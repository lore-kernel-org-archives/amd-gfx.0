Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A10EB271F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 22:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E057D10E13E;
	Tue, 10 Feb 2026 22:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BH7UMbKY";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCD210E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 22:16:05 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8c5349ba802so608855485a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 14:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770761764; x=1771366564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XIIKd1sOIrTTZAoRjJExxLKFRTicCZthc3i1lVIskr8=;
 b=BH7UMbKYA3aFKokXwx3jrWg4Kw05VjzpWOm/dBmVfh9pQeZxNuBzGF5rV1O6uKQuO0
 zt0p9tNFV5hz7w1R7EYYXQGhYO7yPdtVDT3t9VjMmY3wysmrk14SOebt5moMXIQ21E7N
 W9CIK9ZEBVMXbFmTqO3B/61Q4LWY2+Ztn9V5zplqXEAHt3aw1V8IFrFyJkkVW9v6okae
 ApzU961TjKOYxhVM5++ZwPpi3ZUDtvZ/t0DkJT0dawuh1rcmTkj9gYH1w4tWoUi0WZHV
 OU7QSAxLz0DnmQRDZS8uIUN9/WG/0S+Ee0WgeZP5DYoR8sofzbZLuQBoeKHPjCHyxzkC
 BYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770761764; x=1771366564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIIKd1sOIrTTZAoRjJExxLKFRTicCZthc3i1lVIskr8=;
 b=fvhggoqkWADqNMVxtUkkGgfUpfmeal5TvdcR9V/Jt4/2LZQ7TJQSHp+Ufj6nmUngVF
 H+8PWOylJinKygC/qhEQDqJIi1tMt0sC/Xt6VbmJlCLBd3r32wy7VnFaqK1q37Z2gcpU
 jQEUCMotAXF0NjJdYy5FHI31oGpepBrnL0/soN1HrNyP+fa6GunoeNqZQlgVwxJ29aFX
 7bkx1BcQ0DDWs0+64UZkU1j9ry+RBUvwcRJAzLpERPIHxep2pCTI04X68Ms2w5WoPywK
 hLajNdsx/rhntKjKWs1oNXoZ0V6wYTGiUxva1aHiYCqrP89Qd3tX4qZSdbkGM4Way7dF
 J+bA==
X-Gm-Message-State: AOJu0YwGmZU+Py+L/F78uZcVWK7jNQC2i2BAR/vgvck3pZnXBh2CY4ms
 Ti8rOvSsm1xZEtpd+OYeBAvqUggjHiOU0Ri7+JWbb157aZigxJuWxXvHyQZeDA==
X-Gm-Gg: AZuq6aJ1r8JDT41uu0ZVch1LOJIMy02pbTZGqcrg6tYNHmsk/fURPPfv6Y63DLTaAG/
 HCfRx+PslpK7VSablFxjaCrgwpE62ZRgzmqlupptX3S7b+CwdUjbgZngjTnH88mSPNynCddPG74
 NAL/PcDUxLOgp1kE+p/rjPW2sj5Y8K9X+3iq/xHkSxTOzNdfkhylhVHEPZ3izRtKVpcYcrzE5WQ
 PE4r2/d7HuuGaRdHDPut4kEDheZPpotoimVauKIufwmhlLso7Pvuz6gdgEjBP5bvBV3ISVeR+U+
 USa40a6P1wriNcE9YhtabNbRAX0sBVYGgYJk5TbGMGsc2CILIXKPY3euAS6lAhT29pxxuvF9syT
 BKkA3EfS9+3huLNAbvY+3NciwVnWQELfIQV4Dhy/+hPJWqUZv3GnQMnfwbAxjY7fNUNnxDc9qUF
 vmgQBEIEFkctpNkF+XMNo17S5gRL07GiFS1pZxk9FhoFyAYv5NUiVn84Q4QA==
X-Received: by 2002:a05:620a:4116:b0:8c6:e225:2671 with SMTP id
 af79cd13be357-8caefdc0abdmr2139572185a.48.1770761763933; 
 Tue, 10 Feb 2026 14:16:03 -0800 (PST)
Received: from cauchy (d216-121-183-226.home3.cgocable.net. [216.121.183.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971c01820bsm1512746d6.13.2026.02.10.14.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 14:16:03 -0800 (PST)
From: Erik Kurzinger <ekurzinger@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Erik Kurzinger <ekurzinger@gmail.com>
Subject: [PATCH v2] drm/amd/display: remove duplicate format modifier
Date: Tue, 10 Feb 2026 17:15:55 -0500
Message-ID: <20260210221555.1309-1-ekurzinger@gmail.com>
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
So we end up with two copies. Most apps just ignore this but some
(Weston) don't like it.

As a fix, we change amdgpu_dm_plane_add_gfx12_modifiers to not add
DRM_FORMAT_MOD_LINEAR to the list, matching the behavior of analogous
functions for other chips.

Signed-off-by: Erik Kurzinger <ekurzinger@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index d3e62f511c8f..a0a7c3b5ee03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -704,21 +704,21 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 	uint8_t max_comp_block[] = {2, 1, 0};
 	uint64_t max_comp_block_mod[ARRAY_SIZE(max_comp_block)] = {0};
 	uint8_t i = 0, j = 0;
-	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b, DRM_FORMAT_MOD_LINEAR};
+	/* Note, linear (no DCC) gets added to the modifier list for all chips by the caller. */
+	uint64_t gfx12_modifiers[] = {mod_256k, mod_64k, mod_4k, mod_256b};
 
 	for (i = 0; i < ARRAY_SIZE(max_comp_block); i++)
 		max_comp_block_mod[i] = AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_comp_block[i]);
 
 	/* With DCC: Best choice should be kept first. Hence, add all 256k modifiers of different
 	 * max compressed blocks first and then move on to the next smaller sized layouts.
-	 * Do not add the linear modifier here, and hence the condition of size-1 for the loop
 	 */
-	for (j = 0; j < ARRAY_SIZE(gfx12_modifiers) - 1; j++)
+	for (j = 0; j < ARRAY_SIZE(gfx12_modifiers); j++)
 		for (i = 0; i < ARRAY_SIZE(max_comp_block); i++)
 			amdgpu_dm_plane_add_modifier(mods, size, capacity,
 						     ver | dcc | max_comp_block_mod[i] | gfx12_modifiers[j]);
 
-	/* Without DCC. Add all modifiers including linear at the end */
+	/* Without DCC. */
 	for (i = 0; i < ARRAY_SIZE(gfx12_modifiers); i++)
 		amdgpu_dm_plane_add_modifier(mods, size, capacity, gfx12_modifiers[i]);
 
-- 
2.53.0

