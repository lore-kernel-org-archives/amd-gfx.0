Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C648C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA7210ED01;
	Fri, 16 Sep 2022 09:09:02 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDC810ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:56 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id cc5so25127227wrb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=cMwI3xPX+Z3R2g0LKdLEzqDB5AX+yZo8yYC8jh9c+HY=;
 b=pnBmFi2n7qLf2tPOlUzp628yzAkwjaegMA3NLZLPADWElVSXSvE4Fdd9KZ+L/0+EC2
 UG3n0dlS8T06tt5C7qEoj9/gY3akzu1Wxe/KRpb59uJMpgYjEth+tP61X7ruIl6XQpIZ
 mj+vHCb9Pi6th6UQ/8Sqf5yQYiyB97i4xTx16Y1Ns8arwLQeOg8bTWkQ6mPOmooDuPmo
 MPFedZSk1vcX9UCwPHTGezUtGDvz0kpXG+miGDF04rPB04qThYUUXWHXvGfhGz7YA7Vq
 9nGzhNv2lVGgWl9uZmzLLDj/R/1aNTDAAWIrKJYakz6UsaKYqwrXQ3grWT8/2M78SwSS
 kewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=cMwI3xPX+Z3R2g0LKdLEzqDB5AX+yZo8yYC8jh9c+HY=;
 b=kufHTmLehhSCBfp6Bpfu/xC3wgFfhorOpiSytAOnv5YJSrur2Qaf0cyLiqvmyfts/N
 buRtPQIRDyH+HHzd5RXwNpW8u1buHZ1l09tAT6njovdCbFAShWD2yKzG9uNzqoI+31tC
 NPH6LvxjWzuCGaKXzqaRupeUmjNbcx+4SMCvf8Fv3Wzx3A10p1Lza5e2MafsNtIFjXYH
 6y978WioMgCy0vGWg014arIh2WpsAh93HQtDWeZDx2Tg9WqmpcgAJNVxSwikpq0JklTy
 0lSPXiBnRgafAZ72UwcYKXr4VWDY1i36y9xnCt7cNhIEc8xZ7J9pEHv8N5QdWin6ZXPs
 OtqA==
X-Gm-Message-State: ACrzQf2LZ3NBvSFROVPjF2rCu9YqH1QzK+33SpC6fVYpFKoM5uT5HcHN
 C9/bt+/qucpfvlwtv+L6OMfy7j82edGT6Q==
X-Google-Smtp-Source: AMsMyM74M0bS45D4xgRFWZbJnNbamB9VN/62x8M3p9toHdfBm+/yZ/YN+R+C8GH8kbgQJygmAURnig==
X-Received: by 2002:a05:6000:1f9d:b0:22a:e096:5a7f with SMTP id
 bw29-20020a0560001f9d00b0022ae0965a7fmr796951wrb.50.1663319334399; 
 Fri, 16 Sep 2022 02:08:54 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 5/8] drm/amdgpu: revert "fix limiting AV1 to the first
 instance on VCN3" v3
Date: Fri, 16 Sep 2022 11:08:42 +0200
Message-Id: <20220916090845.3336-6-christian.koenig@amd.com>
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

This reverts commit 250195ff744f260c169f5427422b6f39c58cb883.

The job should now be initialized when we reach the parser functions.

v2: merge improved application check into this patch
v3: back to the original test, but use the right ring

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 39405f0db824..9c8b5fd99037 100644
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
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
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

