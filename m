Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E58606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QPLXUf1P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45411124F0;
	Thu, 22 Oct 2026 10:55:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0C71124EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:55:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so17920165e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792666512; x=1793271312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zv7CkHAV3N3REUXqzyWKtvO8PelSQIZd3jgUPZp9ZC8=;
 b=QPLXUf1PoPXwfURZ5GM37aa3I88UeAnMVP5Brt2axgISVvf7+cMW7UD6VzY7eLjBKP
 HYZCcxAjdlcqDInnVKOmMbNxgN0f0130+0yTD6kJNMzzPWaK/Hn1kSdgbRbIM9x81GFw
 DTwVWHQuewA5pDdFOQLllXZxAMcyLi6MmHEyWGx+VaBBJcMq6+mMyXXqYucA69AF+8A4
 AmsuJFTqlI6MkjKlQgmF7i5SHnu5k3CPtG3rG7E6qVji3rnyjI8PI7Bm6IFJgJDMSwLa
 uYlldeEzkldZQlftIoiZ9/JmdAHXAfCb/iqRAQKzRU21h71ug2VDG2galxCJ8WwaSxVs
 i44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792666512; x=1793271312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zv7CkHAV3N3REUXqzyWKtvO8PelSQIZd3jgUPZp9ZC8=;
 b=OHNDzO5XohwT7BTynBFOEJOxwVRW3uui4unBDhiF+5Wq5lfbbMBe695EoJQvIhc/XG
 WVTo3MBXMskqJEtE4JGyOzj3kOLuFhGwsAMxgcnpZAUjzYkPBsaxkENxhqe3qeV5uIEu
 tgKzTMxrHbYtd8rinzFpJZOS2rBK4q5Xr+ilp0E/2VBbVbp3zHOJ39BUKQlib86bonL/
 FEi7Pvo0qdfovovqT4+VIti5WC2utYWHiD04B9LXYW6d0MMe5EGfKr0VFrNtgaK5Rm+J
 tZQ9+yPl2CV8bpIYSswZ5terFhgiLXkQKbs3zU/7dE4ywZs89c28JcpSOzemgaBIWxyb
 bilg==
X-Gm-Message-State: AFq9FYK0dPSbJSOcTGJYQ47M0wfApeuj3hyqHQ4QDcFa8t9+teNQFk4m
 WIAEDu5s9yzkKWgkOiB9rRipJLZPYUxwMxN3SgrmDdjRbARUR3qBI+G2qjlkt3Q8
X-Gm-Gg: AYBFou0dwK0pmpBdgV2t3LHDW/nO4PH8NgXSp0ERjYsp2fWdVf7CSLtiVD0JpNrbiLS
 Go5h/eQU5bVxCZLqcflLNWu+cCBFPEV/E+5HeNI65NXPNNP+M3yCk7u/on2dnzqaLceeAyZWUkc
 Pi2wpZPQHcbF3dmfWEsFyFekXeeeVkOYbzVAAtHnyLrCUXWVsPZQBYSa+YQt6zGhblPxOn1YJB0
 QUapdMHBUNSaU6sypLz2bGtwJ/7JBf16HVpemi1+7YdQvcquThTydwkFAbKksK7PJblFbwxSoJ8
 sXCvYu7WU2YlW2RXuUzP78zEIm1yoJ213TZs4NqrqAu4bWszx2Jq9oAGIbccQ3504zWg1rGZ6h1
 vzXaYg9x/DbO7+M2jnm2sgmiyC2VFons+HhkzVudCYcY+uxfRiNtkAIajy5Lmyoz9ZyJi3nrYQ/
 PYxw0YNuY8/9hB0R64FIn1wunnEFK5I20eRJyrjFJBZ4Vw+uND9VkDJpJMNF3+yAtKgV854cGoh
 dJ27gQZLuZgtFt4euwYWs/UB/O4M7mF0sz7fyjfhIFwdpNMdJ9xxjh4nqFHzX202wu8JyaY52hR
 9GcveO9MkvaA6wbj5yT3PMldySLO20LMqjzjYw6+gwbq/Myh/VRaPwGO0oMS5pLGmduwgWmY+sK
 0LK1WsyHBvGWGS3N/yC8MAmwssDJkbuqw8fXPIgZrbJH75lin+tATA3bm0QNbTBwThBGs5EmXSJ
 UOcONrfS8l8vUCBpdZvfT7shzs02wb8AUNDn4wMYhjKkcjc3P+3R2ncOK9MrXjLkc8T+YzBpYam
 SO0i02IOMJ9SA==
X-Received: by 2002:a05:600c:8b78:b0:4a2:cbe:beac with SMTP id
 5b1f17b1804b1-4a20cbec01dmr5594955e9.23.1792666511845; 
 Thu, 22 Oct 2026 03:55:11 -0700 (PDT)
Received: from localhost.localdomain (188.42.205.77.rev.sfr.net.
 [77.205.42.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583e25asm12227393f8f.46.2026.10.22.03.55.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 03:55:11 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, felix.kuehling@amd.com,
 alexander.deucher@amd.com, xiaogang.chen@amd.com,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Subject: [PATCH v7 3/3] drm/amdkfd: propagate SVM migration fence errors and
 guard submit with drm_dev_enter
Date: Thu, 22 Oct 2026 12:55:03 +0200
Message-ID: <20261022105503.60372-4-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
References: <20261022105503.60372-1-olivier.kaloudoff@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On surprise removal the killed process's own exit path can fault on its
SVM managed ranges: SIGBUS -> coredump -> get_dump_page() ->
__get_user_pages() -> do_swap_page() -> svm_migrate_to_ram(). The fault
path waits on the SDMA migration fence in svm_migrate_copy_done().

That fence can complete with an error: the dying process submits the
migration job on its own drm_sched entity, which process teardown has
already killed, so the job is terminated and its fence completes with
-ESRCH (guaranteed to signal at all by the companion drm/scheduler
fix posted separately to dri-devel).

Make svm_migrate_copy_done() return the fence's error status after the
unbounded wait, and make both callers handle it: release the allocated
destination pages (VRAM pages via svm_migrate_put_vram_page(), system
pages unmapped, unlocked and put), clear migrate->dst before
migrate_vma_finalize() so a failed copy cannot complete as a
successful migration, and propagate the error to the caller. The page
release loops are the same logic the copy functions already run on
their own error paths, factored into helpers so both error paths share
them.

Also guard the job-submitting sections of svm_migrate_ram_to_vram() and
svm_migrate_vram_to_ram() with drm_dev_enter()/drm_dev_exit() so they
fail fast with -ENODEV once the device is unplugged instead of
submitting to dead hardware.

Rebased on amd-staging-drm-next (post window_resident landing).

Tested on gfx906 (MI50 on Thunderbolt): with a managed-memory hog
process SIGBUS'd mid-migration, surprise removal now tears down
cleanly, all KFD processes reap, the pciehp removal completes, the
host survives and the device re-enumerates on re-authorization.

Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 101 ++-
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8b96e1f..0000000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -204,7 +204,8 @@
 	int r = 0;
 
 	if (mfence) {
-		r = dma_fence_wait(mfence, false);
+		dma_fence_wait(mfence, false);
+		r = mfence->error;
 		dma_fence_put(mfence);
 		pr_debug("sdma copy memory fence done\n");
 	}
@@ -239,6 +240,24 @@
 	put_page(page);
 }
 
+/* Release VRAM dst pages of a failed migration and clear migrate->dst
+ * so migrate_vma_finalize() leaves the source pages unmigrated.
+ */
+static void
+svm_migrate_vram_pages_put(struct amdgpu_device *adev,
+			   struct migrate_vma *migrate, u64 *dst, u64 npages)
+{
+	u64 i;
+
+	for (i = 0; i < npages; i++) {
+		if (!dst[i])
+			continue;
+		svm_migrate_put_vram_page(adev, dst[i]);
+		dst[i] = 0;
+		migrate->dst[i] = 0;
+	}
+}
+
 static unsigned long
 svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 {
@@ -359,13 +378,7 @@
 out_free_vram_pages:
 	if (r) {
 		pr_debug("failed %d to copy memory to vram\n", r);
-		for (i = 0; i < npages && mpages; i++) {
-			if (!dst[i])
-				continue;
-			svm_migrate_put_vram_page(adev, dst[i]);
-			migrate->dst[i] = 0;
-			mpages--;
-		}
+		svm_migrate_vram_pages_put(adev, migrate, dst, npages);
 	}
 
 #ifdef DEBUG_FORCE_MIXED_DOMAINS
@@ -441,7 +454,7 @@
 	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
-	int r = -ENOMEM;
+	int ret, r = -ENOMEM;
 
 	/* Avoid unnecessary migrations and MMU notifiers if all the data is
 	 * already resident in VRAM.
@@ -493,7 +506,13 @@
 	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&migrate);
 
-	svm_migrate_copy_done(adev, mfence);
+	ret = svm_migrate_copy_done(adev, mfence);
+	if (ret) {
+		svm_migrate_vram_pages_put(adev, &migrate,
+					   (u64 *)(scratch + npages), npages);
+		if (!r)
+			r = ret;
+	}
 	migrate_vma_finalize(&migrate);
 
 	mpages = svm_migrate_successful_pages(&migrate);
@@ -542,6 +561,7 @@
 	u64 ttm_res_offset;
 	struct kfd_node *node;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	if (start_mgr < prange->start || last_mgr > prange->last) {
@@ -627,6 +647,34 @@
 	}
 }
 
+/* Release system RAM dst pages of a failed migration and clear
+ * migrate->dst so migrate_vma_finalize() leaves them unmigrated.
+ */
+static void
+svm_migrate_ram_pages_put(struct device *dev, struct migrate_vma *migrate,
+			  dma_addr_t *dst, u64 npages)
+{
+	u64 i;
+
+	for (i = 0; i < npages; i++) {
+		struct page *dpage;
+
+		if (dst[i]) {
+			dma_unmap_page(dev, dst[i], PAGE_SIZE,
+				       DMA_BIDIRECTIONAL);
+			dst[i] = 0;
+		}
+		if (!migrate->dst[i])
+			continue;
+		dpage = migrate_pfn_to_page(migrate->dst[i]);
+		if (!dpage)
+			continue;
+		unlock_page(dpage);
+		put_page(dpage);
+		migrate->dst[i] = 0;
+	}
+}
+
 static int
 svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			struct migrate_vma *migrate, struct dma_fence **mfence,
@@ -717,22 +765,7 @@
 		}
 
 		/* release previous allocated sys pages and unmap dma address */
-		while (i--) {
-
-			if (dst[i]) {
-				dma_unmap_page(dev, dst[i], PAGE_SIZE,
-					       DMA_BIDIRECTIONAL);
-				dst[i] = 0;
-			}
-
-			dpage = migrate_pfn_to_page(migrate->dst[i]);
-			if (!dpage)
-				continue;
-
-			unlock_page(dpage);
-			put_page(dpage);
-			migrate->dst[i] = 0;
-		}
+		svm_migrate_ram_pages_put(dev, migrate, dst, npages);
 	}
 
 	return r;
@@ -770,7 +803,7 @@
 	struct migrate_vma migrate = { 0 };
 	dma_addr_t *scratch;
 	void *buf;
-	int r = -ENOMEM;
+	int ret, r = -ENOMEM;
 
 	memset(&migrate, 0, sizeof(migrate));
 	migrate.vma = vma;
@@ -825,7 +858,12 @@
 	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
 		 mpages, cpages, migrate.npages);
 
-	svm_migrate_copy_done(adev, mfence);
+	ret = svm_migrate_copy_done(adev, mfence);
+	if (ret) {
+		svm_migrate_ram_pages_put(adev->dev, &migrate, scratch, npages);
+		if (!r)
+			r = ret;
+	}
 	migrate_vma_finalize(&migrate);
 
 	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
@@ -869,6 +907,7 @@
 	unsigned long start;
 	unsigned long end;
 	unsigned long mpages = 0;
+	int idx;
 	long r = 0;
 
 	/* this pragne has no any vram page to migrate to sys ram */
@@ -889,6 +928,11 @@
 		pr_debug("failed to get kfd node by id 0x%x\n", prange->actual_loc);
 		return -ENODEV;
 	}
+
+	/* Block unplug while the migration submits jobs and waits on them */
+	if (!drm_dev_enter(adev_to_drm(node->adev), &idx))
+		return -ENODEV;
+
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu 0x%x to ram\n",
 		 prange->svms, prange, start_mgr, last_mgr,
 		 prange->actual_loc);
@@ -933,6 +977,7 @@
 		}
 	}
 
+	drm_dev_exit(idx);
 	return r < 0 ? r : 0;
 }
 
-- 
2.39.0
