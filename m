Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913F0E6B27C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B62710E9D3;
	Fri,  1 Nov 2024 13:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PYqGPWbc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CE410E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzpyKJDQP9bl7Dyr+souj7vcP+TryvYVoFTVJuYsG/nM7ijusxFH1BwWVtdfV9l2VJSvEWBYPEeDi/FJEJcZHwILYePesfDEy7w/L1kuUjHmYbjf9jTTPXN0n4WnghkHZsU+pHS+T9jKMdWXJqA8nC/8HoLQ0BNPZaqnoi8SS4+CCFkH1+FiqhLZ1txAdMv9DceT4h3gGC0KC8VXgPdcdY57xJnRFRlN8H0sZ3wQehsyt/BL2GuHKyk2gaZbeVgx5QrpxMM10OmsSWdUaPEa1k5xtTRc1Aqbp+HM6YMBNAa2kL+nyUGKegAiOcu/FwthXdwEdCCC14ZbFt4f/uoDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk4UCZl6ZyAcRBiK9IJz2vR24jkvdFt/ycm2V/GqMvM=;
 b=Ht3RaXwObLHd59l5SSluFkt5vnYJ2Qn9/x5PYQ8GvsHE6fN/voekQtKySPqiG3PWIBwHz9JhdZZ0s6m0Tzq1zByYqNvlKep4Os05iSUmNLHzIZlNsroBWmBRxQE755b7Zr9rPJ3NGHob1ifI0VnEK+ft9mPumfrUqEuI2KIIU4fZtd5fkQnziYcN21RBjB9tQnjoJNOftWzObbdWOz1BR4JmRohfL7kgVHvnl2v1haMHHKCVxI8Gbb/VgzMi3TRdxG+16Ofr52iHf5sEDNsOFqIW4RGH39OmpiQcSITXjoGvv6mCbvai4AL4PYTA8WJwhHOyOOw6OZqBT+KVqErzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk4UCZl6ZyAcRBiK9IJz2vR24jkvdFt/ycm2V/GqMvM=;
 b=PYqGPWbc0QrvX8zbNxiD13m81xpomCU6JlPkbB/N7CS4SHoJkeQhrIZyw8W6qqxlPglOl+Zh05PD2WBsJdlGqFgfAGFQoGpxw9exGXpcL4NY0+19FOXiftQjsbAueWL0PqNIAAO7OKJlJo1fNFNlPOdY/Axd5Py9NY4i7wNnRFw=
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 13:50:30 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::49) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:30 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:27 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 16/17] drm/amd/display: Prune Invalid Modes For HDMI Output
Date: Fri, 1 Nov 2024 09:49:39 -0400
Message-ID: <20241101134940.1426653-17-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 721f4908-0a2a-4b2c-f41b-08dcfa7c2639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m1JqWvwI5AkP27HCsSMYsMWwKBFt06S7t/BdNWVHxNNz1tVTzHHaWWyM8M9O?=
 =?us-ascii?Q?keEL7VMoWNoKE6IQyLmyvUaWi/eswIOzdk0N7juOWvpY0TyrVelcax/OaiUu?=
 =?us-ascii?Q?0yRAXmbD6scTn63mhL0qdQ3K26wVsgsWxC6qdwpy19I5WAg9tUN1m7R0Lfy3?=
 =?us-ascii?Q?+KpQqf8dHokwKCepBXd7my2eQq0kdF/PAJjo5bzgJ/CNqXArhl1RDkLcHyH2?=
 =?us-ascii?Q?pEaOpifpaE+u3igl9ZmVv7AWsQtZdv3A07BzvZ4vdUyUaHHTi+/CRaqxiGWg?=
 =?us-ascii?Q?qYnCedDXQcHbR39z+2oS0wQRQLEVh0mh+fnpoVyfTK2FDIZINAd3s180k4lM?=
 =?us-ascii?Q?MXyb80e0HO/zrJ2cN1WtRSJf7eM6SylAGrfwFPiOKz2vPffE6DDi3rWmPzH7?=
 =?us-ascii?Q?l9R+e0dOxUvTr6+8BanNpD61k9SpOyGpMbA4B91mzEnPkzHJMAgtC3znNpx8?=
 =?us-ascii?Q?XU/uULVzXuoxA/Wf8dFrcSBz2j3p8a8eHqXgYYFBppiHNH8ZC/8oSd9n/nos?=
 =?us-ascii?Q?Elcb97vsNUtszXVW9IGfMo4Q+sl+h00iaELynFqE9txVCtajVpzWewb/I/iJ?=
 =?us-ascii?Q?kw2O2sAgCOXN1bq1MSYIw2owrzX6ZA8034f4ou3p0pI6DtcTsz1uhGI3QJPu?=
 =?us-ascii?Q?DWgCGQPErrBwzK8hcCZ5H/kn6hl9pg+f2EtvDzx3WaZh/1aNRjv6t2/gRupg?=
 =?us-ascii?Q?oCq3OyBVGCVXdeHzcA+spABVWW/Tfk2K9C0M5WywtTgqiK8ihn0n8/y+ozNr?=
 =?us-ascii?Q?L/YElb0M9UHsPpiTuCkVij+rDa079IACQ8m1WUY2AZ24w7hOeW0N2dmMbRnT?=
 =?us-ascii?Q?McruQu0Vpqp/rSdQ9hRf8N5sib/vVADi/QT0BkM5P6q+SJPhjFRnCKqIJBDh?=
 =?us-ascii?Q?6yfXypU1oy+hBjnDHX+r0lyrXTWCA9ojGnFvEbW/GUN+kUmr8H2AbDj3h2IW?=
 =?us-ascii?Q?xTPK9DE7BjDot1/tlNy4djkAz/P9fCwtK55v720DaJDsIdweArUkq2s3iJE9?=
 =?us-ascii?Q?ec407yixwomg6ZB54oJMFdzwSA2EM1XKKOqufCvRQgrja4EikbkloxoYu84C?=
 =?us-ascii?Q?fLSrTdtCNFY01cXtskhs5Tr5pr8aSu/bjso4tFNOaIkfZHYUuWNoVdUar3NF?=
 =?us-ascii?Q?TPmNL+vfnr4PuXf6RjredRFItdqyyF86m6mhbjCrDPpx6lfW0A9LpdS8Xipz?=
 =?us-ascii?Q?gcjh6P72o5eAwk/H8RyXwD5CIkssl6P1vi92qMxID4wkr6M3JcC71p66SFR3?=
 =?us-ascii?Q?dz+t7GYPXpy6C8aoDB8pgOLjJzGL1bQX61OVMv/ugR2i8IR+7NnnsTPz2iBm?=
 =?us-ascii?Q?tGnF5DM/sgSh7mHJbM8e7PXXnpFE2848PGC5jYAUsTqaEBJh0kYr3wndKns3?=
 =?us-ascii?Q?pYS5pSdcoLu5vcZs1M6Yvkhycq7Hl9fhMqbStqMP5Nn1vYutdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:30.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721f4908-0a2a-4b2c-f41b-08dcfa7c2639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
1. HDMI does not have 6 bpc support. Having 6 bpc pass validation
does not comply with spec.
2. Validate 420 only for native HDMI, but not apply to pcon use
case.
3. Current mode validation log is not readable.

[how]
1. Cap 8 bpc for dp-hdmi converter.
2. Validate yuv420 for pcon use case as well,
   if rgb/yuv444 8bpc cannot fit into pcon bw limitation of
   the link from the converter to HDMI sink.
3. Add readable pixel_format and color_depth into debug log.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 40 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  6 +--
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +
 4 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00e0a10add86..7a1b5d5beeaf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7323,10 +7323,15 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	const struct drm_connector_state *drm_state = dm_state ? &dm_state->base : NULL;
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
+	uint8_t bpc_limit = 6;
 
 	if (!dm_state)
 		return NULL;
 
+	if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+	    aconnector->dc_link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+		bpc_limit = 8;
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
@@ -7347,11 +7352,12 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
-			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d (%s)\n",
+			DRM_DEBUG_KMS("Mode %dx%d (clk %d) pixel_encoding:%s color_depth:%s failed validation -- %s\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
 				      drm_mode->clock,
-				      dc_result,
+				      dc_pixel_encoding_to_str(stream->timing.pixel_encoding),
+				      dc_color_depth_to_str(stream->timing.display_color_depth),
 				      dc_status_to_str(dc_result));
 
 			dc_stream_release(stream);
@@ -7359,10 +7365,13 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			requested_bpc -= 2; /* lower bpc to retry validation */
 		}
 
-	} while (stream == NULL && requested_bpc >= 6);
+	} while (stream == NULL && requested_bpc >= bpc_limit);
 
-	if (dc_result == DC_FAIL_ENC_VALIDATE && !aconnector->force_yuv420_output) {
-		DRM_DEBUG_KMS("Retry forcing YCbCr420 encoding\n");
+	if ((dc_result == DC_FAIL_ENC_VALIDATE ||
+	     dc_result == DC_EXCEED_DONGLE_CAP) &&
+	     !aconnector->force_yuv420_output) {
+		DRM_DEBUG_KMS("%s:%d Retry forcing yuv420 encoding\n",
+				     __func__, __LINE__);
 
 		aconnector->force_yuv420_output = true;
 		stream = create_validate_stream_for_sink(aconnector, drm_mode,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 0bb25c537243..af1ea5792560 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -392,3 +392,43 @@ char *dc_status_to_str(enum dc_status status)
 
 	return "Unexpected status error";
 }
+
+char *dc_pixel_encoding_to_str(enum dc_pixel_encoding pixel_encoding)
+{
+	switch (pixel_encoding) {
+	case PIXEL_ENCODING_RGB:
+		return "RGB";
+	case PIXEL_ENCODING_YCBCR422:
+		return "YUV422";
+	case PIXEL_ENCODING_YCBCR444:
+		return "YUV444";
+	case PIXEL_ENCODING_YCBCR420:
+		return "YUV420";
+	default:
+		return "Unknown";
+	}
+}
+
+char *dc_color_depth_to_str(enum dc_color_depth color_depth)
+{
+	switch (color_depth) {
+	case COLOR_DEPTH_666:
+		return "6-bpc";
+	case COLOR_DEPTH_888:
+		return "8-bpc";
+	case COLOR_DEPTH_101010:
+		return "10-bpc";
+	case COLOR_DEPTH_121212:
+		return "12-bpc";
+	case COLOR_DEPTH_141414:
+		return "14-bpc";
+	case COLOR_DEPTH_161616:
+		return "16-bpc";
+	case COLOR_DEPTH_999:
+		return "9-bpc";
+	case COLOR_DEPTH_111111:
+		return "11-bpc";
+	default:
+		return "Unknown";
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index aca2821d546b..75b81db33828 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -810,12 +810,12 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			stream->dst.height,
 			stream->output_color_space);
 	DC_LOG_DC(
-			"\tpix_clk_khz: %d, h_total: %d, v_total: %d, pixelencoder:%d, displaycolorDepth:%d\n",
+			"\tpix_clk_khz: %d, h_total: %d, v_total: %d, pixel_encoding:%s, color_depth:%s\n",
 			stream->timing.pix_clk_100hz / 10,
 			stream->timing.h_total,
 			stream->timing.v_total,
-			stream->timing.pixel_encoding,
-			stream->timing.display_color_depth);
+			dc_pixel_encoding_to_str(stream->timing.pixel_encoding),
+			dc_color_depth_to_str(stream->timing.display_color_depth));
 	DC_LOG_DC(
 			"\tlink: %d\n",
 			stream->link->link_index);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index fa5edd03d004..b5afd8c3103d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -60,5 +60,7 @@ enum dc_status {
 };
 
 char *dc_status_to_str(enum dc_status status);
+char *dc_pixel_encoding_to_str(enum dc_pixel_encoding pixel_encoding);
+char *dc_color_depth_to_str(enum dc_color_depth color_depth);
 
 #endif /* _CORE_STATUS_H_ */
-- 
2.34.1

