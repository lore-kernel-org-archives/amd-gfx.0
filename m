Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A511FC43219
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A745B10E4EA;
	Wed,  2 Nov 2022 16:04:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEAD10E4EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUst7U7X2KjCQZ9RDaqpej/u5Y09NXj38TOlHbG+NBv/0I/7qdgf9ANstI8OIX/SQgEJlGMK6EnSL5YFeDFgQhAmxw3Og8rHmAQOT1hZvcffkEUxVmfszeJXYdy/J8JHDeYDTGa82h2m986EOwgP0SaX6mRsu4XJPNVG+TnYdWrJQH0cWTG6fQYPQ9/Cv6ztRCsQDQ9B8zhMiT/Pju39+bMn5ctXnup5rEQesZ+nJ6pV8vlcft69KddFFxjM7zrQMT4e5sA+CDFdGdp/09dzLM3O+rvA70Bi4hT6OTCz65kOPVo6ZGn6jyr1fva2gNoLrpRwoHU4d6u63zW0A998HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBjLTSnZwnrFdJzPiQBip4Gl0hF2KfxiDJfcXeHIeOM=;
 b=kHZWzRKUX78K647yNyKz36qFOgAnHrvr2d9K+e3xq/f+Ls0vqofQX4u6KL0d7mnYHGtJ1IHMxg3/ZxNlrbPximc5JGTf5TnJZs7eSei//e3VMXsC51TpUY4CgS449diNMKKXw1XO1NqkYoYgvhXpOtrrJaEBg2sHriAzJPVP0/OhPlo9KSPMs9ZReJB/g6E3TtSn/R2Vo3JFqjyzpBgV58dswM3f5o4y4rVieNDomonCFfK1fyU3USA9Uh47Nbc5lCukVI+xuTZEbJTXReEHJq9IFTCHaFMhN5BDleIp6DUVdSlsfOGUGeKXdbvEPHYQ/Wf1lD/YyDMneUtBx7UyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBjLTSnZwnrFdJzPiQBip4Gl0hF2KfxiDJfcXeHIeOM=;
 b=ybpV6C/eCn3QXc8tUt/dcHBhQFpsGTqGaO8oeIVLmUN+5Cld8yDxN3sovA2i4pTY3kEAKAvi7RLaIQ5buQ/EXpKKD+Cpx66pBMOXlSa04Xq7BJ0MU7lhIDpk6is5SaNrGNk7tivbMQ6JmDdLc5tAlgIoJQxvUF4RsaGbXwVeN0k=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 16:04:19 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::f5) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:17 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:13 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: Enforce minimum prefetch time for low
 memclk on DCN32
Date: Thu, 3 Nov 2022 00:01:13 +0800
Message-ID: <20221102160117.506511-19-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: db366c61-82cf-4ebb-d886-08dabcebe5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ws5UJUs4YnjpLp13wgIHHeBfmeaSlsQ4q9R/3VyaQLHLqoGkvDlw0Jo9jgE7R6jgZ8FLTp1r+NkyfLZ8NrpiIB3InmsHIEBSzjbGlI3BFHINUZs4Mf8TzCRC6I7NMXvVHjfqxbFzoTeJ6trpODhzcEFxsdx9yczPWOpwWqx4nZzdbDHPdzMiyvIiONOCd/14n5DbBTIEnX+gdQqUlRmgVoJsep2lSQrn99ahwC9zB47/f3ysjFx3+fU36WmG91xFhb1yz6tEaM2/Yzyx2y/VLgEK4hHDq8+BPoPO8syqsOAYTiUWa5WL9smXL+kxpwvDnf2O6Cp1VDpHtesXqaGdt0Mp415UGzghrI99u284Wvqv7Pdzlsbrq3F1elmnqek5rSfZGVhqgVcXjbrjme2SLXlyPZxHrpt2iB4uP2TkTY//yX/e9VJtUTiwNdB1jrghSj7a6J/QcYaEsQ+sNhcAmW+ZmqUsWUfb+yDvoR7WTxbTn9Gd/NPjaWCuzMhOuYNZHKtzG6CswIKVmpwzy9b/gmhBRi4iPQofZv7qv++YDX6HpGGrP3u7iWLVS4Ag4P/IHXPemin1sd4QV0Gu4Ff1X4dC3l9WWfnXT9x4iW7KCwdBPjP6ScvwzbaaMwHl/gvKcG5Nc0zwhr8rsAvkBf7kXQhctjZIOMY6WTyh2ggKY4W7LTkZJHW0nH3OEpN6c+hnDErTupvSHdypKNTs4/I4WAyR3W4Vcq2SHTRXQooeHjbfmLceuLv+kCySa1M28K8bAg9aRAviPl6LWiYIE0M976VPe31AJvVIO8BTrNbZxkEN+Buo8mThbBs4Kvm34DTHrp2ojtLGOEKPsLVMLI4mOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(426003)(81166007)(83380400001)(70586007)(5660300002)(2906002)(41300700001)(356005)(82740400003)(36860700001)(86362001)(47076005)(2616005)(26005)(316002)(40480700001)(40460700003)(1076003)(186003)(478600001)(6916009)(336012)(8936002)(54906003)(82310400005)(4326008)(8676002)(70206006)(7696005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:18.3653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db366c61-82cf-4ebb-d886-08dabcebe5c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Data return times when using lowest memclk can be <= 60us, which can cause
underflow on high bandwidth displays with a workload.

[HOW?]
Enforce a minimum prefetch time during validation for low memclk modes.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c    |  1 +
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |  2 ++
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c   |  4 ++++
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h   |  3 +++
 .../display/dc/dml/dcn32/display_mode_vba_util_32.c  | 12 ++++++++++--
 .../display/dc/dml/dcn32/display_mode_vba_util_32.h  |  1 +
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c   |  2 ++
 .../drm/amd/display/dc/dml/display_mode_structs.h    |  1 +
 10 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 84c82d3a6761..d69121809524 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -864,6 +864,7 @@ struct dc_debug_options {
 	bool enable_dp_dig_pixel_rate_div_policy;
 	enum lttpr_mode lttpr_mode_override;
 	unsigned int dsc_delay_factor_wa_x1000;
+	unsigned int min_prefetch_in_strobe_ns;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 4ba9a8662185..4bd861427b3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -724,6 +724,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
 	.alloc_extra_way_for_cursor = true,
+	.min_prefetch_in_strobe_ns = 60000, // 60us
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 61087f2385a9..6292ac515d1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -722,6 +722,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_dp_dig_pixel_rate_div_policy = 1,
 	.allow_sw_cursor_fallback = false,
 	.alloc_extra_way_for_cursor = true,
+	.min_prefetch_in_strobe_ns = 60000, // 60us
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0d704e302d03..853ffb704985 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2351,6 +2351,8 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 	/* DML DSC delay factor workaround */
 	dcn3_2_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
 
+	dcn3_2_ip.min_prefetch_in_strobe_us = dc->debug.min_prefetch_in_strobe_ns / 1000.0;
+
 	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
 	dcn3_2_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index ae6e6abc620b..244fd15d24b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -786,6 +786,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->SwathHeightY[k],
 					v->SwathHeightC[k],
 					TWait,
+					v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ?
+							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 					/* Output */
 					&v->DSTXAfterScaler[k],
 					&v->DSTYAfterScaler[k],
@@ -3245,6 +3247,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->swath_width_chroma_ub_this_state[k],
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k], v->TWait,
+							v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ ?
+									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
 
 							/* Output */
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index c62e0991358b..f82e14cd9d8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -49,6 +49,9 @@
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
 
+#define MEM_STROBE_FREQ_MHZ 1600
+#define MEM_STROBE_MAX_DELIVERY_TIME_US 60.0
+
 struct display_mode_lib;
 
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ab9217732a17..635fc54338fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3417,6 +3417,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightY,
 		unsigned int SwathHeightC,
 		double TWait,
+		double TPreReq,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
@@ -3474,6 +3475,7 @@ bool dml32_CalculatePrefetchSchedule(
 	double  min_Lsw;
 	double  Tsw_est1 = 0;
 	double  Tsw_est3 = 0;
+	double  TPreMargin = 0;
 
 	if (v->GPUVMEnable == true && v->HostVMEnable == true)
 		HostVMDynamicLevelsTrips = v->HostVMMaxNonCachedPageTableLevels;
@@ -3699,6 +3701,8 @@ bool dml32_CalculatePrefetchSchedule(
 
 	dst_y_prefetch_equ = dml_floor(4.0 * (dst_y_prefetch_equ + 0.125), 1) / 4.0;
 	Tpre_rounded = dst_y_prefetch_equ * LineTime;
+
+	TPreMargin = Tpre_rounded - TPreReq;
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: dst_y_prefetch_equ: %f (after round)\n", __func__, dst_y_prefetch_equ);
 	dml_print("DML::%s: LineTime: %f\n", __func__, LineTime);
@@ -3726,7 +3730,7 @@ bool dml32_CalculatePrefetchSchedule(
 	*VRatioPrefetchY = 0;
 	*VRatioPrefetchC = 0;
 	*RequiredPrefetchPixDataBWLuma = 0;
-	if (dst_y_prefetch_equ > 1) {
+	if (dst_y_prefetch_equ > 1 && TPreMargin > 0.0) {
 		double PrefetchBandwidth1;
 		double PrefetchBandwidth2;
 		double PrefetchBandwidth3;
@@ -3872,7 +3876,11 @@ bool dml32_CalculatePrefetchSchedule(
 		}
 
 		if (dst_y_prefetch_oto < dst_y_prefetch_equ) {
-			*DestinationLinesForPrefetch = dst_y_prefetch_oto;
+			if (dst_y_prefetch_oto * LineTime < TPreReq) {
+				*DestinationLinesForPrefetch = dst_y_prefetch_equ;
+			} else {
+				*DestinationLinesForPrefetch = dst_y_prefetch_oto;
+			}
 			TimeForFetchingMetaPTE = Tvm_oto;
 			TimeForFetchingRowInVBlank = Tr0_oto;
 			*PrefetchBandwidth = prefetch_bw_oto;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index fdccaa93eb2e..3989c2a28fae 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -743,6 +743,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightY,
 		unsigned int SwathHeightC,
 		double TWait,
+		double TPreReq,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index ec0486efab14..432b4ecd01a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -544,6 +544,8 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	/* DML DSC delay factor workaround */
 	dcn3_21_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
 
+	dcn3_21_ip.min_prefetch_in_strobe_us = dc->debug.min_prefetch_in_strobe_ns / 1000.0;
+
 	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
 	dcn3_21_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index d7be01ac0751..64d602e6412f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -367,6 +367,7 @@ struct _vcs_dpi_ip_params_st {
 
 	/* DM workarounds */
 	double dsc_delay_factor_wa; // TODO: Remove after implementing root cause fix
+	double min_prefetch_in_strobe_us;
 };
 
 struct _vcs_dpi_display_xfc_params_st {
-- 
2.25.1

