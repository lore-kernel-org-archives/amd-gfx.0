Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41B8ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA9710E378;
	Mon,  5 Sep 2022 12:32:51 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E877010E363
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:41 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id fy31so16797642ejc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=qXmGcJlmxwlng38fO6I3e7LppXqMdrj+MfREyLEPOJdADxrUPKiPi9G/mYBwgcGPw9
 2oGkHFeqXT2Pd0EfWPMO4UzRvCNBwgNk1n5pvwV9LBwaprHWc5NF2nYkoVaOOFTJPAGg
 DWIDPrzFc2k6r0UgLIO6FJw11jUoQJZGebqM1Qy2x8V2Eib8G3bXEauo/OzUTnNdRIEc
 cyMzrFHi13Da7m2j2p96ZwSAMhqSZcEDJC/AkoGBP1ZyN1qrWfdZMBrH5Lnn9X4H7lLS
 8u9AKPyBLDBNycIGamgciVzANhEuhFI1Sp0lnR4iM+1gPLdqg6VJVH9BTbydbZbd+oBK
 G/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=4Mlg8SNenojv5du91e7ivEc66bi+kpLMZV1+eTAZtpqoXKyjPksp4SuMgnefLa4pBF
 ccFhp0EasJoH9Pl/AruZNgW3Wr2srCO1Imdw1pQHLmzYAnb83p/ooq2f91/SAzIM4bt2
 3G2LNcrGBG0lWzBnLfrcxafszMcQRBM0CXp1hxGEdTB0X0izQV/Ps5JGjGRKdbrg0o73
 ITGWBavAnQ85a1Ug2pALsVs4GtETu4+UALwbghRGLGa71xXNlRbpMFJGh7GWLuhCBRjZ
 9Zt0PbEPOURQAZzdkHpp6BK3kLPXuu0/voD6ysyVveTWJJy9ugqBQGHKHyJY2N5XRlie
 hvLw==
X-Gm-Message-State: ACgBeo1UdXq4218tLjlYfmuJ6md+3o7A/dfg2r+WPIsQK5OZcMaBRzyZ
 rRy+hRMcoEY1RLcjbqyX/c3L7qJKSinntg==
X-Google-Smtp-Source: AA6agR45ADVpSK8FJCwW+mpJMESMm+Ay1dTVcH7/8pcjh6rBnhcHgUQULRXE42gJhgbPseHwMRzpoQ==
X-Received: by 2002:a17:907:2d0f:b0:731:87d0:13aa with SMTP id
 gs15-20020a1709072d0f00b0073187d013aamr37118143ejc.142.1662381161567; 
 Mon, 05 Sep 2022 05:32:41 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:41 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 08/12] drm/amdgpu: revert "fix limiting AV1 to the first
 instance on VCN3"
Date: Mon,  5 Sep 2022 14:32:28 +0200
Message-Id: <20220905123232.2809-8-christian.koenig@amd.com>
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

