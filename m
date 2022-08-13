Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B9EC19F2D
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 09:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44CA8A77C;
	Sat, 13 Aug 2022 09:20:36 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6253DB95D4
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 05:57:04 +0000 (UTC)
Received: by mail-ua1-x935.google.com with SMTP id 38so1056444uau.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=B0ujQQKh05kItfYHRKjykhUZXOkRF/q57AIUXqXPJdg=;
 b=tQLd328v49yvl4TGwh3SdE0qZLrwvR3OZEqExztOWBVhV30kjicxxKFaxe/keLeibA
 9YZbsQCn48gAHCuSWnyMvHmNdPWa30ZTaqGnBcGWO/Sqd8q4dS+V493a95cuJum7Jq7e
 6yZsPDws13u9my9m6k0QzmsyGXE/LPyjA2WAMXjHR69cw2YogYSZR1Tj+RjsfudXhj3y
 vAcE3M7AdCs4oTALbotrzGjP05JHOlk4yLb6QDDuAm5Tch/lBqgGQ7AD2WKguhH1jEEN
 upKXLux5S/9l123hq8vAvgFRfkXDhxu+RKJnMSPh2zcJrsivFidsHc2ZO6desmhGNJT3
 ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=B0ujQQKh05kItfYHRKjykhUZXOkRF/q57AIUXqXPJdg=;
 b=7tmSvFuTfqQGNgshib7yG7rJdh6KezwmRvAeFJvnqvDzVFjJNAERB84/kwwmr6FPmm
 KZWS4Wyx7Xrn1rPbNquWBPkmyEctzVUV8GCxHQMS7in78AnJOlo1grAPiJzAwbTYgC29
 9AbMsTbDIo8MBt0LVsR30ui5fiidZWWVc06J5pcOtqwL0yDVYchhOIw/itnq/Tk1JNdA
 OlsdgnGAEF/vJ5RD+Wr3PLqMmvhP6A2WsQlAVrw2icgFo9cPlj4eKOQlspHSSMSaQKB8
 Z6F/pO+Ly+NvK9msBWOypLh9ga60KNjs4y9h2YycPC77WtJuIhz8FIEkjxvBSYy2TFVj
 GDqw==
X-Gm-Message-State: ACgBeo2J2ptLzX0WbiZcZx+p60mLNpY9P3o5E/y2Yk7jh0GXQxnHee26
 O/RY1t6t46PiEnQtvYpqEiqif7gDv7xeXqMeJ+ir+Q==
X-Google-Smtp-Source: AA6agR6F9LmoSaPAXpWLzraKjpG9HXvk9qxlUQv/XNYHQutP/gBrGbdevhH+mOH+RMxcz7yBIWQ6bPXOyHYjucvBrJY=
X-Received: by 2002:ab0:32d8:0:b0:384:cced:87fb with SMTP id
 f24-20020ab032d8000000b00384cced87fbmr3074999uao.52.1660370223280; Fri, 12
 Aug 2022 22:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-2-tales.aparecida@gmail.com>
In-Reply-To: <20220811004010.61299-2-tales.aparecida@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 13 Aug 2022 13:56:52 +0800
Message-ID: <CABVgOS=wdbxczwgbTrGgDof_nTBUSfA_0WpqTdk2jhgPLrO2nw@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amd/display: Introduce KUnit tests for fixed31_32
 library
To: Tales Aparecida <tales.aparecida@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000060787705e61911ed"
X-Mailman-Approved-At: Sat, 13 Aug 2022 09:20:17 +0000
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
Cc: andrealmeid@riseup.net, Thomas Zimmermann <tzimmermann@suse.de>,
 siqueirajordao@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, magalilemes00@gmail.com,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Trevor Woerner <twoerner@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 KUnit Development <kunit-dev@googlegroups.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000060787705e61911ed
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 11, 2022 at 8:40 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> The fixed31_32 library performs a lot of the mathematical operations
> involving fixed-point arithmetic and the conversion of integers to
> fixed-point representation.
>
> This unit tests intend to assure the proper functioning of the basic
> mathematical operations of fixed-point arithmetic, such as
> multiplication, conversion from fractional to fixed-point number,
> and more. Use kunit_tool to run:
>
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kunitconfig=drivers/gpu/drm/amd/display/tests/
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

On the whole, I really like these tests: this sort-of fixed-point
library code is such an excellent example of the sorts of thing KUnit
is really well suited for.

The only thing I'll comment on is that these _could_ be parameterised
tests (given most of them are just testing the same function over and
over with different inputs). That being said, it's a matter of taste
as much as anything.

Otherwise, the remaining comments I'd have apply to most of the
patches in the series, particularly around where they live and how
they're compiled. I think what you have now is okay, but does have
some drawbacks.
In particular, while the #include method is a good
lowest-common-denominator (in that it opens up testing static
functions), it isn't as flexible and broadly compatible with different
testing setups (particularly some with KUNIT=m) as having a separate
test module. I tried making this a separate

It's up to you (and the DRM/AMDGPU maintainers) as to whether having
consistency between tests which _do_ need to test static functions is
worth having those that don't be less accessible.

I've left some comments with more detail below, but regardless, these
tests look fine to me:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/gpu/drm/amd/display/Kconfig           |  13 +
>  .../drm/amd/display/dc/basics/fixpt31_32.c    |   5 +
>  .../gpu/drm/amd/display/tests/.kunitconfig    |   6 +
>  .../dc/basics/dc_basics_fixpt31_32_test.c     | 232 ++++++++++++++++++
>  4 files changed, 256 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
>  create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 96cbc87f7b6b..27981ccb7032 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -55,4 +55,17 @@ config DRM_AMD_SECURE_DISPLAY
>              Cooperate with specific DMCU FW.
>
>
> +config AMD_DC_BASICS_KUNIT_TEST
> +       bool "Enable unit tests for the 'utils' sub-component of DAL" if !KUNIT_ALL_TESTS
> +       depends on DRM_AMD_DC && KUNIT

If these tests get compiled into the amdgpu kernel module, and
CONFIG_KUNIT=m, this could break loading the driver in some setups.

In particular, see the discussion here:
https://lore.kernel.org/all/20220810234056.2494993-1-npache@redhat.com/T/#u

Given this doesn't affect the "supported" cases, I think you can leave
it as-is, but if you want to handle his "build with KUNIT=m, but
kunit.ko not installed" case, you'll probably want to either split the
tests out into a separate module, or depend on KUNIT=y.

> +       default KUNIT_ALL_TESTS
> +       help
> +               Enables unit tests for the Display Core. Only useful for kernel
> +               devs running KUnit.

Given the above, maybe it's worth explicitly noting that these tests
get compiled into the amdgpu module.


> +
> +               For more information on KUnit and unit tests in general please refer to
> +               the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +               If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> index 1726bdf89bae..82747d8ab95a 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> @@ -490,3 +490,8 @@ int dc_fixpt_s4d19(struct fixed31_32 arg)
>         else
>                 return ux_dy(arg.value, 4, 19);
>  }
> +
> +#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
> +#include "../../tests/dc/basics/dc_basics_fixpt31_32_test.c"
> +#endif
> +




> diff --git a/drivers/gpu/drm/amd/display/tests/.kunitconfig b/drivers/gpu/drm/amd/display/tests/.kunitconfig
> new file mode 100644
> index 000000000000..60f2ff8158f5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/tests/.kunitconfig
> @@ -0,0 +1,6 @@
> +CONFIG_KUNIT=y
> +CONFIG_PCI=y
> +CONFIG_DRM=y
> +CONFIG_DRM_AMDGPU=y
> +CONFIG_DRM_AMD_DC=y
> +CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c b/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
> new file mode 100644
> index 000000000000..2fc489203499
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: MIT
> +/* Unit tests for display/include/fixed31_32.h and dc/basics/fixpt31_32.c
> + *
> + * Copyright (C) 2022, Tales Aparecida <tales.aparecida@gmail.com>
> + */
> +
> +#include <kunit/test.h>
> +#include "os_types.h"
> +#include "fixed31_32.h"
> +
> +static const struct fixed31_32 dc_fixpt_minus_one = { -0x100000000LL };
> +
> +/**
> + * dc_fixpt_from_int_test - KUnit test for dc_fixpt_from_int
> + * @test: represents a running instance of a test.
> + */
> +static void dc_fixpt_from_int_test(struct kunit *test)
> +{
> +       struct fixed31_32 res;
> +
> +       res = dc_fixpt_from_int(0);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_zero.value);
> +
> +       res = dc_fixpt_from_int(1);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_int(-1);
> +       KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_int(INT_MAX);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x7FFFFFFF00000000LL);
> +
> +       res = dc_fixpt_from_int(INT_MIN);
> +       KUNIT_EXPECT_EQ(test, res.value,
> +                       0x8000000000000000LL); /* implicit negative signal */
> +}

These could be done as a parameterised test if you prefer, though it's
fine either way.



> +
> +/**
> + * dc_fixpt_from_fraction_test - KUnit test for dc_fixpt_from_fraction
> + * @test: represents a running instance of a test.
> + */
> +static void dc_fixpt_from_fraction_test(struct kunit *test)
> +{
> +       struct fixed31_32 res;
> +
> +       /* Assert signal works as expected */
> +       res = dc_fixpt_from_fraction(1LL, 1LL);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_fraction(-1LL, 1LL);
> +       KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_fraction(1LL, -1LL);
> +       KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_fraction(-1LL, -1LL);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       /* Assert that the greatest parameter values works as expected */
> +       res = dc_fixpt_from_fraction(LLONG_MAX, LLONG_MAX);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_fraction(LLONG_MIN, LLONG_MIN);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       /* Edge case using the smallest fraction possible without LSB rounding */
> +       res = dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRACTIONAL_PART));
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
> +
> +       /* Edge case using the smallest fraction possible with LSB rounding */
> +       res = dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRACTIONAL_PART + 1));
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
> +
> +       /* Assert an nil numerator is a valid input */
> +       res = dc_fixpt_from_fraction(0LL, LLONG_MAX);
> +       KUNIT_EXPECT_EQ(test, res.value, 0LL);
> +
> +       /* Edge case using every bit of the decimal part without rounding */
> +       res = dc_fixpt_from_fraction(8589934590LL, 8589934592LL);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x0FFFFFFFFLL);
> +
> +       res = dc_fixpt_from_fraction(-8589934590LL, 8589934592LL);
> +       KUNIT_EXPECT_EQ(test, res.value, -0x0FFFFFFFFLL);
> +
> +       /* Edge case using every bit of the decimal part then rounding LSB */
> +       res = dc_fixpt_from_fraction(8589934591LL, 8589934592LL);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       res = dc_fixpt_from_fraction(-8589934591LL, 8589934592LL);
> +       KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
> +       /*  A repeating decimal in binary representation that doesn't round up the LSB */
> +       res = dc_fixpt_from_fraction(4, 3);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x0000000155555555LL);
> +
> +       res = dc_fixpt_from_fraction(-4, 3);
> +       KUNIT_EXPECT_EQ(test, res.value, -0x0000000155555555LL);
> +
> +       /* A repeating decimal in binary representation that rounds up the LSB */
> +       res = dc_fixpt_from_fraction(5, 3);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x00000001AAAAAAABLL);
> +
> +       res = dc_fixpt_from_fraction(-5, 3);
> +       KUNIT_EXPECT_EQ(test, res.value, -0x00000001AAAAAAABLL);
> +}
> +
> +/**
> + * dc_fixpt_mul_test - KUnit test for dc_fixpt_mul
> + * @test: represents a running instance of a test.
> + */
> +static void dc_fixpt_mul_test(struct kunit *test)
> +{
> +       struct fixed31_32 res;
> +       struct fixed31_32 arg;
> +
> +       /* Assert signal works as expected */
> +       res = dc_fixpt_mul(dc_fixpt_one, dc_fixpt_one);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       res = dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_one);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
> +
> +       res = dc_fixpt_mul(dc_fixpt_one, dc_fixpt_minus_one);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
> +
> +       res = dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_minus_one);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       /* Assert that the greatest parameter values works as expected */
> +       arg.value = LONG_MAX;
> +       res = dc_fixpt_mul(arg, dc_fixpt_one);
> +       KUNIT_EXPECT_EQ(test, res.value, arg.value);
> +
> +       arg.value = LONG_MIN;
> +       res = dc_fixpt_mul(arg, dc_fixpt_one);
> +       KUNIT_EXPECT_EQ(test, res.value, arg.value);
> +
> +       arg.value = LONG_MAX;
> +       res = dc_fixpt_mul(dc_fixpt_one, arg);
> +       KUNIT_EXPECT_EQ(test, res.value, arg.value);
> +
> +       arg.value = LONG_MIN;
> +       res = dc_fixpt_mul(dc_fixpt_one, arg);
> +       KUNIT_EXPECT_EQ(test, res.value, arg.value);
> +
> +       /* Assert it doesn't round LSB as expected */
> +       arg.value = 0x7FFFFFFF7fffffffLL;
> +       res = dc_fixpt_mul(arg, dc_fixpt_epsilon);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x000000007FFFFFFF);
> +
> +       /* Assert it rounds LSB as expected */
> +       arg.value = 0x7FFFFFFF80000000LL;
> +       res = dc_fixpt_mul(arg, dc_fixpt_epsilon);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x0000000080000000);
> +}
> +
> +/**
> + * dc_fixpt_sqr_test - KUnit test for dc_fixpt_sqr
> + * @test: represents a running instance of a test.
> + */
> +static void dc_fixpt_sqr_test(struct kunit *test)
> +{
> +       struct fixed31_32 res;
> +       struct fixed31_32 arg;
> +
> +       arg.value = dc_fixpt_one.value;
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       arg.value = dc_fixpt_minus_one.value;
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       arg.value = 0;
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, 0);
> +
> +       /* Test some recognizable values */
> +       arg = dc_fixpt_from_int(100);
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_from_int(10000).value);
> +
> +       arg = dc_fixpt_from_fraction(1, 100);
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value,
> +                       dc_fixpt_from_fraction(1, 10000).value);
> +
> +       /* LSB rounding */
> +       arg = dc_fixpt_from_fraction(3, 2);
> +       res = dc_fixpt_sqr(arg);
> +       KUNIT_EXPECT_EQ(test, res.value,
> +                       dc_fixpt_from_fraction(9, 4).value + 1LL);
> +}
> +
> +/**
> + * dc_fixpt_recip_test - KUnit test for dc_fixpt_recip
> + * @test: represents a running instance of a test.
> + */
> +static void dc_fixpt_recip_test(struct kunit *test)
> +{
> +       struct fixed31_32 res;
> +       struct fixed31_32 arg;
> +
> +       /* Assert 1/1 works as expected */
> +       res = dc_fixpt_recip(dc_fixpt_one);
> +       KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
> +
> +       /* Assert smallest parameters work as expected. */
> +       arg.value = 3LL;
> +       res = dc_fixpt_recip(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, 0x5555555555555555LL);
> +
> +       arg.value = -3LL;
> +       res = dc_fixpt_recip(arg);
> +       KUNIT_EXPECT_EQ(test, res.value, -0x5555555555555555LL);
> +}
> +
> +static struct kunit_case dc_basics_fixpt31_32_test_cases[] = {
> +       KUNIT_CASE(dc_fixpt_from_int_test),
> +       KUNIT_CASE(dc_fixpt_from_fraction_test),
> +       KUNIT_CASE(dc_fixpt_mul_test),
> +       KUNIT_CASE(dc_fixpt_sqr_test),
> +       KUNIT_CASE(dc_fixpt_recip_test),
> +       {}
> +};
> +
> +static struct kunit_suite dc_basics_fixpt31_32_test_suite = {
> +       .name = "dc_basics_fixpt31_32",
> +       .test_cases = dc_basics_fixpt31_32_test_cases,
> +};
> +
> +kunit_test_suites(&dc_basics_fixpt31_32_test_suite);
> +
> --
> 2.37.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220811004010.61299-2-tales.aparecida%40gmail.com.

--00000000000060787705e61911ed
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBA
sO2JY2IyCyzc5lAV08+dDLhHRvxo+bqNmwK2AvaFdjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTMwNTU3MDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQT4hmLC0ZwxFHn7/sEu4
mosdDlrGlA/M5rr1vgSnfsbwctDag6S3etjdLRyoKnny8iCWtt8jRCkmFZV4qTWeGPamFv6BzBcv
YG+gEiBRfjm44Gas+LdmVSZS7lBVh3h5uwoFad7+seIQp9HHdlrVaH6eXW5VEefvn1pOtAkVh5T2
0QcqaQxMHeApfASxK1buNT5P01tEbKGkxizKPAQlGoZUXzq26eOiB9iUeVXVqY8QB4RvNIx9tpdK
KspFOm8BXyPBKDeFzd3CSDleeX6A3Df7b+M5Faqsp7pWJLehaymme5g7SKwLDwJeyGCEeueSslfk
k42zurPl/y5Yr9mFjg==
--00000000000060787705e61911ed--
