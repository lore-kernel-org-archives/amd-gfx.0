Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E875D1CDC6
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Dec 2025 14:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7139D10E009;
	Sun,  7 Dec 2025 14:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eQYzC3VS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D7910E009
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5875360054
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Dec 2025 14:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920C3C4CEFB;
 Sun,  7 Dec 2025 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765116247;
 bh=0cMde3rZKHT9QhIJL8h5nq4rXHlQRFcH567mel5nhxs=;
 h=From:To:Cc:Subject:Date:From;
 b=eQYzC3VSvjLbj44z+L3gewzhPX3/ijKZNn5BHMYXbtro1gQwJJ1ErHz7ZjxHYXjca
 C21riKRtw2eTLZzkEvW3sDH56ZXfED7z9BWYNv+ujnakyNAoNjUKYeNOTXkPcZaWOA
 w/mOMcaY8ERFRgLvq5wfutzFHhe09l2ye018Jyif4GyI7gqbGsOSXjqsdfw/U6o9sz
 fqbVpU1G2aUv12enbRX1h8NOFiVturJHX9QljwHd1oV8XTbBfMT0ovkbTQFHRjdBhJ
 ZtuGgfmavq/V6JakAMX6mhDhkuDbJnfVHSTQhNBCQBnKzhhuiAq2OAoyQUmpbMoKUX
 c+r6nqqJBBMnQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 0/2] Make device links between KFD and GPU device
Date: Sun,  7 Dec 2025 08:04:00 -0600
Message-ID: <20251207140402.121338-1-superm1@kernel.org>
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

Mario Limonciello (AMD) (2):
  amdkfd: Only ignore -ENOENT for KFD init failuires
  amdkfd: Add device links between kfd device and amdgpu device

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  8 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 ++
 6 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.0

