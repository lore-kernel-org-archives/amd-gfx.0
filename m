Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCEDC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 07:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE6B60F51
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 07:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDE6B60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 161E86E0DF;
	Sat, 18 Sep 2021 07:20:17 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE3A6E0DB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 07:20:14 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 f3-20020a17090a638300b00199097ddf1aso11646131pjj.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 00:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8zm7yyW0xmDYNaXfS1pmGLjR09AtdVSZ5qKbdyipfTs=;
 b=jY7DP5mg6+lvd9mr8+QQJV63C/lhZQKLf4wLtwRzXFBJRmcfiCuZBpe95QtFNFanjm
 F/FFFJhsJxyOrcp6bP2UuDAz2IaV0mqhFGFbCNDqdvOdEMTjV1hj9gQRLiLHb2wufV4r
 dcGvoaRYTcDZl1YLDW/AMgj53BPVY54qbD2q8BKCS05VXtn6i5pxiTFkxc/Af0a1Yojv
 MMM9/b29ra8mYIQGx5qZgSFUqHtm+po/iAUNtG69n4zenDVJtXOXm6h0GmHHnE+1jnvC
 e7KFlsIzCLuQYFAC4QtbHhgCgZ/brZOaNEwun5NAQ7YhMtylGckEoH0zum0fAdZSEIzk
 vQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zm7yyW0xmDYNaXfS1pmGLjR09AtdVSZ5qKbdyipfTs=;
 b=fxTWecPUMJSyp7LYa48T1lKZ4JlzZKll+L7Xm3Vow7fBzP9QaoQL7jVf0Ol989ivcv
 PVCnpynfXIddT5lddtHorTM1CdrE0tbIoZc/aqRQ9KKjzJJuQi+SU7Sd91LfSyuDxmXL
 ZCqnMyj7JlgimUCmwtR0tQNYD913uomsg1iVlO4yVlK5Lmj0Jsj573LrIGp7nt7q3W75
 qXEag086o3oC4wtVRleYtlSStGLGWFOK12MlGWaKkoS9xg33cVNCwfYbtVmijDrqWlcq
 LZ1/m8fXCMkR5Qd4pdImG3O5Ll8iwIgT45NZhJIpSa3croyT2is+luSJgNVl9fYhL9gf
 0UQg==
X-Gm-Message-State: AOAM5304a9C91IuReSXeC2kDHd1zBwveisrHpnjdefMfNgmv07GDgqEw
 ZwY239lLTEC/vcLSI2GLbqSKX83tXKWpmL3Mmdw=
X-Google-Smtp-Source: ABdhPJz9r9+HoBscQgmVBJ1sCsmjmCQK86Ui5WWzoI4mD0S+qkiMuqbvsH1GfKLtwmUvts9Zw8hXX9Wiair8/NFs/GU=
X-Received: by 2002:a17:90a:1db:: with SMTP id
 27mr5953336pjd.106.1631949614158; 
 Sat, 18 Sep 2021 00:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <4ded93f1-e6b1-06c3-9f03-b6135911392c@gmail.com>
 <d8293063-6f0e-b808-2636-631fe2f08fcf@daenzer.net>
 <DM6PR12MB261970C1F0CDB0D1D91EE7C9E4DD9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261970C1F0CDB0D1D91EE7C9E4DD9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Sat, 18 Sep 2021 03:19:38 -0400
Message-ID: <CAAxE2A7RL+LEgwtQwH2s9_Zm5FZFKvGYpRqTZzxiXAwXdaeR6w@mail.gmail.com>
Subject: Re: DRM IOCTLS come regularly(every minute) still even after screen
 off
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000000b179a05cc3fe1e0"
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

--0000000000000b179a05cc3fe1e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Printing the backtrace from si_flush_gfx_cs while /etc/environment contains
GALLIUM_THREAD=3D0 at boot should show which GL call and X call caused the
flush.

Marek

On Thu, Sep 16, 2021 at 10:58 PM Quan, Evan <Evan.Quan@amd.com> wrote:

> [Public]
>
>
>
> > -----Original Message-----
> > From: Michel D=C3=A4nzer <michel@daenzer.net>
> > Sent: Thursday, September 16, 2021 4:12 PM
> > To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>; Quan, Evan
> > <Evan.Quan@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; 'amd-gfx@lists.freedesktop.org' <amd-
> > gfx@lists.freedesktop.org>
> > Subject: Re: DRM IOCTLS come regularly(every minute) still even after
> screen
> > off
> >
> > On 2021-09-16 08:27, Christian K=C3=B6nig wrote:
> > > Good morning,
> > >
> > > for the background I advised to contact you Michel since we couldn't
> find
> > an explanation.
> > >
> > > Alex explanation might be correct, but the CS seems to come from the =
X
> > server and is always roughly 60 seconds after going into power save.
> > >
> > > Any idea what that could be?
> >
> > For the DRM_IOCTL_MODE_* ioctls, attaching gdb to Xorg and setting a
> > breakpoint on drmIoctl should show where they're coming from.
> >
> > The AMDGPU_CS ioctls are probably from glamor calling OpenGL, most like=
ly
> > for X11 drawing protocol requests. Note that in this case drmIoctl/ioct=
l
> will
> > likely be called from a separate thread. Pierre / Marek should be able
> to help
> > you find out where the OpenGL calls are coming from.
> >
> >
> > In general, Xorg only ever does anything in response to:
> >
> > * X11 protocol requests, i.e. on behalf of clients.
> > * Input events, i.e. on behalf of the user.
> > * Other kernel events, e.g. hotplug events.
> >
> Thanks for sharing these.
> >
> > FWIW, with only xfwm4 & xterm running on Xorg, I'm not seeing any
> drmIoctl
> > calls during DPMS off. So the ioctls you're seeing are most likely
> triggered by
> > clients.
> >
> Got it. Thanks!
>
> Evan
> >
> > --
> > Earthling Michel D=C3=A4nzer               |
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fred=
h
> > at.com%2F&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C296d316427
> > b4469f8eb908d978e9b46a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > C0%7C637673767426116632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> > p;sdata=3DgBj4idZGCuaPdyaH1g1mfuDqPCcKhFMjPCbqpM8drlg%3D&amp;res
> > erved=3D0
> > Libre software enthusiast             |             Mesa and X develope=
r
>

--0000000000000b179a05cc3fe1e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Printing the backtrace f=
rom<span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)"> si_f=
lush_gfx_cs while /etc/environment contains GALLIUM_THREAD=3D0 at boot shou=
ld show which GL call and X call caused the flush.</span></div><div><span s=
tyle=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)"><br></span></di=
v><div><span style=3D"color:rgb(0,0,0);background-color:rgb(255,255,255)">M=
arek<br></span></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 16, 2021 at 10:58 PM Quan, Evan &lt;<a hre=
f=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">[Public]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel@daenzer.net" tar=
get=3D"_blank">michel@daenzer.net</a>&gt;<br>
&gt; Sent: Thursday, September 16, 2021 4:12 PM<br>
&gt; To: Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;; Quan=
, Evan<br>
&gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_blank">Evan.Quan@a=
md.com</a>&gt;<br>
&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Koenig, Christian<br=
>
&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com" target=3D"_blank">Chri=
stian.Koenig@amd.com</a>&gt;; &#39;<a href=3D"mailto:amd-gfx@lists.freedesk=
top.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&#39; &lt;amd-<=
br>
&gt; <a href=3D"mailto:gfx@lists.freedesktop.org" target=3D"_blank">gfx@lis=
ts.freedesktop.org</a>&gt;<br>
&gt; Subject: Re: DRM IOCTLS come regularly(every minute) still even after =
screen<br>
&gt; off<br>
&gt; <br>
&gt; On 2021-09-16 08:27, Christian K=C3=B6nig wrote:<br>
&gt; &gt; Good morning,<br>
&gt; &gt;<br>
&gt; &gt; for the background I advised to contact you Michel since we could=
n&#39;t find<br>
&gt; an explanation.<br>
&gt; &gt;<br>
&gt; &gt; Alex explanation might be correct, but the CS seems to come from =
the X<br>
&gt; server and is always roughly 60 seconds after going into power save.<b=
r>
&gt; &gt;<br>
&gt; &gt; Any idea what that could be?<br>
&gt; <br>
&gt; For the DRM_IOCTL_MODE_* ioctls, attaching gdb to Xorg and setting a<b=
r>
&gt; breakpoint on drmIoctl should show where they&#39;re coming from.<br>
&gt; <br>
&gt; The AMDGPU_CS ioctls are probably from glamor calling OpenGL, most lik=
ely<br>
&gt; for X11 drawing protocol requests. Note that in this case drmIoctl/ioc=
tl will<br>
&gt; likely be called from a separate thread. Pierre / Marek should be able=
 to help<br>
&gt; you find out where the OpenGL calls are coming from.<br>
&gt; <br>
&gt; <br>
&gt; In general, Xorg only ever does anything in response to:<br>
&gt; <br>
&gt; * X11 protocol requests, i.e. on behalf of clients.<br>
&gt; * Input events, i.e. on behalf of the user.<br>
&gt; * Other kernel events, e.g. hotplug events.<br>
&gt; <br>
Thanks for sharing these.<br>
&gt; <br>
&gt; FWIW, with only xfwm4 &amp; xterm running on Xorg, I&#39;m not seeing =
any drmIoctl<br>
&gt; calls during DPMS off. So the ioctls you&#39;re seeing are most likely=
 triggered by<br>
&gt; clients.<br>
&gt; <br>
Got it. Thanks!<br>
<br>
Evan<br>
&gt; <br>
&gt; --<br>
&gt; Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fredh" rel=3D"noreferrer" target=3D"_blank">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredh</a><br>
&gt; <a href=3D"http://at.com" rel=3D"noreferrer" target=3D"_blank">at.com<=
/a>%2F&amp;amp;data=3D04%7C01%7CEvan.Quan%<a href=3D"http://40amd.com" rel=
=3D"noreferrer" target=3D"_blank">40amd.com</a>%7C296d316427<br>
&gt; b4469f8eb908d978e9b46a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7<br>
&gt; C0%7C637673767426116632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w<br>
&gt; LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;am<b=
r>
&gt; p;sdata=3DgBj4idZGCuaPdyaH1g1mfuDqPCcKhFMjPCbqpM8drlg%3D&amp;amp;res<b=
r>
&gt; erved=3D0<br>
&gt; Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br=
>
</blockquote></div>

--0000000000000b179a05cc3fe1e0--
