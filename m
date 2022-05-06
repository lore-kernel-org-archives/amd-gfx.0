Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEEB210E1C8;
	Fri,  6 May 2022 15:43:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A5510E1C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3pVdaDstEYf8jQuG9UKIMgKy5UaWQiEHGoXmjnK33bmn8Jh4OuwjbLhS4ZP6ODGxLNoLP6LNKiB/KfkLbFtS76sB02bc3zM8gSbHKwmm2JNtQ9WcMwUp4i/lu7/kQBm/EPYC3mNOu3tYJUqZ5h1VzZ9m1jZrwOH7Dnk00sOVkFJlAWUoyUpx2G9R88+Ej+bPh6LEmBl8KJ1yTcOTB8jwjvaLSCTpWV/9CmI9kvDpBIBRqrQnew/tb8hsc+q4ba6TS6NMKHVbuHPKs9mRBX4Lh4d3BUmraVQmCRSNkevXqyTJh/GtZQ5s4at6QYh6OHPRECRNxy1PqsBFMmyPD5FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMmLPULv1KSfy/zDUKzGvnG9OCIGStpNUciBNmAp6pE=;
 b=S4BwuuKNTHzs9G/cLSw/NOKnbp5XgfGYk5lA+Pg7c9hWfIVkm4gfeCkYZqZHIXGtxU7C7bDYzwTnJNbJ5cBwhFRYr5E61C1gAiCOJE2CRrin0RRIKbGHD1lCPS3dxiGP/UHUA1KokqBn+dlJlWJgEk3YpHR7WNgPpZLzteiHwoZFBwdAfC1yf88UUCJY4kYmlv0tS5q7dJ5Dj5rbv0B8Lsi0sAm/Oxve1WhWWQJczW6UmUJn3snYhjDtuO4p889t+TcNRvGQOXbGQps46FZ+sHKiA455MZ+ouBIl4L4LN7xVfVSvh8wDcfVMY+kc5NDHtUsv2sRkF1V6sd7hvX3DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMmLPULv1KSfy/zDUKzGvnG9OCIGStpNUciBNmAp6pE=;
 b=xppiLA8BfcjbEXpOvhKXElN7O2Yk/OPzLpndHJU87RciRGXCaBRa5vbfRLMoLey9isjWGa8FOjh6RplAk5s9sOpzAyTWms5QOiyreb05TBb8CTYrTJaVxPrb87jBzBpC9Px+6gzYZKFSwW58qIi4uMaaCicjgufFCMXtn5np9RU=
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 15:43:19 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::f1) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 6 May 2022 15:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:19 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:13 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 in dc
Date: Fri, 6 May 2022 23:42:06 +0800
Message-ID: <20220506154214.3438665-8-stylon.wang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d297eac-6c9b-4534-c74e-08da2f77250d
X-MS-TrafficTypeDiagnostic: MN0PR12MB5907:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5907627456E0180931BD0068FFC59@MN0PR12MB5907.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRpjXUMnnCH4Hji6cRucsoB79fOIemiPQmT+EwbplsCW/gHP2WGMAw8yh477HM6N0+OEpKMoXLoUYsjRVzQ9xEQJzgqiwt29avEaIrvftZkafddRM/mIW2Dh34J6ikdJZMOCvTSJEh1Bjq5SP/J+7KszwTpTOL8xKeFWD9fndHMMMJygiam5mpH/gWrepAZvNcgYvlQbtBvNEhWAveuPUdRGuosJMxAd075qFOLPe4KRc99R5dy0wRLId6yTxqfReykl6sNoPgPs+VyqVvFaI4EZOvXtsFb1wD6ph+ywXl4l/0WSiNOMxe3JYIf3F2eKGeQ0yWBNS5KvoPmmIzro+sfYyOClbHB/vpIc15XbS0PbZcn8E5PE74cwBjvzNYf8i26CjDv8RvJzFRPNr+3cfLH4k0XpB2UCJTeiCemBvnltShkrTU+uGVgvyKiFK7+0RI7O8JWevIyREB4OaRoOehTucJ2OOVPF6rHLzEsF5mXcygupJ2GlzCiZUEgL8FJ/rYteiRAn29mvCKuWXnZxY7tuNWuoHnwa7lPsouFwstLfpo6mq5u0HwBYVTeuOrxYwimi1pMahYIGD0Not+3VM16MeJS5UWiZesqK0+yD+or/8zVBmmpCAQHd9JzvGHobPrbioJj/8XkESy3iHMQkBA85OenNlwn7oGC5GkW2/FPhX5Tly77kmUtkh9yoYE9DgsO8MNGxok8Fgq5TzfJIPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(508600001)(8676002)(40460700003)(4326008)(70206006)(70586007)(86362001)(81166007)(316002)(6916009)(356005)(2906002)(30864003)(7696005)(26005)(5660300002)(6666004)(54906003)(47076005)(1076003)(426003)(336012)(2616005)(44832011)(82310400005)(186003)(16526019)(83380400001)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:19.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d297eac-6c9b-4534-c74e-08da2f77250d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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
in dc and dc/core directories.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 -
 .../display/dc/bios/command_table_helper2.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 ++--------------
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 --
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  2 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 21 ++---------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  8 ----
 drivers/gpu/drm/amd/display/dc/dc.h           | 37 -------------------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 17 ++-------
 12 files changed, 10 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index f05ab2bf20c5..b4eca0236435 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -63,9 +63,7 @@ DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink
 dc_surface.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
 dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
 
-ifdef CONFIG_DRM_AMD_DC_DCN
 DISPLAY_CORE += dc_vm_helper.o
-endif
 
 AMD_DISPLAY_CORE = $(addprefix $(AMDDALPATH)/dc/core/,$(DISPLAY_CORE))
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index dd9704ef4ccc..f3792286f571 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -65,7 +65,6 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCE_VERSION_12_1:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case DCN_VERSION_1_0:
 	case DCN_VERSION_1_01:
 	case DCN_VERSION_2_0:
@@ -80,7 +79,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_16:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
-#endif
+
 	default:
 		/* Unsupported DCE */
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c2fcd67bcc4d..1eeea7c184ae 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -829,14 +829,12 @@ static void dc_destruct(struct dc *dc)
 	kfree(dc->bw_dceip);
 	dc->bw_dceip = NULL;
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	kfree(dc->dcn_soc);
 	dc->dcn_soc = NULL;
 
 	kfree(dc->dcn_ip);
 	dc->dcn_ip = NULL;
 
-#endif
 	kfree(dc->vm_helper);
 	dc->vm_helper = NULL;
 
@@ -882,10 +880,8 @@ static bool dc_construct(struct dc *dc,
 	struct dc_context *dc_ctx;
 	struct bw_calcs_dceip *dc_dceip;
 	struct bw_calcs_vbios *dc_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	struct dcn_soc_bounding_box *dcn_soc;
 	struct dcn_ip_params *dcn_ip;
-#endif
 
 	dc->config = init_params->flags;
 
@@ -913,7 +909,6 @@ static bool dc_construct(struct dc *dc,
 	}
 
 	dc->bw_vbios = dc_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	dcn_soc = kzalloc(sizeof(*dcn_soc), GFP_KERNEL);
 	if (!dcn_soc) {
 		dm_error("%s: failed to create dcn_soc\n", __func__);
@@ -929,7 +924,6 @@ static bool dc_construct(struct dc *dc,
 	}
 
 	dc->dcn_ip = dcn_ip;
-#endif
 
 	if (!dc_construct_ctx(dc, init_params)) {
 		dm_error("%s: failed to create ctx\n", __func__);
@@ -1868,7 +1862,6 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	return (result == DC_OK);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dc_acquire_release_mpc_3dlut(
 		struct dc *dc, bool acquire,
 		struct dc_stream_state *stream,
@@ -1904,7 +1897,7 @@ bool dc_acquire_release_mpc_3dlut(
 	}
 	return ret;
 }
-#endif
+
 static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -1925,7 +1918,6 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 	return false;
 }
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 /* Perform updates here which need to be deferred until next vupdate
  *
  * i.e. blnd lut, 3dlut, and shaper lut bypass regs are double buffered
@@ -1944,7 +1936,6 @@ static void process_deferred_updates(struct dc *dc)
 				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
 	}
 }
-#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 void dc_post_update_surfaces_to_stream(struct dc *dc)
 {
@@ -1971,9 +1962,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
 		}
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	process_deferred_updates(dc);
-#endif
 
 	dc->hwss.optimize_bandwidth(dc, context);
 
@@ -1987,9 +1976,7 @@ static void init_state(struct dc *dc, struct dc_state *context)
 	 * initialize and obtain IP and SOC the base DML instance from DC is
 	 * initially copied into every context
 	 */
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_lib));
-#endif
 }
 
 struct dc_state *dc_create_state(struct dc *dc)
@@ -2361,11 +2348,9 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	int i;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dc->idle_optimizations_allowed)
 		overall_type = UPDATE_TYPE_FULL;
 
-#endif
 	if (stream_status == NULL || stream_status->plane_count != surface_count)
 		overall_type = UPDATE_TYPE_FULL;
 
@@ -2874,10 +2859,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if (update_type == UPDATE_TYPE_FULL) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_allow_idle_optimizations(dc, false);
 
-#endif
 		if (get_seamless_boot_stream_count(context) == 0)
 			dc->hwss.prepare_bandwidth(dc, context);
 
@@ -2895,7 +2878,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
 		struct pipe_ctx *odm_pipe;
@@ -2904,7 +2886,6 @@ static void commit_planes_for_stream(struct dc *dc,
 			for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
-#endif
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
@@ -3014,7 +2995,6 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
-#ifdef CONFIG_DRM_AMD_DC_DCN
 		if (dc->debug.validate_dml_output) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
 				struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
@@ -3028,7 +3008,6 @@ static void commit_planes_for_stream(struct dc *dc,
 						&context->res_ctx.pipe_ctx[i].ttu_regs);
 			}
 		}
-#endif
 	}
 
 	// Update Type FAST, Surface updates
@@ -3583,8 +3562,6 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 	return true;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 {
 	if (dc->debug.disable_idle_power_optimizations)
@@ -3740,7 +3717,6 @@ void dc_hardware_release(struct dc *dc)
 	if (dc->hwss.hardware_release)
 		dc->hwss.hardware_release(dc);
 }
-#endif
 
 /*
  *****************************************************************************
@@ -3760,13 +3736,12 @@ void dc_hardware_release(struct dc *dc)
  */
 bool dc_is_dmub_outbox_supported(struct dc *dc)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	/* YELLOW_CARP B0 USB4 DPIA needs dmub notifications for interrupts */
+	/* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
 	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
 	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
 	    !dc->debug.dpia_debug.bits.disable_dpia)
 		return true;
-#endif
+
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 643762542e4d..72376075db0c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -345,7 +345,6 @@ void context_clock_trace(
 		struct dc *dc,
 		struct dc_state *context)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	DC_LOGGER_INIT(dc->ctx->logger);
 	CLOCK_TRACE("Current: dispclk_khz:%d  max_dppclk_khz:%d  dcfclk_khz:%d\n"
 			"dcfclk_deep_sleep_khz:%d  fclk_khz:%d  socclk_khz:%d\n",
@@ -363,7 +362,6 @@ void context_clock_trace(
 			context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz,
 			context->bw_ctx.bw.dcn.clk.fclk_khz,
 			context->bw_ctx.bw.dcn.clk.socclk_khz);
-#endif
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 07f154fc4e56..9529b924742e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -804,7 +804,6 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 
 static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Apply work around for tunneled MST on certain USB4 docks. Always use DSC if dock
 	 * reports DSC support.
 	 */
@@ -815,7 +814,6 @@ static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
 			link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
 			!link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around)
 		link->wa_flags.dpia_mst_dsc_always_on = true;
-#endif
 }
 
 static void revert_dpia_mst_dsc_always_on_wa(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5e49e346aa06..975d631534b5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5127,12 +5127,10 @@ void dp_retrieve_lttpr_cap(struct dc_link *link)
 	else
 		link->lttpr_support = LTTPR_CHECK_EXT_SUPPORT;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Check DP tunnel LTTPR mode debug option. */
 	if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
 	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
 		link->lttpr_support = LTTPR_UNSUPPORTED;
-#endif
 
 	if (link->lttpr_support > LTTPR_UNSUPPORTED) {
 		/* By reading LTTPR capability, RX assumes that we will enable
@@ -5626,9 +5624,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 		 * only if required.
 		 */
 		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 				!link->dc->debug.dpia_debug.bits.disable_force_tbt3_work_around &&
-#endif
 				link->dpcd_caps.is_branch_dev &&
 				link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
 				link->dpcd_caps.branch_hw_revision == DP_BRANCH_HW_REV_10 &&
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index 0e95bc5df4e7..a5765f36d86f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -547,11 +547,9 @@ static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
 				dp_translate_training_aux_read_interval(
 					link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* Check debug option for extending aux read interval. */
 	if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
 		wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
-#endif
 
 	return wait_time_microsec;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 147c6a3c6312..f702919a2279 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -56,7 +56,6 @@
 #include "dce110/dce110_resource.h"
 #include "dce112/dce112_resource.h"
 #include "dce120/dce120_resource.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dcn10/dcn10_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
@@ -68,7 +67,6 @@
 #include "dcn31/dcn31_resource.h"
 #include "dcn315/dcn315_resource.h"
 #include "dcn316/dcn316_resource.h"
-#endif
 
 #define DC_LOGGER_INIT(logger)
 
@@ -124,7 +122,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		else
 			dc_version = DCE_VERSION_12_0;
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case FAMILY_RV:
 		dc_version = DCN_VERSION_1_0;
 		if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev))
@@ -165,7 +162,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASICREV_IS_GC_10_3_7(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_16;
 		break;
-#endif
 
 	default:
 		dc_version = DCE_VERSION_UNKNOWN;
@@ -397,7 +393,6 @@ bool resource_construct(
 		}
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	for (i = 0; i < caps->num_mpc_3dlut; i++) {
 		pool->mpc_lut[i] = dc_create_3dlut_func();
 		if (pool->mpc_lut[i] == NULL)
@@ -406,7 +401,7 @@ bool resource_construct(
 		if (pool->mpc_shaper[i] == NULL)
 			DC_ERR("DC: failed to create MPC shaper!\n");
 	}
-#endif
+
 	dc->caps.dynamic_audio = false;
 	if (pool->audio_count < pool->stream_enc_count) {
 		dc->caps.dynamic_audio = true;
@@ -1369,7 +1364,6 @@ static struct pipe_ctx *acquire_free_pipe_for_head(
 	return pool->funcs->acquire_idle_pipe_for_layer(context, pool, head_pipe->stream);
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static int acquire_first_split_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1404,7 +1398,6 @@ static int acquire_first_split_pipe(
 	}
 	return -1;
 }
-#endif
 
 bool dc_add_plane_to_context(
 		const struct dc *dc,
@@ -1447,13 +1440,12 @@ bool dc_add_plane_to_context(
 	while (head_pipe) {
 		free_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
 
-	#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (!free_pipe) {
 			int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 			if (pipe_idx >= 0)
 				free_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
 		}
-	#endif
+
 		if (!free_pipe) {
 			dc_plane_state_release(plane_state);
 			return false;
@@ -2259,10 +2251,8 @@ enum dc_status resource_map_pool_resources(
 		/* acquire new resources */
 		pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	if (pipe_idx < 0)
 		pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
-#endif
 
 	if (pipe_idx < 0 || context->res_ctx.pipe_ctx[pipe_idx].stream_res.tg == NULL)
 		return DC_NO_CONTROLLER_RESOURCE;
@@ -2453,7 +2443,6 @@ enum dc_status dc_validate_global_state(
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate))
 			result = DC_FAIL_BANDWIDTH_VALIDATE;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/*
 	 * Only update link encoder to stream assignment after bandwidth validation passed.
 	 * TODO: Split out assignment and validation.
@@ -2461,7 +2450,6 @@ enum dc_status dc_validate_global_state(
 	if (result == DC_OK && dc->res_pool->funcs->link_encs_assign && fast_validate == false)
 		dc->res_pool->funcs->link_encs_assign(
 			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
-#endif
 
 	return result;
 }
@@ -3189,10 +3177,8 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format)
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
 	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
-#endif
 		return 32;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
@@ -3345,7 +3331,6 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 	/* TODO - get transmitter to phy idx mapping from DMUB */
 	uint8_t phy_idx = transmitter - TRANSMITTER_UNIPHY_A;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dc->ctx->dce_version == DCN_VERSION_3_1 &&
 			dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
 		switch (transmitter) {
@@ -3369,7 +3354,7 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 			break;
 		}
 	}
-#endif
+
 	return phy_idx;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index c4e871f358ab..acca35d86c10 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -314,9 +314,7 @@ bool dc_stream_set_cursor_attributes(
 	const struct dc_cursor_attributes *attributes)
 {
 	struct dc  *dc;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool reset_idle_optimizations = false;
-#endif
 
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
@@ -346,12 +344,10 @@ bool dc_stream_set_cursor_attributes(
 #endif
 	program_cursor_attributes(dc, stream, attributes);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* re-enable idle optimizations if necessary */
 	if (reset_idle_optimizations)
 		dc_allow_idle_optimizations(dc, true);
 
-#endif
 	return true;
 }
 
@@ -396,9 +392,7 @@ bool dc_stream_set_cursor_position(
 	const struct dc_cursor_position *position)
 {
 	struct dc  *dc;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool reset_idle_optimizations = false;
-#endif
 
 	if (NULL == stream) {
 		dm_error("DC: dc_stream is NULL!\n");
@@ -424,12 +418,10 @@ bool dc_stream_set_cursor_position(
 	stream->cursor_position = *position;
 
 	program_cursor_position(dc, stream, position);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* re-enable idle optimizations if necessary */
 	if (reset_idle_optimizations)
 		dc_allow_idle_optimizations(dc, true);
 
-#endif
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e37d9c19f089..0f86bb809e04 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -222,7 +222,6 @@ struct dc_dcc_setting {
 	unsigned int max_compressed_blk_size;
 	unsigned int max_uncompressed_blk_size;
 	bool independent_64b_blks;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	//These bitfields to be used starting with DCN
 	struct {
 		uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN (the worst compression case)
@@ -230,7 +229,6 @@ struct dc_dcc_setting {
 		uint32_t dcc_256_128_128 : 1;		//available starting with DCN
 		uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN (the best compression case)
 	} dcc_controls;
-#endif
 };
 
 struct dc_surface_dcc_cap {
@@ -332,9 +330,7 @@ struct dc_config {
 	bool enable_4to1MPC;
 	bool enable_windowed_mpo_odm;
 	bool allow_edp_hotplug_detection;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool clamp_min_dcfclk;
-#endif
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
 	bool is_asymmetric_memory;
@@ -395,14 +391,12 @@ enum dcn_pwr_state {
 	DCN_PWR_STATE_LOW_POWER = 3,
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 enum dcn_zstate_support_state {
 	DCN_ZSTATE_SUPPORT_UNKNOWN,
 	DCN_ZSTATE_SUPPORT_ALLOW,
 	DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_DISALLOW,
 };
-#endif
 /*
  * For any clocks that may differ per pipe
  * only the max is stored in this structure
@@ -420,10 +414,8 @@ struct dc_clocks {
 	int phyclk_khz;
 	int dramclk_khz;
 	bool p_state_change_support;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
-#endif
 	enum dcn_pwr_state pwr_state;
 	/*
 	 * Elements below are not compared for the purposes of
@@ -653,9 +645,7 @@ struct dc_debug_options {
 	bool disable_pplib_clock_request;
 	bool disable_clock_gate;
 	bool disable_mem_low_power;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool pstate_enabled;
-#endif
 	bool disable_dmcu;
 	bool disable_psr;
 	bool force_abm_enable;
@@ -673,20 +663,16 @@ struct dc_debug_options {
 	bool remove_disconnect_edp;
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
 	bool disable_z9_mpc;
-#endif
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
 	bool dmub_offload_enabled;
 	bool dmcub_emulation;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_idle_power_optimizations;
 	unsigned int mall_size_override;
 	unsigned int mall_additional_timer_percent;
 	bool mall_error_as_fatal;
-#endif
 	bool dmub_command_table; /* for testing only */
 	struct dc_bw_validation_profile bw_val_profile;
 	bool disable_fec;
@@ -695,9 +681,7 @@ struct dc_debug_options {
 	 * watermarks are not affected.
 	 */
 	unsigned int force_min_dcfclk_mhz;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	int dwb_fi_phase;
-#endif
 	bool disable_timing_sync;
 	bool cm_in_bypass;
 	int force_clock_mode;/*every mode change.*/
@@ -729,11 +713,9 @@ struct dc_debug_options {
 	enum det_size crb_alloc_policy;
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool enable_z9_disable_interface;
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
-#endif
 	bool apply_vendor_specific_lttpr_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
@@ -767,11 +749,9 @@ struct dc {
 	/* Inputs into BW and WM calculations. */
 	struct bw_calcs_dceip *bw_dceip;
 	struct bw_calcs_vbios *bw_vbios;
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	struct dcn_soc_bounding_box *dcn_soc;
 	struct dcn_ip_params *dcn_ip;
 	struct display_mode_lib dml;
-#endif
 
 	/* HW functions */
 	struct hw_sequencer_funcs hwss;
@@ -780,12 +760,8 @@ struct dc {
 	/* Require to optimize clocks and bandwidth for added/removed planes */
 	bool optimized_required;
 	bool wm_optimized_required;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool idle_optimizations_allowed;
-#endif
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool enable_c20_dtm_b0;
-#endif
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
 
@@ -835,9 +811,7 @@ struct dc_init_data {
 	uint64_t log_mask;
 
 	struct dpcd_vendor_signature vendor_signature;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool force_smu_not_present;
-#endif
 };
 
 struct dc_callback_init {
@@ -1030,9 +1004,7 @@ struct dc_plane_state {
 	struct dc_transfer_func *in_shaper_func;
 	struct dc_transfer_func *blend_tf;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_transfer_func *gamcor_tf;
-#endif
 	enum surface_pixel_format format;
 	enum dc_rotation_angle rotation;
 	enum plane_stereo_format stereo_format;
@@ -1169,13 +1141,11 @@ void dc_resource_state_construct(
 		const struct dc *dc,
 		struct dc_state *dst_ctx);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dc_acquire_release_mpc_3dlut(
 		struct dc *dc, bool acquire,
 		struct dc_stream_state *stream,
 		struct dc_3dlut **lut,
 		struct dc_transfer_func **shaper);
-#endif
 
 void dc_resource_state_copy_construct(
 		const struct dc_state *src_ctx,
@@ -1306,10 +1276,8 @@ struct hdcp_caps {
 
 #include "dc_link.h"
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
 
-#endif
 /*******************************************************************************
  * Sink Interfaces - A sink corresponds to a display output device
  ******************************************************************************/
@@ -1433,7 +1401,6 @@ bool dc_is_dmcu_initialized(struct dc *dc);
 
 enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
 void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 
 bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
 				struct dc_cursor_attributes *cursor_attr);
@@ -1458,13 +1425,9 @@ void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable);
 /* cleanup on driver unload */
 void dc_hardware_release(struct dc *dc);
 
-#endif
-
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
-#endif
 
 bool dc_is_dmub_outbox_supported(struct dc *dc);
 bool dc_enable_dmub_notifications(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 31109db02e93..fb6a2d7b6470 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -160,9 +160,7 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable);
-#endif
 
 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 951c9b60917d..26f3a55c35d7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -33,9 +33,7 @@
 #include "dc_bios_types.h"
 #include "mem_input.h"
 #include "hubp.h"
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "mpc.h"
-#endif
 #include "dwb.h"
 #include "mcif_wb.h"
 #include "panel_cntl.h"
@@ -181,7 +179,6 @@ struct resource_funcs {
 	void (*update_bw_bounding_box)(
 			struct dc *dc,
 			struct clk_bw_params *bw_params);
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool (*acquire_post_bldn_3dlut)(
 			struct resource_context *res_ctx,
 			const struct resource_pool *pool,
@@ -194,7 +191,7 @@ struct resource_funcs {
 			const struct resource_pool *pool,
 			struct dc_3dlut **lut,
 			struct dc_transfer_func **shaper);
-#endif
+
 	enum dc_status (*add_dsc_to_stream_resource)(
 			struct dc *dc, struct dc_state *state,
 			struct dc_stream_state *stream);
@@ -254,10 +251,9 @@ struct resource_pool {
 	struct hpo_dp_stream_encoder *hpo_dp_stream_enc[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_count;
 	struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
 	struct dc_transfer_func *mpc_shaper[MAX_PIPES];
-#endif
+
 	struct {
 		unsigned int xtalin_clock_inKhz;
 		unsigned int dccg_ref_clock_inKhz;
@@ -286,9 +282,7 @@ struct resource_pool {
 	struct dmcu *dmcu;
 	struct dmub_psr *psr;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct abm *multiple_abms[MAX_PIPES];
-#endif
 
 	const struct resource_funcs *funcs;
 	const struct resource_caps *res_cap;
@@ -380,7 +374,6 @@ struct pipe_ctx {
 	struct pipe_ctx *next_odm_pipe;
 	struct pipe_ctx *prev_odm_pipe;
 
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	struct _vcs_dpi_display_dlg_regs_st dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st rq_regs;
@@ -390,7 +383,7 @@ struct pipe_ctx {
 	struct _vcs_dpi_display_e2e_pipe_params_st dml_input;
 	int det_buffer_size_kb;
 	bool unbounded_req;
-#endif
+
 	union pipe_update_flags update_flags;
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
@@ -419,9 +412,7 @@ struct resource_context {
 	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
 	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
 	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool is_mpc_3dlut_acquired[MAX_PIPES];
-#endif
 };
 
 struct dce_bw_output {
@@ -484,9 +475,7 @@ struct dc_state {
 
 	/* Note: these are big structures, do *not* put on stack! */
 	struct dm_pp_display_configuration pp_display_cfg;
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	struct dcn_bw_internal_vars dcn_bw_vars;
-#endif
 
 	struct clk_mgr *clk_mgr;
 
-- 
2.35.1

