Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C97EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 14:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA07F10E3D3;
	Fri, 25 Feb 2022 14:23:25 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE1D10E3D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 14:23:24 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 l21-20020a056830239500b005afd2a7eaa2so859911ots.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZzRqFHeUKblwum+43K1r4wABeHvobj/UWbOkQfwwbaI=;
 b=glyZlQzxRHO0SPxGTEBgJio7gkkuoWKWuOxPAq8d/7Cqioe40o5deuOJwpZnPIhMG6
 K2XqDhlvnfGIkOThpA/0sWfWh4SIqlgsstJeDudOzlN8aZflmyKs7lMzKqBwREZFBp+m
 AdkHrPKt6ac1aomqnCeipskjNLfDZDC8r6P3TdX6l/kmQ4cpyYdB3rKYfx0vZHMl+Ofh
 S4BDaq+ucxTVO1+kssnRuTPrsnCLpQSP0VD3Yt9JJ7tgZY7dX15/ccGU6AH1H3g9WUzq
 D8VTMEzzqssppgYs2aLQ3vg6LOY13ZdSnI/XSaa0vpQe+Lfzf8GyNYM+u0Q1njw/VdU5
 xPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZzRqFHeUKblwum+43K1r4wABeHvobj/UWbOkQfwwbaI=;
 b=Ben9NZ8rYV1hRbBmkDGsBvk/jE/4k27hhZQGIfAxBNTl1FQAHSAInXObED2NmiuxXy
 S4NzrQkOVn21diQBYHEj8ejuI+c9v4X/K62hD7UFRwuPUv8lg5yCjAFplpIlbw9PViQR
 hf5MFQ0ApnUHqGFsXUQ/MkX+mhptNWGNxf9ePJxJJovHub4DHwrYUDVYNmQfWb4pufAI
 MjoBGEEoQkTNfs3QweNTek98nPzSTNydvr+MrDN5ngP61W6d8vADxk6KQ31p+HqnFTtY
 11yyLfjSLlDGuIx1vF5vFZeTrzBs+zqqrkBde7ghxPDPsfQYIjRd9d3o6WIt9QS+fA1P
 wvMg==
X-Gm-Message-State: AOAM532D60YVRPw0rBaTbZ3rSQ9pWkM2HQN/mN+Jjn0iQYNQ4s+G971x
 6za/UmON5KiXDSLYs/7SRlUlkqE0t9sxIUYzXlp0y1c0
X-Google-Smtp-Source: ABdhPJxCBC/Yff1DFicGA/TcqcgMdrGpddWCsb5+qGlYfOQBSDFDVGTqKnrlIe0tdh4f2fUKUVM5PTHbhiJz0xJe4Vo=
X-Received: by 2002:a9d:5a06:0:b0:5af:b5fd:5b72 with SMTP id
 v6-20020a9d5a06000000b005afb5fd5b72mr2641209oth.200.1645799004193; Fri, 25
 Feb 2022 06:23:24 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
 <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
 <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
 <alpine.LNX.2.00.2202241728250.23253@lancer.cnet.absolutedigital.net>
In-Reply-To: <alpine.LNX.2.00.2202241728250.23253@lancer.cnet.absolutedigital.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Feb 2022 09:23:13 -0500
Message-ID: <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
To: Cal Peake <cp@absolutedigital.net>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 24, 2022 at 6:12 PM Cal Peake <cp@absolutedigital.net> wrote:
>
> On Thu, 24 Feb 2022, Christian K=C3=B6nig wrote:
>
> > Interesting to know that it turned out to be the motherboard, going to =
keep
> > that in mind if somebody else is having similar problems.
>
> Looks like I might have spoke too soon, getting random resets again. I
> have no idea why my nvidia card runs perfectly fine, but two completely
> different AMD GPUs both have the same problem, or why that problem comes
> and goes at random.
>
> I'm gonna have to do a deeper dive into this until I figure it out (or
> until Intel drops their dGPUs and I can get a modern, OSS-friendly GPU
> that's stable on my system lol).
>
> I'll let you know if I come up with anything more definitive, Christian.

Does setting amdgpu.aspm=3D0 help?

Alex

>
> Thanks!
>
> --
> Cal Peake
>
> P.S. To your earlier point about capacitors: Between the mobo and the GPU=
,
> the only electrolytic caps are for the audio hardware. Everything else is
> solid polymer, so I'm thinking that that's probably not the culprit :-)
