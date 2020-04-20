Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04588C38A30
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD35206D6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5EvYsN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD35206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319E86E838;
	Mon, 20 Apr 2020 18:05:06 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC76D6E81C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 16:45:29 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id h6so1491743qvz.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6oUqvlfqqRTiVN7e5S6r4vOPITt4A0zv1VIgw212qq0=;
 b=A5EvYsN4XjdWqEfg8/R9nTa/ntSr6wx9NxydP4maJMMAX0LrGPzdBHG1hGxgPQHLvh
 Emifm2RWnJ35fxNb19ZKaM9Ytb8fvHw9lvKdkbv+3hKM1ggE7hMyGzETYSFJrfHwRLkr
 gZpT6ObQa23gDZ7mz6lDK20LAtSg5zk35RvE0Ef1SNa7sB6VJUMhQSJrHO1j1lApdQSN
 /WGyiFOyZMQ6dh9M5pfVHxVPlkuUBcFMsoqOX+Twb28NfxARbJwzo2Nqo6i+2HszGAR5
 +GGIRCTgzNZZhrQN1rXcJ5ebBZMSuB+t2hpc1xvs2JpYfQY3hENAJ0tdJZnXM0gLfErr
 mHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6oUqvlfqqRTiVN7e5S6r4vOPITt4A0zv1VIgw212qq0=;
 b=IqgxSXvya/RBEmyS3FWuj+4CqOKEqIJCNRCLF8fHtG0QhVtUCzSdH7jTimaEJBvMvH
 3DMvVhHzR0QNjDWCqbML4h6YbmlWZyf8B+YKswHkbzxslI5VKzv4+FFeN49MM0DV6QZd
 wVV4z//bDTPiggrkN26JIaMm4/pWkOXa8BtOe/++XdoqyFEzXoPjkDSdadYTWHNan2HO
 FvHUvGFIsN3gKDAAwvwIvIalusa9ke+aqf4qW27DnbpkmLdw1xDPWbQbvUm0NrKWQ+1H
 FcJRPKIfCSA/gCeB+GBudPylaKlQSnS0qhJC2muz7UtNySd8SoYlQZWylhHTq5X0swYb
 BcQQ==
X-Gm-Message-State: AGi0PuaxvFbQZXEEpZaClrBjjpouTIpr9btSThmlqZFj7FA8PlS6Xf7W
 p3LkLBCIEjTLaRBpMK5PdCCCyxz4LYhJQNJz4rwPk21t
X-Google-Smtp-Source: APiQypLBvCT0v2SZJOS7eXxqPYCOXvmioBqwztRBXUkiJrLQVSopolBkK7IQav909VZga8yxzARunVFHJJ8rbUbncY0=
X-Received: by 2002:a0c:f34b:: with SMTP id e11mr12834693qvm.76.1587401128987; 
 Mon, 20 Apr 2020 09:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
 <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
 <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
 <71874997-8503-27eb-b16e-bad70472041c@daenzer.net>
In-Reply-To: <71874997-8503-27eb-b16e-bad70472041c@daenzer.net>
From: uday kiran pichika <udaykiran.pichika@gmail.com>
Date: Mon, 20 Apr 2020 22:15:17 +0530
Message-ID: <CAGcx_0aAbMviGJMtZP3jSpLr8OayUDMOwFkUd70j=SY-qmbGyg@mail.gmail.com>
Subject: Re: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-Mailman-Approved-At: Mon, 20 Apr 2020 18:05:05 +0000
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
Content-Type: multipart/mixed; boundary="===============0130841784=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0130841784==
Content-Type: multipart/alternative; boundary="00000000000068d1be05a3bba059"

--00000000000068d1be05a3bba059
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 9:45 PM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:

> On 2020-04-20 6:04 p.m., uday kiran pichika wrote:
> >
> > Even in amdgpu_present_flip(), there is a check
> > for amdgpu_window_has_variable_refresh() which actually checks whether
> > window has a variable_refresh property set from the MESA or not ? this
> > check is failing in my case and never calls
> amdgpu_present_set_screen_vrr.
>
> This should be set by
>
>         get_window_priv(window)->variable_refresh =3D variable_refresh;
>
> in amdgpu_vrr_property_update.
>

I amdgpu_vrr_property_update method gets called from amdgpu_change_property
when the property is being added to the window. though variable_refresh
property is updating from the below call, this window is not same as the
one(info->flip_window) in amdgpu_present_flip.
*get_window_priv(window)*->variable_refresh =3D variable_refresh;

Could you please let me know you IRC ID to have a chat in that for more
information.

>
>
> > Is there any way that i can check whether MESA is setting this property=
 ?
> >
> > To my understanding, MESA will set this property to true or false based
> on
> > whether application is running in Full screen mode or in normal mode.
>
> Mesa always sets the window property by default, unless the driconf
> option "adaptive_sync" is disabled, e.g. via the application blacklist
> in /usr/share/drirc.d/00-mesa-defaults.conf (mostly for compositors /
> browsers / video players).
>
Yes.. I had verified this too from
https://patchwork.freedesktop.org/patch/257941/?series=3D51388&rev=3D1


>
>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--00000000000068d1be05a3bba059
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20, 2020 at 9:45 PM Miche=
l D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenzer.net">michel@daenzer.net<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 2020-04-20 6:04 p.m., uday kiran pichika wrote:<br>
&gt; <br>
&gt; Even in amdgpu_present_flip(), there is a check<br>
&gt; for amdgpu_window_has_variable_refresh() which actually checks whether=
<br>
&gt; window has a variable_refresh property set from the MESA or not ? this=
<br>
&gt; check is failing in my case and never calls amdgpu_present_set_screen_=
vrr.<br>
<br>
This should be set by<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_window_priv(window)-&gt;variable_refresh =
=3D variable_refresh;<br>
<br>
in amdgpu_vrr_property_update.<br></blockquote><div><br></div><div>I=C2=A0a=
mdgpu_vrr_property_update method gets called from amdgpu_change_property wh=
en the property is being added to the window. though variable_refresh prope=
rty is updating from the below call, this window is not same as the one(inf=
o-&gt;flip_window) in amdgpu_present_flip.</div><div><b>get_window_priv(win=
dow)</b>-&gt;variable_refresh =3D variable_refresh;=C2=A0</div><div><br></d=
iv><div>Could you please let me know you IRC ID to have a chat in that for =
more information.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
<br>
&gt; Is there any way that i can check whether MESA is setting this propert=
y ?<br>
&gt; <br>
&gt; To my understanding, MESA will set this property to true or false base=
d on<br>
&gt; whether application is running in Full screen mode or in normal mode.<=
br>
<br>
Mesa always sets the window property by default, unless the driconf<br>
option &quot;adaptive_sync&quot; is disabled, e.g. via the application blac=
klist<br>
in /usr/share/drirc.d/00-mesa-defaults.conf (mostly for compositors /<br>
browsers / video players).<br></blockquote><div>Yes.. I had verified this t=
oo from=C2=A0<a href=3D"https://patchwork.freedesktop.org/patch/257941/?ser=
ies=3D51388&amp;rev=3D1">https://patchwork.freedesktop.org/patch/257941/?se=
ries=3D51388&amp;rev=3D1</a></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"https://redhat.com" rel=3D"noreferrer" target=3D"_blank">https://redhat=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div></div>

--00000000000068d1be05a3bba059--

--===============0130841784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0130841784==--
