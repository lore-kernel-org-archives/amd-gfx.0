Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC55C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 10:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE8C10FAA3;
	Fri,  3 Jun 2022 10:21:12 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AFF10FA6F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 10:21:10 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id t13so9795201wrg.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QdT7qmTqHRj1pwwDHYGCrlsIEYCWJ2CBunw9tOz730U=;
 b=BaUMkVODFtgvO8huKrbXzdME7UEueQzPKek2Ph60yo5/dhCmFMeo6aF2mQfZrqYmvW
 AxhcIbut/lNrTLERP9hZhNDOu7h/LqNDCF1vR2qgz3sAeODuDI74bF4hb8KIE/ZRqGW5
 fUhBC3kDUKyHnlMO3dcBZ5qnR25zjFf/wNDiBHXC3cf0NXP8UP6/WO6pmGmnfU1E6AQB
 8aXEk03WhjWo4Ang1PD/EgfVBpGigMGFDdCQdI86/5nyMgE342aaRn3KNydne4vR+Mat
 qXpg4kaA/yxLKaOJstJRCBhj4G7rr/57iSO93WYwKOaMnE86lbv4Wl++Jt65RvN2zHPr
 kXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QdT7qmTqHRj1pwwDHYGCrlsIEYCWJ2CBunw9tOz730U=;
 b=p+RlKkv4tHcaCAzqUP1qNZa7O4TyNZzWNlU+o9749msEz7MIdzGT//HPGCRBwlDtdt
 dLVqWnssNMEJuXnoTRXrjov/H5Cftq9kMMrXQ4wWo2WdMrpTOq8ldX3OTD9hPmsiEqkc
 9F/ufDbvFC/0YHiW7jM9J/GLobZj1hNOKYtq2ZQ1hmB4JpWm6OFAYACTD09jmtwy2pmV
 umNnlrpbSBeWdmvBAu4MxNRfE2Wm2j6E++RCTNACufbtRG/Pb7IzJGYbrFwp7VQCs9Tj
 gh6AJ/1o8OR2sJ91QHVv6Rc5POmPhaF4zqfsYY+ITrEzU5OKhqSQ/gT/k0nExyMgEFIl
 s/6Q==
X-Gm-Message-State: AOAM530pvTj0Q1SXcRBe0nI1eFf0Yh5QLRi0MQ4+McpolMi0MfYDdUlC
 en4kB6WWxMG0nN8TQzTpei0=
X-Google-Smtp-Source: ABdhPJzTduaNLqQdSj663PqRqfKu0d+GYpxrggaOmoZnJ5dR7Goj1yBnqHgd86tz1T/1Bxwa5cLHxg==
X-Received: by 2002:adf:f08e:0:b0:213:b7f7:58ff with SMTP id
 n14-20020adff08e000000b00213b7f758ffmr3623989wro.123.1654251668842; 
 Fri, 03 Jun 2022 03:21:08 -0700 (PDT)
Received: from baker.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a5d624b000000b0020ff3a2a925sm8407274wrv.63.2022.06.03.03.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jun 2022 03:21:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Pierre-eric.Pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
Date: Fri,  3 Jun 2022 12:21:06 +0200
Message-Id: <20220603102106.149508-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The job is not yet initialized here.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures directly in CS parsers")
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3cabceee5f57..39405f0db824 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job)
+static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
 {
 	struct drm_gpu_scheduler **scheds;
 
 	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
+	if (atomic_read(&p->entity->fence_seq))
 		return -EINVAL;
 
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
-	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
+	drm_sched_entity_modify_sched(p->entity, scheds, 1);
 	return 0;
 }
 
-static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
-			    uint64_t addr)
+static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *map;
@@ -1848,7 +1846,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v3_0_limit_sched(p, job);
+		r = vcn_v3_0_limit_sched(p);
 		if (r)
 			goto out;
 	}
@@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
+	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
@@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			msg_hi = val;
 		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0) &&
 			   val == 0) {
-			r = vcn_v3_0_dec_msg(p, job,
-					     ((u64)msg_hi) << 32 | msg_lo);
+			r = vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | msg_lo);
 			if (r)
 				return r;
 		}
-- 
2.25.1

