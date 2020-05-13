Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF2C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 15:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D116205ED
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdZ5Ac8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D116205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34E76EA68;
	Wed, 13 May 2020 15:13:31 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88186EA68
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 15:13:30 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id g185so17662120qke.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xWN21ceuMzRzgwdKhBaDodezf/PXQesG/Wm7zAQ8qko=;
 b=IdZ5Ac8zFecPawt+C6fSN3amVsiv2GKwTfOPXnEo+z8ghUJOG1Yfk51FfpPBvX6ii4
 66GMGhfddE/k7s1ThiTPLLdopDJDTDZffLdJ0kzZiFlVQFeK1hht95OMi0JIiGAnDp3A
 9pU7MZrE+fglAMISecCgY87Q4wZlzKw1aD95EVWIyEJDveTLhT5REV89RvTJRDNHUnjQ
 Lsxt8bXTvdqIkeHx2KrppoxCfE/RamDNjsRPt2HV1N+hDVyNDqB0AorYPxSJFy28eZEa
 UqhRB2hG7X1vaLqdp/HvHUnlo8bfzuMfcDEdFU7opHN8yM/XkYkYBh9d4kSf+jyeDwuF
 +HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xWN21ceuMzRzgwdKhBaDodezf/PXQesG/Wm7zAQ8qko=;
 b=Q1bV4rhqh6FoCLjdd7pih12kWQUGI+IMuGMew952GY5liHCECpH0xY+MgHX0j2wbX9
 6EiQNrVSg4PtDPSi2JMHPHCY+KHKdr5wySK0o+33RJ8WwB6f3gePwtsQdu9OVzCacjUh
 uREd9KmLAoQWw1HF9y0WL6z13G8J8vK4+W8SNYODdpSntUZC0xEHGUwL3FS/S3+fBdxk
 XbTeA0iDAWGnNOt0eb+r9YpUFbvn7C7xQ9yvtZ/c7PsjuhwIJMPKGIirKDOeq4+IK+NI
 EXwI/QSACABnKsmiqD+2kdBpxB7q793e/R8sfq+Z0eURfSNBlQAH6CYhVbS07Zekj+9T
 Uc3w==
X-Gm-Message-State: AOAM533VV4Q0dDtNgngIJ3dJ1ywTN3IwwXPcq1B8Pj4MzMnQUdziqx2Q
 gcswnz3rHs0fM4U9KPf9SOjUQMDBJ+OJRan0FzhqcH3P
X-Google-Smtp-Source: ABdhPJzq8FxR2ZBgtL1ry9vLIo8datjwrlMmbnMQlh9rBz7p4rR+iukzwk49E6Dbr9/T5r1Zi6j+uzWgHzDELA0vk0k=
X-Received: by 2002:a37:a687:: with SMTP id p129mr131284qke.45.1589382809446; 
 Wed, 13 May 2020 08:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
 <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
 <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
 <71874997-8503-27eb-b16e-bad70472041c@daenzer.net>
 <CAGcx_0aAbMviGJMtZP3jSpLr8OayUDMOwFkUd70j=SY-qmbGyg@mail.gmail.com>
 <1e659586-2ba8-6791-01b6-30c69f211d82@daenzer.net>
In-Reply-To: <1e659586-2ba8-6791-01b6-30c69f211d82@daenzer.net>
From: uday kiran pichika <udaykiran.pichika@gmail.com>
Date: Wed, 13 May 2020 20:43:18 +0530
Message-ID: <CAGcx_0aeZkBLLyWN_C7D7UpEyT=iMAG3GB6aP_Bjhe+BszxRAw@mail.gmail.com>
Subject: Re: Reg. Adaptive Sync feature in xf86-video-amdgpu
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Content-Type: multipart/mixed; boundary="===============0152014570=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0152014570==
Content-Type: multipart/alternative; boundary="000000000000c4edc905a58905a7"

--000000000000c4edc905a58905a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michel and Team,

Can you please help to provide the below details on the Adaptive Sync
verification?
1. As you have mentioned in IRC, AMD has verified on Ubuntu machine with
Unity/Compiz Compositor. But when i see mesa/src/util/00-mesa-defaults.conf
where Mutter and Compiz compositors are black listed.

<application name=3D"compiz" executable=3D"compiz">

            <option name=3D"adaptive_sync" value=3D"*false*" />

<application name=3D"mutter" executable=3D"mutter">

                          <option name=3D"adaptive_sync" value=3D"*false*" =
/>
I even tried by keeping the Ubuntu machine in Runlevel-3 mode and launched
Xorg manually. Ran a gfxapp in full screen mode. In this case modesetting
driver is not getting launched because there is no gdm3 service running.

Can you please tell me what is the setup you people followed to verify this
?

Thanks
Uday Kiran





On Mon, Apr 20, 2020 at 10:18 PM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:

> On 2020-04-20 6:45 p.m., uday kiran pichika wrote:
> > On Mon, Apr 20, 2020 at 9:45 PM Michel D=C3=A4nzer <michel@daenzer.net>
> wrote:
> >> On 2020-04-20 6:04 p.m., uday kiran pichika wrote:
> >>>
> >>> Even in amdgpu_present_flip(), there is a check
> >>> for amdgpu_window_has_variable_refresh() which actually checks whethe=
r
> >>> window has a variable_refresh property set from the MESA or not ? thi=
s
> >>> check is failing in my case and never calls
> >> amdgpu_present_set_screen_vrr.
> >>
> >> This should be set by
> >>
> >>         get_window_priv(window)->variable_refresh =3D variable_refresh=
;
> >>
> >> in amdgpu_vrr_property_update.
> >>
> >
> > I amdgpu_vrr_property_update method gets called from
> amdgpu_change_property
> > when the property is being added to the window. though variable_refresh
> > property is updating from the below call, this window is not same as th=
e
> > one(info->flip_window) in amdgpu_present_flip.
> > *get_window_priv(window)*->variable_refresh =3D variable_refresh;
>
> Then it's probably not the application's window which is page flipping,
> but e.g. the compositor's. Make sure your compositor supports
> unredirecting fullscreen windows.
>
>
> > Could you please let me know you IRC ID to have a chat in that for more
> > information.
>
> I'm MrCooper on IRC.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--000000000000c4edc905a58905a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Michel and Team,<div><br></div><div>Can you please h=
elp to provide the below=C2=A0details on the Adaptive Sync verification?</d=
iv><div>1. As you have mentioned in IRC, AMD has verified on Ubuntu machine=
 with Unity/Compiz Compositor. But when i see=C2=A0<span style=3D"backgroun=
d-color:aqua;color:black;font-family:Calibri,sans-serif;font-size:11pt">mes=
a/src/util/00-mesa-defaults.conf</span>=C2=A0 where Mutter and Compiz compo=
sitors are black listed.=C2=A0</div><p class=3D"gmail-MsoPlainText" style=
=3D"margin:0cm 0cm 0.0001pt 36pt;font-size:11pt;font-family:Calibri,sans-se=
rif"><span style=3D"color:rgb(191,144,0)">&lt;application
name=3D&quot;<span style=3D"background:yellow">compiz</span>&quot;
executable=3D&quot;compiz&quot;&gt;</span><span style=3D"color:black"></spa=
n></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"color:rgb(191,144,=
0)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
&lt;option name=3D&quot;adaptive_sync&quot; value=3D&quot;</span><b><span s=
tyle=3D"color:red">false</span></b><span style=3D"color:rgb(191,144,0)">&qu=
ot; /&gt;</span><span style=3D"color:black"></span></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"color:rgb(191,144,=
0)">&lt;application
name=3D&quot;<span style=3D"background:yellow">mutter</span>&quot;
executable=3D&quot;mutter&quot;&gt;</span><span style=3D"color:black"></spa=
n></p>

<p class=3D"gmail-MsoPlainText" style=3D"margin:0cm 0cm 0.0001pt 36pt;font-=
size:11pt;font-family:Calibri,sans-serif"><span style=3D"color:black"></spa=
n></p><div><span style=3D"font-family:Calibri,sans-serif;font-size:11pt;col=
or:rgb(191,144,0)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;option name=3D&quot;adaptive_sync&qu=
ot; value=3D&quot;</span><b style=3D"font-family:Calibri,sans-serif;font-si=
ze:11pt"><span style=3D"color:red">false</span></b><span style=3D"font-fami=
ly:Calibri,sans-serif;font-size:11pt;color:rgb(191,144,0)">&quot; /&gt;</sp=
an>=C2=A0=C2=A0</div><div>I even tried by keeping the Ubuntu machine in Run=
level-3 mode and launched Xorg manually. Ran a gfxapp in full screen mode. =
In this case modesetting driver is not getting launched because there is no=
 gdm3 service running.=C2=A0</div><div><br></div><div>Can you please tell m=
e what is the setup you people followed to verify this ?=C2=A0</div><div><b=
r></div><div>Thanks=C2=A0</div><div>Uday Kiran</div><div><br></div><div><br=
></div><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20, 2020 at 10:18 PM Miche=
l D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenzer.net">michel@daenzer.net<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 2020-04-20 6:45 p.m., uday kiran pichika wrote:<br>
&gt; On Mon, Apr 20, 2020 at 9:45 PM Michel D=C3=A4nzer &lt;<a href=3D"mail=
to:michel@daenzer.net" target=3D"_blank">michel@daenzer.net</a>&gt; wrote:<=
br>
&gt;&gt; On 2020-04-20 6:04 p.m., uday kiran pichika wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Even in amdgpu_present_flip(), there is a check<br>
&gt;&gt;&gt; for amdgpu_window_has_variable_refresh() which actually checks=
 whether<br>
&gt;&gt;&gt; window has a variable_refresh property set from the MESA or no=
t ? this<br>
&gt;&gt;&gt; check is failing in my case and never calls<br>
&gt;&gt; amdgpu_present_set_screen_vrr.<br>
&gt;&gt;<br>
&gt;&gt; This should be set by<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_window_priv(window)-&gt;varia=
ble_refresh =3D variable_refresh;<br>
&gt;&gt;<br>
&gt;&gt; in amdgpu_vrr_property_update.<br>
&gt;&gt;<br>
&gt; <br>
&gt; I amdgpu_vrr_property_update method gets called from amdgpu_change_pro=
perty<br>
&gt; when the property is being added to the window. though variable_refres=
h<br>
&gt; property is updating from the below call, this window is not same as t=
he<br>
&gt; one(info-&gt;flip_window) in amdgpu_present_flip.<br>
&gt; *get_window_priv(window)*-&gt;variable_refresh =3D variable_refresh;<b=
r>
<br>
Then it&#39;s probably not the application&#39;s window which is page flipp=
ing,<br>
but e.g. the compositor&#39;s. Make sure your compositor supports<br>
unredirecting fullscreen windows.<br>
<br>
<br>
&gt; Could you please let me know you IRC ID to have a chat in that for mor=
e<br>
&gt; information.<br>
<br>
I&#39;m MrCooper on IRC.<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"https://redhat.com" rel=3D"noreferrer" target=3D"_blank">https://redhat=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div>

--000000000000c4edc905a58905a7--

--===============0152014570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0152014570==--
