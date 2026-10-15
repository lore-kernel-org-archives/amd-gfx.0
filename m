Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53630CC6B39
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 15:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73FB10EA03;
	Thu, 15 Oct 2026 15:16:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8AF510EA0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62CAB41454;
 Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A31F000C4;
 Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077412;
 bh=czOd1zQNZUMw6GYUrJDnQ96E5UzYrct07og54e6yZVI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=FnhN7rn2I9a3CYDafvP6ph9HvJGJLus1SL7dxzz9VKYPUJGPNeLGgEAVgkxo7IXpN
 ncyBPoZQBK/FMqML0x6qDwqP7pQx08xtTSuniOpfxskxUtHFPltIoaPY5c2qIdUiG5
 qFxB81eVLMz6xtEcNC7Q3tZ6r8tAbJ9oYOQQQ3DTicO3GmcRaCj59afGJKMbuayn1A
 GMzBYTkUhDt85X44JI2UsWUztLpbOTxXegYsxEEhUvdTsdD8GSLVFM2Gv0rN241rX9
 iFwQQ70fMZuKjr9r2bqnUoVBqc8OWW4y3mXmmdOf433kujdenSqi+dTmUk0C2mulg6
 0Vb8k3sB0qtqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A3A0392EB21; Thu, 15 Oct 2026 15:16:52 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261014201441.GA1661922@bhelgaas>
References: <20261014201441.GA1661922@bhelgaas>
X-PR-Tracked-List-Id: Upstream kernel work for Rockchip platforms
 <linux-rockchip.lists.infradead.org>
X-PR-Tracked-Message-Id: <20261014201441.GA1661922@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 tags/pci-v7.3-fixes-5
X-PR-Tracked-Commit-Id: 4e9f69d08253471d92bcc46b363fbada06bd59c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e177c722b3dd9ad432195b5c2cbbfe58c909a821
Message-Id: <179207741094.3496071.13040126142711127127.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:16:50 +0000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, amd-gfx@lists.freedesktop.org,
 Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>,
 Diederik de Haas <diederik@cknow-tech.com>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

The pull request you sent on Wed, 14 Oct 2026 15:14:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e177c722b3dd9ad432195b5c2cbbfe58c909a821

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
