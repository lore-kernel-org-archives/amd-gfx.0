Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F77C352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 07:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0421410E032;
	Wed,  7 Dec 2022 07:49:43 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6363410E032
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 07:49:40 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id v8so23752005edi.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Dec 2022 23:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v+gikHeEmzagGWzffd8JDxwNNmGVmOzAoaQmEp0f23Q=;
 b=e55ZO2PWuxbCE8khfRH2sRHL+2yHbdI/KEM10iIX+CAjT5k8vsiUlYiTOSoHXoteEX
 ulzvNkvcFgrFSkjvMmdzeeMvdykV6N2ybOJ9ouYeCZJNykD9VsJ9Y0Qw2USLM5u3Lv4H
 NYz7/3NlramXcutdvQMww2B6wtUD/JiLKtRCJnY3CetDxyQngXUG54g9g3NojC/fdZi2
 PMkzpzwgGZQXGHkGR+285I2C1Wd1ldR4ekJ/NUva6GD+gVQKD8BmQjI/LkHiZPBHTtTN
 K0xkuz7aASoiQGud9Gav0rMuXVvi5uRhOp78RE1jL9WM8D1YkWWibI6ZeDjIf3E4VLOx
 pA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+gikHeEmzagGWzffd8JDxwNNmGVmOzAoaQmEp0f23Q=;
 b=PsJo9ouZqs+Rkc6Hbakblwo6Tey/U1tSS56TMlkIQVQ71GGbnp7cemNUQHflPhkYSV
 5cMSJFCL80+Crph93EUTSV4Fg2GLKkTquC/OfJvuTYG6TNeaf1+jiJMXoXqBFciXX6nW
 mW3DRwm19l4jQkHVoE96y3syPO307CL/0apC07sw+OfUwT6dHH+ch5K7zboSy6LH/BDe
 tP+pQCo8tiRVnyDxqCEABFYOgaWX4zYEMfoe3JGaj1x25LSXRm2Ffo6xWJhtk/Co9IHV
 H5klcnHkzdhfWJHRYH4TiLB6HzWThDugdqDMP0QrQxJ9Z40iMWiX1/OaZqq9kLvxkX7U
 lcwA==
X-Gm-Message-State: ANoB5pnowHXXiYcjpf0G1Uh6RqLBk7A+CouCIRAWC6EBd7dyFkPTKb+U
 bA1q9y7vAytY/l4Hz0opf7Y=
X-Google-Smtp-Source: AA0mqf74nKJ0lgZndwHCXRolJYkMpmlOUoLYQ7Y3OwspGoi1TR+egyAUUUElFwF+cK3cbd/HG9txCw==
X-Received: by 2002:a05:6402:2946:b0:468:febe:ebab with SMTP id
 ed6-20020a056402294600b00468febeebabmr33989218edb.337.1670399378718; 
 Tue, 06 Dec 2022 23:49:38 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 kw26-20020a170907771a00b00783f32d7eaesm8135229ejc.164.2022.12.06.23.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Dec 2022 23:49:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: vprosyak@amd.com,
	Kenny.Ho@amd.com,
	Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: fixx NULL pointer deref in gmc_v9_0_get_vm_pte
Date: Wed,  7 Dec 2022 08:49:36 +0100
Message-Id: <20221207074936.1347543-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We not only need to make sure that we have a BO, but also that the BO
has some backing store.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 50386eb2eec8..afc0cfed5065 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1185,6 +1185,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 				struct amdgpu_bo_va_mapping *mapping,
 				uint64_t *flags)
 {
+	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
+
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
 
@@ -1196,7 +1198,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (mapping->bo_va->base.bo)
+	if (bo && bo->resource)
 		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
 					     mapping, flags);
 }
-- 
2.34.1

