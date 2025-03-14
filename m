Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BA0C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E073410E306;
	Fri, 14 Mar 2025 14:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4zUbqdq";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106F410E984
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:13:07 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so1412721f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741961585; x=1742566385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONWsh80GS3oG36M9xCl+wY5tU7etsBQDtlC3Q4VtJwg=;
 b=m4zUbqdqk7z4/f6FL9oSKkS+SI0ZdQQBXM+B/OXzvaG/NZlPRXRsa6p0AD2MS088wD
 tAYYdmzzgwgIy/7BgUXkKU5rr86roUg/jRgwCu/0aDnoddGUsMy4hj8OZ/9OJ2/AMVy+
 9powv79disTm02Rxay3+alhGmBgKTk41WVDjPcn6dlg6dT4wnza6Sv9S3l2psgr4EXI3
 iShA5d5rHOipYuPeHJ4BMjFXOaoPZ0Jd1dPHGMd34SB2UGAUXgSdgFrvfPExDKtNXPSt
 N35dAkzjF7FcxXpSBvILUQWP5UA1y1FAv2vpo6wbB6nt+aGaty49ITq29ILNIjjY5+m1
 AL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741961585; x=1742566385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ONWsh80GS3oG36M9xCl+wY5tU7etsBQDtlC3Q4VtJwg=;
 b=gPotk65aj8sjxe6O0Pl83n0f031Myimb4NVR6MXLEhF+TQTFzq3lmtrwK1/7JbuoxU
 1BV+uZnj2NmL58o69MT/F9MG5eP+4OQhw2PVUqOAJwjN3iNX/DH5UFv9h7nziiDpO3Wv
 KxcVxycJ/XHwEFbEw+RKJCAQgfG+2R1pkq1wUp38h0ZSYGuMQq12yU1H15KGAgC4P4vy
 B8H5Ryl+ZI4CKD4i32kI0Ic516GlmgnX9aBGf3WsvQBVOG7a+13hic6VIrKVJIZepTNm
 xWz4Q/aa0cY6cr/joGOdxFBKzEUp3wQEQSywiNXvzOOGebncj7XIAhhXkBKB02OuA5ES
 Xh4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeJhyJbsM+kxyHANkD6E3hLpw2EfpCzRG7ftr7dlTasZSw6lO5Svj3OrHbR3trsyIYC4i26hDj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmcbJIyr7UGFrZyOgLs1esHMe9j+NdTk0pYaWBPv6OoCk1w4xE
 M76Q1wkmaYHcmEUaa3/ucOvB1nMYPq+Y/EAj2nfJKplp/ibKzj+jvQWbqkNb
X-Gm-Gg: ASbGnctrqI+YDMKGrGsQ+UEFHMAhjsiGsC9NLeNABNK56bspQsjxwXgrvgF/o0Ymslp
 Fq2zmWg/asrhvDIKNkdwfrYpdxQ6qSehJyNAtAW/Dmn6uVsPc+KSxQzKkAMvgpk8tJAvhDSxCYp
 5Y+NIm2w4N9HRNGOFZqtIB6eIUManfTKPHvK0OIG6Tio+yCilqW4sAme0zsb3Zyx2YCP6NO2qfJ
 dgIUAmDe/ZUtnMEcTtK3VZMHWasURhExXubmvKoRSIYSuJK5uBvGpM8bGaEp3k/+fGtSi4aCV45
 YsT4qfeY7v+62bQeVG7CNw6cGqfrOcJZ+zPtyV0/RmfPbQo0I4AJZ7MoPONMOWYSs7KTvYaYMw=
 =
X-Google-Smtp-Source: AGHT+IGTDEHCFdSU8eL6xV8HQXvji2Ou+A2RjqW9w84aeD4ajKFeD1NjuqQ0pyvHkgv5/S4YhSY0Yg==
X-Received: by 2002:adf:a454:0:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3971e3a5680mr2926080f8f.29.1741961585245; 
 Fri, 14 Mar 2025 07:13:05 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a5esm5611073f8f.27.2025.03.14.07.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 07:13:04 -0700 (PDT)
Message-ID: <898df91a-3831-4d2b-8a06-d8f37fbaefec@gmail.com>
Date: Fri, 14 Mar 2025 15:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: overwrite signaled fence in amdgpu_sync
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-3-christian.koenig@amd.com>
 <d16eb6df-8a40-4afd-8099-c218fd43aabc@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d16eb6df-8a40-4afd-8099-c218fd43aabc@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 12.03.25 um 16:06 schrieb SRINIVASAN SHANMUGAM:
>
> On 3/7/2025 7:18 PM, Christian König wrote:
>> This allows using amdgpu_sync even without peeking into the fences for a
>> long time.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index 86c17a8946f5..bfe12164d27d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -135,11 +135,16 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
>>       struct amdgpu_sync_entry *e;
>>         hash_for_each_possible(sync->fences, e, node, f->context) {
>> -        if (unlikely(e->fence->context != f->context))
>> -            continue;
>> +        if (dma_fence_is_signaled(e->fence)) {
>> +            dma_fence_put(e->fence);
>> +            e->fence = dma_fence_get(f);
>> +            return true;
>> +        }
>>   -        amdgpu_sync_keep_later(&e->fence, f);
>> -        return true;
>> +        if (likely(e->fence->context == f->context)) {
>> +            amdgpu_sync_keep_later(&e->fence, f);
> --> The call to amdgpu_sync_keep_later(&e->fence, f); ensures that the new fence is tracked for future synchronization., ie., so If the driver only replaced the old fence without keeping a reference to the new one of the next job or second job for example, it could lead to situations where the synchronization state is lost. This could cause race conditions where one job might proceed before another job has completed, leading to errors. , so this is  " amdgpu_sync_keep_later(&e->fence, f);" done, for tracking purpose of next job/second job, if we have multiple jobs in gang submissions of same context/client, is my understanding is correct here pls?

Your questions is not easy to understand, but I think your understanding is correct.

Basically if you have submissions A,B,C to the same ring buffer and the HW guarantees that they execute in order you only need to keep a reference to C to wait for A and B as well.

Regards,
Christian.

>> +            return true;
>> +        }
>>       }
>>       return false;
>>   }

