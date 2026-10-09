Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF4CA6015
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 04:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA5410E198;
	Fri,  9 Oct 2026 04:57:45 +0000 (UTC)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E349210E198
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 04:57:44 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout1.hostsharing.net (Postfix) with ESMTPS id 9F678377;
 Fri, 09 Oct 2026 06:57:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 754216013EAB; Fri,  9 Oct 2026 06:57:42 +0200 (CEST)
Date: Fri, 9 Oct 2026 06:57:42 +0200
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
Message-ID: <ash0Rn78gwlQ87Fg@wunner.de>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008191705.GA917105@bhelgaas>
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

On Thu, Oct 08, 2026 at 02:17:05PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> > 
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
[...]
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
[...]
> Applied to pci/for-linus for v7.3, thanks!
[...]
> If we're confident that this also fixes the MacBookPro16,1 power-off
> issue reported by Jason (it would be ideal if you could test this,
> Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> If so, I'd like to add Jason's Reported-by and link.
> 
> But if we're not sure whether this fixes the MacBookPro16,1 power-off
> issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> it with this fix and try again for v7.4.

Apple products with a T2 Secure Enclave will require a separate patch
which avoids enabling Advisory Non-Fatal Errors on this particular device.
A quirk, in other words.

I think the firmware on the T2 is upgradable in principle, but Apple isn't
going to do us the favor to fix it.  So we don't have any other option
than keeping a blacklist for ANFE-incompatible devices, with the T2 being
the first device on that blacklist and maybe others to follow.

I was going to work on this for the remainder of the week, but if you feel
the feature needs another cycle to mature, I have no objections to
reverting eddba19b8b5f for v7.3 and re-applying it together with the two
required fixes to pci/aer.  (The two required fixes being the one for Alex
and the one for the T2.)

Thanks,

Lukas
