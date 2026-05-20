Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8186BCD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 13:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A8D10E135;
	Wed, 20 May 2026 13:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szNR0Wgc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9976710E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 13:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp2fQImAXS0RbSWVMTLwwYwQANusBFuafwWR/g68g0d3qPmasET0d+Wr54NK2RCRdytnNcBQuwhCqRjXZZrRQWXjBSrnUjrRkjS+paf30j4ciyLUr62CGi8w8zkeX7/KMThAOaBe8IB+y5S5NzhO4yUrwrtJsYx9OKp0bkRGlK1DXthWGhN/maDPQLY0EkUBS4QTPYDK9EdzJ6zXt0uQHEXm5xWli9Ua4iqsegQSxcy7mnMat/stnA2RH4V7nhDaIE1IuvveqU4Z/0lmt/+GOv81/JrMtfpQIhBF67HvO+WhMx4bW52+oEubDD9/uwOHcxV7RIBSqIAH4xThUbByAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waZN0xqzW1mOq3uQHH1VLbeiYVJJ1N0vKim+s4teWiw=;
 b=TjOOSBIcz6lnbiRhM0uG3t87rV/hX8tj2a17b9o4HnuaTWN9pWZqFxLxAw9qF1GqR6qWFPdwPkHh2IT2czqvjQxwQO4CqxFEpFu/xpeb2T0+Q5lnew47SxzOgbyuh8VcPlokkwQc/VPuUVDtWO+Yi3CPfB2OgE5qUNBrY4Gz13kMPtcG7OK6K2HiPNDhGa6xFJ2/SL5T8105kyW27/I3kyOK+8IntxX7u6Mw12Z/IFKsB/vVBuVzlXoWcwKqgAOkhOmvqpOBI0GSHrOg99HKI758ok42tsE9Vy1o+GGdFZ8tg+TbqsRNqOPhQNp0Ta7wR7rJnp9kHNgFlsZeyoWEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waZN0xqzW1mOq3uQHH1VLbeiYVJJ1N0vKim+s4teWiw=;
 b=szNR0WgcjcB7bFIA4U+dfgsMI16GH85qb7/l22HY5naNrmlR5VnuTXcxJ8xkwjoDGpadbwCz4/42DryXV1MFQYajNRDf2ozwgTBaCBa8Bqc1iPZfKS+nZAeahtz/C/O5dud1D4n6hh9h08SoEW5/FE9nDjGnE6V9nbXwHeH34YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:20:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 13:20:06 +0000
Message-ID: <2d625b39-7e49-4ed7-86e6-0b89f100d888@amd.com>
Date: Wed, 20 May 2026 15:20:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/userq: use array instead of list for
 userq_vas
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520121019.2581398-1-sunil.khatri@amd.com>
 <20260520121019.2581398-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520121019.2581398-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:408:e0::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: f47ed9f4-bb35-4c0e-239f-08deb6728215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: KHrs3QdmI/lHiOsbrGgzTY2DFWioeozyGZqsFi10Kxnp3y5jU4kOxtX56/hHyGTnfIl06CTslHG9IMtiRutSEKcW0sB6KJs8VcZOIyds00uIbwSAprLPaRqbhlavnO0UaiLWezn4WC4pWm2Pn6XXtT3zpfoMYnYdoFTgmaoHd1HKJNcJeFy38l1bWeYQDvDOk+fgUU9vEx/wAolcuf2Ok3nG46KXsFzMTFYQhTwys2ohoZ16XVJ+755HdU4H8gtfWLAXyv5tryt6EM9ozodH29HXsu0hRLQQB8Xll1Xlw9xpuE/52Zipkh340DY0WuMeHGXj1GpirtmIkTEjMuwEMbr6+MVTYo1zJ6CPVlAZ4r9zRNmToJlsF/6RktkvCNH4MFp5bU41al2B0PS0kSwOUTLefDfhJSPfEmuOn0chTkppUe/yCqslzT5bbfUMaLrRyA3TGg7bpcGVe9FgThkVMJ7fKFzne32ed+uAd7E3u8Q3fYuqZ+1dfQBweotdt/2f14VgCF6rf1piKCWIALTqzxLq0WP8/MYI+1ScoIh8NAIsDZPG5nSt5GYQ1qYT/ZxYmYaPP/JUIMRQvDuNtdmyUS0hfF4VH9VG8qBuQC5TFe0qprqsM4gHoZZezLW+rjL1jPrQPvlQplkR1EXAR+C+Fo7+pyC2ZI5TkPmyFxvf/sWGPuGeZVm1vJiND38weTQD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJ3WldMaGZhZXdHUmJqVUIvblhRbWVkZVlhUkpuQUxNditKQmdHaFhCcVhO?=
 =?utf-8?B?RlVVUFdSNFBqemg1YmdqaXFsUFlnT2ZVSUU5ZDExbHczc3F2TElIVnFJdHJB?=
 =?utf-8?B?MzRGbVc4TnFvV2VWc010NnpXcEl4cG9lK0tyTnVzSm1DS3B4Y0c5dGtla2NS?=
 =?utf-8?B?VmxudWptejRhRDg1WXAwRkdnVGhzNTdaUWp4UEh1MWtGMEkyN2dGc1BDdGF1?=
 =?utf-8?B?SVNIb1pZcHh6UDdVK3BMVzNsckRBc0pSSThKS0xaMVlud3E3dEtjcnBIUTVQ?=
 =?utf-8?B?aE5Hb0RQM2JWTzJGc05ZRDE3R2E1NUdqcXdnNlQzUTl3RFIrN05lU1dCRnFL?=
 =?utf-8?B?UGpSMUF2TjZHb2QxT2xLK0ZJaW9nRk5EWkZ3dG1QU3cxU2t3UUxvZE5HZitH?=
 =?utf-8?B?VDk2d0trOWtyb0FrNHVTZ3ZhTFhkeWtLQ2hoa3JrY1QvNFYxZlBIdkgwMnZH?=
 =?utf-8?B?dXZJTUc5djJJcFh3anNMQk0zZFp0TEdyVStMNHg5bzNFZjJnZXlsWjRXbVdL?=
 =?utf-8?B?bm5FTjdYVG5rVW1icHRmbzNVRzI3Vit5K08wM3NDblgwaFBqWHpmYWs3UVox?=
 =?utf-8?B?bzNnU0hOazVzWnpLYkdGdktCY24wZ1ZCaTdKSlUwY3pXSXdGSlNoZzVxVjBo?=
 =?utf-8?B?OTZsWTNJSDliTFdRTUtzdXR4b1J0RWFrYkEzeStTdkVvdnZYZ3RlKy9uYm5H?=
 =?utf-8?B?R1F5OHlIVTV0WnVUQXlTRDZFUE1XakRDM0tvZTkvdDBHL3J6WDI4QlQwazJJ?=
 =?utf-8?B?SkxDSlRxSnc4STZhYXpOSWVWVUpEelFnRy9waWQvUW1uZ1dFVU9YeW1FV3li?=
 =?utf-8?B?ZDB5bVE0Wi91TytmQzJKTWw1b2huRnJzbWZxNVZXRmhkcU55SHZ6cm1vTjAy?=
 =?utf-8?B?VnN1aTZZSmE1djBHSk5naGtQVlg2NkY0cnZRUWRKZllUSW5VaU9xeVNhZzVG?=
 =?utf-8?B?dkMwblY3c0ZmbG5rRndXWVc3a0JUQUJZcnN1OUxOdkRIUk0xdE1qSlRqWDRW?=
 =?utf-8?B?djhaSDBVOWxlWXppRlpJMTgwaFRqSlFhbE9WRjdKVlM1TUQwalB1OER3UDI0?=
 =?utf-8?B?U1pPdk9BVlRvN2JUQ1dFTGRZRmhwdk03K0ExUW9yOXprb1dDR3NueDRhQnRQ?=
 =?utf-8?B?OUxnS1l0c0Noa3J6U2lXK1BCaVFQZzBCMEJSa0pKekF0V1dXc0VJYWZMcHk5?=
 =?utf-8?B?WWdXNjNXVHlPSnFYdGovbmJVRmtpcHR3RnY3NGtjaHFHSWZDZStXUys4RUdt?=
 =?utf-8?B?SXd6Uk9lV01TY0NIcDRqaXZYb1h5NFUyVFB2ZFA2aUt6LzJDNDNpcjdicGlw?=
 =?utf-8?B?OEFJTW1CUlkwNEZIbDUzaU9rdVFkdmZlQXBJMjNLWGVXbUxxemZsc1pwTmpC?=
 =?utf-8?B?R1NqWUhXSGxTd1J0K2QxNC9iMUloVGRoQ0tLQ3M3S0tRQVBMMkJnYkJSaDRX?=
 =?utf-8?B?NzB0TEowMmNSbVN0WDE3dE4zWXVhdm0rSE1rQ3VKZFVrYVZmczlyb2tXeGpl?=
 =?utf-8?B?dlVFUzdhSXR6bk9IOVRGMVdqeURhUHFLZ0x3Rzh2SmlLUkJIbWs1YzMrdXRj?=
 =?utf-8?B?YnlKVHVrMElUbHoycm95U3oxLzgyMERrR1hDYmlXeFdjTTF5cFNNRUMxN3po?=
 =?utf-8?B?VjBRZStseWJuWWZPSkR6OUFlVEozUENwSE1YaWVydGg3aUgrVGMwVG83R2Nw?=
 =?utf-8?B?TnRuM1RJbHlneEZTRnhHOStOaklEY2IvMUdhYnhIMzQzV1MrSWpxM281cCtj?=
 =?utf-8?B?d2tnTHh1ZG02MStMZnpNTWlpYWJCQ2pvYzlyTzVkYjlheGc5N1lMOEpwcm03?=
 =?utf-8?B?enNNQU9ON0drQVhjZHZoem5vTUlJejQxR2ovRG4wUi9jN29JTWhuS2tRNEFJ?=
 =?utf-8?B?OCt3YVJjK0FITjdPc2pqZDBtMjNjWEhJZ0p3T2hWWkJlU3RIRlBpMUM2TW5U?=
 =?utf-8?B?RENSYzA5SG9hUmpxMUhDS2JHRE9ENHVHN1hLTkIrTStmaXBYaFhWNGZmWGZu?=
 =?utf-8?B?bEUzZkhaNS9LZk54RzlKMmUxOVZRUmdYT0RMb2tGZXpDYTJlallvem4zZitM?=
 =?utf-8?B?OHBhaTVtMlJGK2ZqcWttOXJMMjFuY3V2WDFwZVRYRm5Jd0tpWmxweGtFblFZ?=
 =?utf-8?B?U0R4TkV2NldxZXlUb3RpUEd2S0NJT05RL0gzRUVhblZXeVdJeDFLWlBrb29J?=
 =?utf-8?B?dE5ZOEFTRmxCcTJ4Tm1LV0FiRjhxWE9jeitCM0V1UFNFNG9iNzU1d01jNVFQ?=
 =?utf-8?B?VUt6dUsrTWV4aTYwMzVpa3lmdVIwcHhqUFpUU0d6QTNUZVlYeEQyRTdiVG9a?=
 =?utf-8?Q?Cg9C8eDvTNQSaiiH2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ed9f4-bb35-4c0e-239f-08deb6728215
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:20:06.1052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI13GcfGajeQOTbhHLErvj1MtAnP3w8Bf74T4WZK4F0imopsmTA6hnEzwEj9c6cH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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

On 5/20/26 14:10, Sunil Khatri wrote:
> Use array instead of list for userq_vas since these are fixed no
> of bos and its better to use userq_vas and we dont have to clean
> up later since this array would be free along with queue only.

The patch itself looks good, but digging a bit more through the code we also have the amdgpu_mqd_prop structure which seems to have a lot of the same information needed here.

Can you double check that as well? If there is something missing we could potentially add that but I really don't like to duplicate things.

Thanks,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 89 ++++++----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 20 +++--
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 ++--
>  3 files changed, 46 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8cc3c8e7e166..62f65118d37c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -215,33 +215,17 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  	xa_unlock_irqrestore(xa, flags);
>  }
>  
> -static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
> -					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
> -{
> -	struct amdgpu_userq_va_cursor *va_cursor;
> -	struct userq_va_list;
> -
> -	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
> -	if (!va_cursor)
> -		return -ENOMEM;
>  
> -	INIT_LIST_HEAD(&va_cursor->list);
> -	va_cursor->gpu_addr = addr;
> -	va_map->bo_va->userq_va_mapped = true;
> -	list_add(&va_cursor->list, &queue->userq_va_list);
> -
> -	return 0;
> -}
>  
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  				   struct amdgpu_usermode_queue *queue,
> -				   u64 addr, u64 expected_size)
> +				   u64 addr, u64 expected_size,
> +				   u64 *va_out)
>  {
>  	struct amdgpu_bo_va_mapping *va_map;
>  	struct amdgpu_vm *vm = queue->vm;
>  	u64 user_addr;
>  	u64 size;
> -	int r = 0;
>  
>  	/* Caller must hold vm->root.bo reservation */
>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
> @@ -250,20 +234,18 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>  
>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> -	if (!va_map) {
> -		r = -EINVAL;
> -		goto out_err;
> -	}
> +	if (!va_map)
> +		return -EINVAL;
> +
>  	/* Only validate the userq whether resident in the VM mapping range */
>  	if (user_addr >= va_map->start  &&
>  	    va_map->last - user_addr + 1 >= size) {
> -		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
> +		va_map->bo_va->userq_va_mapped = true;
> +		*va_out = user_addr;
>  		return 0;
>  	}
>  
> -	r = -EINVAL;
> -out_err:
> -	return r;
> +	return -EINVAL;
>  }
>  
>  static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
> @@ -284,14 +266,16 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  
>  static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> -	int r = 0;
> +	int i, r = 0;
>  
> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
> -		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
> +	for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
> +		if (!queue->userq_vas.va_array[i])
> +			continue;
> +		r += amdgpu_userq_buffer_va_mapped(queue->vm,
> +						   queue->userq_vas.va_array[i]);
>  		dev_dbg(queue->userq_mgr->adev->dev,
>  			"validate the userq mapping:%p va:%llx r:%d\n",
> -			queue, va_cursor->gpu_addr, r);
> +			queue, queue->userq_vas.va_array[i], r);
>  	}
>  
>  	if (r != 0)
> @@ -300,24 +284,7 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  	return false;
>  }
>  
> -static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
> -						 struct amdgpu_usermode_queue *queue)
> -{
> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> -	struct amdgpu_bo_va_mapping *mapping;
> -
> -	/* Caller must hold vm->root.bo reservation */
> -	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>  
> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
> -		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
> -		if (mapping)
> -			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
> -				queue, va_cursor->gpu_addr);
> -		list_del(&va_cursor->list);
> -		kfree(va_cursor);
> -	}
> -}
>  
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>  {
> @@ -539,8 +506,6 @@ static int
>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> -	struct amdgpu_vm *vm = &fpriv->vm;
>  	const struct amdgpu_userq_funcs *uq_funcs;
>  
>  	int r = 0;
> @@ -561,13 +526,9 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> -	amdgpu_bo_unreserve(vm->root.bo);
> -	list_del(&queue->userq_va_list);
> -	queue->userq_mgr = NULL;
>  	uq_funcs = adev->userq_funcs[queue->queue_type];
>  	uq_funcs->mqd_destroy(queue);
> +	queue->userq_mgr = NULL;
>  
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	amdgpu_bo_unpin(queue->db_obj.obj);
> @@ -671,7 +632,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	}
>  
>  	kref_init(&queue->refcount);
> -	INIT_LIST_HEAD(&queue->userq_va_list);
>  	queue->doorbell_handle = args->in.doorbell_handle;
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
> @@ -692,14 +652,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto free_fence_drv;
>  
>  	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
> -					   args->in.queue_size) ||
> +					   args->in.queue_size,
> +					   &queue->userq_vas.va.queue_rb) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
> -					   AMDGPU_GPU_PAGE_SIZE) ||
> +					   AMDGPU_GPU_PAGE_SIZE,
> +					   &queue->userq_vas.va.rptr) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
> -					   AMDGPU_GPU_PAGE_SIZE)) {
> +					   AMDGPU_GPU_PAGE_SIZE,
> +					   &queue->userq_vas.va.wptr)) {
>  		r = -EINVAL;
>  		amdgpu_bo_unreserve(fpriv->vm.root.bo);
> -		goto clean_mapping;
> +		goto free_fence_drv;
>  	}
>  	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  
> @@ -711,7 +674,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	r = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp, &index);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
> -		goto clean_mapping;
> +		goto free_fence_drv;
>  	}
>  
>  	queue->doorbell_index = index;
> @@ -771,10 +734,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	amdgpu_bo_unpin(queue->db_obj.obj);
>  	amdgpu_bo_unreserve(queue->db_obj.obj);
>  	amdgpu_bo_unref(&queue->db_obj.obj);
> -clean_mapping:
> -	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> -	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  free_fence_drv:
>  	amdgpu_userq_fence_driver_free(queue);
>  free_queue:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 76ef5cfab52e..28cfc6682333 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -48,11 +48,6 @@ struct amdgpu_userq_obj {
>  	struct amdgpu_bo *obj;
>  };
>  
> -struct amdgpu_userq_va_cursor {
> -	u64			gpu_addr;
> -	struct list_head	list;
> -};
> -
>  struct amdgpu_usermode_queue {
>  	int			queue_type;
>  	enum amdgpu_userq_state state;
> @@ -93,7 +88,17 @@ struct amdgpu_usermode_queue {
>  	struct delayed_work	hang_detect_work;
>  	struct kref		refcount;
>  
> -	struct list_head	userq_va_list;
> +	union {
> +		struct {
> +			u64 queue_rb;
> +			u64 wptr;
> +			u64 rptr;
> +			u64 eop;
> +			u64 shadow;
> +			u64 csa;
> +		} va;
> +		u64 va_array[6];
> +	} userq_vas;
>  };
>  
>  struct amdgpu_userq_funcs {
> @@ -174,7 +179,8 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
>  
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  				   struct amdgpu_usermode_queue *queue,
> -				   u64 addr, u64 expected_size);
> +				   u64 addr, u64 expected_size, u64 *va_out);
> +
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping,
>  					uint64_t saddr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index ebd4e90cce63..9f4f2121a4de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -318,8 +318,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(compute_mqd);
>  			goto free_mqd;
>  		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
> -						   2048);
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   compute_mqd->eop_va, 2048,
> +						   &queue->userq_vas.va.eop);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(compute_mqd);
> @@ -368,7 +369,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
> -						   shadow_info.shadow_size);
> +						   shadow_info.shadow_size,
> +						   &queue->userq_vas.va.shadow);
>  		if (r) {
>  			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(mqd_gfx_v11);
> @@ -376,7 +378,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		}
>  
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
> -						   shadow_info.csa_size);
> +						   shadow_info.csa_size,
> +						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(mqd_gfx_v11);
> @@ -406,7 +409,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
> -						   32);
> +						   32,
> +						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(mqd_sdma_v11);

