Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA9DC04A6A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 09:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83E810E0F5;
	Thu,  3 Aug 2023 09:59:25 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A45910E1EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 09:59:23 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso7669255e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Aug 2023 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691056762; x=1691661562;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCAqhvoC3w09/L9KLPF1IHqw+257jwjEFUKcBuqpeBE=;
 b=X2zmTVOJanfOW92qwlJnPyY7bJ7tKWbhwInomFPh6yd5H7gHfu+iCuIMFX/B99r1I9
 Ir4NzFBrTpNmwM3X2vifkW4Nl+LcKKeOmNhGNpsrnSjXw5nhMn2eyYQGXckeeKKixtIw
 eb64emHHX8HSZv5draJPg2UGP2Cu7mJ672y1r8hAT5YVeFB4e2XAl8M1xvj/4dxJn01O
 VFY4t1WNIMAwNQjzXdC1h7NInEvrNMMCKLj4IWhOhHPtX0XdzKwCjOEcI6VlukyvKwle
 484wAPte5NrIvyqqANKIyncGya272mmPgv1ceOugPjSnYzgJ1dQ0umY8O2XWpdLrFmWC
 uCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691056762; x=1691661562;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCAqhvoC3w09/L9KLPF1IHqw+257jwjEFUKcBuqpeBE=;
 b=LXOsK4mlg56mv89U/vKDaa/O9J2TpaF0mLu4nJJvtfJe3R9hR8Flu8pNcxcXUeUCIO
 IruiOju4KomKVzm0LBRd9TlVmhenfyk1yfkSVhaHVqhBZNbhdgXw8hX9kaAJPkqkoRjb
 StxCwAXxm7Canut5vNDuF42T4+Snm3biIEt+1E7lfAF+pQPronzxt9YA1KkE0hkVj8/Y
 qwsMjj6Mkm44jEzK5d1lqZEH/oeZ3ydLlH5Rq0+zXPgGGDML/n8nLBDSGEuFcLB3p5y8
 he+7JlFmdXRznONaHwVAgSDqrIYuuQviz93FviOSMTdKJDNeMFWkO51TF6DnBmCdR8fo
 PQNQ==
X-Gm-Message-State: ABy/qLYNOeo2C0ayGuc+8Kv6P4TVXxC3v8DElNQxqh+YlqIYEqfkmuNU
 Wq3MwmpE8NzhwIxLVYuLBOiLwAZWfHc=
X-Google-Smtp-Source: APBJJlFsucJPOpTtudVDGcEepRvmDqMzHM/HuDf2vQ870dWGYPpsldEGCG/B/wTwtStn+sn3eATrIg==
X-Received: by 2002:a05:600c:204f:b0:3fe:108d:7f88 with SMTP id
 p15-20020a05600c204f00b003fe108d7f88mr7014952wmg.36.1691056761744; 
 Thu, 03 Aug 2023 02:59:21 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1569:4500:df4b:1bb:b0ec:33a0?
 ([2a00:e180:1569:4500:df4b:1bb:b0ec:33a0])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fe29f6b61bsm3827503wml.46.2023.08.03.02.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 02:59:21 -0700 (PDT)
Message-ID: <96e86dc6-1bbe-972f-88b2-7b0c5c1be073@gmail.com>
Date: Thu, 3 Aug 2023 11:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230728152248.3290911-1-alexander.deucher@amd.com>
 <DM5PR12MB2469E784A786056B85067B85F105A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB2469E784A786056B85067B85F105A@DM5PR12MB2469.namprd12.prod.outlook.com>
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

Am 31.07.23 um 03:41 schrieb Chen, Guchun:
> [Public]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>> Deucher
>> Sent: Friday, July 28, 2023 11:23 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
>>
>> Since the gang_size check is outside of chunk parsing loop, we need to reset i
>> before we free the chunk data.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Might have already been landed, but the patch is Reviewed-by: Christian 
König <christian.koenig@amd.com>

Regards,
Christian.

>
> Regards,
> Guchun
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 040f4cb6ab2d0..fb78a8f475879 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -295,7 +295,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser
>> *p,
>>
>>        if (!p->gang_size) {
>>                ret = -EINVAL;
>> -             goto free_partial_kdata;
>> +             goto free_all_kdata;
>>        }
>>
>>        for (i = 0; i < p->gang_size; ++i) {
>> --
>> 2.41.0

