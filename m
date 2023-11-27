Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80494C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 18:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF1D10E301;
	Mon, 27 Nov 2023 18:46:08 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B538810E301
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 18:46:06 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3316d09c645so3040521f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701110765; x=1701715565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WISL0fjqdzOQYWQ6Ll7YK4vcayWymKsVRYuQWYUu9rA=;
 b=lyNt5O/5/PzVln9acb4sV7SHkD4o7+JXICCcHKnBn6vv/ShvG/txQC8SVgrb2UiNE0
 W8sJww2sC96lJjf71yD/aTX0TUk2dHD53eHTSrdtIEmpWqOGk4wBCQiUxgVrFKEexSWq
 tp1xvzdciK7v9PK8mimaV3tzJSEe2Qwy4t/ji23LOmIp5I8m+yBi+hNjY7x0YDBkjdvM
 Tg0ftZ9dBjsVa80yXd5sczHFiHqmrUFzk02K05JLisFTQhD/H67doaxO8xfCfrYwfh9S
 QHrNlQt0DeVsE7qe1krNIMldKC4ztanAWHzMaZvlc9KApeolqwYHqQbj92wXoak8rgrp
 RIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701110765; x=1701715565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WISL0fjqdzOQYWQ6Ll7YK4vcayWymKsVRYuQWYUu9rA=;
 b=gSz8D/gOPiW9bHJ7VMkB+OENOyE8sbCang93P7oPZPDORDu/ftHzgTehW7Qdio6DQ7
 DCYD4QeLIDoKv0Ka26qJFBCPwmSc3DlBr+9/9nl8L5va35BkPSBsxQvj2NXo/UxZEWlv
 l8wHg8T2PZHIREvXU3I4QGa5yYSJKIYDIpoj7wRNB+MBeOvweUClYd8LNWKnMo+BDzJl
 krSGh8sqd4/T12eIKRZlzTgRfid114I7yUCu6EokgEyfjU7O/jsoVtMnWF0r+P9laXs/
 jwLM01Yb48igdMCOXM27tkJtGzTpDcwvjjlGxa9kSQ9tktWCwbqy40bhaHuvGrNafe59
 Kj4g==
X-Gm-Message-State: AOJu0YyRUJu5QPAuhiFqk5yk/d0GBj51Xt9Xih7v9aM6+/TbDRduaTJk
 vn8Cxhn7c9kqSsDklNIodpA=
X-Google-Smtp-Source: AGHT+IGlfVr24ffN7s5DgP+qlFqa0ws1WfikM6Y5c6osTTALxunGHh9rqgETOVdaY9r/UpkzN8k0CQ==
X-Received: by 2002:adf:b1d5:0:b0:332:c441:70aa with SMTP id
 r21-20020adfb1d5000000b00332c44170aamr9922419wra.26.1701110764840; 
 Mon, 27 Nov 2023 10:46:04 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a0560001b0900b003143867d2ebsm12799909wrz.63.2023.11.27.10.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 10:46:04 -0800 (PST)
Message-ID: <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
Date: Mon, 27 Nov 2023 19:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231127182945.1109556-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.11.23 um 19:29 schrieb Lijo Lazar:
> The return value is uniinitialized if ras context is NULL.
>
> Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to ras)
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1a8668a63e67..f6b47ebce9d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>   int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -	int ret;
> +	int ret = 0;

That's usually considered very bad coding style and complained about by 
automated checkers.

Instead explicitly set the return value in the code paths not actually 
setting it.

Regards,
Christian.

>   
>   	if (con) {
>   		ret = amdgpu_mca_smu_set_debug_mode(adev, enable);

