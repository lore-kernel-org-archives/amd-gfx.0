Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA31D0D170
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 21:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3879710E034;
	Wed,  7 Jan 2026 21:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UhoRBIt9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9FC10E034
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 21:37:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A24AF60007;
 Wed,  7 Jan 2026 21:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59A8C19421;
 Wed,  7 Jan 2026 21:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767821854;
 bh=Iuj2DC/80Fbtvy92+8ocp0Ob4j64NheL/N7rprE6MMM=;
 h=From:To:Cc:Subject:Date:From;
 b=UhoRBIt9EdbuElzDizRfW3PfsJx+ELy37nBM2IdrjW3oL6O95ybQPy0htpA339Zsy
 xf8HorA6sgakk8YsEMtuj6JiGIqEvKZGaZGiFkZwnu5mam8K9cTWYXKs6ttPoyPTgO
 gUpLNk/SnM2pttLOuuVpQnVGNHMa/ZM4lgKA76Vx9L8VeVPu7lfci535pFQVLunFu9
 t3T0M9GpKX02sUl4e72RU21sfx5C3nueOKCPLEcKKTPbzM0dJ/xXQjciQyPvKxFeVk
 CJSkWJ7ZWFaKL+n3IuxVeiKBGROqCHeu/RRerx72bD/tTcM3BMlxYdj59DnuQGu7NJ
 2JpM+p+EkAo4g==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	kent.russell@amd.com
Subject: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Date: Wed,  7 Jan 2026 15:37:28 -0600
Message-ID: <20260107213728.370011-1-superm1@kernel.org>
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

When an eGPU is unplugged the KFD topology should also be destroyed
for that GPU. This never happens because the fini_sw callbacks never
get to run. Run them manually before calling amdgpu_device_ip_fini_early()
when a device has already been disconnected.

This location is intentionally chosen to make sure that the kfd locking
refcount doesn't get incremented unintentionally.

Cc: kent.russell@amd.com
Closes: https://community.frame.work/t/amd-egpu-on-linux/8691/33
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Move the call earlier in amdgpu_device_fini_hw() to fix locking
   refcount issues
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 021ecc988ff79..f167ba1b6ffcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5251,6 +5251,14 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
+	/*
+	 * device went through surprise hotplug; we need to destroy topology
+	 * before ip_fini_early to prevent kfd locking refcount issues by calling
+	 * amdgpu_amdkfd_suspend()
+	 */
+	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+		amdgpu_amdkfd_device_fini_sw(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
-- 
2.43.0

