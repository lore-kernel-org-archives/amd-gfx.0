Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A6AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801EE613C2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 09:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801EE613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EBA6E0FE;
	Tue,  6 Apr 2021 09:09:08 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871EE6E0AB;
 Tue,  6 Apr 2021 09:09:07 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 11B72B2FA;
 Tue,  6 Apr 2021 09:09:06 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, bskeggs@redhat.com, ray.huang@amd.com,
 linux-graphics-maintainer@vmware.com, sroland@vmware.com, zackr@vmware.com,
 shashank.sharma@amd.com, sam@ravnborg.org, emil.velikov@collabora.com,
 Felix.Kuehling@amd.com, nirmoy.das@amd.com
Subject: [PATCH 0/8] drm: Clean up mmap for TTM-based GEM drivers
Date: Tue,  6 Apr 2021 11:08:55 +0200
Message-Id: <20210406090903.7019-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.2
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

Implement mmap via struct drm_gem_object_functions.mmap for amdgpu,
radeon and nouveau. This allows for using common DRM helpers for
the mmap-related callbacks in struct file_operations and struct
drm_driver. The drivers have their own vm_ops, which are now set
automatically by the DRM core functions. The code in each driver's
verify_access becomes part of the driver's new mmap implementation.

With the GEM drivers converted, vmwgfx is the only user of
ttm_bo_mmap() and related infrastructure. So move everything into
vmwgfx and delete the rsp code from TTM.

This touches several drivers. Preferably everything would be merged
at once via drm-misc-next.

Thomas Zimmermann (8):
  drm/ttm: Don't override vm_ops callbacks, if set
  drm/amdgpu: Remove unused function amdgpu_bo_fbdev_mmap()
  drm/amdgpu: Implement mmap as GEM object function
  drm/radeon: Implement mmap as GEM object function
  drm/nouveau: Implement mmap as GEM object function
  drm/vmwgfx: Inline ttm_bo_mmap() into vmwgfx driver
  drm/vmwgfx: Inline vmw_verify_access()
  drm/ttm: Remove ttm_bo_mmap() and friends

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 46 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 19 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 71 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 -
 drivers/gpu/drm/nouveau/nouveau_bo.c        | 10 ---
 drivers/gpu/drm/nouveau/nouveau_drm.c       |  3 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c       | 36 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_ttm.c       | 49 --------------
 drivers/gpu/drm/nouveau/nouveau_ttm.h       |  1 -
 drivers/gpu/drm/radeon/radeon_drv.c         |  3 +-
 drivers/gpu/drm/radeon/radeon_gem.c         | 52 +++++++++++++++
 drivers/gpu/drm/radeon/radeon_ttm.c         | 65 -------------------
 drivers/gpu/drm/radeon/radeon_ttm.h         |  1 -
 drivers/gpu/drm/ttm/ttm_bo_vm.c             | 60 ++---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  9 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 51 ++++++++++++++-
 include/drm/ttm/ttm_bo_api.h                | 13 ----
 include/drm/ttm/ttm_device.h                | 15 -----
 22 files changed, 212 insertions(+), 365 deletions(-)

--
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
