Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3FAC7EE22
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565D710E20A;
	Mon, 15 May 2023 14:51:41 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E010010E204
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 14:51:38 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-54fa79be6e8so2456227eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684162297; x=1686754297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GadG8zda3mxGC1Q5Zhq8J3resCS8TP5mWRCDmcgC3Y=;
 b=Ljb1tJXj0mSKZ3kDH227zWJe2drgzmq0fwJSSz7ltj7PmRHzaeIvsisXkBdNNX384d
 FyLMY62jzUvvxvesczBiu69NcMtVYDHySU6wIvo/ngtEmUpd6DMslbWiCwTuNCyZJgG6
 9UbwSNS0oyp42uS0zOWbXL5EF8k83uP0smfBjV1kGgbiyLK+J9m2bjHgGOKgCfanAyui
 JTa/3P/KJtcEeLlhG0KPHyVAAkNFG06GSWfhdbkoBK5EdbEd6m4qeei94itkouJdC1+w
 pgD64uOeESIRLAOiY043jWKibA/E4P27oLGvkKCacnGo2Y/P/QyG6/AWb6BwlXMDTgFW
 CpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684162297; x=1686754297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GadG8zda3mxGC1Q5Zhq8J3resCS8TP5mWRCDmcgC3Y=;
 b=A2TIgYSbDLXsYsIvN2yb7RCzb6CDRaQuWgo8YwnDI+wEo5Ka3mg21ayHEIbqI7z26C
 tuzZpDJaRglS7f4/SWKQvc2M9SMGqBmzmpW1nws2o/eOU6GE65bzknm/Av1SdpBm87yk
 o6d4B29Y/evPqG/gyX2CeRS48irt5c8DFTgx4BqVMdHVu3YXj36UHbYJvhWmZrEkF78N
 1QazO+oANjMmzM7Lu/N2hpfRMnagNpD4HRBbrJ1MHJxm7g0fGK84f4sJL5JwUS4Sho3g
 U1kQkuPjVZM2TrBFyMYSJ1+LSmI5ajHGh10ienBBtODnmJItcu7FHStYw73h2slxLdnc
 7Oqw==
X-Gm-Message-State: AC+VfDzEAZcGZFzSh6md9pW9Z40/RiCEP4OUTk51Mr50vcOkE5QiuS68
 LGDWiSZFouWVRcPsvHcqxP8u3eTjaGdCJ3/vFnaVLAwO1L4=
X-Google-Smtp-Source: ACHHUZ5Xy+UCRpmr1M40v+GAPnFEkEIJO9wQEQp57u7aAO/941WxcgbkSSxmrkMvSJ2Zfj9Hz0wpqJlv1azppE1AEXE=
X-Received: by 2002:a05:6808:4cf:b0:38d:ec3f:3118 with SMTP id
 a15-20020a05680804cf00b0038dec3f3118mr9993452oie.28.1684162296056; Mon, 15
 May 2023 07:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZF2W8ZS7FUdKHSoh@sellars>
 <CADnq5_NFGrtQbFBopP6kmV6rTMWrQTuTzALyXSDPAT=7a9GPTg@mail.gmail.com>
In-Reply-To: <CADnq5_NFGrtQbFBopP6kmV6rTMWrQTuTzALyXSDPAT=7a9GPTg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 May 2023 10:51:25 -0400
Message-ID: <CADnq5_NtKDuBv1QB-4cy3sY6O+BZpGvOVbvtz83LUrMs0YHD1A@mail.gmail.com>
Subject: Re: No GTT->VRAM unswapping with amdgpu?
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 15, 2023 at 10:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Thu, May 11, 2023 at 9:38=E2=80=AFPM Linus L=C3=BCssing <linus.luessin=
g@c0d3.blue> wrote:
> >
> > Hi,
> >
> > Initially noticed this in some games, which seem to be a bit lazy
> > with their VRAM allocations + freeing, that performance would drop
> > dramatically / become unusable once the VRAM is full and GTT gets
> > used. For instance in No Man's Sky after jumping a solar system
> > or on DCS World on several maps and in multiplayer. I'm using an
> > ATI/AMD Radeon RX 6650 XT, 8GB VRAM with an eGPU enclosure
> > (Razer Core X Chroma, Thunderbolt 3), connected via a 40Gbit/s
> > USB4 port. Which usually has great performance, until I hit the
> > VRAM limit.
> >
> > I scripted some further tests and benchmarking around
> > memmtest_vulkan(*) and these were the results:
> >
> > https://github.com/T-X/linux-amdgpu-radeon-vram-swapping-test/
> >
> > I would have expected roughly the same speeds in all tests.
> > However tests 5) and 6) yielded significantly lower performance.
> >
> > Which leads me to the conclusion that anything that gets allocated
> > on GTT stays there and is never unswapped from GTT / system memory
> > back to VRAM?
>
> It will get swapped back to VRAM if it makes sense for performance.
> The driver throttles swapping if there is too much contention to avoid
> the overhead of swapping large amounts of memory back and forth
> between vram and gtt for every command submission.

RADV also dynamically prefers GTT if you are using an eGPU and memory
is contended:
https://cgit.freedesktop.org/mesa/mesa/commit/?id=3D95d06343c693aa12b4cda5c=
da31d81fae138b0ec

Alex

>
> Alex
>
> >
> > I also read that there was some rework with a new TTM allocator
> > in 2020. But dynamic (un)swapping via TTM seems currently unused?
> > Is this expected?
> >
> > Regards, Linus
> >
> > (*): https://github.com/GpuZelenograd/memtest_vulkan
