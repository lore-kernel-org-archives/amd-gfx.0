Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FF2CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B2CC10E4F6;
	Tue, 26 May 2026 07:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnC4kBXA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84E910E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkLCdpR218rGYC68L4OUd24rN4CwwO6nmh5ZUa54OCDNFkJ/0Ufu9QeedBo8/WdSc+6JTrEmW6XVL2Iv9S+Q+TwM0zrM6JHZN3hSkGGHnLQmdOkiSHM+GoTFC6NFDt0B07eCNjo7ENst0z5vKfXtMgphmfUmVEvvVwM1LZicyyYdE8idDQ++458yozDnVyMABpYH6vJpSLGX7dbGFgANYPmF/laoCbQ8DHqVHEaNZ062c3FmPbf9g6hVaxt8cp4P6TnbJhs5nL+fO6uTA0kL2BtD6Yr5wT21kf8+bf3sAwsfRxDAQhj4ggUx8weZGS3AljyIO43oHeksz0B0/2//7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLg8+bhX+hkAHWoBHkMZzr8oweyOzBt2MSOwPwbuzHw=;
 b=lLLzGCcMY53aotn1SBCO4ZD8lZjzAmPS9wCeiDhg4nw06gv3utAogEBW6TiPWPY40469+AKAUA5jxERS4BYdqCVi0LXu/Y9snTV3A1L6vKP0Tn5cw5gjnniMF2V+KWTVyakZZGPtNrtAbq5Qx9fjbMmpkDhQzQ6e5L3F1tBqIiZemlRpUk9fEOSHru1UMojhqdz3Pabs9i9PgmzlpdHDr6eMiM3yUHxGdMFkAi0z4yzSxkOV3ZlrZS88isHwAV1U/1BCKawn7tZ7nzlhDv9mpC3LFl9vElNqDCcTiY/YPkN1PO1yboTElllDADenytxpY3xfQBkHZ6bWph92wpBucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLg8+bhX+hkAHWoBHkMZzr8oweyOzBt2MSOwPwbuzHw=;
 b=mnC4kBXABKAXGfYSggO2+wNAhYK6ydUPSYCbl0rH36OvxivqPM9OZ1nwMfvzRf38WESrpInubhLJDvHkI5Xbjy/ugFvEmRgBMGRuwurZRt9vV0agedCpjc6JHr6YqK2vN/0HtcIuhqyXQ4xF0QGEBH4FAg8Noq/Y2h6MufdU1Ac=
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 07:17:08 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::76) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:17:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:06 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:16:58 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 19/41] drm/amd/display: Fix DP_PIXEL_FORMAT fields & update
 clk_src for DCN4x
Date: Tue, 26 May 2026 15:01:42 +0800
Message-ID: <20260526071413.2181251-20-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfb69d7-6143-4bae-ccdd-08debaf6cbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: k3qJM6qOIJQxUbSE5PlujdMba5BNvnRkozxSnwOTT75tTYoEvO/sR0KpMO2O83/OpeTlbnNO05JfXmeMKLgwTwQfRukjddBCaGqG4byH1IamCIrD1Db8rr1iMSna3jNhXO/vcjSUFxDeXlnxsafRkdOhKyzQtXdJwz833oz8IyE/4VG5r0kFLlZFHdbedtxfaavVzwqIAXSmQYODiZjMR/j426AD2IvSU/PSvqxw2SeGVi2l5On9FAh6elZlsjpkWVZq8H8HGBxiTIkG+u2fCV1I8bf4Ohud/cuyOgTAQ4vEvVDA7GXF3c3drJm2tVhAMcXk1DkPh4Tj/Zq6C7ao8sVDPVpVUvAdDdn4H2nVDFGGFCFh7de1asYnLYTRL/plaeCbEGLRCch0dTrPDX1jjzqvnZ2t0AlfYXz5UkJ5OIwtfgcslWMHLqxjN3PkWKC6OS40oVlWJOAqx7rR76HgwPncEuFWvIhtju1+8c36FgPxFrOu6zJOFJ95iA0TS5PrkRVkRpnptcFRHATWZaGRqnKSCuga9sB688mj0wk1OYtoasa5fALyPSop4zAd1PZQlNcZ4oLncduuAZSBJC1PFSsakOJLLPUTmBbQDgu7CSkbUj5TlgeAT5spka2d2EzNeb1CC3UzpX86nds7/q5m3UifCedfJKZLpU+MSE38FmIR8JGQsgY2zJaMVg+IGyeTxnp8K7RXa7w25FmDPAz7ZJvb5+PbTI2ERe2rnrncWZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9W+3CoKwtBPH/fxyXcOCdTuE9+4O+wAxpXDk5ehDKpEw48P7WpB2LX4IYB8s1YNwjUBHrcPLVmeke0bgHkLg/1ukWS88ObTejc/+tJHMp+Dld9ETsfS2yXCV5TnuA0xYrKFgf5gkv1qmmB4+cdKA8QtZVx/WGiXrwepIMYyF6PP7w7p5EQFApIztaWtecu7spG7rg9Rt9fPkbVzias3uOQ8HyDuEZxW8Z0DaE2T8CMEh1okKIQ6GAIL1uB92QTtws+zN1HbX4b7KYZDCVBLxtXqPLRyxP2G7wERsnX2EuYNeFWavQS/2nCmJFpHlxfMZ5iEBXKW/wKxKLsoY7ZrYZwcpgeFO1wZUPuY676XO42fVmY5ZpPkIua8Ykm4ra4RPFhKtLYKq3ZzXqZEcA88i8GcfJweaZiYDwCpxN+JweO5NfgZCoZJyDB6+gutYJqia
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:17:07.7342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfb69d7-6143-4bae-ccdd-08debaf6cbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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
The enc1_stream_encoder_dp_get_pixel_format() function reads fields of the
DP_PIXEL_FORMAT register that are deprecated on DCN4x. This breaks seamless
boot because driver cannot properly determine the pixel format programmed by VBIOS.
The previous changed submitted for this issue incorrectly calculated the DP DTO
frequency because register access to DCN4x DP DTO registers was not working.

Create a new function that reads the correct fields.
Update clk_src structs to support register access for new DCN4x registers & fields.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 -
 .../drm/amd/display/dc/dce/dce_clock_source.h | 31 +++++++--
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   | 64 ++++++++++++++++++-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h   |  6 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  7 +-
 .../dc/resource/dcn42/dcn42_resource.h        |  3 +-
 7 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index f454eb812c21..50ff52867393 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1264,8 +1264,6 @@ static bool dcn401_get_dp_dto_frequency_100hz(const struct clock_source *clock_s
 		 *     - DPDTO MODULO = DTBCLK_P rate
 		 *     - target pix_clk_hz = (DPDTO INTEGER * DPDTO MODULO + DPDTO PHASE)
 		 */
-
-		dp_dto_integer += 1; // integer=0 represents 1x multiplier, etc.
 		temp = (unsigned long long)dp_dto_integer * modulo_hz + phase_hz;
 
 		if (temp / 100 > 0xFFFFFFFFUL) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
index 9441aa6a897f..55c96b4b7765 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.h
@@ -171,6 +171,17 @@
 	CS_COMMON_MASK_SH_LIST_DCN2_0(mask_sh),\
 	CS_SF(OTG0_PIXEL_RATE_CNTL, PIPE0_DTO_SRC_SEL, mask_sh)
 
+#define CS_COMMON_MASK_SH_LIST_DCN4_0_1(mask_sh)\
+	CS_COMMON_MASK_SH_LIST_DCN3_2(mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, OTG0_TMDS_PIXEL_RATE_DIV, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, DPDTO0_INT, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, OTG1_TMDS_PIXEL_RATE_DIV, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, DPDTO1_INT, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, OTG2_TMDS_PIXEL_RATE_DIV, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, DPDTO2_INT, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, OTG3_TMDS_PIXEL_RATE_DIV, mask_sh),\
+	CS_SF(OTG_PIXEL_RATE_DIV, DPDTO3_INT, mask_sh)
+
 #define CS_COMMON_REG_LIST_DCN1_0(index, pllid) \
 		SRI(PIXCLK_RESYNC_CNTL, PHYPLL, pllid),\
 		SRII(PHASE, DP_DTO, 0),\
@@ -202,23 +213,31 @@
 	type PLL_REF_DIV; \
 	type DP_DTO0_PHASE; \
 	type DP_DTO0_MODULO; \
-	type DP_DTO0_ENABLE; \
-	type DPDTO0_INT; \
-	type DPDTO1_INT; \
-	type DPDTO2_INT; \
-	type DPDTO3_INT;
+	type DP_DTO0_ENABLE;
 
 #define CS_REG_FIELD_LIST_DCN32(type) \
 	type PIPE0_DTO_SRC_SEL;
 
+#define CS_REG_FIELD_LIST_DCN401(type) \
+	type DPDTO0_INT; \
+	type DPDTO1_INT; \
+	type DPDTO2_INT; \
+	type DPDTO3_INT; \
+	type OTG0_TMDS_PIXEL_RATE_DIV; \
+	type OTG1_TMDS_PIXEL_RATE_DIV; \
+	type OTG2_TMDS_PIXEL_RATE_DIV; \
+	type OTG3_TMDS_PIXEL_RATE_DIV;
+
 struct dce110_clk_src_shift {
 	CS_REG_FIELD_LIST(uint8_t)
 	CS_REG_FIELD_LIST_DCN32(uint8_t)
+	CS_REG_FIELD_LIST_DCN401(uint8_t)
 };
 
-struct dce110_clk_src_mask{
+struct dce110_clk_src_mask {
 	CS_REG_FIELD_LIST(uint32_t)
 	CS_REG_FIELD_LIST_DCN32(uint32_t)
+	CS_REG_FIELD_LIST_DCN401(uint32_t)
 };
 
 struct dce110_clk_src_regs {
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
index 55ddb9cf8a52..35845e6dd5aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
@@ -447,6 +447,68 @@ void enc42_reset_hdmi_stream_attribute(
 		HDMI_CLOCK_CHANNEL_RATE, 0);
 }
 
+bool enc42_dio_get_uncompressed_dp_pixel_format(
+	struct stream_encoder *enc,
+	enum dc_pixel_encoding *encoding,
+	enum dc_color_depth *depth)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t is_compressed_pixel_format, uncompressed_component_depth, uncompressed_pixel_format, compressed_pixel_format;
+
+	if (enc == NULL || encoding == NULL || depth == NULL)
+		return false;
+
+	REG_GET_4(DP_PIXEL_FORMAT,
+		PIXEL_ENCODING_TYPE, &is_compressed_pixel_format,
+		UNCOMPRESSED_COMPONENT_DEPTH, &uncompressed_component_depth,
+		UNCOMPRESSED_PIXEL_FORMAT, &uncompressed_pixel_format,
+		COMPRESSED_PIXEL_FORMAT, &compressed_pixel_format);
+
+	if (!is_compressed_pixel_format) {
+		switch (uncompressed_component_depth) {
+		case DP_COMPONENT_PIXEL_DEPTH_6BPC:
+			*depth = COLOR_DEPTH_666;
+			break;
+		case DP_COMPONENT_PIXEL_DEPTH_8BPC:
+			*depth = COLOR_DEPTH_888;
+			break;
+		case DP_COMPONENT_PIXEL_DEPTH_10BPC:
+			*depth = COLOR_DEPTH_101010;
+			break;
+		case DP_COMPONENT_PIXEL_DEPTH_12BPC:
+			*depth = COLOR_DEPTH_121212;
+			break;
+		case DP_COMPONENT_PIXEL_DEPTH_16BPC:
+			*depth = COLOR_DEPTH_161616;
+			break;
+		default:
+			*depth = COLOR_DEPTH_UNDEFINED;
+			break;
+		}
+
+		switch (uncompressed_pixel_format) {
+		case DP_PIXEL_ENCODING_TYPE_RGB444:
+			*encoding = PIXEL_ENCODING_RGB;
+			break;
+		case DP_PIXEL_ENCODING_TYPE_YCBCR422:
+			*encoding = PIXEL_ENCODING_YCBCR422;
+			break;
+		case DP_PIXEL_ENCODING_TYPE_YCBCR444:
+		case DP_PIXEL_ENCODING_TYPE_Y_ONLY:
+			*encoding = PIXEL_ENCODING_YCBCR444;
+			break;
+		case DP_PIXEL_ENCODING_TYPE_YCBCR420:
+			*encoding = PIXEL_ENCODING_YCBCR420;
+			break;
+		default:
+			*encoding = PIXEL_ENCODING_UNDEFINED;
+			break;
+		}
+	}
+
+	return true;
+}
+
 static const struct stream_encoder_funcs dcn42_str_enc_funcs = {
 	.dp_set_stream_attribute =
 		enc401_stream_encoder_dp_set_stream_attribute,
@@ -483,7 +545,7 @@ static const struct stream_encoder_funcs dcn42_str_enc_funcs = {
 	.dig_connect_to_otg = enc1_dig_connect_to_otg,
 	.dig_source_otg = enc1_dig_source_otg,
 
-	.dp_get_pixel_format  = enc1_stream_encoder_dp_get_pixel_format,
+	.dp_get_pixel_format  = enc42_dio_get_uncompressed_dp_pixel_format,
 
 	.enc_read_state = enc401_read_state,
 	.dp_set_dsc_config = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h
index 7a98fee46081..5c2d81cb040f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h
@@ -203,4 +203,10 @@ void enc42_se_enable_audio_clock(
 
 void enc42_reset_hdmi_stream_attribute(
 	struct stream_encoder *enc);
+
+bool enc42_dio_get_uncompressed_dp_pixel_format(
+	struct stream_encoder *enc,
+	enum dc_pixel_encoding *encoding,
+	enum dc_color_depth *depth);
+
 #endif /* __DC_DIO_STREAM_ENCODER_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 9498cbff2449..bb1dd27f567b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -197,11 +197,11 @@ static struct bios_registers bios_regs;
 static struct dce110_clk_src_regs clk_src_regs[5];
 
 static const struct dce110_clk_src_shift cs_shift = {
-		CS_COMMON_MASK_SH_LIST_DCN3_2(__SHIFT)
+	CS_COMMON_MASK_SH_LIST_DCN4_0_1(__SHIFT)
 };
 
 static const struct dce110_clk_src_mask cs_mask = {
-		CS_COMMON_MASK_SH_LIST_DCN3_2(_MASK)
+	CS_COMMON_MASK_SH_LIST_DCN4_0_1(_MASK)
 };
 
 #define abm_regs_init(id)\
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 0feb4872412f..f2b7c820a3d2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -214,10 +214,10 @@ static struct bios_registers bios_regs;
 static struct dce110_clk_src_regs clk_src_regs[5];
 
 static const struct dce110_clk_src_shift cs_shift = {
-	CS_COMMON_MASK_SH_LIST_DCN3_1_4(__SHIFT)
+	CS_COMMON_MASK_SH_LIST_DCN4_0_1(__SHIFT)
 };
 static const struct dce110_clk_src_mask cs_mask = {
-	CS_COMMON_MASK_SH_LIST_DCN3_1_4(_MASK)
+	CS_COMMON_MASK_SH_LIST_DCN4_0_1(_MASK)
 };
 #define abm_regs_init(id) \
 	ABM_DCN42_REG_LIST_RI(id)
@@ -874,8 +874,7 @@ static struct clock_source *dcn42_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn401_clk_src_construct(clk_src, ctx, bios, id,
-								 regs, &cs_shift, &cs_mask)) {
+	if (dcn401_clk_src_construct(clk_src, ctx, bios, id, regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
index fe960542d7bd..3e4d9b188b26 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
@@ -550,7 +550,8 @@
 		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 0, index),             \
 		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 1, index),             \
 		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 2, index),             \
-		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 3, index)
+		SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 3, index),             \
+		SR_ARR(OTG_PIXEL_RATE_DIV, index)
 
 /* ABM */
 #define ABM_DCN42_REG_LIST_RI(id)                               \
-- 
2.43.0

