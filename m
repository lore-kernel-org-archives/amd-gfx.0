Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0F2CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5A310EE24;
	Thu, 11 Jun 2026 10:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4m2gd9sg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C1310EE24
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 10:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moajYWvlUcVs3+i+zR2Yqv24MlIDa78HCjaxvlFWEzEg3/tfp9kgFYlrCqjKBJlEBvEl4Jq8igB2I7hfg6YCQDANiDosx9VqTp9zWr8jtNH11S2/QZgoA4PBWzZd3E0jBONp2ZDyAed8AgiN8pKx+8clHKvVvLiAl7zKeJh6HLCwKaJeZ0WFuXYOPuRPPV/gQ5PoGD9bgxDeZc5UvTzxn5B6wjoKN3q8epql6Np25MjX/1WfDUcAOZkwihK61pNNZGIbuGd4QifEXIZryFuChrRTMj6uJdBcgyHnEHypXdAznYZVYrqJLoA+d+z/bHYM5AX6rFAr2rZA383SvxJbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svT3ItttbHUNieDpacEr3SNtyzvgxO01Nqkn/jc6BlM=;
 b=JoPC83lyTYvnWrvaqGsn0NO44DX5Pknb4U7/lNdwRc1XOSXifkmEAoiKqPTrmjIHp+AlNMXE+RYJvhXiXmvjz/ET7mYdLvEj3qqbe/hXY03QRFCdc7quBeapL3HZPLV+KRcr8o4DjdoT5GL1GvBt0NH94GJJ4bwy9zyekYdE+eVJK6cwVN9GmtEMQH6MRvJgdA9a9Ls17LAYLcK9+dfKfKdlVqR8w1nBAf5PF5DYLkKff2B0NeGf3szjcQHzTsoF4TZ+eYLbRQ3mkFLyMZkyvCtriK5IwdSaNJJIWwBuZ4icyGUboZO9d46wnEKcjQ+KF6OgowXow/Lr8c/VOZ+sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svT3ItttbHUNieDpacEr3SNtyzvgxO01Nqkn/jc6BlM=;
 b=4m2gd9sgeiE5BACBgrkUumRnSrtH1mvqApxClH3W1rivyNy7dO6hENXIMvyQfU4J6rL8410t4yZenFCB7Jn2wERZXT3G0sLYBPDwaId4GPn7jYw0aKSW9//otCaHRzeeJ0kfrvTuxGNBgv9fKi0EJaBlT43wGPAB8h0guFAG5LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:28:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 10:28:52 +0000
Message-ID: <2973b6fa-9bef-4a3f-9bda-0eb45111fce8@amd.com>
Date: Thu, 11 Jun 2026 12:28:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/5] drm/amdgpu: Use queue references for queue-aware
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
 <20260611072644.2856170-6-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611072644.2856170-6-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: a3772eb8-9759-4e82-c10f-08dec7a43b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DJ6m5lbpwcvOOjxdQmxOLxIFGyWPfIq1EMlhCorzppyNsdgd5Rb/4iC3AT2QxSDb20Vt8gwj7qpAQ8MInb4/1++2adQ+/C8YI4EV30sMd/0/t+HhAgED7NqJls0EF9BamOfGQ4yqFcEEi6mbfKqgBHGikYv3GTvNHo/v3y+D5+EA1groPFg09tLPnaoNb1tX5byF+DA9Z3mwdxz+kcTktVCNOnAxodk7JSerVat+B3QyqTqnPHzyBck+LRE5DaITbgYP4TeitX2QUg7rmH3xbqTB0cYnPVpig8JBnabtvFSFR0dIFsfhYp6Dbujl7g2usQSCsi3jB+xoloxf7MbU/B/LJO8XfMx9wwrZY2ZB3aZ3TBre53T7VNTBfSPmD3XrE8lLDJinpXEnzCMi8ayllrx+Kw7fuEynS6r/uiCvxScvhy6vz95tVqEU10luXrrEyva4Cm+E1fhNk2/RP0iktX1wHzBzgX6/DEPSsw8mByjGSs7wa7QZaiugZmfUqkoE/I7p0n62x4U1w7NjA7UpMK5QZRak3OI0HYyiaXgtmJRzGV5zBt8pCQl5w62PtKs8mGICAtSBIq1buAbwm2QZAK8W90eWgsIm11KuSVJzyTeJex45iap+dBHn2HC9iiDp3wfUmMNTzgUMnE/Yb4Vgc4w/LXDp0WmyDwSPsmxP8ZZci3VpqI16oD2G3TfzOwiR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NmSWtUczVDYVBhMU5RVFR1Wm9SOFVIQ1VJNmlmcFA0dUpEZzBmTUxNY2Qv?=
 =?utf-8?B?a0dQU1ZTbnU4MHYzTlN4SE5ub3dkd3BRb0JWbDcybkZnSnJqUnJRNWFqM1Bk?=
 =?utf-8?B?V3hBVkZsd1VYalhrcHBkNVhGMWZNak45S3RlemxWQVVGYmxIN2pzNEt2a0RO?=
 =?utf-8?B?RmxPMEtIRlpGVVRQKzVZMlErMFc4WjlKNENvLzVRVmYwQXpocUlHMFZQZXdJ?=
 =?utf-8?B?d0w1c3JnTkY0MGFhc2tRV0VHVitYV25nRExKbzk0OVViUkd6OGFxMXVxQ3U0?=
 =?utf-8?B?bFZPYWE2MGo5bW1XOFNRV2xSb3p2d3pTUWNiSEpVaXlLWVZFN2R1cTlobERZ?=
 =?utf-8?B?ZGdlYWVCdDlKSjdwOUZpeGxLOEI0eFpJdnpzME1tL2VFVEhlcjQ3OVJrbG5K?=
 =?utf-8?B?aGxIR2xsN1QwRmgrU3ZXeUszVEVVL1lWekVQazNpbFJjbDB2QktLQklIVWJr?=
 =?utf-8?B?RTFQc3pqUzM3UmxUMWgycXFzM1hPcjF5N2x1VmRyVTBRbHlaTGJSK0EzRVFR?=
 =?utf-8?B?S2VMd1VMVlFBLzRGU2twRjhzdnlOYmEremFrcnBHSklnV09BejdCLzljQmhz?=
 =?utf-8?B?akdxR0d3YTRESTFFQXpsRTFHS1E1ak9UcEFPWVMraWNxRlg1WUR4Q3o1Titp?=
 =?utf-8?B?RytvWGZ6WjluZFRwdDRhakVTMERsN0FqMjd5SUFkcGhyQnFYQWZQUVo4cC9q?=
 =?utf-8?B?NnVFSVdNdStsUDIzWlR2Z1QzYms4alFsQVlEdkJSQzVQd2g0Z1FwQjBKMTJp?=
 =?utf-8?B?ci8wYkY3YlRWT0EwN0s2WjNidE13TUlBV1hwdmt4M05hSWRNSExqcEFRcjNn?=
 =?utf-8?B?c3JUZWpyRTh2bGo1NFhoeTdNeno4TGoxd05qdTVwaFg5SS9XelhDcTJXdnlE?=
 =?utf-8?B?YkNuSzhRS2JOYVpJNXBpRllHSjUxbE5IUHFOZWR5Qlh5VHNBcmdXaDY4Zkk3?=
 =?utf-8?B?Nko0ZlhyNUVZbWJ6TmM2a1dzSlN6ckJHQkpvYzJOd25KblRsUFdrRzdpZGQx?=
 =?utf-8?B?cHgwTUpFTWRVYVM4aThNTWRGcURMeGZnbUZLYmxsUi9rYlJZMVVnaU02Vlg0?=
 =?utf-8?B?M1dONmkwb0pHUkxadEF0K0pVcEd0QlpWaGZkN3NxcW5MWHduM3A3a2hjc0ha?=
 =?utf-8?B?dllOZzhmQ0JUUG1tT2h3VnpnOHNYT1ZERU9Sd1pjeTBuYkFGelpxb2l5T0o5?=
 =?utf-8?B?M1I2V0pEemhBOC9OemZvWVdQVTZEVzdoZU1PQUFheENnZ0djSkQ1SEZxTlN2?=
 =?utf-8?B?RkRieXhqVExVMzhRaHlSZitUTGpYNG5hL1MwdnRHK0lnM0F5bHBpcms5OUsx?=
 =?utf-8?B?Wnhyc0NJMWd5VmhWNGJtOGR5L2s3bFVrK0lhdVh3WE9NbWVNc2xpdEx5YXNO?=
 =?utf-8?B?UUZDR0o2YW1uTWw5Yi8zTFpSTEU0bElFd1pjblJheUJxYjJVODJLVEY2cXh3?=
 =?utf-8?B?aVYxSTNNQjIvOGkwQnc1RVdva21JN2w5MW1lUk11MDFpV0R4UTFhMldWWEhS?=
 =?utf-8?B?ejdFYk9VN0h4b3dJQmdVZEhoTVlydWtlWGw3VFlRMUFySUZVYTF5MldGckxh?=
 =?utf-8?B?aTR5SGp4ZHFWZjRyUXdPRWtDZ1llVmRpUUxUaW1rbllHUUNURkdCTml2Z2No?=
 =?utf-8?B?WmFwY1lKRG5XTE9RL2RKckpOanFkcUJZMnBaZk5HL1ZNQ3RyOGFGaUdOVXJx?=
 =?utf-8?B?Q04xcXgxV2wvTlJoTmR3T2pQaCtmcE01eStCVU82YXJKVWpsY2NTYTlXQ1Rk?=
 =?utf-8?B?THlBTlBXQTJrMU0vUnl6WEQ0SXd0N2w1Q1Q1SnRJQy9IOC92Yk9PVC9vNk13?=
 =?utf-8?B?WGNxbWdWek83cElaM1pQN2VsM0ZMR1orNWNyb0ljSk9GcGJhZmZnMlNRRnpX?=
 =?utf-8?B?UHNDRUlOWXViRkF1S01LcXR3WnptS1JsRnBUV3Z2Rm5YMHlhZkxsNGpDNFh0?=
 =?utf-8?B?cENMWGVmTEpWYXhmbXZTMnl6bG9ESXpBNlJ5K3cwNVZlUzFxMTZzbWJqWkl4?=
 =?utf-8?B?dUpLTWw4WGdJa3BoQ3RNYitvdVRpbGk1K0lSQndCN1lnQlJqRjZCUGZXMGln?=
 =?utf-8?B?OVltS2JQMEl5cDZxTWcycCt1U2tYYjlnUUN2M3ZPUWc5bUE0T1dlM0kycHhq?=
 =?utf-8?B?NkowazE0UndSUUY2L3NIdGh4ZVk2WWV1ZE44akx6S2RVZzlONXhheW5yazNk?=
 =?utf-8?B?NFpLdjRqUy9UMUk1NkEvL2hramhrNlpmWk1IT2MvYkdncDkvSm8zdTV4REtr?=
 =?utf-8?B?L1NHKzZhOEVtQ1NnaDJmMFdKVDdrT1pNTmZVTFBZWGx6Y2VidUJ0RDc1WlhN?=
 =?utf-8?Q?lto3AW/PjTXxN0gVGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3772eb8-9759-4e82-c10f-08dec7a43b85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:28:52.2282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubqzQvk9A+cKdaTq2sStcT0o916qY00+py+SagOgcGZ0X8dw5FOF8AbH0vRuMxm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
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

On 6/11/26 09:26, Srinivasan Shanmugam wrote:
> Queue-scoped EVENTFD subscriptions originally used queue_id as part of
> the routing key. However, queue_id is only a UAPI-visible handle and can
> be reused after a queue is destroyed, making it unsuitable as a stable
> identifier for internal EVENTFD tracking.
> 
> Rework queue-scoped EVENTFD handling to resolve queue_id to the
> corresponding amdgpu_usermode_queue object in the ioctl path before
> calling into the EVENTFD helpers. Resolve the eventfd file descriptor to
> an eventfd context in the same place.
> 
> EVENTFD subscriptions now store the actual queue pointer and eventfd
> context instead of the reusable queue identifier and raw eventfd file
> descriptor.
> 
> Use the existing user queue refcounting infrastructure to keep queues
> alive while EVENTFD subscriptions exist. Release those references during
> unbind, manager teardown, and explicit queue cleanup.
> 
> Introduce amdgpu_eventfd_remove_queue() to remove all subscriptions
> associated with a queue when that queue is removed from the USERQ
> manager. This prevents EVENTFD from retaining stale queue references
> after queue removal.
> 
> Queue-scoped subscriptions are matched using the queue pointer, while
> GPU-scoped subscriptions continue to operate without an associated
> queue.
> 
> Also validate supported event types, distinguish queue-scoped events
> from GPU-scoped events, and allow eventfd file descriptor 0 by rejecting
> only negative values.
> 
> EVENTFD remains notification-only and does not carry event payloads.
> 
> v11: (per Christian)
> - Convert queue_id to a queue pointer in the ioctl path before calling
>   EVENTFD helpers.
> - Convert the eventfd file descriptor to an eventfd context in the ioctl
>   path before calling EVENTFD helpers.
> - Store queue pointers in EVENTFD entries instead of reusable queue_id
>   values.
> - Add queue cleanup to remove EVENTFD subscriptions when queues are
>   removed from the USERQ manager.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c   | 151 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h   |  17 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  81 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 -
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   1 +
>  .../drm/amd/amdgpu/amdgpu_userq_internal.h    |  36 +++++
>  7 files changed, 231 insertions(+), 64 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> index c777d563f1b5..3efe1841880e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -28,12 +28,15 @@
>   * Event metadata/details are expected to be consumed separately through the
>   * corresponding wait/event path.
>   *
> + * Queue-scoped subscriptions store a refcounted queue pointer, not the
> + * reusable UAPI queue_id.
>   */
>  
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  
>  #include "amdgpu_eventfd.h"
> +#include "amdgpu_userq_internal.h"
>  
>  #define AMDGPU_EVENTFD_MAX_BINDS 4096
>  
> @@ -132,7 +135,7 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr,
>   *
>   * The manager stores mappings:
>   *
> - *   event_id -> list of eventfds
> + *   event_type -> list of eventfds
>   *
>   * The xarray provides efficient lookup of event type containers.
>   */
> @@ -168,6 +171,8 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  
>  		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
>  			hlist_del(&e->hnode);
> +			if (e->queue)

The NULL check is superflous. You do that multiple times in the patch.

In general it is good practice to have the NULL check in the _put function and we should already have that.

Apart from that it looks good to me, but that needs a hell lot of test cases to exercise everything.

Thanks,
Christian.

> +				amdgpu_userq_put(e->queue);
>  			eventfd_ctx_put(e->ctx);
>  			kfree(e);
>  		}
> @@ -180,55 +185,49 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  }
>  
>  /**
> - * amdgpu_eventfd_bind - bind an eventfd to an event type
> + * amdgpu_eventfd_bind - bind eventfd to an EVENTFD subscription
>   * @mgr: eventfd manager
>   * @event_type: kernel-defined AMDGPU event type
> - * @eventfd: eventfd file descriptor
> + * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
> + * @ctx: eventfd context
>   *
> - * Register an eventfd subscription for the specified event type.
> - * Duplicate subscriptions are treated as success.
> + * The caller resolves queue_id to @queue and eventfd to @ctx before
> + * calling this helper. This helper assumes ownership of the references
> + * passed in. On success, the EVENTFD entry retains those references.
> + * On duplicate binds or errors, the references are dropped before
> + * returning.
>   *
>   * Return:
>   * 0 on success or a negative error code.
>   */
>  int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> -			u32 event_type, int eventfd)
> +			u32 event_type,
> +			struct amdgpu_usermode_queue *queue,
> +			struct eventfd_ctx *ctx)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e = NULL, *it;
> -	struct eventfd_ctx *ctx;
>  	unsigned long flags;
>  	bool dup = false;
>  	int r = 0; /* duplicate binds are treated as success */
>  
> -	if (!mgr || !event_type || eventfd < 0)
> +	if (!mgr || !event_type || !ctx)
>  		return -EINVAL;
>  
> -	/*
> -	 * Enforce total bind limit without a separate manager lock.
> -	 * For duplicate binds, we decrement back before returning success.
> -	 */
>  	if (atomic_inc_return(&mgr->bind_count) > AMDGPU_EVENTFD_MAX_BINDS) {
> -		atomic_dec(&mgr->bind_count);
> -		return -ENOSPC;
> -	}
> -
> -	ctx = eventfd_ctx_fdget(eventfd);
> -	if (IS_ERR(ctx)) {
> -		atomic_dec(&mgr->bind_count);
> -		return PTR_ERR(ctx);
> +		r = -ENOSPC;
> +		goto out_put_refs;
>  	}
>  
>  	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
>  	if (!id) {
>  		r = -ENOMEM;
> -		goto out_put_ctx;
> +		goto out_dec_bind_count;
>  	}
>  
> -	/* check for duplicate binding */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  	hlist_for_each_entry(it, &id->entries, hnode) {
> -		if (it->ctx == ctx) {
> +		if (it->ctx == ctx && it->queue == queue) {
>  			dup = true;
>  			break;
>  		}
> @@ -236,24 +235,24 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  
>  	if (dup)
> -		goto out_put_ctx; /* duplicate bind: success */
> +		goto out_dec_bind_count;
>  
> -	/* Allocate entry only after ctx/id prerequisites are satisfied. */
>  	e = kzalloc(sizeof(*e), GFP_KERNEL);
>  	if (!e) {
>  		r = -ENOMEM;
> -		goto out_put_ctx;
> +		goto out_dec_bind_count;
>  	}
>  
>  	e->ctx = ctx;
> +	e->queue = queue;
>  
>  	/*
>  	 * Re-check duplicate under lock to close the race with another bind()
> -	 * for the same event_type and eventfd context.
> +	 * for the same (event_type, queue, ctx).
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  	hlist_for_each_entry(it, &id->entries, hnode) {
> -		if (it->ctx == ctx) {
> +		if (it->ctx == ctx && it->queue == queue) {
>  			dup = true;
>  			break;
>  		}
> @@ -262,6 +261,8 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
>  	if (!dup) {
>  		hlist_add_head(&e->hnode, &id->entries);
>  		id->n_entries++;
> +		queue = NULL;
> +		ctx = NULL;
>  		e = NULL; /* consumed */
>  	}
>  	xa_unlock_irqrestore(&mgr->ids, flags);
> @@ -273,41 +274,44 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
>  
>  out_free_entry:
>  	kfree(e);
> -out_put_ctx:
> -	eventfd_ctx_put(ctx);
> +out_dec_bind_count:
>  	atomic_dec(&mgr->bind_count);
> +out_put_refs:
> +	if (queue)
> +		amdgpu_userq_put(queue);
> +	eventfd_ctx_put(ctx);
>  
>  	return r;
>  }
>  
>  /**
> - * amdgpu_eventfd_unbind - remove an eventfd subscription
> + * amdgpu_eventfd_unbind - remove an EVENTFD subscription
>   * @mgr: eventfd manager
>   * @event_type: kernel-defined AMDGPU event type
> - * @eventfd: eventfd file descriptor
> + * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
> + * @ctx: eventfd context
>   *
> - * Remove an existing subscription for the specified event type.
> + * The caller resolves queue_id to @queue and eventfd to @ctx before
> + * calling this helper. This helper assumes ownership of the references
> + * passed in and drops them before returning.
>   *
>   * Return:
>   * 0 on success or a negative error code.
>   */
>  int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> -			  u32 event_type, int eventfd)
> +			  u32 event_type,
> +			  struct amdgpu_usermode_queue *queue,
> +			  struct eventfd_ctx *ctx)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
>  	struct hlist_node *tmp;
> -	struct eventfd_ctx *ctx;
>  	unsigned long flags;
>  	bool removed = false;
>  
> -	if (!mgr || !event_type || eventfd < 0)
> +	if (!mgr || !event_type || !ctx)
>  		return -EINVAL;
>  
> -	ctx = eventfd_ctx_fdget(eventfd);
> -	if (IS_ERR(ctx))
> -		return PTR_ERR(ctx);
> -
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
>  	id = xa_load(&mgr->ids, event_type);
> @@ -315,13 +319,15 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
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
> +		if (e->queue)
> +			amdgpu_userq_put(e->queue);
>  		eventfd_ctx_put(e->ctx);
>  		kfree(e);
>  
> @@ -338,21 +344,70 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
>  out_unlock:
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  	eventfd_ctx_put(ctx);
> +	if (queue)
> +		amdgpu_userq_put(queue);
>  
>  	return removed ? 0 : -ENOENT;
>  }
>  
>  /**
> - * amdgpu_eventfd_signal - signal all eventfds bound to an event type
> + * amdgpu_eventfd_remove_queue - remove all EVENTFD bindings for a queue
>   * @mgr: eventfd manager
> - * @event_type: kernel-defined AMDGPU event type
> + * @queue: queue being destroyed/released
>   *
> - * Notify all subscribers associated with the specified event type.
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
> +			if (e->queue)
> +				amdgpu_userq_put(e->queue);
> +			eventfd_ctx_put(e->ctx);
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
> + * amdgpu_eventfd_signal - signal matching eventfd subscriptions
> + * @mgr: eventfd manager
> + * @event_type: kernel-defined AMDGPU event type
> + * @queue: queue pointer for queue-scoped events, or NULL for GPU-scoped events
>   *
>   * Signaling is notification-only and does not carry additional payload.
>   */
>  void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> -			   u32 event_type)
> +			   u32 event_type, struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
> @@ -369,8 +424,10 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
>  
>  	id = xa_load(&mgr->ids, event_type);
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
> index e13b86240afc..8dbae07b0d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -32,8 +32,11 @@
>  #include <linux/eventfd.h>
>  #include <linux/xarray.h>
>  
> +struct amdgpu_usermode_queue;
> +
>  struct amdgpu_eventfd_entry {
>  	struct eventfd_ctx *ctx;
> +	struct amdgpu_usermode_queue *queue;
>  	struct hlist_node hnode;
>  };
>  
> @@ -52,11 +55,19 @@ void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
>  void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
>  
>  int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> -			u32 event_type, int eventfd);
> +			u32 event_type,
> +			struct amdgpu_usermode_queue *queue,
> +			struct eventfd_ctx *ctx);
>  int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> -			  u32 event_type, int eventfd);
> +			  u32 event_type,
> +			  struct amdgpu_usermode_queue *queue,
> +			  struct eventfd_ctx *ctx);
> +
> +void amdgpu_eventfd_remove_queue(struct amdgpu_eventfd_mgr *mgr,
> +				 struct amdgpu_usermode_queue *queue);
>  
>  void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> -			   u32 event_type);
> +			   u32 event_type,
> +			   struct amdgpu_usermode_queue *queue);
>  
>  #endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 7cc54b7e3b81..66344d03f91e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_userq_internal.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -634,11 +635,72 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
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
> +static int amdgpu_eventfd_get_refs(struct amdgpu_fpriv *fpriv,
> +				   struct drm_amdgpu_eventfd *args,
> +				   struct amdgpu_usermode_queue **queue,
> +				   struct eventfd_ctx **ctx)
> +{
> +	*queue = NULL;
> +	*ctx = NULL;
> +
> +	if (!amdgpu_eventfd_valid_type(args->event_type))
> +		return -EINVAL;
> +
> +	if (amdgpu_eventfd_queue_scoped(args->event_type)) {
> +		if (!args->queue_id)
> +			return -EINVAL;
> +
> +		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
> +		if (!*queue)
> +			return -ENOENT;
> +	} else if (args->queue_id) {
> +		return -EINVAL;
> +	}
> +
> +	*ctx = eventfd_ctx_fdget(args->eventfd);
> +	if (IS_ERR(*ctx)) {
> +		if (*queue)
> +			amdgpu_userq_put(*queue);
> +		return PTR_ERR(*ctx);
> +	}
> +
> +	return 0;
> +}
> +
>  int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  			 struct drm_file *file_priv)
>  {
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	struct drm_amdgpu_eventfd *args = data;
> +	struct amdgpu_usermode_queue *queue;
> +	struct eventfd_ctx *ctx;
> +	int r;
>  
>  	if (!fpriv)
>  		return -EINVAL;
> @@ -649,24 +711,21 @@ int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
>  	if (args->flags || !args->event_type || args->eventfd < 0)
>  		return -EINVAL;
>  
> -	/*
> -	 * Queue-scoped subscriptions are enabled by the later
> -	 * queue-reference routing patch. Until then, keep
> -	 * queue_id zero.
> -	 */
> -	if (args->queue_id)
> -		return -EINVAL;
> +	r = amdgpu_eventfd_get_refs(fpriv, args, &queue, &ctx);
> +	if (r)
> +		return r;
>  
>  	switch (args->op) {
>  	case DRM_AMDGPU_EVENTFD_OP_BIND:
>  		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> -					   args->event_type,
> -					   args->eventfd);
> +					   args->event_type, queue, ctx);
>  	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
>  		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> -					     args->event_type,
> -					     args->eventfd);
> +					     args->event_type, queue, ctx);
>  	default:
> +		if (queue)
> +			amdgpu_userq_put(queue);
> +		eventfd_ctx_put(ctx);
>  		return -EINVAL;
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 427c09c83d6b..b77385e35e4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_userq_internal.h"
>  
>  /*
>   * Get the per-file eventfd manager associated with this userq manager.
> @@ -872,6 +873,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		if (!queue)
>  			return -ENOENT;
>  
> +		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
> +
>  		amdgpu_userq_put(queue);
>  		break;
>  	}
> @@ -1232,6 +1235,9 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		if (!queue)
>  			break;
>  
> +		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
> +					    queue);
> +
>  		amdgpu_userq_put(queue);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 8c4b55517a0a..e1a7d0dbc436 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -144,9 +144,6 @@ struct amdgpu_db_info {
>  	struct amdgpu_userq_obj	*db_obj;
>  };
>  
> -struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> -
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..8795156270f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -31,6 +31,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_userq_internal.h"
>  
>  #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> new file mode 100644
> index 000000000000..3b24fbb294e5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_internal.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_USERQ_INTERNAL_H__
> +#define __AMDGPU_USERQ_INTERNAL_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_userq_mgr;
> +struct amdgpu_usermode_queue;
> +
> +struct amdgpu_usermode_queue *
> +amdgpu_userq_get(struct amdgpu_userq_mgr *userq_mgr, u32 queue_id);
> +
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> +

