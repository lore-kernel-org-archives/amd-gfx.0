Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C0606AAC1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PmLeGvRl
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC692CCF2E5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 14:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6009D10E8A4;
	Mon, 19 Oct 2026 14:52:50 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295F410E6C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnrEDAG+u9dUyIUbS+GQ32sF4enFy7990cVy2C3JIOjOHmEFvTcsSHVP1hRaP9I3F4A3VcGxskvDcZW8kHfKdL0MXxM2B4b7M+uemSN5Jy1IosLlAt7heMJcLdh72ESluhYPRhARgch2PwsyoMpRODc8HP3nLaskpQbRTgg1L2H8W+MzHmMERfVgqe9g2qc/izJ17E7NSS0pQRWEIdiGYmNbFP7f2NIZMXuzc1XrR7YFmbaxZGQs0x7hO8ftR8l4cYJt9U0RCZO3Gc+rczIVu3D22inxV0njdFptvNsXpPOl49OHqIlvp35qeDKjJLJc/mkzbMyfjMmsIDRmsQs+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaXlCYmfTh6JluHXLXA/YaYwxpYrlv8J3j/JM7vJRAo=;
 b=nE3nwRxUSWgeVX68YyT7zOhYmH9/uUwDL1c4sTRaZLeZk32wAXIUb8ZvdMRnjCFbeTqvEVKt+kv04w9w7nCd3kkdatLplsJHct9Lsfy5Gx8jwd15MDjvKJdSNe07AeX9YCe9TRbQ6sIEUf352nnxY51/Kh/BpAeziVmDbolOONdatXg5db7OB9Mp6PhqZbp0i7raI/MBHmwr3ru0QsEUn5xb7q4c9qQgGX9dNCNjSaIG1YSJpkiINU0cvGq5DxS7kheJuRFlKnGMKAPl0xiy9GgW/c9rRDr8kOSTth5QAeqYmqvffSMsh1pBTgPVkUBsH5wrp5kp59KNV8LkAVeTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaXlCYmfTh6JluHXLXA/YaYwxpYrlv8J3j/JM7vJRAo=;
 b=PmLeGvRlWCCv13rs1viXj9OWhN/taI5M/bxAHZneL9mblm9k1gElJ0ZN4p6tuJWHEtgbTk7CyF/C6IRwLo2S9ybYHUTb0/GnEig5MpVlgT0SmKESsWkYBxkEyhF+wWLGGOLfbmaCREZp1Jg5zj+JUvCD0JQhXnZQxf6GFkNdgd8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB249853.namprd12.prod.outlook.com (2603:10b6:610:702::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:52:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:52:40 +0000
Message-ID: <18998b1c-b3f8-4cd8-bdc9-0bd06be37977@amd.com>
Date: Mon, 19 Oct 2026 16:52:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] drm/amdgpu/userq: add a walk over the user queues
 of one type
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
 <20261019083402.2033724-5-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019083402.2033724-5-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0358.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB249853:EE_
X-MS-Office365-Filtering-Correlation-Id: 96267ac5-377d-488d-df82-08df2df09f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t1jwlPGWv9ylQ6gk6RR7kSPN0jdSIMdQm8ciujmKFtBY3m8YKl93KgUBHhnOy286F3XfeMFYfrQCyd+HFfMMJF340EJ8pSj6R/RK32bsI66KtPQ6+mD58jwtS1DnnQAeaXM7fXKQh76+Uw/8oLLaDH8Y4S2n+88H0LEJeWxTuVl9gv0pEYMd6qazGW6PGXJ9gZTI2I4CCIHymVk3I+t4BM4sguiHlYO9wjyBMsXdEdSyEep2Russ2wdj8nekdgYv6OXFaWIG2ouMTceAftjmzwax+esW5G0UinmX/r0JLIAyJIjjw8u4z7y9496wHoOn3Qr2eNDeAJSdSqgHmhNQTj2WEsv8mIYkXliLlhuC76KqXMph5JZIBJW5CDGDKYwyuWoaIb/xYRHVwH97ebY2cFN9KbZfhdk3XL2oQdKgdUcR+AyNi6CplNMovNqWIevOAggWk6gYwbE7t1ABtK369RYpN2E4uw5N7ZsoNZk3q38iCYp+NsQo0Gw/6spAUadeGP0Wlrl5MGx77JNydluZs+NA70MIz0hZZ0Bb7eENgp1/JfAIsuDvAi/ErKMYEZAYDMwul2CUUZoBVAug2EgKPCM6ib1eesZapo63JKjxo2oiiO1iJ5D5Y7VL0Q3CLdTOZfN9Ac8lk9ZJ0p6v+pgXxeVYFo5FS+mv8UPSYccgtoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkp0TUsxZGdMakh0YVhiNm1oQWFoUk9XcFlxbDRYQnA1cUV2ZnJQTFZ3VGd4?=
 =?utf-8?B?TGFUVGpDOW1wSnhUYTI1Vi9Mdjg1eUVmbU0wZHFodzEwUDBrdXNrdlhEbnFu?=
 =?utf-8?B?U3JHb1RQS1FoclN0Q04wNVllejZDRmVlMzlkNDdxUGtFTm5JMXEvbTcwTjgr?=
 =?utf-8?B?Mzk2UW94c3BET1U0Ym1TSXg2S2RxS3owZEpzYUdUUmJBZmVtdmtFVE1ybEtZ?=
 =?utf-8?B?UFg5NXpkanVCYU0wS0lpU1QyOHZkbnhZVWpGSmxlajhJVXhvQlhiTUh5K0ZT?=
 =?utf-8?B?MnJyd2xEMlJjaDNEemUzaWRTaUV5K2hRZUVpN05XNUMyOGJnZEd5NDJpOGU5?=
 =?utf-8?B?VmlTV2xHVjMrN0N0cFRuMkNERkJUbHdxMEdkT3JjN3RtRDQvMTRPOFR4Vi95?=
 =?utf-8?B?OVB6MDk0QzFwRllCSUtiSW1Ea3NuL2s3QWkwQk94U1M2ZkUvNXQwVTNJck11?=
 =?utf-8?B?cTZxeVppUlk0Zi9xL1JXbXlVMGhieldJVXFoRzJmSVlDRFVnM20xY2xidkJU?=
 =?utf-8?B?VllIR3UxYkNzMjdnOVJ6TTM2VWEvV1JlTEJEQ2diVVFnbm1vZjl0anFLRndS?=
 =?utf-8?B?bHRuQW5Xd2ZGNVNzSkRwVTc1RVV4aUNQWFlMOU9WcE1OZmIzMTVkOVd4Z3pI?=
 =?utf-8?B?bVF5SVZxY1pGU3VoS3BVc0pjMnhkZXJtWDFRQTJ4dkxMQnBaZXlydE8xeHFY?=
 =?utf-8?B?bFVsWTBlTUt4Tm9ucGt0SHpVTzlPcDNNbWNlWk1vNWNPTGY5RmhQYnZ4aitl?=
 =?utf-8?B?TksxSnVLN2hLRElmOWFvRHVaaWlDdDNNT3JadHRacktSOW9zTXFWd01iTkpW?=
 =?utf-8?B?TlQ2UklWdkpUVjNodUgwQ0YyckxDZzY3ZkR2WnR3cFIyZXRxNE1LWlJHenVS?=
 =?utf-8?B?V256aEpGZzNDaXE4SEtibU5HRUFLNWxyZTV2V01ESHJ4cVJGM1JuWi9sMS80?=
 =?utf-8?B?Qjg1YnVBeXJidytqM3VaUDJSMkwwLzJ6QzBpeEM5Z1VxK0dtL1ZCRzFYc1d2?=
 =?utf-8?B?ZEhLQkhGQU4wazVQV1lycXlEMVNuaDhUTGdhL1VxYUw2dTFmYytzOFBtMGdv?=
 =?utf-8?B?YnNxNVJ0bGtKNHk2aWtleld6bU1HNmUxK1dieUhvMXhxMnMrZ0xBQmJMbUxu?=
 =?utf-8?B?UjVacHczMm9RU3pNeHdzRW8rT3YvSG9TSzRQek03eWN2dkt4ZjRmUmlCMWhL?=
 =?utf-8?B?dWJHWDZQOGZ5TXl1UDRGbmliZzV4NE9MeGdjTDloOEhXV3FsbGR6NnpiY3cr?=
 =?utf-8?B?ZTFKU3NrN0ZxK1RheXVubjFMbVgzRjB1NXVFTWdCTVlMMzBzcnV1Z3JGbDU2?=
 =?utf-8?B?emU3Q3h2ZGpZclNhVDVTb1JzVUhzUDgreUI2Y1doWTBETnY5VUk2WFBCNUtG?=
 =?utf-8?B?eWZxYUl3amp2SEc0VFZUa2V0cTR0anhjSnhVbG1HeGRESDR5QTZWVGprZ2Er?=
 =?utf-8?B?a2x5d2RCMlgxQUNrRktyQVpVRUZNNHlaNndpbWd0a3ovcHRJTFR1bVNvQ3pr?=
 =?utf-8?B?QzN3T0pIL0ExUXpIcGRuMDRtbnpkR2E2Nld2S2x4Z005T0xWWFpMOTRTUE05?=
 =?utf-8?B?SHVmZENua0NXamN5bUhkOWNURFFsSHRCa0JVd1BMYkQxMGFxUHRuMkQrZHJs?=
 =?utf-8?B?MEZOUTh2NVNlTUN6MCsxd1BTdVdtb3ZzbC9XQkUzeVZpQjd6ZjBOZlk5Szkr?=
 =?utf-8?B?RVdkWFZqdk0rMW1VZG5rK3RKYXd1bk1WTVR3RjRMK3lTVE5tbWpVU0h2alEv?=
 =?utf-8?B?QmdydFk1dS9HTFcyVENYaDV3OVI1Z1ZHakc3S0lscmI3WEZKM0JiNUJTR1J2?=
 =?utf-8?B?dStnTzBZcDdCOEVEVFhyUmd2eGJZeDdmc1dEa0twZHM1UElHaWFuQ3lYcmNN?=
 =?utf-8?B?SDJybjU3UkxUSGZ2b2hsamtaYWJnRzV3K3JZbVIvTDZkVDZxL21JWW14MU13?=
 =?utf-8?B?ck91a3cxdDhnMVN0UjVuZTZVNVdoQ0QrVDZlWjhCbEhjMmVxRkIvd2dEM1do?=
 =?utf-8?B?T3lNL2QzVmZ1YnBFMlZqM0Y0MTRTbjEyNDQxVzV4Y1JWYmVzZ3hjREV0Qy9i?=
 =?utf-8?B?OExUQ3QxSEJGL002enZzYXZqa1BUM0l3LzhYUUhUeHpzZmU4U2tkSE96bmtN?=
 =?utf-8?B?QXdWM2ZPaTRCRjlXdjEweTg1eHVFeUlXenY0Y3BzUDNNSHc1ZFpXN3ZBYWN1?=
 =?utf-8?B?WTBVUXUyYUVHcWt6S2syZlVjSlhQU25xZk1mdGpYVDQ0SnlRcy8zVitteVhl?=
 =?utf-8?B?NDUxVGhCNFo4Qll1Y3FLVVE4SnlQSVJnUC9aMk01UE5JbWRGUTBCSVZxa0xm?=
 =?utf-8?Q?mAaRC4/cmX0gqk2FVY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96267ac5-377d-488d-df82-08df2df09f62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:52:40.2277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgRaTjhFXAeKKJO1BkKEMtBO4S6KRUV3HFdSAzv9kFyZqf6ZIASkp75KlMOZEysn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB249853
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 10:33, Jesse Zhang wrote:
> A reset of the queues of one engine of the GFX IP only holds the reset
> lock of that engine: the user queues of the other engines can be freed
> meanwhile, and their type can't be read then.
> 
> Add amdgpu_userq_next_of_type() and for_each_userq_of_type(), which
> check the type of a queue under the xarray lock, before it can be freed.
> A queue of the walked type is kept from being freed by the reset lock of
> its engine, which the caller holds.

Absolutely clear NAK to that!

You *CAN'T* touch the userqueues from the reset handler like this nor keep them alive with an extra lock.

The only thing which we can do from the reset handler is to take the xa_lock_irqsave() and iterate the queues to change their state.

Everything else is *STRICTLY* forbidden from inside a reset handler!

Regards,
Christian.

> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  8 ++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cbad1fa1d2b5..2097d7c0bfd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1591,6 +1591,28 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  			      false, MAX_SCHEDULE_TIMEOUT);
>  }
>  
> +/*
> + * The next user queue of @queue_type at or after *@index. An engine reset
> + * only keeps the queues of its engine from being freed: check the type of
> + * the others under the xarray lock, before they can be.
> + */
> +struct amdgpu_usermode_queue *
> +amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
> +			  u32 queue_type)
> +{
> +	struct xarray *xa = &adev->userq_doorbell_xa;
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long flags;
> +
> +	xa_lock_irqsave(xa, flags);
> +	xa_for_each_start(xa, *index, queue, *index) {
> +		if (queue->queue_type == queue_type)
> +			break;
> +	}
> +	xa_unlock_irqrestore(xa, flags);
> +	return queue;
> +}
> +
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>  {
>  	const struct amdgpu_userq_funcs *userq_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..a56cb9fa8684 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -179,6 +179,14 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  void amdgpu_userq_reset_work(struct work_struct *work);
> +struct amdgpu_usermode_queue *
> +amdgpu_userq_next_of_type(struct amdgpu_device *adev, unsigned long *index,
> +			  u32 queue_type);
> +/* Walk the user queues of an engine while the queues of others get freed. */
> +#define for_each_userq_of_type(adev, index, queue, queue_type)		\
> +	for (index = 0;							\
> +	     (queue = amdgpu_userq_next_of_type(adev, &index, queue_type));	\
> +	     index++)
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);

