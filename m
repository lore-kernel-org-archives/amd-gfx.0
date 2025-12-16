Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAAED5E156
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 13:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDDC10E2D0;
	Tue, 16 Dec 2025 13:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="cHDkr1f/";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC74910E2D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 13:55:08 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG1JEEV019693;
 Tue, 16 Dec 2025 13:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KKZ+RJ
 0Q0sNcvzXKMu8Osx4RXIus9qrP8TqxO/DSF4E=; b=cHDkr1f/SSnyQ+Pdxi6dnR
 3SHTd9gAkzk4fTIh9+U4zsH2l2y0Sm6xFELO7/voIfqCWgtFP3RTORDfrNpjDexs
 +Eqh8pQXq+hkgt0apUAmQuoFYOiL0oOk04rYXiIkfw6G1L/we0k9A44WJPLdYS0N
 Zpt8ZvzfVpMpC8IvWpSek8eCoeVAdVQhiE/Tg1gpcWXFvo+P877XLrd03FS+CeZC
 yifTsD19nQvlpkTdeRwMT3f2NQvlkMaShtJWZItPvlasI1aS8v1ehm1iVKXxjIQn
 xzD+MXjgAqM+LrtFnsawUmQbh8kYv7kOS8/JyapiY9KRKR8ADTrVO2t1Svqxc2lw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1enk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:55:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGDe0fa012715;
 Tue, 16 Dec 2025 13:55:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1enk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:55:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGAbJPg003028;
 Tue, 16 Dec 2025 13:55:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kykm7rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 13:55:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGDt2re33358342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 13:55:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B063C5803F;
 Tue, 16 Dec 2025 13:55:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B5E458056;
 Tue, 16 Dec 2025 13:54:59 +0000 (GMT)
Received: from [9.124.210.169] (unknown [9.124.210.169])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 13:54:59 +0000 (GMT)
Message-ID: <bed34fa1-5971-416a-a3d4-7824d0387e02@linux.ibm.com>
Date: Tue, 16 Dec 2025 19:24:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9n5TWpEFywq71mdBf3__3rhbi1RinGhj
X-Proofpoint-ORIG-GUID: 6wkH2ASOrAL0das5UcfTG3zNNZhs82r3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX5/56jdyHoXMw
 qRgz9MSlJ2aUm9/2wQ3Zakhj2TQTRU9mxLftD1RDIZa30urjhBWOEt7R5lCBoJpsxHgK+MOkMvW
 h3xJrKozdNuvqAove8DO3CgRf80J0btfT7DjmK2HS18SwkbY4S9i3Yl3+0QVIRVUoXoCWhI5gLo
 TgL7D7cWdLAq7Tp36+Z7IkFbnWF8mD4iYlpwnlfYYMutyP3EmdEbuLKQ4eYb/jouVfne5mM6Yw+
 DNGeaeZv3njUKx3GlDJDEGy3w0JbHJARdYsW4AJ3KWLNWID6Sh4CKq/HXGL1ES1XVWBWBlPW//R
 eC8y4G344TWcVRUjI2FgP0zP6bSWCYCGUy7YVXT0m+gijYzonswNP4OZIBA/c8IzR56cGQHpUlu
 dEWDP6RvEQael0CrwJ7jqegHKdcHRg==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=694164b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=zd2uoN0lAAAA:8 a=PliKiKpVoH0uRaRyEN0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
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


On 12/15/25 7:39 PM, Alex Deucher wrote:
> On Mon, Dec 15, 2025 at 4:47 AM Christian König
> <christian.koenig@amd.com> wrote:
>> On 12/12/25 18:24, Alex Deucher wrote:
>>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>>> Christian König <christian.koenig@amd.com> writes:
>>>>>>> Setup details:
>>>>>>> ============
>>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>>> AMD GPU:
>>>>>>>    Name:                    gfx90a
>>>>>>>    Marketing Name:          AMD Instinct MI210
>>>>>>>
>>>>>>> Queries:
>>>>>>> =======
>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>>>     these changes. Is there anything else that you would suggest us to run to
>>>>>>>     shake out any other page size related issues w.r.t the kernel driver?
>>>>>> The ROCm team needs to answer that.
>>>>>>
>>>>> Is there any separate mailing list or list of people whom we can cc
>>>>> then?
>>>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>>>
>>>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>>>
>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>>>     size HW dependent? Should it be made PAGE_SIZE?
>>>>>> Yes and no.
>>>>>>
>>>>> If you could more elaborate on this please? I am assuming you would
>>>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>>>> that would be great!
>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>>>
>>>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>>>
>>>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>>>
>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>>>     Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>>>     non-4K page sizes?
>>>>>> The problem is the HW can't do this.
>>>>>>
>>>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>>>> what functionality will be unsupported due to this HW limitation then?
>>>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
>>> Right.  There are some 4K pages with the MMIO register BAR which are
>>> empty and registers can be remapped into them.  In this case we remap
>>> the HDP flush registers into one of those register pages.  This allows
>>> applications to flush the HDP write FIFO from either the CPU or
>>> another device.  This is needed to flush data written by the CPU or
>>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
>>> it).  This is flushed internally as part of the shader dispatch
>>> packets,
>> As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.
> There is an explicit PM4 packet to flush the HDP cache for userqs and
> for AQL the flush is handled via one of the flags in the dispatch
> packet.  The MMIO remap is needed for more fine grained use cases
> where you might have the CPU or another device operating in a gang
> like scenario with the GPU.


Thank you, Alex.

We were encountering an issue while running the RCCL unit tests. With 2 
GPUs, all tests passed successfully; however, when running with more 
than 2 GPUs, the tests began to fail at random points with the following 
errors:

[  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for 
queue with doorbell_id: 80030008
[  606.696820] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
[  606.696826] amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
[  610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for 
queue with doorbell_id: 80030008
[  610.696869] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
[  610.696942] amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues


After applying patches 7/8 and 8/8, we are no longer seeing this issue.

One question I have is: we only started observing this problem when the 
number of GPUs increased. Could this be related to MMIO remapping not 
being available?


> Alex
>
>> That's the reason why ROCm needs the remapped MMIO register BAR.
>>
>>> but there are certain cases where an application may want
>>> more control.  This is probably not a showstopper for most ROCm apps.
>> Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.
>>
>> Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.
>>
>> If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.
>>
>> The only tricky part is that you need to get the HW barriers with the doorbell write right.....
>>
>>> That said, the region is only 4K so if you allow applications to map a
>>> larger region they would get access to GPU register pages which they
>>> shouldn't have access to.
>> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>
>> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.
>>
>> Christian.
>>
>>> Alex
>>>
>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>
>>>>>>>
>>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>>> supported with amd gpu kernel driver.
>>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>>> That's a bummer :(
>>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>>
>>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>>
>>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>>
>>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>>> Not that I know off any.
>>>>
>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>>
>>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>>
>>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>>
>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>>> due to 64K pagesize.
>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>
>>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>
>>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>>> at least with these changes, we were able to see all the tests passing.
>>>>>
>>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>>
>>>>> Thanks a lot! That would be super helpful!
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>> Thanks again for the quick response on the patch series.
>>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> -ritesh
