Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78182C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 00:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C0A10E334;
	Fri,  3 Jul 2026 00:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOtprTXW";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A99B10E334
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 00:35:36 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-92e533aacf2so671585a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 17:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783038935; x=1783643735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IhuPZo9By9WeOKbnJZiXCMtpI4vqAR0qLJD+1E3bLpo=;
 b=nOtprTXW4ewmf0vYJ6/cSZ9NoAr/FadyUwMmNvzf4pfshiM61P6ZCfl1lk8jeZXvnn
 71Jl65vjgSVdND+TNQsJ4Ftnv9HXWgLffbK4IXykUuFn/2uzDrZWjgCQPcBdDRstNPNY
 3IYVSRQltMp4/Kuyu5vFfMtLz2f7NUsveyS6sjB4PlVoFf9DgufKxR2UFRq0j6HjqO7i
 MeMlBfSg3Bi8AJR0TWXqyewuZSi3IEGJkUDeNt/sIpj2sZrKOs/jF95ib9PQCF29l4zD
 wQr1EcfAAkZU6EKOzGyeuSSTF1JdbBXCvZRVtEX+aTuA4ih8+zxo83eit62P9cn9lyvd
 tQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783038935; x=1783643735;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhuPZo9By9WeOKbnJZiXCMtpI4vqAR0qLJD+1E3bLpo=;
 b=UEGrEgw2IVPAn9Ctqv4bcaEF8FOguaghf1CAQ89gef4ldCALsL1LpY/JIvLP7Y5aJY
 gP+PRkQ8YpX8KGTCBeEMubA6DgbhfFltBhgnFYQ6ij0XtLMLNZGiyyErJGfCTMFmCuZp
 yeHwgAj592f+yCB5pClEeN8O+6ZBSEPOX/oJBfCXno8tucSUPzR1HoQQ+Oq89D/DQ3pP
 t8U3AU1O85XoVbQnOZjdupgnJ/O83kgNGccyp/6BUy9VOWneXlHTbD8WSmohFWl7ZfX0
 DxPbJolcAOot0uftci272g5T8U+FddwR48m1MQH4IssB88Ld14lH6LVFsesJc2El7Rjv
 i+yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pKo3iCsrdwu0N6z4b+TES13iUqAyBQGtzawVMPz+zKaIhhPpIaPCVgGJoVQLBvGaQ97PlXd3a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWjC1qZkTOVJCNYQs8+ghghkQMyonxZcvq3bMafSe+sKY7NTk0
 oyt1kAqf5nisVWCkCZRHaA6aOuYXiNcLOOLLuzWDx6ePzgYnCN6c1YfY
X-Gm-Gg: AfdE7ckxIFSu2VrUmVL272YAcC1rxyAy5w0JgpBNiWCcQqkedCn6l8yyJA+J0N9yh5x
 zuLFVu/t+ghTewe5RT6v8rOZS91WjxJYkFOdWb5eFqw0PmkMREhu3N4kgfvCxb7BZgEIXzZZHR2
 EQaoMsVdoc6o4r6CNIZDL1ZgcGHBIhie2OzBiojRHMVLcZnpPkZaEutPHsALWOQsKMRfFS9OdrV
 yUAiXKvVY/xqtlVmsPk473/BIg1rPne0YpUmhJCh4nlExfz9kPwFhQA4oq/tECzCfAJ7K7BY4VO
 xx7+wRcETXLJv1ObAOl+OvwuzBw53tpY3OwA9UM/9qIagjue15jHbS7sMkIGQXrasmOZOckB+9A
 BRHPaGxVFiYVAnJUGAtxXXjgJNrPVROjzz4GfnM5lqZ8mQJrYwZwACkZaRIPl9GD6JCyAWzPUD/
 3aEWEhaI/rLlSgnOAaUw==
X-Received: by 2002:a05:620a:269b:b0:92e:675e:8ef0 with SMTP id
 af79cd13be357-92e7b473cfbmr986657085a.68.1783038935434; 
 Thu, 02 Jul 2026 17:35:35 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.73.95])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-92e9095e780sm23952485a.0.2026.07.02.17.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 17:35:34 -0700 (PDT)
Message-ID: <edcfd337-2cba-49da-a77e-3a2f8aa67e4c@gmail.com>
Date: Thu, 2 Jul 2026 20:35:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: bail out of try_harder when alignment
 cannot be honoured
To: Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, stable@vger.kernel.org
References: <20260629074311.68836-1-Arunpravin.PaneerSelvam@amd.com>
 <a4657daa-c58e-4441-ad81-c3e770bc5a94@intel.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <a4657daa-c58e-4441-ad81-c3e770bc5a94@intel.com>
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

On 7/2/26 6:48 AM, Matthew Auld wrote:
> On 29/06/2026 08:43, Arunpravin Paneer Selvam wrote:
>> The try_harder contiguous fallback could return a range whose start
>> offset did not match the caller's min_block_size. When a candidate's
>> start is misaligned, realign it: free the misaligned run and reallocate
>> exactly @size at the next lower min_block_size boundary. This keeps the
>> returned size unchanged with no surplus to trim, and rejects the request
>> only when no aligned candidate fits.
>>
>> v2: align misaligned candidates down to min_block_size instead of
>>      bailing out, for both the RHS and LHS paths (Matthew).
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Cc: John Olender <john.olender@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 

I haven't hit any issues with this revision during testing.

Thanks,
John

>> ---
>>   drivers/gpu/buddy.c | 63 +++++++++++++++++++++++++++++++--------------
>>   1 file changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index dc81fe0301ce..3c73ae87f3c5 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1118,22 +1118,30 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>>                    blocks, total_allocated_on_err);
>>   }
>>   +static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>> +                    u64 unaligned_offset,
>> +                    u64 size,
>> +                    u64 min_block_size,
>> +                    struct list_head *blocks)
>> +{
>> +    u64 aligned_offset = round_down(unaligned_offset, min_block_size);
>> +
>> +    return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
>> +}
>> +
>>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>                        u64 size,
>>                        u64 min_block_size,
>>                        struct list_head *blocks)
>>   {
>> -    u64 rhs_offset, lhs_offset, lhs_size, filled;
>> +    u64 rhs_offset, lhs_offset, filled;
>>       struct gpu_buddy_block *block;
>>       unsigned int tree, order;
>> -    LIST_HEAD(blocks_lhs);
>> -    unsigned long pages;
>>       u64 modify_size;
>>       int err;
>>         modify_size = rounddown_pow_of_two(size);
>> -    pages = modify_size >> ilog2(mm->chunk_size);
>> -    order = fls(pages) - 1;
>> +    order = ilog2(modify_size) - ilog2(mm->chunk_size);
>>       if (order == 0)
>>           return -ENOSPC;
>>   @@ -1149,31 +1157,48 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>           while (iter) {
>>               block = rbtree_get_free_block(iter);
>>   -            /* Allocate blocks traversing RHS */
>>               rhs_offset = gpu_buddy_block_offset(block);
>> +
>> +            /* Allocate blocks traversing RHS */
>>               err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>>                                  &filled, blocks);
>> -            if (!err || err != -ENOSPC)
>> +            if (err && err != -ENOSPC)
>>                   return err;
>> +            if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>> +                return 0;
>> +            if (!err) {
>> +                /* Allocate the unaligned RHS offset using round_down */
>> +                gpu_buddy_free_list_internal(mm, blocks);
>> +                err = __alloc_contig_aligned_retry(mm, rhs_offset,
>> +                                   size,
>> +                                   min_block_size,
>> +                                   blocks);
>> +                if (!err)
>> +                    return 0;
>> +                if (err != -ENOSPC) {
>> +                    gpu_buddy_free_list_internal(mm, blocks);
>> +                    return err;
>> +                }
>> +                goto next;
>> +            }
>>   -            lhs_size = max((size - filled), min_block_size);
>> -            if (!IS_ALIGNED(lhs_size, min_block_size))
>> -                lhs_size = round_up(lhs_size, min_block_size);
>> +            if (size - filled > rhs_offset)
>> +                goto next;
>>   -            /* Allocate blocks traversing LHS */
>> -            lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
>> -            err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>> -                               NULL, &blocks_lhs);
>> -            if (!err) {
>> -                list_splice(&blocks_lhs, blocks);
>> +            lhs_offset = rhs_offset - (size - filled);
>> +
>> +            /* Allocate the unaligned LHS offset using round_down */
>> +            gpu_buddy_free_list_internal(mm, blocks);
>> +            err = __alloc_contig_aligned_retry(mm, lhs_offset, size,
>> +                               min_block_size, blocks);
>> +            if (!err)
>>                   return 0;
>> -            } else if (err != -ENOSPC) {
>> +            if (err != -ENOSPC) {
>>                   gpu_buddy_free_list_internal(mm, blocks);
>>                   return err;
>>               }
>> -            /* Free blocks for the next iteration */
>> +next:
>>               gpu_buddy_free_list_internal(mm, blocks);
>> -
>>               iter = rb_prev(iter);
>>           }
>>       }
>>
>> base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
> 

