Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A35C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 15:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF2B10EC42;
	Fri, 24 Feb 2023 15:01:38 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9245E10EC42
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 15:01:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id x10so55039393edd.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 07:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8VbXb6H0IfdTZB9K0pNlfg0RhlN5aDhLcItNI24pocY=;
 b=R+siqjN1fQVNMJSl4KsYOEMRRGLFPkR42ExfdFEuPGocJoFF+NXW54SuR9GbH4tMmY
 B3f+ckB6itlc+XqypdMOTquDqc2nF/2J7kMBnU1abnuZASMkJ/9s45jduHgfMZUhlSVs
 RWfcTuk76vMLZenkIEym/yI0NDiMmsTOps7fU8JyoyLuRl6NDkJEoXmafp6tMGeQAUyX
 H2TZTV2qpd25IxMMsqrj0/DQz4D+n5nI09F6rvm0XQKtBdjBXspdQ5gCxtUjjLpiYrXL
 UY/2sE+xiNeKNnHa9NhnecZEBIryTSlbwFX+UvQGJmSUoxxiwhWs8QCo0UxCfMccmNZj
 tecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8VbXb6H0IfdTZB9K0pNlfg0RhlN5aDhLcItNI24pocY=;
 b=jO+0s69b9/juC3RT33MtpT/uU7+nZPdc8YB0oCgD9hrtmL5FXlMUQ9EmzdQ3qE4DyM
 /fQoqmbaMPzzujwx6JjrpTr1up76T6g2Qjdt2Sz8mIEReWUoubtlJPX7L/vmuV81qClx
 j8gSRX4qHfbA+lRR4KUMkXUk4WANt2616M1nJYHPuv34FxT8dhlfP8tm0by8r+mG2Ezw
 zSY3W9NpOH0slSeg+8iYblCkpUhSoHpMSD32aXwJi48q/P1PHnddElmyq67Qh0gmhIU7
 igndj+50PcaRl/+BNXy1WhNrjesm5Wmq5atGfZXceQojOmDPAb1ws+rK/PeUIc708Xsz
 02kw==
X-Gm-Message-State: AO0yUKUaaEYK08E+1EX41lEVvNye5qXNMWMhKpanUbtzHcMy+JJ/6Twl
 jw4revUbGpqa4/yLNL4SPRg=
X-Google-Smtp-Source: AK7set/HNubvASiMaF5EBz8ahqUO18vkiTYyyqz42BYKQJ03MMW1chTbx0Y4ZbWVE680kvYYJtsWXw==
X-Received: by 2002:aa7:df0a:0:b0:4ae:e51e:6956 with SMTP id
 c10-20020aa7df0a000000b004aee51e6956mr14638250edy.13.1677250895915; 
 Fri, 24 Feb 2023 07:01:35 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:35e:38c6:dafc:5dd2?
 ([2a02:908:1256:79a0:35e:38c6:dafc:5dd2])
 by smtp.gmail.com with ESMTPSA id
 eh8-20020a0564020f8800b004af720b855fsm1427986edb.82.2023.02.24.07.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Feb 2023 07:01:34 -0800 (PST)
Message-ID: <c248c2a8-7f00-41e9-409d-5b5163849fed@gmail.com>
Date: Fri, 24 Feb 2023 16:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: support more AV1 encoding requests
Content-Language: en-US
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230222231131.191619-1-David.Wu3@amd.com>
 <b1de9e63-5194-4ca5-e033-25674e2b7d92@gmail.com>
 <SJ1PR12MB61949A2DE67BD5A817CBC33395AB9@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <SJ1PR12MB6194457874373CDB84901E9495A89@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <SJ1PR12MB6194457874373CDB84901E9495A89@SJ1PR12MB6194.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well STOP! This can't be pushed before we have Mesa code for this!

Christian.

Am 24.02.23 um 15:36 schrieb Dong, Ruijing:
> [AMD Official Use Only - General]
>
> If no other comment or concern, we will push it.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dong, Ruijing
> Sent: Thursday, February 23, 2023 10:19 AM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Wu, David <David.Wu3@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: support more AV1 encoding requests
>
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> Thanks Christian,
>
> This is just to cover possible valid ways in kernel as a preparation, av1 encoding in Mesa is still under developing.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Thursday, February 23, 2023 1:48 AM
> To: Wu, David <David.Wu3@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: support more AV1 encoding requests
>
> Am 23.02.23 um 00:11 schrieb David (Ming Qiang) Wu:
>> Ensuring accurate IB package searching and covers more corners for AV1
>> encoding requests.
> That at least looks much cleaner now. Do we already have the Mesa patches ready which use this?
>
> Regards,
> Christian.
>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 81 +++++++++++++++++++++++++--
>>    1 file changed, 75 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 22a41766a8c7..8235ff3820ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1726,6 +1726,7 @@ static int vcn_v4_0_dec_msg(struct
>> amdgpu_cs_parser *p, struct amdgpu_job *job,
>>
>>    #define RADEON_VCN_ENGINE_TYPE_ENCODE                       (0x00000002)
>>    #define RADEON_VCN_ENGINE_TYPE_DECODE                       (0x00000003)
>> +#define RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE          (0x00000004)
>>
>>    #define RADEON_VCN_ENGINE_INFO                              (0x30000001)
>>    #define RADEON_VCN_ENGINE_INFO_MAX_OFFSET           16
>> @@ -1733,21 +1734,86 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>>    #define RENCODE_ENCODE_STANDARD_AV1                 2
>>    #define RENCODE_IB_PARAM_SESSION_INIT                       0x00000003
>>    #define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET    64
>> +#define RENCODE_IB_ENC_QUE_INSTRUCTION                       (0x32000001)
>> +#define RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET    64
>>
>>    /* return the offset in ib if id is found, -1 otherwise
>>     * to speed up the searching we only search upto max_offset
>>     */
>> -static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t
>> id, int max_offset)
>> +static int vcn_v4_0_enc_find_ib_param(uint32_t *ptr, int size,
>> +uint32_t id, int max_offset)
>>    {
>>        int i;
>>
>> -     for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
>> -             if (ib->ptr[i + 1] == id)
>> +     for (i = 0; i < size && i < max_offset && ptr[i] >= 8; i += ptr[i] / 4) {
>> +             if (ptr[i + 1] == id)
>>                        return i;
>>        }
>>        return -1;
>>    }
>>
>> +static int vcn_v4_0_enc_queue_msg(struct amdgpu_cs_parser *p,
>> +                               struct amdgpu_job *job,
>> +                               struct amdgpu_ib *ib) {
>> +     struct ttm_operation_ctx ctx = { false, false };
>> +     struct amdgpu_bo_va_mapping *map;
>> +     struct amdgpu_bo *bo;
>> +     uint64_t start, end;
>> +     int i;
>> +     void *ptr;
>> +     int r;
>> +     int data_size = 0;
>> +     uint64_t addr;
>> +     uint32_t *msg;
>> +
>> +     i = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw, RENCODE_IB_ENC_QUE_INSTRUCTION,
>> +             RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET);
>> +     if (i >= 0) {
>> +             addr = ((uint64_t)ib->ptr[i + 3]) << 32 | ib->ptr[i + 2];
>> +             data_size = ib->ptr[i + 4];
>> +     }
>> +
>> +     if (!data_size) /* did not find */
>> +             return 0;
>> +
>> +     addr &= AMDGPU_GMC_HOLE_MASK;
>> +     r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
>> +     if (r) {
>> +             DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
>> +             return r;
>> +     }
>> +
>> +     start = map->start * AMDGPU_GPU_PAGE_SIZE;
>> +     end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
>> +     if (addr & 0x7) {
>> +             DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>> +     amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>> +     r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> +     if (r) {
>> +             DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
>> +             return r;
>> +     }
>> +
>> +     r = amdgpu_bo_kmap(bo, &ptr);
>> +     if (r) {
>> +             DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
>> +             return r;
>> +     }
>> +
>> +     msg = ptr + addr - start; /* IB with SESSION_INIT */
>> +     i = vcn_v4_0_enc_find_ib_param(msg, data_size, RENCODE_IB_PARAM_SESSION_INIT,
>> +             RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
>> +     if (i >= 0 && msg[i + 2] == RENCODE_ENCODE_STANDARD_AV1)
>> +             r = vcn_v4_0_limit_sched(p, job);
>> +
>> +     amdgpu_bo_kunmap(bo);
>> +     return r;
>> +}
>> +
>>    static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>                                           struct amdgpu_job *job,
>>                                           struct amdgpu_ib *ib) @@
>> -1763,12 +1829,13 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>                return 0;
>>
>>        /* RADEON_VCN_ENGINE_INFO is at the top of ib block */
>> -     idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
>> +     idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw,
>> +RADEON_VCN_ENGINE_INFO,
>>                        RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
>>        if (idx < 0) /* engine info is missing */
>>                return 0;
>>
>>        val = amdgpu_ib_get_value(ib, idx + 2); /*
>> RADEON_VCN_ENGINE_TYPE */
>> +
>>        if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
>>                decode_buffer = (struct amdgpu_vcn_decode_buffer
>> *)&ib->ptr[idx + 6];
>>
>> @@ -1779,10 +1846,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>                        decode_buffer->msg_buffer_address_lo;
>>                return vcn_v4_0_dec_msg(p, job, addr);
>>        } else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
>> -             idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
>> -                     RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
>> +             idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw,
>> +                     RENCODE_IB_PARAM_SESSION_INIT,
>> +RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
>>                if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
>>                        return vcn_v4_0_limit_sched(p, job);
>> +     } else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE) {
>> +             return vcn_v4_0_enc_queue_msg(p, job, ib);
>>        }
>>        return 0;
>>    }

