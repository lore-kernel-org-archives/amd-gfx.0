Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD42C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 14:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46F610E1FA;
	Mon, 15 May 2023 14:42:42 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE1810E1FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 14:42:40 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1925ad4953dso6019035fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684161759; x=1686753759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H89B/9HN4gmozC1Ely8aiFisGVL+cOJXLQAYdQDSG4U=;
 b=HmRnMHGVaR/LFsul9zi4L7igZwOfd/vVGXsEzXu2OexIVEwbZdp71vgUSFEN7ZtWDh
 RSAq7EILQYrKOFWkExZXZ+xp59/PCxepyBubTZ1Xf3SvMOp/3YCIRx7gKMHEM83vD6mb
 y4Xj73sR/lQTqYGnC/hoCrRTFwYROKjjn7j5dXT7RJgQR+r+peoQxVXtwj6pY3sua6fV
 siVnxmaDos7uNvI+I24KCR2stFAhN7+iOig74C+tqdNUHKh1WBDZ8E28bEP3nDPneR0a
 b7CsPiO7stBzeL2WQUir+LcyUsVc6oomic4lCVaP6GRKIEKzyk8myz1i+vOizB+ihtid
 SF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684161759; x=1686753759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H89B/9HN4gmozC1Ely8aiFisGVL+cOJXLQAYdQDSG4U=;
 b=NWsYjHWWOEpTxgFYDHvYCh+Z9O9AGxUHFOycGqFijeLu54rrEKPNhjc91XhNNOP/Y2
 5hgyIo+vP/xI/RvW6oGUyTXWXug2kyM11Su93FXOJthOGlZ2rstqeowsjicEv6OcB3vq
 MS/lvBezGahGzb9uLeb2R5w1bgqMXD6lFtIDqLu6CT4nZm/03/N4GrFcDeRF7di41StQ
 P1MidrHDBSqqOQaaA5F2ZywiRwyWtFyM8rEJ+8b5LI1sUhK3AD5Ox7/IdRAZzm+413af
 yvb/28bXGBji8d7I7SX++YsgUDppntfxMmXXo+0zZDQE3i1cfzfl1yX6slhrRf9s51vV
 g8qw==
X-Gm-Message-State: AC+VfDzy5fGliycTjyovS1K4KJCKRQN89MF8d8J3tFh2tX9bVm2T38wH
 anqxKGFdaB3fJ1G0z2I5+fWuRE6UQLQbf2zeMSmp9eOJ
X-Google-Smtp-Source: ACHHUZ79NkgeebKXTQVEAHDXj0VZq+f/aMRiC9oPiXGzFEAxIVRsiscL60KzDKf2V8xWClu3RWmmNIvo3/ceRWWULYY=
X-Received: by 2002:a05:6870:822b:b0:187:bda6:db2d with SMTP id
 n43-20020a056870822b00b00187bda6db2dmr15482206oae.13.1684161759403; Mon, 15
 May 2023 07:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZF2W8ZS7FUdKHSoh@sellars>
In-Reply-To: <ZF2W8ZS7FUdKHSoh@sellars>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 May 2023 10:42:28 -0400
Message-ID: <CADnq5_NFGrtQbFBopP6kmV6rTMWrQTuTzALyXSDPAT=7a9GPTg@mail.gmail.com>
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

On Thu, May 11, 2023 at 9:38=E2=80=AFPM Linus L=C3=BCssing <linus.luessing@=
c0d3.blue> wrote:
>
> Hi,
>
> Initially noticed this in some games, which seem to be a bit lazy
> with their VRAM allocations + freeing, that performance would drop
> dramatically / become unusable once the VRAM is full and GTT gets
> used. For instance in No Man's Sky after jumping a solar system
> or on DCS World on several maps and in multiplayer. I'm using an
> ATI/AMD Radeon RX 6650 XT, 8GB VRAM with an eGPU enclosure
> (Razer Core X Chroma, Thunderbolt 3), connected via a 40Gbit/s
> USB4 port. Which usually has great performance, until I hit the
> VRAM limit.
>
> I scripted some further tests and benchmarking around
> memmtest_vulkan(*) and these were the results:
>
> https://github.com/T-X/linux-amdgpu-radeon-vram-swapping-test/
>
> I would have expected roughly the same speeds in all tests.
> However tests 5) and 6) yielded significantly lower performance.
>
> Which leads me to the conclusion that anything that gets allocated
> on GTT stays there and is never unswapped from GTT / system memory
> back to VRAM?

It will get swapped back to VRAM if it makes sense for performance.
The driver throttles swapping if there is too much contention to avoid
the overhead of swapping large amounts of memory back and forth
between vram and gtt for every command submission.

Alex

>
> I also read that there was some rework with a new TTM allocator
> in 2020. But dynamic (un)swapping via TTM seems currently unused?
> Is this expected?
>
> Regards, Linus
>
> (*): https://github.com/GpuZelenograd/memtest_vulkan
