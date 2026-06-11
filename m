Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D15CD98C7
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 22:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A25810E8E8;
	Thu, 11 Jun 2026 22:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+soW//a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66910E8E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 22:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssVVLhO3icceA1qEdx3rEQsaieXAv8GC3KZw+LMzTb8nHZPQRb0T8gvzctEbQTc5PlZMD9B2lwnWeb4hmFXrvQlLX0r+2/Yt3idKNMXibFW/p0g+yxD7gfaxz5K5JDssA9rE3Vjgd3FUaEea692S71nqDrACIAeKDiyeeKSP7YXbtK41KE0DiHT6bHA58zE5t/XLAEt2felhswUVC+cB6HLeDxAj9uiYgXdY/9QEFSavCW8zjGTt5yvuQCfxbZssn00OhegZeBkLddNUShOHXnxhXb7q4IJBNRwkJAx9YOF7NXNiOz3IlfLWKrohaRiH8WelqFEJn5JHWpsDVEXaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDlRuEamFOIvkE8+FPj+zmJ8lbs8sR5DxcEq9M1vdig=;
 b=cvkFxi29Fdc8Qh0C17YBC3N4hzYi+AHPo4Z3eX6M4ASmY7OyokwCAGf93JyTWv4UKbA7RWuSbTij8fA2lBgsHdD8UVhp3pBH2p4wH5mNjsfwUONK9bMDmG5KZikOfFMikNPZgLMTM/JsGygCldKl9K+7zQpLf9ZOJpGw2dFb1KRT6mz9VR+4swDJgXmA4krTnqQHSSO0w1ZiwWFutMQ7V/qjx6Raz91h9Iw3WjP6dzXMzf898m8G/WXwXGpeGNthtkKFMsKBjsFTejCw188NKAvPwTwqws5FBP6Cnm3Tco/W9NMtZcAPSjTSEkpaahbvu3ZMV2g1VGvG+OSroNV0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDlRuEamFOIvkE8+FPj+zmJ8lbs8sR5DxcEq9M1vdig=;
 b=r+soW//arkfJ9gcbuYRTqFeEXhXAP79I81u+hkrzhg/hx2UCK5cYu4ufUVbBa7ZpGJTtgqjYSEZdbI9KeGT9DW8eDIRdt674ubMfg7j4OiO1ZSQfhh0IpRwY+on6GFYvTOPgLTZqoK/AMqe00iF1h/2tDWh4TakRCqX6ENoTOwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 22:57:57 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 22:57:57 +0000
Message-ID: <e49783ff-fd2e-48fa-8438-1036e795e369@amd.com>
Date: Thu, 11 Jun 2026 17:57:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: check find_first_zero_bit before
 __set_bit on kfd->doorbell_bitmap
To: amd-gfx@lists.freedesktop.org
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
 <20260528184656.123149-2-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260528184656.123149-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:610:b0::23) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: d5493390-bc40-4b1f-945f-08dec80ce118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: TPOnXoLttxyQpUZ8uMGoIFUHycu1jmFxeYSfmSj8WWC4UhJjivBZdeELUW56HuGJG1Y75MSj4lsU9Mie9W9GcfSma6grqMtKKSQyp6jm42n/5Dc4a0bUXAHWhtH4x/jeOiTgqPCofwKHdfrOBSH/Wywa2qHZSZjuFMTP27ShpOfWKB1jZM8RlmSntnW0q+GO8wsJZ0eFCLkECTztlSQZueOd6lZTW4J0tK8lGPE/B/LA1sJOwVzLi2yNGdqVWMdBZbFpA/n8q9t2QUu0n8BKcgMjU4ZDfPBcBztdvlaenD7/iqJBMCxstJ48zFqUUytQMsoOqmsOVli8Hjv7WkBr7kQIrnR1H2vXd5CFF2bKiyDhVKBbzerf/It/xL7YAP19aMoRdvwUIB4cNGdKpaRA2Bp+JtUKyTE/CKnHrZTK/hB2X1XiWtflCJQLScZtZOMv0VzUphsUA2CsRlEmNpE63nOMln83mnVAPzs1j9bR78daMs7Ic31BJQIvQBkUGIugfa/sYcI1vrUNTCWA+ppZOReptenSaPx2YHSxXpHSHZRZwhyk7f19O6uPoq0ld40fVHuyH4vEqoIvPaQCgWwelonHH84ICYbIv3UnRsgvaGSDnxZsA4CUu83TDRsS/AWHdMJjHkTxWJEeX1lgfKi+XpEI3OO9XJOZPIeA3SQlCCQmGTHLFWWo/rFTMi1AAs+H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBkOHVQa09RNFN6ZFErMExFMU9ZWlQzUGp4em9mNzBoOEFoK2F4ZEFPK3lj?=
 =?utf-8?B?bEZlOGtVL1hHUWxTdG0vWnR6QnF5bjdFUjNKRitRWlNHWHd3cUk2OUVJNDVT?=
 =?utf-8?B?RmdITGpzUmtSbDEzS0RjNm5keXRxYlJiaUhVeFYwOVE1NkpCcjVzZW4zbTRj?=
 =?utf-8?B?RmxGVi81ejFxaHEyeWIyd2xrTmt3bE02MTJhN1dWQWtZR0Y1dkxPSjA0eDVz?=
 =?utf-8?B?ZE91UkdOUERlZWpDQnBOQ1BhK1YyRzh6Y1FvUXlxV2hiSEZLaVBGNzU0TEt6?=
 =?utf-8?B?MC9pUEJma0I5SGNnSUhlKzQ3WkhEY0hVMSs5SlpETHBBczZQb2xkNjZpUm9N?=
 =?utf-8?B?SGtISVVJSUw2NlVlWEhlTVZZbHNTRGpRc1poNmhIWlAzd1JWYVBzN3JCbEhJ?=
 =?utf-8?B?Y2ZIVVFOY1BBY1l6ZUlrVmhZa2x6bTYzdVRjcjNyUHBUTnlocU5oQ00vODAw?=
 =?utf-8?B?VE1yRGRraHhadDNPWisrV3IrdUwvZVp5NHIzL3ZKcXpiQmp0d0RIaVgyUVlV?=
 =?utf-8?B?RmN4WWhIakZyR2hrbGVMZm1meGFUN3pVbW41SitCT1BkTXB1VzQ4ZVhWYzFL?=
 =?utf-8?B?K0hoUWkrZGgwb2ZYczlaRVNUeGpiaTc5L3BTbjhKNTFSRFZCeTUyUHFrU3A3?=
 =?utf-8?B?WFdhMTlFZWxIY1JsQXkxaUFRUllDMUsrUXB4VUNtalgxZ2ZBZjgvOVdoQ093?=
 =?utf-8?B?NVhyMEU5emJNRWZYNG5MSnZCSFpoZHZHSDh2WEpnZngrNUttMThlT2dac1RB?=
 =?utf-8?B?bGRuS0ZiVlpOK05iUHhDZU5kREY0dDNHdUFPUWN0bnFHNCswQ2g3RStaV0dH?=
 =?utf-8?B?UUd2aXp3RXdmMi9rcWUzQXZhbm9BUDM3TEVYbjlQRXRISnVobWVqaitjZXZt?=
 =?utf-8?B?dGEwbzJJQXU5RDR0bklFMWVCYnUvb1NLRXE1cEdrNWU4bVowKzhFTlRJcktE?=
 =?utf-8?B?UDFDUEl2RUFiN1kzUm5HTVR1NGNGMmh2ek15MHNwQXUyVGJjWVArQVJ3SVVp?=
 =?utf-8?B?TjdGNGVkN1J5TWpRang5dzhQVGM0WlBvU3hZL2R6Y2VudnJSRTJIbmxTMlND?=
 =?utf-8?B?cjlOcmorK0I4OXgwM0RHUW5JcXE2ZW5LSlVnYm5NdG9raDU1NVdPM3p3YTFE?=
 =?utf-8?B?MmJkcjJ4bjAyMFdVb1lMcUQzVUdlbWo3QlpqMjBJT09yb21MZThZS1luTThj?=
 =?utf-8?B?bEttMFZ4UFhoRThpNHJ2NmRmNXJmMFhnS3J1L3kyYTdNazM0RG5yOENUVStn?=
 =?utf-8?B?OE5iVUtOQ25Bcy95Z2lpQU5JQjdVTWtxVks4cjFPQUx1ek9qV2VSZThoNCtO?=
 =?utf-8?B?Q1RTU0pUMDdENStVMkV3bnBmdU9DaG5neWJTeW5PTkRDWnYwS2xNYzlTN1F0?=
 =?utf-8?B?NGRpMzI5MnNNQXVzYTk5cjk4WmNpRXEwR2grLzI4UVdIRGpDVjhPVG9BeW9V?=
 =?utf-8?B?eVdoYWxNQnZHMUJBa0xwUW5hVk56dVIrSUU2cy81K1ZlWURWVjdwdVVKazk0?=
 =?utf-8?B?YWhqbGxRdVJsWDE0WEs4MzJPQlAxdnhNNDk5Zk01S3NXT2NEQy9ER1FzOGZY?=
 =?utf-8?B?Rk9uWHg3YmM2N3lScWdQZmt2T1NtTC9aYmNrbCtnS25YeHNCTHlnaHdmV3Na?=
 =?utf-8?B?cjd0RnpsR1ZNMkI3ZHFiYm9PUlJPT1JKOTZFc09tc3J2d2tpaWhSYzY2dE8r?=
 =?utf-8?B?bm83ZXdTWjN1UmhSVlJvMXJlcTNJTEliblhiWm1ITDByZkxIUXNpcGhOV00y?=
 =?utf-8?B?TGxFa2VSOFpqSmlPOVEvdjJMZC9oTDA0d0NFTzlXREhBNnM4L3VyalJYMHVs?=
 =?utf-8?B?NlFTOWIwWkRTU0RKODFOQWxSbTZWZjkvQXdIQW9UOFNacW1TanlPN1Q0WkEx?=
 =?utf-8?B?MlhtanY1RVQ3NThlNVZFSVhNWVJ4NnU2N3BkeUgzcXVpWGFkMjlnK1N1aUFa?=
 =?utf-8?B?RHIxRDNyblRUWXBScy83Y21KU0JFQVJCc3U4RU5xNU1sQU9ub2xIRTcxVXpO?=
 =?utf-8?B?YUxjWnNyaWRRd2lQV000RURLN0hmcUJsbzNUL1NBelphamhxN1pIR3F5ZWtt?=
 =?utf-8?B?MUpyMWJwd3o1TUxwZzMxdkl3b3Jad3FVN0RWazBSN0svQzlNRmM0elZEVFM4?=
 =?utf-8?B?UlJWQ3k5d2pOZWFvMDgvd0p6bzFtT0EzQmI4ZUFzRGdVZ1oweGx1Nm5LTHNi?=
 =?utf-8?B?aGxRa0lNdC93QTFyMmhrTlM5anVjanR4R0pCUGRlYTRKeUxvUVJ0S0xVUVFa?=
 =?utf-8?B?dUtueTFHY05QZm5hSm9nTjJjWE4rZmtkeERmaG1YbXVFOUNSNE1DeWF3ajRQ?=
 =?utf-8?Q?Nprx7kJ/5JHRuc3hJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5493390-bc40-4b1f-945f-08dec80ce118
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:57:57.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VuwEDWQc9QjHhnT7bg+XQInXzUYiPpt3aVqPgdIpqB+zBwAm/SoIRd+5ZRDxwiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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


ping

On 5/28/2026 1:46 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> If inx from find_first_zero_bit is beyond range not need set doorbell_bitmap.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 05c74887fd6f..18785d3bec4b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -153,14 +153,16 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   	u32 inx;
>   
>   	mutex_lock(&kfd->doorbell_mutex);
> +
>   	inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u32));
> +	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS){
> +		mutex_unlock(&kfd->doorbell_mutex);
> +		return NULL;
> +	}
>   
>   	__set_bit(inx, kfd->doorbell_bitmap);
>   	mutex_unlock(&kfd->doorbell_mutex);
>   
> -	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> -		return NULL;
> -
>   	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev,
>   						     kfd->doorbells,
>   						     inx,
