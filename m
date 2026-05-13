Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C6CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88E610F04A;
	Wed, 13 May 2026 20:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVERfoyx";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7C10F04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so40712185e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702666; x=1779307466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1FPGSV7LejosXVeEFxjnGK2JzxLEsdYwTa92yxR1dQ=;
 b=jVERfoyxds5qJQ+AkTHETw73LKADhQPBguzIOR1GP3V9V/aXBQ4PL3UqBCX3TaweIm
 iJab2qPlM/5q7YTxM/U7VFusV6Nlbo85aCbO6MxTBbfWZx3I/JJpFpupjpd9yatEDpVq
 uiKlOba3x/po+OdzVKrGt4M9cHX2RBnLZix2ojgm5Db4ubkqo2FISqUJzW/uCLevU4+Q
 jH0AaUtbTk+M7BMBYWuH43TqP35mzX1cd2RoEpSOrv9x+CZ9vWg5fNTg6F4MXFK+Dsmk
 OYi6wEMrtJJHIlz3POPf34d6HexigL5grUX4yh6/6NKWC7I2GyKukoK8tutqXLNuDVD0
 9pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702666; x=1779307466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1FPGSV7LejosXVeEFxjnGK2JzxLEsdYwTa92yxR1dQ=;
 b=fpW/pt3oxQzMw0yWLtjr00oQZQhBxVDt27iQMiA5xJDCtAVAS8hYrss/UCjolLLGPF
 LUecsG6UVpgZY6C/lV/cokYphC+ZBVVb3nxhF6zYFAP0/oKGEhcgjeUVflI6R4QlkrDa
 QZZaDHzb2bVyPMBcAGCgPlVCjgke+V9TDLlzc2O7uIP9BKK02KwBiGsCFmOwQ4ReKz4u
 ZprLiyx5LWrnbnSCRDaWXkxgWO64BbJqB3l2oHhSg75GUu1I8orMUdBHmfgBqXIpwLLl
 0WcTX1h0gco18jqQF21otIjg37/71qaumxJI8TY1hNhyBTI3xW8TaOsQ0pyoKf1CyZ6H
 CYZw==
X-Gm-Message-State: AOJu0YwzwlE9YFH2H3Atj1GZfK0GcvUDZ3HaL8dGFXsaSiRyZiTVR3rY
 mKlvJsEUpfcmUyqK8uJi9+A173XEL6yEpvjoJW9NqvGS0p5UVjaNoPaSWQKfjg==
X-Gm-Gg: Acq92OHZ6cHgtjfB7BX+j0YUr2/0Qf951q6NYxFO2S71g4HkbC5CQmVDgL1bc77ZNOY
 ONujEm6tfHS5+HvbYjln47zNC6mp5MoYLL57lkURpE4Osl4VvXepXaibLErdmVKA6AYLvV64brV
 hXZRsAxPp0CimO596Y9cRYbmuI4xUo2lijCAjOzfv7aUbvP5EIpPCG0vDxjoriLz8cjG60H99In
 jQ6Ga7TDI2aYxe03zVRhuBZA5/dXukvt79oxZktYckoeJRYKyAnp7i7uGa5Izqu+s1VvGbXrG4/
 drtFO6T8U8K+HLO+kHDy5eFuMIsjgLWQw5o4pw7NQvVzGHn527fxJvOiprJdnV1VC40027YFUzw
 bFNl9AyvJbdqvKilW6UILB2/AKJGcivcpd3TmOnx1c7NA8CS3IbDqetrwTdLvtWSlHT8ATE6ujW
 0cck2v32BAifKHxBrn3Yt2TJZY7cffQt4cWwXSUMBwOpE6aFnJwkqGpMx7TjJ+wjY7
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48fc9a41e96mr66803415e9.21.1778702665573; 
 Wed, 13 May 2026 13:04:25 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/9] drm/amdgpu/vce1: Stop using amdgpu_vce_resume
Date: Wed, 13 May 2026 22:04:14 +0200
Message-ID: <20260513200416.35631-8-timur.kristof@gmail.com>
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

The VCE1 firmware works slightly differently and is already
loaded by vce_v1_0_load_fw(). It doesn't actually need to
call amdgpu_vce_resume().

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 32ee6452f95d..93253db5e2de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -178,7 +178,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
 }
 
 /**
- * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
+ * vce_v1_0_load_fw() - load firmware signature into VCPU BO
  *
  * @adev: amdgpu_device pointer
  *
@@ -186,7 +186,7 @@ static void vce_v1_0_init_cg(struct amdgpu_device *adev)
  * This function finds the signature appropriate for the current
  * ASIC and writes that into the VCPU BO.
  */
-static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
+static int vce_v1_0_load_fw(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	struct vce_v1_0_fw_signature *sign;
@@ -232,6 +232,8 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	memset_io(&cpu_addr[0], 0, amdgpu_bo_size(adev->vce.vcpu_bo));
+
 	cpu_addr += (256 - 64) / 4;
 	memcpy_toio(&cpu_addr[0], &sign->val[i].nonce[0], 16);
 	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
@@ -592,10 +594,7 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vce_resume(adev);
-	if (r)
-		return r;
-	r = vce_v1_0_load_fw_signature(adev);
+	r = vce_v1_0_load_fw(adev);
 	if (r)
 		return r;
 	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
@@ -714,10 +713,7 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_vce_resume(adev);
-	if (r)
-		return r;
-	r = vce_v1_0_load_fw_signature(adev);
+	r = vce_v1_0_load_fw(adev);
 	if (r)
 		return r;
 	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
-- 
2.54.0

