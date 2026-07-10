Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641FC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A2210F793;
	Fri, 10 Jul 2026 06:46:09 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBA210F793
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:46:07 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-eVgDbXX0MQm8tIyJKyXxIQ-1; Fri,
 10 Jul 2026 02:39:58 -0400
X-MC-Unique: eVgDbXX0MQm8tIyJKyXxIQ-1
X-Mimecast-MFC-AGG-ID: eVgDbXX0MQm8tIyJKyXxIQ_1783665597
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B07751956053
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:57 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E249830001A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:55 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] amd/dc: drop spl copies of custom float and fixed pt
 libraries
Date: Fri, 10 Jul 2026 16:37:43 +1000
Message-ID: <20260710063946.2262582-3-airlied@gmail.com>
In-Reply-To: <20260710063946.2262582-1-airlied@gmail.com>
References: <20260710063946.2262582-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W8ZLviteBCvSDvABJPyvkdl89V8TAH4ff4OJ7ETy46M_1783665597
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dave Airlie <airlied@redhat.com>

There are two copies of these libraries, like the upstream
should just not do this, but in the kernel we definitely don't want
this.

I haven't taken the next step of ripping out the spl_ changes, but
maybe if I get in a bad mood.

This drops 5K from the amdgpu binary:
   text=09   data=09    bss=09    dec=09    hex=09filename
12284141=09 705053=09 292544=0913281738=09 caa9ca=09../../drm-next-build/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu.ko

   text=09   data=09    bss=09    dec=09    hex=09filename
12279057=09 704445=09 292544=0913276046=09 ca938e=09../../drm-next-build/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu.ko

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/Makefile  |   2 +-
 .../amd/display/dc/sspl/spl_custom_float.c    | 152 -----
 .../amd/display/dc/sspl/spl_custom_float.h    |  15 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  | 495 ----------------
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  | 544 +-----------------
 5 files changed, 31 insertions(+), 1177 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/Makefile b/drivers/gpu/drm=
/amd/display/dc/sspl/Makefile
index 5e3e4aa13820..17f3e2c801cf 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/sspl/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'spl' sub-component of DAL.
 # It provides the scaling library interface.
=20
-SPL =3D dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_ish=
arp_filters.o dc_spl_filters.o spl_fixpt31_32.o spl_custom_float.o
+SPL =3D dc_spl.o dc_spl_scl_filters.o dc_spl_scl_easf_filters.o dc_spl_ish=
arp_filters.o dc_spl_filters.o
=20
 AMD_DAL_SPL =3D $(addprefix $(AMDDALPATH)/dc/sspl/,$(SPL))
=20
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c b/drive=
rs/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
deleted file mode 100644
index 0700b3dbbda7..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
+++ /dev/null
@@ -1,152 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#include "spl_debug.h"
-#include "spl_custom_float.h"
-
-static bool spl_build_custom_float(struct spl_fixed31_32 value,
-=09=09=09       const struct spl_custom_float_format *format,
-=09=09=09       bool *negative,
-=09=09=09       uint32_t *mantissa,
-=09=09=09       uint32_t *exponenta)
-{
-=09uint32_t exp_offset =3D (1 << (format->exponenta_bits - 1)) - 1;
-
-=09const struct spl_fixed31_32 mantissa_constant_plus_max_fraction =3D
-=09=09SPL_NAMESPACE(spl_fixpt_from_fraction((1LL << (format->mantissa_bits=
 + 1)) - 1,
-=09=09=09=09       1LL << format->mantissa_bits));
-
-=09struct spl_fixed31_32 mantiss;
-
-=09if (spl_fixpt_eq(value, spl_fixpt_zero)) {
-=09=09*negative =3D false;
-=09=09*mantissa =3D 0;
-=09=09*exponenta =3D 0;
-=09=09return true;
-=09}
-
-=09if (spl_fixpt_lt(value, spl_fixpt_zero)) {
-=09=09*negative =3D format->sign;
-=09=09value =3D spl_fixpt_neg(value);
-=09} else {
-=09=09*negative =3D false;
-=09}
-
-=09if (spl_fixpt_lt(value, spl_fixpt_one)) {
-=09=09uint32_t i =3D 1;
-
-=09=09do {
-=09=09=09value =3D spl_fixpt_shl(value, 1);
-=09=09=09++i;
-=09=09} while (spl_fixpt_lt(value, spl_fixpt_one));
-
-=09=09--i;
-
-=09=09if (exp_offset <=3D i) {
-=09=09=09*mantissa =3D 0;
-=09=09=09*exponenta =3D 0;
-=09=09=09return true;
-=09=09}
-
-=09=09*exponenta =3D exp_offset - i;
-=09} else if (spl_fixpt_le(mantissa_constant_plus_max_fraction, value)) {
-=09=09uint32_t i =3D 1;
-
-=09=09do {
-=09=09=09value =3D spl_fixpt_shr(value, 1);
-=09=09=09++i;
-=09=09} while (spl_fixpt_lt(mantissa_constant_plus_max_fraction, value));
-
-=09=09*exponenta =3D exp_offset + i - 1;
-=09} else {
-=09=09*exponenta =3D exp_offset;
-=09}
-
-=09mantiss =3D spl_fixpt_sub(value, spl_fixpt_one);
-
-=09if (spl_fixpt_lt(mantiss, spl_fixpt_zero) ||
-=09    spl_fixpt_lt(spl_fixpt_one, mantiss))
-=09=09mantiss =3D spl_fixpt_zero;
-=09else
-=09=09mantiss =3D spl_fixpt_shl(mantiss, format->mantissa_bits);
-
-=09*mantissa =3D spl_fixpt_floor(mantiss);
-
-=09return true;
-}
-
-static bool spl_setup_custom_float(const struct spl_custom_float_format *f=
ormat,
-=09=09=09       bool negative,
-=09=09=09       uint32_t mantissa,
-=09=09=09       uint32_t exponenta,
-=09=09=09       uint32_t *result)
-{
-=09uint32_t i =3D 0;
-=09uint32_t j =3D 0;
-=09uint32_t value =3D 0;
-
-=09/* verification code:
-=09 * once calculation is ok we can remove it
-=09 */
-
-=09const uint32_t mantissa_mask =3D
-=09=09(1 << (format->mantissa_bits + 1)) - 1;
-
-=09const uint32_t exponenta_mask =3D
-=09=09(1 << (format->exponenta_bits + 1)) - 1;
-
-=09if (mantissa & ~mantissa_mask) {
-=09=09SPL_BREAK_TO_DEBUGGER();
-=09=09mantissa =3D mantissa_mask;
-=09}
-
-=09if (exponenta & ~exponenta_mask) {
-=09=09SPL_BREAK_TO_DEBUGGER();
-=09=09exponenta =3D exponenta_mask;
-=09}
-
-=09/* end of verification code */
-
-=09while (i < format->mantissa_bits) {
-=09=09uint32_t mask =3D 1 << i;
-
-=09=09if (mantissa & mask)
-=09=09=09value |=3D mask;
-
-=09=09++i;
-=09}
-
-=09while (j < format->exponenta_bits) {
-=09=09uint32_t mask =3D 1 << j;
-
-=09=09if (exponenta & mask)
-=09=09=09value |=3D mask << i;
-
-=09=09++j;
-=09}
-
-=09if (negative && format->sign)
-=09=09value |=3D 1 << (i + j);
-
-=09*result =3D value;
-
-=09return true;
-}
-
-bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
-=09struct spl_fixed31_32 value,
-=09const struct spl_custom_float_format *format,
-=09uint32_t *result))
-{
-=09uint32_t mantissa;
-=09uint32_t exponenta;
-=09bool negative;
-
-=09return spl_build_custom_float(value, format, &negative, &mantissa, &exp=
onenta) &&
-=09=09=09=09  spl_setup_custom_float(format,
-=09=09=09=09=09=09     negative,
-=09=09=09=09=09=09     mantissa,
-=09=09=09=09=09=09     exponenta,
-=09=09=09=09=09=09     result);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h b/drive=
rs/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
index 60620537ae3e..7aaa2c5db1a5 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
@@ -5,18 +5,9 @@
 #ifndef SPL_CUSTOM_FLOAT_H_
 #define SPL_CUSTOM_FLOAT_H_
=20
-#include "spl_os_types.h"
-#include "spl_fixpt31_32.h"
+#include "dc/inc/custom_float.h"
=20
-struct spl_custom_float_format {
-=09uint32_t mantissa_bits;
-=09uint32_t exponenta_bits;
-=09bool sign;
-};
-
-bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
-=09struct spl_fixed31_32 value,
-=09const struct spl_custom_float_format *format,
-=09uint32_t *result));
+#define spl_custom_float_format custom_float_format
+#define spl_convert_to_custom_float_format convert_to_custom_float_format
=20
 #endif //SPL_CUSTOM_FLOAT_H_
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers=
/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
deleted file mode 100644
index ff0bdc3c33c8..000000000000
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ /dev/null
@@ -1,495 +0,0 @@
-// SPDX-License-Identifier: MIT
-//
-// Copyright 2024 Advanced Micro Devices, Inc.
-
-#include "spl_fixpt31_32.h"
-
-static const struct spl_fixed31_32 spl_fixpt_two_pi =3D { 26986075409LL };
-static const struct spl_fixed31_32 spl_fixpt_ln2 =3D { 2977044471LL };
-static const struct spl_fixed31_32 spl_fixpt_ln2_div_2 =3D { 1488522236LL =
};
-
-static inline unsigned long long abs_i64(
-=09long long arg)
-{
-=09if (arg > 0)
-=09=09return (unsigned long long)arg;
-=09else
-=09=09return (unsigned long long)(-arg);
-}
-
-/*
- * @brief
- * result =3D dividend / divisor
- * *remainder =3D dividend % divisor
- */
-static inline unsigned long long spl_complete_integer_division_u64(
-=09unsigned long long dividend,
-=09unsigned long long divisor,
-=09unsigned long long *remainder)
-{
-=09unsigned long long result;
-
-=09result =3D spl_div64_u64_rem(dividend, divisor, remainder);
-
-=09return result;
-}
-
-
-#define FRACTIONAL_PART_MASK \
-=09((1ULL << FIXED31_32_BITS_PER_FRACTIONAL_PART) - 1)
-
-#define GET_INTEGER_PART(x) \
-=09((x) >> FIXED31_32_BITS_PER_FRACTIONAL_PART)
-
-#define GET_FRACTIONAL_PART(x) \
-=09(FRACTIONAL_PART_MASK & (x))
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
-=09long long numerator, long long denominator))
-{
-=09struct spl_fixed31_32 res;
-
-=09bool arg1_negative =3D numerator < 0;
-=09bool arg2_negative =3D denominator < 0;
-
-=09unsigned long long arg1_value =3D arg1_negative ? -numerator : numerato=
r;
-=09unsigned long long arg2_value =3D arg2_negative ? -denominator : denomi=
nator;
-
-=09unsigned long long remainder;
-
-=09/* determine integer part */
-
-=09unsigned long long res_value =3D spl_complete_integer_division_u64(
-=09=09arg1_value, arg2_value, &remainder);
-
-=09SPL_ASSERT(res_value <=3D (unsigned long long)LONG_MAX);
-
-=09/* determine fractional part */
-=09{
-=09=09unsigned int i =3D FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-=09=09do {
-=09=09=09remainder <<=3D 1;
-
-=09=09=09res_value <<=3D 1;
-
-=09=09=09if (remainder >=3D arg2_value) {
-=09=09=09=09res_value |=3D 1;
-=09=09=09=09remainder -=3D arg2_value;
-=09=09=09}
-=09=09} while (--i !=3D 0);
-=09}
-
-=09/* round up LSB */
-=09{
-=09=09unsigned long long summand =3D (remainder << 1) >=3D arg2_value;
-
-=09=09SPL_ASSERT(res_value <=3D (unsigned long long)LLONG_MAX - summand);
-
-=09=09res_value +=3D summand;
-=09}
-
-=09res.value =3D (long long)res_value;
-
-=09if (arg1_negative ^ arg2_negative)
-=09=09res.value =3D -res.value;
-
-=09return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
-=09struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2))
-{
-=09struct spl_fixed31_32 res;
-
-=09bool arg1_negative =3D arg1.value < 0;
-=09bool arg2_negative =3D arg2.value < 0;
-
-=09unsigned long long arg1_value =3D arg1_negative ? -arg1.value : arg1.va=
lue;
-=09unsigned long long arg2_value =3D arg2_negative ? -arg2.value : arg2.va=
lue;
-
-=09unsigned long long arg1_int =3D GET_INTEGER_PART(arg1_value);
-=09unsigned long long arg2_int =3D GET_INTEGER_PART(arg2_value);
-
-=09unsigned long long arg1_fra =3D GET_FRACTIONAL_PART(arg1_value);
-=09unsigned long long arg2_fra =3D GET_FRACTIONAL_PART(arg2_value);
-
-=09unsigned long long tmp;
-
-=09res.value =3D arg1_int * arg2_int;
-
-=09SPL_ASSERT(res.value <=3D (long long)LONG_MAX);
-
-=09res.value <<=3D FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-=09tmp =3D arg1_int * arg2_fra;
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09tmp =3D arg2_int * arg1_fra;
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09tmp =3D arg1_fra * arg2_fra;
-
-=09tmp =3D (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
-=09=09(tmp >=3D (unsigned long long)spl_fixpt_half.value);
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09if (arg1_negative ^ arg2_negative)
-=09=09res.value =3D -res.value;
-
-=09return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 ar=
g))
-{
-=09struct spl_fixed31_32 res;
-
-=09unsigned long long arg_value =3D abs_i64(arg.value);
-
-=09unsigned long long arg_int =3D GET_INTEGER_PART(arg_value);
-
-=09unsigned long long arg_fra =3D GET_FRACTIONAL_PART(arg_value);
-
-=09unsigned long long tmp;
-
-=09res.value =3D arg_int * arg_int;
-
-=09SPL_ASSERT(res.value <=3D (long long)LONG_MAX);
-
-=09res.value <<=3D FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-=09tmp =3D arg_int * arg_fra;
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09tmp =3D arg_fra * arg_fra;
-
-=09tmp =3D (tmp >> FIXED31_32_BITS_PER_FRACTIONAL_PART) +
-=09=09(tmp >=3D (unsigned long long)spl_fixpt_half.value);
-
-=09SPL_ASSERT(tmp <=3D (unsigned long long)(LLONG_MAX - res.value));
-
-=09res.value +=3D tmp;
-
-=09return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 =
arg))
-{
-=09/*
-=09 * @note
-=09 * Good idea to use Newton's method
-=09 */
-
-=09return SPL_NAMESPACE(spl_fixpt_from_fraction(
-=09=09spl_fixpt_one.value,
-=09=09arg.value));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 a=
rg))
-{
-=09struct spl_fixed31_32 square;
-
-=09struct spl_fixed31_32 res =3D spl_fixpt_one;
-
-=09int n =3D 27;
-
-=09struct spl_fixed31_32 arg_norm =3D arg;
-
-=09if (spl_fixpt_le(
-=09=09spl_fixpt_two_pi,
-=09=09spl_fixpt_abs(arg))) {
-=09=09arg_norm =3D spl_fixpt_sub(
-=09=09=09arg_norm,
-=09=09=09spl_fixpt_mul_int(
-=09=09=09=09spl_fixpt_two_pi,
-=09=09=09=09(int)spl_div64_s64(
-=09=09=09=09=09arg_norm.value,
-=09=09=09=09=09spl_fixpt_two_pi.value)));
-=09}
-
-=09square =3D SPL_NAMESPACE(spl_fixpt_sqr(arg_norm));
-
-=09do {
-=09=09res =3D spl_fixpt_sub(
-=09=09=09spl_fixpt_one,
-=09=09=09spl_fixpt_div_int(
-=09=09=09=09SPL_NAMESPACE(spl_fixpt_mul(
-=09=09=09=09=09square,
-=09=09=09=09=09res)),
-=09=09=09=09n * (n - 1)));
-
-=09=09n -=3D 2;
-=09} while (n > 2);
-
-=09if (arg.value !=3D arg_norm.value)
-=09=09res =3D spl_fixpt_div(
-=09=09=09SPL_NAMESPACE(spl_fixpt_mul(res, arg_norm)),
-=09=09=09arg);
-
-=09return res;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 ar=
g))
-{
-=09return SPL_NAMESPACE(spl_fixpt_mul(
-=09=09arg,
-=09=09SPL_NAMESPACE(spl_fixpt_sinc(arg))));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 ar=
g))
-{
-=09/* TODO implement argument normalization */
-
-=09const struct spl_fixed31_32 square =3D SPL_NAMESPACE(spl_fixpt_sqr(arg)=
);
-
-=09struct spl_fixed31_32 res =3D spl_fixpt_one;
-
-=09int n =3D 26;
-
-=09do {
-=09=09res =3D spl_fixpt_sub(
-=09=09=09spl_fixpt_one,
-=09=09=09spl_fixpt_div_int(
-=09=09=09=09SPL_NAMESPACE(spl_fixpt_mul(
-=09=09=09=09=09square,
-=09=09=09=09=09res)),
-=09=09=09=09n * (n - 1)));
-
-=09=09n -=3D 2;
-=09} while (n !=3D 0);
-
-=09return res;
-}
-
-/*
- * @brief
- * result =3D exp(arg),
- * where abs(arg) < 1
- *
- * Calculated as Taylor series.
- */
-static struct spl_fixed31_32 spl_fixed31_32_exp_from_taylor_series(struct =
spl_fixed31_32 arg)
-{
-=09unsigned int n =3D 9;
-
-=09struct spl_fixed31_32 res =3D SPL_NAMESPACE(spl_fixpt_from_fraction(
-=09=09n + 2,
-=09=09n + 1));
-=09/* TODO find correct res */
-
-=09SPL_ASSERT(spl_fixpt_lt(arg, spl_fixpt_one));
-
-=09do
-=09=09res =3D spl_fixpt_add(
-=09=09=09spl_fixpt_one,
-=09=09=09spl_fixpt_div_int(
-=09=09=09=09SPL_NAMESPACE(spl_fixpt_mul(
-=09=09=09=09=09arg,
-=09=09=09=09=09res)),
-=09=09=09=09n));
-=09while (--n !=3D 1);
-
-=09return spl_fixpt_add(
-=09=09spl_fixpt_one,
-=09=09SPL_NAMESPACE(spl_fixpt_mul(
-=09=09=09arg,
-=09=09=09res)));
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 ar=
g))
-{
-=09/*
-=09 * @brief
-=09 * Main equation is:
-=09 * exp(x) =3D exp(r + m * ln(2)) =3D (1 << m) * exp(r),
-=09 * where m =3D round(x / ln(2)), r =3D x - m * ln(2)
-=09 */
-
-=09if (spl_fixpt_le(
-=09=09spl_fixpt_ln2_div_2,
-=09=09spl_fixpt_abs(arg))) {
-=09=09int m =3D spl_fixpt_round(
-=09=09=09spl_fixpt_div(
-=09=09=09=09arg,
-=09=09=09=09spl_fixpt_ln2));
-
-=09=09struct spl_fixed31_32 r =3D spl_fixpt_sub(
-=09=09=09arg,
-=09=09=09spl_fixpt_mul_int(
-=09=09=09=09spl_fixpt_ln2,
-=09=09=09=09m));
-
-=09=09SPL_ASSERT(m !=3D 0);
-
-=09=09SPL_ASSERT(spl_fixpt_lt(
-=09=09=09spl_fixpt_abs(r),
-=09=09=09spl_fixpt_one));
-
-=09=09if (m > 0)
-=09=09=09return spl_fixpt_shl(
-=09=09=09=09spl_fixed31_32_exp_from_taylor_series(r),
-=09=09=09=09(unsigned int)m);
-=09=09else
-=09=09=09return spl_fixpt_div_int(
-=09=09=09=09spl_fixed31_32_exp_from_taylor_series(r),
-=09=09=09=091LL << -m);
-=09} else if (arg.value !=3D 0)
-=09=09return spl_fixed31_32_exp_from_taylor_series(arg);
-=09else
-=09=09return spl_fixpt_one;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 ar=
g))
-{
-=09struct spl_fixed31_32 res =3D spl_fixpt_neg(spl_fixpt_one);
-=09/* TODO improve 1st estimation */
-
-=09struct spl_fixed31_32 error;
-
-=09SPL_ASSERT(arg.value > 0);
-=09/* TODO if arg is negative, return NaN */
-=09/* TODO if arg is zero, return -INF */
-
-=09do {
-=09=09struct spl_fixed31_32 res1 =3D spl_fixpt_add(
-=09=09=09spl_fixpt_sub(
-=09=09=09=09res,
-=09=09=09=09spl_fixpt_one),
-=09=09=09spl_fixpt_div(
-=09=09=09=09arg,
-=09=09=09=09SPL_NAMESPACE(spl_fixpt_exp(res))));
-
-=09=09error =3D spl_fixpt_sub(
-=09=09=09res,
-=09=09=09res1);
-
-=09=09res =3D res1;
-=09=09/* TODO determine max_allowed_error based on quality of exp() */
-=09} while (abs_i64(error.value) > 100ULL);
-
-=09return res;
-}
-
-
-/* this function is a generic helper to translate fixed point value to
- * specified integer format that will consist of integer_bits integer part=
 and
- * fractional_bits fractional part. For example it is used in
- * spl_fixpt_u2d19 to receive 2 bits integer part and 19 bits fractional
- * part in 32 bits. It is used in hw programming (scaler)
- */
-
-static inline unsigned int spl_ux_dy(
-=09long long value,
-=09unsigned int integer_bits,
-=09unsigned int fractional_bits)
-{
-=09/* 1. create mask of integer part */
-=09unsigned int result =3D (1 << integer_bits) - 1;
-=09/* 2. mask out fractional part */
-=09unsigned int fractional_part =3D FRACTIONAL_PART_MASK & value;
-=09/* 3. shrink fixed point integer part to be of integer_bits width*/
-=09result &=3D GET_INTEGER_PART(value);
-=09/* 4. make space for fractional part to be filled in after integer */
-=09result <<=3D fractional_bits;
-=09/* 5. shrink fixed point fractional part to of fractional_bits width*/
-=09fractional_part >>=3D FIXED31_32_BITS_PER_FRACTIONAL_PART - fractional_=
bits;
-=09/* 6. merge the result */
-=09return result | fractional_part;
-}
-
-static inline unsigned int spl_clamp_ux_dy(
-=09long long value,
-=09unsigned int integer_bits,
-=09unsigned int fractional_bits,
-=09unsigned int min_clamp)
-{
-=09unsigned int truncated_val =3D spl_ux_dy(value, integer_bits, fractiona=
l_bits);
-
-=09if (value >=3D (1LL << (integer_bits + FIXED31_32_BITS_PER_FRACTIONAL_P=
ART)))
-=09=09return (1 << (integer_bits + fractional_bits)) - 1;
-=09else if (truncated_val > min_clamp)
-=09=09return truncated_val;
-=09else
-=09=09return min_clamp;
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg))
-{
-=09return spl_ux_dy(arg.value, 4, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg))
-{
-=09return spl_ux_dy(arg.value, 3, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg))
-{
-=09return spl_ux_dy(arg.value, 2, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg))
-{
-=09return spl_ux_dy(arg.value, 0, 19);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg=
))
-{
-=09return spl_clamp_ux_dy(arg.value, 0, 14, 1);
-}
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg=
))
-{
-=09return spl_clamp_ux_dy(arg.value, 0, 10, 1);
-}
-
-int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg))
-{
-=09if (arg.value < 0)
-=09=09return -(int)spl_ux_dy(spl_fixpt_abs(arg).value, 4, 19);
-=09else
-=09=09return spl_ux_dy(arg.value, 4, 19);
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int valu=
e,
-=09unsigned int integer_bits,
-=09unsigned int fractional_bits))
-{
-=09struct spl_fixed31_32 fixpt_value =3D spl_fixpt_zero;
-=09struct spl_fixed31_32 fixpt_int_value =3D spl_fixpt_zero;
-=09long long frac_mask =3D ((long long)1 << (long long)integer_bits) - 1;
-
-=09fixpt_value.value =3D (long long)value << (FIXED31_32_BITS_PER_FRACTION=
AL_PART - fractional_bits);
-=09frac_mask =3D frac_mask << fractional_bits;
-=09fixpt_int_value.value =3D value & frac_mask;
-=09fixpt_int_value.value <<=3D (FIXED31_32_BITS_PER_FRACTIONAL_PART - frac=
tional_bits);
-=09fixpt_value.value |=3D fixpt_int_value.value;
-=09return fixpt_value;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int=
_value,
-=09unsigned int frac_value,
-=09unsigned int integer_bits,
-=09unsigned int fractional_bits))
-{
-=09struct spl_fixed31_32 fixpt_value =3D spl_fixpt_from_int(int_value);
-
-=09fixpt_value.value |=3D (long long)frac_value << (FIXED31_32_BITS_PER_FR=
ACTIONAL_PART - fractional_bits);
-=09return fixpt_value;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers=
/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
index b0e639d6e97d..b5b15d6070ab 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
@@ -5,522 +5,32 @@
 #ifndef __SPL_FIXED31_32_H__
 #define __SPL_FIXED31_32_H__
=20
-#include "spl_debug.h"
-#include "spl_os_types.h"   // swap
-
-#ifndef LLONG_MAX
-#define LLONG_MAX 9223372036854775807ll
-#endif
-#ifndef LLONG_MIN
-#define LLONG_MIN (-LLONG_MAX - 1ll)
-#endif
-
-#define FIXED31_32_BITS_PER_FRACTIONAL_PART 32
-#ifndef LLONG_MIN
-#define LLONG_MIN (1LL<<63)
-#endif
-#ifndef LLONG_MAX
-#define LLONG_MAX (-1LL>>1)
-#endif
-
-/*
- * @brief
- * Arithmetic operations on real numbers
- * represented as fixed-point numbers.
- * There are: 1 bit for sign,
- * 31 bit for integer part,
- * 32 bits for fractional part.
- *
- * @note
- * Currently, overflows and underflows are asserted;
- * no special result returned.
- */
-
-struct spl_fixed31_32 {
-=09long long value;
-};
-
-
-/*
- * @brief
- * Useful constants
- */
-
-static const struct spl_fixed31_32 spl_fixpt_zero =3D { 0 };
-static const struct spl_fixed31_32 spl_fixpt_epsilon =3D { 1LL };
-static const struct spl_fixed31_32 spl_fixpt_half =3D { 0x80000000LL };
-static const struct spl_fixed31_32 spl_fixpt_one =3D { 0x100000000LL };
-
-/*
- * @brief
- * Initialization routines
- */
-
-/*
- * @brief
- * result =3D numerator / denominator
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
-=09long long numerator, long long denominator));
-
-/*
- * @brief
- * result =3D arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_from_int(int arg)
-{
-=09struct spl_fixed31_32 res;
-
-=09res.value =3D (long long) arg << FIXED31_32_BITS_PER_FRACTIONAL_PART;
-
-=09return res;
-}
-
-/*
- * @brief
- * Unary operators
- */
-
-/*
- * @brief
- * result =3D -arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_neg(struct spl_fixed31_32 ar=
g)
-{
-=09struct spl_fixed31_32 res;
-
-=09res.value =3D -arg.value;
-
-=09return res;
-}
-
-/*
- * @brief
- * result =3D abs(arg) :=3D (arg >=3D 0) ? arg : -arg
- */
-static inline struct spl_fixed31_32 spl_fixpt_abs(struct spl_fixed31_32 ar=
g)
-{
-=09if (arg.value < 0)
-=09=09return spl_fixpt_neg(arg);
-=09else
-=09=09return arg;
-}
-
-/*
- * @brief
- * Binary relational operators
- */
-
-/*
- * @brief
- * result =3D arg1 < arg2
- */
-static inline bool spl_fixpt_lt(struct spl_fixed31_32 arg1, struct spl_fix=
ed31_32 arg2)
-{
-=09return arg1.value < arg2.value;
-}
-
-/*
- * @brief
- * result =3D arg1 <=3D arg2
- */
-static inline bool spl_fixpt_le(struct spl_fixed31_32 arg1, struct spl_fix=
ed31_32 arg2)
-{
-=09return arg1.value <=3D arg2.value;
-}
-
-/*
- * @brief
- * result =3D arg1 =3D=3D arg2
- */
-static inline bool spl_fixpt_eq(struct spl_fixed31_32 arg1, struct spl_fix=
ed31_32 arg2)
-{
-=09return arg1.value =3D=3D arg2.value;
-}
-
-/*
- * @brief
- * result =3D min(arg1, arg2) :=3D (arg1 <=3D arg2) ? arg1 : arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_min(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09if (arg1.value <=3D arg2.value)
-=09=09return arg1;
-=09else
-=09=09return arg2;
-}
-
-/*
- * @brief
- * result =3D max(arg1, arg2) :=3D (arg1 <=3D arg2) ? arg2 : arg1
- */
-static inline struct spl_fixed31_32 spl_fixpt_max(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09if (arg1.value <=3D arg2.value)
-=09=09return arg2;
-=09else
-=09=09return arg1;
-}
-
-/*
- * @brief
- *          | min_value, when arg <=3D min_value
- * result =3D | arg, when min_value < arg < max_value
- *          | max_value, when arg >=3D max_value
- */
-static inline struct spl_fixed31_32 spl_fixpt_clamp(
-=09struct spl_fixed31_32 arg,
-=09struct spl_fixed31_32 min_value,
-=09struct spl_fixed31_32 max_value)
-{
-=09if (spl_fixpt_le(arg, min_value))
-=09=09return min_value;
-=09else if (spl_fixpt_le(max_value, arg))
-=09=09return max_value;
-=09else
-=09=09return arg;
-}
-
-/*
- * @brief
- * Binary shift operators
- */
-
-/*
- * @brief
- * result =3D arg << shift
- */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 ar=
g, unsigned int shift)
-{
-=09SPL_ASSERT(((arg.value >=3D 0) && (arg.value <=3D LLONG_MAX >> shift)) =
||
-=09=09((arg.value < 0) && (arg.value >=3D ~(LLONG_MAX >> shift))));
-
-=09arg.value =3D arg.value << shift;
-
-=09return arg;
-}
-
-/*
- * @brief
- * result =3D arg >> shift
- */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 ar=
g, unsigned int shift)
-{
-=09bool negative =3D arg.value < 0;
-
-=09if (negative)
-=09=09arg.value =3D -arg.value;
-=09arg.value =3D arg.value >> shift;
-=09if (negative)
-=09=09arg.value =3D -arg.value;
-=09return arg;
-}
-
-/*
- * @brief
- * Binary additive operators
- */
-
-/*
- * @brief
- * result =3D arg1 + arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_add(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09struct spl_fixed31_32 res;
-
-=09SPL_ASSERT(((arg1.value >=3D 0) && (LLONG_MAX - arg1.value >=3D arg2.va=
lue)) ||
-=09=09((arg1.value < 0) && (LLONG_MIN - arg1.value <=3D arg2.value)));
-
-=09res.value =3D arg1.value + arg2.value;
-
-=09return res;
-}
-
-/*
- * @brief
- * result =3D arg1 + arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_add_int(struct spl_fixed31_3=
2 arg1, int arg2)
-{
-=09return spl_fixpt_add(arg1, spl_fixpt_from_int(arg2));
-}
-
-/*
- * @brief
- * result =3D arg1 - arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_sub(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09struct spl_fixed31_32 res;
-
-=09SPL_ASSERT(((arg2.value >=3D 0) && (LLONG_MIN + arg2.value <=3D arg1.va=
lue)) ||
-=09=09((arg2.value < 0) && (LLONG_MAX + arg2.value >=3D arg1.value)));
-
-=09res.value =3D arg1.value - arg2.value;
-
-=09return res;
-}
-
-/*
- * @brief
- * result =3D arg1 - arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_sub_int(struct spl_fixed31_3=
2 arg1, int arg2)
-{
-=09return spl_fixpt_sub(arg1, spl_fixpt_from_int(arg2));
-}
-
-
-/*
- * @brief
- * Binary multiplicative operators
- */
-
-/*
- * @brief
- * result =3D arg1 * arg2
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
-=09struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2));
-
-
-/*
- * @brief
- * result =3D arg1 * arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_mul_int(struct spl_fixed31_3=
2 arg1, int arg2)
-{
-=09return SPL_NAMESPACE(spl_fixpt_mul(arg1, spl_fixpt_from_int(arg2)));
-}
-
-/*
- * @brief
- * result =3D square(arg) :=3D arg * arg
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 ar=
g));
-
-/*
- * @brief
- * result =3D arg1 / arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_div_int(struct spl_fixed31_3=
2 arg1, long long arg2)
-{
-=09return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value,
-=09=09spl_fixpt_from_int((int)arg2).value));
-}
-
-/*
- * @brief
- * result =3D arg1 / arg2
- */
-static inline struct spl_fixed31_32 spl_fixpt_div(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value, arg2.value));
-}
-
-/*
- * @brief
- * Reciprocal function
- */
-
-/*
- * @brief
- * result =3D reciprocal(arg) :=3D 1 / arg
- *
- * @note
- * No special actions taken in case argument is zero.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 =
arg));
-
-/*
- * @brief
- * Trigonometric functions
- */
-
-/*
- * @brief
- * result =3D sinc(arg) :=3D sin(arg) / arg
- *
- * @note
- * Argument specified in radians,
- * internally it's normalized to [-2pi...2pi] range.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 a=
rg));
-
-/*
- * @brief
- * result =3D sin(arg)
- *
- * @note
- * Argument specified in radians,
- * internally it's normalized to [-2pi...2pi] range.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 ar=
g));
-
-/*
- * @brief
- * result =3D cos(arg)
- *
- * @note
- * Argument specified in radians
- * and should be in [-2pi...2pi] range -
- * passing arguments outside that range
- * will cause incorrect result!
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 ar=
g));
-
-/*
- * @brief
- * Transcendent functions
- */
-
-/*
- * @brief
- * result =3D exp(arg)
- *
- * @note
- * Currently, function is verified for abs(arg) <=3D 1.
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 ar=
g));
-
-/*
- * @brief
- * result =3D log(arg)
- *
- * @note
- * Currently, abs(arg) should be less than 1.
- * No normalization is done.
- * Currently, no special actions taken
- * in case of invalid argument(s). Take care!
- */
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 ar=
g));
-
-/*
- * @brief
- * Power function
- */
-
-/*
- * @brief
- * result =3D pow(arg1, arg2)
- *
- * @note
- * Currently, abs(arg1) should be less than 1. Take care!
- */
-static inline struct spl_fixed31_32 spl_fixpt_pow(struct spl_fixed31_32 ar=
g1, struct spl_fixed31_32 arg2)
-{
-=09if (arg1.value =3D=3D 0)
-=09=09return arg2.value =3D=3D 0 ? spl_fixpt_one : spl_fixpt_zero;
-
-=09return SPL_NAMESPACE(spl_fixpt_exp(
-=09=09SPL_NAMESPACE(spl_fixpt_mul(
-=09=09=09SPL_NAMESPACE(spl_fixpt_log(arg1)),
-=09=09=09arg2))));
-}
-
-/*
- * @brief
- * Rounding functions
- */
-
-/*
- * @brief
- * result =3D floor(arg) :=3D greatest integer lower than or equal to arg
- */
-static inline int spl_fixpt_floor(struct spl_fixed31_32 arg)
-{
-=09unsigned long long arg_value =3D arg.value > 0 ? arg.value : -arg.value=
;
-
-=09if (arg.value >=3D 0)
-=09=09return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-=09else
-=09=09return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/*
- * @brief
- * result =3D round(arg) :=3D integer nearest to arg
- */
-static inline int spl_fixpt_round(struct spl_fixed31_32 arg)
-{
-=09unsigned long long arg_value =3D arg.value > 0 ? arg.value : -arg.value=
;
-
-=09const long long summand =3D spl_fixpt_half.value;
-
-=09SPL_ASSERT(LLONG_MAX - (long long)arg_value >=3D summand);
-
-=09arg_value +=3D summand;
-
-=09if (arg.value >=3D 0)
-=09=09return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-=09else
-=09=09return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/*
- * @brief
- * result =3D ceil(arg) :=3D lowest integer greater than or equal to arg
- */
-static inline int spl_fixpt_ceil(struct spl_fixed31_32 arg)
-{
-=09unsigned long long arg_value =3D arg.value > 0 ? arg.value : -arg.value=
;
-
-=09const long long summand =3D spl_fixpt_one.value -
-=09=09spl_fixpt_epsilon.value;
-
-=09SPL_ASSERT(LLONG_MAX - (long long)arg_value >=3D summand);
-
-=09arg_value +=3D summand;
-
-=09if (arg.value >=3D 0)
-=09=09return (int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-=09else
-=09=09return -(int)(arg_value >> FIXED31_32_BITS_PER_FRACTIONAL_PART);
-}
-
-/* the following two function are used in scaler hw programming to convert=
 fixed
- * point value to format 2 bits from integer part and 19 bits from fractio=
nal
- * part. The same applies for u0d19, 0 bits from integer part and 19 bits =
from
- * fractional
- */
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg=
));
-
-unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg=
));
-
-int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg));
-
-static inline struct spl_fixed31_32 spl_fixpt_truncate(struct spl_fixed31_=
32 arg, unsigned int frac_bits)
-{
-=09bool negative =3D arg.value < 0;
-
-=09if (frac_bits >=3D FIXED31_32_BITS_PER_FRACTIONAL_PART) {
-=09=09SPL_ASSERT(frac_bits =3D=3D FIXED31_32_BITS_PER_FRACTIONAL_PART);
-=09=09return arg;
-=09}
-
-=09if (negative)
-=09=09arg.value =3D -arg.value;
-=09arg.value &=3D (~0ULL) << (FIXED31_32_BITS_PER_FRACTIONAL_PART - frac_b=
its);
-=09if (negative)
-=09=09arg.value =3D -arg.value;
-=09return arg;
-}
-
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int valu=
e,
-=09=09unsigned int integer_bits, unsigned int fractional_bits));
-struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int=
_value,
-=09=09unsigned int frac_value,
-=09=09unsigned int integer_bits,
-=09=09unsigned int fractional_bits));
+#include "dc/os_types.h"
+#include "include/fixed31_32.h"
+
+#define spl_fixed31_32 fixed31_32
+#define spl_fixpt_mul dc_fixpt_mul
+#define spl_fixpt_from_fraction dc_fixpt_from_fraction
+#define spl_fixpt_u0d19 dc_fixpt_u0d19
+#define spl_fixpt_u3d19 dc_fixpt_u3d19
+#define spl_fixpt_le dc_fixpt_le
+
+#define spl_fixpt_add dc_fixpt_add
+#define spl_fixpt_mul dc_fixpt_mul
+#define spl_fixpt_div dc_fixpt_div
+
+#define spl_fixpt_from_int dc_fixpt_from_int
+#define spl_fixpt_add_int dc_fixpt_add_int
+#define spl_fixpt_mul_int dc_fixpt_mul_int
+#define spl_fixpt_div_int dc_fixpt_div_int
+
+#define spl_fixpt_min dc_fixpt_min
+#define spl_fixpt_one dc_fixpt_one
+#define spl_fixpt_zero dc_fixpt_zero
+#define spl_fixpt_ceil dc_fixpt_ceil
+#define spl_fixpt_floor dc_fixpt_floor
+#define spl_fixpt_recip dc_fixpt_recip
+#define spl_fixpt_truncate dc_fixpt_truncate
+#define spl_fixpt_round dc_fixpt_round
=20
 #endif
--=20
2.54.0

