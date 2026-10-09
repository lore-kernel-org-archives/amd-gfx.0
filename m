Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBBFCA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977AC10E9B6;
	Fri,  9 Oct 2026 15:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/aRiNmV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1F410E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:07:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C546960098;
 Fri,  9 Oct 2026 15:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53C1F00893;
 Fri,  9 Oct 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791558445;
 bh=Yc4wezejOuATtX+/xD62oIcWyMlHYCGQf4E0gpjKHZg=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=C/aRiNmVkNEuBLKRmeE6ewObnb27+Vw3S+hbRtFUJQqlzChgB/xrPXH+JASEb9dOz
 wxfwRKzmIFjMyRwkcGb5WlHQ7YwFeXCqCjR0OvFgxL9qbwdY9gDjPlnvDVPovlgppc
 EzCnIE6GsNyWGHDiNHcGfkAanpsFUhA5xMnBNbCutl34iycb4lwmpc6vrlv3+Aycrc
 8Ac9fhtwz4hYm8tyCjNNPm20Z9a3QBAHuu71k/X34pZZom6WaMy1/u6xEf6HyiKjD8
 EhoL4njP4J9Fh9hC3rKxA0MsO8o3r7p1cmuGg1vvFu8wAB4qMnzc0fCK+TLuXsbQ/d
 HrRCkVAAtjjJQ==
Date: Fri, 9 Oct 2026 10:07:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
 Jason Perlow <jperlow@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <20261009150724.GA974326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ash0Rn78gwlQ87Fg@wunner.de>
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

On Fri, Oct 09, 2026 at 06:57:42AM +0200, Lukas Wunner wrote:
> On Thu, Oct 08, 2026 at 02:17:05PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > recover from a Firmware First reported Fatal Error.
> > > 
> > > However all status registers in the Root Port's AER Extended Capability
> > > are blank, so apparently the platform firmware raised a false alarm.
> [...]
> > > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > > actually signaled.
> [...]
> > Applied to pci/for-linus for v7.3, thanks!
> [...]
> > If we're confident that this also fixes the MacBookPro16,1 power-off
> > issue reported by Jason (it would be ideal if you could test this,
> > Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> > If so, I'd like to add Jason's Reported-by and link.
> > 
> > But if we're not sure whether this fixes the MacBookPro16,1 power-off
> > issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> > it with this fix and try again for v7.4.
> 
> Apple products with a T2 Secure Enclave will require a separate patch
> which avoids enabling Advisory Non-Fatal Errors on this particular device.
> A quirk, in other words.
> 
> I think the firmware on the T2 is upgradable in principle, but Apple isn't
> going to do us the favor to fix it.  So we don't have any other option
> than keeping a blacklist for ANFE-incompatible devices, with the T2 being
> the first device on that blacklist and maybe others to follow.
> 
> I was going to work on this for the remainder of the week, but if you feel
> the feature needs another cycle to mature, I have no objections to
> reverting eddba19b8b5f for v7.3 and re-applying it together with the two
> required fixes to pci/aer.  (The two required fixes being the one for Alex
> and the one for the T2.)

OK, it sounds like two separate issues needing two separate patches to
fix.  So I think I'll ask Linus to pull this fix today and watch for
the quirk next week.

Bjorn
