${complexType.name}.hpp
/* Autogenerated with kurento-module-creator */

#ifndef __${camelToUnderscore(complexType.name)}_HPP__
#define __${camelToUnderscore(complexType.name)}_HPP__

#include <json/json.h>
#include <jsonrpc/JsonRpcException.hpp>
#include <memory>
<#if complexType.extends??>
#include "${complexType.extends.name}.hpp"
<#elseif complexType.typeFormat == "REGISTER">
#include <RegisterParent.hpp>
</#if>

<#list module.code.implementation["cppNamespace"]?split("::") as namespace>
namespace ${namespace}
{
</#list>
class ${complexType.name};
<#list module.code.implementation["cppNamespace"]?split("::")?reverse as namespace>
} /* ${namespace} */
</#list>

namespace kurento
{
class JsonSerializer;
void Serialize (std::shared_ptr<${module.code.implementation["cppNamespace"]}::${complexType.name}> &object, JsonSerializer &s);
} /* kurento */

<#list module.code.implementation["cppNamespace"]?split("::") as namespace>
namespace ${namespace}
{
</#list>
<#list complexType.getChildren() as dependency>
<#if childs??>

</#if>
<#if module.remoteClasses?seq_contains(dependency.type.type) ||
  module.complexTypes?seq_contains(dependency.type.type) ||
  module.events?seq_contains(dependency.type.type)><#assign childs=true>
class ${dependency.type.name};
</#if>
</#list>

class ${complexType.name}<#if complexType.extends??> : public ${complexType.extends.name}<#elseif complexType.typeFormat == "REGISTER"> : public RegisterParent </#if>
{

public:

<#assign createEmptyConstructor = true>
<#if complexType.typeFormat == "REGISTER">
  ${complexType.name} (<#rt>
    <#assign createEmptyConstructor = false>
    <#lt><#assign first = true><#rt>
      <#lt><#if complexType.extends??><#rt>
        <#lt><#list complexType.parentProperties as property><#rt>
          <#lt><#if !property.optional><#rt>
            <#lt><#if !first>, </#if><#rt>
            <#lt><#assign first = false><#rt>
            <#lt>${getCppObjectType(property.type)}${property.name}<#rt>
          <#lt></#if><#rt>
        <#lt></#list><#rt>
      <#lt></#if><#rt>
    <#lt><#list complexType.properties as property><#rt>
      <#lt><#if !property.optional><#rt>
        <#lt><#if !first>, </#if><#rt>
        <#lt><#assign first = false><#rt>
        <#lt>${getCppObjectType(property.type)}${property.name}<#rt>
      <#lt></#if><#rt>
    <#lt></#list>)<#rt>
    <#lt><#assign first = true><#rt>
    <#lt><#if complexType.extends??> : ${complexType.extends.name} (<#rt>
      <#lt><#list complexType.parentProperties as property><#rt>
        <#lt><#if !property.optional><#rt>
          <#assign createEmptyConstructor = true>
          <#lt><#if !first>, </#if><#rt>
          <#lt><#assign first = false><#rt>
          <#lt>${property.name}<#rt>
        <#lt></#if><#rt>
    <#lt></#list>)</#if> {
    <#list complexType.properties as property><#rt>
      <#lt><#if !property.optional><#rt>
      <#assign createEmptyConstructor = true>
    this->${property.name} = ${property.name};
      </#if><#rt>
    <#lt></#list>
  };

  <#list complexType.properties as property>
  void set${property.name?cap_first} (${getCppObjectType(property.type, true)}${property.name}) {
    this->${property.name} = ${property.name};
    <#if property.optional>
    __isSet${property.name?cap_first} = true;
    </#if>
  };

  ${getCppObjectType(property.type, false)} get${property.name?cap_first} () {
    return ${property.name};
  };

  <#if property.optional>
  bool isSet${property.name?cap_first} () {
    return __isSet${property.name?cap_first};
  };

  </#if>
  </#list>
  virtual void Serialize (JsonSerializer &s);

  static void registerType () {
    std::function<RegisterParent*(void)> func =
        [] () {

      return new ${complexType.name} ();

    };

  <#if module.name == "core" || module.name == "elements" || module.name == "filters">
    RegisterParent::registerType ("kurento.${complexType.name}", func);
  <#else>
    RegisterParent::registerType ("${module.name}.${complexType.name}", func);
  </#if>
  }
  <#if createEmptyConstructor >

protected:

  ${complexType.name}() {};
  </#if>

private:

  <#list complexType.properties as property>
  ${getCppObjectType(property.type, false)} ${property.name};
  <#if property.optional>
  bool __isSet${property.name?cap_first} = false;
  </#if>
  </#list>

<#elseif complexType.typeFormat == "ENUM">
  typedef enum {
  <#list complexType.values as value>
    ${value}<#if value_has_next>,</#if>
  </#list>
  } type;

  ${complexType.name} (const std::string &value) {
    enumValue = getValueFromString (value);
  };

  ${complexType.name} (type value) {
    this->enumValue = value;
  }

  type getValue () {
    return enumValue;
  };

  std::string getString () {

    <#list complexType.values as value>
    if (enumValue ==  ${value}) {
      return "${value}";
    }

    </#list>
    return "";
  }

  void Serialize (JsonSerializer &s);

  <#if createEmptyConstructor >
  ${complexType.name}() {};
  </#if>

private:

  static type getValueFromString (const std::string &value);

  type enumValue;

<#else>
// TODO: Type format ${complexType.typeFormat} not supported
</#if>
  friend void kurento::Serialize (std::shared_ptr<${module.code.implementation["cppNamespace"]}::${complexType.name}> &object, JsonSerializer &s);

};

<#list module.code.implementation["cppNamespace"]?split("::")?reverse as namespace>
} /* ${namespace} */
</#list>

#endif /*  __${camelToUnderscore(complexType.name)}_HPP__ */
