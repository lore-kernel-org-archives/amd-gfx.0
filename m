Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07932E9904C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B01210E8CC;
	Fri, 10 Apr 2026 07:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="PNWaiztM";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D5010E7DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:13:54 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-50d8e11b948so8454121cf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 05:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775736833; cv=none;
 d=google.com; s=arc-20240605;
 b=ka/YYoo7iAP8SKSUsMeV5/MfF53YUkuZWytD2TGb/AJEECVDQevJu3VOTiOp+wxNOz
 w7HGsUJ5Ea48de1k0E1CB/UxKQEluuewaIgCbeaKxG0FUmDrAi4w6KXDYL9tWqAEAPeS
 VFvfhP93sgKTZVe2NUaoAbNCuaD1ecwvPv9G2JmzoCoahIM6qn69E/wExxKsPTppzJ9I
 PY/+qTjgaHWtDMc0TYwrGvqKJSNLHU8aZQsE+1S/iAgUQX1ojO3MZ1oK1II5z6oy3ZpG
 UHu+66FOZ56fqRPj4m7eCydKD4ss81fxvGVoHlO+fZk3yf+68EWJKD3S5RUrohwOAlD5
 uNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8XI/sPMA2Y1qplZwSGgrreTsObuPXAfJOT2DUvQs6OM=;
 fh=3mxbbTVKDqPLGS2fD+N9WVhtNN2dfHXY07YXYDEWkfA=;
 b=ZQmBVJj+hCOO3bm4h4kDolrRIxEaSeg/ixylqwnHwCaFomcnKxBs8mkwiAkbf0giEH
 ypYAEY+OPL1GA+gUdN2fJgdqhzhKNaY4svqbLiac5VXso3wDaTht9OTDoGpFr2qUDktj
 16gzNPRSKJBxaV05GCpkBYKBLz9iIoUuFetDB+46M8ilb/6b/wwtuoKROQlD2iNTv9BV
 bO0R6wNUq7s4qeE3iCy7tLEHsncPoDriH12X2/qfCoOOyV/2KREtY5ISphA/JdKa73Fk
 CuaQtBN4a0gQfmG9jhFDwCPgG3neB3I5fX5inWwoVNWuE+jkraJ3HzPKwRugaqZVjseK
 +e7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775736833; x=1776341633;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8XI/sPMA2Y1qplZwSGgrreTsObuPXAfJOT2DUvQs6OM=;
 b=PNWaiztMcyfDLugbQTbcwxkDO9RuL/GR8J0VHJ+Pi3/ORTlbUt5ySVYX0orfW4GVj6
 InvhpIc4SqayTtfHHw9XuUY1bFehEnKAfk8keewODrgbLYALd9qu9fuxx/ZCxYgOS/EB
 klhzGuOS20I3jYaTxlXG4ja4FBSVAKizfQv4qKpmzJisavD+yCh8ZUM0nHXwXTjMQQyc
 smCXcZ1D8SOOeIaZxxhms5R6x4vjH9CSk1dAP1p/6BH/ZzLxlu+BJSRMqCFyCsphEAfo
 sb8OyXjWNtnpu7FegrWGf/Ft7XufiDRhlTI/EfHFqnmq6hjQIDN+E5ccDrAohm5SOl7u
 +f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775736833; x=1776341633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XI/sPMA2Y1qplZwSGgrreTsObuPXAfJOT2DUvQs6OM=;
 b=LNhRaN9D669GA9H5giXJOaePRgLuJwmnuXA24xb9dqAUBj6RYjuOpySszKl7IiHdOb
 K48z0mcA7W3gTwVwVeyL0PML21subONn+5vlmcqbgEtd2WFIDzrJm3cWCmxMC6rQ3XD3
 87GcszI2DqEwbChbRLwEY8+Q49HIpqqLKCPG4fccQ1owS1xRRfsgw3AOb9ACuYxOGn3A
 U9E1gIMIbFlll5SUQBY8ewiUEHNEaFqsFQVVb7iG/5U43G4nt/YEwFM90IOPxbOj7/gc
 JBgt+hA18mcqml53PCHNpaGFpPVzvXcwkecw4zSW1XNn+UGkIircJp31rkOjOrBIEQWD
 Jwyg==
X-Gm-Message-State: AOJu0YwSf1r7haYkW6LKk5PYVrTHlDEQAJuBpY4SzByzxCiwuONN9Eiz
 /f7Jhn3nsSuGdZOOicTrPyKuQd2+0Fqvk8+1FT+8mJ4O+d29zPXReWj5A9b6IhEnQ+xPeKp7XSr
 2faPbfHZEBjbPmSqgRjgQARmXH3VlH0T1BYltYsz87g==
X-Gm-Gg: AeBDiesOzKeXBKiJmIgf/m1TG2wu7ix7g217V7Ja4TdP9ziIR7CgUz7kL+l1+cimsN8
 lhMpumXZLH/L/P+8BYcXT2vYo27/gf6GF3ukcvaTimQnx0xlW007+O91OWuFUQGc/I4xHhSinga
 uwxGpxWt91GqWIShCWbab8Mm3dQogFl6eeUPxJMrQUqs9sGhxbEWFja/54gMxNNZpCmrAkddkwK
 wF4LHiV5cxj3CHgZK8m7hnbgDln/zvOfDB7sEVoiH9zYQImdseG5tgqATLkn/kifi9s5caEV7Fm
 j7GxM7ILdt/xb3xPIEAZ0CDFeieC0JczanDM7Q==
X-Received: by 2002:a05:622a:5d0f:b0:50d:bc78:5ff6 with SMTP id
 d75a77b69052e-50dbc78892dmr57051571cf.61.1775736832787; Thu, 09 Apr 2026
 05:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
In-Reply-To: <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Thu, 9 Apr 2026 05:13:41 -0700
X-Gm-Features: AQROBzCkoeAT5jrWaUBRhvjxiHJPQriZ0HlTPPfBazZkvIXv481WVcBB20dr7VI
Message-ID: <CAGpo2mcLFMrkduCx1MuQnR3EZUxtEo+jT8PAXGgXbGDm2_1Now@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>, alexander.deucher@amd.com
Content-Type: multipart/alternative; boundary="00000000000022201d064f05f33f"
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

--00000000000022201d064f05f33f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I appreciate the speedy response,
What your saying makes sense they are basically wrapping symptoms that
could at least from what I seen now at this point only continue and
eventually create a web of useless code to try to catch all code paths it
hits during crashing. Let me investigate the real reason as to why it=E2=80=
=99s
crashing more rather then where.


On Thu, Apr 9, 2026 at 4:42=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> On 4/9/26 02:05, Geramy Loveless wrote:
> > When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
> > Thunderbolt the TB driver receives no notification and the tunnel
> > stays up while the endpoint is unreachable.
>
> IIRC a MODE1 reset should keep the bus active and so the endpoint should
> still be reachable.
>
> > All subsequent PCIe
> > reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> > triggering an infinite reset loop that hangs the system.
>
> That sounds more like the MODE1 reset failed.
>
> > After MODE1 reset completes, check whether the PCIe endpoint is still
> > reachable using pci_device_is_present(). If the device is behind
> > Thunderbolt and the link is dead, walk up parent bridges calling
> > pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
> > inside the dock.
>
> Well that is then a bus reset.
>
> I mean that is a reasonable mitigation when a MODE1 reset failed, but the
> question is rather why does the MODE1 reset fails in the first place?
>
> > If recovery fails, return -ENODEV to prevent the
> > reset retry loop.
> >
> > This also causes the GPU fan to be at 100% and basically when it
> > happens and you are not there, you now have a GPU with fan at 100% and
> > cant reset it.
> > I wanted to notate some other things I am finding sometimes before
> > this adventure of patches to the kernel and amdgpu driver.
> > Sometimes a crash could happen in the drive and then the GPU fan speed
> > hits 100% and the air is hot coming out without any workload, other
> > times
> > I have seen it have barely any fan speed at all and heat up more than
> > it should at the fan level its curently operating at. These are things
> > I have seen with this gpu in a TB5 dock with the driver and
> > instability. I'm not sure exactly whats going on there but I figured
> > since im communicating with these patches I might as well bring you up
> > to speed and supermario has been great help throughout me trying to
> > get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
> > USB4v2 dock!
>
> Adding Mario as well. That strongly sounds like you crashed the SMU which
> would also explain the failed MODE1 reset.
>
> But all of that are only symptoms. Question is what is actually going on
> here? e.g. what is the root cause?
>
> >
> > It seems to be finally working with bar resizing after my kernel
> > patch. Which allows you to safely release a empty switch bridge at the
> > device end.
> > Then it rebuilds it afterwords with the increased bar. This was done
> > on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
> > branch with my patch here.
> >
> >
> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmTh=
xOvk2XUDpEzw@mail.gmail.com/T/#u
>
> Where is the MMIO register BAR before and after the rebuild?
>
> Regards,
> Christian.
>
> >
> > Thank you!
> >
> > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > ---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 31a60173c..91d01d538 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct
> amdgpu_device *adev)
> > /* ensure no_hw_access is updated before we access hw */
> > smp_mb();
> > + /*
> > + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> > + * endpoint but the TB tunnel stays up unaware. Detect the
> > + * dead link and attempt recovery by resetting parent bridges
> > + * to retrain the physical PCIe link inside the dock.
> > + */
> > + if (!pci_device_is_present(adev->pdev) &&
> > + pci_is_thunderbolt_attached(adev->pdev)) {
> > + struct pci_dev *bridge;
> > + bool recovered =3D false;
> > +
> > + dev_info(adev->dev,
> > + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n"=
);
> > +
> > + bridge =3D pci_upstream_bridge(adev->pdev);
> > + while (bridge && !pci_is_root_bus(bridge->bus)) {
> > + dev_info(adev->dev,
> > + "attempting link recovery via %s\n",
> > + pci_name(bridge));
> > + pci_bridge_secondary_bus_reset(bridge);
> > + msleep(100);
> > + if (pci_device_is_present(adev->pdev)) {
> > + recovered =3D true;
> > + break;
> > + }
> > + bridge =3D pci_upstream_bridge(bridge);
> > + }
> > +
> > + if (!recovered) {
> > + dev_err(adev->dev,
> > + "Thunderbolt PCIe link recovery failed\n");
> > + ret =3D -ENODEV;
> > + goto mode1_reset_failed;
> > + }
> > +
> > + dev_info(adev->dev,
> > + "Thunderbolt PCIe link recovered via %s\n",
> > + pci_name(bridge));
> > + }
> > +
> > amdgpu_device_load_pci_state(adev->pdev);
> > ret =3D amdgpu_psp_wait_for_bootloader(adev);
> > if (ret)
> > --
> > 2.51.0
>
>

--00000000000022201d064f05f33f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Christian,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I appreciate the speedy response,</div><div dir=3D"auto">What you=
r saying makes sense they are basically wrapping symptoms that could at lea=
st from what I seen now at this point only continue and eventually create a=
 web of useless code to try to catch all code paths it hits during crashing=
. Let me investigate the real reason as to why it=E2=80=99s crashing more r=
ather then where.</div><div><br></div><div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 9, 2=
026 at 4:42=E2=80=AFAM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian=
.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,20=
4,204)">On 4/9/26 02:05, Geramy Loveless wrote:<br>
&gt; When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on<=
br>
&gt; Thunderbolt the TB driver receives no notification and the tunnel<br>
&gt; stays up while the endpoint is unreachable.<br>
<br>
IIRC a MODE1 reset should keep the bus active and so the endpoint should st=
ill be reachable.<br>
<br>
&gt; All subsequent PCIe<br>
&gt; reads return 0xFFFFFFFF and MES firmware cannot reinitialize,<br>
&gt; triggering an infinite reset loop that hangs the system.<br>
<br>
That sounds more like the MODE1 reset failed.<br>
<br>
&gt; After MODE1 reset completes, check whether the PCIe endpoint is still<=
br>
&gt; reachable using pci_device_is_present(). If the device is behind<br>
&gt; Thunderbolt and the link is dead, walk up parent bridges calling<br>
&gt; pci_bridge_secondary_bus_reset() to retrain the physical PCIe link<br>
&gt; inside the dock.<br>
<br>
Well that is then a bus reset.<br>
<br>
I mean that is a reasonable mitigation when a MODE1 reset failed, but the q=
uestion is rather why does the MODE1 reset fails in the first place?<br>
<br>
&gt; If recovery fails, return -ENODEV to prevent the<br>
&gt; reset retry loop.<br>
&gt; <br>
&gt; This also causes the GPU fan to be at 100% and basically when it<br>
&gt; happens and you are not there, you now have a GPU with fan at 100% and=
<br>
&gt; cant reset it.<br>
&gt; I wanted to notate some other things I am finding sometimes before<br>
&gt; this adventure of patches to the kernel and amdgpu driver.<br>
&gt; Sometimes a crash could happen in the drive and then the GPU fan speed=
<br>
&gt; hits 100% and the air is hot coming out without any workload, other<br=
>
&gt; times<br>
&gt; I have seen it have barely any fan speed at all and heat up more than<=
br>
&gt; it should at the fan level its curently operating at. These are things=
<br>
&gt; I have seen with this gpu in a TB5 dock with the driver and<br>
&gt; instability. I&#39;m not sure exactly whats going on there but I figur=
ed<br>
&gt; since im communicating with these patches I might as well bring you up=
<br>
&gt; to speed and supermario has been great help throughout me trying to<br=
>
&gt; get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /<b=
r>
&gt; USB4v2 dock!<br>
<br>
Adding Mario as well. That strongly sounds like you crashed the SMU which w=
ould also explain the failed MODE1 reset.<br>
<br>
But all of that are only symptoms. Question is what is actually going on he=
re? e.g. what is the root cause?<br>
<br>
&gt; <br>
&gt; It seems to be finally working with bar resizing after my kernel<br>
&gt; patch. Which allows you to safely release a empty switch bridge at the=
<br>
&gt; device end.<br>
&gt; Then it rebuilds it afterwords with the increased bar. This was done<b=
r>
&gt; on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource=
<br>
&gt; branch with my patch here.<br>
&gt; <br>
&gt; <a href=3D"https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbE=
SLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqd=
F8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u</a><br>
<br>
Where is the MMIO register BAR before and after the rebuild?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; <br>
&gt; Thank you!<br>
&gt; <br>
&gt; Signed-off-by: Geramy Loveless &lt;<a href=3D"mailto:gloveless@jqluv.c=
om" target=3D"_blank">gloveless@jqluv.com</a>&gt;<br>
&gt; ---<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++=
<br>
&gt; 1 file changed, 40 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 31a60173c..91d01d538 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_dev=
ice *adev)<br>
&gt; /* ensure no_hw_access is updated before we access hw */<br>
&gt; smp_mb();<br>
&gt; + /*<br>
&gt; + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe<br>
&gt; + * endpoint but the TB tunnel stays up unaware. Detect the<br>
&gt; + * dead link and attempt recovery by resetting parent bridges<br>
&gt; + * to retrain the physical PCIe link inside the dock.<br>
&gt; + */<br>
&gt; + if (!pci_device_is_present(adev-&gt;pdev) &amp;&amp;<br>
&gt; + pci_is_thunderbolt_attached(adev-&gt;pdev)) {<br>
&gt; + struct pci_dev *bridge;<br>
&gt; + bool recovered =3D false;<br>
&gt; +<br>
&gt; + dev_info(adev-&gt;dev,<br>
&gt; + &quot;PCIe link lost after mode1 reset, attempting Thunderbolt recov=
ery\n&quot;);<br>
&gt; +<br>
&gt; + bridge =3D pci_upstream_bridge(adev-&gt;pdev);<br>
&gt; + while (bridge &amp;&amp; !pci_is_root_bus(bridge-&gt;bus)) {<br>
&gt; + dev_info(adev-&gt;dev,<br>
&gt; + &quot;attempting link recovery via %s\n&quot;,<br>
&gt; + pci_name(bridge));<br>
&gt; + pci_bridge_secondary_bus_reset(bridge);<br>
&gt; + msleep(100);<br>
&gt; + if (pci_device_is_present(adev-&gt;pdev)) {<br>
&gt; + recovered =3D true;<br>
&gt; + break;<br>
&gt; + }<br>
&gt; + bridge =3D pci_upstream_bridge(bridge);<br>
&gt; + }<br>
&gt; +<br>
&gt; + if (!recovered) {<br>
&gt; + dev_err(adev-&gt;dev,<br>
&gt; + &quot;Thunderbolt PCIe link recovery failed\n&quot;);<br>
&gt; + ret =3D -ENODEV;<br>
&gt; + goto mode1_reset_failed;<br>
&gt; + }<br>
&gt; +<br>
&gt; + dev_info(adev-&gt;dev,<br>
&gt; + &quot;Thunderbolt PCIe link recovered via %s\n&quot;,<br>
&gt; + pci_name(bridge));<br>
&gt; + }<br>
&gt; +<br>
&gt; amdgpu_device_load_pci_state(adev-&gt;pdev);<br>
&gt; ret =3D amdgpu_psp_wait_for_bootloader(adev);<br>
&gt; if (ret)<br>
&gt; --<br>
&gt; 2.51.0<br>
<br>
</blockquote></div></div>

--00000000000022201d064f05f33f--
