//
//  JQMacro.h
//  Pods
//
//  Created by zhangjinquan on 2019/11/27.
//

#ifndef JQMacro_h
#define JQMacro_h

#import <libextobjc/metamacros.h>

#define __JQK_DATA_SECTION_ATTRIBUTE(name) \
    __attribute((used, section("__DATA,"#name)))

#define JQK_TOKEN_JOIN(sep, a, b, c) \
    #a#sep#b#sep#c

#define JQK_DATA_SECTION_MAKE_VALUE(category, key, value) \
    JQK_TOKEN_JOIN(&, category, key, value)

/// category key classname中不得出现'&'字符
/// section、category和classname仅支持字母、数字、'_'
/// 相同的[section, category, value]，只能有1个key，否则编译无法通过
/// 相同的[section, category, key]，只能有1个value，否则运行时校验无法通过
#define JQK_DATA_SECTION_BIND_CLASS(section, category, key, classname) \
    char const * __jqk_sect_data_##section##_##category##_##classname __JQK_DATA_SECTION_ATTRIBUTE(section) = JQK_DATA_SECTION_MAKE_VALUE(category, key, classname);

#define JQK_BIND_CLASS(category, key, classname) \
    JQK_DATA_SECTION_BIND_CLASS(__jqkit, category, key, classname)

#endif /* JQMacro_h */
