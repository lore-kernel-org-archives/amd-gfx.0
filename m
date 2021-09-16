Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A49C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 12:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7270860EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 12:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7270860EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA0F6ED9C;
	Thu, 16 Sep 2021 12:22:20 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729D66ED9D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 12:22:19 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id y132so4683093wmc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=kra6YnAjZWRTxxxAs5XQIepeGYfZ4Rx3fQ5J07pAZC0=;
 b=Sgd0sj9QY0NLxV60P3vHebBOc6lMVJFSimAys3nxgFTc3VemkUmSRGRxivjGMHg5Ug
 PdE4Ru0pMCmMQY6qepZpUP+R9xXRfliItw2gpfiyMqdZe4w044mbMk796T7MXYiarvaP
 nUQ6MdmLUWxHklsOG/efHNGRCp7RidhkJTVq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kra6YnAjZWRTxxxAs5XQIepeGYfZ4Rx3fQ5J07pAZC0=;
 b=F67TfjFcNqu5D3g6Dg9c1I5AVd48mU3MLFgOPWpT8WOmdjJt9uncPObehcmZTQArr6
 ujTgQ97CsP2GheLsu0mqwJZnT+xIO/wTtdG67FjEr3Q8mNewEf2wOUWP+92bnG3fEQKG
 kQ6hFKuxS53R/NmIacKmqa0xg9W/jqEnoxaIzCNQOfcBHX/7sD6taVzD4GLZxZNvY8Cd
 a8ztihfyXkzziVBO4fC4LGEZLj0Qe8uNmr1xuF62AJN1exJzy9fVGMgw9xI07Z5I5Q3C
 flEcc/CPrcurdeNT27+gxLRhzgYIe4kp8SvhQZKlizC4Y0BpnPRocon5DQ2n02L4xFGU
 YYnw==
X-Gm-Message-State: AOAM532T1YUyQAkeqOVEVUjm9bfSWlq4Alm1GMtpIx6LDVfCXkg8CAJi
 PgxXo/xNbyvlq4n2uF7YTP4od94kNuH0cA==
X-Google-Smtp-Source: ABdhPJwJfMMYdSV6bI2C56HmJ/PjTCy11r3L+lOlGxKtlwfQ/YOn+1pYdcpf7apFRCv1oBkQbSCe0w==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr4870333wmj.108.1631794937949; 
 Thu, 16 Sep 2021 05:22:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 10sm7247206wmi.1.2021.09.16.05.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 05:22:17 -0700 (PDT)
Date: Thu, 16 Sep 2021 14:22:15 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [resend PATCH] drm/ttm: Fix a deadlock if the target BO is not
 idle during swap
Message-ID: <YUM297WiEcIhTyAB@phenom.ffwll.local>
References: <20210907040832.1107747-1-xinhui.pan@amd.com>
 <074efe24-db7a-df68-3624-05989596f44a@amd.com>
 <YTcrcw+hxWuyyl4C@phenom.ffwll.local>
 <37412f7e-9f6f-04bb-41b1-72931ea1381e@amd.com>
 <YTkAnDncKU7ewW+5@phenom.ffwll.local>
 <97ccbd16-ba3f-1b21-b6fb-5568d34f1af3@amd.com>
 <YUCowZxEhECTlgAH@phenom.ffwll.local>
 <e87ad40d-9c07-c307-2b61-75ecc3d0986c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e87ad40d-9c07-c307-2b61-75ecc3d0986c@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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

On Wed, Sep 15, 2021 at 12:05:30PM +0200, Christian König wrote:
> Am 14.09.21 um 15:50 schrieb Daniel Vetter:
> > On Thu, Sep 09, 2021 at 09:10:39AM +0200, Christian König wrote:
> > > Am 08.09.21 um 20:27 schrieb Daniel Vetter:
> > > > On Tue, Sep 07, 2021 at 11:28:23AM +0200, Christian König wrote:
> > > > > Am 07.09.21 um 11:05 schrieb Daniel Vetter:
> > > > > > On Tue, Sep 07, 2021 at 08:22:20AM +0200, Christian König wrote:
> > > > > > > Added a Fixes tag and pushed this to drm-misc-fixes.
> > > > > > We're in the merge window, this should have been drm-misc-next-fixes. I'll
> > > > > > poke misc maintainers so it's not lost.
> > > > > Hui? It's a fix for a problem in stable and not in drm-misc-next.
> > > > Ah the flow chart is confusing. There is no current -rc, so it's always
> > > > -next-fixes. Or you're running the risk that it's lost until after -rc1.
> > > > Maybe we should clarify that "is the bug in current -rc?" only applies if
> > > > there is a current -rc.
> > > Yeah, I've noticed this as well.
> > > 
> > > But when there is no current -rc because we are in the merge window then the
> > > question is how do I submit patches to the current stable?
> > You never submit patches directly to stable. It's always "get it into
> > Linus' tree asap" plus either Cc: stable or a Fixes: line.
> 
> But what if the code in drm-misc-next-fixes has been restructured and
> doesn't have that issue any more?
> 
> How do I get the patch into stable then? Submitting directly to Greg?

Yes, that's the exception. With a reference to the commit in Linus' tree
that resolves the issue, and an explainer why you need something else as a
backport.

https://dri.freedesktop.org/docs/drm/process/stable-kernel-rules.html#option-3

Cheers, Daniel

> 
> Thanks,
> Christian.
> 
> >   During merge
> > window "get into Linus' tree asap" means "put it into drm-misc-next-fixes"
> > 
> > > In other words this patch here is really for 5.14 and should then be
> > > backported to 5.13 and maybe even 5.10 as well.
> > > 
> > > The code was restructured for 5.15 and I even need to double check if that
> > > still applies there as well.
> > > 
> > > Or should I send patches like those directly to Greg?
> > Nope. Just fastest path into Linus' tree is good enough. Greg picks up
> > patches directly from the merge window if it has one of the tags. There's
> > occasionally a bit of grumbling because there's so many stable patches
> > coming in during the merge window, but otherwise it should be in stable in
> > the next release like during -rc phase.
> > -Daniel
> > 
> > > Regards,
> > > Christian.
> > > 
> > > > Anyway Thomas sent out a pr, so it's all good.
> > > > -Daniel
> > > > 
> > > > > Christian.
> > > > > 
> > > > > > -Daniel
> > > > > > 
> > > > > > > It will take a while until it cycles back into the development branches, so
> > > > > > > feel free to push some version to amd-staging-drm-next as well. Just ping
> > > > > > > Alex when you do this.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Christian.
> > > > > > > 
> > > > > > > Am 07.09.21 um 06:08 schrieb xinhui pan:
> > > > > > > > The ret value might be -EBUSY, caller will think lru lock is still
> > > > > > > > locked but actually NOT. So return -ENOSPC instead. Otherwise we hit
> > > > > > > > list corruption.
> > > > > > > > 
> > > > > > > > ttm_bo_cleanup_refs might fail too if BO is not idle. If we return 0,
> > > > > > > > caller(ttm_tt_populate -> ttm_global_swapout ->ttm_device_swapout) will
> > > > > > > > be stuck as we actually did not free any BO memory. This usually happens
> > > > > > > > when the fence is not signaled for a long time.
> > > > > > > > 
> > > > > > > > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > > > > > > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > > > > > > ---
> > > > > > > >      drivers/gpu/drm/ttm/ttm_bo.c | 6 +++---
> > > > > > > >      1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > > > > index 8d7fd65ccced..23f906941ac9 100644
> > > > > > > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > > > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > > > > > @@ -1152,9 +1152,9 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> > > > > > > >      	}
> > > > > > > >      	if (bo->deleted) {
> > > > > > > > -		ttm_bo_cleanup_refs(bo, false, false, locked);
> > > > > > > > +		ret = ttm_bo_cleanup_refs(bo, false, false, locked);
> > > > > > > >      		ttm_bo_put(bo);
> > > > > > > > -		return 0;
> > > > > > > > +		return ret == -EBUSY ? -ENOSPC : ret;
> > > > > > > >      	}
> > > > > > > >      	ttm_bo_del_from_lru(bo);
> > > > > > > > @@ -1208,7 +1208,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> > > > > > > >      	if (locked)
> > > > > > > >      		dma_resv_unlock(bo->base.resv);
> > > > > > > >      	ttm_bo_put(bo);
> > > > > > > > -	return ret;
> > > > > > > > +	return ret == -EBUSY ? -ENOSPC : ret;
> > > > > > > >      }
> > > > > > > >      void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
