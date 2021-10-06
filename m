Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286D861130
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 286D861130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4166EDEB;
	Wed,  6 Oct 2021 18:21:53 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECE86EDEB
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:21:52 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 c6-20020a9d2786000000b005471981d559so4233990otb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q1IrU7LurHB+1r7/eWXtt6A8U5je8/FlF0Tr/IMUcTs=;
 b=mpjGcJbVYeJkf+lzw2EnT+ZD94t/uXc7m8RAHBl4ZWG1jgTs/NsHv7sgQKOPhWJcLm
 I5rlTnkh0WB5u0zDgFHcBL9HgudpFpWx/Quh1ya9OXzWSyI2YHE5aPfJSHZoqtFMWLr5
 a6qo3TfmmmBHS3TSlAwS8W9LHGhDUhO6Kq7bW7v8WXhagXnRLuDN0hmdCMOvipJjl2nw
 tB1ZdsX74WoMBvCaW76Rp20MAG9VPxTV3lG9JB1Ex4Hmpl9XTzgYSMpD22iOFost5d3w
 NxvVJOIgucFszAAo3KExPESxTRdyahtI0Xupgo5/QQWPdft0EH1qO4BqueGY341dWcIn
 Xzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q1IrU7LurHB+1r7/eWXtt6A8U5je8/FlF0Tr/IMUcTs=;
 b=ep+h3y8rr/Sxt6s6sML28GGrzM5ofKvvlqR2Js81BLgAaN9xfT2jIIqCkOI0uiZuDa
 x9kE5EJcA6AfmWtvO745mAlNmHJGJ0OblaK+RF9+GWTbNkT1o3u1o9CahKyg/7bgNJO1
 Uiee7rU5eIPbvQlk8K1HiX9SbawOW03ZEPGrGBeqlPqyqXEA2bXy38O3bGdiEAU/w2JX
 n9KJiqpFpmFbqkaAtUQ254K/lCenNMivKmgI8/L7kRbGkoGYmH9NUrGQMgrMiYIV7GJ2
 OEoFnuj16u4RLNhDfC3jfg7tLWS2IgP1qcTCV41aoAIqryrJpJbLfl7yenZEYl1gW2eQ
 AGnA==
X-Gm-Message-State: AOAM532jTrDEVuEPMf8+pFojaPA7Q4H8b+OGEdCPHAxRnf1/HaofytET
 0t3r/gXPoHj984bDMa00Z7RtkDuMeRLatDhQafU=
X-Google-Smtp-Source: ABdhPJzqrH+cvH4IRHtTok5MSv/AJtJSk3KhUyBWETrT+GSDb4LtMSJnYNyQr1nbGoCKxi8vf/lkuEHORE3/6RD4xE0=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr194281otd.200.1633544511418; 
 Wed, 06 Oct 2021 11:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
In-Reply-To: <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Oct 2021 14:21:40 -0400
Message-ID: <CADnq5_M2y1tUAcUPNOrmB=pHfBGtnqMtTrw24ZC45202hg-kYw@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 X86 ML <x86@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

And just another general comment, swiotlb + bounce buffers isn't
really useful on GPUs.  You may have 10-100s of MBs of memory mapped
long term into the GPU's address space for random access.  E.g., you
may have buffers in system memory that the display hardware is
actively scanning out of.  For GPUs you should really only enable SME
if IOMMU is enabled in remapping mode.  But that is probably beyond
the discussion here.

Alex

On Wed, Oct 6, 2021 at 2:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 1:48 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Ok,
> >
> > so I sat down and wrote something and tried to capture all the stuff we
> > so talked about that it is clear in the future why we did it.
> >
> > Thoughts?
> >
> > ---
> > From: Borislav Petkov <bp@suse.de>
> > Date: Wed, 6 Oct 2021 19:34:55 +0200
> > Subject: [PATCH] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> >  automatically
> >
> > This Kconfig option was added initially so that memory encryption is
> > enabled by default on machines which support it.
> >
> > However, Raven-class GPUs, a.o., cannot handle DMA masks which are
> > shorter than the bit position of the encryption, aka C-bit. For that,
> > those devices need to have the IOMMU present.
>
> This is not limited to Raven.  All GPUs (and quite a few other
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
>
>
> >
> > If the IOMMU is disabled or in passthrough mode, though, the kernel
> > would switch to SWIOTLB bounce-buffering for those transfers.
> >
> > In order to avoid that,
> >
> >    2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
> >
> > disables the default IOMMU passthrough mode so that devices for which
> > the default 256K DMA is insufficient, can use the IOMMU instead.
> >
> > However 2, there are cases where the IOMMU is disabled in the BIOS, etc,
> > think the usual hardware folk "oops, I dropped the ball there" cases.
> >
> > Which means, it can happen that there are systems out there with devices
> > which need the IOMMU to function properly with SME enabled but the IOMMU
> > won't necessarily be enabled.
> >
> > So in order for those devices to function, drop the "default y" for
> > the SME by default on option so that users who want to have SME, will
> > need to either enable it in their config or use "mem_encrypt=on" on the
> > kernel command line.
>
> Another option would be to enable SME by default on Epyc platforms,
> but disabled by default on client APU platforms or even just raven.
>
> Other than these comments, looks fine to me.
>
> Alex
>
> >
> > Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: <stable@vger.kernel.org>
> > Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
> > ---
> >  arch/x86/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 8055da49f1c0..6a336b1f3f28 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
> >
> >  config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
> >         bool "Activate AMD Secure Memory Encryption (SME) by default"
> > -       default y
> >         depends on AMD_MEM_ENCRYPT
> >         help
> >           Say yes to have system memory encrypted by default if running on
> > --
> > 2.29.2
> >
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
