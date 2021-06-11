Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D522C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A6661027
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A6661027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F066EE45;
	Fri, 11 Jun 2021 07:58:17 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EA26EE46
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:58:16 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id b205so2870038wmb.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Cb2J6sSCslD5uvLaCGMCBxynXsGOY9oqpQH7yy0HDiM=;
 b=YLj4dPA5HeJ1vFEo+Kagh6Cll3C1STlr33QgWQyGmziFH+Z9OFECn3bt5cNXkIlh+k
 tJSkreQzKvXrsm+dricbgqCIwJ3SxKkQSyymdgaT5gJv60m+uyh5SZzrAfRygmbsNafQ
 Wta+hIIL8apOxGuiDkhEld58aUN09SM3GAlrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Cb2J6sSCslD5uvLaCGMCBxynXsGOY9oqpQH7yy0HDiM=;
 b=IocbDL39SYTYCpex+0wuDoeaYngdxh18UsGzGkKGx5ua50oefwvUte2/bDBmG1Jsap
 CUcJLoNelwoqCE2QRgs1ypo+pUafVd5rTJhAgSiitzoQyv+Aqi0CefUBSAkCEKLzK885
 10mYvhi3K+qFCFvtJlzbpZg+m+z5HCYOyn0mNjL/5KpNeDDdIWkh5K6lpqQ9HOxDusot
 WIRn6Ssxv3EmIO8saIDfgirh+nTcU0YL4yGHNZ0fSmqcjP3Hdr2ReQV0b7nLIvSWWDcl
 om/44IR7/CQV4RJKTn//0oswxuxx3gIlL4vwTlp9Umy37Z0mOJn/4UwH6rKZ0th3i3ak
 bGkg==
X-Gm-Message-State: AOAM533bSju6of1vj6T1eU48A0m8DVlViYR9s//wZOXZm3DuoNZrK0aH
 YEDSgT5QGzGocFnZDYfVtz+7HVJJNH1EiQ==
X-Google-Smtp-Source: ABdhPJylLBcD7nMz11LRrYZN4d8CQjyvSjS8RevAozcmcYQPEQA3gPZ0GZoBpegES+gmKgKBrnS1QQ==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr10397638wmh.144.1623398295202; 
 Fri, 11 Jun 2021 00:58:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g17sm6191082wrp.61.2021.06.11.00.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 00:58:14 -0700 (PDT)
Date: Fri, 11 Jun 2021 09:58:12 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 3/7] dma-buf: add dma_fence_chain_alloc/free self tests
Message-ID: <YMMXlF5A7uB0sORs@phenom.ffwll.local>
References: <20210610091800.1833-1-christian.koenig@amd.com>
 <20210610091800.1833-4-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610091800.1833-4-christian.koenig@amd.com>
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

On Thu, Jun 10, 2021 at 11:17:56AM +0200, Christian K=F6nig wrote:
> Exercise the newly added functions.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

I have honestly no idea what this checks. Spawning a few threads to
validate kmalloc/kfree feels a bit silly. Now testing whether we correctly
rcu-delay the freeing here would make some sense, but even that feels a
bit silly.

I guess if you want this explain with comments what it does and why?
-Daniel


> ---
>  drivers/dma-buf/st-dma-fence-chain.c | 48 ++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> =

> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dm=
a-fence-chain.c
> index 8ce1ea59d31b..855c129c6093 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -95,6 +95,53 @@ static int sanitycheck(void *arg)
>  	return err;
>  }
>  =

> +static int __alloc_free(void *arg)
> +{
> +	atomic_t *counter =3D arg;
> +	int i, j;
> +
> +	for (i =3D 0; i < 1024; ++i) {
> +		struct dma_fence_chain *chains[64];
> +
> +		for (j =3D 0; j < ARRAY_SIZE(chains); ++j)
> +			chains[j] =3D dma_fence_chain_alloc();
> +
> +		for (j =3D 0; j < ARRAY_SIZE(chains); ++j)
> +			dma_fence_chain_free(chains[j]);
> +
> +		atomic_add(ARRAY_SIZE(chains), counter);
> +	}
> +	return 0;
> +}
> +
> +static int alloc_free(void *arg)
> +{
> +	struct task_struct *threads[8];
> +	atomic_t counter =3D ATOMIC_INIT(0);
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(threads); i++) {
> +		threads[i] =3D kthread_run(__alloc_free, &counter, "dmabuf/%d",
> +					 i);
> +		if (IS_ERR(threads[i])) {
> +			err =3D PTR_ERR(threads[i]);
> +			break;
> +		}
> +	}
> +
> +	while (i--) {
> +		int ret;
> +
> +		ret =3D kthread_stop(threads[i]);
> +		if (ret && !err)
> +			err =3D ret;
> +	}
> +
> +	pr_info("Completed %u cycles\n", atomic_read(&counter));
> +
> +	return err;
> +}
> +
>  struct fence_chains {
>  	unsigned int chain_length;
>  	struct dma_fence **fences;
> @@ -677,6 +724,7 @@ int dma_fence_chain(void)
>  {
>  	static const struct subtest tests[] =3D {
>  		SUBTEST(sanitycheck),
> +		SUBTEST(alloc_free),
>  		SUBTEST(find_seqno),
>  		SUBTEST(find_signaled),
>  		SUBTEST(find_out_of_order),
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
