Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7E3C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F0B10EDD8;
	Fri, 28 Apr 2023 19:47:35 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2364010EDD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:47:34 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-50685f1b6e0so173621a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682711252; x=1685303252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ngG8XUFIlyDy4UuIVraS2uYzrEj95MNZhnXqB9qKut8=;
 b=s3PcWM0FdQQiPPkTtp3usnJWsJ2goicIDqkVU9d1RhhSmigC8SjiZcVzdIB1eI6q2q
 SUdtnOtMcuyEkFnTbt/4gpPZWMN65vUeGhRK/zPjtpuD+RxJDmxaHh9YUZIqvl9hjxUz
 h/eVLpB8fDxbmBrawwFuPzdEPdoBInvRWEgEYI4FuSWcezNX2bWKxB0G6d03AUg6o1NM
 Gi/JjQpbRHER3DnmN9RTscEwyfrVYdzGQo28hh46HoHU6IdEkVIX5G9s1puB4Wv8ehnh
 WAEDECdmpxAgsEw8x9+blPdwsM0Aq5ILvuoxSff9HAoQ3mC6a7mr9Ye52KBDhTCetX00
 sjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682711252; x=1685303252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ngG8XUFIlyDy4UuIVraS2uYzrEj95MNZhnXqB9qKut8=;
 b=Ft4XSbJ8OlHcoFUt0haExg6FKgJhPwGywmHfqPKBpaZQ/8eOzQCrX/jXlWGffbxKLq
 WEMe5wMYvnVbIst3YXPFUMta75Xl0o2K6MCb/sTn/7DTgrIEP06HmOcLOhdWLymdoAsh
 uXo81x4v8mdvt/a8lhT0+SJU3Pf863fOMt16jta9/ho2eE1bbz9Zig8/3bK6tfT2nhJi
 tn07uf5jH1FQsRv5JQVrnZzCOA4FP5vSQNL4mLNdM5wU3nDUY/pSyJa7ifQUOWP35wPv
 gyS64HTpYetdkdDYxqWG+/cOXcw6A4hh+Uc9gcrakTfSdbb2TimhuY7QIwZ08b8YPe1I
 odTg==
X-Gm-Message-State: AC+VfDyTPQVqasOIcc/yoJEZFF/lTXFGU/GJ/z156GmKFY8Ad7bgd6U2
 Mbn6M8lXw7Vpk2pAoVedOMQuQXWvKFypbFiJravxJH202xY=
X-Google-Smtp-Source: ACHHUZ6X/xg3PyoFBchD4SyF9ee99T5uPApaex3J2qPKusKaCQGHp1P1nRqpRBtHfVtPTtdscXKftf0YOcfINNZIc4A=
X-Received: by 2002:a17:907:36cb:b0:8b1:7de3:cfaa with SMTP id
 bj11-20020a17090736cb00b008b17de3cfaamr5582192ejc.3.1682711251867; Fri, 28
 Apr 2023 12:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
 <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
In-Reply-To: <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 28 Apr 2023 15:47:20 -0400
Message-ID: <CAAxE2A58Wp-2z3CKadQfgGkAZA2emH5Z3Z0_soiZEPNmKhkuBA@mail.gmail.com>
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: Joshua Ashton <joshua@froggi.es>
Content-Type: multipart/alternative; boundary="0000000000006d5f0405fa6abe56"
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

--0000000000006d5f0405fa6abe56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I thought the same thing initially, but then realized that's not how
modifiers were designed to work.

Mesa should expose all modifiers it wants to allow for 3D and it doesn't
care which ones are displayable.

The kernel should expose all modifiers it wants to allow for display.

With that, Mesa can still use theoretically displayable DCC, but it will
only be used for anything that's not the display.

We can, of course, disable it in Mesa instead to get the same effect.

We would need perf numbers for dGPUs to be able to tell whether it's
beneficial with the cost of DCC retiling.

Marek

On Fri, Apr 28, 2023, 12:11 Joshua Ashton <joshua@froggi.es> wrote:

> I really don't think the kernel isn't the right place to do this.
> Is there any reason to not just disable it from the Mesa side?
>
> We can already disable displayable DCC there, so I don't see why you are
> even touching the kernel.
> It makes it infinitely harder for anyone to evaluate perf and power
> tradeoffs if you disable it at this level.
>
> The whole power vs perf trade is also not a big deal on dGPUs compared to
> APUs. Probably needs a better heuristic either way to avoid regressing pe=
rf.
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
> On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.com>=
 wrote:
>>
>> Hi,
>>
>> It's attached for review.
>>
>> Thanks,
>> Marek
>>
>

--0000000000006d5f0405fa6abe56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I thought the same thing initially, but then realize=
d that&#39;s not how modifiers were designed to work.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Mesa should expose all modifiers it wants to =
allow for 3D and it doesn&#39;t care which ones are displayable.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">The kernel should expose all modif=
iers it wants to allow for display.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">With that, Mesa can still use theoretically displayable DCC, bu=
t it will only be used for anything that&#39;s not the display.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">We can, of course, disable it in Me=
sa instead to get the same effect.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">We would need perf numbers for dGPUs to be able to tell whether =
it&#39;s beneficial with the cost of DCC retiling.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Marek<br><br><div class=3D"gmail_quote" dir=3D"a=
uto"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 28, 2023, 12:11 Josh=
ua Ashton &lt;<a href=3D"mailto:joshua@froggi.es">joshua@froggi.es</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div>I really don&#39;t thin=
k the kernel isn&#39;t the right place to do this.<br>Is there any reason t=
o not just disable it from the Mesa side?<br><br>We can already disable dis=
playable DCC there, so I don&#39;t see why you are even touching the kernel=
.<br>It makes it infinitely harder for anyone to evaluate perf and power tr=
adeoffs if you disable it at this level.<br><br>The whole power vs perf tra=
de is also not a big deal on dGPUs compared to APUs. Probably needs a bette=
r heuristic either way to avoid regressing perf.<br><br>- Joshie =F0=9F=90=
=B8=E2=9C=A8<br><br><div class=3D"gmail_quote">On 28 April 2023 10:47:17 BS=
T, &quot;Marek Ol=C5=A1=C3=A1k&quot; &lt;<a href=3D"mailto:maraeo@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt; wrote:<bloc=
kquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>It&#39;s attached for re=
view.<br></div><div><br></div><div>Thanks,<br></div><div>Marek<br></div></d=
iv>
</blockquote></div></div></blockquote></div></div></div>

--0000000000006d5f0405fa6abe56--
