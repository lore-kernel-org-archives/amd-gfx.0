Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00791C3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 19:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F0110E32E;
	Tue, 17 Jan 2023 19:21:55 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9224010E32B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 19:21:52 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id s66so26141539oib.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eIbFR5/bFscUmmrsNHGCKWjFRSxO0rhe2moVV5VA1s=;
 b=UNwDz9YBMrSPQa0iUDkhMm89ewppY68LloJQB64g+euqmtWS56GN+ooyHX0EBOQ3y5
 aEmpsD2uqpln9LE5anqnXwowfTrmhqzxxJQ97pIgEWJBhQDSSlD+EkkImzQKBKaooWFt
 SBJAwNliyd4yyJduk517zD1UIZHMGsQzocX1BP5DM+hCHYXu+iF0LRz4vcueUgfY92+t
 sfBfqmERh9Cj/SCn3qFH/MYVQguqtBf5FfdjqIXaur+aJUMCEJjrJ8TP5ykyeI6iBAGh
 QzMwPsZytM3eFuw/Nz/06E/UHTUnUanDG3qf5W8LVXA9DklL5Q7sPNmlLqTaTBDM2VTp
 Qd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eIbFR5/bFscUmmrsNHGCKWjFRSxO0rhe2moVV5VA1s=;
 b=LhW0OlOx83ZjoVDWGsOQZBYXC5owPaCh0iymJ5q5SW997Arhg1bY3p0ZY4vFBrjowJ
 DmxmnQv6caIhRVspDRl4bRhShHsLXidPBhIqKXaEnJilEzQmkKtYgCruw41wbf0l/jUk
 gNbXQ3QNNxNzMFiD3AauLIWK2AIGDCDi6IqOoez23M8drlhnxntZYiprBm3LEneCgeXc
 jrEdwXIUuZH4urJuUXNngZ0XiQb1yBRb4fjtiFt4fIcJ6KfzMlGuRwaM/mqqMuj4Jb+C
 H7Cy/CwMsOWY4+0oTsS8a4VOqHk/tqqIdTJPaNmJ+p49HmOhKXZf2SNBJSJqmpW8NPe1
 LY+w==
X-Gm-Message-State: AFqh2koLy3x+XKthcF+VVmEW10XilU8HliIHAisjtfLEvKxu/5hTRAr8
 YB9KSoyzEE4UVBXcbn0wm21M/npBZaSRCWKymDw4fAbgIaw=
X-Google-Smtp-Source: AMrXdXv7D9e4gZTx+oOC7oPhkKiPfB+G9dVB4i8wOzDmNuu45Tm5mPEZKHDqBMjeKwfjTgt12aqgKLlwO2d+kO3mJsY=
X-Received: by 2002:a05:6808:4387:b0:35b:d93f:cbc4 with SMTP id
 dz7-20020a056808438700b0035bd93fcbc4mr254888oib.96.1673983311752; Tue, 17 Jan
 2023 11:21:51 -0800 (PST)
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
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jan 2023 14:21:40 -0500
Message-ID: <CADnq5_OLWnJMRT8vZTRh_Kq9KW6z9BPahq7L=rbyqLELp9LY7Q@mail.gmail.com>
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

Looks good to me.  It might be good to add a comment above pcie_gen in
amdgpu_drm.h to specify that this is the max common pcie gen supported
by both the GPU and the slot.  With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Jan 13, 2023 at 6:33 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:
>
> There is no hole on 32-bit unfortunately. It looks like the hole on 64-bi=
t is now ABI.
>
> I moved the field to replace _pad1. The patch is attached (with your Rb).
>
> Marek
>
> On Fri, Jan 13, 2023 at 4:20 PM Alex Deucher <alexdeucher@gmail.com> wrot=
e:
>>
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
>> > On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher <alexdeucher@gmail.com> =
wrote:
>> >>
>> >> On Thu, Jan 12, 2023 at 6:50 AM Christian K=C3=B6nig
>> >> <christian.koenig@amd.com> wrote:
>> >> >
>> >> > Am 11.01.23 um 21:48 schrieb Alex Deucher:
>> >> > > On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>> >> > >> Yes, it's meant to be like a spec sheet. We are not interested i=
n the current bandwidth utilization.
>> >> > > After chatting with Marek on IRC and thinking about this more, I =
think
>> >> > > this patch is fine.  It's not really meant for bandwidth per se, =
but
>> >> > > rather as a limit to determine what the driver should do in certa=
in
>> >> > > cases (i.e., when does it make sense to copy to vram vs not).  It=
's
>> >> > > not straightforward for userspace to parse the full topology to
>> >> > > determine what links may be slow.  I guess one potential pitfall =
would
>> >> > > be that if you pass the device into a VM, the driver may report t=
he
>> >> > > wrong values.  Generally in a VM the VM doesn't get the full view=
 up
>> >> > > to the root port.  I don't know if the hypervisors report properl=
y for
>> >> > > pcie_bandwidth_available() in a VM or if it just shows the info a=
bout
>> >> > > the endpoint in the VM.
>> >> >
>> >> > So this basically doesn't return the gen and lanes of the device, b=
ut
>> >> > rather what was negotiated between the device and the upstream root=
 port?
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
>> >> > >> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com>=
 wrote:
>> >> > >>> [AMD Official Use Only - General]
>> >> > >>>
>> >> > >>>
>> >> > >>> To clarify, with DPM in place, the current bandwidth will be ch=
anging based on the load.
>> >> > >>>
>> >> > >>> If apps/umd already has a way to know the current bandwidth uti=
lisation, then possible maximum also could be part of the same API. Otherwi=
se, this only looks like duplicate information. We have the same informatio=
n in sysfs DPM nodes.
>> >> > >>>
>> >> > >>> BTW, I don't know to what extent app/umd really makes use of th=
is. Take that memory frequency as an example (I'm reading it as 16GHz). It =
only looks like a spec sheet.
>> >> > >>>
>> >> > >>> Thanks,
>> >> > >>> Lijo
>> >> > >>> ________________________________
>> >> > >>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
>> >> > >>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>> >> > >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> >> > >>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.or=
g>
>> >> > >>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and la=
nes from the INFO
>> >> > >>>
>> >> > >>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com>=
 wrote:
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
>> >> > >>>>       > I see. Well, those sysfs files are not usable, and I d=
on't think it
>> >> > >>>>       > would be important even if they were usable, but for c=
ompleteness:
>> >> > >>>>       >
>> >> > >>>>       > The ioctl returns:
>> >> > >>>>       >      pcie_gen =3D 1
>> >> > >>>>       >      pcie_num_lanes =3D 16
>> >> > >>>>       >
>> >> > >>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>> >> > >>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>> >> > >>>>       > It matches the expectation.
>> >> > >>>>       >
>> >> > >>>>       > Let's see the devices (there is only 1 GPU Navi21 in t=
he system):
>> >> > >>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>> >> > >>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/=
ATI] Navi
>> >> > >>>>      10 XL
>> >> > >>>>       > Upstream Port of PCI Express Switch (rev c3)
>> >> > >>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/=
ATI] Navi
>> >> > >>>>      10 XL
>> >> > >>>>       > Downstream Port of PCI Express Switch
>> >> > >>>>       > 0c:00.0 VGA compatible controller: Advanced Micro Devi=
ces, Inc.
>> >> > >>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (=
rev c3)
>> >> > >>>>       >
>> >> > >>>>       > Let's read sysfs:
>> >> > >>>>       >
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_w=
idth
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_w=
idth
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_w=
idth
>> >> > >>>>       > 16
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_s=
peed
>> >> > >>>>       > 2.5 GT/s PCIe
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_s=
peed
>> >> > >>>>       > 16.0 GT/s PCIe
>> >> > >>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_s=
peed
>> >> > >>>>       > 16.0 GT/s PCIe
>> >> > >>>>       >
>> >> > >>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>> >> > >>>>
>> >> > >>>>      US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed=
. Total
>> >> > >>>>      theoretical bandwidth is then derived based on encoding a=
nd total
>> >> > >>>>      number
>> >> > >>>>      of lanes.
>> >> > >>>>
>> >> > >>>>       > Problem 2: Userspace doesn't know the bus index of the=
 bridges,
>> >> > >>>>      and it's
>> >> > >>>>       > not clear which bridge should be used.
>> >> > >>>>
>> >> > >>>>      In general, modern ones have this arch=3D US->DS->EP. US =
is the one
>> >> > >>>>      connected to physical link.
>> >> > >>>>
>> >> > >>>>       > Problem 3: The PCIe gen number is missing.
>> >> > >>>>
>> >> > >>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
>> >> > >>>>
>> >> > >>>>      BTW, your patch makes use of capabilities flags which giv=
es the maximum
>> >> > >>>>      supported speed/width by the device. It may not necessari=
ly reflect the
>> >> > >>>>      current speed/width negotiated. I guess in NV, this info =
is already
>> >> > >>>>      obtained from PMFW and made available through metrics tab=
le.
>> >> > >>>>
>> >> > >>>>
>> >> > >>>> It computes the minimum of the device PCIe gen and the motherb=
oard/slot
>> >> > >>>> PCIe gen to get the final value. These 2 lines do that. The lo=
w 16 bits
>> >> > >>>> of the mask contain the device PCIe gen mask. The high 16 bits=
 of the
>> >> > >>>> mask contain the slot PCIe gen mask.
>> >> > >>>> + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_ge=
n_mask >> 16);
>> >> > >>>> + dev_info->pcie_gen =3D fls(pcie_gen_mask);
>> >> > >>>>
>> >> > >>> With DPM in place on some ASICs, how much does this static info=
 help for
>> >> > >>> upper level apps?
>> >> > >>>
>> >> > >>>
>> >> > >>> It helps UMDs make better decisions if they know the maximum ac=
hievable bandwidth. UMDs also compute the maximum memory bandwidth and comp=
ute performance (FLOPS). Right now it's printed by Mesa to give users detai=
led information about their GPU. For example:
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
