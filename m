Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1CC48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7371261263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7371261263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DABA6ED95;
	Thu, 10 Jun 2021 16:29:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDFC6ED95
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISINDC7etIK7kZNU1+V5/XlH5+rvX+iPHwckCej18XT4MQzpUfGO9TsJ59lEmHIC21B1Hnp6SQ0A6j5nz2fZC5leJoT/T2nc49QY3qYh9ZKbayWuuVEBuFyGgrzCk6VcWvDDbpLpLTQDpN1A5FzZ8YSgrFqjP0T9BHiKWklsQwG62ly0G6JiuHVhZZkDZI0uZ7dvgrL6RzpbpZ668URgza7xAQIdMzsW5Ha1t0YJ7b2y2xSs0TK8X3mHcnaY3o7Cbz0+tt1b1unGNnoGYUjbdC2Zok8nTsvfD3A+a/lvSeHfGNG4neOO3UxggBhBqLsh/l6sNuiq07QzY1RJ3vVZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrNaDA+pr+QhAEX7POBq29RpcajjQy8fCrNn3odi6hw=;
 b=M3eSoVX808rLmzRFwD65LklwrAmUZzDWJugV2OUeS2+QiL13Q3fD3j6CyUcYsmz++oHGvF1iWbVBnxeQfZdnkeD90NSkba8rCUX7/ONjzyiULabICUj306/a0irt/ejcXvfiE/liIS/7I0I1foiO0gzYJ3yK4++24s9bYIG5Ta0+5/sHo3NiGVqmGb/42fjS+XKW/OrC0hP5HtxZp8tLsxoH/0OiQ4vEIg6uSgW2uMZRjB14dN/t2lTDZ01X+RSSrYDKuLhI2F+Fzd/g6cQbxiC+J6egLBCooep6MvJt8Yrlmw5jLh5RuHKanJTdtlaNT5/RaLHIyY0Akpm/8N+zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrNaDA+pr+QhAEX7POBq29RpcajjQy8fCrNn3odi6hw=;
 b=lvCWmzBabYDB9mmuynfZbAwrLfb1E7C+TmzLkzFY5hvNXKkIxMLcIgurg7EIW6ZU3XKgTOC/NJBh0gjLDGTh5sY66hHFBdu4kgPZW481Zskhgv9439VICcgZgz9dyIbGBPSFfbXv7miOXc9Ow71aPoj/YqUjyRdpmZwKt/8m35o=
Received: from MWHPR11CA0006.namprd11.prod.outlook.com (2603:10b6:301:1::16)
 by MWHPR12MB1917.namprd12.prod.outlook.com (2603:10b6:300:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:26 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::24) by MWHPR11CA0006.outlook.office365.com
 (2603:10b6:301:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:24 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:23 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/24] drm/amd/display: move psr dm interface to separate files
Date: Thu, 10 Jun 2021 12:28:24 -0400
Message-ID: <20210610162838.287723-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b13403-1522-4c10-082d-08d92c2ce9d7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917FD45B90167A690905DFCEB359@MWHPR12MB1917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GE8LOQQakXMOc3wLyuFFkDcjGSkEARV+X7xDs0o//X8vuuLPjFZd0ej2gR165xLzWHqTD3KljrT4kN47gdNudyx+efJYwl2y03aJrcQOFjQZIKxRtYICeN/DPGKmnX0BPpfYfIbghuNCEA5/+IvQ3gbExiJB5Rb9Z0IdUMkQUGE0Yam2oih+8bT3ggftlnIClSNF9EB5WLBRBaVlZGf7cfirNz39sLGcbyoVy98OIdjDLa09WdKID8nxDS6S627ZYAATFhlIVHsyKflOWGbvKzescoQgKbOeMgfNTbHbQp4qK7X8CZDrhTP+RtSHM12y4yKSIfgqytteTUgjsKiKe5LBqu0TIUDHiKKrUaUPAznAM+h5QDtZy5m26keIne2PWYx5B55S3mx0Se/+HS7gtzKjrFmPZb6353RvE9GYJ6TZJp64zJ4WuPhpOpqvrLyDeCUbNIYrXSI4mzmhZmK5AxH4CahSv0aRj8BSMRLLV+HHtPjJUgvSvRAH0WaRhyLBxh2cy+PK8PP/Zv250GuJWAjycW/cTVXHmb3s4vgicsscJywoCmAEoX+Z03LxKAGTv/MobVI8JHb8+/4oQd9QDlKQRp+qfG9QpYj4Xk/vYyoj9v2ua79YpAlDAtZxl4EcGoROZDk8TypYT3Gm+874qGCbHTo8f8XFG/JeuKpPO6XvuDZVhwPn9GifqUr3zGxR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(2906002)(36860700001)(478600001)(82310400003)(82740400003)(356005)(6916009)(316002)(47076005)(86362001)(83380400001)(7696005)(54906003)(8676002)(4326008)(36756003)(70206006)(336012)(70586007)(426003)(2616005)(26005)(81166007)(30864003)(1076003)(5660300002)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:26.1353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b13403-1522-4c10-082d-08d92c2ce9d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Improve the maintain/read abilities of dm code.

[How]
Create amdgpu_dm_psr.c/h files.
Move psr function from amdgpu_dm.c

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +--------------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 166 ++++++++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  37 ++++
 4 files changed, 205 insertions(+), 137 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 9a3b7bf8ab0b..91fb72c96545 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -28,7 +28,7 @@
 AMDGPUDM = amdgpu_dm.o amdgpu_dm_irq.o amdgpu_dm_mst_types.o amdgpu_dm_color.o
 
 ifneq ($(CONFIG_DRM_AMD_DC),)
-AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o
+AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o
 endif
 
 ifdef CONFIG_DRM_AMD_DC_HDCP
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c0a3119982b0..03b4ac4bf9ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -58,6 +58,7 @@
 #if defined(CONFIG_DEBUG_FS)
 #include "amdgpu_dm_debugfs.h"
 #endif
+#include "amdgpu_dm_psr.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -213,12 +214,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static void handle_cursor_update(struct drm_plane *plane,
 				 struct drm_plane_state *old_plane_state);
 
-static void amdgpu_dm_set_psr_caps(struct dc_link *link);
-static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
-static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
-static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
-static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
-
 static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
 
@@ -10826,136 +10821,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 						       freesync_capable);
 }
 
-static void amdgpu_dm_set_psr_caps(struct dc_link *link)
-{
-	uint8_t dpcd_data[EDP_PSR_RECEIVER_CAP_SIZE];
-
-	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
-		return;
-	if (link->type == dc_connection_none)
-		return;
-	if (dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
-					dpcd_data, sizeof(dpcd_data))) {
-		link->dpcd_caps.psr_caps.psr_version = dpcd_data[0];
-
-		if (dpcd_data[0] == 0) {
-			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-			link->psr_settings.psr_feature_enabled = false;
-		} else {
-			link->psr_settings.psr_version = DC_PSR_VERSION_1;
-			link->psr_settings.psr_feature_enabled = true;
-		}
-
-		DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
-	}
-}
-
-/*
- * amdgpu_dm_link_setup_psr() - configure psr link
- * @stream: stream state
- *
- * Return: true if success
- */
-static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
-{
-	struct dc_link *link = NULL;
-	struct psr_config psr_config = {0};
-	struct psr_context psr_context = {0};
-	bool ret = false;
-
-	if (stream == NULL)
-		return false;
-
-	link = stream->link;
-
-	psr_config.psr_version = link->dpcd_caps.psr_caps.psr_version;
-
-	if (psr_config.psr_version > 0) {
-		psr_config.psr_exit_link_training_required = 0x1;
-		psr_config.psr_frame_capture_indication_req = 0;
-		psr_config.psr_rfb_setup_time = 0x37;
-		psr_config.psr_sdp_transmit_line_num_deadline = 0x20;
-		psr_config.allow_smu_optimizations = 0x0;
-
-		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
-
-	}
-	DRM_DEBUG_DRIVER("PSR link: %d\n",	link->psr_settings.psr_feature_enabled);
-
-	return ret;
-}
-
-/*
- * amdgpu_dm_psr_enable() - enable psr f/w
- * @stream: stream state
- *
- * Return: true if success
- */
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
-{
-	struct dc_link *link = stream->link;
-	unsigned int vsync_rate_hz = 0;
-	struct dc_static_screen_params params = {0};
-	/* Calculate number of static frames before generating interrupt to
-	 * enter PSR.
-	 */
-	// Init fail safe of 2 frames static
-	unsigned int num_frames_static = 2;
-
-	DRM_DEBUG_DRIVER("Enabling psr...\n");
-
-	vsync_rate_hz = div64_u64(div64_u64((
-			stream->timing.pix_clk_100hz * 100),
-			stream->timing.v_total),
-			stream->timing.h_total);
-
-	/* Round up
-	 * Calculate number of frames such that at least 30 ms of time has
-	 * passed.
-	 */
-	if (vsync_rate_hz != 0) {
-		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
-		num_frames_static = (30000 / frame_time_microsec) + 1;
-	}
-
-	params.triggers.cursor_update = true;
-	params.triggers.overlay_update = true;
-	params.triggers.surface_update = true;
-	params.num_frames = num_frames_static;
-
-	dc_stream_set_static_screen_params(link->ctx->dc,
-					   &stream, 1,
-					   &params);
-
-	return dc_link_set_psr_allow_active(link, true, false, false);
-}
-
-/*
- * amdgpu_dm_psr_disable() - disable psr f/w
- * @stream:  stream state
- *
- * Return: true if success
- */
-static bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
-{
-
-	DRM_DEBUG_DRIVER("Disabling psr...\n");
-
-	return dc_link_set_psr_allow_active(stream->link, false, true, false);
-}
-
-/*
- * amdgpu_dm_psr_disable() - disable psr f/w
- * if psr is enabled on any stream
- *
- * Return: true if success
- */
-static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm)
-{
-	DRM_DEBUG_DRIVER("Disabling psr if psr is enabled on any stream\n");
-	return dc_set_psr_allow_active(dm->dc, false);
-}
-
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
new file mode 100644
index 000000000000..f7c77ae0d965
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "amdgpu_dm_psr.h"
+#include "dc.h"
+#include "dm_helpers.h"
+
+/*
+ * amdgpu_dm_set_psr_caps() - set link psr capabilities
+ * @link: link
+ *
+ */
+void amdgpu_dm_set_psr_caps(struct dc_link *link)
+{
+	uint8_t dpcd_data[EDP_PSR_RECEIVER_CAP_SIZE];
+
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+		return;
+	if (link->type == dc_connection_none)
+		return;
+	if (dm_helpers_dp_read_dpcd(NULL, link, DP_PSR_SUPPORT,
+					dpcd_data, sizeof(dpcd_data))) {
+		link->dpcd_caps.psr_caps.psr_version = dpcd_data[0];
+
+		if (dpcd_data[0] == 0) {
+			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+			link->psr_settings.psr_feature_enabled = false;
+		} else {
+			link->psr_settings.psr_version = DC_PSR_VERSION_1;
+			link->psr_settings.psr_feature_enabled = true;
+		}
+
+		DRM_INFO("PSR support:%d\n", link->psr_settings.psr_feature_enabled);
+	}
+}
+
+/*
+ * amdgpu_dm_link_setup_psr() - configure psr link
+ * @stream: stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
+{
+	struct dc_link *link = NULL;
+	struct psr_config psr_config = {0};
+	struct psr_context psr_context = {0};
+	struct dc *dc = NULL;
+	bool ret = false;
+
+	if (stream == NULL)
+		return false;
+
+	link = stream->link;
+	dc = link->ctx->dc;
+
+	psr_config.psr_version = link->dpcd_caps.psr_caps.psr_version;
+
+	if (psr_config.psr_version > 0) {
+		psr_config.psr_exit_link_training_required = 0x1;
+		psr_config.psr_frame_capture_indication_req = 0;
+		psr_config.psr_rfb_setup_time = 0x37;
+		psr_config.psr_sdp_transmit_line_num_deadline = 0x20;
+		psr_config.allow_smu_optimizations = 0x0;
+
+		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
+
+	}
+	DRM_DEBUG_DRIVER("PSR link: %d\n",	link->psr_settings.psr_feature_enabled);
+
+	return ret;
+}
+
+/*
+ * amdgpu_dm_psr_enable() - enable psr f/w
+ * @stream: stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
+{
+	struct dc_link *link = stream->link;
+	unsigned int vsync_rate_hz = 0;
+	struct dc_static_screen_params params = {0};
+	/* Calculate number of static frames before generating interrupt to
+	 * enter PSR.
+	 */
+	// Init fail safe of 2 frames static
+	unsigned int num_frames_static = 2;
+
+	DRM_DEBUG_DRIVER("Enabling psr...\n");
+
+	vsync_rate_hz = div64_u64(div64_u64((
+			stream->timing.pix_clk_100hz * 100),
+			stream->timing.v_total),
+			stream->timing.h_total);
+
+	/* Round up
+	 * Calculate number of frames such that at least 30 ms of time has
+	 * passed.
+	 */
+	if (vsync_rate_hz != 0) {
+		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
+		num_frames_static = (30000 / frame_time_microsec) + 1;
+	}
+
+	params.triggers.cursor_update = true;
+	params.triggers.overlay_update = true;
+	params.triggers.surface_update = true;
+	params.num_frames = num_frames_static;
+
+	dc_stream_set_static_screen_params(link->ctx->dc,
+					   &stream, 1,
+					   &params);
+
+	return dc_link_set_psr_allow_active(link, true, false, false);
+}
+
+/*
+ * amdgpu_dm_psr_disable() - disable psr f/w
+ * @stream:  stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream)
+{
+
+	DRM_DEBUG_DRIVER("Disabling psr...\n");
+
+	return dc_link_set_psr_allow_active(stream->link, false, true, false);
+}
+
+/*
+ * amdgpu_dm_psr_disable() - disable psr f/w
+ * if psr is enabled on any stream
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm)
+{
+	DRM_DEBUG_DRIVER("Disabling psr if psr is enabled on any stream\n");
+	return dc_set_psr_allow_active(dm->dc, false);
+}
+
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
new file mode 100644
index 000000000000..57bbb80421e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef AMDGPU_DM_AMDGPU_DM_PSR_H_
+#define AMDGPU_DM_AMDGPU_DM_PSR_H_
+
+#include "amdgpu.h"
+
+void amdgpu_dm_set_psr_caps(struct dc_link *link);
+bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
+bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
+bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
+bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
+
+#endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
