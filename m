Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCCDC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C3010EAF3;
	Thu,  6 Jun 2024 21:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EEBvIVXa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1BE10EB02
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE4Wm19QKtySSzKii8z1qj96+cj3LYjkq5e32iElSBd1ggapF86rEb48mgvGhtHITUW0sSqta5OnEClYVkjbRxyypbDZ4Atm5rKyUW2pw4YKyDNjUFGLFykYhFbsxP1dyXpfezrjGFTKW6hv3qgT29uapE1OP2whpLIr6FBUW/RYRCbbigGIFzfI/ryr1BSa0yreS+Iuqc7ZZkHL1ujZfXBYx98diYmnXqSJX4besIjrxOtBU0twv+52Hxz1JlNWNbUWihXme/cLYR2J8RdWujmqplpZ+6mEC182RGwTJQSn/kZ4SxqI7alDwFKxtk0aNCgDySQnchLdOiuOCIz4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPNw4EXN3d9125uZelAOiCNn3ru4WD46j8UUziBv1PY=;
 b=Xk4CK9dO1QIzTLCfzCqpFx1dkzZBiwTDAhDtKqlHrk931Y6CXSMYdtwN3VKyvUB/OHrqlneAicddLbG3y00y7gD1EUTCmxX7niMWrtairwPgjXf8fEvm/XvUfVgi6EM/qL+t+bNvV2z/ujUHger1oLDzfoFMewBNSmQVu6qz469idgxoDoid228eeq7ZRkjJPLgi8cb0GWV6G6UYWlkbhfhJTLicDgYZc1VOzLZbTmvnSiwbW4fxKs1Q9vU27A8qryxvyWanMqOT7z6YWkBkTPs55OXOEzdR3gCONo88jF8p1wuV9Cbmf5J6EdTiHYuUPiKfctGlrLRwm7B8qj1F6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPNw4EXN3d9125uZelAOiCNn3ru4WD46j8UUziBv1PY=;
 b=EEBvIVXazK6uX3uNT/gw8gjJGEdw58P3/gowOBP8a26Jv6c+foRdCMyj6gITG97dcsw2zVTpr0Xj+Wftss+aWkk8Q0N+AGsqtP/K3dJvX/aEt5HM0ykTrcc/kLFR7m9FXJeX05fyTyrBlmvqkQcIF6xiN3HuLTbU8gqkTskQzZw=
Received: from BLAPR03CA0125.namprd03.prod.outlook.com (2603:10b6:208:32e::10)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 21:57:56 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::10) by BLAPR03CA0125.outlook.office365.com
 (2603:10b6:208:32e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Leo Li <sunpeng.li@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Pekka
 Paalanen" <pekka.paalanen@collabora.com>
Subject: [PATCH 41/67] drm/amd/display: Move PRIMARY plane zpos higher
Date: Thu, 6 Jun 2024 17:56:06 -0400
Message-ID: <20240606215632.4061204-42-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 699e11b2-5c53-4d89-e40d-08dc8673b918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cNhPEYNHa2a32LZXYEUyE4isy1sJ21nOi8Bcpp+zxzPVKvgPjqRXiny+jQ6n?=
 =?us-ascii?Q?4QEUyrp8oJYb7CHB/NK75xodKcp1+gdynzsg1Gy+2nkeqFrC693ba9ClMVCr?=
 =?us-ascii?Q?37mYekJDNHW/zhPIUDrcDcxjAnlCt/4Uhb3901SrsD5jk4bATZ0C7kvqplmF?=
 =?us-ascii?Q?219GtM70QFhCBAkkPdNqaD9ZN8aEkuS+M6xLpfS2ID09szpYCEmQj4HbvpW/?=
 =?us-ascii?Q?0skrmzvYLGPsxD8SsA6GjXzQI6v8JE+iGuxxuMuP7gGF0bRM+YmHyYdu64sH?=
 =?us-ascii?Q?IhGeMLk9h/NhXG3oi8ajwyIpkfSLUQp9wgKpikqBYt5l3FuFZAUWgWA/FTEv?=
 =?us-ascii?Q?qEDK/gYFMG4Zrj+w6UdRXVjws/PzW/b4jnpY2FV4r+K+FNff42+Coa5B4BMw?=
 =?us-ascii?Q?0n+3Sr0t4b/G6cLDiuuEJsFUfVG1DO5TBgzia6sohZpiNm3fDodqkt1aP4qA?=
 =?us-ascii?Q?aarXVeQdibo0QGTWYnM+dsvIDZjDnlig/z0P23+N9cHy2ZGG5URFw/93uk1B?=
 =?us-ascii?Q?SFfsnRXTo83YY5xWwDXbefNTVCHUtLiR5AzhZ2BFdU0L+jfqqD89qmw7LnN6?=
 =?us-ascii?Q?ymbPDZ47k9j0p+ym0R20fjKNpTfsTMUinnB7bKPjhyhbfhxrkr8NIsg87am4?=
 =?us-ascii?Q?whMBQuhFzaq5znqSqjzkikndF7e5EutDVmuYfssiDdhjd20i8YgJPINi43Lo?=
 =?us-ascii?Q?9cwW/25NdRoQZZe+jTigW5zIzmLLyYuAE/VD0mMTU391SG6NYkKPraYJyuh4?=
 =?us-ascii?Q?DPEQvqSHR1XCpBl3nTSRrnuVmFvlqkXfSjzSV6DtXC5omAcuhX/3qijx3cUC?=
 =?us-ascii?Q?3EPlBQBQ1DdXU7IvThT/kUAZIQ0BgSZ/2g5V5pzqV8V6wPAOl4kiTqWqKK1u?=
 =?us-ascii?Q?4251/zTPgYj4kQILtG0NzJPBi85YdPYPwBEWRZkxBv2AN3YQ0dXwVx398aYK?=
 =?us-ascii?Q?lpZfzDkzarsh5m38VTlpFUoebffJk3syjNXG2fdtfPRJbeaOJihKlRK23dgg?=
 =?us-ascii?Q?kMBzNZ5dJj98ssolw8NiPe+fkt3bZWGNNWK2J422+tY+3UHpV3m008Y1kXGU?=
 =?us-ascii?Q?AUi8HSIHKcGYROerYRpw2zXSFit5yfrT9LMtq3Yl9BPjlbvxVo73CIR066r8?=
 =?us-ascii?Q?FWd4ggR38+SZGI4gNYcEp4l6Ff2nj3jhnRvuHpCVZEXY8EViDAQ6a4lJDEMp?=
 =?us-ascii?Q?jN5JexcwU6ud9XPvQAyc9YTNEFVwfG+sf1hvy6GWSEfLzK+AQVv3gKwhNrAZ?=
 =?us-ascii?Q?2hK/YhKGjnYB6l+5k3NOnmgvTR6ITSdGYD+goz9xAN26T6bUtR/yeixdxQl7?=
 =?us-ascii?Q?R/4qS/DKZl9lWoIk0VOf8TvP3xOkITovVlpFQ4N6e6/Hz/WxoFX+Sf0s53b9?=
 =?us-ascii?Q?TBwAkwQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:56.3607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699e11b2-5c53-4d89-e40d-08dc8673b918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Compositors have different ways of assigning surfaces to DRM planes for
render offloading. It may decide between various strategies: overlay,
underlay, or a mix of both (see here for more info:
https://gitlab.freedesktop.org/emersion/libliftoff/-/issues/76)

One way for compositors to implement the underlay strategy is to assign
a higher zpos to the DRM_PRIMARY plane than the DRM_OVERLAY planes,
effectively turning the DRM_OVERLAY plane into an underlay plane.

Today, amdgpu attaches an immutable zpos of 0 to the DRM_PRIMARY plane.
This however, is an arbitrary restriction. DCN pipes are general
purpose, and can be arranged in any z-order. To support compositors
using this allocation scheme, we can set a non-zero immutable zpos for
the PRIMARY, allowing the placement of OVERLAYS (mutable zpos range
0-254) beneath the PRIMARY.

[How]

Assign a zpos = #no of OVERLAY planes to the PRIMARY plane. Then, clean
up any assumptions in the driver of PRIMARY plane having the lowest
zpos.

v2: Fix typo s/decending/descending/

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 +++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 18 +++++++---
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6697ee9b3d72..dbd50a32f5c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -80,6 +80,7 @@
 #include <linux/firmware.h>
 #include <linux/component.h>
 #include <linux/dmi.h>
+#include <linux/sort.h>
 
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
@@ -375,6 +376,20 @@ static inline void reverse_planes_order(struct dc_surface_update *array_of_surfa
 		swap(array_of_surface_update[i], array_of_surface_update[j]);
 }
 
+/*
+ * DC will program planes with their z-order determined by their ordering
+ * in the dc_surface_updates array. This comparator is used to sort them
+ * by descending zpos.
+ */
+static int dm_plane_layer_index_cmp(const void *a, const void *b)
+{
+	const struct dc_surface_update *sa = (struct dc_surface_update *)a;
+	const struct dc_surface_update *sb = (struct dc_surface_update *)b;
+
+	/* Sort by descending dc_plane layer_index (i.e. normalized_zpos) */
+	return sb->surface->layer_index - sa->surface->layer_index;
+}
+
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
  *
@@ -399,7 +414,8 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 						    struct dc_stream_update *stream_update,
 						    struct dc_surface_update *array_of_surface_update)
 {
-	reverse_planes_order(array_of_surface_update, planes_count);
+	sort(array_of_surface_update, planes_count,
+	     sizeof(*array_of_surface_update), dm_plane_layer_index_cmp, NULL);
 
 	/*
 	 * Previous frame finished and HW is ready for optimization.
@@ -9773,6 +9789,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		for (j = 0; j < status->plane_count; j++)
 			dummy_updates[j].surface = status->plane_states[0];
 
+		sort(dummy_updates, status->plane_count,
+		     sizeof(*dummy_updates), dm_plane_layer_index_cmp, NULL);
 
 		mutex_lock(&dm->dc_lock);
 		dc_exit_ips_for_hw_access(dm->dc);
@@ -10508,6 +10526,16 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	if (new_crtc_state->color_mgmt_changed)
 		return true;
 
+	/*
+	 * On zpos change, planes need to be reordered by removing and re-adding
+	 * them one by one to the dc state, in order of descending zpos.
+	 *
+	 * TODO: We can likely skip bandwidth validation if the only thing that
+	 * changed about the plane was it'z z-ordering.
+	 */
+	if (new_crtc_state->zpos_changed)
+		return true;
+
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
 		return true;
 
@@ -11350,7 +11378,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 	/* Remove exiting planes if they are modified */
-	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, new_plane_state) {
 		if (old_plane_state->fb && new_plane_state->fb &&
 		    get_mem_type(old_plane_state->fb) !=
 		    get_mem_type(new_plane_state->fb))
@@ -11395,7 +11423,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	}
 
 	/* Add new/modified planes */
-	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
+	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, new_plane_state) {
 		ret = dm_update_plane_state(dc, state, plane,
 					    old_plane_state,
 					    new_plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 969fc42f9a68..d9ea2cd1638f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -104,8 +104,6 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 	*global_alpha = false;
 	*global_alpha_value = 0xff;
 
-	if (plane_state->plane->type == DRM_PLANE_TYPE_PRIMARY)
-		return;
 
 	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
 		plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
@@ -1709,6 +1707,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	int res = -EPERM;
 	unsigned int supported_rotations;
 	uint64_t *modifiers = NULL;
+	unsigned int primary_zpos = dm->dc->caps.max_slave_planes;
 
 	num_formats = amdgpu_dm_plane_get_plane_formats(plane, plane_cap, formats,
 							ARRAY_SIZE(formats));
@@ -1738,10 +1737,19 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
-		drm_plane_create_zpos_immutable_property(plane, 0);
+		/*
+		 * Allow OVERLAY planes to be used as underlays by assigning an
+		 * immutable zpos = # of OVERLAY planes to the PRIMARY plane.
+		 */
+		drm_plane_create_zpos_immutable_property(plane, primary_zpos);
 	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
-		unsigned int zpos = 1 + drm_plane_index(plane);
-		drm_plane_create_zpos_property(plane, zpos, 1, 254);
+		/*
+		 * OVERLAY planes can be below or above the PRIMARY, but cannot
+		 * be above the CURSOR plane.
+		 */
+		unsigned int zpos = primary_zpos + 1 + drm_plane_index(plane);
+
+		drm_plane_create_zpos_property(plane, zpos, 0, 254);
 	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
-- 
2.34.1

