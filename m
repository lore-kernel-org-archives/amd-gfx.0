Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28F0FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 09:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F7A10E2A3;
	Tue, 28 Apr 2026 09:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yf7e/L8x";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E0010E2A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDQq+gD8WdtNfmLG2UDohNajwhw0cU3ORNIkspagVfkqRtTSWWA+txb65Etgz7uzHxTEv0CiKYknwIWcrI6wcjSglgaB2k3dBc5ofPBlvtdjUYMTCecHxTyq3HWQsr9+7pKyEce2AnXeS7J8OhvHIfM/SMzfJ/W18BZUF50NVnA4+S8MjX+hFVP1N2HLFMc8EqDUXHxGrgTcrfZhzac+/hV0jnao5LTaUNevjsq+rdgY/JdbCXwzcQMCUwDOdalY35bmr+TXgNevYnaX4p2BLi9azx2kxM2O/gvmnMGx2Kvp9vXOcs7qMzqbMXBYEu7NKyoDT1A5pEXjApwUH77pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LZQ0SltZRggNGRezJRnoCJhBlnmDi+IgxpSdvdPxgE=;
 b=YvIDuqK6ufzScSaRWrUlvPDL4rwFG0lLQIhI5RnwknqW1rrhr2vq2vPV2KCfstilafGbDd2kKsKRuj+m+xrsXRgdnkUARRPOqi5hEgEIV3MSCFx2e5NX3FS1UMh4OMimaWgmxAdKzr8uSP7J/d7NnZaq1kMH9JEx3ggEJypIkDaSRJzmvffdtTmDn/S+FlnVov4YZn+oFxJCEEfSuoBghmveSSY18ivURnFjWYI5xBYG+Cp60GH1miZNecqy7VavUt6DahqvHMO3ca0JwmyAlf8naT2Hfua/TVSgJ9c/dA8ypbLMCyWPhAWQVpa2fqt9AbndO5nCpdMfvLHttvuFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LZQ0SltZRggNGRezJRnoCJhBlnmDi+IgxpSdvdPxgE=;
 b=yf7e/L8x+6d+hqaRQQjGKKF5P0R+ZWdjD0X78iiS3QXmBiCk5b3efR8lmYr22FvC5WmSCDdOClwTAL86OjlgaIqib+0bpCgFyibs4E0BGoPUtfhmmlp7UkaRxeNbBaeW4R0MBj0mDHcw+5KwHvoQdtvIz6Va15nqVo6HruPyuFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 09:35:50 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 09:35:49 +0000
Message-ID: <5e0a9edc-2225-4e02-a587-3f64d2b67e0a@amd.com>
Date: Tue, 28 Apr 2026 15:05:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: rework amdgpu_userq_signal_ioctl v2
To: christian.koenig@amd.com, alexander.deucher@amd.com, Prike.Liang@amd.com, 
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260427182723.1715-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 841f0284-a281-47f8-5fcc-08dea509884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: MhZsndwOtFNFIebg9/0/Cfniu3tAWmzj9+lOlZ3qTxT9UVQNfQ6CB28u6Qr60yerxNZL9nDVQvKSqO+OtKWAJFQNuAFntWRU6ZLr9gH/JObolY/15+dMurVQAUEMl3ofZ/3+Dv5/689vZjLKhOwLMe+554CmghRMn+fMnNVpW0WN+Lrrd7/amn2Y2wMciJ4afBU+rf2GR3nA8RluB0gcZ5cWVdY3m9KG4/a50FH9C02N+0WkFKWRrd2ZVlg/2WP3NKawZll4ReiG0qtJBWQfNUXTltfjIWwdoNfFN2Ruf2U6ZZ93N20OiY489LqW6GSV5RxlSvmbTwsiMfIEBuS88xVJ9xINu0zXpyxcnisZvJF09rseovCB5j/kbuE1P4sG54dR6RnuEMozbJYr0zLFyZDNqSoc13PFdLBiwdSt2+cXLNNQpsGTeifw0nEyQZVLDGzwJRGgpNRZB4PCtlzcyYCmOzV5XLOJ4t8v14wCyPNQvCoJK0C3l4QOxggnIr61c+UmBQTHgvD5GALGmuvEOii/OpYrikbkJ44a7JMzdkn2hBPP25x0Q/WDlzGV/ufCpsJIAuTkQ0m+zkjGeiMcPeDAJq0D15UWjNWogh+QZzbgwhaCp4yvRg0NwAgK5QlacHED9TCsU9oROwR5Y8PveSoUg0Syu/OMq59MSUXt2+znl/ejIm1pGWW6s/TYPyRWP6Ilz1TBraUZYa8alj0pY0eCjWYRXHVpvMHJfgqRLew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTl1ZTJTOW9DSTRUUVJ0WDBMRGVjTEVFTEtrQjZPN3RzYW4xSGtubXg0Vlc5?=
 =?utf-8?B?ZVVxc0FkelN2RGp6MytTQ1NucWptbHltOFdHQXdET1JpbGVtbEVBTjRuVTE0?=
 =?utf-8?B?UmM1LzRKTXp4VExJRDhDUWVHMFcrK0dwTTBDRktBOTFCNHZHd0pTNFEzeWk1?=
 =?utf-8?B?QVlXWDcxVjNPbklBVjFjOEpqYXJBd3lKVDN6N0FDUXdpeHQwaUxvQnBNKzB3?=
 =?utf-8?B?akt3bVlhM3NFR1ZDeSt1L3RZZS93RXdGZkpvSjN0YUdzRDVPY09CZE9UeFNz?=
 =?utf-8?B?UUJtRXhHdXU2SmpUL1B6OEhMSysrOGVTMDJOSEpRcWNBaEh2N2trdXRUN1V6?=
 =?utf-8?B?SUwzRmxGY2JqRzRiaUJNZ2YyNXVQaHhZbnBod2NIM3V2WTB5MnRiYWRyUFBO?=
 =?utf-8?B?UGpROENQaHlNbDA2SVZUY2lYUHhPVHg0N3ZCci9FSFZMTU5lRDBTYnQweTdr?=
 =?utf-8?B?UjVZVDQrbysrTWgxZ3JIRmdrV1NqNDZLN3hHNk03bnpmNWVFbVJQOUs0dkhI?=
 =?utf-8?B?SzNQS2FIUVQ3WTlhOHNiMXB6SlJWKzd1MHArdDV0bGxWOHozaGFxakYzWGVS?=
 =?utf-8?B?aldqN0Q5RndRTGVPdW5sVjlKOGs4OFU2SUtJMTkyL0E1OFIwU29reGZ0bDlx?=
 =?utf-8?B?RFpVL0RBSUd5dlJQZjZ5QVFXSDdUMnhmOHV6R1FvMlJ3MlN0S2JzRmxiWTlj?=
 =?utf-8?B?a0JQaFpZSnlhUWdtT0lzYndPMVVsNmw1M2lhVjhPeDU4L2Q1bVBDM3liRmFF?=
 =?utf-8?B?VStSZDBCRWVSVG90blFwaW5WL0kxcDdaV1NlODdDTjhSbGptRnAzRGZVVEUw?=
 =?utf-8?B?WDg2MGVyNElZSi9VNVREVnExWkxpcXpVVC9KOVNRUXVOTjFIeG1DVnF2QlNK?=
 =?utf-8?B?WTkvQlB6MERGN2ZYMjZBWXFyL1hCSDVLYytKQ0dDUW1YcFBWL2pOVjVYU3M1?=
 =?utf-8?B?TmtSZ1EyT05ub3lDa1RUdnlpTkR6bytYTTlxVzdjKzhNWE4rSmNpVnFPdGwy?=
 =?utf-8?B?cjcyMFY1Tk9pMmkwZFNMc0tJL3hvTGgxeFA0U2RHMjZuczQ3bmVobitTNWcv?=
 =?utf-8?B?Z01aZmdDOVlsYSt5TFc2T1V1QWFHYklKMUdpSWd0eWlZZFY5MHZhODEyblNZ?=
 =?utf-8?B?NEVxZU8zVjhrOXhjSEozSUhVQnB4dDhyOStCY0c1M0h3c3dQUnpKbDg0OXFW?=
 =?utf-8?B?a0g4eGJUc2xlSHZGWnJkci9xdEVBK0dlU3lsZVBUYTZDSDJIVFRUdnZLREhm?=
 =?utf-8?B?SkFTcjNXb1A3MjBXcHZmTFVPekZUUkoySnNkbzlOdUpSTnNTalh5Smg2TkQz?=
 =?utf-8?B?czZMNkRZemdYUGhscmJxZ2tkZEI5TFpRSXZqNTFSNFhxcWlZbFFOaHRCRHBU?=
 =?utf-8?B?MmtDcWJaMHBJNWdSZ0JITTk0ZWhtUU9JZ2hYeTV2am5xZ1YyeS9Hbk9iVEd4?=
 =?utf-8?B?Sy9haG53L1RhMkx4OGp4UExvMVRNZ3JtaC9sNUxNZW51UlVMcE4zaGlRcVBY?=
 =?utf-8?B?TlorSEtGSWg5Vm83a3V3ZHlaSDNsTlZvNWZuOVZwaFVLdnF1a0VyRVpzZTNS?=
 =?utf-8?B?Z01xakpidWIvd1F4UXl1UkFhciswcEgrSEFMMXc0T0lwcXlqK01vSjExVlZz?=
 =?utf-8?B?WVhGYUZ5ZVJpYytMQVRCNDhFNUtiVkpWRzdkZEFYNzJuaTJWM0VTanNFRFRK?=
 =?utf-8?B?QWVuQURLQUdXU2dSOC92Uk0wY2tLOEh3YXY4VHp0ODhJMG04Q1prNS8zWVpL?=
 =?utf-8?B?ZUpPYWt3U3FBM3Z3elU1eFhLaldHYzN3Y2MrVFpJcGJIWGJxL1JzVjh2ZVYv?=
 =?utf-8?B?aVJYSXNuemloY2JWbjQzWXdSbjRtNVQrcGRUM3kxUmpLUzFVN01jV0hrL0Ew?=
 =?utf-8?B?OTgzb2VBOXFEeTdPMENad3lwblAveTU0eDNxOVV5dGhteU9rUkdpNnY5Tzlt?=
 =?utf-8?B?eHhhdTRxNHRISTRMME1JYUR6UDZMMkFtL1hJWjdhak40emgxTnkzSndOSCtL?=
 =?utf-8?B?VGF6TUdaQklpQVgzVWdRQUV0ekZNSi9pSHlja0dtWWlIMm4rdHhDV3JvWUhB?=
 =?utf-8?B?QnpHYVBjdUZWWGpjQmNJSGJqcnNrOENMT2xNRmJFYlkvZjlwck4veG9HK1ZU?=
 =?utf-8?B?WE11djRCNkNLdGRtTmhWRWNUMW1OVGVGVUJPQUFXeWcyQWZWdTR0YmdUcE0x?=
 =?utf-8?B?NVFWbEQxZnBZeGFPb0RaV2d4YmVYaWc1M3ZQSzZuRGczQ3dBdUF6OXZZVVBK?=
 =?utf-8?B?aWxuVUtwMndoalZsNWZFQVQwNFd3ZnJPRlZjY2Jaa3d1dVkvOFlicTlGSEls?=
 =?utf-8?B?NGVTQmhYN0M4MzRKZXJmS1ZCVXB6M2M1RXFhR0t4M3Y4WmwzQnJkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f0284-a281-47f8-5fcc-08dea509884c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:35:49.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vDM4fdH170YcPpTj75fV/iLMcZhSArJJyw/jIZOwyaKYyGuUw7RvQAFsS98TIU/UoPzbLxBFt2uPe/NpJeDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
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


On 27-04-2026 11:57 pm, Christian König wrote:
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
> v2: fix incorrect usage of xa_find, destroy the new mutex on error
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  12 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 227 ++++++++----------
>   3 files changed, 119 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index a34b1df513d3..62d155d6e4ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -806,6 +806,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	}
>   
>   	queue->doorbell_index = index;
> +	mutex_init(&queue->fence_drv_lock);
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>   	if (r) {
> @@ -879,6 +880,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>   	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +	mutex_destroy(&queue->fence_drv_lock);
>   free_queue:
>   	kfree(queue);
>   err_pm_runtime:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 8b8f345b60b6..843ea8ecc5d7 100644
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
> index f3d0595e3e61..a2792f05b670 100644
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
> @@ -209,81 +210,84 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
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
> +	void * entry;
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
> +	XA_STATE(xas, &userq->fence_drv_xa, 0);
> +
> +	rcu_read_lock();
> +	do {
> +		entry = xas_find_marked(&xas, ULONG_MAX, XA_FREE_MARK);
> +	} while (xas_retry(&xas, entry));
> +	rcu_read_unlock();
Functionally its correct but Using xa_for_each to count the no of 
entries should suffice for what we need?  why doing more work or this 
approach is fixing something which xa_for_each does not ?
> +
> +	userq_fence->fence_drv_array = kvmalloc_array(xas.xa_index,
> +						      sizeof(fence_drv),
> +						      GFP_KERNEL);
> +	if (!userq_fence->fence_drv_array) {
> +		mutex_unlock(&userq->fence_drv_lock);
> +		kfree(userq_fence);
> +		return -ENOMEM;
> +	}
> +
> +	userq_fence->fence_drv_array_count = xas.xa_index;
> +	xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
> +		   0, ULONG_MAX, xas.xa_index, XA_PRESENT);
same count could be used here also to copy, just open questions but the 
current code is good to go.
Irrespective of the change the code is Reviewed-by: Sunil Khatri 
<sunil.khatri@amd.com>

Regards
Sunil Khatri
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
> -		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> -
> -	*f = fence;
> -
> -	return 0;
> +		amdgpu_userq_fence_put_fence_drv_array(fence);
> +	else
> +		amdgpu_userq_start_hang_detect_work(userq);
>   }
>   
>   static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
> @@ -404,11 +408,6 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
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
> @@ -452,13 +451,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -470,13 +470,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -490,21 +491,17 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -513,73 +510,61 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -590,15 +575,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
> @@ -873,8 +854,10 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>   		 * Otherwise, we would gather those references until we don't
>   		 * have any more space left and crash.
>   		 */
> +		mutex_lock(&waitq->fence_drv_lock);
>   		r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
>   			     xa_limit_32b, GFP_KERNEL);
> +		mutex_unlock(&waitq->fence_drv_lock);
>   		if (r)
>   			goto put_waitq;
>   
