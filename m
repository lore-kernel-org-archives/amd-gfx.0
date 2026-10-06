Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16FDCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3129210F5B3;
	Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="BSHTZ1Ft";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED5510E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 12:32:06 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BZTpe1804981; Tue, 6 Oct 2026 12:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kL1btm
 mtGMJvDCfMlB2ePjrUdzTqT+afmq+zLEgQ1ik=; b=BSHTZ1FtLxL9zZhcxfPNxU
 AansVh7qYHzt3rosEnpoMOJQY6ntBa0F1rmA669QaDFj0WLFtaq09YNsvF32Gg74
 qLGlxLqGIRHpQU4uDtOfCTl7y37uU/gF8BV6lbUO2TbyLlW7SrJEYubakVqRu2Qu
 N46lSHfAYcsZJFoRc+2xUDhlAhgBu4s6O7/S6lxXtCrcKBj29Z9CCcqOOJ55N67j
 8rQgPv75v0o7AuGJcdWbKDjhOSMNtrEwMUQOwxF59Y8CvHtcZhN/5psRbzOBfCMf
 SCDoMUxQUkpPi6jug3MT64RzdFOngShbd4GfomKydcE+csDLh7wASLVqA2KI0fzg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrfw0a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:32:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BWVXQ227907; Tue, 6 Oct 2026 12:32:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pt1x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:32:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696CW2Yh6292016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 12:32:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B06958062;
 Tue,  6 Oct 2026 12:32:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A138B58052;
 Tue,  6 Oct 2026 12:31:57 +0000 (GMT)
Received: from [9.123.4.213] (unknown [9.123.4.213])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 12:31:57 +0000 (GMT)
Message-ID: <7c4cfc5e-5b92-4d8b-bdf9-75a854d62772@linux.ibm.com>
Date: Tue, 6 Oct 2026 18:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: Add support for discontiguous NUMA node
 topology
To: Felix Kuehling <felix.kuehling@amd.com>, Dhruv B <dhruv.b@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
 <b167aff82d52fde5bf1568ac886bc80b042a10a1.1791208447.git.dhruv.b@linux.ibm.com>
 <7b32f88e-4038-4b8a-81f0-5a19469a9899@amd.com>
Content-Language: en-US
From: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>
In-Reply-To: <7b32f88e-4038-4b8a-81f0-5a19469a9899@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX9dG5IBQ2VwXv
 9VBvapbTpTztNTs+9NJRDDn7oyUz3EJ4rjSq9+44qq/IzOGsRNpqaeHLdrYbD+fglqaJDyODtTP
 76tOyCsMYLbyWkf03rg0Q33ApwCYVWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX8of9NLNjTg9/
 qUUUy7XStnAt+teTrnGNADMV2QU5f9vaIbwzWpHa+gnjqdaW4rW8ty+3Wjx4O9F+h+lVG6czJ5m
 /mZGqowWdsNdy6B0K/yEIxtn6mikY038eaF3ju5V8JnpjfF0Ggl8/j4OPZJ+iW7iGG/TWbA0IRd
 LTCRq2PdUn+oIOUBRecA4iawHtmERsA96FVk4VzUHLzUwL6SeaSiwbANUWhbObQ7pWhOtUTAKkW
 ZTEDbIfY3BEhJ+PBO1bcAFxP8ke/petxmh50IARsKE/96Z0z7isR8VvRe7hZvksCS6/rk5C12sD
 sxG7o/fjuuKdRKvQHjeUIK428SWXMgJVyA5oIKRFlZ96eMzd+seggYadr0nCsvu8hGPPGdR0h9a
 IASq4sOU5hHSc2ZisERTboWzmKE1BeAZ9Odo7m+y5M8V+iyrCDLYes+7D4h+h7cOahDjRzijWNY
 uHadoAJp20wt2ti7Oaw==
X-Proofpoint-GUID: Mldppb5HNLfnWzJyF4xP4iLtWtFKCrp6
X-Proofpoint-ORIG-GUID: r68uptjyEHY_GJReriQ-Gj-NEDGn977H
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4ea44 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7HFmxy_FuCrxImmKOzQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
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


On 06/10/26 01:48, Felix Kuehling wrote:
> On 2026-10-05 10:00, Dhruv B wrote:
>> On systems with discontiguous NUMA nodes, the GPU driver fails to load
>> with the following errors:
>>
>> [    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
>> [    5.609781] kfd kfd: Error adding device to topology
>> [    5.609848] kfd kfd: Error initializing KFD node
>>
>> In the current KFD code, proximity domains are created contiguously
>> when generating the VCRAT. With discontiguous NUMA node IDs, this
>> creates a mismatch between the proximity domain ID and the NUMA node ID.
>> For example, if NUMA nodes 0, 2 and 3 are online, the current code
>> assigns proximity domains 0, 1 and 2 to these nodes respectively,
>> instead of domains 0, 2 and 3.
>>
>> The KFD topology uses the NUMA node and proximity domain information to
>> create topology devices representing the CPU and memory resources
>> associated with each NUMA node. This topology is exposed to userspace
>> through sysfs, where the NUMA node and proximity domain information are
>> used to identify the topology devices. The mismatch between the NUMA
>> node ID and proximity domain therefore results in an inconsistent KFD
>> topology and causes topology parsing to fail.
>>
>> Make the proximity domain ID correspond directly to the NUMA node ID by
>> iterating through the complete NUMA node ID range up to the last online
>> node. Account for every node ID when assigning proximity domains, while
>> skipping resource entry creation for offline or unpopulated nodes.
>> This preserves the NUMA-node-to-proximity-domain mapping and allows the
>> KFD topology and its sysfs representation to correctly reflect
>> discontiguous NUMA topologies.
>>
>> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 99b0c7f825fe..d4739db1c14c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -1899,7 +1899,7 @@ static int kfd_create_vcrat_image_cpu(void 
>> *pcrat_image, size_t *size)
>>       acpi_status status;
>>       struct crat_subtype_generic *sub_type_hdr;
>>       int avail_size = *size;
>> -    int numa_node_id;
>> +    int numa_node_id, last_node;
>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>       uint32_t entries = 0;
>>   #endif
>> @@ -1935,9 +1935,12 @@ static int kfd_create_vcrat_image_cpu(void 
>> *pcrat_image, size_t *size)
>>       crat_table->num_domains = 0;
>>         sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
>> +    last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
>>   -    for_each_online_node(numa_node_id) {
>> -        if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>> +    for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
>> +        crat_table->num_domains++;
>
> Doing this at the beginning of the loop body, doesn't that result in 
> an incorrect proximity_domain being used in kfd_fill_cu_for_cpu? E.g. 
> the first CPU will get proximity_domain 1 instead of 0.


Thanks for pointing this out, Felix. Apologies, we missed this when 
making the change.

I'll correct this and will post a new version with the corrected changes.

Thanks,
Dhruv B


>
>
> Regards,
>   Felix
>
>
>> +
>> +        if (!node_online(numa_node_id))
>>               continue;
>>             /* Fill in Subtype: Compute Unit */
>> @@ -1982,8 +1985,6 @@ static int kfd_create_vcrat_image_cpu(void 
>> *pcrat_image, size_t *size)
>>   #else
>>           pr_info("IO link not available for non x86 platforms\n");
>>   #endif
>> -
>> -        crat_table->num_domains++;
>>       }
>>         /* TODO: Add cache Subtype for CPU.
