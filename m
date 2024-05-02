Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD7C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 18:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E44710E5E3;
	Thu,  2 May 2024 18:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1B0nwGBm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E9B10E5E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 18:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0W/GmeYhWAyaU/Lw/DH4kfWH590RWPxfRSkUkOYnD1F+t2tb4ajaXTfBJpkPvlk8++DGsbZFRjTm0uDH2iYeWuHpiyImDlo7xqdahX6fobugwsuBJRZovKT7HmVzyhGOlBjpkfHY9/VVjl0DG8C2OHyqDbpS08lVUBRgz3sI4HOO5DCiOqD3/ondP6NypUSAR/7l95V8LzQG++qbfOxNqVdAnDo5LmtdReVVbEekopwBRK9zslp07OcNF3FFZcRzuTFa0n+l3yjb3nmUVh6h8nERNfXqwDTda9vOQC8kbCtumZIEyYwQPRvRmhZQLBqo12mueWpneISs3NJFm/+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOX/eORmGdVzRTynQ4ClV+0R6URjP53xqjhw7lTyqAo=;
 b=OvOBt/wMkw8uj7mU2RhrZtXgXd5GiCZ7jcHTUawjUzbIotOunh1kLv3R+Y1kSNggdIJte05DkLBfZ6hPuoQuJPWBLdxzMOHeWh4Sx3oHOvqaoORKNe15QwcNuN0Mx+A8BOUZDbDUz1L0qd+Wl/QfPc1PLXwPPIuzR84baD3ijVUDHE4BV525Ou+cOlZCCBlfgg7WnXd6lXuOkrHEFHuzSvwApyP75dH33Nxw7AVB9tQuEUyIMi36hK4q3y31ANZBR1nRbhe9RJp7yjxHhP6PqclwXk+uQxZ69Wz/enilW2KGJLUXOcbK++lfRiVbgDBb+rOX+sQVZzX3dzsPjxd3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOX/eORmGdVzRTynQ4ClV+0R6URjP53xqjhw7lTyqAo=;
 b=1B0nwGBmZrDOcq+XmSCVy7yxG63XkP1InvVISBFBZ8AxVpwrOmr3O0hVic4zN7qRi9R19JD7bWp5dPSrgBQGcUN0n4uj82HR39jb4o+JR8F1CWfRi1bVMpHclgxL4eaF09DzVzvnp+luEKJ3H1ej0PHlqnfvBqGPthFiYHTfohw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 18:18:50 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 18:18:50 +0000
Message-ID: <f9dde383-8384-8107-35f8-97687af3744e@amd.com>
Date: Thu, 2 May 2024 20:18:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 14/14] drm/amdgpu: add kernel config for gfx-userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-15-shashank.sharma@amd.com>
 <9fec4ce7-6814-4abd-a14f-5f4b9034f204@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9fec4ce7-6814-4abd-a14f-5f4b9034f204@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2486f103-86b3-44a8-4456-08dc6ad45088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEE2T0dxQk80Z2ZqQWRVL2FZQ3lDb0FZNlFsRFZNYXArYlo4ay83eEFSNGFh?=
 =?utf-8?B?ay9qNG5YZktSRlpHaXJnOHkwalZqT1V3SlFydU5pMkhmUURCSktQMjkyVUNN?=
 =?utf-8?B?bkY1d0ZRNjBMMS8rZzEvUGhQNzdkeXMzcnFjYUpjbm1xUnVEY2QzZHZqeXhN?=
 =?utf-8?B?V1V0L2ZxazZNUWVyUUYwYVZmY3phRURCUDRNTSt0a05WY2UrU2R3aE1ibm0v?=
 =?utf-8?B?Z0Y4VDNXWHdmWWovSUtjOWM2WUl0NGZmMHF0STEyZlZ6UzdXN3RUVnhWaVNw?=
 =?utf-8?B?MGRkNXlVNkliZ21jcForczNNQStZTWVrZjJMeDc5UXZNQVpoYzJRZEZXWk5w?=
 =?utf-8?B?dGlUZ0laVzJSNXFZWGtZMUJrMU5aZmRDSkExSVRxejB1RGhIUTVrSk9uQk1Q?=
 =?utf-8?B?eWpIQzRXUlMzcTBud3pMSTJBeGJBS3J5UTFWaTdWZ1F4UDR1Qk9FcTNuTHFR?=
 =?utf-8?B?ajViQ25sYkRFK3dwSkZ1OXYvWUVOcllNRiswaEphN2NRRWlDdWUrbXNqcDYv?=
 =?utf-8?B?bENOR1hsbUVBNlQvUmVRR3RBR3l3aGd1MnJ5TnBURjlZMkZucllMMTBWRjNW?=
 =?utf-8?B?MUlYWm1zZUpvNlVZWldjQUt1TUpaUVhMN3pXVXJLMmg1QjRGWnVncktMOHJW?=
 =?utf-8?B?bWhKWlZqWklzaUpDeGFuY2FMaXVBa0x3RUlYcmJubnhFZkJzMlhCTXVrZkkr?=
 =?utf-8?B?YVQyWUxXOHZVRGt3bFk1R2hiVURleXU3YTI2MTQyVml1Z203TDc5VTcwRzhG?=
 =?utf-8?B?QnF1ZmVzWHlhendkL05qeGhibzdHd0pEMTFxc0N6dTd5VmIwekF6Y1lZZjI1?=
 =?utf-8?B?bWZGamhZakxXcjEwa1FROFg3VHVtYWRxSjdnSmM2T3ROenRZeG03Mno1cDhG?=
 =?utf-8?B?dERyV1ZZSVo0RWxtSnk5azJ2QUwwaFZTZy9wSldxYVl4VHY4OFU4ZWhIWEhX?=
 =?utf-8?B?SWhudXRsOUdEUkVOUkZUamszQ2toNnpka3JsWWRLNVlRRkxveDVLUmxOTTNz?=
 =?utf-8?B?cXVFcTJxSkgwVW9wdmZRcUJKbmI2ZTBSR05xakJOeDFkdERZQ1A1eGN3WDli?=
 =?utf-8?B?bTRESGJxRG9xTEhkZ1RiQU1hTFpwQjZuVmpYUzA4RG9HM3hxWWFhVXNlaElZ?=
 =?utf-8?B?Z0lMVjY1bmREcjdTTFdxaUcrOHlvUHJnbmxIMzV4MUtvdFJYd2NKYlh2clVn?=
 =?utf-8?B?QUFKekwrZnpWaGxqZ2c1RTZmSjJBU2N1QXlVOG03UjhvcXFvT2JTTmNPRXRj?=
 =?utf-8?B?SUVZSjZhUDROcDBKNzFMQm1OZ2wxUTBRMFl4VWFDMnMxTy9PQy9qY1VoUkw3?=
 =?utf-8?B?NDBUWlNac3VlbW9Gd28zZXh2N2p3MkNoenBhYUNtTWFnam9obnZVNE1GbkNT?=
 =?utf-8?B?ZXR3QVhvM3l1bGQ5ZnVkZjFxZ1ZBajZxQVdJamdkWkNuQVFjSDA4RXVXaG90?=
 =?utf-8?B?RzdaZmxrSEVFeUFwVEpOeEdVWEFpQjArU0FsZ3hGNmcxQ1F4L1h3ZFZ1ckJw?=
 =?utf-8?B?TGw3eHV2WTZ3Q2dNSmNKR0FDcFEwZWFwYXhjOUlCTVgrVWhIUTVadG91SlAx?=
 =?utf-8?B?aEdia0t5aE1HTHBUaFlSbDBaTGR2TTlRakxTZnFNbzNXSjU3Yjl4S1ZxOWFv?=
 =?utf-8?B?QzBXWlFzb01nbDE3QmlzSEdreWJ2L3FyVnRIcU94WE9TeDZTRVMvZ0xmK3dN?=
 =?utf-8?B?UUpFdzM0MTIwbEQzV3R2N0UyVzMycXFMM09LMGlHaURZV2hjNERlaDNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmQxbzM2T01ZVytMZkpLU2tyczFsQ1RscUcraWNSRlAzN1VrL3pGL3E3TWxu?=
 =?utf-8?B?aTFkM3BybU5mV1BhbEtDNFUrd0JnaVJ4RDNTbVU3Ym9xQ3BZVFppNFJuMURY?=
 =?utf-8?B?MmxyYUd4WC9ucFJCUW9wbGhLRFNrZUJ3ZkllSGxncTQrc1V1S0F1NEdTQlgy?=
 =?utf-8?B?ZTdQVHZJSnRRakU5QXlQSTNvSmkxN2svcGtPV1ZMMmJHMUhVVTBoZ1k0Y05z?=
 =?utf-8?B?aWx0KzlyZ3BVREt1dWhhblJEWFdJYU15NjRnNTdESDMrWFBZTC9ySzU2UDhB?=
 =?utf-8?B?K2pRYW41MTVzT1ErUitrbldnTGE5MWgxc2I0K0tMZGVrNUJncXBEeGMrcXlI?=
 =?utf-8?B?eWNDWHkzTTRXWGo2cHdTNzRlNU1wbHpoUDM1K2t4Q0xtQ3FFOVM1Tk16K3dy?=
 =?utf-8?B?ZER2QVpRdkRNc3FFbVBoZE5VRTM3STc0VGU2RURJbTVOZ2VRVytMZTc4TDdl?=
 =?utf-8?B?YVZkdktUaHoxeC9LeTdESHBqWEs2K0toZ0lKZ1B6c1h4eUJWTHg4Y1RpQWhL?=
 =?utf-8?B?T1k5VGZDSEVpVmw1RnJPUVJESWZudk40K2JwTWRkK0E5bUsvTUdUbmNKZU91?=
 =?utf-8?B?UzVjRnVvSVJ2WVpUWGtqTktUaTFQMGMrTG1EMWQ2Y1JLbjhETFlRaUN0M0F0?=
 =?utf-8?B?S0R6cVJnM1V5NUtOY3RCRklQTzdmT0QveXB1bUw4RmdFVTlocVJlNFFPMGVW?=
 =?utf-8?B?Y0ZpblRFNGxPTHRYenJncUpYSWpDMnplZGJUK1JMdEViV1hVTks4QzVwd0Ft?=
 =?utf-8?B?NW5VWVIzUW1MaVFrS3NjQ2dyMmthTmV5Zk4wMWJCY2pyNUhka0hPZjVJRzEz?=
 =?utf-8?B?KzgvL2dvTThqRFQ2bkxqay9ISHR1aTlKSHpYcU9YVDNYTWlBeS9LUC9ldVho?=
 =?utf-8?B?bUhuMVpLKzRDRWN3WWVVOEU1N25MU2hDZVpFUC92MTl6a0hlNW1KVFZZbmZX?=
 =?utf-8?B?REtvU2FCM3BKeG9MaUdDSWVmQks0b2JIb2lNRGR4ZG1zc2dsbGNNd0lNWWx2?=
 =?utf-8?B?STFwVTM2NDVzK2NkeXhiTUpLR3p1YlY1VXNGSnNWSHpiYmNZZXlIVDhIWGVl?=
 =?utf-8?B?ZklIOVQzZDdiVXVOL3pmL1lEVU9ONHNpazZwYnBIQnR1YTJHcTFrbWp0cGVW?=
 =?utf-8?B?aHBUYmZ2MzRkQ2IvUWpUTVM4QU5KQjRSYUdJSU16U2xQdUNiSG1YUGo2bERR?=
 =?utf-8?B?RHIrRk50TmI4bnVJVm9vYTBGNzZqU3hnVCs3WERQWjJQQlFVVUJFSVg5WHpi?=
 =?utf-8?B?WTZOT3RvTU5KZ0w5R3JQaXptQm9wUTZVUHhhK2FkSlRUc0QyYXQvNUJkUVF0?=
 =?utf-8?B?UGE4MzF2c3VvVFVLZ3VJcVBkLzZwK1pSd1NHUjZpZGp1NUpCNHI3Y3RwVWg1?=
 =?utf-8?B?MlhEVnFWeUl6eHpVWVJQY0lRckFjTnVRNW1OY21OM3BBbG5SM2FLYng2TUlo?=
 =?utf-8?B?Q05lTzRuZHd2M2l0NW9HYmlHdHJmR2EvNnRLbm1hV2ZKWFY2azBwQWFITlZC?=
 =?utf-8?B?anhOMlBFb2pEM1lPb2Nob3NkWVRQTENyUllsOHd0V3VSdWJuK0pDTDFGK3lE?=
 =?utf-8?B?czYwQlF6NUJzc1huTWdyYk1CbFkyYzduL3dDb1dUbk5OUUlzb0QwUTR2Zksr?=
 =?utf-8?B?dmdJQ3J4QTR4alB6ZVJNM0hIVjlFMWZZU0VVamhEaklINmUvUUdiK2VwR0kv?=
 =?utf-8?B?Y0MxbWpsYmN3NVBGSFZEMk4yMmtOTnAvT3lmcG5KRzdNdDU1Rk9DalZNRXhW?=
 =?utf-8?B?Y3NoYS80OUtacDduSThhV1BmRSt3Y3JJdUU1L0crZUZvenFPbzJZcytoVmtL?=
 =?utf-8?B?aGZBZTlLZm90bFErQ2hUMXpIY01ZU0xCcSt1YUVrUXhsczJyelh1QWJuSnVT?=
 =?utf-8?B?SWxQb1FvMjZZYnpJUktBZDJISHRGMzVvMVQ3ZGwzdzlCZ2g2TWE5ZVY0c1oz?=
 =?utf-8?B?U200ZnZ6QXVPaFNidHpTM2hhQ0VacHpKMU90N2R5RjQ1K1htUVkzRlFpUDl6?=
 =?utf-8?B?ZVhaeXlMS3B1elVWcUlTNjF0NVBsQWdlUnZ3dWVTMzV0NitHVnpMWWkvMkVZ?=
 =?utf-8?B?YjIzb3hYc29KY0JHYnRMQ3pNUGs1Syt1ZXhmYWZWYmlsMTdpQVlvK0xrMFlx?=
 =?utf-8?Q?Dqv5o1iWkJXGirmSyBSqg3xJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2486f103-86b3-44a8-4456-08dc6ad45088
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:18:50.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tlq8hByc6AoW/tBPeJjrSGFc4ouyVfcE+RYc2rMgbJB10RanrFbCbwiRDvRH+F2Vi+twPDrgXFsfu2FPm7Tl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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


On 02/05/2024 17:22, Christian König wrote:
>
>
> Am 26.04.24 um 15:48 schrieb Shashank Sharma:
>> This patch:
>> - adds a kernel config option "CONFIG_DRM_AMD_USERQ_GFX"
>> - moves the usequeue initialization code for all IPs under
>>    this flag
>>
>> so that the userqueue works only when the config is enabled.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Kconfig     | 8 ++++++++
>>   drivers/gpu/drm/amd/amdgpu/Makefile    | 8 ++++++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>>   4 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig 
>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> index 22d88f8ef527..bba963527d22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -80,6 +80,14 @@ config DRM_AMDGPU_WERROR
>>         Add -Werror to the build flags for amdgpu.ko.
>>         Only enable this if you are warning code for amdgpu.ko.
>>   +config DRM_AMDGPU_USERQ_GFX
>> +    bool "Enable Navi 3x gfx usermode queues"
>> +    depends on DRM_AMDGPU
>> +    default n
>> +    help
>> +      Choose this option to enable usermode queue support for GFX
>> +          workload submission. This feature is supported on Navi 3X 
>> only.
>
> When this is for Navi 3x only I would name that 
> DRM_AMDGPU_NAVI3X_USERQ instead.
>
> And since we enable/disable GFX, Compute and SDMA I would drop "gfx" 
> from the comment and description.
>
> Apart from that the approach looks good to me.
>
Agree, both the review comments addressed in V10.

- Shashank

> Christian.
>
>> +
>>   source "drivers/gpu/drm/amd/acp/Kconfig"
>>   source "drivers/gpu/drm/amd/display/Kconfig"
>>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index a640bfa468ad..0b17fc1740a0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -184,8 +184,12 @@ amdgpu-y += \
>>   amdgpu-y += \
>>       amdgpu_mes.o \
>>       mes_v10_1.o \
>> -    mes_v11_0.o \
>> -    mes_v11_0_userqueue.o
>> +    mes_v11_0.o
>> +
>> +# add GFX userqueue support
>> +ifneq ($(CONFIG_DRM_AMD_USERQ_GFX),)
>> +amdgpu-y += mes_v11_0_userqueue.o
>> +endif
>>     # add UVD block
>>   amdgpu-y += \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 27b86f7fe949..8591aed9f9ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1349,8 +1349,10 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 2;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>           adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = 
>> &userq_mes_v11_0_funcs;
>> +#endif
>>           break;
>>       case IP_VERSION(11, 0, 1):
>>       case IP_VERSION(11, 0, 4):
>> @@ -1362,8 +1364,10 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 1;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>           adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = 
>> &userq_mes_v11_0_funcs;
>> +#endif
>>           break;
>>       default:
>>           adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 90354a70c807..084059c95db6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1267,7 +1267,10 @@ static int sdma_v6_0_sw_init(void *handle)
>>           return -EINVAL;
>>       }
>>   +#ifdef CONFIG_DRM_AMD_USERQ_GFX
>>       adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>> +#endif
>> +
>>       return r;
>>   }
>
