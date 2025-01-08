Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9837FE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D7D10E823;
	Wed,  8 Jan 2025 09:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HcJgWbZf";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3B810E823
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 09:33:41 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-385e3621518so7744584f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2025 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328760; x=1736933560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Fw8VzD0yzNSYzpH+cxbP+RQYX/D4Myf+xfGhUHZpCQ=;
 b=HcJgWbZfJ/ddUojNnpnEBTtreuc3JWQKuQis+2br8PomWGzGLGWw9mm9606hsvNTYW
 dUqbtH/aN1K2hxqMf+bMbT/zpjff3t5GfUKcn2kNn4ybSZ0wcMDx0wc0SX9vUdzVOk78
 9CfrX1hZjk/vs5NCX7N33byebInvwelmPnKHahrtylidrC9DCBt8xtC037KrkKk9Taat
 DC3tUbXx2Kk+rp7pTyDJbj3Cpqvwqukf6lyf33MbDms7ARc3QGJErKzSkR4c9QFQTuvm
 oCTvN4rFfrQilli3VJSTFefBz7KkUPTMu1IGJbIYxJesroaJlvNyWN62sf6myIzRbvk1
 QJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328760; x=1736933560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Fw8VzD0yzNSYzpH+cxbP+RQYX/D4Myf+xfGhUHZpCQ=;
 b=volRjUCaATI5EIkdUTju06cyrG6VcLfdAxImjRFB15go8g097DTSbmYmdhG6a+qPpp
 H2X+1HiPIyx28MlaNWF7mJG8W26RhOafSaR9CzDCdAfwFSFoLKm6zfD+WpoWbM5VELYJ
 JfQGIq/KHkD8HtXN4dXVTSEgQwHN0p10224t1OQIuG2RuNA5F+vAuz64SN6tYgHU4+W0
 6GvrmrbZ9Ih9l08OKpLIjSvAH0uxuitqOZI8zxtf4eV7y+ZWcesvq1uqpn8OSn95q+w/
 ruU764Bk5aIFokeKgcqG1ClcwoO7eCu6C/Nt6xWO9wX1XdMAnr8Md3j6y+mFbsFmsBTb
 QoVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBqwLQWUqdLkZRjKTfLMG7seRANUmiclDishrJ0jwhxRsxMhb8K3tZKtk7J8OVmm5BHvTun4z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxCFkdSK4DmOxzvbE/6HZZKssitrNutCfyDsIcIsJpMQq0NAbg
 k53dAJWRdu9fd/rMDly1hESOkUy8cxpsEQQEwNbOtS5w4rB6NiJV
X-Gm-Gg: ASbGncvlKsBlnfOrNUDmswHtpt4Tp28XQx2kgHC97BN7cTb6eCY962TmT6SxEAg4xGn
 a0KtU1zrqfqGJkhAlEGxxIN6j7JtkIgYfSPnHsn9qD4n14xeZ+HSdseiVCAeUgRD57zLdfqRIbd
 9GofScxj93CIPsJxXjtHeaDkpqv+DkgxlHU7UW2zptqEfXB+RyNK+WCCYdEmizCoUs/goIx0G43
 wJ19YOxFdXjXz5FpbR/6Xlhh175YNuC5b3qqMIrxaf9/60ryxyjFb+Hnvux/biBQoOemA==
X-Google-Smtp-Source: AGHT+IExLiIL7GZEn2K2gxGq4GByilU2C76v5iYou/Sb6MAXjC5+2UgfqHtJTwfKZM2XTOm2Px7VOQ==
X-Received: by 2002:a5d:64a8:0:b0:385:e429:e591 with SMTP id
 ffacd0b85a97d-38a8730a6bdmr1404454f8f.23.1736328758808; 
 Wed, 08 Jan 2025 01:32:38 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1528:2d00:c2c0:4511:c405:eb59])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a2311b3c8sm49513287f8f.25.2025.01.08.01.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:32:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: always sync the GFX pipe on ctx switch
Date: Wed,  8 Jan 2025 10:32:37 +0100
Message-Id: <20250108093237.81961-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

That is needed to enforce isolation between contexts.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d751995dc131..e0bc37557d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -191,8 +191,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
-	     amdgpu_vm_need_pipeline_sync(ring, job))) {
+	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
+
 		need_pipe_sync = true;
 
 		if (tmp)
-- 
2.34.1

