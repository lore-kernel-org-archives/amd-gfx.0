Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B2C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B1F20665
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV6sBeiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B1F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821256E0BE;
	Tue, 25 Aug 2020 14:15:41 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE9F6E356
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:15:40 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p17so7213615wrj.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/7MprVvRSHaL8YlMDusJzLiGVJMTTwvhZJxg5/IsiRU=;
 b=TV6sBeiq/3xmvEJeI+dZZG2lvkBCqfTfV8YrxAW5HBb5sqRmaNiQj+P4LEzGqXOWo6
 lKnFqFgQWfJKXQwOlmKmh4fdQazArqBUsjc+OY37v3DHZ3YDrBtyeCmiPU4E6VXKjj0B
 jG2xReMuMsLveEMYeQEqooS3YtjiMZMoHfjwMRnuldZ4PrViFdCP1lsv9bckfpkeb2W0
 aOx4kyaO7uTQbgv8A3CLAjNH6yQ+Hxjp7nJcbQIjr0vizVeJR/tub1VEFtRimxE2gA7R
 Ou1MA+Q+xpQZZnbdS4vpO5YMgR8VuYoyR6ie4J9ZhABGTx+db4erGCMvTw5PkAgbl0sU
 MrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/7MprVvRSHaL8YlMDusJzLiGVJMTTwvhZJxg5/IsiRU=;
 b=QJNUNirNzCcFIm8dNMqgyQaxMQRgw5IJa+0/reV+Uq6JrXJ9hpViyfHtGlW2DU3M3q
 lvFKC8BJRlpRHboi65lOyDMZpS2tPokQdFvdMYBk0MbbALNTakh+U+wKSG54DI2lLaix
 BnJfg5ifkNfWRqyo0VTCySSc3ONvGN85awiptt0fQlKgGvinBsmGbYT2Gvu8z3D1DurN
 UJsAz2w13UZa3yvw/oqXnlbp+hjQHuOl8mx7uYfI6rOFK5bKKdx98gqJeywNcvHqhnVk
 KwvIyvIOmbmm93h4IeOmT5c37RKV763KgZxz8qUpLFkMEZzrkUDYibHt2WAWrzx0ckvg
 Kd/Q==
X-Gm-Message-State: AOAM530prxnKceBM6kmfEZ8R7w/owNcaVSO7XbCoUjGqO+Q90QR8Sy0+
 JFeT/IBuSirl57E7KcAc+i5KG1+zqxcORA==
X-Google-Smtp-Source: ABdhPJwPK0pmH8rcgszLN5GD1G9pckrlYDX/qNAi/wujw/7aZQyXXZyijyv3IdVTaDsdFSA8Pa8igw==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr10643421wrq.11.1598364938764; 
 Tue, 25 Aug 2020 07:15:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:13a:17a0:682c:e29a:1246:5253])
 by smtp.gmail.com with ESMTPSA id
 c206sm6603299wmf.47.2020.08.25.07.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:15:38 -0700 (PDT)
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: add support for user trap handlers
Date: Tue, 25 Aug 2020 16:07:08 +0200
Message-Id: <20200825140708.1334-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
References: <20200824114916.11808-1-samuel.pitoiset@gmail.com>
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
Cc: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A trap handler can be used by userspace to catch shader exceptions
like divide by zero, memory violations etc.

On GFX6-GFX8, the registers used to configure TBA/TMA aren't
privileged and can be configured from userpace.

On GFX9+ they are per VMID and privileged, only the KMD can
configure them. At the moment, we don't know how to set them
via the CP, so they are only emitted if a VMID is reserved.

This introduces a new CS chunk that can be used to set the
TBA/TMA virtual address at submit time.

TODO:
- rebase on top of amd-staging-drm-next (this branch currently
hangs my GPU at boot)

Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 31 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 20 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 20 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 19 +++++++++++++++
 include/uapi/drm/amdgpu_drm.h            |  8 ++++++
 9 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a512ccbc4dea..6ca5c4912e3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -104,6 +104,19 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
 	return r;
 }
 
+static int amdgpu_cs_user_trap_chunk(struct amdgpu_cs_parser *p,
+				     struct drm_amdgpu_cs_chunk_trap *data,
+				     uint64_t *tba_addr, uint64_t *tma_addr)
+{
+	if (!data->tba_addr || !data->tma_addr)
+		return -EINVAL;
+
+	*tba_addr = data->tba_addr;
+	*tma_addr = data->tma_addr;
+
+	return 0;
+}
+
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
@@ -112,6 +125,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	uint64_t *chunk_array;
 	unsigned size, num_ibs = 0;
 	uint32_t uf_offset = 0;
+	uint64_t tba_addr = 0, tma_addr = 0;
 	int i;
 	int ret;
 
@@ -214,6 +228,19 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 
 			break;
 
+		case AMDGPU_CHUNK_ID_TRAP:
+			size = sizeof(struct drm_amdgpu_cs_chunk_trap);
+			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
+				ret = -EINVAL;
+				goto free_partial_kdata;
+			}
+
+			ret = amdgpu_cs_user_trap_chunk(p, p->chunks[i].kdata,
+							&tba_addr, &tma_addr);
+			if (ret)
+				goto free_partial_kdata;
+			break;
+
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
@@ -239,6 +266,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 
 	if (p->uf_entry.tv.bo)
 		p->job->uf_addr = uf_offset;
+
+	p->job->tba_addr = tba_addr;
+	p->job->tma_addr = tma_addr;
+
 	kfree(chunk_array);
 
 	/* Use this opportunity to fill in task info for the vm */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 26127c7d2f32..1e703119e4c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -88,9 +88,10 @@
  * - 3.37.0 - L2 is invalidated before SDMA IBs, needed for correctness
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
+ * - 3.40.0 - Add AMDGPU_CHUNK_ID_TRAP
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	39
+#define KMS_DRIVER_MINOR	40
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 8e58325bbca2..fd0d56724b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -58,6 +58,10 @@ struct amdgpu_vmid {
 	uint32_t		oa_base;
 	uint32_t		oa_size;
 
+	/* user trap */
+	uint64_t		tba_addr;
+	uint64_t		tma_addr;
+
 	unsigned		pasid;
 	struct dma_fence	*pasid_mapping;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 81caac9b958a..b8ed5b13ea44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -62,6 +62,10 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
+
+	/* user trap handling */
+	uint64_t		tba_addr;
+	uint64_t		tma_addr;
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index da871d84b742..1f165a6295d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -197,6 +197,9 @@ struct amdgpu_ring_funcs {
 	void (*soft_recovery)(struct amdgpu_ring *ring, unsigned vmid);
 	int (*preempt_ib)(struct amdgpu_ring *ring);
 	void (*emit_mem_sync)(struct amdgpu_ring *ring);
+	void (*emit_trap_handler)(struct amdgpu_ring *ring,
+				  uint32_t vmid,
+				  uint64_t tba_addr, uint64_t tma_addr);
 };
 
 struct amdgpu_ring {
@@ -265,6 +268,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)->funcs->emit_vm_flush((r), (vmid), (addr))
 #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)->funcs->emit_fence((r), (addr), (seq), (flags))
 #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
+#define amdgpu_ring_emit_trap_handler(r, v, tba, tma) (r)->funcs->emit_trap_handler((r), (v), (tba), (tma))
 #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
 #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buffer((r))
 #define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r), (d))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71e005cf2952..6b619bb03777 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1079,15 +1079,22 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
+	bool trap_handler_needed = false;
 	unsigned patch_offset = 0;
 	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
 	int r;
 
-	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid) {
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
 
+		trap_handler_needed = ring->funcs->emit_trap_handler && (
+			id->tba_addr != job->tba_addr ||
+			id->tma_addr != job->tma_addr);
+	}
+
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
 		gds_switch_needed = true;
+		trap_handler_needed = true;
 		vm_flush_needed = true;
 		pasid_mapping_needed = true;
 	}
@@ -1099,12 +1106,14 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	trap_handler_needed &= !!ring->funcs->emit_trap_handler;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
+	if (!vm_flush_needed && !gds_switch_needed &&
+	    !trap_handler_needed && !need_pipe_sync)
 		return 0;
 
 	if (ring->funcs->init_cond_exec)
@@ -1158,6 +1167,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job->oa_size);
 	}
 
+	if (ring->funcs->emit_trap_handler && trap_handler_needed) {
+		id->tba_addr = job->tba_addr;
+		id->tma_addr = job->tma_addr;
+		amdgpu_ring_emit_trap_handler(ring, job->vmid, job->tba_addr,
+					      job->tma_addr);
+	}
+
 	if (ring->funcs->patch_cond_exec)
 		amdgpu_ring_patch_cond_exec(ring, patch_offset);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 65997ffaed45..f864b217589f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7141,6 +7141,24 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				    (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
+static void gfx_v10_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
+					    uint32_t vmid,
+					    uint64_t tba_addr,
+					    uint64_t tma_addr)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	mutex_lock(&adev->srbm_mutex);
+	nv_grbm_select(adev, 0, 0, 0, vmid);
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, lower_32_bits(tba_addr >> 8));
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upper_32_bits(tba_addr >> 8) |
+				1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT);
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, lower_32_bits(tma_addr >> 8));
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upper_32_bits(tma_addr >> 8));
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static int gfx_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -8530,6 +8548,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
+	.emit_trap_handler = gfx_v10_0_ring_emit_trap_handler,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
@@ -8566,6 +8585,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
+	.emit_trap_handler = gfx_v10_0_ring_emit_trap_handler,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index cb9d60a4e05e..4fc00f196085 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4162,6 +4162,23 @@ static void gfx_v9_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 				   (1 << (oa_size + oa_base)) - (1 << oa_base));
 }
 
+static void gfx_v9_0_ring_emit_trap_handler(struct amdgpu_ring *ring,
+					    uint32_t vmid,
+					    uint64_t tba_addr,
+					    uint64_t tma_addr)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, 0, 0, 0, vmid);
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_LO, lower_32_bits(tba_addr >> 8));
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TBA_HI, upper_32_bits(tba_addr >> 8));
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_LO, lower_32_bits(tma_addr >> 8));
+	WREG32_SOC15_RLC(GC, 0, mmSQ_SHADER_TMA_HI, upper_32_bits(tma_addr >> 8));
+	soc15_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static const u32 vgpr_init_compute_shader[] =
 {
 	0xb07c0000, 0xbe8000ff,
@@ -6720,6 +6737,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
@@ -6756,6 +6774,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
+	.emit_trap_handler = gfx_v9_0_ring_emit_trap_handler,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3218576e109d..7eae264adb5d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -551,6 +551,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES	0x07
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT    0x08
 #define AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL  0x09
+#define AMDGPU_CHUNK_ID_TRAP            0x0a
 
 struct drm_amdgpu_cs_chunk {
 	__u32		chunk_id;
@@ -645,6 +646,13 @@ struct drm_amdgpu_cs_chunk_syncobj {
        __u64 point;
 };
 
+struct drm_amdgpu_cs_chunk_trap {
+	/** Trap Base Address */
+       __u64 tba_addr;
+	/** Trap Memory Address */
+       __u64 tma_addr;
+};
+
 #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ	0
 #define AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ_FD	1
 #define AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD	2
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
