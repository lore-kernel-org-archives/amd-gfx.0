Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DA3C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 20:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6048110E191;
	Mon, 17 Mar 2025 20:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfXkYJpY";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE0D10E191
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 20:41:04 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6000f9179f8so607924eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742244063; x=1742848863; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=we2TDJlBug4KQDaPnBnJWVVFSOUG3t7pz5G2t7aOowo=;
 b=hfXkYJpY2ze1WXcGjbf/c5IH1wbRw+nbirqHGjiRfIu7IuOPwwOFzRKOgzMOENl/KT
 QImNlmbSc7AwETsFENHpupH9ZEFJM5RfwfDeUTZ11t1TRllHcMf252/FpyCB426Hfh4g
 19cLUrPbB11VPiG69wR6tIVyG1mM0Dhms1TdxPgXJ+vI6qhJv1resIxSmMyQI0f11S0e
 8ldeAXljNyYjDBsdI8cUVSZu9MJjzVlUfPNZuOHnpda0pEhkF1P2zn6axd03p4NNXuZ2
 tfW/ZuRYKl1CgxUZ3W59BIOb5+QgZ8C3o4Xvk+K14bk3xF0ITscks0Y8TY6fR+fpcB9C
 W0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742244063; x=1742848863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=we2TDJlBug4KQDaPnBnJWVVFSOUG3t7pz5G2t7aOowo=;
 b=VVf0aUDHFalRGASwftGMCJpGXBElD0CfPxjlRllGfZAXZio6PaBYzXSsvHknm/rmEm
 Lf6/jWM6QV9pUYZRBQNQg4BQ+BbOdhsAOSXPsho/tF3FAJ7Y0IVz490pXQsnoZi5/l1f
 k6xCJhykeYcjM7lNL2XFkFb+uapUUXKRGnmTlfw1gAGFK8bOJkXlE6G60rttIED39Jxl
 KkqiBMdOfjsZ20YowLRclM/IDjfuga2ZiqnJD+4E2P7lJXBd2ipN0nG0FMahuzaf0+hu
 xowx51avYZWyPYzE0+pHohWDQ6JSzgPgXPThzp9sUg94KqR3QQM7LSGihJ51G49g3fYk
 JViw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzSRiBfO8SMQ/+0B8MQ0b2gECwLzZsd3FDtCn23gPeDj1JkvmJSLLchJiKGIE2tJxwciupYtXb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywg06MW+PERqoEDz98fxS1aW96EL1fwVY7B/VfCcqbjdZvHHS/s
 DpQ9aGC9Ef9DL2/mBQUCqyQAjlBVyvDlb2UGCc35OUyPI/IP7027nqORf1GHbCJZvTdmXGNMCB4
 O62rU0tLLri1UJIqtEcLFSijYI+I=
X-Gm-Gg: ASbGnctW2sm3It3BQNj1SCEApzsJwrc7+a2SimtHbT0io0ofE6k8M/cwNqqkRbcjjpR
 U05/O/EUcQkMj4HlrD3b1I0T8zD3rTWf0D5Wq9Rzq/y16T8ELmCwEb0yrRzDv2sDfyoUCLBypcY
 OekOHc6bmZZ1LkL3ttJBn12itW9C8=
X-Google-Smtp-Source: AGHT+IFbbx/bJkpqpuu6VwynUtbc7W87r/t674Zu4EXvrYZ+85LI5P1aniFsqTjnrRzpQAgG1si2K2Ck79pKh7J1oGM=
X-Received: by 2002:a05:6870:4722:b0:29e:6ddf:22d2 with SMTP id
 586e51a60fabf-2c691117581mr2854025fac.9.1742244063180; Mon, 17 Mar 2025
 13:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
 <DS7PR12MB60057FE73D45BF10F18E0046FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CAAxE2A4KPSniNzPJ=3_JMHmCCyaOR77mXqarQr5=FWi7eiZ9Hw@mail.gmail.com>
 <CADnq5_MLAcnBiZHGC_s8es1p7cOAb6Cg89-VvTa=_c8+R3me=Q@mail.gmail.com>
In-Reply-To: <CADnq5_MLAcnBiZHGC_s8es1p7cOAb6Cg89-VvTa=_c8+R3me=Q@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 17 Mar 2025 16:40:26 -0400
X-Gm-Features: AQ5f1JrX_oSjtVp6jHLbMyK5zg8KbMElIO7HwAJU_kKG4UvBnDrOP9I74tJhFVI
Message-ID: <CAAxE2A7iK39JwoaN8urM5dv0NA6BBT1XChR_Wv7jny=zgnmxng@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Content-Type: multipart/alternative; boundary="0000000000007f7fee06308fcec4"
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

--0000000000007f7fee06308fcec4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:27=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Mar 17, 2025 at 1:23=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com> wrote:
> >
> > Userspace needs a query that a queue IP type is supported.
> "available_rings" is used for that right now, but if that's 0, something
> else must indicate IP support.
> >
> > amd_ip_info::num_queues should be non-zero even when user queues are
> supported. The exact number doesn't matter with user queues.
>
> How will mesa determine whether kernel queues are supported?  Can mesa
> look at amd_ip_info::num_queues and if it's 0, check some new INFO
> query to determine if user queues are available?  If
> amd_ip_info::num_queues is always non-0, then it would be assumed that
> the kernel supports kernel queues, which it may not.
>

That is to be determined. However, num_queues is also used to indicate
whether the IP is supported, so either the meaning of num_queues has to
change, or the way num_queues is set has to change.

Marek

--0000000000007f7fee06308fcec4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Mar 17, 2025 at 2:27=E2=80=AFPM Alex =
Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexdeucher@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Mon, Mar 17, 2025 at 1:23=E2=80=AFPM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D=
"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; Userspace needs a query that a queue IP type is supported. &quot;avail=
able_rings&quot; is used for that right now, but if that&#39;s 0, something=
 else must indicate IP support.<br>
&gt;<br>
&gt; amd_ip_info::num_queues should be non-zero even when user queues are s=
upported. The exact number doesn&#39;t matter with user queues.<br>
<br>
How will mesa determine whether kernel queues are supported?=C2=A0 Can mesa=
<br>
look at amd_ip_info::num_queues and if it&#39;s 0, check some new INFO<br>
query to determine if user queues are available?=C2=A0 If<br>
amd_ip_info::num_queues is always non-0, then it would be assumed that<br>
the kernel supports kernel queues, which it may not.<br></blockquote><div><=
br></div><div>That is to be determined. However, num_queues is also used to=
 indicate whether the IP is supported, so either the meaning of num_queues =
has to change, or the way num_queues is set has to change.</div><div><br></=
div><div>Marek</div></div></div>

--0000000000007f7fee06308fcec4--
