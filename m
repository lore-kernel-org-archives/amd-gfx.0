Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F33CD5BB2
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 20:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7C010F15F;
	Wed, 20 May 2026 20:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1sOdQ5fY";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716D310E39A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 20:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3Dw+3mReqnKmv3iAh9TBgWSkI1TDQXv3BYOp8qOxqsKNubPnc8VivewFzjN/5vZwqmj9GcvvPPwP5vj+vlqNgIJYwu50zRnn1p+/yVKHF3XVS2hs0AXb/TcSMVtIa6lyg33cm0lm1/aOahv3gFrft2mI+JXIFoStu1oUHFgrYfhg6pAmd8j347NuR7JTx9lM7Far31r13ShTvbfNJ0f28op3ClnoViiZrKUcZF9kYLhaI280IVi0O2pLZUaccOdEu++2TbBMqoTL0yydwp5LRBvklF2cIXfEiGyOy+/hAtGV7UaI19qCWLXWWtK6At2gxLKjZueVQvSDkFZzYqKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp5ZDgX5K/+BkAapZ5mkvqrdb0j16SshO32rMqMFawM=;
 b=j4HAZ+3g792P0+YHoWub0ye9nlq5OxgdX3+gTsDbPN7GnPrKVOqk8C50AXcEgKq3u5UY71xQPHqZq0BJHmiLT1T61JtYZZi/0IYqP8T5upZqn8TP/QiWRE0UrFldEhbhqluIWRtKzl8VJKW6KPyjTChhw4VhjJ2QAbmUqEp1A3+O5pPgNA8XUE39Yp+UKs3+I96b0Xmyeio3ZmfdS4BTWMFyeOy3u4DSU96gI2vGND0dDt/wbDk6cw2l0Zw/XcB0DpFF/6BVi6cNFGkbWDgN2Ay5xPb0+EeYQf82oJeuiqBVB0aPRs8VygpXCaUWpfA78cSDThKGDRZr1gSY6rEk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp5ZDgX5K/+BkAapZ5mkvqrdb0j16SshO32rMqMFawM=;
 b=1sOdQ5fYp8w+ejml21v0pqX0APHSAafowIeGjOg0SMhdQRsiu2vab+96Uw2AvSnDZ1CD5ubhx0AKz6gRRt4YHiO4lvYT5qB+j1ACT7qLSGAR+ElfrgmVtA/5FG49oCkw3WvCW5+aU1ZASKcVaLjuITMoaz0NnPLhAwx265RflP8=
Received: from CH0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:76::19)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 20:29:45 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::b9) by CH0PR04CA0014.outlook.office365.com
 (2603:10b6:610:76::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:29:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 15:29:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 15:29:42 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 15:29:41 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v6 13/15] drm/amd/display: add HDMI 2.1 Compliance Support
Date: Wed, 20 May 2026 16:29:26 -0400
Message-ID: <20260520202929.555119-14-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520202929.555119-1-harry.wentland@amd.com>
References: <20260520202929.555119-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db613a5-da0e-462b-bda1-08deb6ae8639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: IQe2q2wUtgC5JZODz+5jaV5LeB6+EI6aOz18eclE+cHr90fw+Kh4cXSobR305TZJsnd+6x/BkOKbNfCU9MK/w5Fb+AiRuYKB9Ttq/8CWOM0N0wgV2s+t8Ir6P/C+7fO3y6vvSS2WAAeU1MhUvnyiWwLNTEXArdad6g7jOa7CdIgX6fZxyCKW8baq0L9gFReAyuD5YqZM9TwRRD9FXSEZR3h/Zi4AjbgSdoxIILqSxCQUfQ0vV3IVrSkmHgUYSWlDx7Jj5O7on7YJBABPwtJ7UxHyZwrkWuA7ZXc5FkTT8RauaTQlW+2je3iYlOJxma0eFx3inRPrWHS9B2iZQjsUWhw4YVPocTQFwpbeKBZFsyGGeoJ1TpKblTkDdbDprmDLqV+RSzOa7USAJNvS/nMBCNTM25tVx12uOfx+FMPBzterMbM9/4KzWSQfaShbe9npSByL05kvFUwSa/4INAvBL4DQ0OxVV3hQiIo5UytUGFwC67NCh2sbrIWHAv0/scsc5V9flirWEJ9pnwgW5Um/AhOQJYybmg86HbvdT3hZKlG6H5iXXnLeVwqYioq3fg5380sIVgMWt0U9GoAmWtcK4grmNv+fVtVw6gwIzVFzks+pQfQPgBr8WV4zYCgsoIZrKjHIt3gxThlXhwbb2cJeZ0TbUgPC99+Cg0uZaS9dmc9bJTb8Jt/R0VbupFgQsdJAqs/RUl8vci3cc2pu6mpZ7EOKVzDIQWw/RRgaQX0qg6A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QwxHntt0LsRTWHq6QGpH7PmdgiAyJ14BSmFkAkvnc94gKW1Ambgq/ajKchyJnWp+2X5jFJtPbW4edYn54qyzFoam4ErBv57KUyo+GbBO32oPOaTp0GLP/bewkzG5zYK5UaOZs6Qu1lztCdWe8yo5m4ujQTd3NJThBQL0mVrRNrSt7erAziNRIdizpoSJht0WQlb3ba4ZNu5snk351yofMxyjNy6Vjz4D1Wt6BOQ2iJUZR2K4TpAjSxkywaM2RLvGIDgP39Eov9/8fv1tGlSMrm8MocHoSSzPXqSP8Eu/LT2tCuSIv5HWsVmtuOGopMvpAQ4uhK3i7tsDdaGfO2gE1lcP2MbWP0v9AfN731S2XNK2ezILx10fB/zxWI0axj01ER80kS2d4gaYOeZw5BGsPWspcbEX3tKfy9EGspUGKfEl4sHaC1FwmjkdRJEiJ/do
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:29:42.5348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db613a5-da0e-462b-bda1-08deb6ae8639
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
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
index cb93b105f63a..10bf4451d4de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6956,18 +6956,26 @@ static void fill_stream_properties_from_drm_display_mode(
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
index 3f05036b6624..5efbcf6eae86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -848,6 +848,7 @@ struct amdgpu_dm_connector {
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

