Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 18:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF6A10E300;
	Wed, 15 Mar 2023 18:44:19 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C1810E300
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 18:44:18 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 p23-20020a05600c1d9700b003ead4835046so2434212wms.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678905857;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5+XVEd/GPksSqa9h+P3xd0O4dNVychfSwwGKj3Qupc=;
 b=hwwylslzBP5A8r6nTvBYoYHA6hSdvhMes4Il3TIJv2G1qzkndElGIsph/wHCG1/P3Z
 NwmXTd2uwxXkERXQnCWIsZLyZEE+rQ2a4kHD42lyy+J9SBs5aHzX0GUY+yXt4HaVzVvD
 WT1L/fKWU61FkNgPHNJsSa4o78fRyWg4Se6o1G640hvAcgyCzyL3SCN/fSnwN/HxbIeq
 y+Na7nK92MV72AxqIChflfixq9rcCS7C44FbnZkhHVL6ScC0O5c1HuPCrWrA4Pfcq1YD
 qkgAzNJx3YVPYytZcbYHR5eqIYhME7vf52VO8BJpfg8EmHBczAWjXGVUtqKDxiwu1nzh
 y9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678905857;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5+XVEd/GPksSqa9h+P3xd0O4dNVychfSwwGKj3Qupc=;
 b=mSJ+EIBghp3wlGbFtV/FhT1gj/6eL1cdGDHNa/h5SFpZF9DeibyyGuwcYUX0Nanyil
 v1opxvgRO0obTaxxro4oWfVS2v6LepMdSF/mN5cDkYaQcPbBTp0Pfey8Pcny9RnTiV2l
 QgImBdIi+5a3tYsk+yIFx8RfdYuh6uw77dQ/q4TP3oH8JN7J8fpENO1sf2cZz70gzW4f
 PpZx1AdkSBmOHJ+zEbJbiGHHewSIYS0P7wVjK9zrc8ETa/Yjz+jqi8RMBlGDQAzqBMxH
 pj2BxPIFdCaCAnFc7Kiwe3CsKpUvyhf7fSXIrwGHnIAGlfmFnB3cAEXRtr9nCFNMPJok
 tv8w==
X-Gm-Message-State: AO0yUKXiRdtwP71aM6nnCtfHe7Fh35VDc2QyJNdZouZTdbbN0mWm5Rsa
 OvhXbDrjAQDywfYNZpVn2OSAWGJlRLM=
X-Google-Smtp-Source: AK7set83p9TvvTvcLkVB12G7wx6aFs/50iHFlYAnBMTFRsPkzYcUfjbRjS+7tDE5xGPMz8hL1r0q4g==
X-Received: by 2002:a05:600c:4587:b0:3df:e468:17dc with SMTP id
 r7-20020a05600c458700b003dfe46817dcmr18251913wmo.40.1678905856880; 
 Wed, 15 Mar 2023 11:44:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:bb77:36d:cdaf:f7f2?
 ([2a02:908:1256:79a0:bb77:36d:cdaf:f7f2])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a7bc394000000b003ed2433aa4asm2547057wmj.41.2023.03.15.11.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Mar 2023 11:44:16 -0700 (PDT)
Message-ID: <06de253c-edda-6de8-7fbf-a4ba51822076@gmail.com>
Date: Wed, 15 Mar 2023 19:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: drop the extra sign extension
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230315175329.3774178-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230315175329.3774178-1-alexander.deucher@amd.com>
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

Am 15.03.23 um 18:53 schrieb Alex Deucher:
> amdgpu_bo_gpu_offset_no_check() already calls
> amdgpu_gmc_sign_extend() so no need to call it twice.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 69e105fa41f6..ce2afd7e775b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -152,7 +152,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
>   
>   	src += p->num_dw_left * 4;
>   
> -	pe += amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
> +	pe += amdgpu_bo_gpu_offset_no_check(bo);
>   	trace_amdgpu_vm_copy_ptes(pe, src, count, p->immediate);
>   
>   	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
> @@ -179,7 +179,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
>   {
>   	struct amdgpu_ib *ib = p->job->ibs;
>   
> -	pe += amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
> +	pe += amdgpu_bo_gpu_offset_no_check(bo);
>   	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
>   	if (count < 3) {
>   		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,

