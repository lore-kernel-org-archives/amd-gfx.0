Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E78C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C237A45A5;
	Thu, 14 Jul 2022 10:39:15 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C705CA4583
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:13 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id dn9so2633818ejc.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=PiqsjVMUpPHBZqTcJvTbCFraRXTEDfnTLkTgNu/pyM1D5/WrKaSzkNOUPntNCflu2B
 /WQX9cYA4omkFbzMaIvKyDRzZf9mRzDXmE6jWSlj1h+lm+IeaCnIfvGTpqopxn0m0PVB
 NeqWIzXUvV6822QMFa2KIdMd7tkeVr5LdkEa8g2shbzQarTyZmnO2EUUX9yTSiny56zI
 fYlMteCZ+lLoDtbDUPYaiH+BdjTIHpgNyba2CeDqmY/WIv3yhjMM3soOStqgRn/FiGB1
 N8l3gzTgY8+9Nvc0i+q1kGb2j9XT0ixpCo0O0LVzD3V4xK7f+VEBJyGyNywQNwDROjJj
 y7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=SkZOr8gdE4j/eluLnYU/zm6kilxdpiXbmuD+lUJGpzjVC6Q9rnObYCxK7E5cwMAbyp
 VGksngjCwy6ONee6B1zW6h+CO2uuxzcuDXMyppORRVqruGlhgRsZ0EApVljg6ZhjwR+j
 12Dl9pa2eQQQU3dgeTq2TlyHP6qkq4euRqX51cSgB0UsOCBC8sVMiMDm3pxIew/xREY1
 W8sGWugJ5dgjXUG2dGjYytxBn5wLwkYDtTcUMDZOzdebrLlVDxmgQXEjduVYwD0dn/tm
 qk3BKvPviA4hwwVl0Nd6IdgZwE1wt0G+hS8g2iPYlXIMWTJwXTzLEM5euibC7THI9Rnc
 t4Jw==
X-Gm-Message-State: AJIora/2J7if5+xINqzhVNnaxgrEmNxNkcdUFjeY4ax7YHXU0sFiszlp
 BqkxwnEKm1mUJBAFVA64eJmb7p3hifU=
X-Google-Smtp-Source: AGRyM1uOEIfv/pP21lskt3SUb6jsKzkHH4/qDJEk4+BRNWSDO1Ue3ZDeZTxF1iiUT9b+/FiEY2sQBw==
X-Received: by 2002:a17:906:53ca:b0:6fe:ae32:e01e with SMTP id
 p10-20020a17090653ca00b006feae32e01emr7936428ejo.455.1657795153416; 
 Thu, 14 Jul 2022 03:39:13 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 08/10] drm/amdgpu: revert "fix limiting AV1 to the first
 instance on VCN3"
Date: Thu, 14 Jul 2022 12:39:00 +0200
Message-Id: <20220714103902.7084-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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

This reverts commit 250195ff744f260c169f5427422b6f39c58cb883.

The job should now be initialized when we reach the parser functions.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 39405f0db824..3cabceee5f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1761,21 +1761,23 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
+static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
 
 	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&p->entity->fence_seq))
+	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
-	drm_sched_entity_modify_sched(p->entity, scheds, 1);
+	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 	return 0;
 }
 
-static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *map;
@@ -1846,7 +1848,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v3_0_limit_sched(p);
+		r = vcn_v3_0_limit_sched(p, job);
 		if (r)
 			goto out;
 	}
@@ -1860,7 +1862,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
@@ -1879,7 +1881,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			msg_hi = val;
 		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
 			   val == 0) {
-			r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | msg_lo);
+			r = vcn_v3_0_dec_msg(p, job,
+					     ((u64)msg_hi) << 32 | msg_lo);
 			if (r)
 				return r;
 		}
-- 
2.25.1

