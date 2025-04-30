Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF21FC369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 13:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A2E10E858;
	Thu,  1 May 2025 13:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WP/7U1gi";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7584F10E6E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 08:01:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso49530055e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746000089; x=1746604889; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XVsI8LQZj8BwCLrRgRJ4kPnlB5Zuoj8Y+TGCFkKkR4M=;
 b=WP/7U1gisQS563aL7Aqc7+tb1DdzSYPbbKHY6bFBak/sVNILS9ECpg2JwHS1fzTuQX
 nZNDstANvymWalIfsHpcINGaprjYd147EQYMSyBKpHN7Zox2iO8Jf+EcE9FFL8ITLtpS
 rBw4SzMmlvCXaixriE3F2Esr5vaq0548kCLLX/bJl+b93O0u5njtw7Wr6yaXNUypla9i
 aU74kuw+7BTXsw3ZXC3frmuFu5qQOnL9zwns0KGGXqmMmmex8+ustJ1wXZDYA016bThH
 N65zke5qwvGWbsPgWA04eMtknN3JXozvLx1msb2nBF5exJ0tZnY+/KihTGolS80T6Eup
 VfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746000089; x=1746604889;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XVsI8LQZj8BwCLrRgRJ4kPnlB5Zuoj8Y+TGCFkKkR4M=;
 b=CoUTH3R8bO1EcMvqUtl6lXZ8eau+fGzJ5x8eX/pm5F9So5oZTrRl7iz7oBFQfIGkOJ
 1TBLMTJyh/IBlIRS+olV9iEG1E9IBF2qjJwLGTrmAK/8geVZS5ZqfQXJuEKzwLbXM80J
 mdMl6m/xrtVrbYHsMzx9a6Z32FcRFbHUibQTq6R2Gs620F50SEj1+Meu5zVecsVXDlIP
 vv+iWW+i6sSNv7RAnFLXXvAcdk9+Btrdvma3wMqEa2Zu5t+E3ZPZiW/qK3EYSzxPf2FT
 n6BsfQbkVWknO5PwXXqBLgp+cM0+Qdph8loOZZAvApdJ2gSBFhYrrFElZF1ipYhtzmT1
 f+HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWY4iNCMp5xvLUAsRng1qIYqy43g9oiDiPem9A13YV6uyH+3qKzMP0bMvQBwIJX7ldWkEgH0kv@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7P6fxfuOwdqC1YZoJP/9+1ZawTNzVT39xqKVX5I+iJkgJAl7k
 p3Y/gNHNTujqtG586R6tq8h+D0pIJOM0Bhr+e+ocEr7+uuU57PRiSaqELygX4co=
X-Gm-Gg: ASbGnctZoTAlX1U+m62BqckwPAXQoha656G49u3q1zMhBxibjayIurFxBVYmvqwF31r
 vS6TvNkk6hFv7MgrR5+dZODDrNdD8lj8GuwNeBZu1bbq5WzZ+G5nQahi72NO0L0WMuJcSfh08eh
 u9iEZReYehyL2CVGkeWJwxVW7jTCu7qcOy7Djv+IHQFK8MMHB+vcNmwFS0a0yJ5fArV/Gm6l2wM
 C3FHWnHoKWG/BB3uiysiJrYyLqC2MCOuN+YaLpkF57G19GxizZYA1SqRtBrTP2V3FaoozWvIG1K
 mZGmQksp3lefvR1feJMBYgCVpPxutE7r7sUcq6ASsvqbKg==
X-Google-Smtp-Source: AGHT+IGSWw5YzFLfOEVeGZ2sMxce5ruW0SonDB1/HWE46YfPkACQqdVyQiIV6naiuky8x9154Y7AYg==
X-Received: by 2002:a05:600c:35cc:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-441b1f33a80mr15531415e9.12.1746000088903; 
 Wed, 30 Apr 2025 01:01:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-441b2b5951asm15364615e9.0.2025.04.30.01.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 01:01:28 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:01:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arvind Yadav <Arvind.Yadav@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu/userq: Call unreserve on error in
 amdgpu_userq_fence_read_wptr()
Message-ID: <aBHY1IPONYHyybrf@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 01 May 2025 13:05:51 +0000
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

This error path should call amdgpu_bo_unreserve() before returning.

Fixes: d8675102ba32 ("drm/amdgpu: add vm root BO lock before accessing the vm")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index be068e8e37d1..57169a8224be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -373,6 +373,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 
 	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
 	if (!mapping) {
+		amdgpu_bo_unreserve(queue->vm->root.bo);
 		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
 		return -EINVAL;
 	}
-- 
2.47.2

