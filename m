Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F5FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 12:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251C210E333;
	Thu, 10 Feb 2022 12:27:57 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931DB10E333
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 12:27:56 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id cn6so10604216edb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 04:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ug6paMMwh6VIPeL5z6Fdb+6hWBOdMleUnUZr2PQkcko=;
 b=QXcB/w+8dyiWc2P9r8N440D0CbO4e2Tc8N1BdRpxRQTADXA6AJrG0RCFIuA9Kgw62G
 9TeFzNo9oTs5nIWKCLeQ71JlJHiBekevFxGlsv+d7S8mhS8hyLknVrS/1z8yCJuHxVlh
 LRm/cuKMJTfrtLWgP5DekHJUTRVcq87kuCfic1Wi7tJbOJ9B8o8ZFS9agfB2XgVFXX5j
 XZJViLEzZdf4VL7v5BXmTg8RvfGAfSXDI8zY9Q0/S7r4OuM6V8bCB8bUVV14QYCjwo/N
 dyDWcmM3UJMWCVL0xVvpMLMaXDEU+YuLAyBPBtSO3bTwRhJzk8IH7RcSwB4OX44SWweA
 xplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ug6paMMwh6VIPeL5z6Fdb+6hWBOdMleUnUZr2PQkcko=;
 b=vIqg9OcyD+bArl7CO1Q5wai6IYr+p1TXjkoDLha8wpzI6bsm8C3orn9AgwWKbTTSBD
 Qx7mkX1LZyZiKbNQq/rItJG9BNdvXJ9nM5Zye2mvZgfirnm8NS6eRlAAyf86PiAAAspx
 yl+7K6Ul5qVHkCrhU5LZ2sD9+mlBLv9ileIdT6A6G1zfk5BRMFViqS0idwfXZfkBwgiS
 dVjAcZK9mqRKpitiLLsga5FPVwLEUMXwKLmQVjta4xIcClZ6ao+/OuLZl0Mhv5GPxidS
 qt7Mjox6G3ffJFGzXqKApfYwUCyTxddMRElRnbBCDx2xlMUbBXYDFEXDsXIuamlw5rix
 sD2A==
X-Gm-Message-State: AOAM533OorvTxljBQ9KiFyaQIVyjwPWHuEqb0LvyXK1bMj8sxAjNm8RA
 VuQvCErAfb7cEriQDSml3Rc=
X-Google-Smtp-Source: ABdhPJyKgFEOPRz2WH+dnpLK12TG8t1UCJ6hCqt9FV/9Phw9+At4Hg4m1qdhkSkKmfM7ggb2iixrxQ==
X-Received: by 2002:a05:6402:35d5:: with SMTP id
 z21mr6475782edc.17.1644496075010; 
 Thu, 10 Feb 2022 04:27:55 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id v23sm7158542ejy.178.2022.02.10.04.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Feb 2022 04:27:54 -0800 (PST)
Message-ID: <a6fc864d-47f8-0998-deb2-7ca3ea6685d4@gmail.com>
Date: Thu, 10 Feb 2022 13:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
 <0f1bdc56-6ca3-d343-50de-9b54a39d39a9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <0f1bdc56-6ca3-d343-50de-9b54a39d39a9@amd.com>
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

Am 10.02.22 um 12:59 schrieb Sharma, Shashank:
>
>
> On 2/10/2022 6:29 AM, Somalapuram, Amaranath wrote:
>>
>> On 2/9/2022 1:17 PM, Christian König wrote:
>>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>>> Dump the list of register values to trace event on GPU reset.
>>>>>
>>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>>> ++++++++++++++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 1e651b959141..057922fb7e37 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>>> amdgpu_device *adev,
>>>>>          return r;
>>>>>   }
>>>>>
>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>> +{
>>>>> +       int i;
>>>>> +       uint32_t reg_value[128];
>>>>> +
>>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>>> GC registers.  If we wanted to dump other registers, we'd need a
>>>> different macro.  Might be better to just use RREG32 here for
>>>> everything and then encode the full offset using
>>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>>> MMIO which will adversely affect the hang signature.
>>>
>>> Well this should execute right before a GPU reset, so I think it 
>>> shouldn't matter if we hang the chip or not as long as the read 
>>> comes back correctly (I remember a very long UVD debug session 
>>> because of this).
>>>
>>> But in general I agree, we should just use RREG32() here and always 
>>> encode the full register offset.
>>>
>>> Regards,
>>> Christian.
>>>
>> Can I use something like this:
>>
>> +                       reg_value[i] = 
>> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
>> + [adev->reset_dump_reg_list[i][1]]
>> + [adev->reset_dump_reg_list[i][2]])
>> +                                 + adev->reset_dump_reg_list[i][3]);
>>
>> ip --> adev->reset_dump_reg_list[i][0]
>>
>> inst --> adev->reset_dump_reg_list[i][1]
>>
>> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>>
>> reg --> adev->reset_dump_reg_list[i][3]
>>
>> which requires 4 values in user space for each register.
>>
>> using any existing macro like RREG32_SOC15** will not be able to pass 
>> proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
>>
>
>
> Why cant we use just a simple array
> adev->reset_dump_reg_list[10] for both ip and reg offsets ?

That won't work. The IPs are separated into several base registers, see 
how the SOC15 functions work.

But that's also not necessary. Userspace should have the same 
information as the kernel about which IP is mapped where.

So all we need here is the already resolved 32bit value of which 
register to read and are basically done.

Regards,
Christian.

>
> Userspace can provide the IP engine enum in first entry of the array,
> reset_dump_reg_list[0], and register offsets in other entries starting 
> from 1. We can convert that into desirable engine substring using an 
> array of char *, something like:
>
> const char *ip_engine_name_substing[] = {
>     /* Same order as enum amd_hw_ip_block_type */
>     "GC", "HDP", ......
> }
>
> engine enum;
> u32 ip = adev->reset_dump_reg_list[0];
> const char *ip_name = ip_engine_name_subs[ip];
>
> for (i = 0; i < 9; i++) {
>     reg_val = RREG_SOC15_IP(ip_name, reset_dump_reg_list[i+1]);
> }
>
> - Shashank
>
>>>
>>>>
>>>> Alex
>>>>
>>>>> +                       reg_value[i] = RREG32_SOC15_IP(GC, 
>>>>> adev->reset_dump_reg_list[i]);
>>>>> +               else
>>>>> +                       reg_value[i] = 
>>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>>> +       }
>>>>> +
>>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>>> reg_value, i);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>                           struct amdgpu_reset_context *reset_context)
>>>>>   {
>>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>>> *device_list_handle,
>>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>>                                  if 
>>>>> (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>>                                          r = -EALREADY;
>>>>> -                       } else
>>>>> +                       } else {
>>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>>> +                       }
>>>>>
>>>>>                          if (r) {
>>>>>                                  dev_err(tmp_adev->dev, "ASIC 
>>>>> reset failed with error, %d for drm dev, %s",
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>>                        __entry->seqno)
>>>>>   );
>>>>>
>>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>>> +           TP_ARGS(address, value, length),
>>>>> +           TP_STRUCT__entry(
>>>>> +                            __array(long, address, 128)
>>>>> +                            __array(uint32_t, value, 128)
>>>>> +                            __field(int, len)
>>>>> +                            ),
>>>>> +           TP_fast_assign(
>>>>> +                          memcpy(__entry->address, address, 128);
>>>>> +                          memcpy(__entry->value, value, 128);
>>>>> +                          __entry->len = length;
>>>>> +                          ),
>>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>>> +                     __print_array(__entry->address, 
>>>>> __entry->len, 8),
>>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>>> +                    )
>>>>> +);
>>>>> +
>>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>   #endif
>>>>>
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>

