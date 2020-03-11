Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF5020737
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toVa/Xek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF5020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8AD6E9F3;
	Wed, 11 Mar 2020 19:54:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED616E9F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 19:54:23 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p2so4265676wrw.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7t/ca/Cw71Dk+S4jZQnX/kH3L7nf43dvs0is9bTSWH0=;
 b=toVa/Xeko1Ox+862SrtjUJv7cyw1f30If/JG4rhu0EaEPcDnGzCMh1JlxbKkWSGm/r
 5i+8EfQvT8sNv+DtPVduHFRIwMnTjP3n25s+mHdd0jfnm1EaxyEuYkwCH7WXX1/umGV4
 OjcqvHgCyXn/Gm2MtfC25ed2AHWVfJjP97Ioy5pUWHSzu/bj9gah7Qs3bD/LOuZ3BN9+
 uPc5qLDlesdwr0ecqytY+u67Uk8NOZ9pm4Wzcp8W/rMhu3ZmSbXw8cWR3zdFOBeJyQIo
 haP3nvObGOOx7r6JSYCQcAmyaaeDLRfDEKSBol+iqt+NQE980B1DtUSI5RKFz9VqQ8t/
 JkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7t/ca/Cw71Dk+S4jZQnX/kH3L7nf43dvs0is9bTSWH0=;
 b=ZZDteYwTedLJLkswV87ykICYwa+a6s+XS1GwtQUuhEj77Q5TO5Wydq3Y0lbvipDgCx
 SIxSXI1wPPAAW8n2q4JanH0g4KpkhHqyILCUMXkyrMIch57gPJJouJE+xb73PBUKyv5r
 CVE+q1WkF1TKhz0JfmgEdsyqj9f+onHyJ8lYu6GIZrGZNM7ksE8xA/c8Cihl4F8sZ6Cz
 1+Z4JL0EmK+HmsQc3jn+r5TiMiHVD+/K9bqYI9WHdwrhiT+dH71JAkNFAcHj/t59pp5G
 NOC0ZI0e5UV9xnq9cHQ5rM91A61OBvjaaetj7Xz8SoVfG/otUty5IAeVyH27gWxf64UX
 VBIw==
X-Gm-Message-State: ANhLgQ1F9CLQ27DiB9m10TDjMDLC7FGyEJbePjVoVg6MkIUmiPfuw/m/
 0u8Is7uyi2+5U4x9+heZC1u0eb0QcsSLhpKj
X-Google-Smtp-Source: ADFU+vvOe6N54cfp+aD8GxLsRleb249wdU3/npXm/sK8vJRJTe/GcbpZ9xTRn0s5Vv3hRFYB53DjOw==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr6380272wro.207.1583956462129; 
 Wed, 11 Mar 2020 12:54:22 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F28AE00BD65D97DC346E601.dip0.t-ipconnect.de.
 [2003:c5:8f28:ae00:bd65:d97d:c346:e601])
 by smtp.gmail.com with ESMTPSA id o9sm74643425wrw.20.2020.03.11.12.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 12:54:21 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn jobs
Date: Wed, 11 Mar 2020 20:57:59 +0100
Message-Id: <20200311195759.49332-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN HW  doesn't support dynamic load balance on multiple
instances for a context. This patch modifies entity's
sched_list to a sched_list consist of only one drm scheduler.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 ++
 8 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8304d0c87899..db0eef19c636 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1203,6 +1203,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 			    union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
 	struct drm_sched_entity *entity = p->entity;
 	enum drm_sched_priority priority;
 	struct amdgpu_bo_list_entry *e;
@@ -1257,6 +1258,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
 
+	if (ring->funcs->no_gpu_sched_loadbalance)
+		amdgpu_ctx_disable_gpu_sched_load_balance(entity);
+
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fa575bdc03c8..d699207d6266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -559,6 +559,20 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 	}
 }
 
+/**
+ * amdgpu_ctx_disable_gpu_sched_load_balance - disable gpu_sched's load balancer
+ * @entity: entity on which load balancer will be disabled
+ */
+void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity)
+{
+	struct drm_gpu_scheduler **scheds = &entity->rq->sched;
+
+	/* disable gpu_sched's job load balancer by assigning only one */
+	/* drm scheduler to the entity */
+	drm_sched_entity_modify_sched(entity, scheds, 1);
+
+}
+
 int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 			       struct drm_sched_entity *entity)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index de490f183af2..3a2f900b8000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -90,5 +90,6 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
 
 void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
 
+void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4981e443a884..64dad7ba74da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -140,6 +140,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 		      void *owner, struct dma_fence **f)
 {
+	struct amdgpu_ring *ring = to_amdgpu_ring(entity->rq->sched);
 	enum drm_sched_priority priority;
 	int r;
 
@@ -154,6 +155,8 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 	amdgpu_job_free_resources(job);
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
+	if (ring->funcs->no_gpu_sched_loadbalance)
+		amdgpu_ctx_disable_gpu_sched_load_balance(entity);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 448c76cbf3ed..f78fe1a6912b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -115,6 +115,7 @@ struct amdgpu_ring_funcs {
 	u32			nop;
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
+	bool			no_gpu_sched_loadbalance;
 	unsigned		vmhub;
 	unsigned		extra_dw;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 71f61afdc655..749ccdb5fbfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1871,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.no_gpu_sched_loadbalance = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
@@ -1905,6 +1906,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
 	.nop = VCN_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.no_gpu_sched_loadbalance = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f2745fd1ddb3..c48423b54bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1954,6 +1954,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_gpu_sched_loadbalance = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
@@ -1984,6 +1985,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
+	.no_gpu_sched_loadbalance = true,
 	.nop = VCN_ENC_CMD_NO_OP,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9b22e2b55132..1cc8e1420fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1478,6 +1478,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_gpu_sched_loadbalance = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
@@ -1577,6 +1578,7 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
 static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
+	.no_gpu_sched_loadbalance = true,
 	.nop = VCN_ENC_CMD_NO_OP,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
