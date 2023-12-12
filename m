Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38015C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 01:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A121410E060;
	Tue, 12 Dec 2023 01:52:50 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400D310E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 01:52:49 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so1262232866b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702345967; x=1702950767; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tcsqxaL4flCCT5BFcYcFQa5xlm0vUAhz15fmFCcpB/s=;
 b=N878oyRy+FctspfgXGPlgH4/pQ4lrRlEzrSmWR0aP+k9S4nLn6ubrkXyqVmn35uAF/
 9FG1+BVokJsoS7a+Zx+9ej/EpRCGhVxDutxenp1Li56db48oEZTsRs/Azf1nX60K/ELP
 hZhumHJws+pIIc9LRmhVoeiau401B7P2Ri3Q9x0jBw34X8n6GWefmM0qW3MWT0DKZkeG
 RyD/x3xni8lil/WNv4aObgkKJnOMDEHxD4wirpXzHRcTISQtyTcIenmipy/puIW7ZNNp
 U0JK83fhcVdo0G9Zv4+D6vIQmf8V7eqUinVgIsoKpN/X++SmHlW0ePLm+BtnJScnkqfh
 sBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702345967; x=1702950767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcsqxaL4flCCT5BFcYcFQa5xlm0vUAhz15fmFCcpB/s=;
 b=sTbaNKQw7TpAW8MEbGwNBxHej4ULBWC+CBpsKQTl8Hkq/bKPdO4uD5Us/0AiyGBWyv
 lvifEQBgfUEDXQj1X8zey9BZCUvepspBirem/k1B9AkQDujEV/3urbyQjgS+VqzckGiI
 57H8lrrYgefdg6PgyQ1xhdDhP3EGA3eC3kMvUsMtprOMVNX/+R84KKzM2WfOGao0SxMZ
 /z+ojMwSnr33hHAwzxk/P2hxL4vUvh6aYCpX0obdwRnfMHn1mxzHTJm6G84KrpD9Q0Yt
 ezVHyqrkoM++6/AL7bHv8rmD3ah6xloRK/7seV7kzcIMuklQQNTgCDpiV06rP0YsNorV
 9Y1Q==
X-Gm-Message-State: AOJu0YyeRKYwzp4RqFiBwgpYlompbzforFwyZ9UUMayQtqlHynK0+vTo
 8pnQXE/Wu7Miw6rVu+O16I/6klSZkrjQAjic5BXQlmYs
X-Google-Smtp-Source: AGHT+IE2s4uz2z4jx8PPpRdyTrnvLhSzB60rkXZL/Ha43mvTM2daEPhx5OtmzTGzCywCid2ErtKzKpIRh9woDfMTpis=
X-Received: by 2002:a17:906:5a6b:b0:a18:a5b1:31a9 with SMTP id
 my43-20020a1709065a6b00b00a18a5b131a9mr6033436ejc.12.1702345967370; Mon, 11
 Dec 2023 17:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
 <CAAxE2A6Kdj5TBCdZRoT_t+cABzf9tsNCvJLZAVCE66F5pz5yXQ@mail.gmail.com>
 <5de028e5-d24c-4e98-96aa-e3d18720ab6a@froggi.es>
 <CADnq5_PrvUZXvsLY6fsvigrF+SEwwKZCN5MCF=Zo-RggGJrd1A@mail.gmail.com>
In-Reply-To: <CADnq5_PrvUZXvsLY6fsvigrF+SEwwKZCN5MCF=Zo-RggGJrd1A@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 11 Dec 2023 20:52:11 -0500
Message-ID: <CAAxE2A73ZJZsB=vvTZXCd-1icQ7dJVCN2V6i=NxVYxa3JeGnCA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ab84bb060c464e38"
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
Cc: amd-gfx@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ab84bb060c464e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 1:37=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:

> On Fri, Dec 8, 2023 at 12:27=E2=80=AFPM Joshua Ashton <joshua@froggi.es> =
wrote:
> >
> > FWIW, we are shipping this right now in SteamOS Preview channel
> > (probably going to Stable soon) and it seems to be working as expected
> > and fixing issues there in instances we need to composite, compositor
> > work we are forced to do would take longer than the compositor redzone
> > to vblank.
> >
> > Previously in high gfx workloads like Cyberpunk using 100% of the GPU,
> > we would consistently miss the deadline as composition could take
> > anywhere from 2-6ms fairly randomly.
> >
> > Now it seems the time for the compositor's work to complete is pretty
> > consistent and well in-time in gpuvis for every frame.
>
> I was mostly just trying to look up the information to verify that it
> was set up correctly, but I guess Marek already did and provided you
> with that info, so it's probably fine as is.
>
> >
> > The only times we are not meeting deadline now is when there is an
> > application using very little GPU and finishes incredibly quick, and th=
e
> > compositor is doing significantly more work (eg. FSR from 800p -> 4K or
> > whatever), but that's a separate problem that can likely be solved by
> > inlining some of the composition work with the client's dmabuf work if
> > it has focus to avoid those clock bubbles.
> >
> > I heard some musings about dmabuf deadline kernel work recently, but no=
t
> > sure if any of that is applicable to AMD.
>
> I think something like a workload hint would be more useful.  We did a
> few patch sets to allow userspace to provide a hint to the kernel
> about the workload type so the kernel could adjust the power
> management heuristics accordingly, but there were concerns that the
> UMDs would have to maintain application lists to select which
> heuristic worked best for each application.  Maybe it would be better
> to provide a general classification?  E.g., if the GL or vulkan app
> uses these extensions, it's probably a compute type application vs
> something more graphics-y.  The usual trade-off between power and
> performance.  In general, just letting the firmware pick the clock
> based on perf counters generally seems to work the best.  Maybe a
> general workload hint set by the compositor based on the content type
> it's displaying would be a better option (video vs gaming vs desktop)?
>
> The deadline stuff doesn't really align well with what we can do with
> our firmware and seems ripe for abuse.  Apps can just ask for high
> clocks all the time which is great for performance, but not great for
> power.  Plus there is not much room for anything other than max clocks
> since you don't know how big the workload is or which clocks are the
> limiting factor.
>

Max clocks also decrease performance due to thermal and power limits.
You'll get more performance and less heat if you let the GPU turn off idle
blocks and boost clocks for busy blocks.

Marek

--000000000000ab84bb060c464e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Dec 8, 2023 at 1:37=E2=80=AFPM Alex Deucher &lt;<a href=3D"m=
ailto:alexdeucher@gmail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Dec 8, 2023 at 12=
:27=E2=80=AFPM Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" target=
=3D"_blank">joshua@froggi.es</a>&gt; wrote:<br>
&gt;<br>
&gt; FWIW, we are shipping this right now in SteamOS Preview channel<br>
&gt; (probably going to Stable soon) and it seems to be working as expected=
<br>
&gt; and fixing issues there in instances we need to composite, compositor<=
br>
&gt; work we are forced to do would take longer than the compositor redzone=
<br>
&gt; to vblank.<br>
&gt;<br>
&gt; Previously in high gfx workloads like Cyberpunk using 100% of the GPU,=
<br>
&gt; we would consistently miss the deadline as composition could take<br>
&gt; anywhere from 2-6ms fairly randomly.<br>
&gt;<br>
&gt; Now it seems the time for the compositor&#39;s work to complete is pre=
tty<br>
&gt; consistent and well in-time in gpuvis for every frame.<br>
<br>
I was mostly just trying to look up the information to verify that it<br>
was set up correctly, but I guess Marek already did and provided you<br>
with that info, so it&#39;s probably fine as is.<br>
<br>
&gt;<br>
&gt; The only times we are not meeting deadline now is when there is an<br>
&gt; application using very little GPU and finishes incredibly quick, and t=
he<br>
&gt; compositor is doing significantly more work (eg. FSR from 800p -&gt; 4=
K or<br>
&gt; whatever), but that&#39;s a separate problem that can likely be solved=
 by<br>
&gt; inlining some of the composition work with the client&#39;s dmabuf wor=
k if<br>
&gt; it has focus to avoid those clock bubbles.<br>
&gt;<br>
&gt; I heard some musings about dmabuf deadline kernel work recently, but n=
ot<br>
&gt; sure if any of that is applicable to AMD.<br>
<br>
I think something like a workload hint would be more useful.=C2=A0 We did a=
<br>
few patch sets to allow userspace to provide a hint to the kernel<br>
about the workload type so the kernel could adjust the power<br>
management heuristics accordingly, but there were concerns that the<br>
UMDs would have to maintain application lists to select which<br>
heuristic worked best for each application.=C2=A0 Maybe it would be better<=
br>
to provide a general classification?=C2=A0 E.g., if the GL or vulkan app<br=
>
uses these extensions, it&#39;s probably a compute type application vs<br>
something more graphics-y.=C2=A0 The usual trade-off between power and<br>
performance.=C2=A0 In general, just letting the firmware pick the clock<br>
based on perf counters generally seems to work the best.=C2=A0 Maybe a<br>
general workload hint set by the compositor based on the content type<br>
it&#39;s displaying would be a better option (video vs gaming vs desktop)?<=
br>
<br>
The deadline stuff doesn&#39;t really align well with what we can do with<b=
r>
our firmware and seems ripe for abuse.=C2=A0 Apps can just ask for high<br>
clocks all the time which is great for performance, but not great for<br>
power.=C2=A0 Plus there is not much room for anything other than max clocks=
<br>
since you don&#39;t know how big the workload is or which clocks are the<br=
>
limiting factor.<br></blockquote><div><br></div><div>Max clocks also decrea=
se performance due to thermal and power limits. You&#39;ll get more perform=
ance and less heat if you let the GPU turn off idle blocks and boost clocks=
 for busy blocks.<br></div><div><br></div><div>Marek<br></div><br></div></d=
iv>

--000000000000ab84bb060c464e38--
