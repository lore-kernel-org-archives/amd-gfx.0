Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842EEEB2712
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 20:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212BF10E037;
	Tue, 10 Feb 2026 20:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W0t8ZeqZ";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F7D10E037
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 20:36:30 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8c7120353f1so474864385a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 12:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770755789; x=1771360589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ls9BFs5ncK5AYr8/VXWJY2TNnw+cs6LWPUFtVekVxc=;
 b=W0t8ZeqZbMxNq2WPuzIH1+OkmY1GHRBHCSZth8/afIxD/0Jjl5UiNTWtsaxIMyF6ot
 5EwrIxrn2bZamk+IIoHLZh7NAAwmhOChaDfq7IiktOqBKR0EETu9A+7bxE0fg56VT770
 J6wWduxBHs1WiPADRf5r8mRdQBLvaVtgSZty4IlJ2o10kzDsF5ztqDezX2Sv953JXmFh
 KRWMNo88AHIPG6wt8hx6EdKMca82pWxMkdEW4HG9A1dNaxJEsTO46igHT+7XBVuJEMvG
 suTC+K1VmQrYamgRdgsCS61czkN5oTLfWRA4/hvxoahFRvY+jZzlyFlsQtH5vMxF8Ja9
 1aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770755789; x=1771360589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ls9BFs5ncK5AYr8/VXWJY2TNnw+cs6LWPUFtVekVxc=;
 b=XSL1yRau+V+Ubotl7bL2evI1ClTt6N1f8OtT7WVYS7m4lQIoxdIHT6RJt8V+AYPVAm
 Hqv6nFLXS/tn2hIsfIeTWnR3jIAMunzxcXRqJ9pFatFPhs1snimPq+mXZJLnixuogt+l
 igKDa8j7PEW0FRPltfJohbIOAD2PoFDy7BH3vvYkt73ffDWSElsVWXtlRrHSFap280Uq
 i2n31fo4deniiwX00AswK5a2ySSiDzFAD1V4mF/r6b+m5V8dkF8LAYh5rQgjullRs+P4
 KTBm4C43t5DErC6vq1FCLb5k+PnBfuusgccQSOIH8yrjfsp4/7BcNqwqzX5dYaxQtrpj
 Udjw==
X-Gm-Message-State: AOJu0YzQyQbYJPjK337dGfJ4sUO26j8eusAlDwfxZPiFIW0YlM08I0tG
 dvD8HrwiaDwtc3dZVJv3xljLXYZxQa7QkWcLL1vsKciNo57wjxLs4IAMZ3pz/Q==
X-Gm-Gg: AZuq6aIptalBhyT1iOke9laLAxFTam9Me3utR8Gib52Gb7ivNEkCRc7F5pCf56VxKbs
 fAciKySEzPw+j9TxcsJQackYiSRMoLcBtbl3toBhCYbmgWe1ekT9LTNk7phEGjBjV+FISCEtxdb
 M82S+Ob54hA4A19OGoei7FiGdQQMgk3H4P4a6ynKZS5338L/Z7fDa3N9vXcKCqsvAbCIlG2ClAK
 2sYVMS9IF+8hqGVHx/ruFbdyARL0BmceBJP/ATGXUUYqvoMgziT/SlWJnJXF7xRLF8f3BIsvK42
 EJVAbD5n0vf+f8FcxLNF8vvXeQw+0Bd9JF1GFYln7kiy69FkYrsF86ovRbYKWNrhUsK0mOFB/6E
 oi5qmULnYJu8UawsXUXvMYxg3Lx+qyHFBvdBl5zAoMUcBtQDOLaytY+75JjxvDkmySaXCKMsEt+
 fkkoRXTRmcDAZ1IN68akifE0iItNJufGgoy5HX1iqUitKDE1zQCMfw8TdL+Q==
X-Received: by 2002:a05:620a:3724:b0:8ca:2cf9:819d with SMTP id
 af79cd13be357-8cb27fb1928mr87179585a.26.1770755788808; 
 Tue, 10 Feb 2026 12:36:28 -0800 (PST)
Received: from cauchy (d216-121-183-226.home3.cgocable.net. [216.121.183.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9ee8593sm1103702185a.36.2026.02.10.12.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:36:28 -0800 (PST)
From: Erik Kurzinger <ekurzinger@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Erik Kurzinger <ekurzinger@gmail.com>
Subject: [PATCH] drm/amd/display: remove duplicate format modifier
Date: Tue, 10 Feb 2026 15:36:00 -0500
Message-ID: <20260210203600.9035-1-ekurzinger@gmail.com>
X-Mailer: git-send-email 2.53.0
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

amdgpu_dm_plane_get_plane_modifiers always adds DRM_FORMAT_MOD_LINEAR to
the list of modifiers. However, with gfx12,
amdgpu_dm_plane_add_gfx12_modifiers also adds that modifier to the list.
So we end up with two copies. Most apps just ignore this but some (like
Weston) don't like it.

As a fix, we modify amdgpu_dm_plane_add_gfx12_modifiers to not add
DRM_FORMAT_MOD_LINEAR to the list, matching the behavior of similar
functions for other chips.

Signed-off-by: Erik Kurzinger <ekurzinger@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index d3e62f511c8f..12bd0c908d09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -704,7 +704,7 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 	uint8_t max_comp_block[] = {2, 1, 0};
 	uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] = {0};
 	uint8_t i = 0, j = 0;
-	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b, DRM_FORMAT_MOD_LINEAR};
+	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b};
 
 	for (i = 0; i < ARRAY_SIZE(max_comp_block); i++)
 		max_comp_block_mod[i] = AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block[i]);
-- 
2.53.0

