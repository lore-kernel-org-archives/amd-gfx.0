Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8390C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3977610E8F5;
	Mon, 13 Dec 2021 20:30:02 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D0210E8F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:30:01 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id m6so24757554oim.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 12:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5YWSkPBIkrW8C7SP3x48mv5Im1AI/XMTYnQTSln74oA=;
 b=EbWkAP/QzuVqbamzPCNbhjf53MDGjFmymZ+91ng7n0uGxJ/sZm3CRkTQu49AbcSyDt
 m3Er7npaLxGlqChp05V+IGIY96k9pjVc3jKbJwjhB1YIKk9oSXoqo5pz3ocY4qDALR9A
 3mLGdUJxuhYHXqZCUEQBm8tlNs3rvJJdl+cpVJ++faOFrEkF72PPNVxsoaQW25UWAUZb
 f2AFOoDSwvAG/Z1F5zcyCt4xElcWMpkeTbqTkxyIzdJg12ae3Jg3P7rXfXCOVjspcZPR
 OSpoGEFNjPNdoj0nD5C+CwV8F9jbapQjVKgTJbI0xPd9uCmxWXksvOyQyOAM7IeZzRdz
 slvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5YWSkPBIkrW8C7SP3x48mv5Im1AI/XMTYnQTSln74oA=;
 b=mhKtrlt9DDmk0kwKRYXOE32Gzq/41zQLeCof6awQCPE0gWr7N7hPvmhjOAoI0Qse0p
 nYWSfaaMf3jI1peyP5wvd6lwEoA3gw6Rq+lKGCKt+/EigZFM7pZf/SrrudtHG9bMt6+S
 0kZpe2/D+o1ec0oSNrClcmh6wx6MHdIF2I9GY3KiU5eopwMqyA1OyplgaUC4BI9URr80
 ptZ1p+xpVFjelu8oQ40qn2cXap1HMicJ5fgreqhJhaAhC0xfQTfXvJvnQ5rLEToITGxv
 /ZX3/IW3HLof2c273o2owV0NKWtst0+T3uMADKOBGB4vCW73xshu20KesCc7PdDhwCaJ
 ZBuA==
X-Gm-Message-State: AOAM530DR4SpR7VZUxZVLMMfhMfLmcI7qeL/CLvSi+PCgSTtjZ147jgi
 kvM4L2mw4VOv4+ylrsT+4rDBS+6XhtTJy807lZqIQOj5
X-Google-Smtp-Source: ABdhPJybV49PXvaLuOuYRrtN6VngwcWE7l11lUSP8M5Bwsrn1JeciZ0c+JZ0ZKCjsJ5Tt+o28ywTf0oc6X9SWNBJ/PU=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr771006oic.123.1639427400213; 
 Mon, 13 Dec 2021 12:30:00 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_M_PS6fSza560ReNVki0n40tozig_KsbZnFksco2MZ3Ag@mail.gmail.com>
 <631945286.59894149.1639347564095.JavaMail.root@zimbra39-e7>
In-Reply-To: <631945286.59894149.1639347564095.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Dec 2021 15:29:49 -0500
Message-ID: <CADnq5_N8JtdE0UKO3of-pA3d3mQptL4URqW1Se+8za8cxzwTbg@mail.gmail.com>
Subject: Re: Various problems trying to vga-passthrough a Renoir iGPU to a
 xen/qubes-os hvm
To: Yann Dirson <ydirson@free.fr>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Dec 12, 2021 at 5:19 PM Yann Dirson <ydirson@free.fr> wrote:
>
> Alex wrote:
> > On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson <ydirson@free.fr> wrote:
> > >
> > > Hi Alex,
> > >
> > > > We have not validated virtualization of our integrated GPUs.  I
> > > > don't
> > > > know that it will work at all.  We had done a bit of testing but
> > > > ran
> > > > into the same issues with the PSP, but never had a chance to
> > > > debug
> > > > further because this feature is not productized.
> > > ...
> > > > You need a functional PSP to get the GPU driver up and running.
> > >
> > > Ah, thanks for the hint :)
> > >
> > > I guess that if I want to have any chance to get the PSP working
> > > I'm
> > > going to need more details on it.  A quick search some time ago
> > > mostly
> > > brought reverse-engineering work, rather than official AMD doc.
> > >  Are
> > > there some AMD resources I missed ?
> >
> > The driver code is pretty much it.
>
> Let's try to shed some more light on how things work, taking as excuse
> psp_v12_0_ring_create().
>
> First, register access through [RW]REG32_SOC15() is implemented in
> terms of __[RW]REG32_SOC15_RLC__(), which is basically a [RW]REG32(),
> except it has to be more complex in the SR-IOV case.
> Has the RLC anything to do with SR-IOV ?

When running the driver on a SR-IOV virtual function (VF), some
registers are not available directly via the VF's MMIO aperture so
they need to go through the RLC.  For bare metal or passthrough this
is not relevant.

>
> It accesses registers in the MMIO range of the MP0 IP, and the "MP0"
> name correlates highly with MMIO accesses in PSP-handling code.
> Is "MP0" another name for PSP (and "MP1" for SMU) ?  The MP0 version

Yes.

> reported at v11.0.3 by discovery seems to contradict the use of v12.0
> for RENOIR as set by soc15_set_ip_blocks(), or do I miss something ?

Typo in the ip discovery table on renoir.

>
> More generally (and mostly out of curiosity while we're at it), do we
> have a way to match IPs listed at discovery time with the ones used
> in the driver ?

In general, barring typos, the code is shared at the major version
level.  The actual code may or may not need changes to handle minor
revision changes in an IP.  The driver maps the IP versions from the
ip discovery table to the code contained in the driver.

>
> ---
>
> As for the register names, maybe we could have a short explanation of
> how they are structured ?  Eg. mmMP0_SMN_C2PMSG_69: that seems to be
> a MMIO register named "C2PMSG_69" in the "MP0" IP, but I'm not sure
> of the "SMN" part -- that could refer to the "System Management Network",
> described in [0] as an internal bus.  Are we accessing this register
> through this SMN ?

These registers are just mailboxes for the PSP firmware.  All of the
C2PMSG registers functionality is defined by the PSP firmware.  They
are basically scratch registers used to communicate between the driver
and the PSP firmware.

>
>
> >  On APUs, the PSP is shared with
> > the CPU and the rest of the platform.  The GPU driver just interacts
> > with it for a few specific tasks:
> > 1. Loading Trusted Applications (e.g., trusted firmware applications
> > that run on the PSP for specific functionality, e.g., HDCP and
> > content
> > protection, etc.)
> > 2. Validating and loading firmware for other engines on the SoC.
> >  This
> > is required to use those engines.
>
> Trying to understand in more details how we start the PSP up, I noticed
> that psp_v12_0 has support for loading a sOS firmware, but never calls
> init_sos_microcode() - and anyway there is no sos firmware for renoir
> and green_sardine, which seem to be the only ASICs with this PSP version.
> Is it something that's just not been completely wired up yet ?

On APUs, the PSP is shared with the CPU so the PSP firmware is part of
the sbios image.  The driver doesn't load it.  We only load it on
dGPUs where the driver is responsible for the chip initialization.

>
> That also rings a bell, that we have nothing about Secure OS in the doc
> yet (not even the acronym in the glossary).
>
>
> > I'm not too familiar with the PSP's path to memory from the GPU
> > perspective.  IIRC, most memory used by the PSP goes through carve
> > out
> > "vram" on APUs so it should work, but I would double check if there
> > are any system memory allocations that used to interact with the PSP
> > and see if changing them to vram helps.  It does work with the IOMMU
> > enabled on bare metal, so it should work in passthrough as well in
> > theory.
>
> I can see a single case in the PSP code where GTT is used instead of
> vram: to create fw_pri_bo when SR-IOV is not used (and there has
> to be a reason, since the SR-IOV code path does use vram).
> Changing it to vram does not make a difference, but then the
> only bo that seems to be used at that point is the one for the psp ring,
> which is allocated in vram, so I'm not too much surprised.
>
> Maybe I should double-check bo_create calls to hunt for more ?

We looked into this a bit ourselves and ran into the same issues.
We'd probably need to debug this with the PSP team to make further
progress, but this was not productized so neither team had the
resources to delve further.

Alex

>
>
> [0] https://github.com/PSPReverse/psp-docs/blob/master/masterthesis-eichner-psp-2020.pdf
