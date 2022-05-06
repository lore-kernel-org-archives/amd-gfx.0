Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4B810EB30;
	Fri,  6 May 2022 15:04:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C405810EB28
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:04:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDnthxxEwsmlK3EuDXBRkLtsnn4KAoxhhRjArCQe6kqNM2sv2di3WcWXazqNxntJAUQGXfRTW2iafnh9JJoMO+WnR0ALDmzAjLDYc1psLmsTxQ+x6fOAQ4NBMw2Z83CBp6KAgdxLKr7DAzQNXe9UE2iCr9QgqqVr/l394X4f4xCFWoaro+pKOrLLjFLxOgvhZY20EfJl9+0K6u+aH4kG6cbcSqxh9sZMPCdSXdS3B2ub4KQcAMfu99LSQtR1K/n6VmUZqFWfX2ZUjPM8Y40up4zLDTLzNk9fBauI0mQ3vlKKpWnpAtlVnumQAHs1YzZtFzeXpEcLfTbPFSvUViKoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Slz9lJ1l6zTbxfj7LjM+UAQ7VJFteBbmdBg4YnUqujc=;
 b=mKw9qaproRiV/MmpFVuL8l9thfQcjZjsrGDmYGB1txcuEQXD4fWhHawUpl8NTWtWll7yL9IyV0z9XiWNPoK9r4i/x34nsNUQbQ0ppj0RjA76PNrBvsEwlVGY6XXa+s8Sk5soXXQ9pKzH0Ly4Suew2NFLH5+jKJP/aqmUVWQh9G8PjCRPrumdFI/1UbigwkKTudzUdeGIExvdeT3WuawtolK73aXjhhvZ7pVJq3VP13QqcQ/57w6FeZMF5zBF+QnuYOJZHWnFO/+qmN0pnp5wC7ujf/8o0hcJ8N0uwY8xrNmbpdjeWGxCdr9U1bGbr5XcKy2PVxEqW/cMB2KLmXTrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Slz9lJ1l6zTbxfj7LjM+UAQ7VJFteBbmdBg4YnUqujc=;
 b=NrzuMQGg2A81Zi58fsVvtH3R06r4yidJE+xwstk5ApCZtskFybxk265HLbjMBWGmtLYVO4EX7rM4pp88/9e+u5l7fS5GhlogKjpldX5O8KIK6OjNP5swShon2+JYrgV/HZfnJpf8/M19+gZf4FICwP7cYOYn3cy4+5GDzrC0j0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 15:04:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 15:04:47 +0000
Message-ID: <7d3d6769-5208-4298-4227-042b0fae1efc@amd.com>
Date: Fri, 6 May 2022 11:04:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Marek.Olsak@amd.com, amd-gfx@lists.freedesktop.org
References: <20220506112312.347519-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220506112312.347519-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac52c243-98fb-45d6-0e80-08da2f71c1e7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4469D5FD8F164E4B045F699B92C59@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MR0B9YqQ60YdIQWOjgqTxHYWuXtiELsxluOkqPUTPhGTHh5oZHUBqxn/MLoYCYPP81611G5fctp2kXVX4Ss+UZFwS9cJpALY7mkGpXIrTWSh6RG+hlijF5N6w9Rnc3YCvjM9dYUHe9TMTy9OG1mwDYJOaT272kVI+85Ssy/50nLTtPQ1TWOB2KkkyTITw3m5Rob2G9wqzaCoCvm9o+9kCfEDZJ2AfN+vjkd5EiGNcb6wuFPFTqjnIAV6q/9eu1anhSOC04kn4J5GXUt1Qx+9BZVLB/+/mp4YD08Bp3ijHU/MPYlMlqPnVyZ2oFvq/X3VXIP+EZ4BwnjIDirRQonr2NBtv8USFeZsz7DeOVcH3IA7FEa4oieDAsR7umuC0AlmjnGyOYp7JcG8jckgtLxRwl+zeH9hENARkYf68T1MXwrlBs3BCiahhSW01GnKQ/VXRWNBiLdXFvZ5ZotmKPcRWps3uLqlFUUKjrJATOdoSTtzBO1aoUyqgCAVresDXBRPcBjKuPo9VyllEfWJsgxc3E4Nejmkydyc0EIpaA+W0h42MVCe+FR/JbhybZgd7HDEdgAtuZVoUJymIpYRWdV0iSIvKue6RgkvEFZ2L/4c4OMAeHeaEecJeoL8V4bR74HS5ebyb9mFCsKKSAPsBi+EFo/EpYa+eqw7bze277EO6ycOhg2uPCW5zVumee3yZpdxSuMO/6kwqf5V2svKkj5ZPD+EE4oulZp92REkrvRKSKA9bplk+O2AW15HYi3VXpHb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(36756003)(6666004)(2906002)(31686004)(8676002)(6486002)(26005)(508600001)(38100700002)(66946007)(66476007)(6512007)(66556008)(5660300002)(316002)(8936002)(86362001)(31696002)(66574015)(186003)(44832011)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUlOY0JLczZuaGdmYStXU2pNZlZHU3NOakdjLzhjL3RWc0wwN0puVFBlcWhh?=
 =?utf-8?B?Y1pCUUxiZ2w1YTM4K1hmL1hEakJpcEZHbDBSTU5EL21KeXdtQ0x3Q24yQmQ5?=
 =?utf-8?B?L2JqUGxySU9qdDRLQTJZcENBSFJMRUt2dlk2cGN2L09iTmVtMzQzTWpUczVS?=
 =?utf-8?B?SmdvSmlDYXV1c0sxMExmOWRnQi9jekErV25xZkFWOFJIUnRXYklVYXI0QnNr?=
 =?utf-8?B?WStpcjlMcy92Wld3aWtORFdtdXVKZWlRT0l2Zkd2eEpXOVdMSW9kRnF3Sm1s?=
 =?utf-8?B?NlFISThCVjNNblBpMTNlVWUvNU1iTXhZUkQzR0sxc1JiR2VSSzZGNnJWU0x5?=
 =?utf-8?B?cXN4Rk4vejUvQm5Ka1dxVFFnT3dVTlR0Yk4wcHh3UkFpcDlRMGtHZEQrTEY4?=
 =?utf-8?B?eDl3OEtjV0FBdXJKOXNaYkdaZ3hLS2xnVXJSYU1Nd3JrclFxTGd0S1gxdnVN?=
 =?utf-8?B?VHlaVmNmSzR6MVZqclJ6eDYzNmZ4QkwrckNEd3F4YWtiYVc1QzBJNHdNbFM0?=
 =?utf-8?B?dHJnOEtBSVBkc09va1A1RFM5RTMrMGhYRkFJTHkrM2hvdDdIdVRQSnpBOUs3?=
 =?utf-8?B?di9FYjlTMk51dE9QMk5JSWVWVjM2clVZdUEvRmJKTTFQcWhXNVNMaDJZWitq?=
 =?utf-8?B?cDV5bG84YU9xRjIzMzFFalBqS2NnRFpsOVhSTklOWHYwMHlzbiszS3FmdVZz?=
 =?utf-8?B?TzFvL1BvcVpkR2g2aWw3U1c0cW5mZUhseVpON2pOSXVHOC9zK00yNlNpakhu?=
 =?utf-8?B?NnJkZ1lGVW5hZ3RpRjFONllPaElGNnZoOWxFOFlKRkVHSFF6bXpJWlhoa1Az?=
 =?utf-8?B?Y09kc28xU0tPMGd0OCtTaGRlRlhmd1E1cUVJMUdYaEF3cDVlcHJVQnRzdVMz?=
 =?utf-8?B?M0dOSW9leGFiM3JKeFYwdG5OeUxyc0hhaTFwNXlLYTBPbW9BcTAxa1dxL0F4?=
 =?utf-8?B?MkExbU5kTHloLzd3d2ZuVmtRcGpnSXhvd1pmaFNHVXgyNHdFYzQzSXNkTEt2?=
 =?utf-8?B?b2VXd2p0VmRMbGlSSHhKQ0s5b0czSW45eldacXhIUTB2YXBVblRvZm43cUM2?=
 =?utf-8?B?RDVzQXBFRURkQU1Sek1NSEtlM0FjUkE4Ukh4U3FQMXR6LzZhUE53R1FUamZ6?=
 =?utf-8?B?Z2JVVGJwcWVTWDV1ZHl1YS9vNUxNRkVOdllmcWMrcnp0K3lhYkJLUHJyejA5?=
 =?utf-8?B?c3NIait6b3hqb292T1psck0xWmNDNnhXS2I3L1FCZ0NZVGVFZGxmcTh2U2Ev?=
 =?utf-8?B?S0tjYThlZEJsTE5iOWtLNzVTdW5hTUZxb1JyU2RsdTBUZ0xaVXR4UDBvaGlM?=
 =?utf-8?B?Tk5WUkhNYUVGUE1HOFpobGQwU2FiQk9iczhpSlhEWjBIdWcwNnZwRWtTUFlz?=
 =?utf-8?B?QkNxQStkWXdjVUJyV0d1eHZTWHMxbFh2MW82bUE2TVVuNGs5V1dGTVp6N1Vu?=
 =?utf-8?B?dmlYUGxqdmxTT2dDV3ArZk1xRlgyVkFuVUJzRkxkZEErSHJ6STlTZ2gyV0Fq?=
 =?utf-8?B?VTNaMHFOWk5HblhYUTFzYVBLeUZmNkVlY1RxMWN1U1ladmRCZTBWZzljN3do?=
 =?utf-8?B?Qk1BOVVIS0MzR3RkZ1NwbjhtdHB5Q1E4QmN2MERjNTBXWllJdXlTOUkweG1O?=
 =?utf-8?B?UzE3VCtwMlJqNE1yUCs5Mjk2L1lZSHJsemtlSE9LdmlTY0g2c3FUUjlEYnVS?=
 =?utf-8?B?U0JlUnY4RWlzYURkZjM4Z3Z1M2JxTGh3bHE3TDlqL09rTkljd1J3QUk3b21n?=
 =?utf-8?B?Vk9kT1MrU1p0QlNxQXVTQjVJQitMQTB0S0VYNTQ3U3IwVFY5enJNaW5tbEFW?=
 =?utf-8?B?SXJaMm94ck1ZclpsMEhRd05DOUNyYm13QTJFRTVhQ0NzTEl1RTYvZnh5azVl?=
 =?utf-8?B?UTFJUERTbFVzWkV1cVhEOThBenliYmMxRkpMVDA0bis0djlIeVk3eFpsT3B2?=
 =?utf-8?B?T1hrVGdMNThJaUk2NUI1Wmo4dlhEVU1hOVl3NDk1UDAxbWJxMWc1SWtEWVVq?=
 =?utf-8?B?OSs5amZhTm5PczhzbDhPSkozVXJQVy95Y2Z0NXFBMzlyZ3cra3RHUlRLbStX?=
 =?utf-8?B?MUMvdEoxK2IrMmh5Q1N2ZzBhTU1WQlRodFdmd20zZ0hRSWlxSHJGWERHTkpR?=
 =?utf-8?B?akVuQ2d4akxUV21KeGpXYmpMR1ZSRjJub1ozbnFzNmtOQy9EM0pkUFpua29V?=
 =?utf-8?B?VkdrL3ZUanRza0NocEluNW9HZmtIQUhTK2Vzb05IUFE1a0IxeDJaS25vcmxY?=
 =?utf-8?B?RllzS0dhZ1RhdzY5OXZVUUMrK2RFZUVpSFFRRDhBOG5DTUJRa24rNU0rNm5F?=
 =?utf-8?B?c3RyNncxRzMvQko3Q3hwQnZmNkVOZ2NXYzRHTk9tV3NMS2wwcTR5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac52c243-98fb-45d6-0e80-08da2f71c1e7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:04:47.3711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQMuHG3IBS7pgwSnGf0vlqbv0OKBj49BnbijMCuSuVSAhk8I9zPEumPHeqM6owX4eysMfPfRnJ+W73u+u0/95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
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


Am 2022-05-06 um 07:23 schrieb Christian König:
> Add a AMDGPU_GEM_CREATE_DISCARDABLE flag to note that the content of a BO
> doesn't needs to be preserved during eviction.
>
> KFD was already using a similar functionality for SVM BOs so replace the
> internal flag with the new UAPI.
>
> Only compile tested!
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 2 +-
>   include/uapi/drm/amdgpu_drm.h              | 4 ++++
>   6 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 2e16484bf606..bf97d8f07f57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -302,8 +302,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
>   		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>   		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED))
> -
> +		      AMDGPU_GEM_CREATE_ENCRYPTED |
> +		      AMDGPU_GEM_CREATE_DISCARDABLE))
>   		return -EINVAL;
>   
>   	/* reject invalid gem domains */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8b7ee1142d9a..1944ef37a61e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		bp->domain;
>   	bo->allowed_domains = bo->preferred_domains;
>   	if (bp->type != ttm_bo_type_kernel &&
> +	    !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>   	    bo->allowed_domains == AMDGPU_GEM_DOMAIN_VRAM)
>   		bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 4c9cbdc66995..147b79c10cbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -41,7 +41,6 @@
>   
>   /* BO flag to indicate a KFD userptr BO */
>   #define AMDGPU_AMDKFD_CREATE_USERPTR_BO	(1ULL << 63)
> -#define AMDGPU_AMDKFD_CREATE_SVM_BO	(1ULL << 62)
>   
>   #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
>   #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 41d6f604813d..ba3221a25e75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -117,7 +117,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>   	}
>   
>   	abo = ttm_to_amdgpu_bo(bo);
> -	if (abo->flags & AMDGPU_AMDKFD_CREATE_SVM_BO) {
> +	if (abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) {
>   		placement->num_placement = 0;
>   		placement->num_busy_placement = 0;
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ed8d9b549a4..835b5187f0b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -531,7 +531,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> -	bp.flags |= AMDGPU_AMDKFD_CREATE_SVM_BO;
> +	bp.flags |= AMDGPU_GEM_CREATE_DISCARDABLE;
>   	bp.type = ttm_bo_type_device;
>   	bp.resv = NULL;
>   
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9a1d210d135d..57b9d8f0133a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -140,6 +140,10 @@ extern "C" {
>    * not require GTT memory accounting
>    */
>   #define AMDGPU_GEM_CREATE_PREEMPTIBLE		(1 << 11)
> +/* Flag that BO can be discarded under memory pressure without keeping the
> + * content.
> + */
> +#define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
