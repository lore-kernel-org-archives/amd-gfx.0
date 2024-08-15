Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F077CC52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 10:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E40010E097;
	Thu, 15 Aug 2024 10:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAphGNRb";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA24510E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 05:11:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BD6EFCE1B50;
 Thu, 15 Aug 2024 05:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225C9C4AF0A;
 Thu, 15 Aug 2024 05:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723698668;
 bh=eXONwdpy7zzCQlj0SYE4BBEVndYt1VYhJpLfvIZUXhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hAphGNRb2iwEUXBFO3UO550HW1JykHH9HxbgUW10wf6+djZafQEelqjG5aCs06xd5
 NncjHXjJkKpSwgNKqXLGwWuM/RQZx9/tzNmEeDyKv9xDyWbhLM5sY9lUyXWhjKRgbp
 wnzIEU7ddY6eCRsSsOQI9ovGNCcW1VuFu151Nu6A=
Date: Thu, 15 Aug 2024 07:11:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081558-filtrate-stuffed-db5b@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
X-Mailman-Approved-At: Thu, 15 Aug 2024 10:05:59 +0000
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

On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> On Wed, Aug 14, 2024 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> >
> > On 2024-08-12 11:00, Greg KH wrote:
> > > Hi all,
> > >
> > > As some of you have noticed, there's a TON of failure messages being
> > > sent out for AMD gpu driver commits that are tagged for stable
> > > backports.  In short, you all are doing something really wrong with how
> > > you are tagging these.
> > Hi Greg,
> >
> > I got notifications about one KFD patch failing to apply on six branches
> > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > already applied this patch on two branches back in May. The emails had a
> > suspicious looking date in the header (Sep 17, 2001). I wonder if there
> > was some date glitch that caused a whole bunch of patches to be re-sent
> > to stable somehow:
> 
> I think the crux of the problem is that sometimes patches go into
> -next with stable tags and they end getting taken into -fixes as well
> so after the merge window they end up getting picked up for stable
> again.  Going forward, if they land in -next, I'll cherry-pick -x the
> changes into -fixes so there is better traceability.

Please do so, and also work to not have duplicate commits like this in
different branches.  Git can handle merges quite well, please use it.

If this shows up again in the next -rc1 merge window without any
changes, I'll have to just blackhole all amd drm patches going forward
until you all tell me you have fixed your development process.

thanks,

greg k-h
