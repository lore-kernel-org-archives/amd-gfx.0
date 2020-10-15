Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E1C4363A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1DB22254
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 12:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1DB22254
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E903D6ECEA;
	Thu, 15 Oct 2020 12:38:16 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A54C6ECD8;
 Thu, 15 Oct 2020 12:38:15 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A66FDB18A;
 Thu, 15 Oct 2020 12:38:12 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, sam@ravnborg.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, kraxel@redhat.com, l.stach@pengutronix.de,
 linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
 yuq825@gmail.com, bskeggs@redhat.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, hjc@rock-chips.com, heiko@sntech.de,
 hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 oleksandr_andrushchenko@epam.com, ray.huang@amd.com,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, luben.tuikov@amd.com,
 apaneers@amd.com, linus.walleij@linaro.org, melissa.srw@gmail.com,
 chris@chris-wilson.co.uk, miaoqinglang@huawei.com
Subject: [PATCH v4 02/10] drm/cma-helper: Remove empty
 drm_gem_cma_prime_vunmap()
Date: Thu, 15 Oct 2020 14:37:58 +0200
Message-Id: <20201015123806.32416-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015123806.32416-1-tzimmermann@suse.de>
References: <20201015123806.32416-1-tzimmermann@suse.de>
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
Cc: linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 xen-devel@lists.xenproject.org, spice-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function drm_gem_cma_prime_vunmap() is empty. Remove it before
changing the interface to use struct drm_buf_map.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 17 -----------------
 drivers/gpu/drm/vc4/vc4_bo.c         |  1 -
 include/drm/drm_gem_cma_helper.h     |  1 -
 3 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 2165633c9b9e..d527485ea0b7 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -537,23 +537,6 @@ void *drm_gem_cma_prime_vmap(struct drm_gem_object *obj)
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_prime_vmap);
 
-/**
- * drm_gem_cma_prime_vunmap - unmap a CMA GEM object from the kernel's virtual
- *     address space
- * @obj: GEM object
- * @vaddr: kernel virtual address where the CMA GEM object was mapped
- *
- * This function removes a buffer exported via DRM PRIME from the kernel's
- * virtual address space. This is a no-op because CMA buffers cannot be
- * unmapped from kernel space. Drivers using the CMA helpers should set this
- * as their &drm_gem_object_funcs.vunmap callback.
- */
-void drm_gem_cma_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
-{
-	/* Nothing to do */
-}
-EXPORT_SYMBOL_GPL(drm_gem_cma_prime_vunmap);
-
 static const struct drm_gem_object_funcs drm_gem_cma_default_funcs = {
 	.free = drm_gem_cma_free_object,
 	.print_info = drm_gem_cma_print_info,
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index f432278173cd..557f0d1e6437 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -387,7 +387,6 @@ static const struct drm_gem_object_funcs vc4_gem_object_funcs = {
 	.export = vc4_prime_export,
 	.get_sg_table = drm_gem_cma_prime_get_sg_table,
 	.vmap = vc4_prime_vmap,
-	.vunmap = drm_gem_cma_prime_vunmap,
 	.vm_ops = &vc4_vm_ops,
 };
 
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 2bfa2502607a..a064b0d1c480 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -104,7 +104,6 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
 int drm_gem_cma_prime_mmap(struct drm_gem_object *obj,
 			   struct vm_area_struct *vma);
 void *drm_gem_cma_prime_vmap(struct drm_gem_object *obj);
-void drm_gem_cma_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
 struct drm_gem_object *
 drm_gem_cma_create_object_default_funcs(struct drm_device *dev, size_t size);
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
