Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D76FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 15:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8609310E1E5;
	Tue, 13 Dec 2022 15:57:15 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7367510E1E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 15:57:09 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id qk9so37629091ejc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6w6T/atcHVLVmU9iiLyUKL3QDcJ+fiYG2hUHFphhpg=;
 b=Xrb7QjON5Di9+K6uGiYpVQfDh1g6ZelzgPuDJsT44eVBzoyltQxr4q2O9h+rM7oE+G
 p+6zWYDBtXyNs51ySZYoaqrcCyme2/zxNK9wCTHM2S5bqFiAGjg901OtdUZ0yugyAFeI
 6INsaAHUXekBbHZkKLpzeanO/zjQ/tffwAzGyydRZJMdG3hSkg8m+xq/D1INjICcr/df
 8fVkju2ii3CYFmrNE1RRhl3O+2ya/sbzv81djB7srKvGbMhzgGtVzd+X/4cE3XK5njry
 uzN9e1J95TGztOVQoPvdU2bEIU6gLjWg0piRVTJcDHuKdHiAS73b8aqw2myMiN/98kPP
 RSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6w6T/atcHVLVmU9iiLyUKL3QDcJ+fiYG2hUHFphhpg=;
 b=MCNIwrZnQOe/E/e1UDl/dxpo80tmFbrG8ieA+FN9+R1XSHyXLVeL2zDJwpQylxzvAH
 NPVDQIEkA5aaA3q5vWCfhCKKSLYZaounaOlIifLxUwJ/YFL2SPSHTEieKDFhnEN/RAhu
 0N/Te3QSEdNFjuD1mybVJPxsPrHdxuUEtYJpL+/6eSnDW/PwPerkWddUfRMk7mI/ylxJ
 cA0IkS1RAd+Ks33xVTPklvG283p9MAKRnbaIAsNl1rOOATBBq+tIT313hokPzEYaa9Pd
 7tCoUDbvcKCZdVlo2BMpX6Ff2dUjsJhBflJ5Y1h3PBUclsHcyyYe10rly54hhUAyI3mx
 O8Jg==
X-Gm-Message-State: ANoB5pmtQZBkCLFWMe6hfXpmHpkusY61itn0jjpieQtxJuO2axBJQ6by
 DdzRHl3XN9f4j3M3i7hCM8g=
X-Google-Smtp-Source: AA0mqf56jVfTH1XaWvnxRXZX8xzUxck/5FZaS8Nhhng9i2oOEn5EDy3Ea42rcZ1eda2kJOQaDeIcaw==
X-Received: by 2002:a17:906:bccf:b0:7c1:11fd:9b98 with SMTP id
 lw15-20020a170906bccf00b007c111fd9b98mr17998347ejb.27.1670947027815; 
 Tue, 13 Dec 2022 07:57:07 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:6dcb:76b9:10a7:813b?
 ([2a02:908:1256:79a0:6dcb:76b9:10a7:813b])
 by smtp.gmail.com with ESMTPSA id
 ko12-20020a170907986c00b00781be3e7badsm4742021ejc.53.2022.12.13.07.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Dec 2022 07:57:07 -0800 (PST)
Message-ID: <ddd80a3a-b393-41c2-c259-e4f9ec8facb5@gmail.com>
Date: Tue, 13 Dec 2022 16:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix double release KFD pasid
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221213154910.705-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221213154910.705-1-Philip.Yang@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.12.22 um 16:49 schrieb Philip Yang:
> If amdgpu_amdkfd_gpuvm_acquire_process_vm returns failed after vm is
> converted to KFD vm and vm->pasid set to KFD pasid, KFD will not
> take pdd->drm_file reference, as a result, drm close file handler maybe
> called to release the KFD pasid before KFD process destroy to release
> the same pasid and set vm->pasid to zero, this generates below WARNING
> backtrace and NULL pointer access.

Well NAK. If you fail after making the VM a compute VM the correct 
approach would be to drop this in the error handling again.

Since we don't need to reallocate anything that should also never fail.

Christian.

>
> For compute process, KFD manage pasid and drm close file handler should
> not release KFD pasid to avoid double release.
>
>   amdgpu: Failed to create process VM object
>
>   ida_free called for id=32770 which is not allocated.
>   WARNING: CPU: 57 PID: 72542 at ../lib/idr.c:522 ida_free+0x96/0x140
>   RIP: 0010:ida_free+0x96/0x140
>   Call Trace:
>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>    drm_file_free.part.13+0x216/0x270 [drm]
>    drm_close_helper.isra.14+0x60/0x70 [drm]
>    drm_release+0x6e/0xf0 [drm]
>    __fput+0xcc/0x280
>    ____fput+0xe/0x20
>    task_work_run+0x96/0xc0
>    do_exit+0x3d0/0xc10
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:ida_free+0x76/0x140
>   Call Trace:
>    amdgpu_pasid_free_delayed+0xe1/0x2a0 [amdgpu]
>    amdgpu_driver_postclose_kms+0x2d8/0x340 [amdgpu]
>    drm_file_free.part.13+0x216/0x270 [drm]
>    drm_close_helper.isra.14+0x60/0x70 [drm]
>    drm_release+0x6e/0xf0 [drm]
>    __fput+0xcc/0x280
>    ____fput+0xe/0x20
>    task_work_run+0x96/0xc0
>    do_exit+0x3d0/0xc10
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index efc0a13e9aea..bf444c3f6656 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1244,8 +1244,14 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   		amdgpu_bo_unreserve(adev->virt.csa_obj);
>   	}
>   
> -	pasid = fpriv->vm.pasid;
> +	if (fpriv->vm.is_compute_context)
> +		/* pasid managed by KFD is released when process is destroyed */
> +		pasid = 0;
> +	else
> +		pasid = fpriv->vm.pasid;
> +
>   	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
> +
>   	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
>   		amdgpu_vm_bo_del(adev, fpriv->prt_va);
>   		amdgpu_bo_unreserve(pd);

