Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54B8C00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 00:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1918811AE96;
	Thu, 11 Aug 2022 00:41:17 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7363691E2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 00:41:01 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id q190so16869541vsb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=qsPellQYxcROZ/lwvYyERP958oYpxp25CA4jCAlbS/w=;
 b=NXEdrrUtxlhFwma0fplX+Fa7V7advm0PtZZf7SPem+mgeJEUuzR2RSoZX+7C3UKMhM
 u9/uTyhoKdHyRrQaP1qF4qN9cHnmL5M7Ybd4KFou6mQfcwZEp7Oq4BeI7fr9LkHJEayg
 rLxIlm5uuTlEtqNyCwkgeWp4SyIFSljHysHFbxcMY0VyEL9CtN3U1J9RBVh/FNsabHhM
 I5UXHsO0r/3esZ8dGYBfFveFXGuLbJWPph5423xeUWJA+S7vVeq0sgp+QvGDj43hhHmz
 2e3JNEUE123U2t7y/2uiMmpNa21VMQywZhgvAxap7dB1FsIyMqVu2z24TMujeF0VmQOk
 6NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=qsPellQYxcROZ/lwvYyERP958oYpxp25CA4jCAlbS/w=;
 b=zaTEbJzfudV34n1aDLN2vCQBpSsMrvoN9u9BxvkkF5sfbBYgE5NpyYK6de83nfbsXE
 lfeNeESjd8A0xo8QyhTjZ46xFAFrpX/vZMME/PjpwbmRWFyoUcVCgx/2W+F03d3wKiej
 uUY5qN75fdeq/BbB+FcfGwtlcmNxnWgERw831+nOD8WcusxJrtavtei11vB8zBMX8LDb
 lj/+g5Ym3h5ef2Z5BegAhyG44ZVOK3HkbBdNmxLiopVWr3RORXCjhk4iboKtXo+GdVWI
 zKJUor7V4B5NH8NyBvIf922bpObNIZqbLUsPBOafvLrExO6cFGck/7h57aPlrn6tXdN6
 ZB9w==
X-Gm-Message-State: ACgBeo1qb74bCUFxi/MMtT5X5RfBtIQDXA/qSebkL/3LPe3rooy5/Q0X
 zpwDvSg00eBQA7rNRS4qkzM=
X-Google-Smtp-Source: AA6agR4J4rSVFjB8b4WHH4Y7qCBlxQZBUu+pZxqhW5D2ZnZ3ivR2Qj79vYklrq7zW4uHzSw2u4dOlA==
X-Received: by 2002:a05:6102:e42:b0:36f:94fa:5ede with SMTP id
 p2-20020a0561020e4200b0036f94fa5edemr12564568vst.47.1660178460342; 
 Wed, 10 Aug 2022 17:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
 by smtp.gmail.com with ESMTPSA id
 z188-20020a1fc9c5000000b003791113188csm893072vkf.55.2022.08.10.17.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 17:40:59 -0700 (PDT)
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
Subject: [PATCH 7/8] drm/amd/display: Introduce KUnit tests to dc_dmub_srv
 library
Date: Wed, 10 Aug 2022 21:40:09 -0300
Message-Id: <20220811004010.61299-8-tales.aparecida@gmail.com>
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

Add unit test to the SubVP feature in order to avoid possible
regressions and assure the code robustness.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
 .../amd/display/tests/dc/dc_dmub_srv_test.c   | 285 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2d61c2a91cee..f5dd1f69840e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -809,3 +809,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 		diag_data.is_cw0_enabled,
 		diag_data.is_cw6_enabled);
 }
+
+#if IS_ENABLED(CONFIG_AMD_DC_BASICS_KUNIT_TEST)
+#include "../tests/dc/dc_dmub_srv_test.c"
+#endif
diff --git a/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
new file mode 100644
index 000000000000..051079cbf65e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/tests/dc/dc_dmub_srv_test.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: MIT
+/*
+ * KUnit tests for dc_dmub_srv.c
+ *
+ * Copyright (C) 2022, Maíra Canal <mairacanal@riseup.net>
+ */
+
+#include <kunit/test.h>
+#include "dc_dmub_srv.h"
+
+struct populate_subvp_cmd_drr_info_test_case {
+	const char *desc;
+	struct dc *dc;
+	struct pipe_ctx *subvp_pipe;
+	struct pipe_ctx *vblank_pipe;
+	const u8 drr_in_use;
+	const u8 drr_window_size_ms;
+	const u16 min_vtotal_supported;
+	const u16 max_vtotal_supported;
+	const u8 use_ramping;
+};
+
+struct populate_subvp_cmd_drr_info_test_case populate_subvp_cmd_drr_info_cases[] = {
+	{
+		.desc = "Same Clock Frequency",
+		.dc = &(struct dc) {
+			.caps = {
+				.subvp_prefetch_end_to_mall_start_us = 0,
+			}
+		},
+		.subvp_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 2784,
+					.v_addressable = 1080,
+					.pix_clk_100hz = 1855800,
+				},
+				.mall_stream_config = {
+					.paired_stream = &(struct dc_stream_state) {
+						.timing = {
+							.h_total = 3600,
+							.v_total = 1111,
+							.v_addressable = 1080,
+							.v_front_porch = 3,
+							.pix_clk_100hz = 1855800,
+						},
+					},
+				},
+			},
+		},
+		.vblank_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 2784,
+					.v_total = 1111,
+					.v_addressable = 1080,
+					.pix_clk_100hz = 1855800,
+				},
+			},
+		},
+		.drr_in_use = true,
+		.use_ramping = false,
+		.drr_window_size_ms = 4,
+		.min_vtotal_supported = 2540,
+		.max_vtotal_supported = 2619,
+	},
+	{
+		.desc = "Same Clock Frequency with Prefetch End to Mall Start",
+		.dc = &(struct dc) {
+			.caps = {
+				.subvp_prefetch_end_to_mall_start_us = 500,
+			}
+		},
+		.subvp_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 2784,
+					.v_addressable = 1080,
+					.pix_clk_100hz = 1855800,
+				},
+				.mall_stream_config = {
+					.paired_stream = &(struct dc_stream_state) {
+						.timing = {
+							.h_total = 3600,
+							.v_total = 1111,
+							.v_addressable = 1080,
+							.v_front_porch = 3,
+							.pix_clk_100hz = 1855800,
+						},
+					},
+				},
+			},
+		},
+		.vblank_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 2784,
+					.v_total = 1111,
+					.v_addressable = 1080,
+					.pix_clk_100hz = 1855800,
+				},
+			},
+		},
+		.drr_in_use = true,
+		.use_ramping = false,
+		.drr_window_size_ms = 4,
+		.min_vtotal_supported = 2540,
+		.max_vtotal_supported = 2619,
+	},
+	{
+		.desc = "Same Clock Frequency Not Multiple of 2",
+		.dc = &(struct dc) {
+			.caps = {
+				.subvp_prefetch_end_to_mall_start_us = 0,
+			}
+		},
+		.subvp_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 2784,
+					.v_addressable = 1080,
+					.pix_clk_100hz = 1866743,
+				},
+				.mall_stream_config = {
+					.paired_stream = &(struct dc_stream_state) {
+						.timing = {
+							.h_total = 3600,
+							.v_total = 2400,
+							.v_addressable = 2360,
+							.v_front_porch = 4,
+							.pix_clk_100hz = 1866743,
+						},
+					},
+				},
+			},
+		},
+		.vblank_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 3600,
+					.v_total = 2400,
+					.v_addressable = 2360,
+					.pix_clk_100hz = 1866743,
+				},
+			},
+		},
+		.drr_in_use = true,
+		.use_ramping = false,
+		.drr_window_size_ms = 4,
+		.min_vtotal_supported = 1387,
+		.max_vtotal_supported = 2875,
+	},
+	{
+		.desc = "Different Clock Frequency for smaller h_total and v_total",
+		.dc = &(struct dc) {
+			.caps = {
+				.subvp_prefetch_end_to_mall_start_us = 300,
+			}
+		},
+		.subvp_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 1280,
+					.v_addressable = 600,
+					.pix_clk_100hz = 1855800,
+				},
+				.mall_stream_config = {
+					.paired_stream = &(struct dc_stream_state) {
+						.timing = {
+							.h_total = 1280,
+							.v_total = 720,
+							.v_addressable = 600,
+							.v_front_porch = 4,
+							.pix_clk_100hz = 1866743,
+						},
+					},
+				},
+			},
+		},
+		.vblank_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 1280,
+					.v_total = 720,
+					.v_addressable = 600,
+					.pix_clk_100hz = 2100800,
+				},
+			},
+		},
+		.drr_in_use = true,
+		.use_ramping = false,
+		.drr_window_size_ms = 4,
+		.min_vtotal_supported = 1477,
+		.max_vtotal_supported = 9954,
+	},
+	{
+		.desc = "Different Clock Frequency for approximately 1920x1080",
+		.dc = &(struct dc) {
+			.caps = {
+				.subvp_prefetch_end_to_mall_start_us = 0,
+			}
+		},
+		.subvp_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 1920,
+					.v_addressable = 1000,
+					.pix_clk_100hz = 1855800,
+				},
+				.mall_stream_config = {
+					.paired_stream = &(struct dc_stream_state) {
+						.timing = {
+							.h_total = 1911,
+							.v_total = 1080,
+							.v_addressable = 1000,
+							.v_front_porch = 7,
+							.pix_clk_100hz = 1866743,
+						},
+					},
+				},
+			},
+		},
+		.vblank_pipe = &(struct pipe_ctx) {
+			.stream = &(struct dc_stream_state) {
+				.timing = {
+					.h_total = 1280,
+					.v_total = 720,
+					.v_addressable = 600,
+					.pix_clk_100hz = 2100800,
+				},
+			},
+		},
+		.drr_in_use = true,
+		.use_ramping = false,
+		.drr_window_size_ms = 4,
+		.min_vtotal_supported = 2482,
+		.max_vtotal_supported = 8971,
+	},
+};
+
+static void populate_subvp_cmd_drr_info_test_to_desc(struct
+		populate_subvp_cmd_drr_info_test_case * t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr_info_cases,
+		  populate_subvp_cmd_drr_info_test_to_desc);
+
+static void populate_subvp_cmd_drr_info_test(struct kunit *test)
+{
+	const struct populate_subvp_cmd_drr_info_test_case *test_param =
+		test->param_value;
+	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data;
+
+	pipe_data = kunit_kzalloc(test,
+				  sizeof(struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2),
+				  GFP_KERNEL);
+
+	populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
+				    test_param->vblank_pipe, pipe_data);
+
+	KUNIT_EXPECT_EQ(test, test_param->drr_in_use,
+			pipe_data->pipe_config.vblank_data.drr_info.drr_in_use);
+	KUNIT_EXPECT_EQ(test, test_param->drr_window_size_ms,
+			pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms);
+	KUNIT_EXPECT_EQ(test, test_param->use_ramping,
+			pipe_data->pipe_config.vblank_data.drr_info.use_ramping);
+	KUNIT_EXPECT_EQ(test, test_param->min_vtotal_supported,
+			pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported);
+	KUNIT_EXPECT_EQ(test, test_param->max_vtotal_supported,
+			pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported);
+}
+
+static struct kunit_case dc_dmub_srv_cases[] = {
+	KUNIT_CASE_PARAM(populate_subvp_cmd_drr_info_test, populate_subvp_cmd_drr_info_gen_params),
+	{  }
+};
+
+static struct kunit_suite dc_dmub_srv_suite = {
+	.name = "dc_dmub_srv",
+	.test_cases = dc_dmub_srv_cases,
+};
+
+kunit_test_suite(dc_dmub_srv_suite);
-- 
2.37.0

