Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F104C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A634310E5EA;
	Fri,  6 May 2022 15:43:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9D710E5EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSyl9T1FNqyzFd9f+XSBYLwSdSFFH+Px9g6ibgtNorK76RXGZAQmxn9tqqALx90jc/kPjzpTs97x82Y3KO6oPeOnonFJunXkqKVNAGEurDF6Xx/0WbzxodK7WTKBMbIRqYyNw8e5zWA358EVCptCTWdH2n5XmjdvvprlrNivuxyzEvnMLD7IHJmD4enmtdjpguQBg9kGbc93aujuteYSlY+A4IPMyvZ8HtLYjwca1Oddq0mfOeQyHm82AHJPI5VUpSeyXeN2mvh9X3tO3h18H7ce0jkYX8xgLlq3VXC+wiRkAFc4i57Xt5q78+R2AaRxuSlGIB5QRrfCVaB4QkBfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4nvD8HvtzpXVUv5aNA/IQKm3JWIQJVkRJxPCtU6DE4=;
 b=RacfVQYTT2Qc8PW9LnhEYSY8yKAYtDQC2iB0XXIulW0ERG2wbBacwKfii2KDM9fPUnwdduoaNjH3ehd4DzgVWRiMVuJ0cjXS7+G0SkpzPNYSX8OIBT/eDdC21Lsf6eer9JinO+q3fOEuj9Fml4ypPph2xoePKJFDoILR0Xmlgx50UgUrVUEuAOWzCU4CdrGiTnk/somlk8ImcBreOI8pVwNCOYf86nEQsJfNexiIn6BZgkbmaXuy5+s1/MK60JJIwSeNp9Ue8I5VVp75P4iJwOXO/vsrzzLfoITT7CdxjrHJoVhxBw0dYQgAvbT9rIthvY3j39pgg1IZu5ke2Oq21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4nvD8HvtzpXVUv5aNA/IQKm3JWIQJVkRJxPCtU6DE4=;
 b=fQgFIDsNvyqJDDm6y4vwkEQSGAymoNBoiI05/9eMH+NuH2EFGZUY7H9mpRRemkOHYXx0OANgcar24X97tRKQyCxyLlU6+u2nuDlZfp4ebzRwkKtb0Gi77d7k54fmXBFJOi1McMzEcG3pCzI2EBPvbSElCSOoPnRvhmmSeJdDn94=
Received: from MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::11)
 by BN7PR12MB2708.namprd12.prod.outlook.com (2603:10b6:408:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:43:23 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::97) by MW4P221CA0006.outlook.office365.com
 (2603:10b6:303:8b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Fri, 6 May 2022 15:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:22 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:18 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/15] drm/amd/display: remove redundant CONFIG_DRM_AMD_DC_DCN
 in dce
Date: Fri, 6 May 2022 23:42:07 +0800
Message-ID: <20220506154214.3438665-9-stylon.wang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef1ccd22-236f-4053-1c06-08da2f772713
X-MS-TrafficTypeDiagnostic: BN7PR12MB2708:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB27089EE622E5BBF3499F24FEFFC59@BN7PR12MB2708.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEjbWy+PoHOmBRD4Z2rstZ1KFP0ipIuUkovttQHic2rNjUMj1uPmEYNdkLGsMNYM+dPfFW31fGhMVI3+YmiDp4OMaBxF0gNoBKACxyG5QGzJjGINx0afXpnaE6qSVeoPjdkXL1X2seVxbcuJ/2NalA7bDk8du716JUGg7l0dgd3ilpqOY9IW1958bv+Doy3rNCosy/KdhIINLSFcnXDUT9ONCQdu22xf7RaEkDnw5YQ4/oK6mLywWe26rE1scshlbPFik5Z4QUMVla17A++hJDjAaCm0JSLb5mhRKoYgy79YZ40BQiaAcRvzy0ASwboSTTMrSu/c8H1PVW4s8YuybW05UfRvcTCqOrwbbUu11aAOFuI0kNT58jpcGyBPVd2hoJnYG9BE5NXKEV2l2OihVKVa3YQhJOO8o+4M05Js3rgKoUWWs9VF/FOxtxUFdT3X1x432dfP5cOuflUaAPtCrifjx5IJs7ukZ7fajLHdLzq/rqDjA24PGdnFpVGz0YIvkEyP6dokFJyttNHmgu/EACNemhoGH6xuq0PugamGMuvGslfpCrRu8gaZVmoHmOoaPdSwSggv4njgVEWb1WmvG9Xpz7GlVnyAjvTJyPy3PHVBtyJD4VZhybLoYkIMvBMMntmTcCG79bB6DD3ZLSlHy1/hbXdlBO/0X/j+WETy/BLkoM0q8Y9o52NmtQYNl5gaOOdLahz6mkuF8/voYmwu4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(186003)(40460700003)(81166007)(30864003)(508600001)(5660300002)(86362001)(82310400005)(356005)(8936002)(83380400001)(70586007)(47076005)(70206006)(6666004)(4326008)(2906002)(7696005)(8676002)(426003)(336012)(6916009)(36756003)(1076003)(54906003)(316002)(2616005)(44832011)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:22.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ccd22-236f-4053-1c06-08da2f772713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2708
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
in dce directory.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 15 +------------
 .../drm/amd/display/dc/dce/dce_clock_source.h | 12 +----------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 10 ---------
 .../amd/display/dc/dce/dce_stream_encoder.c   | 21 +------------------
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 --
 5 files changed, 3 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 760653e2b607..5e6fea85a7b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -918,7 +918,6 @@ static bool dce112_program_pix_clk(
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
 		unsigned int inst = pix_clk_params->controller_id - CONTROLLER_ID_D0;
 		unsigned dp_dto_ref_100hz = 7000000;
@@ -932,7 +931,6 @@ static bool dce112_program_pix_clk(
 		REG_UPDATE(PIXEL_RATE_CNTL[inst], DP_DTO0_ENABLE, 1);
 		return true;
 	}
-#endif
 	/* First disable SS
 	 * ATOMBIOS will enable by default SS on PLL for DP,
 	 * do not disable it here
@@ -971,7 +969,6 @@ static bool dce112_program_pix_clk(
 	return true;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static bool dcn31_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
@@ -1062,7 +1059,6 @@ static bool dcn31_program_pix_clk(
 
 	return true;
 }
-#endif
 
 static bool dce110_clock_source_power_down(
 		struct clock_source *clk_src)
@@ -1121,7 +1117,6 @@ static bool get_pixel_clk_frequency_100hz(
 	return false;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 /* this table is use to find *1.001 and /1.001 pixel rates from non-precise pixel rate */
 const struct pixel_rate_range_table_entry video_optimized_pixel_rates[] = {
 	// /1.001 rates
@@ -1171,7 +1166,6 @@ const struct pixel_rate_range_table_entry *look_up_in_video_optimized_rate_tlb(
 
 	return NULL;
 }
-#endif
 
 static bool dcn20_program_pix_clk(
 		struct clock_source *clock_source,
@@ -1218,7 +1212,6 @@ static const struct clock_source_funcs dcn20_clk_src_funcs = {
 	.override_dp_pix_clk = dcn20_override_dp_pix_clk
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static bool dcn3_program_pix_clk(
 		struct clock_source *clock_source,
 		struct pixel_clk_params *pix_clk_params,
@@ -1304,7 +1297,7 @@ static const struct clock_source_funcs dcn31_clk_src_funcs = {
 	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
 	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
 };
-#endif
+
 /*****************************************/
 /* Constructor                           */
 /*****************************************/
@@ -1690,7 +1683,6 @@ bool dcn20_clk_src_construct(
 	return ret;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dcn3_clk_src_construct(
 	struct dce110_clk_src *clk_src,
 	struct dc_context *ctx,
@@ -1706,9 +1698,7 @@ bool dcn3_clk_src_construct(
 
 	return ret;
 }
-#endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dcn31_clk_src_construct(
 	struct dce110_clk_src *clk_src,
 	struct dc_context *ctx,
@@ -1724,9 +1714,7 @@ bool dcn31_clk_src_construct(
 
 	return ret;
 }
-#endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dcn301_clk_src_construct(
 	struct dce110_clk_src *clk_src,
 	struct dc_context *ctx,
@@ -1742,4 +1730,3 @@ bool dcn301_clk_src_construct(
 
 	return ret;
 }
-#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 069de7649c8c..9eec3524335f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -100,7 +100,6 @@
 		SRII(PIXEL_RATE_CNTL, OTG, 2),\
 		SRII(PIXEL_RATE_CNTL, OTG, 3)
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #define CS_COMMON_REG_LIST_DCN3_0(index, pllid) \
 		SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
 		SRII(PHASE, DP_DTO, 0),\
@@ -130,9 +129,7 @@
 		SRII(PIXEL_RATE_CNTL, OTG, 1),\
 		SRII(PIXEL_RATE_CNTL, OTG, 2),\
 		SRII(PIXEL_RATE_CNTL, OTG, 3)
-#endif
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 #define CS_COMMON_REG_LIST_DCN3_02(index, pllid) \
 		SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
 		SRII(PHASE, DP_DTO, 0),\
@@ -160,15 +157,13 @@
 		SRII(PIXEL_RATE_CNTL, OTG, 0),\
 		SRII(PIXEL_RATE_CNTL, OTG, 1)
 
-#endif
+
 #define CS_COMMON_MASK_SH_LIST_DCN2_0(mask_sh)\
 	CS_SF(DP_DTO0_PHASE, DP_DTO0_PHASE, mask_sh),\
 	CS_SF(DP_DTO0_MODULO, DP_DTO0_MODULO, mask_sh),\
 	CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, mask_sh),\
 	CS_SF(OTG0_PIXEL_RATE_CNTL, DP_DTO0_ENABLE, mask_sh)
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
 #define CS_COMMON_REG_LIST_DCN1_0(index, pllid) \
 		SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
 		SRII(PHASE, DP_DTO, 0),\
@@ -190,7 +185,6 @@
 	CS_SF(PHYPLLA_PIXCLK_RESYNC_CNTL, PHYPLLA_DCCG_DEEP_COLOR_CNTL, mask_sh),\
 	CS_SF(OTG0_PIXEL_RATE_CNTL, DP_DTO0_ENABLE, mask_sh)
 
-#endif
 
 #define CS_REG_FIELD_LIST(type) \
 	type PLL_REF_DIV_SRC; \
@@ -274,7 +268,6 @@ bool dcn20_clk_src_construct(
 	const struct dce110_clk_src_shift *cs_shift,
 	const struct dce110_clk_src_mask *cs_mask);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 bool dcn3_clk_src_construct(
 	struct dce110_clk_src *clk_src,
 	struct dc_context *ctx,
@@ -301,7 +294,6 @@ bool dcn31_clk_src_construct(
 	const struct dce110_clk_src_regs *regs,
 	const struct dce110_clk_src_shift *cs_shift,
 	const struct dce110_clk_src_mask *cs_mask);
-#endif
 
 /* this table is use to find *1.001 and /1.001 pixel rates from non-precise pixel rate */
 struct pixel_rate_range_table_entry {
@@ -312,10 +304,8 @@ struct pixel_rate_range_table_entry {
 	unsigned short div_factor;
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 extern const struct pixel_rate_range_table_entry video_optimized_pixel_rates[];
 const struct pixel_rate_range_table_entry *look_up_in_video_optimized_rate_tlb(
 		unsigned int pixel_rate_khz);
-#endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 8cd841320ded..7183ac5780a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -70,9 +70,7 @@
 //Register access policy version
 #define mmMP0_SMN_C2PMSG_91				0x1609B
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static const uint32_t abm_gain_stepsize = 0x0060;
-#endif
 
 static bool dce_dmcu_init(struct dmcu *dmcu)
 {
@@ -333,7 +331,6 @@ static void dce_get_psr_wait_loop(
 	return;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void dcn10_get_dmcu_version(struct dmcu *dmcu)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
@@ -930,7 +927,6 @@ static bool dcn10_recv_edid_cea_ack(struct dmcu *dmcu, int *offset)
 	return false;
 }
 
-#endif //(CONFIG_DRM_AMD_DC_DCN)
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 static void dcn10_forward_crc_window(struct dmcu *dmcu,
@@ -1021,7 +1017,6 @@ static const struct dmcu_funcs dce_funcs = {
 	.is_dmcu_initialized = dce_is_dmcu_initialized
 };
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static const struct dmcu_funcs dcn10_funcs = {
 	.dmcu_init = dcn10_dmcu_init,
 	.load_iram = dcn10_dmcu_load_iram,
@@ -1065,7 +1060,6 @@ static const struct dmcu_funcs dcn21_funcs = {
 	.lock_phy = dcn20_lock_phy,
 	.unlock_phy = dcn20_unlock_phy
 };
-#endif
 
 static void dce_dmcu_construct(
 	struct dce_dmcu *dmcu_dce,
@@ -1085,7 +1079,6 @@ static void dce_dmcu_construct(
 	dmcu_dce->dmcu_mask = dmcu_mask;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 static void dcn21_dmcu_construct(
 		struct dce_dmcu *dmcu_dce,
 		struct dc_context *ctx,
@@ -1103,7 +1096,6 @@ static void dcn21_dmcu_construct(
 		dmcu_dce->base.psp_version = psp_version;
 	}
 }
-#endif
 
 struct dmcu *dce_dmcu_create(
 	struct dc_context *ctx,
@@ -1126,7 +1118,6 @@ struct dmcu *dce_dmcu_create(
 	return &dmcu_dce->base;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 struct dmcu *dcn10_dmcu_create(
 	struct dc_context *ctx,
 	const struct dce_dmcu_registers *regs,
@@ -1189,7 +1180,6 @@ struct dmcu *dcn21_dmcu_create(
 
 	return &dmcu_dce->base;
 }
-#endif
 
 void dce_dmcu_destroy(struct dmcu **dmcu)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 779bc92a2968..a8c92b517df1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -136,7 +136,7 @@ static void dce110_update_generic_info_packet(
 			AFMT_GENERIC0_UPDATE, (packet_index == 0),
 			AFMT_GENERIC2_UPDATE, (packet_index == 2));
 	}
-#if defined(CONFIG_DRM_AMD_DC_DCN)
+
 	if (REG(AFMT_VBI_PACKET_CONTROL1)) {
 		switch (packet_index) {
 		case 0:
@@ -175,7 +175,6 @@ static void dce110_update_generic_info_packet(
 			break;
 		}
 	}
-#endif
 }
 
 static void dce110_update_hdmi_info_packet(
@@ -230,7 +229,6 @@ static void dce110_update_hdmi_info_packet(
 				HDMI_GENERIC1_SEND, send,
 				HDMI_GENERIC1_LINE, line);
 		break;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	case 4:
 		if (REG(HDMI_GENERIC_PACKET_CONTROL2))
 			REG_UPDATE_3(HDMI_GENERIC_PACKET_CONTROL2,
@@ -259,7 +257,6 @@ static void dce110_update_hdmi_info_packet(
 					HDMI_GENERIC1_SEND, send,
 					HDMI_GENERIC1_LINE, line);
 		break;
-#endif
 	default:
 		/* invalid HW packet index */
 		DC_LOG_WARNING(
@@ -277,7 +274,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	bool use_vsc_sdp_for_colorimetry,
 	uint32_t enable_sdp_splitting)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	uint32_t h_active_start;
 	uint32_t v_active_start;
 	uint32_t misc0 = 0;
@@ -288,7 +284,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	uint8_t colorimetry_bpc;
 	uint8_t dynamic_range_rgb = 0; /*full range*/
 	uint8_t dynamic_range_ycbcr = 1; /*bt709*/
-#endif
 
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 	struct dc_crtc_timing hw_crtc_timing = *crtc_timing;
@@ -329,10 +324,8 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		if (enc110->se_mask->DP_VID_M_DOUBLE_VALUE_EN)
 			REG_UPDATE(DP_VID_TIMING, DP_VID_M_DOUBLE_VALUE_EN, 1);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (enc110->se_mask->DP_VID_N_MUL)
 			REG_UPDATE(DP_VID_TIMING, DP_VID_N_MUL, 1);
-#endif
 		break;
 	default:
 		REG_UPDATE(DP_PIXEL_FORMAT, DP_PIXEL_ENCODING,
@@ -340,10 +333,8 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		break;
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (REG(DP_MSA_MISC))
 		misc1 = REG_READ(DP_MSA_MISC);
-#endif
 
 	/* set color depth */
 
@@ -374,7 +365,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	/* set dynamic range and YCbCr range */
 
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	switch (hw_crtc_timing.display_color_depth) {
 	case COLOR_DEPTH_666:
 		colorimetry_bpc = 0;
@@ -454,7 +444,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				DP_DYN_RANGE, dynamic_range_rgb,
 				DP_YCBCR_RANGE, dynamic_range_ycbcr);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (REG(DP_MSA_COLORIMETRY))
 			REG_SET(DP_MSA_COLORIMETRY, 0, DP_MSA_MISC0, misc0);
 
@@ -468,7 +457,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 			REG_SET_2(DP_MSA_TIMING_PARAM1, 0,
 					DP_MSA_HTOTAL, hw_crtc_timing.h_total,
 					DP_MSA_VTOTAL, hw_crtc_timing.v_total);
-#endif
 
 		/* calcuate from vesa timing parameters
 		 * h_active_start related to leading edge of sync
@@ -489,7 +477,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				hw_crtc_timing.v_front_porch;
 
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 		/* start at begining of left border */
 		if (REG(DP_MSA_TIMING_PARAM2))
 			REG_SET_2(DP_MSA_TIMING_PARAM2, 0,
@@ -514,9 +501,7 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				hw_crtc_timing.h_addressable + hw_crtc_timing.h_border_right,
 				DP_MSA_VHEIGHT, hw_crtc_timing.v_border_top +
 				hw_crtc_timing.v_addressable + hw_crtc_timing.v_border_bottom);
-#endif
 	}
-#endif
 }
 
 static void dce110_stream_encoder_set_stream_attribute_helper(
@@ -787,7 +772,6 @@ static void dce110_stream_encoder_update_hdmi_info_packets(
 		dce110_update_hdmi_info_packet(enc110, 3, &info_frame->hdrsmd);
 	}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (enc110->se_mask->HDMI_DB_DISABLE) {
 		/* for bring up, disable dp double  TODO */
 		if (REG(HDMI_DB_CONTROL))
@@ -799,7 +783,6 @@ static void dce110_stream_encoder_update_hdmi_info_packets(
 		dce110_update_hdmi_info_packet(enc110, 3, &info_frame->spd);
 		dce110_update_hdmi_info_packet(enc110, 4, &info_frame->hdrsmd);
 	}
-#endif
 }
 
 static void dce110_stream_encoder_stop_hdmi_info_packets(
@@ -825,7 +808,6 @@ static void dce110_stream_encoder_stop_hdmi_info_packets(
 		HDMI_GENERIC1_LINE, 0,
 		HDMI_GENERIC1_SEND, 0);
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* stop generic packets 2 & 3 on HDMI */
 	if (REG(HDMI_GENERIC_PACKET_CONTROL2))
 		REG_SET_6(HDMI_GENERIC_PACKET_CONTROL2, 0,
@@ -844,7 +826,6 @@ static void dce110_stream_encoder_stop_hdmi_info_packets(
 			HDMI_GENERIC1_CONT, 0,
 			HDMI_GENERIC1_LINE, 0,
 			HDMI_GENERIC1_SEND, 0);
-#endif
 }
 
 static void dce110_stream_encoder_update_dp_info_packets(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 9fc1ba12ec19..7eff7811769d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1365,11 +1365,9 @@ static void program_scaler(const struct dc *dc,
 {
 	struct tg_color color = {0};
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* TOFPGA */
 	if (pipe_ctx->plane_res.xfm->funcs->transform_set_pixel_storage_depth == NULL)
 		return;
-#endif
 
 	if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
 		get_surface_visual_confirm_color(pipe_ctx, &color);
-- 
2.35.1

