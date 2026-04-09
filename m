Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA76E99054
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9291B10E8C6;
	Fri, 10 Apr 2026 07:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="QnAsqFJo";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562EA10E7EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:12:54 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50d6144877aso9029641cf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 06:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775740373; cv=none;
 d=google.com; s=arc-20240605;
 b=c9NLc1YiXs1+EAaAYfc/3pHkZrdG9ftwBb6NNxgtREkfjB//hMAZiABd3YMxzidJB8
 w2MMZzG/ikm/QRI7YmjWOEvKr/jvHV+LwSeZFbE/X6FgjB1vbpIWZehT5Ql1NiH/4jKB
 ykv06ygo9i7LCWjxzIR6a/hypGwdEAzxplOC1XJdIEuusrxQQpY7bz2c+jR5f3mdV/Ow
 Xcm0fbtl38YDNgE+CJC/EgI/2DcFSHAf9wDvNQv80WkAXCurf8tGog+eoG6dZ57eCSpH
 T9YarXAoxMsAIf3ucz8g9QWZ5W3xs2B55/uVuelLIwXylnS2TbwXx+mSuY05Qt9QoLtv
 nvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=24QeZ+gIfMRwTuFxEQ6wFaCAeiF7rgwaD/VTqyS40Ls=;
 fh=3mxbbTVKDqPLGS2fD+N9WVhtNN2dfHXY07YXYDEWkfA=;
 b=VpnU+XS/pTpRv03IuGE/+hdy0slh+yKDZJVN7efCdqKIn6y4Jf7tWbE2IbClF8h9Uu
 wEuH7gFOrG+nVCrbrEnFWnNta2B4mlTShIB1/A4D3o9dLQVb22XUcF1gSkQzXbaJYVdf
 LB/O1HjB7HF3GnRLPE1rJbFvzBMF7K784v4vKXb/i4Eo8byE/aWkkjf3r8Umlw6mdTKU
 EtS7pv/01VgAm5h813hxJSxfruaycVniA5gSA7FcXfH9C777b4/WpC5haCwpN+VaE1gy
 2tkue6iWfPrxJuoMnAmE2sY4mcPUlXyvxDU+EcARUc/6SkBrah/AdtYB+yPhBkeoGIez
 P3jA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775740373; x=1776345173;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24QeZ+gIfMRwTuFxEQ6wFaCAeiF7rgwaD/VTqyS40Ls=;
 b=QnAsqFJoX3I1OHKFYTb0b2NpZs6OB5PpCVHd0APXUAHvC3UO0gj6OHxkq8D30Cs4OU
 jXATiHkRR2/FPfFEBbKXTZw53AUxiPZDVOG2Ot4HQ71BvOLmPN5CJ1gUYvwp0Q6r96YU
 V+WkTkGnAoe03nigTErqiByMAV+MI3CEx7Iv4uUkKHPVQfvl5Zt2nswlP72yTWAxrqRI
 NZEW5epT61AmUMSf0GcgOtn6GXEbAxhk4aQ75S2IWwBRaIxSwuhAg1oqSP9Lp6gY88/A
 AEbRyYAIl80r6xSAncxEVFBegdvEk6RkwZr2L1c/ITUPmKNyGmPzq1+urP/NtUAKrkho
 vPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775740373; x=1776345173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24QeZ+gIfMRwTuFxEQ6wFaCAeiF7rgwaD/VTqyS40Ls=;
 b=nLqP821zIipJUs4L1FZ+TN9gbxz7oE0vUfyLuGOYN/fbIj/EbFAsuS3wDhiE9RQu6A
 kdFZbVZzThflLlMpdOI9kk9BMqL3E/02EWn2LFhyYuKC1slRYt+KnMPvcBK/OxWOVgWi
 u5vS+UfEqJ7gHbHAZThN7OpA2gX9B4YvasxDjxfrWjGNmLYXmCwQs6C8yrlp/76DUwUD
 Ky5gWQnsSKZvWPlCK8C5SYKM/IrpPaC3TOP8fGyDZBpEkJrG92Fd2qxFp60rs2H2aVhr
 QbcTZ3ZiQbWhuaYesEPat18GG2HiJ4DrgObz5D1O2ph/s3SoagZZuAliN71E5Yt8ZXmc
 IiDQ==
X-Gm-Message-State: AOJu0Yw2FiDmh9rbILuexZf37iPJB4cuBfZ9ckOzRtefKdqFgTUFig3C
 wi3KMNBxZGm9wl0GiAALmVmi9OfdMLL0KK21ITPCt2RsYLYjL3LZMke1B5o3aU/hb4KW3oxKFp5
 ExZ14/OOIaV9FzznRfxpjqHq2z1hi9VXqZi1KnPmDCQ==
X-Gm-Gg: AeBDiev7SfgkoD1CIbQ7SjqsC/6m8ff4Hq8OibkyMYStoYRRs4xZI79M1QAVbwhetPI
 P4fM4J+HrqGjpqSD4TmNlifiCDtY56EbdPWSMdjasNFWpLu5EPXrKBpG3uT5fgDBmw7s5/Tre7q
 Zu02Od+4373zNTe+qSpQfmTqfgPssmeS7dyKuFjVKcZr6F1AZxVGtWwwlqmf7fvWa4l8MafjFuP
 r492xfhbSrR1Nu9w4qi+l6UnIQIBE7W4L0n9dq1POx8TRiLvQKbNlGbrcCdVHDIqI5MavFwMIdJ
 1VpaIskcvPs+e0Cs6DOZ8GHSYC3QagJP5gX3dYyB2gkEF5PV
X-Received: by 2002:a05:622a:1a86:b0:50d:6b6d:bc17 with SMTP id
 d75a77b69052e-50dc212b2e3mr47103861cf.23.1775740372622; Thu, 09 Apr 2026
 06:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <CAGpo2mcLFMrkduCx1MuQnR3EZUxtEo+jT8PAXGgXbGDm2_1Now@mail.gmail.com>
 <b92192ad-0a49-4234-927d-71e2c5441947@amd.com>
In-Reply-To: <b92192ad-0a49-4234-927d-71e2c5441947@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Thu, 9 Apr 2026 06:12:41 -0700
X-Gm-Features: AQROBzCCCHv7v4dzgytxeV5SW4qwG-5ObFhE9jkbGPeUi7QwetQIvkEWDhoyy_E
Message-ID: <CAGpo2mdWGmDFVh_398=mBM4Zgt2fWXyBtYwFy4nH5VbxxbAmdQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>, alexander.deucher@amd.com
Content-Type: multipart/alternative; boundary="0000000000001fd8e1064f06c617"
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:07:32 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000001fd8e1064f06c617
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Christian,

This is going to be very interesting.
So the AMD Radeon AI R9700 Pro is running over USB4v2 into a Razor Dock on
a 650W power supply I have two of these setups cards provided by AMD for
some project testing on tb5 rocm ai broadcast messages for testing two
machines connected over tb5 with rdma sorry if I loose you here. What I am
seeing or finding in my opinion is thunderbolt is not very well flushed out
on Linux in terms of stability and accessible feature sets. After my kernel
pci patch I have gotten it to work which we went over already.

I have one machine running Qwen3.5 27B A3B on the GPU with llamacpp /
lemonade successfully but yesterday after attempting to load the model
which it did into vram it crashed which ten minutes prior was running a
prompt 73k tokens at 40tps. A side note The power management on Thunderbolt
seems to clash with the power management on the GPU. What I was seeing is
when the GPU doesn=E2=80=99t detect a display it =E2=80=9Csuspends=E2=80=9D=
 which may be correct or
not but it doesn=E2=80=99t matter either way in this scenario. The Thunderb=
olt
fabric I believe shuts down also and kills the link. I got passed this by
disabling all PM systems. So I=E2=80=99m not 100% sure what=E2=80=99s going=
 on and how to
find the actual problem yet maybe if I spend more time and brain power on
this I=E2=80=99ll find where in power management it=E2=80=99s having the pr=
oblem or if
that=E2=80=99s the real problem. Let me know if you can offer anymore guida=
nce into
where I should dig. I appreciate the help this far and the SMU information
helps get more context.

On Thu, Apr 9, 2026 at 5:57=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> Hi Geramy,
>
> On 4/9/26 14:13, Geramy Loveless wrote:
> > Hi Christian,
> >
> > I appreciate the speedy response,
> > What your saying makes sense they are basically wrapping symptoms that
> could at least from what I seen now at this point only continue and
> eventually create a web of useless code to try to catch all code paths it
> hits during crashing. Let me investigate the real reason as to why it=E2=
=80=99s
> crashing more rather then where.
>
> To just give you a bit background on what happens here:
>
> AMD GPUs have an embedded micro controller called SMU which takes care of
> things like voltages, clocks, temperature, fan speed etc.. and reset.
>
> So when the kernel driver detects that it needs to do a reset it sends a
> MODE1 reset command to the SMU. But instead of the SMU coming back a shor=
t
> time later noting that the reset was done the device just drops off the b=
us
> (e.g. all reads return 0xffffffff).
>
> The cause of that can be anything, e.g. from power fluctuations to a dirt=
y
> fan which doesn't starts to rotate again after it was stopped.
>
> I would try to narrow it down step by step, e.g. if it work on older
> kernels, if yes what feature/patch broke the behavior. You can also try t=
o
> disable certain power management features like ASPM (try amdgpu.aspm=3D0 =
on
> the kernel command line).
>
> Hope that helps,
> Christian.
>
> >
> >
> > On Thu, Apr 9, 2026 at 4:42=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com
> <mailto:christian.koenig@amd.com>> wrote:
> >
> >     On 4/9/26 02:05, Geramy Loveless wrote:
> >     > When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE=
1
> on
> >     > Thunderbolt the TB driver receives no notification and the tunnel
> >     > stays up while the endpoint is unreachable.
> >
> >     IIRC a MODE1 reset should keep the bus active and so the endpoint
> should still be reachable.
> >
> >     > All subsequent PCIe
> >     > reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> >     > triggering an infinite reset loop that hangs the system.
> >
> >     That sounds more like the MODE1 reset failed.
> >
> >     > After MODE1 reset completes, check whether the PCIe endpoint is
> still
> >     > reachable using pci_device_is_present(). If the device is behind
> >     > Thunderbolt and the link is dead, walk up parent bridges calling
> >     > pci_bridge_secondary_bus_reset() to retrain the physical PCIe lin=
k
> >     > inside the dock.
> >
> >     Well that is then a bus reset.
> >
> >     I mean that is a reasonable mitigation when a MODE1 reset failed,
> but the question is rather why does the MODE1 reset fails in the first
> place?
> >
> >     > If recovery fails, return -ENODEV to prevent the
> >     > reset retry loop.
> >     >
> >     > This also causes the GPU fan to be at 100% and basically when it
> >     > happens and you are not there, you now have a GPU with fan at 100=
%
> and
> >     > cant reset it.
> >     > I wanted to notate some other things I am finding sometimes befor=
e
> >     > this adventure of patches to the kernel and amdgpu driver.
> >     > Sometimes a crash could happen in the drive and then the GPU fan
> speed
> >     > hits 100% and the air is hot coming out without any workload, oth=
er
> >     > times
> >     > I have seen it have barely any fan speed at all and heat up more
> than
> >     > it should at the fan level its curently operating at. These are
> things
> >     > I have seen with this gpu in a TB5 dock with the driver and
> >     > instability. I'm not sure exactly whats going on there but I
> figured
> >     > since im communicating with these patches I might as well bring
> you up
> >     > to speed and supermario has been great help throughout me trying =
to
> >     > get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB=
5
> /
> >     > USB4v2 dock!
> >
> >     Adding Mario as well. That strongly sounds like you crashed the SMU
> which would also explain the failed MODE1 reset.
> >
> >     But all of that are only symptoms. Question is what is actually
> going on here? e.g. what is the root cause?
> >
> >     >
> >     > It seems to be finally working with bar resizing after my kernel
> >     > patch. Which allows you to safely release a empty switch bridge a=
t
> the
> >     > device end.
> >     > Then it rebuilds it afterwords with the increased bar. This was
> done
> >     > on Kernel 7.0-rc7 i believe it is and latest changes from
> pci/resource
> >     > branch with my patch here.
> >     >
> >     >
> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmTh=
xOvk2XUDpEzw@mail.gmail.com/T/#u
> <
> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmTh=
xOvk2XUDpEzw@mail.gmail.com/T/#u
> >
> >
> >     Where is the MMIO register BAR before and after the rebuild?
> >
> >     Regards,
> >     Christian.
> >
> >     >
> >     > Thank you!
> >     >
> >     > Signed-off-by: Geramy Loveless <gloveless@jqluv.com <mailto:
> gloveless@jqluv.com>>
> >     > ---
> >     > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40
> ++++++++++++++++++++++
> >     > 1 file changed, 40 insertions(+)
> >     >
> >     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >     > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >     > index 31a60173c..91d01d538 100644
> >     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >     > @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct
> amdgpu_device *adev)
> >     > /* ensure no_hw_access is updated before we access hw */
> >     > smp_mb();
> >     > + /*
> >     > + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> >     > + * endpoint but the TB tunnel stays up unaware. Detect the
> >     > + * dead link and attempt recovery by resetting parent bridges
> >     > + * to retrain the physical PCIe link inside the dock.
> >     > + */
> >     > + if (!pci_device_is_present(adev->pdev) &&
> >     > + pci_is_thunderbolt_attached(adev->pdev)) {
> >     > + struct pci_dev *bridge;
> >     > + bool recovered =3D false;
> >     > +
> >     > + dev_info(adev->dev,
> >     > + "PCIe link lost after mode1 reset, attempting Thunderbolt
> recovery\n");
> >     > +
> >     > + bridge =3D pci_upstream_bridge(adev->pdev);
> >     > + while (bridge && !pci_is_root_bus(bridge->bus)) {
> >     > + dev_info(adev->dev,
> >     > + "attempting link recovery via %s\n",
> >     > + pci_name(bridge));
> >     > + pci_bridge_secondary_bus_reset(bridge);
> >     > + msleep(100);
> >     > + if (pci_device_is_present(adev->pdev)) {
> >     > + recovered =3D true;
> >     > + break;
> >     > + }
> >     > + bridge =3D pci_upstream_bridge(bridge);
> >     > + }
> >     > +
> >     > + if (!recovered) {
> >     > + dev_err(adev->dev,
> >     > + "Thunderbolt PCIe link recovery failed\n");
> >     > + ret =3D -ENODEV;
> >     > + goto mode1_reset_failed;
> >     > + }
> >     > +
> >     > + dev_info(adev->dev,
> >     > + "Thunderbolt PCIe link recovered via %s\n",
> >     > + pci_name(bridge));
> >     > + }
> >     > +
> >     > amdgpu_device_load_pci_state(adev->pdev);
> >     > ret =3D amdgpu_psp_wait_for_bootloader(adev);
> >     > if (ret)
> >     > --
> >     > 2.51.0
> >
>
>

--0000000000001fd8e1064f06c617
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">=C2=A0Christian,</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">This is going to be very interesting.</div><div dir=3D"auto">So =
the AMD Radeon AI R9700 Pro is running over USB4v2 into a Razor Dock on a 6=
50W power supply I have two of these setups cards provided by AMD for some =
project testing on tb5 rocm ai broadcast messages for testing two machines =
connected over tb5 with rdma sorry if I loose you here. What I am seeing or=
 finding in my opinion is thunderbolt is not very well flushed out on Linux=
 in terms of stability and accessible feature sets. After my kernel pci pat=
ch I have gotten it to work which we went over already.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I have one machine running Qwen3.5 27B A3B =
on the GPU with llamacpp / lemonade successfully but yesterday after attemp=
ting to load the model which it did into vram it crashed which ten minutes =
prior was running a prompt 73k tokens at 40tps. A side note The power manag=
ement on Thunderbolt seems to clash with the power management on the GPU. W=
hat I was seeing is when the GPU doesn=E2=80=99t detect a display it =E2=80=
=9Csuspends=E2=80=9D which may be correct or not but it doesn=E2=80=99t mat=
ter either way in this scenario. The Thunderbolt fabric I believe shuts dow=
n also and kills the link. I got passed this by disabling all PM systems. S=
o I=E2=80=99m not 100% sure what=E2=80=99s going on and how to find the act=
ual problem yet maybe if I spend more time and brain power on this I=E2=80=
=99ll find where in power management it=E2=80=99s having the problem or if =
that=E2=80=99s the real problem. Let me know if you can offer anymore guida=
nce into where I should dig. I appreciate the help this far and the SMU inf=
ormation helps get more context.<br clear=3D"all"><br></div><div dir=3D"aut=
o">On Thu, Apr 9, 2026 at 5:57=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote=
:<br></div><div><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204=
,204)">Hi Geramy,<br>
<br>
On 4/9/26 14:13, Geramy Loveless wrote:<br>
&gt; Hi Christian,<br>
&gt; <br>
&gt; I appreciate the speedy response,<br>
&gt; What your saying makes sense they are basically wrapping symptoms that=
 could at least from what I seen now at this point only continue and eventu=
ally create a web of useless code to try to catch all code paths it hits du=
ring crashing. Let me investigate the real reason as to why it=E2=80=99s cr=
ashing more rather then where.<br>
<br>
To just give you a bit background on what happens here:<br>
<br>
AMD GPUs have an embedded micro controller called SMU which takes care of t=
hings like voltages, clocks, temperature, fan speed etc.. and reset.<br>
<br>
So when the kernel driver detects that it needs to do a reset it sends a MO=
DE1 reset command to the SMU. But instead of the SMU coming back a short ti=
me later noting that the reset was done the device just drops off the bus (=
e.g. all reads return 0xffffffff).<br>
<br>
The cause of that can be anything, e.g. from power fluctuations to a dirty =
fan which doesn&#39;t starts to rotate again after it was stopped.<br>
<br>
I would try to narrow it down step by step, e.g. if it work on older kernel=
s, if yes what feature/patch broke the behavior. You can also try to disabl=
e certain power management features like ASPM (try amdgpu.aspm=3D0 on the k=
ernel command line).<br>
<br>
Hope that helps,<br>
Christian.<br>
<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Apr 9, 2026 at 4:42=E2=80=AFAM Christian K=C3=B6nig &lt;<a hre=
f=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@am=
d.com</a> &lt;mailto:<a href=3D"mailto:christian.koenig@amd.com" target=3D"=
_blank">christian.koenig@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 4/9/26 02:05, Geramy Loveless wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; When an AMD GPU behind a Thunderbolt PCIe tunn=
el undergoes a MODE1 on<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thunderbolt the TB driver receives no notifica=
tion and the tunnel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; stays up while the endpoint is unreachable.<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0IIRC a MODE1 reset should keep the bus active and s=
o the endpoint should still be reachable.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; All subsequent PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; reads return 0xFFFFFFFF and MES firmware canno=
t reinitialize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; triggering an infinite reset loop that hangs t=
he system.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0That sounds more like the MODE1 reset failed.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; After MODE1 reset completes, check whether the=
 PCIe endpoint is still<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; reachable using pci_device_is_present(). If th=
e device is behind<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thunderbolt and the link is dead, walk up pare=
nt bridges calling<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; pci_bridge_secondary_bus_reset() to retrain th=
e physical PCIe link<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; inside the dock.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Well that is then a bus reset.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I mean that is a reasonable mitigation when a MODE1=
 reset failed, but the question is rather why does the MODE1 reset fails in=
 the first place?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; If recovery fails, return -ENODEV to prevent t=
he<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; reset retry loop.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This also causes the GPU fan to be at 100% and=
 basically when it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; happens and you are not there, you now have a =
GPU with fan at 100% and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; cant reset it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I wanted to notate some other things I am find=
ing sometimes before<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; this adventure of patches to the kernel and am=
dgpu driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Sometimes a crash could happen in the drive an=
d then the GPU fan speed<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; hits 100% and the air is hot coming out withou=
t any workload, other<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; times<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I have seen it have barely any fan speed at al=
l and heat up more than<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; it should at the fan level its curently operat=
ing at. These are things<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I have seen with this gpu in a TB5 dock with t=
he driver and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; instability. I&#39;m not sure exactly whats go=
ing on there but I figured<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; since im communicating with these patches I mi=
ght as well bring you up<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to speed and supermario has been great help th=
roughout me trying to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; get the AMD AI R9700 Pro working on my MS-S1 H=
alo Strix with a TB5 /<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; USB4v2 dock!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Adding Mario as well. That strongly sounds like you=
 crashed the SMU which would also explain the failed MODE1 reset.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But all of that are only symptoms. Question is what=
 is actually going on here? e.g. what is the root cause?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; It seems to be finally working with bar resizi=
ng after my kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; patch. Which allows you to safely release a em=
pty switch bridge at the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; device end.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Then it rebuilds it afterwords with the increa=
sed bar. This was done<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; on Kernel 7.0-rc7 i believe it is and latest c=
hanges from pci/resource<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; branch with my patch here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://lore.kernel.org/linux-pci/C=
AGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u" rel=
=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/linux-pci/CAGpo2m=
eKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u</a> &lt;<a=
 href=3D"https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8U=
BF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u" rel=3D"noreferrer" target=3D"_blan=
k">https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmT=
hxOvk2XUDpEzw@mail.gmail.com/T/#u</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Where is the MMIO register BAR before and after the=
 rebuild?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0Christian.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thank you!<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Geramy Loveless &lt;<a href=3D"=
mailto:gloveless@jqluv.com" target=3D"_blank">gloveless@jqluv.com</a> &lt;m=
ailto:<a href=3D"mailto:gloveless@jqluv.com" target=3D"_blank">gloveless@jq=
luv.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4=
0 ++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 1 file changed, 40 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=
_device.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 31a60173c..91d01d538 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1=
_reset(struct amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; /* ensure no_hw_access is updated before we ac=
cess hw */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; smp_mb();<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * On Thunderbolt-attached GPUs, MODE1 reset =
kills the PCIe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * endpoint but the TB tunnel stays up unawar=
e. Detect the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * dead link and attempt recovery by resettin=
g parent bridges<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + * to retrain the physical PCIe link inside t=
he dock.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + if (!pci_device_is_present(adev-&gt;pdev) &a=
mp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + pci_is_thunderbolt_attached(adev-&gt;pdev)) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + struct pci_dev *bridge;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + bool recovered =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + dev_info(adev-&gt;dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + &quot;PCIe link lost after mode1 reset, atte=
mpting Thunderbolt recovery\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + bridge =3D pci_upstream_bridge(adev-&gt;pdev=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + while (bridge &amp;&amp; !pci_is_root_bus(br=
idge-&gt;bus)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + dev_info(adev-&gt;dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + &quot;attempting link recovery via %s\n&quot=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + pci_name(bridge));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + pci_bridge_secondary_bus_reset(bridge);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + msleep(100);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + if (pci_device_is_present(adev-&gt;pdev)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + recovered =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + bridge =3D pci_upstream_bridge(bridge);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + if (!recovered) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + dev_err(adev-&gt;dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + &quot;Thunderbolt PCIe link recovery failed\=
n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + ret =3D -ENODEV;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + goto mode1_reset_failed;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + dev_info(adev-&gt;dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + &quot;Thunderbolt PCIe link recovered via %s=
\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + pci_name(bridge));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; + }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; amdgpu_device_load_pci_state(adev-&gt;pdev);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ret =3D amdgpu_psp_wait_for_bootloader(adev);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.51.0<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000001fd8e1064f06c617--
