Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DCBC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AECE10F416;
	Fri, 31 Jul 2026 21:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GhBamGuD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD2B10F3FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqkzDUkDSq/zrdTvHa3TGI+nPVGjslXPR0BlpISTk0kvU0b1gn/otoeAkSslzEosbt0RIIQBOr7cWOz/I5kJRvd/qGrIHz6ET3OkGkvG9Wmf0lBDqG5/0lY0cZWoKxMeqLhoWA+oVksrOV38ykubDHx/AedkckrtPmt5/7wo8TnkJjLJVjYt0EDYS0XpviRWVxxHPIzgs4KWitRpisuxSi2HRvWMcwsGlfVwP9qU5vb/96XapPqxPKtJkmok3CuMCDQK70yc1AbkaeG9wYkxhLgfRdISXrD/Hq4xw+POm7IuiUzdL1HWsAliqf5F+4aHB8mdkGMWFqzpxbJfLuot1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX3siSgqNdlhVV8TE/TPLxg+nO4SAquzFdwWnGwGs0k=;
 b=mfEee4A5VMvnwHpbG5wrJJMDepY4Pa+NyKQrHA/Deqqpo2arClgJQKWZWBKhmvC1+3igFLv0e4k6yVabjmRVZxFU6g5vxd/RQ9idr8IAAKYCSJaX2mpsjfo1dcZpQ1tSo1SMNRlukYUmBikT6w9pNvFgbHkOY116rKXYxt57B++5ocbX9zYKNKUpHFDgBsQCwO4vhpN6SsCjw4Yzkh5SZ1fL/N4HufHDAiu6lTf44zqxIaADyeGefc1JTNoM/2cZbMj1Akf1cnOpVUelx0WWXjsi7FZAI44aJ5XIYRVM5fg0lpoWQcNJ31BnKARGOPX+asYw+VuQX6HjmX1BZ0Uylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX3siSgqNdlhVV8TE/TPLxg+nO4SAquzFdwWnGwGs0k=;
 b=GhBamGuDIkwiF+O3NIskA19+7jxIZqwbww1+2hCOKe1tdpb+9CcDJlS6QD60iUW14K94xc/0dV/X8na/YNT3ljyAZvbbVjZS9SoBREXghRJUKyadOfKyHWhd92JkOSgRo2CuL/SFUzD3a12F7cL9kimuQ0S1w0lpqSnpbrVNJKE=
Received: from CH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:32::31)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:53 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ad) by CH0PR07CA0026.outlook.office365.com
 (2603:10b6:610:32::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:50 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:49 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 22/41] drm/amd/display: Unify force_yuv debugfs into
 force_yuv_pixel_format
Date: Fri, 31 Jul 2026 17:12:43 -0400
Message-ID: <20260731211302.3040343-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a6ee3-bc56-4858-29f4-08deef48e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|6133799003|56012099006|11063799006|10067099003|5023799004|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Uoua5HJM8cjDBtwY17HqZ8wpo3CAPO0RFyhD2RU2O1Y+1FLrcT2V7PmiLDBvYFYngb01QhwRzubDz1rJm+4AfRT53LeRNH3tMDRfuanumFStXXhbMVuk6h/c9Tpr3OrfMlbERF4Nt6DTFpf0Y8wJ1m8urme278QXaXkvbMaPT3ehtrjSqsKdQu2QSNHNqDl/7bdMmMnAXQzNKAvwmltgSOIy9vYjADLiofrbDnG1IqpbJHDFiwpjzKVzMPSooKNiXd5D91NZV0krq2nxLeWDRGRV+P75dxDkPj0mgNqtg+pJEoyuiZO1r4cAtZjo1cmo8ceTlH9NHyaRNtQgNQFuLgqbZRGja0Wlqh3/1ltvjYFT5uTAR0WNl8iqEio1ec1r7UYsYUgfc+6x5g0IFBVwkASTZKUXBqGaptGSDKJxURS0DrremNw0e0eXv2PIFxnLB+UzZALgm5HVvRmk/2Iu/XZQ1OkshbCQOV6ldA/wSaBiLEJpMMl8TcLz0UgONQ/poKguWM2JJN+5VyTs8C44QXgBq/vTubk6pcKbuXoONzTDdB+ynj7C8/11doN6m+i98gnzPO1P3FmyxOWp0eJ7NO1naTaVDjjfbMq/U5Jp/Rw4kSZooFBTLlCQlVchTjgsHzqBfS8M7DBvp+llOILBuqRfrFppZpyIgGuMjP6o31y/FWCiePwQoW2d8FwX1/mr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(5023799004)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bH3azPoiHi7h8XQG6on1cTOYFTvjGl1tr0AE7P4Z2L8R+br2FUnA4J1A3bfunP8CMX8Pg7UcswKyFMujcJvRggxh2yCHfejoahiTHcmpDiHFQJSsLWIpYs2pY5lSWGrb+ATGsAu5j0a4MBYCOz+zGHvJ/KBZITS/JvPVj684kOLBb8EkGV1pF3/sRgu+2ZH6G/bxzg3mVU/uk683qpDhh2e3Vpx6zcl+yQBRMJzr3V3UHg3Blnp8S/tFcL+SMs7iYgxlL90bKdGFq4mKVIPhDpNM9FQMbQYRg1wyH1vTNtsHBNGDAlgK/vM+5klrhWnNEWuRQnd5gUr38snGsJlzeXyIlJ/vgsHh0YOvVK8LMCG/g7V38hkIS7iBAoQE/Rs9e+sFG3u8cwCkM1nIqyiTOafT2jnS3MwKt1WxibH/nq6AuvszopYyF//VGmlIOhaR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:53.7913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a6ee3-bc56-4858-29f4-08deef48e7c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
The connector exposed a single force_yuv420_output boolean debugfs and
carried force_yuv420_output / force_yuv422_output boolean fields to force a
chroma encoding. This cannot express "force RGB" or "force YCbCr444", and
diverges from the upstream amdgpu_dm which uses a single
force_yuv_pixel_format field keyed on enum dc_pixel_encoding.

[How]
- Replace the two boolean fields with a single uint8_t
  force_yuv_pixel_format holding an enum dc_pixel_encoding value
  (PIXEL_ENCODING_UNDEFINED == no override).
- Replace the force_yuv420_output boolean debugfs with a read/write
  force_yuv_pixel_format file that takes the encoding directly
  (1=RGB, 2=YCbCr422, 3=YCbCr444, 4=YCbCr420), validated against
  PIXEL_ENCODING_COUNT.
- Convert the existing readers/writers in amdgpu_dm_connector.c to the
  new field, preserving current behaviour.
- Add YCbCr444 force support now that the field can express it.

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 -
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 23 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 57 +++++++------------
 3 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1ddf5bc88a03..3524931451c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -857,8 +857,6 @@ struct amdgpu_dm_connector {
 	struct mutex hpd_lock;
 
 	bool fake_enable;
-	bool force_yuv420_output;
-	bool force_yuv422_output;
 	uint8_t force_yuv_pixel_format;
 	struct dsc_preferred_settings dsc_settings;
 	struct psr_caps psr_caps;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 825c3408763c..4304520d2484 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -147,7 +147,7 @@ STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 		int max_bpc = conn_state->max_requested_bpc;
 
 		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
-			  aconnector->force_yuv420_output;
+			  aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420;
 		color_depth = amdgpu_dm_convert_color_depth_from_display_info(connector,
 								    is_y420,
 								    max_bpc);
@@ -2280,20 +2280,25 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 *  - RGB is the mandatory baseline and always available.
 	 *  - YCbCr444 is only meaningful for native HDMI sinks.
 	 *  - A 420-only mode collapses the mask to YCbCr420 alone.
-	 *  - The debugfs force_yuv420_output / force_yuv422_output overrides
-	 *    pin the encoding to a single value when set. An explicit YCbCr420
-	 *    force is honoured even on modes the sink only lists as RGB/4:4:4
-	 *    capable (drm_mode_is_420_also() clear), as required for HDMI
-	 *    compliance testing; dc_validate_stream() still rejects anything
-	 *    the link genuinely cannot carry. The YCbCr422 force stays gated on
+	 *  - The debugfs force_yuv_pixel_format override pins the encoding to a
+	 *    single dc_pixel_encoding when set (PIXEL_ENCODING_UNDEFINED means
+	 *    "no override"). An explicit YCbCr420 force is honoured even on
+	 *    modes the sink only lists as RGB/4:4:4 capable
+	 *    (drm_mode_is_420_also() clear), as required for HDMI compliance
+	 *    testing; dc_validate_stream() still rejects anything the link
+	 *    genuinely cannot carry. The YCbCr422/YCbCr444 forces stay gated on
 	 *    the sink's advertised caps.
 	 */
 	if (drm_mode_is_420_only(info, drm_mode) ||
-	    aconnector->force_yuv420_output) {
+	    aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420) {
 		encoding_mask = BIT(PIXEL_ENCODING_YCBCR420);
-	} else if (aconnector->force_yuv422_output &&
+	} else if (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR422 &&
 		   (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))) {
 		encoding_mask = BIT(PIXEL_ENCODING_YCBCR422);
+	} else if (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444 &&
+		   (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444)) &&
+		   is_hdmi_ep) {
+		encoding_mask = BIT(PIXEL_ENCODING_YCBCR444);
 	} else {
 		encoding_mask = BIT(PIXEL_ENCODING_RGB);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 830cf8da06b4..c4b2fc690fd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3199,57 +3199,42 @@ static const struct {
 };
 
 /*
- * Force YUV420 output if available from the given mode
+ * Force a specific pixel encoding for the given connector, overriding the
+ * encoding that stream validation would otherwise pick. The value is an
+ * enum dc_pixel_encoding:
+ *
+ *   0 - PIXEL_ENCODING_UNDEFINED (no override, default)
+ *   1 - PIXEL_ENCODING_RGB
+ *   2 - PIXEL_ENCODING_YCBCR422
+ *   3 - PIXEL_ENCODING_YCBCR444
+ *   4 - PIXEL_ENCODING_YCBCR420
  */
-static int force_yuv420_output_set(void *data, u64 val)
+static int force_yuv_pixel_format_set(void *data, u64 val)
 {
 	struct amdgpu_dm_connector *connector = data;
 
-	connector->force_yuv420_output = (bool)val;
-	connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR420;
+	if (val >= PIXEL_ENCODING_COUNT)
+		return -EINVAL;
+
+	connector->force_yuv_pixel_format = (uint8_t)val;
 
 	return 0;
 }
 
 /*
- * Check if YUV420 is forced when available from the given mode
+ * Read back the pixel encoding currently forced on the given connector.
  */
-static int force_yuv420_output_get(void *data, u64 *val)
+static int force_yuv_pixel_format_get(void *data, u64 *val)
 {
 	struct amdgpu_dm_connector *connector = data;
 
-	*val = connector->force_yuv420_output;
+	*val = connector->force_yuv_pixel_format;
 
 	return 0;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(force_yuv420_output_fops, force_yuv420_output_get,
-			 force_yuv420_output_set, "%llu\n");
-
-static int force_yuv422_output_set(void *data, u64 val)
-{
-      struct amdgpu_dm_connector *connector = data;
-
-      connector->force_yuv422_output = (bool)val;
-      connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR422;
-
-      return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(force_yuv422_output_fops, NULL,
-                       force_yuv422_output_set, "%llu\n");
-
-static int force_yuv444_output_set(void *data, u64 val)
-{
-      struct amdgpu_dm_connector *connector = data;
-
-      connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR444;
-
-      return 0;
-}
-
-DEFINE_DEBUGFS_ATTRIBUTE(force_yuv444_output_fops, NULL,
-                       force_yuv444_output_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(force_yuv_pixel_format_fops, force_yuv_pixel_format_get,
+			 force_yuv_pixel_format_set, "%llu\n");
 
 /*
  *  Read Replay state
@@ -3699,9 +3684,7 @@ static const struct {
 	char *name;
 	const struct file_operations *fops;
 } connector_debugfs_entries[] = {
-		{"force_yuv420_output", &force_yuv420_output_fops},
-		{"force_yuv422_output", &force_yuv422_output_fops},
-		{"force_yuv444_output", &force_yuv444_output_fops},
+		{"force_yuv_pixel_format", &force_yuv_pixel_format_fops},
 		{"trigger_hotplug", &trigger_hotplug_debugfs_fops},
 		{"internal_display", &internal_display_fops},
 		{"odm_combine_segments", &odm_combine_segments_fops}
-- 
2.34.1

