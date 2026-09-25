Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F9C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A2710E5C9;
	Sun, 27 Sep 2026 13:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="iUztaLFM";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9482410E068
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 14:13:59 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4a7ZT4104476; Fri, 25 Sep 2026 14:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=54ZqZ2
 l9M8D/c0NjLUrIKIRp72yriJxMsI0xJBMA08I=; b=iUztaLFMRdCYh5QiTBZpUb
 x2JEu6bnRFUL2rXkLelW6ktSfNowffU/AR8bCNIZMw5QQsiDhnHxlt4TDpSouSFS
 07J7OXvyksE+IH8hnSIh03GtDi5yzhXCPp2mqyJQjqQ5h8hbJIvXOeeIuRy/J4Mu
 V5MXETAdwsJHTQt1+0quTPllDA5531tPPchyWUK3hXzx8jD8ITHq15KFr5hZ4c9s
 324AdHlt1HrIKZbJIF1sKUhwfGE17W2MIPaeDbvQW8S7N8Ma+aJdYVZOpNil8P+s
 EbPX/cftJKB+Lw+YaWk6T0pmvPtKeKvMCg7meIjN3rTEQFjCRC2CvXy+N5vX8Z0w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1xjgy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 14:13:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P9tnVn1959486; Fri, 25 Sep 2026 14:13:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eex1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 14:13:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PEDrh59241110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 14:13:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17E2A5804E;
 Fri, 25 Sep 2026 14:13:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EF955803F;
 Fri, 25 Sep 2026 14:13:48 +0000 (GMT)
Received: from [9.43.117.126] (unknown [9.43.117.126])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 14:13:47 +0000 (GMT)
Message-ID: <067237bd-64b5-4515-a5ba-e3643dd0b9e7@linux.ibm.com>
Date: Fri, 25 Sep 2026 19:43:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amdgpu: Fix topology device creation and
 proximity domain mappings for sparse and CPU-less NUMA systems
From: Dhruv Bhogaonkar <dhruv.b@linux.ibm.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
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
 <6b7e68a3-8308-496d-a183-f23be992448e@linux.ibm.com>
 <a7404568-5d4b-4588-950c-28a5225f77d3@amd.com>
 <8e5fccd6-6907-498c-b1a9-39fe15525ee2@linux.ibm.com>
 <00a10239-1e09-470b-8970-db00814af486@amd.com>
 <cafaaba4-7d45-46ef-b0bf-67fe8cfa70ac@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <cafaaba4-7d45-46ef-b0bf-67fe8cfa70ac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QLgwNcM_cJxm_MC-5sHLm3C5GH1Ft91v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfX4lI36+RC7VWO
 seN+CFmeD87BfOeaoaBmf/hTbYVBYaG3NL2iZ2239iisxEk3dmiTqjh5j6Ad7j0Lb+bVrszzDdX
 7uS3MJvfAw3wys/iI+AkqJMQU6dfwW+SNC4Iz2ECXDzIFrRVErQynapvn5humqRKDJLU1vgHdy2
 agsWrWtVIP83x/3OmeZxi3rjKeIbZMJZrKWxf4AgBu4WQC7tMO7rtm4Rn986SRK93U64LJTldGm
 ricDBtr548yXyd2ihePVEqsLazaMHkPl+fQRw3A6Po9PZaFaOZfml9jzfj0/JDaaL7k50A7GO4q
 kajOF6juLAXgPqWZ4kAlMmk/XL6MRTxiP847EO2jXPB+UBnhmOKNRM8SmXwncklbg6VF5MABaBl
 uh329IrWOVrFRAb11e+BYQQqzJi/y1rd54UvDg6pDT4PRPRL7skXaaFzCy7BCZaHoFatcebtBGZ
 cqGHekcduA8BRIrgWZw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab681a3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=2SrNnTgdAAAA:20
 a=P-IC7800AAAA:8 a=5zLolSZRropB7c23hK8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfX816AGfYvNqnW
 LhQsVcZwh92egc5qlMYUOy6gj2y2TeIY5epuvg1wzX6XjDGqlQzEDvuE3sxQJv/ogXJQFYnodsB
 uk4tFf68udhpewtR3YuX7N14g+VhD1Y=
X-Proofpoint-GUID: 6Okoahd5bg0BMCv5qPyBbeIZ69pJd4p2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250056
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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


On 23/09/26 11:28, Dhruv Bhogaonkar wrote:
>
> On 23/09/26 04:19, Felix Kuehling wrote:
>> On 2026-09-22 12:59, Dhruv Bhogaonkar wrote:
>>>
>>> On 21/09/26 22:35, Kuehling, Felix wrote:
>>>> On 2026-09-21 00:56, Dhruv Bhogaonkar wrote:
>>>>> On 05/08/26 21:46, Kuehling, Felix wrote:
>>>>>>
>>>>>> On 2026-08-05 03:09, Donet Tom wrote:
>>>>>>>
>>>>>>> On 8/5/26 3:57 AM, Felix Kuehling wrote:
>>>>>>>>
>>>>>>>> On 2026-08-04 05:52, Donet Tom wrote:
>>>>>>>>> This series fixes topology device creation and proximity domain
>>>>>>>>> mappings in
>>>>>>>>> AMDKFD when a system does not provide a CRAT table and the driver
>>>>>>>>> generates a
>>>>>>>>> Virtual CRAT (VCRAT).
>>>>>>>>>
>>>>>>>>> The current implementation assumes that CPU NUMA node IDs are
>>>>>>>>> contiguous and
>>>>>>>>> that every NUMA node contains CPUs. During VCRAT generation, CPU
>>>>>>>>> topology
>>>>>>>>> entries and proximity domains are created only for NUMA nodes 
>>>>>>>>> that
>>>>>>>>> have CPUs.
>>>>>>>>> GPU proximity domains are then allocated immediately after the 
>>>>>>>>> CPU
>>>>>>>>> proximity
>>>>>>>>> domains, and the GPU I/O link (proximity_domain_to) is 
>>>>>>>>> initialized
>>>>>>>>> using the
>>>>>>>>> NUMA node ID to which the GPU is attached, implicitly assuming 
>>>>>>>>> that
>>>>>>>>> NUMA node
>>>>>>>>> IDs and proximity domains have a one-to-one mapping.
>>>>>>>>>
>>>>>>>>> These assumptions break on systems with:
>>>>>>>>>
>>>>>>>>> Sparse (non-contiguous) NUMA node IDs
>>>>>>>>> CPU-less NUMA nodes
>>>>>>>>> CPU-less and memory-less NUMA nodes
>>>>>>>>>
>>>>>>>>> For example:
>>>>>>>>>
>>>>>>>>> available: 3 nodes (0,2-3)
>>>>>>>>>
>>>>>>>>> node 0: CPUs present
>>>>>>>>> node 2: CPU-less
>>>>>>>>> node 3: CPU-less
>>>>>>>>>
>>>>>>>>> In this case, the driver creates a CPU topology device only for
>>>>>>>>> node 0 and
>>>>>>>>> assigns a single CPU proximity domain (0). However, the GPU VCRAT
>>>>>>>>> still
>>>>>>>>> references the NUMA node ID to which the GPU is attached (for
>>>>>>>>> example, node 3)
>>>>>>>>> in the proximity_domain_to field. Since no corresponding CPU
>>>>>>>>> proximity domain
>>>>>>>>> exists for node 3, the parser cannot find a matching proximity
>>>>>>>>> domain during
>>>>>>>>> VCRAT parsing, causing topology initialization to fail.
>>>>>>>>
>>>>>>>> Hi Tom,
>>>>>>>
>>>>>>>
>>>>>>> Hi Felix,
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thank you for the explanation and the patch series. I may have 
>>>>>>>> some
>>>>>>>> gaps in my understanding that I would like to clarify. In my 
>>>>>>>> mind, I
>>>>>>>> was using "proximity domain" and "NUMA node" interchangeably. 
>>>>>>>> You're
>>>>>>>> demonstrating that they are not the same thing. Is that just a
>>>>>>>> different way of labeling the same thing, or are NUMA nodes and
>>>>>>>> proximity domains fundamentally different concepts.
>>>>>>>>
>>>>>>>> Your code in patch 5 (kfd_proximity_domain_to_numa_node and
>>>>>>>> kfd_numa_node_to_proximity_domain) seems to imply that there 
>>>>>>>> is, in
>>>>>>>> fact, a 1:1 mapping, as it assumes that there is a unique
>>>>>>>> translation in both directions. Am I missing something?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks for the comment.
>>>>>>>
>>>>>>> IIUC, NUMA node IDs and proximity domains are different numbering
>>>>>>> schemes. We have proximity domains for both CPU and GPU devices. 
>>>>>>> CPU
>>>>>>> proximity domains start from 0, and GPU proximity domains start 
>>>>>>> after
>>>>>>> the last CPU proximity domain.
>>>>>>>
>>>>>>> If the NUMA node IDs are contiguous, the CPU proximity domains 
>>>>>>> happen
>>>>>>> to match the NUMA node IDs. However, if the NUMA node IDs are
>>>>>>> discontiguous, the CPU proximity domains and NUMA node IDs no 
>>>>>>> longer
>>>>>>> have a one-to-one mapping.
>>>>>>>
>>>>>>>>
>>>>>>>> If they are just different numbering systems, do we really need to
>>>>>>>> keep track of both proximity domains and NUMA nodes in the KFD
>>>>>>>> topology? Or would it be sufficient to only track NUMA nodes, if
>>>>>>>> that's what we really care about in the uAPI (KFD sysfs)?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks for the suggestion. I also think we don't need to keep track
>>>>>>> of both the proximity domains and the NUMA node IDs in KFD. Do you
>>>>>>> think the approach below would be reasonable?
>>>>>>>
>>>>>>> Just to make sure I understand correctly, for CPU devices the
>>>>>>> proximity domain will be the same as the NUMA node ID, and the GPU
>>>>>>> proximity domains will start after the last CPU proximity domain.
>>>>>>>
>>>>>>> In that case, the CPU proximity domains and NUMA node IDs will 
>>>>>>> always
>>>>>>> have a one-to-one mapping, and the GPU proximity domains will 
>>>>>>> follow
>>>>>>> after them.
>>>>>>>
>>>>>>> For example, if a system has three NUMA nodes and two GPUs:
>>>>>>>
>>>>>>> NUMA node IDs:            0   2   3
>>>>>>> CPU proximity domains:    0   2   3
>>>>>>> GPU proximity domains:    4   5
>>>>>>>
>>>>>>> Would it be okay to proceed with this approach?
>>>>>>
>>>>>> Yes, this looks good to me.
>>>>>
>>>>>
>>>>> Hi Felix,
>>>>>
>>>>> I have been looking into this issue along with Donet.
>>>>>
>>>>> From my understanding, there are three related but distinct concepts
>>>>> involved here:
>>>>>
>>>>> * NUMA node: A system can have sparse NUMA node IDs. For example,
>>>>>   online nodes can be 0, 2, and 3, with node 1 absent.
>>>>>
>>>>> * Proximity domain: The proximity domain is the identifier
>>>>>   associated with a KFD topology device. In the current 
>>>>> implementation,
>>>>>   proximity domains for CPU topology devices are assigned using a
>>>>>   sequential counter, and GPU proximity domains are allocated 
>>>>> after the
>>>>>   CPU proximity domains.
>>>>>
>>>>> * KFD sysfs topology node: KFD exposes each topology device through
>>>>>   a node under its sysfs topology interface. Userspace reads these 
>>>>> sysfs
>>>>>   nodes to discover the CPU/GPU topology and their relationships. 
>>>>> In the
>>>>>   current implementation, the sysfs node numbering corresponds to the
>>>>>   proximity domain numbering.
>>>>>
>>>>> IIUC, the proximity-domain numbering and KFD sysfs topology-node
>>>>> numbering are expected to correspond, while the Linux NUMA node ID 
>>>>> can
>>>>> be a separate identifier that is mapped to the corresponding topology
>>>>> or proximity domain.
>>>>>
>>>>> As discussed in the thread, we implemented the
>>>>> 'NUMA node ==Proximity Domain' approach. However, after implementing
>>>>> this for sparse nodes, we found that the userspace libraries using 
>>>>> the
>>>>> KFD sysfs nodes have an assumption that the topology devices are
>>>>> contiguous.
>>>>>
>>>>> With this approach, discontiguous NUMA nodes result in discontiguous
>>>>> proximity-domain and sysfs node numbers. This would break userspace
>>>>> libraries that assume the topology devices are contiguous.
>>>>>
>>>>> To support this approach, we would need to make corresponding changes
>>>>> in the userspace libraries, which would break applications using the
>>>>> existing userspace and introduce backward-compatibility concerns.
>>>>>
>>>>> With this in mind, we think the current RFC v1 approach would be the
>>>>> better way to proceed, keeping the NUMA node IDs separate from the
>>>>> proximity-domain/sysfs numbering.
>>>>
>>>> I'm not sure about this. We have code in user mode that uses the KFD
>>>> proximity domains as CPU NUMA nodes, e.g. in calls to mbind. E.g.
>>>> https://github.com/ROCm/rocm-systems/blob/f437a7135fa67b96b48da4baeb72d5f75c406052/projects/rocr-runtime/libhsakmt/src/fmm.c#L2058 
>>>>
>>>>
>>>> So if you change the KFD CPU proximity domain numbers to something
>>>> contiguous, you're probably breaking user mode either way.
>>>
>>>
>>> Hi Felix,
>>>
>>> Thanks for pointing this out.
>>>
>>> I think the approach you originally suggested seems to be the better 
>>> one:
>>> keeping the CPU proximity domain numbers aligned with the NUMA node 
>>> IDs,
>>> including sparse NUMA node IDs.
>>>
>>> This will require corresponding userspace changes to support
>>> non-contiguous NUMA node IDs, but I don't expect this to break any
>>> existing applications or introduce backward compatibility issues. For
>>> systems with contiguous NUMA node IDs, the existing behavior will work
>>> as is, while systems with non-contiguous NUMA node IDs will work after
>>> the userspace changes.
>>>
>>> For example, one of the areas that will need to be updated is here:
>>>
>>> https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/ 
>>>
>>> projects/rocr-runtime/libhsakmt/src/topology.c#L831
>>
>> The code here is already designed to handle sysfs nodes that are not 
>> accessible because GPUs are not available in the process' cgroup. 
>> Maybe we need additional fixes here to handle the case where a 
>> directory is completely missing in sysfs. The biggest problem is 
>> probably, that user mode tries to remap the node-IDs into a 
>> contiguous range here: 
>> https://github.com/ROCm/rocm-systems/blob/2d743306cb341b5973cb0d6af7b549569d127724/projects/rocr-runtime/libhsakmt/src/topology.c#L836. 
>> We'd need to avoid that for CPU nodes so that we preserve the 
>> identity mapping from node IDs to NUMA node IDs. Maybe we can create 
>> dummy nodes with no CPU cores and no memory as place-holders.


Hi Felix,

As we discussed, I tried an approach where dummy topology devices
and corresponding sysfs entries are created for absent NUMA nodes.
With this approach, the KFD sysfs entries remain contiguous even when
the underlying NUMA node IDs are discontiguous. Therefore, no
userspace changes are required.

The core change is:

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a1087c13f241..80b0242844cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1879,7 +1879,7 @@ static int kfd_create_vcrat_image_cpu(
         acpi_status status;
         struct crat_subtype_generic *sub_type_hdr;
         int avail_size = *size;
-       int numa_node_id;
+       int numa_node_id, last_node;
  #ifdef CONFIG_X86_64
         uint32_t entries = 0;
  #endif
@@ -1916,8 +1916,14 @@ static int kfd_create_vcrat_image_cpu(
         sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
-       for_each_online_node(numa_node_id) {
-               if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
+       /*
+        * Iterate 0..last_online_node so proximity_domain == NUMA node ID.
+        * Absent (gap) node IDs get a domain slot but no subtypes.
+        */
+       last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
+       for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
+               crat_table->num_domains++;
+
+               if (!node_online(numa_node_id))
                         continue;

Here, VCRAT entries were not previously created for NUMA nodes that
did not have CPUs. I made changes to also support CPU-less, memory-less,
and CPU-less/memory-less NUMA nodes.

For missing NUMA node IDs, we reserve a proximity-domain slot without
creating any CPU or memory subtypes. Similarly, for online nodes
without CPUs or memory, the domain slot is still reserved. This
results in a placeholder topology device while keeping the NUMA node
IDs and KFD proximity domains aligned.

For example, if we have online NUMA nodes {0, 2, 3}, we reserve:

     proximity domain    sysfs ID
            0                 0
            1                 1 (dummy)
            2                 2
            3                 3

This allows the existing kernel and userspace code to handle the
topology without remapping the actual NUMA node IDs.

I implemented this with only kernel-side changes; no userspace changes
were required. With these changes, the driver loads successfully on
our system, and all RCCL unit tests are passing.

Could you please share your guidance on whether this approach looks
reasonable? If so, I can prepare and post a proper patch as soon as
possible.

Thanks,
Dhruv B
>>
>>
>>>
>>>
>>> If you have any pointers or suggestions regarding this approach,
>>> especially for the userspace changes, I would really appreciate your
>>> feedback.
>>>
>>>
>>>
>>>>
>>>>
>>>>
>>>>
>>>> Can you point out what specific problems you run into with
>>>> non-contiguous NUMA nodes topologies?
>>>
>>>
>>> The issue we see on a system with discontiguous NUMA nodes is that the
>>> GPU VCRAT parsing fails when we load the GPU driver, resulting in the
>>> following errors in dmesg:
>>>
>>>     amdgpu: Virtual CRAT table created for GPU
>>>     amdgpu: Error parsing VCRAT
>>>     kfd: amdgpu: Error adding device to topology
>>>     kfd: amdgpu: Error initializing KFD node
>>>
>>> On our system, we have 3 NUMA nodes: 0, 2, and 3, with 2 GPUs attached
>>> to NUMA node 3.
>>
>> OK, that's all stuff that would need to be addressed with kernel mode 
>> driver patches. I'm hoping it would be a simplified version of the 
>> patches that Donet already proposed.
>>
>> Regards,
>>   Felix
>
>
> Hi Felix,
>
> Thanks for your suggestions.
>
> I'll start working in this direction and post a patch once
> it's ready.
>
> Thanks,
> Dhruv B
>>
>>
>>>
>>> With the current upstream implementation, CPU proximity domains are
>>> assigned sequentially. Thus, NUMA nodes 0, 2, and 3 get CPU proximity
>>> domains 0, 1, and 2 respectively. The two GPUs then get proximity
>>> domains 3 and 4.
>>>
>>> However, when generating the GPU VCRAT, `proximity_domain_to` is
>>> populated directly with the NUMA node ID. Since both GPUs are attached
>>> to NUMA node 3, the VCRAT contains:
>>>
>>>     GPU0 -> proximity_domain_to = 3
>>>     GPU1 -> proximity_domain_to = 3
>>>
>>> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L2175 
>>>
>>>
>>> Here, the CPU proximity domain corresponding to NUMA node 3 is actually
>>> 2, while proximity domain 3 belongs to GPU0.
>>>
>>> During VCRAT parsing, the I/O link parser looks up this `id_to`
>>> proximity domain, which is 3, and returns `-ENODEV` because there is no
>>> CPU topology device with proximity domain 3:
>>>
>>> https://elixir.bootlin.com/linux/v7.1/source/drivers/gpu/drm/amd/amdkfd/kfd_crat.c#L1284 
>>>
>>>
>>> Thus, the GPU I/O link is referencing the NUMA node ID as if it were
>>> the CPU proximity domain, which causes the VCRAT parsing to fail.
>>>
>>> Since the parsing fails, the driver does not get loaded.
>>>
>>> Thanks,
>>> Dhruv B
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Would you agree with this approach? If so, I can rebase the RFC v1
>>>>> series onto the latest kernel and post a new version for review.
>>>>>
>>>>> Thanks,
>>>>> Dhruv B
>>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> I think this approach should also resolve the driver loading issue.
>>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>> Donet Tom
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>   Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The failure is observed as:
>>>>>>>>>
>>>>>>>>> amdgpu: Virtual CRAT table created for GPU
>>>>>>>>> amdgpu: Error parsing VCRAT
>>>>>>>>> kfd: amdgpu: Error adding device to topology
>>>>>>>>> kfd: amdgpu: Error initializing KFD node
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Since every online NUMA node is a valid topology object and can
>>>>>>>>> contain
>>>>>>>>> CPUs, memory, I/O links, or any combination of these, topology
>>>>>>>>> devices
>>>>>>>>> and proximity domains should be created for every online NUMA 
>>>>>>>>> node
>>>>>>>>> rather than only for NUMA nodes that contain CPUs.
>>>>>>>>>
>>>>>>>>> To address this, this series introduces a new VCRAT subtype that
>>>>>>>>> records the mapping between the NUMA node ID and the generated 
>>>>>>>>> VCRAT
>>>>>>>>> proximity domain. When topology devices are created, this
>>>>>>>>> information
>>>>>>>>> is stored in the corresponding topology device, allowing the
>>>>>>>>> driver to
>>>>>>>>> translate a NUMA node ID into its associated proximity domain
>>>>>>>>> whenever
>>>>>>>>> required.
>>>>>>>>>
>>>>>>>>> Returning to the previous example, the system contains three 
>>>>>>>>> online
>>>>>>>>> NUMA nodes, so three CPU topology devices and three proximity
>>>>>>>>> domains
>>>>>>>>> are created, even though only one NUMA node contains CPUs. The 
>>>>>>>>> NUMA
>>>>>>>>> node ID is stored in each topology device together with its
>>>>>>>>> generated
>>>>>>>>> proximity domain.
>>>>>>>>>
>>>>>>>>> Later, when the GPU VCRAT is generated, the driver only knows the
>>>>>>>>> NUMA
>>>>>>>>> node ID to which the GPU is attached (for example, node 3).
>>>>>>>>> Instead of
>>>>>>>>> assuming that the NUMA node ID is equal to the proximity 
>>>>>>>>> domain, the
>>>>>>>>> driver walks the existing topology devices to locate the
>>>>>>>>> corresponding
>>>>>>>>> NUMA node and retrieves its generated proximity domain. In this
>>>>>>>>> example, NUMA node 3 maps to proximity domain 2, so
>>>>>>>>> proximity_domain_to is populated with the correct value.
>>>>>>>>>
>>>>>>>>> Since the GPU I/O link now references a valid proximity domain,
>>>>>>>>> VCRAT
>>>>>>>>> parsing completes successfully and topology initialization 
>>>>>>>>> proceeds
>>>>>>>>> without errors on systems with sparse NUMA node IDs, CPU-less 
>>>>>>>>> NUMA
>>>>>>>>> nodes, and CPU-less/memory-less NUMA nodes.
>>>>>>>>>
>>>>>>>>> This series consists of the following patches:
>>>>>>>>>
>>>>>>>>> Patch 1 removes an unused argument from
>>>>>>>>> kfd_create_crat_image_virtual() as a preparatory cleanup.
>>>>>>>>>
>>>>>>>>> Patch 2 introduces a new VCRAT NUMA affinity subtype that 
>>>>>>>>> stores the
>>>>>>>>> NUMA node ID and its corresponding proximity domain.
>>>>>>>>>
>>>>>>>>> Patch 3 populates the NUMA affinity entries during VCRAT 
>>>>>>>>> generation
>>>>>>>>> for every online NUMA node.
>>>>>>>>>
>>>>>>>>> Patch 4 parses the NUMA affinity entries from the VCRAT and
>>>>>>>>> stores the
>>>>>>>>> NUMA node ID and proximity domain in the corresponding topology
>>>>>>>>> device.
>>>>>>>>>
>>>>>>>>> Patch 5 fixes GPU VCRAT proximity domain mappings by 
>>>>>>>>> translating the
>>>>>>>>> GPU's NUMA node ID to the corresponding CPU proximity domain 
>>>>>>>>> before
>>>>>>>>> programming proximity_domain_to.
>>>>>>>>>
>>>>>>>>> Patch 6 creates proximity domains and VCRAT entries for all 
>>>>>>>>> online
>>>>>>>>> NUMA nodes, including CPU-less and memory-less nodes.
>>>>>>>>>
>>>>>>>>> Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
>>>>>>>>> devices, exposing the associated NUMA node through the topology
>>>>>>>>> sysfs
>>>>>>>>> interface.
>>>>>>>>>
>>>>>>>>> Please note that the changes in this series are on a best effort
>>>>>>>>> basis from our
>>>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper
>>>>>>>>> knowledge of the
>>>>>>>>> HW & SW stack) to kindly help with the review and provide 
>>>>>>>>> feedback
>>>>>>>>> / comments on
>>>>>>>>> these patches
>>>>>>>>>
>>>>>>>>> Donet Tom (7):
>>>>>>>>>    drm/amdgpu: Remove unused argument from
>>>>>>>>> kfd_create_crat_image_virtual
>>>>>>>>>    drm/amdgpu: Add VCRAT NUMA affinity entry
>>>>>>>>>    drm/amdgpu: Populate NUMA affinity entries in VCRAT
>>>>>>>>>    drm/amdgpu: Parse NUMA affinity entries from VCRAT
>>>>>>>>>    drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
>>>>>>>>>    drm/amdgpu: Create proximity domains and VCRAT entries for
>>>>>>>>> CPU-less
>>>>>>>>>      and memory-less NUMA nodes
>>>>>>>>>    drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs 
>>>>>>>>> entry
>>>>>>>>>
>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152
>>>>>>>>> +++++++++++++++-------
>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
>>>>>>>>>   4 files changed, 168 insertions(+), 56 deletions(-)
>>>>>>>>>
