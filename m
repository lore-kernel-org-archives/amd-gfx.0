Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F288ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544C910E840;
	Wed, 14 Sep 2022 05:16:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB0510E83B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5CGRqZ1SexUrs0R6sIABi98EIKabYEVZNzo889JIaInCSnAfFqWFeVOvo9GdBSKQU5bLqmS5mQZP/EwR+51uVt1Yk2xhoqxjdUyb8Sfwqau8Q2TFJAgy67jm0SSCLRkKM0wwOjqIeamV/WnA9IRZgrEnpr7ow5M9JfBvDLPq+MBwX8H925QjoXL4Yy7Q84gk4ad3bomVJlifgGE7DMOiPdKnbJlonVLnvMHu0O2jQDL2k8SlikISm1jcwW1z6ZAuZsP4hInMTyUCmlGmQ/TIPR5CABQzcL/h9S58qpNb3Vp6OgNEIrOPZyopphY94egr3yqvWiTo/phZXe+1sY7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ke8s3v5CPi30y2QULDTK5B6DEWE+OjBu6DHLBAYU/o=;
 b=iempmSA/xEg6JI2amAknmcsvPaMZxCV4IZj+a1utWY4NtpVf8v3DmhZgUPiT3pTQfQyhBwZ0hCrlAoDidO15wJdmed2VKnrMcD++imxqM9yXEqB8DyoKQ1G56S/iSC/8O0HtWbeFMg6Y793YAQD7KF0AAQQtM7UoJ+eNL5L914Wz2Qk91lkYoGWWHika6vA0+874JmAQ5WkzVqQW/l0aNGe2bJVTgMy41txVt2HO/0Nsy5iUGtGO9XU4g5Xh5tEeXl/A6XsL1bqB/Mv+F+a0mvCUDotLHXYI3FOc8DVIG0oNVR4UzVzAafsn064t5dWBilVN4t60nIN2FS5nmgnFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ke8s3v5CPi30y2QULDTK5B6DEWE+OjBu6DHLBAYU/o=;
 b=GGnlox4RELBYzXgEAkE8oxgdpZnmADe3cQf/oXQ9guqyvJqS1/SafNytu7svTNQ2PpSnVrcrTNXZMIYmb56Xdq5XAPVVBE/asxYc1nRRA5FjeIR/N3rNb0sRo/SSmcjzqUvkXVnGrv2qae+YK5p7rf0TossBAo2ZPbMTEVoTac4=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:15:52 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::bf) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:49 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 29/47] drm/amd/display: Display distortion after hotplug 5K
 tiled display
Date: Wed, 14 Sep 2022 13:10:28 +0800
Message-ID: <20220914051046.1131186-30-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: aec0a5c0-fd85-4ea1-d57c-08da961031b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 349Bvn0aHRHWvLQiEdHOPJublZSjpRIenHR4y6iXlFE/LygzlsyyiUCV+6y8VJJw6i4kvWgnTVTCMt+8UWCocVC6xu292r/LU1ddUNH8PsDlvN5RDNl0eZ8BkvUCiYCFVz5QdF3dHrkNnX8UDVeuXRUjghnhfxuR0oM+hRtb30UWH0SNKzOz76yE/Yyp70NPh/bVLcct+ukqVwIjpUfXmaH1lhA7sgqFTYr3PqG0cAS4+bAUSQjbjd3v/D2q3R4wIvWY5zEm9mIeHG3yzX3CKso9dlAYLP+NA684XoXDv1yuKBRzfraKX2E5RaMU4XDEMtOf9TlYd9WyHXwfwVk/pylQNuaBU5H+rKTJzA+FUwb1cIa2lLipKOfpqN4+Mf8wtWMX93Iorh5H528gOX4HFXdTnT/ZxncZRgnLD3CdK32fQGXB6kzXW2HtUj7Gq4gmtfDSHOxBth3g0AT/6q+prcSOXiik9pHotkzJYh09zMJCkLcnpc9x0XnTJ5PSdW72U8Z4AMQ+NbMH+3QBozwxkYtbxe32ZeC0EBQozr4gMn2unWvzZ7PPdyBPF0AgIxiHJ19jcee27Rkmu2n79A/kLNn7rr1sOiU7Gj1CjwCkuVEKRGfopdiDvQNnghyKmgu2qKPpML3tT5ag4zPFB9opMFqID/h1FBw5pu8G8PGqL7qsSloTkmSOgM+d8JyQi7zcNdqMJvfqW3wAY/d8Sj4odiVtMKdZWbZhRvAB7U1EBcTPHRTuAWVDkqW3+//EdLsXC1LSwE3vTI60ZHiducXT/ipcEYLIc76+ZCnrMTQ3rryP90D9dEUoACmkas4D2XTa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(2906002)(356005)(82310400005)(40480700001)(81166007)(86362001)(41300700001)(316002)(1076003)(186003)(47076005)(8936002)(2616005)(70586007)(26005)(336012)(426003)(5660300002)(82740400003)(54906003)(83380400001)(478600001)(36860700001)(36756003)(7696005)(4326008)(40460700003)(70206006)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:52.1867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec0a5c0-fd85-4ea1-d57c-08da961031b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
 Meenakshikumar
 Somasundaram <meenakshikumar.somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
During hot plug of specific 5K tiled display, sometimes both the tiles
are not synchronized resulting in distortion. The reason is that otgs of
both the tiles goes out of sync when otg workaround (dcnxxx_disable_otg_wa)
is applied for bandwidth optimization. The otg workaround reenables otg
but otg synchronization context is not reset and hence dc_trigger_sync()
does not resynchronize otg again.

[How]
Implement reset_sync_context_for_pipe() to reset the otg synchronization
context for the disabled pipe and its slave pipes when otg workaround is
applied.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c    | 11 ++++++-----
 .../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c  | 11 ++++++-----
 .../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c  | 11 ++++++-----
 .../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c  | 11 ++++++-----
 .../gpu/drm/amd/display/dc/core/dc_resource.c   | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h   |  4 ++++
 6 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index d43258e3cd4f..c1eaf571407a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -104,7 +104,7 @@ static int dcn31_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
@@ -115,9 +115,10 @@ static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
-			if (disable)
+			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-			else
+				reset_sync_context_for_pipe(dc, context, i);
+			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
@@ -216,11 +217,11 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn31_disable_otg_wa(clk_mgr_base, true);
+		dcn31_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn31_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn31_disable_otg_wa(clk_mgr_base, false);
+		dcn31_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index cd86aa912e3c..fd4b79746f4b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -126,7 +126,7 @@ static int dcn314_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
@@ -138,9 +138,10 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
 				     dc_is_virtual_signal(pipe->stream->signal))) {
-			if (disable)
+			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-			else
+				reset_sync_context_for_pipe(dc, context, i);
+			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
@@ -240,11 +241,11 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn314_disable_otg_wa(clk_mgr_base, true);
+		dcn314_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn314_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn314_disable_otg_wa(clk_mgr_base, false);
+		dcn314_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index dd6abfba9253..7f481ab252d0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -84,7 +84,7 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
@@ -96,9 +96,10 @@ static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
 				     dc_is_virtual_signal(pipe->stream->signal))) {
-			if (disable)
+			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-			else
+				reset_sync_context_for_pipe(dc, context, i);
+			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
@@ -180,12 +181,12 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		/* No need to apply the w/a if we haven't taken over from bios yet */
 		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, true);
+			dcn315_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, false);
+			dcn315_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 0cd3d2eb7ac7..187f5b27fdc8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -112,7 +112,7 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
@@ -124,9 +124,10 @@ static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 			continue;
 		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
 				     dc_is_virtual_signal(pipe->stream->signal))) {
-			if (disable)
+			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
-			else
+				reset_sync_context_for_pipe(dc, context, i);
+			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
 		}
 	}
@@ -221,11 +222,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, true);
+		dcn316_disable_otg_wa(clk_mgr_base, context, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, false);
+		dcn316_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 5bedee56acd4..8ee0d946bb2f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3581,6 +3581,23 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	}
 }
 
+void reset_sync_context_for_pipe(const struct dc *dc,
+	struct dc_state *context,
+	uint8_t pipe_idx)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx_reset;
+
+	/* reset the otg sync context for the pipe and its slave pipes if any */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe_ctx_reset = &context->res_ctx.pipe_ctx[i];
+
+		if (((GET_PIPE_SYNCD_FROM_PIPE(pipe_ctx_reset) == pipe_idx) &&
+			IS_PIPE_SYNCD_VALID(pipe_ctx_reset)) || (i == pipe_idx))
+			SET_PIPE_SYNCD_TO_PIPE(pipe_ctx_reset, i);
+	}
+}
+
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter)
 {
 	/* TODO - get transmitter to phy idx mapping from DMUB */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index a58f80ac94ba..c37d1141febe 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -219,6 +219,10 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	struct dc_state *context,
 	uint8_t disabled_master_pipe_idx);
 
+void reset_sync_context_for_pipe(const struct dc *dc,
+	struct dc_state *context,
+	uint8_t pipe_idx);
+
 uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter transmitter);
 
 const struct link_hwss *get_link_hwss(const struct dc_link *link,
-- 
2.37.3

