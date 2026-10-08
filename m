Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63910CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B3710FF61;
	Fri,  9 Oct 2026 08:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ZZ9jcR/G";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B3F10E403
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 08:24:35 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987ZbSU702563; Thu, 8 Oct 2026 08:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FkLt4/
 efk5xaiPQ3LJBkTHv9tpuC0X9yFjtQpl6mGnQ=; b=ZZ9jcR/GaJlK00+uPzT8Dh
 ashi0PgZJzpqc/iJ+CSRaK6hyXg8PCUJjOC10Pmq2PhT49AzlcDMNNFnTXap12w2
 CTqoK+jiovtJfX9V4jku0W+A1LbpnAJcNpJeVhaGJqsF6utqoZ5srYsISLZavpRG
 HIJ7JlHTKABnaC+WRZDKFVp8aZK8AtsXlGZVMvkL6Tz3FfRENjyY/DOHiZcfGNSh
 JxdiGv/01r5iY/kJRreFuuop/T5Ot56CWCa2hpiwfJN8lsYJmj3isb++cyjeGe9e
 jK4G+w1aiiU1Njug67egCs+fZo1Ha/ZDFk/SwlYaeVRapy4y9GOdgBAbCew6lgqg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvad0e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 08:24:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987Ia0c3153230; Thu, 8 Oct 2026 08:24:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh2a5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 08:24:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6988OTMQ33424108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 08:24:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95A065805D;
 Thu,  8 Oct 2026 08:24:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32E4958058;
 Thu,  8 Oct 2026 08:24:25 +0000 (GMT)
Received: from [9.43.94.40] (unknown [9.43.94.40])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 08:24:24 +0000 (GMT)
Message-ID: <e94d79d2-bc24-41e9-aef0-b29d3e44a833@linux.ibm.com>
Date: Thu, 8 Oct 2026 13:54:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Restrict CU and memory entries to
 resource nodes
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, Dhruv B <dhruv.b@linux.ibm.com>
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
 <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
 <c4f3a215-531a-440e-a0e2-c3fbcbd4408c@amd.com>
 <9c600a6f-e665-46d2-9924-a7af08af092b@linux.ibm.com>
 <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
Content-Language: en-US
From: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>
In-Reply-To: <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9OS4LxqTZ71D0itRwjF8AIXK7FK5ht2f
X-Proofpoint-ORIG-GUID: 2x4gxpJ-jSdzR1wBaxDb8iO85kQeXXO5
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac75340 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=_EeEMxcBAAAA:8
 a=VnNF1IyMAAAA:8 a=FwCEwbOold7zalt3GyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX9yTh1+OdTF9k
 JIEhw8KuJlvJhog81BcoyL4xCoyIZyTqN963zZxscrXxotubbkC25764pnlQIP2gthDTGiXRemE
 6Dev1laWZ3qUXsj16WUmtfCMOyYM1q7CiRPGHDtj/tb+9GYC0RbVvhKno9aDdszv7+9lap/QxPr
 ivsYXnX+EER+5Yg6aEcX2pRuEKRHYlaGbYOJt2B6p0vJB2ZX4PbG87YkZnNEolBXGDy+m4rw7Z1
 npj1qf6r5UJkxJjzuzWJEtzejZxakXK+/64aP7Nbgbw4PhMSArnM9H6DazFSGvr0tFPpaTywWDl
 Cw9/W+FOTUDkFWjTuL4XWDtqm7SuOkB2vFiOjRM/kejrhMcmVuBHxHPyfUpvU8JnnzAX8RoAXgK
 vJls5wqva4n+c/4hn0BrWQa4LQJ7OhFg08mh315m0UCER53VKyj6KV5elHmsCgLYm9H9BLCHbtc
 +KL8J26dMoP2NK1Zq/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX0kX6mhb39qlh
 99t2innCB3//C3C4XOAylNmSPHg3umMAujGq21lSngSd0nnaJfLESrgw3HECVW+Ek1tBtutCigX
 FnzCyhEU7e55jSSo7jXOJAYvilLxMCA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032
X-Mailman-Approved-At: Fri, 09 Oct 2026 08:12:18 +0000
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


On 08/10/26 02:31, Kuehling, Felix wrote:
> On 2026-10-07 07:14, Dhruv Bhogaonkar wrote:
>> [Some people who received this message don't often get email from 
>> dhruvb@linux.ibm.com. Learn why this is important at 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On 07/10/26 01:30, Felix Kuehling wrote:
>>>
>>> On 2026-10-06 08:51, Dhruv B wrote:
>>>> In heterogeneous or non-uniform NUMA systems, a NUMA node may be
>>>> CPU-less, memory-less, or both CPU-less and memory-less.
>>>>
>>>> Previously, kfd_create_vcrat_image_cpu() assumed that every online 
>>>> NUMA
>>>> node contained both compute units and memory, attempting to create 
>>>> both
>>>> CU and memory CRAT entries unconditionally for every online node.
>>>>
>>>> Add explicit guards to:
>>>> 1. Only create Compute Unit CRAT entries if the NUMA node has valid
>>>>     CPU cores (kfd_numa_node_to_apic_id() != -1).
>>>> 2. Only create Memory CRAT entries if the NUMA node actually contains
>>>>     memory (node_state(numa_node_id, N_MEMORY)).
>>>>
>>>> This avoids emitting invalid or empty CRAT subtype entries for 
>>>> CPU-less,
>>>> memory-less, or both CPU-less and memory-less NUMA nodes in virtual 
>>>> CRAT
>>>> generation.
>>>
>>> @David Yat Sin, I think we currently support CPU-less and memory-less
>>> NUMA domains already. I know we have CPU-less NUMA domains on MI300A
>>> in NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU systems
>>> with only one DIMM populated, which would result in a memory-less NUMA
>>> domain.
>>>
>>> Therefore, I'm not sure whether this patch is really needed and I'd be
>>> concerned about introducing a regression. Is ROCr able to handle the
>>> changes being proposed here? David, could you take a look at this and
>>> maybe even test it, or find someone who could help test it on the
>>> system configurations I described?
>>
>> Thank you for the feedback, Felix. Apologies for the bug in v1 —
>> that was an oversight on our part.
>>
>> From the current code, the kfd_numa_node_to_apic_id() == -1
>> continue causes the entire loop body to be skipped
>> for a CPU-less NUMA node:
>>
>>   for_each_online_node(numa_node_id) {
>>           if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>>                   continue;
>>
>>           ret = kfd_fill_cu_for_cpu(...);
>>           ...
>>           ret = kfd_fill_mem_info_for_cpu(...);
>>   }
>>
>> When the loop body is skipped, neither a CU entry nor a memory entry is
>> generated for that node, and no KFD topology device appears to be
>> registered for it from this code path. From our reading, it appears that
>> CPU-less nodes are effectively absent from the generated VCRAT topology
>> rather than being represented with an empty or placeholder entry.
>
> OK. I'm a bit surprised about that, because MI300A in NPS4 mode should 
> have three CPU-less NUMA nodes per socket. Maybe we never depended on 
> them being represented as CPU-less NUMA nodes in the KFD topology. 
> Then this change should be an improvement because it removes some 
> ambiguity between NUMA node numbers and KFD proximity domains.
>
>
>>
>>>
>>> @Dhruv B, how much testing have you done on this patch series. Given
>>> that the bug in patch 2 slipped through in v1, I'm worried that it's
>>> not very thorough.
>>
>> Regarding testing, on the userspace side we ran the RCCL unit tests.
>>
>> On the kernel side, we verified that the IO links are created correctly
>> for both topologies by inspecting the KFD topology sysfs entries after
>> driver load.
>>
>> Here are the RCCL unit test results for both configurations, along with
>> the corresponding numactl and KFD topology sysfs output observed after
>> driver load.
>
> Sounds good. We still need to test MI300A to make sure the changes 
> don't confuse ROCr or amdsmi. Applications mostly shouldn't care 
> because they don't use KFD topology node numbers directly. I'm told 
> that most of the MI300A systems in production seem to use NPS1, so 
> this shouldn't affect them.


Thank you, Felix, for the feedback and clarification. We appreciate
you taking the time to review the series.

We will wait for the MI300A testing results and will be happy to make
any changes based on the findings.

Regards,
Dhruv B
>
>
> Regards,
>   Felix
>
>
>>
>> ---
>> Test environment — contiguous NUMA (4 nodes, 0-3)
>> --------------------------------------------------
>>
>> numactl reports 4 contiguous nodes (0-3), all with CPUs and memory:
>>
>>   $ numactl -H
>>   available: 4 nodes (0-3)
>>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40
>>                41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
>>   node 0 size: 881496 MB
>>   node 0 free: 875909 MB
>>   node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74
>>                75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93
>>                94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
>>                110 111
>>   node 1 size: 885640 MB
>>   node 1 free: 883815 MB
>>   node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123 124 125
>>                126 127 128 129 130 131 132 133 134 135 136 137 138 139
>>                140 141 142 143 144 145 146 147 148 149 150 151 152 153
>>                154 155 156 157 158 159 160 161 162 163 164 165 166 167
>>   node 2 size: 885640 MB
>>   node 2 free: 874248 MB
>>   node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 180 181
>>                182 183 184 185 186 187 188 189 190 191 192 193 194 195
>>                196 197 198 199 200 201 202 203 204 205 206 207 208 209
>>                210 211 212 213 214 215 216 217 218 219 220 221 222 223
>>   node 3 size: 885394 MB
>>   node 3 free: 884033 MB
>>
>> The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2 GPUs
>> (nodes 4 and 5), each CPU node with correct core and memory counts:
>>
>>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>>
>>   0: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>   1: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>   2: cpu_cores_count 56  mem_banks_count 1 io_links_count 2
>>   3: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
>>   4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>>   5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>>
>> RCCL unit tests — 948 cases, all PASS:
>>
>> ---
>> Test environment — discontiguous NUMA (3 nodes: 0, 2-3)
>> --------------------------------------------------------
>>
>> numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3 are
>> CPU-less and memory-less:
>>
>>   $ numactl -H
>>   available: 3 nodes (0,2-3)
>>   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
>>                22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
>>   node 0 size: 519305 MB
>>   node 0 free: 504963 MB
>>   node 2 cpus: (none)
>>   node 2 size: 0 MB
>>   node 2 free: 0 MB
>>   node 3 cpus: (none)
>>   node 3 size: 0 MB
>>   node 3 free: 0 MB
>>
>> After this patch series the KFD topology sysfs correctly preserves the
>> NUMA node IDs as proximity domains. Node 1 appears as an empty
>> placeholder, nodes 2 and 3 have no cores or memory banks but carry the
>> GPU IO links, and both GPUs correctly reference node 2 as their attached
>> CPU-less domain:
>>
>>   /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
>>
>>   0: cpu_cores_count 40  mem_banks_count 1 io_links_count 0
>>   1: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (absent,
>> placeholder)
>>   2: cpu_cores_count  0  mem_banks_count 0 io_links_count 2 (CPU-less,
>> GPUs attached)
>>   3: cpu_cores_count  0  mem_banks_count 0 io_links_count 0 (CPU-less)
>>   4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>>   5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
>>
>>   node 4 io_link: node_from 4  node_to 2 type 2  max_bandwidth 10000
>>   node 5 io_link: node_from 5  node_to 2 type 2  max_bandwidth 10000
>>
>> RCCL unit tests — 948 cases, all PASS:
>>
>> We fully understand your concern about regressions. We would
>> greatly appreciate it if someone with access to the systems you 
>> mentioned
>> could test this series, and we are very happy to make any adjustments
>> based on that feedback.
>>
>> Regards,
>> Dhruv
>>
>>>
>>> That said, the patch series looks good to me now, in theory.
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40 
>>>> +++++++++++++++------------
>>>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> index 7dad8f30ff2a..329931b0edc6 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>> @@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void
>>>> *pcrat_image, size_t *size)
>>>>           }
>>>>             /* Fill in Subtype: Compute Unit */
>>>> -        ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>> -            crat_table->num_domains,
>>>> -            (struct crat_subtype_computeunit *)sub_type_hdr);
>>>> -        if (ret < 0)
>>>> -            return ret;
>>>> -        crat_table->length += sub_type_hdr->length;
>>>> -        crat_table->total_entries++;
>>>> +        if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
>>>> +            ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>> +                          crat_table->num_domains,
>>>> +                          (struct crat_subtype_computeunit
>>>> *)sub_type_hdr);
>>>> +            if (ret < 0)
>>>> +                return ret;
>>>> +            crat_table->length += sub_type_hdr->length;
>>>> +            crat_table->total_entries++;
>>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char 
>>>> *)sub_type_hdr +
>>>> -            sub_type_hdr->length);
>>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>>> *)sub_type_hdr +
>>>> +                sub_type_hdr->length);
>>>> +        }
>>>>             /* Fill in Subtype: Memory */
>>>> -        ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>> -            crat_table->num_domains,
>>>> -            (struct crat_subtype_memory *)sub_type_hdr);
>>>> -        if (ret < 0)
>>>> -            return ret;
>>>> -        crat_table->length += sub_type_hdr->length;
>>>> -        crat_table->total_entries++;
>>>> +        if (node_state(numa_node_id, N_MEMORY)) {
>>>> +            ret = kfd_fill_mem_info_for_cpu(numa_node_id, 
>>>> &avail_size,
>>>> +                            crat_table->num_domains,
>>>> +                            (struct crat_subtype_memory
>>>> *)sub_type_hdr);
>>>> +            if (ret < 0)
>>>> +                return ret;
>>>> +            crat_table->length += sub_type_hdr->length;
>>>> +            crat_table->total_entries++;
>>>>   -        sub_type_hdr = (typeof(sub_type_hdr))((char 
>>>> *)sub_type_hdr +
>>>> -            sub_type_hdr->length);
>>>> +            sub_type_hdr = (typeof(sub_type_hdr))((char
>>>> *)sub_type_hdr +
>>>> +                sub_type_hdr->length);
>>>> +        }
>>>>             /* Fill in Subtype: IO Link */
>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
