Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F258CE834C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D8710E514;
	Mon, 30 Sep 2024 14:32:21 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DC210E516
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWFLj2682327; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFWj2682326;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: update the handle ptr in late_fini
Date: Mon, 30 Sep 2024 20:00:09 +0530
Message-Id: <20240930143019.2682202-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930143019.2682202-1-sunil.khatri@amd.com>
References: <20240930143019.2682202-1-sunil.khatri@amd.com>
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
functions pointers of late_fini.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 2 +-
 drivers/gpu/drm/amd/include/amd_shared.h         | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 28c1bf6867ca..9eb07bdbdea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3392,7 +3392,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
 		if (adev->ip_blocks[i].version->funcs->late_fini)
-			adev->ip_blocks[i].version->funcs->late_fini((void *)adev);
+			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.late_initialized = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 980a6a740689..615f880d3e80 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -386,7 +386,7 @@ struct amd_ip_funcs {
 	int (*early_fini)(struct amdgpu_ip_block *ip_block);
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
-	void (*late_fini)(void *handle);
+	void (*late_fini)(struct amdgpu_ip_block *ip_block);
 	int (*prepare_suspend)(void *handle);
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 194cf4f922a3..5c109be6bcbd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -230,9 +230,9 @@ static int pp_late_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static void pp_late_fini(void *handle)
+static void pp_late_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.smu_prv_buffer)
 		amdgpu_bo_free_kernel(&adev->pm.smu_prv_buffer, NULL, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3a92eac86f4b..2f15a17a7500 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2042,9 +2042,9 @@ static int smu_hw_fini(void *handle)
 	return 0;
 }
 
-static void smu_late_fini(void *handle)
+static void smu_late_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = handle;
+	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
 	kfree(smu);
-- 
2.34.1

