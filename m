Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9FFC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32A510E207;
	Mon,  4 Aug 2025 13:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BzKWjK2P";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC3610E207
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi0sMWHRU+cnbGJDZjVqNVNZP9Ltgf/6W3k/4SqTVZD0uO1Z/eHzBlpIRyCBLuT0me58OZnAhW31n+OI61rVZfNfNvrzXfnBJOa94J9da4TfP04vlwLbH69BKU7jXKtI5dMZph0sUUZ2hJpa5Pjp4t9L/Q8UxoDVXBaXaDMq3mUeHNcWcGp53ka1tydjmt4RuEVP4D/3aRIMGKbHdblhgpYXFuB/f+vqWDeAJ5SDXZdquuyyzOOjJWMWJFZBDH0rmr3yqHg2lrx4mKHmtKgBUIxI4xgAFTKUZtxWhGcLtiACVhQ/54RYaxVsI6jUJ8VRVJ5I9c9Hj2hFDFNFYNgzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G20Q+00/CjeUunwnRctk6a8dmD9l52zQkSXHseoKDj4=;
 b=b74CB9EvM4AdEpJpSWgkKAczmRaceA6jJcxZy027WXcMEwNXh6IsJfWdeTmoe7lNSD264CGoQjhfZR282pYw+fXcYBG87Q/FWnxkexgqpWZA7DBM9LPDMSwVYRAnkI0V2fJX67SPD15NeA+3HnAOjOIVmN++qUsz3plVu8l5tez2U0MCUr4kLoI21JgZ0EBIVrdaPcDelwf8weIU9l6A5jExP0zqFbWCXhsDUmfajeCk7RE487wjCXtsO6nQaUq+EoYV401NNgp/1eI45P720FW6WfJMbR99y/UU8igFpt66ziMPjBCwNXKIPRoy+3dHxVUy+kZNPX29Th0blF97nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G20Q+00/CjeUunwnRctk6a8dmD9l52zQkSXHseoKDj4=;
 b=BzKWjK2P9cyt1RqKdtappILPnXyg2yJFfJ+8WVF6UkfZi3+1cEj//tS4ngJZ0aN5FzjRSg1cxwnxHrYbLHVC+UmRwz6h3Pm7k5TlvfdptP60mAdj4Di8RIVFFwmmFckaRLqw4JopSD+w5CxdOQbkbqmEB6giU5fZryW4glMElnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:36:50 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 13:36:49 +0000
Message-ID: <4827b012-4bdc-47ef-82d0-1611f211f75f@amd.com>
Date: Mon, 4 Aug 2025 19:06:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] drm/amd/pm: Fetch and fill temperature metrics
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804110539.637463-1-asad.kamal@amd.com>
 <20250804110539.637463-4-asad.kamal@amd.com>
 <d26ca6d5-e715-473c-b808-c6fb149ca8c7@amd.com>
Content-Language: en-US
In-Reply-To: <d26ca6d5-e715-473c-b808-c6fb149ca8c7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf6be09-c537-4607-1082-08ddd35bf699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFV4b3NNSWpEeEZiNFE4cTZVcUFwN3Y4V09Sa2dhU25UQzBNeXR0Q3VXVERJ?=
 =?utf-8?B?REdyYTdKbnFjblpHU001QWg3Mys0Y1J5ODEvbUtkMXZBZjMrZ3pwbjJJV3Zx?=
 =?utf-8?B?eDErNnpxN2ZxUUo4MjZlU2VhdWh6dUlNVWVBcitpZjFIb1ZYeG1jbHZnQWh5?=
 =?utf-8?B?bUQwUCs0aUVGY1JHYmsvUldnL0hzVTFxdGFkL1ZXTVBYTERudzFCS28yRGx1?=
 =?utf-8?B?cEhNejhCTU9NelQrUGwwbUo0TVpvZllTOHhVUmVJdWk5K2ZNQWtjNFZEMEhU?=
 =?utf-8?B?SzJZcU5XVTBHWUkxRnorUDJMZHpuUXlPWEQvS1kzcENycGRSZ0hialhYUUNJ?=
 =?utf-8?B?eTRRT0h4bnBadGRQT3VoNmMwTTY1TXBGWEJVNm05dTVzTkJZcEV2OEJ4bmU1?=
 =?utf-8?B?RGxkVHlRQUdPakw0SnppS1M1dEtGZk1uMWhibURVRGZ3Zjl4aFZEa3hpMEhK?=
 =?utf-8?B?NzBiZEZQSllQUjFSMzl0eVU5NXd1R1ZTalNRQUp5QkxDTzRoUUFLa0xXak9Z?=
 =?utf-8?B?dXRLRElFYlYzTWdZSGdKdjVQNmg3bWwxL3c2Q3dUak1YSkVnYW5MbjZDMi9Z?=
 =?utf-8?B?azRlOEozcUpGQi9tR05xbWhycVhtQnJ5S3RKcWQ4RVBzdkk2NE5mTUNGYit2?=
 =?utf-8?B?eFU2L2FzNE5xQmUvZ2ZUSFgybUg0WU1XL3BsMVFtaGQzbVhMeHdwNDBHaWxY?=
 =?utf-8?B?L3RoSnVNK08vemhMUFdLZzVzR1U4akNYZGdvVytXVGZpd2lzVWFZODFVWkU1?=
 =?utf-8?B?RUJKc1VwVFJPR256cE4vOFV4T3NWbXFobGpaQjc5UXRvMThDQnVjd05lUzZK?=
 =?utf-8?B?UnVVSjlhTUtRT0diZ0x3Y3lDZ0pNbENTOFFqOW5WbkRCa1k2QXJMUE5wcUUz?=
 =?utf-8?B?L1RBRW42VnJZbkRFZmpyK3hKUURVTDQyMzJ6RFBtb21UMU1qWS81S2Nod2Zt?=
 =?utf-8?B?ZHFjdmVtTmVraU1WZVlyb3pWRTNTWXdmeUNhZXFvSkgzREFrd0kzTHBHNWFV?=
 =?utf-8?B?T3MyMkFwZ3Q5dmJ4SU9RWWtOd1N5dTRQSW5qUU9UTjdmTUttN21YbEl1Vm9R?=
 =?utf-8?B?WVN6RHNRelRIcnBCUVM5VDhMRFNNeUp3OElONHRaVktPM1M5WWhTbktNajV0?=
 =?utf-8?B?Vm8raGVJN01pVTNvN2RQcXNhTHhWV3R2YVE4ZFFtNEQyNFJHNHBFSzhtemlD?=
 =?utf-8?B?YUhMZmwxSXhaYUFnakJxS3k2S3ZFRHpnQlBWVm1tZmtTb3N3R0ZJSlZzVEI5?=
 =?utf-8?B?Qm1hS0NkSy9zNmZ2MU1NYXFHOWdJaWY1VThPb1o3V3loeERVK3c4eFh0Q1ky?=
 =?utf-8?B?Zk11ZG42Zy8xTFJUOEcyTTRBYUZ3dlFtUG1EaHNocm01dUhEL3Y5N3ZPazNH?=
 =?utf-8?B?dUF2a0crK3dKQVFUTThNMFNiMjh1eThWTE5uTFU5ai9kTWNLZmpJTlFWdm9h?=
 =?utf-8?B?Nm82SVdJSWxubWFsTEhoaDVENVloZmg0dlJidFBia3VSeU5CbTU2aThBbjM3?=
 =?utf-8?B?VHMxWWY4bmNvZVIzY0VIbCt5VjZoS3ZUc1hLek1McU1iNXZGNmZYTC9IUnNL?=
 =?utf-8?B?TmxLY2VQb00yWTVwemU2bG4xcG0vSkdYQjRBVEpyNldSdXN4Rk9mWTFSZEds?=
 =?utf-8?B?MjdHdXZrYXFRUTl5eTQ4ekV3SmF6SWMxQWNFMENCNXJKZFYyVTlHbkNoSmpS?=
 =?utf-8?B?NllWNi9MK2RuUGpPeFBUdWpzdnVGb29Fb1QydmNibFd4akdVVjZyeEZWNkpw?=
 =?utf-8?B?ZHAybEVJT0dodlowdUFFV0NXc2p6TVdzenBSU1QrcEFhWkFxNlhzaUp1Z1hR?=
 =?utf-8?B?ait4akl3TkUrOW4vL0NNZVJOZE91K1YyM01obEtXb014TEFIaG9EWGw3UUxk?=
 =?utf-8?B?dEoxUit0dXAxL1IraHd4bmZCZlAwYUpWQ3kwSFZFa2w1ZWo2UEFtbzN4a1B6?=
 =?utf-8?Q?ljer66KKecA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBJMkxEakZOWmpnaVBmMzVrN1FqU3RadTFjWFVVTlVDQmJTVmlzNUp2ZmxH?=
 =?utf-8?B?THdqdlJ0ak9mVWY0WlFiRHhuQzY5NUU5cU9rTzBtTXRDaDhPV1NrV1U0VW12?=
 =?utf-8?B?bUFFTzd6cHNvK2IyeEd1aVh3Mm1xSFVpejAzdkZvU1JqN3lnTlorQkNXaVlt?=
 =?utf-8?B?MmM4VzVYTEtmSUdHek9veFRHQWxsQkI1aTlqWWpENUM4VE9lZTdicy83MHE5?=
 =?utf-8?B?U0FHZUkyZmRxL05CY0lGdXBSc2RwR3JPZ1ZxRStZczBycUlrZVRpRkdNdU9p?=
 =?utf-8?B?amQ1Zy9NNzk3bnhXSmRkYVBsVU5oOERMR1gydVlZblY5dDdkaUNBdmVtS1Zy?=
 =?utf-8?B?c0ljU0JsdGhyWWsvb3hLa3pwOXVQVE5wY2diRXNlNnRJS1VIcmRVRlFYZElL?=
 =?utf-8?B?ZVQ0NEZLbUxBQ0xpd1FicTN4QTZsWWg1dnVEbFhXM2ltVkhhR1l4MHZGOEFr?=
 =?utf-8?B?NnVyOVQxaXBSZW1Gd2paM2szWGgwaHVSMUpuZ2M1Z3VEckhpOVFLM0RRRnl2?=
 =?utf-8?B?T1c5TUY1ZUp5K05NK0wzdjNzNFl6dXZXTGxNS2hNdXJ6U1h5aDlLVGtEMlZH?=
 =?utf-8?B?dHJob3c3bW45bDlKS2R5Zk9qaGg5Nml0TjFpKzFkbGFFNUw4WnFSMFgvajBE?=
 =?utf-8?B?K1B6SXZ3M2JYR1B5clpPN3NacFRiMkZodGtBeVBwWDBVb3cxK25MdTZkTndH?=
 =?utf-8?B?OGYra2drNmtETjhxdDdWaGttc1VuU2FycnFNUWQ1UEJrdUI5R2NHOHAybUo2?=
 =?utf-8?B?ZTFHMzd6TWQzbXJpTStoRnB0Ylp6TE12OW5YRXE3UHRuaHZodTVKRjNKdlRk?=
 =?utf-8?B?eXg4cXphaGhWNnY5TndUYldQSTlxRUU1WVM4NG5yL2xWd2V4TDk0VXhDVFVW?=
 =?utf-8?B?em5jU0oyVmxONUdtdm1zcGdSSG9SMXZCek1MRDdqTEVzYWtQNTFxaFJUMXQ0?=
 =?utf-8?B?UndvS1FONzJQMEdLaDRWQVY4UkNxNXU4SGQ2eG1GSUdrNGxSZE5pWVFLbWRR?=
 =?utf-8?B?WVllTVdlU3g2ZVJGVUFRWW1XRXpHSE5JakpneG5VVW5KTnNpWkx0ZEZoQ0V3?=
 =?utf-8?B?VEdxUUROWmttMWlXUzR1OCtCakZkTTlyVnFHRkQvT1ZhbFlUanlONXcwRklC?=
 =?utf-8?B?cERON1J6WWhGQ0MzeTFyRWFKYXNMdE43N2szWDZ3RmpPSlh2TVArRko4Nml4?=
 =?utf-8?B?ckdTM0svZk1qVkhac1hqQUR0bVFJVUhXV0NrRFlLUWpaZTA3U1RTYmF2YUxk?=
 =?utf-8?B?SDV5UzgrZi96TXowTzJPQ2NKQjgzck9CN1lBL3g0QXZnd1VXMFlKNm9GMXhC?=
 =?utf-8?B?Mkg2elJCdVl5UkNsV1RwVk5BbXJIQVdkMVNkd2lFYzVRNElFdk0zNUc4MlNk?=
 =?utf-8?B?bXBUS2xRNjdNU1hFd3dCWDZOMmFLTjRiTC9IR3hBV2VXRVpUNXZ1Tmc5azU4?=
 =?utf-8?B?SHNQVTI5andSc0luSmFxbWwrUmNSbXNTakU1OGI1QnN3UjhmdU1KeXJOWU0r?=
 =?utf-8?B?VVlJZWtNNkZRTmlnbjdQRWRwUWp3NXQzMGlvZ1JzVWRKOEcvYlpWSEFnM1Jp?=
 =?utf-8?B?QzBJSzBEdTZhOGVpVVFMM3NMQVFrM21TanpxVi9SVmdXZkJuT2FzSWRUYnlB?=
 =?utf-8?B?cStvSlI1Yk91aFVkRWVLcWdQcUxjNm5Ya3VxT0l2d25YdWtxNFR3SFFiTUFw?=
 =?utf-8?B?R2k1Q2hJSlVjeE41NEJ6WnJHSHZGeGdjVGQyN3dZd1VJNGVTcUlwdzNJOFBr?=
 =?utf-8?B?TGY2M0t6ZWgrQ1R3eTJSS1FSUDVCTXB1SmxzL2krYUhxa3lzaUFHRCtaaitW?=
 =?utf-8?B?V2s5K0o4Z1NOK1E2d08yS0N4ZjlGTmdkL1VMRFRQL25QVVZ6WjRaU1A1SmJR?=
 =?utf-8?B?Wmo0N1Ivai9RRHArcktmVjhRV2hwenlrOUw5ZjBCczlxRTlaUlR0WllyN2E3?=
 =?utf-8?B?UXpSSWxraHV0NlArS3EzRlFJV2VmZ0JxWUtLNy9ZR2VkZ2Uvc052alpKQzJ0?=
 =?utf-8?B?Q1VRa2Q3TmRMWnIvemw0K255MWU1RTJic3lJd1RJUkJlWnBiYmV3VW0xWnRx?=
 =?utf-8?B?dU5RaEFMWmo1dG5WWE9QTzE3NVdYUWRyc3JKSm1IRisvb1NSQTg4VW9vNXVF?=
 =?utf-8?Q?k5r+wAeiXKNUllnw7gN/Ft0N0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf6be09-c537-4607-1082-08ddd35bf699
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:36:49.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyxVs0V8DV0qk/rYVmeUgM9MObIPhe0KkGEH6AxsEVm43nh17u8XaKj4VmEfAUhv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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



On 8/4/2025 5:52 PM, Lazar, Lijo wrote:
> 
> 
> On 8/4/2025 4:35 PM, Asad Kamal wrote:
>> Fetch system metrics table to fill gpuboard/baseboard temperature
>> metrics data for smu_v13_0_12
>>
>> v2: Remove unnecessary checks, used separate metrics time for
>> temperature metrics table(Lijo)
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 248 +++++++++++++++++-
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   3 +
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  26 ++
>>  7 files changed, 287 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 8b015107f761..dc48a1dd8be4 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -766,6 +766,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>>  	case IP_VERSION(13, 0, 14):
>>  	case IP_VERSION(13, 0, 12):
>>  		smu_v13_0_6_set_ppt_funcs(smu);
>> +		smu_v13_0_6_set_temp_funcs(smu);
>>  		/* Enable pp_od_clk_voltage node */
>>  		smu->od_enabled = true;
>>  		break;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index b490c39e313e..611b381b9147 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -257,6 +257,7 @@ struct smu_table {
>>  	void *cpu_addr;
>>  	struct amdgpu_bo *bo;
>>  	uint32_t version;
>> +	unsigned long  metrics_time;
>>  };
>>  
>>  enum smu_perf_level_designation {
>> @@ -322,6 +323,7 @@ enum smu_table_id {
>>  	SMU_TABLE_ECCINFO,
>>  	SMU_TABLE_COMBO_PPTABLE,
>>  	SMU_TABLE_WIFIBAND,
>> +	SMU_TABLE_TEMP_METRICS,
>>  	SMU_TABLE_COUNT,
>>  };
>>  
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> index d7a9e41820fa..458c4ac2dfbc 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>> @@ -278,7 +278,8 @@
>>  	__SMU_DUMMY_MAP(MALLPowerState), \
>>  	__SMU_DUMMY_MAP(ResetSDMA), \
>>  	__SMU_DUMMY_MAP(ResetVCN), \
>> -	__SMU_DUMMY_MAP(GetStaticMetricsTable),
>> +	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
>> +	__SMU_DUMMY_MAP(GetSystemMetricsTable),
>>  
>>  #undef __SMU_DUMMY_MAP
>>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> index 02a455a31c25..d0dd84670361 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
>> @@ -138,6 +138,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
>>  	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
>>  	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
>>  	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
>> +	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
>>  };
>>  
>>  static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
>> @@ -184,7 +185,8 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
>>  
>>  int smu_v13_0_12_get_max_metrics_size(void)
>>  {
>> -	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
>> +	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
>> +		   sizeof(SystemMetricsTable_t));
>>  }
>>  
>>  static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
>> @@ -359,6 +361,245 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>>  	return 0;
>>  }
>>  
>> +static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
>> +						 bool bypass_cache)
>> +{
>> +	struct smu_table_context *smu_table = &smu->smu_table;
>> +	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
>> +	struct smu_table *table = &smu_table->driver_table;
>> +	int ret;
>> +
>> +	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
>> +	    time_after(jiffies,
>> +		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
>> +		       msecs_to_jiffies(1))) {
>> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
>> +		if (ret) {
>> +			dev_info(smu->adev->dev,
>> +				 "Failed to export system metrics table!\n");
>> +			return ret;
>> +		}
>> +
>> +		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
>> +		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
>> +
>> +		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
>> +	}
>> +
>> +	if (metrics_table)
>> +		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
>> +
>> +	return 0;
>> +}
>> +
>> +static enum amdgpu_node_temp smu_v13_0_12_get_node_sensor_type(NODE_TEMP_e type)
>> +{
>> +	switch (type) {
>> +	case NODE_TEMP_RETIMER:
>> +		return AMDGPU_RETIMER_X_TEMP;
>> +	case NODE_TEMP_IBC_TEMP:
>> +		return AMDGPU_OAM_X_IBC_TEMP;
>> +	case NODE_TEMP_IBC_2_TEMP:
>> +		return AMDGPU_OAM_X_IBC_2_TEMP;
>> +	case NODE_TEMP_VDD18_VR_TEMP:
>> +		return AMDGPU_OAM_X_VDD18_VR_TEMP;
>> +	case NODE_TEMP_04_HBM_B_VR_TEMP:
>> +		return AMDGPU_OAM_X_04_HBM_B_VR_TEMP;
>> +	case NODE_TEMP_04_HBM_D_VR_TEMP:
>> +		return AMDGPU_OAM_X_04_HBM_D_VR_TEMP;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum amdgpu_vr_temp smu_v13_0_12_get_vr_sensor_type(SVI_TEMP_e type)
>> +{
>> +	switch (type) {
>> +	case SVI_VDDCR_VDD0_TEMP:
>> +		return AMDGPU_VDDCR_VDD0_TEMP;
>> +	case SVI_VDDCR_VDD1_TEMP:
>> +		return AMDGPU_VDDCR_VDD1_TEMP;
>> +	case SVI_VDDCR_VDD2_TEMP:
>> +		return AMDGPU_VDDCR_VDD2_TEMP;
>> +	case SVI_VDDCR_VDD3_TEMP:
>> +		return AMDGPU_VDDCR_VDD3_TEMP;
>> +	case SVI_VDDCR_SOC_A_TEMP:
>> +		return AMDGPU_VDDCR_SOC_A_TEMP;
>> +	case SVI_VDDCR_SOC_C_TEMP:
>> +		return AMDGPU_VDDCR_SOC_C_TEMP;
>> +	case SVI_VDDCR_SOCIO_A_TEMP:
>> +		return AMDGPU_VDDCR_SOCIO_A_TEMP;
>> +	case SVI_VDDCR_SOCIO_C_TEMP:
>> +		return AMDGPU_VDDCR_SOCIO_C_TEMP;
>> +	case SVI_VDD_085_HBM_TEMP:
>> +		return AMDGPU_VDD_085_HBM_TEMP;
>> +	case SVI_VDDCR_11_HBM_B_TEMP:
>> +		return AMDGPU_VDDCR_11_HBM_B_TEMP;
>> +	case SVI_VDDCR_11_HBM_D_TEMP:
>> +		return AMDGPU_VDDCR_11_HBM_D_TEMP;
>> +	case SVI_VDD_USR_TEMP:
>> +		return AMDGPU_VDD_USR_TEMP;
>> +	case SVI_VDDIO_11_E32_TEMP:
>> +		return AMDGPU_VDDIO_11_E32_TEMP;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e type)
>> +{
>> +	switch (type) {
>> +	case SYSTEM_TEMP_UBB_FPGA:
>> +		return AMDGPU_UBB_FPGA_TEMP;
>> +	case SYSTEM_TEMP_UBB_FRONT:
>> +		return AMDGPU_UBB_FRONT_TEMP;
>> +	case SYSTEM_TEMP_UBB_BACK:
>> +		return AMDGPU_UBB_BACK_TEMP;
>> +	case SYSTEM_TEMP_UBB_OAM7:
>> +		return AMDGPU_UBB_OAM7_TEMP;
>> +	case SYSTEM_TEMP_UBB_IBC:
>> +		return AMDGPU_UBB_IBC_TEMP;
>> +	case SYSTEM_TEMP_UBB_UFPGA:
>> +		return AMDGPU_UBB_UFPGA_TEMP;
>> +	case SYSTEM_TEMP_UBB_OAM1:
>> +		return AMDGPU_UBB_OAM1_TEMP;
>> +	case SYSTEM_TEMP_OAM_0_1_HSC:
>> +		return AMDGPU_OAM_0_1_HSC_TEMP;
>> +	case SYSTEM_TEMP_OAM_2_3_HSC:
>> +		return AMDGPU_OAM_2_3_HSC_TEMP;
>> +	case SYSTEM_TEMP_OAM_4_5_HSC:
>> +		return AMDGPU_OAM_4_5_HSC_TEMP;
>> +	case SYSTEM_TEMP_OAM_6_7_HSC:
>> +		return AMDGPU_OAM_6_7_HSC_TEMP;
>> +	case SYSTEM_TEMP_UBB_FPGA_0V72_VR:
>> +		return AMDGPU_UBB_FPGA_0V72_VR_TEMP;
>> +	case SYSTEM_TEMP_UBB_FPGA_3V3_VR:
>> +		return AMDGPU_UBB_FPGA_3V3_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR:
>> +		return AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR:
>> +		return AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_0_1_0V9_VR:
>> +		return AMDGPU_RETIMER_0_1_0V9_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_4_5_0V9_VR:
>> +		return AMDGPU_RETIMER_4_5_0V9_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_2_3_0V9_VR:
>> +		return AMDGPU_RETIMER_2_3_0V9_VR_TEMP;
>> +	case SYSTEM_TEMP_RETIMER_6_7_0V9_VR:
>> +		return AMDGPU_RETIMER_6_7_0V9_VR_TEMP;
>> +	case SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR:
>> +		return AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP;
>> +	case SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR:
>> +		return AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP;
>> +	case SYSTEM_TEMP_IBC_HSC:
>> +		return AMDGPU_IBC_HSC_TEMP;
>> +	case SYSTEM_TEMP_IBC:
>> +		return AMDGPU_IBC_TEMP;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
>> +						   enum smu_temp_metric_type type)
>> +{
>> +	switch (type) {
>> +	case SMU_TEMP_METRIC_BASEBOARD:
>> +		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
>> +		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
>> +		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
>> +			return true;
>> +		break;
>> +	case SMU_TEMP_METRIC_GPUBOARD:
>> +		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
>> +					     enum smu_temp_metric_type type, void *table)
>> +{
>> +	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
>> +	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
>> +	SystemMetricsTable_t *metrics;
>> +	u32 idx, sensors;
>> +	int ret, sensor_type;
>> +	ssize_t size = 0;
>> +
>> +	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
>> +		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
>> +
>> +	if (!table)
>> +		goto out;
> 
> This returns a valid size on failure instead of error code. Better
> return from here directly with -EINVAL. Size assignment may be clubbed
> with the type checks below.

Please ignore this comment. Find the amdgpu_dpm API documentation that
it should return expected size if NULL is passed.

Thanks,
Lijo

> 
>> +	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
>> +	if (!metrics)
>> +		return -ENOMEM;
>> +	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
>> +	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
>> +	if (type  == SMU_TEMP_METRIC_GPUBOARD)
>> +		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
>> +	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
>> +		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
>> +
>> +	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, true);
> 
> Suggest to pass false so that cached values are used for back to back
> baseboard/gpuboard queries.
> 
> Thanks,
> Lijo
> 
>> +	if (ret) {
>> +		kfree(metrics);
>> +		return ret;
>> +	}
>> +
>> +	if (type == SMU_TEMP_METRIC_GPUBOARD) {
>> +		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
>> +		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
>> +		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
>> +
>> +		idx = 0;
>> +		for (sensors = 0; sensors < NODE_TEMP_MAX_TEMP_ENTRIES; sensors++) {
>> +			if (metrics->NodeTemperatures[sensors] != -1) {
>> +				sensor_type = smu_v13_0_12_get_node_sensor_type(sensors);
>> +				gpuboard_temp_metrics->node_temp[idx] =
>> +					((int)metrics->NodeTemperatures[sensors])  & 0xFFFFFF;
>> +				gpuboard_temp_metrics->node_temp[idx] |= (sensor_type << 24);
>> +				idx++;
>> +			}
>> +		}
>> +
>> +		idx = 0;
>> +
>> +		for (sensors = 0; sensors < SVI_MAX_TEMP_ENTRIES; sensors++) {
>> +			if (metrics->VrTemperatures[sensors] != -1) {
>> +				sensor_type = smu_v13_0_12_get_vr_sensor_type(sensors);
>> +				gpuboard_temp_metrics->vr_temp[idx] =
>> +					((int)metrics->VrTemperatures[sensors])  & 0xFFFFFF;
>> +				gpuboard_temp_metrics->vr_temp[idx] |= (sensor_type << 24);
>> +				idx++;
>> +			}
>> +		}
>> +	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
>> +		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
>> +		baseboard_temp_metrics->label_version = metrics->LabelVersion;
>> +		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
>> +
>> +		idx = 0;
>> +		for (sensors = 0; sensors < SYSTEM_TEMP_MAX_ENTRIES; sensors++) {
>> +			if (metrics->SystemTemperatures[sensors] != -1) {
>> +				sensor_type = smu_v13_0_12_get_system_sensor_type(sensors);
>> +				baseboard_temp_metrics->system_temp[idx] =
>> +					((int)metrics->SystemTemperatures[sensors])  & 0xFFFFFF;
>> +				baseboard_temp_metrics->system_temp[idx] |= (sensor_type << 24);
>> +				idx++;
>> +			}
>> +		}
>> +	}
>> +
>> +	kfree(metrics);
>> +
>> +out:
>> +	return size;
>> +}
>> +
>>  ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
>>  {
>>  	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
>> @@ -572,3 +813,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
>>  
>>  	return sizeof(*gpu_metrics);
>>  }
>> +
>> +const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
>> +	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
>> +	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
>> +};
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 9cc294f4708b..c777c0e4ea11 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -3857,3 +3857,9 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
>>  	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
>>  	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
>>  }
>> +
>> +void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
>> +{
>> +	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
>> +			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
>> +}
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> index 67b30674fd31..ece04ad724fb 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
>> @@ -68,10 +68,12 @@ enum smu_v13_0_6_caps {
>>  	SMU_CAP(HST_LIMIT_METRICS),
>>  	SMU_CAP(BOARD_VOLTAGE),
>>  	SMU_CAP(PLDM_VERSION),
>> +	SMU_CAP(TEMP_METRICS),
>>  	SMU_CAP(ALL),
>>  };
>>  
>>  extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
>> +extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
>>  bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
>>  int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
>>  int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
>> @@ -88,4 +90,5 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
>>  				     void *smu_metrics);
>>  extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
>>  extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
>> +extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> index a608cdbdada4..d588f74b98de 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> @@ -65,6 +65,32 @@
>>  		header->structure_size = sizeof(*tmp);                     \
>>  	} while (0)
>>  
>> +#define smu_cmn_init_baseboard_temp_metrics(ptr, fr, cr)                        \
>> +	do {                                                                    \
>> +		typecheck(struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *,  \
>> +			  (ptr));                                               \
>> +		struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *tmp = (ptr); \
>> +		struct metrics_table_header *header =                           \
>> +			(struct metrics_table_header *)tmp;                     \
>> +		memset(header, 0xFF, sizeof(*tmp));                             \
>> +		header->format_revision = fr;                                   \
>> +		header->content_revision = cr;                                  \
>> +		header->structure_size = sizeof(*tmp);                          \
>> +	} while (0)
>> +
>> +#define smu_cmn_init_gpuboard_temp_metrics(ptr, fr, cr)                         \
>> +	do {                                                                    \
>> +		typecheck(struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *,   \
>> +			  (ptr));                                               \
>> +		struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *tmp = (ptr);  \
>> +		struct metrics_table_header *header =                           \
>> +			(struct metrics_table_header *)tmp;                     \
>> +		memset(header, 0xFF, sizeof(*tmp));                             \
>> +		header->format_revision = fr;                                   \
>> +		header->content_revision = cr;                                  \
>> +		header->structure_size = sizeof(*tmp);                          \
>> +	} while (0)
>> +
>>  extern const int link_speed[];
>>  
>>  /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
> 

