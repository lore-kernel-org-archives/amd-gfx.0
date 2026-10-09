Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F8CA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 07:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C7210FF04;
	Fri,  9 Oct 2026 07:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqgiOrEr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67ED610FF04
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 07:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKOgQh9WotXnO4KQ1gy2Vv9s0zsY9QKSUkDpPxlCJC7eLrgP3wvwn/Sys+fBOC1WdtzjUYz+aqDbwYBWa02CVtvIrOyDfiiGWWUOVLRjaIougPhklVLukVl9deRD0JMdxH+YJMAsfIZwuN4RQ9OAI0R5WD86Xh8/0JQS+kwAxpjJmfYEJxjBxgMOmSav4QD3grrCc+V8kVIqqkwYlivjX2wSqQpKgw3gvM8JOxB/3RynRitY0FPnNNdYYlRJjbtoBRXM/uQhyIJXXxLZp9ZUQ5kY2QzuMoPo8oP4gCgZdlhutu4/2iyfAjhUE3zpS+K+e5NxacnQuejCxJvXBzuQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+LOR7Ycl2iIwn0QwP3QWoWMQtohV2mC4XtVbZOK0Bo=;
 b=tvYzjGboj5hd94QIEXxIDDogPJg3wiLxV2w24JlR3aUkN7/QW63459dsGiKi/L2kadMZ0U2WbdIiwcGTqLOJo8QcxFm2Ugx1yR4KtNwCLqU0o1AxfurDHw7Xx7C+MB+RWBmAtYsVj29FwzYrOZNZGMkHCh0qgcnWDG5CsqPCV6W8n2ETpU42h1W7qv+VX4U7gRQq7WEG+NvSVtjp0cETpv6tOthalfg+85V6h2T5VgIZcn1uX4oPDOCNctTktPWggbcWAqkgYUwPP50cy2M+qFihPeDFfMjlrsbRguRuJXRjkEW72OuzWz1TK4cldbu288mcCNF2hcW22NkbsPNm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+LOR7Ycl2iIwn0QwP3QWoWMQtohV2mC4XtVbZOK0Bo=;
 b=ZqgiOrEr8tb8XdRhKx0ptENm9DGd+8gb7SnnXWhLiZzJKLtcsF1tkZ3/cUf5TDZFcZpr2ksvHwSS+JoV4x+GID/kbOKqZ9g+O4/Z4NlQ+GhGJfiMtBklIeL5c+yttyOrPnDELfS5wf25LaLvUJU88S2F8H/4j9k4jVp1qrpd7FI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 07:33:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 07:33:35 +0000
Message-ID: <6ae4ed50-daed-42cc-b841-dbc37401b579@amd.com>
Date: Fri, 9 Oct 2026 09:33:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix the error path in amdgpu_vm_pt_alloc()
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261009015716.3935954-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009015716.3935954-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999131:EE_
X-MS-Office365-Filtering-Correlation-Id: 15207fd9-62ce-4ea3-2c69-08df25d7a095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VBLXpRgkdJUhIWEON2hWZtEzQLKrx4HxuBVYBYq72dZBCaUvbb8IjT1osPPOO5kim3RvsD7SYTZG5mY5JvSF+9rbRd93GfKHosiwclOKJC0DFiKpafhjdR3Q+wIA54bUoYudKFGUZYvWhNmSRHOSPJwE5uVFvJezAcYtFtRtX3Qg0n70Aex3qpQ85R3tiUT4oU27WqZUEQ6Ylw2PuNEw73VoPzy3TrdEHGHWzWOwZBqMHZ5sYiIAjpPx1mpYJqEWtdpK5agvjsdmVR9ctlnh8Kc++ltOFjk4In9DQ1UYsD48jXleTiP/807cOKJmY9aUSO+zSWt6decInVxKHQHu6/jFSafwSeusqhPNcyCLx3xvIKjHT1mNuqSZm58ZxLiFi3YokXrZKjbSqdogvg98pdpwQvYcscNtDcYcvN/YC9G6Lf07fFQNGy2qeCsZqg+aXaSIKawc2+ZulzC/yl52WUjIx1ucCBngDjjJPkS/Fkedrd8RgSdUPKq+Ef+PJux5dXDvtmREYfFhRrB4zCPiJoWBolxbzcv9kUgjayHTx7XOZ5U/rXYuVm8zNyG4MB0WsVWjCyqB/cWg7XhE2NAyQ/u0JhPx2zsYIesXEIVs01NaMBA/jfD8xBSz2GLpjHTIzcCSn7rP/V9e7ltb8s/BvThjfR8QA/EjDkwFVez7xos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25EUXN6L0plSWdsM0t3cWhXTlArbVVsdnBRZlJVT2REeDZaekJZZWJzaDJQ?=
 =?utf-8?B?ekgzZnNFeldJVUdDMWVhSEFNeVZieXBuZXl0NGowQ0NEblpkNk5zNUM1RDQ2?=
 =?utf-8?B?RzhUTmFXQW9aUURKVDI0bUdhdzIvcHdBeHBUWjdUNnJ3RmExUFJvYWhPTjA0?=
 =?utf-8?B?d05KdndHNFArQVVqcjdzdkdkaXJyaHFnMGtXUE5xaW8xYTZKZFJheXdsOG9K?=
 =?utf-8?B?TnlLNUQ3ejdwTE51dk9vdER5OWdmdER0dmdKeU4rVnVrSWg3Y1RWN1BNNFZS?=
 =?utf-8?B?ZHMxRFFlbXcrSjhyOFphdWdDT3h1YURZZXJzOEJ0NkNFVEVWSTJOdXFBY3lz?=
 =?utf-8?B?aHdqWGFDcUFRT3RIdTR4ZjBNQWZETkEySXJsWGxWZGVjOXBCT2dxakJJRVUx?=
 =?utf-8?B?S2pvRlA0RU5MdXhnc1FkajJkbTFhdjVKTXlxWGdXZmwzS3hKVFR4dWFLNWZo?=
 =?utf-8?B?d25DdzhkNmZmLzkwdjVJTGgydW8zMGhpYjMrQm9SM3ZvcXZzRU1YaDROR25p?=
 =?utf-8?B?V0ZrQWlCMnl5R2dQS2t2c1oxTmYyS1dOejEyc21jV1hpY2N1dGd5RDdFMUdG?=
 =?utf-8?B?L1EzWVBmNkVZUGt1RnVJOUc1SERqM1lvcXBjbnpPWlpKZE9Qd1V0NWw0c3lF?=
 =?utf-8?B?dWhTTTJlb0VGUmtiSkdrZXlLN0Rza1FTN2J1ZXRSY0oyajBNNUdYUDVEUmhS?=
 =?utf-8?B?L2tYY2MxSGllUEMyUWFsTzJiQTUxd0VzWXhDcW40SUNGTktJUXlaL0VBZTRF?=
 =?utf-8?B?b1QrNHJqdDZZMlorNGY3dm05amdHYy9MQktQTEVKR1hYU3RKUk54R3RHd1lZ?=
 =?utf-8?B?OEw4TkdPVEp5SlJOdEhNNll6V013SkZnZlB0LzNBeE45VW5pa3NLRXhJTTZj?=
 =?utf-8?B?N0hZcy9rK2Iva2JRZGthRFY5OWhXMzlLMUNiMGxlY2ZnUjZCcHBZQk5UOXJl?=
 =?utf-8?B?MUJPTmxtWm14YU5wTXBHdWtOUXF0UkdqM3pBSDhKYnNEQ2VDMWJpTmJ2d3hN?=
 =?utf-8?B?VVJUa1Zrb2lraUgvS1NUUDdMMndCVjl1cW9lbjJVOWxZQzNtUHd0ZTZNTWJv?=
 =?utf-8?B?Wit0NzljUnk3Wi9ORXBoZE1qWFhHYjN4ZHQ0b3hLVnJ4aXZJcjNjWlNFV0w4?=
 =?utf-8?B?SmVsWjROajAxNzNybHBldUJicCtubGFlVW4vQlczdW9BSUJtenFYOU5rdTJB?=
 =?utf-8?B?SXBNa2xaZjJjcDlGYk5FQlJ3dVM2Yk01bTZuT0pKcUM1SHdOYlYvT0xiaHE1?=
 =?utf-8?B?dmZ3SjkzUU5relh5RXFMa3F2ZFhvK1cwZkhjK0R4RzZrVnFqMEw0S0dRMzVZ?=
 =?utf-8?B?ZVZyN2N3dW5pcTNHSjhLQkNDSnM5THdOenk3b29tODRXS3RpeEdTSTRPSXly?=
 =?utf-8?B?STFLZ1ludVpncjltNk1JQjJIMzlXemNlbWNaNW9GY3AvcTBldWFFNXVHWUFp?=
 =?utf-8?B?N2pGZ2ZuM1EvKzExZEN2Y3BLZFI1RndOTW5YbHNSVG1oSU55R290VVpQeVVT?=
 =?utf-8?B?NE1qR1R3S0FocUFKbUlqQ2RyUUZ0a2NNZkZRZGxwNlc3MzlVSnJuZGFBcFhp?=
 =?utf-8?B?bGExYWdWVUd1T2wzU0IyZDh1WHRTZjc4NnZ3WDBIYXdOb05DeXUyMnRreS9F?=
 =?utf-8?B?QWtzQzZDZms0WjVjNkZUUXcwd0Jxdzd1VTB1N1R2cmZSREdpRTVKVytSWnQv?=
 =?utf-8?B?Y2FCR0ZvUWt3cFZCMGVVZ1JCQjdmWEpSMloycWtmL2F5MngrUjFueTVHTU82?=
 =?utf-8?B?NkpkMWR4OXA3R21tSFJ1eUlyR0RIL05tMjJLQU4ybkhTSVg3RUJaejVCNUtB?=
 =?utf-8?B?RVY5VmZvS1F6Sm5UazlhUmVHTFZOdDRFUmRuR05kZlE4cjRIUTdlWmRYVDBt?=
 =?utf-8?B?LzlFV2tTNFBKalo0ZjdRZVMvbS9pVnkwbUwvZDFZU09HVWtDVHowUjRreDJ6?=
 =?utf-8?B?YXBDQ0N3bTFoaWlZM3oxYXQvbDNLNTJPRWV6TGdYUzI3OTcrN1loLzRTdWtD?=
 =?utf-8?B?S3FYazNUQ2hRYVF1ZThKRzdIR2kwZk8vWFpFai9saWQyMER4cEd5L1A1amk3?=
 =?utf-8?B?ekFuZDgrdWpCa3VzWTBsTjRGZXAwbTlSdDE0eE9sSndVVzNRNGlHWGtiaFcr?=
 =?utf-8?B?YTBNZEkvVXdiVU5FUjg3NVIwbnhHeDU2UUl5RkF1b0ZZUHJ2QlJ4dmZiZkxE?=
 =?utf-8?B?WjFpdTQ4a0VkYVJBWDhOU2RQeVp5Z2pBdll5VmJ6am1rWS9mL0xjakU5Vzla?=
 =?utf-8?B?SFJCTjRobEJUWWVnTG1xM015ZGdQQWZudEJOUU12RXhzTEhPMGZaZ2wvT25Q?=
 =?utf-8?Q?lVLuq+jmJcCYowbV06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15207fd9-62ce-4ea3-2c69-08df25d7a095
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 07:33:35.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+6V6k4RkTh/AutVaY0JVNTmuIUepj3qpblzh8G3YvJKwLGe3s8fTSHAEv8g5KpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131
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

On 10/9/26 03:56, Jesse Zhang wrote:
> amdgpu_vm_pt_alloc() drops the eviction lock while it creates the new
> page table. When the VM started to get evicted in the meantime,
> amdgpu_vm_begin_critical() returns -EBUSY and we jump to error_free_pt
> before pt_bo is assigned. That unreferences an uninitialized pointer,
> leaks the new page table (still pinned for NPA VMs) and returns 0 since
> r is the result of the successful page table creation.
> 
> With vm->evicting set right after amdgpu_vm_pt_create() (what
> amdgpu_vm_evictable() does when TTM evicts one of the VM page tables in
> that window), the first GEM_VA map that needs a new page table oopses:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000460
>   RIP: 0010:amdgpu_bo_unref+0x27/0x70 [amdgpu]
>   Call Trace:
>    amdgpu_vm_ptes_update+0xa4e/0xa60 [amdgpu]
>    amdgpu_vm_update_range+0x2eb/0x970 [amdgpu]
>    amdgpu_vm_bo_update+0x325/0x6d0 [amdgpu]
>    amdgpu_gem_va_update_vm+0xdb/0x1c0 [amdgpu]
>    amdgpu_gem_va_ioctl+0x86c/0x940 [amdgpu]
> 
> Assign pt_bo first, unpin and free the new page table and return the
> error from amdgpu_vm_begin_critical().
> 
> Fixes: 1e0041e2ac56 ("drm/amdgpu: rework eviction lock handling into critical section v3")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c03327f1242d..599c0085cdd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -531,13 +531,16 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	r2 = amdgpu_vm_begin_critical(p);
>  	if (r)
>  		return r;
> -	if (r2)
> -		goto error_free_pt;
> +
> +	pt_bo = &pt->bo;
> +	if (r2) {
> +		r = r2;
> +		goto error_unpin;
> +	}
>  
>  	/* Keep a reference to the root directory to avoid
>  	 * freeing them up in the wrong order.
>  	 */
> -	pt_bo = &pt->bo;
>  	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
>  	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
>  	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
> @@ -549,7 +552,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  error_unpin:
>  	if (p->vm->is_npa)
>  		amdgpu_bo_unpin(pt_bo);
> -error_free_pt:
>  	amdgpu_bo_unref(&pt_bo);
>  	return r;
>  }

