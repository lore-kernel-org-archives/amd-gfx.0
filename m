Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0433606A32F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kHC2KtCm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F7810F843;
	Tue, 17 Nov 2026 17:16:30 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B881C10F837
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaaQliHf/Vr97DtMbs/xnbEXLhlA5IZMPy5tQiaz2Xk6yf6rhT0f/UpL9CtUCE7BSHQY4TymhS23SdknIqU3+9SuQ8wbLY5x/ZWAz/NXP3QsXFTOdlFZXhlmyxdSVzCXTIJCcE5N6NGo/nCxxPeT461Mkf4+e9Mkb69DvsgKjR8vVcV8tRJo2UlEipDhfr6H/9Nq9JWwFKbik7kcrB3rDnq/oC+lPzexlb13mrwmCcCrSPxGuJwYMo+vzWkEDnU3gAbvsRjwVw3GSAnU1eSVQhUzflzHsB/RFmJgFWRKFzK6KNBx5AMHXn8H3PthcPV5ev74U7YwkPhJFIzR1yQUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJhSKIffY/GkSjB68/1/TT6X+ZhqwHS5YULJTC1heAw=;
 b=rIfC/Z35vZ8UOaMrdB27wMUga0YoAFPZkQlyr5aNnBguPqdlfVYM3mn6vKKpjz7pE2UhuDxA3y2+39Pj/4mV3YfddpEH6L3oNsfyEA0FVHA/Y0ZJJ4lLmtr0RK5yvDIh2BzDgBhGAUkqN0+8dK7daM+856i3IucbS0iCBJC2FTwpy6WcYh8ty0458htjeJBkHO2Cye5lHkLsJbKBOqRr6fSP8YOIP3N+PU9rCPR6jAcU3hgVxpphDEywLn3PhjD3xYQlnWQCuNdqzOZwvjWEHpVhSXWHJ4CZOswNZXbsh+zq3bSNMbe6Pk6ftX4CdVNOzQMCPHvvuhUZlSPvMkUbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJhSKIffY/GkSjB68/1/TT6X+ZhqwHS5YULJTC1heAw=;
 b=kHC2KtCmoQlvBbQa02rDfyw2yCRrGdrYYGgfZUIQwomLYbsayI01Aa0Ck8XRT0AXNC1gDaNT1LrUaX+bXYO6xdlGNpRc0Hb6HhEkV9yCY/8TNa6FO925JlGSldnqDMknGLguxyY125Qx29CR4HukB96TG2LoxvrHm5CnEcTT8is=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 17:16:20 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::82) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 17:16:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:16:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:16:06 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:15:57 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 23/33] drm/amd/display: Drop unused DC interfaces
Date: Tue, 17 Nov 2026 05:51:00 +0800
Message-ID: <20261116215641.2800595-24-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 125f1403-f0fa-43d4-d077-08df44ce7e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261021123027099003|261026121527099003|261021135927099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: NbkRi2tTHXsTM/vX4KL1F7ypwZZNjElgSphirctFfuzLleA5tPU/spAIZO3M/Bq8FUSZgRUEcm7JseYTLUxHIetGH++0ADyp+/JXA68Lwqi33WdIX43r3v116HrAk8BggHn5N4yDccocEC3BOjcxNtEup10VGDoW2mEALL39qOFlLqRPwHnbXB9QSMVbBMU+d1XVrqqWNkTlTr2CFeLSnWpU2vyP/f0U3qT2fdxM1YM3Q5tyng2QWe1Z0WbpllZRfQRbLEaqc0kNVBJ/s5Y99mVzA+3KXwn2Luqy7ZHVVxiFCoOsthIyW1vlz6GVVsAQ10iMU5+nzfoLWdaBrFDD1aPMCVEExme54uCsKNxqSjWXLxpic7po4kesN0sNQAZ5PIEnvHkpzGHExJQIALgBDtrpfTeIPrmOhZp0Mspil1g9+xXXBHHZNxb/ZXB3vgznpK10LGBt4GCZ/gWm71I05npnPrbEtMjJUX8wdGqfFdTluol6asO5JnzV/ZZJTEHa9qwxQFYCemED7wgEpTo+cXOk/IrmHCGPNlZn3q9IbBrbR6a/J8sYI65ycFP6J487phpIk7wBwHgdigdlTZAbZG+ND+foTK46tBR43q2Ka9jT5caRwdnnAUaATkO6z23lix9rR4RDA9uiFVTyWlMnYYySItBVh5Efc9padT3adhho7iUmbH0CJKhL6xH96k1QPie7cSDjmrl+xjTRWc0zsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261021123027099003)(261026121527099003)(261021135927099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YyhYLI1RBXoXzB1VbrZbNeoipSG6DXiWd4hz0pxz6GKv8QRAYv8hPe7ICWvBikSixw2b/XVM0zdcdRhHIq2bV5RBH1fEEdxDTf6SqqQqChzuZvn8WNMPWWeC2qOlp+qOi+a7SOa+MHEqugXKRBpU7WKfdJiwkpBksawjEgouMqUZVuD9SgjFZikpbMcXTibgAScAUJMFybvVc4kAhSKGgYY3z2VGLcWzZJB1xTYu4U8uG+1LfN9lr/Qjr6DqkAgnbqN21txehOodVN4ic7HaNCzvJrsSpXQ4h+3xbAKeX/RamxN0HyhSm4bOmZS9PKg1uAHVcRcxgEt3qmpOLLAllttiT1AETgh8XbNrzrzZkwaoxfa8z6g2Acp6HBanzans+8H4zWiurqfz+sFdOKUbheLqHIbFPsQewgrifZMf8y2o/ujHY7ChJZvL6EmVi5Ii
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:16:18.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125f1403-f0fa-43d4-d077-08df44ce7e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[why & how]
Cleanup for unused interfaces no longer in use by any DCN revision.

Cc: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                      | 8 --------
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h             | 6 ------
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h  | 8 --------
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 4 ----
 4 files changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 775259e5e478..7d0a47e7bc1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2489,14 +2489,6 @@ struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
 
 
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
-bool dc_set_fva_vrr_adjust(struct dc *dc,
-	struct dc_stream_state *stream,
-	struct fva_adj *fva_adj,
-	struct dc_crtc_timing_adjust *vrr_adj);
-
-int dc_get_hw_max_fva_factor(struct dc *dc,
-		struct dc_stream_state *stream,
-		unsigned int max_pixel_clock);
 
 void dc_set_vstartup_start(struct dc *dc,
 		struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 20504dfb1b13..387d2ebb2b7c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -1207,12 +1207,6 @@ struct mcif_buf_params {
 	uint8_t				tmz_id;
 };
 
-struct fva_adj {
-	unsigned int pixel_clock_100hz;
-	unsigned int max_pixel_clock_100hz;
-	unsigned int fva_factor;
-};
-
 enum symclk_state {
 	SYMCLK_OFF_TX_OFF,
 	SYMCLK_ON_TX_ON,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 65014d42195c..61470a51da23 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -72,14 +72,6 @@ enum dc_status dcn30_setup_hdmi_frl_link(
 		struct dc_link *link,
 		int hpo_inst,
 		enum clock_source_id frl_phy_clock_source_id);
-void dcn30_hw_set_fva_vrr_adj(struct dc *dc, struct pipe_ctx **pipe_ctx, int num_pipes,
-		struct fva_adj *fva_adj,
-		struct dc_crtc_timing_adjust *vrr_adj);
-
-int dcn30_hw_get_max_fva_factor(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_crtc_timing *timing,
-		unsigned int max_pixel_clock);
 
 bool dcn30_does_plane_fit_in_mall(struct dc *dc,
 		unsigned int pitch,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 52d4d57358cd..c538e89bfac4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -494,10 +494,6 @@ struct timing_generator_funcs {
 	void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
 	void (*set_drr_trigger_window)(struct timing_generator *optc,
 			uint32_t window_start, uint32_t window_end);
-	int (*set_fva_factor)(struct timing_generator *optc, struct fva_adj *fva_adj);
-	int (*get_max_hw_supported_fva_factor)(struct timing_generator *optc,
-		struct dc_crtc_timing *timing,
-		unsigned int max_pixclk_100hz);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
 			uint32_t limit);
 	void (*align_vblanks)(struct timing_generator *master_optc,
-- 
2.43.0

