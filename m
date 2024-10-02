Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F56CF31AF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 11:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4758B10E1F7;
	Wed,  2 Oct 2024 11:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="tu8d8Yl2";
	dkim-atps=neutral
X-Greylist: delayed 574 seconds by postgrey-1.36 at gabe;
 Wed, 02 Oct 2024 11:06:39 UTC
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6B210E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 11:06:38 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
 t=1727866623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFYP2U3afp97x/PWFZ/H2WQVejex0/N1NBYKjBA/0TI=;
 b=tu8d8Yl25Wq/4yoZQZc+zfXMOCkxc17oOOGd/397sm8iL4H/A0HyaiqfySlnOmNBIayS6R
 753qM9vRYXGSJXizDXiVJxg2RKXmkLh5A3xs2shsR17VDOsT2ciN2yOjUuTf4lzuF2EGt0
 EIiCeOelkA8501rhFHHbydkWVWQmEkd1mP24wiS0VjUO5BXevulJNlYS49jzxphmdVLge0
 zvdkq6NyQhzR62eRKsdD+hvIXaaw3/Ky4tkX2Y9+3MjsOCWI8NF929+QhgLWG9LrsfUXNF
 99MT/Wydk2XR2aEWDV4kz6oJ/mmNW5ydD8qMhSAOSpIEEE4cINQc8dnoJY1hMA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Oct 2024 03:56:55 -0700
Message-Id: <D4L9LH0XT9OL.2RUPJNHCEX3O@kode54.net>
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: "John Rowley" <lkml@johnrowley.me>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Hamza Mahfooz"
 <hamza.mahfooz@amd.com>
Cc: "Harry Wentland" <harry.wentland@amd.com>, "Rodrigo Siqueira"
 <Rodrigo.Siqueira@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <regressions@lists.linux.dev>
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
 <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
 <9c562132-64a0-41f5-80ad-8492d1039692@amd.com>
 <3c0dfd3a-9549-4afa-94b6-80041f498436@johnrowley.me>
 <25eed927-fe69-4005-8c0d-c5f3052e662e@amd.com>
 <92af8678-2b45-409e-82d1-f273fe907a36@johnrowley.me>
In-Reply-To: <92af8678-2b45-409e-82d1-f273fe907a36@johnrowley.me>
X-Migadu-Flow: FLOW_OUT
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

On Tue Oct 1, 2024 at 2:32 PM PDT, John Rowley wrote:
> The attached patch seems to improve rendering performance a lot; animatio=
ns and desktop performance are generally smoother again.
>
> But it doesn't seem 100%, e.g. if I let the laptop idle for 10 secs befor=
e interacting with the touchpad, the desktop cursor seems to stick in-place=
 for 100-200ms or so, before becoming responsive again.
>
> This 'sticking' problem doesn't seem to occur with PSR disabled.
>
> My testing isn't exactly scientifically sound I'm afraid, if there's a be=
tter test or benchmark I can run, please let me know.

May want to also tell the list that you mis-applied the patch on the
first go by misreading what it did and editing manually. I'm eager to
hear whether the actual patch worked out better.

>
> On 01/10/2024 22:16, Mario Limonciello wrote:
> > On 10/1/2024 16:14, John Rowley wrote:
> >> Disabling PSR as per Leo's reply seems to have done the trick!
> >>
> >> Stock 6.12-rc1 (without revert): BROKEN
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
state:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 6
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
capability:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Sink support: yes [0x03]
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Driver support: yes
> >>
> >> With amdgpu.dcdebugmask=3D0x800: BROKEN
> >>
> >> With amdgpu.dcdebugmask=3D0x10: FIXED! Performance is as it was on 6.1=
1.
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
state:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 0
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
capability:
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Sink support: yes [0x03]
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Driver support: no [0xffffffff]
> >>
> >> I have the older Framework 13 panel (BOE 0x0BCA, 2256x1504 @ 59.999 Hz=
) so I assume PSR isn't supported according to Mario, yet psr_{state,capabi=
lity} above seem to indicate otherwise?
> >>
> >
> > PSR and Replay are two different things.=C2=A0 But from your above anal=
ysis it does confirm it's a PSR issue.
> >
> > There's a patch that Hamza attached to https://gitlab.freedesktop.org/d=
rm/amd/-/issues/3658.
> >
> > Can you try that?
> >
> > Thanks,

