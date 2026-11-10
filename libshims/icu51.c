/*
 * Copyright (C) 2026 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 * ICU 51 compatibility shim for the prebuilt libqc-opt.so.
 *
 * libqc-opt.so was built against ICU 51 and imports versioned symbols
 * (utext_openUChars_51 etc.). CM 12.1 ships ICU 53, so dlopen() fails with
 * 'cannot locate symbol "utext_openUChars_51"' and the QCOM power HAL loses
 * perf-lock support. These wrappers export the _51 names and call the
 * platform ICU; the ICU headers rename the unsuffixed calls below to the
 * current version's symbols (e.g. utext_openUChars_53).
 */

#include <unicode/utypes.h>
#include <unicode/uchar.h>
#include <unicode/utext.h>

#define SHIM_EXPORT __attribute__((visibility("default")))

SHIM_EXPORT UText *utext_openUChars_51(UText *ut, const UChar *s,
                                       int64_t length, UErrorCode *status)
{
    return utext_openUChars(ut, s, length, status);
}

SHIM_EXPORT UText *utext_close_51(UText *ut)
{
    return utext_close(ut);
}

SHIM_EXPORT const char *u_errorName_51(UErrorCode code)
{
    return u_errorName(code);
}

SHIM_EXPORT int32_t u_digit_51(UChar32 ch, int8_t radix)
{
    return u_digit(ch, radix);
}
