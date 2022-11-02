Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA2C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 15:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3950710E4AE;
	Wed,  2 Nov 2022 15:28:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE8010E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:28:38 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 ja4-20020a05600c556400b003cf6e77f89cso2540270wmb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0gUGsitZ6DPztdnuk5Kl8EruKu0dxceUwd7N7BmKHk=;
 b=UmIAC8wEJkm8wdbgfjf1BJnZXrYWJgOVXnWgVC7GfwiH7JiW/jWPJJgiEKBsIFtVyL
 f/7mnryhcfclJSCak4UvqCWY8u1A8onP8qo3jcDIZfjAIOO3qxQP9+t/ECmy/SLSawMB
 HMwV8bsVqa1pHYO+mawG+A8DQ0XAwznfh8RAC9rd9herJT9lo3sXQMBXFBt9K8Cj2oWV
 vsgkhIcQwUxWw0TTzSU30jhjyVZ9JKMpap7wI6bPAf9QKDtsGEPAzEt2fxQYBqcF/U7E
 cKNTzWn7uBMBra9CPQk5EyjyY6Nh37QJRlrXRBhg79jiUCt8tbT8GBYRXO+tMS62t8Jv
 Tm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0gUGsitZ6DPztdnuk5Kl8EruKu0dxceUwd7N7BmKHk=;
 b=iZ1CvKzsGPOZFD6X9qUfix8suKGUn0VSj9isIOnFOsSziReo0NU1ZRzz0DiK5DiPA5
 e8bqNVQZrVJgob8n59k7k+3vwsXXHzRI2c4fysHbaKi/jOpXduRc0hh5HeMdDbQlOVhz
 Cykyync4nG9hgHHgxQlGilvAqN9QX8lzPJdkYeeLHe2Dyeyg3CrHbTgy7ikLwIlo/mfs
 yOUxpiQ0gdjO3WQWRIsaugZPHInzNWCkcg/YJu6UmD08MFuMuuguhlCaYQXnabDWohSi
 uWsUoWJ1KtBjL2133IVyLoy5Hcu54SzOjpkEMnQF21O/cMqaOM9ALp/hJ4cLUNrcyl7t
 TRFA==
X-Gm-Message-State: ACrzQf2aze64zDEhorYfVYJtKwowukEYUkNRbplPPhWrseF0WcRg8BOr
 P3QeJ4GoDYRk/2755ijUFXsSV+Y/jIo=
X-Google-Smtp-Source: AMsMyM5aymmEfb8xyMBNDIdF6iNcVC6sF5B+6VHK5TEtJYNdT/2OyYIV7/bmshdsXv7jziv2ud9DMw==
X-Received: by 2002:a05:600c:3547:b0:3cf:7a9f:d6cd with SMTP id
 i7-20020a05600c354700b003cf7a9fd6cdmr8297998wmq.30.1667402917145; 
 Wed, 02 Nov 2022 08:28:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:7c81:2208:32f3:412e?
 ([2a02:908:1256:79a0:7c81:2208:32f3:412e])
 by smtp.gmail.com with ESMTPSA id
 dn12-20020a05600c654c00b003cf537ec2efsm2745357wmb.36.2022.11.02.08.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Nov 2022 08:28:36 -0700 (PDT)
Message-ID: <97315c55-499e-f0ee-4729-c054cc84543d@gmail.com>
Date: Wed, 2 Nov 2022 16:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx9: set gfx.funcs in early init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221102152333.553521-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221102152333.553521-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 02.11.22 um 16:23 schrieb Alex Deucher:
> So the callbacks are set before we use them.
>
> Fixes: 0c9646e1a043 ("drm/amdgpu: switch to select_se_sh wrapper for gfx v9_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 877521230529..5d23a0f03615 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1921,8 +1921,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
>   	u32 gb_addr_config;
>   	int err;
>   
> -	adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
> -
>   	switch (adev->ip_versions[GC_HWIP][0]) {
>   	case IP_VERSION(9, 0, 1):
>   		adev->gfx.config.max_hw_contexts = 8;
> @@ -4541,6 +4539,8 @@ static int gfx_v9_0_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
> +
>   	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
>   	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>   		adev->gfx.num_gfx_rings = 0;

