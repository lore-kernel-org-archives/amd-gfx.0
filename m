Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C88C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96AA10EE63;
	Wed,  1 Jun 2022 16:12:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1849210EE6C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY3zTECHpcqOQwsdmBrT54rrR/brDjFFWQGZy35vBdc8nsvEUAQuPPONeH8v/BuQNQkcYu04EpzRrJe4Mpkn3vMasOovEzNuz5bTF+0/Dxad9e3P9WocqTfurmH8Cj4ro5eqQK3ZXK6rEzRbLdO9bgTS3DPQ2+YODXiSN10WvqCHFNMzpl/Vg6NsTuYFk33+h7JiwWd3QLvmEbLoBo6jFtB3NyUAt3koUy2nxm05InUIvNDzL1OY4CCgW7eM7aTOnihEoT6iT+dIxnDwFOB6BSWr2pb5Dxosjf0VN39FP2nd2upTz/tWAn3GCw+2ts59f/XB4FGyFbqi/t+eNi6o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2ibo4JTjxSHr4Ao9zR9MXrnlU5eG22CVwTM3CfvA4c=;
 b=k9lj3+raJNSL/VgrISrRbr18zkdbpCkOd4lP/BTkNNWWzYk3JkeGVh/gMIAVUppO8Sho07M2KADVeg+dkAueGPLjy3WxBQ7Zdzas5kIeKFZryrIUVKk7OrUbcjsqcnr+8+Q2C41kkD4WgT/exMD47Jz0TkLsxEJM4AjWEbZV6vRO0MN+DK0Kk8VyQ8zKiWHLb5AqWFbGpEzvGt1OBFv2r9NSZXPKm5hUuyysgzvaYeX9vkU1FA0XeQHe49wqUDCLghpX6MqeXPwPPukwLo472QHzPCa1t+YXNP/dgi9LHJkjxB2giQ0cvCR6IUTqwQu5nowlqxx3ix7yIbr5RZHdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ibo4JTjxSHr4Ao9zR9MXrnlU5eG22CVwTM3CfvA4c=;
 b=XHO6akL1ulYe6cO9WGEaqv/GE+zBLcCxGiktJi09H5PMawndpAAgR3iyEe+5MpvDvFHtXalW5BVG5YiILNumKDZH6RfVQuOk+jhxFYuKJIMTmK0GXO36R53kO06Y2Q/yadaJjqygH0iwJdWVp928G3pkDGNIebVgYlyeWoYeYQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR1201MB0104.namprd12.prod.outlook.com (2603:10b6:910:1d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 16:12:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 16:12:10 +0000
Message-ID: <d4b9aca8-2ec7-908b-a526-a51ed11cc1a5@amd.com>
Date: Wed, 1 Jun 2022 12:12:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220531170141.788526-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220531170141.788526-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2bf8c95-e637-41d4-4e36-08da43e97b20
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0104:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01041D24F2D330F60164FAF792DF9@CY4PR1201MB0104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/144Plobvzi2h4gREAro5GJo0uMHm0Edzaz8cE6qLqa3FCTYhwtUP5LfB+1E6tZb25eALVcRVknCrSjFvVD8V81V5bsZxcj4cJUOZNImt/R2BNctvY+KG3NtM/mkVym1rABDRhX0Ahz4+d5bbBQCwMZ3bsUlTF1HgQqs4v2BYxaWo5i0TFWyC8H/hAFYQjaAFbkw124ZyQnP7ntQtgQFddOQSlJYEqPbrpMNx12SXvcVg6cvsIxJDNuPUNKNYL1v/gDfmoOtEsFYigF9VsJrosGoyZPvrtvgBa2xzZBgefUwgS14ndsKw/cOtbJ7BysNosPtpqrhyGudyuRJkbVs+CzOfAbJPdo87N53HfpGqxht+NesKfYj67KVKPxB4OHGnuUO3eOkhrxeEUVSe+D/9DPA5Q3x2I2R5TKgNdRS5Yt+AM1mlGGyUB3j0YumadM9QeAYXWgSF8dI5/c9G/tP8+43YLk/bH0tuzogcsRwA27fkM7YxvMqqd7iSKu20eGVx60y57KiI5i02V0z89nzsZGTHeD64w2yslHyV/OWIJDxRDdHIiY/76MNH5PgjthLt+RlVvPVIggr/ukKBBL8m/hIa9rb/OJmtbIXMAn4ueKjFgySK0cejYfDsQYo+jhaDE5lija1UU1wE67Pn4/KvNgamhGcvqyM5xqy3MGBfrJq9bjKfidFlWEOoz7S6emQ6aAfh3ViHGMDtqJdo1z9Dm5WNwVnLmR5mWJkM2zm7E2Ky/PJQFbOpSTkspb7HBv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(6486002)(6506007)(86362001)(26005)(2616005)(6512007)(2906002)(38100700002)(186003)(31696002)(83380400001)(30864003)(44832011)(66946007)(8676002)(66556008)(66476007)(316002)(508600001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl3YVVZbDUyam1XU1FUbTREOGs5MjZsVUY5SEFWVHRaa2FVbXRuRHNLS25r?=
 =?utf-8?B?S2RyMWxEMXVUK1c3WTk0V1dLSnRrOWFua0N1SG8zeGxzSzZwSGNLNEYrT1ZM?=
 =?utf-8?B?em9pMnRWUi9RcUYyaWJHalBaUm90cVlLN0w4ZXNjUkZDQUFOY24yMHVncHNt?=
 =?utf-8?B?WjB3UWlxbzEvcDltZ3hzdWxYaWtScVZORkZUM1hIRVFDL0VjU25hR1VHZXdw?=
 =?utf-8?B?WHZscTJub3RtcENvc2JuVU95OEZjVE5KaEtSVlBOa0xPTG53c3UwZWd6YjlG?=
 =?utf-8?B?T2c5QXJNVkRVRWFVakFJMTRGNUp4aDJBZDFvTWRzRGtoUVFPV1NUTVpIcERs?=
 =?utf-8?B?NDdtQjM5cW9IU29IS25uNnNEcFhzQTNFZEZaVVdUM0tBYnAzaVVzSmJxWmhW?=
 =?utf-8?B?eDdJMXpWWmJDVmVPZjJPV3ZwNXV6amNMQmhBcEJNSnBlYmg4aUxHbE52eXZq?=
 =?utf-8?B?b3lpSjlBMk9mclVXMDZOenQxblNtN1AyQzFiRlphSHppVXVYM3dLMmFySlNL?=
 =?utf-8?B?ejhwM3JTdXkrbGJWemVWZlVZREM0SHl0WHQ2QmpBeGpxaE1ZSEVYT25QdGk0?=
 =?utf-8?B?WGhWU0V2aE9MRGNvSmpCR28rbVcwMHhiNjl0TTEzQ2pTUFJGNksrZFhDZjVi?=
 =?utf-8?B?R3B4SzFYVFNsQUJnNDVkVzA0NzlDL3p6ZjJIMjVkcXpCb3BWc3FaSmMzbWZD?=
 =?utf-8?B?RDRKMGx1WlgvMnRjWTBrTEhWeThGZE54S0hpRDlTNURmaHpUS2lWcnczTE9T?=
 =?utf-8?B?Qjh2b28yc0Z6MmdPVW9kenRjeWdURWMxR3ZhSjVObGQ4UktZdWN3cEdYd1hp?=
 =?utf-8?B?MjVuVWRrR3BWem04Nm1CTWtjY3JEWlVtazNraEJ0Y2xNL0FtSy9qbTAwUGtD?=
 =?utf-8?B?YWV2bnFDQzZoOEg1eUkyYVdRTWMydDh4OCtVNC9XTlVIWWJuelgxQlg4TU85?=
 =?utf-8?B?VDBEcnJCUGp0V2Q5ZXlSTk5TaDd1NFlUcWpCZnlGMDRQZWwxUUhubks0S1VJ?=
 =?utf-8?B?WGVzQW9TUUcrUFg0b1VRSVR0N0FoZTdPWHpLWktNMDNFN0lkcitXTUZiMEZP?=
 =?utf-8?B?U2ZuSmFzVTloTkRlMk9BaGxIZEhuVFg5WUliTkovWFF3Nk56N3BBTDVWalUr?=
 =?utf-8?B?T3ZYNVFYazlYZXRLdHRtUGl3RFJJUjRTcTBJcGpneXd4a0xWZFYxWThjYWpG?=
 =?utf-8?B?Kysvb1Urb2JPVGJuWE9DQzdhUkFlUk5Yelg1d3JBTmFmL0gzU25ZVHRtVWZw?=
 =?utf-8?B?azBuZCtVSzZQYUZ5TE9DdTVLZ0RsVVVYZlVvRWFYeVlsVGU4Z0Zsdk9GVFFD?=
 =?utf-8?B?SUZYQ2hLR09uanZlNDN1QW0wMHMvWEVJNithUjhGL2FrdkFoVTcvZXdud1Z2?=
 =?utf-8?B?d24yc0xqKzliZ1ZmTHdjZXFKOHF0SnVzV2t3eGozOW9PeEN5WlIrVGN0Rm1J?=
 =?utf-8?B?MlZERWdxZ0k4c1p1cVhDSGRJeVRUd3BhakZ4MG4vRzE5S2Q2Z3RReU4rdWhm?=
 =?utf-8?B?dFdtWWNZZmJXUXZJelNBTWI2UDhnMUIxNFJyWDIreE1oeW93S1l5UjNMb2Jo?=
 =?utf-8?B?b3R1K25Sbm9RN1BwMEVyQndOSnlvMCthcGU4dzBGWkxiRVJYK2EzOWpVaVJz?=
 =?utf-8?B?ZlFrSEpRNkNpb2xlVitzUUZGREkxak42K1ArM3lJWGtReHhBeUo5dUFBYllV?=
 =?utf-8?B?c3FHYzY2TEFBMEJyN2RiMC9MSEd2OWhVaUJEcmpWQ3NFNGxDQWM1M1RRYy9B?=
 =?utf-8?B?b2JIQVFaUkxqVnhNUitLMXhLMkVGa05qOUMvVHBSUUp0SnZaSERCN1J0Szk2?=
 =?utf-8?B?ZkNxQWI2OVJHaXUvVmxoM28yTWdjZExadGxkcU1yaStrU2R4NkFaQzAvUlRu?=
 =?utf-8?B?OHU1blUwR2tvRjB4NFpuS1F5d1BycWZxbStQdlZiWWwzN0RXa2kvcFN5NG91?=
 =?utf-8?B?NXZvQk5RdTZNZjJIWkxNQ2ZOYlNDcVJmU0lqVEY5V0RvRERRNHNrM3NuNHdB?=
 =?utf-8?B?bFp6bW9PVnZoYlRLa2lTbXBTaTVMeVFJWXE4cDVTMVpQVnBKMjFxdkFleE83?=
 =?utf-8?B?Ylg4TzNrUE1GQ3I3WHk0YldPeEJNeXZ2MitQTEtPSzVTaVQrUUR6eXhLNWZh?=
 =?utf-8?B?cU5XSWJzZ2lESzRmaXZPOCtGcDJWMW8yak90ZTNmVGhtTVVVcFZnV0J2V3JT?=
 =?utf-8?B?THlsVmlaSndORjgrN1l4TEtrcDZObzF2T1ExcjMwdGplNUF4UjN0QnJlNzlx?=
 =?utf-8?B?ckJ1SWlvWCt1NnJ1Y1dCamhkd3lkakh3a01UcXplREE2OHV6ZklCMGhXVnQ4?=
 =?utf-8?B?WVIzWVBQd0dlZTlhQnpuL0ttb1Bwei91U0FPVmZqMWRQbUZiY09mUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bf8c95-e637-41d4-4e36-08da43e97b20
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:12:09.9751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unHaDgj1dlUSiIeGLv/uIDTzGZvE8hf6UKXhG0UNeO1pdyJT4WvmmV3RBFYP0B8sT3jyL0asSFE824mEf4gFAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
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


Am 2022-05-31 um 13:01 schrieb Ramesh Errabolu:
> Add support for peer-to-peer communication, in both data and control
> planes, among AMD GPUs that are connected PCIe and have large BAR vBIOS.

Please don't use the "control plane", "data plane" terminology here. 
This is not common usage in this context. Also the reference to 
large-BAR BIOSes is incorrect because BARs can be resized.

More comments inline ...


> Support REQUIRES enablement of config HSA_AMD_P2P.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 328 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  30 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   8 +
>   4 files changed, 307 insertions(+), 60 deletions(-)
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
> index 34ba9e776521..c2af82317a03 100644
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
> @@ -670,6 +841,38 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	return 0;
>   }
>   
> +/**
> + * @kfd_mem_attach_vram_bo: Acquires the handle of a VRAM BO that could
> + * be used to enable a peer GPU access it
> + *
> + * Implementation determines if access to VRAM BO would employ DMABUF
> + * or Shared BO mechanism. Employ DMABUF mechanism if kernel has config
> + * option HSA_AMD_P2P enabled. Employ Shared BO mechanism if above
> + * config option is not set. It is important to note that a Shared BO
> + * cannot be used to enable peer acces if system has IOMMU enabled
> + *
> + * @TODO: ADD Check to ensure IOMMU is not enabled. Should this check
> + * be somewhere as this is information could be useful in other places
> + */
> +static int kfd_mem_attach_vram_bo(struct amdgpu_device *adev,
> +			struct kgd_mem *mem, struct amdgpu_bo **bo,
> +			struct kfd_mem_attachment *attachment)
> +{
> +	int ret =  0;
> +
> +#if defined(CONFIG_HSA_AMD_P2P)
> +	attachment->type = KFD_MEM_ATT_DMABUF;
> +	ret = kfd_mem_attach_dmabuf(adev, mem, bo);
> +	pr_debug("Employ DMABUF mechanim to enable peer GPU access\n");
> +#else
> +	*bo = mem->bo;
> +	attachment->type = KFD_MEM_ATT_SHARED;
> +	drm_gem_object_get(&(*bo)->tbo.base);
> +	pr_debug("Employ Shared BO mechanim to enable peer GPU access\n");

This is something we cannot do in the upstream driver. If P2P is 
disabled, we have to fail any attempt to map peer memory.

Therefore I think this helper function is not needed. You can just call 
kfd_mem_attach_dmabuf directly in kfd_mem_attach.


> +#endif
> +	return ret;
> +}
> +
>   /* kfd_mem_attach - Add a BO to a VM
>    *
>    * Everything that needs to bo done only once when a BO is first added
> @@ -691,6 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	uint64_t va = mem->va;
>   	struct kfd_mem_attachment *attachment[2] = {NULL, NULL};
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
> +	bool same_hive = false;
>   	int i, ret;
>   
>   	if (!va) {
> @@ -698,6 +902,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		return -EINVAL;
>   	}
>   
> +	/* Determine if the mapping of VRAM BO to a peer device is valid
> +	 * It is possible that the peer device is connected via PCIe or
> +	 * xGMI link. Access over PCIe is allowed if device owning VRAM BO
> +	 * has large BAR. In contrast, access over xGMI is allowed for both
> +	 * small and large BAR configurations of device owning the VRAM BO
> +	 */
> +	if (adev != bo_adev && mem->domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +		same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
> +		if (!same_hive &&
> +		    !amdgpu_device_is_peer_accessible(bo_adev, adev))
> +			return -EINVAL;
> +	}
> +
>   	for (i = 0; i <= is_aql; i++) {
>   		attachment[i] = kzalloc(sizeof(*attachment[i]), GFP_KERNEL);
>   		if (unlikely(!attachment[i])) {
> @@ -708,9 +925,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
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
> @@ -726,26 +943,35 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
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
>   			attachment[i]->type = KFD_MEM_ATT_DMABUF;
>   			ret = kfd_mem_attach_dmabuf(adev, mem, &bo[i]);
>   			if (ret)
>   				goto unwind;
> +		/* Enable acces to VRAM BOs of peer devices */
> +		} else if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
> +			   mem->bo->tbo.type == ttm_bo_type_device) {
> +			ret = kfd_mem_attach_vram_bo(adev, mem,
> +						&bo[i], attachment[i]);

You can just call kfd_mem_attach_dmabuf directly here. Wrap this whole 
else-if block (and the following block for doorbells and MMIO) in #ifdef 
CONFIG_HSA_AMD_P2P.


> +			if (ret)
> +				goto unwind;
> +		/* Handle DOORBELL BOs of peer devices and MMIO BOs of local and peer devices */
> +		} else if ((mem->bo->tbo.type == ttm_bo_type_sg) &&
> +			   ((mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> +			    (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {

I think we need an amdgpu_device_is_peer_accessible check here, except 
maybe for local MMIO mappings. Alternatively extend the 
peer-accessibility check at the start of this function to also handle 
doorbell and MMIO BOs.


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
> @@ -1146,24 +1372,6 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
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
> @@ -1532,7 +1740,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			bo_type = ttm_bo_type_sg;
>   			if (size > UINT_MAX)
>   				return -EINVAL;
> -			sg = create_doorbell_sg(*offset, size);
> +			sg = create_sg_table(*offset, size);
>   			if (!sg)
>   				return -ENOMEM;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f16f105a737b..3dfac07cf37c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -127,6 +127,8 @@ const char *amdgpu_asic_name[] = {
>   	"LAST",
>   };
>   
> +extern bool pcie_p2p;
> +
>   /**
>    * DOC: pcie_replay_count
>    *
> @@ -5463,6 +5465,34 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
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

I was expecting a call to pci_p2pdma_distance_many somewhere here.

Regards,
   Felix


> +	uint64_t address_mask = peer_adev->dev->dma_mask ?
> +		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> +	resource_size_t aper_limit =
> +		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +
> +	return pcie_p2p && (adev->gmc.visible_vram_size &&
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
