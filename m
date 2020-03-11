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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE7C2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1A42072F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2z0OC9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1A42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD786E9C5;
	Wed, 11 Mar 2020 17:14:43 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF906E9C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 17:14:41 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d5so3290345wrc.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IWB1TydoRTTwvwJtyXbXTnZsdy8W5OcISlWGu6bPyyA=;
 b=F2z0OC9v8H+Qx3CrKvV+Gz0udlPgjH8FRU8fT+9M2fB5OI6eUogseZaqZLXeTKXw6q
 G3vxGCROsQGTxFmGLy4Os3H3CTb4j1ldgJx9H7WsmuKDGDMSB9AjG+4qe3gDpelNtM7i
 izzT8BUuHm5P8jet4377JUoKsXek2APuMsijPatnAFABHlyEjFGl63nB18QSNFau9ke4
 NAXOwLyrkBD+HLU6VUdSrZRnxO2B9f1+pO0bdOaR3RVbws9fuwKmxOBNb9bQGbMA5Qzz
 72sO1gB4XUZDK5Jf8xTGI/5oKSyeXBDilPGxfGxVxMOl+e0iL8WqLLim7nwYsWkuYZqQ
 aZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IWB1TydoRTTwvwJtyXbXTnZsdy8W5OcISlWGu6bPyyA=;
 b=HxfDjXBwyuSoVer6SGIjpSzPiPJTX56SDMR6hapKd8hfSY9jjIyR8hCmMXENqBnhsZ
 xzaEs4XJVjzAYUxJXdL72G9R9pU/ESU0eJ5fcZpDQVoV7ieVJFJFqjvj7UgInDnsSp7F
 icihk0Tgjl63FVLESRAJ+kO/BD121rqn2oqEh8BL931jh4ANzNFnCAYScr7uZcEJmW/b
 4B6sCPH+rt0/Vhp7nnocfLttux/pg6aj8TQG4bhIBAnhX8cF3NT861zlW5p/c6l4eNq4
 oOJnZsrQ6PUF/JiJyL7ADgvRYj2eevD49TcK38lQ1Nso8kv8fwxN+WhENU59FfTXJDv8
 yAUQ==
X-Gm-Message-State: ANhLgQ3DlHp6HlwfN0M/Wozbef5kS4ft2E8I5xoNKzePP0dyGGv28xI1
 9mcmLQ8r45gx0Y4fyrEoMLnQDdGvYV1q5wtN
X-Google-Smtp-Source: ADFU+vuN0Xid7Z7+IWfu3j6Z6KSzs3AOSyH46w0Gd7NhIzCVQlOn6+2c2TsHpyrjOCOR1S+nTDj7BA==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr5389537wrw.321.1583946879876; 
 Wed, 11 Mar 2020 10:14:39 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F28AE00BD65D97DC346E601.dip0.t-ipconnect.de.
 [2003:c5:8f28:ae00:bd65:d97d:c346:e601])
 by smtp.gmail.com with ESMTPSA id y12sm8630814wmi.48.2020.03.11.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 10:14:39 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: disable gpu load balancer for vcn jobs
Date: Wed, 11 Mar 2020 18:18:09 +0100
Message-Id: <20200311171809.7115-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200311171809.7115-1-nirmoy.das@amd.com>
References: <20200311171809.7115-1-nirmoy.das@amd.com>
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
instances for a context. This modifies the entity's sched_list
to a sched_list consist of only one drm scheduler.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8304d0c87899..00032093d8a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1257,6 +1257,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
 
+	amdgpu_ctx_limit_load_balance(entity);
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fa575bdc03c8..57b49188306d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -139,6 +139,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
 	if (r)
 		goto error_free_entity;
 
+	entity->hw_ip = hw_ip;
 	ctx->entities[hw_ip][ring] = entity;
 	return 0;
 
@@ -559,6 +560,30 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 	}
 }
 
+static void limit_vcn_load_balance(struct amdgpu_ctx_entity *centity)
+{
+	struct drm_gpu_scheduler **scheds = &centity->entity.rq->sched;
+
+	if (drm_sched_entity_num_jobs(&centity->entity) == 1)
+		drm_sched_entity_modify_sched(&centity->entity, scheds, 1);
+
+}
+
+void amdgpu_ctx_limit_load_balance(struct drm_sched_entity *entity)
+{
+	struct amdgpu_ctx_entity *centity = to_amdgpu_ctx_entity(entity);
+
+	if (!centity)
+		return;
+
+	switch (centity->hw_ip) {
+	case AMDGPU_HW_IP_VCN_DEC:
+	case AMDGPU_HW_IP_VCN_ENC:
+		limit_vcn_load_balance(centity);
+	}
+
+}
+
 int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 			       struct drm_sched_entity *entity)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index de490f183af2..d52d8d562d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -33,6 +33,7 @@ struct amdgpu_fpriv;
 
 struct amdgpu_ctx_entity {
 	uint64_t		sequence;
+	uint32_t		hw_ip;
 	struct drm_sched_entity	entity;
 	struct dma_fence	*fences[];
 };
@@ -90,5 +91,6 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
 
 void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
 
+void amdgpu_ctx_limit_load_balance(struct drm_sched_entity *entity);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4981e443a884..955d12bc89ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -154,6 +154,7 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
 	amdgpu_job_free_resources(job);
 	priority = job->base.s_priority;
 	drm_sched_entity_push_job(&job->base, entity);
+	amdgpu_ctx_limit_load_balance(entity);
 
 	return 0;
 }
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
