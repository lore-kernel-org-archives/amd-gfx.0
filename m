Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052B7C3DA78
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 21:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B40510EAFA;
	Fri, 13 Jan 2023 21:20:27 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7222810EAFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 21:20:24 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id s124so1876447oif.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwqhjddFHDnqXHu9x2FK4WzzMTps3P1xEbANhIqM7EE=;
 b=lysh7Qp43YdpcZ9SbKeaKDOLNMjeXQqC7aJnk0siJIvQusSR7uVivWUhpoLyXGKT7t
 6IrQHSd/JuRj6f3ob1kURa9Lb/ecn+xb43DMMze79FJpI9c30JcoKNHlzeDlht4wz5dz
 9eMFlClvo11Nh28Oj4QMlJlKRnjO70s8luvf//XgjsEF29xAn3Dx7TiRnE5YdLj4SYD9
 6svYHgxwgbu4/4Mc4JE9+VmPDnsatppYsX/NG4t6cN+dv0wHRYPafe8luM4IgnJPjV8U
 cPMYBYMQ5yz+GOL9TNSlgj/iIwptJ16Ih4v8nnptP3WDhWNTLikdjUXA+jmdVDS4+1vS
 xW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwqhjddFHDnqXHu9x2FK4WzzMTps3P1xEbANhIqM7EE=;
 b=rOdBXVUrfXGc4rO6KVxgKsL+F2pwilzUV6m9JkoLaF01Sr66RyYsDsh9a2VDxAKdLJ
 6bW4XLqWQbagfGHsmzJAMjEETCMvBMRyogBPRs2zdMJsFvUbmI1UBqk88X3RorBZ4WhD
 x47nBH97ZYeHoHQVOH2awG0nEF1sLHalPrm7gZx694yDNeS9WgJhR8N4bbWDoOMpMreq
 KmBap3LVQRYRxMp11YoIRqWs0pH+NsvaYj4G9Zl0uBhIo2ltBbDiQEXEPvAEM0CKCIIT
 JZ8Zp7g0nKWfLfaIM4ZL6ZSeSbDKuecjx5qvyurYFqmP+9470EIuCLivfX5dkge5p6XS
 s47A==
X-Gm-Message-State: AFqh2kqJvO7WCvJDv3sKhaGnuqjeD8zqvNO8zI84tiZhaZdRsqT8BtrJ
 WSPMAdVAcGcoF5Az2mbhCYPvS5fDDdxY6/YIkNQ=
X-Google-Smtp-Source: AMrXdXu0GAj6Q0Bn4ZwsouBQqeZI6ahc5wGXvN/v/YOVyYSZ9ob2QAwKgZeBz59LEXlTBrp/Mp2wFbQ7BNLyWSC9zWM=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr5568026oib.46.1673644823633; Fri, 13
 Jan 2023 13:20:23 -0800 (PST)
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
In-Reply-To: <CAAxE2A7QvaE3triTt6vAYuWmkaG6DRZsdkQrLJcpDXj96-GO9w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 16:20:11 -0500
Message-ID: <CADnq5_Pr+8vdtEtn4K5kd-ssbvsGAf2_wnsqAkMpLJUPW+55_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 4:02 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:
>
> i've added the comments and indeed pahole shows the hole as expected.

What about on 32-bit?

Alex

>
> Marek
>
> On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher <alexdeucher@gmail.com> wro=
te:
>>
>> On Thu, Jan 12, 2023 at 6:50 AM Christian K=C3=B6nig
>> <christian.koenig@amd.com> wrote:
>> >
>> > Am 11.01.23 um 21:48 schrieb Alex Deucher:
>> > > On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.c=
om> wrote:
>> > >> Yes, it's meant to be like a spec sheet. We are not interested in t=
he current bandwidth utilization.
>> > > After chatting with Marek on IRC and thinking about this more, I thi=
nk
>> > > this patch is fine.  It's not really meant for bandwidth per se, but
>> > > rather as a limit to determine what the driver should do in certain
>> > > cases (i.e., when does it make sense to copy to vram vs not).  It's
>> > > not straightforward for userspace to parse the full topology to
>> > > determine what links may be slow.  I guess one potential pitfall wou=
ld
>> > > be that if you pass the device into a VM, the driver may report the
>> > > wrong values.  Generally in a VM the VM doesn't get the full view up
>> > > to the root port.  I don't know if the hypervisors report properly f=
or
>> > > pcie_bandwidth_available() in a VM or if it just shows the info abou=
t
>> > > the endpoint in the VM.
>> >
>> > So this basically doesn't return the gen and lanes of the device, but
>> > rather what was negotiated between the device and the upstream root po=
rt?
>>
>> Correct. It exposes the max gen and lanes of the slowest link between
>> the device and the root port.
>>
>> >
>> > If I got that correctly then we should probably document that cause
>> > otherwise somebody will try to "fix" it at some time.
>>
>> Good point.
>>
>> Alex
>>
>> >
>> > Christian.
>> >
>> > >
>> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> > >
>> > > Alex
>> > >
>> > >> Marek
>> > >>
>> > >> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com> wr=
ote:
>> > >>> [AMD Official Use Only - General]
>> > >>>
>> > >>>
>> > >>> To clarify, with DPM in place, the current bandwidth will be chang=
ing based on the load.
>> > >>>
>> > >>> If apps/umd already has a way to know the current bandwidth utilis=
ation, then possible maximum also could be part of the same API. Otherwise,=
 this only looks like duplicate information. We have the same information i=
n sysfs DPM nodes.
>> > >>>
>> > >>> BTW, I don't know to what extent app/umd really makes use of this.=
 Take that memory frequency as an example (I'm reading it as 16GHz). It onl=
y looks like a spec sheet.
>> > >>>
>> > >>> Thanks,
>> > >>> Lijo
>> > >>> ________________________________
>> > >>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
>> > >>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>> > >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> > >>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> > >>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes=
 from the INFO
>> > >>>
>> > >>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>> > >>>
>> > >>>
>> > >>>
>> > >>> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
>> > >>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
>> > >>>> <mailto:lijo.lazar@amd.com>> wrote:
>> > >>>>
>> > >>>>
>> > >>>>
>> > >>>>      On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
>> > >>>>       > I see. Well, those sysfs files are not usable, and I don'=
t think it
>> > >>>>       > would be important even if they were usable, but for comp=
leteness:
>> > >>>>       >
>> > >>>>       > The ioctl returns:
>> > >>>>       >      pcie_gen =3D 1
>> > >>>>       >      pcie_num_lanes =3D 16
>> > >>>>       >
>> > >>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>> > >>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>> > >>>>       > It matches the expectation.
>> > >>>>       >
>> > >>>>       > Let's see the devices (there is only 1 GPU Navi21 in the =
system):
>> > >>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>> > >>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI=
] Navi
>> > >>>>      10 XL
>> > >>>>       > Upstream Port of PCI Express Switch (rev c3)
>> > >>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI=
] Navi
>> > >>>>      10 XL
>> > >>>>       > Downstream Port of PCI Express Switch
>> > >>>>       > 0c:00.0 VGA compatible controller: Advanced Micro Devices=
, Inc.
>> > >>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev=
 c3)
>> > >>>>       >
>> > >>>>       > Let's read sysfs:
>> > >>>>       >
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_widt=
h
>> > >>>>       > 16
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_widt=
h
>> > >>>>       > 16
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_widt=
h
>> > >>>>       > 16
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_spee=
d
>> > >>>>       > 2.5 GT/s PCIe
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_spee=
d
>> > >>>>       > 16.0 GT/s PCIe
>> > >>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_spee=
d
>> > >>>>       > 16.0 GT/s PCIe
>> > >>>>       >
>> > >>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>> > >>>>
>> > >>>>      US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. T=
otal
>> > >>>>      theoretical bandwidth is then derived based on encoding and =
total
>> > >>>>      number
>> > >>>>      of lanes.
>> > >>>>
>> > >>>>       > Problem 2: Userspace doesn't know the bus index of the br=
idges,
>> > >>>>      and it's
>> > >>>>       > not clear which bridge should be used.
>> > >>>>
>> > >>>>      In general, modern ones have this arch=3D US->DS->EP. US is =
the one
>> > >>>>      connected to physical link.
>> > >>>>
>> > >>>>       > Problem 3: The PCIe gen number is missing.
>> > >>>>
>> > >>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
>> > >>>>
>> > >>>>      BTW, your patch makes use of capabilities flags which gives =
the maximum
>> > >>>>      supported speed/width by the device. It may not necessarily =
reflect the
>> > >>>>      current speed/width negotiated. I guess in NV, this info is =
already
>> > >>>>      obtained from PMFW and made available through metrics table.
>> > >>>>
>> > >>>>
>> > >>>> It computes the minimum of the device PCIe gen and the motherboar=
d/slot
>> > >>>> PCIe gen to get the final value. These 2 lines do that. The low 1=
6 bits
>> > >>>> of the mask contain the device PCIe gen mask. The high 16 bits of=
 the
>> > >>>> mask contain the slot PCIe gen mask.
>> > >>>> + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_m=
ask >> 16);
>> > >>>> + dev_info->pcie_gen =3D fls(pcie_gen_mask);
>> > >>>>
>> > >>> With DPM in place on some ASICs, how much does this static info he=
lp for
>> > >>> upper level apps?
>> > >>>
>> > >>>
>> > >>> It helps UMDs make better decisions if they know the maximum achie=
vable bandwidth. UMDs also compute the maximum memory bandwidth and compute=
 performance (FLOPS). Right now it's printed by Mesa to give users detailed=
 information about their GPU. For example:
>> > >>>
>> > >>> $ AMD_DEBUG=3Dinfo glxgears
>> > >>> Device info:
>> > >>>      name =3D NAVI21
>> > >>>      marketing_name =3D AMD Radeon RX 6800
>> > >>>      num_se =3D 3
>> > >>>      num_rb =3D 12
>> > >>>      num_cu =3D 60
>> > >>>      max_gpu_freq =3D 2475 MHz
>> > >>>      max_gflops =3D 19008 GFLOPS
>> > >>>      l0_cache_size =3D 16 KB
>> > >>>      l1_cache_size =3D 128 KB
>> > >>>      l2_cache_size =3D 4096 KB
>> > >>>      l3_cache_size =3D 128 MB
>> > >>>      memory_channels =3D 16 (TCC blocks)
>> > >>>      memory_size =3D 16 GB (16384 MB)
>> > >>>      memory_freq =3D 16 GHz
>> > >>>      memory_bus_width =3D 256 bits
>> > >>>      memory_bandwidth =3D 512 GB/s
>> > >>>      pcie_gen =3D 1
>> > >>>      pcie_num_lanes =3D 16
>> > >>>      pcie_bandwidth =3D 4.0 GB/s
>> > >>>
>> > >>> Marek
>> >
