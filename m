Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A4CC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B822110E4FD;
	Fri, 28 Aug 2026 13:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YEbLQuqR";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7AB10E4FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 13:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXcZi/EJTUUen62ZBJS7Mhp8t0g4GakxN3dhxQPLyyKUfjG19E7QCm6gMPQ7yAsAIFdYBrYyWbxg+RoIRlHqx9U0yQ4EyUIaXqNLN7lbjRbV/XPmVrclI+8YvrdNozF/R2OdERBh/GysqYu2BHjpyc3Nj3hI7ty/ZiWFKDxaZRUhyeRYyoh6Sb318Lrq4YfuIzUJ/wgoYB2ISO1mcE+V/rxVDxJdjqpFA8yldL3YvYMzl6Se9C6DIRo51xBUvrDZxbDuJpd3RIRy5ZBqp7I802R7MRljeoFneBFEVD+LJBvp1e4UBK4sSqjd3X2y3d+Fn5xGZgjijZyj7wq9rw+j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Opn640+OGqLOWTg9bD6l1DqR/FF7QIU4GgQNXUgEnM=;
 b=J0fW4cnZyS3uESXh8g/gHqgcD4Jqx10isBV6a16hvCBnOSFdd006jLMhNUh0n7hggoq6TN936WRGTdTD0QIPBhv+WA+xgtOSfKdoB/DBy2zYYR5/vkoABaCpi6xVYZN+god8h3W7cXOaTi8EH0R8zAIGgywPSfezuY0r/+KKhNcLMSt25b69lwCPRXLPkfyBIFvN5DWY5ptrL7/U6tiOD947ZkOk8bYnoIj86m6dKn7/I09dnzalITjmG5EVQpFMzdF1j4BcJPhv/krJ+NsDSQmLHRnyAedpQPvbeghDWB1bN7fK2hXawrsuuDgX+8ij92j1U+BndG4JMDJlcr7Vrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Opn640+OGqLOWTg9bD6l1DqR/FF7QIU4GgQNXUgEnM=;
 b=YEbLQuqRutC9cZJIuM7FGFCgmmlbFCFQnsMk60Shx54vW9J+r4NMmFPmqaVKRwlEmjfnMHVJpSKlNQhlCLWdHTW93KPZM+ye3M5nSMkE9W7DhyC1Jqm2k6RxhEuTFV6A+/yPakCr41jb8yj6lHdaYlDQwM54/LYJG66LJWJhPXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 13:09:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 13:09:44 +0000
Message-ID: <18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com>
Date: Fri, 28 Aug 2026 15:09:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: keep the userq manager alive as long as
 its queues
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-3-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260828095349.9797-3-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0388.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: b25b4e25-ff79-4b56-f3bb-08df0505a0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oPmJfaJBlCtnwoOF1fV/jefE//NPcYpITNPpHC53S42GGm97eQL5UOmZLSAb3I4JSPYdpeFLt2RQZZK/Or/vHBI4pacgEAmwtYafzRAL7x6CnLiL0BOfve89edmzYWEcgLYhReWD2w3a+4vdX/xNtV9V1FdbSEgu1aw4mzhF7dvE0I9i5y9B+9lXZj48MREzlCxRvgHx0iUGNtU97VudV95czvMUTyYkTPnzuE3bb2gS3f/zvE5W9BMmMvLc7cLE0RqSUk+nNmhCnpAWySY5YUh98usM/AmLSeUYBIUCJe7jdMHmDGdFxTnD9pLGxhB+gVl41uMANkRGDcIiYBUcymOOTfS0wgeif1+2NtMsSVN1bQujM+2h5U1xVD4rndY7pdp4dwxRfiwWypX1NqY06fucbTNXGhsAXjvgNEO1A6HZ60DBGKAXIdWc6jtS4JRr1qcoTLifnQDGkg05AWc9rjDVhrCVko8XJ3LmBiX/73mAnPTDr27vKO4fTjf6K+obO69N5v/y+4Z/Cwj7GT7sSeE2Lw5p84XSXLl1HtOR4q/JqNxVvfJNWueVqF7Q9TMTlCVzcVmvjG+KAxj/UrdamhyjVG9K4nglyZdWN+Z7iljHBtMnfEHXhrglCdRJhtDWklcCws7FIUFpoSWj8UZs37YEQinphE+e6zyDLhM/DOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllINGxSRDMrenJDaHVOYTJFMVFrbTQzdVNENHRrT1V5eUFiUml3MnJqUVZH?=
 =?utf-8?B?MWpLUnVRZmFNZnFSNVJYTHd6b25nSWFCb1dhMW5CdFdnUTNKMWUydWg5Wm9x?=
 =?utf-8?B?UzIwNnZuZ09LTkkycjFkQ3pOU2p6ajdCWDBjWjBoWlBxOFRaa3RRVDRVb0Vu?=
 =?utf-8?B?bEY4MWw3YmxYU3d4OHBuZ0gxR2RrbTBadG1HUkxsa01YaFRtVC82ZUVGUEZu?=
 =?utf-8?B?UWY2V0dBL1cyQ3FUUTdEbXdIS3FINlBRRStOZ2lFaTRyRWNmNktWUHhxd3A1?=
 =?utf-8?B?SUhIczllSzJPeTRnMzBPRUlxL3NST3Y1YVVRdVlWOUE3VW9tVnk2eWQrVy9i?=
 =?utf-8?B?dzV1cjdMYXVmd3NSR3lWUkhrQldKU1AwM25LeXdheXJidDdKZGNMSXJNeWl1?=
 =?utf-8?B?aHFScmlhT1NCUUhnbThuT3FXNFA1MmdkSW4rM3dTdHFKRlZjbk9IL25BbGJN?=
 =?utf-8?B?SGpiNmhRZXhaZGlydmNzdmFqR0hlS2RrL3RzRW1LWDY0aDU5bENwYlU3NTAy?=
 =?utf-8?B?aHNUa0krSVUxMjl1dTlDVTRkZ09wdG9tU0NHZnIycW5NTEdxbFljZ1pzZW9l?=
 =?utf-8?B?dnd3SEhXcmM1bGpueWVQNDhaMnNBa0hFYTg2R1RZRWtOTTBpMmhlb0NwM1JL?=
 =?utf-8?B?K2EwbmNLYWU5UVVpS1pqUElTTk5wZEtqVW1iU01nSkhtTWRsZTBQY3FMNHFF?=
 =?utf-8?B?Snl6RU9zUU90MzY3T2g4WUw4WEZhRWljMmhhb0I5aUpWOGRnUHUycUczYVMx?=
 =?utf-8?B?V0hlZndKbUt4cHdpTCtEakpvY0Jma3VPYTRmYTc1YldZRThBam5md01ZT3Iz?=
 =?utf-8?B?WS94VEdGaW15SDlyRE9oajFpSmE3elkyTVFaRHZMYUZLbXM0WUJNNDVYTk4z?=
 =?utf-8?B?Q0VlZ1B0SWtTek5PV3dubklSTEVhVlVKTkErMjh4UmVxT3IwQVJPZ29hTStX?=
 =?utf-8?B?LzJmSmF1OVk5RG5qTEFjR3ZkVFAyajQxeUtMMTVwUGZ1T2ZxYWVudjd1aFU5?=
 =?utf-8?B?OStOY3JUYXlIRks3RjJUV3pZZ3BGaE5FVzJ3RlZMdHp3ZlBZUFdFcDIzY0xu?=
 =?utf-8?B?d3V0RnZWbHB1UVhlVHg5VzR5dXZ6WCtyME9CZ1RDWGVLNjIzR1VLczJLV0lF?=
 =?utf-8?B?amNHdmdBVDFvdVFoWTMzRGlPTDNjWlp1a05seGdCU01hd0pkRlUzd2ZITmI4?=
 =?utf-8?B?OHhzMlNBNjUvZytleWdaVFk0clI2cnk5ODJ4WXIza0tLL2RjSW9CcGlSQmFW?=
 =?utf-8?B?ZWJITjgzQkVJWk16bUtxRWo5dWZJaXY5aGZ6UlE0cjQxS3hxV1psNVBCc0VV?=
 =?utf-8?B?VlZubHNQQXA3Z1NHb0FRdUpzb3NCZUdpQTBTVDZRVERjQm9kSDNOc2Vod205?=
 =?utf-8?B?NmdJS2plc3B5OHV5b1YrY1ZlbWlEdXFKS3BtenJoSHNNdDJRSE1YcUZxZjlB?=
 =?utf-8?B?eWdnamR6MDRucmlDUEFmaWhaZkVNL3piaHpPOFJBcnZjMTE2NklNWWtHNHNr?=
 =?utf-8?B?c2J6U2pMRmdFcndSOHU0bm8rMkpSRlpyS0hvVTNudkJSNVVkT2N1V0NnOWR6?=
 =?utf-8?B?SDE3QXUvNzF2c2g2K1hldHhXUVlaQnNjL2dHSkpUa2pRdzdwbE1Ka28vcXd1?=
 =?utf-8?B?Z0pjZTV3bXFJRU8vY2ZjVHUxTmk4ZFY0OHJ2YVNkSFBJNy9RdWtwdnIxZ09G?=
 =?utf-8?B?WDZNZnlqTDdUYWZUU2JJS0IxenNDQVc0NEhjemk3NUNGSHZUbnRHOENpMlR6?=
 =?utf-8?B?b29aV2lETlFhTlVuTDByUEx5ZUVVMVlWK1djZkVGQU5SQzl4bnFxQXpDSEpS?=
 =?utf-8?B?T3d1TUhuWlI1V3dwNXl2aDFJT0RYcUowSjlaVktMTGdXeWxTb3JrLy9XZnpG?=
 =?utf-8?B?TnBudWNYcWtsT08xZm96d0xiUjdXckhUZzFucGE0MXIrcGhSK0YrdEpxV0hW?=
 =?utf-8?B?YXQvMWdXWVlaV1VTcTBBcTVKblZHSmlKa2tkRnVXaDRxdlQyZ1ZweWpuUzlU?=
 =?utf-8?B?U0FaSW1nc0JhRnEzSE9SZXBES3o2MDU0ZSttNllLbG9zMTJVVW5uRGpJVTgy?=
 =?utf-8?B?c1dubCswM2Fja3hmY2x4Z2xLNEppQlRBS1JjM1QyeUFjdWFLLzd4Tm5KN3d2?=
 =?utf-8?B?UmlsZVpmbWhVeXlqeE5MWWFUSFNHYU9RWHJhSnRCamxMVVJhblZocmZIcEtK?=
 =?utf-8?B?Vm83eXV2MFNkdkdxbzY5NSszcDBTTGNjYnNGZmZxRTJjYUkydkdiRWJMRjBN?=
 =?utf-8?B?NmdKNmVuQUFGMkhKRjdEVnhBazNEeXR2TUh4Ui9qRGRjUS9Zbm9JNkhxcXJl?=
 =?utf-8?Q?yLXOGf1FH7Sds7fVA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25b4e25-ff79-4b56-f3bb-08df0505a0ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 13:09:43.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCxJX3MCnbUni1vN5sO3O1DRUrDKgk2L41SAQsiolTEv4niEcMmgXhZG1fmYrxXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

On 8/28/26 11:53, Zhu Lingshan wrote:
> The life cycle of a user queue is managed by its
> kref. However when destroy a userq manager,
> the kref_put of its queues in amdgpu_userq_mgr_fini
> may not be the last put, therefore the queues
> could be still alive after the userq manager
> has been destroyed, resulting in
> userq->userq_mgr use-after-free issues.
> 
> This commit fixes this problem by introduce a new
> counter refs representing for the number of its queues,
> and only free the userq_manager when refs == 0

Clear NAK to that one as well, this is just nonsense.

Christian.

> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e0639f844a8e..f398986a61a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/overflow.h>
>  #include <drm/drm_drv.h>
> +#include <linux/wait_bit.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_reset.h"
> @@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  	return r;
>  }
>  
> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	atomic_inc(&uq_mgr->refs);
> +}
> +
> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	if (atomic_dec_and_test(&uq_mgr->refs))
> +		wake_up_var(&uq_mgr->refs);
> +}
> +
>  static int
>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
> @@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>  	if (r)
>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
> +
> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>  }
>  
>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> @@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>  				fpriv->xcp_id : 0;
>  	queue->userq_mgr = uq_mgr;
> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);
>  
> @@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  free_queue:
>  	trace_amdgpu_userq_create_end(queue, r);
>  	kfree(queue);
> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>  err_pm_runtime:
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  	return r;
> @@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  {
>  	mutex_init(&userq_mgr->userq_mutex);
>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
> +	atomic_set(&userq_mgr->refs, 0);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
>  	userq_mgr->proc_ctx_allocated = false;
> @@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		amdgpu_userq_put(queue);
>  	}
>  
> +	/*
> +	 * The above amdgpu_userq_put() may not be the last put
> +	 * of the kref of a user queue, therefore there could
> +	 * be some queues still alive even when the userq manager
> +	 * has been destroyed. This wait_evet() blocks
> +	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
> +	 * while any queues holding it.
> +	 *
> +	 * This prevents queue->userq_mgr use-after-free issues.
> +	 */
> +	wait_var_event(&userq_mgr->refs,
> +		       !atomic_read_acquire(&userq_mgr->refs));
> +
>  	xa_destroy(&userq_mgr->userq_xa);
>  
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 8fc73862f64e..a13d8d4dd5c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
>  	 */
>  	struct xarray			userq_xa;
>  	struct mutex			userq_mutex;
> +
> +	/**
> +	 * @refs:
> +	 *
> +	 * Each queue increases this counter when join this manager,
> +	 * and decreases it when leave this manager.
> +	 */
> +	atomic_t			refs;
> +
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct drm_file			*file;

