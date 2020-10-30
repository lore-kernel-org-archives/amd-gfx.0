Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5CFC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FE020679
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB4C6EHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FE020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D68B6EDDE;
	Fri, 30 Oct 2020 14:33:57 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591B36ECFA;
 Fri, 30 Oct 2020 08:23:38 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44D9F22228;
 Fri, 30 Oct 2020 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604046218;
 bh=MlYFaLQkpPG7LdEjrCa4Kc2PSIB4VTTYCHuO8KY0oB4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jB4C6EHwR0LUsfUVD51mQal9IEhqjuWgFYFwFh5ioAn7WNc/O5zTFCiapIbxuG85f
 Hj0rvHLDAjF3oTpfMuYERU0pNV78nJ1eMra1+RnGgQPzuAE31D8Gv+U7PfZV6+k0Rw
 aI2hakdmRUQ40NrYJIoOgcSwNwug2opsMG3H/VEs=
Date: Fri, 30 Oct 2020 09:24:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030082425.GA1619669@kroah.com>
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
 <20201030075716.GA6976@my--box>
 <20201030080316.GA1612206@kroah.com>
 <CACAkLupMiH9z4g7WLJ7t-N089_M6QGX6HkPQUATu4VCxDeFAKw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACAkLupMiH9z4g7WLJ7t-N089_M6QGX6HkPQUATu4VCxDeFAKw@mail.gmail.com>
X-Mailman-Approved-At: Fri, 30 Oct 2020 14:33:56 +0000
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
Cc: Deepak R Varma <mh12gx2825@gmail.com>, David Airlie <airlied@linux.ie>,
 daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, melissa.srw@gmail.com,
 Outreachy <outreachy-kernel@googlegroups.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 30, 2020 at 01:47:05PM +0530, Sumera Priyadarsini wrote:
> On Fri, 30 Oct, 2020, 1:32 PM Greg KH, <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Oct 30, 2020 at 01:27:16PM +0530, Deepak R Varma wrote:
> > > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with
> > debugfs_create_file_unsafe()
> > > > > function in place of the debugfs_create_file() function will make the
> > > > > file operation struct "reset" aware of the file's lifetime.
> > Additional
> > > > > details here:
> > https://lists.archive.carbon60.com/linux/kernel/2369498
> > > > >
> > > > > Issue reported by Coccinelle script:
> > > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > >
> > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > ---
> > > > > Please Note: This is a Outreachy project task patch.
> > > > >
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20
> > ++++++++++----------
> > > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > index 2d125b8b15ee..f076b1ba7319 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void
> > *data, u64 val)
> > > > >   return 0;
> > > > >  }
> > > > >
> > > > > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > -                 amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > +                  amdgpu_debugfs_ib_preempt, "%llu\n");
> > > >
> > > > Are you sure this is ok?  Do these devices need this additional
> > > > "protection"?  Do they have the problem that these macros were written
> > > > for?
> > > >
> > > > Same for the other patches you just submitted here, I think you need to
> > > > somehow "prove" that these changes are necessary, checkpatch isn't able
> > > > to determine this all the time.
> > >
> > > Hi Greg,
> > > Based on my understanding, the current function debugfs_create_file()
> > > adds an overhead of lifetime managing proxy for such fop structs. This
> > > should be applicable to these set of drivers as well. Hence I think this
> > > change will be useful.
> >
> > Why do these drivers need these changes?  Are these files dynamically
> > removed from the system at random times?
> >
> > There is a reason we didn't just do a global search/replace for this in
> > the kernel when the new functions were added, so I don't know why
> > checkpatch is now saying it must be done.
> >
> 
> Hi,
> 
> Sorry to jump in on the thread this way, but what exactly does a 'lifetime
> managing proxy' for file operations mean? I am trying to understand how
> DEFINE_DEBUGFS_ATTRIBUTE changes things wrt debug_ fs file operations but
> can't find many resources. :(

It means that the debugfs core can handle debugfs files being removed
from the system while they are still open when they were created by a
driver/module that is now unloaded from memory.

This is only an issue for drivers that manage devices that have unknown
lifespans (i.e. they can be yanked out of the system at any time, and
the memory for those debugfs files can be freed).

For the entire DRM/GPU subsystem, I strongly doubt this is the case.

> Please let me know if I should be asking this in a different mailing
> list/irc instead.
> 
> The change seems to be suggested by a coccinelle script.

I know, and I don't think that script knows the nuances behind this, as,
again, we would have just done a global search/replace for this when the
debugfs fixes went into the kernel.

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
