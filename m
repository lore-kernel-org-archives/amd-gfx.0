Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21570CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C039A10EB00;
	Fri,  7 Nov 2025 15:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xbud4Wty";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA6010EB00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:57:59 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so7613835e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531078; x=1763135878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P+yo75OB9aOzv5vyd6hRd19EJN+7xlOdXgpdpST6mQI=;
 b=Xbud4Wty0wUEdW0QY8hDZRCDVbmQm7qSVK8P/Q+LQOb4JYIv+F8L4zFKJQ1qFxoe/y
 D+//4yKM1lXJbAuS3gt0csg30+yLeslMMfdNlqQ8Kn1ErfZEOQLoc3kgHYwWVLEDPrDe
 S5rOi3WjhA4OjJxT6yjnB/9xgQo9lA4SwhqMNbOas56wjAUW49GC101Goqz0dpsEMK86
 2YPUyTMqSATBVXJHrLqCl9N/EfucxVVQi6mYoRFNKPnl695HRFWKyWRBh6Jn3HbKzCTB
 cSJYQ5jwFPNxHCOrSRR70bmMhspYNMLvqdd97IbsA0nxhg0eJN6T4MkMS2BStVNoWWsU
 baNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531078; x=1763135878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+yo75OB9aOzv5vyd6hRd19EJN+7xlOdXgpdpST6mQI=;
 b=BJu2S5giOB7dDb36zeVZlSEUiEk9D0EJfJnYWzhlC+QE4XQTbn6BVXuX+AqRK4yogz
 Q8phXcGIFxhxk5xPRx/2zftNUCkaF2ZUo0j0xmBD3s42INooJGBjUsEVu35mZAs43FXq
 huWgUB9Uk2K2TEyTFDuvtoAsd6pIP4bIxl3JoWWB8Dcc1Gry6HOiEz3AsyEX12K0amwx
 Y4/JAb83kJetE06nbEQEFzFCo9nAyp2UuPaFPSnhSVf1N0OKh0Cn5tN6Kt9s1Y18TQgd
 78tcbzIP53Xw6qp7do+X+ynf/gxOX6bARruTB5nl/E+t63Wz6tgycByN1/hJagvt12qz
 2iww==
X-Gm-Message-State: AOJu0Yx/Obgzr89xpA9f8x55OgcHah0gSa6cayzV7a9EoXaa9R6jwuYx
 6FewJA93TUyXA+GbfStm/oZyN40Zie2hGGcCXKWAM8VWUMzij1saMu36uwiu3g==
X-Gm-Gg: ASbGncsyW+e+hYFpnCXnqBRsOviqM7USL/FeMnm7KWHp57lVfCb2QOxGho1W4SSTLWF
 gZw9FDMMnXCM5rrAEJVFSlRhWzOFQg6BfEBywpbeclwfiMshF+Fldmlt1ljStkL59qOp+Y8ijsv
 Bcf50M8Mi72RXRxsKujbOB5IR5PEMf66J5+yJGfVRaPboKMtumX7+/vP5YK1Ae3M62T/GtYZcBP
 gZ7RgDqEe85ERNQjGtFlFszITMrJMbGPrWA/41aeKqzlYc5wGoI4/aK/oGxh2nKzbJYBbxOu/Tc
 9Uv5JpY9bgBhvPduKsMIjqP7ZQrZZSvR3oA7kyZunvE3RBP2aiyQwoc4DKNUZzQAu6ZA1I9xEht
 F2OYpjY/2uwuSP/nz1SMWqOnoqWJCim/z2g1K1aKNHdm7n+3FRPyAKVma4EfFqBdtWnl3cECmyS
 KPJmCAs8j/R4aJg6hzxG0=
X-Google-Smtp-Source: AGHT+IHcsJvM396E+K685Q9PqMycQ2u2hUVEey3IbTACnsRsrbWrFXaaSzdSDb5CCY8ZErCV9/jdQQ==
X-Received: by 2002:a05:6000:1869:b0:427:630:4106 with SMTP id
 ffacd0b85a97d-42ae5ac209emr2556077f8f.34.1762531077904; 
 Fri, 07 Nov 2025 07:57:57 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:57:57 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 05/12] drm/amdgpu/vce: Clear VCPU BO,
 don't unmap/unreserve (v4)
Date: Fri,  7 Nov 2025 16:57:38 +0100
Message-ID: <20251107155745.8334-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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

The VCPU BO doesn't only contain the VCE firmware but also other
ranges that the VCE uses for its stack and data. Let's initialize
this to zero to avoid having garbage in the VCPU BO.

Additionally, don't unmap/unreserve the VCPU BO.
The VCPU BO needs to stay at the same location before and after
sleep/resume because the FW code is not relocatable once it's
started.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index c4e9d1862108..3a986e3589a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -314,40 +314,23 @@ int amdgpu_vce_suspend(struct amdgpu_device *adev)
  */
 int amdgpu_vce_resume(struct amdgpu_device *adev)
 {
-	void *cpu_addr;
 	const struct common_firmware_header *hdr;
 	unsigned int offset;
-	int r, idx;
+	int idx;
 
 	if (adev->vce.vcpu_bo == NULL)
 		return -EINVAL;
 
-	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
-	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve VCE bo\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
-	if (r) {
-		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
-		dev_err(adev->dev, "(%d) VCE map failed\n", r);
-		return r;
-	}
-
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
 	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
+		memset_io(adev->vce.cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo));
+		memcpy_toio(adev->vce.cpu_addr, adev->vce.fw->data + offset,
 			    adev->vce.fw->size - offset);
 		drm_dev_exit(idx);
 	}
 
-	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
-
-	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
-
 	return 0;
 }
 
-- 
2.51.0

