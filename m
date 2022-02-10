Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D0BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 14:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70F410E87E;
	Thu, 10 Feb 2022 14:05:50 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9185B10E87E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 14:05:49 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id p24so15661924ejo.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=I8Y1Ph9XK4oOPYI0kvZSA0jcZSGKRHEQj+gHnlAn4k4=;
 b=cQmnlZTX5yEM0gPSxo5PSFSBy+9THba16ru+c/zrE8mcJF4dO5X3jA1kjZ8+1TQK+/
 wq8e3X/utCDnU6Yof7LnugiEQ8T/JxUHnVyhTJjaoE++bmVYBK/VvgNWtd8YdOlRsieG
 3JW4oGasknZSUJ8LatSluIxxIoYyn0veeRjlHxpWZe3/VuhZVJiUoeMj9tA70dje0VZ9
 xXCtuLCc5NfcMW0YNCJqYD1UfM2lZzUQZ4J+IVQzqzGXZH5SGstWcE85tWwCcYgpcRF1
 tDNnuqJDEjK8LEMKnB9nIbMJ8TwS5OjmsCrEOvOimb8puMwNg3lplMhwt1pjl8rTooav
 LHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=I8Y1Ph9XK4oOPYI0kvZSA0jcZSGKRHEQj+gHnlAn4k4=;
 b=sWBM1eGV8yoW04O0HjIHIV6LZ72Vskel3jtkA7MwGpnESI0Flymzx03Azc1LqfgQtI
 e4seyCgQsln4cOweuq3nqd+FTkIAHPGtjaNhfDIDmoFOzDvj5g5nAkOJTMXF7J5ibaBL
 KQpZaQ19l6pS8yr4XINH+FUaj62zbjr4wFk8Hn6peg/l2f9qZt2gaO/+imzHSvoXcNSv
 0FX+nEDL6GKKddFd++e9WF+ncmBLvnCIgUdd9KKMWAcXJ9AHFxPkaNvHYUcrY2P1us0k
 I5DhgrL+h+EPIJYnYNZOf6gy/M0uGV9wM7b3RXR+BvanGK2T3wDoanW3jZvACrO6bU9/
 SqYQ==
X-Gm-Message-State: AOAM533ZIr7i+1rYCsA1+/E+7juyKnazSyupRJ3FlYhW2Dvjgbgj8dEx
 xLLrE7plxdPYI0epMS3oySFa7qRzzJg=
X-Google-Smtp-Source: ABdhPJxCWwLd2a5pUT8kXGfBHUzUlnCvY/nU7vdSN2H6h4HwBixNTwwq2Nk4nQ/xBv/PmCeyBvFkAg==
X-Received: by 2002:a17:907:629f:: with SMTP id
 nd31mr6503439ejc.693.1644501947847; 
 Thu, 10 Feb 2022 06:05:47 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id r10sm7165226ejy.148.2022.02.10.06.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 06:05:47 -0800 (PST)
Message-ID: <ef597684-c5e7-cea5-a502-ab1434b0094d@gmail.com>
Date: Thu, 10 Feb 2022 15:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
 <01cbfbe8-c08a-e7a8-7e23-bc1ccc5c32f1@amd.com>
 <d2a93513-c199-c4f4-7564-da58f3bb2120@amd.com>
 <2c30cea6-7db0-92e9-b884-5967a9b95bd7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <2c30cea6-7db0-92e9-b884-5967a9b95bd7@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.02.22 um 14:18 schrieb Sharma, Shashank:
>
>
> On 2/10/2022 8:38 AM, Christian König wrote:
>> Am 10.02.22 um 08:34 schrieb Somalapuram, Amaranath:
>>>
>>> On 2/10/2022 12:39 PM, Christian König wrote:
>>>> Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>>>>>
>>>>> On 2/9/2022 1:17 PM, Christian König wrote:
>>>>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>>>>
>>>>>>>> Signed-off-by: Somalapuram Amaranath 
>>>>>>>> <Amaranath.Somalapuram@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>>>>> ++++++++++++++++++++-
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 
>>>>>>>> +++++++++++++++++++
>>>>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 1e651b959141..057922fb7e37 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>>          return r;
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>> +{
>>>>>>>> +       int i;
>>>>>>>> +       uint32_t reg_value[128];
>>>>>>>> +
>>>>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>>>>> This check should be against CHIP_VEGA10.  Also, this only 
>>>>>>> allows for
>>>>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>>>>> different macro.  Might be better to just use RREG32 here for
>>>>>>> everything and then encode the full offset using
>>>>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to 
>>>>>>> think
>>>>>>> about how to handle gfxoff in this case.  gfxoff needs to be 
>>>>>>> disabled
>>>>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>>>>> MMIO which will adversely affect the hang signature.
>>>>>>
>>>>>> Well this should execute right before a GPU reset, so I think it 
>>>>>> shouldn't matter if we hang the chip or not as long as the read 
>>>>>> comes back correctly (I remember a very long UVD debug session 
>>>>>> because of this).
>>>>>>
>>>>>> But in general I agree, we should just use RREG32() here and 
>>>>>> always encode the full register offset.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>> Can I use something like this:
>>>>>
>>>>> +                       reg_value[i] = 
>>>>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>>>>> + [adev->reset_dump_reg_list[i][1]]
>>>>> + [adev->reset_dump_reg_list[i][2]])
>>>>> +                                 + adev->reset_dump_reg_list[i][3]);
>>>>>
>>>>> ip --> adev->reset_dump_reg_list[i][0]
>>>>>
>>>>> inst --> adev->reset_dump_reg_list[i][1]
>>>>>
>>>>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>>>>
>>>>> reg --> adev->reset_dump_reg_list[i][3]
>>>>
>>>> No, that won't work.
>>>>
>>>> What you need to do is to use the full 32bit address of the 
>>>> register. Userspace can worry about figuring out which ip, 
>>>> instance, base and reg to resolve into that address.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> Thanks Christian.
>>>
>>> should I consider using gfxoff like below code or not required:
>>> amdgpu_gfx_off_ctrl(adev, false);
>>> amdgpu_gfx_off_ctrl(adev, true);
>>
>> That's a really good question I can't fully answer.
>>
>> I think we don't want that because the GPU is stuck when the dump is 
>> made, but better let Alex comment as well.
>>
>> Regards,
>> Christian.
>
>
> I had a quick look at the function amdgpu_gfx_off_ctrl, and it locks 
> this mutex internally:
> mutex_lock(&adev->gfx.gfx_off_mutex);
>
> and the reference state is tracked in:
> adev->gfx.gfx_off_state
>
> We can do something like this maybe:
> - If (adev->gfx_off_state == 0) {
>   trylock(gfx_off_mutex)
>   read_regs_now;
>   unlock_mutex();
> }
>
> How does it sounds ?

As far as I know that won't work. GFX_off is only disabled intentionally 
in very few places.

So we will probably never get a register trace with that.

Regards,
Christian.

>
> - Shashank
>>
>>>
>>>
>>> Regards,
>>>
>>> S.Amarnath
>>>>>
>>>>> which requires 4 values in user space for each register.
>>>>>
>>>>> using any existing macro like RREG32_SOC15** will not be able to 
>>>>> pass proper argument from user space (like ip##_HWIP or 
>>>>> reg##_BASE_IDX)
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> + reg_value[i] = RREG32_SOC15_IP(GC, 
>>>>>>>> adev->reset_dump_reg_list[i]);
>>>>>>>> +               else
>>>>>>>> +                       reg_value[i] = 
>>>>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>>>>> reg_value, i);
>>>>>>>> +
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>                           struct amdgpu_reset_context 
>>>>>>>> *reset_context)
>>>>>>>>   {
>>>>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct 
>>>>>>>> list_head *device_list_handle,
>>>>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>>>>                                  if 
>>>>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>>>>                                          r = -EALREADY;
>>>>>>>> -                       } else
>>>>>>>> +                       } else {
>>>>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>>>>> +                       }
>>>>>>>>
>>>>>>>>                          if (r) {
>>>>>>>> dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for 
>>>>>>>> drm dev, %s",
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>>>>                        __entry->seqno)
>>>>>>>>   );
>>>>>>>>
>>>>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>>>>> +           TP_ARGS(address, value, length),
>>>>>>>> +           TP_STRUCT__entry(
>>>>>>>> +                            __array(long, address, 128)
>>>>>>>> +                            __array(uint32_t, value, 128)
>>>>>>>> +                            __field(int, len)
>>>>>>>> +                            ),
>>>>>>>> +           TP_fast_assign(
>>>>>>>> + memcpy(__entry->address, address, 128);
>>>>>>>> +                          memcpy(__entry->value, value, 128);
>>>>>>>> +                          __entry->len = length;
>>>>>>>> +                          ),
>>>>>>>> +           TP_printk("amdgpu register dump offset: %s value: 
>>>>>>>> %s ",
>>>>>>>> + __print_array(__entry->address, __entry->len, 8),
>>>>>>>> + __print_array(__entry->value, __entry->len, 8)
>>>>>>>> +                    )
>>>>>>>> +);
>>>>>>>> +
>>>>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>>>>   #endif
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> 2.25.1
>>>>>>>>
>>>>>>
>>>>
>>

