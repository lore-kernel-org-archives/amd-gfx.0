Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA47CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 16:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6DF10E04F;
	Fri,  9 Oct 2026 16:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BN4mU+/B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C1D10E04F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 16:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C74E43B5A;
 Fri,  9 Oct 2026 16:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37791F000FF;
 Fri,  9 Oct 2026 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791562714;
 bh=NE4GSGjdyUFLGIjRGu6MqQlfoYhpG+jgvXdNxa7kHoE=;
 h=Date:From:To:Cc:Subject;
 b=BN4mU+/B0/tDOrdQQw1h/pKGHqMUJkE62rvhh7AJD8QtlJ9YjHJ7pGb+xG6B568Cx
 N2gGjZDiHI4+wpyATfRJdddQJrFgn/ObDOJfaVEuDfhJbsVHpbkFEQaKhRldlfTniE
 yby+F7wscsRpecKD0HevuNBCxkjpTm//66IGDdqnVR8cPagOTYWuMcbwUKQ0q3faEr
 n7Hi3PfhJANqpOY0I7okK24CKXrhyQKOIBfpVvA/wIZhv4mNo4lv2Y1GB4BcNGlxpI
 bUYCVORMirGad6ktkLqy5z8tdZ1V9SX0tQIDbVumubI2Sej3Jp+7FQBqyg5SDvpeve
 EFfq5shI275jw==
Date: Fri, 9 Oct 2026 11:18:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
 Jason Perlow <jperlow@gmail.com>
Subject: [GIT PULL] PCI fixes for v7.3
Message-ID: <20261009161832.GA980777@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-4

for you to fetch changes up to 79c168e2aa957ed0054c93db17caba653b95e377:

  PCI/AER: Skip error recovery on false alarms (2026-10-08 14:33:04 -0500)

This fixes some GPU initialization regressions caused by eddba19b8b5f
("PCI/AER: Support Advisory Non-Fatal Errors"), which appeared in v7.3-rc1.
That commit also caused a MacBookPro16,1 spontaneous power-off regression;
I expect a fix for that next week.

----------------------------------------------------------------

  - Skip error recovery if no unmasked errors were signaled, which fixes
    GPU initialization regressions caused by new Advisory Non-Fatal Error
    support (Lukas Wunner)

----------------------------------------------------------------
Lukas Wunner (1):
      PCI/AER: Skip error recovery on false alarms

 drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)
