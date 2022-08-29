Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9009C0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D0810F269;
	Mon, 29 Aug 2022 13:18:46 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33D510F1CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:34 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id p16so12503425ejb.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=n8ReaTFDY60fVNZT4Kec3ZDRgvAYr90eGg8sGzGskjNVLPg6xK3+7L/UVp8ORuB+VL
 cEKzdoQlQivV2KcqOEjxsmgDYGtWAiwWfvdn1Q2n4x/T22Y7CDNlIXFHo37GTh2sGSjE
 XT7ql/mE4dv7/UGhpwR2UxY4pQzMGstLV0GpocWkwhCh94CS3ovLKFLQ59YEEZGstp1G
 IEujyn0qFHWBDHCH2Uh6rexsK1DcDulpo9SsKRHgg43vwUQAKzVPx5FHx7VJVkFw53On
 lOb0Cm3rx693uGmrjfNUPoQB9ABuLB3gnC8G4IMhniyXWilPhz1ds+XukkzYGk6k3aZV
 CBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=e8tdSPdfMZy2XhUPs+eTNveZ2txqo4ZA2fD5kc+j2VH4WbBKXuLDqL5F63Z+hiCZ8Y
 X0wU49tcr1F+WEi0+HpFtehusp52Uk/mE4R7CSS4xCrPIpPSsqx5dICLvMd6aH0C7DgP
 dXyqzb5L7L4px0rbj8almDZxapfnd0ru39b61wB5zNyjFRnO705nYsmpZsRSzRGey97e
 jdaY1Qr6JUEOyjsUTfOJBaAk+MQAzbC+cuuZx3IwRcXup16j7amO33EA9jjGeHdB7gIE
 0gcGE5XF6KFECoav4AMuR219AvboVCahnohqOa9WeczyjN8W0Cv0Y4EAqH0TJ1pta5iX
 110A==
X-Gm-Message-State: ACgBeo11HPvd+adXkxim6FoUS3yii37RW9Niz2ue7jVia+tJfRpz2nzU
 G0jHRuwBCTVhh8FHm6guYMY=
X-Google-Smtp-Source: AA6agR4fYz3fmbZSPv6d1S1eD8VUFCd4RxbGoyjRpkb4ebh54ihNmIQAirt4fk1Q7Jz7Go+HmxrtqQ==
X-Received: by 2002:a17:907:a0c6:b0:741:d9a1:e2b6 with SMTP id
 hw6-20020a170907a0c600b00741d9a1e2b6mr130312ejc.99.1661779113490; 
 Mon, 29 Aug 2022 06:18:33 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdgpu: cleanup instance limit on VCN4
Date: Mon, 29 Aug 2022 15:18:18 +0200
Message-Id: <20220829131821.2049-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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

Similar to what we did for VCN3 use the job instead of the parser
entity. Cleanup the coding style quite a bit as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 46 +++++++++++++++------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fb2d74f30448..9338172eec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1327,21 +1327,23 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p)
+static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
 
 	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&p->entity->fence_seq))
+	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
-	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
-		[AMDGPU_RING_PRIO_0].sched;
-	drm_sched_entity_modify_sched(p->entity, scheds, 1);
+	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
+		[AMDGPU_RING_PRIO_DEFAULT].sched;
+	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 	return 0;
 }
 
-static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *map;
@@ -1412,7 +1414,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v4_0_limit_sched(p);
+		r = vcn_v4_0_limit_sched(p, job);
 		if (r)
 			goto out;
 	}
@@ -1425,32 +1427,34 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 #define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x00000003)
 
 static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job,
-				struct amdgpu_ib *ib)
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.entity->rq->sched);
+	struct amdgpu_vcn_decode_buffer *decode_buffer;
+	uint64_t addr;
 	uint32_t val;
-	int r = 0;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
-		return r;
+		return 0;
 
 	/* unified queue ib header has 8 double words. */
 	if (ib->length_dw < 8)
-		return r;
+		return 0;
 
 	val = amdgpu_ib_get_value(ib, 6); //RADEON_VCN_ENGINE_TYPE
+	if (val != RADEON_VCN_ENGINE_TYPE_DECODE)
+		return 0;
 
-	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
+	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
 
-		if (decode_buffer->valid_buf_flag  & 0x1)
-			r = vcn_v4_0_dec_msg(p, ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-						decode_buffer->msg_buffer_address_lo);
-	}
-	return r;
+	if (!(decode_buffer->valid_buf_flag  & 0x1))
+		return 0;
+
+	addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+		decode_buffer->msg_buffer_address_lo;
+	return vcn_v4_0_dec_msg(p, job, addr);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.25.1

