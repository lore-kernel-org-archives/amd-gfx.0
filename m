Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4028CCF9EA
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C9410E287;
	Sun, 26 Oct 2025 04:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FNQ/kyRv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70FC10E1B5
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4240560302
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBFCC4CEF7;
 Sun, 26 Oct 2025 04:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453003;
 bh=NglDHfAn5NxaRpJs7BKBlsP5LwDmuu75zsCQsXn+uP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FNQ/kyRvVk46eIlMwe4KmGZHon3bnoic/s0qmlBq/jDv3zQAJJlTIENPeAr9n3IKx
 9MaV7CAn7Z/Tj7/G84s77IpQJ9Pc5rJ3/8XTtlMMxPgdFdNRkxfiAqTRy3d3zig+er
 meflyyGleVPa4dfniRa7VcN7Qo89HGVD7gClIDZyRvErglFKVCWsX3NMyO2HddTF0h
 /TuLBq0ZkIZic/oNmEe8Fg4zcOSNLbvDxFw62THB2u28coPoYLCP/Uw7+mLPq/Ari6
 6DrpTedg7SBI7TQUfJs11/WTabKavh+BoHJQnQpoeSdS4CBMZctP+2lreK8W5D5E+p
 vZSTTR8K5g37w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v5 5/5] drm/amd: Reset the GPU if pmops failed
Date: Sat, 25 Oct 2025 23:29:40 -0500
Message-ID: <20251026042942.549389-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026042942.549389-1-superm1@kernel.org>
References: <20251026042942.549389-1-superm1@kernel.org>
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

If the GPU fails to suspend the return code is passed up to the caller
but it's left in an inconsistent state.  This could lead to hangs
if userspace tries to access it.

The last stage of all pmpops calls (success or fail) is the complete()
callback.  If by the time the PM core reaches this state the GPU is still
in suspend something went really wrong, so reset it.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Handle case of DPM_FLAG_SMART_SUSPEND (Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cee90f9e58a9..4d437e31d1bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2590,6 +2590,17 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	/* sequence failed, use a big 🔨 try to cleanup */
+	if (adev->in_suspend && !pm_runtime_suspended(dev)) {
+		adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+		dev_crit(adev->dev, "pmpops sequence failed, resetting\n");
+		amdgpu_asic_reset(adev);
+		return;
+	}
+
 	amdgpu_device_complete(dev_get_drvdata(dev));
 }
 
-- 
2.51.1

