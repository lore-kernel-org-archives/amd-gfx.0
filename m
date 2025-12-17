Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21709D64093
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEC710E58A;
	Wed, 17 Dec 2025 09:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="tZ6QGRob";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE74910E585
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:03:35 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH178re014417;
 Wed, 17 Dec 2025 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OyLrUq
 CNH9ViqXpnJZJu1xYEOhC9U/Qc3yjD/pWxOT8=; b=tZ6QGRobYIduUmWcPWoJTq
 nKN/ZdGUi+8RzUGOU2zgfWEJ7LpQCjdw1C8qIfZvpQasVzsYhz86dLR2dbh0gCBu
 M2Ya/grK8gLgB3umsRhya5LbeljvWqFUh4BsDE1RY+IsOaCd5kP/3J8TpthbnO2s
 wwwclOzYe4f/lNGDpkZ4KqZOWQ3NcfjZUm5nBPZbCSFKHYfQGlELBrAsfWiEOJwy
 b7570cX8Z/LzFohrN9nPiubah+Cy0vlVyZUPeDXlgFZRwE3droaGgBJAvbXREC43
 0edpNvmg0Pr63r4sYLQEPJ4jSEaeYZD9C43ukLwU8Z3f61JnjnOt4maBn3Lrh3fg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8m2sv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:03:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH93WeM020554;
 Wed, 17 Dec 2025 09:03:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8m2sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:03:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH7TL56014318;
 Wed, 17 Dec 2025 09:03:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpk11y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Dec 2025 09:03:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BH93UFn32571958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Dec 2025 09:03:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9136C58052;
 Wed, 17 Dec 2025 09:03:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07CE558056;
 Wed, 17 Dec 2025 09:03:27 +0000 (GMT)
Received: from [9.39.19.148] (unknown [9.39.19.148])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Dec 2025 09:03:26 +0000 (GMT)
Message-ID: <1f2a0b14-9cff-40cd-bdbc-71fae06c34b1@linux.ibm.com>
Date: Wed, 17 Dec 2025 14:33:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
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
 <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
 <bed34fa1-5971-416a-a3d4-7824d0387e02@linux.ibm.com>
 <CADnq5_Owfg0fG5mUo7NDZUNeB+QNas2EL+sK=42_deVSxiGfQQ@mail.gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <CADnq5_Owfg0fG5mUo7NDZUNeB+QNas2EL+sK=42_deVSxiGfQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfXwPtCcWNjii/R
 IH/yffZ5Xn6U9eHxY+ON/Xqj0GMhzdRDZEBQPrBi9XcnHC2ZP4LE1+wnPtmIYwWaUs1JRR/Kv5I
 8HmwD7g/iQxRHD6XTfuLXd3HGfAeE0vWRcYdoC6vzE8Ox+zVATB4RMSSU9F3e0FsG+Zf/500EXb
 C8/2yA9Ij7hwhdUKZEU8b9fmtUORp7b3cNtMPXsO14apoAeBBoAVWAnJS9nYnaRMrcwYPEqgLRO
 noBh5UoIJz0JE01F1b6pNhcr5KIx1ZAJHI7cPaMiOEboh5989s2hCcbDBGD4AX2sPdIX9cFfyh9
 T0kr7NVLhMkslHnJZc2FNlA4+O3KPOU7JRgGnkWH03qm+kIL6pat0VEKefnuvaA6PykAVMiK3XH
 jS1wfzipdp8K0eMw299jwnuMXOtXRw==
X-Proofpoint-GUID: s14wJW2t5-lhHeTA3NYPi3waILgdKkGd
X-Proofpoint-ORIG-GUID: xgzymJCMQWXMUBunGp1kzGVSpcTftlfr
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=694271e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=fSlJ9ulIoR0CtGt3cwQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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


On 12/16/25 7:32 PM, Alex Deucher wrote:
> On Tue, Dec 16, 2025 at 8:55 AM Donet Tom <donettom@linux.ibm.com> wrote:
>>
>> On 12/15/25 7:39 PM, Alex Deucher wrote:
>>> On Mon, Dec 15, 2025 at 4:47 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>> On 12/12/25 18:24, Alex Deucher wrote:
>>>>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>>>>> <christian.koenig@amd.com> wrote:
>>>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>>>>> Christian König <christian.koenig@amd.com> writes:
>>>>>>>>> Setup details:
>>>>>>>>> ============
>>>>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>>>>> AMD GPU:
>>>>>>>>>     Name:                    gfx90a
>>>>>>>>>     Marketing Name:          AMD Instinct MI210
>>>>>>>>>
>>>>>>>>> Queries:
>>>>>>>>> =======
>>>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>>>>>      these changes. Is there anything else that you would suggest us to run to
>>>>>>>>>      shake out any other page size related issues w.r.t the kernel driver?
>>>>>>>> The ROCm team needs to answer that.
>>>>>>>>
>>>>>>> Is there any separate mailing list or list of people whom we can cc
>>>>>>> then?
>>>>>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>>>>>
>>>>>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>>>>>
>>>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>>>>>      size HW dependent? Should it be made PAGE_SIZE?
>>>>>>>> Yes and no.
>>>>>>>>
>>>>>>> If you could more elaborate on this please? I am assuming you would
>>>>>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>>>>>> that would be great!
>>>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>>>>>
>>>>>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>>>>>
>>>>>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>>>>>
>>>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>>>>>      Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>>>>>      non-4K page sizes?
>>>>>>>> The problem is the HW can't do this.
>>>>>>>>
>>>>>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>>>>>> what functionality will be unsupported due to this HW limitation then?
>>>>>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
>>>>> Right.  There are some 4K pages with the MMIO register BAR which are
>>>>> empty and registers can be remapped into them.  In this case we remap
>>>>> the HDP flush registers into one of those register pages.  This allows
>>>>> applications to flush the HDP write FIFO from either the CPU or
>>>>> another device.  This is needed to flush data written by the CPU or
>>>>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
>>>>> it).  This is flushed internally as part of the shader dispatch
>>>>> packets,
>>>> As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.
>>> There is an explicit PM4 packet to flush the HDP cache for userqs and
>>> for AQL the flush is handled via one of the flags in the dispatch
>>> packet.  The MMIO remap is needed for more fine grained use cases
>>> where you might have the CPU or another device operating in a gang
>>> like scenario with the GPU.
>>
>> Thank you, Alex.
>>
>> We were encountering an issue while running the RCCL unit tests. With 2
>> GPUs, all tests passed successfully; however, when running with more
>> than 2 GPUs, the tests began to fail at random points with the following
>> errors:
>>
>> [  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for
>> queue with doorbell_id: 80030008
>> [  606.696820] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
>> [  606.696826] amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
>> [  610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for
>> queue with doorbell_id: 80030008
>> [  610.696869] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
>> [  610.696942] amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues
>>
>>
>> After applying patches 7/8 and 8/8, we are no longer seeing this issue.
>>
>> One question I have is: we only started observing this problem when the
>> number of GPUs increased. Could this be related to MMIO remapping not
>> being available?
> It could be.  E.g., if the CPU or a GPU writes data to VRAM on another
> GPU, you will need to flush the HDP to make sure that data hits VRAM
> before the GPU attached to the VRAM can see it.


Thanks Alex

I am now suspecting that the queue preemption issue may be related to 
the unavailability of MMIO remapping. I am not very familiar with this area.

Could you please point me to the relevant code path where the PM4 packet 
is issued to flush the HDP cache?

I am consistently able to reproduce this issue on my system when using 
more than three GPUs if patches 7/8 and 8/8 are not applied. In your 
opinion, is there anything that can be done to speed up the HDP flush or 
to avoid this situation altogether?



>
> Alex
>
>>
>>> Alex
>>>
>>>> That's the reason why ROCm needs the remapped MMIO register BAR.
>>>>
>>>>> but there are certain cases where an application may want
>>>>> more control.  This is probably not a showstopper for most ROCm apps.
>>>> Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.
>>>>
>>>> Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.
>>>>
>>>> If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.
>>>>
>>>> The only tricky part is that you need to get the HW barriers with the doorbell write right.....
>>>>
>>>>> That said, the region is only 4K so if you allow applications to map a
>>>>> larger region they would get access to GPU register pages which they
>>>>> shouldn't have access to.
>>>> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>>>
>>>> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.
>>>>
>>>> Christian.
>>>>
>>>>> Alex
>>>>>
>>>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>>>>> supported with amd gpu kernel driver.
>>>>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>>>>> That's a bummer :(
>>>>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>>>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>>>>
>>>>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>>>>
>>>>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>>>>
>>>>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>>>>> Not that I know off any.
>>>>>>
>>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>>>>
>>>>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>>>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>>>>
>>>>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>>>>
>>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>>>>> due to 64K pagesize.
>>>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>>>
>>>>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>>>
>>>>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>>>>> at least with these changes, we were able to see all the tests passing.
>>>>>>>
>>>>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>>>>
>>>>>>> Thanks a lot! That would be super helpful!
>>>>>>>
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>> Thanks again for the quick response on the patch series.
>>>>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> -ritesh
