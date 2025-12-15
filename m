Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B36D59D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F8010E3D8;
	Mon, 15 Dec 2025 10:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="i0Fc38UJ";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FA110E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:11:54 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BEKPP6O008696;
 Mon, 15 Dec 2025 10:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6eexRg
 br0IZm999taNpzQKZKJKk/dMXeD9rBpau1y9Y=; b=i0Fc38UJwxcv4Vl+vs9//y
 S0i5bIwIsZXKUWDKKTQ9bHGuEZDDDpfUkG7WPV5BcEacnmJgLYE4411fDJFlURkK
 pxGQ2VeCG8hyOZxCrPDa0VbQ6oVQoEhdQNdu6lkfdKJGb/bh2ZlkzZUuJcJcV7xg
 53Im19AbzxtqOZ5XIgE2GUyXPs593X/HbxXgQLAbeE0lJT+uNv+sSxol1C/i2IFI
 sc1rs4HbPLG68wcypEFjOJE/euL/2iHkS2PDQcGDfpWTSGTcVUjo5/KnRBg9sCsR
 xepEG32llFrPqRHtTEFE9/dAcC724/OxLStr4i7pNvkLc/AOHgRVhngqowrLi+Kg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkrqvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 10:11:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFA7pwn016231;
 Mon, 15 Dec 2025 10:11:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkrqvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 10:11:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF7YunN012783;
 Mon, 15 Dec 2025 10:11:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juxww4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 10:11:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFABmNG25821932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 10:11:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19C7858054;
 Mon, 15 Dec 2025 10:11:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8F185803F;
 Mon, 15 Dec 2025 10:11:44 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 10:11:44 +0000 (GMT)
Message-ID: <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
Date: Mon, 15 Dec 2025 15:41:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S6YMfKpSfrJmyU6LFYxQcswkl-wKn7D7
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=693fdee6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=zd2uoN0lAAAA:8 a=xG_aP-PUQn1seHLX9yUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: U6Wl3n87wPcsLp-3hmgSU_v2eVlbQsK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX4doUp6M+L+u6
 NKJsCwWPeVdFuSqeLDn9i1KuhKVDB4ZxemicY8Fywt70Zc/OyAZBJqcGD9TVvy1lOrCGfFYGnKj
 OXM4Wk79tEQ6hxnRSF0Q9Zigb+O0Kn7cj8kG9JqxByaEH23mAaxq10sjNaDKja9zBbti/dk0Hdh
 pqoReuhYEeCR+OoryUA4dYEPHgm5wAYB236HGWMmHGT8K5MTQTl/wTf3rlbrnsfllXXRGfX7RCM
 qxqEm5RVc67REpEZgYsMc4VpSILwnxUB16x1LTRhsJO2WaHb4EB72GXasqpzEcbk+1hh6/xu4Un
 bPYQ6qiSwf3ewlUf4Hlll4L4mYtrVCxoR7Z6dwYd3qHCEVJKpLdroNR5+MjyNQaKUozscTnPzkr
 JYuJJg1EY5jPy6ReDIVLsTBfJPTpFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
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


On 12/15/25 3:17 PM, Christian König wrote:
> On 12/12/25 18:24, Alex Deucher wrote:
>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>> Christian König <christian.koenig@amd.com> writes:
>>>>>> Setup details:
>>>>>> ============
>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>> AMD GPU:
>>>>>>    Name:                    gfx90a
>>>>>>    Marketing Name:          AMD Instinct MI210
>>>>>>
>>>>>> Queries:
>>>>>> =======
>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>>     these changes. Is there anything else that you would suggest us to run to
>>>>>>     shake out any other page size related issues w.r.t the kernel driver?
>>>>> The ROCm team needs to answer that.
>>>>>
>>>> Is there any separate mailing list or list of people whom we can cc
>>>> then?
>>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>>
>>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>>
>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>>     size HW dependent? Should it be made PAGE_SIZE?
>>>>> Yes and no.
>>>>>
>>>> If you could more elaborate on this please? I am assuming you would
>>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>>> that would be great!
>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>>
>>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>>
>>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>>
>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>>     Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>>     non-4K page sizes?
>>>>> The problem is the HW can't do this.
>>>>>
>>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>>> what functionality will be unsupported due to this HW limitation then?
>>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
>> Right.  There are some 4K pages with the MMIO register BAR which are
>> empty and registers can be remapped into them.  In this case we remap
>> the HDP flush registers into one of those register pages.  This allows
>> applications to flush the HDP write FIFO from either the CPU or
>> another device.  This is needed to flush data written by the CPU or
>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
>> it).  This is flushed internally as part of the shader dispatch
>> packets,
> As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.
>
> That's the reason why ROCm needs the remapped MMIO register BAR.
>
>> but there are certain cases where an application may want
>> more control.  This is probably not a showstopper for most ROCm apps.
> Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.
>
> Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.
>
> If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.
>
> The only tricky part is that you need to get the HW barriers with the doorbell write right.....
>
>> That said, the region is only 4K so if you allow applications to map a
>> larger region they would get access to GPU register pages which they
>> shouldn't have access to.
> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>
> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.


Sorry, Cristian — I may be misunderstanding this point, so I would 
appreciate some clarification.

If the CPU page size is 64K and the GPU page size is 4K, then from the 
GPU side the page table entries are created and mapped at 4K 
granularity, while on the CPU side the pages remain 64K. To map a single 
CPU page to the GPU, we therefore need to create multiple GPU page table 
entries for that CPU page.

We found that this was not being handled correctly in the SVM path and 
addressed it with the change in patch 2/8.

Given this, if the memory is allocated and mapped in GPU page-size (4K) 
granularity on the GPU side, could you please clarify how memory waste 
occurs in this scenario?

Thank you for your time and guidance.


>
> Christian.
>
>> Alex
>>
>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>
>>>>>>
>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>> supported with amd gpu kernel driver.
>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>> That's a bummer :(
>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>
>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>
>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>
>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>> Not that I know off any.
>>>
>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>
>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>
>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>
>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>> due to 64K pagesize.
>>> Yeah, but this is all for ROCm and not the graphics side.
>>>
>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>
>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>> at least with these changes, we were able to see all the tests passing.
>>>>
>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>
>>>> Thanks a lot! That would be super helpful!
>>>>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>> Thanks again for the quick response on the patch series.
>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> -ritesh
