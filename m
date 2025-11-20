Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1713ECF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50E510E7B0;
	Thu, 20 Nov 2025 18:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GOxxSQUo";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8885610E7B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPpXRPHgFW+XVOllmJXyDsfnFBpvSQamsuqkQtJWds6C+aoeyk/zjZIVSclEV1fwfXg3GPiGcBhbdMgd44WyGnL9EXi5iXZS9oYCgb+8Lh/n1jcX2Ya83n0cnpopjjYit/S7NhI51QlZEvtdJ7uSNC5pzaV7ORB8VZXIw/U8WfHM665ufqBb5kbpQzn0tTLAscATxu3kqctWqGrNCygriWco3QMC4fbtp387J4WMBQ9+8LF5h4L03KMarWY/zAui+UvVKu28f/GVaMbMHKhzYPJ3Ze8+vI/+sLruYVvHpwNS3TdKq8ZS+NI5FxqQIMJ0TQ8Wh4EsReA3C99ML1HBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htNndp8cpmAmCs2L01ogkgWYbinp0i8q7TqGO8nhdXA=;
 b=HtwNcWhhiiju/IV/4g26q1FcyEgcp2tZpNOTQjX705Ggzc0VDTmZ9N8aMT4tkQ/uqsMGNQBJlsYV6OHy0O17ONoh8eP7i+HVYmE+Tuoy6H1xMsaxgyKW8RleG7tNHL76RUZiihd/GwK1DYIMdRo9WVF9zmJnVNA8fuQs/FQ5MG6URjboBRQBOa1JFZLrxqyeBzfFA3Xa5gUftSRpPyfwuYbePDJESdCtv/M7C2RdjqDdynZQrzbxHCcPxXDJ4GTVxAnr0VWf+sYzoB2jNv2j9Aw1xWUj1x2Hk21cVJjc8KUGF9icDrM3AAGFTiqUaRd8cy7+PGelXpwd1n3x9Ax0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htNndp8cpmAmCs2L01ogkgWYbinp0i8q7TqGO8nhdXA=;
 b=GOxxSQUou5af4N9SCfCcHOHm8ZlUGmiecdU5N5JYF2ih2adTQI6t+MtxHBRYBane4Ak77U404qJ/sZ/NP8dsf2Pb80mtAGkZ7PoMt7UZNxOIgORigtKmlWgJaHo1SIuy2rixGhcM5yQFhmv4JAfqMnOsmRiLaCmDrHkQVww11P0=
Received: from CH5P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::14)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:18:39 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::d3) by CH5P222CA0013.outlook.office365.com
 (2603:10b6:610:1ee::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 18:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:18:39 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:18:37 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jack Chang <jack.chang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 07/26] drm/amd/display: Revise VSC SDP header for Panel Replay
Date: Thu, 20 Nov 2025 11:03:03 -0700
Message-ID: <20251120181527.317107-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 839d8d12-58c7-40bc-811d-08de28613a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x99Vm+s2/pgIiSYvJvZqzL5M85wbNoWeDnlynC4p1QkTMaKUx6I8iTWWGMAB?=
 =?us-ascii?Q?8UnAfKaCi36dxQXYqY5ve9Mj7AWjHdNDG1UEO2mvVDzUSQukLRosEyqgkJgQ?=
 =?us-ascii?Q?Ezw8HLLtXva2FpudNwKHtHPjw3ZbDPy+eQp4sFCL0krMwxGdi4ebw1OQe2dN?=
 =?us-ascii?Q?77c34muLrKjFu3vP6thORzgtQ9WWlOJVZi1tNurgOb1FiL4CBJ6lPHxN0DTq?=
 =?us-ascii?Q?dG2KCYWgm4hyAABOmRT3epHnQgCEE0QAJv9iMk7uwG7ATutPu1+eLTvwkV9J?=
 =?us-ascii?Q?a4oBVv9GBDellfqVxQ072yJaVLUvzVt3FLXQPNeZPssyC6qK3eDN5rQpahAD?=
 =?us-ascii?Q?hzjwNOOXJS0kkIHJl5YR6NmJSq5Jc/AhDotMQwQb52z69HB6ymGv4HGBUWpf?=
 =?us-ascii?Q?BEuCaAvMDttqPr4LTA+zPGFAXesDBQBfvsKUGeev2qb/X+JhKKW0Das9LtZc?=
 =?us-ascii?Q?zM+wUQrugW4BWnkZWUWex5uNz8ZX5uPEaNLmip7xWJ2wYpDQ+6K2n5jy6N/C?=
 =?us-ascii?Q?NImDrl9dqA3QDfEY3ZVAB43EDG8SvSYhUVmipkVOQzLO38BSo8CNklT6Tfi0?=
 =?us-ascii?Q?nCywPuVWwAJtno2dRZOy+l+fUZeMPQCIEWKasuEKdXlp5UQcBsWMhMD0hnOI?=
 =?us-ascii?Q?uxLFgtrWykLjiLN3zE5NmzyPyz51Sl8C1XJKmVNnfnz5XCDjR7+9leSGf9xQ?=
 =?us-ascii?Q?W6V1PrF3W8Q6O8jYqRqkAkLcDXAPvTmD0hsUZ0bLfjvWxKNVJmr4bgQU+NQz?=
 =?us-ascii?Q?FctPOzY9SfkHBUg0E0Aw1K8yZLhtF/8V+x2vu43GpI0See9CBHubITC9Qum1?=
 =?us-ascii?Q?eVSssrqYmsKdD2rThjrJHfg8xFp4yvYQxXwJKBPpdPA59qdYgA/YXTf5LU7A?=
 =?us-ascii?Q?R8JIpBkInTc8a2QlwkA77xWBqzAPmWnU1Z2d3cPwmW1ufbmLtzQtHIuII3s+?=
 =?us-ascii?Q?88UYD9QhbaNYMJkr0JTslO+1EAfgdQxP4JIoG+msA62bB62Npi7qqDY2xf5m?=
 =?us-ascii?Q?KPW4rhBipSsTumvvo1sev4Uzs1BrBn86yxtCCrcDXsUzAJrFVhZ2yYwACXqu?=
 =?us-ascii?Q?or/BuZvS4UZP4KbADoD0P4etIV9jS6kkiC9PUDfRgPdL1+4SO6DDfKxio+7C?=
 =?us-ascii?Q?z5jMEmisWYWwwquuJKQbZALCVd4wNbbz1L3BCPuPX2KcK2scJqsteVrpTFKj?=
 =?us-ascii?Q?QSOt4rYDnMqV/VpFFO1lUlm3fkghtJE85c8v2ADU8bqzN/H4yC2RQBMZUHpJ?=
 =?us-ascii?Q?/RorbkGyh1v5j2Zx3vpeP1ZyuMm0taLBhWYo+P6kR3L8h2o/AHHIqSvaAWAt?=
 =?us-ascii?Q?MNq1M5l3MqveKqe5xmz2xnfg39soNyVBISf+fttb9crbJnWjPHlBwPLhwSo0?=
 =?us-ascii?Q?yPBBxyDYO9NR4ErNIweiLXuPL2AWFRvKZqCcBE7l1xOpQNfCmzqWrSA3qsRd?=
 =?us-ascii?Q?u2wYu7xU+FIsp/hHSPeOVbq/4msn8EAAlZ84zYcbNFsMNngkmZDUQR39mII1?=
 =?us-ascii?Q?aq4/qw+zyKEhCXi3nrvM60QmP9KFew9TQyM9ebJ53ESJvsDM3IcKS4c0noGB?=
 =?us-ascii?Q?Yhqc2Li3r6ZZGVEJHKs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:18:39.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839d8d12-58c7-40bc-811d-08de28613a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
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

From: Jack Chang <jack.chang@amd.com>

[WAHT]
Add vsc sdp header setting for Panel Replay.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Jack Chang <jack.chang@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/modules/inc/mod_info_packet.h |   6 +
 .../display/modules/info_packet/info_packet.c | 345 ++++++++++--------
 2 files changed, 206 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 66dc9a19aebe..ddd64b7e4c04 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -33,6 +33,12 @@ struct dc_stream_state;
 struct dc_info_packet;
 struct mod_vrr_params;
 
+void set_vsc_packet_colorimetry_data(
+		const struct dc_stream_state *stream,
+		struct dc_info_packet *info_packet,
+		enum dc_color_space cs,
+		enum color_transfer_func tf);
+
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
 		enum dc_color_space cs,
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 251b7b6f45af..00473c6284d5 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -42,6 +42,10 @@ enum vsc_packet_revision {
 	vsc_packet_rev4 = 4,
 	//05h = 3D stereo + PSR/PSR2 + Y-coordinate + Pixel Encoding/Colorimetry Format
 	vsc_packet_rev5 = 5,
+	//06h = 3D stereo + PR + Y-coordinate
+	vsc_packet_rev6 = 6,
+	//07h = 3D stereo + PR + Y-coordinate + Pixel Encoding/Colorimetry Format
+	vsc_packet_rev7 = 7,
 };
 
 #define HDMI_INFOFRAME_TYPE_VENDOR 0x81
@@ -130,6 +134,163 @@ enum ColorimetryYCCDP {
 	ColorimetryYCC_DP_ITU2020YCbCr  = 7,
 };
 
+/* Helper function to set VSC packet colorimetry data */
+void set_vsc_packet_colorimetry_data(
+		const struct dc_stream_state *stream,
+		struct dc_info_packet *info_packet,
+		enum dc_color_space cs,
+		enum color_transfer_func tf)
+{
+	/* Set VSC SDP fields for pixel encoding and colorimetry format from DP 1.3 specs
+	 * Data Bytes DB 18~16
+	 * Bits 3:0 (Colorimetry Format)        |  Bits 7:4 (Pixel Encoding)
+	 * ----------------------------------------------------------------------------------------------------
+	 * 0x0 = sRGB                           |  0 = RGB
+	 * 0x1 = RGB Wide Gamut Fixed Point
+	 * 0x2 = RGB Wide Gamut Floating Point
+	 * 0x3 = AdobeRGB
+	 * 0x4 = DCI-P3
+	 * 0x5 = CustomColorProfile
+	 * (others reserved)
+	 * ----------------------------------------------------------------------------------------------------
+	 * 0x0 = ITU-R BT.601                   |  1 = YCbCr444
+	 * 0x1 = ITU-R BT.709
+	 * 0x2 = xvYCC601
+	 * 0x3 = xvYCC709
+	 * 0x4 = sYCC601
+	 * 0x5 = AdobeYCC601
+	 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+	 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+	 * (others reserved)
+	 * ----------------------------------------------------------------------------------------------------
+	 * 0x0 = ITU-R BT.601                   |  2 = YCbCr422
+	 * 0x1 = ITU-R BT.709
+	 * 0x2 = xvYCC601
+	 * 0x3 = xvYCC709
+	 * 0x4 = sYCC601
+	 * 0x5 = AdobeYCC601
+	 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+	 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+	 * (others reserved)
+	 * ----------------------------------------------------------------------------------------------------
+	 * 0x0 = ITU-R BT.601                   |  3 = YCbCr420
+	 * 0x1 = ITU-R BT.709
+	 * 0x2 = xvYCC601
+	 * 0x3 = xvYCC709
+	 * 0x4 = sYCC601
+	 * 0x5 = AdobeYCC601
+	 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
+	 * 0x7 = ITU-R BT.2020 Y'C'bC'r
+	 * (others reserved)
+	 * ----------------------------------------------------------------------------------------------------
+	 * 0x0 =DICOM Part14 Grayscale          |  4 = Yonly
+	 * Display Function
+	 * (others reserved)
+	 */
+	unsigned int pixelEncoding = 0;
+	unsigned int colorimetryFormat = 0;
+
+	/* Set Pixel Encoding */
+	switch (stream->timing.pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		pixelEncoding = 0x0;  /* RGB = 0h */
+		break;
+	case PIXEL_ENCODING_YCBCR444:
+		pixelEncoding = 0x1;  /* YCbCr444 = 1h */
+		break;
+	case PIXEL_ENCODING_YCBCR422:
+		pixelEncoding = 0x2;  /* YCbCr422 = 2h */
+		break;
+	case PIXEL_ENCODING_YCBCR420:
+		pixelEncoding = 0x3;  /* YCbCr420 = 3h */
+		break;
+	default:
+		pixelEncoding = 0x0;  /* default RGB = 0h */
+		break;
+	}
+
+	/* Set Colorimetry format based on pixel encoding */
+	switch (stream->timing.pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		if ((cs == COLOR_SPACE_SRGB) ||
+				(cs == COLOR_SPACE_SRGB_LIMITED))
+			colorimetryFormat = ColorimetryRGB_DP_sRGB;
+		else if (cs == COLOR_SPACE_ADOBERGB)
+			colorimetryFormat = ColorimetryRGB_DP_AdobeRGB;
+		else if ((cs == COLOR_SPACE_2020_RGB_FULLRANGE) ||
+				(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE))
+			colorimetryFormat = ColorimetryRGB_DP_ITU_R_BT2020RGB;
+		break;
+
+	case PIXEL_ENCODING_YCBCR444:
+	case PIXEL_ENCODING_YCBCR422:
+	case PIXEL_ENCODING_YCBCR420:
+		/* Note: xvYCC probably not supported correctly here on DP since colorspace translation
+		 * loses distinction between BT601 vs xvYCC601 in translation
+		 */
+		if (cs == COLOR_SPACE_YCBCR601)
+			colorimetryFormat = ColorimetryYCC_DP_ITU601;
+		else if (cs == COLOR_SPACE_YCBCR709)
+			colorimetryFormat = ColorimetryYCC_DP_ITU709;
+		else if (cs == COLOR_SPACE_ADOBERGB)
+			colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
+		else if (cs == COLOR_SPACE_2020_YCBCR_LIMITED)
+			colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
+
+		if (cs == COLOR_SPACE_2020_YCBCR_LIMITED && tf == TRANSFER_FUNC_GAMMA_22)
+			colorimetryFormat = ColorimetryYCC_DP_ITU709;
+		break;
+
+	default:
+		colorimetryFormat = ColorimetryRGB_DP_sRGB;
+		break;
+	}
+
+	info_packet->sb[16] = (pixelEncoding << 4) | colorimetryFormat;
+
+	/* Set color depth */
+	switch (stream->timing.display_color_depth) {
+	case COLOR_DEPTH_666:
+		/* NOTE: This is actually not valid for YCbCr pixel encoding to have 6 bpc
+		 *       as of DP1.4 spec, but value of 0 probably reserved here for potential future use.
+		 */
+		info_packet->sb[17] = 0;
+		break;
+	case COLOR_DEPTH_888:
+		info_packet->sb[17] = 1;
+		break;
+	case COLOR_DEPTH_101010:
+		info_packet->sb[17] = 2;
+		break;
+	case COLOR_DEPTH_121212:
+		info_packet->sb[17] = 3;
+		break;
+	/*case COLOR_DEPTH_141414: -- NO SUCH FORMAT IN DP SPEC */
+	case COLOR_DEPTH_161616:
+		info_packet->sb[17] = 4;
+		break;
+	default:
+		info_packet->sb[17] = 0;
+		break;
+	}
+
+	/* all YCbCr are always limited range */
+	if ((cs == COLOR_SPACE_SRGB_LIMITED) ||
+			(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE) ||
+			(pixelEncoding != 0x0)) {
+		info_packet->sb[17] |= 0x80; /* DB17 bit 7 set to 1 for CEA timing. */
+	}
+
+	/* Content Type (Bits 2:0)
+	 *  0 = Not defined.
+	 *  1 = Graphics.
+	 *  2 = Photo.
+	 *  3 = Video.
+	 *  4 = Game.
+	 */
+	info_packet->sb[18] = 0;
+}
+
 void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet,
 		enum dc_color_space cs,
@@ -137,8 +298,6 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 {
 	unsigned int vsc_packet_revision = vsc_packet_undefined;
 	unsigned int i;
-	unsigned int pixelEncoding = 0;
-	unsigned int colorimetryFormat = 0;
 	bool stereo3dSupport = false;
 
 	if (stream->timing.timing_3d_format != TIMING_3D_FORMAT_NONE && stream->view_format != VIEW_3D_FORMAT_NONE) {
@@ -158,12 +317,38 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	if (stream->use_vsc_sdp_for_colorimetry)
 		vsc_packet_revision = vsc_packet_rev5;
 
+	/* Check for Panel Replay (highest priority) */
+	if (stream->link->replay_settings.config.replay_version == DC_VESA_PANEL_REPLAY)
+		vsc_packet_revision = stream->use_vsc_sdp_for_colorimetry ? vsc_packet_rev7 : vsc_packet_rev6;
+
 	/* VSC packet not needed based on the features
 	 * supported by this DP display
 	 */
 	if (vsc_packet_revision == vsc_packet_undefined)
 		return;
 
+	if (vsc_packet_revision == vsc_packet_rev6) {
+		/* Secondary-data Packet ID = 0*/
+		info_packet->hb0 = 0x00;
+		/* 07h - Packet Type Value indicating Video
+		 * Stream Configuration packet
+		 */
+		info_packet->hb1 = 0x07;
+		/* 06h = VSC SDP supporting 3D stereo + PR
+		 */
+		info_packet->hb2 = 0x06;
+		/* 0Eh = VSC SDP supporting 3D stereo + PR
+		 * (HB2 = 06h), with Y-coordinate of first scan
+		 * line of the SU region
+		 */
+		info_packet->hb3 = 0x10;
+
+		for (i = 0; i < 28; i++)
+			info_packet->sb[i] = 0;
+
+		info_packet->valid = true;
+	}
+
 	if (vsc_packet_revision == vsc_packet_rev4) {
 		/* Secondary-data Packet ID = 0*/
 		info_packet->hb0 = 0x00;
@@ -292,152 +477,22 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = true;
 
-		/* Set VSC SDP fields for pixel encoding and colorimetry format from DP 1.3 specs
-		 * Data Bytes DB 18~16
-		 * Bits 3:0 (Colorimetry Format)        |  Bits 7:4 (Pixel Encoding)
-		 * ----------------------------------------------------------------------------------------------------
-		 * 0x0 = sRGB                           |  0 = RGB
-		 * 0x1 = RGB Wide Gamut Fixed Point
-		 * 0x2 = RGB Wide Gamut Floating Point
-		 * 0x3 = AdobeRGB
-		 * 0x4 = DCI-P3
-		 * 0x5 = CustomColorProfile
-		 * (others reserved)
-		 * ----------------------------------------------------------------------------------------------------
-		 * 0x0 = ITU-R BT.601                   |  1 = YCbCr444
-		 * 0x1 = ITU-R BT.709
-		 * 0x2 = xvYCC601
-		 * 0x3 = xvYCC709
-		 * 0x4 = sYCC601
-		 * 0x5 = AdobeYCC601
-		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
-		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
-		 * (others reserved)
-		 * ----------------------------------------------------------------------------------------------------
-		 * 0x0 = ITU-R BT.601                   |  2 = YCbCr422
-		 * 0x1 = ITU-R BT.709
-		 * 0x2 = xvYCC601
-		 * 0x3 = xvYCC709
-		 * 0x4 = sYCC601
-		 * 0x5 = AdobeYCC601
-		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
-		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
-		 * (others reserved)
-		 * ----------------------------------------------------------------------------------------------------
-		 * 0x0 = ITU-R BT.601                   |  3 = YCbCr420
-		 * 0x1 = ITU-R BT.709
-		 * 0x2 = xvYCC601
-		 * 0x3 = xvYCC709
-		 * 0x4 = sYCC601
-		 * 0x5 = AdobeYCC601
-		 * 0x6 = ITU-R BT.2020 Y'cC'bcC'rc
-		 * 0x7 = ITU-R BT.2020 Y'C'bC'r
-		 * (others reserved)
-		 * ----------------------------------------------------------------------------------------------------
-		 * 0x0 =DICOM Part14 Grayscale          |  4 = Yonly
-		 * Display Function
-		 * (others reserved)
-		 */
-
-		/* Set Pixel Encoding */
-		switch (stream->timing.pixel_encoding) {
-		case PIXEL_ENCODING_RGB:
-			pixelEncoding = 0x0;  /* RGB = 0h */
-			break;
-		case PIXEL_ENCODING_YCBCR444:
-			pixelEncoding = 0x1;  /* YCbCr444 = 1h */
-			break;
-		case PIXEL_ENCODING_YCBCR422:
-			pixelEncoding = 0x2;  /* YCbCr422 = 2h */
-			break;
-		case PIXEL_ENCODING_YCBCR420:
-			pixelEncoding = 0x3;  /* YCbCr420 = 3h */
-			break;
-		default:
-			pixelEncoding = 0x0;  /* default RGB = 0h */
-			break;
-		}
-
-		/* Set Colorimetry format based on pixel encoding */
-		switch (stream->timing.pixel_encoding) {
-		case PIXEL_ENCODING_RGB:
-			if ((cs == COLOR_SPACE_SRGB) ||
-					(cs == COLOR_SPACE_SRGB_LIMITED))
-				colorimetryFormat = ColorimetryRGB_DP_sRGB;
-			else if (cs == COLOR_SPACE_ADOBERGB)
-				colorimetryFormat = ColorimetryRGB_DP_AdobeRGB;
-			else if ((cs == COLOR_SPACE_2020_RGB_FULLRANGE) ||
-					(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE))
-				colorimetryFormat = ColorimetryRGB_DP_ITU_R_BT2020RGB;
-			break;
-
-		case PIXEL_ENCODING_YCBCR444:
-		case PIXEL_ENCODING_YCBCR422:
-		case PIXEL_ENCODING_YCBCR420:
-			/* Note: xvYCC probably not supported correctly here on DP since colorspace translation
-			 * loses distinction between BT601 vs xvYCC601 in translation
-			 */
-			if (cs == COLOR_SPACE_YCBCR601)
-				colorimetryFormat = ColorimetryYCC_DP_ITU601;
-			else if (cs == COLOR_SPACE_YCBCR709)
-				colorimetryFormat = ColorimetryYCC_DP_ITU709;
-			else if (cs == COLOR_SPACE_ADOBERGB)
-				colorimetryFormat = ColorimetryYCC_DP_AdobeYCC;
-			else if (cs == COLOR_SPACE_2020_YCBCR_LIMITED)
-				colorimetryFormat = ColorimetryYCC_DP_ITU2020YCbCr;
-
-			if (cs == COLOR_SPACE_2020_YCBCR_LIMITED && tf == TRANSFER_FUNC_GAMMA_22)
-				colorimetryFormat = ColorimetryYCC_DP_ITU709;
-			break;
-
-		default:
-			colorimetryFormat = ColorimetryRGB_DP_sRGB;
-			break;
-		}
-
-		info_packet->sb[16] = (pixelEncoding << 4) | colorimetryFormat;
+		set_vsc_packet_colorimetry_data(stream, info_packet, cs, tf);
+	}
 
-		/* Set color depth */
-		switch (stream->timing.display_color_depth) {
-		case COLOR_DEPTH_666:
-			/* NOTE: This is actually not valid for YCbCr pixel encoding to have 6 bpc
-			 *       as of DP1.4 spec, but value of 0 probably reserved here for potential future use.
-			 */
-			info_packet->sb[17] = 0;
-			break;
-		case COLOR_DEPTH_888:
-			info_packet->sb[17] = 1;
-			break;
-		case COLOR_DEPTH_101010:
-			info_packet->sb[17] = 2;
-			break;
-		case COLOR_DEPTH_121212:
-			info_packet->sb[17] = 3;
-			break;
-		/*case COLOR_DEPTH_141414: -- NO SUCH FORMAT IN DP SPEC */
-		case COLOR_DEPTH_161616:
-			info_packet->sb[17] = 4;
-			break;
-		default:
-			info_packet->sb[17] = 0;
-			break;
-		}
+	if (vsc_packet_revision == vsc_packet_rev7) {
+		/* Secondary-data Packet ID = 0 */
+		info_packet->hb0 = 0x00;
+		/* 07h - Packet Type Value indicating Video Stream Configuration packet */
+		info_packet->hb1 = 0x07;
+		/* 07h = VSC SDP supporting 3D stereo, PR, and Pixel Encoding/Colorimetry Format indication. */
+		info_packet->hb2 = 0x07;
+		/* 13h = VSC SDP supporting 3D stereo, + PR, + Pixel Encoding/Colorimetry Format indication (HB2 = 07h). */
+		info_packet->hb3 = 0x13;
 
-		/* all YCbCr are always limited range */
-		if ((cs == COLOR_SPACE_SRGB_LIMITED) ||
-				(cs == COLOR_SPACE_2020_RGB_LIMITEDRANGE) ||
-				(pixelEncoding != 0x0)) {
-			info_packet->sb[17] |= 0x80; /* DB17 bit 7 set to 1 for CEA timing. */
-		}
+		info_packet->valid = true;
 
-		/* Content Type (Bits 2:0)
-		 *  0 = Not defined.
-		 *  1 = Graphics.
-		 *  2 = Photo.
-		 *  3 = Video.
-		 *  4 = Game.
-		 */
-		info_packet->sb[18] = 0;
+		set_vsc_packet_colorimetry_data(stream, info_packet, cs, tf);
 	}
 }
 
-- 
2.43.0

