Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6F6D6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F0410F0A9;
	Thu,  2 Apr 2026 18:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3DYLa6bI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632E310F01C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLPFGTizg8d3mtdKHBm2Bp13t2+IDtjzuLEQqolMkdV0xOoTXxvj2eU7RrrNvoa/Hc6WAkPIpZdaVK3GB9qeVdxBW4yGddOTGCmKV9o7R5nDqSXgJd8iZFLbdurvI/UaYDRbm/j2XYWP02vTaQ6NzpFm8Z2xwapOG9EDbe9hv1CTlVcYNEl5U2btU/bibKl0/WFvq/KqOvq4n6LN4eK00NFW+eMhQMHgJegHQkWvndprw+CSf1/eVpKpGh/ctMNUOS6q6A+fcX37WC0Q1R6jmZ7fakuhm3V0r/3j8EHnC48z8b9zQhmNVi0FE5Z8l8hX0nXN7ah5WpV7WslhqSUu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukJtE+zfVtyi+asU3GCY+XGZ/vIzrAT1E/VHCMtZU/E=;
 b=WqsamOjOtCTbrCxjuTk+l2kTeYkFfGuVqeC+WXvyUXYGrHHC09T2uIwTsCCAfC6QE9s7yO1EnOE4w3wH7BAYeroVPxQoaWesRmJ2UNuzRALb5CjW26X819qFRNPnfII2uzoa0oXHrJWrX0dHwPtRuyIZuJA7IzeoiaHfgs/rGhPG1hq7FkiRacM0Vlchxd9WdZVUg0t+mBUffOv0k66Mbk0+6QvdnW8Bs7GmAM3gXZ/4hlunbfZT7vx6/FYotX4YfnwuYHDRH8g1SzbJhf6VsY7aiIdhjNDEeveqTS53djVFvIHvsYmluiNy/OdHVcHJTb7s1xWWoQkdY2CtDwXI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukJtE+zfVtyi+asU3GCY+XGZ/vIzrAT1E/VHCMtZU/E=;
 b=3DYLa6bI9jZlMj4HqCWr6NX8EOAoMWNPoLe6vvlTsKsbWMKdmHJH1W8QSNzUpaXvXpJMa94/UbAzLFyjDThVn9GOc+z8a/zdjd8IkrPfW3ei+LphCAUvIvdr4EyWzNfZtbBZXcMnEOFeSnSrJxg5pSgxiuG823fE/OIDMnEyJv8=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:33:29 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::1a) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 18:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:33:28 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:27 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Gaghik
 Khachatrian" <gaghik.khachatrian@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Clayton King <clayton.king@amd.com>
Subject: [PATCH 01/22] drm/amd/display: Fix unused parameters warnings in
 dml2_0
Date: Thu, 2 Apr 2026 14:32:53 -0400
Message-ID: <20260402183314.1388755-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d014f18-26c0-4ed1-e602-08de90e655fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eaKK9gJWHxAgN1NC+2OHxYhEdRyvRWZfhLU0l27NIu73akRk/cBpM1XuyZYXHf36Uvprrbk6qOuHahLTXZfbDrW6CRVduO2UfgqsXv71Mg3iWyvfNP/Fjq2NIwqHHlIzOqaJTigS3nygYVEG23DeLGDrcsK6ggnmHfyIW8M0kEUW5d1GC3bC1b3jJxGnj8jih6YAhdEogMYrTRXIQj7o1vKze/CajF2jZAXvBoJEkTHT6TK19ollrbSU6HpAlW8sI6+CAkK1wijCdikEYJxYfzKf9FfWTa5/R2hi9GTBOwjbmOPJIovdJCF40cgzjPno1+25Cnt4gPhmb01Ay5uB+LhgIOdIRI+2ixJPdZGHcdAdltGCrjkJMyw/kqaXFxAt/qCBQXAKqt2uumWAuCf99049KQNt+IqTree9n1n76eqzxwsHZ/VG4J/tBHpZycErpJ6NKgr4OlBl5D1XNGaC9utTwYYcAVH6yUPG+FdFWV5sqLK9ODzxBu/cLeRsghr+PxTsJglRLQISsnviDdW2K+8SyrsZXCNFVtEYoVWoAVM1KdiKBmZ518vSN/snoK+U3mcdIm9ucyIOd7V5I3883e4r0oqgcE6OguCVYbfs/Y4szBht5G59MQCJ0ohYxjtvGdoUMsZvFWS5cnNYjji2rfRVNZyu4AQznJiGini5GfBG0D+kWtXJz1CCTbeLHLuQ0Neh8d06w9dQQMSP9aAVQvj8b3WB09vBSDP04agtaH2Xgt9ReEED7G40iLHPgvzmeUSFJm5Kvf5MJrDRwgOd7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RHQ7bVeh+gfEEN2PyrUPP7j7v3DLsl8JAkf+IERJ9e/pEhYgKzgCGajGMWwFPLVtJ+pKjd76283j8s21EqtpM6ptzFTawrQY3hftZlfqOlTOwiBdtMtm/13pYq9bJrm2YfOdKnAuhijQIkzEltJ/dvMaKTwHtICQCB8ol+wHxhGmA0+kKcgSY/Pvpx8H1+giDP+2CWueeHaAVQ0L4SYpdHycFADMQWVy89hPxKvRD/0gsi6wLeBVXiCeaAdLf/Q1x3XbvAjcHyRe9PDu086mUeOjnqKjDp8NKtpxjGv+lbzBev4Hr4q4QAg7FwuunK3JF3IgXfn2EWl6nJPSKP0mWwwqkLox/sVCIJbGafdSseA43rcYXebmKirZ2b+8ppFwQDiUSYQEq0dq0BMg+bsPTYTPK+HAYIB/aW2goM68s74MdtVoYjndAjut+/UVFv0z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:29.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d014f18-26c0-4ed1-e602-08de90e655fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why] Resolve warnings by marking unused parameters explicitly.

[How] Keep parameter names in signatures and add a line with
     '(void)param;'  inside the function body

Preserved function signatures and avoids breaking code paths that
may reference the parameter under conditional compilation.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Clayton King <clayton.king@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/dml2_0/display_mode_core.c | 17 ++++++++++++++
 .../amd/display/dc/dml2_0/display_mode_util.c | 14 +++++++++++
 .../dml2_0/dml21/dml21_translation_helper.c   |  3 +++
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |  2 ++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |  2 ++
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 23 +++++++++++++++++++
 .../dml21/src/dml2_core/dml2_core_utils.c     |  1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |  2 ++
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |  1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  5 ++++
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |  3 +++
 .../dml21/src/dml2_top/dml2_top_soc15.c       |  2 ++
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |  9 ++++++++
 .../dc/dml2_0/dml2_translation_helper.c       |  6 +++++
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |  1 +
 .../dc/dml2_0/dml_display_rq_dlg_calc.c       |  1 +
 18 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
index 8e8935995fca..698d62fb9cf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core.c
@@ -1812,6 +1812,8 @@ static dml_float_t CalculateWriteBackDISPCLK(
 		dml_uint_t WritebackLineBufferSize,
 		dml_float_t DISPCLKDPPCLKVCOSpeed)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	dml_float_t DISPCLK_H, DISPCLK_V, DISPCLK_HB;
 
 	DISPCLK_H = PixelClock * dml_ceil(WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -1830,6 +1832,8 @@ static dml_float_t CalculateWriteBackDelay(
 		dml_uint_t WritebackSourceHeight,
 		dml_uint_t HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	dml_float_t CalculateWriteBackDelay;
 	dml_float_t Line_length;
 	dml_float_t Output_lines_last_notclamped;
@@ -1977,6 +1981,7 @@ static void CalculateFlipSchedule(
 		dml_float_t *final_flip_bw,
 		dml_bool_t *ImmediateFlipSupportedForPipe)
 {
+	(void)HostVMMinPageSize;
 	dml_float_t min_row_time = 0.0;
 	dml_uint_t HostVMDynamicLevelsTrips = 0;
 	dml_float_t TimeForFetchingMetaPTEImmediateFlip = 0;
@@ -2118,6 +2123,11 @@ static void CalculateDCCConfiguration(
 		dml_uint_t *IndependentBlockLuma,
 		dml_uint_t *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)TilingFormat;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	dml_uint_t DETBufferSizeForDCC = nomDETInKByte * 1024;
 
 	dml_uint_t yuv420;
@@ -2489,6 +2499,7 @@ static dml_uint_t CalculateVMAndRowBytes(
 		dml_uint_t *DPDE0BytesFrame,
 		dml_uint_t *MetaPTEBytesFrame)
 {
+	(void)SourcePixelFormat;
 	dml_uint_t MPDEBytesFrame;
 	dml_uint_t DCCMetaSurfaceBytes;
 	dml_uint_t ExtraDPDEBytesFrame;
@@ -3662,6 +3673,8 @@ static void CalculateVMGroupAndRequestTimes(
 		dml_float_t TimePerVMRequestVBlank[],
 		dml_float_t TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	dml_uint_t num_group_per_lower_vm_stage;
 	dml_uint_t num_req_per_lower_vm_stage;
 
@@ -3762,6 +3775,7 @@ static void CalculateVMGroupAndRequestTimes(
 static void CalculateStutterEfficiency(struct display_mode_lib_scratch_st *scratch,
 		struct CalculateStutterEfficiency_params_st *p)
 {
+	(void)scratch;
 	dml_float_t DETBufferingTimeY = 0;
 	dml_float_t SwathWidthYCriticalSurface = 0;
 	dml_float_t SwathHeightYCriticalSurface = 0;
@@ -4085,6 +4099,7 @@ static void CalculateStutterEfficiency(struct display_mode_lib_scratch_st *scrat
 static void CalculateSwathAndDETConfiguration(struct display_mode_lib_scratch_st *scratch,
 	struct CalculateSwathAndDETConfiguration_params_st *p)
 {
+	(void)scratch;
 	dml_uint_t MaximumSwathHeightY[__DML_NUM_PLANES__];
 	dml_uint_t MaximumSwathHeightC[__DML_NUM_PLANES__];
 	dml_uint_t RoundedUpMaxSwathSizeBytesY[__DML_NUM_PLANES__];
@@ -4331,6 +4346,7 @@ static void CalculateSwathWidth(
 		dml_uint_t swath_width_luma_ub[], // per-pipe
 		dml_uint_t swath_width_chroma_ub[]) // per-pipe
 {
+	(void)BytePerPixY;
 	enum dml_odm_mode   MainSurfaceODMMode;
 	dml_uint_t surface_width_ub_l;
 	dml_uint_t surface_height_ub_l;
@@ -5029,6 +5045,7 @@ static void CalculateMaxDETAndMinCompressedBufferSize(
 		dml_uint_t *nomDETInKByte,
 		dml_uint_t *MinCompressedBufferSizeInKByte)
 {
+	(void)ROBBufferSizeInKByte;
 	*MaxTotalDETInKByte = ConfigReturnBufferSizeInKByte - ConfigReturnBufferSegmentSizeInKByte;
 	*nomDETInKByte = (dml_uint_t)(dml_floor((dml_float_t) *MaxTotalDETInKByte / (dml_float_t) MaxNumDPP, ConfigReturnBufferSegmentSizeInKByte));
 	*MinCompressedBufferSizeInKByte = ConfigReturnBufferSizeInKByte - *MaxTotalDETInKByte;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
index 4022f91193ed..b2fada6c44c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
@@ -178,6 +178,7 @@ dml_float_t dml_log2(dml_float_t x)
 
 dml_float_t dml_round(dml_float_t val, dml_bool_t bankers_rounding)
 {
+	(void)bankers_rounding;
 //	if (bankers_rounding)
 //			return (dml_float_t) lrint(val);
 //	else {
@@ -217,6 +218,7 @@ dml_uint_t dml_round_to_multiple(dml_uint_t num, dml_uint_t multiple, dml_bool_t
 
 void dml_print_data_rq_regs_st(const dml_display_plane_rq_regs_st *rq_regs)
 {
+	(void)rq_regs;
 	dml_print("DML: ===================================== \n");
 	dml_print("DML: DISPLAY_PLANE_RQ_REGS_ST\n");
 	dml_print("DML: chunk_size = 0x%x\n", rq_regs->chunk_size);
@@ -248,6 +250,7 @@ void dml_print_rq_regs_st(const dml_display_rq_regs_st *rq_regs)
 
 void dml_print_dlg_regs_st(const dml_display_dlg_regs_st *dlg_regs)
 {
+	(void)dlg_regs;
 	dml_print("DML: ===================================== \n");
 	dml_print("DML: DISPLAY_DLG_REGS_ST \n");
 	dml_print("DML: refcyc_h_blank_end = 0x%x\n", dlg_regs->refcyc_h_blank_end);
@@ -299,6 +302,7 @@ void dml_print_dlg_regs_st(const dml_display_dlg_regs_st *dlg_regs)
 
 void dml_print_ttu_regs_st(const dml_display_ttu_regs_st *ttu_regs)
 {
+	(void)ttu_regs;
 	dml_print("DML: ===================================== \n");
 	dml_print("DML: DISPLAY_TTU_REGS_ST \n");
 	dml_print("DML: qos_level_low_wm = 0x%x\n", ttu_regs->qos_level_low_wm);
@@ -326,6 +330,7 @@ void dml_print_ttu_regs_st(const dml_display_ttu_regs_st *ttu_regs)
 
 void dml_print_dml_policy(const struct dml_mode_eval_policy_st *policy)
 {
+	(void)policy;
 	dml_print("DML: ===================================== \n");
 	dml_print("DML: DML_MODE_EVAL_POLICY_ST\n");
 	dml_print("DML: Policy: UseUnboundedRequesting = 0x%x\n", policy->UseUnboundedRequesting);
@@ -353,6 +358,8 @@ void dml_print_dml_policy(const struct dml_mode_eval_policy_st *policy)
 
 void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
 {
+	(void)j;
+	(void)mode_lib;
 	dml_print("DML: MODE SUPPORT: ===============================================\n");
 	dml_print("DML: MODE SUPPORT: Voltage State %d\n", j);
 	dml_print("DML: MODE SUPPORT:     Mode Supported              : %s\n", mode_lib->ms.support.ModeSupport[j] == true ? "Supported" : "NOT Supported");
@@ -526,6 +533,7 @@ void dml_print_dml_mode_support_info(const struct dml_mode_support_info_st *supp
 
 void dml_print_dml_display_cfg_timing(const struct dml_timing_cfg_st *timing, dml_uint_t num_plane)
 {
+	(void)timing;
 	for (dml_uint_t i = 0; i < num_plane; i++) {
 		dml_print("DML: timing_cfg: plane=%d, HTotal = %d\n", i, timing->HTotal[i]);
 		dml_print("DML: timing_cfg: plane=%d, VTotal = %d\n", i, timing->VTotal[i]);
@@ -542,6 +550,7 @@ void dml_print_dml_display_cfg_timing(const struct dml_timing_cfg_st *timing, dm
 
 void dml_print_dml_display_cfg_plane(const struct dml_plane_cfg_st *plane, dml_uint_t num_plane)
 {
+	(void)plane;
 	dml_print("DML: plane_cfg: num_plane = %d\n", num_plane);
 	dml_print("DML: plane_cfg: GPUVMEnable = %d\n", plane->GPUVMEnable);
 	dml_print("DML: plane_cfg: HostVMEnable = %d\n", plane->HostVMEnable);
@@ -590,6 +599,7 @@ void dml_print_dml_display_cfg_plane(const struct dml_plane_cfg_st *plane, dml_u
 
 void dml_print_dml_display_cfg_surface(const struct dml_surface_cfg_st *surface, dml_uint_t num_plane)
 {
+	(void)surface;
 	for (dml_uint_t i = 0; i < num_plane; i++) {
 		dml_print("DML: surface_cfg: plane=%d, PitchY = %d\n", i, surface->PitchY[i]);
 		dml_print("DML: surface_cfg: plane=%d, SurfaceWidthY = %d\n", i, surface->SurfaceWidthY[i]);
@@ -609,6 +619,7 @@ void dml_print_dml_display_cfg_surface(const struct dml_surface_cfg_st *surface,
 
 void dml_print_dml_display_cfg_hw_resource(const struct dml_hw_resource_st *hw, dml_uint_t num_plane)
 {
+	(void)hw;
 	for (dml_uint_t i = 0; i < num_plane; i++) {
 		dml_print("DML: hw_resource: plane=%d, ODMMode = %d\n", i, hw->ODMMode[i]);
 		dml_print("DML: hw_resource: plane=%d, DPPPerSurface = %d\n", i, hw->DPPPerSurface[i]);
@@ -620,6 +631,7 @@ void dml_print_dml_display_cfg_hw_resource(const struct dml_hw_resource_st *hw,
 
 __DML_DLL_EXPORT__ void dml_print_soc_state_bounding_box(const struct soc_state_bounding_box_st *state)
 {
+	(void)state;
 	dml_print("DML: state_bbox: socclk_mhz = %f\n", state->socclk_mhz);
 	dml_print("DML: state_bbox: dscclk_mhz = %f\n", state->dscclk_mhz);
 	dml_print("DML: state_bbox: phyclk_mhz = %f\n", state->phyclk_mhz);
@@ -649,6 +661,7 @@ __DML_DLL_EXPORT__ void dml_print_soc_state_bounding_box(const struct soc_state_
 
 __DML_DLL_EXPORT__ void dml_print_soc_bounding_box(const struct soc_bounding_box_st *soc)
 {
+	(void)soc;
 	dml_print("DML: soc_bbox: dprefclk_mhz = %f\n", soc->dprefclk_mhz);
 	dml_print("DML: soc_bbox: xtalclk_mhz = %f\n", soc->xtalclk_mhz);
 	dml_print("DML: soc_bbox: pcierefclk_mhz = %f\n", soc->pcierefclk_mhz);
@@ -686,6 +699,7 @@ __DML_DLL_EXPORT__ void dml_print_soc_bounding_box(const struct soc_bounding_box
 
 __DML_DLL_EXPORT__ void dml_print_clk_cfg(const struct dml_clk_cfg_st *clk_cfg)
 {
+	(void)clk_cfg;
 	dml_print("DML: clk_cfg: 0-use_required, 1-use pipe.clks_cfg, 2-use state bbox\n");
 	dml_print("DML: clk_cfg: dcfclk_option = %d\n", clk_cfg->dcfclk_option);
 	dml_print("DML: clk_cfg: dispclk_option = %d\n", clk_cfg->dispclk_option);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 2f0e0048bea8..5d7b6c399470 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -441,6 +441,7 @@ static void populate_dml21_surface_config_from_plane_state(
 		struct dml2_surface_cfg *surface,
 		const struct dc_plane_state *plane_state)
 {
+	(void)in_dc;
 	surface->plane0.pitch = plane_state->plane_size.surface_pitch;
 	surface->plane1.pitch = plane_state->plane_size.chroma_pitch;
 	surface->plane0.height = plane_state->plane_size.surface_size.height;
@@ -873,6 +874,7 @@ static struct dml2_dchub_watermark_regs *wm_set_index_to_dc_wm_set(union dcn_wat
 
 void dml21_extract_watermark_sets(const struct dc *in_dc, union dcn_watermark_set *watermarks, struct dml2_context *in_ctx)
 {
+	(void)in_dc;
 	const struct dml2_display_cfg_programming *programming = in_ctx->v21.mode_programming.programming;
 
 	unsigned int wm_index;
@@ -907,6 +909,7 @@ void dml21_get_pipe_mcache_config(
 	struct dml2_per_plane_programming *pln_prog,
 	struct dml2_pipe_configuration_descriptor *mcache_pipe_config)
 {
+	(void)context;
 	mcache_pipe_config->plane0.viewport_x_start = pipe_ctx->plane_res.scl_data.viewport.x;
 	mcache_pipe_config->plane0.viewport_width = pipe_ctx->plane_res.scl_data.viewport.width;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 4724b08c77e1..732de97335fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -88,6 +88,7 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 		struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__],
 		int dml_plane_idx)
 {
+	(void)in_dc;
 	unsigned int dml_stream_index;
 	unsigned int main_stream_id;
 	unsigned int dc_plane_index;
@@ -282,6 +283,7 @@ static struct dc_plane_state *dml21_add_phantom_plane(struct dml2_context *dml_c
 	struct dc_plane_state *main_plane,
 	struct dml2_per_plane_programming *plane_programming)
 {
+	(void)plane_programming;
 	struct dc_plane_state *phantom_plane;
 
 	phantom_plane = dml_ctx->config.svp_pstate.callbacks.create_phantom_plane(dc, context, main_plane);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index cc992af6ac9c..de40d7bae252 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -51,6 +51,8 @@ void dml21_reinit(const struct dc *in_dc, struct dml2_context *dml_ctx, const st
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
 	struct dml2_context *in_ctx, unsigned int pipe_cnt)
 {
+	(void)out_new_hw_state;
+	(void)pipe_cnt;
 	unsigned int dml_prog_idx = 0, dc_pipe_index = 0, num_dpps_required = 0;
 	struct dml2_per_plane_programming *pln_prog = NULL;
 	struct dml2_per_stream_programming *stream_prog = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 99fc2f0666e2..fda01b0800d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -281,6 +281,7 @@ static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters
 static void create_phantom_plane_from_main_plane(struct dml2_plane_parameters *phantom, const struct dml2_plane_parameters *main,
 	const struct dml2_stream_parameters *phantom_stream, int phantom_stream_index, const struct dml2_stream_parameters *main_stream)
 {
+	(void)main_stream;
 	memcpy(phantom, main, sizeof(struct dml2_plane_parameters));
 
 	phantom->stream_index = phantom_stream_index;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index f6402e199354..80813159bffd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -840,6 +840,7 @@ static void CalculateSwathWidth(
 	unsigned int swath_width_luma_ub[], // per-pipe
 	unsigned int swath_width_chroma_ub[]) // per-pipe
 {
+	(void)BytePerPixY;
 	enum dml2_odm_mode MainSurfaceODMMode;
 	double odm_hactive_factor = 1.0;
 	unsigned int req_width_horz_y;
@@ -1283,6 +1284,8 @@ static double TruncToValidBPP(
 	// Output
 	unsigned int *RequiredSlots)
 {
+	(void)DSCInputBitPerComponent;
+	(void)RequiredSlots;
 	double MaxLinkBPP;
 	unsigned int MinDSCBPP;
 	double MaxDSCBPP;
@@ -1922,6 +1925,7 @@ static void CalculateRowBandwidth(
 	double *dpte_row_bw,
 	double *meta_row_bw)
 {
+	(void)use_one_row_for_frame;
 	if (!DCCEnable || !mrq_present) {
 		*meta_row_bw = 0;
 	} else if (dml_is_420(SourcePixelFormat) || SourcePixelFormat == dml2_rgbe_alpha) {
@@ -2020,6 +2024,11 @@ static void CalculateDCCConfiguration(
 	unsigned int *IndependentBlockLuma,
 	unsigned int *IndependentBlockChroma)
 {
+	(void)SurfaceWidthChroma;
+	(void)SurfaceHeightChroma;
+	(void)TilingFormat;
+	(void)BytePerPixelDETY;
+	(void)BytePerPixelDETC;
 	unsigned int DETBufferSizeForDCC = nomDETInKByte * 1024;
 
 	unsigned int segment_order_horz_contiguous_luma;
@@ -2270,6 +2279,7 @@ static void calculate_mcache_row_bytes(
 	struct dml2_core_internal_scratch *scratch,
 	struct dml2_core_calcs_calculate_mcache_row_bytes_params *p)
 {
+	(void)scratch;
 	unsigned int vmpg_bytes = 0;
 	unsigned int blk_bytes = 0;
 	float meta_per_mvmpg_per_channel = 0;
@@ -3642,6 +3652,8 @@ static double CalculateWriteBackDelay(
 	unsigned int WritebackSourceHeight,
 	unsigned int HTotal)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackHRatio;
 	double CalculateWriteBackDelay;
 	double Line_length;
 	double Output_lines_last_notclamped;
@@ -3959,6 +3971,7 @@ static enum dml2_odm_mode DecideODMMode(unsigned int HActive,
 	double SurfaceRequiredDISPCLKWithODMCombineThreeToOne,
 	double SurfaceRequiredDISPCLKWithODMCombineFourToOne)
 {
+	(void)SurfaceRequiredDISPCLKWithODMCombineFourToOne;
 	enum dml2_odm_mode MinimumRequiredODMModeForMaxDispClock;
 	enum dml2_odm_mode MinimumRequiredODMModeForMaxDSCHActive;
 	enum dml2_odm_mode MinimumRequiredODMModeForMax420HActive;
@@ -4460,6 +4473,8 @@ static double CalculateWriteBackDISPCLK(
 	unsigned int HTotal,
 	unsigned int WritebackLineBufferSize)
 {
+	(void)WritebackPixelFormat;
+	(void)WritebackVRatio;
 	double DISPCLK_H, DISPCLK_V, DISPCLK_HB;
 
 	DISPCLK_H = PixelClock * math_ceil2((double)WritebackHTaps / 8.0, 1) / WritebackHRatio;
@@ -4561,6 +4576,10 @@ static void CalculateSurfaceSizeInMall(
 	unsigned int SurfaceSizeInMALL[],
 	bool *ExceededMALLSize)
 {
+	(void)Read256BytesBlockWidthY;
+	(void)Read256BytesBlockWidthC;
+	(void)Read256BytesBlockHeightY;
+	(void)Read256BytesBlockHeightC;
 	unsigned int TotalSurfaceSizeInMALLForSS = 0;
 	unsigned int TotalSurfaceSizeInMALLForSubVP = 0;
 	unsigned int MALLAllocatedForDCNInBytes = MALLAllocatedForDCN * 1024 * 1024;
@@ -4620,6 +4639,7 @@ static void calculate_tdlut_setting(
 		struct dml2_core_internal_scratch *scratch,
 		struct dml2_core_calcs_calculate_tdlut_setting_params *p)
 {
+	(void)scratch;
 	// locals
 	unsigned int tdlut_bpe = 8;
 	unsigned int tdlut_width;
@@ -6503,6 +6523,7 @@ static void CalculateFlipSchedule(
 	double *final_flip_bw,
 	bool *ImmediateFlipSupportedForPipe)
 {
+	(void)use_one_row_for_frame_flip;
 	struct dml2_core_shared_CalculateFlipSchedule_locals *l = &s->CalculateFlipSchedule_locals;
 
 	l->dual_plane = dml_is_420(SourcePixelFormat) || SourcePixelFormat == dml2_rgbe_alpha;
@@ -9968,6 +9989,8 @@ static void CalculateVMGroupAndRequestTimes(
 	double TimePerVMRequestVBlank[],
 	double TimePerVMRequestFlip[])
 {
+	(void)dpte_row_width_luma_ub;
+	(void)dpte_row_width_chroma_ub;
 	unsigned int num_group_per_lower_vm_stage = 0;
 	unsigned int num_req_per_lower_vm_stage = 0;
 	unsigned int num_group_per_lower_vm_stage_flip;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index 6930ba7ce5b7..cd9bf190cb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -648,6 +648,7 @@ static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters
 static void create_phantom_plane_from_main_plane(struct dml2_plane_parameters *phantom, const struct dml2_plane_parameters *main,
 	const struct dml2_stream_parameters *phantom_stream, int phantom_stream_index, const struct dml2_stream_parameters *main_stream)
 {
+	(void)main_stream;
 	memcpy(phantom, main, sizeof(struct dml2_plane_parameters));
 
 	phantom->stream_index = phantom_stream_index;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index ab0b4a4b5d65..5ffe211a6643 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -552,6 +552,7 @@ static int get_displays_without_vactive_margin_mask(struct dml2_dpmm_map_mode_to
 
 static int get_displays_with_fams_mask(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out, int latency_hiding_requirement_us)
 {
+	(void)latency_hiding_requirement_us;
 	unsigned int i;
 	int displays_with_fams_mask = 0x0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index 1f2d9e97f5fd..39965ff2e111 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -8,11 +8,13 @@
 
 static bool dummy_map_mode_to_soc_dpm(struct dml2_dpmm_map_mode_to_soc_dpm_params_in_out *in_out)
 {
+	(void)in_out;
 	return true;
 }
 
 static bool dummy_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
 {
+	(void)in_out;
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
index 3dcd2c250633..fb0b0ac547c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -9,6 +9,7 @@
 
 static bool dummy_build_min_clock_table(struct dml2_mcg_build_min_clock_table_params_in_out *in_out)
 {
+	(void)in_out;
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index e8691983c0eb..f7c10dbfc154 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -428,6 +428,7 @@ static void insert_strategy_into_expanded_list(
 	struct dml2_pmo_pstate_strategy *expanded_strategy_list,
 	unsigned int *num_expanded_strategies)
 {
+	(void)stream_count;
 	if (expanded_strategy_list && num_expanded_strategies) {
 		memcpy(&expanded_strategy_list[*num_expanded_strategies], per_stream_pstate_strategy, sizeof(struct dml2_pmo_pstate_strategy));
 
@@ -520,6 +521,7 @@ static bool is_variant_method_valid(const struct dml2_pmo_pstate_strategy *base_
 		const unsigned int num_streams_per_variant_method[PMO_DCN4_MAX_DISPLAYS],
 		const unsigned int stream_count)
 {
+	(void)variant_strategy;
 	bool valid = true;
 	unsigned int i;
 
@@ -1180,6 +1182,7 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 
 static void insert_into_candidate_list(const struct dml2_pmo_pstate_strategy *pstate_strategy, int stream_count, struct dml2_pmo_scratch *scratch)
 {
+	(void)stream_count;
 	scratch->pmo_dcn4.pstate_strategy_candidates[scratch->pmo_dcn4.num_pstate_candidates] = *pstate_strategy;
 	scratch->pmo_dcn4.num_pstate_candidates++;
 }
@@ -1847,6 +1850,7 @@ static void build_subvp_meta_per_stream(struct dml2_pmo_instance *pmo,
 	struct display_configuation_with_meta *display_config,
 	int stream_index)
 {
+	(void)display_config;
 	struct dml2_implicit_svp_meta *stream_svp_meta = &pmo->scratch.pmo_dcn4.stream_svp_meta[stream_index];
 	struct dml2_pstate_meta *stream_pstate_meta = &pmo->scratch.pmo_dcn4.stream_pstate_meta[stream_index];
 
@@ -1990,6 +1994,7 @@ static void setup_planes_for_drr_by_mask(struct display_configuation_with_meta *
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
 {
+	(void)pmo;
 	unsigned int plane_index;
 	struct dml2_plane_parameters *plane;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index 4d687fa86caa..83802aac11cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -9,16 +9,19 @@
 
 static bool dummy_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in_out)
 {
+	(void)in_out;
 	return false;
 }
 
 static bool dummy_test_for_stutter(struct dml2_pmo_test_for_stutter_in_out *in_out)
 {
+	(void)in_out;
 	return true;
 }
 
 static bool dummy_optimize_for_stutter(struct dml2_pmo_optimize_for_stutter_in_out *in_out)
 {
+	(void)in_out;
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
index 4a7c4c62111e..fa20a91c6e16 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c
@@ -17,6 +17,7 @@ static void setup_unoptimized_display_config_with_meta(const struct dml2_instanc
 
 static void setup_speculative_display_config_with_meta(const struct dml2_instance *dml, struct display_configuation_with_meta *out, const struct dml2_display_cfg *display_config)
 {
+	(void)dml;
 	memcpy(&out->display_config, display_config, sizeof(struct dml2_display_cfg));
 	out->stage1.min_clk_index_for_latency = 0;
 }
@@ -472,6 +473,7 @@ static unsigned int count_elements_in_span(int *array, unsigned int array_size,
 static bool calculate_h_split_for_scaling_transform(int full_vp_width, int h_active, int num_pipes,
 	enum dml2_scaling_transform scaling_transform, int *pipe_vp_x_start, int *pipe_vp_x_end)
 {
+	(void)h_active;
 	int i, slice_width;
 	const char MAX_SCL_VP_OVERLAP = 3;
 	bool success = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
index 6ef93c6fc1cd..6b78334c2554 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
@@ -178,6 +178,10 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 
 static bool validate_pipe_assignment(const struct dml2_context *ctx, const struct dc_state *state, const struct dml_display_cfg_st *disp_cfg, const struct dml2_dml_to_dc_pipe_mapping *mapping)
 {
+	(void)ctx;
+	(void)disp_cfg;
+	(void)mapping;
+	(void)state;
 //	int i, j, k;
 //
 //	unsigned int plane_id;
@@ -292,6 +296,7 @@ static unsigned int find_last_resort_pipe_candidates(const struct dc_state *exis
 	const unsigned int stream_id,
 	unsigned int *last_resort_pipe_candidates)
 {
+	(void)stream_id;
 	unsigned int num_last_resort_candidates = 0;
 	int i;
 
@@ -541,6 +546,7 @@ static void add_odm_slice_to_odm_tree(struct dml2_context *ctx,
 		struct dc_pipe_mapping_scratch *scratch,
 		unsigned int odm_slice_index)
 {
+	(void)ctx;
 	struct pipe_ctx *pipe = NULL;
 	int i;
 
@@ -567,6 +573,8 @@ static struct pipe_ctx *add_plane_to_blend_tree(struct dml2_context *ctx,
 	unsigned int odm_slice,
 	struct pipe_ctx *top_pipe)
 {
+	(void)ctx;
+	(void)plane;
 	int i;
 
 	for (i = 0; i < pipe_pool->num_pipes_assigned_to_plane_for_mpcc_combine; i++) {
@@ -722,6 +730,7 @@ static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_stat
 
 static void remove_pipes_from_blend_trees(struct dml2_context *ctx, struct dc_state *state, struct dc_plane_pipe_pool *pipe_pool, unsigned int odm_slice)
 {
+	(void)ctx;
 	struct pipe_ctx *pipe;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index cf3a69aba638..8e0997441ee0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -33,6 +33,7 @@
 
 void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, struct ip_params_st *out)
 {
+	(void)in_dc;
 	switch (dml2->v20.dml_core_ctx.project) {
 	case dml_project_dcn32:
 	case dml_project_dcn321:
@@ -244,6 +245,7 @@ void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, stru
 
 void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, struct soc_bounding_box_st *out)
 {
+	(void)in_dc;
 	out->dprefclk_mhz = dml2->config.bbox_overrides.dprefclk_mhz;
 	out->xtalclk_mhz = dml2->config.bbox_overrides.xtalclk_mhz;
 	out->pcierefclk_mhz = 100;
@@ -328,6 +330,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	const struct soc_bounding_box_st *in_bbox, struct soc_states_st *out)
 {
+	(void)in_dc;
 	struct dml2_policy_build_synthetic_soc_states_scratch *s = &dml2->v20.scratch.create_scratch.build_synthetic_socbb_scratch;
 	struct dml2_policy_build_synthetic_soc_states_params *p = &dml2->v20.scratch.build_synthetic_socbb_params;
 	int dcfclk_stas_mhz[NUM_DCFCLK_STAS] = {0};
@@ -782,6 +785,7 @@ static void populate_dml_timing_cfg_from_stream_state(struct dml_timing_cfg_st *
 static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *out, unsigned int location,
 				const struct dc_stream_state *in, const struct pipe_ctx *pipe, struct dml2_context *dml2)
 {
+	(void)pipe;
 	unsigned int output_bpc;
 
 	out->DSCEnable[location] = (enum dml_dsc_enable)in->timing.flags.DSC;
@@ -1133,6 +1137,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml2,
 		const struct dc_stream_state *stream, const struct dml_display_cfg_st *dml_dispcfg)
 {
+	(void)dml_dispcfg;
 	int i = 0;
 	int location = -1;
 
@@ -1173,6 +1178,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *conte
 static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2, const struct dc_plane_state *plane,
 		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id, int plane_index)
 {
+	(void)dml_dispcfg;
 	unsigned int plane_id;
 	unsigned int i = 0;
 	unsigned int location = UINT_MAX;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
index 6c7cdf102906..86567e232415 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c
@@ -465,6 +465,7 @@ void dml2_initialize_det_scratch(struct dml2_context *in_ctx)
 
 static unsigned int find_planes_per_stream_and_stream_count(struct dml2_context *in_ctx, struct dml_display_cfg_st *dml_dispcfg, int *num_of_planes_per_stream)
 {
+	(void)in_ctx;
 	unsigned int plane_index, stream_index = 0, num_of_streams;
 
 	for (plane_index = 0; plane_index < dml_dispcfg->num_surfaces; plane_index++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_display_rq_dlg_calc.c
index 00d22e542469..18962bbf455b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml_display_rq_dlg_calc.c
@@ -563,6 +563,7 @@ void dml_rq_dlg_get_dlg_reg(dml_display_dlg_regs_st		   *disp_dlg_regs,
 
 void dml_rq_dlg_get_arb_params(struct display_mode_lib_st *mode_lib, dml_display_arb_params_st *arb_param)
 {
+	(void)mode_lib;
 	memset(arb_param, 0, sizeof(*arb_param));
 	arb_param->max_req_outstanding = 256;
 	arb_param->min_req_outstanding = 256; // turn off the sat level feature if this set to max
-- 
2.34.1

