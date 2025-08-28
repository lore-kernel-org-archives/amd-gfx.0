Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64842CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1072010E961;
	Thu, 28 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mMvIaxbk";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F65510E961
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:41:39 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c6ae25978bso564836f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756374098; x=1756978898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ej+AAb48HdbebFHcRZ+ZxF/PT+57dEaJQ/VY50vcLVw=;
 b=mMvIaxbkXsg+A+bNS8NdrYEoZDZ5jwTLgX7Ohgi6UYJXsTlKv34rkQjoq6g95xnWkH
 Xp9noB5fIAcWXqW3w3UO22u1vmElTiOFZpXFS8yUMN68kTCu7Tu/w9aOdiG4xf2QzLpD
 PI7n2u/S3Q8GFwyyPij5cnqo1y9PFjD14ojF8+zbPYpBnqBCHKa+ulcZVIT+1o4flbmt
 Uk8QZrTE+y1OMSl4Vh+QKMcYKfdIaFAKz07X8pnqDlmmpwEODNiGB5NffHLkPzNjaqn4
 XEN2uF8FUC/hfQXUitbEN74iy9XBIcfZ9ea1v5zB6U0pmi4YfHUfEzMyNxqWS7Zrz0l0
 nVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756374098; x=1756978898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ej+AAb48HdbebFHcRZ+ZxF/PT+57dEaJQ/VY50vcLVw=;
 b=Bzq0TnmmDnUzPCMcm6oiQnxwAGKPb4l3ksGgeI+/vez2JL8ftDGVTDKHRvzV6jFo5o
 BmvRvmkqmHekHHWQx6T7IldC6/Q2sPVKeM8W6aVlQSSO4J+WFvernQQPj7kZvhQMGSSg
 QO07Vyk8UPd8rb4GVmUDsKnrCLLZb4bA2GOIDztWiSXgofuAHJ3j+nFEyU3L21kOE8pm
 /Sz2xnfjYNaN+YTmVu5RSAm9L4vgI1catio4PYIUT+JRfi++zX9z1hNQUzE9cLbySc3X
 TVQj05GjUkxRXhX9DNpMWPn3Zp2c3wxbqFDc7JeoW2mTYsdoFgAGH833CnFrde499tJB
 m1wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFnMMzimqwAskQmRI6OK9U9SGaUzsNACP4qqRBPqHjwS8cQ31cKXe8mvk/w3DQ/KgSUopgN+Gw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQKERGs1kfGt09n5rpXYYMTtFCT/d0nDx+8etZO86RfR816uH2
 qHJ13YYg0nZ4bRP21B5SJ2bxMn6wrfbcSc5wQ9qhb9kDRjs5lHrD9XOg
X-Gm-Gg: ASbGncugIjFZ6M8lbNWe/XDDxD4z+bXNY07rIvDyA2SArOiNO2z0KQXrKFpKb4EeYnA
 bNDpPKE6zVdyz/8hTqFKk33sP7Xolway5v9SJF+njXckDvhZVxAtw6hMI2CXAc2Hqood64hQUZd
 70DzOqERfgqw0WNGMrXv7uwqJk5dWT0JjL+GVJzcRvGaCEGsSW7Y9Q+6r7wJTghe1S894kqMVHr
 L8ShjyHfUSuV1VL5VPExubXcYllTumtwVR2TzUJlyu+v/INFUMp3oyqEyLBMFRAZ+2MoQoeOqIn
 Wm6e9CXE/zflADXsfLWBypTlTjVvN9zJswPjzAegtBWhs2YGkcbjXIZyLbEDtDuwaGwSD/jEdP2
 XkaocK3WzNDAKfpLsc9muPHwWpsRZ2HzF1nlowBIyti07
X-Google-Smtp-Source: AGHT+IG+yrh2Ka1oVu6gAZ3iDXI9eVKqs3xX+f1+eJILBR0hFou0myqqJUXwAVmjro+KVhUkefNKsw==
X-Received: by 2002:a05:6000:290b:b0:3cd:b3f7:bb62 with SMTP id
 ffacd0b85a97d-3cdb3f7bd7dmr2092821f8f.45.1756374097945; 
 Thu, 28 Aug 2025 02:41:37 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1520:b00:c238:b791:3cb4:3e9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd2e01dd9dsm4941135f8f.60.2025.08.28.02.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 02:41:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add assert
 instead
Date: Thu, 28 Aug 2025 11:41:35 +0200
Message-ID: <20250828094136.40078-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828094136.40078-1-christian.koenig@amd.com>
References: <20250828094136.40078-1-christian.koenig@amd.com>
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

We should leave such checks to lockdep and not implement something
manually.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2..1dec07513cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -616,18 +616,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		spin_unlock(&vm->status_lock);
 
 		bo = bo_base->bo;
-
-		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket) {
-			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
-
-			pr_warn_ratelimited("Evicted user BO is not reserved\n");
-			if (ti) {
-				pr_warn_ratelimited("pid %d\n", ti->pid);
-				amdgpu_vm_put_task_info(ti);
-			}
-
-			return -EINVAL;
-		}
+		dma_resv_assert_held(bo->tbo.base.resv);
 
 		r = validate(param, bo);
 		if (r)
-- 
2.43.0

