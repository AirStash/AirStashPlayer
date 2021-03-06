/*
 * This file is part of AirStashPlayer.
 * Copyright (c) 2016 Wearable Inc.
 *
 * AirStashPlayer is based on ijkPlayer:
 * Copyright (c) 2013-2014 Zhang Rui <bbcallen@gmail.com>
 *
 * Portions of ijkPlayer are based on kxmovie:
 * Copyright (c) 2012 Konstantin Boukreev. All rights reserved.
 *
 * AirStashPlayer is free software: you can redistribute it and/or
 * modify it under the terms of version 3 of the GNU Lesser General
 * Public License as published by the Free Software Foundation.
 *
 * AirStashPlayer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with AirStashPlayer.  If not, see
 * <http://www.gnu.org/licenses/>.
 */

#ifndef AIRSTASH_PARSER_AST__AST_REFERENCE_TYPE__HPP
#define AIRSTASH_PARSER_AST__AST_REFERENCE_TYPE__HPP

#include "ast__def.hpp"
#include "ast_type.hpp"

NAMESPACE_AST_BEGIN

class ReferenceType: public Type
{
public:
    virtual bool is_reference_type() override {return true;}
    virtual bool is_void_type() override {return false;}
    virtual bool is_string_type() override;

    virtual bfc::string_ptr get_c_type() override;
    virtual bfc::string_ptr get_c_sign_in_method() override;
    virtual bfc::string_ptr get_c_default_value() override      {return bfc::string::make_ptr("NULL");}

    virtual bfc::string_ptr get_c_call_instance_method_api() override   {return bfc::string::make_ptr("CallObjectMethod");}
    virtual bfc::string_ptr get_c_call_static_method_api() override     {return bfc::string::make_ptr("CallStaticObjectMethod");}
    virtual bfc::string_ptr get_c_get_instance_field_api() override     {return bfc::string::make_ptr("GetObjectField");}
    virtual bfc::string_ptr get_c_get_static_field_api() override       {return bfc::string::make_ptr("GetStaticObjectField");}
    virtual bfc::string_ptr get_c_set_instance_field_api() override     {return bfc::string::make_ptr("SetObjectField");}
    virtual bfc::string_ptr get_c_set_static_field_api() override       {return bfc::string::make_ptr("SetStaticObjectField");}

private:
    Identifier *find_identifier(const bfc::string_ptr& name);
    bfc::string_ptr _get_java_long_name();

public:
    AST_IMPLEMENT(ReferenceType);
protected:
    explicit ReferenceType(const bfc::string_ptr &name): Type(name) {;}
    explicit ReferenceType(Identifier *other): Type(other) {;}
public:
    static pointer_type make_ptr(const bfc::string_ptr &name) {return pointer_type(new ReferenceType(name));}
    static pointer_type make_ptr(Identifier *identifier) {return pointer_type(new ReferenceType(identifier));}
};

NAMESPACE_AST_END

#endif
