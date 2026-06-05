Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB3BCD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EFE11A871;
	Fri,  5 Jun 2026 13:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrNaFN4Z";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FF411A871
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFlPa/6wKUxjFj0NBoV8L3/PHztGOIPAd5D+AYaDmVb2OJABgoqnJ6NmTdjehTMs5W2qgdKN7rmzvgdP/2U1tNkuNTxE13rY7VFIWyGxq8z3tSlCF+L5fQtr2FsLENC9O+/cxhUeBElqTRtKyBy7D2vU/LzD0EB9T2NpjRFs4DbyD/ASe3lc5UxKp1ww3WuTH5D3qQDYjbEk+CgNBZcOAQPE1h9iUygDFjh3Q0rBxPKf2Z8jSgel1Lm7hLGEDgXOCIMIjDpvsXzHM74pxF4CKyslsg3PhAVhPTRrA54O8JODL4GouF7W97XlYfbOPQvbI9HVyzzbESmxk7zsTkyrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkAzZMuoNos5+inhFQrWBH0IZbZ0XlNexZUiHKRO4j8=;
 b=vsr6bdqzSGilE2dNtBMrIaxHQFChisa1rNmeMvwp6xwLfn5OeHGUlBGw9D3YuFrxJoiO153roITQqWb8CrB0N3ND/U80Z5PMyEXwq/GvspLGZ9QT8qRm9aHSuaI8FnFCPwwG/cMYlsv3kdRMYp6tB5Ov0797uME+wL6FSs0+FOx72HV4Fkoy34ysUKc9d0ke0LU9hVvgN3KmAcUdzTnRSpi8aOe1LRwoNtx6xZ55MfDRfXmIIXO7qoKUXns2R7B73V6HJOq36ASg17mHSbDZ/mwUaw4GaZYRsAsHAU4faFCVAxzcuDDq1dLrAqeBg9K3KOPwOjgf92+Kgl/bx5rPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkAzZMuoNos5+inhFQrWBH0IZbZ0XlNexZUiHKRO4j8=;
 b=WrNaFN4ZZNSsEqE9h439hRX+ypF0uhlikFOouLmfHTMcB67NEl2N3SAdoBt9ov2CScn77Q5531VtMXHvnXpRUYDmbd2CTDntmphfj+aFTvTCot/NBRhcjoPEI/knIpTdKi6MVaBhAHpV2WnrCHzZbVFYK6BDV3p8TJopi4kAyDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:20:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:20:39 +0000
Message-ID: <c5c81981-492b-45b2-8000-76d734d4c11c@amd.com>
Date: Fri, 5 Jun 2026 15:20:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/11] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: cac57c24-973f-40b5-148e-08dec3053cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: iSdUxodog32GRfDPHfXdhE9jYyEDoVeL8tRF4j3x2PKBkt/PqD5rFKReDLPGSvaX8HM2R8Wv3yi20lMaYbcRbgrnOaUY70YkA2s5ju/85Mz9mh564Lm0m3Wjbjn0cBXSJfd8fS4CDxlH0XZtap4pUWW6CFOay5+atlfbcX4SfCv9Sm1Z3ncvdyuJh+ciaSVPnXCNBK1R3yvS3D9S9LWInosKfqhK0jlGEyRTaqEJYLd11YXvQ5wag+X71whMismvuWFD+jIx2Fz3cDB5ttYrBp74fb0IviivRyLPctJEsJCW44qN6GT8o/i+UEwpOPdzz/GvkeCv6+C2yOiXGEbhQSyJSXin0Vd1kEbX6e75vS5sMLTuqW+kKboLOtdk8lnkIFQDW4qr4skPMXbWSP0kHbSA88alukZitWtRU2oW3O6OoZI6z97pq1ZTDFd5IWGqv7GGj8eZSuyukX6Pwte9pc36ylP0i1mi7/3MmZ918OqarVEz82rz5itEqWC7q8vf3Vf3ENFo6GZstv6pzAv5DZv+7BPKIolotQ89dHdE99cpYeRqvIrTkiNelnJwgDWyPrG9Cavdom9BNaRp9F5i4LcwUR8N89dwFuIfnDIVsm5QKUo6vqgTSTacOSmv1NIYQGIIgD0WW/cfbj1FLYKj2TJ5FyqHxLW6SdtrsIBIgLxWmCOcIhy3TAu5jNcTWl4B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdHL1F4UDkwWXdjZUtRWEZtZDludGdab2xyMS9BUGkydGgwaE00Qm4wWDF4?=
 =?utf-8?B?RVFHTWpsZmJreDFVUGhrblhJOU5DNEpwTXhGNVFsaHJkWTVrVnhXUGZZUGpJ?=
 =?utf-8?B?c1plcmlEank4WkVhUk9UTzlQMk55dHI2KzFUa0Y1SEpmaWtPRW81dTV2S0di?=
 =?utf-8?B?NWRqdFVHOGppb0NLQXR1Lzd3bnRXeUNUbXBTT1phT1VOTXZRUlZUdnU2aGV0?=
 =?utf-8?B?Q0tkUmNkVXhDTS9BdXBPT1VBS3ZkSDNwTVpNamZhQXM0QzZaSDV1NjlnZXE2?=
 =?utf-8?B?Z0JUb3gyaHFlUFAzdGlqRVhtcWkvL1NSdjZOdElnTEwxaThzUFlvYTlWYW9r?=
 =?utf-8?B?NHVtcWxnT0UzblJ1R0syU2J2Q05Zei9IaTFhc1ZhWDFQVzVaYTk0SSszbzgy?=
 =?utf-8?B?bmI5eEhpVTB5NUY3bVZHbVJvZm4vbFJPSkZvZy81ZzZJR09XNjlVenk2b2o2?=
 =?utf-8?B?dit5clpCUXA4YlY0aHRielA1eG5oSTVoMUkxejlBZDg3RS9rRE5tUnRwQ0hQ?=
 =?utf-8?B?Yld6QW4waFVPUE5MbkorMEVvR3RRS1UveGdSMWdFZzdWdzNUZ3FQeUlDNU9F?=
 =?utf-8?B?clBFeDlIeStLa1lWUVM0K0ZxUXE2Y1hPWXNwSEhGTHFHaEdKUC9yVHJpTzJK?=
 =?utf-8?B?L2hZVWRVa2JnZE9QaFNtYmlFbmRzRzBDbnlsZ0RpYjFCSFRJVWxjM0M0eEhB?=
 =?utf-8?B?VWFpdlFvdjFnSnJqamJjdG05MzhJQzdpT01ZK3AwUCsxNzZMR1JoUjduWENQ?=
 =?utf-8?B?dDMxcTI3Wnp4cEpOMDhCS0xQenE1UEhONzd6K2JZYmRyQXFRWG5PRlQ1V0Rt?=
 =?utf-8?B?RS9SNTJvTXVlbUY2a2I1VzZ0TUlRN1ZLRWZnR01SQ3JnUlozemtzeEJWNm80?=
 =?utf-8?B?U0Q1OXFxRU5jYVpQY3docisxMGhLc1ZrNlpzR0JHZlFzRWVxc3ZJQWhXM25D?=
 =?utf-8?B?UzhyQXNadm5NVGRwUGVTV0Q4Q3BXbHhJZFkwQ01mNU1Qam1BeVVFaHNjOS9F?=
 =?utf-8?B?MmNLZHFvVDg4WFFCRWpVaUluRkExQVZYRFhHWk9FUlRIamh6bXFwVDRSTkxx?=
 =?utf-8?B?Q2ZScDUwUk5NaUp6enFaK3hCcTJIckY5SDNCTTQ2RXRpRkRjVzBtaE0xdmF6?=
 =?utf-8?B?VE14d2ZMUnpBM016dUEwUUx0d1czc0p0ZlhWYmNjLzNENXFKb3RmWTYxR2NN?=
 =?utf-8?B?c0txS3ZxSFF6V3FxS1hLNXRqZlMxV2FRTDBnZk5iU0NPR2NVcVdaQ1hWTmlM?=
 =?utf-8?B?V3NNYm1vTWprOXZ2WnVqY05SQmVUWGlYME9uWXVHcEFtRUFIMHArYnVoRHBM?=
 =?utf-8?B?WWorTUxxRy96bDdPRUpCSnBLRlFXL1hpOXFZMWVVQlZrSmQ3SzgxTEIwWEhs?=
 =?utf-8?B?V0RVenlCcTcvUUJia09JVW1MUjdBSE82QWJseU44OFpRWElyLy9NakdyTEdR?=
 =?utf-8?B?K2d0TFN2aDRTSWh5SWsyZjN6MVlzOEtDMUUyYUhrU2tpVlh2MUZBQ05zTWNF?=
 =?utf-8?B?dHhyLzRjYStSMFRqRU1NMmlMSEdhYkNmbUljRUYzRndKL3prd2c3b1lqSXRJ?=
 =?utf-8?B?NnhPVXdDdXJDRWUvR0c0Q1VaZ3ByaVAzSnNRaHhrR3p3WlBBVjRucllPeGZJ?=
 =?utf-8?B?WmhXcExQMjhrU0FRaHlWSUJRamRqN2RBNXNqbUFBMVFUZFNZUDR3MTRwMDc4?=
 =?utf-8?B?VDdxbitUT0s5dWs2d3JPb1kwb0NObjR4S0d4cVVSWCtRMVJvZ1kzUmREcXoy?=
 =?utf-8?B?cWlIN2hoc3d1TkhtZXZlbTdmSVczWndKaGtOZGZDQzJIQzk4TVdvNzJyM3Nr?=
 =?utf-8?B?bEttMHdKVFBCdHk3TE5uR2tKbXVkNVcvZ2ZWbTRsTm4rZ0ZwbzZtVG95QmF6?=
 =?utf-8?B?NXZpMHBmWXlsaWlXVHVKeFdaamlGOFJHQ2NGdGxYU3IvK1dJNnZXdVNSNXo5?=
 =?utf-8?B?MjYwZGZ6TTVqRkJxbWp3YUVzNk5zRkZ0YjQvUE5YaFJlS0tZR0ZqUTRiVlls?=
 =?utf-8?B?dzZQWmliNFdIQXZ1UmM3bThqNHpCMVBkUmp5My80bjhLUjhOdklNV0FzMjhl?=
 =?utf-8?B?Sk8xd0FQOHhJeElTQkh0L0ZXNHNRbUNsa0ZOaGFEaTB5VzB3cTV0aCthYytI?=
 =?utf-8?B?MXkreTRrUEpjV2dPWk02cmh4cnJsZkhzZjNiYzlnZms3NkhvVnRDS09KUnJD?=
 =?utf-8?B?MU1Kd0duV0tHWDJNM2VmSUlLMGNrS0d4dWFmeER0aU5qYXE2OWxCN0ZaTkZQ?=
 =?utf-8?B?aDFKYzhBQTRGdHl0dnU5Q1pabHEwaHBYeE5CR2E0WVhUWW1Wck83dWI0RXh3?=
 =?utf-8?Q?kVGHlZh/+FBe5xIP1e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac57c24-973f-40b5-148e-08dec3053cd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:20:39.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er0HPAWABoPp9eycVjHQ1ieKQqDqFeYohMJFwVZAgqwob/CZAs0CpI3pYZSoSngs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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

On 6/3/26 18:33, Srinivasan Shanmugam wrote:
> The current EVENTFD UAPI describes subscriptions using a userspace-defined
> event_id and reserves queue_id for future use.
> 
> That no longer matches the intended render-node event model. Userspace
> should subscribe to kernel-defined event types, while the kernel keeps
> control of event semantics and signaling sources.
> 
> Add a shared UAPI enum for AMDGPU EVENTFD event types and update the
> EVENTFD ioctl documentation to describe subscriptions as notification-only.
> 
> queue_id remains part of the UAPI and is now used to distinguish
> queue-scoped subscriptions from GPU/device-scoped subscriptions.
> 
> USERQ_EOP, QUEUE_RESET, and SCRATCH may use queue_id for queue-specific
> subscriptions. MEMORY_EXCEPTION is currently GPU-scoped and requires
> queue_id = 0.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
>  include/uapi/drm/amdgpu_drm.h           | 25 +++++++++++++++++++------
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd127a271c19..75fc3a74db28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -643,7 +643,7 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  	if (!fpriv)
>  		return -EINVAL;
>  
> -	if (args->flags || !args->event_id || args->eventfd < 0)
> +	if (args->flags || !args->event_type || args->eventfd < 0)
>  		return -EINVAL;
>  
>  	/*
> @@ -656,11 +656,11 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  	switch (args->op) {
>  	case DRM_AMDGPU_EVENTFD_OP_BIND:
>  		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> -					   args->event_id,
> +					   args->event_type,
>  					   args->eventfd);
>  	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
>  		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> -					     args->event_id,
> +					     args->event_type,
>  					     args->eventfd);
>  	default:
>  		return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 63cde4487c47..3dffd9e581a1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -207,28 +207,41 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +enum drm_amdgpu_event_type {
> +	DRM_AMDGPU_EVENT_TYPE_INVALID = 0,

What exactly is the invalid event_type?

> +	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
> +	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
> +	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
> +	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
> +	DRM_AMDGPU_EVENT_TYPE_GPU_RESET = 5,
> +};
> +
>  enum drm_amdgpu_eventfd_op {
>  	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
>  	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
>  };
>  
>  /**
> - * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an event_id
> + * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU event
>   * @op: operation type, see &enum drm_amdgpu_eventfd_op
> - * @event_id: userspace-defined event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   * @eventfd: eventfd file descriptor
> - * @queue_id: queue identifier for future queue-specific subscriptions
> + * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
> + *	      device/GPU-scoped subscriptions
>   * @flags: must be 0
>   *
>   * This ioctl lets userspace register or unregister eventfd notifications
>   * for a render-node event.
>   *
> - * For now, @queue_id is reserved for future queue-specific subscriptions
> - * and must be 0.
> + * Eventfd signaling is notification-only.
> + *
> + * USERQ_EOP, QUEUE_RESET, and SCRATCH may use @queue_id for queue-scoped
> + * subscriptions. MEMORY_EXCEPTION is currently GPU-scoped and requires
> + * @queue_id = 0.
>   */
>  struct drm_amdgpu_eventfd {
>  	__u32 op;
> -	__u32 event_id;
> +	__u32 event_type;

That rename should be in the original patch adding the interface.

Maybe best to squash the two patches together.

Regards,
Christian.

>  	__s32 eventfd;
>  	__u32 queue_id;
>  	__u32 flags;

