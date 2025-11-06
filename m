Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E976CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E75410E332;
	Thu,  6 Nov 2025 13:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kr93iOlx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B421A10E332
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 13:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z10IzUZ57lpKlq64CLS2Y7cOFd9FXvunXukFlWMxAmH3N+47Ry2DAK/nsfgpwR3DQEIZClZ+f2HNc+xcYtivSMeGbdKR+LBlUUoW/2xU4x0aBul2yNW/WfLWaxZsp9iIXBxCMhuOtGcvzvemgDxYyZ2Em0JfIxbtXSE/MP8pD3tuTvizqOt/4/7EMYJuGe79u6Bk6yk4oD5yDkGSvH1uGwIr++mV+ZPa0b3T96oXGPd6nFzlDYaoHVaW1Wa0BqxHbV9Jer5gOewShlvlJ+F6maNNtNuVA2AwDvjumJUtzvV+TFZLHneATpqG6mZRGVl/K/C8X2REXvPeeAZDiVov0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdUcdNM+KBesiO8C3DrgEkg5P/kKnIeiaaQmR+WlqKI=;
 b=YcqDvz8NyjDp+6dqTDxSIdxV9Pdit5lkPv505jjhPbYezyKaL2Yiu65u5EMshwo1OCUt3lXyBGDwvoBMg3Gp5SRzUW+9ExdgOAIhvRcFmUImDWAnIcjIuAeOLNOnbdLjx3VtzITnkqETol6x27NMNmNdjVHKuQe7RDdQZ+yOY5AvhceKjO+eo92iFD2Or3eQ9cw0VE717WaovdaLEXHruxffwElIsTDEyAxGj2h3jetNCXE6SWZJicfOedvCB0qtCxX0GaEHKx62sJm1DIVZI5VtJyM+2KOe8wMhIUmqG+1xarpILtAzl8LuKm1z/3KZudZYe/T0/7y8w0yuAPGBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdUcdNM+KBesiO8C3DrgEkg5P/kKnIeiaaQmR+WlqKI=;
 b=Kr93iOlxh+bXQHPgO8Fsnq3Zl9Srkd/2hfgFmv/620/60/lCgOcljT41GBZ0nmfNqOfE9cpGbOIDWwiBW0DVhax4cyjyonACuaJo3Ox+PeBIMivISjB0wwc4tdVMywaC6b6CyJauS/YiYybsDVhWF3mSlk/KBC37wD9ooPVuKQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 13:28:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 13:28:45 +0000
Message-ID: <2e921077-4118-4829-b8d2-916f77eb3087@amd.com>
Date: Thu, 6 Nov 2025 18:58:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106114421.3770378-1-asad.kamal@amd.com>
 <20251106114421.3770378-3-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106114421.3770378-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: fee43392-64ed-4b32-2615-08de1d38690a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHNYb0pwSWd6UEp4S09Xa3FON2djeTl1UTFuZUlUUnY1QXVWWUFYNTBpQTlU?=
 =?utf-8?B?a2VscDh1a2VpZFp3NUVEVktkYzVkSTFraXpZbUtWQUF5bDV5MVdnYlE5NUNI?=
 =?utf-8?B?Tk9ZUEJTdlNNWHZwNHpQb1lDUkF0QTBSOTFtcE05dGljUkFxWVlVa29OY0Np?=
 =?utf-8?B?Y01hcHNoNlVPYnhYTGdZL1QwUzgvMGdhVXFvQXNIR2ZHbE5xTm5KVVRyVTBh?=
 =?utf-8?B?SThXRWFocnJGcXd5cVJndUR1Q3lHbUtrVGxhc0JDcFZLdlZJd2JzZlF4QytP?=
 =?utf-8?B?bXV2TUhjVEE2Q0FEN0psOWc0WHFLWDErUlhDa3YyTG0ycXk2eG5RaHhPZTZL?=
 =?utf-8?B?eWVnWEs4aUhZeFk0YmZPeVIvNG0rY0dZRnkwL2JCOGw2L21EZjhXb1hFYlAr?=
 =?utf-8?B?emhYZW5nYUZEandBN1JZWkhndVJjSTZZQVNnbkJwQmJtTDEyUzJtL3hZTVVI?=
 =?utf-8?B?YTk5ajdZalVHM3gweXpLRVJQeXBiN0xNYzZZczNObitGZTVSeld5THpMVzh6?=
 =?utf-8?B?WmhNNm5Qd3FualUzUEhzd1Q5Q0Q1ZGFwOUdEWHpCcE9FdlNpWDJoUiswVnBQ?=
 =?utf-8?B?K1BxQ0plckVHQXdIMlpCU3c0dGxQU25yeW1pK1FLbXd6WnFyRVV1dExaODhk?=
 =?utf-8?B?UHBPaFc1aE5xR1E2dEJqQXlicWlWWU81UnMxcUZSY3g5NTBhZ1IvYjJib0ky?=
 =?utf-8?B?c0d1TmIwQ1hnWWtaTEVWVS9ORnBvbjdGSll1c0lCRVc2MTdPSVlhL21LdUtH?=
 =?utf-8?B?S2FOOThwYjFzcVBOZFVuT2dqRlU4bjcyL1NKZjV0V0pVd1Fua05BSm1UQ05S?=
 =?utf-8?B?MWIvajlScXVrRC9sQVpGejdmTGFMbmQwamRxcHZlbUJHck9oTzN3TUZGc2Vu?=
 =?utf-8?B?MTh0MzFGcjZMZ2NDNnE2dmpsRkh6a1drWjFqWDlSUk0rd0hoWVZuUmpOOHZT?=
 =?utf-8?B?bFloRkNQbGUvL1Z4SDl6N24yaTRQMXFLMlpWRnYwc041NmRBaDVqZU14WWN0?=
 =?utf-8?B?eXZIQ2k4cHFHYzNsOENCeGdyUzQ4Z2NHZklJTXNudjhJcnFtRElRVUJVTVIy?=
 =?utf-8?B?TDJHZ2lBWEZ3NTU4bDBZWGJ1MHBFcVQ1eUJlUmFscWhadGRvR3ZzOUM1WE1u?=
 =?utf-8?B?eHRUbnRsN1FmbzBQNXN5a1AvSEdWMnVMeElUTCtwcVVmVUdUaVlkdjdSU0hN?=
 =?utf-8?B?MzduNE9Fbmc5aWFJZ2xiYzN0SDVHZnRtTytpamMxY3J4ZVozb0ZSaS9sRktP?=
 =?utf-8?B?djlaV3c4aVRFa1lYcUk0MjBFeG14ZDVPeGRtblUxdWZYVloyeStQQlkwaDR5?=
 =?utf-8?B?RW0xeWRQZGpsWU5zbjZaL1ZPZ3d6a08vZit1YnBIREpLODFpM3VsYXAwR1Zv?=
 =?utf-8?B?ZkxyVWFNVnY5aXJVenBEMGh4cDBoanhMZlNCckt2TS9mM3h5WGNvQUIrMjVh?=
 =?utf-8?B?VkgvNEtTRG10WjUxQmRFb3ZnOWU4YTE5R3NVeHlCbi9wemxROUFuV21DOENo?=
 =?utf-8?B?UzNadys4WUE3cXFGai9PWU1jek5RL3A1anlPeFc3aFVvNWw1YzM0bkplTDdS?=
 =?utf-8?B?N2FQUFdkRWhQdXNCZ1pLSlEwK1pjWUxUaDN3RDhYK2JENmVuZHhZaXZZQ2k3?=
 =?utf-8?B?TGF5dnVzR1ZZNnphcG91S0VrNmtlejlPVlMrRzRjK09XK1U1RTRSSko5R1Fy?=
 =?utf-8?B?aExqTm5uNDJwTmI0VUZtazhBS0tha25JSms5R2Q4N0w0aTR1VU82ZjZoUXVU?=
 =?utf-8?B?WkR6RVBtS2crMGJwMk5ZSkdObjRvRkhweHkxbktMczdtQURRNEE0aXo0ME9j?=
 =?utf-8?B?Q0Y5bkJ1Q0tzRzJqd3VSK0owd2xtVkxndHM2aVNuSzh1cXJCSnRXcW5PQmIz?=
 =?utf-8?B?Y2tLZmhKZ3hDWlJJN1YyZHZ1bEx1S2pZWXludWV4RVN6OVYrek9QWmxOWTlR?=
 =?utf-8?Q?TLVhxc5ilHXt9tlHFUBvZ9+PTcROurUv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZmTVU1cndZS2RpVmsrT2ljV0R6dXQvLzNnSHdsbHdrczVzZmlXdGVvNjJx?=
 =?utf-8?B?OGs3V0VzNHNvalVNMFJOcldMRlFDbDNJOEJEc1U1TVlqdFVrc2hQSHZiZGoz?=
 =?utf-8?B?S3ZJRzUzeGl5NFg0Y0E0dVdCSFRWRFM5dE90TDZBTDZpR2IzdGkvbmVSZlRS?=
 =?utf-8?B?ZDA3UGlDRnI3S2FYVmZYU250b0hTd01jU3VRcDNaQ3JHbmNlMjFrYmVMWHd0?=
 =?utf-8?B?RUsyd2FiY280L2Izd3haY2RWUktQbW5vejE2RUttRGgvQ3d3cjZZdTRFZGpG?=
 =?utf-8?B?VS9DOVJZSG9EcWNDODIxQm90QkExV3lpTzFxNGZ0TFdqV29wMGtJOGRkaWZF?=
 =?utf-8?B?cU16ZnFvZmJSdTJlZ0ozWFFpUm5wWDY5eUdGeUxNSzh6Y054bDE0Z3JCYkhs?=
 =?utf-8?B?OUVIR0dtYzdrUkp2eWJVSkx0Uld6WE80VGxzRXRlMERqMHQvS3dCRU5CUEo3?=
 =?utf-8?B?NVRacVpHQ3RCalovaHZXbjhSQWZyY2EzNk94c1hIcnU2ZWFCYWN1bGpVdWRT?=
 =?utf-8?B?UGgxc2pFSnRvUVhOQXowN2tudk5FNXdDWjUyOEhoNUk3Ky9TeittajBPMDho?=
 =?utf-8?B?Z2NaeUlHby92QWdGQUxEMnpnOHRJZldoTk9YMnIzdDFSbCtxOWN5ZjltZU1G?=
 =?utf-8?B?U1Z2S3lLKy9WUjg1VnlkR3kvYlVHOFYzTDR2ZUhiZ2Jvd0JRWi9NMElRZHNE?=
 =?utf-8?B?ODgwb2E5SkJINVNHeEhqRWl1RmV0T3dScHdnK2Rtb0ZWamRKdXF4b1FKbGpZ?=
 =?utf-8?B?T29yaXY4MWNJQWhNeldEMnFDWkpqTEJydXRsdTEzUWEvaFhGZnp2UHZuVHNj?=
 =?utf-8?B?YUtDQTJGOXI2bU8wb3dkcERiWGdxOTZyN3lvMWV1NWhxYkdrYnU0ai9IYzhL?=
 =?utf-8?B?TWE3bi9FZTRPTFFhWjQ3WnFma3pZeXN3RG9KNGlnZEZEcmVQMnJwOGNJVjF1?=
 =?utf-8?B?amhhZE1lQ3dYRFYycTdHV3Ivb3Bub0F4eWdJSEdsS3grbGF6UW1FSlZ4byt5?=
 =?utf-8?B?bHRLcU80VU1wVEtka1MzMUY5NGJJU0lYVjgyU0lSMlkvcGozdCtuekdzek1n?=
 =?utf-8?B?T0NxdjJFZ3MwdWtqS1U1UkYvMll1VitsbUw4Zm5mZVRtNjdZK3RPMURKTFhB?=
 =?utf-8?B?MEFqNzdnSUtNSm9pa29jNDR5Q3FpbkRLZDk3QUVuTEVzVm1WTVcyZkoyVU1C?=
 =?utf-8?B?eitJY2NIRW8xTGNEdHpKYTQ1RVJwckdPaVBuamVkMjZxWVFyUi9hT0N6ZEt4?=
 =?utf-8?B?SzMwME14eXhsc2xWaTUvajlSSTY3emtTVVNQOU5jbVNTeXdKVUFDVHA5NmlL?=
 =?utf-8?B?M3FyLzYvNlNQT0hqckZZMUhmaHh6eEZtL1hKTy85a0h2STdDMmc2Q1JQTGg5?=
 =?utf-8?B?V3YvT2k4RlNrMHVFN3NuZHFKUG5XaUF4VklHZTFoYU01UEsyUTQ3eXlJcndK?=
 =?utf-8?B?aUxPbVVETEpMMnlsOWV2bDhqM2ZMOGV6Vnh5dSs5czRtQ2lhNzNDZFI0dkJ3?=
 =?utf-8?B?Mmk1NEF4MklneTZnZ1VqV2tGRzQyMTFjZnN3WDFHamhOaUh0V2RoQUw1VHRr?=
 =?utf-8?B?dUp0MlNDVDdGekErVEsvNlVxV1hkd0FWWHJrZUpQMER6Q0NmVGlJYnJvSE52?=
 =?utf-8?B?cUszdVhLeWI2UGpVMS9BUTN3NERKeXp5ZEUyZFlYeUtBRVNpNERwTTE2MVA5?=
 =?utf-8?B?US9rNFJiQVBsRnZ5RHQrdXpyTTNDTnd0ZEF3dWNBdXRjMmF6bStIVW5ROVMx?=
 =?utf-8?B?VlVWMVFsR1Bpb2ZKLzRrT3pQZEJ4eldkc2dwVENTNWltRkJBb2ZuWFpVYzVr?=
 =?utf-8?B?ZDdJdHRvdmxlZHFDeVVrNVpybDZFczJTY2ZuSzdhVnlzaTVXaHRTMGk1Um5C?=
 =?utf-8?B?U1F5Y2lIa2RxcVdFZFg3NGJ0WnJNTm1zQ0p4cUVUZi9za1hOdTg2bkdNTllp?=
 =?utf-8?B?SWNqbjRPQ0drZnVBdkZOZDVmWmNRYUQ0NTl5VDJBeER3Yk9iZ0c4b2NnZWcv?=
 =?utf-8?B?bWI3UWhCbUcvZ1k2UVFyQnRXOVR3cVBNc3hDSzRESWM0YXRvTW1rSEpLeE9Q?=
 =?utf-8?B?TE5tWHF5bnNRSFh5SWFoK2dudkpBcnk4ZDNJTDZvNXQvMUNmZDhpTTc0b2NN?=
 =?utf-8?Q?9S5kbK8Iq3g4L1PXflhqWHGeU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee43392-64ed-4b32-2615-08de1d38690a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:28:45.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0936RdLwYVhth0SKjOAO2stnU93X/DBMtZ/UkJWNoZQ2dodfAFS+5UdZ0exVXTxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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



On 11/6/2025 5:14 PM, Asad Kamal wrote:
> Expose power2_cap hwmon node for retrieving and configuring ppt1
> limit on supported boards for gc_v9_5_0
> 
> v2: Remove version check
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 12 +++++++++---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 69aa8e22f103..49cc5aaa749c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3373,7 +3373,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
>   				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
>   				  "fastPPT" : "slowPPT");
>   	else
> -		return sysfs_emit(buf, "PPT\n");
> +		return sysfs_emit(buf, "%s\n",
> +				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
> +				  "PPT1" : "PPT");
>   }
>   
>   static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
> @@ -3737,7 +3739,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* not all products support both average and instantaneous */
> -	if (attr == &sensor_dev_attr_power1_average.dev_attr.attr &&
> +	if ((attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
> +	     attr == &sensor_dev_attr_power2_average.dev_attr.attr) &&

Better group this with other power2 attributes.

Thanks,
Lijo

>   	    amdgpu_pm_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER,
>   					 (void *)&tmp) == -EOPNOTSUPP)
>   		return 0;
> @@ -3832,7 +3835,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
> +	     attr == &sensor_dev_attr_power2_label.dev_attr.attr) &&
> +	     (amdgpu_dpm_get_power_limit(adev, &tmp,
> +					 PP_PWR_LIMIT_MAX,
> +					 PP_PWR_TYPE_FAST) == -EOPNOTSUPP))
>   		return 0;
>   
>   	return effective_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 4317da6f7c38..73a063748c86 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2921,6 +2921,8 @@ int smu_get_power_limit(void *handle,
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
>   		if (smu->ppt_funcs->get_ppt_limit)
>   			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> +		else
> +			return -EOPNOTSUPP;
>   	} else {
>   		switch (limit_level) {
>   		case SMU_PPT_LIMIT_CURRENT:

