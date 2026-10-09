Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B3BCA9EBB
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 23:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09598112320;
	Fri,  9 Oct 2026 23:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nkbbsnDh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD93112320
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 23:32:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B281C60211;
 Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE81F000FF;
 Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791588749;
 bh=XsAAW/EodyzMUQNgpqDd1gVryRXCL0iBRw+vyKGYF0s=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=nkbbsnDhHbcUgWZxIPr4zlCDEyiIgwFB2oGgjt+OVD8YOCXu6BTTOrunpugbwVcv/
 md5wDlzXDz7oboIjx2Aq/b+fxAGAqBswhSulNnMUSWbfY3WTDJSSbeZOlt3sBBd6oH
 2Lygkj3nrqT0K0M0gqPBmxKU/t5JzZ/NTGTlC7I9ba90zFLQAKvwntHuLOEMW6Kf1B
 V1KjVbuGNdEgyWR4gc/RR+wVriN4c4nsC2Z4XyDb/RPdtSKBAro4oadq0QQn11RuvJ
 TiOfXGdpJgIlBFeaegVak/6b4npZ/dPZYtqE7Amp2/XZAmeShdeat5DV5LW5w+Gdqh
 OcFc1GSNJbhWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A4C139263A7; Fri,  9 Oct 2026 23:32:29 +0000 (UTC)
Subject: Re: [GIT PULL] PCI fixes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009161832.GA980777@bhelgaas>
References: <20261009161832.GA980777@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261009161832.GA980777@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 tags/pci-v7.3-fixes-4
X-PR-Tracked-Commit-Id: 79c168e2aa957ed0054c93db17caba653b95e377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
Message-Id: <179158874784.1049084.5856116017471433775.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 23:32:27 +0000
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
 Aditya Garg <aditya.garg@linux.dev>, Jason Perlow <jperlow@gmail.com>
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

The pull request you sent on Fri, 9 Oct 2026 11:18:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.3-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
