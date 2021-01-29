Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3175564E14
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3175564E14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D8C6EC33;
	Fri, 29 Jan 2021 21:28:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F18A6EC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9ByG7etmvzWKInF/Y1VNVljXNOGrnXdq4VT70mmDNmSVIlycDGsfyJwwJrFbzmoFlWZtRinfwVDLLbY8PkfpwWu5nZ9+vJQ+npop9EWMq+d554DgFfN5Ymg09Zfi7Uddf+brrV/HUQzZNOdoZ3cpjsQJVlRWGdsv8+T3BtOyJpylpJE6y+o3Z68IiOOfWn4tpoWjHANwSxAuHhVJbA2l81wWCpWvhCi4Sqa9VEWDXIZBf2fxOQx24Rm5ExulDbI6RpOuu9YYi/RUAXPKUf+Pk2oLdS/goHucn0VyePixAo6wYNX/rLvz/oUokO12bsyzVIBXHH6cArwNuvH5AeBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydsamllrf5fU4+TZe33HQJ7xuoDcg5KpCL9qu2nb9B4=;
 b=DGv0VZ62UHclb0N95yvo3fYwJnnf3Sf/F8SdYYEs2moD1ULEoihZSGetTXwpEwjEx4mt6+ERfXhF4ZXV6pCgCrbsAoWSdhy1uBprewhr7/mzj/vqxCRe1ZwPGv64rHaGqDTn+IGbU49IS+dVSeWN3llBKVUb7ACq64soymqL7F8OHWohxMxy8Q56N7IKX0Fp9gWmPmK5HFjeOzhIbQmr5mNFcNrjUW1Dm72WuH0KVzNMXh1YsTBQdkq6DF9AhizJeV57WeNEm5bhqM1gCl8X4pLZP01C+lD4lGt59F8LJwBz2NY+yRv5GzZF4bmo+QKqHjt4LjCI33cI84TYpmkJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydsamllrf5fU4+TZe33HQJ7xuoDcg5KpCL9qu2nb9B4=;
 b=0g4M37J38oSVeKe3PP2VoSTd6qKdXxiHGL196WZQquN0LUCmqXgHd2LnXY/giplCegcgwx1iCMHudQA6VjDAO80M6qvOVItBB+4WHS8PAMUd/TyB7XPwgozpC9Z8jlx0rCptf0T+7A65pkLy4NM0DwKJj0+SZnpeTCgUTHoo2o0=
Received: from BN9PR03CA0469.namprd03.prod.outlook.com (2603:10b6:408:139::24)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:31 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::d9) by BN9PR03CA0469.outlook.office365.com
 (2603:10b6:408:139::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:29 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:19 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:18 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/27] drm/amd/display: fix initial bounding box values for
 dcn3.02
Date: Fri, 29 Jan 2021 16:27:41 -0500
Message-ID: <20210129212752.38865-17-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6380a047-782e-475c-5c62-08d8c49cd28d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41309EB5CDFDC5D7D07AC357EBB99@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnv3TpYhS+8OY209QeYwmNByBjgFAocGqz+UsSemA98yfcop3qrhnScdKAgYYZdSl7ZW2cp4ag6x+fkDQWIx4PM04IwqYVGMchib+hIv9sBolEupgzDhBlI5jIqQ+iSn5q9M9+gq+rIKRV0XdbBXhCtijzqAUKsnBHCuHIBpDGjUZldDBEExczyDU3y/xS+QjdCW4XWQmpyYDJahpvulSM44YY3ywJgb4FZQ3oIHemOSsU8lUJsui77ZHw+qy8pFZ8MENmPNFdhJ30pHRGcxFfrW/MG3m9YMhoAn0y36/B6ci0ysR24kuhpYAmtujCplMJGp4Jm7bcyNzKBJr6kvhFwfpVIgWJ+gfj5AXWNZyYFUotWx2vD9EyoAzbPEXZyX1/6gMnrGjkgofyukhmLdNg1JCZTaef5aNVxc6sXGwbVdC7vkyCVcrn2wj8QUQOJFNO4Y6VFfKE8GYzCnK1yUXVXXmWHWZibiDP0+6dNS0Mb+MP/Q1GqS6P/7fZEVtla02goS8sEn0Wwg3q0wOi32xDzaCYXm1G2uAeBzgo3u6AjiEiBegLJXU8vkjP+tjjwvlTSuNLKRHnxvMSWOeGUAyx/RDga+tKtsdkXXVEbm9Ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(8676002)(336012)(82310400003)(7696005)(83380400001)(6666004)(1076003)(478600001)(36756003)(54906003)(8936002)(316002)(5660300002)(81166007)(426003)(6916009)(82740400003)(30864003)(4326008)(86362001)(47076005)(2616005)(26005)(186003)(2906002)(70206006)(356005)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:29.8827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6380a047-782e-475c-5c62-08d8c49cd28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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
Cc: Joshua Aberback <Joshua.Aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Samson Tam <Samson.Tam@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Initial bounding box values are updated in dcn30_update_bw_bounding_box
 but they use dcn3_0_soc and dcn3_0_ip instead of dcn3_02_soc and
 dcn3_02_ip

[How]
Add dcn302_update_bw_bounding_box and
 dcn302_get_optimal_dcfclk_fclk_for_uclk so it uses
 dcn3_02_soc and dcn3_02_ip.
Use sr_exit_time_us, sr_enter_plus_exit_time_us,
 from dcn30 on dcn302 to fix flicker on eDP.
 Also use dram_clock_change_latency_us from dcn30.

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  24 ++-
 .../amd/display/dc/dcn302/dcn302_resource.c   | 168 +++++++++++++++++-
 .../amd/display/dc/dcn302/dcn302_resource.h   |   2 +
 3 files changed, 184 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index dcf848f747a5..22ae6a547cd3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2334,16 +2334,28 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-                                                       unsigned int *optimal_dcfclk,
-                                                       unsigned int *optimal_fclk)
+/*
+ * This must be noinline to ensure anything that deals with FP registers
+ * is contained within this call; previously our compiling with hard-float
+ * would result in fp instructions being emitted outside of the boundaries
+ * of the DC_FP_START/END macros, which makes sense as the compiler has no
+ * idea about what is wrapped and what is not
+ *
+ * This is largely just a workaround to avoid breakage introduced with 5.6,
+ * ideally all fp-using code should be moved into its own file, only that
+ * should be compiled with hard-float, and all code exported from there
+ * should be strictly wrapped with DC_FP_START/END
+ */
+static noinline void dcn30_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+		unsigned int *optimal_dcfclk,
+		unsigned int *optimal_fclk)
 {
        double bw_from_dram, bw_from_dram1, bw_from_dram2;
 
        bw_from_dram1 = uclk_mts * dcn3_0_soc.num_chans *
-                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / 100);
+		dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / 100);
        bw_from_dram2 = uclk_mts * dcn3_0_soc.num_chans *
-                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100);
+		dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100);
 
        bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
 
@@ -2402,7 +2414,7 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		// Calculate optimal dcfclk for each uclk
 		for (i = 0; i < num_uclk_states; i++) {
 			DC_FP_START();
-			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+			dcn30_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
 					&optimal_dcfclk_for_uclk[i], NULL);
 			DC_FP_END();
 			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b4ff73e32279..4b659b63f75b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -54,6 +54,7 @@
 #include "dce/dce_panel_cntl.h"
 #include "dce/dmub_abm.h"
 #include "dce/dmub_psr.h"
+#include "clk_mgr.h"
 
 #include "hw_sequencer_private.h"
 #include "reg_helper.h"
@@ -163,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 5.20,
-		.sr_enter_plus_exit_time_us = 9.60,
+		.sr_exit_time_us = 12,
+		.sr_enter_plus_exit_time_us = 20,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
 		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
@@ -191,7 +192,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 		.num_banks = 8,
 		.gpuvm_min_page_size_bytes = 4096,
 		.hostvm_min_page_size_bytes = 4096,
-		.dram_clock_change_latency_us = 350,
+		.dram_clock_change_latency_us = 404,
 		.dummy_pstate_latency_us = 5,
 		.writeback_dram_clock_change_latency_us = 23.0,
 		.return_bus_width_bytes = 64,
@@ -1229,6 +1230,165 @@ static void dcn302_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
+static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+		unsigned int *optimal_dcfclk,
+		unsigned int *optimal_fclk)
+{
+	double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+	bw_from_dram1 = uclk_mts * dcn3_02_soc.num_chans *
+		dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_dram_bw_use_normal_percent / 100);
+	bw_from_dram2 = uclk_mts * dcn3_02_soc.num_chans *
+		dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+	if (optimal_fclk)
+		*optimal_fclk = bw_from_dram /
+		(dcn3_02_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+	if (optimal_dcfclk)
+		*optimal_dcfclk =  bw_from_dram /
+		(dcn3_02_soc.return_bus_width_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
+void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	unsigned int i, j;
+	unsigned int num_states = 0;
+
+	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
+	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
+
+	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
+	unsigned int num_dcfclk_sta_targets = 4;
+	unsigned int num_uclk_states;
+
+
+	if (dc->ctx->dc_bios->vram_info.num_chans)
+		dcn3_02_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+		dcn3_02_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
+	dcn3_02_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	if (bw_params->clk_table.entries[0].memclk_mhz) {
+		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
+
+		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+			if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
+				max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+			if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
+				max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+			if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
+				max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+			if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
+				max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		}
+		if (!max_dcfclk_mhz)
+			max_dcfclk_mhz = dcn3_02_soc.clock_limits[0].dcfclk_mhz;
+		if (!max_dispclk_mhz)
+			max_dispclk_mhz = dcn3_02_soc.clock_limits[0].dispclk_mhz;
+		if (!max_dppclk_mhz)
+			max_dppclk_mhz = dcn3_02_soc.clock_limits[0].dppclk_mhz;
+		if (!max_phyclk_mhz)
+			max_phyclk_mhz = dcn3_02_soc.clock_limits[0].phyclk_mhz;
+
+		if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			/* If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array */
+			dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
+			num_dcfclk_sta_targets++;
+		} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			/* If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates */
+			for (i = 0; i < num_dcfclk_sta_targets; i++) {
+				if (dcfclk_sta_targets[i] > max_dcfclk_mhz) {
+					dcfclk_sta_targets[i] = max_dcfclk_mhz;
+					break;
+				}
+			}
+			/* Update size of array since we "removed" duplicates */
+			num_dcfclk_sta_targets = i + 1;
+		}
+
+		num_uclk_states = bw_params->clk_table.num_entries;
+
+		/* Calculate optimal dcfclk for each uclk */
+		for (i = 0; i < num_uclk_states; i++) {
+			dcn302_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+					&optimal_dcfclk_for_uclk[i], NULL);
+			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
+				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
+			}
+		}
+
+		/* Calculate optimal uclk for each dcfclk sta target */
+		for (i = 0; i < num_dcfclk_sta_targets; i++) {
+			for (j = 0; j < num_uclk_states; j++) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
+					optimal_uclk_for_dcfclk_sta_targets[i] =
+							bw_params->clk_table.entries[j].memclk_mhz * 16;
+					break;
+				}
+			}
+		}
+
+		i = 0;
+		j = 0;
+		/* create the final dcfclk and uclk table */
+		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+			} else {
+				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+				} else {
+					j = num_uclk_states;
+				}
+			}
+		}
+
+		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
+			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+		}
+
+		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
+				optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+		}
+
+		dcn3_02_soc.num_states = num_states;
+		for (i = 0; i < dcn3_02_soc.num_states; i++) {
+			dcn3_02_soc.clock_limits[i].state = i;
+			dcn3_02_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+			dcn3_02_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+			dcn3_02_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
+			/* Fill all states with max values of all other clocks */
+			dcn3_02_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
+			dcn3_02_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
+			dcn3_02_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
+			dcn3_02_soc.clock_limits[i].dtbclk_mhz = dcn3_02_soc.clock_limits[0].dtbclk_mhz;
+			/* These clocks cannot come from bw_params, always fill from dcn3_02_soc[1] */
+			/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
+			dcn3_02_soc.clock_limits[i].phyclk_d18_mhz = dcn3_02_soc.clock_limits[0].phyclk_d18_mhz;
+			dcn3_02_soc.clock_limits[i].socclk_mhz = dcn3_02_soc.clock_limits[0].socclk_mhz;
+			dcn3_02_soc.clock_limits[i].dscclk_mhz = dcn3_02_soc.clock_limits[0].dscclk_mhz;
+		}
+		/* re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
+	}
+}
+
 static struct resource_funcs dcn302_res_pool_funcs = {
 		.destroy = dcn302_destroy_resource_pool,
 		.link_enc_create = dcn302_link_encoder_create,
@@ -1245,7 +1405,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 		.acquire_post_bldn_3dlut = dcn30_acquire_post_bldn_3dlut,
 		.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
-		.update_bw_bounding_box = dcn30_update_bw_bounding_box,
+		.update_bw_bounding_box = dcn302_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
index 71f7deed18e3..42d2c73e30bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
@@ -30,4 +30,6 @@
 
 struct resource_pool *dcn302_create_resource_pool(const struct dc_init_data *init_data, struct dc *dc);
 
+void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+
 #endif /* _DCN302_RESOURCE_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
