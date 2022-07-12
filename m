Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2610C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850B394EF9;
	Tue, 12 Jul 2022 15:17:18 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B1494F06
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:17:17 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id v12so10496283edc.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=Ft2lQaCk2NQ8KfYJ8LAqUmwuolQN9Ck6exVznLEz4Kc=;
 b=SLTYO4mJPuYe9+TYfq1uyP3FSct80wsfVbrLF75Wnc5V3G8Tepwf/xOtLCY2WLfVYr
 9Gu7qNKx6LcZiCGYKoltDpJv7rqUPRiTsPUpv5oF9ndke70dF/euWkNMR/b8qNnMm+eq
 S8ygBrpVc/tlgqNtvm/2YphwXnpiwUgheMEZH689gky89a4w0daVf42fsan4LBwECblt
 03Zi1iJhfaWwA7bCMClhplYBhDtz57iHX2b83P4LTjaHkafWpk8Bi01doULgMoV39x5E
 gNdAHPerAHOFh/9tkZsueTw0AF/U04uws1eJhtcImSp8TsBAE+yneuqe/80PLKdFomFt
 1Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ft2lQaCk2NQ8KfYJ8LAqUmwuolQN9Ck6exVznLEz4Kc=;
 b=LRWjt/7s2DUmmygtg7+awPBX0eAXYWHN6cZG4oNBidA1CfUIXyb8w4IEaV0hxckh81
 jkfuKVJ/lg65QixJAzPvqiepHcrWMX0v99INTC40tv4gp8Cstb8RTSNqRcRNZo8IN7No
 9a2meEhEh3KdYnk+EVBRVBZo40FGaj0DesAU/266aupkshdpVUA9oREQr5DlorKsIhdD
 MLpuj0pxv8VJotx5dKQPaGgeBCRI0Eif5/LHJBKWtVbuCw7so5bYhwVOWV7gtC63dZ2F
 Ngj02LhawBlScmSZIJBysYS9xHF1GOLPPpOBv0SZbT6XQnWO6pSDBYkt+HxH6fjeWdOP
 +N0w==
X-Gm-Message-State: AJIora/h6hqbpAAdZehUEopOcFTXQSxAO8XTHMxx7yBl6++yo17jaAFr
 yHAn7KuYXUL3wBVNkfNPsaPLKAbxMEQ=
X-Google-Smtp-Source: AGRyM1uDbbP2n3eEVKIqQVJTQo2Rfa1etMvB2N6gCE8z1m9b8VG8QVdArmJ7kXCx1f9NdhfmEzQf9g==
X-Received: by 2002:a05:6402:5114:b0:43a:d072:83b9 with SMTP id
 m20-20020a056402511400b0043ad07283b9mr17839275edd.260.1657639036465; 
 Tue, 12 Jul 2022 08:17:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:cf35:dc88:25dd:1187?
 ([2a02:908:1256:79a0:cf35:dc88:25dd:1187])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a50ff11000000b0043af8007e7fsm39654edu.3.2022.07.12.08.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 08:17:15 -0700 (PDT)
Message-ID: <6c6cb19c-2169-3372-556c-b6b4bab1dc43@gmail.com>
Date: Tue, 12 Jul 2022 17:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] drm/amdgpu/gpuvm: remove unused variable
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712151348.3047904-1-alexander.deucher@amd.com>
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

Am 12.07.22 um 17:13 schrieb Alex Deucher:
> Not used so drop it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches #1-#3 are Reviewed-by: Christian König <christian.koenig@amd.com>

No idea what to do about patch #4, somebody more familiar with this 
needs to take a look.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4effee12a4ac..d1657de5f875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1576,7 +1576,6 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   				    struct amdgpu_vm *vm)
>   {
>   	struct amdkfd_process_info *process_info = vm->process_info;
> -	struct amdgpu_bo *pd = vm->root.bo;
>   
>   	if (!process_info)
>   		return;

