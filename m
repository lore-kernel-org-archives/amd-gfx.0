Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50775CD4F43
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96C210EAD2;
	Tue, 12 May 2026 15:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QiggREHe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D8A10EB28
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcdYLoFlTGdDVSNEWt/n2JnQwer2m74CkKWKSX4hE5TaU5VulKesBuXXiSCfL+rfEgFsvV18vGsCP5n6reC7j6ProOVXNL4W2F4QxR3dnt2X9IkPdojaH4KSwqTJqrqdegZ+x2pCC9pmlwmNnuSoPiGKTU6IxOaH8CS3/rwmOZrnkSSr+L/yLQMC/MR3TWbS1sDbIaXWxKPrAGi8seKonpeVUnNjw7CS5vllAH6C8Gmz7X/5Pnyugs/mYh9GZI9sDgSveM9ZCT3h/V6Be+wywrIYcYdgsVI7KcaQwjDg+IAXg6oKellwxNTKmMD/+7d2IAP2lcKfe8w2Iunq4zmv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pY5XKC931qf48OkYMvma0Rnz/ZIp8LvWKyT1Nb2vyt0=;
 b=TZ47IZBaL/3oMX4JQTPbU6/DJ1vFo8yuwo//TfoQeP5fo4eFilJK5ozVlTnABgYzkEoMAiJbgPzyPIw9mu5TqjkjCUwqDzJ0Xhz5zd2n6DafJ++6Nd2LHl1AjMpS2z/9Z53vSGSqJgvAlCyxfdw61vQPD1yEpRsyWTwO/3Vio6JTqTn3cpr5uJ8+QOT0JqEOx+RRRVnQPHK/BqptIHunZWIoKZV2quLxjcIvJmWEyQKU5Iyt+OHBX3pNpkFPBEaz4Y91VNCrjdeA2RzlKUty1bjoLf9xLyLJPz/j2BihrhcAwMQLIrozdraP6BXwngV9uqsd1+Iv4RAAh5lpOco03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY5XKC931qf48OkYMvma0Rnz/ZIp8LvWKyT1Nb2vyt0=;
 b=QiggREHe0FeIxKcQC+k//m34uNjbMhNd1tJq8DpujhFTuMKeFo9gKX+O5G0DQ56qKTlD9S3+BP0/b/ivllbRExrRrYn7EPKBsRnguMDWaqHtxByRf7hq1ROeMMDOOLnb4yG4I3PHISPl+Gbu5Bh0YGYxCWBNcr8NAw9TM4Qv7q8=
Received: from MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:52:56 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::54) by MN2PR06CA0016.outlook.office365.com
 (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 15:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:52:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 10:52:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 10:52:55 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 10:52:54 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v5 12/13] drm/amd/display: add HDMI 2.1 Compliance Support
Date: Tue, 12 May 2026 11:52:43 -0400
Message-ID: <20260512155244.403854-13-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: d31d0d26-a1c7-41d3-4a56-08deb03e88d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799003|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: REb4pjt/ys3m2jpnL1byxt1YfYATBQodK9oUGaXSB7ZXoyTqRDmBrqKTHfPKx1hzYz+vmCTxJcTQ4sou4BPSeERtTsq3i2VrCdoxq/ScsRXo4sM+JJWJGf6x4MYk4nII9RxTpDhlwMCAeYHL/b+Mr9fY07vHZiVk0RyQhYX5JVGXDskN5LC6H67ejpzbH+/AD4X5km78ykN+mrX0RVajPw1uPpDxJkjamVk+BAoKdiJUXqAurGlbNHRNZgn4lj8qIpLs5iN4z73uYzGdECxRZ3AobDE9t9UbDqjT8zfz4vB0IbWvw2/Zpjck63jNDJ1cego4yRFlUb0cuR9jyxHFZ6A8RLfnaa/qM8geXcWcA4izLLCbaJu57YTWDthAKJOfQTY4B30NfXyV6zYM3gkTexOgnDnbRyMCxT1hZYXZWEosBl0sjcZR0GWrwAIE5OXqArCCFgaVzIFJgsSPEhjEblCYgpe2EDwzTjrWqZM93FQGuVDECpxH9LKOD/X+GGVdA1eAL0nvL4NH3JG1YqYqfAXdwBlST/iM0mjDaI0Ny6Jg39UvB0vpyqXgEDRpqUx3afyG6s1nfZuD8Yl7y92ZFMS1ht+tgmVSqxEhmcc3RtvD8brjqobRC3Rzov2L06+HQ3XJXnOoCsceZghusgcMXdwCif0C14/z+rpRNA3P5cVV8WA68VY9Hiv9m8/LNcvwPULb+B5RJ9taIMR9zjGltmG8xgZCwVEiod5HDsnW0Sg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799003)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zh6QEXqVNuBudk+tVeQTQthSC0CoTWZFBZwKlGG0xJl7S0gITUwpC4cp7GOUHhDh76I7EzRj7+3vRUGXI8US+3CSGjsZwIJr+RA7aFYsz4hL+9Gh55WvygK7+oS/MV2HloRCT4HNVIymoAlFX0WysMc7HpIbg4ECpbOahLBoGsDce5LNntMebbJEGhgGiyutQpXJp4dw4MwscyqxesdvbFgNeB8mxI2aaVexNkY+pCk1t2S1XO3XXogbDyyOX7RnSoa02+q2wu9kI7NmjOZeY94MbHZbDLxHKHB6BuW5xvfsmKDqj+h9P5ukwAJB9AdyNa3q8AiMPGgxb/VslRrXGP0T+Y/2cAJa3Lc+WTPabMYkmEKasSR60ENpoaFSpZ3thjUHxBIMXIyLpWgbc5pcZbf0pZ3QecSDY6AHWjA3h/dwKQYbihATTGxMUQMvFa8T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:52:56.2639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31d0d26-a1c7-41d3-4a56-08deb03e88d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 ++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 28 +++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f7df05202de..f262c63c426e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6937,18 +6937,26 @@ static void fill_stream_properties_from_drm_display_mode(
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
index 4e68a3541639..cacb6f63d9fa 100644
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
@@ -3605,6 +3631,8 @@ static const struct {
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

