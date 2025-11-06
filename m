Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E49CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3BB10E9AA;
	Thu,  6 Nov 2025 18:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZrDTNWJA";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E572810E9BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:46 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-54aa789f9b5so762839e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454746; x=1763059546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cT+d//URVvCaDQGIqsRLhZbuLDoeonR8rNy8BEPdDbo=;
 b=ZrDTNWJA+krNxQTQN38XJquXOugvMtQlKMq/ipaBncpI3aZL1wvlWFa++4ZIZmLBRL
 DaN9jKlPrpkPHIQ38fI6JopINXsgmBx3VXOy9TowU+le3VG/k+GTKKnQW8bk0aAUvfBD
 k8O69R0fY1VyfskVWvQIhru6SB8jfGC8tG7R2+7HSo6loUfzJwQYMgseusKyeS2s2sRx
 YmQge7TjN63e2yDLSDZFLQgvURcZpSUHt/sEgenwRWieVD5nggyG4d2nnLtU163MzKem
 3oSZ2LuTK1Cl6x+WqF3hFQXV5WGXxalX/8ETjxA0LkbhVG0l06ZETpMOfpOoGWm1XF4F
 3fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454746; x=1763059546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cT+d//URVvCaDQGIqsRLhZbuLDoeonR8rNy8BEPdDbo=;
 b=YfAQCJuMEYCBC9nfMsbAUObhPj7oXhpVw61HjfEhqPUUQ14yurKZyIJEaId2N6wNW5
 tAPCjN5x1BEPShZm1HEDZtDcd47Lpp9XOccfKvlmZTzGf+fjoJfRqbBrkff/pIkATqBp
 gNy5kM06dUxPwnq+vrfB+gMoOfbuQx2onwpSPXGtlG6Vf6Kid8bS8jDG8HcoD3CMC+Mr
 uvjaNsbd/rvw7RDs7YvHNtUmhaU7vFE5Cb1Xe0QVGlht8r9bx4Qd0PFfQ6K6O21zl8FU
 i2fZ+j9eTmBVS1u5Vp1JiSlzsvLq9LPaGuPJsx9CNVB5FX80SGhMm9dTl958RxAfNJuj
 ERnA==
X-Gm-Message-State: AOJu0YxdT5U3+S6UcEWJrxkCEEjtMCht5c+jxuf7OuR4qsV0Mz9FRY4K
 RlgCKgl4lIRueuNGN4+rEGl/60RX+bzwF0F1kCWJC7lzX58pdeMfhPWSxQeBrSdW
X-Gm-Gg: ASbGncuIB6Lfjk6FIheT9bQPLfbWRSIVjkzmq0kN3mF+/sEJlyYZjaogMIQaah9iXxn
 Y1XuIgAQRwEAnqNl6OaY+ZjFuJOiuRUw5UKnhlULkmD3hFU7XR0O31xRgJSA8D59+3WNkmFmb0B
 KI1Rck0Cc8xsEHdImdP2GL2HcaDlh55qDxBOfa/hiY8Xn2ZRQ2rC+fcsJCIXtgt/rYPiQIr61ro
 Ym6JXcA6ce5Mj2J7uR+o8eIpQvqJlsRqu2k3SxPcTpViGqLbBDFityxc8lTYO2J4LRZFHL8wF38
 6A6S3r97YDL/siwHQkuKZ7qlzlLFrOf8EPXq7V65KeH02onh/V+bEJA0Ejn6Bvz0k6QnRy56y/f
 nFr+QI0QZpf7AjW8rUhrZSuMud8MwgnZ9yu68zjPNguQuikwo3pKCSqKAC5oCu5phHCcDHEV84b
 aw1KYEOqeBeUR1k6lqBeRs9/3PmxXNdg==
X-Google-Smtp-Source: AGHT+IEh3NCHPgaF8RGz5MTJtX5NKYR2KilkeViV91bFRk9NczFQQnOfCh8VKoFM5LZrjWOv2doUFg==
X-Received: by 2002:a05:6122:4891:b0:54a:9cff:6fe7 with SMTP id
 71dfb90a1353d-559a3ab9462mr265977e0c.4.1762454745981; 
 Thu, 06 Nov 2025 10:45:45 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:45 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 04/13] drm/amdgpu/vce: Clear VCPU BO before copying firmware
 to it (v2)
Date: Thu,  6 Nov 2025 19:44:39 +0100
Message-ID: <20251106184448.8099-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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

v2:
- Only clear BO after creation, not on resume.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd4806..e028ad0d3b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -187,6 +187,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 		return r;
 	}
 
+	memset_io(adev->vce.cpu_addr, 0, size);
+
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
 		atomic_set(&adev->vce.handles[i], 0);
 		adev->vce.filp[i] = NULL;
-- 
2.51.0

