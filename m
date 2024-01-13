Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A0C4706C
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jan 2024 14:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D2F10E0A6;
	Sat, 13 Jan 2024 14:02:17 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E0C10E0A6
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 14:02:16 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so7458105f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jan 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1705154535; x=1705759335; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BkRH0xQaORaYFC0L9YHXubUjP3FyyFde2/Uyaek8ns=;
 b=asBvp0o7sCIKYzCoFZY3Ktc1w4FB0Q1nqte1ryCZ6gqdbKfnWcdiYO3Na6DNluVsvC
 Wu/8VGqXZfCFZ++3O1iPzGb9JCT9qvZG5j1Qbl+LIFVAwhR4ell03yWQrkPZ/hxefeVZ
 jcaiyayN8tBRo/jS6QOyo+Gylz1beBik8wnJdt+A0JjVxiYHpP0U+pQOKPTv/+mTz+/R
 RV9IkIIHTNIaogX0DvO71WNR5lPelrd8MXzPhasAP6q9dwgqqWbhC62RMQYv9s/CqzBp
 rhahfAzG5uCnJ5EVmsIFKDEsPidnqQW7TOTZnzikUNKJIcl0QjAwZAtjE6jx1FB8fFNX
 +UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705154535; x=1705759335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BkRH0xQaORaYFC0L9YHXubUjP3FyyFde2/Uyaek8ns=;
 b=Z1H7m6N2M0pJjlZIvg2/vr1uryXEOsAvfY0FlRTWqZt4vFbsuDMtHAJpP5MYO1aPKl
 5S0hZ4x5ujGEcyVhNk0xlIY8vUgOtcbImF77EE2dsgOoKjBRf5RUigAkid9YC2NrjkYQ
 WgJZVfVCcax/Bfx/7PALDumCnYizWYow7WoE9CZtWFB9iK93K0dXWqoxiCc17EZXaBQ1
 ksmIpLv2tMq6OGe+1NpC8oohkFDCSK6gB3LsFcGnOvwHsRNGMlEkcMIVw/YgZ1RL9BP9
 AyiDV/BqFTAzEXfeGxdQUEGsU87tUUuHhBYTy389dhjxIuk1+bH2KRXVQa647qh5Jodd
 nXdw==
X-Gm-Message-State: AOJu0Ywj/UKtqug0HDfNbzVTJEcUl5Jaxx58xb72IkeRm8Gc0LZuQwzn
 b8QIKT0CfQNGvbfxnYPilGZBnVPVIkpcv6p0CGFndwo+7TQ=
X-Google-Smtp-Source: AGHT+IFTbWqSwyuSRbOZuWE3Z/J7aa8f/fYQG3u9Ga+GpYjv+X4+9uWCTEMlzYUI3lWMMQL0oNxHzw==
X-Received: by 2002:a5d:4a8e:0:b0:337:427f:e993 with SMTP id
 o14-20020a5d4a8e000000b00337427fe993mr823916wrq.85.1705154535387; 
 Sat, 13 Jan 2024 06:02:15 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a056000111100b003377cb92901sm6756540wrw.83.2024.01.13.06.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 06:02:15 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery path
Date: Sat, 13 Jan 2024 14:02:04 +0000
Message-ID: <20240113140206.2383133-2-joshua@froggi.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113140206.2383133-1-joshua@froggi.es>
References: <20240113140206.2383133-1-joshua@froggi.es>
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
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, stable@vger.kernel.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to bump the karma of the drm_sched job in order for the context
that we just recovered to get correct feedback that it is guilty of
hanging.

Without this feedback, the application may keep pushing through the soft
recoveries, continually hanging the system with jobs that timeout.

There is an accompanying Mesa/RADV patch here
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
to properly handle device loss state when VRAM is not lost.

With these, I was able to run Counter-Strike 2 and launch an application
which can fault the GPU in a variety of ways, and still have Steam +
Counter-Strike 2 + Gamescope (compositor) stay up and continue
functioning on Steam Deck.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 25209ce54552..e87cafb5b1c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		dma_fence_set_error(fence, -ENODATA);
 	spin_unlock_irqrestore(fence->lock, flags);
 
+	if (job->vm)
+		drm_sched_increase_karma(&job->base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
-- 
2.43.0

