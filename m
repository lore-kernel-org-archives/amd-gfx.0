Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4804C43458
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jun 2026 05:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D40F10E043;
	Sat, 27 Jun 2026 05:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGDG1AmJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF0B10E043
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jun 2026 05:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVgCnmjmKcaqSfPxkafj4iIvbTG+U37y8a1Uio7KifyKyP0hdaRi3RCUjj+Wq5Y/v8xszrYSCL8KlUzV+bA5Qc5P2bZ0cArdqD2xfTkP3IYdqrKyJVFWPZ0D9bAiXLXi2zlUH5s/kdhaIlTabklMuuTUcVLYlFstuDJF1aLey7TC8JuhqjpNbdjmpNDQDLBX3334xNtP5Ru/fuOrAmpOWp9fQ+n2Zj4BBwrFCoG/vophsMVDIw+j3bhoaGLHKGYqLDHBefHMxjJ3LuPkDVn/fzJ27X70TwnxoxQtzzvFVvYCm3Qr25X0ZA9FQRykz/WOhWiwiH6NJBL0n3o6Kzy/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eErGS1goHWEUpg4si2y7ygZFQVzNPNguSOINkvYBdbQ=;
 b=QyOqE4ptoQrrHu//7IQxLXjRo2a1LjQCGZF8tWIhmeEEfH0LbVX9wZQhqTDB3AAthBXHQDUC9Uwgiq7zC0ZrjDIeUZ8ADfw/KrYUJF3ReyowjJyNAkcIPZEqh3Ct4MyaIAzTI9KiyIp+R3tNXwVNCyGfL+rKRjrGMFomIEOYoc/RMLE+sHw9XBWvJ00KWp+6Pv4/YhSZNRL66VqSXse8qm9I6Pk1WGO3diVG0ElkJpfG5NQTY2hRFBVzlKXEZ4y6S0UEgEzbxPl1aWGu2mJ26U2iiUAcZ7gQ8X74/mlR2lcT62K+LVwRubd1MfAvFrWnM3uVQjbHrUet60H4NbxJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eErGS1goHWEUpg4si2y7ygZFQVzNPNguSOINkvYBdbQ=;
 b=XGDG1AmJLgqW/AyibSOXfFdJNhZ0ViP3G6um9CGeVzTiREhURmEgPwq6kYNA8qYnmVDmrPsthFrLW1RNPYgaWEcoVFKn/+3rtNzlT91sLDk3gg3XrOYjM++aavhUILUR0kE98gPCSiJaTJzEfi6ABWKd18MhWG161ZUykhFSP7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Sat, 27 Jun
 2026 05:25:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 05:25:05 +0000
Message-ID: <f281601b-2f81-44e1-9b5c-67473991bb6c@amd.com>
Date: Sat, 27 Jun 2026 00:25:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Simplify filtering rings during IP block
 soft reset
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20260624073829.40835-1-timur.kristof@gmail.com>
 <4b2ebeaa-f3a4-4787-b8d7-76cd225b6564@igalia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4b2ebeaa-f3a4-4787-b8d7-76cd225b6564@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:806:24::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: c198622f-aba8-40f7-1450-08ded40c71dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bOPNmHtzSsOx2UeJW2+CPaQ+TYZtYwQTrzoXxPtWmU27RhPOR+7vashKH7SFjwClC53nmmSqeLNkN4plHb+iNH0bgdzkRdbq1WMqGcE7zIvk0Q+LtTwJ/URqr6N1lJibYqYiXZGimfDg9ap5lEDZDHw4sZcuWFabMN4qKNkP+SZVD9hRK/VoHvbA7x5bdMNfMaflMt/mu2K0/E+bmqfVkDOZgct+QHihOkHihxWbLn9DUoY8BsfNhzkrtm4G6ccEpZnPuRhxBcoZkTA27H9JlMHe498hhbNzqXqStLQzWENBplVSe0DeKJDV5iMFyWTxsIn+aHRrw90PgK+Mi10AJ6BrpDAIN8HEdPErB8i5oi+2TabMGRAG4AspiqBQ/j2vJ/uhOe/hxCWnAXd72xaGrWDPSA97YUtWBIM8+eJQV/jXzK6M6y2JgSiX90b7Q/NzryG2FrUji5R/DQMZveY1F4qF/Q41A53YifYQVlOMqbXC4sv6wfGed6P+wKoW/a0IJ2HM9op+5dgDrlTFfNpTR9c4YK8kVpByNAnrPmdEcqIpTc2OtgbYTu8Jcw0PdlnTzTUT5VSzz64A4lviUt7pyNVVP31eWo7rP4vvLRvpk61TyHS4ttoYdrOSDqSGmPcZgtulMXTltjcCO9OCFfd12St3XXjoew4HapwN/aJec4qfbYdWQTCGG7zyykUlWKajDflbcwsxspa5X2zibx/SIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVFMGJLbDROQWpMdUNBdGNVRGNFWFMwYU55ekJ4MHhOZmNzc1F5b1VIZ2RD?=
 =?utf-8?B?NHEyTUE5c3lDMkE5M2lXNEV5WUtsc3FabWtEK2laM3paWmpmS2Z1N1d4VE9l?=
 =?utf-8?B?eGRtRFhaZlNMM0ZrTmF1MnhJMTNqdFNoMi9rNUtjS1NNUEJKYTNtK095WFdm?=
 =?utf-8?B?RDBjVmRlUnlIS0RKWHJ6UFdlWDBYK0JyczRWQzNNdlFsaEFFV1ZROERzWHoy?=
 =?utf-8?B?RDBuSVFBTkVibXFwdHRQRUxmd1h1MWU3SmhQUENVeUJ1Z0JuOXh2K01MUTNu?=
 =?utf-8?B?M0pPakhCWHhnL2tDa2hQMlBLMElMYW91Q1RXTEhDaTlQWEhuKytBaHZmZks2?=
 =?utf-8?B?NGZBaFg4SEExdFV2OHVmSmNUWWRNcGN5eW9HT3ZhYkRXSitoU051d1BOUFZn?=
 =?utf-8?B?OWkrYm5QbER2QzR4ekVkNGY4RHlVQUxUWTZVbWlTWkVaczhhRlR5Mng0czBm?=
 =?utf-8?B?eGxJalpHdndPeEdMTXFyV2wvYzFLakE0UGpOQ3RNcHNXOVhTZlRMb2pVNlVh?=
 =?utf-8?B?OUdSM014cTNtQnI5QjZJUWdiTkRDdUJXL1VsZ2JyTlJXQzI1Z3hpUVJselRR?=
 =?utf-8?B?TExZNnR6eEZxd2J3aUhWNlNXV1Zhc3U3QXFsc3ZORjlhM000YUpDL0doeDBQ?=
 =?utf-8?B?TkVudDlUYnkrSVVDU1VBbGcrSVJZb05acm5hem5ZMzE3WXFETnF0TXFrZEIw?=
 =?utf-8?B?dDhWRU1UMy9tU1o3R1g5RWJ6a1ladC9WdDR5Q1VnSXRRTDljWGw0K3h6UmFN?=
 =?utf-8?B?OG1xd1pUeWRzaDRuRjc4dWVhbjRzTmNHU2lhY0RqMFI0eXladUt3WVFibDY3?=
 =?utf-8?B?a0tydlNrblZlSGxXcVloUGgwaStoWStXMnV0eWN2ZmJHWko4d0JxTHlxZ2hS?=
 =?utf-8?B?RE1aVFliSzh5elptdGtNRHNiU1BPL2pJalAwT0EzY3hXM1o0WDdVVzFQY1Ji?=
 =?utf-8?B?OHBGMEQ3T29uMEJvT0VNbXRTSGZQRGE5ajNtMml0SU5HeTU5OW1RcUZhUUNu?=
 =?utf-8?B?a244WUpUUkVQYndDTW51c3VTNWh2bFFKc0FqdHU5Mmh6S3E5amlXWlNBeHRZ?=
 =?utf-8?B?QTcvME1rKzJIUWo4Qmc0UE5sTmU2UUVwdDJoYjNZTFlCVVRqSjFvaktSV1p0?=
 =?utf-8?B?bG0rK1hMS1NoNnpUVVowMDVFSEhjU00rRE84N0hKQm1wTkhEbkhSVkZpVk13?=
 =?utf-8?B?SklPdXA3bFFiSjZYc0dZeGxBWGVmNFlxcGxqcjQzdnptTkFORWh2R09xYW94?=
 =?utf-8?B?dFo1VUpoZFpJRjQ2SUoxUEJVWG9HZGZOZ0loUWZ4cnN5SmxrbytHSGZpbHRo?=
 =?utf-8?B?WjJXUmRVeVNWalZQZHBUc1pueGlaSWp2ZlpkWnJFbVlrSmpLR2s4QlNhMExv?=
 =?utf-8?B?dm5wcUNOdDdGQTd3V2tiNk9TWUlMc1FWSnRvSFRkUnpra2krUE41RlRtYkRL?=
 =?utf-8?B?ZkVsaWg3bW9ScWJGNG5XaUE5Rjdub0EvMVZrWG9aSit0QjRXeWZJVWZhdDVw?=
 =?utf-8?B?ZmY2RklGdnprMkwzYlJuYkRjZ1VIeXJuM3NSc3dsck8xbCsxL1g3Y2ZRNVho?=
 =?utf-8?B?Rm1qWnN2QUw3NGxxc2hQVWpMUmJJQnVLdFI0M0hiYWoxdmRDQnBITmZTampS?=
 =?utf-8?B?QXBzWkhkckZrcW9NdThoZ1UxVVVQeTZOMzVmZ2V1TUFlRUFxTHladi9nOGJ0?=
 =?utf-8?B?M2Z0WGNFdkhBYnJXRzJsVEJKbGtWbjVmdWFZeTEwRGRhVlNHVUQyYzhHNXNw?=
 =?utf-8?B?bGhXWUJiYW9aNkFReTNpRW42YWNLbWdVTzF3MVMybzFuL2RmbmhQcHpOZlRy?=
 =?utf-8?B?M25odEtQZDFQamtDM2RrSVpDUnZWM3lLSXRMVEFjT0NpUld3cEJHWDFvR0pa?=
 =?utf-8?B?cXR5WmlBTVdIU25GNThKQlBlME9XbUZFRnAyWlpod2tCd0x2TkFDRWxqdU9R?=
 =?utf-8?B?b2Q4OThwbTlxUkNnWXpVNXZGVHJLSklnbXg2dUZUMDhVUnpYcW95MlZHT0Rj?=
 =?utf-8?B?SGMxK2tkL2xpdmhDVzdMbHNvcmtHdHArZDhGMm9SV0VNeE04ditreUFLYVpI?=
 =?utf-8?B?QnNsUm1BSnV0Y2l2czFwc0Z1K1U1clF4ZWJveUxrdHpRWFZUL3haVkZ6SmI0?=
 =?utf-8?B?K1U5RTc4UWY1eFVxcXNlUVpHYmFHQVFuQ0NpWEhqWlZHV1JtV2Fnc0FpdFFE?=
 =?utf-8?B?aTErdk9qU2xxTnNiVm5wTGxxdzAySWRVQkhzVlhqcVIySWYzNUZBa0JrcUl3?=
 =?utf-8?B?SkU0WjhET0YwbXJOS1JNMCtBQ3FIZGN0YW9BOFZuNHUrYVVta0RlcC8rNWR0?=
 =?utf-8?Q?a3qrpPH6Hj6QDRtQ4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c198622f-aba8-40f7-1450-08ded40c71dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 05:25:04.9535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu9t9jpqnCRRjbn1ZOTSbZ/YfutSR5NVWEhqkQBOn/dHi9+4gv+rMMobahlJ1H3OXjt2MYNY/ToYEQj7dfaATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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



On 6/24/26 06:00, Tvrtko Ursulin wrote:
> 
> On 24/06/2026 08:38, Timur Kristóf wrote:
>> Instead of storing pointers to affected rings in an array,
>> just iterate over all rings of the device and filter the
>> affected rings by type using the type mask.
>>
>> This is done to save memory used by the array of affected
>> rings which was sized AMDGPU_MAX_RINGS.
>>
>> Suggested-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 30 ++------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 53 ++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 +-
>>   3 files changed, 40 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/ 
>> amd/amdgpu/amdgpu_ip.c
>> index 65505bc50399a..99ed0b0d82e94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
>> @@ -481,28 +481,6 @@ static u32 amdgpu_ring_mask_from_ip(const enum 
>> amd_ip_block_type ip_type)
>>       }
>>   }
>> -/**
>> - * amdgpu_filter_rings() - Filter rings according to a mask.
>> - *
>> - * @adev: amdgpu_device pointer
>> - * @ring_type_mask: Mask of ring types you are looking for
>> - * @out_rings: Array of rings which is going to be filled
>> - * @out_num_rings: Number of rings which were filtered
>> - */
>> -static void amdgpu_filter_rings(struct amdgpu_device *adev, const u32 
>> ring_type_mask,
>> -                struct amdgpu_ring **out_rings, u32 *out_num_rings)
>> -{
>> -    u32 num_rings = 0;
>> -    int i;
>> -
>> -    for (i = 0; i < adev->num_rings; ++i) {
>> -        if (BIT(adev->rings[i]->funcs->type) & ring_type_mask)
>> -            out_rings[num_rings++] = adev->rings[i];
>> -    }
>> -
>> -    *out_num_rings = num_rings;
>> -}
>> -
>>   /**
>>    * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on 
>> an IP block.
>>    *
>> @@ -524,10 +502,9 @@ int amdgpu_device_ip_soft_reset(struct 
>> amdgpu_ring *guilty_ring,
>>                   struct amdgpu_fence *guilty_fence)
>>   {
>>       struct amdgpu_device *adev = guilty_ring->adev;
>> -    struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
>>       struct amdgpu_ip_block *ip_block;
>>       enum amd_ip_block_type ip_type;
>> -    u32 num_rings, ring_type_mask;
>> +    u32 ring_type_mask;
>>       int r;
>>       ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
>> @@ -543,14 +520,13 @@ int amdgpu_device_ip_soft_reset(struct 
>> amdgpu_ring *guilty_ring,
>>           ip_block->version->funcs->name);
>>       ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
>> -    amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
>>       amdgpu_device_lock_reset_domain(adev->reset_domain);
>> -    amdgpu_multi_ring_reset_helper_begin(rings, num_rings, 
>> guilty_ring, guilty_fence);
>> +    amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring, 
>> guilty_fence);
>>       r = ip_block->version->funcs->soft_reset(ip_block);
>> -    r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, 
>> guilty_ring, r);
>> +    r = amdgpu_multi_ring_reset_helper_end(ring_type_mask, 
>> guilty_ring, r);
>>       amdgpu_device_unlock_reset_domain(adev->reset_domain);
> 
> Patch looks correct to me so:
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied.

> 
> I do however have some lamentations:

Feel free to follow up with any other changes on top.

> 
> 1)
> ring_type_mask is derived directly from the guilty_ring so strictly 
> speaking is redundant as parameter to begin/end helpers.
> 
> 2)
> Lets consider this sequence:
> 
>    ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
>    ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
> 
> And expand it for say sdma:
> 
> ip_type = amdgpu_ip_from_ring(ring_type)
> {
>      switch (ring_type) {
>      case AMDGPU_RING_TYPE_SDMA:
>          return AMD_IP_BLOCK_TYPE_SDMA;
> 
> ring_mask_type = amdgpu_ring_mask_from_ip(ip_type)
> {
>      switch (ip_type) {
>      case AMD_IP_BLOCK_TYPE_SDMA:
>          return BIT(AMDGPU_RING_TYPE_SDMA);
> 
> Identity map kind of.
> 
> I am not sure it is worth it for the reset code on it's own, only if 
> there are other places in the driver which ask the same question, but in 
> general I am often tempted to just store those in the respective parent 
> data structures at init time.
> 
> In this case that would be something like:
> 
> ring->ip_type - holding AMD_IP_BLOCK_TYPE_SDMA
> 
> ip_block->ring_mask - holding a bitmask mask of rings implemented
> 
> Again probably not worth the effort in this instance. I only mention it 
> because there are similar things in the driver with much more often used 
> invariant lookups which then waste a lot of space. For example the one I 
> recently re-posted saves ~150KiB of .text:
> 
> https://lore.kernel.org/amd-gfx/20260622121034.52762-1- 
> tvrtko.ursulin@igalia.com/
> 
>>       if (r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_ring.c
>> index 8062135e73a1d..ab5df854c1d20 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -884,8 +884,7 @@ int amdgpu_ring_reset_helper_end(struct 
>> amdgpu_ring *ring,
>>   /**
>>    * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings 
>> for a reset.
>>    *
>> - * @rings: Pointer to an array of amdgpu rings that are affected.
>> - * @num_rings: Number of rings in the array.
>> + * @ring_type_mask: Bitmask of affected ring types
>>    * @guilty_ring: The ring which is guilty of causing a reset.
>>    * @guilty_fence: The fence which didn't signal on the guilty ring.
>>    *
>> @@ -904,7 +903,7 @@ int amdgpu_ring_reset_helper_end(struct 
>> amdgpu_ring *ring,
>>    * After the reset is complete, the caller should then call
>>    * amdgpu_multi_ring_reset_helper_end() to restore the rings.
>>    */
>> -void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, 
>> u32 num_rings,
>> +void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>>                         struct amdgpu_ring *guilty_ring,
>>                         struct amdgpu_fence *guilty_fence)
>>   {
>> @@ -915,8 +914,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct 
>> amdgpu_ring **rings, u32 num_ri
>>       int i;
>>       u32 t;
>> -    for (i = 0; i < num_rings; ++i) {
>> -        ring = rings[i];
>> +    for (i = 0; i < adev->num_rings; ++i) {
>> +        ring = adev->rings[i];
>> +
>> +        if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +            continue;
> 
> Another thing to consider is if adding a succint helper for the ring 
> walks would be interesting. Ie.
> 
>   amdgpu_for_each_ring(adev, ring, mask)
> 
> Regards,
> 
> Tvrtko
> 
>>           /* Don't accept new submissions on the ring. */
>>           if (amdgpu_ring_sched_ready(ring) && ! 
>> drm_sched_is_stopped(&ring->sched))
>> @@ -949,8 +951,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct 
>> amdgpu_ring **rings, u32 num_ri
>>           rings_busy = false;
>>           /* Check if any of the non-guilty rings are busy */
>> -        for (i = 0; i < num_rings; ++i) {
>> -            ring = rings[i];
>> +        for (i = 0; i < adev->num_rings; ++i) {
>> +            ring = adev->rings[i];
>> +
>> +            if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +                continue;
>>               if (ring == guilty_ring)
>>                   continue;
>> @@ -966,8 +971,11 @@ void amdgpu_multi_ring_reset_helper_begin(struct 
>> amdgpu_ring **rings, u32 num_ri
>>           mdelay(10);
>>       }
>> -    for (i = 0; i < num_rings; ++i) {
>> -        ring = rings[i];
>> +    for (i = 0; i < adev->num_rings; ++i) {
>> +        ring = adev->rings[i];
>> +
>> +        if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +            continue;
>>           /*
>>            * Find guilty fences, ie. the fences that didn't signal
>> @@ -991,8 +999,7 @@ void amdgpu_multi_ring_reset_helper_begin(struct 
>> amdgpu_ring **rings, u32 num_ri
>>   /**
>>    * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for 
>> a reset.
>>    *
>> - * @rings: Pointer to an array of amdgpu rings that are affected.
>> - * @num_rings: Number of rings in the array.
>> + * @ring_type_mask: Bitmask of affected ring types
>>    * @guilty_ring: The ring which is guilty of causing a reset.
>>    * @ret: Return code from the reset function.
>>    *
>> @@ -1004,7 +1011,7 @@ void amdgpu_multi_ring_reset_helper_begin(struct 
>> amdgpu_ring **rings, u32 num_ri
>>    * be called to restore some state, but it won't attempt to
>>    * fully restore the ring contents.
>>    */
>> -int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, 
>> u32 num_rings,
>> +int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
>>                          struct amdgpu_ring *guilty_ring, int ret)
>>   {
>>       struct amdgpu_device *adev = guilty_ring->adev;
>> @@ -1012,8 +1019,11 @@ int amdgpu_multi_ring_reset_helper_end(struct 
>> amdgpu_ring **rings, u32 num_rings
>>       int i, r;
>>       /* Set preempt condition, rings are now allowed to execute 
>> submissions */
>> -    for (i = 0; i < num_rings; ++i) {
>> -        ring = rings[i];
>> +    for (i = 0; i < adev->num_rings; ++i) {
>> +        ring = adev->rings[i];
>> +
>> +        if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +            continue;
>>           if (ring->funcs->init_cond_exec)
>>               amdgpu_ring_set_preempt_cond_exec(ring, true);
>> @@ -1027,9 +1037,13 @@ int amdgpu_multi_ring_reset_helper_end(struct 
>> amdgpu_ring **rings, u32 num_rings
>>           return ret;
>>       /* Restore contents of all rings */
>> -    for (i = 0; i < num_rings; ++i) {
>> -        ring = rings[i];
>> +    for (i = 0; i < adev->num_rings; ++i) {
>> +        ring = adev->rings[i];
>> +
>> +        if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +            continue;
>> +        /* Restore contents of the ring */
>>           r = amdgpu_ring_reset_helper_end(ring, ring->guilty_fence);
>>           if (r) {
>>               dev_err(adev->dev,
>> @@ -1040,8 +1054,11 @@ int amdgpu_multi_ring_reset_helper_end(struct 
>> amdgpu_ring **rings, u32 num_rings
>>       }
>>       /* Accept submissions on all rings again */
>> -    for (i = 0; i < num_rings; ++i) {
>> -        ring = rings[i];
>> +    for (i = 0; i < adev->num_rings; ++i) {
>> +        ring = adev->rings[i];
>> +
>> +        if (!(BIT(ring->funcs->type) & ring_type_mask))
>> +            continue;
>>           if (!amdgpu_ring_sched_ready(ring))
>>               continue;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_ring.h
>> index c272e0b028ad8..9d3934b4f1069 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -595,10 +595,10 @@ void amdgpu_ring_reset_helper_begin(struct 
>> amdgpu_ring *ring,
>>                       struct amdgpu_fence *guilty_fence);
>>   int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>>                    struct amdgpu_fence *guilty_fence);
>> -void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_ring **rings, 
>> u32 num_rings,
>> +void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>>                         struct amdgpu_ring *guilty_ring,
>>                         struct amdgpu_fence *guilty_fence);
>> -int amdgpu_multi_ring_reset_helper_end(struct amdgpu_ring **rings, 
>> u32 num_rings,
>> +int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
>>                          struct amdgpu_ring *guilty_ring, int ret);
>>   bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
>>                        u32 reset_type);
> 

