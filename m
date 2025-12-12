Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090A4D4922B
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E6E10E6A7;
	Fri, 12 Dec 2025 13:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zj/QDQHi";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440B310E5B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 11:09:35 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-29806bd47b5so6853445ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 03:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765537775; x=1766142575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LWThh888wTHNeMNoovpZ6siNOEBzMB4V7mHEK6cNEW4=;
 b=Zj/QDQHiYpplwVYdT8WTgozucU1fmQHMwo/S4NoWSPfqGxfbbDga7u9VhHYbCHhEjy
 yba8MM6MgXZqKnVIZLxI+sPHIriFt+L+h3aiNrzHZBjKjkRS8w8MnS0tY4JuVUeJiG1s
 B+MW3HLZKB4vSWxorc7AJC5J4Yl/fd1Bqliggi+ngLqZgNPob5HOld8NIyDdMS4OqFAC
 CXe/eN/gIPlrAgLUEzrLxBT9jMl48GwO9WYou3+ezuOmpwQCGYA5UH7memnlhaFaverU
 5+FB2DvzU2WA4f2c7OZdIpYN+OJmjvpDDwqjji7c+ZRnzpd2d4K7flPOalkW4Yu6dyjo
 XRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765537775; x=1766142575;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LWThh888wTHNeMNoovpZ6siNOEBzMB4V7mHEK6cNEW4=;
 b=uEEt/gzf7V9+B+n7RKhJuXwxpH8C2TluXhmCSNTu4risuec4uvhxtBLv7UDfgSi9rv
 aDPES77q7XV/J3IcQ3tloV7xjaDQQbPLAknnfMiW6IxJbdsFQPs8LU1o8K8mZGjNQweT
 G5ke8df+kcxqkV+hMUNOCuNv4K1dS5OSA5VMdMWfhKOF20gjO302O38hlOQJPh5gffVM
 fecaqy28NDOqFzA9XBInPHmNAbjsFESYekWTTNjE9ZYlDWE+UkkOPTBx0JNyJ6SQqWYi
 BvPgVc17wFvcm84/AMG0dIjtKnFL2xTIkdsqQPlAXYvRTIREth7x3SIOmVgwNsZKANKW
 hOxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOSqAZ+ewbnqaop1FQLXk7+aiC6fOL8LWm2WBiHf0OVbkqsBf5szCwshHJzIiYHLCcq04mR19q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxFk3vUveWe+MN69gjQ3d10oQLAPO7w3CRvc0/IQd6HOdnzFe6
 lzJxMuskIN3ol8elBKSaYzv1ApFlcxvQqyJ1b1Gw9BBkE9nGI4fbe+Po
X-Gm-Gg: AY/fxX67UDWFJJTGmAWnrKexcfZ4SlDW5EmW//0c7/l0Kl34CObOQe4cwGzcndCcxBw
 kw5YsGThOf5r+gww8hyBXar+iPwR+lMaQeSj5RgPDpyoGFlnOV9+oY2Ai5e9MxQZm/frYcUCz/d
 6bodCopRZAGrG5avt7x7uublAAvhkrgNyBfhFUWR4FnyC7sxGN1ZC4Q8qYvD2pxu6GuiC6NzQd5
 Ns60CSvLdpJtX95umVIKbY89aDQO/bFGIcpn3KVDS+WU+T0mZcLUm4q72ICztQX9RhGMCbNY8Lk
 N1J964l67oi1Hv9uEf0i5+VlUG25jkUjp0c5AEIpuJ3+9f5akTTSulpeSpw0iG9Bb9rcyNZUnxp
 BSN43kijY5SoyZPLRbJNbxonEBfcYXOp+O6iYDWoa4srCMJDYLmSPleSxqnJ0i6BkWXfhPJQ40W
 qM6XL/
X-Google-Smtp-Source: AGHT+IE6WMGqndcjj3cbpvTW+Hq0Oefiq4svZKWB9oH8HmRYrT1O5p1ld5inTEw4xdE14N8QMC2A+A==
X-Received: by 2002:a17:903:2f50:b0:298:60d5:d272 with SMTP id
 d9443c01a7336-29f23e08409mr23599305ad.17.1765537774564; 
 Fri, 12 Dec 2025 03:09:34 -0800 (PST)
Received: from dw-tp ([171.76.86.230]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7f4c5093d5csm4946588b3a.49.2025.12.12.03.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:09:33 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Donet Tom
 <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, Felix Kuehling
 <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
In-Reply-To: <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
Date: Fri, 12 Dec 2025 16:15:23 +0530
Message-ID: <871pl0567w.ritesh.list@gmail.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:57:48 +0000
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

Christian König <christian.koenig@amd.com> writes:

> On 12/12/25 07:40, Donet Tom wrote:
>> This patch series addresses few issues which we encountered while running rocr
>> debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), using 64k
>> system pagesize.
>> 
>> Note that we don't observe any of these issues while booting with 4k system
>> pagesize on Power. So with the 64K system pagesize what we observed so far is,
>> at few of the places, the conversion between gpu pfn to cpu pfn (or vice versa)
>> may not be done correctly (due to different page size of AMD GPU (4K)
>> v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu hang
>> while running these tests.
>> 
>> Changes so far in this series:
>> =============================
>> 1. For now, during kfd queue creation, this patch lifts the restriction on EOP
>>    buffer size to be same buffer object mapping size.
>> 
>> 2. Fix SVM range map/unmap operations to convert CPU page numbers to GPU page
>>    numbers before calling amdgpu_vm_update_range(), which expects 4K GPU pages.
>>    Without this the rocr-debug-agent tests and rccl unit  tests were failing.
>> 
>> 3. Fix GART PTE allocation in migration code to account for multiple GPU pages
>>    per CPU page. The current code only allocates PTEs based on number of CPU
>>    pages, but GART may need one PTE per 4K GPU page.
>> 
>> 4. Adjust AMDGPU_GTT_MAX_TRANSFER_SIZE to respect the SDMA engine's 4MB hardware
>>    limit regardless of CPU page size. The hardcoded 512 pages worked on 4K
>>    systems but seems to be exceeding the limit with 64K system page size.
>> 
>> 5. In the current driver, MMIO remap is supported only when the system page
>>    size is 4K. Error messages have been added to indicate that MMIO remap
>>    is not supported on systems with a non-4K page size.
>> 
>> 6. Fix amdgpu page fault handler (for xnack) to pass the corresponding system
>>    pfn (instead of gpu pfn) for restoring SVM range mapping.
>> 
>> 7. Align ctl_stack_size and wg_data_size to GPU page size.
>> 
>> 8. On systems where the CPU page size is larger than the GPU’s 4K page size,
>>    the MQD and control stack are aligned to the CPU PAGE_SIZE, causing
>>    multiple GPU pages to inherit the UC attribute incorrectly. This results
>>    in the control-stack area being mis-mapped and leads to queue preemption
>>    and eviction failures. Aligning both regions to the GPU page size
>>    ensures the MQD is mapped UC and the control stack NC, restoring correct
>>    behavior.
>> 
>> 9. Apart from these 8 changes, we also needed this change [1]. Without this change
>>    kernel simply crashes when running rocminfo command itself.
>>    [1]: https://github.com/greenforce-project/chromeos-kernel-mirror/commit/2b33fad96c3129a2a53a42b9d90fb3b906145b98
>> 
>> Setup details:
>> ============
>> System details: Power10 LPAR using 64K pagesize.
>> AMD GPU:
>>   Name:                    gfx90a
>>   Marketing Name:          AMD Instinct MI210
>> 
>> Queries:
>> =======
>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>    these changes. Is there anything else that you would suggest us to run to
>>    shake out any other page size related issues w.r.t the kernel driver?
>
> The ROCm team needs to answer that.
>

Is there any separate mailing list or list of people whom we can cc
then?

>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>    size HW dependent? Should it be made PAGE_SIZE?
>
> Yes and no.
>

If you could more elaborate on this please? I am assuming you would
anyway respond with more context / details on Patch-1 itself. If yes,
that would be great!

>> 
>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>    Do we need to lift this restriction and add MMIO remap support for systems with
>>    non-4K page sizes?
>
> The problem is the HW can't do this.
>

We aren't that familiar with the HW / SW stack here. Wanted to understand
what functionality will be unsupported due to this HW limitation then?

>> 
>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>> 
>> 
>> Please note that the changes in this series are on a best effort basis from our
>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>> supported with amd gpu kernel driver.
>
> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.

That's a bummer :( 
- Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
- Are there any latest AMD GPU versions which maybe lifts such restrictions?

> What we can do is to support graphics and MM, but that should already work out of the box.
>

- Maybe we should also document, what will work and what won't work due to these HW limitations.


> What we can do is to support graphics and MM, but that should already work out of the box.

So these patches helped us resolve most of the issues like SDMA hangs
and GPU kernel page faults which we saw with rocr and rccl tests with
64K pagesize. Meaning, we didn't see this working out of box perhaps
due to 64K pagesize.

AFAIU, some of these patches may require re-work based on reviews, but
at least with these changes, we were able to see all the tests passing.

> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>

Thanks a lot! That would be super helpful!


> Regards,
> Christian.
>

Thanks again for the quick response on the patch series.

-ritesh
