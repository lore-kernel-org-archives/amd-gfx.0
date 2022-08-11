Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F44C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2288118BDD6;
	Thu, 11 Aug 2022 00:41:01 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D173418BDD6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:39 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id s129so16844003vsb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=GbHaFYxf/CV3p/CkLXhE8O1MukNhPUsOmxBxGhbW4Vg=;
 b=EO6UYx4tZxK3tdG8JOPcBf2SNXYRBDqFfM55g0pVB2FFmW2jLr5tOxTyfC6kUDPY3g
 dOmLa6SHr1qD+z8Hg1Bx+51ZXqPvoL7kZ0pd9FRoI4R8DdOaRGtTubdv42i6dkwjcm7+
 gZDNSGrS42NQyiUTLtIzB1xKzyLImNe80pAHJcbZQcGTMyAwsAoamhpLtPykMjY1sQ0g
 b1ggy6WY+R4dK2ar2RCN64H9D1SBRJHECtYXfOp/uhCJcNB7NSW3H3oVpmP0+cE9tSKS
 Sx9y9BvelM66qXuZ01CTmKQjbFuPOBywXVhpcqXRPznEXuKGnfCkt8ugw6SOn9yVSKPK
 U9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=GbHaFYxf/CV3p/CkLXhE8O1MukNhPUsOmxBxGhbW4Vg=;
 b=prC5HcOyzS3ZzLg/kLEH71aDhpnv6ehKlUJJ/OGyvx9hksx9GM7d+y4GP9hDlYv4Hi
 ZzMFxMPoN8w9DWvoX1o0OEWZn0KRlDb4981QCMo8yO+V/Tmyvn5PBnAjVbRTE/MrEl8f
 iv+J8pDBuyf4xRLZSiXUFQ5xpTnxNIumkV0+J7voR8YGKukUHSeN6uhhEZMDbLKaq4sU
 Jy+Fwb5dSJPeDomwZlPVpCOM6Fg/nGH9OLrb+nrxPY4ZzwOA3TOfVyxZfLhZ/jKAlR6z
 bjciE05jOkvRPrCf5S+y5lo1VuEmcYzms/yYmCQkALm99oCVfQBnL+R+oc6ahLOpj2Ii
 PIBQ==
X-Gm-Message-State: ACgBeo2O5L/RwUikr+K8DmHlk48TVJaumUTiDktlJvDThDb4Xt7CKITC
 rMw2ZJhTWE//braE6oArdeI=
X-Google-Smtp-Source: AA6agR6dnrTP3CPCvK3EGKdWZ2wTEbn4xp/Hfo060sio3KvWysrDsMmcDQxt3NtkSxPMHkDZfrw3Bw==
X-Received: by 2002:a67:db14:0:b0:387:fc62:8cd7 with SMTP id
 z20-20020a67db14000000b00387fc628cd7mr12786384vsj.80.1660178438893; 
 Wed, 10 Aug 2022 17:40:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:38 -0700 (PDT)
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
Subject: [PATCH 3/8] drm/amd/display: Introduce Kunit tests to
 display_rq_dlg_calc_20
Date: Wed, 10 Aug 2022 21:40:05 -0300
Message-Id: <20220811004010.61299-4-tales.aparecida@gmail.com>
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

From: Isabella Basso <isabbasso@riseup.net>

This adds tests to the bit encoding format verification functions on the
file. They're meant to be simpler so as to provide a proof of concept on
testing DML code.

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 +
 .../dml/dcn20/display_rq_dlg_calc_20_test.c   | 112 ++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 548cdef8a8ad..ab688c9ba0d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -1683,3 +1683,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 		ASSERT(*refcyc_per_req_delivery_cur < dml_pow(2, 13));
 	}
 }
+
+#if IS_ENABLED(CONFIG_DML_KUNIT_TEST)
+#include "../../../tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c"
+#endif
diff --git a/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c
new file mode 100644
index 000000000000..03ac3522e804
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_rq_dlg_calc_20_test.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: MIT
+/*
+ * KUnit tests for dml/dcn20/display_rq_dlg_calc_20.c
+ *
+ * Copyright (c) 2022, Isabella Basso <isabbasso@riseup.net>
+ */
+
+#include <kunit/test.h>
+#include "dml/display_mode_lib.h"
+
+static void get_bytes_per_element_test(struct kunit *test)
+{
+	/* last numbers should tell us the horizontal 4-element region binary
+	 * size N used for subsampling, thus giving us N/8 bytes per element
+	 */
+	/* note that 4:4:4 is not subsampled */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_16, false), 2);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_32, false), 4);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_64, false), 8);
+
+	/* dcn20 doesn't support bit depths over 10b */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_12, false), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_12, true), 0);
+
+	/* dm_444_XX are not dual plane */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_16, true), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_32, true), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_64, true), 0);
+
+	/* in the dm_42* values, last numbers specify bit depth, demanding we
+	 * treat chroma and luma channels separately
+	 */
+	/* thus we'll now have ceil(N/8) bytes for luma */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_8, false), 1);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_10, false), 2);
+	/* and double the luma value for accommodating blue and red chroma
+	 * channels
+	 */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_8, true), 2);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_420_10, true), 4);
+
+	/* monochrome encodings should mirror non-subsampled variants */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_mono_8, false),
+			get_bytes_per_element(dm_444_8, false));
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_mono_16, false),
+			get_bytes_per_element(dm_444_16, false));
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_mono_16, true), 0);
+
+	/* dcn20 doesn't support 4:2:2 chroma subsampling */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_422_8, false), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_422_8, true), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_422_10, false), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_422_10, true), 0);
+
+	/* dcn20 doesn't support RGBE encodings */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_rgbe, false), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_rgbe, true), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_rgbe_alpha, false), 0);
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_rgbe_alpha, true), 0);
+
+	/* as in the first values, _8 here represents horizontal binary length */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_8, false), 1);
+	/* in a non-subsampled monochrome encoding chroma and luma should be the
+	 * same length
+	 */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_444_8, false),
+			get_bytes_per_element(dm_444_8, true));
+
+	/* as dm_mono_8 == dm_444_8, it must behave the same way */
+	KUNIT_ASSERT_EQ(test, get_bytes_per_element(dm_mono_8, false),
+			get_bytes_per_element(dm_mono_8, true));
+}
+
+static void is_dual_plane_test(struct kunit *test)
+{
+	/* strictly speaking monochrome formats are not dual plane, but they're
+	 * included here for completeness
+	 */
+	int source_format_count = 11;
+
+	for (int i = 0; i < source_format_count; i++) {
+		/* dcn20 doesn't support other dual plane formats */
+		if (i == 3 || i == 4)
+			KUNIT_ASSERT_TRUE(test, is_dual_plane(i));
+		else
+			KUNIT_ASSERT_FALSE(test, is_dual_plane(i));
+	}
+}
+
+static void get_blk_size_bytes_test(struct kunit *test)
+{
+	/* corresponds to 4^4 kB tiles */
+	KUNIT_ASSERT_EQ(test, get_blk_size_bytes(dm_256k_tile), 256 * 1024);
+	/* corresponds to 4^3 kB tiles */
+	KUNIT_ASSERT_EQ(test, get_blk_size_bytes(dm_64k_tile), 64 * 1024);
+	/* corresponds to 4^1 kB tiles */
+	KUNIT_ASSERT_EQ(test, get_blk_size_bytes(dm_4k_tile), 4 * 1024);
+}
+
+static struct kunit_case dcn20_rq_dlg_calc_20_test_cases[] = {
+	KUNIT_CASE(get_bytes_per_element_test),
+	KUNIT_CASE(is_dual_plane_test),
+	KUNIT_CASE(get_blk_size_bytes_test),
+	{  }
+};
+
+static struct kunit_suite dcn20_rq_dlg_calc_20_test_suite = {
+	.name = "display_rq_dlg_calc_20",
+	.test_cases = dcn20_rq_dlg_calc_20_test_cases,
+};
+
+kunit_test_suites(&dcn20_rq_dlg_calc_20_test_suite);
-- 
2.37.0

