Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B4C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AA461458
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AA461458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38916EB23;
	Fri, 23 Apr 2021 02:40:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6E76EB23
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+zedaIuOdiZwcf3GuKSKAIogo7yDq7fF6p7jAcQNSCCTu5vYqDy2dqYIjrEzBV6BloUa/x/bInsFxpn7AvbyY5u1KRztuOS+IEHe/NSqqzwxwmq+4LRntn9dV+cIL8CWhKSCm5O4OA8t7kZKapWlbpVADSvcJ0PWL9NCF+w58HfsAqWHBXWvhwV06Y2GxsyNybcKUGpZIQfKH5YMD6dL6D9LLbYGZoo4gk/OVWE6f+45zo0Isf+EK9nVJYyNxn9JfjSsG4GyyXrNWx4B7agvAtvfhgAhaFi69CA0BxYakMyGASuNEpLONEnIu1xNCIseIml+ToGXxgEzSrZQ24tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwto+Qsk+Kq8EbXlXitLExuW64CxdX41RFPiEqRgDnY=;
 b=WbPnd6+ZxGJBubsTDOoU80PAgcWhRkQH+EYC8iyVaQFuZTaux8Z9WVMgvtH3seXHu/DXip8lKCKoQ+p4Ry/GY4LEyVdTwXncRIfGiLbju12go04P5gqLdVoLqZPiWUdJjCFokQr71rDYpaK/Vcfgwo54Ru5VeH6aqQ4L4IuCAMhYkqae5infR4H7tfeoJ1/rBa5/Rp5pXV6VumoE4GyhyLHBtIg6KfPl2ZG/Y3vsqIogOTkdmzrL4JWAobFvYCfU2VUvUyKO24wJ9FZt4ssyrNx6/D3jQRk/ZeR3gVpDvivEl+GE2r6yxTTNgtZVweEhcHbTOCrrgXP6qDoCpTu2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwto+Qsk+Kq8EbXlXitLExuW64CxdX41RFPiEqRgDnY=;
 b=P+J4Zn9VRHm+D1XbzMOEBbSvxG9qrhQyw8PX5vCwBPv7/uLiFa6CeJwTl3G557IyCNtqRjgVaZyBIT1ApNXEOtEV4wNQakOdBmIq9818FBEtX56kw4tKnm5uBa0LPnSSp64DFAZgRuQp7cH8NP3P2BEN+uP0nJTYI6mJjaTffo8=
Received: from MWHPR22CA0002.namprd22.prod.outlook.com (2603:10b6:300:ef::12)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 02:39:59 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::3b) by MWHPR22CA0002.outlook.office365.com
 (2603:10b6:300:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 02:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:39:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:39:58 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:39:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Revert wait vblank on update dpp clock
Date: Fri, 23 Apr 2021 10:37:01 +0800
Message-ID: <20210423023714.22044-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4c52fc6-f87d-46da-1ee5-08d9060116d1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:
X-Microsoft-Antispam-PRVS: <CH0PR12MB529999BF459ACDB613091952FC459@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZe3FrFEo8q26Jpc+f2sDEvAJN/sHsVQj2RE+TY2/fzwtbw21lcQcEF2hzw2k7SU8JadmiEVW28QioOhNrMyD8lRcGypfZ7rFT6lqfpiD2bRNvo26OgOEaIUmdCXaOq5i/aQE+qoG0KdnjfUqsaUlV4t+87bUMUf9Qt8aEyXfT1O6RX3nAccC7Y9HOv2Eb2h3wTVowJR9t0GU/l61HfrqG/ClCmfaRnwM45Na3FU5GpanG0lN1iQAyDRfvBnnhzz5M6PJ7vTH3DQli1TBTrjmbOKrdUY9481tsjnG2Fpp1pDvMCn97Cbf+1/+srCSJusw05sV37CqGMOY7RRD3OLvwplTb4PSgGKrlTEK+5GMMxaKs53ULdeVZslKBw9mG3lYrg7HZ7j8drMRFR8ZuCneuS3PJ5g7zkK/g1tjwZfBA50y5PfCrlseKWS2X10N/HOmOap37qFLM/NrzT0RCvICNHpP4M1HIHd26CxbuDgVMrqEVZNxJyLsv28JisyKN2+EG7Xr/gx5qQ1/bdacwCnNv7V9hnxHsC+IUiRmTwaY92FB8WM/YISpWwRQ7eTR1rzqsvWRadEMqOC9lXmkI6EOQIIBYhABP8rFM20otLDZ15ylZ3Izbismv6GxnOSyEEh5hmASGrV9PTmrCQpoit4Q1hEIVpWLPs1Gsoy1ttNjCnLCexLpJc5T4fYD58YQk3Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(316002)(26005)(54906003)(83380400001)(70586007)(8936002)(70206006)(36756003)(47076005)(426003)(36860700001)(2616005)(15650500001)(6666004)(4326008)(82310400003)(86362001)(2906002)(5660300002)(186003)(356005)(7696005)(82740400003)(6916009)(81166007)(478600001)(1076003)(8676002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:39:59.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c52fc6-f87d-46da-1ee5-08d9060116d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
This change only fix dpp clock switch to lower case.
New solution later can fix both case, which is "dc: skip
program clock when allow seamless boot"

[How]
This reverts commit "dc: wait vblank when stream enabled
and update dpp clock"

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c   | 10 +---------
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 13 -------------
 drivers/gpu/drm/amd/display/dc/dc.h                 |  1 -
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index a06e86853bb9..49d19fdd750b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -128,7 +128,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count, i;
+	int display_count;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -210,14 +210,6 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dppclk_khz,
 				safe_to_lower);
 
-		for (i = 0; i < context->stream_count; i++) {
-			if (context->streams[i]->signal == SIGNAL_TYPE_EDP &&
-				context->streams[i]->apply_seamless_boot_optimization) {
-				dc_wait_for_vblank(dc, context->streams[i]);
-				break;
-			}
-		}
-
 		clk_mgr_base->clks.actual_dppclk_khz =
 				rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4713f09bcbf1..e57df2f6f824 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3219,19 +3219,6 @@ void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 	}
 }
 
-void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream) {
-			struct timing_generator *tg =
-				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
-			tg->funcs->wait_for_state(tg, CRTC_STATE_VBLANK);
-			break;
-		}
-}
-
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info)
 {
 	info->displayClock				= (unsigned int)state->bw_ctx.bw.dcn.clk.dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 100d434f7a03..65f801b50686 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -719,7 +719,6 @@ void dc_init_callbacks(struct dc *dc,
 void dc_deinit_callbacks(struct dc *dc);
 void dc_destroy(struct dc **dc);
 
-void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream);
 /*******************************************************************************
  * Surface Interfaces
  ******************************************************************************/
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
