Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED7DC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 06:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E1510E565;
	Mon, 13 Jul 2026 06:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNcA07Rp";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFDA10E565
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:14:50 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so12319965e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 23:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783923289; x=1784528089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SM1C9DWzmQ1CdFcBJ1mMm1A45BrPFY+GBXgtao2pFwA=;
 b=kNcA07RpNIyxZVi5zSlo0QwZYsesqvX0scsuMs1Z/aWd2cLxJcQxOlU+AU/RMrSu82
 0v3Uau2ayqMitTy2lAL9ROojxCTQAYJ+doUnQM2cyTNBwc8vg/z/S2NUMdD05gbEcCcw
 xDBtkXGRIUwVhX0mqw+c4pUEiLKGGYy9XXam8gBQv37gXK0IiXYSDZeoBrSge/UsS4bz
 fD3Ou3Xsz83xeuRqCQjGrGPyvQPoLKLFidf5liWqvLTYVt3STn1SH+vhdVNv+NqPGSV4
 Lo5xE7shXsx3vqeXqirnUfRLNtRkJ7tqiNoQHPBIsIjf6Q2auHQuXY3UV3xyBL+bG95T
 nkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783923289; x=1784528089;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SM1C9DWzmQ1CdFcBJ1mMm1A45BrPFY+GBXgtao2pFwA=;
 b=SvMhUTu/Kj8/zg7fHuFOgYX7s7Y8QFKfkq5ONLSAUzuN/rF3cReuQl7gucEw/ueLnF
 N9Fb9Y0yZTGypChvmwjLU7UnYZ5Iv9A6/rV9fVWLkj3Mn7s9qX0fTyTAwD32zddIV1eA
 nPHKgA5U6mIRuLn0mSHxeEFNJSUTFSBGQOk+LoIGrpbfzMzJkf0Cv5PG0LLN3tWkhCoW
 oVAwbIXv0KbnuaM8b4QOfQBvIRkNPmDTjf1nTISKR7ejI2rWhLvGXowq+EZ1v0ZxFYIa
 joaxezgGUfX9FTksav/qw7h6pVG9ealFFYJET4s71AESFE2gH1QdsEqXE6pyfZLue9QB
 e+/A==
X-Gm-Message-State: AOJu0Yx3hXc9CawwAGNycOfGAvrJQQVQ1SxeK0BY52O078jvgnsAWn8F
 yYJUaT7QBOBI4hnLPh4dUeBr3Ekt5sVxW5MfA9jZuFkrbjvWXM137YAU15HpuA==
X-Gm-Gg: AfdE7clAsEnXA6Zbu4NlVrHwudUE6KGj4sztsOBF831kOAllab/SWKKJAyhgPUV/Bqq
 rflWXrDdiAx3sXlIjc+DJ8g3Utxfgiyjgtc86mX8gRl6PLBKyT7nr+EnvDjiE5/DjIMMHFQGbu9
 GbjIt+Y5umtsYDD8X9Lwx8M6tdTOX+PPh6Gp/gwk4sRsd+O7AxTZkIGHN3L9jcpU15Wk2lEnLuK
 Tn/howYmZB48a6X1ek3RB0Avnx3J5X3cwQ3ae8o4tkFnFMepzI5TREM36ibBmuAU1Fm7gLcdahE
 wCCyxLDUjmtu+G4bew0LQYcZed1mYkt43nfd+ElvT8KHIegdmaDfezbdXkDqG9N3K8f6Sm19bzS
 NLH4zQvlq6g0J7GPPottSaio8wMSZXMgGlKFYrybsHOjB485vcAybYQ3adRvIVQW+gj/Po3hInN
 RB23PAR8OV/G+W7vgZXpmYrRXWlUJ3/3XYLOEwlXiFvNE5yaRwparo7w==
X-Received: by 2002:a05:600c:4693:b0:493:a5d0:d1a1 with SMTP id
 5b1f17b1804b1-493f882993fmr73929635e9.31.1783923288601; 
 Sun, 12 Jul 2026 23:14:48 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f744e8d7sm206490805e9.15.2026.07.12.23.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:14:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7
 260X)
Date: Mon, 13 Jul 2026 08:14:43 +0200
Message-ID: <20260713061443.32561-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The old radeon driver has a documented workaround in ci_dpm.c
which claims that Bonaire 0x6658 with old memory controller
firmware is unstable with MCLK DPM, so as a precaution I
disabled MCLK DPM on this ASIC in amdgpu.

Note that the old MC firmware is not actually used with
amdgpu, but in theory it's possible that the VBIOS sets
up the ASIC with an old MC firmware that is already running
when amdgpu initializes (in which case amdgpu doesn't
load its own firmware).

What I expected to happen is that the GPU would simply use
its maximum memory clock, and indeed this is what seemed
to happen according to amdgpu_pm_info which reads the
current MCLK value from the SMU.
However, some users reported a huge perf regression
and upon a closer look it seems that the GPU seems to
not actually use the highest MCLK value, despite the SMU
reporting that it does.

Let's not disable MCLK DPM on Bonaire 0x6658 (R7 260X).

Keep MCLK DPM disabled on R9 M380 in the 2015 iMac
because that still hangs if we enable it.

Fixes: 9851f29cb06c ("drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
index 1d6e30269d56..4d553be56396 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
@@ -106,11 +106,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
 		hwmgr->od_enabled = false;
 		switch (hwmgr->chip_id) {
 		case CHIP_BONAIRE:
-			/* R9 M380 in iMac 2015: SMU hangs when enabling MCLK DPM
-			 * R7 260X cards with old MC ucode: MCLK DPM is unstable
-			 */
-			if (adev->pdev->subsystem_vendor == 0x106B ||
-			    adev->pdev->device == 0x6658) {
+			/* R9 M380 in iMac 2015: SMU hangs when enabling MCLK DPM */
+			if (adev->pdev->subsystem_vendor == 0x106B) {
 				dev_info(adev->dev, "disabling MCLK DPM on quirky ASIC");
 				adev->pm.pp_feature &= ~PP_MCLK_DPM_MASK;
 				hwmgr->feature_mask &= ~PP_MCLK_DPM_MASK;
-- 
2.55.0

