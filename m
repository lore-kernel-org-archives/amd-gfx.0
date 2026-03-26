Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FF110ED66D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B1610EE10;
	Fri, 27 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jg3f/ESN";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DFA10EB28
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:38 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so641805a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568857; x=1775173657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=Jg3f/ESNVIajf4EAF6z/Lwq6W5RRa/FNZ56WVBiRRGnFSNHsdsqhFQ/1wgSme8Dp9s
 goE3MOFHc9RY6UXKGt/G7BmnMH56rEhgWf9aXTenbk/DoyITyon5GRdM8AoGMHBbnQHs
 /905cmTvQz3e/IOQvZFn0lw3XKrj1+H20J7gaaW2BzK1oM5yo6f2uq/OZQyRVVL4rRTs
 rgMOrU8m6uiE/ncKB0mOxvJhcZTFxt0/HMAQIlMKj+QbiNncSn3qAPVgDkY+GBNd1iPq
 VVW2eEZ8pxS/MRNZy1RDDZHPgHYANTihEvXfarADVsIZgbRj2/J7fZdWTCk6HuPTHNgs
 oN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568857; x=1775173657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
 b=AEaUbQ1c7p3d6eBVuYSaJ58upvW7C7a+eKIAMJwA5T+MlxZH4MMtDrrEYWWQCZ7+Re
 63nHZgaRwClfmENzZOw89xhExawlRH4Xgxczp91fkYyKhVYjyPbnxAUI7zmAd2fCPD8X
 5UcKuK4MGXjtlNBQvH9dJt5QUYUek372DzPM2D7Qh03mKlmDWeFGJn844l+6xSyybAl1
 Wl9igd+69de0aVmhxZEZ4WHSlxJpMRu+YZd3M/lcowk6vu8v25BI4WKtuKMl33y1LjEi
 elUpRQ1hH6ZfkwwsGcBi7I781uqhhylOorsiZETSBY9yDP+ymakeIr7yzIku0glARwEd
 1U4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4QXHdo+zyx7GxWJLlV6hb7EYfkDg5yVyXnneSWO+xKLrLLhljmpB+n8+hsbWwc8Domkm23wJU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfWYZBahKBWhuheWWLBIGYt6AXs9vvLWakNw1tUdg1eP7CiFlp
 3XbiZWat8Bxp1rMD0YRS8E4NTxFfHXO6ub51rpxg05Hiq0TXIQYgjvSX
X-Gm-Gg: ATEYQzzgm0hnoUQhfJOk2r7tTbNgZlo5oH7z6E45Yn5ayK63JJFH39+lNk8OhpCjDOw
 I49AGKQPM1RtjOyvwaJPdXyeMbxNQYX86AgAsE968qeIvA/AF0kPHm87NILvFcsL2kZnv+4377z
 gxB3SNrMW6Ur6pdDFCCYEbquVMveQnJW/hCa0FYQbsAMbkmK/UZ2cCWMvwQnBJd6HdFLYDcy4c3
 twM/SIbxGmKz83BbZ+4PRr25vHYFSP+5dnTM34+43SnwFKMAXOsvgfkV4g5CpBZ/6JUGUzpyqOt
 psPCICtD5MFrSdKsoxQIlRWqhgF+uINHoLqVeG0R58Od/4eIGW6kzH4b17VZnfXSmVFOKlJ9Zb3
 /INOgbWDnAM31Gafbc8fliWiojPhHzawuzdnBMJA155mdoZbgG8BzrUcJEQOw3vQGvJouGPnYB/
 SIb7r4XqPHW+ibaC3isEbE0/q2ok+nCfdivKjIuaM0n2TSNslXk8qY5Ts=
X-Received: by 2002:a05:6a20:3d83:b0:398:4bf2:4285 with SMTP id
 adf61e73a8af0-39c877fe4bamr553257637.16.1774568857439; 
 Thu, 26 Mar 2026 16:47:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 1/9] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Thu, 26 Mar 2026 16:47:08 -0700
Message-ID: <20260326234716.16723-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit df0e722fbdbedb6f2b682dc2fad9e0c221e3622d ]

ASPM doesn't need to be disabled if pcie dpm is disabled.
So ASPM can be independantly enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d5e6d5ec69c8..dbee43c58741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1782,8 +1782,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
-		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0

