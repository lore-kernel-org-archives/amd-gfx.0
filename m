Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2389CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 20:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6936910E9D3;
	Thu,  6 Nov 2025 20:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mkBM+J+B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6BC10E9D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 20:55:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C4CE6133D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 20:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92201C4CEF7;
 Thu,  6 Nov 2025 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762462530;
 bh=cOWJE2qCVv7CNiWGa9gN70PzDc/5144eA5y+bTbw0RU=;
 h=From:To:Cc:Subject:Date:From;
 b=mkBM+J+BVqaOgBz2vnlBznz+gYpQQYcwdnoDQX5SYqJkNg2Pm6vmLUw99W5jFGnfP
 Nq1nLxSZR4IeZEb4zQBhj88xYmIb1ZWvzjRbLWu7zL+ml/TtteaK5ZRVh79SV70Xxw
 Wr+2dJxQ9VTSU3lzb/Mz3vhf8jLnmk4BenRUU7ZJFOYBbOJKEg2encau1XREfdgAyZ
 xcdzgrM6PVsK5LpiP6uvc37Rvx0jM2PsoM4h7mjJXRRu908mF6NJeitrXa5uPi+gBM
 hv4pKA+k9Y6r3lz3ZLjBFZMgwRhRte9EfeLc2oCDSRw3fhGRngKVAfmkkhr/Nd582M
 Vz/138KJbJ4cg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Clarify that amdgpu.audio only works for non-DC
Date: Thu,  6 Nov 2025 14:55:27 -0600
Message-ID: <20251106205527.105492-1-superm1@kernel.org>
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

The comment already explains it bu the module parameter help text
doesn't.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4684
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 475a385462429..6ae3a1fb8d455 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -310,7 +310,7 @@ module_param_named(moverate, amdgpu_moverate, int, 0600);
  * DOC: audio (int)
  * Set HDMI/DPAudio. Only affects non-DC display handling. The default is -1 (Enabled), set 0 to disabled it.
  */
-MODULE_PARM_DESC(audio, "Audio enable (-1 = auto, 0 = disable, 1 = enable)");
+MODULE_PARM_DESC(audio, "HDMI/DP Audio enable for non DC displays (-1 = auto, 0 = disable, 1 = enable)");
 module_param_named(audio, amdgpu_audio, int, 0444);
 
 /**
-- 
2.43.0

