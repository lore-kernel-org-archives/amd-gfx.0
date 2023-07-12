Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA48EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD05810E5B4;
	Wed, 12 Jul 2023 17:14:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E35B10E5B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGzi2yNm6z3pz5GlSxh3edTcHwUZVYlDlWXOss/93yPJS1x516Ju24ZY7AJpKnbYU5dCdgePP0GZ/r8mvRxkbVUOw9D3XNAMJv5CdLGmnv0mezCe5EIxtuHyXszRcp/2pgi88gm+FrarBnb6iq8RsfZqMKawHgURzMozNSlF8/7SkFDitqKruoEJyfrjVY3K7TKoJh8qIa0KYbShdMYHlYo4oUVCyZDLf2nXbgckyHUNZDMccIHHkyvxE3X+LFxzSHBRmjfoSyHsOEhnpRmInOKlu7P4w8VEY308TTreqxL0D5CcDlGkn0bQmy6pZZCw6qTWHaYE2VFItDXzJxbjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv1UXcBWde2/veGnZnEhFjFiXxNJzBdFdCMF6TX3sgQ=;
 b=a2W+YXAyXS023k3/3b265OAdT8MJN6M9oo3QZdNParvk9lFosAkRX6IeqWDueChTgYJcK9ECWivcoawIKfWt1WcW91sLy0t0bvZDyTScCFslzkCxESJG1EBT11Cf8TvAyACal0JBKPVy0OM4jmDUoV5SnFO7+Qm9NNKO2bA74FwAaBny7booZ6gP45u+4yyKAoCAkrs9kGVoz9Q7+hnP63WjJdYQ/xiRh9/5gWBQYoQJOc/+auEX8c3sz52nlwte9PPQ1JC0zylG2x6SmjF3m5s+m+m7lYVeIg/m/8TncXay1WeX5u03q326v/mZjzbHiCkF6HlDj4hdhZy+cUGVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv1UXcBWde2/veGnZnEhFjFiXxNJzBdFdCMF6TX3sgQ=;
 b=Glex1+32I2isYgvX6n06QLiHkgGQp007D5TXfFAvWw0NbDjTWmX5uXWtI0ZVXY7FdS83WRkgj9m4MvVPDgCodnb6/n78k36jOoVLu8I8a8QpaXkxcPc5TDuy2Ca4nb+wTp4GJFBAwfv70cstOE0Pc4UltGgQ1JhucwilPfPyv5g=
Received: from BN9PR03CA0755.namprd03.prod.outlook.com (2603:10b6:408:13a::10)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 17:14:00 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::19) by BN9PR03CA0755.outlook.office365.com
 (2603:10b6:408:13a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:00 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:51 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: Fix race condition when turning off an
 output alone
Date: Thu, 13 Jul 2023 01:11:25 +0800
Message-ID: <20230712171137.3398344-22-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5d1331-748a-4452-9dc7-08db82fb6295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0t11aTXGG+uFttVxZhRn40X/3/kQUYb8OirsPhud7NUfODw6yKNhHOL3nd7jEc+G65erCp/NMAP5p7hNrFlgmPpc8/hHX7nRSeS3pM/MHiOaQ+LXsRc2w+gqL+PsjbqDyQ4x17RimcNxw3vEywEY0kbcRPu+yVJmIdIjRGAAoPB6Hma95RwKy2ElX2BNNC2rtX/o0vi0CiuLy2F3T4vzm6281CpArsincwyr63O/GAd6mHkgGH5vb3betPRnoU8UPFPOycjTpTCZNOywZ2msdpFpf4+xkbDOWKxp46fqRRqyro0dnTwnFo3Md+j+qfF2DXeCxqXVgeT9j/pU2NnrOU8u9co/RHCCWQOWOT86c/kg/XV7nrq6K8MTZG3weYO9J/rtDQhK8nBaNf/kKksvMQqG2bzMAyPYxhL7NZdRRoDEtsyBakl3IYYC4zmr4fowv8DB4+0OMmrFzpnCrBhrUgjQr1YFbuSH2kTQIK5bq/oM0aEE+C8/ZztEBBGQo31dq+0NgwMxBWHNDVKwJlAbnxoHvstKwmJUgbf2zrPOtV+9die8n0TT3zF493g1hnVFw2SmhQxK4yIN/CeCj/CJ2Cnid4eVod5p0BDIAyb7iwacJtMUX05E5j92NAnx6DfNawuMBuU3SM/kcQwGCesB2hllUn/k6EnrXmadWQqlvkXCV5qyB1DycFxy1lF5DhRbxJaU74tsF1SvoKRwz7wwxb50OTa/DM8Xbkd49q7TgMwIzF2r5u3zT+VnZkuZ6Z8+INnSGuCNLuMdW1WLXul0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(47076005)(83380400001)(41300700001)(36860700001)(426003)(2616005)(40460700003)(2906002)(36756003)(336012)(186003)(356005)(81166007)(5660300002)(82740400003)(26005)(6916009)(4326008)(8936002)(8676002)(1076003)(40480700001)(316002)(70206006)(70586007)(82310400005)(478600001)(86362001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:00.4963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5d1331-748a-4452-9dc7-08db82fb6295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <haoping.liu@amd.com>

[Why]
When 2 threads are doing commit_tail parallelly, one thread could
commit new streams to dc state but another thread remove it from dc
right away.

[How]
If we don't have new dm state change from commit_check, then we should
not call dc_commit_streams() in commit_tail. A new function
amdgpu_dm_commit_streams() is introduced to refator dc_commit_stream()
adjacent code and fix this issue.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Alan Liu <haoping.liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 114 +++++++++---------
 1 file changed, 55 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 88057641972d..1e1a38014475 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7937,7 +7937,6 @@ static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
 }
 
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
-				    struct dc_state *dc_state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
 				    struct drm_crtc *pcrtc,
@@ -8417,52 +8416,17 @@ static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_stat
 	stream_state->mode_changed = drm_atomic_crtc_needs_modeset(crtc_state);
 }
 
-/**
- * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
- * @state: The atomic state to commit
- *
- * This will tell DC to commit the constructed DC state from atomic_check,
- * programming the hardware. Any failures here implies a hardware failure, since
- * atomic check should have filtered anything non-kosher.
- */
-static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
+static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
+					struct dc_state *dc_state)
 {
 	struct drm_device *dev = state->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
-	struct dm_atomic_state *dm_state;
-	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
-	u32 i, j;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	unsigned long flags;
-	bool wait_for_vblank = true;
-	struct drm_connector *connector;
-	struct drm_connector_state *old_con_state, *new_con_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
-	int crtc_disable_count = 0;
 	bool mode_set_reset_required = false;
-	int r;
-
-	trace_amdgpu_dm_atomic_commit_tail_begin(state);
-
-	r = drm_atomic_helper_wait_for_fences(dev, state, false);
-	if (unlikely(r))
-		DRM_ERROR("Waiting for fences timed out!");
-
-	drm_atomic_helper_update_legacy_modeset_state(dev, state);
-	drm_dp_mst_atomic_wait_for_dependencies(state);
-
-	dm_state = dm_atomic_get_new_state(state);
-	if (dm_state && dm_state->context) {
-		dc_state = dm_state->context;
-	} else {
-		/* No state changes, retain current state. */
-		dc_state_temp = dc_create_state(dm->dc);
-		ASSERT(dc_state_temp);
-		dc_state = dc_state_temp;
-		dc_resource_state_copy_construct_current(dm->dc, dc_state);
-	}
+	u32 i;
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
@@ -8561,24 +8525,22 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 	} /* for_each_crtc_in_state() */
 
-	if (dc_state) {
-		/* if there mode set or reset, disable eDP PSR */
-		if (mode_set_reset_required) {
-			if (dm->vblank_control_workqueue)
-				flush_workqueue(dm->vblank_control_workqueue);
+	/* if there mode set or reset, disable eDP PSR */
+	if (mode_set_reset_required) {
+		if (dm->vblank_control_workqueue)
+			flush_workqueue(dm->vblank_control_workqueue);
 
-			amdgpu_dm_psr_disable_all(dm);
-		}
+		amdgpu_dm_psr_disable_all(dm);
+	}
 
-		dm_enable_per_frame_crtc_master_sync(dc_state);
-		mutex_lock(&dm->dc_lock);
-		WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
+	dm_enable_per_frame_crtc_master_sync(dc_state);
+	mutex_lock(&dm->dc_lock);
+	WARN_ON(!dc_commit_streams(dm->dc, dc_state->streams, dc_state->stream_count));
 
-		/* Allow idle optimization when vblank count is 0 for display off */
-		if (dm->active_vblank_irq_count == 0)
-			dc_allow_idle_optimizations(dm->dc, true);
-		mutex_unlock(&dm->dc_lock);
-	}
+	/* Allow idle optimization when vblank count is 0 for display off */
+	if (dm->active_vblank_irq_count == 0)
+		dc_allow_idle_optimizations(dm->dc, true);
+	mutex_unlock(&dm->dc_lock);
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
@@ -8598,6 +8560,44 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				acrtc->otg_inst = status->primary_otg_inst;
 		}
 	}
+}
+
+/**
+ * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
+ * @state: The atomic state to commit
+ *
+ * This will tell DC to commit the constructed DC state from atomic_check,
+ * programming the hardware. Any failures here implies a hardware failure, since
+ * atomic check should have filtered anything non-kosher.
+ */
+static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
+{
+	struct drm_device *dev = state->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct dm_atomic_state *dm_state;
+	struct dc_state *dc_state = NULL;
+	u32 i, j;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	unsigned long flags;
+	bool wait_for_vblank = true;
+	struct drm_connector *connector;
+	struct drm_connector_state *old_con_state, *new_con_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	int crtc_disable_count = 0;
+
+	trace_amdgpu_dm_atomic_commit_tail_begin(state);
+
+	drm_atomic_helper_update_legacy_modeset_state(dev, state);
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
+	dm_state = dm_atomic_get_new_state(state);
+	if (dm_state && dm_state->context) {
+		dc_state = dm_state->context;
+		amdgpu_dm_commit_streams(state, dc_state);
+	}
+
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
@@ -8875,8 +8875,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
 		if (dm_new_crtc_state->stream)
-			amdgpu_dm_commit_planes(state, dc_state, dev,
-						dm, crtc, wait_for_vblank);
+			amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vblank);
 	}
 
 	/* Update audio instances for each connector. */
@@ -8931,9 +8930,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	for (i = 0; i < crtc_disable_count; i++)
 		pm_runtime_put_autosuspend(dev->dev);
 	pm_runtime_mark_last_busy(dev->dev);
-
-	if (dc_state_temp)
-		dc_release_state(dc_state_temp);
 }
 
 static int dm_force_atomic_commit(struct drm_connector *connector)
-- 
2.34.1

