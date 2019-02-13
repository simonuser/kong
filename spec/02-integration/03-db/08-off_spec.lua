local Errors  = require "kong.db.errors"
local helpers = require "spec.helpers"


describe("kong.db [#off]", function()
  local db
  lazy_setup(function()
    local _
    _, db = helpers.get_db_utils("off", { })
  end)

  describe("Routes", function()

    describe(":insert()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:insert()
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot create 'routes' entities when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":update()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:update()
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot update 'routes' entities when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":update_by_field()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:update_by_field("name")
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot update 'routes' entities by 'name' when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":upsert()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:upsert()
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot create or update 'routes' entities when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":upsert_by_field()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:upsert_by_field("name")
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot create or update 'routes' entities by 'name' when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":delete()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:delete()
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot remove 'routes' entities when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)

    describe(":delete_by_field()", function()
      it("returns operation unsupported error", function()
        local _, err_t = db.strategies.routes:delete_by_field("name")
        assert.same({
          code     = Errors.codes.OPERATION_UNSUPPORTED,
          name     = Errors.names[Errors.codes.OPERATION_UNSUPPORTED],
          message  = "cannot remove 'routes' entities by 'name' when not using a database",
          strategy = "off",
        }, err_t)
      end)
    end)
  end)
end)
