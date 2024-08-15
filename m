Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE1FC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 10:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFB010E0D7;
	Thu, 15 Aug 2024 10:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWXz1qEY";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DEA10E2C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 05:12:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3009F61D58;
 Thu, 15 Aug 2024 05:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F46C4AF0A;
 Thu, 15 Aug 2024 05:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723698764;
 bh=Nhs4LP/qOha9uBz5IKXTxoESOcgX8PVTbALyHYj31N8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WWXz1qEYUgsDIfcOzUses/8TFIE43Yb2x3KTlsB2rBaVb8fSCEfa++IoVb0cPIzv/
 pyZsdjwt//xvZvWX1hrjPe946GN4FuA0qEbGhRPo3iaBe0eSqaO8cQ9MK+3Iq3AGDW
 +QRkcGBSSGD8qGTik94R6a5kOw6JQHSl+Pt8X1Hg=
Date: Thu, 15 Aug 2024 07:12:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024081527-step-resort-2984@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
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

On Wed, Aug 14, 2024 at 04:39:29PM -0400, Felix Kuehling wrote:
> On 2024-08-12 11:00, Greg KH wrote:
> > Hi all,
> > 
> > As some of you have noticed, there's a TON of failure messages being
> > sent out for AMD gpu driver commits that are tagged for stable
> > backports.  In short, you all are doing something really wrong with how
> > you are tagging these.
> Hi Greg,
> 
> I got notifications about one KFD patch failing to apply on six branches
> (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you already
> applied this patch on two branches back in May. The emails had a suspicious
> looking date in the header (Sep 17, 2001). I wonder if there was some date
> glitch that caused a whole bunch of patches to be re-sent to stable somehow:
> 
>    ------------------ original commit in Linus's tree
>    ------------------ From 24e82654e98e96cece5d8b919c522054456eeec6 Mon
>    Sep 17 00:00:00 2001 From: Alex Deucher
>    <alexander.deucher@amd.com>Date: Sun, 14 Apr 2024 13:06:39 -0400

That's the real date, ignore the 2001 thing, that's from git.


>    Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page
>    with large pages ...
> 
> On 6.1 and 6.6, the patch was already applied by you in May:
> 
>    $ git log --pretty=fuller stable/linux-6.6.y --grep "drm/amdkfd: don't allow mapping the MMIO HDP page with large pages"
>    commit 4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724
>    Author:     Alex Deucher <alexander.deucher@amd.com>
>    AuthorDate: Sun Apr 14 13:06:39 2024 -0400
>    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>    CommitDate: Fri May 17 12:02:34 2024 +0200
> 
>         drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
>    ...
> 
> On 6.10 it was already upstream.

Then why did we have it in the tree again with different commit ids?
That's the issue here, and the major confusion as there is no way for us
to determine if this is a commit that has been in the tree already or if
it's just a normal failure.

> On 5.4-5.15 it doesn't apply because of conflicts. I can resolve those and
> send the fixed patches out for you.

If it is needed in those branches, please do so.

thanks,

greg k-h
