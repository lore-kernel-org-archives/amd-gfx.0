Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E28C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 12:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF3110E0A1;
	Thu, 11 Jul 2024 12:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NC2lzj5A";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8C510E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 12:39:10 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-36798e62aeeso468366f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720701548; x=1721306348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAegpIgWo/qJZV6AFAky/CCSIvYy33d1WhbaTOcMEmw=;
 b=NC2lzj5A0B9TF4ouCBICtWaGijLvL9oKBGgu2sXo3pT3DllKvZCV31eoymSQ/4fs7d
 6BjqOjk8hB20SKWNZxQyV/2nxnaB9fdX3O+23uTzKUxabs+89a5k+rLn8NSgGb06+wP8
 eMxsi7vYSFbm39p6y6TlNFkC0Ad1IEx3DXXMUL1GFcxX+k67y9u5WzX/K/mXhehx8uMZ
 YgpioqUp90DNpjVc+DNwSgBa2+d0FHV/d7mCZ0uHnEL5LfbWivD0q3EolGYmO1kQarsS
 TAVSr0TxEu/K8btLuniKPi6uR2nj6aDeVAMXNnwImN6ETOlvU+kw5CisGgWznKH+IKM9
 frCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720701548; x=1721306348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JAegpIgWo/qJZV6AFAky/CCSIvYy33d1WhbaTOcMEmw=;
 b=fzTkDQNxrwgKJzgRZoMnOZgk3ukpwW8s70IbEt03UdjJ0+f9w1NoOMrZEHnvKkNHg2
 4SYFIUQ2G8KReUZSyK9FyJ31gTOCqXe8fOVa46OxqTLlpktEFnKnM0nexZtxi+Ohr0Kv
 zGx6f2zmSpctjAIY8UW4xvV7CHX4vJkzIAJi5LiErB4vT2KDU2oEDR0UDUEHZutUm38T
 Cx0/vqtuWU8LXCMFc89PaBrRvyH8W2zDokq0DiE2MwG77JUrh5O3o5lgPhrp/IYf4vPs
 BmhS2RB9oq1igT+Di8eUpFO0rwxcVdNMfW4UG6+Wde7Eb5nBXUigvhULl/x4Uw0shdJX
 Vnfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoL+28AcI2kHpGIHll6Zwc1SqDmsicAezApCwWLtRp9RIz6Onfjn2RQXF5+cAAiRmd5jeE09NP/u89KME/die5pQFLjUes841J+Pqlew==
X-Gm-Message-State: AOJu0YxI904vrdrTFDO7UlB1v6eie9bw2SSyU067uRqFTDkuSioLZcLO
 CgeYlfnex24o2kG1w14EqwxbzV9nXd3R/Ryvc0Qhf5ogQgDsIZD5
X-Google-Smtp-Source: AGHT+IFT0mBkVyDwf2h8NPX/vOY27QnCp7M8z0Xkj7QlJ5j81AcAa9x/6Kp4ga3TETfBH9MvQcWi1w==
X-Received: by 2002:a05:6000:c08:b0:367:4d9d:568b with SMTP id
 ffacd0b85a97d-367ceadc9eemr5142915f8f.68.1720701547999; 
 Thu, 11 Jul 2024 05:39:07 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e171sm7616418f8f.18.2024.07.11.05.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 05:39:07 -0700 (PDT)
Message-ID: <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
Date: Thu, 11 Jul 2024 14:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: "Huang, Trigger" <Trigger.Huang@amd.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, completely agree. This patch doesn't really make sense.

Please explain why you would want to do this?

Regards,
Christian.

Am 11.07.24 um 13:56 schrieb Huang, Trigger:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> This patch seems to be wrong.
> Quite a lot of preparations have been done in amdgpu_bo_move_notify
> For example, amdgpu_bo_kunmap() will be called to prevent the BO from being accessed by CPU. If not called, the CPU may attempt to access the BO while it is being moved.
>
> Thanks,
> Trigger
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> YuanShang
>> Sent: Thursday, July 11, 2024 5:10 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
>> (River) <YuanShang.Mao@amd.com>
>> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> It leads to race condition if amdgpu_bo is marked as invalid before it is really
>> moved.
>>
>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 29e4b5875872..a29d5132ad3d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>> *bo, bool evict,
>>
>>          if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>                           bo->ttm == NULL)) {
>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  ttm_bo_move_null(bo, new_mem);
>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  return 0;
>>          }
>>          if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA || @@ -
>> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo,
>> bool evict,
>>          if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>              (new_mem->mem_type == TTM_PL_TT ||
>>               new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  ttm_bo_move_null(bo, new_mem);
>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  return 0;
>>          }
>>          if ((old_mem->mem_type == TTM_PL_TT || @@ -542,9 +542,9 @@ static
>> int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>                          return r;
>>
>>                  amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  ttm_resource_free(bo, &bo->resource);
>>                  ttm_bo_assign_mem(bo, new_mem);
>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  return 0;
>>          }
>>
>> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>> *bo, bool evict,
>>              new_mem->mem_type == AMDGPU_PL_OA ||
>>              new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>                  /* Nothing to save here */
>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  ttm_bo_move_null(bo, new_mem);
>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>                  return 0;
>>          }
>>
>> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
>> ttm_buffer_object *bo, bool evict,
>>                  return -EMULTIHOP;
>>          }
>>
>> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>>          if (adev->mman.buffer_funcs_enabled)
>>                  r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>>          else
>>                  r = -ENODEV;
>> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>>
>>          if (r) {
>>                  /* Check that all memory is CPU accessible */
>> --
>> 2.25.1

