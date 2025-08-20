Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5901CA0EFC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C691C10E7E5;
	Wed, 20 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G05PsqPt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2367610E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh5d5g4YBGlLY9BDuE7edAlrUhiRpdlSjSi8mcxRKMDtxp1luXWlPOuGYXncdY9r8Sf1sfejl4Q9iUnd/tg4WbidURjEBhjEvXQE18S8e0BUQfcY2Ps/PMMO78BNtHvcXHwgFS8/94lX0sIve8cilacKfIskWHy+K5GYfOEBqCzTniR7ANMKrd+ZzDwGqwbx4BHlHlNVxSn57F2U1e6ni618sFrohxhw7TH0oFfL3SCOOpD6x4lInp+Si+CkcpqADZAsIvG2Gb8wgmFWADQ5nqfeUSq1XHOA4nVOP2FxwOjriuXgzVvobGuHonkr41+70v7Z1TRFC9hIIDn7NnIAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDXpsrOvtw6r+PDFdJtbBPzim5tNwtHr/TjEwLDZEZQ=;
 b=M2O64QcrA3Gg4tZI67uvrdJw6w78oKijUZuZMTZQN6Bwg8wWuPr5/6/eFpDsIcHucWbPHpMX2+PfMFZDQwE6wPYaZ7W3A/J35Fqi5e05KYc3RGFcBT0HouXrkjiHK7dYPRpacfNBtru5K+qoQrPzs009g50VNaqwD61HcqIC+79wFMOkgHjtUJ1AXweeDgCVOlRt9dfY2PO6byz3LIYcwtvggypOq9jhcK2ZjjSSp6ouW3Y0PbWus/6eOBkWjRwHjVc+ZFoyo3TSzTzQN4lGRGK4O90+MJWiFBEVrQ6QFGZ58tIfjg4ccnZQaDMXa7jGrG3hZg71esmbaIgOsyYigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDXpsrOvtw6r+PDFdJtbBPzim5tNwtHr/TjEwLDZEZQ=;
 b=G05PsqPt13yT4Pa696EhSmKQeZSLxZSF/Eah4/pxFLX/HHMI1DRjZ/A1FBDqtYbZpJoagGzt3gd2VijoqYbANSe2TfKIQnTc0fd1+czxcNHfIujvkX16WMVvZrVkFuJP3IPsDsbBZtR2zr9+/VJgwl02CYw19m9E1ZX3qzLj20g=
Received: from CH0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:610:b3::25)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Wed, 20 Aug
 2025 20:21:10 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::cc) by CH0PR03CA0050.outlook.office365.com
 (2603:10b6:610:b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:04 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 01/12] drm/amd/display: Add control flags to force PSR / replay
Date: Wed, 20 Aug 2025 16:19:51 -0400
Message-ID: <20250820202103.1122706-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9799c409-3d0a-49f2-07b0-08dde027193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a56MubrLVo2pcZvjCLZEuCm9kl+9zqJjw6gy+Q8vMxI4lQxPiLjyR/pO8Bxn?=
 =?us-ascii?Q?ouEqFVZLsEGHffKjz4qKchz+UCKbDE7V1pYjxfcNtzwkrtxQ/rNUfgyzYmHK?=
 =?us-ascii?Q?Afx2TrBFwbh2Ie9O3N0ZeFEdI9t3COvG35YNTe5KX9LskH/a/hU5HS7N0Q1W?=
 =?us-ascii?Q?WJA0WQC5ZkadMcxwrOVpfnJor6QGA6E6Z+YY/3uPqQdx7/AJgRlHlBIo4+0y?=
 =?us-ascii?Q?dS595YDT+wc/GFE68hmsqjijheHDzlnFbQpv07snJJ3OAUebmwJCax/+BGF3?=
 =?us-ascii?Q?ePLWGJU/VCpthbc0VxaxHhEiQGmQO98etT3a5gdx+KBy83xEF3qdBpfBBb7Y?=
 =?us-ascii?Q?HfTOTovoD+H4JL7oqif2jnFUDXdkXjzm7pacSp3fgLBnEQdnvwCqGWheKOxW?=
 =?us-ascii?Q?3YAieygbTHF7wFM8KnwPcQUg0dqRtYBUdX5ztLNFyOG0/cKYffbOJOEH06yc?=
 =?us-ascii?Q?pb31ok/kDHhNBWbocHBXYF1n1fbwi4DTPjrRlO80AgDmvrIlyVuerL8ainDV?=
 =?us-ascii?Q?+y5skr01Ny2gjW1zKMhErHdzbX+Q1Eht+UpQDuWElatIz/Mb70SW1pEEqmBs?=
 =?us-ascii?Q?KWzdq2E6dKYGgY+DkPZrjSWMFyLc4RaFzGgjOO93Hygc+VNZhPF61SCdni3A?=
 =?us-ascii?Q?pJbww+2rRRYekQzVJlgPHTCJ1jpUZz0GHd28EBSJh2sGD8uUATa0ffKkwosY?=
 =?us-ascii?Q?TER4eV76+BKRMHiCKFdJbJtdVryu3Ii5dEAciI5Z1+CUnXp5dfnfTNakk60I?=
 =?us-ascii?Q?DXufG/KSdRkvlKozvoE4kTjKJ/0ZGynv/9jMdiEsYRNE3k5tr6qd+XG7oYVI?=
 =?us-ascii?Q?HrAp2zO04atuRimIFurma5Cs2vlsx9zVZtenZIAOckUOAIFViVj3c6oP0m5g?=
 =?us-ascii?Q?rAZkvLlCeGmb8JvX+zz4IbDBuunGl/50Lp4O7PXXtLvHY3Xd8GO+8PrcifRQ?=
 =?us-ascii?Q?4pRsozi/RhP3EX/zngEIALjyobXj2SM6EWEhRdzvXcg5Xia/HVb5FgF3rco7?=
 =?us-ascii?Q?HzSB/e2//aMFA+fZZK7i2k2v4n+kwNNn7/M5QWLvP17sXBMhWzxNcuKdyjUA?=
 =?us-ascii?Q?/0pvg0iuXszaWBEQav7FbbFqUhLq6tlAEL/Kl6f1stmA9Vuk3QTEr3SjI8BR?=
 =?us-ascii?Q?U4yS/KA73fktv4t80foHBToMZwnmu5XmqAOYciZZIIzPtfRyFe1yQHCirC86?=
 =?us-ascii?Q?6pWsqieCUXxdpmh2WKPn3ltJDBULlmPmtlGLRsczl1JCOxaH/0P4r1+jEOTj?=
 =?us-ascii?Q?3JOHJPV2HnX2K2h55Ff7IveQGo1CdQiB9RqVtD5FTltpIIDpTI1y9DhmzQk4?=
 =?us-ascii?Q?C7naD/uC/zz5P8qjKWmtBTZUBCeF6HMzp5Yeeyjk9IQxYVMjz9Vp8JFEB6We?=
 =?us-ascii?Q?ae8AGBv8Rg+q324Hkrjl8wmxmAZveAw/J3RxBC0IUW1meR5A30niCzZRAIrV?=
 =?us-ascii?Q?3MXfLATZzgyR/gwZlgZ8Yej8ezkXFU5WCfAzCoAX64l/WhIGVX6gDPjZbRgF?=
 =?us-ascii?Q?lqEd2eNtt2SSj2XCcONAB1+XXLC4Fyz8VbkT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:08.7372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9799c409-3d0a-49f2-07b0-08dde027193c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

To change PSR/Replay behavior based on OS preferences, add some
config options.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                     | 4 ++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c                 | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h               | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2e2dea21b332..619834a328a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -628,6 +628,7 @@ struct psr_config {
 	unsigned int line_time_in_us;
 	uint8_t rate_control_caps;
 	uint16_t dsc_slice_height;
+	bool os_request_force_ffu;
 };
 
 union dmcu_psr_level {
@@ -740,6 +741,7 @@ struct psr_context {
 	unsigned int line_time_in_us;
 	uint8_t rate_control_caps;
 	uint16_t dsc_slice_height;
+	bool os_request_force_ffu;
 };
 
 struct colorspace_transform {
@@ -1151,6 +1153,8 @@ struct replay_config {
 	bool replay_video_conferencing_optimization_enabled;
 	/* Replay alpm mode */
 	enum dc_alpm_mode alpm_mode;
+	/* Replay full screen only */
+	bool os_request_force_ffu;
 };
 
 /* Replay feature flags*/
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index ff3b8244ba3d..87af4fdc04a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -391,7 +391,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 			sizeof(DP_SINK_DEVICE_STR_ID_1)))
 		link->psr_settings.force_ffu_mode = 1;
 
-	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
+	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode || psr_context->os_request_force_ffu;
 
 	if (((link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
 		!link->dc->debug.disable_fec) &&
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 4387de044469..d30f94c35f11 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -684,6 +684,7 @@ struct replay_context {
 	/* Controller Id used for Dig Fe source select */
 	enum controller_id controllerId;
 	unsigned int line_time_in_ns;
+	bool os_request_force_ffu;
 };
 
 enum dc_replay_enable {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 2c3e2945124a..8b7b87b21c2e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -870,6 +870,8 @@ bool edp_setup_psr(struct dc_link *link,
 
 	psr_context->dsc_slice_height = psr_config->dsc_slice_height;
 
+	psr_context->os_request_force_ffu = psr_config->os_request_force_ffu;
+
 	if (psr) {
 		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
 			link, psr_context, panel_inst);
@@ -1029,6 +1031,8 @@ bool edp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream
 
 	replay_context.line_time_in_ns = lineTimeInNs;
 
+	replay_context.os_request_force_ffu = link->replay_settings.config.os_request_force_ffu;
+
 	link->replay_settings.replay_feature_enabled =
 			replay->funcs->replay_copy_settings(replay, link, &replay_context, panel_inst);
 	if (link->replay_settings.replay_feature_enabled) {
-- 
2.50.1

