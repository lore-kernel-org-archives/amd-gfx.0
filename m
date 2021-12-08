Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B47C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 22:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B076E111;
	Wed,  8 Dec 2021 22:50:08 +0000 (UTC)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4896E203
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 22:50:06 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 3D691B004EE;
 Wed,  8 Dec 2021 23:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1639003804;
 bh=OoqHCwNqw4dVpxTaH9A6R+M2Qay8YI6j/Vo67IMWsEg=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=WGfc056rFFJytAqGYPKac0MAoWkYOXt07Ugwv/ySrzYKOs69UbFXhih0+7cBr/lfe
 rNDeFlZhC68YXY8MOuf7yKw7BfmJOhx4D0Q3j3WFwlkzfQqKP3JdrbtXSbB50kg2ZW
 CbZUIdG07E8hBwAmp0AKzm2fol34IqINd1Ve43lTR1+SGDRzHPIwCHDQ9VvBNmexrK
 LuWXkcjDFN6fA9KiSFYim7cR+Qsrc9tlaOV1HOrZaRitmAtjm+Gb0vwgVJrZ6r2A0C
 vPiVmnwyCTQN4mcCcgyov6ac9Vo/rTnvf/Xb06mzTUwZIwUzEaT+Sg2AbKuQg+Z9Oj
 S9VbInS9SBvuA==
Date: Wed, 8 Dec 2021 23:50:04 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: Alex Deucher <alexdeucher@gmail.com>
Message-ID: <2125070111.42356235.1639003804213.JavaMail.root@zimbra39-e7>
In-Reply-To: <CADnq5_M_PS6fSza560ReNVki0n40tozig_KsbZnFksco2MZ3Ag@mail.gmail.com>
Subject: Re: Various problems trying to vga-passthrough a Renoir iGPU to a
 xen/qubes-os hvm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Hi Alex,

> 
> On Mon, Dec 6, 2021 at 4:36 PM Yann Dirson <ydirson@free.fr> wrote:
> >
> > Hi Alex,
> >
> > > We have not validated virtualization of our integrated GPUs.  I
> > > don't
> > > know that it will work at all.  We had done a bit of testing but
> > > ran
> > > into the same issues with the PSP, but never had a chance to
> > > debug
> > > further because this feature is not productized.
> > ...
> > > You need a functional PSP to get the GPU driver up and running.
> >
> > Ah, thanks for the hint :)
> >
> > I guess that if I want to have any chance to get the PSP working
> > I'm
> > going to need more details on it.  A quick search some time ago
> > mostly
> > brought reverse-engineering work, rather than official AMD doc.
> >  Are
> > there some AMD resources I missed ?
> 
> The driver code is pretty much it.  On APUs, the PSP is shared with
> the CPU and the rest of the platform.  The GPU driver just interacts
> with it for a few specific tasks:
> 1. Loading Trusted Applications (e.g., trusted firmware applications
> that run on the PSP for specific functionality, e.g., HDCP and
> content
> protection, etc.)
> 2. Validating and loading firmware for other engines on the SoC.
>  This
> is required to use those engines.

After some digging, if I understand correctly, the PSP is the 3rd IP
getting its hw_init() called.  First comes soc15_common, then vega10_ih.

- soc15_common_init_hw does some writes through nbio_v7.0 functions,
  but does not query the hw to check before or after
- vega10_init_hw does some register reads as part of its work, but once
  it has written it does not check either

So PSP is the first one to check that "soc15" (I'm still not sure what
this one represents, really) is in fact alive and well.

Can't we check earlier that the chip is really listening to us ?

> 
> I'm not too familiar with the PSP's path to memory from the GPU
> perspective.  IIRC, most memory used by the PSP goes through carve
> out
> "vram" on APUs so it should work, but I would double check if there
> are any system memory allocations that used to interact with the PSP
> and see if changing them to vram helps.  It does work with the IOMMU
> enabled on bare metal, so it should work in passthrough as well in
> theory.
> 
> Alex
> 
> 
> >
> > Best regards,
> > --
> > Yann
> 
