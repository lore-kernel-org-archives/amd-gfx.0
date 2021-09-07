Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B80C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D2460F21
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 08:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30D2460F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C4A89D87;
	Tue,  7 Sep 2021 08:14:51 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AF889D6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 08:14:50 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id g16so1111950wrb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LeqDzkOguFWa/Aiqv4vbwDFxhiqkZigGTylkoWp3J7A=;
 b=hdSZQysKR1xDqy1NSgfMaq1KhQ6MUCGTw3rATUbLPl26dlSuIYGwDmFvSypEAFRtsM
 CLgIY9jaTTP/Fg/84a2bG0KibYObpz4kZLbf0skNQLsHAnS3XAwux5khoR0ZllveNa3L
 ZyNwQCYmxB96Wy1Yp9OArWEeD/AgYHGDS5yiTiB5vdg2/6eR6BuEsqScMWOrb2p87bqG
 n1Bzc0l2i7nlTEP2tk9ifbC3OrctB1VYuJFph5yiR6gJgaUhL+xB/ATSgsJj3mEB3do8
 Xupw4XEmgxZ/dgeyOI2NjH0sEFlDn+66tjSqjSj7/CEn4k1pEU7p9cG5z545MJAkpiIP
 aKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LeqDzkOguFWa/Aiqv4vbwDFxhiqkZigGTylkoWp3J7A=;
 b=UYuswlEPncFeqQf4VROiJbhuh++Dgn69A6k9Bz2KWyvnp9ASS0G6RKKS3xFL6xhool
 k3HYRqFQL3bsp+hnM0pS+55Koyr5h6Ezb4kajtgrwQvMECVO1s4uDj34aYPnB0LM9AiJ
 J/91VdzBWS8VjIFbicVkx98Eo5xp2LKhImznhGzZjUM2HgubtY17cRbHSCie2DAhrVDn
 9OFfMn4XJqX9wm8nPtWoZPTetxmLG770t5itSjUJJZ6rj+5NUTvyEg5Te115tn3Cm9Mr
 lwoq1HW2DFK9OrG9xpHOTD+VTKpIlHo/ViEV1D2sH2pogFuW0MVz237xiXfjjLGA16Dd
 V6xQ==
X-Gm-Message-State: AOAM531ZXuKc6B1729Oar7xPrvyo9GXlGuJK3tsfWE0o3cJ4T3rlfHeI
 mY7ua+shnOXl0rLloPOV1JR8uQ6UVkGMT+NB
X-Google-Smtp-Source: ABdhPJyKjeJM1ioGuvYvuTHYBT/bOkBLe2h3e5rMpy1fUNKfLiqR/K3nFfMFKN1fWpbP+Q8R4+lbtA==
X-Received: by 2002:adf:f747:: with SMTP id z7mr17443704wrp.194.1631002489446; 
 Tue, 07 Sep 2021 01:14:49 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 z19sm2012398wma.0.2021.09.07.01.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 01:14:49 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: michel@daenzer.net,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix use after free during BO move
Date: Tue,  7 Sep 2021 10:14:46 +0200
Message-Id: <20210907081447.182532-1-christian.koenig@amd.com>
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

The memory backing old_mem is already freed at that point, move the
check a bit more up.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1699
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 446943e32e3e..e2896ac2c9ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -513,6 +513,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		goto out;
 	}
 
+	if (bo->type == ttm_bo_type_device &&
+	    new_mem->mem_type == TTM_PL_VRAM &&
+	    old_mem->mem_type != TTM_PL_VRAM) {
+		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
+		 * accesses the BO after it's moved.
+		 */
+		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	}
+
 	if (adev->mman.buffer_funcs_enabled) {
 		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
 		      new_mem->mem_type == TTM_PL_VRAM) ||
@@ -543,15 +552,6 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 			return r;
 	}
 
-	if (bo->type == ttm_bo_type_device &&
-	    new_mem->mem_type == TTM_PL_VRAM &&
-	    old_mem->mem_type != TTM_PL_VRAM) {
-		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
-		 * accesses the BO after it's moved.
-		 */
-		abo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	}
-
 out:
 	/* update statistics */
 	atomic64_add(bo->base.size, &adev->num_bytes_moved);
-- 
2.25.1

