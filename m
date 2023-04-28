Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215E6C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 08:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B681B10EC82;
	Fri, 28 Apr 2023 08:57:53 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F67D10EC82
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 08:57:52 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-504dfc87927so16238279a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682672270; x=1685264270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU+V3h69pPdNIOqrMW1+U19YaeGVdcG8fQ27O7Fmkiw=;
 b=FJ28dR4LT9QFpHbncr9WlqRWeyh1J/kdQP/umB7ZBAi0B6wZ4n9QG49BSm4CesL8Qm
 u2H2+oHQMdUibUZHRffFDYf2nchdrmJKz7cxCvBT2kMKlT8nNrsamj7e8+iDZ4a0FP6F
 QlQRVFNItDV5QYRY5SIQAmUZ4j6QsgumFDZEj70znGfBpBeYJQUUAGyLA8rrScKUJpX0
 dAC9kUv/idiMG16o2XO+WHuAlkM4krtqNZ/pA2+VleVSCiF6vkSf/DtdKz2Z3A1udC8w
 ytIZCszcil0S3V8TQIC6QYooHLEUFF5P+BLmO+hdLhj7lNIYWtBCCABkujLN9GrlJJTL
 hufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682672270; x=1685264270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU+V3h69pPdNIOqrMW1+U19YaeGVdcG8fQ27O7Fmkiw=;
 b=S9UzRpj+QVpKaCGoPHnA+3LUBDTqgKBx6YrY+vWv01z1CIzVDCLsiUz2gKim+W8NjN
 Q44VrH+SoIAIhH0+mjeZIh3KSpX3RsKVCnTWzTVRsANRosXCef5a6C2eD1sHeldK1rZz
 Mmw8tyPkotFKYCW5hZvitZYQJ11dwJ7CXJYI1e679Vnb3u4OHJhKC/jlqGFaWn8QI0Z8
 BHSPP7WhxBfn9pnKGhDy2ahpJFdtF1GlY5UFp275p2H0csO0RgrHi/zEhzoxWmZYPY64
 g1xfBD80j+YpERSs/8UMaQ3kZynzY1BSLF/u7UFXQpbPXainI24EYU5LxZH8Kp6aITzs
 I6RQ==
X-Gm-Message-State: AC+VfDzq59px7VUP1nuPT5nJ6G2iZrUolwIDlFDIae0o0kYdN/Uvs89N
 7y7V+NjegBOYbSjNKSHGYkk=
X-Google-Smtp-Source: ACHHUZ40g7LosIG9KKimsdqEu4py4yjRvfjA9O5Ji1oZEL/svdK6z3lVc1du1BiOwe2QSLq3UZbslQ==
X-Received: by 2002:a05:6402:b02:b0:506:b2c7:2552 with SMTP id
 bm2-20020a0564020b0200b00506b2c72552mr4676760edb.13.1682672269980; 
 Fri, 28 Apr 2023 01:57:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a056402148700b0050692cfc24asm8780347edv.16.2023.04.28.01.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 01:57:49 -0700 (PDT)
Message-ID: <aacbb7ab-a606-6da4-76a7-7695de231f67@gmail.com>
Date: Fri, 28 Apr 2023 10:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
Content-Language: en-US
To: "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230427071634.1484586-1-Xiaomeng.Hou@amd.com>
 <DM4PR12MB524818FF0E65A15836CA0814F06B9@DM4PR12MB5248.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB524818FF0E65A15836CA0814F06B9@DM4PR12MB5248.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, the bit basically tells the IH which PASID lookup table to use for 
VMID->PASID translation.

I briefly remember that I've just copied&pasted the fields from the 
IH_COOKIE definition.

Reviewed-by: Christian König <christian.koenig@amd.com>

Am 28.04.23 um 04:54 schrieb Liu, Aaron:
> [AMD Official Use Only - General]
>
> Good catch!
> The PASID_SRC bit is only used in IH_COOKIE which is sent as register write to the IH by IH_client.
> But in the interrupt packet from IH to driver, the corresponding bit is always reserved. PASID_SRC is not to be used for driver.
>
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Xiaomeng Hou
>> Sent: Thursday, April 27, 2023 3:17 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ji, Ruili
>> <Ruili.Ji@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
>>
>> PASID_SRC is not actually present in the Interrupt Packet, the field is taken as
>> reserved bits now. So remove it from IV entry to avoid misuse.
>>
>> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 1 -
>> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> index d58353c89e59..fceb3b384955 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> @@ -271,7 +271,6 @@ void amdgpu_ih_decode_iv_helper(struct
>> amdgpu_device *adev,
>>        entry->timestamp_src = dw[2] >> 31;
>>        entry->pasid = dw[3] & 0xffff;
>>        entry->node_id = (dw[3] >> 16) & 0xff;
>> -     entry->pasid_src = dw[3] >> 31;
>>        entry->src_data[0] = dw[4];
>>        entry->src_data[1] = dw[5];
>>        entry->src_data[2] = dw[6];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> index 7a8e686bdd41..1c747ac4129a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> @@ -54,7 +54,6 @@ struct amdgpu_iv_entry {
>>        unsigned timestamp_src;
>>        unsigned pasid;
>>        unsigned node_id;
>> -     unsigned pasid_src;
>>        unsigned src_data[AMDGPU_IRQ_SRC_DATA_MAX_SIZE_DW];
>>        const uint32_t *iv_entry;
>>   };
>> --
>> 2.25.1

