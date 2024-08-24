Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF2C52D6F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Aug 2024 08:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CAF10E09C;
	Sat, 24 Aug 2024 08:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgf6GhvS";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC6910E0FD
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Aug 2024 05:23:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CF53BCE0B97;
 Sat, 24 Aug 2024 05:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A9FC32781;
 Sat, 24 Aug 2024 05:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1724477005;
 bh=XWD8ceHx6o4FDlXAJq7OaMkh5r83l0cP9C27pPRs/aQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qgf6GhvSjvWqUL1dLQWb8oS1OQrp9pEzdxsSFz+VrF740AYWbm5E1snnxNvXwCarP
 pj3Kx2ggxhrdSCkvAyFGu1VSEYRZYPKepqwJaUWNcHbm7w/PNSohSAZI2We4sxR4sv
 SyIg08qkoF64YLM7OLIIXZ5sh7VzjTCCFASXl0XM=
Date: Sat, 24 Aug 2024 13:23:21 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024082439-extending-dramatize-09ca@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
X-Mailman-Approved-At: Sat, 24 Aug 2024 08:28:43 +0000
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

On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> On Thu, Aug 15, 2024 at 1:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > On Wed, Aug 14, 2024 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> > > >
> > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > Hi all,
> > > > >
> > > > > As some of you have noticed, there's a TON of failure messages being
> > > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > > backports.  In short, you all are doing something really wrong with how
> > > > > you are tagging these.
> > > > Hi Greg,
> > > >
> > > > I got notifications about one KFD patch failing to apply on six branches
> > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > > > already applied this patch on two branches back in May. The emails had a
> > > > suspicious looking date in the header (Sep 17, 2001). I wonder if there
> > > > was some date glitch that caused a whole bunch of patches to be re-sent
> > > > to stable somehow:
> > >
> > > I think the crux of the problem is that sometimes patches go into
> > > -next with stable tags and they end getting taken into -fixes as well
> > > so after the merge window they end up getting picked up for stable
> > > again.  Going forward, if they land in -next, I'll cherry-pick -x the
> > > changes into -fixes so there is better traceability.
> >
> > Please do so, and also work to not have duplicate commits like this in
> > different branches.  Git can handle merges quite well, please use it.
> >
> > If this shows up again in the next -rc1 merge window without any
> > changes, I'll have to just blackhole all amd drm patches going forward
> > until you all tell me you have fixed your development process.
> 
> Just a heads up, you will see some of these when the 6.12 merge window
> due to what is currently in -next and the fixes that went into 6.11,
> but going forward we have updated our process and it should be better.

Can you give me a list of the git ids that I should be ignoring for
6.12-rc1?  Otherwise again, it's a huge waste of time on my side trying
to sift through them and figure out if the rejection is real or not...

thanks,

greg k-h
