Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8C6C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 13:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3812B112320;
	Wed,  8 Jun 2022 13:58:15 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBB4112313
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 13:58:13 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id v19so27201370edd.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jun 2022 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JdlJdW8ELxaRsjMlJjis+KVdOMevuIkcJ5i0rxXts0A=;
 b=YWobAyJukZrgYt4qpNVVvvUwxI753RdSB6o0oz4CZ8c1OKzp+bMybrHq7KJ8klFQ8s
 jhnYL73fFC39Iyb/zs6YS6C1E10DRIV/EuQLvUP7Y7aPIUEasf/fDrXIpGPAoLq7fLnd
 1FO7Sg/X1F8Qc2UpZUB67CO57Ij5eEX24eA357QLq3b7XjKz83kgpdPOardDJNHNH9hm
 BQGYQ0kvIOIU4tzJczuDESroF73MvfHU5P5+NTvwdX0edp/9u5ZGl8w5JFwlySI0DaTM
 i0c5bo7k6/91F8AvQrIQNFjiZZ8mKx/MSW+vnMrY5QSaz7P0qxa8h4IY9wRTF5J8G4EF
 pWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JdlJdW8ELxaRsjMlJjis+KVdOMevuIkcJ5i0rxXts0A=;
 b=UNm4qOWy0jbGJ8KogWX55vfNipbhFZ15GQzacf082Ue63s7xIQ02EhgAEGXYUo9GVu
 1+Kb5KUSYNFZECp81sg8hRtF64CDSJBSusVS7aRRTcYxoqp9tBaV7hvvfbwnu6YraWk4
 eTJT2LiPPy/WDlUetRR0jM8YVVaqN6HBp3x27kOIDCID01zEXqeen77qGUcqWfSnAeYw
 4Mdd5MvahheJF3qbYi+7fp9NJ9Kq2QpRw23X4qjlpOkP9ehlbnXmDT+isOcpaBLSwdNZ
 weccMTm/Pido/vxSFwCiD12LZpCph8QKwINZDs3c1Ma90Ifcq023fCfftJPDPgq1jdPb
 +KTw==
X-Gm-Message-State: AOAM530Sw3Psq8fNBTSFQz+z9UvXHrh09Nae1jU0jVfLZRAh/UHb1UZT
 Tfpbc23o3vlq14kSFxzyiCbvj3adQBY=
X-Google-Smtp-Source: ABdhPJzE3tM+5SPto7AodKfJxr7ZHywxwCEX1gLHEOfks45p79u8wBsBngmfkdaXKh5sRvUc4zkcGQ==
X-Received: by 2002:a05:6402:2706:b0:430:6238:78d5 with SMTP id
 y6-20020a056402270600b00430623878d5mr27080331edd.413.1654696692090; 
 Wed, 08 Jun 2022 06:58:12 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:2f36:54a0:e1ea:c1ad?
 ([2a02:908:1256:79a0:2f36:54a0:e1ea:c1ad])
 by smtp.gmail.com with ESMTPSA id
 u2-20020aa7d982000000b0042ab4e20543sm12301036eds.48.2022.06.08.06.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 06:58:11 -0700 (PDT)
Message-ID: <eaf1d004-4386-2008-071b-abbabeb0cc81@gmail.com>
Date: Wed, 8 Jun 2022 15:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: always flush the TLB on gfx8
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220603130504.81147-1-christian.koenig@amd.com>
 <CADnq5_OxrThyuAa0z9pK7FxJ=NoOj9yoezM4aC0_sL=UUPOXBw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OxrThyuAa0z9pK7FxJ=NoOj9yoezM4aC0_sL=UUPOXBw@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.06.22 um 22:27 schrieb Alex Deucher:
> On Fri, Jun 3, 2022 at 9:05 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> The TLB on GFX8 stores each block of 8 PTEs where any of the valid bits
>> are set.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex could you push this? It's an important fix, but I'm seriously not 
feeling well at the moment.

Thanks,
Christian.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9596c22fded6..b747488c28ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>          flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
>>                       adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0);
>>
>> +       /*
>> +        * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
>> +        */
>> +       flush_tlb |= adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0);
>> +
>>          memset(&params, 0, sizeof(params));
>>          params.adev = adev;
>>          params.vm = vm;
>> --
>> 2.25.1
>>

