Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A84CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B1910EAE2;
	Tue, 10 May 2022 20:46:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0213010EA40
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSDaLF/ZqxJfPvDcBsIr0GED6giAwaQyv1oJtHD3Gy+TisebITX8L7xP9NkSGan2j6XxeYiFpLBXfcBVMkypj+hI4HzueBLBT7zR6zbIxLp9nWw+vNrwXF5GeN+rvuH/OtD4/oF86hkx6UE7NpITsOYrfktpqPAREjo29lvqU26qlFG3H/ME7uqp5twcJIocfHzY4nvMxV06CCak0RfVpvxX+GeGaEv30XJSWbzM0NXFk+MJzX+YM4k+ztMELW1/a7DEMiK3TqfOxuU4Fm2uocBiWv9ok9wXMNmA383yn8FmfkrOFDCEBV9YpntLFJiuZ290oN7otDjXqz41IrdzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGx3/ipcpBjPHUpT+YhpFd6A0J65ctOT/rqNS5qVZt4=;
 b=T6s8Lt6o1CN72VMDoFQa1+UTRAMPtNn1PAgXr5iMcaUODpVzVUwlWiIfCG4iW59tjr2xWxVCvwTtoplbGklFkdaJsC4Z1o0kLir8ZzVHKNuYswMtOZadJbS9mvM/UOYQKFH4/KHWwK6FRl5oRsw4nfl9y153oDgQkDa4byh8D2gVnX2Agyz5SYw9UP3ke0AxPbJhhR/Iqx95eAZPHVj1PngBTFgMrVl+sZDmYPQ4W0Ypr4IhQgJcqs9q2qg8+/yaKWIb16sNmiwsiUkLPotkJLoujiwMz4GNMzof6PbYuvclHKbAt8puIIYoSsA3yvWErNzolZ3uIa9zOblmjPGDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGx3/ipcpBjPHUpT+YhpFd6A0J65ctOT/rqNS5qVZt4=;
 b=3WCBvyxosBwMTYpZTvwNhHC7qZmq+oljzt95Q1TatrRsKetERL3VRWYAnlsY+TD0uqnCfZSAdLheo50ZdgZYXFfe2W6FjPZoeTbQhwTA4rcoTeZh8bQSFFeuDAN481UQilBHWNhlzVDCGivRfOx+fGAeIMAjcnwFPue5xY2OUHI=
Received: from MW4PR04CA0212.namprd04.prod.outlook.com (2603:10b6:303:87::7)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:48 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8c) by MW4PR04CA0212.outlook.office365.com
 (2603:10b6:303:87::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Tue, 10 May 2022 20:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:46:48 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:46 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:37 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 17/19] drm/amd/display: Implement MPO PSR SU
Date: Tue, 10 May 2022 16:45:06 -0400
Message-ID: <20220510204508.506089-18-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86bda46-31e9-4bcc-382a-08da32c633f8
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42316B3E26B71799BEB8654A8DC99@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUZhGhPwZpueunBxaUG8HdM19MVnA1qAePj6gB0xV+XgZeEsTiHzOmB4c1hZOycgw2HR4uKpHYByEVi4yjm21uJJQfRgLR+GVKU20X8CleW6AWm9Ao+POhPhALmccMhCWufxKceNqNK9gYGRx/TcYv8xaqPFZ9QTB17iGGtNezD2dG/qWvrbGk63AroqIEgbnuXJyX0oFYEXTEq9xdJyVw7p0cApvbTxdYbjEhITAaaCTEhvXKEASFWaIS5s2ZPVNbtl0P/G8F1RzdqH2PXwVv7Bfw5wWCALw8VxkowLsZW4YgLmoqJaisqTg6XPR7J9Wn+DehIz2rDY7BNAsRhmn4EDs4f69yU0l9QEc+DtziPGTlr3eNbErnZmSlLAiDTnVaO4mDqJYtyG2PbXU0GOjG2ywZphwc6OVF3vU5FA9i7VTt+uFeG/65Thib4CnOcFhV6yAZKEGCHuG9nmRLOSVg9CVNF7t70uU8U1ruO3VZInAPx3qwuF8Q4h6bMuFktyqjDXHtcZRmI4LdgAnED1jy9YTip1CtHHAVz7lLoX52ECClDT83JViunLyuJfBBzbDxEX3zXg/Vo+acdp3PLWEYzGuM6EchgjOLxikh62EPOfBboGwuYMe7yyBEtngD+ykaKq99SukAql65DK75hYLbvFGTBTUOvZDcFRLe2VD0LZGsO2qUXAhyZsRrYlE7q+cVf7UKZJZRUZOGEyU1kt+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(86362001)(26005)(70206006)(4326008)(81166007)(8676002)(70586007)(5660300002)(7696005)(508600001)(2906002)(2616005)(36860700001)(54906003)(1076003)(6666004)(6916009)(316002)(36756003)(40460700003)(336012)(82310400005)(426003)(47076005)(83380400001)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:48.1290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86bda46-31e9-4bcc-382a-08da32c633f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
index 2ea20dd7fccf..29dd59d06fa4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1255,10 +1255,20 @@ static void vblank_control_worker(struct work_struct *work)
 
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
@@ -5631,6 +5641,117 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
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
@@ -6579,6 +6700,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
 	state->force_dpms_off = cur->force_dpms_off;
+	state->mpo_requested = cur->mpo_requested;
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
@@ -9219,6 +9341,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
+		fill_dc_dirty_rects(plane, old_plane_state, new_plane_state,
+				    new_crtc_state,
+				    &bundle->flip_addrs[planes_count]);
+
 		/*
 		 * Only allow immediate flips for fast updates that don't
 		 * change FB pitch, DCC state, rotation or mirroing.
@@ -9414,6 +9540,18 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
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
index 52508bdda8e9..c8da18e45b0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -79,10 +79,12 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
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

