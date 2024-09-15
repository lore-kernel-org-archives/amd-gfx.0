Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4CAC3ABA0
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Sep 2024 19:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B658010E2BC;
	Sun, 15 Sep 2024 19:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VyZbLvTb";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A51210E2BC
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Sep 2024 19:28:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 513BDA40EE9;
 Sun, 15 Sep 2024 19:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494CCC4CEC3;
 Sun, 15 Sep 2024 19:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726428531;
 bh=g1/tBL6wMAVCAbZ4Zgi16X2hkvKxKZdJzr4cgRsOXZs=;
 h=From:To:Cc:Subject:Date:From;
 b=VyZbLvTb5fyLQvfU7r7I9t4TEwJpUzTz+jl6FpIfXB6U5flizYFBPpOtwBECh9Qj7
 nW5IbDENtjSpDDyLDqOtmrON0PD2nzTDewzG+3Y6ws1KOUIu05mQJcJ+oS5yl3bakB
 vKDBWK8P1uJ56PJ4WT0FF2nL9ARyFGIK5JH0pjSFC8y2MfE8mhLFH3Vnf+aTYdjcW0
 UdYza0ize+T/GHoptESJg4CLlyoGH5QtLGd/pbpo+6pPG927PcgyKoUg/nVQgyerVC
 oIO9zWQu14Er7+ZaCLLiG1V6HFuiU7VqHSBrWcHJIFRLhV7FX/ElR1SyKbhOELjkBK
 ed5RArSpEOBNA==
From: Mario Limonciello <superm1@kernel.org>
To: harry.wentland@amd.com
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] drm/amd/display: Allow backlight to go below
 `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`
Date: Sun, 15 Sep 2024 14:28:37 -0500
Message-ID: <20240915192837.124745-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

The issue with panel power savings compatibility below
`AMDGPU_DM_DEFAULT_MIN_BACKLIGHT` happens at
`AMDGPU_DM_DEFAULT_MIN_BACKLIGHT` as well.

That issue will be fixed separately, so don't prevent the backlight
brightness from going that low.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/amd-gfx/be04226a-a9e3-4a45-a83b-6d263c6557d8@t-8ch.de/T/#m400dee4e2fc61fe9470334d20a7c8c89c9aef44f
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ad66f09cd0bb..80b8594fcc33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4449,7 +4449,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		int spread = caps.max_input_signal - caps.min_input_signal;
 
 		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
+		    caps.min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
 			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
-- 
2.43.0

