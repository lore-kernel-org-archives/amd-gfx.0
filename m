Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE327C27C50
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD2910E47A;
	Tue,  4 Jun 2024 12:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.b="HnB1dqAs";
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63ADC10E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CuvIJAs/rMor6MVjY7M7zEwy7LNwWt2bysowxjqLdnk=; b=HnB1dqAspFeokFHDpJ6iowJwqC
 f8l6XWeb3L0PyyhxQ4p8sNtVe+0Mkh2gAa1iHDkaQqUQQ9EuXc1HfJJ0Gz5K1GUQXneWD+AfaR3Uf
 0J83vLxSZR7y0ElouhccJzbSH18YS1YPYcdwS8+ICG3WZn/qKw8Yld0sRAYXBp2epfgpX/tUNc1kg
 DN1E+LakHzn07ydwLXk3jAShOxSQeCCtkw1mO4TmJL0tV5C25AaT0ypswb0grtf2GIRipjbLIqxIE
 BooGTFlv08JsqmkNYZlpmReKJ4patXBlmxEMzcGgwAuaiVJZbRoA+a9Nm/C2rRtFnLLWTXKiFxcqx
 6XNQRfrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sEJhQ-00CoVl-0D; Tue, 04 Jun 2024 02:14:56 +0000
Date: Tue, 4 Jun 2024 03:14:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: amd-gfx@lists.freedesktop.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2][RFC] amdkfd CRIU fixes
Message-ID: <20240604021456.GB3053943@ZenIV>
References: <20240604021255.GO1629371@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604021255.GO1629371@ZenIV>
X-Mailman-Approved-At: Tue, 04 Jun 2024 12:47:57 +0000
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

Instead of trying to use close_fd() on failure exits, just have
criu_get_prime_handle() store the file reference without inserting
it into descriptor table.

Then, once the callers are past the last failure exit, they can go
and either insert all those file references into the corresponding
slots of descriptor table, or drop all those file references and
free the unused descriptors.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..3f129e1c0daa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -36,7 +36,6 @@
 #include <linux/mman.h>
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
-#include <linux/fdtable.h>
 #include <linux/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
@@ -1857,7 +1856,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 }
 
 static int criu_get_prime_handle(struct kgd_mem *mem,
-				 int flags, u32 *shared_fd)
+				 int flags, u32 *shared_fd,
+				 struct file **file)
 {
 	struct dma_buf *dmabuf;
 	int ret;
@@ -1868,13 +1868,14 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 		return ret;
 	}
 
-	ret = dma_buf_fd(dmabuf, flags);
+	ret = get_unused_fd_flags(flags);
 	if (ret < 0) {
 		pr_err("dmabuf create fd failed, ret:%d\n", ret);
 		goto out_free_dmabuf;
 	}
 
 	*shared_fd = ret;
+	*file = dmabuf->file;
 	return 0;
 
 out_free_dmabuf:
@@ -1882,6 +1883,24 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 	return ret;
 }
 
+static void commit_files(struct file **files,
+			 struct kfd_criu_bo_bucket *bo_buckets,
+			 unsigned int count,
+			 int err)
+{
+	while (count--) {
+		struct file *file = files[count];
+		if (!file)
+			continue;
+		if (err) {
+			fput(file);
+			put_unused_fd(bo_buckets[count].dmabuf_fd);
+		} else {
+			fd_install(bo_buckets[count].dmabuf_fd, file);
+		}
+	}
+}
+
 static int criu_checkpoint_bos(struct kfd_process *p,
 			       uint32_t num_bos,
 			       uint8_t __user *user_bos,
@@ -1890,6 +1909,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets;
 	struct kfd_criu_bo_priv_data *bo_privs;
+	struct file **files = NULL;
 	int ret = 0, pdd_index, bo_index = 0, id;
 	void *mem;
 
@@ -1903,6 +1923,12 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 		goto exit;
 	}
 
+	files = kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
+	if (!files) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
 		struct kfd_process_device *pdd = p->pdds[pdd_index];
 		struct amdgpu_bo *dumper_bo;
@@ -1950,7 +1976,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				ret = criu_get_prime_handle(kgd_mem,
 						bo_bucket->alloc_flags &
 						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
-						&bo_bucket->dmabuf_fd);
+						&bo_bucket->dmabuf_fd, &files[bo_index]);
 				if (ret)
 					goto exit;
 			} else {
@@ -2001,12 +2027,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	*priv_offset += num_bos * sizeof(*bo_privs);
 
 exit:
-	while (ret && bo_index--) {
-		if (bo_buckets[bo_index].alloc_flags
-		    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
-			close_fd(bo_buckets[bo_index].dmabuf_fd);
-	}
-
+	commit_files(files, bo_buckets, bo_index, ret);
+	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;
@@ -2358,7 +2380,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 
 static int criu_restore_bo(struct kfd_process *p,
 			   struct kfd_criu_bo_bucket *bo_bucket,
-			   struct kfd_criu_bo_priv_data *bo_priv)
+			   struct kfd_criu_bo_priv_data *bo_priv,
+			   struct file **file)
 {
 	struct kfd_process_device *pdd;
 	struct kgd_mem *kgd_mem;
@@ -2410,7 +2433,7 @@ static int criu_restore_bo(struct kfd_process *p,
 	if (bo_bucket->alloc_flags
 	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
 		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
-					    &bo_bucket->dmabuf_fd);
+					    &bo_bucket->dmabuf_fd, file);
 		if (ret)
 			return ret;
 	} else {
@@ -2427,6 +2450,7 @@ static int criu_restore_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets = NULL;
 	struct kfd_criu_bo_priv_data *bo_privs = NULL;
+	struct file **files = NULL;
 	int ret = 0;
 	uint32_t i = 0;
 
@@ -2440,6 +2464,12 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (!bo_buckets)
 		return -ENOMEM;
 
+	files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
+	if (!files) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
 			     args->num_bos * sizeof(*bo_buckets));
 	if (ret) {
@@ -2465,7 +2495,7 @@ static int criu_restore_bos(struct kfd_process *p,
 
 	/* Create and map new BOs */
 	for (; i < args->num_bos; i++) {
-		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
+		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i], &files[i]);
 		if (ret) {
 			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
 			goto exit;
@@ -2480,11 +2510,8 @@ static int criu_restore_bos(struct kfd_process *p,
 		ret = -EFAULT;
 
 exit:
-	while (ret && i--) {
-		if (bo_buckets[i].alloc_flags
-		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
-			close_fd(bo_buckets[i].dmabuf_fd);
-	}
+	commit_files(files, bo_buckets, i, ret);
+	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;
