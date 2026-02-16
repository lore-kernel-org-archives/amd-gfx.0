Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0DEE83822
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 18:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82F010E06E;
	Mon, 16 Feb 2026 18:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsXWZ8dI";
	dkim-atps=neutral
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF010E06E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 18:22:18 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-5fdef6330bfso2494043137.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 10:22:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771266137; cv=none;
 d=google.com; s=arc-20240605;
 b=SUt5teKe3T9MjqCAFhJE//aqAeuyv1GKcuxJbbT6G4SzWMZBAxtvcpjQ96VwexRJMU
 5NUUPE0RGA0qx9bzDRP/Pro5H1mas0rI9YRO8swHjsaKN+Fa3LU6Ot5NPL/Xi5nJ+FCM
 aWz+avAo15NmzJDEW4YzHwqcUdfNkaaH8giOZcNICSSibSNWRv6ccpJ1rIdYLfXqputi
 nvEnzxIt0cGLv64xbNUB0XXk6qHDcT359K5E53AsRP0XFhDqI7x3WYZIkUvKnD9vaP1D
 9T1XSYA0uawu9xiva/eyFy+hc8cPV9llJUBcYLqwkrNji/D/auXRxVzqddhJlvnPHvn0
 WPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2lSKh8bqqRKiTXHInvNbfCQ1fFlABnA8S0OZcV1ReEQ=;
 fh=22Om4p1ewSHVaZ7cIzjg1nKCodyVx60Z2KRFH8JaKIc=;
 b=GiMG1cFqFNXIKh+L6i8fzBs3rolN97lN6Tj6wSDsAWnLvI9ZtNDYQ+5Y8RaFxy2FqC
 zdJY3CGryfOUdo7Hz+4dPuXeJW6E8zSg//oMNnhl8Pf/TZMYXY+ZR9/Ye2CpuI3/U+LH
 Nenpim+JvTNHXiGDCJjldJGdFdPy9QjOeP4ZVt45f+JPUfKpm6RzHyr5axBV+HHnP+bF
 ftnIE6wxImoSaLDST67HJf5hNvF514kXNQhq1/4mXWdp8eFrXQaQdJPe8KURtrQbTZlk
 QWClVuu0FgRVGvDdNPpmSLTvQRB1xzkoReQPPeRQ3Hk5glQHUmS224z1C0lNqPpAnMM8
 zJUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771266137; x=1771870937; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2lSKh8bqqRKiTXHInvNbfCQ1fFlABnA8S0OZcV1ReEQ=;
 b=nsXWZ8dIIOLmpDO2YY/xXaOx79+4OhGH6m68bZ8yMLxqU5+fD9HCpcNVSVMAapYkFf
 wgYNla5K95T5XWUoYDWEjtJLmPrs3eqGLB4k45O1GN/vioga4Pug5JfBTHfMq9LNoV8K
 qDZw8YRuraLv5DLDYKtqm6s0FScj/z/B5dseWrPK2VhS9RA2ulwfIXImst1rxuHTandL
 i4c1cWQkE2qEjaFLtqR+HC0ZBTQk8S5cA8GmCvfEaa25bIZKUQHS57iZvsTVLPt+NIgd
 HI8DZGMcLRKN5D+EAd5Sp26azNCEsQLMqprIsEoiBuTQLpe46F408ik/eagroezsRcS9
 LyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771266137; x=1771870937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lSKh8bqqRKiTXHInvNbfCQ1fFlABnA8S0OZcV1ReEQ=;
 b=d/Kb4xdRaHp8aZfwav682TQGbger57T1bSFnTbOxtzPjVW4uvOgE5QcN1x01i43gN3
 eYA3XFyVGxGrs9J0vp6lq8kndH7UD3n2IvQ/NFplW4OcNbIsKJgcqOUPKooeMHdhTC/g
 n4ztC4DgkqEz1MZsTa4YW/X5SvBJWWAxyKQe1BBxR6TxcHGjJYAXJJiPozz5/91aJUDM
 I2CUq7y/UKrssybEmAl4LLo3PqU47uAFILWmqQQi+Bz1NTDjJY5gXyYYnTM54i6HLRm1
 gQLYLb+RIUWPqjp8qaNRLmXSTEc/VNrx31xzgPDxeCgd+3pJaBi6VFM7lJ48qTo/RWZU
 loCw==
X-Gm-Message-State: AOJu0Yw0yJL7mB9CkDginY7+F+x4CmNzEL+RktGAiUqXyU85ebqpwDT9
 OGTCPA4O7lnqRPyAdd6oNCtZYYUdEHBxdY2FnROKQd7bBAtGA6QCx4ZykZGIaZ9KFkrBb0rNhZU
 1JGSbMTNSr7H8UO7gBTyzwkypwhZJN6A=
X-Gm-Gg: AZuq6aKMzlo3VNkVg+JT8+gOzpYIwZNHb1NTEOT7hDD0eeULBHCaH0FhOWGpGvO3Khr
 JAGplHNegptMxwPW8r74gqPRUJRVyVJJwF1tSaWbTn8Z86Lh1aRroW4rXFmc3xlW+cqC0tgFIt8
 f8kTGuiOZ4L0yuJW938JAb0jbPrVEQkTuSnobMNtL446zgV8NEza81F1mIxuzlZA3snupUwTZ3k
 yBMGATXbQrEkFVbusenzPszOowGhz0hhVssNAKAPL2VxN7d1OACHC2nPJm3aFYmQAI1zebN/Jp8
 zC8NbP1kCeH/JNwWxjA=
X-Received: by 2002:a05:6102:2921:b0:5f8:e367:959 with SMTP id
 ada2fe7eead31-5fe2ad39ba0mr3449353137.7.1771266136943; Mon, 16 Feb 2026
 10:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <2869796.vuYhMxLoTh@timur-hyperion>
 <376e868d-8962-416f-bdd9-a1eaf1094cc3@amd.com>
 <3689606.dWV9SEqChM@timur-max> <acb8eb50-d356-449d-9c0d-3b090eadf7ed@amd.com>
In-Reply-To: <acb8eb50-d356-449d-9c0d-3b090eadf7ed@amd.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Mon, 16 Feb 2026 19:22:04 +0100
X-Gm-Features: AaiRm512PJQhZ4JdQEOS3q-N71JeBzMdstWyvVu0QCbL901k_JCFzsuey5C4ce0
Message-ID: <CAFF-SiUtF8FS2EhsdLXLoD6b3H9pi5Gkher=quFNkW5Krv=qYA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e530e4064af508f0"
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

--000000000000e530e4064af508f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Hung <alex.hung@amd.com> ezt =C3=ADrta (id=C5=91pont: 2026. febr. 16.,=
 H=C3=A9t
18:49):

>
>
> On 2/16/26 08:19, Timur Krist=C3=B3f wrote:
> > On 2026. febru=C3=A1r 15., vas=C3=A1rnap 6:06:33 k=C3=B6z=C3=A9p-eur=C3=
=B3pai t=C3=A9li id=C5=91 Alex Hung
> wrote:
> >> On 2/9/26 15:11, Timur Krist=C3=B3f wrote:
> >>> On Monday, February 9, 2026 6:21:38=E2=80=AFPM Central European Stand=
ard Time
> Alex
> >>>
> >>> Hung wrote:
> >>>> Hi Timur,
> >>>>
> >>>> I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI
> is
> >>>> not set, or with the following change to Makefile. Can you check?
> >>>
> >>> Hi Alex,
> >>>
> >>> I didn't see any problem when I submitted the patch, but it's possibl=
e
> >>> that I overlooked something. I will fix it in the second version.
> >>>
> >>> Thanks,
> >>> Timur
> >>
> >> I can fix them them manually.
> >>
> >> This series is Reviewed-by: Alex Hung <alex.hung@amd.com>
> >
> > Thank you Alex.
> >
> > I will send a second version of this series where I fix this and the
> other
> > feedback that I received.
>
> I pushed this series to amd-staging-drm-next and you can send a new serie=
s.
>

Hi Alex,

I would strongly prefer to have the other series "drm/amd/display: Fix and
cleanup analog encoders" merged before this one in order to make it easier
to backport that one.



> >
> > Timur
> >
> >
>
>

--000000000000e530e4064af508f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Alex Hung &lt;<a href=3D"mailto:=
alex.hung@amd.com">alex.hung@amd.com</a>&gt; ezt =C3=ADrta (id=C5=91pont: 2=
026. febr. 16., H=C3=A9t 18:49):<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><b=
r>
<br>
On 2/16/26 08:19, Timur Krist=C3=B3f wrote:<br>
&gt; On 2026. febru=C3=A1r 15., vas=C3=A1rnap 6:06:33 k=C3=B6z=C3=A9p-eur=
=C3=B3pai t=C3=A9li id=C5=91 Alex Hung wrote:<br>
&gt;&gt; On 2/9/26 15:11, Timur Krist=C3=B3f wrote:<br>
&gt;&gt;&gt; On Monday, February 9, 2026 6:21:38=E2=80=AFPM Central Europea=
n Standard Time Alex<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hung wrote:<br>
&gt;&gt;&gt;&gt; Hi Timur,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I just found this patch won&#39;t build unless that CONFIG=
_DRM_AMD_DC_SI is<br>
&gt;&gt;&gt;&gt; not set, or with the following change to Makefile. Can you=
 check?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Alex,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I didn&#39;t see any problem when I submitted the patch, but i=
t&#39;s possible<br>
&gt;&gt;&gt; that I overlooked something. I will fix it in the second versi=
on.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Timur<br>
&gt;&gt;<br>
&gt;&gt; I can fix them them manually.<br>
&gt;&gt;<br>
&gt;&gt; This series is Reviewed-by: Alex Hung &lt;<a href=3D"mailto:alex.h=
ung@amd.com" target=3D"_blank" rel=3D"noreferrer">alex.hung@amd.com</a>&gt;=
<br>
&gt; <br>
&gt; Thank you Alex.<br>
&gt; <br>
&gt; I will send a second version of this series where I fix this and the o=
ther<br>
&gt; feedback that I received.<br>
<br>
I pushed this series to amd-staging-drm-next and you can send a new series.=
<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Hi Alex,</div><div dir=3D"auto"><br></div><div dir=3D"auto">I would strongl=
y prefer to have the other series &quot;drm/amd/display: Fix and cleanup an=
alog encoders&quot; merged before this one in order to make it easier to ba=
ckport that one.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
&gt; <br>
&gt; Timur<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000e530e4064af508f0--
