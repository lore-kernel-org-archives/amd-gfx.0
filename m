Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5436CDC198
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 12:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201E010E222;
	Tue,  6 Jan 2026 12:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ZbAsUOcv";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E59410E222
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 12:58:30 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6063Ac0t024579;
 Tue, 6 Jan 2026 12:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=FIrYOUXQJL/T+6UcnGGfhG6KAI/8fR
 RBDkBQ6VuLTRg=; b=ZbAsUOcv0rDVuHQjgKEmTdS3Uj59xu9LG+AgcRPRMay3QD
 0yVlaR7IEcSN+8wxX4Y10KG3BPIxgTng8UaP6o7/Xf4jzsjxb6ACu8F/kRCY8BXk
 28yiIzmB8LpRsIjrwfM3h7fG6TqCiK3fXbvoajVRq4Tb+p/Nv68M8IYFKt3vjpwg
 RSSHhc47qmIuLFibzPKO86c1GqZJm6viupKhERG+oSXrN6USyhOb30y+p4xhy4Qu
 Up1OynamSJqTCjn2x9FurxqIVbFRs2EXRvkwQ1Yn8IH8+vDZw7k6KaTATYS9dYpO
 /GaFOQ0SYF9zcA1zdcFQuUjFKtYfa/WPvh6o6xtw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtk2wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:58:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606Cu9TE026099;
 Tue, 6 Jan 2026 12:58:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtk2w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:58:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606CqhdJ014667;
 Tue, 6 Jan 2026 12:58:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemucqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 12:58:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606CwPPY62259480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 12:58:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47685805A;
 Tue,  6 Jan 2026 12:58:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C94058056;
 Tue,  6 Jan 2026 12:58:21 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 12:58:20 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------m8JvenzkpxYpCokyFj0tNyyg"
Message-ID: <811fc946-e8fd-494e-a2d5-e436ffef1901@linux.ibm.com>
Date: Tue, 6 Jan 2026 18:28:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: "Yat Sin, David" <David.YatSin@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
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
 <1f2a0b14-9cff-40cd-bdbc-71fae06c34b1@linux.ibm.com>
 <CADnq5_OiCrFn=hPbxfBu5_Oj0pk-fQ1tN6ju2QhbLTY5BCAwEg@mail.gmail.com>
 <DM6PR12MB5021DE8E1ECC352D5B9D92AC95ABA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <DM6PR12MB5021DE8E1ECC352D5B9D92AC95ABA@DM6PR12MB5021.namprd12.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d06f4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=2SrNnTgdAAAA:20 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=Da-2XLwLz_rdedStxkoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UqCG9HQmAAAA:8 a=OoZkBxN8GLp9daxHRx8A:9
 a=Qnjkspp6VYFlz0ir:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: KKmbOd2I0ALHUZ1Srjapb293fgpc9TZ1
X-Proofpoint-ORIG-GUID: Gkto5XxgLGX_u_VSG7q1GhH1J49xp2e0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNiBTYWx0ZWRfX6a7Kvy5WCiR6
 q/GlQ1rGJWIa7CFbbWNe4xZKZX/x6xIEm070uDjXRnU48ONVrr0ynRxq3gq/gZX6JTZzIXZyNbs
 LHrogw8SlM/rgdGN19r2cmRGUEew9RJpF0ZFA/axLP2/enIrp89i8FhR0ovbNef5p9hCWjo+fRT
 ZTke3MH0MylrlyfuY79WQbu3/A9cxloyY3/iiklPK30ywJlYMJfwqSgKphh0ojZJJRr4/ofuuJJ
 IisMyi9fJTkkKe8Gc0M/1fo+NkthrUpVmr2spEvY41RcIjlvf4hRwlLqqQ1gQxE7E63xpwK/Qe7
 OMI/KugxXZ5zUshirsJQG9hZ867nrTn5E3cWlrzRMiZZweb/CX0KOZbkVFcClhM8jIcHA1P0ZZE
 dlq1/yox5BdOfQPipIq0OPRVHuNKKJp7AmesGMipufn9EiCDeanZGl13Cnksxp1ZNf3eSLAAEqr
 MU3YtrUl69lENapn8pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060106
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

This is a multi-part message in MIME format.
--------------m8JvenzkpxYpCokyFj0tNyyg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/18/25 3:01 AM, Yat Sin, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> HDP flush is done in ROCm using these 3 methods:
>
> 1. For AQL packets, this is done by setting the system-scope acquire and release fences in the packet header.
>       For example, it is set here:
>       https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_kernel.cpp#L878
>
>       And when the headers are defined here:
>       https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L85
>
>
> 2. Via a SDMA packet. This is done before doing a memory copy:
>       The function is called here:
>          https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L484
>       And the packet (POLL_REGMEM) is generated here:
>          https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L1154
>
>
> 3. By writing to a MMIO remapped address:
>              The address is stored in rocclr here:
>          https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocdevice.cpp#L607
>
>              And the flush is triggered by writing a 1, e.g here:
>          https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L3831


Hi David, Alex and Christian

Thank you for pointing me to the code where the HDP flush is handled.

 From my understanding of the code, if MMIO remap is supported, the HDP flush is performed via MMIO remap. If MMIO remap is not supported, a workaround is used:
"write all arguments → sfence → write the last byte → mfence → read the last byte"

This sequence ensures that the HDP flush is completed before the GPU reads the data.

With this understanding, I think patch 5/8 (amdkfd/kfd_chardev: Add error message for non-4K page size failures) may not be needed, as it prints an error when MMIO remap is not supported, which is an expected case.

Should we drop patch 5/8, or do you think it would be better to change this to a pr_warn or pr_info message when MMIO remap is not supported?


>
>
> Regards,
> David
>
>
>> -----Original Message-----
>> From: Alex Deucher<alexdeucher@gmail.com>
>> Sent: Wednesday, December 17, 2025 9:23 AM
>> To: Donet Tom<donettom@linux.ibm.com>; Yat Sin, David
>> <David.YatSin@amd.com>
>> Cc: Koenig, Christian<Christian.Koenig@amd.com>; Ritesh Harjani (IBM)
>> <ritesh.list@gmail.com>;amd-gfx@lists.freedesktop.org; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Russell, Kent<Kent.Russell@amd.com>;
>> Vaidyanathan Srinivasan<svaidy@linux.ibm.com>; Mukesh Kumar Chaurasiya
>> <mkchauras@linux.ibm.com>
>> Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
>> size systems
>>
>> On Wed, Dec 17, 2025 at 4:03 AM Donet Tom<donettom@linux.ibm.com> wrote:
>>>
>>> On 12/16/25 7:32 PM, Alex Deucher wrote:
>>>> On Tue, Dec 16, 2025 at 8:55 AM Donet Tom<donettom@linux.ibm.com>
>> wrote:
>>>>> On 12/15/25 7:39 PM, Alex Deucher wrote:
>>>>>> On Mon, Dec 15, 2025 at 4:47 AM Christian König
>>>>>> <christian.koenig@amd.com> wrote:
>>>>>>> On 12/12/25 18:24, Alex Deucher wrote:
>>>>>>>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>>>>>>>> <christian.koenig@amd.com> wrote:
>>>>>>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>>>>>>>> Christian König<christian.koenig@amd.com> writes:
>>>>>>>>>>>> Setup details:
>>>>>>>>>>>> ============
>>>>>>>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>>>>>>>> AMD GPU:
>>>>>>>>>>>>      Name:                    gfx90a
>>>>>>>>>>>>      Marketing Name:          AMD Instinct MI210
>>>>>>>>>>>>
>>>>>>>>>>>> Queries:
>>>>>>>>>>>> =======
>>>>>>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2]
>> to test
>>>>>>>>>>>>       these changes. Is there anything else that you would suggest us
>> to run to
>>>>>>>>>>>>       shake out any other page size related issues w.r.t the kernel
>> driver?
>>>>>>>>>>> The ROCm team needs to answer that.
>>>>>>>>>>>
>>>>>>>>>> Is there any separate mailing list or list of people whom we
>>>>>>>>>> can cc then?
>>>>>>>>> With Felix on CC you already got the right person, but he's on vacation
>> and will not be back before the end of the year.
>>>>>>>>> I can check on Monday if some people are still around which could
>> answer a couple of questions, but in general don't expect a quick response.
>>>>>>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop
>> ring buffer
>>>>>>>>>>>>       size HW dependent? Should it be made PAGE_SIZE?
>>>>>>>>>>> Yes and no.
>>>>>>>>>>>
>>>>>>>>>> If you could more elaborate on this please? I am assuming you
>>>>>>>>>> would anyway respond with more context / details on Patch-1
>>>>>>>>>> itself. If yes, that would be great!
>>>>>>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of
>> all the events and actions the CP should execute when shaders and cache flushes
>> finish.
>>>>>>>>> The size depends on the HW generation and configuration of the GPU
>> etc..., but don't ask me for details how that is calculated.
>>>>>>>>> The point is that the size is completely unrelated to the CPU, so using
>> PAGE_SIZE is clearly incorrect.
>>>>>>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system
>> page size > 4K.
>>>>>>>>>>>>       Do we need to lift this restriction and add MMIO remap support
>> for systems with
>>>>>>>>>>>>       non-4K page sizes?
>>>>>>>>>>> The problem is the HW can't do this.
>>>>>>>>>>>
>>>>>>>>>> We aren't that familiar with the HW / SW stack here. Wanted to
>>>>>>>>>> understand what functionality will be unsupported due to this HW
>> limitation then?
>>>>>>>>> The problem is that the CPU must map some of the registers/resources
>> of the GPU into the address space of the application and you run into security
>> issues when you map more than 4k at a time.
>>>>>>>> Right.  There are some 4K pages with the MMIO register BAR which
>>>>>>>> are empty and registers can be remapped into them.  In this case
>>>>>>>> we remap the HDP flush registers into one of those register
>>>>>>>> pages.  This allows applications to flush the HDP write FIFO
>>>>>>>> from either the CPU or another device.  This is needed to flush
>>>>>>>> data written by the CPU or another device to the VRAM BAR out to
>>>>>>>> VRAM (i.e., so the GPU can see it).  This is flushed internally
>>>>>>>> as part of the shader dispatch packets,
>>>>>>> As far as I know this is only done for graphics shader submissions to the
>> classic CS interface, but not for compute dispatches through ROCm queues.
>>>>>> There is an explicit PM4 packet to flush the HDP cache for userqs
>>>>>> and for AQL the flush is handled via one of the flags in the
>>>>>> dispatch packet.  The MMIO remap is needed for more fine grained
>>>>>> use cases where you might have the CPU or another device operating
>>>>>> in a gang like scenario with the GPU.
>>>>> Thank you, Alex.
>>>>>
>>>>> We were encountering an issue while running the RCCL unit tests.
>>>>> With 2 GPUs, all tests passed successfully; however, when running
>>>>> with more than 2 GPUs, the tests began to fail at random points
>>>>> with the following
>>>>> errors:
>>>>>
>>>>> [  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed
>>>>> for queue with doorbell_id: 80030008 [  606.696820] amdgpu
>>>>> 0048:0f:00.0: amdgpu: Failed to evict process queues [  606.696826]
>>>>> amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4 [
>>>>> 610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed
>>>>> for queue with doorbell_id: 80030008 [  610.696869] amdgpu
>>>>> 0048:0f:00.0: amdgpu: Failed to evict process queues [  610.696942]
>>>>> amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues
>>>>>
>>>>>
>>>>> After applying patches 7/8 and 8/8, we are no longer seeing this issue.
>>>>>
>>>>> One question I have is: we only started observing this problem when
>>>>> the number of GPUs increased. Could this be related to MMIO
>>>>> remapping not being available?
>>>> It could be.  E.g., if the CPU or a GPU writes data to VRAM on
>>>> another GPU, you will need to flush the HDP to make sure that data
>>>> hits VRAM before the GPU attached to the VRAM can see it.
>>>
>>> Thanks Alex
>>>
>>> I am now suspecting that the queue preemption issue may be related to
>>> the unavailability of MMIO remapping. I am not very familiar with this area.
>>>
>>> Could you please point me to the relevant code path where the PM4
>>> packet is issued to flush the HDP cache?
>> + David who is more familiar with the ROCm runtime.
>>
>> PM4 has a packet called HDP_FLUSH which flushes the HDP.  For AQL, it's
>> handled by one of the flags I think.  Most things in ROCm use AQL.
>>
>> @David Yat Sin Can you point to how HDP flushes are handled in the ROCm
>> runtime?
>>
>> Alex
>>
>>> I am consistently able to reproduce this issue on my system when using
>>> more than three GPUs if patches 7/8 and 8/8 are not applied. In your
>>> opinion, is there anything that can be done to speed up the HDP flush
>>> or to avoid this situation altogether?
>>>
>>>
>>>
>>>> Alex
>>>>
>>>>>> Alex
>>>>>>
>>>>>>> That's the reason why ROCm needs the remapped MMIO register BAR.
>>>>>>>
>>>>>>>> but there are certain cases where an application may want more
>>>>>>>> control.  This is probably not a showstopper for most ROCm apps.
>>>>>>> Well the problem is that you absolutely need the HDP flush/invalidation for
>> 100% correctness. It does work most of the time without it, but you then risk data
>> corruption.
>>>>>>> Apart from making the flush/invalidate an IOCTL I think we could also just
>> use a global dummy page in VRAM.
>>>>>>> If you make two 32bit writes which are apart from each other and then a
>> read back a 32bit value from VRAM that should invalidate the HDP as well. It's less
>> efficient than the MMIO BAR remap but still much better than going though an
>> IOCTL.
>>>>>>> The only tricky part is that you need to get the HW barriers with the doorbell
>> write right.....
>>>>>>>> That said, the region is only 4K so if you allow applications to
>>>>>>>> map a larger region they would get access to GPU register pages
>>>>>>>> which they shouldn't have access to.
>>>>>>> But don't we also have problems with the doorbell? E.g. the global
>> aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>>>>>> Thinking more about it there is also a major problem with page tables.
>> Those are 4k by default on modern systems as well and while over allocating them
>> to 64k is possible that not only wastes some VRAM but can also result in OOM
>> situations because we can't allocate the necessary page tables to switch from 2MiB
>> to 4k pages in some cases.
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>>>>> [1] ROCr debug agent tests:
>>>>>>>>>>>> https://github.com/ROCm/rocr_debug_agent
>>>>>>>>>>>> [2] RCCL tests:
>>>>>>>>>>>> https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Please note that the changes in this series are on a best
>>>>>>>>>>>> effort basis from our end. Therefore, requesting the amd-gfx
>>>>>>>>>>>> community (who have deeper knowledge of the HW & SW stack)
>>>>>>>>>>>> to kindly help with the review and provide feedback /
>>>>>>>>>>>> comments on these patches. The idea here is, to also have non-4K
>> pagesize (e.g. 64K) well supported with amd gpu kernel driver.
>>>>>>>>>>> Well this is generally nice to have, but there are unfortunately some
>> HW limitations which makes ROCm pretty much unusable on non 4k page size
>> systems.
>>>>>>>>>> That's a bummer :(
>>>>>>>>>> - Do we have some HW documentation around what are these
>> limitations around non-4K pagesize? Any links to such please?
>>>>>>>>> You already mentioned MMIO remap which obviously has that problem,
>> but if I'm not completely mistaken the PCIe doorbell BAR and some global seq
>> counter resources will also cause problems here.
>>>>>>>>> This can all be worked around by delegating those MMIO accesses into
>> the kernel, but that means tons of extra IOCTL overhead.
>>>>>>>>> Especially the cache flushes which are necessary to avoid corruption
>> are really bad for performance in such an approach.
>>>>>>>>>> - Are there any latest AMD GPU versions which maybe lifts such
>> restrictions?
>>>>>>>>> Not that I know off any.
>>>>>>>>>
>>>>>>>>>>> What we can do is to support graphics and MM, but that should
>> already work out of the box.
>>>>>>>>>> - Maybe we should also document, what will work and what won't work
>> due to these HW limitations.
>>>>>>>>> Well pretty much everything, I need to double check how ROCm does
>> HDP flushing/invalidating when the MMIO remap isn't available.
>>>>>>>>> Could be that there is already a fallback path and that's the reason why
>> this approach actually works at all.
>>>>>>>>>>> What we can do is to support graphics and MM, but that should
>>>>>>>>>>> already work out of the box.>
>>>>>>>>>> So these patches helped us resolve most of the issues like
>>>>>>>>>> SDMA hangs and GPU kernel page faults which we saw with rocr
>>>>>>>>>> and rccl tests with 64K pagesize. Meaning, we didn't see this
>>>>>>>>>> working out of box perhaps due to 64K pagesize.
>>>>>>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>>>>>>
>>>>>>>>> To be honest I'm not sure how ROCm even works when you have 64k
>> pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>>>>>>> AFAIU, some of these patches may require re-work based on
>>>>>>>>>> reviews, but at least with these changes, we were able to see all the
>> tests passing.
>>>>>>>>>>> I need to talk with Alex and the ROCm team about it if workarounds
>> can be implemented for those issues.
>>>>>>>>>> Thanks a lot! That would be super helpful!
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Christian.
>>>>>>>>>>>
>>>>>>>>>> Thanks again for the quick response on the patch series.
>>>>>>>>> You are welcome, but since it's so near to the end of the year not all
>> people are available any more.
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> -ritesh
--------------m8JvenzkpxYpCokyFj0tNyyg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/18/25 3:01 AM, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM6PR12MB5021DE8E1ECC352D5B9D92AC95ABA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

HDP flush is done in ROCm using these 3 methods:

1. For AQL packets, this is done by setting the system-scope acquire and release fences in the packet header.
     For example, it is set here:
     <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_kernel.cpp#L878">https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_kernel.cpp#L878</a>

     And when the headers are defined here:
     <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L85">https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L85</a>


2. Via a SDMA packet. This is done before doing a memory copy:
     The function is called here:
        <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L484">https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L484</a>
     And the packet (POLL_REGMEM) is generated here:
        <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L1154">https://github.com/ROCm/rocm-systems/blob/develop/projects/rocr-runtime/runtime/hsa-runtime/core/runtime/amd_blit_sdma.cpp#L1154</a>


3. By writing to a MMIO remapped address:
            The address is stored in rocclr here:
        <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocdevice.cpp#L607">https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocdevice.cpp#L607</a>

            And the flush is triggered by writing a 1, e.g here:
        <a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L3831">https://github.com/ROCm/rocm-systems/blob/develop/projects/clr/rocclr/device/rocm/rocvirtual.cpp#L3831</a></pre>
    </blockquote>
    <p><br>
    </p>
    <pre>Hi David, Alex and Christian

Thank you for pointing me to the code where the HDP flush is handled.

From my understanding of the code, if MMIO remap is supported, the HDP flush is performed via MMIO remap. If MMIO remap is not supported, a workaround is used:
"write all arguments → sfence → write the last byte → mfence → read the last byte"

This sequence ensures that the HDP flush is completed before the GPU reads the data.

With this understanding, I think patch 5/8 (amdkfd/kfd_chardev: Add error message for non-4K page size failures) may not be needed, as it prints an error when MMIO remap is not supported, which is an expected case.

Should we drop patch 5/8, or do you think it would be better to change this to a pr_warn or pr_info message when MMIO remap is not supported?</pre>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:DM6PR12MB5021DE8E1ECC352D5B9D92AC95ABA@DM6PR12MB5021.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">


Regards,
David


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>
Sent: Wednesday, December 17, 2025 9:23 AM
To: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>; Yat Sin, David
<a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>
Cc: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Ritesh Harjani (IBM)
<a class="moz-txt-link-rfc2396E" href="mailto:ritesh.list@gmail.com">&lt;ritesh.list@gmail.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>;
Vaidyanathan Srinivasan <a class="moz-txt-link-rfc2396E" href="mailto:svaidy@linux.ibm.com">&lt;svaidy@linux.ibm.com&gt;</a>; Mukesh Kumar Chaurasiya
<a class="moz-txt-link-rfc2396E" href="mailto:mkchauras@linux.ibm.com">&lt;mkchauras@linux.ibm.com&gt;</a>
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
size systems

On Wed, Dec 17, 2025 at 4:03 AM Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">

On 12/16/25 7:32 PM, Alex Deucher wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On Tue, Dec 16, 2025 at 8:55 AM Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
</pre>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">wrote:
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">
On 12/15/25 7:39 PM, Alex Deucher wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">On Mon, Dec 15, 2025 at 4:47 AM Christian König
<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">On 12/12/25 18:24, Alex Deucher wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">On Fri, Dec 12, 2025 at 8:19 AM Christian König
<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
</pre>
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> writes:
</pre>
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
    Name:                    gfx90a
    Marketing Name:          AMD Instinct MI210

Queries:
=======
1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2]
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">to test
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">     these changes. Is there anything else that you would suggest us
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">to run to
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">     shake out any other page size related issues w.r.t the kernel
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">driver?
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">The ROCm team needs to answer that.

</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">Is there any separate mailing list or list of people whom we
can cc then?
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">With Felix on CC you already got the right person, but he's on vacation
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">and will not be back before the end of the year.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
I can check on Monday if some people are still around which could
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">answer a couple of questions, but in general don't expect a quick response.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">2. Patch 1/8: We have a querry regarding eop buffer size Is this eop
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">ring buffer
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">     size HW dependent? Should it be made PAGE_SIZE?
</pre>
                          </blockquote>
                          <pre wrap="" class="moz-quote-pre">Yes and no.

</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">If you could more elaborate on this please? I am assuming you
would anyway respond with more context / details on Patch-1
itself. If yes, that would be great!
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">all the events and actions the CP should execute when shaders and cache flushes
finish.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
The size depends on the HW generation and configuration of the GPU
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">etc..., but don't ask me for details how that is calculated.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
The point is that the size is completely unrelated to the CPU, so using
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">PAGE_SIZE is clearly incorrect.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">3. Patch 5/8: also have a query w.r.t the error paths when system
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">page size &gt; 4K.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">     Do we need to lift this restriction and add MMIO remap support
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">for systems with
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">     non-4K page sizes?
</pre>
                          </blockquote>
                          <pre wrap="" class="moz-quote-pre">The problem is the HW can't do this.

</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">We aren't that familiar with the HW / SW stack here. Wanted to
understand what functionality will be unsupported due to this HW
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">limitation then?
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">The problem is that the CPU must map some of the registers/resources
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">of the GPU into the address space of the application and you run into security
issues when you map more than 4k at a time.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">Right.  There are some 4K pages with the MMIO register BAR which
are empty and registers can be remapped into them.  In this case
we remap the HDP flush registers into one of those register
pages.  This allows applications to flush the HDP write FIFO
from either the CPU or another device.  This is needed to flush
data written by the CPU or another device to the VRAM BAR out to
VRAM (i.e., so the GPU can see it).  This is flushed internally
as part of the shader dispatch packets,
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">As far as I know this is only done for graphics shader submissions to the
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">classic CS interface, but not for compute dispatches through ROCm queues.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">There is an explicit PM4 packet to flush the HDP cache for userqs
and for AQL the flush is handled via one of the flags in the
dispatch packet.  The MMIO remap is needed for more fine grained
use cases where you might have the CPU or another device operating
in a gang like scenario with the GPU.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">
Thank you, Alex.

We were encountering an issue while running the RCCL unit tests.
With 2 GPUs, all tests passed successfully; however, when running
with more than 2 GPUs, the tests began to fail at random points
with the following
errors:

[  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed
for queue with doorbell_id: 80030008 [  606.696820] amdgpu
0048:0f:00.0: amdgpu: Failed to evict process queues [  606.696826]
amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4 [
610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed
for queue with doorbell_id: 80030008 [  610.696869] amdgpu
0048:0f:00.0: amdgpu: Failed to evict process queues [  610.696942]
amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues


After applying patches 7/8 and 8/8, we are no longer seeing this issue.

One question I have is: we only started observing this problem when
the number of GPUs increased. Could this be related to MMIO
remapping not being available?
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">It could be.  E.g., if the CPU or a GPU writes data to VRAM on
another GPU, you will need to flush the HDP to make sure that data
hits VRAM before the GPU attached to the VRAM can see it.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">

Thanks Alex

I am now suspecting that the queue preemption issue may be related to
the unavailability of MMIO remapping. I am not very familiar with this area.

Could you please point me to the relevant code path where the PM4
packet is issued to flush the HDP cache?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
+ David who is more familiar with the ROCm runtime.

PM4 has a packet called HDP_FLUSH which flushes the HDP.  For AQL, it's
handled by one of the flags I think.  Most things in ROCm use AQL.

@David Yat Sin Can you point to how HDP flushes are handled in the ROCm
runtime?

Alex

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
I am consistently able to reproduce this issue on my system when using
more than three GPUs if patches 7/8 and 8/8 are not applied. In your
opinion, is there anything that can be done to speed up the HDP flush
or to avoid this situation altogether?



</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">
Alex

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">Alex

</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">That's the reason why ROCm needs the remapped MMIO register BAR.

</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">but there are certain cases where an application may want more
control.  This is probably not a showstopper for most ROCm apps.
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">Well the problem is that you absolutely need the HDP flush/invalidation for
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">100% correctness. It does work most of the time without it, but you then risk data
corruption.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
Apart from making the flush/invalidate an IOCTL I think we could also just
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">use a global dummy page in VRAM.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
If you make two 32bit writes which are apart from each other and then a
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">read back a 32bit value from VRAM that should invalidate the HDP as well. It's less
efficient than the MMIO BAR remap but still much better than going though an
IOCTL.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
The only tricky part is that you need to get the HW barriers with the doorbell
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">write right.....
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">That said, the region is only 4K so if you allow applications to
map a larger region they would get access to GPU register pages
which they shouldn't have access to.
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">But don't we also have problems with the doorbell? E.g. the global
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">aggregated one needs to be 4k as well, or is it ok to over allocate there?
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
Thinking more about it there is also a major problem with page tables.
</pre>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Those are 4k by default on modern systems as well and while over allocating them
to 64k is possible that not only wastes some VRAM but can also result in OOM
situations because we can't allocate the necessary page tables to switch from 2MiB
to 4k pages in some cases.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">
Christian.

</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">Alex

</pre>
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">[1] ROCr debug agent tests:
<a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocr_debug_agent">https://github.com/ROCm/rocr_debug_agent</a>
[2] RCCL tests:
<a class="moz-txt-link-freetext" href="https://github.com/ROCm/rccl/tree/develop/test">https://github.com/ROCm/rccl/tree/develop/test</a>


Please note that the changes in this series are on a best
effort basis from our end. Therefore, requesting the amd-gfx
community (who have deeper knowledge of the HW &amp; SW stack)
to kindly help with the review and provide feedback /
comments on these patches. The idea here is, to also have non-4K
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">pagesize (e.g. 64K) well supported with amd gpu kernel driver.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">Well this is generally nice to have, but there are unfortunately some
</pre>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">HW limitations which makes ROCm pretty much unusable on non 4k page size
systems.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">That's a bummer :(
- Do we have some HW documentation around what are these
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">limitations around non-4K pagesize? Any links to such please?
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">You already mentioned MMIO remap which obviously has that problem,
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">but if I'm not completely mistaken the PCIe doorbell BAR and some global seq
counter resources will also cause problems here.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
This can all be worked around by delegating those MMIO accesses into
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">the kernel, but that means tons of extra IOCTL overhead.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
Especially the cache flushes which are necessary to avoid corruption
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">are really bad for performance in such an approach.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">- Are there any latest AMD GPU versions which maybe lifts such
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">restrictions?
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">Not that I know off any.

</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">What we can do is to support graphics and MM, but that should
</pre>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">already work out of the box.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">
</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">- Maybe we should also document, what will work and what won't work
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">due to these HW limitations.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">Well pretty much everything, I need to double check how ROCm does
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">HDP flushing/invalidating when the MMIO remap isn't available.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
Could be that there is already a fallback path and that's the reason why
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">this approach actually works at all.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">What we can do is to support graphics and MM, but that should
already work out of the box.&gt;
</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">So these patches helped us resolve most of the issues like
SDMA hangs and GPU kernel page faults which we saw with rocr
and rccl tests with 64K pagesize. Meaning, we didn't see this
working out of box perhaps due to 64K pagesize.
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">Yeah, but this is all for ROCm and not the graphics side.

To be honest I'm not sure how ROCm even works when you have 64k
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">pages at the moment. I would expect much more issue lurking in the kernel driver.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">AFAIU, some of these patches may require re-work based on
reviews, but at least with these changes, we were able to see all the
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">tests passing.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">
</pre>
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">I need to talk with Alex and the ROCm team about it if workarounds
</pre>
                        </blockquote>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">can be implemented for those issues.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">
</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">Thanks a lot! That would be super helpful!


</pre>
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">Thanks again for the quick response on the patch series.
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">You are welcome, but since it's so near to the end of the year not all
</pre>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">people are available any more.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">
Regards,
Christian.

</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">-ritesh
</pre>
                      </blockquote>
                    </blockquote>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------m8JvenzkpxYpCokyFj0tNyyg--

