Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA8CCD4F3F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2009110F053;
	Wed, 13 May 2026 20:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ntHdAc6O";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E02210F04A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:28 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so86333635e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702667; x=1779307467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxYoehvwx6JnVvgyB4wpOmMQgYoOl/v9XfUQ8spxtu0=;
 b=ntHdAc6O7VW5FZ/TBtgIG0b5xhdtOcKOYkNDUi+oxJLF/V9HqwLUh2cbTbCr+AF6fk
 Chl1bmNjKk9FtDzU6KllWdWnfCu5WKMahYDefzhJo/hBaNRaZnqaK/tOgiFj6bh0i1SO
 PcmwyQJxoIqVINGVoD+ig65NXhCWRcaE81LNKxfMh/AnxShFOrPNmhaOEpxGlJByjReI
 CnTyq3b6t8W2ceNlAaxLyIKlqAok+++EwUbX/2U0Kk7qDlp9cQW8NAYDV/1W1M0tZXKP
 MZrOxiBWNSZF1iQRlVkfaewctN7RCoIIJn34K6V/0mPGAIAc00XfBMa18JZ51WgyVHGK
 NipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702667; x=1779307467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UxYoehvwx6JnVvgyB4wpOmMQgYoOl/v9XfUQ8spxtu0=;
 b=iPiGC16eUVAHtmBen023qJudITrO1NWltzESymCEXHauS3UfvSsXfGNT5CX+jA0S1u
 5Y3rothv+uIrIYnN3gYo3AIBHyLmwEOh6jmeJvvb1wnfM/1kUoT0+AgZYiYhZ0liXvw6
 IXV1PrtQIVYJEwR64wvCjCzNAkr/hZ8pphU9ibBgWhQ+TNXPUj9fvnZ8pbpl0OAMUffj
 D5VSo6Mr7b4YY7AX2z+sXMjovbVQ/7klvOjiC3AvpAFrZQNaJyB9xtlBnpmwEA/cGJU4
 CaTpGW1xMKqufilWPglXxAY/sW9OwGO4VLSbykGVTjKyLEp5bECF60rRQW3jr5IRoD01
 +TvQ==
X-Gm-Message-State: AOJu0Yz/3unrFmsu7kBCLkNm/5b5YjWObPyj1KSpeSeuywTGrIWZpuLl
 ym7G2HeUgswy+9ZtrKaeYozl39EbNAApnVTWU3w8pjNSdsC7iL1XVVbOxWe7xg==
X-Gm-Gg: Acq92OGMghxG5pJJ6lhJAOpPbp87SIGcN7QX8l/M09iKHwUEtp/TrWBJyTDmvjY9Tmp
 5Pvc/hJBQT8eFN92UyLpeIELzHSrL8GXXzI2LJKvRsA40zV6q9nZaFoRZcOMvg9+f6vn66Kt7nc
 mcrufk2HxnN90B3fVh4HuyRa3zAwUDFeeUEXkvAN5vzO948IIp2wGMW9MrLLhaYc4DnvrbdxdC9
 m6cgcJ965OREkKfgkuWa6Opu6IkrZ4r03UBL2FtsWiDBgkeC3K4ncxIdqX7IO/EdC+tgHqXtq+2
 DBOUy/SMI7kCSO9Ka+6v9z0UycoH991yN1XqKuYUeiRrEkItY4veIC/KiT9CuaHC84GaHbipBTG
 zqda9zrbDtUfCv/fMXhYnMn+86RCyBBczBelnS/RoHmOZyJYYQ6BE5aq73Lm9WQ9ALIdQtKya5F
 yBATm9VTDJhuAKfq4exmagrJF+lsIC20daviKPa7zlaH7nmXRGnGZjZyLcTi0dEA6+
X-Received: by 2002:a05:600c:4c29:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-48fd1b8a1ecmr31850945e9.9.1778702666514; 
 Wed, 13 May 2026 13:04:26 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 John Olender <john.olender@gmail.com>
Subject: [PATCH 8/9] drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
Date: Wed, 13 May 2026 22:04:15 +0200
Message-ID: <20260513200416.35631-9-timur.kristof@gmail.com>
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

Additionally, increase the VCE_V2_0_DATA_SIZE to
have extra space after the VCE handles.

Also increase the data size used for each VCE handle.
The FW needs 23744 bytes, use 24K to be safe.

This fixes VM faults when using VCE 2.

Cc: John Olender <john.olender@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802
Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index db149eda6204..3a6fc8604108 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -37,9 +37,14 @@
 #include "oss/oss_2_0_d.h"
 #include "oss/oss_2_0_sh_mask.h"
 
+
+/* Use 24K to be safe. The FW supposedly only requires 23744 bytes. */
+#define VCE_V2_0_DATA_ENTRY_SIZE (24 * 1024)
+
 #define VCE_V2_0_FW_SIZE	(256 * 1024)
 #define VCE_V2_0_STACK_SIZE	(64 * 1024)
-#define VCE_V2_0_DATA_SIZE	(23552 * AMDGPU_MAX_VCE_HANDLES)
+#define VCE_V2_0_DATA_SIZE	(VCE_V2_0_DATA_ENTRY_SIZE * (AMDGPU_MAX_VCE_HANDLES + 1))
+
 #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
 
 static void vce_v2_0_set_ring_funcs(struct amdgpu_device *adev);
@@ -183,7 +188,7 @@ static void vce_v2_0_mc_resume(struct amdgpu_device *adev)
 	WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
 
 	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
-	size = VCE_V2_0_FW_SIZE;
+	size = VCE_V2_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
 	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
-- 
2.54.0

