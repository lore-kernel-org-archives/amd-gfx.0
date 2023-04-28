Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD96C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 22:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C4D10E0C8;
	Fri, 28 Apr 2023 22:36:50 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E336E10E0C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 22:36:47 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-50a145a0957so21761538a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682721404; x=1685313404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6u7vWbDEdsZCmMhd1BUoLyG7yfvP8R7ElBDMPSTEIBc=;
 b=qIFd9r1Rh0/NWvGbzMStmaH3kXzFxi5suyH5FPFMlIns8+tLVQf33NRxFaZ369UEGI
 /kuQ3pgQtOMfosdiDySYfiQu4CpnwIYhB/BgrHTkvWj0hdODnMQolkeqOslWXoaIee/f
 G36c7fXnbynf24Wkcd4RqtyTzPTyQSnUKTTF85vr/Acx8Pe+YYUjY6mkyc91o/f1e9Ee
 q7nECu7aY4f8rRsdaAzy0TsHu1Jcle2mFfFi1Qu+6v38M9k+Lzzli63FgRP46Cj2vElT
 p5uSkmHwhMbLolkjQfkmAd+c5licWHKg5q8PfBqvjPzrrLIuuhOQnp20xXsLaObHpXYz
 C+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682721404; x=1685313404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6u7vWbDEdsZCmMhd1BUoLyG7yfvP8R7ElBDMPSTEIBc=;
 b=dCkGvYU5GxedyqUwxyHDWwaeJvQNVP95HlnPBgtXkHdqvKj+mBsVdmH76cXAEWzdQE
 SA4QbxzEzRhVmBI3yZ0C1ITFulEKdcUWrwj2E5ruLpqf6ezDrZRdfaYcbFJWvXfQN8Cn
 v8iZDgc1ll3+d4Cb3cjGtCeq2Plr5hx5/18cnSYX6R0og8r+sk9wY3+2t3gouERowH6M
 n05ycEKa6wuVJu25x2Cs+CwoNs6HtuHt8oALSPyo3QbXS/0EGEVtW5AsOSJ+A+ZlMA43
 gxCvP1/+SngR+BMrRZDSRT55uo3yzEZWq1uNF+s6cm4DED+6X9O9FmKzaxO2Do/Hv4Zy
 FRog==
X-Gm-Message-State: AC+VfDzWJ8ljt01KBnO4iW6kI2invv3/BAPko6nlk6w+IOfixpX9+l9x
 qll+AhT2BwekUWEW/ngUIwl/OVYMGkHrCKuus8k=
X-Google-Smtp-Source: ACHHUZ4RsS8AXSRodUWkpLu9K0itxmZnEoYrzYW5yTXGIZQcOzvAaWz9Fvb5KnYsp7fG8Sz3AQP7Wj6FrNIyy1xLEKk=
X-Received: by 2002:a17:906:1e90:b0:953:5ff8:8b17 with SMTP id
 e16-20020a1709061e9000b009535ff88b17mr10754020ejj.2.1682721403643; Fri, 28
 Apr 2023 15:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
 <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
 <CAAxE2A58Wp-2z3CKadQfgGkAZA2emH5Z3Z0_soiZEPNmKhkuBA@mail.gmail.com>
 <CAEZNXZC+qbD2JJgV7gTYdNH-SNKhNBbzQKNDyzje0mPKjhSJYg@mail.gmail.com>
In-Reply-To: <CAEZNXZC+qbD2JJgV7gTYdNH-SNKhNBbzQKNDyzje0mPKjhSJYg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 28 Apr 2023 18:36:32 -0400
Message-ID: <CAAxE2A55+Rmdz63P8JETkvsLX6DSLFvpBwNoiE_pdsKjpdpCLg@mail.gmail.com>
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="00000000000085299105fa6d1bfb"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000085299105fa6d1bfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023, 16:14 Joshua Ashton <joshua@froggi.es> wrote:

> I mean I would also like power and perf numbers for Vangogh given you
> referenced 10.3.
>
> Generic "power consumption is better" isn't enough to convince me that
> this is the right call.
>

Raphael and Mendocino have worse power consumption with retiled displayable
DCC and modifiers, and that can also be due to how retiling is implemented
for modifiers.

Marek


> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On Friday, 28 April 2023, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrote:
> > I thought the same thing initially, but then realized that's not how
> modifiers were designed to work.
> > Mesa should expose all modifiers it wants to allow for 3D and it doesn'=
t
> care which ones are displayable.
> > The kernel should expose all modifiers it wants to allow for display.
> > With that, Mesa can still use theoretically displayable DCC, but it wil=
l
> only be used for anything that's not the display.
> > We can, of course, disable it in Mesa instead to get the same effect.
> > We would need perf numbers for dGPUs to be able to tell whether it's
> beneficial with the cost of DCC retiling.
> > Marek
> >
> > On Fri, Apr 28, 2023, 12:11 Joshua Ashton <joshua@froggi.es> wrote:
> >>
> >> I really don't think the kernel isn't the right place to do this.
> >> Is there any reason to not just disable it from the Mesa side?
> >>
> >> We can already disable displayable DCC there, so I don't see why you
> are even touching the kernel.
> >> It makes it infinitely harder for anyone to evaluate perf and power
> tradeoffs if you disable it at this level.
> >>
> >> The whole power vs perf trade is also not a big deal on dGPUs compared
> to APUs. Probably needs a better heuristic either way to avoid regressing
> perf.
> >>
> >> - Joshie =F0=9F=90=B8=E2=9C=A8
> >>
> >> On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.c=
om> wrote:
> >>>
> >>> Hi,
> >>> It's attached for review.
> >>>
> >>> Thanks,
> >>> Marek
> >

--00000000000085299105fa6d1bfb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Apr 28, 2023, 16:14 Joshua Ashton &lt;<a href=3D"mailt=
o:joshua@froggi.es">joshua@froggi.es</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">I mean I would also like power and perf numbers for Vangog=
h given you referenced 10.3.<br><br>Generic &quot;power consumption is bett=
er&quot; isn&#39;t enough to convince me that this is the right call.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Raphae=
l and Mendocino have worse power consumption with retiled displayable DCC a=
nd modifiers, and that can also be due to how retiling is implemented for m=
odifiers.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br>- Joshie =F0=9F=90=B8=E2=9C=A8<br><br>On Frid=
ay, 28 April 2023, Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail=
.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt; wrote:<=
br>&gt; I thought the same thing initially, but then realized that&#39;s no=
t how modifiers were designed to work.<br>&gt; Mesa should expose all modif=
iers it wants to allow for 3D and it doesn&#39;t care which ones are displa=
yable.<br>&gt; The kernel should expose all modifiers it wants to allow for=
 display.<br>&gt; With that, Mesa can still use theoretically displayable D=
CC, but it will only be used for anything that&#39;s not the display.<br>&g=
t; We can, of course, disable it in Mesa instead to get the same effect.<br=
>&gt; We would need perf numbers for dGPUs to be able to tell whether it&#3=
9;s beneficial with the cost of DCC retiling.<br>&gt; Marek<br>&gt;<br>&gt;=
 On Fri, Apr 28, 2023, 12:11 Joshua Ashton &lt;<a href=3D"mailto:joshua@fro=
ggi.es" target=3D"_blank" rel=3D"noreferrer">joshua@froggi.es</a>&gt; wrote=
:<br>&gt;&gt;<br>&gt;&gt; I really don&#39;t think the kernel isn&#39;t the=
 right place to do this.<br>&gt;&gt; Is there any reason to not just disabl=
e it from the Mesa side?<br>&gt;&gt;<br>&gt;&gt; We can already disable dis=
playable DCC there, so I don&#39;t see why you are even touching the kernel=
.<br>&gt;&gt; It makes it infinitely harder for anyone to evaluate perf and=
 power tradeoffs if you disable it at this level.<br>&gt;&gt;<br>&gt;&gt; T=
he whole power vs perf trade is also not a big deal on dGPUs compared to AP=
Us. Probably needs a better heuristic either way to avoid regressing perf.<=
br>&gt;&gt;<br>&gt;&gt; - Joshie =F0=9F=90=B8=E2=9C=A8<br>&gt;&gt;<br>&gt;&=
gt; On 28 April 2023 10:47:17 BST, &quot;Marek Ol=C5=A1=C3=A1k&quot; &lt;<a=
 href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">mara=
eo@gmail.com</a>&gt; wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Hi,<br>&gt;&gt;=
&gt; It&#39;s attached for review.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Thanks,<=
br>&gt;&gt;&gt; Marek<br>&gt;
</blockquote></div></div></div>

--00000000000085299105fa6d1bfb--
