Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F76C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B84310EBB6;
	Thu, 17 Mar 2022 13:11:12 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB10E10EB17
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 12:27:12 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id y142so9842848ybe.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LdctqbxEVDhQYvXDWmmeebZ0ThVF6Vvf++/7X2JTCJ8=;
 b=NgegS/3xXWHhJZ+h+d8E8O7udktNPpwoJowIpEdN96EYhMXLEjnwxKuqGxuZnjG4++
 q7+4YWF/NHhqwBcf5RwJjrhS50aacDBu9FmkptgQ7Z7cMKaxs3UvgaQmT3M96RTERk4P
 pYF5uSGmWJcdg9weIdBYJHpd57sZrC4rwyOmp2med4PO8AgZinm46X3xCvMCXzmVWSNO
 bUnfN74fXkB3dF4tsbIiuYpxP1ufITYwwx3sfW0kQbJ1IfefFnDcoPArd7qgKhWuBgjX
 RxzRNZ1GoAGJOv1rirRl0ELuAfiPHyZHIibdTGi4fc2OSdkAXz65xr4IJ1bs8l2DOcxm
 N+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LdctqbxEVDhQYvXDWmmeebZ0ThVF6Vvf++/7X2JTCJ8=;
 b=Bhn9ECgnjQGj6QcCJQtQKCO2aGAiT1X1d5KOixrjz5Vbl6HfH+m4a3rVlwTLxdqD+s
 B3IxYY0JuVlNO6J5mp2kJZdW8WulOQBxqLkGYJsvB1iWfcEDPrmuNi7U37Ql6tRd+zbX
 ZXVZDEJVEQdzfLAFTgxIRwD09yYArFkcp2sG2iGzmuegFvN4BBYXA07yeLQs6aO8NeuK
 f42xlbqyUsIOwWVWMJN6YfakjRSngdHT2ISrdbRfj4PqpD+7mIn5i8el+M3PIuL4kfd6
 4eCufivTLZ5cCGN0A4hTjBOwybyKwkhowdqOBdFOA5XNkw8f3h+28O6CSA2eBwzc97jt
 THcQ==
X-Gm-Message-State: AOAM5336YBv9aIlhAat1nzysPVmSxD6ZuCtZj/KWCY+C1y+EXe9Ma5aE
 Klb7Bwnn+T+pOBXsYbszRNuzP9vRBJbPYeNJ/Gs=
X-Google-Smtp-Source: ABdhPJwCBKSWEr+iQJyBYOMQKOUXfv83u9thixxmY/S06ul6Wpnil+dZXTcHg6YAnmKn3zkYeTVHkEQstFwI206YOGU=
X-Received: by 2002:a25:bc87:0:b0:633:806d:9c7d with SMTP id
 e7-20020a25bc87000000b00633806d9c7dmr4784082ybk.232.1647520031959; Thu, 17
 Mar 2022 05:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <c3bd7c08-f7e3-153e-8445-8e867916d03c@arm.com>
In-Reply-To: <c3bd7c08-f7e3-153e-8445-8e867916d03c@arm.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Thu, 17 Mar 2022 08:26:57 -0400
Message-ID: <CAMdYzYpt1vOCXiDUHCnuVRKnQ51Qissj9-w75FB6nVrFWS-9iw@mail.gmail.com>
Subject: Re: radeon ring 0 test failed on arm64
To: Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Mar 2022 13:11:06 +0000
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
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 6:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-17 00:14, Peter Geis wrote:
> > Good Evening,
> >
> > I apologize for raising this email chain from the dead, but there have
> > been some developments that have introduced even more questions.
> > I've looped the Rockchip mailing list into this too, as this affects
> > rk356x, and likely the upcoming rk3588 if [1] is to be believed.
> >
> > TLDR for those not familiar: It seems the rk356x series (and possibly
> > the rk3588) were built without any outer coherent cache.
> > This means (unless Rockchip wants to clarify here) devices such as the
> > ITS and PCIe cannot utilize cache snooping.
> > This is based on the results of the email chain [2].
> >
> > The new circumstances are as follows:
> > The RPi CM4 Adventure Team as I've taken to calling them has been
> > attempting to get a dGPU working with the very broken Broadcom
> > controller in the RPi CM4.
> > Recently they acquired a SoQuartz rk3566 module which is pin
> > compatible with the CM4, and have taken to trying it out as well.
> >
> > This is how I got involved.
> > It seems they found a trivial way to force the Radeon R600 driver to
> > use Non-Cached memory for everything.
> > This single line change, combined with using memset_io instead of
> > memset, allows the ring tests to pass and the card probes successfully
> > (minus the DMA limitations of the rk356x due to the 32 bit
> > interconnect).
> > I discovered using this method that we start having unaligned io
> > memory access faults (bus errors) when running glmark2-drm (running
> > glmark2 directly was impossible, as both X and Wayland crashed too
> > early).
> > I traced this to using what I thought at the time was an unsafe memcpy
> > in the mesa stack.
> > Rewriting this function to force aligned writes solved the problem and
> > allows glmark2-drm to run to completion.
> > With some extensive debugging, I found about half a dozen memcpy
> > functions in mesa that if forced to be aligned would allow Wayland to
> > start, but with hilarious display corruption (see [3]. [4]).
> > The CM4 team is convinced this is an issue with memcpy in glibc, but
> > I'm not convinced it's that simple.
> >
> > On my two hour drive in to work this morning, I got to thinking.
> > If this was an memcpy fault, this would be universally broken on arm64
> > which is obviously not the case.
> > So I started thinking, what is different here than with systems known to work:
> > 1. No IOMMU for the PCIe controller.
> > 2. The Outer Cache Issue.
> >
> > Robin:
> > My questions for you, since you're the smartest person I know about
> > arm64 memory management:
> > Could cache snooping permit unaligned accesses to IO to be safe?
>
> No.
>
> > Or
> > Is it the lack of an IOMMU that's causing the alignment faults to become fatal?
>
> No.
>
> > Or
> > Am I insane here?
>
> No. (probably)
>
> CPU access to PCIe has nothing to do with PCIe's access to memory. From
> what you've described, my guess is that a GPU BAR gets put in a
> non-prefetchable window, such that it ends up mapped as Device memory
> (whereas if it were prefetchable it would be Normal Non-Cacheable).

Okay, this is perfect and I think you just put me on the right track
for identifying the exact issue. Thanks!

I've sliced up the non-prefetchable window and given it a prefetchable window.
The 256MB BAR now resides in that window.
However I'm still getting bus errors, so it seems the prefetch isn't
actually happening.
The difference is now the GPU realizes that an error has happened and
initiates recovery, vice before where it seemed to be clueless.
If I understand everything correctly, that's because before the bus
error was raised by the CPU due to the memory flag, vice now where
it's actually the bus raising the alarm.

My next question, is this something the driver should set and isn't,
or is it just because of the broken cache coherency?

>
> Robin.

Thanks again!
Peter
