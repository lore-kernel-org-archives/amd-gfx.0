Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E2CC5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80DC10E609;
	Wed, 28 May 2025 13:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pmWN2muN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B9810E609
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:48:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4IXglGWBy/o1GKQnVRRQH+SJEFsFZ+4qrqrAsLxj56CEN74HyEmBtaxfJhSVDYd4N6GamqEGSkQ/yXgN25yLKqQYG3PMPuQmbkwOL02V7VV9vaoZ436tkGXLy5AIT6jcP9p/7QUINnF5iH8i/VW6e4DyiURrgsWODT5GJLSKccmTB0+IsxVjlLXoNra3Jkcw+IGCBj3RGsRLnrZfoaS6RzEFN4yCpFJpXZUb+Xt7f5zhXTw3MDd5Lbw7lmVKmZ+wB181mk5GgQazgi0zT9R4qSoYt1kOzGGyclYnh/6PIhIuj5MvGYMRci/YSyC38A14VvXP1rZoFUzAhGVdJaecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FcTJnXPTc5H2ehGds0vHALqVhA9QiKgYeZV+MsgF88=;
 b=qfi+B7rSWAg1+mXoEbIcAG5D+GoWaF0t3ZdYHgXIgz7DsLiGSp7lXlWxogSKq+5PDjewUq/RuDqmStP02oKPsj+r6iGahKJ31lAQRVXtdOJbxyRLjqbvDHh19+VfEF2viyNqo+a7EZVOuRHtj1E1W3f5hYrcSEoAL+W8lyEhEIjJL55JapjQQiXivG6wdfiH8D6bIY410e4dy1+LRTaY+98kT6EqgqifkQ/gcrjaOCLH7xe8Y72rzi14YIfHuiayxUU0HP36N+WakqQcf+0JzcDNYdf8sox+JRo5VuHHTw1CPqHIBnNdrYJ7ik2uvUeECgTYHLClUl5vCBqoOiZJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FcTJnXPTc5H2ehGds0vHALqVhA9QiKgYeZV+MsgF88=;
 b=pmWN2muNZmL9UA5BWcIBkrE+nhxsT267+IgFiNjxWaEt8D1sBF2MN3WtKXH5di61TmW5eg2mF8F9MmLhnoQqmjoBGF84wTgTl3ouCj3DGZ9LNqojUgeP2VN/08/yiBFypOTc9PVa0H+nkl0WzaEO+800GXlh/ftzxZLiPBhpWCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 28 May
 2025 13:48:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 28 May 2025
 13:48:15 +0000
Message-ID: <95cc9164-85d2-4835-a393-0bf125cdb254@amd.com>
Date: Wed, 28 May 2025 15:48:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] drm/amdgpu/gfx10: re-emit unprocessed state on kgq
 reset
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-13-alexander.deucher@amd.com>
 <a85033a1-aea8-47a7-ac43-7e5c4a5d134b@amd.com>
 <CADnq5_M-0ziR25s-FyiiFWi5D_R6ntNkUtB4sTnKnDMNJdGSNA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M-0ziR25s-FyiiFWi5D_R6ntNkUtB4sTnKnDMNJdGSNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c2358d-5dd3-4d76-63bf-08dd9dee4b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk41WTVmV09OaHRYWGpRUmNKNDZNWEN0OW8vOU9aSVhWazE3S2tGNys0Q1pa?=
 =?utf-8?B?MWZhY1l4L01oN1h0NXJZUEkzY0MwRHdIZEJzdWl3bVV5THR5STZTTm82R21Z?=
 =?utf-8?B?NGV1NUZ6Qzg0ZXFiMVRIV3ZkZThNanlsQTQ1M0xUY3g3NTBzZ2dyV2xsa0Vv?=
 =?utf-8?B?Uytlb0ljM2JNenVWQVptR096b3lxTTM4WmI4SHhoVVFNcVYzRU9hVHV2NW94?=
 =?utf-8?B?S0pmeGxlUklTM3FKTVdBV3R4dU5LMEp0RngyQzFpbmVlZS9BWjRDaFVMeitR?=
 =?utf-8?B?ZS9KcFlFaDZ1SUNCU1ZQRmZGUkFXVGxicGRlSmJtNTY4azFzMFg3L2lPajly?=
 =?utf-8?B?NDJKelpmbEE5amtDL0JiVEo4c05BQm5DcEkzREF0QVFKd2JBenFCSGE5TW4x?=
 =?utf-8?B?c0YrMFB3SnNOWlNvY2tIT01kUE1wNnpoK2lEY2hDaklKWVRBWHR4QlJ6dVdH?=
 =?utf-8?B?VTlKUG92eDVRQzdHRm5HRGhudnBxTFA0VWR4dEVVVUlvV1ViZEx3OG4xQndS?=
 =?utf-8?B?czBjbTFTL0xyRHVrcEV1ZnBrOUtOWEg4QW9XcC82S3Z1QmxESkgyeTNyQk1l?=
 =?utf-8?B?b3dVdGtGaml1Rzl0Z0cxQW1CbmpLY2ZqUjhzdEJRSC9rblRqYkk3ZnpBV01B?=
 =?utf-8?B?VGdqSk9TbUpZcVoxL0h4RHhZcFpiQnVwelFRVXRDRU9pNGpiSk9CK0QzV0pw?=
 =?utf-8?B?YUp6Y1hxWWM0aFZHblNqdkJOVEN0aWt5S25MZHcyVWRNSXkzQVlWaEw1UTVy?=
 =?utf-8?B?aEZ2YWcxZ08zMmJzb2JwZU1VUzd4RDJ4UkkyWjRjaEhqZUhoVlJyRGU5M3VM?=
 =?utf-8?B?dXJld2d5bVBqT2hKdjc2Ny9VQ1JoQkx0MytBZHBzdVhSS3h2SEVQVi9PMUQ1?=
 =?utf-8?B?YVpNTE8wZm1YTnVDK1Y0S0NnL2tvVWsxRll4ZldsdmVtaVBYSVVHazVUTEt0?=
 =?utf-8?B?bVUwYmFqbHE1RVNwcm05UVkzL0lTZmdNVzV1WTR6blFFelBlUHZpV0tTdTdp?=
 =?utf-8?B?ZjRkUXJNQnlwMW01VlNGdC9OZWp0azliWlhoZ09oRmc2RklLRHIyN1Y3WmJo?=
 =?utf-8?B?L1d6L1llYkxvUFRxc1VXNjNtQW4yZUtacU1nalZxVFU2bVJ6UlQybnNWOEEw?=
 =?utf-8?B?WDJVU1JzdFpSUjVmakprbHNtQlFKdnA5Mnh4ZDlGMDFQdmxnT3NEVm1wS1pU?=
 =?utf-8?B?cDBCVWVwZGlFSnNJYkZZOXhlNkNHMW1xZ1k1dnN4RFEzZHZRR0FQYVBISk9X?=
 =?utf-8?B?Slc5MG94NkQ1SU4zV0kwSjdFbmYrYUxnbHBWdHlVOEUvazhDV0tOWnhxTU8v?=
 =?utf-8?B?LzRyY0pRejNQZXBMWGpzTTZ6MGFaZ216MWt4TFV2cDNYWjZKajRoZkNBTm1H?=
 =?utf-8?B?U0JGZTl0UE5WR1FnVE41cnZnQVJzSVRMK09IMm0rK0xMWUNJOGFjcDNzU0xY?=
 =?utf-8?B?Z0w2NFEvSmhOa0JpcWhGVFVIejhDNURMUmdhT1lSTmt3UVVhNVdIdURpYnlQ?=
 =?utf-8?B?TUl4NFhJdG9rS21JWktUSWpLVWhJeTRTd0JNR1dzdnhIQ3VPVmo0QTl5SGs2?=
 =?utf-8?B?d2Q0eW8yTm5wTVNrTkFDdU1FZUZCRzhpeUpENDBhdTAxSkZWNlpEMnhUblhr?=
 =?utf-8?B?MVdta3BNWWVTZ2NyZHRWcjVxRDlnM3VxUnB4WmdTUnFwN3h4cE9Cck9XOTJp?=
 =?utf-8?B?UUdaWWY5NEg2MSs0K2t5N1J1cGRqQ1JPRndmSVphSXJhVU10ZEw1WTBMTjAr?=
 =?utf-8?B?VGxGeTFJK1pPVEdWZDhDb3BuRlF2Y3U3dGpDZG0wMU9UT2NqVTArVkNBWXVC?=
 =?utf-8?B?S25Ld3BCb2RaVWE1TGljZmlPRXh0UDZUL2ZGRHhuN1FDd25aMlZmbWZiRGxG?=
 =?utf-8?B?c3MwK2RBWmRwaHRUdnB0NmF6YjRVSzgzUU9odzAvKzdJQWJVYjl6TTdnUVlt?=
 =?utf-8?Q?LbK7wJ3rLv4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJuMHpCU2FlR2gzMlNuZ0thT0Rja0VFa0N0R3pXSkx6eFVLM01CK01vdE5H?=
 =?utf-8?B?K0ppV084cnZhYzBON2dSWGZiVkI0VFF1MDVpeVZMZ0hwMnJjeitwUDVhQXJz?=
 =?utf-8?B?RXRhTGwzSTROU0VMNXlML2VCWWRvTUkxN3ppVTVuUUtHbi9OZFRlUUFQWXFL?=
 =?utf-8?B?SWxISWpuckpqck5ISEIzTG93UGE5R2pndS9lSngwVVVjTG9uaEQrdVBjbTk5?=
 =?utf-8?B?NWRlTGpQbE9KdG4zMHJ2MVpKK3I0R0JEb0YrRW5aRlN3MDJZQTFzcllWK1Br?=
 =?utf-8?B?eGJaWlM1eFIvOTRxaTJDMjArbTJRdEJjZVU4dXpzMW8rOE5GUmdEbmFGelNq?=
 =?utf-8?B?K0pZV1VIOWYzSm9GeHhreko4c3JsdkNXZ2hRdlpiSEVIaEhva3o0NGtXS0Vm?=
 =?utf-8?B?cG1tYlJoaWNtWk1lVG1ZV21JSXp4UTJyUWRqN0J2WWdvUHh1OWhFSCtxVTcx?=
 =?utf-8?B?OG1rVzYvRTkvOUtrM21Tdm1qTDZoSDZPT1lJc3hiVlRoYlpYQlNVdWUxWERZ?=
 =?utf-8?B?Umhjdis0VUw4NExYM2FJZEhiak8yTHk2Smg0R29FckdnM1c4dmZQamthWXZu?=
 =?utf-8?B?Nk5RRk5HTUVKNnNrcWxtemw5dm9GTWtBMGRTL1AvdW8xT1NRWXY4Vnh4NHRX?=
 =?utf-8?B?c0duU3FiK1pvU2JwaTFnV2wzcFNGcG9rZEtiQmo2bG5sdk84WTFuRG14Q1I4?=
 =?utf-8?B?eGZod3VENGpVcTZzd1pvaUIzTXl3UW8vbCtiVENuNWZLNUxpZHZQbzRIU1Er?=
 =?utf-8?B?cEVHVkVNL3ZpOCtKM1gzWXgyUnhQckt2VVNVQm9Iays1RS9EeWszODJUdG9p?=
 =?utf-8?B?ZktzRlc0STRMcjc4b0lMcHMzc25aR3hGY3VhOTBaM0tHcjBpTk4yK0ZyMk5r?=
 =?utf-8?B?bmxFa21CaW1hUFVCWHZZNVlRS1h0Q1VDbkdkRjNldUVDcGpsaTd3WXo3VHll?=
 =?utf-8?B?U3JMd2VrajRacy9QbVlvU2dMRTFPMi9oTjdUOFRSMnlZd3Y1UXlmWm44cFc2?=
 =?utf-8?B?djRzWUdLMzlxTDZBZUNJcENQaU5mQTJTN0lMdDlBN3JwY3U4TldZVkRSdlJF?=
 =?utf-8?B?aWs3d2pTejhWb05wejFIeHVvSjZIbzdoOXlKNmw3QlZDY3h6YlBJN3ZBdHRG?=
 =?utf-8?B?TTBPY08vUWhqMDljTGFhZEZ5dFBIcHdIejBmYStVMXIvVll3TTFqQ21lb0dZ?=
 =?utf-8?B?cVIxZUYvTkJUa1E0dTFSSnRUVkg5UDM5cm4yOHQ5eTkzSGhIY1hsSXVOdUVI?=
 =?utf-8?B?M2RmTzRFWUJ6MzB6NzNlU25Cb3QyVTl2OWYyWFlUNFp6bC9TdWo3Wk1FSndj?=
 =?utf-8?B?OFB6WkZvZHk5Y3JGRmNxZm1RUmFyeE54d0ZBY2JmcXFKV1RGa3hpdUlmRTNZ?=
 =?utf-8?B?b2lIZDZUL0lUc0JPMFV1WDdaMTVlelA4YURPYmtEakVIN0pjWEdFamZmcFBx?=
 =?utf-8?B?TE5TMm1tOC9xNFhueXZ3SlJHamFNdStFN0RsVTBNZ1BSVDlsR0pGRmV0c280?=
 =?utf-8?B?YmtBbWpaNTFLeFE2K041WEVoVmJ0RlFRYU1xM0hJUjJvdUp1dldwd3l0K3JU?=
 =?utf-8?B?aGczYmlJYi9JakhDVWM4UmhpLzVaTVE5UC84S3pHK0dGTnhsUEU3S042YzNa?=
 =?utf-8?B?OUF3ekM0TnZvZlFPcFdzU2VqOStTYkh1dzFKVlB5TkxoNTV1VFN1c2RYOEFG?=
 =?utf-8?B?QkhBMG4wUEE0MjdrZ1dSZGtDUkQzSXZXbzE1M3M1bStITnBnYW1ERkJjZU5m?=
 =?utf-8?B?WWVtVTgyZnV2KzFKNzhWY2U0U0xadHkxTnhodHVlMDZqVDV5NUpHMHMwbHRM?=
 =?utf-8?B?ZFpyYmNVL3V6cVI4NVIycWdTZjVUTWpMMU51aFhmVWJwRXA0MUdKNnd1OEpz?=
 =?utf-8?B?VkVlbFY1SGFiaDc2bFM5UHZFRnZqUFozdUxQVHhjVWNHRjI1K1V6UnZZeldN?=
 =?utf-8?B?VVlYd3p2T1ppaWcrdS80M0R6ditBaDF0SU4yTGhpSDJsMHh6NmVvL2RyQXFv?=
 =?utf-8?B?S00zYnQ1NTVPYzJFbXZrSWFLMHlYQ1p6bW1oOGo1OXJlbGZ5Y1RpVm1hS29G?=
 =?utf-8?B?Zm5OVkJ5UHIzbUVhOElObDhhSCtOMjEyWGpJalhvVlV2K1NZR05zMldMOUUy?=
 =?utf-8?Q?2tsmab9Rx0aq2qGd4VaGGyYXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2358d-5dd3-4d76-63bf-08dd9dee4b69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:48:15.1639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZF3ET6f0AoA5NCNjX1uT+eezzm7qs44x4Y37F6JLwOAr87H2RNisWdMsYAGoXb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

On 5/28/25 15:38, Alex Deucher wrote:
> On Wed, May 28, 2025 at 7:40 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/28/25 06:19, Alex Deucher wrote:
>>> Re-emit the unprocessed state after resetting the queue.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 3193eb88b6889..f6e04cf21abcc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>       struct amdgpu_ring *kiq_ring = &kiq->ring;
>>>       unsigned long flags;
>>> +     unsigned int i;
>>>       u32 tmp;
>>>       u64 addr;
>>>       int r;
>>> @@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>                                    SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
>>>       kiq->pmf->kiq_map_queues(kiq_ring, ring);
>>>       amdgpu_ring_commit(kiq_ring);
>>> -
>>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>> -
>>>       r = amdgpu_ring_test_ring(kiq_ring);
>>
>> I don't think we should do a ring test on the KIQ here That basically doesn't tells as much and might cause additional problems.
> 
> We need some way to wait for the KIQ submission to complete.  This is
> a simple way to accomplish that.

Ok, that makes sense.

> 
>>
>>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>>       if (r)
>>>               return r;
>>>
>>> @@ -9584,7 +9583,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>               return r;
>>>       }
>>>
>>> -     return amdgpu_ring_test_ring(ring);
>>> +     if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
>>> +             return -ENOMEM;
>>> +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>> +                            ring->ring_backup_seq, 0);
>>> +     for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
>>> +             amdgpu_ring_write(ring, ring->ring_backup[i]);
>>> +     amdgpu_ring_commit(ring);
>>
>> I'm not sure if the commands are always relocatable. We should probably just instruct the ring to re-start with the original RPTR/WPTR.
>>
>> That would also avoid the need to save/restore the ring content with the CPU.
> 
> I tried that originally, but I couldn't make it work for a few reasons:
> 1. We need to have enforce isolation enabled otherwise we almost
> always reset the wrong VMID so then when we execute the rest of the
> pipeline, we hang again.
> 2. When enforce isolation is enabled, we need to signal the fence
> associated with the guilty job first otherwise we get stuck waiting on
> the pipeline sync when we execute the rest of the pipeline

So we execute the guilty job submission again? What prevents that one from running?

Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +     return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>>>  }
>>>
>>>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>> @@ -9612,9 +9619,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>>       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
>>>                                  0, 0);
>>>       amdgpu_ring_commit(kiq_ring);
>>> -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>> -
>>>       r = amdgpu_ring_test_ring(kiq_ring);
>>> +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
>>>       if (r)
>>>               return r;
>>>
>>> @@ -9891,7 +9897,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>>       .emit_wreg = gfx_v10_0_ring_emit_wreg,
>>>       .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>>>       .emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
>>> -     .soft_recovery = gfx_v10_0_ring_soft_recovery,
>>>       .emit_mem_sync = gfx_v10_0_emit_mem_sync,
>>>       .reset = gfx_v10_0_reset_kgq,
>>>       .emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
>>

