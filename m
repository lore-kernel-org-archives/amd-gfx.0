Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EBDC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 18:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CA510E355;
	Mon, 15 Jan 2024 18:30:34 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C5210E355
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 18:30:33 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5f0462ee645so12646537b3.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1705343433; x=1705948233;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IvfxaVZfyr/C+QHDiS/IKvS7dfJi4VNqlYpBH3VCVrU=;
 b=ZT4ssemDukjkFFE40/oUeQN5tZhL6slDfOavMpTA9wMg1ssSmdN/Hite8wzF1dqYlt
 Bpbb4eSI6rtSGS/70x36XuaEfYwbszPebOnd0I2nWFzPk8Xo9qId6hMqlYzXrSeGGxQQ
 K83UAzBBrr6xJtsBAjn4zLHGM8jygFvzIBLgLcJWbnWbVlrd2cau7tj8XxxhiQXjzg82
 3nsIL68BYXyaF67+0QGBTbChroB0c5t1wm7oiQ2rElbpHorKkMAn9n/bHuPNBf6YVn8n
 zBxrgDzeJ7w9+Osijpe1Z3cFoYlbVKikeq3wqPy3/GzxUDy9MnMgs30e0zKHY/wm6mzf
 ciPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705343433; x=1705948233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvfxaVZfyr/C+QHDiS/IKvS7dfJi4VNqlYpBH3VCVrU=;
 b=YpfGNLUZPHoule02c7N0pB/DC9gOMe+DtrCmky7f33/uqGEsyYCA9BdimwQd9WC/Ck
 b6x4+sdZ8DGqGfOtx7O7aIKIg+aZKCFEDLChBc8usatSwrv2xpw/tJ4HarFGvEnR8mlQ
 NGcO0uJdsbvmdDHi2nKFg8kEJ9TwYEL+VWzu9n5zk8yxV1xM0AW1iX/0HjsdSTTh0LBn
 VZBofBvZNN5FRAXd5e7yvLa5uHZruUeMfCbfy6VoKSqIr5EdSMz5U1zqCtTH9qop5nGN
 GhSbRbxiMcPAlESIlOUMNwj+SmbHgrGx7HVHd92q1uBH1X4KUvY6WUKFlcPqabvzOY+l
 GnvA==
X-Gm-Message-State: AOJu0Yx5FJp1E/+DtLmGwJ52HJjI3pq2mtvJgZGXF3SRM3Y08qbVoSlY
 nHAI7oDkzABDOrhwfTQR5f4tN2IZ3x2zMjSD2cRcAMXR9dvlPw==
X-Google-Smtp-Source: AGHT+IHgHhKCozqDjB334oeKe9jpbISzxyVPOZkWfKwBgIvdy+r6TVDdbLzRDX9RT1U8dYKeOWSLrl3ChAi+z6Rzh2A=
X-Received: by 2002:a81:a701:0:b0:5f6:b6b7:8a04 with SMTP id
 e1-20020a81a701000000b005f6b6b78a04mr6009485ywh.1.1705343433039; Mon, 15 Jan
 2024 10:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
 <c9b839cd-4c42-42a6-8969-9a7b54d4fbe8@amd.com>
 <0e701278-a633-403c-b397-e4f772d66c5a@froggi.es>
 <aca706e6-58bc-4c38-bbfe-19137f38c897@gmail.com>
 <9a07c4e4-321c-4f75-aeae-81ed90038365@daenzer.net>
 <f2153219-e791-4e97-96eb-26094d7acf87@froggi.es>
 <5c99ec8c-142d-4877-9624-c8ce0373fccd@gmx.de>
 <5ff32f43-46ea-4e74-8db4-c23e0b03b429@daenzer.net>
 <8e5cd59e-075a-480e-8452-87924580122d@froggi.es>
 <1dbe811f-64a0-4ccd-88cf-3fd30f79f7bc@daenzer.net>
 <c36400bd-b8f2-4026-b989-f4e1854b05ca@gmx.de>
 <7194a09a-afe8-4eae-8288-c72e2ac7d0a6@daenzer.net>
 <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
In-Reply-To: <51b9ffc3-9ab3-4a06-9307-6b2a343f6bc6@gmx.de>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 15 Jan 2024 19:30:21 +0100
Message-ID: <CAP+8YyGg91f_z2ktrd7HQMtOSHn34F-8x7O2iRv=TTrXo2NNoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: Friedrich Vock <friedrich.vock@gmx.de>
Content-Type: multipart/alternative; boundary="0000000000008c015d060f00352b"
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
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000008c015d060f00352b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 7:14=E2=80=AFPM Friedrich Vock <friedrich.vock@gmx.=
de>
wrote:

> Re-sending as plaintext, sorry about that
>
> On 15.01.24 18:54, Michel D=C3=A4nzer wrote:
> > On 2024-01-15 18:26, Friedrich Vock wrote:
> >> [snip]
> >> The fundamental problem here is that not telling applications that
> >> something went wrong when you just canceled their work midway is an
> >> out-of-spec hack.
> >> When there is a report of real-world apps breaking because of that hac=
k,
> >> reports of different apps working (even if it's convenient that they
> >> work) doesn't justify keeping the broken code.
> > If the breaking apps hit multiple soft resets in a row, I've laid out a
> pragmatic solution which covers both cases.
> Hitting soft reset every time is the lucky path. Once GPU work is
> interrupted out of nowhere, all bets are off and it might as well
> trigger a full system hang next time. No hang recovery should be able to
> cause that under any circumstance.
>

I think the more insidious situation is no further hangs but wrong results
because we skipped some work. That we skipped work may e.g. result in some
texture not being uploaded or some GPGPU work not being done and causing
further errors downstream (say if a game is doing AI/physics on the GPU not
to say anything of actual GPGPU work one might be doing like AI)


> >
> >
> >> If mutter needs to be robust against faults it caused itself, it shoul=
d
> be robust
> >> against GPU resets.
> > It's unlikely that the hangs I've seen were caused by mutter itself,
> more likely Mesa or amdgpu.
> >
> > Anyway, this will happen at some point, the reality is it hasn't yet
> though.
> >
> >
>

--0000000000008c015d060f00352b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 15, 2024 at 7:14=E2=80=AF=
PM Friedrich Vock &lt;<a href=3D"mailto:friedrich.vock@gmx.de">friedrich.vo=
ck@gmx.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Re-sending as plaintext, sorry about that<br>
<br>
On 15.01.24 18:54, Michel D=C3=A4nzer wrote:<br>
&gt; On 2024-01-15 18:26, Friedrich Vock wrote:<br>
&gt;&gt; [snip]<br>
&gt;&gt; The fundamental problem here is that not telling applications that=
<br>
&gt;&gt; something went wrong when you just canceled their work midway is a=
n<br>
&gt;&gt; out-of-spec hack.<br>
&gt;&gt; When there is a report of real-world apps breaking because of that=
 hack,<br>
&gt;&gt; reports of different apps working (even if it&#39;s convenient tha=
t they<br>
&gt;&gt; work) doesn&#39;t justify keeping the broken code.<br>
&gt; If the breaking apps hit multiple soft resets in a row, I&#39;ve laid =
out a pragmatic solution which covers both cases.<br>
Hitting soft reset every time is the lucky path. Once GPU work is<br>
interrupted out of nowhere, all bets are off and it might as well<br>
trigger a full system hang next time. No hang recovery should be able to<br=
>
cause that under any circumstance.<br></blockquote><div><br></div><div>I th=
ink the more insidious situation is no further hangs but wrong results beca=
use we skipped some work. That we skipped work may e.g. result in some text=
ure not being uploaded or some GPGPU work not being done and causing furthe=
r errors downstream (say if a game is doing AI/physics on the GPU not to sa=
y anything of actual GPGPU work one might be doing like AI)<br></div><div>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;<br>
&gt;&gt; If mutter needs to be robust against faults it caused itself, it s=
hould be robust<br>
&gt;&gt; against GPU resets.<br>
&gt; It&#39;s unlikely that the hangs I&#39;ve seen were caused by mutter i=
tself, more likely Mesa or amdgpu.<br>
&gt;<br>
&gt; Anyway, this will happen at some point, the reality is it hasn&#39;t y=
et though.<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--0000000000008c015d060f00352b--
