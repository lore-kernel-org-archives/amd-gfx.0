Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB275C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 15:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32C210E454;
	Wed,  4 Jan 2023 15:10:40 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F173F10E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 15:10:38 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id fc4so83216978ejc.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QTYNahCtH6IEx6fyWkiwwKXR0QkFzC7zwnL9p4qczc=;
 b=UYsInzVLb5sJG12tnwAPZQIXBN5Czt8Wuvs/BcpaOksxNR5Xg5+i4jASTk6S7ERD6E
 K86Jqh/ZA3AaGspkXdvBP+LTeKdiWvD2oYYhucEGWK7Vk3M5uAt1BXEGf+MWxopDHmOa
 xf9o1qfl88ti6sbVdezozPkSPUDtCBGZdUe4NdKVB99osapznDrK2fzB06dzv6q8E1+i
 I6fICxdfDXqfW6qZ/gGhcuVAM9W8lmujcXCKk86bnDHUFWiZJR872uI7ntth5pvGgT1j
 +GDxVH9nDG/tBwDxHiA/A//NqldFMDf+xQKxlnqKWH+aW6k9u1YoHeT720PznA1o3xQc
 WMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QTYNahCtH6IEx6fyWkiwwKXR0QkFzC7zwnL9p4qczc=;
 b=ao8Wf824vbDcz1laBHFmA6M2jI5hM5jAcYt6qsaV9OwfbmcYHIosptGc/CjUAlEX6P
 A7O4UdllwozeTsxOr80fkx5JwJYLqwuI+D5AmAe11rQY595gupl2zfFvtbEJGLX9+jw8
 MuLqG7eNLU/YaGYybL5k5cgIb9D274FCX+HAtccXB5vfhkbH6R0h+Lma05bDNWZ05jB6
 WXFO41eTRQLRXL/jASebqDBKpMvAJxslqd9Ismrw4g2k9gzfX0iDDDIsmuX8BLlEj/DZ
 RPQZFx0gfkMoRe7nJocvIyitWOi1cthMOvXCOcS9zMO/ZoJphEooapdrmLEBTob/g9uD
 v8Ng==
X-Gm-Message-State: AFqh2kpShMKP1/J1UqBgsVpBzsFAd4rp/amOL/ZieQ+A0EhQWTv4f4EQ
 1KJ8xWY5sD2uH0g8bXQtZny2vtDxgMuvmUUmc2BchmrkdrA=
X-Google-Smtp-Source: AMrXdXs8ExB/HhXHZehwT9HcoiaWe1Dikf7sprmtBGQtuAp0s0Zg4W4y2vg5vzbNl8qEazh84DuI45xZoonQO1dzc54=
X-Received: by 2002:a17:906:1407:b0:7c1:7226:c935 with SMTP id
 p7-20020a170906140700b007c17226c935mr5566391ejc.338.1672845037482; Wed, 04
 Jan 2023 07:10:37 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
In-Reply-To: <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 4 Jan 2023 10:10:00 -0500
Message-ID: <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: multipart/alternative; boundary="00000000000039382605f1719651"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000039382605f1719651
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:

>
>
> On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
> > On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
> > <mailto:lijo.lazar@amd.com>> wrote:
> >
> >
> >
> >     On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
> >      > I see. Well, those sysfs files are not usable, and I don't think
> it
> >      > would be important even if they were usable, but for completenes=
s:
> >      >
> >      > The ioctl returns:
> >      >      pcie_gen =3D 1
> >      >      pcie_num_lanes =3D 16
> >      >
> >      > Theoretical bandwidth from those values: 4.0 GB/s
> >      > My DMA test shows this write bandwidth: 3.5 GB/s
> >      > It matches the expectation.
> >      >
> >      > Let's see the devices (there is only 1 GPU Navi21 in the system)=
:
> >      > $ lspci |egrep '(PCI|VGA).*Navi'
> >      > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
> >     10 XL
> >      > Upstream Port of PCI Express Switch (rev c3)
> >      > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
> >     10 XL
> >      > Downstream Port of PCI Express Switch
> >      > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >      > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
> >      >
> >      > Let's read sysfs:
> >      >
> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> >      > 16
> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> >      > 16
> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> >      > 16
> >      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> >      > 2.5 GT/s PCIe
> >      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> >      > 16.0 GT/s PCIe
> >      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> >      > 16.0 GT/s PCIe
> >      >
> >      > Problem 1: None of the speed numbers match 4 GB/s.
> >
> >     US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total
> >     theoretical bandwidth is then derived based on encoding and total
> >     number
> >     of lanes.
> >
> >      > Problem 2: Userspace doesn't know the bus index of the bridges,
> >     and it's
> >      > not clear which bridge should be used.
> >
> >     In general, modern ones have this arch=3D US->DS->EP. US is the one
> >     connected to physical link.
> >
> >      > Problem 3: The PCIe gen number is missing.
> >
> >     Current link speed is based on whether it's Gen1/2/3/4/5.
> >
> >     BTW, your patch makes use of capabilities flags which gives the
> maximum
> >     supported speed/width by the device. It may not necessarily reflect
> the
> >     current speed/width negotiated. I guess in NV, this info is already
> >     obtained from PMFW and made available through metrics table.
> >
> >
> > It computes the minimum of the device PCIe gen and the motherboard/slot
> > PCIe gen to get the final value. These 2 lines do that. The low 16 bits
> > of the mask contain the device PCIe gen mask. The high 16 bits of the
> > mask contain the slot PCIe gen mask.
> > + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >>
> 16);
> > + dev_info->pcie_gen =3D fls(pcie_gen_mask);
> >
>
> With DPM in place on some ASICs, how much does this static info help for
> upper level apps?
>

It helps UMDs make better decisions if they know the maximum achievable
bandwidth. UMDs also compute the maximum memory bandwidth and compute
performance (FLOPS). Right now it's printed by Mesa to give users detailed
information about their GPU. For example:

$ AMD_DEBUG=3Dinfo glxgears
Device info:
    name =3D NAVI21
    marketing_name =3D AMD Radeon RX 6800
    num_se =3D 3
    num_rb =3D 12
    num_cu =3D 60
    max_gpu_freq =3D 2475 MHz
    max_gflops =3D 19008 GFLOPS
    l0_cache_size =3D 16 KB
    l1_cache_size =3D 128 KB
    l2_cache_size =3D 4096 KB
    l3_cache_size =3D 128 MB
    memory_channels =3D 16 (TCC blocks)
    memory_size =3D 16 GB (16384 MB)
    memory_freq =3D 16 GHz
    memory_bus_width =3D 256 bits
    memory_bandwidth =3D 512 GB/s
    pcie_gen =3D 1
    pcie_num_lanes =3D 16
    pcie_bandwidth =3D 4.0 GB/s

Marek

--00000000000039382605f1719651
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo &lt;<a href=3D"mailto:lij=
o.lazar@amd.com">lijo.lazar@amd.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
<br>
On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &lt;<a href=3D"mailto:lijo.=
lazar@amd.com" target=3D"_blank">lijo.lazar@amd.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:lijo.lazar@amd.com" target=3D"_blank">lij=
o.lazar@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I see. Well, those sysfs files are not usable=
, and I don&#39;t think it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; would be important even if they were usable, =
but for completeness:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The ioctl returns:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pcie_gen =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 pcie_num_lanes =3D 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Theoretical bandwidth from those values: 4.0 =
GB/s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; My DMA test shows this write bandwidth: 3.5 G=
B/s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It matches the expectation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Let&#39;s see the devices (there is only 1 GP=
U Navi21 in the system):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ lspci |egrep &#39;(PCI|VGA).*Navi&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0a:00.0 PCI bridge: Advanced Micro Devices, I=
nc. [AMD/ATI] Navi<br>
&gt;=C2=A0 =C2=A0 =C2=A010 XL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Upstream Port of PCI Express Switch (rev c3)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0b:00.0 PCI bridge: Advanced Micro Devices, I=
nc. [AMD/ATI] Navi<br>
&gt;=C2=A0 =C2=A0 =C2=A010 XL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Downstream Port of PCI Express Switch<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 0c:00.0 VGA compatible controller: Advanced M=
icro Devices, Inc.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6=
900 XT] (rev c3)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Let&#39;s read sysfs:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/curre=
nt_link_width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/curre=
nt_link_width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/curre=
nt_link_width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/curre=
nt_link_speed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 2.5 GT/s PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/curre=
nt_link_speed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16.0 GT/s PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/curre=
nt_link_speed<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 16.0 GT/s PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 1: None of the speed numbers match 4 =
GB/s.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0US bridge =3D 2.5GT/s means operating at PCIe Gen 1=
 speed. Total<br>
&gt;=C2=A0 =C2=A0 =C2=A0theoretical bandwidth is then derived based on enco=
ding and total<br>
&gt;=C2=A0 =C2=A0 =C2=A0number<br>
&gt;=C2=A0 =C2=A0 =C2=A0of lanes.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 2: Userspace doesn&#39;t know the bus=
 index of the bridges,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; not clear which bridge should be used.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In general, modern ones have this arch=3D US-&gt;DS=
-&gt;EP. US is the one<br>
&gt;=C2=A0 =C2=A0 =C2=A0connected to physical link.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Problem 3: The PCIe gen number is missing.<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Current link speed is based on whether it&#39;s Gen=
1/2/3/4/5.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0BTW, your patch makes use of capabilities flags whi=
ch gives the maximum<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported speed/width by the device. It may not nec=
essarily reflect the<br>
&gt;=C2=A0 =C2=A0 =C2=A0current speed/width negotiated. I guess in NV, this=
 info is already<br>
&gt;=C2=A0 =C2=A0 =C2=A0obtained from PMFW and made available through metri=
cs table.<br>
&gt; <br>
&gt; <br>
&gt; It computes the minimum of the device PCIe gen and the motherboard/slo=
t <br>
&gt; PCIe gen to get the final value. These 2 lines do that. The low 16 bit=
s <br>
&gt; of the mask contain the device PCIe gen mask. The high 16 bits of the =
<br>
&gt; mask contain the slot PCIe gen mask.<br>
&gt; + pcie_gen_mask =3D adev-&gt;pm.pcie_gen_mask &amp; (adev-&gt;pm.pcie_=
gen_mask &gt;&gt; 16);<br>
&gt; + dev_info-&gt;pcie_gen =3D fls(pcie_gen_mask);<br>
&gt; <br>
<br>
With DPM in place on some ASICs, how much does this static info help for <b=
r>
upper level apps?<br></blockquote><div><br></div>It helps UMDs make better =
decisions if they know the maximum achievable bandwidth. UMDs also compute =
the maximum memory bandwidth and compute performance (FLOPS). Right now it&=
#39;s printed by Mesa to give users detailed information about their GPU. F=
or example:<br></div><div class=3D"gmail_quote"><br></div><div class=3D"gma=
il_quote">$ AMD_DEBUG=3Dinfo glxgears<br>Device info:<br>=C2=A0 =C2=A0 name=
 =3D NAVI21<br>=C2=A0 =C2=A0 marketing_name =3D AMD Radeon RX 6800<br>=C2=
=A0 =C2=A0 num_se =3D 3<br>=C2=A0 =C2=A0 num_rb =3D 12<br>=C2=A0 =C2=A0 num=
_cu =3D 60<br>=C2=A0 =C2=A0 max_gpu_freq =3D 2475 MHz<br>=C2=A0 =C2=A0 max_=
gflops =3D 19008 GFLOPS<br>=C2=A0 =C2=A0 l0_cache_size =3D 16 KB<br>=C2=A0 =
=C2=A0 l1_cache_size =3D 128 KB<br>=C2=A0 =C2=A0 l2_cache_size =3D 4096 KB<=
br>=C2=A0 =C2=A0 l3_cache_size =3D 128 MB<br>=C2=A0 =C2=A0 memory_channels =
=3D 16 (TCC blocks)<br>=C2=A0 =C2=A0 memory_size =3D 16 GB (16384 MB)<br>=
=C2=A0 =C2=A0 memory_freq =3D 16 GHz<br>=C2=A0 =C2=A0 memory_bus_width =3D =
256 bits<br>=C2=A0 =C2=A0 memory_bandwidth =3D 512 GB/s<br>=C2=A0 =C2=A0 pc=
ie_gen =3D 1<br>=C2=A0 =C2=A0 pcie_num_lanes =3D 16<br>=C2=A0 =C2=A0 pcie_b=
andwidth =3D 4.0 GB/s</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">Marek<br></div></div>

--00000000000039382605f1719651--
