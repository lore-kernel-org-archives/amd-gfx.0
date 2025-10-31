Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E7FCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A5E10EB7E;
	Fri, 31 Oct 2025 13:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5osG8y8";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E3110EB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:07 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso19733075e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918306; x=1762523106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=A5osG8y8qPdV5K2DVMPTQUZVfiEgmpFoO2Cw1tZrw3bRW7Lqq7C7ikXcjG9NU9nkQC
 mai4JkKUrGtu+W5+qjz9xXnI0n9Aijcqaovj+ZDuvS4GEqC+0JZBA+nZCGfOsatnFKS0
 nr5ijSFE8P6Z+0sKOx2+SlT480rzWI6kmHFsArigGpskslsxgvpDW+scKlNCBSpEs5x/
 JchBIe/O3bb5y4nNShKVMEaX+N1aGqpcYX+aUS6zYQljXEeQRs35PNuycL2goccQDU0X
 2IwiH7JnBXgPSzKdgIfK4EbrZS0+Sn99kYi5l1T/jjFtl3w7s7l2sH3Wef5bKjmAfQ/l
 9ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918306; x=1762523106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=T9QVtw5rqEqBnFfvRHqVaCl7ztwXFRSSGiVm1zdbVf+0pJpdO//pVm2GLwxjSVY1ta
 zYW6meI5RDBsdewGFRHlIEf3FfmsFRQAUJaKn+V3AOD8Kj76zC9rdHTAhvH2c3Yzl9/1
 qvfxbVRLz1NI6JDcDq579EEHsOE+7cWIcrQVdLVS1AxAOVDd9EalQqhOJD4hUg4orQ6U
 Dl7MrBrD+slMoqIx8U2AQcsQaNHUh/zmtkz42G0zaqQ8QjeSnlOI+SQB3BPGvZyfaipM
 acKv0PHNHeN7rJ2NmO80JDXxjRB19mS/GeP+x/wmhIrUEL7OrX+9fJoxKfpdjjHsTeog
 tAuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUiL4N3o1iwlKeoSwxImQ4ZvAvH+45+sNKDBBOH6o3Km/S3EWu4EXcdObtmmio01dAhNICPlyL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxW2cBqGmkieJjBckonuYTOxROMMHiwEuU8pro6J488ASB9lCHy
 glb6skGOIko/kwShfLTP+5hc7itfxiyo+PkPpI32Wd0BJzOdesXAV8Jl
X-Gm-Gg: ASbGncvIdqhv2V0EntIcS6KGY8mghEK1rGYjhbVcQOGfrM7X+HIIprTbNNTDUvKas3C
 z4q26ZKbjfoHPos+kki104nGiEn188f2AGymYgRv95YwLxTJHXLK2oZx1K8gKF2B8ulM3HBbxtt
 bXVYB5Jm5zUoBOK/HVpFsPfoMvMouo9q0RZhOlgCRMA3xukaikfWoXyBnawpA9Ufs7cAIfKs/pT
 x1ueVlGzWpGumBcclKHkksq6G9lTHY4TZNVY6XRFxvvd8TLgg8RXS3UIT+yNq31E3f4fP+Y2Jr6
 LhRaETUl520v00HFWUCgxnXqWqeZSaj2cEAVFG5ld3QwMOxQLSbn1wSvdvfF78rXAOKpQDVrqvx
 SrHPEgb8DQc+xUO6PGt/+oNQCI4mdN2zljaJYrrZ/Vpvdu8AmSfLFdEWgjCjFaJxxjXBRZKx7CB
 IlHiwqRL67wGkWT4+P2HGFgjAh
X-Google-Smtp-Source: AGHT+IGQQWhW4KydYllYE96yBXpnJNZb+d0a1/v5j1qYDJHW7rwr/iQL8xbdeQKjOGiZIyvMilnY7A==
X-Received: by 2002:a05:600c:548b:b0:475:de55:9304 with SMTP id
 5b1f17b1804b1-4773089c775mr36273065e9.19.1761918305811; 
 Fri, 31 Oct 2025 06:45:05 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/20] drm/amdgpu: fix KFD eviction fence enable_signaling path
Date: Fri, 31 Oct 2025 14:16:45 +0100
Message-ID: <20251031134442.113648-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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

Calling dma_fence_is_signaled() here is illegal!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..09c919f72b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -120,12 +120,6 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	if (!fence)
-		return false;
-
-	if (dma_fence_is_signaled(f))
-		return true;
-
 	if (!fence->svm_bo) {
 		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
 			return true;
-- 
2.43.0

