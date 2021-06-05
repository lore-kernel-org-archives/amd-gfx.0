Return-Path: <SRS0=4Bis=K7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320AC47082
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Jun 2021 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377BC613AE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Jun 2021 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377BC613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BC26E061;
	Sat,  5 Jun 2021 10:49:20 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701976E061
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Jun 2021 10:49:19 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id dj8so14084797edb.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Jun 2021 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=b2CFSQidDzo8s10masgDUHLMxGazLThCMxSEH6fe4cE=;
 b=Vqux8L073mreg2h0ci/6HolXh05Q8p+JIs58UBsQ53VlIQx2wToldyf+BS/pxOt5WD
 wQGqaZ/V54+Vu+CKhNHs7BD2cfBZK+CU7TQw6LK1P3tsrWKTP9kA8zYLx2RIyPcaMlo4
 u8q6gGdXkrRUZEam+VzqHsM20p+jj9TOH4IdgPPDkWLC9fjw/8EZpfl5nUi6EzXfdOMW
 0IMb3r8syyDoDhPTamZNrvXxh4xw4sURiv+ddOCeCYa5FNYQXBmf6PTBBWBHU01RgrkA
 JLFCq6aMfONPWgwptqFRFFf2U/X+uzHlLYvAtGKzkbmpHnC7sIMULS+IAmSefGSGEsCv
 rIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b2CFSQidDzo8s10masgDUHLMxGazLThCMxSEH6fe4cE=;
 b=Gg0kB2kKV/3J4MOzHafRCHaHVdoQegTh658k82j8mqYfJUwRKL+hTVg3yHj09Zmih6
 dhHtc31CznowVyTKvrMnWN6FCCBA4FZ+RsL+90bniEg+kftZfbcbFP+3Rorrv57hxD0u
 9PJ6gzw0DMqD4cSGGfOVZod/NTwz4gQ6ANWLJpk29ETKPSCkZ8G+a46I6GLp/s37Mdpm
 wr7MKI7qv3z6daow+NV9eEOQUQhAlg54W+h8Qp2dQnWk5XVeZQ1aBsmESrRXRd+VIPhe
 gTdEOQ2mWI6ToQG6GjqaBoSUHwGjktqtVaDUHUSAop8vWDNMMKQI+nJseJMzlNS7QyFQ
 Lpgw==
X-Gm-Message-State: AOAM533VLkCD6bECA9CzAlHMLzQ0T0OqCiYSvYoogIDYuFqdGMMZ/AYC
 Df33Pa3mv2EL/b5tc5lp/8M=
X-Google-Smtp-Source: ABdhPJwSCYY5OLScRM5jtIYJkuqwJRYNpHS5iRjUt+h0poVOJe8qX7U7rGrxdVA0zYYhLNk79LAPHQ==
X-Received: by 2002:a50:fe18:: with SMTP id f24mr9710138edt.271.1622890158156; 
 Sat, 05 Jun 2021 03:49:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8946:fd9b:10c9:6ef0?
 ([2a02:908:1252:fb60:8946:fd9b:10c9:6ef0])
 by smtp.gmail.com with ESMTPSA id w14sm4539517edj.6.2021.06.05.03.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Jun 2021 03:49:17 -0700 (PDT)
Subject: Re: [PATCH] drm/amdkfd: pages_addr offset must be 0 for system range
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com
References: <20210604231039.27518-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8b0dd803-642a-735e-2785-b711749d58c3@gmail.com>
Date: Sat, 5 Jun 2021 12:49:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210604231039.27518-1-Philip.Yang@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.06.21 um 01:10 schrieb Philip Yang:
> prange->offset is for VRAM range mm_nodes, if multiple ranges share same
> mm_nodes, migrate range back to VRAM will reuse the VRAM at offset of
> the same mm_nodes. For system memory pages_addr array, the offset is
> always 0, otherwise, update GPU mapping will use incorrect system memory
> page, and cause system memory corruption.

Nirmoy and I also stumbled over a similar problem which we are going to 
fix inside the VM code instead.

Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2901e7a993e..0f18bd0dc64e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1153,7 +1153,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	prange->mapping.start = prange->start;
>   	prange->mapping.last = prange->last;
> -	prange->mapping.offset = prange->offset;
> +	prange->mapping.offset = prange->ttm_res ? prange->offset : 0;
>   	pte_flags = svm_range_get_pte_flags(adev, prange);
>   
>   	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
