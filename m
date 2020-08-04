Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70943C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEA621744
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgtVAZBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEA621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A1F89227;
	Tue,  4 Aug 2020 20:02:11 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26CE89227
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 20:02:10 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id f18so2891411wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LLO/rcWBQPARE6ry1zojr30W4XyQOnnb/qFSIx4UP+M=;
 b=ZgtVAZBUMcPfnaRAHct89SKDDE4beOACewbKWY+nTcXD1FNlFjrRWlC4U5m7OZV5ko
 oswA705WuAoNtLYeC2qHTm3qduUAlTNtn/l/eKYiqY4ps5KIW1Qv5BUm8Nt3q6g1Yqmq
 SOXt2ne1Ne73srnfL8AXTpriVzSP7+trf+vigcT1XyQM4DbSpUFNou1ZCKfdq7C1/dSA
 KVnMnX+sD3WVzHYv6FeMx3qVZCPl5jvyUKltiPyMx7WMlGtfcTFZrd8i+fSY9nSjksv5
 p4yw31kJGCoffsFtx4hhaFO3cZh8I5jSjHAdutTQtn2B2Npr2Qq5KToXIwUi8zPg9sMl
 W9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LLO/rcWBQPARE6ry1zojr30W4XyQOnnb/qFSIx4UP+M=;
 b=f9L+BPE2/hx2Aw09fAh0n9T3VkhKYxTO6GNQ1n5IaXs1Ay5nep586ZgnVhnFpkbWiC
 0cZulNelSd7EngWE4E8aRCmrxQi48RkCZHIrnCltEbvCDOiW/RH5JTh4xGKsm7sU68/v
 e4EhAhqz58h8eJjAm+ZXYt4hJtKltRhXJ+qRwSDSd+SoDPgUG+nNEoai6ELF+UU3XuLE
 Dp8UlSMHEIxy0VykDmKKB1ZnqPJTkReJmpkBFheJu+z8GDgLPWS/nrZZanWIAMu+WlNU
 kZOQUza3OE6hlBrSI0JcgEgVIrHNiOFgad7YUR4A8TnEJ9LZbfHX03oQ9P8R6k16gTis
 u1Tg==
X-Gm-Message-State: AOAM532bk84oIiEsq9nV8Xb2ExrAUUD3CZQRVDJ8WPhxyeUEOZk1mCXW
 IjjmN4HJc5KRPkqdZ2zwoZx8gY/K+X7HOSdgw6o=
X-Google-Smtp-Source: ABdhPJwbAqAaLIgqlKJufuJ9QuyZujGywPIBRjtTns//NI8UNhIWX+UbOjAYnQYrq3dEE8rXr4flo7E2nbVE0h5+fSY=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr79807wmh.39.1596571329459;
 Tue, 04 Aug 2020 13:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
 <CADnq5_PcEo7sXFpEoKLj5q4J52ehtGjMvQzUFPHLcHObR3Q94A@mail.gmail.com>
 <796fb0f5-d2fa-0456-5f5e-9413c9fb5a0f@gmx.de>
In-Reply-To: <796fb0f5-d2fa-0456-5f5e-9413c9fb5a0f@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 16:01:58 -0400
Message-ID: <CADnq5_MP-j6JpW+q6XV5nqwXfgFOEvgZ_GBRP3uuinSn98CRng@mail.gmail.com>
Subject: Re: Amdgpu kernel oops and freezing graphics
To: harv@gmx.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 21, 2020 at 2:21 PM Harvey <harv@gmx.de> wrote:
>
> Alex,
>
> tnak you so much - you're my hero!
>
> Am 21.07.20 um 18:17 schrieb Alex Deucher:
> > On Mon, Jul 20, 2020 at 4:22 AM Harvey <harv@gmx.de> wrote:
> >>
> >> Hello,
> >>
> >> this is my first post to this list so please be patient with me ;)
> >>
> >> The facts:
> >>
> >> it is now one week that I own a new laptop, a MSI Bravo 17 A4DDR/MS-17FK
> >> with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M. I installed
> >> my beloved Archlinux but I can't start any graphics withpout kernel oops
> >> on it beside the normal console, even calling 'lspci' on the console is
> >> provoking errors.
> >>
> >> I am using linux kernel 5.7.9 and linux-firmware 20200619.e96c121
> >>
> >> (FWIW: I even tried with a self-cmpiled kernel 5.8-rc5 and
> >> linux-firmware directly from the git repository - no changes)
> >>
> >> The following is only part of the information I can provide but I didn't
> >> want to make this mail bigger than it already is.
> >
> > Does appending amdgpu.runpm=0 on the kernel command line in grub help?
>
> Yes it does. Woohoo! The system is not freezing anymore! Can I provide
> any further information to get this sorted?
>
> I will be happy to help investigating and testing if needed.

Does appending pci=noats on the kernel command line in grub also fix the issue?

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
