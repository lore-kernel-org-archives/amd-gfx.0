Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B3C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700CE2145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLZPLXgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700CE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BED6E833;
	Mon, 20 Apr 2020 18:05:06 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941AD6E7D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 16:04:55 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id j4so11115495qkc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mTM20ystUbYtsKRZ3ZxlxWVHLxZs3H2mGqURbXZMtWg=;
 b=YLZPLXgnTc/eNlM33yiTl/8hoD/W16WPAt/cfTYm+r1k4FxwO60I9wjwvFAXuY1m5L
 deFEhGWLZ4Kt0pJTVbIXXayiWGOuAe85sbrN7CTDhdW9zAKtoiy3elbjex51OPqiWW6T
 ACFAdhHjpqdf88tYDwhz2CCMIAY0cqv4Ayf1cbFL6xY3lT79IRNHieVXlY8N9P/jSkDX
 U+ox5kjAE6J5MRuUH5605Nxqa0PZ59zX6xPB3/UPE19plpL23lwR6Gd3CoyrWOvZbKZB
 t1cTsob0ulSEpAOLjYoveqEXqlfHRsrCXV+05XHzE49oD3k885KsvDsurB5WYpRmMgnc
 F7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mTM20ystUbYtsKRZ3ZxlxWVHLxZs3H2mGqURbXZMtWg=;
 b=IRVDXuQYYMpYokphxWcQKSxYzkWccNWpuDrkCCqg3rQZNqavf93mOQG9+3bMgFwv8r
 lAdRkc6Xm1gwdSAGqhrXQj+RQ7vnuZBeiFUkK8YvMIJ3pmk6t1TU+D5kxlF+r39qpBw2
 BTRNc4r4EcqTZAPNAT2IU2oYTGZfr53JdZZTSeSOhuXDxvAtvxJN/KZJFn4m2kJc1BXN
 xuFBY4BTltN6CwSf8OKLUFsebbVQkmNUaNgjdzbzebZXYK60hzwcOoLdtPoGtkK7rv4r
 IfL0yZvB8+WuCYoRrRbpM7ws7lWuVuuXO+f+4laGUOqQsoyi7JhEWoQBJzRkTIn+Pypy
 w6+A==
X-Gm-Message-State: AGi0Pua6/nyRIpZcLNHzqWKP9LHMR2yap+84rbCN5N9Q1C4zDZviAnEo
 BBPyyZxVd7B07Sl/aDJg4WNoHpAUHVE1WY6k/qStvBKY
X-Google-Smtp-Source: APiQypINl/AD5GIXpA5/lhmxbbMbEQg/B6PrB/Xn+fqkvm01JJT9tK2RnUCtCIQdy+gmCecait5bZ4hfEyjuaIwQxcM=
X-Received: by 2002:a37:6287:: with SMTP id w129mr16706022qkb.34.1587398694662; 
 Mon, 20 Apr 2020 09:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGcx_0Z4Lz4x5xxahtQJwaysGcQz9frLctYMg3z1Num3y+LUyw@mail.gmail.com>
 <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
In-Reply-To: <ab5fd92f-c0e3-8647-80e7-00d4ad397582@daenzer.net>
From: uday kiran pichika <udaykiran.pichika@gmail.com>
Date: Mon, 20 Apr 2020 21:34:43 +0530
Message-ID: <CAGcx_0ZoYz9jJQCWceTkN_X0dGdc+fTEaZytEx152SNLavAPRQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0570544027=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0570544027==
Content-Type: multipart/alternative; boundary="0000000000004ff5f805a3bb0f01"

--0000000000004ff5f805a3bb0f01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the information Michel.

Even in amdgpu_present_flip(), there is a check
for amdgpu_window_has_variable_refresh() which actually checks whether
window has a variable_refresh property set from the MESA or not ? this
check is failing in my case and never calls amdgpu_present_set_screen_vrr.
Is there any way that i can check whether MESA is setting this property ?

To my understanding, MESA will set this property to true or false based on
whether application is running in Full screen mode or in normal mode.
Please correct me if I am wrong.

Thanks
Uday Kiran

On Mon, Apr 20, 2020 at 8:14 PM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:

> On 2020-04-20 6:12 a.m., uday kiran pichika wrote:
> > Hello Team,
> >
> > I'm working on adding Adaptive Sync feature in Xserver/modesetting. Whe=
n
> > understanding the existing AMD's implementation, I've few doubts
> regarding
> > the vrr property being set on the Window from MESA.
> >
> > I have made the modifications in xserver/modesetting but when i launch
> the
> > application(DOTA2), below condition gets failed
> >
> https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/blob/maste=
r/src/amdgpu_kms.c#L110
>
> BTW, one should always use a specific Git commit for this kind of
> reference, otherwise it will tend to point to unrelated code or even
> nirvana as time passes.
>
>
> > As per the code, i had a confusion that this condition will never met.
> >
> > *I had analysed the code and here is the analysis made when the flip
> > happens in xserver When full screen gaming application is opened,
> > variable_refresh property is being set in MESA and xserver will get
> > notified with amdgpu_change_property() method(Same method we registered
> > with the client during AMDGPUScreenInit_KMS()). *
> >
> > *Below actions will happen in ms_change_property() *
> >
> > *1. Create Local WindowPtr and copy the data from Stuff->window to this
> > WindowPtr*
> >
> > *2. Call amdgpu_vrr_property_update() based on the property set in Stuf=
f
> by
> > passing the WindowPtr to it.*
> >
> > *    a. Read Private Keys for WindowPtr in amdgpu_vrr_property_update()=
.
> *
> >
> > *    b. Compare info->flip_window and this WindowPtr and make a call to
> > amdgpu_present_set_screen_vrr().  =E2=86=92 But this method will never =
gets
> called
> > due to the condition mismatch every time. Why ? *
> >
> > *Why ?*
> >
> > *info->flip_window gets updated with window (WindowPtr)
> > in amdgpu_present_check_flip() when amdgpu_present_flip() method gets
> > called from DIX. This pointer will never same as the WindowPtr created =
in
> > amdgpu_change_property() and variable_refresh flag is being set for in
> > amdgpu_change_property() WindowPtr only. *
> >
> > Can  you please help me in understanding on this ?
>
> This code in amdgpu_vrr_property_update is for the case when the
> ChangeProperty request is called for a window which is already flipping.
>
> In the case you're looking at, the window only starts flipping later,
> and the KMS property is enabled from amdgpu_present_flip =3D>
> amdgpu_present_set_screen_vrr.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               https://redhat=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--0000000000004ff5f805a3bb0f01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the information Michel.=C2=A0<div><br><div>Even=
 in amdgpu_present_flip(), there is a check for=C2=A0amdgpu_window_has_vari=
able_refresh() which actually checks whether window has a variable_refresh =
property set from the MESA or not ? this check is failing in my case and ne=
ver calls amdgpu_present_set_screen_vrr. Is there any way that i can check =
whether MESA is setting this property ?</div><div><br></div><div>To my unde=
rstanding, MESA will set this property to true or false based on whether ap=
plication=C2=A0is running in Full screen mode or in normal mode.=C2=A0 Plea=
se correct=C2=A0me if I am wrong.=C2=A0</div></div><div><br></div><div>Than=
ks=C2=A0</div><div>Uday Kiran</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20, 2020 at 8:14 PM Michel D=
=C3=A4nzer &lt;<a href=3D"mailto:michel@daenzer.net">michel@daenzer.net</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2=
020-04-20 6:12 a.m., uday kiran pichika wrote:<br>
&gt; Hello Team,<br>
&gt; <br>
&gt; I&#39;m working on adding Adaptive Sync feature in Xserver/modesetting=
. When<br>
&gt; understanding the existing AMD&#39;s implementation, I&#39;ve few doub=
ts regarding<br>
&gt; the vrr property being set on the Window from MESA.<br>
&gt; <br>
&gt; I have made the modifications in xserver/modesetting but when i launch=
 the<br>
&gt; application(DOTA2), below condition gets failed<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgp=
u/-/blob/master/src/amdgpu_kms.c#L110" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/-/blob/master=
/src/amdgpu_kms.c#L110</a><br>
<br>
BTW, one should always use a specific Git commit for this kind of<br>
reference, otherwise it will tend to point to unrelated code or even<br>
nirvana as time passes.<br>
<br>
<br>
&gt; As per the code, i had a confusion that this condition will never met.=
<br>
&gt; <br>
&gt; *I had analysed the code and here is the analysis made when the flip<b=
r>
&gt; happens in xserver When full screen gaming application is opened,<br>
&gt; variable_refresh property is being set in MESA and xserver will get<br=
>
&gt; notified with amdgpu_change_property() method(Same method we registere=
d<br>
&gt; with the client during AMDGPUScreenInit_KMS()). *<br>
&gt; <br>
&gt; *Below actions will happen in ms_change_property() *<br>
&gt; <br>
&gt; *1. Create Local WindowPtr and copy the data from Stuff-&gt;window to =
this<br>
&gt; WindowPtr*<br>
&gt; <br>
&gt; *2. Call amdgpu_vrr_property_update() based on the property set in Stu=
ff by<br>
&gt; passing the WindowPtr to it.*<br>
&gt; <br>
&gt; *=C2=A0 =C2=A0 a. Read Private Keys for WindowPtr in amdgpu_vrr_proper=
ty_update(). *<br>
&gt; <br>
&gt; *=C2=A0 =C2=A0 b. Compare info-&gt;flip_window and this WindowPtr and =
make a call to<br>
&gt; amdgpu_present_set_screen_vrr().=C2=A0 =E2=86=92 But this method will =
never gets called<br>
&gt; due to the condition mismatch every time. Why ? *<br>
&gt; <br>
&gt; *Why ?*<br>
&gt; <br>
&gt; *info-&gt;flip_window gets updated with window (WindowPtr)<br>
&gt; in amdgpu_present_check_flip() when amdgpu_present_flip() method gets<=
br>
&gt; called from DIX. This pointer will never same as the WindowPtr created=
 in<br>
&gt; amdgpu_change_property() and variable_refresh flag is being set for in=
<br>
&gt; amdgpu_change_property() WindowPtr only. *<br>
&gt; <br>
&gt; Can=C2=A0 you please help me in understanding on this ?<br>
<br>
This code in amdgpu_vrr_property_update is for the case when the<br>
ChangeProperty request is called for a window which is already flipping.<br=
>
<br>
In the case you&#39;re looking at, the window only starts flipping later,<b=
r>
and the KMS property is enabled from amdgpu_present_flip =3D&gt;<br>
amdgpu_present_set_screen_vrr.<br>
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

--0000000000004ff5f805a3bb0f01--

--===============0570544027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0570544027==--
