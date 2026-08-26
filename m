Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D67C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8300D10EE67;
	Wed, 26 Aug 2026 23:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2tbwz3r";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A69110EE66
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6yM6sMbve7I1VeqvqFiQtSJ5x7qImbkvXtHwxzE/ExwhQIoeR3apvIRx7puqt6C3/0LWqHS7W8TtI7MV4kgeMg22g697ME24vIBane0TbcrbIYB0WPbkmN5bOU/0t30Q7lFhpOHtqf6JzpzryJRB9821RIPydz4lRx6vZTmRYqxUgqfof5Yh/zyrr/NRSTn5K7V9LlMxIShbzLgUsCjAXCqkBLDRJHzxCXrD6yCggrY8XIbHs2FiiNzRV1KrsQrcxn1dDSbjAe19esEeZIMuDPokfjRxe/49rnWUmbweZOyd+lPIm8pmdnXpQvt1PsJuQDHKq3dydRkb30uqtgPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jhuoP6T/JOTU8bwIcBmIqxoJFwj2QhWcD3ydlZpSpM=;
 b=yfd+xTM11AJzXjdmkDGNDSTaBwBbpT+j+s/XZMwcAHMZeIgVGCQn1BaVdWL4944XOyeKXLC/UO25riiXf4EyYQKgB2cerEbf140QWNBd89zk1kT7uhzYjr+ybiala3K2ebbHIK2i7H26zD7rdlXP4bHno0ANqRO7E8QcHgagPqs6ejc+TZwn9++tvPnCnj8OsgoK6mHmEcq+37rE/GEjG0XUrojDS4YAcGvNxqZo9WI/KF0tI0OVz7mSuqvuFmx/c5SJkgfqd//5N0X8LNUIcQS8g2/dEZhmOJ8Gq6qBdtUOcTdUJ/prhelRkOuAmu7hKCp4lT0HTyislyqjeg92MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jhuoP6T/JOTU8bwIcBmIqxoJFwj2QhWcD3ydlZpSpM=;
 b=d2tbwz3rKPotSQhOvFNoHKLkFPg+9StIdHndztK8JaFVpthHordoxfi7VIfjjlLbG8W05Yo6YO4h2693WbCFVCjyYhFkGASVuPmXbVOI7f8yseqxMRrLxPy5drGlx9BrpT9FdpERjCn8Dvi9am3xtELZkMpmzmBil4X5XzFhk0E=
Received: from PH7P220CA0159.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::28)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:33:45 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::89) by PH7P220CA0159.outlook.office365.com
 (2603:10b6:510:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:33:44 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:33:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 53/59] drm/amd/display: Test DC plane info fill
Date: Wed, 26 Aug 2026 17:05:24 -0600
Message-ID: <20260826231519.881949-54-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8464f0a4-80b1-451a-59dd-08df03ca7890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: hIqQIgprGh/iTyOk7nrNw0UivvhrEtT6l7EoHC336+oDQX4ZIGacRD3TuKLDQJXdMmuRLXUgBg6/ZyGhNhXIAUr5aDdJnujFsJ6xtUgwqc2K5m2yd+r6YCC7ygAaOZE9DigdCFTKLRnV0c7Ve9YC6mK/Gk3Q+kC/0FoC1huoCqWKEZiMe4HcdOWiGaTfiWTivh1R5UZ0n10EMzGLtVhaQHD7Z8BcIYVTF4qB/EdTM3NOkx8ZQ9iwPP7ZO1y95pMQ60heYlRez4BDB1d45ryj7TP9gIP/Cz8ospnaswommAoo5Inoy5lU9wY9umrLMgDw3yDoLQAf2VHAKuRUWoSswt1AfcRzPgzkAhZhRE9rI0jsqbah5sAPeePh/xRhAAOExOJsbsfXgevmu4TJEwPmqCvEAVl6XsoUs34s1bFjoaCGQJdq84yeEMmxBwEZ/aZ/vpPlUd1aZBDs3GRWE4ou0yVpPhcWoA9HBgr7pCu3nuQn1T2Vp/o3f/OxJ3csHc+BoLgifm+LxS2u9hlozw2ylr+8GmEmgqrYKcQaXeGmKn26P+58fgFBUcerk4bwT3mgR4PncLJgQgPKK00ELgjz9g7hyjGF8eZZdsDVrQXGImkBMS3wKK4VDhayLA8x/2xCILNR13AZBCQvHStfGI5ZEUk/+zBoAZmHSIv4pv3e4LlWHD/8ltoK1tf12TQVuW4Kv5HyzOQ5+hLO6OQWvq0+KA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lS4xSR4y55D3uMTpJbiX2dRRlL4nPHy1wgx8K6MkEEO2J77pI2n7sn06IY551h0oWgGIZM+rlpdxZ+GxK/KoxlpddnCrrmIpOuf7dImeGwN14I6t3bhYV5H2ox52U9Yp7UEhfsYXYW0mFhwjo9UBmY3A2kH1l1/NFNsNWvCmX4KG7Y97JFV13xQBBibzvdCGD1/6ZTnxULWJBtRNvDK+7951Ip5uGBIb8TucS9yDC2aIb04NxlJ5lRCsGtN4c5FBuTvUA5e5kxvbljiPK4W6oDMnK24iHBH+UFLgxm1jAQlDRjrJsKNhYcqIGoGdID3aVLLU2sEKInbHCyRyNYt8vzRDvRAILuQMoGVF3zlgT5bkafHk8hJkxGcGG8chPvvJsS4nvFcOgCFfRCheh0UuPfxKTFuQjg7stSnzHxyVHqhqlmIF3H7sk+CZf36W40Nq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:33:44.9981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8464f0a4-80b1-451a-59dd-08df03ca7890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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

[WHAT]
Add KUnit tests for fill_dc_plane_info_and_addr(), covering every
graphics and video pixel format mapping, all rotations, the unsupported
format and invalid colour encoding rejections, and the z-order and
blending forwarding.

[HOW]
A linear GFX9 framebuffer is the simplest input that lets the buffer
attribute helper succeed, so the format switch can be walked without a
live display core.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 246 ++++++++++++++++++
 3 files changed, 254 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ac4711b62e7..8a87677b46b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2958,7 +2958,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 }
 EXPORT_IF_KUNIT(fill_plane_color_attributes);
 
-static int
+STATIC_IFN_KUNIT int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
 			    struct dc_plane_info *plane_info,
@@ -3072,6 +3072,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(fill_dc_plane_info_and_addr);
 
 static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 				    struct dc_plane_state *dc_plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 88fa4292c5cf..09ecca519b3b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1249,12 +1249,18 @@ struct amdgpu_dm_kunit_ops {
 void amdgpu_dm_kunit_set_ops(const struct amdgpu_dm_kunit_ops *ops);
 
 struct dc_phy_addr_space_config;
+struct dc_plane_address;
 struct dc_plane_cap;
+struct dc_plane_info;
 
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 int dm_early_init(struct amdgpu_ip_block *ip_block);
+int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+				const struct drm_plane_state *plane_state,
+				struct dc_plane_info *plane_info,
+				struct dc_plane_address *address, bool tmz_surface);
 int load_dmcu_fw(struct amdgpu_device *adev);
 int dm_sw_init(struct amdgpu_ip_block *ip_block);
 int dm_late_init(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 7d0b5d8f06a1..0fe19a66e6f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -12,6 +12,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_modeset_lock.h>
@@ -3563,6 +3564,244 @@ static void dm_test_init_power_module_alloc_failure(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.power_module);
 }
 
+/* Tests for fill_dc_plane_info_and_addr() */
+
+struct dm_test_plane_info_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_framebuffer *afb;
+	struct drm_plane *plane;
+	struct dm_plane_state *dm_plane_state;
+	struct drm_plane_state *plane_state;
+	struct dc_plane_info plane_info;
+	struct dc_plane_address address;
+};
+
+/*
+ * A linear GFX9 framebuffer of @drm_format bound to an unrotated plane, which
+ * is the simplest input that lets the buffer attribute helper succeed. @adev is
+ * passed in because a test may only allocate one mock DRM device.
+ */
+static struct dm_test_plane_info_ctx *
+dm_test_plane_info_ctx_alloc(struct kunit *test, struct amdgpu_device *adev,
+			     u32 drm_format)
+{
+	struct dm_test_plane_info_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = adev;
+	ctx->afb = kunit_kzalloc(test, sizeof(*ctx->afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->afb);
+	ctx->plane = kunit_kzalloc(test, sizeof(*ctx->plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->plane);
+	ctx->dm_plane_state = kunit_kzalloc(test, sizeof(*ctx->dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_plane_state);
+	ctx->plane_state = &ctx->dm_plane_state->base;
+
+	ctx->adev->family = AMDGPU_FAMILY_NV;
+	ctx->adev->ip_versions[GC_HWIP][0] = IP_VERSION(10, 3, 0);
+
+	ctx->afb->address = 0x80000000ULL;
+	ctx->afb->base.width = 1920;
+	ctx->afb->base.height = 1080;
+	ctx->afb->base.offsets[1] = 0x200000;
+	ctx->afb->base.pitches[0] = 1920 * 4;
+	ctx->afb->base.pitches[1] = 1920 * 4;
+	ctx->afb->base.modifier = DRM_FORMAT_MOD_LINEAR;
+	ctx->afb->base.format = drm_format_info(drm_format);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->afb->base.format);
+
+	ctx->plane->dev = &ctx->adev->ddev;
+	ctx->plane_state->plane = ctx->plane;
+	ctx->plane_state->fb = &ctx->afb->base;
+	ctx->plane_state->rotation = DRM_MODE_ROTATE_0;
+	ctx->plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
+	ctx->plane_state->src_w = 1920 << 16;
+	ctx->plane_state->src_h = 1080 << 16;
+	ctx->plane_state->crtc_w = 1920;
+	ctx->plane_state->crtc_h = 1080;
+
+	return ctx;
+}
+
+static int dm_test_fill_plane_info(struct dm_test_plane_info_ctx *ctx)
+{
+	return fill_dc_plane_info_and_addr(ctx->adev, ctx->plane_state,
+					   &ctx->plane_info, &ctx->address, false);
+}
+
+static const struct {
+	u32 drm_format;
+	enum surface_pixel_format dc_format;
+} dm_test_plane_graphics_formats[] = {
+	{ DRM_FORMAT_C8, SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS },
+	{ DRM_FORMAT_RGB565, SURFACE_PIXEL_FORMAT_GRPH_RGB565 },
+	{ DRM_FORMAT_XRGB8888, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 },
+	{ DRM_FORMAT_ARGB8888, SURFACE_PIXEL_FORMAT_GRPH_ARGB8888 },
+	{ DRM_FORMAT_XRGB2101010, SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010 },
+	{ DRM_FORMAT_ARGB2101010, SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010 },
+	{ DRM_FORMAT_XBGR2101010, SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010 },
+	{ DRM_FORMAT_ABGR2101010, SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010 },
+	{ DRM_FORMAT_XBGR8888, SURFACE_PIXEL_FORMAT_GRPH_ABGR8888 },
+	{ DRM_FORMAT_ABGR8888, SURFACE_PIXEL_FORMAT_GRPH_ABGR8888 },
+	{ DRM_FORMAT_XRGB16161616F, SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F },
+	{ DRM_FORMAT_ARGB16161616F, SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F },
+	{ DRM_FORMAT_XBGR16161616F, SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F },
+	{ DRM_FORMAT_ABGR16161616F, SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F },
+	{ DRM_FORMAT_XRGB16161616, SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 },
+	{ DRM_FORMAT_ARGB16161616, SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 },
+	{ DRM_FORMAT_XBGR16161616, SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 },
+	{ DRM_FORMAT_ABGR16161616, SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 },
+};
+
+/**
+ * dm_test_plane_info_graphics_formats - Test every graphics format mapping
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_graphics_formats(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dm_test_plane_graphics_formats); i++) {
+		u32 fmt = dm_test_plane_graphics_formats[i].drm_format;
+		struct dm_test_plane_info_ctx *ctx;
+
+		ctx = dm_test_plane_info_ctx_alloc(test, adev, fmt);
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_test_fill_plane_info(ctx), 0,
+				    "format %p4cc", &fmt);
+		KUNIT_EXPECT_EQ_MSG(test, (int)ctx->plane_info.format,
+				    (int)dm_test_plane_graphics_formats[i].dc_format,
+				    "format %p4cc", &fmt);
+		/* Graphics formats ignore the DRM colour properties. */
+		KUNIT_EXPECT_EQ(test, (int)ctx->plane_info.color_space,
+				(int)COLOR_SPACE_SRGB);
+	}
+}
+
+static const struct {
+	u32 drm_format;
+	enum surface_pixel_format dc_format;
+} dm_test_plane_video_formats[] = {
+	{ DRM_FORMAT_NV21, SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr },
+	{ DRM_FORMAT_NV12, SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb },
+	{ DRM_FORMAT_P010, SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb },
+};
+
+/**
+ * dm_test_plane_info_video_formats - Test every video format mapping
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_video_formats(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(dm_test_plane_video_formats); i++) {
+		u32 fmt = dm_test_plane_video_formats[i].drm_format;
+		struct dm_test_plane_info_ctx *ctx;
+
+		ctx = dm_test_plane_info_ctx_alloc(test, adev, fmt);
+		ctx->plane_state->color_encoding = DRM_COLOR_YCBCR_BT709;
+		ctx->plane_state->color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_test_fill_plane_info(ctx), 0,
+				    "format %p4cc", &fmt);
+		KUNIT_EXPECT_EQ_MSG(test, (int)ctx->plane_info.format,
+				    (int)dm_test_plane_video_formats[i].dc_format,
+				    "format %p4cc", &fmt);
+		KUNIT_EXPECT_EQ(test, (int)ctx->plane_info.color_space,
+				(int)COLOR_SPACE_YCBCR709_LIMITED);
+	}
+}
+
+/**
+ * dm_test_plane_info_unsupported_format - Test an unsupported format is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_unsupported_format(struct kunit *test)
+{
+	struct dm_test_plane_info_ctx *ctx;
+
+	ctx = dm_test_plane_info_ctx_alloc(test, dm_kunit_alloc_adev(test),
+					   DRM_FORMAT_YUYV);
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_info(ctx), -EINVAL);
+}
+
+/**
+ * dm_test_plane_info_bad_color_encoding - Test an invalid colour encoding is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_bad_color_encoding(struct kunit *test)
+{
+	struct dm_test_plane_info_ctx *ctx;
+
+	ctx = dm_test_plane_info_ctx_alloc(test, dm_kunit_alloc_adev(test),
+					   DRM_FORMAT_NV12);
+	ctx->plane_state->color_encoding = DRM_COLOR_ENCODING_MAX;
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_info(ctx), -EINVAL);
+}
+
+/**
+ * dm_test_plane_info_rotations - Test every DRM rotation maps to a DC angle
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_rotations(struct kunit *test)
+{
+	static const struct {
+		unsigned int drm_rotation;
+		enum dc_rotation_angle dc_rotation;
+	} cases[] = {
+		{ DRM_MODE_ROTATE_0, ROTATION_ANGLE_0 },
+		{ DRM_MODE_ROTATE_90, ROTATION_ANGLE_90 },
+		{ DRM_MODE_ROTATE_180, ROTATION_ANGLE_180 },
+		{ DRM_MODE_ROTATE_270, ROTATION_ANGLE_270 },
+		/* No rotation bit set falls back to the unrotated angle. */
+		{ 0, ROTATION_ANGLE_0 },
+	};
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct dm_test_plane_info_ctx *ctx;
+
+		ctx = dm_test_plane_info_ctx_alloc(test, adev, DRM_FORMAT_ARGB8888);
+		ctx->plane_state->rotation = cases[i].drm_rotation;
+
+		KUNIT_EXPECT_EQ(test, dm_test_fill_plane_info(ctx), 0);
+		KUNIT_EXPECT_EQ(test, (int)ctx->plane_info.rotation,
+				(int)cases[i].dc_rotation);
+	}
+}
+
+/**
+ * dm_test_plane_info_layer_and_blending - Test z-order and blending are forwarded
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_info_layer_and_blending(struct kunit *test)
+{
+	struct dm_test_plane_info_ctx *ctx;
+
+	ctx = dm_test_plane_info_ctx_alloc(test, dm_kunit_alloc_adev(test),
+					   DRM_FORMAT_ARGB8888);
+	ctx->plane_state->normalized_zpos = 3;
+	ctx->plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+	ctx->plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE / 2;
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_info(ctx), 0);
+	KUNIT_EXPECT_TRUE(test, ctx->plane_info.visible);
+	KUNIT_EXPECT_EQ(test, ctx->plane_info.layer_index, 3);
+	KUNIT_EXPECT_EQ(test, (int)ctx->plane_info.stereo_format,
+			(int)PLANE_STEREO_FORMAT_NONE);
+	KUNIT_EXPECT_TRUE(test, ctx->plane_info.per_pixel_alpha);
+	KUNIT_EXPECT_TRUE(test, ctx->plane_info.global_alpha);
+	KUNIT_EXPECT_EQ(test, ctx->plane_info.global_alpha_value, 0x7f);
+}
+
 /* Tests for dm_early_init() */
 
 #define DM_TEST_ATOM_BIOS_SIZE	512
@@ -4254,6 +4493,13 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* amdgpu_dm_init_power_module */
 	KUNIT_CASE(dm_test_init_power_module_no_edp),
 	KUNIT_CASE(dm_test_init_power_module_alloc_failure),
+	/* fill_dc_plane_info_and_addr */
+	KUNIT_CASE(dm_test_plane_info_graphics_formats),
+	KUNIT_CASE(dm_test_plane_info_video_formats),
+	KUNIT_CASE(dm_test_plane_info_unsupported_format),
+	KUNIT_CASE(dm_test_plane_info_bad_color_encoding),
+	KUNIT_CASE(dm_test_plane_info_rotations),
+	KUNIT_CASE(dm_test_plane_info_layer_and_blending),
 	/* dm_early_init */
 	KUNIT_CASE(dm_test_early_init_no_object_header),
 	KUNIT_CASE(dm_test_early_init_legacy_asics),
-- 
2.43.0

