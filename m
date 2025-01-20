Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FDAC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040A810E481;
	Mon, 20 Jan 2025 19:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rG4oxBQq";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D9A10E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:49:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 19E245C57B0;
 Mon, 20 Jan 2025 19:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03EDC4CEE3;
 Mon, 20 Jan 2025 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737402562;
 bh=4g6/RPEJJGpzZ5Y4MWttXshrPv6UvY0Wgcx9Y9YmTFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rG4oxBQqtXb4yB5UcshWx44SBqAs3tMBUyYQOEnQaPbe6aIWNwaPDoNP6gh53F+vj
 /bGmJPoAHB35ABQloYRav48uRmEWQIgvwjaylvY+kUt+VG4bTDXeRULPfmYR5omb8z
 jBh6IIXlCtVo41XNdfhOZ76YIvNRhjzCpYQW7XnyLs1KxBE/Kw9BMoOxJeZT6zm9b/
 6BY5zM3uZC9mQrEsepJzulEjp95qUgf7tAPlJoKLeYtdhBrVZ0+PL9CsquYiIyFek3
 M5V1fp43vNuKv4uAe9fXk/i7bWA40i7/rQxetxafcOAAoxhm/aRDqyYSf8fP6WYbvH
 mDd7Mac2rNgNw==
From: Mario Limonciello <superm1@kernel.org>
To: Harry Wentland <Harry.Wentland@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Decrease message about seamless boot
 enabled to debug
Date: Mon, 20 Jan 2025 13:49:01 -0600
Message-ID: <20250120194903.1048811-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120194903.1048811-1-superm1@kernel.org>
References: <20250120194903.1048811-1-superm1@kernel.org>
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

The message in amdgpu_dm about seamless boot is about an ASIC version
check and module parameter check.  It doesn't actually mean that seamless
boot will work.

Push this message into debug to avoid being disingenuous about it working
until it's been tested.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b5b099369c11..cbce9de5c357a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1965,7 +1965,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_device_seamless_boot_supported(adev)) {
 		init_data.flags.seamless_boot_edp_requested = true;
 		init_data.flags.allow_seamless_boot_optimization = true;
-		DRM_INFO("Seamless boot condition check passed\n");
+		drm_dbg(adev->dm.ddev, "Seamless boot requested\n");
 	}
 
 	init_data.flags.enable_mipi_converter_optimization = true;
-- 
2.43.0

