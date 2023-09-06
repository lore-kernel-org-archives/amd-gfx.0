Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA8CEB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 08:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B5B10E5A6;
	Wed,  6 Sep 2023 08:50:42 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C27D10E5A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 08:50:41 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401187f8071so4450025e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693990240; x=1694595040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yk9K5ZtVG8yzd+XDRlHHxjBq6nAv1CkaCqmEc/NzO1o=;
 b=K+yKbwPSlFKTjg7tDiGOrPHHagzsnK0QxyyAVpguKpsLQ8P/2p6IaGBXGhFGQxUIMO
 MZ7g99IguLW2pfQ804CQvWm29mLcnpHHM4Mi1rnDrtNI7vtvwjVFez9RsesPuhSaCIj5
 Kofhn8qJZ3cLYtipu5RoOm6WABhxBJJP9o9BjhC7vffLnIqwBEr1Je52m8SGHS3CjuuA
 xIGicCeCU5KsKj42z8/4/Jlex4Ij7lJ/s2mnCP/SH3wj0eBWvRIX4hIpD5+YRxh04jKH
 e8Ha+byJ2va3OCB07zkSHcEL10XZvrmr6tR1+Gvoi55VE+n0KQk7ITCpBpk21/5xrKRi
 4ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693990240; x=1694595040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yk9K5ZtVG8yzd+XDRlHHxjBq6nAv1CkaCqmEc/NzO1o=;
 b=Q36ZHoUxoww6FqcIp0khX2ZzWtf3zvIMSseRp/gL5PEk+7sNc+0+sjtJinlB9BPrnD
 PGwz1iJwBUmDvyQi2n1Wof7G0uA82A1WYX8LYFJTerfCMvSgvsmawhqCI1+suI3T8CjE
 oBWJwJa3LLxqKQBvAfWGcvTtRYVmYMttwJX4xnTQVnhTLBM6ESF8vsqiHSBICUVpWdFg
 fgYm7VjGmhfhPIC92NRjpi9J7Y1a+KTgAnaqXs2l4m6u8Dnta+dosZcOXqPqO4XRaIiN
 WXetS4jbO3hYtrrsnmoOX0JU9IlBTB/U/S8BsKAt4M8sitQUO+oBCBcLKj6zd1cOjdhE
 c3FA==
X-Gm-Message-State: AOJu0Yw5676AS/GqZfu2dZdC2y0NECo/1uwMZ5Kerfk/IRMGbkNVm1kW
 CP8vreXgdCk2x88iI108TEaUgRhlN0c7qQ==
X-Google-Smtp-Source: AGHT+IGi+tPhY2X/Nt/nHeCggUDyy4D+JZazjIXQCsPYNnggbDKipuvjl03l4cpDAf6Zidr8hM4dyQ==
X-Received: by 2002:a05:600c:1ca6:b0:400:140c:6083 with SMTP id
 k38-20020a05600c1ca600b00400140c6083mr1937579wms.2.1693990239357; 
 Wed, 06 Sep 2023 01:50:39 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c234a00b003fc06169ab3sm22246081wmq.20.2023.09.06.01.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 01:50:38 -0700 (PDT)
Message-ID: <c6c0237b-87c4-af88-bc5b-a0a9a3fe45f3@gmail.com>
Date: Wed, 6 Sep 2023 10:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-2-christian.koenig@amd.com>
 <CADnq5_Mu9mNohqHNA=k0pjn0vPY4aXd5T+sR4o0GCkGt_TSqvQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Mu9mNohqHNA=k0pjn0vPY4aXd5T+sR4o0GCkGt_TSqvQ@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.09.23 um 22:45 schrieb Alex Deucher:
> On Tue, Sep 5, 2023 at 3:00 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> The KIQ code path was ignoring the second flush. Also avoid long lines and
>> re-calculating the register offsets over and over again.
> I'd split this into two patches, one for the code cleanup and one to
> fix the missing flush.

I've later opted for moving the whole workarounds a layer up because we 
seem to have missed this in a couple of more places.

So I should probably just completely drop fixing this here.

Christian.

>
> Alex
>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 0673cda547bb..4f6990ba71cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -814,13 +814,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                                          uint32_t vmhub, uint32_t flush_type)
>>   {
>>          bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
>> +       u32 j, inv_req, inv_req2, tmp, sem, req, ack;
>>          const unsigned int eng = 17;
>> -       u32 j, inv_req, inv_req2, tmp;
>>          struct amdgpu_vmhub *hub;
>>
>>          BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
>>
>>          hub = &adev->vmhub[vmhub];
>> +       sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
>> +       req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> +       ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>> +
>>          if (adev->gmc.xgmi.num_physical_nodes &&
>>              adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
>>                  /* Vega20+XGMI caches PTEs in TC and TLB. Add a
>> @@ -852,6 +856,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>
>>                  amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>                                                     1 << vmid);
>> +               if (inv_req2)
>> +                       amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
>> +                                                          inv_req2, 1 << vmid);
>> +
>>                  up_read(&adev->reset_domain->sem);
>>                  return;
>>          }
>> @@ -870,9 +878,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                  for (j = 0; j < adev->usec_timeout; j++) {
>>                          /* a read return value of 1 means semaphore acquire */
>>                          if (vmhub >= AMDGPU_MMHUB0(0))
>> -                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
>> +                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
>>                          else
>> -                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
>> +                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
>>                          if (tmp & 0x1)
>>                                  break;
>>                          udelay(1);
>> @@ -884,9 +892,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>
>>          do {
>>                  if (vmhub >= AMDGPU_MMHUB0(0))
>> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
>> +                       WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
>>                  else
>> -                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
>> +                       WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
>>
>>                  /*
>>                   * Issue a dummy read to wait for the ACK register to
>> @@ -895,14 +903,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                   */
>>                  if ((vmhub == AMDGPU_GFXHUB(0)) &&
>>                      (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
>> -                       RREG32_NO_KIQ(hub->vm_inv_eng0_req +
>> -                                     hub->eng_distance * eng);
>> +                       RREG32_NO_KIQ(req);
>>
>>                  for (j = 0; j < adev->usec_timeout; j++) {
>>                          if (vmhub >= AMDGPU_MMHUB0(0))
>> -                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
>> +                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
>>                          else
>> -                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
>> +                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
>>                          if (tmp & (1 << vmid))
>>                                  break;
>>                          udelay(1);
>> @@ -919,9 +926,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                   * write with 0 means semaphore release
>>                   */
>>                  if (vmhub >= AMDGPU_MMHUB0(0))
>> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
>> +                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
>>                  else
>> -                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
>> +                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
>>          }
>>
>>          spin_unlock(&adev->gmc.invalidate_lock);
>> --
>> 2.34.1
>>

