Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F07D3E77A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFAF10E29D;
	Wed, 10 Dec 2025 20:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mXqMC8yJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FDF10E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:15:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 354D660123
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0F1C4CEF1;
 Wed, 10 Dec 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765397722;
 bh=XWKi7DkepQUBDVXJAWVVJapH3p2l/Q9jpZ+R0TmkUEc=;
 h=From:To:Cc:Subject:Date:From;
 b=mXqMC8yJi2mx8qV3XVuv3ier+yEszZfy5Jd5SHCPJkyQM2U14Q4NSDFCQf+MFtNJR
 obGx2YuvvgaxB//y8pTgDu6HJPHy3tkLGDOTDA1e2Sze5B0nxkt2zlgziBUvfsuVfy
 gJr/yaPglKLXCmOiAunHwbeDjMjmLMhbR9SyYLCUyZS7Y3EkPhPrBlEnbx6eq1ijNa
 npwjGnubWVnFbZ6yn2Ux0mmmtbpES+0xIvjAPXRgB51gT7a+lxX95zCpT996TtH5RW
 SPbzik3gAFVdJO0tqDOI2iOVrnzP7Hi73gsDhMYEAHGa5NHFUSiz6BKXkzvhVsH532
 JSTI2sr3kTPmQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/3] Make device links between KFD and GPU device
Date: Wed, 10 Dec 2025 14:15:07 -0600
Message-ID: <20251210201510.3000-1-superm1@kernel.org>
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

Discovering which KFD device is associated with a GPU is relatively
awkward right now in userspace.

This series creates sysfs links between the devices to simplify it
for userspace.

v2:
 * Add tag
 * Fix case that systems > 1 GPU wouldn't show links due to rebuilding
   topology.

Mario Limonciello (AMD) (3):
  amdkfd: Only ignore -ENOENT for KFD init failuires
  amdkfd: Don't rebuild node tree when calling
    kfd_topology_update_sysfs()
  amdkfd: Add device links between kfd device and amdgpu device

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  8 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 42 +++++++++++++++++--
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +
 6 files changed, 57 insertions(+), 6 deletions(-)

-- 
2.43.0

