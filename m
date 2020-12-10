Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A5C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 09:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201D823DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 09:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201D823DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C606EA4D;
	Thu, 10 Dec 2020 09:28:38 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51D86EA4D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 09:28:36 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id x16so6342613ejj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/LvCwjxLhDbDmEsSLFIMaslf2mN9m3g1WqWLIFfQewk=;
 b=CcKwlxlSnjoMs0EAmJpAaKmW12+7srZQiCs61GGC0bZzr3k8wIMzHeY59nqKS+6hB4
 qmJ1drvSMZn6AX8PMJjLPYA2WFjJXbtCX56UG3oVyXo9KqZrGDxxIzCdwIM2RXf32sLY
 QtHkMnAYWmVuswoX9JhqxqizSGJ2IcnSd6GHsETWfsrfhtICUlnaEVYnnzqE/AzyJT1w
 OYpCNOaxpIlbcNqu5zpXzRLA5QXnToBiPijjtSSQukpkNGEqgdkJp0cIpUDwjhc9fMJE
 7hrEw/z22ul3L+4fggak7GIN6JHa+1Gz5HG6t8oGmRRpjXWy4GaRuC9S/nZsoVIimAop
 Srjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=/LvCwjxLhDbDmEsSLFIMaslf2mN9m3g1WqWLIFfQewk=;
 b=rFkGy+P9MFxgOiVb/mAfrQeTeWe6bmX4nl/d4Z3ROZzmRW2OGHKmbX5edCrhPYf99a
 httnRJwssprWZULXBfPB9KubJ/TYQ+HfKev9y7XZNhF2BWbZWDrAGlNm6dNGqLugaBN9
 uFk74dKH/J5FbNXMrOF7Xv2inLMoNBEGSAZt6UxbDhqNU2WNErnp2hlD4aI/ljxHWaEo
 ectqbMjmW7Z7vyLgtC5v2CESoLciKlxclzSEdm/pkoeBw0Lk/xpVCaAzcn86tkimPlCm
 sk6TNncLOBZB3eovwwpO5SiGVbG2x5RxCOtLLz6u9oXdC3Jz6+LG0zIUl128lRsj2H4g
 k2Eg==
X-Gm-Message-State: AOAM533ZTdC159zuNk0XehISeqU7VFx/bTT6vhLr+5rGEHyuK7bTGM32
 boDhFJw3mfyZnfy0OQz6Nso=
X-Google-Smtp-Source: ABdhPJxU3qdQm5gmaLWikPULYqqXpJLNHtF0S21Nme6ZPFurWgTGIP2tlhuLTpnqE4wjhUDV0cEHhQ==
X-Received: by 2002:a17:906:7fca:: with SMTP id
 r10mr5640439ejs.24.1607592515608; 
 Thu, 10 Dec 2020 01:28:35 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q26sm3820231ejt.73.2020.12.10.01.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 01:28:35 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
To: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
 <75590f2b-019e-b6d3-7a8e-be11e3564f57@amd.com>
 <BYAPR12MB29677B831AC49217B288D20393CB0@BYAPR12MB2967.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <379bccc0-2f1a-722c-a8d3-cc06079f0985@gmail.com>
Date: Thu, 10 Dec 2020 10:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB29677B831AC49217B288D20393CB0@BYAPR12MB2967.namprd12.prod.outlook.com>
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Cheng,

well with whom you discussed that? Such discussions should happen on the 
mailing list and at minimum include Alex and me.

Anyway as discussed before this is not acceptable. We already discussed 
this years ago and the behavior is fixed and not changeable.

Regards,
Christian.

Am 10.12.20 um 03:25 schrieb Liu, Cheng Zhe:
> [AMD Public Use]
>
> Yeah, we discussed this issue again. We think it's better UMD make some changes instead of changing in KMD. If FLR happened, it's OK for UMD create new context and continue to submit jobs.
> However, if BACO or mode 1 reset happens, of course UMD could also submit jobs, but these jobs can't use any resource create before the reset, including page table.
> Because all the contents in VRAM has lost after BACO or mode 1 reset, which including APP's buffer.
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, December 9, 2020 6:06 PM
> To: Liu, Cheng Zhe <ChengZhe.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
>
> Am 09.12.20 um 10:46 schrieb Liu ChengZhe:
>> If CS init return -ECANCELED, UMD will free and create new context.
>> Job in this new context could conitnue exexcuting. In the case of BACO
>> or mode 1, we can't allow this happpen. Because VRAM has lost after
>> whole gpu reset, the job can't guarantee to succeed.
> NAK, this is intentional.
>
> When ECANCELED is returned UMD should create new context after a GPU reset to get back into an usable state and continue to submit jobs.
>
> Regards,
> Christian.
>
>> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 9 +++++++--
>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 85e48c29a57c..2a98f58134ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -120,6 +120,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>    	uint64_t *chunk_array;
>>    	unsigned size, num_ibs = 0;
>>    	uint32_t uf_offset = 0;
>> +	uint32_t vramlost_count = 0;
>>    	int i;
>>    	int ret;
>>    
>> @@ -140,7 +141,11 @@ static int amdgpu_cs_parser_init(struct
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>>    
>>    	/* skip guilty context job */
>>    	if (atomic_read(&p->ctx->guilty) == 1) {
>> -		ret = -ECANCELED;
>> +		vramlost_count = atomic_read(&p->adev->vram_lost_counter);
>> +		if (p->ctx->vram_lost_counter != vramlost_count)
>> +			ret = -EINVAL;
>> +		else
>> +			ret = -ECANCELED;
>>    		goto free_chunk;
>>    	}
>>    
>> @@ -246,7 +251,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>>    		goto free_all_kdata;
>>    
>>    	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
>> -		ret = -ECANCELED;
>> +		ret = -EINVAL;
>>    		goto free_all_kdata;
>>    	}
>>    
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
