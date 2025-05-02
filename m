Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4152C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 12:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4515F10E8F3;
	Fri,  2 May 2025 12:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KEZA+1ma";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F4010E8F3
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 12:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr4Zw6jYXMEjDc2aNXp9QcIvPg2x+5yvu55nLryyP0XqeJTtKXXs3Rl75HhFJnhdxYMsPynLyNZpuK4/Ktci8RkB1UfJ1O+myZdkdE+xpzgRaCBvWCyqt+Eb+taaXZpI8rV+EvUMwc8Gpxw6rLDc4mj+X2M+80oFWXuA4OTGevUCZ1LSWVgAWNo5kgtx0Aokd+K9qS6ax9kHZme5S1v17zBpWT/FMYZh8QUzfUhqlewYdaSiOaZKttZkIvRqKhBiiOdYL+gl/LqZ6rBgD+glhrzuviCyufPWEaGvZVM9rBE/5pVR4ZSjvIbO+JHTVXJX1EcRs381CrhwwMtjaOe9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIs4GEGE3/n41BLu2C+a9ZpGhBVVhQ0ta2eNogP+kaQ=;
 b=ycdqagcfIhA959OWz45D/twA40dOfvS8mLORr0l6hDf28IL1LoMKaBHntYkHPv1tteiWhDzVShJx/QXlVnMaghd539efqVOzBmm2PT6q6o1yUyJ731Kc4Kq8RS6rTMHrcLZswNJj8MKFNtskt4N274AF5fhzdjHzGFSYE91r8Mwd+uPhdAK2IO2+sS2wArOEA2Yt/tyRsBQ/OhdJ1OCOFn+9fy1kCmyv86I0SwfN4u+oLrz2TtO3jiwpl3lMZqK05/RytB2PZHDCOerTulRhdflt5g4S38sCB7bNoZ6fxQRWQU1E9mkfM06uQ2e3EjF/mtILSUGPcxHSUK3Eb6CEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIs4GEGE3/n41BLu2C+a9ZpGhBVVhQ0ta2eNogP+kaQ=;
 b=KEZA+1maDw2S5v58lugABr0baVTZh+5rrVUuCW8Sa0sp/pfD3Vh3p6ghDitSfFJ3dJGKMNdleChfBrgagJ8Hut8rbTwUNS1nGGXr4FEQNdq/WjrlPbdBCGKxeSPICLj3D3d9l7ImXfJYpKEuCIHKFGbNzmwdtl+6sqfxrSamZOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 12:36:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 12:36:03 +0000
Message-ID: <4deadb8a-ea39-402c-90f2-ecfa8a10b025@amd.com>
Date: Fri, 2 May 2025 14:35:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu/userq: Add lock before accessing
 dma_fence_is_signaled_locked
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
 <20250409054831.2411-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250409054831.2411-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3247215c-20ef-46f1-8807-08dd8975e6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGIzQUlueTMzRk1CNHRUNGFqSGRvNm5TamRkWHg1UlNvS1RYRVpUOGlwRGZt?=
 =?utf-8?B?QW9wOGxPVjY0cjZiNGc1OU42bVlJNDJRQ1ZnZDlUS0pPT0VqdHF3UU16VzBw?=
 =?utf-8?B?M29POVYvdldISHlZRCtwV2U5OVlPSHBUelFMWGdMSFZEOW4xbkhURmUzaDd3?=
 =?utf-8?B?N3JhaHJNOC9GK0kyTzVIR3h4MmkxTVBYS3FSZWk5YWhlOXArTExxQ0VkTlRy?=
 =?utf-8?B?cGw4SEU0bysrUWhnMG8rTC9TY0h3VlY4Z05lNmNheDB1K1p3dzFoejg4WXh0?=
 =?utf-8?B?TVZibnZIWEJleDNtZGF5eWFJcGRxd0JxZmFIaW5PWTRiSXVZeGZORzYzRkZP?=
 =?utf-8?B?OXZ5MWsza1NMbFY0cG9kUUs4T2JWR0pTRVlCVWhPbjZJelJlOVVZMUxzekMx?=
 =?utf-8?B?NStCeWRZSzEvWW0vazRPU2NsL2hoMGJGK0lYYkpRTUNZNTAvS3I5dERvNkhY?=
 =?utf-8?B?a04rQXBhMHo0Ryszamt0Y1M0YytMU2pETzhLbVJZTDliUndjQkFyOEVaejcz?=
 =?utf-8?B?QkFUYVZTdVkxK1psNGladUJSYllCQlZ3TWx3V3k4UEFVZlA3TFMzN0o1Q2ZW?=
 =?utf-8?B?YkdhaTI2Z3JhNDdiWVFad2ZIRDk0QlRhd1J0R1J3S045RWRwSC9PNnhDNjNY?=
 =?utf-8?B?V25NT1pVcEYrREVZcys0WWZDazhHQTR1eUxEakRIOWM5YzE3VWNjeGU1RVpI?=
 =?utf-8?B?TTdCRnhyckM0K1hDTW5aVUtIUTNMQ2JoNk1lSnhXRVY0VWR1MEtGN0lDU3lH?=
 =?utf-8?B?bFNZZEgwelhDNC8yN0c1NVZaVU1aRkdJc0pJblZ1UjBmdjFIYXJxRGtlZ0hH?=
 =?utf-8?B?SmkxWW5FcCs3dkVNaDhMUXRSZ1ZmQkFvUHNhRkw4cXVsRVM5K3ZEckJKVkFB?=
 =?utf-8?B?Z0ErWFl1QURTR3VSQW5mS3ZaSXQvc0x5MlBIN3o4T2Mxek1pRVI2TEx5blhh?=
 =?utf-8?B?SW9OL3RZa0krQWJkOUVEWGZFa0xxVGMvSlFzNmVHSFVnMU9jbUREMXJFZTBu?=
 =?utf-8?B?eWxqK0s4S3hKMURWRUJ4L2VUSG5mcHRjUGU5dG0xWS9RVGloUjY1V0I1RTNa?=
 =?utf-8?B?allESGFjaGUvOWg5akFmbVBWNnUwNC9uUDRLTjUzVU8xK1FPbzBtZERaN1NB?=
 =?utf-8?B?SWJlUXJ4bjU5U3NpMStTQmsyRWxVY3AzTkJ5OWZFNkE2VXRwYnZwQngvZFpn?=
 =?utf-8?B?T0Z4Ti9hVGltb09QbU1RYUpFc3ZjL0dTUlhVYVdPVGw1cHBWWHIwL0c3QlFs?=
 =?utf-8?B?Sno2bHZEbXF2WDNFbUR0d1dRaTB6K2QyU2RKeWtwRkVpcUFHTEtvb3dnZlhr?=
 =?utf-8?B?bHlxck1FSE9SeTV4WlNPQlBmNTlZVm9udW1ieVluS1NpckRJamx1RDZGSkRy?=
 =?utf-8?B?cFJmMURJR0lZOGM5YW9KZDZVV1lXYW9QYm9mR2tsNlhBcGhrbFROS1R5VnRr?=
 =?utf-8?B?ZFJFb3RUc3UvL1ltdk5SVURpb2F3TlM2ZitiZzMrM1grVm56czFPd2RnbGVl?=
 =?utf-8?B?ays3dmRVUkVBc3dFeFNocXZHVE5pKzlST3FSRTRsU2RGNGkvSWtBYXpoM2FJ?=
 =?utf-8?B?cmZjSkJQNnRKZVR0RkhvVzhxRHliSk5JYjAyNExobC91T3diVEpvdlJVS3lj?=
 =?utf-8?B?RXY0R283QTJLMDVLZmZtbDlucTlpNXFiRVlRTm9BTjFxYnBjaXlNOS9EVEl1?=
 =?utf-8?B?UTlEamZQQ3RpclByRzFSeWlUKzI0dGVFQ0JNMG1oTTZSbjRVQ3pwaXhUUEJp?=
 =?utf-8?B?VEpZYzYxbFR6akR4enI0WE05eE1ZVlBPRnR4Qm1STnlxMVI2WVV4ZGs2SENE?=
 =?utf-8?B?YngwaW5naUhCTEUxM0tSdlVxa3VRbTNERWV2NHFHNVp3UEpNK3hSUWZDdTg3?=
 =?utf-8?B?WXBKQkxQeURPMHhFVW9rTmRtdmtjUDRCSW1TM3B1ZG55RlVCekZkRFlrR244?=
 =?utf-8?Q?g4XGzEYf7KU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ppWlE4bWQxYTNkRi8vZlM1eTRnN0hLUllYeHlJbUdaL3NMdjZaU3BCMVRM?=
 =?utf-8?B?SSswdy9vcTR3QlV4T1JFQ2RuTzJnZEVrRDhtenhPbnh2aDdKYWVGblNsQVcr?=
 =?utf-8?B?eFE0VCt0NDAyejl5Uko5Uld5RjdpNDMyRW1JRWVuTTc2OWtFU3NXRXMvWDFp?=
 =?utf-8?B?YkpDME4zUjhkdTBtNktMemhJN3M3dTNvNDJ4S0kyaGdrVjRvZlgycFZ3UCs0?=
 =?utf-8?B?RGV5L1VGV2hZY1BITU5jOXFOY2FqOEFMd0syWlp3UFFhNnZDM0h2OVlySG80?=
 =?utf-8?B?OUFHSlRXOEdPN3J6Q0RXdFJxTmJhMVJ2T0l0OThVQ1F4UUlsVk9INCtQUzRK?=
 =?utf-8?B?YUJpL2s3WkpVUWVvN3hxd1kvNW10MURTbXFwNWtzc3FWbDY1bSt4dHJJTVVF?=
 =?utf-8?B?WHN2cllTWGlXQUhIVHNLNmV3VGpoVDQ4MnhkanF0UGkyOHVpNmdCSXJLV1hX?=
 =?utf-8?B?WU1IQ3ZWNXYrOG1wNURqQWZEWE5tNlRoRkRDRkp6RU9YQW9xVDNZUkJCYTgx?=
 =?utf-8?B?WHI3cEZVcWtPeGxLaGpPZlU3T3ZkZmhXSnM4VTRNeG12OFhkM2VHTmUzNTBz?=
 =?utf-8?B?T0h6WjYvNktOQW5xMzBJTXM1SlAyYmtUTGtOM3NIaVFZR1VudGVYekQrZjFV?=
 =?utf-8?B?YzFaMzZubkZPZkRJU1hCNytsb28wSTBxVnM1dGJDSDZocVpXOEVpU1hzamJR?=
 =?utf-8?B?bld2alZmd0dNbzJHUGd2elozSW5qSjJiM3BiYmEyTXhSa0JiSXVIOW80cExI?=
 =?utf-8?B?WUpVOG5lSjFLdXRWaGhPR3VIZjZDcW1vVmhkREIrRkFIaUpGM2ptSDRCejE2?=
 =?utf-8?B?cG5ZOWxJTlpMZ09uNTJWMnQ3MUpwRUdiWGJuR1pMaWJtZ3k4STRmem4vUm51?=
 =?utf-8?B?eFczcGdNKzlpYTJsRHpOQWNuQ1FLbmMweTQrOWYvMG5KWGlBOFVSZk4zUlJB?=
 =?utf-8?B?ZVFWNy9DSlVacmx6ZXM3Z3lrSDhMZHEyNnpRcDhVZm02VzRyT1B0QU5CUlEx?=
 =?utf-8?B?SzBJMDhCRFZsWDZXeDJsKzhQck9mRFYvZjFaQ3ZVWVcxZExnZVNwQ1RERCsx?=
 =?utf-8?B?cDRlWmltY1dGWFFNQnVyb0VocDhaQmI2WXRPc3BiOHdDeXdkdnErbnJlWWky?=
 =?utf-8?B?bFdjZm9pQ21aWUpXZXh2N21QWWdseEE3K1J6V2FpaElsK1lKSzlKeWhSVzVY?=
 =?utf-8?B?cVZoYW5vWTRtNzl1V2ZsQ1hDRzlMMG9UWkJFaHQ0K0g3ZExTZzBWbzFmTVZl?=
 =?utf-8?B?VDEvVWx5aE9rZVFLS1A4R1RNUjE0U0gxbVhoQ3JOYkV6aDAxOTBZMGx4SVpr?=
 =?utf-8?B?WjRhZ1pLZklYRWo3RjJEcm0yUmRZVFFpajg3NXZFVU85MW0xa3BDMEJiRG5z?=
 =?utf-8?B?dWNDREZJanpqUlVUdGd3SXNtTlI2ZDZnMkU1UDB0WkJTa3BQbGYxbyttV3Z0?=
 =?utf-8?B?TXF5YTdZNTRuOHc0OE0wWFpxTnN5eEtVUjV2R3MzUVo0dERnZTM3L0RHSHNC?=
 =?utf-8?B?M002RUhsampqamFlbzBlVjJaaEljZUdkcENvYnRjaFdpV1hSNVdVbWtpWTNE?=
 =?utf-8?B?bEo2alpCcWt6cnBYMGhMVURqS2lENTFQNHhWVXNycGJ2Wm9JOTlaY24xbUt1?=
 =?utf-8?B?UmN2TDQ1Lyt3RGRuU3AvOE1ZeGJ0a1IrTTIwalF0L0pROVRHT2JRcm1seUlv?=
 =?utf-8?B?RXF4QUk2SVVDbWtaWnllRC9JR0p3eGJla0FrbkFWMWc4eVNnbjhXbmJON05K?=
 =?utf-8?B?L2x0bVM4MEJpalFYSk9GRGZzV0lwaDc5Q1NMNEJQUDNCU3hrODRpOGpOS3dW?=
 =?utf-8?B?eWtSbmlkRmUzM2VVWTZLLzFyY1NaTHBhQStaUzJVSkU3NDBQRHZKWS9zVXgz?=
 =?utf-8?B?bnB5RXJOaWNDZjZSQUJYQnNmSzgzdkJzUnpuTnhtdkRja0FpWHFuaDNablBO?=
 =?utf-8?B?eFB2cnRQb0tWMjV5dS9rR3RjLzFxZFdheUZmRE1ROURNcWJzWHdWR0RYVWk0?=
 =?utf-8?B?NXpGVEJwci9FU1pEblhNT0JlM25XZWxBODd3TGR3LzllbklLWm9LZHBSZlhV?=
 =?utf-8?B?eUduVk4wckZWaEFDL2NCcWt2aHhPUHhFL3BNQ3FxMElMenU5YTdEMHJRUmR3?=
 =?utf-8?Q?ifUyGJKw4PjU18Tn5cK/3COrt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3247215c-20ef-46f1-8807-08dd8975e6ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:36:03.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWodHC3Gbks2Lnig5TSU01ZQkbkU0PAHhZPvbsEhHgXSmOmVbqk7PX7TFLHzm8jq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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



On 4/9/25 07:48, Arunpravin Paneer Selvam wrote:
> Add lock before accessing dma_fence_is_signaled_locked.
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 24d19b920100..d5b35b5df527 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -259,11 +259,13 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +	spin_lock_nested(fence->lock, SINGLE_DEPTH_NESTING);

That is clear incorrect use of spin_lock_nested(). Why does a normal spinlock() doesn't work?

Regards,
Christian.


>  	if (!dma_fence_is_signaled_locked(fence))
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
>  	else
>  		dma_fence_put(fence);
>  
> +	spin_unlock(fence->lock);
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
>  	*f = fence;

