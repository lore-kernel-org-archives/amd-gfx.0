Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062D9C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 17:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8008110E235;
	Wed,  5 Aug 2026 17:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="HLNTccUy";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9088C10E235
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 17:12:49 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675Fm6Qj059205; Wed, 5 Aug 2026 17:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qdCBI7
 yFVClcT9+SpmOko2ASuuVq7hOvq5FRIJnRsMg=; b=HLNTccUy8ZJ5+Y3nHxDSvX
 /bBLrPLRlkiihHDf7CMnVO7SdgKbCN0ToAbQcVhu3vdKeStiKFco3fscSsJST5by
 iXklvT9qRFsRY1zrCL58Pr7WjV8cbJteypxdSaWILXD7OMvaYul+S2digWMOejDV
 t37harQbbiN2zDzwS6CfaVOM7Blq8abVDAQy/KPHXBSaWnLgiExMbBKZZd2SKmbC
 oKD74S1GXjN8ePNpivJQb5n5WL83Yuze1D88hrifxBnx4H1e1cx0Iqmy5Nqy7SnO
 Ygik4iPjY2Ful2ai+aWC+dL+LjQGrZ/GNvLJti/sCt8xWKNlqSeljjIRAYELCFVw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a446n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 17:12:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675HBGMH020435;
 Wed, 5 Aug 2026 17:12:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyq99q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 17:12:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675HCiEu33292804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 17:12:44 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82D3F58059;
 Wed,  5 Aug 2026 17:12:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD74D58058;
 Wed,  5 Aug 2026 17:12:39 +0000 (GMT)
Received: from [9.39.27.13] (unknown [9.39.27.13])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 17:12:39 +0000 (GMT)
Message-ID: <bf960896-88b0-4c61-92e7-9e2dbcc09123@linux.ibm.com>
Date: Wed, 5 Aug 2026 22:42:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
To: "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <cover.1785833981.git.donettom@linux.ibm.com>
 <16887553-76eb-4af9-8769-f77f4fb9fb68@amd.com>
 <b492ee69-86fa-47a2-aecc-e470568d7204@linux.ibm.com>
 <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a736f0e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=daJAG3_is4Lc0EEiQxwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _lhuUDYQgG1SYfX_hhdUcEPeIQgspxA9
X-Proofpoint-GUID: mqQyGbI-YGfxyewbpIE3LMvNgQjYQ0S9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX6XT84Hzu8IH/
 1rrlFZgwYz8Iv96WccibpYVWY85nyoeiW5s5QQUZzlf2ePT0D3rNQdW/aCRjdmdVxP+UyqTTv0l
 91ZFzF572q+R+VIZwLFWJ7x3ls9m2y8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX2uKvD5Rspg1E
 zooFvfLqhG1/jmmnKcCBM6uCiYaPo7p+Bz2ATUz5qVUn6RCilIOkrBMDqf3J3PpZmgvmtsTNP6V
 784GX5KkA/Gzj6v9a8Y/Qb37v4FKXvEGL9FSN2FN4cLdV7aCElZn8VKK650xIAXLpMGwd5iccmw
 Oq6dL7HbgOQzMajAhfHyhIm/qVKCfH0Itc2BG16zv3pcKoXlBYsDk4ocDOApoU9zuEf5+vswora
 YoZl6sXBi5VtvfcCrjGNml77b2WcNR+pFbTmgorjwEcYQ8xRRyX3fh9DS68DbsEu4SF5X7G1WO+
 OjXa+kCb7cGf7Ustk5KBKI5SXlUpfeQIbqJP3+Llb6Yn78PeZLR9Qg114iSYZAfuGPEthbsqYjR
 yJKltb7cB3YU+Srv6DoWNyuoIkcqJLgEaEfKFpynj/KFI0Z694qIy4RfNKsIVybQ/vU5Kj6bneV
 Uckve1CO6bXfYkBki3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050137
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


On 8/5/26 9:46 PM, Kuehling, Felix wrote:
>
> On 2026-08-05 03:09, Donet Tom wrote:
>>
>> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>>
>>> On 2026-08-04 05:52, Donet Tom wrote:
>>>> This series fixes topology device creation and proximity domain 
>>>> mappings in
>>>> AMDKFD when a system does not provide a CRAT table and the driver 
>>>> generates a
>>>> Virtual CRAT (VCRAT).
>>>>
>>>> The current implementation assumes that CPU NUMA node IDs are 
>>>> contiguous and
>>>> that every NUMA node contains CPUs. During VCRAT generation, CPU 
>>>> topology
>>>> entries and proximity domains are created only for NUMA nodes that 
>>>> have CPUs.
>>>> GPU proximity domains are then allocated immediately after the CPU 
>>>> proximity
>>>> domains, and the GPU I/O link (proximity_domain_to) is initialized 
>>>> using the
>>>> NUMA node ID to which the GPU is attached, implicitly assuming that 
>>>> NUMA node
>>>> IDs and proximity domains have a one-to-one mapping.
>>>>
>>>> These assumptions break on systems with:
>>>>
>>>> Sparse (non-contiguous) NUMA node IDs
>>>> CPU-less NUMA nodes
>>>> CPU-less and memory-less NUMA nodes
>>>>
>>>> For example:
>>>>
>>>> available: 3 nodes (0,2-3)
>>>>
>>>> node 0: CPUs present
>>>> node 2: CPU-less
>>>> node 3: CPU-less
>>>>
>>>> In this case, the driver creates a CPU topology device only for 
>>>> node 0 and
>>>> assigns a single CPU proximity domain (0). However, the GPU VCRAT 
>>>> still
>>>> references the NUMA node ID to which the GPU is attached (for 
>>>> example, node 3)
>>>> in the proximity_domain_to field. Since no corresponding CPU 
>>>> proximity domain
>>>> exists for node 3, the parser cannot find a matching proximity 
>>>> domain during
>>>> VCRAT parsing, causing topology initialization to fail.
>>>
>>> Hi Tom, 
>>
>>
>> Hi Felix,
>>
>>
>>>
>>> Thank you for the explanation and the patch series. I may have some 
>>> gaps in my understanding that I would like to clarify. In my mind, I 
>>> was using "proximity domain" and "NUMA node" interchangeably. You're 
>>> demonstrating that they are not the same thing. Is that just a 
>>> different way of labeling the same thing, or are NUMA nodes and 
>>> proximity domains fundamentally different concepts.
>>>
>>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and 
>>> kfd_numa_node_to_proximity_domain) seems to imply that there is, in 
>>> fact, a 1:1 mapping, as it assumes that there is a unique 
>>> translation in both directions. Am I missing something?
>>
>>
>>
>> Thanks for the comment.
>>
>> IIUC, NUMA node IDs and proximity domains are different numbering 
>> schemes. We have proximity domains for both CPU and GPU devices. CPU 
>> proximity domains start from 0, and GPU proximity domains start after 
>> the last CPU proximity domain.
>>
>> If the NUMA node IDs are contiguous, the CPU proximity domains happen 
>> to match the NUMA node IDs. However, if the NUMA node IDs are 
>> discontiguous, the CPU proximity domains and NUMA node IDs no longer 
>> have a one-to-one mapping.
>>
>>>
>>> If they are just different numbering systems, do we really need to 
>>> keep track of both proximity domains and NUMA nodes in the KFD 
>>> topology? Or would it be sufficient to only track NUMA nodes, if 
>>> that's what we really care about in the uAPI (KFD sysfs)?
>>
>>
>>
>> Thanks for the suggestion. I also think we don't need to keep track 
>> of both the proximity domains and the NUMA node IDs in KFD. Do you 
>> think the approach below would be reasonable?
>>
>> Just to make sure I understand correctly, for CPU devices the 
>> proximity domain will be the same as the NUMA node ID, and the GPU 
>> proximity domains will start after the last CPU proximity domain.
>>
>> In that case, the CPU proximity domains and NUMA node IDs will always 
>> have a one-to-one mapping, and the GPU proximity domains will follow 
>> after them.
>>
>> For example, if a system has three NUMA nodes and two GPUs:
>>
>> NUMA node IDs:            0   2   3
>> CPU proximity domains:    0   2   3
>> GPU proximity domains:    4   5
>>
>> Would it be okay to proceed with this approach?
>
> Yes, this looks good to me.


Thanks, Felix. I'll implement this approach and post a new version.

Thanks,
Donet Tom


>
> Regards,
>   Felix
>
>
>>
>> I think this approach should also resolve the driver loading issue.
>>
>>
>> Thanks
>> Donet Tom
>>
>>
>>>
>>> Thanks,
>>>   Felix
>>>
>>>
>>>>
>>>> The failure is observed as:
>>>>
>>>> amdgpu: Virtual CRAT table created for GPU
>>>> amdgpu: Error parsing VCRAT
>>>> kfd: amdgpu: Error adding device to topology
>>>> kfd: amdgpu: Error initializing KFD node
>>>>
>>>>
>>>> Since every online NUMA node is a valid topology object and can 
>>>> contain
>>>> CPUs, memory, I/O links, or any combination of these, topology devices
>>>> and proximity domains should be created for every online NUMA node
>>>> rather than only for NUMA nodes that contain CPUs.
>>>>
>>>> To address this, this series introduces a new VCRAT subtype that
>>>> records the mapping between the NUMA node ID and the generated VCRAT
>>>> proximity domain. When topology devices are created, this information
>>>> is stored in the corresponding topology device, allowing the driver to
>>>> translate a NUMA node ID into its associated proximity domain whenever
>>>> required.
>>>>
>>>> Returning to the previous example, the system contains three online
>>>> NUMA nodes, so three CPU topology devices and three proximity domains
>>>> are created, even though only one NUMA node contains CPUs. The NUMA
>>>> node ID is stored in each topology device together with its generated
>>>> proximity domain.
>>>>
>>>> Later, when the GPU VCRAT is generated, the driver only knows the NUMA
>>>> node ID to which the GPU is attached (for example, node 3). Instead of
>>>> assuming that the NUMA node ID is equal to the proximity domain, the
>>>> driver walks the existing topology devices to locate the corresponding
>>>> NUMA node and retrieves its generated proximity domain. In this
>>>> example, NUMA node 3 maps to proximity domain 2, so
>>>> proximity_domain_to is populated with the correct value.
>>>>
>>>> Since the GPU I/O link now references a valid proximity domain, VCRAT
>>>> parsing completes successfully and topology initialization proceeds
>>>> without errors on systems with sparse NUMA node IDs, CPU-less NUMA
>>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>>
>>>> This series consists of the following patches:
>>>>
>>>> Patch 1 removes an unused argument from
>>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>>
>>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that stores the
>>>> NUMA node ID and its corresponding proximity domain.
>>>>
>>>> Patch 3 populates the NUMA affinity entries during VCRAT generation
>>>> for every online NUMA node.
>>>>
>>>> Patch 4 parses the NUMA affinity entries from the VCRAT and stores the
>>>> NUMA node ID and proximity domain in the corresponding topology
>>>> device.
>>>>
>>>> Patch 5 fixes GPU VCRAT proximity domain mappings by translating the
>>>> GPU's NUMA node ID to the corresponding CPU proximity domain before
>>>> programming proximity_domain_to.
>>>>
>>>> Patch 6 creates proximity domains and VCRAT entries for all online
>>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>>
>>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
>>>> devices, exposing the associated NUMA node through the topology sysfs
>>>> interface.
>>>>
>>>> Please note that the changes in this series are on a best effort 
>>>> basis from our
>>>> end. Therefore, requesting the amd-gfx community (who have deeper 
>>>> knowledge of the
>>>> HW & SW stack) to kindly help with the review and provide feedback 
>>>> / comments on
>>>> these patches
>>>>
>>>> Donet Tom (7):
>>>>    drm/amdgpu: Remove unused argument from 
>>>> kfd_create_crat_image_virtual
>>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>>    drm/amdgpu: Create proximity domains and VCRAT entries for CPU-less
>>>>      and memory-less NUMA nodes
>>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry
>>>>
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152 
>>>> +++++++++++++++-------
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>>
