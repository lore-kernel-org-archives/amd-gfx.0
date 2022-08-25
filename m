Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB7C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 15:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C275C10E61E;
	Thu, 25 Aug 2022 15:10:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9353C10E61E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 15:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBnpdR4+Oy47FXjRJzwTDBhQmGIm+W6pTt5EIx/FlJcnhC7KoWfbVZpNz2PYB+6RB1UVr2PLif/G+EI72fSVpA3dwv7PQKt/TOFioZhAlUiZv0mwnq5YANVehOly1UPZKyBoOrN85LFVAWGHUtv/YYmies+Ox91JZjpVZE2DZDRYS45nPiaHlDmGraXhF29MH/I7XNBkfsxtzQJEYLLSqUr0STF/NleGc+M9GK86IE2qsVv7qkldDAdHM+nY7aplap3Tt9Hfu6jinK/9Iit1a6R7VXQJavNQxdjAvkhla0h7a0hHNroBagxuvvGCROymjFykMWuPC4LRx/fNoPwcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqxJaAX6fuSmPAFp4N6A13DktPBMJKyWarWiCRTRCq0=;
 b=Y9VvXiX/mwJcS29rNmnpHmUJqCVqXB0Zs+6F8BJK0R/vgjyQVzKhwBH8iUSadsMsqZmFacMpc92mQT9hhieapMUi56scz+0sozA2f8+YWyXe1dKePpuDb7PNM70dWt/IgzC13/sDfZUJjQqRqa8RGcsCbNQ8YF6THRvnq6m4j4s8MukPRTbSlsyXaCClAXPDPM/n9jJ7sLHpkq9EnGmJamPjGxt+p/WeC5kSlXHkVydxOfaXJ0lH5Z1ZORZidNtOPaTEq9Eh6StChPQwBl9pIFN93Lkr/5jJuoeQv2Kz05S/XAZqrHIMG12tLRzlmDVY/hH2WC5cI3HMuHCDOifcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqxJaAX6fuSmPAFp4N6A13DktPBMJKyWarWiCRTRCq0=;
 b=3U39bva4jsUYVvuSaAaaznMOZX/GWxAeNhRzudVc+PhisIMO0Ej77vTugt8XPcicofcVb5VlL2OjNFyTWHEZ+ttuxR6zWWQplR9qIa2+ANgrfZ0nvqq/6/mwd+bmtLm+/yqmf2L1aNA3PpVoiS0EW4WlMFPhR6aBdSFxA+9aMlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 15:10:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:10:20 +0000
Message-ID: <c12c9c63-241f-79a5-cf9a-b32b2c2a2f09@amd.com>
Date: Thu, 25 Aug 2022 11:10:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/11] drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220825133142.8272-1-christian.koenig@amd.com>
 <20220825133142.8272-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220825133142.8272-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bdb813d-58c7-4777-3427-08da86abed64
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSgpBJyfHqRwy4DJxYJ2ae0NmoYP26mBaSQQpzidZJY023JuuG+DFQxFns3/5Tdu6q4UwFiiGM5V7p0yUcODvpkIkXYynbgBk0NOXRLaeVYyBjBjdAvrY/aTfu3e1EALcaddWmrELiig6JIyq5ftjjk5gc4v+BFnBoCmLwX/kx5+Eyrkm6aWnEVgrp+a6/U91LNECMEhLdMQLf4rU/xtTiZLedheVrTQfwwKi5c5xfqgX5WItfNwO14haJgozdJ6gpNBwzbIKFRnh6QI+mqG4oJXrLG5p97QDtvLqse6JgtO1XftzOmdDv+R7jLppgcws221iggec5OwVdjJDIE9ZyCQNQXMltN9xTf8JqiQ/kD1lG90p0pE8yZ5tt2CNqvA3QGOHA8Dt2ggise6VzbmtrjAj+gzZwSR6JbI0b5iaql5GejqbF6qzgybQX81UwX31pc2EFsK0fnSf2OekJen6U8w/JO+xtGKpqD/DBYTwADGlDQYnmyE812PST4MA9+nXKpelvYt/7Dehqi4z9WXMulEBWLBOxc3SGxHxxKojUFVclBo/ZDHyXQtRopyP/lriEZm6oD+T5l/xLWFDt7DhPfi59K10UHTcFzu9LTRpL1CP57vbv+wdZd4B81jyAL+uH84JTNb2Q78jGpz4JoOdVYT0/ezR93igtMXvZBps7ZyN9yVbc26A9q0XmGW4E37ZEmgPyZjp+myd2VjlC1hQ76jHhPjJg/UmbrU5KI0ITlRS8F3EZ4aYsLs9hFdzg4GBFnaR5tv0rkLRWh3jQ37V3Cqb1C0q/Ep6bXoKqdIyGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(83380400001)(186003)(86362001)(66574015)(2616005)(38100700002)(36756003)(316002)(66476007)(6916009)(66556008)(66946007)(5660300002)(31696002)(6506007)(8936002)(2906002)(44832011)(26005)(8676002)(6512007)(478600001)(41300700001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWl1WjY2M3pZVUxXZ0laRWNlTmlFUFdDNmd3SGtTUkpMLysvcXIrU1ltbXRv?=
 =?utf-8?B?MXoyMmI1dGhxSDdLY0dHRUVMM2g0V0JRT2ZWNEVQL3FYQ0d6S3Z1cVpKSXNG?=
 =?utf-8?B?bEZ1ajJRME93bmpvYVl0MWtCQzRjbzR5NjRod08yVis5VkNWeEVRS1dlT0li?=
 =?utf-8?B?VEl3VHUvN0hFSEhBQVN0Qm9NK0hMcGh3aW1kQkk3VzhEam1uQStaVkNmVXRL?=
 =?utf-8?B?eUJSNk1sRWowZjA4d3J2bmdvZGlGN3dDeW5uclNQMGdGMXdOOWZ4KzZlSG42?=
 =?utf-8?B?UldXQ0pML1hjYmUxamRlUlNQbXhNVG5LVDBVSGRGaVBuaGJhSTdubnZMWUZN?=
 =?utf-8?B?VFpTSGVjWHYxdVBqVzk5M2ROdzUxbjA1UmxPU3FzcHJFUXhBV2tBWGJLVXFz?=
 =?utf-8?B?MGMzOXRhYW5oOUxhYlFJUEJkaHdSdjBkWE11aTJ5ekVvaUxnaTl6YzhUMk1B?=
 =?utf-8?B?M21WcXBteXl3aVlneTRUSlRscWcvYWYxOXNleno3UktCbGhiYWI0UHlMNlFM?=
 =?utf-8?B?YzBoUzlZR29DUzBBNEV0ZjVBVXpFZHFEdEtwSWd6NUlkK0J6RkRyVlFPQ3cx?=
 =?utf-8?B?Uk9LcTAzQlZMZGRyakNWUEY3cThnd2tZZUJZb3laZjJUVjBTVWhVeWlQSlJn?=
 =?utf-8?B?WXI0ZkZZUy91dnIyVENteXZ5NUZFOFhLaXJjeE1NVEswTURld2dKMFRZU0lG?=
 =?utf-8?B?Y0VWcjJHQlljSkFMQmVhVG1vY1VyZkNNWlg0Q1RXN01JNmpqNFBvZTJvd3g2?=
 =?utf-8?B?ell1QXpHbElxTk9EWVNBZ2duODFGOVMzZzRPd3Nib1RlMDJqYXZ4dUNoNGR1?=
 =?utf-8?B?cVlhU04yZzhGVVBhWkhHQUVSaWZuajdpQ2tNYXhtMVF1Uk9hOUpYRVJmYkpm?=
 =?utf-8?B?QkhoaTdQOHJRWWg5NmhLRHZsUlRQVk5aTWFVaXhySWZsMWpoWHMvdndqbFdX?=
 =?utf-8?B?MzRiZFg4UFUxRE9QZkU3b3d6Szh1Q3k3UXZBam92cFlwNWxvNzB0MXk4Zmts?=
 =?utf-8?B?S3N1WHZrTEdVeGdycUwzdjZuOE93VnBjZ1BBVjhFRnVhRmNaRDBOa1NuL3dm?=
 =?utf-8?B?ekRTMy9EZlUydXpUdUVWbnJJaUsyK0lKVU4zTlA2WlBZQkp3cUlIQjE3a0dN?=
 =?utf-8?B?WmZFQlMzN1JKUlVWRXF0NFpUNEZKaFlaU2FZSDJOaW16V1pwZ3JuMFU1azA5?=
 =?utf-8?B?UEtJbWJQTjBTTHRCbHBaSk5qdkl2L3ZKY3BleTlxQ0JvenU5S0VYZTRTL3I2?=
 =?utf-8?B?a0toOHRBTEhkaVptR25HS2YzbEpNdmtMVk4vcHhycitib2I0L1R2TlV2cUtt?=
 =?utf-8?B?NmhVSENrL01IQlROSTJVREhHTjR5YTRPZnJJRWFMZ1ZkV25kNnJhdUZNM0N2?=
 =?utf-8?B?d1NkU0w5MjdVRy81UGh1VlNMaTdqUWt5bUkzOFV1d2JxYS9sR3RqWkcwQlVH?=
 =?utf-8?B?M043TVhyeFQvU0dvSGNPT1FsQlY0RWRPL2Nnb2ZLVzVXdDREVFRjTmlLRG5M?=
 =?utf-8?B?RHVlV0Q5TER4WS9OQTlwek1RSklOVThnV3hIVTJkaHdWb3RKWEowRk1wSVc3?=
 =?utf-8?B?WE1TM2c4UEpHQTFJWEtQRlVxTDQyb1VvS3ZKN29hQm9Wc0JTT2kwQlo3aFVZ?=
 =?utf-8?B?TTNGOEY4cFg1ZVFUcVQ4czFVMVZzTWd3TklseHNESXBKRVhVNUtORkVHekFL?=
 =?utf-8?B?RFNNSFVXVDE4WU00RDh4SUJqd28zZTFYT0tkNDd5UFh5RFZMQWRqaWhYRytq?=
 =?utf-8?B?UDBiRytTT1JiL2dMcHpHQnpMa1lHSjBIM2tUSzU3SXBHYXZRakNZQUJVaG9y?=
 =?utf-8?B?TVdPMTVia0MvaGlKS1hlbjZUYWN6ZWdLMVVjRFVPVWlzWnhrc0t5cngwdTF5?=
 =?utf-8?B?N3kzelF5KzhtNkZoZ3FTRElUMW5VUlRRV2JGM3FQZVFFV1krZWtYUzRBREV3?=
 =?utf-8?B?OE93Sm9mOS8vcXFRc2dlZC9iczV0NE5KU2pDT0RlVldMZUJhaFNUdEorRlZi?=
 =?utf-8?B?eDlJaWFVeGRaR0xPSzkySGlZV0tyazZsUzA2NEdITVg5dTZtazY3aHdObzRu?=
 =?utf-8?B?dFRKRkhobERkOVh5NkpxMTd3Y0g0dGZXQzJMZmNBbFYveFJGMWR0VGlSVk1D?=
 =?utf-8?Q?WLPY4/nYKKoQXP9vXqijVyjDO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdb813d-58c7-4777-3427-08da86abed64
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:10:20.8049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTNoT/O1jm6f4/on2hkX2nltGnEZH2Wax4qUl9Lqf8TZ8EprXRUl0OF4LSKoolmseFa6iSHlFERYOaeO66fmnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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

Am 2022-08-25 um 09:31 schrieb Christian König:
> Use DMA_RESV_USAGE_BOOKKEEP for VM page table updates and KFD preemption fence.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c      | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cbd593f7d553..85eb68ec692e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -297,7 +297,7 @@ static int amdgpu_amdkfd_remove_eviction_fence(struct amdgpu_bo *bo,
>   	 */
>   	replacement = dma_fence_get_stub();
>   	dma_resv_replace_fences(bo->tbo.base.resv, ef->base.context,
> -				replacement, DMA_RESV_USAGE_READ);
> +				replacement, DMA_RESV_USAGE_BOOKKEEP);

This is only for the dummy fence when removing a real eviction fence. 
I'd expect another change where the eviction fence gets added.

Regards,
   Felix


>   	dma_fence_put(replacement);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 1fd3cbca20a2..03ec099d64e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -112,7 +112,8 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   		swap(p->vm->last_unlocked, tmp);
>   		dma_fence_put(tmp);
>   	} else {
> -		amdgpu_bo_fence(p->vm->root.bo, f, true);
> +		dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f,
> +				   DMA_RESV_USAGE_BOOKKEEP);
>   	}
>   
>   	if (fence && !p->immediate)
