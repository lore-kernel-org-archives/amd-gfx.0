Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25322C49361
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 16:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54A6610CD
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 16:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54A6610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7BF6E943;
	Thu, 17 Jun 2021 16:58:40 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F86E6E943
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 16:58:39 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id m18so7569020wrv.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=m0NN26eErCRg0kmRwH9+v0k4xd87uCWvx8nQO4DniHo=;
 b=ZYv8yPfG6qw2zUs/XTTYQhQeSzFNtGco8MYF7pOYpNBPz1TKHOKAma5qqd/PTpH+6c
 pmj0gh6j5ApgICukaD758fqIZseLHDXm/2JodKZ3zvMeAMdlaHCeZQjZHSgVctkjjscY
 KfNZvEgifMOJrNLlkEMdRHL8U4G5jhceOlr0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=m0NN26eErCRg0kmRwH9+v0k4xd87uCWvx8nQO4DniHo=;
 b=At2hQRrmbVqPZw9tjDuv+d40mkQiZvoQX0cO3z7CWO7IPsSj+gQ+hfsUCJZ/XwHyLz
 VPLGpbJ/Wj8aQOKvxICXtmL/CK0QyUYoEs7iVBylszgaeWTvm/BSBUoiclujwhh9jwFG
 7QFJDYRwsamdEgUG1vR4mj7W65kLL/4astG1Xq4guAWFBec6Hxz9T7DihiJhIc08sx57
 zSTPNZF4joHog63eI1lFHXEmcg8KXicviRbGHiHGC6/P/AW7Eh+veXpXy4UIvijAxjLa
 9u61ac+k6VuXtV1pLCJmQuSqCfFA5cWh4GCllc+rALptnmn4ZnjcmL05O9oCNOipogZy
 4rgw==
X-Gm-Message-State: AOAM530/l1RH/jYHoZBws6pj5u9H6rCE5Ad3HGQwOdVjDOdzh6Qph+54
 age03jNenIpKcc8grSQoffOmuA==
X-Google-Smtp-Source: ABdhPJzND9ghlEQoOtP44Nnyb0E/yzTEeRlM/h9bCP50Wcq98cnP9naHBDMXVQDtDRw/VOOJv1D6SA==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr7012708wrr.182.1623949118175; 
 Thu, 17 Jun 2021 09:58:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id s7sm5879914wru.67.2021.06.17.09.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 09:58:37 -0700 (PDT)
Date: Thu, 17 Jun 2021 18:58:35 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
Message-ID: <YMt/O2LqRpixWIPa@phenom.ffwll.local>
References: <20210611120301.10595-1-christian.koenig@amd.com>
 <YMN3nr1mTj09p8lT@phenom.ffwll.local>
 <2c91e4b4-e8c8-a9f5-420f-9cf0c1f9a67d@gmail.com>
 <YMN5do2/KUt85h5W@phenom.ffwll.local>
 <a88eacc0-c572-b296-e30b-ec606d716f8f@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a88eacc0-c572-b296-e30b-ec606d716f8f@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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

On Mon, Jun 14, 2021 at 07:15:44PM +0200, Christian K=F6nig wrote:
> Am 11.06.21 um 16:55 schrieb Daniel Vetter:
> > On Fri, Jun 11, 2021 at 04:53:11PM +0200, Christian K=F6nig wrote:
> > > =

> > > Am 11.06.21 um 16:47 schrieb Daniel Vetter:
> > > > On Fri, Jun 11, 2021 at 02:02:57PM +0200, Christian K=F6nig wrote:
> > > > > As the name implies if testing all fences is requested we
> > > > > should indeed test all fences and not skip the exclusive
> > > > > one because we see shared ones.
> > > > > =

> > > > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > > > Hm I thought we've had the rule that when both fences exist, then
> > > > collectively the shared ones must signale no earlier than the exclu=
sive
> > > > one.
> > > > =

> > > > That's at least the contract we've implemented in dma_resv.h. But I=
've
> > > > also found a bunch of drivers who are a lot more yolo on this.
> > > > =

> > > > I think there's a solid case here to just always take all the fence=
s if we
> > > > ask for all the shared ones, but if we go that way then I'd say
> > > > - clear kerneldoc patch to really hammer this in (currently we're n=
ot good
> > > >     at all in this regard)
> > > > - going through drivers a bit to check for this (I have some of tha=
t done
> > > >     already in my earlier series, need to respin it and send it out)
> > > > =

> > > > But I'm kinda not seeing why this needs to be in this patch series =
here.
> > > You mentioned that this is a problem in the last patch and if you ask=
 me
> > > that's just a bug or at least very inconsistent.
> > > =

> > > See dma_resv_wait_timeout() always waits for all fences, including the
> > > exclusive one even if shared ones are present. But dma_resv_test_sign=
aled()
> > > ignores the exclusive one if shared ones are present.
> > Hm the only one I thought I've mentioned is that dma_buf_poll doesn't u=
se
> > dma_fence_get_rcu_safe where I think it should. Different problem. I th=
ink
> > this is one you spotted.
> > =

> > > The only other driver I could find trying to make use of this is nouv=
eau and
> > > I already provided a fix for this as well.
> > i915 also does this, and I think I've found a few more.
> > =

> > > I just think that this is the more defensive approach to fix this and=
 have
> > > at least the core functions consistent on the handling.
> > Oh fully agree, it's just current dma_resv docs aren't the greatest, and
> > hacking on semantics without updating the docs isn't great. Especially
> > when it's ad-hoc.
> =

> Well when the requirement that shared fences should always signal after t=
he
> exclusive fence is not documented anywhere then I would say that it is
> naturally allowed to just add any fence to the list of shared fence and a=
ny
> code assuming something else is just broken and need fixing.

That's not what I meant. I thought the rule is that the shared fences
_together_ need to signal after the exclusive ones. Not each individual
one.

This means that if you have both exclusive  fences and shared fences, and
you want to wait for just the shared fences, then you can ignore the
exclusive ones.

You have a patch series floating around which "fixes" this, but I think
it's imcomplete. And I'm pretty sure it's a change of defacto rules, since
not obeying this breaks a bunch of existing code (as you've noticed).
-Daniel

> =

> Christian.
> =

> > -Daniel
> > =

> > > Christian.
> > > =

> > > > -Daniel
> > > > =

> > > > > ---
> > > > >    drivers/dma-buf/dma-resv.c | 33 ++++++++++++------------------=
---
> > > > >    1 file changed, 12 insertions(+), 21 deletions(-)
> > > > > =

> > > > > diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-res=
v.c
> > > > > index f26c71747d43..c66bfdde9454 100644
> > > > > --- a/drivers/dma-buf/dma-resv.c
> > > > > +++ b/drivers/dma-buf/dma-resv.c
> > > > > @@ -615,25 +615,21 @@ static inline int dma_resv_test_signaled_si=
ngle(struct dma_fence *passed_fence)
> > > > >     */
> > > > >    bool dma_resv_test_signaled(struct dma_resv *obj, bool test_al=
l)
> > > > >    {
> > > > > -	unsigned int seq, shared_count;
> > > > > +	struct dma_fence *fence;
> > > > > +	unsigned int seq;
> > > > >    	int ret;
> > > > >    	rcu_read_lock();
> > > > >    retry:
> > > > >    	ret =3D true;
> > > > > -	shared_count =3D 0;
> > > > >    	seq =3D read_seqcount_begin(&obj->seq);
> > > > >    	if (test_all) {
> > > > >    		struct dma_resv_list *fobj =3D dma_resv_shared_list(obj);
> > > > > -		unsigned int i;
> > > > > -
> > > > > -		if (fobj)
> > > > > -			shared_count =3D fobj->shared_count;
> > > > > +		unsigned int i, shared_count;
> > > > > +		shared_count =3D fobj ? fobj->shared_count : 0;
> > > > >    		for (i =3D 0; i < shared_count; ++i) {
> > > > > -			struct dma_fence *fence;
> > > > > -
> > > > >    			fence =3D rcu_dereference(fobj->shared[i]);
> > > > >    			ret =3D dma_resv_test_signaled_single(fence);
> > > > >    			if (ret < 0)
> > > > > @@ -641,24 +637,19 @@ bool dma_resv_test_signaled(struct dma_resv=
 *obj, bool test_all)
> > > > >    			else if (!ret)
> > > > >    				break;
> > > > >    		}
> > > > > -
> > > > > -		if (read_seqcount_retry(&obj->seq, seq))
> > > > > -			goto retry;
> > > > >    	}
> > > > > -	if (!shared_count) {
> > > > > -		struct dma_fence *fence_excl =3D dma_resv_excl_fence(obj);
> > > > > -
> > > > > -		if (fence_excl) {
> > > > > -			ret =3D dma_resv_test_signaled_single(fence_excl);
> > > > > -			if (ret < 0)
> > > > > -				goto retry;
> > > > > +	fence =3D dma_resv_excl_fence(obj);
> > > > > +	if (fence) {
> > > > > +		ret =3D dma_resv_test_signaled_single(fence);
> > > > > +		if (ret < 0)
> > > > > +			goto retry;
> > > > > -			if (read_seqcount_retry(&obj->seq, seq))
> > > > > -				goto retry;
> > > > > -		}
> > > > >    	}
> > > > > +	if (read_seqcount_retry(&obj->seq, seq))
> > > > > +		goto retry;
> > > > > +
> > > > >    	rcu_read_unlock();
> > > > >    	return ret;
> > > > >    }
> > > > > -- =

> > > > > 2.25.1
> > > > > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
