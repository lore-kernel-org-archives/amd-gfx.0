Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CA9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7640F10EF31;
	Thu,  3 Mar 2022 08:23:21 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C5410EF24
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:20 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id a23so8961024eju.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f2+EWjBpVe7OHomMNdPv4fGwCIt57vK23n5qfMJUqz4=;
 b=KOLclDBVy7Sp9u4zr+iBwtRosUDxRtaKd8A2VsTjL7Os+Q6enelgCzorMZ9LCnOQkW
 rVFCXH4IXf5ohkp7t42quyqM2S3ulN9yeBPjYzkmHjAq4l073fVPp+c6acS609HdiCJY
 X8qed37bcrXL9e8zqwvF6UusL9STKsqV682X3fnOlor3PE7hpzhMpAzcxvqDngxp8zaj
 6+F4Ni1en9ILFwYDbSb6rxdecHnOe3KleHuzBBLNytjM2LcgmOrHnNIwTx1nK4xEcwR9
 Wa5dFyB3am14SOkyvLKp6GHoKBLsXogY1wPbG7jGn+/U8y+eVqJfx9U6pMfwujfluJU1
 vBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f2+EWjBpVe7OHomMNdPv4fGwCIt57vK23n5qfMJUqz4=;
 b=6kVX0sgRQ0l2O7+WAmjAptLoLthchpA9E+40RwD+YSPuD9H6uzBhAizTPudpXasYmd
 GPaYK3RVWkMwosf2ffHDIBy7Wy3PA8z27PeMjE3L2P68bP9I0ObaI0G1y1eUbi9jYP7N
 SS+g0sdNb9+wheC5II6cKb4pSecSwZ1pt9vEL6KWXteUhEdQl0dr21S3iLDPKyn/EnR6
 UhsxZA3haI7lxACEzib1EC6GG81vXREHMr5+JwiF6aYw40ENBDHW0r54Ub/U0FZ+2dU0
 ch/6tBjS5DlhUmAQYDsli3GPc/paRPc3+p6lsmYm9a78b/ORcsEKJLsDYjC1KeAT9Bd+
 Z3ag==
X-Gm-Message-State: AOAM531UP+U/iVzeEzTX5+ELQOXVvn7Epfr2+mL3ZsSP8DIpwpJcf+58
 Mof6LGsePCPrYfU34yt6+OLEiyJnAVZjGw==
X-Google-Smtp-Source: ABdhPJweDxFY4Ep0GD+YnvK79QtyYwpu+GIss8zqBFSFIfNmoRN4e8lW4GDUFGJICtpmo4xvZ+WQbA==
X-Received: by 2002:a17:906:fcbb:b0:6cd:f8fa:e356 with SMTP id
 qw27-20020a170906fcbb00b006cdf8fae356mr25931717ejb.436.1646295798692; 
 Thu, 03 Mar 2022 00:23:18 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:18 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 08/10] drm/amdgpu: initialize the vmid_wait with the stub fence
Date: Thu,  3 Mar 2022 09:23:06 +0100
Message-Id: <20220303082308.38217-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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

This way we don't need to check for NULL any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index ddf46802b1ff..4ba4b54092f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -188,7 +188,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 	unsigned i;
 	int r;
 
-	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
+	if (!dma_fence_is_signaled(ring->vmid_wait))
 		return amdgpu_sync_fence(sync, ring->vmid_wait);
 
 	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 35bcb6dc1816..7f33ae87cb41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -193,6 +193,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		adev->rings[ring->idx] = ring;
 		ring->num_hw_submission = sched_hw_submission;
 		ring->sched_score = sched_score;
+		ring->vmid_wait = dma_fence_get_stub();
 		r = amdgpu_fence_driver_init_ring(ring);
 		if (r)
 			return r;
-- 
2.25.1

