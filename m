Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C50FC531DC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 13:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A9C10E209;
	Mon, 12 Aug 2024 13:05:28 +0000 (UTC)
X-Greylist: delayed 1066 seconds by postgrey-1.36 at gabe;
 Mon, 12 Aug 2024 12:54:54 UTC
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB6610E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 12:54:54 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjDRz0S16z20lZc;
 Mon, 12 Aug 2024 20:32:31 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
 by mail.maildlp.com (Postfix) with ESMTPS id DE72614035E;
 Mon, 12 Aug 2024 20:37:02 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Aug
 2024 20:37:02 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH] amd/gpu: drm/hisilicon: Remove unused declarations
Date: Mon, 12 Aug 2024 20:24:15 +0800
Message-ID: <20240812122415.39664-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)
X-Mailman-Approved-At: Mon, 12 Aug 2024 13:05:27 +0000
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

amdgpu_gart_table_vram_pin() and amdgpu_gart_table_vram_unpin() has
been removed since commit 575e55ee4fbc ("drm/amdgpu: recover gart table
at resume") remain the declarations untouched in the header files.

Besides, amdgpu_dm_display_resume() has also beed removed since
commit a80aa93de1a0 ("drm/amd/display: Unify dm resume sequence into a
single call"). So, let's remove this unused declarations.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 137a88b8de45..f0feb199b6e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1588,13 +1588,6 @@ static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return
 static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC)
-int amdgpu_dm_display_resume(struct amdgpu_device *adev );
-#else
-static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return 0; }
-#endif
-
-
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 8283d682f543..7cc980bf4725 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -55,8 +55,6 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev);
 void amdgpu_gart_table_ram_free(struct amdgpu_device *adev);
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev);
 void amdgpu_gart_table_vram_free(struct amdgpu_device *adev);
-int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
-void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
 int amdgpu_gart_init(struct amdgpu_device *adev);
 void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
 void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
-- 
2.17.1

