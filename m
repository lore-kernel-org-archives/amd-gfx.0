Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B31C53210
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 20:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5355010E48E;
	Wed,  4 Jan 2023 20:17:53 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2479210E490
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 20:17:51 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id 18so967153edw.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NjvegWkbY99PiYaSjulEQhL0hgv2MRCRhB1ToTSxqs=;
 b=nTZbpbxhbF+d7R8cdxtYw/gLypsUnhuuETUX+ZTh41GKmN+m363pfLkxj5Fi8+MI6l
 BKBSlS/3lSI6jZT0vvVQNsF6t7uUCjT3xn2Wx286s5NPw0afrfTsOuxM8u8qKLW+L5q8
 Zinqc5/18pK9tqV71HqWEoKHiVRtuteSb3jgvjYOe+qneUiktN8ZpMeSTQ3jygOJSI0i
 iEzUw50INuTe5eON+LNngcUISLlUpLGHCV0BQreUh8ROr7pl5Ar2hRFeEwQ2oIvuFQ1u
 7i+6HqZANE6m5OlU5T8pDm8111Yg/RZzRFSp8uB9rp//TQ6Zuub28mJ5Dgl6W/3nOZ2T
 tPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NjvegWkbY99PiYaSjulEQhL0hgv2MRCRhB1ToTSxqs=;
 b=zkXucqNHl6NEEn7zP2tu/T+ahBRocZMK6huohDYk9582dkpDie/SZbVwgd9IRKv5Bs
 EZTdKmPQ1jf/UZSSt/FJAiJpDv9E+J+DSp+NjdLoPuLw4BYuhuh78X8pAPyCiPsjq90O
 2BBvO4slvGiC62aPEuV0nJgyQLckGAOLI7IDNqoBvJFI5MQowP7gFt8IVC34P4hs4LbZ
 eMQzB5WJ2ISi7VMyH/k4dA5zMVrNz9USL46vygoNuCx+EDh4R3/NNzxYtB6xBuRMwnB6
 YWH6NyxOtPBc7FCBKVEW/xKDysSlB6mZMGhRnvM1g2sQedA/rQV9czEi5OcUcgxgvory
 HgrA==
X-Gm-Message-State: AFqh2kpEqnZQmHxpo5FjjZ+8bebsHg66CVfTVQukWR6AmUH5aHc2o5M2
 BDg4DagMrtrEhF2qXgNdaKcvvkXQ8lsfYe/45lRd650x
X-Google-Smtp-Source: AMrXdXtakh4n+/FwzSOfN+3NKY75xWMk5jHzh/PP1lZJGEMkMgS9VM2WEPAzL4Bq/A+PgQKu3dzYSHNsDIYiTrbXsag=
X-Received: by 2002:a50:cc47:0:b0:461:b6a9:c5cb with SMTP id
 n7-20020a50cc47000000b00461b6a9c5cbmr5509711edi.148.1672863469524; Wed, 04
 Jan 2023 12:17:49 -0800 (PST)
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
In-Reply-To: <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 4 Jan 2023 15:17:12 -0500
Message-ID: <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Content-Type: multipart/alternative; boundary="000000000000dbdafe05f175e066"
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000dbdafe05f175e066
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, it's meant to be like a spec sheet. We are not interested in the
current bandwidth utilization.

Marek

On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:

> [AMD Official Use Only - General]
>
> To clarify, with DPM in place, the current bandwidth will be changing
> based on the load.
>
> If apps/umd already has a way to know the current bandwidth utilisation,
> then possible maximum also could be part of the same API. Otherwise, this
> only looks like duplicate information. We have the same information in
> sysfs DPM nodes.
>
> BTW, I don't know to what extent app/umd really makes use of this. Take
> that memory frequency as an example (I'm reading it as 16GHz). It only
> looks like a spec sheet.
>
> Thanks,
> Lijo
> ------------------------------
> *From:* Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>
> *Sent:* Wednesday, January 4, 2023 8:40:00 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from
> the INFO
>
> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
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
>
> It helps UMDs make better decisions if they know the maximum achievable
> bandwidth. UMDs also compute the maximum memory bandwidth and compute
> performance (FLOPS). Right now it's printed by Mesa to give users detaile=
d
> information about their GPU. For example:
>
> $ AMD_DEBUG=3Dinfo glxgears
> Device info:
>     name =3D NAVI21
>     marketing_name =3D AMD Radeon RX 6800
>     num_se =3D 3
>     num_rb =3D 12
>     num_cu =3D 60
>     max_gpu_freq =3D 2475 MHz
>     max_gflops =3D 19008 GFLOPS
>     l0_cache_size =3D 16 KB
>     l1_cache_size =3D 128 KB
>     l2_cache_size =3D 4096 KB
>     l3_cache_size =3D 128 MB
>     memory_channels =3D 16 (TCC blocks)
>     memory_size =3D 16 GB (16384 MB)
>     memory_freq =3D 16 GHz
>     memory_bus_width =3D 256 bits
>     memory_bandwidth =3D 512 GB/s
>     pcie_gen =3D 1
>     pcie_num_lanes =3D 16
>     pcie_bandwidth =3D 4.0 GB/s
>
> Marek
>

--000000000000dbdafe05f175e066
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Yes, it&#39;s meant to be like a spec sheet. We are n=
ot interested in the current bandwidth utilization.</div><div><br></div><di=
v>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo &lt;<a href=3D=
"mailto:Lijo.Lazar@amd.com" target=3D"_blank">Lijo.Lazar@amd.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">



<div>
<p style=3D"font-family:Arial;font-size:10pt;color:rgb(0,0,255);margin:5pt"=
 align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color:rgb(33,33,33);background-color:rgb(255,255,255)" dir=3D=
"auto">
<span dir=3D"auto" style=3D"font-size:16px;background-color:rgb(255,255,255=
);color:rgb(33,33,33)">To clarify, with DPM in place, the current bandwidth=
 will be changing based on the load.=C2=A0<span></span></span>
<div dir=3D"auto" style=3D"font-size:16px;background-color:rgb(255,255,255)=
;color:rgb(33,33,33)">
<br>
</div>
<div dir=3D"auto" style=3D"font-size:16px;background-color:rgb(255,255,255)=
;color:rgb(33,33,33)">
If apps/umd already has a way to know the current bandwidth utilisation, th=
en possible maximum also could be part of the same API. Otherwise, this onl=
y looks like duplicate info<span>rmation. We have the same information in s=
ysfs DPM nodes.</span></div>
<div dir=3D"auto" style=3D"font-size:16px;background-color:rgb(255,255,255)=
;color:rgb(33,33,33)">
<span><br>
</span></div>
<div dir=3D"auto" style=3D"font-size:16px;background-color:rgb(255,255,255)=
;color:rgb(33,33,33)">
<span>BTW, I don&#39;t know to what extent app/umd really makes use of this=
. Take that memory frequency as an example (I&#39;m reading it as 16GHz). I=
t only looks like a spec sheet.</span></div>
</div>
<div id=3D"m_-992135596962469349m_6780798461256376712ms-outlook-mobile-sign=
ature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-992135596962469349m_6780798461256376712divRplyFwdMsg" dir=3D"=
ltr"><font style=3D"font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#=
000000"><b>From:</b> Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gma=
il.com" target=3D"_blank">maraeo@gmail.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 4, 2023 8:40:00 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"=
_blank">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.fr=
eedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes f=
rom the INFO</font>
<div>=C2=A0</div>
</div>
<div>
<div dir=3D"ltr">
<div>
<div dir=3D"ltr">On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo &lt;<a href=3D"=
mailto:lijo.lazar@amd.com" target=3D"_blank">lijo.lazar@amd.com</a>&gt; wro=
te:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
<br>
On 1/4/2023 7:43 PM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &lt;<a href=3D"mailto:lijo.=
lazar@amd.com" target=3D"_blank">lijo.lazar@amd.com</a>
<br>
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
upper level apps?<br>
</blockquote>
<div><br>
</div>
It helps UMDs make better decisions if they know the maximum achievable ban=
dwidth. UMDs also compute the maximum memory bandwidth and compute performa=
nce (FLOPS). Right now it&#39;s printed by Mesa to give users detailed info=
rmation about their GPU. For example:<br>
</div>
<div><br>
</div>
<div>$ AMD_DEBUG=3Dinfo glxgears<br>
Device info:<br>
=C2=A0 =C2=A0 name =3D NAVI21<br>
=C2=A0 =C2=A0 marketing_name =3D AMD Radeon RX 6800<br>
=C2=A0 =C2=A0 num_se =3D 3<br>
=C2=A0 =C2=A0 num_rb =3D 12<br>
=C2=A0 =C2=A0 num_cu =3D 60<br>
=C2=A0 =C2=A0 max_gpu_freq =3D 2475 MHz<br>
=C2=A0 =C2=A0 max_gflops =3D 19008 GFLOPS<br>
=C2=A0 =C2=A0 l0_cache_size =3D 16 KB<br>
=C2=A0 =C2=A0 l1_cache_size =3D 128 KB<br>
=C2=A0 =C2=A0 l2_cache_size =3D 4096 KB<br>
=C2=A0 =C2=A0 l3_cache_size =3D 128 MB<br>
=C2=A0 =C2=A0 memory_channels =3D 16 (TCC blocks)<br>
=C2=A0 =C2=A0 memory_size =3D 16 GB (16384 MB)<br>
=C2=A0 =C2=A0 memory_freq =3D 16 GHz<br>
=C2=A0 =C2=A0 memory_bus_width =3D 256 bits<br>
=C2=A0 =C2=A0 memory_bandwidth =3D 512 GB/s<br>
=C2=A0 =C2=A0 pcie_gen =3D 1<br>
=C2=A0 =C2=A0 pcie_num_lanes =3D 16<br>
=C2=A0 =C2=A0 pcie_bandwidth =3D 4.0 GB/s</div>
<div><br>
</div>
<div>Marek<br>
</div>
</div>
</div>
</div>
</div>

</blockquote></div>

--000000000000dbdafe05f175e066--
