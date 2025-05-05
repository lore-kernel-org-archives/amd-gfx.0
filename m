Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ABBC3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 22:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4DC10E446;
	Mon,  5 May 2025 22:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kl4JjjET";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F387F10E446;
 Mon,  5 May 2025 22:19:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1815C444CC;
 Mon,  5 May 2025 22:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49843C4CEE4;
 Mon,  5 May 2025 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746483542;
 bh=Z9IFOu4PacnKKHtb6lAtZ/8jE/G/tPuhMUua38YxDJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kl4JjjETWwKbR4SI1xOPcqo0C5DBuoiDv/jHkRKf9yBbBSYE07lZRiOIv1k7faxPn
 41Aa4OYzOUGJrZjD+zYQ4eI7vuwmzitXT7yzsrpW79GLEvae8YOgNeJmLcT19ftRT1
 uku05a6erwtGPwu7H56Dfin55faS+pG306bH8I38HrDnCE8jV+IWwQ+AP+dm7fqjdn
 AuoN/BujPl66d5SUWZzMY9t5TXBgn6MQrXMRxrPNqP2xpPX1jFdwPnHojV40s62teX
 S9QGae9ctTKry3SyBhq6073evpbpdGUIYKpVtXIy06A0eFij9e8q2KuKfnGLC6V2k8
 in/mDlc0W7gLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kent Russell <kent.russell@amd.com>, Sasha Levin <sashal@kernel.org>,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 lijo.lazar@amd.com, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 106/642] drm/amdgpu: don't free conflicting
 apertures for non-display devices
Date: Mon,  5 May 2025 18:05:22 -0400
Message-Id: <20250505221419.2672473-106-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 9deacd6c55f1b31e5ab20db79df2e14ac480203c ]

PCI_CLASS_ACCELERATOR_PROCESSING devices won't ever be
the sysfb, so there is no need to free conflicting
apertures.

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3e4201a405c8..9cde62b178c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4370,10 +4370,17 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	/* Get rid of things like offb */
-	r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
-	if (r)
-		return r;
+	/*
+	 * No need to remove conflicting FBs for non-display class devices.
+	 * This prevents the sysfb from being freed accidently.
+	 */
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA ||
+	    (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER) {
+		/* Get rid of things like offb */
+		r = aperture_remove_conflicting_pci_devices(adev->pdev, amdgpu_kms_driver.name);
+		if (r)
+			return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
-- 
2.39.5

