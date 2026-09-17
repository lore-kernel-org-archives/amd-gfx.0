Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46698C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 12:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF5610EEAA;
	Thu, 17 Sep 2026 12:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJ3l+xft";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1167610EEAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 12:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V51V0lz3NIdW3O64g25L8KhaRHfmvuxBu/j3tJk0PYA1Putk5hOAQgValJJtttMPcf6M5G1Hyc3nI4x8BYJymnkj8nr8VJFP3c/Zhz94MibWPBQnFR6JFdnMUJ4y88D6AeRHS4dhUt//c52iku29aOSOIEfxdkz6AlToUJkTmlM2G7OkgSMhWRzE2H6INhtjgGFcsj6PZjROhVIntII/o3mOcagaUpk0clrU4zQfMY9aiL7V4sFRvAhySlnISRIfn6jHqD4GQeLFa0cSzU7E2XChTCseklpBBzrDO8YZIqXJZ9nVr1zI1TUXX7l6Fhwf/ZfgPMA5OOC3wGYAOQpDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN7SP6BdvvvIoEhGAVR5fSWkSJWijwKLS2yaxgqulcc=;
 b=YAUSYwrY16fwWYHYhs320PLOGnWg39F/BvBrHcAuKjqU/5Iw1ajV8u62ngY1kD2HuyB5H7CF5QADY3dZ0JvpotyyKbXx05+h15PSLq2DV9NaXsu95G5xIaZtddRlz/qCAFVixNxzkg/nnB2TJS+ibdTlVmkFXDkeZ4ifFyf54o/GHd53Rkpgh0JCF0Iip82oeSI9xxn6lG/wra3rhxkODd/H1Kibsw3qlnrAOoNfjKBqQ70JSU7nxYWBPisHNzdwdSeyIiMgkzzSrKUhi/CZV/TER9dPKC3W+7cb/97UsZGwuZXlyNWYFiGCr674lajmB9iV/bGW6yNYd6xFs+bc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN7SP6BdvvvIoEhGAVR5fSWkSJWijwKLS2yaxgqulcc=;
 b=kJ3l+xftxOjMmsHo3Wcfc98An4Fji7PjJIXwvzTmfEnu+JZP2lldWflxv9w/JYw5yVaPIwiWnq8tsEZCbsBbXd1wzlTce8v6pvgOgpY+Ms/+mQA0bSWOYFoD2PZIweaXe+Ujbs12+dnmj55LeBqqrLCdhPB6lF/9qPlOvEhJavI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 12:40:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 12:40:20 +0000
Message-ID: <0fe02414-9951-4a39-a631-0a190ffa88f6@amd.com>
Date: Thu, 17 Sep 2026 14:40:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use iosys_map for trap TMA BO mappings
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260917090530.666757-1-srinivasan.shanmugam@amd.com>
 <d54c9aa9-6414-4984-8816-84db74de309f@amd.com>
 <2f3df784-35a3-4108-8d1d-cbded59ef727@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2f3df784-35a3-4108-8d1d-cbded59ef727@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: cf450f08-65f5-4644-1053-08df14b8d5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: pxnJsYg5v5XKbTI9Gw5BHujAe8ZlmZGbI+9gjfZ/h9K0GZUMf6ZZLZYdaYRzH8/3+hPxOfgDtVxGIQ78mBRS4tDlJqmzg44SOEctIuzP1yf296hefOM95INXReoFfqBBMYELjEb6pdJ4asbrOdaiVpyc4Lmq0V03O8JUcVt1trrw5SVLzgLQ8Bv19+ReHDcrP4BTZDwJFfcPDdldQo6SzTx+j+YHASZhZAW7XHPBaI4nxNM/ITZIfcbKfbwwdLbdE4fXdRLByiQKxObg5yfbKWcT31Y7/hCCTfv/p/wrdCAPVutHka8tWRzJuNaITAM9/3W9+io9HSx/3ZnLiFzf0KHk1MHQ/3tFywxvcXaH25Nq7S/Rzz5WUL1AA8U52k79+aOVH/MsdW0c8J0TF9R/Q6MShEVMtTy4jUal9feCLZc7GFuPey6eKlqzjt6mEHYxcxed7gX/cP7zL/jSmX/jD6soi/EQXAnAqBl9OA1ZvhSknfjFhVNE6ryU+KyEi+IntbL6BaTpLiAmS08D3hKAwTysBbTCJ2iNrgGlqzSDS1udS1qsN06BGJgvkip+/oR5W7GV0z3Oypuxr0CPZUfvV0876XilVPZfNqiyhIGSJwONYCRzltuZwpxxJxX4ebxP/3BIAy/cW2iMoz+Skx2aTGS4wglVdOZIElNscnsWVvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ErUWtqUGo1RlhiRHdpaVEvZ1BJYkVLQi9VaHVac2E1Y1Vyb2xWd2E2cTdL?=
 =?utf-8?B?eEUvNVBNRUdPKzEwbkNGdWo0NWdBRTNvd3kzNnlsaUh4UkpFME93VnYvUzlM?=
 =?utf-8?B?RlgwYnhobmlIVmNsb25kMDlJOC8zbUZsa2gzUm5qbTgzTzhEQjd0eWRnYldq?=
 =?utf-8?B?Z0pSSlg1YzZFRjlmcmhHbkJ1RUIzeW8xN0MvS3pNRHgwMVBlUm1aZEpZRkl0?=
 =?utf-8?B?c1JQMEdLZzlxU3A3bkVsT3pyd2tFamhuVk5rZVlCM3h6c29MaktyZENQY1Uz?=
 =?utf-8?B?WjhKUzFBbTBOMUhUTWkwTnNFZ240T21ZYitCaWpQU0NMTWNCQmpQN3g5c29a?=
 =?utf-8?B?cHF0anM5TTlORTBQZC83ZnZwMU1qOWw4cEJuUExpMm80RTlyeUJQRHZzcGRi?=
 =?utf-8?B?ZXRkOHE5TnFsY3VQSHA0cnVYZ0N5ZzZsalRTLzRLUS94V3lMYmJHTDdNRXc3?=
 =?utf-8?B?WXJoK2dzbG40N1NIeXZCOUppMWpjUjQ3NUk2QmNFbzZyL294QmpsamlpYklI?=
 =?utf-8?B?WXBFWENzNzFWZWxmSExQbXN6L3pRa1FHVmxEMkw3SXo1NmNPTXRIS1lwSkFD?=
 =?utf-8?B?blJ6VnJ5MnZnY1F0RDVYcE5zOXZFSGZ4QklqV2xCZk5wRDB0ekk1eWpTZlQx?=
 =?utf-8?B?VThpcDROb3I5L3BtNnd5b0ZBYmtzM05WY1BNM09OenhGVkYzcStJNVJoWkx2?=
 =?utf-8?B?WER3L0MvbTJkaDhLTVgzWTN6L2V3YlJReUJac2VQSEZzOWhQbkgwV0FVS3JC?=
 =?utf-8?B?anVtc0EvSW1aZ04xcUIzb0NxcUltdHoxSlpHeTUvdytkaGZkK1pNK0xld3JS?=
 =?utf-8?B?a3A2cU1BeGhiU3JZUy9TN0Nic2xIQ0JHeDRCVDBhbXlVZzY4SmNLTXMzWWVB?=
 =?utf-8?B?WWk5SEw4ZTBsRGk2UVBURzlpY3ZVa2RIUEZMMXlXeEVWVXYyc09iWWV1MjVO?=
 =?utf-8?B?SU04QmJIK3Q2WU00bGZJM01BbTN1SFJWVUZMOGY5TWpwd3Q4NE5waTVTNW9m?=
 =?utf-8?B?bERCZkpZV2M4cFQ3dURzZ24rMXV6ZVFYQ3Rwb1FKNWhINmI5TklKTUxzZElu?=
 =?utf-8?B?Z0RIS1UxbEpuQzEvc2VvekpKSXJKOXhzVG00OTRweUNqSG5OVGh5U1p1ZWVV?=
 =?utf-8?B?ZnQyOEx4aEdNN1Qya0J3Y3J3NXRzTnZHR2lwcHFJeDdsWUE0SUR2Z2hDK0xR?=
 =?utf-8?B?UFU0WjlyUFJiTDFXaEo3ZG4xeER3QnVHUm01M0JJL3h3NXNlWGhGTG9rdWhm?=
 =?utf-8?B?S3ZTYlVTamtzaXFoMDF4K1VEWHFCSmlheFpNZEdpWXJ0WnBSbHNCMHhxcUlP?=
 =?utf-8?B?OHp5UDlMOXp5ZTBBQ2R3NmVPNUV6c3JiWm9hcjdvS1VDeWlwV1JPUzJGc25L?=
 =?utf-8?B?U1VJaXlOQk8wM01BVTJteUJ1TVJwT0U5ekZHZnJKbEJmTWl5RmFHVUNWdWJG?=
 =?utf-8?B?WDRPcUYxamh5aG8xbkM3TW5PemcvY2ZwakZ6aS9EM2djU2JaVHVOaXVMNmZ5?=
 =?utf-8?B?VFBGdVNtcmhmbXhXc3kxWEc5NnpKV25QVmJHVWRSMjFUc2Z1Rnd0dlk3N1A2?=
 =?utf-8?B?YlpIVm9YaUJSZ0V1RXFaNW1PTTRoSy84NHA3eDhEU0hsV25nYUNjRW8wdGly?=
 =?utf-8?B?KzFwc1ZCUGppN3liMUZHSXZIYmI2Wlp1WlNKQytTR0NPd3RWQXAxM2FpK2cx?=
 =?utf-8?B?azNtYkw2WXYzY3JqUU9EVXlhSVhWN0xoQzNFdDBPQ3h1aVhMQ1h6MXZnaVdr?=
 =?utf-8?B?RzI4LyszS3JsZW5JSEI4ZDh6RFIvNk5LbWlHc2J0NERyeHJBNG9vcHQya2t0?=
 =?utf-8?B?SG5aem56dlJ5eUtrbitzUnBYR2hmTGEyYUp2YVplalc2L1JCbVhRLysxUWln?=
 =?utf-8?B?cU83a0xTa0JRYnNVMlZXNEtDKzJlckp0NFQyV1g1QlAwRmk2WTVrZWJENzM0?=
 =?utf-8?B?dEtNTS9yZTlRZ0ZwZXc2QTZ5NXFDcXV0elFNVmlibEZKaWt1Y3NHZGduTVVM?=
 =?utf-8?B?eFR0NGpiSWQxcXppMHl5djBGMGF4NkNvRnFieS9lWHlXL0RkVGYrSWlYNUlj?=
 =?utf-8?B?enFheWxLU0s4eG9xZFI5dzd2MHNnSTVzenJWOHVia2hQQ01RWjUrbGRxVnh4?=
 =?utf-8?B?cVhkNjJDZXY1bElqWTdZLzhuQVJ4RWVTVVN0QWxMaVR0RUwrdHZpNExpNnd2?=
 =?utf-8?B?SmxMQUlaRGtUSXBTSVdTcHptcG11M21GSnc1eDJIQ2VTTUsvdzZWaDFDRlBq?=
 =?utf-8?B?d1NEQU82Nk1BUmFWSDF1eFpxaU5tK3QyNS92Yng2QnZhSGJDamxpL3NDRHZC?=
 =?utf-8?Q?tIZ1gg9p2/JgELp/g2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf450f08-65f5-4644-1053-08df14b8d5dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:40:20.6731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPeNBgO77WvWywtONKiQpvbvsCn/rto/eEa5jIAT+dmD270SpUVFeWItQTDLlhsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172
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

On 9/17/26 14:12, SRINIVASAN SHANMUGAM wrote:
> 
> On 9/17/2026 5:13 PM, Christian König wrote:
>> On 9/17/26 11:05, Srinivasan Shanmugam wrote:
>>> Replace amdgpu_bo_kmap()/amdgpu_bo_kunmap() in the trap handler code
>>> with ttm_bo_vmap()/ttm_bo_vunmap().
>>>
>>> Store the mapping as struct iosys_map and use iosys_map helpers for
>>> memory access. This aligns the trap code with the modern DRM/TTM mapping
>>> interfaces.
>>>
>>> Using iosys_map allows the code to use common DRM mapping helpers
>>> instead of directly accessing memory through raw CPU pointers.
>> I'm really wondering if we shouldn't rework amdgpu_bo_kmap() into amdgpu_bo_vmap() and use that everywhere?
> 
> Hi Christian,
> 
> Thanks, that's a very good point.
> 
> Introducing amdgpu_bo_vmap()/amdgpu_bo_vunmap() and gradually
> converting existing amdgpu_bo_kmap() users sounds like a useful
> cleanup for AMDGPU in general.
> 
> I did a quick grep and found amdgpu_bo_kmap() users in a number
> of AMDGPU/KFD files, so this seems broader than the trap-specific
> conversion.

That's what I meant with a backward compatible interface. E.g. just return the kernel pointer the same way kmap does, it isn't 100% clean but still better than what we do today.

> 
> Would it make sense to keep this trap change focused on the
> original conversion and handle the wider AMDGPU migration as a
> separate follow-up cleanup activity?

I leave that up to you, if you feel that this is to much work feel free to add my rb to the existing patch. That one looks good enough that we can land it.

Regards,
Christian.

> 
> I'd be happy to look into that separately as well.
> 
> Regards,
> Srini
> 
>>
>> We can of course start with backward compatible return the kernel poiunter and then switch other users of amdgpu_bo_kmap() over to iosys_map one by one.
>>
>> Regards,
>> Christian.

