Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 18:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF0B60EE6
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 18:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF0B60EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416636E247;
	Wed,  8 Sep 2021 18:27:45 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DA26E247
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 18:27:44 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id kt8so209866ejb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Sep 2021 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=h7qqbAYeSJZ8gicucUP36snA5crLbH8LBI1pIK+gSTo=;
 b=GKpD+E+P7KmFYfe1bXOy5uk62XNSgLQzbE+a0vGLxZ2vVQvJXrhl70bt4SkMK9cS5c
 Y19XLuGJ9h/xNT3WL5zcImMwCZLjPgwZuAXSu6ZGIipD4Tvem/cZFlPPamwfWnyGasQF
 Aecs3DgArwpUkNVPDtaS2i8ni0BEOwCO/rNrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=h7qqbAYeSJZ8gicucUP36snA5crLbH8LBI1pIK+gSTo=;
 b=bGASEovMHK+dQi14ddgqGMCoEun/VLOSkjZtqMFBccpogn/zQtbkjzrsz+h7JJuxpI
 e1HDhdts2dcVd+I0/PvD2od36o0gVFJm+fUTw6hDi+AWJ1TEoioiqgZD2kTxVACt6XGP
 OelrP/9a0fA+NPhQwEtRw/ju4q2wL07MlYlSM0tR8Pbo+3rWDwNsIMdQ0PEsRKzSQoeD
 TtvmqF7AdzTnyNzh2049OcpgZ2G06mzZDazBQ+1wlgnuDKsl1fGwp2EFwhwZXIZ4QTN0
 iNEssSXeh6fIyyZuG2a+J4BZXAx2ioe7U6RpOO3TpdbokvnTzelAgNpX6TQZfM585zi4
 yxuw==
X-Gm-Message-State: AOAM530h6sO4l5ZtiXudxann0rP/BeCp8EV9Nc53IWdiFgqeg2mXFy4q
 Fwp4RfjMTiZYlFAZNwnIq5O4Og==
X-Google-Smtp-Source: ABdhPJx2WdSNz2VL5q86R3bQiaG5qfGtjEk//hrIEKSqXkgKTJos41xH1KbiVSg8nKtPcyTQxpEFPw==
X-Received: by 2002:a17:906:c298:: with SMTP id
 r24mr1268253ejz.93.1631125663142; 
 Wed, 08 Sep 2021 11:27:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id bx14sm1582030edb.93.2021.09.08.11.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 11:27:42 -0700 (PDT)
Date: Wed, 8 Sep 2021 20:27:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, xinhui pan <xinhui.pan@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [resend PATCH] drm/ttm: Fix a deadlock if the target BO is not
 idle during swap
Message-ID: <YTkAnDncKU7ewW+5@phenom.ffwll.local>
References: <20210907040832.1107747-1-xinhui.pan@amd.com>
 <074efe24-db7a-df68-3624-05989596f44a@amd.com>
 <YTcrcw+hxWuyyl4C@phenom.ffwll.local>
 <37412f7e-9f6f-04bb-41b1-72931ea1381e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37412f7e-9f6f-04bb-41b1-72931ea1381e@amd.com>
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

On Tue, Sep 07, 2021 at 11:28:23AM +0200, Christian König wrote:
> Am 07.09.21 um 11:05 schrieb Daniel Vetter:
> > On Tue, Sep 07, 2021 at 08:22:20AM +0200, Christian König wrote:
> > > Added a Fixes tag and pushed this to drm-misc-fixes.
> > We're in the merge window, this should have been drm-misc-next-fixes. I'll
> > poke misc maintainers so it's not lost.
> 
> Hui? It's a fix for a problem in stable and not in drm-misc-next.

Ah the flow chart is confusing. There is no current -rc, so it's always
-next-fixes. Or you're running the risk that it's lost until after -rc1.
Maybe we should clarify that "is the bug in current -rc?" only applies if
there is a current -rc.

Anyway Thomas sent out a pr, so it's all good.
-Daniel

> 
> Christian.
> 
> > -Daniel
> > 
> > > It will take a while until it cycles back into the development branches, so
> > > feel free to push some version to amd-staging-drm-next as well. Just ping
> > > Alex when you do this.
> > > 
> > > Thanks,
> > > Christian.
> > > 
> > > Am 07.09.21 um 06:08 schrieb xinhui pan:
> > > > The ret value might be -EBUSY, caller will think lru lock is still
> > > > locked but actually NOT. So return -ENOSPC instead. Otherwise we hit
> > > > list corruption.
> > > > 
> > > > ttm_bo_cleanup_refs might fail too if BO is not idle. If we return 0,
> > > > caller(ttm_tt_populate -> ttm_global_swapout ->ttm_device_swapout) will
> > > > be stuck as we actually did not free any BO memory. This usually happens
> > > > when the fence is not signaled for a long time.
> > > > 
> > > > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/ttm/ttm_bo.c | 6 +++---
> > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > index 8d7fd65ccced..23f906941ac9 100644
> > > > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > > > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > > > @@ -1152,9 +1152,9 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> > > >    	}
> > > >    	if (bo->deleted) {
> > > > -		ttm_bo_cleanup_refs(bo, false, false, locked);
> > > > +		ret = ttm_bo_cleanup_refs(bo, false, false, locked);
> > > >    		ttm_bo_put(bo);
> > > > -		return 0;
> > > > +		return ret == -EBUSY ? -ENOSPC : ret;
> > > >    	}
> > > >    	ttm_bo_del_from_lru(bo);
> > > > @@ -1208,7 +1208,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> > > >    	if (locked)
> > > >    		dma_resv_unlock(bo->base.resv);
> > > >    	ttm_bo_put(bo);
> > > > -	return ret;
> > > > +	return ret == -EBUSY ? -ENOSPC : ret;
> > > >    }
> > > >    void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
