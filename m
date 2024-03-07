Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41208C54E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 19:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFFC10E783;
	Thu,  7 Mar 2024 19:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=froggi.es header.i=@froggi.es header.b="dvQQmOGs";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AB010E38D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 19:04:53 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-33e65ed1c3aso17764f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Mar 2024 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1709838292; x=1710443092; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LWXKpunu86jn1bIdyNB9+U6YjyEX5hm6WSiNR9W/xM=;
 b=dvQQmOGsjWPcN7WXJhOC0GliMukOtuHZ7sPqxagb8yh/VU95m5Oc/qx85pC6I8mXua
 monaNE2Io0wxJ+jnXSyw4u6SgS4Jwki1/ect/uB1Uk+j98mk6hMhTJyyX08++r3OJDBw
 aHXczFhmDp2Q62Q6Ju4S+IjZebZpKkxqPy2HcYTM/W+c8lEYXOapsX6igi5uS21Fcww3
 jYemNl2Qjxl4L5flvXKM3mXdjwb0IIoSj6M1VLR4iQn7C3tmx46hhVBZWhaslTcRac5Q
 XqX6qTlkLlwWYkwjyUWTjTUpLQ8UaA1joRz4CO2Ai/0sCjG8BYZyspmB3Agt4aPVEdZF
 O3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709838292; x=1710443092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LWXKpunu86jn1bIdyNB9+U6YjyEX5hm6WSiNR9W/xM=;
 b=qcsDtigMbE1aedWa1+h7rSaJEZMLBJclcSrp0qPnW+GcN7eFuFiTI+7Q9lbsL5bzwM
 wFPrLktTIYURM41B+CFdhhcKgwF/Z/HSabo+C4vGpWhd27uuRbjxz0kP5QRbg4Uh3mmz
 l0WVeqUDNCYjgqiTvW113LR59h2tpJZYFK3kWjNavJAhJHdTPmDKFnk/WOM2SDcWf4oW
 K62B4DVUHleged6/HcnwVXUXv/F6/05hM++Cq6F6b6fzNE/aQTP12UAtnVyowBjhnvWG
 A0F/WQpE0pb9WsJsZLGq7aMR6DnmNQPNH/K6L2S110urFFdIKS0WrLZw4f9lJX+/jc9Q
 8ScQ==
X-Gm-Message-State: AOJu0YxiNUjNYbGAz/yIrMYwzsaPCmKcgItTxI0tS4IsQ4++W/5GkmkE
 c6+FMZWGMr5905akkwsMgYyc92ebO1YMs83rf09lr/rDbztJkKVjZHbgzbyJiOXZ8e412d8/ASE
 Rksg=
X-Google-Smtp-Source: AGHT+IH4QZsZoTqEIG+t+ka63qTM/aR1gSeTjsBayMBdHIYft3jhY5p/r3fqeu50sYkjBKwIxIaZlA==
X-Received: by 2002:a05:6000:180c:b0:33d:d96b:2615 with SMTP id
 m12-20020a056000180c00b0033dd96b2615mr12686235wrh.47.1709838291813; 
 Thu, 07 Mar 2024 11:04:51 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 11:04:51 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>, Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
Subject: [PATCH 2/3] drm/amdgpu: Determine soft recovery deadline next to usage
Date: Thu,  7 Mar 2024 19:04:32 +0000
Message-ID: <20240307190447.33423-2-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307190447.33423-1-joshua@froggi.es>
References: <20240307190447.33423-1-joshua@froggi.es>
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

Otherwise we are determining this timeout based on
a time before we go into some unrelated spinlock,
which is bad.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5505d646f43a..57c94901ed0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -439,8 +439,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	if (unlikely(ring->adev->debug_disable_soft_recovery))
 		return false;
 
-	deadline = ktime_add_us(ktime_get(), 10000);
-
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
@@ -450,6 +448,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 	spin_unlock_irqrestore(fence->lock, flags);
 
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	deadline = ktime_add_us(ktime_get(), 10000);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
-- 
2.44.0

