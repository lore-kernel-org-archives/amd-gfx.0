Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80264606A335
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIm7Q4qL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162E010E4C9;
	Fri, 13 Nov 2026 11:59:54 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A9310E4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 11:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blJP6F8gSsNz3GN2Yzr0QMEmOLJlahGInXGJJ0XLOa+zPEgnHU7RrswrxIYwxDTmabTkOluJY8xYLLt1girwnTYtw7Fd0KCG3/u7LSPU2AsmjOqXK4eEL7+JtX0vTbiOnPc0cHkkRfxurFMBI+AB/nUD+26AIQHIOgw8vTLIYu8aWLFBaDVOu8y2C19ZKbnuBXLQcnJ4N1ED71d4EAroG1rDe5UH1abK39WFzsLC81ofWWnTQeC2e0c6A5+Laj3zrktX4Q3/E2oWeaVJoJ4fk/g7TDhaAz5z2n4jgOf9lOIwXSffGFy/C8Y4GnEX+sRdCRVpOGx6yz9kQ9HD4UOqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+/x/JgBD/T8XJCZ8oS+CE1LOGZUCGQCtPnqMlziD6k=;
 b=zVB/OcZ8oYzons7lGO9IWRVNxZ5kv9UYQPxxLVZz9qwI8Ee0/wqmXXLgb/i+RypH2j9v5dbRlxPWXhe6TT2RKo4zu9KufxuCOnebg2M8oZeve2pT1hifo5rno+GqGCV1YldR+N61sHj16YNkXU0TA9eb1938aExDDaROKTE+kYtQmHtU2uMq2aIeYOu2MA1dScxv6OIhAI/wX2Pl4vmQZQyhGIk6xAh/wdYqaTGbrczDd9re32JHOiY/OKba7yXSyL+WAcp3F1HrSRI/m68jBrUbplsuW/xwSt2WcUXWYPTyWoomHf/1zxmge9slhWkFbho8BmaoiwgwQMI/YiruZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+/x/JgBD/T8XJCZ8oS+CE1LOGZUCGQCtPnqMlziD6k=;
 b=IIm7Q4qLrr2btO0z3HIpsCz65aJpIhYGumuQvnBH/NJ5F44KSccHXLaewJufr8B4ulBnI1BoNEowZSEpLshiwWZ+LrHRO9edLaUgEh7PMQ8pyx+LAzxpNG08H57WOVeXgzenm0GSHbnffdL6hwh8mEWm4lxl7tzt0Y4x4nIglfA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB162361.namprd12.prod.outlook.com (2603:10b6:408:3ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 11:58:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 11:58:43 +0000
Message-ID: <bfc53181-53ac-49f8-b243-95b23999a638@amd.com>
Date: Fri, 13 Nov 2026 12:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112164408.1748006-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB162361:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fed027-432d-496e-a14e-08df417d7639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|10067099003|261009223027099003|4143699003|11063799006|261022105027099003|261028144727099003|261102123227099003|261021123027099003|56012099006|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: lxLx0fTmqvbPvHFn3rnks4C2iMb8oW5wH7akIqfOWe7TLzdY+z6rfMgHu9RqpahlWJHU1FglLHbAZ1cg5mH9KTsYwa9NepUt1Y9P9H0tYB6Y+TMJfnFl6hGtQvp7dj/l9NSLvjZLW+jFs3jB7ab/q1uEsrHcJsvmPaY2ulnREEXG1KT1/YUJbpVff0BkA1K1qqRzjdZ9O1cAiYuewiu7pjqIwJdfdgVOmwLxWUEWIv8ozt5YC+BuxwSpfy1S7lFbfUTIwmMwUBwlEE75U0dMNIt/sM8yv/cexh6e8sd3odmmgfJ1hDcFo8vt0r19qPm4y+47SlWUWapyZvtnZax8Kbjlq9dv+s6a02vLv1QPiaY8/rWX1EvAWWKSBZHlsvjpUJyD4bpakKWklyqODR0sKWP+8AsM8VUlcrM6qSFSqv82Rxad2hr24hGMbG+X4u81qEv3xqCwEG3zxhNFW/LITowH70CPzjicNTX6KgHu9hvHpl9KY435+rX3i2TS4ejlbaKhO9fBmZRcWG3R5BE9AdQrN/oEbUM3Y+5UURR+cN7UE+BpwQgOj3IYMfi8BJJhYV6p5cVZALLaKlCYzbpntYosAUGbKLU2+clEKDllAZb34jQmwFt/+w0rk/Ny5lTCa3K3SUYELj7TyXrHIJpqgsGAgftMH5thUgS3QS2xV+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(10067099003)(261009223027099003)(4143699003)(11063799006)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(56012099006)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFpxMjUyYy9jNGt5N2xWK0hScUtOV2JiS2dtcGhvZWMzb2k4NTN5OW9FSm1a?=
 =?utf-8?B?WldVblZMK1ZOODBHY0sxNzBvRFVnZWZxQ2c1UFJkQUxoSVBDRlRXZ1pzZGtV?=
 =?utf-8?B?NmllUTljdVVnN0tPbFFmSzFrcXVDRUFYaVowaU5kNHRadStCWjc2ZHBFMkU0?=
 =?utf-8?B?RGh3S0NQWjhFQzV3clBZdVlBSlFrZVhwNmxpZHNaaWg5cVREaEtyVU56TkFW?=
 =?utf-8?B?TXRYVGs1ZURjK3c4WCtRRnJCWlZDZmNON0RrSG1VaHJVc3NqYnlFRCtYMDVI?=
 =?utf-8?B?a3J6R1VoZHJKTFNydTJTZzRNM1RHWVdzTE9YOXZlR2I2QW1tK0xhOWFXUHVK?=
 =?utf-8?B?Ukx3dEYvUzBxL08wUzJ4ZC9rUE1NTnlpaytpQS9zSC95L0JsRlYvdXlycld6?=
 =?utf-8?B?Z3lHN2xFNmRvZFFWRVNzYlF4WW4rVkVseDZhSXUxT2dVa0paV0RFOEZDcFo2?=
 =?utf-8?B?aWJNQThRTm5KZy8xRU5udDRydzBhNnkxOE4rM201dHJXT05RTUNCOGV1SXpH?=
 =?utf-8?B?UTlxVkh6UEdOdjIzR0NjR2dObVA2czhiNW8wSGptdUR3TkNCR05lOVkwNDZq?=
 =?utf-8?B?VkRyTzg2eUd1Q3FVdktJd3ZyekVwWjk2QktHY0NtaXZ4TUIwQWc5alVINmFI?=
 =?utf-8?B?bi9lT2JVem4wemI0dVdURWdyYUxURDc1RnNKYXZid21qUHlEL1VlQkx0T3JP?=
 =?utf-8?B?QWJjZUdKRTcvUmRRdjdzVTZnd0hLeFVNYzh0V3F1alUxdlRyNGRDMW9YWU43?=
 =?utf-8?B?c3hoK0Y1MGFPYUk5a2xsdUFYNFlXSDJqZkFPTDIwa3RmeENyTnVkT0NaOHZW?=
 =?utf-8?B?cXp6OVN1dktTMmwxR3FGcDdYWkpYYytveFNiWWM2RzlsTVoreDdoWkVuWEd3?=
 =?utf-8?B?MUxHdnRQWTl4WVBZNTIycFYyMnpsbGNFRkxUL2FFZjdXRzBmNFh3a2M3TllH?=
 =?utf-8?B?T21IT3BvdUtITHRxUjZ4OGlER29xRHdsTTNFV1NnL2QzR253RFNoTlB6cG9z?=
 =?utf-8?B?dDRkVVVvTmNSL3dGQmZzNy9aRm9ZSkZWeHdNb0NRVlEyR3BOcWwyWUYxWHJM?=
 =?utf-8?B?YVZMZzJ3OHFjbjk0ZGIrQzBNOWUxMEdGRkNBeGVxQlZJOU9OdjhyN0tYci9p?=
 =?utf-8?B?aGdWS3QrRlZDYXJOWVFlNiszaXJWeWpWWTlZL2loQVRrVHlrVDl3QW5wRWM4?=
 =?utf-8?B?NFRTcm5OY0dac2dWSkxFL1RvMzhrbi9ja3AvRDk0Z01DQkdsL3NJWTVLQlFt?=
 =?utf-8?B?dEVrOFFHVEpNVmtsbG5YS3E4emp3b1IvdGd4K2prMW5KaDFLNVVQa3RoemUr?=
 =?utf-8?B?dzNYT2lhTmUvbDQ5cXhFdG9DVnppaGNaTXhsUXE5S0ttM3kxeDc0amJrNEVo?=
 =?utf-8?B?V2R4b2czZUVuWFArajRkYy8yYVREcWZOa2NRbTg3dUpBSWFvLzZpb0dLeEUv?=
 =?utf-8?B?Ti9JWU0wdHNZb05XTTZ1VC95Y0NzaVFkS3FiUXF6NTdGWkw4d2dpM25xNWJy?=
 =?utf-8?B?NXNYVUh6bzBYaG1GR3YwT2NmSXZpR25hc0lZYUt2eDJ0QTBJSkN4Z1NCZDZV?=
 =?utf-8?B?Zmp1QzFnVEUvWFZWak5BdDExVWJCYlFHODEyVWRyZGg3TEpGdVo2UWNUMGls?=
 =?utf-8?B?WU42S2N0aDVjNkdmNlVmWDE5VnJSVUxlbjhBcCt1S3NkNnZWMlhFQ09FaUJp?=
 =?utf-8?B?Z3FDMDY0czg1VmYrNVlPUTBreWF3c210TGxhdUxMRnFxeFdXVkwycWp3NVdo?=
 =?utf-8?B?QllVTkNsUVRFQmFrS05sZkpBaWxRek83L2F0bmNXR1RhYkRCVk50MlYwdlJk?=
 =?utf-8?B?YnV3Qkw1K0N5TWh5a2VVWjNMeWhpalYzVWtRREhQZ2VZUk5XcXNxWUFRWE04?=
 =?utf-8?B?OS9ZTGJlbFhrUzlhc2lZeVVMZTQ2YXlmY0tGdjYxTURURlFXdFo3U1hmZXlJ?=
 =?utf-8?B?andBTXZ5a2hMQys1RFFoY1ZwdWZVUGt5YlFlQSt3QmhJdnVodUE1Q2tRKzFi?=
 =?utf-8?B?OER6ZEFOUzU2WHMvYVRSNGxWTTVFb2JVQW04bGp0RmRJVFZoUit2cFBvMyt3?=
 =?utf-8?B?K3RoN1JuazlRanovS1BiSnVSYTFwYmlqUDdBamVnczVQRHJnYytUQlF2QWVX?=
 =?utf-8?B?Rit5WW1ocFFrU0IyQnV1UmphNUVhWGJDQk41NGQrVzUxZjJiaXpQa1NESlBJ?=
 =?utf-8?B?VjRYeFIxeEVnU0RRbWlRZHlxSFp2eWhrdU1OV0ZRN2VsMGoyV1RYeDhvN2w1?=
 =?utf-8?B?YzJqQjBPc0dwUGFQWmxOdVh6bTJHNkFtSXRZNzB2VXJmZFFjcTZ6S1hrWGJk?=
 =?utf-8?Q?i55qgCqVUNycwKNSee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fed027-432d-496e-a14e-08df417d7639
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 11:58:42.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Bxs0a9TXh5J4M1pD8Q++yyZVblUQwAJXG5nf5ZtJrOnoX6axJo2n2kO8SY7YLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB162361
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



On 11/12/26 17:44, Benjamin Cheng wrote:
> Switch to stop using this deprecated helper.
> 
> The original could be incorrect under certain circumstances, since the
> amdgpu_bo_fence only reserves one slot, and at the time of calling the
> SDMA commit and TLB flush fences were not added yet (the reserve_fences
> is not additive). In addition this allows us to switch to use BOOKKEEP
> usage.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e..fe6f2fcb88f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1212,10 +1212,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free;
>  
> +	if (!unlocked) {
> +		/* last_unlocked + SDMA commit + TLB flush */
> +		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 3);
> +		if (r)
> +			goto error_free;
> +	}
> +

That should have been reserved in amdgpu_vm_lock_pd(), but we currently only reserve 2 instead of 3 slots there.

Please fix that up and drop this here. Apart from that looks good to me.

Christian.

>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>  		struct dma_fence *tmp = dma_fence_get_stub();
>  
> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
> +				   DMA_RESV_USAGE_BOOKKEEP);
>  		swap(vm->last_unlocked, tmp);
>  		dma_fence_put(tmp);
>  	}

