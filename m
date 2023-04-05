Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C0FC7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 08:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E2310E87B;
	Wed,  5 Apr 2023 08:29:00 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4425010E87D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 08:28:58 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-177b78067ffso37565366fac.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Apr 2023 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1680683336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXA/l+z5WhIJoyhAr9FoVJ3CB1nfPNcZnynaiD+D5wE=;
 b=jnOfoRQhSw9mvFP94fQbu2afO7QYtSo7VH1fyxaSmK9iXdyHBP9/ADYEaRfBBl9h37
 oHpbn7tcgUXy3V70XHIPzjHIiPzyIFBEVoiAx5CZNnbE/G0rXSRpBVaf+Py7sxunp40t
 gWCnM9AnJXZLiUEcIBtKSn/dy3bjymkg96om0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680683336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXA/l+z5WhIJoyhAr9FoVJ3CB1nfPNcZnynaiD+D5wE=;
 b=Y5d/BlUCk0h9LNHgRWInij4cYb/rzbv6zI1LO3XDQk3aYGpcUL0YGi06ngyyvH2GxN
 e6/aKE+qvuXcCHBFvytE7CUGcD1BBb+3uMjVj8Cy1NXbsq4uVugY7lTwQ+a0Yark0Enl
 HEJ7q2bOW8neSc/83DM8x6tuSrq6fHrp2lQ5YGf09/q8BQ9sIywn7qu0682CNekvFHPR
 mXXvfJ77EBL2MYwbOii9elwNx5haFWXa4MEQlUfpkN8OWzp2Vb5E5q88j3q5aEuYsy3U
 rLKuQb8Q1yBsKf2ADStueFkTZMbPPr2c+5qVlgdc51qPA4YOg/jjMhkZSUZo5U5xOyeQ
 nBdg==
X-Gm-Message-State: AAQBX9fPveAAA+jQgZm54yMxGd6Jst38dBbeDfcblUecDUocWDttkHAQ
 KiT/jQ3q9di/y1i3SdTWmStnarAGVgfwRm5JToc/Xw==
X-Google-Smtp-Source: AKy350YPCyCtLI9MzqLVftUqoTS343CTLiMruivDJauvH3oHzMuGYacpJEmoGEO2h5XWw67yjw0sE6ECd8XAZQ2qZR4=
X-Received: by 2002:a05:6870:e747:b0:17e:d863:a5c0 with SMTP id
 t7-20020a056870e74700b0017ed863a5c0mr2747437oak.8.1680683336411; Wed, 05 Apr
 2023 01:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230403194058.25958-1-joshua@froggi.es>
 <fa0360e4-b845-92ee-3c6d-a593cc4135b5@linux.intel.com>
In-Reply-To: <fa0360e4-b845-92ee-3c6d-a593cc4135b5@linux.intel.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 5 Apr 2023 10:28:45 +0200
Message-ID: <CAKMK7uE7iFJL4_3GD2Vx4g99rJ2tQoLLsFA9GmYw_CBf1VB1Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] uapi, drm: Add and implement RLIMIT_GPUPRIO
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
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
Cc: Matthew Brost <matthew.brost@intel.com>, Asahi Lina <lina@asahilina.net>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@redhat.com>, Qiang Yu <yuq825@gmail.com>,
 Joshua Ashton <joshua@froggi.es>, Lucas Stach <l.stach@pengutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 4 Apr 2023 at 12:45, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> Hi,
>
> On 03/04/2023 20:40, Joshua Ashton wrote:
> > Hello all!
> >
> > I would like to propose a new API for allowing processes to control
> > the priority of GPU queues similar to RLIMIT_NICE/RLIMIT_RTPRIO.
> >
> > The main reason for this is for compositors such as Gamescope and
> > SteamVR vrcompositor to be able to create realtime async compute
> > queues on AMD without the need of CAP_SYS_NICE.
> >
> > The current situation is bad for a few reasons, one being that in order
> > to setcap the executable, typically one must run as root which involves
> > a pretty high privelage escalation in order to achieve one
> > small feat, a realtime async compute queue queue for VR or a compositor=
.
> > The executable cannot be setcap'ed inside a
> > container nor can the setcap'ed executable be run in a container with
> > NO_NEW_PRIVS.
> >
> > I go into more detail in the description in
> > `uapi: Add RLIMIT_GPUPRIO`.
> >
> > My initial proposal here is to add a new RLIMIT, `RLIMIT_GPUPRIO`,
> > which seems to make most initial sense to me to solve the problem.
> >
> > I am definitely not set that this is the best formulation however
> > or if this should be linked to DRM (in terms of it's scheduler
> > priority enum/definitions) in any way and and would really like other
> > people's opinions across the stack on this.
> >
> > Once initial concern is that potentially this RLIMIT could out-live
> > the lifespan of DRM. It sounds crazy saying it right now, something
> > that definitely popped into my mind when touching `resource.h`. :-)
> >
> > Anyway, please let me know what you think!
> > Definitely open to any feedback and advice you may have. :D
>
> Interesting! I tried to solved the similar problem two times in the past =
already.
>
> First time I was proposing to tie nice to DRM scheduling priority [1] - i=
f the latter has been left at default - drawing the analogy with the nice+i=
onice handling. That was rejected and I was nudged towards the cgroups rout=
e.
>
> So with that second attempt I implemented a hierarchical opaque drm.prior=
ity cgroup controller [2]. I think it would allow you to solve your use cas=
e too by placing your compositor in a cgroup with an elevated priority leve=
l.
>
> Implementation wise in my proposal it was left to individual drivers to "=
meld" the opaque cgroup drm.priority with the driver specific priority conc=
ept.
>
> That too wasn't too popular with the feedback (AFAIR) that the priority i=
s a too subsystem specific concept.
>
> Finally I was left with a weight based drm cgroup controller, exactly fol=
lowing the controls of the CPU and IO ones, but with much looser runtime gu=
arantees. [3]
>
> I don't think this last one works for your use case, at least not at the =
current state for drm scheduling capability, where the implementation is a =
"bit" too reactive for realtime.
>
> Depending on how the discussion around your rlimit proposal goes, perhaps=
 one alternative could be to go the cgroup route and add an attribute like =
drm.realtime. That perhaps sounds abstract and generic enough to be passabl=
e. Built as a simplification of [2] it wouldn't be too complicated.
>
> On the actual proposal of RLIMIT_GPUPRIO...
>
> The name would be problematic since we have generic hw accelerators (not =
just GPUs) under the DRM subsystem. Perhaps RLIMIT_DRMPRIO would be better =
but I think you will need to copy some more mailing lists and people on tha=
t one. Because I can imagine one or two more fundamental questions this ope=
ns up, as you have eluded in your cover letter as well.

So I don't want to get into the bikeshed, I think Tvrtko summarized
pretty well that this is a hard problem with lots of attempts (I think
some more from amd too). I think what we need are two pieces here
really:
- A solid summary of all the previous attempts from everyone in this
space of trying to manage gpu compute resources (all the various
cgroup attempts, sched priority), listening the pros/cons. There's
also the fdinfo stuff just for reporting gpu usage which blew up kinda
badly and didn't have much discussion among all the stakeholders.
- Everyone on cc who's doing new drivers using drm/sched (which I
think is everyone really, or using that currently. So that's like
etnaviv, lima, amd, intel with the new xe, probably new nouveau driver
too, amd ofc, panfrost, asahi. Please cc everyone.

Unless we do have some actual rough consens in this space across all
stakeholders I think all we'll achieve is just yet another rfc that
goes nowhere. Or maybe something like the minimal fdinfo stuff
(minimal I guess to avoid wider discussion) which then blew up because
it wasn't thought out well enough.

Adding at least some of the people who probably should be cc'ed on
this. Please add more.

Cheers, Daniel


>
> Regards,
>
> Tvrtko
>
> [1] https://lore.kernel.org/dri-devel/20220407152806.3387898-1-tvrtko.urs=
ulin@linux.intel.com/T/
> [2] https://lore.kernel.org/lkml/20221019173254.3361334-4-tvrtko.ursulin@=
linux.intel.com/T/#u
> [3] https://lore.kernel.org/lkml/20230314141904.1210824-1-tvrtko.ursulin@=
linux.intel.com/



--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
