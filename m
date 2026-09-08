Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DCCC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E7E10EB62;
	Tue,  8 Sep 2026 11:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGtlOQ/t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9A510EB62
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC/xv//cn9DpeY5aTZa3DQySfzmPxVRJksS6VtN8aEZioLZhuCCFUFITVb5LcNZ+VIBBvx5x2ISHkMshu2otYhoT/IyNjcqFI6BmR3kWmJW3ZWFluTKmAKM37NsA4im3kpe+/Y9mUg07VpuWYiNJqhTsk178QbfMNU7UPTtc5NsWrCK/UmSMSjGgs/kVhe5y3gkgdbEf8mFrQPDZ5gnrqJX2pLwiNpvh5vhu3bE/PfO0nZSOsyyif7sHfltc+W5+oQOHYbW+8c8Bj6S8qZgjY2GCA//i55DUarynwP/jI3vbvbwNXL6Ixv9K4LCH+rsU8ctMgntiiVAOvkr+WPo31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMjkXKO2xPJzldM0VFANhwDBvCtAk87hpkqmID0q/W8=;
 b=xOjASdaeoZkctXxQkliaLo+dWaxUN1chXbCf/KUNdybPAqBRuEqtoKnK+t+cjyHZJlAf2y8p87sJk2yLEdvLtGFzXGos6MgLbLey0kJ+dpdgUN4m5wAZ5Tg6Yt5nfuMjlhePLgk1tU7hAun9SetW2Z8sIHy9yVGANtcKslm3Wew6RqkvvkzkTDYM65f9D6x/zZNS+ioQ0WPAJ2iwCZuVgJTCNqn+mlllYkbx6Xbvz62K1HIicJeN+S7lGz9UHZZ+95Va+WADRrEBbozFxFER2Yw06etGPM5xROoGn0Te9uAY2F19+xR3jGKU3nYgvv9mjX7SQYSNcsVAgrKptWjoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMjkXKO2xPJzldM0VFANhwDBvCtAk87hpkqmID0q/W8=;
 b=qGtlOQ/tWxJOFjbMLGNJyekdFWy5iOFEBtJ22uaSuEa2UMG86ANm3VRoj02s7dzuqbu9BYO38JvE+k1+OnQ23cJWc8r+RNE0vp/Jovvcg6Qujk6dQeiHmNHRuFNM4ZQ1Z2OBlHDE0RW9Qe0QdMJHWl+5pkp12iLjBFBEJbGKHPo=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 11:40:45 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::ad) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:40:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:33 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:40:20 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 45/66] drm/amd/display: Rename lock_and_validation_needed to
 needs_dc_state_realloc
Date: Tue, 8 Sep 2026 19:31:38 +0800
Message-ID: <20260908113338.2433445-46-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: d272f595-6ab7-4246-163d-08df0d9e04d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /1uGmSgJaofWN1U/gTW2hT2MZewgvb7LgJgRDw3zHrpt2Qayo2aQKqsOWPj7ec6PLkylpfEeFlysYNsMRFNyLQ6BZpBfvdq/GKFcR4LQHpOiMqQncLQ9kKMhmZ7b0VKFJjqbMDsu9waKQjus8NnRJh9rExImBHQhIXmdlCga6Z+bmgXRXl4hSHohqYbgeZLXRn/faah94Ny5xTnm0Pf22X9x3/T2wxX5qXzAUL8RTNShLxnheaWabmfJLXAKNzc5BEqL9MHyVw9LkECmdIlefDFRWSO2J88v8jg2iVQvfXIxml7GMqj/8nj4eLz+tqmmCZ7jv+VCOIvV13ILS+hgSoadAbDLip82dscB+RrjN6E8XmqSY0l3bIPccCMZZ4kdRmrODyXMO/TipAq1t4lvBnTPE/6bzOJadmrmqgtMXUefHXRMyQb6rgLeXcTVLw2N9tWaZ43xKHUrijaQabP30Evr+JYfn6vjbWAD1pSzL/LXaUMmTgBmKti7LqGY69GLL5wWVQ5/VyhUdMiZEB3msfzR4wt29d2huY89J++Wv4AoGcw9IAMpuHRzrq/x1LisSxNh8YFF4E/x5xBclGjVMNq4dZwndr7lYzk3M3JiBCD7PiAY9aM+JL/FQlHZm4NIMnufNojRntjiFUj/HFirPXXf1UTt/zmJev3jWvuQVTdAkIrpr+wARJHpGxxW93Ixw1ONAKVektY6aOji9DOQqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TGoRzaMI00qljCNYE+3eTfxQV7jZsL4Vr9Iwgr9Ckww1n7UGfknp88nyTbF9HChWwUP+JN2rQlW3tGOKt5FGcD5HsN2z5qacVyP2IkcDzuKG9V0GGgehPC9G2wN56bGa24DNrvqIoXVFWS9lIlzhtCVqNjRMXk/2k8Gub+nsR2oPKGi2g/b3YIUw+1gZc04aMIR9IR0C+qCOvpzotUm81hzyqiUiUtU8dm+IWQFDR+Gdfji+EpDmTA3yAQoEuCNLR1mLx18Yj4pQJmqh+AHcD2KtUP8MKRS1uYKuydbnL9oDNskFddKD292HH9Ke7jb9aYwJuXYPgphkwmqoSs14SJj0cN5gqaKK6ZlzuUCvmYEGwfWuvBGdUsFNmXtWfjoP5hUtL7ubF5FizqbZcMXaD04+murDT/lvdqNHdpUg7cTFltABzULK9keTi5LLwqqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:40:44.6642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d272f595-6ab7-4246-163d-08df0d9e04d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
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

From: James Lin <pinglei.lin@amd.com>

[Why & How]
Split the boolean's two meanings: it only tracks whether the commit needs
to rebuild the dc_state and take the global lock, not the update magnitude.
Rename it so the name reflects that; no functional change.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df649ae66de2..3ed0d8014d21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5443,7 +5443,7 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 					  struct drm_crtc_state *old_crtc_state,
 					  struct drm_crtc_state *new_crtc_state,
 					  bool enable,
-					  bool *lock_and_validation_needed)
+					  bool *needs_dc_state_realloc)
 {
 	struct dm_atomic_state *dm_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
@@ -5616,7 +5616,7 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		amdgpu_dm_reset_freesync_config_for_crtc(dm_new_crtc_state);
 
-		*lock_and_validation_needed = true;
+		*needs_dc_state_realloc = true;
 
 	} else {/* Add stream for any updated/enabled CRTC */
 		/*
@@ -5654,7 +5654,7 @@ STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 				goto fail;
 			}
 
-			*lock_and_validation_needed = true;
+			*needs_dc_state_realloc = true;
 		}
 	}
 
@@ -5886,7 +5886,7 @@ dm_update_plane_state(struct dc *dc,
 		      struct drm_plane_state *old_plane_state,
 		      struct drm_plane_state *new_plane_state,
 		      bool enable,
-		      bool *lock_and_validation_needed,
+		      bool *needs_dc_state_realloc,
 		      bool *is_top_most_overlay)
 {
 
@@ -5957,7 +5957,7 @@ dm_update_plane_state(struct dc *dc,
 
 		dm_new_plane_state->dc_state = NULL;
 
-		*lock_and_validation_needed = true;
+		*needs_dc_state_realloc = true;
 
 	} else { /* Add new planes */
 		struct dc_plane_state *dc_new_plane_state;
@@ -6035,7 +6035,7 @@ dm_update_plane_state(struct dc *dc,
 		 */
 		dm_new_plane_state->dc_state->update_bits.full_update = 1;
 
-		*lock_and_validation_needed = true;
+		*needs_dc_state_realloc = true;
 	}
 
 out:
@@ -6192,7 +6192,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 	struct drm_plane_state *old_plane_state, *new_plane_state, *new_cursor_state;
 	enum dc_status status;
 	int ret, i;
-	bool lock_and_validation_needed = false;
+	bool needs_dc_state_realloc = false;
 	bool is_top_most_overlay = true;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	struct drm_dp_mst_topology_mgr *mgr;
@@ -6366,7 +6366,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    old_plane_state,
 					    new_plane_state,
 					    false,
-					    &lock_and_validation_needed,
+					    &needs_dc_state_realloc,
 					    &is_top_most_overlay);
 		if (ret) {
 			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(ret));
@@ -6380,7 +6380,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   old_crtc_state,
 					   new_crtc_state,
 					   false,
-					   &lock_and_validation_needed);
+					   &needs_dc_state_realloc);
 		if (ret) {
 			drm_dbg_atomic(dev, "DISABLE: dm_update_crtc_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
@@ -6393,7 +6393,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 					   old_crtc_state,
 					   new_crtc_state,
 					   true,
-					   &lock_and_validation_needed);
+					   &needs_dc_state_realloc);
 		if (ret) {
 			drm_dbg_atomic(dev, "ENABLE: dm_update_crtc_state() failed: %pe\n", ERR_PTR(ret));
 			goto fail;
@@ -6406,7 +6406,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    old_plane_state,
 					    new_plane_state,
 					    true,
-					    &lock_and_validation_needed,
+					    &needs_dc_state_realloc,
 					    &is_top_most_overlay);
 		if (ret) {
 			drm_dbg_atomic(dev, "dm_update_plane_state() failed: %pe\n", ERR_PTR(ret));
@@ -6521,7 +6521,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (!is_scaling_state_different(dm_new_con_state, dm_old_con_state))
 			continue;
 
-		lock_and_validation_needed = true;
+		needs_dc_state_realloc = true;
 	}
 
 	/* set the slot info for each mst_state based on the link encoding format */
@@ -6557,7 +6557,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 	 *
 	 * TODO: Remove this stall and drop DM state private objects.
 	 */
-	if (lock_and_validation_needed) {
+	if (needs_dc_state_realloc) {
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret) {
 			drm_dbg_atomic(dev, "dm_atomic_get_state() failed: %pe\n", ERR_PTR(ret));
@@ -6658,7 +6658,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 * the FB pitch, the DCC state, rotation, mem_type, etc.
 		 */
 		if (new_crtc_state->async_flip &&
-		    (lock_and_validation_needed ||
+		    (needs_dc_state_realloc ||
 		     amdgpu_dm_crtc_mem_type_changed(dev, state, new_crtc_state))) {
 			drm_dbg_atomic(crtc->dev,
 				       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
@@ -6667,7 +6667,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 			goto fail;
 		}
 
-		dm_new_crtc_state->update_type = lock_and_validation_needed ?
+		dm_new_crtc_state->update_type = needs_dc_state_realloc ?
 			UPDATE_TYPE_FULL : UPDATE_TYPE_FAST;
 	}
 
-- 
2.43.0

