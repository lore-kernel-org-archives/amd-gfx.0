Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37111C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E6F6113A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0E6F6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D856EDF0;
	Wed,  6 Oct 2021 18:23:31 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07336EDEF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:21:57 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d3600a30656d48e985313.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:3600:a306:56d4:8e98:5313])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A0B31EC0409;
 Wed,  6 Oct 2021 20:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1633544516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=pH1BgCGgyot6UfzzXy0SswyDq/UI1YakCT6GvUCirKw=;
 b=oVmbu+zc1maiohCcroG06IQIcsjl8Q9q3UgtvojYzwsuZVdAV/xkpZ98xRPQOzvRyf14pF
 BTB/m6iRzqe8ecmlxH8p0xopY+XFKBtvaUARBnIxzMirQWPvqIWH+a16jFJGEdyjnO06YQ
 e11g8v3++pB1AN3dgD6V8/qUXjVBPVA=
Date: Wed, 6 Oct 2021 20:21:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
Message-ID: <YV3pQCZ4GYbdpEm5@zn.tnic>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
 <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
X-Mailman-Approved-At: Wed, 06 Oct 2021 18:23:30 +0000
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

On Wed, Oct 06, 2021 at 02:10:30PM -0400, Alex Deucher wrote:
> This is not limited to Raven.

That's what the innocuous "a.o." wanted to state. :)

> All GPUs (and quite a few other
> devices) have a limited DMA mask.  AMD GPUs have between 32 and 48
> bits of DMA depending on what generation the hardware is.  So to
> support SME, you either need swiotlb with bounce buffers or you need
> IOMMU in remapping mode. The limitation with Raven is that if you want
> to use it with the IOMMU enabled it requires the IOMMU to be set up in
> passthrough mode to support IOMMUv2 functionality for compute support
> and due to other hardware limitations on the display side. So for all
> GPUs except raven, just having IOMMU enabled in remapping mode is
> fine.  GPUs from other vendors would likely run into similar
> limitations.  Raven just has further limitations.

Hmm, and in passthrough mode it would use bounce buffers when SME is
enabled. And when those 256K are not enough, it would fail there too,
even with IOMMUv2. At least this is how it looks from here.

Dunno, it feels like doing GPU compute and SME does not go hand-in-hand
real smoothly currently but that probably doesn't matter all too much
for both user camps. But that's just me with a hunch.

> Another option would be to enable SME by default on Epyc platforms,
> but disabled by default on client APU platforms or even just raven.

Thing is, we don't know at SME init time - very early during boot -
whether we're Epyc or client. Can we find that out reliably from the hw?

And even if we do, that's still not accurate enough - we wanna know
whether the IOMMU works.

So I guess we're all left to the user to decide. But I'm always open
to suggestions for solving things in sw and not requiring any user
interaction.

> Other than these comments, looks fine to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
