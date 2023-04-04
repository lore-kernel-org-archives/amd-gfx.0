Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A809C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 13:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D8D10E552;
	Tue,  4 Apr 2023 13:45:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649D610E552
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 13:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIJAxghhRbUVubFwHy+VPfGmpNGV8ETEZCm5/G6iJ8L+kUSSB4spOlIQKSfP5ANkYEGyi3stvqUjlNKIb7Qg+AY5B/Bbg/v95sUYIUecmZkFTJOXIbW3AmkWybJVChu2ILh04HlyBcRwZDuLRX35gHRLluCG6+dB2W7QL/UehWIlIa/7Ns+uDVhyvFQEHq0ctOl4hK9js8ur8SZWJejLm9TN192imO7cJo6hX/zN7WdVDCIlfwKnFxMfvs3saRq5db2WpBk8H6sXYcbNnri6ZKiuX+RAhJI9awGtZUBDnFQhGkfDEClDL1J1poDXLa2Yd1Ws1GXTkqNPG7aaEpLlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5IsbDYmy+b6a8PP8P6KvJhAMg4qeWN7N6zGiTxpL/Y=;
 b=dqpKmQLeOQnjd6fDF0AEYeWSaIxAn3IIUxjkRiVE/LjpeAHYwDMBygaDQHJ6Yc6jxcEOxsHfpN7o4EoVaFLnjfzw8957JAlZralve0tU9+0VP5dNXXxmTliTHWWROvB9o9k1e3l+d06DzMYaC2/uffvEnFOPg6f/f+wMcNiIyYWDj+m6WotcgeKfvMUywp+tYXoYcbn5B+JXx31SEgF6y5rKmbA8w6i6fqoqOOEMJOCrqsYceqsBO5N6XZiv4SR875MOFlqeawfAZWTU6vybgGFBl2GRBU4g0B5vULWXsaQuFnGIE9II4zW4U0ny+bU4fNthTmcCzcLtlwsLUO8ayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5IsbDYmy+b6a8PP8P6KvJhAMg4qeWN7N6zGiTxpL/Y=;
 b=16Q/RzDGK8x9Jm6wLrC34VJBraztord20f+gog9EAf/KlOmrMgahGf/WZQ6JhknonUSFADYOIkqAbZ4f5shssQs5MZCxnDdcGTr63DCcIw1+GpgDx7LGiGGRhNZ4pKrp+yRlotG0edoChp84zNIDGcU3m0bVkeJ7A+Z2HtBgzzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 13:45:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 13:45:11 +0000
Message-ID: <539b143b-64fd-9108-1967-04e2ef27848e@amd.com>
Date: Tue, 4 Apr 2023 09:45:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Xiao, Shane" <shane.xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
 <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
 <c5bd045a-a5ff-36ea-ed9b-bc4732b50b16@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c5bd045a-a5ff-36ea-ed9b-bc4732b50b16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d58db1-6aa7-4ded-e4c6-08db3512cfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZNf5nVEBHcmbd+eAiVRe2fx0fTf1AraCiOHmzXauu4J5+RZIefSTX+Iu+psP02vRFMxW7NZggcTb1vx2y+oxCdXHz24tNb5En9RhfOmWkiH23EFl30ugA6WYG+JMX1llJdgUck1uTKPAEJD/yQZqEqCESYpfUp7QZl0OKFox9DECtv3pd38Sf8u2khUYTYU0Hecvryh+YkHpwZQYt30N3P07moiXgPA8QG80e7i5fB1OmuIaRd7Tt3H+8cSs3Vrm/ilIV3lOb1PFGuNNQYQRFGJDuTp0pVEkdZGT/8fNS9kR0Y5xTLMWSsWeMkdVoq8sCLqpY1yAMJ2m39AIWSinPNnwPuApiWPPE1OBco0CZDlaFfO3SkoRYf80N7DKmex/DcIQ2p7TkzEHeHMXWJCZr00partQp/bgn2Ix3IcwOhgQ9H4Ke1u6gZeaVZpxz5dSn8WAzzVOZBVgdfrDtohl0HyPaCysc0WN/1g7eQVRsnqrEgKMr4TYE9pDlc9Be4NqSnN31ThZ3fo5HkgljKNmOKJh7rNbBwF7AjkMgl4yTb4yAIMMjAWqOrpBHGRqLt3t/l8UVBhO2aGF17u+qBnzblkl6akzPnKTza5AYv32Qnj+xbvDxUjcZ8Gj0GVjjij1j1W5VHJilfrAOqhi14EcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(41300700001)(66476007)(66556008)(8676002)(66946007)(316002)(44832011)(478600001)(4326008)(6636002)(8936002)(5660300002)(110136005)(38100700002)(54906003)(6666004)(83380400001)(66574015)(186003)(2616005)(6486002)(6506007)(6512007)(53546011)(26005)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUM4RkRDQTRsdW5OazF1V2JkdUhFcjByNEk1OWpGS00vSGpuYWNIQm1vSlFQ?=
 =?utf-8?B?dkoveXR3MmpQN1U1aURYVG9WUmNoUzVlVjY1YmRvd2Vod3crMEgwNjVRS2N2?=
 =?utf-8?B?WVlFY2ZKQjMxSFE2YTNOcXNiWFFxMTg2cmJSR1hQN0daSjhPS2VBNkVrVjVQ?=
 =?utf-8?B?M2VhdjhNanpWRW96enNLdEJNck1welZOVzJING9OR0c1Q2VLYjQ3U0IyWmVa?=
 =?utf-8?B?VXFRN21TYlZXbzZOTklUUVgxQU5Tc084Z1BVQnBtb3RmN0RmK1RRSkExd2xQ?=
 =?utf-8?B?a1RyeDB4OVp1djRiUUZJMXFEblIxZFdXN3p4TytqTGlTOUNxNFVtT2laOC80?=
 =?utf-8?B?eExPNlllM1l1SThuUFpMNnpUV1Npd0gvSU1Ya0ZyeUFIV21IL0s1TTlnT2lC?=
 =?utf-8?B?V0o4MDJXeWErSHdqekdBTHJNN3JwNVdKZmkwUHFnYkRGVjRaU3pGZHRscjRk?=
 =?utf-8?B?bGdPSENrU3FkTjNMV2xxWWEvNENidzRhelBXNEdKVDF0cXN2RWMzRjV0ZDI5?=
 =?utf-8?B?c0dhZ0FIeGNQeFJXSFJxU3hWcXRYYWc4VjNLUzlZY1JBcUJxVXYvQjY0cmVh?=
 =?utf-8?B?WUJiZzJTemFBWVM2NVllbnh4V1hmalZabStxeUhXbFgwc1craGRZVFZVdEJN?=
 =?utf-8?B?dUdEUzgxdVVEQmZEaTlVVFRCc1JVS0ROSW1LUmJzcHEzRXJFdTBaUWdWTS9Q?=
 =?utf-8?B?dUFMQUNNRjRndnRDMXdzUUFzZjc2WjNIMTJwSXQ5TDl2L2REaUQ2VS9NU3Zt?=
 =?utf-8?B?MnVxL3poYlViNnlWVWtLZXBJTGZGL3VOZUQ3dndzZXBlN3N2UkI0ZEIvalAv?=
 =?utf-8?B?cUg5dXMvTDZmVm9BTjBXOFMyU1Z2NFl3VXVKWFpKZjgyQ1REcVVZT09Wb2V1?=
 =?utf-8?B?WXhjU0REMklYNXNrcWNXdmFQTkVCUVA2a2VPdmgrY2thUlYyK1BLR0pZb3Jp?=
 =?utf-8?B?WkJQNVVTbEJFNXpDakpJQUdxUnpnekZkOExucXdON2Frb1lxQkJNK0RONTRD?=
 =?utf-8?B?QXE2RUMzNzRXNy9MckxudXR1MURJYUhMOXNWVnVlMkxUWVd6dGNtR1BlRk05?=
 =?utf-8?B?TE4rdldsNlA2aGRUU1hVUlpjUkQxNnJnbmFwWG5ROGlBZHdZRFpsa3dSdWli?=
 =?utf-8?B?Q3UrUUlzKzNZSk54bEl5bXVBVFlPbTNhVnJMdjJwN0Z4NDJqa01XakRPcFhF?=
 =?utf-8?B?dWkyaG5YckViRmtQb3lvc0VqKzBBc2h4aHptS282L3NmNlFQbzV2VlBDWkUz?=
 =?utf-8?B?MTRVZU1TVzJ3RTlVVjBUSGJuUmwyOVpMRVdQMXhLSzVLUnZKTEN2am50dm53?=
 =?utf-8?B?Zk12U1dkdGQxaGNwVmVDY1NJOEVCL1poZ2NRMFpaRXlsVm1ZSmJwNXM3U05C?=
 =?utf-8?B?UTVDNWRCUUxBaE5YKzZGdW85ZUpCa21OTmc1dm9BSmFtaU5KaVJjVzFrWWNm?=
 =?utf-8?B?OGZRVEZBMTZ2ZDBvZG9VVXkreWdpYTRtOTJPTGhtb0FhTFh1WUNkZFFhY0hR?=
 =?utf-8?B?ZXZiK3QwUVNsNFpxTGFqbnMwTVdkRnliR1BKL20yUXpqa1hKdzRITVdRQlVo?=
 =?utf-8?B?c2g4Z29XWmx4d2drcXZHckVRWTZjMlhJK3ZWUytqd1FxbnZ5ZUpjdEV3VXgx?=
 =?utf-8?B?OFpBMkY1QTZxOG9oUGFWN0k3N0hLZW9qSWJMVUxCMVZjV2FHUE9IOG85TStu?=
 =?utf-8?B?Nk00RXNBMjBDYzE3bW1JVlZudFF2MnhYdFltUE9hWCtHTElqNWpQTGE4OHRp?=
 =?utf-8?B?SUpLVk9qYUVVZnhOQllESWVtRy9mSEwwaGVkZU9QTEh5ak1pdDcwcHUvanVX?=
 =?utf-8?B?WW02WUc4dGZmYjVlcGFGczRDeDZPV0gyTzJYT3VHdU9KZmhEaHV4UmRsMkpE?=
 =?utf-8?B?Um5Gb2xlUGdzQlZyZk1idWJsZU9lbjNXbzhUYnh5aUxKbzNLM1N1alc1MU1W?=
 =?utf-8?B?RVcrQzBpMnB5bFYxKzh4R0g1SDJraXdTcUNMeXJaeVc0RVBEUTByKzA1akFY?=
 =?utf-8?B?VEtPZXloUVBuK1REYmVGblIzbDZlKzlodUZKY1IvN3R3ZDJGai91RDdWUkxB?=
 =?utf-8?B?QWtoOUZGSXlwOG5lRktJa3JvbERkOVlzcTI0Tncyb3ZFK1NWQmZQZW9jTm5s?=
 =?utf-8?Q?c16fBuBnSqGQzFZf6BGt/odyk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d58db1-6aa7-4ded-e4c6-08db3512cfd4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:45:11.7239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp/KJcoIJKzPULWIkkBFMkF8fePvYT/SAx/MSKvTX47XzTyaM0pkSnZnOubeFr2Sbw8tJb4W7qn/yUJUBq8XhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+Philip]

Am 2023-04-04 um 08:47 schrieb Christian König:

> Am 04.04.23 um 12:56 schrieb Xiao, Shane:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, April 4, 2023 6:27 PM
>>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>>> Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
>>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs
>>> when iommu is on
>>>
>>> Am 04.04.23 um 11:56 schrieb Shane Xiao:
>>>> For userptr bo with iommu on, multiple GPUs use same system memory dma
>>>> mapping address when both bo_adev and adev in identity mode or in the
>>>> same iommu group.
>> Hi Christian,
>>
>>> WTF? Userptr BOs are not allowed to be exported/imported between 
>>> different
>>> GPUs.
>>>
>>> So how can the same userptr BO be used on different GPUs?
>> If GPUs are all in iommu identity mode which means dma address are 
>> the same as physical address,  all of the GPUs can see the system 
>> memory directly.
>>
>> In such case, should we export/import the BO,  then create a new SG 
>> BO for another GPU?
>
> Yes, absolutely. Each userptr BO is only meant to be used on one GPU.
>
> Even if you could use the same BO for multiple GPUs it's not necessary 
> a good idea since you then have live time problems for example.
>
> E.g. what happens when one GPU is hot removed while the other one who 
> imported the BO is still in use?
>
> Felix can you comment on that? My recollection was that we rather 
> improve the storage of DMA addresses instead of duplicating the BOs 
> over different GPUs.

For KFD we currently enable sharing of userptr BOs between multiple GPUs 
by creating a userptr BO for the first GPU, and creating additional SG 
BOs using the same page list for additional GPUs. That way we don't have 
to call hmm_range_fault N times and setup N MMU notifiers for the same 
address range on an N GPU system. But we do have to create N DMA 
mappings, which is facilitated by the SG BOs.

We have a further optimization to not even store separate DMA addresses 
per-GPU if they are a direct mapping. In that case we just increase the 
reference count on the original userptr BO. (I agree that we should also 
look into more efficient storage of DMA addresses. However, last time we 
talked about this, you basically told us that scatter gather tables are 
being deprecated, but I haven't seen the alternative yet.)

I think this patch fixes a potential issue with that optimization. There 
is an implicit assumption, that the DMA addresses stored in the original 
userptr BO are a direct mapping, so we can reuse them on other GPUs that 
also use a direct mapping. But, we didn't actually check that 
assumption. I think this patch fixes that for systems where system 
memory is direct mapped on some but not all GPUs.

This scenario should probably be called out explicitly in the patch 
description. The condition is also getting pretty hard to read and 
understand. Maybe move the both-direct-map-or-same-iommu-group 
conditions into a helper function, say 
"amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, bo_adev)".

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>>
>> Best Regards,
>> Shane
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index e7403f8e4eba..33cda358cb9e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device
>>> *adev, struct kgd_mem *mem,
>>>>                 va + bo_size, vm);
>>>>
>>>>            if ((adev == bo_adev && !(mem->alloc_flags &
>>> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
>>>> - (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>> adev->ram_is_direct_mapped) ||
>>>> -            same_hive) {
>>>> + (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>> ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
>>>> + adev->dev->iommu_group == bo_adev->dev-
>>>> iommu_group)) ||
>>>> +same_hive){
>>>>                /* Mappings on the local GPU, or VRAM mappings in
>>> the
>>>> -             * local hive, or userptr mapping IOMMU direct map
>>> mode
>>>> -             * share the original BO
>>>> +             * local hive, or userptr mapping in the same dma
>>>> +             * address space share the original BO
>>>>                 */
>>>>                attachment[i]->type = KFD_MEM_ATT_SHARED;
>>>>                bo[i] = mem->bo;
>
