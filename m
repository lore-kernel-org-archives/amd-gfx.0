Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AC9C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 22:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBBB10F6F8;
	Fri,  3 Jun 2022 22:26:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC2310F67D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 22:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQBJUDVWxMeb3r1PNQUSjB8Z4gaUzjzkQYD3B+o0clbl4wEhPb8sb9Fdt50vHwVqgIk9erVIm2mg+wk3XQEaOYItUUqwEBrUUhJydWroCefb7tv5jMqPNXYSOj6MdeyKFs0drpADIxtmlwyXcpf+tD6ZIUPHwYnk+3+9OQnkO78K2VB7XepFuGgtdxzXLajlCtNLp8Jns/QYY8IzHNqVXMBoIv+yuWLe3n05T5/Oxu1rnOM1QJN+yY7Mgfr0kr+vFAgHHNL9bZnJnhXMeiTMIwpUwfE9sq0YenN9XftKSwIIdB43Jm6JuAotL02Vgr8TfSi9EfLYjt1NNrV8gknQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOYJGBMOaCJvNoY6Dh4dEzWjGw2meHu/OGoNSWFUjWA=;
 b=PciCrhGtUGJL/2h975b1n62s6aVtDINS0OgbHfrpzoxAfz8a+7hlcx44l6kT/PWNdjbhncVQ+FTi5aIFgB7aZHaHG/215eEvgB9xkpIYkVj4qrJFFlHOpiQLtRF34mjbFBPXSg/Ed1mk4r1SFOt1IJO3up1BCYpvT/6WccbmkzXTxZG0sECkB3pXMcjUx/3l8FteAL8BWMeJFHTl5F7RO1Ege+9456t+gtM3tcvC1BZ8kdzVXwLxCgvx3xQduPDXuDLabCUyi/rRgdwAk258C7JMaZbHijL4r1szIlcxwNlHNR//6TT+XB5J6buRSO0rqQUyWxSnj8+FpQYlKD+qkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOYJGBMOaCJvNoY6Dh4dEzWjGw2meHu/OGoNSWFUjWA=;
 b=1biYew0SYuIlEIfwuuGWB5ohIxsvrX2GhG6PNAytnKp7sMJ01DKXddj1Uny6VjS3E92eP9G4q+6WB7fpf65sk6saFsuNZ1lWbNJ/nog29U6ig1noGvxCe/JyVjf/C6xA4Px98VeT9M8CxDi7ArGoarfeBw61gokoKSX4AFZxiBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 22:26:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.016; Fri, 3 Jun 2022
 22:26:43 +0000
Message-ID: <412d12a6-24e5-ff30-2d1f-b631e0e21784@amd.com>
Date: Fri, 3 Jun 2022 18:26:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603105227.3363029-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220603105227.3363029-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:610:cd::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd10d7a9-04fa-4c42-c1ca-08da45b02315
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5069F1750EB2232516EC3CEE92A19@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTjOq3Y3ulTHqcjYW9RlRfUXO6mhTCPGQDY9JaOJWEAN0/nOpV9CSukUeqrXDKtqoGvtZAhOS9rczUuvGoaXGkrIXJ856pSVn+lEk/OHW4EnRmzY1GnxxGVbNedh4VU4dguz3C0Ot2xQH7Wi1n10afHGLCJ7XCpdZTVym+yF/IVmg2SpaGiYQl80AxyWpnncZCMo9vJPOplWEC3wsvHIooHFO4g9UAYrBWyjdMygSEK7jbF5FtG+HfHUGqvSE3GGKfY9BT9MbzdHn7kDsrgp2uNd/rf4Bw+jkHx2zB9Bucut+BFmYe9+9N433q6UVwjdoMNARVz/BFmGLRcS1i+xjeNm7r43r9YOoGfieztWzsVaiUryktHXvamdz7TuJQqUEIRkaIiogAyvphlOqYvv4GyZUDEKjuHX+45EnEdX1zlEiZswi0Ev3TNnSd/9QFdWAiyvDGdkyo4zM6T1aLYOjYjCSV8FMxopKlQjFTyO/iuWQD/MROYFFzWm0UDgGAUncyDcfUSI3FgbT3RgTsr2DVvm6+o/yRGQrfrsRoFrQTKZIWlkERnb/O99qpOy9h8Nb4VhRwSUnNNMlfTbBoPWEmjXBop4snpIVekjxWUTiPU0BYGrrqyzPd2VDZg7z/ZEnhlWkO19Fn2CqMrVZ8C1HfhPGRTnux+xIV8EM2KYeDe+QpkuqItOjOm9X8Ps+eVxD2RX4+y6dPahHrTDnMN8W9fuPfWwyX0vzoGCGZnmeav1pGxDp3M8xNSkQr1zGnAL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(66556008)(66476007)(8676002)(66946007)(83380400001)(6506007)(53546011)(86362001)(6512007)(5660300002)(26005)(30864003)(44832011)(36916002)(2906002)(186003)(8936002)(31696002)(2616005)(36756003)(31686004)(6486002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDE1M0JqMmVlMXgxenZwNlBmNHo2ZDg4alloaEgzSk0yMzJzcUU0ZmR1aE4z?=
 =?utf-8?B?a1FiWlNVdWplWjNiL0FFQjhTN0NWTEZJVXFteGtsa0JwMzFsZ2t0V3hTcXIz?=
 =?utf-8?B?RDJ2UnJQd2RTT3RNZXZHVkd4VlVkMjkvV2J2WC9ZYkhORXEzK25nN2dscEps?=
 =?utf-8?B?QlI1VmsxcVlkWEgxZlBNK1VrZG1xbzMzK1ZEOGM0dU9ydjVEUzdaN3dTclZX?=
 =?utf-8?B?b3lTdzBxNEdiS3ErcTZtOCtKMGlvU2x5RS9hbVhRSElrSHpHdlpoc09nZldz?=
 =?utf-8?B?Znd1SzdiNkdmT1RubXZCdUdvelJOZ1pmalBTdGVreFlVRWU0dTdmWDdDV2RG?=
 =?utf-8?B?Y1krQlVjOUJBcDVnejF6N2paQ0hONnplZkVMOVJVOWt4dkcrQnJyY2gwd1Ir?=
 =?utf-8?B?d0dPSHUySis4dGFQTkd4eXBJbjdTQ0RoeURzQlZTbStRVkp5NUI4b2lUL1NS?=
 =?utf-8?B?NmE4THpqZ2F2T1I2QU5sRmx1M0JSeEpaQ2NxQXQwTGViL1N4Q2Z1a29UTTZN?=
 =?utf-8?B?MkJaTEwyS3JMMmttNU93bXZLWVg3MUQ2M1FWRkRpd0Z2b3ZXL29pS3F3NDVR?=
 =?utf-8?B?M0tzWThvSUVyVFJXNnd6K05sSUxnY1dpelVPcjB5VXBNYzhhSzZSaHRVOGp5?=
 =?utf-8?B?eDE5dXE1aXA1U3JYdXJBaVAwOXFwNi96aWg4bCtSNnRqd3o3MVUzNStUaFE3?=
 =?utf-8?B?blIzZDc5aVVDMCszbWhSanY4cUVJcE9KUUg1ZkFSc21rZXE0bS9hZTNFK0s4?=
 =?utf-8?B?czlwZjU3Unlaa3Jzd04wWnYzWEJkT3VDMHI0eHFaMU5jUHFyYS9kYVk3dnRF?=
 =?utf-8?B?OUQ0ZjNqeGVIR3hvOXJBbHpvS2RUTmdPUkNCOWVFc3hQcGJjRXcvQkF5SjRk?=
 =?utf-8?B?MGZiVlBTc0RNTkN3aUNZREgvR1RVYjRROThnMWcrSk41eWd5ZGJtdXBjdklU?=
 =?utf-8?B?NEIxYWs0VURBbFE0TkRWWGtWRTh6SnpwNUkwY3B2WkFXL2x4VFBFemdHSDYx?=
 =?utf-8?B?RzhZOXN3amxLTzFndy9KV0JyclhSRVdEL05qVjFVMGR2RGNNQkppU1p1TjVq?=
 =?utf-8?B?NWFvQW4zbUg5NDF3QjhGRGk1MXJqc0sxZHVJWEJVd1dKSWNEYXdTdjhhNW5F?=
 =?utf-8?B?ZUFxZ1VHYUwvOGh5NklOQjhBN3BjZmg0ZU5lSnk4a092RjVha3BWWFRFM3lx?=
 =?utf-8?B?bjFWNmtFR0w0cy9YelBtRDdUYmFWQkNPSDRJbVYvYklwcVNzZGd1ZFVXaXFD?=
 =?utf-8?B?ZGhPSmpuODgwMXZ1R2tqTzc5V1NOcDJHV2xmNU5MTEU2UVVMUjBoOVJzN1RU?=
 =?utf-8?B?MkFqUVpWY085ZVRmb0xpb3VOYkdMNS9kUjdGc3d2eW9tdytTYk1ocDRPdXlQ?=
 =?utf-8?B?TDN5Zi9idEN5bGNVTWVTTlRlbzRXMDNvd3JFZkVWbnAzZitGWlZTcUxrbDFh?=
 =?utf-8?B?Yk5FUXU1RzFiVDFLU2pzRVVidEpSMDYxUTh6RUpSWVhXWk1pR1g5WWJiSXdv?=
 =?utf-8?B?dVozWjUrTHUwRHpXYkQvVGhJMXNidkE3cWt2R0daV2ZsTzJ6TDc5SjQ3ZzlH?=
 =?utf-8?B?REYzeVVUT2JLeERhK05FNE1uelM3VURKejFGRGhySDlyaVNaaWVTbVpsZDdk?=
 =?utf-8?B?Nkw1UHg1R0ErSFZSbVpzTVV2VlV5R2RianduZHo5V1JZWEJEcGpwNzlrbW1v?=
 =?utf-8?B?Y0ErT2xwRXJnU29HVHVFL0F5TEFaa3BUa3hnb09USEhkdFFyNmsyVTJxRVBS?=
 =?utf-8?B?RG1iSmxSTm4rb1l0SWwzVEgyZjlMSUFuSGtWbTdBaUF0ZkhpNGVKdFgzQ0NB?=
 =?utf-8?B?UjdScU1DOGZXbnZGalo2RHYrQjM4ajNsYm94T3B1OFdEM1FtQTZEVG9TRTRE?=
 =?utf-8?B?REtIRTgzdXZQT2VWcGZUT0M3T3FoUWxNN2FVdEdXS291MkZLNTdYeWdBSzBy?=
 =?utf-8?B?VWlwQlFZaHNJNWg3bkdmaTBjQk4zREovTGlSYVRhdis5d0xDZ3NDRGVEcU9n?=
 =?utf-8?B?UzVXTVEveHZpa1ppMEZKaXMzcVF3b1c1V0lsaGVNQzA4RGNjeUd5aTdlaDR2?=
 =?utf-8?B?V0E2eGJwR3FKdFF2R2tZSXN1d1NDeG5ENUJVOU5ydTkyV2xHUFNVMFhobitV?=
 =?utf-8?B?a3dpZnA0S3J2R0kxRkNHNlNiT3ZoVWdDMXNtU3h1VzROSWVzbGt6VE1tbExT?=
 =?utf-8?B?NTVPVE1CNGh5M1V5NVhxMHNyZU1GVjlENXV4VWRxYnAyRlNtdkY5bndsV0hU?=
 =?utf-8?B?dFZRejA1dzI1TURKc1ZBTnZZMUVzaHhRdEd3UzVueXJ6TzR0dUZ4K0dGWmtQ?=
 =?utf-8?B?NjNra09JLzI4ZmgyRFM5bitsY25tTXRlV0lpN2VBREdabWpuUG5vUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd10d7a9-04fa-4c42-c1ca-08da45b02315
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 22:26:43.2644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu6mCBq1f7ANtiUiDh1qZJkYm6pSpzgaBPr4DD1yPRy7yhh9Z4C/2G0NHmwlyLIfGftpVzbFNzEJzoaKCP/Psw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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


On 2022-06-03 06:52, Ramesh Errabolu wrote:
> Add support for peer-to-peer communication among AMD GPUs over PCIe
> bus. Support REQUIRES enablement of config HSA_AMD_P2P.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 312 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  33 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   8 +
>   4 files changed, 294 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f8b9f27adcf5..5c00ea1df21c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -48,6 +48,7 @@ enum kfd_mem_attachment_type {
>   	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
>   	KFD_MEM_ATT_USERPTR,	/* SG bo to DMA map pages from a userptr bo */
>   	KFD_MEM_ATT_DMABUF,	/* DMAbuf to DMA map TTM BOs */
> +	KFD_MEM_ATT_SG		/* Tag to DMA map SG BOs */
>   };
>   
>   struct kfd_mem_attachment {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 054e4a76ae2e..8e37eae26e49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -241,6 +241,42 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	kfree(bo->kfd_bo);
>   }
>   
> +/**
> + * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
> + * about USERPTR or DOOREBELL or MMIO BO.
> + * @adev: Device for which dmamap BO is being created
> + * @mem: BO of peer device that is being DMA mapped. Provides parameters
> + *	 in building the dmamap BO
> + * @bo_out: Output parameter updated with handle of dmamap BO
> + */
> +static int
> +create_dmamap_sg_bo(struct amdgpu_device *adev,
> +		 struct kgd_mem *mem, struct amdgpu_bo **bo_out)
> +{
> +	struct drm_gem_object *gem_obj;
> +	int ret, align;
> +
> +	ret = amdgpu_bo_reserve(mem->bo, false);
> +	if (ret)
> +		return ret;
> +
> +	align = 1;
> +	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
> +			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
> +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
> +
> +	amdgpu_bo_unreserve(mem->bo);
> +
> +	if (ret) {
> +		pr_err("Error in creating DMA mappable SG BO on domain: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	*bo_out = gem_to_amdgpu_bo(gem_obj);
> +	(*bo_out)->parent = amdgpu_bo_ref(mem->bo);
> +	return ret;
> +}
> +
>   /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
>    *  reservation object.
>    *
> @@ -481,6 +517,38 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   	return pte_flags;
>   }
>   
> +/**
> + * create_sg_table() - Create an sg_table for a contiguous DMA addr range
> + * @addr: The starting address to point to
> + * @size: Size of memory area in bytes being pointed to
> + *
> + * Allocates an instance of sg_table and initializes it to point to memory
> + * area specified by input parameters. The address used to build is assumed
> + * to be DMA mapped, if needed.
> + *
> + * DOORBELL or MMIO BOs use only one scatterlist node in their sg_table
> + * because they are physically contiguous.
> + *
> + * Return: Initialized instance of SG Table or NULL
> + */
> +static struct sg_table *create_sg_table(uint64_t addr, uint32_t size)
> +{
> +	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
> +
> +	if (!sg)
> +		return NULL;
> +	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
> +		kfree(sg);
> +		return NULL;
> +	}
> +	sg_dma_address(sg->sgl) = addr;
> +	sg->sgl->length = size;
> +#ifdef CONFIG_NEED_SG_DMA_LENGTH
> +	sg->sgl->dma_length = size;
> +#endif
> +	return sg;
> +}
> +
>   static int
>   kfd_mem_dmamap_userptr(struct kgd_mem *mem,
>   		       struct kfd_mem_attachment *attachment)
> @@ -545,6 +613,87 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>   	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
> +/**
> + * kfd_mem_dmamap_sg_bo() - Create DMA mapped sg_table to access DOORBELL or MMIO BO
> + * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
> + * @attachment: Virtual address attachment of the BO on accessing device
> + *
> + * An access request from the device that owns DOORBELL does not require DMA mapping.
> + * This is because the request doesn't go through PCIe root complex i.e. it instead
> + * loops back. The need to DMA map arises only when accessing peer device's DOORBELL
> + *
> + * In contrast, all access requests for MMIO need to be DMA mapped without regard to
> + * device ownership. This is because access requests for MMIO go through PCIe root
> + * complex.
> + *
> + * This is accomplished in two steps:
> + *   - Obtain DMA mapped address of DOORBELL or MMIO memory that could be used
> + *         in updating requesting device's page table
> + *   - Signal TTM to mark memory pointed to by requesting device's BO as GPU
> + *         accessible. This allows an update of requesting device's page table
> + *         with entries associated with DOOREBELL or MMIO memory
> + *
> + * This method is invoked in the following contexts:
> + *   - Mapping of DOORBELL or MMIO BO of same or peer device
> + *   - Validating an evicted DOOREBELL or MMIO BO on device seeking access
> + *
> + * Return: ZERO if successful, NON-ZERO otherwise
> + */
> +static int
> +kfd_mem_dmamap_sg_bo(struct kgd_mem *mem,
> +		     struct kfd_mem_attachment *attachment)
> +{
> +	struct ttm_operation_ctx ctx = {.interruptible = true};
> +	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> +	struct amdgpu_device *adev = attachment->adev;
> +	struct ttm_tt *ttm = bo->tbo.ttm;
> +	enum dma_data_direction dir;
> +	dma_addr_t dma_addr;
> +	bool mmio;
> +	int ret;
> +
> +	/* Expect SG Table of dmapmap BO to be NULL */
> +	mmio = (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP);
> +	if (unlikely(ttm->sg)) {
> +		pr_err("SG Table of %d BO for peer device is UNEXPECTEDLY NON-NULL", mmio);
> +		return -EINVAL;
> +	}
> +
> +	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> +			DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> +	dma_addr = mem->bo->tbo.sg->sgl->dma_address;
> +	pr_debug("%d BO size: %d\n", mmio, mem->bo->tbo.sg->sgl->length);
> +	pr_debug("%d BO address before DMA mapping: %llx\n", mmio, dma_addr);
> +	dma_addr = dma_map_resource(adev->dev, dma_addr,
> +			mem->bo->tbo.sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	ret = dma_mapping_error(adev->dev, dma_addr);
> +	if (unlikely(ret))
> +		return ret;
> +	pr_debug("%d BO address after DMA mapping: %llx\n", mmio, dma_addr);
> +
> +	ttm->sg = create_sg_table(dma_addr, mem->bo->tbo.sg->sgl->length);
> +	if (unlikely(!ttm->sg)) {
> +		ret = -ENOMEM;
> +		goto unmap_sg;
> +	}
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (unlikely(ret))
> +		goto free_sg;
> +
> +	return ret;
> +
> +free_sg:
> +	sg_free_table(ttm->sg);
> +	kfree(ttm->sg);
> +	ttm->sg = NULL;
> +unmap_sg:
> +	dma_unmap_resource(adev->dev, dma_addr, mem->bo->tbo.sg->sgl->length,
> +			   dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	return ret;
> +}
> +
>   static int
>   kfd_mem_dmamap_attachment(struct kgd_mem *mem,
>   			  struct kfd_mem_attachment *attachment)
> @@ -556,6 +705,8 @@ kfd_mem_dmamap_attachment(struct kgd_mem *mem,
>   		return kfd_mem_dmamap_userptr(mem, attachment);
>   	case KFD_MEM_ATT_DMABUF:
>   		return kfd_mem_dmamap_dmabuf(attachment);
> +	case KFD_MEM_ATT_SG:
> +		return kfd_mem_dmamap_sg_bo(mem, attachment);
>   	default:
>   		WARN_ON_ONCE(1);
>   	}
> @@ -596,6 +747,50 @@ kfd_mem_dmaunmap_dmabuf(struct kfd_mem_attachment *attachment)
>   	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
> +/**
> + * kfd_mem_dmaunmap_sg_bo() - Free DMA mapped sg_table of DOORBELL or MMIO BO
> + * @mem: SG BO of the DOORBELL or MMIO resource on the owning device
> + * @attachment: Virtual address attachment of the BO on accessing device
> + *
> + * The method performs following steps:
> + *   - Signal TTM to mark memory pointed to by BO as GPU inaccessible
> + *   - Free SG Table that is used to encapsulate DMA mapped memory of
> + *          peer device's DOORBELL or MMIO memory
> + *
> + * This method is invoked in the following contexts:
> + *     UNMapping of DOORBELL or MMIO BO on a device having access to its memory
> + *     Eviction of DOOREBELL or MMIO BO on device having access to its memory
> + *
> + * Return: void
> + */
> +static void
> +kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
> +		       struct kfd_mem_attachment *attachment)
> +{
> +	struct ttm_operation_ctx ctx = {.interruptible = true};
> +	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
> +	struct amdgpu_device *adev = attachment->adev;
> +	struct ttm_tt *ttm = bo->tbo.ttm;
> +	enum dma_data_direction dir;
> +
> +	if (unlikely(!ttm->sg)) {
> +		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
> +		return;
> +	}
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +
> +	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> +				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
> +	dma_unmap_resource(adev->dev, ttm->sg->sgl->dma_address,
> +			ttm->sg->sgl->length, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_free_table(ttm->sg);
> +	kfree(ttm->sg);
> +	ttm->sg = NULL;
> +	bo->tbo.sg = NULL;
> +}
> +
>   static void
>   kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>   			    struct kfd_mem_attachment *attachment)
> @@ -609,38 +804,14 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>   	case KFD_MEM_ATT_DMABUF:
>   		kfd_mem_dmaunmap_dmabuf(attachment);
>   		break;
> +	case KFD_MEM_ATT_SG:
> +		kfd_mem_dmaunmap_sg_bo(mem, attachment);
> +		break;
>   	default:
>   		WARN_ON_ONCE(1);
>   	}
>   }
>   
> -static int
> -kfd_mem_attach_userptr(struct amdgpu_device *adev, struct kgd_mem *mem,
> -		       struct amdgpu_bo **bo)
> -{
> -	unsigned long bo_size = mem->bo->tbo.base.size;
> -	struct drm_gem_object *gobj;
> -	int ret;
> -
> -	ret = amdgpu_bo_reserve(mem->bo, false);
> -	if (ret)
> -		return ret;
> -
> -	ret = amdgpu_gem_object_create(adev, bo_size, 1,
> -				       AMDGPU_GEM_DOMAIN_CPU,
> -				       AMDGPU_GEM_CREATE_PREEMPTIBLE,
> -				       ttm_bo_type_sg, mem->bo->tbo.base.resv,
> -				       &gobj);
> -	amdgpu_bo_unreserve(mem->bo);
> -	if (ret)
> -		return ret;
> -
> -	*bo = gem_to_amdgpu_bo(gobj);
> -	(*bo)->parent = amdgpu_bo_ref(mem->bo);
> -
> -	return 0;
> -}
> -
>   static int
>   kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		      struct amdgpu_bo **bo)
> @@ -691,6 +862,8 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	bool same_hive = false;
> +	bool accessible = false;
>   	int i, ret;
>   
>   	if (!va) {
> @@ -698,6 +871,31 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		return -EINVAL;
>   	}
>   
> +	/* Determine access to VRAM, MMIO and DOORBELL BOs of peer devices
> +	 *
> +	 * The access path of MMIO and DOORBELL BOs of is always over PCIe.
> +	 * In contrast the access path of VRAM BOs depens upon the type of
> +	 * link that connects the peer device. Access over PCIe is allowed
> +	 * if peer device has large BAR. In contrast, access over xGMI is
> +	 * allowed for both small and large BAR configurations of peer device
> +	 */
> +
> +	if ((adev != bo_adev) &&
> +	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
The parentheses around == and != are unnecessary.


> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> +		accessible = amdgpu_device_is_peer_accessible(bo_adev, adev);

This can still call amdgpu_device_is_peer_accessible unnecessarily on 
XGMI connected GPUs.

This whole block could be simplified like this

	if (adev != bo_adev &&
	    (mem->domain == AMDGPU_GEM_DOMAIN_VRAM ||
	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
		if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev, adev))
			return -EINVAL;
	}

The short-circuit of the && operator make sure 
amdgpu_device_is_peer_accessible is only called if necessary. And you 
don't need the bool accessible variable any more.


> +		if ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +		    (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> +			if (!accessible)
> +				return -EINVAL;
> +		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
> +			if (!same_hive && !accessible)
> +				return -EINVAL;
> +		}
> +	}
> +
>   	for (i = 0; i <= is_aql; i++) {
>   		attachment[i] = kzalloc(sizeof(*attachment[i]), GFP_KERNEL);
>   		if (unlikely(!attachment[i])) {
> @@ -708,9 +906,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
>   			 va + bo_size, vm);
>   
> -		if (adev == bo_adev ||
> -		   (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> -		   (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {
> +		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
> +		    same_hive) {
>   			/* Mappings on the local GPU, or VRAM mappings in the
>   			 * local hive, or userptr mapping IOMMU direct map mode
>   			 * share the original BO
> @@ -726,26 +924,38 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		} else if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>   			/* Create an SG BO to DMA-map userptrs on other GPUs */
>   			attachment[i]->type = KFD_MEM_ATT_USERPTR;
> -			ret = kfd_mem_attach_userptr(adev, mem, &bo[i]);
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
>   		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
>   			   mem->bo->tbo.type != ttm_bo_type_sg) {
> -			/* GTT BOs use DMA-mapping ability of dynamic-attach
> -			 * DMA bufs. TODO: The same should work for VRAM on
> -			 * large-BAR GPUs.
> -			 */
> +			/* GTT BOs use DMA-mapping ability of dynamic-attach DMA bufs */
> +			attachment[i]->type = KFD_MEM_ATT_DMABUF;
> +			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
> +			if (ret)
> +				goto unwind;
> +		/* Enable acces to VRAM BOs of peer devices */
> +#if defined(CONFIG_HSA_AMD_P2P)
> +		} else if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
> +			   mem->bo->tbo.type == ttm_bo_type_device) {
>   			attachment[i]->type = KFD_MEM_ATT_DMABUF;
>   			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);

Now this looks identical to the GTT case. Since the CONFIG_HSA_AMD_P2P 
check is already done in amdgpu_device_is_peer_accessible, you can 
probably just merge the two if-cases into one now:

	...
  		} else if ((mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
  			    mem->bo->tbo.type != ttm_bo_type_sg) ||
			   mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
			/* GTT and VRAM BOs use DMA-mapping ability of dynamic-attach
			 * DMA bufs.
			 */
			attachment[i]->type = KFD_MEM_ATT_DMABUF;
			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
			if (ret)
				goto unwind;
	...

If you move this after the doorbell and MMIO case, you can even drop the 
mem->bo->tbo.type != ttm_bo_type_sg check.


>   			if (ret)
>   				goto unwind;
> +			pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
> +#endif
> +		/* Handle DOORBELL BOs of peer devices and MMIO BOs of local and peer devices */
> +		} else if ((mem->bo->tbo.type == ttm_bo_type_sg) &&
> +			   ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +			    (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {

I think userptr, doorbell and MMIO BOs are the only ones that use SGs. 
So you don't really need to check the mem->alloc_flags here. Except 
maybe as a WARN_ONCE sanity check.


> +			attachment[i]->type = KFD_MEM_ATT_SG;
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
> +			if (ret)
> +				goto unwind;
>   		} else {
> -			/* FIXME: Need to DMA-map other BO types:
> -			 * large-BAR VRAM, doorbells, MMIO remap
> -			 */
> -			attachment[i]->type = KFD_MEM_ATT_SHARED;
> -			bo[i] = mem->bo;
> -			drm_gem_object_get(&bo[i]->tbo.base);
> +			WARN_ONCE(true, "Handling invalid ATTACH request");
> +			ret = -EINVAL;
> +			goto unwind;
>   		}
>   
>   		/* Add BO to VM internal data structures */
> @@ -1146,24 +1356,6 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   	return ret;
>   }
>   
> -static struct sg_table *create_doorbell_sg(uint64_t addr, uint32_t size)
> -{
> -	struct sg_table *sg = kmalloc(sizeof(*sg), GFP_KERNEL);
> -
> -	if (!sg)
> -		return NULL;
> -	if (sg_alloc_table(sg, 1, GFP_KERNEL)) {
> -		kfree(sg);
> -		return NULL;
> -	}
> -	sg->sgl->dma_address = addr;
> -	sg->sgl->length = size;
> -#ifdef CONFIG_NEED_SG_DMA_LENGTH
> -	sg->sgl->dma_length = size;
> -#endif
> -	return sg;
> -}
> -
>   static int process_validate_vms(struct amdkfd_process_info *process_info)
>   {
>   	struct amdgpu_vm *peer_vm;
> @@ -1532,7 +1724,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			bo_type = ttm_bo_type_sg;
>   			if (size > UINT_MAX)
>   				return -EINVAL;
> -			sg = create_doorbell_sg(*offset, size);
> +			sg = create_sg_table(*offset, size);
>   			if (!sg)
>   				return -ENOMEM;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b5ee0eb984ee..acb9e934adc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -32,6 +32,7 @@
>   #include <linux/slab.h>
>   #include <linux/iommu.h>
>   #include <linux/pci.h>
> +#include <linux/pci-p2pdma.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_probe_helper.h>
> @@ -127,6 +128,8 @@ const char *amdgpu_asic_name[] = {
>   	"LAST",
>   };
>   
> +extern bool pcie_p2p;
> +
>   /**
>    * DOC: pcie_replay_count
>    *
> @@ -5434,6 +5437,36 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/**
> + * amdgpu_device_is_peer_accessible - Check peer access through PCIe BAR
> + *
> + * @adev: amdgpu_device pointer
> + * @peer_adev: amdgpu_device pointer for peer device trying to access @adev
> + *
> + * Return true if @peer_adev can access (DMA) @adev through the PCIe
> + * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
> + * @peer_adev.
> + */
> +bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> +				      struct amdgpu_device *peer_adev)
> +{
> +#ifdef CONFIG_HSA_AMD_P2P
> +	bool p2p_access = false;
> +	uint64_t address_mask = peer_adev->dev->dma_mask ?
> +		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> +	resource_size_t aper_limit =
> +		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +	p2p_access = !(pci_p2pdma_distance_many(adev->pdev, &peer_adev->dev, 1, true) < 0);

This would give you a checkpatch warning. Please run checkpatch.

Why can't you initialize p2p_access in the declaration above?

Regards,
   Felix


> +
> +	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
> +		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> +		!(adev->gmc.aper_base & address_mask ||
> +		  aper_limit & address_mask));
> +#else
> +	return false;
> +#endif
> +}
> +
>   int amdgpu_device_baco_enter(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bed4ed88951f..d1c82a9e8569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -802,6 +802,14 @@ MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (
>   module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
>   #endif
>   
> +/**
> + * DOC: pcie_p2p (bool)
> + * Enable PCIe P2P (requires large-BAR). Default value: true (on)
> + */
> +bool pcie_p2p = true;
> +module_param(pcie_p2p, bool, 0444);
> +MODULE_PARM_DESC(pcie_p2p, "Enable PCIe P2P (requires large-BAR). (N = off, Y = on(default))");
> +
>   /**
>    * DOC: dcfeaturemask (uint)
>    * Override display features enabled. See enum DC_FEATURE_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
