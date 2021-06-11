Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B81C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466F4613E1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 14:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466F4613E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22166EE98;
	Fri, 11 Jun 2021 14:48:02 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB856E53E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 14:48:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id c5so6361697wrq.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VVUk7MsKVOM1G242xbw185XkVQ9W//REmCA7qNbJimw=;
 b=fJEZuNNGmx2zlCN2vZEDEUFq55EhxmWys680XwPWxR8jRv8fcNy4M+R+BfLjKVsUEn
 u084fjIlQoe8c5fC+PoMJpuGvCc8PYc1L1xpl3MHkvuXt7GwLhjA83ylnRkmdn1ACVgm
 jR6/NFv7QKND/aOa8nbcfLq4VFPab0CQ2xlSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VVUk7MsKVOM1G242xbw185XkVQ9W//REmCA7qNbJimw=;
 b=VZc/l4ALJyR6g6+2MghGpoIAk8/F2PVrNNZONGN5nHg+P2HgWevGC0t2IOB5ulwCh3
 r6Glmwiv7R7ZcSFtwPUI58n2FXw3MAUHD6dK8395tStP+gmQBR6ddvBgRcA+oaFe5btC
 CX/m5aoXE0l6LLhhCg7G/eR+APF0jp1RgafnHQSKni1woHn/46Ul5GBhJ/oDQgzNztU6
 AS9TUUonKIHAT5vwfKTfDlEpVHHwXahMCUsfvLy3+H1dYEBiHiqwGYtA15j6cMuclgOR
 46ZOyZ30XXpr+mVIL9a6yjVKlN9OfRBNSjgrzLoTVViMrIzjsbsGktrOTDUlD85f7J9A
 lMIQ==
X-Gm-Message-State: AOAM532zoOliAeQsVv/WZF7XiGtCr4EZPQUZutnEiDyFnkP+LFWkRQEu
 zs+NPw6y+MCGu0G7wdRm47X09g==
X-Google-Smtp-Source: ABdhPJxpXtK6FRP5F/Bo+mdIDyTcalS6WrzyEZl+FQ36ZRVWsXEYw+ocbVl2lY23/9xQOBb2C8Jd8Q==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr4505452wrr.86.1623422880697;
 Fri, 11 Jun 2021 07:48:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id w11sm7381989wrv.89.2021.06.11.07.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 07:48:00 -0700 (PDT)
Date: Fri, 11 Jun 2021 16:47:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/5] dma-buf: fix dma_resv_test_signaled test_all handling
Message-ID: <YMN3nr1mTj09p8lT@phenom.ffwll.local>
References: <20210611120301.10595-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611120301.10595-1-christian.koenig@amd.com>
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
 daniel@ffwll.ch
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 11, 2021 at 02:02:57PM +0200, Christian K=F6nig wrote:
> As the name implies if testing all fences is requested we
> should indeed test all fences and not skip the exclusive
> one because we see shared ones.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

Hm I thought we've had the rule that when both fences exist, then
collectively the shared ones must signale no earlier than the exclusive
one.

That's at least the contract we've implemented in dma_resv.h. But I've
also found a bunch of drivers who are a lot more yolo on this.

I think there's a solid case here to just always take all the fences if we
ask for all the shared ones, but if we go that way then I'd say
- clear kerneldoc patch to really hammer this in (currently we're not good
  at all in this regard)
- going through drivers a bit to check for this (I have some of that done
  already in my earlier series, need to respin it and send it out)

But I'm kinda not seeing why this needs to be in this patch series here.
-Daniel

> ---
>  drivers/dma-buf/dma-resv.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
> =

> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index f26c71747d43..c66bfdde9454 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -615,25 +615,21 @@ static inline int dma_resv_test_signaled_single(str=
uct dma_fence *passed_fence)
>   */
>  bool dma_resv_test_signaled(struct dma_resv *obj, bool test_all)
>  {
> -	unsigned int seq, shared_count;
> +	struct dma_fence *fence;
> +	unsigned int seq;
>  	int ret;
>  =

>  	rcu_read_lock();
>  retry:
>  	ret =3D true;
> -	shared_count =3D 0;
>  	seq =3D read_seqcount_begin(&obj->seq);
>  =

>  	if (test_all) {
>  		struct dma_resv_list *fobj =3D dma_resv_shared_list(obj);
> -		unsigned int i;
> -
> -		if (fobj)
> -			shared_count =3D fobj->shared_count;
> +		unsigned int i, shared_count;
>  =

> +		shared_count =3D fobj ? fobj->shared_count : 0;
>  		for (i =3D 0; i < shared_count; ++i) {
> -			struct dma_fence *fence;
> -
>  			fence =3D rcu_dereference(fobj->shared[i]);
>  			ret =3D dma_resv_test_signaled_single(fence);
>  			if (ret < 0)
> @@ -641,24 +637,19 @@ bool dma_resv_test_signaled(struct dma_resv *obj, b=
ool test_all)
>  			else if (!ret)
>  				break;
>  		}
> -
> -		if (read_seqcount_retry(&obj->seq, seq))
> -			goto retry;
>  	}
>  =

> -	if (!shared_count) {
> -		struct dma_fence *fence_excl =3D dma_resv_excl_fence(obj);
> -
> -		if (fence_excl) {
> -			ret =3D dma_resv_test_signaled_single(fence_excl);
> -			if (ret < 0)
> -				goto retry;
> +	fence =3D dma_resv_excl_fence(obj);
> +	if (fence) {
> +		ret =3D dma_resv_test_signaled_single(fence);
> +		if (ret < 0)
> +			goto retry;
>  =

> -			if (read_seqcount_retry(&obj->seq, seq))
> -				goto retry;
> -		}
>  	}
>  =

> +	if (read_seqcount_retry(&obj->seq, seq))
> +		goto retry;
> +
>  	rcu_read_unlock();
>  	return ret;
>  }
> -- =

> 2.25.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
