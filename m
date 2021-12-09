Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E242C43217
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFBC10E15B;
	Thu,  9 Dec 2021 16:53:01 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A339210E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 06:19:19 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 47-20020a9d0332000000b005798ac20d72so5133165otv.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 22:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K09KrOKvdCD/M4ifHWgXSzR2/zrc5rm3IsZxIdeKG8M=;
 b=SwDR0Szb3MSzvivPnMry4DASxJm2P22kxsUdCa61jfLqq9ui7gQxPULhv5nFSYYEYt
 umJUwJ6PTD7y3N+KXfVg+NBEkRyRoGb/VDpmNTVmSb6j8HKqUElhtwGdk4389LQUonRU
 Zs6KmKcFSWNQ03UH9Rq9vpaP+r2SNsKvPmIQ1+aKnHH5dCtVK55Et+xPrF5F3hOCvZl2
 qMwJr50AtbNmj9j5ZyFECFAu5kkLOqNRQuP3fV1tn56fu+Hh+g5vxa5nI4kcc9DdxSTv
 p7MRNiSc9qOxw6zDqMXrDMBK+DHDithfIVTlIlvW1BJYfOj3wt3V/Z2jcC9M3GEsmJUK
 DCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K09KrOKvdCD/M4ifHWgXSzR2/zrc5rm3IsZxIdeKG8M=;
 b=hiw261OuqZ9X6Bu4qQD14tSJZ/FVlLPzVegPAtQichoTe8sM7NZh6aGaVglv4f2lNy
 b/MQt8p5/nHzN53lqr+SCHK84q/G55OMYUBQQORakHlaoQI5reP32vrBID9vPDpuwqo0
 IiYNqImQZsglhAoutelhD32xKgkRM7tE9wil1iLDY05MmjS8XnnD0N7A73NNZcZD3p3t
 Z5um/QwwSfqn0PVjoKRR1Bkfuf80gLVSrEAdW76BNs+rXcEHD5EEopG4l2Ql5MoNyYzG
 N/cRoV1eozhVk6auP6v86qBxuPFFcOWLI/cklYJOnyK6eM515mok4sXplVunaTWS5G8D
 02GA==
X-Gm-Message-State: AOAM531L0JpOImgIZprzCIDTdEewaX+VwvNNRfEzynRxD2p633FTKCxm
 dEkOE5WoRjILbbiZv3T0um46sfTVUua5s6UxUhf3JCsV
X-Google-Smtp-Source: ABdhPJwf8PeEHqCVUZHyzGdfNiC0c7lYlYoxDOvdMSXr4GOmdyIhhzAwnqvkkbfyg59LbNwNwa8kTSD9m/y5QZJUxPI=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr3491528oto.357.1639024579308; 
 Wed, 08 Dec 2021 20:36:19 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_M_PS6fSza560ReNVki0n40tozig_KsbZnFksco2MZ3Ag@mail.gmail.com>
 <2125070111.42356235.1639003804213.JavaMail.root@zimbra39-e7>
In-Reply-To: <2125070111.42356235.1639003804213.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 23:36:08 -0500
Message-ID: <CADnq5_MLeh2sYJS0_q0NratEQSSP6poHW1_Xdi0w-7DPZTQ3AA@mail.gmail.com>
Subject: Re: Various problems trying to vga-passthrough a Renoir iGPU to a
 xen/qubes-os hvm
To: Yann Dirson <ydirson@free.fr>
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

On Wed, Dec 8, 2021 at 5:50 PM Yann Dirson <ydirson@free.fr> wrote:
>
> Hi Alex,
>
> >
> > On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson <ydirson@free.fr> wrote:
> > >
> > > Hi Alex,
> > >
> > > > We have not validated virtualization of our integrated GPUs.  I
> > > > don't
> > > > know that it will work at all.  We had done a bit of testing but
> > > > ran
> > > > into the same issues with the PSP, but never had a chance to
> > > > debug
> > > > further because this feature is not productized.
> > > ...
> > > > You need a functional PSP to get the GPU driver up and running.
> > >
> > > Ah, thanks for the hint :)
> > >
> > > I guess that if I want to have any chance to get the PSP working
> > > I'm
> > > going to need more details on it.  A quick search some time ago
> > > mostly
> > > brought reverse-engineering work, rather than official AMD doc.
> > >  Are
> > > there some AMD resources I missed ?
> >
> > The driver code is pretty much it.  On APUs, the PSP is shared with
> > the CPU and the rest of the platform.  The GPU driver just interacts
> > with it for a few specific tasks:
> > 1. Loading Trusted Applications (e.g., trusted firmware applications
> > that run on the PSP for specific functionality, e.g., HDCP and
> > content
> > protection, etc.)
> > 2. Validating and loading firmware for other engines on the SoC.
> >  This
> > is required to use those engines.
>
> After some digging, if I understand correctly, the PSP is the 3rd IP
> getting its hw_init() called.  First comes soc15_common, then vega10_ih.
>
> - soc15_common_init_hw does some writes through nbio_v7.0 functions,
>   but does not query the hw to check before or after
> - vega10_init_hw does some register reads as part of its work, but once
>   it has written it does not check either
>
> So PSP is the first one to check that "soc15" (I'm still not sure what
> this one represents, really) is in fact alive and well.
>
> Can't we check earlier that the chip is really listening to us ?

Each SoC is made up of hardware blocks that provide various different
functionality.  They are mostly independent and mostly initialized
independently.  I'm not sure what you would want to check.  In your
case, I don't think it's an issue of the chip not being functional
overall, but rather a problem specific to the failing block somehow
related to being in a virtualized environment.

Alex


>
> >
> > I'm not too familiar with the PSP's path to memory from the GPU
> > perspective.  IIRC, most memory used by the PSP goes through carve
> > out
> > "vram" on APUs so it should work, but I would double check if there
> > are any system memory allocations that used to interact with the PSP
> > and see if changing them to vram helps.  It does work with the IOMMU
> > enabled on bare metal, so it should work in passthrough as well in
> > theory.
> >
> > Alex
> >
> >
> > >
> > > Best regards,
> > > --
> > > Yann
> >
