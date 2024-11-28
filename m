Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36573D6D255
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 03:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E053110E46C;
	Thu, 28 Nov 2024 03:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ysh+Y2ZC";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0ED10E46C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 03:22:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 29A825C5B0B;
 Thu, 28 Nov 2024 03:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9378C4CECC;
 Thu, 28 Nov 2024 03:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732764152;
 bh=JFWON1a1gwL/eNqi9PJoN9/0QX8IdvNZQuFcTh7vx1c=;
 h=From:To:Cc:Subject:Date:From;
 b=Ysh+Y2ZC5Cb9l50PHjHtB4R9cp8A0l/BBR/4R9J2p07l0MmBdbZB2FVLlmm8DMHYP
 FnmJDqnJYFnJ4shCuTZQC/FTn1i9D8cS225GXfZJ/FHYpabIw5uaHMEGoPf2xP+rXs
 QhnZfbzpwNv7v3kIVGD3zUq7pDaoeB1tXBGjmKk3dCH1SjTeWk0cDtedeYnISN2+Hy
 6IdN7j9ctWDKAPJ6L2SeFU968JEMHsIIcsVxv+PrAyc5aGWqnHyBVhV/hXTJ5IMJsD
 3tU8PWBmUe38I6iEcTQLtNHlstgia6L7rzKCjhJydSaplCbdqR4T+G5xenic5shyqM
 c6TkJXO/9JVgw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Kaitlyn.Tse@amd.com, nicholas.kazlauskas@amd.com, zaeem.mohamed@amd.com,
 daniel.wheeler@amd.com, harry.wentland@amd.com,
 regressions@lists.linux.dev, Mario Limonciello <mario.limonciello@amd.com>,
 Luke Jones <luke@ljones.dev>
Subject: [PATCH] drm/amd/display: Fix programming backlight on OLED panels
Date: Wed, 27 Nov 2024 21:22:00 -0600
Message-ID: <20241128032200.2085398-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 38077562e0594 ("drm/amd/display: Implement new
backlight_level_params structure") adjusted DC core to require
the backlight type to be programmed in the dc link when changing
brightness.  This isn't initialized in amdgpu_dm for OLED panels
though which broke brightness.

Explicitly initialize when aux support is enabled.

Reported-and-tested-by: Luke Jones <luke@ljones.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3792
Fixes: 38077562e059 ("drm/amd/display: Implement new backlight_level_params structure")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19a58630e7740..243cee2841312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3483,6 +3483,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_support = false;
 	else if (amdgpu_backlight == 1)
 		caps->aux_support = true;
+	if (caps->aux_support)
+		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
 
 	luminance_range = &conn_base->display_info.luminance_range;
 
-- 
2.43.0

