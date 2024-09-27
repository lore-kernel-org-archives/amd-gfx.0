Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21FCCDD1B8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 15:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D97610ECBD;
	Fri, 27 Sep 2024 15:01:08 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9B110ECC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 15:01:06 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48RF11kF2232746; Fri, 27 Sep 2024 20:31:01 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48RF11Pd2232745;
 Fri, 27 Sep 2024 20:31:01 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu: update the handle ptr in early_fini
Date: Fri, 27 Sep 2024 20:30:59 +0530
Message-Id: <20240927150059.2232708-5-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927150059.2232708-1-sunil.khatri@amd.com>
References: <20240927150059.2232708-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the *handle to amdgpu_ip_block ptr for all
functions pointers of early_fini.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1c69776b98de..28c1bf6867ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3305,7 +3305,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		if (!adev->ip_blocks[i].version->funcs->early_fini)
 			continue;
 
-		r = adev->ip_blocks[i].version->funcs->early_fini((void *)adev);
+		r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
 		if (r) {
 			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3f44227b7d4b..bc694e214533 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2108,9 +2108,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	return -EINVAL;
 }
 
-static int amdgpu_dm_early_fini(void *handle)
+static int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	amdgpu_dm_audio_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4a10a804f130..980a6a740689 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -383,7 +383,7 @@ struct amd_ip_funcs {
 	int (*late_init)(struct amdgpu_ip_block *ip_block);
 	int (*sw_init)(struct amdgpu_ip_block *ip_block);
 	int (*sw_fini)(struct amdgpu_ip_block *ip_block);
-	int (*early_fini)(void *handle);
+	int (*early_fini)(struct amdgpu_ip_block *ip_block);
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(void *handle);
-- 
2.34.1

