Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1402C5B543
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 01:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C87E10E149;
	Mon,  2 Jun 2025 01:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n9G9eSe6";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50AB10E149
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 01:44:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B562CA4FE08;
 Mon,  2 Jun 2025 01:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0831FC4CEF1;
 Mon,  2 Jun 2025 01:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748828681;
 bh=xSHZbX1Jgv3nWJ3Aa7Vi+fSnOOVQkqawh6HuBquXUOc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n9G9eSe6KTrSEdLw0ygxZz/aKJqsGS9NLgCPza6lMxiobCjeWtiAfY4D49luOgCAx
 MUuCPeg4LhsyNQETgQ9hvvbJCdZS79px5Of5tBg9GcgsyDlZeyphUAJPZdXLgABAJK
 rN9dmzFd8bzJMEfw0+yhhqhXYcj4jfVRgvgsZOFmzX0Io1JCd7IMbCrjPh0YOKyZG9
 nbpINmG9MbAweqIdeBfaR0kaEV2Xrx2j+TS6uJuMFcf5MQ3I7alIZWK+nlOPfevNDK
 nV6b1/zcIHQ+G3PGk3rYEiqHxgy1BdZdhjxhVLf9L4qG3wAgr744sp1R56HbcFncls
 hyXWWX3q8aDOg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] drm/amd/display: Stop storing failures into
 adev->dm.cached_state
Date: Sun,  1 Jun 2025 20:44:31 -0500
Message-ID: <20250602014432.3538345-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602014432.3538345-1-superm1@kernel.org>
References: <20250602014432.3538345-1-superm1@kernel.org>
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

If drm_atomic_helper_suspend() has failed for any reason, it's stored
in adev->dm.cached_state.  This isn't expected because the resume
(or complete()) sequence will attempt to use the stored state to
resume.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1797fa85fac6a..1f5894d8f2fb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3060,6 +3060,19 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
+static int dm_cache_state(struct amdgpu_device *adev)
+{
+	int r;
+
+	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	if (IS_ERR(adev->dm.cached_state)) {
+		r = PTR_ERR(adev->dm.cached_state);
+		adev->dm.cached_state = NULL;
+	}
+
+	return adev->dm.cached_state ? 0 : r;
+}
+
 static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3068,11 +3081,8 @@ static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
 		return 0;
 
 	WARN_ON(adev->dm.cached_state);
-	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
-	if (IS_ERR(adev->dm.cached_state))
-		return PTR_ERR(adev->dm.cached_state);
 
-	return 0;
+	return dm_cache_state(adev);
 }
 
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
@@ -3106,9 +3116,10 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	}
 
 	if (!adev->dm.cached_state) {
-		adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
-		if (IS_ERR(adev->dm.cached_state))
-			return PTR_ERR(adev->dm.cached_state);
+		int r = dm_cache_state(adev);
+
+		if (r)
+			return r;
 	}
 
 	s3_handle_hdmi_cec(adev_to_drm(adev), true);
-- 
2.43.0

