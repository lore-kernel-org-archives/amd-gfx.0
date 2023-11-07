Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD9AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 10:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DCC10E50D;
	Tue,  7 Nov 2023 10:52:57 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5523610E50D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 10:52:55 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so40778685e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Nov 2023 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699354374; x=1699959174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwNSaQdD3CzQHgtbo/PtYj1Dpuy2Q+ZL/K2jVdWFmeE=;
 b=Eba9jB7LfwnWqTJT0NG42j2yLo72ADnkplUBv2yXDkaFcXqb3Ee+eV6f2Cpum2NOga
 vr6BTFOwunnWTjo/YzlUuQxiZD4LIl96o8PVb6TgjGQGnrB6G2QUcpgwrsHLFGy0OEDZ
 bglMDBhEY/9Vs0vPenCMycj4/lRMcWZmqZlrUjR3KMT0XOGjg+UoxT/B8Pm6EZXNayUE
 6Ol68/istjBkYzSloHrYLqebjgCgpomzdYe8NDsT+wzmMqAj9YwFhZngk0n45g3rJdi2
 W+ckGWQ7JiCAl3fBqA0Hy60JJJFHxCajbrrXMZLJIeBL7ew1slk8YCsC9LUGadTPUctt
 xctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699354374; x=1699959174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwNSaQdD3CzQHgtbo/PtYj1Dpuy2Q+ZL/K2jVdWFmeE=;
 b=xICf5lFQALFecsSyIx8qBPNn8wRy2tm8Hgd7j+W+Dh0jdQDVkvy+a3tRwm7aZx6+Tl
 OyHHVq4SrK/csUs1DJA2UD7qEL6UlIZUveonP7SsRadpt1wJLwfXscn1f/zHMeX4XKZx
 FgPVF3CIPndpH9kbioL6x7XlUVhnQQ23/WFbBPpClXX44UdkA8riDApNgMF3uYpnKVgE
 q2bRBudpNL2WcmbVPw/0VRpSda8Jzole/msrxPS9NZhzux7bo/lxRdDlQOgcPWuNiKyX
 IdxHgP7r+BeOEnHPhRSy9+iU3erjMgcyd1gm1hSZYN5t2be1TTrx5VDylbr93MUQjemF
 89cA==
X-Gm-Message-State: AOJu0YxC29ghHaLb/FjzFmgOhPMmOnowLzqtUBqYd2Wf5EwwRaCKOM9O
 9ScWVZ20jv9qDM9Yk4cscrE=
X-Google-Smtp-Source: AGHT+IH1lgB+kyzvCZ20QP5TkrliACWVigCXXMeGHkn4HcbutpC4TtmGgwmOsmrZbp5vqNhD8ez7Wg==
X-Received: by 2002:a05:600c:1992:b0:408:3f61:cb4f with SMTP id
 t18-20020a05600c199200b004083f61cb4fmr1949504wmq.23.1699354373264; 
 Tue, 07 Nov 2023 02:52:53 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004094d4292aesm15100303wmo.18.2023.11.07.02.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:52:52 -0800 (PST)
Message-ID: <bfb3d504-61c9-43e8-b3b3-2d8193e54d81@gmail.com>
Date: Tue, 7 Nov 2023 11:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Luben Tuikov <ltuikov89@gmail.com>, 
 Leo Liu <leo.liu@amd.com>
References: <20231025171928.3318505-1-alexander.deucher@amd.com>
 <96db9e3d-4636-4da4-b4d1-ca3f5fd8d887@gmail.com>
 <CADnq5_ORyv9MDfUd3NPDw+APUunDjkTW4Bx4z0FoCiK+s_i+uw@mail.gmail.com>
 <04db543c-7aec-4550-878f-a9753142130e@gmail.com>
 <a8a0eb47-3aca-4c87-b5f7-dc54e5667944@gmail.com>
 <CADnq5_PS64jYS_Y3kGW27m-kuWP+FQFiaVcOaZiB=JLSgPnXBQ@mail.gmail.com>
 <CADnq5_MBgNQPzZmvBagzUdi94X=rr-h=aaE334RzVozgOHU64g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MBgNQPzZmvBagzUdi94X=rr-h=aaE334RzVozgOHU64g@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.11.23 um 23:10 schrieb Alex Deucher:
> On Fri, Nov 3, 2023 at 4:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Thu, Oct 26, 2023 at 4:17 PM Luben Tuikov <ltuikov89@gmail.com> wrote:
>>> Pushed to drm-misc-next.
>> BTW, I'm seeing the following on older GPUs with VCE and UVD even with
>> this patch:
>> [   11.886024] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
>> entity has no rq!
>> [   11.886028] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
>> [amdgpu]] *ERROR* IB test failed on uvd (-2).
>> [   11.889927] amdgpu 0000:0a:00.0: [drm] *ERROR* drm_sched_job_init:
>> entity has no rq!
>> [   11.889930] amdgpu 0000:0a:00.0: [drm:amdgpu_ib_ring_tests
>> [amdgpu]] *ERROR* IB test failed on vce0 (-2).
>> [   11.890172] [drm:process_one_work] *ERROR* ib ring test failed (-2).
>> Seems to be specific to UVD and VCE, I don't see anything similar with
>> VCN, but the flows for both are pretty similar.  Not sure why we are
>> not seeing it for VCN.  Just a heads up if you have any ideas.  Will
>> take a closer look next week.
> + Leo
>
> I found the problem.  We set up scheduling entities for UVD and VCE
> specifically and not for any other engines.  I don't remember why
> offhand.  I'm guessing maybe to deal with the session limits on UVD
> and VCE?  If so I'm not sure of a clean way to fix this.

I haven't looked through all my mails yet so could be that Leo has 
already answered this.

The UVD/VCE entities are used for the older chips where applications 
have to use create/destroy messages to the firmware.

If an application exits without cleaning up their handles the kernel 
sends the appropriate destroy messages itself. For an example see 
amdgpu_uvd_free_handles().

We used to initialize those entities with separate calls after the 
scheduler had been brought up, see amdgpu_uvd_entity_init() for an example.

But this was somehow messed up and we now do the call to 
amdgpu_uvd_entity_init() at the end of *_sw_init() instead of _late_init().

I suggest to just come up with a function which can be used for the 
late_init() callback of the UVD/VCE blocks.

Christian.

>
> Alex
>
>> Alex
>>
>>> Regards,
>>> Luben
>>>
>>> On 2023-10-26 15:52, Luben Tuikov wrote:
>>>> On 2023-10-26 15:32, Alex Deucher wrote:
>>>>> On Thu, Oct 26, 2023 at 2:22 AM Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>> Am 25.10.23 um 19:19 schrieb Alex Deucher:
>>>>>>> Rather than doing this in the IP code for the SDMA paging
>>>>>>> engine, move it up to the core device level init level.
>>>>>>> This should fix the scheduler init ordering.
>>>>>>>
>>>>>>> v2: drop extra parens
>>>>>>> v3: drop SDMA helpers
>>>>>>>
>>>>>>> Tested-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> I don't know of hand if the high level function really cover everything,
>>>>>> so only Acked-by: Christian König <christian.koenig@amd.com> for now.
>>>>>>
>>>>> Luben,
>>>>>
>>>>> Was this needed for some of the scheduler stuff that is pending?  If
>>>>> you would rather take it via drm-misc to align with the scheduler
>>>>> changes, that works for me, otherwise I can take it via the amdgpu
>>>>> tree.
>>>> Hi Alex,
>>>>
>>>> Yes, it does.
>>>>
>>>> I can take it via drm-misc-next as that where the scheduler changes landed.
>>>>
>>>> I'll add Christian's Acked-by.
>>>>
>>>> I'll add a Fixes tag because ideally it should've gone before the dynamic
>>>> sched_rq commit.
>>>>
>>>> Thanks for the heads-up!
>>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>
>>>>
>>>>> Thanks,
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ---------------------
>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
>>>>>>>    drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
>>>>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
>>>>>>>    drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
>>>>>>>    11 files changed, 19 insertions(+), 84 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 2031a467b721..5c90080e93ba 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>        if (r)
>>>>>>>                goto init_failed;
>>>>>>>
>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>> +
>>>>>>>        /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>        if (!adev->gmc.xgmi.pending_reset) {
>>>>>>>                kgd2kfd_init_zone_device(adev);
>>>>>>> @@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>>>>>>>                amdgpu_virt_request_full_gpu(adev, false);
>>>>>>>        }
>>>>>>>
>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>>>>>> +
>>>>>>>        r = amdgpu_device_ip_suspend_phase1(adev);
>>>>>>>        if (r)
>>>>>>>                return r;
>>>>>>> @@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>>>>>>
>>>>>>>        r = amdgpu_device_ip_resume_phase2(adev);
>>>>>>>
>>>>>>> +     if (adev->mman.buffer_funcs_ring->sched.ready)
>>>>>>> +             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>> +
>>>>>>>        return r;
>>>>>>>    }
>>>>>>>
>>>>>>> @@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>>>>>>        /* disable ras feature must before hw fini */
>>>>>>>        amdgpu_ras_pre_fini(adev);
>>>>>>>
>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>>>>>> +
>>>>>>>        amdgpu_device_ip_fini_early(adev);
>>>>>>>
>>>>>>>        amdgpu_irq_fini_hw(adev);
>>>>>>> @@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>>>>>>>
>>>>>>>        amdgpu_ras_suspend(adev);
>>>>>>>
>>>>>>> +     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>>>>>> +
>>>>>>>        amdgpu_device_ip_suspend_phase1(adev);
>>>>>>>
>>>>>>>        if (!adev->in_s0ix)
>>>>>>> @@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>                                if (r)
>>>>>>>                                        goto out;
>>>>>>>
>>>>>>> +                             if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
>>>>>>> +                                     amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
>>>>>>> +
>>>>>>>                                if (vram_lost)
>>>>>>>                                        amdgpu_device_fill_reset_magic(tmp_adev);
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> index e8cbc4142d80..1d9d187de6ee 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> @@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>>>>>>>        return err;
>>>>>>>    }
>>>>>>>
>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
>>>>>>> -{
>>>>>>> -     struct amdgpu_ring *sdma;
>>>>>>> -     int i;
>>>>>>> -
>>>>>>> -     for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>> -             if (adev->sdma.has_page_queue) {
>>>>>>> -                     sdma = &adev->sdma.instance[i].page;
>>>>>>> -                     if (adev->mman.buffer_funcs_ring == sdma) {
>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>>>>>> -                             break;
>>>>>>> -                     }
>>>>>>> -             }
>>>>>>> -             sdma = &adev->sdma.instance[i].ring;
>>>>>>> -             if (adev->mman.buffer_funcs_ring == sdma) {
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>>>>>> -                     break;
>>>>>>> -             }
>>>>>>> -     }
>>>>>>> -}
>>>>>>> -
>>>>>>>    int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
>>>>>>>    {
>>>>>>>        int err = 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> index 513ac22120c1..173a2a308078 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> @@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>>>>>>>                               bool duplicate);
>>>>>>>    void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>>>>>>>            bool duplicate);
>>>>>>> -void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>>>>>>>    int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>>>>>>>
>>>>>>>    #endif
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>>>> index ee5dce6f6043..a3fccc4c1f43 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>>>> @@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>>>>>>>                rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
>>>>>>> @@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>>>> index b58a13bd75db..45377a175250 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>>>> @@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
>>>>>>> @@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>>>> index c5ea32687eb5..2ad615be4bb3 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>>>> @@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
>>>>>>> @@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>>> index 683d51ae4bf1..3d68dd5523c6 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>>> @@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
>>>>>>> @@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
>>>>>>> @@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
>>>>>>>                        r = amdgpu_ring_test_helper(page);
>>>>>>>                        if (r)
>>>>>>>                                return r;
>>>>>>> -
>>>>>>> -                     if (adev->mman.buffer_funcs_ring == page)
>>>>>>> -                             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>                }
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return r;
>>>>>>> @@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
>>>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
>>>>>>> -             /* disable the scheduler for SDMA */
>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>>>>                return 0;
>>>>>>> -     }
>>>>>>>
>>>>>>>        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
>>>>>>>                for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>> @@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
>>>>>>>        if (adev->in_s0ix) {
>>>>>>>                sdma_v4_0_enable(adev, true);
>>>>>>>                sdma_v4_0_gfx_enable(adev, true);
>>>>>>> -             amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>                return 0;
>>>>>>>        }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>>>> index be5d099c9898..c78027ebdcb9 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>>>> @@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
>>>>>>> @@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> @@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
>>>>>>>    {
>>>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>>>
>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
>>>>>>> -             /* disable the scheduler for SDMA */
>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>>>>                return 0;
>>>>>>> -     }
>>>>>>>
>>>>>>>        sdma_v5_0_ctx_switch_enable(adev, false);
>>>>>>>        sdma_v5_0_enable(adev, false);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>> index a3e8b10c071c..2e35f3571774 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>>>> @@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
>>>>>>> @@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> @@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>>>>>>>    {
>>>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>>>
>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
>>>>>>> -             /* disable the scheduler for SDMA */
>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>>>>                return 0;
>>>>>>> -     }
>>>>>>>
>>>>>>>        sdma_v5_2_ctx_switch_enable(adev, false);
>>>>>>>        sdma_v5_2_enable(adev, false);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>>>> index 445a34549d2c..1c6ff511f501 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>>>> @@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl, ib_cntl;
>>>>>>>        int i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
>>>>>>>                rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 0);
>>>>>>> @@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;
>>>>>>> @@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
>>>>>>>    {
>>>>>>>        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>>>
>>>>>>> -     if (amdgpu_sriov_vf(adev)) {
>>>>>>> -             /* disable the scheduler for SDMA */
>>>>>>> -             amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> +     if (amdgpu_sriov_vf(adev))
>>>>>>>                return 0;
>>>>>>> -     }
>>>>>>>
>>>>>>>        sdma_v6_0_ctxempty_int_enable(adev, false);
>>>>>>>        sdma_v6_0_enable(adev, false);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>>>>>> index 42c4547f32ec..9aa0e11ee673 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>>>>>> @@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
>>>>>>>        u32 rb_cntl;
>>>>>>>        unsigned i;
>>>>>>>
>>>>>>> -     amdgpu_sdma_unset_buffer_funcs_helper(adev);
>>>>>>> -
>>>>>>>        for (i = 0; i < adev->sdma.num_instances; i++) {
>>>>>>>                /* dma0 */
>>>>>>>                rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
>>>>>>> @@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *adev)
>>>>>>>                r = amdgpu_ring_test_helper(ring);
>>>>>>>                if (r)
>>>>>>>                        return r;
>>>>>>> -
>>>>>>> -             if (adev->mman.buffer_funcs_ring == ring)
>>>>>>> -                     amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>>>>>        }
>>>>>>>
>>>>>>>        return 0;

