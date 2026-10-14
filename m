Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0247CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362FE10FD6F;
	Wed, 14 Oct 2026 12:48:00 +0000 (UTC)
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2062C10FB02
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 06:05:40 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id
 2adb3069b0e04-5bce4e278baso575639e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791957938; x=1792562738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
 b=efuoBxypoIG+cnLDfp5bYMvRGKERnYiJVxtLvOtH2R3oCDqAXkzMQyrjQ38hY60mE3
 YQvqwoOQGtXYmV89VS/4yvTbvjEnlQ1NhCoFn8Qr71hxK1luigW6lgE8rVsMH4EkfFdo
 jw8EppYDWMNpl5esZvZMEJLDBy8Q0xUtKMcb89ufYTm/mgvzaB3ph1HZqSbmX6i+CxHq
 O1Lk7OC1noHW+qlvWLA3IZAWCV1W+stvJNAjuDmWAwsRZj2R4ULcnjrR8xJtzccE7auN
 BYYnIx4SIwDuAoF0yKZhsmZVvj24bMP36l6uuCddMTPuKpFm7O5fkyEgkgkRqgXI6/qu
 S5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791957938; x=1792562738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZKHQJZbsU0Ua86VI1CZpz7LRBcGg7w/QDW/s3ZvmOOs=;
 b=ZAf+52cVCPlLdx/GpSO/TDbQvyNxmcH5e769vasVrn3UQh3kdR5Qv8enVW02QIRGos
 Y+idTuPVwVaMzZW42BariT2utWhlMu5YjYH0+vkh3FbaRE/oiPZyEyDfa0guBupYXcxc
 WIJdzuiHQt+mYuh9W1MlHlV6Xb7jG2OoSJJrUql2AesyrO+Op9brsb92RbcO5nAsYm2e
 1EmZpKWckgE7xNzc51Mk6KKtCZFvgtsTEWT+d41XKvu6jbyyq6eiBn0FnBR1l+wS+EpG
 icB0Z1UxGUz015z2+DFoorHEANvf6Z5aJ0re7SBx6kHY8XSoW5O2CLXcOBYsTkGad302
 BcEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBypU7KFREvlrMx71/dtwcYkOhm7Tnz2ntCGtu0+Jcc4QgkSIiNMHUyiXdBELFHtGC9HwwXFs9nu@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLDTHMk1EbsIVZ2Q3esugbkkJYGhkN0txt4Slo9E5/ZjF/fz3eZ
 phjB/b3YGG8I/EFx+mRVoKnrszcKi85pW1NIzZMIK4t9CdJXvnNL4yk8
X-Gm-Gg: AYBFou0p4yQkxGQ1yo9oefhWvVbluFMS1chz0bIKU7nRJ27n/l8tcAV1J8UoFcC2gb6
 ppbMlyB00G6J//WeU20Vf8tdyfpTuv8u0UMFJ4df1foF1HzoBYOPZH/a/yEkXpl5f8xg9oTBEZd
 G5TX0g9WUUz1u76Cq6WQOSo9CafJM2XeIr5VyJPJq1u/D3B++7tYFcSp6Jk2YoEHDo4L0XQtXD6
 4ZSNgggmIQzlvINYOUsQ7KhlIEHuDa26bUns2/gM1R6uQDiG+yPVazWYQXQ4rmUytPK3SK7l2mU
 38N3mOpldqNUnPre0PTUmC6nHIm3/H60IHAkaWM9+1+T3hfAiR2sLeV8fPNJSz8AfmlD5/2c7jY
 5JMs1NoJ5C+2f7xXc3D3Ir+6vL0Sg7HunF4bOcGN8ytPDcKZSV6pkKm87y0zxGEcEXFceH+PTfN
 E5ULpt9+q1RBlAzHngSpKLc5l6bMgyFhf5ZgiDli9cu5FHkZjrYr5PPR/vPpzI6Pnr0W3eovih3
 JYHKoY4bxVdtoYu
X-Received: by 2002:a05:6512:3f08:b0:5bc:cbe1:571d with SMTP id
 2adb3069b0e04-5bcdd559e1emr4705089e87.44.1791957937938; 
 Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be34c726casm235360e87.46.2026.10.13.23.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:05:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Benjamin Cheng <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/amdgpu/vce: Prevent partial address patches
Date: Wed, 14 Oct 2026 09:05:19 +0300
Message-ID: <20261014060523.4685-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 12:47:38 +0000
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

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit de2a02cc28d6d5d37db07d00a9a684c754a5fd74 upstream.

In the case that only one of lo/hi is valid, the patching could result
in a bad address written to in FW.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Roman: In 5.10/5.15, amdgpu_vce_cs_reloc() does not take a struct
amdgpu_ib *ib argument. The conversion was carried out by commit
cdc7893fc93f ("drm/amdgpu: use job and ib structures directly in CS
parsers"). Instead, the IB is obtained via p->job->ibs[ib_idx] ]
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53375

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0a28daa14fb1..9b0efddd145b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -634,11 +634,15 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 			       int lo, int hi, unsigned size, uint32_t index)
 {
+	struct amdgpu_ib *ib = &p->job->ibs[ib_idx];
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 
-- 
2.53.0

