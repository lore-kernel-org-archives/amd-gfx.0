Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F378C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 09:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72A510E1BC;
	Wed,  3 Jul 2024 09:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GpFHhnDd";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4A610E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 09:11:31 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-424ad289949so37224115e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jul 2024 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719997890; x=1720602690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3J9Ac36Nn4BPoF4tfYFuUOdS/RHfzKct4iVSpZU6aG0=;
 b=GpFHhnDdApMsGLKrBkiZqknWTZ6dEjTOh9kXFbwF0x8SeWJnbBXEoyBRUX3vgWiV8B
 GtmXgwOzfmQfaCz/iD1MQdcCdyvv7ftJc83038bG28/gTLa+auykRBpxTihOt6W7EQNZ
 vXnoYio/QrPfFbHXkVo3WLbS1nxd/SPaEftPpYYmxmCBzl7nfq4eyoZG1tWdkNkosHh/
 PQzHgzOVS8D1lAzRKVux5FR2x/ND6O1HBI1bS7JX89VXfSjML0NPK9JlnonNEZnU6GxM
 kbapj0JH6YTsjlCEgraFPWT9pCesCqbap/WGjJCqE13xzrdL5fYEENHioM1TNw8GQCud
 2n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997890; x=1720602690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3J9Ac36Nn4BPoF4tfYFuUOdS/RHfzKct4iVSpZU6aG0=;
 b=CDlYx2pd3bkqrcnvDVs/05f7C0ejyWaD4ZroN5iqF7XXG4V2f4N6QEe0U6oub7JH0h
 DrBINsUKFoFLZDZxWEc840PrFl0iHkS+rxfE9nNmNBtNvInw01GIgdD+/wCsWGepVfr5
 T8qIAU3btFjIxvgvtWtAld53L71xneB4ZBtyME9K5Le+ZriTma1s1NdYGxViUDoS0r9j
 RsFV37CbIy12qv4TtinwBMTejEzJrKbvBZtB6EJ41Jdw1/uF4j1Zo67Dps3r2n665swQ
 zkA/EhAVXS+ZwkzyJY6l7v7Pz9257Jys5h8lSJeKUrS9AeFaQSZnyw3tqDyNMkQZ8W41
 QzRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5aiOfzRVK5k3ucZdDD5J0xpzqcwh7X8juK2U4cimsdtOv0Lvz3d4yc2mbvqtVX9OfvoZ5rQsBiMSwJ/a6bAfni5VrWsx243WXq7MM+w==
X-Gm-Message-State: AOJu0YwwzW+F/vBhp/RTEXzQYjIqPUjfHPTHQCmKQqcsPYg+00CSPz+R
 RECJZK6FM0fvBb4mFmODdOKdDRjhrMiUwUWor8T4CJLI8oAIphNQ
X-Google-Smtp-Source: AGHT+IF6Sj+A/uUEfJVd0JshOEfYBW3B1cg+iV2s+3bMFHyp2KH+1moPHlgwYYBRmq+xOPNMsmeWeg==
X-Received: by 2002:a05:600c:3047:b0:422:4fcd:d4b3 with SMTP id
 5b1f17b1804b1-4257a0282f9mr75224515e9.37.1719997889230; 
 Wed, 03 Jul 2024 02:11:29 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257d04c742sm148108375e9.7.2024.07.03.02.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 02:11:28 -0700 (PDT)
Message-ID: <9f5f46fd-1360-46a6-b48a-7185bddad3b7@gmail.com>
Date: Wed, 3 Jul 2024 11:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missing error handling for
 amdgpu_ring_alloc()
To: "Zhou, Bob" <Bob.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Huang, Tim" <Tim.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240621092454.42879-1-bob.zhou@amd.com>
 <f59fe9bd-b9d6-44cc-980e-59d111933217@amd.com>
 <CO6PR12MB539481D03C064387AC38464D94DD2@CO6PR12MB5394.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CO6PR12MB539481D03C064387AC38464D94DD2@CO6PR12MB5394.namprd12.prod.outlook.com>
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

Error handling is to resolve or at least mitigate problems caused by the 
user or the hardware.

When the driver tries to allocate more than allowed from the ring then 
that's a driver bug and not something for error handling.

So the error handling here doesn't seem to make sense in the first place.

Regards,
Christian.

Am 03.07.24 um 09:23 schrieb Zhou, Bob:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian,
>
> In making the v2 version patch process, I check lots of cases for amdgpu_ring_alloc(). I think checking the return value maybe better.
> For allocating submission size from amdgpu_ring_alloc(), the action is allowed to fail so that rerun allocating submission rather than drop the return value.
> For many cases in gpu driver, it still needs check the call result to conduct the error handling. If drop the return value, in those case it causes some unexpected result.
> If the error occurs, the command submission should be skip and wait the next action.
>
> Regards,
> Bob
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2024年6月21日 17:28
> To: Zhou, Bob <Bob.Zhou@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Tim <Tim.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add missing error handling for amdgpu_ring_alloc()
>
> Am 21.06.24 um 11:24 schrieb Bob Zhou:
>> Fix the unchecked return value warning reported by Coverity, so add
>> error handling.
> That seems to be completely superfluous. The only case when
> amdgpu_ring_alloc() returns an error is when we try to allocate more than the maximum submission size.
>
> And in that case we will get quite a warning already.
>
> I strongly suggest to instead drop the return value from amdgpu_ring_alloc().
>
> Regards,
> Christian.
>
>> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 7 +++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      | 4 +++-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 6 ++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c      | 3 ++-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 8 ++++++--
>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c       | 6 +++++-
>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c       | 6 +++++-
>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c       | 6 +++++-
>>    8 files changed, 35 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 82452606ae6c..25cab6a8d478 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1005,7 +1005,8 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>>                pr_err("critical bug! too many kiq readers\n");
>>                goto failed_unlock;
>>        }
>> -     amdgpu_ring_alloc(ring, 32);
>> +     if (amdgpu_ring_alloc(ring, 32))
>> +             goto failed_unlock;
>>        amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
>>        r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>>        if (r)
>> @@ -1071,7 +1072,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>>        }
>>
>>        spin_lock_irqsave(&kiq->ring_lock, flags);
>> -     amdgpu_ring_alloc(ring, 32);
>> +     if (amdgpu_ring_alloc(ring, 32))
>> +             goto failed_unlock;
>>        amdgpu_ring_emit_wreg(ring, reg, v);
>>        r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>>        if (r)
>> @@ -1107,6 +1109,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev,
>> uint32_t reg, uint32_t v, uint3
>>
>>    failed_undo:
>>        amdgpu_ring_undo(ring);
>> +failed_unlock:
>>        spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>    failed_kiq_write:
>>        dev_err(adev->dev, "failed to write reg:%x\n", reg); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index 3a7622611916..778941f47c96 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -768,7 +768,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>>        }
>>
>>        spin_lock_irqsave(&kiq->ring_lock, flags);
>> -     amdgpu_ring_alloc(ring, 32);
>> +     if (amdgpu_ring_alloc(ring, 32))
>> +             goto failed_unlock;
>>        amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>>                                            ref, mask);
>>        r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT); @@
>> -798,6 +799,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct
>> amdgpu_device *adev,
>>
>>    failed_undo:
>>        amdgpu_ring_undo(ring);
>> +failed_unlock:
>>        spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>    failed_kiq:
>>        dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0,
>> reg1); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> index d234b7ccfaaf..01864990a192 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> @@ -63,12 +63,14 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>>                return;
>>        }
>>        if (start > end) {
>> -             amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
>> +             if (amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start))
>> +                     return;
>>                amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
>>                                           (ring->ring_size >> 2) - start);
>>                amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>>        } else {
>> -             amdgpu_ring_alloc(real_ring, end - start);
>> +             if (amdgpu_ring_alloc(real_ring, end - start))
>> +                     return;
>>                amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>>        }
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index bad232859972..d7d68e61506d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -610,7 +610,8 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring
>> *ring)
>>
>>        /* emit the trailing fence */
>>        ring->trail_seq += 1;
>> -     amdgpu_ring_alloc(ring, 10);
>> +     if (amdgpu_ring_alloc(ring, 10))
>> +             return -ENOMEM;
>>        vpe_ring_emit_fence(ring, ring->trail_fence_gpu_addr, ring->trail_seq, 0);
>>        amdgpu_ring_commit(ring);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 2929c8972ea7..810f7f7e279d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -4093,7 +4093,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>>                pr_err("critical bug! too many kiq readers\n");
>>                goto failed_unlock;
>>        }
>> -     amdgpu_ring_alloc(ring, 32);
>> +     if (amdgpu_ring_alloc(ring, 32))
>> +             goto failed_unlock;
>>        amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>>        amdgpu_ring_write(ring, 9 |     /* src: register*/
>>                                (5 << 8) |      /* dst: memory */
>> @@ -5639,7 +5640,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>        amdgpu_ring_set_preempt_cond_exec(ring, false);
>>
>>        ring->trail_seq += 1;
>> -     amdgpu_ring_alloc(ring, 13);
>> +     if (amdgpu_ring_alloc(ring, 13)) {
>> +             spin_unlock_irqrestore(&kiq->ring_lock, flags);
>> +             return -ENOMEM;
>> +     }
>>        gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>>                                 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC |
>> AMDGPU_FENCE_FLAG_INT);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index b7d33d78bce0..07ca9264085b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -1490,7 +1490,11 @@ static int sdma_v5_0_ring_preempt_ib(struct
>> amdgpu_ring *ring)
>>
>>        /* emit the trailing fence */
>>        ring->trail_seq += 1;
>> -     amdgpu_ring_alloc(ring, 10);
>> +     r = amdgpu_ring_alloc(ring, 10);
>> +     if (r) {
>> +             DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
>> +             return r;
>> +     }
>>        sdma_v5_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>>                                  ring->trail_seq, 0);
>>        amdgpu_ring_commit(ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index cc9e961f0078..d51d5bd7de30 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -1345,7 +1345,11 @@ static int sdma_v5_2_ring_preempt_ib(struct
>> amdgpu_ring *ring)
>>
>>        /* emit the trailing fence */
>>        ring->trail_seq += 1;
>> -     amdgpu_ring_alloc(ring, 10);
>> +     r = amdgpu_ring_alloc(ring, 10);
>> +     if (r) {
>> +             DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
>> +             return r;
>> +     }
>>        sdma_v5_2_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>>                                  ring->trail_seq, 0);
>>        amdgpu_ring_commit(ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index c833b6b8373b..e82426459cc7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1371,7 +1371,11 @@ static int sdma_v6_0_ring_preempt_ib(struct
>> amdgpu_ring *ring)
>>
>>        /* emit the trailing fence */
>>        ring->trail_seq += 1;
>> -     amdgpu_ring_alloc(ring, 10);
>> +     r = amdgpu_ring_alloc(ring, 10);
>> +     if (r) {
>> +             DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
>> +             return r;
>> +     }
>>        sdma_v6_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>>                                  ring->trail_seq, 0);
>>        amdgpu_ring_commit(ring);

