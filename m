Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BACC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 14:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E778E61990
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 14:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E778E61990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8725E6E489;
	Mon, 22 Mar 2021 14:22:07 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0B86E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 14:22:07 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id x13so17129367wrs.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=P7kM0ec17kAxJ7OeBgoamSTjvACVf0yQ0nbW97EJ9+w=;
 b=Ark5NE1ZMAG2EM3A8upZSyFaUgGhOogaj80j93mQsKDyA0T4O5gv3pwCRzfY8MWJYq
 hUWcr1zL27mqm5omXJeGZQvV/Z7U14LOKA7YpJAewrhl3LhRRqF6hUDbvvVYtAkCNjll
 Eb4fn/xWs2hYgCJEwfnXI3vWkykjd4wlY9VS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=P7kM0ec17kAxJ7OeBgoamSTjvACVf0yQ0nbW97EJ9+w=;
 b=L3jtfnoV7KUPekBSK3BTtgyaQxmwZzLKgb8Xbqy4hts5++TctKCteGOKZxmJlBO8P6
 8vC1GZjxz26J0cyK69QW3t0rM+RFb5AHCakKoClgUlg3JUewNWMOjObUUPNpPyhwqBF5
 oGUv8Y7D7dQGDY7IPFWZvxAlvHCCkgKyYmESHLPqImOjmU5ugseFyr5pFTE6qpxWfzig
 /n7Sxnk4vxlyjqPXz6U6m93bwic7hHV5QjdcsSWwZCZcFuW2hFNxXHCu6HZLxmMbRiUi
 jUiRFSCERz7X27cUi8d/B4n8I5wRnL6re34bsXOLRTe81iO2zgbjcYykltl0PE7EBD5k
 J/3w==
X-Gm-Message-State: AOAM533K6ZHER9fsBk42e5mmfzPlsw0clM9os2aCuuZ2/3PKV+W90gmQ
 leUO/ADf5kJ7jYsSo8N8jWmiN6Z4lY3fmlbQ
X-Google-Smtp-Source: ABdhPJzGaDnzwHoePMLQPQyGI6MVZ+JS6XIpmJfbcwANUFMYpQEVnC7/ci8tI2vAgrEgXYf/LNSMAw==
X-Received: by 2002:adf:ba87:: with SMTP id p7mr18868962wrg.298.1616422925721; 
 Mon, 22 Mar 2021 07:22:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m15sm18866008wrp.96.2021.03.22.07.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 07:22:04 -0700 (PDT)
Date: Mon, 22 Mar 2021 15:22:02 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFioChrLPkjMBTP3@phenom.ffwll.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>, mhocko@kernel.org
References: <20210319140857.2262-1-christian.koenig@amd.com>
 <YFTk1GSaUDI3wcWt@phenom.ffwll.local>
 <2831bfcc-140e-dade-1f50-a6431e495e9d@gmail.com>
 <YFT2LSR97rkkPyEP@phenom.ffwll.local>
 <1ae415c4-8e49-5183-b44d-bc92088657d5@gmail.com>
 <CAKMK7uEDhuvSwJj5CX8vHgLb+5zm=rdJPmXwb-VQWdrW6GwQZw@mail.gmail.com>
 <e6e9df3e-cd2b-d80f-205d-6ca1865819b2@gmail.com>
 <YFigZ5+H95c/GI/S@phenom.ffwll.local>
 <20210322140548.GN1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322140548.GN1719932@casper.infradead.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, mhocko@kernel.org,
 Linux MM <linux-mm@kvack.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 22, 2021 at 02:05:48PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 02:49:27PM +0100, Daniel Vetter wrote:
> > On Sun, Mar 21, 2021 at 03:18:28PM +0100, Christian K=F6nig wrote:
> > > Am 20.03.21 um 14:17 schrieb Daniel Vetter:
> > > > On Sat, Mar 20, 2021 at 10:04 AM Christian K=F6nig
> > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > Am 19.03.21 um 20:06 schrieb Daniel Vetter:
> > > > > > On Fri, Mar 19, 2021 at 07:53:48PM +0100, Christian K=F6nig wro=
te:
> > > > > > > Am 19.03.21 um 18:52 schrieb Daniel Vetter:
> > > > > > > > On Fri, Mar 19, 2021 at 03:08:57PM +0100, Christian K=F6nig=
 wrote:
> > > > > > > > > Don't print a warning when we fail to allocate a page for=
 swapping things out.
> > > > > > > > > =

> > > > > > > > > Also rely on memalloc_nofs_save/memalloc_nofs_restore ins=
tead of GFP_NOFS.
> > > > > > > > Uh this part doesn't make sense. Especially since you only =
do it for the
> > > > > > > > debugfs file, not in general. Which means you've just compl=
etely broken
> > > > > > > > the shrinker.
> > > > > > > Are you sure? My impression is that GFP_NOFS should now work =
much more out
> > > > > > > of the box with the memalloc_nofs_save()/memalloc_nofs_restor=
e().
> > > > > > Yeah, if you'd put it in the right place :-)
> > > > > > =

> > > > > > But also -mm folks are very clear that memalloc_no*() family is=
 for dire
> > > > > > situation where there's really no other way out. For anything w=
here you
> > > > > > know what you're doing, you really should use explicit gfp flag=
s.
> > > > > My impression is just the other way around. You should try to avo=
id the
> > > > > NOFS/NOIO flags and use the memalloc_no* approach instead.
> > > > Where did you get that idea?
> > > =

> > > Well from the kernel comment on GFP_NOFS:
> > > =

> > > =A0* %GFP_NOFS will use direct reclaim but will not use any filesystem
> > > interfaces.
> > > =A0* Please try to avoid using this flag directly and instead use
> > > =A0* memalloc_nofs_{save,restore} to mark the whole scope which
> > > cannot/shouldn't
> > > =A0* recurse into the FS layer with a short explanation why. All allo=
cation
> > > =A0* requests will inherit GFP_NOFS implicitly.
> > =

> > Huh that's interesting, since iirc Willy or Dave told me the opposite, =
and
> > the memalloc_no* stuff is for e.g. nfs calling into network layer (needs
> > GFP_NOFS) or swap on top of a filesystems (even needs GFP_NOIO I think).
> > =

> > Adding them, maybe I got confused.
> =

> My impression is that the scoped API is preferred these days.
> =

> https://www.kernel.org/doc/html/latest/core-api/gfp_mask-from-fs-io.html
> =

> I'd probably need to spend a few months learning the DRM subsystem to
> have a more detailed opinion on whether passing GFP flags around explicit=
ly
> or using the scope API is the better approach for your situation.

Atm it's a single allocation in the ttm shrinker that's already explicitly
using GFP_NOFS that we're talking about here.

The scoped api might make sense for gpu scheduler, where we really operate
under GFP_NOWAIT for somewhat awkward reasons. But also I thought at least
for GFP_NOIO you generally need a mempool and think about how you
guarantee forward progress anyway. Is that also a bit outdated thinking,
and nowadays we could operate under the assumption that this Just Works?
Given that GFP_NOFS seems to fall over already for us I'm not super sure
about that ...

> I usually defer to Michal on these kinds of questions.
> =

> > > > The kernel is full of explicit gfp_t flag
> > > > passing to make this as explicit as possible. The memalloc_no* stuff
> > > > is just for when you go through entire subsystems and really can't
> > > > wire it through. I can't find the discussion anymore, but that was =
the
> > > > advice I got from mm/fs people.
> > > > =

> > > > One reason is that generally a small GFP_KERNEL allocation never
> > > > fails. But it absolutely can fail if it's in a memalloc_no* section,
> > > > and these kind of non-obvious non-local effects are a real pain in
> > > > testing and review. Hence explicit gfp_flag passing as much as
> > > > possible.
> =

> I agree with this; it's definitely a problem with the scope API.  I wanted
> to extend it to include GFP_NOWAIT, but if you do that, your chances of
> memory allocation failure go way up, so you really want to set __GFP_NOWA=
RN
> too, but now you need to audit all the places that you're calling to be
> sure they really handle errors correctly.
> =

> So I think I'm giving up on that patch set.

Yeah the auditing is what scares me, and why at least personally I prefer
explicit gfp flags. It's much easier to debug a lockdep splat involving
fs_reclaim than memory allocation failures leading to very strange bugs
because we're not handling the allocation failure properly (or maybe not
even at all).
-Daniel

> =

> > > > > > > > If this is just to paper over the seq_printf doing the wron=
g allocations,
> > > > > > > > then just move that out from under the fs_reclaim_acquire/r=
elease part.
> > > > > > > No, that wasn't the problem.
> > > > > > > =

> > > > > > > We have just seen to many failures to allocate pages for swap=
out and I think
> > > > > > > that would improve this because in a lot of cases we can then=
 immediately
> > > > > > > swap things out instead of having to rely on upper layers.
> > > > > > Yeah, you broke it. Now the real shrinker is running with GFP_K=
ERNEL,
> > > > > > because your memalloc_no is only around the debugfs function. A=
nd ofc it's
> > > > > > much easier to allocate with GFP_KERNEL, right until you deadlo=
ck :-)
> > > > > The problem here is that for example kswapd calls the shrinker wi=
thout
> > > > > holding a FS lock as far as I can see.
> > > > > =

> > > > > And it is rather sad that we can't optimize this case directly.
> > > > I'm still not clear what you want to optimize? You can check for "is
> > > > this kswapd" in pf flags, but that sounds very hairy and fragile.
> > > =

> > > Well we only need the NOFS flag when the shrinker callback really com=
es from
> > > a memory shortage in the FS subsystem, and that is rather unlikely.
> > > =

> > > When we would allow all other cases to be able to directly IO the fre=
ed up
> > > pages to swap it would certainly help.
> > =

> > tbh I'm not sure. i915-gem code has played tricks with special casing t=
he
> > kswapd path, and they do kinda scare me at least. I'm not sure whether
> > there's not some hidden dependencies there that would make this a bad
> > idea. Like afaik direct reclaim can sometimes stall for kswapd to catch=
 up
> > a bit, or at least did in the past (I think, really not much clue about
> > this)
> > =

> > The other thing is that the fs_reclaim_acquire/release annotation really
> > only works well if you use it outside of the direct reclaim path too.
> > Otherwise it's not much better than just lots of testing. That pretty m=
uch
> > means you have to annotate the kswapd path.
> > -Daniel
> > =

> > =

> > =

> > > =

> > > Christian.
> > > =

> > > > -Daniel
> > > > =

> > > > > Anyway you are right if some caller doesn't use the memalloc_no*()
> > > > > approach we are busted.
> > > > > =

> > > > > Going to change the patch to only not warn for the moment.
> > > > > =

> > > > > Regards,
> > > > > Christian.
> > > > > =

> > > > > > Shrinking is hard, there's no easy way out here.
> > > > > > =

> > > > > > Cheers, Daniel
> > > > > > =

> > > > > > > Regards,
> > > > > > > Christian.
> > > > > > > =

> > > > > > > =

> > > > > > > > __GFP_NOWARN should be there indeed I think.
> > > > > > > > -Daniel
> > > > > > > > =

> > > > > > > > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.co=
m>
> > > > > > > > > ---
> > > > > > > > >     drivers/gpu/drm/ttm/ttm_tt.c | 5 ++++-
> > > > > > > > >     1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > > > > =

> > > > > > > > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/d=
rm/ttm/ttm_tt.c
> > > > > > > > > index 2f0833c98d2c..86fa3e82dacc 100644
> > > > > > > > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > > > > > > > @@ -369,7 +369,7 @@ static unsigned long ttm_tt_shrinker_=
scan(struct shrinker *shrink,
> > > > > > > > >             };
> > > > > > > > >             int ret;
> > > > > > > > > -  ret =3D ttm_bo_swapout(&ctx, GFP_NOFS);
> > > > > > > > > +  ret =3D ttm_bo_swapout(&ctx, GFP_KERNEL | __GFP_NOWARN=
);
> > > > > > > > >             return ret < 0 ? SHRINK_EMPTY : ret;
> > > > > > > > >     }
> > > > > > > > > @@ -389,10 +389,13 @@ static unsigned long ttm_tt_shrinke=
r_count(struct shrinker *shrink,
> > > > > > > > >     static int ttm_tt_debugfs_shrink_show(struct seq_file=
 *m, void *data)
> > > > > > > > >     {
> > > > > > > > >             struct shrink_control sc =3D { .gfp_mask =3D =
GFP_KERNEL };
> > > > > > > > > +  unsigned int flags;
> > > > > > > > >             fs_reclaim_acquire(GFP_KERNEL);
> > > > > > > > > +  flags =3D memalloc_nofs_save();
> > > > > > > > >             seq_printf(m, "%lu/%lu\n", ttm_tt_shrinker_co=
unt(&mm_shrinker, &sc),
> > > > > > > > >                        ttm_tt_shrinker_scan(&mm_shrinker,=
 &sc));
> > > > > > > > > +  memalloc_nofs_restore(flags);
> > > > > > > > >             fs_reclaim_release(GFP_KERNEL);
> > > > > > > > >             return 0;
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > > =

> > > > > > > > > _______________________________________________
> > > > > > > > > dri-devel mailing list
> > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > =

> > > =

> > =

> > -- =

> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
