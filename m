Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2103C71159
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 22:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4740E10E45C;
	Mon, 16 Jun 2025 22:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KkLib9pK";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C107110E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 22:23:50 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-313067339e9so859824a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750112630; x=1750717430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHa4TeqieWlFMd64hCWBPNdDQWDYES0VAQqR/tTebmo=;
 b=KkLib9pK1umBrDJ6EXcNDgc3HpgwMHxWyyPis6+Ke5Mf685C0ppSeGdDtS6ISMPvRm
 tuzEzXhhUq0nkHSzmxN5h+EYHdW7di7xj6yCWPPeYSZTt+rX5mltnQCWFg161mhlHVuO
 XSUgyBlGfvilgDGSSj5BKV4qD0nHP1TFYVKntXf8tfPQA44xqLhxZ5XOHN0SVcnJ/hcq
 5NgLvC3/eC09bVxwUaM7uWUH3704Zyw4777eJg8bHbqHEuq69fcwSNK7kXSzcFnqtlzg
 NwgSP+YK3NEEnio+HgT2A4OEJ5tspfmeq3HuRseB4bHji88neCrYjnKxsHELpVQ6kHAb
 nT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750112630; x=1750717430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHa4TeqieWlFMd64hCWBPNdDQWDYES0VAQqR/tTebmo=;
 b=ETqt7SCLRo5Hau4mdOrcEL1TlIELwH/rW8XQPsIxJr/dln4Sgppx7owQ/C2NseOQdO
 Ms85DyYJNEDR2zKenOkl7FjnGPv3NNE30OuvdF8AoTXZs8b/sPwOo3kcuW2wz1BxxjjW
 /fMzi4yGn3panOJiRjJu8IZSuraMGIwLONsrAsRq/qaD8CAo5nhcVyZqlvyOKXYMVdw0
 py5Lms2cj0ohOI3FPndbPF38kwuwP615Wq4XDLPQmgDx+7LclHdp+GxezAyjPTiqiHa3
 5oQ8isVy2DfSW04DEPQktN6I/xYHBRrcMM0c4JcfT31pezdrO56EQHxzl+qdpQ2GC9do
 C7sw==
X-Gm-Message-State: AOJu0YwkzTmzUElJIEcEnXl0WpVtHz1mIYc+66dqgtQ4xpOg++Y535xi
 iePe6h0jWCSXXJrlgzaZHfUjmTT9KwzxWym0nfZchJiQlpETxKs7+hKhuMgwH3TMCvS6H9SquPf
 NCThdlqJvL14XgEy19h9lDnnolX6cvFI=
X-Gm-Gg: ASbGncvwZPGGe6ocp2vwKBSmvBDj2+idT7j+quXhfHj92JZaMNKfkXkp+gQmaB3KoxJ
 u469QVoBBJclqVIOX/oSjMc6uzx/En5WJs8yPZNC9LPN6bChEvomF6ynwkOk7KyiGKlN5CHA7xp
 wFH7skplRk4Tv3vWrduE/X250dT98u85uLocyxkA0T1VbSu6dhAK9Js08=
X-Google-Smtp-Source: AGHT+IEfpjcRONL0OUa3CR7tBjzpKX60b8PDOZDF81SoiMfQmhXKBcNhBDrINESMpKzUmTYcGTlquOZUOe51m0nSmqQ=
X-Received: by 2002:a17:90b:17c6:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-313f1befa77mr6212925a91.1.1750112630101; Mon, 16 Jun 2025
 15:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
 <CADnq5_PatAYdyKGVJpX5TrVJ451Ga9PJjCx85jna+CUxsaFAhA@mail.gmail.com>
 <8o8j5o9K-GIowaV5BW0uUds5QSczbsDlObPMAEUyGjPMV1G2tq-3sdYaQwbZHt_d4p-9sqBe5OnsUkkbS2gb6eZT1d5KiOXyTdz3vy75_V8=@protonmail.com>
 <EefQ4XqoUhDVKwtzYbP7Cwv1m6p8brSTBJzVQeojHh8X688L3QdBfGkakTuU0yf3lWfne5Bhcj90MXHhB9nblEqobkXeWvluAnwrplGkH2A=@protonmail.com>
 <CADnq5_MoZ7W0pf2BFx7Rs2e+6YyJNO2KBCfjjnrkv-+hKNqduA@mail.gmail.com>
 <gE19BlFWNv1spLRDzd5---KtXkBEYRKTKFR-R2YSWJ4rBnQG8R_Gaeqh56sFHvTc-QlLLPc-rYgKCJSCgxsTlKUhJ-zGovqmZq7BnjVlZTw=@protonmail.com>
In-Reply-To: <gE19BlFWNv1spLRDzd5---KtXkBEYRKTKFR-R2YSWJ4rBnQG8R_Gaeqh56sFHvTc-QlLLPc-rYgKCJSCgxsTlKUhJ-zGovqmZq7BnjVlZTw=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 18:23:38 -0400
X-Gm-Features: AX0GCFuZzD-xvftZKsFLucgvXuY9hTzDfJAdF70sqoBNVRTwHkhTI-373LYwlNU
Message-ID: <CADnq5_PL+0Zu4gPgu3_uxh68pB2vS-91bTtk9_cTpcr-5gRRAw@mail.gmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
To: SyntheticBird <syntheticbirdxmr@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Jun 15, 2025 at 5:51=E2=80=AFAM SyntheticBird
<syntheticbirdxmr@protonmail.com> wrote:
>
> Dear Alex,
>
> The situation is more than concerning and my frustration, as well as othe=
rs, is growing.
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3787
> https://gitlab.freedesktop.org/drm/amd/-/issues/2950
>
> There has been a hundred of reports on gitlab, I can find more on reddit,=
 tech1level forum, phoronix forum, I got confirmation by some folks on Matr=
ix that are staying in 6.1 and are starting to mock the amdgpu driver. I've=
 seen features after features being merged in amdgpu yet people are laughin=
g in forum, at how bugs are not fixed. On reddit, some users decided to go =
back on Windows because of it.
>
> There has been 4 bisection attempts so far, that led to no result, and (I=
'm in part at fault here for having used an experimental filesystem with ma=
jor version changes). There are people that managed to grasp debug infos be=
fore the timeout.
>
> In two months, this significant issue will be a year old.
>
> I do not understand, how you guys are not hitting it/trying to bisect it.=
 Are you not keeping your machine up for more than 30 sec.
> With the immense spectrum of hardware concerned, I cannot believe that yo=
u guys are immune to this. And I cannot believe that you guys are letting t=
his rot.
>
> Right now, only a minority is managing to recover their session after a f=
ew minutes. Some people are able to get away with it by enabling the debug =
flag, but this only work for some people and there are no guarantees that i=
t will last long.
>
> Please,
> It's time to forget trying to pass the hotball and get a maintainer inves=
tigate and fix this before it gets too late. If we let it rot another year,=
 no one will be able to bisect it because distros and hardware will make us=
e of recent versions only.

Unfortunately, not every issue is readily reproducible and the issues
you've noted are pretty generic.  There can be a lot of root causes
for these kinds of issues.  If you can't bisect your issue, I would
suggest trying a newer kernel as we've fixed quite a number of issues
that manifest in a similar way over the last few months.

Alex
