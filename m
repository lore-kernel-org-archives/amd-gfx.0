Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6783C5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 20:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5D210E817;
	Wed, 11 Jan 2023 20:48:43 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDC110E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 20:48:40 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id d188so2597621oia.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWlF7xAf/9pA+TzInx8/l50JMwoXmTz5VpPA5Eyv3uo=;
 b=CSaVGpLW89Oblo7QJj40V9Y4WkR4rxCK5Fu032R15sIBI0h77WaaGw+Sbo3B4G82HY
 as7f3h85hsuQXcmIKFEJ8GZsiV2YQEzG0QSE/EWBk78bUfZ1SKACxyoEd7EKGqd5ZtyY
 CM/Cn61Efh0V+05z+x48ZykPR6ZKW38qGVF0Ub9A5IRsr//AaJPOltS7UuVDZBb10HxY
 a/NE71PcsXzptmUAC1Xoqqgu77u5UB39UpudO4GniUDFDnBJxSUVayQzyKJCWd06qYjl
 e6TChkWDZJetFJBokJoM4Bx8VfKnAEDFanB3fUC+gYi5JnietBsv/CMyiVG72SFiYF+A
 CjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWlF7xAf/9pA+TzInx8/l50JMwoXmTz5VpPA5Eyv3uo=;
 b=8ODWZq57r0rDivAn3NMFXql8c81cWgBCurFac7l8rR4IWInR7GkQK6lzgCUL9f2QHp
 /++EMh6hz8H8BfgjWzycLhTFPvsQ5CGeHROOT6taPkLAfUAMYcML4V3NgGMF81Url/KL
 dAKDS9Kr7VTQwB7sU/nVAvLNAyMBBCNZ/wqYghgWZQ8g3YlxussD0fXZPXUXOY1gWbb7
 nncw11yo1tqvIPhfPlpl5KfJIktdeAgrHDADmnz5v+qUVpt/Wr+T9zSgqckjbLius95R
 ihMJHOpujWr0zz4LaEBan98J2WRUuSLzUTofF6wXJeY0tn+Pv5WJyGiVxv44RfxCoiuj
 181g==
X-Gm-Message-State: AFqh2kpcW230EVi+mHXf2rJyQMPkV4Q1hTQr2iw9XEMe7dpbFmMfVjTu
 Pb4QYypyke1yr3op1LcVgRfH0XCbwTm+trLjMdk=
X-Google-Smtp-Source: AMrXdXtcZyUK1k6xUNYeIJj4X4+Yk2ZZ9mrTzkZIgPuKUzoqOCKR3ehZweryZ8vN+7uriFJnX0wdTralsLowi58TTPs=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr4872598oiw.96.1673470119597; Wed, 11 Jan
 2023 12:48:39 -0800 (PST)
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
In-Reply-To: <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Jan 2023 15:48:27 -0500
Message-ID: <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wro=
te:
>
> Yes, it's meant to be like a spec sheet. We are not interested in the cur=
rent bandwidth utilization.

After chatting with Marek on IRC and thinking about this more, I think
this patch is fine.  It's not really meant for bandwidth per se, but
rather as a limit to determine what the driver should do in certain
cases (i.e., when does it make sense to copy to vram vs not).  It's
not straightforward for userspace to parse the full topology to
determine what links may be slow.  I guess one potential pitfall would
be that if you pass the device into a VM, the driver may report the
wrong values.  Generally in a VM the VM doesn't get the full view up
to the root port.  I don't know if the hypervisors report properly for
pcie_bandwidth_available() in a VM or if it just shows the info about
the endpoint in the VM.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Marek
>
> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>
>> [AMD Official Use Only - General]
>>
>>
>> To clarify, with DPM in place, the current bandwidth will be changing ba=
sed on the load.
>>
>> If apps/umd already has a way to know the current bandwidth utilisation,=
 then possible maximum also could be part of the same API. Otherwise, this =
only looks like duplicate information. We have the same information in sysf=
s DPM nodes.
>>
>> BTW, I don't know to what extent app/umd really makes use of this. Take =
that memory frequency as an example (I'm reading it as 16GHz). It only look=
s like a spec sheet.
>>
>> Thanks,
>> Lijo
>> ________________________________
>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from =
the INFO
>>
>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
>> > On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
>> > <mailto:lijo.lazar@amd.com>> wrote:
>> >
>> >
>> >
>> >     On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
>> >      > I see. Well, those sysfs files are not usable, and I don't thin=
k it
>> >      > would be important even if they were usable, but for completene=
ss:
>> >      >
>> >      > The ioctl returns:
>> >      >      pcie_gen =3D 1
>> >      >      pcie_num_lanes =3D 16
>> >      >
>> >      > Theoretical bandwidth from those values: 4.0 GB/s
>> >      > My DMA test shows this write bandwidth: 3.5 GB/s
>> >      > It matches the expectation.
>> >      >
>> >      > Let's see the devices (there is only 1 GPU Navi21 in the system=
):
>> >      > $ lspci |egrep '(PCI|VGA).*Navi'
>> >      > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>> >     10 XL
>> >      > Upstream Port of PCI Express Switch (rev c3)
>> >      > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>> >     10 XL
>> >      > Downstream Port of PCI Express Switch
>> >      > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>> >      > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
>> >      >
>> >      > Let's read sysfs:
>> >      >
>> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>> >      > 16
>> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>> >      > 16
>> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>> >      > 16
>> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>> >      > 2.5 GT/s PCIe
>> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>> >      > 16.0 GT/s PCIe
>> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>> >      > 16.0 GT/s PCIe
>> >      >
>> >      > Problem 1: None of the speed numbers match 4 GB/s.
>> >
>> >     US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total
>> >     theoretical bandwidth is then derived based on encoding and total
>> >     number
>> >     of lanes.
>> >
>> >      > Problem 2: Userspace doesn't know the bus index of the bridges,
>> >     and it's
>> >      > not clear which bridge should be used.
>> >
>> >     In general, modern ones have this arch=3D US->DS->EP. US is the on=
e
>> >     connected to physical link.
>> >
>> >      > Problem 3: The PCIe gen number is missing.
>> >
>> >     Current link speed is based on whether it's Gen1/2/3/4/5.
>> >
>> >     BTW, your patch makes use of capabilities flags which gives the ma=
ximum
>> >     supported speed/width by the device. It may not necessarily reflec=
t the
>> >     current speed/width negotiated. I guess in NV, this info is alread=
y
>> >     obtained from PMFW and made available through metrics table.
>> >
>> >
>> > It computes the minimum of the device PCIe gen and the motherboard/slo=
t
>> > PCIe gen to get the final value. These 2 lines do that. The low 16 bit=
s
>> > of the mask contain the device PCIe gen mask. The high 16 bits of the
>> > mask contain the slot PCIe gen mask.
>> > + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >=
> 16);
>> > + dev_info->pcie_gen =3D fls(pcie_gen_mask);
>> >
>>
>> With DPM in place on some ASICs, how much does this static info help for
>> upper level apps?
>>
>>
>> It helps UMDs make better decisions if they know the maximum achievable =
bandwidth. UMDs also compute the maximum memory bandwidth and compute perfo=
rmance (FLOPS). Right now it's printed by Mesa to give users detailed infor=
mation about their GPU. For example:
>>
>> $ AMD_DEBUG=3Dinfo glxgears
>> Device info:
>>     name =3D NAVI21
>>     marketing_name =3D AMD Radeon RX 6800
>>     num_se =3D 3
>>     num_rb =3D 12
>>     num_cu =3D 60
>>     max_gpu_freq =3D 2475 MHz
>>     max_gflops =3D 19008 GFLOPS
>>     l0_cache_size =3D 16 KB
>>     l1_cache_size =3D 128 KB
>>     l2_cache_size =3D 4096 KB
>>     l3_cache_size =3D 128 MB
>>     memory_channels =3D 16 (TCC blocks)
>>     memory_size =3D 16 GB (16384 MB)
>>     memory_freq =3D 16 GHz
>>     memory_bus_width =3D 256 bits
>>     memory_bandwidth =3D 512 GB/s
>>     pcie_gen =3D 1
>>     pcie_num_lanes =3D 16
>>     pcie_bandwidth =3D 4.0 GB/s
>>
>> Marek
