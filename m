Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3F2CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6308210F546;
	Fri,  1 May 2026 14:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fORywa/n";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C280310F552
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 14:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvRBZFRSBDJwxtgje8Oblp7qTRMZa1SillZsE9Ppx6AB45H8bjS0jTFa8HG7GJx3uI2Q4Q8fgtvlg88Y/5foX6vJW4H/07kQBPWxgNmPa4EQ/P7RIE8K225HS9CavuJDGxy5XJayl3M+SeTMojZtXEDXe7VgnexPipsweYS0cEr6SdMHnHkT3IimW6WrUnM0fwS3osvelb6Cursdd32kqj2nPSr5PZBv7AiSni17VZ/jtedL94L33hzThMuRSa5idlTHy9jHydSc3Zmbs0bZBoQT4ghRQu6bqbuwo8ur+zLwtQhLWUpcrhDxsKemqj+Djh1/Elhhk2FuMv0zEUr81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUXHHnL40wNduDLIX+uQ8jVKO/QlP8Un1IZkhCXV7L8=;
 b=LU5LNtum6M0PoLKfbbtZK+Mo9i3PaZN5EzlcxAi5aA3Ob0fEsifkpNXEggPXy009PeGH49XRuoeADugQxXd5xydDrScXD7XYciybVmBVwewxYg3HhFtDqCF1wq9MCG+yU0aRK/SdoYufXbB1vvTJQDHuK4BLRWepexQjvxMzXqnC70H+l2hpHTTNiFHjo/3Dwiy4zYK+5sOlXmxGDmkM6tyeTdjO3+MCE54LpPGThxDUy0ZyKAHt2iNIB1UjNG+ovWYVv1gsVqQZMGiq78L4nEcuDTpNjlQk/0klWb84zJixqB/CWn+3e33X6EGXukZPBwUVRW6KTihyAi/YRZ+Faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUXHHnL40wNduDLIX+uQ8jVKO/QlP8Un1IZkhCXV7L8=;
 b=fORywa/n8V7FT0pG9x/WiQ6UFrj8LgSWaAsjmDHe6HFOXCozYv/MM9Uhazur7noha80ZYBAqdRH+7ao0XP7jiJ//mkQIw10Ed8qNhJYwP9WA1fqniTfHqVss/bltyX0eQSAV2PukTPG0XHJEEdURsgqu21b7qM8k8rnOu0vtJpU=
Received: from CH2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:5a::33)
 by SA5PPFE494AA682.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 1 May
 2026 14:05:11 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::70) by CH2PR08CA0023.outlook.office365.com
 (2603:10b6:610:5a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Fri,
 1 May 2026 14:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 14:05:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 09:05:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 1 May
 2026 07:05:03 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 1 May 2026 09:05:03 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 21/21] drm/amd/display: add HDMI 2.1 Compliance Support
Date: Fri, 1 May 2026 10:04:37 -0400
Message-ID: <20260501140441.41068-22-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501140441.41068-1-harry.wentland@amd.com>
References: <20260501140441.41068-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: d42e0d2c-de06-46eb-ae86-08dea78aa8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4HkkUBnpagzHTAmld0a5he2j/ojhcBl/cTSBlQYy0Twu5RT15hO1H4mQ3ygcgE6QoyRBf+FTgg3DondQpA5e3MAYt4t1iX/uaN4p/0B5RFZu6F2QHpdrLj8ZPNC6kqsWgM+1p17v12uwK67/6gjDnvKdNqQYNReQTK77VQ5g/HSXxq+k2HHjZ9iXVypcfkQ0rdOnQxyw+2uhCwBeECBgfplNV8M4Utw4w7vLZNkQ4eYbRWc8Z7wlOCaRLTp1eUCvYnuUvC5gYq334ql4saQSNt8xeIWzQmoELv13lh7AAZcH4WgdMgM2vonV/IflRmArbqcNzaB/u3Qd+M9JpB62axCh7G14XiWNMSVSl7ZLuyH5LjaTlCS7/exiEiSuEB+NvHiMvlXwc6UYW8W1+rgiJ14CuzDDOxhxK3jOCa8DEP+6mQgVh5CKmJ/rrPqh2OhW2h/868UyQ7qZifNB7PVucAx26BA/lAZoscDcbaPqppgaYvlKzI+J5eB1QOo8UnIdCtC+ob1VCzVa3YKabK01+ZJRpXT22pykZdYhhCKLiy6VYskgR4sKullvt/W6hCWkMBvlgHKhF3cYoUeL/XAMFn1uOy5EMTHtWzEQYL+HmiI1rG7myMpQaSISOyqk4HNvbEppEz9PqsXoqMP5iN5u6Pa912/n5IYQnC70Ogvl7otNL7yozJnq3xONJ5TJqFg+TPIvduF5SZ9TQ3UMb1wctVII6Uqt9t3lGCXgWVTL5xQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T3ajD5t4sHj7GAL8qs5ogN1kkDu+j114sgwihwHPjrAVhTZ2hMmh3RlyAXSdHSPKmuIISlRgbOPSDfOuC1DJ9utvKgR9bdXYSH4MRid0Kb1IjMIpEWviho8pyoJDRX8K9w3+Bq4ijoo+MY+W/ZAveS1dySzCmfHz0VZzhfvNxP1ap0bcG4AWJX/4gA7TBKkRT0DPc8gh4YQ9xld44Y8WiJWrBQTamQTZbkBIK9C9XSyr39laQJr/zZSJX/0i5cyZGFzYfEO3RFjDRRMuWSXRcbqjCnbUWDfArpu8iKvl2pp3x9ZmntR2aX8KUgXDOXQTrQs1FG6kKbliYT3tDuP2kw2qg8lFZ673wLmxzFChKFVXbX308hho0tEaUHzc72D+F7vepnqYp7h1/SMLt4XeB6nOPuKs5U9cFwBk3KyPHDxVgU/eYd7neekdzATptFnv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:05:11.4057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e0d2c-de06-46eb-ae86-08dea78aa8ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
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
index f998a22b88ef..a9b3aaff1b77 100644
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

