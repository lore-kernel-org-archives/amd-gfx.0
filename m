Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FF5CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC8210E421;
	Wed, 18 Oct 2023 17:42:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7437310E421
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHRCEmgRh5PRjKekYcwD1Ijlg4NMbwMT0CxED+gIXroLtkSTu7HlXMOkPHcQgz03LY0TzIy5mBNvx1rrmHiwYdXte+azbmXQeVYhnsFhwViQP9wbL7bnzZLrWto1XMIhNlLBrZWz9kDNKd73yRDTkcZjrViVTRqL3ZjdeQJGrC1cqpxiiQbBckfVSep9GAQO3tUntvN6ri0W/3ZyfwuO1k2mK+D1oSSCuLQiu2FueWV9pu2e5bS7YtAJOLk6pr3tnMZ4wUkAf3MGmI/iM37rLswcfT52LLtd3fMosg4p3t8yqok1I8FPkc3Pw6bI2tl9yx9AsqBIsgh56t2p4fNfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3+moArg/GnShMngoS4gHkLFIbwEqxVDM9P+jmGnbhk=;
 b=L60g8NIFCZx5oJ6N1BK9faIDbzhDYCbbNXvoPGsRXJ1rSgs4ejSIsjVfSghP+n/5015kl0l900yk0Azlu+KbymDhZBlYs1R0XoiKms8Mf/AjpOx+VIOLEJPDZn8UGmBvHGgHqBvMCVvLtxMj1LjdCZB396xeSm/UC0Sfof4cdkOCUionBJQAk++pL25koNTZpEQDIwYHwKBlO0BS72EkmPosBG0P4DQRGuW075znY+KcxCtJKcAWjGu/ggKXlIdXfucJy09N68srm9P3mtFJd1eBuE24gdfMtcS7vZC+5qP5r6SCpeQHcckAOW8x2PFil1N9vyLJ9HgOG1cXKTy3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3+moArg/GnShMngoS4gHkLFIbwEqxVDM9P+jmGnbhk=;
 b=0shpgllJc2LEFpd4Peip4/eh+ePnp/vQRXyjnrysulz2A0kmflw31YAyo/R32gl1qPamjh0seT2oVx3e0R/PZJuY1sdil3ZLB8+16hHkPKt84JRNR/9QNLq7KscLb7P27tJ9z/1ZE4KxEqJuMYfks+BycOgpMelz0UDcjqzcjvU=
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:42:05 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::61) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 17:42:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:42:02 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/26] drm/amd/display: add pipe resource management callbacks
 to DML2
Date: Wed, 18 Oct 2023 13:41:16 -0400
Message-ID: <20231018174133.1613439-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6746638e-e957-464d-f613-08dbd0018a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECvMyyS6YaDcdLzliaBx2QwSTtPJjN5nGvdxpLxlQ+eaQCXowMB2OulUdB5wpKZ1gELlCzqaD76dmcOKidLD6LGkDhVwGGd5TZ1aw2Vf+EBGUq6Sb7yvE7mxg2Kem5P3M9htZYF9ucu3/RelYp6sYn2eW/sHkV6uhBjcqOkUU7mk5kBfCSGWp59exFZE10LV7y6ADkpbc7aoJW76Bu7nrpFJcX9tEolwGexSgJqigL/UMOzHmdqaAnFBdjLB9JkPnDGMmhQjBB4F1RTQCctihpLDoxbJh86+etSpuXUuc4HZTNjaerSq2s5DP5qFlXWb+vQ3KruGFagKAzosu34U7Ibs7djSQBOgtoZqtDisczG625waJxuKguzWNevYeDiM1ZJM9UXxObf27TqHuqDUYLxvd4Qv3++2StGxuiW/qRnhZjVlMDjs9igykcvUkHBTNeKle5S0Ydu4Th5ITGkMiAfUfsSGfmjerh4ieiKBvJzSO7duKj6aqOEsK/pwEZm772tsy2eD85oXMNrCv8Sk8lRCzs4vnvXrpw8eaU8K75R7b+fUNRUbdhCm1Xz3Lkm0GnAiLWuKXYlTtW7sfaHUC4gqSdbMylC2FY67hUzCzEwnLeJfz67GAlpV4SchCYMTuoEtS0LM5dyDNaL08dS8IJZDDMvuQ3UwF+xyAxuHEBi1X0L+2K1OVYcriX4qsqde3irEPRyPxycpgJSyPPf7MOVm2IpsG6xTbpzQLfa2RXG+g2A0WesOeVvUEZjXnP2sOnGX+XONa90Q7hMXThzRfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(336012)(426003)(26005)(356005)(47076005)(36860700001)(83380400001)(5660300002)(41300700001)(54906003)(8936002)(70206006)(70586007)(8676002)(4326008)(2876002)(6916009)(86362001)(2906002)(478600001)(6666004)(7696005)(1076003)(40480700001)(40460700003)(81166007)(316002)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:03.4053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6746638e-e957-464d-f613-08dbd0018a36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Need DML2 to support new pipe resource management APIs.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c |  5 +++++
 .../drm/amd/display/dc/dcn321/dcn321_resource.c   |  5 +++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_resource.c |  5 +++++
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.h    | 15 +++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 81b0588fa80b..02d3168f1673 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2445,6 +2445,11 @@ static bool dcn32_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 
 	dc->dml2_options.svp_pstate.callbacks.dc = dc;
 	dc->dml2_options.svp_pstate.callbacks.add_plane_to_context = &dc_add_plane_to_context;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 44caf6711589..9f6186be7cd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1998,6 +1998,11 @@ static bool dcn321_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 
 	dc->dml2_options.svp_pstate.callbacks.dc = dc;
 	dc->dml2_options.svp_pstate.callbacks.add_plane_to_context = &dc_add_plane_to_context;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 4e03c9d663de..682bf93049b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -2082,6 +2082,11 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
+	dc->dml2_options.callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
+	dc->dml2_options.callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
+	dc->dml2_options.callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dc->dml2_options.callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dc->dml2_options.callbacks.get_opp_head = &resource_get_opp_head;
 	dc->dml2_options.max_segments_per_hubp = 24;
 
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index f3b85b0891d3..c3d5b84ee914 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -71,6 +71,21 @@ struct dml2_dc_callbacks {
 	bool (*build_scaling_params)(struct pipe_ctx *pipe_ctx);
 	bool (*can_support_mclk_switch_using_fw_based_vblank_stretch)(struct dc *dc, struct dc_state *context);
 	bool (*acquire_secondary_pipe_for_mpc_odm)(const struct dc *dc, struct dc_state *state, struct pipe_ctx *pri_pipe, struct pipe_ctx *sec_pipe, bool odm);
+	bool (*update_pipes_for_stream_with_slice_count)(
+			struct dc_state *new_ctx,
+			const struct dc_state *cur_ctx,
+			const struct resource_pool *pool,
+			const struct dc_stream_state *stream,
+			int new_slice_count);
+	bool (*update_pipes_for_plane_with_slice_count)(
+			struct dc_state *new_ctx,
+			const struct dc_state *cur_ctx,
+			const struct resource_pool *pool,
+			const struct dc_plane_state *plane,
+			int slice_count);
+	int (*get_odm_slice_index)(const struct pipe_ctx *opp_head);
+	int (*get_mpc_slice_index)(const struct pipe_ctx *dpp_pipe);
+	struct pipe_ctx *(*get_opp_head)(const struct pipe_ctx *pipe_ctx);
 };
 
 struct dml2_dc_svp_callbacks {
-- 
2.34.1

