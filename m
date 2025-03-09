Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E44C35FF1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F3D10E30E;
	Sun,  9 Mar 2025 16:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jKMZQVjN";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B1110E1CD
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:49:17 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c3c9f7b1a6so337661885a.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741538951; x=1742143751; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BzKbzUppSFeWD+t+TgU++OCc0tQcvjYsP7HXfKZir9c=;
 b=jKMZQVjNhWWCmUv9Uhma/RxhrDhRc7rFWOTIYS8rgh8rosR6/hpXz4KgpFUINbXjth
 rGnTWf75kW1/V5wXHUDM4p2pO7gW/gYBDEiDm6JGwUUEeaAHtOsDl4xzqPeyw9nJE/qj
 rvJkzJyYprOFpk/xXh5ZJyBrbJZWd2MxuMm4iuqDX6YIGjYxCEmaZIgswBHSHo2+6qZd
 Bl/EwVOvOnUns3ZhFnHkv6s0upxeNy4oNz9xI6ob1iMESUl/MpY5IUGP66qk9R8JPerc
 dn0Yo63Q+KT+uCmvTszshiI2KxivgaEPrmQEjiCs4KjkA48z1htXO6bQxkInRTqHbK15
 Pduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741538951; x=1742143751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzKbzUppSFeWD+t+TgU++OCc0tQcvjYsP7HXfKZir9c=;
 b=MFu5luj/RQ8X0leVCrfoiHGpuYtFoFldVXffQZe2Z47GHh13f3QNmPEKJELM/8Jw8Y
 FGKkjAJ6AhoGEr2GYHAzhj25ylrlfNRdNMoQlJEMw1uJX47/XYIL0JDDi7uSgw6zPxY6
 +OAsHqWBxxITQ5vQAs4ZPoLV77sFAXfMGuu6l8oR+jwQYL/dgwfHKEEiICqBJvAZmvYS
 sEGwaNONBABPBdtrkcOUKGryiDI6pfgHf3S2NhpLzR1Pi3sdrOtb1z3Ci5wsGVAaNcyr
 kMNfNwZFvKIQLTJ/Z5xU+Pk2JSbZ50xR/CJ/6JGTGaFVB9Od8MyPPBsNc2Em6BivP3PX
 Jevg==
X-Gm-Message-State: AOJu0Yw4YdVAchI7RA2lqMR+W+1Lpq2KRL4w7Hu3ddNbUrxqmn/OgJUV
 aQ2jcl7/F1U6UBHsVsjzW5tBnil+CzBOspRr5Pr5aRUrgifEzkvMQSsYsA==
X-Gm-Gg: ASbGncsnM7WpU1YgS8OhHIGWW9lupENVckwzhkY/qiphe8atMeTgIYU+Q/Pi+9giAJX
 yKkw8fkAoFO6QKecarzH03gIo4C3GqkZ9i8Mf+59EsEEKZxpg7YIhyFRO9uzhfaCGpjX5tvh1jq
 uICIQBb7mXbe6gSHh3lVUEwdZTjnmBmcdCBs3y8QXBYJt8P2bhcnKU1rOTWaqvEoIpuXj+S0RRh
 7piZNAmw9RnmIXYbJ3rxQeYzM8HtkGSkHFBLwhcvlGvgWmEEHnJQDFq5h0uWW/zt2Ms0cPz9hCy
 6ZLxd8tRPufVuteJYLaNf8ktKCREBma/az1fJ7cMYYUqoNsvTYa0hQH4jCvEHsBNiJo=
X-Google-Smtp-Source: AGHT+IHQ542Ho+uMGNkfQ6gygerh37hWDuuSzvTA9pZ6Kty1JeMa9d5CQWYEiHs2XtZ6Ac6fLBRm7Q==
X-Received: by 2002:a05:620a:24c9:b0:7c0:a1c8:1db3 with SMTP id
 af79cd13be357-7c53c875b38mr1058407885a.11.1741538951246; 
 Sun, 09 Mar 2025 09:49:11 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c53e2ff59bsm236996385a.1.2025.03.09.09.49.10
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 09:49:10 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/3] drm/amdgpu: fix SI's GB_ADDR_CONFIG_GOLDEN values and
 wire up sid.h in GFX6
Date: Sun,  9 Mar 2025 12:48:51 -0400
Message-ID: <20250309164852.3936628-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
References: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

By wiring up sid.h in GFX6, we end up with a few duplicated defines such as
the golden registers. Let's clean this up.

[TAHITI,VERDE, HAINAN]_GB_ADDR_CONFIG_GOLDEN were defined both in sid.h
and under si_enums.h, with different values. Keep the values used under radeon
and move them under gfx_v6_0.c where they are used (as it is done under cik)

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  6 ------
 drivers/gpu/drm/amd/amdgpu/sid.h      |  4 ----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 41f50bf380c4..4476fb816659 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -28,19 +28,30 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_ucode.h"
 #include "clearstate_si.h"
+#include "si.h"
+#include "sid.h"
+
 #include "bif/bif_3_0_d.h"
 #include "bif/bif_3_0_sh_mask.h"
+
 #include "oss/oss_1_0_d.h"
 #include "oss/oss_1_0_sh_mask.h"
+
 #include "gca/gfx_6_0_d.h"
 #include "gca/gfx_6_0_sh_mask.h"
+#include "gca/gfx_7_2_enum.h"
+
 #include "gmc/gmc_6_0_d.h"
 #include "gmc/gmc_6_0_sh_mask.h"
+
 #include "dce/dce_6_0_d.h"
 #include "dce/dce_6_0_sh_mask.h"
-#include "gca/gfx_7_2_enum.h"
+
 #include "si_enums.h"
-#include "si.h"
+
+#define TAHITI_GB_ADDR_CONFIG_GOLDEN        0x12011003
+#define VERDE_GB_ADDR_CONFIG_GOLDEN         0x12010002
+#define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02010001
 
 static void gfx_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v6_0_set_irq_funcs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index 4e935baa7b91..cd9b0a654991 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -128,8 +128,6 @@
 #define SI_CRTC4_REGISTER_OFFSET                0x2c00
 #define SI_CRTC5_REGISTER_OFFSET                0x2f00
 
-#define DMA0_REGISTER_OFFSET 0x000
-#define DMA1_REGISTER_OFFSET 0x200
 #define ES_AND_GS_AUTO       3
 #define RADEON_PACKET_TYPE3  3
 #define CE_PARTITION_BASE    3
@@ -161,10 +159,6 @@
 #define RLC_SAVE_AND_RESTORE_STARTING_OFFSET 0x90
 #define RLC_CLEAR_STATE_DESCRIPTOR_OFFSET    0x3D
 
-#define TAHITI_GB_ADDR_CONFIG_GOLDEN        0x12011003
-#define VERDE_GB_ADDR_CONFIG_GOLDEN         0x02010002
-#define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02011003
-
 #define PACKET3(op, n)  ((RADEON_PACKET_TYPE3 << 30) |                  \
                          (((op) & 0xFF) << 8) |                         \
                          ((n) & 0x3FFF) << 16)
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 2218fd99ee83..bf228a1dedff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -26,10 +26,6 @@
 
 #define TAHITI_RB_BITMAP_WIDTH_PER_SH  2
 
-#define TAHITI_GB_ADDR_CONFIG_GOLDEN        0x12011003
-#define VERDE_GB_ADDR_CONFIG_GOLDEN         0x12010002
-#define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02010001
-
 #define SI_MAX_SH_GPRS		 	256
 #define SI_MAX_TEMP_GPRS         	16
 #define SI_MAX_SH_THREADS        	256
-- 
2.48.1

