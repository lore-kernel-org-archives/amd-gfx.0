Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B286BA4D4;
	Mon, 25 Jul 2022 14:20:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487E9BA499
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 14:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utfb4arRexh/ZzGEe99cPZPMSJiXCUU8wj71LQ9CInVsnpMLUTn44B/CVmZyjeeA74/YBt64J4mV8FLW9TXwgwHp2TN/p93LcY+K2ROq99RKC9BgOq5Z1gD+cg2BJ80LMoVWgL1XJSazZShDnjh93eOOtYq+hrPEZFpCmHHi+7cXqcQ/KktH0DqMn/vHwedFFnqxEc5HNazMJKsa2EkDxxmz8bEbyEFiU07vYVxdXRDM/oHmqs5Mfw+cJRz5dKX/9pwy5wq/PUIO3cp3BcRjWOgjlxUjBeld+9ecUj3JTIk4u4VvmmWFLNDk45ZpzxsIZ7X6HaY58w23ONFXI4zP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcIE9QFk4F7TmC2gof7wQDIaQ+UlwDmnlZUipPWOVMw=;
 b=IWHsFKxjzcV5lBgu7ycvRAppq9sQEyCqQzbkUv9vi3Zye8bRzTCGmqCglWNLQVw8OpMd3RQ4JETP6iSfNxUH1vQhEjCnPbpaxBM0tBKzGzoQzxyUeFr/vLFXaNw39HVEiYM9Es4YeQe+HfgqAupbf5yoH9Vd2S9ui7v//pIt4Uycmh2oas8qe7u/SlWb4tgVT+5vZPaGG4q/MXqZKQbRPSk/tKKDDFehFJUrNXbJVX+nfH4HUy1qazf0QZ8fIzRNRPoVPcLGwwyblpO0P3IHdU0rtBo8fi33I6qqj3XRjgOriwGYzCQL1s/Uol+yPWN1qZyMsSdYDDbrwE85iXJl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcIE9QFk4F7TmC2gof7wQDIaQ+UlwDmnlZUipPWOVMw=;
 b=oCgvx82HhxOhDAv2WDiSDbjBMHAJmzR/Qmfm9bdff9Nc8tL9IVy3uCEIQbd7CIxtuzXAeWcQcph3DTy+/S9UfQUICOAgRaj8KPpb1IwHp7t+wHUU09Vi3h5Yan6YCpEDf17vVtSHBwcNDQMk0RA2u4XtDJgyeUU1d0h/Tp3meKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.24; Mon, 25 Jul 2022 14:20:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:20:20 +0000
Message-ID: <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
Date: Mon, 25 Jul 2022 10:20:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725103205.2085630-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f3b974b-1b36-4110-ea5d-08da6e48ce21
X-MS-TrafficTypeDiagnostic: DS0PR12MB6557:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyC6v7c//oJsntxyrDJNiq1nCmFzyTWOV3MN8a0+lcuxj7PRKkO/d9EMgNcSmewdsV6iyJEf/dyiTQP9NXUqTTGXEZd5K9s05Z4O4BFsxyeGihzgH4fBLrUQE3gtKYJFLbI9UhF9wuKMkjCR4OK07nYqdqWWPyQnYCPvZy5ViyW7uslLpaQ84asLVZWmG1Lbk5ORuFDtd6yMxIQE7fXd7AMfo89AmMI7z66PdGFLyPsQN0HXR/Q1V4NbC0XGRS0N7R/FqDfD4lYBXsUzPY7cjBGAQZdfAPnRKzw6lLxVwDFRyVV+p60Gx55Ubet8PcuEvZpSwp7Mo9mUVLdFZjiBJ7hFdZYYFAVHavCaoFU8KLK1FDkUJyxoNmWS62OKkBHn6uov51c/nnLV75wukNzEgRuO9CJhV3EsjQUQqDewb/AlwB1o2IjtX+Gp4SGp6+/0R0BM7GBhWh0LgsAGfk2AmaS1gUO7JxQSxuoPcofguKZm/H81AX5UNloJI/vwhBTpVsF2vTi4x5YSjni4YSOTgrHFggfONZrkwJRsTv0PY/Utl+3wOV0vMyOawJ1C2EqUc/pfA+Nh+Ga2nTDrDNwZ2FbJZxM5leXMkX373SYJ5G9AyYWKcu0WGhGuxBI60rmW9SQX/ePq62Dj7qj3+ZUT6WIwQy+GXvBuL8+8/NYmTMJExHqfY+oGdJ6eWjdn9THnCF5U+Pkf3e1hOz5dG9DAPM1BL50lEBkQvV/Gn8atZQm1Zmvt/8n++Y1oQ5WhRW9+VgHGyMnA6/vfV+48cJBjE7x8hyxjD4G0DCWf+vwGnpidMyksIasAnMCuqJPXkMNYoV8QoVASBbVANj+fryd9hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(31696002)(86362001)(36756003)(38100700002)(31686004)(186003)(83380400001)(2616005)(6512007)(6666004)(478600001)(44832011)(2906002)(316002)(6486002)(26005)(8936002)(54906003)(6506007)(41300700001)(8676002)(4326008)(66476007)(66556008)(66946007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEkvSURzTVRpR1NSdFREQ2VxWkUwcTRzSVFLZGNqUTlhZm5XTGFsenpuWkdv?=
 =?utf-8?B?QURyYUlRRWhKN3lMcjVEdUxyeERNR3V3N0xjdXZ1TEJtL01iZVRHTi9ndjA4?=
 =?utf-8?B?elF5aWlSczA0djhIVmNESGwrakdTcWR3MUdNSnJ1NlgzbWEwQ2ZRRUE5VURa?=
 =?utf-8?B?T0M4QVQ4N0tyNzUvemNHR2FDa1dHUkQyZ3U2Q2p6TEpheW5oaDJkbTlhRGJD?=
 =?utf-8?B?VjQyZDN0OE1TOHhTN1I0TUh0dTBjZW50enJSU0djNjhVRzFXbjFveHpEUFFH?=
 =?utf-8?B?aGRXVjgrd0pCakpuZmdnUWptQ2paMGp0V3BRSmNOZERCeGxiMXpEVG44Nmlx?=
 =?utf-8?B?VGZFWHBkdU9OemJNNUx1YWlRWXBzV3czMzRBcy9ZTUd2YXYvallxcVkxbTd6?=
 =?utf-8?B?d3duZEQ3UXdnV1VSMHZCVlRtNGFvclpoRG9XazFsQ2QwWEZKN0NjM3dpVUVP?=
 =?utf-8?B?QnpuakF1ZUZWeWRrd2hHcVZDZUg4Wm5YZWFrRnZOVTRyTFJVMDNrZXY2bVlC?=
 =?utf-8?B?dXdYdTF2NTZ1YnRwbXhjUlpSMU1IaU1Ec0IrdFJSWUZSWUZwR3ZlNy93MVJp?=
 =?utf-8?B?dGxWWTRMUDc3SHhLTDJNeGJsd1puN0k0ZjkzaU5FUE5lUURCWjVoWW1lU3kr?=
 =?utf-8?B?dlVqUU9mSkxJMFlxQWZxRzZqbU5GMTlUVmFzck4xWXFxTnVGQUFQN1Rob3Vn?=
 =?utf-8?B?NTVRRFJlSnlkSFIrL2FUK3FSUENkeWsxM3o2RG5mTVp1MHNNZ1BYUGZPNW9j?=
 =?utf-8?B?OE1IU082RUFsOGtBaUJPOENoeW1ZM3ZwUEtDUTk2VzZXSFY4QkJkOURUUS9s?=
 =?utf-8?B?RlcxQ2dtTEM5ellMNWEzY3E0ZU40dExoalRWOHkrVUFOUDBqeC9zMURPYWc0?=
 =?utf-8?B?eTFzSkhDZkRzaVVXSHRqa1E5T1RkU1FpdE0rRkl0QzE5MGdoOWNUNDFFREJk?=
 =?utf-8?B?UDFTYm93UkcrUTBOaFB3R1J3M01tTHA2SmdPRDkzd1d4NVM0NEJCOUNoUllk?=
 =?utf-8?B?a3JZQTRldXpRaWRjanFIZzRtWmJReDVJK00weG5STm1BQnZ3ZlhHTGNwWFBR?=
 =?utf-8?B?TEl5TmNjcU9RYm8xT0pOTkJpQTVIRDBkVzhhTlpMbEd4UWw1MTdyNEo2UlpM?=
 =?utf-8?B?OXBpS1pGYWttN3hpZTlHTGh5bHNBTUMxSGJNaTlaa3VVRkF3bUdzbUhsVUdB?=
 =?utf-8?B?TEowNzFVc3c4VjVVbHhZRlhUbUlucWxRTHdScFhXSVhiS1N5QlFHclFoVmFJ?=
 =?utf-8?B?T0NPNVlDYSt6ODFiM3RPZjAxeS9MbXJRcVJZUkNrcEZqZ3pVSEN1cjlZd2o0?=
 =?utf-8?B?WlpxeHpnS2dsUkRsbFNma3UrK21ndERST3FnUGcvckhvSnNnZUlMQXArNHV2?=
 =?utf-8?B?ZkxBcGNXR3BaaS9pLzUzUXZrMTRLVFNHdVp5bnF1T3hUelh6aUdueXZ4R0Jo?=
 =?utf-8?B?ZkFVem00QkZESXZZMDhLMk5pVVl3UUdscUthUkc4N0RwdzRaUUV1d3VaMENy?=
 =?utf-8?B?ZEVUQ3pHb3Y2Y21QN3J0azBkSTZZNmJiMm1LU2V6NXB6MVVmVEJlU3JNZTFi?=
 =?utf-8?B?SWJ2MlFHRGF3bWkyemNpYXRrV2FxWm9Ua0V5SnBxT3d4UGtqekVLSkxHanVR?=
 =?utf-8?B?LzlKMjh3YUVidERuYTI2OE0xSnVEZ2JUeW1DaGhmTWtYT3ByMU92cmtMM0VH?=
 =?utf-8?B?eFpRelNZU3dIaldtUDRQdVV6V0xpblBuS2dRQndUUzB4T0hqU2N4VGhFQTRu?=
 =?utf-8?B?LzIxQ3dFYitYcDExODA2QVpmT292QTB4RC8wOTFac1ZieWh5Mm8yVWFEbTZk?=
 =?utf-8?B?MDV2T1RzZE1ESEV0RGV5N2RZNG1PK2ozbG5wbVFuZ1crVWRId3JVdVlTOUhL?=
 =?utf-8?B?NnRKT1pad0hpRUFBeWpycHdYRytGSTU4d0p2YVdzYUF5ZEk0WnJ5WTAwaGZ2?=
 =?utf-8?B?UmkydlAwYjNpU2c1K0RYRHVDTnQ5Wm1yVXI0V3ZxMkpYNmF1eXU1ekF2OHg2?=
 =?utf-8?B?bHFvOHNOZUt4VVhsMWZHSmRrR0pIRzMvSGZYT3JRdFZqMC9rdE1jKytnNGE5?=
 =?utf-8?B?RlRwMjJwdTZTNzJIS3lqYVhvcEFES1B0SFFRczhoZVFsSzFGU3ZDUDlSUXNl?=
 =?utf-8?Q?N827v4xvGKOgwGBqasEKQxpqY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3b974b-1b36-4110-ea5d-08da6e48ce21
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:20:20.2625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6eSUYr8AkeYh+7oFl0xh22VIhCXxJNZU0QMJRadK+MczlH6B4R+2caufYhoRtFg38hDff4JSwNf5UUNjk5CNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-07-25 um 06:32 schrieb Lang Yu:
> We have memory leak issue in current implenmention, i.e.,
> the allocated struct kgd_mem memory is not handled properly.
>
> The idea is always creating a buffer object when importing
> a gfx BO based dmabuf.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
>   1 file changed, 70 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b3806ebe5ef7..c1855b72a3f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>   	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>   	u64 size = amdgpu_bo_size(bo);
>   
> -	unreserve_mem_limit(adev, size, alloc_flags);
> +	if (!bo->kfd_bo->is_imported)
> +		unreserve_mem_limit(adev, size, alloc_flags);
>   
>   	kfree(bo->kfd_bo);
>   }
> @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>   	}
>   }
>   
> +static struct drm_gem_object*
> +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
> +{
> +	struct drm_gem_object *gobj;
> +	struct amdgpu_bo *abo;
> +
> +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {

I'd rather remove this limitation. We should be able to use any DMABuf 
with KFD. This check was added when we basically sidestepped all the 
dmabuf attachment code and just extracted the amdgpu_bo ourselves. I 
don't think we want to keep doing that.

Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf 
import" sent to amd-gfx on March 16. I'm about to send an updated 
version of this as part of upstream RDMA support soon.

Regards,
   Felix


> +		gobj = dma_buf->priv;
> +		abo = gem_to_amdgpu_bo(gobj);
> +		if (gobj->dev == dev && abo->kfd_bo) {
> +			drm_gem_object_get(gobj);
> +			return gobj;
> +		}
> +	}
> +
> +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
> +}
> +
>   static int
>   kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		      struct amdgpu_bo **bo)
> @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   		}
>   	}
>   
> -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
>   	if (IS_ERR(gobj))
>   		return PTR_ERR(gobj);
>   
> @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   {
>   	struct amdkfd_process_info *process_info = mem->process_info;
>   	unsigned long bo_size = mem->bo->tbo.base.size;
> +	bool is_imported = false;
> +	struct drm_gem_object *imported_gobj;
>   	struct kfd_mem_attachment *entry, *tmp;
>   	struct bo_vm_reservation_context ctx;
>   	struct ttm_validate_buffer *bo_list_entry;
>   	unsigned int mapped_to_gpu_memory;
>   	int ret;
> -	bool is_imported = false;
>   
>   	mutex_lock(&mem->lock);
>   
> @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	}
>   
>   	/* Free the BO*/
> -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> +	if (!is_imported) {
> +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
> +	} else {
> +		imported_gobj = mem->dmabuf->priv;
> +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> +	}
> +
>   	if (mem->dmabuf)
>   		dma_buf_put(mem->dmabuf);
>   	mutex_destroy(&mem->lock);
> @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>   				      uint64_t *mmap_offset)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
> -	struct drm_gem_object *obj;
> -	struct amdgpu_bo *bo;
> +	struct drm_gem_object *imported_gobj, *gobj;
> +	struct amdgpu_bo *imported_bo, *bo;
>   	int ret;
>   
> -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> -		/* Can't handle non-graphics buffers */
> +	/*
> +	 * Can't handle non-graphics buffers and
> +	 * buffers from other devices
> +	 */
> +	imported_gobj = dma_buf->priv;
> +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
> +	    drm_to_adev(imported_gobj->dev) != adev)
>   		return -EINVAL;
>   
> -	obj = dma_buf->priv;
> -	if (drm_to_adev(obj->dev) != adev)
> -		/* Can't handle buffers from other devices */
> +	/* Only VRAM and GTT BOs are supported */
> +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
> +	if (!(imported_bo->preferred_domains &
> +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
>   		return -EINVAL;
>   
> -	bo = gem_to_amdgpu_bo(obj);
> -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
> -				    AMDGPU_GEM_DOMAIN_GTT)))
> -		/* Only VRAM and GTT BOs are supported */
> -		return -EINVAL;
> +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
> +	if (ret)
> +		return ret;
>   
> -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> -	if (!*mem)
> -		return -ENOMEM;
> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
> +	if (IS_ERR(gobj)) {
> +		ret = PTR_ERR(gobj);
> +		goto err_import;
> +	}
>   
> -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
> -	if (ret) {
> -		kfree(mem);
> -		return ret;
> +	bo = gem_to_amdgpu_bo(gobj);
> +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> +
> +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> +	if (!*mem) {
> +		ret = -ENOMEM;
> +		goto err_alloc_mem;
>   	}
>   
>   	if (size)
> -		*size = amdgpu_bo_size(bo);
> +		*size = amdgpu_bo_size(imported_bo);
>   
>   	if (mmap_offset)
> -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
> +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
>   
>   	INIT_LIST_HEAD(&(*mem)->attachments);
>   	mutex_init(&(*mem)->lock);
>   
>   	(*mem)->alloc_flags =
> -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>   		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
>   		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
>   		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>   
> -	drm_gem_object_get(&bo->tbo.base);
> +	get_dma_buf(dma_buf);
> +	(*mem)->dmabuf = dma_buf;
>   	(*mem)->bo = bo;
>   	(*mem)->va = va;
> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
>   	(*mem)->mapped_to_gpu_memory = 0;
>   	(*mem)->process_info = avm->process_info;
>   	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>   	amdgpu_sync_create(&(*mem)->sync);
>   	(*mem)->is_imported = true;
> +	bo->kfd_bo = *mem;
>   
>   	return 0;
> +err_import:
> +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
> +err_alloc_mem:
> +	drm_gem_object_put(gobj);
> +	return ret;
>   }
>   
>   /* Evict a userptr BO by stopping the queues if necessary
