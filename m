Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D446C4321E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633A410E279;
	Thu, 24 Nov 2022 21:14:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA4510E271
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI+mVV5W+4IwQUrK5E9C/YP26V3adhpbvi5d8vBL8rKc6+pSESf0yMmM95AW+q3575AfZc1b0F5mqm+DMO7QJOu5egYy1fITZF0bTEWet9ymgTlDFxwZ9rbMCSTvV+IT81a/q+pXiInI8RFLcN8iFIeFqW1Yq/xAY0E8wg8dd7S5AerwsVkQ3plvCKDegVYfa/kx2qCbwPBoQ9HgG/AYnV3coRHFyA1qKfM4cNwonWQyfqhS3eYB1qmMzlZxRRU0aEv//KJxul7FbceALD8K45tSwTESl5C9/CZHILNjvribkT0BSqnUGmLTxAWStZ5QIszTaESU+n1xkBOy+QZv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XuNCqjhybX9M1wsRhTlf1zn6GiL//Fz0qIoHaE8NOc=;
 b=WtCP4OuQzypx+INSRvrsLJIsmTS4A6sbudqUpjGWibFbXJjhGUy6El8igMQbgkXcViXbI0dl8RejTl4+ZS+Q+fWYlrWFf2Wl5+HHtidBROg1GQFSnABUNk5SYjpuhXj7Y587kn1Vw1c4Nsy7/jx6vUp7J0j6mFGZWG08w+hwlXOFNCbxVvtbnI1gdGYvz3xjmH1C+L+s7AoaQm2NNOzfDeoTewqljekzTzBhgoR7ofqTOk5tDbqXgEQooO96gt4j4rX63edLhuULMMwu9GoFTuwsvROpWXMG64RMxIODWBdFk7g5x+at7VGOx+Ams223GPtKgLGmATRjGW3Ciq1k0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XuNCqjhybX9M1wsRhTlf1zn6GiL//Fz0qIoHaE8NOc=;
 b=RIb5aOuLGZpIbWMiV4Ib/45Mw+udYdG9F6C5t/64ZDyKLPaC5RxRNu6vDge0CRPSlqKToEsQjl1V+dph0XYxIf/1Cudb90Qr8gRbEb7nCeZCq02JWoEJv0ppMMMLLfRWa0sKX9/FHK2/pJy120VBZ5EOb+NA1fsBMw7KFY3m1Wg=
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 21:14:13 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::79) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 21:14:12 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:09 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Don't overwrite subvp pipe info in
 fast updates
Date: Thu, 24 Nov 2022 16:13:45 -0500
Message-ID: <20221124211348.214136-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4557f0c9-3373-4cef-f83a-08dace60d605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOFoyAzypg3vZbTvqi8Ty93+Qn3ISJ7mxYC8LTmU/QMGqPfJkRzJDuEK/JNPs8+qJPaD16HAAy5JEXhat+/KeEwDV3f7n2KwQhW4XVDR/4iCboEr21RkLQW+ZqFbPbnCC9mIAOySuNzCEWD1cGAmLY0luzUAw8Wrw9yLlxMjRvvNJUu60Teb6pZUfpruldgasnjooQsi1dLiFi5+VhnXoYUm4YQMVPw0yk/KjIE3mjkUoxAlM8YqlIh0oqJK3YdOGIvfAGKg4v6dvyST8Pg3c1v9/eIZzVGVWotEJb7HAKpk+hKUYVwtGF6oAjTgurc/VWhseVzM+FhIfzAVeUdLYre4rJmhtajlTyTxyVybIFr1usmKThQ/fK5vc3h9Tz3Ci9wk+qJzwW/OOiNomCk+/o75FbLmm9iGIx8Dv4erp7rSeKkey2+hFYwVuvJQJLtsib/0lDv6H+WDX77MNOpQ9iMzQzVXla4F3+L6uDamSAI79wXJBerqcqsU0CHFpWZxDjwV81idQJMXH1v1aqNtq11iKzSm3fUfQY2P7QdGG8qyTWSC2veQt/y+RmcHXXQltGj6sp0Y6u+BnlX2xGvqELcVjE62uWMMi5D09hkM56ThAkKwSUcOoLa1007OGW4rL3gbfGOcvRRMz5NtinJw7GaHNFs1I4/IC1nDDiz/hOfDaXsV2dxA4luf7YwhFkle2V0gSo7S6vxBhUn8y+ce1xVKlYr4GETdy2wWQZ43b6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(15650500001)(5660300002)(36860700001)(70206006)(36756003)(8676002)(70586007)(41300700001)(6916009)(54906003)(316002)(1076003)(4326008)(356005)(2616005)(26005)(82310400005)(336012)(16526019)(6666004)(8936002)(186003)(426003)(47076005)(81166007)(40480700001)(40460700003)(82740400003)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:12.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4557f0c9-3373-4cef-f83a-08dace60d605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- This is a workaround to avoid concurrency issues -- a fast update
  creates a shallow copy of the dc current_state, and removes all
  subvp/phantom related flags.
- We want to prevent the fast update thread from removing those
  flags in case there's another thread running that requires
  the info for proper programming

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 64 +++++++++++--------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 5 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a7bfe0b6a5f3..87994ae0a397 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3061,7 +3061,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		 * Ensures that we have enough pipes for newly added MPO planes
 		 */
 		if (dc->res_pool->funcs->remove_phantom_pipes)
-			dc->res_pool->funcs->remove_phantom_pipes(dc, context);
+			dc->res_pool->funcs->remove_phantom_pipes(dc, context, false);
 
 		/*remove old surfaces from context */
 		if (!dc_rem_all_planes_for_stream(dc, stream, context)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 06489df85ac1..e4dbc8353ea3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1743,7 +1743,7 @@ void dcn32_retain_phantom_pipes(struct dc *dc, struct dc_state *context)
 }
 
 // return true if removed piped from ctx, false otherwise
-bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
+bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context, bool fast_update)
 {
 	int i;
 	bool removed_pipe = false;
@@ -1770,14 +1770,23 @@ bool dcn32_remove_phantom_pipes(struct dc *dc, struct dc_state *context)
 			removed_pipe = true;
 		}
 
-		// Clear all phantom stream info
-		if (pipe->stream) {
-			pipe->stream->mall_stream_config.type = SUBVP_NONE;
-			pipe->stream->mall_stream_config.paired_stream = NULL;
-		}
+		/* For non-full updates, a shallow copy of the current state
+		 * is created. In this case we don't want to erase the current
+		 * state (there can be 2 HIRQL threads, one in flip, and one in
+		 * checkMPO) that can cause a race condition.
+		 *
+		 * This is just a workaround, needs a proper fix.
+		 */
+		if (!fast_update) {
+			// Clear all phantom stream info
+			if (pipe->stream) {
+				pipe->stream->mall_stream_config.type = SUBVP_NONE;
+				pipe->stream->mall_stream_config.paired_stream = NULL;
+			}
 
-		if (pipe->plane_state) {
-			pipe->plane_state->is_phantom = false;
+			if (pipe->plane_state) {
+				pipe->plane_state->is_phantom = false;
+			}
 		}
 	}
 	return removed_pipe;
@@ -1950,23 +1959,28 @@ int dcn32_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;
 
-		switch (pipe->stream->mall_stream_config.type) {
-		case SUBVP_MAIN:
-			pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_sub_viewport;
-			subvp_in_use = true;
-			break;
-		case SUBVP_PHANTOM:
-			pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_phantom_pipe;
-			pipes[pipe_cnt].pipe.src.use_mall_for_static_screen = dm_use_mall_static_screen_disable;
-			// Disallow unbounded req for SubVP according to DCHUB programming guide
-			pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-			break;
-		case SUBVP_NONE:
-			pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_disable;
-			pipes[pipe_cnt].pipe.src.use_mall_for_static_screen = dm_use_mall_static_screen_disable;
-			break;
-		default:
-			break;
+		/* Only populate DML input with subvp info for full updates.
+		 * This is just a workaround -- needs a proper fix.
+		 */
+		if (!fast_validate) {
+			switch (pipe->stream->mall_stream_config.type) {
+			case SUBVP_MAIN:
+				pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_sub_viewport;
+				subvp_in_use = true;
+				break;
+			case SUBVP_PHANTOM:
+				pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_phantom_pipe;
+				pipes[pipe_cnt].pipe.src.use_mall_for_static_screen = dm_use_mall_static_screen_disable;
+				// Disallow unbounded req for SubVP according to DCHUB programming guide
+				pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
+				break;
+			case SUBVP_NONE:
+				pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_disable;
+				pipes[pipe_cnt].pipe.src.use_mall_for_static_screen = dm_use_mall_static_screen_disable;
+				break;
+			default:
+				break;
+			}
 		}
 
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 4e6b71832187..13fbc574910b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -70,7 +70,7 @@ bool dcn32_release_post_bldn_3dlut(
 		struct dc_transfer_func **shaper);
 
 bool dcn32_remove_phantom_pipes(struct dc *dc,
-		struct dc_state *context);
+		struct dc_state *context, bool fast_update);
 
 void dcn32_retain_phantom_pipes(struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3a9b714e7138..5a4cdb559d4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1203,7 +1203,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		// If SubVP pipe config is unsupported (or cannot be used for UCLK switching)
 		// remove phantom pipes and repopulate dml pipes
 		if (!found_supported_config) {
-			dc->res_pool->funcs->remove_phantom_pipes(dc, context);
+			dc->res_pool->funcs->remove_phantom_pipes(dc, context, false);
 			vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] = dm_dram_clock_change_unsupported;
 			*pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, false);
 
@@ -1515,7 +1515,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		return false;
 
 	// For each full update, remove all existing phantom pipes first
-	dc->res_pool->funcs->remove_phantom_pipes(dc, context);
+	dc->res_pool->funcs->remove_phantom_pipes(dc, context, fast_validate);
 
 	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 40a8096a6ccc..525f8f0b8732 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -240,7 +240,7 @@ struct resource_funcs {
 			unsigned int pipe_cnt,
             unsigned int index);
 
-	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context);
+	bool (*remove_phantom_pipes)(struct dc *dc, struct dc_state *context, bool fast_update);
 	void (*retain_phantom_pipes)(struct dc *dc, struct dc_state *context);
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*save_mall_state)(struct dc *dc, struct dc_state *context, struct mall_temp_config *temp_config);
-- 
2.34.1

