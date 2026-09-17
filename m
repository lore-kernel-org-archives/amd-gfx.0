Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9703C982D1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 13:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2224B10E437;
	Thu, 17 Sep 2026 13:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CRLQsS+q";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C932110E437
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 13:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4OJxeDBRyHCiX+Trd5X9aCRUpb/UMy9hivljZKkrZ0WBREOfFczrsh+tiv7qO5NFEp8GzqMg/3KYzhyw6VPtRn9IYnBIMx7SelP30g7FWhKRmXWOdWWeb7L6GhLgGW6CuX0aDB6klfcgmsi6dzuTm3bQz3D7laV17w7Bb04cM75+bf/tTkPxHgUDUuUgXhHy+zpW/9XAGSjrd1tULS1qlojZ64mEeVETXAB2YgqTg2eMHIURK9CHrNW32bvvTy2oSOoT779+5RhlRoqRvZ2DLj19mKibdXlFXPbhLNpuEQ/JTNXaPEAQsKzOrLPfSS+uGmcgmulZ6lGIJIDfHBPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmlI7M5tthiN3o4RnHf2/49RMKYvg8WTSEpiDuDEzKY=;
 b=U+vzHcpuwEEWQY2eNA+Ro7GlmEVdE/jH3NX9dO8ZcWLrqM8oaQwSgLI3ikX9AFGEkcoxXbkGmN2GCrBOYENEB0Ej157G3cAySM9dH1AAkCcN3noQ+uorvx/qY4OXC4WBpdL/gvWJ9bHUd74IdYakn1CLGBIwDbL/DhD6M/TEKBNnfkLuMDuwjYAEjiN1lSBYP/IC5xyB7lc/Ua1EYKVCYrp9SEADvi0b3UDcgl4XOD9fdJ2vfomfB7TgU/88lMCqJUlC80fLVGGtZwkeA0pljvn8oo8T5e90mprXkJX8axheaItyI0Ej9nVD0sfbhrBfXUsgsOyWrC8OTLD1jzlGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmlI7M5tthiN3o4RnHf2/49RMKYvg8WTSEpiDuDEzKY=;
 b=CRLQsS+qpcKcN3izV0gOzCKU/fgfQz/deh0ab1j1GcJtZg5YaWmT7BV8h0dYbwL4tCifkxoHVcMO4SYhXwsPSg+AAxM3wa18c5rHFodKYBq9nqL5HUkq7I4JJepnk1Xhj2TyiYtrTdGpPHc1/Mb8Vc0UJecLXNhtz0ZxbM8OsMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:19:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 13:19:22 +0000
Message-ID: <b29c3c91-6fa8-439d-8085-8a06db178862@amd.com>
Date: Thu, 17 Sep 2026 15:19:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] drm/amdgpu/userq: fix double jiffies conversion in
 hang detect timeout
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260917131338.81540-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917131338.81540-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: d1af2872-305f-4deb-f653-08df14be49d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: BMA6S/2lwtT8BGHWEEi2mNbWftprIrTMGnV4tG+DndwDqbKSgVgO616H3IDkNUO7Y0IEHOpxMQMZFa6elpxmMCrst/yQaw3eF45A4awlrfhQdx6/Ro0+Kq/YOYMHvRaTncgMreVpvPOGH2POJLc0Alt8rP+5o59K4DJ45wdv2QbaRrTssxmV+6A0XGz8bLfmIxLX2b5OBxuRCOUECdZFrPM6Q+IgNPwxB96NTZ8Rj7MgrA3uR0BAedmMFvpi/MMtpjVgUHCdgK2Zb+erqqh77qrWueCc+1FTucSD3qHmgsvBGrUxbGsYInuzSuHL4zYAFKNdNJdQzsQc9n8+retRGlyIg3vAnpj0X6xAQRgNa6hEmtTJWIxCsmo/r/MJklcjoGyvsRnkxMbPeJ15DMA264MKj/vgiPZGV/CVD8NKFGjb7PKJbgnFNdVGc0IMawrBMy0S8RBxRvcsC6CMnQVCME7lZSVSg/kWPOLa1di4AjeqqoltZtmflWv/EIjYY2IF+97Jz/6tSgz1RlLkT4Qh4oHMFSSOE/fFAh9Mqu+kSXgjY5hCIn0QKPY6RhmdUmBU7z9ZaR2ZmLZeX8VmfF1sXjw/4gkHw6Zjy7OUSzzZLKeXtGAnFTJbEFydhuIOBMECVSocqUtp+wL+sfHrPbQLDtpkwnNqqznhz8TKeWvZopo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhvdldJbEZZcUhPeHZYaHRXUmprZUVoTzZNM054UWh1TWsyMXBMZWRpbUMw?=
 =?utf-8?B?QktMQ3ZiVUhaeEFraHVwbm9WSVByclhvaGM2ZHlIaDArWTA5RnZIVTFoR0wy?=
 =?utf-8?B?M1FXdldZMmVmZTZ2MVFJbnJJWG1EOUNINzZkVm5PcGtlK3hUNHFnaHU1RVR6?=
 =?utf-8?B?c2tNWUhCK1Fjc3VWRUFmbTd1S2ZCaU1PZkFPL0JldktxRWhzK2JLVy9DeVBL?=
 =?utf-8?B?UTNVZFVwSkM2NkJUYzJXcFJnUUtSZ3dTLzd2b3JjTWF4OElNWmNFT0NvM0xv?=
 =?utf-8?B?RU1pVE0xRGYwcTNNSCsrbmdEK25mdmJDNW1MQlFPeFR3bWs4dDBmTzhZbFU0?=
 =?utf-8?B?UTVaZXJJRTRDVVdFVmNuSGZWUFRxWCs0UHpSaW52dmU0bmdEY21VRnNFdy83?=
 =?utf-8?B?S2E1ckdVSnFLb0JoamJ2NDlnajRyNjZWeEdsMHg3VHBaWklMUGdVSTlTdFUw?=
 =?utf-8?B?YzdIMmVhbHFDMndKRFhqSnlNUDV4RkQ3Y0gyeUdtMlZ2RXJhSkNtU1NYb2FI?=
 =?utf-8?B?Q1FyV1o1K3g3Z1J1TUg1S0RkckR5UU8wUlNlS05YaE5GVUNSYThOOGtIVzZT?=
 =?utf-8?B?SncvVitpWkZZM1NaYkhiVms5U0lGR3BWTkN2VCtLK3ZqUzk0c3JIVGJaU244?=
 =?utf-8?B?c2pVM1RiU0haNElYTXErdnBzRFAxb0xDM2F2ZW5wRjZIWEJCeVJBcVpXUlFw?=
 =?utf-8?B?cGhNVUthM0EwMEtaRWIyQ0hwaG9qbktuS1FLd2RTa21aNnlxN0ZyYzg2Q0Nw?=
 =?utf-8?B?aEszTzNxQWJ0RkliZENYZVU5aHRTQjNDdEZhWFdscmU0T3VvMWRKalVIeWRC?=
 =?utf-8?B?VGF3dkhMbEh6WDcvSGFKbUMvOGkzTmtWQmVVdmxhZzQ1d2NPaytKVmVQOG5x?=
 =?utf-8?B?ZlYzcTc1N0JjRmFqa3p0WUdwQVZqczNpYW1MWTdXNld3OWZ6VElKY0pGZ2cy?=
 =?utf-8?B?c2ZyYVo2bUFNTDVidy9DeG1Wc2tZaGFwMmpvTDkwUVFCTHpZR1Q3MHFWSzlT?=
 =?utf-8?B?SHFZdy9TNEtNSGJpQ3Y0bGpWenlOdUtQZDZSQUtPeGwwSE5jcUdKd0tYd1BV?=
 =?utf-8?B?b2gralVzdCtMR3BQSjRqWUhFa1NXQ1E1eGZDNlNUUkd4UWwxdFQ4VlVFK1hU?=
 =?utf-8?B?b2lNVVM0bm1HcGNFRkkvL1AwWUVCRnZkeW9jeXNrbytRbmwrWHFmeUNNMHly?=
 =?utf-8?B?NVFjOXNYUzhUUUEzSmREM1paWC9Lb0ZYMTFUczM0WTFPTHlSeVpnQzMzUERT?=
 =?utf-8?B?U01BdXVBWmxxWlZ0WUE1N1JtbGxPY2ZOY09KUndmcG9UOWRYbWdBWHFQL2hw?=
 =?utf-8?B?RG81Nk5IYksxdHFZWmw4T2lKdEd4dUZZZTR2UVBHWU1zMDZQbG9LQWRlTUFE?=
 =?utf-8?B?REsybjNDK2tmQ3cvUHd3NjBHL3hKVjZHcWZYM1Vwa0I2Tmdic0laWTV4Zkh1?=
 =?utf-8?B?b2pBNGFvUkVXREMySHU4S252Y1k2NFl4ZW1vaFVEenc4WFR1eVdZYUxHTDY2?=
 =?utf-8?B?ZmxsWHR4VGRuL3NxS2orcWFKQUlwb1czeHRhdjFXdG5ESWZoWEthejZYckNY?=
 =?utf-8?B?NitnQWE0MjRsY0VXR3FFK2JqbVhjT2pJSTI3aFJkQWVtMnNCYXoxRHFPaEMr?=
 =?utf-8?B?UUxvVWViOHlEazVUWjV0eDlBZ21XdGZnVnZ4U2E0MVU5dWRGcEQ4ekcrVndh?=
 =?utf-8?B?VjhWd0V4TU5lN3F4dGk2OHBneEdxZXY1Qm5vQzA1cWJZUVVQM1N4d3lhUyti?=
 =?utf-8?B?aWdGMDBGNzlMYWpvck5hMW9Zbk9NT1ltZDFHYzRLNVB1Njc4Yjc2eGxDakJB?=
 =?utf-8?B?NCs2eXpqbGZ5NTVIUU9uYlArK0JVL1JkVzdKTHR0UEMwRUVYQ1NjVDRrRFhD?=
 =?utf-8?B?SkE3Zm5zaDRTYmYvRzRhZzBYSDhDWVNEQ085dU51TzVyYjhUZDQ2WGRUTlJn?=
 =?utf-8?B?Z1REN0xsR0xaTmx5K3pGSC82WjJBQ3VNSjlBK2VwNUJMdys0S2U4djRkeS9Z?=
 =?utf-8?B?WTA5SUFrZ1hZN2I3QjdEdGZ6NlVjWjJNTzhQWU1zL2lUdjJsMUNNT1VuVzdM?=
 =?utf-8?B?cnVNYmJOTjRJeUtoRmZhNmV2Q1piU1g4cW51a2RoQWY0TDY4ZGdXTDlrV2dG?=
 =?utf-8?B?Vm9ONFZpV2JOcDNoZFNtV3B3UUMvcFNDUHdtUWJuVTd1WU5JRk01UDNwS0Nn?=
 =?utf-8?B?UjFYKzNzOXl0WENCWEwwTDZVOTdoK1dYcjhYOGNvMkNENDU1S1VrM1Fxa2hC?=
 =?utf-8?B?VDNpV1poMUFIN0hrNWk3VXN4cDJxcjMwejhDRVpGTk5lOEUrMHROczhJR0xp?=
 =?utf-8?Q?NtCDDPLpXUajMMlc0E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af2872-305f-4deb-f653-08df14be49d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:19:22.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ggt6I3mFPVbiWain/oCfyU58VUQLJZHgQRPOzKkO+3LLbIokz9cKngXH15ANSFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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

On 9/17/26 15:13, Sunil Khatri wrote:
> Function amdgpu_userq_start_hang_detect_work() calls msecs_to_jiffies()
> on adev->gfx_timeout/compute_timeout/sdma_timeout before arming
> hang_detect_work. These timeout values already hold jiffies values from
> amdgpu_device_get_job_timeout_settings() at device init.
> 
> This silently shrinks the real hang-detect deadline to (2 * HZ) ms
> instead of the intended timeout. e.g. 500ms instead of the 2000ms
> default on a CONFIG_HZ=250 kernel, only coincidentally correct at
> HZ=1000. The shortened window is easily exceeded by ordinary
> fence-completion latency, causing hang_detect_work to fire and
> trigger a per-queue or full GPU reset for queues that are not
> actually hung.
> 
> Pass the jiffies value directly to queue_delayed_work() instead of
> converting it a second time.
> 
> Fixes: fc3336be9c62 ("drm/amd/amdgpu: Add independent hang detect work for user queue fence")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire set.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5d07320a29b2..75d5ceaa53c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -184,27 +184,27 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_device *adev;
> -	unsigned long timeout_ms;
> +	unsigned long timeout_jiffies;
>  
>  	adev = queue->userq_mgr->adev;
>  	/* Determine timeout based on queue type */
>  	switch (queue->queue_type) {
>  	case AMDGPU_RING_TYPE_GFX:
> -		timeout_ms = adev->gfx_timeout;
> +		timeout_jiffies = adev->gfx_timeout;
>  		break;
>  	case AMDGPU_RING_TYPE_COMPUTE:
> -		timeout_ms = adev->compute_timeout;
> +		timeout_jiffies = adev->compute_timeout;
>  		break;
>  	case AMDGPU_RING_TYPE_SDMA:
> -		timeout_ms = adev->sdma_timeout;
> +		timeout_jiffies = adev->sdma_timeout;
>  		break;
>  	default:
> -		timeout_ms = adev->gfx_timeout;
> +		timeout_jiffies = adev->gfx_timeout;
>  		break;
>  	}
>  
>  	queue_delayed_work(adev->reset_domain->wq, &queue->hang_detect_work,
> -			   msecs_to_jiffies(timeout_ms));
> +			   timeout_jiffies);
>  }
>  
>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)

