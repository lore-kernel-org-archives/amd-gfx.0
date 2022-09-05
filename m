Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5E7C6FA83
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDC010E366;
	Mon,  5 Sep 2022 12:32:57 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA79A10E36E
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:46 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id fc24so7796779ejc.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=xuQPau6oCI+xeLmpJuQfpUl7wqVwTtKwjGAeMu89Eds=;
 b=G669uc5onrDi0C+6sf86MV1dg//8w6HArfzB8w67j6+1KMQVWcLG7jtXNn2BktVORJ
 +zkuYp0SPdgTWEcLpQqgBE+E6GhQxdYzijSpWnJFgALUwV1AKRfg5EKSzNdVihP7aMxS
 93WY+UfqLF3oZWBXN98kilqA5Ej2gycLGa20Z96UyF5l1ViQCW4ITfJcOSpaRSFQxkiO
 xFLV+XicqcC/jxvjprXKjnJB5n/LPqdcBq+rR79rdstgR5C7IAk5oIaH5UJFeN54HU/I
 tzinPOrDhyknnHn3UMlJ2d052f3lfWc+Tou5gXWbJeNBUiAdRvXLk1ixoZ5xaWFBj555
 66hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=xuQPau6oCI+xeLmpJuQfpUl7wqVwTtKwjGAeMu89Eds=;
 b=VB+T5ZcRBp/4pUuJ5ziExPUP0s5g6WHRuxv7G5MzMcZBZe5X0cghwot0htqPJPGV8m
 h4Ubx8sR2kt3+Q0XbOQKWVBSQtTh43etqESKrMVIi9McRgHtJ1kW6FBChnUF436rL86k
 M0TEt/74+MYzm6686s/E9ajBhOqoiDv3zswXt74sEnTcH56HyGktLG9gUUZ5WOCGNzSC
 aLbRPIlu2vHRa+HR4fKBND8L55lp2GLrFvt6LXcsnjA5WvG0JW8TGJrwchzg707FYWK4
 WRI7+TOeKj5SiIY2Vl7NsPuDZlgEiW4eNjsr/KnuV1TgelLfF1rlFtYkZz0Ir7ycAwkC
 90jw==
X-Gm-Message-State: ACgBeo2RUdvID7k3kKMdywbJBBdwxJDHeLn8awHlXI9nKN8okiINnYY7
 DuwXGpJrJZEqz5REz2J0sOu6Ulodo5h7sg==
X-Google-Smtp-Source: AA6agR7k5Ig5//WNPQNzBxkoxnbzsID9KXpqbDxwgiDZ+5xXtkJta0N5pW8JzPEVrHSGKvCtTMOvhw==
X-Received: by 2002:a17:906:4789:b0:74f:f771:4b3 with SMTP id
 cw9-20020a170906478900b0074ff77104b3mr10933662ejc.621.1662381165325; 
 Mon, 05 Sep 2022 05:32:45 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 12/12] drm/amdgpu: cleanup VCN3 and VCN4 instance limiting v2
Date: Mon,  5 Sep 2022 14:32:32 +0200
Message-Id: <20220905123232.2809-12-christian.koenig@amd.com>
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

Check if the entity is already limited, not if it's assigned to the
first instance.

v2: only a cleanup, not a fix

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3cabceee5f57..5e64c3426728 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1862,13 +1862,12 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
 
-	/* The first instance can decode anything */
-	if (!ring->me)
+	/* Abort if it's already limited */
+	if (job->base.entity->num_sched_list <= 1)
 		return 0;
 
 	for (i = 0; i < ib->length_dw; i += 2) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 9338172eec8b..a8264fe2201d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1430,13 +1430,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.entity->rq->sched);
 	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
 
-	/* The first instance can decode anything */
-	if (!ring->me)
+	/* Abort if it's already limited */
+	if (job->base.entity->num_sched_list <= 1)
 		return 0;
 
 	/* unified queue ib header has 8 double words. */
-- 
2.25.1

