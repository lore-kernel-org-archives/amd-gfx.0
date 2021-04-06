Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F962C43461
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA746613DE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA746613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AAB6E7D0;
	Tue,  6 Apr 2021 09:09:10 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E846E0AB;
 Tue,  6 Apr 2021 09:09:08 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CF927B30C;
 Tue,  6 Apr 2021 09:09:06 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, bskeggs@redhat.com, ray.huang@amd.com,
 linux-graphics-maintainer@vmware.com, sroland@vmware.com, zackr@vmware.com,
 shashank.sharma@amd.com, sam@ravnborg.org, emil.velikov@collabora.com,
 Felix.Kuehling@amd.com, nirmoy.das@amd.com
Subject: [PATCH 2/8] drm/amdgpu: Remove unused function amdgpu_bo_fbdev_mmap()
Date: Tue,  6 Apr 2021 11:08:57 +0200
Message-Id: <20210406090903.7019-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406090903.7019-1-tzimmermann@suse.de>
References: <20210406090903.7019-1-tzimmermann@suse.de>
MIME-Version: 1.0
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
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove an unused function. Mapping the fbdev framebuffer is apparently
not supported.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b99e9d8736c2..cfc89164dee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1092,25 +1092,6 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_bo_fbdev_mmap - mmap fbdev memory
- * @bo: &amdgpu_bo buffer object
- * @vma: vma as input from the fbdev mmap method
- *
- * Calls ttm_fbdev_mmap() to mmap fbdev memory if it is backed by a bo.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
-			     struct vm_area_struct *vma)
-{
-	if (vma->vm_pgoff != 0)
-		return -EACCES;
-
-	return ttm_bo_mmap_obj(vma, &bo->tbo);
-}
-
 /**
  * amdgpu_bo_set_tiling_flags - set tiling flags
  * @bo: &amdgpu_bo buffer object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 54ceb065e546..46e94d413c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -268,8 +268,6 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo);
 int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
 int amdgpu_bo_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
-int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
-				struct vm_area_struct *vma);
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);
 void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags);
 int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
