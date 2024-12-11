Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3654DE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 15:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC1210E60F;
	Wed, 11 Dec 2024 15:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fvRVd/9n";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DB810E60F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 15:56:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E3F2C5C62FA;
 Wed, 11 Dec 2024 15:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDFFC4CED2;
 Wed, 11 Dec 2024 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733932572;
 bh=rd6Tu1NDlEijFl2n8w2TdBbOckZfjxqeQ7/arMSl1XY=;
 h=From:To:Cc:Subject:Date:From;
 b=fvRVd/9nFlGu59432hzFb5piUw1W27MjY1zeT0UOCs+vvWnefuS2qOQMDAk2RdeAw
 bPJBJbiNEw+YXZUmPCD0J6ZrJkOyisIa/+gAejBw++nUvj7xMjyEvJuEg1Sst8ARNE
 WWdH5o8CQpN5Mygi8zUe9ynLlJF7lpPaqEBJrjFDna7qzWAytkAPvrZbCj4c6GiCjw
 3tHg5ah7faHU1rD5D1bORrMHEABI6qJsF3UnAeobpbxGbbfkPODHXm2PC4K8E2EPIj
 fjoabbc28oxi0uaKn2ujoIFAlVfsz3ZS4nLmCAR8a+kVaoL6J6B/cS4XV0OFmKmdlS
 tSHYlbQJBpSOA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Gabriel Marcano <gabemarcano@yahoo.com>
Subject: [PATCH] drm/amd: Require CONFIG_HOTPLUG_PCI_PCIE for BOCO
Date: Wed, 11 Dec 2024 09:56:01 -0600
Message-ID: <20241211155601.3585256-1-superm1@kernel.org>
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

If the kernel hasn't been compiled with PCIe hotplug support this
can lead to problems with dGPUs that use BOCO because they effectively
drop off the bus.

To prevent issues, disable BOCO support when compiled without PCIe hotplug.

Reported-by: Gabriel Marcano <gabemarcano@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707#note_2696862
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 764d41434a82f..7db796ebb967e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -419,6 +419,9 @@ bool amdgpu_device_supports_boco(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		return false;
+
 	if (adev->has_pr3 ||
 	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
 		return true;
-- 
2.43.0

