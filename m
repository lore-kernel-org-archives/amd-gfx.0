Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A5CAC5B3
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 15:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7858810E984;
	Thu, 25 Sep 2025 15:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Th1LPUkT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED1210E982
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 15:59:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 462E44538A;
 Thu, 25 Sep 2025 15:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620BEC113D0;
 Thu, 25 Sep 2025 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758815968;
 bh=px0p0ZFlFR5R3SXRYB0XszhBA19eDaPLZybdDC1Ln/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Th1LPUkTHOGAlpVHu2qIzdR7k7p/R76vWAKyisWaqWWh7I1HAwsUC6vc5xF9DwfA5
 w93yMRT/NuOtpncSTv0EaRYGYSD+T48OrsoFZmh28aSysCtmocYip2zQBA2mLIgjNw
 x14MEP/OvrBuUspEs9IaF88mVZpoAfYAa9vDGRHc6wlAGQLmazBNxRXgta+vj7Mqyy
 +E7dyR1s5GmOSsjABQ76VZe5Tt4YSTjBCJ7WFiTOWWOhwMeslzqgp+0dDZ6O27GT7C
 cFVFJdu/DLUk03IfpE0ofXqDHx7sw3POK0XO61DMox/T1f0+QHAGn7YfEvPT4WtBD1
 GB3Pi6Nt+6sog==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ionut Nechita <ionut_n2001@yahoo.com>, Kenneth Crudup <kenny@panix.com>
Subject: [PATCH v2 3/3] drm/amd: Fix hybrid sleep
Date: Thu, 25 Sep 2025 10:59:18 -0500
Message-ID: <20250925155918.2725474-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
References: <20250925155918.2725474-1-superm1@kernel.org>
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

[Why]
commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for
normal hibernation") optimized the flow for systems that are going
into S4 where the power would be turned off.  Basically the thaw()
callback wouldn't resume the device if the hibernation image was
successfully created since the system would be powered off.

This however isn't the correct flow for a system entering into
s0i3 after the hibernation image is created.  Some of the amdgpu
callbacks have different behavior depending upon the intended
state of the suspend.

[How]
Use pm_hibernation_mode_is_suspend() as an input to decide whether
to run resume during thaw() callback.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for normal hibernation")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Add tags
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 395c6be901ce7..dcea66aadfa33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering())
+	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
-- 
2.43.0

