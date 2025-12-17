Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151DD65526
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E2A10E0CB;
	Wed, 17 Dec 2025 09:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="W3Hv/OdT";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983A310E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:46:50 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGJa6Fk025937;
 Wed, 17 Dec 2025 09:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=letsVF
 IEZP60le/EKPz/5ktwUJdBiQnX6wW2/iJS1bQ=; b=W3Hv/OdThgm1dbUNfQZWHC
 rn38HWrYu/Js5KSAfylpDL5WQiZK35h6ryyCr/40aX/lkZWoFYYUbPTH58JzfPqO
 lJDsRffvk+X5SpOKA9lIqyPHRF5T4Me2yoWDtvKPJVarQoaUFiap7ws15OFRF/Ak
 nHEVGC1/kjyjivWigFBuGRJ2jlUIFzfSop1bKdKKvtu0YEryyF2O7tC81/mDnji2
 w/Wvw0QcExP/yq5CZRcjwvnVloRmKO6XPqjeNcwiq9ApWLMnsSfGX8IlIX2cty7q
 nSfCu+LSaygiN0v62cuXMWDQYFt8+6+6rtfuKeGW852dYsjDbjjh5ZKzlUniGnKw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8m8ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:46:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH9kjPu011332;
 Wed, 17 Dec 2025 09:46:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8m8bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:46:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH7i4q7014337;
 Wed, 17 Dec 2025 09:46:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpk175x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:46:27 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BH9kQ8b28049800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Dec 2025 09:46:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFFD05805A;
 Wed, 17 Dec 2025 09:46:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 634BD5805E;
 Wed, 17 Dec 2025 09:46:22 +0000 (GMT)
Received: from [9.39.19.148] (unknown [9.39.19.148])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Dec 2025 09:46:22 +0000 (GMT)
Message-ID: <c0e24bd4-bc4e-4a6f-9229-57cbb85d0d7e@linux.ibm.com>
Date: Wed, 17 Dec 2025 15:16:20 +0530
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
 <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
 <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfXwnO6p5Uvfaxd
 n6LxhdNSBad3+YKwERj/XXg1Hcea+Ndro8GdsTElJMICIT6wH+uGgBzn2Gy/3Rd/V+j53JjLdp3
 Bvh1jGlnhWgm6GraSnqTLZMEC+R3bmV4UowUrvYJu/Zjf0nSd/eyJvv+DCxVScd0Wgq1wAensVC
 w8LUBC4m7w4IntWo9hSisk6X+8QhQaeSW+FQnOUTSrBI7dtccpPqoDwuDC8jUhjynhbHApefenh
 LvDjMxjRpJGKBB06CgvWhWMV7rp+YHUgMc/53muFYlSdqdn7mqSHSYoDFOOmEe5UTyJkdG0vUXv
 5VWWRRnMjwFRzdQ6D5iDb/RMguT/gNueQiqza2MPvcXSca+Dgve883BRLFjKeHqqn4j+UQegcwt
 dfIDhMv6vu/odhieGwWteZbLkvsO7g==
X-Proofpoint-GUID: TqgPK8Kxfs3A54wR0WgEZzdrDCjS_HRT
X-Proofpoint-ORIG-GUID: QLb_cW41WGK7RwHzzVmQ5QXAclHTkYXh
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69427c06 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=zd2uoN0lAAAA:8 a=fSlJ9ulIoR0CtGt3cwQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018
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


On 12/15/25 9:41 PM, Christian König wrote:
> On 12/15/25 11:11, Donet Tom wrote:
>> On 12/15/25 3:17 PM, Christian König wrote:
>>> On 12/12/25 18:24, Alex Deucher wrote:
>>>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>>>> Christian König <christian.koenig@amd.com> writes:
>>>>>>>> Setup details:
>>>>>>>> ============
>>>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>>>> AMD GPU:
>>>>>>>>     Name:                    gfx90a
>>>>>>>>     Marketing Name:          AMD Instinct MI210
>>>>>>>>
>>>>>>>> Queries:
>>>>>>>> =======
>>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>>>>      these changes. Is there anything else that you would suggest us to run to
>>>>>>>>      shake out any other page size related issues w.r.t the kernel driver?
>>>>>>> The ROCm team needs to answer that.
>>>>>>>
>>>>>> Is there any separate mailing list or list of people whom we can cc
>>>>>> then?
>>>>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>>>>
>>>>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>>>>
>>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>>>>      size HW dependent? Should it be made PAGE_SIZE?
>>>>>>> Yes and no.
>>>>>>>
>>>>>> If you could more elaborate on this please? I am assuming you would
>>>>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>>>>> that would be great!
>>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>>>>
>>>>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>>>>
>>>>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>>>>
>>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>>>>      Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>>>>      non-4K page sizes?
>>>>>>> The problem is the HW can't do this.
>>>>>>>
>>>>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>>>>> what functionality will be unsupported due to this HW limitation then?
>>>>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
>>>> Right.  There are some 4K pages with the MMIO register BAR which are
>>>> empty and registers can be remapped into them.  In this case we remap
>>>> the HDP flush registers into one of those register pages.  This allows
>>>> applications to flush the HDP write FIFO from either the CPU or
>>>> another device.  This is needed to flush data written by the CPU or
>>>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
>>>> it).  This is flushed internally as part of the shader dispatch
>>>> packets,
>>> As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.
>>>
>>> That's the reason why ROCm needs the remapped MMIO register BAR.
>>>
>>>> but there are certain cases where an application may want
>>>> more control.  This is probably not a showstopper for most ROCm apps.
>>> Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.
>>>
>>> Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.
>>>
>>> If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.
>>>
>>> The only tricky part is that you need to get the HW barriers with the doorbell write right.....
>>>
>>>> That said, the region is only 4K so if you allow applications to map a
>>>> larger region they would get access to GPU register pages which they
>>>> shouldn't have access to.
>>> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>>
>>> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.
>>
>> Sorry, Cristian — I may be misunderstanding this point, so I would appreciate some clarification.
>>
>> If the CPU page size is 64K and the GPU page size is 4K, then from the GPU side the page table entries are created and mapped at 4K granularity, while on the CPU side the pages remain 64K. To map a single CPU page to the GPU, we therefore need to create multiple GPU page table entries for that CPU page.
> The GPU page tables are 4k in size no matter what the CPU page size is and there is some special handling so that we can allocate them even under memory pressure. Background is that you sometimes need to split up higher order pages (1G, 2M) into lower order pages (2M, 4k) to be able to swap things to system memory for example and for that you need some an extra layer of page tables.
>
> The problem is now that those 4k pages are rounded up to your CPU page size, resulting in both wasting quite some memory as well as messing up the special handling to not run into OOM situations when swapping things to system memory....


Thank you, Christian, for the clarification.

When you say swapping to system memory, does that mean SVM migration to 
DRAM?

 From my understanding of the code, SVM pages are tracked in system 
page–size PFNs, which on our system is 64 KB. With a 64 KB base page 
size, buffer objects (BOs) are allocated in 64 KB–aligned chunks, both 
in VRAM and GTT, while the GPU page-table mappings are still created 
using 4 KB pages.

During SVM migration from VRAM to system memory, I observed that an 
entire 64 KB page is migrated. Similarly, when XNACK is enabled, if the 
GPU accesses a 4 KB page, my understanding is that the entire 64 KB page 
is migrated.

If my understanding is correct, allocating 4 KB memory on a 64 KB 
page–size system results in a 64 KB BO allocation, meaning that around 
60 KB is effectively wasted. Are you referring to this kind of 
over-allocation potentially leading to OOM situations under memory pressure?

Since I am still getting familiar with the AMDGPU codebase, could you 
please point me to the locations where special handling is implemented 
to avoid OOM conditions during swapping or migration?


>
> What we could potentially do is to switch to 64k pages on the GPU as well (the HW is flexible enough to be re-configurable), but that is tons of changes and probably not easily testable.
>
> Regards,
> Christian.
>
>> We found that this was not being handled correctly in the SVM path and addressed it with the change in patch 2/8.
>>
>> Given this, if the memory is allocated and mapped in GPU page-size (4K) granularity on the GPU side, could you please clarify how memory waste occurs in this scenario?
>>
>> Thank you for your time and guidance.
>>
>>
>>> Christian.
>>>
>>>> Alex
>>>>
>>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>>
>>>>>>>>
>>>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>>>> supported with amd gpu kernel driver.
>>>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>>>> That's a bummer :(
>>>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>>>
>>>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>>>
>>>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>>>
>>>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>>>> Not that I know off any.
>>>>>
>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>>>
>>>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>>>
>>>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>>>
>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>>>> due to 64K pagesize.
>>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>>
>>>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>>
>>>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>>>> at least with these changes, we were able to see all the tests passing.
>>>>>>
>>>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>>>
>>>>>> Thanks a lot! That would be super helpful!
>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>> Thanks again for the quick response on the patch series.
>>>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> -ritesh
