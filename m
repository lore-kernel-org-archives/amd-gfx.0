Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230DC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA719206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOwflxG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA719206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E0E6E843;
	Mon, 16 Dec 2019 17:18:48 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8B36E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 17:18:47 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id x1so5817672qkl.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMQBW3cAS2MrJ3OKiQIxJB1nsv0yBBduRlnMHm7926k=;
 b=AOwflxG+als8JuQOS0P/ggQiju8TadfahmpaNy/jDUXqRQp06VwTWEpYN9UzgiF8+S
 tkUBpavguXgO3Qgfx2ZHaO841ohROUk1CvzcXDNoBIIT0PzoL28SOf7ZPJETr5edgqJ+
 tsfkZa3npoiFwMa9iNKIX/BIzOxJZoDXth+pvgeu/z35/dmrVlkRB9flbvW3mTYSjMKv
 APjuphYHZG+rVYoVP1u6iWx03Ct8InnlNyGqmquk9oIBU0+hCw8x/BxG3UfUUuqJCuyf
 ZeRxP9KijhwwHOntjD9Y6r3PtVDxqmMJ24A3dWkmib0jKt6xywwk3LoxjZoO3ImWMiZ8
 e8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dMQBW3cAS2MrJ3OKiQIxJB1nsv0yBBduRlnMHm7926k=;
 b=inwrod1pFBC88PoX87qpZ0oA9DaFjubCsr1XAU5xINmFPJCOe2libIAEoRztBtMwCj
 XL8R4FnCklbjhJgDfrNLHDkPslfQc3v7zeaA/ggEoPlDNdDX48vMD98fTYR1hDQEXzgw
 PLf1o9F5945zDHtLo+SRkAVbXRcHHA8YrZ4GfwZdbDP67/oBZPs+8XaKWd9nmYi2URBv
 HQvZIYBEx+UsBiSFJmcETMTp9QFNklk+HLWze7AZHcWjT6JTmUaS6jAp4DDefm9NNl1n
 3KEOv0RYCZsShveY4cg30E2zhWZA94FMT75psbkJQ+75N3XgDnN1NKxU94Pr2PM8L30E
 9zMg==
X-Gm-Message-State: APjAAAVJy7LVt9rPKE0GzaP2KllGTVSOf2Wai2T2PYjl6GaWDsGassGY
 U1CRXiypSviOYiDwxH9do0+T3nlu
X-Google-Smtp-Source: APXvYqzENa6OJ+5dOfhkOmZZfMzEdDdGRUjJWUT96LtPRBZ3QAbViFP6mJUB0NqfP11ePUqhFp3H3w==
X-Received: by 2002:a05:620a:142c:: with SMTP id
 k12mr301276qkj.207.1576516726067; 
 Mon, 16 Dec 2019 09:18:46 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id k50sm7219291qtc.90.2019.12.16.09.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 09:18:45 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
Date: Mon, 16 Dec 2019 12:18:33 -0500
Message-Id: <20191216171834.217251-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216171834.217251-1-alexander.deucher@amd.com>
References: <20191216171834.217251-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Increment the usage count in emit fence, and decrement in
process fence to make sure the GPU is always considered in
use while there are fences outstanding.  We always wait for
the engines to drain in runtime suspend, but in practice
that only covers short lived jobs for gfx.  This should
cover us for longer lived fences.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 377fe20bce23..e9efee04ca23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -34,6 +34,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_debugfs.h>
 
@@ -154,7 +155,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		       seq);
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-
+	pm_runtime_get_noresume(adev->ddev->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
 		struct dma_fence *old;
@@ -234,6 +235,7 @@ static void amdgpu_fence_schedule_fallback(struct amdgpu_ring *ring)
 bool amdgpu_fence_process(struct amdgpu_ring *ring)
 {
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
+	struct amdgpu_device *adev = ring->adev;
 	uint32_t seq, last_seq;
 	int r;
 
@@ -274,6 +276,8 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 			BUG();
 
 		dma_fence_put(fence);
+		pm_runtime_mark_last_busy(adev->ddev->dev);
+		pm_runtime_put_autosuspend(adev->ddev->dev);
 	} while (last_seq != seq);
 
 	return true;
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
