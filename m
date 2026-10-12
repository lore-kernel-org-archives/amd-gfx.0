Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF58CA9ED0
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 10:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EEF10E428;
	Mon, 12 Oct 2026 10:07:35 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98CA10E584
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 10:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImZL5joYsZRZVCq+JfUcD0AAHJve2GUDjUgkQyMnHKAgOqN2zJ3VqsZR2wGQd8aQHNn5DP7HmW0T1QQa69Ft2GwgpHb6MQYMnTYqGB95UXjKZyEP4lQoW7SDyv2SLNDxAl0B0oY8dNOO8hdIJFS4aw5ovprCWqz53sNN8JPpUZ8eG5RxOkFPPZFfTEDuGVLRfTFE56gaEFVsWsE/axt1rVYRjOzAzPxaHhJqRJOWgL0Ie3ZA03fShCP3NOoCrVJg+lWLynyjqW4q2eRXQFo8PhGyQjHC3w7qAdSp5/CKj4zj5cmMF8Qz+3D/MmcGjUoBgXC3x7J4UXkO4joxtc35qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bra8Q+WxczrF+UFEorSVMj7ppTdwr1ZZkgDO4yz98SA=;
 b=hjDICFdZJgtthNpmy1+uGMbuevMOrMwQ0qs1bqSpWDjZxd1XCW4bREZi9TjP9+5x2qAatvZPZa0KouWX164zYTZkVFdRa03cMR4ej9SEoJRWDX3EvKRM4ALY4NNZFPnXZM1C/E0KGMCWodBfr04fe6mkRwEGBlL5AqzX1UW9vlukYcvFjgZSriw/VtKyXgU31WVTD2wnL7pVOLLZrQrtZ/c+7BDfudYuz/+kHP2UHGrf8Gv5TDjZ9xrL0pehJAkdgyEoseh1nJBewnNVgtJioZnc5A242aOfTDKdgp61RrNO5+tfMuGeZe2ZiD0hWaZf+FZ9KLfWdaqoVFpye0J2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bra8Q+WxczrF+UFEorSVMj7ppTdwr1ZZkgDO4yz98SA=;
 b=FHnJIXOtJCF+mtp6V6BmROR7JK7Nekt1+A3Y1ufHalXVzmegWqU0Vjy07IRx1lmpx0dGemg0Xqe4RcwUeoOFyvsp0QQaM6sSWutK5D6Tb41KhPrXawivYfciAocyg9EDNScflHczxjKmlBSVMb+pVW4YKOwjMjZ3gVK3+/iRO5E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:07:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:07:25 +0000
Message-ID: <68ae0d1a-57aa-47cc-9d57-850e31c8f330@amd.com>
Date: Mon, 12 Oct 2026 12:07:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: keep the eviction fence until the last
 handle is closed
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20261012094754.1685828-1-Jesse.Zhang@amd.com>
 <20261012094754.1685828-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012094754.1685828-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f671f-952e-45ec-e09a-08df28489d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: kRPcfEh7zzMSLzoUyz+2CxT8Pj1V1V9FZoQf/aJIUGB+/UX5SdMQTy88DiQfeWl7SijxlsyhnTTT/yR3bJNF0TTRJHpWmxJn8YTK150cloGcZBnwRnDu3lZBCXkd3Q+AgwR/bH3UoArIWnP7a/SSskljCtV71H3UYsAF6GhpbXid0YeMQHvjfNM779P+2WAjOiidsA/b7+NbvFHRUuCZxCJVYAHNWlHPB+iWjBHaBveXnwT84FB1Nx1IWO2qdlm4Zv6OOV6tRzv9OvSzW8M/chqR9KPaVdjlKTL8JN+1catpu+nDK/XSEAAOo8LYKp6iWPfZR5Z17roHFFNmbJIaDiilrLFjxHxqUbAxEmuZ3hu4gQv+mGtlHkEoJoGbH5xI9ynIGvqTSqi9yUEq8rMweAYjrNryblg0ooURaSXl9mKfxBgYHorSq9+BiUbcQpoJae3LBlal4QEz09zaUy6TrvgatgpqRf7YaCmQOB89xy3eDy+r4h81tO7zJgb/KtcIBG5Xxw3suvUgN4UysSJeeoVPKa/KiFnr56MPL4AUfZjspmMglwhtucfYwFtzk5OQZ0pacmXe2s0jaf6Lu8eitwBXNXVPXQVQAZpTV/ItoWh7CjEkIQ1r7S+HfAjhh7S6lnvvkXooWBWUqDkPFi9CCJdtX0pwLBFbjojI88Dtsgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VrWWllcEdzRkdkWmRWNytWbEt3UStCQ1cwMW1rYVpRbWw0WEZlV1JGYVlI?=
 =?utf-8?B?N1YwQUpXYzh3VnJiQTBrU3J2aC9EZ0oyQmNzbWZtSFcyZGdTaWF3QkZOdlZL?=
 =?utf-8?B?d3JXNXErN0c4d3pQdFNWa25xeVN2Y0I4VENKcVJORHJYS2hXaGJ4amI0ZnlQ?=
 =?utf-8?B?NVp0RGRqbEdKK0tYVjZNT3Qra3pRMDRtTWc2emNIM3dkcjdFTS9jZS9SZWQ2?=
 =?utf-8?B?VGJEbWIzVGtNN0lmS1kwL3hZcXN0WlBXS0ZHa2NmdVdiZnNmSXdYQklXZGJh?=
 =?utf-8?B?WUsvYk8yZktVcmlMYlhFdDNyVG1hcTJoM1VaaHRHa3ZWTXhMKzltUHlPalR3?=
 =?utf-8?B?ZEk0a1lJdEQvNUVYb2I2eGF0RHd5eisyclVQbUh3YTN3aDd4WjdLN3dXOTVk?=
 =?utf-8?B?Q0xuVlRpUjdCa2JHWTUzZ2djZnh1L05xeUswMnBweklSbFMzcHZqVm95eUh6?=
 =?utf-8?B?TE1jcU9WQWM1MlBJTmNkU0tzREpCTUdwSUxnbDh0dVZ4RXUvaE54RGNMeTJw?=
 =?utf-8?B?WC8yRjUwNDF1d1ZuK1dERVZ2UHlmT0p6UCtNdzVvc1F4OTR6ek5yWktTcFlX?=
 =?utf-8?B?d3hRUldrRzZieTZjaG1hNDZjS3BMNElsb3VaR2NuWVgvcnNFNzQwVEhlVmdB?=
 =?utf-8?B?dzVxaG54WEREOTZHQVV0Q0dLamZqY0hhWUdDV1N2bElkYjRzMkVUbUFPaTly?=
 =?utf-8?B?NkJUdi9pQXA2djdoTUEweUZrWDhndm5NbTVkOXVtU1lNTEpHMUVGdCttakZT?=
 =?utf-8?B?ZWc0aFVrZ1dEZ3dqVGlLZEZ2Nmt1VVg4YlZrSTZ1UCtQNGhjdjZVakdqZy9L?=
 =?utf-8?B?Rkdza0FkZmp0VGY4bTR3RC9mdjUrRERWMU9sb0hlOGZrVVkwSmhVRzdqM2lD?=
 =?utf-8?B?MlQyS3pLQlgxSnYwRHNLRm05d2xZSnJTMnpUdWhxbEx2QjBpb2wzeFordklE?=
 =?utf-8?B?LzhFZkt0WFMxQnMzS1hOWkZ4WitWZitxdzZ6QTJ3WGxxWWdDMGpZclIyYWxr?=
 =?utf-8?B?L21FUGFlU2dQTmtZUkp4d1pja01zQjRIN3ljVjkzWTVocXdvVllSRm51S1hT?=
 =?utf-8?B?RFVxQXJTRTIzYXFLMmt3c01WNjJmQktpTE85dFV3L2VqUmlCT2ZrV0thRy9V?=
 =?utf-8?B?MGRZb0tJd3FOVEc5aEhzV2FrR3hMS3p6Y3p6ek9XVFpHNTlrSHNnZGwzSzNH?=
 =?utf-8?B?OXBQYkhpS1Z6aWEvMWYzUi9pZ1FDMTlWcWh2YzZTZkM1blUvUTExOVlkKzZh?=
 =?utf-8?B?RGh2dXk3ZzlIR1QxdWZtSFZrZE9KbHI2amdRcU5tN2kxSk02QVRheGF3TlJ2?=
 =?utf-8?B?N3lYTVo1WVA1RUtrbjBydnRQdHBMRS9aYWtjYUxoZ1ora3l3cFRIRjR5Szl6?=
 =?utf-8?B?VWZnZzFSM1RaWkJOdko2ZS9RV2ZoaVU2RGdLcWpKOCtkdTZvMG9EdTNVOGZD?=
 =?utf-8?B?eTlRemE5ZFVKbjFveDluR0ZtNWNPR29OUlIyaUh6aWFiYWtYN0N2WDdxQTR1?=
 =?utf-8?B?cklEektERC9iODlRZnFsWS9oQUN5RHdlVmN1NEdLTzJyV1B4c3RqL092RnAz?=
 =?utf-8?B?S1pIajAwaDB4YjdtNWlnR3ZFdE40bGJjbVZ0aTBvUFVETk02NFhCVUtDR3Uz?=
 =?utf-8?B?aXd1MkI4WTdIb1JBQ2JGOXpZRXZPeGtGaWhFZzVuMXVGb2RoV1VZb1JlNG1x?=
 =?utf-8?B?amFWSXdNTVM1eUJ5UGN4eTdjUFFvSWFuWXFmQytwWGdERXoxUnI5QVQwbUo2?=
 =?utf-8?B?NEJ5d2RkN2hpS3k0aHl1YzdHdEVRWTd2RExCZDVwcWVMS2lCK3hOWjJ3RDRB?=
 =?utf-8?B?WUZoK3hCb0V2cjZBVm00cGo0UDFZMHN6MlA3RStRQmVpZDltZndCR3NYZlE2?=
 =?utf-8?B?WFBPNXhkZmtVdzVKanVIMmo3NVJRU3ZLSjNtN1NVTFozM21YS0lMMFhIRHQ3?=
 =?utf-8?B?dmc3RUpoa3NRQUtUby93YkdGc1cwQWQ2cWFrRk00aWRTSnhzc1dyTHFwY2JT?=
 =?utf-8?B?Q21RWnFZTWxzZzJJNXlmclo5TDVScm0vNmQwdkRHMkFUZXJWTG5XMmNDRVJJ?=
 =?utf-8?B?cFpmaEFnK2YybUNTUU4ydUdGZUJKL0JxemtSMVFRd2JqczBaRnNoMmZMeUs5?=
 =?utf-8?B?akM2NkhjcmdhU3ZnU1o2ajJnT2E3WGZrd1dkV3duVlgxVUpxUHBpRnNIdHJj?=
 =?utf-8?B?MmtmTW9nQ0tKQTZFdU8xcTl1TFkwRDVLMk5td05adU9uYTNFdUhxdllUSjRL?=
 =?utf-8?B?SzVOS21XalhtTTIrakU5TnZIWmpHaCtjaDA5N1g5dTkvZzR0NDlJK1J4QlVI?=
 =?utf-8?Q?QI208DulV0FODPDIHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f671f-952e-45ec-e09a-08df28489d40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:07:25.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doD4sAh2s2D7GYRUdyqd+3Zh4hvae2kTNjQLxqv3Y5ZMy1zyVB4ve61ckGA1+OcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

On 10/12/26 11:47, Jesse Zhang wrote:
> amdgpu_gem_object_close() detaches the user queue eviction fence from
> the BO before it checks bo_va->ref_count, so closing any handle of a BO
> removes the fence, even when the file still has another handle to the
> BO and the bo_va with its GPU mappings stays. The BO can then be evicted
> without suspending the user queues of the file, which keep accessing it
> through mappings that are only marked for update.
> 
> Seen on navi31 with a SDMA user queue: a BO opened twice in the same
> file (GEM_FLINK + GEM_OPEN) loses its eviction fence when the second
> handle is closed (traced attach/detach of the fence):
> 
>   attach bo=ffff8c78a6c84c00
>   GEM_CLOSE handle=7
>   detach bo=ffff8c78a6c84c00
> 
> while handle 6 and the mapping are still in use.
> 
> Only detach the fence when the last reference to the bo_va goes away,
> matching amdgpu_gem_object_open(), which attaches it only when the
> bo_va is created. With this the fence stays until the file is closed.
> 
> Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8dbd7bb77305..0552b17d9aa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -351,11 +351,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  			goto out_unlock;
>  	}
>  
> +	bo_va = amdgpu_vm_bo_find(vm, bo);
> +	/* the fence is attached once per bo_va, so keep it for other handles */
> +	if (bo_va && --bo_va->ref_count)
> +		goto out_unlock;
> +
>  	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>  		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
> -
> -	bo_va = amdgpu_vm_bo_find(vm, bo);
> -	if (!bo_va || --bo_va->ref_count)
> +	if (!bo_va)
>  		goto out_unlock;
>  
>  	amdgpu_vm_bo_del(adev, bo_va);

