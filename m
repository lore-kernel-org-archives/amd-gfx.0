Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE56DC282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 22:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725AD10ED51;
	Fri, 28 Feb 2025 22:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PN4O/2UG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EF010ED51
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 22:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVG6Cun3iG+WHtyVgDZLDow/+reXkZ08fHTyL3vHvlyZENLpNcKQTfn3iqUElTV5FDbragieRxZqKC0ZUylzfJgZbalcq/jK8v9KorO7PRJfcxDbHD26StSR1GezCXUzF41UdoMIqa6uJHRL84RTqAVl1Qq9+q2f6XHagwzuWFkJbo68UFybeh0tz383EYtMxrpiOlUbe2Clg49kHw7HNE3EZ+h7hhWrNk/pyuFTXy7+gsH9R8hRGQ5cDCrpFrOx9g+Ao0ycgXU4tsRvIL9G0UBSMq/Wna+a8XojYeOrUPKFY4+7vb8u5EBAVlLF5erZJftyEsdZrfPG2fsEN8khpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYIMMr8mx/i1yyCDJMHzzkZfdahwUeOsaxvuUUkvagM=;
 b=lmIjtrru+KgeDPAZwc8gobck32G6QfjzG1IfiCI31JkCTKWt29GZTS+lTHBMb/aI8RI2AUlv5c3B8qmZcK+MphdGBY8/4eZMEHXzaxmPl/XdYl998QBItgg8MoY8zA/EMuGMQBdCAcmKCqYhaDNZmt9SVAcEVkqpToa3HZFQ5KxlVK6Vr/h9fvxgZIW4L7YfE9r5kgQHrIfnwEBlgUGnpmlZpt/gNyktEyh994m9I5SXpty/yefUzj7JvumXaZn9/xlKut/siFMeNS70l5Fr8nZXFt6LCcOIYlheexX4s4rn6wIomMlFjYB5AjNd06sTEVgL6Q2n4GeZ3xS8vFwFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYIMMr8mx/i1yyCDJMHzzkZfdahwUeOsaxvuUUkvagM=;
 b=PN4O/2UGfFqJsQoPCex6grFDiRf3Polfm/jyJrCIbRHdNI1//W/ALR3Dhek7nPcSbHG3BHS/nEHMPS+KSjGZgpKLCBKCyrTMaImIyu0vl3GQh05xDnwdDmJlxkeWMhORSD3f3YagEAoQe/TGkJ9yjku5u0/aO/tRJQoPlvw4Z3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 22:04:14 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 22:04:14 +0000
Message-ID: <b47c433f-1f80-4bd9-b45f-06674a599ca7@amd.com>
Date: Fri, 28 Feb 2025 15:04:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amd: Pass luminance data to
 amdgpu_dm_backlight_caps
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250228185145.186319-1-mario.limonciello@amd.com>
 <20250228185145.186319-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250228185145.186319-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: a8274fc2-35e7-43b4-8245-08dd5843d65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0NDempzZTUydlJjZjNweHBRYTFjaEV4UmN0L2RkMjFFZXdiV0xQZGxJUUdq?=
 =?utf-8?B?VnJlZTdITDNsVmxSMEZFN2Zhb1VISkpPKzVXc2tNSksvQmtSbEtIWFgvZUd3?=
 =?utf-8?B?UlMweTlhR2pnRFZGWjhNamhzZFdFUjI4V0xPeFplcGVWai93N3FIUUJqN0RW?=
 =?utf-8?B?VDg0ZlRIMk82em5PaG03dWFkQXRPZGQ3bE14QVJjMUxibUF0aURZZ3BxWXgr?=
 =?utf-8?B?L1YxSTYyU1ByalJNSXJUZmpxVXNiT0pkRmVmcTMyYytmMk9QanlwZHRhVVlp?=
 =?utf-8?B?VGkzU2dHVFdFcldUUm5hWmw4VDM3MGdGZTNNWThqM0RBcUVKNjFMaVMrVWs0?=
 =?utf-8?B?eEtBcXBiUDhaNTRpMlkwdEV1d2l4eGxUUGVuK2VhR0tIMGEzakVaN1NIMU90?=
 =?utf-8?B?U1drTExkZkFxTHNwQUE0WW9BS0JQSXZYWlRLYjlBd09OMEk5R25zQVFwLzR5?=
 =?utf-8?B?aGRRanYxYWpzOWJFWGRmQzVPaVR4b3loZ0lVbGh6K3FCRnRacnJQSnhpOUFL?=
 =?utf-8?B?MWd3cEZMcklPSHdZU010TVBHQlkxUmY5a0pVTU9Ld0VZd0ViWXdpbW1qaVo2?=
 =?utf-8?B?WW9Jd2tOSks3TXpEcnVyUVNrSCtCeEYzZjA0WU1IYmJRU1dweDVCWW0vY2Q1?=
 =?utf-8?B?aWlkMWtuL2ZSYUNvVlNDV2d3V0RQek5MOUNpTE10b1FEUTVvWmtYWkN0aHJx?=
 =?utf-8?B?RTZYNHNEdzRXaCszaWFXNVpBelplVkVPejV6YjlBYW9rZVllamp3aTRBTG9X?=
 =?utf-8?B?ZmJua01DRFl3SnIrZ0ZnQjlnZzBCbWlMVGlZanRsTGp3cGdXUFhtdWdHV1pk?=
 =?utf-8?B?QmI4OG5nTldkZHU2K3dIUXYyL3lmbU52TS9WSk5seTZxNXI0ODhqczgzcHVX?=
 =?utf-8?B?VFVwMWZBU2Rvd1A3OHdXSURHTkt4bEROZDdkL1JocDVEc1phL2QzaThHbmFQ?=
 =?utf-8?B?T0JQWXJoait0MFJ6cGZqNXZaL1lkQkFXdGRjMUw2QTVoNzhaR1BpQXVIOERj?=
 =?utf-8?B?eHh2SHhzTU9DUlptN1ZwOW85NG9zMWNkUDJTS3F5UHlRbHNCWW8xdE8zeEM3?=
 =?utf-8?B?RlNKa1hTUjljdWZXSVlyaUZvbHNsUWJzZFRGbU9jK2kyNjc1aFA3QjQvNGYx?=
 =?utf-8?B?VVZpN2NQZDlBQ0tSekVJV0krM2VDaVV5L3UyMjY2MDlXRGM5SWhrMWN1ekZw?=
 =?utf-8?B?akRkSHZiT0RUZjVERHBqa1hDeHBvaDR1eC8rSU1kbjJ5WGtYalJTbE5WWFNB?=
 =?utf-8?B?djJJbndORWdvbHVpLzVpdHVvWExaU0UyRGlqVkpDakNZanBXalY4OWxSc25o?=
 =?utf-8?B?SzllRzZiK0JTRjlPM2F0eVNMV1BwQzBFUFZBb1NpcmxXR1ZQdDNsWXVuSDlB?=
 =?utf-8?B?Mk0vbXF5dmc3RDZIM1VrS1JYN2htaXNXQWlWLzFEaUJURmlUUjZLNlFXcWJi?=
 =?utf-8?B?cVdrSFY3MVgvc0dXeVMrOExpKzcybk5uWGZYOVVNVlloRkgzRzJOb2ZVbits?=
 =?utf-8?B?MmpxTWx1WmhNV2tJNGRpU2ZkVFZKMlJMamVaa3piZDVaemJXY2ZXVzFteVpQ?=
 =?utf-8?B?OVg5UjI4MTRkcGZWRUlZaXU5SlhzOVhCN1I5aGNPQmQrVlZuTE4wbWlBejdW?=
 =?utf-8?B?cHpnV1dkVTNGRUd0L2tNUHcrRDkvNzByUUxFeFd1VkNHRysrQm8zcC8vK1Vm?=
 =?utf-8?B?V082T0t1MDE3R3psNzlaK0p3MTV1UWEraXhrZ1pGRFdGR1VaNGZrOENkcXQ0?=
 =?utf-8?B?YUdMRUFsall0MVdQUmRLbkJIZ2NKZ01NdURaYTZ1YldYT3F5akE3UVFBYzkz?=
 =?utf-8?B?YnJuekpaSjJDT3FGT2k1Slg4d1JWVHdmL3BlQ2x1ZkczNjlwZmNGZTlKbiti?=
 =?utf-8?Q?KhxPb73cmG3It?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFc5VjhBM3dZMWY2LzhEbHdVNktpRDcvVDhTQWhFNktwVURTVkNmOGx0YUhK?=
 =?utf-8?B?RzNNUkM1MFlRTUdqZVN2VTlZcFpCUy9wR29ZVW1aNkN6NVgvRzJQNjVGYnVk?=
 =?utf-8?B?aWFkdjRvSmJ0YUxLalpkQmxmZHZYaUJvdWVTTmJCL1JzZzFOUDZadEovVWNI?=
 =?utf-8?B?aUpuZ01ROEdCajRMRzZWMmNUUHdCZ09OVnVLOXlKVmlBTGs4aHlydnVDeHUx?=
 =?utf-8?B?ekNLS3pLWEF6QnJuaU9wNHZQalpSZVYrazRReTlNSStIRGFEWmFmSWNsSG9i?=
 =?utf-8?B?VDhKL01oNlAwd0NuWUpZTkZOTk9UdEMvR0RVZzNla1dqaTQ0T3lmUDVLYWxs?=
 =?utf-8?B?dFYvK1NpeHZ1Ym9QUWY2MGM4bEQ2TEFvMHBJT2N3bU1HVWFCTmxaT1RMYm44?=
 =?utf-8?B?aTJxRnBsQlNuV0tOYTdoOTdsL29MS2FaSWRBK2Q3Y1RVT0M1Z0V0NFN0L1VU?=
 =?utf-8?B?OUJtV0s5YXpKREdhMkRSU2dOMndUZnVBYkxjOXArZTYxZEZXbkhCenlBT051?=
 =?utf-8?B?ZGpocHNsSndlaFdBd3Q4Z0s5WUxOK29CQWh1d3hMeVQrQkVGQlYzM1RMcDNy?=
 =?utf-8?B?Vld1a1UvM1U3U0FTanlIOXl4S2ZpbE13djhuN0xmNmQ0Z1B5UjdWSk16Qng3?=
 =?utf-8?B?NGVpSjBlQ2lEc0hhVTJaa3orL2VXNTFMZlduT2tHSWhoRE03a2xqU01ERjNh?=
 =?utf-8?B?R1lXeG1JK0JadkJWaEZsSUxHaEl3ZkgycVphcW9qb1gwd0ZFR1czZTdRRlRh?=
 =?utf-8?B?SWtxV3RxR3NNZ2ppT0t2YWxaU3cwQzBVS2QxdUJYcktLZ1dMRUJ4T3pHMDVS?=
 =?utf-8?B?b1hScDNKTlRpK1NENi9UYS8vQUNWWFd3UW1ibk1qUjUrRks3SU9sRTVxTm9J?=
 =?utf-8?B?d0w2akdEUE5sdXlPOGk4dnlMWHVaVS9iYjdBUktLalNsakRIU1NPaDltUFJH?=
 =?utf-8?B?eG9OeSs3elFMeDNYWVF0SVoyQ2M3cGp6c3Fvci9jRlpIS1Jsb3ZCK0JpQlV2?=
 =?utf-8?B?RFpxMjRKUmQ4dk1PMXp0L3BFa2ZZT3krZDdFRFIyQ3NXYzVxNkIvaEd6bTRr?=
 =?utf-8?B?b21vVnR4SGJaTGNENENjVjVGd1hxZjdMbTUvUk1LY0VLdDFXN2pnVXNYeWF6?=
 =?utf-8?B?VFg1d1pUM2ZtMnQwV0hxclVvc2ZNTWhHMkh1eVI0ZmY3VC9hWGQwMVJzMnAw?=
 =?utf-8?B?Z3BYQUxPNTB3WDhBemxjMmpCQThHcUhZVm9KUi9zSkN4S3ArcHZNUm51VU5v?=
 =?utf-8?B?OUx2eDhJeXlUQWJXUnhoWXpPN0l0ZWJPakZqSzFzc1VQZkdRdWNwQ1YzWVJm?=
 =?utf-8?B?dlh6cXpIUCtGc0xpTE9LOCtMVFFpNlE3MDNWWnA4THEvVzlVUDVXVUlFY2J3?=
 =?utf-8?B?VGRBVFhpK213T016dUdEZVd6SERNU1JmaDMxeTRJbHpGMFhOQTdrWlcwQUxo?=
 =?utf-8?B?eko2eHlWd0JQV3l2d09jcGRTay8zQk1tQmR5VHVRd2htTDJ6czk3SDNIcmxm?=
 =?utf-8?B?UUNOaGxoMDJrdCtVSlZJbGt5SnhodVgxOVRuMkV4NWxqUHgrWEJYSEgwNysy?=
 =?utf-8?B?dnZDK1d0ZEtWZkFKS0M5b3JCcityejNJWjFScFB1VFF2SEhIbloySGNnNDc2?=
 =?utf-8?B?Rk9pdGozdFZXSWcxaGRTVEZidXhuRVVocU1lYVNucHQ5aS9ZUFMxd0pwR1VU?=
 =?utf-8?B?VWtndjBPNkpkbitQdG9RUU1tcnVGWmJabmZRUXNUbG9iZzA1YWRuY254Q0JJ?=
 =?utf-8?B?K2Y0WUl6cTVDalFYVWpNcXVTK0NYTkRmTlJHQVRpMDFqV2d0cjE1emN2Mnoz?=
 =?utf-8?B?WHE5enpxRW1YTWhuUlZqT25IZmZsbUdrdGRNamw2dWxxcThETCtMZ2Yvck9p?=
 =?utf-8?B?VEZXam52Z292dzBHdlhpWk9Qa285dytSWG5HTXJta0d1dDBrUDVjLzZETEsr?=
 =?utf-8?B?K1RlN0tPdStmK3pZSDk5TzJUazl0NE8zMnJtMFpzZlFTVkNMWXlVTXBERENt?=
 =?utf-8?B?RXJzOXE1d0lncHl2N3hQdGZ1aXBTSkViMXYrcTlCVzZFTXNIRDd3VnFQVTZ5?=
 =?utf-8?B?NW9GQUF0cDF2TkpWZVVRWm54QnhLTGI0M3M3WW1HdDFpRm9OMWM5Z1pOaEJt?=
 =?utf-8?Q?cZJoa4Xped1S5wSimupKX7RLs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8274fc2-35e7-43b4-8245-08dd5843d65b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 22:04:14.0230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYmSteuBceGjwe/Q4Q0PqREege4xpipuFFToPUYn0eiGpFWo6Dojg1AFCAg4rZm1CrRBpCwcnPOpJxUI9vsVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/28/25 11:51, Mario Limonciello wrote:
> The ATIF method on some systems will provide a backlight curve. Pass
> this curve into amdgpu_dm add it to the structures.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Keep ACPI and DM structures separate
>   * Add static asserts to ensure structures remain in sync
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  4 ++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++++++++++++++++
>   drivers/gpu/drm/amd/include/amd_acpi.h        |  4 +++-
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 515c6f32448d..b7f8f2ff143d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -394,6 +394,10 @@ static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
>   			characteristics.max_input_signal;
>   	atif->backlight_caps.ac_level = characteristics.ac_level;
>   	atif->backlight_caps.dc_level = characteristics.dc_level;
> +	atif->backlight_caps.data_points = characteristics.number_of_points;
> +	memcpy(atif->backlight_caps.luminance_data,
> +	       characteristics.data_points,
> +	       sizeof(atif->backlight_caps.luminance_data));
>   out:
>   	kfree(info);
>   	return err;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index f3bc00e587ad..85b64c457ed6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -151,6 +151,18 @@ struct idle_workqueue {
>   	bool running;
>   };
>   
> +#define MAX_LUMINANCE_DATA_POINTS 99
> +
> +/**
> + * struct amdgpu_dm_luminance_data - Custom luminance data
> + * @luminance: Luminance in percent
> + * @input_signal: Input signal in range 0-255
> + */
> +struct amdgpu_dm_luminance_data {
> +	u8 luminance;
> +	u8 input_signal;
> +} __packed;
> +
>   /**
>    * struct amdgpu_dm_backlight_caps - Information about backlight
>    *
> @@ -195,6 +207,14 @@ struct amdgpu_dm_backlight_caps {
>   	 * @dc_level: the default brightness if booted on DC
>   	 */
>   	u8 dc_level;
> +	/**
> +	 * @data_points: the number of custom luminance data points
> +	 */
> +	u8 data_points;
> +	/**
> +	 * @luminance_data: custom luminance data
> +	 */
> +	struct amdgpu_dm_luminance_data luminance_data[MAX_LUMINANCE_DATA_POINTS];
>   };
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/include/amd_acpi.h b/drivers/gpu/drm/amd/include/amd_acpi.h
> index 2d089d30518f..06badbf0c5b9 100644
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -61,7 +61,7 @@ struct atif_qbtc_arguments {
>   
>   struct atif_qbtc_data_point {
>   	u8 luminance;		/* luminance in percent */
> -	u8 ipnut_signal;	/* input signal in range 0-255 */
> +	u8 input_signal;	/* input signal in range 0-255 */
>   } __packed;
>   
>   struct atif_qbtc_output {
> @@ -75,6 +75,8 @@ struct atif_qbtc_output {
>   	u8 number_of_points;	/* number of data points */
>   	struct atif_qbtc_data_point data_points[ATIF_QBTC_MAX_DATA_POINTS];
>   } __packed;
> +static_assert(ATIF_QBTC_MAX_DATA_POINTS == MAX_LUMINANCE_DATA_POINTS);
> +static_assert(sizeof(struct atif_qbtc_data_point) == sizeof(struct amdgpu_dm_luminance_data));
>   
>   #define ATIF_NOTIFY_MASK	0x3
>   #define ATIF_NOTIFY_NONE	0

