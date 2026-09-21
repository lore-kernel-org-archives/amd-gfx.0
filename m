Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119FCC982F7
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778C610E1B2;
	Mon, 21 Sep 2026 07:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ShQ9dTv/";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F89B10E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 04:56:55 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3ZdBn2600866; Mon, 21 Sep 2026 04:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b0a18e
 TjtS4BbEI8hV4IP2VFt/madAuYj/Y/sWlsBMc=; b=ShQ9dTv/LhSyxkLssEUS+N
 s9N7fWVmPErZJs4XP2+/+2BXfPKmg4frwkHNhJQt31hzmaqPg9VWGtIK+XRWwYYW
 ehENjhRHM15/AHvRB85rG88NtVtYMqDbTsXiZdulceKk2jdnFiZy/u4nXQls0uol
 DYdr/Ht5uDOILsSYm93pQRxQaG5gehIb3tQCVi0b4Wgpk8+N32EzNGyY4b2xLGPJ
 O/QpEIDDEL3TTu5vSj+DJ/b+tZlFNC1aRnU0UNvHj0a/NPZ7H+Mx0RoM27+65iv+
 E5dDIwO+qm1dp/sHrbSnvxbHrLTSdm28V6LX2niBHvFsExqUQpeejpsT6FrS9zxw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1etnm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:56:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L3XZBC628100; Mon, 21 Sep 2026 04:56:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vbx1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:56:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68L4umL74981430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 04:56:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDEAF58054;
 Mon, 21 Sep 2026 04:56:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D8EC5805A;
 Mon, 21 Sep 2026 04:56:42 +0000 (GMT)
Received: from [9.123.4.213] (unknown [9.123.4.213])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 04:56:41 +0000 (GMT)
Message-ID: <6b7e68a3-8308-496d-a183-f23be992448e@linux.ibm.com>
Date: Mon, 21 Sep 2026 10:26:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
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
From: Dhruv Bhogaonkar <dhruv.b@linux.ibm.com>
In-Reply-To: <2bde809f-d2d9-4b94-88e3-f8e2ae2cc7b0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6s3jT-rFiMoarPkapAND_U9K819l0DZg
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab0b913 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=And3cf6dBW2exZHAJBEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX1rH4TtTpuqgQ
 n7EmzPXC9BeuQBSRfuPrlmvqZmRqld9Uau1nl//djXfVIwjC4N67V4GuSN/bPwIi5yEtJT1YPsN
 0Mzf1+NF0KUaIyuzbCJnvOLrL7nm7Gw=
X-Proofpoint-GUID: b-NheIfNa6hF1O_pVzMNXKii1uoKJWxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA2MyBTYWx0ZWRfX1GD84PIzp/Gr
 QUqTnbcBx5Hqw0u2ziBvuHfGILKK47Z+jvyu66dEnFf3s4qkxh5td/a+Ab5Osi7qqZyN20gnNd/
 fUg5IfINlXKuC7LYteFphOli5N6GTBxgDaAczwk/vk/z6eLc7G3gLNI/iZat3PiQVTR3MNnam9H
 94ZrDtKK74M4eA46ONOl0gahMz/J3/h0MFuqVSriboTuhjtrAjZdtdFw74wbTOfaIWFw2+npAK+
 zXNfeAM4xAfW9A9OfcYoA5skIMWn842hwyf7X/LhPPWm90nJmuI1nx2yohI2h/3rp/s5lIOxyPZ
 284z1POhtewKy8v/voXzOSPZ2tBtEptR8znrMigQwmviN/pudtkAvLHfdN6AM/0NaTtG0aADcKt
 4CoE0dpwTR3EyaZGJjhxpa/hFHloNuLoT/LZZiLu+LyHe3n+ZQrU3qL2US/TeQyeySBNE755yYB
 34/hgzpIfud3wzXjziA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210063
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
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


On 05/08/26 21:46, Kuehling, Felix wrote:
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


Hi Felix,

I have been looking into this issue along with Donet.

 From my understanding, there are three related but distinct concepts 
involved here:

* NUMA node: A system can have sparse NUMA node IDs. For example,
   online nodes can be 0, 2, and 3, with node 1 absent.

* Proximity domain: The proximity domain is the identifier
   associated with a KFD topology device. In the current implementation,
   proximity domains for CPU topology devices are assigned using a
   sequential counter, and GPU proximity domains are allocated after the
   CPU proximity domains.

* KFD sysfs topology node: KFD exposes each topology device through
   a node under its sysfs topology interface. Userspace reads these sysfs
   nodes to discover the CPU/GPU topology and their relationships. In the
   current implementation, the sysfs node numbering corresponds to the
   proximity domain numbering.

IIUC, the proximity-domain numbering and KFD sysfs topology-node
numbering are expected to correspond, while the Linux NUMA node ID can
be a separate identifier that is mapped to the corresponding topology
or proximity domain.

As discussed in the thread, we implemented the
'NUMA node ==Proximity Domain' approach. However, after implementing
this for sparse nodes, we found that the userspace libraries using the
KFD sysfs nodes have an assumption that the topology devices are contiguous.

With this approach, discontiguous NUMA nodes result in discontiguous
proximity-domain and sysfs node numbers. This would break userspace
libraries that assume the topology devices are contiguous.

To support this approach, we would need to make corresponding changes
in the userspace libraries, which would break applications using the
existing userspace and introduce backward-compatibility concerns.

With this in mind, we think the current RFC v1 approach would be the
better way to proceed, keeping the NUMA node IDs separate from the
proximity-domain/sysfs numbering.

Would you agree with this approach? If so, I can rebase the RFC v1
series onto the latest kernel and post a new version for review.

Thanks,
Dhruv B
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
