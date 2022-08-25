Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD32DC64E83
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC6210E0CC;
	Thu, 25 Aug 2022 13:32:27 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0FC10E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:56 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id u6so21066584eda.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=Nui2P8IA5tmUu9bnmVRb87Y8xCyO07/8IlXwk25uEltN8VZlddoTC+VJGjcLSTZtVz
 f6hy069nF2WX4d8YhfNJQVotpdfCjI4pAmuQWey+nUwYLFI1VZGPcsTQmI44BU5DG11I
 8Cq3lVx/XctgpCrh3DSuf8v7C/Q/Jqre4p8t5E6mcTCJWvC9x7gmkDvvKTgDqh9i3eMh
 LQqZKNjBBL3krEtsT9hvCMr8Pmdtlncm8TvUUZ9wFpk5Pzr6pjJbMaz7KnVEWx8URFxq
 2AkuFY8eY19pseQGemzZJGuQKnqDxl4AFCHtSs8+5kbYFsl2Qk/BIf9I8gM1Wm+VgOwG
 SPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=QEEHOcVX9jcWEvEnHDVnuQFTANJGIJsGfJ2gHsBc/Ng=;
 b=dcMpYfBARn8t7U3CvQEXRxw/NNQW+hCHVdiP5424wPgHhP4HBp+4VHKw03x52omvFx
 cIWjzbcQhwHG1OrH6MNQWS3t1WZCpZYz4EgaDTX9hxkMJ+tebW54jkiGSQNyDV2jIO/o
 GlTOMxTfiD+oA0gFf9VDiOGktUBgWiQlPJtM2NRYwVkd2oQGNdDS8sOSOOCMeKw3p1Wv
 p181tLv8khSh+v5xRekV7Pk+K4KvBo8KO3ELmTgNZgj3tr+pgBNU7v96nzAjkprVeibC
 Y6MQMNWxPC2gELeiOQ6xAz0Nkcea9Wmh5uazcaX74yW6TCjZL8cCVSJa7iSJslmeaUD5
 duHA==
X-Gm-Message-State: ACgBeo0jyUABD7t4DHOx1n0apy+VnsHd5HArHUrzY4LKduuxiFXIDLZj
 hiF76xMtsALCdGL8MO4HFiGqt5tdIEZZtg==
X-Google-Smtp-Source: AA6agR4uNoxRJyHzsvp+qAZcRI4ZbSIuRvDeJrELtLNjloed+xwI/bl2e528Q/Lbm43gwf7rev+qHQ==
X-Received: by 2002:a05:6402:1d4d:b0:447:67b:2631 with SMTP id
 dz13-20020a0564021d4d00b00447067b2631mr3193062edb.243.1661434314390; 
 Thu, 25 Aug 2022 06:31:54 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/amdgpu: revert "fix limiting AV1 to the first
 instance on VCN3"
Date: Thu, 25 Aug 2022 15:31:38 +0200
Message-Id: <20220825133142.8272-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
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

