Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F9CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CFD65013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CFD65013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E926EBA1;
	Fri,  5 Mar 2021 15:11:43 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB83F6EBA1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:11:42 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id v64so1931821qtd.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 07:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RHceeGHUErPdcQ7FwCJlgb3iXC7Vq4b2/48c/764FRk=;
 b=TVs1w4LfYJ2waufcvymDaBYCDgYJu82a8rw2xVYeQqNESm24k+eK75rH9cQtG3xX7o
 KoRgR80ud1fLrMVltim8ZWjLGfmYHn+Gf8njJDMA5c95a5VuDJy/Tc8Qkj/5sSm9bQ4D
 Y82im6SzkuyP40LJrJjQJjJIZtoxfNjbT5Y+umTK1OsSlXU//5oOgl3xkGGZMun7zewo
 rYacpAu/wypBiYbZ3o8zHaNlNA4WJLnAyGLOVAWJlqni2kMuE2/QC9opexNaHgagkJNk
 pSdl35VkkvJWj+kwVtqjOoxv50WGq+oPOqhvOiE8jQO7Me7qFzKH2MU9Jn7UIMHjA6ye
 AdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RHceeGHUErPdcQ7FwCJlgb3iXC7Vq4b2/48c/764FRk=;
 b=gFxwjNHuUDDvDiPA5cC8dgyvq9iDhJUpurOplqbU58keQypf+5JJluwO3b1PEnQUti
 I6pGeEyzWiLf7LcPJm0Rl+t5F/ZkjL7di7JXKu4j05vNgzK9x3PsmbiZg6wqsGHDql+G
 0K9HrSbayNiasqgkceMxk++ZUTJr1QJHSW/fItY7thxkGvCGTSdQKnq1X/1R/BXL7H2Z
 JidpKYogpNC3Is/G6G+4mvuw7kXIyzYOjslemUqHk0fj07KbV52sYiOKOvW2yzmM9++f
 z2Y5NfC8Ro7JI2U7AjLAG+6cMRGa+LgZvqtdO+vZ4vP3KxjtQLXfVbWy7GKFak7Br4v0
 8YRQ==
X-Gm-Message-State: AOAM5327nvTQsOtO1oDEBRkcCB9bKa/mnux/Ig18OB0dzyGCeVPtk82t
 PUR6PBSrmcAU9EyUotCQmwsyslEbdS4+Jg==
X-Google-Smtp-Source: ABdhPJxLUxFpAd/sV2uUOI8kU+T87NXbYUG/QdWsJLi6cjT2MRaIJErBQtXb5gSNJHosRIcdgJtstg==
X-Received: by 2002:ac8:4e8f:: with SMTP id 15mr9123309qtp.317.1614957102031; 
 Fri, 05 Mar 2021 07:11:42 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id w59sm2048295qtd.29.2021.03.05.07.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 07:11:41 -0800 (PST)
Subject: Re: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0d083697-b194-99ac-71b5-866d2974a6a8@gmail.com>
Date: Fri, 5 Mar 2021 16:11:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305143532.5936-3-nirmoy.das@amd.com>
Content-Language: en-US
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We might need to use this for the KFD as well.

Christian.

Am 05.03.21 um 15:35 schrieb Nirmoy Das:
> GEM objects encapsulate amdgpu_bo for userspace applications.
> Now that we have a new amdgpu_bo_user subclass for that purpose,
> let's use that instead.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8e9b8a6e6ef0..9d2b55eb31c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -54,6 +54,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   			     struct drm_gem_object **obj)
>   {
>   	struct amdgpu_bo *bo;
> +	struct amdgpu_bo_user *ubo;
>   	struct amdgpu_bo_param bp;
>   	int r;
>   
> @@ -68,7 +69,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   retry:
>   	bp.flags = flags;
>   	bp.domain = initial_domain;
> -	r = amdgpu_bo_create(adev, &bp, &bo);
> +	r = amdgpu_bo_create_user(adev, &bp, &ubo);
>   	if (r) {
>   		if (r != -ERESTARTSYS) {
>   			if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> @@ -85,6 +86,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   		}
>   		return r;
>   	}
> +	bo = &ubo->bo;
>   	*obj = &bo->tbo.base;
>   
>   	return 0;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
