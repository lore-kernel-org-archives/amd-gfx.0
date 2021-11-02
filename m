Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C87BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D06060524
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D06060524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F2072D01;
	Tue,  2 Nov 2021 13:59:52 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E458F72D01
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 13:59:51 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id bm39so19641978oib.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hGRDipcFHpRhtZGVoh6OOrkjsV95eyyGSGuxwG3Rp5Y=;
 b=ciGXj188hPsOfnK9fXZGh/HNUtHnEOlj2lEUeu6v/1c3yOtIgg9vex5YLfzNYb5HiC
 fGoyCWtPRNxNPqvJN+kpCI/z5JO9UWdFbE1Xdwafh4gzxhibrKgc3t933SX19jOxnoh0
 KJI/hyJB6rmU2AWvqDGSXmVPWYYknQvxnI/IgtzWSlbcbNOKs7b3/j+ZjxkTDJl0gf/W
 pU39MizWW1yv7VU5PbPawwRZAck773tMGz1PFYSAWNvOaL3peem1T0GjrL1EZcKCSZTN
 5DjIeSCGqdnIqMYOVI8jLKoGCt6X7seVk9RhB0D5vCNdnGpgp9r42Bi+5JXTacX17EOp
 yPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hGRDipcFHpRhtZGVoh6OOrkjsV95eyyGSGuxwG3Rp5Y=;
 b=6RqXcjlYj7gSgjEPinx4v87V1p7hgtpA6W8DAEiFXPqbUGJ5s3cuhPEFpXA4bRHMwv
 7uU70vI3oFuKXEYsOEMW1PNUdBDppOfwou6t8vKvZgdGH/br4sTe3dMvhATWrOS3rdWa
 HN5ND74weaSQRzBSvm3llJMOhO+NFhwKbsxjyq/N06BrlCJBk5r17ijbamr1v+m9xPAw
 gnEn78pVlsgP9u37sItx7GYcLV5IKjmyax+lnLH46iZA4z/dvh17ZAwWnWvXBwXyHVy8
 JXTwHj1V2KZYHhnBezd6CqUqj9Dx//VoGRUiMiMIDI9L4gzNTt5JMmGAZ1vC/t0sJdqT
 4yVw==
X-Gm-Message-State: AOAM5315aC09FRLTRCpCMoTieo51wksDO7obs08jfjW8FOymtLBzrtJJ
 6dUPHvSKqP218U9Ni84MQlUqpy2wli80dvPJ7b8=
X-Google-Smtp-Source: ABdhPJxfotmHb7elO1d19hwcTj946RaW0cuU3vqZWbpyiM2v8Tmqx1R6eixDmY4HRdC04mx3TfYrH6uCuVYtWouzNnU=
X-Received: by 2002:aca:e08a:: with SMTP id x132mr5125944oig.120.1635861591247; 
 Tue, 02 Nov 2021 06:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <446fda20-a635-3b00-4886-661fff4ab0f2@gmail.com>
 <CADnq5_Nr_c7J-WrZfsOEAHQwerM7vgU=dC0JrO+B7wTh40Z_Wg@mail.gmail.com>
 <d8e3eea3-5a92-8a0a-d15d-a1c2f5024ad2@gmail.com>
In-Reply-To: <d8e3eea3-5a92-8a0a-d15d-a1c2f5024ad2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Nov 2021 09:59:40 -0400
Message-ID: <CADnq5_N-9ibXP5_6gLNZEiOF9kqM55KMpfX05k7AAULN8DiAXg@mail.gmail.com>
Subject: Re: amdgpu support for Ryzen 5XXXG, with integrated graphics: is it?
To: PGNet Dev <pgnet.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 2, 2021 at 9:48 AM PGNet Dev <pgnet.dev@gmail.com> wrote:
>
> > Yes, your device is supported.
>
> gr8, thx!
>
> > If the issue is related to the whether
> > or not you can override the ycbcr vs rgb setting for your monitor,
>
> i'm not clear if its a monitor issue, &/or or a (on-die) 'vid card' issue.
>

Well, if it's the ycbcr vs rgb issue, it's a disagreement between what
the monitor wants and what the driver tells the hardware to send.

> that said, most of the rumblings i've found so far _do_ refer to the ycbcr 'vs' rgb setting.
>
> > you've found the relevant threads about that.  To upstream a solution,
> > we need to get consensus across drivers on how to handle that and that
> > has been a challenge.
>
> 'upstream' here meaning ... AMD.com or Kernel.org?

Upstream into the kernel.

>
> what, if any, additional info from my setup is helpful?

You can try the patches on the relevant bugs.

>
> > I believe there are some experimental patches
> > on one of the tickets you posted if you want to try them out.
>
> missed them.  looking again ...
>
> if there's anything specific you've in mind, pls feel free to 'point'

It's been a while, but I think these are the relevant links:
https://gitlab.freedesktop.org/drm/amd/-/issues/476
https://www.spinics.net/lists/amd-gfx/msg53281.html
https://lkml.org/lkml/2021/6/18/294

Alex
