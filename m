Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F5EC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 20:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A36C10E0FD;
	Mon,  6 Jun 2022 20:04:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979BC10E080
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 20:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiYX4oml9M/0KLnXqEUP22WJX0cqbpCvF98ZKeLxlRhy7aBpqk9LWoWFcFsF2EFn17Jn2bmuSCM49nS6mT4rEuDTnpeohETFjMoozuwE2FVQMDAKPkPFCeSny4VgQuRT9Uck1F7pqIUF8LCfFYZc2le28yF2GdcL1BIlB5AvOm+wC+FY6Z3shW2DlG18boPmlCiLr+BGNSPvHCLysfjMd3kDwgA3/fhVwwVMuIOa91wrnY0mBFYEXlu//z8aVWmNgMB7u+vK2/4GGikVFWVR9HMMJBQuVniwkzz3KMNqOQQxXUEE3TbPD6PXfwef251OH/ygDd8qLdqu8YfRoxbSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulAMHI51CE9xtDCfHtSahTdjAksqUeO+OuRF1Bu7tMc=;
 b=ESvgHkfshvS7+Om0PYZr6pHwUqKTD015BpHeVT1x127xhX6s4urBUOmwJM7vI9pdBO4vplaK5bN1I7AgLQbSIbrCrgxJGOnjP16y7N7idlvuYwgQE0HeRPlUMzRxeUko+J/PrwZzvoIHE6LL79l6TiUrq9bSGLZzGJL3jkmO14PzrxRMFB8Wph5xRAMpwcQLV43hoST4vmMo1NtztL+hlu3wD1vqj+uSWZ+ZWdA29ZWjkpo2EigLbUMgCKWts16uG4Lxd4E6GWhfbwlHdAWr4Y9F4yJ88OvX8OhDbi8JfcJoimkKvgBMeE+xIalrSM6xh7I/pElNIDtDvhLhAxjatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulAMHI51CE9xtDCfHtSahTdjAksqUeO+OuRF1Bu7tMc=;
 b=BNq+tjZH6ADRyJkT850r5Y9c/67ZJTobHEHk+ewlv45dRFLKLIlID+4vOERkUrxlypzUOAMuaxS2i76iz11wDD8gleubZDRYBtUhL6po8npYRb//J7qNaJfcFKTneWa1YHVbAxNY/nYN2wciUBWL26PHyWOQS1Ibs9SpH8zbkSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1871.namprd12.prod.outlook.com (2603:10b6:300:10b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 20:04:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 20:04:31 +0000
Message-ID: <650bb659-e29c-d0af-b104-5897d6c3ac03@amd.com>
Date: Mon, 6 Jun 2022 16:04:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606180742.3313561-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220606180742.3313561-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6529015-5fbd-469d-13fa-08da47f7c43f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1871:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB18716757C8BCA53E3306F4D592A29@MWHPR12MB1871.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWXGV9d6pZ2fit54n5Mf2bH5VxtSAbRVXIy+jjfds0oA1wMiKOIRoQ+5fflWM5n/4PACBW1qlDN08/G/GBK1PGPJ9GZpKyTPloS41HHKb2WGS+2QBTxPbVAf3gcxzknDV9Q6irrecwQKqNfINOwHiDBpGs0iRbtF7dcBg3RYS2/tCCMD7jfQLoO70jRMGBSlSZw9gOqUeH3DcahQasXVvdsG1/+4ZFwLDAfseMAccIoAfC+hqCQtKyiIvX3XpRxMMZLKt9L0NnmtXn4OcCjv8FeyM11Ts//OgNwPqh5LjukiaEh9pFnh0xAXZW6PWbJBtfb8I6FMKgC3zT0UO63rEaVp+diQ7RHIt9VdhVfrqyC9B1WFdcHPlWY5Ko37wuvCZSD9sna5FUp40GPDvyAmgzBQZFx2LMRKQtWoB+cEYh2iXklcPudTXyKxMu2SuK4xpPkhd0jRDpNR1N+NTv8yPpnKLNDmrvdL5rtLDjwHVjT2UZITpZdJ/DWaaTitW+wq0N3rbXSy7I2aYU5PsbHy23FuvDV3M833iJTHAeY59JqCFU4UWG2bW9nrFnmVPHrtfy/pvOJiY1pJF29oNtVpBMTiJMunwMr3pOfF4LPEPQhemdYbChGib59GdJounTB8ayHaYLOcZmVaZ33uDLc76+JiS7mU6ETc5hAn8ec1HMnmimOuN++oGYgn6iTo1dp/Iazh2SmXTRRffzUFpVenSYs9yxQ2GRMzytFVbLWpKUAlNt3OHfYhW6OXPw4PACxG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2616005)(316002)(6506007)(6512007)(31696002)(38100700002)(508600001)(44832011)(86362001)(31686004)(186003)(26005)(8676002)(8936002)(83380400001)(36756003)(2906002)(30864003)(66946007)(66556008)(6666004)(66476007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xJeXpPSlJaWVhlOGRzOGhVYmEwN3EvMkZBbXV6M2k0ZW9OTHdpeDYwZEVG?=
 =?utf-8?B?bW5QQlgvdUNUMkh3S0JSOEs0dzVzY2I4RzBiRCtZNkt5ckk2bUt3V2xXQVlN?=
 =?utf-8?B?dkxqU2hoMkxlYjdpcndncUQvakhSM3VVYjRwckNSTmwyTC9IaTc0V2J0OVda?=
 =?utf-8?B?L2lIVzVpK2JMYjh5S2IxNWFzbWVWd3cvNi93STE1VkE5eDcxbTkrR2w1ZE5T?=
 =?utf-8?B?cUo1Z0FPUkN1ZFVPc0srZzFWNXNkT0VyRXRuVFVjYmgxa05KVG5acjdxMFZa?=
 =?utf-8?B?L3ZkbGxUTWRCbDUrRlpCK3hZdDNlNkFmbkpSV3dxZHdVNk95K2hTL25VYkVm?=
 =?utf-8?B?MXJLUWJGTWlDdjJudExLd0hGcmdzZFoxQ0RGQmhXMGZhZ2VyMW1WakowbUFr?=
 =?utf-8?B?U29Rak5pM3N5YkloNzZvUmhZci85bXlnU2NjWTF0SWdhbnZQUko0d3pPSHUz?=
 =?utf-8?B?dGpYVytTUk5wLzl5ZWM1dFg5dUdlUlFnWXJHejNBRUZTR3ZablpjbXExcU83?=
 =?utf-8?B?VVlpK2syU0RQVnJTU0Y1aTFiVVprMXpEbXZpazUvS29hVVVpTVJNUlFtMDdt?=
 =?utf-8?B?RDFNNjg3eTkxanY1Y0dZbnJHZHd3cFJPd2FIUEMrNTg5ZkNzOFJLZ0w5OU9v?=
 =?utf-8?B?bDZpOVJVRTNiM085Q2g3TEZUZWpta0MxWXRHTVhucnE4Z1d3QjAybHRCYWZj?=
 =?utf-8?B?UURhMFdpYmpuTXlUSlpzTVdqb0dpbnBPTnVjMU9nR01IUzVqMk12WWd2dFh3?=
 =?utf-8?B?M05tejRoUG9xbWlySkhQdU5HZU5yWGp3R2J5UlBkWHZDVllGOXlUSVpkcDlp?=
 =?utf-8?B?b2taYnJyT2hHSnYwWW83b045SEJzVThnTFkrTm9WK2N2SUNxUDlKVjJHRml0?=
 =?utf-8?B?MzZJdk9FcjFxdk03VzhCZGRScU9ja21YZG91QWxrRzNYUUFwSFY0VFNXTnJ6?=
 =?utf-8?B?MnM2ZUVGSWFZOHFYbmljTVJ3bVA3RmRGeEVCQnlUVUlVYUZBa1VYdjg3TDVx?=
 =?utf-8?B?bk9zZndqTFN6V1A1bGJ0Uk9mOXBUeDJGcnNlNi9CV09rZ0w0dUZPV3VBM3d4?=
 =?utf-8?B?Slp6dkNzNUl1bkN1dTI1MWc1WFFwaDNQVndITTJXdE10TXZOMXpqeW5vQkRz?=
 =?utf-8?B?OUh1N25HNWRIT05VOEwvMUF5d2FoWWxRVVRxclU5Zk41QXRxNXhDSFRiL3lp?=
 =?utf-8?B?QnNOcFVPc3oyYzVwRWhDVlhweS80U1hNS3QwNTB4encyTXNNMDNhcVZCNEUy?=
 =?utf-8?B?cFBDTzVwcTVDcWx1a1lvMnRUTE1WT0tNV2pQeVU4Rjk3UUVZYmUvUjREdGlw?=
 =?utf-8?B?Vlp3Y3k3NFFUeE10VUlZY3oycG43dFlqY1ZpbmZKWnhTWDBxcHpkZlJEbDY5?=
 =?utf-8?B?WXhsZGlzVWxrZ3MvL3dnaXRGQ0krWkJQMzkwaXJyMUNWZUlUSmo0RCtkY2Jl?=
 =?utf-8?B?clI3c2E2b2NFQTNHOWJQZTN0WDkyQkZEdTZpRjRkbXJSRS9aaWhzUzY4eGlt?=
 =?utf-8?B?QTR4QVpKOXdHeHhzckFxSTkvcldibDk1R0Y1MStjZ2xtdEVvUUhxdEhpRU53?=
 =?utf-8?B?V0sxSmlxRktQRVVjV0d6c01aRDNiaGpJKzNuVDE1ajRrYllaZFpOaUx1S3I4?=
 =?utf-8?B?bjFFQXdISmRkeHZ3UXhLMldNT0NITDNrSDIzWmVvc0Z3SVRUamVpdmJtbU5n?=
 =?utf-8?B?UVlFRGgzRjhOOUlJSGp4UFZNbFpSM20zY082VkJmL09tNFhteHJlREJUeGU2?=
 =?utf-8?B?am52Wmd4Y0VYQ3ZEMnRqR0JsQkNMNXh0aWZiN052N29kU3hmLzFiNHdhUUQ2?=
 =?utf-8?B?OUVoM2lpcDF4L29memRoTHllMU1NWHp5K0hzYnZTV1NoaFZscUJuZTBxazlI?=
 =?utf-8?B?ZHBpcGV5bjMvQ0RJNFA0THp5Y0ZMVjFjMldLTkg4NkorNlFsZGR3NGxkWWFx?=
 =?utf-8?B?NUhxbWRuWS82eUZIWUU1dXdGR2p3RFBUeC90VGZ5TnJ2djluWjBnUFZXU2F0?=
 =?utf-8?B?WVB4RVJRc2p4TjIrN0lhbXQ2akxuSUcrcHdWeXhTNi95QTYySzBrTDcvSVBW?=
 =?utf-8?B?c1QwbjVwQ2tuNFhpMXRQREtZQVR2cHB5bmdvMUNmQmhsVWNMeGwwcnk0TlFm?=
 =?utf-8?B?WXVMVlQwVE5YcmdnK3lYV002OGIzcnNndmZNaUpYVFVreE5qb1A2UTFqUGNt?=
 =?utf-8?B?MUFtYUZjZHRjTm4vMkpOR0E3Yk1Uc1F4Y3g5czcyaFR1WVdWMkhBWjhaVG55?=
 =?utf-8?B?LzlyUG1ieHhkNGR3ZmUxQURlRjlFYkR3MU5FUFNib2JXVVBISVFJRUJJMWZG?=
 =?utf-8?B?VWd1QjlRVjZacGhpREZoOGt1d3FKZ3IrY3RXa0RtUCtGVmkvS2ZKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6529015-5fbd-469d-13fa-08da47f7c43f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:04:30.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe9S3zO80aW2XVtZAlUnXnFV3eQJn1Az4OVHSyTHg7O87zSUzJfENyNmt+HwvwfN9QrAmDUm2BkeJLZk5m/1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1871
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

Am 2022-06-06 um 14:07 schrieb Ramesh Errabolu:
> Add support for peer-to-peer communication among AMD GPUs over PCIe
> bus. Support REQUIRES enablement of config HSA_AMD_P2P.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Sorry, one more nit-pick inline. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 300 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  33 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   8 +
>   4 files changed, 280 insertions(+), 62 deletions(-)
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
> index 054e4a76ae2e..ce012a148ed7 100644
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
> @@ -691,6 +862,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	bool same_hive = false;
>   	int i, ret;
>   
>   	if (!va) {
> @@ -698,6 +870,24 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
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
> +	if ((adev != bo_adev) &&
> +	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> +		if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
> +			same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
> +		if (!same_hive && !amdgpu_device_is_peer_accessible(bo_adev, adev))
> +			return -EINVAL;
> +	}
> +
>   	for (i = 0; i <= is_aql; i++) {
>   		attachment[i] = kzalloc(sizeof(*attachment[i]), GFP_KERNEL);
>   		if (unlikely(!attachment[i])) {
> @@ -708,9 +898,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
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
> @@ -726,26 +916,30 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		} else if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>   			/* Create an SG BO to DMA-map userptrs on other GPUs */
>   			attachment[i]->type = KFD_MEM_ATT_USERPTR;
> -			ret = kfd_mem_attach_userptr(adev, mem, &bo[i]);
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
> -		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT &&
> -			   mem->bo->tbo.type != ttm_bo_type_sg) {
> -			/* GTT BOs use DMA-mapping ability of dynamic-attach
> -			 * DMA bufs. TODO: The same should work for VRAM on
> -			 * large-BAR GPUs.
> -			 */
> +		/* Handle DOORBELL BOs of peer devices and MMIO BOs of local and peer devices */
> +		} else if (mem->bo->tbo.type == ttm_bo_type_sg) {
> +			WARN_ONCE(!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL ||
> +				    mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP),
> +				  "Handing invalid SG BO in ATTACH request");
> +			attachment[i]->type = KFD_MEM_ATT_SG;
> +			ret = create_dmamap_sg_bo(adev, mem, &bo[i]);
> +			if (ret)
> +				goto unwind;
> +		/* Enable acces to GTT and VRAM BOs of peer devices */
> +		} else if (mem->domain == AMDGPU_GEM_DOMAIN_GTT ||
> +			   mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
>   			attachment[i]->type = KFD_MEM_ATT_DMABUF;
>   			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
> +			pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
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
> @@ -1146,24 +1340,6 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
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
> @@ -1532,7 +1708,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			bo_type = ttm_bo_type_sg;
>   			if (size > UINT_MAX)
>   				return -EINVAL;
> -			sg = create_doorbell_sg(*offset, size);
> +			sg = create_sg_table(*offset, size);
>   			if (!sg)
>   				return -ENOMEM;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index be0baacc5942..8e88e7c88d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -34,6 +34,7 @@
>   #include <linux/pci.h>
>   #include <linux/devcoredump.h>
>   #include <generated/utsrelease.h>
> +#include <linux/pci-p2pdma.h>
>   
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_probe_helper.h>
> @@ -129,6 +130,8 @@ const char *amdgpu_asic_name[] = {
>   	"LAST",
>   };
>   
> +extern bool pcie_p2p;
> +
>   /**
>    * DOC: pcie_replay_count
>    *
> @@ -5498,6 +5501,36 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
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
> +	uint64_t address_mask = peer_adev->dev->dma_mask ?
> +		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> +	resource_size_t aper_limit =
> +		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +	bool p2p_access = !(pci_p2pdma_distance_many(adev->pdev,
> +					&peer_adev->dev, 1, true) < 0);
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
