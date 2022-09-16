Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3F0ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01C310ED04;
	Fri, 16 Sep 2022 09:09:05 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D479710ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:55 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id e16so34949043wrx.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=A8StqY2vzqtVeHwctnMzi2FYkYB+kh+dcOLHCLX6mwo=;
 b=F88NDIHbboKUenzJveimmeB7gS+IE+PscNgH2b/r8oNQnkkF8ucDYoxA7pAUe7euWp
 AxRR3p4C/LMYiAEsdR0bxb+xV96byfKYnCL8ixMfs/Rx+CKStscS9jImihkAESGs2YVN
 rZ5qL4WuKLODZwwOtdYLFct4i9Ua7k6NI8BnVrw1G9/oqD5MYjALzJUMYYQsXWNfJWQo
 UzlcWgIbEQq+kxW2mmt1keqTe+kG2jGmW+XB5TAK9V9cQBVoCH2Em70wVebnWQyJrfjx
 js+HxWEA2D2VPLZ+Qv0F1Ztrt7/Q8HwaWcJH8h9lOQce4C9FQBOgvfUIOWQI4NljKFZG
 38Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=A8StqY2vzqtVeHwctnMzi2FYkYB+kh+dcOLHCLX6mwo=;
 b=o5VmXKxBfrak8O3EtbQWO4Gnu3oxtNMx2ht/ZfXMJ30asQtjjZ7qxOFQSAywd/awNM
 1Vs/Rv7qTBEQWoBBkCfomm8G04h+rPVYK34RNGq58L6x6D4L9/a36f6LFfmVHiUAQeKQ
 KAcjFXwqJi7Esi8vr0dFNJNWqGca49M89IchIRcQrTL7MRPzr8tL2vTt1eQb+j0MTJWC
 cmFUHb2fbrSg2xYKM4SOhyKQJlaFo051nPaJ3SFZhKOq6p3bDDJCfoxxfVlJF0culig+
 fkX+YMxWN7vNPPINZqlEqGasOgwi13aKnKmkriP23l+WCVBWLpgvE7cpo115yslNVAeh
 /GQQ==
X-Gm-Message-State: ACrzQf13W+pYWApg+tss5+c9qPJMMtsopwwyEnVQ+P0e8eHzRKEioNA3
 EbZdlIacu9FqXycK0OCjSwPV+qHgrFGlGA==
X-Google-Smtp-Source: AMsMyM7dnRgqZgWOLSxgLQgXNmeGE3I4TXWxpGOC69uY+V3WDnZOjIBzO2dYLkig69Nfc9GNucznvw==
X-Received: by 2002:a5d:598a:0:b0:22a:47b2:dd8e with SMTP id
 n10-20020a5d598a000000b0022a47b2dd8emr2280645wri.214.1663319335461; 
 Fri, 16 Sep 2022 02:08:55 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:54 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 6/8] drm/amdgpu: cleanup instance limit on VCN4 v3
Date: Fri, 16 Sep 2022 11:08:43 +0200
Message-Id: <20220916090845.3336-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to what we did for VCN3 use the job instead of the parser
entity. Cleanup the coding style quite a bit as well.

v2: merge improved application check into this patch
v3: finally fix the check

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 46 +++++++++++++++------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 09c89faa8c27..bdabe5da8d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1591,21 +1591,23 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
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
@@ -1676,7 +1678,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v4_0_limit_sched(p);
+		r = vcn_v4_0_limit_sched(p, job);
 		if (r)
 			goto out;
 	}
@@ -1689,32 +1691,34 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 #define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x00000003)
 
 static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job,
-				struct amdgpu_ib *ib)
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
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

