Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDCFC5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 14:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6DD10E496;
	Tue, 20 Feb 2024 14:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRy1XYzU";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E768C10E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 14:45:59 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-5dc20645871so3471179a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708440359; x=1709045159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dqoh+aO5PuDXiiP1kNhYVUZ2C9dCr9HHTDaZyknCirw=;
 b=XRy1XYzUJeJIes4WthGIrRm/W1CRJdyrA3N+VwstP5AKoVaEtIcDKAuEt7jIGFM+eu
 dvxZM5SUFQobF5gPxR/85Z4e544fp0WtIP/ZWKgriqY5mxnH2hNPEJCMB3NlSuW114VQ
 LS3lY7SGP653lorLeBp1rp+UJfuxAn+bXpO52YNXPUeMEGgzKHGJ4+pUfAtaeOHJbGyC
 yBjk8y0OP/hD+70JbrsHb1NC+EOJAt8TbMO1+/DJAiYbNRaKKolm/GgnxwvcygMhmxQY
 cBjkSnLzmeKKwnP+AEgQKK0AbBc1sxCkTfdhOk3C52gkMIQI0uwtdJ3s7KOE94caFI5C
 ocMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708440359; x=1709045159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dqoh+aO5PuDXiiP1kNhYVUZ2C9dCr9HHTDaZyknCirw=;
 b=eYduJGG9WukEur4x9k07/ljksldrDKjNy4m/74Qf3d2JBW9dslcwKc9t+jI2SpNZX+
 zvMqsSQgKkLNTCnLUoUsosVJVtIbag7Q5QQru9rEq9FqtkBwhbOUEeFSVGMCiMR5N7Qm
 YTEAxeVcx2XdIQks1cHtOGfmt3FkujEhl31iAz1lwj/9881V49xBMtJNp8uu7790NP5K
 qkAAyJjw9dFj5vksmq4rdBdOpzJUzbJ5BN1/jJbygoOU5WgaskFlKkUSgO91zV2lPBGd
 knN4Bq4cVQX1m8Mf1Z48c9fxu1jP+m4XKWl2SFOkxYDdfMzDEpcQXQr75OFEFBF0zsNo
 BQEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzzBTrc8Tqc3Kd3OBppzigXJAXYlQwxTIllwHxROFEWHANP+4LqIz0vDOf8mv3ZY7faw9rdE7MDVpfV5meV5Gsa2b41/EjhqWZyqzS7A==
X-Gm-Message-State: AOJu0YzbY40Avdi6hP83xfuQmu2eLWJaL7SplKX4MN64pEUI2obZWkWG
 CR7SwdsECCGqyDPpeUbBbzXe+1AbdOGixQCwgVT5IhR6D3PFO2ElJcbo8/RLfL1aPeQt8/uqyJw
 qpjDAdOHGGPm6o6wP1GsFGcybFoY=
X-Google-Smtp-Source: AGHT+IEzbFTeHEExGYPs6vvdhejACokVXp8HYK3mE36/KNfRZqfgHDzUh/rrTveciNVPq7sJJFaxRjvi1RJGoOh5znw=
X-Received: by 2002:a17:90b:1881:b0:299:1cce:f3c3 with SMTP id
 mn1-20020a17090b188100b002991ccef3c3mr19017313pjb.7.1708440359315; Tue, 20
 Feb 2024 06:45:59 -0800 (PST)
MIME-Version: 1.0
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
In-Reply-To: <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Feb 2024 09:45:47 -0500
Message-ID: <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>, 
 Roman Benes <benes@riadoklan.sk.eu.org>
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

On Mon, Feb 19, 2024 at 9:47=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 17.02.24 14:30, Greg KH wrote:
> > On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
> >> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 670=
0XT,
> >> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
> >> neither with Corectrl, LACT or TuxClocker and /sys have a variable rea=
d-only
> >> even for root. This is not of above apps issue but of the kernel, I re=
ad
> >> similar issues from other bug reports of above apps. I downgraded to v=
6.6.10
> >> kernel and my 115W(under power)cap work again as before.
> >
> > Any chance you can use 'git bisect' to figure out the offending change?
>
> For the record and everyone that lands here: the cause is known now
> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
> value") [v6.7-rc1]) and the issue afaics tracked here:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>
> Other mentions:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>
> Haven't seen any statement from the amdgpu developers (now CCed) yet on
> this there (but might have missed something!). From what I can see I
> assume this will likely be somewhat tricky to handle, as a revert
> overall might be a bad idea here. We'll see I guess.

The change aligns the driver what has been validated on each board
design.  Windows uses the same limits.  Using values lower than the
validated range can lead to undefined behavior and could potentially
damage your hardware.

Alex

>
> Roman posted something that apparently was meant to go to the list, so
> let me put it here:
>
> """
> UPDATE: User fililip already posted patch, but it need to be merged,
> discussion is on gitlab link below.
>
> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>
>
> > it seems that commit was already found(see user's 'fililip' comment):
> >
> > https://gitlab.freedesktop.org/drm/amd/-/issues/3183
> > commit 1958946858a62b6b5392ed075aa219d199bcae39
> > Author: Ma Jun <Jun.Ma2@amd.com>
> > Date:   Thu Oct 12 09:33:45 2023 +0800
> >
> >     drm/amd/pm: Support for getting power1_cap_min value
> >
> >     Support for getting power1_cap_min value on smu13 and smu11.
> >     For other Asics, we still use 0 as the default value.
> >
> >     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >     Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > However, this is not good as it remove under-powering range too far. I
> was getting only about 7% less performance but 90W(!) less consumption
> when set to my 115W before. Also I wonder if we as a OS of options and
> freedom have to stick to such very high reference for min values without
> ability to override them through some sys ctrls. Commit was done by amd
> guy and I wonder if because of maybe this post that I made few months
> ago(business strategy?):
> >
> >
> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capp=
ed_115w_at_only_10/
> >
> > This is not a dangerous OC upwards where I can understand desire to
> protect HW, it is downward, having min cap at 190W when card pull on
> 115W almost same speed is IMO crazy to deny. We don't talk about default
> or reference values here either, just a move to lower the range of
> options for whatever reason.
> >
> > I don't know how much power you guys have over them, but please
> consider either reverting this change, or give us an option to set
> min_cap through say /sys (right now param is readonly, even for root).
> >
> >
> > Thank you in advance for looking into this, with regards:  Romano
> """
>
> And while at it, let me add this issue to the tracking as well
>
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
>
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
>
> #regzbot introduced 1958946858a62b /
> #regzbot title drm: amdgpu: under-powering broke
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
