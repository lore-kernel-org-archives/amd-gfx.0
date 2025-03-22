Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7F8C36008
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973FA10E852;
	Sat, 22 Mar 2025 01:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbI4U9lq";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51DB10E851
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:14 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so16734901cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608033; x=1743212833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lsIo/ww6dQr3ZzJn+/76utSv6PhJ7u4CPLB+kqNpkLQ=;
 b=mbI4U9lqcwfPyTgD5vMcgkOA9anPWtDWQ+0NGPCS8sKviOWabTv+ADs7QmxUMkF+Eg
 Zd27BYVZZMjSA645qA26ppO6zRXPm7UO/eXSh4SX4an7Jv0qKwvePGaiYNeo2Ikocfnm
 AowpN4CYkA8fcr3rua1pdm6X20wk49+4i2fqMrm/Yt7pZHhHehqaradoRmHOBHMK7igD
 nitq+xl2WVDKycGqab0aYGjuedvuCsopUZ/Cwxgt7CV12AdWttjqWpvm3F5N7ab1IXFW
 2EvLWIKxgK8YWULocLBS7vF3vY5E1BV7ej4EDoaEj0kOvJ+2g7c83IIBAO/WpVOsOS6U
 0tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608033; x=1743212833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsIo/ww6dQr3ZzJn+/76utSv6PhJ7u4CPLB+kqNpkLQ=;
 b=G7iAKk/KtTBJD3uhfiDdhvG9ZPzRvt+K9iLzObtcL5xFlsL70Lnn1b7jQ9MFHVAGSt
 P282G9q6bbR3+JWlIUplhi9PPFas+r+9E6WWBtYyD0iift8kkwaH0UrEje4Nqr1ucP2b
 8HRENhost9BrTmSHRYo5LjvK6HlCnxxh9kxNRr6VTsPy+6/VjsAtQ9I4e9Vn2pN6xppu
 ImH0Y/LyXjwc31dZQQGEmbiBJJeMkDhkY8kEHSCRqCixfYGKe9Ij+8UF0y3Ri2IEY01H
 /NTmkm9DrkJsZJBBayuYbe7dDCigdtOReuryGpVTFx4R++2ptWVPve2qZV/wUEM1onfu
 qjHA==
X-Gm-Message-State: AOJu0YzSugDaFCdJ6BVq/8tMYt3Hy439ytAMU8po5zD/2yYj9A50sT40
 SXNO3vpk6q+guvozBb9ex58yOdLlrhez2kWHUB//lnQ14s9a38YDu3vhPQ==
X-Gm-Gg: ASbGncvKD1WrOO5rVbEk14AqlxdMtYYzIIV5sTVLFHFaAlwcQym/UVsV0aeP43limC5
 FdfV6R0AbW8MeWvzZeidl1/zzlIOVZdCspjsdZvSRjmUZM/8kFbwLKqK1UlGJ3IrHiG/f9kRJv5
 YfbNiWvkMLHnmKjxNj+O7Jn4f335mSH5NJuGwjCTe/vbzYTJvDpl0DiPeNm3yon4ZUXb+1Sz350
 P8WrCSKpBAUT08ymMHo2GrXBw5MM6Uwc7RAMUmu0u08UGB+sXPTjN+WaInrezfamQFFSOeR4y8Q
 Sf9n8XZdsPO4/F3hLhZQyTMdlUXVe9B+E6x6iFvL4RDzJ43WKbT7zx0w6WdFF5115T4=
X-Google-Smtp-Source: AGHT+IG0KFedMP8om4VtezfCu1QfmN3DUb1jUjHpXicKiBYx8a7uS/jfT8U2prN8NIIBmZqCzGoqzQ==
X-Received: by 2002:a05:622a:488b:b0:477:1134:3ee with SMTP id
 d75a77b69052e-4771dd626bemr99572331cf.4.1742608033410; 
 Fri, 21 Mar 2025 18:47:13 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.12
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:12 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/18] drm/amdgpu: move GFX6 defines into gfx_v6_0.c
Date: Fri, 21 Mar 2025 21:46:43 -0400
Message-ID: <20250322014700.62356-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

Send a few GFX6 defines where it's used in GFX6.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/si_enums.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 4476fb816659..5f85c3b63971 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -53,6 +53,9 @@
 #define VERDE_GB_ADDR_CONFIG_GOLDEN         0x12010002
 #define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02010001
 
+#define GFX6_NUM_GFX_RINGS     1
+#define GFX6_NUM_COMPUTE_RINGS 2
+
 static void gfx_v6_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index d656ef1fa6e1..b44a32bacd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -148,8 +148,6 @@
 #define WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
 #define WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
 
-#define GFX6_NUM_GFX_RINGS     1
-#define GFX6_NUM_COMPUTE_RINGS 2
 #define RLC_SAVE_AND_RESTORE_STARTING_OFFSET 0x90
 #define RLC_CLEAR_STATE_DESCRIPTOR_OFFSET    0x3D
 
-- 
2.48.1

