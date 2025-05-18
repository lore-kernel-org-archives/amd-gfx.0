Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564C4C3ABC9
	for <amd-gfx@archiver.kernel.org>; Sun, 18 May 2025 06:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6C710E1F2;
	Sun, 18 May 2025 06:28:04 +0000 (UTC)
X-Greylist: delayed 460 seconds by postgrey-1.36 at gabe;
 Sun, 18 May 2025 06:28:02 UTC
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053C810E1F2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 May 2025 06:28:02 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
 by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5631F2C051F8;
 Sun, 18 May 2025 08:19:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 6960054C2D; Sun, 18 May 2025 08:20:07 +0200 (CEST)
Date: Sun, 18 May 2025 08:20:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Denis Benato <benato.denis96@gmail.com>,
 Merthan Karaka?? <m3rthn.k@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Put PCIe ports with downstream devices into
 D3 at hibernate
Message-ID: <aCl8F0MA7JXSZYxf@wunner.de>
References: <20250514193406.3998101-1-superm1@kernel.org>
 <20250514193406.3998101-3-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514193406.3998101-3-superm1@kernel.org>
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

On Wed, May 14, 2025 at 02:34:05PM -0500, Mario Limonciello wrote:
> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
> pci_pm_suspend_noirq() in that PCIe ports that are power manageable should

Nit: s/should//

> without downstream devices in D0 should be put into their appropriate
> sleep state.

This leads to a lot of code duplication between pci_pm_suspend_noirq()
and pci_pm_poweroff_noirq().  Can the common portion of the code be moved
to a helper invoked by both functions so that it's easier to follow the
logic and understand common and differing parts of the suspend flow?

Thanks,

Lukas
