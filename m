Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E297C282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF5210E8A6;
	Thu,  6 Mar 2025 01:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PRANdz8W";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1DD10E8A7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:50:24 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6e8f916e75fso169566d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741225823; x=1741830623; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rf8TOOYi7UG7/xUCz4Z5Q/h7YroCehcvvuzEzSu+KDo=;
 b=PRANdz8WUlViq5bQdH9X1xqylPPMRQmA49AFtiQId/+CNRbUa7ScIXBqhe4ExI+x2H
 jzOTtIBA0hlMdG+bBgfW9jxqZ47TLbpgFAn4cu+Qh3Ub5EGEPhRrmIptmYMqieewRCwN
 pUNTJ9h0m7eSBm6Sh9ps6HeKr2fy2OBx2TilmDdCDy29u+Fhb8PHEryQSEewcXiFxozC
 OGHCdNE7yicLf7hxVp74eKHtdy0i9KP/MY97HZsgRGJJsFid/e8Jk+3MX7G8duvIzR04
 9F7d8qrP80gVlVHwSB3sd4KsjpV5J5W1KCXtE98S+V+zw5HYOjvsh1bcVAb/GXxED1ly
 13fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225823; x=1741830623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rf8TOOYi7UG7/xUCz4Z5Q/h7YroCehcvvuzEzSu+KDo=;
 b=cUsV9wxnxO40/2WrVkJVYWqACWAtJ8V/NSktGgB25gDuHmkACkIxdf3CGO00to0fyh
 6IzpiUUemNK5Ursk0NS3lBks1UgXmzsUvxjxf2ZFfGLsiI2sfVt8NGKFuHXw39LxWxkl
 ZhH4hDRwzKj+CmubS1G+S2GuID+jgdA16TDVQGE7pCd7I3+v3rQ8iB75qPejLyK+hqGI
 DQNbpk0hwuSqBGDCdqEIfYw7M4Uelh9EC/4/UIGN0vdC5ZtoI7xUVNvIovLtAD5SlAzn
 D4luTrvz9dVuzylUm6mZJG8fyqM7GGsr3jqKa9QaS3o5eQfq+3ivHxN57Rf+TOtC2Ba8
 UBZw==
X-Gm-Message-State: AOJu0YwmBKeNiltNnjb9+O9S1RE6+/zCl0WYAUuTPoMKLTn0+H8UatHk
 xY4JvSDB/9FLcKjxPtJDg7k+rfxd2NO2BEMotiwL+bNb1+LDYDpOt72epw==
X-Gm-Gg: ASbGncsjk1Vt3aM42r09fay36Kqzdok3IOqDWKYC75vinLVYteV9av5+YLO1ofrAP/F
 WsjASk7AGcSHMLTn/ZnPxCA4ZgBdFjR4ZvTWqEB3uGQnrX0ZPxuMo0H8q5KhFsUTa8kKlnt+vMd
 5z5x5SzmHuHVboYMNCuItMz/+qGTdxJP2ZFGVTrt8ntNT+c8gziinwfUfDufnuUbuveXC64RCOD
 UdoC2IH+234WFOmc/4ftPftY5N0eKNTrJAJRVaIyQh6XvM0xW6vdGAOhI7tZxjtdFeI7pGt5/a2
 MuUsxgY7cu6be8XBW0OMdSzI1DSjeHicrA9yJjgy1lWi0xCEPAQu5gUJgXqPc0hVoec=
X-Google-Smtp-Source: AGHT+IHHc6a264rvR8ykzOxKVyeYltb3tCRNnXW8piRJ6YGaETW6O6SFJAiTwzSVAMa79grkBS8QHg==
X-Received: by 2002:ad4:5d6b:0:b0:6e2:49eb:fb7 with SMTP id
 6a1803df08f44-6e8f46aae90mr24991446d6.3.1741225823281; 
 Wed, 05 Mar 2025 17:50:23 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b65csm1489786d6.76.2025.03.05.17.50.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 17:50:22 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 3/4] drm/amdgpu: move and fix X_GB_ADDR_CONFIG_GOLDEN values
Date: Wed,  5 Mar 2025 20:49:57 -0500
Message-ID: <20250306014958.785021-4-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
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

By wiring up sid.h in the previous commit, we ended up with many duplicated defines.
Let's clean this up.

First and easy cleanup.
[TAHITI,VERDE, HAINAN]_GB_ADDR_CONFIG_GOLDEN were defined in sid.h and
under si_enums.h, with different values. Keep the values used under radeon
and move them under gfx_v6_0.c where they are used (as it is done under cik)

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  4 ----
 drivers/gpu/drm/amd/amdgpu/sid.h      |  4 ----
 3 files changed, 13 insertions(+), 10 deletions(-)

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
index cdf8eebaa392..8a2ebd725b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -154,10 +154,6 @@
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
index 32a4e7d450c6..16314173e5ce 100644
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

