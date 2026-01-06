Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490FCD0437
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 04:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC9910E1C6;
	Tue,  6 Jan 2026 04:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AkeI+TVx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A15F10E1C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 04:39:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B6DFD40326
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 04:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494AAC116C6;
 Tue,  6 Jan 2026 04:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767674377;
 bh=ol/uMIMEzvU8ekkBwnrBhXJyo4a8V7LsQGhXS06EV4c=;
 h=From:To:Cc:Subject:Date:From;
 b=AkeI+TVxQr8zMj4VWNQ3D5AjlSrJ0rusQMQ5agVxxgFNLrTAuL91VyVrtgUvlZmK6
 HMDJjHmHAjfpYZ9CbOIgK7fS0VgHW+UFfqMAZ7lvg67ymiwLxs7nfkS4z9bmOgZiut
 /kv9tcHK5plwqqfvAlGQbhnR5Mdg22SLR+eh+KPzMTdQqGHHISovwW/1mVOXEDa8l4
 Gp9e6YZbJL+R/6a8cP418jJlDrlng0EWHNIjANQ39awPscLz9UqavQ0H83sEb8VqSp
 nrCDXl/MU3fQoqgoL42EkWTeOYIvtbBoLP49Fn8RMHgfkTitUaLnzb4usQ0U5ewSF6
 W+/UG4u9fTgLw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Date: Mon,  5 Jan 2026 22:39:27 -0600
Message-ID: <20260106043927.51803-1-superm1@kernel.org>
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
get to run. Run them manually at the end of amdgpu_device_fini_hw()
when a device is already disconnected.

Closes: https://community.frame.work/t/amd-egpu-on-linux/8691/33
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 021ecc988ff79..4bac0d25547f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5263,6 +5263,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	if (drm_dev_is_unplugged(adev_to_drm(adev)))
 		amdgpu_device_unmap_mmio(adev);
 
+	/* surprise hotplug */
+	if (pci_dev_is_disconnected(adev->pdev))
+		amdgpu_amdkfd_device_fini_sw(adev);
 }
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
-- 
2.43.0

