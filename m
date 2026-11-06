Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D0606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VWQc1Q2e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97212112EB0;
	Fri,  6 Nov 2026 16:04:23 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE50112EA1
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 16:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oivij7fPYZjldkJZg1Eiw9cfigH49bnopTUZpKlpN8CZxmnSL1wXnAb82J7kKpM8Cl7RGiLzbfOXjhb8fJElpTh4cQAaiFcAdmxD0rffILuTmqhsTRKHfbMvf8pSSUB870j9CjPzmMd6nEuDYE1MkN+EuKL0wnPcZO5+lfF5ZEcO9nwHpvEJY692RWTDdX4rLtKO3mhUxJ6W9rywQbFO331ihs72cLRN34zN72Kb8yc0jtHVC34AigVPj3xbBjaZz5rra3lZYJuuMbrgLHJmBUrFYbkSsC52igTlD2hr4uJvEKErKTxN/3a6xUawaoG1RoqEpsAtKS3dvjn8SHjWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YjC8bR4qdtj08NzsTsd6AWKH0GUDN5+WzVcvuTM0Js=;
 b=JGmprf7ymE6zwXvZer8bqicVXLsV+eoGWaRD7eahw4ar5d4sPVr3ve2Dq2VnYtn4J259BP2e3dGjNASSf4CDzICodGUxrthmpiFHr20RPjhsgqJ/obD+DtK9nEi0aBQnYWWLYz0EhMI6ge8cQSZ58Ah1qJAfZ6fCDJOPeAXptQ9Z6Xe6xNGr3Y1/oz8tnavT5T1LjE5Diel3xqC+5ozq6qGb2JsjK4fY/A+PDCl/yeFCyzWGHbCcmUkjRaDlEzp94lUXpcxMc49xladUnX2/myZJfQ0nzY8zjyWUDK8PUVgEV3dwAknuO/6hUqetjtNpCZITRWml5h9QTuDSIWlOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YjC8bR4qdtj08NzsTsd6AWKH0GUDN5+WzVcvuTM0Js=;
 b=VWQc1Q2eH9fNixgq8lHZ8JS1OUp1z9qsqINKDZ36B7Pr77ks92XATkw9kzY623fWwQZ33E8qZKwtDF0P3O+pBpVAXyme3p3/n/mDYUlUblxUWaX8NyYSjxVJTsOVeNptEF0rD/WPmkVGhAI0l2jPwoZvj2M0L3k5UIZWTNUaDHQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by FT1PR12MB917062.namprd12.prod.outlook.com (2603:10b6:170:2b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:04:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 16:04:14 +0000
Message-ID: <26bbdd2a-b26a-4e76-9eba-092a7e61660c@amd.com>
Date: Fri, 6 Nov 2026 17:04:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: wait for tlb flush before freeing BO
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261106152031.4040973-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261106152031.4040973-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|FT1PR12MB917062:EE_
X-MS-Office365-Filtering-Correlation-Id: fa075123-eb9a-49f8-7db1-08df3c1f9a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|10067099003|4143699003|5023799004|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: T5dzm660Qk8gDRgs6858pVQmDuWcf5aSYF5v5AwoTXJ0qyPgnERAf2xzaUCObW1m+jX+BNuhnEan6F7PDr7K2Y1hGPPwsUjO4kmj5YEV+BVHquZXvTQGYqQsy27th28AD+kXrR2QyzmyeS+u5kJ5sHP1bzKaYox6tODWtNAxVu9tCzogUQIJ8P6YMzGXnZZyfeXRUn3L1P8ZNaNXYVvcDQfRdOUD9F5sLUFGApLuTNM7pm1VlW15+wQurGOVmaUulb7k6afcTpoQsvgFlc7NJUEVlW+ZY62+OTLceSI3B+QLqn5ioucZhVz3EItWyiN0h4nKteaunuyl5z8ZzWRuID/P+taSuGzQ0ps5k4xnWhBPkA06G16WOmEZ3LlIwQoyrdH5SPWpEJyfL089WMo/IX3TOtiKKXJGYps5Z81TpopAFn0cV6kC4ev2cfpfUbH6QRtT8Mn8+S5bl/6KYrinP6ZoqddGDx57QVIb91TRIgUlY1Q5GEUZTAghf4uTp4ZncZCekDKdxGK5A4iYhplIjYBjBf7WiLx30Zy8aCUw0v4Q6vxxAbiQ/SVPfPz61YgDCm59MbUnxz2jLjQkftdcNUOzGitXygdj3hHSX2yPykDl05aKfNUGHi9CYEH6Nz/SseVppMrWxlynXxswnZrIOU3GGALKF4MIi6k89Maiiss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWFVN2tZM2U5N2tjVkRES1ZJSlFoUHpEWllsdUdJelVKa05maFZPSmRiRWRi?=
 =?utf-8?B?Q3J1aDIzb1Jzc1dtcFBPU0tUcHc3MmxaYzZndnF4aDJSME05TktEUnRIZTl6?=
 =?utf-8?B?TDNwR2ZoclR2SWVNU2RmVnlNc0Q5cnFIQTk2ZlkvOE1IRXN2dWxBeERsSnFl?=
 =?utf-8?B?U2xxNm9Ob2k2c1FjUnFuK280dUJYLzRaV3RtbkM0Tkt5MkJwQzg4aFpVL000?=
 =?utf-8?B?cVdnNmNweUhPT3pVWDVJZDlHWlZGMUFnWHNMM0tuQ1NLeXpmaEt3MlRiV1Mr?=
 =?utf-8?B?WDJlYUVQM2FxQlhOYS9HR3RZWEhtQzhRemRzaHFoVHYxZ3NUN00zTng1QVJP?=
 =?utf-8?B?d0hoZThhUnlmRzRURzU4TG1idXlXK0ZRckZkYS9DNk1WUVRiWlF0SnBZS2po?=
 =?utf-8?B?MmVCcE5sU1VRQWFoSyt2cEp6THIrd3RUNlREZnFRUHA1eGFaVExqMG12ZnMw?=
 =?utf-8?B?N2NkbzJlWXVFNlAxdnoyMi9QMy84SnBaVERqR25nUHd1YkhXdFJYbUhaYXNU?=
 =?utf-8?B?cDZnLzFyZ202NlpFRFh1Vnh6eGdPL3NFWWlwNDNCb1VBMjN1MXRvaXpSVlhW?=
 =?utf-8?B?UXlvdHRxMkJqZFhHNkliY0IzQ0pqRmk3MDB5dkkwcE9UNUVObGRBc1dqY3VN?=
 =?utf-8?B?dTVSc1hPWEw3dFVxMDkyaUl0M1pIQUxVa1Z0V3FlWXNQNk1rei92ZSsrV1Rs?=
 =?utf-8?B?cVJiZHlaRG0rNHZLTGJEWGRkWnlPM3JjNy9ySXJpME5VRVBQaWNUNzRRMHRH?=
 =?utf-8?B?ZzVvZ0lPQnhjRzd2RjdWVVJFakhTNk5pVGtUcjZIRS9pOGtUbmVrOEZkL1F2?=
 =?utf-8?B?NENva2NWV1F1NjM2b0srYUZ1b0dqWWRWZGFiN09FMFc4bjhtWXVtZnpNd2dq?=
 =?utf-8?B?aEltZW5iR3k5RHRQU3l5VHg1c3pxaFpDRjB6M2M2VUZTZ3YxZTdFVHNWZkRl?=
 =?utf-8?B?MHF5Zk10bzFBc1dJcy92aVZDWTliRFNHV3JiUEZTelFDYnE4R3JDclFYU05T?=
 =?utf-8?B?U1lqU3pqVmlBRXBtODg5QVo3VTlWZWVqYUZKcjNIc1k5T0VLL1NyL0JFeUNx?=
 =?utf-8?B?MHJuWU52bGhraGQ3MklUZ1hSWmtoZ0JjRENVc2lEOGNWeWk4MGNVa3IzV3JB?=
 =?utf-8?B?WWVUTTdDbUN1NHBFSGdMUGJIWm9MUUtWZC9WQjlBazh2UEd0dUxidldCcWE0?=
 =?utf-8?B?Vk01ZzlSQ2t1KzdoQkdCL0ZkNnkxclFtOFdCTjQvR1cvS2oxb2xTT0QvWFhK?=
 =?utf-8?B?QVNVb1BBWUlPNU5kY0tJMHlNaFB4QkFRVGpJRERtc0pHRjhFeWNjSjZVdTc1?=
 =?utf-8?B?SW9iWUhZSmlPWHVRSmlsY2hON2M1SlpyM1pPeFhCS3BRQ1lLRVMxSFBOaGw3?=
 =?utf-8?B?c2lYVFRFQjNFVWFTOWpGSUR6OWNEV1l5TlJ0UU1HZ2ppZmt5RVVzWDk3N0Ix?=
 =?utf-8?B?elkrRy9LRk9aVlA0bWhGSWx1UkRNRVp6WTBUQi9oaTRyQzFmcHNUQWpobVFS?=
 =?utf-8?B?UUlzRkNsTmJ5TXB1aGg1bUU5ekhWck04cmlUZG1mUjNrY096ZTB0UW5sUUQ3?=
 =?utf-8?B?VFE4U08wZXV1S2RLSlZSL3p3WlFYSEZSVUR5TjdtN09ETDVKZzlSeDBtdExJ?=
 =?utf-8?B?QWQveCtoQTc5a2J4RU8rbUxtM2NvSlZGRjdoVTRTRkJjUEVVajdMd3ExWXlk?=
 =?utf-8?B?dFh3UFY2d3FJWk84bFcrNzJqaVhGWFVuNFY3U3VpYUtGQU9udGMrZW43ODQ5?=
 =?utf-8?B?Y24xSENTWEo1b0tFZHVOTUQrK3NWeHBiYk8vaTVSanVhNUJTU29TMmdyUmpl?=
 =?utf-8?B?MHF0N3MrNkxJb0JQcmE0Q2hueVROU2R4UmUrQ1k5TUpsSGZKeC9kQ1dYNlBz?=
 =?utf-8?B?SWFsSkJlVm1tZDJkK3I3Y1kzMThsNnlwdE1DOHlUQ2pFR3hTTmVvTGE0RGNO?=
 =?utf-8?B?akQ3TDg3QjVQSHlXczZzeVNrKzI4SkpCaS9OWklNdjIxWDVETjNwQ0cvby9W?=
 =?utf-8?B?OVdoQ0UwTGcybWpKQTV6cVRSN2FPa0VBZkJwK2lpQytweXFUZEdzNzlvTDA1?=
 =?utf-8?B?RkNtNjhCVkpwMlBIL25JRVBZcGs1Q0VqLzZqUnNKVGUvUW55cFkvb1Jmd29y?=
 =?utf-8?B?YnUxOHRramFFK2Z0YTZuczFMSGtyT0szOWtzRnh3djZhUERpaDdnOXZ6RWJm?=
 =?utf-8?B?ZjJJdUxnQUdjcXUwa3g3TDBWa2xKcDRvZ1A5Vnk5RnByTVZxYlNYZFRQZk8w?=
 =?utf-8?B?L1ZoNW00UndLSUt5ZnAvZDAvV1FDMkFvY1pOY0R0TWhDaWVUeVFTaFZkNno4?=
 =?utf-8?Q?azqx5+yTIkXD3Z5ueX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa075123-eb9a-49f8-7db1-08df3c1f9a76
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:04:14.4156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hmNoPjD/nnVraG/MlVxBgoxjU5Ykr2nh1FUKt7VUEXUzpzGr9Br3Ob12aSZoSt+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB917062
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 16:20, Benjamin Cheng wrote:
> On gem object close, we previously only attached the fence of its own
> clear_freed() call to the BO's resv. If an unmap of this BO happened
> prior to the close call, clear_freed() would be invoked, leaving
> vm->freed empty, and no meaningful fence to be attached to the resv.
> Because of that the memory may be freed before the TLB flush is
> complete, and give a running userq potential access to a stale
> address translation.
> 
> Fix this by attaching the last_tlb_inv fence to the BO's resv.
> 
> Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
> v2:
> - Rebase on "drm/amdgpu: fix TLB invalidation fence handling v4" to get
>   last_tlb_inv
> - Move the fence after the clear_freed call to make sure we wait for the
>   right invalidation.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6137ab4211be..36b0bd85616f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -371,11 +371,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  		dev_err(adev->dev, "failed to clear page "
>  			"tables on GEM object close (%ld)\n", r);
>  	if (r || !fence)
> -		goto out_unlock;
> +		goto out_tlb;
>  
>  	amdgpu_bo_fence(bo, fence, true);
>  	dma_fence_put(fence);
>  
> +out_tlb:
> +	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);

You need to change the drm_exec_prepare_obj() call above from 1 to 2 since we are now attaching 2 fences.

Apart from that looks good to me.

Regards,
Christian.

> +
>  out_unlock:
>  	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
>  		dev_err(adev->dev, "leaking bo va (%ld)\n", r);

