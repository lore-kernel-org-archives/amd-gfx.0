Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F75FAD3E6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E320A10EAC8;
	Thu, 23 Apr 2026 01:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tIBedd86";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B7A10EAC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:22 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so48908455e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906981; x=1777511781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNT0tJHr0pW1bUGIFJfYGreBPGubBlb/WQJBFr3ABwc=;
 b=tIBedd86Dc5Jy04sPuMXypT0jyBJ9dJnan1+fJpjhH24glpNSXzJz1B6hhXGSnnq51
 kUk/iuZ0n9rI2JJG1dAX3lmXbPBbzqezAUeP8G/TrrQADMP55zNrsdY2qjefjd8D9dNj
 cpPtndDunIx5lrVibgycUeXssfY1lLmceSNKdCatpezex0EjIpvJJ53PdL8uvUa1ADmr
 nKr4VJJ06LhTsUAq/OGRwkiWwtK24TqkR66m2H7i0OUAjB9o4t6BA5fgmKpDmSxI7nRm
 RBZGZ6BSF+nUiHiWHxug3h+GtCUEG/UclWm7/FECi49/joF9xCCarrd6BhH/VdLUzEph
 DCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906981; x=1777511781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNT0tJHr0pW1bUGIFJfYGreBPGubBlb/WQJBFr3ABwc=;
 b=WiE9WwQ9zWgQ703NAcNmWpkLc4OfFmSKMhlljuCriVN0fpO3Y+AydogiiMm61hoKA4
 fkDtgFJW/7r8gADD5PlaR0G0UC5VEeTWgSsSuFAVy/YJglgAkKN/ZqEgF3+KtirVzkQx
 R3XUlh/k/GuAXUwUwzs20YupcDknzgzriwN0cHcOS2cJUdiFB7NSO+L+XnNY7PXYQF8b
 1ccwaJKqgwN/6Agec38Zf3YhtH8LRiO8pZDGdMvSaWXrRzJIq8Vd78kI6i9MrvvLAECo
 f1fKiXYD6xVQKo1q8NgNPw0/anQ5jl5Z3sXBMCn2UUiDGOeM0oi5NzOAj8TDkDK4eH1s
 VW7Q==
X-Gm-Message-State: AOJu0Yx3HOhXWS4VlDAmRcQUXmMkSrnG7Aqdyw9jow+/FY58eo/YM4AK
 HmmbSu/L0LvSx4o/QSvJklnr4GO/ng5EyR79fCEZEn+54o5cCLh2TfjgQEVtFw==
X-Gm-Gg: AeBDiev85eIMcsRS90FWvjyJt+YmVdeRaoiz6PLEBMojJ8GzYIGmUxUsiLAeLrjyrxM
 59rKRPmxP2yOq+CHDuI7/EG/npeYCldaEB9+dyf94E9zXf3M4/aD3F13FIZUelS5HHTJMeT9rwA
 MJy0HgdpdxDA3h4HcubVEd5VQtDcIFJJokekTexWIpOB6vKq/4HwB0gzAqru1qTc4a3tm844INB
 du9pJaLUdgiMR2Zgd474g9aCmYmZECCdx6zxvWFsGSQzGwf2t9hDkEFVJNSI/ooPuo9SnNqGIGD
 I5owXtOyK+aULaPFZceg13flJ/JxsqpBUqYMC1tQghFVdSJ/t6VGlXgH57kMJU+dLdAMIe6Am/G
 AtrNKDGHDi+8DOaHhauiK7zdDdJIpa+TgcMh7anvUDICVQ8xtDUd5qtnpimTl2LwE35H30Y2RUU
 LUs99xy51gboCr9nhYyfkBrZhaMa/Fgbqyq3dtruTg35/2YZ3vLwrYVV5szXez+P1UmgRJ9ny9v
 24OzQ==
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr327642545e9.26.1776906980965; 
 Wed, 22 Apr 2026 18:16:20 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:19 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/11] drm/amdgpu/vce1: Check if VRAM address is lower than
 GART.
Date: Thu, 23 Apr 2026 03:16:07 +0200
Message-ID: <20260423011614.309180-5-timur.kristof@gmail.com>
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

Previously, I had assumed this was not possible
so it was OK to not handle it, but now we got a report
from a user who has a board that is configured this way.

When the VCPU BO is already located in a low 32-bit address
in VRAM (eg. when VRAM is mapped to the low address space),
don't do the workaround.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 884f24be36859..a49f11be74b20 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -542,6 +542,9 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	u64 vce_gart_start_offs;
 	int r;
 
+	if (adev->gmc.vram_start < adev->gmc.gart_start)
+		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
+
 	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
 					 &adev->vce.gart_node, num_pages,
 					 DRM_MM_INSERT_LOW);
-- 
2.53.0

