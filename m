Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCCC6109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 09:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FCCC6109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7521889DEC;
	Tue,  7 Sep 2021 09:06:00 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0097189994
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 09:05:58 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 n14-20020a05600c3b8e00b002f8bd2f8ab6so1206219wms.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=9vYdDd8X0lBhnoXWTjXmd+qDgl8UgZ4vjdFNESohV+c=;
 b=AavmxG3vZRSVGG0YeqrAZg5OvtfcNg/ok+H2xaRJi9jnsS/cn+pyA+hK4oF86K9kJH
 GCbxKEaLf5/+KZ/Gkgm17IPEQHiJOQaJNG7Lz9F/NJDvYoBaxjsSUJS0TUOZP4LAJ1nV
 6r5RQq/wkLCqorark6Iat/lVRhfKTSp26i6xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9vYdDd8X0lBhnoXWTjXmd+qDgl8UgZ4vjdFNESohV+c=;
 b=uJrRcRXTZOQC+eGl7Y3rD4nm/HGoFq1LfXQu7sZwQawPUk/QrQ4OnnVgzUqP+FbMBM
 +ZFgdKtjTVxzXe5Kcu1L6G738hPVObDjjIJNN+M4/06SKhUVyv/RI2uAVDZupdDF/ykS
 v5hFmnO0P7m4wEJqtQbdlWXFnm4MJJq/n5ca5nZi+TQ+fbUWkmhc47vi/ICeIJjp7Yh3
 Vd+KwL1o+g8PAepd9LDtb/Fg+q4ccneIYTqrHuSrsMn/CPOMStBUyR6aBvhmQhVMq9Y/
 CGkiecos8CikteQWb+a8vaJJfCmGGQRL/ob4GyKrgl/NuAEPKaLktGQOHktAOGyhNWr5
 zUkw==
X-Gm-Message-State: AOAM532FAFZoGhdZPXOqB2EeL16a/1gKOJcEj0/4FjfvhfhO6yC8qJad
 FriZ5plVm3j9oWZODRZXuy5CGg==
X-Google-Smtp-Source: ABdhPJwo4tVF4Qk9OhdkzaEuokKaigsbodEipflSfp5oYEAy6XPRhP3ONe4FQjuXF1WU7PoAq7OGbQ==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr2898015wma.94.1631005557501; 
 Tue, 07 Sep 2021 02:05:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m6sm5691102wrw.0.2021.09.07.02.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 02:05:57 -0700 (PDT)
Date: Tue, 7 Sep 2021 11:05:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [resend PATCH] drm/ttm: Fix a deadlock if the target BO is not
 idle during swap
Message-ID: <YTcrcw+hxWuyyl4C@phenom.ffwll.local>
References: <20210907040832.1107747-1-xinhui.pan@amd.com>
 <074efe24-db7a-df68-3624-05989596f44a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <074efe24-db7a-df68-3624-05989596f44a@amd.com>
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

On Tue, Sep 07, 2021 at 08:22:20AM +0200, Christian König wrote:
> Added a Fixes tag and pushed this to drm-misc-fixes.

We're in the merge window, this should have been drm-misc-next-fixes. I'll
poke misc maintainers so it's not lost.
-Daniel

> 
> It will take a while until it cycles back into the development branches, so
> feel free to push some version to amd-staging-drm-next as well. Just ping
> Alex when you do this.
> 
> Thanks,
> Christian.
> 
> Am 07.09.21 um 06:08 schrieb xinhui pan:
> > The ret value might be -EBUSY, caller will think lru lock is still
> > locked but actually NOT. So return -ENOSPC instead. Otherwise we hit
> > list corruption.
> > 
> > ttm_bo_cleanup_refs might fail too if BO is not idle. If we return 0,
> > caller(ttm_tt_populate -> ttm_global_swapout ->ttm_device_swapout) will
> > be stuck as we actually did not free any BO memory. This usually happens
> > when the fence is not signaled for a long time.
> > 
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/ttm/ttm_bo.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > index 8d7fd65ccced..23f906941ac9 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -1152,9 +1152,9 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> >   	}
> >   	if (bo->deleted) {
> > -		ttm_bo_cleanup_refs(bo, false, false, locked);
> > +		ret = ttm_bo_cleanup_refs(bo, false, false, locked);
> >   		ttm_bo_put(bo);
> > -		return 0;
> > +		return ret == -EBUSY ? -ENOSPC : ret;
> >   	}
> >   	ttm_bo_del_from_lru(bo);
> > @@ -1208,7 +1208,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
> >   	if (locked)
> >   		dma_resv_unlock(bo->base.resv);
> >   	ttm_bo_put(bo);
> > -	return ret;
> > +	return ret == -EBUSY ? -ENOSPC : ret;
> >   }
> >   void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
