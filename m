Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2417606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PPNZf0r+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5276910E272;
	Mon,  9 Nov 2026 15:05:08 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B704510E272
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 15:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUknKARxeczGK5M9HaQMLDZZjcJOVEswNRywnEP+AB/GUlMafxAxSANz5zjhPrVE5sWnkv43PtB278U8tDQZEPytJ9JiaJ+0tSZRDhUFSWh05bEvz24DWlAxpoWrLLlkr44VHn6DJzpYcWyomK69gRQGpyDffitvTydtI+LKkgScS34w/cqZJhYWwePPW2c8gTsnGckZLhgWabckF+TN1h+s+69x22NvdpU1JPaESrq6fqlf0CkpZjAW1j/H/XA3WuqE64sWOQXODS/6hA9U84+FhngJ9PqNWkdnJRLpzh47gb2vnDsFNUNDvq2zl+f3fW3DxXXqNEm9sNSJt55DLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ+hefhdqwpZBwoOb3Yf0WKmTMvQPqtGeG20RAiYulY=;
 b=WLBrDWdljPI3PUe0IfjkZgO4ohkQ7vNct3+JbUPh5ufowsQUbil/r7rn4xf/ahGhtKFsSKVyD6u5mMHBnMrGaffOEAdCJBOOD7XhMBN+8GRf4ypWM1QSBmc1EgrCXBel/kDi+lOkDhPj3c1zkoUoplxlpNkbdlxWcbMNiHB6TMQeZB3sLFxXeBbhD3upvB8ES7Kw3LzCJENkRCakDOLbiIc2mbtVigktNpSkxxzSvYyJ9WoQAZr/GOptS1pvwa5ga5YohX/esJAv5CxfklEBXbybwfbDH4O14YYaTJh4l6Tvd2YOeYkQu85yteyPJ+O3VF1Lz/dSmos+tVxTwpkfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ+hefhdqwpZBwoOb3Yf0WKmTMvQPqtGeG20RAiYulY=;
 b=PPNZf0r+6phXexZtTYTX7shPoC/woBymF7dq1nyBdyplKgUVrDfdUQ8jFJOfi1kgErlSk5sUsGXZlPyao/kM10kblmzi9xMuzFTlsdtgkx+86RVFPk88lK2MTECmvyyNzk5RAHqUnDcjffRXZyauki6jkwgT9S5OPvwH+J+kP8E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 15:02:58 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0592.009; Mon, 9 Nov 2026
 15:02:58 +0000
Message-ID: <a73583ec-fc20-4b50-b801-a9f633ddd866@amd.com>
Date: Mon, 9 Nov 2026 10:02:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu/gem: use dma_resv_add_fence directly
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261109145718.91381-1-benjamin.cheng@amd.com>
 <20261109145718.91381-2-benjamin.cheng@amd.com>
 <98d9220c-ccd1-48dd-a293-eae4703c1dc4@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <98d9220c-ccd1-48dd-a293-eae4703c1dc4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::22) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e60db2-35bb-40c0-75f8-08df3e728a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|10067099003|4143699003|11063799006|261102123227099003|56012099006|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4XLGY6E4JQ0xgstn4p+1X5lMhbllQz/bG6RbkUYYUnp65v03/0UGrmsn7GfVsYjuz/oKz7jWqv5kUVLr9eU05yqGv8DIysw4Qgx7WAUVZJycR0MoNVhVuXdTsQkE+jZcR+1MvXxpI29rWrqW+FgGQmqa/J6tn1E4aetU4yqZ7j/+yXr+U2KCyNrbS6znfuw8OTWxRhDvRmJQSFTtLms3bveUBNWovtJXdvyi0Ab8en3hAYktXTSHE7kLadvPabk4yBxSJtj9C1BSUxoFIoAW5KW9ITN7xbRDSsE46VUnCKBgm2nv6AxlOBEJwKZeoy7nKjmDIhy0XQ9bJAavPsKfHpEOKULnXZ4TOyuJ+Mr6Ob9bf+9bVQXrfpPtOLU+w0jvX26mnpZABwURrsBmicQQu3o6+kplsApupP3mzoGCKwZI4Q/aBM+QXCRnMRM4tXiVsu0dIUgMRJpLRNtT2b4bnTDuAYYhwUeeqzezWtlnAC4iG27jUF/KH7SGsLkoXXRnEPMVmc9A5UBx4jP15HujV1nBZWunoBSScaMk4Bhm4oK7bY4albXDRI6ea6KnLVOs4PyiODOcQQ8qGt1+/87MNMUhK3NodLnH3S+0+dVqI/w/Khud9xVPqDhFyO8z+1+6ygf/THgnaDK06f1ur1tlKmFrSdPBZwrUF+Ys/gRywpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGg5Nk4xamdvL1pXV2oxUktJS1hOc1UwQUNBS2ZHQ1NSSGUxT0tUbXpsV1Zo?=
 =?utf-8?B?UUk0dDdiTDhHcDVZVmdLTDVqenhBallvTnEweStqN1FQcTg1bTJKZ3lwL0JY?=
 =?utf-8?B?YThIYlZSc3hOU2k5aGYwU213ZjYwamhzMlczUzhRdjRTMkxDQldEamRvWUwy?=
 =?utf-8?B?QWtMWXJWWHdTTWhkWFA4T0pWNitpM1lqcUkrYWM5NkNyMndqa1JRK3BmVmdP?=
 =?utf-8?B?RXVwak5UWldhVGNISG55V2s4Ulk4aXNFeUp0UXFHaW96WDdrc2prTXNxbEtH?=
 =?utf-8?B?V3RFNmxnRkFGSEJVYXlkTzdRUllEbmEwNWZyeFk4YzhwY3hVV01IS1hpN0VD?=
 =?utf-8?B?MmU0ejlkU1dDTXlTc0JPdGdic0VzNVNFbWJYVGUyT3lRblpGLzROMjVrZ3ph?=
 =?utf-8?B?c1hzSi9BRjhFM2tmL0FpTlVURFhjQmw5NlliQmJRUm9xemN6bm5HNzAxcmxW?=
 =?utf-8?B?K0ZQTzV3TVFWa3FvU3BoZmwyQnp2ckhkRmpUZUladkdhV203K2pLVUhvSVB0?=
 =?utf-8?B?a1lhTUd6ZlNxbStJYndDOThzc3pqM0dTTUxYUktYc3NRSm5TL2haamk2cHoy?=
 =?utf-8?B?Zndrck9SOGZGU2hJSjJrZ2FieGdlMWZ0OGJuMUN4Zy91UzNObzRjZlFxcHdT?=
 =?utf-8?B?Qk5tR0tIUjYzQVpqQUk3Nm1PcGV2eTRWL0REUGJ0aVhiQXUwck5LUDVRTE55?=
 =?utf-8?B?aGhBN1JVZkxxZ2xrT29YMzBxVEM2MUZuSDd0andtQk84ZDA2Nkc4eXRYeFhp?=
 =?utf-8?B?bjBKbWxJVHVOVjRvbVFpU3J2WGVZUzZDc3hMQlpLMHM4NHVWbUV4T3I4Njdm?=
 =?utf-8?B?emNXUVkzK2t5LzZwZXVpMkxzSFRncGoxN2RCTFIwRWpZZlRqeU5oYVNpMldz?=
 =?utf-8?B?WU96MTlXWlY2QXdYb2pwVUJXcGE5a0ZKbXd2ckZHcnh5cm5wQ1hkSVpxSDg5?=
 =?utf-8?B?ZTYzbVBRWmZ2aGhXa3BPT0lDVHo0NTIxbzVyUnp6a3lJLzVsWnFVcm4zN0RX?=
 =?utf-8?B?VWNMekhEa0hCbkxqRVFrZlNMa0hkbW5qbWI1VnJ6UnZXdys0MjNLUnZuUGNR?=
 =?utf-8?B?M28wWnFHNU1BVm9iSHQvbVZtQUdrdjZ4VVdreS9hOGE3c0QvMU9qWC9zaDdz?=
 =?utf-8?B?Sk0wRVpYS3pFR096eTZBZVk3cGJQS1pIVmw5NDljUjFYWHlqTUt2WEVMWVBs?=
 =?utf-8?B?VDgwdTdEaDlqODdGbVNUNHF5L040YzJLU0ROa2xSb1FROEZsbVRvdlVsUzN3?=
 =?utf-8?B?MitvUWFBMzcxRnpHWlVFaGZPYUFaaCtDenN5YU9ubnBQd21nSVdINUk1TVA2?=
 =?utf-8?B?WFN1VXQyeEhzRkJIN256MFZhWmJyUFp4NHZHREUrQWt6SUxXUnRteUgxN3N0?=
 =?utf-8?B?YkdjSlY0LzdJR2J3cE0xN1VQb0lGM0ZFU29UUk8zcHlodTF2TC91d0QwMXFp?=
 =?utf-8?B?MW4xbEg4SmpSMFNaZWVIK0oyeGx4d21qRGZCdFpBeGRSNXpaNHJMSXNlT2lI?=
 =?utf-8?B?c3hBandVNEFFNDhzaVpvZVg2MERBOHJMK0dCaEhFZlFXNXRkK21LMFM2RW5H?=
 =?utf-8?B?MEdJcm1tUDJoZldWa0dLS3pKMHZ2U1NBZEpEMFc3cHVEcEhIYUpKbGpPWEV1?=
 =?utf-8?B?bksvVnNEUisxRFhzcjVwSG94QnhSL2xqM2R6dXJud21YZEFDek5oWjlLaHdZ?=
 =?utf-8?B?NmxlSGRMUU5pSXoxclhVdm5SWHpqQm1Ma2s5TXMxbzA5NGhzSGVLQXdUNWJr?=
 =?utf-8?B?THh0K25qNVdQbVBqZUJKYnJ4dTVaVTI5U3Zwd1h6U01SdWZyWUNHVzl2bjJW?=
 =?utf-8?B?RXJ3YmY0bzFFbGVkTDVEb1dMaWxqOXE2VXYvR0lZcnErSnk4R3RPTG90NW13?=
 =?utf-8?B?dytwSzhyZUdzSnQzTTN5MHd0SnRqWG5KK0FjeFJ4U21QOE9tUE5iZm83WXZV?=
 =?utf-8?B?Uk5SY1NDdHB4Rk15bzVBZHF2c0xqK3VoVEpVbkNMcFpkbXJYK2FxNVA2c0Rt?=
 =?utf-8?B?NUZLUERBdDRaNng5NVR1T21Ea2RvOGJqNDNMMXNjNFlhN0hPa1FoUk1EQXJa?=
 =?utf-8?B?czNnbjkybklHYlVZNnBRbEFKditUL0lSZ0F4aUYxS3JTbUVYZ0ZidWViZWh3?=
 =?utf-8?B?Sy9nbUp6eE9kWXQwemhSS1BTRDZXeEF1aEJWRVVXOWNrajVpTDJIVmlNUjlp?=
 =?utf-8?B?UThhdVZuNzZqNVlsL0lYdGJQRnpRdSs4eVE4TVFPVDFDMU1qUnM1UXpZVWpH?=
 =?utf-8?B?MTJXcEVreHNZTzhrQU12VTlmazRZZkNTclQ4dlAyWGNYSmIvTHhOQ3RDM2Ev?=
 =?utf-8?B?KzFWR1RFWXcwdGdTU0NHeEtrZ0lZcUt5bE9BY0VGME1SS0VpVFhpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e60db2-35bb-40c0-75f8-08df3e728a9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:02:58.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmN+Ri2id8oKVya4m8wcpnJC0a2BMmM6jSBmwstJtFRWNUfHIGG+Anov5Tvse6DWOIGGwxfrEO71M1oYHUFlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
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


On 2026-11-09 10:00, Christian König wrote:
>
> On 11/9/26 15:57, Benjamin Cheng wrote:
>> Christian pointed out that amdgpu_bo_fence() is deprecated since it
>> reserves fence slots there outside of the lock. Replace it with a direct
>> dma_resv_add_fence call here (we reserve the correct amount of fences
>> already). Also switch it to use the BOOKKEEP usage since these are both
>> kernel-internal fences.
>>
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> Oh changing that to BOOKKEEP is a really good idea. Are there still users of amdgpu_bo_fence() left?

Yeah, in amdgpu_uvd.c and amdgpu_vm.c. This patch was intended only for amdgpu_gem.

I'll get to the other usages in the next couple of days, and then we can get rid of amdgpu_bo_fence() entirely.

> Either way Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index c9a84257ae5f..eebba3bea089 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -373,11 +373,11 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>  	if (r || !fence)
>>  		goto out_tlb;
>>  
>> -	amdgpu_bo_fence(bo, fence, true);
>> +	dma_resv_add_fence(bo->tbo.base.resv, fence, DMA_RESV_USAGE_BOOKKEEP);
>>  	dma_fence_put(fence);
>>  
>>  out_tlb:
>> -	amdgpu_bo_fence(bo, vm->last_tlb_inv, true);
>> +	dma_resv_add_fence(bo->tbo.base.resv, vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
>>  
>>  out_unlock:
>>  	if (r && !drm_dev_is_unplugged(adev_to_drm(adev)))
