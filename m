Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D2D5B87C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 06:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6608D10E6D4;
	Tue, 16 Dec 2025 06:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="II4S/wGJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7530610E6EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:00:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 30E1F43048
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E26C4CEF1;
 Tue, 16 Dec 2025 06:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765864855;
 bh=NFoHxd1rLi4d4osTb646IyK3qDP5g9r5v+4AdB+dRqw=;
 h=From:To:Cc:Subject:Date:From;
 b=II4S/wGJ6JKtRBfW6IZB560iBPbcI+KsBl5cTMwANXi85dvCZv81qIKk29ebcfWmv
 V8712QBtlA5VswpyxNFZktUSW0G0Gk1Nm+QgORiyrAROsAhEVbmEpCdl8OSjJCOLNe
 b/GLwrqUqm+w/zuo05sKZQ33SGGM5T7mG4n+2F6FWuEFauDVyQs8vDXY4gJoBCxib2
 JfqdSsvy72dklCve9joPo0fgjAnnwCsaOqsbRn7UI+zO6XEJ43ODeF549oR9mAVWtU
 3YhXKpa8QhJFbLTze2qE7YMgFnUHyaqxvRiwXeYoMbDQ1FE4bb1vpgWjQYRxwFkz4r
 fnyJgTOOLvDVw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v3 0/2] Make device links between KFD and GPU device
Date: Tue, 16 Dec 2025 00:00:44 -0600
Message-ID: <20251216060046.3131-1-superm1@kernel.org>
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

Discovering which GPU device is associated with a KFD node is
relatively awkward right now in userspace.

This series creates a link from KFD to GPU to simplify it
for userspace.

Mario Limonciello (AMD) (2):
  amdkfd: Only ignore -ENOENT for KFD init failuires
  amdkfd: Add device links between kfd device and amdgpu device

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c       | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
 6 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.43.0

