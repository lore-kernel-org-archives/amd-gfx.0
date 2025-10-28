Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91616CCF9F1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCEA10E689;
	Tue, 28 Oct 2025 22:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXnI6MHB";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F045110E688
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:59 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-63c1a0d6315so12187448a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689218; x=1762294018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZgKPgMIe2msC2hnGTLXopuu2v+EBVK/7Skjo5gWWuCI=;
 b=QXnI6MHBJo4oFEhl5qAPI2FxO1grJ+gTc2IcdZQgiMTJdtgwzVlUFFJcN8TzUrj/W1
 eT/1IEyPH+sV7NyVvghM1gQZozz+7mvyA+rCyU08xmU60/bypOtfAAb13JVorWHPjYHl
 cTB/rIvC/lSDH21aHjm8eLbCa6zSMOxRoNji0wvN3YaMaROEVlYVWWTINLkSGWICWAjE
 9q2s2dOjlcD2OXQtPGAXu5EI9ACnBa56EwDz9/b9ac3HAXdPVSwdaiRX39S+0cuLX+Bt
 ULjyEloNhy/3JmB3NDtW0Vef6jxdljG8IuazGQ4ihF41gcSY82YlxYpjYJd3eBHriLXX
 WYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689218; x=1762294018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgKPgMIe2msC2hnGTLXopuu2v+EBVK/7Skjo5gWWuCI=;
 b=lIkBw5r+jGqttyQgAZEW5tX6w3uRN1pb0RqeGvTu6qaI7bgWM+2noV72ULWPVrBmzA
 DANPoqeAWKwrdex3oEZCvKdYU5QXnc5qbiBpxJvJCSSRqc1iaaJ2P16uDEKnhugR9z8t
 +SbbX0HfvLlK1Wpq9wRgdTNGW51zA875LH9L1Fj3Dh60eb7e7Tx4jSETBey0rxEB2Ir1
 z22roi9oG4nhnV0BEyu0Awu5UcHUndXQyZ9NuO73NiILkiU2cYyBKukKOYJQNU1fC3XM
 eQFcjDkYgZH+6lg4+vkD+oL5DL4JWSKNBnR8bC+ukiCKlZyk+4scOKZQS6pzEKpsuyUJ
 M5xg==
X-Gm-Message-State: AOJu0Yx0D61NJlnPY6dSxAEjfUawYbkyskHGSt7KmEYwaZ0E9zmf13Bc
 cERuMC6nE2SMSqgQ2M6penGomhx9FlGCm6Pq2eB2TQSgJA9IQvpbacH+e0oBIw==
X-Gm-Gg: ASbGnctsm0DIy94NgphkRkpPZQ4BrAlecYPXfeb1ZJxByTTVFQrD1j0/Fm4rW2qu7jh
 GukJmkMRcLW+7kPHbnqNaZ66eHH8u/Y5P8fIz70sL2UvR1C8vAcPnwPxtS5a32FdHQfuWleupsC
 iExURZhF2BXVKxOidHOMXBGaZwjIvWLVEhhu1fq4gIkr+OkQUnqbRmpJ/5OlZ4OAVadW6V/vNoH
 VuGbUeBv8AEZzmeMaiLMIZBXk5Ct2epUncVQT8gID8xmXEa8M9srnVFlJq8X1k8uPry9/DiaSOu
 KYgFungANQ9LXkIJ8HNZOrcls4WGnLowK2Rv5ewa+gJKGU4HpxwMufI12Ft7Ixo2PzejPPImOq7
 AeAE6OZWSy0ck3Skbx2fZt94Lf7VEcg45M6HiV1pW/pJH6frpnJnV1fPIPsRX3B/5+Sq2xEypAl
 uhy+Yyo0u3qSkAAxdF9Ltw8Ko04h8SoZxMesv56BS44gcsnyvI8mNHKuyoWOb260n16WpFKACzb
 67RnlwE
X-Google-Smtp-Source: AGHT+IEgwPTuV+y/YxgKmEMQ5JWR0Ph9FUtNVoCa4/KkPCvXSSNybLamP4zieVNPRz+A2xMD1/sodg==
X-Received: by 2002:a05:6402:2793:b0:63c:3efe:d98a with SMTP id
 4fb4d7f45d1cf-64044279ed3mr493706a12.32.1761689218434; 
 Tue, 28 Oct 2025 15:06:58 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:57 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 13/14] drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn,
 Cape Verde GPUs
Date: Tue, 28 Oct 2025 23:06:27 +0100
Message-ID: <20251028220628.8371-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Add the VCE1 IP block to the SI GPUs that have it.
Advertise the encoder capabilities corresponding to VCE1,
so the userspace applications can detect and use it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Co-developed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9468c03bdb1b..f7b35b860ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -45,6 +45,7 @@
 #include "dce_v6_0.h"
 #include "si.h"
 #include "uvd_v3_1.h"
+#include "vce_v1_0.h"
 
 #include "uvd/uvd_4_0_d.h"
 
@@ -921,8 +922,6 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0x3630, 0xfffffff0, 0x00000100,
 };
 
-/* XXX: update when we support VCE */
-#if 0
 /* tahiti, pitcairn, verde */
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
@@ -940,13 +939,7 @@ static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
 	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
 	.codec_array = tahiti_video_codecs_encode_array,
 };
-#else
-static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
-{
-	.codec_count = 0,
-	.codec_array = NULL,
-};
-#endif
+
 /* oland and hainan don't support encode */
 static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 {
@@ -2723,7 +2716,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
+		amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block);
 		break;
 	case CHIP_OLAND:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
@@ -2741,7 +2734,6 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_HAINAN:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
-- 
2.51.0

