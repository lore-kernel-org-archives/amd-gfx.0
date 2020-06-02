Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B6C206A2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkrUGAJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B6C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28586E1E9;
	Tue,  2 Jun 2020 18:53:43 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADC56E1E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 18:53:42 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id a4so5503352pfo.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HiAFwAghjVM9P4l+Lh5uJQLBJlZFeYnoZU64MZjfDx4=;
 b=nkrUGAJDO5yg/AbY9SNsTfLHpf6QnIb1ItRnTiCTznUWngbfuS0grxk9QAGJpRJuY0
 pfICgQoAOERWIxoyAIv7Z3X2joBcQDulSvKvaaGEwI24QUw8IobMSuSQW7tqlgiSh91r
 HmrSPUzdkT8ImDrgAuEalAoGfe6jdThrykZPBakJYPuL8sOUmohLjuS49bkpjhOwWegx
 0ee4jmY8y7bC50rZUu72K3aEMxK+0rBZj8hoIqkAO9I+phI1lqub2QyxYzQg62eszXsm
 vHArHFnEqC/UaKANXLmLB2lBm++b+oKH78XCpXhi0gsqRsoLjuovY2on0g8PZxdY3gjD
 UiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HiAFwAghjVM9P4l+Lh5uJQLBJlZFeYnoZU64MZjfDx4=;
 b=WkZFGg5kkUtFOU6riUiEyI286JDSwdO7CVORJ9/eRCCm9f2BD+LHi258w1ZiGyT7dT
 bZ1CtaxtxfCmipcRK8BXGd4YlUwEf/LNguEYklqx6pbkx94ZcNta9ziLVMywGb2KASIo
 kEP4rUNl6QLDquz8ERhXa5l/Ru680IIz7hGaIeJMP5OXoSMFZ2XK8TANgbst6eu/Jr8S
 FJliHW1j2kZq7K99EMQunui5Nc21jCDVq10gptY8ac4+CHcgQJMrTW54eVEaQyn29hhu
 fbV8CymR3v31KSjm/SPOdIKg1refLERDEga/++EbYrapwHSHswc2Pr2XISV8JlXOKQJi
 lMKA==
X-Gm-Message-State: AOAM531xDouGMghSc/u/+VCxfuFNk5tnc3HLwPftqOIfOt3cD0fiVqQm
 naEPhyzJF4kg8JVEu8r4DQWMcF4q
X-Google-Smtp-Source: ABdhPJwquKo1qhFBREwueExU/tGG4T2660orUEKBeYZY55Ece3yFv4YQeJzrB+VenVu0a1GDowKurA==
X-Received: by 2002:a62:8344:: with SMTP id h65mr26592036pfe.207.1591124021406; 
 Tue, 02 Jun 2020 11:53:41 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id u25sm1536854pfm.115.2020.06.02.11.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 11:53:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/fence: use the no_scheduler flag
Date: Tue,  2 Jun 2020 14:53:27 -0400
Message-Id: <20200602185327.1303384-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

Rather than checking the ring type manually.  We already set
this for MES and KIQ (and a few other special cases).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 0ce82686c983..8537f4704348 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -469,9 +469,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 	if (!ring->fence_drv.fences)
 		return -ENOMEM;
 
-	/* No need to setup the GPU scheduler for KIQ and MES ring */
-	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ &&
-	    ring->funcs->type != AMDGPU_RING_TYPE_MES) {
+	/* No need to setup the GPU scheduler for rings that don't need it */
+	if (!ring->no_scheduler) {
 		switch (ring->funcs->type) {
 		case AMDGPU_RING_TYPE_GFX:
 			timeout = adev->gfx_timeout;
@@ -543,7 +542,8 @@ void amdgpu_fence_driver_fini(struct amdgpu_device *adev)
 		if (ring->fence_drv.irq_src)
 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
 				       ring->fence_drv.irq_type);
-		drm_sched_fini(&ring->sched);
+		if (!ring->no_scheduler)
+			drm_sched_fini(&ring->sched);
 		del_timer_sync(&ring->fence_drv.fallback_timer);
 		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
 			dma_fence_put(ring->fence_drv.fences[j]);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
