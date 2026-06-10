Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80640CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF0510E884;
	Wed, 10 Jun 2026 09:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9n0DJ8f";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0EA010E884
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9FhbN6eY16PC57yLcQrQIGpsJDJxhbkIySZFvhkRUD4ghBoR0+bF+jYDY/N+h6pMadbmHZ2/5wJROnZonMEhu09adPD3PjQNbLojGJEJ6YIdgQIKeCzhXw8DFQaFMJbVa4NU5M3148ioocS+k6/Unw+uJfINshG1DmhWPHOK5htsmeXDDE9/TyfOD28+peo/ZPiOWt+Vx2W9tcvreidKLujafawzKKnlaawZXsiFKmDuKzXlSXmcWtPQQxwtHJ2DXTCmjvE1ymraEDeXKNakYFrYhVffAttCMOKHIRR53USJiA8OcWNWTzki46rPcsn9Mo1mNZzb1CsjJIC8Gemwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAm/bkByOn9wLXbnH4x4s4mqF5/x1G0VhNe9vrCNuSo=;
 b=IqANEQRAXqOxr4U098MXrHyXVQa9FAlg7xi+49szG0vz7sP/ygNnDjprCN6YSYX+hOdEnNGDKPOOXYSQzbr4eyEF6Uo+ho03gWDfx7iRYczYnqM9b28lfYB/tPdLXRM2bV2UzoVrnCjYI2bp0WuASDihat7WjEFzuWrTsybrrDiqit7YyGhmnPEMEBq9Ge/ehdGlr3Yit2avxsoujwKbkbBFlFkvus2KZ/OBqpUod1vPLJgvwsT8FM1ZAPgcbNVtT9nCNQZAuT6n5VQKAPCb9gKG42kzdgDP8z8BItcbP6yh6c635+tZvI5NRTc6rDR7TUA/aRR+pb+8SdRR4tTC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAm/bkByOn9wLXbnH4x4s4mqF5/x1G0VhNe9vrCNuSo=;
 b=n9n0DJ8fzUtNtje6IwXSxOWoBzyqEnubfMcKq6ANK7twU3Ec0XOKg10OINOObYmiFq9U3+yHtqveEqHF1Spz+rSRjIBUdDMKxpY3/3C6U9UacOb3x50cn46gnmQzqBapDKwafAuL67bBKPckNjWKRlf6iFznPpnjgga7uY1gWsU=
Received: from PH8PR02CA0043.namprd02.prod.outlook.com (2603:10b6:510:2da::12)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:50:39 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::56) by PH8PR02CA0043.outlook.office365.com
 (2603:10b6:510:2da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Wed,
 10 Jun 2026 09:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:50:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:36 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:50:28 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 17/32] drm/amd/display: Add KUnit tests for amdgpu_dm
Date: Wed, 10 Jun 2026 17:45:01 +0800
Message-ID: <20260610094639.1965367-18-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 24561dca-81dd-4f8b-8929-08dec6d5baae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: Bx0/RAhzs7Y/P4UQac+9HpghMvGK+vGqhGrwOczYupHjelWTrh2UCb1s2JVTuNTYvgTB2DvfvUuXlkqRPs28Wv0SkCUT0MTHjdrbCswRG92/47EJUYJgR6ddiSde+TCJkyaTORRm91EGmbLKNaolQFY5hzbN6gWDNGkJxjk1ZdqnJ+3uJDAa8YDMVQhfdzxcZKkP0BeVzS0/BNMG0YUOe5Y6v9xb6BUcM09D35P5CASnvYqge37gdHNf7zleMB6ar7ZNqaYBgMaZvd34JGVKzlKOyMvwAF/2+wGRCHSdffRDPw2UtEcVxz8Emp80sABfoalp/eebxhtsCwLR+zpr6Ya0N9f+Z+JnYl9Jja2lJITDUXaalFy3YaGz2RATUcjq6o3aioTXnQuCSHBGy7uL89mvDwOYYr63/OPC3OHmWFiEwOrp2x4p0FVCWLpmqD1BosSb/XvE8wv33f/jCCeAihV91+oImZwabaTOkGqMBaJeU/QYEPWNLeRCYZDiM4i49N29FBOvQzr/SIS6Z60p1MGmOlvmWTBTNPcxO5UBHDeHjLi1fOEPIlFCYT7r9TMMPXcaQ7l6jS+x9+IgwUOGtixnhoGRgJv2zOg+LIfyAywvb2bU/56m+pf39Eg2bcjpUpnFF97/DSnG9n4ov+meLv+7kAUMequi45nEYM7UPcC9ZHEF1vqJdm42M7XVDDZYJ3EYC+zFFZdMmm7oXJ6SMDofHlHCkSsVWhill5fUpX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GSHyQB2xJjO4tumtBOa/oRuPoiDZoXj8j/iLwHPJfl5rNK7zixDm0rZyiq+4W/9HyWv8g3HapOwwknj0Us10rpxDL4K8zjnByXK6dWlohaxWjywgaBokHP7s7iboFhWbnLbGpis1lV6mdgUbldwUa7xxEmoh1yRv8M1nfdUEg+3+yEztlFFsDiLHO8siVg2Em9zxhiZ/1xtTMfoDZprDNXa0aKQm7G4GymdpW+xBGDqO+yixPqksG9ZAAmDFNFKzMFUy7InV407TZIBhI+eaM2KET0NWOBhVfrOTukF8wS0JthYgflabwk0XmV/zHbblyb4u/hx20nZwrujQ0mh5KQKqt/S+bn7nwkWZahg8K6hPiH4FO0eNaOBDlRW/VdEeZf6rC8+2O4ja43yovImmCsAej0fEw+8vQ6tgznR6yoXZ8ZL237AcCo/KG8wV5V3r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:50:39.5164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24561dca-81dd-4f8b-8929-08dec6d5baae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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

From: Alex Hung <alex.hung@amd.com>

Add KUnit tests for pure helper functions in amdgpu_dm.c.

Tests cover:
- dm_plane_layer_index_cmp(): equal, ascending, and descending
  layer_index ordering
- fill_plane_color_attributes(): RGB plus BT601/BT709/BT2020
  full- and limited-range YCbCr, and invalid encoding
- modereset_required(): active vs inactive stream states with
  and without a mode change
- dm_get_oriented_plane_size(): 0/90/180/270 degree rotations
- dm_get_plane_scale(): identity, rotated identity, and
  division-by-zero guard
- is_scaling_state_different(): identical state, scaling mode
  change, and underscan enable/border changes
- is_timing_unchanged_for_freesync(): NULL args, identical
  modes, VRR vtotal/vsync shift, and pixel clock change
- set_freesync_fixed_config(): fixed refresh-rate computation
- is_dc_timing_adjust_needed(): pending hw adjust, VRR
  active-fixed, VRR active-state toggle, and steady state
- set_multisync_trigger_params(): disabled trigger and
  rising/falling edge selection by vsync polarity
- set_master_stream(): highest refresh-rate selection and the
  default-to-first-stream case

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  42 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  21 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |   1 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 929 ++++++++++++++++++
 5 files changed, 979 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4519c0572963..7faf580a3f8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -70,6 +70,7 @@
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_dmub.h"
 #include "amdgpu_dm_connector.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -146,7 +147,7 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
 
-static bool
+STATIC_IFN_KUNIT bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
 
@@ -247,8 +248,8 @@ static int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
-					      struct dm_crtc_state *new_state)
+STATIC_IFN_KUNIT bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
+						 struct dm_crtc_state *new_state)
 {
 	if (new_state->stream->adjust.timing_adjust_pending)
 		return true;
@@ -259,13 +260,14 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 	else
 		return false;
 }
+EXPORT_IF_KUNIT(is_dc_timing_adjust_needed);
 
 /*
  * DC will program planes with their z-order determined by their ordering
  * in the dc_surface_updates array. This comparator is used to sort them
  * by descending zpos.
  */
-static int dm_plane_layer_index_cmp(const void *a, const void *b)
+STATIC_IFN_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
 {
 	const struct dc_surface_update *sa = (struct dc_surface_update *)a;
 	const struct dc_surface_update *sb = (struct dc_surface_update *)b;
@@ -273,6 +275,7 @@ static int dm_plane_layer_index_cmp(const void *a, const void *b)
 	/* Sort by descending dc_plane layer_index (i.e. normalized_zpos) */
 	return sb->surface->layer_index - sa->surface->layer_index;
 }
+EXPORT_IF_KUNIT(dm_plane_layer_index_cmp);
 
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
@@ -2978,12 +2981,13 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 	return dm_init_microcode(adev);
 }
 
-static bool modereset_required(struct drm_crtc_state *crtc_state)
+STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 {
 	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
+EXPORT_IF_KUNIT(modereset_required);
 
-static int
+STATIC_IFN_KUNIT int
 fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
@@ -3030,6 +3034,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(fill_plane_color_attributes);
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
@@ -3598,7 +3603,7 @@ static void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 	amdgpu_irq_update(adev, &adev->pageflip_irq, irq_type);
 }
 
-static bool
+STATIC_IFN_KUNIT bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
 			   const struct dm_connector_state *old_dm_state)
 {
@@ -3615,6 +3620,7 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 		return true;
 	return false;
 }
+EXPORT_IF_KUNIT(is_scaling_state_different);
 
 static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 					    struct drm_crtc_state *old_crtc_state,
@@ -5077,7 +5083,7 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state)
 	return 0;
 }
 
-static void set_multisync_trigger_params(
+STATIC_IFN_KUNIT void set_multisync_trigger_params(
 		struct dc_stream_state *stream)
 {
 	struct dc_stream_state *master = NULL;
@@ -5090,9 +5096,10 @@ static void set_multisync_trigger_params(
 		stream->triggered_crtc_reset.delay = TRIGGER_DELAY_NEXT_PIXEL;
 	}
 }
+EXPORT_IF_KUNIT(set_multisync_trigger_params);
 
-static void set_master_stream(struct dc_stream_state *stream_set[],
-			      int stream_count)
+STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
+					int stream_count)
 {
 	int j, highest_rfr = 0, master_stream = 0;
 
@@ -5113,6 +5120,7 @@ static void set_master_stream(struct dc_stream_state *stream_set[],
 			stream_set[j]->triggered_crtc_reset.event_source = stream_set[master_stream];
 	}
 }
+EXPORT_IF_KUNIT(set_master_stream);
 
 static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
@@ -5558,7 +5566,7 @@ static void reset_freesync_config_for_crtc(
 	       sizeof(new_crtc_state->vrr_infopacket));
 }
 
-static bool
+STATIC_IFN_KUNIT bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state)
 {
@@ -5587,8 +5595,9 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 
 	return false;
 }
+EXPORT_IF_KUNIT(is_timing_unchanged_for_freesync);
 
-static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+STATIC_IFN_KUNIT void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
 {
 	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
@@ -5602,6 +5611,7 @@ static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
 	res = div_u64(num, den);
 	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
 }
+EXPORT_IF_KUNIT(set_freesync_fixed_config);
 
 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			 struct drm_atomic_state *state,
@@ -6337,8 +6347,8 @@ static int dm_update_plane_state(struct dc *dc,
 	return ret;
 }
 
-static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
-				       int *src_w, int *src_h)
+STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+					 int *src_w, int *src_h)
 {
 	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
 	case DRM_MODE_ROTATE_90:
@@ -6354,8 +6364,9 @@ static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 		break;
 	}
 }
+EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
 
-static void
+STATIC_IFN_KUNIT void
 dm_get_plane_scale(struct drm_plane_state *plane_state,
 		   int *out_plane_scale_w, int *out_plane_scale_h)
 {
@@ -6365,6 +6376,7 @@ dm_get_plane_scale(struct drm_plane_state *plane_state,
 	*out_plane_scale_w = plane_src_w ? plane_state->crtc_w * 1000 / plane_src_w : 0;
 	*out_plane_scale_h = plane_src_h ? plane_state->crtc_h * 1000 / plane_src_h : 0;
 }
+EXPORT_IF_KUNIT(dm_get_plane_scale);
 
 /*
  * The normalized_zpos value cannot be used by this iterator directly. It's only
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ba1e11e144f2..2f4a567412f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1126,4 +1126,25 @@ void amdgpu_dm_emulated_link_detect(struct dc_link *link);
 void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 											   struct dc_sink *sink);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+int dm_plane_layer_index_cmp(const void *a, const void *b);
+int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+				const enum surface_pixel_format format,
+				enum dc_color_space *color_space);
+bool modereset_required(struct drm_crtc_state *crtc_state);
+void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+				int *src_w, int *src_h);
+void dm_get_plane_scale(struct drm_plane_state *plane_state,
+			int *out_plane_scale_w, int *out_plane_scale_h);
+bool is_scaling_state_different(const struct dm_connector_state *dm_state,
+				const struct dm_connector_state *old_dm_state);
+bool is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
+				      struct drm_crtc_state *new_crtc_state);
+void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state);
+bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
+				struct dm_crtc_state *new_state);
+void set_multisync_trigger_params(struct dc_stream_state *stream);
+void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
+#endif
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
index 4b2864375105..1f910a6a00c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
@@ -10,6 +10,7 @@
 #define STATIC_IFN_KUNIT
 #define INLINE_IFN_KUNIT inline
 #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
+
 #else
 #define STATIC_IFN_KUNIT static
 #define INLINE_IFN_KUNIT
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 4d2eb301c2af..4365d4024f70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_wb_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
new file mode 100644
index 000000000000..31194ab42f04
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+
+/* Tests for dm_plane_layer_index_cmp() */
+
+/**
+ * dm_test_plane_layer_index_cmp_equal - Test Plane layer index cmp equal
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_layer_index_cmp_equal(struct kunit *test)
+{
+	struct dc_plane_state *plane_a;
+	struct dc_plane_state *plane_b;
+	struct dc_surface_update sa, sb;
+
+	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+
+	plane_a->layer_index = 5;
+	plane_b->layer_index = 5;
+	sa.surface = plane_a;
+	sb.surface = plane_b;
+
+	KUNIT_EXPECT_EQ(test, dm_plane_layer_index_cmp(&sa, &sb), 0);
+}
+
+/**
+ * dm_test_plane_layer_index_cmp_descending - Test Plane layer index cmp descending
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_layer_index_cmp_descending(struct kunit *test)
+{
+	struct dc_plane_state *plane_a;
+	struct dc_plane_state *plane_b;
+	struct dc_surface_update sa, sb;
+
+	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+
+	plane_a->layer_index = 3;
+	plane_b->layer_index = 7;
+	sa.surface = plane_a;
+	sb.surface = plane_b;
+
+	/* b has higher index, so cmp(a,b) = b - a > 0 (b sorts first) */
+	KUNIT_EXPECT_GT(test, dm_plane_layer_index_cmp(&sa, &sb), 0);
+}
+
+/**
+ * dm_test_plane_layer_index_cmp_ascending - Test Plane layer index cmp ascending
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_layer_index_cmp_ascending(struct kunit *test)
+{
+	struct dc_plane_state *plane_a;
+	struct dc_plane_state *plane_b;
+	struct dc_surface_update sa, sb;
+
+	plane_a = kunit_kzalloc(test, sizeof(*plane_a), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_a);
+	plane_b = kunit_kzalloc(test, sizeof(*plane_b), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_b);
+
+	plane_a->layer_index = 9;
+	plane_b->layer_index = 2;
+	sa.surface = plane_a;
+	sb.surface = plane_b;
+
+	/* a has higher index, so cmp(a,b) = b - a < 0 (a sorts first) */
+	KUNIT_EXPECT_LT(test, dm_plane_layer_index_cmp(&sa, &sb), 0);
+}
+
+/* Tests for fill_plane_color_attributes() */
+
+/**
+ * dm_test_fill_color_attr_rgb_format - Test Fill color attr rgb format
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_rgb_format(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	/* RGB format: should return 0 and set SRGB regardless of encoding */
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
+	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space, (int)COLOR_SPACE_SRGB);
+}
+
+/**
+ * dm_test_fill_color_attr_bt601_full - Test Fill color attr bt601 full
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt601_full(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT601;
+	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space, (int)COLOR_SPACE_YCBCR601);
+}
+
+/**
+ * dm_test_fill_color_attr_bt601_limited - Test Fill color attr bt601 limited
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt601_limited(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT601;
+	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space,
+			(int)COLOR_SPACE_YCBCR601_LIMITED);
+}
+
+/**
+ * dm_test_fill_color_attr_bt709_full - Test Fill color attr bt709 full
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt709_full(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
+	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space, (int)COLOR_SPACE_YCBCR709);
+}
+
+/**
+ * dm_test_fill_color_attr_bt709_limited - Test Fill color attr bt709 limited
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt709_limited(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
+	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space,
+			(int)COLOR_SPACE_YCBCR709_LIMITED);
+}
+
+/**
+ * dm_test_fill_color_attr_bt2020_full - Test Fill color attr bt2020 full
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt2020_full(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT2020;
+	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space,
+			(int)COLOR_SPACE_2020_YCBCR_FULL);
+}
+
+/**
+ * dm_test_fill_color_attr_bt2020_limited - Test Fill color attr bt2020 limited
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_bt2020_limited(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = DRM_COLOR_YCBCR_BT2020;
+	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, (int)color_space,
+			(int)COLOR_SPACE_2020_YCBCR_LIMITED);
+}
+
+/**
+ * dm_test_fill_color_attr_invalid_encoding - Test Fill color attr invalid encoding
+ * @test: The KUnit test context
+ */
+static void dm_test_fill_color_attr_invalid_encoding(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	enum dc_color_space color_space = COLOR_SPACE_UNKNOWN;
+	int ret;
+
+	plane_state.color_encoding = 99;
+	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
+
+	ret = fill_plane_color_attributes(&plane_state,
+					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
+					  &color_space);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/* Tests for modereset_required() */
+
+/**
+ * dm_test_modereset_required_when_inactive_and_modeset - Test Modereset required when inactive and modeset
+ * @test: The KUnit test context
+ */
+static void dm_test_modereset_required_when_inactive_and_modeset(struct kunit *test)
+{
+	struct drm_crtc_state crtc_state = { 0 };
+
+	crtc_state.active = false;
+	crtc_state.mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, modereset_required(&crtc_state));
+}
+
+/**
+ * dm_test_modereset_not_required_when_active_and_modeset - Test Modereset not required when active and modeset
+ * @test: The KUnit test context
+ */
+static void dm_test_modereset_not_required_when_active_and_modeset(struct kunit *test)
+{
+	struct drm_crtc_state crtc_state = { 0 };
+
+	crtc_state.active = true;
+	crtc_state.mode_changed = true;
+
+	KUNIT_EXPECT_FALSE(test, modereset_required(&crtc_state));
+}
+
+/**
+ * dm_test_modereset_not_required_when_inactive_without_modeset - Test Modereset not required when inactive without modeset
+ * @test: The KUnit test context
+ */
+static void dm_test_modereset_not_required_when_inactive_without_modeset(struct kunit *test)
+{
+	struct drm_crtc_state crtc_state = { 0 };
+
+	crtc_state.active = false;
+	crtc_state.mode_changed = false;
+
+	KUNIT_EXPECT_FALSE(test, modereset_required(&crtc_state));
+}
+
+/* Tests for dm_get_oriented_plane_size() */
+
+/**
+ * dm_test_oriented_plane_size_rotate_0 - Test Oriented plane size rotate 0
+ * @test: The KUnit test context
+ */
+static void dm_test_oriented_plane_size_rotate_0(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int src_w = 0;
+	int src_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_0;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+
+	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
+
+	KUNIT_EXPECT_EQ(test, src_w, 1920);
+	KUNIT_EXPECT_EQ(test, src_h, 1080);
+}
+
+/**
+ * dm_test_oriented_plane_size_rotate_90 - Test Oriented plane size rotate 90
+ * @test: The KUnit test context
+ */
+static void dm_test_oriented_plane_size_rotate_90(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int src_w = 0;
+	int src_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_90;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+
+	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
+
+	KUNIT_EXPECT_EQ(test, src_w, 1080);
+	KUNIT_EXPECT_EQ(test, src_h, 1920);
+}
+
+/**
+ * dm_test_oriented_plane_size_rotate_180 - Test Oriented plane size rotate 180
+ * @test: The KUnit test context
+ */
+static void dm_test_oriented_plane_size_rotate_180(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int src_w = 0;
+	int src_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_180;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+
+	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
+
+	KUNIT_EXPECT_EQ(test, src_w, 1920);
+	KUNIT_EXPECT_EQ(test, src_h, 1080);
+}
+
+/**
+ * dm_test_oriented_plane_size_rotate_270 - Test Oriented plane size rotate 270
+ * @test: The KUnit test context
+ */
+static void dm_test_oriented_plane_size_rotate_270(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int src_w = 0;
+	int src_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_270;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+
+	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
+
+	KUNIT_EXPECT_EQ(test, src_w, 1080);
+	KUNIT_EXPECT_EQ(test, src_h, 1920);
+}
+
+/* Tests for dm_get_plane_scale() */
+
+/**
+ * dm_test_get_plane_scale_identity - Test Get plane scale identity
+ * @test: The KUnit test context
+ */
+static void dm_test_get_plane_scale_identity(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int scale_w = 0;
+	int scale_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_0;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+	plane_state.crtc_w = 1920;
+	plane_state.crtc_h = 1080;
+
+	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
+
+	KUNIT_EXPECT_EQ(test, scale_w, 1000);
+	KUNIT_EXPECT_EQ(test, scale_h, 1000);
+}
+
+/**
+ * dm_test_get_plane_scale_rotate_90_identity - Test Get plane scale rotate 90 identity
+ * @test: The KUnit test context
+ */
+static void dm_test_get_plane_scale_rotate_90_identity(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int scale_w = 0;
+	int scale_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_90;
+	plane_state.src_w = 1920 << 16;
+	plane_state.src_h = 1080 << 16;
+	plane_state.crtc_w = 1080;
+	plane_state.crtc_h = 1920;
+
+	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
+
+	KUNIT_EXPECT_EQ(test, scale_w, 1000);
+	KUNIT_EXPECT_EQ(test, scale_h, 1000);
+}
+
+/**
+ * dm_test_get_plane_scale_zero_src_width - Test Get plane scale zero src width
+ * @test: The KUnit test context
+ */
+static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
+{
+	struct drm_plane_state plane_state = { 0 };
+	int scale_w = 0;
+	int scale_h = 0;
+
+	plane_state.rotation = DRM_MODE_ROTATE_0;
+	plane_state.src_w = 0;
+	plane_state.src_h = 1080 << 16;
+	plane_state.crtc_w = 100;
+	plane_state.crtc_h = 200;
+
+	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
+
+	KUNIT_EXPECT_EQ(test, scale_w, 0);
+	KUNIT_EXPECT_EQ(test, scale_h, 185);
+}
+
+/* Tests for is_scaling_state_different() */
+
+/**
+ * dm_test_scaling_state_same - Test identical scaling states compare equal
+ * @test: The KUnit test context
+ */
+static void dm_test_scaling_state_same(struct kunit *test)
+{
+	struct dm_connector_state a = { 0 };
+	struct dm_connector_state b = { 0 };
+
+	a.scaling = RMX_FULL;
+	a.underscan_enable = false;
+	b = a;
+
+	KUNIT_EXPECT_FALSE(test, is_scaling_state_different(&a, &b));
+}
+
+/**
+ * dm_test_scaling_state_scaling_changed - Test differing scaling mode is detected
+ * @test: The KUnit test context
+ */
+static void dm_test_scaling_state_scaling_changed(struct kunit *test)
+{
+	struct dm_connector_state a = { 0 };
+	struct dm_connector_state b = { 0 };
+
+	a.scaling = RMX_FULL;
+	b.scaling = RMX_CENTER;
+
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&a, &b));
+}
+
+/**
+ * dm_test_scaling_state_underscan_enabled - Test enabling underscan with borders differs
+ * @test: The KUnit test context
+ */
+static void dm_test_scaling_state_underscan_enabled(struct kunit *test)
+{
+	struct dm_connector_state old_state = { 0 };
+	struct dm_connector_state new_state = { 0 };
+
+	/* new enables underscan with non-zero borders, old has it disabled */
+	new_state.underscan_enable = true;
+	new_state.underscan_hborder = 16;
+	new_state.underscan_vborder = 16;
+	old_state.underscan_enable = false;
+
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&new_state, &old_state));
+}
+
+/**
+ * dm_test_scaling_state_underscan_border_changed - Test changed underscan borders differ
+ * @test: The KUnit test context
+ */
+static void dm_test_scaling_state_underscan_border_changed(struct kunit *test)
+{
+	struct dm_connector_state a = { 0 };
+	struct dm_connector_state b = { 0 };
+
+	a.underscan_enable = true;
+	a.underscan_hborder = 16;
+	a.underscan_vborder = 16;
+	b = a;
+	b.underscan_hborder = 32;
+
+	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(&a, &b));
+}
+
+/* Tests for is_timing_unchanged_for_freesync() */
+
+/**
+ * dm_test_timing_unchanged_null_args - Test NULL crtc states return false
+ * @test: The KUnit test context
+ */
+static void dm_test_timing_unchanged_null_args(struct kunit *test)
+{
+	struct drm_crtc_state crtc_state = { 0 };
+
+	KUNIT_EXPECT_FALSE(test,
+			   is_timing_unchanged_for_freesync(NULL, &crtc_state));
+	KUNIT_EXPECT_FALSE(test,
+			   is_timing_unchanged_for_freesync(&crtc_state, NULL));
+}
+
+/**
+ * dm_test_timing_unchanged_identical_modes - Test identical modes are not "unchanged"
+ * @test: The KUnit test context
+ *
+ * The helper only returns true when vtotal/vsync shift (vrr) while the rest
+ * of the timing stays fixed, so identical modes must return false.
+ */
+static void dm_test_timing_unchanged_identical_modes(struct kunit *test)
+{
+	struct drm_crtc_state old_state = { 0 };
+	struct drm_crtc_state new_state = { 0 };
+
+	old_state.mode.clock = 148500;
+	old_state.mode.hdisplay = 1920;
+	old_state.mode.vdisplay = 1080;
+	old_state.mode.htotal = 2200;
+	old_state.mode.vtotal = 1125;
+	new_state.mode = old_state.mode;
+
+	KUNIT_EXPECT_FALSE(test,
+			   is_timing_unchanged_for_freesync(&old_state, &new_state));
+}
+
+/**
+ * dm_test_timing_unchanged_vrr_shift - Test vrr-style vtotal/vsync shift is detected
+ * @test: The KUnit test context
+ */
+static void dm_test_timing_unchanged_vrr_shift(struct kunit *test)
+{
+	struct drm_crtc_state old_state = { 0 };
+	struct drm_crtc_state new_state = { 0 };
+
+	old_state.mode.clock = 148500;
+	old_state.mode.hdisplay = 1920;
+	old_state.mode.vdisplay = 1080;
+	old_state.mode.htotal = 2200;
+	old_state.mode.vtotal = 1125;
+	old_state.mode.hsync_start = 2008;
+	old_state.mode.vsync_start = 1084;
+	old_state.mode.hsync_end = 2052;
+	old_state.mode.vsync_end = 1089;
+
+	/* Same horizontal timing, vertical totals/sync shifted by 125 lines */
+	new_state.mode = old_state.mode;
+	new_state.mode.vtotal = 1250;
+	new_state.mode.vsync_start = 1209;
+	new_state.mode.vsync_end = 1214;
+
+	KUNIT_EXPECT_TRUE(test,
+			  is_timing_unchanged_for_freesync(&old_state, &new_state));
+}
+
+/**
+ * dm_test_timing_unchanged_clock_changed - Test pixel clock change returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_timing_unchanged_clock_changed(struct kunit *test)
+{
+	struct drm_crtc_state old_state = { 0 };
+	struct drm_crtc_state new_state = { 0 };
+
+	old_state.mode.clock = 148500;
+	old_state.mode.htotal = 2200;
+	old_state.mode.vtotal = 1125;
+	old_state.mode.vsync_start = 1084;
+	old_state.mode.vsync_end = 1089;
+
+	new_state.mode = old_state.mode;
+	new_state.mode.clock = 297000;
+	new_state.mode.vtotal = 1250;
+	new_state.mode.vsync_start = 1209;
+	new_state.mode.vsync_end = 1214;
+
+	KUNIT_EXPECT_FALSE(test,
+			   is_timing_unchanged_for_freesync(&old_state, &new_state));
+}
+
+/* Tests for set_freesync_fixed_config() */
+
+/**
+ * dm_test_set_freesync_fixed_config_60hz - Test fixed refresh computed for 1080p60
+ * @test: The KUnit test context
+ */
+static void dm_test_set_freesync_fixed_config_60hz(struct kunit *test)
+{
+	struct dm_crtc_state dm_crtc_state = { 0 };
+
+	dm_crtc_state.base.mode.clock = 148500;
+	dm_crtc_state.base.mode.htotal = 2200;
+	dm_crtc_state.base.mode.vtotal = 1125;
+
+	set_freesync_fixed_config(&dm_crtc_state);
+
+	KUNIT_EXPECT_EQ(test, (int)dm_crtc_state.freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	/* 148500 kHz / (2200 * 1125) = 60 Hz = 60000000 uHz */
+	KUNIT_EXPECT_EQ(test, dm_crtc_state.freesync_config.fixed_refresh_in_uhz,
+			60000000U);
+}
+
+/* Tests for is_dc_timing_adjust_needed() */
+
+/**
+ * dm_test_dc_timing_adjust_pending - Test a pending hw timing adjust forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_dc_timing_adjust_pending(struct kunit *test)
+{
+	struct dm_crtc_state *old_state, *new_state;
+	struct dc_stream_state *stream;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	new_state->stream = stream;
+	stream->adjust.timing_adjust_pending = 1;
+
+	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
+}
+
+/**
+ * dm_test_dc_timing_adjust_active_fixed - Test VRR active-fixed forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_dc_timing_adjust_active_fixed(struct kunit *test)
+{
+	struct dm_crtc_state *old_state, *new_state;
+	struct dc_stream_state *stream;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	new_state->stream = stream;
+	new_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+
+	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
+}
+
+/**
+ * dm_test_dc_timing_adjust_vrr_toggle - Test a change in vrr active state forces true
+ * @test: The KUnit test context
+ */
+static void dm_test_dc_timing_adjust_vrr_toggle(struct kunit *test)
+{
+	struct dm_crtc_state *old_state, *new_state;
+	struct dc_stream_state *stream;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	new_state->stream = stream;
+	old_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+	new_state->freesync_config.state = VRR_STATE_INACTIVE;
+
+	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
+}
+
+/**
+ * dm_test_dc_timing_adjust_not_needed - Test steady-state timing needs no adjust
+ * @test: The KUnit test context
+ */
+static void dm_test_dc_timing_adjust_not_needed(struct kunit *test)
+{
+	struct dm_crtc_state *old_state, *new_state;
+	struct dc_stream_state *stream;
+
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	new_state->stream = stream;
+	old_state->freesync_config.state = VRR_STATE_INACTIVE;
+	new_state->freesync_config.state = VRR_STATE_INACTIVE;
+
+	KUNIT_EXPECT_FALSE(test, is_dc_timing_adjust_needed(old_state, new_state));
+}
+
+/* Tests for set_multisync_trigger_params() */
+
+/**
+ * dm_test_multisync_trigger_disabled - Test disabled reset leaves params untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_multisync_trigger_disabled(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+
+	stream->triggered_crtc_reset.enabled = false;
+	stream->triggered_crtc_reset.event = CRTC_EVENT_VSYNC_FALLING;
+	stream->triggered_crtc_reset.delay = TRIGGER_DELAY_NEXT_LINE;
+
+	set_multisync_trigger_params(stream);
+
+	/* Nothing should change when the reset trigger is disabled */
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.event,
+			(int)CRTC_EVENT_VSYNC_FALLING);
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.delay,
+			(int)TRIGGER_DELAY_NEXT_LINE);
+}
+
+/**
+ * dm_test_multisync_trigger_rising - Test positive vsync polarity selects rising edge
+ * @test: The KUnit test context
+ */
+static void dm_test_multisync_trigger_rising(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dc_stream_state *master;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	master = kunit_kzalloc(test, sizeof(*master), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, master);
+
+	master->timing.flags.VSYNC_POSITIVE_POLARITY = 1;
+	stream->triggered_crtc_reset.enabled = true;
+	stream->triggered_crtc_reset.event_source = master;
+
+	set_multisync_trigger_params(stream);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.event,
+			(int)CRTC_EVENT_VSYNC_RISING);
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.delay,
+			(int)TRIGGER_DELAY_NEXT_PIXEL);
+}
+
+/**
+ * dm_test_multisync_trigger_falling - Test negative vsync polarity selects falling edge
+ * @test: The KUnit test context
+ */
+static void dm_test_multisync_trigger_falling(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+	struct dc_stream_state *master;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
+	master = kunit_kzalloc(test, sizeof(*master), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, master);
+
+	master->timing.flags.VSYNC_POSITIVE_POLARITY = 0;
+	stream->triggered_crtc_reset.enabled = true;
+	stream->triggered_crtc_reset.event_source = master;
+
+	set_multisync_trigger_params(stream);
+
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.event,
+			(int)CRTC_EVENT_VSYNC_FALLING);
+	KUNIT_EXPECT_EQ(test, (int)stream->triggered_crtc_reset.delay,
+			(int)TRIGGER_DELAY_NEXT_PIXEL);
+}
+
+/* Tests for set_master_stream() */
+
+/**
+ * dm_test_master_stream_highest_refresh - Test highest refresh-rate stream becomes master
+ * @test: The KUnit test context
+ */
+static void dm_test_master_stream_highest_refresh(struct kunit *test)
+{
+	struct dc_stream_state *stream0, *stream1;
+	struct dc_stream_state *stream_set[2];
+
+	stream0 = kunit_kzalloc(test, sizeof(*stream0), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream0);
+	stream1 = kunit_kzalloc(test, sizeof(*stream1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream1);
+	stream_set[0] = stream0;
+	stream_set[1] = stream1;
+
+	/* stream0: 60Hz, stream1: 120Hz -> stream1 is master */
+	stream0->triggered_crtc_reset.enabled = true;
+	stream0->timing.pix_clk_100hz = 1485000;
+	stream0->timing.h_total = 2200;
+	stream0->timing.v_total = 1125;
+
+	stream1->triggered_crtc_reset.enabled = true;
+	stream1->timing.pix_clk_100hz = 2970000;
+	stream1->timing.h_total = 2200;
+	stream1->timing.v_total = 1125;
+
+	set_master_stream(stream_set, 2);
+
+	KUNIT_EXPECT_PTR_EQ(test, stream0->triggered_crtc_reset.event_source,
+			    stream1);
+	KUNIT_EXPECT_PTR_EQ(test, stream1->triggered_crtc_reset.event_source,
+			    stream1);
+}
+
+/**
+ * dm_test_master_stream_defaults_to_first - Test default master when none triggered
+ * @test: The KUnit test context
+ *
+ * When no stream has the reset trigger enabled, master_stream stays 0 and all
+ * streams point at the first stream as their event source.
+ */
+static void dm_test_master_stream_defaults_to_first(struct kunit *test)
+{
+	struct dc_stream_state *stream0, *stream1;
+	struct dc_stream_state *stream_set[2];
+
+	stream0 = kunit_kzalloc(test, sizeof(*stream0), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream0);
+	stream1 = kunit_kzalloc(test, sizeof(*stream1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream1);
+	stream_set[0] = stream0;
+	stream_set[1] = stream1;
+
+	set_master_stream(stream_set, 2);
+
+	KUNIT_EXPECT_PTR_EQ(test, stream0->triggered_crtc_reset.event_source,
+			    stream0);
+	KUNIT_EXPECT_PTR_EQ(test, stream1->triggered_crtc_reset.event_source,
+			    stream0);
+}
+
+static struct kunit_case amdgpu_dm_tests[] = {
+	/* dm_plane_layer_index_cmp */
+	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
+	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
+	KUNIT_CASE(dm_test_plane_layer_index_cmp_ascending),
+	/* fill_plane_color_attributes */
+	KUNIT_CASE(dm_test_fill_color_attr_rgb_format),
+	KUNIT_CASE(dm_test_fill_color_attr_bt601_full),
+	KUNIT_CASE(dm_test_fill_color_attr_bt601_limited),
+	KUNIT_CASE(dm_test_fill_color_attr_bt709_full),
+	KUNIT_CASE(dm_test_fill_color_attr_bt709_limited),
+	KUNIT_CASE(dm_test_fill_color_attr_bt2020_full),
+	KUNIT_CASE(dm_test_fill_color_attr_bt2020_limited),
+	KUNIT_CASE(dm_test_fill_color_attr_invalid_encoding),
+	/* modereset_required */
+	KUNIT_CASE(dm_test_modereset_required_when_inactive_and_modeset),
+	KUNIT_CASE(dm_test_modereset_not_required_when_active_and_modeset),
+	KUNIT_CASE(dm_test_modereset_not_required_when_inactive_without_modeset),
+	/* dm_get_oriented_plane_size */
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_0),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_90),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_180),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_270),
+	/* dm_get_plane_scale */
+	KUNIT_CASE(dm_test_get_plane_scale_identity),
+	KUNIT_CASE(dm_test_get_plane_scale_rotate_90_identity),
+	KUNIT_CASE(dm_test_get_plane_scale_zero_src_width),
+	/* is_scaling_state_different */
+	KUNIT_CASE(dm_test_scaling_state_same),
+	KUNIT_CASE(dm_test_scaling_state_scaling_changed),
+	KUNIT_CASE(dm_test_scaling_state_underscan_enabled),
+	KUNIT_CASE(dm_test_scaling_state_underscan_border_changed),
+	/* is_timing_unchanged_for_freesync */
+	KUNIT_CASE(dm_test_timing_unchanged_null_args),
+	KUNIT_CASE(dm_test_timing_unchanged_identical_modes),
+	KUNIT_CASE(dm_test_timing_unchanged_vrr_shift),
+	KUNIT_CASE(dm_test_timing_unchanged_clock_changed),
+	/* set_freesync_fixed_config */
+	KUNIT_CASE(dm_test_set_freesync_fixed_config_60hz),
+	/* is_dc_timing_adjust_needed */
+	KUNIT_CASE(dm_test_dc_timing_adjust_pending),
+	KUNIT_CASE(dm_test_dc_timing_adjust_active_fixed),
+	KUNIT_CASE(dm_test_dc_timing_adjust_vrr_toggle),
+	KUNIT_CASE(dm_test_dc_timing_adjust_not_needed),
+	/* set_multisync_trigger_params */
+	KUNIT_CASE(dm_test_multisync_trigger_disabled),
+	KUNIT_CASE(dm_test_multisync_trigger_rising),
+	KUNIT_CASE(dm_test_multisync_trigger_falling),
+	/* set_master_stream */
+	KUNIT_CASE(dm_test_master_stream_highest_refresh),
+	KUNIT_CASE(dm_test_master_stream_defaults_to_first),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_test_suite = {
+	.name = "amdgpu_dm",
+	.test_cases = amdgpu_dm_tests,
+};
+
+kunit_test_suite(amdgpu_dm_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

