Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4289C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 22:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7B064DF2
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 22:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7B064DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244126F3A2;
	Fri, 12 Feb 2021 22:36:02 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE67D6F3A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 22:36:00 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id i8so1732343ejc.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 14:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6OAUuxsxKY0lwjV0hqdI/wo82AnCuT/RJhUaX2kVOac=;
 b=t+uPqT0DgZzZ7VFSUSM3IZVavCxn6LMoImc5TTaAPe1KhW4yv7SXDhUL5Rq0IgazgY
 QK8KOQE+YnRj6c+hM41o8VueKgfhx6ELhyW+UUSdHJgbcZtlGw3D/7xOZovZgklXWb8K
 QwUIBxs8UMwfSOaeCYGdmigy8qYnabIfqtjGKSFAsH47KoVaVQvSXhRZ8wNqQ5AtE18z
 MIUMrwQaQ5FgeJH9hgoDqPK61i568NGPMJDgtLdC1j4/FHUVDPdLSWj4E1hgf2z1jNy8
 Jbn9jfj4oIoZo9a3pvZBkvrfEocePufX/y4YX5D4YFFygumsDIkLrUp3DY5wBGSr6l0Y
 O+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6OAUuxsxKY0lwjV0hqdI/wo82AnCuT/RJhUaX2kVOac=;
 b=MCBSsU5/XnuEFpP/pYod8FSUFV2ybSCDTEwzISzZShksFyNEyfdgVx6zakXfb39ylt
 8NlVWBKw9Ggy7XREo9XIQFwe65REYm9R7byradfY1Q5FgijuMZUWH7ywufC6JYoeMoqM
 22ZzGXUBbS+SMLLnJGBQs2c2hL2CsXts/7BEOydfiQgH3Ro8n67cMMauJMdNm2/O/YG0
 C6e/gKBmJDNFBLnJDOIyHNDMwU4/6rzbgFhcrU5IzYRiuS5UlGah7rZCCwmNQhbPSu9i
 tPwlQfJ+wVP+VDLQP8dcR6HOtoIa5YW/h5unmmf0gxTR+lKhP0pJO0COwadsmyKIjlwD
 rH4w==
X-Gm-Message-State: AOAM533opa70T1VmWpq8vEbkZxn7QDfdJYKa3vxFa/We54JBbFwWM382
 fBpfSWBovBvDYzWJMgkspwDKfJGHlk2nODIYN1g=
X-Google-Smtp-Source: ABdhPJzFDLXi7d74misF+sd+2+NYTTijCAHz3oEvnNDRhVMjJdQ+ug/Z8JMllXw9PEhHE4Gl/s1H4BpChM2diBcM9QQ=
X-Received: by 2002:a17:906:e104:: with SMTP id
 gj4mr5022964ejb.349.1613169359566; 
 Fri, 12 Feb 2021 14:35:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEsyxyj9ArbpxWQttLhBZzU1mR_Fz=hRt1p52yMuwdmToZwuGA@mail.gmail.com>
 <CAEsyxyjPUmXGWpQDbr6E0Wccd0PvxATLPoZKE0zZ1gwPZSoLAQ@mail.gmail.com>
 <CADnq5_NdULq_V79O01UprBdfL1V=dUsvTjXS5jaGv=bJB66J_Q@mail.gmail.com>
 <CAEsyxyjmHfnc-w1jsJAxL8Zw5W1R9AiiUYd1-taKxX3Q3BfWfA@mail.gmail.com>
 <CADnq5_NpZdTRBfvUxFy=7Z5OSDUJKmiE++U2jsnLHM6BJ4FAfA@mail.gmail.com>
In-Reply-To: <CADnq5_NpZdTRBfvUxFy=7Z5OSDUJKmiE++U2jsnLHM6BJ4FAfA@mail.gmail.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 12 Feb 2021 23:35:47 +0100
Message-ID: <CAEsyxyi=cAQEyLEwuzWg0QGvokS01GvK5nfji4uiqqMAAAH+aQ@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1783380791=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1783380791==
Content-Type: multipart/alternative; boundary="000000000000a3bb7605bb2b42d4"

--000000000000a3bb7605bb2b42d4
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 12, 2021 at 6:32 AM Alex Deucher <alexdeucher@gmail.com> wrote:

> On Thu, Feb 11, 2021 at 4:12 PM Mario Kleiner
> <mario.kleiner.de@gmail.com> wrote:
> >
> > On Wed, Feb 10, 2021 at 10:36 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >>
> >> On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner
> >> <mario.kleiner.de@gmail.com> wrote:
> >> >
> >> > Resending this one as well, in the hope of some clarification or
> background information.
> >> >
> >>
> >
> > Thanks Alex.
> >
> >> I suspect this may have been a limitation from DCE11.0 (E.g.,
> >> carrizo/stoney APUs).  They had some bandwidth limitations with
> >> respect to high bit depth IIRC.  I suspect it should be fine on the
> >> relevant dGPUs.  The code was probably originally added for the APUs
> >
> >
> > That sounds as if it would make sense for me to try to submit a patch to
> you that restricts this limitation to DCE 11.0 only?
>
> I suspect older DCE 8.x APUs have similar limitations.  Although it
> may only be an issue with multiple monitors or something like that.  I
> don't remember the details.  @Harry Wentland do you remember?
>
> >
>

Fwiw, the tested DCE-8.3 was a mullins APU, at least that one was fine,
although only testable with 10 bpc HDMI + 6 bpc eDP, the only available
outputs.

I just sent out a patch to restrict the dithering restriction to DCE-11.0.
Successfully retested on DCE-11.2 via DP for extra care.

Have a nice weekend,
-mario


> All i can say is during my testing with DCE-8.3 over HDMI and DCE-11.2
> over DP under amdvlk with fp16 mode and ouptut_bpc set to 10 bpc, ie.
> dithering down from 12 bpc to 10 bpc, i didn't notice any problems when
> hacking this out, and photometer measurements showed good improvements of
> luminance reproduction with dithering.
> >
> >> and just never updated or the changes were accidentally lost when we
> >> consolidated the DCE code.  Unfortunately, there are not a lot of apps
> >> that work properly in Linux with >8 bits per channel.
> >>
> >
> > Mine does ;-). As does apparently the Kodi media player. And at least
> Gnome/X11 works now, whereas KDE's Kwin/X11 used to work nicely, but
> regressed. And amdvlk does have fp16 support now since a while ago, so
> that's one way to get high precision without disturbing conventional
> desktop apps. I'll probably look into Mesa's Vulkan/WSI for 10 bpc / fp16
> sometime this year if nobody beats me to it.
> >
>
> Sounds good.
>
> Alex
>
> > -mario
> >
> >
> >> Alex
> >>
> >>
> >> > Thanks,
> >> > -mario
> >> >
> >> > On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner <
> mario.kleiner.de@gmail.com> wrote:
> >> >>
> >> >> Hi Harry and Nicholas,
> >> >>
> >> >> I'm still on an extended quest to squeeze as much HDR out of Linux +
> your hw as possible, although the paid contract with Vesa has officially
> ended by now, and stumbled over this little conundrum:
> >> >>
> >> >> DC's set_spatial_dither() function (see link below) has this
> particular comment:
> >> >> "/* no 10bpc on DCE11*/" followed by code that skips dithering setup
> if the target output depth is 10 bpc:
> >> >>
> >> >>
> https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219
> >> >>
> >> >> I couldn't find any hint in the commit messages towards the reason,
> so why is that?
> >> >>
> >> >> This gets in the way if one has a HDR-10 monitor with 10 bit native
> output depth connected and wants to output a fp16 framebuffer and retain
> some of the > 10 bit linear precision by use of spatial dithering down to
> 10 bit. One only gets the same precision as a 10 bpc unorm fb. Also the
> routine is called for all DCE's, not only DCE11, so it affects all of them.
> >> >>
> >> >> The same restrictions don't exist in the old kms code for amdgpu-kms
> and radeon-kms. I added a mmio hack to Psychtoolbox to go behind the
> drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use spatial
> dithering down to 10 bpc anyway to circumvent this limitation. My
> photometer measurements on fp16 framebuffers feeding into 10 bit output
> show that I get a nice looking response consistent with dithering to 10 bpc
> properly working on DCE. Also i don't see any visual artifacts in displayed
> pictures, so the hw seems to be just fine. This on DCE-11.2, and more
> lightly tested on DCE-8.3.
> >> >>
> >> >> So i wonder if this is some leftover from some hw bringup, or if
> there is a good reason for it being there? Maybe it could be removed or
> made more specific to some problematic asic?
> >> >>
> >> >> Thanks for any insights you could provide. Stay safe,
> >> >> -mario
> >> >>
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx@lists.freedesktop.org
> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000a3bb7605bb2b42d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Feb 12, 2021 at 6:32 AM Alex Deuc=
her &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&=
gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, Feb 11, 2021 at 4:12 PM Mario Kleiner<br>
&lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mario.k=
leiner.de@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Feb 10, 2021 at 10:36 PM Alex Deucher &lt;<a href=3D"mailto:al=
exdeucher@gmail.com" target=3D"_blank">alexdeucher@gmail.com</a>&gt; wrote:=
<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 10, 2021 at 4:08 PM Mario Kleiner<br>
&gt;&gt; &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" target=3D"_blank=
">mario.kleiner.de@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Resending this one as well, in the hope of some clarification=
 or background information.<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Thanks Alex.<br>
&gt;<br>
&gt;&gt; I suspect this may have been a limitation from DCE11.0 (E.g.,<br>
&gt;&gt; carrizo/stoney APUs).=C2=A0 They had some bandwidth limitations wi=
th<br>
&gt;&gt; respect to high bit depth IIRC.=C2=A0 I suspect it should be fine =
on the<br>
&gt;&gt; relevant dGPUs.=C2=A0 The code was probably originally added for t=
he APUs<br>
&gt;<br>
&gt;<br>
&gt; That sounds as if it would make sense for me to try to submit a patch =
to you that restricts this limitation to DCE 11.0 only?<br>
<br>
I suspect older DCE 8.x APUs have similar limitations.=C2=A0 Although it<br=
>
may only be an issue with multiple monitors or something like that.=C2=A0 I=
<br>
don&#39;t remember the details.=C2=A0 @Harry Wentland do you remember?<br>
<br>
&gt;<br>
</blockquote><div><br></div><div>Fwiw, the tested DCE-8.3 was a mullins APU=
, at least that one was fine, although only testable with 10 bpc HDMI + 6 b=
pc eDP, the only available outputs.<br></div><div>=C2=A0</div><div>I just s=
ent out a patch to restrict the dithering restriction to DCE-11.0. Successf=
ully retested on DCE-11.2 via DP for extra care.<br></div><div><br></div><d=
iv>Have a nice weekend,</div><div>-mario</div><div><br></div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; All i can say is du=
ring my testing with DCE-8.3 over HDMI and DCE-11.2 over DP under amdvlk wi=
th fp16 mode and ouptut_bpc set to 10 bpc, ie. dithering down from 12 bpc t=
o 10 bpc, i didn&#39;t notice any problems when hacking this out, and photo=
meter measurements showed good improvements of luminance reproduction with =
dithering.<br>
&gt;<br>
&gt;&gt; and just never updated or the changes were accidentally lost when =
we<br>
&gt;&gt; consolidated the DCE code.=C2=A0 Unfortunately, there are not a lo=
t of apps<br>
&gt;&gt; that work properly in Linux with &gt;8 bits per channel.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Mine does ;-). As does apparently the Kodi media player. And at least =
Gnome/X11 works now, whereas KDE&#39;s Kwin/X11 used to work nicely, but re=
gressed. And amdvlk does have fp16 support now since a while ago, so that&#=
39;s one way to get high precision without disturbing conventional desktop =
apps. I&#39;ll probably look into Mesa&#39;s Vulkan/WSI for 10 bpc / fp16 s=
ometime this year if nobody beats me to it.<br>
&gt;<br>
<br>
Sounds good.<br>
<br>
Alex<br>
<br>
&gt; -mario<br>
&gt;<br>
&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; -mario<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Mon, Jan 25, 2021 at 3:56 AM Mario Kleiner &lt;<a href=3D"=
mailto:mario.kleiner.de@gmail.com" target=3D"_blank">mario.kleiner.de@gmail=
.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Hi Harry and Nicholas,<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I&#39;m still on an extended quest to squeeze as much HDR=
 out of Linux + your hw as possible, although the paid contract with Vesa h=
as officially ended by now, and stumbled over this little conundrum:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; DC&#39;s set_spatial_dither() function (see link below) h=
as this particular comment:<br>
&gt;&gt; &gt;&gt; &quot;/* no 10bpc on DCE11*/&quot; followed by code that =
skips dithering setup if the target output depth is 10 bpc:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; <a href=3D"https://elixir.bootlin.com/linux/v5.11-rc4/sou=
rce/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c#L219" rel=3D"noreferrer" t=
arget=3D"_blank">https://elixir.bootlin.com/linux/v5.11-rc4/source/drivers/=
gpu/drm/amd/display/dc/dce/dce_opp.c#L219</a><br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I couldn&#39;t find any hint in the commit messages towar=
ds the reason, so why is that?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; This gets in the way if one has a HDR-10 monitor with 10 =
bit native output depth connected and wants to output a fp16 framebuffer an=
d retain some of the &gt; 10 bit linear precision by use of spatial ditheri=
ng down to 10 bit. One only gets the same precision as a 10 bpc unorm fb. A=
lso the routine is called for all DCE&#39;s, not only DCE11, so it affects =
all of them.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The same restrictions don&#39;t exist in the old kms code=
 for amdgpu-kms and radeon-kms. I added a mmio hack to Psychtoolbox to go b=
ehind the drivers back and hack the FMT_BIT_DEPTH_CONTROL register to use s=
patial dithering down to 10 bpc anyway to circumvent this limitation. My ph=
otometer measurements on fp16 framebuffers feeding into 10 bit output show =
that I get a nice looking response consistent with dithering to 10 bpc prop=
erly working on DCE. Also i don&#39;t see any visual artifacts in displayed=
 pictures, so the hw seems to be just fine. This on DCE-11.2, and more ligh=
tly tested on DCE-8.3.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; So i wonder if this is some leftover from some hw bringup=
, or if there is a good reason for it being there? Maybe it could be remove=
d or made more specific to some problematic asic?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Thanks for any insights you could provide. Stay safe,<br>
&gt;&gt; &gt;&gt; -mario<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_b=
lank">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a><br>
</blockquote></div></div>

--000000000000a3bb7605bb2b42d4--

--===============1783380791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1783380791==--
