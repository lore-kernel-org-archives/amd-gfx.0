Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F4FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 20:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C0610E780;
	Thu, 17 Mar 2022 20:27:41 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FF510E780
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 20:27:39 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 q1-20020a4a7d41000000b003211b63eb7bso7868541ooe.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iv/OJkHPaMnCc+U3vxZvDDpvOMmikwuG/jvKDsftmmo=;
 b=eJfZvpUatIvQlZprLySpLAmwYGAn1xguiwhzBj+hV7P4ihNItwag7Ler9eSqAb+w8s
 IdeWV2/c6NB8L6lqmGHpu5NQoql2iGWyD1Ry77lDAhFEU9dymBMd+2qowhXUHCNt0C13
 ccbNHThybMfDizFHQmRHKoZn8eD/5FPCsFyYabBe1tpqfZ65yZNI3KEKKCNMbC/ciN6l
 dkEi6KBMr+oTLbLl/XjSujmO18eR1cZfLCg6YkqIVxbucUPSHiRLHgZKn12GZY6LU6Yb
 T7M2TcUdND2fqXfCcKKh0BWl1NcFruAQHTuGZqvT02U4ZJ0hZ0XIog6s/dfzjm6GItx7
 1IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iv/OJkHPaMnCc+U3vxZvDDpvOMmikwuG/jvKDsftmmo=;
 b=65hcGBMtoYOwyLboBx7377VW/HWaVm50C5CK+hkIEpaEECxCRec3kRJgJKFG+nX2Cx
 iQFltOYk7n8bdohhP6BtFDdAPI11EQMvpYjj1odk6llqpkpNcW7oNTFTeuCm877Jzt6p
 Hp7AhWOM32gE0DyTg5As57tdZ0a0yVyfizw2TMsaKLuEUDSRYXja62cJ+IJc7/nQw3eR
 8+czM+yn282hfCsWFWF7IIEfDiKbiVl+9UJDgaWl3WhHkgJMdpvRaqIoycUEQpC4auoX
 ksH30Z+VfKHMZHyk9/J9i85PZb5PAk+Hq1vmhikPHpcPEGHgvKD2+Jpgf/i4UrsLh3kS
 HxMw==
X-Gm-Message-State: AOAM532cCONZBC80yA/mQfgxAspw4g7EGl1nVsJB/zIlTFyH7rTzx/0W
 gZYul1yr8ABk29z5Ze+7MjiCN0tm2y/cPAWE88Y=
X-Google-Smtp-Source: ABdhPJzXe+gRGct7a7VxBZi+g6xbJD7JTGm5EBC04s62nAH1o2bgmpznmjNjkiS6gclAR/ftCllIbOMesTKa7Ak8CdQ=
X-Received: by 2002:a05:6871:8ab:b0:dd:b74b:409a with SMTP id
 r43-20020a05687108ab00b000ddb74b409amr1960073oaq.200.1647548858735; Thu, 17
 Mar 2022 13:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <a62372c7-d274-a58a-0487-d199312fd7d6@amd.com>
In-Reply-To: <a62372c7-d274-a58a-0487-d199312fd7d6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Mar 2022 16:27:27 -0400
Message-ID: <CADnq5_NJftHTnVm+oHfftjxXGWRkiYkGsqZbL-cQn7O3qGa8UA@mail.gmail.com>
Subject: Re: radeon ring 0 test failed on arm64
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Peter Geis <pgwipeout@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Robin Murphy <robin.murphy@arm.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 5:15 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Peter,
>
> Am 17.03.22 um 01:14 schrieb Peter Geis:
> > Good Evening,
> >
> > I apologize for raising this email chain from the dead, but there have
> > been some developments that have introduced even more questions.
> > I've looped the Rockchip mailing list into this too, as this affects
> > rk356x, and likely the upcoming rk3588 if [1] is to be believed.
> >
> > TLDR for those not familiar: It seems the rk356x series (and possibly
> > the rk3588) were built without any outer coherent cache.
> > This means (unless Rockchip wants to clarify here) devices such as the
> > ITS and PCIe cannot utilize cache snooping.
>
> well, as far as I know that is a clear violation of the PCIe specificatio=
n.
>
> Coherent access to system memory is simply a must have.
>
> > This is based on the results of the email chain [2].
> >
> > The new circumstances are as follows:
> > The RPi CM4 Adventure Team as I've taken to calling them has been
> > attempting to get a dGPU working with the very broken Broadcom
> > controller in the RPi CM4.
> > Recently they acquired a SoQuartz rk3566 module which is pin
> > compatible with the CM4, and have taken to trying it out as well.
> >
> > This is how I got involved.
> > It seems they found a trivial way to force the Radeon R600 driver to
> > use Non-Cached memory for everything.
>
> Yeah, you basically just force it into AGP mode :)
>
> There is just absolutely no guarantee that this works reliable.

It might not be too bad if we use the internal GART rather than AGP.
The challenge will be allocating uncached system memory.  I think that
tended to be the problem on most non-x86 platforms.

Alex


>
> > This single line change, combined with using memset_io instead of
> > memset, allows the ring tests to pass and the card probes successfully
> > (minus the DMA limitations of the rk356x due to the 32 bit
> > interconnect).
> > I discovered using this method that we start having unaligned io
> > memory access faults (bus errors) when running glmark2-drm (running
> > glmark2 directly was impossible, as both X and Wayland crashed too
> > early).
> > I traced this to using what I thought at the time was an unsafe memcpy
> > in the mesa stack.
> > Rewriting this function to force aligned writes solved the problem and
> > allows glmark2-drm to run to completion.
> > With some extensive debugging, I found about half a dozen memcpy
> > functions in mesa that if forced to be aligned would allow Wayland to
> > start, but with hilarious display corruption (see [3]. [4]).
> > The CM4 team is convinced this is an issue with memcpy in glibc, but
> > I'm not convinced it's that simple.
>
> Yes exactly that.
>
> Both OpenGL and Vulkan allow the application to mmap() device memory and
> do any memory access they want with that.
>
> This means that changing memcpy is just a futile effort, it's still
> possible for the application to make an unaligned memory access and that
> is perfectly valid.
>
> > On my two hour drive in to work this morning, I got to thinking.
> > If this was an memcpy fault, this would be universally broken on arm64
> > which is obviously not the case.
> > So I started thinking, what is different here than with systems known t=
o work:
> > 1. No IOMMU for the PCIe controller.
> > 2. The Outer Cache Issue.
>
> Oh, very good point. I would be interested in that as answer as well.
>
> Regards,
> Christian.
>
> >
> > Robin:
> > My questions for you, since you're the smartest person I know about
> > arm64 memory management:
> > Could cache snooping permit unaligned accesses to IO to be safe?
> > Or
> > Is it the lack of an IOMMU that's causing the alignment faults to becom=
e fatal?
> > Or
> > Am I insane here?
> >
> > Rockchip:
> > Please update on the status for the Outer Cache errata for ITS services=
.
> > Please provide an answer to the errata of the PCIe controller, in
> > regard to cache snooping and buffering, for both the rk356x and the
> > upcoming rk3588.
> >
> > [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298=
e8049d4f&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a76=
5f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378307287620=
44450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DZL3jA2VrnynWbUdFG6naaqrZqcnKRq338n=
%2Bj50DRa74%3D&amp;reserved=3D0
> > [2] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flore.kernel.org%2Flkml%2F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;data=3D=
04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8ec4a765f8a08da07ab1cb2%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637830728762044450%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C3000&amp;sdata=3DQZy%2Bt%2Fus5f3yxwrHmXpzerXngPpKp3i9ZsF1UJ%2BHvlU%3D&a=
mp;reserved=3D0
> > [3] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953414755970850816=
%2Funknown.png&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8=
ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378307=
28762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dc29bc87hxyIvnsBK3Fo7FbF7RwJc=
Fr%2FjgBrLIiBb%2FyY%3D&amp;reserved=3D0
> > [4] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852422=
%2Funknown.png&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C4ae2dfa3e8=
ec4a765f8a08da07ab1cb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378307=
28762044450%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DfwygTk%2BDzdla67rdAYb44vlivl=
by9lFwtcgjLfJEH4A%3D&amp;reserved=3D0
> >
> > Thank you everyone for your time.
> >
> > Very Respectfully,
> > Peter Geis
> >
> > On Wed, May 26, 2021 at 7:21 AM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Hi Robin,
> >>
> >> Am 26.05.21 um 12:59 schrieb Robin Murphy:
> >>> On 2021-05-26 10:42, Christian K=C3=B6nig wrote:
> >>>> Hi Robin,
> >>>>
> >>>> Am 25.05.21 um 22:09 schrieb Robin Murphy:
> >>>>> On 2021-05-25 14:05, Alex Deucher wrote:
> >>>>>> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
> >>>>>> wrote:
> >>>>>>> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
> >>>>>>> <alexdeucher@gmail.com> wrote:
> >>>>>>>> On Tue, May 25, 2021 at 8:42 AM Peter Geis <pgwipeout@gmail.com>
> >>>>>>>> wrote:
> >>>>>>>>> Good Evening,
> >>>>>>>>>
> >>>>>>>>> I am stress testing the pcie controller on the rk3566-quartz64
> >>>>>>>>> prototype SBC.
> >>>>>>>>> This device has 1GB available at <0x3 0x00000000> for the PCIe
> >>>>>>>>> controller, which makes a dGPU theoretically possible.
> >>>>>>>>> While attempting to light off a HD7570 card I manage to get a
> >>>>>>>>> modeset
> >>>>>>>>> console, but ring0 test fails and disables acceleration.
> >>>>>>>>>
> >>>>>>>>> Note, we do not have UEFI, so all PCIe setup is from the Linux
> >>>>>>>>> kernel.
> >>>>>>>>> Any insight you can provide would be much appreciated.
> >>>>>>>> Does your platform support PCIe cache coherency with the CPU?  I=
.e.,
> >>>>>>>> does the CPU allow cache snoops from PCIe devices?  That is requ=
ired
> >>>>>>>> for the driver to operate.
> >>>>>>> Ah, most likely not.
> >>>>>>> This issue has come up already as the GIC isn't permitted to snoo=
p on
> >>>>>>> the CPUs, so I doubt the PCIe controller can either.
> >>>>>>>
> >>>>>>> Is there no way to work around this or is it dead in the water?
> >>>>>> It's required by the pcie spec.  You could potentially work around=
 it
> >>>>>> if you can allocate uncached memory for DMA, but I don't think tha=
t is
> >>>>>> possible currently.  Ideally we'd figure out some way to detect if=
 a
> >>>>>> particular platform supports cache snooping or not as well.
> >>>>> There's device_get_dma_attr(), although I don't think it will work
> >>>>> currently for PCI devices without an OF or ACPI node - we could
> >>>>> perhaps do with a PCI-specific wrapper which can walk up and defer
> >>>>> to the host bridge's firmware description as necessary.
> >>>>>
> >>>>> The common DMA ops *do* correctly keep track of per-device coherenc=
y
> >>>>> internally, but drivers aren't supposed to be poking at that
> >>>>> information directly.
> >>>> That sounds like you underestimate the problem. ARM has unfortunatel=
y
> >>>> made the coherency for PCI an optional IP.
> >>> Sorry to be that guy, but I'm involved a lot internally with our
> >>> system IP and interconnect, and I probably understand the situation
> >>> better than 99% of the community ;)
> >> I need to apologize, didn't realized who was answering :)
> >>
> >> It just sounded to me that you wanted to suggest to the end user that
> >> this is fixable in software and I really wanted to avoid even more
> >> customers coming around asking how to do this.
> >>
> >>> For the record, the SBSA specification (the closet thing we have to a
> >>> "system architecture") does require that PCIe is integrated in an
> >>> I/O-coherent manner, but we don't have any control over what people d=
o
> >>> in embedded applications (note that we don't make PCIe IP at all, and
> >>> there is plenty of 3rd-party interconnect IP).
> >> So basically it is not the fault of the ARM IP-core, but people are ju=
st
> >> stitching together PCIe interconnect IP with a core where it is not
> >> supposed to be used with.
> >>
> >> Do I get that correctly? That's an interesting puzzle piece in the pic=
ture.
> >>
> >>>> So we are talking about a hardware limitation which potentially can'=
t
> >>>> be fixed without replacing the hardware.
> >>> You expressed interest in "some way to detect if a particular platfor=
m
> >>> supports cache snooping or not", by which I assumed you meant a
> >>> software method for the amdgpu/radeon drivers to call, rather than,
> >>> say, a website that driver maintainers can look up SoC names on. I'm
> >>> saying that that API already exists (just may need a bit more work).
> >>> Note that it is emphatically not a platform-level thing since
> >>> coherency can and does vary per device within a system.
> >> Well, I think this is not something an individual driver should mess
> >> with. What the driver should do is just express that it needs coherent
> >> access to all of system memory and if that is not possible fail to loa=
d
> >> with a warning why it is not possible.
> >>
> >>> I wasn't suggesting that Linux could somehow make coherency magically
> >>> work when the signals don't physically exist in the interconnect - I
> >>> was assuming you'd merely want to do something like throw a big
> >>> warning and taint the kernel to help triage bug reports. Some drivers
> >>> like ahci_qoriq and panfrost simply need to know so they can program
> >>> their device to emit the appropriate memory attributes either way, an=
d
> >>> rely on the DMA API to hide the rest of the difference, but if you
> >>> want to treat non-coherent use as unsupported because it would requir=
e
> >>> too invasive changes that's fine by me.
> >> Yes exactly that please. I mean not sure how panfrost is doing it, but
> >> at least the Vulkan userspace API specification requires devices to ha=
ve
> >> coherent access to system memory.
> >>
> >> So even if I would want to do this it is simply not possible because t=
he
> >> application doesn't tell the driver which memory is accessed by the
> >> device and which by the CPU.
> >>
> >> Christian.
> >>
> >>> Robin.
>
