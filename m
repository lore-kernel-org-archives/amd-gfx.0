Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98ACD5CCB7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 10:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4806F10E67D;
	Tue, 16 Dec 2025 10:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="SOEpxtzx";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03B610E67D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 10:13:08 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG7Pn6d023977;
 Tue, 16 Dec 2025 10:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YudP25
 uopcbONYV33pEFnUEbUEnvYQNqH4ed7TXUcT0=; b=SOEpxtzxZTy3DyrKLpCRC9
 m2UnPAirB/nszEpWH4gfSOPM6vd51X1eU+fBPL/GwgY9oB4Ao7ZJo4Cl9GSf1tlI
 COhpCPYfSYyy68BRIAW9i8ZY4PfqCFSuhRn0GiJzxoGLyq8YjVT5c6Z7TjS1P2U6
 B2m06ZZZMbMJ29Lo9y+LGmX+YmgLJcjoOQskf9pCSzxseMrLBozKAzrqbALf3jVL
 bbxPGHcq1mAtKeXz17J/ULZQf+3XfVFCQo5KKmmpngSnaNXW38I/EqqphR5u0GUl
 KvjwoFKN0OEbL3yV8d7V7ZOOC0bsBbpVljFKlMKgh7OdyEc20nErfsO72l6+QuSw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkwwab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:13:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BG9lCEH022540;
 Tue, 16 Dec 2025 10:13:06 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkwwa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:13:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG7dCp7014406;
 Tue, 16 Dec 2025 10:13:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpju72w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 10:13:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGAD3Oi7602894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 10:13:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92DD758071;
 Tue, 16 Dec 2025 10:13:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD5475803F;
 Tue, 16 Dec 2025 10:13:00 +0000 (GMT)
Received: from [9.124.208.98] (unknown [9.124.208.98])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 10:13:00 +0000 (GMT)
Message-ID: <8b2805da-e0e1-42df-b200-05d6e14b4c30@linux.ibm.com>
Date: Tue, 16 Dec 2025 15:42:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/8] drm/amdkfd: Relax size checking during queue
 buffer get
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <afa131799094e31bc6180aaa310cbca38185635e.1765519875.git.donettom@linux.ibm.com>
 <64013bb5-9510-4a29-873e-b23d59c494db@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <64013bb5-9510-4a29-873e-b23d59c494db@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FihwH5D4DJiI6Q_bkznOzCuykqRr6aAM
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=694130b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ps_O9QLQRzjHPjfu8zYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -KjWByuV-NKC2czbXhKcy4xv-eMHQjRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfXyPOclTwA7sBg
 HRZXsajfAD3SUcyO1Yc+mSd24wgjQLK5/XcH0Y3UO6YyXx30S/uc32eNRCqK8hsQWqob0YQdB0G
 RsfMlsQsUkYE2d0QLBoXpmE8y53FB2E7N+tIkmP4igDnQIgcotIXAo+i8ZbXO62VtZ32w8QLhge
 cPZ0s11vbAUotVfU4Ovk0rwq2LfsV7UMH/HAmjFNa1n+s+X5waD6TWwCflmC/NlicAnDgYG4RTK
 eUQoQszsoNZpKrUIbcAjpzemEKupL9Y9iKzQo4OpIXn/kOJDm8ZAMNAezVQ16akv3AjiA/u5inc
 1gL11qFH0JRPRAKp905lvOWOEC+evXI25I1w5bVDdt7QJn/5FQdCjwMKO5pvNyJPdyrByazXgwi
 xN2Zs3EmLifLLlapejnwj11K/XaT7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
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


On 12/16/25 1:55 AM, Philip Yang wrote:
>
>
> On 2025-12-12 01:40, Donet Tom wrote:
>> HW-supported EOP buffer sizes are 4K and 32K. On systems that do not
>> use 4K pages, the minimum buffer object (BO) allocation size is
>> PAGE_SIZE (for example, 64K). During queue buffer acquisition, the 
>> driver
>> currently checks the allocated BO size against the supported EOP buffer
>> size. Since the allocated BO is larger than the expected size, this 
>> check
>> fails, preventing queue creation.
>>
>> Relax the strict size validation and allow PAGE_SIZE-sized BOs to be 
>> used.
>> Only the required 4K region of the buffer will be used as the EOP buffer
>> and avoids queue creation failures on non-4K page systems.
>>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index f1e7583650c4..dc857450fa16 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -199,6 +199,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, 
>> void __user *addr, struct amdgpu_
>>       struct amdgpu_bo_va_mapping *mapping;
>>       u64 user_addr;
>>       u64 size;
>> +    u64 bo_size;
>>         user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
>>       size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>> @@ -207,11 +208,12 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, 
>> void __user *addr, struct amdgpu_
>>       if (!mapping)
>>           goto out_err;
>>   -    if (user_addr != mapping->start ||
>> -        (size != 0 && user_addr + size - 1 != mapping->last)) {
>> -        pr_debug("expected size 0x%llx not equal to mapping addr 
>> 0x%llx size 0x%llx\n",
>> +    bo_size = mapping->last - mapping->start + 1;
>> +
>> +    if (user_addr != mapping->start || (size != 0 && bo_size < size)) {
>> +        pr_debug("expected size 0x%llx grater than mapping addr 
>> 0x%llx size 0x%llx\n",
>>               expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
>> -            (mapping->last - mapping->start + 1) << 
>> AMDGPU_GPU_PAGE_SHIFT);
>> +            bo_size <<  AMDGPU_GPU_PAGE_SHIFT);
> This change works, but also relax the size validation for ring buffer 
> size etc, this may have side effect,
> for example FW and user space should have the same ring buffer size.
>
> Other buffers already use PAGE_SIZE as expected size or size aligned 
> to PAGE_SIZE, maybe only relax the eop buffer
> size check
>
> @@ -275,7 +275,7 @@ int kfd_queue_acquire_buffers(struct 
> kfd_process_device *pdd, struct queue_prope
>
>         /* EOP buffer is not required for all ASICs */
>         if (properties->eop_ring_buffer_address) {
> -               if (properties->eop_ring_buffer_size != 
> topo_dev->node_props.eop_buffer_size) {
> +               if (properties->eop_ring_buffer_size < 
> topo_dev->node_props.eop_buffer_size) {
>                         pr_debug("queue eop bo size 0x%x not equal to 
> node eop buf size 0x%x\n",
> properties->eop_ring_buffer_size,
> topo_dev->node_props.eop_buffer_size);
> @@ -284,7 +284,7 @@ int kfd_queue_acquire_buffers(struct 
> kfd_process_device *pdd, struct queue_prope
>                 }
>                 err = kfd_queue_buffer_get(vm, (void 
> *)properties->eop_ring_buffer_address,
> &properties->eop_buf_bo,
> - properties->eop_ring_buffer_size);
> + ALIGN(properties->eop_ring_buffer_size, PAGE_SIZE));
>                 if (err)
>                         goto out_err_unreserve;
>         }


Thank you. I will make this change in next version.


>
> Regards,
> Philip
>>           goto out_err;
>>       }
>
