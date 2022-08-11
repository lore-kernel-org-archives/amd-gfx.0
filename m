Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340F2C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F401B97AA4;
	Thu, 11 Aug 2022 00:41:12 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CCC97AB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:40:56 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id j2so16903389vsp.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=cLlytlV290u98L3rGTcPbYM15C81gm5ChFOPwzLAQhQ=;
 b=JhqlNdWFvAa6n/rHo/i+pq4kPQ3gQDSalm3GWInUygZw/hj2RWc/tUnxzdwpgwdgfA
 /OgVP0V/Q8Kne29t9kFvodpENsckWOrCSWdZVS7w9+3/l0TlqIAuaoOe4APa/jud66Vf
 qgu2hQtmWzY1bJKI62T2w4nVPPWmA//CFpgKTYwAUN87qNQ+Ea8+yleY3St5/sMzpx+P
 lIwRlDrBMvrpPP3ljHrx6BKFT26AGlww2lXRUhsqzV6HqfTbmFBphZHYq7BjNQhupiVs
 vXHUIEvUbegPkf+hpVh0QlFe5A+cMiKMg9UVEXKep2XdsZFeLLkvb9VEhSec8oxR1jW8
 BiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=cLlytlV290u98L3rGTcPbYM15C81gm5ChFOPwzLAQhQ=;
 b=pUisVjBH4ynOLc8MyGak296yCjqsMpGXR5u2XcoJdSh6blRVCWZbM3n/es0Z5Zqvad
 Mg3DSpjX6FwOc7AkaRpSndCWR0aRxywfKEV7sxuSTTB21piDPFFhrEfrj1xLLYGO5+Tv
 y9RUc0mwzxxbb1uDTU3cDSeB7e/FWvfTf11f4gqXILoVuKj0i/NRkKPZHvEtOBlM6tCs
 JVB5gCYQ9og0NS2dNwwA5o9a5c9Of811ksEHtjooVfjCKFw7nSGn824lZuF+YI1mX7lK
 x3tjJ3KbNJD26K8Hj2S1ar1z6dKkzfgAoE8AwQR49LpUp8P0eBUBL7rOKFKiKGjq8Ql9
 m6Ig==
X-Gm-Message-State: ACgBeo1LMSdd/CRVzWKg8bFjqc7z+cvw0rfmCo2m4h1Hfz9lGRJSSTJ9
 IkcE0W5Kflq07mK9h8E37As=
X-Google-Smtp-Source: AA6agR6s/9c96IBvlbAZWB9+foqwFqXHyI5lj2xEO97Q3MSyDdLCIoBVoG/ekvPUk+bDwvZedPPhgg==
X-Received: by 2002:a67:26c4:0:b0:358:5195:fb40 with SMTP id
 m187-20020a6726c4000000b003585195fb40mr12760038vsm.0.1660178455082; 
 Wed, 10 Aug 2022 17:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:54 -0700 (PDT)
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
Subject: [PATCH 6/8] drm/amd/display: Introduce KUnit tests for dcn20_fpu
Date: Wed, 10 Aug 2022 21:40:08 -0300
Message-Id: <20220811004010.61299-7-tales.aparecida@gmail.com>
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

From: Magali Lemes <magalilemes00@gmail.com>

This commit adds unit tests to the functions dcn20_cap_soc_clocks and
dcn21_update_bw_bounding_box from dcn20/dcn20_fpu.

Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +
 .../tests/dc/dml/dcn20/dcn20_fpu_test.c       | 560 ++++++++++++++++++
 2 files changed, 564 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ca44df4fca74..ad30d6ef9603 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2390,3 +2390,7 @@ void dcn201_populate_dml_writeback_from_context_fpu(struct dc *dc,
 	}
 
 }
+
+#if IS_ENABLED(CONFIG_DML_KUNIT_TEST)
+#include "../../tests/dc/dml/dcn20/dcn20_fpu_test.c"
+#endif
diff --git a/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c
new file mode 100644
index 000000000000..71b1391cda91
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/dml/dcn20/dcn20_fpu_test.c
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: MIT
+/*
+ * KUnit tests for dml/dcn20/dcn20_fpu.h
+ *
+ * Copyright (C) 2022, Magali Lemes <magalilemes00@gmail.com>
+ */
+
+#include <kunit/test.h>
+
+#include "dc/inc/resource.h"
+#include "dc/inc/hw/clk_mgr.h"
+#include "dc/dcn21/dcn21_resource.h"
+
+#include "dml/dcn20/dcn20_fpu.h"
+
+/**
+ * DOC: Unit tests for AMDGPU DML dcn20/dcn20_fpu.h
+ */
+
+struct dcn20_cap_soc_clocks_test_case {
+	const char *desc;
+	struct _vcs_dpi_soc_bounding_box_st bb;
+	struct pp_smu_nv_clock_table max_clocks;
+	const int clock_states;
+	const struct _vcs_dpi_voltage_scaling_st expected_clock_limits[DC__VOLTAGE_STATES];
+};
+
+struct dcn21_update_bw_bounding_box_test_case {
+	const char *desc;
+	struct dc dc;
+	struct clk_bw_params bw_params;
+	const int clocks_to_compare;
+	const struct _vcs_dpi_voltage_scaling_st expected_clock_limits[DC__VOLTAGE_STATES];
+};
+
+struct dcn20_cap_soc_clocks_test_case dcn20_cap_soc_clocks_test_cases[] = {
+	{
+		.desc = "4-state bounding box clock limits ",
+		.bb = {
+			.clock_limits = {
+				{
+					.dcfclk_mhz = 506.0,
+					.fabricclk_mhz = 506.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 400.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 506.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 1600.0,
+				},
+				{
+					.dcfclk_mhz = 540.0,
+					.fabricclk_mhz = 540.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 540.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 8000.0,
+				},
+				{
+					.dcfclk_mhz = 675.0,
+					.fabricclk_mhz = 675.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 675.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 10000.0,
+				},
+				{
+					.dcfclk_mhz = 1265.0,
+					.fabricclk_mhz = 1266.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 1266.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 15000.0,
+				},
+			},
+			.num_states = 4,
+		},
+		.max_clocks = {
+			.dcfClockInKhz = 1265000,
+			.uClockInKhz = 875000,
+			.fabricClockInKhz = 0,
+			.displayClockInKhz = 1284000,
+			.dppClockInKhz = 0,
+			.phyClockInKhz = 810000,
+			.socClockInKhz = 1266000,
+			.dscClockInKhz = 0,
+		},
+		.clock_states = 4,
+		.expected_clock_limits = {
+			{
+				.dcfclk_mhz = 506.0,
+				.fabricclk_mhz = 506.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 506.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 1600.0,
+			},
+			{
+				.dcfclk_mhz = 540.0,
+				.fabricclk_mhz = 540.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 540.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 8000.0,
+			},
+			{
+				.dcfclk_mhz = 675.0,
+				.fabricclk_mhz = 675.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 675.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 10000.0,
+			},
+			{
+				.dcfclk_mhz = 1265.0,
+				.fabricclk_mhz = 1266.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 1266.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 14000.0,
+			},
+		},
+	},
+	{
+		.desc = "One duplicate clock state",
+		.bb = {
+			.clock_limits = {
+				{
+					.dcfclk_mhz = 506.0,
+					.fabricclk_mhz = 506.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 400.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 506.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 1600.0,
+				},
+				{
+					.dcfclk_mhz = 675.0,
+					.fabricclk_mhz = 675.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 675.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 10000.0,
+				},
+				{
+					.dcfclk_mhz = 675.0,
+					.fabricclk_mhz = 675.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 675.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 10000.0,
+				},
+				{
+					.dcfclk_mhz = 1265.0,
+					.fabricclk_mhz = 1266.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 1284.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 1266.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 15000.0,
+				},
+			},
+			.num_states = 4,
+		},
+		.max_clocks = {
+			.dcfClockInKhz = 1265000,
+			.uClockInKhz = 875000,
+			.fabricClockInKhz = 0,
+			.displayClockInKhz = 1284000,
+			.dppClockInKhz = 0,
+			.phyClockInKhz = 810000,
+			.socClockInKhz = 1266000,
+			.dscClockInKhz = 0,
+		},
+		.clock_states = 3,
+		.expected_clock_limits = {
+			{
+				.dcfclk_mhz = 506.0,
+				.fabricclk_mhz = 506.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 506.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 1600.0,
+			},
+			{
+				.dcfclk_mhz = 675.0,
+				.fabricclk_mhz = 675.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 675.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 10000.0,
+			},
+			{
+				.dcfclk_mhz = 675.0,
+				.fabricclk_mhz = 675.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 1284.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 675.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 10000.0,
+			},
+		},
+	},
+	{
+		.desc = "Zeroed max clocks",
+		.bb = {
+			.clock_limits = {
+				{
+					.dcfclk_mhz = 506.0,
+					.fabricclk_mhz = 506.0,
+					.dispclk_mhz = 1284.0,
+					.dppclk_mhz = 400.0,
+					.phyclk_mhz = 810.0,
+					.socclk_mhz = 506.0,
+					.dscclk_mhz = 428.0,
+					.dram_speed_mts = 1600.0,
+				},
+			},
+			.num_states = 1,
+		},
+		.max_clocks = {
+			.dcfClockInKhz = 0,
+			.uClockInKhz = 0,
+			.fabricClockInKhz = 0,
+			.displayClockInKhz = 0,
+			.dppClockInKhz = 0,
+			.phyClockInKhz = 0,
+			.socClockInKhz = 0,
+			.dscClockInKhz = 0,
+		},
+		.clock_states = 1,
+		.expected_clock_limits = {
+			{
+				.dcfclk_mhz = 506.0,
+				.fabricclk_mhz = 506.0,
+				.dispclk_mhz = 1284.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 506.0,
+				.dscclk_mhz = 428.0,
+				.dram_speed_mts = 1600.0,
+			},
+		},
+	},
+};
+
+struct dcn21_update_bw_bounding_box_test_case dcn21_update_bw_bounding_box_test_data[] = {
+	{
+		.desc = "5-entry bounding box clocks table",
+		.dc = {
+			.res_pool = &(struct resource_pool) {
+				.pipe_count = 2,
+				.res_cap = &(struct resource_caps) {
+					.num_timing_generator = 3
+				},
+			},
+		},
+		.bw_params = {
+			.num_channels = 1,
+			.clk_table = {
+				.entries = {
+					{
+						.voltage = 0,
+						.dcfclk_mhz = 200,
+						.fclk_mhz = 400,
+						.memclk_mhz = 800,
+						.socclk_mhz = 0,
+					},
+					{
+						.voltage = 0,
+						.dcfclk_mhz = 201,
+						.fclk_mhz = 800,
+						.memclk_mhz = 1600,
+						.socclk_mhz = 0,
+					},
+					{
+						.voltage = 0,
+						.dcfclk_mhz = 553,
+						.fclk_mhz = 1067,
+						.memclk_mhz = 1067,
+						.socclk_mhz = 0,
+					},
+					{
+						.voltage = 0,
+						.dcfclk_mhz = 602,
+						.fclk_mhz = 1333,
+						.memclk_mhz = 1600,
+						.socclk_mhz = 0,
+					},
+					{
+						.voltage = 0,
+						.dispclk_mhz = 1372,
+						.dppclk_mhz = 1372,
+						.phyclk_mhz = 810,
+						.phyclk_d18_mhz = 667,
+						.dtbclk_mhz = 600,
+					},
+				},
+
+				.num_entries = 5,
+			},
+		},
+		.expected_clock_limits = {
+			{
+				.state = 0,
+				.dcfclk_mhz = 200.0,
+				.fabricclk_mhz = 400.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 205.67,
+				.dram_speed_mts = 1600.0,
+			},
+			{
+				.state = 1,
+				.dcfclk_mhz = 200.0,
+				.fabricclk_mhz = 400.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 205.67,
+				.dram_speed_mts = 1600.0,
+			},
+			{
+				.state = 2,
+				.dcfclk_mhz = 201,
+				.fabricclk_mhz = 800.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 205.67,
+				.dram_speed_mts = 3200.0,
+			},
+			{
+				.state = 3,
+				.dcfclk_mhz = 553.0,
+				.fabricclk_mhz = 1067.0,
+				.dispclk_mhz = 757.89,
+				.dppclk_mhz = 685.71,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 287.67,
+				.dram_speed_mts = 2134.0,
+			},
+			{
+				.state = 4,
+				.dcfclk_mhz = 602.0,
+				.fabricclk_mhz = 1333.0,
+				.dispclk_mhz = 847.06,
+				.dppclk_mhz = 757.89,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 318.334,
+				.dram_speed_mts = 3200.0,
+			},
+			{
+				.state = 5,
+				.dcfclk_mhz = 0.0,
+				.fabricclk_mhz = 0.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 205.67,
+				.dram_speed_mts = 0.0,
+			},
+			{
+				.state = 6,
+				.dcfclk_mhz = 0.0,
+				.fabricclk_mhz = 0.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.0,
+				.phyclk_mhz = 600.0,
+				.socclk_mhz = 0.0,
+				.dscclk_mhz = 205.67,
+				.dram_speed_mts = 0.0,
+			},
+		},
+		.clocks_to_compare = 6,
+	},
+};
+
+/**
+ * dcn20_cap_soc_clocks_test - KUnit test for dcn20_cap_soc_clocks
+ * @test: represents a running instance of a test.
+ */
+static void dcn20_cap_soc_clocks_test(struct kunit *test)
+{
+	struct dcn20_cap_soc_clocks_test_case *test_param =
+		(struct dcn20_cap_soc_clocks_test_case *)test->param_value;
+	int i;
+
+	DC_FP_START();
+	dcn20_cap_soc_clocks(&test_param->bb, test_param->max_clocks);
+	DC_FP_END();
+
+	/* Check if no clock limit is higher than the specified maximum */
+	for (i = 0; i < test_param->bb.num_states; i++) {
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].dcfclk_mhz,
+				test_param->expected_clock_limits[i].dcfclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].fabricclk_mhz,
+				test_param->expected_clock_limits[i].fabricclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].dispclk_mhz,
+				test_param->expected_clock_limits[i].dispclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].dppclk_mhz,
+				test_param->expected_clock_limits[i].dppclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].phyclk_mhz,
+				test_param->expected_clock_limits[i].phyclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].socclk_mhz,
+				test_param->expected_clock_limits[i].socclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].dscclk_mhz,
+				test_param->expected_clock_limits[i].dscclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->bb.clock_limits[i].dram_speed_mts,
+				test_param->expected_clock_limits[i].dram_speed_mts);
+	}
+
+	KUNIT_EXPECT_EQ(test, test_param->clock_states, test_param->bb.num_states);
+}
+
+static struct _vcs_dpi_soc_bounding_box_st original_dcn2_1_soc;
+static struct _vcs_dpi_ip_params_st original_dcn2_1_ip;
+
+/**
+ * dcn20_fpu_dcn21_update_bw_bounding_box_test_init - Store backup copies of DCN global structures
+ * @test: represents a running instance of a test.
+ */
+int dcn20_fpu_dcn21_update_bw_bounding_box_test_init(struct kunit *test)
+{
+	memcpy(&original_dcn2_1_soc, &dcn2_1_soc, sizeof(struct _vcs_dpi_soc_bounding_box_st));
+	memcpy(&original_dcn2_1_ip, &dcn2_1_ip, sizeof(struct _vcs_dpi_ip_params_st));
+
+	return 0;
+}
+
+/**
+ * dcn20_fpu_dcn21_update_bw_bounding_box_test_exit - Restore original values
+ * of DCN global structures
+ * @test: represents a running instance of a test.
+ */
+static void dcn20_fpu_dcn21_update_bw_bounding_box_test_exit(struct kunit *test)
+{
+	memcpy(&dcn2_1_soc, &original_dcn2_1_soc, sizeof(struct _vcs_dpi_soc_bounding_box_st));
+	memcpy(&dcn2_1_ip, &original_dcn2_1_ip, sizeof(struct _vcs_dpi_ip_params_st));
+}
+
+/**
+ * dcn21_update_bw_bounding_box_test - KUnit test for dcn21_update_bw_bounding_box
+ * @test: represents a running instance of a test.
+ */
+static void dcn21_update_bw_bounding_box_test(struct kunit *test)
+{
+	struct dcn21_update_bw_bounding_box_test_case *test_param =
+		(struct dcn21_update_bw_bounding_box_test_case *)test->param_value;
+	int i;
+
+	DC_FP_START();
+	dcn21_update_bw_bounding_box(&test_param->dc, &test_param->bw_params);
+	DC_FP_END();
+
+	KUNIT_EXPECT_EQ(test, test_param->dc.res_pool->res_cap->num_timing_generator,
+			dcn2_1_ip.max_num_otg);
+	KUNIT_EXPECT_EQ(test, test_param->dc.res_pool->pipe_count, dcn2_1_ip.max_num_dpp);
+	KUNIT_EXPECT_EQ(test, test_param->bw_params.num_channels, dcn2_1_soc.num_chans);
+
+	for (i = 0; i <= test_param->clocks_to_compare; i++) {
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].state,
+				dcn2_1_soc.clock_limits[i].state);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].dcfclk_mhz,
+				dcn2_1_soc.clock_limits[i].dcfclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].fabricclk_mhz,
+				dcn2_1_soc.clock_limits[i].fabricclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].dispclk_mhz,
+				dcn2_1_soc.clock_limits[i].dispclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].dppclk_mhz,
+				dcn2_1_soc.clock_limits[i].dppclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].phyclk_mhz,
+				dcn2_1_soc.clock_limits[i].phyclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].socclk_mhz,
+				dcn2_1_soc.clock_limits[i].socclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].dscclk_mhz,
+				dcn2_1_soc.clock_limits[i].dscclk_mhz);
+		KUNIT_EXPECT_EQ(test, test_param->expected_clock_limits[i].dram_speed_mts,
+				dcn2_1_soc.clock_limits[i].dram_speed_mts);
+	}
+
+	if (test_param->bw_params.clk_table.num_entries)
+		KUNIT_EXPECT_EQ(test, test_param->bw_params.clk_table.num_entries,
+				dcn2_1_soc.num_states);
+}
+
+static void dcn20_cap_soc_clocks_test_to_desc(struct dcn20_cap_soc_clocks_test_case *t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+static void dcn21_update_bw_bounding_box_test_to_desc(struct dcn21_update_bw_bounding_box_test_case *t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+KUNIT_ARRAY_PARAM(dcn20_cap_soc_clocks,
+		  dcn20_cap_soc_clocks_test_cases,
+		  dcn20_cap_soc_clocks_test_to_desc);
+
+static struct kunit_case dcn20_fpu_test_cases[] = {
+	KUNIT_CASE_PARAM(dcn20_cap_soc_clocks_test, dcn20_cap_soc_clocks_gen_params),
+	{  }
+};
+
+static struct kunit_suite dcn20_fpu_test_suite = {
+	.name = "dml_dcn20_fpu",
+	.test_cases = dcn20_fpu_test_cases,
+};
+
+KUNIT_ARRAY_PARAM(dcn21_update_bw_bounding_box,
+		  dcn21_update_bw_bounding_box_test_data,
+		  dcn21_update_bw_bounding_box_test_to_desc);
+
+static struct kunit_case dcn20_fpu_dcn21_update_bw_bounding_box_test_cases[] = {
+	KUNIT_CASE_PARAM(dcn21_update_bw_bounding_box_test,
+			 dcn21_update_bw_bounding_box_gen_params),
+	{  }
+};
+
+static struct kunit_suite dcn21_update_bw_bounding_box_test_suite = {
+	.name = "dml_dcn20_fpu_dcn21_update_bw_bounding_box_test",
+	.init = dcn20_fpu_dcn21_update_bw_bounding_box_test_init,
+	.exit = dcn20_fpu_dcn21_update_bw_bounding_box_test_exit,
+	.test_cases = dcn20_fpu_dcn21_update_bw_bounding_box_test_cases,
+};
+
+kunit_test_suites(&dcn20_fpu_test_suite, &dcn21_update_bw_bounding_box_test_suite);
-- 
2.37.0

