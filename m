Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A1C77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F50310EC15;
	Thu, 20 Apr 2023 11:58:03 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA7D10E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:58:00 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id z6so5788607ejc.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991878; x=1684583878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7Ig8Kl4jd4BfcepntbJnzwhVu/D+8mkocz2CrOFf60=;
 b=hdOuYHTPCoC+zucScPeYcPAa5D4aiciFAhWC5ET9ZYXM9wHmEJY5RmOi2O2xTuq7xl
 lfRwp9EnRi/T41N1OdI0e4ZYb7Ux5fa4/kQp9gJWpEAv958OResVn/gJOGQCVQvA1Dz8
 T30cN8OqHEar/cCkEaY5ot2eGqq8pvQ4eeS+1nyfD2JlVhoED1dLmcz6zPhGJ5vYyHIv
 aXmokwYO/yWk3oyBh3SXCom9sBfmWd6eNHLbtUsYYHsJ48LkKKfmvP2lsO4s4yij4x4f
 Pgie5sSsFcILY4cKECed8xG8Nzo6wI8FHcLT1paZOZY9ASGLL9oTS/aHE1ljxtYJiv8t
 FmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991878; x=1684583878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7Ig8Kl4jd4BfcepntbJnzwhVu/D+8mkocz2CrOFf60=;
 b=FTwJCERsvI1evBBoq2SASaVlq22HnlakxZsV1DJS2VNJNJ6cEHfV3EV1gAzSPL/PlH
 joMvkbNtdoXdj6WUtBBA0+PVXys9AkMQS0+ZxgQlKfbIwzf8oIeI6JFKfHqlgT40ibfN
 vQ27Rc/iPV5dY5rT1xU7vAGfi9sJ4C+MNZ4P3kB72HEqBVFd6rW5TJmkbls30iU0CvDq
 2QrW6egfDaboJIXFb0uQgUVnRecSj7dIMDQ/+tLrXLDTFtJebdQl2w4hAblKqxM3gPZd
 DplzykyB2W0SlLV7hbkRdFx8Kjboi+Yc5Tph8UHIQWY/fITZWDDQ65Rxq5P6UzDD/e/G
 5ZTA==
X-Gm-Message-State: AAQBX9euGGIRe75vtP+5P6ZsCh6cxNyaJ3g2EqikouNnEDCOl+EYg1hH
 d1pjGsS4kojEIATU7thA1JQgXtdw3XQSUA==
X-Google-Smtp-Source: AKy350bJuLpux33ATj/1/sQ2BuxzkB5i90To4UomiLBaqAGxm5NZJymufhbf2wyAEmj+M1vISzDdBQ==
X-Received: by 2002:a17:906:9153:b0:951:f54c:208c with SMTP id
 y19-20020a170906915300b00951f54c208cmr1506995ejw.41.1681991878455; 
 Thu, 20 Apr 2023 04:57:58 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: mark soft recovered fences with -ENODATA
Date: Thu, 20 Apr 2023 13:57:49 +0200
Message-Id: <20230420115752.31470-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the fence error code before trying to soft-recover it.

It gets overwritten when a hard recovery is required.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d3ad29d932b8..083b1020b421 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -432,11 +432,18 @@ void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
 bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 			       struct dma_fence *fence)
 {
+	unsigned long flags;
+
 	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
 
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
+	spin_lock_irqsave(fence->lock, flags);
+	if (!dma_fence_is_signaled_locked(fence))
+		dma_fence_set_error(fence, -ENODATA);
+	spin_unlock_irqrestore(fence->lock, flags);
+
 	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
-- 
2.34.1

