Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506B9E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D820410E13C;
	Wed,  8 Jan 2025 16:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XfJ548Vs";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92E710E13C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSzy+0s7ukpPzccY5LVdwpxUyc5kB9Gq5ogldJ2c9vdfL1v0cyrMWpnLJ3RJ6MZ15hkPH5bEEPprbS53EXEKKmyNKPm1jpoyktaquGok2mHnGGd3AimD9jSBvQ/RaE/BqZcBWK5vmnNtCzcyGZ38F/k/s2HjbtrDPOaVbOCWSKZgwR4wk6N107DiK1gK9cCUErKyP13z8KpTGQl0W9vMdi43ZywwDXeXadhqTWaRuRAcEvAlBHBw3L4uPnh0sSgAeAzh/OdpAsN/RI59E+f3f331dvBYM0lwgk52GxKCkGLcXUYPGtDZGkkOl1cqk0HDfTaCOHG54hdvw/xo+hMo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxU4dtmhzumR0KOGRxIbJeYkocH16obc6bxhCjVMDug=;
 b=VOk17slMPCxavVvEA6vsWuI0paatVoC5X2+XST75FJIA23SCjEQlldeZ5mNvlm+4worCwdxBEGqeRhEcnBhkDmniGcjMj8e4jzIYX47JTArwiLdVZ+2U+M8JbKmdUVfAV+tZZGSM7t6ARAPxzbIoN8T6NQOLAB5nSL/sIEaMtT/c5JtGB+5ndUgQcFvTemsuoEpbwsSvFekZj5hZeSS+YsLX+VxhV1/DI3WQkjIo2LYKBbqEkQopo7jFTvTnjdnavwnJcSSD40/TnTCjxtf1OZEBt3uzMDKEdBwgPH2/FVHRfS18PJv5MQPG0TpbW0yH5H9uJXHhiN81dFuIg9ySZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxU4dtmhzumR0KOGRxIbJeYkocH16obc6bxhCjVMDug=;
 b=XfJ548VsHOVtnRrI1xcSz8fka0RKrZ7/bJrtCrbe9C8m+2494c3aDmSaXxUVP+++LeP7b4P3lBAOC66WrbLt+UVD/HRV7CZ4dtdiODCg6YNy725ItYFtz7AGQVHQOBv1rhN1FjbCZ3Ee6YoEQOwy9oJr5NcZI3T/Wt8aH37cZuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 16:00:25 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 16:00:25 +0000
Message-ID: <4aeb5922-8fb7-41c6-9144-b202bc12fde0@amd.com>
Date: Wed, 8 Jan 2025 17:00:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: map doorbell for the requested userq
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, veerabadhran.gopalakrishnan@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com, christian.koenig@amd.com
References: <20250106164530.763188-1-saleemkhan.jamadar@amd.com>
 <20250106164530.763188-3-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <20250106164530.763188-3-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d799e28-f306-43c9-81b1-08dd2ffd908f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N21wMVVmb3dCTmRnMHJpeG9LVG8vTTBMMVJuQlFtQXhwV2RHMUZhZGIyZGlk?=
 =?utf-8?B?bVN5K0RIWVZOcDJ4ekw4ajAycy95UDJjR2xwWVUrbWZHdzdDbGMvTXh5NEUy?=
 =?utf-8?B?SEtIWDNDT1RhTVVGZnQyWEJraDJ2NFdJaCs3RncrOHFQTXVmRGNrWTY5VGZs?=
 =?utf-8?B?TkRwN0YvNTZGTjRucElPcGJsZ205Rm5rMUV6YndHQ01yOUV2U3dGY1pycytl?=
 =?utf-8?B?R0p5TjlyMTlFcGJlOHFSL2k2R2dTTWI1S2ViR1RZbmlJdXMyckt5d2F3ZklG?=
 =?utf-8?B?UUNrWW5Nc21TQ3l3ZFhwMTZzVUMxT2UyUWlEM1dENXBvcWdML0xQVDlzVVVh?=
 =?utf-8?B?UFZUaVJtRjc1bit5WGpGa0ZWOUJ3MnpKNWtqbHVML2tXU2ZOeVAzUW94NDMx?=
 =?utf-8?B?Lzl2TmNtTUNyY3Q2ZnJ6L1hHTlNyNjh1Q2VTS1kxWW1kSGlXMVBYRjdoblFt?=
 =?utf-8?B?TWk1aWFsckVIZWh3UzVEWnVEdVc1NzIrcDVzZ284VmdzbHRzbGMxbzk2VUdK?=
 =?utf-8?B?NVp6MXFXN2xQSDI4bFhZdHFaWjBGbjVtQVNldkVienQ3OSs1M21veXFZcDJ3?=
 =?utf-8?B?cklSclhQMnRlVHlnVGcxNTZLSVlDalNvSzF6elV1TG05L2tPUk1RWjFXUFE5?=
 =?utf-8?B?dk9JR0pXcnRMbGNIN2RIcGs1NXlQL3lhcGN1Y0pTdUlNTFVXd0pIWEVNQnlx?=
 =?utf-8?B?NWJZSURMOEl2cVlieVVZdjF2SitCRnQxT09OaDJYekpEUHRON0dDTHBqc0VE?=
 =?utf-8?B?R3ZubUlrTy9NQ1dwZm5CYXNkV1B1WXcwUnZ5TS9jNFdnb0pGUXEzMlhrNnVu?=
 =?utf-8?B?UENESDUvVDRKVXNpcUtDeUEzRWxRTzJEbUNPUjUyMmcrZjFjSGU1RnN0ekQz?=
 =?utf-8?B?MDIvazJ3cElUZlhhc1A1eklvL3l2bWZPaHI2KzZod2lHRHJIWTBJdEVScEx3?=
 =?utf-8?B?a1ptRjkrRlFscW43cGtlODg0eWkzY3ZmZlFNczVVNkhPTVJ4Y3VnSGdla3g2?=
 =?utf-8?B?d3ArWnFvRm14TEdrVnFYV2gyWGJqaVlCM3VHSEVNUEtST25PK1E4M2MrYW43?=
 =?utf-8?B?SUlhZEVKU29WN2FERDc0aFdqV21nNXlGVHpRVlhNQnhhV25CM29wMDBhUFJR?=
 =?utf-8?B?T0tVT1Y5ZWo1c2xPQzJLd2l3eXRLTzFCZjBjakhRWnQ4Yzl6aDljVEJKNGpT?=
 =?utf-8?B?VU1MTTR4THRaSHFzQVlPenYxMUJoemFDZXhlbGFKWGptRVgyNmJXeWpzYlFh?=
 =?utf-8?B?bDkrd0ExbWgxOUZKZ0tEaVdjR2RzS1lEcEFNK1ZWZytVNDBSUEtRd0Y0Sktm?=
 =?utf-8?B?RzVvSnY5SnB1WkhmYml5YkZRVEZodlRvNGxFNTVMV0JRMGUwRkN6YVpaYVpP?=
 =?utf-8?B?S0pKUEdETDRHRzZ4YWtUR295Y0Z3U1hiWGFrSjRsODJrOHBlQUZZaVViZmx5?=
 =?utf-8?B?WC82RkV3VjE4NXk0ZlQxM2FIckpvaDZQU0dSYllWdTE4a3A5alRxczQ1bHQ0?=
 =?utf-8?B?SW96dFJuQnVwaVBQYnI4andoNHZuK2orNnpMQzQ1WWZFblZOYlpuaXJjb3Vn?=
 =?utf-8?B?TjJGSDJZaG9sdmVqbmo3UUIxQlR0MmNaRzRlZVord29LNGdGZ1dKWVFOU2Vn?=
 =?utf-8?B?MHpqRFVwcFA1T1ZsZm9GRVEybFlpR1pScFhVd3IxOTAvYjlaTHJhWXF6UERS?=
 =?utf-8?B?bTU0aTBEYUVzQW1NSUtJV1JjTitZbU1QOCtqMmxSN3ZSOThCWERSbGZHUm8z?=
 =?utf-8?B?MWlFYXhWNTl4MzlJVmdHVGJnQUdaSWMwbk1GZUIvVGNsTlBhS09DUGF5NG1h?=
 =?utf-8?B?eFVoRDJWajRIRFF5cW9aWm1qYmF1QW1JV0ZLUmNFeGloY2lTd3BuQW1TNHAv?=
 =?utf-8?Q?4jhO0tfhTTThP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Q5VmdWWmNIWG51dUZoVjNyTDVRQ2Jpc3B4MW1Ka2JtdkJvcHhQc2E0SXhE?=
 =?utf-8?B?K3BvQUgvTS9paTdlUklkSkppMDE4TS9yRFpGUStvZ0p6RFFMbGROeVpjT1Vx?=
 =?utf-8?B?TjV3Z3ErQTZWcHFud09SeXpHL3dtSFpXRHJ2OUNYbHZZaFl6VTdJRWpnVHdL?=
 =?utf-8?B?SkFXWWRPcDNvVjEwcTVqdW43WW9nRm1SeDR0ZzZYTlRvNDY0TGxWL2lVeVRq?=
 =?utf-8?B?QUVUREhsUEJwWXlWejZOeVdQNjN2NzMwb0RzamVMNFk1VTF0ZHFuYm1tbE94?=
 =?utf-8?B?ZEk1TEEwMUpwRU5GOGNaVDZ5K2s0RHJXcjduTi91bU5Ec3NuZVlnQ2FtQlJX?=
 =?utf-8?B?bzRLNytUbVpBbEswRDFnK0ltY0J1V3M1RHU2dll3Vys5K2ZKWTdYeVBIU0ov?=
 =?utf-8?B?NVFmVWd5Sm9OL21RTFpRZVV4OEgzY3hEMXVSYzB2WVpCQXhFemJxa1pKSTk1?=
 =?utf-8?B?WnRBZ2xldHhDVFFlcjVOREdFcng4VkFLdCtmK0ZZeXZPdncvVmdEUGlZUXhI?=
 =?utf-8?B?ZDFlRUZuTXdaTndOTTh0QVN0Z09sT2xTMWlyMllLSThRaVh2bmh4UzlRN09n?=
 =?utf-8?B?UnRJNnJ5T1NhKzR6OWFwNDM0U3preHlMWUs0Tm1ib28vU09uNis0QkRSaUZs?=
 =?utf-8?B?N1RMWlBsVU9zYjh0RHlXNExXRWM2dElKS2R1RHJjZy9FTDVkVHFTTm5WZ0xp?=
 =?utf-8?B?SG1TYkhGa1JEcm5NdGt6NFF2ZXlKWURhRGVhZEc4SFE0Zkw5N0VnZFMrVFUz?=
 =?utf-8?B?U2NHL1ZwQy9YYVV4akJ4RlI4elZoZDdtSXF3ZUZmaFpnckNUNFFZcGcvSGk3?=
 =?utf-8?B?R1p6WkdTRW1FbHZ2YWtXWXhTNVc2THVOQWY2bGtTR3k2UWo1RWp5WTdHUGU2?=
 =?utf-8?B?aXg0OGF5cUs1Q0JwVWpuWVVNR3JrVEphS0N5WUVBVHhSV2l0SUdSNjJ0dHky?=
 =?utf-8?B?ZmhsVUEwZDIwZDhQV2xuUUgvcHVaMysyb29MdVA2Tk1wdDZpU20zMS9WMWNj?=
 =?utf-8?B?elM4Ty9yQ1hKTnVpQndUWDIySG5pc2p4QnM5SmZ1RmxoWXJZVnJwU0JVRGhv?=
 =?utf-8?B?bWlnQ1BwcE5lNm9WdEY1Y1huUy9BKytaVTZwa1FIaEpmZ0thdkRBWUVoYVBC?=
 =?utf-8?B?ZUkzSlhGTXB5bEpCY0lhYUU3WVhEYkpRanVvZFdRNmJ1NTlkWW5CR2RzMmNI?=
 =?utf-8?B?Y0RuVUJFRXFjTnE5ZDg5SS9abUJBU2JZMmVqL3c1eEhuY0NKRkRyOVFBdXQx?=
 =?utf-8?B?U1kxRnpnWEZNTEpHVS80UWRtVmZIV2dkWjFyNVJuRVMyMkxZdlVZc3BvenJ5?=
 =?utf-8?B?L29kZ3kvalNyMzFhOVBERnB0QkNrYUlDTnRaOFVaNGUzUFFaQjg0OG9Cb0w3?=
 =?utf-8?B?QlpwWVV4dFp3YTRXVVNybjdFeE0rZ0NUOFVPeW9OSWZsK1kvWFpVZkh3cThM?=
 =?utf-8?B?SGhTMFZ6amhwWG9RaURzWnI2VjRHVGRxWW1Zd1R6Wjd0ZWNwQmV3Q2NxNkZz?=
 =?utf-8?B?dG9QMksvbTNZQkc3eTRHK3hKOHdPL3hueDZLN1JwOHluZitySmo5bGQ0aGNs?=
 =?utf-8?B?cEcxNTFmK0xVRVhlSW9OOU5ibkVuNU51cW9Fb3RPOXlQOUFKdzVCRHZwRDRj?=
 =?utf-8?B?TThOY2JyMkExNG9YYTNacGo0V3dJSU15VHd6WjhRWWM1ckY1SURMQjkxSUlE?=
 =?utf-8?B?ZXJBd0V1cjExLzNSQ2J1ZUNlaTY5Rm5nYUJFU3k2eEtBYVp1MU83QlFhV3h0?=
 =?utf-8?B?MCt2TW14WkFSQXBuWEhPdGc3QlVCWm5CNk4rc1c5cnl1OXVkWDNnd2lrZ0pm?=
 =?utf-8?B?aitFYkRsS24zNXN3eldITXpPSDZodnRSOS92OXBlR3ZNVWtsNko0TUp1SUlJ?=
 =?utf-8?B?eTdXNEkzRVRiWmFOUVlnRUsvcEFrWW5DQys3eC9pM1RscGZWcldzV2lkMEdD?=
 =?utf-8?B?Skp0cy9VOCs3ZHdTckxtMnFmNGJLWTBEejlQSjRmT3N5MFU3TkI2bHFvRisr?=
 =?utf-8?B?c0xyd0tpZ1kyeEg2cXZwSm44ZFRzTnFCU3h4Z1NOUFpGbmc2YVFwbXZiSFZC?=
 =?utf-8?B?UWtrRU1ZUkpLWkkvMGxrL2hKOGRNNEJ1NGhDOHNPSStYbzV0ckJySFlzdVVI?=
 =?utf-8?Q?pIpqYTgGcIfoHh9NbO/cNxYJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d799e28-f306-43c9-81b1-08dd2ffd908f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:00:25.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDtX2QAMBHE8XtVqD+QkP3G28/KbsNXscJCDQyE6gLB5a7gkzgtV//isPiIjcITXrCJE580i3ku07wYPTGcH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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


On 06/01/2025 17:45, Saleemkhan Jamadar wrote:
> Made changes to the doorbell mapping func more generic,
> by taking parameters that vary based on IPs and/or usecase
> into db_info structure.
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>
> ]
This line above is garbage, please make sure that you pass checkpatch.pl 
for all the patches in this series.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 27 +++++++++++--------
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  5 ++++
>   2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 85baba323ba5..769154223e2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,18 +189,17 @@ void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>   	amdgpu_bo_unref(&userq_obj->obj);
>   }
>   
> -static uint64_t
> +uint64_t
>   amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> -				     struct amdgpu_usermode_queue *queue,
> -				     struct drm_file *filp,
> -				     uint32_t doorbell_offset)
> +				     struct amdgpu_db_info *db_info,
> +				     struct drm_file *filp)
>   {
>   	uint64_t index;
>   	struct drm_gem_object *gobj;
> -	struct amdgpu_userq_obj *db_obj = &queue->db_obj;
> -	int r;
> +	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
> +	int r, db_size;
>   
> -	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
> +	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>   	if (gobj == NULL) {
>   		DRM_ERROR("Can't find GEM object for doorbell\n");
>   		return -EINVAL;
> @@ -222,8 +221,9 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   		goto unpin_bo;
>   	}
>   
> +	db_size = sizeof(u64);
may be move this line into next patch (and, where we are overwriting 
this for other IPs.
>   	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
> -					     doorbell_offset, sizeof(u64));
> +					     db_info->doorbell_offset, db_size);
Same for this line, pls move this to next patch.
>   	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
>   	amdgpu_bo_unreserve(db_obj->obj);
>   	return index;
> @@ -268,6 +268,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *uq_funcs;
>   	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_db_info db_info;
>   	uint64_t index;
>   	int qid, r = 0;
>   
> @@ -302,19 +303,23 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   	queue->doorbell_handle = args->in.doorbell_handle;
> -	queue->doorbell_index = args->in.doorbell_offset;
>   	queue->queue_type = args->in.ip_type;
>   	queue->vm = &fpriv->vm;
>   
> +	db_info.queue_type = queue->queue_type;
> +	db_info.doorbell_handle = queue->doorbell_handle;
> +	db_info.db_obj = &queue->db_obj;
> +	db_info.doorbell_offset = args->in.doorbell_offset;
> +
>   	/* Convert relative doorbell offset into absolute doorbell index */
> -	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
> +	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, filp);
>   	if (index == (uint64_t)-EINVAL) {
>   		DRM_ERROR("Failed to get doorbell for queue\n");
>   		kfree(queue);
>   		goto unlock;
>   	}
> -	queue->doorbell_index = index;
>   
> +	queue->doorbell_index = index;
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 1109144ed7e0..34b4a7eb79ac 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -105,4 +105,9 @@ int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
>   
>   void amdgpu_userqueue_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>   				      struct amdgpu_eviction_fence_mgr *evf_mgr);
> +
> +uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +				     struct amdgpu_db_info *db_info,
> +				     struct drm_file *filp);

please fix the alignment with the '(' above. checkpatch will get this 
one as well.

- Shashank

> +
>   #endif
