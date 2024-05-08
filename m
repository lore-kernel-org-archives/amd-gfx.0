Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4201FC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B4711311C;
	Wed,  8 May 2024 17:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V9db3P5J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABACB11311C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgWr/3AygbG9cW5VYgQYN7RhVtGP4X0cy8XqbQSDaALC/NQjBv35+9CZpcq22XrAbJzb9O+HRrywneZnmBZ4sVUHqhhCqUvJeY3wQh/Uv0p8Z5Y42aQ/Hv18SLFUCsCeMw9YVO+n6aqtgK6BeeBpPMHQk4FXpenMSVZciBsNbQ7LvNbbrWeY6imd8iFHcqICkCEGwLBAakHl5O5VpUiGjGuffmzMbVoDfFreOMV/Ce++5DRYabWTAjpn7ien/bGFAjnyElRVkqATibBtvLkPfRReNkeAfnC+declhF5TLyuiXPcM8/TQsj6+yZKgd2zfiotY8vM0RjpkDCpwPaGj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3idas/AQyvLh2Ed5dxqE+NeSSvWOagdiIHbtrHYEzA=;
 b=EP/TnLCeH2OC1kXkYd4Vbmf34MPf1bAGUTJJCn8U5QxZv/n1D32aaf6Acq67cPQILxB5BtjptOq+WwaEpBtWMiZiuXtzQSpLlpsKjWeOHAlktGraMbUlgKZZ+yqJCZ/115I0coB4EHn93bpe7FycaUlqG1bW5miFsduDaflyOl+H9lJtC8yli14qH2KY/CdO1RHHqdIJu1e4U8oTCwgU2RaEcO8pDtfixUC1RHB9OZbMDkgqS91qCLpCkGTfm54f4lop8vR5Mn4Ydo0iFaCryQjNZ/V90J/m7GoLFTkNRVtIQJf2yb6/fCuR9bMpdHTF9kvmj2KlvY0T6aen+gc1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3idas/AQyvLh2Ed5dxqE+NeSSvWOagdiIHbtrHYEzA=;
 b=V9db3P5J/LmyTEGFZpt1/6ROkrdjJz23gj8T4djJRgweUGVOTaZKrmFG3b26JOVOAo0/51o5fKmA5JQEFrURStaWBEkQCzJU2S7LA8TKMMcu0NiGF9uESazDMR+r2wA4ymWifxHr1ULF+q3Tib/OAXSurM7cpK6kuf979gKQSBM=
Received: from MN2PR02CA0020.namprd02.prod.outlook.com (2603:10b6:208:fc::33)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:16:07 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::ed) by MN2PR02CA0020.outlook.office365.com
 (2603:10b6:208:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:16:07 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:16:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/20] drm/amd/display: Fix write to non-existent reg on DCN401
Date: Wed, 8 May 2024 11:13:05 -0600
Message-ID: <20240508171320.3292065-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 308bf184-ef70-49ce-70ac-08dc6f828c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TETaVVyu+BIhH+zqhkDv1SATWjZFW1KIPJoZbpeFT5xNhBVJJjhxIxUK8R38?=
 =?us-ascii?Q?avTHJzXjwXlDhh386F1xEJTAVHR8ft91PVlNYlalEH1iyBlRcx0tBjPx15bJ?=
 =?us-ascii?Q?hB76i0V+ZtnnyKGbc6PUhMZEBUWWrBM/87brvpGNC9z0DwY/uvN5g5ApslZV?=
 =?us-ascii?Q?Bu87bsBkwTKzbkbu0wIAou0Npvl0SoIoKj801XV1o7VdkEqDsOsRyQH8Hv5F?=
 =?us-ascii?Q?O4nMgmPffjOckegdeMR9whyk/Txp3cUbKzHf4/RrkwMQEBrngXecIoemRIN6?=
 =?us-ascii?Q?XWBONO8fgFh1riHoQljca8HDeOIAOTZ2eN/vBKq2o5JUOhtjBXK5W9NDWwIZ?=
 =?us-ascii?Q?7T/nIpDfaMLAY2zpE6en7R7hCGh8H1Bo8IdY++pFkYuJQNu1m5fu8DYlmIBg?=
 =?us-ascii?Q?JfE7C1BbFgcjFGAUh7TAMWJ0AICjg2MJRXKGmbThFjZi50ai1wZ1pgof4CE6?=
 =?us-ascii?Q?SSS0g+7ws+fwDxtE/5tdg8YR/hmQa9SiRO3BnC1fWCZ/eNYN2ombUH87ueRy?=
 =?us-ascii?Q?mJtNtH+4lfbd4Nnj9aLu+qhJ+SMsKkQ1WBFuoWKXaSAQeCwFnxJfTKD3/xcS?=
 =?us-ascii?Q?wPB3HzXgTgI4L3NtsPQLhtb2cP0ovujMZ5/vwK1pl2dEypCj9S5b3zUJbEy1?=
 =?us-ascii?Q?xg0Q597u6wHBO+0xBiSEupNmrzw5EJlMbZGen+6Wp/rukgmaMayfY4Pb+Dsb?=
 =?us-ascii?Q?CI8L2LrYNBUvmtITtX0Spdih+qNyoEKxt4yS5OmFnize1OZC1aO+000TVS/x?=
 =?us-ascii?Q?E9+tieRzg/uCV5WuUASMBoPp23ONNDz2MnzxRkH3Yq65UdwkA9Q8Gz+W2SRh?=
 =?us-ascii?Q?UcQ02gFoeVDGQ7Rgz7H1KbtFycnNQ5WAmARaJtPaIpq1gdvpz7VXHhL+GsT2?=
 =?us-ascii?Q?vtDEujb4izryii8cSFu0el72DjgaL4ZM5cwi9Mx7bcFRFlH5lbmsRoTpxbMe?=
 =?us-ascii?Q?EhpdDXvWO2QgqLp/kn+KjgAXQTiEYtCmtb7Lwdt6J7Nn9xGOYm4uyGmiFk5X?=
 =?us-ascii?Q?XhwtEEYLF3TnUy0wDKEW3XM7qTIJAJwookaeU1sUJSh0zR5U4D6tE9D7IkTw?=
 =?us-ascii?Q?YCGlkVRcFhoSA15jEerNaNekBEUwSbj7aLa4kTjeg0Gl9FM+M+gN97JQlP5j?=
 =?us-ascii?Q?f9okBWqMv9VUeTTv33/Wu/ZPmlt01MCBwhsqEpjuuw+kSR5Pv1tepolpd5Nu?=
 =?us-ascii?Q?ZxzI6ERB+1TvkCGD0mTJEfCeJjmRbCcSYKJjpyBT+FLoMrfTjXQs/vSTrE5P?=
 =?us-ascii?Q?UCzSl+VgX+CSJjvwtQBYn7woCFwja9hCVzDZq/fzHlJjPtAwtZmwbVsvDEdu?=
 =?us-ascii?Q?adM0P49HI9gtdL3PFjJ2sP/oJ4t6AqtOUZFWjTPK/k4C0mUxd+X3M5xi3Rgm?=
 =?us-ascii?Q?2xGazXkWHLQOkJPE4ko8G78/o6YW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:16:07.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308bf184-ef70-49ce-70ac-08dc6f828c97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

DP_DSC_CNTL no longer exists on DCN401.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 .../dc/dcn401/dcn401_dio_stream_encoder.c     | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
index 1c55ccede09b..090288305609 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
@@ -372,21 +372,6 @@ static void enc401_stream_encoder_dp_unblank(
 	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM);
 }
 
-/* Set DSC-related configuration.
- *   dsc_mode: 0 disables DSC, other values enable DSC in specified format
- *   sc_bytes_per_pixel: DP_DSC_BYTES_PER_PIXEL removed in DCN3x
- *   dsc_slice_width: DP_DSC_SLICE_WIDTH removed in DCN3x
- */
-static void enc401_dp_set_dsc_config(struct stream_encoder *enc,
-					enum optc_dsc_mode dsc_mode,
-					uint32_t dsc_bytes_per_pixel,
-					uint32_t dsc_slice_width)
-{
-	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-
-	REG_UPDATE(DP_DSC_CNTL,	DP_DSC_MODE, dsc_mode == OPTC_DSC_DISABLED ? 0 : 1);
-}
-
 /* this function read dsc related register fields to be logged later in dcn10_log_hw_state
  * into a dcn_dsc_state struct.
  */
@@ -395,7 +380,8 @@ static void enc401_read_state(struct stream_encoder *enc, struct enc_state *s)
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	//if dsc is enabled, continue to read
-	REG_GET(DP_DSC_CNTL, DP_DSC_MODE, &s->dsc_mode);
+	REG_GET(DP_PIXEL_FORMAT, PIXEL_ENCODING_TYPE, &s->dsc_mode);
+
 	if (s->dsc_mode) {
 		REG_GET(DP_GSP11_CNTL, DP_SEC_GSP11_LINE_NUM, &s->sec_gsp_pps_line_num);
 
@@ -770,7 +756,7 @@ static const struct stream_encoder_funcs dcn401_str_enc_funcs = {
 	.dp_get_pixel_format  = enc1_stream_encoder_dp_get_pixel_format,
 
 	.enc_read_state = enc401_read_state,
-	.dp_set_dsc_config = enc401_dp_set_dsc_config,
+	.dp_set_dsc_config = NULL,
 	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc401_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
-- 
2.34.1

