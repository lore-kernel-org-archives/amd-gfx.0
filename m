Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33113C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 20:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E38610E206;
	Wed,  5 Apr 2023 20:26:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998EC10E206
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 20:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1rprwTwV5qp7RnNVnmGJJVez3n9NKhr6AOKUSTpVOtbS8A5d82gRlbwn2mAReGmuJ2bspASw+LiEWmXQsSiFcgzIwu5cHYsost855LGPdfS5t8xB/MyUPIVVMTMgHHZwZ+kc9oEgWGRDt/krP+9LzWPOf9d/MP99SDxI1qCKHz9ksedLSLZi70UvcXitojKfWnea6zEkdc5o9A5jRMMTGUaa53xdO5CekBRtREdMYkb/rE4UfqpyTx4grc7wEQAjF3setwO7vSCS53S9jAMfKMN79DKBbhzYTPOtcHU4aNcIiTgEtDciw99iq4KyK7lcc/Rs9WIBAYznjUcqDRsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlCnvowI0NRI6A18sYSgdc0yqpEJ9WVuPRmSaj8cOtk=;
 b=LM18hHgbzgYeqbnwLRWvLzidVrAWnpCpUv5T1Uu5xu0rorRZhboHV/h3r6Lcr4PynEp02JVSQkymDb6u8F36ud5YxcGm3U304cEqHeUhmkoRY1YN5mNb0TywKRM6fpgz5Z4WQMKt3/04gMFXL+8yqg1zMUIcid8at6PyUw3pd1m6aA8FNynqFw73QU3G5gLukjMTNLLnwVitZaiZrio1iULjARg69LVxkXkTTErhY1GlV4wT4qhUlVuielAyrbUcCj5ZkC2KNe+0SJ99t1pcbkrL3as95y81Vge4OfmrOXvnmMod62sSGLczpl4BRinDmHGeSZftYqLkzw/4wGhmGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlCnvowI0NRI6A18sYSgdc0yqpEJ9WVuPRmSaj8cOtk=;
 b=vOgZ8m8GbYOPAeMHTfUMI+sleJnKZ/ws5LfkzG5ckV1sqv8sq9/ZaOGMbFDNW0iCheFcjVCVi2yyJY4l0immH3UxK1Sn0ak0anJIqRlPI6ry1pC5wcq47nw5eTtnepg/ylHz7VXYo6uH8iiqtEsF+Y84Mfd4wM77r7q8Xfxltd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 20:26:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 20:26:00 +0000
Message-ID: <358c8b39-1032-3643-1640-b45ad7264599@amd.com>
Date: Wed, 5 Apr 2023 16:25:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Philip.Yang@amd.com
References: <20230405153121.3324620-1-shane.xiao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230405153121.3324620-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 008a8dcd-cdf9-4939-aa9c-08db3613f7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyngyIAHGibRCrukseFyCJn46RqneHQUU5jlbtxLZTxmoYzPMGQIhp4fxWnppnmXXrky6m3bdXUXyqe2uwFOHJjfwNa40aav+710/wd/CLIgmD4FXak/XXOHaBQeJgBswJ2MkSQ+uKxoshw8NbTNBiX8tLnFGCghnbkv89stMLR1+ZhZRSml6yk9BLFFHS+GsFH27wffq/tn6BIxxKlPnRF8wsHAIbLN3T/SoSW8fxIzwnZpwIbHDjHgQm/BfPkT2TxEH7DHq0/GfgMMoSe5Uu0YmOK0zDKqlc6KdBNlmz2yYEd3i48hclDuDhiBt2IbUEK2gW2YHmq4YzoKrwN3U8lQSwlrUE3+DmYzXFIB6Kocw4b2IXIbxFJTJvqJAmIXEHElMt2uVira/niXqNTODeUfoFV1RXay4iPkpRuOr5cwl9hO7tcj1UkOGYEeQaE8WNyN7XFQX8JAawSBXmNFmuYyaWHqcjOMNPtKymjcmOLV8sEAnPgAHDWnZDahhPy+zYJunEioDEAEROFBjRt78qhf+aSsZHjttB5sHIgj++o5/rjVztGI+EdRigNGstj88VjTFN/BQQeBa0b77X8P20rG8NlZgzRUyDS6hgt6dhm2Oxdtlbvr7TnEj5uz56wW7fxP4/unw5YiqDU6LhQR3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(66476007)(186003)(6666004)(6486002)(41300700001)(38100700002)(31686004)(36916002)(26005)(53546011)(6506007)(6512007)(2616005)(83380400001)(66556008)(478600001)(316002)(2906002)(44832011)(31696002)(86362001)(66946007)(4326008)(8676002)(5660300002)(6636002)(36756003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2s5a2E4Wm9BNVZqUEt4Mk9jbnBKNXEyWENEL3J6TzE2c1JGb1RCbWlQaGxQ?=
 =?utf-8?B?d1hGcVJTOThhSW1sRFlqYUUzTHRRVDdNMGJvVFR3UlJWZWRiQjd0WmVYbWZE?=
 =?utf-8?B?R3ByZzEyYWZWaDFSaStoVmJNUXpoZCtWREw0RXk3blJncDdGSSt4dFExYmZ4?=
 =?utf-8?B?OWZYM3lpbnhuMnNUNnF1YTh2QU5BV0lscUJkOERRdm9hcjJWdHFnTWJVSVM0?=
 =?utf-8?B?Sm5OT0o0eVBxdlBjUE83dWpIVVlvc25EK3AyeXNsR1J6alhnTTMzaGE5WlRM?=
 =?utf-8?B?czNNTm5iUnhDRjY0Rmx1ejJaNHRRQ1l3bWcrRHMwQnk0cjRvT3M2dlhpemlr?=
 =?utf-8?B?UEhEWFJNLzJEeFVMb04vRGp1UzJrUk93TXJYb2FXM25iMVhnb0o3Q1ZHYU1O?=
 =?utf-8?B?YXFIZ1A0V1R5aFJsZjREcW8rNU51NjJYaTFsNk9ZeUJGNGY4L25JV1RGeU9B?=
 =?utf-8?B?am9NSnVab1puZGpBZUZ4LytrYy85akQwd1pmTUN1RGxWMy80cHBqNHA0WFJi?=
 =?utf-8?B?R1JlZitlYm5wTHBOQmZmY1ptNE1oVGdRbFZpV3Vwb0dpQmNSMitCYTNCYlF6?=
 =?utf-8?B?cVQwaHYyOHJGQnVoUjl1Y2U4RWhuM0kvaWxMdjJxaEE4ck5RS3RGUWNnL2hm?=
 =?utf-8?B?UFJoamhlTVdMMGRwWHRZRDNMSUlKTnFIOWtYakdLTXNRdjloSitFK3BSU01y?=
 =?utf-8?B?ZUl2RlpKMHpZbTUxQUJkbTBabTNqSk5xb1hwYmI1K0s4QzlPNWpsYXBqRzdk?=
 =?utf-8?B?Ui9TMllyUGRYWnR4NVk0S2FPc2VlOXZxR0hnL3Q2a1o2akpEZlYyYVVOY09o?=
 =?utf-8?B?SjdUMHRrc1cvSnRjbGRBcmlNQTR0cHkzV0xQcElzZXZkQ3poVzRsRVl5Nm82?=
 =?utf-8?B?ZEFLV2FNTFhnUGdySlBkc2djVHBEV2orbzdkazJFTmxmWlZHRkM5S0RFMVNQ?=
 =?utf-8?B?dlFIZ2V0MHpocVZINVFDNndRT0s3dTd4MkV6MUtkaXdxdkNGRkJ4WTlXaVpj?=
 =?utf-8?B?a3RtNm0xMGxBamZVbEd0N25VUmk0TUpyRjBZa3VycVpCUFRHWVpXdVRqcmlo?=
 =?utf-8?B?UVYrL2NhdTVEcktkU0ZrT1pvSEFsMXorNVRCZ0dJcHdoY3ZLM0IxNlU1b1d4?=
 =?utf-8?B?K1J2cCtYT2Z0a0daQStxbzRhem5TWWpubDgySHc0UmtqbFlLdGdOalg0UHRr?=
 =?utf-8?B?M1pkSDNQM2MrUllHVFZxbTlvMXJvUi9OR3B3WkdGR0pQa2xpTW9SeWNhbkJW?=
 =?utf-8?B?Y01vZitNWUJjenVoMFd2N3FmZGFkTjRaSmdEUFJjNGdyc2xTeEdNNk94TGEv?=
 =?utf-8?B?cVRnMlBUTDhwYVBiYXljMktaM0ZZb3Uza1NCYVFNUzRXQWJVdkxLUHJNMys5?=
 =?utf-8?B?eExFY2poQjZSNW9NZHdJc2VqSWlZVUkwZGlROFREWmwxSTBNMW96SlNtNEdR?=
 =?utf-8?B?RVh4Nmk4akx3ZWFkbGRmUk5KOEJiRlBtTFNWZ0V5SVJkQnV4QTJGU2dyWTNF?=
 =?utf-8?B?WGxzelFOSXZFMmJNb2pNNlhScFJTYVRlenBieEZMVWkzbkxSN3VqdmhPNSt1?=
 =?utf-8?B?Q2tMTjRVWWR0ZVladlk1UWxIeDZPWExRZXgrM3RDVCtnbUNQYzh0dXd5VTd6?=
 =?utf-8?B?YmFIVTFsY1BrcWF0cVg4WWhxcTZVekZCenJWWHFxVkoyTUpsN2xENU9ZdERr?=
 =?utf-8?B?L1dqRHZFaEFrRnpDZW9wekxsaGxNMkRiaDZNbzVSYm93MWNXYW5vbFVqREtt?=
 =?utf-8?B?NWtuMnVCTVJzQXErVVUwLyt0aEYwUWpSZ09ERmIyS0VzdEdPLzUzaWVONWtm?=
 =?utf-8?B?aU5WYi9xSW9zdkhlUjVDcDIwMVd2VjFXbVorOG9SQkh2Vm11V3hoVC9uMTBO?=
 =?utf-8?B?R0RnRTFuOVlFNHo4RGJyREFCVXhuUDZSUWV3bWZSRUFFTThYYlJ3bDJ2bEhk?=
 =?utf-8?B?N09TUm14RU9lZDZTOStBZXo2a2VtZlpKVkJIcTJNNWlxcGhoVUtzTzNaRFRT?=
 =?utf-8?B?L1Q4UG9pVTM1WnBDb0xCUDlHSFM5NHNyVmd6U1k0bU9ORFVUWTVRN2UybE9O?=
 =?utf-8?B?dHREbEFtM244QUZnNEY1czY2bVc3K0ovalNPNml0T3pieXRKeS9TNktyZldC?=
 =?utf-8?Q?PeW+je4eKB8QlscERwMjXhfjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008a8dcd-cdf9-4939-aa9c-08db3613f7d0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 20:25:59.5763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0fAbhqzGHBeq8lSw+i8mRF2NY7NGTBEb6ousz//wvQRdqaMsHsYOfjpbBaEnewY6jVrRVghAvIYn+IY4uEWmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-05 11:31, Shane Xiao wrote:
> For userptr bo with iommu on, multiple GPUs use same system
> memory dma mapping address when both adev and bo_adev are in
> identity mode or in the same iommu group.
>
> If RAM direct map to one GPU, other GPUs can share the original
> BO in order to reduce dma address array usage when RAM can
> direct map to these GPUs. However, we should explicit check
> whether RAM can direct map to all these GPUs.
>
> This patch fixes a potential issue that where RAM is
> direct mapped on some but not all GPUs.
>
> v2:
>    1. Update comment
>    2. Add helper function reuse_dmamap
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 27 ++++++++++++++++---
>   1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index e7403f8e4eba..2fbb9db64ad5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -81,6 +81,25 @@ static bool kfd_mem_is_attached(struct amdgpu_vm *avm,
>   	return false;
>   }
>   
> +/**
> + * reuse_dmamap() - Check whether adev can share the original
> + * userptr BO
> + *
> + * If both adev and bo_adev are in direct mapping or
> + * in the same iommu group, they can share the original BO.
> + *
> + * @adev: Device to which can or cannot share the original BO
> + * @bo_adev: Device to which allocated BO belongs to
> + *
> + * Return: returns true if adev can share original userptr BO,
> + * false otherwise.
> + */
> +static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_adev)
> +{
> +	return (adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
> +			(adev->dev->iommu_group == bo_adev->dev->iommu_group);
> +}
> +
>   /* Set memory usage limits. Current, limits are
>    *  System (TTM + userptr) memory - 15/16th System RAM
>    *  TTM memory - 3/8th System RAM
> @@ -804,11 +823,11 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			 va + bo_size, vm);
>   
>   		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
> -		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> -		    same_hive) {
> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, bo_adev)) ||
> +			same_hive) {
>   			/* Mappings on the local GPU, or VRAM mappings in the
> -			 * local hive, or userptr mapping IOMMU direct map mode
> -			 * share the original BO
> +			 * local hive, or userptr mapping can reuse dma map
> +			 * address space share the original BO
>   			 */
>   			attachment[i]->type = KFD_MEM_ATT_SHARED;
>   			bo[i] = mem->bo;
