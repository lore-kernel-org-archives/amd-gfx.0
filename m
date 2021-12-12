Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DA2C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Dec 2021 22:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BE510F71D;
	Sun, 12 Dec 2021 22:19:27 +0000 (UTC)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C0F10F71D
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Dec 2021 22:19:26 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp6-g21.free.fr (Postfix) with ESMTP id 238347802C2;
 Sun, 12 Dec 2021 23:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1639347564;
 bh=F3koVWuo6dc9QkqwZJb34T/o6KQPr/Y+5335BI3Xje8=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=feb9EAvwSPEiMMy1gW9z3geSgMp1rBK77Ke8/sltTPMpotdKgVDDol9U6r2AbG1KY
 IQCkbYfBHVZL3BEs0HDw6iHbajfxqe+6+MUuxvOzQPt0N2olxreGUsWCyzs7yNodQf
 C+Z6XI2TciGdJYnhXTVyQUaPdh2RuL/sePP2A7sjPj75Fw2xL9RB/pw1mqWQ1wrJm7
 FeKD90L9aUdgDAzQ4r3Jqc2oTPiNY5Iw7OJFco//y6W2vrpcSTss5gwqUSPMj024qu
 SZPQf0b9OyH4ABBfJvJoWMJTuniSJkyYWBvuDJeCDN5x9QqAL+thjwXPyOi4TROd+w
 /Yi/1YVurx1AA==
Date: Sun, 12 Dec 2021 23:19:24 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Message-ID: <631945286.59894149.1639347564095.JavaMail.root@zimbra39-e7>
In-Reply-To: <CADnq5_M_PS6fSza560ReNVki0n40tozig_KsbZnFksco2MZ3Ag@mail.gmail.com>
Subject: Re: Various problems trying to vga-passthrough a Renoir iGPU to a
 xen/qubes-os hvm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Alex wrote:
> On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson <ydirson@free.fr> wrote:
> >
> > Hi Alex,
> >
> > > We have not validated virtualization of our integrated GPUs.  I
> > > don't
> > > know that it will work at all.  We had done a bit of testing but
> > > ran
> > > into the same issues with the PSP, but never had a chance to
> > > debug
> > > further because this feature is not productized.
> > ...
> > > You need a functional PSP to get the GPU driver up and running.
> >
> > Ah, thanks for the hint :)
> >
> > I guess that if I want to have any chance to get the PSP working
> > I'm
> > going to need more details on it.  A quick search some time ago
> > mostly
> > brought reverse-engineering work, rather than official AMD doc.
> >  Are
> > there some AMD resources I missed ?
> 
> The driver code is pretty much it.

Let's try to shed some more light on how things work, taking as excuse
psp_v12_0_ring_create().

First, register access through [RW]REG32_SOC15() is implemented in
terms of __[RW]REG32_SOC15_RLC__(), which is basically a [RW]REG32(),
except it has to be more complex in the SR-IOV case.
Has the RLC anything to do with SR-IOV ?

It accesses registers in the MMIO range of the MP0 IP, and the "MP0"
name correlates highly with MMIO accesses in PSP-handling code.
Is "MP0" another name for PSP (and "MP1" for SMU) ?  The MP0 version
reported at v11.0.3 by discovery seems to contradict the use of v12.0
for RENOIR as set by soc15_set_ip_blocks(), or do I miss something ?

More generally (and mostly out of curiosity while we're at it), do we
have a way to match IPs listed at discovery time with the ones used
in the driver ?

---

As for the register names, maybe we could have a short explanation of
how they are structured ?  Eg. mmMP0_SMN_C2PMSG_69: that seems to be
a MMIO register named "C2PMSG_69" in the "MP0" IP, but I'm not sure
of the "SMN" part -- that could refer to the "System Management Network",
described in [0] as an internal bus.  Are we accessing this register
through this SMN ?


>  On APUs, the PSP is shared with
> the CPU and the rest of the platform.  The GPU driver just interacts
> with it for a few specific tasks:
> 1. Loading Trusted Applications (e.g., trusted firmware applications
> that run on the PSP for specific functionality, e.g., HDCP and
> content
> protection, etc.)
> 2. Validating and loading firmware for other engines on the SoC.
>  This
> is required to use those engines.

Trying to understand in more details how we start the PSP up, I noticed
that psp_v12_0 has support for loading a sOS firmware, but never calls
init_sos_microcode() - and anyway there is no sos firmware for renoir
and green_sardine, which seem to be the only ASICs with this PSP version.
Is it something that's just not been completely wired up yet ?

That also rings a bell, that we have nothing about Secure OS in the doc
yet (not even the acronym in the glossary).


> I'm not too familiar with the PSP's path to memory from the GPU
> perspective.  IIRC, most memory used by the PSP goes through carve
> out
> "vram" on APUs so it should work, but I would double check if there
> are any system memory allocations that used to interact with the PSP
> and see if changing them to vram helps.  It does work with the IOMMU
> enabled on bare metal, so it should work in passthrough as well in
> theory.

I can see a single case in the PSP code where GTT is used instead of
vram: to create fw_pri_bo when SR-IOV is not used (and there has
to be a reason, since the SR-IOV code path does use vram).
Changing it to vram does not make a difference, but then the
only bo that seems to be used at that point is the one for the psp ring,
which is allocated in vram, so I'm not too much surprised.

Maybe I should double-check bo_create calls to hunt for more ?


[0] https://github.com/PSPReverse/psp-docs/blob/master/masterthesis-eichner-psp-2020.pdf
