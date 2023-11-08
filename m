Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D134C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 23:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678D510E09A;
	Wed,  8 Nov 2023 23:41:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8901810E09A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 23:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSxPIDelq9nhPgLmZyGGACM0oAy4myoA2uJ96PRT6aiaMz41Xncsj/DpnC8gIK58Y10wqPcOb0J8t9ckHtObT8o2A6rXVh4ZzGtDUafkfh9NxvQ0j6WEnyHEDKO+SN0u2mHIhHpJXH3QeTamh7oyar9PtDVY8ZtkVePZp/CUeUOn5K0dxg9fTELKVAUWuBxvg3FD9zbK7WDJHIrh5tXDi+2i6TFtG08OcJkdqO47cwXOaSYWsc6qcyH8KQaOZtLbq3doPy4liK7ZYMgutquqMstYk0AOq0Oxx8V3evvNM/MSAby18CtAIx2dSGKl4e7v+c1MxWChwHMG+2ZLEF4gFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd3himr95REllU63WCX/ijt+CikqgczC8qSS0cAm9hA=;
 b=i2a/PYkxWfZsGMTsGVOeO0avdKaHBQDxNRN56pv0hkqDgR/8KjMAruOhOqSX0m7L5eHSobvrQd9VcqoGxGx6jpnDAK7hCeYl31GJCKFGUh0/vCF04skPAj7DwWfPGDdyxmw2BCS/abbMrqTJZp+qzHCnzDQ6YSwFrpbecOOEoSGPK8FJF0fY5g0YwpzRSB0vJuXwwCtvxAnKLuqM2gqn5nC0hSRg34nY9mwZgZ0hW/CNmNAwz2La2jYP/mdOEMpFWuYgGmMO4vIY345VuL25V9JL/X43MJFTmsRF3A77ZEFPvInVXP9YI99fKIexFf/f8s+k+I9riGWtLgdeLwqwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd3himr95REllU63WCX/ijt+CikqgczC8qSS0cAm9hA=;
 b=mORL//HsZSd38mBmrFQuOkepO1STjQJ9W/E9LIEWyBLt6ay2rHhdhDZh7br9r1oyVHAeOjIws5L/epHiuSLMyI+V4TjivduxOCtGMWR9vPsxQ9WiZCQECRtYMKW0SvxlcKzSulDoKil8vaEEn7SB0QOfY/KwOXyf6QcOmMezWeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 23:41:14 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9578:681f:c050:51b9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 23:41:13 +0000
Message-ID: <c3fe6cca-e26c-936d-7bff-71a27c0f6ae8@amd.com>
Date: Wed, 8 Nov 2023 17:41:10 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] drm/amdkfd: Import DMABufs for interop through DRM
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-5-Felix.Kuehling@amd.com>
 <feedeec2-e6ca-f1c1-77db-db0cd6305428@amd.com>
 <297844d3-835c-4785-b2f9-122a1432e474@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <297844d3-835c-4785-b2f9-122a1432e474@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0168.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::14) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd53dfe-2ed1-4092-1f7c-08dbe0b43171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfWkVtIB8uiRA/dDFGJEo4I96Kg0jnAXJsnF/MV+XFhvYH5b25WORTdWWA/dC+rW1t2XTdVam4RgJIyonSFo7OtbnRTq1NN7l0NAOMUGMGji6QcpOX9ELiQ15l1TLBXCpImg6CYhOmQVykD35sOXVodjdXmtpE0ianM/PIYk6pHUyeEmlsYInJx+u4PlanRgbUHBHm+Fj+0IM6lpcbIo7aN2LXWi17Fqg0ltTUww+x/T6iKazyfG8YB0XAjiSHMpdZpXnIWDOKD5TvzSPzu1gROXH48o9B/E1Ai5oPBGcw+tS1F5m8KYvkd3/jCl7cmeUHGBW+xLoXpEBu/Lh7YSR8VNWn2DT1m6mHzuFuKqjJDQ1m3drifhHl3vDrfv827Qz7Eo0hZEdq7/nhZTPQRrrKOfHM6DHKxZqcTgitYtm1YLlYkvNwxGzGrOvTb1SToZE8xuGjMu28HkFV344z6ZUlBPgFhvPDOvTth06TNEifx4MY56nBBQ6KYPAkgttMCiA6VmJoXpcGObk968/Ob5kGITB4J/6zY5h9KIm83CYkNEggB3a2P0ovD7KxDvTuickzwwrfw42emNkYx0+39lC/o+beNdVS0lfIVlG1hvbvBrFkKsPP2tNh9sufLBTIDPciOGWjO5P2Gf1t0fBbOwCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(8676002)(4326008)(8936002)(316002)(5660300002)(41300700001)(2906002)(66946007)(66476007)(66556008)(83380400001)(6486002)(31696002)(86362001)(478600001)(26005)(2616005)(6512007)(38100700002)(53546011)(36756003)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amgrVHZqaENCa1QzaVBMbktnMGZLV0FDVnBQUGV4VFRtU2lBVVl3S3lZYU54?=
 =?utf-8?B?QUtWdEdnQ2Irb1M1cE1zK21obXc4a203eWRMYXpTd3lydFE3RDl3dDZ5TnZ0?=
 =?utf-8?B?cnNJVWJSczVRdzJzVlcvSXVRUk52eVgwSEdyZUF2d28rRVB2RnBqd2l1TFhh?=
 =?utf-8?B?K1FZaHhrbWh1aFpOWVp0d0FyWHFmdlQ0K3d5WlgvVlJmYmN5djJSeE9ScUta?=
 =?utf-8?B?Z05oZzhvT094TFErek1sbXFsY0U1WU5yT3ZheWhHN1FqL2U2QVpqbE41dkN1?=
 =?utf-8?B?V2tyRjJPTDNDSnc3cGM2QkE0Ym0vbGp5ejgrUXZiZ1lNSFJITDBLb2NXQVpH?=
 =?utf-8?B?TWN1RFhMZEZmMkRtME5GMlB2MGVqc0xIN284NHEwaEhEampYUDhFV1lTMnQ3?=
 =?utf-8?B?R3Q2RWNzTkdoTlFwRkVrY29DdjJ5YzRJSi80ZW9CV1NiN2dmK1hSUmRqY1dt?=
 =?utf-8?B?UVI4d3c4Q1RRa09ha1BSZXJyYk1Ra25GU3UyVjR6cEN4YXVlcktsWjVHRkJT?=
 =?utf-8?B?WlJHZWdHNEdJMFRjLzlPUTlXMHpsRW5Uc1hmeEhpVEdqN0ZqWTRscE5lMFNj?=
 =?utf-8?B?cCtPaC83S2d6UmZJQWRxaTdqRnNRQVhudytSalU0Vi93Zk5pa2wxdzdOcmRH?=
 =?utf-8?B?TFRLYnFObjRlOHlSaDVvNUJHTTkyMWpvRzZKMjl0LzVOckVCRWJhQ0g4bk9E?=
 =?utf-8?B?Z3NaKzBKbDZaTFNadnNjOHFyNzQ4OGQ3ei92Uy9oWkNDZWcxZDhpMkVRMnoz?=
 =?utf-8?B?LzBsbUxjdVVCNnZNRHVaZTNyNVNwMG5pK25zTDh0RWVjMzAyWVVERjB6bnJV?=
 =?utf-8?B?VFpFUXRSQTlNZGQ1cVh5TzhPK3ZaTFhPZlJUM2dyWkJIclN1eE1qeVk5LzNW?=
 =?utf-8?B?eCtGWUFtSVJxbFRmcjgxYnlUcC9oS0pYR0F6VTB5S1lIWjlVRWFSaERpOThq?=
 =?utf-8?B?MUtsdDVlcWhLNTV3ZzNoTWxWWHlOWVUzOVRnNXNNTi9BcmlBc2RvcVZGMGZz?=
 =?utf-8?B?ZFFrQW4vQVNjSFFvQ2NmKzlKWkcxc2NBSzgwVStNZ3EvQU4zdVpQV1hlY0dR?=
 =?utf-8?B?NjA1cGJKVFEybkE2bSs0aThWSytxa2FiLzhsaDZtMlZ5SWxETU5CTno0NFc5?=
 =?utf-8?B?aTE3VEVtY2d1WUVjcXlLZGZrODE2ZWdMRkk2MnlrU0ZrRWtoUGlucnEyYUk4?=
 =?utf-8?B?VHBESW4rWlNuczFWdXVIdXNscnZqT1pVWDMzNGZCZXlQOENvRDlvd0VtY2R1?=
 =?utf-8?B?dEVPWDJwR2pYaUpVT0pTc1BwSTR6bWNnSGRIRE9pZ1NYT0J1Qytib0hJQlVr?=
 =?utf-8?B?ZGVnc0xHSjNzQzF5Nk42MW5WTU13bVNydFBNYTZFU0Q3YVNGbUZBQnZBaFdt?=
 =?utf-8?B?eHBDU1VwWG5Nd0ltblFNcHF1dVNoclZoU1BGOENrZWtlRU81UXlCOTFJY0VV?=
 =?utf-8?B?MlJLZGlBUStuOEFDK3JNS1JqZWJSK2RtdW5NbzFueXRORWg5RjBKQzE0ZnB5?=
 =?utf-8?B?V3V0Y25GUFZMclkzaGFGMER0MmhNRjJKc01qRWt2V0t1YllHMWhnQXkwMnMx?=
 =?utf-8?B?cnB2djVHS1Z5VXlaZkRpTWJkZHBQekpDNCtxNFFVQ0xGNkdzelp3TS8zN1U3?=
 =?utf-8?B?ZVZPN2pOVEVkcGJvZXlVK21xZXFSWXhneno2b0MzMFB1cUR0UlNGTGxOeFVC?=
 =?utf-8?B?VW1sK1RGV3ZCaUlpcGNYczg3ZzNDcjI2S0JXSkg3dExLTnJFOWlrWjVyTzNS?=
 =?utf-8?B?WlFXZHZJTjc3UGE3WVIwbEJwa1RQRFFiT21Hc2xTQ2RxVmZIVUNmZTFnSHBk?=
 =?utf-8?B?RVJmNE1lUDNGYm9oaUxidGx0anBVNVFyUUVDZ0dmOE1tSmV1V1lrZnRJS0tM?=
 =?utf-8?B?WVFJRTZpeURTWGRZc04rL2p3WEYvQkR6a0l2NmoyLzhPTmdONEw1ZlY5V094?=
 =?utf-8?B?WCtoRVd5c0tQTlFmK0RZZFJKU2ZkSWhORjY3VnBzcndPaEJ5Q3VHYlFmTC9Z?=
 =?utf-8?B?TkNGL09paXhaejlVT2ltdEFYM3BiL0R0QlMvVFJONVhuQS9DZ3BUbEhoSWdD?=
 =?utf-8?B?QS9jK0xMRzN4R2hRVzYrVDltQlV4dndZR0VDTEU1c29qbWZUUTBQaDZOdXRh?=
 =?utf-8?Q?MQgw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd53dfe-2ed1-4092-1f7c-08dbe0b43171
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 23:41:13.2992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ACvsegeHKpCW2DDHr4oZR2VFteyZUHEJFFo6z3/fV9n02U7o1yYhj3BcJZJMrdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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
Cc: ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/8/2023 5:26 PM, Felix Kuehling wrote:
> On 2023-11-08 18:20, Chen, Xiaogang wrote:
>>
>> On 11/7/2023 10:58 AM, Felix Kuehling wrote:
>>> Use drm_gem_prime_fd_to_handle to import DMABufs for interop. This
>>> ensures that a GEM handle is created on import and that obj->dma_buf
>>> will be set and remain set as long as the object is imported into KFD.
>>>
>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  9 ++-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 64 
>>> +++++++++++++------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 15 ++---
>>>   3 files changed, 52 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 4caf8cece028..88a0e0734270 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -318,11 +318,10 @@ int 
>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>                           struct dma_fence **ef);
>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>>                             struct kfd_vm_fault_info *info);
>>> -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>>> -                      struct dma_buf *dmabuf,
>>> -                      uint64_t va, void *drm_priv,
>>> -                      struct kgd_mem **mem, uint64_t *size,
>>> -                      uint64_t *mmap_offset);
>>> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>>> *adev, int fd,
>>> +                     uint64_t va, void *drm_priv,
>>> +                     struct kgd_mem **mem, uint64_t *size,
>>> +                     uint64_t *mmap_offset);
>>>   int amdgpu_amdkfd_gpuvm_export_dmabuf(struct kgd_mem *mem,
>>>                         struct dma_buf **dmabuf);
>>>   void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 4bb8b5fd7598..1077de8bced2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2006,8 +2006,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>         /* Free the BO*/
>>> drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>> -    if (!mem->is_imported)
>>> -        drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
>>> +    drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
>>
>> A minor thing for this patch: I think this is a correction for last 
>> patch " Export DMABufs from KFD using GEM handles". mem->gem_handle 
>> is created unconditionally at 
>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu.  drm_gem_handle_delete 
>> should be put at the lat patch.
>
> This change was intentional. Without this patch, imported DMABufs 
> didn't get a GEM handle, so I didn't need to delete one. With this 
> patch, I now have a GEM handle for imported BOs, so I delete the GEM 
> handle unconditionally.
>
oh, imported mem->gem_handle is generated at 
amdgpu_amdkfd_gpuvm_import_dmabuf_fd. Need refresh my memory after a 
while.  This patch is:

Reviwed-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>

> Regards,
>   Felix
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>       if (mem->dmabuf) {
>>>           dma_buf_put(mem->dmabuf);
>>>           mem->dmabuf = NULL;
>>> @@ -2363,34 +2362,26 @@ int 
>>> amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>>>       return 0;
>>>   }
>>>   -int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>>> -                      struct dma_buf *dma_buf,
>>> -                      uint64_t va, void *drm_priv,
>>> -                      struct kgd_mem **mem, uint64_t *size,
>>> -                      uint64_t *mmap_offset)
>>> +static int import_obj_create(struct amdgpu_device *adev,
>>> +                 struct dma_buf *dma_buf,
>>> +                 struct drm_gem_object *obj,
>>> +                 uint64_t va, void *drm_priv,
>>> +                 struct kgd_mem **mem, uint64_t *size,
>>> +                 uint64_t *mmap_offset)
>>>   {
>>>       struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>>> -    struct drm_gem_object *obj;
>>>       struct amdgpu_bo *bo;
>>>       int ret;
>>>   -    obj = amdgpu_gem_prime_import(adev_to_drm(adev), dma_buf);
>>> -    if (IS_ERR(obj))
>>> -        return PTR_ERR(obj);
>>> -
>>>       bo = gem_to_amdgpu_bo(obj);
>>>       if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
>>> -                    AMDGPU_GEM_DOMAIN_GTT))) {
>>> +                    AMDGPU_GEM_DOMAIN_GTT)))
>>>           /* Only VRAM and GTT BOs are supported */
>>> -        ret = -EINVAL;
>>> -        goto err_put_obj;
>>> -    }
>>> +        return -EINVAL;
>>>         *mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>> -    if (!*mem) {
>>> -        ret = -ENOMEM;
>>> -        goto err_put_obj;
>>> -    }
>>> +    if (!*mem)
>>> +        return -ENOMEM;
>>>         ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>>>       if (ret)
>>> @@ -2440,8 +2431,41 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct 
>>> amdgpu_device *adev,
>>>       drm_vma_node_revoke(&obj->vma_node, drm_priv);
>>>   err_free_mem:
>>>       kfree(*mem);
>>> +    return ret;
>>> +}
>>> +
>>> +int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>>> *adev, int fd,
>>> +                     uint64_t va, void *drm_priv,
>>> +                     struct kgd_mem **mem, uint64_t *size,
>>> +                     uint64_t *mmap_offset)
>>> +{
>>> +    struct drm_gem_object *obj;
>>> +    uint32_t handle;
>>> +    int ret;
>>> +
>>> +    ret = drm_gem_prime_fd_to_handle(&adev->ddev, 
>>> adev->kfd.client.file, fd,
>>> +                     &handle);
>>> +    if (ret)
>>> +        return ret;
>>> +    obj = drm_gem_object_lookup(adev->kfd.client.file, handle);
>>> +    if (!obj) {
>>> +        ret = -EINVAL;
>>> +        goto err_release_handle;
>>> +    }
>>> +
>>> +    ret = import_obj_create(adev, obj->dma_buf, obj, va, drm_priv, 
>>> mem, size,
>>> +                mmap_offset);
>>> +    if (ret)
>>> +        goto err_put_obj;
>>> +
>>> +    (*mem)->gem_handle = handle;
>>> +
>>> +    return 0;
>>> +
>>>   err_put_obj:
>>>       drm_gem_object_put(obj);
>>> +err_release_handle:
>>> +    drm_gem_handle_delete(adev->kfd.client.file, handle);
>>>       return ret;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 4417a9863cd0..1a2e9f564b7f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1564,16 +1564,11 @@ static int kfd_ioctl_import_dmabuf(struct 
>>> file *filep,
>>>   {
>>>       struct kfd_ioctl_import_dmabuf_args *args = data;
>>>       struct kfd_process_device *pdd;
>>> -    struct dma_buf *dmabuf;
>>>       int idr_handle;
>>>       uint64_t size;
>>>       void *mem;
>>>       int r;
>>>   -    dmabuf = dma_buf_get(args->dmabuf_fd);
>>> -    if (IS_ERR(dmabuf))
>>> -        return PTR_ERR(dmabuf);
>>> -
>>>       mutex_lock(&p->mutex);
>>>       pdd = kfd_process_device_data_by_id(p, args->gpu_id);
>>>       if (!pdd) {
>>> @@ -1587,10 +1582,10 @@ static int kfd_ioctl_import_dmabuf(struct 
>>> file *filep,
>>>           goto err_unlock;
>>>       }
>>>   -    r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->adev, dmabuf,
>>> -                          args->va_addr, pdd->drm_priv,
>>> -                          (struct kgd_mem **)&mem, &size,
>>> -                          NULL);
>>> +    r = amdgpu_amdkfd_gpuvm_import_dmabuf_fd(pdd->dev->adev, 
>>> args->dmabuf_fd,
>>> +                         args->va_addr, pdd->drm_priv,
>>> +                         (struct kgd_mem **)&mem, &size,
>>> +                         NULL);
>>>       if (r)
>>>           goto err_unlock;
>>>   @@ -1601,7 +1596,6 @@ static int kfd_ioctl_import_dmabuf(struct 
>>> file *filep,
>>>       }
>>>         mutex_unlock(&p->mutex);
>>> -    dma_buf_put(dmabuf);
>>>         args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
>>>   @@ -1612,7 +1606,6 @@ static int kfd_ioctl_import_dmabuf(struct 
>>> file *filep,
>>>                              pdd->drm_priv, NULL);
>>>   err_unlock:
>>>       mutex_unlock(&p->mutex);
>>> -    dma_buf_put(dmabuf);
>>>       return r;
>>>   }
