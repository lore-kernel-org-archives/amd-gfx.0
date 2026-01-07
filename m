Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32389CFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644F910E646;
	Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LrhlZHi3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9E510E62D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzZZXNbqwfG47PdUov0kt24rMIAw2PQ5emLlxtsjmWj7U69L2oGRkP27lVTGtUkLaKlr4nXWNqlpIZlCfaYSFmL6BAY8mzHUcwOCnftIlU7mFNj68DR8z5/j01bMgqiqPpjnBOFAicN1Ajtipw5RwR5+PAAENrX7AbRhW1lWJUc19W6hI85KU3ae3/QlLxqwK9NcYDEkjIaZ7L7Uf8Vcx3BUswOLWOF3fJKnhI50GpcKM7aiuG19tGUtPiVq+ybpCVrwIRmbyo4atfi2xkotheA07hS8WiEWPUFXUMej9H40MwCx3ymIBgtLjhPhULisfKUXfA3/IyEyB5lDDmu+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m79FdIQFuoKfVn/JIgZDxnXbwJDmFHm8qHyFI0JFLPI=;
 b=gswBFCHi+BYu8CP9uwhVEfOSPQ00VehJBgTPVayuzET4d5K4Zb0QlcajNB/Vybv9uYAvCM79w8+lHd/zduC3UOJHBah8xQme3gz7eTZguOfHN9gwMPIC7Ao+aqEXEjJYneAyhXmpJ84P5+pBFgJB9+TI9Dk8Nl4c04N63//5AFI+bC9ULl9Cj36ZKfsBKW0RB3U33Yk5EwViG9CxnRxHZ6iGdEJSMMoOJG32ka5hditL7j77bb/JvCoKUw92gXm/wt8gzI86RcrvCXpArt7fsVth8qWvMwSvul/G9I0pDs9jfH8lykI8aI6uUguhngXqGwX6EUTBMJ+IZHlXJKuPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m79FdIQFuoKfVn/JIgZDxnXbwJDmFHm8qHyFI0JFLPI=;
 b=LrhlZHi38V9hcnyOtjUmA51Zkem4VaqTlBIL1MOumei36t9Ygqs0k3Jon9H542klO+p9wF+ZDsxkXbqVCSmNTKoaDKNUL6AdR+ugQ7My7E7B22jO72MoA9THWWrPSfw29igL76+pzN/voIL2a+DDhEhYAb0Kbtdz0+7tgEZM4k8=
Received: from CH0P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::22)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:14 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::b8) by CH0P221CA0035.outlook.office365.com
 (2603:10b6:610:11d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed, 7
 Jan 2026 15:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:10 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:10 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 19/21] drm/amd/display: switch to drm_dbg_ macros instead of
 DRM_DEBUG_ variants
Date: Wed, 7 Jan 2026 10:48:11 -0500
Message-ID: <20260107155421.1999951-20-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9c019e-1967-4429-9e54-08de4e0590e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sIBefbdXG5JHrixlL+82xa6Or8vxb2jqyA5mQ7I0ji2MDs6YQZTGlDLn5EIr?=
 =?us-ascii?Q?3wwZcsvLaK+uYiJtvGugABf7tAgcZnEtxnQ8g/+8d2K0dmxBVRLrQQ+vQ4Lp?=
 =?us-ascii?Q?FtZPW7QhEdb3zf7ad2HtegT+vDn1PXCQOYWkjE/J9fhCZh/9xS6+b22/bI4l?=
 =?us-ascii?Q?uq5XMsHuk6trcehGODBRIkQ1h6OgFNjNA3dMr3O5W0DqthN6X7LUPhC3jUSg?=
 =?us-ascii?Q?A3YtxKZ7ZH1VsxKp/NIB7oZkn94SoXe7iU+zdPPqMY1uBQKPMQdX+QNQeNnW?=
 =?us-ascii?Q?tyqZAYYABSffsGPYR2cWiI76y2XDvFexyxLDUbK4fz7zEuiyowvENiyPvN1H?=
 =?us-ascii?Q?cqfQBd7ZZ0as2X3oCMCBT4p1TMpz0D2K0B01xfsPfMYtflSA4V6Ma6lJJCtV?=
 =?us-ascii?Q?5+/8zru5JeHz1t5lAkZVnYhnSQc/reLwJwUuoPFBlq5ZAcenaTJrtn0Hhpgy?=
 =?us-ascii?Q?7vnNOAZa8dXvfTElVK49hmpjGh4O3aogSSSijc8Lj25HCVTZvhBVxeRJImNU?=
 =?us-ascii?Q?Jy/rXRoB52BSp6EbJPqU2Makd5swXEOYbeq/uZpEWaEcHeUJ4cLhxwunRq1g?=
 =?us-ascii?Q?JB5/BsoMnGEs3AaRItHbfmeE/JaPRSlkm2ZcQoIW4NV25ztUgztVEzDhPVWM?=
 =?us-ascii?Q?HJlEEH2Br1k9iTWluMO+53WmtAFFOwQsB46ogAa+F05+VTSx/D1xzpTjBEpW?=
 =?us-ascii?Q?rLDcFVVyZYI1TSdAllKBCzvt+xV26avx+/EHH4MSmxpk5T6qsWBTnOuQo4pA?=
 =?us-ascii?Q?Ij9IpcZHWGGBeZT6JmDVyFXIPWOLYvBq0PQef2MI9H/FJKDCxz4pHynUnJec?=
 =?us-ascii?Q?4R2kVDMO5U5NUavLVjOZ8pP9r8BtDcr0hOvP2t7RVLRIOhaMyqVPSZfg/CUq?=
 =?us-ascii?Q?Xrjwx8FH1AloVXpCnz24GtwZ2i0i5te2cS4YR1XN1WKcNd+It0+g/mL9ZVxE?=
 =?us-ascii?Q?Uvj2LNyPIz+OAsa56pGlXjRVS0QS3rI6dKW7fX+XfIeSXbis+R8gzY4AHl/2?=
 =?us-ascii?Q?hOOCEhVMRhtD2oMl8AjCaEaFH7l9/bHQlw/C/P1MsfDdsWuprQEJjbtA2yKy?=
 =?us-ascii?Q?12rPycuXxh+2kSPOjxJ6oAc5IBZ1oBIKCO6dpLUlKaVqhChYKMhtNBuPjoIh?=
 =?us-ascii?Q?jrhPPSNDQiYFunniqHdCUWiLe8U5WPH+ZX3u4aTL5mia0lM/EebyF6YkC2sC?=
 =?us-ascii?Q?fnNosXoBHX02Owx2ghqnYEC44z1aP4QqTHMDs5e8DoUxeu4o3+Mm0Yk1tWUp?=
 =?us-ascii?Q?RECcbvbEm1MVO0RKwSskbnj70+l4DNkVtDqQEM0lZDtE5Dzm6ytg8weC2Ruw?=
 =?us-ascii?Q?ZhOlIhU6B8nbotshCi/wb7ukP9Tu+9ZDwGqWpK2ChRqp5lnHLRGmSA52+A1f?=
 =?us-ascii?Q?xpsisb7o24+iJVFcnvO+Ua3qz62QX+Xi0JnndlIUHCM62ni+ToBA/Pcnbgxd?=
 =?us-ascii?Q?VmPkAit6uNaAmxAUXl1sykt7UfViCRpx+vEeOJhC7pw7rEljrzXPQVF1heWF?=
 =?us-ascii?Q?eOORGvR8bex8jKUUuJjlk1JksXpjE2wnYdPiIUldXr4Knbo6o8BieVlCCNe8?=
 =?us-ascii?Q?gtjA4f6YYHFOGh5fL8Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:14.5698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c019e-1967-4429-9e54-08de4e0590e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Device pointer sources used:
	- connector->dev - when a DRM connector was available
	- old_plane_crtc->dev / new_plane_crtc->dev - for plane state functions
	- pass in drm_device - for the stream scaling function
	- aconnector->base.dev - for the VSDB parsing function

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ecdf4e44bae5..62968a9fd44a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6393,7 +6393,8 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 			   &flip_addrs->dirty_rect_count, true);
 }
 
-static void update_stream_scaling_settings(const struct drm_display_mode *mode,
+static void update_stream_scaling_settings(struct drm_device *dev,
+					   const struct drm_display_mode *mode,
 					   const struct dm_connector_state *dm_state,
 					   struct dc_stream_state *stream)
 {
@@ -6443,8 +6444,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 	stream->src = src;
 	stream->dst = dst;
 
-	DRM_DEBUG_KMS("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
-		      dst.x, dst.y, dst.width, dst.height);
+	drm_dbg_kms(dev, "Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
+		    dst.x, dst.y, dst.width, dst.height);
 
 }
 
@@ -7332,7 +7333,7 @@ create_stream_for_sink(struct drm_connector *connector,
 		apply_dsc_policy_for_stream(aconnector, sink, stream, &dsc_caps);
 #endif
 
-	update_stream_scaling_settings(&mode, dm_state, stream);
+	update_stream_scaling_settings(dev, &mode, dm_state, stream);
 
 	fill_audio_info(
 		&stream->audio_info,
@@ -8067,7 +8068,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 			dc_result = dm_validate_stream_and_context(adev->dm.dc, stream);
 
 		if (dc_result != DC_OK) {
-			DRM_DEBUG_KMS("Pruned mode %d x %d (clk %d) %s %s -- %s\n",
+			drm_dbg_kms(connector->dev, "Pruned mode %d x %d (clk %d) %s %s -- %s\n",
 				      drm_mode->hdisplay,
 				      drm_mode->vdisplay,
 				      drm_mode->clock,
@@ -8419,7 +8420,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 		drm_dp_atomic_find_time_slots(state, mst_mgr, mst_port,
 					      dm_new_connector_state->pbn);
 	if (dm_new_connector_state->vcpi_slots < 0) {
-		DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_state->vcpi_slots);
+		drm_dbg_atomic(connector->dev, "failed finding vcpi slots: %d\n", (int)dm_new_connector_state->vcpi_slots);
 		return dm_new_connector_state->vcpi_slots;
 	}
 	return 0;
@@ -10869,7 +10870,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		stream_update.stream = dm_new_crtc_state->stream;
 		if (scaling_changed) {
-			update_stream_scaling_settings(&dm_new_con_state->base.crtc->mode,
+			update_stream_scaling_settings(dev, &dm_new_con_state->base.crtc->mode,
 					dm_new_con_state, dm_new_crtc_state->stream);
 
 			stream_update.src = dm_new_crtc_state->stream->src;
@@ -11588,7 +11589,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Scaling or underscan settings */
 	if (is_scaling_state_different(dm_old_conn_state, dm_new_conn_state) ||
 				drm_atomic_crtc_needs_modeset(new_crtc_state))
-		update_stream_scaling_settings(
+		update_stream_scaling_settings(adev_to_drm(adev),
 			&new_crtc_state->mode, dm_new_conn_state, dm_new_crtc_state->stream);
 
 	/* ABM settings */
@@ -11851,7 +11852,7 @@ static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
 	new_acrtc = to_amdgpu_crtc(new_plane_crtc);
 
 	if (new_plane_state->src_x != 0 || new_plane_state->src_y != 0) {
-		DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
+		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not supported for cursor plane\n");
 		return -EINVAL;
 	}
 
@@ -11950,7 +11951,7 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!dm_old_crtc_state->stream)
 			return 0;
 
-		DRM_DEBUG_ATOMIC("Disabling DRM plane: %d on DRM crtc %d\n",
+		drm_dbg_atomic(old_plane_crtc->dev, "Disabling DRM plane: %d on DRM crtc %d\n",
 				plane->base.id, old_plane_crtc->base.id);
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -12003,7 +12004,7 @@ static int dm_update_plane_state(struct dc *dc,
 			goto out;
 		}
 
-		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
+		drm_dbg_atomic(new_plane_crtc->dev, "Enabling DRM plane: %d on DRM crtc %d\n",
 				 plane->base.id, new_plane_crtc->base.id);
 
 		ret = fill_dc_plane_attributes(
@@ -13095,7 +13096,7 @@ static int parse_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 				amd_vsdb->version == HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3) {
 			vsdb_info->replay_mode = (amd_vsdb->feature_caps & AMD_VSDB_VERSION_3_FEATURECAP_REPLAYMODE) ? true : false;
 			vsdb_info->amd_vsdb_version = HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3;
-			DRM_DEBUG_KMS("Panel supports Replay Mode: %d\n", vsdb_info->replay_mode);
+			drm_dbg_kms(aconnector->base.dev, "Panel supports Replay Mode: %d\n", vsdb_info->replay_mode);
 
 			return true;
 		}
-- 
2.52.0

