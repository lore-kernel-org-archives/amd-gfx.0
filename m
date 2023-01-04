Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43651C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7AD10E05C;
	Wed,  4 Jan 2023 14:14:16 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F44110E0BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:14:15 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id z11so32884335ede.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 06:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PuwygBwSI4QxkETSUuGcMRknGHjunEU33VckfSwOY1c=;
 b=DyrHLr/cLS5ESgfyJndnkHB++prELq/JuF157HoPMdgXnRJA1bEJhZzxdDYeSGrSwq
 cWYg6tstC0sQVrhdEQeuphNdvroB56swBLBP0qp9rpjataogcPIO7zsP/AdNPWZKSGKC
 ePpfZpwp27akTXfao4+urQ3jYUB4FA++wTScWmN/dZHLK7VyeZgP6q/aQ6OzjEI/rJ2O
 fKa6rC48+sOSVMoe7Hp2VJxKh2bpo4dCmidX7HxjCGuX/5+Z/OQTGi6I9W/lEEDaYTH/
 S3y5Bn7zJgf3XtuWOsSMRjqxMKOeJ7J2c0Xomyd3jwSlVGY1Qr4jQuQ5gPMzK+A1ArHj
 sOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuwygBwSI4QxkETSUuGcMRknGHjunEU33VckfSwOY1c=;
 b=WcULvx6ZqC7gImZQvI5qfG4KgldGIXvSf//kbioiLZtfPPh2m3uWkFVfQJzeytdopk
 mfpSwQFV3GvWbOxYt+SvXFs2snFva16zrFPe8hPSgSNKsuXyBEozFogKZ1p0cQ5KIO9K
 YF6/2omQrDGhYZtp71zm/8S6y0qy6mDE24Axec7wqWkuFuEKjAop3WO9Ih4h25Vf0gwt
 3F59fNDMxsV9A9EIatocK8yBn06f3nW2uNkLtobza839gWXKoxMkmU25rWtsVe+cOFHH
 utkLHEWEB3Her7whbhJsSwYBsUuLDeeaolUm0jium/BV5C0e+KcYO5OzSSgKEINaB5UG
 kbEg==
X-Gm-Message-State: AFqh2kpIVKsRf4NzeGNPqZ5MIA+IHcjv3yNkTuCe5+KN5SYKcEY68NPK
 OxOqtz09VRZ7niynv54NPkH0jdkKWeCZmCn4vDdXKD51gN0=
X-Google-Smtp-Source: AMrXdXtifRX4AytmNpw9Mwmdt+RJZtex20NbkAMkRcWUs3EA8I3iOswidjnCaZFnAMR7CeeUavniI9o2BbJLO5xMgek=
X-Received: by 2002:a05:6402:2906:b0:48e:bd55:cfa8 with SMTP id
 ee6-20020a056402290600b0048ebd55cfa8mr790206edb.69.1672841653754; Wed, 04 Jan
 2023 06:14:13 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
In-Reply-To: <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 4 Jan 2023 09:13:37 -0500
Message-ID: <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: multipart/alternative; boundary="00000000000089a15405f170cc05"
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

--00000000000089a15405f170cc05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:

>
>
> On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:
> > I see. Well, those sysfs files are not usable, and I don't think it
> > would be important even if they were usable, but for completeness:
> >
> > The ioctl returns:
> >      pcie_gen =3D 1
> >      pcie_num_lanes =3D 16
> >
> > Theoretical bandwidth from those values: 4.0 GB/s
> > My DMA test shows this write bandwidth: 3.5 GB/s
> > It matches the expectation.
> >
> > Let's see the devices (there is only 1 GPU Navi21 in the system):
> > $ lspci |egrep '(PCI|VGA).*Navi'
> > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> > Upstream Port of PCI Express Switch (rev c3)
> > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
> > Downstream Port of PCI Express Switch
> > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
> >
> > Let's read sysfs:
> >
> > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
> > 16
> > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
> > 2.5 GT/s PCIe
> > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
> > 16.0 GT/s PCIe
> > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
> > 16.0 GT/s PCIe
> >
> > Problem 1: None of the speed numbers match 4 GB/s.
>
> US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total
> theoretical bandwidth is then derived based on encoding and total number
> of lanes.
>
> > Problem 2: Userspace doesn't know the bus index of the bridges, and it'=
s
> > not clear which bridge should be used.
>
> In general, modern ones have this arch=3D US->DS->EP. US is the one
> connected to physical link.
>
> > Problem 3: The PCIe gen number is missing.
>
> Current link speed is based on whether it's Gen1/2/3/4/5.
>
> BTW, your patch makes use of capabilities flags which gives the maximum
> supported speed/width by the device. It may not necessarily reflect the
> current speed/width negotiated. I guess in NV, this info is already
> obtained from PMFW and made available through metrics table.
>

It computes the minimum of the device PCIe gen and the motherboard/slot
PCIe gen to get the final value. These 2 lines do that. The low 16 bits of
the mask contain the device PCIe gen mask. The high 16 bits of the mask
contain the slot PCIe gen mask.
+ pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16)=
;
+ dev_info->pcie_gen =3D fls(pcie_gen_mask);

Marek

--00000000000089a15405f170cc05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &lt;<a href=3D"mailto:lij=
o.lazar@amd.com">lijo.lazar@amd.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
<br>
On 1/4/2023 4:11 AM, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; I see. Well, those sysfs files are not usable, and I don&#39;t think i=
t <br>
&gt; would be important even if they were usable, but for completeness:<br>
&gt; <br>
&gt; The ioctl returns:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pcie_gen =3D 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pcie_num_lanes =3D 16<br>
&gt; <br>
&gt; Theoretical bandwidth from those values: 4.0 GB/s<br>
&gt; My DMA test shows this write bandwidth: 3.5 GB/s<br>
&gt; It matches the expectation.<br>
&gt; <br>
&gt; Let&#39;s see the devices (there is only 1 GPU Navi21 in the system):<=
br>
&gt; $ lspci |egrep &#39;(PCI|VGA).*Navi&#39;<br>
&gt; 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL =
<br>
&gt; Upstream Port of PCI Express Switch (rev c3)<br>
&gt; 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL =
<br>
&gt; Downstream Port of PCI Express Switch<br>
&gt; 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. <br>
&gt; [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)<br>
&gt; <br>
&gt; Let&#39;s read sysfs:<br>
&gt; <br>
&gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width<br>
&gt; 16<br>
&gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width<br>
&gt; 16<br>
&gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width<br>
&gt; 16<br>
&gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed<br>
&gt; 2.5 GT/s PCIe<br>
&gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed<br>
&gt; 16.0 GT/s PCIe<br>
&gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed<br>
&gt; 16.0 GT/s PCIe<br>
&gt; <br>
&gt; Problem 1: None of the speed numbers match 4 GB/s.<br>
<br>
US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total <br>
theoretical bandwidth is then derived based on encoding and total number <b=
r>
of lanes.<br>
<br>
&gt; Problem 2: Userspace doesn&#39;t know the bus index of the bridges, an=
d it&#39;s <br>
&gt; not clear which bridge should be used.<br>
<br>
In general, modern ones have this arch=3D US-&gt;DS-&gt;EP. US is the one <=
br>
connected to physical link.<br>
<br>
&gt; Problem 3: The PCIe gen number is missing.<br>
<br>
Current link speed is based on whether it&#39;s Gen1/2/3/4/5.<br>
<br>
BTW, your patch makes use of capabilities flags which gives the maximum <br=
>
supported speed/width by the device. It may not necessarily reflect the <br=
>
current speed/width negotiated. I guess in NV, this info is already <br>
obtained from PMFW and made available through metrics table.<br></blockquot=
e><div><br></div>It computes the minimum of the device PCIe gen and the mot=
herboard/slot PCIe gen to get the final value. These 2 lines do that. The l=
ow 16 bits of the mask contain the device PCIe gen mask. The high 16 bits o=
f the mask contain the slot PCIe gen mask.<br></div>+		pcie_gen_mask =3D ad=
ev-&gt;pm.pcie_gen_mask &amp; (adev-&gt;pm.pcie_gen_mask &gt;&gt; 16);<br><=
div>+		dev_info-&gt;pcie_gen =3D fls(pcie_gen_mask);</div><div><br></div><d=
iv class=3D"gmail_quote">Marek<br></div></div>

--00000000000089a15405f170cc05--
