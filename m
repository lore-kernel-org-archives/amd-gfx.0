Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F19BC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1ECA1B12;
	Thu, 11 Aug 2022 12:54:19 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A56A9B43
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 07:35:02 +0000 (UTC)
Received: by mail-vs1-xe29.google.com with SMTP id b124so17446555vsc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=Zf4dPRTYmplJYeainFGksxHZErpXbpZxUB9mz4KvGrY=;
 b=nXD1DDRQxBFX9R4LYgBCQHorbHZNm390NaV3B+cj/xb3heP0KUVnJABJPG+Va8QtN+
 WcyubkKOS0Ee4jT8NBbVamVnC8EhsaFyHk8fknCcUjwiZh03ZWO5MAF5Q+RrNjoBV2IB
 qW+1FD2gtKnB0RC00sYnKkV/Tb4cyOSeAlGsvC4hfoaz35eWik3BgxG2W86CDxKM9D4s
 O0jLsmjAzWpiQKKoJ71QNhDiPR9Q+1w37bfGaJId0D816AO4Y+0vjlEJ4BqxHoIZEzCy
 mkABN76w1bCznBaZk4EmR1zBQkKmFYzGHqlUajXXBO6wJJ0PxhWAgW259SLgcP0u4Kxv
 Q51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=Zf4dPRTYmplJYeainFGksxHZErpXbpZxUB9mz4KvGrY=;
 b=WxZ7Vmc1RYTi6mP/M6TUTDPRRm7dTcYOWDpop9uGuGLhYn56SADM1b8HGtZBItDIy2
 F4/MSwdQHm4c0oY8GgCiD+Iw6r4c+EO5QH6t8XNj8fwAlDffTIt9WlLAwePNQ9j5kV6J
 cSRioSQ7ZqGMArpSGyYZIkVEIk/8AY2rsEAht4Socg6vL54nbdbpGDcoT7M5kA8ijbIE
 tiK2UNrPx6uI9/Cuez97Q6IDOrMHoNDIEWbbTB17W8auAbjHU7iQkClMVmESPBfRcUR/
 2KH2UI5yoH6mG5ch4V8J+U+YFYerhh8e6ehpEuaPumfcEWuwyoniDuzvZl4pI+25Fgl2
 3jPg==
X-Gm-Message-State: ACgBeo1Y6na1vSwuHw99dvpxcjLhoZNODhPXbM5Ut4Doi7TNF1BA7GH2
 /sRZ5GggIX0j/vpn55JGeeMIcqItchJBNgJi82ma6g==
X-Google-Smtp-Source: AA6agR7P7/8YGFQUN6OSOy19y0QIwoBp1FpPcb467Or9uEETD0mmcu/Y5akkWCYCeP9e3yf8bVeQbZ0ulqnOPFAbmtE=
X-Received: by 2002:a67:c198:0:b0:383:b020:f7c4 with SMTP id
 h24-20020a67c198000000b00383b020f7c4mr13892853vsj.71.1660203301565; Thu, 11
 Aug 2022 00:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
 <20220811004010.61299-3-tales.aparecida@gmail.com>
In-Reply-To: <20220811004010.61299-3-tales.aparecida@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Aug 2022 15:34:50 +0800
Message-ID: <CABVgOSmkeybnR2sGEEgn1Cb0cR2eKxW=vhXkHjC5xCuhaxsqVg@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amd/display: Introduce KUnit tests to the
 bw_fixed library
To: Tales Aparecida <tales.aparecida@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Aug 2022 12:54:12 +0000
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
Cc: siqueirajordao@riseup.net, David Airlie <airlied@linux.ie>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Jonathan Corbet <corbet@lwn.net>, magalilemes00@gmail.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 KUnit Development <kunit-dev@googlegroups.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, mwen@igalia.com,
 Trevor Woerner <twoerner@gmail.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 8:40 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> From: Ma=C3=ADra Canal <maira.canal@usp.br>
>
> KUnit unifies the test structure and provides helper tools that simplify
> the development of tests. Basic use case allows running tests as regular
> processes, which makes easier to run unit tests on a development machine
> and to integrate the tests in a CI system.
>
> This commit introduces a unit test to the bw_fixed library, which
> performs a lot of the mathematical operations involving fixed-point
> arithmetic and the conversion of integers to fixed-point representation
> inside the Display Mode Library.
>
> As fixed-point representation is the base foundation of the DML calcs
> operations, this unit tests intend to assure the proper functioning of
> the basic mathematical operations of fixed-point arithmetic, such as
> multiplication, conversion from fractional to fixed-point number, and
> more.  You can run it with: ./tools/testing/kunit/kunit.py run \
>         --arch=3Dx86_64 \
>         --kunitconfig=3Ddrivers/gpu/drm/amd/display/tests/
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> Co-developed-by: Magali Lemes <magalilemes00@gmail.com>
> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> Co-developed-by: Tales Aparecida <tales.aparecida@gmail.com>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

Not directly related to this patch, but I get a whole stack of
warnings about the definition of MIN_I64 causing integer overflow:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/../../../tests/dc/dml=
/calcs/bw_fixed_test.c:214:31:
note: in expansion of macro =E2=80=98MIN_I64=E2=80=99
 214 |         KUNIT_EXPECT_EQ(test, MIN_I64 + 1, res.value);
     |                               ^~~~~~~
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
warning: integer overflow in expression =E2=80=98-9223372036854775808=E2=80=
=99 of type
=E2=80=98long long int=E2=80=99 results in =E2=80=98-9223372036854775808=E2=
=80=99 [-Woverflow]
  30 |         (int64_t)(-(1LL << 63))
     |                   ^

This seems to fix it (I'll re-send it out as a separate patch so gmail
doesn't mangle it once I'm a bit more convinced it's the best
implementation):

--- 8< ---
From 84e84664873dc9e98dff5ee9f74d95872e6cd423 Mon Sep 17 00:00:00 2001
From: David Gow <davidgow@google.com>
Date: Thu, 11 Aug 2022 15:21:02 +0800
Subject: [PATCH] drm/amd/display: MIN_I64 definition causes overflow
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The definition of MIN_I64 in bw_fixed.c can cause gcc to whinge about
integer overflow, because it is treated as a positive value, which is
then negated. The temporary postive value is not necessarily
representable.

This causes the following warning:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/calcs/bw_fixed.c:30:19:
warning: integer overflow in expression =E2=80=98-9223372036854775808=E2=80=
=99 of type
=E2=80=98long long int=E2=80=99 results in =E2=80=98-9223372036854775808=E2=
=80=99 [-Woverflow]
  30 |         (int64_t)(-(1LL << 63))
     |                   ^

Writing out (INT_MIN - 1) - 1 works instead.

Signed-off-by: David Gow <davidgow@google.com>
---
drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c | 6 +++---
1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
index fbe8d0661396..3850f7f0f679 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
@@ -26,12 +26,12 @@
#include "bw_fixed.h"


-#define MIN_I64 \
-       (int64_t)(-(1LL << 63))
-
#define MAX_I64 \
       (int64_t)((1ULL << 63) - 1)

+#define MIN_I64 \
+       (-MAX_I64 - 1)
+
#define FRACTIONAL_PART_MASK \
       ((1ULL << BW_FIXED_BITS_PER_FRACTIONAL_PART) - 1)

--
2.37.1.595.g718a3a8f04-goog
--- 8< ---

Otherwise, this test seems to okay. I'll review it (and the series)
more properly over then next few days.

Cheers,
-- David
