Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE5FAD3E6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3239210EAD7;
	Thu, 23 Apr 2026 01:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUanzwCN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925A910EAC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso62789265e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906989; x=1777511789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNrFiRiS0C+430H85dlcsvf8l8wIKdv0ty614aws/oo=;
 b=dUanzwCN0BxhbV2GqHIk+tiWLyOYLCH6v2xbImT67BVuMh5nepvPYTEhEzk3FmMvT1
 uhDRzB1dDst/BdVurbWvzrr3UwrNeNCGcamwSyEk5FeLhD9fnhJySYdnkUHUzZSARNO0
 VDp0tyhq9CejMPYCLnSyNgrp/efsJba6H/cbtKmo1jj/TPkmCDkeDYyk3B9A5aidJKzl
 gdS8qNHc84GUY3lkePyxHfQqgBrqqAEaWB8c/jEt53M777zje6j+EHP70hFDaWB4A5OL
 LcXENdac66Ce9Mqnus3+L5b6lA3ZoBo/NW0eZTrYqjEpX5Uh34yQxmWnaZIAsOdKof7+
 MwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906989; x=1777511789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JNrFiRiS0C+430H85dlcsvf8l8wIKdv0ty614aws/oo=;
 b=dNsbh7ocDILGQ6o/zEXrWN8w/jEAM+MBlwKXP3jSvflJsU36FkDFGm81O2yfLeY0rb
 HaXmrXIF82jTJYygt5vachX+tU2Z1UHBNPV9zQNRSZv1tr4vktBNQD2aX5Cq3S2fGnpe
 YRKWX0gLny4cBmCbxLTLdPSCoL5Exj3qcs6iJs7KxyHCoB8JEd2FADxeBCulqlRpBJXW
 y7CgSrZDQ77fG/PIttq5D6vGPVdfp6lTjIQdOZqiW8o+xE5dYpST/bXnAzQmz3eIb4rP
 uLCj79DRy1wGwDBJtwsCcusR0EMF7Rew9OUn/NNdeU6Kz5tISZICjUVG9A8zMPdvV6+Y
 IivQ==
X-Gm-Message-State: AOJu0YwCUmCnVIgVuHVHQSfOufxM7Vri+qc7Xu/c8yjtVhACMZkKHhs8
 9dzSI1sX1K5AHqjGVmotXnVXvzH7H+ugq8iorgIWO8SgsyLU9nBOy6gTD2LsPQ==
X-Gm-Gg: AeBDieu47l+10ssaBXp9yz5XvI3bsqOSRKoek00qxdcfwgwAGYofkuGq3RIG8NjnVeC
 RGV3dHxMcmepxbeKjG2oN1SytEAHYWmI1fM0aMFcdZP0NfnDOFXlYPX2VWLfsug4fMezxUcc/EB
 ttkuzSLPL47EsKSo/7PwU7r0Y8CG9hG0/gO8lvplKHhumxcaqFe8/q/qmYx4Cctbuk/ZyFw5HaG
 O8umMTODXiHKvJvEUry84NsOkIQj0IlSZ57t4tKjX8a3R4ZKKIrpIhtCm8f3iNFnzkZ1sHK6GaO
 czgRUnsdp8tgcff9ludKGJAp4xv2P1lG4ntpBnSnXH+a+WllD3JIX0N4RyIKkN877kNhtXZJvjC
 tu4TFELdbBrxw15bOMQeHE9M8jDwdEFTBaW0SvhGN/CZM7qUrliRtuHEoNl4LIqe//O1l95/Eiq
 0Nc3ZqGnbsnblaPQVgki7CaHpmIQab0qGX/29Eo3yzpnCCx7MK9Aq3GbrZcJyvU2ZWAqg6co9LH
 4lNKA==
X-Received: by 2002:a05:600d:8447:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488fb8b18d1mr243816185e9.10.1776906989060; 
 Wed, 22 Apr 2026 18:16:29 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 11/11] drm/amdgpu/vce4: Fix VCE 4 firmware size and offsets
Date: Thu, 23 Apr 2026 03:16:14 +0200
Message-ID: <20260423011614.309180-12-timur.kristof@gmail.com>
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

This may fix VM faults when using VCE 4.

Cc: John Olender <john.olender@gmail.com>
Fixes: c1dc356a116c ("drm/amdgpu: add initial vce 4.0 support for vega10")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 3309e7b8f2a2e..eaa3e05a52e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -281,7 +281,7 @@ static int vce_v4_0_sriov_start(struct amdgpu_device *adev)
 						mmVCE_LMI_VCPU_CACHE_64BIT_BAR2),
 						(adev->vce.gpu_addr >> 40) & 0xff);
 
-		size = VCE_V4_0_FW_SIZE;
+		size = VCE_V4_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
 		MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCE, 0, mmVCE_VCPU_CACHE_SIZE0), size);
 
 		offset = (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) ? offset + size : 0;
-- 
2.53.0

