Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC954E80A8E
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 05:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3857110E469;
	Wed, 27 Sep 2023 05:37:58 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E982810E469
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 05:37:56 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4053c6f0d55so103290965e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695793075; x=1696397875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pvp3UevbAEAU0OUH6dbKVKIDY2tDhatqrItuCzJ5Od0=;
 b=A0Ba6wgmIrSpzglG5uyakl5RZthp7Gr1/0iwXL+kQkW6g4dl+KFTmNtKB3GcD7LumH
 YcISf2okG4xOf1B4Tlwy/Y5gSuLAjsNlbiRzwcXGFh416UIhJQwp5QpMESfyOs+zr+pt
 CxzQXKNXaOTJysqp3ceuaXIl7yL3AsiqXfKHqBQyrDX9kH+Amnt0l2mzR+Z7/5Kb+EXe
 vxDehRewCvjXyY1pjtCD6S4/L8gTzrBgAIyw5J65GwDiWvTJLjPx4ymTO84goI/iXIFK
 SeVaWC7fuQ7P1ft55Jy3tYelBH4WR1Vkz/xfv5WDHPZTswfzogL6HvxdqJAtcQmOtxKa
 ee5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695793075; x=1696397875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pvp3UevbAEAU0OUH6dbKVKIDY2tDhatqrItuCzJ5Od0=;
 b=ZknIwMp9aZXecsyxXZuU9f14QLZ4YN0GQ0hf7VreLbVtFbfPZrURuW+Dgq9dQPVJ6Y
 RqPeir0KlHu3bqVAUY+svtd7pEUx5GWBLb5NvdbXVU6sTcT3zQyepZp3VQSp0/eehTQG
 1eMbNxqaVraFk2RVaPRIzQer0VbsPOgkXB5M8a1KG1p3vY5bqiv0spB/c2aIsTBDV0Gj
 Ty7WCW9veB+7WMLkv5jUpMsZdHylc06/mc9tEoo9Jsb3iW4l1XLkTi9ZmeS9WvPuQITc
 Kwm76PK8n72h5+skYKP2ErsOOGqtGYYXFDGB4xGCZu5XP+6kIaAVJL6qUnLbqB4q1GWw
 xzrQ==
X-Gm-Message-State: AOJu0Yyw0W7T2slLRyuWF5Y9KzkKG1+7a7rSa7/4ttiU+HV7ETfRLNbR
 5adtvFnCfCGaZPPh2It3/XY=
X-Google-Smtp-Source: AGHT+IEAfj/91C6wUi5H5FsFzekA0OacnBP7VWt6VX4SmrcaUyqYUynwcdkLKcJuLxZEu2v8R9li4g==
X-Received: by 2002:a5d:590c:0:b0:321:64a6:e417 with SMTP id
 v12-20020a5d590c000000b0032164a6e417mr720958wrd.1.1695793074981; 
 Tue, 26 Sep 2023 22:37:54 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.195])
 by smtp.gmail.com with ESMTPSA id
 m4-20020adff384000000b00321673de0d7sm916168wro.25.2023.09.26.22.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 22:37:54 -0700 (PDT)
Message-ID: <2ad761b8-7228-7a00-4514-45464be549f2@gmail.com>
Date: Wed, 27 Sep 2023 07:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230921214019.926691-1-alexander.deucher@amd.com>
 <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OSqC1MbV1MJr778CEJsLx5HyaVHDsGae7phReoKMCnuQ@mail.gmail.com>
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

I'm still not happy with moving the GART fixed to the end. We abandoned 
this for good reasons.

If we really go this way I would prefer to have this as parameter to the 
amdgpu_gmc_gart_location() function and not in the gmc structure.

Regards,
Christian.

Am 26.09.23 um 19:30 schrieb Alex Deucher:
> Ping on this series?
>
> On Thu, Sep 21, 2023 at 5:46 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> We normally place GART based on the location of VRAM and the
>> available address space around that, but provide an option
>> to force a particular location for hardware that needs it.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  8 ++++++++
>>   2 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index f74a51a93ebb..d1d98488373b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -287,11 +287,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>>                  mc->gart_size = max(size_bf, size_af);
>>          }
>>
>> -       if ((size_bf >= mc->gart_size && size_bf < size_af) ||
>> -           (size_af < mc->gart_size))
>> -               mc->gart_start = 0;
>> -       else
>> +       switch (mc->gart_placement) {
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
>> index dd0ede75e5d7..fcef057b9213 100644
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
>> @@ -339,6 +345,8 @@ struct amdgpu_gmc {
>>          bool flush_tlb_needs_extra_type_0;
>>          bool flush_tlb_needs_extra_type_2;
>>          bool flush_pasid_uses_kiq;
>> +
>> +       enum amdgpu_gart_placement gart_placement;
>>   };
>>
>>   #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
>> --
>> 2.41.0
>>

