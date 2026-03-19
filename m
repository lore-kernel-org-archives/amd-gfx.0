Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53BA1090241
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 15:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F29E10E8DE;
	Thu, 19 Mar 2026 15:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PKyuEBSi";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26D310E8E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 15:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIePOQ3i/Zt7NC1AEA7ihgHTupJZCi2pgjDqMYu7/Bdb4LfSa6V7FN8VS6+LmLsKI0C8Q7ktwlXgCmCnlK190M6fiRod7fYbE2Uar2WF4rU2UtI4i9emintVopVoYFmDnddsAk4TpOD6AFmlBKaVQJ/T4+r85UMhSTLgyQQZJQjTmT+xWBDM9cyQVVUkSaJ+1o+iq6FvEZ2j37F/v3yl7FU+AulgBS5y8Til5Mt/UtpHnIysu5/T/cqT1rRXlFJSZeSpM5LlSbREu4g34UlDJ2oom/tpyE+oY98NwQ2SoPKXuKmv7A8OMLN59vhJ7eFtbE8FQontrh1zsGTNQT3dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYeRaptitzoyShGBstqcYW+9MGF/cPHbb9gg+/Fb4Uc=;
 b=vpGlTs/TJJ4B7JMScmH/OdIfV2JR2JNjfTQz2fUL91OQU/vP+sMTNKQPSoAEnqrDCWefbW6keGNnXfMRzxMcUctGjcV1QhLju5Uj/RZ19QD7+nf2FLUD1RG/O7do4kYr3LcT2mi46HdQNA2P+TyHjSrEwEOQpF87MCkoY250AGxDQMvpD2wDPp31W0Uw2e2d5MYUqPnwaJ5oHdmr4FYKed1zUcQt192DSpQv6hPeVElSwpuOHaAUdpgm7FWqSO/nFPtL75pYl9u/QRj1I84nhD0FvEESaTpf93GQ6wTFHFicQCly0mZGVrL+iSgaLACdOaKSPugx/4YVbDTgRyISbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYeRaptitzoyShGBstqcYW+9MGF/cPHbb9gg+/Fb4Uc=;
 b=PKyuEBSijE+Z+FtV2kWHhOKTa+kPNHEaO/Y+rnMAMN/Gk3jjwUvcGy2w4K9DeM8WzlmB3ILUXBwSwwJHF72MCGv6vejFR5M4TmJONSBNiYWPxJzy86eWGqTcvwmsquYWOY2IJPm0IsQWVb9G57KjEys63pKjxf8ajjAlc6Ho6w0=
Received: from IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::13)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 15:41:54 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::5a) by IA4P221CA0010.outlook.office365.com
 (2603:10b6:208:559::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 15:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 15:41:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 10:41:52 -0500
Received: from thonkpad (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Thu, 19 Mar 2026 10:41:46 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <superm1@kernel.org>, <Ray.Wu@amd.com>, Ray Wu
 <ray.wu@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Add Idle state manager(ISM)
Date: Thu, 19 Mar 2026 11:41:41 -0400
Message-ID: <20260319154141.567018-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c728714-65e7-4237-07e4-08de85ce0b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9KithZks+xrWIiME9n7RRaE9K3XtYXDJ6J3naWA87r+8K58NBriSJu1irB6kVgp6pHJpF2UXTTew6HOGEYUO/4o6Q0rweGyKagr1GgPS5hD6VisXuC9p3qAi5ockcdqXoB4Ma8jv4MnLmm0jCSS4LU2miRxb8VxZ9b6QIoQYi62sdRsnZGKh1O9bcIU6XKVAUXnvl2giXajHqB/Bnj/r0d2LWRmU2ycmZmCGwpFr/TIQoXkrF6kJAupj3qLt4v0CzjtZW1xi+lG30XonTXEiwST9HjX+8GGIL0LiY4mNhfc9yQh++KXikcHqOUBfbDqiN7vE3QaQvTD3Y4tW+vM4piCYRihvj9vxpPHJUhjsY7pc6YoohYLtZHG6EurvbxPy9Zeb5hQOtm98J3cChfZhguYRXu1GfJRQNJ9ron/B2qQYgLz90DlKdrZ565b0yl5Y6RTi4myDQTYgukBWZK5PU3Ipfhznw8xSe3PxFrM3VoJo0qXcMmtapB/sQwN1yWs3WE0NBDc6T/XUmkqnbW62b8knIjUXRokj7wdMleNqdpFtKbFdsvYhju0YhcFUo0mJvCJ8V0rZwwVBpWNSL1MMIDAzm4p+IUsTC3kOrOP5HIsZZIYsohJO/vF5AL03K7sfQ7RVqiJ8O1Lk5xtismjSSP5j3+71qjt1FSZYVYnTHb50Wf2ilXLC2qwlzHuSevmTeFo5thWfCAGFVPLXu+M+KxrdJoNdoWTUOJa8K+pPuWo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YVT5wNLojZraz8hVcFBWsz6x65VC5YKurqW7VXkxRRx1g2qf2vxG3Pm8vU79zspoeQA8uv5SSwTweO/xjIr/N1109f6NeR4dsnG6Nm1eNx8Tb9di/QoA19sDkTGB7dN0xyyDSbudIpZ+a9fcEFt1yh0gwppAkJQaw+WOqkrYhPrGmOGtEqrr7r7KY1zh4X5MAgQyDtKBvqLrS0WZqZx7wBrhAkpIQr6gnT1wwXTcpPgCDC43ev5X9FEghCUrMQ4Qk8ykxQ9UDraY/FpMoDSVK5OWqR6TCpSQuXlLFXpQv8WOJGfD/FZo81rLD7poBNkCsG0B5cfGYZU+p+czefIyxpzM54D11yCxFbJcqdIgXZrFn4aUXAssaiTcD1tQNPNO5vPsjyzBeSFivTCqx4/NfOjwySbpzrRg7OLWaFRKk3Ax/XxoJJQ1rw6669S+w/Hi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:41:53.1494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c728714-65e7-4237-07e4-08de85ce0b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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

From: Ray Wu <ray.wu@amd.com>

[Why]

Rapid allow/disallow of idle optimization calls, whether it be IPS or
self-refresh features, can end up using more power if actual
time-in-idle is low. It can also spam DMUB command submission in a way
that prevents it from servicing other requestors.

[How]

Introduce the Idle State Manager (ISM) to amdgpu. It maintains a finite
state machine that uses a hysteresis to determine if a delay should be
inserted between a caller allowing idle, and when the actual idle
optimizations are programmed.

A second timer is also introduced to enable static screen optimizations
(SSO) such as PSR1 and Replay low HZ idle mode. Rapid SSO enable/disable
can have a negative power impact on some low hz video playback, and can
introduce user lag for PSR1 (due to up to 3 frames of sync latency).

This effectively rate-limits idle optimizations, based on hysteresis.

This also replaces the existing delay logic used for PSR1, allowing
drm_vblank_crtc_config.disable_immediate = true, and thus allowing
drm_crtc_vblank_restore().

Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/4527
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/3709
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   5 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  34 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 591 ++++++++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h | 151 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  16 +
 8 files changed, 813 insertions(+), 63 deletions(-)
 create mode 100755 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
 create mode 100755 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 90352284c5ee2..51ab1a3326157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -44,6 +44,7 @@
 #include <drm/display/drm_dp_mst_helper.h>
 #include "modules/inc/mod_freesync.h"
 #include "amdgpu_dm_irq_params.h"
+#include "amdgpu_dm_ism.h"
 
 struct amdgpu_bo;
 struct amdgpu_device;
@@ -486,6 +487,10 @@ struct amdgpu_crtc {
 	int deferred_flip_completion;
 	/* parameters access from DM IRQ handler */
 	struct dm_irq_params dm_irq_params;
+
+	/* DM idle state manager */
+	struct amdgpu_dm_ism ism;
+
 	/* pll sharing */
 	struct amdgpu_atom_ss ss;
 	bool ss_enabled;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 8e949fe773129..89350aa9ca7ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -40,7 +40,8 @@ AMDGPUDM = \
 	amdgpu_dm_replay.o \
 	amdgpu_dm_quirks.o \
 	amdgpu_dm_wb.o \
-	amdgpu_dm_colorop.o
+	amdgpu_dm_colorop.o \
+	amdgpu_dm_ism.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d487e92bd5d61..95a093f4ec329 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3281,6 +3281,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 		mutex_lock(&dm->dc_lock);
 
+		amdgpu_dm_ism_disable(dm);
 		dc_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
@@ -3314,6 +3315,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_irq_suspend(adev);
 
+	scoped_guard(mutex, &dm->dc_lock)
+		amdgpu_dm_ism_disable(dm);
+
 	hpd_rx_irq_work_suspend(dm);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
@@ -3604,6 +3608,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 		dc_resume(dm->dc);
 
+		amdgpu_dm_ism_enable(dm);
 		amdgpu_dm_irq_resume_early(adev);
 
 		for (i = 0; i < dc_state->stream_count; i++) {
@@ -3664,6 +3669,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* program HPD filter */
 	dc_resume(dm->dc);
 
+	scoped_guard(mutex, &dm->dc_lock)
+		amdgpu_dm_ism_enable(dm);
+
 	/*
 	 * early enable HPD Rx IRQ, should be done before set mode as short
 	 * pulse interrupts are used for MST
@@ -9328,31 +9336,7 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 	if (acrtc_state) {
 		timing = &acrtc_state->stream->timing;
 
-		/*
-		 * Depending on when the HW latching event of double-buffered
-		 * registers happen relative to the PSR SDP deadline, and how
-		 * bad the Panel clock has drifted since the last ALPM off
-		 * event, there can be up to 3 frames of delay between sending
-		 * the PSR exit cmd to DMUB fw, and when the panel starts
-		 * displaying live frames.
-		 *
-		 * We can set:
-		 *
-		 * 20/100 * offdelay_ms = 3_frames_ms
-		 * => offdelay_ms = 5 * 3_frames_ms
-		 *
-		 * This ensures that `3_frames_ms` will only be experienced as a
-		 * 20% delay on top how long the display has been static, and
-		 * thus make the delay less perceivable.
-		 */
-		if (acrtc_state->stream->link->psr_settings.psr_version <
-		    DC_PSR_VERSION_UNSUPPORTED) {
-			offdelay = DIV64_U64_ROUND_UP((u64)5 * 3 * 10 *
-						      timing->v_total *
-						      timing->h_total,
-						      timing->pix_clk_100hz);
-			config.offdelay_ms = offdelay ?: 30;
-		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
 			   IP_VERSION(3, 5, 0) ||
 			   !(adev->flags & AMD_IS_APU)) {
 			/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 39fcbc3e702dc..ac064144f2e79 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -124,37 +124,37 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
  * - Enable condition same as above
  * - Disable when vblank counter is enabled
  */
-static void amdgpu_dm_crtc_set_panel_sr_feature(
-	struct vblank_control_work *vblank_work,
+void amdgpu_dm_crtc_set_panel_sr_feature(
+	struct amdgpu_display_manager *dm,
+	struct amdgpu_crtc *acrtc,
+	struct dc_stream_state *stream,
 	bool vblank_enabled, bool allow_sr_entry)
 {
-	struct dc_link *link = vblank_work->stream->link;
+	struct dc_link *link = stream->link;
 	bool is_sr_active = (link->replay_settings.replay_allow_active ||
 				 link->psr_settings.psr_allow_active);
 	bool is_crc_window_active = false;
-	bool vrr_active = amdgpu_dm_crtc_vrr_active_irq(vblank_work->acrtc);
+	bool vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 	is_crc_window_active =
-		amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base);
+		amdgpu_dm_crc_window_is_activated(&acrtc->base);
 #endif
 
 	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
-		amdgpu_dm_replay_enable(vblank_work->stream, true);
+		amdgpu_dm_replay_enable(stream, true);
 	} else if (vblank_enabled) {
 		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
-			amdgpu_dm_psr_disable(vblank_work->stream, false);
+			amdgpu_dm_psr_disable(stream, false);
 	} else if (link->psr_settings.psr_feature_enabled && !vrr_active &&
 		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
 
 		struct amdgpu_dm_connector *aconn =
-			(struct amdgpu_dm_connector *) vblank_work->stream->dm_stream_context;
+			(struct amdgpu_dm_connector *) stream->dm_stream_context;
 
 		if (!aconn->disallow_edp_enter_psr) {
-			struct amdgpu_display_manager *dm = vblank_work->dm;
-
-			amdgpu_dm_psr_enable(vblank_work->stream);
+			amdgpu_dm_psr_enable(stream);
 			if (dm->idle_workqueue &&
 			    (dm->dc->config.disable_ips == DMUB_IPS_ENABLE) &&
 			    dm->dc->idle_optimizations_allowed &&
@@ -251,33 +251,15 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	mutex_lock(&dm->dc_lock);
 
-	if (vblank_work->enable)
+	if (vblank_work->enable) {
 		dm->active_vblank_irq_count++;
-	else if (dm->active_vblank_irq_count)
-		dm->active_vblank_irq_count--;
-
-	if (dm->active_vblank_irq_count > 0)
-		dc_allow_idle_optimizations(dm->dc, false);
-
-	/*
-	 * Control PSR based on vblank requirements from OS
-	 *
-	 * If panel supports PSR SU, there's no need to disable PSR when OS is
-	 * submitting fast atomic commits (we infer this by whether the OS
-	 * requests vblank events). Fast atomic commits will simply trigger a
-	 * full-frame-update (FFU); a specific case of selective-update (SU)
-	 * where the SU region is the full hactive*vactive region. See
-	 * fill_dc_dirty_rects().
-	 */
-	if (vblank_work->stream && vblank_work->stream->link && vblank_work->acrtc) {
-		amdgpu_dm_crtc_set_panel_sr_feature(
-			vblank_work, vblank_work->enable,
-			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
-	}
-
-	if (dm->active_vblank_irq_count == 0) {
-		dc_post_update_surfaces_to_stream(dm->dc);
-		dc_allow_idle_optimizations(dm->dc, true);
+		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
+				DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+	} else {
+		if (dm->active_vblank_irq_count > 0)
+			dm->active_vblank_irq_count--;
+		amdgpu_dm_ism_commit_event(&vblank_work->acrtc->ism,
+				DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
 	}
 
 	mutex_unlock(&dm->dc_lock);
@@ -476,6 +458,9 @@ static struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *cr
 
 static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+
+	amdgpu_dm_ism_fini(&acrtc->ism);
 	drm_crtc_cleanup(crtc);
 	kfree(crtc);
 }
@@ -719,6 +704,15 @@ static const struct drm_crtc_helper_funcs amdgpu_dm_crtc_helper_funcs = {
 	.get_scanout_position = amdgpu_crtc_get_scanout_position,
 };
 
+static struct amdgpu_dm_ism_config default_ism_config = {
+	.filter_num_frames = 4,
+	.filter_history_size = 8,
+	.filter_entry_count = 1,
+	.activation_num_delay_frames = 4,
+	.filter_old_history_threshold = 0,
+	.sso_num_frames = 11,
+};
+
 int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			       struct drm_plane *plane,
 			       uint32_t crtc_index)
@@ -749,6 +743,8 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	if (res)
 		goto fail;
 
+	amdgpu_dm_ism_init(&acrtc->ism, &default_ism_config);
+
 	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
 
 	/* Create (reset) the plane state */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index c1212947a77b8..3a8094013a5d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -27,6 +27,12 @@
 #ifndef __AMDGPU_DM_CRTC_H__
 #define __AMDGPU_DM_CRTC_H__
 
+void amdgpu_dm_crtc_set_panel_sr_feature(
+	struct amdgpu_display_manager *dm,
+	struct amdgpu_crtc *acrtc,
+	struct dc_stream_state *stream,
+	bool vblank_enabled, bool allow_sr_entry);
+
 void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc);
 
 bool amdgpu_dm_crtc_modeset_required(struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
new file mode 100755
index 0000000000000..7f7393e5336cd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include <linux/types.h>
+#include <drm/drm_vblank.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_dm_ism.h"
+#include "amdgpu_dm_crtc.h"
+
+/**
+ * dm_ism_next_state - Get next state based on current state and event
+ *
+ * This function defines the idle state management FSM. Invalid transitions
+ * are ignored and will not progress the FSM.
+ */
+static bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
+			      enum amdgpu_dm_ism_event event,
+			      enum amdgpu_dm_ism_state *next_state)
+{
+	switch (STATE_EVENT(current_state, event))
+	{
+	case STATE_EVENT(DM_ISM_STATE_FULL_POWER_RUNNING,
+			 DM_ISM_EVENT_ENTER_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_FULL_POWER_RUNNING,
+			 DM_ISM_EVENT_BEGIN_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_FULL_POWER_BUSY;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_FULL_POWER_BUSY,
+			 DM_ISM_EVENT_ENTER_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_HYSTERESIS_BUSY;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_FULL_POWER_BUSY,
+			 DM_ISM_EVENT_END_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_WAITING,
+			 DM_ISM_EVENT_EXIT_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_TIMER_ABORTED;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_WAITING,
+			 DM_ISM_EVENT_BEGIN_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_HYSTERESIS_BUSY;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_WAITING,
+			 DM_ISM_EVENT_TIMER_ELAPSED):
+		*next_state = DM_ISM_STATE_OPTIMIZED_IDLE;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_WAITING,
+			 DM_ISM_EVENT_IMMEDIATE):
+		*next_state = DM_ISM_STATE_OPTIMIZED_IDLE;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_BUSY,
+			 DM_ISM_EVENT_EXIT_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_FULL_POWER_BUSY;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_HYSTERESIS_BUSY,
+			 DM_ISM_EVENT_END_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_HYSTERESIS_WAITING;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE,
+			 DM_ISM_EVENT_EXIT_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE,
+			 DM_ISM_EVENT_BEGIN_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_HYSTERESIS_BUSY;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE,
+			 DM_ISM_EVENT_SSO_TIMER_ELAPSED):
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE,
+			 DM_ISM_EVENT_IMMEDIATE):
+		*next_state = DM_ISM_STATE_OPTIMIZED_IDLE_SSO;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE_SSO,
+			 DM_ISM_EVENT_EXIT_IDLE_REQUESTED):
+		*next_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+		break;
+	case STATE_EVENT(DM_ISM_STATE_OPTIMIZED_IDLE_SSO,
+			 DM_ISM_EVENT_BEGIN_CURSOR_UPDATE):
+		*next_state = DM_ISM_STATE_HYSTERESIS_BUSY;
+		break;
+
+	case STATE_EVENT(DM_ISM_STATE_TIMER_ABORTED,
+			 DM_ISM_EVENT_IMMEDIATE):
+		*next_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+		break;
+
+	default:
+		return false;
+	}
+	return true;
+}
+
+static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
+				     const struct dc_stream_state *stream)
+{
+	const struct amdgpu_dm_ism_config *config = &ism->config;
+	uint32_t v_total, h_total;
+	uint64_t one_frame_ns, sso_delay_ns;
+
+	if (!stream)
+		return 0;
+
+	if (!config->sso_num_frames)
+		return 0;
+
+	v_total = stream->timing.v_total;
+	h_total = stream->timing.h_total;
+
+	one_frame_ns = div64_u64(v_total * h_total * 10000000ull,
+				 stream->timing.pix_clk_100hz);
+	sso_delay_ns = config->sso_num_frames * one_frame_ns;
+
+	return sso_delay_ns;
+}
+
+/**
+ * dm_ism_get_idle_allow_delay - Calculate hysteresis-based idle allow delay
+ */
+static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
+					    const struct dc_stream_state *stream)
+{
+	const struct amdgpu_dm_ism_config *config = &ism->config;
+	uint32_t v_total, h_total;
+	uint64_t one_frame_ns, short_idle_ns, old_hist_ns;
+	uint32_t history_size;
+	int pos;
+	uint32_t short_idle_count = 0;
+	uint64_t ret_ns = 0;
+
+	if (!stream)
+		return 0;
+
+	if (!config->filter_num_frames)
+		return 0;
+	if (!config->filter_entry_count)
+		return 0;
+	if (!config->activation_num_delay_frames)
+		return 0;
+
+	v_total = stream->timing.v_total;
+	h_total = stream->timing.h_total;
+
+	one_frame_ns = div64_u64(v_total * h_total * 10000000ull,
+				 stream->timing.pix_clk_100hz);
+
+	short_idle_ns = config->filter_num_frames * one_frame_ns;
+	old_hist_ns = config->filter_old_history_threshold * one_frame_ns;
+
+	// Look back into the recent history and count how many times we entered
+	// idle power state for a short duration of time
+	history_size = min(
+		max(config->filter_history_size, config->filter_entry_count),
+		AMDGPU_DM_IDLE_HIST_LEN);
+	pos = ism->next_record_idx;
+
+	for (int k = 0; k < history_size; k++)
+	{
+		if (pos <= 0 || pos > AMDGPU_DM_IDLE_HIST_LEN)
+			pos = AMDGPU_DM_IDLE_HIST_LEN;
+		pos -= 1;
+
+		if (ism->records[pos].duration_ns <= short_idle_ns)
+			short_idle_count += 1;
+
+		if (short_idle_count >= config->filter_entry_count)
+			break;
+
+		if (old_hist_ns > 0 &&
+		    ism->last_idle_timestamp_ns - ism->records[pos].timestamp_ns > old_hist_ns)
+			break;
+	}
+
+	if (short_idle_count >= config->filter_entry_count)
+		ret_ns = config->activation_num_delay_frames * one_frame_ns;
+
+	return ret_ns;
+}
+
+/**
+ * dm_ism_insert_record - Insert a record into the circular history buffer
+ */
+static void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
+{
+	struct amdgpu_dm_ism_record *record;
+
+	if (ism->next_record_idx < 0 ||
+	    ism->next_record_idx >= AMDGPU_DM_IDLE_HIST_LEN)
+		ism->next_record_idx = 0;
+
+	record = &ism->records[ism->next_record_idx];
+	ism->next_record_idx += 1;
+
+	record->timestamp_ns = ktime_get_ns();
+	record->duration_ns =
+		record->timestamp_ns - ism->last_idle_timestamp_ns;
+}
+
+
+static void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
+{
+	ism->last_idle_timestamp_ns = ktime_get_ns();
+}
+
+
+static bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
+				 enum amdgpu_dm_ism_event event)
+{
+	enum amdgpu_dm_ism_state next_state;
+
+	bool gotNextState = dm_ism_next_state(ism->current_state, event,
+					      &next_state);
+
+	if (gotNextState)
+	{
+		ism->previous_state = ism->current_state;
+		ism->current_state = next_state;
+	}
+
+	return gotNextState;
+}
+
+
+static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
+					     struct dc_stream_state *stream,
+					     bool vblank_enabled,
+					     bool allow_panel_sso)
+{
+	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	int r;
+
+	pr_debug("[DM ISM] active_vblank_irq_count=%d vblank_enabled=%d allow_panel_sso=%d\n",
+		      dm->active_vblank_irq_count, vblank_enabled, allow_panel_sso);
+
+	/*
+	 * If there is a CRTC with vblanks enabled, or if SSO is being engaged,
+	 * then disallow idle optimizations.
+	 */
+	if ((vblank_enabled && dm->active_vblank_irq_count > 0) ||
+	    (!vblank_enabled && allow_panel_sso))
+		dc_allow_idle_optimizations(dm->dc, false);
+
+	/*
+	 * Control PSR based on vblank requirements from OS
+	 *
+	 * If panel supports PSR SU/Replay, there's no need to exit self-refresh
+	 * when OS is submitting fast atomic commits, as they can allow
+	 * self-refresh during vblank periods.
+	 */
+	if (stream && stream->link) {
+		/*
+		 * If allow_panel_sso is true when disabling vblank, allow
+		 * deeper panel sleep states such as PSR1 and Replay static
+		 * screen optimization.
+		 */
+		if (!vblank_enabled && allow_panel_sso) {
+			pr_debug("[DM ISM] CRTC %d: Allowing static screen optimizations\n",
+				 acrtc->crtc_id);
+			amdgpu_dm_crtc_set_panel_sr_feature(
+				dm, acrtc, stream, false,
+				acrtc->dm_irq_params.allow_sr_entry);
+		} else if (vblank_enabled) {
+			/* Make sure to exit SSO on vblank enable */
+			amdgpu_dm_crtc_set_panel_sr_feature(
+				dm, acrtc, stream, true,
+				acrtc->dm_irq_params.allow_sr_entry);
+		}
+		/*
+		 * Else, vblank_enabled == false and allow_panel_sso == false;
+		 * do nothing here.
+		 */
+	}
+
+	if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
+		dc_post_update_surfaces_to_stream(dm->dc);
+
+		r = amdgpu_dpm_pause_power_profile(adev, true);
+		if (r)
+			dev_warn(adev->dev, "failed to set default power profile mode\n");
+
+		dc_allow_idle_optimizations(dm->dc, true);
+
+		r = amdgpu_dpm_pause_power_profile(adev, false);
+		if (r)
+			dev_warn(adev->dev, "failed to restore the power profile mode\n");
+	}
+}
+
+
+static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
+	struct amdgpu_dm_ism *ism,
+	struct dm_crtc_state *acrtc_state,
+	enum amdgpu_dm_ism_event event)
+{
+	enum amdgpu_dm_ism_event ret = event;
+	const struct amdgpu_dm_ism_config *config = &ism->config;
+	uint64_t delay_ns, sso_delay_ns;
+
+	switch (ism->previous_state)
+	{
+	case DM_ISM_STATE_HYSTERESIS_WAITING:
+		/*
+		 * Stop the timer if it was set, and we're not running from the
+		 * idle allow worker.
+		 */
+		if (ism->current_state != DM_ISM_STATE_OPTIMIZED_IDLE &&
+		    ism->current_state != DM_ISM_STATE_OPTIMIZED_IDLE_SSO)
+			cancel_delayed_work(&ism->delayed_work);
+		break;
+	case DM_ISM_STATE_OPTIMIZED_IDLE:
+		if (ism->current_state == DM_ISM_STATE_OPTIMIZED_IDLE_SSO)
+			break;
+		/* If idle disallow, cancel SSO work and insert record */
+		cancel_delayed_work(&ism->sso_delayed_work);
+		dm_ism_insert_record(ism);
+		dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
+						      true, false);
+		break;
+	case DM_ISM_STATE_OPTIMIZED_IDLE_SSO:
+		/* Disable idle optimization */
+		dm_ism_insert_record(ism);
+		dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
+						      true, false);
+		break;
+	default:
+		break;
+	}
+
+	switch (ism->current_state)
+	{
+	case DM_ISM_STATE_HYSTERESIS_WAITING:
+		dm_ism_set_last_idle_ts(ism);
+
+		/* CRTC can be disabled; allow immediate idle */
+		if (!acrtc_state->stream) {
+			ret = DM_ISM_EVENT_IMMEDIATE;
+			break;
+		}
+
+		delay_ns = dm_ism_get_idle_allow_delay(ism,
+						       acrtc_state->stream);
+		if (delay_ns == 0) {
+			ret = DM_ISM_EVENT_IMMEDIATE;
+			break;
+		}
+
+		/* Schedule worker */
+		mod_delayed_work(system_unbound_wq, &ism->delayed_work,
+				 nsecs_to_jiffies(delay_ns));
+
+		break;
+	case DM_ISM_STATE_OPTIMIZED_IDLE:
+		sso_delay_ns = dm_ism_get_sso_delay(ism, acrtc_state->stream);
+		if (sso_delay_ns == 0)
+			ret = DM_ISM_EVENT_IMMEDIATE;
+		else if (config->sso_num_frames < config->filter_num_frames){
+			/*
+			 * If sso_num_frames is less than hysteresis frames, it
+			 * indicates that allowing idle here, then disallowing
+			 * idle after sso_num_frames has expired, will likely
+			 * have a negative power impact. Skip idle allow here,
+			 * and let the sso_delayed_work handle it.
+			 */
+			mod_delayed_work(system_unbound_wq,
+					 &ism->sso_delayed_work,
+					 nsecs_to_jiffies(sso_delay_ns));
+		} else {
+			/* Enable idle optimization without SSO */
+			dm_ism_commit_idle_optimization_state(
+				ism, acrtc_state->stream, false, false);
+			mod_delayed_work(system_unbound_wq,
+					 &ism->sso_delayed_work,
+					 nsecs_to_jiffies(sso_delay_ns));
+		}
+		break;
+	case DM_ISM_STATE_OPTIMIZED_IDLE_SSO:
+		/* Enable static screen optimizations. */
+		dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
+						      false, true);
+		break;
+	case DM_ISM_STATE_TIMER_ABORTED:
+		dm_ism_insert_record(ism);
+		dm_ism_commit_idle_optimization_state(ism, acrtc_state->stream,
+						      true, false);
+		ret = DM_ISM_EVENT_IMMEDIATE;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static char *dm_ism_events_str[DM_ISM_NUM_EVENTS] = {
+	[DM_ISM_EVENT_IMMEDIATE] = "IMMEDIATE",
+	[DM_ISM_EVENT_ENTER_IDLE_REQUESTED] = "ENTER_IDLE_REQUESTED",
+	[DM_ISM_EVENT_EXIT_IDLE_REQUESTED] = "EXIT_IDLE_REQUESTED",
+	[DM_ISM_EVENT_BEGIN_CURSOR_UPDATE] = "BEGIN_CURSOR_UPDATE",
+	[DM_ISM_EVENT_END_CURSOR_UPDATE] = "END_CURSOR_UPDATE",
+	[DM_ISM_EVENT_TIMER_ELAPSED] = "TIMER_ELAPSED",
+	[DM_ISM_EVENT_SSO_TIMER_ELAPSED] = "SSO_TIMER_ELAPSED",
+};
+
+static char *dm_ism_states_str[DM_ISM_NUM_STATES] = {
+	[DM_ISM_STATE_FULL_POWER_RUNNING] = "FULL_POWER_RUNNING",
+	[DM_ISM_STATE_FULL_POWER_BUSY] = "FULL_POWER_BUSY",
+	[DM_ISM_STATE_HYSTERESIS_WAITING] = "HYSTERESIS_WAITING",
+	[DM_ISM_STATE_HYSTERESIS_BUSY] = "HYSTERESIS_BUSY",
+	[DM_ISM_STATE_OPTIMIZED_IDLE] = "OPTIMIZED_IDLE",
+	[DM_ISM_STATE_OPTIMIZED_IDLE_SSO] = "OPTIMIZED_IDLE_SSO",
+	[DM_ISM_STATE_TIMER_ABORTED] = "TIMER_ABORTED",
+};
+
+
+void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
+				enum amdgpu_dm_ism_event event)
+{
+	enum amdgpu_dm_ism_event next_event = event;
+	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(acrtc->base.state);
+
+	/* ISM transitions must be called with mutex acquired */
+	ASSERT(mutex_is_locked(&dm->dc_lock));
+
+	if (!acrtc_state) {
+		pr_debug("[DM ISM] CRTC %d No state associated, ignoring event %s\n",
+			      acrtc->crtc_id,
+			      dm_ism_events_str[event]);
+		return;
+	}
+
+	do {
+		bool transition = dm_ism_trigger_event(ism, event);
+		next_event = DM_ISM_NUM_EVENTS;
+
+		if (transition) {
+			pr_debug("[DM ISM] CRTC %d: %s -> %s on event %s\n",
+				      acrtc->crtc_id,
+				      dm_ism_states_str[ism->previous_state],
+				      dm_ism_states_str[ism->current_state],
+				      dm_ism_events_str[event]);
+			next_event = dm_ism_dispatch_power_state(
+				ism, acrtc_state, next_event);
+		} else {
+			pr_debug("[DM ISM] CRTC %d: No transition on event %s (current state %s)\n",
+				      acrtc->crtc_id,
+				      dm_ism_events_str[event],
+				      dm_ism_states_str[ism->current_state]);
+		}
+
+		event = next_event;
+
+	} while (next_event < DM_ISM_NUM_EVENTS);
+}
+
+
+static void dm_ism_delayed_work_func(struct work_struct *work)
+{
+	struct amdgpu_dm_ism *ism =
+		container_of(work, struct amdgpu_dm_ism, delayed_work.work);
+	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	guard(mutex)(&dm->dc_lock);
+
+	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_TIMER_ELAPSED);
+}
+
+static void dm_ism_sso_delayed_work_func(struct work_struct *work)
+{
+	struct amdgpu_dm_ism *ism =
+		container_of(work, struct amdgpu_dm_ism, sso_delayed_work.work);
+	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
+	guard(mutex)(&dm->dc_lock);
+
+	amdgpu_dm_ism_commit_event(ism, DM_ISM_EVENT_SSO_TIMER_ELAPSED);
+}
+
+/**
+ * amdgpu_dm_ism_disable - Disable the ISM
+ *
+ * @dm: The amdgpu display manager
+ *
+ * Disable the idle state manager by disabling any ISM work, canceling pending
+ * work, and waiting for in-progress work to finish. After disabling, the system
+ * is left in DM_ISM_STATE_FULL_POWER_RUNNING state.
+ */
+void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_dm_ism *ism;
+
+	drm_for_each_crtc(crtc, dm->ddev) {
+		acrtc = to_amdgpu_crtc(crtc);
+		ism = &acrtc->ism;
+
+		/* Cancel and disable any pending work */
+		disable_delayed_work_sync(&ism->delayed_work);
+		disable_delayed_work_sync(&ism->sso_delayed_work);
+
+		/* When disabled, leave in FULL_POWER_RUNNING state.
+		 * EXIT_IDLE will not queue any work */
+		amdgpu_dm_ism_commit_event(ism,
+					   DM_ISM_EVENT_EXIT_IDLE_REQUESTED);
+	}
+}
+
+/**
+ * amdgpu_dm_ism_enable - enable the ISM
+ *
+ * @dm: The amdgpu display manager
+ *
+ * Re-enable the idle state manager by enabling work that was disabled by
+ * amdgpu_dm_ism_disable.
+ */
+void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_dm_ism *ism;
+
+	drm_for_each_crtc(crtc, dm->ddev) {
+		acrtc = to_amdgpu_crtc(crtc);
+		ism = &acrtc->ism;
+
+		enable_delayed_work(&ism->delayed_work);
+		enable_delayed_work(&ism->sso_delayed_work);
+	}
+}
+
+void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
+			struct amdgpu_dm_ism_config *config)
+{
+	ism->config = *config;
+
+	ism->current_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+	ism->previous_state = DM_ISM_STATE_FULL_POWER_RUNNING;
+	ism->next_record_idx = 0;
+	ism->last_idle_timestamp_ns = 0;
+
+	INIT_DELAYED_WORK(&ism->delayed_work, dm_ism_delayed_work_func);
+	INIT_DELAYED_WORK(&ism->sso_delayed_work, dm_ism_sso_delayed_work_func);
+}
+
+
+void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism)
+{
+	cancel_delayed_work_sync(&ism->sso_delayed_work);
+	cancel_delayed_work_sync(&ism->delayed_work);
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
new file mode 100755
index 0000000000000..ba5ea37800d12
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __AMDGPU_DM_ISM_H__
+#define __AMDGPU_DM_ISM_H__
+
+#include <linux/workqueue.h>
+
+struct amdgpu_crtc;
+struct amdgpu_display_manager;
+
+#define AMDGPU_DM_IDLE_HIST_LEN 16
+
+enum amdgpu_dm_ism_state {
+	DM_ISM_STATE_FULL_POWER_RUNNING = 0,
+	DM_ISM_STATE_FULL_POWER_BUSY,
+	DM_ISM_STATE_HYSTERESIS_WAITING,
+	DM_ISM_STATE_HYSTERESIS_BUSY,
+	DM_ISM_STATE_OPTIMIZED_IDLE,
+	DM_ISM_STATE_OPTIMIZED_IDLE_SSO,
+	DM_ISM_STATE_TIMER_ABORTED,
+	DM_ISM_NUM_STATES,
+};
+
+enum amdgpu_dm_ism_event {
+	DM_ISM_EVENT_IMMEDIATE = 0,
+	DM_ISM_EVENT_ENTER_IDLE_REQUESTED,
+	DM_ISM_EVENT_EXIT_IDLE_REQUESTED,
+	DM_ISM_EVENT_BEGIN_CURSOR_UPDATE,
+	DM_ISM_EVENT_END_CURSOR_UPDATE,
+	DM_ISM_EVENT_TIMER_ELAPSED,
+	DM_ISM_EVENT_SSO_TIMER_ELAPSED,
+	DM_ISM_NUM_EVENTS,
+};
+
+#define STATE_EVENT(state, event) (((state) << 8) | (event))
+
+struct amdgpu_dm_ism_config {
+
+	/**
+	 * @filter_num_frames: Idle periods shorter than this number of frames
+	 * will be considered a "short idle period" for filtering.
+	 *
+	 * 0 indicates no filtering (i.e. no idle allow delay will be applied)
+	 */
+	unsigned int filter_num_frames;
+
+	/**
+	 * @filter_history_size: Number of recent idle periods to consider when
+	 * counting the number of short idle periods.
+	 */
+	unsigned int filter_history_size;
+
+	/**
+	 * @filter_entry_count: When the number of short idle periods within
+	 * recent &filter_history_size reaches this count, the idle allow delay
+	 * will be applied.
+	 *
+	 * 0 indicates no filtering (i.e. no idle allow delay will be applied)
+	 */
+	unsigned int filter_entry_count;
+
+	/**
+	 * @activation_num_delay_frames: Defines the number of frames to wait
+	 * for the idle allow delay.
+	 *
+	 * 0 indicates no filtering (i.e. no idle allow delay will be applied)
+	 */
+	unsigned int activation_num_delay_frames;
+
+	/**
+	 * @filter_old_history_threshold: A time-based restriction on top of
+	 * &filter_history_size. Idle periods older than this threshold (in
+	 * number of frames) will be ignored when counting the number of short
+	 * idle periods.
+	 *
+	 * 0 indicates no time-based restriction, i.e. history is limited only
+	 * by &filter_history_size.
+	 */
+	unsigned int filter_old_history_threshold;
+
+	/**
+	 * @sso_num_frames: Number of frames to delay before enabling static
+	 * screen optimizations, such as PSR1 and Replay low HZ idle mode.
+	 *
+	 * 0 indicates immediate SSO enable upon allowing idle.
+	 */
+	unsigned int sso_num_frames;
+};
+
+struct amdgpu_dm_ism_record {
+	/**
+	 * @timestamp_ns: When idle was allowed
+	 */
+	unsigned long long timestamp_ns;
+
+	/**
+	 * @duration_ns: How long idle was allowed
+	 */
+	unsigned long long duration_ns;
+};
+
+struct amdgpu_dm_ism {
+	struct amdgpu_dm_ism_config config;
+	unsigned long long int last_idle_timestamp_ns;
+
+	enum amdgpu_dm_ism_state current_state;
+	enum amdgpu_dm_ism_state previous_state;
+
+	struct amdgpu_dm_ism_record records[AMDGPU_DM_IDLE_HIST_LEN];
+	int next_record_idx;
+
+	struct delayed_work delayed_work;
+	struct delayed_work sso_delayed_work;
+};
+
+#define ism_to_amdgpu_crtc(ism_ptr) \
+	container_of(ism_ptr, struct amdgpu_crtc, ism)
+
+void amdgpu_dm_ism_init(struct amdgpu_dm_ism *ism,
+			struct amdgpu_dm_ism_config *config);
+void amdgpu_dm_ism_fini(struct amdgpu_dm_ism *ism);
+void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
+				enum amdgpu_dm_ism_event event);
+void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
+void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 812497d428aa0..9ff40f6643ba8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1374,8 +1374,16 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		/* turn off cursor */
 		if (crtc_state && crtc_state->stream) {
 			mutex_lock(&adev->dm.dc_lock);
+			amdgpu_dm_ism_commit_event(
+				&amdgpu_crtc->ism,
+				DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+
 			dc_stream_program_cursor_position(crtc_state->stream,
 						      &position);
+
+			amdgpu_dm_ism_commit_event(
+				&amdgpu_crtc->ism,
+				DM_ISM_EVENT_END_CURSOR_UPDATE);
 			mutex_unlock(&adev->dm.dc_lock);
 		}
 		return;
@@ -1405,6 +1413,10 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
+		amdgpu_dm_ism_commit_event(
+			&amdgpu_crtc->ism,
+			DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+
 		if (!dc_stream_program_cursor_attributes(crtc_state->stream,
 							 &attributes))
 			DRM_ERROR("DC failed to set cursor attributes\n");
@@ -1412,6 +1424,10 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		if (!dc_stream_program_cursor_position(crtc_state->stream,
 						   &position))
 			DRM_ERROR("DC failed to set cursor position\n");
+
+		amdgpu_dm_ism_commit_event(
+			&amdgpu_crtc->ism,
+			DM_ISM_EVENT_END_CURSOR_UPDATE);
 		mutex_unlock(&adev->dm.dc_lock);
 	}
 }
-- 
2.53.0

