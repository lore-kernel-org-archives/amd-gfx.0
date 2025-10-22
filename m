Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA01CCF9E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB9F10E8BF;
	Thu, 23 Oct 2025 07:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t7F0onkJ";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB1910E74E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:03:29 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso6572481f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131008; x=1761735808; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXsoFSKSD+Jxnxd3GCdpg7hzwIK45uE+7Oq4mebbZTI=;
 b=t7F0onkJcM00pWfyJdh1a8Ijxm6qwYd+uQJBqCv6rlQPOhrWZ3ngNGEQDWH2GVeiRj
 3htd7yzrLpD5WbgzLIjQq9jISsjxmyP4mCq7V6XvYm2eBP+dSVDpg6/pQcHeyxgSgFD9
 xEEr5bLdg8xwFwb2/3B7V8tvzISsrS2KNfb6GHQ+/FUNIV9vQAKKt/GnY+gsSdlLAAfo
 YTsdOYq/zngalwhEt6Zi5hKtXp9u6hC37ZeYuxrJFkl2y3M/WpRPeTyI4iR48rvIFeY6
 I32mgo4JDFqIKerVDZgM3z1I3I8rXqJL1Um6Rky3tmwr/J3izr1QV+b7xjziAQAUsWYb
 M1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131008; x=1761735808;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXsoFSKSD+Jxnxd3GCdpg7hzwIK45uE+7Oq4mebbZTI=;
 b=Hr0lJhUrZXlMOLdmgFtKV6tcb3oQeTwz4Ns6oFBXTEgsSMv956lotjb1JLRfImk+Lv
 7KovUfC1E2zHBS/9JFjF8kJy/DlmHN9xloAHFywdkWRwJ6AVSos+loyfZc6oAKQkbs9s
 hTnc6pkQOLylJTXHv3wbiXni6VucCI1jcNiO1VFkjCkP67MiCLHNkhTKstMe85+5a2G5
 kXJuM+OXSYY1n9oLHWDYHX+QPujKZlFsvrS/rYCnvgEBKch4/D4KeCtzDIi6SSaCTkH+
 pmc0v9hclh/AgKSbbVtdwbEnUO1KcinndNhTdcjEE2TV+7vw8vH9eP2WqEGGHh/HR13t
 Vynw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoQ7rysKDWHLuEMPalKCVNqPz+PeXIECCQB6VTzveKOWaZA9npRFxXoy8A5A586VzOFN1vWBpv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX0DhWAuhijt2nQ9Qp/lDqmpWmGcBsGHo5DWpqzxbN87UvmOwR
 hjz4yWAO1vDVoxg1GeVkKp3Lw7O+CHZmSyD1sFAAnPkt6D1TvcdabpUFXeydNyflx6c=
X-Gm-Gg: ASbGncu07LDErH5Os0I5dYu8b/I4nsH7KllaCGRGMAKY0nMfovqVyQ0dQNYgs+SctT6
 gXQPIfgKWPEFDDPlCGou2BJ/uSNo7yvMi86IaWj3PEk4Dr9ZXnZgGnOxt02KMki6OTVNMfYVKxb
 WwzXdtxfsiFsUpeQqss6TNqu9aXB5Ef932iOq3QJq5x2yC/0SUJwqZBqBQpzzZdyhVkaSM8G6Wo
 prlbdu59+eqBKj0R7bpyj54SQhIipBDoiWMvjykT8N5bjtOH8lgNRZFbnQWuOzL8UGrpjjExyqz
 J++dKUo4LKr2vR1nQNCtxgVHCO3Goc1Oyo0rEFqn1IPsYAZGBnGohrTHVVVANDLkM+kxKCjXwr7
 l9VF8xAeDzaATNazJNtVerASGkJmEh9oQ+zDM/JFFH8yNWTPWXm50+rLpWDt8URURaGH+ouUggN
 BdqLcB00AhPXAVcacJ
X-Google-Smtp-Source: AGHT+IGqGsmmm51ejlY0k7sOzKGZrFx3JPVXLYQMM7eHv3uJuXOnG04Xu33Xnd/PMxPWMzgUajg6yQ==
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id
 ffacd0b85a97d-42704da9e16mr13267011f8f.36.1761131007920; 
 Wed, 22 Oct 2025 04:03:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-427ea5b3c65sm24546043f8f.15.2025.10.22.04.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:03:27 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:03:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu/userqueue: Fix use after free in
 amdgpu_userq_buffer_vas_list_cleanup()
Message-ID: <aPi5_CILMKn3ZrVd@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

The amdgpu_userq_buffer_va_list_del() function frees "va_cursor" but it
is dereferenced on the next line when we print the debug message.  Print
the debug message first and then free it.

Fixes: 2a28f9665dca ("drm/amdgpu: track the userq bo va for its obj management")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9d4751a39c20..2200e0bbf040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -159,9 +159,9 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 			r = -EINVAL;
 			goto err;
 		}
-		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
 			queue, va_cursor->gpu_addr);
+		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 	}
 err:
 	amdgpu_bo_unreserve(queue->vm->root.bo);
-- 
2.51.0

