Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C1FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B4464E3E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B4464E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B771F6E200;
	Thu, 11 Feb 2021 21:12:04 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9675D6E200
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:12:03 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id q2so8406277eds.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2WOChJtEGcYy1e7iLC67EGoDfEjUUo/ZwOaLl4WMNAo=;
 b=YcU4eWN9pwVPBsZzu4dyJoz1GrjDx9j7OqGragC5Ta9g1qvLajQdbNZLSIeltMenai
 UKQBkMIva/wVP505t6x3vhRkGumDdvyPSSsUZH2Xdqdp8VBtwyaQs10Onexi0Rpz3mki
 OUC/nLxfHoRLefW+QrT7FcPddWBxtaMwCa+nyhKiiX+iOih4DtPXMmZGOl6yugVD3hU+
 UCt06eIp7sMvATUkcKcdbg2CY31w2+nyF8/+bPIrUw2U02wDyVvLBVlvixOSTYVQtJoY
 L4YhnSC9coElLfhULA//XEIMtGrOoJtj27rg4CKp3juLyibC5liwiCiSr/Yhsnd1Pb9f
 57RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2WOChJtEGcYy1e7iLC67EGoDfEjUUo/ZwOaLl4WMNAo=;
 b=BzPXDwJParhRbWwfDxmV52AkLLS0O1+x4ETU3duZZvcvonpI+QLEYwE/pqlCKkm651
 sh0GZ42khyOG4GpXQUvWPW687bRWXgHc15cWYLnqxNam1Z4QN97ajuqGJ0J1NAiQPEC7
 p0mI+tOINeV+Ws+lugWJGBFYlJoefVTakJ+ibO1x0VU6MGm4nI6LrmiAmrcu2y/jqzMv
 zlDUyIar+ToY7evGT3e3iwBmVv6A88Flz23IIJFwDKI5IfNsJ0wAeh7rSVi5k41niLdo
 X2tPRPsBRqGAAqeQ4n7GuQTrk4AeRZTnl5U6sOWEKRvE5XfxAby/MuM2FqgW7VDlWXHf
 sojA==
X-Gm-Message-State: AOAM53374uW1P58tLXigu5Q2wAtCU46utgD6ZDVMxSb3s32oQtS4dU0c
 dTvUuAx/ReERWIbliRRCB9FTs8pZJuZeAjOdhwE=
X-Google-Smtp-Source: ABdhPJwcJoy7Q87ya/pkIyqpIsksHXmmMHiZb6uddSklZ2/1wgzEMzSt+JPHkV7ZZfMucwZrUwbC6i/0oENkusX4ItY=
X-Received: by 2002:a50:d4d9:: with SMTP id e25mr28356edj.183.1613077922233;
 Thu, 11 Feb 2021 13:12:02 -0800 (PST)
MIME-Version: 1.0
References: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
 <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
 <CADnq5_NdULq_V79O01UprBdfL1V=dUsvTjXS5jaGv=bJB66J_Q@mail.gmail.com>
In-Reply-To: <CADnq5_NdULq_V79O01UprBdfL1V=dUsvTjXS5jaGv=bJB66J_Q@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Thu, 11 Feb 2021 22:11:50 +0100
Message-ID: <CAEsyxyjmHfnc-w1jsJAxL8Zw5W1R9AiiUYd1-taKxX3Q3BfWfA@mail.gmail.com>
Subject: Re: Why no spatial dithering to 10 bit depth on DCE?
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1180828891=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1180828891==
Content-Type: multipart/alternative; boundary="0000000000008cc15405bb15f87d"

--0000000000008cc15405bb15f87d
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 10, 2021 at 10:36 PM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner
> <mario.kleiner.de@gmail.com> wrote:
> >
> > Resending this one as well, in the hope of some clarification or
> background information.
> >
>
>
Thanks Alex.

I suspect this may have been a limitation from DCE11.0 (E.g.,
> carrizo/stoney APUs).  They had some bandwidth limitations with
> respect to high bit depth IIRC.  I suspect it should be fine on the
> relevant dGPUs.  The code was probably originally added for the APUs
>

That sounds as if it would make sense for me to try to submit a patch to
you that restricts this limitation to DCE 11.0 only?

All i can say is during my testing with DCE-8.3 over HDMI and DCE-11.2 over
DP under amdvlk with fp16 mode and ouptut_bpc set to 10 bpc, ie. dithering
down from 12 bpc to 10 bpc, i didn't notice any problems when hacking this
out, and photometer measurements showed good improvements of luminance
reproduction with dithering.

and just never updated or the changes were accidentally lost when we
> consolidated the DCE code.  Unfortunately, there are not a lot of apps
> that work properly in Linux with >8 bits per channel.
>
>
Mine does ;-). As does apparently the Kodi media player. And at least
Gnome/X11 works now, whereas KDE's Kwin/X11 used to work nicely, but
regressed. And amdvlk does have fp16 support now since a while ago, so
that's one way to get high precision without disturbing conventional
desktop apps. I'll probably look into Mesa's Vulkan/WSI for 10 bpc / fp16
sometime this year if nobody beats me to it.

-mario


Alex
>
>
> > Thanks,
> > -mario
> >
> > On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner <
> mario.kleiner.de@gmail.com> wrote:
> >>
> >> Hi Harry and Nicholas,
> >>
> >> I'm still on an extended quest to squeeze as much HDR out of Linux +
> your hw as possible, although the paid contract with Vesa has officially
> ended by now, and stumbled over this little conundrum:
> >>
> >> DC's set_spatial_dither() function (see link below) has this particular
> comment:
> >> "/* no 10bpc on DCE11*/" followed by code that skips dithering setup if
> the target output depth is 10 bpc:
> >>
> >>
> https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219
> >>
> >> I couldn't find any hint in the commit messages towards the reason, so
> why is that?
> >>
> >> This gets in the way if one has a HDR-10 monitor with 10 bit native
> output depth connected and wants to output a fp16 framebuffer and retain
> some of the > 10 bit linear precision by use of spatial dithering down to
> 10 bit. One only gets the same precision as a 10 bpc unorm fb. Also the
> routine is called for all DCE's, not only DCE11, so it affects all of them.
> >>
> >> The same restrictions don't exist in the old kms code for amdgpu-kms
> and radeon-kms. I added a mmio hack to Psychtoolbox to go behind the
> drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial
> dithering down to 10 bpc anyway to circumvent this limitation. My
> photometer measurements on fp16 framebuffers feeding into 10 bit output
> show that I get a nice looking response consistent with dithering to 10 bpc
> properly working on DCE. Also i don't see any visual artifacts in displayed
> pictures, so the hw seems to be just fine. This on DCE-11.2, and more
> lightly tested on DCE-8.3.
> >>
> >> So i wonder if this is some leftover from some hw bringup, or if there
> is a good reason for it being there? Maybe it could be removed or made more
> specific to some problematic asic?
> >>
> >> Thanks for any insights you could provide. Stay safe,
> >> -mario
> >>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008cc15405bb15f87d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Feb 10, 2021 at 10:36 PM Alex Deu=
cher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>=
&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner<br>
&lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mario.k=
leiner.de@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Resending this one as well, in the hope of some clarification or backg=
round information.<br>
&gt;<br>
<br></blockquote><div><br></div><div>Thanks Alex.</div><div> <br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
I suspect this may have been a limitation from DCE11.0 (E.g.,<br>
carrizo/stoney APUs).=C2=A0 They had some bandwidth limitations with<br>
respect to high bit depth IIRC.=C2=A0 I suspect it should be fine on the<br=
>
relevant dGPUs.=C2=A0 The code was probably originally added for the APUs<b=
r>
</blockquote><div><br></div><div>That sounds as if it would make sense for =
me to try to submit a patch to you that restricts this limitation to DCE 11=
.0 only?</div><div><br></div><div>All i can say is during my testing with D=
CE-8.3 over HDMI and DCE-11.2 over DP under amdvlk with fp16 mode and ouptu=
t_bpc set to 10 bpc, ie. dithering down from 12 bpc to 10 bpc, i didn&#39;t=
 notice any problems when hacking this out, and photometer measurements sho=
wed good improvements of luminance reproduction with dithering.</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">and just never u=
pdated or the changes were accidentally lost when we<br>
consolidated the DCE code.=C2=A0 Unfortunately, there are not a lot of apps=
<br>
that work properly in Linux with &gt;8 bits per channel.<br>
<br></blockquote><div><br></div><div>Mine does ;-). As does apparently the =
Kodi media player. And at least Gnome/X11 works now, whereas KDE&#39;s Kwin=
/X11 used to work nicely, but regressed.  And amdvlk does have fp16 support=
 now since a while ago, so that&#39;s one way to get high precision without=
 disturbing conventional desktop apps. I&#39;ll probably look into Mesa&#39=
;s Vulkan/WSI for 10 bpc / fp16 sometime this year if nobody beats me to it=
.<br></div><div><br></div><div>-mario</div><div><br></div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
Alex<br>
<br>
<br>
&gt; Thanks,<br>
&gt; -mario<br>
&gt;<br>
&gt; On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner &lt;<a href=3D"mailto:ma=
rio.kleiner.de@gmail.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&=
gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Harry and Nicholas,<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m still on an extended quest to squeeze as much HDR out of L=
inux + your hw as possible, although the paid contract with Vesa has offici=
ally ended by now, and stumbled over this little conundrum:<br>
&gt;&gt;<br>
&gt;&gt; DC&#39;s set_spatial_dither() function (see link below) has this p=
articular comment:<br>
&gt;&gt; &quot;/* no 10bpc on DCE11*/&quot; followed by code that skips dit=
hering setup if the target output depth is 10 bpc:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://elixir.bootlin.com/linux/v5.11-rc4/source/drive=
rs/gpu/drm/amd/display/dc/dce/dce_opp.c#L219" rel=3D"noreferrer" target=3D"=
_blank">https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/a=
md/display/dc/dce/dce_opp.c#L219</a><br>
&gt;&gt;<br>
&gt;&gt; I couldn&#39;t find any hint in the commit messages towards the re=
ason, so why is that?<br>
&gt;&gt;<br>
&gt;&gt; This gets in the way if one has a HDR-10 monitor with 10 bit nativ=
e output depth connected and wants to output a fp16 framebuffer and retain =
some of the &gt; 10 bit linear precision by use of spatial dithering down t=
o 10 bit. One only gets the same precision as a 10 bpc unorm fb. Also the r=
outine is called for all DCE&#39;s, not only DCE11, so it affects all of th=
em.<br>
&gt;&gt;<br>
&gt;&gt; The same restrictions don&#39;t exist in the old kms code for amdg=
pu-kms and radeon-kms. I added a mmio hack to Psychtoolbox to go behind the=
 drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial di=
thering down to 10 bpc anyway to circumvent this limitation. My photometer =
measurements on fp16 framebuffers feeding into 10 bit output show that I ge=
t a nice looking response consistent with dithering to 10 bpc properly work=
ing on DCE. Also i don&#39;t see any visual artifacts in displayed pictures=
, so the hw seems to be just fine. This on DCE-11.2, and more lightly teste=
d on DCE-8.3.<br>
&gt;&gt;<br>
&gt;&gt; So i wonder if this is some leftover from some hw bringup, or if t=
here is a good reason for it being there? Maybe it could be removed or made=
 more specific to some problematic asic?<br>
&gt;&gt;<br>
&gt;&gt; Thanks for any insights you could provide. Stay safe,<br>
&gt;&gt; -mario<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--0000000000008cc15405bb15f87d--

--===============1180828891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1180828891==--
