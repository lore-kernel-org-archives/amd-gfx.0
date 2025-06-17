Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9C0C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 18:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D6210E074;
	Tue, 17 Jun 2025 18:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hNUl2sKx";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B339110E074
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 18:30:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 44E885C582D;
 Tue, 17 Jun 2025 18:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B3BC4CEE3;
 Tue, 17 Jun 2025 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750185058;
 bh=a+UTCPLpQ/eBYeyrWjXcX+OiOMGdzZUMzXQ12h69EFo=;
 h=From:To:Cc:Subject:Date:From;
 b=hNUl2sKxZf502+2QzSh3oDESK4H9mo10v0VNNXL87VIs1ta8zm2gyGOjOaIaHy2JB
 xNNc0rHRP11iiAUzR8NI8iEJLpSpQm02Wmasnhli1ey0PWgzu2dbY3KB80IT/PDEOe
 XzXCJqcS000w1eTrLvzhSKpMNUK75rfB8oHSH6w6hkaNG83Fta2tLRrnBqQEt3E7Dx
 ykTv8yOMibnDQ0xvO+dbEj0EbR9b9PgR1u4awnQmtG/aB0oVJCmkrlrs6aRme+cNay
 1IBuJ7anmwoEbyafF6Eohs6LPmmtbWshDyfSDfe8hmsHLR4ga1j76/ExJCqMUgA9PA
 uYMRh0pgLsqNg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: [PATCH v2] drm/amd: Adjust output for discovery error handling
Date: Tue, 17 Jun 2025 13:30:52 -0500
Message-ID: <20250617183052.1692059-1-superm1@kernel.org>
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

commit 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file
available") added support for reading an amdgpu IP discovery bin file
for some specific products. If it's not found then it will fallback to
hardcoded values. However if it's not found there is also a lot of noise
about missing files and errors.

Adjust the error handling to decrease most messages to DEBUG and to show
users less about missing files.

Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4312
Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Fixes: 017fbb6690c22 ("drm/amdgpu/discovery: check ip_discovery fw file available")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add tag
 * Push error message into default flow only
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a0e9bf9b27108..a29bd807e59f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -321,10 +321,9 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
 	const struct firmware *fw;
 	int r;
 
-	r = request_firmware(&fw, fw_name, adev->dev);
+	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
 	if (r) {
-		dev_err(adev->dev, "can't load firmware \"%s\"\n",
-			fw_name);
+		drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);
 		return r;
 	}
 
@@ -459,16 +458,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
 	if (fw_name != NULL) {
-		dev_info(adev->dev, "use ip discovery information from file");
+		drm_dbg(&adev->ddev, "use ip discovery information from file");
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
-
-		if (r) {
-			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
-			r = -EINVAL;
+		if (r)
 			goto out;
-		}
-
 	} else {
+		drm_dbg(&adev->ddev, "use ip discovery information from memory");
 		r = amdgpu_discovery_read_binary_from_mem(
 			adev, adev->mman.discovery_bin);
 		if (r)
@@ -1338,10 +1333,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	int r;
 
 	r = amdgpu_discovery_init(adev);
-	if (r) {
-		DRM_ERROR("amdgpu_discovery_init failed\n");
+	if (r)
 		return r;
-	}
 
 	wafl_ver = 0;
 	adev->gfx.xcc_mask = 0;
@@ -2579,8 +2572,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	default:
 		r = amdgpu_discovery_reg_base_init(adev);
-		if (r)
-			return -EINVAL;
+		if (r) {
+			drm_err(&adev->ddev, "discovery failed: %d\n", r);
+			return r;
+		}
 
 		amdgpu_discovery_harvest_ip(adev);
 		amdgpu_discovery_get_gfx_info(adev);
-- 
2.43.0

