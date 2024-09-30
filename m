Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D492CE834D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F2710E51A;
	Mon, 30 Sep 2024 14:32:54 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7642110E524
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWF052682332; Mon, 30 Sep 2024 20:02:15 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWFmp2682331;
 Mon, 30 Sep 2024 20:02:15 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: update the handle ptr in prepare_suspend
Date: Mon, 30 Sep 2024 20:00:10 +0530
Message-Id: <20240930143019.2682202-4-sunil.khatri@amd.com>
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
functions pointers of prepare_suspend.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      | 4 ++--
 drivers/gpu/drm/amd/include/amd_shared.h   | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9eb07bdbdea8..98083efd35e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4745,7 +4745,7 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		if (!adev->ip_blocks[i].version->funcs->prepare_suspend)
 			continue;
-		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
+		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
 		if (r)
 			goto unprepare;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index f5804cdfca45..c33b86f24a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -704,9 +704,9 @@ static int uvd_v3_1_hw_fini(void *handle)
 	return 0;
 }
 
-static int uvd_v3_1_prepare_suspend(void *handle)
+static int uvd_v3_1_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return amdgpu_uvd_prepare_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 522aec5f8e26..de9e6222d495 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -218,9 +218,9 @@ static int uvd_v4_2_hw_fini(void *handle)
 	return 0;
 }
 
-static int uvd_v4_2_prepare_suspend(void *handle)
+static int uvd_v4_2_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return amdgpu_uvd_prepare_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 407014149eaf..f9bdbd148383 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -216,9 +216,9 @@ static int uvd_v5_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int uvd_v5_0_prepare_suspend(void *handle)
+static int uvd_v5_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return amdgpu_uvd_prepare_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 68601bb4ce44..642b8db993b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -540,9 +540,9 @@ static int uvd_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int uvd_v6_0_prepare_suspend(void *handle)
+static int uvd_v6_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return amdgpu_uvd_prepare_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 93d37cfdd805..aef7ca1435f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -608,9 +608,9 @@ static int uvd_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
-static int uvd_v7_0_prepare_suspend(void *handle)
+static int uvd_v7_0_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block->adev;
 
 	return amdgpu_uvd_prepare_suspend(adev);
 }
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 615f880d3e80..1939c0dcdd1d 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -387,7 +387,7 @@ struct amd_ip_funcs {
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(struct amdgpu_ip_block *ip_block);
-	int (*prepare_suspend)(void *handle);
+	int (*prepare_suspend)(struct amdgpu_ip_block *ip_block);
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
-- 
2.34.1

