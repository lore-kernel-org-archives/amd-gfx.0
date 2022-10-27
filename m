Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC1FFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC46610E6D7;
	Thu, 27 Oct 2022 18:42:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F61010E6D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYfrALaoxBXcmBdGlVqKsU2T7WT/NKbyHyjkR4yS6xPLSgJ7dia0AKbVM6pfI1fa9OVL9Of7Lri+NCykKdPXGqM+O54kidCuRLu5rwc64hfJPWLwFT1OyCKDbSRzaZoo20aSjVZombhz6H8GwT2ywW35hbI6GHUJD71GVXGMj6Yog2WiCJAsTJzqYJ4tar5fJzztVNTAjTdwyKIXkWSJFIJXQ9OQVj2L2eZY0ggtBEiTdK2oF3yDxX2rYRDNAigZ1UnwH9Eh2LGH/zpt6cNcq6+vcYYE99snn6tMlsflnd5W11+SDVT0qgm+v/FI7OINwcA0/wekNf23BtbIeUDG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShVj+0Yadj6RF6DFKoyYWPm9cY8KBbqzkhHxCSvxOJA=;
 b=mQft+F9VLyo+s3deu9KYePW6sPTr0IqgWfoSptQMtfGv3/IvDRNoWNvaDFD17KP8vZvf3xaOB7pA3wD8Uz0fZaKCPqodrM4zXM5F8QKoK1DapAWGObrezvRnD1Hv3/J8Ebl7IBO4NfokkcKPbF0Ukqk8wQTpr1hDmzUVN82ADzx6yUee0GFZ7foDgQCFGfW9NCUqpPNLjiJ7OoSzL7l5/l1CsKqE8krjLYw1hrUVm3fxPN/Fa2a8JSUWeCy12TJ9R0pe8DT4UiH4SEmZmkaXLI8cWLm0BajBYAJzgdkGMtHjD8KVh7ptaFL/WiMzhpskyncJ5YsdUxmqrrCqOUdrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShVj+0Yadj6RF6DFKoyYWPm9cY8KBbqzkhHxCSvxOJA=;
 b=pgf4NX0ExR1scCY8EkSkWQfZjhTsY2Zp+bGI9fL801/GTYVZfJOjuS7bdA1JZUs3xBTh8pBsTdotvY6ZfJbiFdmA9+29cWgme41F8Xa35vLASp5MWXrKdwwWNz1YqNRY6KwM86Cub41kx2bjdzdh0qu3Upumb5g86KJkEWuf/0o=
Received: from BN0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:e8::26)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:42:07 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::57) by BN0PR04CA0051.outlook.office365.com
 (2603:10b6:408:e8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Thu, 27 Oct 2022 18:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:42:07 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:42:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amd/display: Add DSC delay factor workaround
Date: Thu, 27 Oct 2022 12:35:40 -0600
Message-ID: <20221027183543.1117976-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: d8954e35-0df7-44cc-4c26-08dab84af305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xsc2ITxGzpKN447lur/xrB3zPcNZwAkaIb+uJkw8BTXjWEnsKP7GiCITsWqc+kMgZtzSpI/Aj5+ovsqighe5G1JhD0OpwwMnfKUUMCWgJpE7HGpsFvvxH4l7vLZ4+QrYo8slAajHudOX5iAeoukNGfXvaGicoobybhLf8LMDMeL/mHEuWU8czQWYQKvFqqALPTIKdiLyb1WkMOMtByR9t+1A7CdHIWI7iqGpf308P21eu099ngWsku09KpJH3zNy6gMrMqMm4IgInC/ZJI2FQ50ineu+48kRkVV8bV1Tmap40R4lwGFg3dweJqAx9lXAh0O6FqqteYexc9HMDUhLHLd+CBm4aW0+s43Sgr85uUzl9z5757XLsmr2Ewk5Pc4REgIX992h101CktPC1NBj4uHxCxBPaLzPKM0xcIsTx8UuShWm7+pnbOpWKXICLt3tDwwdtbb20NHS9p2BQ7cickA9cbwBkzxf7LzF11ucdLSG28Rz/Bv56QZ8G6NJE1uqTinJXpAss662mbmmymkAuTWy236GNhC/RBNgIvbe9ras3C0F6j5KnygInKGVmKOwjoZ1AUy8by7Sc/c28JYbfRH374VRB8jiywf4KjP+/xtT8cRgeq9JGrumxtV9hDxsFR75uSUmZ4gZ9FlJs0xVACehddpXOb5UyYI4TTpjUgeNtPZfp/fR7834828Yd1VSDNN4MB0wZca4ZXm7PpfB1tsEtxgAYXN5yv0CiITUer3f9pqioGlciHUBo00kojKOdc+OT0ghyO9BFyTl+f/J8nMCLP8ixCM2Dh/HKC5wDltC+gI97sCITkp7UYEyR2h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(83380400001)(47076005)(54906003)(6916009)(40480700001)(4326008)(5660300002)(8936002)(41300700001)(36860700001)(26005)(8676002)(70586007)(44832011)(70206006)(82310400005)(336012)(7696005)(86362001)(356005)(6666004)(426003)(82740400003)(2616005)(36756003)(16526019)(81166007)(1076003)(186003)(478600001)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:42:07.0179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8954e35-0df7-44cc-4c26-08dab84af305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain 4K high refresh rate modes requiring DSC are exhibiting top
of screen underflow corruption. Increasing the DSC delay by a factor
of 6 percent stops the underflow for most use cases.

[How]
Multiply DSC delay requirement in DML by a factor.
Add debug option to make this DSC delay factor configurable.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c         | 4 +++-
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c   | 5 +++--
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c  | 5 +++--
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h  | 3 ++-
 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c       | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h    | 3 +++
 7 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dc0d51396626..fb33540323bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -863,6 +863,7 @@ struct dc_debug_options {
 	bool enable_double_buffered_dsc_pg_support;
 	bool enable_dp_dig_pixel_rate_div_policy;
 	enum lttpr_mode lttpr_mode_override;
+	unsigned int dsc_delay_factor_wa_x1000;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9c03f62b9d19..0d704e302d03 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2346,9 +2346,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 
 		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
 			dcn3_2_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
 	}
 
+	/* DML DSC delay factor workaround */
+	dcn3_2_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
+
 	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
 	dcn3_2_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 60351b2891d0..47ff0a8bd105 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -367,7 +367,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.OutputBpp[k], mode_lib->vba.HActive[k], mode_lib->vba.HTotal[k],
 				mode_lib->vba.NumberOfDSCSlices[k], mode_lib->vba.OutputFormat[k],
 				mode_lib->vba.Output[k], mode_lib->vba.PixelClock[k],
-				mode_lib->vba.PixelClockBackEnd[k]);
+				mode_lib->vba.PixelClockBackEnd[k], mode_lib->vba.ip.dsc_delay_factor_wa);
 	}
 
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k)
@@ -2475,7 +2475,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.OutputBppPerState[i][k], mode_lib->vba.HActive[k],
 					mode_lib->vba.HTotal[k], mode_lib->vba.NumberOfDSCSlices[k],
 					mode_lib->vba.OutputFormat[k], mode_lib->vba.Output[k],
-					mode_lib->vba.PixelClock[k], mode_lib->vba.PixelClockBackEnd[k]);
+					mode_lib->vba.PixelClock[k], mode_lib->vba.PixelClockBackEnd[k],
+					mode_lib->vba.ip.dsc_delay_factor_wa);
 		}
 
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 4a3e7a5d2758..968924c491c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1726,7 +1726,8 @@ unsigned int dml32_DSCDelayRequirement(bool DSCEnabled,
 		enum output_format_class  OutputFormat,
 		enum output_encoder_class Output,
 		double PixelClock,
-		double PixelClockBackEnd)
+		double PixelClockBackEnd,
+		double dsc_delay_factor_wa)
 {
 	unsigned int DSCDelayRequirement_val;
 
@@ -1764,7 +1765,7 @@ unsigned int dml32_DSCDelayRequirement(bool DSCEnabled,
 	dml_print("DML::%s: DSCDelayRequirement_val = %d\n", __func__, DSCDelayRequirement_val);
 #endif
 
-	return DSCDelayRequirement_val;
+	return dml_ceil(DSCDelayRequirement_val * dsc_delay_factor_wa, 1);
 }
 
 void dml32_CalculateSurfaceSizeInMall(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 55cead0d4237..2c3827546ac7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -327,7 +327,8 @@ unsigned int dml32_DSCDelayRequirement(bool DSCEnabled,
 		enum output_format_class  OutputFormat,
 		enum output_encoder_class Output,
 		double PixelClock,
-		double PixelClockBackEnd);
+		double PixelClockBackEnd,
+		double dsc_delay_factor_wa);
 
 void dml32_CalculateSurfaceSizeInMall(
 		unsigned int NumberOfActiveSurfaces,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 7352f7514410..ec0486efab14 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -29,6 +29,7 @@
 #include "dcn321_fpu.h"
 #include "dcn32/dcn32_resource.h"
 #include "dcn321/dcn321_resource.h"
+#include "dml/dcn32/display_mode_vba_util_32.h"
 
 #define DCN3_2_DEFAULT_DET_SIZE 256
 
@@ -538,9 +539,11 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 
 		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
 			dcn3_21_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
 	}
 
+	/* DML DSC delay factor workaround */
+	dcn3_21_ip.dsc_delay_factor_wa = dc->debug.dsc_delay_factor_wa_x1000 / 1000.0;
+
 	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
 	dcn3_21_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index f33a8879b05a..d7be01ac0751 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -364,6 +364,9 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int max_num_dp2p0_outputs;
 	unsigned int max_num_dp2p0_streams;
 	unsigned int VBlankNomDefaultUS;
+
+	/* DM workarounds */
+	double dsc_delay_factor_wa; // TODO: Remove after implementing root cause fix
 };
 
 struct _vcs_dpi_display_xfc_params_st {
-- 
2.38.1

