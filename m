Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B242C3ABBF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C9C10E5D2;
	Tue,  6 May 2025 09:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sFW4XYCW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EC410E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnUJhnM7TKLRNcnOn6dw/Za5hdQFbVVleFFRcSCYmXpWJzlfWxAbq9Ode8Bezd4PG0AzDVvHdlRngZEIlyRi0X4OXuFqYziY3k2lHbXV+mHWjIYQb+eSNQeeCrJNZiRY3HgQyPL1QCaMxCoVhqtrDkh7Se/L+JARWGePG3Jl65bWxoBHcCbO/EV0uGybEtgElcSoqHNUy+Sr87Qsoq1kYbFSoY0mMZlQM8zfAznSdHq83yg2oouLqtc7+gtK/5OzhOHbdgehAsBH8rhDx9wVq5Z7e1gFFYfZnlanboDBWHr2CQLd0n8bA3VOf/DLT1NL9OvUIER440nqqnNCVK9L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKbSjYvP+WxgjX01kYoRRSf4ChaP5a1aBA+FH7UWMnU=;
 b=fLuHdyT9wb6782m+YTSGoNrBegfx5QACCOUlNuCIBNC+nqypVy8B4LbdOCRmheWjWVufQH7+tSU0HBq2QpUqXe/xEBWH2bOWRct4GySFhh8uJBs27niKg0tcjwIU2jNwM2B428LuO1Nb4bR5mhEVSvWThQYFp+fjKqsPEcrp37o9AwtFAIMIXumEA8/y7eKcUZscUY1bSPKvBxdICoMJLYTEksoxz3pJBfoASctMr32UHCFRBQnfA01ruYBc/FVadqsB6lOlD35C3cHENWK8dcRSpMvwt6EQBvH6ffd09lyAt7LbrUWsDHdx2iAaIcGnZj+7ZeLGflaIE4ZN5rRWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKbSjYvP+WxgjX01kYoRRSf4ChaP5a1aBA+FH7UWMnU=;
 b=sFW4XYCWe6gi0VnsA57b+bnn1umL9QkEqCJ17GDw85fUrFjatTGsr++mu6VMYYEhIQyQtsQEWMdC4H9mUddA7m0GB0tofuVCSf1mrV88jmRnwzYZMJdOmdgTmneDxCOtC5FX5IYfUotFiZRXkLvhfoEg2ghGdEMTFEm5jqW/7f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::994) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 09:03:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:03:19 +0000
Message-ID: <8c9a1d68-83b8-4f73-a718-4adb62f317d0@amd.com>
Date: Tue, 6 May 2025 11:03:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-4-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: f85aa49c-8de6-4e40-08b3-08dd8c7cd81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akF6K3hYR0cwU0VXcXhDYlEzbkhFaEJ3VW4rcU9mMHVncU80TEgyRHhoWjM5?=
 =?utf-8?B?dHR2QURtak5tVmpYVjdtazlpMnNaQkZWR251UUJLcTVTWFpXT3dwTFVnZWY1?=
 =?utf-8?B?cFJ6VThWRCsvYjdRTUpwUFpFRjVUdFViUTQ5MnVTNGt0czcyTWF6d0MraDk2?=
 =?utf-8?B?VjZFcHZCeFdGMGJQZ1RpWHd4YVBPRXFrZnNCd09rL0orZC9tZnNkVzFQcHVm?=
 =?utf-8?B?Q2s2T1FSeEdlVHg3Ti80OThnQjd5YzNnMWM4Nmk5a1dCZkpCaXJpanFOWUc1?=
 =?utf-8?B?Z2VvK0cyTXZMc2QzTU4wKy9hdDRWREFhZGtUZEV5SDR0clpwKzNHTTVodW5X?=
 =?utf-8?B?am16YTlwQmVwVzhCY28rZ0tvTzd0UkpVd3M4eHo5N1pmYmpRVjh0d2QyemFN?=
 =?utf-8?B?SzllWjJNMmtmQnZZdFg5NTJ5ZE1pemhDSkw4WEtsMkVWZlFtWVJJRkFXTW85?=
 =?utf-8?B?WGtrZitaU3ZtZWlIdWU4V0JBNEJ3Ty95SjQyTkxJS3ZzdWhDVkFmWE9uRDlQ?=
 =?utf-8?B?MkRlUlFkYjJIQWhoOU1JeFR5SmRVZnNhSGNCZEtnMnREMldDdTRLMk1PdVhT?=
 =?utf-8?B?U1VEZnJMZHN4RGRXNFJyaEtmRW1PenpVWk03TmNsbVZGdnl6OXgxTFlHWEFz?=
 =?utf-8?B?dWl6MFpwZmNLUDErc3RiYlRQekozOUI0UDV3K21jUWpyQlArQjlMU3Y3cXlx?=
 =?utf-8?B?cEJSRmQvMmFFZ1dCYTc1dUZUR1Eva1hEMi9kNm5rMTh6TUxPVXFlWUQ2ancr?=
 =?utf-8?B?QTZ3bXowVStkVC9BU3VZaTBWa2FuQWpSTElMTlppZCtveDBrVkRlQjVvZE9z?=
 =?utf-8?B?L29BK2h5Qk5NcmZsbkVxVGRlTkZ5eVJ1OVJ0d09MRlV3VGJhSCtQMGpaZDA3?=
 =?utf-8?B?Nm53cWEzdTJid1NobElPcnhJdzBaa1o4YlBxMmhLQTNsSHc2MS93MVM2K1Uz?=
 =?utf-8?B?ejFOVW9wSFp6VEtvT2RRMjY2MTYxdk1SWTlmcitNMzBKNHNKc1ZKL0xIRVNy?=
 =?utf-8?B?MWlqeE5iWm9qMDBwWGNGRUdQd2J6Tjl1MU5TbzVaQ3p1WHJJMHRvUVlaYk80?=
 =?utf-8?B?bWl2TVdndDdpM0tKWG55elVsK0wvZU5GVS81dDRIY0NUOUlEN3psc1luNGR0?=
 =?utf-8?B?REw3Z21SNXhJOUxwdVgrQjZqcmgzTE9kaGpHcHVhZkd3T3hNTVFJcnJnUXVJ?=
 =?utf-8?B?ZHJKNnd3S0JzQkx0OUVicnl6ekVyblo5cVJ3eTlNZGJndDdZVE9SV0dLcXgy?=
 =?utf-8?B?TmdoY3JyMGtUSDVsKzhvdUxqTjUvM3JUeTRkTDYwVzFrUHk0WEplV2NVeXZL?=
 =?utf-8?B?MEVzaC80aVZDWGxndFVQTWJzbnZhMGdvVmoyUEVNOHdoVGdlYk1jSDBjOXlm?=
 =?utf-8?B?MTJ1cjBxdEc0T3hCQ2wzYUhqenZWbEw4SFhtKy9sbkwwTExpTlVWSGdndzNx?=
 =?utf-8?B?T3Nkc1NPTTNFUlhiUlZiZnY0bFhsa3RMTU9YYndXWjd2UzFBWkpUeFBvQ2tC?=
 =?utf-8?B?N3g1clVKaXpkb0kwVld4OXRodEVvaW84L0NNMElMaXA5VFhOL1dHOEJ4MWJj?=
 =?utf-8?B?OEhTS1ovejdiNzhIMldXR3pzZEV6MmJOMU5jTHlwRHY0TmxzK0FwSXpRNTdH?=
 =?utf-8?B?ZE1BSVVkeCsvdTRGcTRTWERIRmY2QTg5Mjh0ZHc4am1nMG9SbzRiRU1FZnQy?=
 =?utf-8?B?a3JNSjdINzBBR1ZSN3ZVd09IUXV6YTFuRjBsYytmaHdDckUxOTNickREM2sw?=
 =?utf-8?B?dDdZTytBQjJROS8ybjBhNE83dnlwbXhHUUJLOW9iMWNUSk96cGtwNFVzZ2Yr?=
 =?utf-8?B?Nld4WXFvZVJVUTI0UGZUM1JtcERTWXlMcUFYZk04aWJyZnRjd3FOVkZvS09o?=
 =?utf-8?B?S3VoL0l6NkdmeHp4U2RWYnFTdUVXQVQ1TTBIbS9ZWVlvVUxZWHF0cFVRbHRS?=
 =?utf-8?Q?P9CjV3SBOpc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEh4bEpQa3RETk1WNm5Jd3N2L2NSRmJYOVE1N1JlaHRLRk44eWl5OHBxd3R3?=
 =?utf-8?B?Rm45S0ZRTE1LZ3Q4SzY2ODN0clNyMk4yZjRKbytjOXZhR1VoVnpGSlFKdE1P?=
 =?utf-8?B?ZzFqM1pUZ1A2S215d3JzTVRub2Y2WjB2QlhEUEdrUExTVTZLNjZBaDU1Q3U2?=
 =?utf-8?B?d3gyb01QTFUxay83T1RkbXN6UmxBMWRhanF6K2hVdm1TMkg5RUVGREozVXdY?=
 =?utf-8?B?ZHRsTW1jWDRyYllWTXNFUnpMTWJndmd3YmQvcDBabG5CM1V1bklVNU8va1Vh?=
 =?utf-8?B?SXFGUHZIdVlGMkNGeHFTVXA0V2ZJRWdsVFYxTmtrY2p4aWgxUXdFVmxBc1hV?=
 =?utf-8?B?MFdDL1ZsbHo5Ukk5ZlIzVkhBRVovMUlQbjRUMFpMU1I2dlhQb3MrMWQ3UUtk?=
 =?utf-8?B?UjNKdDU3RURyZVl6b012UmhTUi9Wb3J3Q1FuaEU4WXU2b2NZUEE5bzhEZnFY?=
 =?utf-8?B?OXJ1QnVERno3dWpqaHkycncrL21kMVZUUVg3VFRiK3VQYWtmbEhFZ01RV29W?=
 =?utf-8?B?TG9FbTJPeFd4cFFoSW0zYXdQWml0NzM0MFhtRlJLK2RhR3ZBVUx5QkVHZXNt?=
 =?utf-8?B?dDdFazdWRHBkY0xrRnpUbldUVk42T3M5QjJpQ0VHTXRLVVZQSkh5RzlQUGVk?=
 =?utf-8?B?aC9yVFpJNVJjMnlnVWRKSlA5ZmZuKytaRDh0Zjg3ZE5VY1B0dkRmOTdLcDY2?=
 =?utf-8?B?YnRXUGtxd0pPZVYwK1V0T2UzVDA0VUNxdlUyVnkwbDBMRnNXZlRCZUx1Z0JG?=
 =?utf-8?B?MnhETzhMczdTbzAvelJleHMrVkhDK2YvMFNwRHYrRzh1RUw4cUhSTm9jQTRR?=
 =?utf-8?B?eVU5VS9ZRU4xNUVRN3ltcWU1eDA4VDczeVV5emwzV2N4SjdlVFdYanc2eFFs?=
 =?utf-8?B?YUQwTGhFYllZcUJVWTFUQThkeC95Z3o1ME55RDRpd1g1MHF3M2tJaEg1ZFVH?=
 =?utf-8?B?dUNXc3NuTzQzMi9WN2U1WWVIQkxzdUo3akppWmNYdi80dmdpN042OFlIS3ZK?=
 =?utf-8?B?cW5kOGI5NWk0NzJHZkFtN2Z2eGVtM1BNaE11d0RpTjJmSE8wSDEwRHRvSjBs?=
 =?utf-8?B?cVJaSWY0TE13bU1kTU5sZmxnd3l2enh0ZDRldlk1TUNpRkpKdUc0NFpsWExK?=
 =?utf-8?B?enpQS1ZnZFpLQTA2eENFZnRId3BLQjNhVFU3d3hoNTc3MDhNVFhpdFFFcFVT?=
 =?utf-8?B?ZmlGeEk4RmNJaGlGckRrSDVnOGRhSWNpeU4rbkVXWFRBRTVYL1lRZlU4SU9m?=
 =?utf-8?B?QkpNSUZrNDB0NWt0elZrZmthNHFHdHYrWWFDM1hXNFhhQXdLaHl1U1dmbmRx?=
 =?utf-8?B?aWlJT2FQKy9QZytUbUgvNHE5ZmFtOWU1NDBZNXVQSjdPSUQ5ZDB0WFI0WTA5?=
 =?utf-8?B?aWxQL0RiSFhtK1htZWpuSTloTVJuQjlzYmVYMStQcFJwUG80MUpIcDVwM2FE?=
 =?utf-8?B?aExzbGtIVG5paFg2UElxRXg2aFMrQUo3VnA3SnBVcTJpS0RaZHFJclZxL05S?=
 =?utf-8?B?OVJ5YVV1dmhnaWlxKzdwdTVkT3ZDUzlCNU1yNTJYUzJXTlZwNVJsUGV6V3o3?=
 =?utf-8?B?bDZXdjFHd1NPZ1VqOTZ5UHpkTDNhRnloUFYrdGp1aExWVVNyTWV6c21iN2U2?=
 =?utf-8?B?c2RCUWdmVzJlbFFsazZCSzFra1hJSWFYMWtJVGNJVVkyR2JIbkwwM2FocHZl?=
 =?utf-8?B?RFJZbldwTExseFVJRXZXYzRrWjVsK2I5NDE2M1JoQ1VZN1VoVjdlQlJTaGt1?=
 =?utf-8?B?VnB2WS9ONUZuRzRKeGpZNzZRNUJzelZJQ1orKzhDUjZTbUxkK1VlaldNdXJ3?=
 =?utf-8?B?VGZEV2lwZWdqSW9WUENoZ09xUUdVQU15SnRkOFRhMXhwelhIa2RsMHJPRnpz?=
 =?utf-8?B?cjRnckF6TDU2ZG9aMlZSbzJmMzFMUGwweGp1ajUrSEdzdm9xZU5ZV0ZoTkhU?=
 =?utf-8?B?dVZoMW9PSU05YVEyK2dTbDlnWXNDSStJOTlaY1poNWxLZk91NzliRGNmTGZq?=
 =?utf-8?B?Q1ZRN2U3N25TeWlCZ09MZVZyaUxZUFdYKzFodDFpZHN2TXo0clBNWVhGNHYr?=
 =?utf-8?B?VHJDaUhCN00vWXJNLzRNQkM1UG9zcmtuR2xpZStWQUpaMjYwbFpUV1Z4Tmlo?=
 =?utf-8?Q?VuXmpwEL+JiW/kOzdJHmtX1Ox?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85aa49c-8de6-4e40-08b3-08dd8c7cd81b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:03:19.0415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoqPd/8LGCHJqOOSjz21jpz3eewTHoE/qyefyM4EzH1hPs8mVxj3EEy3NOqv+N2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
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

On 4/30/25 17:48, Alex Deucher wrote:
> Add support for forcing completion of userq fences.
> This is needed for userq resets and asic resets so that we
> can set the error on the fence and force completion.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3288c2ff692e7..3494ac9e9e9db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
>  	return le64_to_cpu(*fence_drv->cpu_addr);
>  }
>  
> +static void
> +amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
> +			 u64 seq)
> +{
> +	if (fence_drv->cpu_addr)
> +		*fence_drv->cpu_addr = cpu_to_le64(seq);

It would be *much* more cleaner if the FW would do that as part of their reset prodcedure, but that is probably to much to ask.

> +}
> +
>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  				    struct amdgpu_usermode_queue *userq)
>  {
> @@ -408,6 +416,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
>  	dma_fence_put(fence);
>  }
>  
> +static void
> +amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
> +				    int error)
> +{
> +	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
> +	unsigned long flags;
> +	struct dma_fence *f;
> +
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +
> +	f = rcu_dereference_protected(&fence->base,
> +				      lockdep_is_held(&fence_drv->fence_list_lock));

Hui? That rcu_dereference_protected doesn't really make sense here and will most likely result in complains by automated checkers.

Just using &fence->base should be sufficient.

Regards,
Christian.

> +	if (f && !dma_fence_is_signaled_locked(f))
> +		dma_fence_set_error(f, error);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +}
> +
> +void
> +amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
> +{
> +	struct dma_fence *f = userq->last_fence;
> +
> +	if (f) {
> +		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
> +		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
> +		u64 wptr = fence->base.seqno;
> +
> +		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
> +		amdgpu_userq_fence_write(fence_drv, wptr);
> +		amdgpu_userq_fence_driver_process(fence_drv);
> +
> +	}
> +}
> +
>  int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  			      struct drm_file *filp)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 97a125ab8a786..d76add2afc774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  				    struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
> +void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>  int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  			      struct drm_file *filp);

