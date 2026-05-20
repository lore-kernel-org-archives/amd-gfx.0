Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2061CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 13:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CA910F070;
	Wed, 20 May 2026 13:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ECS/JIsP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93D910E105
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 13:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZd42QXJyfpGTvSGWy+qAXOA46vWBbf1JPh9lyY02OAjtD6H+uqP2htefD40jyd9xP5chPzhzHOSM4hyF1Ivdp7nNc636vV910AIZ72MGKJEBollFSRcRaboe/tNHRkRtDZdCJX3J6acQN3GwP8iRGzbARktgYEanZkR/UYb/CrQtisyF8chM957/ULMWIavUbujcjHH7nvOoaZ2JQQ50nZU0KTYEF5AJtJ8iYl8Qc71fXO3dg+6dpwAolld3R986q1BWqbVL3BMCF7MKgZrodMb8kfeUdACnKZ8LU7gtpWKLrJhXZX6dwQ2VVUr8dwpu8GbwiGcC+Q/i+iMpDaOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFBhTGkrXLRYcygIMvdYyZ7TP2FN54yPJTnkOYOAqDE=;
 b=kE7jMUXgJSgpWxVMwC72jK8w2mVkMj42QX/w/gDZTtT8n0Zl+MaxL8B5RcAd8JSDyCX1h/Lofi/oXg4N8fk0ktFwhpdTJhD3F7UOq91JGDRrbFfrvv+U/XQyAhyu2EiKZ5HhEnehH/f1nGkp2k/JKzKU2ADRE9qJbrzH+OQgnT5ktf4i0jBdRfY3ABRFnRKumEm0a9fqDEdss+NgJTYuh4O5ksm6jejFwL37kJIO2n2C6d+/xUSR/f0IC6oUS0Uj+PpXydmUp96YCoK+U2nIZkPgkvVQkDbud+WcDbB5S5Unyha3QEUPNPhMUYdHv28/4btXb4VYvPm01Dv04/7Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFBhTGkrXLRYcygIMvdYyZ7TP2FN54yPJTnkOYOAqDE=;
 b=ECS/JIsPNmDz/6TAZkhtQPBS2AiseUYTJxwGSZaRyDDxDg07IEcLT15il9/R92j2DP2V1WDE7KJJ6EmS5U0Mf6+snXLCwyVxJm7TcskwOGSeQDkkLU/MrOcVu61hlfSpA136ifI/XARjGw5gqkZ6vytNtBYNmenQ4iIwdeJdxfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 13:25:45 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 13:25:45 +0000
Message-ID: <f53d2a7a-05e7-40aa-8110-42cf7206fd37@amd.com>
Date: Wed, 20 May 2026 18:55:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/userq: use array instead of list for
 userq_vas
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520121019.2581398-1-sunil.khatri@amd.com>
 <20260520121019.2581398-3-sunil.khatri@amd.com>
 <2d625b39-7e49-4ed7-86e6-0b89f100d888@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <2d625b39-7e49-4ed7-86e6-0b89f100d888@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0173.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::9) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1cd6ca-f086-46a0-2062-08deb6734c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: XroD9nHmz9h6c+G1Ga3lAwaOtJ1LBXZyyyI+AtynkQAjhoPDrpLvHmmyoTv7J0xS3TCfMhItY6RVSR1GWbpeXoUnbeHb/2KW1Z4DQfVpyKUHBTr0iKBFdkF8K2nPrViVp9reNZzntMoryYlsMPnvfR4Zaa+6ksvmALmJYp9t8THun2XDMLvbICEQl19TSxRst1STm0O0HTyR3gvNS8lnE7jkgfnIT2Hn7nZAJpkprFXsk1t5B/9x2K6lYHE3q3OprVwwqlCb5prQWWApG2zVX0Von9P5qpLeBeSdntU5s0edE+tfPicbpBafKa6XbbEpMGQk1DYKPzeBTSuhWGDlTn2dvls6yULJKmbkk7T9qz+kRP49nwWYjUyHDRdvIvioDIfUTslg4q5CJFdUqWS1gmvTfZr1iLRQ970IrTh80ooGRjTYv5QAyIHUDusE5I+u2Jl2zLnlInX/SB/KxES3LmJDeXqKnE3M1Twh3r02CeDCGrBgBgAOZSa6zJRmIOE2yuDGBomAijBS+yAywkBZayNx/2zDvPD0NWtTkkii38RRkw16hHaAz+TQNfZQhdDzosVZ+oRANKpEHlXRl6OHOegNoIS21LM4p50NQi9WYa28ufG0QA6udtx0FN2KrYR/pfuGt5OiJfFXPdpK6lcyZnq2zcvPY3T9UuXMZ3wp722YwWdV2uVzAUsg4FXHB+A8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZDN1U3K1FtUks1REEyR3VBMldlbTZmNEUxbUJWNmtXUksvSW1hN2t4SEky?=
 =?utf-8?B?Nkp0MVFxTXoxNmhZM3NsOHJsTzBiZWVoTjA5Ym50MFZIanpmUlBuM0NBU1py?=
 =?utf-8?B?OXhzWVA2WE1oQkhrZUgwbEtCbmxZV3VYMVBORW5tR3NHWU9OV1dYbDl1cEZL?=
 =?utf-8?B?d0pPb3IzWjZzdlhJbmdjK3JIbnlRRVpTSDdXRVpiVkpWNWYxTnlMU3pHTnRs?=
 =?utf-8?B?YVQwRnFHa0t1UHpPTnpzZ2Z0cHNDcEhRcEx4Q1JIUno5K1lRNldPNzdzZzd1?=
 =?utf-8?B?dHpaYnNndzk1Wm4yUy9TT3Y5WHZwQk5WeVd3Q2t5bjc1czJ4YWJMUDYrODBY?=
 =?utf-8?B?MjlwckVkUmg3bmtVemVKa1JRNlArTTNDc2VPTUh1ZzZwcTR0QTZpQUNqMTBm?=
 =?utf-8?B?eHQ5ajk0Y3pRTExvcDRJVDI3RUZnTGxJV09aVWxGekxaTnovTXFPYkdWbjhM?=
 =?utf-8?B?TWJxTU90aVlYMGloazVBQkVXVElFWmpwNUY4OHFOSUtVM2pDOVBnUGlNdU1V?=
 =?utf-8?B?NFhLaGhpTU15YnJ6d1BhRWVXTEhBLzVKYWlYcXk5R2dZUEhHaXgxZ0EyeW9L?=
 =?utf-8?B?SEVoUHRMbnpoZUJKWkhobUg3TGlzVmc3VW4zbUw0TnFkeHdZanl4bm1Hbk9k?=
 =?utf-8?B?RmVNc0MwdW9paFhiUEh1R2F2MGE3UElCdWJmZnBVUUZUUGc1UkhPV0FIaEFL?=
 =?utf-8?B?Rzd3cmtsSlRBNVFBM2k3NTRnQzJpRFhQUEVIUmFxd0JIZGFXVng1Z2t1N2Nt?=
 =?utf-8?B?dittQlIxc3Z3KzF3dkxsNGFDSHFyL05VQW1CNHphNHZ6cFQ3UFh6T1g3TkRt?=
 =?utf-8?B?NmxLaDZCNGFpKy9Zemp1Wm4rSncwVlMvWFFmdllGWVRld1RkZFhsWFg2U0p5?=
 =?utf-8?B?RGI4MzBmdGU2Q1RUZ2luQTdkaGFxbW9NcFZLQk5zZmVDa2c4RjFVMWR5SEk4?=
 =?utf-8?B?a0FPTzFWaVBJMDF2ZjJ6SEsyZ251K3RBOWNjUlYxU3dnYVFMam5kclR4Tjkv?=
 =?utf-8?B?eHlocEx2YzNkUVZvWml5MllqRUhTMFJ3OU5EcTdaS1JpRXIvZ2RkMWhLS1lT?=
 =?utf-8?B?TXhIUlc0NEFPQzE2U1V5WndPWXZMZUpxUFl5ZWRCYUNuRWJXZFd1anAwRGND?=
 =?utf-8?B?V2d0ZUpVR1VtSUdFcVpHSDF4QnhEZExxNHA2WlNCeEI1SU1ycVBXNnBvaFB5?=
 =?utf-8?B?OXRpZUNvNW8yK2ZvQWgrZlRMYUtDYzY3OU84dlVvL1VVa2V0WU1ibnJUVkRM?=
 =?utf-8?B?c2l4S0ExT24wRmgwcStmZU5WRWsrYldnRWUyWW03azFPY2ZlNHF4dk9rejVU?=
 =?utf-8?B?V1VuUkRjR2FJd3dNb3NkL2pGNW1uZXpBMkNkWlI1WFdjMy81UEJtZEg0NEY4?=
 =?utf-8?B?NkhIOHNuZmlwclRtaXNGZXl2MGNDSEdlZzZhWnZIc0tEdjdQSGhCTHIreUxO?=
 =?utf-8?B?bWRHYzdqZXZ4bDc0T3dSWmNZNlVEVnpWM0JXQUMrVkhRS2RaSlh0a3F4U1Ir?=
 =?utf-8?B?b0R5MVhVbWdvQ2lWTEdpL2FRRC90SG5JZ3ZXQVJPRkhEZXU3SzUyUFIvNWlO?=
 =?utf-8?B?QlpSRi80UW5hY01PTHVZSmhxR2ZBQkFvcCs5TExiZkdWQW9KeEk2MEJvdld3?=
 =?utf-8?B?UmtKVzlGUG82R244c2w3SHpFMi9YeisrTVJWUFgzTTBVZjZSS1A2SnFwUUQ3?=
 =?utf-8?B?WTNOaS9LcGcyTjgxQWp1ME5OYnVCSFlINEVFMFd0NXZ6aTdPSVZXQ21sQVlj?=
 =?utf-8?B?NEFIM3JhSGY5T0N1alcwbFVzcnR6NU5NKzloQkJQSVhqd3haYmQ1c2JQdEx4?=
 =?utf-8?B?c0owWThwUENEOXJlZU9aUlZhb3p1ajFWVUFGY0hJcmZOYlhmT2kxYjBqNU5E?=
 =?utf-8?B?VFVHem9VMXZNcTJuOTdPOGlkQ29oaXpFYndScTlkZ0diVEs3UytHdlJxK1pv?=
 =?utf-8?B?Y0YxcEJKSjF3c21pQ1d4b3pmaW9yc3hmV1JURlN6WFF3QTlrRGg5dWpoZDMv?=
 =?utf-8?B?RjFzVnRHekpGMkUrbzRCVWt5OVQ2Q2pHRnJsMDNLcnlPNDIvbytJV3p2YWpO?=
 =?utf-8?B?UTBMNFNxZ01xUUU4QzhoNnNBNlE4ODdMbjJYWjNGejZXOElXOFIrdXdnVWov?=
 =?utf-8?B?NVhIM0FLWjIrYm1wRnk0dG82NFZ2aDVycmVWWEVGbnpZcUN3ZVk2cDMrbS9F?=
 =?utf-8?B?VERpbW4wcFRHYkl5Vk9Zem9obldBUzdKRi9GcXZVZzFDLzRKZ3VCYmJ6eFM3?=
 =?utf-8?B?c1ZERGMvV2pCTGlpTlZtMzNKMWEvcFFSekVsdG1xU1RrblJmbkxvZEZCeDdz?=
 =?utf-8?B?YitkdENNczV1TkpYcjhTUE1pdnZpdjVkSkN3eTJHOHJEQzFSenFqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1cd6ca-f086-46a0-2062-08deb6734c70
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:25:45.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNfPalMpuX3/WY3Si9XLb2Plc1iIpILLG5cswmok88LaQJkE8S4hH3GzGp6zAx3jYk3Ept5MH9QBnxrRnWPjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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


On 20-05-2026 06:50 pm, Christian König wrote:
> On 5/20/26 14:10, Sunil Khatri wrote:
>> Use array instead of list for userq_vas since these are fixed no
>> of bos and its better to use userq_vas and we dont have to clean
>> up later since this array would be free along with queue only.
> The patch itself looks good, but digging a bit more through the code we also have the amdgpu_mqd_prop structure which seems to have a lot of the same information needed here.
>
> Can you double check that as well? If there is something missing we could potentially add that but I really don't like to duplicate things.
>
> Thanks,
> Christian.
That's is not duplicate and is being used in Kernel and User submission 
and is a MQD level structure. So i dont think any changes needed there.
Regards
Sunil Khatri
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 89 ++++++----------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 20 +++--
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 ++--
>>   3 files changed, 46 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 8cc3c8e7e166..62f65118d37c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -215,33 +215,17 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>>   	xa_unlock_irqrestore(xa, flags);
>>   }
>>   
>> -static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>> -					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
>> -{
>> -	struct amdgpu_userq_va_cursor *va_cursor;
>> -	struct userq_va_list;
>> -
>> -	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
>> -	if (!va_cursor)
>> -		return -ENOMEM;
>>   
>> -	INIT_LIST_HEAD(&va_cursor->list);
>> -	va_cursor->gpu_addr = addr;
>> -	va_map->bo_va->userq_va_mapped = true;
>> -	list_add(&va_cursor->list, &queue->userq_va_list);
>> -
>> -	return 0;
>> -}
>>   
>>   int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>   				   struct amdgpu_usermode_queue *queue,
>> -				   u64 addr, u64 expected_size)
>> +				   u64 addr, u64 expected_size,
>> +				   u64 *va_out)
>>   {
>>   	struct amdgpu_bo_va_mapping *va_map;
>>   	struct amdgpu_vm *vm = queue->vm;
>>   	u64 user_addr;
>>   	u64 size;
>> -	int r = 0;
>>   
>>   	/* Caller must hold vm->root.bo reservation */
>>   	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>> @@ -250,20 +234,18 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>   	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>>   
>>   	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>> -	if (!va_map) {
>> -		r = -EINVAL;
>> -		goto out_err;
>> -	}
>> +	if (!va_map)
>> +		return -EINVAL;
>> +
>>   	/* Only validate the userq whether resident in the VM mapping range */
>>   	if (user_addr >= va_map->start  &&
>>   	    va_map->last - user_addr + 1 >= size) {
>> -		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
>> +		va_map->bo_va->userq_va_mapped = true;
>> +		*va_out = user_addr;
>>   		return 0;
>>   	}
>>   
>> -	r = -EINVAL;
>> -out_err:
>> -	return r;
>> +	return -EINVAL;
>>   }
>>   
>>   static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>> @@ -284,14 +266,16 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>>   
>>   static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>   {
>> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>> -	int r = 0;
>> +	int i, r = 0;
>>   
>> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>> -		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
>> +	for (i = 0; i < ARRAY_SIZE(queue->userq_vas.va_array); i++) {
>> +		if (!queue->userq_vas.va_array[i])
>> +			continue;
>> +		r += amdgpu_userq_buffer_va_mapped(queue->vm,
>> +						   queue->userq_vas.va_array[i]);
>>   		dev_dbg(queue->userq_mgr->adev->dev,
>>   			"validate the userq mapping:%p va:%llx r:%d\n",
>> -			queue, va_cursor->gpu_addr, r);
>> +			queue, queue->userq_vas.va_array[i], r);
>>   	}
>>   
>>   	if (r != 0)
>> @@ -300,24 +284,7 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>   	return false;
>>   }
>>   
>> -static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>> -						 struct amdgpu_usermode_queue *queue)
>> -{
>> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>> -	struct amdgpu_bo_va_mapping *mapping;
>> -
>> -	/* Caller must hold vm->root.bo reservation */
>> -	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>>   
>> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>> -		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>> -		if (mapping)
>> -			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>> -				queue, va_cursor->gpu_addr);
>> -		list_del(&va_cursor->list);
>> -		kfree(va_cursor);
>> -	}
>> -}
>>   
>>   static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -539,8 +506,6 @@ static int
>>   amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> -	struct amdgpu_vm *vm = &fpriv->vm;
>>   	const struct amdgpu_userq_funcs *uq_funcs;
>>   
>>   	int r = 0;
>> @@ -561,13 +526,9 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>>   
>>   	cancel_delayed_work_sync(&queue->hang_detect_work);
>> -	amdgpu_bo_reserve(vm->root.bo, true);
>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>> -	amdgpu_bo_unreserve(vm->root.bo);
>> -	list_del(&queue->userq_va_list);
>> -	queue->userq_mgr = NULL;
>>   	uq_funcs = adev->userq_funcs[queue->queue_type];
>>   	uq_funcs->mqd_destroy(queue);
>> +	queue->userq_mgr = NULL;
>>   
>>   	amdgpu_bo_reserve(queue->db_obj.obj, true);
>>   	amdgpu_bo_unpin(queue->db_obj.obj);
>> @@ -671,7 +632,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	}
>>   
>>   	kref_init(&queue->refcount);
>> -	INIT_LIST_HEAD(&queue->userq_va_list);
>>   	queue->doorbell_handle = args->in.doorbell_handle;
>>   	queue->queue_type = args->in.ip_type;
>>   	queue->vm = &fpriv->vm;
>> @@ -692,14 +652,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		goto free_fence_drv;
>>   
>>   	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va,
>> -					   args->in.queue_size) ||
>> +					   args->in.queue_size,
>> +					   &queue->userq_vas.va.queue_rb) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va,
>> -					   AMDGPU_GPU_PAGE_SIZE) ||
>> +					   AMDGPU_GPU_PAGE_SIZE,
>> +					   &queue->userq_vas.va.rptr) ||
>>   	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va,
>> -					   AMDGPU_GPU_PAGE_SIZE)) {
>> +					   AMDGPU_GPU_PAGE_SIZE,
>> +					   &queue->userq_vas.va.wptr)) {
>>   		r = -EINVAL;
>>   		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>> -		goto clean_mapping;
>> +		goto free_fence_drv;
>>   	}
>>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>   
>> @@ -711,7 +674,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	r = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp, &index);
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>> -		goto clean_mapping;
>> +		goto free_fence_drv;
>>   	}
>>   
>>   	queue->doorbell_index = index;
>> @@ -771,10 +734,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	amdgpu_bo_unpin(queue->db_obj.obj);
>>   	amdgpu_bo_unreserve(queue->db_obj.obj);
>>   	amdgpu_bo_unref(&queue->db_obj.obj);
>> -clean_mapping:
>> -	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>> -	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>>   free_fence_drv:
>>   	amdgpu_userq_fence_driver_free(queue);
>>   free_queue:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 76ef5cfab52e..28cfc6682333 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -48,11 +48,6 @@ struct amdgpu_userq_obj {
>>   	struct amdgpu_bo *obj;
>>   };
>>   
>> -struct amdgpu_userq_va_cursor {
>> -	u64			gpu_addr;
>> -	struct list_head	list;
>> -};
>> -
>>   struct amdgpu_usermode_queue {
>>   	int			queue_type;
>>   	enum amdgpu_userq_state state;
>> @@ -93,7 +88,17 @@ struct amdgpu_usermode_queue {
>>   	struct delayed_work	hang_detect_work;
>>   	struct kref		refcount;
>>   
>> -	struct list_head	userq_va_list;
>> +	union {
>> +		struct {
>> +			u64 queue_rb;
>> +			u64 wptr;
>> +			u64 rptr;
>> +			u64 eop;
>> +			u64 shadow;
>> +			u64 csa;
>> +		} va;
>> +		u64 va_array[6];
>> +	} userq_vas;
>>   };
>>   
>>   struct amdgpu_userq_funcs {
>> @@ -174,7 +179,8 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
>>   
>>   int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>>   				   struct amdgpu_usermode_queue *queue,
>> -				   u64 addr, u64 expected_size);
>> +				   u64 addr, u64 expected_size, u64 *va_out);
>> +
>>   void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>   					struct amdgpu_bo_va_mapping *mapping,
>>   					uint64_t saddr);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index ebd4e90cce63..9f4f2121a4de 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -318,8 +318,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			kfree(compute_mqd);
>>   			goto free_mqd;
>>   		}
>> -		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
>> -						   2048);
>> +		r = amdgpu_userq_input_va_validate(adev, queue,
>> +						   compute_mqd->eop_va, 2048,
>> +						   &queue->userq_vas.va.eop);
>>   		amdgpu_bo_unreserve(queue->vm->root.bo);
>>   		if (r) {
>>   			kfree(compute_mqd);
>> @@ -368,7 +369,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			goto free_mqd;
>>   		}
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
>> -						   shadow_info.shadow_size);
>> +						   shadow_info.shadow_size,
>> +						   &queue->userq_vas.va.shadow);
>>   		if (r) {
>>   			amdgpu_bo_unreserve(queue->vm->root.bo);
>>   			kfree(mqd_gfx_v11);
>> @@ -376,7 +378,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   		}
>>   
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
>> -						   shadow_info.csa_size);
>> +						   shadow_info.csa_size,
>> +						   &queue->userq_vas.va.csa);
>>   		amdgpu_bo_unreserve(queue->vm->root.bo);
>>   		if (r) {
>>   			kfree(mqd_gfx_v11);
>> @@ -406,7 +409,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   			goto free_mqd;
>>   		}
>>   		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
>> -						   32);
>> +						   32,
>> +						   &queue->userq_vas.va.csa);
>>   		amdgpu_bo_unreserve(queue->vm->root.bo);
>>   		if (r) {
>>   			kfree(mqd_sdma_v11);
