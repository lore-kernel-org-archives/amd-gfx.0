Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A64C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45050613B3
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45050613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A916EE9F;
	Fri, 11 Jun 2021 14:55:54 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBEF6EE9F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 14:55:53 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 f16-20020a05600c1550b02901b00c1be4abso8832445wmg.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VogJSzUKEexMGABDNfazwk46tI2gvNniSZkFlcB+wfc=;
 b=fjrwH/yB8odcqf6t9urm0xnWaWCOcXsE7p282DE9BQ5u5a5yDdkqMSg6Xt82y+kv+t
 +8KEYXzu+WdBFS1d9FVFAiMyR6yo+ilaBqFSSyRMxYi7EWJRXtYoyACmhdunyfWgo7JR
 9CBpYXZitaqRbEgiZFT/hVxw55twH1Xd0xoC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VogJSzUKEexMGABDNfazwk46tI2gvNniSZkFlcB+wfc=;
 b=FuwVtBWkSo5oCCNh1iJtJ4GIGGcrb/gxc7T2QKA09NtMdUOYjT4NFRfAb/aD0UIXDn
 vW9dh8gEYD/5FrrtzvAJ7CqK7iXV3Fdr0V9kBl6o7gBgiGba0lqqqkrwF3WJflXn1O2P
 a5VrvJCYvG+KwRmef/VK9uXlcztfj+uumdfzd/fvFLJ5FT02a2csScfiE5xN9Pqg/iEX
 QfaGkOQojtU8ibS/tfOOj9HadunATA3t+hwxbI/rB8B9xVIm6Mkwvpif6HclT4H637d/
 WYI/Pa0a6VyitR2928XETU04q0LtLvdxZC4rmpJYQxlxuQ/6b5KTywZ+iaon1oUo4NkU
 94Zw==
X-Gm-Message-State: AOAM530lqq9THUjP4tNrKtcKlBWeLk1MT3Tz51naZaPQ8eoPJzzWlKn0
 Sgr5KkLSSvFmzO1+MN4FzTVdxw==
X-Google-Smtp-Source: ABdhPJwZMeLyfVZ3r7Sgg3vZQ5olxvPiHwMHzxvGqJxnrOt9crVrYfYvz++st8pgd2SBDUKsvkb2Qw==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr20625206wmg.44.1623423352482; 
 Fri, 11 Jun 2021 07:55:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id t9sm7171092wmq.14.2021.06.11.07.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 07:55:52 -0700 (PDT)
Date: Fri, 11 Jun 2021 16:55:50 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
Message-ID: <YMN5do2/KUt85h5W@phenom.ffwll.local>
References: <20210611120301.10595-1-christian.koenig@amd.com>
 <YMN3nr1mTj09p8lT@phenom.ffwll.local>
 <2c91e4b4-e8c8-a9f5-420f-9cf0c1f9a67d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c91e4b4-e8c8-a9f5-420f-9cf0c1f9a67d@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 11, 2021 at 04:53:11PM +0200, Christian K=F6nig wrote:
> =

> =

> Am 11.06.21 um 16:47 schrieb Daniel Vetter:
> > On Fri, Jun 11, 2021 at 02:02:57PM +0200, Christian K=F6nig wrote:
> > > As the name implies if testing all fences is requested we
> > > should indeed test all fences and not skip the exclusive
> > > one because we see shared ones.
> > > =

> > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > Hm I thought we've had the rule that when both fences exist, then
> > collectively the shared ones must signale no earlier than the exclusive
> > one.
> > =

> > That's at least the contract we've implemented in dma_resv.h. But I've
> > also found a bunch of drivers who are a lot more yolo on this.
> > =

> > I think there's a solid case here to just always take all the fences if=
 we
> > ask for all the shared ones, but if we go that way then I'd say
> > - clear kerneldoc patch to really hammer this in (currently we're not g=
ood
> >    at all in this regard)
> > - going through drivers a bit to check for this (I have some of that do=
ne
> >    already in my earlier series, need to respin it and send it out)
> > =

> > But I'm kinda not seeing why this needs to be in this patch series here.
> =

> You mentioned that this is a problem in the last patch and if you ask me
> that's just a bug or at least very inconsistent.
> =

> See dma_resv_wait_timeout() always waits for all fences, including the
> exclusive one even if shared ones are present. But dma_resv_test_signaled=
()
> ignores the exclusive one if shared ones are present.

Hm the only one I thought I've mentioned is that dma_buf_poll doesn't use
dma_fence_get_rcu_safe where I think it should. Different problem. I think
this is one you spotted.

> The only other driver I could find trying to make use of this is nouveau =
and
> I already provided a fix for this as well.

i915 also does this, and I think I've found a few more.

> I just think that this is the more defensive approach to fix this and have
> at least the core functions consistent on the handling.

Oh fully agree, it's just current dma_resv docs aren't the greatest, and
hacking on semantics without updating the docs isn't great. Especially
when it's ad-hoc.
-Daniel

> =

> Christian.
> =

> > -Daniel
> > =

> > > ---
> > >   drivers/dma-buf/dma-resv.c | 33 ++++++++++++---------------------
> > >   1 file changed, 12 insertions(+), 21 deletions(-)
> > > =

> > > diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> > > index f26c71747d43..c66bfdde9454 100644
> > > --- a/drivers/dma-buf/dma-resv.c
> > > +++ b/drivers/dma-buf/dma-resv.c
> > > @@ -615,25 +615,21 @@ static inline int dma_resv_test_signaled_single=
(struct dma_fence *passed_fence)
> > >    */
> > >   bool dma_resv_test_signaled(struct dma_resv *obj, bool test_all)
> > >   {
> > > -	unsigned int seq, shared_count;
> > > +	struct dma_fence *fence;
> > > +	unsigned int seq;
> > >   	int ret;
> > >   	rcu_read_lock();
> > >   retry:
> > >   	ret =3D true;
> > > -	shared_count =3D 0;
> > >   	seq =3D read_seqcount_begin(&obj->seq);
> > >   	if (test_all) {
> > >   		struct dma_resv_list *fobj =3D dma_resv_shared_list(obj);
> > > -		unsigned int i;
> > > -
> > > -		if (fobj)
> > > -			shared_count =3D fobj->shared_count;
> > > +		unsigned int i, shared_count;
> > > +		shared_count =3D fobj ? fobj->shared_count : 0;
> > >   		for (i =3D 0; i < shared_count; ++i) {
> > > -			struct dma_fence *fence;
> > > -
> > >   			fence =3D rcu_dereference(fobj->shared[i]);
> > >   			ret =3D dma_resv_test_signaled_single(fence);
> > >   			if (ret < 0)
> > > @@ -641,24 +637,19 @@ bool dma_resv_test_signaled(struct dma_resv *ob=
j, bool test_all)
> > >   			else if (!ret)
> > >   				break;
> > >   		}
> > > -
> > > -		if (read_seqcount_retry(&obj->seq, seq))
> > > -			goto retry;
> > >   	}
> > > -	if (!shared_count) {
> > > -		struct dma_fence *fence_excl =3D dma_resv_excl_fence(obj);
> > > -
> > > -		if (fence_excl) {
> > > -			ret =3D dma_resv_test_signaled_single(fence_excl);
> > > -			if (ret < 0)
> > > -				goto retry;
> > > +	fence =3D dma_resv_excl_fence(obj);
> > > +	if (fence) {
> > > +		ret =3D dma_resv_test_signaled_single(fence);
> > > +		if (ret < 0)
> > > +			goto retry;
> > > -			if (read_seqcount_retry(&obj->seq, seq))
> > > -				goto retry;
> > > -		}
> > >   	}
> > > +	if (read_seqcount_retry(&obj->seq, seq))
> > > +		goto retry;
> > > +
> > >   	rcu_read_unlock();
> > >   	return ret;
> > >   }
> > > -- =

> > > 2.25.1
> > > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
