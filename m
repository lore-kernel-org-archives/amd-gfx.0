Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B17CD37B2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 15:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C5410E7F3;
	Mon, 11 May 2026 15:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjXfO3aJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1A810E7E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 15:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5/gy7kZfkaydVLdLAGoSN77Qx9PdRZRovPU1Zi8xTErJy9yN+71JCCc/KovtqSE9Tdwvz5J2/wfVtqyHqG81eocUL8P5hh8yjTEavcrMcrF+2WemJSLA/ZAGIGAUVsCRkxLAc3QmyPbXVeAit041jdM11q00HTDB8VAIi29Zn5J7aJBSm/rnf0aGIMxDVIz3dSGW338rmXwLf9CgXdqSySqTZ/mhMNn9rbkZU74G0WPT5v2D4h2aEWre0SzOO9EBpJaBZY1So4mh9MKEmu4D3lT7yfU0B7XHFPrwR/4VPvoiRODTOIaeLnMzUAyiO215T9WLngGTY6k2VF15A8nXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6x0cSk0ojBXIoxoZjv0k9b1RU6hTfpGpaLo3B4Kcjw=;
 b=bOPbopKxwVAFrn09EpzsjaFD0ma0kCwAd4kBexzBuIIttopoeOMTm+9MtpNoYE3TonRpC53ZXUenni/zCiHjBPJodqlpJ9OTu7ZMPxU497NVkJHHbHd/2LLGQXEidWV8ef39twJ6a1UaBi0Ol0dnugmRTBXJhbOld+yZ76NJ4kdrFl0d2yIInRhwN85Q9FaF7ZejevivsIarOfwLAnQBCDkAoaI9GIbEcm/95ONbAbxe7hZmTipAFF3gPzBdcJrbWt07k/3dCw6o49g7lFvoCX03TjlU5XGBB2m1dtvl/qERyy+VIFSbDmPBWSWDFMjnGN/Aq56dTC9L3RShOI/tLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6x0cSk0ojBXIoxoZjv0k9b1RU6hTfpGpaLo3B4Kcjw=;
 b=TjXfO3aJOU1KZdm2zyl2+6djbR968QPEGgULpMhvPgliat8AKqcGF13S0yDDMCm6gkImG0y73unCnnY5wIz2eh5z/0d3TTV6zVw3a/FJ1q5LNkbc20J1lH6+xrir2R5q1t7EoYJM2JebS5S4r3i0qB3+mGB+sp5DaRDUwPHFvqs=
Received: from SJ0PR05CA0137.namprd05.prod.outlook.com (2603:10b6:a03:33d::22)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 15:52:31 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7e) by SJ0PR05CA0137.outlook.office365.com
 (2603:10b6:a03:33d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Mon, 11
 May 2026 15:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 15:52:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 10:52:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:52:25 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 10:52:25 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jerry.Zuo@amd.com>
Subject: [PATCH RESEND v3 12/14] drm/amd/display: add HDMI 2.1 Compliance
 Support
Date: Mon, 11 May 2026 11:52:09 -0400
Message-ID: <20260511155212.73586-13-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155212.73586-1-harry.wentland@amd.com>
References: <20260511155212.73586-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: fb881189-a77f-4f71-fbbd-08deaf754f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: ipuM62jZSQWXyOmX0vOVAF5P825nUs8WGI2Gv08Rz+ifksh3K+1J2aVLG9acHgqqVPPi0iCF0yGr5i+85/QzZVPVfRUVhTSXjIc3tIn9YsY0BRPAd3lZSxFsh0KEm/xeQYPT9Y0UNMl4I1xJvvQykIqz1U4PGq+6MDNfrjEXPLcoC5B/ZTClSo2W+17fxgJ2e8upXyRUzVxdznmausD9RmSpi7pOlaPMOONt9i3Xr7ENGoHMLGHxOKvJjeeAVdIXKFKfAzVoh41ZpwnSx/uQ2E9PS4G9wuxhXuEts1J6MfLUPyTyOcZT8NWHuG6aSj7BvXpMdAdBChjIVFoibAPgBK6odGWMhKXP6Rhrb88OE/hSLd7geAYkLG7WFURwwD4V3s+BYvYgpXcGFDpijt08GZZEyyPo7jY5AXvDcY7Bngbi2LklMfE4w1b9LOGWAZtC9p0wz0H8tXdSh1/FSMcqXjP4mLx9vzQQEoOutw5o+ozueOIxq7eewEBFiMWL2VKuBNGzt3y7ad8vXCeyoX9kXxHWnbC2X4UarmpyaEzMxaeUhid+u3HO3uWiu45fyGxYdwZFsVehnspmNziS9K0o3nFz9jueBT4npGa0+xuFaUhkCQPR7PTuYmJVU85Dh2CxChRNuPUIc02lh28gKJ0gyYurGTITIGK8RSyu6Wq8axrj2fbCxPpX+ty9p5cJT1RUxJ2NEg7GiwWqdAOpx/sYhvxstISorGnPmFnokVCXcaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j1lJaXqefm/RCy7/xsUDhsEFaIYIVY9ZBSwGp5THwukklVXS0e2Q+d8oJGmIgifRdy3dqQScsm6F5DFHzLYXEvaHONYhZl44qEdwtqLwy+FUigdgRJg8FXleXkyAmrvibIzFuj9wnwo30nW4IZphaPgDjr+RO2BtDpcJzKP0+BKNSKNcMk8PNnttNlKlQ2KkGhub+sFipp9sNH/9C/klM86gU8Cg+IRzMPLo2vF28QAkKNCin0pqy0tmSUVPFqLMjM/cSuEle+G8qd+gxT9DXaUH6JKF0lc5JHtuwmCleQRzMyLU4JwYp7ENig2z1Y1i1rtEJ2WVIzIdVVuENW6MPGVqOfQGAEP79dao7QoNJtpJEBnWs6vCcbcu/RKdOZgPWTNl/yCQvY3nn7EcFjy+gdV0TOOizi4WvuGtsX5sF5S8EgwAKVY8NvU8FSFeLlGi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 15:52:30.5439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb881189-a77f-4f71-fbbd-08deaf754f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
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

Add force yuv format from igt for compliance test.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 ++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 28 +++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99d03cb536b5..be4b66b00be9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6933,18 +6933,26 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->v_border_bottom = 0;
 	/* TODO: un-hardcode */
 	if (drm_mode_is_420_only(info, mode_in)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
+			&& aconnector
+			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if (drm_mode_is_420_also(info, mode_in)
 			&& aconnector
-			&& aconnector->force_yuv420_output)
+			&& (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420
+			|| aconnector->force_yuv420_output))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
 			&& aconnector
-			&& aconnector->force_yuv422_output)
+			&& (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR422
+			|| aconnector->force_yuv422_output))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
+			&& (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+			    stream->signal == SIGNAL_TYPE_HDMI_FRL)
+			&& aconnector
+			&& aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR444)
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
 	else
 		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 8af11bfda6fe..d871f7f6b233 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -850,6 +850,7 @@ struct amdgpu_dm_connector {
 	bool fake_enable;
 	bool force_yuv420_output;
 	bool force_yuv422_output;
+	uint8_t force_yuv_pixel_format;
 	struct dsc_preferred_settings dsc_settings;
 	struct psr_caps psr_caps;
 	union dp_downstream_port_present mst_downstream_port_present;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 49226d6d0311..f10188e567cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3137,6 +3137,7 @@ static int force_yuv420_output_set(void *data, u64 val)
 	struct amdgpu_dm_connector *connector = data;
 
 	connector->force_yuv420_output = (bool)val;
+	connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR420;
 
 	return 0;
 }
@@ -3156,6 +3157,31 @@ static int force_yuv420_output_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(force_yuv420_output_fops, force_yuv420_output_get,
 			 force_yuv420_output_set, "%llu\n");
 
+static int force_yuv422_output_set(void *data, u64 val)
+{
+      struct amdgpu_dm_connector *connector = data;
+
+      connector->force_yuv422_output = (bool)val;
+      connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR422;
+
+      return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(force_yuv422_output_fops, NULL,
+                       force_yuv422_output_set, "%llu\n");
+
+static int force_yuv444_output_set(void *data, u64 val)
+{
+      struct amdgpu_dm_connector *connector = data;
+
+      connector->force_yuv_pixel_format = PIXEL_ENCODING_YCBCR444;
+
+      return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(force_yuv444_output_fops, NULL,
+                       force_yuv444_output_set, "%llu\n");
+
 /*
  *  Read Replay state
  */
@@ -3528,6 +3554,8 @@ static const struct {
 	const struct file_operations *fops;
 } connector_debugfs_entries[] = {
 		{"force_yuv420_output", &force_yuv420_output_fops},
+		{"force_yuv422_output", &force_yuv422_output_fops},
+		{"force_yuv444_output", &force_yuv444_output_fops},
 		{"trigger_hotplug", &trigger_hotplug_debugfs_fops},
 		{"internal_display", &internal_display_fops},
 		{"odm_combine_segments", &odm_combine_segments_fops}
-- 
2.54.0

