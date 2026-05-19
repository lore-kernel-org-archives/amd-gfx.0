Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A84CCD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B761710E5EC;
	Tue, 19 May 2026 13:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFyk1qKf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9835410E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFV4MWo8xVczKLRBowmziFtYgEe5Xo+O26c7FV6dRBPxfkNEvKa/TMckbNV8fPH692x8NdFUWR866Fmz+YhXeeXbNA0Fl8oWit8m20x1wszTFk5glGZmT5rXHc3A5wH4wOQqH0H6vxuIta4+cTiJ+Lc6Gg1miYnsHYcsALuI92LKn9MVu7sYCbRDlFh4vx9RaYJ1X1ipVGroTcG5+nM+TBdS9Od1pGm68eeaTHrFvQAYA/4TxYT4eaTdd08plVmvyuo47pKsYIVmOhJf0Q6ZsW+1f7FZWgAuWidpAwBOC6hEesVRX+R73rCxgUc034BNztc17NXTlpS+hQgiLB6pYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzzbAVjgv8WZVCYqWuVynWiJinNw7gLNnuRG2ftadPg=;
 b=K8IjYAMaL3sQaLGXRUaJCsK51CpPUjUInJQd5rxWQSPZPDCjjyHit3UuxGZLZa+8e6xCfhKmq0xm3n63H1mZjHkiNdHJ18e9dIHE6LKxeCWy1+2CcM2vw+zEE8F5BhvpJvT3Mr2pThosqu1YPFO1hdzZfXkB7Bsebz+0tiexhaVv1i3qSq8mD9glTTdtAtvso73yP0aO+sfW3PIcqGcHe9mq162JcAq6KgNHTaXP3945n5trYu1tu/f9cCCyLm/+/aZFzzeazk1wG6r4Hj0LE5hlepH1ZUr/S2hBmqgybm1uOl8kM/ps7kVk/gwLYODvfTdbeV3lAeU7hhYqIWwAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzzbAVjgv8WZVCYqWuVynWiJinNw7gLNnuRG2ftadPg=;
 b=BFyk1qKfrc0mQM3clRhs2oB67omlyKi/qTgw4gCK0eA9KSqc3FLn/6u40pFAyCPHhVNHDZ+e0c5jcVjf8DyAw77xyPexd2GQpK/2SD3T9l9VUYFONPy2FTJ4uD3biEJi4TJlL7C0dwQhMQtwdSJas5oaz+5BtqIWm/7BmP3wZaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:09:20 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 13:09:19 +0000
Message-ID: <db639edc-0b5e-4165-9363-43c265a75839@amd.com>
Date: Tue, 19 May 2026 18:39:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] drm/amdgpu/userq: Fix the mutex_init cleanup for
 fence_drv_lock
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-2-sunil.khatri@amd.com>
 <316ff7e5-b665-4a40-9a8e-f1f5ea07f794@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <316ff7e5-b665-4a40-9a8e-f1f5ea07f794@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a1b26e-bbae-4f62-fd72-08deb5a7d5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|11063799006|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: pVw8Zc47V7tdfl7WoV8MP4gBLTs7OX+KgKYlrWllNxZvEQ2awYVKMYBx3y6rwKNtnNg+CScKk4r3HRBk6Ss38UcLIdOuLhbfiSsCMm5APhxV9A2rJ38QwJX7sCl9cxWZ1d2Ylc285PmDOcY16Sgj+bzKCUJmaDGva/U8G10ucvSOKuEDBeFlCUlH2FFOnEjFV9JJdOJIRo2n3gfuGkjCUhtw1ydJ8n/Kmh6xpQLe8PQ5sfftph0UiipClJOpMUqVXl209StjAJDGFKY825eCN2afnCNsgFkkfeKWyMueKcOr8G6yGUa0nR2YROJjUQ9V9kJ3THDu9T01ahuZ5WwUQSxfRFIN+bX6VRyDxw15DgwziFTvIkXouebj07Se7KaPHf0oRVcQrkCqPYvQKwWd7iASByB/f8mJeI3WDeeGxLZKbXhL9EIzOXfMmsjkdCP7ysj9W4dSpWAyDzaP4OS3aKpBtjbWgLN8DaJM3DXNxK+uwyOkNulYek+mSozJzIVtUz5kD/clRxJ3tXR8iISot/JIoZ8BNmJ3tZEoufdzIOu7pHpGjakNalIZHAP7hWFmtM09pIegSJMUZtEKSV3MnsWbXpGbUQWVRBB2ry+xlcB1bewhEC09mKI0vwwpefK0pA6R6j8MDjr34dNCL70uB0JMtK416vWPWmi6VEI8xmXn8hpe3yj9edjnfHMEld8k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K08ySy96RE8wa0N4YVhKanEyWXB6bnpzam0vWEx0SVd6bmdhZ3d5VUdGRUxs?=
 =?utf-8?B?cDM0Z2x2cERXTXA0Rzk4a1VZQmdyWWNqQmdrNWtLdytPUnVLN252K3dUNWU0?=
 =?utf-8?B?clNkaXVRNjliMkFlNWtQNXZRQkNmc2tiUzBaYU5kNmFCWTdaM0xYN1FQMTQ1?=
 =?utf-8?B?UzFFQlB2anhROEJYdkNmdTdCcFEycDlCTXhsR1JsQVcxbzUrUnIzVUcrQzZs?=
 =?utf-8?B?UzFnY0JFU3cxclJ0Y2MrZmwwRjY4eVNVbWhZc25CL0dZU2NMSW5Ca2x4a1Uw?=
 =?utf-8?B?M2FTQWMxY2pBajZzRkFWN3JHd1dCeGJVMCt0azdKemJTQTI4aURFdWUyWHdX?=
 =?utf-8?B?N0d2QTlVYW8zS0Y0MSthSXhzOGczQmFaTlJuUkRLeC9Sby9TVWpuNUozRklq?=
 =?utf-8?B?VUNpRDhrUVdacDI4cERVVmE0MExiM0dxQ1BOclFlZUV3NTZxVlJXcWE4Umpw?=
 =?utf-8?B?aG42TGhzQy9CemJXNk1RQytYVGdmMkE1bHJDK25GTFhZVzRqTXdqMlNOZUk0?=
 =?utf-8?B?b25DeE9zOE9QR1FZc2dFYTczUUF0VkozS1pKcWR0UjJZeGRudVVqVnF1SVVx?=
 =?utf-8?B?VGtaNG03TzhkajBRME9TYjJUTEVmdnR4QmJsWHdsZ3d0Vk9QZFlBYm1JeXhs?=
 =?utf-8?B?T25aQ1pFRllEUlpHT0hSNFo0VFg3K3JicFB2RjBYWXNFTmZKTlMyWkpwUTln?=
 =?utf-8?B?UDJtNzYybTJZaTBWNWFFTDU3SDRFMTJpRjZtYUNNOEpHTmZMUDdCSUlJQUxj?=
 =?utf-8?B?aVpVQmF2WUQ5RWl3TkUxbXdWSEhRVWhBeFRSbVAzclpRWlEyUkJMVUxVZzBR?=
 =?utf-8?B?SEVuM2VnMkhEQU9wQVN3NTBDazgrQnVsUTBEaEFIYWpYV0IxYTZTRzdXMk05?=
 =?utf-8?B?WWcwbVdjOWVMeG1jblB3bHd4UkJaS2pZaFRyZitaN0x5c3llK0JmOHlEblJN?=
 =?utf-8?B?cEgwbEZXV0xVLzBUUTA4NDQ3dkJxTC9LZldpa3BBd0lMY2svTUwreEhZQWpj?=
 =?utf-8?B?YkNOek9lVFNFbEdxcUo5MXM1ekVjUWZTYjRWYnB5dzlJVDZxdGlIekFRNHFE?=
 =?utf-8?B?TTlqcXhpWmwyU1YxazNRN2o3aVRqWHV5ajJjK0QrdXgvdk13Z1V5TFd3UGpr?=
 =?utf-8?B?RWVkT1pmVzlib1ZSa3BTNGVLRVpLQmduR0l2TWNBMCtnZW42aGtqQUVPdXMr?=
 =?utf-8?B?VHQyQlFLVU01ZHpCWXNGT3FHNHErUm9BUlpxMEtqMk5ZdHQ5MVJlQ0t4cVh5?=
 =?utf-8?B?RFZrUmFna2V2SmZjTG04bGFYcDRhQnJoWEkzMmlYVEYrTzBDb1pyeTBoenFE?=
 =?utf-8?B?Q3pHeWcwQWYyckhxbkk5YVBqSE9zN3RXTzV1U1hMbXpRRUVJNmZFcEkySVhs?=
 =?utf-8?B?NmI3WHJXOStGMlJqYW1TVzBvMC8za1A3SnlWUk41b3RMSnNCN3JjL0pUUzlI?=
 =?utf-8?B?MUZZeEpBQVNrVGZPRVpQZnpWNEFJR0xOSVMrRUt3TjQrTVM3MGtnWUFEQU82?=
 =?utf-8?B?MWF3WGpVUVAwOVNkNlRXSVV5WGdZZkQ4WTFxUDFNQkpwbkFZYW1ta3BtUHFM?=
 =?utf-8?B?dnFRQ2pSM2ppcUhKancyeWdlUTMyOTZjdHRqSUw1RnJtSnJidTZaSzBwTHIw?=
 =?utf-8?B?TkthcE93WGttS1J6U2taVHFzbmVWOGxxVVlscE5hZ2RVZE9IN3RzdVZWNjNT?=
 =?utf-8?B?ODRUSWo3QnUvY1JtTTh2aHYydEUxVGhNbHN4eEI3THB3WHpSZGhPTTQrV0hN?=
 =?utf-8?B?UE0zMFkyNmNhWng1OWllNjRBTnZia3BUd0NKTjBmSWl4NWpDQ1VPb3oxdTJ3?=
 =?utf-8?B?cFFGbEJ5Q2lFM3VXQmgwNEE0MzNhdS9ZY0dMSDA5cUJqUWJaTTNuNDdZTVN0?=
 =?utf-8?B?d3NxOWU1NGhBeERuR2N0VVUrMno1NHB2eVZBZzF1SXRNNmZsMm9nb002c3h1?=
 =?utf-8?B?dS93UGZLM2dwTWkzQXVWYnNsWm1zZkhDc3JXZHJkdTlTR2MrYVdqYW5PTU51?=
 =?utf-8?B?cUIzNnlUdG1GNXUrazFBU21hemJZME5VQVd3ektCMjZBeHJ5V0w0OGk3SzZu?=
 =?utf-8?B?RjZVZ055bGRzOFkxQ21VY2NKMlQ4U2Q4ckR0RmtSUTVnSGhQWURZa1oxcFFU?=
 =?utf-8?B?TDZ1NE5OUEQrSU9GQ3AxeWlEZ1RUWXNPcWprVHJuMHJqektGVC9ocWR6ek0x?=
 =?utf-8?B?c002Z2FWNGdaZ0pLL2ROQytleXB3MTJqN1JSNkFWdG9naC9adTRUS3RXQXV6?=
 =?utf-8?B?Y3NYWHI2cHFEQzIyU1JCbFNlMjJnSUhOa0xRWVFHVlhQamdyWU9XNU43eUV4?=
 =?utf-8?B?dTBndG44emhSUlpRZ05tczlZRmJTalM2bTJZUC9VVUZ5ZTlkQWExZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a1b26e-bbae-4f62-fd72-08deb5a7d5d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:09:19.3191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Kb1+CxQlNFEe5NMKA+a27Q8TUaX1e+rXfaOG7N8r0BtfiJhPXD0vQJU4Rjg4/SJqZhZq7pI6jxkzp8OLpzb7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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


On 19-05-2026 06:08 pm, Christian König wrote:
> On 5/19/26 13:17, Sunil Khatri wrote:
>> mutex fence_drv_lock is destroyed in amdgpu_userq_fence_driver_free
>> also in one of the jump condition mutex_destroy is also called leading
>> to double mutex_destroy.
>>
>> So rearranging the code so amdgpu_userq_fence_driver_free takes care
>> of the clean up along with mutex_destroy.
> Please also move amdgpu_userq_fence_driver_free() into amdgpu_userq.c or eventually completely drop it.
>
> The cleanup done in there is actually on the queue and not the fence driver

There is no clear demarcation here, we are doing 
amdgpu_userq_walk_and_drop_fence_drv and amdgpu_userq_fence_driver_put 
in the clean up function.  If it's ok we could pick that up later for code

organization as its mixed use case right now and all the function called 
from clean up also needs to be pulled in.

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index eedea84c5e0f..3bfb9ae2cb3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -748,12 +748,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>   			  amdgpu_userq_hang_detect_work);
>>   
>> -	mutex_init(&queue->fence_drv_lock);
>> -	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>>   	if (r)
>>   		goto free_queue;
>>   
>> +	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>> +	mutex_init(&queue->fence_drv_lock);
>>   	/* Make sure the queue can actually run with those virtual addresses. */
>>   	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
>>   	if (r)
>> @@ -844,7 +844,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>>   	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>> -	mutex_destroy(&queue->fence_drv_lock);
>>   free_fence_drv:
>>   	amdgpu_userq_fence_driver_free(queue);
>>   free_queue:
