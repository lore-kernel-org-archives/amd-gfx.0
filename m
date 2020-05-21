Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7051CC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 13:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E02206B6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 13:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey/V17yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E02206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79536E21A;
	Thu, 21 May 2020 13:51:02 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AA66E21A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 13:51:01 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id k19so6690938edv.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=YNkap3wFHKVkXHAGlopCqe5B9SpqJlIq1kSkQk3Y5/4=;
 b=ey/V17yEQJ05wMWtEeYr1XTQb1DdZ6QGMr0grkTHr1wUQyELFQNbsGJ3oFb/vlryjP
 u/rXr2/WOY9kJC9wcBxNMa8nB9GOH3oxppeb1jqun5Jl4xUlcw/FSNuRq8D+O5ccFZhX
 syQtD8VAwSChqfG2vQHXrsUuAWF9YfW5z8A/Fl+huBkuYegcXSg+lppbWQwAcyujSDmn
 8tCRBQQ6FGso2tEujfqYR3m5Qi3zVRflCl20Bj9RRtqXe3jhD3eKTvfiXubtNLyUci8L
 mVxuKUBV89An1rRxsAPCHJvA1Pwo5bLduhLlEh5LjET39AnxZEuJnKrDawU5NBru6KcS
 j93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=YNkap3wFHKVkXHAGlopCqe5B9SpqJlIq1kSkQk3Y5/4=;
 b=c+5qcYQCC1UXShp/nXVhdOTAB3hKzsLV9tmEFXU/pQjggRoev4xN+UWvQFXCd7kata
 i4tEnH3H+qMBYAqS9mGxeksuYIxMMI9iZSIdU3GXfrik+SA9aWBrPqq9i2ZYr67r/xZj
 +oZIzuWk/0x1XQ/nN5Xxaw2KzhH83MxW8qB1W1P6A/7bsDKHZ3CvdVq9uFEhSD9H2C/i
 c2Q2WLaRQI/ahTF7sM2FMHJLU8yf0LlSwVHv99uE7k+iFNu+f3LVmz4bFCVqz15FrtYl
 f7929LaMdusl8qKDT1931vqegXowPYw1cMBWEqo6c36/km+4kIxn1u7gfBqJ0thgBRSl
 zreA==
X-Gm-Message-State: AOAM533yr6kYOGjlzBdCsT3pExePodoYWsETt3E1vVr/itZtdVkUNbvl
 2rkYWij9mAm44o3mhyZ2UtQcLUr2
X-Google-Smtp-Source: ABdhPJwKw/+HrpqTDDvfMrpReRWDY38DWtSMhMxmkUuq9ypmJCHVJTIW6Fqc1d2wtLo7UEW092tKpA==
X-Received: by 2002:a05:6402:3185:: with SMTP id
 di5mr7804489edb.330.1590069060203; 
 Thu, 21 May 2020 06:51:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id qp13sm5122882ejb.8.2020.05.21.06.50.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2020 06:50:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Sync with VM root BO when switching VM to
 CPU update mode
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200520225159.977-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <14ac63e1-a212-7540-fe65-523451bf6a89@gmail.com>
Date: Thu, 21 May 2020 15:50:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200520225159.977-1-Felix.Kuehling@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: jay.cornwall@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.05.20 um 00:51 schrieb Felix Kuehling:
> This fixes an intermittent bug where a root PD clear operation still in
> progress could overwrite a PDE update done by the CPU, resulting in a
> VM fault.

Mhm, maybe better add this to amdgpu_vm_cpu_prepare().

This way we could (in theory) switch between CPU and SDMA based updates 
on the fly elsewhere as well.

Christian.

>
> Fixes: 108b4d928c03 ("drm/amd/amdgpu: Update VM function pointer")
> Reported-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Tested-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 414a0b1c2e5a..7417754e9141 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3000,10 +3000,17 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
>   		  "CPU update of VM recommended only for large BAR system\n");
>   
> -	if (vm->use_cpu_for_update)
> +	if (vm->use_cpu_for_update) {
> +		/* Sync with last SDMA update/clear before switching to CPU */
> +		r = amdgpu_bo_sync_wait(vm->root.base.bo,
> +					AMDGPU_FENCE_OWNER_UNDEFINED, true);
> +		if (r)
> +			goto free_idr;
> +
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
> -	else
> +	} else {
>   		vm->update_funcs = &amdgpu_vm_sdma_funcs;
> +	}
>   	dma_fence_put(vm->last_update);
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
