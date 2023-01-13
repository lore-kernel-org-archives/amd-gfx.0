Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C65C6379F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 23:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7981F10E21C;
	Fri, 13 Jan 2023 23:39:04 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7D310E21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 23:39:02 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id b4so13753404edf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9y+byyGB8tQWvysQWFZHVs0d2Xf/aNV7SEAmJ+hPpE=;
 b=GlbcwkeTr36P+HnnJ17cVZoyS+502qIn+eyQiejfPHs9zafKGMJwsgxMZQj+QAjNbA
 g5kk5TErGiSUGEnnLd8V+IpuG3ysbwgv/oLW09RP8XuW6DZg7SoG59RULM2u8i4LQD1F
 LlHvldn23FOolWbeMvTqN1YoCGT/FixINJU3JYQBuNGH/gEDTva1EisgFarGHMCW08jV
 K6elA3SQ22L9+W9The3gGHsd0QMYaYvD8b3Voma0vY4p0zkfSaNU62XcRcD/K51Q8PDV
 P0qgEOoafOcrn6gW3HcicjZMrJlTpNotkfmeXOazD7D6qrTnHjTMdC8jeu3kcw8uhzkB
 dQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9y+byyGB8tQWvysQWFZHVs0d2Xf/aNV7SEAmJ+hPpE=;
 b=Uv5Q0ehuXLxE85ZbPr1Shl5zI0kwnw0y+V3uGIt/U/uSOGk63SjiFJ2rcGyUysIIB/
 duNtOy+U1SqhR/ERSNVqPWM+uhG8Uibwknb/OSRsaZTZVlSXOfe4s6Ru/W1PvtHrQlDD
 GvCg9vMIuUutrMuh4fI9zpx926N3VWOBbiqjmLaDgKYzAcsTM+PKqXdlaNlXcTbMCGkQ
 wiSG6PQpJ6cIA4U2Qzmy+DazeIj6GO7z/wIthPd8Z7ZMCbKxzgH7Z+/rumsQraJEUr1f
 YdskLlz9scgphEY7dVU2ep++g9I/o6eCjh59xomN5lx8WjCkHd8qLuDTqonGUOEKbtiR
 sSZg==
X-Gm-Message-State: AFqh2krY9zmXluR3vTNmAbBlOUwGULX6Uq0LZT4bFmSBBddI9kznGhPJ
 qAc3T18A6cWDHgfN32/9UyQ3tGw/bHJ21zYmCu2nHaoG
X-Google-Smtp-Source: AMrXdXs18Qgi64Y3g77SeDaYx2TiRW5mRMztsa41dJPela4iM59kb2KdEQ04mpagPi5DwzN9C7V9VUSRZZ4IxInGbrs=
X-Received: by 2002:a05:6402:3453:b0:49c:705:41ec with SMTP id
 l19-20020a056402345300b0049c070541ecmr588395edc.183.1673653140667; Fri, 13
 Jan 2023 15:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
 <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
 <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
 <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
 <e931b723-d4bf-be9c-0f08-6f3bf00eb938@amd.com>
 <CADnq5_NOmdq9_kUzm9cnavyn6czx18-kKmLm0-R6msRdqOwXsA@mail.gmail.com>
 <CAAxE2A7QvaE3triTt6vAYuWmkaG6DRZsdkQrLJcpDXj96-GO9w@mail.gmail.com>
 <CADnq5_Pr+8vdtEtn4K5kd-ssbvsGAf2_wnsqAkMpLJUPW+55_g@mail.gmail.com>
 <CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com>
In-Reply-To: <CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 13 Jan 2023 18:38:24 -0500
Message-ID: <CAAxE2A6y1uFoGVfZ2B4iw98tbScBh8dr2Yys8OkQ11B=0xn=uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ed441305f22dbc92"
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ed441305f22dbc92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Valve would like this in kernel 6.2, but if put it there, we also need to
backport INFO ioctl changes for DRM driver version 3.50.0.

Marek

On Fri, Jan 13, 2023 at 6:33 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:

> There is no hole on 32-bit unfortunately. It looks like the hole on 64-bi=
t
> is now ABI.
>
> I moved the field to replace _pad1. The patch is attached (with your Rb).
>
> Marek
>
> On Fri, Jan 13, 2023 at 4:20 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
>
>> On Fri, Jan 13, 2023 at 4:02 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>> >
>> > i've added the comments and indeed pahole shows the hole as expected.
>>
>> What about on 32-bit?
>>
>> Alex
>>
>> >
>> > Marek
>> >
>> > On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher <alexdeucher@gmail.com>
>> wrote:
>> >>
>> >> On Thu, Jan 12, 2023 at 6:50 AM Christian K=C3=B6nig
>> >> <christian.koenig@amd.com> wrote:
>> >> >
>> >> > Am 11.01.23 um 21:48 schrieb Alex Deucher:
>> >> > > On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com>
>> wrote:
>> >> > >> Yes, it's meant to be like a spec sheet. We are not interested i=
n
>> the current bandwidth utilization.
>> >> > > After chatting with Marek on IRC and thinking about this more, I
>> think
>> >> > > this patch is fine.  It's not really meant for bandwidth per se,
>> but
>> >> > > rather as a limit to determine what the driver should do in certa=
in
>> >> > > cases (i.e., when does it make sense to copy to vram vs not).  It=
's
>> >> > > not straightforward for userspace to parse the full topology to
>> >> > > determine what links may be slow.  I guess one potential pitfall
>> would
>> >> > > be that if you pass the device into a VM, the driver may report t=
he
>> >> > > wrong values.  Generally in a VM the VM doesn't get the full view
>> up
>> >> > > to the root port.  I don't know if the hypervisors report properl=
y
>> for
>> >> > > pcie_bandwidth_available() in a VM or if it just shows the info
>> about
>> >> > > the endpoint in the VM.
>> >> >
>> >> > So this basically doesn't return the gen and lanes of the device, b=
ut
>> >> > rather what was negotiated between the device and the upstream root
>> port?
>> >>
>> >> Correct. It exposes the max gen and lanes of the slowest link between
>> >> the device and the root port.
>> >>
>> >> >
>> >> > If I got that correctly then we should probably document that cause
>> >> > otherwise somebody will try to "fix" it at some time.
>> >>
>> >> Good point.
>> >>
>> >> Alex
>> >>
>> >> >
>> >> > Christian.
>> >> >
>> >> > >
>> >> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> >> > >
>> >> > > Alex
>> >> > >
>> >> > >> Marek
>> >> > >>
>> >> > >> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com>
>> wrote:
>> >> > >>> [AMD Official Use Only - General]
>> >> > >>>
>> >> > >>>
>> >> > >>> To clarify, with DPM in place, the current bandwidth will be
>> changing based on the load.
>> >> > >>>
>> >> > >>> If apps/umd already has a way to know the current bandwidth
>> utilisation, then possible maximum also could be part of the same API.
>> Otherwise, this only looks like duplicate information. We have the same
>> information in sysfs DPM nodes.
>> >> > >>>
>> >> > >>> BTW, I don't know to what extent app/umd really makes use of
>> this. Take that memory frequency as an example (I'm reading it as 16GHz)=
.
>> It only looks like a spec sheet.
>> >> > >>>
>> >> > >>> Thanks,
>> >> > >>> Lijo
>> >> > >>> ________________________________
>> >> > >>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
>> >> > >>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>> >> > >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> >> > >>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g
>> >
>> >> > >>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and
>> lanes from the INFO
>> >> > >>>
>> >> > >>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com>
>> wrote:
>> >> > >>>
>> >> > >>>
>> >> > >>>
>> >> > >>> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
>> >> > >>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
>> >> > >>>> <mailto:lijo.lazar@amd.com>> wrote:
>> >> > >>>>
>> >> > >>>>
>> >> > >>>>
>> >> > >>>>      On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
>> >> > >>>>       > I see. Well, those sysfs files are not usable, and I
>> don't think it
>> >> > >>>>       > would be important even if they were usable, but for
>> completeness:
>> >> > >>>>       >
>> >> > >>>>       > The ioctl returns:
>> >> > >>>>       >      pcie_gen =3D 1
>> >> > >>>>       >      pcie_num_lanes =3D 16
>> >> > >>>>       >
>> >> > >>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>> >> > >>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>> >> > >>>>       > It matches the expectation.
>> >> > >>>>       >
>> >> > >>>>       > Let's see the devices (there is only 1 GPU Navi21 in
>> the system):
>> >> > >>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>> >> > >>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc.
>> [AMD/ATI] Navi
>> >> > >>>>      10 XL
>> >> > >>>>       > Upstream Port of PCI Express Switch (rev c3)
>> >> > >>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc.
>> [AMD/ATI] Navi
>> >> > >>>>      10 XL
>> >> > >>>>       > Downstream Port of PCI Express Switch
>> >> > >>>>       > 0c:00.0 VGA compatible controller: Advanced Micro
>> Devices, Inc.
>> >> > >>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT]
>> (rev c3)
>> >> > >>>>       >
>> >> > >>>>       > Let's read sysfs:
>> >> > >>>>       >
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>> >> > >>>>       > 2.5 GT/s PCIe
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>> >> > >>>>       > 16.0 GT/s PCIe
>> >> > >>>>       > $ cat
>> /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>> >> > >>>>       > 16.0 GT/s PCIe
>> >> > >>>>       >
>> >> > >>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>> >> > >>>>
>> >> > >>>>      US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed=
.
>> Total
>> >> > >>>>      theoretical bandwidth is then derived based on encoding
>> and total
>> >> > >>>>      number
>> >> > >>>>      of lanes.
>> >> > >>>>
>> >> > >>>>       > Problem 2: Userspace doesn't know the bus index of the
>> bridges,
>> >> > >>>>      and it's
>> >> > >>>>       > not clear which bridge should be used.
>> >> > >>>>
>> >> > >>>>      In general, modern ones have this arch=3D US->DS->EP. US =
is
>> the one
>> >> > >>>>      connected to physical link.
>> >> > >>>>
>> >> > >>>>       > Problem 3: The PCIe gen number is missing.
>> >> > >>>>
>> >> > >>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
>> >> > >>>>
>> >> > >>>>      BTW, your patch makes use of capabilities flags which
>> gives the maximum
>> >> > >>>>      supported speed/width by the device. It may not
>> necessarily reflect the
>> >> > >>>>      current speed/width negotiated. I guess in NV, this info
>> is already
>> >> > >>>>      obtained from PMFW and made available through metrics
>> table.
>> >> > >>>>
>> >> > >>>>
>> >> > >>>> It computes the minimum of the device PCIe gen and the
>> motherboard/slot
>> >> > >>>> PCIe gen to get the final value. These 2 lines do that. The lo=
w
>> 16 bits
>> >> > >>>> of the mask contain the device PCIe gen mask. The high 16 bits
>> of the
>> >> > >>>> mask contain the slot PCIe gen mask.
>> >> > >>>> + pcie_gen_mask =3D adev->pm.pcie_gen_mask &
>> (adev->pm.pcie_gen_mask >> 16);
>> >> > >>>> + dev_info->pcie_gen =3D fls(pcie_gen_mask);
>> >> > >>>>
>> >> > >>> With DPM in place on some ASICs, how much does this static info
>> help for
>> >> > >>> upper level apps?
>> >> > >>>
>> >> > >>>
>> >> > >>> It helps UMDs make better decisions if they know the maximum
>> achievable bandwidth. UMDs also compute the maximum memory bandwidth and
>> compute performance (FLOPS). Right now it's printed by Mesa to give user=
s
>> detailed information about their GPU. For example:
>> >> > >>>
>> >> > >>> $ AMD_DEBUG=3Dinfo glxgears
>> >> > >>> Device info:
>> >> > >>>      name =3D NAVI21
>> >> > >>>      marketing_name =3D AMD Radeon RX 6800
>> >> > >>>      num_se =3D 3
>> >> > >>>      num_rb =3D 12
>> >> > >>>      num_cu =3D 60
>> >> > >>>      max_gpu_freq =3D 2475 MHz
>> >> > >>>      max_gflops =3D 19008 GFLOPS
>> >> > >>>      l0_cache_size =3D 16 KB
>> >> > >>>      l1_cache_size =3D 128 KB
>> >> > >>>      l2_cache_size =3D 4096 KB
>> >> > >>>      l3_cache_size =3D 128 MB
>> >> > >>>      memory_channels =3D 16 (TCC blocks)
>> >> > >>>      memory_size =3D 16 GB (16384 MB)
>> >> > >>>      memory_freq =3D 16 GHz
>> >> > >>>      memory_bus_width =3D 256 bits
>> >> > >>>      memory_bandwidth =3D 512 GB/s
>> >> > >>>      pcie_gen =3D 1
>> >> > >>>      pcie_num_lanes =3D 16
>> >> > >>>      pcie_bandwidth =3D 4.0 GB/s
>> >> > >>>
>> >> > >>> Marek
>> >> >
>>
>

--000000000000ed441305f22dbc92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Valve would like this in kernel 6.2, but if put it there, =
we also need to backport INFO ioctl changes for DRM driver version 3.50.0.<=
div><br></div><div>Marek</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jan 13, 2023 at 6:33 PM Marek Ol=C5=
=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div>There is no hole on 32-bit unfortunately. It looks like the h=
ole on 64-bit is now ABI.</div><div><br></div><div>I moved the field to rep=
lace _pad1. The patch is attached (with your Rb).</div><div><br></div><div>=
Marek</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">On Fri, Jan 13, 2023=
 at 4:20 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" targe=
t=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:<br></div><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jan 13=
, 2023 at 4:02 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.=
com" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; i&#39;ve added the comments and indeed pahole shows the hole as expect=
ed.<br>
<br>
What about on 32-bit?<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher &lt;<a href=3D"mailto:al=
exdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:=
<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jan 12, 2023 at 6:50 AM Christian K=C3=B6nig<br>
&gt;&gt; &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">=
christian.koenig@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Am 11.01.23 um 21:48 schrieb Alex Deucher:<br>
&gt;&gt; &gt; &gt; On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k &lt=
;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>=
&gt; wrote:<br>
&gt;&gt; &gt; &gt;&gt; Yes, it&#39;s meant to be like a spec sheet. We are =
not interested in the current bandwidth utilization.<br>
&gt;&gt; &gt; &gt; After chatting with Marek on IRC and thinking about this=
 more, I think<br>
&gt;&gt; &gt; &gt; this patch is fine.=C2=A0 It&#39;s not really meant for =
bandwidth per se, but<br>
&gt;&gt; &gt; &gt; rather as a limit to determine what the driver should do=
 in certain<br>
&gt;&gt; &gt; &gt; cases (i.e., when does it make sense to copy to vram vs =
not).=C2=A0 It&#39;s<br>
&gt;&gt; &gt; &gt; not straightforward for userspace to parse the full topo=
logy to<br>
&gt;&gt; &gt; &gt; determine what links may be slow.=C2=A0 I guess one pote=
ntial pitfall would<br>
&gt;&gt; &gt; &gt; be that if you pass the device into a VM, the driver may=
 report the<br>
&gt;&gt; &gt; &gt; wrong values.=C2=A0 Generally in a VM the VM doesn&#39;t=
 get the full view up<br>
&gt;&gt; &gt; &gt; to the root port.=C2=A0 I don&#39;t know if the hypervis=
ors report properly for<br>
&gt;&gt; &gt; &gt; pcie_bandwidth_available() in a VM or if it just shows t=
he info about<br>
&gt;&gt; &gt; &gt; the endpoint in the VM.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So this basically doesn&#39;t return the gen and lanes of the=
 device, but<br>
&gt;&gt; &gt; rather what was negotiated between the device and the upstrea=
m root port?<br>
&gt;&gt;<br>
&gt;&gt; Correct. It exposes the max gen and lanes of the slowest link betw=
een<br>
&gt;&gt; the device and the root port.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; If I got that correctly then we should probably document that=
 cause<br>
&gt;&gt; &gt; otherwise somebody will try to &quot;fix&quot; it at some tim=
e.<br>
&gt;&gt;<br>
&gt;&gt; Good point.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Christian.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexande=
r.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; Alex<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt;&gt; Marek<br>
&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt; On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo &lt;<a h=
ref=3D"mailto:Lijo.Lazar@amd.com" target=3D"_blank">Lijo.Lazar@amd.com</a>&=
gt; wrote:<br>
&gt;&gt; &gt; &gt;&gt;&gt; [AMD Official Use Only - General]<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; To clarify, with DPM in place, the current bandw=
idth will be changing based on the load.<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; If apps/umd already has a way to know the curren=
t bandwidth utilisation, then possible maximum also could be part of the sa=
me API. Otherwise, this only looks like duplicate information. We have the =
same information in sysfs DPM nodes.<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; BTW, I don&#39;t know to what extent app/umd rea=
lly makes use of this. Take that memory frequency as an example (I&#39;m re=
ading it as 16GHz). It only looks like a spec sheet.<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; Thanks,<br>
&gt;&gt; &gt; &gt;&gt;&gt; Lijo<br>
&gt;&gt; &gt; &gt;&gt;&gt; ________________________________<br>
&gt;&gt; &gt; &gt;&gt;&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailt=
o:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; Sent: Wednesday, January 4, 2023 8:40:00 PM<br>
&gt;&gt; &gt; &gt;&gt;&gt; To: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar=
@amd.com" target=3D"_blank">Lijo.Lazar@amd.com</a>&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; Cc: <a href=3D"mailto:amd-gfx@lists.freedesktop.=
org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mai=
lto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesk=
top.org</a>&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; Subject: Re: [PATCH 1/2] drm/amdgpu: return the =
PCIe gen and lanes from the INFO<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo &lt;<=
a href=3D"mailto:lijo.lazar@amd.com" target=3D"_blank">lijo.lazar@amd.com</=
a>&gt; wrote:<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote=
:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &=
lt;<a href=3D"mailto:lijo.lazar@amd.com" target=3D"_blank">lijo.lazar@amd.c=
om</a><br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:lijo.lazar@amd.=
com" target=3D"_blank">lijo.lazar@amd.com</a>&gt;&gt; wrote:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 On 1/4/2023 4:11 AM, Mar=
ek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; I see. Well, =
those sysfs files are not usable, and I don&#39;t think it<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; would be impo=
rtant even if they were usable, but for completeness:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; The ioctl ret=
urns:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0 pcie_gen =3D 1<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =
=C2=A0 pcie_num_lanes =3D 16<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Theoretical b=
andwidth from those values: 4.0 GB/s<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; My DMA test s=
hows this write bandwidth: 3.5 GB/s<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; It matches th=
e expectation.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Let&#39;s see=
 the devices (there is only 1 GPU Navi21 in the system):<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ lspci |egre=
p &#39;(PCI|VGA).*Navi&#39;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 0a:00.0 PCI b=
ridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 10 XL<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Upstream Port=
 of PCI Express Switch (rev c3)<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 0b:00.0 PCI b=
ridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 10 XL<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Downstream Po=
rt of PCI Express Switch<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 0c:00.0 VGA c=
ompatible controller: Advanced Micro Devices, Inc.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; [AMD/ATI] Nav=
i 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Let&#39;s rea=
d sysfs:<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0a:00.0/current_link_width<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 16<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0b:00.0/current_link_width<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 16<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0c:00.0/current_link_width<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 16<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0a:00.0/current_link_speed<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 2.5 GT/s PCIe=
<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0b:00.0/current_link_speed<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 16.0 GT/s PCI=
e<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; $ cat /sys/bu=
s/pci/devices/0000:0c:00.0/current_link_speed<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 16.0 GT/s PCI=
e<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Problem 1: No=
ne of the speed numbers match 4 GB/s.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 US bridge =3D 2.5GT/s me=
ans operating at PCIe Gen 1 speed. Total<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 theoretical bandwidth is=
 then derived based on encoding and total<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 number<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 of lanes.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Problem 2: Us=
erspace doesn&#39;t know the bus index of the bridges,<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 and it&#39;s<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; not clear whi=
ch bridge should be used.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 In general, modern ones =
have this arch=3D US-&gt;DS-&gt;EP. US is the one<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 connected to physical li=
nk.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Problem 3: Th=
e PCIe gen number is missing.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Current link speed is ba=
sed on whether it&#39;s Gen1/2/3/4/5.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 BTW, your patch makes us=
e of capabilities flags which gives the maximum<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 supported speed/width by=
 the device. It may not necessarily reflect the<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 current speed/width nego=
tiated. I guess in NV, this info is already<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 obtained from PMFW and m=
ade available through metrics table.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; It computes the minimum of the device PCIe g=
en and the motherboard/slot<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; PCIe gen to get the final value. These 2 lin=
es do that. The low 16 bits<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; of the mask contain the device PCIe gen mask=
. The high 16 bits of the<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; mask contain the slot PCIe gen mask.<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; + pcie_gen_mask =3D adev-&gt;pm.pcie_gen_mas=
k &amp; (adev-&gt;pm.pcie_gen_mask &gt;&gt; 16);<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt; + dev_info-&gt;pcie_gen =3D fls(pcie_gen_mas=
k);<br>
&gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; With DPM in place on some ASICs, how much does t=
his static info help for<br>
&gt;&gt; &gt; &gt;&gt;&gt; upper level apps?<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; It helps UMDs make better decisions if they know=
 the maximum achievable bandwidth. UMDs also compute the maximum memory ban=
dwidth and compute performance (FLOPS). Right now it&#39;s printed by Mesa =
to give users detailed information about their GPU. For example:<br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; $ AMD_DEBUG=3Dinfo glxgears<br>
&gt;&gt; &gt; &gt;&gt;&gt; Device info:<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 name =3D NAVI21<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 marketing_name =3D AMD Radeo=
n RX 6800<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 num_se =3D 3<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 num_rb =3D 12<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 num_cu =3D 60<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 max_gpu_freq =3D 2475 MHz<br=
>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 max_gflops =3D 19008 GFLOPS<=
br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 l0_cache_size =3D 16 KB<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 l1_cache_size =3D 128 KB<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 l2_cache_size =3D 4096 KB<br=
>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 l3_cache_size =3D 128 MB<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 memory_channels =3D 16 (TCC =
blocks)<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 memory_size =3D 16 GB (16384=
 MB)<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 memory_freq =3D 16 GHz<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 memory_bus_width =3D 256 bit=
s<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 memory_bandwidth =3D 512 GB/=
s<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pcie_gen =3D 1<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pcie_num_lanes =3D 16<br>
&gt;&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pcie_bandwidth =3D 4.0 GB/s<=
br>
&gt;&gt; &gt; &gt;&gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt;&gt; Marek<br>
&gt;&gt; &gt;<br>
</blockquote></div></div>
</blockquote></div>

--000000000000ed441305f22dbc92--
