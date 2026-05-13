Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D380CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA23B10F04E;
	Wed, 13 May 2026 20:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUl77BCb";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F31D510F04E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:28 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso4247746f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702667; x=1779307467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYCmm8NK5Wtph6CtZuOtMAw45jWQX6uKEnuhmk4zeUQ=;
 b=OUl77BCb5+wuOC1S0b4kxm5JZQkBFrkLxQdSIaIeiSrFR+pY39bFGAmKcrWZj20uSs
 HB7pkE46SCkQA/Ns4VAIwRk5FRCKJqXHOwoNn2iIQXydq+bwp+lzsFExOLbfNUOS8Qp8
 OEmsuigigx0a+Ep5ac29NYTjrGualkVnBXewYVf22/GGVsqc/8a9nqMgfrsB4T6Gi0j3
 mJQ0DwPqD1Ofl/CvuQ1WFNHXYUpahgnaqhYkR6ecYIJLs5M9tPttfzcaUTSs7Y8oumew
 jz412dR/sB/Jjqjymi9p/qr+bmYDCYdgJTTAKh5aIxXn9A2uurV57/iw9FnnjaLgSSMP
 MWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702667; x=1779307467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FYCmm8NK5Wtph6CtZuOtMAw45jWQX6uKEnuhmk4zeUQ=;
 b=qldtF+1uYd5sVQFBmJL8IHcvSRKgql1q+h1Xa7h4KzPOzHhHgncfwlkCiwSkVpbwHp
 cCZt2guOxyGE6hgA5pPD9Pxcli5YthcaJxcXjO82QEs3TEf7fIPm/ESbh9lnXLarKyzf
 jgaEWZKlPzBw4ynsxGWsSZeSDG4mltBTJBGJrn3n6jZ6UNBOYsbr6bdOGZ48OC2s6FKL
 qb1ZTLDe505L7Zj9wl9aP5tkZe9421BbSMhjyp8LJWzBpn08Y/CBrFQ6FFYfR6sIaIfU
 kD0aRw4gRDpri/z06Wd/uvF3fSbH8LtBFXLTA4NX/aw5Vf6f9JwVwYgBTiUWMhm1gSwX
 auuQ==
X-Gm-Message-State: AOJu0YynUHGCH8T+YQULdgMKzeJUrMZn8ZKt57AbK3mUW69Qo/KZ8N1B
 JkkY6mG+CqJAwEvogrw1lIRpWvMYHvHH/qdFbv2ZfVd2CKSHXgjwwltuk19LSQ==
X-Gm-Gg: Acq92OHoVwozzoCy6FKsrOKqCOQUY9xhUow9VfTgKKRz5wOxmX460FlFcxTrJHuSlDr
 aJf9bolxRu7+3qTp/WWt/Lgnk63tjslbvYC4DM45FSkMH+BF+LhRh7Np1Y8WR/a8z9ul+pnDPG0
 nCh/cW0/+98a8x/DSQ8D8GtdrMGH7zo4/CEkdR4uzFGRBNtC0fpujCyqvRi6xD1TAZK2BhmNBDY
 0TKkaGsEau1d4HWcYx/KKUiQg9zQYa/Bil2Lw7pQ4E7+VMIFHAUboHqrouIuANL8hJaRVqpDQ78
 WVocIjz9pch57F88Ew2vB4eUIjSCqL83ztdJWpBFvk8RLXNQzgrRkKRXSwHYdTeK5TvDQLGNfwe
 8fR7Ugn9W+ptXTU4azI9vNmXn55UAGWxtls7b7vXb9sa8EALRf/DTfOFRAZoJJE91FMaax4GuuS
 DO0fLbTYInG4mbT6nn9I/xyY29z8txAi43l8fC2VCxFByv74odqEgsI3POw7/Yo5+ctVaq5tf8/
 yU=
X-Received: by 2002:a05:6000:26cf:b0:455:cff5:9178 with SMTP id
 ffacd0b85a97d-45c5859f0d8mr7576627f8f.9.1778702667428; 
 Wed, 13 May 2026 13:04:27 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 John Olender <john.olender@gmail.com>
Subject: [PATCH 9/9] drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
Date: Wed, 13 May 2026 22:04:16 +0200
Message-ID: <20260513200416.35631-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 03d79e464f04..c69f7d82060f 100644
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
2.54.0

