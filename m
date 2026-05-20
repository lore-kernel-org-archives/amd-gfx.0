Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94430CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8AC10E15B;
	Wed, 20 May 2026 08:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u83jMsOT";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD0710E15B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9r8H96sNf4BbKvCrZM7FS6LFmxVLYtFQT5wv3g4ebTT+l+GTO1mL3JnyJdwbJLJRVHVorRNfP1a5tAOVuTOyrsTZtCJB1X4HNWxk0S8dDuXRjMsbHWO1TIxwZB0tbgxQCOCv7FCGeovgj9c7MCq/9bO+/Wj7QmLIDZ6YtM+/OJeX2uLDWVJLYPBUtmMna505atW+dXPnrOFhUCcs8NhlODafZRXPrxWQH12/5SbdXpQ8/+PYNqglM3uTjRTPte7FpjN9JTFuOKnEqCqc5LZdyL/GZ5BOC6zdpLsZTzOKLDFt9IjjJUP7cXYdsUNfbkxN9NFT5X0uJ11ZrDQqi/QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e2lSDhzx50aaU1RkioP8bwSxuAsW9CN2DDIc2wUkvU=;
 b=pz1UFwqYyu5E3yHRiXQMrMUV+a9QcPycp9Gb+SzlkcjSZoeiOwXohPGk7PrsK573RTxAKWOyDaMPwtD9FYkcPX6PEO6dWwXiLW6Qs/5K7t7Q9SDSSzkcVHRqKxNEO+Q1mPRXGrXPhkG5d7nkGs9UAkV1m+O1r9J5ylpaR9/UM4FGp49FQugz2/sAN8AL56QJvyJULgf895TVtJCOlS66E8WfS33ktbZ+b8RU6WJrlBQKS4qjLT/Nx/qvt2lTSKSpuTRQp0+fsgnwy/nORiPySbhPahC7n+ktLlIOyTPGlYEutg/9cBAq3IeHLb+E4aHt4iLAEqf1kUeRwrg0Kwa2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e2lSDhzx50aaU1RkioP8bwSxuAsW9CN2DDIc2wUkvU=;
 b=u83jMsOTtsSm7rbMCDvU8qsK5numZs87EA1UiJMhMQcpCN2ABww5vvp1ZCQSi8F+2VkHG//GzEZ+JicPg8nexgEU6JoaiT90YnzRsZ/X/DQ4zNz11bozOCXpw2BL4v/XKxvXEnMUnOaXn00Gl8W6HSeUbkUfFLrHQj57hBxY59Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 08:39:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:39:48 +0000
Message-ID: <05128708-8a69-489a-b8ee-219725df14c7@amd.com>
Date: Wed, 20 May 2026 10:39:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: guard userq BO unpin calls against zero
 pin_count
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260520015609.127747-1-vitaly.prosyak@amd.com>
 <20260520015609.127747-2-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520015609.127747-2-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b7ff03-f4ad-4d8a-f68f-08deb64b59f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZoIZCVveWCCRLdoONdy0AsjZd5cXnG1xPjV8UOsFKCMD9byKyNXGASVC3GcTSpPYMc+LRw7U5T1hyzBKkOm3vJjZcB12krx0HVamjp4bkZGaVfCE1jMnzi+haj1mnCVxBDlkTme1s86ioQKdvJ+vHFkMaHyW+PoGk49OoFPqGTRQWPoZLI2l0WdeIiSH9lTlOoYuvQcm9gmS9nz15aiHDpt4b1hX/YSjSwqRVy5NCVeNnmyVU7x5BLHT0OUTzFwUlqoUWAdGMWg8hgQ45lNYzEN4HUQxkvhlrAWc7zwG5ZK0URKhSFK2241hU+Z+iEcTka6dz/WdD38WF8AwqpsXzy+0aPYAFICM1P17TrDPnskMD3wmtIuhKv8pYSXIiZ+BFvsJwOFFA8DYYNweKUE284xoarSJgFGshFGQ1kuBJ5i/1ISOEZ5wVfxyNsSiXcnDxZEg11tAjmzLrY+WHBOkNbebxT2cyFL38b5i617naFqOTgHN0Z8F5D62g2YuL0/UZvkMalrJaqcx8DSkUnN2B8xBueXSnknL1jezVn6U+3JjgDOZM+pHV/LVpyz1u0puKxS03qVI8BYVeJE2Em8As95lZdjwiACGb16TmitXWmXDon//ZOVNCg3j66pKu2eDAHlGNuFeV3cQgrl+FqGjo467rSdUs2iHgz+L3jC81D/HY+ihE/rU22DFjCd8YzOK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lzQmRVLzd1ektWMS82VDNsZWZ2bHdtUTN3OHdvbk5YbDJTdldyaG1qWDVu?=
 =?utf-8?B?V0hnZzY2UjN2dVV3U1lVQ0lqbHVJSnhjcDBmN0tZWWNpTldNSWkxRmYwWW9v?=
 =?utf-8?B?aktsMXBKRE1IL2VPbFpENGEyY0R3K3lxODNpdXZsVnhZVzdpaDZORUhzcy9N?=
 =?utf-8?B?Wmw1cll2U3d6REhDdW0wWTVIekhpU0E1d2NmSzhHaDBQdk03STc1bmRCdzgx?=
 =?utf-8?B?a2xFcFpNbmxMbkw5YVFMMU5hcjJJTDdyRmNQVlowaWdHQnJ6RHU1L3grRm96?=
 =?utf-8?B?VUZsTVlUaDBkTkdzeFo4RzM3NHBPb0NtUFJSUGc1UFg4WmV3VVBaaHM3TVNT?=
 =?utf-8?B?MFkvQ09IYzFCSVNJZ0JsOFh2Vzgzc3FyRG5GSnpSaDgyM1FpMHA1dTY1MFEr?=
 =?utf-8?B?akMzVFkyZkw1N2hpbWJCS1pYekN3UzJvT0c2VGh5OExYcUE2Sk41QmYwSUxY?=
 =?utf-8?B?UytsT3h5SW54TjFKNzVReUpIemJHL1JPMDd6bWtyTkgyNlZaZXRvNUM0U0c4?=
 =?utf-8?B?UnBSWXdDaEZXV1dPelNzOXZZZkQxMVc4T3c4cDZjNU55OVppMmMrZ3E2OE1T?=
 =?utf-8?B?YkVXRHMzbGJuYU9Ed0k1ZzRXSWx6TXo5L0pUdlFCZ0krQmJ6SGRTSXRnOThi?=
 =?utf-8?B?NDQ3ZXQ4WGZzam9KenhhM2lUYUc1eGdkWENCWTBtUkM3SFdiaTFsS3ZyTG93?=
 =?utf-8?B?YzFPV0l5dWt0V0l5YWRzSnNIWWFtMjFCdWFQd0l6NVdRbnR0blI4dkNYbkVw?=
 =?utf-8?B?MXF4KzV4Q0plckg4TjFCajBCUFFXWU1FMVJoNlFHdlp4azRGWFkzRWVmQkFq?=
 =?utf-8?B?YnBVZVBEMGtxQmlUdU4xVVBxUVFGZ3NabWJuYWVSTUJycmxiSlBvdnI0YUFQ?=
 =?utf-8?B?d3c2R2Vkb2FvMkg5WDR0N1lXcDVlUHFRUzRrL3VyN0dncXRYOE92MWpGWFZO?=
 =?utf-8?B?cW9oa0hOYnVFUVJ5R1FTb1lEblFvOU1IekppS3M0ZG9qa1IraFY2ejVJMDRz?=
 =?utf-8?B?ZC92cW5WYTNsejdnNU13RFBrbkdUWFNNRVJSQzZXcWtzR1h1YW0vcnNnNmJv?=
 =?utf-8?B?K2JpZHJmUUw0MGt2clFsT1FzdzJWYjFWSVh3aUc4c0JldlVuMDlZRHZxdTRV?=
 =?utf-8?B?V3B2SUl2YXBEOTZhMlpHNEhKNUJqejBEMFpOUjQxdzRBeEN5ZGFTd0ZBZlVJ?=
 =?utf-8?B?TnB6Z0o4Y3RjR0owZThEWTZicGZOTmtnb2NzR2RLVENiaVA4a2hrbHE1cTdt?=
 =?utf-8?B?a2UvYlYvamovcy81Y1ZYanlkaUtuOXlxZHUvelMzbEdRK0ZZOFIwTzZlVWhq?=
 =?utf-8?B?UUN4WTdzd0trTGtyYUk3WVdDT1grOXlSZWdEeFF6QkppQ0QzUm40ZEpxWkhD?=
 =?utf-8?B?QWpKMi8weDltZjltLzk2bHREWFQyU1RPNFhYNEZiZVVKY2hTWld5dUdGeEdT?=
 =?utf-8?B?SDA1bWtKNUJDUnJoakNaMW9xZDFoZ25KOHZtNjlUc0R0YS9CMWluWlV1NFZE?=
 =?utf-8?B?U01xNkU4RE1XQ3BLbWx5N1NVQ2xrWmQ0djVuVWQwRHEvang3dFBCYm9jdStX?=
 =?utf-8?B?WGdWbEdRWVdkRkxqOExzVy9SakdkT0NDaXgwb2xNQUV3a3hYN2lFRDFOY0V6?=
 =?utf-8?B?UDNwUkY5bEpKQ3hjaHU2MVdzb2ZnVSt3Qjd2WVkwVHdqcFhubXpSRnRmZnRq?=
 =?utf-8?B?RU50YzgwM2JSaEZHUi9IRzlnSytFYVdTM0N5ekthWVhmQ1dRc3JnQ1czbjQy?=
 =?utf-8?B?UmhYSGprNWkxOVJLZmlKM0FER1RWZ0NEUVVJNlk3VXI4Zk92TFJRVGZYbEpn?=
 =?utf-8?B?NU9NeDBYRGtBZXVrV1FwUnJlMk9iZi9obTRTWkhyanhGUDF1bEhjQVJ4WDhX?=
 =?utf-8?B?Q3g4dHJPTCtUMkhtZEpXMGl6WHRSZGdsb0ViM2t6LzVBU1RVUHhWakl4bEl6?=
 =?utf-8?B?ZGcwYisvY1JtcFpqaHNzdG1mMkpJQ1l4TjB0bmh4azg1V0xFUm9VTFFUclZX?=
 =?utf-8?B?VXd1RUVVVWxwd1U4V1VoS1o2ZE5pbWFpNVVHUlM0eUZWUStvdkZQM0I4aG9k?=
 =?utf-8?B?YllNUWhwYTErakV2OXdjREVqMWFieG1BdXN0TXAxSmxIOTNZZXZjZ1hkN01I?=
 =?utf-8?B?b0pPbXFRSXUwYmFwQlc3WSs2UjR6dUh4dXhVejgwTzVGNlBxU21pWnZmOFNt?=
 =?utf-8?B?QTFyMUs3VHliRXkxVTd1S2F6TUFwY2NMUkVwN1RrVENmTHhNYjUvVFB1RkNp?=
 =?utf-8?B?RkU5S1ROOWZJbFB1cTdsVGwwMGduMUtuVEtKOFVqeTBROVl1SjFyR0dEd2dl?=
 =?utf-8?Q?oQWt/G005DlnWUUhFc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b7ff03-f4ad-4d8a-f68f-08deb64b59f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:39:48.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa4RRGzrzy5BW+bflr+mhB3m3PULI7YMYMYAiDhi90oretPb3v/6ZznKEQICbV6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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

On 5/20/26 03:55, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add pin_count checks before calling amdgpu_bo_unpin() in the user queue
> destroy paths. When a GPU reset or TDR occurs during a SDMA user queue
> hang, the BOs may already be unpinned by the reset path.

What? The reset path should never ever unpin the BOs!

Where do you see that?

Thanks for pointing that out,
Christian.

> The subsequent
> explicit destroy (via ioctl or file close) then hits pin_count==0,
> triggering TTM warnings:
> 
>   WARNING: drivers/gpu/drm/ttm/ttm_bo.c:646 at ttm_bo_unpin
>   WARNING: drivers/gpu/drm/ttm/ttm_resource.c:270 at ttm_resource_move_to_lru_tail
> 
> Also add the missing amdgpu_bo_reserve/unreserve around the unpin in
> amdgpu_userq_destroy_object(), which TTM requires (dma_resv_assert_held).
> 
> Move mqd_destroy() outside of the userq_mutex critical section in
> amdgpu_userq_destroy() to fix a circular locking dependency:
>   reservation_ww_class_mutex -> userq_mutex (restore_worker path)
>   userq_mutex -> reservation_ww_class_mutex (destroy path via mqd_destroy)
> 
> The queue is already unmapped at this point, so firmware no longer
> references the MQD - safe to free the BOs without holding userq_mutex.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com> 
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3bfb9ae2cb3a..88c80dae27b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -417,17 +417,14 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>  
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
>  
> -	uq_funcs->mqd_destroy(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
> -	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
>  
>  	up_read(&adev->reset_domain->sem);
> @@ -531,8 +528,13 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_userq_obj *userq_obj)
>  {
> -	amdgpu_bo_kunmap(userq_obj->obj);
> -	amdgpu_bo_unpin(userq_obj->obj);
> +	struct amdgpu_bo *bo = userq_obj->obj;
> +
> +	amdgpu_bo_reserve(bo, true);
> +	amdgpu_bo_kunmap(bo);
> +	if (bo->tbo.pin_count)
> +		amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
>  	amdgpu_bo_unref(&userq_obj->obj);
>  }
>  
> @@ -637,13 +639,24 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
> +	/*
> +	 * Free MQD and firmware objects outside of userq_mutex to maintain
> +	 * lock ordering: reservation_ww_class_mutex (acquired by bo_reserve
> +	 * inside mqd_destroy) must not be taken while holding userq_mutex,
> +	 * since the restore worker takes them in the opposite order.
> +	 */
> +	adev->userq_funcs[queue->queue_type]->mqd_destroy(queue);
> +	queue->userq_mgr = NULL;
> +
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
> -	amdgpu_bo_unpin(queue->db_obj.obj);
> +	if (queue->db_obj.obj->tbo.pin_count)
> +		amdgpu_bo_unpin(queue->db_obj.obj);
>  	amdgpu_bo_unreserve(queue->db_obj.obj);
>  	amdgpu_bo_unref(&queue->db_obj.obj);
>  
>  	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> -	amdgpu_bo_unpin(queue->wptr_obj.obj);
> +	if (queue->wptr_obj.obj->tbo.pin_count)
> +		amdgpu_bo_unpin(queue->wptr_obj.obj);
>  	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>  	amdgpu_bo_unref(&queue->wptr_obj.obj);
>  	kfree(queue);

