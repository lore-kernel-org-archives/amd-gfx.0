Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A7606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eh+24LTq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5EC1126B8;
	Fri, 30 Oct 2026 09:14:06 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E8C11268D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 08:39:38 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8EeAg2376878; Fri, 30 Oct 2026 08:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=4h8zXOxmdiIrSIIIIFAbQkDwrVWAvg
 RGit5mCU+iInE=; b=Eh+24LTqeKjMKx/viWthXrRk0LzM4N+tmyk0tdiR9HCxce
 y4SWSUVV4bNNPLAswbqx24Y6PAsRxPeYHtYJEbMpJaY2T9L4al/SZesR5Su5ar1A
 UXlwP2l/OxW9yX6ZaFX8/YEsUMWCmpqGTXf4JEUa4VPgULLZdVQVgsxLUzTGbt79
 jcg7ORfK9n4smNx6GSW9RvagVcxq8vmk6zamba1cEdpGpk6sFEMB4XcDtDR0wjwO
 maRWxkkNWmfDFD5SuQAfZrX5u0sXbQzBh9DbO2ADOCotxEAOyxa6QAfng27kHyjv
 oyf1fMZ0nM6ohGK65edj1JppDl4/nU1LKnIzHGyA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay1u08-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:39:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8JwCe297743; Fri, 30 Oct 2026 08:39:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm6pbbq65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:39:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69U8dWeZ27525658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 08:39:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 099A15805E;
 Fri, 30 Oct 2026 08:39:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2E7C58056;
 Fri, 30 Oct 2026 08:39:26 +0000 (GMT)
Received: from [9.123.11.4] (unknown [9.123.11.4])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 08:39:26 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------5fzz10HUUVdfz1Ph2Jx00LbQ"
Message-ID: <8419937c-f800-4872-b09e-40e9e1104d2b@linux.ibm.com>
Date: Fri, 30 Oct 2026 14:09:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Restrict CU and memory entries to
 resource nodes
To: Felix Kuehling <felix.kuehling@amd.com>, Dhruv B <dhruv.b@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
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
 <8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com>
 <f064e15c-7fe0-4e6f-a01f-7b50a6e77a81@amd.com>
Content-Language: en-US
From: Dhruv Bhogaonkar <dhruvb@linux.ibm.com>
In-Reply-To: <f064e15c-7fe0-4e6f-a01f-7b50a6e77a81@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Mk80gQD2AzYxcIlivxGbfzDTowhtMiVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfXwmoH4BES+/GG
 eTzmCDvMSuvjaMcjQEInWPiWfnBB73PFvwSYHmXYebPsvP9fe2MMhrMhvqzPMEvLT50DlWOJKqA
 rCqs3dr2ozfRINbW9oIblT/9fl+HO7GvNq7H1kz9gNNgt5VIhlbK0dDAWFys6aOZIWlIVERLIPf
 bPJRxvrEx0gipSY4VJgIRqyTa2cmgupKSbIRQ2xAm09gsPDVniU8wpUec7K+dxoGJz7QRDvl9Ow
 Xsi4+BFcSWR9CO0xTbTSl4mOKlYVIp2oJSnn3ZjQ2r+ymIfq1ZBxEEZyBOI02Kk6nQshKBg+SSH
 4OAhzA8bd9V5o/yZGBYE5sXeVwdupaq9hVTRZa6UOp0UzO9X9y8SGfBcoftP7Ia6bUzxQLqVF7E
 bbSiOGeEDwsxCTTtTP/aCaVdyV6ht1R2brOBjwDEC1LKVdPkz3oTrLJreJ/LBMXdYpK79ybZEPr
 OJm5va28l7sZ1W4/wkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX/S8GLMBWTzJb
 WH00nXoLdQQ2DdtmvOZRgqz6dOLfCMImKfymPiCxNyzBk0moxND1SECs45vma1s8qv/eC7q9JKl
 qSKpDbPP5UqZmo1thnOWtQDWnd3Np2s=
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ae457c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=RpNjiQI2AAAA:8
 a=_EeEMxcBAAAA:8 a=VnNF1IyMAAAA:8 a=KtkiOsJ62Gb8zp28YvUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zd2uoN0lAAAA:8 a=R6zti-N_oJsAuXyPo0IA:9
 a=tqdMzFhGG8mD8GCBlf4leDhY3gs=:19 a=sTxRpBpiy98KL1WkT8X2XIWo+SM=:19
 a=MtcTX9wBk6-28s7N:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: pk6uMLSqHPmdh_-2K5hNCQP19qILMbXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300032
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:13:37 +0000
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,WEIRD_PORT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------5fzz10HUUVdfz1Ph2Jx00LbQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 27/10/26 03:51, Felix Kuehling wrote:
> On 2026-10-26 14:=E2=80=8A07, Dhruv Bhogaonkar wrote: On 08/10/26 02:=E2=
=80=8A31,=20
> Kuehling, Felix wrote: On 2026-10-07 07:=E2=80=8A14, Dhruv Bhogaonkar wro=
te:=20
> [Some people who received this message don't often get email from=20
> dhruvb@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Acom. Learn why this is import=
ant
>=20
> On 2026-10-26 14:07, Dhruv Bhogaonkar wrote:
>>
>>
>> On 08/10/26 02:31, Kuehling, Felix wrote:
>>> On 2026-10-07 07:14, Dhruv Bhogaonkar wrote:
>>>> [Some people who received this message don't often get email from=20
>>>> dhruvb@linux.ibm.com. Learn why this is important at=20
>>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> On 07/10/26 01:30, Felix Kuehling wrote:
>>>>>
>>>>> On 2026-10-06 08:51, Dhruv B wrote:
>>>>>> In heterogeneous or non-uniform NUMA systems, a NUMA node may be
>>>>>> CPU-less, memory-less, or both CPU-less and memory-less.
>>>>>>
>>>>>> Previously, kfd_create_vcrat_image_cpu() assumed that every=20
>>>>>> online NUMA
>>>>>> node contained both compute units and memory, attempting to=20
>>>>>> create both
>>>>>> CU and memory CRAT entries unconditionally for every online node.
>>>>>>
>>>>>> Add explicit guards to:
>>>>>> 1. Only create Compute Unit CRAT entries if the NUMA node has valid
>>>>>> =C2=A0=C2=A0=C2=A0 CPU cores (kfd_numa_node_to_apic_id() !=3D -1).
>>>>>> 2. Only create Memory CRAT entries if the NUMA node actually=20
>>>>>> contains
>>>>>> =C2=A0=C2=A0=C2=A0 memory (node_state(numa_node_id, N_MEMORY)).
>>>>>>
>>>>>> This avoids emitting invalid or empty CRAT subtype entries for=20
>>>>>> CPU-less,
>>>>>> memory-less, or both CPU-less and memory-less NUMA nodes in=20
>>>>>> virtual CRAT
>>>>>> generation.
>>>>>
>>>>> @David Yat Sin, I think we currently support CPU-less and memory-less
>>>>> NUMA domains already. I know we have CPU-less NUMA domains on MI300A
>>>>> in NPS4/TPX mode. And I remember we've fixed bugs on NUMA CPU systems
>>>>> with only one DIMM populated, which would result in a memory-less=20
>>>>> NUMA
>>>>> domain.
>>>>>
>>>>> Therefore, I'm not sure whether this patch is really needed and=20
>>>>> I'd be
>>>>> concerned about introducing a regression. Is ROCr able to handle the
>>>>> changes being proposed here? David, could you take a look at this and
>>>>> maybe even test it, or find someone who could help test it on the
>>>>> system configurations I described?
>>>>
>>>> Thank you for the feedback, Felix. Apologies for the bug in v1 =E2=80=
=94
>>>> that was an oversight on our part.
>>>>
>>>> From the current code, the kfd_numa_node_to_apic_id() =3D=3D -1
>>>> continue causes the entire loop body to be skipped
>>>> for a CPU-less NUMA node:
>>>>
>>>> =C2=A0 for_each_online_node(numa_node_id) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kfd_numa_no=
de_to_apic_id(numa_node_id) =3D=3D -1)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fil=
l_cu_for_cpu(...);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fil=
l_mem_info_for_cpu(...);
>>>> =C2=A0 }
>>>>
>>>> When the loop body is skipped, neither a CU entry nor a memory=20
>>>> entry is
>>>> generated for that node, and no KFD topology device appears to be
>>>> registered for it from this code path. From our reading, it appears=20
>>>> that
>>>> CPU-less nodes are effectively absent from the generated VCRAT=20
>>>> topology
>>>> rather than being represented with an empty or placeholder entry.
>>>
>>> OK. I'm a bit surprised about that, because MI300A in NPS4 mode=20
>>> should have three CPU-less NUMA nodes per socket. Maybe we never=20
>>> depended on them being represented as CPU-less NUMA nodes in the KFD=20
>>> topology. Then this change should be an improvement because it=20
>>> removes some ambiguity between NUMA node numbers and KFD proximity=20
>>> domains.
>>>
>>>
>>>>
>>>>>
>>>>> @Dhruv B, how much testing have you done on this patch series. Given
>>>>> that the bug in patch 2 slipped through in v1, I'm worried that it's
>>>>> not very thorough.
>>>>
>>>> Regarding testing, on the userspace side we ran the RCCL unit tests.
>>>>
>>>> On the kernel side, we verified that the IO links are created=20
>>>> correctly
>>>> for both topologies by inspecting the KFD topology sysfs entries after
>>>> driver load.
>>>>
>>>> Here are the RCCL unit test results for both configurations, along=20
>>>> with
>>>> the corresponding numactl and KFD topology sysfs output observed after
>>>> driver load.
>>>
>>> Sounds good. We still need to test MI300A to make sure the changes=20
>>> don't confuse ROCr or amdsmi. Applications mostly shouldn't care=20
>>> because they don't use KFD topology node numbers directly. I'm told=20
>>> that most of the MI300A systems in production seem to use NPS1, so=20
>>> this shouldn't affect them.
>>
>>
>> Hi Felix,
>>
>> I wanted to ask if there have been any updates on the
>> patch series and whether anything would be required
>> from my=C2=A0side.
>>
> Thanks for the reminder. We did some testing of these patches and also=20
> considered what configurations of MI300A are actually deployed. An=20
> automated AI review caught two other problematic interactions in patch=20
> 2/3:
>
>     Phantom domains have a knock-on effect in kfd_topology.c:
>     kfd_create_indirect_link_prop() (kfd_topology.c:1421-1440) walks i
>     over every CPU-side topology device and does return -ENOMEM when
>     no matching cpu_link is found. A device synthesized for an offline
>     node has an empty io_link_props, so on an x86 box with a hole in
>     the node IDs and >1 GPU, kfd_dev_create_p2p_links() now bails out
>     and all indirect/P2P links are silently dropped (the return value
>     at kfd_topology.c:2077 is ignored). Worth either skipping
>     link-less CPU devices there or confirming this path was evaluated.
>
> And
>
>     Regression: the old loop body started with
>
>     |if (kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1) continue;|
>
>     and that guard is gone. For a node that is online but has no CPUs
>     (CXL / dax-kmem memory-only nodes, hotplug-added memory nodes, HBM
>     nodes), |cpumask_of_node()| is empty, so |kfd_fill_cu_for_cpu()|
>     hits the |processor_id_low =3D=3D -1| check at line 1791 and returns
>     -EINVAL. |kfd_create_vcrat_image_cpu()| propagates that at line
>     1951, producing exactly the "Error parsing VCRAT" / "Error
>     initializing KFD node" failure this patch is fixing =E2=80=94 just on=
 a
>     different machine.
>
>     Suggest folding the check into the skip condition so such nodes
>     still consume a proximity domain (which is what the commit message
>     describes):
>
>     |if (!node_online(numa_node_id) ||
>     kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1) {
>     crat_table->num_domains++; continue; }|
>
> I think that last suggestion is wrong though, because it basically=20
> defeats the purpose of that patch by skipping CPU-less NUMA domains.
>
> And one AI comment on patch 3/3:
>
>     Newly reachable misclassification. With this patch a
>     CPU-less-but-has-memory NUMA node (CXL/dax-kmem,
>     generic-initiator) now emits a Memory entry. On parse, that node's
>     topology device has |cpu_cores_count =3D=3D 0|, so this branch treats
>     it as a GPU node; |kfd_fill_mem_info_for_cpu()| memsets the entry
>     (line 1819) so |visibility_type =3D=3D 0|, and the heap is tagged
>     |HSA_MEM_HEAP_TYPE_FB_PRIVATE| instead of |HSA_MEM_HEAP_TYPE_SYSTEM|.
>
>     Result: host CXL/hotplug memory is exported to ROCr/Thunk as
>     private framebuffer on a node with no GPU. This path was
>     unreachable before because |kfd_fill_cu_for_cpu()| bailed with
>     -EINVAL.
>
>     |cpu_cores_count| is no longer a valid CPU-vs-GPU discriminator.
>     Suggest keying off GPU-ness instead, e.g.:
>
>     |if (dev->node_props.simd_count =3D=3D 0) heap_type =3D
>     HSA_MEM_HEAP_TYPE_SYSTEM; else if (mem->visibility_type =3D=3D 0)
>     heap_type =3D HSA_MEM_HEAP_TYPE_FB_PRIVATE; else heap_type =3D
>     mem->visibility_type;|
>
>     (GPU VCRAT emits the CU entry before the memory entries, so
>     |simd_count| is already populated when this runs.)
>
Thanks a lot for the review and feedback, Felix.
I have posted v3 of the patch series, with the
suggested changes.

Thanks,
Dhruv B
>
>
> Regards,
> =C2=A0 Felix
>
>
>> Thanks,
>> Dhruv B
>>
>>
>>>
>>>
>>> Regards,
>>> =C2=A0 Felix
>>>
>>>
>>>>
>>>> ---
>>>> Test environment =E2=80=94 contiguous NUMA (4 nodes, 0-3)
>>>> --------------------------------------------------
>>>>
>>>> numactl reports 4 contiguous nodes (0-3), all with CPUs and memory:
>>>>
>>>> =C2=A0 $ numactl -H
>>>> =C2=A0 available: 4 nodes (0-3)
>>>> =C2=A0 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38=20
>>>> 39 40
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
>>>> =C2=A0 node 0 size: 881496 MB
>>>> =C2=A0 node 0 free: 875909 MB
>>>> =C2=A0 node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72=
=20
>>>> 73 74
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91=20
>>>> 92 93
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 94 95 96 97 98 99 100 101 102 103 104 105 106 107=20
>>>> 108 109
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 110 111
>>>> =C2=A0 node 1 size: 885640 MB
>>>> =C2=A0 node 1 free: 883815 MB
>>>> =C2=A0 node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122 123 12=
4 125
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 126 127 128 129 130 131 132 133 134 135 136 137 138 139
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 140 141 142 143 144 145 146 147 148 149 150 151 152 153
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 154 155 156 157 158 159 160 161 162 163 164 165 166 167
>>>> =C2=A0 node 2 size: 885640 MB
>>>> =C2=A0 node 2 free: 874248 MB
>>>> =C2=A0 node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 18=
0 181
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 182 183 184 185 186 187 188 189 190 191 192 193 194 195
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 196 197 198 199 200 201 202 203 204 205 206 207 208 209
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 210 211 212 213 214 215 216 217 218 219 220 221 222 223
>>>> =C2=A0 node 3 size: 885394 MB
>>>> =C2=A0 node 3 free: 884033 MB
>>>>
>>>> The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2 GPUs
>>>> (nodes 4 and 5), each CPU node with correct core and memory counts:
>>>>
>>>> =C2=A0 /sys/class/kfd/kfd/topology/nodes: 0=C2=A0 1=C2=A0 2 3=C2=A0 4=
=C2=A0 5
>>>>
>>>> =C2=A0 0: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_count 0
>>>> =C2=A0 1: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_count 0
>>>> =C2=A0 2: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_count 2
>>>> =C2=A0 3: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_count 0
>>>> =C2=A0 4: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io_links_=
count 1 (GPU)
>>>> =C2=A0 5: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io_links_=
count 1 (GPU)
>>>>
>>>> RCCL unit tests =E2=80=94 948 cases, all PASS:
>>>>
>>>> ---
>>>> Test environment =E2=80=94 discontiguous NUMA (3 nodes: 0, 2-3)
>>>> --------------------------------------------------------
>>>>
>>>> numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3 are
>>>> CPU-less and memory-less:
>>>>
>>>> =C2=A0 $ numactl -H
>>>> =C2=A0 available: 3 nodes (0,2-3)
>>>> =C2=A0 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
>>>> =C2=A0 node 0 size: 519305 MB
>>>> =C2=A0 node 0 free: 504963 MB
>>>> =C2=A0 node 2 cpus: (none)
>>>> =C2=A0 node 2 size: 0 MB
>>>> =C2=A0 node 2 free: 0 MB
>>>> =C2=A0 node 3 cpus: (none)
>>>> =C2=A0 node 3 size: 0 MB
>>>> =C2=A0 node 3 free: 0 MB
>>>>
>>>> After this patch series the KFD topology sysfs correctly preserves the
>>>> NUMA node IDs as proximity domains. Node 1 appears as an empty
>>>> placeholder, nodes 2 and 3 have no cores or memory banks but carry the
>>>> GPU IO links, and both GPUs correctly reference node 2 as their=20
>>>> attached
>>>> CPU-less domain:
>>>>
>>>> =C2=A0 /sys/class/kfd/kfd/topology/nodes: 0=C2=A0 1=C2=A0 2 3=C2=A0 4=
=C2=A0 5
>>>>
>>>> =C2=A0 0: cpu_cores_count 40=C2=A0 mem_banks_count 1 io_links_count 0
>>>> =C2=A0 1: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_links_cou=
nt 0 (absent,
>>>> placeholder)
>>>> =C2=A0 2: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_links_cou=
nt 2 (CPU-less,
>>>> GPUs attached)
>>>> =C2=A0 3: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_links_cou=
nt 0 (CPU-less)
>>>> =C2=A0 4: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io_links_=
count 1 (GPU)
>>>> =C2=A0 5: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io_links_=
count 1 (GPU)
>>>>
>>>> =C2=A0 node 4 io_link: node_from 4=C2=A0 node_to 2 type 2 max_bandwidt=
h 10000
>>>> =C2=A0 node 5 io_link: node_from 5=C2=A0 node_to 2 type 2 max_bandwidt=
h 10000
>>>>
>>>> RCCL unit tests =E2=80=94 948 cases, all PASS:
>>>>
>>>> We fully understand your concern about regressions. We would
>>>> greatly appreciate it if someone with access to the systems you=20
>>>> mentioned
>>>> could test this series, and we are very happy to make any adjustments
>>>> based on that feedback.
>>>>
>>>> Regards,
>>>> Dhruv
>>>>
>>>>>
>>>>> That said, the patch series looks good to me now, in theory.
>>>>>
>>>>> Regards,
>>>>> =C2=A0 Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Co-developed-by: Donet Tom <donettom@linux.ibm.com>
>>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>>> Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
>>>>>> ---
>>>>>> =C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40=20
>>>>>> +++++++++++++++------------
>>>>>> =C2=A0 1 file changed, 22 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> index 7dad8f30ff2a..329931b0edc6 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>>>>> @@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void
>>>>>> *pcrat_image, size_t *size)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Fill in Subtype: Compute Unit */
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fill_cu_for_=
cpu(numa_node_id, &avail_size,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->num_domains,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(struct crat_subtype_computeunit *)sub_type_hdr);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return ret;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table->length +=3D =
sub_type_hdr->length;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table->total_entrie=
s++;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kfd_numa_node_to_api=
c_id(numa_node_id) !=3D -1) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table->num_domains,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (struct crat_subtype_computeunit
>>>>>> *)sub_type_hdr);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (ret < 0)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->length +=3D sub_type_hdr->length;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->total_entries++;
>>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr =3D =
(typeof(sub_type_hdr))((char=20
>>>>>> *)sub_type_hdr +
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sub_type_hdr->length);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sub_type_hdr =3D (typeof(sub_type_hdr))((char
>>>>>> *)sub_type_hdr +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr->length);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Fill in Subtype: Memory */
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fill_mem_inf=
o_for_cpu(numa_node_id, &avail_size,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->num_domains,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(struct crat_subtype_memory *)sub_type_hdr);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return ret;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table->length +=3D =
sub_type_hdr->length;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table->total_entrie=
s++;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (node_state(numa_node=
_id, N_MEMORY)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D kfd_fill_mem_info_for_cpu(numa_node_id,=20
>>>>>> &avail_size,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 crat_table->num_domains,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (struct crat_subtype_memory
>>>>>> *)sub_type_hdr);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (ret < 0)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->length +=3D sub_type_hdr->length;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
crat_table->total_entries++;
>>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr =3D =
(typeof(sub_type_hdr))((char=20
>>>>>> *)sub_type_hdr +
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sub_type_hdr->length);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sub_type_hdr =3D (typeof(sub_type_hdr))((char
>>>>>> *)sub_type_hdr +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr->length);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* Fill in Subtype: IO Link */
>>>>>> =C2=A0 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)=

--------------5fzz10HUUVdfz1Ph2Jx00LbQ
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
    <div class=3D"moz-cite-prefix">On 27/10/26 03:51, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:f064e15c-7fe0-4e6f-a01f-7b50a6e77a81@amd.com">
      <!-- BaNnErBlUrFlE-BoDy-start -->
      <!-- Preheader Text : BEGIN -->
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;">
        On 2026-10-26 14:=E2=80=8A07, Dhruv Bhogaonkar wrote: On 08/10/26
        02:=E2=80=8A31, Kuehling, Felix wrote: On 2026-10-07 07:=E2=80=8A14=
, Dhruv
        Bhogaonkar wrote: [Some people who received this message don't
        often get email from dhruvb@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Aco=
m. Learn why this is
        important</div>
      <!-- Preheader Text : END -->
      <!-- Email Banner : BEGIN -->
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;"></div>
      <!-- Email Banner : END -->
      <!-- BaNnErBlUrFlE-BoDy-end -->
      <!-- BaNnErBlUrFlE-HeAdEr-start -->
      <style>@scope { #pfptBanner51jsud1 { all: revert !important; display:=
 block !important;
    visibility: visible !important; opacity: 1 !important;
    background-color: #d0d8dc !important;
    max-width: none !important; max-height: none !important }.pfptPrimaryBu=
tton51jsud1:hover, .pfptPrimaryButton51jsud1:focus {
    background-color: #b4c1c7 !important; }.pfptPrimaryButton51jsud1:active=
 {
    background-color: #90a4ae !important; }html:root, html:root>body { all:=
 revert !important; display: block !important;
    visibility: visible !important; opacity: 1 !important; } }</style>
      <!-- BaNnErBlUrFlE-HeAdEr-end -->
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <div class=3D"moz-cite-prefix">On 2026-10-26 14:07, Dhruv Bhogaonkar
        wrote:<br>
      </div>
      <blockquote type=3D"cite"
        cite=3D"mid:8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com">
        <p><br>
        </p>
        <div class=3D"moz-cite-prefix">On 08/10/26 02:31, Kuehling, Felix
          wrote:<br>
        </div>
        <blockquote type=3D"cite"
          cite=3D"mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com">On
          2026-10-07 07:14, Dhruv Bhogaonkar wrote: <br>
          <blockquote type=3D"cite">[Some people who received this message
            don't often get email from <a
              class=3D"moz-txt-link-abbreviated moz-txt-link-freetext"
              href=3D"mailto:dhruvb@linux.ibm.com" moz-do-not-send=3D"true"=
>dhruvb@linux.ibm.com</a>.
            Learn why this is important at <a
              class=3D"moz-txt-link-freetext"
              href=3D"https://aka.ms/LearnAboutSenderIdentification"
              moz-do-not-send=3D"true">https://aka.ms/LearnAboutSenderIdent=
ification</a>
            ] <br>
            <br>
            On 07/10/26 01:30, Felix Kuehling wrote: <br>
            <blockquote type=3D"cite"> <br>
              On 2026-10-06 08:51, Dhruv B wrote: <br>
              <blockquote type=3D"cite">In heterogeneous or non-uniform
                NUMA systems, a NUMA node may be <br>
                CPU-less, memory-less, or both CPU-less and memory-less.
                <br>
                <br>
                Previously, kfd_create_vcrat_image_cpu() assumed that
                every online NUMA <br>
                node contained both compute units and memory, attempting
                to create both <br>
                CU and memory CRAT entries unconditionally for every
                online node. <br>
                <br>
                Add explicit guards to: <br>
                1. Only create Compute Unit CRAT entries if the NUMA
                node has valid <br>
                =C2=A0=C2=A0=C2=A0 CPU cores (kfd_numa_node_to_apic_id() !=
=3D -1). <br>
                2. Only create Memory CRAT entries if the NUMA node
                actually contains <br>
                =C2=A0=C2=A0=C2=A0 memory (node_state(numa_node_id, N_MEMOR=
Y)). <br>
                <br>
                This avoids emitting invalid or empty CRAT subtype
                entries for CPU-less, <br>
                memory-less, or both CPU-less and memory-less NUMA nodes
                in virtual CRAT <br>
                generation. <br>
              </blockquote>
              <br>
              @David Yat Sin, I think we currently support CPU-less and
              memory-less <br>
              NUMA domains already. I know we have CPU-less NUMA domains
              on MI300A <br>
              in NPS4/TPX mode. And I remember we've fixed bugs on NUMA
              CPU systems <br>
              with only one DIMM populated, which would result in a
              memory-less NUMA <br>
              domain. <br>
              <br>
              Therefore, I'm not sure whether this patch is really
              needed and I'd be <br>
              concerned about introducing a regression. Is ROCr able to
              handle the <br>
              changes being proposed here? David, could you take a look
              at this and <br>
              maybe even test it, or find someone who could help test it
              on the <br>
              system configurations I described? <br>
            </blockquote>
            <br>
            Thank you for the feedback, Felix. Apologies for the bug in
            v1 =E2=80=94 <br>
            that was an oversight on our part. <br>
            <br>
            From the current code, the kfd_numa_node_to_apic_id() =3D=3D -1
            <br>
            continue causes the entire loop body to be skipped <br>
            for a CPU-less NUMA node: <br>
            <br>
            =C2=A0 for_each_online_node(numa_node_id) { <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kfd_=
numa_node_to_apic_id(numa_node_id) =3D=3D -1)
            <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue; <br>
            <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D =
kfd_fill_cu_for_cpu(...); <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D =
kfd_fill_mem_info_for_cpu(...); <br>
            =C2=A0 } <br>
            <br>
            When the loop body is skipped, neither a CU entry nor a
            memory entry is <br>
            generated for that node, and no KFD topology device appears
            to be <br>
            registered for it from this code path. From our reading, it
            appears that <br>
            CPU-less nodes are effectively absent from the generated
            VCRAT topology <br>
            rather than being represented with an empty or placeholder
            entry. <br>
          </blockquote>
          <br>
          OK. I'm a bit surprised about that, because MI300A in NPS4
          mode should have three CPU-less NUMA nodes per socket. Maybe
          we never depended on them being represented as CPU-less NUMA
          nodes in the KFD topology. Then this change should be an
          improvement because it removes some ambiguity between NUMA
          node numbers and KFD proximity domains. <br>
          <br>
          <br>
          <blockquote type=3D"cite"> <br>
            <blockquote type=3D"cite"> <br>
              @Dhruv B, how much testing have you done on this patch
              series. Given <br>
              that the bug in patch 2 slipped through in v1, I'm worried
              that it's <br>
              not very thorough. <br>
            </blockquote>
            <br>
            Regarding testing, on the userspace side we ran the RCCL
            unit tests. <br>
            <br>
            On the kernel side, we verified that the IO links are
            created correctly <br>
            for both topologies by inspecting the KFD topology sysfs
            entries after <br>
            driver load. <br>
            <br>
            Here are the RCCL unit test results for both configurations,
            along with <br>
            the corresponding numactl and KFD topology sysfs output
            observed after <br>
            driver load. <br>
          </blockquote>
          <br>
          Sounds good. We still need to test MI300A to make sure the
          changes don't confuse ROCr or amdsmi. Applications mostly
          shouldn't care because they don't use KFD topology node
          numbers directly. I'm told that most of the MI300A systems in
          production seem to use NPS1, so this shouldn't affect them.</bloc=
kquote>
        <p><br>
        </p>
        <p data-pm-slice=3D"1 1 []"
style=3D"caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-s=
ize: medium; font-style: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;"><span>Hi
            Felix,</span></p>
        <p
style=3D"caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-s=
ize: medium; font-style: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;"><span>I
            wanted to ask if there have been any updates on the</span><br>
          <span>patch series and whether anything would be required=C2=A0<b=
r>
            from my</span><span>=C2=A0side.</span></p>
      </blockquote>
      <p>Thanks for the reminder. We did some testing of these patches
        and also considered what configurations of MI300A are actually
        deployed. An automated AI review caught two other problematic
        interactions in patch 2/3:</p>
      <blockquote>
        <p>Phantom domains have a knock-on effect in kfd_topology.c:
          kfd_create_indirect_link_prop() (kfd_<a
            class=3D"moz-txt-link-freetext" href=3D"topology.c:1421-1440"
            moz-do-not-send=3D"true">topology.c:1421-1440</a>) walks i
          over every CPU-side topology device and does return -ENOMEM
          when no matching cpu_link is found. A device synthesized for
          an offline node has an empty io_link_props, so on an x86 box
          with a hole in the node IDs and &gt;1 GPU,
          kfd_dev_create_p2p_links() now bails out and all indirect/P2P
          links are silently dropped (the return value at kfd_<a
            class=3D"moz-txt-link-freetext" href=3D"topology.c:2077"
            moz-do-not-send=3D"true">topology.c:2077</a> is ignored).
          Worth either skipping link-less CPU devices there or
          confirming this path was evaluated.</p>
      </blockquote>
      <p>And</p>
      <blockquote>
        <p>Regression: the old loop body started with</p>
        <pre><code>if (kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1)
        continue;</code></pre>
        <p>and that guard is gone. For a node that is online but has no
          CPUs (CXL / dax-kmem memory-only nodes, hotplug-added memory
          nodes, HBM nodes), <code>cpumask_of_node()</code> is empty,
          so <code>kfd_fill_cu_for_cpu()</code> hits the <code>processor_id=
_low
            =3D=3D -1</code> check at line 1791 and returns -EINVAL. <code>=
kfd_create_vcrat_image_cpu()</code>
          propagates that at line 1951, producing exactly the "Error
          parsing VCRAT" / "Error initializing KFD node" failure this
          patch is fixing =E2=80=94 just on a different machine.</p>
        <p>Suggest folding the check into the skip condition so such
          nodes still consume a proximity domain (which is what the
          commit message describes):</p>
        <pre><code>if (!node_online(numa_node_id) ||
    kfd_numa_node_to_apic_id(numa_node_id) =3D=3D -1) {
        crat_table-&gt;num_domains++;
        continue;
}</code></pre>
      </blockquote>
      <p>I think that last suggestion is wrong though, because it
        basically defeats the purpose of that patch by skipping CPU-less
        NUMA domains.</p>
      <p>And one AI comment on patch 3/3:</p>
      <blockquote>
        <p>Newly reachable misclassification. With this patch a
          CPU-less-but-has-memory NUMA node (CXL/dax-kmem,
          generic-initiator) now emits a Memory entry. On parse, that
          node's topology device has <code>cpu_cores_count =3D=3D 0</code>,
          so this branch treats it as a GPU node; <code>kfd_fill_mem_info_f=
or_cpu()</code>
          memsets the entry (line 1819) so <code>visibility_type =3D=3D 0</=
code>,
          and the heap is tagged <code>HSA_MEM_HEAP_TYPE_FB_PRIVATE</code>
          instead of <code>HSA_MEM_HEAP_TYPE_SYSTEM</code>.</p>
        <p>Result: host CXL/hotplug memory is exported to ROCr/Thunk as
          private framebuffer on a node with no GPU. This path was
          unreachable before because <code>kfd_fill_cu_for_cpu()</code>
          bailed with -EINVAL.</p>
        <p><code>cpu_cores_count</code> is no longer a valid CPU-vs-GPU
          discriminator. Suggest keying off GPU-ness instead, e.g.:</p>
        <pre><code>if (dev-&gt;node_props.simd_count =3D=3D 0)
        heap_type =3D HSA_MEM_HEAP_TYPE_SYSTEM;
else if (mem-&gt;visibility_type =3D=3D 0)
        heap_type =3D HSA_MEM_HEAP_TYPE_FB_PRIVATE;
else
        heap_type =3D mem-&gt;visibility_type;</code></pre>
        <p>(GPU VCRAT emits the CU entry before the memory entries, so <cod=
e>simd_count</code>
          is already populated when this runs.)</p>
      </blockquote>
    </blockquote>
    <font face=3D"monospace">Thanks a lot for the review and feedback,
      Felix.=C2=A0<br>
      I have posted v3 of the patch series, with the=C2=A0<br>
      suggested changes.<br>
      <br>
      Thanks,<br>
      Dhruv B</font>
    <blockquote type=3D"cite"
      cite=3D"mid:f064e15c-7fe0-4e6f-a01f-7b50a6e77a81@amd.com">
      <blockquote> </blockquote>
      <p><br>
      </p>
      <p>Regards,<br>
        =C2=A0 Felix</p>
      <p><br>
      </p>
      <blockquote type=3D"cite"
        cite=3D"mid:8a6dee87-72aa-469e-bb87-eb121df6b4d2@linux.ibm.com">
        <p
style=3D"caret-color: rgb(255, 255, 255); color: rgb(255, 255, 255); font-s=
ize: medium; font-style: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;"><span>Thanks,</span>=
<br>
          <span>Dhruv B</span></p>
        <p><br>
        </p>
        <blockquote type=3D"cite"
          cite=3D"mid:a32fd341-4fe8-4bdd-9627-1cd6c02969c6@amd.com">=C2=A0<=
br>
          <br>
          Regards, <br>
          =C2=A0 Felix <br>
          <br>
          <br>
          <blockquote type=3D"cite"> <br>
            --- <br>
            Test environment =E2=80=94 contiguous NUMA (4 nodes, 0-3) <br>
            -------------------------------------------------- <br>
            <br>
            numactl reports 4 contiguous nodes (0-3), all with CPUs and
            memory: <br>
            <br>
            =C2=A0 $ numactl -H <br>
            =C2=A0 available: 4 nodes (0-3) <br>
            =C2=A0 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
            18 19 20 21 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
            37 38 39 40 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
            <br>
            =C2=A0 node 0 size: 881496 MB <br>
            =C2=A0 node 0 free: 875909 MB <br>
            =C2=A0 node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70
            71 72 73 74 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89
            90 91 92 93 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 94 95 96 97 98 99 100 101 102 103 104 105 106
            107 108 109 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 110 111 <br>
            =C2=A0 node 1 size: 885640 MB <br>
            =C2=A0 node 1 free: 883815 MB <br>
            =C2=A0 node 2 cpus: 112 113 114 115 116 117 118 119 120 121 122
            123 124 125 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 126 127 128 129 130 131 132 133 134 135 136
            137 138 139 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 140 141 142 143 144 145 146 147 148 149 150
            151 152 153 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 154 155 156 157 158 159 160 161 162 163 164
            165 166 167 <br>
            =C2=A0 node 2 size: 885640 MB <br>
            =C2=A0 node 2 free: 874248 MB <br>
            =C2=A0 node 3 cpus: 168 169 170 171 172 173 174 175 176 177 178
            179 180 181 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 182 183 184 185 186 187 188 189 190 191 192
            193 194 195 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 196 197 198 199 200 201 202 203 204 205 206
            207 208 209 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 210 211 212 213 214 215 216 217 218 219 220
            221 222 223 <br>
            =C2=A0 node 3 size: 885394 MB <br>
            =C2=A0 node 3 free: 884033 MB <br>
            <br>
            The KFD topology sysfs reflects all 4 CPU nodes (0-3) plus 2
            GPUs <br>
            (nodes 4 and 5), each CPU node with correct core and memory
            counts: <br>
            <br>
            =C2=A0 /sys/class/kfd/kfd/topology/nodes: 0=C2=A0 1=C2=A0 2 3=
=C2=A0 4=C2=A0 5 <br>
            <br>
            =C2=A0 0: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_c=
ount 0
            <br>
            =C2=A0 1: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_c=
ount 0
            <br>
            =C2=A0 2: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_c=
ount 2
            <br>
            =C2=A0 3: cpu_cores_count 56=C2=A0 mem_banks_count 1 io_links_c=
ount 0
            <br>
            =C2=A0 4: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io=
_links_count 1=C2=A0
            (GPU) <br>
            =C2=A0 5: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io=
_links_count 1=C2=A0
            (GPU) <br>
            <br>
            RCCL unit tests =E2=80=94 948 cases, all PASS: <br>
            <br>
            --- <br>
            Test environment =E2=80=94 discontiguous NUMA (3 nodes: 0, 2-3)=
 <br>
            -------------------------------------------------------- <br>
            <br>
            numactl reports 3 nodes with a gap at node 1. Nodes 2 and 3
            are <br>
            CPU-less and memory-less: <br>
            <br>
            =C2=A0 $ numactl -H <br>
            =C2=A0 available: 3 nodes (0,2-3) <br>
            =C2=A0 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
            18 19 20 21 <br>
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
            37 38 39 <br>
            =C2=A0 node 0 size: 519305 MB <br>
            =C2=A0 node 0 free: 504963 MB <br>
            =C2=A0 node 2 cpus: (none) <br>
            =C2=A0 node 2 size: 0 MB <br>
            =C2=A0 node 2 free: 0 MB <br>
            =C2=A0 node 3 cpus: (none) <br>
            =C2=A0 node 3 size: 0 MB <br>
            =C2=A0 node 3 free: 0 MB <br>
            <br>
            After this patch series the KFD topology sysfs correctly
            preserves the <br>
            NUMA node IDs as proximity domains. Node 1 appears as an
            empty <br>
            placeholder, nodes 2 and 3 have no cores or memory banks but
            carry the <br>
            GPU IO links, and both GPUs correctly reference node 2 as
            their attached <br>
            CPU-less domain: <br>
            <br>
            =C2=A0 /sys/class/kfd/kfd/topology/nodes: 0=C2=A0 1=C2=A0 2 3=
=C2=A0 4=C2=A0 5 <br>
            <br>
            =C2=A0 0: cpu_cores_count 40=C2=A0 mem_banks_count 1 io_links_c=
ount 0
            <br>
            =C2=A0 1: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_li=
nks_count 0
            (absent, <br>
            placeholder) <br>
            =C2=A0 2: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_li=
nks_count 2
            (CPU-less, <br>
            GPUs attached) <br>
            =C2=A0 3: cpu_cores_count=C2=A0 0=C2=A0 mem_banks_count 0 io_li=
nks_count 0
            (CPU-less) <br>
            =C2=A0 4: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io=
_links_count 1=C2=A0
            (GPU) <br>
            =C2=A0 5: cpu_cores_count=C2=A0 0=C2=A0 simd_count 416=C2=A0 io=
_links_count 1=C2=A0
            (GPU) <br>
            <br>
            =C2=A0 node 4 io_link: node_from 4=C2=A0 node_to 2 type 2=C2=A0
            max_bandwidth 10000 <br>
            =C2=A0 node 5 io_link: node_from 5=C2=A0 node_to 2 type 2=C2=A0
            max_bandwidth 10000 <br>
            <br>
            RCCL unit tests =E2=80=94 948 cases, all PASS: <br>
            <br>
            We fully understand your concern about regressions. We would
            <br>
            greatly appreciate it if someone with access to the systems
            you mentioned <br>
            could test this series, and we are very happy to make any
            adjustments <br>
            based on that feedback. <br>
            <br>
            Regards, <br>
            Dhruv <br>
            <br>
            <blockquote type=3D"cite"> <br>
              That said, the patch series looks good to me now, in
              theory. <br>
              <br>
              Regards, <br>
              =C2=A0 Felix <br>
              <br>
              <br>
              <blockquote type=3D"cite"> <br>
                Co-developed-by: Donet Tom <a
                  class=3D"moz-txt-link-rfc2396E"
                  href=3D"mailto:donettom@linux.ibm.com"
                  moz-do-not-send=3D"true">&lt;donettom@linux.ibm.com&gt;</=
a>
                <br>
                Signed-off-by: Donet Tom <a
                  class=3D"moz-txt-link-rfc2396E"
                  href=3D"mailto:donettom@linux.ibm.com"
                  moz-do-not-send=3D"true">&lt;donettom@linux.ibm.com&gt;</=
a>
                <br>
                Signed-off-by: Dhruv B <a class=3D"moz-txt-link-rfc2396E"
                  href=3D"mailto:dhruv.b@linux.ibm.com"
                  moz-do-not-send=3D"true">&lt;dhruv.b@linux.ibm.com&gt;</a>
                <br>
                --- <br>
                =C2=A0 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40
                +++++++++++++++------------ <br>
                =C2=A0 1 file changed, 22 insertions(+), 18 deletions(-) <b=
r>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
                b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
                index 7dad8f30ff2a..329931b0edc6 100644 <br>
                --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
                +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c <br>
                @@ -1944,28 +1944,32 @@ static int
                kfd_create_vcrat_image_cpu(void <br>
                *pcrat_image, size_t *size) <br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } <b=
r>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Fill in Subtype: Compute Unit */ <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fil=
l_cu_for_cpu(numa_node_id,
                &amp;avail_size, <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;num_domains, <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (struct crat_subtype_computeunit
                *)sub_type_hdr); <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret &lt; 0)=
 <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret; <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table-&gt;=
length +=3D
                sub_type_hdr-&gt;length; <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table-&gt;=
total_entries++; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kfd_numa_no=
de_to_apic_id(numa_node_id) !=3D
                -1) { <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D kfd_fill_cu_for_cpu(numa_node_id,
                &amp;avail_size, <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 crat_table-&gt;num_domains, <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (struct
                crat_subtype_computeunit <br>
                *)sub_type_hdr); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret &lt; 0) <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;length +=3D
                sub_type_hdr-&gt;length; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;total_entries++; <br>
                =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type=
_hdr =3D (typeof(sub_type_hdr))((char
                *)sub_type_hdr + <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sub_type_hdr-&gt;length); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sub_type_hdr =3D (typeof(sub_type_hdr))((char
                <br>
                *)sub_type_hdr + <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr-&gt;length); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } <br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Fill in Subtype: Memory */ <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D kfd_fil=
l_mem_info_for_cpu(numa_node_id,
                &amp;avail_size, <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;num_domains, <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (struct crat_subtype_memory
                *)sub_type_hdr); <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret &lt; 0)=
 <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret; <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table-&gt;=
length +=3D
                sub_type_hdr-&gt;length; <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table-&gt;=
total_entries++; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (node_state(=
numa_node_id, N_MEMORY)) { <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D
                kfd_fill_mem_info_for_cpu(numa_node_id, &amp;avail_size,
                <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crat_table-&gt;num_domains,
                <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (struct crat_subtype_memory
                <br>
                *)sub_type_hdr); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret &lt; 0) <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;length +=3D
                sub_type_hdr-&gt;length; <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 crat_table-&gt;total_entries++; <br>
                =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type=
_hdr =3D (typeof(sub_type_hdr))((char
                *)sub_type_hdr + <br>
                -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sub_type_hdr-&gt;length); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sub_type_hdr =3D (typeof(sub_type_hdr))((char
                <br>
                *)sub_type_hdr + <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sub_type_hdr-&gt;length); <br>
                +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } <br>
                =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* Fill in Subtype: IO Link */ <br>
                =C2=A0 #if defined(CONFIG_X86_64) &amp;&amp;
                !defined(CONFIG_UML) <br>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------5fzz10HUUVdfz1Ph2Jx00LbQ--

