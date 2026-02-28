Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3821FFEE4E6
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C0B10EC5D;
	Sat, 28 Feb 2026 09:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b0P0q+xd";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C2110E1D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 01:12:33 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82735a41985so1564150b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772241153; x=1772845953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVWvXlolIB1z5Wdh/ZWEpJ69krVbfULM/4hKT6Ylcj4=;
 b=b0P0q+xdcs6NGO5h624gOFU/DgAyODs2EwpARCaCPXiqdTOSUakEa/EK77RkOj2jGq
 JGltKyalt8DSsE+9hf+zZYiIkh8vX/aEyuZJwpRE3DN5D0QS5C3edBTbp79SX1pnFoc0
 NYZjwDhL4hReNviSZyjsws0LyPNFx54HhcJATw0YbnM5ukPTxRkDe+32vleRbzOOD+aa
 YrJY7goiuNp7n3z9l144Iiz4zTvFeDDMCPZ+Vq6C9MHIpH3j33O8yc0YxDPwTzKmzelv
 iyf49H0gcrHPJnIg2Jz1IgD7p7A9Jl0XGIe7JBtW4DPp2MCpuPY/ycsaNRN4O0m0RWuP
 VrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772241153; x=1772845953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UVWvXlolIB1z5Wdh/ZWEpJ69krVbfULM/4hKT6Ylcj4=;
 b=PplLH6h2xi7gSE6HikAaKGa9yXUR9NoOCgaJb9bAVBtUbIa6VmshvKtP3ZLi670aT6
 FuJ4ikFIn2C3J35DmW6Cs0MYhNoWFjE1aYjeN5mA4NfdqcCkUUDXWM1ZexYLOaN2PXWK
 9XW1PyUt+wiT3nVZ1wHlBaiGAjVT0UyKGUra80/ZfRSJsqHClC8ovqLwciewv4b2Uv1U
 RL/izrD9Opn8/hfEA8RnCYehJ/cCdlne4OaZPfyWQRv2olzuoTXpS651TQ4vxfgvuNyR
 l7/SEDjiJT8V16xAczyLVxTGP34tk8qIgrK4ls47snWQvem2k7fuLAtINwwq+ASK/6s0
 BrFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwc/8BDJHi70JFSCqd8kKXGLnb2wzpKuhNymqiQ0KAUjTbo1/rYoFatl5oAeiRaxLjxO1JvLgM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA24+kQYavymHrEhU8nopK31jkSNs2y3qcb2ynQt/u8dH+8nWh
 mYT2YWl6duVFrvh0QqhnFi72NKdPpfAIq7eGSJzzCJYoiq63KXFuHG3r
X-Gm-Gg: ATEYQzwmBd+nDsCM7g3kzdCn2bnUqeopAPbFqJTthApEmti4Gw8vxh1SihIFWZ+eDvJ
 IukpwGUBjXHiDw6gOgELSoPeLRx6sR/lAh+LGfAuFFoQVcVy3sP2wSQOuU9S/qqCiQrd4wnsrZW
 tVo6rgbYmVLM8EfNkHsVy28Fs/Q5fL52qoT6RUJBIgjGrdgPO/YLgZczb6k38XWeELjKyCzF9r7
 VkqPpl0DIMl85AY/2BBWicgY62ACiRRgREqBp5mzGuyuyGVPirZrGF9RCQqKChSI4WTZVHo65pc
 ClNeT2aiwxUnhZU7+yTCy9R6ixkuIngRTxAjTQIphKz5mrvbBcM1gnCIlTHYWZ16ycLGEFhUXLk
 /C84JTdMew0Huq//BNUgl/V4pt8JSVxwTCPQw5WJQ8fcnAQLAyctpdkNpK8LxiniARjfu2IJ/XA
 3/AdMDTiKcodazq33P4Rv4bWw2mw/kA/9Ax7MvE67JG/3HhIuK+me1Vw==
X-Received: by 2002:a05:6a20:56a3:b0:395:1200:3abd with SMTP id
 adf61e73a8af0-395c3b45943mr4205836637.62.1772241153329; 
 Fri, 27 Feb 2026 17:12:33 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6f46c2sm75772845ad.89.2026.02.27.17.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 17:12:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Eliav Farber <farbere@amazon.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Zhigang Luo <Zhigang.Luo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Bert Karwatzki <spasswolf@web.de>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Wentao Liang <vulab@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.1 1/2] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
Date: Fri, 27 Feb 2026 17:12:12 -0800
Message-ID: <20260228011213.423524-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228011213.423524-1-rosenp@gmail.com>
References: <20260228011213.423524-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:10 +0000
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cd0bccc95205..98cce09684f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
-- 
2.53.0

