Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE68ECD54A5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF7C10E367;
	Tue, 19 Sep 2023 08:01:42 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E962910E367
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 08:01:39 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-404773f2501so50003675e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695110498; x=1695715298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErpUi+ORq59JFehWhlASYkmE00V3qL9c3IKNA27HKbM=;
 b=CF/IFDLxqtRRCORr2PmRmbygu0p0Ltla/BccC0+HhaAQalVVso1yYespTj+dmoJqB0
 O0QyP0E+URuanIUs1lyRk7cpjLL29o3mUVqm2/AENmf0RnA8/mjfSzFrOJsJydM9NhAa
 LsGDU8Wbst7TP6w7yCGTQk9ELY6hduTddUCzIiyoIwUdPmfZcahlgphflpu8o86SZOxR
 Nl8E8/eNbHbKqN1YtfWeUNm31ViolDSM0nPG3LxVG3a4Mp3QhhTllBABVeBKJ4PpLvZr
 AE02jyFAl/+nvbwYcLzJ4/QZbplOTYTyovNAguNgRyrAfLnIytnl3+rxpL4ossUQ2jfp
 LPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110498; x=1695715298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ErpUi+ORq59JFehWhlASYkmE00V3qL9c3IKNA27HKbM=;
 b=Kg+d4BTvPKJ68jXYbWupXStv5NaIp9ARbZAPE9+tSclrwVLSF8m4tLfs+wF66SCM/h
 eUVLTKYVjRQx4/I8Dv5SWCDK7V2MaGAG0HGLtbXVbIePpJRe8Orhl5CUuDLGYpg0bgXO
 QNdCUAPnZfEKVSYsj+JFFaINJpO0jxvrQJTRZ5UjFv475nbL4vXxigmWkx8lDVXyhenr
 BTw51L8bTXJKzvLQVnmu7Yo9vHoRH3kH4N61j7qLQ6LOp9w5QFMTT44Baz1obym6LeXt
 fmcjgC6HwjWItps99jCd1eBgGfqogyjpG6wIfY/iuTMX+ihS1M8RpAZehJ2qHIEQSDj9
 ab/A==
X-Gm-Message-State: AOJu0YyycV+XYPRPG05JGxUcNxvIHVVDN/tcSGbFaRcdT7E3WEW61l5T
 aW1E1eMld2vQgZNkKn9LAV0=
X-Google-Smtp-Source: AGHT+IHzECwmwH8ZTtDcMoEtlT5efXS8O/zRZlARvZU6J3uztgctQzmTFqpE1Ldpq+1eC+2jUlKlbA==
X-Received: by 2002:a05:600c:2109:b0:402:f8ea:be3e with SMTP id
 u9-20020a05600c210900b00402f8eabe3emr9048549wml.7.1695110497944; 
 Tue, 19 Sep 2023 01:01:37 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a5d4c8f000000b0030647449730sm14829339wrs.74.2023.09.19.01.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 01:01:37 -0700 (PDT)
Message-ID: <936fc851-39ce-6c68-f188-6e35ab25faaa@gmail.com>
Date: Tue, 19 Sep 2023 10:01:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-2-christian.koenig@amd.com>
 <42a4ca26-1698-7838-df27-ce1e21eb065c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <42a4ca26-1698-7838-df27-ce1e21eb065c@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.09.23 um 20:58 schrieb Felix Kuehling:
>
> On 2023-09-05 02:04, Christian König wrote:
>> The KIQ code path was ignoring the second flush. Also avoid long 
>> lines and
>> re-calculating the register offsets over and over again.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 0673cda547bb..4f6990ba71cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -814,13 +814,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>                       uint32_t vmhub, uint32_t flush_type)
>>   {
>>       bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, 
>> vmhub);
>> +    u32 j, inv_req, inv_req2, tmp, sem, req, ack;
>>       const unsigned int eng = 17;
>> -    u32 j, inv_req, inv_req2, tmp;
>>       struct amdgpu_vmhub *hub;
>>         BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
>>         hub = &adev->vmhub[vmhub];
>> +    sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
>> +    req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> +    ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>
> If you use SOC15_REG_OFFSET here, you can drop all the if (vmhub >= 
> AMDGPU_MMHUB0(0)) conditions below.

I though about that as well, but that won't work since we don't know the 
register name.

Regards,
Christian.

>
> Other than that, the patch looks good to me.
>
> Regards,
>   Felix
>
>
>> +
>>       if (adev->gmc.xgmi.num_physical_nodes &&
>>           adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
>>           /* Vega20+XGMI caches PTEs in TC and TLB. Add a
>> @@ -852,6 +856,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>             amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>                              1 << vmid);
>> +        if (inv_req2)
>> +            amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>> +                               inv_req2, 1 << vmid);
>> +
>>           up_read(&adev->reset_domain->sem);
>>           return;
>>       }
>> @@ -870,9 +878,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>           for (j = 0; j < adev->usec_timeout; j++) {
>>               /* a read return value of 1 means semaphore acquire */
>>               if (vmhub >= AMDGPU_MMHUB0(0))
>> -                tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, 
>> hub->vm_inv_eng0_sem + hub->eng_distance * eng);
>> +                tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
>>               else
>> -                tmp = RREG32_SOC15_IP_NO_KIQ(GC, 
>> hub->vm_inv_eng0_sem + hub->eng_distance * eng);
>> +                tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
>>               if (tmp & 0x1)
>>                   break;
>>               udelay(1);
>> @@ -884,9 +892,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>         do {
>>           if (vmhub >= AMDGPU_MMHUB0(0))
>> -            WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + 
>> hub->eng_distance * eng, inv_req);
>> +            WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
>>           else
>> -            WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + 
>> hub->eng_distance * eng, inv_req);
>> +            WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
>>             /*
>>            * Issue a dummy read to wait for the ACK register to
>> @@ -895,14 +903,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>            */
>>           if ((vmhub == AMDGPU_GFXHUB(0)) &&
>>               (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
>> -            RREG32_NO_KIQ(hub->vm_inv_eng0_req +
>> -                      hub->eng_distance * eng);
>> +            RREG32_NO_KIQ(req);
>>             for (j = 0; j < adev->usec_timeout; j++) {
>>               if (vmhub >= AMDGPU_MMHUB0(0))
>> -                tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, 
>> hub->vm_inv_eng0_ack + hub->eng_distance * eng);
>> +                tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
>>               else
>> -                tmp = RREG32_SOC15_IP_NO_KIQ(GC, 
>> hub->vm_inv_eng0_ack + hub->eng_distance * eng);
>> +                tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
>>               if (tmp & (1 << vmid))
>>                   break;
>>               udelay(1);
>> @@ -919,9 +926,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct 
>> amdgpu_device *adev, uint32_t vmid,
>>            * write with 0 means semaphore release
>>            */
>>           if (vmhub >= AMDGPU_MMHUB0(0))
>> -            WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + 
>> hub->eng_distance * eng, 0);
>> +            WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
>>           else
>> -            WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + 
>> hub->eng_distance * eng, 0);
>> +            WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
>>       }
>>         spin_unlock(&adev->gmc.invalidate_lock);

