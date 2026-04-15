Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD2FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899A110E69F;
	Wed, 15 Apr 2026 07:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAUF/zV+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0918E10E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm2N69dAG0a+5lza2T40ok0xQLfIxcDAO8pdFZ1wEQc/JYqR3HlbhLz0d8fn9rlVULy5jg4u14BHsScRdL1WwNA9Gd7q09QQSfdsziv9G9q0xYVE0/AvJo/fdDRdiuItQizT9Hzc8C4bXZmBRmYp8f6di/DgMdgs2GYMqtTSZ0yjUNp/yiLGIenBFuwnj6kfSpJgzfXmPOje3vMcAwQBNfrIrG0Lme27s5I6vprO1Hsu8NT7rU9afP+FVYsWRuuDI6QljlQixdI4txLzai4F7atGnrm0FHDNkM0dDCLfVGUADssqWzCpQY4x9J9BVNGBoynbM1AsJZNhzmcEx+E/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9r/2htXxexrDTGmjrPaqV4MxMR0P8483eIArS/2o8U=;
 b=TH2B4mklbiCeYo/FXr47yjFyNnO3SknEsFtJH/X8uGRIgRPWDnGugTW9kOGa2AUkSYxUuRQTesxw/KLTwV8mPahJiglu0OzU47TNS19TX8kUGYvMgcJ4vXcXE7lY1FVPkpCDE9LQcOOZsZilVPXx29MWEj/OdR4QR3mvWwmF18ZrJprtopbwvCs3frgNPtYoEJNegz2t5QjjtkBd1kRgv6r/xb8PsuJvlvBDIx9hnCzAnpFnJsuh6VvH+rFBDX6ilH7D2/Ir4pLTSV85rLO6Pjg7b5uLKta1KvrBBy/T3FSqf57BGS7a18kbxsqztaXHQNpvwJqfe/W/gKXV7VuKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9r/2htXxexrDTGmjrPaqV4MxMR0P8483eIArS/2o8U=;
 b=HAUF/zV+QJgakhfa0G38/6QTifL5z79stJ1w3fZG1Om/fHS3PzR6xawkyFXju2wTt6Mr2JTMdmqQ6bZkWRYjLH8hFSliVxuy/N4X7JeKB82K8fLgRrYKB+/sakmt9nLQY1tcKsxgvk3dBbykILWbdlG80bFZMxat2/FfYR1+h3A=
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 07:44:05 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::41) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:04 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:01 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Dillon Varone
 <Dillon.Varone@amd.com>, Austin Zheng <austin.zheng@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 13/19] drm/amd/display: Add minimum vfp requirement
Date: Wed, 15 Apr 2026 15:39:52 +0800
Message-ID: <20260415074223.34848-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: cc06cd64-8fb3-43bf-cf8b-08de9ac2c4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yFv6vpChrQUVwUclXXzHIJqjkUFGPQRxApBorTZ8fQe+rOnnSpJqj4OQk98PRjQmF5E7Spda1KbJI4UHl5ihgVshotc6Mw0lAZ5OMZJu3okYt5yZyKVFACWkwZGKDOEfPdrn0GUgjwkSr3St+Ob712UroCtFB1ie3lJNmURp122V/IvbyMx5Q9RnXNM12dk/8K0oldv8oNu+o3q4ydj3EgZ/j8PMZHAavfNhmKpKl4iTX9eQsd9E0whWwnrk/SUT6GaSgQLgf3eLPuhUz62JUeDE2vH9G8o1344aH2E4CCS41HQEY7wNlDuSpz/+rKpMst2f9TEtopmxPxo3uqD92mzBEQSgRvIYV7i3KEGNClE5w4utxSa1sOEn6HETqwLE2z/p6+d+xsmvnDX8A2hBNKR95bPEMNqh0dqvJgKg4nPVXP7iZtB5c8zXQrCu77YzfIK0vxNsiOFWND9BCyafH/OakzBkV5D04jXnGxkCoCZ6XM9fqtgfZQUJMlHKIfHRPKmdzuoqdIUmhX6ddWL+GNRA5k8wC18H46M/QSnFHqoEfjUCVQtM4IMirmcaetrM/u0m4B4XoZhk80QenaKYVAy83BJA7m4TVazCtBtFmmw4fgyEzLdjf0GQDk03IihbR/4hhnk4Ti0+s/1fyP6yXpx730hKQHNxwINTDFTngw8TG1P7KdQvu/iJAetw3vNbTBgShwFNY6E4IEkbYbLRccADUNvMCZ5c/MeVgT9NLFK9WVRTCms1BCYUryBuKlHkVuVbIpmOFAQb3PumOifA/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VV8+ZZLjSgfz4ks+o8GW54s+/JSz3q84JHsN3RqRz8Sp3DG6tXRxdM8mjtBmvEdATAiI+Qzc8/ls9jG67bJHLP2hgwEqdsG6/rzzo4XjPuK4vbMCNjAQUFHUvsy/YwC6yF39HoFjCKyE6zphWbQLk4bqbMAVP5sVYOyLn5Hy10uu54i1HdHk6QrnsxCh17x7Lw93gmaIUKPUEYyrhj6JGxGLU+D9j8gEQONHC52dmj6ySC6yZhxtsMaKiArhbUmYa/FSqHuK8EBiLkqvokA6i7skiz6V+NINLH+5oOMbVgkaiMyzy0P33kTS93tZSNWjnwfrLXhslRfYrFpFwdk3Cdslkf8shjJcH6RRVLwt4qNPso/uGUj3Xvs5MHmExBc0oOaShZB9j8IgzdQ3k9QOyOP70t/bEj3edUMnUAg0eQz/K8iM2yTbVeZGNM4VN1xg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:05.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06cd64-8fb3-43bf-cf8b-08de9ac2c4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Vertical front porch (vfp) must be greater than 1, and must be patched
if it isn't.  This must be done pre-DML so the DLG programming remains
consistent with the OTG programming.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/dml21_translation_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 476030193f14..9031fd582ec7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -90,6 +90,8 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 		struct pipe_ctx *pipe_ctx,
 		struct dml2_context *dml_ctx)
 {
+	const unsigned int min_v_front_porch = (stream->timing.flags.INTERLACE != 0) ? 2 : 1;
+
 	unsigned int hblank_start, vblank_start;
 	uint64_t min_hardware_refresh_in_uhz;
 	uint32_t pix_clk_100hz;
@@ -97,7 +99,8 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 	timing->v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
 	timing->h_front_porch = stream->timing.h_front_porch;
-	timing->v_front_porch = stream->timing.v_front_porch;
+	timing->v_front_porch = stream->timing.v_front_porch > min_v_front_porch ?
+			stream->timing.v_front_porch : min_v_front_porch;
 	timing->pixel_clock_khz = stream->timing.pix_clk_100hz / 10;
 	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
 		timing->pixel_clock_khz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz / 10;
@@ -116,7 +119,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	if (hblank_start < stream->timing.h_addressable)
 		timing->h_blank_end = 0;
 
-	vblank_start = stream->timing.v_total - stream->timing.v_front_porch;
+	vblank_start = timing->v_total - timing->v_front_porch;
 
 	timing->v_blank_end = vblank_start - stream->timing.v_addressable
 		- stream->timing.v_border_top - stream->timing.v_border_bottom;
-- 
2.43.0

