Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A95FCA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C7210E2B1;
	Thu,  8 Oct 2026 17:17:10 +0000 (UTC)
X-Greylist: delayed 486 seconds by postgrey-1.36 at gabe;
 Thu, 08 Oct 2026 17:17:08 UTC
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B596110E2B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:17:08 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout3.hostsharing.net (Postfix) with ESMTPS id 5554CC37;
 Thu, 08 Oct 2026 19:09:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 3333560CF5D2; Thu,  8 Oct 2026 19:09:00 +0200 (CEST)
Date: Thu, 8 Oct 2026 19:09:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>,
 Jason Perlow <jperlow@gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
Message-ID: <asfOLOMCKt2ZxrJv@wunner.de>
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
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

On Thu, Oct 08, 2026 at 11:19:22AM -0400, Alex Deucher wrote:
> On Thu, Oct 8, 2026 at 8:26???AM Lukas Wunner <lukas@wunner.de> wrote:
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
> > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> 
> FWIW, I only tested this patch in conjunction with the other two
> patches you had posted on the ticket.  I haven't tried just this patch
> alone.

This patch alone should avoid the issues you're seeing both
on the Vega20 system (the first one you reported in the bugzilla) and
on the Navi10 system (the second one).

On both systems, the BIOS is signaling a Fatal Error via Firmware First
error handling even though the error status registers are blank.

The Vega20 log says that error recovery failed because no driver was
bound to the GPU.  The two additional patches you tested with avoid this
error message because they change error recovery to tolerate unbound
devices.  But by not attempting recovery on false alarms in the first
place, it becomes irrelevant whether the device is bound.

I had skimmed the log after your initial report, saw the message about
recovery failing for unbound devices and hence pointed you to the
patches which tolerate unbound devices on error recovery.

Then on closer inspection of the logs I realized that the error status
registers are completely blank, so the error reported by firmware is
bogus and attempting recovery is pointless.

For native error handling (i.e. not Firmware First), we already check
whether "status & ~mask" is zero in aer_get_device_error_info() and
skip recovery if so.  This patch aligns Firmware First error handling
with native error handling in that regard.

Thanks,

Lukas
