Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB7D1CDC6
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Dec 2025 14:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7637710E03A;
	Sun,  7 Dec 2025 14:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BCHKKAnt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F92110E00E
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE496600AA
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EC6C19422;
 Sun,  7 Dec 2025 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765116248;
 bh=apf6Z9w75758pFe1IDXyo3nd2dIg6sEDqMlOLb1wqRM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BCHKKAnteSJZ9OEJztSGqoPrYF8heG8+fc+uR4gPe5isOtl23qAW0zbcNi4hmCfNE
 9U1ZjQgAfqvJVN01dp1CeZ4DdSVVC7Gh4oSI0ESyj+GnVcpC4LIpdmG0BbSMRwm7kU
 BXL1IFu2ocqtX3Fu0tqyJb4k7HczwLoFMAkZJVlwKWZn2mIz/Q5Maw3NTVzWPnRgJc
 hSsAtBmKrqgz8yTrg4ldPBGcDBQTQPqTRyrr6sLWi0nwkoNs8cz/bBWf2dOBptGrHU
 qM0nisydZf5N35fYZTt0kBtt0AuXfjTuaJ18rdHFxDdxZGhc0o9+HxHyco2UwaeGuv
 7DCQLa/Om1ehw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 1/2] amdkfd: Only ignore -ENOENT for KFD init failuires
Date: Sun,  7 Dec 2025 08:04:01 -0600
Message-ID: <20251207140402.121338-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251207140402.121338-1-superm1@kernel.org>
References: <20251207140402.121338-1-superm1@kernel.org>
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

When compiled without CONFIG_HSA_AMD KFD will return -ENOENT.
As other errors will cause KFD functionality issues this is the
only error code that should be ignored at init.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16adeba4d7e68..e804461e5f272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3169,8 +3169,10 @@ static int __init amdgpu_init(void)
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
 
-	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
-	amdgpu_amdkfd_init();
+	/* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
+	r = amdgpu_amdkfd_init();
+	if (r && r != -ENOENT)
+		goto error_fence;
 
 	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-- 
2.43.0

