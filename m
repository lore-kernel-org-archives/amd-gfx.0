Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 15:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948306143C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 15:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948306143C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217AC6ED16;
	Thu, 13 May 2021 15:02:17 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AA96ED16
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 15:02:15 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 v13-20020a4ac00d0000b029020b43b918eeso1135200oop.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2jiYyfGon+l+dlMJ6kapOd+In1t5dSTiN7MQBF/Q/Es=;
 b=j30501PewlzcvcuQ4+8CqsWaMTS4JQ0lqMxYvK8rfcLbJEYtYIdIB1VD+EOmozA3Lh
 dPQ+IitmoW7fTYLvMf7jNrpt8gHvZRQZG/HuOsP1/aNI3dWJQOJ41+dk5i5m1M/423tK
 AoDRNcKCAPMaS2hIk3PsY+45IFW4k4I27XpU7BTsQmanXVZTxjBA6IX/hMftMhdvhUJH
 hehJIjIRAuVbSGJAc7SbogLAeC7DoW1YVNgHFFZGt79MAaOpZsvz2TJrXrSzPRoV8b0c
 cQR1SxkJhVOJAPhWBUjl74hlcbmhpRi8jlZge1WgV+9B7xHf79Sgv9CQiG+rMfdSoY2K
 XWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2jiYyfGon+l+dlMJ6kapOd+In1t5dSTiN7MQBF/Q/Es=;
 b=lUv3cbSvlCxQGNuDXLXLBHrzak0jC3OobahCPlkfWsqz67jG0YpqhvyFtPGSHjbd/x
 x/NNdMMKFhHVL7WRG2tSQ2E7J/gFVe6Y//8Jwym3MVkstgAUQoCTfiiOz+DblTM56rT2
 gfS3Ykg+8qg49xmg2/OfGRaZHVWEghjR9xf18q46aubc8o7Hb4lhA7KPk8JCghwepQEy
 Toy2S2/WWfsn2HJ7jsLPs+rWlA6EhZaIML5dteCxyMgqaMJN90pcfvwBiMJsLauym9NH
 8rmPfzbCgHf89CNPTGh8fNuGPXwvnrAWb5/ChZins0IlGvgiRmfOHs5nmXmZdUpCNaaI
 HSzg==
X-Gm-Message-State: AOAM531ZUdSEg57b/5ErDwJfNaCxU/Uh9yzNexwpNHy5R2/oMcZPshYy
 0iYYn6TeOEF34EazwPj0tsNCrk175V8IfBTjtDOKEKB/
X-Google-Smtp-Source: ABdhPJyLU0gR/kFQy8ahgNakokKjbP/wNRGj4ycisfi1FD3EebVM6PxVZFr23Qi3Yjm5fku9f9SUlVO0d3fbRkcejw8=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr32537508oos.72.1620918133701; 
 Thu, 13 May 2021 08:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <CADnq5_Or5maEWTZFzS6iksyoFC=q9=y=-YmPTdPuWRKFhdw0yg@mail.gmail.com>
 <YJ04D8a6LaVRMuGH@zn.tnic>
 <CADnq5_NQonmqtFDpfsWygGzA2kv-W-daDSkxkY2ALf9a1eby9g@mail.gmail.com>
 <YJ0+YbwSpxTrghpo@zn.tnic>
In-Reply-To: <YJ0+YbwSpxTrghpo@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 11:02:02 -0400
Message-ID: <CADnq5_PibVG4JRwtpX7at-dz6eT=XP8=pdy6a+4kCumdPxooeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
To: Borislav Petkov <bp@alien8.de>
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, x86-ml <x86@kernel.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 10:57 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, May 13, 2021 at 10:32:45AM -0400, Alex Deucher wrote:
> > Right.  The sys admin can query the bad page count and decide when to
> > retire the card.
>
> Yap, although the driver should actively "tell" the sysadmin when some
> critical counts of retired VRAM pages are reached because I doubt all
> admins would go look at those counts on their own.

I think we print something in the log as well when we hit the
threshold.  I need to double check the code.

>
> Btw, you say "admin" - am I to understand that those are some high end
> GPU cards with ECC memory? If consumer grade stuff has this too, then
> the driver should very much warn on such levels on its own because
> normal users won't know what and where to look.
>

Currently it's only available on workstation and datacenter boards.

> Other than that, the big picture sounds good to me.

Thanks!

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
