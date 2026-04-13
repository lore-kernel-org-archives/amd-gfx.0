Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B4F34C49
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 13:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39140890D2;
	Mon, 13 Apr 2026 13:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cAXsm/Mu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5B710E449
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 13:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=silEArSXATfqI4Lw5YyHMvuivf05IvpL73HcI6/tdcqX+fr8tH7qwJ7OzACUXrKB+jnH8jwe+zG7bLt0eeGZ4BaqatVItSFEVrEhamzthVEpzL9ffsbAs9eveyv9vBzIeagER06WeIN/6qvuZTRuIITMFGeOmeOJbUe5vNlxutiNsGk8iSCS9msnD4wOZRwye415RlhAiUEb9/B0kJqHFg8E1Nz0azkAL3odmMpNMVtp/AmCitrpRWhBBZmwJokxRIXa1vFdzCXismTCCns1qrg0b6s5xX7D0bcMz2gnyE6z+weiRDatN7loNqbiMDCIlqoI+sYhrXnWXeFom5vzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpjzeUVG+JMdOrPQtI3aQwhu8uAvICm7NEPlUwa4TuU=;
 b=ei0icZb748yURxwiQ/EiIW4l0oZUCpX7eMu1jFgbA6uUpiSvnzAeJK35nPOAihV/VnA9d4IdYFnrw3L9uV/9X41fYhas19+vLu5ohYiqMRslZqza4Ja3+wYu4os/LOG6tU4MVLCgrVjkiyv+AvUELWb9dzIfre3r0k9aIo6bj+/MMAi6tkUha2Ahbbz2oaNHqDcyPwYAhN0u47KaP8LjDGBtlBWIkaS3ZSMHH5YA7AfgOM3FX/Zpt7fIq5KgBr3dvA7cZiFHzc5JFnEa5r7R/OinlvLcIIbnqLCuDUoL3z3pEcAjLBMDEDOV8CpsaCoVchNZyAzb4p+oqMdn+5kGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpjzeUVG+JMdOrPQtI3aQwhu8uAvICm7NEPlUwa4TuU=;
 b=cAXsm/MujU+HHro5iB3t7pem1R8PNdqNoH2I7JgqjNW3fcFJ8Uim+Ni/dMHoec2v5ufuXrKzJeaADWglt2BR5Pa3Xj0YqZ3Fgdcy7a9JtfLkQK5Hr+o475S2T1lfEWewG62UR46O9SfBLfmkCXbWii/ztAeq9UpqeQBGUDrZ1P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 13:25:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 13:25:48 +0000
Message-ID: <7a2a38c1-4efa-4a84-ab3e-a32a011616c8@amd.com>
Date: Mon, 13 Apr 2026 15:25:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: drop userq fence driver refs out of fence
 process()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260413125918.3467129-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413125918.3467129-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0476.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd46bf-959c-48f2-7349-08de99602cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: evj6QjAIFGYkF2ACTt5QLj5wqCgUPpn3LIcbswsWtagFHyL3JXezqyjy0kU9G9IBZlQvZb1OekF3oxEZ3LxcNa0rMtUvhh2kv0KY7GlQflssCpspt9wtAsspobqkgVnGpI4QpeuCCwnVyCuMrFy6leA0nFqUeKUzGX5+28WxZ0dGrLpXM7moK41zTmOl8m2TjuqpsXBNYFsuPXopvkVq7Wci4NGCpLEyNAMwWQRC9//efnyjHTcLR0NAWJFQ3OXFnxNJLDa+kpuPZKiFdXfggHDloOgsRt5XQt4sdFsrdhZ7TiX7pKrI5QKur7QXLU4+EPJ0D1ICEvwUw7iMVcCXq9PLF5UTiJrrwrsUnzVqfcjKzL6XFdlDUXisdRx0js80TL9QD8PvOwRcO5AJu/XDUoKQACiwWCmVuxRKkJqdPr2LtAxNJlPlHcSlnq+e5qGEx/JzP20Ij3SWbWMyIK3WNCsLjfvLPFbUh8qyd8CeLJSm5Dv16HadlTW3hezCDikSXZUibZawIzRfQsHoxf7gLa8evOFqL+0OJQXDaxqnmTILiF3wgTCBy7xEk1Mij9BQ6+7DVAxHrPgB9myaJg60kAYChPntupJ6e2u149A40iguWIaIzp0TJi+JNvQKLpoEFExjXn1/DRDQ96b9HrG+5Oknzl9QnlYuHBWpnD3KFqXoNr+wqXJ/a26A+Xo5ulx70JgG1gyTE30rpWCOPScEe6iYLeZ9cgODyDiO0mlSf00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZXd1J0alRzZkdxa3dKaWR6eHpKc21jbGd2dTJYWDIzaVJTYlFDenpwQlBT?=
 =?utf-8?B?UC9SVUtoTHpIUkRGc0VvWE9wMWZ1TjlOT2lBL1BNUzc1S1NZd1JIUkltamZk?=
 =?utf-8?B?MVoyZ1ZlSjd6OTVrTzhONE91bllERFZjVUJkNmVxcDJONU1XV1JtTG5CSTZF?=
 =?utf-8?B?RVlvTmlkbFd6Q2lFaHpkNld2Tm95MjF5ZE9zSkJjSDVKNE52MDZCaDVndDR2?=
 =?utf-8?B?SDhybkl4Q1RSRWhabmN0MmRtclE2NDVWOUlzOUk0MmNSZld0ZXR4OHhiWEhL?=
 =?utf-8?B?d3NuSk1KcnUxUEZGeFMxbkp1VkVOdHBwcnRZUTNuNGs3VDJhYXpTeEU0dFZC?=
 =?utf-8?B?MW1pdTlLcGdXblBvNVhGci9jTW5kaFRMNHFIM3dYa2lTVGk3Rzd0NVY5NHBJ?=
 =?utf-8?B?d1MvYUlvSjZKTzdWemg1Tks4L1ZuaHZWSUllVlpJVHFtbHNvSWd5WWpabE1n?=
 =?utf-8?B?RU1XRktCNG4rSDRPb3A4UUdubUo1VTNoNmgzMElPRFZGR2VRc001OFBuaDI3?=
 =?utf-8?B?RmMvZE42cTZmbzZtZytBQStqcVJHT1JIZG5nam9GOENZcUl5clFmeS9lQ3Y3?=
 =?utf-8?B?c1pqT1BuOG5mRXVucWFSUUE4b3VGSWJCOFBCak41TVBsUm5OYUs3WVY3V0pD?=
 =?utf-8?B?ZEM2ZGNSK1dPTjYwcGRnRm1kQmhCV0JJblMvUjFaMjRqN0RJRGVhS2lvZzg2?=
 =?utf-8?B?R2lsSFRmTzJVQjc3dExUVTR2MEpwZG01UkQvd1huT3ozSmQ2RHpEV2k1WStE?=
 =?utf-8?B?aTZPQmQzYVBBeXJZTTVwM3NVUXlnbUROTnVFeUJWYklNYkR1RjlLenlxbmFY?=
 =?utf-8?B?VXZhYTVsWXhzdEk3V2RQV0tKOEFHNGZMY0pSTXk3cERyS2srNU5raDM0MDNH?=
 =?utf-8?B?SlRoQWdndEpPRVhsRGp4ekFrTm8xR0wxRGd1ejZreWhFQmh5MnEwSE9ITi9T?=
 =?utf-8?B?ZnNpUkNBWnF2dEJwcGVaUU1jdVloMGk1bUR4cW9hcWNWcU9sZ0ZlRG9jMGJ0?=
 =?utf-8?B?MFdYdnB5dU1QUHI2S2NndlMzOG1MdDErSFVkSkVFSjlIeW5hTDRoT01DK01U?=
 =?utf-8?B?clVUcmR6eFR1VHk2R2IxY2RnR2dVUXp6d2FvMXI1aXVvZitSaDYzcHUyU2lr?=
 =?utf-8?B?TVZOYjlnTlNmQU5CaGl4MFJQdUZvdDJtUk1ZWERzQ0FOb0oxRjdkeGFPY1ln?=
 =?utf-8?B?Z2o2SmpOTm84aTRGMUlkRGZQc29OQTA1a3JkUjN0RTZ5V1Fhc2s0Qk5yUnhO?=
 =?utf-8?B?ejJSOVBIeWVNYnNGYVNWSUVBVTQrUWsxRGxpTTdrRnBZeHdUZE8zKzlPOTho?=
 =?utf-8?B?Z1orSVhsYVdsTUtSbEU1Y1Y2akRmV1RIYUlXNmhyYTdGQVhQaWs4TWZDS1dH?=
 =?utf-8?B?bWxYbHlJSkVGWkhETU9SdUtTdEdFUUtrYWFDeUMrQ212SXdwMG1JSjhkV053?=
 =?utf-8?B?bjc5T2ZHNHBUQkphQWhKVTdPN214SW95bHd3UjdnUTlHaXlwbmtpZzhGU0dh?=
 =?utf-8?B?SHUzKzlWazBrZExxaFhDc1BpdDF1ZllWRDQxWVlVSjUrb0RtaWloTjhDdXVm?=
 =?utf-8?B?NVh5V1JhZ2R1QVhhb29OTHpLUXBPa2liWFVqZmcrSFZLZFRicDNBUDRVMGZH?=
 =?utf-8?B?YVdHb0JDdnd2L0VCUlRJeGFsRVR0RS9ZNGxNdk1tdCt3dVAwdzFReEs5aVA4?=
 =?utf-8?B?UGh4R2Vqd3R3YkdaaXVtR0tCcGtwU29PdUNwTXhjYmh0b3l1NE9SSEcwbEZ1?=
 =?utf-8?B?bENuKzAvaGNkZi9NUjVtVk5BcHZOL0ZPSUNtNmNUU2FjdnNMbWFiNkI3L0xF?=
 =?utf-8?B?aTlmTjBLU1hPNmc5S0NreGRUY0FOeFZ1VVRUeVA0eGIvQU1MMVY4TDdPYkF6?=
 =?utf-8?B?bFJaYWoxdzNFY0U2Z2w0eGtadEt0aHJ0ekhRR1E4cWl1QzdobS9qNXZRbnU3?=
 =?utf-8?B?V3BQZmFlSzJ0czU0c0NBZEZmTXY2QWR5eFkvd1ZUejZxN0hIR0kvVlE2c2N6?=
 =?utf-8?B?dkovNk1lbXI1S2FWeElLL2YxRDQ2bi9pYkJtRlJYclhiNjJtZnZxY0NZMmRz?=
 =?utf-8?B?aFc2dFpKUzFCMS9pckI5azZuQkRIOGlxb0crSDY4enh6WWRqbyt1THVPWjVJ?=
 =?utf-8?B?VytuSUQ0RkQxdWFaM0tJQVRoTldXb21xSzNFd3I5UE9zYVdQN1M5cFdKMFdZ?=
 =?utf-8?B?dGdXc2pOa2tZRGZwVDdjZW0xS3QyTTFPY0V6U1F5aDBUOXQvYnMva3pkWWFP?=
 =?utf-8?B?TFoxaERBeWlKbDhyejZGUXpxM0xvYzNTVTJ3bmR4Y0wwU3owZ1RRY0NpUzla?=
 =?utf-8?B?eDF2UjBIVi9JZWxNN0lvbjE1NUpucnlaWngxVXA1bjBaZFVPY0t1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd46bf-959c-48f2-7349-08de99602cea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 13:25:48.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaMkFkWnhoBIWlIjlaEwSr8mfsxY7cFgAFZxFJX5GqNNN3cQJQ8//Ywh0AXTJzHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

On 4/13/26 14:59, Prike Liang wrote:
> amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
> drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
> created, those references are transferred into userq_fence->fence_drv_array
> so they can be released when the fence completes.
> 
> However, those inherited references are currently only dropped from
> amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
> such as it is already signaled when created, so we need to explicitly release
> those fences in that case.
> 
> v2: use a list(list_cut_before) for managing the signal userq driver fences.(Christian)
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 56 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3be80a82788a..ce3446a77c88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -145,35 +145,56 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  	amdgpu_userq_fence_driver_put(userq->fence_drv);
>  }
>  
> +static void
> +amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
> +{
> +	unsigned long i;
> +	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> +		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +	userq_fence->fence_drv_array_count = 0;
> +}
> +
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>  {
> -	struct amdgpu_userq_fence *userq_fence, *tmp;
> +	struct amdgpu_userq_fence *userq_fence, *tmp, *first_unsignaled = NULL;
>  	struct dma_fence *fence;
>  	unsigned long flags;
>  	u64 rptr;
> -	int i;
> +	LIST_HEAD(to_be_signaled);
>  
>  	if (!fence_drv)
>  		return;
>  
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>  	rptr = amdgpu_userq_fence_read(fence_drv);
> +	userq_fence = NULL;
> +	fence = NULL;
>  
> -	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> -		fence = &userq_fence->base;
> -
> -		if (rptr < fence->seqno)
> +	list_for_each_entry(userq_fence, &fence_drv->fences, link) {
> +		if (rptr < userq_fence->base.seqno) {
> +			first_unsignaled = userq_fence;
>  			break;
> +		}
> +	}
>  
> -		dma_fence_signal(fence);
> -
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +	if (first_unsignaled)
> +		list_cut_before(&to_be_signaled, &fence_drv->fences,
> +				&first_unsignaled->link);
> +	else
> +		list_splice_init(&fence_drv->fences, &to_be_signaled);

Please drop the local variable first_unsignaled and just use userq_fence->link. This avoid the if and should work fine as far as I can see.

Apart from that looks good to me.

Regards,
Christian.

> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> -		list_del(&userq_fence->link);
> +	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
> +		fence = &userq_fence->base;
> +		list_del_init(&userq_fence->link);
> +		dma_fence_signal(fence);
> +		/* Drop fence_drv_array outside fence_list_lock
> +		 * to avoid the recursion lock.
> +		 */
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>  		dma_fence_put(fence);
>  	}
> -	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +
>  }
>  
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> @@ -228,6 +249,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  	struct amdgpu_userq_fence_driver *fence_drv;
>  	struct dma_fence *fence;
>  	unsigned long flags;
> +	bool signaled = false;
>  
>  	fence_drv = userq->fence_drv;
>  	if (!fence_drv)
> @@ -275,13 +297,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled(fence))
> +	if (!dma_fence_is_signaled(fence)) {
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
> -	else
> +	} else {
> +		signaled = true;
>  		dma_fence_put(fence);
> -
> +	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> +	if (signaled)
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> +
>  	*f = fence;
>  
>  	return 0;

