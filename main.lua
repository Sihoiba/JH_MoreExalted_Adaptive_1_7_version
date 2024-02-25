register_blueprint "mod_exalted_adaptive_impact_buff"
{
    flags = { EF_NOPICKUP },
    text = {
        name = "ADAPT-IMPACT",
        desc = "+75% impact resistance, -25% slash/pierce/plasma",
    },
    ui_buff = {
        color     = LIGHTBLUE,
        priority  = 100,
    },
    attributes = {
        resist = {
            impact   = 75,
            slash    = -25,
            pierce   = -25,
            plasma   = -25,
        },
    },
    data = {
        adaptive_buff = true,
    },
    callbacks = {
        on_attach = [[
            function ( self, target )
                for c in ecs:children( target ) do
                    if c~= self and c.data and c.data.adaptive_buff then
                        world:mark_destroy( c )
                    end
                end
                world:flush_destroy()
            end
        ]],
    },
}

register_blueprint "mod_exalted_adaptive_slash_buff"
{
    flags = { EF_NOPICKUP },
    text = {
        name = "ADAPT-SLASH",
        desc = "+75% slash resistance, -25% impact/pierce/plasma",
    },
    ui_buff = {
        color     = LIGHTBLUE,
        priority  = 100,
    },
    attributes = {
        resist = {
            impact   = -25,
            slash    = 75,
            pierce   = -25,
            plasma   = -25,
        },
    },
    data = {
        adaptive_buff = true,
    },
    callbacks = {
        on_attach = [[
            function ( self, target )
                for c in ecs:children( target ) do
                    if c~= self and c.data and c.data.adaptive_buff then
                        world:mark_destroy( c )
                    end
                end
                world:flush_destroy()
            end
        ]],
    },
}

register_blueprint "mod_exalted_adaptive_pierce_buff"
{
    flags = { EF_NOPICKUP },
    text = {
        name = "ADAPT-PIERCE",
        desc = "+75% pierce resistance, -25% impact/slash/plasma",
    },
    ui_buff = {
        color     = LIGHTBLUE,
        priority  = 100,
    },
    attributes = {
        resist = {
            impact   = -25,
            slash    = -25,
            pierce   = 75,
            plasma   = -25,
        },
    },
    data = {
        adaptive_buff = true,
    },
    callbacks = {
        on_attach = [[
            function ( self, target )
                for c in ecs:children( target ) do
                    if c~= self and c.data and c.data.adaptive_buff then
                        world:mark_destroy( c )
                    end
                end
                world:flush_destroy()
            end
        ]],
    },
}

register_blueprint "mod_exalted_adaptive_plasma_buff"
{
    flags = { EF_NOPICKUP },
    text = {
        name = "ADAPT-PLASMA",
        desc = "+75% plasma resistance, -25% impact/slash/pierce",
    },
    ui_buff = {
        color     = LIGHTBLUE,
        priority  = 100,
    },
    attributes = {
        resist = {
            impact   = -25,
            slash    = -25,
            pierce   = -25,
            plasma   = 75,
        },
    },
    data = {
        adaptive_buff = true,
    },
    callbacks = {
        on_attach = [[
            function ( self, target )
                for c in ecs:children( target ) do
                    if c~= self and c.data and c.data.adaptive_buff then
                        world:mark_destroy( c )
                    end
                end
                world:flush_destroy()
            end
        ]],
    },
}

register_blueprint "exalted_kw_adaptive"
{
    flags = { EF_NOPICKUP },
    text = {
        status = "ADAPTIVE",
        sdesc  = "gains damage resistance to last weapon damage type hit by. Plasma resist does not show on stats screen.",
    },
    callbacks = {
        on_activate = [=[
            function( self, entity )
                entity:attach( "exalted_kw_adaptive" )
            end
        ]=],
        on_receive_damage = [[
            function ( self, entity, source, weapon, amount )
                if weapon and weapon.weapon then
                    nova.log("adapting")
                    if weapon.weapon.damage_type == world:hash("impact") then
                        entity:attach("mod_exalted_adaptive_impact_buff")
                    elseif weapon.weapon.damage_type == world:hash("pierce") then
                        entity:attach("mod_exalted_adaptive_pierce_buff")
                    elseif weapon.weapon.damage_type == world:hash("plasma") then
                        entity:attach("mod_exalted_adaptive_plasma_buff")
                    elseif weapon.weapon.damage_type == world:hash("slash") then
                        entity:attach("mod_exalted_adaptive_slash_buff")
                    end
                else
                    nova.log("non weapon damage adaptation cleared")
                    for c in ecs:children( entity ) do
                        if c.data and c.data.adaptive_buff then
                            world:mark_destroy( c )
                        end
                    end
                    world:flush_destroy()
                end
            end
        ]],
    }
}