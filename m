Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90345C636D7
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D4010E302;
	Sun, 12 Feb 2023 17:00:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAEB10E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR8c0+gzKQFq17y20Awr4DAa33Tc4eEcmuYrnqNFobEPFR3tIJAyJTcqB8Q2MWyNYrbxzVds8JhwNGCvxled54gceeXmGmBlBRef6jNs6GbPAjncmJ3eSeEh8AJcmNoQywCWiMFO/JGt//2MY59gCDqX3mn8x8yGewdZbwWxUaSsioC7f4NgJxDezAQaV3CAHjXkVfbbSaZ07KD4GAvWWv0bmXGC1u9Ij9pNnwKEW/K0ccKC1D8Xq9QaSNXrRd0NpfH6K4ASlKoYvYAZbhMmW/O9SWD3ouBa7L7oXnt9Q8rmqDkhmXC4Z/o4w5zjz4U6FYLpOG7v2yZVgq1tB0fFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJb0k0L3xT63Bf8JZD6oRUKztHpZBPkQ5+vEVmtFYBs=;
 b=K+tA0fVTydvPwHiOVWiKE0ySxHgJZPBTVpgrN5ZIIIPOLGaQPqsHrWyrbZUbAPZE0z2o89vtTmjQ0zY4CU+cKpKepMyh47eVONcJ2ANQ85AW1ZCZDHjfcovVcuzEZIwM8nqRRtO9nIS/AATBgHvHDpjkcVhFErJBFGZJ+DbOcqHHqEo48wh7RbVgvgKD64lDloAeNTlE/JXw6Gmp+sfCnD4IBK2rGG4i0Nt6YFsiXaEEvdJB8jioY+mjHJfKk0PpF4xTToct37YPsiXjxMNCFrIMvBRFEB9RovW5kaEsYKRYtM62jl4H10tpoO69LsauD9dcgSXvEj6fXduC+AC7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJb0k0L3xT63Bf8JZD6oRUKztHpZBPkQ5+vEVmtFYBs=;
 b=Njf8NOlXzsk/5raJnLWQL/rtdXRiVarAD6nDW6uEmKHJDKfnJTQM6O0XzNnmnSQRjz1zex+8slEcJhNNonk3sbKOCTOIm7Bt3eOPiYATUvnPKjFBybywVQ9E/E/GHhXkukqxIfaY0FY54g6F68foPQoKaYFr4DycI38y1Mq40W0=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:46 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::bb) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:42 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:41 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/22] drm/amd/display: Fix video glitch while drag window in
 PSR-SU
Date: Sun, 12 Feb 2023 11:59:45 -0500
Message-ID: <20230212165955.1993601-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6deb19-c63e-4974-11fb-08db0d1aaeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdzHVd7SFyXjU0rVByaMqRF78YA0GpjVMwi14oIrzWFSKsUUUJxJh9P1EuJIE7NUucyZJSjG1yanV5L8ay1JBzHDeAMgpy5y82EI9TaEZTzlC3X8LASnB4qMqeayzT5++8LQvNOajJ63Q4Vg4WCBuqKApEdRknAl1Mwf3ATTMvQoVmXhEbKsT+jk3eEdUIIZZcOFrNUFvNCTwDp98avK3xSfMI0/ZHnI4HLIHiC7Jn7LMkZSBSHXJNZtcs/tj7Jufk3PSYXaa3zbVf/E45jQ86/816gjF4+Oh6AQWX09fETQJ4sZkt6ARtj8bUVzWIEKZt6jxlJVna7pEIOv7+DgDhJdXix3H4LjfbfdlzPJe9fKWNia78fqZPO/2C9FJXWgDuuIjl2jy8wWYG1OHt1SGv5sYxEhX9C7t5b6R7DZcHiG1VOmYQI89TGpBHVOtwKLkcPVISU5/iLnZ57refB4WlbJLIAQLBhzJjAOPfHVChoo0/Ixf2b+dWA+nnswRVNzla4/40mps7ls+nlaR1+Fw1G6QwvtnxWERboHv6XVMayPTkFLn9P32Yjv016AyV5sQAJBmkMEM4F+L7FhvvOj0kN0GirtKd1/QdFqpmlvJGN3V6G6jkpJFI87KNVfBctrKMMr7nKyhQwu5cfxJ45GGZPIsIwHGZs2bG5uQKOcca4epFDR3TCd3/4rMbhV3wtGKFneU25czSHaB2ZPPOGU4YpUk2RPa+7qJfXygsF4fOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(41300700001)(8936002)(44832011)(426003)(47076005)(81166007)(36860700001)(82740400003)(82310400005)(86362001)(36756003)(40480700001)(356005)(40460700003)(2906002)(316002)(54906003)(1076003)(26005)(186003)(16526019)(4326008)(6916009)(336012)(478600001)(2616005)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:45.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6deb19-c63e-4974-11fb-08db0d1aaeda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Dmub will cache the video position data during PSR-SU enable.
The dmub will use an outdated MPO video position if user try
to drag the video window and it will cause video glitch.

[How]
Disable the PSR-SU temporarily while user drag the video window.
The PSR-SU will be re-enabled after the video window is stable.

Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 833d7137c4f4..922adc10894a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5036,6 +5036,7 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
  * @new_plane_state: New state of @plane
  * @crtc_state: New state of CRTC connected to the @plane
  * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
+ * @dirty_regions_changed: dirty regions changed
  *
  * For PSR SU, DC informs the DMUB uController of dirty rectangle regions
  * (referred to as "damage clips" in DRM nomenclature) that require updating on
@@ -5052,7 +5053,8 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *old_plane_state,
 				struct drm_plane_state *new_plane_state,
 				struct drm_crtc_state *crtc_state,
-				struct dc_flip_addrs *flip_addrs)
+				struct dc_flip_addrs *flip_addrs,
+				bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct rect *dirty_rects = flip_addrs->dirty_rects;
@@ -5061,6 +5063,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	bool bb_changed;
 	bool fb_changed;
 	u32 i = 0;
+	*dirty_regions_changed = false;
 
 	/*
 	 * Cursor plane has it's own dirty rect update interface. See
@@ -5105,6 +5108,8 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 		new_plane_state->plane->base.id,
 		bb_changed, fb_changed, num_clips);
 
+	*dirty_regions_changed = bb_changed;
+
 	if (bb_changed) {
 		fill_dc_dirty_rect(new_plane_state->plane, &dirty_rects[i],
 				   new_plane_state->crtc_x,
@@ -7858,7 +7863,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    bool wait_for_vblank)
 {
 	u32 i;
-	u64 timestamp_ns;
+	u64 timestamp_ns = ktime_get_ns();
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
@@ -7873,6 +7878,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
+	bool dirty_rects_changed = false;
 	struct {
 		struct dc_surface_update surface_updates[MAX_SURFACES];
 		struct dc_plane_info plane_infos[MAX_SURFACES];
@@ -7960,10 +7966,32 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
-		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled)
+		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
-					    &bundle->flip_addrs[planes_count]);
+					    &bundle->flip_addrs[planes_count],
+					    &dirty_rects_changed);
+
+			/*
+			 * If the dirty regions changed, PSR-SU need to be disabled temporarily
+			 * and enabled it again after dirty regions are stable to avoid video glitch.
+			 * PSR-SU will be enabled in vblank_control_worker() if user pause the video
+			 * during the PSR-SU was disabled.
+			 */
+			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
+			    acrtc_attach->dm_irq_params.allow_psr_entry &&
+#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
+#endif
+			    dirty_rects_changed) {
+				mutex_lock(&dm->dc_lock);
+				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
+				timestamp_ns;
+				if (acrtc_state->stream->link->psr_settings.psr_allow_active)
+					amdgpu_dm_psr_disable(acrtc_state->stream);
+				mutex_unlock(&dm->dc_lock);
+			}
+		}
 
 		/*
 		 * Only allow immediate flips for fast updates that don't
@@ -8182,7 +8210,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
-			    !acrtc_state->stream->link->psr_settings.psr_allow_active)
+			    !acrtc_state->stream->link->psr_settings.psr_allow_active &&
+			    (timestamp_ns -
+			    acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns) >
+			    500000000)
 				amdgpu_dm_psr_enable(acrtc_state->stream);
 		} else {
 			acrtc_attach->dm_irq_params.allow_psr_entry = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 99cfe6c9858c..ae51e4c1a98e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -102,6 +102,7 @@ struct psr_settings {
 	bool psr_allow_active;			// PSR is currently active
 	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
 	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
+	unsigned long long psr_dirty_rects_change_timestamp_ns;	// for delay of enabling PSR-SU
 
 	/* These parameters are calculated in Driver,
 	 * based on display timing and Sink capabilities.
-- 
2.25.1

