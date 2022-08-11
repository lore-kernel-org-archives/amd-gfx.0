Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7525C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BA1979CF;
	Thu, 11 Aug 2022 00:40:43 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5EF97A16
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:28 +0000 (UTC)
Received: by mail-vk1-xa35.google.com with SMTP id c22so8267364vko.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=7/Rh2PgDbTQ3rV+CeAhD8G/7QfPAGS6lSYGSbNLp4GM=;
 b=VBZTY4goJfh6oaOM1wQnIV6M0k+OkFoM0bw8+uM3vQ5YvdiRrHBr5QZkbRgF6UOv4K
 pKlrYJzCBkRqp2Ojfdkg0wAfJekBceNVY4YMSRbwKkD7+7JSPycl00f8YH2hEEpRj4JR
 UOTORn1EBaG9YoPZbP/1d2CDxbXHG9qjgL0AE20082akovgovCuGx1kkG1MrlzH18qPs
 CEorS2sfFlCkYw748BsVDKSdP88Q1PeH6TTTaJ6cRVGLSvqqkI7ZJ+PvQr3c3ZRiAztQ
 K8XRft+ZP2E+4WDZVAOUH2J47DUoz4/yca7VvFKtRKmb3xHqNk0C7Qimw7aD8nCohJZg
 TaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=7/Rh2PgDbTQ3rV+CeAhD8G/7QfPAGS6lSYGSbNLp4GM=;
 b=uAtRZkL1FXs58VZPtt195WR72Q011McFY2tbOlz91KuYK33m1KuICbbvDHmSwQXX3M
 O1fBWwL51INFihFDWwRegWZP/ON+zNnMh+Q3P2isxgUSROPrxSkDhSbQ6gJHlCFBnyZZ
 Kmy4PrW9uYltpk9FphYC8A+LrVQaXXLjCl+q1vRVJqOXpAKm2oBkNEMEj6L2s2nxwr1t
 n0ZlPCGlBjVhjeBAaR84LiRbZZsCyqlKhayl3s+Hffi7oRBFm7/cBxeXBJPOq1ni4dr+
 9auUqXOx1viCq8cY9opavR+BuZz5EKOavca2sTMqbUiAEcqmVJxOo5Feww9WMJhh5fgZ
 zwGg==
X-Gm-Message-State: ACgBeo2bUdQCMKcfv2aeep+Q7jmyQrvwT0Njh5V5G0e2AI2Le7Z0M4r5
 zypr8tRYG4r91ZX0l1m6ta4=
X-Google-Smtp-Source: AA6agR5J63mMyfOs0B6MJAPIa7ruy7+rXz0n3/DZnWyC4wjc/1ksGjbQsq9Tf5aFAUC8HxNjkq7vvQ==
X-Received: by 2002:a1f:c806:0:b0:374:2b74:47d5 with SMTP id
 y6-20020a1fc806000000b003742b7447d5mr13310809vkf.31.1660178427768; 
 Wed, 10 Aug 2022 17:40:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:27 -0700 (PDT)
From: Tales Aparecida <tales.aparecida@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 1/8] drm/amd/display: Introduce KUnit tests for fixed31_32
 library
Date: Wed, 10 Aug 2022 21:40:03 -0300
Message-Id: <20220811004010.61299-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220811004010.61299-1-tales.aparecida@gmail.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: siqueirajordao@riseup.net, magalilemes00@gmail.com,
 tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 mairacanal@riseup.net, kunit-dev@googlegroups.com,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fixed31_32 library performs a lot of the mathematical operations
involving fixed-point arithmetic and the conversion of integers to
fixed-point representation.

This unit tests intend to assure the proper functioning of the basic
mathematical operations of fixed-point arithmetic, such as
multiplication, conversion from fractional to fixed-point number,
and more. Use kunit_tool to run:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kunitconfig=drivers/gpu/drm/amd/display/tests/

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  13 +
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   5 +
 .../gpu/drm/amd/display/tests/.kunitconfig    |   6 +
 .../dc/basics/dc_basics_fixpt31_32_test.c     | 232 ++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 96cbc87f7b6b..27981ccb7032 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -55,4 +55,17 @@ config DRM_AMD_SECURE_DISPLAY
             Cooperate with specific DMCU FW.
 
 
+config AMD_DC_BASICS_KUNIT_TEST
+	bool "Enable unit tests for the 'utils' sub-component of DAL" if !KUNIT_ALL_TESTS
+	depends on DRM_AMD_DC && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+		Enables unit tests for the Display Core. Only useful for kernel
+		devs running KUnit.
+
+		For more information on KUnit and unit tests in general please refer to
+		the KUnit documentation in Documentation/dev-tools/kunit/.
+
+		If unsure, say N.
+
 endmenu
diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 1726bdf89bae..82747d8ab95a 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -490,3 +490,8 @@ int dc_fixpt_s4d19(struct fixed31_32 arg)
 	else
 		return ux_dy(arg.value, 4, 19);
 }
+
+#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
+#include "../../tests/dc/basics/dc_basics_fixpt31_32_test.c"
+#endif
+
diff --git a/drivers/gpu/drm/amd/display/tests/.kunitconfig b/drivers/gpu/drm/amd/display/tests/.kunitconfig
new file mode 100644
index 000000000000..60f2ff8158f5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/.kunitconfig
@@ -0,0 +1,6 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_DRM=y
+CONFIG_DRM_AMDGPU=y
+CONFIG_DRM_AMD_DC=y
+CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c b/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
new file mode 100644
index 000000000000..2fc489203499
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/basics/dc_basics_fixpt31_32_test.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: MIT
+/* Unit tests for display/include/fixed31_32.h and dc/basics/fixpt31_32.c
+ *
+ * Copyright (C) 2022, Tales Aparecida <tales.aparecida@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include "os_types.h"
+#include "fixed31_32.h"
+
+static const struct fixed31_32 dc_fixpt_minus_one = { -0x100000000LL };
+
+/**
+ * dc_fixpt_from_int_test - KUnit test for dc_fixpt_from_int
+ * @test: represents a running instance of a test.
+ */
+static void dc_fixpt_from_int_test(struct kunit *test)
+{
+	struct fixed31_32 res;
+
+	res = dc_fixpt_from_int(0);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_zero.value);
+
+	res = dc_fixpt_from_int(1);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	res = dc_fixpt_from_int(-1);
+	KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
+
+	res = dc_fixpt_from_int(INT_MAX);
+	KUNIT_EXPECT_EQ(test, res.value, 0x7FFFFFFF00000000LL);
+
+	res = dc_fixpt_from_int(INT_MIN);
+	KUNIT_EXPECT_EQ(test, res.value,
+			0x8000000000000000LL); /* implicit negative signal */
+}
+
+/**
+ * dc_fixpt_from_fraction_test - KUnit test for dc_fixpt_from_fraction
+ * @test: represents a running instance of a test.
+ */
+static void dc_fixpt_from_fraction_test(struct kunit *test)
+{
+	struct fixed31_32 res;
+
+	/* Assert signal works as expected */
+	res = dc_fixpt_from_fraction(1LL, 1LL);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	res = dc_fixpt_from_fraction(-1LL, 1LL);
+	KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
+
+	res = dc_fixpt_from_fraction(1LL, -1LL);
+	KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
+
+	res = dc_fixpt_from_fraction(-1LL, -1LL);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	/* Assert that the greatest parameter values works as expected */
+	res = dc_fixpt_from_fraction(LLONG_MAX, LLONG_MAX);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	res = dc_fixpt_from_fraction(LLONG_MIN, LLONG_MIN);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	/* Edge case using the smallest fraction possible without LSB rounding */
+	res = dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRACTIONAL_PART));
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
+
+	/* Edge case using the smallest fraction possible with LSB rounding */
+	res = dc_fixpt_from_fraction(1, 1LL << (FIXED31_32_BITS_PER_FRACTIONAL_PART + 1));
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_epsilon.value);
+
+	/* Assert an nil numerator is a valid input */
+	res = dc_fixpt_from_fraction(0LL, LLONG_MAX);
+	KUNIT_EXPECT_EQ(test, res.value, 0LL);
+
+	/* Edge case using every bit of the decimal part without rounding */
+	res = dc_fixpt_from_fraction(8589934590LL, 8589934592LL);
+	KUNIT_EXPECT_EQ(test, res.value, 0x0FFFFFFFFLL);
+
+	res = dc_fixpt_from_fraction(-8589934590LL, 8589934592LL);
+	KUNIT_EXPECT_EQ(test, res.value, -0x0FFFFFFFFLL);
+
+	/* Edge case using every bit of the decimal part then rounding LSB */
+	res = dc_fixpt_from_fraction(8589934591LL, 8589934592LL);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	res = dc_fixpt_from_fraction(-8589934591LL, 8589934592LL);
+	KUNIT_EXPECT_EQ(test, res.value, -dc_fixpt_one.value);
+	/*  A repeating decimal in binary representation that doesn't round up the LSB */
+	res = dc_fixpt_from_fraction(4, 3);
+	KUNIT_EXPECT_EQ(test, res.value, 0x0000000155555555LL);
+
+	res = dc_fixpt_from_fraction(-4, 3);
+	KUNIT_EXPECT_EQ(test, res.value, -0x0000000155555555LL);
+
+	/* A repeating decimal in binary representation that rounds up the LSB */
+	res = dc_fixpt_from_fraction(5, 3);
+	KUNIT_EXPECT_EQ(test, res.value, 0x00000001AAAAAAABLL);
+
+	res = dc_fixpt_from_fraction(-5, 3);
+	KUNIT_EXPECT_EQ(test, res.value, -0x00000001AAAAAAABLL);
+}
+
+/**
+ * dc_fixpt_mul_test - KUnit test for dc_fixpt_mul
+ * @test: represents a running instance of a test.
+ */
+static void dc_fixpt_mul_test(struct kunit *test)
+{
+	struct fixed31_32 res;
+	struct fixed31_32 arg;
+
+	/* Assert signal works as expected */
+	res = dc_fixpt_mul(dc_fixpt_one, dc_fixpt_one);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	res = dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_one);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
+
+	res = dc_fixpt_mul(dc_fixpt_one, dc_fixpt_minus_one);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_minus_one.value);
+
+	res = dc_fixpt_mul(dc_fixpt_minus_one, dc_fixpt_minus_one);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	/* Assert that the greatest parameter values works as expected */
+	arg.value = LONG_MAX;
+	res = dc_fixpt_mul(arg, dc_fixpt_one);
+	KUNIT_EXPECT_EQ(test, res.value, arg.value);
+
+	arg.value = LONG_MIN;
+	res = dc_fixpt_mul(arg, dc_fixpt_one);
+	KUNIT_EXPECT_EQ(test, res.value, arg.value);
+
+	arg.value = LONG_MAX;
+	res = dc_fixpt_mul(dc_fixpt_one, arg);
+	KUNIT_EXPECT_EQ(test, res.value, arg.value);
+
+	arg.value = LONG_MIN;
+	res = dc_fixpt_mul(dc_fixpt_one, arg);
+	KUNIT_EXPECT_EQ(test, res.value, arg.value);
+
+	/* Assert it doesn't round LSB as expected */
+	arg.value = 0x7FFFFFFF7fffffffLL;
+	res = dc_fixpt_mul(arg, dc_fixpt_epsilon);
+	KUNIT_EXPECT_EQ(test, res.value, 0x000000007FFFFFFF);
+
+	/* Assert it rounds LSB as expected */
+	arg.value = 0x7FFFFFFF80000000LL;
+	res = dc_fixpt_mul(arg, dc_fixpt_epsilon);
+	KUNIT_EXPECT_EQ(test, res.value, 0x0000000080000000);
+}
+
+/**
+ * dc_fixpt_sqr_test - KUnit test for dc_fixpt_sqr
+ * @test: represents a running instance of a test.
+ */
+static void dc_fixpt_sqr_test(struct kunit *test)
+{
+	struct fixed31_32 res;
+	struct fixed31_32 arg;
+
+	arg.value = dc_fixpt_one.value;
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	arg.value = dc_fixpt_minus_one.value;
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	arg.value = 0;
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value, 0);
+
+	/* Test some recognizable values */
+	arg = dc_fixpt_from_int(100);
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_from_int(10000).value);
+
+	arg = dc_fixpt_from_fraction(1, 100);
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value,
+			dc_fixpt_from_fraction(1, 10000).value);
+
+	/* LSB rounding */
+	arg = dc_fixpt_from_fraction(3, 2);
+	res = dc_fixpt_sqr(arg);
+	KUNIT_EXPECT_EQ(test, res.value,
+			dc_fixpt_from_fraction(9, 4).value + 1LL);
+}
+
+/**
+ * dc_fixpt_recip_test - KUnit test for dc_fixpt_recip
+ * @test: represents a running instance of a test.
+ */
+static void dc_fixpt_recip_test(struct kunit *test)
+{
+	struct fixed31_32 res;
+	struct fixed31_32 arg;
+
+	/* Assert 1/1 works as expected */
+	res = dc_fixpt_recip(dc_fixpt_one);
+	KUNIT_EXPECT_EQ(test, res.value, dc_fixpt_one.value);
+
+	/* Assert smallest parameters work as expected. */
+	arg.value = 3LL;
+	res = dc_fixpt_recip(arg);
+	KUNIT_EXPECT_EQ(test, res.value, 0x5555555555555555LL);
+
+	arg.value = -3LL;
+	res = dc_fixpt_recip(arg);
+	KUNIT_EXPECT_EQ(test, res.value, -0x5555555555555555LL);
+}
+
+static struct kunit_case dc_basics_fixpt31_32_test_cases[] = {
+	KUNIT_CASE(dc_fixpt_from_int_test),
+	KUNIT_CASE(dc_fixpt_from_fraction_test),
+	KUNIT_CASE(dc_fixpt_mul_test),
+	KUNIT_CASE(dc_fixpt_sqr_test),
+	KUNIT_CASE(dc_fixpt_recip_test),
+	{}
+};
+
+static struct kunit_suite dc_basics_fixpt31_32_test_suite = {
+	.name = "dc_basics_fixpt31_32",
+	.test_cases = dc_basics_fixpt31_32_test_cases,
+};
+
+kunit_test_suites(&dc_basics_fixpt31_32_test_suite);
+
-- 
2.37.0

