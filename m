Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313A606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=PXqY1GnT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBE011223A;
	Thu, 22 Oct 2026 00:31:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C587D10E1F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so939826f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629070; x=1793233870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qa31dc1zui4OVilCwGUyROOnyfIegskXwc/lR6+B310=;
 b=PXqY1GnTi3pag0QZO+wNBi6x+5WfoUoj3bX7wlYAe6kJrXxf4NcvW8I3IhYkltC9i1
 8hNsj6cfYc1memERTcckhwZowPLh50orXfJF9i82lpwYFrTHZkQ5hJlqYyjNZJ7SkIbo
 gg4WL2sW6g6iHeFYC+0BifRuc7nUyjYVqb9vV0+gfzEtzDCFHgtaBHaMHA9m4pM9jtaW
 pwB7OIrI1lfa5tvojUe+zopX9njocvRZxaTw2I81lFzOp42hQyNkDWpUFtR8DGASigjL
 QnOoxscCVvoYjfbYqRdi1cAuIMNatVAjznOwdwFbdF4ez1KRayj6X7NZdeBfY8JiSDz9
 9OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629070; x=1793233870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qa31dc1zui4OVilCwGUyROOnyfIegskXwc/lR6+B310=;
 b=SQmXwg6LX5jtwAZYpHcp+WzRBITPK4MjUnsIlwo4jF0MBMjyqvhpHJLn9O0mSR/dUt
 ILOPKdsWY28iXhV57DTwMGr9i/ngBne9fOzzonnWNicaVmOVqKaE2l1aNjbNQ/UFksOq
 /m4LoW9NB7dQZ6OK/8RnMN+jWoiH/nSNbdxsuUUIFIksGQcr9GHIOFXI30kzZ+s3IuOg
 9i98hORpp3LRs81DCGXfC3RKWDJdK8qxr6tF8mfLr+qZRAmpFPZvJfcqut5rlKjgsOPq
 4x4lIU1eZvQAJnjSBUhuB5e0r4GzOd0KbZ9saWXgry+uMcxvIaua7xIKNboEoqwipmPQ
 Rv+w==
X-Gm-Message-State: AFq9FYJCmsivDKPeRpgL7NWVTDEjnE2cZ+Hp0og5/gAsihqwQ7zYfw6Y
 h3b1gXLUUQRpEu+0iLiI+WnzoW9W1hn37YNj+4I2ZgsI6GLIblKeNHqWS2pOqsztg+Zkl57i9Fb
 LG/F4AwU=
X-Gm-Gg: AYBFou3U+iEccRqTKOqmATGeMuODSLmSoB1kvGSyxKprCCDWj9FVVqQX9F6iuiuyBdi
 FY22sbnR3XQOfjlGT4hKMorQByIdojOdUp1ZVPRCyD6C0imyYUvpw/AiakggkAnOeviSkcMETib
 cxhaQhdWC26IdRHpX9wJAP8TdRDU7qHmSxpj/tHdLU8FQo03MDSOSOLNz/WFOk9zFz9wCsDQYnV
 AcKyNL8MaVkkAPxoxPyib+/ed4ghGeavgk5bZEtieAgphvjJ9U6ZHeAcio1FBDGjICQe1OEW52K
 BKNgLvYxpmdcFWLlCuR88O5kY1PQOpEHzyDRXr6t9/Z/MUBlc/7tcNVRzydCMGI5mhdAY3G2HSz
 ZgMEBFDnfQCfeATAKJYfYoKtgRiKOcr+w6xpRUlu+zFkK21fNnMm2fPnsCeU8p/7dRByNhHw6QN
 ak1Ow6Lesjyd+k0oz9NuqDl//GN7IVwmvQpm6ctzf7fmtMcwgRdEDeF9tbKSfun8OdgJgtb1SPN
 yQSPKnDUps/6EyEdOkc7VNTx5zqkjsjJSdzTIoc1OA79+et5qWoP3dIM4YQL6juLGzuhRfdMYTM
 +iirG/wz4fyqh564UHff4LttFcy9k9/I1Ge+mUk9AGqL
X-Received: by 2002:a05:6000:2913:b0:48a:f318:ac03 with SMTP id
 ffacd0b85a97d-48e2649e369mr7660449f8f.25.1792629070130; 
 Wed, 21 Oct 2026 17:31:10 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:09 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 2/5] drm/amdgpu: Add usage argument to amdgpu_sync_resv.
Date: Thu, 22 Oct 2026 01:30:55 +0100
Message-ID: <20261022003058.1723817-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let callers pass the highest dma_resv usage amdgpu_sync_resv() syncs to,
instead of hardcoding DMA_RESV_USAGE_READ. All existing callers pass
DMA_RESV_USAGE_READ, so there is no functional change.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c         | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h         | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 +++++---
 6 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9a7e14a3c719..0ed41f696197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1375,6 +1375,7 @@ static int process_sync_pds_resv(struct amdkfd_process_info *process_info,
 		struct amdgpu_bo *pd = peer_vm->root.bo;
 
 		ret = amdgpu_sync_resv(NULL, sync, pd->tbo.base.resv,
+				       DMA_RESV_USAGE_READ,
 				       AMDGPU_SYNC_NE_OWNER,
 				       AMDGPU_FENCE_OWNER_KFD);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 63fd16009bf8..afcd254c9884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1227,7 +1227,9 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		r = amdgpu_sync_resv(p->adev, &p->sync, resv, sync_mode,
+		/* Implicitly sync only to KERNEL, WRITE and READ */
+		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
+				     DMA_RESV_USAGE_READ, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d6d84ff110a0..663873dc005a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1454,7 +1454,8 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 	int r;
 
 	amdgpu_sync_create(&sync);
-	amdgpu_sync_resv(adev, &sync, resv, sync_mode, owner);
+	amdgpu_sync_resv(adev, &sync, resv, DMA_RESV_USAGE_READ, sync_mode,
+			 owner);
 	r = amdgpu_sync_wait(&sync, intr);
 	amdgpu_sync_free(&sync);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index d6ae9974c952..c670ca01c230 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -234,14 +234,15 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
  * @adev: amdgpu device
  * @sync: sync object to add fences from reservation object to
  * @resv: reservation object with embedded fence
+ * @usage: the maximum fence usage to sync to
  * @mode: how owner affects which fences we sync to
  * @owner: owner of the planned job submission
  *
  * Sync to the fence
  */
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
-		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
-		     void *owner)
+		     struct dma_resv *resv, enum dma_resv_usage usage,
+		     enum amdgpu_sync_mode mode, void *owner)
 {
 	struct dma_resv_iter cursor;
 	struct dma_fence *f;
@@ -249,8 +250,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 	if (resv == NULL)
 		return -EINVAL;
-	/* Implicitly sync only to KERNEL, WRITE and READ */
-	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
+
+	dma_resv_for_each_fence(&cursor, resv, usage, f) {
 		dma_fence_chain_for_each(f, f) {
 			struct dma_fence *tmp = dma_fence_chain_contained(f);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 51eb4382c91e..7d39bdb9d4d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -24,6 +24,7 @@
 #ifndef __AMDGPU_SYNC_H__
 #define __AMDGPU_SYNC_H__
 
+#include <linux/dma-resv.h>
 #include <linux/hashtable.h>
 
 struct dma_fence;
@@ -50,8 +51,8 @@ void amdgpu_sync_create(struct amdgpu_sync *sync);
 int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
 		      gfp_t flags);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
-		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
-		     void *owner);
+		     struct dma_resv *resv, enum dma_resv_usage usage,
+		     enum amdgpu_sync_mode mode, void *owner);
 int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
 struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
 				     struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0b8a8f82ecab..6adeb4b0e217 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1307,7 +1307,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		 * unmapping.
 		 */
 		r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
-				     AMDGPU_SYNC_EQ_OWNER, vm);
+				     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EQ_OWNER,
+				     vm);
 		if (r)
 			goto error_free;
 		if (bo) {
@@ -1339,7 +1340,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		/* Implicitly sync to moving fences before mapping anything */
 		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_EXPLICIT, vm);
+				     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EXPLICIT,
+				     vm);
 		if (r)
 			goto error_free;
 	}
@@ -1593,7 +1595,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	 */
 	amdgpu_sync_create(&sync);
 	r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
-			     AMDGPU_SYNC_EQ_OWNER, vm);
+			     DMA_RESV_USAGE_READ, AMDGPU_SYNC_EQ_OWNER, vm);
 	if (r)
 		goto error_free;
 
-- 
2.56.0

