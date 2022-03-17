Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDF9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 14:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C93610EAEC;
	Thu, 17 Mar 2022 14:23:20 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C43D10E624
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 14:22:15 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-2e5757b57caso59921537b3.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jbzrEoZkh3IQyGP4Z/QZFnd3Nhw5QZGTt4HaViU1gk8=;
 b=SFiUBQTIojjILrohES4QijrGh/3sRD5oenIxtoQoURDyuF9AyNvYsaaGcHG7vL+gFN
 +kC2Kt0bu0d4mG3en7bhneeHvzvKimIVxYYPeD1GtZzquzwCkquhuektYYGWdqgJMsNO
 lihAh+8WAzE3DUd2sbWEDaxuP9cj6NyOE0M6WaVM5fo29LXeEy2TNL2dX3hD8wuwg/Nz
 LmTHX/PvxmICA1qvlqPHfIHsMFjazuV7PHtv/cexjui+mR4m4ylG1yAhO2x4qerN1IVr
 cAWcwn8q/0kUqwdXCNlc7AffsXnEGZUcher3lXVTjzN3TnfW8Z50qZDvGSiP7A6cF8KA
 kf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jbzrEoZkh3IQyGP4Z/QZFnd3Nhw5QZGTt4HaViU1gk8=;
 b=VBoCEV8vDxcItP8ixSJxW/kr/jcsLg+L+FJV19EVUXFHPI3iW9dCNbcvoXZB98/94P
 EFEO2k3fFjchrQB6w7xRAiGrC2Crouooz8+qI351iXf5YOhk43lqAeaPYa8K3pKVIHA0
 Nbx7DLhHVUNbSNbQQFlNge2zed4wThcHyYomzfJM3OVDRD50oaLpy1cw7OVRtmZJAMq2
 TqKRY2RoV5y2gJLQrcSt+qA3rX8W3SJ30+tvH+qn1ui/cikxIF0BlUbxEhOdLz/zslA5
 i6OpGBLadYos5MY2BqzLZKko9yf7TeBbaBEfMyuh+QqnP+doTrwNvsuW8Brsnk2rg/N9
 T/QA==
X-Gm-Message-State: AOAM531UwsYL3diKM5Jh3QBsoQ9M2dfN+Frz+zLQVBpapb9B+IrsDrv8
 1tHKvY5pLS+vXJZw0v4vogahsvlveXyJiRG27Xo=
X-Google-Smtp-Source: ABdhPJzaUJRyQ7NS7G9QBdOSwtwPWvllkyOA2eEI/Gn97gTGRfyV2+YERgdmbCwOkSV6TwYnhnCj5pefmUk9mw9mQb4=
X-Received: by 2002:a0d:c947:0:b0:2e5:c4fa:b5ab with SMTP id
 l68-20020a0dc947000000b002e5c4fab5abmr1952351ywd.241.1647526934337; Thu, 17
 Mar 2022 07:22:14 -0700 (PDT)
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
 <CAMdYzYpt1vOCXiDUHCnuVRKnQ51Qissj9-w75FB6nVrFWS-9iw@mail.gmail.com>
 <6f5aaddd-e793-e5f1-17aa-71e7804f035f@arm.com>
In-Reply-To: <6f5aaddd-e793-e5f1-17aa-71e7804f035f@arm.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Thu, 17 Mar 2022 10:21:59 -0400
Message-ID: <CAMdYzYrxM-+kt=4_zHX9Nfy_cW0jWfw9n30N=3VePkvMuKYyBA@mail.gmail.com>
Subject: Re: radeon ring 0 test failed on arm64
To: Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Mar 2022 14:23:19 +0000
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
Cc: Simon Xue <xxm@rock-chips.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Jingoo Han <jingoohan1@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 17, 2022 at 9:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-17 12:26, Peter Geis wrote:
> > On Thu, Mar 17, 2022 at 6:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-03-17 00:14, Peter Geis wrote:
> >>> Good Evening,

I've added the Designware driver maintainers, since the Rockchip host
driver uses the dwc driver.

> >>>
> >>> I apologize for raising this email chain from the dead, but there have
> >>> been some developments that have introduced even more questions.
> >>> I've looped the Rockchip mailing list into this too, as this affects
> >>> rk356x, and likely the upcoming rk3588 if [1] is to be believed.
> >>>
> >>> TLDR for those not familiar: It seems the rk356x series (and possibly
> >>> the rk3588) were built without any outer coherent cache.
> >>> This means (unless Rockchip wants to clarify here) devices such as the
> >>> ITS and PCIe cannot utilize cache snooping.
> >>> This is based on the results of the email chain [2].
> >>>
> >>> The new circumstances are as follows:
> >>> The RPi CM4 Adventure Team as I've taken to calling them has been
> >>> attempting to get a dGPU working with the very broken Broadcom
> >>> controller in the RPi CM4.
> >>> Recently they acquired a SoQuartz rk3566 module which is pin
> >>> compatible with the CM4, and have taken to trying it out as well.
> >>>
> >>> This is how I got involved.
> >>> It seems they found a trivial way to force the Radeon R600 driver to
> >>> use Non-Cached memory for everything.
> >>> This single line change, combined with using memset_io instead of
> >>> memset, allows the ring tests to pass and the card probes successfully
> >>> (minus the DMA limitations of the rk356x due to the 32 bit
> >>> interconnect).
> >>> I discovered using this method that we start having unaligned io
> >>> memory access faults (bus errors) when running glmark2-drm (running
> >>> glmark2 directly was impossible, as both X and Wayland crashed too
> >>> early).
> >>> I traced this to using what I thought at the time was an unsafe memcpy
> >>> in the mesa stack.
> >>> Rewriting this function to force aligned writes solved the problem and
> >>> allows glmark2-drm to run to completion.
> >>> With some extensive debugging, I found about half a dozen memcpy
> >>> functions in mesa that if forced to be aligned would allow Wayland to
> >>> start, but with hilarious display corruption (see [3]. [4]).
> >>> The CM4 team is convinced this is an issue with memcpy in glibc, but
> >>> I'm not convinced it's that simple.
> >>>
> >>> On my two hour drive in to work this morning, I got to thinking.
> >>> If this was an memcpy fault, this would be universally broken on arm64
> >>> which is obviously not the case.
> >>> So I started thinking, what is different here than with systems known to work:
> >>> 1. No IOMMU for the PCIe controller.
> >>> 2. The Outer Cache Issue.
> >>>
> >>> Robin:
> >>> My questions for you, since you're the smartest person I know about
> >>> arm64 memory management:
> >>> Could cache snooping permit unaligned accesses to IO to be safe?
> >>
> >> No.
> >>
> >>> Or
> >>> Is it the lack of an IOMMU that's causing the alignment faults to become fatal?
> >>
> >> No.
> >>
> >>> Or
> >>> Am I insane here?
> >>
> >> No. (probably)
> >>
> >> CPU access to PCIe has nothing to do with PCIe's access to memory. From
> >> what you've described, my guess is that a GPU BAR gets put in a
> >> non-prefetchable window, such that it ends up mapped as Device memory
> >> (whereas if it were prefetchable it would be Normal Non-Cacheable).
> >
> > Okay, this is perfect and I think you just put me on the right track
> > for identifying the exact issue. Thanks!
> >
> > I've sliced up the non-prefetchable window and given it a prefetchable window.
> > The 256MB BAR now resides in that window.
> > However I'm still getting bus errors, so it seems the prefetch isn't
> > actually happening.
>
> Note that "prefetchable" really just means "no side-effects on reads",
> i.e. we can map it with a Normal memory type that technically *allows*
> the CPU to make speculative accesses because they will not be harmful,
> but that's not to say the CPU will do so. Just that if it did, you
> wouldn't notice anyway.
>
> It's entirely possible that the PCIe IP itself doesn't like unaligned
> accesses, so changing the memory type just moves you from an alignment
> fault to an external abort.

Okay, I've tried setting up PL_COHERENCY_CONTROL_3_OFF, where AxCACHE
can be forced from auto to predefined for reads and writes.
As I understand it, the cache bit should permit characteristic
mismatch to be accepted and prefetch to be enabled, when combined with
the read/write bits.
It doesn't seem to make a difference however.
I got the idea to look for this from the Armada8K and Tegra drivers.

It would be nice to know if dGPUs work at all on *any* DWC based PCIe
controllers.
We could use those as a starting point to find out what's broken here.

>
> > The difference is now the GPU realizes that an error has happened and
> > initiates recovery, vice before where it seemed to be clueless.
> > If I understand everything correctly, that's because before the bus
> > error was raised by the CPU due to the memory flag, vice now where
> > it's actually the bus raising the alarm.
> >
> > My next question, is this something the driver should set and isn't,
> > or is it just because of the broken cache coherency?
>
> The general rule for userspace mmap()ing PCIe-attached memory and
> handing it off to glibc or anyone else who might assume it's regular
> system RAM is "don't do that". If it's not access size or alignment that
> falls over, it could be atomic operations, MTE tags, or any other
> new-fangled memory innovation. For the ultimate dream of just plugging
> in a card full of RAM, you either need to look back to ISA or forward to
> CXL ;)

So either go back to the really old way of doing things, find and fix
the underlying problem, or wait for the IP to catch up?

>
> Robin.

Thanks!
Peter
