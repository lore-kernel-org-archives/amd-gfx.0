Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC241F9B605
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E27010E99A;
	Wed, 22 Apr 2026 10:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMvR1kWL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCABB10E99A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJXoiAg2W+yZi8sHBxqwbd5oOBNmlJvWoddqy2rZetyOc5UwyRsmnDICCFiUNlnaEZxMH+DPOpud/TxtLSr5wezWtFevKfsmkgCADG8a3yI3cQwhdFAFsC6yG81KpJYwoyTFpuo7UW3Fgfr2H5WMT+w8rh/XZFXGBx7dq91IB1Zk0azACjRmRpuBdhRoGRQGo89w6zLVMYLQNRnv77A+F29ZbSsVDQtDjD3t6Rjr254Lcc/awAVFTwODfJSEzZQ2YBocRqVBhlmFqq1QnQZp7xx8fkQDT0PvEj9BR2WihpjI+FT8z2LqwVA/DBjh5A4Poe0cJtNK+cHk4vfpvdmoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX5NoYyQ61hdRWwz6pk8n1UQPv2jBBTeO+wCqe9N5f0=;
 b=EY0ucckPuZsgtfj0fioKF73iQxuahCGK6eS9GEN/G+KE+SXQP2sEgmohozqfX2qkTsWD8eNwlZamU1F5/P7SasiPLvCFh9brxsbmW+Tb0huPjAUfSYDZ4/bQmqz3opEvmi9TrWdXflvz7cXK6mxqLoeg1Hnc9LAsbHIBjoyFb9KHfSr1slOxwKzPrWCPEc4XOBdm58xVEnku0LAIRNwv/xUOrGYO5kAnyVsMo940X8bpzmuHhXUVhLngoSmHvk+to3KeMezBzttkrUmZZfRDqxgdk0tJvVW2pQt1SzcKpoLByauwqgGrCk5ABFG0Ui+vypCN0T7rsWbHv3fYUk1Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX5NoYyQ61hdRWwz6pk8n1UQPv2jBBTeO+wCqe9N5f0=;
 b=TMvR1kWLW0m/raQ0kRPdeXK5501ulzSzsLS5Vyd42J7xqFQeVST8AbW02yen4rppoBjxSgDmA76Fff3sjNHRppEZDWGiWm2oZVGkcFG6x/X8FaEpYQ0N3koI00mRYuBEzeWIkqokzKAzp/N8w3sKB4fJtkbr4buXAfB41xn3yxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 10:08:17 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 10:08:17 +0000
Message-ID: <8fe38911-e8c0-40da-be4e-4d14983678a0@amd.com>
Date: Wed, 22 Apr 2026 15:38:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu: rework amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-4-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: d644bfe4-771a-4476-c7ea-08dea05712b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: OAzOJSAbPdJogW8S1bRI1WUD1wJqG4Pna3GqUZRP4/oVfBCupS/WIlt83G1sUeD6b9y91v7xINX9FV7aU9z5dal7J1iDTeA8BdqY7ba42CNPA7Q75IgcbS8sR2oy+yWY8Ipqz0+KPm40W+AP4xnRS7XTU9JnAuhUAR+58aeDzdevPN06aIrBhMY47N+x2oyEBX7zzXlo3rTQ3SmMD/RF3JJPYB7czW8MT+KMw0v8t8+PBSCqs3QFH6nGN/YF7d3he6saCi+KdYH1HJEBt8aC8eF8y5RiIHcns+qHFFqwgHs+e2gliQsnt4xdG21g+uOMUzbsZeK/bFoJ96Gb5CX9ndjRDQJxlFIbm/MlgFqio6c5lWC719cNVwb6xK0ZwUqqJeocJtwuZI4UZa3eKYbjxLZDtTFTnjgiwHBEIjKZ081eaF0/F37PbaLTD3m2jNxMFcnyKFn8SQ0A6q0LIijy3FRzpnNBQlTXD4CbcMBuIjQeDud9s+4Rr+T7rM1y1ZlET69yFB+GHpbtIRy0i2RkH19vo4H2HIq1f5uLito4Kl3UHt1G9U5hmJzKu+PV8BuSXtv/eOpT0YxifYpySPLYSEO7zpr+mH9j33GimW1I9u+aeo5+hwYl7Ot0NCzvNynFv8Zb74c+sM8cgliXmkQ/fPh1rFiSZyO2333kAfZU69Md5+5g7K4UZJrUVLOekjhYAA0hBU/fA5S+pIr3sFcT6eGRIBVd+gtz/WV2Nfo4KCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Z4Y2lhWW1FVWJhTjZkank4dStrQk0vb3lQU05HOFI5MXBVRmdsanFmWGZC?=
 =?utf-8?B?MWo3K0lvS0VsMkdNVlRpU01ZMW4yMHZpVzViV2xrbjMwS0VDZzlaWW1HWThJ?=
 =?utf-8?B?Wk1WamhFeElZVmtaR1l0S1FBdWJab3E5a2JDb2ttZk1zR1E5Y2J5SjZCV25V?=
 =?utf-8?B?YU5Ub2U5Q3lmdjlQOXU1MnZQK3E0djl0RHVNbmYvY2t2TEttTzEwMTd1ODhR?=
 =?utf-8?B?Yy9KOUtFVTZXUnJoRFJ6VGNUcERNT01lMW5DOVRPU29BWUlLVVFQYVdGekIv?=
 =?utf-8?B?OU1NbmpVL3dDb01KaU5PNGhnd2l6MGdqL0p3VWwxSlZBSGZZWFRUQzZoS0Ir?=
 =?utf-8?B?SE1TNWJYbFo1UDZVaFd0eG5YeXp4MEpUY0NYMTdUTzV3cHU5QXB0SVU0Vi9L?=
 =?utf-8?B?RE9VM3Y1RUpGVnhicEwxMThzdTE5OUIxbGZ6WnU0a1BaR2FhZ1QvWTgvcDB3?=
 =?utf-8?B?VmhYQmVja3FINHowb3E3TzZ4Tk5ZMGhZT2RJNWpHNHJrWFAwN0tLZEE0cjVF?=
 =?utf-8?B?Qk5oTy94ak1KY0t2ck9QeWNkRlpPZ1NZcDIrZndVVFVjNW5JUkc3WWZRMlI4?=
 =?utf-8?B?WjU2ekJKM0kzaklIZmZSWkFra2VVR2cxM25MY3VlNWp0NjBWMGdyWUlDdS9R?=
 =?utf-8?B?dHA5cWp1OTZWUE1qeGtQcjNUZDNGRGpOUkNuaUtMbFhJUEFqcVlNNDdGNmtx?=
 =?utf-8?B?elBZdHdLOWlkRDdBRjhhcTJiMFpBWG1ybGJCUnArSVJsalhhOC9RejNXTkl4?=
 =?utf-8?B?azNsOXhLS1dQMThzSlNPR2I3VVBuZ2hUK05uRDlpbUNMM2RlZ21RYTNYMTFG?=
 =?utf-8?B?Y000YzBUUWxWWDd5dzk1QVQzN21WODZZZk1YcURPak9XdzMzc1dqNjRnbVR5?=
 =?utf-8?B?bVNQVlNaRnZzV0Q5RGMwVmNLcHc2MDBuSkhFbW9lUTljTngrT0hUNnA2TjF4?=
 =?utf-8?B?UDV1VE5rMTQzNDc2clJDR0R4RmZ5bTFNWGZsS2ZUZFRxYm96OC9hZktNbWhG?=
 =?utf-8?B?bDB4U29JbEM4T3o2Q2trdmduTGVvMzd4UmQ2aHovUmtmN3pLYTZKTVIwRndW?=
 =?utf-8?B?dmFmR0RvQThsZGZCZ21mN2E5aTQvN01VckpYTjRxdG1Ra1dMdjM3b051clBs?=
 =?utf-8?B?UEVJZkF2U0NTWUNWNC9mVVk4akd4SVdDWW51Y2crZE5URkluUzVSQ1NKNmJ4?=
 =?utf-8?B?NnFWUEx6OTB4ZDNodVphKzI1VnNGakJNdlhweHVZNUFaKysrNDJ3N3B3aXVT?=
 =?utf-8?B?ZlhGd25jTWd1Z3VJWVNORjdDUDVQSXF0VFdIY1VCRm9iYTVsK1JrVkNhbVFk?=
 =?utf-8?B?NGhnb0ZVWHRrUXlQVkxZTlZLdVFrWnNvTU90c3ZVOWRmczBSVHBDUzZvcEli?=
 =?utf-8?B?THVMMnNnMDVkRU5sL052TDFZMVpwelFDdnRMZG1Tb3o5S1Q1cWRuNlJXekdJ?=
 =?utf-8?B?UTFqaHlNWnNBNmNZMm4wTHEwQ3owY3F5bHR2UDdveHZKZVN6ZHMyaEpDcDhn?=
 =?utf-8?B?YXBNYkl2KzBYa2NFN0JYRXgxajZzRGdhaGw3RjBmaGRHNTRPcHZVaW5VTzBa?=
 =?utf-8?B?VXVLUjRBdmV5V3NqbmlUcjd6MG11ZklZeWxjTThyZkxhelhENnZrUEdnbDNK?=
 =?utf-8?B?NDA4c1V0YzNlei91T3Q0OFhTdXNrb3cxYkRXcWt0UnZubXNCcHpyU3FpeVJj?=
 =?utf-8?B?QkxFNnh3Z0lRRVdMcHVxK1hxM2FkazNDU2wrWlpNQzFNdEhpSlRXemU2RG9G?=
 =?utf-8?B?aUwyWDFMSm1jbERRTEwwUGpxWHduVmEvdUI5cWYwZVpVZmxTaTFhV0R0TlRz?=
 =?utf-8?B?c3V1Q0JNOXJ0Uk04b0QwZnRSc3V0QXNobjRUd1djTkIwRW81TGFLUzA0Z3hm?=
 =?utf-8?B?Wks3eG15ZWxtUTd4bzhMNTlVT3cxOXRnSHNXTDMvNDJiamFWOVh6WUcxNXV2?=
 =?utf-8?B?cGhBNlk2dTdLZ0NDWmpRYmxsV1p6MElRK3NmSm05eXY2aEZEaXpmdjJvODdu?=
 =?utf-8?B?bXpXTDRYcnl3RVBJMCswUk4zOG9wMmdKYThib1d0cjFoSkR1aUFTSXBrMTR1?=
 =?utf-8?B?RE1RN0hRTVlXbTlEdTJNaU53bXZIbnRaMGo4eWlac2tyVjRJQUNJQnhMajJi?=
 =?utf-8?B?N1NvVzAxRHZKMldFb1MxaW5wQno4NW5YMGpVWDVLSWNJMGdmZmVqZGlvWHN2?=
 =?utf-8?B?T2JBbGpRWXJ6M1VNKzVqdDNIa3Y1VUYxVUdmUDYrb2NzS21WQzZhVGZMdFgy?=
 =?utf-8?B?bGpWbWx6MUNLWW1SRTdJdks1RVNmSHZocDdCWUFEeFlGUkF6dERIWmdTdUh6?=
 =?utf-8?B?dzJLaGFLeGtGRU5PMERiZm1oNVBjUDAzWFl4d25TYWJ1am9JTUVZUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d644bfe4-771a-4476-c7ea-08dea05712b0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:08:17.1217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT31Qk1MhioLOAfJ9J4Wv2mttWCMRXR4p/n5qjWmtv+TmL+mhQhpzogQJhdh6zxRtZ0QqTssbEcA3PlADirm+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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


On 21-04-2026 06:25 pm, Christian König wrote:
> This one was fortunately not looking so bad as the wait ioctl path, but
> there were still a few things which could be fixed/improved:
>
> 1. Allocating with GFP_ATOMIC was quite unecessary, we can do that
>     before taking the userq_lock.
> 2. Use a new mutex as protection for the fence_drv_xa so that we can do
>     memory allocations while holding it.
> 3. Starting the reset timer is unecessary when the fence is already
>     signaled when we create it.
> 4. Cleanup error handling, avoid trying to free the queue when we don't
>     even got one.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  12 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 220 ++++++++----------
>   3 files changed, 111 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b632bc3c952b..174190a77005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -793,6 +793,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   
>   	queue->doorbell_index = index;
> +	mutex_init(&queue->fence_drv_lock);
we do want to destroy the mutex in case queue creation fails ? RIght now 
amdgpu_userq_fence_driver_alloc fails we goto clean_mapping and not 
destroying the mutex which is done in amdgpu_userq_fence_driver_free.
goto needs to be modified i guess to handle it.

Apart from that LGTM. Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 675fe6395ac8..cb92789c1ed1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -66,6 +66,18 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_obj	db_obj;
>   	struct amdgpu_userq_obj fw_obj;
>   	struct amdgpu_userq_obj wptr_obj;
> +
> +	/**
> +	 * @fence_drv_lock: Protecting @fence_drv_xa.
> +	 */
> +	struct mutex		fence_drv_lock;
> +
> +	/**
> +	 * @fence_drv_xa:
> +	 *
> +	 * References to the external fence drivers returned by wait_ioctl.
> +	 * Dropped on the next signaled dma_fence or queue destruction.
> +	 */
>   	struct xarray		fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct dma_fence	*last_fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 909bdccc2a92..b0543fa257ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -121,6 +121,7 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>   	userq->last_fence = NULL;
>   	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>   	xa_destroy(&userq->fence_drv_xa);
> +	mutex_destroy(&userq->fence_drv_lock);
>   	/* Drop the queue's ownership reference to fence_drv explicitly */
>   	amdgpu_userq_fence_driver_put(userq->fence_drv);
>   }
> @@ -216,81 +217,77 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
>   	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
>   }
>   
> -static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
> +static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
> +				    struct amdgpu_userq_fence **pfence)
>   {
> -	*userq_fence = kmalloc(sizeof(**userq_fence), GFP_ATOMIC);
> -	return *userq_fence ? 0 : -ENOMEM;
> +	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
> +	struct amdgpu_userq_fence *userq_fence;
> +	unsigned long count;
> +
> +	userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
> +	if (!userq_fence)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Get the next unused entry, since we fill from the start this can be
> +	 * used as size to allocate the array.
> +	 */
> +	mutex_lock(&userq->fence_drv_lock);
> +	xa_find(&userq->fence_drv_xa, &count, ULONG_MAX, XA_FREE_MARK);
> +
> +	userq_fence->fence_drv_array = kvmalloc_array(count, sizeof(fence_drv),
> +						      GFP_KERNEL);
> +	if (!userq_fence->fence_drv_array) {
> +		mutex_unlock(&userq->fence_drv_lock);
> +		kfree(userq_fence);
> +		return -ENOMEM;
> +	}
> +
> +	userq_fence->fence_drv_array_count = count;
> +	xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
> +		   0, ULONG_MAX, count, XA_PRESENT);
> +	xa_destroy(&userq->fence_drv_xa);
> +
> +	mutex_unlock(&userq->fence_drv_lock);
> +
> +	userq_fence->fence_drv = fence_drv;
> +	amdgpu_userq_fence_driver_get(fence_drv);
> +
> +	*pfence = userq_fence;
> +	return 0;
>   }
>   
> -static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
> -				     struct amdgpu_userq_fence *userq_fence,
> -				     u64 seq, struct dma_fence **f)
> +static void amdgpu_userq_fence_init(struct amdgpu_usermode_queue *userq,
> +				    struct amdgpu_userq_fence *fence,
> +				    u64 seq)
>   {
> -	struct amdgpu_userq_fence_driver *fence_drv;
> -	struct dma_fence *fence;
> +	struct amdgpu_userq_fence_driver *fence_drv = userq->fence_drv;
>   	unsigned long flags;
>   	bool signaled = false;
>   
> -	fence_drv = userq->fence_drv;
> -	if (!fence_drv)
> -		return -EINVAL;
> -
> -	spin_lock_init(&userq_fence->lock);
> -	INIT_LIST_HEAD(&userq_fence->link);
> -	fence = &userq_fence->base;
> -	userq_fence->fence_drv = fence_drv;
> -
> -	dma_fence_init64(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
> +	spin_lock_init(&fence->lock);
> +	dma_fence_init64(&fence->base, &amdgpu_userq_fence_ops, &fence->lock,
>   			 fence_drv->context, seq);
>   
> -	amdgpu_userq_fence_driver_get(fence_drv);
> -	dma_fence_get(fence);
> -
> -	if (!xa_empty(&userq->fence_drv_xa)) {
> -		struct amdgpu_userq_fence_driver *stored_fence_drv;
> -		unsigned long index, count = 0;
> -		int i = 0;
> -
> -		xa_lock(&userq->fence_drv_xa);
> -		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
> -			count++;
> -
> -		userq_fence->fence_drv_array =
> -			kvmalloc_array(count,
> -				       sizeof(struct amdgpu_userq_fence_driver *),
> -				       GFP_ATOMIC);
> -
> -		if (userq_fence->fence_drv_array) {
> -			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
> -				userq_fence->fence_drv_array[i] = stored_fence_drv;
> -				__xa_erase(&userq->fence_drv_xa, index);
> -				i++;
> -			}
> -		}
> -
> -		userq_fence->fence_drv_array_count = i;
> -		xa_unlock(&userq->fence_drv_xa);
> -	} else {
> -		userq_fence->fence_drv_array = NULL;
> -		userq_fence->fence_drv_array_count = 0;
> -	}
> +	/* Make sure the fence is visible to the hang detect worker */
> +	dma_fence_put(userq->last_fence);
> +	userq->last_fence = dma_fence_get(&fence->base);
>   
> -	/* Check if hardware has already processed the job */
> +	/* Check if hardware has already processed the fence */
>   	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled(fence)) {
> -		list_add_tail(&userq_fence->link, &fence_drv->fences);
> +	if (!dma_fence_is_signaled(&fence->base)) {
> +		dma_fence_get(&fence->base);
> +		list_add_tail(&fence->link, &fence_drv->fences);
>   	} else {
> +		INIT_LIST_HEAD(&fence->link);
>   		signaled = true;
> -		dma_fence_put(fence);
>   	}
>   	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>   
>   	if (signaled)
> -		amdgpu_userq_fence_put_fence_drv_refs(userq_fence);
> -
> -	*f = fence;
> -
> -	return 0;
> +		amdgpu_userq_fence_put_fence_drv_refs(fence);
> +	else
> +		amdgpu_userq_start_hang_detect_work(userq);
>   }
>   
>   static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
> @@ -392,11 +389,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
> -{
> -	dma_fence_put(fence);
> -}
> -
>   static void
>   amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>   				    int error)
> @@ -440,13 +432,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +
>   	struct drm_gem_object **gobj_write, **gobj_read;
>   	u32 *syncobj_handles, num_syncobj_handles;
> -	struct amdgpu_userq_fence *userq_fence;
> -	struct amdgpu_usermode_queue *queue = NULL;
> -	struct drm_syncobj **syncobj = NULL;
> -	struct dma_fence *fence;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_fence *fence;
> +	struct drm_syncobj **syncobj;
>   	struct drm_exec exec;
> +	void __user *ptr;
>   	int r, i, entry;
>   	u64 wptr;
>   
> @@ -458,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		return -EINVAL;
>   
>   	num_syncobj_handles = args->num_syncobj_handles;
> -	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
> -					    num_syncobj_handles, sizeof(u32));
> +	ptr = u64_to_user_ptr(args->syncobj_handles);
> +	syncobj_handles = memdup_array_user(ptr, num_syncobj_handles,
> +					    sizeof(u32));
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
> -	/* Array of pointers to the looked up syncobjs */
> -	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
> +	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
> +				GFP_KERNEL);
>   	if (!syncobj) {
>   		r = -ENOMEM;
>   		goto free_syncobj_handles;
> @@ -478,21 +472,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		}
>   	}
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(args->bo_read_handles),
> -				   num_read_bo_handles,
> -				   &gobj_read);
> +	ptr = u64_to_user_ptr(args->bo_read_handles);
> +	r = drm_gem_objects_lookup(filp, ptr, num_read_bo_handles, &gobj_read);
>   	if (r)
>   		goto free_syncobj;
>   
> -	r = drm_gem_objects_lookup(filp,
> -				   u64_to_user_ptr(args->bo_write_handles),
> -				   num_write_bo_handles,
> +	ptr = u64_to_user_ptr(args->bo_write_handles);
> +	r = drm_gem_objects_lookup(filp, ptr, num_write_bo_handles,
>   				   &gobj_write);
>   	if (r)
>   		goto put_gobj_read;
>   
> -	/* Retrieve the user queue */
>   	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>   	if (!queue) {
>   		r = -ENOENT;
> @@ -501,73 +491,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	r = amdgpu_userq_fence_read_wptr(adev, queue, &wptr);
>   	if (r)
> -		goto put_gobj_write;
> +		goto put_queue;
>   
> -	r = amdgpu_userq_fence_alloc(&userq_fence);
> +	r = amdgpu_userq_fence_alloc(queue, &fence);
>   	if (r)
> -		goto put_gobj_write;
> +		goto put_queue;
>   
>   	/* We are here means UQ is active, make sure the eviction fence is valid */
>   	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>   
> -	/* Create a new fence */
> -	r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
> -	if (r) {
> -		mutex_unlock(&userq_mgr->userq_mutex);
> -		kfree(userq_fence);
> -		goto put_gobj_write;
> -	}
> +	/* Create the new fence */
> +	amdgpu_userq_fence_init(queue, fence, wptr);
>   
> -	dma_fence_put(queue->last_fence);
> -	queue->last_fence = dma_fence_get(fence);
> -	amdgpu_userq_start_hang_detect_work(queue);
>   	mutex_unlock(&userq_mgr->userq_mutex);
>   
> +	/*
> +	 * This needs to come after the fence is created since
> +	 * amdgpu_userq_ensure_ev_fence() can't be called while holding the resv
> +	 * locks.
> +	 */
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>   		      (num_read_bo_handles + num_write_bo_handles));
>   
> -	/* Lock all BOs with retry handling */
>   	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_read,
> +					   num_read_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			amdgpu_userq_fence_cleanup(fence);
> +		if (r)
>   			goto exec_fini;
> -		}
>   
> -		r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
> +		r = drm_exec_prepare_array(&exec, gobj_write,
> +					   num_write_bo_handles, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (r) {
> -			amdgpu_userq_fence_cleanup(fence);
> +		if (r)
>   			goto exec_fini;
> -		}
>   	}
>   
> -	for (i = 0; i < num_read_bo_handles; i++) {
> -		if (!gobj_read || !gobj_read[i]->resv)
> -			continue;
> -
> -		dma_resv_add_fence(gobj_read[i]->resv, fence,
> +	/* And publish the new fence in the BOs and syncobj */
> +	for (i = 0; i < num_read_bo_handles; i++)
> +		dma_resv_add_fence(gobj_read[i]->resv, &fence->base,
>   				   DMA_RESV_USAGE_READ);
> -	}
>   
> -	for (i = 0; i < num_write_bo_handles; i++) {
> -		if (!gobj_write || !gobj_write[i]->resv)
> -			continue;
> -
> -		dma_resv_add_fence(gobj_write[i]->resv, fence,
> +	for (i = 0; i < num_write_bo_handles; i++)
> +		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>   				   DMA_RESV_USAGE_WRITE);
> -	}
>   
> -	/* Add the created fence to syncobj/BO's */
>   	for (i = 0; i < num_syncobj_handles; i++)
> -		drm_syncobj_replace_fence(syncobj[i], fence);
> +		drm_syncobj_replace_fence(syncobj[i], &fence->base);
>   
> +exec_fini:
>   	/* drop the reference acquired in fence creation function */
> -	dma_fence_put(fence);
> +	dma_fence_put(&fence->base);
>   
> -exec_fini:
>   	drm_exec_fini(&exec);
> +put_queue:
> +	amdgpu_userq_put(queue);
>   put_gobj_write:
>   	for (i = 0; i < num_write_bo_handles; i++)
>   		drm_gem_object_put(gobj_write[i]);
> @@ -578,15 +556,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	kvfree(gobj_read);
>   free_syncobj:
>   	while (entry-- > 0)
> -		if (syncobj[entry])
> -			drm_syncobj_put(syncobj[entry]);
> +		drm_syncobj_put(syncobj[entry]);
>   	kfree(syncobj);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   
> -	if (queue)
> -		amdgpu_userq_put(queue);
> -
>   	return r;
>   }
>   
> @@ -874,8 +848,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   		 * Otherwise, we would gather those references until we don't
>   		 * have any more space left and crash.
>   		 */
> +		mutex_lock(&waitq->fence_drv_lock);
>   		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>   			     xa_limit_32b, GFP_KERNEL);
> +		mutex_unlock(&waitq->fence_drv_lock);
>   		if (r) {
>   			amdgpu_userq_fence_driver_put(fence_drv);
>   			goto put_waitq;
