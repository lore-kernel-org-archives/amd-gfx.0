Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961F4CD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E1D11A884;
	Fri,  5 Jun 2026 13:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XxLGu2q6";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E0411A884
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L29aEiZMchxErGazXA4mPecriP8SnKgKW9yZSwWJFuCSwXIQhMokpSFYU7aVNTdBeUldh1HG4xryWRrS6MYTP0wDykXHnE2yF2IwaqBvI2ruxnJOTKitI6BhZgd+VPcKo5xpvHbYUD3oXAlQuWEwB6WCHrZyY//ixBdx4uuiTn4fXJWcoze92AU/vzaL/YDdWPdNA/EsmcT9h6szDK7+pczZOiD9/u5vutw2UP8U8fYR4SG691+fB2s3jvzRPYqJSUFISDtwldKEitaH4fmVd6Fx/NYdNJNQfNSGruMMtdcu1CoZjwpmoyOnq+f5DfFb1P+DAVAoMRoGCdqjmpFCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjePLeWCAh46yB2dlOg25GZBh6fmHoiEYc2gjhLa8cg=;
 b=w7yFcdNQqURkYvdT3XcH7Snwe0cBBLCezrr+1n2aOY1vNxnB32wORh9cucjdQIvlggWrGZ3SCeNgxn9YUvjaASuJXFkvGrZAOdI1NiH2a4GrK15+YnK6zmeTPn2Ey0DXk+SwSdhVHaoTYETCqNLs+qZBn218hdvsT3rK8L7Lc2Lq5n6wqDLYBCAEg0FPAoJHHjo16oW0dlKvfr2Val/7JGyoGFoq8n0FTN2BnGlbaTCs2MYGYXqOjohbGsEpFk82xJHjlwB1RtAJEB8tbI6U9UZhaHqX0XIZTyts0FALm/maEwRe5lgK61p9WcS5wev9yRuqXzTNAK9QwFN8u9vtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjePLeWCAh46yB2dlOg25GZBh6fmHoiEYc2gjhLa8cg=;
 b=XxLGu2q6eVViQMYrkqKNffLA+4zFeNrZ4N+1zYFlkV2qEv1sm5Ebpp+RY+HEluY0y3RLhcagFiZfAq8PqlXb6SJkp18uARjHx1LxoRSIOsy7J5m9/UMItCIZ2NfUcN3cdCDnj8fe1njrg8caHClWDdinpSS5Wt5Lv+/e51enKls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:26:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:26:14 +0000
Message-ID: <b3445b69-2f52-4b22-974a-7bfc2be2b9d5@amd.com>
Date: Fri, 5 Jun 2026 15:26:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] drm/amdgpu: Make EVENTFD subscriptions
 queue-aware
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
 <20260603163350.2678309-7-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260603163350.2678309-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3012c525-290d-4b39-bed4-08dec306046e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vxI4G07BzOQPzH5/TEapVys6SSHqRZgVYyzJ+jB9uZN90k9AC8SI9UN8pUnlITqWX7/2IU5SMH24brQTB4OZmLzHcdkH+8/W8AmNKVEy0aAl3IA3cbguA8WX2U8bGYl72lEtm1MrJqRto+K6F54gK2DvmGwR1J60eAlhJ+lQQXfAm6nk/zGhb/U/pL+d96cGCnlZLskJEUOzDvO26pRlue6htqsJAZbHk5K0XokuMDNOxYJzvLiPTMSeNOd+JjjZzqgNpB2d+Hr5ZcjEcC+JNggtzKxNL/oLUiZDNr9GAbXHVCM02pYnHsv8350qlWJ3E/MmYJYSmjoKkPmWUEvI2Q1LCqfgi6bK4jvM1NG/PJhUQBSzECnfv3jDYJv/fJTS+Tkqj+X8RXsyqtU9CuThvmT5AaM++/OI0nSnnx0rBm7O/pvjmlL4Ig2uNgL31xvJ3U2+EMN7ZuFJ/iy3WshIosWF9InrsdUyQBhYVCh3v9RcHE/tAzUBJYzDyM2j132HIrXejRBfdyKMt26UOBHTKh5bH5WoV0vC23k5GgsyHFKCdsyH0BL4lyNQiyB4p1HTcLyLqQ5nn3AZvO0QYxSaut8LsbYUsVRQRhhLxrClgQgCm2tjMMSFdAdfavnyJhEy0Kd5sSHtn/vZWyYjZ1HWXaZNabD4PbTsU7CCeU63ZcPZ3670XwDTivnWh92QDW7r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFBqUERnYUhDREVmOTl6ZCtVdXQyUmwrbUFWbGVWcWVFeTJBeEozdFcrWWJx?=
 =?utf-8?B?bzNZZ05sT2kyUGJ6cnVoRkRnaW13UTEycytQR1lvY3hsbE1ZKzNzeTFwcDFK?=
 =?utf-8?B?TEJkazQwcXNZUHpNYThXYjZwMDBWWXNmMkFKSEkwOXlpdUtjQVc1YVpLQUkz?=
 =?utf-8?B?dm9BTzF4ZGVpZUVBdmd4ZVRHUGhuSzNhTjlPSWVnZkMvSU5WMDgyaGprZEIx?=
 =?utf-8?B?Rm5jZ1loTWJIbGQzU2Z4TnZMR2xIbkdBK1dGSXh3b05YMnJVVFBmSzJNSWVv?=
 =?utf-8?B?TzBycFlmcGRGSW9jL1A5b28ybHFDYzVyRUhueWw3eXBCLzJCbHY5WktSc3dE?=
 =?utf-8?B?aHFQNGxFUFltTVpCanVOeHNIczkxNG04dmRFT3o5bjVUUXFxRi9XVVJ2eEhh?=
 =?utf-8?B?YjJ5NGtqZEEwbXgvUnFyQU1lZ3MxTWI0MkhPakE0Qk1Wazl6c0QxVmJVdlhL?=
 =?utf-8?B?UmpCTWxSdTFVVTZOV3NNazFlSC84OFZZY3NmYlZwdWZOWERVTmFCNHBSNkRY?=
 =?utf-8?B?N0dlVno4ZHVYbDIzZlJhbkFPVDMwQ3JUMGE5a0pLL1M3c1N4Ymtmb0tWdS9E?=
 =?utf-8?B?ekR1b3grVVhVM3hjclpVaytuaFlrV0RPZWtac2RlSm5yOGFrMG5iSC93TStn?=
 =?utf-8?B?QVNrMzE4bnhHM29rdnZaVW5kbU51UWZiMUtIR2pEczYvazZhekZ1MGRYYUkx?=
 =?utf-8?B?WjlCQjVsWDFRM05udjIrTFJVOTd5L0ZMc0gxZEdjZlNXSStFelk2bS8yRG9a?=
 =?utf-8?B?TWJmTkUweWphZlEvVTdsaFljdGo4cjNaZityZ3Fqc29zMVo5VVZmMjFZN0Ru?=
 =?utf-8?B?Y2hMM09lUEliQ092ZitHenBGSCttSHBTc0Y4U2k4d3VLbG90cEVpU3hReU1o?=
 =?utf-8?B?bGg1V1Y2bXAvZ1d4WkFmTUxSLzV6RC9lUDRlSHhqUm1vYzZmdGc3OEZncFlD?=
 =?utf-8?B?VjNPN0xhOUJFR0YxRDhDMUp6WlhiRGxhNVp5aGdhMVF0ZjFHSitpN0dRbXo4?=
 =?utf-8?B?Z3B2eURBNmFIR1RFakpSWDBBalJlQnFwK0ZZcWdpZWJBaWxtVjNVdkpuMWgz?=
 =?utf-8?B?UmN0eEE3YzZwdEFxamVYN2dHdjRJR09FbHRLcG1WZjJ4dUdUZFcvSVBQbzkw?=
 =?utf-8?B?Nkc0bUVQUjd1K0VOb1NMWmFSMXlKU0FxcHZTcnl1aGQ3R2l6R1lTdTBRZFpt?=
 =?utf-8?B?ZnNjTWlYK1FEYkdRSEwrWURVdkRvR25Ic3FYalJmbnBETFlMZTF5Y0lFRzRN?=
 =?utf-8?B?WWtNMEdPMGtZb0QzYk9RcS94UmJPVDZIcmtYaGxOc0lFQWdUb0daOEtzdnBO?=
 =?utf-8?B?RDNuR0ZDK1hiMVJXdUwwWkRrUzZOWFVqSWlXYlNTL1JOenhIZ2dJR05PcGhX?=
 =?utf-8?B?Q3prMGc5dVoxV3QzSG9OM0hBMzVPdnlIekUyanRUUG95MXpuZml5TnpoT3p0?=
 =?utf-8?B?UnZvRkl3VGZyQ2dMV2p1cDhkNjZHVnh5cGJSek90NDhuSVA2OWdEVTJxaXRV?=
 =?utf-8?B?RGttanBkYWp1SmpSMGFaSm9mWnhtdzN0S1BnM2hLSk9NQ0pkcEdaRDZ1a2xD?=
 =?utf-8?B?NmpnemR5UHNiUHhwUzBDTCtGZ0FqWWFEdGtrdzJCOEFGdHpINmFkVG9pK2xC?=
 =?utf-8?B?M3h0bXM5cGRtSUI2SjRaNm85NmNZYURiYWVhODQvK0hQelhpY1M5R2hONHk0?=
 =?utf-8?B?eHd4M3p1RytVeXRyQm9SYXZzTmJPbVpnK0Ixb1h3VHR1NXMyQVFMVmtzNEZ6?=
 =?utf-8?B?T2UweUlrNStLVVBxWC9ROVdudEN1Q3hUd0J0SU9zUVFiL1NPTElQck5zUUh4?=
 =?utf-8?B?aWppdGRReHZWZ1YvL0VHdExSUkVXRGdRSDhqVkN0WVJxOFl4Nm9IRFVYMWI0?=
 =?utf-8?B?aHVDNDR3RkFXbzNXMmhKa21Eb0lhb2FaNTNaUnNSMy9IUllZMzdiK05uVFBQ?=
 =?utf-8?B?a29LV2xXS3RWeXgyVWZKTlk4UCs2TWUvQTl4anNRbWdsajlxNGptREgyMDV6?=
 =?utf-8?B?eGMxaGtwc2hBelRSWnhPWUtieXE2N0pHcVduRUp2Yy80VmxVK1REbWRJTmpu?=
 =?utf-8?B?Y29hbzNFeEpPVmUvNUFKY3E5Y0dpZkRNMHEzQTFSWWQzWXlOQlZvL3MyQUlq?=
 =?utf-8?B?cGNPNDN4WlpTdHhiQWtaUkM5cnpQV1h5cTROaVp4U0p2YW1OZ3pGeVJWOS9q?=
 =?utf-8?B?bXVQd1BudjZXZEtCZzdiWjVFWGRJb1JDUXZvUXF2Sk5uZk9oTDlEb2ZpSkZk?=
 =?utf-8?B?Y21SbnpsbVZlNko0L3BWbXU0SU1yaks0RUk1RkV4RC9xTzIxRDhaWUI0YWxw?=
 =?utf-8?Q?oOhAWFLGyxCjIn09X6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3012c525-290d-4b39-bed4-08dec306046e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:26:14.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsRjd1CrT1LngJ31C++sIcBYwvpcvu5TIBvo6hQfV05jEpaxNO6jD9alYxcxHKcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
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
> The current EVENTFD manager matches subscriptions only by event
> identifier.  That is enough for coarse notification, but it does not
> support the queue-scoped routing needed by queue completion style
> events.
> 
> Extend the subscription key from a single event identifier to the pair
> (event_type, queue_id).
> 
> For device/GPU-scoped events, queue_id is 0.  For queue-scoped events,
> queue_id selects the queue-specific subscription.
> 
> EVENTFD remains notification-only.
> 
> Also fix the queue-aware bind path to compute the packed subscription
> key before lookup/insert, and allow fd 0 by rejecting only negative file
> descriptors.
> 
> This change keeps the existing manager design and binding model intact,
> while making queue_id meaningful for queue-scoped wakeups.

Yeah that doesn't work like this.

The queue_id is just an identifier for the UAPI and can be re-used.

So you can't put that as key in the amdgpu_eventfd_id structure.

I suggest to convert the queue_id into the global doorbell id or put the eventfd manager on the queue itself instead of the fpriv.

Regards,
Christian.

> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 92 ++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h | 16 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 20 +++--
>  3 files changed, 86 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> index 0b0c9268aedc..fefc85ca916e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -36,25 +36,39 @@
>  
>  #include <linux/slab.h>
>  #include <linux/err.h>
> +#include <drm/amdgpu_drm.h>
>  
>  #include "amdgpu_eventfd.h"
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
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /**
>   * amdgpu_eventfd_id_alloc - allocate an event id container
> - * @event_id: userspace-defined event identifier
> + * @key: packed (event_type, queue_id) subscription key
>   *
> - * Each event_id represents a notification category. Multiple eventfds can
> - * be bound to the same event_id.
> + * Each key represents one subscription category. Multiple eventfds can
> + * be bound to the same key.
>   *
>   * This function allocates the container which stores the list of eventfds
> - * associated with that event_id.
> + * associated with that subscription key.
>   *
>   * Return:
>   * Pointer to the newly allocated structure or NULL on failure.
>   */
> -static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u64 key)
>  {
>  	struct amdgpu_eventfd_id *id;
>  
> @@ -62,7 +76,7 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
>  	if (!id)
>  		return NULL;
>  
> -	id->event_id = event_id;
> +	id->key = key;
>  	INIT_HLIST_HEAD(&id->entries);
>  	id->n_entries = 0;
>  	return id;
> @@ -71,9 +85,9 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
>  /**
>   * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @key: packed (event_type, queue_id) subscription key
>   *
> - * This helper returns the container associated with the given event_id.
> + * This helper returns the container associated with the given key.
>   * If it does not exist, it will create one.
>   *
>   * The function is designed to be callable without holding any locks.
> @@ -84,7 +98,7 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
>   * Pointer to the event_id structure or NULL on failure.
>   */
>  static struct amdgpu_eventfd_id *
> -amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u64 key)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_id *new_id;
> @@ -92,19 +106,19 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
>  	int r;
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, key);
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  	if (id)
>  		return id;
>  
> -	new_id = amdgpu_eventfd_id_alloc(event_id);
> +	new_id = amdgpu_eventfd_id_alloc(key);
>  	if (!new_id)
>  		return NULL;
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
>  	/* Re-check after taking the lock in case another thread inserted it. */
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, key);
>  	if (id) {
>  		xa_unlock_irqrestore(&mgr->ids, flags);
>  		kfree(new_id);
> @@ -115,9 +129,9 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
>  	 * xa_insert() returns -EBUSY if an entry already exists.
>  	 * Since we are in irqsave context here, use GFP_ATOMIC.
>  	 */
> -	r = xa_insert(&mgr->ids, event_id, new_id, GFP_ATOMIC);
> +	r = xa_insert(&mgr->ids, key, new_id, GFP_ATOMIC);
>  	if (r == -EBUSY)
> -		id = xa_load(&mgr->ids, event_id);
> +		id = xa_load(&mgr->ids, key);
>  
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  
> @@ -190,13 +204,14 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  }
>  
>  /**
> - * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
>   * @mgr: eventfd manager
> - * @event_id: userspace event identifier
> + * @event_type: kernel-defined event type
> + * @queue_id: queue identifier, or 0 for device/GPU-scoped events
>   * @eventfd: eventfd file descriptor
>   *
>   * This function allows userspace to subscribe to notifications for a
> - * specific event_id.
> + * specific (event_type, queue_id) pair.
>   *
>   * Multiple eventfds can be bound to the same event_id.
>   *
> @@ -206,17 +221,21 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>   * Return:
>   * 0 on success, negative error code on failure.
>   */
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			u32 queue_id, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e, *it;
>  	struct eventfd_ctx *ctx;
> +	u64 key;
>  	unsigned long flags;
>  	bool dup = false;
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || !eventfd || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
>  		return -EINVAL;
>  
> +	key = amdgpu_eventfd_key(event_type, queue_id);
> +
>  	/*
>  	 * Enforce total bind limit without a separate manager lock.
>  	 * For duplicate binds, we decrement back before returning success.
> @@ -232,7 +251,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  		return PTR_ERR(ctx);
>  	}
>  
> -	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +	id = amdgpu_eventfd_id_get_or_create(mgr, key);
>  	if (!id) {
>  		eventfd_ctx_put(ctx);
>  		atomic_dec(&mgr->bind_count);
> @@ -294,9 +313,10 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  }
>  
>  /**
> - * amdgpu_eventfd_unbind - remove eventfd binding
> + * amdgpu_eventfd_unbind - remove EVENTFD binding
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @event_type: kernel-defined event type
> + * @queue_id: queue identifier, or 0 for device/GPU-scoped events
>   * @eventfd: eventfd file descriptor
>   *
>   * Removes an existing binding between an event_id and an eventfd.
> @@ -304,25 +324,29 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>   * Return:
>   * 0 if removed, -ENOENT if binding does not exist.
>   */
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			  u32 queue_id, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
> +	u64 key;
>  	struct amdgpu_eventfd_entry *e;
>  	struct hlist_node *tmp;
>  	struct eventfd_ctx *ctx;
>  	unsigned long flags;
>  	bool removed = false;
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || eventfd < 0 || !amdgpu_eventfd_valid_type(event_type))
>  		return -EINVAL;
>  
> +	key = amdgpu_eventfd_key(event_type, queue_id);
> +
>  	ctx = eventfd_ctx_fdget(eventfd);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, key);
>  	if (!id)
>  		goto out_unlock;
>  
> @@ -338,7 +362,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  			atomic_dec(&mgr->bind_count);
>  
>  			if (!id->n_entries) {
> -				__xa_erase(&mgr->ids, event_id);
> +				__xa_erase(&mgr->ids, key);
>  				kfree(id);
>  			}
>  			break;
> @@ -353,31 +377,37 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  }
>  
>  /**
> - * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * amdgpu_eventfd_signal - notify all eventfds bound to subscription key
>   * @mgr: eventfd manager
>   * @event_id: event identifier
> + * @event_type: kernel-defined event type
> + * @queue_id: queue identifier, or 0 for device/GPU-scoped events
>   *
>   * This function is typically called from interrupt context.
>   *
> - * All eventfds registered for the given event_id will be signaled.
> + * All eventfds registered for the given subscription will be signaled.
>   * Userspace processes waiting on those eventfds will wake up.
>   */
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			   u32 queue_id)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
> +	u64 key;
>  	unsigned long flags;
>  
> -	if (!mgr || !event_id)
> +	if (!mgr || !amdgpu_eventfd_valid_type(event_type))
>  		return;
>  
> +	key = amdgpu_eventfd_key(event_type, queue_id);
> +
>  	/*
>  	 * IRQ-safe signaling path: keep xarray lock held while iterating and
>  	 * signaling. eventfd_signal() is IRQ-safe.
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, key);
>  	if (id) {
>  		hlist_for_each_entry(e, &id->entries, hnode)
>  			eventfd_signal(e->ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> index 248afb1f2f14..6e7eb513fbc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -38,7 +38,7 @@ struct amdgpu_eventfd_entry {
>  };
>  
>  struct amdgpu_eventfd_id {
> -	u32 event_id;
> +	u64 key;
>  	struct hlist_head entries;
>  	u32 n_entries;
>  };
> @@ -48,12 +48,20 @@ struct amdgpu_eventfd_mgr {
>  	atomic_t bind_count;        /* total binds across all event_ids */
>  };
>  
> +static inline u64 amdgpu_eventfd_key(u32 event_type, u32 queue_id)
> +{
> +	return ((u64)event_type << 32) | queue_id;
> +}
> +
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
>  void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
>  
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			u32 queue_id, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			  u32 queue_id, int eventfd);
>  
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_type,
> +			   u32 queue_id);
>  
>  #endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 75fc3a74db28..22dfd22210c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -646,21 +646,27 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  	if (args->flags || !args->event_type || args->eventfd < 0)
>  		return -EINVAL;
>  
> -	/*
> -	 * queue_id is reserved for future queue-specific subscriptions.
> -	 * Keep it zero for now.
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
>  
>  	switch (args->op) {
>  	case DRM_AMDGPU_EVENTFD_OP_BIND:
>  		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> -					   args->event_type,
> +					   args->event_type, args->queue_id,
>  					   args->eventfd);
>  	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
>  		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> -					     args->event_type,
> +					     args->event_type, args->queue_id,
>  					     args->eventfd);
>  	default:
>  		return -EINVAL;

