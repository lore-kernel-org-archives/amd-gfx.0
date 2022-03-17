Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14492C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 03:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC3D10EADB;
	Thu, 17 Mar 2022 03:19:11 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB84910EA1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 00:14:32 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-2e5827a76f4so41648587b3.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lc+f5YAlXK2ackZ3hljZOa9RzrDFIwpFZOIUUC3NQnc=;
 b=Ooxo32rclqRYKkA4V5OVS/sTEnrb56SZ6AxEY1MF9F2pENY5lrHWkZnrldS68hdOgQ
 nnMdbnZo4AXjAk3J/B/c+Ff+udD9W0VGtFzWhgokh/Jl09dAkw/zAQbEQTAZ4GEVkPmo
 ZI2Y0AP3OrJL2CPqUCCpCoG21IY9mlV4ufHvsO/JRRVeWfU0N7XqDEaVioF/Gt1wzKAV
 NOImHn4pkCHdM6VseuzmFEV7HEy39Iw3veA8J66g4XFTp1h0uxhR4J12Wq6PK+TXNZco
 agfQ81vW353s28J46nhGpvXR/ZER1lLakT/nIEyKcDao8ediiYrOmrRUZOKnzA99MHzX
 YBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lc+f5YAlXK2ackZ3hljZOa9RzrDFIwpFZOIUUC3NQnc=;
 b=WPO8cyk5knLiV8zERr7aZzttwV28BSuaVD+KcqxKnNUcolud4A1PC2BK3nf87QVCF9
 u3jUInw4WI2M5W9o6cWJ3zn8+gQuptGiQYs4iIFtrBaSkPKET1IhGXRCW9g7lpi9gCbf
 xoHZZtkhkDZNPyhzl+33JkC5SprADQiNkMDwkCZcsDZRbVNjW9SztzT/e402hgO7fvjl
 geD2OJmVXkMi6hwFfplSoQQEoVsqBHEnsz2QEDEi9pE2F+WaVynh6xFLqGTB+KIoc6d0
 Grtfd2pP6EG05WGttN+aFz82/jf1kmCayJr1kBBTa+TLHFcyc6LLIJ37/w7aJuGPQJb2
 Ua8g==
X-Gm-Message-State: AOAM532pvouDrjo9Aq+NZqSTFQkLFREGb7bbUaTaTySQxpx+fh4g3l+/
 xYOFSduqhGCLhVVc7HOSnPj/QblQ2ixzBiVeKDI=
X-Google-Smtp-Source: ABdhPJz4FD6B7kIAm7ysXGC3phS5L4Lx2AmSAvUiM6vnEQqkbn8aLot+BN9y65b2BaLBnO9A1VWwoW2TN9Iq9Nb12+8=
X-Received: by 2002:a81:5a85:0:b0:2dc:6ed4:21f3 with SMTP id
 o127-20020a815a85000000b002dc6ed421f3mr3138699ywb.519.1647476071905; Wed, 16
 Mar 2022 17:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
In-Reply-To: <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 16 Mar 2022 20:14:18 -0400
Message-ID: <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
Subject: Re: radeon ring 0 test failed on arm64
To: Kever Yang <kever.yang@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 17 Mar 2022 03:19:09 +0000
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
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good Evening,

I apologize for raising this email chain from the dead, but there have
been some developments that have introduced even more questions.
I've looped the Rockchip mailing list into this too, as this affects
rk356x, and likely the upcoming rk3588 if [1] is to be believed.

TLDR for those not familiar: It seems the rk356x series (and possibly
the rk3588) were built without any outer coherent cache.
This means (unless Rockchip wants to clarify here) devices such as the
ITS and PCIe cannot utilize cache snooping.
This is based on the results of the email chain [2].

The new circumstances are as follows:
The RPi CM4 Adventure Team as I've taken to calling them has been
attempting to get a dGPU working with the very broken Broadcom
controller in the RPi CM4.
Recently they acquired a SoQuartz rk3566 module which is pin
compatible with the CM4, and have taken to trying it out as well.

This is how I got involved.
It seems they found a trivial way to force the Radeon R600 driver to
use Non-Cached memory for everything.
This single line change, combined with using memset_io instead of
memset, allows the ring tests to pass and the card probes successfully
(minus the DMA limitations of the rk356x due to the 32 bit
interconnect).
I discovered using this method that we start having unaligned io
memory access faults (bus errors) when running glmark2-drm (running
glmark2 directly was impossible, as both X and Wayland crashed too
early).
I traced this to using what I thought at the time was an unsafe memcpy
in the mesa stack.
Rewriting this function to force aligned writes solved the problem and
allows glmark2-drm to run to completion.
With some extensive debugging, I found about half a dozen memcpy
functions in mesa that if forced to be aligned would allow Wayland to
start, but with hilarious display corruption (see [3]. [4]).
The CM4 team is convinced this is an issue with memcpy in glibc, but
I'm not convinced it's that simple.

On my two hour drive in to work this morning, I got to thinking.
If this was an memcpy fault, this would be universally broken on arm64
which is obviously not the case.
So I started thinking, what is different here than with systems known to wo=
rk:
1. No IOMMU for the PCIe controller.
2. The Outer Cache Issue.

Robin:
My questions for you, since you're the smartest person I know about
arm64 memory management:
Could cache snooping permit unaligned accesses to IO to be safe?
Or
Is it the lack of an IOMMU that's causing the alignment faults to become fa=
tal?
Or
Am I insane here?

Rockchip:
Please update on the status for the Outer Cache errata for ITS services.
Please provide an answer to the errata of the PCIe controller, in
regard to cache snooping and buffering, for both the rk356x and the
upcoming rk3588.

[1] https://github.com/JeffyCN/mirrors/commit/0b985f29304dcb9d644174edacb67=
298e8049d4f
[2] https://lore.kernel.org/lkml/871rbdt4tu.wl-maz@kernel.org/T/
[3] https://cdn.discordapp.com/attachments/926487797844541510/9534147559708=
50816/unknown.png
[4] https://cdn.discordapp.com/attachments/926487797844541510/9534249520428=
52422/unknown.png

Thank you everyone for your time.

Very Respectfully,
Peter Geis

On Wed, May 26, 2021 at 7:21 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Robin,
>
> Am 26.05.21 um 12:59 schrieb Robin Murphy:
> > On 2021-05-26 10:42, Christian K=C3=B6nig wrote:
> >> Hi Robin,
> >>
> >> Am 25.05.21 um 22:09 schrieb Robin Murphy:
> >>> On 2021-05-25 14:05, Alex Deucher wrote:
> >>>> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
> >>>> wrote:
> >>>>>
> >>>>> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
> >>>>> <alexdeucher@gmail.com> wrote:
> >>>>>>
> >>>>>> On Tue, May 25, 2021 at 8:42 AM Peter Geis <pgwipeout@gmail.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> Good Evening,
> >>>>>>>
> >>>>>>> I am stress testing the pcie controller on the rk3566-quartz64
> >>>>>>> prototype SBC.
> >>>>>>> This device has 1GB available at <0x3 0x00000000> for the PCIe
> >>>>>>> controller, which makes a dGPU theoretically possible.
> >>>>>>> While attempting to light off a HD7570 card I manage to get a
> >>>>>>> modeset
> >>>>>>> console, but ring0 test fails and disables acceleration.
> >>>>>>>
> >>>>>>> Note, we do not have UEFI, so all PCIe setup is from the Linux
> >>>>>>> kernel.
> >>>>>>> Any insight you can provide would be much appreciated.
> >>>>>>
> >>>>>> Does your platform support PCIe cache coherency with the CPU?  I.e=
.,
> >>>>>> does the CPU allow cache snoops from PCIe devices?  That is requir=
ed
> >>>>>> for the driver to operate.
> >>>>>
> >>>>> Ah, most likely not.
> >>>>> This issue has come up already as the GIC isn't permitted to snoop =
on
> >>>>> the CPUs, so I doubt the PCIe controller can either.
> >>>>>
> >>>>> Is there no way to work around this or is it dead in the water?
> >>>>
> >>>> It's required by the pcie spec.  You could potentially work around i=
t
> >>>> if you can allocate uncached memory for DMA, but I don't think that =
is
> >>>> possible currently.  Ideally we'd figure out some way to detect if a
> >>>> particular platform supports cache snooping or not as well.
> >>>
> >>> There's device_get_dma_attr(), although I don't think it will work
> >>> currently for PCI devices without an OF or ACPI node - we could
> >>> perhaps do with a PCI-specific wrapper which can walk up and defer
> >>> to the host bridge's firmware description as necessary.
> >>>
> >>> The common DMA ops *do* correctly keep track of per-device coherency
> >>> internally, but drivers aren't supposed to be poking at that
> >>> information directly.
> >>
> >> That sounds like you underestimate the problem. ARM has unfortunately
> >> made the coherency for PCI an optional IP.
> >
> > Sorry to be that guy, but I'm involved a lot internally with our
> > system IP and interconnect, and I probably understand the situation
> > better than 99% of the community ;)
>
> I need to apologize, didn't realized who was answering :)
>
> It just sounded to me that you wanted to suggest to the end user that
> this is fixable in software and I really wanted to avoid even more
> customers coming around asking how to do this.
>
> > For the record, the SBSA specification (the closet thing we have to a
> > "system architecture") does require that PCIe is integrated in an
> > I/O-coherent manner, but we don't have any control over what people do
> > in embedded applications (note that we don't make PCIe IP at all, and
> > there is plenty of 3rd-party interconnect IP).
>
> So basically it is not the fault of the ARM IP-core, but people are just
> stitching together PCIe interconnect IP with a core where it is not
> supposed to be used with.
>
> Do I get that correctly? That's an interesting puzzle piece in the pictur=
e.
>
> >> So we are talking about a hardware limitation which potentially can't
> >> be fixed without replacing the hardware.
> >
> > You expressed interest in "some way to detect if a particular platform
> > supports cache snooping or not", by which I assumed you meant a
> > software method for the amdgpu/radeon drivers to call, rather than,
> > say, a website that driver maintainers can look up SoC names on. I'm
> > saying that that API already exists (just may need a bit more work).
> > Note that it is emphatically not a platform-level thing since
> > coherency can and does vary per device within a system.
>
> Well, I think this is not something an individual driver should mess
> with. What the driver should do is just express that it needs coherent
> access to all of system memory and if that is not possible fail to load
> with a warning why it is not possible.
>
> >
> > I wasn't suggesting that Linux could somehow make coherency magically
> > work when the signals don't physically exist in the interconnect - I
> > was assuming you'd merely want to do something like throw a big
> > warning and taint the kernel to help triage bug reports. Some drivers
> > like ahci_qoriq and panfrost simply need to know so they can program
> > their device to emit the appropriate memory attributes either way, and
> > rely on the DMA API to hide the rest of the difference, but if you
> > want to treat non-coherent use as unsupported because it would require
> > too invasive changes that's fine by me.
>
> Yes exactly that please. I mean not sure how panfrost is doing it, but
> at least the Vulkan userspace API specification requires devices to have
> coherent access to system memory.
>
> So even if I would want to do this it is simply not possible because the
> application doesn't tell the driver which memory is accessed by the
> device and which by the CPU.
>
> Christian.
>
> >
> > Robin.
>
