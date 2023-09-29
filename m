Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB550E732D0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 10:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADC110E002;
	Fri, 29 Sep 2023 10:41:55 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B21010E002
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 10:41:53 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32325534cfaso9189150f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695984111; x=1696588911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJJin821yiePrQGBmypvXmkdZz+5mvyLIoB34DHugu0=;
 b=FBn/CYwNG3ZFjN1GylvG+FfykuWcHlAAG3jdjbPY4C9WxOwiFZxwPmA1apJY9wO7eQ
 zbYd4CmMEhiiZ55uXA8tpi+11F/JrVAGnPfG8L0AnSRdRx4Fgfs5kycC2iA6CAYYkIA8
 iCwkquqrKa3Y/HQXUPp2f6Y9s9SIWWiwFMipwVkmMU1aasb1TPiqY3e1B9pW7Be16GkK
 X2Nl5BSqeH5pWEzhCGljBZkZ8r+0zBeSQD5Eb7cHvPGIa4/gSFiQ/Hk3jlLfECfSqAiH
 +FFR1JiY77MmUV5agHZQZ4OYsKztXWR1vQsDDXnlHOxfKnZ0r1gSq1V1R8/DkTaztP8p
 Q+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695984111; x=1696588911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CJJin821yiePrQGBmypvXmkdZz+5mvyLIoB34DHugu0=;
 b=sQD+beyx4GmWgkZLukmzmHNaycZvIel4K17MF5rdUhTFakgYKikgpqQc8LI7RtP3/w
 lTTRGNlUZuhIqLUZW5x6MJs/vemV2PWXcyyrwRjCO5CRo9BTa0Wr+4/LLxXJfwPsdCZ0
 Ee/FWqubUn8CR3gcUk67eE7RDN6NSNvpszpPsmz9ICbiO8VIZwCr6vYQFY4XnnoRO9oX
 OjP4TJWBbFoVtsnlgxJMtW9pgZmBkIMhxdLR+6Okbn56kO3SYoOP/U0yu0QVXRVr8T2I
 /dqQv2fr9LI3Cp/cNhy93voFA7/tC0Dr3A1FlRr3Xh48ku/kX1oXfejbypsvmeBNcYxD
 kSuw==
X-Gm-Message-State: AOJu0YxnoTjvvmQU34/VQFQOR7k07S0+Mcnb9AU2N+HwB5mIKy6xoDtv
 8od8JUryGpe9YvBGNSK4pis=
X-Google-Smtp-Source: AGHT+IHu73wZnnKNlJbQwHqXARP/5NtXvbK2rMZ1xZWcyN2V/ZeoMcQ/r2vw/OoGXb381fZ3+HTLBw==
X-Received: by 2002:a5d:4211:0:b0:31f:dcdd:726 with SMTP id
 n17-20020a5d4211000000b0031fdcdd0726mr3629746wrq.66.1695984110741; 
 Fri, 29 Sep 2023 03:41:50 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.65])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b003232380ffd5sm13264120wrb.106.2023.09.29.03.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 03:41:50 -0700 (PDT)
Message-ID: <4287004f-a89e-3e8a-a2c0-687fa6ec38f8@gmail.com>
Date: Fri, 29 Sep 2023 12:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230927181251.2364633-1-alexander.deucher@amd.com>
 <CADnq5_MMWMoLrKa2GWDcx24-gG=6T6kuftEznvujwjUWxNa9Aw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MMWMoLrKa2GWDcx24-gG=6T6kuftEznvujwjUWxNa9Aw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As discussed on yesterdays call feel free to add my rb to the series.

Christian.

Am 28.09.23 um 15:23 schrieb Alex Deucher:
> Ping on this series?  Fixes an issue for SR-IOV in stress tests.
>
> Alex
>
> On Wed, Sep 27, 2023 at 2:31 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> We normally place GART based on the location of VRAM and the
>> available address space around that, but provide an option
>> to force a particular location for hardware that needs it.
>>
>> v2: Switch to passing the placement via parameter
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 +++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  9 ++++++++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
>>   8 files changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 2bfeaacd050c..60c81c3d29d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -269,7 +269,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>>    * If GART size is bigger than space left then we ajust GART size.
>>    * Thus function will never fails.
>>    */
>> -void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>> +void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>> +                             enum amdgpu_gart_placement gart_placement)
>>   {
>>          const uint64_t four_gb = 0x100000000ULL;
>>          u64 size_af, size_bf;
>> @@ -287,11 +288,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>>                  mc->gart_size = max(size_bf, size_af);
>>          }
>>
>> -       if ((size_bf >= mc->gart_size && size_bf < size_af) ||
>> -           (size_af < mc->gart_size))
>> -               mc->gart_start = 0;
>> -       else
>> +       switch (gart_placement) {
>> +       case AMDGPU_GART_PLACEMENT_HIGH:
>>                  mc->gart_start = max_mc_address - mc->gart_size + 1;
>> +               break;
>> +       case AMDGPU_GART_PLACEMENT_LOW:
>> +               mc->gart_start = 0;
>> +               break;
>> +       case AMDGPU_GART_PLACEMENT_BEST_FIT:
>> +       default:
>> +               if ((size_bf >= mc->gart_size && size_bf < size_af) ||
>> +                   (size_af < mc->gart_size))
>> +                       mc->gart_start = 0;
>> +               else
>> +                       mc->gart_start = max_mc_address - mc->gart_size + 1;
>> +               break;
>> +       }
>>
>>          mc->gart_start &= ~(four_gb - 1);
>>          mc->gart_end = mc->gart_start + mc->gart_size - 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index f593259a66c3..e699d1ca8deb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
>>
>>   #define INVALID_PFN    -1
>>
>> +enum amdgpu_gart_placement {
>> +       AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
>> +       AMDGPU_GART_PLACEMENT_HIGH,
>> +       AMDGPU_GART_PLACEMENT_LOW,
>> +};
>> +
>>   struct amdgpu_gmc {
>>          /* FB's physical address in MMIO space (for CPU to
>>           * map FB). This is different compared to the agp/
>> @@ -391,7 +397,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>>   void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>>                                u64 base);
>>   void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
>> -                             struct amdgpu_gmc *mc);
>> +                             struct amdgpu_gmc *mc,
>> +                             enum amdgpu_gart_placement gart_placement);
>>   void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>>                               struct amdgpu_gmc *mc);
>>   void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 70370b412d24..8e6e36279389 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -670,7 +670,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
>>          base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>>
>>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>> -       amdgpu_gmc_gart_location(adev, mc);
>> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>          if (!amdgpu_sriov_vf(adev))
>>                  amdgpu_gmc_agp_location(adev, mc);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index d0a9ee2f12d3..d611d2efce3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -634,7 +634,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>>          base = adev->mmhub.funcs->get_fb_location(adev);
>>
>>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>> -       amdgpu_gmc_gart_location(adev, mc);
>> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>          if (!amdgpu_sriov_vf(adev) ||
>>              (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
>>                  amdgpu_gmc_agp_location(adev, mc);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 3f31f268e0eb..7f66954fd302 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -212,7 +212,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>>          base <<= 24;
>>
>>          amdgpu_gmc_vram_location(adev, mc, base);
>> -       amdgpu_gmc_gart_location(adev, mc);
>> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>>
>>   static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index a72dc21cf6fc..3869cefab7bd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -240,7 +240,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
>>          base <<= 24;
>>
>>          amdgpu_gmc_vram_location(adev, mc, base);
>> -       amdgpu_gmc_gart_location(adev, mc);
>> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 8ce77d074d17..4126172feb7f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -414,7 +414,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_device *adev,
>>          base <<= 24;
>>
>>          amdgpu_gmc_vram_location(adev, mc, base);
>> -       amdgpu_gmc_gart_location(adev, mc);
>> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 6b15677c0314..37e96d9d30a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1611,7 +1611,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>>                  amdgpu_gmc_sysvm_location(adev, mc);
>>          } else {
>>                  amdgpu_gmc_vram_location(adev, mc, base);
>> -               amdgpu_gmc_gart_location(adev, mc);
>> +               amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
>>                  if (!amdgpu_sriov_vf(adev))
>>                          amdgpu_gmc_agp_location(adev, mc);
>>          }
>> --
>> 2.41.0
>>

