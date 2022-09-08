Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B3ECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 06:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FE7710E963;
	Thu,  8 Sep 2022 06:11:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C331410E963
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 06:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAg5fxyVzTRKU0NEXly0znmTGniXMem0GZNqk9iMRdZEgCgnHZTrUnB4dmIT+uhwFc8OfrJdXsgdTapcvzOxkQOzvG3ST2d79C4tEhPg+Hx3OMXcMQtnXIT+BloHkabdQD/dufd6eFmg+hlXdxEnYOfRM+N6HdeI69q/J9S7jHsV7Ts4ks680ImbkwICGUrm20CMxfE5ElmDUp9WdD/C1Iaf7816/2yo/fY/jSVJYYEwuE756h0pNkVqqdRGjg4EAqOihiVsXllT9v/gx7DLpetq+jJGwoJywofKEThgQVWxXoQf/zCxWs/yHQ5xWigev5pvTdjnTEtEs/e86e5svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RsTccqP9xBm2admP8tKrpgHgFXqQzU+9dTnPkwtxP8=;
 b=eV6AmxZ3WlZvBVE/5/R51xAZRNz76Q+JomyLvbDUmidDsHwioCP1UZ6zfGxqTAkKNtWIx9FjRvSMwUMDqMvVdysu3m5IVclaJMn36aZ0/VpqudH9uocwN4515wxFYDyCq492Um81CaP43R/CLde/l55RYhRki/QKppLXpaBr3yvYbfjufirszD4mtOHsHf55xW+J77HvqdxR8b7HftLWsxgWqegrThmkNjfDOUN+A7ak76Y50M2ddQU+5PQPn/VLX1hERwKzBW/J4ntITDeSZ2lQfu53O/wHPsE3eCjPgWgOWp9Xj7wGHfaZLqKvTdxxRsvY8Zc8jJWmoU7A5o1I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RsTccqP9xBm2admP8tKrpgHgFXqQzU+9dTnPkwtxP8=;
 b=2AH26Eif/vYKtY9lSj1zQsxWCfslILwyXxKYmUiA7ii4JS4YC/ePGt1N0kou7FaCzOw9HN+nAOmaGlN4deY/IN9wmPdj7CCfVl/KfEGSWbcjkFxKTJz+YtW1dZs1bLzgQp8XjaNVDLlUJzKR5PKXLwizPSgn3s1UWmYsnFCKPg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 06:11:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.015; Thu, 8 Sep 2022
 06:11:02 +0000
Message-ID: <d8d6db5b-c516-076b-f7a0-9353c620d42f@amd.com>
Date: Thu, 8 Sep 2022 08:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] drm/amdgpu: Set MTYPE in PTE based on BO flags
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220907000256.452005-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220907000256.452005-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0009.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aadd35e-6976-4f24-1961-08da9160e81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EelHrBp+sDTdcC8J8tU9Xm0vLfuXPkA3G3h9HmWmmv1NlMNPn5jUDfkgYKoCCDA1p2BldI/xus1OyRzO3aQTQ4IvpewoQ6r8+HPHXb2aRmQl+ePSjRqnySQfojl8eB9BvmAMuhe9moHrOFQdBRGxmfCATR/UdXiMb19pndmXdwdvBeH4EROti9v0uDk+zCijF4bKXko0L4WNMbAhnEt63tcGkYwF107b0X4T/0T0v2Z/2CNxDcqkwArQ2kXg3bNQiU8lne9i0q0tCpCTTYJHU1J0kMRXxh7OVpULYLwRCout9qKRlYwk+G6mUWS8bVMQOyQ9lCGr1myCryfw4dujjhhPb8IzH39ji8d49tPzL4/lqYEiI25vVfRvBleRCcPH24YmBkagc3QngeAV4pNQ1gYD+kkEPo771l9aD1zS1W9mEJK4LBP4fcz3nrndoBr3pz827mpsU7NeNxYTnHQa4ylzYooJunYEwVHZp2N7/P/ckJFondm1SFw49Aico9t90VWmVWrF+XxPMMpe63zAkZAtIAAIXXiIRkjAOUa5lLpfB0A85UGi3SYw1Y6QdTfUQEJwKRFV2hhNFZIMMCwPjcrnkVWNKuvbYrGem6x75bY4WBHNtB5UaCBdgATqt7gsG3L4qpZFX263WahLWhzhlKbU7n527KlL+Osh9nBBHz0u4Wik5rmLyaSu2dGTP9O8hU3TCy6MYau3M3XtoQ3rnhGDdj8jSRLq9EQTpO46dE7e7KoCnZbtt5fHXxqo37dgd0J+vDHJYvMF9xFZN9KDqXHAChxRFAOUY7DNMGoo9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(31686004)(8676002)(66476007)(66556008)(66946007)(2616005)(38100700002)(6486002)(66574015)(41300700001)(186003)(6666004)(6506007)(6512007)(26005)(478600001)(316002)(2906002)(36756003)(30864003)(86362001)(83380400001)(5660300002)(8936002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5wZnB2TjRyaUJ6Q1NFQXJ6TE0vYVloei9TbHBiYWZGU2dQMFFKRmFTSGZN?=
 =?utf-8?B?eVY0OEdkRy91Y1IwNUZnV2t0NFlxNWx5T0VTbjJSbUNqRmpPQlV6NEhySmRx?=
 =?utf-8?B?aW05N2J2dDh6cnUwMFBDNFBjVUVsWTE2YTFhZi91VlNxNkIwMFU5NDVYZ3o2?=
 =?utf-8?B?ZDdzNjViYzBxRTgzT2VYeXZYK25HZXR5ZUlSakxaWXFaaE1xRkVPL3F5Y3Fz?=
 =?utf-8?B?TFA0UzhsMW5lMWl6a2labHdFaTh6Y3N6cXg0T0I0d2h1RWZ6K3NDNSszbVJM?=
 =?utf-8?B?eGh3MEhLS0xiUmZjWENZRFhJV1VOVmg5MWMwNEY3VUx2RDY4SFBsV3pyMUN2?=
 =?utf-8?B?VWYvdVJuVVNsTEZpam83c1BNWVo5eVJNNk9La2ZMM05pNWhlamlxMzhTMW1t?=
 =?utf-8?B?cGZWcUQya1lVSGhZa0I2SkNnMy9yMWVSOGk0elJXQ1lTekMrTVdXaURvSUcr?=
 =?utf-8?B?anpFeSs3VWZhazB4L3ZaVDMvT0tmNDIrNmRLdmM5MkNoaUpaU24yek9MeFJo?=
 =?utf-8?B?ZXozeTlTeVVjcnhDZ1lQbUpMbGo5T2w2SVlaSmJaWWZDT1pqcG1adzJPNWRI?=
 =?utf-8?B?Z2c3MFpENndKUjYrWkt4eUVVbmdJbzlDS3JjMGE5ZC9XbW1qRU0rblJJTUd6?=
 =?utf-8?B?UFZGSEZJc1IvOUx1ZDcxOTE0RlVURWh3THVMNTF5ZDlLWGtlOTQxck5JZEtZ?=
 =?utf-8?B?Q3FIZWErRUhxeW90MXFMQjdDNjFSNFo2QWRBN1hWc29yRkVtRXI2anBVYTVs?=
 =?utf-8?B?bndVMzhRZVdNRTZxVEFzMWV5bXh6SjlrQXQ0bWZCeDFJMnBRdWVRREg5djZj?=
 =?utf-8?B?Ti9Fb0VEYnRKWGwzU2lsdC9FQzNVay81QktINFl4SWFNdG5TenFTTXdrUWdn?=
 =?utf-8?B?OFcvQ09IRSs0ZHNBT1MzZVNJVCt3UDlicmpnZnNGbXFDa01mR3lBUitUcGdZ?=
 =?utf-8?B?UFNsM3ZvVFpVKzFJUzVMSzkwVmV4dXFESzVscDhuZGxEVmVhTEhvMjBheS83?=
 =?utf-8?B?Y0FwNGs0blIzZWJKcjNNZmVsR3kzK3I3QjRTR29Md0ovY1lwU2ZCY1JMMDJO?=
 =?utf-8?B?b25vTDROOVpoRzFyY0lhN2MrVUVOZzR6eG5Tdm80T050djgrQUx5M1VYdGpB?=
 =?utf-8?B?Qlc2STVDRkdqdnRDcG5nK2xDMnRSWm1kYmUzcFYrQ2NZTDB4UmVHNjRNdjhM?=
 =?utf-8?B?dGdpYjJzK3JRM3Iwb1RqYTRiYUZnQm1TZnBDRm1TeDd2NERiTUIrV0ZVSi9i?=
 =?utf-8?B?QXp1ZUtMUk4yN0VCdmRFZWRyR1N2WDdoQzJQMmRpY2tmWXNVZTRmOWx2V2Fr?=
 =?utf-8?B?VjFQcTlQUStpNDNlRFcwQ3NNQlUwNS94WEdNb05vbWgwdzJvNlBxSFJwRm4y?=
 =?utf-8?B?U1hlRWsvV3hxZzZ2YlZhQ3hFVjIrWjNSd0R5THlJYlR0SlduSVRBUUpvRlNj?=
 =?utf-8?B?TlR0aHFLNEZRdWJOM29oVkFvKzJNc1hMQXl2NmN3QUFzWkVnZy9VMFBaNlFu?=
 =?utf-8?B?Y3JEOFFReEpwQVRIeTFtOHE4K0p3cFZwOEdGL01rNWFCemt1UW1oOGROWFh4?=
 =?utf-8?B?aGljanF6eEowUGhUVlRyQmtPQ2dGUTNnSFBOSnhMMmhYMk5PNDRkZ1E5djFP?=
 =?utf-8?B?L2M4NlpGT29wbmR1eDFRZjByL0V0S0c1Q3BNTFd1RGhMZWxWcHRYbzRtcWR4?=
 =?utf-8?B?bm44TU5qc3dnY3dULzkzR2MvRDBXcy9MaDVyM1NmYjk0c3hXRWk2SGptWnBN?=
 =?utf-8?B?YWNSZ05ldVJFbEZFZzZmU2NHelZYUVpIRVVDTTlDNUtzbXl1OURSVWNhSld6?=
 =?utf-8?B?aWJPemozMDJHVmJXYkFHZlpUT053QStOdFJMSCt2QVp3U2Y4ZUdJYXRWbWdC?=
 =?utf-8?B?cXdzMXU4VU8wdlhZR0dBbDRwZHp4YmtPWDV0RlRuZDFhbnNwYStkem1ZNUln?=
 =?utf-8?B?Z3NMbXRlWXJ5dnAraWk1ZTEvZ25LcnIvMVVRODBMTjhFVlVvdVk1SkVPUnBJ?=
 =?utf-8?B?K29Mb1J3dSs5RE1jOFA3WTFzMzZ6R2UyWURwRFJOdFNYclltUVRJUXNmWStT?=
 =?utf-8?B?Q3doRE9wVFlYUCsrRXNkeXJvVGdKQjBJSkVxYjF3Tjg4djFVUnV5L1ZEYXU1?=
 =?utf-8?Q?yjpzj9kCNKWax/Vn4yp9GQvmQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadd35e-6976-4f24-1961-08da9160e81d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:11:02.5486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9eHG9j8IjO/46jMCq7scyac2RYRadWtxMhahSudgV5uhoUGhyM9sqhgJRA5THUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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

Am 07.09.22 um 02:02 schrieb Felix Kuehling:
> The same BO may need different MTYPEs and SNOOP flags in PTEs depending
> on its current location relative to the mappint GPU. Setting MTYPEs from
> clients ahead of time is not practical for coherent memory sharing.
> Instead determine the correct MTYPE for the desired coherence model and
> current BO location when updating the page tables.
>
> To maintain backwards compatibility with MTYPE-selection in
> AMDGPU_VA_OP_MAP, the coherence-model-based MTYPE selection is only
> applied if it chooses an MTYPE other than MTYPE_NC (the default).
>
> Add two AMDGPU_GEM_CREATE_... flags to indicate the coherence model. The
> default if no flag is specified is non-coherent (i.e. coarse-grained
> coherent at dispatch boundaries).
>
> Update amdgpu_amdkfd_gpuvm.c to use this new method to choose the
> correct MTYPE depending on the current memory location.

Only skimmed over this but in general the solution looks really clean now.

One thing that I've noticed is that you don't NULL check the BO pointer 
in the mapping. For PRTs there is no BO backing a mapping and this will 
just crash.

Apart from that I need to take a closer look when I've found my glasses 
and have a bit more time.

Regards,
Christian.

>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 59 ++------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  7 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  7 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 77 +++++++++++++++++--
>   include/uapi/drm/amdgpu_drm.h                 | 14 ++++
>   5 files changed, 105 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cbd593f7d553..19d72d323355 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -404,63 +404,15 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   
>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   {
> -	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> -	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
> -	bool uncached = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
> -	uint32_t mapping_flags;
> -	uint64_t pte_flags;
> -	bool snoop = false;
> +	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
> +				 AMDGPU_VM_MTYPE_DEFAULT;
>   
> -	mapping_flags = AMDGPU_VM_PAGE_READABLE;
>   	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_WRITEABLE;
>   	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -			if (bo_adev == adev) {
> -				if (uncached)
> -					mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -				else if (coherent)
> -					mapping_flags |= AMDGPU_VM_MTYPE_CC;
> -				else
> -					mapping_flags |= AMDGPU_VM_MTYPE_RW;
> -				if (adev->asic_type == CHIP_ALDEBARAN &&
> -				    adev->gmc.xgmi.connected_to_cpu)
> -					snoop = true;
> -			} else {
> -				if (uncached || coherent)
> -					mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -				else
> -					mapping_flags |= AMDGPU_VM_MTYPE_NC;
> -				if (amdgpu_xgmi_same_hive(adev, bo_adev))
> -					snoop = true;
> -			}
> -		} else {
> -			if (uncached || coherent)
> -				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -			else
> -				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> -			snoop = true;
> -		}
> -		break;
> -	default:
> -		if (uncached || coherent)
> -			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -		else
> -			mapping_flags |= AMDGPU_VM_MTYPE_NC;
> -
> -		if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
> -			snoop = true;
> -	}
> -
> -	pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
> -	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> -
> -	return pte_flags;
> +	return amdgpu_gem_va_map_flags(adev, mapping_flags);
>   }
>   
>   /**
> @@ -1670,6 +1622,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		}
>   	}
>   
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
> +		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
> +		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
> +
>   	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>   	if (!*mem) {
>   		ret = -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f513e2c2e964..f14db7d3c33d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -612,6 +612,8 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
>   				 struct amdgpu_bo_va_mapping *mapping,
>   				 uint64_t *flags)
>   {
> +	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
>   
> @@ -628,6 +630,11 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
>   		*flags |= AMDGPU_PTE_SYSTEM;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
> +
> +	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			 AMDGPU_GEM_CREATE_UNCACHED))
> +		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
> +			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
>   }
>   
>   static unsigned gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 846ccb6cf07d..6ff4de7d8709 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -499,6 +499,8 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
>   				 struct amdgpu_bo_va_mapping *mapping,
>   				 uint64_t *flags)
>   {
> +	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
>   
> @@ -515,6 +517,11 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
>   		*flags |= AMDGPU_PTE_SYSTEM;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
> +
> +	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			 AMDGPU_GEM_CREATE_UNCACHED))
> +		*flags = (*flags & AMDGPU_PTE_MTYPE_NV10_MASK) |
> +			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
>   }
>   
>   static unsigned gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4603653916f5..58a2d1c8a188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1110,6 +1110,74 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   	}
>   }
>   
> +static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
> +					 struct amdgpu_bo_va_mapping *mapping,
> +					 uint64_t *flags)
> +{
> +	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
> +	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
> +	unsigned int mtype;
> +	bool snoop = false;
> +
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(9, 4, 1):
> +	case IP_VERSION(9, 4, 2):
> +		if (is_vram) {
> +			if (bo_adev == adev) {
> +				if (uncached)
> +					mtype = MTYPE_UC;
> +				else if (coherent)
> +					mtype = MTYPE_CC;
> +				else
> +					mtype = MTYPE_RW;
> +				/* FIXME: is this still needed? Or does
> +				 * amdgpu_ttm_tt_pde_flags already handle this?
> +				 */
> +				if (adev->ip_versions[GC_HWIP][0] ==
> +					IP_VERSION(9, 4, 2) &&
> +				    adev->gmc.xgmi.connected_to_cpu)
> +					snoop = true;
> +			} else {
> +				if (uncached || coherent)
> +					mtype = MTYPE_UC;
> +				else
> +					mtype = MTYPE_NC;
> +				if (mapping->bo_va->is_xgmi)
> +					snoop = true;
> +			}
> +		} else {
> +			if (uncached || coherent)
> +				mtype = MTYPE_UC;
> +			else
> +				mtype = MTYPE_NC;
> +			/* FIXME: is this still needed? Or does
> +			 * amdgpu_ttm_tt_pde_flags already handle this?
> +			 */
> +			snoop = true;
> +		}
> +		break;
> +	default:
> +		if (uncached || coherent)
> +			mtype = MTYPE_UC;
> +		else
> +			mtype = MTYPE_NC;
> +
> +		/* FIXME: is this still needed? Or does
> +		 * amdgpu_ttm_tt_pde_flags already handle this?
> +		 */
> +		if (!is_vram)
> +			snoop = true;
> +	}
> +
> +	if (mtype != MTYPE_NC)
> +		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> +			 AMDGPU_PTE_MTYPE_VG10(mtype);
> +	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> +}
> +
>   static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   				struct amdgpu_bo_va_mapping *mapping,
>   				uint64_t *flags)
> @@ -1125,14 +1193,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
> -	if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
> -	     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) &&
> -	    !(*flags & AMDGPU_PTE_SYSTEM) &&
> -	    mapping->bo_va->is_xgmi)
> -		*flags |= AMDGPU_PTE_SNOOPED;
> -
> -	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
> -		*flags |= mapping->flags & AMDGPU_PTE_SNOOPED;
> +	gmc_v9_0_get_coherence_flags(adev, mapping, flags);
>   }
>   
>   static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c2c9c674a223..f9bdc4f388ef 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -144,6 +144,20 @@ extern "C" {
>    * content.
>    */
>   #define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
> +/* Flag that BO is shared coherently between multiple devices or CPU threads.
> + * May depend on GPU instructions to flush caches explicitly
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_COHERENT		(1 << 13)
> +/* Flag that BO should not be cached by GPU. Coherent without having to flush
> + * GPU caches explicitly
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */

