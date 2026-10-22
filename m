Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE04606A31F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.a=rsa-sha256 header.s=google header.b=Z5j7XiwP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC1B112283;
	Thu, 22 Oct 2026 00:31:24 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CCE11223A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:31:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so1988045e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 17:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1792629073; x=1793233873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yV6IUiDyK0jd7Mijo8t15PQwc0Vi7srdN93JNcH1sZM=;
 b=Z5j7XiwP79ad6j3cOMnx1kWr1xXPJ+yLMn2krEUmrz2SwLJJgU6XBgvLRzWgTybG0C
 HCDK/dCetG4n6GfVV+NHIEKfxGssWsu/y/Nak7YLnWKBMq1IZCxj8skb1Q7W5Cpt/WQY
 fSUZIeOLLVprgD6YtjDafCWtqAXDquKs4ApY30hgajSWbt7BdQm6Sb1zHBpuFR1hWZD6
 xVx5HQ0r+sZ1lH7Q07fRObpYj3CJuKw2pg4xTkmEFLHoIH6G1mu5B+DxBoZGpLKNwoqa
 dXUeLE6mPiouKfNAbJ0j3rVgl/XgJ5IM7VvK1xkGspy7QC2kr0iGtIwM3LntsHPo6TMP
 36dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792629073; x=1793233873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yV6IUiDyK0jd7Mijo8t15PQwc0Vi7srdN93JNcH1sZM=;
 b=RYgWzCxfTuCe3HlYtvo0YFTclOLYlAgWeeVPosBE+jbRfWCzpCs5Un5R3LzPLo4qQ6
 gF3OtFnGQKExvq3MtUqtRDakK94kIoZZJh6OH4VzU0pndc0ApFjhJSs8dnsz2c+VUS/q
 AJ5ZEvJpfrP7noTAh0MiXKSLXNe9js0JV1snfCYG+oz+ak3cuLh7JrR1YZD2XdWvG9tZ
 9XyzCIoH5Y65CCW2MHN879qk4x2dPO1O1O5r4gwIxWFAl8xU8eKqw5lRn4lpbfJkKXYg
 0WoDxS/sUw+3BFSGkPRsZixaWJHEPtIvrEXT2Fr3KnFkTYUe6QGvdxd7WJUja/ZyXUIb
 JchQ==
X-Gm-Message-State: AFq9FYLLQEwuf2PeKw+CUzMOhY+/rG8emoINwEI7gbIxXg/mevibYxK+
 vd6A286UR5THfdhqz9gKu0ZEuTPSgtoYVcOCMHFE4n/BaMg32ushR1BZ0I9Gq/Zpw+dmZTd8TVE
 O755OA/U=
X-Gm-Gg: AYBFou14jld/PTWz4Aky2CdWWjBoSoiDW5GEZtAOOCO6QYQWqCEcQ3nhHamL2W5YOGB
 28AMG1sJPe8h0v/W0JlVTUmATFyXR9N0Du9M4E4CQ47o0tDChtdtXH0fqbA2d5nZtVSBLPSYvyG
 QKu9ZuP44YhZSl4poiJAtKe43v+l6Gz1810lImp1FHfTWTW2PblgCYk69StC6r4/kdC1gDqR7gm
 N4gBD6oozXSC3/NflpAynvKR2r906UUf1qkCSuU3aqe7iJtP6pDE6zDTkR1I4k2IbKGEgXNy94Q
 xm4bp1EaHNyqk5yyaEiLi3ocfvrkOhfyWOrpC7wSPwkfWjiPxa8kCD8VfrKh497UpNwOPd5GB29
 Bod5DDM10dkv56/p7PPlQXvdV93pxT/n3CW/mtuyqCLO+QfECIEt2Mq4BxyVeoAofQBAoU8v7Yx
 oeuR5zj0SqqWntwPlhkhvma9XjMf8GnKb7hd5jO26Zm4lSNDtZYRKJLFw67HbOkG6Wb35/sUUt1
 wI/ueP9MFLFanubfMBe/7S07/bDWLBSiBjGaN+LYHWRCMxCG5lizYg2o3bjMl1VYmCcUJcFmRTE
 28pJya6oBAuCEc3Jdm2HLBHZtc0Y9euyXKLNlTUbOWnd
X-Received: by 2002:a05:600c:6085:b0:4a1:a7f8:c124 with SMTP id
 5b1f17b1804b1-4a204b04321mr16895605e9.7.1792629073397; 
 Wed, 21 Oct 2026 17:31:13 -0700 (PDT)
Received: from bas-workstation ([143.58.146.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm7954532f8f.58.2026.10.21.17.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 17:31:12 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, samuel.pitoiset@gmail.com, natalie.vock@gmx.de,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 4/5] drm/amdgpu: Implement disabling implicit sync per
 submission.
Date: Thu, 22 Oct 2026 01:30:57 +0100
Message-ID: <20261022003058.1723817-5-bas@basnieuwenhuizen.nl>
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

Implements the UAPI flag to give apps an options to disable
implicit sync per submission.

v2:
 - signal READ fences for the VM root PD, as some unmapping
   operations only wait for READ and up.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 34 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index afcd254c9884..f0fe9d0f1398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -49,6 +49,9 @@
 #define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW	0xFFFFF
 #define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW	0x7FFFF0
 
+/* All flags accepted in drm_amdgpu_cs_in.flags */
+#define AMDGPU_CS_FLAGS_MASK	AMDGPU_CS_NO_IMPLICIT_SYNC
+
 static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
 {
 	switch (type) {
@@ -188,9 +191,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
-	if (cs->in.flags)
+	if (cs->in.flags & ~AMDGPU_CS_FLAGS_MASK)
 		return -EINVAL;
 
+	p->flags = cs->in.flags;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
@@ -1220,16 +1225,19 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	}
 
 	drm_exec_for_each_locked_object(&p->exec, obj) {
+		/* Implicitly sync only to KERNEL, WRITE and READ */
+		enum dma_resv_usage usage = DMA_RESV_USAGE_READ;
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		struct dma_resv *resv = bo->tbo.base.resv;
 		enum amdgpu_sync_mode sync_mode;
 
+		if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC)
+			usage = DMA_RESV_USAGE_KERNEL;
+
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		/* Implicitly sync only to KERNEL, WRITE and READ */
-		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
-				     DMA_RESV_USAGE_READ, sync_mode,
+		r = amdgpu_sync_resv(p->adev, &p->sync, resv, usage, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
@@ -1341,9 +1349,23 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
 	drm_exec_for_each_locked_object(&p->exec, gobj) {
+		enum dma_resv_usage read_usage = DMA_RESV_USAGE_READ;
+		enum dma_resv_usage write_usage = DMA_RESV_USAGE_WRITE;
 
 		ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
 
+		/*
+		 * Keep READ/WRITE on the root PD resv:
+		 * amdgpu_vm_bo_update(clear=true) only waits on the VM root PD
+		 * resv with read and should still sync to avoid unmapping
+		 * before the job finishes.
+		 */
+		if ((p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC) &&
+		    gobj->resv != vm->root.bo->tbo.base.resv) {
+			read_usage = DMA_RESV_USAGE_BOOKKEEP;
+			write_usage = DMA_RESV_USAGE_BOOKKEEP;
+		}
+
 		/* Everybody except for the gang leader uses READ */
 		for (i = 0; i < p->gang_size; ++i) {
 			if (p->jobs[i] == leader)
@@ -1351,11 +1373,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 			dma_resv_add_fence(gobj->resv,
 					   &p->jobs[i]->base.s_fence->finished,
-					   DMA_RESV_USAGE_READ);
+					   read_usage);
 		}
 
 		/* The gang leader as remembered as writer */
-		dma_resv_add_fence(gobj->resv, p->fence, DMA_RESV_USAGE_WRITE);
+		dma_resv_add_fence(gobj->resv, p->fence, write_usage);
 	}
 
 	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 39c33ad100cb..5c2a5f6b1d55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -50,6 +50,7 @@ struct amdgpu_cs_parser {
 	struct amdgpu_device	*adev;
 	struct drm_file		*filp;
 	struct amdgpu_ctx	*ctx;
+	u32			flags;
 
 	/* chunks */
 	unsigned		nchunks;
-- 
2.56.0

