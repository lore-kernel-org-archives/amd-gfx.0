Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DC8C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED40B112761;
	Thu, 11 Aug 2022 00:41:07 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B417A97A7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:50 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id 129so16866640vsq.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=yumtWw16ut9yxBBV4zua/gB81aa6CJBs8W8sqVgedBI=;
 b=J2vbNsTQtWc2bGhNzxhwlt6YOBzvQMBrEG2zrSdswNjTxZ+oa3DpiVKiIoxMaQ4jc3
 m/te4IoF0NFN1ISN4ZdKY3Vm/az0vSV+JR3ZDn81w7huX93/wzEz1eBX3r/U9dQdwiHn
 02OrAShYOxjEq5OWREyuyl9ZGwrZl0RfxSB6R3uuJc9xlShR2mWQn3SvcIQcp+MfQIC5
 QQ/rEOpEacXbz5ucOVjduV0aYt1vUBAgVZw31aqpqX41YQbaYrsBnMJCuVRwWhDChe/3
 4SRZ45d+ReluqCQQNNySzq1G4jD7WVJ3PDg97sD/YWe+jr96XET0SWRGw98wahKBKsLj
 t9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=yumtWw16ut9yxBBV4zua/gB81aa6CJBs8W8sqVgedBI=;
 b=xbh3wRvpwC3mji3HdyiNUiEvJpZuTO1oRFxmPQsUfq2ae2h0+6ofnJoijB6O0eZcmF
 saKz/ocnCwOF6PzJ8jQY3aVKAVj/rF5k8ypti+FavUblcfOQpYHulZFqtrDhpR7cCjvj
 yYjRVsHDY8eRiAR0p/PKtnaUgjM6Zcq79BUwYAtnbwmiTEgjl60ZAmeCHptg+D0SRbsv
 E5zSFpu1++ZQrCi/y2+cP+hKN4RHb1AeDT4TA3XKTdxFT/R2yNUPpW42Cq4gyjY+Mhrt
 t0S9ZI4STSsOLDdESTCOpyqECpKaXIJ3TYn7YU+dYNbpV1vXG9d7wlcUdNonw9bBGK2L
 3uEg==
X-Gm-Message-State: ACgBeo2RZFMPbTarEG3EcQZhl1gvjjd8I3AVVRIWWRyzh3OtHEFNdbmh
 48C94KU3LUawn1sO7EpxX1U=
X-Google-Smtp-Source: AA6agR4gLHq/07oLktZwn2wITr+Ef94zVK48r4yKnffpcc56VYmHUwAVCcguQYNAE7gVmcrhCBt/uw==
X-Received: by 2002:a67:a449:0:b0:357:3407:9f60 with SMTP id
 p9-20020a67a449000000b0035734079f60mr13383781vsh.17.1660178449719; 
 Wed, 10 Aug 2022 17:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:49 -0700 (PDT)
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
Subject: [PATCH 5/8] drm/amd/display: Introduce KUnit to
 dcn20/display_mode_vba_20 library
Date: Wed, 10 Aug 2022 21:40:07 -0300
Message-Id: <20220811004010.61299-6-tales.aparecida@gmail.com>
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
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Maíra Canal <mairacanal@riseup.net>

The display_mode_vba_20 deals with hundreds of display parameters for
the DCN20 and sometimes does it in odd ways. The addition of unit tests
intends to assure the quality of the code delivered by HW engineers and,
also make it possible to refactor the code decreasing concerns about adding
bugs to the codebase.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
 .../dc/dml/dcn20/display_mode_vba_20_test.c   | 227 ++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d3b5b6fedf04..738d8c1f5def 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -5112,3 +5112,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				locals->OutputBppPerState[mode_lib->vba.VoltageLevel][k];
 	}
 }
+
+#if IS_ENABLED(CONFIG_DML_KUNIT_TEST)
+#include "../../tests/dc/dml/dcn20/display_mode_vba_20_test.c"
+#endif
diff --git a/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c
new file mode 100644
index 000000000000..7abaf0a8d50a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/display_mode_vba_20_test.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: MIT
+/*
+ * KUnit tests for dml/dcn20/display_mode_vba_20.c
+ *
+ * Copyright (C) 2022, Maíra Canal <mairacanal@riseup.net>
+ */
+
+#include <kunit/test.h>
+#include "dml/display_mode_enums.h"
+
+static void DSC_compute_delay_test(struct kunit *test)
+{
+	/* 4:4:4 encoding */
+	KUNIT_EXPECT_EQ(test, dscComputeDelay(dm_444), 30);
+
+	/* 4:2:0 encoding */
+	KUNIT_EXPECT_EQ(test, dscComputeDelay(dm_420), 48);
+
+	/* 4:2:2 n-encoding */
+	KUNIT_EXPECT_EQ(test, dscComputeDelay(dm_n422), 49);
+
+	/* 4:2:2 s-encoding */
+	KUNIT_EXPECT_EQ(test, dscComputeDelay(dm_s422), 30);
+}
+
+static void calculate_TWait_test(struct kunit *test)
+{
+	/* Zeroed Prefetch Mode */
+
+	/* DRAMClockChangeLatency > UrgentLatencyPixelDataOnly > SREnterPlusExitTime*/
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1300000, 1200000, 1000000), 2500000);
+
+	/* DRAMClockChangeLatency > SREnterPlusExitTime > UrgentLatencyPixelDataOnly */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1300000, 900000, 1200000), 2200000);
+
+	/* UrgentLatencyPixelDataOnly > DRAMClockChangeLatency > SREnterPlusExitTime */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1000000, 2000000, 900000), 3000000);
+
+	/* UrgentLatencyPixelDataOnly > SREnterPlusExitTime > DRAMClockChangeLatency */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1000000, 1200000, 1100000), 2200000);
+
+	/* SREnterPlusExitTime > DRAMClockChangeLatency > UrgentLatencyPixelDataOnly */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1000000, 900000, 2000000), 2000000);
+
+	/* SREnterPlusExitTime > UrgentLatencyPixelDataOnly > DRAMClockChangeLatency */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(0, 1000000, 1200000, 1300000), 2200000);
+
+	/* Prefetch Mode equals 1 */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 2500000, 2000000, 900000), 2000000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 1300000, 900000, 1200000), 1200000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 1100000, 1200000, 1000000), 1200000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 1000000, 1200000, 1100000), 1200000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 1000000, 900000, 2000000), 2000000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 1000000, 1200000, 1300000), 1300000);
+
+	/* Prefetch Mode greater than 1 */
+	KUNIT_EXPECT_EQ(test, CalculateTWait(1, 2500000, 2000000, 900000), 2000000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(2, 2500000, 900000, 2000000), 900000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(5, 1100000, 1200000, 1000000), 1200000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(4, 1000000, 1300000, 1200000), 1300000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(6, 1000000, 900000, 2000000), 900000);
+	KUNIT_EXPECT_EQ(test, CalculateTWait(3, 1000000, 1200000, 1300000), 1200000);
+}
+
+static void trunc_to_valid_BPP_test(struct kunit *test)
+{
+	/* HDMI output for 4:2:0 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18.01, true, dm_hdmi, dm_420, 0), 18);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18, true, dm_hdmi, dm_420, 10), 18);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15.01, false, dm_hdmi, dm_420, 0), 15);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15, false, dm_hdmi, dm_420, 8), 15);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(12.01, true, dm_hdmi, dm_420, 0), 12);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(12, true, dm_hdmi, dm_420, 5), 12);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.99, false, dm_hdmi, dm_420, 5), BPP_INVALID);
+
+	/* HDMI output for 4:2:0 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36.01, true, dm_hdmi, dm_444, 0), 36);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36, true, dm_hdmi, dm_444, 10), 36);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30.01, false, dm_hdmi, dm_444, 0), 30);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30, false, dm_hdmi, dm_444, 8), 30);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24.01, true, dm_hdmi, dm_444, 0), 24);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24, true, dm_hdmi, dm_444, 5), 24);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18.01, true, dm_hdmi, dm_444, 0), 18);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18, true, dm_hdmi, dm_444, 5), 18);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.99, false, dm_hdmi, dm_444, 5), BPP_INVALID);
+
+	/* HDMI output for different encoding types */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36.01, true, dm_hdmi, dm_n422, 0), 24);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36, true, dm_hdmi, dm_s422, 10), 24);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30.01, false, dm_hdmi, dm_n422, 0), 20);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30, false, dm_hdmi, dm_s422, 8), 20);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24.01, true, dm_hdmi, dm_n422, 0), 16);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24, true, dm_hdmi, dm_s422, 5), 16);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15.99, false, dm_hdmi, dm_n422, 5), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, true, dm_hdmi, dm_s422, 0), BPP_INVALID);
+
+	/* Display Port output with DSC enabled and 4:2:0 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(5.99, true, dm_dp, dm_420, 0), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, true, dm_dp, dm_420, 0), BPP_INVALID);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(12, true, dm_dp, dm_420, 8), 12);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(1.5 * 8 - 1 / (double)16, true, dm_dp, dm_420, 8), 11);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(7, true, dm_dp, dm_420, 3), 4);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(1.5 * 9 - 1 / (double)16, true, dm_dp, dm_420, 9), 13);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6, true, dm_dp, dm_420, 8), 6);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6.25, true, dm_dp, dm_420, 8), 6);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6 + 1 / (double)3, true, dm_dp, dm_420, 8), 6);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6.50, true, dm_dp, dm_420, 8), 6);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6.75, true, dm_dp, dm_420, 8), 6);
+
+	/* Embedded Display Port output with DSC enabled and n-4:2:2 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(6.99, true, dm_edp, dm_n422, 0), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, true, dm_edp, dm_n422, 0), BPP_INVALID);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(16, true, dm_edp, dm_n422, 7), 14);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(2 * 7 - 1 / (double)16, true, dm_edp, dm_n422, 7), 13);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(7, true, dm_edp, dm_n422, 3), 6);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(2 * 9 - 1 / (double)16, true, dm_edp, dm_n422, 9), 17);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11, true, dm_edp, dm_n422, 8), 11);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11 + 1 / (double)3, true, dm_edp, dm_n422, 8), 11);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.40, true, dm_edp, dm_n422, 8), 11);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.50, true, dm_edp, dm_n422, 8), 11);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.75, true, dm_edp, dm_n422, 8), 11);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.95, true, dm_edp, dm_n422, 8), 11);
+
+	/* Display Port 2.0 output with DSC enabled and 4:4:4 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(7.99, true, dm_dp2p0, dm_444, 0), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, true, dm_dp2p0, dm_444, 0), BPP_INVALID);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(22, true, dm_dp2p0, dm_444, 11), 22);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(3 * 7 - 1 / (double)16, true, dm_dp2p0, dm_444, 7), 20);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(14, true, dm_dp2p0, dm_444, 3), 9);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(3 * 9 - 1 / (double)16, true, dm_dp2p0, dm_444, 9), 26);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17, true, dm_dp2p0, dm_444, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17 + 1 / (double)3, true, dm_dp2p0, dm_444, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.40, true, dm_dp2p0, dm_444, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.50, true, dm_dp2p0, dm_444, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.75, true, dm_dp2p0, dm_444, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.95, true, dm_dp2p0, dm_444, 7), 17);
+
+	/* WB output with DSC enabled and 4:2:2 s-encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(7.99, true, dm_wb, dm_s422, 0), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, true, dm_wb, dm_s422, 0), BPP_INVALID);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(22, true, dm_wb, dm_s422, 11), 22);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(3 * 7 - 1 / (double)16, true, dm_wb, dm_s422, 7), 20);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18, true, dm_wb, dm_s422, 3), 9);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(3 * 9 - 1 / (double)16, true, dm_wb, dm_s422, 9), 26);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17, true, dm_wb, dm_s422, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17 + 1 / (double)3, true, dm_wb, dm_s422, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.40, true, dm_wb, dm_s422, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.50, true, dm_wb, dm_s422, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.75, true, dm_wb, dm_s422, 7), 17);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.95, true, dm_wb, dm_s422, 7), 17);
+
+	/* Display Port output with DSC disabled for 4:2:0 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18.01, false, dm_dp, dm_420, 0), 18);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18, false, dm_dp, dm_420, 10), 18);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15.01, false, dm_dp, dm_420, 0), 15);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15, false, dm_dp, dm_420, 8), 15);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(12.01, false, dm_dp, dm_420, 0), 12);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(12, false, dm_dp, dm_420, 5), 12);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(11.99, false, dm_dp, dm_420, 5), BPP_INVALID);
+
+	/* Embedded Display Port output with DSC disabled for 4:2:2 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24.01, false, dm_edp, dm_s422, 0), 24);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24, false, dm_edp, dm_n422, 10), 24);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(20.01, false, dm_edp, dm_s422, 0), 20);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(20, false, dm_edp, dm_n422, 8), 20);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(16.01, false, dm_edp, dm_s422, 0), 16);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(16, false, dm_edp, dm_n422, 5), 16);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(15.99, false, dm_edp, dm_s422, 5), BPP_INVALID);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(-1, false, dm_edp, dm_n422, 5), BPP_INVALID);
+
+	/* WB output with DSC disabled for 4:4:4 encoding */
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36.01, false, dm_wb, dm_444, 0), 36);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(36, false, dm_wb, dm_444, 10), 36);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30.01, false, dm_wb, dm_444, 0), 30);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(30, false, dm_wb, dm_444, 8), 30);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24.01, false, dm_wb, dm_444, 0), 24);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(24, false, dm_wb, dm_444, 5), 24);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18.01, false, dm_wb, dm_444, 0), 18);
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(18, false, dm_wb, dm_444, 5), 18);
+
+	KUNIT_EXPECT_EQ(test, TruncToValidBPP(17.99, false, dm_wb, dm_444, 5), BPP_INVALID);
+}
+
+static struct kunit_case display_mode_vba_20_cases[] = {
+	KUNIT_CASE(DSC_compute_delay_test),
+	KUNIT_CASE(calculate_TWait_test),
+	KUNIT_CASE(trunc_to_valid_BPP_test),
+	{  }
+};
+
+static struct kunit_suite display_mode_vba_20_suite = {
+	.name = "display_mode_vba_20",
+	.test_cases = display_mode_vba_20_cases,
+};
+
+kunit_test_suite(display_mode_vba_20_suite);
-- 
2.37.0

