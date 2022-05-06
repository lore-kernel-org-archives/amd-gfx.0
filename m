Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184ACC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FAA10E623;
	Fri,  6 May 2022 15:43:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE1110E623
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQJTXJSY7xgwu/jhccY7qNCRmwiZLBR1Knb0OWTGkCBgLlHjVe4PsQkgU5SbgQSTGKCPVIUKMlPHxP5o0+2pDjLgOJWnPD/fSE5FjmT78y5OmjUcq/Jm9d4fYEvaoIoGB0C1auTbjXUH/DJfmk8tTCzMwNAHw8q3W4KsBWiPClTQubRkkSaSeoaToasmUp1JSZVmxVTCRWHCc9j/9fEt0dSJZ9LEaSgQqHTIqER4rHbtyIL6AoB3w1vb52I0SlovqXfUFOE6r8AsuCKmtKd/duwjkmwG4+Kafnhe4tNjbzX0+tJTakcWi+CjD9TQTWYkkTNa/Frci5jqvYWBVNBzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq1NIY7dSC7lAwD0Z9ZsV3qCIaba1nO2+Ln/zFrCtvg=;
 b=A0UCKpUtEVz2Rs+qf9rsADO6zYx9+gcCZmtUPyhKa3P7H4+d23fhDnOA5F3rLDv65FeaANnLt1tTXksz2q10EcyQE1d94WxvGf4Dy4gZRf9JNf5l4senMAh4AIapq0Bo+IcimQtQBDpBYZjrJ39t8zKdpuv3TS5WwUmyj17LAtIXITfptm3SfynGWd2JKvb2jZEYkuLffUxrf/sCN/6qiLTZOnmeg/+UA7YLOzUPqnT+AgxeKH2gsJgxpeKnpcDPoyT9dtLLqK5nWZWe20brC+UwDOFUcnD2Jha9tUE0Upc7caMHzZ0MO/hfJFtFb+uzk50qAMzCy6JnaUWRkyUaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq1NIY7dSC7lAwD0Z9ZsV3qCIaba1nO2+Ln/zFrCtvg=;
 b=cTNJPApCelh2wUi5vUCCtDWsWJlOVFgOq6LlWPtNgMmTK4JLf0M4NTyOJcn8snNe83ymh2MMGqbbF8LNirSn88oAf3UFiA6AmCxwNKgWtkM5VXTV+4Hh0+935zKMiV7KsBq0T7UKA2TI7jXDVG7yTv0U6ISBm03d79VmDlPxJEc=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:43:44 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::9d) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 6 May 2022 15:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:43 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:30 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 for z10
Date: Fri, 6 May 2022 23:42:10 +0800
Message-ID: <20220506154214.3438665-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81cbb685-876e-42bb-e349-08da2f773384
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB50141FB7F81E12DE4143AAC9FFC59@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4kuUd/IyMM2qX4Gg4euQX1XwfYxCt7SAadRBF6epwRKk52gx5Sc0rbKg/0+W5fZwpoHwsP/9jGBMlQpRUYIPgmJDnZUV8L3rPodbvo0yYgnHlUt9mKJ84bemuUbmdsxn85Z2MacFZb2ElkGdknOkwhKaKuFZEaXOe2dCAAM0r7dMEgP9jluuqfHpZPcl3tpDAb1eTVq2wbTqMuNLoTCaj7UgrDmyhW2ShzXcfRfdYOtE+Qh24iSyLH7oKc/jIQzbyeVTkWNQ8PZXs1cghGFVOiELSh1zkQhmUDGmC/n/5SxniuVPJewGIMaX76laPBIWYCqvbjKfP39FrX8x4A6KkLI90r++hnqly2wxoF/XgW5QRi7xFdF6De+a7hdt4O02OMBo/mGwznvnayyFHqvN8Di40Ckc5duBpcRYfYz+ZyrGHpcWKndmFSS4eBk+HxjAsb9F90FLZnJzGEB+HRzbcxghjI/H9olZCjAYbU5Au/+RGA/l6nG6mFx5RGZZ3FGGCbs0pK3yr9/4LOtYTdVIDrajZ8LaTsXTS4DUdOmHQnzmR+iPGIDwXPKtakoPF5Gtlk8sc0/tgTMFa4BixiGu28pxylTKynWWTrj2sp+pykK5zv309HSHQnqeLhiywjLXsvWiHoEjBoLOCWpnA+bZ4BCQZQGiDloCPSxeb5IHBEgykAicd3DUa4hEBrxC9BwM5EiD2opIco+JmQaICN36Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(5660300002)(2906002)(336012)(47076005)(8936002)(16526019)(186003)(26005)(36860700001)(86362001)(6916009)(54906003)(508600001)(44832011)(426003)(2616005)(6666004)(83380400001)(82310400005)(1076003)(7696005)(356005)(81166007)(4326008)(40460700003)(36756003)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:43.6588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cbb685-876e-42bb-e349-08da2f773384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why & How]
CONFIG_DRM_AMD_DC_DCN is used by pass the compilation failures, but DC
code should be OS-agnostic.

This patch fixes it by removing unnecessasry CONFIG_DRM_AMD_DC_DCN
for enabling z10.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 10 ++--------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c   |  4 ----
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c |  4 ----
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1eeea7c184ae..e41a48f596a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1674,7 +1674,6 @@ static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
 	return stream_mask;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 void dc_z10_restore(const struct dc *dc)
 {
 	if (dc->hwss.z10_restore)
@@ -1686,7 +1685,7 @@ void dc_z10_save_init(struct dc *dc)
 	if (dc->hwss.z10_save_init)
 		dc->hwss.z10_save_init(dc);
 }
-#endif
+
 /*
  * Applies given context to HW and copy it into current context.
  * It's up to the user to release the src context afterwards.
@@ -1700,10 +1699,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 	struct dc_state *old_state;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
 	dc_allow_idle_optimizations(dc, false);
-#endif
 
 	for (i = 0; i < context->stream_count; i++)
 		dc_streams[i] =  context->streams[i];
@@ -2839,9 +2836,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
-#endif
 
 	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
@@ -3298,9 +3293,8 @@ void dc_set_power_state(
 	case DC_ACPI_CM_POWER_STATE_D0:
 		dc_resource_state_construct(dc, dc->current_state);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_z10_restore(dc);
-#endif
+
 		if (dc->ctx->dmub_srv)
 			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9529b924742e..67ef357e5798 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -879,9 +879,7 @@ static bool should_prepare_phy_clocks_for_link_verification(const struct dc *dc,
 
 static void prepare_phy_clocks_for_destructive_link_verification(const struct dc *dc)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
-#endif
 	clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
 }
 
@@ -3098,10 +3096,8 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, const bool *allow_active
 	if (allow_active && link->psr_settings.psr_allow_active != *allow_active) {
 		link->psr_settings.psr_allow_active = *allow_active;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!link->psr_settings.psr_allow_active)
 			dc_z10_restore(dc);
-#endif
 
 		if (psr != NULL && link->psr_settings.psr_feature_enabled) {
 			psr->funcs->psr_enable(psr, link->psr_settings.psr_allow_active, wait, panel_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index acca35d86c10..de8b214132a2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -333,7 +333,6 @@ bool dc_stream_set_cursor_attributes(
 	dc = stream->ctx->dc;
 	stream->cursor_attributes = *attributes;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
 	/* disable idle optimizations while updating cursor */
 	if (dc->idle_optimizations_allowed) {
@@ -341,7 +340,6 @@ bool dc_stream_set_cursor_attributes(
 		reset_idle_optimizations = true;
 	}
 
-#endif
 	program_cursor_attributes(dc, stream, attributes);
 
 	/* re-enable idle optimizations if necessary */
@@ -405,7 +403,6 @@ bool dc_stream_set_cursor_position(
 	}
 
 	dc = stream->ctx->dc;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
 
 	/* disable idle optimizations if enabling cursor */
@@ -414,7 +411,6 @@ bool dc_stream_set_cursor_position(
 		reset_idle_optimizations = true;
 	}
 
-#endif
 	stream->cursor_position = *position;
 
 	program_cursor_position(dc, stream, position);
-- 
2.35.1

