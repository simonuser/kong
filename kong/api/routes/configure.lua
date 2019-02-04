local declarative = require("kong.db.declarative")
local kong = kong


return {
  ["/configure"] = {
    POST = function(self)
      local dc = declarative.init(kong.configuration)

      local yaml = self.params.config
      local entities, err = dc:parse_string(yaml, "config.yml", { yaml = true })
      if err then
        return kong.response.exit(400, { error = err })
      end

      declarative.load_into_cache(entities)

      return kong.response.exit(201, entities)
    end,
  },
}
