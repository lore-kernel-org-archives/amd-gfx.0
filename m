Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77DFFAD3E7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A90110EAD5;
	Thu, 23 Apr 2026 01:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2juUQxk";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D623C10EAC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488b0046078so54884305e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906987; x=1777511787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbqQXwhcOBJjEmkM+4+OSwnBi1vKWRurNJntEFcabdA=;
 b=V2juUQxkrm7QCRJiGrO/sbDHA2LYkqjOv4m87IACSeNTDQq1vU3ZIjDMqZlgilAe7f
 tOYTfkSqvclmcVsuJgnnas4Gx3ZtHB7O+sT9c8PVq2+F7+xxd0mis2Sxror1m4bTvS4W
 Pz57S+DM+p8deDT27i7rKDyVcNQZAYVnOqZ+uNdDhmrBhklcNj83yo30sOObOFFGfmrh
 wTUrA13welns2X6IR65uG/+HPAi/6dYYnAycf0shpSfsG/3gwlx9nPimzQ+ZtsIeNM3K
 Be2ck+xrfBWe3uSCHGHI5/go7TuZRsYPnh7Jest+RpetEocqU773WfinrYrFTBE1sQzh
 kGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906987; x=1777511787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EbqQXwhcOBJjEmkM+4+OSwnBi1vKWRurNJntEFcabdA=;
 b=r1zha/gbvGiq2K8sENBaFQYov482guqRJikLO8Eu+DVYTv8UoT1CsTpxfXuHSk9WL9
 KzV6FRqDpePrBn8H7bNhEVW00SRaQVryzuebhMji2nM/1Nm/kATsix9U0gksd2xYLqRx
 b7h5Bh0YKiPfmNOwy2HWwBU7AG04mmdjMxLEwkZELFUMaSlVeRfdOLISR4Srk8FJ0tPU
 R2RxkzGJf3pcwiac+ske3csFC7LTIRSIi7pdxTlDve7eCXb/b/MraeIoMvLVJ1LlqTuN
 Lb9AoJwFYxxLWQSeIOMTVWVQJ1MA75ZmnDL9bDKyuxPMkLkzAdaGs6AydQzPjc0vL3kb
 67lg==
X-Gm-Message-State: AOJu0Ywknwm87SlQDdo0gYQh1Wrsub71ZijwJHF2Q4wET0jrmd/SsfJj
 +6IOiGHc751KiQRNSd/3UZ5NHlcMamboddRN2tqFHQ8w0Exx70P775U+8dB1sg==
X-Gm-Gg: AeBDiesewz+/Xo+7kwE3R9VKsje2QgvRkfRHE5FIixbVeyPTwGAIMuiS8DCJVLqIjyj
 6NRnkYM4KVU0ff8eIHhtt0kvFY1unG7ov4UsKFBISlrA58gD5AzszqGLWDrr1xe0Xl52Xiu0K+G
 ix0p+ydlkTYGzDL/3WnnOq4Yv0lVFJmQRxV+6ELwn9KuanKWLa2T+DuwK87tTh9xkWjzCTlf9yp
 dQBvZkS69yWR2fZq2nJKmNlkSUa0p+4nHFkLtGZhv+nuf3shhDHBq+dccXvpcx7KfYo85tvQFux
 4M/466F0IhGyGFsvHp2UOUYk0A+jfx/xF+GRLbaM3qbuqqY2V4udozxbjIVMOPbhkSK6TlZddVi
 +7vNPcQtYSyDR+Fu3sYfLFeJPeEL+om5wkCWPpuqm+aZ9QkLRAI6t5Le6GyxeutkM4eufU9eJ+H
 PjukNZQ4swqGDkIbPO/3eZHsNg6OstlC/ihUkC1RkbGnUhCehkzqJjDv7vgxqU243m9Nulp7UIj
 MCirA==
X-Received: by 2002:a05:600d:14:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488fb7957efmr271426405e9.30.1776906987319; 
 Wed, 22 Apr 2026 18:16:27 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/11] drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
Date: Thu, 23 Apr 2026 03:16:12 +0200
Message-ID: <20260423011614.309180-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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

The VCPU BO contains the actual FW at an offset, but
it was not calculated into the VCPU BO size.
Subtract this from the FW size to make sure there is
no out of bounds access.

This may fix VM faults when using VCE 2.

Cc: John Olender <john.olender@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802
Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 00b4037d4bc89..3b493a2e94dd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -183,7 +183,7 @@ static void vce_v2_0_mc_resume(struct amdgpu_device *adev)
 	WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
 
 	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
-	size = VCE_V2_0_FW_SIZE;
+	size = VCE_V2_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
 	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
-- 
2.53.0

