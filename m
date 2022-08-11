Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A2C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF72897A8C;
	Thu, 11 Aug 2022 00:40:50 +0000 (UTC)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6614797A4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:34 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id bj43so7222456vkb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=yWVaV1UtM3oloD9qapB/LwIihD3sODYyWc6pWPPqi4A=;
 b=B/XDx2JG72kBA2gIs5IPQWKU6AMIAlfrPwGLW0vkS9XC4BYh65t4Vwp43tULYw+eUA
 YvrGfej2ZeKIdnl4WwwX410CthZax5SvEmxICucNAj1ALVe+qyAwsh7f+3gmd+Dh62tl
 AhP3Ap/9imDswKDdhZswLhOd7d2B+nFSRN4LKOYoDHjZDhxVs12zK3x8ORQHvnFWc7F4
 3Kj13vs/M6osKx6XXwu7wjr99q+i8fMH8Cvjt+UqR+GHAmvJTSu2rXIX8/fPKwzSwul5
 eHP7Fti0oy0UP0t0gw5DJjC3aDudhHjjO1iOM664nBX46XRQoCbx0yzUIQh0taqTA8Ca
 5zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=yWVaV1UtM3oloD9qapB/LwIihD3sODYyWc6pWPPqi4A=;
 b=dNWIRiUYfJLbAjVxzqVjC2RfJGGwHXFre2chTf1Ph8Xw79Bzs05YEoKTm1Lb4sF9Cj
 461VfpmLUnWnw+j/24oqFixteBwCDrsB1DxrkJestxahBKPo7An0/Mb4Y0cQCQbaG+G6
 wE/l3hMRBExKVxOIkpqCcD4Cx8nDivb6DRdkJ1h9AYL3o+EYnAhJpzJ9IAiQeRLeHBAO
 Uw4Jb6RN5VG3g78Q5c1oeM+pVOW6SICQf6dMjIst9iktckh0QhThQJwfV+cqy4k5GVBu
 8g+OhTzKwiTCazy8f8uUxWC0EN8R/rGbsSkcEu+rTzIHR2mYCWNTlAJXDNRmWdfIOJ9s
 Ox0g==
X-Gm-Message-State: ACgBeo1yh6WaKXSz9tqYXVM2ct3CVKVODykW97J1Ysesmpt8SrZZd+Zm
 fpo6XrkCS2aUoMMKfCNZwzs=
X-Google-Smtp-Source: AA6agR5SzEhIOFYWN36DGRoKUOUNO0i9E0FPc14eCg61hAT7AGHHIb5jBDN3KezLGtFiwbe/ChFGAQ==
X-Received: by 2002:a1f:2981:0:b0:377:ea6:a939 with SMTP id
 p123-20020a1f2981000000b003770ea6a939mr12734849vkp.1.1660178433275; 
 Wed, 10 Aug 2022 17:40:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:32 -0700 (PDT)
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
Subject: [PATCH 2/8] drm/amd/display: Introduce KUnit tests to the bw_fixed
 library
Date: Wed, 10 Aug 2022 21:40:04 -0300
Message-Id: <20220811004010.61299-3-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220811004010.61299-1-tales.aparecida@gmail.com>
References: <20220811004010.61299-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Maíra Canal <maira.canal@usp.br>

KUnit unifies the test structure and provides helper tools that simplify
the development of tests. Basic use case allows running tests as regular
processes, which makes easier to run unit tests on a development machine
and to integrate the tests in a CI system.

This commit introduces a unit test to the bw_fixed library, which
performs a lot of the mathematical operations involving fixed-point
arithmetic and the conversion of integers to fixed-point representation
inside the Display Mode Library.

As fixed-point representation is the base foundation of the DML calcs
operations, this unit tests intend to assure the proper functioning of
the basic mathematical operations of fixed-point arithmetic, such as
multiplication, conversion from fractional to fixed-point number, and
more.  You can run it with: ./tools/testing/kunit/kunit.py run \
	--arch=x86_64 \
	--kunitconfig=drivers/gpu/drm/amd/display/tests/

Signed-off-by: Maíra Canal <maira.canal@usp.br>
Co-developed-by: Magali Lemes <magalilemes00@gmail.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Co-developed-by: Tales Aparecida <tales.aparecida@gmail.com>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  12 +
 .../drm/amd/display/dc/dml/calcs/bw_fixed.c   |   3 +
 .../gpu/drm/amd/display/tests/.kunitconfig    |   3 +-
 .../tests/dc/dml/calcs/bw_fixed_test.c        | 323 ++++++++++++++++++
 4 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 27981ccb7032..72e7a63da79f 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -54,6 +54,18 @@ config DRM_AMD_SECURE_DISPLAY
             of crc of specific region via debugfs.
             Cooperate with specific DMCU FW.
 
+config DML_KUNIT_TEST
+	bool "Run all unit tests for DML" if !KUNIT_ALL_TESTS
+	depends on DRM_AMD_DC && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+		Enables unit tests for the Display Mode Library. Only useful for kernel
+		devs running KUnit.
+
+		For more information on KUnit and unit tests in general please refer to
+		the KUnit documentation in Documentation/dev-tools/kunit/.
+
+		If unsure, say N.
 
 config AMD_DC_BASICS_KUNIT_TEST
 	bool "Enable unit tests for the 'utils' sub-component of DAL" if !KUNIT_ALL_TESTS
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
index 6ca288fb5fb9..fbe8d0661396 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
@@ -189,3 +189,6 @@ struct bw_fixed bw_mul(const struct bw_fixed arg1, const struct bw_fixed arg2)
 	return res;
 }
 
+#if IS_ENABLED(CONFIG_DML_KUNIT_TEST)
+#include "../../../tests/dc/dml/calcs/bw_fixed_test.c"
+#endif
diff --git a/drivers/gpu/drm/amd/display/tests/.kunitconfig b/drivers/gpu/drm/amd/display/tests/.kunitconfig
index 60f2ff8158f5..dd52cae852d2 100644
--- a/drivers/gpu/drm/amd/display/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/tests/.kunitconfig
@@ -3,4 +3,5 @@ CONFIG_PCI=y
 CONFIG_DRM=y
 CONFIG_DRM_AMDGPU=y
 CONFIG_DRM_AMD_DC=y
-CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
\ No newline at end of file
+CONFIG_AMD_DC_BASICS_KUNIT_TEST=y
+CONFIG_DML_KUNIT_TEST=y
diff --git a/drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c b/drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c
new file mode 100644
index 000000000000..1369da49f444
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/dml/calcs/bw_fixed_test.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: MIT
+/*
+ * KUnit tests for dml/calcs/bw_fixed.h
+ *
+ * Copyright (C) 2022, Magali Lemes <magalilemes00@gmail.com>
+ * Copyright (C) 2022, Maíra Canal <mairacanal@riseup.net>
+ * Copyright (C) 2022, Tales Aparecida <tales.aparecida@gmail.com>
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_util.h>
+#include "bw_fixed.h"
+
+/**
+ * DOC: Unit tests for AMDGPU DML calcs/bw_fixed.h
+ *
+ * bw_fixed.h performs a lot of the mathematical operations involving
+ * fixed-point arithmetic and the conversion of integers to fixed-point
+ * representation.
+ *
+ * As fixed-point representation is the base foundation of the DML calcs
+ * operations, these tests intend to assure the proper functioning of the
+ * basic mathematical operations of fixed-point arithmetic, such as
+ * multiplication, conversion from fractional to fixed-point number, and more.
+ *
+ */
+
+/**
+ * abs_i64_test - KUnit test for abs_i64
+ * @test: represents a running instance of a test.
+ */
+static void abs_i64_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 0ULL, abs_i64(0LL));
+
+	/* Argument type limits */
+	KUNIT_EXPECT_EQ(test, (uint64_t)MAX_I64, abs_i64(MAX_I64));
+	KUNIT_EXPECT_EQ(test, (uint64_t)MAX_I64 + 1, abs_i64(MIN_I64));
+}
+
+/**
+ * bw_int_to_fixed_nonconst_test - KUnit test for bw_int_to_fixed_nonconst
+ * @test: represents a running instance of a test.
+ */
+static void bw_int_to_fixed_nonconst_test(struct kunit *test)
+{
+	struct bw_fixed res;
+
+	/* Add BW_FIXED_BITS_PER_FRACTIONAL_PART trailing 0s to binary number */
+	res = bw_int_to_fixed_nonconst(1000);          /* 0x3E8 */
+	KUNIT_EXPECT_EQ(test, 16777216000, res.value); /* 0x3E8000000 */
+
+	res = bw_int_to_fixed_nonconst(-1000);          /* -0x3E8 */
+	KUNIT_EXPECT_EQ(test, -16777216000, res.value); /* -0x3E8000000 */
+
+	res = bw_int_to_fixed_nonconst(0LL);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	/**
+	 * Test corner cases, as the function's argument has to be an int64_t
+	 * between BW_FIXED_MIN_I32 and BW_FIXED_MAX_I32.
+	 */
+	res = bw_int_to_fixed_nonconst(BW_FIXED_MAX_I32 - 1);  /* 0x7FFFFFFFFE */
+	KUNIT_EXPECT_EQ(test, 9223372036821221376, res.value); /* 0x7FFFFFFFFE000000 */
+
+	res = bw_int_to_fixed_nonconst(BW_FIXED_MIN_I32 + 1);   /* -0x7FFFFFFFFF */
+	KUNIT_EXPECT_EQ(test, -9223372036837998592, res.value); /* -0x7FFFFFFFFF000000 */
+}
+
+/**
+ * bw_frc_to_fixed_test - KUnit test for bw_frc_to_fixed
+ * @test: represents a running instance of a test.
+ */
+static void bw_frc_to_fixed_test(struct kunit *test)
+{
+	struct bw_fixed res;
+
+	/* Extreme scenarios */
+
+	/* A fraction of N/N should result in "1.0" */
+	res = bw_frc_to_fixed(MAX_I64, MAX_I64);
+	KUNIT_EXPECT_EQ(test, 1LL << BW_FIXED_BITS_PER_FRACTIONAL_PART, res.value);
+
+	res = bw_frc_to_fixed(1, MAX_I64);
+	KUNIT_EXPECT_EQ(test, 0LL, res.value);
+
+	res = bw_frc_to_fixed(0, MAX_I64);
+	KUNIT_EXPECT_EQ(test, 0LL, res.value);
+
+	/* Turn a repeating decimal to the fixed-point representation */
+
+	/* A repeating decimal that doesn't round up the LSB */
+	res = bw_frc_to_fixed(4, 3);
+	KUNIT_EXPECT_EQ(test, 22369621LL, res.value);     /* 0x1555555 */
+
+	res = bw_frc_to_fixed(-4, 3);
+	KUNIT_EXPECT_EQ(test, -22369621LL, res.value);    /* -0x1555555 */
+
+	res = bw_frc_to_fixed(99999997, 100000000);
+	KUNIT_EXPECT_EQ(test, 16777215LL, res.value);     /* 0x0FFFFFF */
+
+	/* A repeating decimal that rounds up the MSB */
+	res = bw_frc_to_fixed(5, 3);
+	KUNIT_EXPECT_EQ(test, 27962027LL, res.value);     /* 0x1AAAAAB */
+
+	res = bw_frc_to_fixed(-5, 3);
+	KUNIT_EXPECT_EQ(test, -27962027LL, res.value);    /* -0x1AAAAAB */
+
+	res = bw_frc_to_fixed(99999998, 100000000);
+	KUNIT_EXPECT_EQ(test, 1LL << BW_FIXED_BITS_PER_FRACTIONAL_PART, res.value);
+
+	/* Turn a terminating decimal to the fixed-point representation */
+	res = bw_frc_to_fixed(62609, 100);
+	KUNIT_EXPECT_EQ(test, 10504047165LL, res.value);  /* 0X272170A3D */
+
+	res = bw_frc_to_fixed(-62609, 100);
+	KUNIT_EXPECT_EQ(test, -10504047165LL, res.value); /* -0X272170A3D */
+}
+
+/**
+ * bw_floor2_test - KUnit test for bw_floor2
+ * @test: represents a running instance of a test.
+ */
+static void bw_floor2_test(struct kunit *test)
+{
+	struct bw_fixed arg;
+	struct bw_fixed significance;
+	struct bw_fixed res;
+
+	/* Round 10 down to the nearest multiple of 3 */
+	arg.value = 10;
+	significance.value = 3;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 9, res.value);
+
+	/* Round 10 down to the nearest multiple of 5 */
+	arg.value = 10;
+	significance.value = 5;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 10, res.value);
+
+	/* Round 100 down to the nearest multiple of 7 */
+	arg.value = 100;
+	significance.value = 7;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 98, res.value);
+
+	/* Round an integer down to its nearest multiple should return itself */
+	arg.value = MAX_I64;
+	significance.value = MAX_I64;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MAX_I64, res.value);
+
+	arg.value = MIN_I64;
+	significance.value = MIN_I64;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MIN_I64, res.value);
+
+	/* Value is a multiple of significance, result should be value */
+	arg.value = MAX_I64;
+	significance.value = MIN_I64 + 1;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MAX_I64, res.value);
+
+	/* Round 0 down to the nearest multiple of any number should return 0 */
+	arg.value = 0;
+	significance.value = MAX_I64;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	arg.value = 0;
+	significance.value = MIN_I64;
+	res = bw_floor2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+}
+
+/**
+ * bw_ceil2_test - KUnit test for bw_ceil2
+ * @test: represents a running instance of a test.
+ */
+static void bw_ceil2_test(struct kunit *test)
+{
+	struct bw_fixed arg;
+	struct bw_fixed significance;
+	struct bw_fixed res;
+
+	/* Round 10 up to the nearest multiple of 3 */
+	arg.value = 10;
+	significance.value = 3;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 12, res.value);
+
+	/* Round 10 up to the nearest multiple of 5 */
+	arg.value = 10;
+	significance.value = 5;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 10, res.value);
+
+	/* Round 100 up to the nearest multiple of 7 */
+	arg.value = 100;
+	significance.value = 7;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 105, res.value);
+
+	/* Round an integer up to its nearest multiple should return itself */
+	arg.value = MAX_I64;
+	significance.value = MAX_I64;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MAX_I64, res.value);
+
+	arg.value = MIN_I64 + 1;
+	significance.value = MIN_I64 + 1;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MIN_I64 + 1, res.value);
+
+	/* Value is a multiple of significance, result should be value */
+	arg.value = MAX_I64;
+	significance.value = MIN_I64 + 1;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, MAX_I64, res.value);
+
+	/* Round 0 up to the nearest multiple of any number should return 0 */
+	arg.value = 0;
+	significance.value = MAX_I64;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	arg.value = 0;
+	significance.value = MIN_I64;
+	res = bw_ceil2(arg, significance);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+}
+
+/**
+ * bw_mul_test - KUnit test for bw_mul
+ * @test: represents a running instance of a test.
+ */
+static void bw_mul_test(struct kunit *test)
+{
+	struct bw_fixed arg1;
+	struct bw_fixed arg2;
+	struct bw_fixed res;
+	struct bw_fixed expected;
+
+	/* Extreme scenario */
+	arg1.value = MAX_I64;
+	arg2.value = MIN_I64;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, BW_FIXED_MAX_I32 + 1, res.value);
+
+	/* Testing multiplication property: x * 1 = x */
+	arg1.value = 1;
+	arg2.value = MAX_I64;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, BW_FIXED_MAX_I32 + 1, res.value);
+
+	arg1.value = 1;
+	arg2.value = MIN_I64;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, BW_FIXED_MIN_I32, res.value);
+
+	/* Testing multiplication property: x * 0 = 0 */
+	arg1.value = 0;
+	arg2.value = 0;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	arg1.value = 0;
+	arg2.value = MAX_I64;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	arg1.value = 0;
+	arg2.value = MIN_I64;
+	res = bw_mul(arg1, arg2);
+	KUNIT_EXPECT_EQ(test, 0, res.value);
+
+	/* Testing multiplication between integers */
+	res = bw_mul(bw_int_to_fixed(8), bw_int_to_fixed(10));
+	KUNIT_EXPECT_EQ(test, 1342177280LL, res.value); /* 0x50000000 */
+
+	res = bw_mul(bw_int_to_fixed(10), bw_int_to_fixed(5));
+	KUNIT_EXPECT_EQ(test, 838860800LL, res.value); /* 0x32000000 */
+
+	res = bw_mul(bw_int_to_fixed(-10), bw_int_to_fixed(7));
+	KUNIT_EXPECT_EQ(test, -1174405120LL, res.value); /* -0x46000000 */
+
+	/* Testing multiplication between fractions and integers */
+	res = bw_mul(bw_frc_to_fixed(4, 3), bw_int_to_fixed(3));
+	expected = bw_int_to_fixed(4);
+
+	/*
+	 * As bw_frc_to_fixed(4, 3) didn't round up the fixed-point representation,
+	 * the expected must be subtracted by 1.
+	 */
+	KUNIT_EXPECT_EQ(test, expected.value - 1, res.value);
+
+	res = bw_mul(bw_frc_to_fixed(5, 3), bw_int_to_fixed(3));
+	expected = bw_int_to_fixed(5);
+
+	/*
+	 * As bw_frc_to_fixed(5, 3) rounds up the fixed-point representation,
+	 * the expected must be added by 1.
+	 */
+	KUNIT_EXPECT_EQ(test, expected.value + 1, res.value);
+}
+
+static struct kunit_case bw_fixed_test_cases[] = {
+	KUNIT_CASE(abs_i64_test),
+	KUNIT_CASE(bw_int_to_fixed_nonconst_test),
+	KUNIT_CASE(bw_frc_to_fixed_test),
+	KUNIT_CASE(bw_floor2_test),
+	KUNIT_CASE(bw_ceil2_test),
+	KUNIT_CASE(bw_mul_test),
+	{  }
+};
+
+static struct kunit_suite bw_fixed_test_suite = {
+	.name = "dml_calcs_bw_fixed",
+	.test_cases = bw_fixed_test_cases,
+};
+
+kunit_test_suites(&bw_fixed_test_suite);
-- 
2.37.0

