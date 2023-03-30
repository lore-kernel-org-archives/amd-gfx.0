Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777BBC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1588B10ED55;
	Thu, 30 Mar 2023 08:59:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D831310ED55
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1sAUlOfIIbHmSCOtzDv69lG6xEXXhywefAI6eQT8NkZ+F9C028uYzNTZToe3SFeNB/3V6d8MpP/4npgEJ8Gl3HPgXuZZk7Y2tMk8/jfMGhs2bg81C26Q/coQvaIq/wMkubSEuw5OngQlTJAKROFL4QTc4Ke2bCrDm6p82+LPlsnN86GDtRkdSWV5hSx1CTVt7gJ3h2zzk0v8hvvWOy1UCvj65PXHgvTsjfEX2O4zroHQr75nxQc1aeslbdLnQ7g5wvWvwjhA6xZXFxAvBQPJ+CQzghMqWitnoAYzrAzyj+bCYXyM0hoKlQWgOsy3VNdn5otyUOxvVwvsJdix69nHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41W8jykRY3KSOqSVz95xmB2H5i4MBMBHgBCAhOMXWvo=;
 b=L1Gp8xoa59CwKPH/oWHtudWZKHRqx21KhN2YD1HLMzBwwpWp2LNS55kgmCwYk61xAQSrZpXvb7SAf896kXJoKOEj+43XrueHh4VMLbUgDjnl8zkikMpjB97rh/FGAp07iLQEejezs3oKOq1TKswg9FepBZCVv/d0Ktp8E07pOVMdauMu0WLe02YDlbJpQrHc3MrThyAx5IVzHNyroAgnls5i7dSKHTPFWYDef4ZkFsefye69ru3TWaBs3j3Z03lYaBJqOlUPh9t00I9P5y3Pp5tFVh+65kVH7V/Qx6x3QjTPF3NY+YbAynEnEprlPNdZSdBLIDh0wi2VKbCLo9X9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41W8jykRY3KSOqSVz95xmB2H5i4MBMBHgBCAhOMXWvo=;
 b=aHdjpah/gu1J0HYxqpbCILQHeSoxZwvlRG2NU+xxi3+fp22kqiWu+S2qRJ0Ua70h/e6ct6uGuvjtaHMd6KyRAYdWUu8zqbeeuZKdrhYnm8iRMgMUAZmaBpoYOKIfrsbXNVE+b/HOvFgvLPIOC5r83s01p8UuWJ1iBbDW/ix/zrw=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 08:59:41 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5f) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 08:59:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:36 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amd/display: On clock init, maintain DISPCLK freq
Date: Thu, 30 Mar 2023 04:57:16 -0400
Message-ID: <20230330085720.3863-7-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c0a876-2697-48b7-d6c9-08db30fd195e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaJ/MMET0wV/3Qh0PM7mdEos+TdcWMPDm9GveDQpoVTM5a4eNURht+MNDZen5pcNvyhJ8NLVwQpxrQB1srilIAMSUB00TLtKTbmliPSZX4GWmZuNAfnlyRYPJzE4wxroTcXWvnYbyVLVCEV6+0lVz7b2OtmTqsGZvIyz58snQ/UKqO/TyAZwL7DCDjf2X/jGFfqwsStfYltAgBE25/a7ktTF46XuJvu1pu4tpqhS0ZIfrk2S3/6BSzGRHw80Y2IOSU03xu/ssMePvO/H8DcJytQ+u8n2fWKPnVn6J+lNRw2QqujvvOt5tSGNvbPzAwuYWK/idzQ2bFzhU6V1Ryw9xw9T2wGPphYFdFYP1DRIZir6N1rXMQzqMfSQZD++bGS3Tp/lweUVZ617J7ZlUYxnxsFEDsl3pEnWVZxSg83LM1KR88BfrnI0m4Dwk+8wUKjdHSJdmFuxPoG6EwB2fUwGnJt3ovqU6WVkx+hPdNBBLTDIizNMFS+45c2lv8GfZe3ZNsFdQlaWVM0+Hm9sdigfZh5OPiRkr4iKAiGUdYoNtd8vB39P+JYkpVrFJic9tRx14TqLPTmgjCYs5tZ6vn3W7wzkvFUWxlxB3dDkQTwzbj9f4QgyiH92xqLVJryG+f9YODPLVa9zuj8hCTRV6rMNKc4gkgdzW20abExEVnNQ6S9MO6Wyd1Mtbf0RqKVof5gMpdpaNndtJ2TrWSmuWNwsWBovps85fu9hTkqidnTI+yo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(70206006)(40480700001)(186003)(40460700003)(16526019)(1076003)(26005)(6916009)(36860700001)(5660300002)(70586007)(81166007)(41300700001)(8936002)(356005)(54906003)(478600001)(316002)(336012)(426003)(82740400003)(8676002)(4326008)(86362001)(47076005)(6666004)(2616005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:41.3093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c0a876-2697-48b7-d6c9-08db30fd195e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- On init if a display is connected, we need to maintain the DISPCLK
  frequency
- Even though DPG_EN=1, the display still requires the correct
  timing or it could cause audio corruption (if DISPCLK freq
  is reduced)
- Read the current DISPCLK freq and request the same value to ensure
  the timing is valid and unchanged
- However, add option to do a full pipe power down (including link)
  which will also avoid audio related issues
	- Disabled for the time being on dcn32

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 18 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 26 +++++++++++++++----
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  3 +++
 6 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index af108f88b112..ea753f8fa175 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -399,6 +399,23 @@ static void dcn32_update_clocks_update_dentist(
 
 }
 
+static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t dispclk_wdivider;
+	int disp_divider;
+
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
+	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+
+	/* Return DISPCLK freq in Khz */
+	if (disp_divider)
+		return (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+
+	return 0;
+}
+
+
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -852,6 +869,7 @@ static struct clk_mgr_funcs dcn32_funcs = {
 		.are_clock_states_equal = dcn32_are_clock_states_equal,
 		.enable_pme_wa = dcn32_enable_pme_wa,
 		.is_smu_present = dcn32_is_smu_present,
+		.get_dispclk_from_dentist = dcn32_get_dispclk_from_dentist,
 };
 
 void dcn32_clk_mgr_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 719727a2f939..f51b9c265b51 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -877,6 +877,7 @@ struct dc_debug_options {
 	bool support_eDP1_5;
 	uint32_t fpo_vactive_margin_us;
 	bool disable_fpo_vactive;
+	bool disable_boot_optimizations;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b3824287c224..db0974fe58ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -721,10 +721,19 @@ static void dcn32_initialize_min_clocks(struct dc *dc)
 	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
 	clocks->dramclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 1000;
 	clocks->dppclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dppclk_mhz * 1000;
-	clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
-	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
-	clocks->fclk_p_state_change_support = true;
-	clocks->p_state_change_support = true;
+	if (dc->debug.disable_boot_optimizations) {
+		clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
+	} else {
+		/* Even though DPG_EN = 1 for the connected display, it still requires the
+		 * correct timing so we cannot set DISPCLK to min freq or it could cause
+		 * audio corruption. Read current DISPCLK from DENTIST and request the same
+		 * freq to ensure that the timing is valid and unchanged.
+		 */
+		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
+		clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
+		clocks->fclk_p_state_change_support = true;
+		clocks->p_state_change_support = true;
+	}
 
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
@@ -823,7 +832,14 @@ void dcn32_init_hw(struct dc *dc)
 	 * everything down.
 	 */
 	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
-		hws->funcs.init_pipes(dc, dc->current_state);
+		/* Disable boot optimizations means power down everything including PHY, DIG,
+		 * and OTG (i.e. the boot is not optimized because we do a full power down).
+		 */
+		if (dc->hwss.enable_accelerated_mode && dc->debug.disable_boot_optimizations)
+			dc->hwss.enable_accelerated_mode(dc, dc->current_state);
+		else
+			hws->funcs.init_pipes(dc, dc->current_state);
+
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 99d417fa6458..e30d1f60695d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -728,6 +728,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_fpo_optimizations = false,
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = true,
+	.disable_boot_optimizations = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 7ebd14fb9698..e5ab7f3077c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -726,6 +726,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_fpo_optimizations = false,
 	.fpo_vactive_margin_us = 2000, // 2000us
 	.disable_fpo_vactive = true,
+	.disable_boot_optimizations = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 591ab1389e3b..bef843cc32a1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -293,6 +293,9 @@ struct clk_mgr_funcs {
 
 	/* Get SMU present */
 	bool (*is_smu_present)(struct clk_mgr *clk_mgr);
+
+	int (*get_dispclk_from_dentist)(struct clk_mgr *clk_mgr_base);
+
 };
 
 struct clk_mgr {
-- 
2.34.1

