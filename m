Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA894C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 17:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471FA10E23B;
	Wed, 29 Dec 2021 17:56:46 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09F710E24A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 17:56:45 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 w19-20020a056830061300b0058f1dd48932so28730615oti.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YypY2pRh29wvF04JaEIw5DDHHxJUR6inBJLRmBr6Z4w=;
 b=eGpx8aaW8QHNp05emBf3/ApBxEPvMoCfLJkNk7bVxKZModb5lZ4ahl5MaxuvRZfoWe
 AXRX7Q22AGbRxa6C0FPOWgMYXZBogbMdev9TRDgerb1Fv+cZlkKiS/orMvXhMj0f+e01
 w1iEMdYaUDLdjocQXGJCr3dkNyOdPVeb3rTbXgv4p8V8B/EdO+Ok6/FUS4J15Z4xIyKg
 5W3x5+ok0aWE22XEUgFCyhqAENL/677wzcyX7VMhekzq87Jz5pz5ZTmo5w433BNoyHOV
 tN+6UtYuYmSlMQJeJFj8fDENPglqMqzDa09h6wtOc/zzPQ6oOBdDRdsCH+I7X15gEaNi
 3IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YypY2pRh29wvF04JaEIw5DDHHxJUR6inBJLRmBr6Z4w=;
 b=Gpffg8ccUA6vTi5e0+ypl/R7PqKN/iSdfsHzVGa/Uo2DOVSKas2l/vlm+L2oRvaHfn
 kDxwS015XNbHiBDyJK5wpm4XnrshBny/Zv2DTEjWJ0VbHQoFmg02DGjM71EhjVyEe/YR
 0gBRA8cxhjAz6KvBz4DfBQWtjLqlMKR2bzMjAgd7uERfHBMQtgX3mWfCY+mguRaeqLaD
 MWu6fZ73R+bVI0o7qEhrG3+OWmzzCpldCQC7uFDxVfz/zYVg3t2xMEviq/5fs6Qymybz
 rqBAtn771K3xuEUCLiYHJGPgkNZCkZCUvlyQiN3JFoaPmttJfKF5/evhBFZTjLmfi22e
 llbA==
X-Gm-Message-State: AOAM530sJUcSVWXRoU2skdgROQc+Ei1VadbOG1bMWG8TGmNJ72Rlrmsk
 tfOLh2yS8Lvya0Kbiop/Jlv6vLkOSqbP1jKoDL0=
X-Google-Smtp-Source: ABdhPJx7gcB68xNPYAolvsef9giCKLrNztvDuGs19nkT8lkekrTbrpTuEuiLcpsHoA7dZFeRebi7LG9aoDoXUVoZerI=
X-Received: by 2002:a9d:6390:: with SMTP id w16mr20372932otk.200.1640800604725; 
 Wed, 29 Dec 2021 09:56:44 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_PsQ6Mw7+dPrPCsGaPak6pgSCHEkrrS6CmsasdUz1BoTw@mail.gmail.com>
 <201102890.134776927.1640799250860.JavaMail.root@zimbra39-e7>
In-Reply-To: <201102890.134776927.1640799250860.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Dec 2021 12:56:33 -0500
Message-ID: <CADnq5_N_n2AqcmQsq8_4DLn5FmdR9rk0+JmjccRz9TXdJu5i2A@mail.gmail.com>
Subject: Re: Various problems trying to vga-passthrough a Renoir iGPU to a
 xen/qubes-os hvm
To: Yann Dirson <ydirson@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 29, 2021 at 12:34 PM Yann Dirson <ydirson@free.fr> wrote:
>
> Alex wrote:
> > On Wed, Dec 29, 2021 at 11:59 AM Yann Dirson <ydirson@free.fr> wrote:
> > >
> > > Alex wrote:
> > > > On Tue, Dec 21, 2021 at 6:09 PM Yann Dirson <ydirson@free.fr>
> > > > wrote:
> > > > >
> > > > >
> > > > >
> > > > > ----- Mail original -----
> > > > > > De: "Alex Deucher" <alexdeucher@gmail.com>
> > > > > > =C3=80: "Yann Dirson" <ydirson@free.fr>
> > > > > > Cc: "Christian K=C3=B6nig" <ckoenig.leichtzumerken@gmail.com>,
> > > > > > "amd-gfx list" <amd-gfx@lists.freedesktop.org>
> > > > > > Envoy=C3=A9: Mardi 21 D=C3=A9cembre 2021 23:31:01
> > > > > > Objet: Re: Various problems trying to vga-passthrough a
> > > > > > Renoir
> > > > > > iGPU to a xen/qubes-os hvm
> > > > > >
> > > > > > On Tue, Dec 21, 2021 at 5:12 PM Yann Dirson <ydirson@free.fr>
> > > > > > wrote:
> > > > > > >
> > > > > > >
> > > > > > > Alex wrote:
> > > > > > > >
> > > > > > > > On Sun, Dec 19, 2021 at 11:41 AM Yann Dirson
> > > > > > > > <ydirson@free.fr>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > Christian wrote:
> > > > > > > > > > Am 19.12.21 um 17:00 schrieb Yann Dirson:
> > > > > > > > > > > Alex wrote:
> > > > > > > > > > >> Thinking about this more, I think the problem
> > > > > > > > > > >> might be
> > > > > > > > > > >> related
> > > > > > > > > > >> to
> > > > > > > > > > >> CPU
> > > > > > > > > > >> access to "VRAM".  APUs don't have dedicated VRAM,
> > > > > > > > > > >> they
> > > > > > > > > > >> use a
> > > > > > > > > > >> reserved
> > > > > > > > > > >> carve out region at the top of system memory.  For
> > > > > > > > > > >> CPU
> > > > > > > > > > >> access
> > > > > > > > > > >> to
> > > > > > > > > > >> this
> > > > > > > > > > >> memory, we kmap the physical address of the carve
> > > > > > > > > > >> out
> > > > > > > > > > >> region
> > > > > > > > > > >> of
> > > > > > > > > > >> system
> > > > > > > > > > >> memory.  You'll need to make sure that region is
> > > > > > > > > > >> accessible to
> > > > > > > > > > >> the
> > > > > > > > > > >> guest.
> > > > > > > > > > > So basically, the non-virt flow is is: (video?)
> > > > > > > > > > > BIOS
> > > > > > > > > > > reserves
> > > > > > > > > > > memory, marks it
> > > > > > > > > > > as reserved in e820, stores the physaddr somewhere,
> > > > > > > > > > > which
> > > > > > > > > > > the
> > > > > > > > > > > GPU
> > > > > > > > > > > driver gets.
> > > > > > > > > > > Since I suppose this includes the framebuffer, this
> > > > > > > > > > > probably
> > > > > > > > > > > has to
> > > > > > > > > > > occur around
> > > > > > > > > > > the moment the driver calls
> > > > > > > > > > > drm_aperture_remove_conflicting_pci_framebuffers()
> > > > > > > > > > > (which happens before this hw init step), right ?
> > > > > > > > > >
> > > > > > > > > > Well, that partially correct. The efifb is using the
> > > > > > > > > > PCIe
> > > > > > > > > > resources
> > > > > > > > > > to
> > > > > > > > > > access the framebuffer and as far as I know we use
> > > > > > > > > > that
> > > > > > > > > > one
> > > > > > > > > > to
> > > > > > > > > > kick
> > > > > > > > > > it out.
> > > > > > > > > >
> > > > > > > > > > The stolen memory we get over e820/registers is
> > > > > > > > > > separate
> > > > > > > > > > to
> > > > > > > > > > that.
> > > > > > >
> > > > > > > How is the stolen memory communicated to the driver ?  That
> > > > > > > host
> > > > > > > physical
> > > > > > > memory probably has to be mapped at the same guest physical
> > > > > > > address
> > > > > > > for
> > > > > > > the magic to work, right ?
> > > > > >
> > > > > > Correct.  The driver reads the physical location of that
> > > > > > memory
> > > > > > from
> > > > > > hardware registers.  Removing this chunk of code from
> > > > > > gmc_v9_0.c
> > > > > > will
> > > > > > force the driver to use the BAR, but I'm not sure if there
> > > > > > are
> > > > > > any
> > > > > > other places in the driver that make assumptions about using
> > > > > > the
> > > > > > physical host address or not on APUs off hand.
> > > > > >
> > > > > >         if ((adev->flags & AMD_IS_APU) ||
> > > > > >             (adev->gmc.xgmi.supported &&
> > > > > >              adev->gmc.xgmi.connected_to_cpu)) {
> > > > > >                 adev->gmc.aper_base =3D
> > > > > >                         adev->gfxhub.funcs->get_mc_fb_offset(ad=
ev)
> > > > > >                         +
> > > > > >                         adev->gmc.xgmi.physical_node_id *
> > > > > >                         adev->gmc.xgmi.node_segment_size;
> > > > > >                 adev->gmc.aper_size =3D
> > > > > >                 adev->gmc.real_vram_size;
> > > > > >         }
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > > ... which brings me to a point that's been puzzling
> > > > > > > > > > > me
> > > > > > > > > > > for
> > > > > > > > > > > some
> > > > > > > > > > > time, which is
> > > > > > > > > > > that as the hw init fails, the efifb driver is
> > > > > > > > > > > still
> > > > > > > > > > > using
> > > > > > > > > > > the
> > > > > > > > > > > framebuffer.
> > > > > > > > > >
> > > > > > > > > > No, it isn't. You are probably just still seeing the
> > > > > > > > > > same
> > > > > > > > > > screen.
> > > > > > > > > >
> > > > > > > > > > The issue is most likely that while efi was kicked
> > > > > > > > > > out
> > > > > > > > > > nobody
> > > > > > > > > > re-programmed the display hardware to show something
> > > > > > > > > > different.
> > > > > > > > > >
> > > > > > > > > > > Am I right in suspecting that efifb should get
> > > > > > > > > > > stripped
> > > > > > > > > > > of
> > > > > > > > > > > its
> > > > > > > > > > > ownership of the
> > > > > > > > > > > fb aperture first, and that if I don't get a black
> > > > > > > > > > > screen
> > > > > > > > > > > on
> > > > > > > > > > > hw_init failure
> > > > > > > > > > > that issue should be the first focus point ?
> > > > > > > > > >
> > > > > > > > > > You assumption with the black screen is incorrect.
> > > > > > > > > > Since
> > > > > > > > > > the
> > > > > > > > > > hardware
> > > > > > > > > > works independent even if you kick out efi you still
> > > > > > > > > > have
> > > > > > > > > > the
> > > > > > > > > > same
> > > > > > > > > > screen content, you just can't update it anymore.
> > > > > > > > >
> > > > > > > > > It's not only that the screen keeps its contents, it's
> > > > > > > > > that
> > > > > > > > > the
> > > > > > > > > dom0
> > > > > > > > > happily continues updating it.
> > > > > > > >
> > > > > > > > If the hypevisor is using efifb, then yes that could be a
> > > > > > > > problem
> > > > > > > > as
> > > > > > > > the hypervisor could be writing to the efifb resources
> > > > > > > > which
> > > > > > > > ends
> > > > > > > > up
> > > > > > > > writing to the same physical memory.  That applies to any
> > > > > > > > GPU
> > > > > > > > on
> > > > > > > > a
> > > > > > > > UEFI system.  You'll need to make sure efifb is not in
> > > > > > > > use in
> > > > > > > > the
> > > > > > > > hypervisor.
> > > > > > >
> > > > > > > That remark evokes several things to me.  First one is that
> > > > > > > every
> > > > > > > time
> > > > > > > I've tried booting with efifb disabled in dom0, there was
> > > > > > > no
> > > > > > > visible
> > > > > > > improvements in the guest driver - i.i. I really have to
> > > > > > > dig
> > > > > > > how
> > > > > > > vram mapping
> > > > > > > is performed and check things are as expected anyway.
> > > > > >
> > > > > > Ultimately you end up at the same physical memory.  efifb
> > > > > > uses
> > > > > > the
> > > > > > PCI
> > > > > > BAR which points to the same physical memory that the driver
> > > > > > directly
> > > > > > maps.
> > > > > >
> > > > > > >
> > > > > > > The other is that, when dom0 cannot use efifb, entering a
> > > > > > > luks
> > > > > > > key
> > > > > > > is
> > > > > > > suddenly less user-friendly.  But in theory I'd think we
> > > > > > > could
> > > > > > > overcome
> > > > > > > this by letting dom0 use efifb until ready to start the
> > > > > > > guest,
> > > > > > > a
> > > > > > > simple
> > > > > > > driver unbind at the right moment should be expected to
> > > > > > > work,
> > > > > > > right
> > > > > > > ?
> > > > > > > Going further and allowing the guest to use efifb on its
> > > > > > > own
> > > > > > > could
> > > > > > > possibly be more tricky (starting with a different state?)
> > > > > > > but
> > > > > > > does
> > > > > > > not seem to sound completely outlandish either - or does it
> > > > > > > ?
> > > > > > >
> > > > > >
> > > > > > efifb just takes whatever hardware state the GOP driver in
> > > > > > the
> > > > > > pre-OS
> > > > > > environment left the GPU in.  Once you have a driver loaded
> > > > > > in
> > > > > > the
> > > > > > OS,
> > > > > > that state is gone so I I don't see much value in using efifb
> > > > > > once
> > > > > > you
> > > > > > have a real driver in the mix.  If you want a console on the
> > > > > > host,
> > > > > > it's probably better to use 2 GPU or just load the real
> > > > > > driver as
> > > > > > needed in both the host and guest.
> > > > >
> > > > > My point is essentially making sure we always have a usable
> > > > > display.
> > > > > Dom0 will essentially use it for entering luks key (but having
> > > > > boot
> > > > > logs
> > > > > visible may also be useful for some troubleshooting), and I was
> > > > > figuring
> > > > > out that once dom0 has relinquished it to start a guest with
> > > > > passthrough,
> > > > > the guest might as well make use of it before it can start
> > > > > amdgpu.
> > > > > Could be useful as a first step of seeing the GPU in the guest,
> > > > > in
> > > > > case there are more issues to be solved to be able to start
> > > > > amdgpu.
> > > >
> > > >
> > > > Something has to program the GPU to get the displays up.  You
> > > > need a
> > > > driver for that.  Once the OS has loaded the UEFI GOP driver is
> > > > gone.
> > >
> > > My understanding is that efifb is only making use of the
> > > framebuffer set up
> > > by the GOP.  If that's correct I don't see why the same framebuffer
> > > could
> > > not be used by a guest once the host releases it (provided the
> > > guest boots
> > > Tiano Core and we can tell the latter to pass the GOP framebuffer
> > > through).
> > > Where do I get it wrong ?
> >
> > Sure, you could re-use the GPU memory that backs the framebuffer, but
> > something needs to reprogram the display timing so that you get a
> > signal to your monitor.  That is what the driver does (GOP or OS
> > driver).
>
> Yes, GOP programs timings early, so host and early guest can use efifb, t=
hen
> at some time the guest OS driver takes over the passed-through device and
> at that point we forget about efifb.  That seems to make sense ?

Yes.  on boot up, the GOP driver loads and initializes the hardware,
enumerates the attached displays, and lights them up.  Once the OS
loads, the pre-OS environment is gone, so the GOP driver is gone.  The
OS just inherits the memory and timings that the GOP driver set up.
Then the OS loads the OS driver which enumerates the displays and
lights them up, etc.  When you unload the OS driver and you want to
use the hardware again, something has to re-initialize it.

Alex


>
> >
> > Alex
> >
> > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > But putting efi asside what Alex pointed out pretty
> > > > > > > > > > much
> > > > > > > > > > breaks
> > > > > > > > > > your
> > > > > > > > > > neck trying to forward the device. You maybe could
> > > > > > > > > > try to
> > > > > > > > > > hack
> > > > > > > > > > the
> > > > > > > > > > driver to use the PCIe BAR for framebuffer access,
> > > > > > > > > > but
> > > > > > > > > > that
> > > > > > > > > > might
> > > > > > > > > > be
> > > > > > > > > > quite a bit slower.
> > > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Christian.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >> Alex
> > > > > > > > > > >>
> > > > > > > > > > >> On Mon, Dec 13, 2021 at 3:29 PM Alex Deucher
> > > > > > > > > > >> <alexdeucher@gmail.com>
> > > > > > > > > > >> wrote:
> > > > > > > > > > >>> On Sun, Dec 12, 2021 at 5:19 PM Yann Dirson
> > > > > > > > > > >>> <ydirson@free.fr>
> > > > > > > > > > >>> wrote:
> > > > > > > > > > >>>> Alex wrote:
> > > > > > > > > > >>>>> On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson
> > > > > > > > > > >>>>> <ydirson@free.fr>
> > > > > > > > > > >>>>> wrote:
> > > > > > > > > > >>>>>> Hi Alex,
> > > > > > > > > > >>>>>>
> > > > > > > > > > >>>>>>> We have not validated virtualization of our
> > > > > > > > > > >>>>>>> integrated
> > > > > > > > > > >>>>>>> GPUs.  I
> > > > > > > > > > >>>>>>> don't
> > > > > > > > > > >>>>>>> know that it will work at all.  We had done a
> > > > > > > > > > >>>>>>> bit
> > > > > > > > > > >>>>>>> of
> > > > > > > > > > >>>>>>> testing but
> > > > > > > > > > >>>>>>> ran
> > > > > > > > > > >>>>>>> into the same issues with the PSP, but never
> > > > > > > > > > >>>>>>> had
> > > > > > > > > > >>>>>>> a
> > > > > > > > > > >>>>>>> chance
> > > > > > > > > > >>>>>>> to
> > > > > > > > > > >>>>>>> debug
> > > > > > > > > > >>>>>>> further because this feature is not
> > > > > > > > > > >>>>>>> productized.
> > > > > > > > > > >>>>>> ...
> > > > > > > > > > >>>>>>> You need a functional PSP to get the GPU
> > > > > > > > > > >>>>>>> driver
> > > > > > > > > > >>>>>>> up
> > > > > > > > > > >>>>>>> and
> > > > > > > > > > >>>>>>> running.
> > > > > > > > > > >>>>>> Ah, thanks for the hint :)
> > > > > > > > > > >>>>>>
> > > > > > > > > > >>>>>> I guess that if I want to have any chance to
> > > > > > > > > > >>>>>> get
> > > > > > > > > > >>>>>> the
> > > > > > > > > > >>>>>> PSP
> > > > > > > > > > >>>>>> working
> > > > > > > > > > >>>>>> I'm
> > > > > > > > > > >>>>>> going to need more details on it.  A quick
> > > > > > > > > > >>>>>> search
> > > > > > > > > > >>>>>> some
> > > > > > > > > > >>>>>> time
> > > > > > > > > > >>>>>> ago
> > > > > > > > > > >>>>>> mostly
> > > > > > > > > > >>>>>> brought reverse-engineering work, rather than
> > > > > > > > > > >>>>>> official
> > > > > > > > > > >>>>>> AMD
> > > > > > > > > > >>>>>> doc.
> > > > > > > > > > >>>>>>   Are
> > > > > > > > > > >>>>>> there some AMD resources I missed ?
> > > > > > > > > > >>>>> The driver code is pretty much it.
> > > > > > > > > > >>>> Let's try to shed some more light on how things
> > > > > > > > > > >>>> work,
> > > > > > > > > > >>>> taking
> > > > > > > > > > >>>> as
> > > > > > > > > > >>>> excuse
> > > > > > > > > > >>>> psp_v12_0_ring_create().
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> First, register access through [RW]REG32_SOC15()
> > > > > > > > > > >>>> is
> > > > > > > > > > >>>> implemented
> > > > > > > > > > >>>> in
> > > > > > > > > > >>>> terms of __[RW]REG32_SOC15_RLC__(), which is
> > > > > > > > > > >>>> basically a
> > > > > > > > > > >>>> [RW]REG32(),
> > > > > > > > > > >>>> except it has to be more complex in the SR-IOV
> > > > > > > > > > >>>> case.
> > > > > > > > > > >>>> Has the RLC anything to do with SR-IOV ?
> > > > > > > > > > >>> When running the driver on a SR-IOV virtual
> > > > > > > > > > >>> function
> > > > > > > > > > >>> (VF),
> > > > > > > > > > >>> some
> > > > > > > > > > >>> registers are not available directly via the VF's
> > > > > > > > > > >>> MMIO
> > > > > > > > > > >>> aperture
> > > > > > > > > > >>> so
> > > > > > > > > > >>> they need to go through the RLC.  For bare metal
> > > > > > > > > > >>> or
> > > > > > > > > > >>> passthrough
> > > > > > > > > > >>> this
> > > > > > > > > > >>> is not relevant.
> > > > > > > > > > >>>
> > > > > > > > > > >>>> It accesses registers in the MMIO range of the
> > > > > > > > > > >>>> MP0
> > > > > > > > > > >>>> IP,
> > > > > > > > > > >>>> and
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> "MP0"
> > > > > > > > > > >>>> name correlates highly with MMIO accesses in
> > > > > > > > > > >>>> PSP-handling
> > > > > > > > > > >>>> code.
> > > > > > > > > > >>>> Is "MP0" another name for PSP (and "MP1" for
> > > > > > > > > > >>>> SMU) ?
> > > > > > > > > > >>>>  The
> > > > > > > > > > >>>> MP0
> > > > > > > > > > >>>> version
> > > > > > > > > > >>> Yes.
> > > > > > > > > > >>>
> > > > > > > > > > >>>> reported at v11.0.3 by discovery seems to
> > > > > > > > > > >>>> contradict
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> use
> > > > > > > > > > >>>> of
> > > > > > > > > > >>>> v12.0
> > > > > > > > > > >>>> for RENOIR as set by soc15_set_ip_blocks(), or
> > > > > > > > > > >>>> do I
> > > > > > > > > > >>>> miss
> > > > > > > > > > >>>> something ?
> > > > > > > > > > >>> Typo in the ip discovery table on renoir.
> > > > > > > > > > >>>
> > > > > > > > > > >>>> More generally (and mostly out of curiosity
> > > > > > > > > > >>>> while
> > > > > > > > > > >>>> we're
> > > > > > > > > > >>>> at
> > > > > > > > > > >>>> it),
> > > > > > > > > > >>>> do we
> > > > > > > > > > >>>> have a way to match IPs listed at discovery time
> > > > > > > > > > >>>> with
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> ones
> > > > > > > > > > >>>> used
> > > > > > > > > > >>>> in the driver ?
> > > > > > > > > > >>> In general, barring typos, the code is shared at
> > > > > > > > > > >>> the
> > > > > > > > > > >>> major
> > > > > > > > > > >>> version
> > > > > > > > > > >>> level.  The actual code may or may not need
> > > > > > > > > > >>> changes
> > > > > > > > > > >>> to
> > > > > > > > > > >>> handle
> > > > > > > > > > >>> minor
> > > > > > > > > > >>> revision changes in an IP.  The driver maps the
> > > > > > > > > > >>> IP
> > > > > > > > > > >>> versions
> > > > > > > > > > >>> from
> > > > > > > > > > >>> the
> > > > > > > > > > >>> ip discovery table to the code contained in the
> > > > > > > > > > >>> driver.
> > > > > > > > > > >>>
> > > > > > > > > > >>>> ---
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> As for the register names, maybe we could have a
> > > > > > > > > > >>>> short
> > > > > > > > > > >>>> explanation of
> > > > > > > > > > >>>> how they are structured ?  Eg.
> > > > > > > > > > >>>> mmMP0_SMN_C2PMSG_69:
> > > > > > > > > > >>>> that
> > > > > > > > > > >>>> seems
> > > > > > > > > > >>>> to
> > > > > > > > > > >>>> be
> > > > > > > > > > >>>> a MMIO register named "C2PMSG_69" in the "MP0"
> > > > > > > > > > >>>> IP,
> > > > > > > > > > >>>> but
> > > > > > > > > > >>>> I'm
> > > > > > > > > > >>>> not
> > > > > > > > > > >>>> sure
> > > > > > > > > > >>>> of the "SMN" part -- that could refer to the
> > > > > > > > > > >>>> "System
> > > > > > > > > > >>>> Management
> > > > > > > > > > >>>> Network",
> > > > > > > > > > >>>> described in [0] as an internal bus.  Are we
> > > > > > > > > > >>>> accessing
> > > > > > > > > > >>>> this
> > > > > > > > > > >>>> register
> > > > > > > > > > >>>> through this SMN ?
> > > > > > > > > > >>> These registers are just mailboxes for the PSP
> > > > > > > > > > >>> firmware.
> > > > > > > > > > >>>  All
> > > > > > > > > > >>> of
> > > > > > > > > > >>> the
> > > > > > > > > > >>> C2PMSG registers functionality is defined by the
> > > > > > > > > > >>> PSP
> > > > > > > > > > >>> firmware.
> > > > > > > > > > >>>   They
> > > > > > > > > > >>> are basically scratch registers used to
> > > > > > > > > > >>> communicate
> > > > > > > > > > >>> between
> > > > > > > > > > >>> the
> > > > > > > > > > >>> driver
> > > > > > > > > > >>> and the PSP firmware.
> > > > > > > > > > >>>
> > > > > > > > > > >>>>
> > > > > > > > > > >>>>>   On APUs, the PSP is shared with
> > > > > > > > > > >>>>> the CPU and the rest of the platform.  The GPU
> > > > > > > > > > >>>>> driver
> > > > > > > > > > >>>>> just
> > > > > > > > > > >>>>> interacts
> > > > > > > > > > >>>>> with it for a few specific tasks:
> > > > > > > > > > >>>>> 1. Loading Trusted Applications (e.g., trusted
> > > > > > > > > > >>>>> firmware
> > > > > > > > > > >>>>> applications
> > > > > > > > > > >>>>> that run on the PSP for specific functionality,
> > > > > > > > > > >>>>> e.g.,
> > > > > > > > > > >>>>> HDCP
> > > > > > > > > > >>>>> and
> > > > > > > > > > >>>>> content
> > > > > > > > > > >>>>> protection, etc.)
> > > > > > > > > > >>>>> 2. Validating and loading firmware for other
> > > > > > > > > > >>>>> engines on
> > > > > > > > > > >>>>> the
> > > > > > > > > > >>>>> SoC.
> > > > > > > > > > >>>>>   This
> > > > > > > > > > >>>>> is required to use those engines.
> > > > > > > > > > >>>> Trying to understand in more details how we
> > > > > > > > > > >>>> start
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> PSP
> > > > > > > > > > >>>> up, I
> > > > > > > > > > >>>> noticed
> > > > > > > > > > >>>> that psp_v12_0 has support for loading a sOS
> > > > > > > > > > >>>> firmware,
> > > > > > > > > > >>>> but
> > > > > > > > > > >>>> never
> > > > > > > > > > >>>> calls
> > > > > > > > > > >>>> init_sos_microcode() - and anyway there is no
> > > > > > > > > > >>>> sos
> > > > > > > > > > >>>> firmware
> > > > > > > > > > >>>> for
> > > > > > > > > > >>>> renoir
> > > > > > > > > > >>>> and green_sardine, which seem to be the only
> > > > > > > > > > >>>> ASICs
> > > > > > > > > > >>>> with
> > > > > > > > > > >>>> this
> > > > > > > > > > >>>> PSP
> > > > > > > > > > >>>> version.
> > > > > > > > > > >>>> Is it something that's just not been completely
> > > > > > > > > > >>>> wired up
> > > > > > > > > > >>>> yet
> > > > > > > > > > >>>> ?
> > > > > > > > > > >>> On APUs, the PSP is shared with the CPU so the
> > > > > > > > > > >>> PSP
> > > > > > > > > > >>> firmware
> > > > > > > > > > >>> is
> > > > > > > > > > >>> part
> > > > > > > > > > >>> of
> > > > > > > > > > >>> the sbios image.  The driver doesn't load it.  We
> > > > > > > > > > >>> only
> > > > > > > > > > >>> load
> > > > > > > > > > >>> it on
> > > > > > > > > > >>> dGPUs where the driver is responsible for the
> > > > > > > > > > >>> chip
> > > > > > > > > > >>> initialization.
> > > > > > > > > > >>>
> > > > > > > > > > >>>> That also rings a bell, that we have nothing
> > > > > > > > > > >>>> about
> > > > > > > > > > >>>> Secure OS
> > > > > > > > > > >>>> in
> > > > > > > > > > >>>> the doc
> > > > > > > > > > >>>> yet (not even the acronym in the glossary).
> > > > > > > > > > >>>>
> > > > > > > > > > >>>>
> > > > > > > > > > >>>>> I'm not too familiar with the PSP's path to
> > > > > > > > > > >>>>> memory
> > > > > > > > > > >>>>> from
> > > > > > > > > > >>>>> the
> > > > > > > > > > >>>>> GPU
> > > > > > > > > > >>>>> perspective.  IIRC, most memory used by the PSP
> > > > > > > > > > >>>>> goes
> > > > > > > > > > >>>>> through
> > > > > > > > > > >>>>> carve
> > > > > > > > > > >>>>> out
> > > > > > > > > > >>>>> "vram" on APUs so it should work, but I would
> > > > > > > > > > >>>>> double
> > > > > > > > > > >>>>> check
> > > > > > > > > > >>>>> if
> > > > > > > > > > >>>>> there
> > > > > > > > > > >>>>> are any system memory allocations that used to
> > > > > > > > > > >>>>> interact
> > > > > > > > > > >>>>> with
> > > > > > > > > > >>>>> the PSP
> > > > > > > > > > >>>>> and see if changing them to vram helps.  It
> > > > > > > > > > >>>>> does
> > > > > > > > > > >>>>> work
> > > > > > > > > > >>>>> with
> > > > > > > > > > >>>>> the
> > > > > > > > > > >>>>> IOMMU
> > > > > > > > > > >>>>> enabled on bare metal, so it should work in
> > > > > > > > > > >>>>> passthrough
> > > > > > > > > > >>>>> as
> > > > > > > > > > >>>>> well
> > > > > > > > > > >>>>> in
> > > > > > > > > > >>>>> theory.
> > > > > > > > > > >>>> I can see a single case in the PSP code where
> > > > > > > > > > >>>> GTT is
> > > > > > > > > > >>>> used
> > > > > > > > > > >>>> instead
> > > > > > > > > > >>>> of
> > > > > > > > > > >>>> vram: to create fw_pri_bo when SR-IOV is not
> > > > > > > > > > >>>> used
> > > > > > > > > > >>>> (and
> > > > > > > > > > >>>> there
> > > > > > > > > > >>>> has
> > > > > > > > > > >>>> to be a reason, since the SR-IOV code path does
> > > > > > > > > > >>>> use
> > > > > > > > > > >>>> vram).
> > > > > > > > > > >>>> Changing it to vram does not make a difference,
> > > > > > > > > > >>>> but
> > > > > > > > > > >>>> then
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> only bo that seems to be used at that point is
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> one
> > > > > > > > > > >>>> for
> > > > > > > > > > >>>> the
> > > > > > > > > > >>>> psp ring,
> > > > > > > > > > >>>> which is allocated in vram, so I'm not too much
> > > > > > > > > > >>>> surprised.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Maybe I should double-check bo_create calls to
> > > > > > > > > > >>>> hunt
> > > > > > > > > > >>>> for
> > > > > > > > > > >>>> more
> > > > > > > > > > >>>> ?
> > > > > > > > > > >>> We looked into this a bit ourselves and ran into
> > > > > > > > > > >>> the
> > > > > > > > > > >>> same
> > > > > > > > > > >>> issues.
> > > > > > > > > > >>> We'd probably need to debug this with the PSP
> > > > > > > > > > >>> team to
> > > > > > > > > > >>> make
> > > > > > > > > > >>> further
> > > > > > > > > > >>> progress, but this was not productized so neither
> > > > > > > > > > >>> team
> > > > > > > > > > >>> had
> > > > > > > > > > >>> the
> > > > > > > > > > >>> resources to delve further.
> > > > > > > > > > >>>
> > > > > > > > > > >>> Alex
> > > > > > > > > > >>>
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> [0]
> > > > > > > > > > >>>> https://github.com/PSPReverse/psp-docs/blob/master=
/masterthesis-eichner-psp-2020.pdf
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >
