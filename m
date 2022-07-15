Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F32C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EAE10F7C3;
	Sat, 16 Jul 2022 14:35:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B540A10E433
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLuOqgaajdlBFlY0r86VfnunVIZRxYhedJfvQVaO7RveBWpjUTjKFHipbqZtZ6IlAfC/8Ez6E0LTlTkjSrktYCStLww2qKiqgp2fHH++yH+Y5YhsgNwDVXv2wdMzZ2zgSQhHI8Y3BzP/htOSAFx3dUcz309I09W8ARkUwzoK+ZHFWdYBsop7RlkeNxzz4jO9lVwaGh7F53q5sOTSf6Tl1RLo1DGfFSjRIinDZO95uywJXNDl4pP9J+N6BPlsM41ChAJCW0X/vfLSJhR+M3QkSWoZnVXwMbdMgUtLbLf0I/4fhzsHR89QHyXG8fzfXo9xQX6ua8+QDer7cCQyhHbhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXPW31x4/Ml+fll9siKcOQcyX+3+Fa9+dIW6VFk7zS4=;
 b=D3hxfdsxd0r1bo2U89wAJyzPJFiZOmn5+NyP3JgDvy9AI9S8JmDAD2xQF+loeOOzXkPuL9U0Axuyryjfugm5L+IhS+bmr5mnoLyP4RcFfttZGVT0pmZHDrN0CghKgr/htg640VZKEmicqoFf2+UA3NgmubZSvik98cU150MRmc8OxETer1J/uol1ivRoefWWSjegltw4ls06xaKIthjY+0kLP55z/KIQ6vulWfwgMdjc1YZYSAI8jN2ZY8e4S4h4CW5VONOwW9aeyBNRgZNUbTD++gfal2NE8kfEA1d/j5BEj6mUszALWwATnDTqgvhbAs/yHSQm6NOPZWT6vc2gYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXPW31x4/Ml+fll9siKcOQcyX+3+Fa9+dIW6VFk7zS4=;
 b=bVZE15EdkCAfHybSdbZP/TsJmiqX6yqji2IuoQgZrMGmc3t9MXuzAA+6RyNZpHM2ISWbZcpNAF7KkHzO6WRARcRg5nksBs7NVwoAnkVKk43wZ7IZ3CoupT3gLECS7A4oGEQoRfx+UJ03Nc0kI8M44LdJUAvAWPyRyw0t4AmEPeY=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Fri, 15 Jul
 2022 18:17:38 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::46) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.5 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:37 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/31] drm/amd/display: Create a file dedicated for CRTC
Date: Fri, 15 Jul 2022 14:16:43 -0400
Message-ID: <20220715181705.1030401-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42a9e8d-f266-45b3-f798-08da668e4ca4
X-MS-TrafficTypeDiagnostic: LV2PR12MB5797:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epq6ZvCzcLs8aBSdKXr1Sw1NAVhSryG1HdbobFGxPT1V3PqGN+tyfe+uiQy/jA/4BpjQGXGT+RnAtVslcvZozZwbBemcNJmG54WBAwkSFnwhCYiEdELp7ilUmA5AgwMOXSOqpkNdtEvNkW26yFub7Q+qTDG0oDmQqdezyjDQcjGFjjMnwbit4lbvP8RX4AjFOQ39zkqo0dgWxoQOkS5mcsLwDj5aRYuKX7qBw835z+ttb9SVbMipeHdZs0o/WNWAMdNen2tVCW0PhSiyzxIoKfCeS4H+Tclvi9evoAbPr2Cn8/pdXJJlorhvrp8Jqjx3wevZU4SQ+vARjFT4wSLLGUm6AuOYjeR73hdRtX0BoKlH3vCUHgpeXEJvgydetpDbqF6tSsrOvMx0gXHH7yOUWL/UghDEdZxLxsi1am8WVxgyKAZVE/uThNprlSokqWZaHlmdbHWdZ8QBS+rgAA5HgmIDlVDIQn72yPt9vVjY2D06Ec7KMcm6oGEi/pSdE0Z0PPDpLKLH5vXAw4zDmB2rdA4RLXsHdH3XiScq8j4YPC6frBJgxukoqfLPtUfQUKAZkjh5SirQ7E2Pbj6gcdxuiI3gLs63gE9/wfiznLwTOVa/Om6kdEjk2Xi5wBOfbh9NP6HYC69TiGo0+5nw576Rrtya2bJn3PAtTnGgo1gEwx0uWgRFeQRPFJiVYpfqNDnVMc8jUM0v+UNxScfp6SCORqU1y1lX2AHETdFdBf/oaproVPxMF9gBsxBjiZVqXyK603kNxlWS+tILvWl+hG1s+fSgE8iM83hftZM8I5HOfRB4GknmnQ8LI6jkel0wI3qg3E9F9n+VLgmVflBp3BaK6zudaArXakPgzpi1SPprl60=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(83380400001)(8676002)(82740400003)(81166007)(336012)(1076003)(2616005)(47076005)(426003)(316002)(186003)(40480700001)(8936002)(2906002)(4326008)(86362001)(82310400005)(6666004)(356005)(6916009)(5660300002)(41300700001)(478600001)(70206006)(26005)(70586007)(54906003)(36860700001)(36756003)(40460700003)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:38.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a9e8d-f266-45b3-f798-08da668e4ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The amdgpu_dm file contains most of the code that works as an interface
between DRM API and DC. As a result, this file becomes very large since
it comprises multiple abstractions such as CRTC manipulation.

[How]
This commit extracts the CRTC code to its specific file named
amdgpu_dm_crtc. This change does not change anything inside the
functions; the only exception is converting some static functions to a
global function.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 434 +---------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 463 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |  51 ++
 4 files changed, 516 insertions(+), 433 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index ec559ea902a3..90fb0f3cdb6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -28,6 +28,7 @@
 AMDGPUDM = \
 	amdgpu_dm.o \
 	amdgpu_dm_plane.o \
+	amdgpu_dm_crtc.o \
 	amdgpu_dm_irq.o \
 	amdgpu_dm_mst_types.o \
 	amdgpu_dm_color.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ceac70e93ece..bf01ed340ec3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -47,6 +47,7 @@
 #include "atom.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_crtc.h"
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
 #include <drm/drm_hdcp.h>
@@ -204,9 +205,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
 /* removes and deallocates the drm structures, created by the above function */
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
-static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
-			       struct drm_plane *plane,
-			       uint32_t link_index);
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *amdgpu_dm_connector,
 				    uint32_t link_index,
@@ -335,20 +333,6 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 	return NULL;
 }
 
-static inline bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
-{
-	return acrtc->dm_irq_params.freesync_config.state ==
-		       VRR_STATE_ACTIVE_VARIABLE ||
-	       acrtc->dm_irq_params.freesync_config.state ==
-		       VRR_STATE_ACTIVE_FIXED;
-}
-
-static inline bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
-{
-	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
-	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-}
-
 static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 					      struct dm_crtc_state *new_state)
 {
@@ -464,26 +448,6 @@ static void dm_pflip_high_irq(void *interrupt_params)
 		     vrr_active, (int) !e);
 }
 
-static void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
-{
-	struct drm_crtc *crtc = &acrtc->base;
-	struct drm_device *dev = crtc->dev;
-	unsigned long flags;
-
-	drm_crtc_handle_vblank(crtc);
-
-	spin_lock_irqsave(&dev->event_lock, flags);
-
-	/* Send completion event for cursor-only commits */
-	if (acrtc->event && acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
-		drm_crtc_send_vblank_event(crtc, acrtc->event);
-		drm_crtc_vblank_put(crtc);
-		acrtc->event = NULL;
-	}
-
-	spin_unlock_irqrestore(&dev->event_lock, flags);
-}
-
 static void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
@@ -1261,52 +1225,6 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
-static void vblank_control_worker(struct work_struct *work)
-{
-	struct vblank_control_work *vblank_work =
-		container_of(work, struct vblank_control_work, work);
-	struct amdgpu_display_manager *dm = vblank_work->dm;
-
-	mutex_lock(&dm->dc_lock);
-
-	if (vblank_work->enable)
-		dm->active_vblank_irq_count++;
-	else if(dm->active_vblank_irq_count)
-		dm->active_vblank_irq_count--;
-
-	dc_allow_idle_optimizations(dm->dc, dm->active_vblank_irq_count == 0);
-
-	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
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
-	if (vblank_work->stream && vblank_work->stream->link) {
-		if (vblank_work->enable) {
-			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
-			    vblank_work->stream->link->psr_settings.psr_allow_active)
-				amdgpu_dm_psr_disable(vblank_work->stream);
-		} else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
-			   !vblank_work->stream->link->psr_settings.psr_allow_active &&
-			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
-			amdgpu_dm_psr_enable(vblank_work->stream);
-		}
-	}
-
-	mutex_unlock(&dm->dc_lock);
-
-	dc_stream_release(vblank_work->stream);
-
-	kfree(vblank_work);
-}
-
 static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
@@ -2382,9 +2300,6 @@ static int dm_hw_fini(void *handle)
 }
 
 
-static int dm_enable_vblank(struct drm_crtc *crtc);
-static void dm_disable_vblank(struct drm_crtc *crtc);
-
 static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 				 struct dc_state *state, bool enable)
 {
@@ -4676,13 +4591,6 @@ static int dm_early_init(void *handle)
 	return 0;
 }
 
-static bool modeset_required(struct drm_crtc_state *crtc_state,
-			     struct dc_stream_state *new_stream,
-			     struct dc_stream_state *old_stream)
-{
-	return crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
-}
-
 static bool modereset_required(struct drm_crtc_state *crtc_state)
 {
 	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
@@ -5913,182 +5821,6 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	return stream;
 }
 
-static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
-{
-	drm_crtc_cleanup(crtc);
-	kfree(crtc);
-}
-
-static void dm_crtc_destroy_state(struct drm_crtc *crtc,
-				  struct drm_crtc_state *state)
-{
-	struct dm_crtc_state *cur = to_dm_crtc_state(state);
-
-	/* TODO Destroy dc_stream objects are stream object is flattened */
-	if (cur->stream)
-		dc_stream_release(cur->stream);
-
-
-	__drm_atomic_helper_crtc_destroy_state(state);
-
-
-	kfree(state);
-}
-
-static void dm_crtc_reset_state(struct drm_crtc *crtc)
-{
-	struct dm_crtc_state *state;
-
-	if (crtc->state)
-		dm_crtc_destroy_state(crtc, crtc->state);
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (WARN_ON(!state))
-		return;
-
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
-}
-
-static struct drm_crtc_state *
-dm_crtc_duplicate_state(struct drm_crtc *crtc)
-{
-	struct dm_crtc_state *state, *cur;
-
-	cur = to_dm_crtc_state(crtc->state);
-
-	if (WARN_ON(!crtc->state))
-		return NULL;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return NULL;
-
-	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
-
-	if (cur->stream) {
-		state->stream = cur->stream;
-		dc_stream_retain(state->stream);
-	}
-
-	state->active_planes = cur->active_planes;
-	state->vrr_infopacket = cur->vrr_infopacket;
-	state->abm_level = cur->abm_level;
-	state->vrr_supported = cur->vrr_supported;
-	state->freesync_config = cur->freesync_config;
-	state->cm_has_degamma = cur->cm_has_degamma;
-	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
-	state->mpo_requested = cur->mpo_requested;
-	/* TODO Duplicate dc_stream after objects are stream object is flattened */
-
-	return &state->base;
-}
-
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
-{
-	crtc_debugfs_init(crtc);
-
-	return 0;
-}
-#endif
-
-static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
-{
-	enum dc_irq_source irq_source;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	int rc;
-
-	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
-
-	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
-
-	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
-		      acrtc->crtc_id, enable ? "en" : "dis", rc);
-	return rc;
-}
-
-static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
-{
-	enum dc_irq_source irq_source;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
-	struct amdgpu_display_manager *dm = &adev->dm;
-	struct vblank_control_work *work;
-	int rc = 0;
-
-	if (enable) {
-		/* vblank irq on -> Only need vupdate irq in vrr mode */
-		if (amdgpu_dm_vrr_active(acrtc_state))
-			rc = dm_set_vupdate_irq(crtc, true);
-	} else {
-		/* vblank irq off -> vupdate irq off */
-		rc = dm_set_vupdate_irq(crtc, false);
-	}
-
-	if (rc)
-		return rc;
-
-	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
-
-	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-		return -EBUSY;
-
-	if (amdgpu_in_reset(adev))
-		return 0;
-
-	if (dm->vblank_control_workqueue) {
-		work = kzalloc(sizeof(*work), GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
-
-		INIT_WORK(&work->work, vblank_control_worker);
-		work->dm = dm;
-		work->acrtc = acrtc;
-		work->enable = enable;
-
-		if (acrtc_state->stream) {
-			dc_stream_retain(acrtc_state->stream);
-			work->stream = acrtc_state->stream;
-		}
-
-		queue_work(dm->vblank_control_workqueue, &work->work);
-	}
-
-	return 0;
-}
-
-static int dm_enable_vblank(struct drm_crtc *crtc)
-{
-	return dm_set_vblank(crtc, true);
-}
-
-static void dm_disable_vblank(struct drm_crtc *crtc)
-{
-	dm_set_vblank(crtc, false);
-}
-
-/* Implemented only the options currently available for the driver */
-static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
-	.reset = dm_crtc_reset_state,
-	.destroy = amdgpu_dm_crtc_destroy,
-	.set_config = drm_atomic_helper_set_config,
-	.page_flip = drm_atomic_helper_page_flip,
-	.atomic_duplicate_state = dm_crtc_duplicate_state,
-	.atomic_destroy_state = dm_crtc_destroy_state,
-	.set_crc_source = amdgpu_dm_crtc_set_crc_source,
-	.verify_crc_source = amdgpu_dm_crtc_verify_crc_source,
-	.get_crc_sources = amdgpu_dm_crtc_get_crc_sources,
-	.get_vblank_counter = amdgpu_get_vblank_counter_kms,
-	.enable_vblank = dm_enable_vblank,
-	.disable_vblank = dm_disable_vblank,
-	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	.late_register = amdgpu_dm_crtc_late_register,
-#endif
-};
-
 static enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -6624,113 +6356,6 @@ amdgpu_dm_connector_helper_funcs = {
 	.atomic_check = amdgpu_dm_connector_atomic_check,
 };
 
-static void dm_crtc_helper_disable(struct drm_crtc *crtc)
-{
-}
-
-static int count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
-{
-	struct drm_atomic_state *state = new_crtc_state->state;
-	struct drm_plane *plane;
-	int num_active = 0;
-
-	drm_for_each_plane_mask(plane, state->dev, new_crtc_state->plane_mask) {
-		struct drm_plane_state *new_plane_state;
-
-		/* Cursor planes are "fake". */
-		if (plane->type == DRM_PLANE_TYPE_CURSOR)
-			continue;
-
-		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
-
-		if (!new_plane_state) {
-			/*
-			 * The plane is enable on the CRTC and hasn't changed
-			 * state. This means that it previously passed
-			 * validation and is therefore enabled.
-			 */
-			num_active += 1;
-			continue;
-		}
-
-		/* We need a framebuffer to be considered enabled. */
-		num_active += (new_plane_state->fb != NULL);
-	}
-
-	return num_active;
-}
-
-static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
-					 struct drm_crtc_state *new_crtc_state)
-{
-	struct dm_crtc_state *dm_new_crtc_state =
-		to_dm_crtc_state(new_crtc_state);
-
-	dm_new_crtc_state->active_planes = 0;
-
-	if (!dm_new_crtc_state->stream)
-		return;
-
-	dm_new_crtc_state->active_planes =
-		count_crtc_active_planes(new_crtc_state);
-}
-
-static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
-				      struct drm_atomic_state *state)
-{
-	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
-										crtc);
-	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	struct dc *dc = adev->dm.dc;
-	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
-	int ret = -EINVAL;
-
-	trace_amdgpu_dm_crtc_atomic_check(crtc_state);
-
-	dm_update_crtc_active_planes(crtc, crtc_state);
-
-	if (WARN_ON(unlikely(!dm_crtc_state->stream &&
-			modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
-		return ret;
-	}
-
-	/*
-	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
-	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
-	 * planes are disabled, which is not supported by the hardware. And there is legacy
-	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
-	 */
-	if (crtc_state->enable &&
-		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
-		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
-		return -EINVAL;
-	}
-
-	/* In some use cases, like reset, no stream is attached */
-	if (!dm_crtc_state->stream)
-		return 0;
-
-	if (dc_validate_stream(dc, dm_crtc_state->stream) == DC_OK)
-		return 0;
-
-	DRM_DEBUG_ATOMIC("Failed DC stream validation\n");
-	return ret;
-}
-
-static bool dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
-				      const struct drm_display_mode *mode,
-				      struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
-static const struct drm_crtc_helper_funcs amdgpu_dm_crtc_helper_funcs = {
-	.disable = dm_crtc_helper_disable,
-	.atomic_check = dm_crtc_helper_atomic_check,
-	.mode_fixup = dm_crtc_helper_mode_fixup,
-	.get_scanout_position = amdgpu_crtc_get_scanout_position,
-};
-
 static void dm_encoder_helper_disable(struct drm_encoder *encoder)
 {
 
@@ -6888,63 +6513,6 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 }
 #endif
 
-static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
-			       struct drm_plane *plane,
-			       uint32_t crtc_index)
-{
-	struct amdgpu_crtc *acrtc = NULL;
-	struct drm_plane *cursor_plane;
-
-	int res = -ENOMEM;
-
-	cursor_plane = kzalloc(sizeof(*cursor_plane), GFP_KERNEL);
-	if (!cursor_plane)
-		goto fail;
-
-	cursor_plane->type = DRM_PLANE_TYPE_CURSOR;
-	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
-
-	acrtc = kzalloc(sizeof(struct amdgpu_crtc), GFP_KERNEL);
-	if (!acrtc)
-		goto fail;
-
-	res = drm_crtc_init_with_planes(
-			dm->ddev,
-			&acrtc->base,
-			plane,
-			cursor_plane,
-			&amdgpu_dm_crtc_funcs, NULL);
-
-	if (res)
-		goto fail;
-
-	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
-
-	/* Create (reset) the plane state */
-	if (acrtc->base.funcs->reset)
-		acrtc->base.funcs->reset(&acrtc->base);
-
-	acrtc->max_cursor_width = dm->adev->dm.dc->caps.max_cursor_size;
-	acrtc->max_cursor_height = dm->adev->dm.dc->caps.max_cursor_size;
-
-	acrtc->crtc_id = crtc_index;
-	acrtc->base.enabled = false;
-	acrtc->otg_inst = -1;
-
-	dm->adev->mode_info.crtcs[crtc_index] = acrtc;
-	drm_crtc_enable_color_mgmt(&acrtc->base, MAX_COLOR_LUT_ENTRIES,
-				   true, MAX_COLOR_LUT_ENTRIES);
-	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
-
-	return 0;
-
-fail:
-	kfree(acrtc);
-	kfree(cursor_plane);
-	return res;
-}
-
-
 static int to_drm_connector_type(enum signal_type st)
 {
 	switch (st) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
new file mode 100644
index 000000000000..a9413acfe4dc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include <drm/drm_vblank.h>
+#include <drm/drm_atomic_helper.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_trace.h"
+#include "amdgpu_dm_debugfs.h"
+
+void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
+{
+	struct drm_crtc *crtc = &acrtc->base;
+	struct drm_device *dev = crtc->dev;
+	unsigned long flags;
+
+	drm_crtc_handle_vblank(crtc);
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+
+	/* Send completion event for cursor-only commits */
+	if (acrtc->event && acrtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
+		drm_crtc_send_vblank_event(crtc, acrtc->event);
+		drm_crtc_vblank_put(crtc);
+		acrtc->event = NULL;
+	}
+
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+bool modeset_required(struct drm_crtc_state *crtc_state,
+			     struct dc_stream_state *new_stream,
+			     struct dc_stream_state *old_stream)
+{
+	return crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
+}
+
+bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)
+
+{
+	return acrtc->dm_irq_params.freesync_config.state ==
+		       VRR_STATE_ACTIVE_VARIABLE ||
+	       acrtc->dm_irq_params.freesync_config.state ==
+		       VRR_STATE_ACTIVE_FIXED;
+}
+
+int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
+{
+	enum dc_irq_source irq_source;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	int rc;
+
+	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
+
+	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
+
+	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
+		      acrtc->crtc_id, enable ? "en" : "dis", rc);
+	return rc;
+}
+
+bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
+{
+	return dm_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE ||
+	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
+}
+
+static void vblank_control_worker(struct work_struct *work)
+{
+	struct vblank_control_work *vblank_work =
+		container_of(work, struct vblank_control_work, work);
+	struct amdgpu_display_manager *dm = vblank_work->dm;
+
+	mutex_lock(&dm->dc_lock);
+
+	if (vblank_work->enable)
+		dm->active_vblank_irq_count++;
+	else if (dm->active_vblank_irq_count)
+		dm->active_vblank_irq_count--;
+
+	dc_allow_idle_optimizations(
+		dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
+
+	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+
+	/*
+	 * Control PSR based on vblank requirements from OS
+	 *
+	 * If panel supports PSR SU, there's no need to disable PSR when OS is
+	 * submitting fast atomic commits (we infer this by whether the OS
+	 * requests vblank events). Fast atomic commits will simply trigger a
+	 * full-frame-update (FFU); a specific case of selective-update (SU)
+	 * where the SU region is the full hactive*vactive region. See
+	 * fill_dc_dirty_rects().
+	 */
+	if (vblank_work->stream && vblank_work->stream->link) {
+		if (vblank_work->enable) {
+			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
+			    vblank_work->stream->link->psr_settings.psr_allow_active)
+				amdgpu_dm_psr_disable(vblank_work->stream);
+		} else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
+			   !vblank_work->stream->link->psr_settings.psr_allow_active &&
+			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
+			amdgpu_dm_psr_enable(vblank_work->stream);
+		}
+	}
+
+	mutex_unlock(&dm->dc_lock);
+
+	dc_stream_release(vblank_work->stream);
+
+	kfree(vblank_work);
+}
+
+static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
+{
+	enum dc_irq_source irq_source;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct vblank_control_work *work;
+	int rc = 0;
+
+	if (enable) {
+		/* vblank irq on -> Only need vupdate irq in vrr mode */
+		if (amdgpu_dm_vrr_active(acrtc_state))
+			rc = dm_set_vupdate_irq(crtc, true);
+	} else {
+		/* vblank irq off -> vupdate irq off */
+		rc = dm_set_vupdate_irq(crtc, false);
+	}
+
+	if (rc)
+		return rc;
+
+	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+
+	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+		return -EBUSY;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	if (dm->vblank_control_workqueue) {
+		work = kzalloc(sizeof(*work), GFP_ATOMIC);
+		if (!work)
+			return -ENOMEM;
+
+		INIT_WORK(&work->work, vblank_control_worker);
+		work->dm = dm;
+		work->acrtc = acrtc;
+		work->enable = enable;
+
+		if (acrtc_state->stream) {
+			dc_stream_retain(acrtc_state->stream);
+			work->stream = acrtc_state->stream;
+		}
+
+		queue_work(dm->vblank_control_workqueue, &work->work);
+	}
+
+	return 0;
+}
+
+int dm_enable_vblank(struct drm_crtc *crtc)
+{
+	return dm_set_vblank(crtc, true);
+}
+
+void dm_disable_vblank(struct drm_crtc *crtc)
+{
+	dm_set_vblank(crtc, false);
+}
+
+static void dm_crtc_destroy_state(struct drm_crtc *crtc,
+				  struct drm_crtc_state *state)
+{
+	struct dm_crtc_state *cur = to_dm_crtc_state(state);
+
+	/* TODO Destroy dc_stream objects are stream object is flattened */
+	if (cur->stream)
+		dc_stream_release(cur->stream);
+
+
+	__drm_atomic_helper_crtc_destroy_state(state);
+
+
+	kfree(state);
+}
+
+static struct drm_crtc_state *dm_crtc_duplicate_state(struct drm_crtc *crtc)
+{
+	struct dm_crtc_state *state, *cur;
+
+	cur = to_dm_crtc_state(crtc->state);
+
+	if (WARN_ON(!crtc->state))
+		return NULL;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
+
+	if (cur->stream) {
+		state->stream = cur->stream;
+		dc_stream_retain(state->stream);
+	}
+
+	state->active_planes = cur->active_planes;
+	state->vrr_infopacket = cur->vrr_infopacket;
+	state->abm_level = cur->abm_level;
+	state->vrr_supported = cur->vrr_supported;
+	state->freesync_config = cur->freesync_config;
+	state->cm_has_degamma = cur->cm_has_degamma;
+	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
+	state->mpo_requested = cur->mpo_requested;
+	/* TODO Duplicate dc_stream after objects are stream object is flattened */
+
+	return &state->base;
+}
+
+static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
+{
+	drm_crtc_cleanup(crtc);
+	kfree(crtc);
+}
+
+static void dm_crtc_reset_state(struct drm_crtc *crtc)
+{
+	struct dm_crtc_state *state;
+
+	if (crtc->state)
+		dm_crtc_destroy_state(crtc, crtc->state);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (WARN_ON(!state))
+		return;
+
+	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+}
+
+#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
+{
+	crtc_debugfs_init(crtc);
+
+	return 0;
+}
+#endif
+
+/* Implemented only the options currently available for the driver */
+static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
+	.reset = dm_crtc_reset_state,
+	.destroy = amdgpu_dm_crtc_destroy,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = dm_crtc_duplicate_state,
+	.atomic_destroy_state = dm_crtc_destroy_state,
+	.set_crc_source = amdgpu_dm_crtc_set_crc_source,
+	.verify_crc_source = amdgpu_dm_crtc_verify_crc_source,
+	.get_crc_sources = amdgpu_dm_crtc_get_crc_sources,
+	.get_vblank_counter = amdgpu_get_vblank_counter_kms,
+	.enable_vblank = dm_enable_vblank,
+	.disable_vblank = dm_disable_vblank,
+	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	.late_register = amdgpu_dm_crtc_late_register,
+#endif
+};
+
+static void dm_crtc_helper_disable(struct drm_crtc *crtc)
+{
+}
+
+static int count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
+{
+	struct drm_atomic_state *state = new_crtc_state->state;
+	struct drm_plane *plane;
+	int num_active = 0;
+
+	drm_for_each_plane_mask(plane, state->dev, new_crtc_state->plane_mask) {
+		struct drm_plane_state *new_plane_state;
+
+		/* Cursor planes are "fake". */
+		if (plane->type == DRM_PLANE_TYPE_CURSOR)
+			continue;
+
+		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+
+		if (!new_plane_state) {
+			/*
+			 * The plane is enable on the CRTC and hasn't changed
+			 * state. This means that it previously passed
+			 * validation and is therefore enabled.
+			 */
+			num_active += 1;
+			continue;
+		}
+
+		/* We need a framebuffer to be considered enabled. */
+		num_active += (new_plane_state->fb != NULL);
+	}
+
+	return num_active;
+}
+
+static void dm_update_crtc_active_planes(struct drm_crtc *crtc,
+					 struct drm_crtc_state *new_crtc_state)
+{
+	struct dm_crtc_state *dm_new_crtc_state =
+		to_dm_crtc_state(new_crtc_state);
+
+	dm_new_crtc_state->active_planes = 0;
+
+	if (!dm_new_crtc_state->stream)
+		return;
+
+	dm_new_crtc_state->active_planes =
+		count_crtc_active_planes(new_crtc_state);
+}
+
+static bool dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+				      const struct drm_display_mode *mode,
+				      struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+				      struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+										crtc);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct dc *dc = adev->dm.dc;
+	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
+	int ret = -EINVAL;
+
+	trace_amdgpu_dm_crtc_atomic_check(crtc_state);
+
+	dm_update_crtc_active_planes(crtc, crtc_state);
+
+	if (WARN_ON(unlikely(!dm_crtc_state->stream &&
+			modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
+		return ret;
+	}
+
+	/*
+	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
+	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
+	 * planes are disabled, which is not supported by the hardware. And there is legacy
+	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
+	 */
+	if (crtc_state->enable &&
+		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
+		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
+		return -EINVAL;
+	}
+
+	/* In some use cases, like reset, no stream is attached */
+	if (!dm_crtc_state->stream)
+		return 0;
+
+	if (dc_validate_stream(dc, dm_crtc_state->stream) == DC_OK)
+		return 0;
+
+	DRM_DEBUG_ATOMIC("Failed DC stream validation\n");
+	return ret;
+}
+
+static const struct drm_crtc_helper_funcs amdgpu_dm_crtc_helper_funcs = {
+	.disable = dm_crtc_helper_disable,
+	.atomic_check = dm_crtc_helper_atomic_check,
+	.mode_fixup = dm_crtc_helper_mode_fixup,
+	.get_scanout_position = amdgpu_crtc_get_scanout_position,
+};
+
+int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
+			       struct drm_plane *plane,
+			       uint32_t crtc_index)
+{
+	struct amdgpu_crtc *acrtc = NULL;
+	struct drm_plane *cursor_plane;
+
+	int res = -ENOMEM;
+
+	cursor_plane = kzalloc(sizeof(*cursor_plane), GFP_KERNEL);
+	if (!cursor_plane)
+		goto fail;
+
+	cursor_plane->type = DRM_PLANE_TYPE_CURSOR;
+	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
+
+	acrtc = kzalloc(sizeof(struct amdgpu_crtc), GFP_KERNEL);
+	if (!acrtc)
+		goto fail;
+
+	res = drm_crtc_init_with_planes(
+			dm->ddev,
+			&acrtc->base,
+			plane,
+			cursor_plane,
+			&amdgpu_dm_crtc_funcs, NULL);
+
+	if (res)
+		goto fail;
+
+	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
+
+	/* Create (reset) the plane state */
+	if (acrtc->base.funcs->reset)
+		acrtc->base.funcs->reset(&acrtc->base);
+
+	acrtc->max_cursor_width = dm->adev->dm.dc->caps.max_cursor_size;
+	acrtc->max_cursor_height = dm->adev->dm.dc->caps.max_cursor_size;
+
+	acrtc->crtc_id = crtc_index;
+	acrtc->base.enabled = false;
+	acrtc->otg_inst = -1;
+
+	dm->adev->mode_info.crtcs[crtc_index] = acrtc;
+	drm_crtc_enable_color_mgmt(&acrtc->base, MAX_COLOR_LUT_ENTRIES,
+				   true, MAX_COLOR_LUT_ENTRIES);
+	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
+
+	return 0;
+
+fail:
+	kfree(acrtc);
+	kfree(cursor_plane);
+	return res;
+}
+
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
new file mode 100644
index 000000000000..1ac8692354cf
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_DM_CRTC_H__
+#define __AMDGPU_DM_CRTC_H__
+
+void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc);
+
+bool modeset_required(struct drm_crtc_state *crtc_state,
+		      struct dc_stream_state *new_stream,
+		      struct dc_stream_state *old_stream);
+
+int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable);
+
+bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc);
+
+bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state);
+
+int dm_enable_vblank(struct drm_crtc *crtc);
+
+void dm_disable_vblank(struct drm_crtc *crtc);
+
+int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
+			struct drm_plane *plane,
+			uint32_t link_index);
+
+#endif
+
-- 
2.37.0

