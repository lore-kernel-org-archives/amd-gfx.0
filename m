Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08592C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 14:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8482F10E2DD;
	Mon,  2 Jun 2025 14:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjXBrh/C";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21DE310E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 14:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuzkH+XgiL6UhSS3gS/Un92eX15WkO2cOlEG+Sp9EAHLWfpLRT4oelSHK90db1d6ROtAWpXLx6YZ5VVKiG/6z86RlqXxxImJkUqkdknNUgpSxQnaY54Ub1tcX9WXiXnk1wPYnws/6Jx4ilyluvLhfxMxzlTlRxjWffu87/m6+FuxJf78Bl6FLYdTo+yW7Nq3QU1T/xhcQli67IgfZEvwsOYN+Ro/1eLI8vhKyZzk4bXN5VyxOJEP2Wmz2SwEGKlvHlKM1EO/hXcHmwcaLyYVtyTvB9EvLXT8zB3hfQQUFGv4NfYjNIPvxu3CVOPTmdvCoxHqiufA0xNFBB2xllOITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUP+k9FH+cDBm7nyeSCJ7waurMHmk3tUFH70Ey7+248=;
 b=fVOSDHiAV8wZb9mW80z17I9A7r/B6YMSa2ULcEPXtn1oUv0BaYV3eWAGIqE2cxpyQxFeFgGNi1DkTI+O3jVJRWJZ4mMOZirZAgHE30B78nfU+dwwmTnHbyqw7Re0r0JpSkE+9U39w6WIieIy/YzBoR/SaSxvNa4JOH6QtzXgWXVWI1nulkHx5Nxdum3Ch6kX6hZBW2Ib+Y3hXuZB4nGLNhAK6h9c8YzSCM6Kll+sipZL7bHargTtExi40lV1Dm49unk5ACXze+eLjCczTOhFcVx5Kc6GGmZbvXGcMNaPde8iwk9tti6f8Mom2TNsi7OBueb3BuHRj4aZLVd3vv/hwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUP+k9FH+cDBm7nyeSCJ7waurMHmk3tUFH70Ey7+248=;
 b=BjXBrh/CEBH0eS0oBlC5rQe04yc7mRsbJbeTbK1z8S0eAgyyVPC93aUw55NxVaMeUdk7ZCaK9d5km/WAdnJGJti2/2nH1JLslHCC0ZH98YKIjWQUWOsYsqD5l9DPKiLB6VVglRhFOEmu8QFJpRVmV5NTgdvvJHeBZ7orBmJUzn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 14:27:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 14:27:54 +0000
Message-ID: <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
Date: Mon, 2 Jun 2025 16:27:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529200758.6326-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:52c::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: fd32866a-ea78-478a-594b-08dda1e1a959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3RURlhYbEVNbmg0RVRNRlNteWdmcUNieVNnZ2pEZjV5Zk5LOGdpcUJ3MkMr?=
 =?utf-8?B?THpEQ0F0UnpWenA5UHBaUzVZRDBaSmlUaGxxTVZwU09aMkxTMVYyWnVHTVRU?=
 =?utf-8?B?LzBjQWMzQ1EyTk1XVU9oSk9jWGdrbVJvVTVvOVpmNVRHcGxvK0JpR3FsT0NT?=
 =?utf-8?B?NlNLY0t0SGNMY3ZXb2VYN2JITUlvZWZZbTVuWExOdXp5TE1oYmxrZzV1c3BQ?=
 =?utf-8?B?ejAzZUZzVlR5MUJNdG5QYU9Cem81R3FkZG1UUmN3QUcxWWVnMEFBSkswMW5y?=
 =?utf-8?B?YXJubThSaVZnanIxRTRTMzdUWndmZmIrcFMrdkRjc1dEcFN5dVVJbmZ4VUtQ?=
 =?utf-8?B?VnpRR0F2RFkyY3ViZkJIWjcyZmhPZWwyTUpBMmxxRm5lR1I4WFRjZ0tVeC95?=
 =?utf-8?B?VnUxcVFZUXlHdUdnMkZibkNLK25hOTlWcFhtSXd0S3hadnlaOVdtMjRxZzhn?=
 =?utf-8?B?M1hTTTEyaFVDeEpGKzlTMVRWa3l1Sm9yY0JxbzJLRUlpc09rRUp6WFdRNVVj?=
 =?utf-8?B?TStENzZyTnltVWZYcXJrQ3kyVzlBUkFCdEh5b1Q4MEFiZzVZbk9hUFc1YUVO?=
 =?utf-8?B?WndoWTN3R0Mza0NyemVnUjZwcTJQK2J6ZGMxWUtqdTEvb1k5N2h3Vk04RkZ2?=
 =?utf-8?B?WDVRWlNxMFZCbnVMeTN3Z2ZROXlXZzlyc1ArZGdOZytEa2FsTkJHQTc3d2tr?=
 =?utf-8?B?bHBYNGZleEpJWXR2M0pmYmpZYXhWaEpWcFY4RUsxZ1V0M3BFRERQUzBQdGJ1?=
 =?utf-8?B?dGxFQkpPb2ZyWlhnN1I3R1dJY2g4UGtsTkVMb2pqbjRyaTVpTUVvUGE2VzFT?=
 =?utf-8?B?UmEvUlpFd3JEVHFobzBmMmxmU2YxUEZqTUJyS0RiTnVpdmdkV1FFMitzTUpG?=
 =?utf-8?B?RWpTNFFkQ1NwZVJsaEZjeXFoZ3RPTkJOR0RTVm1aUDhTOGdiMm91T3VZWC9i?=
 =?utf-8?B?NWZxUEFZWW8zNVh2aXhqZ05ZQkNjeXVzSXoxT2t5TUQrSnlORVNYNEI0R09Y?=
 =?utf-8?B?clZzVFVtZEhnQ2xlNEZ2U1d3Wm5YQXpBaG9KSjF3MlF3UWhBdmZOWTR2SEtD?=
 =?utf-8?B?KzlTQkpIL0pLQU1WOUxlMzRWRXNtQkFtWDU2R1E5eWkxRTQyNG12MlBhNFBt?=
 =?utf-8?B?cGZFSGwrT2FwODhiOWFOaUNzc08rSGNVWDhoVVpQS2dSNXZCVHVNbHpVb3Qw?=
 =?utf-8?B?UFNvbXAvR3FFaTVCdUVPM2F6bHRPT0xRVFNMbEwxeTA2bFlFSnRVdzBQY1BH?=
 =?utf-8?B?Ui9hTE01L3pKZHhGUmViRm5vam1rOTcrOVpqSURuNXZSQWFyWW8yUEMyUU9F?=
 =?utf-8?B?ZE94bnA2QXNrSFYxaFB0T0RrVjBDV0FxTVB1aVlnV2tybG5UUjB4ZFhaQjk1?=
 =?utf-8?B?R3V2U1NYdmljR3VKWnd2VkpHUGRnZnMxZnlSRS9Fazlxb3FkcGlmMUFJME5I?=
 =?utf-8?B?alpSSFdzaDBPQlRnWmtoR0o3Z2pTZS9TdkJ2UWk3NlJGQ1B4YW1nUi9ESDNC?=
 =?utf-8?B?K1RlbWM1M3NWa0xGcUtTQjdxK3lkZmwwTi80Y0l1c1lSZVNsT1BrMkdta0RK?=
 =?utf-8?B?aGJxMmRybDBmdWVQOVI5OFg2bzRSUCtkNUd2UDJIMlhKdHBNNWt4YVNCak5y?=
 =?utf-8?B?MDdFRVRMd1ZHWmNwOStNZHVnZDU0T3pST1hVU3JVVTFrVGlic0laVmNzN0Uz?=
 =?utf-8?B?dzdQU3N2V0JnNi9rNC9NUWt6N2JPbnhpbjgzNjg4WTVSSUxrd25zWEVsSzdn?=
 =?utf-8?B?c0l6NUpjWDJPU0tObHlvaDY0LzZ1eFpVZ1JRN1c0MTVvRXVOMEx4M0tMNXU0?=
 =?utf-8?B?Skk4N1MzUUhUUnZ3cExVZVNBQTEyR05vNUptU2FsU2FsS0pFUXdneFUyR0N5?=
 =?utf-8?B?UGtpblBMRHZMcitSYXBFQkx3NUZjNzBXNWpYaVdEZG9vNFdMTDdSOVhTNkwz?=
 =?utf-8?Q?0C1w/J8XdkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJUajJkRlRveVo4QkNpbGcweHFOcnRHNXRKdnI2K05zTDBFR1pZcW5nc3Z5?=
 =?utf-8?B?RHZsWURmOC8rS2w3V1B4eXNMeU00OGtLbkpMYmpvTCtrV3R6YW50alhUbzFI?=
 =?utf-8?B?SDNmNGJJZ0hhNGNUR05DT1JpdE1qUHlRY24zbENxdlNQM1FqR2UrWFV4TmJ5?=
 =?utf-8?B?bTd1L0F0dE9Xc2xKcGlMaytyR0RQNVM0MGJlTFM4amhkUTlDd3dUVTR2WHJo?=
 =?utf-8?B?U0pkRCt3ZGF3M0E3dHduM2dtK1JGdGordDltb1ZNVERaakozbjEzbFV0d1pm?=
 =?utf-8?B?SXpHekZwNXVYVjBrT0Y5UzhHNWgzRnpucFZlMXpQeTE3anEybm5TcFc5dkVx?=
 =?utf-8?B?Skl0aWhyVWtadHQ1bVJEQWtWV3gvVGsrWGdHWVRBaURMY3BBOGhIUzFGekhh?=
 =?utf-8?B?bFhOS2x2WUVKK1EzeCtJR0UxeXhUZVgvRkx4MUphd1VhUEVUeDFyWGpTdkIx?=
 =?utf-8?B?MXNtN1AyVDNRSDNsQ0Fydyt2RmlVNWJkd3dlbllqdk8xNlNOWE4xQU5UbGJY?=
 =?utf-8?B?eFdCeFU0YnpNOTlldS90NVkwY1BJeUZJeW5Wak5NMjR1QU8rNzF1d1VtTHN3?=
 =?utf-8?B?Qi9MUGJqY1JxNHdZcVJUdFZOTlhNdzdaV0hiWllXUkZycXJIQ3ZtOVpQcTNm?=
 =?utf-8?B?QXYyeVVzZmpnbk9TWEdhdHhxZHNJRjVQRDFRU0x1b2xGUHV4T040Z1RWd2RS?=
 =?utf-8?B?Z3djRWJycXpEcGoySGdRZkVRNnh1eGVCUHplZlRmbzk0b0o5QjNBZ3ZIOU52?=
 =?utf-8?B?OThGcXMvb3BWak9rRk9kN3djOUJGd3VSa3JoUUtUYlhqS1RvZzV0a003S0hj?=
 =?utf-8?B?RTZDOS8yMTdSRnZ4NVNLTlJKSHVsbXhHT0hsd3RzRytqSGZzZUxPRTBRTHFh?=
 =?utf-8?B?VjNvMHNtcVdjaUk5UUljbXpWUEI2enNYengvQnFJZGN1R0NPRC8vZ1ZKSTQ4?=
 =?utf-8?B?VG00SDBaVUYvbkV4YUlFMHB6QWkvYmxNZ0ljSTBzbkpsMDdEU05jKytEM3pO?=
 =?utf-8?B?MnkrUTROQ3VIeWVPYWVwRmNGQnNXT3JOS0ZZTUtLK2VDTGxaWU1EWmJrTmM3?=
 =?utf-8?B?cmFPSkkvQXNyemJnbnY3NWtWQXhDNVY2ZHBkVVFrdTlMc2w4Lzh4Qys1dnkv?=
 =?utf-8?B?MTc2dkZqQUUrZmVNb0dUQkJ0enJYbUN5YksyTEFITWhJZEZEVXo5S1duTGQ2?=
 =?utf-8?B?dThOWVJ1WEt5N0pLUzR0aDQ3VnRBSWdGWmdtRWd1ZnNFQ3hEQzhBbnFmQmVV?=
 =?utf-8?B?SlI4cFhHZVNtY21RT2ZEaGdpUDd6YTg2bHZ0dXhCS0tsZVFTNHFkMVUyMDA5?=
 =?utf-8?B?TlU2RHRoMXdYblhVUHd6N1hUSEVHYTZlMjR2dWR5VEhjbjE4S2RUbWtvWXg2?=
 =?utf-8?B?clZHNVZkMjliWVo5YmhqRlRRcEdiZ1VqNEp2dlZEOGZFcDhKQ0h5dGVZZGMx?=
 =?utf-8?B?QTZDNjBpUkttOSs5WUhhN2JEemRlVncweWRWNk5jeUl5ZHB2Z1U4ZW5SYThX?=
 =?utf-8?B?dDBtY3NOeWVESVY1WXgzOHRyR1Z2di9kQlVXaHI3RzZaaS9RWHFUSkpUcVFW?=
 =?utf-8?B?WENncWwvT0pXT2RXbEZUeWYzMjJaOGhQaUtBRVZVVHNuU3djYlliUXdKVVUz?=
 =?utf-8?B?V3pKRkJ1K3hUa2ZBbENIWDlYdWpreHFtRzlnVEdtZ2xGQUI2d0UrKzJKaTNE?=
 =?utf-8?B?V3FlU3c2M0pRTmZTS3dublJmalVXKzRESEFDSjhTRnZWSHBTcTFDMEZNblE2?=
 =?utf-8?B?ekJncjZkaHRvY05vd3JvSURXQzNmM0t5bVlKM2h6dFl3VG10OGJpOS9XTzVi?=
 =?utf-8?B?TTdrOFpkQTdBVlVIMms4dkN5U1hqRUp1VFpiVXlqQ2M3WGdHNVdoQmpOSWt3?=
 =?utf-8?B?N1VPMTYzbTBvR1JsUWcvUmg4dFF6bFdXck9zQlphY0g1eE1KOStEMmxPNnVD?=
 =?utf-8?B?Vk1vL0VwRmgrK2ExRTZzT2tZNHF3SmxXVjZjZVRjNDBacWk1SHo1RC9waUNs?=
 =?utf-8?B?MW9ZZDNWQ0hQb3c5RG9DMVR4Qlh3Ui9jZXFDa0xIQ05vQXlXT21Sa3dBOWxM?=
 =?utf-8?B?UlM1eUVJbnBmRCtzS01uQi84V01MRHo4TytwcklpbDc2ZnovNDN6d1dqTzh6?=
 =?utf-8?Q?zoPAVqdzwbl9m+3gA6W17bhmd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd32866a-ea78-478a-594b-08dda1e1a959
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:27:54.1759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Eu29bh7a2asRk7bD7YfT77Lm8yCu5HyEs7w1AJZ6gsO/8UvzFyN+CCdUIR+2On4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
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

On 5/29/25 22:07, Alex Deucher wrote:
> We need to know the wptr and sequence number associated
> with a job so that we can re-emit the unprocessed state
> after a ring reset.  Pre-allocate storage space for
> the ring buffer contents and add a helper to save off
> the unprocessed state so that it can be re-emitted
> after the queue is reset.
> 
> Add a helper that ring reset callbacks can use to verify
> that the ring has reset successfully and to reemit any
> unprocessed ring contents from subsequent jobs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++
>  6 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2f24a6aa13bf6..319548ac58820 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -764,6 +764,18 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>  	amdgpu_fence_process(ring);
>  }
>  
> +/**
> + * amdgpu_fence_driver_seq_force_completion - force signal of specified sequence
> + *
> + * @ring: fence of the ring to signal
> + *
> + */
> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring, u32 seq)
> +{
> +	amdgpu_fence_write(ring, seq);
> +	amdgpu_fence_process(ring);
> +}
> +
>  /*
>   * Common fence implementation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b39..67df82d50a74a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> +	/* This must be last for resets to work properly
> +	 * as we need to save the wptr associated with this
> +	 * job.
> +	 */
> +	if (job)
> +		job->ring_wptr = ring->wptr;

First of all such state should *absolutely* not be made part of the job. That belongs into the HW fence.

Then we need to handle the case that one application submitted multiple jobs which potentially depend on each other.

I think we should rather put this logic into amdgpu_device_enforce_isolation().

Regards,
Christian.


>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index a0fab947143b5..f0f752284b925 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
>  	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> +	struct dma_fence *fence = &job->hw_fence;
>  	int idx;
>  	int r;
>  
> @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		else
>  			is_guilty = true;
>  
> -		if (is_guilty)
> +		if (is_guilty) {
> +			amdgpu_ring_backup_unprocessed_jobs(ring, job->ring_wptr, fence->seqno);
>  			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> +		}
>  
>  		r = amdgpu_ring_reset(ring, job->vmid);
>  		if (!r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index f2c049129661f..c2ed0edb5179d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -79,6 +79,8 @@ struct amdgpu_job {
>  	/* enforce isolation */
>  	bool			enforce_isolation;
>  	bool			run_cleaner_shader;
> +	/* wptr for the job for resets */
> +	uint32_t		ring_wptr;
>  
>  	uint32_t		num_ibs;
>  	struct amdgpu_ib	ibs[];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf2..909b121d432cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
>  
> +	if (!ring->ring_backup) {
> +		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
> +		if (!ring->ring_backup)
> +			return -ENOMEM;
> +	}
> +
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
>  		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  					    (void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
> +			kvfree(ring->ring_backup);
>  			return r;
>  		}
>  		amdgpu_ring_clear_ring(ring);
> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	amdgpu_bo_free_kernel(&ring->ring_obj,
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
> +	kvfree(ring->ring_backup);
> +	ring->ring_backup = NULL;
>  
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
> @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  
>  	return true;
>  }
> +
> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> +					 u64 bad_wptr, u32 bad_seq)
> +{
> +	unsigned int entries_to_copy = ring->wptr - bad_wptr;
> +	unsigned int idx, i;
> +
> +	for (i = 0; i < entries_to_copy; i++) {
> +		idx = (bad_wptr + i) & ring->buf_mask;
> +		ring->ring_backup[i] = ring->ring[idx];
> +	}
> +	ring->ring_backup_entries_to_copy = entries_to_copy;
> +	ring->ring_backup_seq = bad_seq;
> +}
> +
> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	/* signal the fence of the bad job */
> +	amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backup_seq);
> +	/* verify that the ring is functional */
> +	r = amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +	/* re-emit the unprocessed ring contents */
> +	if (ring->ring_backup_entries_to_copy) {
> +		if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
> +			return -ENOMEM;
> +		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +			amdgpu_ring_write(ring, ring->ring_backup[i]);
> +		amdgpu_ring_commit(ring);
> +	}
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b95b471107692..fd08449eee33f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
> +					      u32 seq);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -268,6 +270,9 @@ struct amdgpu_ring {
>  
>  	struct amdgpu_bo	*ring_obj;
>  	uint32_t		*ring;
> +	uint32_t		*ring_backup;
> +	uint32_t		ring_backup_seq;
> +	unsigned int		ring_backup_entries_to_copy;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	volatile u32		*rptr_cpu_addr;
> @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
> +					 u64 bad_wptr, u32 bad_seq);
> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
>  #endif

