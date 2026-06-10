Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F8ACD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F321410E439;
	Wed, 10 Jun 2026 12:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="evqKG+kS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFEE10E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x61wcpIh/cOAZM8sHQuWtKPRWn3NUaQpEkMq+AiFDkkOJCKgNts2v+nfgWQ+INoAFIk0mabRu/L7R/cD7KF3L3PbzMdOMB2UYpHdrXVvBoEFwSPJAcebpRIImGFtg6WqmPEGvWW/TlNQ40OuJzLClLN6lE/trCBbJvLxTUt4Sebu7DJS9dxhgOEPOnARN5xLU6NsFbL4r6Q3g68fjxObRsczvfU5Od4G6hfEtRYGIEgKEFQ36QbU9xX80ntpCQ088obJatwyXucVRF4oqT2dCEu9erYfxc2QYFDQgO9jmIpjDv52dxDcghzXHF+W/XM5mq2oxPUSW5F7RPpU43wPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uncLYIRohUtRMg+LR7XQtr755CDeJLE+z1HToV0wk/0=;
 b=vhGeDSlQi8nmzESR7S3GSMHubd0pwVExDNtkjgmvath9PhtPE4T+7KzE7XhaFhS5PqmfAzgTrvroEB6VeutWZvh5k0xAm2WRcLr7rmAvT2BviOV8RfWQ9HXRWwneB3mw9xfXU3H6bRdU2JcOCgY+UKGs4Sufjr/JzXLJoUHjjPJ78QopU0+fTkefpWFt+EkLIAAcrQGWHWUEge1fmE2Hs17HPmlUhOBHoBXPAo9eY9zN+nA9j4UMtsvkZ7QlSwZC2hPjSnbpT4Am/8P3j14L84iFCITK1P9+/LnUJhplb+rKAUYxlq3Xnwvxy4Bs4m4rko2b0/xilU85fRSz8kbwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uncLYIRohUtRMg+LR7XQtr755CDeJLE+z1HToV0wk/0=;
 b=evqKG+kSy6nzME+OR+QYpfPgw5jvsk4wl/vQAbaJ5wXtVsb53cYrR+Cnj9xhAXkBojHmLXgucglZYGUlHeobf+avDp2kTAgvEpnJorrR1Hc+9bd/xiDBHcN25XWhI+6l4NA8OX+R6vhY+tqpno56mh6ut1Xyb5eHw8c9UnAuzmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 12:32:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 12:32:09 +0000
Message-ID: <67c9025d-a1ea-4ba2-a6c1-d1afd53b4c19@amd.com>
Date: Wed, 10 Jun 2026 14:32:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/9] drm/amdgpu: Use queue references for queue-aware
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
 <20260610060402.2769642-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610060402.2769642-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:52f::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 988eed8c-daf9-4a24-e607-08dec6ec4a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: wee+NlVubC7piw0LzVzgkJMuF5xfKInZV0y4BEllVS0YWFcLHvyxLEuK7SaKlUuJAvuvOtIFs3M9dAj1ElYuTEi1BZfiR82yeRuyoo7O5LaEkfx2fYE02hmP+VZDdz3vcH7wQpDAyZcRalKpuxw8rv9ZAeBmPFZBz584mwlzePh8CiiHRTtmlClTHCxekBi2N/rvqcT13tkGKN2bTROJuqhOEZ/khzSqdDGziVLtIO91X+EBE6eykUcAMVX6w0XYHNVfrdahFNBW6SxyTDnjsDbBD7Xrd1EeFpW5GZMSfoxNJNMmWBLUYZ3ravOPANVfaa5tNaCGNzTtedt0M8nrW7eS8L4UbuqQoXo2jIB5szpX5M8f1yjCbHdqowIDdevFYmWwbC8koD81w0AQY5eM33/iTOGhFkUiGMbNfwWgzYVWT28LZC65LrakSVPV51W4ydF4pnRKfT6tbGFFweB4Hl9I38YdEIGHhjC7OJBD9Oz0ikdtB2GrF5tZfURRm9NsovLob6gKc8yhDkngbbrMlroL9egLW1OWFXVvN68kwZHuqRuw4plJBeUMfcx9WOhHH1Q7rSG6LWv0sXAMfG6fuPPJ656NNQSAODnW5GGSLEzwqF33sWPuLABTeZegXVjOudmaKdXooIOx/5aZuZRxZgYjQrxfrEs4N90sGhOAUiEWIXDgz602tzSp4X7SfxeD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dYYlJoOUYzSWdXbWtjalRYVVp4UEZoZUFtd0F5TWVJUDdueFlFbEpaQ1po?=
 =?utf-8?B?UDVURnIxMGlveHBPOHk1NTU1VDlXSlc1NEZ1dGxWKy8yZ3ZYcFlnYXFMS0Nm?=
 =?utf-8?B?YlhCYy9GZVJoOXQwVXFRb2VLZU54bUZoTHkzUGpCeXVrYk92RlE1K3JGWnFD?=
 =?utf-8?B?U3Z2TWoxcnNqTWRrajNOenU3TzB3ZVMzQW9nYWJCMTBYWFlnNFhJUEhaQ3ds?=
 =?utf-8?B?ckZLc0VuNG9ZNW9jU1RyN1lqOUZlWUpaTy84U0JKRUF5ZXFHMXJDYnMyVmF1?=
 =?utf-8?B?NEREeCt4SGp2YnVGRS9wSUg4bWYwQ3ZtajAxUlhiQ0tPSkprUGlocUI4Q2wy?=
 =?utf-8?B?dzFVa3F1dFYwTS9WOWFrdjVidklhNWtOanUwSlNyU0k1eVlhVi9BZnlLMnRk?=
 =?utf-8?B?U1FYcnI3UWNlTDczdkFORWFBdFdPVmlDdWpzZnNmOEtnVDBZb3hrRm83Si95?=
 =?utf-8?B?eW5tR2lrNVBiNUtLZXkvWGVFUUYxb1FVOFNKeG5ZR2dWQk1GNFoyeCtQSENk?=
 =?utf-8?B?SEhQUnkvTG9mOEpYeTVhdnhSYmhoaU5xZUhuUE43bnM1OE1DUkhmNmV2bFc4?=
 =?utf-8?B?TmtmaTJWUWdoZkxsV3JQdXZZM0lMdkk2OFFDOW5ZZGF0R0RpY2JHbkdqWExi?=
 =?utf-8?B?ZEFkd2tnR3pDNFNnMUZxY0ptM0pyUmNWWk15Vy9jV1JlSXhodFh4MU82aFZq?=
 =?utf-8?B?aDBVK09oOW1mY0dHcUVWMktKTldnWWpjNEhDc0ZHTFdlYURib012Zy9Cd2dp?=
 =?utf-8?B?SCt0NUNKRGFIQTZKNGR6c0JVSjlqYmJBMFBiL01oWldicUdZNnl2eGQvSWc3?=
 =?utf-8?B?bWR5aVlUMHBkak51TGU4NEJ5ekxtMStoMFo4a0FkSFl4eG5FSlR6bnlYdml6?=
 =?utf-8?B?MXRzSitIK1UrbEJaUWZlVGxHVjFoRjUyaXlISkZtTU9La2lpWmdnTHZNR3Fv?=
 =?utf-8?B?cW9vT0JpN2ZKa1Jha0pPekRrZkNRMFIvQ1JlZVhaaXRwd1pETFp4QVpoNHZR?=
 =?utf-8?B?dFo5dmJ6dysreFRKN2hTOE9WU012MWhSNlUrV01xWUpLUjJEazl3aWpBK2VP?=
 =?utf-8?B?bVllNzNrNkt0UGRpYWM5NE9Nc1NNZ3lOR0EvU2dnWVFRYm5jVks3SCt2eVRU?=
 =?utf-8?B?VlZKdE5jNzRWR2V0Yk01MTlDenUyWVRXMDlrcWVrMEpqMHdvS3BFZWxJaDJG?=
 =?utf-8?B?Z1o2MlA3TTFPQW1XNEM4Wkp2MFRFLzdTUWhPS1ZtUUhNZCs5eVJvWmxBbjRC?=
 =?utf-8?B?N3k5VEt5a0U1QVN2VTFsdjlWK3g2dFArb2FERkcyR25VRGNDdHlPWUxNakRD?=
 =?utf-8?B?MEdyQ001ek1mbCtqV2srdTdkbkdyeDR6VkxsbG5qZWMrcTRXMFRiTmErNy80?=
 =?utf-8?B?WVgzWGVaUTRxQXhscmNXYXIrVkMyTFM4cXZXSW51ZnVFTm9FaTQ4TjNRSDMz?=
 =?utf-8?B?NHkrTlZGZlVOTlRsUFFmQ0R1dE8wL0NUcDUyR0tDdDE0WEVuNzgzbXJZUU1v?=
 =?utf-8?B?VGJNMUw4NVlCZU4raXZneTNGeVcvNUZYeDZiMWl2MkIySEdSblpVNmgyRDV1?=
 =?utf-8?B?a2I1TEI4cnp1dmk3NzRLVTFjaUhMT2xCd3gxWWhvc2pBV1lEa1E3SWNTVDhh?=
 =?utf-8?B?bXpEdUh0RkUwL1ByQWZDMEVZT2l0T0psUXhLTGRna0F0V0gydVBNQTZhYkty?=
 =?utf-8?B?WlFSNW0rS3c2aldhYXBWZFZsc1dNb0Rwd1FDS1hIaTZDUHAzWnpoeXNSUXRi?=
 =?utf-8?B?eGMrU2FoRVFpemhRb2VKc3dSMFpsaGQ2UzV1bHJya21uT2M2RHVUWXBOMDZF?=
 =?utf-8?B?c05IQkhtcXQ4VXRYL1RVVEFraERVUEprY1ZIRXlUdWhYTEVOeHlSeUQwZUlZ?=
 =?utf-8?B?MHppREFCdTlvbHlUeUtGL0lZREVmTGh2NFpQUlIzMEpQMzhwZm9TVDVlSkd6?=
 =?utf-8?B?dWJIbjFhUElIUWhIdmM2OGpWVUtTMzlGY1FhOG1nbnoxcE1XbWVpOXg1clND?=
 =?utf-8?B?TS83SC9kR1VMZTVMWGp5YWRkcExIY1piQ2c3cS9CVWZRNFl4M3MxVVpMbVVy?=
 =?utf-8?B?dERUMll5eFpQNDFrZ0NZdnlzczRTZ0g5amtERHc5YldBQ2djelJvSjhGcE5X?=
 =?utf-8?B?ZUQxTndQVm1ycFNselQ2QWJaZ1R1dkpJOFVXcGZWTXBLVjgyNW1JeTV3YWsv?=
 =?utf-8?B?c3Q4MDk0TVR4S3R4ejlOY3h1ODk3TWhKeVM5SndVV1V6ZkFpVXMxT2Z5V1By?=
 =?utf-8?B?T3Y2QTI1MlQ0dzd2enZkSElTVS9FU284L2dBTC9URWZpVm1ST0RnRDE3Rysy?=
 =?utf-8?Q?pEPkj1sgLGoBRLLxJm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988eed8c-daf9-4a24-e607-08dec6ec4a37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:32:09.5096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLGKFVeEtRg3YLy+VKr5+X28zWWbhQ/HO51/rsJo454ZW2Tq/DjwKdbA6gbZNwpk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

On 6/10/26 08:03, Srinivasan Shanmugam wrote:
> Queue-scoped EVENTFD subscriptions originally used queue_id as part of
> the routing key. However, queue_id is only a UAPI-visible handle and can
> be reused after a queue is destroyed, making it unsuitable as a stable
> identifier for internal EVENTFD tracking.
> 
> Rework queue-scoped EVENTFD handling to resolve queue_id to the
> corresponding amdgpu_usermode_queue object during bind and unbind.
> EVENTFD subscriptions now hold references to the actual queue objects
> instead of the reusable queue identifiers.
> 
> Use the existing user queue refcounting infrastructure to keep queues
> alive while subscriptions exist, and release those references during
> unbind, manager teardown, and explicit queue cleanup.
> 
> Introduce amdgpu_eventfd_remove_queue() to remove all subscriptions
> associated with a queue when that queue is being released. This ensures
> that EVENTFD does not retain stale queue references after queues are
> removed from the USERQ manager.
> 
> Queue-scoped subscriptions are now matched using the queue pointer,
> while GPU-scoped subscriptions continue to operate without an associated
> queue.
> 
> Also update the EVENTFD infrastructure to:
> 
> distinguish queue-scoped and GPU-scoped event types, allow eventfd file
> descriptor 0 by rejecting only negative values, validate supported event
> types, and avoid relying on reusable queue identifiers for signaling.
> 
> EVENTFD remains notification-only and does not carry event payloads.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 240 ++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  19 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |   4 +
>  4 files changed, 209 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> index 3a6e08a3d0c1..db743435605f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -24,37 +24,63 @@
>  /*
>   * Render-node eventfd subscription infrastructure.
>   *
> - * This module provides a simple event notification mechanism for render-node
> - * clients using Linux eventfd objects.
> + * EVENTFD is notification-only. It wakes userspace when a GPU event happens.
> + * Event metadata/details are expected to be consumed separately through the
> + * corresponding wait/event path.
>   *
> - * Userspace can bind an eventfd to a userspace-defined event_id. When the
> - * driver signals that event_id, all eventfds bound to it are notified.
> - *
> - * This mechanism is intended to support lightweight GPU event notifications
> - * without polling from userspace.
> + * Queue-scoped subscriptions use queue_id only for lookup at bind/unbind time.
> + * The EVENTFD entry stores a refcounted queue pointer, not the reusable UAPI
> + * queue_id.
>   */
>  
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <drm/amdgpu_drm.h>
>  
> +#include "amdgpu.h"
>  #include "amdgpu_eventfd.h"
> +#include "amdgpu_userq.h"
>  
>  #define AMDGPU_EVENTFD_MAX_BINDS 4096
>  
> +static bool amdgpu_eventfd_valid_type(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool amdgpu_eventfd_queue_scoped(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /**
> - * amdgpu_eventfd_id_alloc - allocate an event id container
> - * @event_id: userspace-defined event identifier
> - *
> - * Each event_id represents a notification category. Multiple eventfds can
> - * be bound to the same event_id.
> + * amdgpu_eventfd_id_alloc - allocate an event type container
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * This function allocates the container which stores the list of eventfds
> - * associated with that event_id.
> + * Each event_type has one container. For queue-scoped events, individual
> + * subscriptions inside the container are distinguished by the refcounted
> + * queue pointer stored in each entry.
>   *
>   * Return:
>   * Pointer to the newly allocated structure or NULL on failure.
>   */
> -static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_type)
>  {
>  	struct amdgpu_eventfd_id *id;
>  
> @@ -62,43 +88,40 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
>  	if (!id)
>  		return NULL;
>  
> -	id->event_id = event_id;
> +	id->event_type = event_type;

I think you might want to move renaming event_id to event_type in a separate patch or even into the initial patch.

It creates a lot of extra unecessary noise in this patch.

>  	INIT_HLIST_HEAD(&id->entries);
>  	id->n_entries = 0;
> +
>  	return id;
>  }
>  
>  /**
> - * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * amdgpu_eventfd_id_get_or_create - find or create an event_type entry
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> - *
> - * This helper returns the container associated with the given event_id.
> - * If it does not exist, it will create one.
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * The function is designed to be callable without holding any locks.
> - * Memory allocation is done outside the xarray lock to avoid blocking
> - * inside critical sections.
> + * This helper returns the container associated with the given event_type.
> + * If it does not exist, it creates one.
>   *
>   * Return:
> - * Pointer to the event_id structure or NULL on failure.
> + * Pointer to the event_type structure or NULL on failure.
>   */
>  static struct amdgpu_eventfd_id *
> -amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_type)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_id *new_id;
> -	XA_STATE(xas, &mgr->ids, event_id);
> +	XA_STATE(xas, &mgr->ids, event_type);
>  	unsigned long flags;
>  	int r;
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  	if (id)
>  		return id;
>  
> -	new_id = amdgpu_eventfd_id_alloc(event_id);
> +	new_id = amdgpu_eventfd_id_alloc(event_type);
>  	if (!new_id)
>  		return NULL;
>  
> @@ -174,6 +197,7 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  
>  		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
>  			hlist_del(&e->hnode);
> +			amdgpu_userq_put(e->queue);
>  			eventfd_ctx_put(e->ctx);
>  			kfree(e);
>  		}
> @@ -186,51 +210,61 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  }
>  
>  /**
> - * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
>   * @mgr: eventfd manager
> - * @event_id: userspace event identifier
> + * @userq_mgr: user queue manager used to resolve queue_id
> + * @event_type: kernel-defined AMDGPU event type
> + * @queue_id: UAPI queue id for queue-scoped events, or 0 for GPU-scoped events
>   * @eventfd: eventfd file descriptor
>   *
> - * This function allows userspace to subscribe to notifications for a
> - * specific event_id.
> - *
> - * Multiple eventfds can be bound to the same event_id.
> - *
> - * Duplicate bindings of the same eventfd are treated as success and do
> - * not create additional entries.
> + * For queue-scoped events, queue_id is used only to look up the queue.
> + * The entry stores the refcounted queue pointer, not queue_id.
>   *
>   * Return:
>   * 0 on success, negative error code on failure.
>   */
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +			struct amdgpu_userq_mgr *userq_mgr,
> +			u32 event_type, u32 queue_id, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e, *it;
>  	struct eventfd_ctx *ctx;
> +	struct amdgpu_usermode_queue *queue = NULL;
>  	unsigned long flags;
>  	bool dup = false;
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
>  		return -EINVAL;
>  
> -	/*
> -	 * Enforce total bind limit without a separate manager lock.
> -	 * For duplicate binds, we decrement back before returning success.
> -	 */
> +	if (amdgpu_eventfd_queue_scoped(event_type)) {
> +		if (!userq_mgr || !queue_id)
> +			return -EINVAL;
> +
> +		queue = amdgpu_userq_get(userq_mgr, queue_id);
> +		if (!queue)
> +			return -ENOENT;
> +	} else if (queue_id) {
> +		return -EINVAL;
> +	}
> +
>  	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
>  		atomic_dec(&mgr->bind_count);
> +		amdgpu_userq_put(queue);
>  		return -ENOSPC;
>  	}
>  
>  	ctx = eventfd_ctx_fdget(eventfd);
>  	if (IS_ERR(ctx)) {
>  		atomic_dec(&mgr->bind_count);
> +		amdgpu_userq_put(queue);
>  		return PTR_ERR(ctx);
>  	}
>  
> -	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
>  	if (!id) {
>  		eventfd_ctx_put(ctx);
> +		amdgpu_userq_put(queue);
>  		atomic_dec(&mgr->bind_count);
>  		return -ENOMEM;
>  	}
> @@ -238,7 +272,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  	/* check for duplicate binding */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  	hlist_for_each_entry(it, &id->entries, hnode) {
> -		if (it->ctx == ctx) {
> +		if (it->ctx == ctx && it->queue == queue) {
>  			dup = true;
>  			break;
>  		}
> @@ -247,6 +281,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  
>  	if (dup) {
>  		eventfd_ctx_put(ctx);
> +		amdgpu_userq_put(queue);
>  		atomic_dec(&mgr->bind_count);
>  		return 0;
>  	}
> @@ -255,10 +290,13 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  	e = kzalloc(sizeof(*e), GFP_KERNEL);
>  	if (!e) {
>  		eventfd_ctx_put(ctx);
> +		amdgpu_userq_put(queue);
>  		atomic_dec(&mgr->bind_count);
>  		return -ENOMEM;
>  	}
> +
>  	e->ctx = ctx;
> +	e->queue = queue;
>  
>  	/*
>  	 * Re-check duplicate under lock to close the race with another bind()
> @@ -266,7 +304,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  	hlist_for_each_entry(it, &id->entries, hnode) {
> -		if (it->ctx == ctx) {
> +		if (it->ctx == ctx && it->queue == queue) {
>  			dup = true;
>  			break;
>  		}
> @@ -281,6 +319,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  
>  	if (dup) {
>  		eventfd_ctx_put(ctx);
> +		amdgpu_userq_put(queue);
>  		kfree(e);
>  		atomic_dec(&mgr->bind_count);
>  		return 0;
> @@ -290,53 +329,70 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  }
>  
>  /**
> - * amdgpu_eventfd_unbind - remove eventfd binding
> + * amdgpu_eventfd_unbind - remove EVENTFD binding
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @userq_mgr: user queue manager used to resolve queue_id
> + * @event_type: kernel-defined AMDGPU event type
> + * @queue_id: UAPI queue id for queue-scoped events, or 0 for GPU-scoped events
>   * @eventfd: eventfd file descriptor
>   *
> - * Removes an existing binding between an event_id and an eventfd.
> - *
>   * Return:
>   * 0 if removed, -ENOENT if binding does not exist.
>   */
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +			  struct amdgpu_userq_mgr *userq_mgr,
> +			  u32 event_type, u32 queue_id, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
>  	struct hlist_node *tmp;
>  	struct eventfd_ctx *ctx;
> +	struct amdgpu_usermode_queue *queue = NULL;
>  	unsigned long flags;
>  	bool removed = false;
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
>  		return -EINVAL;
>  
> +	if (amdgpu_eventfd_queue_scoped(event_type)) {
> +		if (!userq_mgr || !queue_id)
> +			return -EINVAL;
> +
> +		queue = amdgpu_userq_get(userq_mgr, queue_id);
> +		if (!queue)
> +			return -ENOENT;
> +	} else if (queue_id) {
> +		return -EINVAL;
> +	}
> +
>  	ctx = eventfd_ctx_fdget(eventfd);
> -	if (IS_ERR(ctx))
> +	if (IS_ERR(ctx)) {
> +		amdgpu_userq_put(queue);
>  		return PTR_ERR(ctx);
> +	}
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	if (!id)
>  		goto out_unlock;
>  
>  	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> -		if (e->ctx != ctx)
> +		if (e->ctx != ctx || e->queue != queue)
>  			continue;
>  
>  		hlist_del(&e->hnode);
>  		id->n_entries--;
>  		removed = true;
>  
> +		amdgpu_userq_put(e->queue);
>  		eventfd_ctx_put(e->ctx);
>  		kfree(e);
>  
>  		atomic_dec(&mgr->bind_count);
>  
>  		if (!id->n_entries) {
> -			__xa_erase(&mgr->ids, event_id);
> +			__xa_erase(&mgr->ids, event_type);
>  			kfree(id);
>  		}
>  
> @@ -346,27 +402,75 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  out_unlock:
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  	eventfd_ctx_put(ctx);
> +	amdgpu_userq_put(queue);
>  
>  	return removed ? 0 : -ENOENT;
>  }
>  
>  /**
> - * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * amdgpu_eventfd_remove_queue - remove all EVENTFD bindings for a queue
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @queue: queue being destroyed/released
>   *
> - * This function is typically called from interrupt context.
> + * Remove all subscriptions that hold a reference to @queue.
> + * This is called when the queue id is released so EVENTFD can drop
> + * its queue references before the queue is finally destroyed.
> + */
> +void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
> +				 struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	struct hlist_node *tmp;
> +	unsigned long index;
> +	unsigned long flags;
> +
> +	if (!mgr || !queue)
> +		return;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	xa_for_each(&mgr->ids, index, id) {
> +		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +			if (e->queue != queue)
> +				continue;
> +
> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +
> +			eventfd_ctx_put(e->ctx);
> +			amdgpu_userq_put(e->queue);
> +			kfree(e);
> +
> +			atomic_dec(&mgr->bind_count);
> +		}
> +
> +		if (!id->n_entries) {
> +			__xa_erase(&mgr->ids, index);
> +			kfree(id);
> +		}
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +}
> +
> +/**
> + * amdgpu_eventfd_signal - notify all matching eventfd subscriptions
> + * @mgr: eventfd manager
> + * @event_type: kernel-defined AMDGPU event type
> + * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
>   *
> - * All eventfds registered for the given event_id will be signaled.
> - * Userspace processes waiting on those eventfds will wake up.
> + * This can run from IRQ context. The queue pointer must refer to the actual
> + * queue object, not the reusable UAPI queue_id.
>   */
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			   struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
>  	unsigned long flags;
>  
> -	if (!mgr || !event_id)
> +	if (!mgr || !amdgpu_eventfd_valid_type(event_type))
>  		return;
>  
>  	/*
> @@ -375,10 +479,12 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	if (id) {
> -		hlist_for_each_entry(e, &id->entries, hnode)
> -			eventfd_signal(e->ctx);
> +		hlist_for_each_entry(e, &id->entries, hnode) {
> +			if (e->queue == queue)
> +				eventfd_signal(e->ctx);
> +		}
>  	}
>  
>  	xa_unlock_irqrestore(&mgr->ids, flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> index 248afb1f2f14..9ea3283e92bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -32,13 +32,17 @@
>  #include <linux/xarray.h>
>  #include <linux/atomic.h>
>  
> +struct amdgpu_userq_mgr;
> +struct amdgpu_usermode_queue;
> +
>  struct amdgpu_eventfd_entry {
>  	struct eventfd_ctx *ctx;
> +	struct amdgpu_usermode_queue *queue;
>  	struct hlist_node hnode;
>  };
>  
>  struct amdgpu_eventfd_id {
> -	u32 event_id;
> +	u32 event_type;
>  	struct hlist_head entries;
>  	u32 n_entries;
>  };
> @@ -51,9 +55,16 @@ struct amdgpu_eventfd_mgr {
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
>  void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
>  
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +			struct amdgpu_userq_mgr *userq_mgr,
> +			u32 event_type, u32 queue_id, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +			  struct amdgpu_userq_mgr *userq_mgr,
> +			  u32 event_type, u32 queue_id, int eventfd);
> +void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
> +				 struct amdgpu_usermode_queue *queue);
>  
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			   struct amdgpu_usermode_queue *queue);
>  
>  #endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f7c750094393..0db128def289 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -649,22 +649,32 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  	if (args->flags || !args->event_type || args->eventfd < 0)
>  		return -EINVAL;
>  
> -	/*
> -	 * Queue-scoped subscriptions are enabled by the later queue-reference
> -	 * routing patch. Until then, keep queue_id zero.
> -	 */
> -	if (args->queue_id)
> +	switch (args->event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +		break;
> +	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
> +		if (args->queue_id)
> +			return -EINVAL;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}

Doesn't that duplicate the functionality of amdgpu_eventfd_queue_scoped() ?

In general I think it would be cleaner if you convert the queue_id into the queue pointer here.

Same could be done for eventfd.

Regards,
Christian. 

>  
>  	switch (args->op) {
>  	case DRM_AMDGPU_EVENTFD_OP_BIND:
>  		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> +					   &fpriv->userq_mgr,
>  					   args->event_type,
> +					   args->queue_id,
>  					   args->eventfd);
>  	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
>  		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> -					     args->event_type,
> -					     args->eventfd);
> +						 &fpriv->userq_mgr,
> +						 args->event_type,
> +						 args->queue_id,
> +						 args->eventfd);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 376813e9623f..45981adbd7d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -869,6 +869,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		if (!queue)
>  			return -ENOENT;
>  
> +		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
> +
>  		amdgpu_userq_put(queue);
>  		break;
>  	}
> @@ -1229,6 +1231,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		if (!queue)
>  			break;
>  
> +		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr), queue);
> +
>  		amdgpu_userq_put(queue);
>  	}
>  

