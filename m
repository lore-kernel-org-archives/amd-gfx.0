Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B4CC6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 06:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B7010F103;
	Fri, 31 Mar 2023 06:51:38 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D9010F103
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 06:51:36 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id ek18so85841787edb.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 23:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680245495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePYowlHVMs9KaXacjyUGkDd+cSmqfZioihB/zFAzqNU=;
 b=ab3tnGocBc6TJFZFfzg5XSk1xofOhzVE63bvQ/f8umYE78I+qEWur/VW6SZ0tT7HOE
 7/6HGl0+ZHElMoxuX3OAObTB7fYo20Scp6J3sUrgxnG2peG1KIde4HdMiJaougX7Q8nb
 aJ+aO93fP8JHTLDQTCgo9Ee5cZaOvuWJlizlKMxOFu8kEM/oQQQJxsK5SJZJ9frHXW4M
 ZPP6HE3rQ2bDINpTDMOyjxBk+f5pV6FCtt+SUFi/Drhkfd11iFHEmHjbUzu5QocP1hWr
 +o34RQH+u951KYXFP1N1MbTrdNK6kjzDhaS9sddSsDgPPYZxGAe1ykicIeeMkoHxxlCB
 2xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680245495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePYowlHVMs9KaXacjyUGkDd+cSmqfZioihB/zFAzqNU=;
 b=RC3HgL6JOK1Ev0EMsD98cG2VlOpdqGXPUAE8N7Me7SL5u9mm26BfecgfnSbkG72g1p
 pldrsvB8EwizaK5jsMVmgq8z4MKOKSS57JekO1tthe+QKmCOAoViMU3DCO2foScYesEx
 yndgBuqT6ZE+HbavpHSaUkAv0Qctjblmvl8N9LG1OTORuAlWyWsZS2wLfOvBOJOYWmTB
 T4JEgNxNWf0qfyxiAftCCNsIkH2WubXU5fyg4OUiCSyx/+dQIIoPKQyJ3axhKPXXL2xD
 zK18uxAhM2hVB+mY5Zj+aDBmedsrDw2ZLrCTLakB9SU3KD2ZEIRSCUd26rTkw6z+R+3P
 rvLA==
X-Gm-Message-State: AAQBX9dtmUgYcPeUYcZWmHJ1VJxy7pk0X4OThqzl9eUvn2wCP7ux5ZP4
 z87lnAU6R6K7/9a0QeeclRM=
X-Google-Smtp-Source: AKy350YEWOkUuQr/s6j0p0Ct+wA4UHBldulHJav5uOVQbO7ImE2+RRUa/IaBMEGecT+NsLR3WEScPw==
X-Received: by 2002:a17:906:da88:b0:945:c4cf:34b7 with SMTP id
 xh8-20020a170906da8800b00945c4cf34b7mr17468275ejb.68.1680245494812; 
 Thu, 30 Mar 2023 23:51:34 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 cw1-20020a170906c78100b0093de5b42856sm635101ejb.119.2023.03.30.23.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 23:51:34 -0700 (PDT)
Message-ID: <623b6bbc-61be-2368-9071-ed907dc2f316@gmail.com>
Date: Fri, 31 Mar 2023 08:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
 <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
 <842f5527-6992-f579-8749-c49d4f9f6e28@gmail.com>
 <CADnq5_OJ7_a750rrsncs4HyPK3K8zkE5nYG+oPMcqJQEfAK2aw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_OJ7_a750rrsncs4HyPK3K8zkE5nYG+oPMcqJQEfAK2aw@mail.gmail.com>
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.03.23 um 15:10 schrieb Alex Deucher:
> On Thu, Mar 30, 2023 at 6:48 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 30.03.23 um 11:15 schrieb Liu, HaoPing (Alan):
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>> Hi Christian,
>>
>>
>>
>> Thanks for the review. Please see inline.
>>
>>
>>
>> Best Regards,
>>
>> Alan
>>
>>
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, March 28, 2023 7:16 PM
>> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
>>
>>
>>
>> Am 27.03.23 um 17:20 schrieb Alan Liu:
>>
>>> [Why]
>>> After gpu-reset, sometimes the driver would fail to enable vblank irq,
>>> causing flip_done timed out and the desktop freezed.
>>> During gpu-reset, we will disable and enable vblank irq in
>>> dm_suspend() and dm_resume(). Later on in
>>> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and decide to enable or disable the irqs again.
>>> However, we have 2 sets of API for controling vblank irq, one is
>>> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>>> its own refcount and flag to store the state of vblank irq, and they
>>> are not synchronized.
>>
>>
>> This is the source of the problem and you should address this instead.
>>
>> The change you suggested below would break in some use cases.
>>
>>
>>
>> In struct drm_vblank_crtc we have a vblank irq refcount controlled by drm layer, and in struct amdgpu_irq_src we have enabled_types as refcount for each irq controlled by the dm.
>>
>> I think the best solution will be to get rid of the refcount in drm and only maintain the dm one, and add a crtc function for the drm layer to get the refcount/state of vblank.
>>
>> But this may be dangerous since it’s a change in drm layer. Do you have any comments?
>>
>>
>> You don't necessarily need to remove it completely, what you can do as well is properly chaining of them.
>>
>> E.g. when the DRM counter goes from 0->1 or 1->0 it calls some function to enable/disable the hw irq. In this situation you call amdgpu_irq_get()/amdgpu_irq_put() as appropriate.
>>
>> The the code in this patch already looks like it goes into the right direction regarding that. It just seems to be that you have some race issues when you need to add checks that the IRQ counter doesn't goes below 0.
>>
> I think the problem is that atomic in general is not GPU reset
> compatible.  GPU resets sort of happen outside of the standard atomic
> flow.  So the DRM level interrupts will keep their original state, but
> internally, the driver has to deal with the fact that we need to
> re-enable interrupts as part of the reset sequence.

If I'm not completely mistaken we already do update all the interrupt 
state after a GPU reset.

I think what could potentially happen here is that we try to update the 
state while *inside* the GPU reset.

This basically means we just need to grab the appropriate locks.

Christian.

>
> Alex
>
>
>>
>>> In drm we use the first API to control vblank irq but in
>>> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>>> The failure happens when vblank irq was enabled by dm_vblank_get()
>>> before gpu-reset, we have vblank->enabled true. However, during
>>> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>>> checked from
>>> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
>>> again. After gpu-reset, if there is a cursor plane commit, the driver
>>> will try to enable vblank irq by calling drm_vblank_enable(), but the
>>> vblank->enabled is still true, so it fails to turn on vblank irq and
>>> causes flip_done can't be completed in vblank irq handler and desktop
>>> become freezed.
>>> [How]
>>> Combining the 2 vblank control APIs by letting drm's API finally calls
>>> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>>> synchronized. Also add a check to prevent refcount from being less
>>> then
>>> 0 in amdgpu_irq_put().
>>> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
>>>    2 files changed, 13 insertions(+), 4 deletions(-)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> index a6aef488a822..1b66003657e2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>>>             if (!src->enabled_types || !src->funcs->set)
>>>                            return -EINVAL;
>>> +         if (!amdgpu_irq_enabled(adev, src, type))
>>> +                       return 0;
>>> +
>>
>>
>> That is racy and won't work. The intention of amdgpu_irq_update() is to always update the irq state, no matter what the status is.
>>
>>
>>
>> This is a change to amdgpu_irq_put() to prevent the refcount from being cut to less than 0. Does it break the intention of amdgpu_irq_update()?
>>
>>
>> Yes, exactly that. The reference count can *never* be below 0 or you have a bug in the caller.
>>
>> What you could do is to add a WARN_ON(!amdgpu_irq_enabled(adev, src, type)), but just ignoring the call is an absolute no-go.
>>
>> Regards,
>> Christian.
>>
>> PS: Please don't use HTML formating when discussing on public mailing lists.
>>
>>
>>
>> Regards,
>>
>> Christian.
>>
>>
>>
>>>             if (atomic_dec_and_test(&src->enabled_types[type]))
>>>                            return amdgpu_irq_update(adev, src, type);
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index dc4f37240beb..e04f846b0b19 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct
>>> work_struct *work)
>>>    static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>>    {
>>> -          enum dc_irq_source irq_source;
>>> +         int irq_type;
>>>             struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>>>             struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>>>             struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
>>> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>>>             if (rc)
>>>                            return rc;
>>> -          irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
>>> +         irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>>> +acrtc->crtc_id);
>>> +
>>> +         if (enable)
>>> +                       rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
>>> +
>>> +         else
>>> +                       rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
>>> -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>>> -                        return -EBUSY;
>>> +         if (rc)
>>> +                       return rc;
>>>    skip:
>>>             if (amdgpu_in_reset(adev))
>>
>>
>>

