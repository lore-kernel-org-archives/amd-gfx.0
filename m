Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA7EC3064D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CEC10E9A0;
	Wed, 26 Jun 2024 18:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEBe+5Kp";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F4110E999
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:32:11 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-79c0f8d6ec5so156818685a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719426730; x=1720031530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k+Mo8mg73anFxbrWDvfMjpj08YphmArYTo3FhzDkn8=;
 b=dEBe+5KpcUySPqApOQPzUlqxs+bBvagtPv4Wom0NyeBS7L3Prg/d2R28DzXsuZktaz
 JkDdoWYTzdGmMUQPfemsRuleFF6q+o/hXJO9ZHxBZ98bDgMaRsVGBWuOdKaBTbfcRd7o
 QSOr/DeSopX0UHKUkhME7hwHEqgJXA6MtNwnHBFsrJx0K4mc8k5qI71J9jJwpqXF7dQE
 +noPgLqQml3IUwdLS3EuUU7IoZCFJcYpQvDL4zSVBvkOzZRsPGo26mM/WBsXjdGQ/jnk
 2fM1IERZwIcvr/yX/hSG45CiIZRLjDU7IJpLEe6J6GoGSPl/Np2a31Rga55a4LOJ2HWR
 NnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719426730; x=1720031530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9k+Mo8mg73anFxbrWDvfMjpj08YphmArYTo3FhzDkn8=;
 b=WGYUVPv1kHsmiJFxCGbLw0KxNsSEuz010LDPlEXbP+JUlJ7ukjfnTliV4GySOD+5LW
 RyIGtQ3Vb10xZr9oqAVqUZwZoIjKypNQZLhAz5lOt5AxhMVelsmBKqilWknhpM+Cq9kT
 3QfBW+MntMdgSyDcCDrUr3txyp5satHbm7XRcoqQqaNhYe0zuEKIgeQT4PcEz5/0FVxU
 U0L2OXA9IHDDV3EqmFbE5NiloXX3YbzzdOZQFnnia4DUrWJwFwuYP6dU6Qfo5cxvuSgr
 zXbnu+HnJBpWqdIalxvMb624+Kt/dhVfFyfuElyKXmtSJ4zc6tvu1Xc7k89ODsg9Q/NG
 4kIA==
X-Gm-Message-State: AOJu0YyYi4bzeDOW8Z+ygQMJgDSC53Z1/LcOVAvX+xgUzyMqLUsDGZLh
 AkvPbiXHgAsMJvjWNG8Y9KfMQsJtr9YK6aeTfUXXtyeb0PrHPsArsOr+Ig==
X-Google-Smtp-Source: AGHT+IH0/uVqE+D1n0/QLPex1Mc4tbSnVUM0AF6y7nr1ZVQSIit+Ab+CJEuC59Yoc4twMHZAcLy/Fw==
X-Received: by 2002:a0c:da0f:0:b0:6b5:47b0:8f09 with SMTP id
 6a1803df08f44-6b547b08fe2mr107081216d6.36.1719426729802; 
 Wed, 26 Jun 2024 11:32:09 -0700 (PDT)
Received: from localhost.localdomain ([142.188.138.70])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b538092644sm42209276d6.39.2024.06.26.11.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 11:32:08 -0700 (PDT)
From: "=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=" <maraeo@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?=
 <marek.olsak@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>
Subject: [PATCH 12/13] drm/amdgpu/display: add all gfx12 modifiers
Date: Wed, 26 Jun 2024 14:31:34 -0400
Message-Id: <20240626183135.8606-12-marek.olsak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626183135.8606-1-marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
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

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index e13938e01b70..0320200dae94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -688,12 +688,13 @@ static void amdgpu_dm_plane_add_gfx11_modifiers(struct amdgpu_device *adev,
 static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
 {
-	uint64_t mod_64K_2D = AMD_FMT_MOD |
-		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
-		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D);
+	uint64_t ver = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12);
 
-	/* 64K without DCC */
-	amdgpu_dm_plane_add_modifier(mods, size, capacity, mod_64K_2D);
+	/* Without DCC: */
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D));
+	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D));
 	amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD_LINEAR);
 }
 
-- 
2.34.1

