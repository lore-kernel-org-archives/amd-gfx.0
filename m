Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D24AC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B573961979
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B573961979
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2D56EA8F;
	Fri, 19 Mar 2021 19:06:26 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E826EA8F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 19:06:25 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id o16so10173562wrn.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hA+rVKZCs7Za5H9fQ1BcSyG1KmVXAv6lS2Chdg3O6t0=;
 b=WOo4ehtM9HDAAlqBCSaWwwPMjyiLdZFMY86+WReaJ/lAYsrimi05zHFQKxV/VN1QQ9
 AK7ehT8qnS1IiXO+ceCRhUU8RUNgTc+RrRJR8L+/IuKCoTUz6IIBFWetXkhqWdWaK/ye
 hVY/XWswNB1uNZfpc/+vePP/hx4jo6O53tbvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hA+rVKZCs7Za5H9fQ1BcSyG1KmVXAv6lS2Chdg3O6t0=;
 b=ACp8PeqyZIqktXnJYlB3MwMq7qmzAwDNB6vni9TlQJzw6xbKi4GE0s5zegj7oiZRzW
 g6FqVAc8IXcr8up9polEdTwsNGe7n/wwEyu6QrH7sfQR2VuruS8VxAl6sc14Cncu2sEy
 GpsMhcHBEIE4WTYKw8QEyn/p+vVxY6vY9teyEcJGs7EE06hw1ORtM40xXIX+lWty2Wym
 xauDhNK3kwNP0stXvbhu+EywCQDEJ8FNDTlpaWHuFswIP/itbsXJzT0H+5n9sGhf5XrO
 1YM1dVmHcl6jT54bLUS+dT2eiX+4l/qZQ4hrde/kSNiLuGA8v8na/L1lhy14hYSReBvp
 YQQg==
X-Gm-Message-State: AOAM533H02JNXutEj21iDE0BeaTwG3pkyjvv9reyc6upMOkGLaUMWJtu
 5RdDZMn3t7K3aWtL+3vd/gUuKw==
X-Google-Smtp-Source: ABdhPJyMCOhZhnNKohwpb3XeW/df5Yoco6nEGoXJTGZEoiXt+YV3Wtr60O5AphQPDPLx6p4uJYbodA==
X-Received: by 2002:a5d:53c8:: with SMTP id a8mr5884007wrw.323.1616180783356; 
 Fri, 19 Mar 2021 12:06:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v14sm8925127wrd.48.2021.03.19.12.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 12:06:22 -0700 (PDT)
Date: Fri, 19 Mar 2021 20:06:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFT2LSR97rkkPyEP@phenom.ffwll.local>
References: <20210319140857.2262-1-christian.koenig@amd.com>
 <YFTk1GSaUDI3wcWt@phenom.ffwll.local>
 <2831bfcc-140e-dade-1f50-a6431e495e9d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2831bfcc-140e-dade-1f50-a6431e495e9d@gmail.com>
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
Cc: dri-devel@lists.freedesktop.org, Leo.Liu@amd.com,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 19, 2021 at 07:53:48PM +0100, Christian K=F6nig wrote:
> Am 19.03.21 um 18:52 schrieb Daniel Vetter:
> > On Fri, Mar 19, 2021 at 03:08:57PM +0100, Christian K=F6nig wrote:
> > > Don't print a warning when we fail to allocate a page for swapping th=
ings out.
> > > =

> > > Also rely on memalloc_nofs_save/memalloc_nofs_restore instead of GFP_=
NOFS.
> > Uh this part doesn't make sense. Especially since you only do it for the
> > debugfs file, not in general. Which means you've just completely broken
> > the shrinker.
> =

> Are you sure? My impression is that GFP_NOFS should now work much more out
> of the box with the memalloc_nofs_save()/memalloc_nofs_restore().

Yeah, if you'd put it in the right place :-)

But also -mm folks are very clear that memalloc_no*() family is for dire
situation where there's really no other way out. For anything where you
know what you're doing, you really should use explicit gfp flags.

> > If this is just to paper over the seq_printf doing the wrong allocation=
s,
> > then just move that out from under the fs_reclaim_acquire/release part.
> =

> No, that wasn't the problem.
> =

> We have just seen to many failures to allocate pages for swapout and I th=
ink
> that would improve this because in a lot of cases we can then immediately
> swap things out instead of having to rely on upper layers.

Yeah, you broke it. Now the real shrinker is running with GFP_KERNEL,
because your memalloc_no is only around the debugfs function. And ofc it's
much easier to allocate with GFP_KERNEL, right until you deadlock :-)

Shrinking is hard, there's no easy way out here.

Cheers, Daniel

> =

> Regards,
> Christian.
> =

> =

> > =

> > __GFP_NOWARN should be there indeed I think.
> > -Daniel
> > =

> > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > > ---
> > >   drivers/gpu/drm/ttm/ttm_tt.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_t=
t.c
> > > index 2f0833c98d2c..86fa3e82dacc 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > @@ -369,7 +369,7 @@ static unsigned long ttm_tt_shrinker_scan(struct =
shrinker *shrink,
> > >   	};
> > >   	int ret;
> > > -	ret =3D ttm_bo_swapout(&ctx, GFP_NOFS);
> > > +	ret =3D ttm_bo_swapout(&ctx, GFP_KERNEL | __GFP_NOWARN);
> > >   	return ret < 0 ? SHRINK_EMPTY : ret;
> > >   }
> > > @@ -389,10 +389,13 @@ static unsigned long ttm_tt_shrinker_count(stru=
ct shrinker *shrink,
> > >   static int ttm_tt_debugfs_shrink_show(struct seq_file *m, void *dat=
a)
> > >   {
> > >   	struct shrink_control sc =3D { .gfp_mask =3D GFP_KERNEL };
> > > +	unsigned int flags;
> > >   	fs_reclaim_acquire(GFP_KERNEL);
> > > +	flags =3D memalloc_nofs_save();
> > >   	seq_printf(m, "%lu/%lu\n", ttm_tt_shrinker_count(&mm_shrinker, &sc=
),
> > >   		   ttm_tt_shrinker_scan(&mm_shrinker, &sc));
> > > +	memalloc_nofs_restore(flags);
> > >   	fs_reclaim_release(GFP_KERNEL);
> > >   	return 0;
> > > -- =

> > > 2.25.1
> > > =

> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
