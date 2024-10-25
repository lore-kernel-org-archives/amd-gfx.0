Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56935D0C5FB
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 11:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71E210EA96;
	Fri, 25 Oct 2024 11:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBfMt5cY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC34D10EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 11:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQGATurBK4BnFOjFQ9XsMVoxTIuZ7lzMavmxA6oXdSD/J2fziPJN6sGg3q20sbjPU6yiU+5b5aDV5YFumCXIPxApUwIfg04hb5MgK3Fd8fomuzWLjoPtc8O5UvFeSrnJDea2y5TM/FsoteJE6mEdDzjQWXB0C9gjpP6aJ1aAHU0p3U8tvJenKrfRpFsCKcBfFJpwe4de7Vic4H6w9zAwsmLomIvEOVSlFsWFkpWHdj+zSMuIClwPFHcZ4BhITdNDw91jhaqST+mEwe9I+H3fE+y2d+sefbLwP/DlgXUlRpgwwhjF0/QTXfsfhI7npa3Rz0zAlOox6ABr1ceMYapq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21CM21DomvFnA+kL8lo3TldCDvNkUdA93yOjjqIj1HM=;
 b=gUP5FgFdwQXwZV/KQomWlsGINDWFKWlAae03DILe43t6L3mR0SQhNsP5JO/Q5FlMgpul6B3NSBEc8j/q4fZl7Xo9rLn+rSWMvyuHx7rMt6UesLvW7E5wMzQF03Bfg2pB0R94QAoBg7Gx7DUTcVKmr39rOot3/OXJAJ+LfvwnPcWV9jAq7N29Op6cT8lWXngq8Ocx6Qya8UQHqG6AwkyVjJY3gE9t1fssDB7DHYWFJX6HXsGi7ceIx2LYxrjsAh4H3dEsDT2TNsj1D0zqekJq0JzoWAETifmysdshG3V1R/CHg3iMS5t3bEpyUFhzc/aoRBk7ewkyt8xOoiPNOiFMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21CM21DomvFnA+kL8lo3TldCDvNkUdA93yOjjqIj1HM=;
 b=mBfMt5cYNKr4zV+vtHZ+agua62ZrhJFzp5g5fu3ujDYBOu6EBGGxaZGlk8gdinaZ3xru3huA3Lyc47ON2oGCca7ZPHJ5UXeJU71es368Euc3+yhwtJQw3WPtzN1TrEWnMxj+2Khq3e9CrUKElZJS1fauUWpCSWPcEokATK8SO4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 11:22:58 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 11:22:58 +0000
Subject: Re: [PATCH 21/29] drm/amdgpu: sw_init for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-22-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <8ede81e7-f4c3-b714-c889-8e43827def4e@amd.com>
Date: Fri, 25 Oct 2024 16:52:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-22-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------82725CFCA26AB88DD8D68802"
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5902e664-0d57-4740-f4c2-08dcf4e76118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2tUUEVzUHdPT0JaRVdmM0JSRk5JM29WcEM3V0dQMW5hd3QrKzdRZzlNdjNF?=
 =?utf-8?B?c0lhc0N3Y3NMK2RKbW1GOCt5MkVDSXVWUUtYelJOU1lEZ1dQV3RJbzlkajZj?=
 =?utf-8?B?SXdDdWpzeEluMjkwZWJvVFpMdFJsSUhvd3RDNzBsVEFNVWVNTzFYVHVmMzBN?=
 =?utf-8?B?K3pXSUNWditWRjQxZ0szZU9Sd0VEVEt0OVZKd215MDE0SURUN1pQaUoyUnZZ?=
 =?utf-8?B?RlM3bUpIS2F5V1Z6eTdYK3RxQ0JlNmZpMW91cUtIZmVlMVRZS3hiVVdBWUNw?=
 =?utf-8?B?YUptdzVQSXlFNk1RdWp4MWlkYXRhYk5yNHpPRDV6RGhxbFNxdStzM2VrcG9E?=
 =?utf-8?B?UlhHR3dKSk91N0wyQzNXajBESzE5MU9DZEVBZ281d0o5NlM1OGMzMDBBNGNo?=
 =?utf-8?B?Vldlcnd1SU1mWFNQeVV5aVZPWHNFbXFITFRvcjJSbERrbk5adWw5VmIxQThH?=
 =?utf-8?B?Wm03ZTRaMWFQa3BhYlhKcUE5aUNoNmsvQk81NHJHYk83ZzhkUGR2TkdHMFA3?=
 =?utf-8?B?YWFoOStsM2pYWm1GYW9CU0ZXRFROcFhadk5YNmlWdGVXTm1ialZxTG1ZY0Yy?=
 =?utf-8?B?T0tkZXlnL2tKNGxzTjV0RVl2UkV1S2w3Z3lkTU1YT2ZlUVFDUlcyVFE5cy9J?=
 =?utf-8?B?KzcvcmNGNU5sRGY0c25KTGI4OGJLZHFtMFRLUHM2NWk5WmxWWEtRTUsvS3Bt?=
 =?utf-8?B?NHlLbEtURU9IeXllRnIybUtjKzkwUFdJR0VDVjJmNUdqSlBVQkFZVGg5ZWFn?=
 =?utf-8?B?bmNhL0NpMi90OXpjL0ZkaEFxcXd3dkY0Yk1Lek5CZmYvKzVERm0vc1kzQXVW?=
 =?utf-8?B?eGw0RHlGd2J6ejJQWFl6VVB3dGdXOE16aWEvU21sbTZua1dqOEFva09NeWds?=
 =?utf-8?B?MlNJQzc5T2NnTWNGcXVSNWJvQVNkMjFhazNrWWdtbTdhczJOZWt0dmU3U1I4?=
 =?utf-8?B?NnVIVWgxUnY5d0FJMkZZSC9yQjErbUY0NEJaSEFxRnNRZGJEZ2JzNW1zQjR3?=
 =?utf-8?B?bldhamRLSVBFeGMvM3lBSDVmUXh1VkhZTUM2U3BIT3ZHdVVzSW1BTlZWcXph?=
 =?utf-8?B?dXlSTXZRTE1IODNpSDM0ZWxISnNNeGRrWXZldXRvNDFZK1lXakNldkVOQmNF?=
 =?utf-8?B?anMxTG1JaDFreUFVMWgwenp1dXFvM2dYNmVPK0xNeUw2ckNVbDROWnNZUy84?=
 =?utf-8?B?NlhsUmIxNG85VGIxWDl1VHFDNnRNcjFnRU9BRWdhMEVPdlBpT1duUWxSelUv?=
 =?utf-8?B?dmtkUWx3dm9FWGg4OFpya2dpNHVpNkJ3dkZ4b0ZHaHdTaWNsUGdBbG5mOXp5?=
 =?utf-8?B?bU50VkhBTHFQMGlEMXFpUXVSbGVLVzNheW5FNktTcmRDdjdMNDl6YUlEOHI1?=
 =?utf-8?B?bi9KL1dmelZWTmJ3WXZQQnZSVWZhb3hKLzdWd05ZbDNNZy9SL3JSMFcxU2Vu?=
 =?utf-8?B?ajRjaVRiTlVicDN3Yi9vVU4zcWVQZ0NWRjRyWW5JZU4veE1IMWp1T2xuMWVw?=
 =?utf-8?B?WVBzVVVZalZ6ZFRCTU5rNVprbkl3QzVqZjJvWUg3dGNYRDVwckdFSUV6MGtO?=
 =?utf-8?B?aDNzWWtsQTVlcFlaY3N4djNaTVZMR1hXalNUUnBndHRTcTBtNHZpVDQ5L1RT?=
 =?utf-8?B?M0RzM0RMR0h2UHVFaUlFa3laU0MzcDhSRVlXR2dCYnVUS1QyV3NYMUZCVGJy?=
 =?utf-8?B?L0tvN0Z2QW5zTTdnL1poRmFZdmhhWUZuWjRmeXlVbzROb2d1M2JyM0J2azVr?=
 =?utf-8?Q?3HRMmRVy0NWCkCm0R25BlHTUhq3YenMaQZZfY0/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJZbjRCN0pKdjNCci8vQ1BNSnNKQ2g1eEZYQnNSQzlJVmJMWmFOMFNqenp5?=
 =?utf-8?B?NkpaRmVEWmxoNXp6REFPSzY3eVgyVG50WUtvWWoyWk96Q2ptV3lJUmJCeHRX?=
 =?utf-8?B?bW41cUVhMkpHY3FmTkJFYXJDdkJjOEpNM0o0OFNPTFZwUSticVhNaHNVUnNx?=
 =?utf-8?B?ME5TQzRZT0pGYWJIaS84ZmdUT0xKTTZUL2k1MElFUUhTbU94OFJSYXd6VC9G?=
 =?utf-8?B?dUdoKzhMcnFaUDVhWFZEaEVRSXZiWVdIY1dHa1o4ajhZdGVFRXpVbzdMbFZR?=
 =?utf-8?B?cWNsMC9uVkxyWDNFTTByTHZ1NG96aW40bzhDeTk1Z2NPYVMyWmVpMVNIYXpI?=
 =?utf-8?B?b24rTWlTenZoSjc3TENPZDhHa1lJREhGanJscjRRZ3FqQlpTYTNjNFhNdUxu?=
 =?utf-8?B?cnVrQ0J4a2JGcGpPOEMvNmtOcWwvVzNlZk1aM0pVS01ONHkyWlZBRUNyb1F2?=
 =?utf-8?B?aHF6QjkxcE40d3NxNnRuVHE2a1VwTEZSWFJ5WE5aVzBIMkRRV0xKRDkyS0ZJ?=
 =?utf-8?B?ZzVpKzdDMHlHZ2dqMXdiTkpaLzl6SlpYTWhjUUM3RHBsTlBoYWo5OER6aEJW?=
 =?utf-8?B?SXJ3dlNmVzA1M1lYUnBwem4rcnd6Tm90ZFpRNnNGYkFKTlRYWndzOWRadzI0?=
 =?utf-8?B?UHh4b3V2TS9maTdSNGhkSVlVQ1ZBcU1Sekc5U2szMjAvNDJNZW13Z2tvMHRs?=
 =?utf-8?B?VEJZMStpYUtuN3lEYVJqSGdLRlh0elRpWlRQRm01WFpTaktkQWtxdGJ2ZTRs?=
 =?utf-8?B?TDVtNFpGMEd3U0FQL0dBemJnSndTT0RWVnV1RVFOVldYckp5TEsybEN0NWl5?=
 =?utf-8?B?ZDQwT0ozS2JiWWN0VDM5cFpMd2NXODRhNWJubnZER2tCT2Ztc2c1aFJYbkhY?=
 =?utf-8?B?SVlTcWhyeERWaDF1VHRWTSt5ZUd3S0FQNFpYbCttQmdudXJJYnA2S0tlcjIx?=
 =?utf-8?B?ZHMzMXJuWXNlVlZwMW9Nd284c0FtQzAzN2xhYjFJMDNsTXQrZnM4RENLaDFF?=
 =?utf-8?B?MlNWSlpHb0ZOYk9VQzVXejV5VGJRdlNIVTVvVWljV1NTVHpFWE5xL1hkM2xV?=
 =?utf-8?B?YjFiTTFGK1ZBV2c2dHBHUG9tVlJEamlyUGZPNUJIdzJkbGNxVnNOa2RtdHY3?=
 =?utf-8?B?NXVTKzdBZncrNnh0N1JTLzlJVmhQaTBYV2R0TndDcGlNTDNDdGJQRXFrbDJk?=
 =?utf-8?B?NGpSbU5aQitGQ0xOZXJqamlNQ2Jac0VsR2FhbitMaWc3YzBPUjlRZmJBb09v?=
 =?utf-8?B?T1QreTYvdEk5Q0xJZFpLUlVXRzNFZ2xVWXRSYmhvTUs1K2pZT3ZRNm9SWHJG?=
 =?utf-8?B?Y3FuSm5MQnBUUVdncW9Yd1FoOU5WbUFlRk12cThIYUF3UHdKbmZodm9LVDNm?=
 =?utf-8?B?c2Mycm9QRVdHMXczUUNXYjM1enp4MHMrSFNMMWpvWk04Y0dkUTNMY0hoN2tZ?=
 =?utf-8?B?cm85elR1VHBHbGFoL3lSQy9rWU1QakVEZG1IT0xib1QwWXFoR1FXcTVNMmhE?=
 =?utf-8?B?YUFnMWRHV0J5Vi9Wa2J2ZDJIdUVDdURTU0JHUWlveEE1aENWcWhSMThoelAx?=
 =?utf-8?B?VENWZGU5QjdIMXk3ZGlER2YxSytKWlFGZGZReDNvSlBTcEFzdXplbmU5VU5s?=
 =?utf-8?B?VWlOUzNIQ3JxYzBWSThvYzN1cWgrRHFSMU1Udk51UTdKbEttVjgyQnlpbzNj?=
 =?utf-8?B?NFl3QW14WE1OeTM0NmFqUld3aFcrWVF4SUFldkduODE2WnZFOXJsdnptK2dm?=
 =?utf-8?B?K1E4U0xrakJQZ2dwamdzR2xReHNHNTJDeTkrNjJSWXFHTVBvL0h4TGpKSlg5?=
 =?utf-8?B?bHFsUWczT200dTdnMEFnSmFZMUNVZ0l3U0xNK2d5R1d6UVQyVVowSDFpZmZL?=
 =?utf-8?B?c0VwOFAySklUSU9mQ1pWV0dXa1oxM1lJNVVwN1d6c3BhTUd4V3N4dlQ1ZDk5?=
 =?utf-8?B?U1NCVzhBT1k1TjZGVHNIZ1hSQTJiMUJwdUhrZWFOSUV5czRaZ3JTUkgybnlP?=
 =?utf-8?B?TXhOazRBUWZkU2l0aFRjNW14cjJLRlJVMGNQQ1lFMk4wN3RxY3JNOXYwazZC?=
 =?utf-8?B?RFppSjJBN2RWQmJNb1JqdG5oMHZadGhRNFZEcmx2aWh5dENFKzJDZ3Z2MmRQ?=
 =?utf-8?Q?RiilpgVzF5M3XwcACx7VqwFNy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5902e664-0d57-4740-f4c2-08dcf4e76118
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:22:58.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CpNKAQoNNyLrF2nryQCWJI1ifPqW2lsPvc6P2Nz74YnXQRoMeRco5SeJOawYfHd1IY+OxW8GZS9sGplbaEkeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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

--------------82725CFCA26AB88DD8D68802
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_sw_init(), and perform
> sw init ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
>   10 files changed, 69 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 21701738030f..2c55166e27d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
>   	return r;
>   }
>   
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
>   {
>   	unsigned long bo_size;
>   	const struct common_firmware_header *hdr;
>   	unsigned char fw_check;
>   	unsigned int fw_shared_size, log_offset;
> -	int i, r;
> +	int r;
> +
> +	adev->vcn.inst[inst].adev = adev;
> +	adev->vcn.inst[inst].work_inst = inst;
> +	INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		adev->vcn.inst[i].adev = adev;
> -		adev->vcn.inst[i].work_inst = i;
> -		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
> -	}
>   	mutex_init(&adev->vcn.vcn_pg_lock);
>   	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
>   	atomic_set(&adev->vcn.total_submission_cnt, 0);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> -		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +
> +	atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
>   
>   	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>   	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	if (amdgpu_vcnfw_log)
>   		bo_size += AMDGPU_VCNFW_LOG_SIZE;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << inst))
> +		return 0;
>   
> -		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_VRAM |
> -					    AMDGPU_GEM_DOMAIN_GTT,
> -					    &adev->vcn.inst[i].vcpu_bo,
> -					    &adev->vcn.inst[i].gpu_addr,
> -					    &adev->vcn.inst[i].cpu_addr);
> -		if (r) {
> -			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> -			return r;
> -		}
> +	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_VRAM |
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&adev->vcn.inst[inst].vcpu_bo,
> +					&adev->vcn.inst[inst].gpu_addr,
> +					&adev->vcn.inst[inst].cpu_addr);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
> +		return r;
> +	}
>   
> -		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
> -				bo_size - fw_shared_size;
> -		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
> -				bo_size - fw_shared_size;
> +	adev->vcn.inst[inst].fw_shared.cpu_addr = adev->vcn.inst[inst].cpu_addr +
> +			bo_size - fw_shared_size;
> +	adev->vcn.inst[inst].fw_shared.gpu_addr = adev->vcn.inst[inst].gpu_addr +
> +			bo_size - fw_shared_size;
>   
> -		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
> +	adev->vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
>   
> -		if (amdgpu_vcnfw_log) {
> -			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> -			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
> -		}
> +	if (amdgpu_vcnfw_log) {
> +		adev->vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +		adev->vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
> +		adev->vcn.inst[inst].fw_shared.log_offset = log_offset;
> +	}
>   
> -		if (adev->vcn.indirect_sram) {
> -			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> -					AMDGPU_GEM_DOMAIN_VRAM |
> -					AMDGPU_GEM_DOMAIN_GTT,
> -					&adev->vcn.inst[i].dpg_sram_bo,
> -					&adev->vcn.inst[i].dpg_sram_gpu_addr,
> -					&adev->vcn.inst[i].dpg_sram_cpu_addr);
> -			if (r) {
> -				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
> -				return r;
> -			}
> +	if (adev->vcn.indirect_sram) {
> +		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM |
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->vcn.inst[inst].dpg_sram_bo,
> +				&adev->vcn.inst[inst].dpg_sram_gpu_addr,
> +				&adev->vcn.inst[inst].dpg_sram_cpu_addr);
> +		if (r) {
> +			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", inst, r);
> +			return r;
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 58fbb87e5ec4..4809da69bd1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -484,7 +484,7 @@ enum vcn_ring_type {
>   };
>   
>   int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
> -int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>   int amdgpu_vcn_resume(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 6fd509e6744d..808d69ab0904 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
>   	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>   	uint32_t *ptr;
> -	struct amdgpu_device *adev = ip_block->adev;
>   
>   	/* VCN DEC TRAP */
>   	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> @@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8f7038190a43..a86cff00d761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
>   	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
>   	uint32_t *ptr;
> -	struct amdgpu_device *adev = ip_block->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   
>   	/* VCN DEC TRAP */
> @@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 74814370ddc9..9967ac3fc51b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
>   	int i, r;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>   	uint32_t *ptr;
> -	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance;
>   
>   	if (adev->vcn.harvest_config & (1 << inst))
>   		goto sw_init;
> @@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   sw_init:
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index a7fb5dda51dd..e89088e3cd1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance, j, r;
>   	int vcn_doorbell_index = 0;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
>   	uint32_t *ptr;
> -	struct amdgpu_device *adev = ip_block->adev;
> +	int j, r;
Looks like j is unused. fix this and patch looks good to me.
Acked-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index c0c2a071ea15..1b492197c2b7 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>    */
>   static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_ring *ring;
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance, r;
> +	int inst = ip_block->instance;
> +	struct amdgpu_ring *ring;
> +	int r;
>   
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 1d1ee6da7647..5b61000f3004 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   	struct amdgpu_ring *ring;
> -	int inst = ip_block->instance, r, vcn_inst;
> +	int r, vcn_inst;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>   	uint32_t *ptr;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 81efc53e7cd3..4d944636d02b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_ring *ring;
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance, r;
> +	int inst = ip_block->instance;
> +	struct amdgpu_ring *ring;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
>   	uint32_t *ptr;
> +	int r;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7873ca91da4c..8efedf943581 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>    */
>   static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_ring *ring;
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int inst = ip_block->instance, r;
> +	int inst = ip_block->instance;
> +	struct amdgpu_ring *ring;
>   	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
>   	uint32_t *ptr;
> +	int r;
>   
> -	r = amdgpu_vcn_sw_init(adev);
> +	r = amdgpu_vcn_sw_init(adev, inst);
>   	if (r)
>   		return r;
>   

--------------82725CFCA26AB88DD8D68802
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/25/2024 8:05 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241025023545.465886-22-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Pass instance parameter to amdgpu_vcn_sw_init(), and perform
sw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
 10 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 21701738030f..2c55166e27d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 	return r;
 }
 
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 {
 	unsigned long bo_size;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
-	int i, r;
+	int r;
+
+	adev-&gt;vcn.inst[inst].adev = adev;
+	adev-&gt;vcn.inst[inst].work_inst = inst;
+	INIT_DELAYED_WORK(&amp;adev-&gt;vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		adev-&gt;vcn.inst[i].adev = adev;
-		adev-&gt;vcn.inst[i].work_inst = i;
-		INIT_DELAYED_WORK(&amp;adev-&gt;vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
-	}
 	mutex_init(&amp;adev-&gt;vcn.vcn_pg_lock);
 	mutex_init(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
 	atomic_set(&amp;adev-&gt;vcn.total_submission_cnt, 0);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++)
-		atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submission_cnt, 0);
+
+	atomic_set(&amp;adev-&gt;vcn.inst[inst].dpg_enc_submission_cnt, 0);
 
 	if ((adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) &amp;&amp;
 	    (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG))
@@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (amdgpu_vcnfw_log)
 		bo_size += AMDGPU_VCNFW_LOG_SIZE;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
+		return 0;
 
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &amp;adev-&gt;vcn.inst[i].vcpu_bo,
-					    &amp;adev-&gt;vcn.inst[i].gpu_addr,
-					    &amp;adev-&gt;vcn.inst[i].cpu_addr);
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;(%d) failed to allocate vcn bo\n&quot;, r);
-			return r;
-		}
+	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&amp;adev-&gt;vcn.inst[inst].vcpu_bo,
+					&amp;adev-&gt;vcn.inst[inst].gpu_addr,
+					&amp;adev-&gt;vcn.inst[inst].cpu_addr);
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;(%d) failed to allocate vcn bo\n&quot;, r);
+		return r;
+	}
 
-		adev-&gt;vcn.inst[i].fw_shared.cpu_addr = adev-&gt;vcn.inst[i].cpu_addr +
-				bo_size - fw_shared_size;
-		adev-&gt;vcn.inst[i].fw_shared.gpu_addr = adev-&gt;vcn.inst[i].gpu_addr +
-				bo_size - fw_shared_size;
+	adev-&gt;vcn.inst[inst].fw_shared.cpu_addr = adev-&gt;vcn.inst[inst].cpu_addr +
+			bo_size - fw_shared_size;
+	adev-&gt;vcn.inst[inst].fw_shared.gpu_addr = adev-&gt;vcn.inst[inst].gpu_addr +
+			bo_size - fw_shared_size;
 
-		adev-&gt;vcn.inst[i].fw_shared.mem_size = fw_shared_size;
+	adev-&gt;vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
 
-		if (amdgpu_vcnfw_log) {
-			adev-&gt;vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev-&gt;vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev-&gt;vcn.inst[i].fw_shared.log_offset = log_offset;
-		}
+	if (amdgpu_vcnfw_log) {
+		adev-&gt;vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev-&gt;vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev-&gt;vcn.inst[inst].fw_shared.log_offset = log_offset;
+	}
 
-		if (adev-&gt;vcn.indirect_sram) {
-			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM |
-					AMDGPU_GEM_DOMAIN_GTT,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_bo,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_gpu_addr,
-					&amp;adev-&gt;vcn.inst[i].dpg_sram_cpu_addr);
-			if (r) {
-				dev_err(adev-&gt;dev, &quot;VCN %d (%d) failed to allocate DPG bo\n&quot;, i, r);
-				return r;
-			}
+	if (adev-&gt;vcn.indirect_sram) {
+		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM |
+				AMDGPU_GEM_DOMAIN_GTT,
+				&amp;adev-&gt;vcn.inst[inst].dpg_sram_bo,
+				&amp;adev-&gt;vcn.inst[inst].dpg_sram_gpu_addr,
+				&amp;adev-&gt;vcn.inst[inst].dpg_sram_cpu_addr);
+		if (r) {
+			dev_err(adev-&gt;dev, &quot;VCN %d (%d) failed to allocate DPG bo\n&quot;, inst, r);
+			return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 58fbb87e5ec4..4809da69bd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -484,7 +484,7 @@ enum vcn_ring_type {
 };
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6fd509e6744d..808d69ab0904 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8f7038190a43..a86cff00d761 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block-&gt;adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
@@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 74814370ddc9..9967ac3fc51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int inst = ip_block-&gt;instance;
 
 	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; inst))
 		goto sw_init;
@@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 sw_init:
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a7fb5dda51dd..e89088e3cd1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block-&gt;instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int j, r;</pre>
    </blockquote>
    Looks like j is unused. fix this and patch looks good to me.<br>
    Acked-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;
    <blockquote type="cite" cite="mid:20241025023545.465886-22-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c0c2a071ea15..1b492197c2b7 100644

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int inst = ip_block-&gt;instance, r;
+	int inst = ip_block-&gt;instance;
+	struct amdgpu_ring *ring;
+	int r;
 
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1d1ee6da7647..5b61000f3004 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block-&gt;instance, r, vcn_inst;
+	int r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 81efc53e7cd3..4d944636d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int inst = ip_block-&gt;instance, r;
+	int inst = ip_block-&gt;instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7873ca91da4c..8efedf943581 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int inst = ip_block-&gt;instance, r;
+	int inst = ip_block-&gt;instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
</pre>
    </blockquote>
  </body>
</html>

--------------82725CFCA26AB88DD8D68802--
