Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4981C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 19:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7684310E11C;
	Tue, 17 Jun 2025 19:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chI+azDf";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C77C10E11C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 19:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1Xcn4wzIrM7t50BypTSLtDyCfc5D+yXhBtU9piXsIrucsPPSmOX8jR4S/oRk8Hm1nPLFGEvFhCncxgB4BlEL0UzuBs9K0LwzdXRPjeSiysTbOpWP9Jgg/1V7kC3WcI6oujW1hXOPiRkpyVO/H7BOepOOXHc4v16FTqfbt75nAaoCeR84xhXZTo0rKh5nhS8EAwEV7uOebNsdwVkV5UdC+F2Oy8dDLClUxgV2A2xUJfnSZVfY+sF7z5glKVi8O2Sn2im2GOfyMgZiqjIpgGFz7qkDjIxChM2U1DYNtw49aCpSBhMhGi+VJUG9DSzEqV31Z0+4BLke+XwVrC4cPvkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c07wOB6J8iy1/4MLbRrr3ygeeZMfBUUzpD4xZWtoT8Y=;
 b=yzFaqevUnz0TVMgJ1DdTvQx1Skl37Zh5g/Jq0J7c+uyLmmT/01UDmqHzT0pDIEQJZRpRR6HqlGpTrujnJCSpUKHpsM8Tw4ci5fstz2ZtAijQqEqjhJQDVH65mAz0snupakEmuC5fPB3VnLygOPWCdLp7f8uiHY/BVAyeA1grcSDkTN6SI+00k7DvKX0EM47gEIOg6tG1aOrm/HouZ+VZRcFDMSLspcA6U8KT4fVGv7ThE2KIMDzL1NDaQ5luiapcIiRnEvPIkj+C/S9BNA0ChF7NSeWu3V7ukiHSYpyshI9EggaNnlhD3blQw0t4BZs8wvHV4tiyUsMYW5xELeXlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c07wOB6J8iy1/4MLbRrr3ygeeZMfBUUzpD4xZWtoT8Y=;
 b=chI+azDfy5I9VTq/TykF5fJT+SLNaEuZKV6ltp+3KUfOMxof+W39dxDcnjmJ4NmuJW9FeDUbjelHOt0uNK9VNdZFZWP5jTJx9zj3WiBNmgLcfGEuxN88dD0sSHKiMf8OuHw+Z22pvUbnquSSQgnvHATNzbhTVcz13nmsXFyo7FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 19:23:01 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 19:23:01 +0000
Message-ID: <f8b4bf5b-17ca-442a-a515-7860037a8afd@amd.com>
Date: Wed, 18 Jun 2025 00:52:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-37-alexander.deucher@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20250617030815.5785-37-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0113.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::9) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: f57e3686-7297-44b2-76dc-08ddadd45ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzJxb01LZVV2SUNlWU04eVhlODNtc3I1ZHBCdDNHcHh6SDFlVk51VnNsbERD?=
 =?utf-8?B?SDZYSlRnbThsTllkdCtUMU50R1cvYWtyTUhxcFBYUVhxMldWcjRrRW1ENDZI?=
 =?utf-8?B?UHNTZ3VmV2tlNk1LVGhsUHJycGxTZVVVM1lSZVhzOWpIMnJmU1h3WDBseFVu?=
 =?utf-8?B?YTlHdnB3emJ0dFUxZndXTmhzN3hXSUJtanEzcnpoL3YwamlWaXB2eHlvNDMx?=
 =?utf-8?B?MmV0N00zYUdsMHlWK1JHVnRZZjRTY2ZWdHBMWVd5TnNqZzkvVWNIMjJETGFa?=
 =?utf-8?B?TkpjRGs1QkVmblRYR1dmcURTRmhSOUN6dVd2ZjZUbEVUVzExck0yYkFoL3Ur?=
 =?utf-8?B?eEVMSkJhaDJNKzNvZm93bCtHQ2k0SU1ma3ZiWEd1S0RNK1JxQW5MN05jWmVx?=
 =?utf-8?B?S0ZNckpaM0ZJOVgwZHIyTG5SOHhjUVowN3FYOFNsQlZiTHRXZXM0SU5xeFd0?=
 =?utf-8?B?U3BRSnpTcHlwQW45RUw4SGtjVUxQSWhEOCtsbzQrazZuZjdySzJOc3VCWk4z?=
 =?utf-8?B?dUt3SkcxL1JLZW5BRXNnalUySzVkVm1rVzNzNmt4ZjhwQlpycVl0VUFpVzVl?=
 =?utf-8?B?QWRTRzVjeXJ5T0tBY0JKUVY0L2xSNCtoNDNpcjRJVEI3OTdtVU9GUGFOSTE1?=
 =?utf-8?B?TkNGckVZenU2U2tYQVM4V1Zkbk8zRDRFNDdoaGRYNHpFVGdnb0p5Skk0ODdm?=
 =?utf-8?B?ZGRhWHVBbFVra1F3dS8zQWg5K0NtWGF0N0Z0dGQvdnc5MDNFc0NhREE1QlZj?=
 =?utf-8?B?UHhYUU5GOVZuTWFZMS84NjdwRXlHL016VldEV01vWTQ2Wk1Mb3pDWXNBTW1F?=
 =?utf-8?B?NE90MjBXQThqaGppbmJueE9JNXdDcFF2b2l5WkowTytEZ0NHU28yV1Nianpa?=
 =?utf-8?B?cnlJMUx4a1RUNUh2S3FQQkZ0ZHZBdGFjY2Z1UXVhVmFkcDFkN1YxMXFFNXNX?=
 =?utf-8?B?dHlJRGJwQ1RrQzI4Y29wN0dMM3NnL2VEcEJlQjBQbU1OdDlkUkh1NG9oOTZ5?=
 =?utf-8?B?MzZHUHFhWThEYlZqWXFSb3h4bVkxUlcySmF6emNRMTVvZ1VzOUtQM3E2NUY5?=
 =?utf-8?B?cWkvRmJhZ0lPay9DMEtzQXc2NGFpeG41K0RWSWlaM3JNdGo5amdDeStPRFFq?=
 =?utf-8?B?dVRNYTdNbUdneldNMVh3UDBrNkJiWisxYkRLZDFTZjhQb0ZXTWdONWRPbnRw?=
 =?utf-8?B?V1F2d3JlcXhSOFBtcEpLK0gzTVBjRTNVdGx2T1NMd01YOUpPdGwzNHBtTng2?=
 =?utf-8?B?czViRTBmL2xwTGU3bDNuU1lmaHRNb1Y5OVRVa2U2THBMZFpkSW5GWmlIU0hq?=
 =?utf-8?B?S0FxQ3ZldjZjc1VWS0NKUklBRFNSaE9iZW5ORjFIeTQ5YkdSQnZKTEJNNmxX?=
 =?utf-8?B?ZWFTR1BKT1dNd0RsTEJnZW5QYUhKRWpOR2tSUXI1SHhaVWRTbU5RTkVFUmsy?=
 =?utf-8?B?RlNCWVEzQm1RaUdRdUlOdDBCVitpNzEyQlNzdGRxcEF2M1Z6ZEVZR2F2U2xU?=
 =?utf-8?B?NFNIOVBTay9USmpSbEtjcks1bVAwOGJwWVdwUjBPVXVsOW8yb01qalZYS2Zq?=
 =?utf-8?B?YXJVdGxGWS9LK2ZYOGYxOUJKQnFod3Z2bWtzUzMyVk41SXFNSEcwUlY0ZG82?=
 =?utf-8?B?VyttZ3o2aVNZeFFtR1YyS1hScGZsWGszckJXOVJxcndkWlNmeFFHa3gvWGt5?=
 =?utf-8?B?RVdMT0dTbFRuN3VjVHI1MXFjNGNObHdpUXR6MnRoaUhTK2pWTWQyaVZtcWI3?=
 =?utf-8?B?VnFaTVh2alVkUWlIKzZYOFJnMGF5ZnZSeFNRTlNFTVZFa0M5dXNnZE9BV1dp?=
 =?utf-8?B?NndFZUoxbzRCM3VWQ2Z6eG9neTFmUzhRWkIrN0s5c2t2VDNuY0FNTGZwWUNX?=
 =?utf-8?B?UkNwc094dUVYNERaTEpJdms0WVF0Z05ZSWlkVmxHRkUrOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9tUGVBc0MvK0tIOG9sSC9Pb2NrVHJYYmYvOWcxZERQWHRJZlRHcWhQWkMz?=
 =?utf-8?B?Rnp5ZGZFTFp6N09EdmFyeXBlVWNabHk1T1dkQjZPaFVZdmRCaGk5Yk1BUzZj?=
 =?utf-8?B?OVR4bzlmYXVkUkNpZmcrb1c1aS9VNVFmcUJzN0Jodm9qS0ZOeU54RDQ0ZzRG?=
 =?utf-8?B?SUsrZ1lnUVlSQ1R1c21rYk11ZHpselBsY0lnUS9KV2d3SFhTZnVrWURERDR4?=
 =?utf-8?B?WU5sQWxSTFZzT3huS1ByNlZXVkZtNjBNTS9HN2FGYmc2SDA5MUhDYnFwc1FX?=
 =?utf-8?B?L3ZhNUNPcXJPTDBOQXJnVWdEZHY3Um56K1oyM0RTb3JuOStLRXhQalh4R0Ft?=
 =?utf-8?B?aExaMTRlS2pacHByaGNsMW8yalFIdTVyam15WEUrK1IxeXhkMkd0b2pJdE8z?=
 =?utf-8?B?djVSWXN6VWNqYmUzWWlydldFVGd1bUdhRjZxVERGWE9VNTd1ZE44eHdQeUgv?=
 =?utf-8?B?djl0QmNJWUxwRnRVTUJQR2dLSUdGaWU4NDNRdTVLZXV2SFZKUW5tS3ZFRGFY?=
 =?utf-8?B?VnZQWDZ6SGFnbWdJNERpQXgrM2ZIaUdwME5HWWhWTFNtVC8rb0IrL0Uramta?=
 =?utf-8?B?bExIVXJsMmNPdVRJTWNNMlI3anl0RnpIdkxReDV4ZTdvSjcycmVadXRUVFRM?=
 =?utf-8?B?WWIrc1h5R01nMVRNcXRnc0NlSjdIQlVWdjJudXF3TXAxcmRObkNyRU01d21V?=
 =?utf-8?B?ZlNUUlVqemNUVG9uSDlqbWg1a0xmT1BaT2ZZSkZRR3R5dW9PaWxJYlZ0d2Jm?=
 =?utf-8?B?YmgvOHFXcFRnQSswREZFTW12TmFkR2FWbGl0Sk9NZFpxVUQyV09jN2lQbk1C?=
 =?utf-8?B?cjg3S3VLNlU3VU8zcTRHUXVVVE1zMzM1TTlOMmZ1MnRsay9ueXJyZVMrbDN2?=
 =?utf-8?B?akt4OXV5aFJMNXBBN2ZmM2w5Y0EzLy9ZTS9qWjVPOGhhWVNRYWNISE5neVdP?=
 =?utf-8?B?dVF6WC9GeDEvZHVISDZNNTlOTzBWZ1IyaDlBaU9PT0V2WTVMbmhDZXU1Sy9Q?=
 =?utf-8?B?eXlQdHZjZzUxSkY3MUV6N0JkNTZtN1VCa3RlUlZiSG9NQnhEd2QzZnltZVpj?=
 =?utf-8?B?d2JROFZsZG96dzFmWXdzZEtlUUNSeEc1eXZNM0JGTGtFNlF0dEN2Zzd1d2lu?=
 =?utf-8?B?UmxaV0FpR2JxRy9DUVZiMHFwZGs4YmxpbzJSam1aY0o0bWYxK05kbHl0Qlhj?=
 =?utf-8?B?NHZyNzk2TzZYTlpIdEQ3ZGkwRFE3R1JaMFg3SkNuM0VWMUE3bjB0TDRHY1FO?=
 =?utf-8?B?YncycnQ0WHZjUm8wMEw3bEtmM2VETjdla3ZYSXVTd2VTdEo5Qk1GazlYTkdJ?=
 =?utf-8?B?YnExMjZ1UEphRk03Mkt3VkhrU09NMkxRb0ZhMjBjb3dPU0FTZlBvNVhuYmdQ?=
 =?utf-8?B?SDBoTEpXSkszTXBVL1BnZlRoSXZRdW5hd212YmZoeFNZRXRZbmxlSXBhWlY5?=
 =?utf-8?B?bDZ5dGFSYWQ4SnpNOUJWUm1CZENXK2J3NC9HU2p1NXJKdjRraFFmWjdFU0E5?=
 =?utf-8?B?L1c3UkI2aENMVjluTTJFdjhwYy9IYXRLM0FHS2hvczN0M1FQdEppSm9ncVJu?=
 =?utf-8?B?WmFjMCtXNVJyeTRBV2VCNFA2cGVqZysxL25kN3FNbmgzQ0tnK3J3VEtwdFRM?=
 =?utf-8?B?VmZLUkRFdCtpQkh4Q1ZadDVISmJtT0xSa29EVFZ3U2hYVGwwUDFRdkVqak9G?=
 =?utf-8?B?NE5mRDk5NitrQ3hkZjAvZ3B5S3NyT3gvd01zdVNSTFoxcDJ3a2F1V01MWndB?=
 =?utf-8?B?ZlhQZUNzajc3ZXN5akEyNWsvNlpCcy8wMVZxSjNMdVZ1bzRIc08vSW5oS2tV?=
 =?utf-8?B?WmlPVUMvQy8xQ3c2TVdKa2RsVTJTYjZGTkdxU1lJY1Q1K0xRaEJ4ZXdHam1L?=
 =?utf-8?B?bGlkTHZrVkFUck15cGw5Qk9xTzNYbVJyVzdSZmtyS2xUSEVvT0ZwNXcrMm5v?=
 =?utf-8?B?dlVxSXl0dmlVYTBjcVcyK2lLOGxJUUtvSUNETkRlQ1JFWDhHVUxQZWJINDAv?=
 =?utf-8?B?RVg3VmQ1eVdHdXpjZWFITHVWM1VKbmJwZkN3N3R6bStLSTdMVnFSTll1WDVp?=
 =?utf-8?B?YWFzblg2V2Q4N0lmQmV6SUcwb3ppVG5Kc0thYXV6SVFwd0l0c1pVQ1dTTFhR?=
 =?utf-8?Q?YXcbNuAoeCxaruji5LClqGwnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57e3686-7297-44b2-76dc-08ddadd45ff8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 19:23:01.4140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFpwkfYsXh28s2411U3/aQOJyKNdZKtbUDC+523fIyU7yjWD3mhmFATZTZ2Efd5o7v6YZh6O0LwhdxOFILKXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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

Hi Alex,

On 6/17/2025 8:38 AM, Alex Deucher wrote:
> Use the new helpers to handle engine resets for VCN.
>
> Untested.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 9fb0d53805892..ec4d2ab75fc4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
>   				 enum amd_powergating_state state);
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
>   				   struct dpg_pause_state *new_state);
> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
>   
>   static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>   static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
> +		adev->vcn.inst[i].reset = vcn_v3_0_reset;
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -1869,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>   	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
>   	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = amdgpu_vcn_ring_reset,

You probably wanted to add reset callback to vcn_v3_0_enc_ring_vm_funcs 
instead ofvcn_v3_0_dec_sw_ring_vm_funcs.

With that, the vcn and jpeg changes in this series are :-

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Test exceptions: VCN/JPEG 4_0_3 and VCN/JPEG 5_0_1.

Regards,
Sathish

>   };
>   
>   static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> @@ -2033,6 +2036,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
>   	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
>   	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = amdgpu_vcn_ring_reset,
>   };
>   
>   /**
> @@ -2164,6 +2168,26 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
> +{
> +	int i, r;
> +
> +	vcn_v3_0_stop(vinst);
> +	vcn_v3_0_start(vinst);
> +	r = amdgpu_ring_test_ring(&vinst->ring_dec);
> +	if (r)
> +		return r;
> +	for (i = 0; i < vinst->num_enc_rings; i++) {
> +		r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
> +		if (r)
> +			return r;
> +	}
> +	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
> +	for (i = 0; i < vinst->num_enc_rings; i++)
> +		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
> +	return 0;
> +}
> +
>   static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;

