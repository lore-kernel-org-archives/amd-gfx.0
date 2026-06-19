Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4192DCDB46F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 08:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE0110E1B2;
	Sat, 20 Jun 2026 08:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="eqD6WQuC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634FA10E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eNgQCvSsoI1Sx7xFawjITb2f7T6ee77P38xxBoF8f2Q=; b=eqD6WQuCn8zHcceaZqJxPc0hqR
 WZ5WUv+ZL+9HO3A115Bd3Eb+ZP5pe1eJUuWZneon8XCCDERaobnzDEP60RDnBZXp+50+1GI39rf3m
 kLCYRbe2bjZFaUNXcvR36dWvYXe1ljaR4R+GmNGaUEB3i7O2s5SYtzuAuLqNwpG60KWHCzVGy0Yu0
 zHfY4FJTUzPy4CbJrR0kwxOd/tKyvlol+55K79ddjb/kGPDycdKtjwAT6ju1A7dH7ntN0cw+ZPiL/
 rCzCAgOuM7hiGSfCiR9a45RI7IipYNZ4Jln+LLockx/uYwooL9pi6OiphVG4das431EIVmQQ2l8le
 V8En+3vw==;
Received: from [37.209.163.134] (helo=[172.16.30.123])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wacXK-002bZd-Eq; Fri, 19 Jun 2026 18:57:46 +0200
Message-ID: <55a72da8-e81c-43e7-bb9c-6f0e070cbae8@igalia.com>
Date: Fri, 19 Jun 2026 18:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Choose SOC15 RLC register read write
 functions at init time
To: Alex Deucher <alexdeucher@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260424125003.52366-1-tvrtko.ursulin@igalia.com>
 <8693b119-f870-43eb-ac8d-f4c69419693e@igalia.com>
 <CADnq5_Pga5tgYgnf3gbnL10uCf9pRvv87=U1TYprgPR_c9NFeg@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@igalia.com>
In-Reply-To: <CADnq5_Pga5tgYgnf3gbnL10uCf9pRvv87=U1TYprgPR_c9NFeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 08:50:44 +0000
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


On 16/06/2026 16:01, Alex Deucher wrote:
> On Tue, Jun 9, 2026 at 11:06 AM Tvrtko Ursulin
> <tvrtko.ursulin@igalia.com> wrote:
>>
>> + Alex - wondering you you are interested in this type of a thing or I
>> should drop it? Unless I am missing something (could be, it was long
>> time ago when I first wrote it), it is a nice .text saving of pointless
>> conditionals.
> Yes, sorry for the delay.  This just fell off my radar.  I've applied
> the series.

Thank you!

Were you just brave by pulling all three of my series, or they actually 
passed internal CI this time? :)

Anyway, I am around to fix any fallout, if there will be, and if reverts 
will not be a more suitable course of action.

Regards,

Tvrtko
>> Regards,
>>
>> Tvrtko
>>
>> On 24/04/2026 13:50, Tvrtko Ursulin wrote:
>>> Currently on every RLC register read the driver checks for three different
>>> conditions to decide which of the two register read/write functions to
>>> call.
>>>
>>> As these register operations are macros, which is required for register
>>> name expansion to work, the result is a significant explosion of generated
>>> (redundant) code which the compiler cannot optimise away.
>>>
>>> We however know that all of the three conditional are static and can
>>> therefore move the decision to driver init time. All that we need to do is
>>> define a new vfunc table for the SOC12 RLC read/write functions and just
>>> use them directly.
>>>
>>> Bloat-o-meter agrees the driver size savings are significant:
>>>
>>> add/remove: 11/35 grow/shrink: 82/1117 up/down: 53024/-450922 (-397898)
>>> ...
>>> Total: Before=10293928, After=9896030, chg -3.87%
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 ++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  8 ++---
>>>    10 files changed, 64 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 30ce2e85a506..bd1b0e9ee220 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3745,6 +3745,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>        mutex_init(&adev->gfx.workload_profile_mutex);
>>>        mutex_init(&adev->vcn.workload_profile_mutex);
>>>
>>> +     amdgpu_early_init_rlc_reg_funcs(adev);
>>>        amdgpu_device_init_apu_flags(adev);
>>>
>>>        r = amdgpu_device_check_arguments(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>>> index 572a60e1b3cb..002fae3c380e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>>> @@ -583,3 +583,42 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
>>>                amdgpu_gfx_rlc_init_microcode_v2_5(adev);
>>>        return 0;
>>>    }
>>> +
>>> +static const struct amdgpu_rlc_reg_funcs amdgpu_sriov_rlc_reg_funcs = {
>>> +     .rreg32 = amdgpu_sriov_rreg,
>>> +     .wreg32 = amdgpu_sriov_wreg,
>>> +};
>>> +
>>> +static u32
>>> +amdgpu_rlc_rreg(struct amdgpu_device *adev, u32 reg, u32 acc_flags, u32 hwip,
>>> +             u32 xcc_id)
>>> +{
>>> +     return amdgpu_device_rreg(adev, reg, 0);
>>> +}
>>> +
>>> +static void
>>> +amdgpu_rlc_wreg(struct amdgpu_device *adev, u32 reg, u32 value, u32 acc_flags,
>>> +             u32 hwip, u32 xcc_id)
>>> +{
>>> +     amdgpu_device_wreg(adev, reg, value, 0);
>>> +}
>>> +
>>> +static const struct amdgpu_rlc_reg_funcs amdgpu_rlc_reg_funcs = {
>>> +     .rreg32 = amdgpu_rlc_rreg,
>>> +     .wreg32 = amdgpu_rlc_wreg,
>>> +};
>>> +
>>> +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev)
>>> +{
>>> +     adev->gfx.rlc.reg_funcs = &amdgpu_rlc_reg_funcs;
>>> +}
>>> +
>>> +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev)
>>> +{
>>> +     if (amdgpu_sriov_vf(adev) &&
>>> +         adev->gfx.rlc.funcs &&
>>> +         adev->gfx.rlc.rlcg_reg_access_supported)
>>> +             adev->gfx.rlc.reg_funcs = &amdgpu_sriov_rlc_reg_funcs;
>>> +     else
>>> +             adev->gfx.rlc.reg_funcs = &amdgpu_rlc_reg_funcs;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>>> index e535534237a1..959d60c90dcd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>>> @@ -262,6 +262,11 @@ struct amdgpu_rlc_funcs {
>>>        bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
>>>    };
>>>
>>> +struct amdgpu_rlc_reg_funcs {
>>> +     u32  (*rreg32)(struct amdgpu_device *adev, u32 reg, u32 acc_flags, u32 hwip, u32 xcc_id);
>>> +     void (*wreg32)(struct amdgpu_device *adev, u32 reg, u32 val, u32 acc_flags, u32 hwip, u32 xcc_id);
>>> +};
>>> +
>>>    struct amdgpu_rlcg_reg_access_ctrl {
>>>        uint32_t scratch_reg0;
>>>        uint32_t scratch_reg1;
>>> @@ -303,6 +308,7 @@ struct amdgpu_rlc {
>>>        /* safe mode for updating CG/PG state */
>>>        bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
>>>        const struct amdgpu_rlc_funcs *funcs;
>>> +     const struct amdgpu_rlc_reg_funcs *reg_funcs;
>>>
>>>        /* for firmware data */
>>>        u32 save_and_restore_offset;
>>> @@ -374,4 +380,8 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
>>>    int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
>>>                                  uint16_t version_major,
>>>                                  uint16_t version_minor);
>>> +
>>> +void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
>>> +void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
>>> +
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 8b60299b73ef..4bfdd55be7f9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -7829,6 +7829,8 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>>>        /* init rlcg reg access ctrl */
>>>        gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v10_0_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 8c82e90f871b..8b9a9d944641 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -5341,6 +5341,8 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>>>
>>>        gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v11_0_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 65c33823a688..a5034e39a8e9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -3912,6 +3912,8 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>>
>>>        gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v12_0_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> index 68fd3c04134d..13de1b356e9d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> @@ -2915,6 +2915,8 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
>>>
>>>        gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v12_1_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index 95be105671ec..100b5ee44fef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -4816,6 +4816,8 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>>>        /* init rlcg reg access ctrl */
>>>        gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v9_0_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index ad4d442e7345..2e17fc1157fd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -2525,6 +2525,8 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
>>>        /* init rlcg reg access ctrl */
>>>        gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
>>>
>>> +     amdgpu_init_rlc_reg_funcs(adev);
>>> +
>>>        return gfx_v9_4_3_init_microcode(adev);
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>>> index a7b5a95ebebb..a04f61b22379 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>>> @@ -38,14 +38,10 @@
>>>        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset))
>>>
>>>    #define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
>>> -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
>>> -      amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
>>> -      WREG32(reg, value))
>>> +     adev->gfx.rlc.reg_funcs->wreg32(adev, reg, value, flag, hwip, inst)
>>>
>>>    #define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
>>> -     ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
>>> -      amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
>>> -      RREG32(reg))
>>> +     adev->gfx.rlc.reg_funcs->rreg32(adev, reg, flag, hwip, inst)
>>>
>>>    #define WREG32_FIELD15(ip, idx, reg, field, val)    \
>>>         __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,   \

