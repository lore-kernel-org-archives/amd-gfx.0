Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B1C77B6C
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 08:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A67D10EB0C;
	Thu,  6 Apr 2023 08:12:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60D110EB0C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 08:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHFGY+2XoOi94Iq+fbuJE6c1gnxBFHRZxvpwPZjLWTgcLJ9cbyZNhBiEEl10+BEXl9FIfB8nwriVUrpFVuE8hm+iWkTNloeqVYq8GEQtUOO+WWVb1NkM93h5I34aQRw/Z8UuFPEu9K79kWA4C7riXBTdtuvQryEmyEzjZHwwwp7+pmeZ8Lclh3GW1x6IuHhbIzHf+kXoLFNXZjOGPbfevWsc6nDXupx8znm5wNT7cMk8Xr3uubE3uFR5zEyi6kVy+St1SttSpWK/H77nqFhDF3AROYk5bTgOItCnzD2cu2N3OQrtVjX7b1bdKXh1pBOYC4tiqp0B8aZ28e19UAXY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJndZQ+uT+iOqw4ctwQgDVJP5kZPvMuhI41CJTlTq60=;
 b=bz+J+tC0qLFcv4tvMtfrofFIBsn+IgBKfSwyHSRbsBRVA+zV7eeyI3lnlJG2dmP8/TPidDkBuqAOnnQc2CqEKffYtRUEt8C6lioBsZ7hDiF+JdTqxVXONo6SZSvmqIZzd+OzRJpi4jSE9XGWKuaWpiLa6BWPFQt/kvSV50pTvOlxhKeEpMKeDoVJXpbtkvk/CLQtzeUBcQQNj4T4nDDyBxGS/WiXC+MQU8OLxlr1y36lGue3t6lUkNvQFB6K5KHVJiIsi8P5DUoNYvGbgF/VqmIeiyzO3sUumn8a4Pp0DGjMvnDiK5Ihy17OhVZN2yo2kwLIMww/JlCHo516FYlcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJndZQ+uT+iOqw4ctwQgDVJP5kZPvMuhI41CJTlTq60=;
 b=r1byIFl+M1K7lRBGPY1tO4as1gzhdNj/h1G2BGv0VvS1D89P/SH+77A+lBgNo2LgRAcsrcS/wqBxleWjVMTj/GejSTiij5U6xzjI4suDYFt/2oVP7Wmo1IV9pBzV7g1Nzks581X7hIC2cYq4Wjfa+RR5bCKH+Bg/DmZIxhxRURg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 08:12:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 08:12:54 +0000
Message-ID: <5d487b03-beff-10dd-284d-ecec9489d094@amd.com>
Date: Thu, 6 Apr 2023 10:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20230405153121.3324620-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230405153121.3324620-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b4cb8b-cc5b-4c78-5654-08db3676b8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oBoitqP8PAHDmYVCAfNg3RZeVe0jnUSGOirAp6/GtdD5CyiKfjUrLqzkOGJSnmbNdz5VQ/rTYF8xoXYLLpd6wsEGRRkaCLNl3okAqJjM32j2PiYJQhqeLaBH6a1B6YcUKEmCf2+oPN45wO0cQIyne1FcwXPce0F3+M6eBMzgjjrrKEXrk0WioIl1NreZ2ODMxwW42mqNBUXTjupbb8eweVFjCQjCGZvYmbnZ+J7M1JpIrQZq4kfBHtc4OiVYk9lDtb3DoiIY/XyK8Dw16+IE95UfS8sfnPzd1gyVOLSMwsD31HFIvMm1gccoGmjcabJtUqyxMCWEzvTdCFRq+jd6v38fIYSg91HCIplyApJyj1weJuJAMF9lSN5PP8dBchOCjKE31575yLpabtLVXZG/VUCxRHpFddAXkzBxlnfFLsUFNy7l25JfVOFaFiJSSMsHPaCLxL07EumgSozS5nbQf6DBuntnk+vV6mttu3Z6YWmYVXbp/vAXy/J4yoxu8ib9nruei0+XF8csV1L/1kMdLq3zVSslyql/zTpFQ6zZU6ERFwGx9wIJoBisstroZEQI6i8TJPhYPm87XUqKa4gX8o43iNcpujHB7DYcTMCBUty1YDh36bkW7LU/upknOLciu7Pfn8PJWv+95tWXoSMUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(66946007)(316002)(66556008)(4326008)(66476007)(8676002)(8936002)(6636002)(478600001)(41300700001)(5660300002)(38100700002)(186003)(6666004)(6486002)(2616005)(83380400001)(6506007)(26005)(6512007)(2906002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdZVFREcDBEWGtPNzk1TVBhT3JaTSthcFA4YVZoUlNxbnZ4N1dIK2hQdkow?=
 =?utf-8?B?ZWc0Ukt1cFVCVGJzU2Q4cUd5UmxBU0NNUnh3U0VJRFJuNmg1UVhLT3prOWZv?=
 =?utf-8?B?SkRFMVV0Q2EzU04rdnVmWmNzK3k1TGovellraVlDd3hxRUlpdjh6eUF6NmRF?=
 =?utf-8?B?Q1FmRkN5OWdKRENkZjVLT2p4c25VaTZRWXcwNFZ5MVFQM0hGMHFRMnBPWllR?=
 =?utf-8?B?bkJmRnZYUHhtakJ5dzkreHNXT2ZWcHM0N3h0NXF5MVduQW5ZQUlJN3Nad3Bi?=
 =?utf-8?B?MmJDNGlmMnFKUC8rSUhSNWJjOXJ0NC81NHR6UWMvamtmaHdmTE9UM25SSVRo?=
 =?utf-8?B?Ukw2Z09hd1hkVmlLWldIbHFIUmFYRWQ2akZWb3NvRVpYL0REZDN6T1daVDhh?=
 =?utf-8?B?OTgzUDZMUVRSa0JqRXlmdHFoeWNmakw1d2o4a2RuVzI4VWMvUWZKZStjMmlt?=
 =?utf-8?B?dUxOU2dxbHB0UEtDWVF2Y2g2MTl3SVhIcHF2L2VNK3hMNWpnMHBVT3R1M3NY?=
 =?utf-8?B?bnRpN09pY3hySGxIUGpQc1V6ZnN1Z3QxbERUdFJUZ0FmRlNodWlrSFIvc3VF?=
 =?utf-8?B?WlZXZnE2SldjVmllbStucDA1cStiS0svRTVBbnNvRkdqZFNtcndNdGd3a29N?=
 =?utf-8?B?dWtqMmJ6Mkp4ZEpuTE9LOXhwSmVLTUprb1RqekVWb1h1Q0M4YmJNY2taMmlG?=
 =?utf-8?B?T3BNUzl2bmdQajZ6clZUVVErYitoRXdseGVBd1BCRjk2SVpwT0IwaDZ0Q1Jm?=
 =?utf-8?B?QVBncHhpT2pxTU83MVVJYllXdjVsa0xXMk14SFFtRGZyYi9SaW9zME95amJ5?=
 =?utf-8?B?TW5vRWovclNPSGVzREw0M29hU1QvMDFuT1lMejlmOFhjT2xKeFZFUGs5WERq?=
 =?utf-8?B?cjlVaHdlSEFKY1FIbmpvVmRzcmxCUzZUOWR5aXVSSXlkaGVHV2x6UXFZNUNh?=
 =?utf-8?B?K3ljTnMzSXJOdjVVNmNZK0ZqdFU0WFZ4MGNyYUcrM0dEMzhtM0F3UTRYMHRL?=
 =?utf-8?B?TVhNRnc2M0syV1cycWN4eWRQWVBWQWZ6UWZ3N2k4dlpqRFlWNWU4RFMzNmJT?=
 =?utf-8?B?Vm9QajhBbTZtNW9DRm1iWFlxYjlHeU1JbnZUblM2UE1oWUY0NW45TjhaU3hx?=
 =?utf-8?B?VVIwQkVXVmFvcEduY0ttVzd4ajVtR3l3djlWbmdhdWh5ditzeFRQQ0Y5YjhZ?=
 =?utf-8?B?SFpPMFI2QTBHOSt2UXRJSHhYQnZIZVB5Z3UxVG5YNWZZbUk5MUVxVjJkdmJn?=
 =?utf-8?B?ZWNza3V3N2tiUG52cWIxTUZsRU9sSzg3QndIblRkb1JXcm1nbjJxTWsrOGlG?=
 =?utf-8?B?Zll2R3FGajNFTFdhZHVWS0NJeXBVM2tPWkNjM0IxRHh1Y2RBaUR4SGNkd1Az?=
 =?utf-8?B?ZEljalJqWlhUcGpnVEdjK2JVZ2h2RHc2d1dKNmNiWEsyMExWMTFWd1Jqa1VM?=
 =?utf-8?B?MldpVUlBK2dvYmpqQndHVFkrTEdEV2IxVVNCa3U2ZkxIWWJZNFZSYjA0US91?=
 =?utf-8?B?dm5OY3pWOWRqRWZISVdEYkNydDlsTFNlS3J3U2RLT0M4VUI5UjdLSHBKb0Q0?=
 =?utf-8?B?N1FZYkVQeUd0L0pXcTBHS1FSbXJNaWcvWEJwZEp0YVgxS3NibUNlWXJRaVM4?=
 =?utf-8?B?YWlZTHZLbkRsR0R4bWdjTUZsMW9OaE1NcTdsTFIydWVSZHA5dVROd01XM0hK?=
 =?utf-8?B?RkFpLy81QnZoRUZMd1dTYXBjc1JjM2FxbE5sTjN6SjV4V3MzSStzME1OaXIx?=
 =?utf-8?B?MGtYdHhxL3pXejlHdjFpakZsb1B5bU92QTRJaHU4eDV0c2Y2UGVvVXB2bjVv?=
 =?utf-8?B?TXNIRnAvZHdnK0sxbU4wMTc4Rmt6WVlMSDlrMWdaaWJMRWVSSEFOM3JvYkQr?=
 =?utf-8?B?L3U4L1pZR3RpbUhsdjdrWklyTTduUTBtUE5lZVlOZXkvYjZCWVlNWFRuKytw?=
 =?utf-8?B?Q1A2YnVEUDNiWC9QSDB5NW1NZ0UyQ2d5NC9ieHlUSzdsVnhHNTRzcXhmdnMy?=
 =?utf-8?B?UjdmcWpmVEJyL0t6R2g2UVNnbHIzbWdYV0dNakFBZ1BUWW9OWkJFVnhMdXYr?=
 =?utf-8?B?RStwYlROanZDNkxPZUlLeGZseWtYWTJHMm5hay85REdXT3R6SUhIb2pRYVhy?=
 =?utf-8?Q?8oFPEHnuNwPRc8lbYdu7X0WI5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b4cb8b-cc5b-4c78-5654-08db3676b8e2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 08:12:54.1766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMV7Z2KNkE4jSa2r/t7xqjex72Z9FNQmP4c2jflSgEbicwblMT12MyMKSoIdko7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

Am 05.04.23 um 17:31 schrieb Shane Xiao:
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

Please wait with committing this until I had a chance to talk with Felix 
about it.

Monday is unfortunately a holiday here, but I will try to find some time 
anyway.

Christian.

>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
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

