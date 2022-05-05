Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCDCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4714310E40C;
	Thu,  5 May 2022 14:24:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CC310E270
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeCUN96Kb1kz21rvGaeGg7anAfi/8G0VBbcwnR/XRJJxfUNf6LepuFLMDMK/COCCIz2JRCSmzzpA/W3Dty6KMwOIYAlV3DE1j92LDZTl/TUV6YYtFl+rdmlkSbOM95WO4UeaL2wSIrZSvhqfm9juxwMU1Cjgrc1eT+p98uBJQ+nftCGIHBaYjXLq0L+hSwX1R7pei5ABBiVelqKLDbp3jot8QxjsfcksOaqNhKImuZYVDYfiKlJAjLkXBrIwUNFvmCcUsPEIZFnPzLJVzCf5owHcAZ0quUqZT66nKOH0gsuOh7BstinJS6qwS12HYGXHrd86Lh7MzZPogSUsgu2itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bSHrYzE9J/2u9SN4u6i9yiNNud7J9P4tARTEcv+zPk=;
 b=gZxvmF+LqLJ4P0Bh6PTvA0H8IsqdWw8op33c6KSaolRFkYOmt2ZD+D5BBgLYslsh/DtOt6HSlhcafWstH5ucumswUSh2KGLY2/kDmNhMZl+nbrigF2LdN8gAsNHAItWDWYSKgIOe1kX25xBpJG5TZVmcYJVqp1mXq0Z9mbKm1wkmzMHN1Oynywr/pnfkxGJhI1T/lms5/SgJplh34J5dNCtZ1xGOYcJlgWPzAF3TY803vptrwt/S1MM6PVUyGRUCjKslv7NO6DfOVrT36iFN9O4Q9VivYTSyMxNnlOfke/p5TBitiCZ6d2CXtucT3q+Lc5oAryoO7wOckrfwqmbwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bSHrYzE9J/2u9SN4u6i9yiNNud7J9P4tARTEcv+zPk=;
 b=K1aADu8GhqxnZEBi1xuZRfzr4M8Mc6QL7fd947IWh0+DnNwplLfzxWRLuJEBh09U8z8kcLc3Gc9GM4zs1f6wRw1f3857LujgmMx4YtUkRRJm0JiFL2hG++gPQwR47ZQehDKGQyjb1YVEi9efNqOjckhK5R29kb9Y4CZVBYPl9dE=
Received: from DM6PR10CA0008.namprd10.prod.outlook.com (2603:10b6:5:60::21) by
 MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 14:24:07 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::70) by DM6PR10CA0008.outlook.office365.com
 (2603:10b6:5:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:24:07 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:24:05 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/17] drm/amd/display: Implement MPO PSR SU
Date: Thu, 5 May 2022 10:23:23 -0400
Message-ID: <20220505142323.2566949-18-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20358f49-748a-4497-13c2-08da2ea2ea0d
X-MS-TrafficTypeDiagnostic: MN0PR12MB5737:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5737BB2BBC609ADAD715D47F8DC29@MN0PR12MB5737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zvbBONWXA3vurfLyJM9SwGo7s7+/geUT8zO/GdcDGS8P4Geg7jFMM0nIJ6eLFvnItNF0iBbtvOPMffxFnFS9U2aJl2+MI9vMpK4AS+rGqaoXgeSsQinzZz6mwUcmwQWG9rUvDzWgR+wurz9D5wdZpv5GLh59sOAuFDIJZQCiGnklmsuNeeIOprCEYFW2XUR7V894t5QiPebDqjtD1C0usHpYExxnmX4db4xvRTzuMqgeyD2l+Dm2G1NhXZuEVZWL3YB7X7gthP6fVCgrvY65jksIs3vGoshC2TESjKAO+wx2lrdIZGYb69mhMjG61Swptoi14/uwjauOBCMEmOwLkVSk9e5yrnKXRqF+CxDa9YR8Jg/WX6RNtJ5TXq6SPBx+TSab8P3uNo/ITOohN+AeDE6k2+wGY+OtjLbcv5i2fZ0qZZ3wMSXk0ZFQ/Bjix9UD7KYNF6QLxv0cqbvky56/wV0zlBs4Yld8Jg8YddPWKjeuwj8WTgyAy10D266ddlwK9b4Daus28yRueEnu2TQseC33EYmVWrdx1ykxhZkVfGhb09QGHYSIQRq7BzlnZCHvUQD/JHeCGLbzm8jwmV3Rw3pgClBOkQUNat63FwDVG19nIrifeQntvUB60wRUk3dWM7xGWA7CWMg44kZyPLxKq/lbsARvmu7UDaA4VDvLZJ8ErRZs80ohu/FyfppMIsZZkXPgQ08lihPbGlVXnBFEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(70586007)(8676002)(508600001)(4326008)(70206006)(316002)(54906003)(36756003)(86362001)(356005)(1076003)(40460700003)(81166007)(36860700001)(7696005)(426003)(336012)(186003)(26005)(6666004)(5660300002)(8936002)(82310400005)(2616005)(16526019)(2906002)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:24:07.1714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20358f49-748a-4497-13c2-08da2ea2ea0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[WHY]

For additional power savings, PSR SU (also referred to as PSR2) can be
enabled on eDP panels with PSR SU support.

PSR2 saves more power compared to PSR1 by allowing more opportunities
for the display hardware to be shut down. In comparison to PSR1, Shut
down can now occur in-between frames, as well as in display regions
where there is no visible update. In otherwords, it allows for some
display hw components to be enabled only for a **selectively updated**
region of the visible display. Hence PSR SU.

[HOW]

To define the SU region, support from the OS is required. OS needs to
inform driver of damaged regions that need to be flushed to the eDP
panel. Today, such support is lacking in most compositors.

Therefore, an in-between solution is to implement PSR SU for MPO and
cursor scenarios. The plane bounds can be used to define the damaged
region to be flushed to panel. This is achieved by:

* Leveraging dm_crtc_state->mpo_requested flag to identify when MPO is
  enabled.
* If MPO is enabled, only add updated plane bounds to dirty region.
  Determine plane update by either:
    * Existence of drm damaged clips attached to the plane (added by a
      damage-aware compositor)
    * Change in fb id (flip)
    * Change in plane bounds (position and dimensions)
* If cursor is enabled, the old_pos and new_pos of cursor plus cursor
  size is used as damaged regions(*).

(*) Cursor updates follow a different code path through DC. PSR SU for
cursor is already implemented in DC, and the only thing required to
enable is to set DC_PSR_VERSION_SU_1 on the eDP link. See
dcn10_dmub_update_cursor_data().

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   6 +-
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00ebda0bea44..dd949040c1aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1263,10 +1263,20 @@ static void vblank_control_worker(struct work_struct *work)
 
 	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
-	/* Control PSR based on vblank requirements from OS */
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
 	if (vblank_work->stream && vblank_work->stream->link) {
 		if (vblank_work->enable) {
-			if (vblank_work->stream->link->psr_settings.psr_allow_active)
+			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
+			    vblank_work->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(vblank_work->stream);
 		} else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
 			   !vblank_work->stream->link->psr_settings.psr_allow_active &&
@@ -5662,6 +5672,117 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * fill_dc_dirty_rects() - Fill DC dirty regions for PSR selective updates
+ *
+ * @plane: DRM plane containing dirty regions that need to be flushed to the eDP
+ *         remote fb
+ * @old_plane_state: Old state of @plane
+ * @new_plane_state: New state of @plane
+ * @crtc_state: New state of CRTC connected to the @plane
+ * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
+ *
+ * For PSR SU, DC informs the DMUB uController of dirty rectangle regions
+ * (referred to as "damage clips" in DRM nomenclature) that require updating on
+ * the eDP remote buffer. The responsibility of specifying the dirty regions is
+ * amdgpu_dm's.
+ *
+ * A damage-aware DRM client should fill the FB_DAMAGE_CLIPS property on the
+ * plane with regions that require flushing to the eDP remote buffer. In
+ * addition, certain use cases - such as cursor and multi-plane overlay (MPO) -
+ * implicitly provide damage clips without any client support via the plane
+ * bounds.
+ *
+ * Today, amdgpu_dm only supports the MPO and cursor usecase.
+ *
+ * TODO: Also enable for FB_DAMAGE_CLIPS
+ */
+static void fill_dc_dirty_rects(struct drm_plane *plane,
+				struct drm_plane_state *old_plane_state,
+				struct drm_plane_state *new_plane_state,
+				struct drm_crtc_state *crtc_state,
+				struct dc_flip_addrs *flip_addrs)
+{
+	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
+	struct rect *dirty_rects = flip_addrs->dirty_rects;
+	uint32_t num_clips;
+	bool bb_changed;
+	bool fb_changed;
+	uint32_t i = 0;
+
+	flip_addrs->dirty_rect_count = 0;
+
+	/*
+	 * Cursor plane has it's own dirty rect update interface. See
+	 * dcn10_dmub_update_cursor_data and dmub_cmd_update_cursor_info_data
+	 */
+	if (plane->type == DRM_PLANE_TYPE_CURSOR)
+		return;
+
+	/*
+	 * Today, we only consider MPO use-case for PSR SU. If MPO not
+	 * requested, and there is a plane update, do FFU.
+	 */
+	if (!dm_crtc_state->mpo_requested) {
+		dirty_rects[0].x = 0;
+		dirty_rects[0].y = 0;
+		dirty_rects[0].width = dm_crtc_state->base.mode.crtc_hdisplay;
+		dirty_rects[0].height = dm_crtc_state->base.mode.crtc_vdisplay;
+		flip_addrs->dirty_rect_count = 1;
+		DRM_DEBUG_DRIVER("[PLANE:%d] PSR FFU dirty rect size (%d, %d)\n",
+				 new_plane_state->plane->base.id,
+				 dm_crtc_state->base.mode.crtc_hdisplay,
+				 dm_crtc_state->base.mode.crtc_vdisplay);
+		return;
+	}
+
+	/*
+	 * MPO is requested. Add entire plane bounding box to dirty rects if
+	 * flipped to or damaged.
+	 *
+	 * If plane is moved or resized, also add old bounding box to dirty
+	 * rects.
+	 */
+	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
+	fb_changed = old_plane_state->fb->base.id !=
+		     new_plane_state->fb->base.id;
+	bb_changed = (old_plane_state->crtc_x != new_plane_state->crtc_x ||
+		      old_plane_state->crtc_y != new_plane_state->crtc_y ||
+		      old_plane_state->crtc_w != new_plane_state->crtc_w ||
+		      old_plane_state->crtc_h != new_plane_state->crtc_h);
+
+	DRM_DEBUG_DRIVER("[PLANE:%d] PSR bb_changed:%d fb_changed:%d num_clips:%d\n",
+			 new_plane_state->plane->base.id,
+			 bb_changed, fb_changed, num_clips);
+
+	if (num_clips || fb_changed || bb_changed) {
+		dirty_rects[i].x = new_plane_state->crtc_x;
+		dirty_rects[i].y = new_plane_state->crtc_y;
+		dirty_rects[i].width = new_plane_state->crtc_w;
+		dirty_rects[i].height = new_plane_state->crtc_h;
+		DRM_DEBUG_DRIVER("[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)\n",
+				 new_plane_state->plane->base.id,
+				 dirty_rects[i].x, dirty_rects[i].y,
+				 dirty_rects[i].width, dirty_rects[i].height);
+		i += 1;
+	}
+
+	/* Add old plane bounding-box if plane is moved or resized */
+	if (bb_changed) {
+		dirty_rects[i].x = old_plane_state->crtc_x;
+		dirty_rects[i].y = old_plane_state->crtc_y;
+		dirty_rects[i].width = old_plane_state->crtc_w;
+		dirty_rects[i].height = old_plane_state->crtc_h;
+		DRM_DEBUG_DRIVER("[PLANE:%d] PSR SU dirty rect at (%d, %d) size (%d, %d)\n",
+				old_plane_state->plane->base.id,
+				dirty_rects[i].x, dirty_rects[i].y,
+				dirty_rects[i].width, dirty_rects[i].height);
+		i += 1;
+	}
+
+	flip_addrs->dirty_rect_count = i;
+}
+
 static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 					   const struct dm_connector_state *dm_state,
 					   struct dc_stream_state *stream)
@@ -6610,6 +6731,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
 	state->force_dpms_off = cur->force_dpms_off;
+	state->mpo_requested = cur->mpo_requested;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
@@ -9254,6 +9376,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
+		fill_dc_dirty_rects(plane, old_plane_state, new_plane_state,
+				    new_crtc_state,
+				    &bundle->flip_addrs[planes_count]);
+
 		/*
 		 * Only allow immediate flips for fast updates that don't
 		 * change FB pitch, DCC state, rotation or mirroing.
@@ -9451,6 +9577,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 			/* Allow PSR when skip count is 0. */
 			acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
+
+			/*
+			 * If sink supports PSR SU, there is no need to rely on
+			 * a vblank event disable request to enable PSR. PSR SU
+			 * can be enabled immediately once OS demonstrates an
+			 * adequate number of fast atomic commits to notify KMD
+			 * of update events. See `vblank_control_worker()`.
+			 */
+			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
+			    acrtc_attach->dm_irq_params.allow_psr_entry &&
+			    !acrtc_state->stream->link->psr_settings.psr_allow_active)
+				amdgpu_dm_psr_enable(acrtc_state->stream);
 		} else {
 			acrtc_attach->dm_irq_params.allow_psr_entry = false;
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index ab8fa42156af..eee3150614fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -83,10 +83,12 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 		link->psr_settings.psr_feature_enabled = true;
 	}
 
-	DRM_INFO("PSR support %d, DC PSR ver %d, sink PSR ver %d\n",
+	DRM_INFO("PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
 		link->psr_settings.psr_feature_enabled,
 		link->psr_settings.psr_version,
-		link->dpcd_caps.psr_info.psr_version);
+		link->dpcd_caps.psr_info.psr_version,
+		link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
+		link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
 
 }
 
-- 
2.25.1

