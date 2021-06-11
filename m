Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A55C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 15:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858E761263
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 15:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858E761263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E2C6EEAF;
	Fri, 11 Jun 2021 15:11:58 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE4A6EEB1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 15:11:57 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id c9so6447303wrt.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=XdyIzqizK6pAqCwRAfCRwynXNk5/rhNcT3ATuA902+M=;
 b=IGto4DjS05PVntPCgr6mFmgFfSPJ9Ce+0agGeqAwcr86bYtW7pR2g/R3jChYOjng5x
 vSgAUj57GMZQqrC74eDq5t1eOFeu3b+4FtlUcVcH+SHrnOGHzO4lfELq//QDZI85zYks
 A0so+6JTTpXMzumRSlLhlwGgOr0xU+6pBe9/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XdyIzqizK6pAqCwRAfCRwynXNk5/rhNcT3ATuA902+M=;
 b=cSFJMgqCzynXJd8jT3poEv8zZQWLUouToYR0bKDhq/VBfzbRS9lMU4rqt+F7FtHNZU
 IY052zj+579QwqOuDhnQMXL6XbyNRb7+mHK0lgUcBxi7Yqp8cRZQ6wzJEpShsXpQzjgF
 U40a/T70LgPnnlcKWK9jAgFZkmCqJ4+SOSGcZsoU77DR7HUHBdbJxVOobdm7FkcA3PSc
 Ta6rrIEog+GcLMxnUpQw6JhDNA4ID8+/A4/aQGg+yLGRbvfdzgpln1nrE4v9UUTTkTus
 FfK/3yWor1U75QwIuYNHafc1uAaXgtcqz9ycJXI5pPv/FtnI4+FUuOr7jp3hk0yDwx8h
 SPow==
X-Gm-Message-State: AOAM533AouDbWOAy5srsBPGzBwlyfxy4bDhBPtvNTkZ+mdUSDYS6aMNX
 3zc83oiDIkSwOSCRsSuoR1s+5w==
X-Google-Smtp-Source: ABdhPJxOTbY8he4VgN61JfDiNoLkaLyKVaunrIlyVc6lp1gDPWDPyNHpD/ZQGpYtFUdcURhQfJL0mw==
X-Received: by 2002:adf:ed03:: with SMTP id a3mr4731961wro.166.1623424315698; 
 Fri, 11 Jun 2021 08:11:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 4sm6849586wry.74.2021.06.11.08.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 08:11:55 -0700 (PDT)
Date: Fri, 11 Jun 2021 17:11:53 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 4/7] dma-buf: add dma_fence_chain_garbage_collect
Message-ID: <YMN9ORJ2xrZKATHu@phenom.ffwll.local>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <20210610091800.1833-5-christian.koenig@amd.com>
 <YMMlmt0frb1Pfdo0@phenom.ffwll.local>
 <e844dace-832c-3a0a-8ca2-d3aeb5cfde19@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e844dace-832c-3a0a-8ca2-d3aeb5cfde19@gmail.com>
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

On Fri, Jun 11, 2021 at 12:07:00PM +0200, Christian K=F6nig wrote:
> Am 11.06.21 um 10:58 schrieb Daniel Vetter:
> > On Thu, Jun 10, 2021 at 11:17:57AM +0200, Christian K=F6nig wrote:
> > > Add some rather sophisticated lockless garbage collection
> > > for dma_fence_chain objects.
> > > =

> > > For this keep all initialized dma_fence_chain nodes an a
> > > queue and trigger garbage collection before a new one is
> > > allocated.
> > > =

> > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > Uh hand-rolled lockless list, I'm not a fan.
> > =

> > But the real question here is why? This is a global list, so it's going=
 to
> > look great on your desktop, but gpus are for servers now and those are
> > NUMA. So just from that pov doing garbage-collection individually still
> > feels like a much better idea.
> =

> Yeah, I was pondering on that quite a bit as well. That why I added the
> multi threaded alloc/free test.
> =

> > So what's the problem your trying to solve here?
> =

> I was not sure if the chain is garbage collected enough when used for the
> dma_resv exclusive object.
> =

> But I think we could just drop this for now and just see how it goes.

Yeah I think fixing a perf/tuning problem when we're hitting it is much
better than trying to guess what it might be and writing something really
clever to anticipate that. We generally get it wrong.

Also with the explaination of what it tests added the testcase makes
sense. Just some documentation or comment would have helped.
-Daniel

> =

> Christian.
> =

> > -Daniel
> > =

> > > ---
> > >   drivers/dma-buf/dma-fence-chain.c | 160 +++++++++++++++++++++++++--=
---
> > >   include/linux/dma-fence-chain.h   |   5 +
> > >   2 files changed, 142 insertions(+), 23 deletions(-)
> > > =

> > > diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-=
fence-chain.c
> > > index 1b4cb3e5cec9..c2f0b69eabb7 100644
> > > --- a/drivers/dma-buf/dma-fence-chain.c
> > > +++ b/drivers/dma-buf/dma-fence-chain.c
> > > @@ -9,8 +9,53 @@
> > >   #include <linux/dma-fence-chain.h>
> > > +static struct dma_fence_chain __rcu *fifo_front;
> > > +static struct dma_fence_chain __rcu **fifo_back =3D &fifo_front;
> > > +
> > >   static bool dma_fence_chain_enable_signaling(struct dma_fence *fenc=
e);
> > > +/**
> > > + * dma_fence_chain_enqueue - enqeue a chain node for garbage collect=
ion
> > > + * @chain: the chain node to enqueue
> > > + *
> > > + * Add the chain node to the end of the gc fifo.
> > > + */
> > > +static void dma_fence_chain_enqueue(struct dma_fence_chain *chain)
> > > +{
> > > +	struct dma_fence_chain __rcu **tmp;
> > > +
> > > +	RCU_INIT_POINTER(chain->next, NULL);
> > > +	tmp =3D xchg((struct dma_fence_chain __force ***)&fifo_back,
> > > +		   &chain->next);
> > > +
> > > +	/* This is intentionally unordered since we only need the fifo for =
gc */
> > > +	rcu_assign_pointer(*tmp, chain);
> > > +}
> > > +
> > > +/**
> > > + * dma_fence_chain_dequeue - deqeueue a chain node for garbage colle=
ction
> > > + *
> > > + * Remove the first chain node from the gc fifo while making sure th=
at always
> > > + * keep at least one node on the fifo for lockless fifo implementati=
on.
> > > + * Returns the dequeued chain node or NULL.
> > > + */
> > > +static struct dma_fence_chain *dma_fence_chain_dequeue(void)
> > > +{
> > > +	struct dma_fence_chain *chain, *tmp;
> > > +
> > > +	rcu_read_lock();
> > > +	chain =3D rcu_dereference(fifo_front);
> > > +	/* Never dequeue the last chain node for lockless fifo */
> > > +	if (unlikely(!chain || !rcu_access_pointer(chain->next))) {
> > > +		rcu_read_unlock();
> > > +		return NULL;
> > > +	}
> > > +	tmp =3D cmpxchg((struct dma_fence_chain __force **)&fifo_front,
> > > +		      chain, rcu_access_pointer(chain->next));
> > > +	rcu_read_unlock();
> > > +	return tmp =3D=3D chain ? chain : NULL;
> > > +}
> > > +
> > >   /**
> > >    * dma_fence_chain_get_prev - use RCU to get a reference to the pre=
vious fence
> > >    * @chain: chain node to get the previous node from
> > > @@ -28,6 +73,43 @@ static struct dma_fence *dma_fence_chain_get_prev(=
struct dma_fence_chain *chain)
> > >   	return prev;
> > >   }
> > > +/**
> > > + * dma_fence_chain_try_replace - try to replace the prev node
> > > + * @chain: Chain node we try to replace prev.
> > > + * @prev: the old prev node
> > > + *
> > > + * Try to replace the previous chain node when it or its containing =
fence is
> > > + * signaled. Returns true if we tried, false if we need to wait.
> > > + */
> > > +static bool dma_fence_chain_try_replace(struct dma_fence_chain *chai=
n,
> > > +					struct dma_fence *prev)
> > > +{
> > > +	struct dma_fence *replacement, *tmp;
> > > +	struct dma_fence_chain *prev_chain;
> > > +
> > > +	prev_chain =3D to_dma_fence_chain(prev);
> > > +	if (prev_chain) {
> > > +		if (!dma_fence_is_signaled(prev_chain->fence))
> > > +			return false;
> > > +
> > > +		replacement =3D dma_fence_chain_get_prev(prev_chain);
> > > +	} else {
> > > +		if (!dma_fence_is_signaled(prev))
> > > +			return false;
> > > +
> > > +		replacement =3D NULL;
> > > +	}
> > > +
> > > +	tmp =3D cmpxchg((struct dma_fence __force **)&chain->prev, prev,
> > > +		      replacement);
> > > +	if (tmp =3D=3D prev)
> > > +		dma_fence_put(tmp);
> > > +	else
> > > +		dma_fence_put(replacement);
> > > +
> > > +	return true;
> > > +}
> > > +
> > >   /**
> > >    * dma_fence_chain_walk - chain walking function
> > >    * @fence: current chain node
> > > @@ -38,8 +120,8 @@ static struct dma_fence *dma_fence_chain_get_prev(=
struct dma_fence_chain *chain)
> > >    */
> > >   struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence)
> > >   {
> > > -	struct dma_fence_chain *chain, *prev_chain;
> > > -	struct dma_fence *prev, *replacement, *tmp;
> > > +	struct dma_fence_chain *chain;
> > > +	struct dma_fence *prev;
> > >   	chain =3D to_dma_fence_chain(fence);
> > >   	if (!chain) {
> > > @@ -48,26 +130,8 @@ struct dma_fence *dma_fence_chain_walk(struct dma=
_fence *fence)
> > >   	}
> > >   	while ((prev =3D dma_fence_chain_get_prev(chain))) {
> > > -
> > > -		prev_chain =3D to_dma_fence_chain(prev);
> > > -		if (prev_chain) {
> > > -			if (!dma_fence_is_signaled(prev_chain->fence))
> > > -				break;
> > > -
> > > -			replacement =3D dma_fence_chain_get_prev(prev_chain);
> > > -		} else {
> > > -			if (!dma_fence_is_signaled(prev))
> > > -				break;
> > > -
> > > -			replacement =3D NULL;
> > > -		}
> > > -
> > > -		tmp =3D cmpxchg((struct dma_fence __force **)&chain->prev,
> > > -			      prev, replacement);
> > > -		if (tmp =3D=3D prev)
> > > -			dma_fence_put(tmp);
> > > -		else
> > > -			dma_fence_put(replacement);
> > > +		if (!dma_fence_chain_try_replace(chain, prev))
> > > +			break;
> > >   		dma_fence_put(prev);
> > >   	}
> > > @@ -205,7 +269,21 @@ static void dma_fence_chain_release(struct dma_f=
ence *fence)
> > >   	dma_fence_put(prev);
> > >   	dma_fence_put(chain->fence);
> > > -	dma_fence_free(fence);
> > > +	WRITE_ONCE(chain->fence, NULL);
> > > +
> > > +	/*
> > > +	 * Don't garbage collect here to avoid recursion and potential stack
> > > +	 * overflow.
> > > +	 */
> > > +	chain =3D dma_fence_chain_dequeue();
> > > +	if (!chain)
> > > +		return;
> > > +
> > > +	if (kref_read(&chain->base.refcount) ||
> > > +	    READ_ONCE(chain->fence))
> > > +		dma_fence_chain_enqueue(chain);
> > > +	else
> > > +		dma_fence_free(&chain->base);
> > >   }
> > >   const struct dma_fence_ops dma_fence_chain_ops =3D {
> > > @@ -218,6 +296,40 @@ const struct dma_fence_ops dma_fence_chain_ops =
=3D {
> > >   };
> > >   EXPORT_SYMBOL(dma_fence_chain_ops);
> > > +/**
> > > + * dma_fence_chain_garbage_collect - cleanup chain nodes
> > > + *
> > > + * Do some garbage collection and try to release chain nodes.
> > > + */
> > > +void dma_fence_chain_garbage_collect(void)
> > > +{
> > > +	struct dma_fence_chain *chain =3D dma_fence_chain_dequeue();
> > > +
> > > +	if (!chain)
> > > +		return;
> > > +
> > > +	if (!dma_fence_get_rcu(&chain->base)) {
> > > +		/* Unused, check if it's also clean */
> > > +		if (likely(!READ_ONCE(chain->fence))) {
> > > +			dma_fence_free(&chain->base);
> > > +			return;
> > > +		}
> > > +
> > > +	} else {
> > > +		struct dma_fence *prev;
> > > +
> > > +		/* Used, do some chain walk */
> > > +		prev =3D dma_fence_chain_get_prev(chain);
> > > +		if (prev) {
> > > +			dma_fence_chain_try_replace(chain, prev);
> > > +			dma_fence_put(prev);
> > > +		}
> > > +		dma_fence_put(&chain->base);
> > > +	}
> > > +	dma_fence_chain_enqueue(chain);
> > > +}
> > > +EXPORT_SYMBOL(dma_fence_chain_garbage_collect);
> > > +
> > >   /**
> > >    * dma_fence_chain_init - initialize a fence chain
> > >    * @chain: the chain node to initialize
> > > @@ -254,5 +366,7 @@ void dma_fence_chain_init(struct dma_fence_chain =
*chain,
> > >   	dma_fence_init(&chain->base, &dma_fence_chain_ops,
> > >   		       &chain->lock, context, seqno);
> > > +	dma_fence_chain_enqueue(chain);
> > >   }
> > > +
> > >   EXPORT_SYMBOL(dma_fence_chain_init);
> > > diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fenc=
e-chain.h
> > > index 5f45689a6d2e..b412b5396434 100644
> > > --- a/include/linux/dma-fence-chain.h
> > > +++ b/include/linux/dma-fence-chain.h
> > > @@ -19,6 +19,7 @@
> > >    * @base: fence base class
> > >    * @lock: spinlock for fence handling
> > >    * @prev: previous fence of the chain
> > > + * @next: next chain node for garbage collection
> > >    * @prev_seqno: original previous seqno before garbage collection
> > >    * @fence: encapsulated fence
> > >    * @cb: callback structure for signaling
> > > @@ -27,6 +28,7 @@
> > >   struct dma_fence_chain {
> > >   	struct dma_fence base;
> > >   	struct dma_fence __rcu *prev;
> > > +	struct dma_fence_chain __rcu *next;
> > >   	u64 prev_seqno;
> > >   	struct dma_fence *fence;
> > >   	union {
> > > @@ -38,6 +40,8 @@ struct dma_fence_chain {
> > >   extern const struct dma_fence_ops dma_fence_chain_ops;
> > > +void dma_fence_chain_garbage_collect(void);
> > > +
> > >   /**
> > >    * to_dma_fence_chain - cast a fence to a dma_fence_chain
> > >    * @fence: fence to cast to a dma_fence_array
> > > @@ -61,6 +65,7 @@ to_dma_fence_chain(struct dma_fence *fence)
> > >    */
> > >   static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> > >   {
> > > +	dma_fence_chain_garbage_collect();
> > >   	return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> > >   };
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
