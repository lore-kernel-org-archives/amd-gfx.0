Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC47C433EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56712070B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GzkYmEP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56712070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A74889CF5;
	Mon, 27 Jul 2020 09:39:12 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE0089CF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 09:39:11 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id f18so14180413wrs.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=8RCoZkhoieZac/MTCN4IyM+rPgUjma0v0Zq7zVhhyeg=;
 b=GzkYmEP8m/BdmdATLXvwvkzOzhLtQDtPsoDJIKpMsw6nAoTTjeSsPH+lmMoKkiG3Kj
 DTcD374BbOMNZzXWS75vl1qBv/9Y/dSDfDDuK8ZMctiqzZP6pGnOnUTKGkudttUGNZgW
 6z+YyyCmgSWKSay+w/T4/Fb0zM71NJAXUWRtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=8RCoZkhoieZac/MTCN4IyM+rPgUjma0v0Zq7zVhhyeg=;
 b=HS4QmeXIjA6ksh626fyg07IkDxwq39xnWYpBV3MfKZm0ta+VQWR+wf8qssoX8NhrJ/
 BbRY3NTcKKjLfM0dlk/Is78IGNJXiRKv+4Gpn8CyYj+G5OYB42tXXT2ehSGD4c6uxoTN
 65yQPCp7xWzjseTfoYwfUa93EileVoAbHZCA8+pP6Bu8UKiHbG1TEy8zQ3URPEGg4sBM
 PJW9EkAx+iEDgbJEOlL+xcbsCYe5hV9TTIXrE6gHz34G4u4Fg48l81S92t56QNumZasV
 aIaX/w2tupAjDEcT9UvxL6FKsf+Emgd/tp1cj3+kpPopVJhff8uw/KedHHA2lN/eeLci
 0XnA==
X-Gm-Message-State: AOAM53292PRQy1wTlwbQuzgCEM+C2ie4hC458/dFyiuZAGdX/cUpN3Qr
 unktVOK+mZvNS0LtZ0woN6c54w==
X-Google-Smtp-Source: ABdhPJw75vAc101pWEOGCaxoXpoO4Pq+2dtXYVMRaimrbaDttaYjkaCndLVxKo7QwXXGdffqB7vNnQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr19767200wrt.154.1595842749725; 
 Mon, 27 Jul 2020 02:39:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o2sm3410131wmh.5.2020.07.27.02.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 02:39:08 -0700 (PDT)
Date: Mon, 27 Jul 2020 11:39:07 +0200
From: daniel@ffwll.ch
To: 
Subject: Re: [PATCH -next 1/2] drm: Remove redundant NULL check
Message-ID: <20200727093907.GN6419@phenom.ffwll.local>
Mail-Followup-To: Li Heng <liheng40@huawei.com>, <airlied@linux.ie>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
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
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 23, 2020 at 11:27:42AM +0800, Li Heng wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/gpu/drm/drm_drv.c:819:2-7: WARNING: NULL check before some freeing functions is not needed.
> 
> Fixes: 5dad34f3c444 ("drm: Cleanups after drmm_add_final_kfree rollout")
> Signed-off-by: Li Heng <liheng40@huawei.com>

Queued up, should make it into 5.9 merge window, thanks for your patch.
-Daniel


> ---
>  drivers/gpu/drm/drm_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index bc38322..13068fd 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -815,8 +815,7 @@ static void drm_dev_release(struct kref *ref)
>  
>  	drm_managed_release(dev);
>  
> -	if (dev->managed.final_kfree)
> -		kfree(dev->managed.final_kfree);
> +	kfree(dev->managed.final_kfree);
>  }
>  
>  /**
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
