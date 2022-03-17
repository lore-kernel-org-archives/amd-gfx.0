Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15067C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C5F10EBDD;
	Thu, 17 Mar 2022 13:50:59 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871EB10EBD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:55 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id a8so10852083ejc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PvvpAlfWUx4MZsjqJ2ledaQ6ZYxjlMxRZHkgrvDwVbE=;
 b=UySrgiAM+lrSjr7LgnnWIY6cgjmt6Ro2A0UKhbBOGTXHIGFnCUQeh8oj+wNCqMuZhX
 Wl6Fp1yECOOm9/VyrQ9MQJXllASCgzWKJA2q4kNljff/AxuszH0MefO+4C2rXBEvn/cQ
 /brSwF5k3A3aBWKjPogQKsnS/F0KhwxnxPq9F5dV7z2F3KhDejxmu58ACecq6prGkSon
 OeSTnxGAs/X6lMYs18jmoCGIiGyNbpCoBim0oNR/AZP09cY37wdBA1z00cI+AH8iQMHS
 xvYYpZE/AwiWr5ORHQRAQIWM9T5M0+Q2TE+Bl8l9gHLpTuFonM/25T9UjyoykT4uuwbG
 2cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PvvpAlfWUx4MZsjqJ2ledaQ6ZYxjlMxRZHkgrvDwVbE=;
 b=toBhbTwcuH+BXXW2Sw4TFIQ/UvGR0iLQp+rbLESbzxB5cAbHpd7rvTNpag2n8QoJh5
 DnWkaWtffjbkqqo1ouEYCtYWKEXNpKO8tnKe2ADZXJBLcmfySfdbfXZAw6sGU6n2ZWbe
 s/Mqo5Zdz3d8lcWEb9AseV0TQBUbmqcpYTZCJj0L9fwuWr0XvSjlUWkRVCqRFwUH3PVr
 0DXoRmzRXxbsvb28gKcJRkLVVi+G5yE53LRNgWDYNTl6x0Fq1DXn6xJvgTuBq2MB69bH
 iX8vX+VsIWsfI5C/wtDc5K6K4FwXLaiJ0WZdBJmTnZOUDFYVEA5J/XEK9Gh/OoI9CB5e
 QFgg==
X-Gm-Message-State: AOAM533DNbbX9qpZmXOk+FK6ojsFr/Or41Ym8QnHe3Zxvxp1urGS0yT0
 bCMrbjqRVuzF2r8gfsEdY2TDoOu/Y+E=
X-Google-Smtp-Source: ABdhPJxsQhNrJEYzsUmwy+jSo4dTNa7rJc0MmwJCkkQyMeowKCTRQ76gaP8DuhOO/+EzZjXzLWFo8g==
X-Received: by 2002:a17:906:58c5:b0:6da:81ae:9eb0 with SMTP id
 e5-20020a17090658c500b006da81ae9eb0mr4402675ejs.611.1647525053965; 
 Thu, 17 Mar 2022 06:50:53 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 6/7] drm/amdkfd: use tlb_seq from the VM subsystem for SVM as
 well
Date: Thu, 17 Mar 2022 14:50:43 +0100
Message-Id: <20220317135044.2099-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317135044.2099-1-christian.koenig@amd.com>
References: <20220317135044.2099-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of hand rolling the table_freed parameter.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 18 ++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4cb14c2fe53f..9fcfb5e1b55c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -273,9 +273,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
 		uint64_t *size);
-int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
-		bool *table_freed);
+int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
+					  struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cd89d2e46852..57b521bb1eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1093,8 +1093,7 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
 
 static int update_gpuvm_pte(struct kgd_mem *mem,
 			    struct kfd_mem_attachment *entry,
-			    struct amdgpu_sync *sync,
-			    bool *table_freed)
+			    struct amdgpu_sync *sync)
 {
 	struct amdgpu_bo_va *bo_va = entry->bo_va;
 	struct amdgpu_device *adev = entry->adev;
@@ -1105,7 +1104,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false, table_freed);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
@@ -1117,8 +1116,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 static int map_bo_to_gpuvm(struct kgd_mem *mem,
 			   struct kfd_mem_attachment *entry,
 			   struct amdgpu_sync *sync,
-			   bool no_update_pte,
-			   bool *table_freed)
+			   bool no_update_pte)
 {
 	int ret;
 
@@ -1135,7 +1133,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
 	if (no_update_pte)
 		return 0;
 
-	ret = update_gpuvm_pte(mem, entry, sync, table_freed);
+	ret = update_gpuvm_pte(mem, entry, sync);
 	if (ret) {
 		pr_err("update_gpuvm_pte() failed\n");
 		goto update_gpuvm_pte_failed;
@@ -1745,7 +1743,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		struct amdgpu_device *adev, struct kgd_mem *mem,
-		void *drm_priv, bool *table_freed)
+		void *drm_priv)
 {
 	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
 	int ret;
@@ -1832,7 +1830,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 			 entry->va, entry->va + bo_size, entry);
 
 		ret = map_bo_to_gpuvm(mem, entry, ctx.sync,
-				      is_invalid_userptr, table_freed);
+				      is_invalid_userptr);
 		if (ret) {
 			pr_err("Failed to map bo to gpuvm\n");
 			goto out_unreserve;
@@ -2300,7 +2298,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync, NULL);
+			ret = update_gpuvm_pte(mem, attachment, &sync);
 			if (ret) {
 				pr_err("%s: update PTE failed\n", __func__);
 				/* make sure this gets validated again */
@@ -2506,7 +2504,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 				continue;
 
 			kfd_mem_dmaunmap_attachment(mem, attachment);
-			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
+			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
 			if (ret) {
 				pr_debug("Memory eviction: update PTE failed. Try again\n");
 				goto validate_map_fail;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e1e2362841f8..91f82a9ccdaf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1146,7 +1146,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	long err = 0;
 	int i;
 	uint32_t *devices_arr = NULL;
-	bool table_freed = false;
 
 	if (!args->n_devices) {
 		pr_debug("Device IDs array empty\n");
@@ -1208,7 +1207,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 			peer_pdd->dev->adev, (struct kgd_mem *)mem,
-			peer_pdd->drm_priv, &table_freed);
+			peer_pdd->drm_priv);
 		if (err) {
 			struct pci_dev *pdev = peer_pdd->dev->adev->pdev;
 
@@ -1233,13 +1232,11 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	/* Flush TLBs after waiting for the page table updates to complete */
-	if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
-		for (i = 0; i < args->n_devices; i++) {
-			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
-			if (WARN_ON_ONCE(!peer_pdd))
-				continue;
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
-		}
+	for (i = 0; i < args->n_devices; i++) {
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
 	}
 	kfree(devices_arr);
 
@@ -2203,8 +2200,8 @@ static int criu_restore_bo(struct kfd_process *p,
 		if (IS_ERR(peer_pdd))
 			return PTR_ERR(peer_pdd);
 
-		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem, peer_pdd->drm_priv,
-							    NULL);
+		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem,
+							    peer_pdd->drm_priv);
 		if (ret) {
 			pr_err("Failed to map to gpu %d/%d\n", j, p->n_pdds);
 			return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4a8a047b7593..ac8123c1ee8f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -722,7 +722,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 		goto err_alloc_mem;
 
 	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->adev, *mem,
-			pdd->drm_priv, NULL);
+			pdd->drm_priv);
 	if (err)
 		goto err_map_mem;
 
-- 
2.25.1

