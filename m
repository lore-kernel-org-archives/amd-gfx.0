Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F4CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2876510F9C5;
	Fri, 29 May 2026 07:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f0TEUIsr";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08BE510F9C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9MriESe7xw8KOOP/EmvWpYvzb/IWn3+Zv+hQoe6hyWgQm15HzemQj1DvT0Dabq7SldjD569J0ccRrrghiiVSaPoaGWSFxvH5XZpxIWlZ9ZR41GYwZt+ds/E9hLD6zp23XfA7tzYutmBuAf1PLWqSJinAEyVc9Yytn/eS4NmNvztLBHHDJHLDTf+7WC2PrqQahrp5SqrRiN+YkI4ANP4sQ7BGQaL1pEeN7prMkRsddMOj2nwFPffMF9Kgb5GjXMFIS03uAWjR7HMXHzsVg14jjoc7N3UfneqZAOg6hjtUFJPFvareKEH/FAYSH0Sc6AYAvS/K+tYWECuhUr4NoY3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5EEFlqUv/xZpXFqealR+tcuuj98tCTYIa+Hlo71WG4=;
 b=uX1G9QtxGYv0BN6S1Kokep415pWYBIxDiMl6/vWQU79jwjB7dQZideP3+q7Je/Cw2G/Gb3myJ9/YSniW9T8j7fbrYFNWVs546xUIUeDJe+C3gfmHrpTfIh25lY3t5c+c4cQZktn1z8cREvIlFVqEUyr3eESInEVw6+wsIdk8PBRmklHMcPyaPbR2bWET7OMBacAdGIWX1Zag4N42wrPeUaCeYgn7rOqOR+4GhTm+hPWuoVahism0dI25ZkjqXpRMR3KjbWSilPnTMzMKJavHSmybs/NzdBaZ0Trh6TYKYtStdJPizBbS+pEMu3wk/mVoOEBz46zimIQ9jZH5/35Zsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5EEFlqUv/xZpXFqealR+tcuuj98tCTYIa+Hlo71WG4=;
 b=f0TEUIsrLNw5YW1nmm7Ym7WrTvdZKcWX02e0uHBnguXji5lFQB4UHKHXeJTPxxMdZrW+3V4uAknvOmGf8NUyMz87/86MWM5ozRyMd78Y3J093x1xXCnUhKZ2tbsg/VX1pn30YBN86kaff38t2IcxfJD+W9BIwmuilQDHk56oCSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 07:04:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:04:55 +0000
Message-ID: <00bc6d0e-678f-46a6-b0e2-eadd48be2f19@amd.com>
Date: Fri, 29 May 2026 09:04:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: Honglei Huang <honghuan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529022745.552737-1-honghuan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260529022745.552737-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc02879-f874-4b97-073c-08debd509643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bBMbrFdA3350TZC3UvzPNQ863XVai98ZhDjSjoxef7+19cFA2bVeyPdcgTJW/pEzsfUtp/wK7I1Kk41OER4tW6d2kvb6UmA3NpMei9DOoeoE9YGZhKPGVjzYfjnMpJutmQD8LplUAgJQQG0XLNwPGL723vbN7UF+6+wl2y1QE0dsB8IIiDkP4Ge4MvEKqp9OsyGgFVmOT54DkPdsBfS/RqmIhNXj0gpqPoNYPEr8S13fgBsXWDhKEBTvgqmtnQ4Dfk1npH99MvYsWWemfXJ/4HJtmueffn5WwM5lNLekbh7JkDPfHPNRbYQs1ydGrX7qjA4mbGwpNOtngREEncHcKQgxpitaq8QHIsF4xlxEShZTG+fIQaL+eUALobA3oyJ2tdnjBjCVpStUj2cu2TOg/7MEHYaROsd2wjbAdLqk3/TL0Z8z3tiRBam665Ewf2HN1m1HAOXbWrJUN1zwDzDaQLewuneS7FJs4SO5RYyTSUrSaTW+NoGVlo0jHJYb01CKXudc8S74vfZeEgYb+rsegYXme0f1YpJg+GmRnctqsspf8ZirStX9RCWVvq5qI1txHJ3C9sTbWYdrTBW6cNaLz/bqke39rGxAoCfLgJoA24OkVle+j4I8IiYuQoWmKbsXY/JVl1zP8URRWVbJzaQJCOMnillUMJc/UOOEBd1CDe2qL07kaUhFB9ojnWxA2s6EvMT9iLptrh4ge8Q3tyWGuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2lpSHQxNDErSnJBMFRoUEhSMEF2dXlYdmM2YjQrNTFNNFlUQmxpdklxZ0xt?=
 =?utf-8?B?NXF0ZnJvTXVVK1N5ZWhqM012ZkRQeWNCUDl4QTRNa2swZDhERHRiOTRERjJq?=
 =?utf-8?B?NWROK2kxK2J1bFhoUFFKaHFnVHFOQ1dScGlPU3gwd2ZHcWRXR1kzYUJNbnVP?=
 =?utf-8?B?cG9lRk04TjJUMTBxSjJ4MEhReEVMMWx2MEt3QzZUaDBhS1RsTmJzSUI3Z3FW?=
 =?utf-8?B?dExnNHM0bHlxUkx6R2lHamh3U25HK01BSmViaENuT24vV1l5eDN4MnFyL1dq?=
 =?utf-8?B?cFFQVitNUDFhY2xOUjE4K0hhTnhTQ1JCdXBJYzkxUnBTVkdlMm9JSjFURDRO?=
 =?utf-8?B?WFV0ajBmZU80UXFhSDZSNjdxcmh4eG52R1VicVQzOVJYRjkrSU9yWktFY3Zt?=
 =?utf-8?B?ZkVNa2Z0OE90V3oxNnRTZ1lvam1QaWFqSll6dXNMS0QzdU51cWZvd2ZmNkFr?=
 =?utf-8?B?RHUxcFhWMnJITXV5UHpmOG90TTBUT014OE1US2IvOWc5U3FJUkpOQTBVL3Jm?=
 =?utf-8?B?cHh0cVFHWS8ydURjL3ZPL05EVFhidTgwYjFMUjVleW16VzhxVTROZ1NrZWIy?=
 =?utf-8?B?TXRVZDFwY1NGOGRPL0pjZmw2VlZxcVhMOVJRMHZkUlBGb01sd3RRazluN0d2?=
 =?utf-8?B?VWtRbE1ncTRkY1FPZGZWMjh4Z3J3SWVsamtUTHhvcEY0NG5jWUY5OExFMmNK?=
 =?utf-8?B?czFzU1J3NHVTa2RwcEorYk9WWkhLV0NnY3Z5NXpqemxqQTgxbHp2TmJEaENX?=
 =?utf-8?B?dE0rNVZUNnVLdGI3TWYwc0Roc2NWUDdyZmdTYVdNQjZRdjIwODU1Z3Z4SFhj?=
 =?utf-8?B?QXpUbXlYL0hNeGRSbzJrOHdDU2FMN1hrTUt3NEZ0bTNIdXFrNlk0QmRoeWdW?=
 =?utf-8?B?UzJTdUI3NFFpQms1MWVObUU2SGZNbk1hRGtlQ3R5WUZiQmZ6N2tVSzBxdHNm?=
 =?utf-8?B?Wmh4bm53cTFPUzEyRkdVTmxGbDU3Ry9oc0g4TXlzYWJGTURkUEJGNVBsNnh6?=
 =?utf-8?B?MVZTY3BGR3hwQmdqUE5CVklrU3VDYkJBL1pROFM5QnQrSkZBRzJvZ0RMemlG?=
 =?utf-8?B?M1NsVENwOFF4cXNaVlpMQ1VmaDY4VStVMHpBbmRpb1E5Y3oxWVppc3hXZmww?=
 =?utf-8?B?T0d2bHArZkQzSkFKcXAxSldKV1JZcFpMTVhtWnAwWFFLVVNwUVd0MVdOM0p1?=
 =?utf-8?B?b0dDQm9VSzVseFlTWVFPeTUrRUFmZ3RHcGlqRnEwa2FpVWRCZjllNWd6NGw4?=
 =?utf-8?B?Wkk4alN6d25pN0FwZVdJOVR6Ri9hMjZ0OXhDMmZ6emRlR3R5UlpNWXNQU29l?=
 =?utf-8?B?WE1nVlhlSzNHOUpEa0lZMVpmczhhQlI1T0thU1FSY01XTWgrTy9zRnk0bWx1?=
 =?utf-8?B?b2NDTFZRWEJNL3hNaXQxMEkzV2pVQVp0TEh3VHpGb2NXSHFqWHBqTEhCd2dt?=
 =?utf-8?B?emRFUjFrZVJqWUdIYU02Zy9WN2VLNXlmMHk1Mk9TendudENyM3hwWXVtQkl3?=
 =?utf-8?B?Z2l3N0RXMjVNdTd6M2ZaZ1lWanBSNDdnd253VWtVZ3YwaldJaWFjK3UrWVNn?=
 =?utf-8?B?c2tKcFVmZFZEVXQvQjkyck11UitpOXRzWUh0cDRobUhFS3dBWWNMUEJTdHI3?=
 =?utf-8?B?bXowdEhubjhNL0tVeGorNS9sUVdVYno2ajNWT1VqWVpldGRha2VFTWtLeWhj?=
 =?utf-8?B?ZUdXbDRiWmpSSDR0TnVPZWh4RVcrK1JzUWpVUGp0U3FXem5ZWEVWL2FFaDBr?=
 =?utf-8?B?dzY5TXd1emV4cDEwVkdHTXYxTklWait4MXBqVTN5S3A2UVlNSVZ6Mno3dlZz?=
 =?utf-8?B?L0FZVXNuTm5EQTIwM3VnUDZaQm1jRkErakgySGNlYUhUOWpFNmR1MEF2akVF?=
 =?utf-8?B?VDFZZThlN1ZYdFhrcTBTZWlVQ3pSSGVxM3JqSFk3cVF6Y3RRQnB0VVdVdDIz?=
 =?utf-8?B?b2s0VHZYdlRzbkZCVGt6bmYvOW13UHdLQ1YyVlZNc2pqTTNhUW5BelNVVFZ0?=
 =?utf-8?B?L2ZKNFRGeElObVBLR3k1SXh0UFN6SEZidERSSGRxVEI3MmJaR2N4OWxMdnN6?=
 =?utf-8?B?SUFTMXhSS2QxUWZ0dS9rVm5FZTJnN3NIRElIYk1yeW9maHN0dzJTNjl3MUc1?=
 =?utf-8?B?MjV5VUhyYmIyZGZvNlVyMm95Y2c0aFJ1V3B5dXNWWkJQSDhSS3Zha05oSTJH?=
 =?utf-8?B?VHl6Um9vN2IwbGw0aHhpSDBJeHl0TDBTZE1TOURCdkhvNjBUMUZRZURRZzFV?=
 =?utf-8?B?U05STkpJUkFaQ0tFQlNjOTBoL2Y4RGoxS3l6aTFLVjMwVGVORDZiZFAxWjB4?=
 =?utf-8?Q?4zNmZJZNKuYU03J7+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc02879-f874-4b97-073c-08debd509643
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:04:55.0909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdi/6k2+epd9rnq3YJAVCebdlcs7dUVQl6kCcHbxavFKQRP4fZCLtr+zcbzz6Ur9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024
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

On 5/29/26 04:27, Honglei Huang wrote:
> Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> moved mmu_interval_read_begin() out of the per-chunk loop, the
> captured notifier_seq is no longer refreshed across retries. As a
> result, the existing -EBUSY retry path can never make progress:
> 
>   hmm_range_fault() returns -EBUSY only when
>   mmu_interval_check_retry(notifier, notifier_seq) reports that the
>   sequence is stale. Once the sequence has advanced, the stored seq
>   will never match again, so every subsequent call within the same
>   invocation returns -EBUSY immediately.
> 
> The "goto retry" therefore degenerates into a busy spin that simply
> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
> finally bailing out with -EAGAIN. This is pure latency with no chance
> of recovery, and it actively hurts the KFD userptr stack: the caller
> ends up blocked for a second while holding mmap_lock, only to return
> -EAGAIN to the restore worker (or to userspace) which would have
> re-driven the operation immediately anyway.
> 
> Drop the retry/timeout entirely and let -EBUSY propagate straight to
> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
> handled at a higher level: the KFD restore_userptr_worker reschedules
> itself, and the userptr ioctl path returns -EAGAIN to userspace.
> 
> No functional regression: the previous behaviour on -EBUSY was already
> to fail with -EAGAIN after a 1s stall; we just skip the stall.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 5d72878c8..229c30867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	const u64 max_bytes = SZ_2G;
>  
>  	struct hmm_range *hmm_range = &range->hmm_range;
> -	unsigned long timeout;
>  	unsigned long *pfns;
>  	unsigned long end;
>  	int r;
> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>  			hmm_range->start, hmm_range->end);
>  
> -		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> -
> -retry:
>  		r = hmm_range_fault(hmm_range);
> -		if (unlikely(r)) {
> -			if (r == -EBUSY && !time_after(jiffies, timeout))
> -				goto retry;
> +		if (unlikely(r))
>  			goto out_free_pfns;
> -		}
>  
>  		if (hmm_range->end == end)
>  			break;

