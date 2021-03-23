Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F552C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEC7619A0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 11:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEC7619A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888CC6E8AD;
	Tue, 23 Mar 2021 11:28:25 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1FF6E0FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 11:28:24 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 t5-20020a1c77050000b029010e62cea9deso10634352wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=D+NyPjsJ+1GW7mDMp5MrVh/C5QY0YA2fly1lgVcTiAk=;
 b=MxJ2KV2cgA5nNI+zvJlpHQd9qdF7OeZ/97M/ZIH7+QuKjpxqgEfvZzGEWdrOBsuxV4
 c1qoZ7ouegY596ymeKbbrAIw3ir2EWvKrq7bvyq4DhBHQwjQW62mEV4wsufiTa+QdHZT
 MkH7/RFpIvdW/rrAArbN5EGAftbWn7qYsza7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=D+NyPjsJ+1GW7mDMp5MrVh/C5QY0YA2fly1lgVcTiAk=;
 b=PaZMuy4r8RiNcbkjeWT3N1k//Dy678tRZ6v7qhItEBn61PjAEJ2u4zjzw0pIi73Ht8
 z58nzcEM5ni0Hed23pHaWg0Y281EAJXO8D1vKx3r4fZt6GxN3CSAnHdc2fP4iSf0BlLq
 PS0haHqf2bYDwOoZHy7w9V90k3bVORjaMe0XYkTIHOQ7TRofPr2KbTEwnUIShAc95Hfo
 wrLEC4k/3u4PnjkSBJLhUQX/ZW8kuAbKsqlf89taBSn4mMVLNzgvjjS4/1faqBqp0vwp
 UJoGC6JMWZFVF2ELaAnPNExPZydJUPo8Q+jXP7wSjXx9AgYwLp8qNCAVK2pR6YV3X21O
 BXFQ==
X-Gm-Message-State: AOAM5311PFURaAorN3WscnLiZdNsWfZzy7+9KDMb9G/6v8pCe7wcPPbg
 10+HUjAK3eyxR+bOJDMBMOxq3Q==
X-Google-Smtp-Source: ABdhPJxKAjL5w3e8FQp+Ic49cpESgWVuGaVDBFqAJucj8k1zAMnKthjdGYROFZOmVrOFhaVxm8SE1g==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr2838646wmk.53.1616498902785; 
 Tue, 23 Mar 2021 04:28:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id c11sm24060039wrm.67.2021.03.23.04.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Mar 2021 04:28:21 -0700 (PDT)
Date: Tue, 23 Mar 2021 12:28:20 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFnQ1Lk6BTo8L7pr@phenom.ffwll.local>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
References: <YFT2LSR97rkkPyEP@phenom.ffwll.local>
 <1ae415c4-8e49-5183-b44d-bc92088657d5@gmail.com>
 <CAKMK7uEDhuvSwJj5CX8vHgLb+5zm=rdJPmXwb-VQWdrW6GwQZw@mail.gmail.com>
 <e6e9df3e-cd2b-d80f-205d-6ca1865819b2@gmail.com>
 <YFigZ5+H95c/GI/S@phenom.ffwll.local>
 <20210322140548.GN1719932@casper.infradead.org>
 <YFi+UROYbQERYEEr@dhcp22.suse.cz>
 <CAKMK7uGM6EJvzktrANyeeemRPoW7O0ka-ZyKi==wL1zt3yM=5w@mail.gmail.com>
 <c78457bb-d93a-ff84-1cce-0fb3fa9f0cec@gmail.com>
 <YFma+ZxncvfBd++o@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFma+ZxncvfBd++o@dhcp22.suse.cz>
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
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Chinner <dchinner@redhat.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 23, 2021 at 08:38:33AM +0100, Michal Hocko wrote:
> On Mon 22-03-21 20:34:25, Christian K=F6nig wrote:
> > Am 22.03.21 um 18:02 schrieb Daniel Vetter:
> > > On Mon, Mar 22, 2021 at 5:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > On Mon 22-03-21 14:05:48, Matthew Wilcox wrote:
> > > > > On Mon, Mar 22, 2021 at 02:49:27PM +0100, Daniel Vetter wrote:
> > > > > > On Sun, Mar 21, 2021 at 03:18:28PM +0100, Christian K=F6nig wro=
te:
> > > > > > > Am 20.03.21 um 14:17 schrieb Daniel Vetter:
> > > > > > > > On Sat, Mar 20, 2021 at 10:04 AM Christian K=F6nig
> > > > > > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > > > > > Am 19.03.21 um 20:06 schrieb Daniel Vetter:
> > > > > > > > > > On Fri, Mar 19, 2021 at 07:53:48PM +0100, Christian K=
=F6nig wrote:
> > > > > > > > > > > Am 19.03.21 um 18:52 schrieb Daniel Vetter:
> > > > > > > > > > > > On Fri, Mar 19, 2021 at 03:08:57PM +0100, Christian=
 K=F6nig wrote:
> > > > > > > > > > > > > Don't print a warning when we fail to allocate a =
page for swapping things out.
> > > > > > > > > > > > > =

> > > > > > > > > > > > > Also rely on memalloc_nofs_save/memalloc_nofs_res=
tore instead of GFP_NOFS.
> > > > > > > > > > > > Uh this part doesn't make sense. Especially since y=
ou only do it for the
> > > > > > > > > > > > debugfs file, not in general. Which means you've ju=
st completely broken
> > > > > > > > > > > > the shrinker.
> > > > > > > > > > > Are you sure? My impression is that GFP_NOFS should n=
ow work much more out
> > > > > > > > > > > of the box with the memalloc_nofs_save()/memalloc_nof=
s_restore().
> > > > > > > > > > Yeah, if you'd put it in the right place :-)
> > > > > > > > > > =

> > > > > > > > > > But also -mm folks are very clear that memalloc_no*() f=
amily is for dire
> > > > > > > > > > situation where there's really no other way out. For an=
ything where you
> > > > > > > > > > know what you're doing, you really should use explicit =
gfp flags.
> > > > > > > > > My impression is just the other way around. You should tr=
y to avoid the
> > > > > > > > > NOFS/NOIO flags and use the memalloc_no* approach instead.
> > > > > > > > Where did you get that idea?
> > > > > > > Well from the kernel comment on GFP_NOFS:
> > > > > > > =

> > > > > > >   * %GFP_NOFS will use direct reclaim but will not use any fi=
lesystem
> > > > > > > interfaces.
> > > > > > >   * Please try to avoid using this flag directly and instead =
use
> > > > > > >   * memalloc_nofs_{save,restore} to mark the whole scope which
> > > > > > > cannot/shouldn't
> > > > > > >   * recurse into the FS layer with a short explanation why. A=
ll allocation
> > > > > > >   * requests will inherit GFP_NOFS implicitly.
> > > > > > Huh that's interesting, since iirc Willy or Dave told me the op=
posite, and
> > > > > > the memalloc_no* stuff is for e.g. nfs calling into network lay=
er (needs
> > > > > > GFP_NOFS) or swap on top of a filesystems (even needs GFP_NOIO =
I think).
> > > > > > =

> > > > > > Adding them, maybe I got confused.
> > > > > My impression is that the scoped API is preferred these days.
> > > > > =

> > > > > https://www.kernel.org/doc/html/latest/core-api/gfp_mask-from-fs-=
io.html
> > > > > =

> > > > > I'd probably need to spend a few months learning the DRM subsyste=
m to
> > > > > have a more detailed opinion on whether passing GFP flags around =
explicitly
> > > > > or using the scope API is the better approach for your situation.
> > > > yes, in an ideal world we would have a clearly defined scope of the
> > > > reclaim recursion wrt FS/IO associated with it. I've got back to
> > > > https://lore.kernel.org/amd-gfx/20210319140857.2262-1-christian.koe=
nig@amd.com/
> > > > and there are two things standing out. Why does ttm_tt_debugfs_shri=
nk_show
> > > > really require NOFS semantic? And why does it play with
> > > > fs_reclaim_acquire?
> > > It's our shrinker. shrink_show simply triggers that specific shrinker
> > > asking it to shrink everything it can, which helps a lot with testing
> > > without having to drive the entire system against the OOM wall.
> =

> Yes I figured that much. But...
> =

> > > fs_reclaim_acquire is there to make sure lockdep understands that this
> > > is a shrinker and that it checks all the dependencies for us like if
> > > we'd be in real reclaim. There is some drop caches interfaces in proc
> > > iirc, but those drop everything, and they don't have the fs_reclaim
> > > annotations to teach lockdep about what we're doing.
> =

> ... I really do not follow this. You shouldn't really care whether this
> is a reclaim interface or not. Or maybe I just do not understand this...

We're heavily relying on lockdep and fs_reclaim to make sure we get it all
right. So any drop caches interface that isn't wrapped in fs_reclaim
context is kinda useless for testing. Plus ideally we want to only hit our
own paths, and not trash every other cache in the system. Speed matters in
CI.

> > To summarize the debugfs code is basically to test if that stuff really
> > works with GFP_NOFS.
> =

> What do you mean by testing GFP_NOFS. Do you mean to test that GFP_NOFS
> context is sufficiently powerful to reclaim enough objects due to some
> internal constrains?
> =

> > My only concern is that if I could rely on memalloc_no* being used we c=
ould
> > optimize this quite a bit further.
> =

> Yes you can use the scope API and you will be guaranteed that _any_
> allocation from the enclosed context will inherit GFP_NO* semantic.

I think this is where I don't get yet what Christian tries to do: We
really shouldn't do different tricks and calling contexts between direct
reclaim and kswapd reclaim. Otherwise very hard to track down bugs are
pretty much guaranteed. So whether we use explicit gfp flags or the
context apis, result is exactly the same.
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
