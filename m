Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB97C3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 19:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA9810E720;
	Wed, 14 May 2025 19:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XWbJw4Om";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A29D10E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 19:34:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CC0FB629DA;
 Wed, 14 May 2025 19:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB54C4CEE3;
 Wed, 14 May 2025 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747251275;
 bh=6ZhtYL9XJDANrJegpJCXnCuhUS/Ld27H9Ez7xl04a8M=;
 h=From:To:Cc:Subject:Date:From;
 b=XWbJw4Om0t0WHUIGln1+oKO/ad0zLXSHDcPm5ucZlmmPsXD0s4w6kMf9KAmVPpbn3
 uYaoUhz11UmfPghYeO5mX1Sk2jgp7bRW0FTwI6lmYPhB4waVWyO4nA6azj5hKMXfjE
 EbKRsT2+U2G3gTBf21D78bvQwKn0LE69LcY5ekk6i9Er0CeA0rjgTnLnEfgCtUgMUk
 RBBm7SIpNmLaJreBeN2XBOBj8XbQvqD9jUzXH5STBS2EJVVlwumn4KdVyOIfLEy/0I
 ID0Cuw2dyRA8T87Z7POJVs9S+3pGePi0GiTRXMmod9FADsPRfHfnNOnp4iaXTY2JUO
 4B7zLsmL1riug==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
 aka swsusp)), linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list),
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] Improvements to S5 power consumption
Date: Wed, 14 May 2025 14:34:03 -0500
Message-ID: <20250514193406.3998101-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

A variety of issues both in function and in power consumption have been
raised as a result of devices not being put into a low power state when
the system is powered off.

There have been some localized changes[1] to PCI core to help these issues,
but they have had various downsides.

This series instead tries to use the S4 flow when the system is being
powered off.  This lines up the behavior with what other operating systems
do as well.  If for some reason that fails or is not supported, unwind and
do the previous S5 flow that will wake all devices and run their shutdown()
callbacks.

Previous submissions [1]:
Link: https://lore.kernel.org/linux-pm/CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com/T/#m91e4eae868a7405ae579e89b135085f4906225d2
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/

Mario Limonciello (3):
  PM: Use hibernate flows for system power off
  PCI: Put PCIe ports with downstream devices into D3 at hibernate
  drm/amd: Avoid evicting resources at S5

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++
 drivers/pci/pci-driver.c                   | 39 ++++++++++++++++++++--
 kernel/reboot.c                            | 12 +++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.43.0

