Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B12606A330
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HmHFlsNc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AD010E052;
	Thu, 12 Nov 2026 10:09:18 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905EB10E052
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 10:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT4JE4PpvEp3cMA8NAmah3NuFRF2JO5hYF8nZnfu08GIjyopTYuUtLk3Jsn72qHI3ng1p7EG4Ru3N6D33JX/xT4u22RgPI8/YWpiODOIlkjuynutUA0yE0pC+2K7Kw9pFlD0mmLG8uzGUqbLEv4IAMuIjKO9jIOT6Waxq7xPV5C6r8VkphoLjaYUOUYbbZaB8IppKQL5dbdIUuYHD1IKV8+2wJ27B76pkrBkUJySVPFil5fWDkML+KI5a8OeEJcID+8SiPizXBKtKQPn4DIB+5Wsc7Ud2iQO22OckL4iaWpeOWlSJgwAeib9qPDnCw/7m4erKMFS7hjaSI/KKRHpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39OgCFI40FZtjgt/yF+5HXo2HWNEnYFh540/NmOX/Jk=;
 b=BcDx7Ayea8LKGM/NDJpKhDS1oNwcGksTOpt4V+AV9OaZ5J0scthORV/jOIfAezpnr029naDf7ZEZJT3IsnJcujrYQOCNjo3qhSjpVzLwdL49Fvdr6Qcs71Kyg3MPJ1/4nTidi54QMFvNnUjb6hCDWSSD0kYf4a3HfGRbjGrSzfxHG9dw19h1X5F2jZMHCXKn6O6XC8Sm2KIlCQTMzrL7Jy+jwCZeOnCTAyH6I6WAt+GvBb/OPyn8YGfuFnBSyg0mYlnhBAcOTdt+YaijcF6VKPgnwxrf16AQe/ndR+xCxlqhZ1uwxSQFm68sQGIYDZ3Jt1v+QHAElu4SS6yHqA2Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39OgCFI40FZtjgt/yF+5HXo2HWNEnYFh540/NmOX/Jk=;
 b=HmHFlsNc91BSzX0EtEKHbsFJUp5w2A7ZNnRLbwSV0gvQfu4T+n+np+ksKQUdOzBWlFMNRUlcpYDIRBu6DkyUwIiiTVjmyz7G77+RQkOp5QNbBkLTn266Ap+pyqUjf6GN8L8dgOkeFuy81lOXckWClTECVHEYzr0dE387+Qo9Gdw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:09:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:09:10 +0000
Message-ID: <0a53082c-e569-4c68-b249-8e94fbc665d7@amd.com>
Date: Thu, 12 Nov 2026 11:09:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: defer amdgpu_vm_pt_clear() to
 validation
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: alexander.deucher@amd.com
References: <20261029040922.3911530-1-shahyan.soltani@amd.com>
 <20261029040922.3911530-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029040922.3911530-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e548351-d197-4ae2-78db-08df40a4fe91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|4143699003|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261102130727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: GXDMNSVpcnjBeFl2LHdS6dYKKHwTHNCVaGfuRmlmavlgQfjCWw+c2z7sqJ8ONutomHThw35drjULGZNBLdNdzbnYKE2XdhD670cy+ODa1Hwn8vscMoRaYn8CQybkgtzIbvz2nP7vTDeoa7h+4CuGwXURNfobe9I3YtJVF9Hll+X8Img9GIFC75DItgraTQmRpLb8Ijma3geToFpMxbC8o1I8e15X2gj4m+zefKjHKmHNBNH2QUrUgecIzY7TMNgFgOES4PrnbHGeRe2DRdIU8KqEILK7xyGxP2E0Fs5vY1Q6pF4RbedGxNd0IWYK9s3zDtn6QSdqVAry6x+N4o5K0FCPdP3YSTtueI/4Y3VOu2qbyg6NISn6OJNP7vDc2jPPT64tc3TE6eTP5qWs9XHp2afZnvOSK97YsHY7f2ErAU7xa1NyhG/KYGYBee8q+sTDGj/PHbctnvfOWPKpCorof8rx5ogfLszdGEFG+y+zrfP8+lAUaqfOug/FJLurNxlApQwq793moezAHhBjOrxctVd2H8nl1SRPrp8bfcDGXeP8zp8Ex4MPo8x64MIjzUXBH3NIuDeIZtnCmOy0rPMT4woovnWHdGHfNCyBxq5UO6zlpBGid7o668nJjbkbRkOJk9XurtJd0UpzSESFg8TJscDqDSvGatScx+KUlcVS/2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmh3Vnk2ZlhadTFYL0lhT2FBMGRxN1JVWmVKOU14eEZ0aElzV3R6RWVVVnZ1?=
 =?utf-8?B?Y0UwT3JJQXJVRzIzM2l3MzBYSWppK1VHWll6U1lWZXVNeXNuZ2ZwNmxlYVlF?=
 =?utf-8?B?M05iMGROTVEvNmE2YU5aS3BmMnVzVWhsTHMrZDQ3MXlMdWp0STVIUVB0dm1K?=
 =?utf-8?B?OENkSmNJdHUrUVFBRzg3RHJGQWxMV2FaVTEzbnh2emM2dU5hMGQyS3FQaTZa?=
 =?utf-8?B?dER3RVVTQU9SaE8zU2lvTkovSDh1cnlUckNPQkxDdFRhV2NOUzZvK25vRFRn?=
 =?utf-8?B?azBaQm9haWN6U3JDTG5OYVkzbFQzMVN3MGRRZzhnZFREQ2JTbzk1Q2NDRHNO?=
 =?utf-8?B?NnNKaklXTHUwY01wMHJlQm9lUW5MQ3ZONEo4Q1NldG1xNytqcjdOM3VWb0s1?=
 =?utf-8?B?T3k2STAvTzFhdUE2T2ZsM01xb2JiSWxMbTkvaENCRC9xc3dpRjh3VzJVQ3lS?=
 =?utf-8?B?bGhraW1tVFVscmcxN0lDRzE5SXN2eWxBbEs3dzkwN1hYSjJ5M2lMRE81UGJ1?=
 =?utf-8?B?ZERSME5MUDFjcHZxUEVNQWVBbVM1Z0lKdDEycll3SVZmcUM5Zi93RlJZUDVD?=
 =?utf-8?B?aGNOSHJmU0p0R1VQQnA0TnYvTEpZL3BIUkhsQkhDWU94dGxRV0wvMFI5UkNQ?=
 =?utf-8?B?Q2pKQ2hWaDQwcjMwQzhnK0JmMnlycjRnSWMxSTFQSHlsUCtaNmJ6YXZmanQ2?=
 =?utf-8?B?NHdRYzdiUTF3QnB0eDdtUVhETGsvSzBuQnc4RzV4WWE2YXdWaHNEajd4RU1F?=
 =?utf-8?B?cG5ub1kzem0rV2dpaU94aC9tdVFHaDhmVDloWEVxalNJRnB2K2RYZ25KWUI1?=
 =?utf-8?B?N2hWMDRTVWNzck5PWTl0cHpSaWlzOVFIWnV6SDhxNEVrYU5uOTF0NGh2V0xz?=
 =?utf-8?B?WXhwM0lGWTJwcDJiMkF4WisxWHZkNEg2VERic09VdVpmRkVFYkpLaU85OXl5?=
 =?utf-8?B?WUE0ZFZ5Nkh1dENaTUlSWEtiUTNqVnBZUWxsMmpFRHdPdWk5aFgrRXRLczJ1?=
 =?utf-8?B?QURTZ212WjZLWTFxbXZaS3FOaWxyZDBlL1FmeWdNbG1DNXFUNnpsTzAwQXho?=
 =?utf-8?B?SHZ0VTAzWFZaWi9kK05VemtUcWdaQ3hQd3BpTDhpdjhWR0k1TVp6TmJhVkpl?=
 =?utf-8?B?T1N5THJCK0M5Tk5Ya0d2VlREb21jSVc3OE5HZ1EzVHprMHFGTTRWaXU2RGpq?=
 =?utf-8?B?ckxSNXJKamsxa1ZLZlBZb1lNeW5sMU5jWXBXZGlZdVQ3YmROWGc5TzArbjJ3?=
 =?utf-8?B?THY3TUFYSk51VUZJR0JpUDFucjArVDlNeGFlc3JsVGZxS1VIazRqV05OZ2pP?=
 =?utf-8?B?dS8yWkdwOHl6VkpYbEtKRENONTFBSGZqNU5weml1Q241aktzZ3FlUHYwYy82?=
 =?utf-8?B?QmtmM0tRK0tUajdQZmdOK1pKSWorb3c5QTZxbGZNTWQzRFNWZi8xdElsSDg0?=
 =?utf-8?B?eHUvSy83cHp4MW02a2ZwUDNrNGczbGZ5SC8rSllQNTRXVzJ5NHFmOUNWV1RM?=
 =?utf-8?B?RFBKNkJ4djR5dDk5Q2l3b1liV2RqV2hHS1creWp3WmdsUGRoR05lNW1VY01H?=
 =?utf-8?B?UlhLaWF4WTFOL3NBVlppcVlPTlF5bjhzaEFYUW8zMEZ6Y1plbHZHbmZadzlz?=
 =?utf-8?B?YzlWcFU4WEV1TkRMUE1IZHlWQUpsRkptRlczZVQxK0cybnJhSkhTRjNscVgx?=
 =?utf-8?B?cDFqUEtXUUtIbDkzbUFYVWZjOGtzb3U1bTVseUg5K3I5NzY5YTZMdnltaFU0?=
 =?utf-8?B?Nm9UNy9hQWN1SE9vVldxdGFGMmNoYm5mUldpdHJwMTI1a0JrYUdmZE1GT3o1?=
 =?utf-8?B?clJIS24wVitHY21aYThtK3ozaWJuNk1QNGNtbVJFY2RZaXE2RUtCdHpYTldK?=
 =?utf-8?B?Ri9VZ2t1ZkZwU3hMVzFrM2c3aVdRcER6K3N5N2NkQXFNbFF3MDIxeWVUZkNR?=
 =?utf-8?B?SjhXbTR2My9RRUUzZE1QaEo2V1R1Z3c1SURWV1U0NW9Wd25qZERKY2d5OEdm?=
 =?utf-8?B?WjVUUFgyMFI1ZjdGVU4vNXhxQkFSUXZubSt0RFZlTkVBUFJKK0pDc2xqYmlV?=
 =?utf-8?B?SjE3ZkhCeVoxK3R1S1pjS2tiNkdvcXJoYVBOcExzV3ZhSlRSNEptL3pYaXBJ?=
 =?utf-8?B?djhLMlVMeXhQLzFVUUJJR0FSTUtLeFVZbDJwSHcxVnJhQmsrMUFwY2pjb0M5?=
 =?utf-8?B?ZUhwMHZ2cjRQdDJtVDZzNEtMNjdJeE1WNWhqYUlEV0hxNGFvY2s1UDZ6UnM2?=
 =?utf-8?B?UTZXdnh3dkF5UzIxZjdtTGNqbHVQd0FSVERtYjVUa0Iya0xNdHVRZmNtLzdL?=
 =?utf-8?Q?fMnHRpEWkpxFeTE3qd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e548351-d197-4ae2-78db-08df40a4fe91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:09:10.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFSyZfPw3H/DLjaduTJP3XwwbrBYD8TCMYBRSEnHTAOfMmoyCOXzII5JOU69uFy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

On 10/29/26 05:09, Shahyan Soltani wrote:
> Currently amdgpu_vm_pt_clear() is called at open time in
> amdgpu_vm_init(). It submits an SDMA job, which needs the GPU to be
> awake and adds complications when it comes to preventing the GPU from
> resuming when direct hardware access isn't required. Instead,
> amdgpu_vm_pt_clear() can be moved out of amdgpu_vm_init() to run later
> on when it's required, such as when amdgpu_vm_validate() is called.
> 
> Introduce delayed virtual memory hardware initialization by changing the
> vm->generation assignment on amdgpu_vm_init() to ~0ULL. By setting
> vm->generation to this value, it will force a mismatch to occur on init,
> processing the amdgpu_vm_validate() logic, and clearing the root PT much
> later on in the stack.
> 
> Set the initial domain of vm->root.bo to 0, this will allow all contents
> of the root PT to exist in system memory without requiring the GPU to be
> active. The vm->root.bo is then put on the evicted list, which will then
> migrate the PT to its preferred/allowed domain at the best possible
> time (usually through amdgpu_vm_validate() on the CS path).
> 
> Edit amdgpu_ualink_manager_start() to no longer depend on
> amdgpu_vm_pt_clear() within amdgpu_vm_init(). Instead, the root bo will
> be reserved directly after initializing the npa vm and
> amdgpu_vm_validate() will be called within the reservation, using the
> logic of the new amdgpu_ualink_bo_validate() function to process the
> validation.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  6 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  | 13 +++++++--
>  4 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 6cd3927a7e82..1e8f7fe8e1fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -27,6 +27,7 @@
>  #include <linux/random.h>
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
> +#include "amdgpu_vm.h"
>  #include "amdgpu_ualink.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_dma_buf.h"
> @@ -4165,14 +4166,44 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +int amdgpu_ualink_bo_validate(void *param, struct amdgpu_bo *bo)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	int r;
> +
> +	if (bo->tbo.pin_count)
> +		return 0;
> +
> +	amdgpu_bo_placement_from_domain(bo, bo->preferred_domains);
> +
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	return r;
> +}
> +
>  int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
>  {
> +	struct drm_exec exec;
>  	int i, r;
>  
>  	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
>  	if (r)
>  		goto out;
>  
> +	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &adev->ualink.npa_vm.root.bo,
> +						 0, &exec, false);
> +	if (unlikely(r)) {
> +		dev_err(adev->dev, "Failed to reserve VM in ualink_manager_start\n");
> +		goto uninit_vm;
> +	}
> +
> +	/* Ensure the root PT is migrated to the correct domain */
> +	r = amdgpu_vm_validate(adev, &adev->ualink.npa_vm, NULL, amdgpu_ualink_bo_validate, NULL);
> +	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
> +	if (r) {
> +		drm_err(adev_to_drm(adev), "amdgpu_vm_validate() failed.\n");
> +		goto uninit_vm;
> +	}
> +


>  	/* For pinning page tables and using CPU for page table updates. */
>  	r = amdgpu_vm_make_npa(adev, &adev->ualink.npa_vm);

That function call needs to validate/pin the root PD anyway, adding clearing to it should be much more trivial than open code it here.

Writing this the NPA mode needs to use a different value to clear the root PD. So that the root PD isn't cleared again after setting vm->is_npa is most likely a bug.

Please separate that change out of this patch and make sure to CC Felix and whoever worked on the NPA patches for the review.

Regards,
Christian.

>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..399ff4da0444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -405,6 +405,7 @@ int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
>  int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
>  void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
>  void amdgpu_ualink_xcp_sysfs_update(struct amdgpu_xcp *xcp);
> +int amdgpu_ualink_bo_validate(void *param, struct amdgpu_bo *bo);
>  int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
>  void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
>  int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 000c982816a7..088a4e5a1aa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2660,6 +2660,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	vm->is_compute_context = false;
>  	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
> +	vm->generation = ~0ULL;
>  
>  	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>  				    AMDGPU_VM_USE_CPU_FOR_GFX);
> @@ -2678,7 +2679,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
>  	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
>  	vm->evicting = false;
> @@ -2701,10 +2701,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free_root;
>  
> -	r = amdgpu_vm_pt_clear(adev, vm, root, false);
> -	if (r)
> -		goto error_free_root;
> -
>  	r = amdgpu_vm_create_task_info(vm);
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e2..2b9f8aafb685 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -449,6 +449,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  {
>  	struct amdgpu_bo_param bp;
>  	unsigned int num_entries;
> +	u32 set_domain;
>  	int r;
>  
>  	memset(&bp, 0, sizeof(bp));
> @@ -457,9 +458,11 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>  
>  	if (!adev->gmc.is_app_apu)
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +		set_domain = AMDGPU_GEM_DOMAIN_VRAM;
>  	else
> -		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> +		set_domain = AMDGPU_GEM_DOMAIN_GTT;
> +
> +	bp.domain = (!vm->root.bo) ? 0 : set_domain;
>  
>  	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
>  	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> @@ -486,6 +489,12 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		return r;
>  
> +	if (!vm->root.bo) {
> +		(*vmbo)->bo.preferred_domains = set_domain;
> +		(*vmbo)->bo.allowed_domains = (set_domain == AMDGPU_GEM_DOMAIN_VRAM) ?
> +			AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT : set_domain;
> +	}
> +
>  	/* Assumes that reservation is shared with the VM root and that the
>  	 * reservation is locked
>  	 */

