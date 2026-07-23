Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE51C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6327610F1DE;
	Thu, 23 Jul 2026 20:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AfkNLEE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 936A810F1D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejr1TCGujWBNXrWdnJvFb3uAhAR5xTLEIjWDvX651Z/Dx5bFPxTbkvLXLmNiObHXQdGRwwC+Vn5z48SHLWqo3QfK7yzNMI17/s3D8/xfjyw5ZSymbDuGxipVIpKBz0XiYzZ5JELNqTL4BWYMD6q+qZJANzslspCvRzY4C0XQBvhALOhZO1tD6frmSg9pvNUbVIYI/jqgRV1OiHkzq9gThHc7x5EdllaruHAp/4igA3IBHofZVmOifQJvXYrtIpazI1p76tZfFRj33LOxujbAKZBgjX3ZXFI9DFpLxcWwvh/0YNQWoOF1vYlV0esbKohwPJjW0TlWZ6gf8O8+nFNNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2mA6Qt/WaMAOFzyHx9EDVtDzwl7UlB2A2Oui/7j6RA=;
 b=ADiebNgSoriR5MNwLme4r6PO1z0bCSEi/k2lDSuhCJtsPGYfAzrVUUkhc3xUY4JRdQYC1v9r9TCnrShW2txX5jdl5hJ6FgXnFNlUXhXeKEJY5zC1Gzy9TcC2JlQ3BcfkAyNUgpJBNHgKAKAzsaChITprbh5FRnkar/ui2fcNgnwQN8w8IPK8IZH1HIlI5cO+YNHp0kOn4kthebISNnMhX7fpvrerJIYq7ps/BKzCp3qAjofVG1dW9Rr25csJdldebpl2qW4n4h8Vz6dDKkdzmj/oBWaBcCmHQwPKTnJoWJGAQQ/HkTWbs+puDF2rFIKBJFZ4BK4gM81b75nEwHESZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2mA6Qt/WaMAOFzyHx9EDVtDzwl7UlB2A2Oui/7j6RA=;
 b=5AfkNLEEU4x5Dhqp4V6LnZLPMSPUMzVt+MFy6xLZMM5+Hnj1WcWPDZ2t9GyesBTF89Se5hxZjhv69G+uWo9x+CEdPUb7k5zKRtFGzSzYEdCq6wXN93pXK9e5mql81LydBKe3uQSUQEiS6WzsW9HT+qPFq4Yl3XI42tdRNrDUJCo=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:11 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::30) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
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
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:10 +0000
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
Subject: [PATCH 17/49] drm/amd/display: add cursor module
Date: Thu, 23 Jul 2026 16:13:25 -0400
Message-ID: <20260723201908.373300-18-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fd1ccb-9e91-499f-8dea-08dee8f7a7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18092099006|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: AVDHWc5kPOUsZlVoRGt50EjEtCLm7JmLNPUzg/uE0yidrnW+EGgXLasfxvY2O+qEXrLZBcqvZOXe98TFHLqZ2OouHHXuUo4r2xdyi7ei81dYYkqlRDdYmRkIawublg/LekuSxUlhfdRnpyuo3HP0cLbSb926O53iZC5WzUKd0cLizOkDPa7l8dMYhg13h73BK0tVEYP3TT6CYfFDYOJpzhaKWdeB0Ofm00tacvMZHirI5+mWmnCGAAGp1xlQAv3ojATnJ/9x/1to+ryfAbnKrkqFMGg5vbP/kNav9lis2zfbH3Cgyacifo9Wgr4C7/P59DN7fGxlkizDbhQ4KWt4tGzFREAY2oBH81W6+MH9j9oS6QDhucEgYB/PMWqBQHFME2WDR6O21tRj1XMrRiDGEJO6iCbpxFo5frO2kKYl3/YM5uXPoS0tHBlp6oSoBtXN9YTrH9wMPq7VZatGXn8mSEmJBmRfV4b64uCoG6Z0aieRZN0DwXuHVXbXHrUTXVbvmdtmGeSYt1wwnhIQ+PHFzbd5hYfhycYponBoG/f21dAmefZEVfvW0DI2gSaENtIZ/ebcY8nwR36mqKucg33P28QRaIFC4W4oGCF2XzXJ606QLJ9Nr+wyOXGFX3jw7cIZQYVjEQIN8MVn8aU6LdsHo6mEIydx07y650wxvYJm6fcc7Rg31Gld012hVhmle3ASdL6V8q0SY8j/CqgnvpnxGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18092099006)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZDCn1t2fZnfCkU0PbgtqPA7XwkdiXUv0I/lloK0AnZnRBXu6FmOFxa169U3msph/4hIjUonvGN/Eo+AD5ZNE0gdd5VDK5mG6GmqK7j4I0piemGWz+uZ9AprIXFtgW62OJLsqqrQxzOf7JvvCBXZbzhY68IgFSvoP7nXwY7OTCBwJiONIy23aBcQHPL9awscTzM8inycFttbLS54OVVxlhWVcKjoUzB7fzrtdHyTJGSiv6GEn66CFnW+gK406wpk4t0WGAeoPaxbgqzfd8FVwA5jzqEpsc5E+M2EaYtjGBDHnHeNI+x79FeP1+T2X5kEk2bY1ZzJ0sc8KqOjBj8QTgBzO+Evs3W/aPC+eSHNmEN0kuq3FGzKutGkS07nbzAMuJryG5xSe9U+gzg6zux7Weg1kNJDLBhTRWlKUUu3MoncT8UuzvpRA5SmXj9wjpFfS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:10.5453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd1ccb-9e91-499f-8dea-08dee8f7a7f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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
Group the cursor policy and validation helpers from amdgpu_dm.c
into a dedicated amdgpu_dm_cursor.c and amdgpu_dm_cursor.h.
The moved functions are:

  dm_check_cursor_fb, dm_check_native_cursor_state,
  dm_should_update_native_cursor, dm_get_oriented_plane_size,
  dm_get_plane_scale, dm_plane_color_pipeline_active,
  dm_crtc_get_cursor_mode.

The cursor helpers exposed by amdgpu_dm_cursor.h are called from
amdgpu_dm.c, so give the three that lacked a namespace prefix the
standard amdgpu_dm_ prefix: amdgpu_dm_check_native_cursor_state,
amdgpu_dm_should_update_native_cursor and
amdgpu_dm_crtc_get_cursor_mode.

The descending-zpos plane iterator shared by these functions and
amdgpu_dm_atomic_check (the for_each_oldnew_plane_in_descending_zpos
macro and its __get_next_zpos helper) moves to amdgpu_dm.h, with
the helper renamed amdgpu_dm_get_next_zpos and made non-static.

Relocate the corresponding KUnit tests into amdgpu_dm_cursor_test.c.

No functional change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 436 +----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  24 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 443 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |  52 ++
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 268 +++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 232 ---------
 8 files changed, 796 insertions(+), 663 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 5cb8c143e72f..d1faf2d8370f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -46,7 +46,8 @@ AMDGPUDM = \
 	amdgpu_dm_audio.o \
 	amdgpu_dm_dmub.o \
 	amdgpu_dm_connector.o \
-	amdgpu_dm_freesync.o
+	amdgpu_dm_freesync.o \
+	amdgpu_dm_cursor.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c36eb8a1d2d1..217ec822e93e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -72,6 +72,7 @@
 #include "amdgpu_dm_connector.h"
 #include "amdgpu_dm_pp_smu.h"
 #include "amdgpu_dm_freesync.h"
+#include "amdgpu_dm_cursor.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -5760,133 +5761,6 @@ static bool should_reset_plane(struct drm_atomic_commit *state,
 	return false;
 }
 
-static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
-			      struct drm_plane_state *new_plane_state,
-			      struct drm_framebuffer *fb)
-{
-	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
-	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
-	unsigned int pitch;
-	bool linear;
-
-	if (fb->width > new_acrtc->max_cursor_width ||
-	    fb->height > new_acrtc->max_cursor_height) {
-		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size %dx%d\n",
-				 new_plane_state->fb->width,
-				 new_plane_state->fb->height);
-		return -EINVAL;
-	}
-	if (new_plane_state->src_w != fb->width << 16 ||
-	    new_plane_state->src_h != fb->height << 16) {
-		drm_dbg_atomic(adev_to_drm(adev), "Cropping not supported for cursor plane\n");
-		return -EINVAL;
-	}
-
-	/* Pitch in pixels */
-	pitch = fb->pitches[0] / fb->format->cpp[0];
-
-	if (fb->width != pitch) {
-		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d doesn't match pitch %d",
-				 fb->width, pitch);
-		return -EINVAL;
-	}
-
-	switch (pitch) {
-	case 64:
-	case 128:
-	case 256:
-		/* FB pitch is supported by cursor plane */
-		break;
-	default:
-		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch %d px\n", pitch);
-		return -EINVAL;
-	}
-
-	/* Core DRM takes care of checking FB modifiers, so we only need to
-	 * check tiling flags when the FB doesn't have a modifier.
-	 */
-	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
-		} else if (adev->family >= AMDGPU_FAMILY_AI) {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
-		} else {
-			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
-				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
-		}
-		if (!linear) {
-			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * Helper function for checking the cursor in native mode
- */
-static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
-					struct drm_plane *plane,
-					struct drm_plane_state *new_plane_state,
-					bool enable)
-{
-
-	struct amdgpu_crtc *new_acrtc;
-	int ret;
-
-	if (!enable || !new_plane_crtc ||
-	    drm_atomic_plane_disabling(plane->state, new_plane_state))
-		return 0;
-
-	new_acrtc = to_amdgpu_crtc(new_plane_crtc);
-
-	if (new_plane_state->src_x != 0 || new_plane_state->src_y != 0) {
-		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not supported for cursor plane\n");
-		return -EINVAL;
-	}
-
-	if (new_plane_state->fb) {
-		ret = dm_check_cursor_fb(new_acrtc, new_plane_state,
-						new_plane_state->fb);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-STATIC_IFN_KUNIT bool dm_should_update_native_cursor(struct drm_atomic_commit *state,
-						     struct drm_crtc *old_plane_crtc,
-						     struct drm_crtc *new_plane_crtc,
-						     bool enable)
-{
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
-
-	if (!enable) {
-		if (old_plane_crtc == NULL)
-			return true;
-
-		old_crtc_state = drm_atomic_get_old_crtc_state(
-			state, old_plane_crtc);
-		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
-
-		return dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
-	} else {
-		if (new_plane_crtc == NULL)
-			return true;
-
-		new_crtc_state = drm_atomic_get_new_crtc_state(
-			state, new_plane_crtc);
-		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-
-		return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
-	}
-}
-EXPORT_IF_KUNIT(dm_should_update_native_cursor);
-
 static int dm_update_plane_state(struct dc *dc,
 				 struct drm_atomic_commit *state,
 				 struct drm_plane *plane,
@@ -5911,14 +5785,14 @@ static int dm_update_plane_state(struct dc *dc,
 	dm_new_plane_state = to_dm_plane_state(new_plane_state);
 	dm_old_plane_state = to_dm_plane_state(old_plane_state);
 
-	update_native_cursor = dm_should_update_native_cursor(state,
-							      old_plane_crtc,
-							      new_plane_crtc,
-							      enable);
+	update_native_cursor = amdgpu_dm_should_update_native_cursor(state,
+								     old_plane_crtc,
+								     new_plane_crtc,
+								     enable);
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR && update_native_cursor) {
-		ret = dm_check_native_cursor_state(new_plane_crtc, plane,
-						    new_plane_state, enable);
+		ret = amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
+							  new_plane_state, enable);
 		if (ret)
 			return ret;
 
@@ -6048,8 +5922,8 @@ static int dm_update_plane_state(struct dc *dc,
 out:
 	/* If enabling cursor overlay failed, attempt fallback to native mode */
 	if (enable && ret == -EINVAL && plane->type == DRM_PLANE_TYPE_CURSOR) {
-		ret = dm_check_native_cursor_state(new_plane_crtc, plane,
-						    new_plane_state, enable);
+		ret = amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
+							  new_plane_state, enable);
 		if (ret)
 			return ret;
 
@@ -6059,37 +5933,6 @@ static int dm_update_plane_state(struct dc *dc,
 	return ret;
 }
 
-STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
-					 int *src_w, int *src_h)
-{
-	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
-	case DRM_MODE_ROTATE_90:
-	case DRM_MODE_ROTATE_270:
-		*src_w = plane_state->src_h >> 16;
-		*src_h = plane_state->src_w >> 16;
-		break;
-	case DRM_MODE_ROTATE_0:
-	case DRM_MODE_ROTATE_180:
-	default:
-		*src_w = plane_state->src_w >> 16;
-		*src_h = plane_state->src_h >> 16;
-		break;
-	}
-}
-EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
-
-STATIC_IFN_KUNIT void
-dm_get_plane_scale(struct drm_plane_state *plane_state,
-		   int *out_plane_scale_w, int *out_plane_scale_h)
-{
-	int plane_src_w, plane_src_h;
-
-	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
-	*out_plane_scale_w = plane_src_w ? plane_state->crtc_w * 1000 / plane_src_w : 0;
-	*out_plane_scale_h = plane_src_h ? plane_state->crtc_h * 1000 / plane_src_h : 0;
-}
-EXPORT_IF_KUNIT(dm_get_plane_scale);
-
 /*
  * The normalized_zpos value cannot be used by this iterator directly. It's only
  * calculated for enabled planes, potentially causing normalized_zpos collisions
@@ -6097,7 +5940,7 @@ EXPORT_IF_KUNIT(dm_get_plane_scale);
  * so that the iterator will not generate the same object twice, or loop
  * indefinitely.
  */
-static inline struct __drm_planes_state *__get_next_zpos(
+struct __drm_planes_state *amdgpu_dm_get_next_zpos(
 	struct drm_atomic_commit *state,
 	struct __drm_planes_state *prev)
 {
@@ -6135,19 +5978,6 @@ static inline struct __drm_planes_state *__get_next_zpos(
 	return &state->planes[highest_i];
 }
 
-/*
- * Use the uniqueness of the plane's (zpos, drm obj ID) combination to iterate
- * by descending zpos, as read from the new plane state. This is the same
- * ordering as defined by drm_atomic_normalize_zpos().
- */
-#define for_each_oldnew_plane_in_descending_zpos(__state, plane, old_plane_state, new_plane_state) \
-	for (struct __drm_planes_state *__i = __get_next_zpos((__state), NULL); \
-	     __i != NULL; __i = __get_next_zpos((__state), __i))		\
-		for_each_if(((plane) = __i->ptr,				\
-			     (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
-			     (old_plane_state) = __i->old_state,		\
-			     (new_plane_state) = __i->new_state, 1))
-
 static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
@@ -6178,244 +6008,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct dr
 	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->mst_mgr);
 }
 
-/**
- * DOC: Cursor Modes - Native vs Overlay
- *
- * In native mode, the cursor uses a integrated cursor pipe within each DCN hw
- * plane. It does not require a dedicated hw plane to enable, but it is
- * subjected to the same z-order and scaling as the hw plane. It also has format
- * restrictions, a RGB cursor in native mode cannot be enabled within a non-RGB
- * hw plane.
- *
- * In overlay mode, the cursor uses a separate DCN hw plane, and thus has its
- * own scaling and z-pos. It also has no blending restrictions. It lends to a
- * cursor behavior more akin to a DRM client's expectations. However, it does
- * occupy an extra DCN plane, and therefore will only be used if a DCN plane is
- * available.
- */
-
-/**
- * dm_plane_color_pipeline_active() - Check if a plane's color pipeline active.
- * @state: DRM atomic state
- * @plane: DRM plane to check
- * @use_old: if true, inspect the old colorop states; otherwise the new ones
- *
- * A color pipeline may be selected (color_pipeline != NULL) but still is
- * inactive if every colorop in the chain is bypassed.  Only return
- * true when at least one colorop has bypass == false, meaning the cursor
- * would be subjected to the transformation in native mode.
- *
- * Return: true if the pipeline modifies pixels, false otherwise.
- */
-static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
-					   struct drm_plane *plane,
-					   bool use_old)
-{
-	struct drm_colorop *colorop;
-	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
-	int i;
-
-	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
-		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
-
-		if (cstate->colorop->plane != plane)
-			continue;
-		if (!cstate->bypass)
-			return true;
-	}
-	return false;
-}
-
-/**
- * dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
- * @adev: amdgpu device
- * @state: DRM atomic state
- * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
- * @cursor_mode: Returns the required cursor mode on dm_crtc_state
- *
- * Get whether the cursor should be enabled in native mode, or overlay mode, on
- * the dm_crtc_state.
- *
- * The cursor should be enabled in overlay mode if there exists an underlying
- * plane - on which the cursor may be blended - that is either YUV formatted,
- * scaled differently from the cursor, or has a color pipeline active.
- *
- * Since zpos info is required, drm_atomic_normalize_zpos must be called before
- * calling this function.
- *
- * Return: 0 on success, or an error code if getting the cursor plane state
- * failed.
- */
-static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
-				   struct drm_atomic_commit *state,
-				   struct dm_crtc_state *dm_crtc_state,
-				   enum amdgpu_dm_cursor_mode *cursor_mode)
-{
-	struct drm_plane_state *old_plane_state, *plane_state, *cursor_state;
-	struct drm_crtc_state *crtc_state = &dm_crtc_state->base;
-	struct drm_plane *plane;
-	bool consider_mode_change = false;
-	bool entire_crtc_covered = false;
-	bool cursor_changed = false;
-	int underlying_scale_w, underlying_scale_h;
-	int cursor_scale_w, cursor_scale_h;
-	int i;
-
-	/* Overlay cursor not supported on HW before DCN
-	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401/420
-	 *
-	 * Always set native cursor mode when the CRTC is disabled,
-	 * to make sure it doesn't cause atomic commits to fail when
-	 * they are trying to disable the CRTC.
-	 */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-	    !dm_crtc_state->base.enable) {
-		*cursor_mode = DM_CURSOR_NATIVE_MODE;
-		return 0;
-	}
-
-	/* Init cursor_mode to be the same as current */
-	*cursor_mode = dm_crtc_state->cursor_mode;
-
-	/*
-	 * Cursor mode can change if a plane's format changes, scale changes, is
-	 * enabled/disabled, z-order changes, or color management properties change.
-	 */
-	for_each_oldnew_plane_in_state(state, plane, old_plane_state, plane_state, i) {
-		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
-
-		/* Only care about planes on this CRTC */
-		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0)
-			continue;
-
-		if (plane->type == DRM_PLANE_TYPE_CURSOR)
-			cursor_changed = true;
-
-		if (drm_atomic_plane_enabling(old_plane_state, plane_state) ||
-		    drm_atomic_plane_disabling(old_plane_state, plane_state) ||
-		    old_plane_state->fb->format != plane_state->fb->format) {
-			consider_mode_change = true;
-			break;
-		}
-
-		dm_get_plane_scale(plane_state, &new_scale_w, &new_scale_h);
-		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
-		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
-			consider_mode_change = true;
-			break;
-		}
-
-		/*
-		 * A non-cursor plane moving or resizing (without a scale change)
-		 * changes how much of the CRTC it covers. This can create or
-		 * remove a hole under the cursor and thus flip the required
-		 * cursor mode (native vs overlay), so its destination rect must
-		 * be re-evaluated too.
-		 *
-		 * The cursor plane itself is deliberately excluded: the cursor
-		 * mode depends on the underlying planes' coverage, not on the
-		 * cursor's position (see the entire_crtc_covered logic below).
-		 * Triggering on cursor movement would force every legacy cursor
-		 * update off its fast path, and in a cursor-only commit - where
-		 * the underlying planes are not part of the state - the coverage
-		 * loop would see no covering plane and misevaluate the mode as
-		 * overlay, regressing flip-vs-cursor-legacy.
-		 */
-		if (plane->type != DRM_PLANE_TYPE_CURSOR &&
-		    (old_plane_state->crtc_x != plane_state->crtc_x ||
-		     old_plane_state->crtc_y != plane_state->crtc_y ||
-		     old_plane_state->crtc_w != plane_state->crtc_w ||
-		     old_plane_state->crtc_h != plane_state->crtc_h)) {
-			consider_mode_change = true;
-			break;
-		}
-
-		if (dm_plane_color_pipeline_active(state, plane, true) !=
-		    dm_plane_color_pipeline_active(state, plane, false)) {
-			consider_mode_change = true;
-			break;
-		}
-	}
-
-	if (!consider_mode_change && !crtc_state->zpos_changed)
-		return 0;
-
-	/*
-	 * If no cursor change on this CRTC, and not enabled on this CRTC, then
-	 * no need to set cursor mode. This avoids needlessly locking the cursor
-	 * state.
-	 */
-	if (!cursor_changed &&
-	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state->plane_mask)) {
-		return 0;
-	}
-
-	cursor_state = drm_atomic_get_plane_state(state,
-						  crtc_state->crtc->cursor);
-	if (IS_ERR(cursor_state))
-		return PTR_ERR(cursor_state);
-
-	/* Cursor is disabled */
-	if (!cursor_state->fb)
-		return 0;
-
-	/* For all planes in descending z-order (all of which are below cursor
-	 * as per zpos definitions), check their scaling and format
-	 */
-	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, plane_state) {
-
-		/* Only care about non-cursor planes on this CRTC */
-		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0 ||
-		    plane->type == DRM_PLANE_TYPE_CURSOR)
-			continue;
-
-		/* Underlying plane is YUV format - use overlay cursor */
-		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
-			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
-			return 0;
-		}
-
-		/* Underlying plane has an active color pipeline - cursor would be transformed */
-		if (dm_plane_color_pipeline_active(state, plane, false)) {
-			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
-			return 0;
-		}
-
-		dm_get_plane_scale(plane_state,
-				   &underlying_scale_w, &underlying_scale_h);
-		dm_get_plane_scale(cursor_state,
-				   &cursor_scale_w, &cursor_scale_h);
-
-		/* Underlying plane has different scale - use overlay cursor */
-		if (cursor_scale_w != underlying_scale_w &&
-		    cursor_scale_h != underlying_scale_h) {
-			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
-			return 0;
-		}
-
-		/* If this plane covers the whole CRTC, no need to check planes underneath */
-		if (plane_state->crtc_x <= 0 && plane_state->crtc_y <= 0 &&
-		    plane_state->crtc_x + plane_state->crtc_w >= crtc_state->mode.hdisplay &&
-		    plane_state->crtc_y + plane_state->crtc_h >= crtc_state->mode.vdisplay) {
-			entire_crtc_covered = true;
-			break;
-		}
-	}
-
-	/* If planes do not cover the entire CRTC, use overlay mode to enable
-	 * cursor over holes
-	 */
-	if (entire_crtc_covered)
-		*cursor_mode = DM_CURSOR_NATIVE_MODE;
-	else
-		*cursor_mode = DM_CURSOR_OVERLAY_MODE;
-
-	return 0;
-}
-
 static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 					    struct drm_atomic_commit *state,
 					    struct drm_crtc_state *crtc_state)
@@ -6619,8 +6211,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
-		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
-					      &dm_new_crtc_state->cursor_mode);
+		ret = amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+						     &dm_new_crtc_state->cursor_mode);
 		if (ret) {
 			drm_dbg(dev, "Failed to determine cursor mode: %pe\n", ERR_PTR(ret));
 			goto fail;
@@ -6754,8 +6346,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 
 		/* If HW can only do native cursor, check restrictions again */
-		ret = dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
-					      &required_cursor_mode);
+		ret = amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_new_crtc_state,
+						     &required_cursor_mode);
 		if (ret) {
 			drm_dbg_driver(crtc->dev,
 				       "[CRTC:%d:%s] Checking cursor mode failed\n",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 1ef92a28e3e9..1ddf5bc88a03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1141,6 +1141,22 @@ void amdgpu_dm_emulated_link_detect(struct dc_link *link);
 void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 											   struct dc_sink *sink);
 
+struct __drm_planes_state *amdgpu_dm_get_next_zpos(struct drm_atomic_commit *state,
+						   struct __drm_planes_state *prev);
+
+/*
+ * Use the uniqueness of the plane's (zpos, drm obj ID) combination to iterate
+ * by descending zpos, as read from the new plane state. This is the same
+ * ordering as defined by drm_atomic_normalize_zpos().
+ */
+#define for_each_oldnew_plane_in_descending_zpos(__state, plane, old_plane_state, new_plane_state) \
+	for (struct __drm_planes_state *__i = amdgpu_dm_get_next_zpos((__state), NULL); \
+	     __i != NULL; __i = amdgpu_dm_get_next_zpos((__state), __i))		\
+		for_each_if(((plane) = __i->ptr,				\
+			     (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			     (old_plane_state) = __i->old_state,		\
+			     (new_plane_state) = __i->new_state, 1))
+
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 struct amdgpu_ip_block;
 bool dm_is_idle(struct amdgpu_ip_block *ip_block);
@@ -1157,19 +1173,11 @@ int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
-bool dm_should_update_native_cursor(struct drm_atomic_commit *state,
-				    struct drm_crtc *old_plane_crtc,
-				    struct drm_crtc *new_plane_crtc,
-				    bool enable);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
 				enum dc_color_space *color_space);
 bool modereset_required(struct drm_crtc_state *crtc_state);
-void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
-				int *src_w, int *src_h);
-void dm_get_plane_scale(struct drm_plane_state *plane_state,
-			int *out_plane_scale_w, int *out_plane_scale_h);
 bool is_scaling_state_different(const struct dm_connector_state *dm_state,
 				const struct dm_connector_state *old_dm_state);
 void set_multisync_trigger_params(struct dc_stream_state *stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
new file mode 100644
index 000000000000..ab50d58896ab
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -0,0 +1,443 @@
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
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_colorop.h>
+
+#include "dc.h"
+#include "dal_asic_id.h"
+#include "amdgpu.h"
+#include "amdgpu_display.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_cursor.h"
+#include "dm_helpers.h"
+
+static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
+			      struct drm_plane_state *new_plane_state,
+			      struct drm_framebuffer *fb)
+{
+	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
+	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
+	unsigned int pitch;
+	bool linear;
+
+	if (fb->width > new_acrtc->max_cursor_width ||
+	    fb->height > new_acrtc->max_cursor_height) {
+		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size %dx%d\n",
+				 new_plane_state->fb->width,
+				 new_plane_state->fb->height);
+		return -EINVAL;
+	}
+	if (new_plane_state->src_w != fb->width << 16 ||
+	    new_plane_state->src_h != fb->height << 16) {
+		drm_dbg_atomic(adev_to_drm(adev), "Cropping not supported for cursor plane\n");
+		return -EINVAL;
+	}
+
+	/* Pitch in pixels */
+	pitch = fb->pitches[0] / fb->format->cpp[0];
+
+	if (fb->width != pitch) {
+		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d doesn't match pitch %d",
+				 fb->width, pitch);
+		return -EINVAL;
+	}
+
+	switch (pitch) {
+	case 64:
+	case 128:
+	case 256:
+		/* FB pitch is supported by cursor plane */
+		break;
+	default:
+		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch %d px\n", pitch);
+		return -EINVAL;
+	}
+
+	/* Core DRM takes care of checking FB modifiers, so we only need to
+	 * check tiling flags when the FB doesn't have a modifier.
+	 */
+	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
+#if defined(CONFIG_DRM_AMD_DC_DCN6_0) || defined(CONFIG_DRM_AMD_DC_DCN5_0)
+		if (adev->family == AMDGPU_FAMILY_GC_12_0_0
+		    || adev->family == AMDGPU_FAMILY_GC_13_0_1) {
+#else
+		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
+#endif
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
+		} else if (adev->family >= AMDGPU_FAMILY_AI) {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
+		} else {
+			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
+				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
+		}
+		if (!linear) {
+			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Helper function for checking the cursor in native mode
+ */
+int amdgpu_dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
+					struct drm_plane *plane,
+					struct drm_plane_state *new_plane_state,
+					bool enable)
+{
+
+	struct amdgpu_crtc *new_acrtc;
+	int ret;
+
+	if (!enable || !new_plane_crtc ||
+	    drm_atomic_plane_disabling(plane->state, new_plane_state))
+		return 0;
+
+	new_acrtc = to_amdgpu_crtc(new_plane_crtc);
+
+	if (new_plane_state->src_x != 0 || new_plane_state->src_y != 0) {
+		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not supported for cursor plane\n");
+		return -EINVAL;
+	}
+
+	if (new_plane_state->fb) {
+		ret = dm_check_cursor_fb(new_acrtc, new_plane_state,
+						new_plane_state->fb);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
+					   struct drm_crtc *old_plane_crtc,
+					   struct drm_crtc *new_plane_crtc,
+					   bool enable)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+
+	if (!enable) {
+		if (old_plane_crtc == NULL)
+			return true;
+
+		old_crtc_state = drm_atomic_get_old_crtc_state(
+			state, old_plane_crtc);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		return dm_old_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
+	}
+
+	if (new_plane_crtc == NULL)
+		return true;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(
+		state, new_plane_crtc);
+	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+	return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
+
+STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+					 int *src_w, int *src_h)
+{
+	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
+	case DRM_MODE_ROTATE_90:
+	case DRM_MODE_ROTATE_270:
+		*src_w = plane_state->src_h >> 16;
+		*src_h = plane_state->src_w >> 16;
+		break;
+	case DRM_MODE_ROTATE_0:
+	case DRM_MODE_ROTATE_180:
+	default:
+		*src_w = plane_state->src_w >> 16;
+		*src_h = plane_state->src_h >> 16;
+		break;
+	}
+}
+EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
+
+STATIC_IFN_KUNIT void
+dm_get_plane_scale(struct drm_plane_state *plane_state,
+		   int *out_plane_scale_w, int *out_plane_scale_h)
+{
+	int plane_src_w, plane_src_h;
+
+	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
+	*out_plane_scale_w = plane_src_w ? plane_state->crtc_w * 1000 / plane_src_w : 0;
+	*out_plane_scale_h = plane_src_h ? plane_state->crtc_h * 1000 / plane_src_h : 0;
+}
+EXPORT_IF_KUNIT(dm_get_plane_scale);
+
+/**
+ * DOC: Cursor Modes - Native vs Overlay
+ *
+ * In native mode, the cursor uses a integrated cursor pipe within each DCN hw
+ * plane. It does not require a dedicated hw plane to enable, but it is
+ * subjected to the same z-order and scaling as the hw plane. It also has format
+ * restrictions, a RGB cursor in native mode cannot be enabled within a non-RGB
+ * hw plane.
+ *
+ * In overlay mode, the cursor uses a separate DCN hw plane, and thus has its
+ * own scaling and z-pos. It also has no blending restrictions. It lends to a
+ * cursor behavior more akin to a DRM client's expectations. However, it does
+ * occupy an extra DCN plane, and therefore will only be used if a DCN plane is
+ * available.
+ */
+
+/**
+ * dm_plane_color_pipeline_active() - Check if a plane's color pipeline active.
+ * @state: DRM atomic state
+ * @plane: DRM plane to check
+ * @use_old: if true, inspect the old colorop states; otherwise the new ones
+ *
+ * A color pipeline may be selected (color_pipeline != NULL) but still is
+ * inactive if every colorop in the chain is bypassed.  Only return
+ * true when at least one colorop has bypass == false, meaning the cursor
+ * would be subjected to the transformation in native mode.
+ *
+ * Return: true if the pipeline modifies pixels, false otherwise.
+ */
+static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
+					   struct drm_plane *plane,
+					   bool use_old)
+{
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
+	int i;
+
+	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
+		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
+
+		if (cstate->colorop->plane != plane)
+			continue;
+		if (!cstate->bypass)
+			return true;
+	}
+	return false;
+}
+
+/**
+ * amdgpu_dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
+ * @adev: amdgpu device
+ * @state: DRM atomic state
+ * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
+ * @cursor_mode: Returns the required cursor mode on dm_crtc_state
+ *
+ * Get whether the cursor should be enabled in native mode, or overlay mode, on
+ * the dm_crtc_state.
+ *
+ * The cursor should be enabled in overlay mode if there exists an underlying
+ * plane - on which the cursor may be blended - that is either YUV formatted,
+ * scaled differently from the cursor, or has a color pipeline active.
+ *
+ * Since zpos info is required, drm_atomic_normalize_zpos must be called before
+ * calling this function.
+ *
+ * Return: 0 on success, or an error code if getting the cursor plane state
+ * failed.
+ */
+int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
+				   struct drm_atomic_commit *state,
+				   struct dm_crtc_state *dm_crtc_state,
+				   enum amdgpu_dm_cursor_mode *cursor_mode)
+{
+	struct drm_plane_state *old_plane_state, *plane_state, *cursor_state;
+	struct drm_crtc_state *crtc_state = &dm_crtc_state->base;
+	struct drm_plane *plane;
+	bool consider_mode_change = false;
+	bool entire_crtc_covered = false;
+	bool cursor_changed = false;
+	int underlying_scale_w, underlying_scale_h;
+	int cursor_scale_w, cursor_scale_h;
+	int i;
+
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401/420
+	 */
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
+#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
+#else
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
+#endif
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+		return 0;
+	}
+
+	/* Init cursor_mode to be the same as current */
+	*cursor_mode = dm_crtc_state->cursor_mode;
+
+	/*
+	 * Cursor mode can change if a plane's format changes, scale changes, is
+	 * enabled/disabled, z-order changes, or color management properties change.
+	 */
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, plane_state, i) {
+		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
+
+		/* Only care about planes on this CRTC */
+		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0)
+			continue;
+
+		if (plane->type == DRM_PLANE_TYPE_CURSOR)
+			cursor_changed = true;
+
+		if (drm_atomic_plane_enabling(old_plane_state, plane_state) ||
+		    drm_atomic_plane_disabling(old_plane_state, plane_state) ||
+		    old_plane_state->fb->format != plane_state->fb->format) {
+			consider_mode_change = true;
+			break;
+		}
+
+		dm_get_plane_scale(plane_state, &new_scale_w, &new_scale_h);
+		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
+		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
+			consider_mode_change = true;
+			break;
+		}
+
+		/*
+		 * A non-cursor plane moving or resizing (without a scale change)
+		 * changes how much of the CRTC it covers. This can create or
+		 * remove a hole under the cursor and thus flip the required
+		 * cursor mode (native vs overlay), so its destination rect must
+		 * be re-evaluated too.
+		 *
+		 * The cursor plane itself is deliberately excluded: the cursor
+		 * mode depends on the underlying planes' coverage, not on the
+		 * cursor's position (see the entire_crtc_covered logic below).
+		 * Triggering on cursor movement would force every legacy cursor
+		 * update off its fast path, and in a cursor-only commit - where
+		 * the underlying planes are not part of the state - the coverage
+		 * loop would see no covering plane and misevaluate the mode as
+		 * overlay, regressing flip-vs-cursor-legacy.
+		 */
+		if (plane->type != DRM_PLANE_TYPE_CURSOR &&
+		    (old_plane_state->crtc_x != plane_state->crtc_x ||
+		     old_plane_state->crtc_y != plane_state->crtc_y ||
+		     old_plane_state->crtc_w != plane_state->crtc_w ||
+		     old_plane_state->crtc_h != plane_state->crtc_h)) {
+			consider_mode_change = true;
+			break;
+		}
+
+		if (dm_plane_color_pipeline_active(state, plane, true) !=
+		    dm_plane_color_pipeline_active(state, plane, false)) {
+			consider_mode_change = true;
+			break;
+		}
+	}
+
+	if (!consider_mode_change && !crtc_state->zpos_changed)
+		return 0;
+
+	/*
+	 * If no cursor change on this CRTC, and not enabled on this CRTC, then
+	 * no need to set cursor mode. This avoids needlessly locking the cursor
+	 * state.
+	 */
+	if (!cursor_changed &&
+	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state->plane_mask)) {
+		return 0;
+	}
+
+	cursor_state = drm_atomic_get_plane_state(state,
+						  crtc_state->crtc->cursor);
+	if (IS_ERR(cursor_state))
+		return PTR_ERR(cursor_state);
+
+	/* Cursor is disabled */
+	if (!cursor_state->fb)
+		return 0;
+
+	/* For all planes in descending z-order (all of which are below cursor
+	 * as per zpos definitions), check their scaling and format
+	 */
+	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, plane_state) {
+
+		/* Only care about non-cursor planes on this CRTC */
+		if ((drm_plane_mask(plane) & crtc_state->plane_mask) == 0 ||
+		    plane->type == DRM_PLANE_TYPE_CURSOR)
+			continue;
+
+		/* Underlying plane is YUV format - use overlay cursor */
+		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
+		/* Underlying plane has an active color pipeline - cursor would be transformed */
+		if (dm_plane_color_pipeline_active(state, plane, false)) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
+		dm_get_plane_scale(plane_state,
+				   &underlying_scale_w, &underlying_scale_h);
+		dm_get_plane_scale(cursor_state,
+				   &cursor_scale_w, &cursor_scale_h);
+
+		/* Underlying plane has different scale - use overlay cursor */
+		if (cursor_scale_w != underlying_scale_w &&
+		    cursor_scale_h != underlying_scale_h) {
+			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+			return 0;
+		}
+
+		/* If this plane covers the whole CRTC, no need to check planes underneath */
+		if (plane_state->crtc_x <= 0 && plane_state->crtc_y <= 0 &&
+		    plane_state->crtc_x + plane_state->crtc_w >= crtc_state->mode.hdisplay &&
+		    plane_state->crtc_y + plane_state->crtc_h >= crtc_state->mode.vdisplay) {
+			entire_crtc_covered = true;
+			break;
+		}
+	}
+
+	/* If planes do not cover the entire CRTC, use overlay mode to enable
+	 * cursor over holes
+	 */
+	if (entire_crtc_covered)
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+	else
+		*cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
new file mode 100644
index 000000000000..5f619e4474aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
@@ -0,0 +1,52 @@
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
+#ifndef __AMDGPU_DM_CURSOR_H__
+#define __AMDGPU_DM_CURSOR_H__
+
+int amdgpu_dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
+					struct drm_plane *plane,
+					struct drm_plane_state *new_plane_state,
+					bool enable);
+
+bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
+					   struct drm_crtc *old_plane_crtc,
+					   struct drm_crtc *new_plane_crtc,
+					   bool enable);
+
+int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
+				   struct drm_atomic_commit *state,
+				   struct dm_crtc_state *dm_crtc_state,
+				   enum amdgpu_dm_cursor_mode *cursor_mode);
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+				int *src_w, int *src_h);
+void dm_get_plane_scale(struct drm_plane_state *plane_state,
+			int *out_plane_scale_w, int *out_plane_scale_h);
+#endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */
+
+#endif /* __AMDGPU_DM_CURSOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index e58ffc4dcd84..3a51fccc2a5e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_freesync_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_cursor_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
new file mode 100644
index 000000000000..3da76794ece9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_cursor.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_blend.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_plane.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_cursor.h"
+
+/* Tests for amdgpu_dm_should_update_native_cursor() */
+
+/**
+ * dm_test_should_update_native_cursor_without_crtc - Test NULL crtc cases update native cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_without_crtc(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_update_native_cursor(NULL, NULL, NULL, false));
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_update_native_cursor(NULL, NULL, NULL, true));
+}
+
+/**
+ * dm_test_should_update_native_cursor_disable_native - Test disable path reads old crtc cursor mode
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_disable_native(struct kunit *test)
+{
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+
+	crtc->index = 0;
+	dm_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
+	state->crtcs[0].old_state = &dm_crtc_state->base;
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_should_update_native_cursor(state, crtc, NULL, false));
+}
+
+/**
+ * dm_test_should_update_native_cursor_enable_overlay - Test enable path reads new crtc cursor mode
+ * @test: The KUnit test context
+ */
+static void dm_test_should_update_native_cursor_enable_overlay(struct kunit *test)
+{
+	struct dm_crtc_state *dm_crtc_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+
+	crtc->index = 0;
+	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_should_update_native_cursor(state, NULL, crtc, true));
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
+static struct kunit_case amdgpu_dm_cursor_tests[] = {
+	/* amdgpu_dm_should_update_native_cursor */
+	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
+	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
+	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
+	/* dm_get_oriented_plane_size */
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_0),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_90),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_180),
+	KUNIT_CASE(dm_test_oriented_plane_size_rotate_270),
+	/* dm_get_plane_scale */
+	KUNIT_CASE(dm_test_get_plane_scale_identity),
+	KUNIT_CASE(dm_test_get_plane_scale_rotate_90_identity),
+	KUNIT_CASE(dm_test_get_plane_scale_zero_src_width),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_cursor_test_suite = {
+	.name = "amdgpu_dm_cursor",
+	.test_cases = amdgpu_dm_cursor_tests,
+};
+
+kunit_test_suite(amdgpu_dm_cursor_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_cursor");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 428d24259198..3c10eec9b1e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -227,76 +227,6 @@ static void dm_test_atomic_get_new_state_match(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, dm_atomic_get_new_state(state), dm_state);
 }
 
-/**
- * dm_test_should_update_native_cursor_without_crtc - Test NULL crtc cases update native cursor
- * @test: The KUnit test context
- */
-static void dm_test_should_update_native_cursor_without_crtc(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL, NULL, NULL, false));
-	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL, NULL, NULL, true));
-}
-
-/**
- * dm_test_should_update_native_cursor_disable_native - Test disable path reads old crtc cursor mode
- * @test: The KUnit test context
- */
-static void dm_test_should_update_native_cursor_disable_native(struct kunit *test)
-{
-	struct dm_crtc_state *dm_crtc_state;
-	struct drm_atomic_commit *state;
-	struct drm_crtc *crtc;
-
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-
-	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
-
-	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
-
-	crtc->index = 0;
-	dm_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
-	state->crtcs[0].old_state = &dm_crtc_state->base;
-
-	KUNIT_EXPECT_TRUE(test,
-			  dm_should_update_native_cursor(state, crtc, NULL, false));
-}
-
-/**
- * dm_test_should_update_native_cursor_enable_overlay - Test enable path reads new crtc cursor mode
- * @test: The KUnit test context
- */
-static void dm_test_should_update_native_cursor_enable_overlay(struct kunit *test)
-{
-	struct dm_crtc_state *dm_crtc_state;
-	struct drm_atomic_commit *state;
-	struct drm_crtc *crtc;
-
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-
-	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
-
-	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
-
-	crtc->index = 0;
-	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
-	state->crtcs[0].new_state = &dm_crtc_state->base;
-
-	KUNIT_EXPECT_FALSE(test,
-			   dm_should_update_native_cursor(state, NULL, crtc, true));
-}
-
 /**
  * dm_test_atomic_destroy_state_no_context - Test destroying DM atomic state without a DC context
  * @test: The KUnit test context
@@ -599,156 +529,6 @@ static void dm_test_modereset_not_required_when_inactive_without_modeset(struct
 	KUNIT_EXPECT_FALSE(test, modereset_required(&crtc_state));
 }
 
-/* Tests for dm_get_oriented_plane_size() */
-
-/**
- * dm_test_oriented_plane_size_rotate_0 - Test Oriented plane size rotate 0
- * @test: The KUnit test context
- */
-static void dm_test_oriented_plane_size_rotate_0(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int src_w = 0;
-	int src_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_0;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-
-	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
-
-	KUNIT_EXPECT_EQ(test, src_w, 1920);
-	KUNIT_EXPECT_EQ(test, src_h, 1080);
-}
-
-/**
- * dm_test_oriented_plane_size_rotate_90 - Test Oriented plane size rotate 90
- * @test: The KUnit test context
- */
-static void dm_test_oriented_plane_size_rotate_90(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int src_w = 0;
-	int src_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_90;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-
-	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
-
-	KUNIT_EXPECT_EQ(test, src_w, 1080);
-	KUNIT_EXPECT_EQ(test, src_h, 1920);
-}
-
-/**
- * dm_test_oriented_plane_size_rotate_180 - Test Oriented plane size rotate 180
- * @test: The KUnit test context
- */
-static void dm_test_oriented_plane_size_rotate_180(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int src_w = 0;
-	int src_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_180;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-
-	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
-
-	KUNIT_EXPECT_EQ(test, src_w, 1920);
-	KUNIT_EXPECT_EQ(test, src_h, 1080);
-}
-
-/**
- * dm_test_oriented_plane_size_rotate_270 - Test Oriented plane size rotate 270
- * @test: The KUnit test context
- */
-static void dm_test_oriented_plane_size_rotate_270(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int src_w = 0;
-	int src_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_270;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-
-	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
-
-	KUNIT_EXPECT_EQ(test, src_w, 1080);
-	KUNIT_EXPECT_EQ(test, src_h, 1920);
-}
-
-/* Tests for dm_get_plane_scale() */
-
-/**
- * dm_test_get_plane_scale_identity - Test Get plane scale identity
- * @test: The KUnit test context
- */
-static void dm_test_get_plane_scale_identity(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int scale_w = 0;
-	int scale_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_0;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-	plane_state.crtc_w = 1920;
-	plane_state.crtc_h = 1080;
-
-	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
-
-	KUNIT_EXPECT_EQ(test, scale_w, 1000);
-	KUNIT_EXPECT_EQ(test, scale_h, 1000);
-}
-
-/**
- * dm_test_get_plane_scale_rotate_90_identity - Test Get plane scale rotate 90 identity
- * @test: The KUnit test context
- */
-static void dm_test_get_plane_scale_rotate_90_identity(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int scale_w = 0;
-	int scale_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_90;
-	plane_state.src_w = 1920 << 16;
-	plane_state.src_h = 1080 << 16;
-	plane_state.crtc_w = 1080;
-	plane_state.crtc_h = 1920;
-
-	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
-
-	KUNIT_EXPECT_EQ(test, scale_w, 1000);
-	KUNIT_EXPECT_EQ(test, scale_h, 1000);
-}
-
-/**
- * dm_test_get_plane_scale_zero_src_width - Test Get plane scale zero src width
- * @test: The KUnit test context
- */
-static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
-{
-	struct drm_plane_state plane_state = { 0 };
-	int scale_w = 0;
-	int scale_h = 0;
-
-	plane_state.rotation = DRM_MODE_ROTATE_0;
-	plane_state.src_w = 0;
-	plane_state.src_h = 1080 << 16;
-	plane_state.crtc_w = 100;
-	plane_state.crtc_h = 200;
-
-	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
-
-	KUNIT_EXPECT_EQ(test, scale_w, 0);
-	KUNIT_EXPECT_EQ(test, scale_h, 185);
-}
-
 /* Tests for is_scaling_state_different() */
 
 /**
@@ -1386,9 +1166,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_crtc_get_scanoutpos_no_stream),
 	KUNIT_CASE(dm_test_atomic_get_new_state_empty),
 	KUNIT_CASE(dm_test_atomic_get_new_state_match),
-	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
-	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
-	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
 	KUNIT_CASE(dm_test_atomic_destroy_state_no_context),
 	/* dm_plane_layer_index_cmp */
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
@@ -1407,15 +1184,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_modereset_required_when_inactive_and_modeset),
 	KUNIT_CASE(dm_test_modereset_not_required_when_active_and_modeset),
 	KUNIT_CASE(dm_test_modereset_not_required_when_inactive_without_modeset),
-	/* dm_get_oriented_plane_size */
-	KUNIT_CASE(dm_test_oriented_plane_size_rotate_0),
-	KUNIT_CASE(dm_test_oriented_plane_size_rotate_90),
-	KUNIT_CASE(dm_test_oriented_plane_size_rotate_180),
-	KUNIT_CASE(dm_test_oriented_plane_size_rotate_270),
-	/* dm_get_plane_scale */
-	KUNIT_CASE(dm_test_get_plane_scale_identity),
-	KUNIT_CASE(dm_test_get_plane_scale_rotate_90_identity),
-	KUNIT_CASE(dm_test_get_plane_scale_zero_src_width),
 	/* is_scaling_state_different */
 	KUNIT_CASE(dm_test_scaling_state_same),
 	KUNIT_CASE(dm_test_scaling_state_scaling_changed),
-- 
2.53.0

