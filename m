Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD99D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDC210E487;
	Mon,  8 Dec 2025 15:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="278ftu8Z";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC0810E487
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g82frKzEu7Zn4r4HzyoYjpXmO8YqSoFdLFE2NQ7nauxIaKGZOH6kDeG21aq+JpNJjKNxdy9gs9Yy+4gw7wXoKdC1jTo49C/fEkGJmsL3NNwKKlK66fNTcOa1SoBT48vm2uVg2g1Q37soqaRC/YTYimgrZCA3upgjjDDQuKccfmOxpKDnkxnQQHnUHFbvacbQlzeEkTunEJ8sPPTNwz5JCweahTia67a72ASr/ulNsbOrwj2jnESG3h1NSCtwxyeemEp/RKSgF4mPmGFWVc9Ln370mKEI8HQ6zrWyGj9M/rSk6lMYaY4OofIP2aMY3U8szSPW7z/mEiApZ+xKRHDB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mScXXFd7cJJ2V1YBGBRSzcMY0fEqIO916T758Qfoi0Y=;
 b=OvY4C2MkKEV/0CT7LpFxZQRLVb+1klovTZ4UA3xjSYGXCvejAOLONtTVSRY51oMr9NMNplpAQcWeeNdkdb9cFZ8pnjeviGJWNQcgSSmNyei4bVpbnkID72FsrdlNr/p3jBVZvlK2MIlTXExT44LXqdFwSxjjzVDa7jgWNbZKxQLmB7h7fDVXolHtiWsce1SkNHbaf4MQSilYqD9Qf9nDBfjc4Dyx+0fnWICE8KoNDwE10eN9CdWk5EiUkonbuDJmt0fqpPmYLFbVBiXwbtJZX5V2ZQ07beLKa8ZqUB6xvBXB6CJ9BsdmlVgy7LCocYOiTKuowm6Aq/OX3UrmPYw4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mScXXFd7cJJ2V1YBGBRSzcMY0fEqIO916T758Qfoi0Y=;
 b=278ftu8ZdU2MK0IehVWNCZRwWmvHTb7MuDEswYZBMoub6i/slkLUMxJxboE+es+/rYc/tHt6fbciO4HYYQCKSwmxvx5XmbAtXdXKceQBp799TPq6XKQ/uR4FiD2uDb0Y3qGmtOqzf9JnDg0xmtl4uz1WcEhdfSWiinDCo4R6tAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:54:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:54:50 +0000
Message-ID: <4a23d4fe-6ca5-4f91-b4fb-f3191fef3f0f@amd.com>
Date: Mon, 8 Dec 2025 16:54:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-6-Philip.Yang@amd.com>
 <a90486e3-e27d-4f05-a129-82068f4c9093@amd.com>
 <b1f259ef-3aeb-4158-84f5-d2811eb8c529@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b1f259ef-3aeb-4158-84f5-d2811eb8c529@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0517.namprd03.prod.outlook.com
 (2603:10b6:408:131::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: a13b23ae-cc15-41f0-191a-08de36721ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUNkTTF3blA4L1FHek9tSjR3UlZzRGYzWldhVU40NmRxMW1oL3B2YXpMRHRC?=
 =?utf-8?B?RDFrY28zZExkWnJOY3dyZENVTXVoOHphQzBuVDUyRVBrb0dEWm1ObVFITXdB?=
 =?utf-8?B?RFdWVTJwQTNVelJDQXdvZTFqUmJ0RUtOeVliSHlZMk0wNk9tM0JUV2p2SWty?=
 =?utf-8?B?Zm1HaElleGZyekREME42MVRNQjd1V3BvV0pRRHN5dnRBVS8wNGRYdTlsR1RP?=
 =?utf-8?B?dnpCWmhRdDVFMGs1TGFuTCtIaVlzeW1ZYXdBQnV6dXBsSlVwUERCN0JvcUlz?=
 =?utf-8?B?TVZKaG9xQzNKSFFQbWRoTjFqKzk0UnUvSXg5S3A1dlEyb0EyTE1yN0dtZDkw?=
 =?utf-8?B?azErTXZzRzllOXNOby9FY2RJUSt1S0pvb09RdTFmR2JHOXV0U3FwUERmWk1r?=
 =?utf-8?B?a2N5Qk5TZ0I3S0FIcUdOdTdDQVhOMWVDQytNNngzNHRtTy9qdXhGZ0QrN3Jl?=
 =?utf-8?B?RVVxbW9IUTdxWWJUVWtBOGJoK0diMVU4UjZWWHFPTFhsNXVaZUNrbThRMStv?=
 =?utf-8?B?alhVR2hjVDBzVnFnMXZWYkg5Ti9IdXhLYzFDQVQxb1dBaEI0a2JtdENTK1ZX?=
 =?utf-8?B?TjNxckttbzJsWlZteFJHWVRVQlpFLzVEbVBPL200SjZubVVLczU5djlxVURB?=
 =?utf-8?B?K0pRN1B6SHU2T0RESCtnaklqN0lzUGRzWFh0RndTOGhoNk9IM0E2d0s5QkFT?=
 =?utf-8?B?VENhYWNCVjhERkJRTW1iNHNGTk51SmtKRGtKNC9DK3M2eGZ1cHNDMXhBN2Qz?=
 =?utf-8?B?aUtzWVNXV3N2Z1QxT0dHcjh3c04xZ29DVE55RVMrd05tdjQxaEZJbW1uaGYr?=
 =?utf-8?B?SFZuaHoyME5zMW45cnBDR29xZHF5K09jSk9oYkZSRWxXNDdxMXI3d1J5SkVa?=
 =?utf-8?B?WWV3ZkUvMDQvUWxSeGNjdlo3MCsweUYzd1BSQTN1L21jZ0JkZ0MrOURaeXNY?=
 =?utf-8?B?cXF5dE1mSkhPci9JTW1ybkl3THNNaUtqSEQ0SW1QYS9Uclc1QUZaQzJTVDYw?=
 =?utf-8?B?cjdzUXBuckVEeUh5cTdjNlgzS291MVlUU2RQcXMxcXFtSjN0djBsalNibTlQ?=
 =?utf-8?B?S252Tmp2WU8xRWxVeHp1NVlUb0pNZnR1SUthaVdXYVdEQzlOMFZ1dkV2WkJR?=
 =?utf-8?B?cUdQN21Gd3hJZ0diMUJncUdJL0xYZVZYd29GdDRkZTFpZjFnSis1MWJLcHhi?=
 =?utf-8?B?YzFINkkwMk9yemF4SFJCSW9oUWNhN3Y1WW9sSmlzYjFzU25XMnNLbFltc1Fy?=
 =?utf-8?B?RXRHZ1R3REVPUTdJWWNhd2kxY0g0NDZvR1VjM05oeHhkQVRJRkNzL0puN1Vq?=
 =?utf-8?B?UThhV1czQUUzaXVpallIVEh0WGVWSXd5ZHZKdkNXTVFBT2JNTTc2YTU3TFdW?=
 =?utf-8?B?WTFaMFgzTHhYcHY4KzJVOU9NUlJpY1N1R3hqNlNyU3pTY21FS1RSc0daWkdP?=
 =?utf-8?B?V1NVSjNERTJHbEhNSUllUzlmMVY2bXI3L2QwQmV1bXVwWkkzVktLVjhqU1dU?=
 =?utf-8?B?RmQwMEFRMUNidDk0WTVqLzZlbVhuOGp1ZGw4ZjBJaTVHRm1vYjJOdUI5ZDE2?=
 =?utf-8?B?S0hNQU1OMExndUpJeXowblRDZ2N5Q1QwbXdaWHhOR0phVXBudk9FSXJJMHYv?=
 =?utf-8?B?ZmVBalJVNTMvb3JuK3pqVU42OHVyMnJBRXJOVWZKb1h0b0RIMFJrZ1NCZXRo?=
 =?utf-8?B?amtrMEdjdVlXYUZFZUE5aWllOUI4OVZCVk1DaDVTWXVsSFhTNGtOQWF4dlRG?=
 =?utf-8?B?dGZVUWI1Q2FmdDgyTWp5bllFREFMUVBDVFBxRHNUU2YwYTdSSXY3SkRhSGla?=
 =?utf-8?B?bFFhajYwQnM1c3dyQUxXcFJhdWhaR1VTancwVkcyV1pKd0x3Unp4SnRLUExL?=
 =?utf-8?B?bFBwV3Z1TDV2cFNWMStwWTlpV3QwSlpwYnl4enVKSXEvY09RblYrT3MxT1JM?=
 =?utf-8?Q?t1q5ZvIuvtmIv38yTP73eSSgPJgpEyp+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBIaFdJTDdScUQyaC9MeXFhUzJaR1lVMHl6Tit2Tkc3a2JxZFhhZXRJMUlM?=
 =?utf-8?B?dEU5N3E5ZE54a0tGQU1QNGFBWHhuQ0JLRUFWZUtSWHJTT1UxOXlHOEI3WXAx?=
 =?utf-8?B?VjE0a3ptWnRCR05PYUFna1BZZTRiTm1tTjFYOFJrZTJCMTlQemdZZ2NmWXRs?=
 =?utf-8?B?ZEYyRGphOXhOdUpDbHFxejRUdGtxWlJmdFkzRGswd2hwNm9YOWF0dFRnUW5G?=
 =?utf-8?B?MUZxUGhHbjhxbUxmbFZDYTQ2QmdLNkpUUC95UHg1WmVSSXNiaElGV2grQmxR?=
 =?utf-8?B?YUU0dXF5UTJwOXVOd1NpRG5ZOXNIRlVkdHZ3TWVBUUlXR2gyZldoMXhBcnFr?=
 =?utf-8?B?M1JDejducTc3YnZ6QjEvWEVWQTRiK3ZkaVpFekpBUTE2WUZXWFNybnBiTzN5?=
 =?utf-8?B?SkwwTXNvcE5XZ2FKWm1BS0ZGRncwQk1Cc0M1YkVDd0VYU3hLdi9pMEhpYW5w?=
 =?utf-8?B?U2dzMUxMRzhNWVZPd21CRmluUjNPRUVWd1hEV2E1U3pMYXVVY09sUG11b29j?=
 =?utf-8?B?RHVHRHM1M0JybHRqek9aTHFvMVBpMXlZdHZsbXhmZDB4L0Q2R1R6UVoydmV6?=
 =?utf-8?B?SWlHa29Bb1N5Ris1R2E2anA5T3YrSGl3bU9Fd1A4NG1RekRlRnVWNCtLejM5?=
 =?utf-8?B?ejNwaW9ORkptRjRKU0trRUptWnBibFd6OUxpbWt6K1NXbUtXRzE0ME40ZGhi?=
 =?utf-8?B?UC91eG9qUU9yTHBnbGt6VVJha2dydFFkS1RzeU41Um9oRFZGbFRKN3RrbUVu?=
 =?utf-8?B?L2U1MWprQVdLOENva1ByRjFGVFNab1lhdWZHMm1lMmZRMFVBSFBNV1RiYXJU?=
 =?utf-8?B?MmxlSkNqMzZpNG9mRjdnK0pNY1FORGtyelZPT0xZTSs2bWNDR3NFVmZ1MU02?=
 =?utf-8?B?TXJrQXlNY0tWeGhRZ3F4TGs0d2FKdWdORmFvWStMdnluSndHL3RJaHpGdmg1?=
 =?utf-8?B?Z0RZeTYwMVBoWHNBaERtN3VXaGhDNDQxM28zU3dvdng5dkRTUmpVTWxwejB1?=
 =?utf-8?B?dHZ2bzFpWlhyM2dUcFdYYlFKVXI3NjBFZFRpUTEwZzRkTkZQMU5KVkJraHV2?=
 =?utf-8?B?L3RjMFlIMHZZTmpMUGc2cXUzanJMRHk3MkM1ZDNMbFpwMXM4Mysvb2JTc0NB?=
 =?utf-8?B?citmRDQvcEpJTmhNbTBtNXN5V2thU0dhTVNjc3VHWHUxMXgrRlkxUUgxZXlV?=
 =?utf-8?B?TDBqTDhGMmRHTFdFUytaWVJRem5mRmV6dzhRVDJzbGQ2ekdxT2hzcHQ1bUJB?=
 =?utf-8?B?WHhIekp4MzFsMmw4enFoVnZnUVZtL2R1UUNpZXhwSTMrem9sVG5RVzRrMyt1?=
 =?utf-8?B?RnJzZk4xUVR4RGxUNERzSHBRZklYWHorNkdPRVk1NnVNZlBYVEFHS2RSellQ?=
 =?utf-8?B?YXdTbmtSVG91S0dVeVpsVXQxOWNablRXOUE3REhNR2Y2aW9NL2dESmJ6Vmpp?=
 =?utf-8?B?MmxMRURHZitnZDhCTmp3R2g2YnN6UUxvOHQ2WnA0MlAyd3A5cFg2YUdXVmRj?=
 =?utf-8?B?dFUvL3RzempGSUxNVjRWQk1mcEM4U0ZHQjd0dFplWjcvcFhIWjZ0T2s0Qy8w?=
 =?utf-8?B?L25UY2JLUmpjMEpZTWpBR003MUJWYWk5WVA0bWJ3bDZHZkdPODY1UmxjR0F6?=
 =?utf-8?B?bGVVbHdGd1p2UmpGclBSRmJwUHF4RUVvaFBVRTFWS05SeFdvODVPbWF5dC94?=
 =?utf-8?B?RFVLVG8rNmNUNlgwV1R4NVBOYmQxQlVDTEMrNCthaCtyZndOVXM0VHVaWUhB?=
 =?utf-8?B?RzBiZWdPRnduczZ0SjVXYVJ2aE9aUFZGT3JoNmI1QnJ4NEMvZzdqZlZTWEJq?=
 =?utf-8?B?N2JJTm1MOTFEVU9tbVV4V3g5M0kxQVVwbGtTUGZzdGhLNGh3Z2tMeTVrWVB6?=
 =?utf-8?B?cVhVakEyNEUzaWZPbGZpLzA4N2RHVDJTZkRwTnVkVm1HTURxNWc3TE84dHhM?=
 =?utf-8?B?ZFA1akhhR1NnaUZVQjdqdEcrdk1LSWJIK05WejVjcjg3YWUrODJ4aWJ6ZGdR?=
 =?utf-8?B?WmplenF1R2U1a0g2SzBLZDZpRzNZMTArckZRTlhOSmt2VXkxWGxQN25vSE1r?=
 =?utf-8?B?cjJjSFJQajRiNVpzY1psRFo0dEdCMWFqZmx0eFp0YXFIc2lOaytPb0tPeW9K?=
 =?utf-8?Q?ffuSZRnWkTRqMqHZKgDyUULMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b23ae-cc15-41f0-191a-08de36721ed1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:54:50.5694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnHYF5QblcPLC9VvhDhWC82z+WrpDd0PlOXzI0joKD7MG+ScBXdU5IMNa3WQYgN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

On 12/8/25 16:52, Philip Yang wrote:
> On 2025-12-08 03:40, Christian König wrote:
>> On 12/5/25 22:49, Philip Yang wrote:
>>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>>> to GART as mtype RW caching, to reduce queue switch latency.
>>>
>>> Add helper amdgpu_ttm_alloc/free_gart_entries.
>>> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
>>> to GART mapping.
>>>
>>> Add GART drm mm_node to kfd mem obj to free the GART entries after
>>> MQD is freed.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 103 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 ++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   1 +
>>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>>>   5 files changed, 122 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 4f8bc7f35cdc..fc6f4daa9b87 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>>       }
>>>   }
>>>   +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>>> +                struct ttm_buffer_object *tbo,
>>> +                struct drm_mm_node *mm_node,
>>> +                uint64_t flags)
>>> +{
>>> +    uint64_t total_pages;
>>> +    int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>> +    uint64_t page_idx, pages_per_xcc;
>>> +    uint64_t ctrl_flags = flags;
>>> +    int i;
>>> +
>>> +    total_pages = tbo->resource->size >> PAGE_SHIFT;
>>> +
>>> +    amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>>> +
>>> +    if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>>> +        amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>>> +
>>> +    pages_per_xcc = total_pages;
>>> +    do_div(pages_per_xcc, num_xcc);
>>> +
>>> +    for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>>> +        u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
>>> +        u64 start_page = mm_node->start + page_idx;
>> Don't use resource->start and ḿm_node->start directly. Use the resource iterators for that.
> VRAM resource allocated with AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS in previous patch, is in one block, GART entries allocated from drm_mm_insert_node_in_range is always in one block. The MQD size is 32 pages for MI300 and 6 pages for VG10, use contiguous allocation is fine unless the VRAM is fragmented too much, or I can remove the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag in this patch, and then use resource iterators to update GART mapping.

It doesn't matter if the block is contigious or not, the point is you should not touch resource->start nor mm_node->start directly.

That is a deprecated field from TTM and internals of the VRAM manager backend, both should not be touched here.

Regards,
Christian.

>>
>>> +
>>> +        pa += adev->vm_manager.vram_base_offset;
>>> +        amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
>>> +                       flags, NULL);
>>> +
>>> +        amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
>>> +                       start_page + 1,
>>> +                       pages_per_xcc - 1,
>>> +                       ctrl_flags, NULL);
>>> +    }
>>> +}
>>> +s
>>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>                    struct ttm_buffer_object *tbo,
>>>                    uint64_t flags)
>>> @@ -1017,6 +1053,73 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>>       return 0;
>>>   }
>>>   +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 num_pages)
>>> +{
>>> +    struct ttm_resource_manager *man;
>>> +    struct amdgpu_gtt_mgr *mgr;
>>> +    int r;
>>> +
>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +    mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>>> +
>>> +    spin_lock(&mgr->lock);
>>> +    r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
>>> +                    0, 0, 0,
>>> +                    adev->gmc.gart_size >> PAGE_SHIFT,
>>> +                    DRM_MM_INSERT_BEST);
>> That belongs into amdgpu_gtt_mgr.c and clearly not here!
> Yes, I will move the helper function to amdgpu_gtt_mgr.c
> 
> Regards,
> Philip
>>
>> Regards,
>> Christian.
>>
>>> +    spin_unlock(&mgr->lock);
>>> +    return r;
>>> +}
>>> +
>>> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
>>> +                  struct drm_mm_node *mm_node)
>>> +{
>>> +    struct ttm_resource_manager *man;
>>> +    struct amdgpu_gtt_mgr *mgr;
>>> +
>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +    mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>>> +
>>> +    spin_lock(&mgr->lock);
>>> +    if (drm_mm_node_allocated(mm_node))
>>> +        drm_mm_remove_node(mm_node);
>>> +    spin_unlock(&mgr->lock);
>>> +}
>>> +
>>> +/*
>>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>>> + *
>>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>>> + */
>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 *gpu_addr)
>>> +{
>>> +    struct ttm_buffer_object *bo = &abo->tbo;
>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>> +    uint64_t flags;
>>> +    int r;
>>> +
>>> +    /* Only for valid VRAM bo resource */
>>> +    if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>>> +        return 0;
>>> +
>>> +    r = amdgpu_ttm_alloc_gart_entries(adev, mm_node,
>>> +                      amdgpu_bo_ngpu_pages(abo));
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    /* compute PTE flags for this buffer object */
>>> +    flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>>> +    amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>>> +    amdgpu_gart_invalidate_tlb(adev);
>>> +
>>> +    *gpu_addr = mm_node->start << PAGE_SHIFT;
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>>    *
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 72488124aa59..cb6123358843 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -185,6 +185,14 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>>                  u64 k_job_id);
>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 *gpu_addr);
>>> +int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
>>> +                  struct drm_mm_node *mm_node,
>>> +                  u64 num_pages);
>>> +void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
>>> +                  struct drm_mm_node *mm_node);
>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> index f78b249e1a41..00e1e5b30a3a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>>             struct kfd_mem_obj *mqd_mem_obj)
>>>   {
>>>       if (mqd_mem_obj->mem) {
>>> +        amdgpu_ttm_free_gart_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>>>           amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>>           kfree(mqd_mem_obj);
>>>       } else {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> index 14123e1a9716..5828220056bd 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>>               kfree(mqd_mem_obj);
>>>               return NULL;
>>>           }
>>> +
>>> +        retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>>> +                               &mqd_mem_obj->mm_node,
>>> +                               &(mqd_mem_obj->gpu_addr));
>>> +        if (retval) {
>>> +            amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>>> +            kfree(mqd_mem_obj);
>>> +            return NULL;
>>> +        }
>>>       } else {
>>>           retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>>                   &mqd_mem_obj);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 29419b3249cf..fdde907836fb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>>>       uint64_t gpu_addr;
>>>       uint32_t *cpu_ptr;
>>>       void *mem;
>>> +    struct drm_mm_node mm_node;
>>>   };
>>>     struct kfd_vmid_info {
> 

