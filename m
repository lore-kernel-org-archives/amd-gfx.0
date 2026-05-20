Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE7CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 10:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C226A10EFEB;
	Wed, 20 May 2026 10:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9Br6O4G";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA0B10EFEB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 10:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyWLpe9Wx3WeD8mtWzwXltq7cjgsqXxPUlHw7A/7hblk47R6KIkpgMdoJQXYRAhSC0OE6lZN2T7c6j+//Q75jnCTXiQPE4CghNNsEJSMcnP8qwFjGmxqCEI07qxPEnbuK+bEKHVhkw1og391E2kYgkry8VC0GeMrbXmwiuv/puaqYYuUYfNleM8x6V5dBFjyqMcvb+KaPuvpW8xfb0UMQM7fxckJ7EzYCpVjEbEoWxso4FEu0otJKslrL31CUUtv4fJ1HXzn0+9URgXl6+1iSU4JsC2Lkj+WRYEnZE8lJmyVNoZEnSHixNW+JulBVIy92EeVDFwFgS39soRYyfujXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo/FO5DVa9XYg+F7/+6MZaJoWbSNMQ5o2dAwEQ1ZmX0=;
 b=EGCYzgnI4kkZl+SCnK1FTKAunrS3yWEo8+dGgC1EyojMpRfTP8CUj3x1iFDlYWEpZAa2zPmQwI1WTdDAR52zNVmNIrk/XXl5dCaTJqUpPgQlM5PN4m3IfkJcj6CQGR6qKcGWyhCnwkLqLhv89G8TqGwp2LjoYBScqtBtLU/lXngssxYHd5bhsBxoRO2H4f/G3eZIWrPMaZ4i/UxodZE2ndotiAlddFNjOCFTuBNmhsNgVIaP6tnw8mfqvYK1h40Omg6HeyVSiNVZg7zwy5jTwWS7sS1dfpgqR2hfsWfvto45GmKaxHB3gbHXNejUxWCfuKPZ5I6upAcRMIpbB7uqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo/FO5DVa9XYg+F7/+6MZaJoWbSNMQ5o2dAwEQ1ZmX0=;
 b=D9Br6O4GIdeEj9rRGtAYw0KI3/sQoBGC6kCx2QxOEMT9G4C5z2F7uPC5e4XWw5ouMiQBSpM2HCfVVjg6mUrPq9zHxu1LNeoxEXBOAkzesUwO3cVagT9YEx33b9dkOR6bKb3ogd4mVMCruK8ddR60Uvf7Vupv5FRWaeS4hvEFpoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:26:46 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:26:46 +0000
Message-ID: <72d21111-0d6b-4f95-a320-c845616e7aa1@amd.com>
Date: Wed, 20 May 2026 15:56:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu/userq: reserve the object before pinning it
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
 <20260520025258.1866776-2-sunil.khatri@amd.com>
 <933edeb7-9f7e-48aa-a798-feb5c0cc7738@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <933edeb7-9f7e-48aa-a798-feb5c0cc7738@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb431a4-ce68-43b1-ac3f-08deb65a4b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: EAS3QXx6u557LLeMl1vDwCoMJAvTxI7BJaKdxYWgfppwkhC8vJIX6UWLR175cOxN8rOYdN4HxVW3EP7E02IVGwaaVoW1n8PiAzzhurcojiWnDt+LuOBXGWNGBm/+jx9AktDA+SKJ3gH7b1QNgCD1SNFFQZ/ApFpo70dmFYbJebI/KBr0Fz3DTxZvReJQv6ROU9atNtXhp0u+U4ee3g7FWa66hBWU7W3HCRkcet11qNK50qCayxTfzX+CwAzXKTX5ojfKRyJfIovJXeZAdRY2JCmSTkugiZVe3MrzMV16AXE/ijAIkxgkJKR99sI/3iuBnGc/H589mrQTk0oy2KYmh7dMZBEiDv/6yUIYer06Yg9xhiaN0DF3hafFTt8THMIxBjz2UTNOi8vTixzcFUmwPa0cQO0YN7BIyc39i5iRQ+3poZGqSKnZh7zA9P1RENIfvLuPXU33rWEGDnV0tIyYfaOVnbBwu5Wey5v1lrbnMiXflu5+jse7cNH7Mcsw5mGPsTJWS3v9R0H1YeGU/Pg37DUzvE32yv9eU2Qhah84m+vNxPS9zjJfo133krYoImKNXi+79ctZ/ZmHe3PJOBqKBcOuxJa7uwshHXaAV3nul38iPzzRoWSiq778gNR48CqfhC+5vYHrROzbL7VRJL5DBFawHwyLkfGrb9zhN8+PQUEYEk675Ed8nYPW4ysPFgCk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZJMGhrQ3pld2JRMk1iQXErbVh4YlFyR3EyRkY5OGtXdTl0c1Z5Q2h1MTlT?=
 =?utf-8?B?L3Ywd0JHSzkxTlg2QlFWbTlZN1dZSGdncWl3UlFlSUxqdXg5NE5xM1VKVXNP?=
 =?utf-8?B?ZmVMNE9RVUxxRDZCNWVPZ0JEcEpNaE1nTE1wUUhPdWpKOTBySFhDVXBGMUps?=
 =?utf-8?B?Z1QxdjVOMGc0Rk5SZk1JbmJFbWhOaFcrTCtmcjRuaVJvakFQRHh1V3dUbktR?=
 =?utf-8?B?ZEIrdEltaTJodjFNY014alBmaG9JWW01R3ZLdHlwQks4RHdZQUM3S1BBamhi?=
 =?utf-8?B?RmdVWWxkT2JCc1pidkhhZkgrMjNkRGsxdGRRZENWQTAvRUtiN2JpNWtIQzZD?=
 =?utf-8?B?b0RFYnBDT0RkTmNwbkFUSjNqMkpqQU9GS2FTKy9PRG9CbVRJSk1ZVDZ4OTFl?=
 =?utf-8?B?dGkyM0l3MWZJNE13NFRvNGhmbjZuWUhNTkRsbHp0UlRseGVybWxDUVpScEJy?=
 =?utf-8?B?dTVHdWxNZmxJNjFCRHg3eVBGYWVrMXFlRGVKeVZ3RVZBRE5rUTRkc0ZBMisy?=
 =?utf-8?B?a0NkZURxUmUrTTFtRlY1RXVuRE5ncHJhZWM0SHMyVjJtUWxRemlUZCs0T05L?=
 =?utf-8?B?Sjl5c1hMSE14WkxqY2VWcUMzalNaVWd2cU83clQ0cFhnOWZSaGxKY1g1Tmdm?=
 =?utf-8?B?ZmlrQThuMnh3ZjVwRkVhc3NIK25uN2lOYmNWTmQ3NE8rZkhtRmV3STRoeGpW?=
 =?utf-8?B?dUxxQWZKUWYzcjF5Yjg1UlVnRjZvYmxsMGRXTXUzTFNzK3JMTzEvWCtRZXZu?=
 =?utf-8?B?dWV1RmxKeVNJbUI5Z1BxUmVIck9qdzVOY21aOHBVU003cHBhTkVtb2F0c0Vm?=
 =?utf-8?B?eVFYNWFGeExLT3J1VmJHd29sY0p3UmVjNTV6S09wL2RBZDkzRjk1aStKY1p1?=
 =?utf-8?B?ZmhheDFIR3hMMDQ2ZUROZk5LSlVncG5iWkgxNTd0emg0Q0tlNlJsanBmemJa?=
 =?utf-8?B?blROcllJYjlFbWV4YkdabnNtMHdYclJOa28xSWJWbmUzQnhjZncveFpIem9B?=
 =?utf-8?B?Q0swbGNhdWZwYzRXZkxVc1QwcFYxcFBRdmdnUFZ2Y2xVR3E5ODlqdWdJWTJB?=
 =?utf-8?B?dkJRUkl6OCs4cGZtd0ROY1ltVE9SYmZaUnUvdkxQZHFyVmEvS1VHa3d6bXlJ?=
 =?utf-8?B?ZzZFenRGUmM1TGRFYnkvNEFZVnRoRGtHSVoxenNuRzZoRmkrT2djelpnZEhW?=
 =?utf-8?B?ZkRlVFJZSEJSZG9DWTlXTWxDU3p3eTFQTkovUkxkRm8rQU8ycEhKYlFFb1FG?=
 =?utf-8?B?QWxMamZvVUpsTEIzNWVjZVQ1dmtKWG9yYU9xZEZWdGpnT3B4aTQrM3RXc0Jl?=
 =?utf-8?B?QTlCSCtaV1dYOFkrK2ZaWkdVRzI2RFVNUVpocjZ2eXovQVZJdmVnWmJCUFl0?=
 =?utf-8?B?NjdPdkZZbEhtRzFrYWNBUFZiczlCVkhTcjNOM08xeTIyTDFNdWltNGZMMjNF?=
 =?utf-8?B?Y2RkMmQvZFJIVmUrNks1VXZjTHZwTGJ5UnFqLzZmWkFkQ1pNZDlGNjU3ZXB4?=
 =?utf-8?B?bVBteHBiQXlrMzIvNlIvc3o0cWovQjZKRE5XdEllOTRCdXI5eElBSUNlYkJu?=
 =?utf-8?B?SXNBU2x3MU15elJFUEc5dy8rdjVRTElkZ3hNUUc5WTNlZFJ3Ylo4ZHZ4OFNh?=
 =?utf-8?B?dTV0Q2lTMlR2SmxJNnZHdU9HTC9neDRBT3RXRnB0NWZoMWlIcDJlVHY1OW5k?=
 =?utf-8?B?am92MVNJaFRkdGJoNXEyMlpaLzlnL2RCUmVsVTVxbEFxaTZoSWwrWWI2eThR?=
 =?utf-8?B?QTZhQ3hQOVVab05YNTJIcm00SVBEZlFzV1h4RTZ6cjF0Yk1jYUo3VUpEbERw?=
 =?utf-8?B?ZTB4WnNtZ0Foc2ZRbGpQelQvL0RtYjJXYWdDNHB1M2wxcDZpelhDUGNKUjVn?=
 =?utf-8?B?SjA0cE1WNTJ1dkMrT0JqWGN2SzZKYzBKSWpkTEMvYkFQZFd2c2s0SjkrZ2d6?=
 =?utf-8?B?Kzd1cTl6R2FBMi9mSFVoK1JBU0tvNWJjOXlPNEt4Mzh2UEZxZHYreXV6WnQ4?=
 =?utf-8?B?QVJrR21rMEVUS0NRN3RZR01BZWppYU15V1VqTUtCWUNHMXpwcVJFMG9HUm1l?=
 =?utf-8?B?S05Lc1hWQXpaRHMyaTd3ZExPT0k3VHRoaStkU0dqN3VPcDBJTTRISktGVVUy?=
 =?utf-8?B?blAvWnhrNXZtME9vRHZoejl1d1JSM3lFcTUwSWh0VmJaMUV3SkFTZ1pVR1M5?=
 =?utf-8?B?RUl5RExrZmlGVTBRRjFFOU80MUlLOExNMk1adlpxT2dnSkluenNTOEFGU2Ew?=
 =?utf-8?B?c2Q4c1M3ODc1VFNXZ1R5aVF6RklvbzlLcml3NHF4ZE9KYVJCOU1kR1kyZUp0?=
 =?utf-8?B?YVdRclV0ZDk0QVBtVnI1OElrc2dOeXUzb2o0aGtzVjNlSURJZitPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb431a4-ce68-43b1-ac3f-08deb65a4b39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:26:46.1954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSmL0BMpkd+IcRfDQJQnPD3ZOuUNXBR8v29T1zvSg368fYf04exSvQExJSwO02YUwrwp13yIYY/1+XYLZ36x+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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


On 20-05-2026 02:26 pm, Christian König wrote:
> On 5/20/26 04:52, Sunil Khatri wrote:
>> In amdgpu_userq_destroy_object, we should reserve the object
>> before unpin the object.
> Yeah please completely nuke the function and use amdgpu_bo_free_kernel() instead.

Sure

Regards
Sunil khatri

>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0607b7078518..758bf099f0bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -528,8 +528,10 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>>   
>>   void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj)
>>   {
>> +	amdgpu_bo_reserve(userq_obj->obj, true);
>>   	amdgpu_bo_kunmap(userq_obj->obj);
>>   	amdgpu_bo_unpin(userq_obj->obj);
>> +	amdgpu_bo_unreserve(userq_obj->obj);
>>   	amdgpu_bo_unref(&userq_obj->obj);
>>   }
>>   
