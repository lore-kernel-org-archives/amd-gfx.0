Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2C6C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 08:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138D3112C06;
	Wed,  8 May 2024 08:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="Eg6cDDEM";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9C4112C06
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 08:41:43 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a59a86fb052so133902166b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 May 2024 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1715157701; x=1715762501; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vj3PIc4hFA9/gXdFfuPOe4yWwg2VXd43faHw15CH2oA=;
 b=Eg6cDDEM1arBPjKZm85lGtmatjMBbgClEmfLWcPbzHDQQka8fX2RQoie3OgQ8DPuhK
 tzYDgVxmWRn6/Gf0OS28Fj7me6Iq3701mUUYGrS4uOCJ1dEb/ZvQzhdkKMaFsGDfJry0
 +rB4YmBsEy4H6YOCKKq+lDsyGiwnqiVfuqBjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715157701; x=1715762501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj3PIc4hFA9/gXdFfuPOe4yWwg2VXd43faHw15CH2oA=;
 b=puAGd/MzlcQFZjWSOGod5Mivi7ODKtSmIp1h8oaKPIX/xSKWCtCu+avMS9aJcokCgg
 EVAQGQMBCkyE7VNrlkZX/hJ2xQB0o1iBpM2CXUL5BigTQK3CJtklcn4gucW9hGnbsRyb
 WhPJyoitZmhwydf5UiUT8ANW8XAhHx5Jf1fa0NvkGvp2rrIWcwazBYHBxbEBSW1HWuKQ
 q8NL63B9Vd0mFeqajAV6dQHXmvMqdJWvRNxtVYsVQ3O2b3BoDnwyNVaE/CtUhbCwSRYp
 p5ohj8GANs4cxWHOfQJQ9Y6pzqiuWL8b9Vi6vpQbvaNd0rR71eolkqZY/ph1hM9vKbAA
 qxwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKr3LmZre2CHbXh4vel7rCnRcOgF62UkRXqOCuWlSu3xbTpnnYRVaEVAAxX+ka48jaqRBTpJIcwf0++48w8go6ltSKX55VpASesJOHHw==
X-Gm-Message-State: AOJu0Yx7fNj5TJwRWhxIrvJ2rSWrUGQlPqTn8B1DLNFBWhIQVWu+32pt
 3/UvArGACQ2jKxHAnQW2kxjWvbfoSo9+OpAyMG/Cbsp1ehGG+CPxvx0KQp3KAh4=
X-Google-Smtp-Source: AGHT+IH14cLBvOGAxNNOD0NGpNszsABs3zuyVXh3n6kNBMTLyF0vRRZioU2iVIuWiSighaj0aLtPcg==
X-Received: by 2002:a17:906:df14:b0:a59:bce9:8454 with SMTP id
 a640c23a62f3a-a59fb94f6d3mr121582766b.1.1715157700922; 
 Wed, 08 May 2024 01:41:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a1709067c5700b00a5a0b34110dsm97882ejp.1.2024.05.08.01.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 01:41:40 -0700 (PDT)
Date: Wed, 8 May 2024 10:41:37 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, christian.koenig@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/buddy: Fix the range bias clear memory allocation
 issue
Message-ID: <Zjs6wVITtRuXoRDz@phenom.ffwll.local>
References: <20240508065720.125846-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508065720.125846-1-Arunpravin.PaneerSelvam@amd.com>
X-Operating-System: Linux phenom 6.6.15-amd64 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 08, 2024 at 12:27:20PM +0530, Arunpravin Paneer Selvam wrote:
> Problem statement: During the system boot time, an application request
> for the bulk volume of cleared range bias memory when the clear_avail
> is zero, we dont fallback into normal allocation method as we had an
> unnecessary clear_avail check which prevents the fallback method leads
> to fb allocation failure following system goes into unresponsive state.
> 
> Solution: Remove the unnecessary clear_avail check in the range bias
> allocation function.
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Fixes: 96950929eb23 ("drm/buddy: Implement tracking clear page feature")
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---
>  drivers/gpu/drm/drm_buddy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you please also add a kunit test case to exercise this corner case and
make sure it stays fixed?

Thanks, Sima
> 
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 284ebae71cc4..831929ac95eb 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -574,7 +574,7 @@ __drm_buddy_alloc_range_bias(struct drm_buddy *mm,
>  
>  	block = __alloc_range_bias(mm, start, end, order,
>  				   flags, fallback);
> -	if (IS_ERR(block) && mm->clear_avail)
> +	if (IS_ERR(block))
>  		return __alloc_range_bias(mm, start, end, order,
>  					  flags, !fallback);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
