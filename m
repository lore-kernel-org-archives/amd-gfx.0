Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 22:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA9A2075F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 22:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZJUWGYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA9A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4647F89722;
	Mon, 25 May 2020 22:07:53 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6286893ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 22:07:51 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id u5so9116757pgn.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=aT4CaCQd/M/aLFVh90rAWA/xL3wGxZzYCGYut4HhGAs=;
 b=TZJUWGYpOkeOkb3wKX5LFONa1QWZL8u8lQsieQMHsuuilhpgVIelTYv45KDwm7Enqb
 UV94Gjrb7shm6CwMrn8fL2ycWHyk0w3gxNzYZ3CoxAxrG6KJxNHUV/jeDc+R7HvNTVj5
 Ro/buGas0eSttWysNAl8sA5+Nb7lrpZ1gsV+mTeRaHbKqzCeRBz/hkYGGJg9+WmurPxz
 wZHcvfYuUJlecNM177wqVNQ5R+8HHKjUheRdenBD7iCb56QgtKD+Y8oPxYhHYLOQ1sjK
 4CgzUm/peXSlEsgN7o52sTcyu9cK+C6fXo5389TEI6rYBuzAg7phoTLEB5yV46NLUfPA
 R7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=aT4CaCQd/M/aLFVh90rAWA/xL3wGxZzYCGYut4HhGAs=;
 b=gJ47x4LqMb62TWoSu7//iQ0aXJ+4aNzObrcshlh/7TUS9RiALeKYqbY2giQMHnz6NO
 8QBJ8tqQqVgq5EjE0NxG3Pwl8xkrmTiS3gID6JWStAmsPiz9PnfhdTiqcluC301fe3md
 mx74xpPwwrhKBesUApZWk36bY6uQTSxgk9ydPMl2wT8j2ILqmJVZdKtWab9BQW605PpW
 xDs3T67RHCRwdGZkc4JKXp7t93Od0CS/4GQWrVjOzyND6K+AOhEfYDIAO63Jcw+UIg3a
 pz74/rmPP5QiDMSfRGfhnRvCJ8OTaDoIV+7c7wQQzMXhC0eZuJWcM0CeoU3Ei3PDYyKm
 LayA==
X-Gm-Message-State: AOAM530lkwXmrNbocAuHOjIoClPKFSnKSi80IeUz+kCa4HBJRMoW0etR
 pwKbtWyZwpCP4lSbIuPwQTv/AwWeHfJmNxHSCHgTE741
X-Google-Smtp-Source: ABdhPJw6xPkc60k2r3IKUR4E/qdgaVWxsi4bbms2XQYTowYMvlcd0y5cc0rjL4QEdOb5TUzj9XzBVDbSyhobJ51wvOg=
X-Received: by 2002:a65:5bc5:: with SMTP id o5mr22593934pgr.233.1590444471380; 
 Mon, 25 May 2020 15:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
In-Reply-To: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 25 May 2020 18:07:14 -0400
Message-ID: <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1394669348=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1394669348==
Content-Type: multipart/alternative; boundary="000000000000c06f2a05a6803583"

--000000000000c06f2a05a6803583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If a user mode driver is changed to rely on the existence of implicit sync,
it results in corruption and flickering as reported here:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/2950

Marek

On Mon, May 25, 2020 at 6:05 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:

> Hi Christian,
>
> Bas and Michel wanted to discuss this. The main disadvantage of no
> implicit (pipeline) sync within the same queue is that we get lower
> performance and lower GPU utilization in some cases.
>
> We actually never really needed the kernel to have implicit sync, because
> all user mode drivers contained hacks to work without it.
>
> Marek
>

--000000000000c06f2a05a6803583
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>If a user mode driver is changed to rely on the exist=
ence of implicit sync, it results in corruption and flickering as reported =
here: <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/issues/2950">ht=
tps://gitlab.freedesktop.org/mesa/mesa/-/issues/2950</a></div><div><br></di=
v><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, May 25, 2020 at 6:05 PM Marek Ol=C5=A1=C3=A1k=
 &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div>Hi Christian,</div><div><br></div><div>Bas and Michel wanted to discuss=
 this. The main disadvantage of no implicit (pipeline) sync within the same=
 queue is that we get lower performance and lower GPU utilization in some c=
ases.<br></div><div><br></div><div>We actually never really needed the kern=
el to have implicit sync, because all user mode drivers contained hacks to =
work without it.</div><div><br></div><div>Marek<br></div></div>
</blockquote></div>

--000000000000c06f2a05a6803583--

--===============1394669348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1394669348==--
