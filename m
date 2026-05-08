Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A495CD3445
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAECD10F5B4;
	Fri,  8 May 2026 18:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AY08Zuh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439A310F5AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0cIIp/o8nbiuWMzjZGsnEV4e2tDHK4anItUa6iZeAozBcBa7HcO+2A1DrIWXjHDIZ7sKvHolPG1Mopl1rakoGg/SSm7cfeH51TLSIPSPTjnhsm8UecEHvf3nX4q6SslstAkfNgngvf0wu6Z/7w//mgbJfw+pzyEvKyoihN+spa+Mj0VR8l07Fq+AYcBgE1Xf1tWu/j/KlPzdeYmuD5M5qlbMV+Qygt9LZpwNfAvMJ5KEpQKMa3mQp3fm4ILAOVRKK0vj4QKyqViLYjOSLoxljFpcY/V/wcLDdOIudMN0hHmk11G7sRiMiM4i56HTMtOtbQZORlISOOf++4MSaAH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6x0cSk0ojBXIoxoZjv0k9b1RU6hTfpGpaLo3B4Kcjw=;
 b=KS8NdJq9Nf88KGR/kulc2hpV1j0zU8zA+/WTAwbDOgdqj2ReSYuKseODs+OcBa3lm2aWSIeCMQAlUgJxp0fnAp/Cx4PBb/Bv5mUEJGQQhwhcGKiYyfiGim4XKVZyKdOc7954c6SM40MSgYyB2uzNraN1Xnt/eaEgzPlcDcx5UfzwDQZF1dWZrUkytFL1Bda/sDVFDWQXEv92ycu3g38WspRo0a/5tRhEm8xQ2d5DKL4QczdA4kt3FUbgC51/IYUEiPbwWqalgk0jhe506Fq/OGK8478ap4RxAszvuqKC0pkhEb3r5arseXwrSG/RXmEea186Uh7aClrJrcLJloKqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6x0cSk0ojBXIoxoZjv0k9b1RU6hTfpGpaLo3B4Kcjw=;
 b=2AY08ZuhTNBhuXx8/WoSSSBo0bMnxtOBQFe/2QMs1BUFSYUphyCA911x0iGGHdVeyzkwxmQ+sWA11o0+C/0OTHcU5NMCW8ugwRR/z3A4mjhY5o20EYGyfVV0gO8vCECQxT/ix9weJ9WapShJ6CqGAWmpwy6sLQEQyehxMWNkacc=
Received: from MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12)
 by SA1PR12MB999085.namprd12.prod.outlook.com (2603:10b6:806:4a2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 18:28:21 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::d) by MW4PR03CA0007.outlook.office365.com
 (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Fri, 8 May 2026 18:28:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:19 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH v3 12/14] drm/amd/display: add HDMI 2.1 Compliance Support
Date: Fri, 8 May 2026 14:28:04 -0400
Message-ID: <20260508182808.520863-13-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508182808.520863-1-harry.wentland@amd.com>
References: <20260508182808.520863-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SA1PR12MB999085:EE_
X-MS-Office365-Filtering-Correlation-Id: aa76cb1e-3845-425a-4ad3-08dead2f9559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: kaHlUIqrG0UkAVN/JeSS3gxMiUcBtKuN02ttfNzCWbVSUn3DP4k0Od0ElMp5REt89ijcJ/PrMQ/S6mB+Z+AmEhJQJ6Q7GZnzaza5MJWBsolAm0xtPySR+4FaMJPVYStnQfUdLEeiMg4n54c5I0LZDvJongONIdI7DxzBJdl+3GLj9xUsoApBiIOla/Hko7WIwCKoM72lgu0kYR3SqY7KJfX7+lXyTSqVl0oIhMTKlZnvV9ECbaf00F+RpjPpSwIRkF5VWD7g3qPDFsZ8DsnrI8YUwZ2U2uuVqcNXlHz7yzmp1bheZKit4q2ll0O+tegN1t7lgEYESV9OOcBkrEDkBufUvfza7bZL/nKE44dnFYoZ5swRyCd3ZCMDX8D2cqemonOei9FMZqITRM7u4Ae8fsHDfXxuJy4JgzJjQpiBn1YN5061yE55K7QA7UHvFnwEmmuj4nIGaJlNOX91LZ69x85XGO2khLX1RIvUKfsgp3nXqg9T8gAFuj5cinWTK8I1eAzaWz7ilItBbNUEVzGe6EFXCSp0DXyA/GLcsfSCQjpFziieFYgGVl7PDPCXxuOPIIGUvkcgLXN1tqglvBsZZHenJkEZYJl/0HZ+Big2JwtJ+SZGQoSnbfAQ9Kddx1X/nyQU2IbFDHw0I64raQ1pzqaieOnvkRai7wbnacmq/UGzjrSp05WpZR+mgLPKqezTOOGfTN+8cD3grosElrMfDdzgpNP7CJ2CJA5+5ZSdNOo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jol/fF4Jcxsz29wFuO6J64C9I/L89lydudwkc+b8L8vHmzJSTf6yZ558LhQyWNHboRek3qUg/qsY+S1FmXkqW/hNiSj8Ap6Kt2I83j7Plg3cAPqFHGGFt1FCRM/LmxtbUNRENB008FI1uiOqFmwYzT3zqbbLtluDhwBznIBo8FP2UGOs2+ntHFlt1vAA4C561aBhdCQytiednbjwjfZ/DGRO1s7UnOsN77WPHffrIGPHy1/a50FisEfwu83yVDtk1j8px49xW6vCWwHYVagf8J/g3YfD2N7QKbS7l7a5SBckGQU912ZDPzizkcWUMHuNMBeVGjIfss+10hpNi07uwHHiI8gu6KhOJaERIZgisYoq1KDwv1KPXNH/WaLfhQz5A/QbO6iqN90l36ndwCQjWscInUImJTgKeQ4alfLt3iiVTlajayZs2cOXjB+RCHUb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:21.2583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa76cb1e-3845-425a-4ad3-08dead2f9559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999085
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

