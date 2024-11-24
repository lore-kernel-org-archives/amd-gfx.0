Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BA1D68BFF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Nov 2024 19:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124AD10E0B1;
	Sun, 24 Nov 2024 19:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JkMt69h9";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCAC10E0B1
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2024 19:00:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 466B3A40F91;
 Sun, 24 Nov 2024 18:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD03C4CECC;
 Sun, 24 Nov 2024 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732474807;
 bh=j700XncnWqwPhVKKIIvHw5fTsIhVOrR0PIIdWUkIzJE=;
 h=From:To:Cc:Subject:Date:From;
 b=JkMt69h9Tcfwn0q9PNLmEOucFbclk1HWt33fmE8HzCXpIKFV4X4BbVWN1WgvCmFFi
 sLmxbpuIA3Tkhx+i9CsfhjjQQpQNRBEAHPRGNPrkh8USMrD6ZwXIhAe4BX+qQ5AXIr
 v6lfs10tdx2m2hTz03+B/kpgrookKECfl7e0ZQwIJyS/SelR8BG43ZIL1WpRia5msh
 2lxFoVyKM0sywMxl7dZyGFCyrTTKfwuci9mRA4I4L4bQs6AuPzxOktt/IMgQh3cbZS
 5RT8I1+XrGFEU6rNvhr6N6dpcTYuY7xnkOoyrUqToo0v1JfuhuMt5MT4sGSZNE6y7D
 f7LaOmncDxoig==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 1/2] drm/amd: Invert APU check for
 amdgpu_device_evict_resources()
Date: Sun, 24 Nov 2024 13:00:00 -0600
Message-ID: <20241124190001.2633591-1-superm1@kernel.org>
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

Resource eviction isn't needed for s3 or s2idle on APUs, but should
be run for S4. As amdgpu_device_evict_resources() will be called
by prepare notifier adjust logic so that APUs only cover S4.

--
v2:
 * New patch

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0171d240fcb05..996e9c78384dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4735,8 +4735,8 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
 	int ret;
 
-	/* No need to evict vram on APUs for suspend to ram or s2idle */
-	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
+	/* No need to evict vram on APUs unless going to S4 */
+	if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
-- 
2.43.0

