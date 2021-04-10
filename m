Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD7BC43470
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8981E61182
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8981E61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69E56EC78;
	Sat, 10 Apr 2021 02:05:02 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690052.outbound.protection.outlook.com [40.107.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69526EC73
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZwWYZZgEiKnCcUECk4lpokFo3ds2tZUMTbOHjejxB9Z4aC0s/nnjQyGtV+jRzgl/rjm2YbH8+yG+FoBdwTjWIcWeBjS2em4AMdl5i6/nxSBNp2iHozuz3HUNpMjxoKpCLdy+ZGNhcY629hkdvtKVkS6GkPk/XSvD0S/rDw3U9/aRHDRUckn97eAWz50pPntQRsyZMD+3KIXdAiP2gKFN7faDeyGNXVcNnHfL91dIoe3f0BGhz53MlSqqCTuXPpjR7Rd0k5ZcNMbHoMEX4PBtXPPPvpi0l1K2T3znAIPwVLSmYUy/YXIzpFqZdebmL8QJutIKwPCPZxrIXD1v/FMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHf2+j2UvIn9md8RdcxsqUQkN5gJJD6LX99ny/9QG5Y=;
 b=QgaB1YRQ/PVSGzgm739ciyHgHUjHoXAqlT956WUz5PevK9X/T+QsIYacChYSe1NE2JeQX4jADPU7u8USEr1PE7wDWeOFzFrwATmDGLUkKcsErCGrn4ahyY9V7rfNZ0iOKjY+bZp+NczVSwEanjJgM3mxbg39l8WTE0atLX9RLZhhFAbH+coPjfsVWGyWAlRz6ls6GAf8WO6J4uwC/H5E3KSE73hy/MEGfqMzScQhcbNckpWHFxEROyMaxDLv8jYjTfBYVj7nAhsXwFWb1RcZltkU1w8U3lloCHgBS9Y4/wCUwqDAQj/I/C0CgCIljZ7IZiDpauZ/PBp1wPkSx1dZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHf2+j2UvIn9md8RdcxsqUQkN5gJJD6LX99ny/9QG5Y=;
 b=r3LA0Rx+Yl52CXX6elG2GNoifUWgzT+ZS9TQh69FrctBGsNePOi7dPQWzuj/kpzdjGwjCJtohiVxpUSzsetWfaAzEqsNUUGgnbpUKY5hXXTZE4HPOQSXup4hMQ1EPNd2QY3DMr+RQ8pZR5rKz8UvcjbzBvWgQuMxVafL3ZWta/Q=
Received: from DM5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:3:93::30) by
 BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Sat, 10 Apr 2021 02:04:59 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::4e) by DM5PR20CA0020.outlook.office365.com
 (2603:10b6:3:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:57 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:56 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: wait vblank when stream enabled and
 update dpp clock
Date: Fri, 9 Apr 2021 22:03:56 -0400
Message-ID: <20210410020401.1100228-12-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8777811e-0808-4f51-958d-08d8fbc50b9d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2840:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2840D0E56EB2126A9BCE4CECF5729@BYAPR12MB2840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjTTws9hZUJRHWd6LatASD69YmVOIY9389LgUc5L5HoDp60xIWfkUJqNnOUXD280sDweVsitM/ZGOlyNFa3PyQkEIpyldgbrh13V9mawM02Xx7r7TwiKBCp+DaF62ZNeCED8jzct8ZqRJxtURXkgC13y+btm7YLj2rIpJPE9CjqXbHu5IUX6EH3SUCJd3EmCB5sdooLyJdaABKr+46l2FNGGS3vO5fSFhpu4lapUbI2wmGWm2xz7/bAsjebl3k1RKYKalbYFZxpnbnw65nnYU2lFiVIZtP652wXcozyf14OO9AT1dMZE5VNnMANrNTCa0CRp8iVyOjNF4JuyjTkXPn3hFi40QLExVBUu4aFFXeWRBvDSULLsk7u7ZIwevs6m6RzrEppStkF4VwxJCNu2FT5xFRfb0RXTKoEb9KNTRC9dE6rzBvfS3UvWIHLWAygvA9h60JgzuutAj6YN3WzEe0Aci2kMxEjZ8N7xrCuM22HtXoES2sk6Xtm+H56t7k6zhiZSOIf2x0clnt2506oA2vRR7L8TYQ/dBWv4DMlVRSHS/qi+zVfaf+QE4OvLfGEpFVn3DXQSUUuNhk97tP3G7ckgxlAkdD021HGlUEh4oXfSzbSH/2AtHfPaAiYp2crTl2cwmbFrq71C1mJQm335L8PmXqBQgRKF+X30faBw4Bv+rmslE65t4kNshKwjFcz1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(8676002)(83380400001)(8936002)(15650500001)(478600001)(82740400003)(426003)(36860700001)(4326008)(82310400003)(2616005)(336012)(2906002)(86362001)(36756003)(81166007)(70586007)(70206006)(356005)(186003)(6916009)(5660300002)(316002)(7696005)(1076003)(47076005)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:59.3921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777811e-0808-4f51-958d-08d8fbc50b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2840
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
When boot into OS, seamless boot device won't blank stream.
Driver update dpp clock when scanline position in vactive will show
garbage on screen.

[How]
Wait for vblank for seamless boot edp display when driver update dpp clock.
The apply seamless boot flag will be clear when OS call SetVisibility on.
Therefore we only wait for vblank once after boot into OS.

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c   | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 13 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h                 |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 887a54246bde..73e8878b03b6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -128,7 +128,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count, i;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -210,6 +210,14 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dppclk_khz,
 				safe_to_lower);
 
+		for (i = 0; i < context->stream_count; i++) {
+			if (context->streams[i]->signal == SIGNAL_TYPE_EDP &&
+				context->streams[i]->apply_seamless_boot_optimization) {
+				dc_wait_for_vblank(dc, context->streams[i]);
+				break;
+			}
+		}
+
 		clk_mgr_base->clks.actual_dppclk_khz =
 				rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 497e44ca98c1..757820a3f068 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3214,6 +3214,19 @@ void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 	}
 }
 
+void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream)
+{
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream) {
+			struct timing_generator *tg =
+				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
+			tg->funcs->wait_for_state(tg, CRTC_STATE_VBLANK);
+			break;
+		}
+}
+
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info)
 {
 	info->displayClock				= (unsigned int)state->bw_ctx.bw.dcn.clk.dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d218d665ed27..4d2ea508fa13 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -717,6 +717,7 @@ void dc_init_callbacks(struct dc *dc,
 void dc_deinit_callbacks(struct dc *dc);
 void dc_destroy(struct dc **dc);
 
+void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream);
 /*******************************************************************************
  * Surface Interfaces
  ******************************************************************************/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
