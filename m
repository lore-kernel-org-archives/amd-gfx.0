Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149CFCDD1AE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 13:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F06410E0C1;
	Fri, 27 Sep 2024 13:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/RG03xF";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB3310E0C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 13:45:00 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-37cc810ce73so1399151f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727444698; x=1728049498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wfrfW2lGznCyi6CWzz0v5mONty5xF/ZYoSpN4JsUgCw=;
 b=T/RG03xF3en7KhzDfYRpR4ihxXVa8rp3InEgRwtYoeb6f+GoSgCPqSCwpFea6PfKr5
 XICB24gxxSDio1jBHyNW6Ggnjm5AQ+W9pPPsilR/4CAg5LLcMPrpMSuitftZtylfm3oc
 GQnu6g6CHiYQHlQZeJZYVIWG6hk81Xt3lFvreswT65ZnJTOAWJ6LOGcKABXT2vgxaP30
 R6XCRrNCGC4Bc/Xgokq+XBIlVebwNLdlLHQY/+uJ4FFoyHnCLGqT02h4QbbM+U/BjS85
 V1/+n1Y1sWfR7xnTMB1Cjv0X3rnDfwQZoocvitMdgNwZEIfXG0t9Apv4lnGVv7TzYKYa
 wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727444698; x=1728049498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wfrfW2lGznCyi6CWzz0v5mONty5xF/ZYoSpN4JsUgCw=;
 b=AmL5uzmWmB0MfmsBWWEhiArIH4gyGbEMcB3WjzZeLfvbC9KyldAPz6e5xQM7jD6Pvc
 fyBvqtLYVr8U5oe3h6SIBSqgZLuwp8YrKIsfT1AlqEBhMzdYUVXPTe5vg3SL+UCwVumN
 b2T3mamcw7g7lN18yu4pinPz1yrUj921CSRoOui9np/ZHImrnSo/QD7jT2mzd1q4cKOF
 YCcmdGrcyh6RqiuvgVUfSAq7ccWfhGBOkR5AI72a8r1a92Dj6YMTysz6mDDVb1kZvQUm
 jD23rCtAIsiZgzv2OkIVuCB5P9aakaqTbgR6CbW1+lphdQDfdJohqKOs6g/Rwb9sBF3v
 yx7w==
X-Gm-Message-State: AOJu0Yz3Zq7KQoZO758et41OHN0nk/NgxkKDnUKkYh/WjJiCq4mKc7GX
 hVsZwAodKC1qnCIbaBgMuiqnSG0xFacIR/bWehB9ouGe5UmMwE7C
X-Google-Smtp-Source: AGHT+IGlPadZhyTVBInRjF1BAyTkl/LYUUDv9aZBW2zKah2u5DmgpwnTC6BLbDjQ5rEHoMbHp7McpQ==
X-Received: by 2002:a05:6000:1089:b0:37c:cfe4:6997 with SMTP id
 ffacd0b85a97d-37cd5b12b1fmr1528885f8f.47.1727444698098; 
 Fri, 27 Sep 2024 06:44:58 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574268bsm2502916f8f.97.2024.09.27.06.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 06:44:57 -0700 (PDT)
Message-ID: <678894ef-adbf-4451-9dea-dc824a182177@gmail.com>
Date: Fri, 27 Sep 2024 15:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in
 cleaner shader code
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
 <BL1PR12MB51440CA6B867F66075BD50ADF79C2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <b775c53c-9367-4364-8a16-f805ba406ac0@amd.com>
 <080840a3-0660-434a-85de-66949fd0c878@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <080840a3-0660-434a-85de-66949fd0c878@amd.com>
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

Am 25.09.24 um 21:45 schrieb Felix Kuehling:
>
> On 2024-09-04 07:03, Christian König wrote:
>> It could be that the automated testing tools will run amok on that.
>>
>> I need to ask Felix for details but I think the code for the CWSR 
>> trap handlers were converted to C style comments as well because of 
>> that.
>
> I'm not aware of that. I see both comment styles in 
> amdkfd/cwsr_trap_handler_*.asm.

Oh, I was assuming that this is the C header with the binary variant and 
not the asm file.

My fault, in that case it indeed doesn't matter.

Regards,
Christian.

>
>
> Regards,
>   Felix
>
>
>>
>> Christian.
>>
>> Am 04.09.24 um 12:52 schrieb Deucher, Alexander:
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>
>>> I think you can drop this patch.  This code is not compiled, it's 
>>> just for reference, and changing all of the comments will just make 
>>> it harder to keep in sync with the internal version.
>>>
>>> Alex
>>>
>>> ------------------------------------------------------------------------ 
>>>
>>> *From:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>>> *Sent:* Wednesday, September 4, 2024 5:51 AM
>>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, 
>>> Alexander <Alexander.Deucher@amd.com>
>>> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
>>> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>>> *Subject:* [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` 
>>> in cleaner shader code
>>> This commit updates the comment style in the cleaner shader code from
>>> `//` to `/* ... */` to adhere to the Linux kernel coding style.
>>>
>>> The comments describe the operation of the cleaner shader, which is 
>>> used
>>> to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
>>> separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
>>> SGPRs.
>>>
>>> Fixes: 3b721dfb2c95 ("drm/amdgpu/gfx9: Add cleaner shader for 
>>> GFX9.4.3")
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>> v2:
>>>  - Corrected typo for iteraions
>>>  - Added fixes tag
>>>
>>>  .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
>>>  1 file changed, 72 insertions(+), 67 deletions(-)
>>>
>>> diff --git 
>>> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>>> index d5325ef80ab0..8951b5a87ae1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>>> @@ -21,47 +21,52 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   */
>>>
>>> -// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 
>>> Dwords or 256 bytes of 192 Dwords cleaner shader.
>>> -//To turn this shader program on for complitaion change this to 
>>> main and lower shader main to main_1
>>> -
>>> -// MI300 : Clear SGPRs, VGPRs and LDS
>>> -//   Uses two kernels launched separately:
>>> -//   1. Clean VGPRs, LDS, and lower SGPRs
>>> -//        Launches one workgroup per CU, each workgroup with 4x 
>>> wave64 per SIMD in the CU
>>> -//        Waves are "wave64" and have 128 VGPRs each, which uses 
>>> all 512 VGPRs per SIMD
>>> -//        Waves in the workgroup share the 64KB of LDS
>>> -//        Each wave clears SGPRs 0 - 95. Because there are 4 
>>> waves/SIMD, this is physical SGPRs 0-383
>>> -//        Each wave clears 128 VGPRs, so all 512 in the SIMD
>>> -//        The first wave of the workgroup clears its 64KB of LDS
>>> -//        The shader starts with "S_BARRIER" to ensure SPI has 
>>> launched all waves of the workgroup
>>> -//          before any wave in the workgroup could end. Without 
>>> this, it is possible not all SGPRs get cleared.
>>> -//    2. Clean remaining SGPRs
>>> -//        Launches a workgroup with 24 waves per workgroup, 
>>> yielding 6 waves per SIMD in each CU
>>> -//        Waves are allocating 96 SGPRs
>>> -//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
>>> these waves from allocating SGPRs 0-223.
>>> -//          As such, these 6 waves per SIMD are allocated physical 
>>> SGPRs 224-799
>>> -//        Barriers do not work for >16 waves per workgroup, so we 
>>> cannot start with S_BARRIER
>>> -//          Instead, the shader starts with an S_SETHALT 1. Once 
>>> all waves are launched CP will send unhalt command
>>> -//        The shader then clears all SGPRs allocated to it, 
>>> cleaning out physical SGPRs 224-799
>>> +/*
>>> + * This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 
>>> Dwords or 256 bytes of 192 Dwords cleaner shader.
>>> + * To turn this shader program on for complitaion change this to 
>>> main and lower shader main to main_1
>>> + *
>>> + * MI300 : Clear SGPRs, VGPRs and LDS
>>> + *   Uses two kernels launched separately:
>>> + *   1. Clean VGPRs, LDS, and lower SGPRs
>>> + *        Launches one workgroup per CU, each workgroup with 4x 
>>> wave64 per SIMD in the CU
>>> + *        Waves are "wave64" and have 128 VGPRs each, which uses 
>>> all 512 VGPRs per SIMD
>>> + *        Waves in the workgroup share the 64KB of LDS
>>> + *        Each wave clears SGPRs 0 - 95. Because there are 4 
>>> waves/SIMD, this is physical SGPRs 0-383
>>> + *        Each wave clears 128 VGPRs, so all 512 in the SIMD
>>> + *        The first wave of the workgroup clears its 64KB of LDS
>>> + *        The shader starts with "S_BARRIER" to ensure SPI has 
>>> launched all waves of the workgroup
>>> + *          before any wave in the workgroup could end. Without 
>>> this, it is possible not all SGPRs get cleared.
>>> + *    2. Clean remaining SGPRs
>>> + *        Launches a workgroup with 24 waves per workgroup, 
>>> yielding 6 waves per SIMD in each CU
>>> + *        Waves are allocating 96 SGPRs
>>> + *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent 
>>> these waves from allocating SGPRs 0-223.
>>> + *          As such, these 6 waves per SIMD are allocated physical 
>>> SGPRs 224-799
>>> + *       Barriers do not work for >16 waves per workgroup, so we 
>>> cannot start with S_BARRIER
>>> + *       Instead, the shader starts with an S_SETHALT 1. Once all 
>>> waves are launched CP will send unhalt command
>>> + *       The shader then clears all SGPRs allocated to it, cleaning 
>>> out physical SGPRs 224-799
>>> + */
>>>
>>>  shader main
>>>    asic(MI300)
>>>    type(CS)
>>>    wave_size(64)
>>> -// Note: original source code from SQ team
>>>
>>> -//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  
>>> = 2176 clks)
>>> +/*
>>> + * Note: original source code from SQ team
>>> + *
>>> + * (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 
>>> 2176 clks)
>>> + */
>>>
>>> -  s_cmp_eq_u32 s0, 1 // Bit0 is set, sgpr0 is set then clear VGPRS 
>>> and LDS as FW set COMPUTE_USER_DATA_3
>>> -  s_cbranch_scc0  label_0023 // Clean VGPRs and LDS if sgpr0 of 
>>> wave is set, scc = (s3 == 1)
>>> +  s_cmp_eq_u32 s0, 1 /* Bit0 is set, sgpr0 is set then clear VGPRS 
>>> and LDS as FW set COMPUTE_USER_DATA_3 */
>>> +  s_cbranch_scc0  label_0023 /* Clean VGPRs and LDS if sgpr0 of 
>>> wave is set, scc = (s3 == 1) */
>>>    S_BARRIER
>>>
>>>    s_movk_i32    m0, 0x0000
>>> -  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop 
>>> unrolled for performance)
>>> -  //
>>> -  // CLEAR VGPRs
>>> -  //
>>> -  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
>>> +  s_mov_b32     s2, 0x00000078  /* Loop 128/8=16 times  (loop 
>>> unrolled for performance) */
>>> +/*
>>> + * CLEAR VGPRs
>>> + */
>>> +  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
>>>  label_0005:
>>>    v_mov_b32     v0, 0
>>>    v_mov_b32     v1, 0
>>> @@ -75,24 +80,24 @@ label_0005:
>>>    s_set_gpr_idx_idx  s2
>>>    s_cbranch_scc0  label_0005
>>>    s_set_gpr_idx_off
>>> -
>>> -  //
>>> -  //
>>> -
>>> -  s_mov_b32     s2, 0x80000000 // Bit31 is first_wave
>>> -  s_and_b32     s2, s2, s1 // sgpr0 has tg_size (first_wave) term 
>>> as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
>>> -  s_cbranch_scc0  label_clean_sgpr_1 // Clean LDS if its first wave 
>>> of ThreadGroup/WorkGroup
>>> -  // CLEAR LDS
>>> -  //
>>> +
>>> +  s_mov_b32     s2, 0x80000000 /* Bit31 is first_wave */
>>> +  s_and_b32     s2, s2, s1 /* sgpr0 has tg_size (first_wave) term 
>>> as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */
>>> +  s_cbranch_scc0  label_clean_sgpr_1 /* Clean LDS if its first wave 
>>> of ThreadGroup/WorkGroup */
>>> +/*
>>> + * CLEAR LDS
>>> + */
>>>    s_mov_b32 exec_lo, 0xffffffff
>>>    s_mov_b32 exec_hi, 0xffffffff
>>> -  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to 
>>> thread-ID (0..63)
>>> -  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to 
>>> thread-ID (0..63)
>>> -  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each 
>>> thread is a double-dword address (8byte)
>>> -  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
>>> +  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to 
>>> thread-ID (0..63) */
>>> +  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to 
>>> thread-ID (0..63) */
>>> +  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each 
>>> thread is a double-dword address (8byte) */
>>> +  s_mov_b32     s2, 0x00000003f               /* 64 loop iterations */
>>>    s_mov_b32     m0, 0xffffffff
>>> -  // Clear all of LDS space
>>> -  // Each FirstWave of WorkGroup clears 64kbyte block
>>> +/*
>>> + * Clear all of LDS space
>>> + * Each FirstWave of WorkGroup clears 64kbyte block
>>> + */
>>>
>>>  label_001F:
>>>    ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
>>> @@ -100,11 +105,11 @@ label_001F:
>>>    v_add_co_u32     v1, vcc, 0x00000400, v1
>>>    s_sub_u32     s2, s2, 1
>>>    s_cbranch_scc0  label_001F
>>> -  //
>>> -  // CLEAR SGPRs
>>> -  //
>>> +/*
>>> + * CLEAR SGPRs
>>> + */
>>>  label_clean_sgpr_1:
>>> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop 
>>> unrolled for performance)
>>> +  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=24 times  (loop 
>>> unrolled for performance) */
>>>    s_nop 0
>>>  label_sgpr_loop:
>>>    s_movreld_b32     s0, 0
>>> @@ -114,25 +119,25 @@ label_sgpr_loop:
>>>    s_sub_u32         m0, m0, 4
>>>    s_cbranch_scc0  label_sgpr_loop
>>>
>>> -  //clear vcc, flat scratch
>>> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
>>> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
>>> -  s_mov_b64 vcc, 0               //clear vcc
>>> -  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1
>>> -  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3
>>> -  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5
>>> -  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7
>>> -  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9
>>> -  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11
>>> -  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13
>>> -  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15
>>> +  /* clear vcc, flat scratch */
>>> +  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
>>> +  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
>>> +  s_mov_b64 vcc, 0               /* clear vcc */
>>> +  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
>>> +  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
>>> +  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
>>> +  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
>>> +  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
>>> +  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
>>> +  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
>>> +  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
>>>  s_endpgm
>>>
>>>  label_0023:
>>>
>>>    s_sethalt 1
>>>
>>> -  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop 
>>> unrolled for performance)
>>> +  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=16 times (loop 
>>> unrolled for performance) */
>>>    s_nop 0
>>>  label_sgpr_loop1:
>>>
>>> @@ -143,10 +148,10 @@ label_sgpr_loop1:
>>>    s_sub_u32         m0, m0, 4
>>>    s_cbranch_scc0  label_sgpr_loop1
>>>
>>> -  //clear vcc, flat scratch
>>> -  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
>>> -  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
>>> -  s_mov_b64 vcc, 0xee            //clear vcc
>>> +  /* clear vcc, flat scratch */
>>> +  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
>>> +  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
>>> +  s_mov_b64 vcc, 0xee            /* clear vcc */
>>>
>>>  s_endpgm
>>>  end
>>> -- 
>>> 2.34.1
>>>
>>

