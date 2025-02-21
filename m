Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC6BC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0A010EA8C;
	Fri, 21 Feb 2025 15:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BHY/4NYq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E4610EA84
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI1lk+bjcdNrs6HDhX4WAh/UqHX8QF6RQan2BbHYovT+0eRZbGPvoAdSPqO0W/Sb55+BHHH0fvGyTdSekBsp5DQYpKH9unhIclFqrZiWY1vR0Pzkuj4GneAcJGyOBmXc6eZPp3T7rpgza9ufpEGbr8cwvySdfjuwpbNZsyehGxPiM5/9oZtMzBxKMrIq3GbEkSFOpFMMJ38uAb8pB3ZaB43Rer7GdPnps+2Ma39O1NluEhEG+jLQIzPUcuClUag4/71uvoFuB68SFlNlpz7IxbdYf6uXu2oIb8jJGAOJZxdbKmAj7nFt2zByuF55CF8mq2GxXrFtmsCkaIpQu+Ol2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wy2ZZNRLpLithp6/ocHvxjNadoOTKNR5c2/nQd0SPMw=;
 b=ln/mAswW7OQmidScRONtgMorJAV8WLeG1fGVcDDHn6ex4w5Z1kyjNwZ/sW1tBT9Etz8WA3ESYNcIGg4QIupe4Pa3PTHyHtJrNrZAzAzUD7/c4kDmhdIwcNUA/3weZZa9HcacVBChGr0aoc9N44g6XxsJVjTZwJmfT0n70DIoP9ynMdcSRVz5TH4kI5KjLHP/usI9ObeBhx+1fukbA/Gs5GNpDDJ4UUVflBaUckLVjicSvJJY5XMqs7TRJ0dZXVONP0MdE33VobaW6pjqkL8yG7lCvqfHoJW6FEzXrpn2Cj0QT2b3RIbjkg+GqGV4N81pBXh4CZqYGTQKJi9OTbb0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy2ZZNRLpLithp6/ocHvxjNadoOTKNR5c2/nQd0SPMw=;
 b=BHY/4NYqexVkrg5BHsy/RT2SHm3kvvdOYtAttloy5RDZPSgr3RNmvDJEiP/oqcssasoHacuKqS/oTg0rYQpmrx+z+S/9Ux6zOEm6SnPuvbatP5YxsskYyWdtQJGUTUUnC4clhopIYaImSoNxD+0MzCZLGJ2DPogNSRFIyTm5imU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:21:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 15:21:19 +0000
Message-ID: <7111f80b-1de1-4922-8fb3-f9542a7843f7@amd.com>
Date: Fri, 21 Feb 2025 16:21:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: init return value in
 amdgpu_ttm_clear_buffer
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221131734.37754-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_O1+FnWcq_-rhfmfuVxg2Ux-CB3HOd+JWv1aQ6NJdUuGw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O1+FnWcq_-rhfmfuVxg2Ux-CB3HOd+JWv1aQ6NJdUuGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 78531224-39e0-40cb-cbec-08dd528b646a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk91eGdhYlZybVZISi9ib2FtR0g0czhRbEE4OVVxTXAwZjZCUXUxVm9hVVJ6?=
 =?utf-8?B?VEM4VVFPNFd3K0hQTGxoSTVQWTFHUFhzc3YzWllmdWJEd2NpL3hjdk56VjJO?=
 =?utf-8?B?Vm1VdjQ2T3E0dTNtdlNqM09BN1hxWGdHd3l5TngzazFBVGxDcFNjRGdySlVi?=
 =?utf-8?B?VWx1ZU50SUt2RkdGRkRHRk5CUmIxSDYwb1VraThNcXlscHVGcnRFYU9XSGMv?=
 =?utf-8?B?QjJtOTdWMytXOUd5dXFsWE9ibCttd2ZDTXJwdXZwTFNkbU1OZUZWZU41Nktl?=
 =?utf-8?B?VkZRczZtTGNuZWZZYWhSUGlYQUtHdVB0TkRmMnBzL3F1MUFrN05ya2ZIaG9R?=
 =?utf-8?B?eHkrcU1SMmZSWm9sa203NWVud0Q3bFM1SXZ6NUllcFNXajVWb0x2Q2VucC9G?=
 =?utf-8?B?ODVZT3djOUFXRTRHV3oxRlpJazBCNUhJajNhRzA4YThsQUhYUXFyRHJ1Y3ZH?=
 =?utf-8?B?bTl1VlkvQWU3QnNzMHBrTDcyZVlVZlEwYW80WXR2OG9la29BQUFnYW9QUE14?=
 =?utf-8?B?SForUEVnaFpzRWpveXQ0UU9sTC9lWHE4dExQZ0xXOFJlUWNranV1SXcwNm1K?=
 =?utf-8?B?ZDNSYnFSK1NUTGhhQ2lyUWhUcjM0WVBXVC9LWGVkbWVMNjk5RTBwMEI2ajFi?=
 =?utf-8?B?V0RCZVdhblgzRGxFdVlZY09LMXk1OGxTRU56RDY2dzlyaC9KNVM0c0VQL1pl?=
 =?utf-8?B?Y0dLYUlaaEQ2WnhROGRCeTJDN09mNGtZUlRLSjVuMC9YNnUxYVpLMWFHS0d0?=
 =?utf-8?B?NTNLOHpGYktLN3ZVa1IwVzJJNTByaUorSXdzY0VTeDFsZW1SOE1LMGlnZWJE?=
 =?utf-8?B?U1lqaEdqRDRHMEpDZmxtTTZ5SGttdVdtYkdBSlhMby9BUHMxN2ljQ3dBQ1Fz?=
 =?utf-8?B?TExHYVJFQldmb3RNbTlpZmY4RnlXRno0RVhqaDUvZFJKNmc5QkNudWlnR0pS?=
 =?utf-8?B?MEFTc2pnYmc1ZGRoYjdaVWdSS05lYXF5dzhWcUEvU3lzc2FqSWI2OE94bGtO?=
 =?utf-8?B?QzROZmZMQmhsbk1tUVVxUjNpbThwbHZ0OHArZEg1UnBjRzZNaHlOQytieHcr?=
 =?utf-8?B?dFRjeE9lNGtiUnV4NWpBZWlXL3FKZzBaN0pPZ3JRdXlGY21vRVRpcC9FKzRh?=
 =?utf-8?B?dm5aR2t4TUJqMlhxeHl3TzJGaHB1eU9qNGxaVUlFcFl1d3d6aTRZZlFqT0l3?=
 =?utf-8?B?UjNOT2tlWHkvcnhVR2FaZ0xDcUgyQXA3QktDdHluTWdWeldhdFE2ZWNabkZY?=
 =?utf-8?B?ejRZQ3d2ZlhOV1VLWTVnQTU5cVJYNUpyVEFLeVJwWjZPaDZBY1kyY3BWLzRm?=
 =?utf-8?B?N0JQZkpEUTNlSEptT3NjUGxwS2l5YVpnZHNKam1lVG02aFJGb1Q4eTFPYXlL?=
 =?utf-8?B?SWVLYWVCR2xBeHErT2RjVDNYcFZLS0pQQzhmN1hjcG8zS2ZFZXpESGVqVDVq?=
 =?utf-8?B?anIzZXYzVzhzVjJSWmNwQ2pHK0dNVGlkWmRkVy91OXRHNDJVNksvdXZiajda?=
 =?utf-8?B?MDYydW8ybStIMUpDVVZmYnNMVW96NXhJRjNuaFJNU0xJT24wSzJ6dUd0REFV?=
 =?utf-8?B?eXd3QVdLcEc1K3AvdUhlS2ExdVQwd3pRbVU4SVpSTTJwbWVsZHArTE51WnB0?=
 =?utf-8?B?dTBYdU40aTZ2empBYVplMlE0OU1PdHJNL1lOVkh5MHVmRmFpKzJFZGdYcTAy?=
 =?utf-8?B?SXR5N0JTZVRSckc0N2Q3OHdESlRXVE9GUmZuQ1hrYm9nSGZEMStXKzdPV05q?=
 =?utf-8?B?SG8rMTN1Wk42aGUyVllVbkJBeS9UWkV4aEZ3cnhSb3RpYzF1Z01UODcvL0pq?=
 =?utf-8?B?NHVWd2NSdVdXQkRUYkxzMGZCWkMzcEVzMyt1NEFWekNPT1RYSFZJRDFQYzNV?=
 =?utf-8?Q?eD59553riuBmu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1RYSTgrUU85L05PT0hYNnRTMGxlUTVGSmY5OUZjT0pLa0hNVllnblVGNGFQ?=
 =?utf-8?B?L3VjaUE5WkEreVRpN1pyZXBaN2orZFg1Q2pnY3VKTk9BTzI5R01JK3lnVldN?=
 =?utf-8?B?M1g1ZlhqK2NUeW9nZ01jVmp4K2R2cjMwMUJYRUtaMm9aUDd3UVdPZWczRDVv?=
 =?utf-8?B?QW40dHZRM293dG9GbTdCSzIrNTVXa1JNZkFHVGt4VHRBVDZzTnFudWoxZjli?=
 =?utf-8?B?RW1MRmVkWEl0amd3Y29MbkZjU2dXT2ZhQWFsS0VjSkJrNUN5eW44Vzdubng5?=
 =?utf-8?B?ZVkxZVNheG9xUGpMNjRORkNVRzRTbWRpRjJTVnVFdmx6VkpmZDZ4TGp1QWlG?=
 =?utf-8?B?U3FYb0IvRTljSU5McUpHdldXNXVXeUxZbzZkQ0I3d1JWajNpUzFtaldTT0lR?=
 =?utf-8?B?dEliajlRS2l1MmtSZEZLNklSM1dib2lTc2w2Yk8zMmEvOGVXWTRTamUrdjVL?=
 =?utf-8?B?S0VSS0czakR6UmVRZlpkRWNqdG9nRDlVdnd5d1JEOEN1WU84ekJyN1N3d3JS?=
 =?utf-8?B?cm5JSnkzanhUMHYyKy82Nkw4b1BXbDFLLzNwWUswNVpicUo2UTJidldJWnpk?=
 =?utf-8?B?YVZXVklJQ2NyaGt4dWdzS2lkOXdrOWNaSE5vdnR0dmpHRUI4ZjJqY1pUODZz?=
 =?utf-8?B?cmYzR0lNSTZhbkZOeVRkOXMyQ3IvSzFTWTJQeUcrZlFLYlNueEdLOGtWM21M?=
 =?utf-8?B?NjRGeFoxYnZaQlhKT3d2LzZ5eUE3Y3J5dm5JdGl2ZGJQRW1xcjl3L0hTMzJF?=
 =?utf-8?B?amtJWDNsdEpJTGszanhsQytWNWIySS9zVEh2QnREQnVzWjUxSjRwZFVPRXJt?=
 =?utf-8?B?TWI0c1hzQkZxSzBzYXVOTlZDaWFibEJnRS9pRTJUMFRJM1pEYzJZYzUzakw1?=
 =?utf-8?B?K2RRR3RLMENwOWhsYlhJcFhISFN3TFArbGVsNEtEdU56c3ZITFhjK2xoZGM2?=
 =?utf-8?B?K3I3aHNuUFpiRmlVVFU5c1dteDQ3dWlZM1ZvdWpIT25UREQ1YkloQVRjYldQ?=
 =?utf-8?B?cHpGY0xRdEJHdDF6WG9oSG9YTXJDWkF0RGNYT2FJeE4xUkM1SWZUaTlUTFpI?=
 =?utf-8?B?WDBmRkpVK243WlhOem9hZVpMLytuSlhFTGlmbUNIQ3FZRnJaWHN1ZlY2cEV6?=
 =?utf-8?B?UE0zWWVpd2Z5dDd5Sjh0dmlTdjFoN096RGNOeC9rUmFyV1NweFlabS91V255?=
 =?utf-8?B?TVNZSjhHMG5rUHJPNGd6WW5ua05JWGlyQnBqYmxiVHN3SFRmbHA1azVvNjdh?=
 =?utf-8?B?ZTdUNlVtRWRvZjRMclgzZmxWeVN1amVpUnpja2h1Mzg5ZkFOUXVLa1IzZjVk?=
 =?utf-8?B?T3pXRVJ5UmZIS3FSbHZuY21PRkMzWnZ2S29qVUtTZlgrVXlHSHJRdmZkMkEx?=
 =?utf-8?B?Y3M4VGkrZ2NrckZkTmRlT2pkVWhBVlk2VlBDQXZGODhoUWFMMXpBV0prYmt6?=
 =?utf-8?B?YmZsVjcyQ0w4NVBLTGFPbFNDUXQrdTBVNHdieHIwNlcwS1JsaDRkS0ZKYkt5?=
 =?utf-8?B?OTU5MzdsbE81UGgzc1dLRWhhN28zZjNKT096WVhlenRlVmpoRlVwalhwbGxl?=
 =?utf-8?B?c2xGNFYxb1V3ZDI0SXNlQ0Y0cFZXZ09QV2l3U2NSUHV2VXFaK28zNFNDeFdW?=
 =?utf-8?B?K3dBemNxNnk5Tk1oVzMxQURjNjNTZXVkVy9BVWtqamd4WnZkWHpsQXNxSlBs?=
 =?utf-8?B?OXlIUktaVnZ6WEM4WEtHTm1hbjM3aVUxdGxmSjdBYmRQcDdsWVpaOWo2aHQ4?=
 =?utf-8?B?cDQ3RklSWjg4RGwvR0JMTnkvZjBZSS9NYmcwVFY5WDVsZTRkdmg4WktJb2pU?=
 =?utf-8?B?SGdVTGowOUdFNEtyMWVpcHB2bzdZV05DT25uK3FZb2pVV1FOMy83cXE0MkF3?=
 =?utf-8?B?dm80MGVXQ2lqNVpoSzR3N0dlZHFvRi93S1VrL3dNWXBWVHZLclc3ajZkTlhV?=
 =?utf-8?B?c3FzS0ZieGFSblNHbFFIWDAwRTE5UndTSmxkWDFhbCt3Q2JjTEdLd2VzM051?=
 =?utf-8?B?dDBNa01JdWprSld4cUh3TXBPTG5ZelhrTFVTZ2FJVmpJd2hPWUVNUDNzQlJu?=
 =?utf-8?B?MU5nOFgzbEJWbytOYlN0akJXVWdNd1hmNWlNNGo1NDVaZXVzMFlhKzFScnlB?=
 =?utf-8?Q?yAcg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78531224-39e0-40cb-cbec-08dd528b646a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:21:19.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXmZeqktTrzEO2414j+xwEUi+jU83fiOT0lY2Ctqk/YTtFXpjMxQQx3qMsBk78y7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

Am 21.02.25 um 16:16 schrieb Alex Deucher:
> On Fri, Feb 21, 2025 at 10:13 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>> Otherwise an uninitialized value can be returned if
>> amdgpu_res_cleared returns true for all regions.
>>
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index a30985c8f539..e8d7c23f22c6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2295,7 +2295,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>>         struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>>         struct amdgpu_res_cursor cursor;
>>         u64 addr;
>> -       int r;
>> +       int r = 0;
>>
>>         if (!adev->mman.buffer_funcs_enabled)
>>                 return -EINVAL;
>> --
>> 2.43.0
>>

