Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F24C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 17:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE646197E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 17:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE646197E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D2F6EA63;
	Fri, 19 Mar 2021 17:52:25 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654B66EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 17:52:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id z2so9960062wrl.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=VnITPwiLrs7uBsWiTNoe0pSs7GaSKYi/Eq2/dCiQhiQ=;
 b=TqOF4ZCgrkuwRtFWvBL6YydLQvUCL48euFg1A9VL6cOkpDZhaZSlwxFceKb3NJUfDF
 YyNQQ8XuU/GZAuMuPTbE5n2ucra6N7lU5/TSJUxWh8Md7NEn+Eg6ge3qhqGnck2PeF3c
 DGlKgfqhdxZaHgH4btTrlQu5oAqylJ4TWuutg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=VnITPwiLrs7uBsWiTNoe0pSs7GaSKYi/Eq2/dCiQhiQ=;
 b=Zn8LTd1GjgCMD8KBR6sjC7UBFflQ1uiSyS5g+5/8b/gpb6xfIkeZXBMQnS0HAEDUG+
 s+7QQxmtNB9yPPfdQAFOnUwVJ9I9XBRmM1deg5d6NgrusuZvjPcwv8pdw8Xia08KbEUX
 wHnvALP3CDSe5Junwx+ra1PDaZlZzh1judvf2h0BtcEiArgOErKmDC0/dXbIlGslQK7I
 ia8K/9Z6kidsXnTl1VwMW89BCSzUHaWPenLbED1gpbEM6Wa2wic7qWqAsf8XcP1g1jsd
 SRJ7pOV7QScQKLhNJI+fptHuIlqrCfSCPhkK3cVw5s9dcqbD5ZHT3HNvqK9r0UYZizj0
 lILw==
X-Gm-Message-State: AOAM533uFb5e9q21lPlpFzoOA4nQ6skt9ez0vcSlkeCN8yQ341vgPAaI
 lylvKxm67sKD/kJo6CnkOp892w==
X-Google-Smtp-Source: ABdhPJyKhjd1TvLDdn9WLGmf01oJs5J3mm4FKIYxCYmQ2hGM9TN8O6qzCv5a4cQW0aUl83L6Odttwg==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr5803938wru.401.1616176343003; 
 Fri, 19 Mar 2021 10:52:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y16sm9145707wrh.3.2021.03.19.10.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 10:52:22 -0700 (PDT)
Date: Fri, 19 Mar 2021 18:52:20 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/ttm: stop warning on TT shrinker failure
Message-ID: <YFTk1GSaUDI3wcWt@phenom.ffwll.local>
References: <20210319140857.2262-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319140857.2262-1-christian.koenig@amd.com>
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
Cc: Leo.Liu@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 19, 2021 at 03:08:57PM +0100, Christian K=F6nig wrote:
> Don't print a warning when we fail to allocate a page for swapping things=
 out.
> =

> Also rely on memalloc_nofs_save/memalloc_nofs_restore instead of GFP_NOFS.

Uh this part doesn't make sense. Especially since you only do it for the
debugfs file, not in general. Which means you've just completely broken
the shrinker.

If this is just to paper over the seq_printf doing the wrong allocations,
then just move that out from under the fs_reclaim_acquire/release part.

__GFP_NOWARN should be there indeed I think.
-Daniel

> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_tt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 2f0833c98d2c..86fa3e82dacc 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -369,7 +369,7 @@ static unsigned long ttm_tt_shrinker_scan(struct shri=
nker *shrink,
>  	};
>  	int ret;
>  =

> -	ret =3D ttm_bo_swapout(&ctx, GFP_NOFS);
> +	ret =3D ttm_bo_swapout(&ctx, GFP_KERNEL | __GFP_NOWARN);
>  	return ret < 0 ? SHRINK_EMPTY : ret;
>  }
>  =

> @@ -389,10 +389,13 @@ static unsigned long ttm_tt_shrinker_count(struct s=
hrinker *shrink,
>  static int ttm_tt_debugfs_shrink_show(struct seq_file *m, void *data)
>  {
>  	struct shrink_control sc =3D { .gfp_mask =3D GFP_KERNEL };
> +	unsigned int flags;
>  =

>  	fs_reclaim_acquire(GFP_KERNEL);
> +	flags =3D memalloc_nofs_save();
>  	seq_printf(m, "%lu/%lu\n", ttm_tt_shrinker_count(&mm_shrinker, &sc),
>  		   ttm_tt_shrinker_scan(&mm_shrinker, &sc));
> +	memalloc_nofs_restore(flags);
>  	fs_reclaim_release(GFP_KERNEL);
>  =

>  	return 0;
> -- =

> 2.25.1
> =

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
