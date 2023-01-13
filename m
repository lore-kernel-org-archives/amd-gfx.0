Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236AEC3DA78
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 23:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7935410E217;
	Fri, 13 Jan 2023 23:33:40 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741BC10E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 23:33:38 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id i9so33312263edj.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBiBRAwaKsyW4TmjOf9V0LWWiKtYvjGJ4+dbQicsZTo=;
 b=HOidORvVvJL5iuCBNoVf4wKNwcpHE5Q3Id246u0/eiIdEtT/KKSxYK1MqSHmOVjVX6
 KH5o2p/7orMv9VYB4+6DGExLPwwr6Xvi+LmdO1ibCHWzl0KVrKgVu8MPyO/OIZuIvnNg
 psthibTPe+7VKlgAd+ycmZf1lRue9pVmaRM8iw4IWDg2jfI+lHqk/YWyJIRmwpvnpw7X
 P0hgWR9ubV3KSqOIc/vh75swSIKmjZYeLzYACVQDGjEdKWHDTuxmer6CLJPMJEi3IHEF
 TZkpaCBjl3c70YQ0c9v4zeuKkfbkMbXwTsJd1HyiMfzONS6awDnuS2NrYlcZxj3F5857
 HWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBiBRAwaKsyW4TmjOf9V0LWWiKtYvjGJ4+dbQicsZTo=;
 b=EXN1vS6mrzjrgwBm7hqzowCn5vu3BfucMjS1f/OEs1+xZubwlHprEg6sZwXNPZCuzs
 YNIfiL8PJtqcxLocaGI9DMpJtyN0A6g1rh0E1t5APZbdGpgKZfa05cmMbbCD/COFtwRV
 p463YiVaRaBMTKzXdJ9Usbfi8HsV7rc8Nftu6krRY1oM4v3qk+URtoX1IJxGFfGV+ad8
 sn+i5AlerYEPlEx6gf2phCXxJEizBPoZtQmzD6j+WpAIyTm5K9Qas0CnlEKEcbt/FVwN
 KIiRIBIf3UR2G9fCi9uwUqsTt9T7c2O4sxp5m5HyrO6Dzgu0c5sPbHvJ9kwnN8eQb10F
 Hsfw==
X-Gm-Message-State: AFqh2kq/D+K6yZAbliOtTIWP/NZ8AX5XQodg7oLfVP7/saoAPv44W3jH
 XusKYJ+mMKSyxOH+kHXExd23UP6HdpA1WAzSBK8=
X-Google-Smtp-Source: AMrXdXtZ26vOMdEAl3SbmxkuJzWcamFj64aZMuXsU/4E4TTpMK2kUVwvhFuqYAUXxsb2tZa+3XEL7HlUEryMZ+jKcq4=
X-Received: by 2002:aa7:cd89:0:b0:497:b04c:f270 with SMTP id
 x9-20020aa7cd89000000b00497b04cf270mr3322837edv.344.1673652816741; Fri, 13
 Jan 2023 15:33:36 -0800 (PST)
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
In-Reply-To: <CADnq5_Pr+8vdtEtn4K5kd-ssbvsGAf2_wnsqAkMpLJUPW+55_g@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 13 Jan 2023 18:33:00 -0500
Message-ID: <CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009ec8e005f22da9d1"
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

--0000000000009ec8e005f22da9d1
Content-Type: multipart/alternative; boundary="0000000000009ec8dd05f22da9cf"

--0000000000009ec8dd05f22da9cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no hole on 32-bit unfortunately. It looks like the hole on 64-bit
is now ABI.

I moved the field to replace _pad1. The patch is attached (with your Rb).

Marek

On Fri, Jan 13, 2023 at 4:20 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Jan 13, 2023 at 4:02 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> =
wrote:
> >
> > i've added the comments and indeed pahole shows the hole as expected.
>
> What about on 32-bit?
>
> Alex
>
> >
> > Marek
> >
> > On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >>
> >> On Thu, Jan 12, 2023 at 6:50 AM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >> >
> >> > Am 11.01.23 um 21:48 schrieb Alex Deucher:
> >> > > On Wed, Jan 4, 2023 at 3:17 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com>
> wrote:
> >> > >> Yes, it's meant to be like a spec sheet. We are not interested in
> the current bandwidth utilization.
> >> > > After chatting with Marek on IRC and thinking about this more, I
> think
> >> > > this patch is fine.  It's not really meant for bandwidth per se, b=
ut
> >> > > rather as a limit to determine what the driver should do in certai=
n
> >> > > cases (i.e., when does it make sense to copy to vram vs not).  It'=
s
> >> > > not straightforward for userspace to parse the full topology to
> >> > > determine what links may be slow.  I guess one potential pitfall
> would
> >> > > be that if you pass the device into a VM, the driver may report th=
e
> >> > > wrong values.  Generally in a VM the VM doesn't get the full view =
up
> >> > > to the root port.  I don't know if the hypervisors report properly
> for
> >> > > pcie_bandwidth_available() in a VM or if it just shows the info
> about
> >> > > the endpoint in the VM.
> >> >
> >> > So this basically doesn't return the gen and lanes of the device, bu=
t
> >> > rather what was negotiated between the device and the upstream root
> port?
> >>
> >> Correct. It exposes the max gen and lanes of the slowest link between
> >> the device and the root port.
> >>
> >> >
> >> > If I got that correctly then we should probably document that cause
> >> > otherwise somebody will try to "fix" it at some time.
> >>
> >> Good point.
> >>
> >> Alex
> >>
> >> >
> >> > Christian.
> >> >
> >> > >
> >> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >> > >
> >> > > Alex
> >> > >
> >> > >> Marek
> >> > >>
> >> > >> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com>
> wrote:
> >> > >>> [AMD Official Use Only - General]
> >> > >>>
> >> > >>>
> >> > >>> To clarify, with DPM in place, the current bandwidth will be
> changing based on the load.
> >> > >>>
> >> > >>> If apps/umd already has a way to know the current bandwidth
> utilisation, then possible maximum also could be part of the same API.
> Otherwise, this only looks like duplicate information. We have the same
> information in sysfs DPM nodes.
> >> > >>>
> >> > >>> BTW, I don't know to what extent app/umd really makes use of
> this. Take that memory frequency as an example (I'm reading it as 16GHz).
> It only looks like a spec sheet.
> >> > >>>
> >> > >>> Thanks,
> >> > >>> Lijo
> >> > >>> ________________________________
> >> > >>> From: Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
> >> > >>> Sent: Wednesday, January 4, 2023 8:40:00 PM
> >> > >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> > >>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org=
>
> >> > >>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and
> lanes from the INFO
> >> > >>>
> >> > >>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com>
> wrote:
> >> > >>>
> >> > >>>
> >> > >>>
> >> > >>> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
> >> > >>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
> >> > >>>> <mailto:lijo.lazar@amd.com>> wrote:
> >> > >>>>
> >> > >>>>
> >> > >>>>
> >> > >>>>      On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
> >> > >>>>       > I see. Well, those sysfs files are not usable, and I
> don't think it
> >> > >>>>       > would be important even if they were usable, but for
> completeness:
> >> > >>>>       >
> >> > >>>>       > The ioctl returns:
> >> > >>>>       >      pcie_gen =3D 1
> >> > >>>>       >      pcie_num_lanes =3D 16
> >> > >>>>       >
> >> > >>>>       > Theoretical bandwidth from those values: 4.0 GB/s
> >> > >>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
> >> > >>>>       > It matches the expectation.
> >> > >>>>       >
> >> > >>>>       > Let's see the devices (there is only 1 GPU Navi21 in th=
e
> system):
> >> > >>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
> >> > >>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc.
> [AMD/ATI] Navi
> >> > >>>>      10 XL
> >> > >>>>       > Upstream Port of PCI Express Switch (rev c3)
> >> > >>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc.
> [AMD/ATI] Navi
> >> > >>>>      10 XL
> >> > >>>>       > Downstream Port of PCI Express Switch
> >> > >>>>       > 0c:00.0 VGA compatible controller: Advanced Micro
> Devices, Inc.
> >> > >>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT]
> (rev c3)
> >> > >>>>       >
> >> > >>>>       > Let's read sysfs:
> >> > >>>>       >
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> >> > >>>>       > 16
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> >> > >>>>       > 16
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> >> > >>>>       > 16
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> >> > >>>>       > 2.5 GT/s PCIe
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> >> > >>>>       > 16.0 GT/s PCIe
> >> > >>>>       > $ cat
> /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> >> > >>>>       > 16.0 GT/s PCIe
> >> > >>>>       >
> >> > >>>>       > Problem 1: None of the speed numbers match 4 GB/s.
> >> > >>>>
> >> > >>>>      US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed.
> Total
> >> > >>>>      theoretical bandwidth is then derived based on encoding an=
d
> total
> >> > >>>>      number
> >> > >>>>      of lanes.
> >> > >>>>
> >> > >>>>       > Problem 2: Userspace doesn't know the bus index of the
> bridges,
> >> > >>>>      and it's
> >> > >>>>       > not clear which bridge should be used.
> >> > >>>>
> >> > >>>>      In general, modern ones have this arch=3D US->DS->EP. US i=
s
> the one
> >> > >>>>      connected to physical link.
> >> > >>>>
> >> > >>>>       > Problem 3: The PCIe gen number is missing.
> >> > >>>>
> >> > >>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
> >> > >>>>
> >> > >>>>      BTW, your patch makes use of capabilities flags which give=
s
> the maximum
> >> > >>>>      supported speed/width by the device. It may not necessaril=
y
> reflect the
> >> > >>>>      current speed/width negotiated. I guess in NV, this info i=
s
> already
> >> > >>>>      obtained from PMFW and made available through metrics tabl=
e.
> >> > >>>>
> >> > >>>>
> >> > >>>> It computes the minimum of the device PCIe gen and the
> motherboard/slot
> >> > >>>> PCIe gen to get the final value. These 2 lines do that. The low
> 16 bits
> >> > >>>> of the mask contain the device PCIe gen mask. The high 16 bits
> of the
> >> > >>>> mask contain the slot PCIe gen mask.
> >> > >>>> + pcie_gen_mask =3D adev->pm.pcie_gen_mask &
> (adev->pm.pcie_gen_mask >> 16);
> >> > >>>> + dev_info->pcie_gen =3D fls(pcie_gen_mask);
> >> > >>>>
> >> > >>> With DPM in place on some ASICs, how much does this static info
> help for
> >> > >>> upper level apps?
> >> > >>>
> >> > >>>
> >> > >>> It helps UMDs make better decisions if they know the maximum
> achievable bandwidth. UMDs also compute the maximum memory bandwidth and
> compute performance (FLOPS). Right now it's printed by Mesa to give users
> detailed information about their GPU. For example:
> >> > >>>
> >> > >>> $ AMD_DEBUG=3Dinfo glxgears
> >> > >>> Device info:
> >> > >>>      name =3D NAVI21
> >> > >>>      marketing_name =3D AMD Radeon RX 6800
> >> > >>>      num_se =3D 3
> >> > >>>      num_rb =3D 12
> >> > >>>      num_cu =3D 60
> >> > >>>      max_gpu_freq =3D 2475 MHz
> >> > >>>      max_gflops =3D 19008 GFLOPS
> >> > >>>      l0_cache_size =3D 16 KB
> >> > >>>      l1_cache_size =3D 128 KB
> >> > >>>      l2_cache_size =3D 4096 KB
> >> > >>>      l3_cache_size =3D 128 MB
> >> > >>>      memory_channels =3D 16 (TCC blocks)
> >> > >>>      memory_size =3D 16 GB (16384 MB)
> >> > >>>      memory_freq =3D 16 GHz
> >> > >>>      memory_bus_width =3D 256 bits
> >> > >>>      memory_bandwidth =3D 512 GB/s
> >> > >>>      pcie_gen =3D 1
> >> > >>>      pcie_num_lanes =3D 16
> >> > >>>      pcie_bandwidth =3D 4.0 GB/s
> >> > >>>
> >> > >>> Marek
> >> >
>

--0000000000009ec8dd05f22da9cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>There is no hole on 32-bit unfortunately. It looks li=
ke the hole on 64-bit is now ABI.</div><div><br></div><div>I moved the fiel=
d to replace _pad1. The patch is attached (with your Rb).</div><div><br></d=
iv><div>Marek</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">On Fri, Jan =
13, 2023 at 4:20 PM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.co=
m">alexdeucher@gmail.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jan 13, 2023 at =
4:02 PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" targe=
t=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>
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

--0000000000009ec8dd05f22da9cf--

--0000000000009ec8e005f22da9d1
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-return-the-PCIe-gen-and-lanes-from-the-IN.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-return-the-PCIe-gen-and-lanes-from-the-IN.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lcv5ls9q0>
X-Attachment-Id: f_lcv5ls9q0

RnJvbSA2MjIwMzk1ZmIwYjljMTBjOTJlYTY3YjgwZTA5MTIwZTZmOTJhNDk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogU2F0LCAyNCBEZWMgMjAyMiAxNzo0NDoyNiAtMDUw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHJldHVybiB0aGUgUENJZSBnZW4gYW5kIGxh
bmVzIGZyb20gdGhlIElORk8gaW9jdGwKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQK
CkZvciBjb21wdXRpbmcgUENJZSBiYW5kd2lkdGggaW4gdXNlcnNwYWNlIGFuZCB0cm91Ymxlc2hv
b3RpbmcgUENJZQpiYW5kd2lkdGggaXNzdWVzLgoKRm9yIGV4YW1wbGUsIG15IE5hdmkyMSBoYXMg
YmVlbiBsaW1pdGVkIHRvIFBDSWUgZ2VuIDEgYW5kIHRoaXMgaXMKdGhlIGZpcnN0IHRpbWUgSSBu
b3RpY2VkIGl0IGFmdGVyIDIgeWVhcnMuCgpOb3RlIHRoYXQgdGhpcyBpbnRlbnRpb25hbGx5IGZp
bGxzIGEgaG9sZSBhbmQgcGFkZGluZwppbiBkcm1fYW1kZ3B1X2luZm9fZGV2aWNlLgoKU2lnbmVk
LW9mZi1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAgMyArKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDE0ICsrKysrKysrKysrKystCiBpbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAgfCAgNiArKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKaW5kZXggMDZhYmEyMDFkNGRiLi5hNzVkYmEyY2FlY2EgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTEwNiw5ICsxMDYsMTAgQEAKICAq
IC0gMy40OS4wIC0gQWRkIGdhbmcgc3VibWl0IGludG8gQ1MgSU9DVEwKICAqIC0gMy41MC4wIC0g
VXBkYXRlIEFNREdQVV9JTkZPX0RFVl9JTkZPIElPQ1RMIGZvciBtaW5pbXVtIGVuZ2luZSBhbmQg
bWVtb3J5IGNsb2NrCiAgKiAgICAgICAgICAgIFVwZGF0ZSBBTURHUFVfSU5GT19TRU5TT1IgSU9D
VEwgZm9yIFBFQUtfUFNUQVRFIGVuZ2luZSBhbmQgbWVtb3J5IGNsb2NrCisgKiAgIDMuNTEuMCAt
IFJldHVybiB0aGUgUENJZSBnZW4gYW5kIGxhbmVzIGZyb20gdGhlIElORk8gaW9jdGwKICAqLwog
I2RlZmluZSBLTVNfRFJJVkVSX01BSk9SCTMKLSNkZWZpbmUgS01TX0RSSVZFUl9NSU5PUgk1MAor
I2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTUxCiAjZGVmaW5lIEtNU19EUklWRVJfUEFUQ0hMRVZF
TAkwCiAKIHVuc2lnbmVkIGludCBhbWRncHVfdnJhbV9saW1pdCA9IFVJTlRfTUFYOwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmluZGV4IDkwM2U4NzcwZTI3NS4uZmJhMzA2
ZTBlZjg3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21z
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCkBAIC00Miw2
ICs0Miw3IEBACiAjaW5jbHVkZSAiYW1kZ3B1X2dlbS5oIgogI2luY2x1ZGUgImFtZGdwdV9kaXNw
bGF5LmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgorI2luY2x1ZGUgImFtZF9wY2llLmgiCiAK
IHZvaWQgYW1kZ3B1X3VucmVnaXN0ZXJfZ3B1X2luc3RhbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogewpAQCAtNzY2LDYgKzc2Nyw3IEBAIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCiAJ
Y2FzZSBBTURHUFVfSU5GT19ERVZfSU5GTzogewogCQlzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2Rl
dmljZSAqZGV2X2luZm87CiAJCXVpbnQ2NF90IHZtX3NpemU7CisJCXVpbnQzMl90IHBjaWVfZ2Vu
X21hc2s7CiAJCWludCByZXQ7CiAKIAkJZGV2X2luZm8gPSBremFsbG9jKHNpemVvZigqZGV2X2lu
Zm8pLCBHRlBfS0VSTkVMKTsKQEAgLTc5OCw3ICs4MDAsNiBAQCBpbnQgYW1kZ3B1X2luZm9faW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpm
aWxwKQogCQlkZXZfaW5mby0+bnVtX3JiX3BpcGVzID0gYWRldi0+Z2Z4LmNvbmZpZy5tYXhfYmFj
a2VuZHNfcGVyX3NlICoKIAkJCWFkZXYtPmdmeC5jb25maWcubWF4X3NoYWRlcl9lbmdpbmVzOwog
CQlkZXZfaW5mby0+bnVtX2h3X2dmeF9jb250ZXh0cyA9IGFkZXYtPmdmeC5jb25maWcubWF4X2h3
X2NvbnRleHRzOwotCQlkZXZfaW5mby0+X3BhZCA9IDA7CiAJCWRldl9pbmZvLT5pZHNfZmxhZ3Mg
PSAwOwogCQlpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQogCQkJZGV2X2luZm8tPmlkc19m
bGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX0ZVU0lPTjsKQEAgLTg1Miw2ICs4NTMsMTcgQEAgaW50
IGFtZGdwdV9pbmZvX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsIHN0
cnVjdCBkcm1fZmlsZSAqZmlscCkKIAogCQlkZXZfaW5mby0+dGNjX2Rpc2FibGVkX21hc2sgPSBh
ZGV2LT5nZnguY29uZmlnLnRjY19kaXNhYmxlZF9tYXNrOwogCisJCS8qIENvbWJpbmUgdGhlIGNo
aXAgZ2VuIG1hc2sgd2l0aCB0aGUgcGxhdGZvcm0gKENQVS9tb2JvKSBtYXNrLiAqLworCQlwY2ll
X2dlbl9tYXNrID0gYWRldi0+cG0ucGNpZV9nZW5fbWFzayAmIChhZGV2LT5wbS5wY2llX2dlbl9t
YXNrID4+IDE2KTsKKwkJZGV2X2luZm8tPnBjaWVfZ2VuID0gZmxzKHBjaWVfZ2VuX21hc2spOwor
CQlkZXZfaW5mby0+cGNpZV9udW1fbGFuZXMgPQorCQkJYWRldi0+cG0ucGNpZV9tbHdfbWFzayAm
IENBSUxfUENJRV9MSU5LX1dJRFRIX1NVUFBPUlRfWDMyID8gMzIgOgorCQkJYWRldi0+cG0ucGNp
ZV9tbHdfbWFzayAmIENBSUxfUENJRV9MSU5LX1dJRFRIX1NVUFBPUlRfWDE2ID8gMTYgOgorCQkJ
YWRldi0+cG0ucGNpZV9tbHdfbWFzayAmIENBSUxfUENJRV9MSU5LX1dJRFRIX1NVUFBPUlRfWDEy
ID8gMTIgOgorCQkJYWRldi0+cG0ucGNpZV9tbHdfbWFzayAmIENBSUxfUENJRV9MSU5LX1dJRFRI
X1NVUFBPUlRfWDggPyA4IDoKKwkJCWFkZXYtPnBtLnBjaWVfbWx3X21hc2sgJiBDQUlMX1BDSUVf
TElOS19XSURUSF9TVVBQT1JUX1g0ID8gNCA6CisJCQlhZGV2LT5wbS5wY2llX21sd19tYXNrICYg
Q0FJTF9QQ0lFX0xJTktfV0lEVEhfU1VQUE9SVF9YMiA/IDIgOiAxOworCiAJCXJldCA9IGNvcHlf
dG9fdXNlcihvdXQsIGRldl9pbmZvLAogCQkJCSAgIG1pbigoc2l6ZV90KXNpemUsIHNpemVvZigq
ZGV2X2luZm8pKSkgPyAtRUZBVUxUIDogMDsKIAkJa2ZyZWUoZGV2X2luZm8pOwpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdw
dV9kcm0uaAppbmRleCBmZTdmODcxZTMwODAuLjk3M2FmNmQwNjYyNiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmgKQEAgLTEwNTMsNyArMTA1Myw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fZGV2aWNl
IHsKIAlfX3UzMiBlbmFibGVkX3JiX3BpcGVzX21hc2s7CiAJX191MzIgbnVtX3JiX3BpcGVzOwog
CV9fdTMyIG51bV9od19nZnhfY29udGV4dHM7Ci0JX191MzIgX3BhZDsKKwkvKiBQQ0llIHZlcnNp
b24gKHRoZSBzbWFsbGVyIG9mIHRoZSBHUFUgYW5kIHRoZSBDUFUvbW90aGVyYm9hcmQpICovCisJ
X191MzIgcGNpZV9nZW47CiAJX191NjQgaWRzX2ZsYWdzOwogCS8qKiBTdGFydGluZyB2aXJ0dWFs
IGFkZHJlc3MgZm9yIFVNRHMuICovCiAJX191NjQgdmlydHVhbF9hZGRyZXNzX29mZnNldDsKQEAg
LTExMDAsNyArMTEwMSw4IEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fZGV2aWNlIHsKIAlfX3Uz
MiBnc19wcmltX2J1ZmZlcl9kZXB0aDsKIAkvKiBtYXggZ3Mgd2F2ZWZyb250IHBlciB2Z3QqLwog
CV9fdTMyIG1heF9nc193YXZlc19wZXJfdmd0OwotCV9fdTMyIF9wYWQxOworCS8qIFBDSWUgbnVt
YmVyIG9mIGxhbmVzICh0aGUgc21hbGxlciBvZiB0aGUgR1BVIGFuZCB0aGUgQ1BVL21vdGhlcmJv
YXJkKSAqLworCV9fdTMyIHBjaWVfbnVtX2xhbmVzOwogCS8qIGFsd2F5cyBvbiBjdSBiaXRtYXAg
Ki8KIAlfX3UzMiBjdV9hb19iaXRtYXBbNF1bNF07CiAJLyoqIFN0YXJ0aW5nIGhpZ2ggdmlydHVh
bCBhZGRyZXNzIGZvciBVTURzLiAqLwotLSAKMi4zNC4xCgo=
--0000000000009ec8e005f22da9d1--
