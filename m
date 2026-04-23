Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA07FAD3E6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3635110EAD2;
	Thu, 23 Apr 2026 01:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RlCB8Ur8";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72A810EAC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so26107315e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906988; x=1777511788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gp+WOAQVpMscIEdxQZDgT3tXKBjcAfoYHuwrNh22FxA=;
 b=RlCB8Ur8GJZ/AJWYOcNF8vBirKRSZkgkv+Z7UpLEM9grZF/95yDKZo7zJCEqlzOK2S
 lsHd/27SZplLygKYZvFoyA8k30FDspGyyi5tb9Gv99WTRz+lVnN1ai+jxAnyU4SM9atd
 PSnlw+suBj9kpPOfyxSeaTqveFOI/BEGvUsQf+sVxEQwSNUwkLfb0EjoJ9bATal+wI5h
 tvdV1+8qc9Yjq9hJfJPf+OocgWZFRlZY3G2n++xzQzmL4dVFAGjzBFi2UISMQ+kUyYC/
 S9KzTxv/UTOXfIpreU0PkaYWB9gJkZstnDVD+/36HpIJpwNlxUf2WcGexcP+7uMm2A6H
 4ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906988; x=1777511788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gp+WOAQVpMscIEdxQZDgT3tXKBjcAfoYHuwrNh22FxA=;
 b=Jrz+vVzotOmwVqIjS3hzS02ULltw5TBRYKqOXnslFfZr3Zz/zN5wxa8cF1o41Lt80S
 LINFakoegg5lubA/NEYMwSOHqerR2+BUKXj5+bP/yhasdiaw5dNlKjqNBg7GPAev3xHa
 4NHDnkpn7DdTindc1Uf0s+SmEibcVbw3clpcDsf8gM7uUOO+OvOwDgn8TPzWnEU8/iZj
 R78EJbsHDGsWRk7lUBolp5BOt6pyegppATEVNs03b7t6DZ8ZYGfejlfmXF7r98iXjfCH
 gumCvIJnM+WD3TIgs6O8SEH4Alf26Bj8enAzXRfOqtMXEZCKufuFgV58YwAbJaWCvhzJ
 KeUw==
X-Gm-Message-State: AOJu0YxY2D9vFdEx+kLjzLWdnYrwsWJGJkgBqEfHxViryvH3yhfYiSkf
 HXadhhtOoTRWNqtk5LrWMqwhnNXFQo9+WRX1Vx/03mpWoT+MEKTIAKDinkp2NQ==
X-Gm-Gg: AeBDieuBDtsUHjHMUaYzNSoZqXaVdNkQFAilzLK3LDBCNuJA+lsI05JTKIlBZLV3RLK
 8B3pm3ItuU4oRv4WmWyxPSBocK7KjOoL+WYhSVaiasVAN3RGQZ7EgVtbAq3O8ylsSH6rPy2M3mk
 M2zuwKxEm2cxZeqb+zRWYLdCVMBolT6mcY5bv5Tx1LSpzJ9+OFjeuchECsdY2VnoSQOunvkJmw5
 clvq9mkPWq5YGJjj1dRTY0ve+tCADqJkdGHRTq8XwT3YWcfuvwCVJ3iZeup1ErWCzCznsXdl2/z
 3WlLxV7bB7BenlgSiiB1tXu0z3P0leRvihM1R5+NTaTeazGN8kvJcwmOcY7xhyFEZ65fYZjlUHU
 4k9gT+dofzXZzV0AoFS5563i/iEC8/gBIZnVXJzkrbrT7NP7fEdLF7455qh1Wvx/CWn8fM3cEUO
 +1ukuETL2q/LUbp/BCvMKOHbtBE121g5/SBRos7vMFOFBjA3d9sXhl478YcvqZrqt/rRz5wz8XT
 Xtryw==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48a53390f6cmr155733305e9.9.1776906988097; 
 Wed, 22 Apr 2026 18:16:28 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/11] drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
Date: Thu, 23 Apr 2026 03:16:13 +0200
Message-ID: <20260423011614.309180-11-timur.kristof@gmail.com>
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

This may fix VM faults when using VCE 3.

Cc: John Olender <john.olender@gmail.com>
Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 2e97376ff30e5..2b6ddb6bec3b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -574,7 +574,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx)
 	} else
 		WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
 	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
-	size = VCE_V3_0_FW_SIZE;
+	size = VCE_V3_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
 	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
-- 
2.53.0

