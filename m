Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E15F36C5F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C0310E55F;
	Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X83uTEq4";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C1310E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488c2690057so29131535e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687051; x=1777291851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOASRI9xkd6w8PdbchOBAG1z6w0edA0dLsd8ezUrjS4=;
 b=X83uTEq4qNyipzWqDt8i4ZM32lccrEB5FNB0bzHasYKod3FPE1GEaHxgytGvuKvTyc
 jlBva0NSyZ2UfM93RNDi8Fmt5hhrfTYGM6aophtAqEIkj3IO3tC3+tZ9cCc5XsxGI5di
 eG+ss7RpfBzGVNscZQoo/u1qOS4Iqgl4gMTLYAsN341+pSzWuEoa/QopRNZpgitj45mS
 I7fNdvs/d5ZOzMrLGlQ1BCbwLc8zQmvQGMgJNTBnBcLwpgEr+xzeU8kHD685o8Fu0P+H
 z2eD4iFjqYb/EQ8xerVMAfRFVOVVXfhWKTiNU2F2qDHwz5ifV7tycmWT9YvjItUJI285
 VYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687051; x=1777291851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XOASRI9xkd6w8PdbchOBAG1z6w0edA0dLsd8ezUrjS4=;
 b=jidp6CDuR+I8d4LmhpQafmsK9wF92MwIOTDIEGbv8yxtf1v0XEz3qzw3eKGAv2p0Oe
 ZjtUz/WDqkF8+FsoW/6Zb6ivpkXXdj1heGPXYBJseT5K3SD5a4Ax3v9Xo2Ec9CvCWFqG
 9lLPFVeaqcn/F8O+yLna+8xS5WGl+4noarxn04b6sucxAbcwQjW6/fNIzUXMkXWh3oFU
 huohVfrgP9ySqj+o1N5JDrrRyeQqAox1vmcjBEe5FyAzBvBPkoiU/V00wNg5uCDnJn6R
 hsss5MfX4nwW+gs52yFuiMGCktszPJNBW/vAVpfLJucVKvjYg9bwzYNefydBlYQRUDI2
 Bacg==
X-Gm-Message-State: AOJu0Yx+idwJiPJMc/cEx1G8CNk0o1ShM6l19I91Rlbb301gV+2gTkK8
 p4g13q3/CfEVJ3ioD8lJBfT9hOp+ps+iA+68Pl8YxnkjsGwy2wpN0oIgIiYr4w==
X-Gm-Gg: AeBDiesXDgxIScRVYApCvJAqM+dpnUuwaLyJotAicJWPVAMsOus/t9E6feCi3fPSDIL
 QpCznqNvf90KJrbtfMUI+ra2UFNIQ3BilZ5KGnBysEZgwjFbIBHiO2qmzd34XziFN+z3XkRDhJF
 weeN1oYWabmTEpsPi5alu46sy/XOe3w9ihEiKYjm/nIbFmD9uikJplKsia33qAjjFjqon36TNKZ
 bK9oOb0q66rGnv9DtyWqQhb9uQCUS7HvQEMk6dIPZt9wvykCwCjs+iij/k3JB01gzChxtyATd+8
 17YAWcDMpyZWI0PYIOEPUi0SIpKcs/0Oz6jFJMJjqAMm1lcWmjFmDTa9mR83tkzVlgzkgkbym6d
 ouxe/NeNa+NEYvCN70eRFlHE1R6pr9bGl7YZdEABTtn5dUmADwNKbzfvopLgzh1EMYzqgA9xbUg
 OudP+huHAEJI0N661sVRnSOLopC4B8hoTj9ZTS0xQGdfslZCfPC+G37oB8mueNNgL57IO4VBfDC
 XrpOQ==
X-Received: by 2002:a05:600c:a116:b0:486:af22:4a2a with SMTP id
 5b1f17b1804b1-488fb74a447mr140024915e9.7.1776687050906; 
 Mon, 20 Apr 2026 05:10:50 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:50 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amdgpu/vce1: Remove superfluous address check
Date: Mon, 20 Apr 2026 14:10:41 +0200
Message-ID: <20260420121044.155030-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121044.155030-1-timur.kristof@gmail.com>
References: <20260420121044.155030-1-timur.kristof@gmail.com>
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

The same thing is already checked a few lines above.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index ce993b57b0e9f..35caef5a8102e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -553,8 +553,6 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	amdgpu_gart_map_vram_range(adev, pa, adev->vce.gart_node.start,
 				   num_pages, flags, adev->gart.ptr);
 	adev->vce.gpu_addr = adev->gmc.gart_start + vce_gart_start_offs;
-	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
-		return -EINVAL;
 
 	return 0;
 }
-- 
2.53.0

