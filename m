Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C5C3F2D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D337246A8
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="yqJhgiPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D337246A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE42A6EEA4;
	Fri, 28 Feb 2020 09:27:06 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EEE6EE9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:27:05 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id m10so8902857wmc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 01:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9/5aSuOnLbh8GxGcND8KueDA6BbfrtwQdaxM7wlqBvY=;
 b=yqJhgiPi1dBgj54WKl1L/iWtM3CGrSfqQ1nqhpzBuca9oO0CJI4R7Ik2noxXmIj/EB
 9gPury+qNfJT/uqla/JQsTShz02LCpi0+4BucU3gX2bYgn4xZaYx0+Ba5GEM+sA/4AuJ
 m2FHcm4cFZSss08tWHBZzMUoHAwh+Ye4xdNGU07aHshzfvv0IM1OzWuqSgAgF1Yz5Icm
 nkXgyTUaUsHCrivrt80kYQG/K9i0HIFIgavXgEmsHdu3XoEW8XDd5YQXlc4fu9PONrd8
 16M0F81mi0aMHSmh6mczVM5X7aqq+Sju30/omu08tW3RUWLYhQkC4VQUzu3b9er2I62E
 kmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9/5aSuOnLbh8GxGcND8KueDA6BbfrtwQdaxM7wlqBvY=;
 b=lec4UmQmrj+eSh8fwaDiIOsSZjlXnFhzp7LDyzXeUuZ07DvQLvAI99TJODd/9DQHha
 SUzM42CEU2tjMmJ+vpzQBwdenGuTeOjxOi8RhRCK0/yGCinz+tQo+E5rQD2ihehHIpQ/
 hMJmIAIQN6CBWphfICUdf6tBA67jDKPc8WCThVw4+ZZ+nqdcNGuyWu4SpJ84h5k12aDJ
 GcuVoWGnjdaj/r/Mgr8lTutF1uKTp+dhRanvirXbwCv+pVDCiwlOgthcrHEL2ORJXage
 hEOLaER+o2zgG+fATQVhfONqoBVHjWzcqdjbf4XGTz6W96uo4o7laNj59YSCD/XDKD0d
 0LVg==
X-Gm-Message-State: APjAAAWYUQ60cwf9lziOs9kRhrzYPUD7fmr99G69Did75W747XG5Z2dB
 ubp05V6uRljk/Wfdi4d+uPyofUG25fGFjz6JAM3yUGy1
X-Google-Smtp-Source: APXvYqyakrBmSvGBUTH02Z6YVQ30POGjosExZ/J8rznjy7IRp+xsAuUv8In4AlH41CGP75yrtJFiHu0XMqgdgndJlB8=
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr3965555wmh.84.1582882024203; 
 Fri, 28 Feb 2020 01:27:04 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <CAPj87rM76W9y_76WUHR35NS3V4_-RFi9ZM3GA=aED3dD3hWYkg@mail.gmail.com>
 <CAPM=9txN-RKGwinzsSPrmT_xFjS2J_XUhXVsRQ2pSSe529wpEA@mail.gmail.com>
In-Reply-To: <CAPM=9txN-RKGwinzsSPrmT_xFjS2J_XUhXVsRQ2pSSe529wpEA@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 28 Feb 2020 09:26:23 +0000
Message-ID: <CAPj87rMc9zE01uWHhLHwCTkK+15UBfi0z-cJy2pFhtaJh3qB6A@mail.gmail.com>
Subject: Re: [Intel-gfx] gitlab.fd.o financial situation and impact on services
To: Dave Airlie <airlied@gmail.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 28 Feb 2020 at 08:48, Dave Airlie <airlied@gmail.com> wrote:
> On Fri, 28 Feb 2020 at 18:18, Daniel Stone <daniel@fooishbar.org> wrote:
> > The last I looked, Google GCP / Amazon AWS / Azure were all pretty
> > comparable in terms of what you get and what you pay for them.
> > Obviously providers like Packet and Digital Ocean who offer bare-metal
> > services are cheaper, but then you need to find someone who is going
> > to properly administer the various machines, install decent
> > monitoring, make sure that more storage is provisioned when we need
> > more storage (which is basically all the time), make sure that the
> > hardware is maintained in decent shape (pretty sure one of the fd.o
> > machines has had a drive in imminent-failure state for the last few
> > months), etc.
> >
> > Given the size of our service, that's a much better plan (IMO) than
> > relying on someone who a) isn't an admin by trade, b) has a million
> > other things to do, and c) hasn't wanted to do it for the past several
> > years. But as long as that's the resources we have, then we're paying
> > the cloud tradeoff, where we pay more money in exchange for fewer
> > problems.
>
> Admin for gitlab and CI is a full time role anyways. The system is
> definitely not self sustaining without time being put in by you and
> anholt still. If we have $75k to burn on credits, and it was diverted
> to just pay an admin to admin the real hw + gitlab/CI would that not
> be a better use of the money? I didn't know if we can afford $75k for
> an admin, but suddenly we can afford it for gitlab credits?

s/gitlab credits/GCP credits/

I took a quick look at HPE, which we previously used for bare metal,
and it looks like we'd be spending $25-50k (depending on how much
storage you want to provision, how much room you want to leave to
provision more storage later, how much you care about backups) to run
a similar level of service so that'd put a bit of a dint in your
year-one budget.

The bare-metal hosting providers also add up to more expensive than
you might think, again especially if you want either redundancy or
just backups.

> > Yes, we could federate everything back out so everyone runs their own
> > builds and executes those. Tinderbox did something really similar to
> > that IIRC; not sure if Buildbot does as well. Probably rules out
> > pre-merge testing, mind.
>
> Why? does gitlab not support the model? having builds done in parallel
> on runners closer to the test runners seems like it should be a thing.
> I guess artifact transfer would cost less then as a result.

It does support the model but if every single build executor is also
compiling Mesa from scratch locally, how long do you think that's
going to take?

> > Again, if you want everything to be centrally
> > designed/approved/monitored/controlled, that's a fine enough idea, and
> > I'd be happy to support whoever it was who was doing that for all of
> > fd.o.
>
> I don't think we have any choice but to have someone centrally
> controlling it, You can't have a system in place that lets CI users
> burn largs sums of money without authorisation, and that is what we
> have now.

OK, not sure who it is who's going to be approving every update to
every .gitlab-ci.yml in the repository, or maybe we just have zero
shared runners and anyone who wants to do builds can BYO.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
