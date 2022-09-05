Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F197DECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8FD10E377;
	Mon,  5 Sep 2022 12:32:49 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28E310E358
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:44 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id r4so11163771edi.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=jn1gO71NxU94tLvJN8bNYvLhFbUwrmSYjHgRSL/BF9+ODpPlh2V4/BqXWRjdWz4jVn
 GIMoJVPYl1Cmk6LxHaIeskQFy9WuuoLcXuwswHytn5wIEta92l+Ka0QZuI3/Xj52kRQm
 HPGbfboiF3I9aDh48MeotsmkYdZtXOjd88GNOZ6FGM0chtNsgQ8QqVBtfg1fPeWHmQ5D
 kYkZEcPTy+Z3n9QFY5uj1Pg+rU3xsgYuqTXJqg0pSTGcRSZQe0f1Pp4F1y5tRecGcJ9F
 LLUFAF5FOtDKn3epW3iwX78ilVsqe6EeYLb8JHQ24rDUCbWNHSc+4L4BHKc0OavySeDN
 FQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=fRh9GuGZwW6pFU9rf9bdg9MLcufIOaiaACsnT0CxMuC0kIJUvE5qWKM9xTYpntDIPR
 ecuz5wp1+9i346wuaWlNULRFsBe/b0p2jxH99FPm9/0420UuGCJEofE19dPVIVGRfd8h
 9X8pvLE8qnwHPoc4PBWj7VGRcN4+KhvzeaZEc3JIqjw7jhrxu+yQFhKlY1uKhqNLYXf5
 x+ueusFwmIUuXP5VpZYgl7sGIEc5n+3NsyoGzZzkvdOhDQJdSfDDOCSXPT/s3b9niimJ
 t2ff9TaGTb2sIXen07NCQDoljl/jwPwOMk89MISMK4Anet1hbyo74Nh0f210/eeXcUAy
 1i8Q==
X-Gm-Message-State: ACgBeo0EU8RsCyrR9EBi3yoGiiHt8Vm13pEgoAvPjWnaMqwFINKCj+Nf
 z6ocfSHaVM4jPnI+LKAz6nIgiKVuldUTuQ==
X-Google-Smtp-Source: AA6agR47viVE3sQaZXOOZmwGcqdQdvGSzYKQzU3iaG4mBjHOpnvTaQuI3mDTabteJlAXah/z47Uf0Q==
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr43541047edb.133.1662381162462; 
 Mon, 05 Sep 2022 05:32:42 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 09/12] drm/amdgpu: cleanup instance limit on VCN4
Date: Mon,  5 Sep 2022 14:32:29 +0200
Message-Id: <20220905123232.2809-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905123232.2809-1-christian.koenig@amd.com>
References: <20220905123232.2809-1-christian.koenig@amd.com>
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

