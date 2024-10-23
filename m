Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27432D2E014
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7CB10E72D;
	Wed, 23 Oct 2024 04:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EuqU96S3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDB410E721
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puy6yjZL3AjCMTxYz1pVjkpv7WFMqnCt61V2FIgpB3qrMFoeqYY1xTmhpmYfzhqMaEVybZYh7mraZHgEfQcMQnQoTedSesJdI54OgwoEbKFeP2utB60aXTOvJGLh0ZZMqmxtZI5aRnKGeacWYXBfLV+Ax90svKt5wJGzg9KEG52MuArD73iR/gU5+Yvik/e6pJxLdVOpz9WKib4BE0Llu5jzDDlJ3yDSL6yEF/IX2sz5WclTfEZvm9Yl2KQslMhjax/S9QNseAVmpu/Yt3SOYPugHFabQTqHEoOhJa9FpinnZ27XvlGlDDVut59Hnkem5HB4942KBVUue06osIBrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrRWKil7s/IXzeP784tz+Ft2MkIoy2rJZHakhaYvKs0=;
 b=nGVMTaWBWCnNfY5FlxULJd/qIST0T930/tVmiAMLHJwwNno07Ru0THIvoKi4a+5uDAJwhKl3U5mK/CcBKQyzvHzK00ddl5D/VN+4cenf+8cDltsVYeYnsvpfsh8AIXmdLzI514Tgz6H1J+ZJ/cL3cUFNaZywUyxCdz5UjgXm62JlufChrRAA3Ws9WBnokSvugBV2NV3GjdPvLqdhuCAPKaUdddxS7nJlD2qNVoFWUuBy1JFYtow3LYUyZWsPQl7Bai4/8L0ILexZL4mMwANa4G3Lrw1X3IbG0tqZOid/lEAMjON1KuUeO/2zACZovQGu+e1vTKjljdgmhU9D3iczBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrRWKil7s/IXzeP784tz+Ft2MkIoy2rJZHakhaYvKs0=;
 b=EuqU96S3gFUtn4t7R6Le3BHJclP+dnlO3+0dgNMhpIdB+jwAWUsGl/IP4rNmO2vQ7eT3h/21ffBrTOB9fxIEZTVACZeN60yFLx+p8fAUrARzDr8eE9atLfRbjcB2Due4wCOthgyUKQwX8N3tncbSp0eSXuc2EHGojMGpAVRZ8zo=
Received: from CYXPR03CA0036.namprd03.prod.outlook.com (2603:10b6:930:d2::20)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 04:54:29 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::92) by CYXPR03CA0036.outlook.office365.com
 (2603:10b6:930:d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:28 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Remove useless assignments and
 variables
Date: Wed, 23 Oct 2024 12:53:29 +0800
Message-ID: <20241023045336.1557443-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f278fef4-100e-42e2-5d2c-08dcf31ec73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8aGgvenQp5Muu6WmGEmUnD05dYmEd50pMvJj5epueJD7MsXnWY7OC0SKVvXI?=
 =?us-ascii?Q?lXpF1OaiI/ScN3UBgl+ia9Hd7B0+oZ6WKwD3TAUpVdLdnmpkTl/UPz/2DAVC?=
 =?us-ascii?Q?Q76yS3mrMxy+doS1aCB+vq1EVgJjpvEhNcEK6s3mEXeAsJXzQQtunR3jZdAH?=
 =?us-ascii?Q?cMOJwxjmra5vyjEDjFXhJpnCfFLHF9i0HiJWM+bwt1qdJnJuoykqPy+CcvAc?=
 =?us-ascii?Q?wXLYMsvKjvW10OqS9pR9smADyqHhy2Px/4iIZRaocSWOtlV1SRsjqQEoxBtH?=
 =?us-ascii?Q?BY8/WLwzbvgNK1vpB5WvHynmRZLeND/Xy5mQsLiJWFT8xBji4df3nVV0MoaN?=
 =?us-ascii?Q?yWJH8FKLEq9/ZZKX3Ff6LYWe0mJLmhHWE1iGyi1eSGGJSMy6BKLx2EkoBpLx?=
 =?us-ascii?Q?KR/Yvcj0wVH8O4DX/wphwpyiIiRTBI7oICg6uUZ9A0OkV8CXjY8CsLpMb1Fr?=
 =?us-ascii?Q?wMD5fmAOy3ZBKP4ZVXaztXUBfdUpB6wtK0bg1OGweOkOel0vaPCsZ/Nqcx2s?=
 =?us-ascii?Q?lV3KslGa8BIT4SjTPc4wtURDm5QnpgxKR5Z3/7etzCnuj0esMktLz7anBoko?=
 =?us-ascii?Q?TdGOE+3BxQxGFVWWak1OcPkY6QbM+YEwyZrdRFZsXffEMLJKYtqVMAzOmtUk?=
 =?us-ascii?Q?97K6NUDORVuGkzVq8GEKmkmzBm1DIV42CEM9/zxrXnJtKjb9+WM4Uszv5bvK?=
 =?us-ascii?Q?Gw4GxNscNiriNvmBm5Ka3tEvBArNamGVTidqMGHAMY9AGrrvkhSx/TQsI2B/?=
 =?us-ascii?Q?2mYrCRGHNcPdOt5/h5sKlrw2phUaiwcXHuxAst51orBiKpuGA/koK8KEwqbK?=
 =?us-ascii?Q?7Z5DZxj9XicAYCDGCg7s31yeo5QPDXWBS9jYk893B7ZqZPGgNd/tc77U8pYw?=
 =?us-ascii?Q?3KZ/Z37xnv+4RiC067RCJjlfGJlQwQMo2q9tNFTGFypP+ZKz6jttJkZzR5EG?=
 =?us-ascii?Q?eks/h4ka7gVzgWzSZLQgjHKokrk+6OZAJQMNCk+EeEQPnwwgxis/KXesGD1n?=
 =?us-ascii?Q?DVU/a0MaAMUJKmUSDI8Hk0djqgQcGXODtqj67bASD3qe1vMUc5oTlufvku32?=
 =?us-ascii?Q?+BBXxg5dj9/P4O70KMYpvv7VLKApv7WPOEJhSMm+UOrMCuVhWuVwzaH6EMYX?=
 =?us-ascii?Q?Z5M81VCvW1mAqG0GA4hKByBrNvHzsmqfaewwulHoWrkPGPCzi0QbMKZCuN/Y?=
 =?us-ascii?Q?8jIpqlreKodVvE6ioUI7GnA5BplTsf728eZaXmJdx0YVI2Wq74Pf0vnR0Zcr?=
 =?us-ascii?Q?biYskoEJ9XJFCCsQ9s6ffTdfhpeMGOISr2+nilHX0a6cxoVoljqvfT0W3kFm?=
 =?us-ascii?Q?uXb1Y2RmshONL+irjCCgYdNq5L0/M2u0Laf9q1Kj2kWIpWDpPqb4W2QQm5Lw?=
 =?us-ascii?Q?cA6B8Kz5gPFovRdr++qTL4Xz6SOGfuB7FkPqGrnboGN7UiAFrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:29.5083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f278fef4-100e-42e2-5d2c-08dcf31ec73c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
misc0, temp and split_pipe are assigned but immediately re-assigned
to other values. The early assignments are useless and are removed.
Unused variables are removed as well.

This fixes 5 UNUSED_VALUE issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                    | 1 -
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c         | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c | 2 --
 .../drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c   | 2 --
 5 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f0417ee6fcf8..f90fc154549a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1013,7 +1013,6 @@ static bool dc_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 		r2 = test_pipe->plane_res.scl_data.recout;
 		r2_r = r2.x + r2.width;
 		r2_b = r2.y + r2.height;
-		split_pipe = test_pipe;
 
 		/**
 		 * There is another half plane on same layer because of
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 5c2825bc9a87..d199e4ed2e59 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -277,7 +277,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	uint32_t misc1 = 0;
 	uint32_t h_blank;
 	uint32_t h_back_porch;
-	uint8_t synchronous_clock = 0; /* asynchronous mode */
 	uint8_t colorimetry_bpc;
 	uint8_t dynamic_range_rgb = 0; /*full range*/
 	uint8_t dynamic_range_ycbcr = 1; /*bt709*/
@@ -380,7 +379,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 		break;
 	}
 
-	misc0 = misc0 | synchronous_clock;
 	misc0 = colorimetry_bpc << 5;
 
 	if (REG(DP_MSA_TIMING_PARAM1)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
index db7557a1c613..8a3fbf95c48f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
@@ -76,7 +76,6 @@ UNP_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_C__GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_C_MAS
 		mmUNP_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_C,
 		value);
 
-	temp = 0;
 	value = 0;
 	temp = address.low_part >>
 	UNP_GRPH_PRIMARY_SURFACE_ADDRESS_C__GRPH_PRIMARY_SURFACE_ADDRESS_C__SHIFT;
@@ -112,7 +111,6 @@ UNP_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_L__GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_L_MAS
 		mmUNP_GRPH_PRIMARY_SURFACE_ADDRESS_HIGH_L,
 		value);
 
-	temp = 0;
 	value = 0;
 	temp = address.low_part >>
 	UNP_GRPH_PRIMARY_SURFACE_ADDRESS_L__GRPH_PRIMARY_SURFACE_ADDRESS_L__SHIFT;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
index f496e952ceec..d01a8b8f9595 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
@@ -255,7 +255,6 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 	uint32_t misc1 = 0;
 	uint32_t h_blank;
 	uint32_t h_back_porch;
-	uint8_t synchronous_clock = 0; /* asynchronous mode */
 	uint8_t colorimetry_bpc;
 	uint8_t dp_pixel_encoding = 0;
 	uint8_t dp_component_depth = 0;
@@ -362,7 +361,6 @@ void enc1_stream_encoder_dp_set_stream_attribute(
 		break;
 	}
 
-	misc0 = misc0 | synchronous_clock;
 	misc0 = colorimetry_bpc << 5;
 
 	switch (output_color_space) {
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 0a27e0942a12..098c2a01a850 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -447,7 +447,6 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 	uint32_t misc1 = 0;
 	uint32_t h_blank;
 	uint32_t h_back_porch;
-	uint8_t synchronous_clock = 0; /* asynchronous mode */
 	uint8_t colorimetry_bpc;
 	uint8_t dp_pixel_encoding = 0;
 	uint8_t dp_component_depth = 0;
@@ -603,7 +602,6 @@ void enc401_stream_encoder_dp_set_stream_attribute(
 		break;
 	}
 
-	misc0 = misc0 | synchronous_clock;
 	misc0 = colorimetry_bpc << 5;
 
 	switch (output_color_space) {
-- 
2.34.1

