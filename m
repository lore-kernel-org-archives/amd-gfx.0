Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A4C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 06:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC59F20826
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hFGXoZ4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC59F20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B5C6E136;
	Wed,  2 Sep 2020 06:59:10 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72AA16E130
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 06:59:09 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c18so3980192wrm.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2020 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0pqHRfpr6UrjNvbY/R9ZrWji8L8XsS+WJrZoowuq3CI=;
 b=hFGXoZ4FFNRD4jI5y5iYxtLPTKZCFlAIprIwSufOwhBSVaFP+52L3gVQxCsv45z5ge
 HUqCe6pvEJh+QdY8c9UjMrcNaoE/juyVOBo1Wbh3ZRaWY3hDXt75EL6LLcAD1npy/KYq
 gMMqC6JsvUTwCOvZSow76odIeTe/j5H0zZkAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0pqHRfpr6UrjNvbY/R9ZrWji8L8XsS+WJrZoowuq3CI=;
 b=pho7H8DKUCtAzjIL6nMGzG0kKlvsoeSD3Fjcvlvwcl1dIvnG4B1Nct9e9sE3wJ7VuU
 yoe2fErmETm0/RnWPY6bnSixkiclp/89dnZfSNWrPhv4Lq9z0rSmGRxqK64P1V/5JjiK
 AykOeYpjG1tsEMqgWPZoU0g1H2z4FGy/m80hsAMHxEnsAG3ZZTiXCd9uhecwBLSdP+Ge
 aPQf0GKd2e452GHDGRqAnuVoi9dXgWakDukmGosFfcWANjkm/pJJmDLasTSHY3Y5auUo
 RK1krKR0dTY/ODPpgJNTUw8x8OJ/LcyJQVBp8W6NEp/BJb2mt1/XxnSyV4tbIBtPxWc9
 lrBQ==
X-Gm-Message-State: AOAM532s+/S8CNeiVSwtAuFyo7rUvYl4Swk3vKpfm4srHU+UqRSg8mlg
 pdw+tXOvelfRRH+EQSbhnZh9ew==
X-Google-Smtp-Source: ABdhPJzagT929ndRY9I71kezYTJbV+uiZ4kTVb4zf4B55/0+JigztoYvjxClbZ1ZrimoU/X1X9ZpBA==
X-Received: by 2002:adf:c182:: with SMTP id x2mr5612366wre.400.1599029948165; 
 Tue, 01 Sep 2020 23:59:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h6sm66345wmb.22.2020.09.01.23.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 23:59:07 -0700 (PDT)
Date: Wed, 2 Sep 2020 08:59:05 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove superfluous NULL check
Message-ID: <20200902065905.GG2352366@phenom.ffwll.local>
References: <20200902010645.26943-1-luben.tuikov@amd.com>
 <20200902010645.26943-4-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200902010645.26943-4-luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Xinhui.Pan@amd.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 01, 2020 at 09:06:45PM -0400, Luben Tuikov wrote:
> The DRM device is a static member of
> the amdgpu device structure and as such
> always exists, so long as the PCI and
> thus the amdgpu device exist.
> 
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

On this patch, but not the other two earlier in this series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c4900471beb0..6dcc256b9ebc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3471,9 +3471,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>  	struct drm_connector_list_iter iter;
>  	int r;
>  
> -	if (!dev)
> -		return -ENODEV;
> -
>  	adev = drm_to_adev(dev);
>  
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
> -- 
> 2.28.0.394.ge197136389
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
