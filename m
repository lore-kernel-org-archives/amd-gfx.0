Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84479C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A5F619B6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A5F619B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48356E856;
	Tue, 23 Mar 2021 08:18:27 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C306E092;
 Tue, 23 Mar 2021 07:38:46 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1616485125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofPdbLGiOv4t4glajDJiQOBAXsq/hbLdis6yZwHlhBg=;
 b=mDTbOZXOo1pjW69S7Rhqr3O0HUnTFZK692Xd6c6Kkw2rAh+eVm2wN8ttIXEQPjhnY8C3Z+
 Jwhq2L5om4GpvS1ahdVWBo+B3gbxmA60cqA9za2A8zGl6y4RP2mz6VdXqVXoz5TELQhGCu
 lL8TRKSvQRXtlkiC4Ak6ssTSc5DeF4g=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 13332ACBF;
 Tue, 23 Mar 2021 07:38:45 +0000 (UTC)
Date: Tue, 23 Mar 2021 08:38:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFma+ZxncvfBd++o@dhcp22.suse.cz>
References: <2831bfcc-140e-dade-1f50-a6431e495e9d@gmail.com>
 <YFT2LSR97rkkPyEP@phenom.ffwll.local>
 <1ae415c4-8e49-5183-b44d-bc92088657d5@gmail.com>
 <CAKMK7uEDhuvSwJj5CX8vHgLb+5zm=rdJPmXwb-VQWdrW6GwQZw@mail.gmail.com>
 <e6e9df3e-cd2b-d80f-205d-6ca1865819b2@gmail.com>
 <YFigZ5+H95c/GI/S@phenom.ffwll.local>
 <20210322140548.GN1719932@casper.infradead.org>
 <YFi+UROYbQERYEEr@dhcp22.suse.cz>
 <CAKMK7uGM6EJvzktrANyeeemRPoW7O0ka-ZyKi==wL1zt3yM=5w@mail.gmail.com>
 <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
X-Mailman-Approved-At: Tue, 23 Mar 2021 08:18:23 +0000
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
Cc: Matthew Wilcox <willy@infradead.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon 22-03-21 20:34:25, Christian K=F6nig wrote:
> Am 22.03.21 um 18:02 schrieb Daniel Vetter:
> > On Mon, Mar 22, 2021 at 5:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > On Mon 22-03-21 14:05:48, Matthew Wilcox wrote:
> > > > On Mon, Mar 22, 2021 at 02:49:27PM +0100, Daniel Vetter wrote:
> > > > > On Sun, Mar 21, 2021 at 03:18:28PM +0100, Christian K=F6nig wrote:
> > > > > > Am 20.03.21 um 14:17 schrieb Daniel Vetter:
> > > > > > > On Sat, Mar 20, 2021 at 10:04 AM Christian K=F6nig
> > > > > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > > > > Am 19.03.21 um 20:06 schrieb Daniel Vetter:
> > > > > > > > > On Fri, Mar 19, 2021 at 07:53:48PM +0100, Christian K=F6n=
ig wrote:
> > > > > > > > > > Am 19.03.21 um 18:52 schrieb Daniel Vetter:
> > > > > > > > > > > On Fri, Mar 19, 2021 at 03:08:57PM +0100, Christian K=
=F6nig wrote:
> > > > > > > > > > > > Don't print a warning when we fail to allocate a pa=
ge for swapping things out.
> > > > > > > > > > > > =

> > > > > > > > > > > > Also rely on memalloc_nofs_save/memalloc_nofs_resto=
re instead of GFP_NOFS.
> > > > > > > > > > > Uh this part doesn't make sense. Especially since you=
 only do it for the
> > > > > > > > > > > debugfs file, not in general. Which means you've just=
 completely broken
> > > > > > > > > > > the shrinker.
> > > > > > > > > > Are you sure? My impression is that GFP_NOFS should now=
 work much more out
> > > > > > > > > > of the box with the memalloc_nofs_save()/memalloc_nofs_=
restore().
> > > > > > > > > Yeah, if you'd put it in the right place :-)
> > > > > > > > > =

> > > > > > > > > But also -mm folks are very clear that memalloc_no*() fam=
ily is for dire
> > > > > > > > > situation where there's really no other way out. For anyt=
hing where you
> > > > > > > > > know what you're doing, you really should use explicit gf=
p flags.
> > > > > > > > My impression is just the other way around. You should try =
to avoid the
> > > > > > > > NOFS/NOIO flags and use the memalloc_no* approach instead.
> > > > > > > Where did you get that idea?
> > > > > > Well from the kernel comment on GFP_NOFS:
> > > > > > =

> > > > > >   * %GFP_NOFS will use direct reclaim but will not use any file=
system
> > > > > > interfaces.
> > > > > >   * Please try to avoid using this flag directly and instead use
> > > > > >   * memalloc_nofs_{save,restore} to mark the whole scope which
> > > > > > cannot/shouldn't
> > > > > >   * recurse into the FS layer with a short explanation why. All=
 allocation
> > > > > >   * requests will inherit GFP_NOFS implicitly.
> > > > > Huh that's interesting, since iirc Willy or Dave told me the oppo=
site, and
> > > > > the memalloc_no* stuff is for e.g. nfs calling into network layer=
 (needs
> > > > > GFP_NOFS) or swap on top of a filesystems (even needs GFP_NOIO I =
think).
> > > > > =

> > > > > Adding them, maybe I got confused.
> > > > My impression is that the scoped API is preferred these days.
> > > > =

> > > > https://www.kernel.org/doc/html/latest/core-api/gfp_mask-from-fs-io=
.html
> > > > =

> > > > I'd probably need to spend a few months learning the DRM subsystem =
to
> > > > have a more detailed opinion on whether passing GFP flags around ex=
plicitly
> > > > or using the scope API is the better approach for your situation.
> > > yes, in an ideal world we would have a clearly defined scope of the
> > > reclaim recursion wrt FS/IO associated with it. I've got back to
> > > https://lore.kernel.org/amd-gfx/20210319140857.2262-1-christian.koeni=
g@amd.com/
> > > and there are two things standing out. Why does ttm_tt_debugfs_shrink=
_show
> > > really require NOFS semantic? And why does it play with
> > > fs_reclaim_acquire?
> > It's our shrinker. shrink_show simply triggers that specific shrinker
> > asking it to shrink everything it can, which helps a lot with testing
> > without having to drive the entire system against the OOM wall.

Yes I figured that much. But...

> > fs_reclaim_acquire is there to make sure lockdep understands that this
> > is a shrinker and that it checks all the dependencies for us like if
> > we'd be in real reclaim. There is some drop caches interfaces in proc
> > iirc, but those drop everything, and they don't have the fs_reclaim
> > annotations to teach lockdep about what we're doing.

... I really do not follow this. You shouldn't really care whether this
is a reclaim interface or not. Or maybe I just do not understand this...
 =

> To summarize the debugfs code is basically to test if that stuff really
> works with GFP_NOFS.

What do you mean by testing GFP_NOFS. Do you mean to test that GFP_NOFS
context is sufficiently powerful to reclaim enough objects due to some
internal constrains?

> My only concern is that if I could rely on memalloc_no* being used we cou=
ld
> optimize this quite a bit further.

Yes you can use the scope API and you will be guaranteed that _any_
allocation from the enclosed context will inherit GFP_NO* semantic.

-- =

Michal Hocko
SUSE Labs
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
