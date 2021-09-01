Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F6C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 08:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383116103A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 08:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 383116103A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D986F89617;
	Wed,  1 Sep 2021 08:18:25 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB6889617
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 08:18:24 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 k12-20020a056830150c00b0051abe7f680bso2527220otp.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Sep 2021 01:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wPcw5tjWJ+wO9coOpJKKvWC5n1KGwBjvh1fc5dEcMak=;
 b=GKmhYL4pRQIrhOQLDXeEiolsAcieFrKye7ekmI57dLqPsfyKZbR49zMI+os9YcPst8
 kMpWvtNRV1DaqjKF8CEFeXISv/IpYYmjX4nHioDz+7imVmaPxcGEXu1x4tJNA0ZiB6ME
 wrDlR2+sHCZP2XGPstW012wEHctoPZKGxsQ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wPcw5tjWJ+wO9coOpJKKvWC5n1KGwBjvh1fc5dEcMak=;
 b=PFsFA88iBqBRI2aBzZWnQ+swbkaIf6CJD81WVRYvDgrM1G4yWM0mvLiEPIH00Jh+X8
 d0k98nKcILB7QoSQvw0RqdTrHW+Y5xn2GDYTFUsSebSwIBY5RpjPDLEUFNqFpEF9OWdH
 2mownr0Y8ylybR0e63P52mmqPqfgf8AcVQoDr3Yrvv1n54d1PbSnhEg1pYEvIVdm5tet
 GWww+lpICRD99FCPXAwoEPw+aM8jdWwEq47C/Z4UAivErqfVVGlbu4ApeziyYzvQJ4ez
 HlQ/iCnXULPsUPBHaDg6f7dItds1Rl6DG1Pp+YrhGa+z+Bvs3H0/1qGdM9i5/3Ixl5di
 t9wQ==
X-Gm-Message-State: AOAM532wXkbpV/NpraNiWFLoHoJOWrRja3YyJS2WLxZAxDjgkyham2FZ
 eI1GjKGNEMCEGHx+VsEBZXduFPac9INzn2d0Owc7fQ==
X-Google-Smtp-Source: ABdhPJz05c+G8CWnq+IuHlbwS0UMDxrh1BXJ7T3nyc1jesV4PcZ3cgvBCyzaQXvZIt+vhh7tv0IHX/yHZqwwpLy10xM=
X-Received: by 2002:a05:6830:70b:: with SMTP id
 y11mr284176ots.281.1630484303762; 
 Wed, 01 Sep 2021 01:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <BL1PR12MB526942160701B46D4B28EEEC84CD9@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB526942160701B46D4B28EEEC84CD9@BL1PR12MB5269.namprd12.prod.outlook.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 1 Sep 2021 10:18:12 +0200
Message-ID: <CAKMK7uHKX0rSVk_yBPo_KAEJ-UeLk5UxQ2kBdv+FD2j9zAjfZA@mail.gmail.com>
Subject: Re: [diagnostic TDR mode patches] unify our solution
 opinions/suggestions in one thread
To: "Liu, Monk" <Monk.Liu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, 
 DRI Development <dri-devel@lists.freedesktop.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Monk,

On Wed, Sep 1, 2021 at 3:23 AM Liu, Monk <Monk.Liu@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
> Hi Daniel/Christian/Andrey
>
>
>
> It looks the voice from you three are spread over those email floods to m=
e, the feature we are working on (diagnostic TDR scheme) is pending there f=
or more than 6 month (we started it from feb 2021).

For me your project exists since a few weeks at most, because that is
when your team showed up on dri-devel. That you already spent 6 months
on this within amd, on a code area that very much affects shared code,
without kicking of any thread on dri-devel isn't great, but also not
something we can fix, since time machines don't exist.

So we have to make the best out of the situation and move ahead where
we are. From my understanding you've done a bunch of changes to the
scheduler code. As far as I can see there's been two related things
your team has done:

- remove some allocations from scheduler code, because that can lead
to deadlocks. I've kicked up this topic quite a while ago here

https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ff=
wll.ch/

This is just one patch of the entire series. This is an area where we
really need a consistent solution across all drm/sched drivers, not
something that individual drivers just fix in their own way.

- the other one is the timeout issue for the patches you cite here.
Again there's been discussion on this on dri-devel with Boris from
panfrost about how we can handle at least some of the races in tdr.
That resulted in lots of discussions and documentation improvements.
Those patches are merged now, link
https://lore.kernel.org/dri-devel/20210625133327.2598825-2-boris.brezillon@=
collabora.com/

There's been more than just this, also quite some doc patches from
Boris that explain how it's all supposed to work and be race-free.
Again your driver isn't the only one with interesting TDR races.

Your team hasn't been active in any of these discussions, but now
suddenly pops up out of nowhere and demands that your approach needs
to land asap. That's really not how upstream works.

The other thing where I'm struggling is that there's a lot of missing
context for outsiders. The patches sometimes come with zero commit
message, for tricky concurrency bugs. And there's no context with what
you've done already on the amdgpu side (since that never showed up on
dri-devel), which makes constructive discussions here really hard.

Now fixing these bugs is obviously good, but the way this is supposed
to work when touching shared infrastructure is:

- Before you start merging anything kick off an RFC thread on
dri-devel (or whatever the topic really is about) about the problem
you have and how your trying to solve it. This can be just text if
it's a big thing, but it can also already include some proof of
concept solution in the form of patches.

- Then we iterate on the solution, across drivers and shared code
_together_. Not "merge amdgpu code first, then get annoyed when the
core changes don't land immediately after you've practially finished
the project".

- This might mean changes to other drivers if we need to adjust interfaces.

On the plus side you can plan much better, because you know you have
upstream buy-in before you start to put in real work on the project.

> Honestly speaking the email ways that we are using now is not friendly an=
d quite painful to me =E2=80=A6.

Yes this is painful :-(

I think the best way forward is to go through the above process again
and essentially restart. So submit a complete patch series with
problem descriptions, solution you picked, why you picked that, all
the amdgpu patches to get there and the core patches too. Since it
sounds like a bunch of this has all landed already you probably need a
patch 1 that goes back to 6 months ago so that we can see the overall
direction, and review whether that's the right one or not.

The not-so-painful approach would have been to do this from the start,
6 months ago. It would definitely have helped if the tdr discussion
we've had just a few months ago would have involved your team too, I'm
sure there would have been some good insights from amd's side. I'd
really want you and your engineers involved here, so let's do this
properly!

Cheers, Daniel

> Can we try to put all our opinions, suggestions, or even objects here tog=
ether, let=E2=80=99s go through them one by one, it=E2=80=99s too hard for =
us to reply each email on different questions .
>
>
>
> For [PATCH 1/2] drm/sched: fix the bug of time out calculation(v4)
>
>
>
> This is a fixing patch on the timeout timer in scheduler, can we complete=
 this one first ? it should already resolved all the questions and suggesti=
ons.
>
>
>
> For [PATCH 2/2] drm/sched: serialize job_timeout and scheduler
>
>
>
> I think I already explained the questions raised by Daniel in other threa=
d , regarding why I use __kthread_should_park()
>
> For other aspects, can we put all our opinion synthesized here ?
>
>
>
> Thanks !
>
>
>
> ------------------------------------------
>
> Monk Liu | Cloud-GPU Core team
>
> ------------------------------------------
>
>



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
