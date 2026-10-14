Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A537ECC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 00:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F59710E11F;
	Wed, 14 Oct 2026 00:29:51 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AB410E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 00:29:44 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5e930a11148so2024262e0c.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791937783; x=1792542583; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gCpZntt7rlk90yQDGnnj9e91a6SUbPGGE+tmaduhpU=;
 b=jfNLu2Oee2gO/ZN9UTI7UjW/m2VLve61bEI+ZesYpDHZUw9QuYEFosbc/mwJ+U0ueA
 LzvtjpV2Tq2WuhnHq5QrOTzta4M+v6G8uhAgfTtG5parUR7TI7fQ2ReYcCnpxfUiIJAI
 hswAMk5BQuUz+71rW+dM1xzxQoBU0SQjDSmHxmyCNgSM6FOo34k9mekJukx+dthxJe9+
 2zvjMCVu9OU8rfR7BY4uE043N7KjBFMlJwz0JyE31O5Wj00kwHs5TAeYHrxSYNcRXaBe
 tlgGCdP5HrwCYvejX4Ll40Zn77nR1VccCZvl9wsSfheAzIkh+VX5MSTNa/P7ElL3MLOy
 ia1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791937783; x=1792542583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gCpZntt7rlk90yQDGnnj9e91a6SUbPGGE+tmaduhpU=;
 b=nQnFWJ+u2TI7IAyk5zNAtAkzSjEqlQnaC1pUkg1t5Z2J9+3CrYEXkuPVHJ6BDdB5zk
 lbi0ePchoJdI0itqqXoe9z3ts2oroFkJX2Gf6ywP2ZS31tHczYKvrcYW+Uwj3Eo6a7dh
 qPivdAc9/lCMD1u551DB2RW0M9Ua5JxzM6P0tB/deItO7r9IcQHP8g5olUNzoDxabiHz
 2Tz1dYoLhyKAZ4wg4wvrPcm5lWuKhvnljPn2iVu+2oNA4XexH4zsOxZ9/5svyJosO+Wz
 IeIItTYDLQnwFrSScE9d+Bee04ChwJCPk5m2hxUqXk4Ld3vb+MH+NNu/M8pwSApF/g3r
 UoDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwuZ6xReeATV1dE2/B3ylEszySjmnoUOiyGfZYk5Vb0DvOOCLIdexoEyxwT1goupxc7go0H/ZC@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLHcRXT3QH07WZcIPHTyYeoLI8iy67jNAfCx1fD6O3MRsde1DWn
 +8L7qGdtVreXqqLmxupvrtTuZGKy82ARcA9P8fllArWDQxI8aHHaRi4I
X-Gm-Gg: AYBFou2PYNwKJj1l6hGVgpkSFN/RH9yJN9pItjyK+mtn5waVWSEIHKc0VY/0kBXe2TF
 u0LMkqLWpp0yrHOev9eLl/dMD9+I8zpo6/Kz5CP86Xpq/icafkLRLN0qW2zlF8MchEHQmz7sZFZ
 wfqHJtwl1TC83M2vBun13We8Bg9YIqwv1s3zLyBd+zJMd4eTgb3MaWjid+mTK28rJYr6GuZch/d
 xEfOkUqlKzge3R5bR8iMGiwyXHFZ2yjd62YmigsSRkqKNvK2DtQr+2lGe3pSB9KDNoQkTvXLkrH
 l2MZdL+TaCcR0gJlVZFf5g1UgUFaHDwFCZ7Dep67/bmtiTCZZXieeS4tTTmkQDN1xOYnUgHSJyj
 ddAbGvvAnX2GFZprWHPSh+GA2hEFXhlumtOrXL+kjBzB60zHX5H/R5t62tZvZBI18py2uSe1KDn
 IKNxucht4uSKL2D2wRTqCHF2CDWHXjW0Np7s/sd+HZWw10ghuduf1UxhgFe16HfLWp3RGX9FvLH
 leh911wAO3hGyHZPmwhcCrymB2LdPFlEgVORSTI
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id
 71dfb90a1353d-5e91f44e07cmr4861188e0c.10.1791937783452; 
 Tue, 13 Oct 2026 17:29:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2804:5698:10bd:5700:de7a:f49a:c785:d4aa])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e91cb3117esm10165836e0c.9.2026.10.13.17.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:29:42 -0700 (PDT)
From: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx8: remove redundant RLC cleanup
Date: Tue, 13 Oct 2026 21:28:58 -0300
Message-ID: <20261014002858.172853-1-williandossantosdeoliveira287@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
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

gfx_v8_0_sw_fini() already releases the RLC objects used by gfx8
(clear_state_obj and cp_table_obj). The generic
amdgpu_gfx_rlc_fini() also frees save_restore_obj, which is not used
by gfx8.

Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7f91186ef1d1..088428e41f44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2059,7 +2059,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_kiq_fini(adev, 0);
 
 	gfx_v8_0_mec_fini(adev);
-	amdgpu_gfx_rlc_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
 				&adev->gfx.rlc.clear_state_gpu_addr,
 				(void **)&adev->gfx.rlc.cs_ptr);
-- 
2.47.3

