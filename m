Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87F5ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C86310F260;
	Mon, 29 Aug 2022 13:18:43 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD33010F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:33 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id h5so4042289ejb.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=oc41ME1Cf7i2fY9MBtQfxJmL72SFfxji8QMmYZT+wzAo+/9PecLDsQ1tOkz+AIhn+t
 AL2+yKDbgN4G2k7TOi7r+Douk7QARHgUEmaFs3tqvPPbq01V+FWORFQ8ttlDAWfuq/zC
 y4/6pG2zI3fIbfEWUZMRJnsgc4v+qS7hKoSrRZlDlDbuO6LYWAKEUkfG505yuO/hw/rm
 Vbu6RX7lkJPBxUSWD9Lp58dJy9bQQZBPf0hYrMpmNCF3ExwY4QzexI4guJsRXk81JH7U
 3fxsS9etbxvjrBPSCRFGpxz/u7yBtOsRt3DzSORnXRBPfKCUszoDd1xzwvc9KRNLfhdA
 APeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=dmuLSl9KU9DPMLrIgiqq7BrtK2t8BoQP6PGNsC1gZgbMq2bSoKdsXCMg3fA2Z00lwK
 hYdwZFNWfqy0T4uZQkXEXThdot/57hWp8FAaPWe1uXQyC9HGM56SNJ7qNjp6hyri7V/p
 /6oOvQXpX+uSMl4MAd+hwjP2klh4EL6qwtPbHGvVgqLoksuqOVm+xMnmFZZrshlNOK8u
 XJgN1Bg9zZN4wzyP9lyMKtSE8FKdZYjWdnq93dQVEnvPavT48w2zMyeKh2Z7lPPZo1R3
 ZtuUWnCtzPOTiVk7mi7ZYrcU3S6toqeH/UG4tZudz8XEoiprzcG3hAVBzGAsxzGYtCbw
 HiTw==
X-Gm-Message-State: ACgBeo330Yrpg/bq64vH3z2AN7WLlZReAJqnhN8txx+duJtujDmHBQJR
 z981YZFwwMz2ePFnMTzR0DZsF+j/+JI=
X-Google-Smtp-Source: AA6agR7gPgqIkzF9x4ToBHPWPmGMF9UyFXXj38L1iUBUgjY1Lb0oAAG5ejGOqX9JQWOjxbrCnl5yiQ==
X-Received: by 2002:a17:907:1c08:b0:741:9c32:8596 with SMTP id
 nc8-20020a1709071c0800b007419c328596mr2495291ejc.498.1661779112456; 
 Mon, 29 Aug 2022 06:18:32 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amdgpu: revert "fix limiting AV1 to the first
 instance on VCN3"
Date: Mon, 29 Aug 2022 15:18:17 +0200
Message-Id: <20220829131821.2049-8-christian.koenig@amd.com>
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

