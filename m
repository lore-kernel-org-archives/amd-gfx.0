Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C36C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3B16E91D;
	Mon,  6 Dec 2021 22:39:32 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FE06E91D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 22:39:31 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id bj13so24232118oib.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cWL0f0Btzk+O7sdCeZf4yHBSfypIsYSfSdyDD0GUDXQ=;
 b=iOfXzwAcn4EgPmgMSeb92/ZZfeRdFDsa+kepvE0K37d8sLQtu+4tR0CXH4MGFn12Dy
 QmipFenaEcF8dYe7zeaVXrs/9KRAcURyQ9FBrzGb5Tv7EhQbJThCJUrCeNXo8jdRioRT
 JKOgRS91L2KYk63oWvGPUmDu2fAZT8dncIG/RxQ6FXT/r16gCqrgut+6JyU/F5tZzPI4
 Bhi/DHJOJhjnGKaDpZeT13PxL2+w0m98+o5VktfHY1CgpYfr5icYoIKWV28aF86k7P2i
 BRtPGTSZLNlucyWQVDvP3PsTrXGfLdqd3DsTQhAd2L2XDhiHJ6AOCooDf7IEf39JYK/o
 6qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cWL0f0Btzk+O7sdCeZf4yHBSfypIsYSfSdyDD0GUDXQ=;
 b=rG3aMp5Wm2XPIGZ352yNuC3y6qDnKmEX0redRHxsIqPRfvYjyWe/8iwPAWsuFB398A
 hu+edZAXXbXNlbZ8jm9PJjMdDCUNBy6FeS+yKzgU2YQ8AD+g341OHGkkq4sSUc7/qEPv
 f4G4lUURqwwTqT9JlPnLHVlWKTZwt82G2tlLCqcacy5+gN7g1ewTK+Gzu8XXyPli2Owa
 XsTiLtsmlB1kenMT6rXn7tLc1EHZQcYzHIMv+3jtWzTdVBhoZTHnTD3rq4RaLdY2rk8T
 pkTA57qDrjDkA5c3CzsMQZ9RSERcjSEKAxFan72xbWFHjQsgBzB+Yn8TMvTqBmNxx0dL
 K/Ug==
X-Gm-Message-State: AOAM533285+Wu2x8NaNKy3ZehY+CTs1+NaMLUo27Xd52r60juqkgRiGE
 25W2lgT1IiAeBrOTvF2Sgs8ILjQWSv4vaTwRjT6aT7Br
X-Google-Smtp-Source: ABdhPJzQ2OdILxWwSVexBZ2/UGDY6x2Wo6Pnop+LM1PmNOj7doVxh8tzAU9EGqcZRq2lzqwLgmSrydRwqLZthmNKG3Y=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr1654172oib.120.1638830370888; 
 Mon, 06 Dec 2021 14:39:30 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_P6ZoxFXxTAmMsNqbCO3_FZ4+2qn+YJ5488q6Ew-FaU-A@mail.gmail.com>
 <2007970240.32601068.1638826572724.JavaMail.root@zimbra39-e7>
In-Reply-To: <2007970240.32601068.1638826572724.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Dec 2021 17:39:20 -0500
Message-ID: <CADnq5_M_PS6fSza560ReNVki0n40tozig_KsbZnFksco2MZ3Ag@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson <ydirson@free.fr> wrote:
>
> Hi Alex,
>
> > We have not validated virtualization of our integrated GPUs.  I don't
> > know that it will work at all.  We had done a bit of testing but ran
> > into the same issues with the PSP, but never had a chance to debug
> > further because this feature is not productized.
> ...
> > You need a functional PSP to get the GPU driver up and running.
>
> Ah, thanks for the hint :)
>
> I guess that if I want to have any chance to get the PSP working I'm
> going to need more details on it.  A quick search some time ago mostly
> brought reverse-engineering work, rather than official AMD doc.  Are
> there some AMD resources I missed ?

The driver code is pretty much it.  On APUs, the PSP is shared with
the CPU and the rest of the platform.  The GPU driver just interacts
with it for a few specific tasks:
1. Loading Trusted Applications (e.g., trusted firmware applications
that run on the PSP for specific functionality, e.g., HDCP and content
protection, etc.)
2. Validating and loading firmware for other engines on the SoC.  This
is required to use those engines.

I'm not too familiar with the PSP's path to memory from the GPU
perspective.  IIRC, most memory used by the PSP goes through carve out
"vram" on APUs so it should work, but I would double check if there
are any system memory allocations that used to interact with the PSP
and see if changing them to vram helps.  It does work with the IOMMU
enabled on bare metal, so it should work in passthrough as well in
theory.

Alex


>
> Best regards,
> --
> Yann
