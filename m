Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C1606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OC3Eo40a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83B210F354;
	Tue, 27 Oct 2026 09:34:12 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5757910E310
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:07:35 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QFEBg03944579; Mon, 26 Oct 2026 18:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=n4KAEqqoiIrqnKnyp9ze3+tMGfRB3K
 Ey6U5su4X3Ak4=; b=OC3Eo40aj6U0puqM9HEqqD+FE1QECleuFYm7HLjLXs17N7
 eBpBWfgPVUJ5bRzgzEvXe4BbsYvzYrPB5B51kH2FTWa10xW/pVgiXQq0DdtLu3rB
 hONLEeqkC5fP16LQDg27h/OxfmIsdqiqLTzBsfS4hoqibyNO4NlUqdzg1TOECMBW
 wwX6bGgCIRK6J+nTpLk7aowbzg/r67cULQXYNW9PgT7fK3Gv2QVZn6C3uN876G4M
 TjK2XFohuzaEyU8X3q1djSOPzVr/qmWhrVlBlGJ5Hvcg594/lFNdfhu9bmf6U2Dm
 K5Z3MvRKIRZfNtHW1b0kUvlekrwCx4VdHHDOT8aw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavb97q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 18:07:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QF4xrR2679010; Mon, 26 Oct 2026 18:07:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80jfb07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 18:07:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QI7T4Y27918968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 18:07:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 524CC58064;
 Mon, 26 Oct 2026 18:07:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7DAB5805A;
 Mon, 26 Oct 2026 18:07:24 +0000 (GMT)
Received: from [9.43.125.254] (unknown [9.43.125.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 18:07:24 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------gcsgMRosat7JeDWSBc69d6nV"
Message-ID: <8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com>
Date: Mon, 26 Oct 2026 23:37:23 +0530
X-Archived-By: <archiver.kernel.org>
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
 donettom@linux.ibm.com
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
 <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
 <c4f3a215-531a-440e-a0e2-c3fbcbd4408c@amd.com>
 <9c600a6f-e665-46d2-9924-a7af08af092b@linux.ibm.com>
 <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
Content-Language: en-US
From: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>
In-Reply-To: <a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf96e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=_EeEMxcBAAAA:8
 a=VnNF1IyMAAAA:8 a=FwCEwbOold7zalt3GyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zd2uoN0lAAAA:8 a=9zUvwptYIGdBwYAPhOcA:9 a=AJi4Jv7M9YSJ48L_:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: EKM-GBueCXEYQK7P434Lsv8e-hG3wbu-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3MCBTYWx0ZWRfXyze1+D32RL3y
 mr4ySN+sxlIfkENfJPgeLj5BIG422FrE2VYftdjq6bf4rFaCeXmgmW4q1VBr5w5hp33e09AuNVz
 OtldDbGTblGEN1YVAnQIiB9HiJXuduY=
X-Proofpoint-ORIG-GUID: YP4eIFM_jAPMzDzw5loh0A6mGkOYaI5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3MCBTYWx0ZWRfXyZLOMH2Gjk8r
 dC4n1O67wsFGhiWpIIYaiqgnZzv+cCljGHBys9EIippZir4FDc9pg14oRIZGGNhgyrfoXM3BKPY
 MaCDZeQ7ejuDXPRwpAWiBHyzRFi1EGXnitO0HzmwTPeOf6P8oTBsr9LixnEfWgp0v8SELuWWg2f
 G3bPWM5M0ZPDHTGV6fsWLGRrn0NGp2B/1078+DxwPVD3EsP69vWwHen1FxKq1agLvYU6d+Jxkao
 vjfEJpxZMGMTNu7UzmAx0HUkQYHtmx1F5515srJ3QCiyqGy3pPIggz2mtVXHY/sOFzJYZzMBqRx
 uuwHuQbhMd9R2zx8FzoRuvQs0A0R8MtYGKT3lf2lbkzy0q8zy5Atori3pjqFHB8vBYJ6H7WmE1T
 gS7PM0ZIff1kVIYSjF/86DvJn654LrFJkmNVQzbt9twiXYQnPgJTWmW5gRuHWGYU4vGFG2+qxh3
 EEGjC+WPEp6H7sQPd3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260070
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:34:11 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------gcsgMRosat7JeDWSBc69d6nV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


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


Hi Felix,

I wanted to ask if there have been any updates on the
patch series and whether anything would be required
from my side.

Thanks,
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
--------------gcsgMRosat7JeDWSBc69d6nV
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
    <div class="moz-cite-prefix">On 08/10/26 02:31, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com">On
      2026-10-07 07:14, Dhruv Bhogaonkar wrote:
      <br>
      <blockquote type="cite">[Some people who received this message
        don't often get email from <a class="moz-txt-link-abbreviated" href="mailto:dhruvb@linux.ibm.com">dhruvb@linux.ibm.com</a>. Learn why this
        is important at <a class="moz-txt-link-freetext" href="https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/LearnAboutSenderIdentification</a> ]
        <br>
        <br>
        On 07/10/26 01:30, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2026-10-06 08:51, Dhruv B wrote:
          <br>
          <blockquote type="cite">In heterogeneous or non-uniform NUMA
            systems, a NUMA node may be
            <br>
            CPU-less, memory-less, or both CPU-less and memory-less.
            <br>
            <br>
            Previously, kfd_create_vcrat_image_cpu() assumed that every
            online NUMA
            <br>
            node contained both compute units and memory, attempting to
            create both
            <br>
            CU and memory CRAT entries unconditionally for every online
            node.
            <br>
            <br>
            Add explicit guards to:
            <br>
            1. Only create Compute Unit CRAT entries if the NUMA node
            has valid
            <br>
                CPU cores (kfd_numa_node_to_apic_id() != -1).
            <br>
            2. Only create Memory CRAT entries if the NUMA node actually
            contains
            <br>
                memory (node_state(numa_node_id, N_MEMORY)).
            <br>
            <br>
            This avoids emitting invalid or empty CRAT subtype entries
            for CPU-less,
            <br>
            memory-less, or both CPU-less and memory-less NUMA nodes in
            virtual CRAT
            <br>
            generation.
            <br>
          </blockquote>
          <br>
          @David Yat Sin, I think we currently support CPU-less and
          memory-less
          <br>
          NUMA domains already. I know we have CPU-less NUMA domains on
          MI300A
          <br>
          in NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU
          systems
          <br>
          with only one DIMM populated, which would result in a
          memory-less NUMA
          <br>
          domain.
          <br>
          <br>
          Therefore, I'm not sure whether this patch is really needed
          and I'd be
          <br>
          concerned about introducing a regression. Is ROCr able to
          handle the
          <br>
          changes being proposed here? David, could you take a look at
          this and
          <br>
          maybe even test it, or find someone who could help test it on
          the
          <br>
          system configurations I described?
          <br>
        </blockquote>
        <br>
        Thank you for the feedback, Felix. Apologies for the bug in v1 —
        <br>
        that was an oversight on our part.
        <br>
        <br>
        From the current code, the kfd_numa_node_to_apic_id() == -1
        <br>
        continue causes the entire loop body to be skipped
        <br>
        for a CPU-less NUMA node:
        <br>
        <br>
          for_each_online_node(numa_node_id) {
        <br>
                  if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
        <br>
                          continue;
        <br>
        <br>
                  ret = kfd_fill_cu_for_cpu(...);
        <br>
                  ...
        <br>
                  ret = kfd_fill_mem_info_for_cpu(...);
        <br>
          }
        <br>
        <br>
        When the loop body is skipped, neither a CU entry nor a memory
        entry is
        <br>
        generated for that node, and no KFD topology device appears to
        be
        <br>
        registered for it from this code path. From our reading, it
        appears that
        <br>
        CPU-less nodes are effectively absent from the generated VCRAT
        topology
        <br>
        rather than being represented with an empty or placeholder
        entry.
        <br>
      </blockquote>
      <br>
      OK. I'm a bit surprised about that, because MI300A in NPS4 mode
      should have three CPU-less NUMA nodes per socket. Maybe we never
      depended on them being represented as CPU-less NUMA nodes in the
      KFD topology. Then this change should be an improvement because it
      removes some ambiguity between NUMA node numbers and KFD proximity
      domains.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <blockquote type="cite">
          <br>
          @Dhruv B, how much testing have you done on this patch series.
          Given
          <br>
          that the bug in patch 2 slipped through in v1, I'm worried
          that it's
          <br>
          not very thorough.
          <br>
        </blockquote>
        <br>
        Regarding testing, on the userspace side we ran the RCCL unit
        tests.
        <br>
        <br>
        On the kernel side, we verified that the IO links are created
        correctly
        <br>
        for both topologies by inspecting the KFD topology sysfs entries
        after
        <br>
        driver load.
        <br>
        <br>
        Here are the RCCL unit test results for both configurations,
        along with
        <br>
        the corresponding numactl and KFD topology sysfs output observed
        after
        <br>
        driver load.
        <br>
      </blockquote>
      <br>
      Sounds good. We still need to test MI300A to make sure the changes
      don't confuse ROCr or amdsmi. Applications mostly shouldn't care
      because they don't use KFD topology node numbers directly. I'm
      told that most of the MI300A systems in production seem to use
      NPS1, so this shouldn't affect them.</blockquote>
    <p><br>
    </p>
    <p data-pm-slice="1 1 []"
style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>Hi
        Felix,</span></p>
    <p
style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>I
        wanted to ask if there have been any updates on the</span><br>
      <span>patch series and whether anything would be required <br>
        from my</span><span> side.</span></p>
    <p
style="caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-size: medium; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;"><span>Thanks,</span><br>
      <span>Dhruv B</span></p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com"> <br>
      <br>
      Regards,
      <br>
        Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        ---
        <br>
        Test environment — contiguous NUMA (4 nodes, 0-3)
        <br>
        --------------------------------------------------
        <br>
        <br>
        numactl reports 4 contiguous nodes (0-3), all with CPUs and
        memory:
        <br>
        <br>
          $ numactl -H
        <br>
          available: 4 nodes (0-3)
        <br>
          node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
        20 21
        <br>
                       22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
        38 39 40
        <br>
                       41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
        <br>
          node 0 size: 881496 MB
        <br>
          node 0 free: 875909 MB
        <br>
          node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
        72 73 74
        <br>
                       75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
        91 92 93
        <br>
                       94 95 96 97 98 99 100 101 102 103 104 105 106 107
        108 109
        <br>
                       110 111
        <br>
          node 1 size: 885640 MB
        <br>
          node 1 free: 883815 MB
        <br>
          node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123
        124 125
        <br>
                       126 127 128 129 130 131 132 133 134 135 136 137
        138 139
        <br>
                       140 141 142 143 144 145 146 147 148 149 150 151
        152 153
        <br>
                       154 155 156 157 158 159 160 161 162 163 164 165
        166 167
        <br>
          node 2 size: 885640 MB
        <br>
          node 2 free: 874248 MB
        <br>
          node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179
        180 181
        <br>
                       182 183 184 185 186 187 188 189 190 191 192 193
        194 195
        <br>
                       196 197 198 199 200 201 202 203 204 205 206 207
        208 209
        <br>
                       210 211 212 213 214 215 216 217 218 219 220 221
        222 223
        <br>
          node 3 size: 885394 MB
        <br>
          node 3 free: 884033 MB
        <br>
        <br>
        The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2
        GPUs
        <br>
        (nodes 4 and 5), each CPU node with correct core and memory
        counts:
        <br>
        <br>
          /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
        <br>
        <br>
          0: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
        <br>
          1: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
        <br>
          2: cpu_cores_count 56  mem_banks_count 1 io_links_count 2
        <br>
          3: cpu_cores_count 56  mem_banks_count 1 io_links_count 0
        <br>
          4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
        <br>
          5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
        <br>
        <br>
        RCCL unit tests — 948 cases, all PASS:
        <br>
        <br>
        ---
        <br>
        Test environment — discontiguous NUMA (3 nodes: 0, 2-3)
        <br>
        --------------------------------------------------------
        <br>
        <br>
        numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3 are
        <br>
        CPU-less and memory-less:
        <br>
        <br>
          $ numactl -H
        <br>
          available: 3 nodes (0,2-3)
        <br>
          node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
        20 21
        <br>
                       22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
        38 39
        <br>
          node 0 size: 519305 MB
        <br>
          node 0 free: 504963 MB
        <br>
          node 2 cpus: (none)
        <br>
          node 2 size: 0 MB
        <br>
          node 2 free: 0 MB
        <br>
          node 3 cpus: (none)
        <br>
          node 3 size: 0 MB
        <br>
          node 3 free: 0 MB
        <br>
        <br>
        After this patch series the KFD topology sysfs correctly
        preserves the
        <br>
        NUMA node IDs as proximity domains. Node 1 appears as an empty
        <br>
        placeholder, nodes 2 and 3 have no cores or memory banks but
        carry the
        <br>
        GPU IO links, and both GPUs correctly reference node 2 as their
        attached
        <br>
        CPU-less domain:
        <br>
        <br>
          /sys/class/kfd/kfd/topology/nodes: 0  1  2 3  4  5
        <br>
        <br>
          0: cpu_cores_count 40  mem_banks_count 1 io_links_count 0
        <br>
          1: cpu_cores_count  0  mem_banks_count 0 io_links_count 0
        (absent,
        <br>
        placeholder)
        <br>
          2: cpu_cores_count  0  mem_banks_count 0 io_links_count 2
        (CPU-less,
        <br>
        GPUs attached)
        <br>
          3: cpu_cores_count  0  mem_banks_count 0 io_links_count 0
        (CPU-less)
        <br>
          4: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
        <br>
          5: cpu_cores_count  0  simd_count 416  io_links_count 1  (GPU)
        <br>
        <br>
          node 4 io_link: node_from 4  node_to 2 type 2  max_bandwidth
        10000
        <br>
          node 5 io_link: node_from 5  node_to 2 type 2  max_bandwidth
        10000
        <br>
        <br>
        RCCL unit tests — 948 cases, all PASS:
        <br>
        <br>
        We fully understand your concern about regressions. We would
        <br>
        greatly appreciate it if someone with access to the systems you
        mentioned
        <br>
        could test this series, and we are very happy to make any
        adjustments
        <br>
        based on that feedback.
        <br>
        <br>
        Regards,
        <br>
        Dhruv
        <br>
        <br>
        <blockquote type="cite">
          <br>
          That said, the patch series looks good to me now, in theory.
          <br>
          <br>
          Regards,
          <br>
            Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Co-developed-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
            <br>
            Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
            <br>
            Signed-off-by: Dhruv B <a class="moz-txt-link-rfc2396E" href="mailto:dhruv.b@linux.ibm.com">&lt;dhruv.b@linux.ibm.com&gt;</a>
            <br>
            ---
            <br>
              drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40
            +++++++++++++++------------
            <br>
              1 file changed, 22 insertions(+), 18 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
            <br>
            b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
            <br>
            index 7dad8f30ff2a..329931b0edc6 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
            <br>
            @@ -1944,28 +1944,32 @@ static int
            kfd_create_vcrat_image_cpu(void
            <br>
            *pcrat_image, size_t *size)
            <br>
                      }
            <br>
                        /* Fill in Subtype: Compute Unit */
            <br>
            -        ret = kfd_fill_cu_for_cpu(numa_node_id,
            &amp;avail_size,
            <br>
            -            crat_table-&gt;num_domains,
            <br>
            -            (struct crat_subtype_computeunit
            *)sub_type_hdr);
            <br>
            -        if (ret &lt; 0)
            <br>
            -            return ret;
            <br>
            -        crat_table-&gt;length += sub_type_hdr-&gt;length;
            <br>
            -        crat_table-&gt;total_entries++;
            <br>
            +        if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
            <br>
            +            ret = kfd_fill_cu_for_cpu(numa_node_id,
            &amp;avail_size,
            <br>
            +                          crat_table-&gt;num_domains,
            <br>
            +                          (struct crat_subtype_computeunit
            <br>
            *)sub_type_hdr);
            <br>
            +            if (ret &lt; 0)
            <br>
            +                return ret;
            <br>
            +            crat_table-&gt;length +=
            sub_type_hdr-&gt;length;
            <br>
            +            crat_table-&gt;total_entries++;
            <br>
              -        sub_type_hdr = (typeof(sub_type_hdr))((char
            *)sub_type_hdr +
            <br>
            -            sub_type_hdr-&gt;length);
            <br>
            +            sub_type_hdr = (typeof(sub_type_hdr))((char
            <br>
            *)sub_type_hdr +
            <br>
            +                sub_type_hdr-&gt;length);
            <br>
            +        }
            <br>
                        /* Fill in Subtype: Memory */
            <br>
            -        ret = kfd_fill_mem_info_for_cpu(numa_node_id,
            &amp;avail_size,
            <br>
            -            crat_table-&gt;num_domains,
            <br>
            -            (struct crat_subtype_memory *)sub_type_hdr);
            <br>
            -        if (ret &lt; 0)
            <br>
            -            return ret;
            <br>
            -        crat_table-&gt;length += sub_type_hdr-&gt;length;
            <br>
            -        crat_table-&gt;total_entries++;
            <br>
            +        if (node_state(numa_node_id, N_MEMORY)) {
            <br>
            +            ret = kfd_fill_mem_info_for_cpu(numa_node_id,
            &amp;avail_size,
            <br>
            +                            crat_table-&gt;num_domains,
            <br>
            +                            (struct crat_subtype_memory
            <br>
            *)sub_type_hdr);
            <br>
            +            if (ret &lt; 0)
            <br>
            +                return ret;
            <br>
            +            crat_table-&gt;length +=
            sub_type_hdr-&gt;length;
            <br>
            +            crat_table-&gt;total_entries++;
            <br>
              -        sub_type_hdr = (typeof(sub_type_hdr))((char
            *)sub_type_hdr +
            <br>
            -            sub_type_hdr-&gt;length);
            <br>
            +            sub_type_hdr = (typeof(sub_type_hdr))((char
            <br>
            *)sub_type_hdr +
            <br>
            +                sub_type_hdr-&gt;length);
            <br>
            +        }
            <br>
                        /* Fill in Subtype: IO Link */
            <br>
              #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------gcsgMRosat7JeDWSBc69d6nV--

