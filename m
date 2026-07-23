Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E8EC531FC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB78610F1D2;
	Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xmvwft5k";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0E310F1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh6ZNz5ljIsjom/HkA2ib3VFkGr8CsizE9ZMeDn9AuFZgSDJejYUR5e9Th0vkKxhW28nqXYbikHnvEH2IRLMrcnSkVXl855J62lsYmO/lgguSfV3BZmwo7wuLW5WOrNkF+N+8fiZSwSGz0Qy0VnrUwfOyzXL9QTMFVvCpeoeDrJxJbjTCsNOwNRd8bPW35/Gp43X+8XHGvkimyVgSGUV/bm834atPNZS2OnVUc2oRe2yWp53zyonHD9CHTanaYNlrqBr/FrYH+lPPy4fwkpXqkznvbnrbY/YMcdmpjvo/oVHOwmaSr8aplCHu8tderjAFexjdquiGj6dUnsNQJaW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMjdGqlcuLqf6/3RLevOPmhnl0vPKoZGOiY926c0rFQ=;
 b=Mnvw6qT9fNEYQ+fwhidzMBS32TQJl2xdW471AGrCm1YOiPK6xF8RUnkFDtj8iKYy2TCuBkB9gIScMCdt5GMpu+hcn06gB46T5lWJpusHlYqJoTAZWNwkDwhQRgvYVakwHlPYaZENfTUrEEQdqPpgrTeXbUKMp8pN7e8VWoF+5L7NnRRUs6yVF0eRKFWY2GpAhW/1Q63uiSbq40f9fU9AsOqkuqV2SdRVmLSMsh93iI0R1Ct4Qd2i+4wZy5mGvfn0vCHDHl6nE/qyH3XuihJHWnMoZYGdnUXdefp1wTu+yynztkFN/X8bUc7e8cClfsO74DhR4caqbRwpx4V2mUHn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMjdGqlcuLqf6/3RLevOPmhnl0vPKoZGOiY926c0rFQ=;
 b=Xmvwft5kn89lk/mVHcPqg3wkfJEF6bhTTbafqi8fg0IKWEW2Efmu49Rq33t+7TVHehs2i9J/x/dqt+qVlQ5RJW1AIrBnYv+hFVhwu6wD3WsD25b5Dw8dqwNBVgCUwzEafqYzlFK9ZLin/HckadK0qEtcvurVEnZ5o9ws4RnKRzI=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:10 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::22) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:09 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:00 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 16/49] drm/amd/display: add FreeSync/VRR module
Date: Thu, 23 Jul 2026 16:13:24 -0400
Message-ID: <20260723201908.373300-17-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3753a0fa-3668-4ddb-2b66-08dee8f7a7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|5023799004|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: vG7VFrdHQ2r3Z8+ydDqXdDCZKZv7qWkRWrsHleJ7ADDWFqZHc24xE2xY/CQxJPxKhfAeU67vHWeNqgayXUUuQv6LobBEWJ5HjWCUEwpf0CPv9fcTrzJ+o9EDA2acjHf/NdH7kASUGOST84COr2l1yUqlBAf5s+3cjTy6uGYDS0lNs29CVHqxaWO2kQ362Bxu3brfp/2hKeGY4nVdYsu4p9EGxYaQBZqXQq4sR+uNGAEEYEgZYyhKkWSI590CfeaLsmxEKT+wRPk60EYbXuBwPEl6fZeSi8p92bMg5Od+R8yvy50v4hHPMuQFjRe/HJ3E2KJ74Zeu1xTgS/Oo6v1aFME5mCsTZn6Kie/S9is22wY9ef8MsKswXB7BSNorZgZUthNSz4ry9ZMxgtdBANAjwtG8Bz2bGj4TXL73OwcsynVKX6kPPWwX7/K94OXr4n7o9AAiV1S384WnsT+jWzAiv07o2MvGE+6Q7IZBVjaLEFbCNv3YcmkXjcHwYvPRodxpKsgrXYWi71OghI0tpfUkW3rn/lb8ObSSEFD+6JcIVrTCrIklcDvesAHwKBn1+eahCfymoB07NzT/dkTECJ3WTfGCS9b+uXKdnWTw38R3ETQ3jaW7sZfswLOuBqDo4QGTSHjvCm4LUgP76AQYzhYEp118CWL17vQ3h4F8L8QeyEcIyI8SbPtDWI76KRICpwTYCRyojvzMlwDYhA4yPQxDag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(3023799007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +phCKyIGZ8tYdjMFJ4gxQYCO2jPXPLWmMqBRIpThrarRvIyXbIhJhjwzRHM0frNW1L2WWaBO4/sMCGZ7SIvFCSyRfV/HtkXKH1iej8HabAA9wNWk8+xnaEkTK5WAbulHi+xOAEFUg9TKDwR9Iyozg71X04K7ZB0+rYozpUwWRCkm8u6BuUZHznAeS7+kYQKPZJtXNU4lTCj4Xi9DOazOgFUBHIydo8wPOq5aLZuaCCdzb4iQhiKpqgza/nxXhZTJ6r5GuxuRAMZwP25LfW83UFM+OkCx26UBGA8SBaffkE97ukdP8GQCd7mygPP3pDLuLaE/w8A9UuwWSA7TCCS6kn3Puuefgjp3Y5ZY6XumeujyPRuN1Mdq++ul6vhwNT0Lgj1NPCh623VHJnlrrkH0+SRzr3z8TuTvLgwnXuSVlqZIwVzoAJE/9/1nRzWF23DU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:09.9593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3753a0fa-3668-4ddb-2b66-08dee8f7a7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

[WHAT]
Group the FreeSync/VRR helpers from amdgpu_dm.c into a dedicated
amdgpu_dm_freesync.c and amdgpu_dm_freesync.h. The moved functions are:

  is_dc_timing_adjust_needed, is_timing_unchanged_for_freesync,
  set_freesync_fixed_config, reset_freesync_config_for_crtc,
  get_freesync_config_for_crtc, update_freesync_state_on_stream,
  update_stream_irq_parameters, amdgpu_dm_handle_vrr_transition.

The FreeSync/VRR helpers exposed by amdgpu_dm_freesync.h are called
from amdgpu_dm.c, so give the seven that lacked a namespace prefix the
standard amdgpu_dm_ prefix:

Relocate the corresponding KUnit tests into amdgpu_dm_freesync_test.c.

No functional change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 349 +-------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 -
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 362 ++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.h    |  65 +++
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 453 ++++++++++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 417 ----------------
 8 files changed, 894 insertions(+), 764 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index d83878e35b61..5cb8c143e72f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -45,7 +45,8 @@ AMDGPUDM = \
 	amdgpu_dm_backlight.o \
 	amdgpu_dm_audio.o \
 	amdgpu_dm_dmub.o \
-	amdgpu_dm_connector.o
+	amdgpu_dm_connector.o \
+	amdgpu_dm_freesync.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfc16f5e415a..c36eb8a1d2d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -71,6 +71,7 @@
 #include "amdgpu_dm_dmub.h"
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_pp_smu.h"
+#include "amdgpu_dm_freesync.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -127,7 +128,6 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 /* basic init/fini API */
 static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
-STATIC_IFN_KUNIT void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
 
 /*
  * initializes drm_device display related structures, based on the information
@@ -147,10 +147,6 @@ STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *cont
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_commit *state);
 
-STATIC_IFN_KUNIT bool
-is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
-				 struct drm_crtc_state *new_crtc_state);
-
 static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
 {
 	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
@@ -248,20 +244,6 @@ STATIC_IFN_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_soft_reset);
 
-STATIC_IFN_KUNIT bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
-						 struct dm_crtc_state *new_state)
-{
-	if (new_state->stream->adjust.timing_adjust_pending)
-		return true;
-	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
-		return true;
-	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
-		return true;
-	else
-		return false;
-}
-EXPORT_IF_KUNIT(is_dc_timing_adjust_needed);
-
 /*
  * DC will program planes with their z-order determined by their ordering
  * in the dc_surface_updates array. This comparator is used to sort them
@@ -1542,7 +1524,7 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 	for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state, i) {
 		new_crtc_state->active_changed = true;
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-		reset_freesync_config_for_crtc(dm_new_crtc_state);
+		amdgpu_dm_reset_freesync_config_for_crtc(dm_new_crtc_state);
 	}
 
 	/*
@@ -3614,213 +3596,6 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 		      acrtc->crtc_id);
 }
 
-static void update_freesync_state_on_stream(
-	struct amdgpu_display_manager *dm,
-	struct dm_crtc_state *new_crtc_state,
-	struct dc_stream_state *new_stream,
-	struct dc_plane_state *surface,
-	u32 flip_timestamp_in_us)
-{
-	struct mod_vrr_params vrr_params;
-	struct dc_info_packet vrr_infopacket = {0};
-	struct amdgpu_device *adev = dm->adev;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
-	unsigned long flags;
-	bool pack_sdp_v1_3 = false;
-	struct amdgpu_dm_connector *aconn;
-	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
-
-	if (!new_stream)
-		return;
-
-	/*
-	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
-	 * For now it's sufficient to just guard against these conditions.
-	 */
-
-	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
-		return;
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	vrr_params = acrtc->dm_irq_params.vrr_params;
-
-	if (surface) {
-		mod_freesync_handle_preflip(
-			dm->freesync_module,
-			surface,
-			new_stream,
-			flip_timestamp_in_us,
-			&vrr_params);
-
-		if (adev->family < AMDGPU_FAMILY_AI &&
-		    amdgpu_dm_crtc_vrr_active(new_crtc_state)) {
-			mod_freesync_handle_v_update(dm->freesync_module,
-						     new_stream, &vrr_params);
-
-			/* Need to call this before the frame ends. */
-			dc_stream_adjust_vmin_vmax(dm->dc,
-						   new_crtc_state->stream,
-						   &vrr_params.adjust);
-		}
-	}
-
-	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
-
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
-		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
-
-		if (aconn->vsdb_info.amd_vsdb_version == 1)
-			packet_type = PACKET_TYPE_FS_V1;
-		else if (aconn->vsdb_info.amd_vsdb_version == 2)
-			packet_type = PACKET_TYPE_FS_V2;
-		else if (aconn->vsdb_info.amd_vsdb_version == 3)
-			packet_type = PACKET_TYPE_FS_V3;
-
-		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
-					&new_stream->adaptive_sync_infopacket);
-	}
-
-	mod_freesync_build_vrr_infopacket(
-		dm->freesync_module,
-		new_stream,
-		&vrr_params,
-		packet_type,
-		TRANSFER_FUNC_UNKNOWN,
-		&vrr_infopacket,
-		pack_sdp_v1_3);
-
-	new_crtc_state->freesync_vrr_info_changed |=
-		(memcmp(&new_crtc_state->vrr_infopacket,
-			&vrr_infopacket,
-			sizeof(vrr_infopacket)) != 0);
-
-	acrtc->dm_irq_params.vrr_params = vrr_params;
-	new_crtc_state->vrr_infopacket = vrr_infopacket;
-
-	new_stream->vrr_infopacket = vrr_infopacket;
-	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
-
-	if (new_crtc_state->freesync_vrr_info_changed)
-		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
-			      new_crtc_state->base.crtc->base.id,
-			      (int)new_crtc_state->base.vrr_enabled,
-			      (int)vrr_params.state);
-
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-}
-
-static void update_stream_irq_parameters(
-	struct amdgpu_display_manager *dm,
-	struct dm_crtc_state *new_crtc_state)
-{
-	struct dc_stream_state *new_stream = new_crtc_state->stream;
-	struct mod_vrr_params vrr_params;
-	struct mod_freesync_config config = new_crtc_state->freesync_config;
-	struct amdgpu_device *adev = dm->adev;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
-	unsigned long flags;
-
-	if (!new_stream)
-		return;
-
-	/*
-	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
-	 * For now it's sufficient to just guard against these conditions.
-	 */
-	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
-		return;
-
-	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-	vrr_params = acrtc->dm_irq_params.vrr_params;
-
-	if (new_crtc_state->vrr_supported &&
-	    config.min_refresh_in_uhz &&
-	    config.max_refresh_in_uhz) {
-		/*
-		 * if freesync compatible mode was set, config.state will be set
-		 * in atomic check
-		 */
-		if (config.state == VRR_STATE_ACTIVE_FIXED && config.fixed_refresh_in_uhz &&
-		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
-		     new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED)) {
-			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
-			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
-			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
-			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
-		} else {
-			config.state = new_crtc_state->base.vrr_enabled ?
-						     VRR_STATE_ACTIVE_VARIABLE :
-						     VRR_STATE_INACTIVE;
-		}
-	} else {
-		config.state = VRR_STATE_UNSUPPORTED;
-	}
-
-	mod_freesync_build_vrr_params(dm->freesync_module,
-				      new_stream,
-				      &config, &vrr_params);
-
-	new_crtc_state->freesync_config = config;
-	/* Copy state for access from DM IRQ handler */
-	acrtc->dm_irq_params.freesync_config = config;
-	acrtc->dm_irq_params.active_planes = new_crtc_state->active_planes;
-	acrtc->dm_irq_params.vrr_params = vrr_params;
-	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
-}
-
-static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
-					    struct dm_crtc_state *old_state,
-					    struct dm_crtc_state *new_state)
-{
-	struct amdgpu_device *adev = dm->adev;
-	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
-	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
-
-	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
-	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
-
-	if (!old_vrr_active && new_vrr_active) {
-		/* Transition VRR inactive -> active:
-		 * While VRR is active, we must not disable vblank irq, as a
-		 * reenable after disable would compute bogus vblank/pflip
-		 * timestamps if it likely happened inside display front-porch.
-		 *
-		 * We also need vupdate irq for the actual core vblank handling
-		 * at end of vblank.
-		 */
-		if (vrr_gates_vupdate)
-			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
-		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
-		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
-				 __func__, new_state->base.crtc->base.id);
-
-		scoped_guard(mutex, &dm->dc_lock) {
-			dc_exit_ips_for_hw_access(dm->dc);
-			amdgpu_dm_psr_set_event(dm, new_state->stream, true,
-				psr_event_vrr_transition, true);
-			amdgpu_dm_replay_set_event(dm, new_state->stream, true,
-				replay_event_vrr, true);
-		}
-	} else if (old_vrr_active && !new_vrr_active) {
-		/* Transition VRR active -> inactive:
-		 * Allow vblank irq disable again for fixed refresh rate.
-		 */
-		if (vrr_gates_vupdate)
-			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
-		drm_crtc_vblank_put(new_state->base.crtc);
-		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
-				 __func__, new_state->base.crtc->base.id);
-
-		scoped_guard(mutex, &dm->dc_lock) {
-			dc_exit_ips_for_hw_access(dm->dc);
-			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
-				psr_event_vrr_transition, false);
-			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
-				replay_event_vrr, false);
-		}
-	}
-}
-
 static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
@@ -4177,7 +3952,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		if (plane == pcrtc->primary)
-			update_freesync_state_on_stream(
+			amdgpu_dm_update_freesync_state_on_stream(
 				dm,
 				acrtc_state,
 				acrtc_state->stream,
@@ -4295,7 +4070,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		 * re-adjust the min/max bounds now that DC doesn't handle this
 		 * as part of commit.
 		 */
-		if (is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
+		if (amdgpu_dm_is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
 			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
 			dc_stream_adjust_vmin_vmax(
 				dm->dc, acrtc_state->stream,
@@ -5344,7 +5119,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
 		/* For freesync config update on crtc state and params for irq */
-		update_stream_irq_parameters(dm, dm_new_crtc_state);
+		amdgpu_dm_update_stream_irq_parameters(dm, dm_new_crtc_state);
 
 #ifdef CONFIG_DEBUG_FS
 		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
@@ -5544,108 +5319,6 @@ static int do_aquire_global_lock(struct drm_device *dev,
 	return ret < 0 ? ret : 0;
 }
 
-STATIC_IFN_KUNIT void get_freesync_config_for_crtc(
-	struct dm_crtc_state *new_crtc_state,
-	struct dm_connector_state *new_con_state)
-{
-	struct mod_freesync_config config = {0};
-	struct amdgpu_dm_connector *aconnector;
-	struct drm_display_mode *mode = &new_crtc_state->base.mode;
-	int vrefresh = drm_mode_vrefresh(mode);
-	bool fs_vid_mode = false;
-
-	if (new_con_state->base.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-		return;
-
-	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
-
-	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
-					vrefresh >= aconnector->min_vfreq &&
-					vrefresh <= aconnector->max_vfreq;
-
-	if (new_crtc_state->vrr_supported) {
-		new_crtc_state->stream->ignore_msa_timing_param = true;
-		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-
-		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
-		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
-		config.vsif_supported = true;
-		config.btr = true;
-
-		if (fs_vid_mode) {
-			config.state = VRR_STATE_ACTIVE_FIXED;
-			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
-			goto out;
-		} else if (new_crtc_state->base.vrr_enabled) {
-			config.state = VRR_STATE_ACTIVE_VARIABLE;
-		} else {
-			config.state = VRR_STATE_INACTIVE;
-		}
-	} else {
-		config.state = VRR_STATE_UNSUPPORTED;
-	}
-out:
-	new_crtc_state->freesync_config = config;
-}
-EXPORT_IF_KUNIT(get_freesync_config_for_crtc);
-
-STATIC_IFN_KUNIT void reset_freesync_config_for_crtc(
-	struct dm_crtc_state *new_crtc_state)
-{
-	new_crtc_state->vrr_supported = false;
-
-	memset(&new_crtc_state->vrr_infopacket, 0,
-	       sizeof(new_crtc_state->vrr_infopacket));
-}
-EXPORT_IF_KUNIT(reset_freesync_config_for_crtc);
-
-STATIC_IFN_KUNIT bool
-is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
-				 struct drm_crtc_state *new_crtc_state)
-{
-	const struct drm_display_mode *old_mode, *new_mode;
-
-	if (!old_crtc_state || !new_crtc_state)
-		return false;
-
-	old_mode = &old_crtc_state->mode;
-	new_mode = &new_crtc_state->mode;
-
-	if (old_mode->clock       == new_mode->clock &&
-	    old_mode->hdisplay    == new_mode->hdisplay &&
-	    old_mode->vdisplay    == new_mode->vdisplay &&
-	    old_mode->htotal      == new_mode->htotal &&
-	    old_mode->vtotal      != new_mode->vtotal &&
-	    old_mode->hsync_start == new_mode->hsync_start &&
-	    old_mode->vsync_start != new_mode->vsync_start &&
-	    old_mode->hsync_end   == new_mode->hsync_end &&
-	    old_mode->vsync_end   != new_mode->vsync_end &&
-	    old_mode->hskew       == new_mode->hskew &&
-	    old_mode->vscan       == new_mode->vscan &&
-	    (old_mode->vsync_end - old_mode->vsync_start) ==
-	    (new_mode->vsync_end - new_mode->vsync_start))
-		return true;
-
-	return false;
-}
-EXPORT_IF_KUNIT(is_timing_unchanged_for_freesync);
-
-STATIC_IFN_KUNIT void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
-{
-	u64 num, den, res;
-	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
-
-	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
-
-	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
-	den = (unsigned long long)new_crtc_state->mode.htotal *
-	      (unsigned long long)new_crtc_state->mode.vtotal;
-
-	res = div_u64(num, den);
-	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
-}
-EXPORT_IF_KUNIT(set_freesync_fixed_config);
-
 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			 struct drm_atomic_commit *state,
 			 struct drm_crtc *crtc,
@@ -5742,7 +5415,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 */
 		if (amdgpu_freesync_vid_mode &&
 		    dm_new_crtc_state->stream &&
-		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
+		    amdgpu_dm_is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
 			goto skip_modeset;
 
 		if (dm_new_crtc_state->stream &&
@@ -5784,14 +5457,14 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
-		    is_timing_unchanged_for_freesync(new_crtc_state,
+		    amdgpu_dm_is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
 			drm_dbg_driver(adev_to_drm(adev),
 				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
-			set_freesync_fixed_config(dm_new_crtc_state);
+			amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
 		} else if (amdgpu_freesync_vid_mode && aconnector &&
@@ -5801,7 +5474,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 			high_mode = amdgpu_dm_get_highest_refresh_rate_mode(aconnector, false);
 			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
-				set_freesync_fixed_config(dm_new_crtc_state);
+				amdgpu_dm_set_freesync_fixed_config(dm_new_crtc_state);
 		}
 
 		ret = dm_atomic_get_state(state, &dm_state);
@@ -5823,7 +5496,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		dc_stream_release(dm_old_crtc_state->stream);
 		dm_new_crtc_state->stream = NULL;
 
-		reset_freesync_config_for_crtc(dm_new_crtc_state);
+		amdgpu_dm_reset_freesync_config_for_crtc(dm_new_crtc_state);
 
 		*lock_and_validation_needed = true;
 
@@ -5911,7 +5584,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	}
 
 	/* Update Freesync settings. */
-	get_freesync_config_for_crtc(dm_new_crtc_state,
+	amdgpu_dm_get_freesync_config_for_crtc(dm_new_crtc_state,
 				     dm_new_conn_state);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 70220997cde9..1ef92a28e3e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1172,16 +1172,8 @@ void dm_get_plane_scale(struct drm_plane_state *plane_state,
 			int *out_plane_scale_w, int *out_plane_scale_h);
 bool is_scaling_state_different(const struct dm_connector_state *dm_state,
 				const struct dm_connector_state *old_dm_state);
-bool is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
-				      struct drm_crtc_state *new_crtc_state);
-void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state);
-bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
-				struct dm_crtc_state *new_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
 void set_master_stream(struct dc_stream_state *stream_set[], int stream_count);
-void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
-void get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
-				  struct dm_connector_state *new_con_state);
 void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 struct hdcp_workqueue;
 bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
new file mode 100644
index 000000000000..7e484adb4120
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include <drm/drm_atomic.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_vblank.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_crtc.h"
+#include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
+#include "amdgpu_dm_freesync.h"
+#include "dm_helpers.h"
+#include "modules/inc/mod_freesync.h"
+
+bool amdgpu_dm_is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
+					  struct dm_crtc_state *new_state)
+{
+	if (new_state->stream->adjust.timing_adjust_pending)
+		return true;
+	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
+		return true;
+	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
+		return true;
+	else
+		return false;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_is_dc_timing_adjust_needed);
+
+bool
+amdgpu_dm_is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
+					   struct drm_crtc_state *new_crtc_state)
+{
+	const struct drm_display_mode *old_mode, *new_mode;
+
+	if (!old_crtc_state || !new_crtc_state)
+		return false;
+
+	old_mode = &old_crtc_state->mode;
+	new_mode = &new_crtc_state->mode;
+
+	if (old_mode->clock       == new_mode->clock &&
+	    old_mode->hdisplay    == new_mode->hdisplay &&
+	    old_mode->vdisplay    == new_mode->vdisplay &&
+	    old_mode->htotal      == new_mode->htotal &&
+	    old_mode->vtotal      != new_mode->vtotal &&
+	    old_mode->hsync_start == new_mode->hsync_start &&
+	    old_mode->vsync_start != new_mode->vsync_start &&
+	    old_mode->hsync_end   == new_mode->hsync_end &&
+	    old_mode->vsync_end   != new_mode->vsync_end &&
+	    old_mode->hskew       == new_mode->hskew &&
+	    old_mode->vscan       == new_mode->vscan &&
+	    (old_mode->vsync_end - old_mode->vsync_start) ==
+	    (new_mode->vsync_end - new_mode->vsync_start))
+		return true;
+
+	return false;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_is_timing_unchanged_for_freesync);
+
+void amdgpu_dm_set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
+{
+	u64 num, den, res;
+	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
+
+	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+
+	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
+	den = (unsigned long long)new_crtc_state->mode.htotal *
+	      (unsigned long long)new_crtc_state->mode.vtotal;
+
+	res = div_u64(num, den);
+	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_set_freesync_fixed_config);
+
+void amdgpu_dm_reset_freesync_config_for_crtc(
+	struct dm_crtc_state *new_crtc_state)
+{
+	new_crtc_state->vrr_supported = false;
+
+	memset(&new_crtc_state->vrr_infopacket, 0,
+	       sizeof(new_crtc_state->vrr_infopacket));
+}
+EXPORT_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
+
+void amdgpu_dm_get_freesync_config_for_crtc(
+	struct dm_crtc_state *new_crtc_state,
+	struct dm_connector_state *new_con_state)
+{
+	struct mod_freesync_config config = {0};
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_display_mode *mode = &new_crtc_state->base.mode;
+	int vrefresh = drm_mode_vrefresh(mode);
+	bool fs_vid_mode = false;
+
+	if (new_con_state->base.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return;
+
+	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
+
+	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
+					vrefresh >= aconnector->min_vfreq &&
+					vrefresh <= aconnector->max_vfreq;
+
+	if (new_crtc_state->vrr_supported) {
+		new_crtc_state->stream->ignore_msa_timing_param = true;
+		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
+
+		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
+		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
+		config.vsif_supported = true;
+		config.btr = true;
+
+		if (fs_vid_mode) {
+			config.state = VRR_STATE_ACTIVE_FIXED;
+			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
+			goto out;
+		} else if (new_crtc_state->base.vrr_enabled) {
+			config.state = VRR_STATE_ACTIVE_VARIABLE;
+		} else {
+			config.state = VRR_STATE_INACTIVE;
+		}
+	} else {
+		config.state = VRR_STATE_UNSUPPORTED;
+	}
+out:
+	new_crtc_state->freesync_config = config;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
+
+void amdgpu_dm_update_freesync_state_on_stream(
+	struct amdgpu_display_manager *dm,
+	struct dm_crtc_state *new_crtc_state,
+	struct dc_stream_state *new_stream,
+	struct dc_plane_state *surface,
+	u32 flip_timestamp_in_us)
+{
+	struct mod_vrr_params vrr_params;
+	struct dc_info_packet vrr_infopacket = {0};
+	struct amdgpu_device *adev = dm->adev;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
+	unsigned long flags;
+	bool pack_sdp_v1_3 = false;
+	struct amdgpu_dm_connector *aconn;
+	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+
+	if (!new_stream)
+		return;
+
+	/*
+	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
+	 * For now it's sufficient to just guard against these conditions.
+	 */
+
+	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
+		return;
+
+	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+	vrr_params = acrtc->dm_irq_params.vrr_params;
+
+	if (surface) {
+		mod_freesync_handle_preflip(
+			dm->freesync_module,
+			surface,
+			new_stream,
+			flip_timestamp_in_us,
+			&vrr_params);
+
+		if (adev->family < AMDGPU_FAMILY_AI &&
+		    amdgpu_dm_crtc_vrr_active(new_crtc_state)) {
+			mod_freesync_handle_v_update(dm->freesync_module,
+						     new_stream, &vrr_params);
+
+			/* Need to call this before the frame ends. */
+			dc_stream_adjust_vmin_vmax(dm->dc,
+						   new_crtc_state->stream,
+						   &vrr_params.adjust);
+		}
+	}
+
+	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
+
+	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
+
+		if (aconn->vsdb_info.amd_vsdb_version == 1)
+			packet_type = PACKET_TYPE_FS_V1;
+		else if (aconn->vsdb_info.amd_vsdb_version == 2)
+			packet_type = PACKET_TYPE_FS_V2;
+		else if (aconn->vsdb_info.amd_vsdb_version == 3)
+			packet_type = PACKET_TYPE_FS_V3;
+
+		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
+					&new_stream->adaptive_sync_infopacket);
+	}
+
+	mod_freesync_build_vrr_infopacket(
+		dm->freesync_module,
+		new_stream,
+		&vrr_params,
+		packet_type,
+		TRANSFER_FUNC_UNKNOWN,
+		&vrr_infopacket,
+		pack_sdp_v1_3);
+
+	new_crtc_state->freesync_vrr_info_changed |=
+		(memcmp(&new_crtc_state->vrr_infopacket,
+			&vrr_infopacket,
+			sizeof(vrr_infopacket)) != 0);
+
+	acrtc->dm_irq_params.vrr_params = vrr_params;
+	new_crtc_state->vrr_infopacket = vrr_infopacket;
+
+	new_stream->vrr_infopacket = vrr_infopacket;
+	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
+
+	if (new_crtc_state->freesync_vrr_info_changed)
+		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
+			      new_crtc_state->base.crtc->base.id,
+			      (int)new_crtc_state->base.vrr_enabled,
+			      (int)vrr_params.state);
+
+	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+}
+
+void amdgpu_dm_update_stream_irq_parameters(
+	struct amdgpu_display_manager *dm,
+	struct dm_crtc_state *new_crtc_state)
+{
+	struct dc_stream_state *new_stream = new_crtc_state->stream;
+	struct mod_vrr_params vrr_params;
+	struct mod_freesync_config config = new_crtc_state->freesync_config;
+	struct amdgpu_device *adev = dm->adev;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
+	unsigned long flags;
+
+	if (!new_stream)
+		return;
+
+	/*
+	 * TODO: Determine why min/max totals and vrefresh can be 0 here.
+	 * For now it's sufficient to just guard against these conditions.
+	 */
+	if (!new_stream->timing.h_total || !new_stream->timing.v_total)
+		return;
+
+	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+	vrr_params = acrtc->dm_irq_params.vrr_params;
+
+	if (new_crtc_state->vrr_supported &&
+	    config.min_refresh_in_uhz &&
+	    config.max_refresh_in_uhz) {
+		/*
+		 * if freesync compatible mode was set, config.state will be set
+		 * in atomic check
+		 */
+		if (config.state == VRR_STATE_ACTIVE_FIXED && config.fixed_refresh_in_uhz &&
+		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
+		     new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED)) {
+			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
+			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
+			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
+			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
+		} else {
+			config.state = new_crtc_state->base.vrr_enabled ?
+						     VRR_STATE_ACTIVE_VARIABLE :
+						     VRR_STATE_INACTIVE;
+		}
+	} else {
+		config.state = VRR_STATE_UNSUPPORTED;
+	}
+
+	mod_freesync_build_vrr_params(dm->freesync_module,
+				      new_stream,
+				      &config, &vrr_params);
+
+	new_crtc_state->freesync_config = config;
+	/* Copy state for access from DM IRQ handler */
+	acrtc->dm_irq_params.freesync_config = config;
+	acrtc->dm_irq_params.active_planes = new_crtc_state->active_planes;
+	acrtc->dm_irq_params.vrr_params = vrr_params;
+	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+}
+
+void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
+				     struct dm_crtc_state *old_state,
+				     struct dm_crtc_state *new_state)
+{
+	struct amdgpu_device *adev = dm->adev;
+	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
+	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
+
+	/* Only DCE gates vupdate on VRR, keep it enabled for DCN */
+	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
+
+	if (!old_vrr_active && new_vrr_active) {
+		/* Transition VRR inactive -> active:
+		 * While VRR is active, we must not disable vblank irq, as a
+		 * reenable after disable would compute bogus vblank/pflip
+		 * timestamps if it likely happened inside display front-porch.
+		 *
+		 * We also need vupdate irq for the actual core vblank handling
+		 * at end of vblank.
+		 */
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
+		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
+		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
+				 __func__, new_state->base.crtc->base.id);
+
+		scoped_guard(mutex, &dm->dc_lock) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			amdgpu_dm_psr_set_event(dm, new_state->stream, true,
+				psr_event_vrr_transition, true);
+			amdgpu_dm_replay_set_event(dm, new_state->stream, true,
+				replay_event_vrr, true);
+		}
+	} else if (old_vrr_active && !new_vrr_active) {
+		/* Transition VRR active -> inactive:
+		 * Allow vblank irq disable again for fixed refresh rate.
+		 */
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
+		drm_crtc_vblank_put(new_state->base.crtc);
+		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
+				 __func__, new_state->base.crtc->base.id);
+
+		scoped_guard(mutex, &dm->dc_lock) {
+			dc_exit_ips_for_hw_access(dm->dc);
+			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
+				psr_event_vrr_transition, false);
+			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
+				replay_event_vrr, false);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h
new file mode 100644
index 000000000000..24c410306284
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_DM_FREESYNC_H__
+#define __AMDGPU_DM_FREESYNC_H__
+
+#include <linux/types.h>
+
+struct amdgpu_display_manager;
+struct dm_crtc_state;
+struct dm_connector_state;
+struct dc_stream_state;
+struct dc_plane_state;
+struct drm_crtc_state;
+
+bool amdgpu_dm_is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
+					  struct dm_crtc_state *new_state);
+
+bool amdgpu_dm_is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
+						struct drm_crtc_state *new_crtc_state);
+
+void amdgpu_dm_set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state);
+
+void amdgpu_dm_reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
+
+void amdgpu_dm_get_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state,
+					    struct dm_connector_state *new_con_state);
+
+void amdgpu_dm_update_freesync_state_on_stream(struct amdgpu_display_manager *dm,
+					       struct dm_crtc_state *new_crtc_state,
+					       struct dc_stream_state *new_stream,
+					       struct dc_plane_state *surface,
+					       u32 flip_timestamp_in_us);
+
+void amdgpu_dm_update_stream_irq_parameters(struct amdgpu_display_manager *dm,
+					    struct dm_crtc_state *new_crtc_state);
+
+void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
+				     struct dm_crtc_state *old_state,
+				     struct dm_crtc_state *new_state);
+
+#endif /* __AMDGPU_DM_FREESYNC_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 1592e8dae1a9..e58ffc4dcd84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_plane_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_freesync_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
new file mode 100644
index 000000000000..0ae636dcbbe4
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_freesync.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_modes.h>
+
+#include "dc.h"
+#include "inc/core_types.h"
+#include "amd_shared.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_freesync.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+
+/* Tests for amdgpu_dm_is_timing_unchanged_for_freesync() */
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
+			   amdgpu_dm_is_timing_unchanged_for_freesync(NULL, &crtc_state));
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_is_timing_unchanged_for_freesync(&crtc_state, NULL));
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
+			   amdgpu_dm_is_timing_unchanged_for_freesync(&old_state, &new_state));
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
+			  amdgpu_dm_is_timing_unchanged_for_freesync(&old_state, &new_state));
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
+			   amdgpu_dm_is_timing_unchanged_for_freesync(&old_state, &new_state));
+}
+
+/* Tests for amdgpu_dm_set_freesync_fixed_config() */
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
+	amdgpu_dm_set_freesync_fixed_config(&dm_crtc_state);
+
+	KUNIT_EXPECT_EQ(test, (int)dm_crtc_state.freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	/* 148500 kHz / (2200 * 1125) = 60 Hz = 60000000 uHz */
+	KUNIT_EXPECT_EQ(test, dm_crtc_state.freesync_config.fixed_refresh_in_uhz,
+			60000000U);
+}
+
+/* Tests for amdgpu_dm_is_dc_timing_adjust_needed() */
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
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_dc_timing_adjust_needed(old_state, new_state));
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
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_dc_timing_adjust_needed(old_state, new_state));
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
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_is_dc_timing_adjust_needed(old_state, new_state));
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
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_dc_timing_adjust_needed(old_state, new_state));
+}
+
+/* Tests for amdgpu_dm_get_freesync_config_for_crtc() */
+
+struct dm_test_freesync_ctx {
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_crtc_state *crtc_state;
+	struct dm_connector_state *conn_state;
+	struct dc_stream_state *stream;
+};
+
+static struct dm_test_freesync_ctx *dm_test_freesync_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
+	ctx->stream = dm_kunit_alloc_stream(test, NULL);
+
+	ctx->conn_state->base.connector = &ctx->aconnector->base;
+	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	ctx->crtc_state->stream = ctx->stream;
+
+	/* 1080p60 timing so drm_mode_vrefresh() == 60 */
+	ctx->crtc_state->base.mode.clock = 148500;
+	ctx->crtc_state->base.mode.htotal = 2200;
+	ctx->crtc_state->base.mode.vtotal = 1125;
+
+	return ctx;
+}
+
+/**
+ * dm_test_freesync_config_writeback - Test writeback connector is left untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_writeback(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->vrr_supported = true;	/* sentinel: must stay set */
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	/* Writeback: early return leaves vrr_supported sentinel untouched */
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+}
+
+/**
+ * dm_test_freesync_config_not_capable - Test a non-freesync sink reports UNSUPPORTED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_not_capable(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = false;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+}
+
+/**
+ * dm_test_freesync_config_out_of_range - Test a refresh outside the range is UNSUPPORTED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_out_of_range(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 90;	/* 60 < 90 -> out of range */
+	ctx->aconnector->max_vfreq = 120;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+}
+
+/**
+ * dm_test_freesync_config_active_variable - Test vrr_enabled yields ACTIVE_VARIABLE
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_active_variable(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->base.vrr_enabled = true;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_TRUE(test, ctx->stream->ignore_msa_timing_param);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_VARIABLE);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.min_refresh_in_uhz,
+			48000000U);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.max_refresh_in_uhz,
+			120000000U);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.vsif_supported);
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.btr);
+}
+
+/**
+ * dm_test_freesync_config_inactive - Test supported-but-off yields INACTIVE
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_inactive(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	ctx->crtc_state->base.vrr_enabled = false;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_INACTIVE);
+}
+
+/**
+ * dm_test_freesync_config_active_fixed - Test freesync-video mode yields ACTIVE_FIXED
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_active_fixed(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 48;
+	ctx->aconnector->max_vfreq = 120;
+	/* Pre-set fixed state selects the freesync-video (fixed) path */
+	ctx->crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
+	ctx->crtc_state->freesync_config.fixed_refresh_in_uhz = 60000000;
+	ctx->crtc_state->base.vrr_enabled = true;	/* ignored on the fixed path */
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_ACTIVE_FIXED);
+	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.fixed_refresh_in_uhz,
+			60000000U);
+}
+
+/* Tests for amdgpu_dm_reset_freesync_config_for_crtc() */
+
+/**
+ * dm_test_reset_freesync_config - Test reset clears vrr support and info packet
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_freesync_config(struct kunit *test)
+{
+	struct dm_crtc_state *crtc_state;
+
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+
+	crtc_state->vrr_supported = true;
+	crtc_state->vrr_infopacket.valid = true;
+
+	amdgpu_dm_reset_freesync_config_for_crtc(crtc_state);
+
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_supported);
+	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_infopacket.valid);
+}
+
+static struct kunit_case amdgpu_dm_freesync_tests[] = {
+	/* amdgpu_dm_is_timing_unchanged_for_freesync */
+	KUNIT_CASE(dm_test_timing_unchanged_null_args),
+	KUNIT_CASE(dm_test_timing_unchanged_identical_modes),
+	KUNIT_CASE(dm_test_timing_unchanged_vrr_shift),
+	KUNIT_CASE(dm_test_timing_unchanged_clock_changed),
+	/* amdgpu_dm_set_freesync_fixed_config */
+	KUNIT_CASE(dm_test_set_freesync_fixed_config_60hz),
+	/* amdgpu_dm_is_dc_timing_adjust_needed */
+	KUNIT_CASE(dm_test_dc_timing_adjust_pending),
+	KUNIT_CASE(dm_test_dc_timing_adjust_active_fixed),
+	KUNIT_CASE(dm_test_dc_timing_adjust_vrr_toggle),
+	KUNIT_CASE(dm_test_dc_timing_adjust_not_needed),
+	/* amdgpu_dm_get_freesync_config_for_crtc */
+	KUNIT_CASE(dm_test_freesync_config_writeback),
+	KUNIT_CASE(dm_test_freesync_config_not_capable),
+	KUNIT_CASE(dm_test_freesync_config_out_of_range),
+	KUNIT_CASE(dm_test_freesync_config_active_variable),
+	KUNIT_CASE(dm_test_freesync_config_inactive),
+	KUNIT_CASE(dm_test_freesync_config_active_fixed),
+	/* amdgpu_dm_reset_freesync_config_for_crtc */
+	KUNIT_CASE(dm_test_reset_freesync_config),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_freesync_test_suite = {
+	.name = "amdgpu_dm_freesync",
+	.test_cases = amdgpu_dm_freesync_tests,
+};
+
+kunit_test_suite(amdgpu_dm_freesync_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_freesync");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 49a1d2ae5588..428d24259198 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -860,214 +860,6 @@ static void dm_test_scaling_state_underscan_border_changed(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, is_scaling_state_different(a, b));
 }
 
-/* Tests for is_timing_unchanged_for_freesync() */
-
-/**
- * dm_test_timing_unchanged_null_args - Test NULL crtc states return false
- * @test: The KUnit test context
- */
-static void dm_test_timing_unchanged_null_args(struct kunit *test)
-{
-	struct drm_crtc_state crtc_state = { 0 };
-
-	KUNIT_EXPECT_FALSE(test,
-			   is_timing_unchanged_for_freesync(NULL, &crtc_state));
-	KUNIT_EXPECT_FALSE(test,
-			   is_timing_unchanged_for_freesync(&crtc_state, NULL));
-}
-
-/**
- * dm_test_timing_unchanged_identical_modes - Test identical modes are not "unchanged"
- * @test: The KUnit test context
- *
- * The helper only returns true when vtotal/vsync shift (vrr) while the rest
- * of the timing stays fixed, so identical modes must return false.
- */
-static void dm_test_timing_unchanged_identical_modes(struct kunit *test)
-{
-	struct drm_crtc_state old_state = { 0 };
-	struct drm_crtc_state new_state = { 0 };
-
-	old_state.mode.clock = 148500;
-	old_state.mode.hdisplay = 1920;
-	old_state.mode.vdisplay = 1080;
-	old_state.mode.htotal = 2200;
-	old_state.mode.vtotal = 1125;
-	new_state.mode = old_state.mode;
-
-	KUNIT_EXPECT_FALSE(test,
-			   is_timing_unchanged_for_freesync(&old_state, &new_state));
-}
-
-/**
- * dm_test_timing_unchanged_vrr_shift - Test vrr-style vtotal/vsync shift is detected
- * @test: The KUnit test context
- */
-static void dm_test_timing_unchanged_vrr_shift(struct kunit *test)
-{
-	struct drm_crtc_state old_state = { 0 };
-	struct drm_crtc_state new_state = { 0 };
-
-	old_state.mode.clock = 148500;
-	old_state.mode.hdisplay = 1920;
-	old_state.mode.vdisplay = 1080;
-	old_state.mode.htotal = 2200;
-	old_state.mode.vtotal = 1125;
-	old_state.mode.hsync_start = 2008;
-	old_state.mode.vsync_start = 1084;
-	old_state.mode.hsync_end = 2052;
-	old_state.mode.vsync_end = 1089;
-
-	/* Same horizontal timing, vertical totals/sync shifted by 125 lines */
-	new_state.mode = old_state.mode;
-	new_state.mode.vtotal = 1250;
-	new_state.mode.vsync_start = 1209;
-	new_state.mode.vsync_end = 1214;
-
-	KUNIT_EXPECT_TRUE(test,
-			  is_timing_unchanged_for_freesync(&old_state, &new_state));
-}
-
-/**
- * dm_test_timing_unchanged_clock_changed - Test pixel clock change returns false
- * @test: The KUnit test context
- */
-static void dm_test_timing_unchanged_clock_changed(struct kunit *test)
-{
-	struct drm_crtc_state old_state = { 0 };
-	struct drm_crtc_state new_state = { 0 };
-
-	old_state.mode.clock = 148500;
-	old_state.mode.htotal = 2200;
-	old_state.mode.vtotal = 1125;
-	old_state.mode.vsync_start = 1084;
-	old_state.mode.vsync_end = 1089;
-
-	new_state.mode = old_state.mode;
-	new_state.mode.clock = 297000;
-	new_state.mode.vtotal = 1250;
-	new_state.mode.vsync_start = 1209;
-	new_state.mode.vsync_end = 1214;
-
-	KUNIT_EXPECT_FALSE(test,
-			   is_timing_unchanged_for_freesync(&old_state, &new_state));
-}
-
-/* Tests for set_freesync_fixed_config() */
-
-/**
- * dm_test_set_freesync_fixed_config_60hz - Test fixed refresh computed for 1080p60
- * @test: The KUnit test context
- */
-static void dm_test_set_freesync_fixed_config_60hz(struct kunit *test)
-{
-	struct dm_crtc_state dm_crtc_state = { 0 };
-
-	dm_crtc_state.base.mode.clock = 148500;
-	dm_crtc_state.base.mode.htotal = 2200;
-	dm_crtc_state.base.mode.vtotal = 1125;
-
-	set_freesync_fixed_config(&dm_crtc_state);
-
-	KUNIT_EXPECT_EQ(test, (int)dm_crtc_state.freesync_config.state,
-			(int)VRR_STATE_ACTIVE_FIXED);
-	/* 148500 kHz / (2200 * 1125) = 60 Hz = 60000000 uHz */
-	KUNIT_EXPECT_EQ(test, dm_crtc_state.freesync_config.fixed_refresh_in_uhz,
-			60000000U);
-}
-
-/* Tests for is_dc_timing_adjust_needed() */
-
-/**
- * dm_test_dc_timing_adjust_pending - Test a pending hw timing adjust forces true
- * @test: The KUnit test context
- */
-static void dm_test_dc_timing_adjust_pending(struct kunit *test)
-{
-	struct dm_crtc_state *old_state, *new_state;
-	struct dc_stream_state *stream;
-
-	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
-	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
-	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	new_state->stream = stream;
-	stream->adjust.timing_adjust_pending = 1;
-
-	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
-}
-
-/**
- * dm_test_dc_timing_adjust_active_fixed - Test VRR active-fixed forces true
- * @test: The KUnit test context
- */
-static void dm_test_dc_timing_adjust_active_fixed(struct kunit *test)
-{
-	struct dm_crtc_state *old_state, *new_state;
-	struct dc_stream_state *stream;
-
-	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
-	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
-	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	new_state->stream = stream;
-	new_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
-
-	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
-}
-
-/**
- * dm_test_dc_timing_adjust_vrr_toggle - Test a change in vrr active state forces true
- * @test: The KUnit test context
- */
-static void dm_test_dc_timing_adjust_vrr_toggle(struct kunit *test)
-{
-	struct dm_crtc_state *old_state, *new_state;
-	struct dc_stream_state *stream;
-
-	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
-	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
-	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	new_state->stream = stream;
-	old_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
-	new_state->freesync_config.state = VRR_STATE_INACTIVE;
-
-	KUNIT_EXPECT_TRUE(test, is_dc_timing_adjust_needed(old_state, new_state));
-}
-
-/**
- * dm_test_dc_timing_adjust_not_needed - Test steady-state timing needs no adjust
- * @test: The KUnit test context
- */
-static void dm_test_dc_timing_adjust_not_needed(struct kunit *test)
-{
-	struct dm_crtc_state *old_state, *new_state;
-	struct dc_stream_state *stream;
-
-	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, old_state);
-	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_state);
-	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
-
-	new_state->stream = stream;
-	old_state->freesync_config.state = VRR_STATE_INACTIVE;
-	new_state->freesync_config.state = VRR_STATE_INACTIVE;
-
-	KUNIT_EXPECT_FALSE(test, is_dc_timing_adjust_needed(old_state, new_state));
-}
-
 /* Tests for set_multisync_trigger_params() */
 
 /**
@@ -1435,194 +1227,6 @@ static void dm_test_cp_diff_desired_to_undesired(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm_test_cp_diff(ctx));
 }
 
-/* Tests for get_freesync_config_for_crtc() */
-
-struct dm_test_freesync_ctx {
-	struct amdgpu_dm_connector *aconnector;
-	struct dm_crtc_state *crtc_state;
-	struct dm_connector_state *conn_state;
-	struct dc_stream_state *stream;
-};
-
-static struct dm_test_freesync_ctx *dm_test_freesync_ctx_alloc(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx;
-
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx);
-
-	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
-	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
-	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
-	ctx->stream = dm_kunit_alloc_stream(test, NULL);
-
-	ctx->conn_state->base.connector = &ctx->aconnector->base;
-	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
-	ctx->crtc_state->stream = ctx->stream;
-
-	/* 1080p60 timing so drm_mode_vrefresh() == 60 */
-	ctx->crtc_state->base.mode.clock = 148500;
-	ctx->crtc_state->base.mode.htotal = 2200;
-	ctx->crtc_state->base.mode.vtotal = 1125;
-
-	return ctx;
-}
-
-/**
- * dm_test_freesync_config_writeback - Test writeback connector is left untouched
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_writeback(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
-	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
-	ctx->crtc_state->vrr_supported = true;	/* sentinel: must stay set */
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	/* Writeback: early return leaves vrr_supported sentinel untouched */
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
-}
-
-/**
- * dm_test_freesync_config_not_capable - Test a non-freesync sink reports UNSUPPORTED
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_not_capable(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->conn_state->freesync_capable = false;
-	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
-	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
-			(int)VRR_STATE_UNSUPPORTED);
-}
-
-/**
- * dm_test_freesync_config_out_of_range - Test a refresh outside the range is UNSUPPORTED
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_out_of_range(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 90;	/* 60 < 90 -> out of range */
-	ctx->aconnector->max_vfreq = 120;
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
-	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
-			(int)VRR_STATE_UNSUPPORTED);
-}
-
-/**
- * dm_test_freesync_config_active_variable - Test vrr_enabled yields ACTIVE_VARIABLE
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_active_variable(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
-	ctx->crtc_state->base.vrr_enabled = true;
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
-	KUNIT_EXPECT_TRUE(test, ctx->stream->ignore_msa_timing_param);
-	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
-			(int)VRR_STATE_ACTIVE_VARIABLE);
-	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.min_refresh_in_uhz,
-			48000000U);
-	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.max_refresh_in_uhz,
-			120000000U);
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.vsif_supported);
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.btr);
-}
-
-/**
- * dm_test_freesync_config_inactive - Test supported-but-off yields INACTIVE
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_inactive(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
-	ctx->crtc_state->base.vrr_enabled = false;
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
-	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
-			(int)VRR_STATE_INACTIVE);
-}
-
-/**
- * dm_test_freesync_config_active_fixed - Test freesync-video mode yields ACTIVE_FIXED
- * @test: The KUnit test context
- */
-static void dm_test_freesync_config_active_fixed(struct kunit *test)
-{
-	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
-
-	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
-	/* Pre-set fixed state selects the freesync-video (fixed) path */
-	ctx->crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
-	ctx->crtc_state->freesync_config.fixed_refresh_in_uhz = 60000000;
-	ctx->crtc_state->base.vrr_enabled = true;	/* ignored on the fixed path */
-
-	get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
-
-	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
-	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
-			(int)VRR_STATE_ACTIVE_FIXED);
-	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.fixed_refresh_in_uhz,
-			60000000U);
-}
-
-/* Tests for reset_freesync_config_for_crtc() */
-
-/**
- * dm_test_reset_freesync_config - Test reset clears vrr support and info packet
- * @test: The KUnit test context
- */
-static void dm_test_reset_freesync_config(struct kunit *test)
-{
-	struct dm_crtc_state *crtc_state;
-
-	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
-
-	crtc_state->vrr_supported = true;
-	crtc_state->vrr_infopacket.valid = true;
-
-	reset_freesync_config_for_crtc(crtc_state);
-
-	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_supported);
-	KUNIT_EXPECT_FALSE(test, crtc_state->vrr_infopacket.valid);
-}
-
 /* Tests for dm_enable_per_frame_crtc_master_sync() */
 
 /**
@@ -1818,18 +1422,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_scaling_state_underscan_enabled),
 	KUNIT_CASE(dm_test_scaling_state_underscan_disabled),
 	KUNIT_CASE(dm_test_scaling_state_underscan_border_changed),
-	/* is_timing_unchanged_for_freesync */
-	KUNIT_CASE(dm_test_timing_unchanged_null_args),
-	KUNIT_CASE(dm_test_timing_unchanged_identical_modes),
-	KUNIT_CASE(dm_test_timing_unchanged_vrr_shift),
-	KUNIT_CASE(dm_test_timing_unchanged_clock_changed),
-	/* set_freesync_fixed_config */
-	KUNIT_CASE(dm_test_set_freesync_fixed_config_60hz),
-	/* is_dc_timing_adjust_needed */
-	KUNIT_CASE(dm_test_dc_timing_adjust_pending),
-	KUNIT_CASE(dm_test_dc_timing_adjust_active_fixed),
-	KUNIT_CASE(dm_test_dc_timing_adjust_vrr_toggle),
-	KUNIT_CASE(dm_test_dc_timing_adjust_not_needed),
 	/* set_multisync_trigger_params */
 	KUNIT_CASE(dm_test_multisync_trigger_disabled),
 	KUNIT_CASE(dm_test_multisync_trigger_rising),
@@ -1849,15 +1441,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_cp_diff_s3_undesired_to_enabled),
 	KUNIT_CASE(dm_test_cp_diff_desired_to_enabled),
 	KUNIT_CASE(dm_test_cp_diff_desired_to_undesired),
-	/* get_freesync_config_for_crtc */
-	KUNIT_CASE(dm_test_freesync_config_writeback),
-	KUNIT_CASE(dm_test_freesync_config_not_capable),
-	KUNIT_CASE(dm_test_freesync_config_out_of_range),
-	KUNIT_CASE(dm_test_freesync_config_active_variable),
-	KUNIT_CASE(dm_test_freesync_config_inactive),
-	KUNIT_CASE(dm_test_freesync_config_active_fixed),
-	/* reset_freesync_config_for_crtc */
-	KUNIT_CASE(dm_test_reset_freesync_config),
 	/* dm_enable_per_frame_crtc_master_sync */
 	KUNIT_CASE(dm_test_per_frame_master_sync_single_stream),
 	KUNIT_CASE(dm_test_per_frame_master_sync_two_streams),
-- 
2.53.0

