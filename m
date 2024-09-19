Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DF4CF3965
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1B310E768;
	Thu, 19 Sep 2024 18:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u7u85ukQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DF410E764
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZX/o7K2Ftdflo5twCL5VdOMibF8XlI9HWcfPisB/QGBnVruV7H3C5Uti49OZVUIkdXW3MuEsqRvueaQpKbIiOk8NIZBwdAhVbWOqdUaSCcZ96S7fTbjgFj+bHAmKNe/J4zHlqGYmDWRDgIuzRUw5OXBTXGE0OTAtH2PbJfrB7j/yTO9ORn/0iucQUigaehepXMM40ghvQRWvIU6EQmXnYFHaJtwoHSnh23CHzYlxFg1nXru/YEVFwCSFUjTRZHJoYf4GB8R+6OYt4AOUiddzJ2vH9GV6OOjDSfHcVLOTmi8l952AyDCyOAf9C2oW8pYxKYRJzjjXsi8qko/gfWI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFxZTRxvIrcR8qRz4+h/cdH0iZRuGngql9mOQK/D9iY=;
 b=c7JQjv52Vjf200mb1hNsKGEgmSk1BP4B0TCaljFp72UQm4WY9KD6c5YQxaNeDcmaYAKkZccO68w3E0UVff786R+QWvYSOlmiPcn7eg4bBae7yMH6GPQmld1QqlEKhPCm9PT53hbU4TIHmBnhPzptrAQaldjpREd2Ex6n4MzRNIpKqlXNa6b4Q56EKSyWKapVTssr5xTyx4VwyXajBVmidLVYre0JiLatt5ed6ZYuAomWSYrzwxudhzCaAaYYPbpG7ADTW7srDvND0UAxdqyG3innL8prZnpndWuL/DzgtUHdLZuvWuMz5yS2DRdV1Xsh8Sam1ZUk4gKrVG90rDiSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFxZTRxvIrcR8qRz4+h/cdH0iZRuGngql9mOQK/D9iY=;
 b=u7u85ukQWqccQPksLwMOv7ibhFFq8vQuUgDmRCqr75Lp87GT8trTLul74ePdFuNPq9YDz1+OtUtJYOK0TGxlnaSbRUgxO4DN7cyIoINMWpoJv5JeKlo9Biy3eCCOOg9iEFcMR/S60f8gnJ6E884jl782NOIoUry9el8jpobLoJQ=
Received: from SN7PR04CA0188.namprd04.prod.outlook.com (2603:10b6:806:126::13)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 18:35:06 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::62) by SN7PR04CA0188.outlook.office365.com
 (2603:10b6:806:126::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:02 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 16/21] drm/amd/display: Fix cursor visual confirm update
Date: Thu, 19 Sep 2024 14:33:34 -0400
Message-ID: <20240919183435.1896209-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: b1380444-3997-4805-f513-08dcd8d9c8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F9udFmzVibhsDE++zOkm7WQ/nLopDlLbkccGNX6uLfBK9gCGSSDhI6u18VlZ?=
 =?us-ascii?Q?fJcCV19LmcdDCn5NA0TehIPAeIf/nIG+Y5Gih4mBeK8pIaCxrkRvceVz8IlV?=
 =?us-ascii?Q?jRBlmkEqKeom2ZvV2gsCxcRfYZ6VjzjPI4xxQbAtQVjVgzNigZ7mDrZ7yTRm?=
 =?us-ascii?Q?kI0L6FtuScStvkMS6h7GscRupwkMVlBtIRN/iVOSvGwN7ycUtdSbBVRZBO62?=
 =?us-ascii?Q?2InccTHmVH6tUSY/sk71PfHOI9WuXbw4pHvBshtQXZ6GEmB0YiThbnfVyOyn?=
 =?us-ascii?Q?CLVD4Hzn4Y4Plx3t7Wny9Z9qiYN58Mo6olMIKqaiamVdVCRSICIY1gQuVTyp?=
 =?us-ascii?Q?6L706+XPKTI7qNUcaiAMimAKcqwhZq5Sl9ZFRgFnCpAwvfBSl66qPu8kJrOv?=
 =?us-ascii?Q?dO92sl/yvuSmwdNt6TEDdANVHMC9Ab20ZroJpkgxLRV/ilQINAUw3Q5KXCZN?=
 =?us-ascii?Q?v0nZEx0uRdllbExyKVBx16Q8q9/cyatREOrlkVJqBu72ZqbG3zDnYMH2wKkH?=
 =?us-ascii?Q?VsrOVjdrKNRLw42CAH50Jc+0m+s/4yuUwmNiuySAMToE6+vWAVUh9LKGGJ+P?=
 =?us-ascii?Q?OZWd+79DrRCeHLflD5vPQWOI8ywH6M5ROJECFLmK7Y8GkbuX5apZmiIcDxgd?=
 =?us-ascii?Q?V53vKn1l1D2sh+tZSGmn6NhJrqA5qJVZMdtszthbaQU+Qz0frh+QEep87Cpz?=
 =?us-ascii?Q?Iyt6se6NQ4ZoMF+fiHqaRVOtMf9KEBANgfv13gWmC+PUq2WPxOdcfozAt/pc?=
 =?us-ascii?Q?lmt9gnxy8x09SqAaOmfMvAmP9niN62Sv4cVinVDuw++CYj2Pe8MoSK4ou7kv?=
 =?us-ascii?Q?Avc+8zhCvdfPfYu7hNYnjr8T9c9pyHg/4ghpcoCbpFer1gqdwzNfUBCUD1MG?=
 =?us-ascii?Q?mhXC/7QQus0L2ccfyXrg9rK0S1WcOhM+9L+36Q7h9+hpl+bO/ZdRzYuEis5E?=
 =?us-ascii?Q?uMfWq+SJVzL1pP5HR/WwFhFc26cA6hzVbWAjCo/s0axkocSWziB5JewBGpdh?=
 =?us-ascii?Q?4qUusrAr/rgfKTRM3eXz/850j4dU9yMvVLt2cdBL6E1z40frlwrrV01W7KYr?=
 =?us-ascii?Q?i1jftreqWpuZ3qS8xP+w1PPelGKKYH02brQGYPUkgXISnsQVEKBDgnhzAolA?=
 =?us-ascii?Q?Z9zCMGFcZRz/sWwTcfKvYWp3MPUC9RCcPy1Qu0pJ8G45XJ6JK2Y14LOaYjV+?=
 =?us-ascii?Q?hg5mUQVeImmQ6TFQMawtbXAotveTayGi541fi2dKdO4ZQs4g3eAY3+AjhH0S?=
 =?us-ascii?Q?yhjYZluuXC2cwAQcKcjEA3rZD6DJh4hRcE9+sfuJpNVFuUe+d8O0jnBHCq1b?=
 =?us-ascii?Q?xpmDHpy3imUIYXabTYmkXUQW9zSts6/stXT8oZgjdqj2xB6DetXbfpMCr4m/?=
 =?us-ascii?Q?wzP0Yz9g3FodMVBIpJkA3AX16gk7qH+rYOjqZEFvkyEJQ5SIihuEovvD25j4?=
 =?us-ascii?Q?pHxD+uHp9xyzlerM7At8fj+xPZoNG1VZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:06.4546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1380444-3997-4805-f513-08dcd8d9c8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Certain transitions from HW to SW cursor can be missed, which will
result in black visual confirm instead of expected blue/red. Need to add
handling for cursor visual confirm to dc_update_visual_confirm_color.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  2 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c   | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 11 +----------
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h  |  4 ++++
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 024d2d0bf457..fbc2e1dfb610 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1157,6 +1157,8 @@ static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *conte
 			get_surface_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
 			get_surface_tile_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR)
+			get_cursor_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		else {
 			if (dc->ctx->dce_version < DCN_VERSION_2_0)
 				color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2cb9253c9bde..2fdcf8d59b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -497,6 +497,23 @@ void get_mclk_switch_visual_confirm_color(
 	}
 }
 
+void get_cursor_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+
+	if (pipe_ctx->stream && pipe_ctx->stream->cursor_position.enable) {
+		color->color_r_cr = color_value;
+		color->color_g_y = 0;
+		color->color_b_cb = 0;
+	} else {
+		color->color_r_cr = 0;
+		color->color_g_y = 0;
+		color->color_b_cb = color_value;
+	}
+}
+
 void set_p_state_switch_method(
 		struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index be2638c763d7..b000bf39762f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -419,7 +419,6 @@ bool dc_stream_program_cursor_position(
 		/* apply/update visual confirm */
 		if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR) {
 			/* update software state */
-			uint32_t color_value = MAX_TG_COLOR_VALUE;
 			int i;
 
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -427,15 +426,7 @@ bool dc_stream_program_cursor_position(
 
 				/* adjust visual confirm color for all pipes with current stream */
 				if (stream == pipe_ctx->stream) {
-					if (stream->cursor_position.enable) {
-						pipe_ctx->visual_confirm_color.color_r_cr = color_value;
-						pipe_ctx->visual_confirm_color.color_g_y = 0;
-						pipe_ctx->visual_confirm_color.color_b_cb = 0;
-					} else {
-						pipe_ctx->visual_confirm_color.color_r_cr = 0;
-						pipe_ctx->visual_confirm_color.color_g_y = 0;
-						pipe_ctx->visual_confirm_color.color_b_cb = color_value;
-					}
+					get_cursor_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 
 					/* programming hardware */
 					if (pipe_ctx->plane_state)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index b3134c85df39..1df17c54f3a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -509,6 +509,10 @@ void get_mclk_switch_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
 
+void get_cursor_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+
 void set_p_state_switch_method(
 		struct dc *dc,
 		struct dc_state *context,
-- 
2.46.0

