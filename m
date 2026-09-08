Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83625C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F7810E0EA;
	Tue,  8 Sep 2026 11:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywYtRi2Y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C6A10EB68
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky4Jfwi6qSKj5XAeG7rcSti0+WzLufL/BsboQU3c/lBUW3kZO/zK0VsQzteI5/+YF23HV3Zl6DnHjVyUWpOJiqn76XkxwtUelKFjBGhIdhxeF6RniPS6VNzdu4C39x360/hf5k+5tTn2FRphVtWLs/KSYUtOjcC4pobf9EfgvsKp+nyPc+u+SA9y7awjpj4dKKZ6xE0TfxY9QWK2asrOuHx6QDDjf9hWRxVP8Nwe4DHwwslHo4XQkVm70vhYZM/9smfi20VCzfCJj8Y4t6lAyhqs6fpX5ab8g+ckQlZgfTnTTKhHHE+841pwvIMK4l7C5nYX473tjoiarR/nm9nHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCUfwszkc2ji9av5LWfRswQxfBxaJvXYrooBDm4dw3o=;
 b=xBWLrgPXJlI+LIVYKL29gVeNspqOIsXPBVLSVaVoiBKMXG9e6Rqa3AOw8frWb6AFUkEs6SI9beELcvTtVu6AkW4Jw1dua9Uy8T9wJtU5SAeUMKB4lsAzdnLcGvgIhG4VEK2Ow0MW/DyrpWOtFEOH9uXEyzU+nmmAPCAK8jZedrrusRUOB4OagQJZoZ3QS3ybm+e7nub1UULxXixQNxALjgUplXImHVgu7zYc/D4kgZXq8VT93Ck1lUn45Eoa+L4CWH9sJRA4kVNFZt4AO2CVNSHyputmr99AR2CZBP1hl1Csbit9X/FBBix4RWPa0KEHxxvp4fHTnWus06Q3PnE46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCUfwszkc2ji9av5LWfRswQxfBxaJvXYrooBDm4dw3o=;
 b=ywYtRi2Y8RFSdcySRcKaA6UBtDsH/jILdW1v7zJz3NPpu+LFif6RlnXK4bFWC0swGLOAvXEg3vAreo0rb9kkjKKDwR4kPpLCKSdiBPWmOW5P65tPH2Y+oRuhyVhMtq4tkgKAO5ayTFpxH2AGAOC5xRNTT4wvRSJ9nb9jwrZTKmc=
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:40:48 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::2d) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:40:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:47 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:40:34 -0500
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
Subject: [PATCH 46/66] drm/amd/display: Attach only plane updates that
 actually changed
Date: Tue, 8 Sep 2026 19:31:39 +0800
Message-ID: <20260908113338.2433445-47-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: d11088f5-3f14-494c-f3ca-08df0d9e071f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: rtILKyndfKF7Ji9pgOo+6LKowvlSPscJvcKE0GX4pF7iFyB7lKU8My69Yeqxo/CfzUIB+7d1FmvUsvTTf7ji3023wQn4s7p0LNv84wTHiKzy/15JNAqoM9xrcjArABwMm4IjjhzE+HuHUTnbuaB1hJS7f0YbP2aUxEn4kQ1hCSZZIx13yG6kAjBsM3PNXXdVfpOoi2vGIjMIHxAUKRC9gMvRdudc5XJnrl/DXK4LfO/sby0VWOQPX5O+QuyMHhbNi0NHkLQnGasULoA4TuCL0m2oE8RwUtINwznaxSIs/HSX2L0QYky72EC/YuxydgXdDRR6KzajNj0BSu9YLuZ8nweYF+G6WNXA1KmGqzC9A/TXqDCfPBRXgAjp307th3iCQoMr3rcZqcSSOds5hXkPupjnTgiOLPYMCNDvVWjylUyHXxmCbP7qZrZkQU8A5N+3HioYvGeKYSfdtmhilCZ5KTWrn7NAPPWEmRk+H9G+gconCffyQZq/EW3ziwjV/Bq6pRsvQf0J2x8aSKwjpbwybDrQXoKUTQYxH4/gAzoYM+cyLZ6v2H71/uupo5yvkyVF9KtBDyatWqU5MhR6YCAYlj2sEYqnaJx1Tmpnhh///0ETgxSuyt8bJ1or5maw6QaB8MTTtL17fAKJJ6ZPH+NS4rYXFXAAJUMbsEdX4WMD8igWXNbzFrg1HkdhHuWMPlG6Hu8iY367U7sb0M4qMD+VcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jgjG2+x6K5j2VhwqOj48wI/d4W1z/pdyEkx+K207KDJXmTbLonozccDO0SVJH3NZ36JH52OA6aBOOm8jDV3SJXVuf4qP3NqSsrA6VBU9P2Dd9nSjujF7hZJbXHjn2+Y6x0aNZrYGDMHE7SUQRAth3CGwG/crWl7fKxBBbD0eXp0NNJ3/Ju3q36Zy7Y2pgWGZxvlcPw/ZYpID8cW0VqvgxhR/AH5QVRU11ZYYEstcarJUhNHlu1SG0Ue8jOhBdys2fXANtHI5hd1J0/MTiikOxaITY9GqkqEUzwqNC/KYANH9+0MSitL+MDIVTKNKJnqNhJ2oo1Ph5Z9PmwBuyU8nio8/IF6BU8aOyyIApm9++PoluJaoH/kOiqWure8keNX60OcbMC4EUspQ32JigHoi74h5g2Q2xKAxq/4fUgSpUAhP1w2VVBV3kZNKS9bwgEtw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:40:48.5042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11088f5-3f14-494c-f3ca-08df0d9e071f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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
Cache the last programmed dc_flip_addrs/dc_plane_info/dc_scaling_info in
dm_plane_state and carry them across atomic_duplicate_state. In
amdgpu_dm_commit_planes() attach each flip_addr/plane_info/scaling_info
surface update only when it differs from the cache (memcmp), so an
address-only flip sends no plane_info/scaling_info update and stays on the
FAMS2 offload path.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 32 ++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 21 ++++++++-
 4 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3ed0d8014d21..9c7fdd2844e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3923,6 +3923,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		bool plane_needs_flip;
 		struct dc_plane_state *dc_plane;
 		struct dm_plane_state *dm_new_plane_state = to_dm_plane_state(new_plane_state);
+		struct dm_plane_state *dm_old_plane_state = to_dm_plane_state(old_plane_state);
 
 		/* Cursor plane is handled after stream updates */
 		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
@@ -3957,11 +3958,22 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 			bundle->surface_updates[planes_count].cm = &dc_plane->cm;
 		}
 
-		amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
-				     &bundle->scaling_infos[planes_count]);
+		if (amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
+							 &bundle->scaling_infos[planes_count])) {
+			planes_count += 1;
+			continue;
+		}
 
-		bundle->surface_updates[planes_count].scaling_info =
-			&bundle->scaling_infos[planes_count];
+		/* Cache the newly computed scaling_info in the plane state */
+		*dm_new_plane_state->scaling_info =
+			bundle->scaling_infos[planes_count];
+
+		/* Only send a scaling_info update if it changed vs the old state */
+		if (memcmp(dm_old_plane_state->scaling_info,
+			   dm_new_plane_state->scaling_info,
+			   sizeof(struct dc_scaling_info)))
+			bundle->surface_updates[planes_count].scaling_info =
+				&bundle->scaling_infos[planes_count];
 
 		plane_needs_flip = old_plane_state->fb && new_plane_state->fb;
 
@@ -3982,8 +3994,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
 
-		bundle->surface_updates[planes_count].plane_info =
-			&bundle->plane_infos[planes_count];
+		/* Cache the newly computed plane_info in the plane state */
+		*dm_new_plane_state->plane_info =
+			bundle->plane_infos[planes_count];
+
+		/* Only send a plane_info update if it changed vs the old state */
+		if (memcmp(dm_old_plane_state->plane_info,
+			   dm_new_plane_state->plane_info,
+			   sizeof(struct dc_plane_info)))
+			bundle->surface_updates[planes_count].plane_info =
+				&bundle->plane_infos[planes_count];
 
 		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
 		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
@@ -4038,7 +4058,16 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 
 		timestamp_ns = ktime_get_ns();
 		bundle->flip_addrs[planes_count].flip_timestamp_in_us = div_u64(timestamp_ns, 1000);
-		bundle->surface_updates[planes_count].flip_addr = &bundle->flip_addrs[planes_count];
+		/* Cache the newly computed flip_addr in the plane state */
+		*dm_new_plane_state->flip_addr =
+			bundle->flip_addrs[planes_count];
+
+		/* Only send a flip_addr update if it changed vs the old state */
+		if (memcmp(dm_old_plane_state->flip_addr,
+			   dm_new_plane_state->flip_addr,
+			   sizeof(struct dc_flip_addrs)))
+			bundle->surface_updates[planes_count].flip_addr =
+				&bundle->flip_addrs[planes_count];
 		bundle->surface_updates[planes_count].surface = dc_plane;
 
 		if (!bundle->surface_updates[planes_count].surface) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c99a84bb040e..d2b1a63c99a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -937,6 +937,10 @@ enum amdgpu_transfer_function {
 	AMDGPU_TRANSFER_FUNCTION_COUNT
 };
 
+struct dc_flip_addrs;
+struct dc_scaling_info;
+struct dc_plane_info;
+
 struct dm_plane_state {
 	struct drm_plane_state base;
 	struct dc_plane_state *dc_state;
@@ -1006,6 +1010,16 @@ struct dm_plane_state {
 	 * applying blend LUT.
 	 */
 	enum amdgpu_transfer_function blend_tf;
+
+	/* Cached per-plane surface descriptors kept in the DRM plane state.
+	 * The DRM atomic old/new state swap lets us compare the previous
+	 * commit's values (old) against the newly computed ones to detect a
+	 * real plane change (vs an address-only flip) so DC only gets a
+	 * scaling_info/plane_info surface update when it actually changed.
+	 */
+	struct dc_flip_addrs *flip_addr;
+	struct dc_scaling_info *scaling_info;
+	struct dc_plane_info *plane_info;
 };
 
 enum amdgpu_dm_cursor_mode {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 23054952a6f6..7f85ef395013 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -33,6 +33,7 @@
 #include <drm/drm_fourcc.h>
 
 #include "amdgpu.h"
+#include "dc.h"
 #include "dal_asic_id.h"
 #include "amdgpu_display.h"
 #include "amdgpu_dm_trace.h"
@@ -1806,6 +1807,18 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
 	if (!amdgpu_state)
 		return;
 
+	amdgpu_state->flip_addr = kzalloc_obj(*amdgpu_state->flip_addr);
+	amdgpu_state->scaling_info = kzalloc_obj(*amdgpu_state->scaling_info);
+	amdgpu_state->plane_info = kzalloc_obj(*amdgpu_state->plane_info);
+	if (!amdgpu_state->flip_addr || !amdgpu_state->scaling_info ||
+	    !amdgpu_state->plane_info) {
+		kfree(amdgpu_state->flip_addr);
+		kfree(amdgpu_state->scaling_info);
+		kfree(amdgpu_state->plane_info);
+		kfree(amdgpu_state);
+		return;
+	}
+
 	if (plane->state)
 		plane->funcs->atomic_destroy_state(plane, plane->state);
 
@@ -1827,6 +1840,21 @@ amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 	if (!dm_plane_state)
 		return NULL;
 
+	dm_plane_state->flip_addr = kmemdup(old_dm_plane_state->flip_addr,
+		sizeof(*old_dm_plane_state->flip_addr), GFP_KERNEL);
+	dm_plane_state->scaling_info = kmemdup(old_dm_plane_state->scaling_info,
+		sizeof(*old_dm_plane_state->scaling_info), GFP_KERNEL);
+	dm_plane_state->plane_info = kmemdup(old_dm_plane_state->plane_info,
+		sizeof(*old_dm_plane_state->plane_info), GFP_KERNEL);
+	if (!dm_plane_state->flip_addr || !dm_plane_state->scaling_info ||
+	    !dm_plane_state->plane_info) {
+		kfree(dm_plane_state->flip_addr);
+		kfree(dm_plane_state->scaling_info);
+		kfree(dm_plane_state->plane_info);
+		kfree(dm_plane_state);
+		return NULL;
+	}
+
 	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
 
 	if (old_dm_plane_state->dc_state) {
@@ -1946,6 +1974,10 @@ STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *
 	if (dm_plane_state->blend_lut)
 		drm_property_blob_put(dm_plane_state->blend_lut);
 
+	kfree(dm_plane_state->flip_addr);
+	kfree(dm_plane_state->scaling_info);
+	kfree(dm_plane_state->plane_info);
+
 	if (dm_plane_state->dc_state)
 		dc_plane_state_release(dm_plane_state->dc_state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index a39c0acad6f7..9f9d99e1b47a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2977,7 +2977,7 @@ static void dm_test_plane_reset_initializes_state(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, new_state->shaper_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
 	KUNIT_EXPECT_EQ(test, new_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
 
-	kfree(new_state);
+	amdgpu_dm_plane_drm_plane_destroy_state(plane, &new_state->base);
 }
 
 /**
@@ -3000,6 +3000,14 @@ static void dm_test_plane_duplicate_state_copies_fields(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, plane);
 	KUNIT_ASSERT_NOT_NULL(test, old_state);
 
+	/* duplicate_state kmemdup()s these, so the source state must own them. */
+	old_state->flip_addr = kunit_kzalloc(test, sizeof(*old_state->flip_addr), GFP_KERNEL);
+	old_state->scaling_info = kunit_kzalloc(test, sizeof(*old_state->scaling_info), GFP_KERNEL);
+	old_state->plane_info = kunit_kzalloc(test, sizeof(*old_state->plane_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->flip_addr);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->scaling_info);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->plane_info);
+
 	old_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_PQ_EOTF;
 	old_state->hdr_mult = 0x123456789ULL;
 	old_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_IDENTITY;
@@ -3016,7 +3024,7 @@ static void dm_test_plane_duplicate_state_copies_fields(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dup_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_SRGB_EOTF);
 	KUNIT_EXPECT_NULL(test, dup_state->dc_state);
 
-	kfree(dup_state);
+	amdgpu_dm_plane_drm_plane_destroy_state(plane, dup_base);
 }
 
 /*
@@ -3067,6 +3075,15 @@ static void dm_test_plane_duplicate_state_copies_resources(struct kunit *test)
 	kref_init(&dc_plane_state->refcount);
 	old_state->dc_state = dc_plane_state;
 	dm_test_attach_color_blobs(test, &adev->ddev, old_state);
+
+	/* duplicate_state kmemdup()s these, so the source state must own them. */
+	old_state->flip_addr = kunit_kzalloc(test, sizeof(*old_state->flip_addr), GFP_KERNEL);
+	old_state->scaling_info = kunit_kzalloc(test, sizeof(*old_state->scaling_info), GFP_KERNEL);
+	old_state->plane_info = kunit_kzalloc(test, sizeof(*old_state->plane_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->flip_addr);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->scaling_info);
+	KUNIT_ASSERT_NOT_NULL(test, old_state->plane_info);
+
 	plane->state = &old_state->base;
 
 	dup_base = amdgpu_dm_plane_drm_plane_duplicate_state(plane);
-- 
2.43.0

