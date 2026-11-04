Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E790606A32C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=reHeiPrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142B211247D;
	Thu,  5 Nov 2026 13:45:48 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CA710E8DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:12:26 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj77w1189448; Wed, 4 Nov 2026 19:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5fPh+pfXZTmkX3T851WZLUYAW4j1ZC
 b48HYamoQyufM=; b=reHeiPrfA5kaFHSlRP8jTikbxQpbW9nP1n9QhDqphGMhlB
 aAWKyEh8Bu1Y4kNxmhMjumRmY1sWk13DpjXGO6kMyrgTMpRNQEpMIfV8whFCTOBB
 rr+ZupbrQduhUHhf1djaZDTaeQ8XVfoKLV0vF0Pzxd4+vDWLMMNqPH3giqoT8Af3
 kA29x5wWIwDtYbLUJUh4pjEnJ8Ixmg7vv4aZZer+Ze1I+FS3ktBEz5+YRiwipyYJ
 o5eW/rSUtKWACr8/ucXnjfUStYgHZ86oNSGpX64bq2yUCv9VYnjelT4nTLZZ3Qx8
 ZP01mn6XaZMWGOlajoYYK1qUliQwRIWCHn3dK2DA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3nwr6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:12:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4ITHRc232342; Wed, 4 Nov 2026 19:12:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5h1drc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:12:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A4JCJg732113214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2026 19:12:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51FF85803F;
 Wed,  4 Nov 2026 19:12:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10EA55805A;
 Wed,  4 Nov 2026 19:12:14 +0000 (GMT)
Received: from [9.43.118.53] (unknown [9.43.118.53])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Nov 2026 19:12:13 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------zcNm7SB8aeT02GR0QGedewSR"
Message-ID: <d05d2131-8559-4c1c-a412-7570a4f0101a@linux.ibm.com>
Date: Thu, 5 Nov 2026 00:42:12 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: Add support for discontiguous and
 CPU-less NUMA topologies
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Dhruv B <dhruv.b@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
References: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
 <20261030083304.9767-3-dhruv.b@linux.ibm.com>
 <70018014-d952-4155-aa36-cf9b39ba8aea@amd.com>
 <1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com>
 <04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com>
 <64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com>
 <4751bd8c-91e8-4985-bdac-52e35ba7f513@amd.com>
Content-Language: en-US
From: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>
In-Reply-To: <4751bd8c-91e8-4985-bdac-52e35ba7f513@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aeb8396 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=RpNjiQI2AAAA:8
 a=VnNF1IyMAAAA:8 a=OnU8845ZNW8q8RRgSkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zd2uoN0lAAAA:8 a=JdIoNKOzngq7Mgm-rNAA:9 a=tqdMzFhGG8mD8GCBlf4leDhY3gs=:19
 a=sTxRpBpiy98KL1WkT8X2XIWo+SM=:19 a=qCLHsqe_nAgSfvew:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: _DiocADrib6FtMm0_Vs1014aoVJJe-Sk
X-Proofpoint-GUID: E6maiqd8Xi9erkcMhW-uCYgCJks57Aod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX7kUguzSYm97y
 UVcdk95hiFnpexXHSdaYw+kW48IqQibjn0QiPOH3rxOqIPCYMcwRqdkSC6B/NK6o0ogQuV2oaMY
 yjKZQ9HPJ92+8IvKznyDrYk3W7nzxXwKRjpwt8paIVMABIrngP9I9GqGnyL/DL5YRrxOvNDf7zZ
 1gBZyaioeKV5h0r4Iqo0W8MChugw8P/HTye4nThZw1mS8gCAOd90gZzoHlNhF7zuwCN7fVt3/nI
 JgAU5CeBHpUXHlOQ4Ttwx7Q74wlC+3rLq5n4yzPDUyyhAQmpYnFNWHCp+L0kdgBr54rvaIgqn/e
 MPlJYFQBDV8mcnaIELaxuhUSn/I579qHj35X9zjLZDHiWXyxoAnwtGMDGZR/jehphIFtcteSIKc
 WumB62olXcRQUdxuL1Uodh0szpRWjfoIynsVETF0/dF8/+Im/jvHzcQ8aIdCKunV+EGy/4CUkwo
 T5MJkQpcFuUT9A4GwzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX48kBXZpv1EWh
 SRiba0vrQtxsA+XJnMVzakW/gfbEeMgB1KUu2GsuQT6CRfZsT3W+YAI3fLsQ2AgqCHtRL2mc7Ng
 QNQn0noK2NP+ZkOFHGrdfDYXZAIWWRQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040074
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------zcNm7SB8aeT02GR0QGedewSR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 05/11/26 00:24, Kuehling, Felix wrote:
> On 2026-11-04 12:=E2=80=8A00, Dhruv Bhogaonkar wrote: On 04/11/26 20:=E2=
=80=8A56,=20
> Kuehling, Felix wrote: On 2026-11-04 08: 41, Dhruv Bhogaonkar wrote:=20
> On 03/11/26 05: 55, Felix Kuehling wrote: On 2026-10-30 04: 33, Dhruv=20
> B wrote: On systems with discontiguous
>=20
>
>
> On 2026-11-04 12:00, Dhruv Bhogaonkar wrote:
>>
>>
>> On 04/11/26 20:56, Kuehling, Felix wrote:
>>> On 2026-11-04 08:=E2=80=8A41, Dhruv Bhogaonkar wrote: On 03/11/26 05:=
=E2=80=8A55,=20
>>> Felix Kuehling wrote: On 2026-10-30 04: 33, Dhruv B wrote: On=20
>>> systems with discontiguous NUMA node IDs, the GPU driver fails to=20
>>> load with the following errors: [ 5. 609767] amdgpu
>>> On 2026-11-04 08:41, Dhruv Bhogaonkar wrote:
>>>>
>>>>
>>>> On 03/11/26 05:55, Felix Kuehling wrote:
>>>>> On 2026-10-30 04:=E2=80=8A33, Dhruv B wrote: On systems with disconti=
guous=20
>>>>> NUMA node IDs, the GPU driver fails to load with the following=20
>>>>> errors: [ 5.=E2=80=8A609767] amdgpu 0038:=E2=80=8A12:=E2=80=8A00.=E2=
=80=8A0: Error parsing VCRAT [=20
>>>>> 5.=E2=80=8A609781] kfd kfd: Error adding device to topology
>>>>> On 2026-10-30 04:33, Dhruv B wrote:
>>>>>> On systems with discontiguous NUMA node IDs, the GPU driver fails to
>>>>>> load with the following errors:
>>>>>>
>>>>>> [    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
>>>>>> [    5.609781] kfd kfd: Error adding device to topology
>>>>>> [    5.609848] kfd kfd: Error initializing KFD node
>>>>>>
>>>>>> In the current KFD code, proximity domains are created contiguously
>>>>>> when generating the VCRAT. With discontiguous NUMA node IDs, this
>>>>>> creates a mismatch between the proximity domain ID and the NUMA node=
 ID.
>>>>>> For example, if NUMA nodes 0, 2 and 3 are online, the current code
>>>>>> assigns proximity domains 0, 1 and 2 to these nodes respectively,
>>>>>> instead of domains 0, 2 and 3.
>>>>>>
>>>>>> The KFD topology uses the NUMA node and proximity domain information=
 to
>>>>>> create topology devices representing the CPU and memory resources
>>>>>> associated with each NUMA node. This topology is exposed to userspace
>>>>>> through sysfs, where the NUMA node and proximity domain information =
are
>>>>>> used to identify the topology devices. The mismatch between the NUMA
>>>>>> node ID and proximity domain therefore results in an inconsistent KFD
>>>>>> topology and causes topology parsing to fail.
>>>>>>
>>>>>> Make the proximity domain ID correspond directly to the NUMA node ID=
 by
>>>>>> iterating through the complete NUMA node ID range up to the last onl=
ine
>>>>>> node. Account for every node ID when assigning proximity domains, wh=
ile
>>>>>> skipping resource entry creation for offline nodes. This preserves t=
he
>>>>>> NUMA-node-to-proximity-domain mapping and allows the KFD topology and
>>>>>> its sysfs representation to correctly reflect discontiguous NUMA
>>>>>> topologies.
>>>>>>
>>>>>> A NUMA node may also be CPU-less, memory-less, or both. Only create a
>>>>>> Compute Unit CRAT entry if the node has CPUs, and only create a Memo=
ry
>>>>>> CRAT entry if the node has memory.
>>>>>>
>>>>>> Additionally, update kfd_parse_subtype_mem() to use simd_count inste=
ad
>>>>>> of cpu_cores_count to distinguish host nodes from GPU nodes. This en=
sures
>>>>>> that memory on CPU-less host NUMA nodes is correctly classified as
>>>>>> system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
>>>>>> framebuffer memory.
>>>>>>
>>>>>> The placeholder domains created for offline node IDs have no IO link=
s,
>>>>>> so skip offline and CPU-less nodes when building the indirect GPU to=
 CPU
>>>>>> links.
>>>>>>
>>>>>> Co-developed-by: Donet Tom<donettom@linux.ibm.com>
>>>>>> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
>>>>>> Signed-off-by: Dhruv B<dhruv.b@linux.ibm.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++------=
----
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
>>>>>>   2 files changed, 36 insertions(+), 26 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_crat.c
>>>>>> index 99b0c7f825fe..bebbc6715b2f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> @@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_=
subtype_memory *mem,
>>>>>>   			mem->proximity_domain);
>>>>>>   	list_for_each_entry(dev, device_list, list) {
>>>>>>   		if (mem->proximity_domain =3D=3D dev->proximity_domain) {
>>>>>> -			/* We're on GPU node */
>>>>>> -			if (dev->node_props.cpu_cores_count =3D=3D 0) {
>>>>>> +			if (dev->node_props.simd_count =3D=3D 0) {
>>>>>> +				heap_type =3D HSA_MEM_HEAP_TYPE_SYSTEM;
>>>>>> +			} else {
>>>>>> +				/* We're on GPU node */
>>>>>>   				/* APU */
>>>>>>   				if (mem->visibility_type =3D=3D 0)
>>>>>>   					heap_type =3D
>>>>>> @@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_s=
ubtype_memory *mem,
>>>>>>   				/* dGPU */
>>>>>>   				else
>>>>>>   					heap_type =3D mem->visibility_type;
>>>>>> -			} else
>>>>>> -				heap_type =3D HSA_MEM_HEAP_TYPE_SYSTEM;
>>>>>> +			}
>>>>>>  =20
>>>>>>   			if (mem->flags & CRAT_MEM_FLAGS_HOT_PLUGGABLE)
>>>>>>   				flags |=3D HSA_MEM_FLAGS_HOT_PLUGGABLE;
>>>>>> @@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pc=
rat_image, size_t *size)
>>>>>>   	acpi_status status;
>>>>>>   	struct crat_subtype_generic *sub_type_hdr;
>>>>>>   	int avail_size =3D *size;
>>>>>> -	int numa_node_id;
>>>>>> +	int numa_node_id, last_node;
>>>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>>>>>   	uint32_t entries =3D 0;
>>>>>>   #endif
>>>>>> @@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *=
pcrat_image, size_t *size)
>>>>>>   	crat_table->num_domains =3D 0;
>>>>>>  =20
>>>>>>   	sub_type_hdr =3D (struct crat_subtype_generic *)(crat_table+1);
>>>>>> +	last_node =3D find_last_bit(node_online_map.bits, MAX_NUMNODES);
>>>>>>  =20
>>>>>> -	for_each_online_node(numa_node_id) {
>>>>>> -		if (kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1)
>>>>>> +	for (numa_node_id =3D 0; numa_node_id <=3D last_node; numa_node_id=
++) {
>>>>>> +		if (!node_online(numa_node_id)) {
>>>>>> +			crat_table->num_domains++;
>>>>>>   			continue;
>>>>>> +		}
>>>>>>  =20
>>>>>>   		/* Fill in Subtype: Compute Unit */
>>>>>> -		ret =3D kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>>> -			crat_table->num_domains,
>>>>>> -			(struct crat_subtype_computeunit *)sub_type_hdr);
>>>>>> -		if (ret < 0)
>>>>>> -			return ret;
>>>>>> -		crat_table->length +=3D sub_type_hdr->length;
>>>>>> -		crat_table->total_entries++;
>>>>>> +		if (kfd_numa_node_to_apic_id(numa_node_id) !=3D -1) {
>>>>>> +			ret =3D kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>>> +						  crat_table->num_domains,
>>>>>> +						  (struct crat_subtype_computeunit *)sub_type_hdr);
>>>>>> +			if (ret < 0)
>>>>>> +				return ret;
>>>>>> +			crat_table->length +=3D sub_type_hdr->length;
>>>>>> +			crat_table->total_entries++;
>>>>>>  =20
>>>>>> -		sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>>> -			sub_type_hdr->length);
>>>>>> +			sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>>> +				sub_type_hdr->length);
>>>>>> +		}
>>>>>>  =20
>>>>>>   		/* Fill in Subtype: Memory */
>>>>>> -		ret =3D kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>>>> -			crat_table->num_domains,
>>>>>> -			(struct crat_subtype_memory *)sub_type_hdr);
>>>>>> -		if (ret < 0)
>>>>>> -			return ret;
>>>>>> -		crat_table->length +=3D sub_type_hdr->length;
>>>>>> -		crat_table->total_entries++;
>>>>>> +		if (node_state(numa_node_id, N_MEMORY)) {
>>>>>> +			ret =3D kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
>>>>>> +							crat_table->num_domains,
>>>>>> +							(struct crat_subtype_memory *)sub_type_hdr);
>>>>>> +			if (ret < 0)
>>>>>> +				return ret;
>>>>>> +			crat_table->length +=3D sub_type_hdr->length;
>>>>>> +			crat_table->total_entries++;
>>>>>>  =20
>>>>>> -		sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>>> -			sub_type_hdr->length);
>>>>>> +			sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
>>>>>> +				sub_type_hdr->length);
>>>>>> +		}
>>>>>>  =20
>>>>>>   		/* Fill in Subtype: IO Link */
>>>>>>   #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>>>>> @@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pc=
rat_image, size_t *size)
>>>>>>   #else
>>>>>>   		pr_info("IO link not available for non x86 platforms\n");
>>>>>>   #endif
>>>>>> -
>>>>>>   		crat_table->num_domains++;
>>>>>>   	}
>>>>>>  =20
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_topology.c
>>>>>> index b38d12f3da84..d2fbe73e57ef 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>>>> @@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struc=
t kfd_topology_device *kdev, int g
>>>>>>   				    struct kfd_iolink_properties, list);
>>>>>>  =20
>>>>>>   	for (i =3D 0; i < num_cpu; i++) {
>>>>>> +		if (!node_online(i) || !node_state(i, N_CPU))
>>>>>
>>>>> The N_CPU part skips indirect links through CPU-less NUMA nodes.=20
>>>>> Is that correct? For links from the GPU to that memory, I think we=20
>>>>> need the indirect links so the GPU knows that it can access such=20
>>>>> memory.
>>>>>
>>>>> Maybe further down we could enhance the large-bar condition to=20
>>>>> only create indirect CPU->GPU links if that node actually has a CPU:
>>>>>
>>>>>                  /* for small Bar or CPU-less NUMA nodes, no CPU --> =
GPU in-direct links */
>>>>>                  if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i,=
 N_CPU)) {
>>>>> 			...
>>>>
>>>>
>>>> Hi Felix,
>>>>
>>>> Thanks a lot for the reply and the suggestion!
>>>>
>>>> Would the following change address your concern? I've removed the
>>>> |N_CPU|check from the loop condition and moved it to the large-BAR
>>>> check so that we retain the indirect links for CPU-less NUMA nodes
>>>> while avoiding CPU =E2=86=92 GPU indirect links for those nodes.
>>>
>>> Yes, this look good. I have one question inline.
>>>
>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=20
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> index b38d12f3da84..8f908323d74b 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> @@ -1419,6 +1419,9 @@ static int=20
>>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0struct kfd_iolink_properties, list);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < num_cpu; i++) {
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node_online(i))
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>>>> +
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU <--> GPU */
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gpu_link->node_to =3D=3D i)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;
>>>> @@ -1437,7 +1440,7 @@ static int=20
>>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_link)
>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>>>
>>> I think I'm fine with this change. But the fact that you need this=20
>>> tells me that you have some weird topology where the CPUs (and=20
>>> CPU-less memory-only) NUMA nodes aren't fully connected. How does=20
>>> that happen? Does that point at some problem elsewhere?
>>>
>> Hi Felix,
>> Thanks for the feedback!
>>
>> Actually the main reason for the change was:
>>
>> In|kfd_create_vcrat_image_cpu()|, CPU-to-CPU IO link
>> generation is wrapped in|#if defined(CONFIG_X86_64)|.
>> Consequently,|kfd_fill_iolink_info_for_cpu()|is not
>> compiled on non-x86 platforms, leaving
>> |cpu_dev->io_link_props|empty for all host nodes.
>>
>>  1. For example, on a multi-node non-x86 system where the
>>     GPU is attached to node 2 and CPUs are present on node 0,
>>     |cpu_link|will be NULL.
>>     Returning|-ENOMEM|in this case causes
>>     |kfd_dev_create_p2p_links()|to abort early, potentially
>>     preventing subsequent GPU-to-GPU P2P links from being
>>     created through|kfd_add_peer_prop()|.
>>
>> If you are okay with these changes, can I post the
>> next version incorporating them?
>
> Yes. Thanks for the clarification. If the lack of CPU-CPU links on=20
> non-x86 CPUs is a problem, I'd also be open to a fix for that. Up to you.
>

Thanks a lot, Felix, for the suggestion and for being open to
looking into this!

We will look into adding CPU-to-CPU IO link support for
non-x86 architectures and post it as a separate follow-up
series in the near future.

For now, I have sent out v4 incorporating the discussed
fixes.

Thanks,
Dhruv B
>
> Thanks,
> =C2=A0 Felix
>
>
>>
>> Thanks,
>> Dhruv B
>>
>>
>>> Regards,
>>> =C2=A0 Felix
>>>
>>>
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU <--> CPU <--> GPU, GPU node*/
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0props =3D kfd_alloc_struct(props);
>>>> @@ -1459,8 +1462,8 @@ static int=20
>>>> kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>>>>
>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for small Bar, no CPU --> GPU in-direc=
t links */
>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kfd_dev_is_large_bar(kdev->gpu)) {
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for small Bar or CPU-less NUMA nodes, =
no CPU --> GPU=20
>>>> in-direct links */
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kfd_dev_is_large_bar(kdev->gpu) && no=
de_state(i, N_CPU)) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU <--> CPU <--> G=
PU, CPU node*/
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0props2 =3D kfd_alloc_s=
truct(props2);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!props2)
>>>> --=20
>>>>
>>>> Does this approach look good to you?
>>>>
>>>> Regards,
>>>> Dhruv B
>>>>
>>>>
>>>>> Regards,
>>>>> =C2=A0 Felix
>>>>>
>>>>>
>>>>>> +			continue;
>>>>>> +
>>>>>>   		/* CPU <--> GPU */
>>>>>>   		if (gpu_link->node_to =3D=3D i)
>>>>>>   			continue;=

--------------zcNm7SB8aeT02GR0QGedewSR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 05/11/26 00:24, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:4751bd8c-91e8-4985-bdac-52e35ba7f513@amd.com">
      <!-- BaNnErBlUrFlE-BoDy-start -->
      <!-- Preheader Text : BEGIN -->
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;">
        On 2026-11-04 12:=E2=80=8A00, Dhruv Bhogaonkar wrote: On 04/11/26
        20:=E2=80=8A56, Kuehling, Felix wrote: On 2026-11-04 08: 41, Dhruv
        Bhogaonkar wrote: On 03/11/26 05: 55, Felix Kuehling wrote: On
        2026-10-30 04: 33, Dhruv B wrote: On systems with discontiguous</di=
v>
      <!-- Preheader Text : END -->
      <!-- Email Banner : BEGIN -->
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;"></div>
      <!-- Email Banner : END -->
      <!-- BaNnErBlUrFlE-BoDy-end -->
      <!-- BaNnErBlUrFlE-HeAdEr-start -->
      <style>@scope { #pfptBannern99zqz3 { all: revert !important; display:=
 block !important;
    visibility: visible !important; opacity: 1 !important;
    background-color: #d0d8dc !important;
    max-width: none !important; max-height: none !important }.pfptPrimaryBu=
ttonn99zqz3:hover, .pfptPrimaryButtonn99zqz3:focus {
    background-color: #b4c1c7 !important; }.pfptPrimaryButtonn99zqz3:active=
 {
    background-color: #90a4ae !important; }html:root, html:root>body { all:=
 revert !important; display: block !important;
    visibility: visible !important; opacity: 1 !important; } }</style>
      <!-- BaNnErBlUrFlE-HeAdEr-end -->
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <p><br>
      </p>
      <div class=3D"moz-cite-prefix">On 2026-11-04 12:00, Dhruv Bhogaonkar
        wrote:<br>
      </div>
      <blockquote type=3D"cite"
        cite=3D"mid:64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com">
        <p><br>
        </p>
        <div class=3D"moz-cite-prefix">On 04/11/26 20:56, Kuehling, Felix
          wrote:<br>
        </div>
        <blockquote type=3D"cite"
          cite=3D"mid:04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com">
          <!-- BaNnErBlUrFlE-BoDy-start -->
          <!-- Preheader Text : BEGIN -->
          <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;">
            On 2026-11-04 08:=E2=80=8A41, Dhruv Bhogaonkar wrote: On 03/11/=
26
            05:=E2=80=8A55, Felix Kuehling wrote: On 2026-10-30 04: 33, Dhr=
uv B
            wrote: On systems with discontiguous NUMA node IDs, the GPU
            driver fails to load with the following errors: [ 5. 609767]
            amdgpu</div>
          <!-- Preheader Text : END -->
          <!-- Email Banner : BEGIN -->
          <!-- Email Banner : END -->
          <!-- BaNnErBlUrFlE-BoDy-end -->
          <!-- BaNnErBlUrFlE-HeAdEr-start -->
          <style>@scope {  }</style>
          <!-- BaNnErBlUrFlE-HeAdEr-end -->
          <div class=3D"moz-cite-prefix">On 2026-11-04 08:41, Dhruv
            Bhogaonkar wrote:<br>
          </div>
          <blockquote type=3D"cite"
cite=3D"mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com">
            <p><br>
            </p>
            <div class=3D"moz-cite-prefix">On 03/11/26 05:55, Felix
              Kuehling wrote:<br>
            </div>
            <blockquote type=3D"cite"
              cite=3D"mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
              <!-- BaNnErBlUrFlE-BoDy-start -->
              <!-- Preheader Text : BEGIN -->
              <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;">
                On 2026-10-30 04:=E2=80=8A33, Dhruv B wrote: On systems with
                discontiguous NUMA node IDs, the GPU driver fails to
                load with the following errors: [ 5.=E2=80=8A609767] amdgpu
                0038:=E2=80=8A12:=E2=80=8A00.=E2=80=8A0: Error parsing VCRA=
T [ 5.=E2=80=8A609781] kfd
                kfd: Error adding device to topology</div>
              <!-- Preheader Text : END -->
              <!-- Email Banner : BEGIN -->
              <!-- Email Banner : END -->
              <!-- BaNnErBlUrFlE-BoDy-end -->
              <!-- BaNnErBlUrFlE-HeAdEr-start -->
              <style>@scope {  }</style>
              <!-- BaNnErBlUrFlE-HeAdEr-end -->
              <div class=3D"moz-cite-prefix">On 2026-10-30 04:33, Dhruv B
                wrote:<br>
              </div>
              <blockquote type=3D"cite"
                cite=3D"mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
                <pre wrap=3D"" class=3D"moz-quote-pre">On systems with disc=
ontiguous NUMA node IDs, the GPU driver fails to
load with the following errors:

[    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
[    5.609781] kfd kfd: Error adding device to topology
[    5.609848] kfd kfd: Error initializing KFD node

In the current KFD code, proximity domains are created contiguously
when generating the VCRAT. With discontiguous NUMA node IDs, this
creates a mismatch between the proximity domain ID and the NUMA node ID.
For example, if NUMA nodes 0, 2 and 3 are online, the current code
assigns proximity domains 0, 1 and 2 to these nodes respectively,
instead of domains 0, 2 and 3.

The KFD topology uses the NUMA node and proximity domain information to
create topology devices representing the CPU and memory resources
associated with each NUMA node. This topology is exposed to userspace
through sysfs, where the NUMA node and proximity domain information are
used to identify the topology devices. The mismatch between the NUMA
node ID and proximity domain therefore results in an inconsistent KFD
topology and causes topology parsing to fail.

Make the proximity domain ID correspond directly to the NUMA node ID by
iterating through the complete NUMA node ID range up to the last online
node. Account for every node ID when assigning proximity domains, while
skipping resource entry creation for offline nodes. This preserves the
NUMA-node-to-proximity-domain mapping and allows the KFD topology and
its sysfs representation to correctly reflect discontiguous NUMA
topologies.

A NUMA node may also be CPU-less, memory-less, or both. Only create a
Compute Unit CRAT entry if the node has CPUs, and only create a Memory
CRAT entry if the node has memory.

Additionally, update kfd_parse_subtype_mem() to use simd_count instead
of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
that memory on CPU-less host NUMA nodes is correctly classified as
system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
framebuffer memory.

The placeholder domains created for offline node IDs have no IO links,
so skip offline and CPU-less nodes when building the indirect GPU to CPU
links.

Co-developed-by: Donet Tom <a class=3D"moz-txt-link-rfc2396E"
                href=3D"mailto:donettom@linux.ibm.com"
                moz-do-not-send=3D"true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Donet Tom <a class=3D"moz-txt-link-rfc2396E"
                href=3D"mailto:donettom@linux.ibm.com"
                moz-do-not-send=3D"true">&lt;donettom@linux.ibm.com&gt;</a>
Signed-off-by: Dhruv B <a class=3D"moz-txt-link-rfc2396E"
                href=3D"mailto:dhruv.b@linux.ibm.com"
                moz-do-not-send=3D"true">&lt;dhruv.b@linux.ibm.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 99b0c7f825fe..bebbc6715b2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype=
_memory *mem,
 			mem-&gt;proximity_domain);
 	list_for_each_entry(dev, device_list, list) {
 		if (mem-&gt;proximity_domain =3D=3D dev-&gt;proximity_domain) {
-			/* We're on GPU node */
-			if (dev-&gt;node_props.cpu_cores_count =3D=3D 0) {
+			if (dev-&gt;node_props.simd_count =3D=3D 0) {
+				heap_type =3D HSA_MEM_HEAP_TYPE_SYSTEM;
+			} else {
+				/* We're on GPU node */
 				/* APU */
 				if (mem-&gt;visibility_type =3D=3D 0)
 					heap_type =3D
@@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_=
memory *mem,
 				/* dGPU */
 				else
 					heap_type =3D mem-&gt;visibility_type;
-			} else
-				heap_type =3D HSA_MEM_HEAP_TYPE_SYSTEM;
+			}
=20
 			if (mem-&gt;flags &amp; CRAT_MEM_FLAGS_HOT_PLUGGABLE)
 				flags |=3D HSA_MEM_FLAGS_HOT_PLUGGABLE;
@@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_ima=
ge, size_t *size)
 	acpi_status status;
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size =3D *size;
-	int numa_node_id;
+	int numa_node_id, last_node;
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
 	uint32_t entries =3D 0;
 #endif
@@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_i=
mage, size_t *size)
 	crat_table-&gt;num_domains =3D 0;
=20
 	sub_type_hdr =3D (struct crat_subtype_generic *)(crat_table+1);
+	last_node =3D find_last_bit(node_online_map.bits, MAX_NUMNODES);
=20
-	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1)
+	for (numa_node_id =3D 0; numa_node_id &lt;=3D last_node; numa_node_id++) {
+		if (!node_online(numa_node_id)) {
+			crat_table-&gt;num_domains++;
 			continue;
+		}
=20
 		/* Fill in Subtype: Compute Unit */
-		ret =3D kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length +=3D sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (kfd_numa_node_to_apic_id(numa_node_id) !=3D -1) {
+			ret =3D kfd_fill_cu_for_cpu(numa_node_id, &amp;avail_size,
+						  crat_table-&gt;num_domains,
+						  (struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length +=3D sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
=20
-		sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
=20
 		/* Fill in Subtype: Memory */
-		ret =3D kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
-			crat_table-&gt;num_domains,
-			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret &lt; 0)
-			return ret;
-		crat_table-&gt;length +=3D sub_type_hdr-&gt;length;
-		crat_table-&gt;total_entries++;
+		if (node_state(numa_node_id, N_MEMORY)) {
+			ret =3D kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
+							crat_table-&gt;num_domains,
+							(struct crat_subtype_memory *)sub_type_hdr);
+			if (ret &lt; 0)
+				return ret;
+			crat_table-&gt;length +=3D sub_type_hdr-&gt;length;
+			crat_table-&gt;total_entries++;
=20
-		sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr-&gt;length);
+			sub_type_hdr =3D (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr-&gt;length);
+		}
=20
 		/* Fill in Subtype: IO Link */
 #if defined(CONFIG_X86_64) &amp;&amp; !defined(CONFIG_UML)
@@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_ima=
ge, size_t *size)
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-
 		crat_table-&gt;num_domains++;
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index b38d12f3da84..d2fbe73e57ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_t=
opology_device *kdev, int g
 				    struct kfd_iolink_properties, list);
=20
 	for (i =3D 0; i &lt; num_cpu; i++) {
+		if (!node_online(i) || !node_state(i, N_CPU))</pre>
              </blockquote>
              <p>The N_CPU part skips indirect links through CPU-less
                NUMA nodes. Is that correct? For links from the GPU to
                that memory, I think we need the indirect links so the
                GPU knows that it can access such memory.</p>
              <p>Maybe further down we could enhance the large-bar
                condition to only create indirect CPU-&gt;GPU links if
                that node actually has a CPU:</p>
              <pre>                /* for small Bar or CPU-less NUMA nodes,=
 no CPU --&gt; GPU in-direct links */
                if (kfd_dev_is_large_bar(kdev-&gt;gpu) &amp;&amp; node_stat=
e(i, N_CPU)) {
			...</pre>
            </blockquote>
            <p><br>
            </p>
            <font face=3D"monospace"><span>Hi Felix,<br>
              </span><br>
              <span>Thanks a lot for the reply and the suggestion!<br>
              </span><br>
              <span>Would the following change address your concern?
                I've removed the</span><br>
              <code dir=3D"ltr"><span>N_CPU</span></code><span><span
                  class=3D"Apple-converted-space">=C2=A0</span>check from t=
he
                loop condition and moved it to the large-BAR</span><span><b=
r>
                check so that we retain the indirect links for CPU-less
                NUMA nodes</span><br>
              <span>while avoiding CPU =E2=86=92 GPU indirect links for tho=
se
                nodes.<br>
              </span></font></blockquote>
          <p>Yes, this look good. I have one question inline.</p>
          <p><br>
          </p>
          <blockquote type=3D"cite"
cite=3D"mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font
              face=3D"monospace"><br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
              index b38d12f3da84..8f908323d74b 100644<br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
              @@ -1419,6 +1419,9 @@ static int
              kfd_create_indirect_link_prop(struct kfd_topology_device
              *kdev, int g<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct kfd_iolink_properties, list);<br>
              =C2=A0<br>
              =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_cpu; i++) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node_online(i))<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
              +<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU &lt;--&gt; GPU */<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gpu_link-&gt;node_to =
=3D=3D i)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
              @@ -1437,7 +1440,7 @@ static int
              kfd_create_indirect_link_prop(struct kfd_topology_device
              *kdev, int g<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              =C2=A0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cpu_link)<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
            </font></blockquote>
          <p>I think I'm fine with this change. But the fact that you
            need this tells me that you have some weird topology where
            the CPUs (and CPU-less memory-only) NUMA nodes aren't fully
            connected. How does that happen? Does that point at some
            problem elsewhere?</p>
        </blockquote>
        <font face=3D"monospace"><span>Hi Felix,</span><br>
          <span>Thanks for the feedback!<br>
            <br>
            Actually the main reason for the change was:<br>
            <br>
            In<span class=3D"Apple-converted-space">=C2=A0</span></span><co=
de
            dir=3D"ltr"><span>kfd_create_vcrat_image_cpu()</span></code><sp=
an>,
            CPU-to-CPU IO link</span><br>
          <span>generation is wrapped in<span
              class=3D"Apple-converted-space">=C2=A0</span></span><code
            dir=3D"ltr"><span>#if defined(CONFIG_X86_64)</span></code><span=
>.</span><br>
          <span>Consequently,<span class=3D"Apple-converted-space">=C2=A0</=
span></span><code
            dir=3D"ltr"><span>kfd_fill_iolink_info_for_cpu()</span></code><=
span><span
              class=3D"Apple-converted-space">=C2=A0</span>is not</span><br>
          <span>compiled on non-x86 platforms, leaving</span><br>
          <code dir=3D"ltr"><span>cpu_dev-&gt;io_link_props</span></code><s=
pan><span
              class=3D"Apple-converted-space">=C2=A0</span>empty for all ho=
st
            nodes.</span></font>
        <ol data-spread=3D"false" start=3D"1"
style=3D"caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-s=
ize: medium; font-style: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;">
          <li><font face=3D"monospace"><span>For example, on a multi-node
                non-x86 system where the</span><br>
              <span>GPU is attached to node 2 and CPUs are present on
                node 0,</span><br>
              <code dir=3D"ltr"><span>cpu_link</span></code><span><span
                  class=3D"Apple-converted-space">=C2=A0</span>will be NULL=
.</span><br>
              <span>Returning<span class=3D"Apple-converted-space">=C2=A0</=
span></span><code
                dir=3D"ltr"><span>-ENOMEM</span></code><span><span
                  class=3D"Apple-converted-space">=C2=A0</span>in this case
                causes</span><br>
              <code dir=3D"ltr"><span>kfd_dev_create_p2p_links()</span></co=
de><span><span
                  class=3D"Apple-converted-space">=C2=A0</span>to abort ear=
ly,
                potentially</span><br>
              <span>preventing subsequent GPU-to-GPU P2P links from
                being</span><br>
              <span>created through<span class=3D"Apple-converted-space">=
=C2=A0</span></span><code
                dir=3D"ltr"><span>kfd_add_peer_prop()</span></code><span>.<=
/span></font></li>
        </ol>
        <font face=3D"monospace"><span>If you are okay with these changes,
            can I post the</span><br>
          <span>next version incorporating them?<br>
          </span></font></blockquote>
      <p>Yes. Thanks for the clarification. If the lack of CPU-CPU links
        on non-x86 CPUs is a problem, I'd also be open to a fix for
        that. Up to you.</p>
    </blockquote>
    <p><br>
    </p>
    <font face=3D"monospace">Thanks a lot, Felix, for the suggestion and
      for being open to<br>
      looking into this!<br>
      <br>
      We will look into adding CPU-to-CPU IO link support for<br>
      non-x86 architectures and post it as a separate follow-up<br>
      series in the near future.<br>
      <br>
      For now, I have sent out v4 incorporating the discussed<br>
      fixes.<br>
      <br>
      Thanks,<br>
      Dhruv B</font>
    <blockquote type=3D"cite"
      cite=3D"mid:4751bd8c-91e8-4985-bdac-52e35ba7f513@amd.com">
      <p>Thanks,<br>
        =C2=A0 Felix</p>
      <p><br>
      </p>
      <blockquote type=3D"cite"
        cite=3D"mid:64a82e4a-2855-46f1-8942-3c1b6f8179f3@linux.ibm.com"><fo=
nt
          face=3D"monospace"><br>
          <span>Thanks,</span><br>
          <span>Dhruv B</span></font>
        <p><br>
        </p>
        <blockquote type=3D"cite"
          cite=3D"mid:04ddca6d-3880-48e0-a64e-a4bbde32e67e@amd.com">
          <p>Regards,<br>
            =C2=A0 Felix</p>
          <p><br>
          </p>
          <blockquote type=3D"cite"
cite=3D"mid:1c7751d3-ca7d-4a7b-91fa-87762af60095@linux.ibm.com"><font
              face=3D"monospace">=C2=A0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU &lt;--&gt; CPU &lt;-=
-&gt; GPU, GPU node*/<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0props =3D kfd_alloc_struct(=
props);<br>
              @@ -1459,8 +1462,8 @@ static int
              kfd_create_indirect_link_prop(struct kfd_topology_device
              *kdev, int g<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<b=
r>
              =C2=A0<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for small Bar, no CPU --&gt; =
GPU in-direct
              links */<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kfd_dev_is_large_bar(kdev-&g=
t;gpu)) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for small Bar or CPU-less NUM=
A nodes, no CPU
              --&gt; GPU in-direct links */<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kfd_dev_is_large_bar(kdev-&g=
t;gpu) &amp;&amp;
              node_state(i, N_CPU)) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPU &lt;--=
&gt; CPU &lt;--&gt; GPU, CPU
              node*/<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0props2 =3D kf=
d_alloc_struct(props2);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!props2)<=
br>
              --=C2=A0<br>
              <br>
              <span>Does this approach look good to you?<br>
              </span><br>
              <span>Regards,</span><br>
              <span>Dhruv B</span></font>
            <p><br>
            </p>
            <blockquote type=3D"cite"
              cite=3D"mid:70018014-d952-4155-aa36-cf9b39ba8aea@amd.com">
              <p>Regards,<br>
                =C2=A0 Felix</p>
              <p><br>
              </p>
              <blockquote type=3D"cite"
                cite=3D"mid:20261030083304.9767-3-dhruv.b@linux.ibm.com">
                <pre wrap=3D"" class=3D"moz-quote-pre">+			continue;
+
 		/* CPU &lt;--&gt; GPU */
 		if (gpu_link-&gt;node_to =3D=3D i)
 			continue;
</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------zcNm7SB8aeT02GR0QGedewSR--

