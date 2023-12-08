Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C8C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 15:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A71D10E27B;
	Fri,  8 Dec 2023 15:34:24 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441AC10E27B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 15:34:23 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54c846da5e9so2033243a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702049661; x=1702654461; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSNCuAFuRqhUIDE4cnEq4TXFS9edBpm5ff5rCt3diHA=;
 b=gGpDBpDcGZgi6o8tY4st6hRnc4Mjy3LRDwbUhQXZI1oclydfd5385yN5SLgjqnxoto
 ivyWhaz4MJwP7b8IHo1qQyS2/ck/j3TjAKvyytMgFU9jGWS5Y99N1OaLAlq8sLUzNt25
 FUEQam1nFUL1ozowCFXrqyuk1rXjeSqh7GaSyaPR1g8ekKjTle+36IpRxycKFa3Z6r+N
 K3GP+gMQWst1tmpjBMCERVSlLGx4nH574MwTseNUF0BJWg0vKnRHiAkBfKvoTdpXEavg
 wVaNc4CH9CTH+E3r8WTDtMmC3eOuCuakAj3stYbvNxdhvZQWz+bnsuN2ZVxXKZ76vj1W
 seLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702049661; x=1702654461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSNCuAFuRqhUIDE4cnEq4TXFS9edBpm5ff5rCt3diHA=;
 b=POc/VRPFIDnkFMk1+FlGcOlvGzAEvERUQGJaO80+wy8I1He76LTeEyGAq7H/VPcOXn
 E4CiWC4nykO4ATGkVsR0pHKq5ZBALtOKHg8nQiTu5KPp26uQssNmFr9kg4yhy7ADA7UT
 7L82nDc7d7Vdh6j+65jI0cX8Ccsz15BBTPZFjbvy47eqkOnUsaY6BOySMk5Adchi+H6r
 3iBp+rT93UiFPWTlDQovmMoe36tZFB0rnpD/L3txio8VUnKsMzkrJAtYUSI8vQS7E6do
 HWgcgAlkVBQ3EmQLjLA7TyMaSv2b2fREQjAxNldmlUogRjCGcIR4VKeu99I2OXDUfBGY
 xUWw==
X-Gm-Message-State: AOJu0YwmvHgt9FOuCNhpKZXQeSDcm/LgQjo1Rs/7Vi/BurOp7TO/ZmQI
 56ftdbLKLRveQH0BDPFRRSCX0kr1i8dPnd1PAZU=
X-Google-Smtp-Source: AGHT+IGAJHqRv6PXoJJRdhYdjCRsUthOZw+IaZ2DXHVXs4t/cdUIEBlvgPPBxWJWb7HYWAEkzrrCQPohyT0q1N63QYo=
X-Received: by 2002:a17:907:94cd:b0:a1e:9d8b:1e78 with SMTP id
 dn13-20020a17090794cd00b00a1e9d8b1e78mr140006ejc.40.1702049661392; Fri, 08
 Dec 2023 07:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
In-Reply-To: <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 8 Dec 2023 10:33:45 -0500
Message-ID: <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="000000000000751cb1060c015120"
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
 Friedrich Vock <friedrich.vock@gmx.de>, Marek Olsak <Marek.Olsak@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000751cb1060c015120
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:57=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com>
wrote:

> Am 08.12.23 um 12:43 schrieb Friedrich Vock:
> > On 08.12.23 10:51, Christian K=C3=B6nig wrote:
> >> Well longer story short Alex and I have been digging up the
> >> documentation for this and as far as we can tell this isn't correct.
> > Huh. I initially talked to Marek about this, adding him in Cc.
>
> Yeah, from the userspace side all you need to do is to set the bit as
> far as I can tell.
>
> >>
> >> You need to do quite a bit more before you can turn on this feature.
> >> What userspace side do you refer to?
> > I was referring to the Mesa merge request I made
> > (https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462).
> > If/When you have more details about what else needs to be done, feel
> > free to let me know.
>
> For example from the hardware specification explicitly states that the
> kernel driver should make sure that only one app/queue is using this at
> the same time. That might work for now since we should only have a
> single compute priority queue, but we are not 100% sure yet.
>

This is incorrect. While the hw documentation says it's considered
"unexpected programming", it also says that the hardware algorithm handles
it correctly and it describes what happens in this case: Tunneled waves
from different queues are treated as equal.

Marek

--000000000000751cb1060c015120
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Dec 8, 2023 at 9:57=E2=80=AFAM Christian K=C3=B6nig &lt;<a h=
ref=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@=
amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Am 08.12.23 um 12:43 schrieb Friedrich Vock:<br>
&gt; On 08.12.23 10:51, Christian K=C3=B6nig wrote:<br>
&gt;&gt; Well longer story short Alex and I have been digging up the<br>
&gt;&gt; documentation for this and as far as we can tell this isn&#39;t co=
rrect.<br>
&gt; Huh. I initially talked to Marek about this, adding him in Cc.<br>
<br>
Yeah, from the userspace side all you need to do is to set the bit as <br>
far as I can tell.<br>
<br>
&gt;&gt;<br>
&gt;&gt; You need to do quite a bit more before you can turn on this featur=
e.<br>
&gt;&gt; What userspace side do you refer to?<br>
&gt; I was referring to the Mesa merge request I made<br>
&gt; (<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/=
26462" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/=
mesa/mesa/-/merge_requests/26462</a>).<br>
&gt; If/When you have more details about what else needs to be done, feel<b=
r>
&gt; free to let me know.<br>
<br>
For example from the hardware specification explicitly states that the <br>
kernel driver should make sure that only one app/queue is using this at <br=
>
the same time. That might work for now since we should only have a <br>
single compute priority queue, but we are not 100% sure yet.<br></blockquot=
e><div><br></div><div>This is incorrect. While the hw documentation says it=
&#39;s considered &quot;unexpected programming&quot;, it also says that the=
 hardware algorithm handles it correctly and it describes what happens in t=
his case: Tunneled waves from different queues are treated as equal.<br></d=
iv><div><br></div><div>Marek</div></div></div>

--000000000000751cb1060c015120--
