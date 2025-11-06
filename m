Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE90CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDAA10E9BC;
	Thu,  6 Nov 2025 18:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bC/D/LEB";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C4210E9AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:53 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-557bf688086so431463e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454753; x=1763059553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k6RUAT0t1x3yHypLmF5XTkG2D6h/5V21vKp2QHKfxFA=;
 b=bC/D/LEBi58AjKxGCP1cbX8tls0YIXgBK7UTX7WEYgW+LB1hTNQNtV6pdzZRoUBNW2
 rLCsYvO18b1Y4CiUhoXOqBTmfrWUuQoONE9OcRWe5kzhe1Vo0ciHAS7jOCHfJhKo/gr7
 BMRf6Umhzu7A2IrBUSCQkLWfj4YkiZXBRBEG3XWRvJaCwplIBepn8EY9y9yDWDJvVMnj
 M30VM3ivJ6ThnnbLifcWMzHN4VEiEboT3ugwc0lY751iEQd/eAbjrnQW2bMgiBo7Esxc
 oIBXfEm87jLw8CYS5CvLeppVZkaepNEJiiI4EmEOwBDW6yl7BK5a/E5/P/Fks/pTnF0k
 wRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454753; x=1763059553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k6RUAT0t1x3yHypLmF5XTkG2D6h/5V21vKp2QHKfxFA=;
 b=KtiOA7BI8s9XjqNeCogPOzzIItI9yoYbRM0UeFWogrrY5g0vB+UyrMsRQ2zvsjK3Do
 vaCZZOOgDpj/y9NtYfNQghKdCLR1SspPdz0OUKIH/eZu1v6KorhMmla9lSlAkhVQs0Eu
 jFVRrX7jEThnc6WUyOdboYybAA1+Ktk7oWY+ScZOFsIbLuI597d1IKPlTHdxRy9FYimB
 /mG564fiE+O7+i3P64bP3P65KM0lWmP9C4yLXXdwhk8xjHPzFa/wdjaBiGOUJWzpEf8r
 JXixgcS4XKAu9p7yCxEBLG9fitEfq0epfc2Wg6j0TZ8DuIOwnQh5gdMIlJuCErEHT1Kw
 W8ow==
X-Gm-Message-State: AOJu0Yzhb4uZzV/nJU9hSS0oEj81kSq2VpxvpL7QjJJF0DBiMAn7D1pb
 6fOAKjc0xIjTDISa10uL5QU2wSRRYExJApo5VcP2N0WjfrSY6f+yTYTuSXo590qe
X-Gm-Gg: ASbGncvsB2PQnEUbOUUzMeAhP3McX/1oMXe1gRrtp32uV8YnqSS43hw411rop1ZlKg9
 95Rw4XZqgZE+2ekuiq3/9vVJ0LKvGlVZxPBF3imDOvQLz2DXlzOXV24HgRa8r4RHVQCVcPaMMpw
 9MVOGGz3y5zp0pfC42RlQ+wnNSFORRnzoYDVlhYDwm9h5JCRIGso82Rzfugo/G/wwys/46Ejo1N
 oup7e60aU060y9CiLP9bWqYR4KmroJmr5kpQ+vuQ5R5K2PkxF5SXuO4hew7P1+BMYbYpGqp0dY2
 oEPl3M3BRXo81V6/PnnusHyKCuaZVCbNwMRIbbmp6ZLjFef4UvoZBZuH75N1K7NCmOGB4f5l65J
 cIkBnTyRioiOQJvU/StvRMzbSfiyUe+A0BkF+i1dajvhxASl32sd2XRADFQ4dj/MQ0nY2N8ec3G
 x74ccVJuan5qg1Nx4vg4E=
X-Google-Smtp-Source: AGHT+IHDTe9AyDeOAIpo42kE7xBRKPZwrcW8pshdWedbj6GPIE8KpDwtL6vQiCcvZWBnffGFgJFGgQ==
X-Received: by 2002:a05:6122:a21:b0:556:95a1:1a44 with SMTP id
 71dfb90a1353d-559a3b9f6fdmr276344e0c.13.1762454752902; 
 Thu, 06 Nov 2025 10:45:52 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:52 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 08/13] drm/amdgpu/vce1: Load VCE1 firmware
Date: Thu,  6 Nov 2025 19:44:43 +0100
Message-ID: <20251106184448.8099-9-timur.kristof@gmail.com>
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

Load VCE1 firmware using amdgpu_ucode_request, just like
it is done for other VCE versions.

All SI chips share the same VCE1 firmware file: vce_1_0_0.bin
which will be sent to linux-firmware soon.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 4beec5b56c4f..2761c096c4cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -41,6 +41,9 @@
 #define VCE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
 /* Firmware Names */
+#ifdef CONFIG_DRM_AMDGPU_SI
+#define FIRMWARE_VCE_V1_0	"amdgpu/vce_1_0_0.bin"
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 #define FIRMWARE_BONAIRE	"amdgpu/bonaire_vce.bin"
 #define FIRMWARE_KABINI	"amdgpu/kabini_vce.bin"
@@ -61,6 +64,9 @@
 #define FIRMWARE_VEGA12		"amdgpu/vega12_vce.bin"
 #define FIRMWARE_VEGA20		"amdgpu/vega20_vce.bin"
 
+#ifdef CONFIG_DRM_AMDGPU_SI
+MODULE_FIRMWARE(FIRMWARE_VCE_V1_0);
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 MODULE_FIRMWARE(FIRMWARE_BONAIRE);
 MODULE_FIRMWARE(FIRMWARE_KABINI);
@@ -99,6 +105,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_PITCAIRN:
+	case CHIP_TAHITI:
+	case CHIP_VERDE:
+		return FIRMWARE_VCE_V1_0;
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_BONAIRE:
 		return FIRMWARE_BONAIRE;
-- 
2.51.0

