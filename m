Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FAEE77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C748A10EB01;
	Tue,  7 Jan 2025 15:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvHc36Rv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7470E10E720
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN0oNHiaPPiUM+7c6FCjCAeB6K0NiNTCJ1xJ/Lk1Ukbo7RCvGy8+yf4aUGwecIgNPNRvMcfoOwxhWRV0HovgJx/NYGjYqJ9wDfrdGM+9eMMiFToS3IE3tsUnt6VpOVITuVZHTJMi/Rc6umqAEM41xkb9p905rEp1rkNgDsZeo1gttHzvF41rbwyzUJe7KaUhZYotXSRjShK6IXEqVW1nThRwc+74SftXC8DZ8RjUzgv2p4uf7kY/NGQ9IA5BG9gdm969zZWwaTs71IywMAtvk+qmEdKt5NNZBHwH5t3Yiy5u9BKD8qQZNebd2Q4GKnzUBSNwz2LIJux7SoQ6u3GTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyJZi9BqVU52H/4uIQxaitv56nIMqBxzLy415Sc3dfE=;
 b=yAF1F2AlAcGkaGFHt8qzD6lojqEQHcRPhUlqOH6gFpQvPUxJDqEDq4tVTamV+1/jAzoGap/1VC+XrolV/r1BMVwzsBDbOhBdwPXnMM5Aypl6+k3fXLbV7mVIdi2UqGdxZgsH6+irqIL2dzeLs5+jVQN5Q2NKRzRlxIT6zHjiukNvUF6D0xNL76quLWbGGP6MdUG7nr5vuFExmvkLxFWbkZ+Py+2zCuRjeVMs+fKwxtH9j5BZXF5A+EWanoL2nEiRu7s6h/nF99LMeoGcBTwvx1swsRHA/Z64e37v3J+8QerXlPN+9raPG3doEFTMcymCJ+C1n99Yc3l6ZXCnZJ9BPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyJZi9BqVU52H/4uIQxaitv56nIMqBxzLy415Sc3dfE=;
 b=bvHc36RviWZtTSSaxxaoVCHdu6fSj3MgTHL0RUhLRaqaQ24LxvzDTDVP680yHDUa59lB67as9g6Sk9fRAH++DJGnjWdwncVFR0UGXhsp7s9zmKewLif76S22jQ7JVppw/tDBaepmt+PIqsHmuLLlmEhb0yXTFV3QvXJWljEGG5c=
Received: from SN7PR04CA0079.namprd04.prod.outlook.com (2603:10b6:806:121::24)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:03 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::ac) by SN7PR04CA0079.outlook.office365.com
 (2603:10b6:806:121::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:02 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:54 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Extend secure display to support
 DisplayCRC mode
Date: Tue, 7 Jan 2025 23:28:41 +0800
Message-ID: <20250107152855.2953302-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c712bc8-e6dd-451b-a1cf-08dd2f30282a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DZsM+nXVTpO08U9tao6evHbdn6snM3P6eeEVb243BHCtNzMZKjJi6lz/6csv?=
 =?us-ascii?Q?c8FIXQn48cX5cAY3bdf2KTRnP3VRxXdR25d5q4GAFeSPevwn6Vb7ivTcDz6O?=
 =?us-ascii?Q?KBsXwsJ1UE4SCJ+22qhuoPvwmJ3pwOvJlwebW4KMWld6CJhbM6FC0CnIN6GO?=
 =?us-ascii?Q?HxGKUfZGcPxOjNmjraz1yLdUT7OpKFCVfe/gphDnqnDG4HKqI/xk2IXmj1XK?=
 =?us-ascii?Q?BNMMPifilKClW22NcXKV24ExaN7lbnv4m9z4qEw88bbJRRQ12Zp4apWw1imR?=
 =?us-ascii?Q?MHnJfmsYn4ZfgzbLmWDoN/fLtHWISpHUKwgzMgWFmK09NQOpogO/YfTI0KzN?=
 =?us-ascii?Q?pHz99oRuk/li+9FWNuhUXbj7cTiUKIZ1u8EtCS268rV2ic6rFv4EpMieiYXL?=
 =?us-ascii?Q?K70QOZ3ZKr1b20XR0cRYJwx/YGgEPcPx728RM1hXqWGFPPddFMHr2jyk7tc1?=
 =?us-ascii?Q?EHCGw33eSd+gOyr9qgPwE6HOoLHNyk7G6v8mEi1YY/+qUfwm0KOcmmD9ljPq?=
 =?us-ascii?Q?/ZUYsLEyEO8GEVv4qjAQjwaTXRzZSNqGYwFF6SF9VQCvH+IyKHAv2H1i7MED?=
 =?us-ascii?Q?Af+W+COoYMhLHBCQ7G6D1iVQaVY7+tFmO2Di5zPXiKC2lKc7EmzRnS3RzQDl?=
 =?us-ascii?Q?xj4kTF2vYJuG/2XRs773j0G/ixqwCBO/6EnaOY1GBVXmziKS8yQLruq9bbn4?=
 =?us-ascii?Q?SYnmJQGv874vluBP1HPa8mvdszsGIc3hLPW6AEEBqnMMWuTYQans772Eux3g?=
 =?us-ascii?Q?dU1Otxo7RRhrNV/4+nTvFA7+6Lz0MniwjzKeYZsXGNhalLYZK4WsZmpoypX0?=
 =?us-ascii?Q?m2o4WRrBfDJwAJ3y8MhahiEsnWqwJZLOT77jrSfVzJmGNw4Qq8b3YOdYyTFO?=
 =?us-ascii?Q?aAGp1/EaSQ/RDJQ87QtK/XNQIuFz3nVN5rubeC6ZWhKOjfleh4xkpnFJMqAs?=
 =?us-ascii?Q?NkFwjM48HKoYRgWg/n81hE2EJvBZXDuBAcVRxav7/0BCaT8dGMDvfETB7mqP?=
 =?us-ascii?Q?gAmVdtscLCqlFxkDGdfj0FaJ3jHoocZq0KGaNYsUSI6TZmbhn4O0bTMHGhmM?=
 =?us-ascii?Q?w05PMh0h0CYIV5UE+uXI87WarbAyFcHWRN6bPkPG1BeXzXYshVfO8EYe3cqZ?=
 =?us-ascii?Q?neFWVFxlOW1ylCYrsytFk/1HVz3Lb81NoESOW2uRvic4UnmT9wZjx5i9ptQ9?=
 =?us-ascii?Q?cjPWmgKLrWb8ivPGg5L61hkScs9jpvEyN0NdfK26gGqdQY3V1JuQlRMexv+K?=
 =?us-ascii?Q?8jY71ZnnQ+3Vyoy4+c15XuN7+0JhxlmEIbyHEDXrkAuEM4P6RZ7x+Gt6iIpI?=
 =?us-ascii?Q?1+Z2/Amjxn3jVbU6im6pMG9baNIo1RYvZMZT8SAT7pHcpghpv7oWhY5SpeOO?=
 =?us-ascii?Q?6vYjmVYKTjLL/Fd6Sd0LHE+nO7/ZrJvEG4YsDCTfrPdxXbLx+mFyjNwoxlgA?=
 =?us-ascii?Q?1CapVIkHug0cvq0aYsD5lARQvj4Jek3CYUGdp8Bf2uxywOyLDUCBnufENZT5?=
 =?us-ascii?Q?lctO3qFl3zL+KJM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:03.4515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c712bc8-e6dd-451b-a1cf-08dd2f30282a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
For the legacy secure display, it involves PSP + DMUB to confgiure and
retrieve the CRC/ROI result. Have requirement to support mode which all
handled by driver only.

[How]
Add another "DisplayCRC" mode, which doesn't involve PSP + DMUB.
All things are handled by the driver only

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 56 +++++++++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  9 +++
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index a2e36b882a4f..2412b9d7c86f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -316,7 +316,7 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 	spin_unlock_irqrestore(&drm_dev->event_lock, flags);
 
 	/* Disable secure_display if it was enabled */
-	if (was_activated) {
+	if (was_activated && dm->secure_display_ctx.op_mode == LEGACY_MODE) {
 		/* stop ROI update on this crtc */
 		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].notify_ta_work);
 		flush_work(&dm->secure_display_ctx.crtc_ctx[crtc->index].forward_roi_work);
@@ -691,7 +691,8 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* Initialize phy id mapping table for secure display*/
-	if (!dm->secure_display_ctx.phy_mapping_updated)
+	if (dm->secure_display_ctx.op_mode == LEGACY_MODE &&
+		!dm->secure_display_ctx.phy_mapping_updated)
 		update_phy_id_mapping(adev);
 #endif
 
@@ -774,6 +775,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	bool forward_roi_change = false;
 	bool notify_ta = false;
 	bool all_crc_ready = true;
+	struct dc_stream_state *stream_state;
 	int i;
 
 	if (crtc == NULL)
@@ -782,6 +784,7 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	acrtc = to_amdgpu_crtc(crtc);
 	adev = drm_to_adev(crtc->dev);
 	drm_dev = crtc->dev;
+	stream_state = to_dm_crtc_state(crtc->state)->stream;
 
 	spin_lock_irqsave(&drm_dev->event_lock, flags1);
 	cur_crc_src = acrtc->dm_irq_params.crc_src;
@@ -807,6 +810,17 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	}
 
 	for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+		struct crc_params crc_window = {
+			.windowa_x_start = acrtc->dm_irq_params.window_param[i].x_start,
+			.windowa_y_start = acrtc->dm_irq_params.window_param[i].y_start,
+			.windowa_x_end = acrtc->dm_irq_params.window_param[i].x_end,
+			.windowa_y_end = acrtc->dm_irq_params.window_param[i].y_end,
+			.windowb_x_start = acrtc->dm_irq_params.window_param[i].x_start,
+			.windowb_y_start = acrtc->dm_irq_params.window_param[i].y_start,
+			.windowb_x_end = acrtc->dm_irq_params.window_param[i].x_end,
+			.windowb_y_end = acrtc->dm_irq_params.window_param[i].y_end,
+		};
+
 		crtc_ctx->roi[i].enable = acrtc->dm_irq_params.window_param[i].enable;
 
 		if (!acrtc->dm_irq_params.window_param[i].enable) {
@@ -821,15 +835,20 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 		}
 
 		if (acrtc->dm_irq_params.window_param[i].update_win) {
-			/* prepare work for dmub to update ROI */
-			crtc_ctx->roi[i].rect.x = acrtc->dm_irq_params.window_param[i].x_start;
-			crtc_ctx->roi[i].rect.y = acrtc->dm_irq_params.window_param[i].y_start;
-			crtc_ctx->roi[i].rect.width = acrtc->dm_irq_params.window_param[i].x_end -
-						acrtc->dm_irq_params.window_param[i].x_start;
-			crtc_ctx->roi[i].rect.height = acrtc->dm_irq_params.window_param[i].y_end -
-						acrtc->dm_irq_params.window_param[i].y_start;
-
-			forward_roi_change = true;
+			crtc_ctx->roi[i].rect.x = crc_window.windowa_x_start;
+			crtc_ctx->roi[i].rect.y = crc_window.windowa_y_start;
+			crtc_ctx->roi[i].rect.width = crc_window.windowa_x_end -
+						crc_window.windowa_x_start;
+			crtc_ctx->roi[i].rect.height = crc_window.windowa_y_end -
+						crc_window.windowa_y_start;
+
+			if (adev->dm.secure_display_ctx.op_mode == LEGACY_MODE)
+				/* forward task to dmub to update ROI */
+				forward_roi_change = true;
+			else if (adev->dm.secure_display_ctx.op_mode == DISPLAY_CRC_MODE)
+				/* update ROI via dm*/
+				dc_stream_configure_crc(stream_state->ctx->dc, stream_state,
+					&crc_window, true, true, i, false);
 
 			reset_crc_frame_count[i] = true;
 
@@ -843,14 +862,18 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 			acrtc->dm_irq_params.window_param[i].skip_frame_cnt = 1;
 			crtc_ctx->crc_info.crc[i].crc_ready = false;
 		} else {
-			struct dc_stream_state *stream_state = to_dm_crtc_state(crtc->state)->stream;
-
 			if (!dc_stream_get_crc(stream_state->ctx->dc, stream_state, i,
 						&crc_r[i], &crc_g[i], &crc_b[i]))
 				DRM_ERROR("Secure Display: fail to get crc from engine %d\n", i);
 
-			/* prepare work for psp to read ROI/CRC and send to I2C */
-			notify_ta = true;
+			if (adev->dm.secure_display_ctx.op_mode == LEGACY_MODE)
+				/* forward task to psp to read ROI/CRC and output via I2C */
+				notify_ta = true;
+			else if (adev->dm.secure_display_ctx.op_mode == DISPLAY_CRC_MODE)
+				/* Avoid ROI window get changed, keep overwriting. */
+				dc_stream_configure_crc(stream_state->ctx->dc, stream_state,
+						&crc_window, true, true, i, false);
+
 			/* crc ready for psp to read out */
 			crtc_ctx->crc_info.crc[i].crc_ready = true;
 		}
@@ -914,6 +937,7 @@ void amdgpu_dm_crtc_secure_display_create_contexts(struct amdgpu_device *adev)
 	}
 
 	adev->dm.secure_display_ctx.crtc_ctx = crtc_ctx;
-	return;
+
+	adev->dm.secure_display_ctx.op_mode = DISPLAY_CRC_MODE;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 0c96f2db1352..3da056c8d20b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -42,6 +42,14 @@ enum amdgpu_dm_pipe_crc_source {
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 #define MAX_CRTC 6
 
+enum secure_display_mode {
+	/* via dmub + psp */
+	LEGACY_MODE = 0,
+	/* driver directly */
+	DISPLAY_CRC_MODE,
+	SECURE_DISPLAY_MODE_MAX,
+};
+
 struct phy_id_mapping {
 	bool assigned;
 	bool is_mst;
@@ -98,6 +106,7 @@ struct secure_display_context {
 	struct secure_display_crtc_context *crtc_ctx;
     /* Whether dmub support multiple ROI setting */
 	bool support_mul_roi;
+	enum secure_display_mode op_mode;
 	bool phy_mapping_updated;
 	int phy_id_mapping_cnt;
 	struct phy_id_mapping phy_id_mapping[MAX_CRTC];
-- 
2.34.1

