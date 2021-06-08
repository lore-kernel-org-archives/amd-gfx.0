Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38BC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AF461358
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 11:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AF461358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43276E141;
	Tue,  8 Jun 2021 11:42:32 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027326E141
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 11:42:31 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 f16-20020a05600c1550b02901b00c1be4abso1729141wmg.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Jun 2021 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pEXiNor2OkcDPOIgILDxh4JoAx3FjZKdhtlyfRe70xM=;
 b=naiTma6PG5D+S2utOMbotT2/vT4dhHO9MLWE6Xxtp9eoQCpB52TRKNZy0CYiPqC7KR
 RZLkEsUj+3gVZAvtlMmOFfExLn8fVb0R3RXvBgIiUpzgmRVvjy3hfCWHPQYzFTDirO0J
 9GK/wUiZqh2EolxtrAqBc/C6CJQU1YVe3RhapYbgGhUKJW478kwp9POdD5j+Tyv1Sl0f
 o9pVAlBOyhHuFJUT5FNn4EJIWtRDEhvr7ZiawLtJetLRraL677Sc98vKRuZae3MxEfls
 ql7AH8vABsaraGmAmWVo8opYbnEKLEuChkzD7ZwaiD9NLR/HW2Szw5LnFZVBz2XCEZVQ
 3hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pEXiNor2OkcDPOIgILDxh4JoAx3FjZKdhtlyfRe70xM=;
 b=D3ud1RZ1Oc4benAgTEulhnXzut6fZQe5xXOYos00GgIEr4MnZU+5bCh4oA+RehstRU
 OMt+SOorG0FdssVJk5b8t+z5X/QjeZ5l16ghyJ1Afvnoy77EtahIxHRYQhuZQIm5t6/X
 EiZ2ZLyifSDdcZV3UKcp4dzYwb3BxH66wI5IalOAPfX9glrLkf9uXNDCJqscTeJCgsH+
 ffovAfM7cQKfL2JUMwDQNrYAwgxNgzPc6GNDs6l25tLGc4sR/Sz9ykczBfZEwoThpo3I
 2HfGBoYgsclTGHbaPLMoDnjUA8LWPNsdAwmzDITHJ7UAibWegReCWAtoaL1CSxDJyuWT
 D1Dg==
X-Gm-Message-State: AOAM530Ehn6IqxNaFvwm5siG40mmEJuhWqiIFKYt/r7o6CMBzpr8I7h5
 KLYRJtN6MLdn8O6khwL156c=
X-Google-Smtp-Source: ABdhPJweNRrSGUlvj8JyaAmdXaORU2CzNjYX48mnOVyPHqnTfs+FeHa7D/vDHtMiknMk2y9UKAbh2g==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr3914159wml.115.1623152550588; 
 Tue, 08 Jun 2021 04:42:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762?
 ([2a02:908:1252:fb60:197a:8536:afbe:3762])
 by smtp.gmail.com with ESMTPSA id l20sm1821587wmq.3.2021.06.08.04.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 04:42:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] drm/amdkfd: use allowed domain for vmbo validation
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608112714.50475-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <915174f0-0341-6465-5775-4220de577720@gmail.com>
Date: Tue, 8 Jun 2021 13:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608112714.50475-1-nirmoy.das@amd.com>
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 08.06.21 um 13:27 schrieb Nirmoy Das:
> Fixes handling when page tables are in system memory.
>
> v2: remove unwanted variable.
>      change amdgpu_amdkfd_validate instead of amdgpu_amdkfd_bo_validate.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d6cb7cf76623..021f25085760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -348,11 +348,9 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   	return ret;
>   }
>
> -static int amdgpu_amdkfd_validate(void *param, struct amdgpu_bo *bo)
> +static int amdgpu_amdkfd_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
>   {
> -	struct amdgpu_vm_parser *p = param;

The structure define of amdgpu_vm_parser isn't used any more if we drop 
this as well, isn't it?

Christian.

> -
> -	return amdgpu_amdkfd_bo_validate(bo, p->domain, p->wait);
> +	return amdgpu_amdkfd_bo_validate(bo, bo->allowed_domains, false);
>   }
>
>   /* vm_validate_pt_pd_bos - Validate page table and directory BOs
> @@ -366,20 +364,15 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>   {
>   	struct amdgpu_bo *pd = vm->root.base.bo;
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
> -	struct amdgpu_vm_parser param;
>   	int ret;
>
> -	param.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -	param.wait = false;
> -
> -	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate,
> -					&param);
> +	ret = amdgpu_vm_validate_pt_bos(adev, vm, amdgpu_amdkfd_validate_vm_bo, NULL);
>   	if (ret) {
>   		pr_err("failed to validate PT BOs\n");
>   		return ret;
>   	}
>
> -	ret = amdgpu_amdkfd_validate(&param, pd);
> +	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
>   	if (ret) {
>   		pr_err("failed to validate PD\n");
>   		return ret;
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
