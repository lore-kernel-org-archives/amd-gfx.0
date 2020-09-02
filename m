Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C19C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956620767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T7LTvXOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E80C6E503;
	Wed,  2 Sep 2020 19:59:49 +0000 (UTC)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971CD6E4FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 19:59:47 +0000 (UTC)
Received: by mail-oo1-xc41.google.com with SMTP id y25so154795oog.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YuD82sKNacp8kiMKG8DhrxLE+yDvscONc/5BDPmWsvE=;
 b=T7LTvXOOxhzGQD5p/KrUNj47PRrZdIANmulyq4bDU2pkJeWxey26msMkjzTkE34fko
 HTUyELmWH01QUcJQlqqcoIfg40dyAEFh7ALu1RZuJMDujawqgIXfWkjrJIpx55mUfD41
 ImALVxaWabXgpnC7HAsdoSAvDGF2yArafzNWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YuD82sKNacp8kiMKG8DhrxLE+yDvscONc/5BDPmWsvE=;
 b=nvFDyqiRs/+tQda8x6hmRbKCiSn9pFC18iGtJ3pJmstpC+85yll/tGSr7ooKgEOO9h
 H8ei49Seu1ZktIp7kVZly/qV2+8PFbuyW/uqPEQgZ1EPDAwD6ynPg+OIyFFVf14nEI5L
 qKeQnjploLrtY5Xgk5Ezumm5GFo/dBjLQmEDwCww4HvmSBvjwUUiKs1O94Pxt4Ro+3nx
 FfSHNlqseauUGJRfGujTPzo+7nAlb2Joy2JdseFGd0tRgILERzAlutA/75S6BN+nj0UI
 4nem7lVKeXvdiXUJMAdcKfQITR2mHA5oHFVT7TNR+xD93wyIRPqDzOwBln6pjoDVLVsR
 z5dg==
X-Gm-Message-State: AOAM532foLQvGvvVB2FmQkCxQLJO72opcDajLQfpp2tGvMUp7Ui0pvuh
 d5jo9ijkZ1zvi95XJh97A51viWkhaU57NzY+sZejRA==
X-Google-Smtp-Source: ABdhPJzh5CRsojCYCUfjrwxuqSghrksXxkp77fC/0LxMhQF9Ifw1wd4PT4q0KYqKV2A7+glhk008iKbCIWg1j2Zis1s=
X-Received: by 2002:a4a:e98e:: with SMTP id s14mr6713378ood.28.1599076786830; 
 Wed, 02 Sep 2020 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200902010645.26943-1-luben.tuikov@amd.com>
 <BDD53312-3A34-4761-A7C3-6FDFE66A6C1F@amd.com>
 <e6916b3b-60cd-e223-4f87-478aab3b2468@amd.com>
 <62D0EAA9-E3AD-4FA7-AC24-9F5F9C594EB2@amd.com>
 <0f336bb9-5d78-30ed-d217-c5905d1dc08a@amd.com>
 <CAPj87rMRemGSZGoPV-BYrAZCK26aB-rFsKL6hVPRsha_850SXQ@mail.gmail.com>
 <20a86ddb-df88-225d-a33d-7feec82a46c2@amd.com>
 <CAPj87rMKNZfP1=kfsHPbRaJtHMAEKY+87p6uTAt=Hh76FwZVcw@mail.gmail.com>
 <fc9b026c-e7d8-3cf6-92e8-7ef0c389e36c@amd.com>
 <CADnq5_PFuhe87tDuB7TMWOrYzo0O==UYJfqyauXK6Mmd7tFVpg@mail.gmail.com>
 <CAKMK7uEoUpMZRG9ey-us_CPWm+wr1hYRJJOT35=vvdRQYBh+ng@mail.gmail.com>
In-Reply-To: <CAKMK7uEoUpMZRG9ey-us_CPWm+wr1hYRJJOT35=vvdRQYBh+ng@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 2 Sep 2020 21:59:35 +0200
Message-ID: <CAKMK7uF9VRE8yoZtf9DA2Pyzi0PmE0MNJAT57T_Z_PpB2GqTWg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use implicit kref infra
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 2, 2020 at 9:55 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Sep 2, 2020 at 9:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Sep 2, 2020 at 3:04 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> > >
> > > On 2020-09-02 11:51 a.m., Daniel Stone wrote:
> > > > Hi Luben,
> > > >
> > > > On Wed, 2 Sep 2020 at 16:16, Luben Tuikov <luben.tuikov@amd.com> wrote:
> > > >> Not sure how I can do this when someone doesn't want to read up on
> > > >> the kref infrastructure. Can you help?
> > > >>
> > > >> When someone starts off with "My understanding of ..." (as in the OP) you know you're
> > > >> in trouble and in for a rough times.
> > > >>
> > > >> Such is the nature of world-wide open-to-everyone mailing lists where
> > > >> anyone can put forth an argument, regardless of their level of understanding.
> > > >> The more obfuscated an argument, the more uncertainty.
> > > >>
> > > >> If one knows the kref infrastructure, it just clicks, no explanation
> > > >> necessary.
> > > >
> > > > Evidently there are more points of view than yours. Evidently your
> > > > method of persuasion is also not working, because this thread is now
> > > > getting quite long and not converging on your point of view (which you
> > > > are holding to be absolutely objectively correct).
> > > >
> > > > I think you need to re-evaluate the way in which you speak to people,
> > > > considering that it costs nothing to be polite and considerate, and
> > > > also takes effort to be rude and dismissive.
> > >
> > > Not sure how to help this:
> > >
> > > > My understanding of the drm core code is like something below.
> > > > struct B {
> > > >       strcut A
> > > > }
> > > > we initialize A firstly and initialize B in the end. But destroy B firstly and destory A in the end.
> > >
> >
> > Luben, please tone it down a bit.  You are coming across very harshly.
> > You do make a good point though.  What is the point of having the drm
> > release callback if it's ostensibly useless?  We should either use it
> > as intended to release the structures allocated by the driver or the
> > drm core should handle it all.  With the managed resources there is an
> > incongruity between allocation and freeing which leads to confusion.
> > Even with the proposed updated documentation, it's not clear to me who
> > should use the managed resources or not.  My understanding was that it
> > was optional for drivers that wanted it.
>
> In an ideal world this would all be perfectly clean. In reality we
> have huge existing drivers which, if at all feasible, can only be
> converted over step by step.
>
> So with that there's a few ways we can make this happen:
> - drmm resources are cleaned up before ->release is called. This means
> doing auto-cleanup of the final steps like cleanup up drm_device
> resources is gated on all drivers first being converted completely
> over to drmm, which is never going to happen. And it's holding up
> removing all the fairly simple cleanup code from small driver, which
> is where managed resources (whether drmm or devm) have the most
> benefit, often they completely eliminate the need for any explicit
> teardown code.
> - start in the middle. That just oopses because the unwind order isn't
> the inverse of the setup order anymore, and generally that's required.
> - start at the end. Unfortunately this means that the drm_device
> cannot be freed in the driver's ->release callback, therefore for
> transition purposes I had to sprinkle drmm_add_final_kfree all over
> the place. But if you use devm_drm_dev_alloc (like the updated docs
> recommend) that's not needed anymore, so really not an eyesore for
> driver developers.
>
> Yes there's mildly tricky code in the core as a result, but given that
> you guys wont volunteer to fix up the entire subsystem either we just
> have to live with that I think. Also, the commit adding the
> drm_managed stuff does explain these implementation details and the
> reasons why.

Also note that tons of stuff in drm doesn't yet provide drmm_
versions, teardown-less drivers really only works for really simple
ones. So completely getting rid of the ->release callback will also
need lots of core work, like the currently in-flight series to add
more drmm_ helpers for kms objects:

https://lore.kernel.org/dri-devel/20200827160545.1146-1-p.zabel@pengutronix.de/

Help obviously very much welcome.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
