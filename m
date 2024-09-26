Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C580FCCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 10:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6994410EB97;
	Thu, 26 Sep 2024 10:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FMnf+A75";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801D310EB99
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 10:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfZ6vFiTHN7MTY03wHImycw5jRoPtD6Urtop6i8A/Z4epRveW9JJzriP1591MK9PAYalNbt6E33snfc3w0bgOG2CIWtV02T+lzuHkfPMiorWEKZqIjaePuy2CyBvj88XjkV5g/l3cqx+m4nznZFuWZhlYanm3THK6pA8wRo4DH6O/G161T/pl/NLxYROIXUM6CutSpYXIxw/4fBuHH25WJ/jwuqjSLnF81Ky/N5CBjFpuUtKIfENRk9HsWqNy4qfzGfyRa1ATcUUCRiX0LAiFMySWKIieNL6o82iDfHxO5Rs80IhSBRzlmpzR3Uy7B+LBi70b8XDfUBzee5xDCQPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBWn+U4PeHFjrjUd9JyuBujNjqbyzSBPyjeDQ5C1Vhs=;
 b=p9fzI4RX6rseQJSqdKlxAckbGvHkjWPeRVsRDH8CulQapaYruxC17Obdj1sCYoRm8l1xIi7uBxIy7vEVveahKlLCmOr6SMLU/vHlNfPf46VWvTAudBd2bAHZYNno3NbiMEF1t6TgUw/Np1eOywDpIdsmnI1/SfHZTPoEB/0XjWHf7lf4OR4LTkOpFHr+OXMwbPS/y5UjT35QmG8L2zrabrBkwmCJdXxqiKDtgRPkZX433dtyuRemmWspiAoSwHUpLOXRxQnSPkYcK16Piw5zyhTHT2RvkgPSs4xCrPKsCduRt71gdmVvA3qF8acoF/1CU2V7ZWaBRPPezwG7mcTVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBWn+U4PeHFjrjUd9JyuBujNjqbyzSBPyjeDQ5C1Vhs=;
 b=FMnf+A75ZpJJb0p4AOq1uwRrQzxTIZlWzYg53oQV2RD1Abe70zPnzSUv0YoaifSupwLcKkMptIuAY0ace0yzDsUOvda5/sQZCzMEuid7pN3CFDACWQgPk5q3AJpfOqItKqyuFgn7N8CJbocM74OlfJfnlvWBrEYJQwHRAW28csY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 10:11:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:11:28 +0000
Message-ID: <252b3c4e-ae45-45f2-a0f3-2f82901d60bd@amd.com>
Date: Thu, 26 Sep 2024 15:41:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] drm/amd/pm: stop extra checks for runtime pm state
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
 <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
 <96b08208-0bb2-4f6d-967b-dd9594994250@damsy.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <96b08208-0bb2-4f6d-967b-dd9594994250@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e08bc1-5e09-45fb-f853-08dcde1395c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXVGRGdnVGM3R0prRlpldHF0RFpXYlVnSVJyRVBzd2JYQ1NwblNmOFRCSjdp?=
 =?utf-8?B?d1B3MytCN3ZKcENiYURzc3VsQy9FcHhLd0M3NmRhYUJxaTRCSlcxWmVaUU9N?=
 =?utf-8?B?bzVGNnRTd2dDWVpGOXJUL2ZCOXRWamdEMEVEMjNWTWd6Rkp0MzE2c2V2ajNl?=
 =?utf-8?B?TUVUeFQzaElEWnhpNVhiS09WK1hzZmpJSzJmV1B3dmRnSFJQTlJMVHNQZW9J?=
 =?utf-8?B?UHM2K0VYQ0FYNmlNdlZNNGNhWE5oMjFKVVYvcC9yRDBhZ3oraU9zYXBEaG1n?=
 =?utf-8?B?R2NqUGVYZFdaN3hoVUFaUUQvdTFmUmxtcUNOM3V2YWR6cy8vZ3dOdVhiOWpJ?=
 =?utf-8?B?VHd4NGx6d3M3UllxbDh3dUdmR3NVM2tPSGpwWUJtVTc1UklOVFNYOXN4eUt5?=
 =?utf-8?B?Znh3aVZORTE0K0R5THprOXpvcVYydWsvTFljRXJXMUdqVUV3ZS9lUDg5WGRO?=
 =?utf-8?B?dVk3aDdKaWViMXBwTk0rd2dSNE5xL0dXVS95dk94b0dUKyt0RTdFbmZiUVhI?=
 =?utf-8?B?ZFFsSTB5QWVLbHl0WjFsdTlTNUhSUG53bWJMek96eGZuempVcFNEM05sbVlH?=
 =?utf-8?B?MHBvUStMNkRiUjVTSE80L2RqdlVibmhKZkdRbDUvK2UyOGlVcHdYNnJMVlpM?=
 =?utf-8?B?NG9oRWs5WlF4WjVTY3VrdHBlTDhpcDZXbmRrdkVmbTh2akR1UmQzMXZ2WlZ6?=
 =?utf-8?B?UjlVUVZKd1dSQXNWdTcvSHpMOS9wY0s1UStnK1hidzUzVGl2V2IvemdnVks5?=
 =?utf-8?B?UTdHMWVBRldaeHhOOGxmUWRTUG44QU00OVV4ZVB4eThDKzhQUGYrQXBsRTdu?=
 =?utf-8?B?Q2ZmWlNBbGlSdXB5blpveVh6OWVsM09lN3ZFOTZXY1NvZXFSQnlUcGV4Z1Y3?=
 =?utf-8?B?bWFTTkVHODBkL3dpYmJPZ0xYM1dIOXdTRm1VWHZwQm1SNjYxWUhEcW11NnFk?=
 =?utf-8?B?Ym56RnhUNEdrMFJjMFlMZm9HK0gyN1hZVkJyN3luaDcyZzNjTlczTncvOHRu?=
 =?utf-8?B?dnBhL0ZvTGlwbVJwbk11SlZHWHB4Z2R5aEF1WmVaNThwWGwwS3lRNVZzV2F1?=
 =?utf-8?B?SWhjcExFMkE4cGNjbVU5QnhaVXk0ZVc5SFM1bUNCRVc2dTB1QkpYcjc1VDRx?=
 =?utf-8?B?Q0Q4YmhiMWU2cGI1QW80ZVd1OFhpRXEvSWlHMTltUXJ2SW1TcW0xNm81dzZo?=
 =?utf-8?B?dUxEZkdYQUcydk5JVytRRHlQYmxSb2RSQ04wYUtaUzRZUUdpKzFwdmp4bzZz?=
 =?utf-8?B?SjZsaVpUSDZqbXF3NmxicDRXTUpVcURYRGlPYUtFMmdkQnlJSm8zSENicjlK?=
 =?utf-8?B?Smw1WG5mZUVWeUN2WGtlRE9UU050ckc5T0lzeWZTWjMyMHNWVFRUODRUc2FY?=
 =?utf-8?B?NWJ3Mk10czZQWnVCZlp5UEF0dm9JVEpEamJ3RXpLQzJBdHpJMDk3VE9QY2Mr?=
 =?utf-8?B?SGlOdXVvSmxSU0o4L3IyVnphTnBkcnE2TWdiNmpoTTdwc0pZWG9qYm1TYzNm?=
 =?utf-8?B?eEV2TUxTdm9uZENkTFU5d1ZYRm9OUGJkZHExU3B3VkZ6Y2x1S0E1QkZSY3I4?=
 =?utf-8?B?ZFBmV2ViaEtlWHZHUnRLeXJjdjRGaFRyVFBvWEcvbkdTZjgwVVJkYkFMVWxF?=
 =?utf-8?B?WVovdmdqUWIyQWVSNi9Hd21TVFl1M1VDYjNyZFh2eXVKVjhSRVZJblNGdzZF?=
 =?utf-8?B?MWUzbnp6R3diL1UyUUdzRzNXMWpUWnhBMTdlWDRTdlQ5bzVHT0s2eVEwNXNl?=
 =?utf-8?B?dkhDVXFLOUlyWUN3SnoxM1pyUzV0S2NPUng2QWo0NUhUS2lWZ3gzY3QzRGhs?=
 =?utf-8?B?Zm9TdW9zT1F1VlExMHhiUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEx3cUZJYUN1S1pVUEVYdzI5VWlmeU5UTmFRb0JSaWpUS04yOEFFWDlQV1pL?=
 =?utf-8?B?MzFLSmNnK1pRZVVCOXRIZUR6K1gwY2FDNkVuN3FKTFJQdGhhVHpGMGFaaGht?=
 =?utf-8?B?UGptZGV4SXkyVithbU54U2ZGaFlMdWdER0NnMWZTZmtJemo3REdxZkMrd1Bn?=
 =?utf-8?B?SkZLWU1RM0lmQkZvSjJJTnhTdURhY1VWNHVoRUdLWWxpaEttekZ0ek1vNzAy?=
 =?utf-8?B?cisrUnBwcC9PcUJoc0hPckptdEYwVHAwTUROVUdNdWs5bjEyUTRrTGN2TGdp?=
 =?utf-8?B?ZU1Fd1ViZXZPeVRCMi9JMkxtcDd3UFEvdXVQQ3NqQUV3OFFGNi85aUZ2Z0hr?=
 =?utf-8?B?MVBKcFhFendCd01EZFUxMW5BV0QzT3l4dGdaNGRBSFBDSGlQNFluMllpL21X?=
 =?utf-8?B?aklhQWYrbUdxT2l2aE9GeEVzSU5KK2U5Zll2VUNjbnhXcTdKZVpaM3Q5eGNq?=
 =?utf-8?B?UWdicElyb3BBd3hvRjhIZnlBVUhYanhaSm5mYTcyeWVqN3hhOS9RdFJma3Zo?=
 =?utf-8?B?dk9Hbjd1UFp3d2hab0RicDZIMXVZWmNNV3lpQkJDWDkrMGJaVmU4d2taS1Vk?=
 =?utf-8?B?b01QTDBUWXVLYnl4SHd4S0s3ZzRVaWdicWVDLyt1QTJEZTBFeDN1bTZtcW1N?=
 =?utf-8?B?STFiMGlhNXJwWm1hRVlJb1Z5NHYwdU40SnFOdVVzSUdPYkxaMXpCSmNWZXpM?=
 =?utf-8?B?bC83cXZHTGpST2g1Zld1cHFScUQwMzlhZk5kcE1GM3VGMS9iVGpVUVF3VGdF?=
 =?utf-8?B?VWhtT1dKOS9Yb0VZWEVHSTlpR0ZkZVpZWGV3MnBSalVaWlcwU2pjZ2pYRUtT?=
 =?utf-8?B?OUJBZEtaNnl3bDUyeCtSMGtpbXlhbzE0NVJMU0E3OEJPUjdMS1hPNEVhQTFr?=
 =?utf-8?B?amlPdVJ4K1FFYjBLRk4vMEtlRFFCRWxTTDdKNEV2M2ViR253bW1KdU5oTXEr?=
 =?utf-8?B?RlVqTnBONHNmUjdTbUI1Tk1RazFuc1NlUGdoek1laGJMbW9KUVZ5WTdlOXdZ?=
 =?utf-8?B?TllnRk5WbEs3VVhCWC9NbUNiYmVZZ1U2UTkwR3l5T0NrcXdpRWYyMWdqd2xB?=
 =?utf-8?B?WHg0eW9IYnd1Mnl1UlJXMUs5aGQ1L1ovQ3dsOEZTRUZ3YWtDd25IeldOd0VU?=
 =?utf-8?B?WGNPUmVvUWZDY2ZVanJqdERPZVdnRHA3RWt1RzN5RFBpcWY0Q25FcCtER3A5?=
 =?utf-8?B?L1hlSDVLYmNLenhzUnFsZW5VYjJDYWxJVWxncmlMTEptb29ZZTdQd1d5Qk5C?=
 =?utf-8?B?QTdQeG1wS3QvUnlUaEFLbk4zMk1ieUdndjRWcHBFVUh1VmZmSUxSN1NzWHIx?=
 =?utf-8?B?NWVGTUJrYVJGSGNWWGF0YmJNYWR0VXV3TWRwcVlPaEJMY1ptSENTRis5NURu?=
 =?utf-8?B?aCt3ZDNpbEp1NzlhUjlVaUdtUUdaVC8rU0xSSkdkb0h2enEvMnJEWnQ1YVJh?=
 =?utf-8?B?ZUxhWlk4Y1JWUHA5RjlxSHl5d1RnTzV4dWU5VlBPRFJPQlExaVNJUTdtNU9E?=
 =?utf-8?B?Uk1zVmJOWVQwRVJ4MWVSdko1Q3pNazVjdmhQblczbnJZdEF5Y2lyL0RrSVFl?=
 =?utf-8?B?T2VOUSsxTjlEQ053ZFg5OEJXVkJva2hoSjNkZGlIVTRhZE5PSG1QUnMwTm5P?=
 =?utf-8?B?VjJ1anIvSy9xM2FGdlYySXVlYlpLc0hubzN0Zk9NTlA0TFl0ZGdqWlppVzE0?=
 =?utf-8?B?TUZjRE9uNFgyaGVGc2dpbitYMzlZRlhSdGxUMm9IWWdRaFdNMjkwbzhHaFhq?=
 =?utf-8?B?clhWZnlaOGtwWXFrL2pGbUU2R0R5QWxXZThhc2ZlZ0xkRGNzS29hK3JRejFD?=
 =?utf-8?B?RDdhRysrSDBlMGpLVlhzV2J3czdQdmM5MXdDQ1VRWUpYY0lhNnhpbVdzaXd5?=
 =?utf-8?B?YTQ3cXpoaWJQbDUyUVVteWVVRG4rNDVvdWxqUFluNVFQS1dNNzZCTWhRdTU1?=
 =?utf-8?B?UWd3S1RZbCtDTDFlSURRVHJuaE1UNmRqWDZwYkRWdGxtQ3FzOVFYTzZoaDZo?=
 =?utf-8?B?Rk5ML1JoSVN6RzhYZmwxQTE1UVpiaXhzSzRQMmgwL0VCQjQwZGUrWndpc04w?=
 =?utf-8?B?bkJ0R2pXdEhiNGU4azFEZWJZS2I2Q2dmUGJyaU8ycW9JQ2xNYmlaWDhuNk41?=
 =?utf-8?Q?bI2nITJhCwyReBvUbJ4DrGjeo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e08bc1-5e09-45fb-f853-08dcde1395c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:11:28.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8jvzWyoxi+73Zd26mhDuj7vTR2b8cs3iuqfGj5ABcb5N+/Qpx2osBIGZXCuMfkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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



On 9/25/2024 7:59 PM, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 25/09/2024 à 15:37, Lazar, Lijo a écrit :
>>
>>
>> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>>> pm_runtime_get_if_in_use already checks if the GPU is active,
>>> so there's no need for manually checking runtimepm status:
>>>
>>>     if (adev->in_suspend && !adev->in_runpm)
>>>        return -EPERM;
>>>
>>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ------------------------------
>>>   1 file changed, 46 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index f1f339b75380..13be5e017a01 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -142,8 +142,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>   
>>
>> I believe this check is for accesses before the device is fully resumed
>> from a suspend sequence. That is not tied to runtime PM.
> 
> AFAICT in_suspend / in_runpm are only set from resume / suspend
> sequences, so checking runtime_status != RPM_ACTIVE like
> pm_runtime_get_if_in_use does should provide the same result.
> 
> (= during resume the device status is RPM_RESUMING)
> 
> Pierre-Eric
> 

On devices whose runtime PM is forbidden, I'm not sure if it goes
through RPM_ state changes or just statically remains at RPM_ACTIVE.

Regardless, these checks are removed only for sys/debug fs attributes.
Hence as Alex mentioned this access check was not required in the first
place.

Thanks,
Lijo
> 
>>
>> Thanks,
>> Lijo
>>
>>>       ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -265,8 +263,6 @@ static ssize_t
>>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -361,8 +357,6 @@ static ssize_t amdgpu_get_pp_num_states(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -396,8 +390,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -523,8 +515,6 @@ static ssize_t amdgpu_get_pp_table(struct device
>>> *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -837,8 +827,6 @@ static ssize_t
>>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -927,8 +915,6 @@ static ssize_t amdgpu_get_pp_features(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -993,8 +979,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -1242,8 +1226,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -1299,8 +1281,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -1376,8 +1356,6 @@ static ssize_t
>>> amdgpu_get_pp_power_profile_mode(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -1464,8 +1442,6 @@ static int
>>> amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         r = pm_runtime_get_if_active(adev->dev, true);
>>>       if (r <= 0)
>>> @@ -1574,8 +1550,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device
>>> *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         if (adev->flags & AMD_IS_APU)
>>>           return -ENODATA;
>>> @@ -1784,8 +1758,6 @@ static ssize_t amdgpu_get_pm_metrics(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -1822,8 +1794,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(ddev->dev, true);
>>>       if (ret <= 0)
>>> @@ -2697,8 +2667,6 @@ static ssize_t
>>> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(adev->dev, true);
>>>       if (ret <= 0)
>>> @@ -2825,8 +2793,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct
>>> device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         err = pm_runtime_get_if_active(adev->dev, true);
>>>       if (err <= 0)
>>> @@ -2852,8 +2818,6 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_input(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         err = pm_runtime_get_if_active(adev->dev, true);
>>>       if (err <= 0)
>>> @@ -2913,8 +2877,6 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_target(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         err = pm_runtime_get_if_active(adev->dev, true);
>>>       if (err <= 0)
>>> @@ -2983,8 +2945,6 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(adev->dev, true);
>>>       if (ret <= 0)
>>> @@ -3149,8 +3109,6 @@ static ssize_t
>>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         r = pm_runtime_get_if_active(adev->dev, true);
>>>       if (r <= 0)
>>> @@ -3682,8 +3640,6 @@ static int amdgpu_retrieve_od_settings(struct
>>> amdgpu_device *adev,
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         ret = pm_runtime_get_if_active(adev->dev, true);
>>>       if (ret <= 0)
>>> @@ -4649,8 +4605,6 @@ static int amdgpu_debugfs_pm_info_show(struct
>>> seq_file *m, void *unused)
>>>         if (amdgpu_in_reset(adev))
>>>           return -EPERM;
>>> -    if (adev->in_suspend && !adev->in_runpm)
>>> -        return -EPERM;
>>>         r = pm_runtime_resume_and_get(dev->dev);
>>>       if (r < 0)
