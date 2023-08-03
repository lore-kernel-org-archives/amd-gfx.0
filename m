Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285FEC0015E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 08:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B913A10E5C9;
	Thu,  3 Aug 2023 08:28:33 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1ADB10E5C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 08:28:30 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31763b2c5a4so603226f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Aug 2023 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691051309; x=1691656109;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2sbJnfGSKZHpkCmR74A+wRq+y6twotKWKmEPRbGRsI=;
 b=MvXHQ1pjsbriJhMKHwwwEL/VdRmhN7b+p1/FvVzR4h+fU1ci+ygJ8MCwDEp7itzBE1
 EDfV1/hT9tCgjjqHtri7ACXWhmB0llVDHFhNX6ccboDigNgLE9xoBpss4SVa7r/wYpYu
 1gaVP2TDAIs3mgC2MHSpd7BClJNZzTo9kB/MMcStFvG8hJY24oNXJIG5JJT4O6CL1aZh
 tlywKJD9HvwXxVRUrAReNwlS4TLHykUmtjKTrPejq9alE+Pt3yAZhpeukhY18NY/Nfsf
 vppkNvn9vSv+J5uxnxS9Yvr/pf3GMX9u5J4DLJtpkKdecj1kmSI1KYI4nRBCfoYd32Cx
 NcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691051309; x=1691656109;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2sbJnfGSKZHpkCmR74A+wRq+y6twotKWKmEPRbGRsI=;
 b=Ce+o9bx9JH1ibLcegTzsLfVrfRAUwXn36r01cAD1MssM/1oJEV4VkcJJL9hqgUxR+V
 777aX+UhbiXWH+/i1xhjh3SbDHF7Qxp/NG92/MIimjPdAjiRiXTL/utLXjgJ24aWb3Dz
 FDkHgwNlPVrBt34G9yp+ZkeYAgfljOtqRN4nHHt9CZ2sFyfbDYbxUSVvuAUTXYNVbHKH
 PQky+DAlMlvXQT6bIo4HKrP/WutCSTp3CVknEdBFvWwarWC6SuTM88YwGsjcFsDOWqWu
 wjMb/bhAqih6FYTXwhc6u13NprW9TaA5k7MaMa18HbajbRFIwkZfX27uRrskk0cViAcj
 BD0g==
X-Gm-Message-State: ABy/qLYy5SmgnHSXqqvg6ZKFA9NGQX+OSYZ6DEEOujHV1sqrOWwL4Hfx
 szicsoO40OxLSSrupZzpubk=
X-Google-Smtp-Source: APBJJlFKtRyw5VzEjWUqKDYDdCVHN8gKomRadWnnY7oeglr8OjyoVUtmLRzaY3FFkWn+PQqivvxT4g==
X-Received: by 2002:a5d:6845:0:b0:314:50d:4540 with SMTP id
 o5-20020a5d6845000000b00314050d4540mr6372463wrw.18.1691051309062; 
 Thu, 03 Aug 2023 01:28:29 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1569:4500:df4b:1bb:b0ec:33a0?
 ([2a00:e180:1569:4500:df4b:1bb:b0ec:33a0])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a056000050100b003141f96ed36sm21376991wrf.0.2023.08.03.01.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 01:28:28 -0700 (PDT)
Message-ID: <b0915726-a8e5-18e7-1b5e-264bb7198c32@gmail.com>
Date: Thu, 3 Aug 2023 10:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition
 case
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20230717022619.3833601-1-guchun.chen@amd.com>
 <20230717022619.3833601-4-guchun.chen@amd.com>
 <96a59b0d-89aa-7cea-e14c-9a9188c64020@amd.com>
 <DM5PR12MB246900DA95D6365824B536A5F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB246900DA95D6365824B536A5F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
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

Yeah, perfectly fine for me. I was out of office for a few days as well.

Christian.

Am 18.07.23 um 04:16 schrieb Chen, Guchun:
> [Public]
>
> Thank you for review, Felix.
>
> Hi Christian,
>
> I forgot to add your RB in patch 2/patch3 when posting this series for review. I will add it back when pushing. Hope it's fine to you.
>
> Regards,
> Guchun
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Monday, July 17, 2023 10:58 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
>> gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> Subject: Re: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp
>> partition case
>>
>> On 2023-07-16 22:26, Guchun Chen wrote:
>>> ~0 as no xcp partition is used in several places, so improve its
>>> definition by a macro for code consistency.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> The series is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          | 2 ++
>>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       | 4 ++--
>>>    4 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index a7f314ddd173..d34c3ef8f3ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1709,7 +1709,8 @@ int
>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>                      alloc_flags |= (flags &
>> KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>>>                      AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
>>>              }
>>> -           xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
>>> +           xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
>>> +                                   0 : fpriv->xcp_id;
>>>      } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>>>              domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>>>              alloc_flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> index d175e862f222..9c9cca129498 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -363,7 +363,7 @@ int amdgpu_xcp_open_device(struct
>> amdgpu_device *adev,
>>>      if (!adev->xcp_mgr)
>>>              return 0;
>>>
>>> -   fpriv->xcp_id = ~0;
>>> +   fpriv->xcp_id = AMDGPU_XCP_NO_PARTITION;
>>>      for (i = 0; i < MAX_XCP; ++i) {
>>>              if (!adev->xcp_mgr->xcp[i].ddev)
>>>                      break;
>>> @@ -381,7 +381,7 @@ int amdgpu_xcp_open_device(struct
>> amdgpu_device *adev,
>>>              }
>>>      }
>>>
>>> -   fpriv->vm.mem_id = fpriv->xcp_id == ~0 ? -1 :
>>> +   fpriv->vm.mem_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
>> -1 :
>>>                              adev->xcp_mgr->xcp[fpriv->xcp_id].mem_id;
>>>      return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> index 0f8026d64ea5..9a1036aeec2a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>>> @@ -37,6 +37,8 @@
>>>    #define AMDGPU_XCP_FL_NONE 0
>>>    #define AMDGPU_XCP_FL_LOCKED (1 << 0)
>>>
>>> +#define AMDGPU_XCP_NO_PARTITION (~0)
>>> +
>>>    struct amdgpu_fpriv;
>>>
>>>    enum AMDGPU_XCP_IP_BLOCK {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> index 16471b81a1f5..72b629a78c62 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>> @@ -68,7 +68,7 @@ static void aqua_vanjaram_set_xcp_id(struct
>> amdgpu_device *adev,
>>>      enum AMDGPU_XCP_IP_BLOCK ip_blk;
>>>      uint32_t inst_mask;
>>>
>>> -   ring->xcp_id = ~0;
>>> +   ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
>>>      if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
>>>              return;
>>>
>>> @@ -177,7 +177,7 @@ static int aqua_vanjaram_select_scheds(
>>>      u32 sel_xcp_id;
>>>      int i;
>>>
>>> -   if (fpriv->xcp_id == ~0) {
>>> +   if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
>>>              u32 least_ref_cnt = ~0;
>>>
>>>              fpriv->xcp_id = 0;

