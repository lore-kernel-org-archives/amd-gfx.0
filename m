Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4498C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 07:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337C789DFC;
	Fri, 14 Jan 2022 07:19:37 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DC689CDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 07:19:36 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id o3so14010948wrh.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 23:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pYqZj4plggGmDD2/nEV2qW8LJqScMksf5F4zcTnOWuo=;
 b=RVECIgIORxkvwPpLdlDSCvSdI6qKs3LxDIO97uXpX+2Ip8Fac0b751qZ8JIsiS3RLB
 5/EDzMwBRe7Zk+qjQDi45AdX2oy+hxU3kelXvVLq7sc8KhnFu4gsovRSqUjIOmR4d9OL
 JHTCnbduCGEnc28USw+sTlA7XnmI97YixJOCm/BgzOjWhdyq32PraWseFKC9YJ43/uZd
 RUNZ8TTs2zAiPbsU14GKxe7S8qX6wjAk3VIfwxSdIplwFYjgcQpkRVw48FMoMdvxaCpU
 8iz7XVCCbWKTQRCWd1tq4D7PKFgmTKXphq7VlqgAG7om9S91UExqsEyD+HkO+5Ecx0P7
 xFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pYqZj4plggGmDD2/nEV2qW8LJqScMksf5F4zcTnOWuo=;
 b=i4EGgW379RJPakKw4BhQO6Owe4xfO5WagZkr+A9uxEu+JoyJi4VDK4/aOSOvWMZ807
 Y8GpDo75OdtMXWzxUA4Z+oFprd32CailAgYtwDgxgU2vTflP3+aKiSKndFeaZVD0bUW5
 5WJrfCJeaIj9euzGd40H5onX1MU9de5gGdBmU3c7vZLEEjhUieiYJM5KGiOVQlmAhoO0
 /Tt1p67gxE0ouxrYY1KOg6h0TCtnZBIYlBzojyhWF4zHT80cMqNZ7Krs3O4vfNGSYmGV
 Lz/98fWqxU875BzwTBRS+Ev+FqDMWtnvNa6wukMuzhXZJon7PpSgYRSWYh1BlpgIgBOM
 bIQg==
X-Gm-Message-State: AOAM532nJh/ABtffRL0YTphV1KfU62bDsgdCOc6BeyXik7JUcEyf70W0
 3d82ihlOtUam1Y5JtwRMsrY=
X-Google-Smtp-Source: ABdhPJwzm6O7Tjxstm1rpLU7hCobNXf2+zbotwQBq2dVKylchdy/RveD2WN8JE4gwBiAmAC6soUjHA==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr3082645wrs.140.1642144774890; 
 Thu, 13 Jan 2022 23:19:34 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id ay39sm4488883wmb.29.2022.01.13.23.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 23:19:34 -0800 (PST)
Subject: Re: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in
 amdgpu_ras
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
 <DM5PR12MB177079EC6D56F9639D398A85B0549@DM5PR12MB1770.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4e96b89e-5068-321a-8932-50634641ecad@gmail.com>
Date: Fri, 14 Jan 2022 08:19:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB177079EC6D56F9639D398A85B0549@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nice cleanup, feel free to add an Acked-by: Christian König 
<christian.koenig@amd.com> as well.

Christian.

Am 14.01.22 um 07:44 schrieb Zhou1, Tao:
> [AMD Official Use Only]
>
> The series is:
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
>> -----Original Message-----
>> From: Chai, Thomas <YiPeng.Chai@amd.com>
>> Sent: Friday, January 14, 2022 1:34 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
>> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>> Subject: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in
>> amdgpu_ras
>>
>> Fix the code style warnings in amdgpu_ras:
>> 1. ERROR: space required before the open parenthesis '('.
>> 2. WARNING: line length of xxx exceeds 100 columns.
>> 3. ERROR: "foo* bar" should be "foo *bar".
>> 4. WARNING: unnecessary whitespace before a quoted newline.
>> 5. WARNING: space prohibited before semicolon.
>> 6. WARNING: suspect code indent for conditional statements.
>> 7. WARNING: braces {} are not necessary for single statement blocks.
>>
>> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++----------
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++---
>>   2 files changed, 30 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 0bb6b5354802..23502b2b0770 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -872,7 +872,7 @@ static int amdgpu_ras_enable_all_features(struct
>> amdgpu_device *adev,  static int amdgpu_ras_block_match_default(struct
>> amdgpu_ras_block_object *block_obj,
>>   		enum amdgpu_ras_block block)
>>   {
>> -	if(!block_obj)
>> +	if (!block_obj)
>>   		return -EINVAL;
>>
>>   	if (block_obj->block == block)
>> @@ -881,7 +881,7 @@ static int amdgpu_ras_block_match_default(struct
>> amdgpu_ras_block_object *block_
>>   	return -EINVAL;
>>   }
>>
>> -static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct
>> amdgpu_device *adev,
>> +static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct
>> +amdgpu_device *adev,
>>   					enum amdgpu_ras_block block,
>> uint32_t sub_block_index)  {
>>   	struct amdgpu_ras_block_object *obj, *tmp; @@ -941,7 +941,7 @@
>> static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct
>> ras_err_d  int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>>   				  struct ras_query_if *info)
>>   {
>> -	struct amdgpu_ras_block_object* block_obj = NULL;
>> +	struct amdgpu_ras_block_object *block_obj = NULL;
>>   	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
>>   	struct ras_err_data err_data = {0, 0, 0, NULL};
>>
>> @@ -953,7 +953,7 @@ int amdgpu_ras_query_error_status(struct
>> amdgpu_device *adev,
>>   	} else {
>>   		block_obj = amdgpu_ras_get_ras_block(adev, info->head.block,
>> 0);
>>   		if (!block_obj || !block_obj->hw_ops)   {
>> -			dev_info(adev->dev, "%s doesn't config ras function \n",
>> +			dev_info(adev->dev, "%s doesn't config ras function.\n",
>>   					get_ras_block_str(&info->head));
>>   			return -EINVAL;
>>   		}
>> @@ -1023,13 +1023,14 @@ int amdgpu_ras_query_error_status(struct
>> amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
>> amdgpu_device *adev,
>>   		enum amdgpu_ras_block block)
>>   {
>> -	struct amdgpu_ras_block_object* block_obj =
>> amdgpu_ras_get_ras_block(adev, block, 0);
>> +	struct amdgpu_ras_block_object *block_obj =
>> +amdgpu_ras_get_ras_block(adev, block, 0);
>>
>>   	if (!amdgpu_ras_is_supported(adev, block))
>>   		return -EINVAL;
>>
>>   	if (!block_obj || !block_obj->hw_ops)   {
>> -		dev_info(adev->dev, "%s doesn't config ras function \n",
>> ras_block_str(block));
>> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
>> +				ras_block_str(block));
>>   		return -EINVAL;
>>   	}
>>
>> @@ -1066,7 +1067,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
>> *adev,
>>   		return -EINVAL;
>>
>>   	if (!block_obj || !block_obj->hw_ops)	{
>> -		dev_info(adev->dev, "%s doesn't config ras function \n",
>> get_ras_block_str(&info->head));
>> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
>> +					get_ras_block_str(&info->head));
>>   		return -EINVAL;
>>   	}
>>
>> @@ -1702,19 +1704,25 @@ static void amdgpu_ras_log_on_err_counter(struct
>> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
>> amdgpu_device *adev,
>>   					  struct ras_query_if *info)
>>   {
>> -	struct amdgpu_ras_block_object* block_obj =
>> amdgpu_ras_get_ras_block(adev, info->head.block, info-
>>> head.sub_block_index);
>> +	struct amdgpu_ras_block_object *block_obj =
>> amdgpu_ras_get_ras_block(adev,
>> +									info-
>>> head.block,
>> +									info-
>>> head.sub_block_index);
>>   	/*
>>   	 * Only two block need to query read/write
>>   	 * RspStatus at current state
>>   	 */
>>   	if ((info->head.block != AMDGPU_RAS_BLOCK__GFX) &&
>>   		(info->head.block != AMDGPU_RAS_BLOCK__MMHUB))
>> -		return ;
>> +		return;
>> +
>> +	block_obj = amdgpu_ras_get_ras_block(adev,
>> +					info->head.block,
>> +					info->head.sub_block_index);
>>
>> -	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info-
>>> head.sub_block_index);
>>   	if (!block_obj || !block_obj->hw_ops) {
>> -		dev_info(adev->dev, "%s doesn't config ras function \n",
>> get_ras_block_str(&info->head));
>> -		return ;
>> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
>> +			get_ras_block_str(&info->head));
>> +		return;
>>   	}
>>
>>   	if (block_obj->hw_ops->query_ras_error_status)
>> @@ -2715,7 +2723,7 @@ static void
>> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)  }
>> #endif
>>
>> -struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
>> +struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
>>   {
>>   	if (!adev)
>>   		return NULL;
>> @@ -2723,7 +2731,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct
>> amdgpu_device *adev)
>>   	return adev->psp.ras_context.ras;
>>   }
>>
>> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras*
>> ras_con)
>> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
>> +amdgpu_ras *ras_con)
>>   {
>>   	if (!adev)
>>   		return -EINVAL;
>> @@ -2755,7 +2763,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
>> *adev)
>>
>>   /* Register each ip ras block into amdgpu ras */  int
>> amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>> -		struct amdgpu_ras_block_object* ras_block_obj)
>> +		struct amdgpu_ras_block_object *ras_block_obj)
>>   {
>>   	struct amdgpu_ras_block_object *obj, *tmp;
>>   	if (!adev || !ras_block_obj)
>> @@ -2766,9 +2774,8 @@ int amdgpu_ras_register_ras_block(struct
>> amdgpu_device *adev,
>>
>>   	/* If the ras object is in ras_list, don't add it again */
>>   	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
>> -		if (obj == ras_block_obj) {
>> +		if (obj == ras_block_obj)
>>   			return 0;
>> -		}
>>   	}
>>
>>   	INIT_LIST_HEAD(&ras_block_obj->node);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> index 7a4d82378205..a51a281bd91a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>> @@ -496,7 +496,8 @@ struct amdgpu_ras_block_object {
>>   	/* ras block link */
>>   	struct list_head node;
>>
>> -	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>> enum amdgpu_ras_block block, uint32_t sub_block_index);
>> +	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>> +				enum amdgpu_ras_block block, uint32_t
>> sub_block_index);
>>   	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
>>   	void (*ras_fini)(struct amdgpu_device *adev);
>>   	const struct amdgpu_ras_block_hw_ops *hw_ops; @@ -504,7 +505,7
>> @@ struct amdgpu_ras_block_object {
>>
>>   struct amdgpu_ras_block_hw_ops {
>>   	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
>> -	void (*query_ras_error_count)(struct amdgpu_device *adev,void
>> *ras_error_status);
>> +	void (*query_ras_error_count)(struct amdgpu_device *adev, void
>> +*ras_error_status);
>>   	void (*query_ras_error_status)(struct amdgpu_device *adev);
>>   	void (*query_ras_error_address)(struct amdgpu_device *adev, void
>> *ras_error_status);
>>   	void (*reset_ras_error_count)(struct amdgpu_device *adev); @@ -
>> 678,7 +679,8 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
>>
>>   struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
>>
>> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras*
>> ras_con);
>> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
>> +amdgpu_ras *ras_con);
>>
>> -int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
>> amdgpu_ras_block_object* ras_block_obj);
>> +int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>> +				struct amdgpu_ras_block_object
>> *ras_block_obj);
>>   #endif
>> --
>> 2.25.1

