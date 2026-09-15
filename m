Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D979FC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 01:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EAA610E224;
	Tue, 15 Sep 2026 01:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3KHSfb2K";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9584F10E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 01:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVRhTGgsrXumAyyt+LaGZNEn2zBzeTpUvmgYClxgLdUYs16TLdGkq89d3H+PwiP/EsBofjfbj4/jnyFfYx+rftWYv023Pvw+/3wsuzpp41xUcC6ZvS0gFU/F3krFRm7h3iaolsbTu0T9qH2dw5fM32BjvBMRdDqIeMuyQdeALDybw/SoCZsc56YSZJEI5FMxhU0ecSIKAERadOUH8JHN35JB5+svmeYl2xrUcfRDrvWmqBbq5iqZ8IhBDRGnuEf40KhDkqX45hd8ArAFXmTfGHOjjGypyomXuamGHNWcUdhbEN+oPe0w5BquJWWGIVPwLMH9M54zr/ajlzNFgLDd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLpcd9rXZWlTnjO7H/A06I2JqvNlxFkClgbCq/Q0Fvw=;
 b=anI5omQloII7WvT/QR42UkHP0qzhVMNkaQcPiG5mbOcWYpSsBcjW0pGSU7xIHFc6dBKDVkQ+RBgYBRAbvOnsKaye6xZvagJ9YE0ZcpMD5yo48P0F7VRmAm1mIj+xNgq1/UVfxON5LSUrXvJ8kqrIyWyWQ+HbuE5gf5Ep8utQlvx8tqHFpLHjRQblWbMpbOTcpbZxdzDrQoxlO+1JvSw39MAWVyTZdFhc6h/elShH+PmseZZhkVGnusmcSJxt0lk1waEGbHkfacIHYYmNqucpWCCmdXvmS8yubPHNLrMirH2WGTIjNdrsR+iCr2BrrKlwRWv7ecLJpnh0wbqkxDDfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLpcd9rXZWlTnjO7H/A06I2JqvNlxFkClgbCq/Q0Fvw=;
 b=3KHSfb2K/bDRO0XdrdIuC+dV8YOIEmR/r6IZiiMoUVjos0wCchxqh22j4vhuO/iwzsb2hqCiSLl+WZsCibHdUvjYXVjy6zP4ilKNhErbbOy1ZrMG3Cw8nHlkOQSm7o+VZNJbYewiIogaEGZKRRMtisRE9eOMYLbl0BPpPj3PSMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:49:52 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:49:52 +0000
Message-ID: <f2da32bf-5d48-4e10-ac5d-e7f2ac1aa178@amd.com>
Date: Mon, 14 Sep 2026 21:49:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] drm/amdgpu: move userq fence wait out of signalling
 section
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-4-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260902125001.621629-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0061.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::15) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc63a79-ba9b-42c0-bdee-08df12cba230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|10067099003|4143699003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ayRAhsA3+/ZKhAHCrn7P0UkEkfPUFnxP0O8BwL4eGSfyjG/TjtsIONZTCopGrZnCVEGTTgHIJm3YShwvB0+jch3z7ZcHzpGed487SBxrDjM4bBsO/H4LAd/h/1xjX7dSWFcW39MDvZBxhSD16m/+4D0LqAfLJ4f/YIp7tAKyVttAfjsN9ruEEbkEeJ8WR4d8uZq3eNh5BSnYVbBm1jmkck5qGe+tlGYccKDSZghNSGo0YsMmq/TOD3oBT9tUo4XluCAIUDn4lzNwgDMiAJNfHrzahY5D2bYNhKzKfO3KdvcHKLJbKWhFl4qAHdgVZ7hIr9hkal6Mf+zKQdjXPatTD8ja91qcXT/LRVkNFQZ6mPN9Hyp+Pwj1u+M3zWveRlD/jSIOjwcLHEwXRDqL6opwXdDHbXPiUMK9wsDyojXul7MDPCW98fRwy8GSMVgpxlJninMSJh1SIkPGDGCW2/QcrqKQ36L2Bb3RR1Cv+0ANQx0zs4zvq52b5lEa/YTtO5aLmq1pw/OHRNs5nBPOqdt6jsRYJfY+kRDCnIWw4xfGZ9XULqC0CxSZ232YvkKA3b3jCRgmvFYsXQ1p+XRlOxuVjUocnsKH9KBCT6OeiOcBPOVKPVNEoHsCP1Z7xufnjPbUHcSow1zK3bNEEj2P3f8Tf89+F1nTrtPcjzdeYyjDbwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(10067099003)(4143699003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBJZWxRZ0NFS09hd3AwTURPNDBKTFlkZjRtL3ZBOHJFT2o3Q0F5ZFJlZXB0?=
 =?utf-8?B?SlgwM1I2NWxKNk44UGVrbTczdzZMSGJMK1pXUEpkcmRYbFVOMjI3eWtnaHBz?=
 =?utf-8?B?UGlUUFJYQzJoWkhMaS96VDJkM095V2cwTjZYdWlhKzNpbEx5L2FuTCtlSzB1?=
 =?utf-8?B?dDc0dnBjVHZ1ZFdseTJzZURwY1RaU0k2bUkydVU3aDVpUm5PL0YwYlBiVFRr?=
 =?utf-8?B?K3NZcGtNM244Y2paQkpKckcza083UTFucW5ta1pjNEtoMXNDbVE1dnk2RTB5?=
 =?utf-8?B?TTlaTmplY2lHYkN1M3FMZjhSeTRVbUpic2c4c1FHeU54R3dhNmI1QUNUcnNR?=
 =?utf-8?B?eDdmdWo3cTQwRVJoaWVuck1CbkhwcE43SlhuYm5UbEh6c2pwV0NVVyt5cEd3?=
 =?utf-8?B?Wkh5WnVnUW1zWHVJeUpRbTBhWVNXLzV2ZWhwR3ZPK3FpaCtZdm9Jem9CVlYx?=
 =?utf-8?B?WDZiZVM2WjFjbWFiMUw0UEJVYmN6M2MycEtycWcyWGQwdGhuZkMvVFRwTjdM?=
 =?utf-8?B?cUN1T0wrVEFLRHErQnhtM3FMcW9qbndBLzg4SnVkc3VrRkpVT3VFVzNoY0Y1?=
 =?utf-8?B?QXBZS3dJdUNXaEN5WjVBaUtlRTQwS1dXSWs1RUJKdlhmV0JweWtGWDdoOHJO?=
 =?utf-8?B?clYwRVJ5NmJZcUdsRUxJaGw0emRHdzRLRnhXK1Z6VXhLNjVjZmxUVDdvbjQv?=
 =?utf-8?B?L0N4NXlVOGIwdFJqQzBROE16cXh0RHJIUjVvSWFGaC8xTFlnc0pHR2tEUENt?=
 =?utf-8?B?NUhGTVFLWnkxQ3pJckFJMUNRdGpJSGxIaE0rNlIxYXY3L0VJY3U0Y3FuS2gr?=
 =?utf-8?B?Vy9QS2REUWVFRXM3RUR3U2c1ZzZKcUd0N2xUWlkvNzlWZk1aNFZjYXBCRW1D?=
 =?utf-8?B?MUNycGNTS0hKOXpQakp4eFBOQks5N09BOThvbGRiRk44dWdHc0ZENDJrTE5X?=
 =?utf-8?B?ZjFBVmJDOWNSVHliM0c5S3lsNlhORk93VEI5MmMyNEE1VkVlTEVTTW9aa1V1?=
 =?utf-8?B?clBqV0hyTzZHeFc5akJxYWFGQ294TGpQUDBKYXVrYjhBbnljdHZpTUE2MDBB?=
 =?utf-8?B?SjFRYVdnWU16ZkdIWXJBWE9DRmRwb1VRRUQvcDJIVk1DeEFhOGEyRXhaNFcy?=
 =?utf-8?B?UmtFcHdEQXhpKy9XWUN5UXNsS09PY25uS3dnbkYwZWNPQjM1bjBBeTdhK1NX?=
 =?utf-8?B?QjMwOGVHeFFuLzdjYzUwS0RrbzVtTHZJeUpObmw2QlRxRThlbmNUR200TjhH?=
 =?utf-8?B?S3lCRnMxZ1k1TDdmblgza0I1UzhjcFl6bFk2TGlSeTdWUUJseENULytRbXRK?=
 =?utf-8?B?aklubXBYS2NKUjlzclV2dlFmMGtSZUMxNXpoUzZVZkplc2MrdVJIekNFbk5Z?=
 =?utf-8?B?U0hPYm9IVU9tRkc1Mmk3dVRnNmJscFcycmRzVHpORlVNZ0dRMWUvalBKcllp?=
 =?utf-8?B?TkdmSzBYdjZBbGd5Z0hidGpFRldpV0tzY0ZGSWVBbzVIK1dKMkNaSHhvMUhT?=
 =?utf-8?B?RDJMaHlXcVh0VGJ4eFZYS1FYQXFqOEhvTGprWHJaUURpUHJQSnJRSFhOOEYv?=
 =?utf-8?B?bVh6dWNVTi91UEd6ZmgwTVBsdEtpQ3ZHdWMzdkwvV21PS3VVUFZMRm1TQ2lH?=
 =?utf-8?B?dGdkUWcxUjU2ZktKdzluMWFIQVRIZHlsQVFRdXgyODRxenNYd2k3T1NVMm9Z?=
 =?utf-8?B?dUxPMDlnQnBDZ25LZzF5SEZ1SWY2WTFOOVJHV01la0JlY29mcEVzL0x1SXRi?=
 =?utf-8?B?TzVxMjVkVDBQWmNVNk5GRE9uNEpJMzRIWGdlYVYzaFlPTHN2MUFKaE90SnNx?=
 =?utf-8?B?Qm13eG1LcFN2OEtuaXBQS09LTXlpRnU2aUtuTzFBSG5OSUtjbWEvWnJYTlRq?=
 =?utf-8?B?MFhxU2d3cFUxZ1BSQ1RWQUtad09wSlk2MlR2blRqRHdud2FGVWNqSmdQbDdX?=
 =?utf-8?B?b21kZWR6OTdKTGJBWVhmMS9KUjA3NDFmcFcvNkg0VGVEUVhDZHZrNWRmWC9z?=
 =?utf-8?B?VnM5NmJJMURMN3NCK2NTa0l2Rk5OU1Axam1HWWtqZ1dNRXoxaWg5Mm5qSzkx?=
 =?utf-8?B?NG9aeEljdUF4V3NwTnAyUmIyQTF0RWYwZlJ5NUF2dVJjYUVoc1FxaXhkZlE1?=
 =?utf-8?B?bVJWc0NRdVAyTlJ6cTJaL0NJTXA2ZU1DVVVIcVFFN253YmJwSDZUMU1iYTEz?=
 =?utf-8?B?UkFlb0pJMTVXaFhzSkZTOUkwRTg4ajd6cytxL05mZ256c1dISDh4YTBJeThz?=
 =?utf-8?B?YjBxMEgzMzllL1FCQ25zSFFwOUJyWCtUVlRwa1dMK0xCTFdaT1J4THRFMXRW?=
 =?utf-8?B?RllqdzVzWEt3aGphbkRTUHMvbVZkb0Y2TENPMWVabWFjMEhtbDh6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc63a79-ba9b-42c0-bdee-08df12cba230
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:49:52.0752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN6dDgjambORdly7A2Elsp+xPab91akU+U6onh/M4DHgCg/xQBDZfgE5hiha11thGiJ67lVT3Cs512mP/aKKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
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

Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

On 2026-09-02 08:49, Prike Liang wrote:
> The eviction fence suspend worker waits for every pending userq fence
> from inside a dma_fence_begin_signalling() critical section. Waiting on
> another DMA fence while responsible for signalling one violates the
> cross-driver fence contract and is reported by lockdep as a
> dma_fence_map dependency.
>
> Move the wait before dma_fence_begin_signalling(). Keep userq_mutex held
> so queue lifetime remains stable while inspecting last_fence.
>
> Fixes: fc61df151617 ("drm/amdgpu: annotate eviction fence signaling path")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 4c5e38dea4c2..a0802012de49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -68,6 +68,9 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
> +	/* Fence waits are not allowed in a fence signalling critical section. */
> +	amdgpu_userq_wait_for_signal(uq_mgr);
> +
>  	/*
>  	 * This is intentionally after taking the userq_mutex since we do
>  	 * allocate memory while holding this lock, but only after ensuring that
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ed329041a648..a7b68fd2360e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1272,7 +1272,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	return ret;
>  }
>  
> -static void
> +void
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> @@ -1291,8 +1291,6 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	/* Wait for any pending userqueue fence work to finish */
> -	amdgpu_userq_wait_for_signal(uq_mgr);
>  	amdgpu_userq_evict_all(uq_mgr);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 6412a7f7b6ef..488dc21d7c81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -162,6 +162,7 @@ void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
>  void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>  
> +void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
