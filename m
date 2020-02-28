Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2C8C3F2D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C582469F
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AmODh+jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C582469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489686EEB6;
	Fri, 28 Feb 2020 09:48:05 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE286EEB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:48:03 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id j16so2047653otl.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X4r4zSKBHI0cJ08ddMSukz7csjMHwcKdfw/isq8n7P0=;
 b=AmODh+jYpbD8RC8Uwhjc/WS1AT4K9hhNaoTg0U5o1qLzfDPSshFI+JUbsfrepjS2YY
 9gl6JRMZJB9/f2rZM2v/pI15lTO0jcsPvGnnpXynkmKaCbmZDvNl9ZQo4c+M1q6744QY
 0WL+Rm+HfjJmby1N1v39N7a+MTEeYJAnNgdJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X4r4zSKBHI0cJ08ddMSukz7csjMHwcKdfw/isq8n7P0=;
 b=VekyrBxOaxej7fQHbmILF6QQKmkbkyRVHe7r8YNa+oo2rb/XOmyCFKhUnqMHaAsYI4
 0EXBb2HdzZoHvHVa00/OYhaTFS9w7YV8b+BRNd3nn5CFlzNxvAl05KDqRtqVCxs46e+6
 f/DKAj+vCgGI/fK48nX+SHTnsNMFH5LzIZiRjZ+8llh8i+nnG2VePNQ7Ygeid0tWfHaw
 hZ69KDADCN8CWeeT082PRp2bF9FexivjejvIzgP9+uwNa3qHa3v5F9R5Xgx31ABQ6jqm
 4cKh3PlF3GAGQPEAWVCfLnjYNBRN0KWMqKt8/Kucx+srUZnwPrtjJaxvvrK5z2BMg6DC
 sTlw==
X-Gm-Message-State: APjAAAUsTpgeNmkWBK/PjaueItt3K0M1ptVNDfYEcyyC1N4KU9B+PksN
 pBkZYjL2w3vXjhMQ3eetrue650W46U3c3RpeZ3OjWg==
X-Google-Smtp-Source: APXvYqxAGPdLIguePuT3BWwg9sZlg2ujinfSISfCup60cla1bY4ruO5I45fs6yLaUDjHz0RAw+Dmc59BFTxje96NTso=
X-Received: by 2002:a05:6830:2015:: with SMTP id
 e21mr2516888otp.106.1582883282144; 
 Fri, 28 Feb 2020 01:48:02 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAPM=9txcGPvFdSzMtYZXyqLKnWyacSMuHdoXdV63M53fLFVFpw@mail.gmail.com>
 <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
In-Reply-To: <b398161ff7d0268454413058dc6c194cf93f5990.camel@collabora.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 28 Feb 2020 10:47:50 +0100
Message-ID: <CAKMK7uEnE0HaB2Hs0opw5LO9YEkbJAOp3h5dvESHKFLvnzgfhQ@mail.gmail.com>
Subject: Re: [Mesa-dev] [Intel-gfx] gitlab.fd.o financial situation and impact
 on services
To: Erik Faye-Lund <erik.faye-lund@collabora.com>
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
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 28, 2020 at 10:29 AM Erik Faye-Lund
<erik.faye-lund@collabora.com> wrote:
>
> On Fri, 2020-02-28 at 13:37 +1000, Dave Airlie wrote:
> > On Fri, 28 Feb 2020 at 07:27, Daniel Vetter <daniel.vetter@ffwll.ch>
> > wrote:
> > > Hi all,
> > >
> > > You might have read the short take in the X.org board meeting
> > > minutes
> > > already, here's the long version.
> > >
> > > The good news: gitlab.fd.o has become very popular with our
> > > communities, and is used extensively. This especially includes all
> > > the
> > > CI integration. Modern development process and tooling, yay!
> > >
> > > The bad news: The cost in growth has also been tremendous, and it's
> > > breaking our bank account. With reasonable estimates for continued
> > > growth we're expecting hosting expenses totalling 75k USD this
> > > year,
> > > and 90k USD next year. With the current sponsors we've set up we
> > > can't
> > > sustain that. We estimate that hosting expenses for gitlab.fd.o
> > > without any of the CI features enabled would total 30k USD, which
> > > is
> > > within X.org's ability to support through various sponsorships,
> > > mostly
> > > through XDC.
> > >
> > > Note that X.org does no longer sponsor any CI runners themselves,
> > > we've stopped that. The huge additional expenses are all just in
> > > storing and serving build artifacts and images to outside CI
> > > runners
> > > sponsored by various companies. A related topic is that with the
> > > growth in fd.o it's becoming infeasible to maintain it all on
> > > volunteer admin time. X.org is therefore also looking for admin
> > > sponsorship, at least medium term.
> > >
> > > Assuming that we want cash flow reserves for one year of
> > > gitlab.fd.o
> > > (without CI support) and a trimmed XDC and assuming no sponsor
> > > payment
> > > meanwhile, we'd have to cut CI services somewhere between May and
> > > June
> > > this year. The board is of course working on acquiring sponsors,
> > > but
> > > filling a shortfall of this magnitude is neither easy nor quick
> > > work,
> > > and we therefore decided to give an early warning as soon as
> > > possible.
> > > Any help in finding sponsors for fd.o is very much appreciated.
> >
> > a) Ouch.
> >
> > b) we probably need to take a large step back here.
> >
>
> I kinda agree, but maybe the step doesn't have to be *too* large?
>
> I wonder if we could solve this by restructuring the project a bit. I'm
> talking purely from a Mesa point of view here, so it might not solve
> the full problem, but:
>
> 1. It feels silly that we need to test changes to e.g the i965 driver
> on dragonboards. We only have a big "do not run CI at all" escape-
> hatch.
>
> 2. A lot of us are working for a company that can probably pay for
> their own needs in terms of CI. Perhaps moving some costs "up front" to
> the company that needs it can make the future of CI for those who can't
> do this
>
> 3. I think we need a much more detailed break-down of the cost to make
> educated changes. For instance, how expensive is Docker image
> uploads/downloads (e.g intermediary artifacts) compared to build logs
> and final test-results? What kind of artifacts?

We have logs somewhere, but no one yet got around to analyzing that.
Which will be quite a bit of work to do since the cloud storage is
totally disconnected from the gitlab front-end, making the connection
to which project or CI job caused something is going to require
scripting. Volunteers definitely very much welcome I think.

> One suggestion would be to do something more similar to what the kernel
> does, and separate into different repos for different subsystems. This
> could allow us to have separate testing-pipelines for these repos,
> which would mean that for instance a change to RADV didn't trigger a
> full Panfrost test-run.

Uh as someone who lives the kernel multi-tree model daily, there's a
_lot_ of pain involved. I think much better to look at filtering out
CI targets for when nothing relevant happened. But that gets somewhat
tricky, since "nothing relevant" is always only relative to some
baseline, so bit of scripting and all involved to make sure you don't
run stuff too often or (probably worse) not often enough.
-Daniel

> This would probably require us to accept using a more branch-heavy
> work-flow. I don't personally think that would be a bad thing.
>
> But this is all kinda based on an assumption that running hardware-
> testing is the expensive part. I think that's quite possibly the case,
> but some more numbers would be helpful. I mean, it might turn out that
> just throwing up a Docker cache inside the organizations that host
> runners might be sufficient for all I know...
>
> We could also do stuff like reducing the amount of tests we run on each
> commit, and punt some testing to a per-weekend test-run or someting
> like that. We don't *need* to know about every problem up front, just
> the stuff that's about to be released, really. The other stuff is just
> nice to have. If it's too expensive, I would say drop it.
>
> I would really hope that we can consider approaches like this before we
> throw out the baby with the bathwater...
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
