Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197BFC433E9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41EF22DD3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41EF22DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EC76E104;
	Tue, 12 Jan 2021 08:10:42 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A696E0EA;
 Tue, 12 Jan 2021 08:10:41 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C03FAB722;
 Tue, 12 Jan 2021 08:10:39 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH 1/6] drm: Inline AGP wrappers into their only callers
Date: Tue, 12 Jan 2021 09:10:30 +0100
Message-Id: <20210112081035.6882-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112081035.6882-1-tzimmermann@suse.de>
References: <20210112081035.6882-1-tzimmermann@suse.de>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The AGP wrapper functions serve no purpose.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_agpsupport.c | 12 ++++++------
 drivers/gpu/drm/drm_memory.c     | 18 ------------------
 include/drm/drm_agpsupport.h     | 18 ------------------
 3 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
index 4c7ad46fdd21..8b690ef306de 100644
--- a/drivers/gpu/drm/drm_agpsupport.c
+++ b/drivers/gpu/drm/drm_agpsupport.c
@@ -285,7 +285,7 @@ int drm_agp_unbind(struct drm_device *dev, struct drm_agp_binding *request)
 	entry = drm_agp_lookup_entry(dev, request->handle);
 	if (!entry || !entry->bound)
 		return -EINVAL;
-	ret = drm_unbind_agp(entry->memory);
+	ret = agp_unbind_memory(entry->memory);
 	if (ret == 0)
 		entry->bound = 0;
 	return ret;
@@ -326,7 +326,7 @@ int drm_agp_bind(struct drm_device *dev, struct drm_agp_binding *request)
 	if (!entry || entry->bound)
 		return -EINVAL;
 	page = DIV_ROUND_UP(request->offset, PAGE_SIZE);
-	retcode = drm_bind_agp(entry->memory, page);
+	retcode = agp_bind_memory(entry->memory, page);
 	if (retcode)
 		return retcode;
 	entry->bound = dev->agp->base + (page << PAGE_SHIFT);
@@ -369,11 +369,11 @@ int drm_agp_free(struct drm_device *dev, struct drm_agp_buffer *request)
 	if (!entry)
 		return -EINVAL;
 	if (entry->bound)
-		drm_unbind_agp(entry->memory);
+		agp_unbind_memory(entry->memory);
 
 	list_del(&entry->head);
 
-	drm_free_agp(entry->memory, entry->pages);
+	agp_free_memory(entry->memory);
 	kfree(entry);
 	return 0;
 }
@@ -453,8 +453,8 @@ void drm_legacy_agp_clear(struct drm_device *dev)
 
 	list_for_each_entry_safe(entry, tempe, &dev->agp->memory, head) {
 		if (entry->bound)
-			drm_unbind_agp(entry->memory);
-		drm_free_agp(entry->memory, entry->pages);
+			agp_unbind_memory(entry->memory);
+		agp_free_memory(entry->memory);
 		kfree(entry);
 	}
 	INIT_LIST_HEAD(&dev->agp->memory);
diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index fbea69d6f909..f4f2bffdd5bd 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -100,24 +100,6 @@ static void *agp_remap(unsigned long offset, unsigned long size,
 	return addr;
 }
 
-/** Wrapper around agp_free_memory() */
-void drm_free_agp(struct agp_memory *handle, int pages)
-{
-	agp_free_memory(handle);
-}
-
-/** Wrapper around agp_bind_memory() */
-int drm_bind_agp(struct agp_memory *handle, unsigned int start)
-{
-	return agp_bind_memory(handle, start);
-}
-
-/** Wrapper around agp_unbind_memory() */
-int drm_unbind_agp(struct agp_memory *handle)
-{
-	return agp_unbind_memory(handle);
-}
-
 #else /*  CONFIG_AGP  */
 static inline void *agp_remap(unsigned long offset, unsigned long size,
 			      struct drm_device *dev)
diff --git a/include/drm/drm_agpsupport.h b/include/drm/drm_agpsupport.h
index 664e120b93e6..f3136750c490 100644
--- a/include/drm/drm_agpsupport.h
+++ b/include/drm/drm_agpsupport.h
@@ -28,10 +28,6 @@ struct drm_agp_head {
 
 #if IS_ENABLED(CONFIG_AGP)
 
-void drm_free_agp(struct agp_memory * handle, int pages);
-int drm_bind_agp(struct agp_memory * handle, unsigned int start);
-int drm_unbind_agp(struct agp_memory * handle);
-
 struct drm_agp_head *drm_agp_init(struct drm_device *dev);
 void drm_legacy_agp_clear(struct drm_device *dev);
 int drm_agp_acquire(struct drm_device *dev);
@@ -61,20 +57,6 @@ int drm_agp_bind_ioctl(struct drm_device *dev, void *data,
 
 #else /* CONFIG_AGP */
 
-static inline void drm_free_agp(struct agp_memory * handle, int pages)
-{
-}
-
-static inline int drm_bind_agp(struct agp_memory * handle, unsigned int start)
-{
-	return -ENODEV;
-}
-
-static inline int drm_unbind_agp(struct agp_memory * handle)
-{
-	return -ENODEV;
-}
-
 static inline struct drm_agp_head *drm_agp_init(struct drm_device *dev)
 {
 	return NULL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
