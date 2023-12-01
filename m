Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D7BC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C653110E87A;
	Fri,  1 Dec 2023 13:28:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CB610E874
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2kpnPBTZ2tm6mJBFHEPjz6uwPFphlM201xQHohKglJRtmqUTGBAGrp+XHqr/ULr61hgQVcaqAAvO0Jo0ppiunVNwtpMQSAwHo4RVmzo2YeRf3eJlk5p6G0oCX/+r10hsA8GYLUROCEib1JLhplLQ0wzwlRCic5g25JLGYGSjsetTQ/1/kALYBWYhLpPyKBtbrvoGZ9IJrE058RV6Wjsg6cJWPTB6m5thc89k6vLjAaLg1H4bT/Q0mll42nzE6AMMR1DiAgK6A0VQzzDu7EjE/bH+ePTxaKlLBb7a4i+Xs42qhQcBkFs0CFdghAglm3Q0onN39sLyjNSnX+xI1nmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDJjU5SGBPg49eHwVxyLW7rdXjR5smmkPRX1adfayxQ=;
 b=Ug+KckN61H4oK/r1tcnfpHTYdLwMg3y0C4ln+oK6CnSRO7JeB/q5dnE+H70jADAevgkOU+BnmDiVdT49LDp2IrLORUZWlx0fdUnnTle0v5O0RaBuThRHGGwCnZMaYtY9AmSIYedvwmzsaqRHqgUDuxmnlplFdLKuQikjPSThihL04qUQ/G9ZTridBpPw3lk93GH3dw95RVFicw+N6OySD1otk0ehQZavDRvjvNL7iaXGEDcc5X8WBXQbP8qeq4NHnF0hNzUs1qtft+WR6UFt0Bml5pweOknuYaHwPgqk7vy6yP9AL/Q5nYJ3rLyBmBvc2qA544bnBVW9UoyaApCJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDJjU5SGBPg49eHwVxyLW7rdXjR5smmkPRX1adfayxQ=;
 b=A5sMrxx8vcbyGHYI/IEZNng3f28ikSPxB3JOi/ndOru2UgeUofbH7/vXMBwmx89m6ZDZbsELT2BZjJ4xkQB3q9XeJspjghFR9jFzuu7X+RNJ8/eLFtUHKLR01ZlCzrd9yfb8cBxgju5/xvwIc3TklAYI1gJl7qK4JGeWPhGWWhI=
Received: from CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25) by
 SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 13:28:14 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::2a) by CH2PR05CA0012.outlook.office365.com
 (2603:10b6:610::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.14 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:13 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:11 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/47] drm/amd/display: insert drv-pmfw log + rollback to new
 context
Date: Fri, 1 Dec 2023 06:25:05 -0700
Message-ID: <20231201132731.2354141-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 89336173-e767-472c-b747-08dbf2715ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brZ8hu4olry5DVKqBaSouJbPWp4JIeRmzne/QfHQkxJ47385URbUGUjqHM+xhUhvPS66GwvgtH8ntP0pcVH0e3jG4DuwPOvP4GkGhLrPEnYQI6NKv5rUUneQTgmPAgXz0cxLCEwuWEVF6xS8mzxrZmyam+wJy6Q/NDDeMVBCh9Kcsb3x+VBdjyW929atyzxtrah38tivj5I7GnDghFzPgoAvO1v7ONNBVGAGffpgXSoDqlEaKF6CJQNHJXVtBHC4ujHquukZT2ZhMeCJSpyakcuTU+XhtUm+4c0IfIleNUV3QGHMm/UOq16j9nbVctZ+qrPLG7uidUcHzWf1V8T/2+t3EZTZxEnUOLqVbh7n7CXuzZtaeApIna1zQjFyCrFlwgRopbQ0K9j8dBKjdKM63NPjCC57HWcekRC6foZRQtNwa6T3ykKLDhxKJa/jJpJz2mnD2RU3Ssgu+robEIhF06hxcKTpM8Y/7e/IKiacMBh3tvsJXvFl8fsNrtQCesvb4A8MAvQZwq/5Tba6EqVm7vnOK+z4eEYCKdkutBxZEkXfynU2ZM+kLTSkGHu27/OP6dCePaW7JglHA2FIevKR47arzAHqrOyQvq9r4dahIMN4Aml910mVd0sOm4HzmMhhfvLYo8YXFPBJq9yWRO6ayVoR6/HnK4Q4rX7ZJZlcnKXzmqBBSj90Om30XmipaO1fQjFkax1EVpxsbf5Vny7kHwY9rSdkJkP1bAdY/zEHbMB26PRlfVxbH/PZzxi0++MVfZJJlRIYFrA+pQ09LornuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(8936002)(4326008)(1076003)(26005)(2616005)(86362001)(54906003)(478600001)(8676002)(6666004)(70206006)(70586007)(426003)(83380400001)(6916009)(16526019)(336012)(316002)(40480700001)(47076005)(81166007)(5660300002)(36860700001)(2906002)(40460700003)(82740400003)(356005)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:13.9615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89336173-e767-472c-b747-08dbf2715ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Chris Park <chris.park@amd.com>, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Rollback to new context for active display: this was previous tested
sequence. Avoid to do OTG master toggle is no active display at all,
this w/a was for fifo err.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 27 ++++++------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 43 ++++++++++++++-----
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index d5fde7d23fbf..9e0fa01ecb79 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -80,12 +80,12 @@
 
 static int dcn35_get_active_display_cnt_wa(
 		struct dc *dc,
-		struct dc_state *context)
+		struct dc_state *context,
+		int *all_active_disps)
 {
-	int i, display_count;
+	int i, display_count = 0;
 	bool tmds_present = false;
 
-	display_count = 0;
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
 
@@ -103,7 +103,8 @@ static int dcn35_get_active_display_cnt_wa(
 				link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
-
+	if (all_active_disps != NULL)
+		*all_active_disps = display_count;
 	/* WA for hang on HDMI after display off back on*/
 	if (display_count == 0 && tmds_present)
 		display_count = 1;
@@ -224,15 +225,16 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
+	int all_active_disps = 0;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
-	/* DTBCLK is fixed, so set a default if unspecified. */
+	display_count = dcn35_get_active_display_cnt_wa(dc, context, &all_active_disps);
 	if (new_clocks->dtbclk_en && !new_clocks->ref_dtbclk_khz)
 		new_clocks->ref_dtbclk_khz = 600000;
 
@@ -254,7 +256,6 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
-			display_count = dcn35_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
 			if (display_count == 0)
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
@@ -311,11 +312,13 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
-
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
+		if (all_active_disps != 0) {
+			dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
+			dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
+			dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
+		} else
+			dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 
 		update_dispclk = true;
 	}
@@ -826,7 +829,7 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	struct dc_state *context = dc->current_state;
 
 	if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
-		display_count = dcn35_get_active_display_cnt_wa(dc, context);
+		display_count = dcn35_get_active_display_cnt_wa(dc, context, NULL);
 		/* if we can go lower, go lower */
 		if (display_count == 0)
 			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index af0a0f292595..786b62ab8d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -279,7 +279,7 @@ void dcn35_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr, u
 		clk_mgr,
 		VBIOSSMC_MSG_SetDisplayIdleOptimizations,
 		idle_info);
-	smu_print("VBIOSSMC_MSG_SetDisplayIdleOptimizations idle_info  = %d\n", idle_info);
+	smu_print("%s: VBIOSSMC_MSG_SetDisplayIdleOptimizations idle_info  = %x\n", __func__, idle_info);
 }
 
 void dcn35_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
@@ -298,7 +298,7 @@ void dcn35_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool e
 			clk_mgr,
 			VBIOSSMC_MSG_SetDisplayIdleOptimizations,
 			idle_info.data);
-	smu_print("dcn35_smu_enable_phy_refclk_pwrdwn  = %d\n", enable ? 1 : 0);
+	smu_print("%s smu_enable_phy_refclk_pwrdwn  = %d\n", __func__, enable ? 1 : 0);
 }
 
 void dcn35_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr)
@@ -310,6 +310,7 @@ void dcn35_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr)
 			clk_mgr,
 			VBIOSSMC_MSG_UpdatePmeRestore,
 			0);
+	smu_print("%s: SMC_MSG_UpdatePmeRestore\n", __func__);
 }
 
 void dcn35_smu_set_dram_addr_high(struct clk_mgr_internal *clk_mgr, uint32_t addr_high)
@@ -350,7 +351,7 @@ void dcn35_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 
 void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support)
 {
-	unsigned int msg_id, param;
+	unsigned int msg_id, param, retv;
 
 	if (!clk_mgr->smu_present)
 		return;
@@ -360,27 +361,32 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 	case DCN_ZSTATE_SUPPORT_ALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10) | (1 << 9) | (1 << 8);
+		smu_print("%s: SMC_MSG_AllowZstatesEntr msg = ALLOW, param = %d\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_DISALLOW:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = 0;
+		smu_print("%s: SMC_MSG_AllowZstatesEntr msg_id = DISALLOW, param = %d\n",  __func__, param);
 		break;
 
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10);
+		smu_print("%s: SMC_MSG_AllowZstatesEntr msg = ALLOW_Z10_ONLY, param = %d\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 10) | (1 << 8);
+		smu_print("%s: SMC_MSG_AllowZstatesEntr msg = ALLOW_Z8_Z10_ONLY, param = %d\n", __func__, param);
 		break;
 
 	case DCN_ZSTATE_SUPPORT_ALLOW_Z8_ONLY:
 		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 		param = (1 << 8);
+		smu_print("%s: SMC_MSG_AllowZstatesEntry msg = ALLOW_Z8_ONLY, param = %d\n", __func__, param);
 		break;
 
 	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
@@ -390,11 +396,11 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 	}
 
 
-	dcn35_smu_send_msg_with_param(
+	retv = dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		msg_id,
 		param);
-	smu_print("dcn35_smu_set_zstate_support msg_id = %d, param = %d\n", msg_id, param);
+	smu_print("%s:  msg_id = %d, param = 0x%x, return = %d\n", __func__, msg_id, param, retv);
 }
 
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr)
@@ -408,7 +414,7 @@ int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr)
 						 VBIOSSMC_MSG_GetDprefclkFreq,
 						 0);
 
-	smu_print("dcn35_smu_get_DPREF clk  = %d mhz\n", dprefclk);
+	smu_print("%s:  SMU DPREF clk  = %d mhz\n",  __func__, dprefclk);
 	return dprefclk * 1000;
 }
 
@@ -423,7 +429,7 @@ int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr)
 					       VBIOSSMC_MSG_GetDtbclkFreq,
 					       0);
 
-	smu_print("dcn35_smu_get_dtbclk  = %d mhz\n", dtbclk);
+	smu_print("%s: get_dtbclk  = %dmhz\n", __func__, dtbclk);
 	return dtbclk * 1000;
 }
 /* Arg = 1: Turn DTB on; 0: Turn DTB CLK OFF. when it is on, it is 600MHZ */
@@ -436,7 +442,7 @@ void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
 			clk_mgr,
 			VBIOSSMC_MSG_SetDtbClk,
 			enable);
-	smu_print("dcn35_smu_set_dtbclk  = %d \n", enable ? 1 : 0);
+	smu_print("%s: smu_set_dtbclk = %d\n", __func__, enable ? 1 : 0);
 }
 
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
@@ -445,30 +451,45 @@ void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *cl
 			clk_mgr,
 			VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown,
 			enable);
+	smu_print("%s: smu_enable_48mhz_tmdp_refclk_pwrdwn = %d\n", __func__, enable ? 1 : 0);
 }
 
 int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 {
-	return dcn35_smu_send_msg_with_param(
+	int retv;
+
+	retv = dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_DispPsrExit,
 		0);
+	smu_print("%s: smu_exit_low_power_state return = %d\n", __func__, retv);
+	return retv;
 }
 
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 {
-	return dcn35_smu_send_msg_with_param(
+	int retv;
+
+	retv = dcn35_smu_send_msg_with_param(
 			clk_mgr,
 			VBIOSSMC_MSG_QueryIPS2Support,
 			0);
+
+	smu_print("%s: VBIOSSMC_MSG_QueryIPS2Support return = %x\n", __func__, retv);
+	return retv;
 }
 
 void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
 {
 	REG_WRITE(MP1_SMN_C2PMSG_71, param);
+	smu_print("%s: write_ips_scratch = %x\n", __func__, param);
 }
 
 uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
 {
-	return REG_READ(MP1_SMN_C2PMSG_71);
+	uint32_t retv;
+
+	retv = REG_READ(MP1_SMN_C2PMSG_71);
+	smu_print("%s: dcn35_smu_read_ips_scratch = %x\n",  __func__, retv);
+	return retv;
 }
-- 
2.42.0

