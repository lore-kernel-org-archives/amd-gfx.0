Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3D3CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8463010E0E0;
	Tue, 26 May 2026 07:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uGsVcf22";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED2510E0E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNbqVakFO6vSgG80428myRkPDq+uVVXUhZ903Q1D1x6GLj6gtrWfPGKcRPAT5dnNH34s31QyZLVKyg2Nd/Vm1UfaU+RgP0+YWTJkW8Pig7SbeC4hk8/qsyWOMSL1jOrJjBHkiK7+M8LTlfURFQLd7B/ENsk0NyVcFJvQhbpHNYWpBq+22RJBEeQZgd3xpM6svea1ycQmUvy1yEPXPrhLdA/C2PSQNLBfSurI3g7UL2wGs5uAbKLST2oLVNFbHlw6umywAFgU1O+ku/mgH/ZRM9AZyIniMq2mTPcniZQIMOACcaITb/FaSvaamSaCqqtVltNm/hN6Fe5IE7W9DlDlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtwDSCjdWwTXH+5BjxB0IG9hOcipUQvcjq+iRIC7rus=;
 b=Bg0JmMnit4V9wI0ahwL6CHyHAvoCyJO2aBg7g9fI6CrLn9RzGu2jlT/2GYWZpvvQRC5SvBGwomocfAn2vHmkbrIZHmu/oQf3087gu6bNwG5c1+JhAWPkQ8MhPSyJtCrYqhnfVSvH18cdS2IC9K5khI1WhvM+RLwgsBVOPe/vbdFUt7qcnghjhtlaFY5ZvmjU1RF9mGdMbWXvLXPog0jAyZ1Gj5ehnVu5e2vjacBwcyvwiMbyMzfqIHjDzPyn1rMO2Eghb35HU2IgRmB9Qa4qB/qr/WhcmkwW9aKhP+FdJe3h5rTg9uwpasx9a725bsipZRljqZ9+dclduIZw2CRdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtwDSCjdWwTXH+5BjxB0IG9hOcipUQvcjq+iRIC7rus=;
 b=uGsVcf22NAwjM3dONl9fADwh/DXlpncC6vY0p/DIR0qsA3EAqMWD6aYuco06wl09Jq/5+hh0g2G6DQbb8le5vN41mwtARoh8H8FDEZ86ZFhpn66+S7xUGeIgofE2hACyDSxgczKPOsQzbBp1ePaZfk6jSr/0DWxmYL5NsX1ybbI=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::992) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:14:37 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::20) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:14:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:14:35 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:14:26 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Leo Chen
 <leo.chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 01/41] drm/amd/display: Update get_pixel_clk_frequency() for
 DCN4x DCCG DP DTO
Date: Tue, 26 May 2026 15:01:24 +0800
Message-ID: <20260526071413.2181251-2-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 0287c805-4b5b-4081-bd3e-08debaf6719f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vXLOaP5ZpgRB+K3/6pYSxsQeGWI/6PrNM00wUXHOmSlP+zF03WjiSXF0mepYyOfY00SyfkuM1Mw1pbk81A+q3HlKKgUcS85MPnU0KOmq0m2lrDLGaNr37vzoZACe73kgYlslL2cupNdu0qsIPheirnTYvUX55jiBnlPhkQnOwn3B2rkdxXV+1nsjT16F7A+1f1ppdOzyyfQ6q3drjCzKd0BJn0h38Bd/GxWXP4lH33mRT14NJXnej5KWMMayGrtN7ICk1QAOU74mp7zpTKEWWw3k6JdQZ1lTQXBGraxw8iN+NyMPo2miJmFLZgmUqRJV8F8YspluQC6mvlr7ICMfVwZHaHGT+FnvteZrwuQ+cOY3EYJLLIPaN0rZRVqSAxyNzI6Dh+jgFYoR/jytrsrglfNtarjJJc8jqaZyzWlk4HkAGtWEBfH1TgMv1ZDIu+uNvMXllDZlvLVjELzVrCDY878LrVq8dYfE439660jGhGD076tUf1sTlves6xVVVpz9g0Mj9X+VFJz7H0S7JBMNX3W/wDRzzaj7T7hosliUer+ZXml0AlDNc91FZ/IL728e1oo0v8Xl7Hb4+keMYaU3XPArmND7VR7NgDSox99rAwTa9X182XPzBbIAyAmwXFpJ2hTy0+lCpJkjI/PtEGhHj99NPTxlwio0dHD5aTn+sXOyzAKa0X3C5tieOP8gTolkCSNipQxI4dYmaWTC+ebL6e/7stUN9IJq2XS3XQZcGAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kpt782fBXTbq/mhPXhO01Ovj9doQkyx1OVlCPj0dmPn1MAgr73ugVilpPlHPjJEDigPNfxMH7Vxwk3tz92En1AJGS+fKpxTX9NeEesqMoQUiZO/SA1jjQrrikkBiHzKp+oCo6qXVTcVYHUIYnwuX6SINpilYKr0UWeY/o309eEsLCJMOgItaqC+f8DBs8AET8XFBZ0lL8xE+hTcbMHMgRRS+z3o31sx4J9ak7erd1y9z2JAVGpys5JI4noiNZvB3YyA+ylqkz0dhkVerPrecehthk2ViFTeC1znvCjHPUEfg/g2yZh6HUqN3Om/RtqSGJJOHbCAg2kOOAtLIu9LrdO7Tl3DYBc72Dm7IObf6z5qyJw3f36bpzNOQXDaZxPSGoNpbIE+zHiBYJbe9jiNSzZU27oBUrntpegQPqeKiDAoLQSy82safVviu7jBxcUDH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:14:36.3336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287c805-4b5b-4081-bd3e-08debaf6719f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why & How]
DCN4x ASICs have different DCCG logic for programming DP DTO. The current
get_pixel_clk_frequency_100hz() function does not account for this.

Rename the function to "get_dp_dto_frequency" to more accurately
reflect its intended behaviour. Create a new function that correctly
calculates the target pixel rate for DCN4.x DCCG design and use it.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c | 85 ++++++++++++++++---
 .../drm/amd/display/dc/dce/dce_clock_source.h |  7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  4 +-
 .../gpu/drm/amd/display/dc/inc/clock_source.h |  4 +-
 5 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0f37209c8330..62e48d2ba513 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1487,7 +1487,7 @@ static void disable_vbios_mode_if_required(
 					}
 				}
 
-				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+				dc->res_pool->dp_clock_source->funcs->get_dp_dto_frequency_100hz(
 					dc->res_pool->dp_clock_source,
 					tg_inst, &pix_clk_100hz);
 
@@ -2004,7 +2004,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		uint32_t numOdmPipes = 1;
 		uint32_t id_src[4] = {0};
 
-		dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+		dc->res_pool->dp_clock_source->funcs->get_dp_dto_frequency_100hz(
 			dc->res_pool->dp_clock_source,
 			tg_inst, &pix_clk_100hz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index b97b4cd23eaa..f454eb812c21 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1188,15 +1188,16 @@ static bool dce110_clock_source_power_down(
 	return bp_result == BP_RESULT_OK;
 }
 
-static bool get_pixel_clk_frequency_100hz(
+static bool get_dp_dto_frequency_100hz(
 		const struct clock_source *clock_source,
 		unsigned int inst,
-		unsigned int *pixel_clk_khz)
+		unsigned int *pixel_clk_100hz)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
 	unsigned int clock_hz = 0;
 	unsigned int modulo_hz = 0;
 	unsigned int dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dprefclk_khz;
+	unsigned long long temp = 0;
 
 	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
 		clock_hz = REG_READ(PHASE[inst]);
@@ -1207,17 +1208,18 @@ static bool get_pixel_clk_frequency_100hz(
 			 * not be programmed equal to DPREFCLK
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
-			if (modulo_hz)
-				*pixel_clk_khz = (unsigned int)div_u64((uint64_t)clock_hz *
-					dp_dto_ref_khz * 10, modulo_hz);
-			else
-				*pixel_clk_khz = 0;
+			if (modulo_hz) {
+				temp = div_u64((uint64_t)clock_hz * dp_dto_ref_khz * 10, modulo_hz);
+				ASSERT(temp / 100 <= 0xFFFFFFFFUL);
+				*pixel_clk_100hz = (unsigned int)(temp / 100);
+			} else
+				*pixel_clk_100hz = 0;
 		} else {
 			/* NOTE: There is agreement with VBIOS here that MODULO is
 			 * programmed equal to DPREFCLK, in which case PHASE will be
 			 * equivalent to pixel clock.
 			 */
-			*pixel_clk_khz = clock_hz / 100;
+			*pixel_clk_100hz = clock_hz / 100;
 		}
 		return true;
 	}
@@ -1225,6 +1227,61 @@ static bool get_pixel_clk_frequency_100hz(
 	return false;
 }
 
+static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_source, unsigned int inst,
+					      unsigned int *pixel_clk_100hz)
+{
+	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
+	unsigned int phase_hz = 0;
+	unsigned int modulo_hz = 0;
+	unsigned int dp_dto_integer = 0;
+	unsigned long long temp = 0;
+
+	if (clock_source->id == CLOCK_SOURCE_ID_DP_DTO) {
+		phase_hz = REG_READ(PHASE[inst]);
+		modulo_hz = REG_READ(MODULO[inst]);
+
+		switch (inst) {
+		case 0:
+			REG_GET(OTG_PIXEL_RATE_DIV, DPDTO0_INT, &dp_dto_integer);
+			break;
+		case 1:
+			REG_GET(OTG_PIXEL_RATE_DIV, DPDTO1_INT, &dp_dto_integer);
+			break;
+		case 2:
+			REG_GET(OTG_PIXEL_RATE_DIV, DPDTO2_INT, &dp_dto_integer);
+			break;
+		case 3:
+			REG_GET(OTG_PIXEL_RATE_DIV, DPDTO3_INT, &dp_dto_integer);
+			break;
+		default:
+			BREAK_TO_DEBUGGER();
+			break;
+		}
+
+		/* On DCN4x, the DCCG DPDTO is directly programmed with the required pixel clock as per the following formula:
+		 *     - DPDTO INTEGER = INT(4:4:4 pixel rate / DTBCLK_P rate)
+		 *     - DPDTO PHASE = 4:4:4 pixel rate – DPDTO INTEGER * DTBCLK_P rate
+		 *     - DPDTO MODULO = DTBCLK_P rate
+		 *     - target pix_clk_hz = (DPDTO INTEGER * DPDTO MODULO + DPDTO PHASE)
+		 */
+
+		dp_dto_integer += 1; // integer=0 represents 1x multiplier, etc.
+		temp = (unsigned long long)dp_dto_integer * modulo_hz + phase_hz;
+
+		if (temp / 100 > 0xFFFFFFFFUL) {
+			/* pixel rate 100hz should never be this high, if it is, throw an assert and return 0  */
+			BREAK_TO_DEBUGGER();
+			*pixel_clk_100hz = 0;
+		} else {
+			*pixel_clk_100hz = (unsigned int)(temp / 100);
+		}
+
+		return true;
+	}
+
+	return false;
+}
+
 /* this table is use to find *1.001 and /1.001 pixel rates from non-precise pixel rate */
 const struct pixel_rate_range_table_entry video_optimized_pixel_rates[] = {
 	// /1.001 rates
@@ -1318,7 +1375,7 @@ static const struct clock_source_funcs dcn20_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn20_program_pix_clk,
 	.get_pix_clk_dividers = dce112_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz,
+	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz,
 	.override_dp_pix_clk = dcn20_override_dp_pix_clk
 };
 
@@ -1405,21 +1462,21 @@ static const struct clock_source_funcs dcn3_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn3_program_pix_clk,
 	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
 static const struct clock_source_funcs dcn31_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn31_program_pix_clk,
 	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
 static const struct clock_source_funcs dcn401_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dcn401_program_pix_clk,
 	.get_pix_clk_dividers = dcn3_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_dp_dto_frequency_100hz = dcn401_get_dp_dto_frequency_100hz
 };
 
 /*****************************************/
@@ -1430,13 +1487,13 @@ static const struct clock_source_funcs dce112_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dce112_program_pix_clk,
 	.get_pix_clk_dividers = dce112_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 static const struct clock_source_funcs dce110_clk_src_funcs = {
 	.cs_power_down = dce110_clock_source_power_down,
 	.program_pix_clk = dce110_program_pix_clk,
 	.get_pix_clk_dividers = dce110_get_pix_clk_dividers,
-	.get_pixel_clk_frequency_100hz = get_pixel_clk_frequency_100hz
+	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 94128f7a18b1..9441aa6a897f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -202,7 +202,11 @@
 	type PLL_REF_DIV; \
 	type DP_DTO0_PHASE; \
 	type DP_DTO0_MODULO; \
-	type DP_DTO0_ENABLE;
+	type DP_DTO0_ENABLE; \
+	type DPDTO0_INT; \
+	type DPDTO1_INT; \
+	type DPDTO2_INT; \
+	type DPDTO3_INT;
 
 #define CS_REG_FIELD_LIST_DCN32(type) \
 	type PIPE0_DTO_SRC_SEL;
@@ -221,6 +225,7 @@ struct dce110_clk_src_regs {
 	uint32_t RESYNC_CNTL;
 	uint32_t PIXCLK_RESYNC_CNTL;
 	uint32_t PLL_CNTL;
+	uint32_t OTG_PIXEL_RATE_DIV;
 
 	/* below are for DTO.
 	 * todo: should probably use different struct to not waste space
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index a1c3c4454397..7ddc68cc7184 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2423,7 +2423,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 			grouped_pipes[i]->stream_res.tg->funcs->get_hw_timing(
 					grouped_pipes[i]->stream_res.tg,
 					&hw_crtc_timing[i]);
-			dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+			dc->res_pool->dp_clock_source->funcs->get_dp_dto_frequency_100hz(
 				dc->res_pool->dp_clock_source,
 				grouped_pipes[i]->stream_res.tg->inst,
 				&pclk);
@@ -2462,7 +2462,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 					dc->res_pool->dp_clock_source,
 					grouped_pipes[i]->stream_res.tg->inst,
 					(unsigned int)phase[i], (unsigned int)modulo[i]);
-				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
+				dc->res_pool->dp_clock_source->funcs->get_dp_dto_frequency_100hz(
 					dc->res_pool->dp_clock_source,
 					grouped_pipes[i]->stream_res.tg->inst, &pclk);
 				grouped_pipes[i]->stream->timing.pix_clk_100hz =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
index ed2f8005d85e..6bbbb8ea7dad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/clock_source.h
@@ -170,10 +170,10 @@ struct clock_source_funcs {
 			struct clock_source *,
 			struct pixel_clk_params *,
 			struct pll_settings *);
-	bool (*get_pixel_clk_frequency_100hz)(
+	bool (*get_dp_dto_frequency_100hz)(
 			const struct clock_source *clock_source,
 			unsigned int inst,
-			unsigned int *pixel_clk_khz);
+			unsigned int *pixel_clk_100hz);
 	bool (*override_dp_pix_clk)(
 			struct clock_source *clock_source,
 			unsigned int inst,
-- 
2.43.0

