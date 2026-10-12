Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B56CA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 19:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9B510E1A9;
	Mon, 12 Oct 2026 19:26:49 +0000 (UTC)
X-Greylist: delayed 536 seconds by postgrey-1.36 at gabe;
 Mon, 12 Oct 2026 19:26:47 UTC
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.78.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E593110E1A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 19:26:47 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout2.hostsharing.net (Postfix) with ESMTPS id 9854285EA;
 Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 7611860000B7; Mon, 12 Oct 2026 21:17:49 +0200 (CEST)
Date: Mon, 12 Oct 2026 21:17:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
 Jason Perlow <jperlow@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <as0yXccnanni6KZe@wunner.de>
References: <ash0Rn78gwlQ87Fg@wunner.de>
 <20261009150724.GA974326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009150724.GA974326@bhelgaas>
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

On Fri, Oct 09, 2026 at 10:07:24AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 09, 2026 at 06:57:42AM +0200, Lukas Wunner wrote:
> > Apple products with a T2 Secure Enclave will require a separate patch
> > which avoids enabling Advisory Non-Fatal Errors on this particular device.
> > A quirk, in other words.
> > 
> > I think the firmware on the T2 is upgradable in principle, but Apple isn't
> > going to do us the favor to fix it.  So we don't have any other option
> > than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> > the first device on that blacklist and maybe others to follow.
> 
> OK, it sounds like two separate issues needing two separate patches to
> fix.  So I think I'll ask Linus to pull this fix today and watch for
> the quirk next week.

In case it's not obvious, the quirk necessary for the Apple T2
was submitted by Aditya here:

https://lore.kernel.org/r/20261010172301.12764-1-aditya.garg@linux.dev/

Also, Jason attached a functionally identical patch to this e-mail:

https://lore.kernel.org/r/CABZrw2H+3yt2Y7xiq6OyAWaJM7P9ox-2nJxoQuJMwoJHLgi+YQ@mail.gmail.com/

Either patch is a viable fix for this problem.

Thanks,

Lukas
