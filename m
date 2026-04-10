Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D3F44871
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 14:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785C410E95E;
	Fri, 10 Apr 2026 14:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p86g0IPI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357D510E95E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 14:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CddC08MvyrcCii5ZwSObiDy+gDYiUwoEl+lpbrFf266vrGf/hiOpW4E/iPU0E1Ex1oADRzKR70PdthdVGQz9U0WY9FhcvqvgNRvbnOnqIE1JnqlcbdyxtzHPfbiE4WcXnr4Yj6yJkl0uxhNnRL20zLG4wd5gR8TlqjRNogAwpCGCISJ22yz5wNSn1/3fXf4klyxwRAsjdkCVyzbFAHT7kBwP3jtDLV1+BzoDU7s24w0nZfjnxbBT/YDB94jw85bh1RMnuz5+FvBD8vFlyoS+tNsRFqMmtzKVVXD4rsHrJTO0wk1EqdnUjqqUhEfv3ilLhb2Gvps8tjdewamOmRG36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9KT3Iufg0DcMdgKz/jjBwb+QfZrB8tJawhsYAE0j+I=;
 b=GM+4T1Ke+KyXM5ol6A3Khx2RVsjdYlq4fB3dxiZTZOK3jP+80CAJJw0b+R8BYqOyveQnHxam8n/zWKfdHebjomzmgfTD1fd3y7YmcLZnI5a/DpYSXtHSLfj5LpUENPwKOkJBJTQGwn6TlWov2DVz8hr+eIfyf6ftdX5zdIj6aaEG7wbsotn1hr/5jc4tVkOmylqMkx7BVWUbelo2Ix4PwBWb2oqPPPkVmR5McHb02vYNm0NDuM1REJePhLFUe+pjFiq1aHPX/kxAOjlYlVrEjkKaTmfswsUyULjyYa5tTdZsV+3625d75ZlvSJTfXC1atO646pgMARl9nW2kQFL6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9KT3Iufg0DcMdgKz/jjBwb+QfZrB8tJawhsYAE0j+I=;
 b=p86g0IPIZkzizHDhvJJdpmu6pVPa6NUjCdMgRA1fk4Ls5kNSefMslneJ4FDnzRdUc0CwArjDzYFXaoePbpU2RBRYt4G8dB7YpE37q+iPobpoHYeKG+kVk3hgduhNOWMUJvYHFiP89VwRH1m9cUILacRbe+3O+xl57r2GS1ZRDvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 14:00:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 14:00:35 +0000
Message-ID: <04b995f0-6edb-408c-8468-9fea7ad828a1@amd.com>
Date: Fri, 10 Apr 2026 16:00:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Change gpu_metrics over to binary with
 per-reader snapshots (v4)
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260406162553.25281-1-tom.stdenis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260406162553.25281-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: cb060cb1-a6ed-40e3-c1a0-08de970989c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 98MFcOjp8zKifAE5iSZc3q3RmFgXSB8ip3MBO0Rh4lYsVnTNYl4edJXepwL/LElj0r0zl25hbI94d3BLqOYyeycRDnB/FREgSbmLxiX0SmBcZLN5Qf6+Ca55/e5Kn6KNEIlKgiQlyOZv44ccfeOp3NJpVMfF80abMWPkCMrXcWUHvzom9zUfgidmAg5nHniDe0iZXnl38FNig/XBTR+QqdEFA7lxh7okZiSDFuffUWIA1dTlZew/o0gRPm2vfuU5AQun6rYLNXLg363AaA+8739Wh6YB0YQAl+QWiKQkFR/aDEakq6uygNav8VqQ/gyXBOgTSdIF+30YXy+xV2vAavlZqknvjzwaWwIGLN03y3wIyPPxLQqIb3wjr0eA+m2BuQTYKNmcvBWtfFI44cam89Lt0eLmS1Zkhs0kXtyNZstK+VIovkRo4+UaScCpa8fGV1NT7XDYXCZfgfGWlc2CeXIMEnpsEMpsh3filglqoRyYGrgd00M3DQV7vCGYlMtfe8EGnsVBuG1oycNcHilp3MfQXMrT6N2Lc9cLs19OVKfwb/naSiWNQrRp+TuvBS21RC6AeNbqMY1YaODN7774e285wEMnnsYT16SeHgJPRkBM9r9j0fDqi9JrWH82t/ujuv9+zBatIms67q9p+otkCHSLrn99kvx81Vh2u9F9M2blALqJhmXeFrHAGCZt0gO1JdskqW42rKwsN1fo81OdC1j1XONlq4JZu8IPjCmmui4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJTR2NCajdRQUdLNCt6R2lLN1l5eVhBS1dEWE1Gem5uVDVrVWVTM053MndQ?=
 =?utf-8?B?Uk82anMvclk4WExkZkl6anF4QVpSaHJhK3d3UmU2VXdSSk4wMXI3MjlZVGVi?=
 =?utf-8?B?VCtTMENTbWxJOWl6aUQzRlRNMEVSOExpSjdVc0hKQXdxOFlsSVI2L3ZNemVQ?=
 =?utf-8?B?QTBqOEg0cFlaVmtRMzliRmdwK3U5ak13VG1HeWNBOFlWSmF3N0pTRmtNYThl?=
 =?utf-8?B?QnFGWDd6OFljUENMMjhyVFB4emdTL1BnMjhFQzk4Z1ZZaU1HUGIxc3RDcXBB?=
 =?utf-8?B?SCtPak8vSnRFcGJLRUpONlc4T0IwaDF3MW9aSUxPZUhXd2tuSVdlUkxEaEhw?=
 =?utf-8?B?VHVSVmRIclRBOTd2K3Fpak5mL0Z0dEJDNzNDSlNPd1hBbFBXb0Q1TEZ3SExo?=
 =?utf-8?B?UURhM3dyS2dIcFRQM2tMQmEzOHFHY3NSUUsvSHRLL0xwUHl1cVV3c1BXWTd0?=
 =?utf-8?B?djFZdGQ1RlRHR3QxNFBOTTRVcE9peWhmclpzd0xadUcvQ2F5aTBmcW0wUm9a?=
 =?utf-8?B?U0ZoajRwRFRmd1o2SnpleFk5OWFuMExEbDZqdHV4UnQyZkFSY1lRendZaDZI?=
 =?utf-8?B?OERlVzFzVGhTcWZydWlSa1BDMXdZWkVkNjcwOVYwMVZJRmErSVdaSXVEZHdX?=
 =?utf-8?B?Q2dPa1ZYQ1RLdTd0U2RFcHhBbUxjRVJmQndyVXpwek92TFZPamlzeWcwMGda?=
 =?utf-8?B?dnR4ZDRiMHNQT3VxU1pIc29lTU5vOWdiQ2dQMkhSQ0lHT0hNZVpTVzhIQzNa?=
 =?utf-8?B?bUFzU3F2WWFtQUc2TVArQVFkRWltaDdDcDgreXZkMVQ1SndXY2dXOCtCK2J5?=
 =?utf-8?B?TStXVnRtc1dxYk9RbkVlK3MyYU1sQ2FVeWNaSG05WXJGNGlSRjNBMGh2YVFB?=
 =?utf-8?B?RVM0RXBRMElTc3htQmJ0WVJmclNGSTh0eURPVDF1WS9jd0pvdE5PcWJRbnJw?=
 =?utf-8?B?Z3Y1WlRLaGNqTnNtYlA2UjZxUi9jOFVWZ0s0VC9LL203cUxzYy90c2RlQ1Ra?=
 =?utf-8?B?dnlTWmNIT3hSZFpqZDlud2JmSEpBMTBBWCtFcUk2aEtMeE41SW5oRmtNYnVw?=
 =?utf-8?B?MDVuS0s2N1hYeGVIT0g5bWZYa2lIWFgzWGdudWNCdFo0dHptanBXcVdqQzhV?=
 =?utf-8?B?d3pIRVhHSHEwMWVrS01KMnFSRnp1ZUFCZ3UyN3BwWmY1MVdRdVJqcGxVaWdq?=
 =?utf-8?B?c3NiM1JCb3pjN0ZvOTIvdjRyR2xKaU9tejg1U1ZITWMwQmVWdldCaS9zY0gx?=
 =?utf-8?B?UGtqUGhxUWx0M3ZWSzhkUjduRE15UmtSNVRJWGtBVlBBVE8rVFZyZ2czcVYx?=
 =?utf-8?B?QzF6YTQ5MkRkL3cxRjA5a1RMQWs0bWJvNU02WEZJM1F1SVFmbE5hMk5nSHdX?=
 =?utf-8?B?ZExUcGdnQ3YwU25BeS92YUJZRUVWeGd1RVdPSEVXZkZZa2JwcWVSd2k1bE9o?=
 =?utf-8?B?MSthVE5sb0M3emVFd0NLM09OYWh1Qng2Y0daTkQ2ZUp4cGVDd3dpWGZ1a3RT?=
 =?utf-8?B?NzZjWm15dTdRYnRZakNJVmV6dWMwWTk0czczQVZCRWYrZTd3eTNaUG1lQUVn?=
 =?utf-8?B?MFY1N0RyT21NY0h6Q3dvWUd4OFdaUTdKcTRVYU9zSEVrZkdSWjVFMmFJYktB?=
 =?utf-8?B?UGUra09Ndm44UVVwa3dsdlNpb2lCeXNWV1pmZUo0ZGs2T1ZORlhEWXJIOWQ5?=
 =?utf-8?B?YnZ1R2pMb0kxb2FCWGpOMkJMYWtmTXZtT2lRWnVXYklyMzIzbEZ4NmkvWXov?=
 =?utf-8?B?MjJkNk1vcWxVdUNZWnI1Z0paWUdudloyZ3EvSkV0UlBJSzZXckUxbkJyWFEx?=
 =?utf-8?B?RDZLcC9FZ09vYWJuRVZYVGJlRmVNR0Yzd1lnb2JKb0daUXhrM0xvRXBXN0cy?=
 =?utf-8?B?RzMrUkxvdnlWRnp2MnBoRnM4ajM5SUt4SEJMZFJkYWlOVDBDcWk0aDYvR2RF?=
 =?utf-8?B?ZDhpZ3RPdnFIYVgzc0pkUzRCQ21QNzY5N3JIanZyc1hIWkx3VXl3UVVHdzkr?=
 =?utf-8?B?OUZMNjJ6TzVlZGpEc1dENi9sajgyWUUvNWZXVHNxT1BONHVYOUExc0hOdnJP?=
 =?utf-8?B?cldGckJkcjlzZkhSN0Z0QjBCVUtmK3haQ0tCeDgwUHBHVG95YmNOajZUeGk1?=
 =?utf-8?B?TGZ2V2FEODhLcStrcnpBL1ZnUDlnRlkwK3FOS2JUcUgxV3d0cGl4eCt1ME01?=
 =?utf-8?B?ekQzNHhDYzMrcVV1UWVzTlBUUzZWZzFwdjQ3bjZOdmRyalFacDMranNXZWRU?=
 =?utf-8?B?NERTbjJxLytHOXNEdFVEbHZhN1J4Mk50WldWaDljWWRZdEJ2VjFTZTk5MGpX?=
 =?utf-8?Q?ryxfVcQZVy8fyaOME8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb060cb1-a6ed-40e3-c1a0-08de970989c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 14:00:35.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEl7nHEIxb5Qn9cfF/5ine1GHQrmb1IPRSOj8EEmmKPjM0zx6gp6EhvlINTb9Hq9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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

On 4/6/26 18:25, Tom St Denis wrote:
> The gpu_metrics sysfs file carries a binary blob but was implemented as
> a text device_attribute, which imposes a hard PAGE_SIZE-1 cap and makes
> it impossible for userspace to distinguish a successful short read from
> a truncated one (stat reports 4 KiB regardless of actual payload size).
> 
> Convert gpu_metrics to a bin_attribute.  The declared file size is an
> upper bound (128 KiB); the real payload length is the byte count
> returned before EOF.
> 
> To guarantee that multi-chunk reads (which kernfs splits at PAGE_SIZE
> boundaries) return a coherent snapshot, each reader (identified by its
> struct file pointer) gets its own cached metrics buffer via an xarray.
> When offset is 0, PMFW is sampled and stored in that reader's entry;
> subsequent offsets are served from the same snapshot.  The entry is
> freed on EOF.  A mutex serialises xarray mutations and PMFW access.
> 
> Stale entries from readers that close without reaching EOF (e.g.,
> killed processes) are lazily evicted after 30 seconds whenever any
> new reader starts.
> 
> This per-reader approach avoids the cross-contamination problem of
> a single shared cache: concurrent readers each see their own coherent
> PMFW snapshot rather than risking one reader's off=0 overwriting the
> buffer while another reader is mid-way through a multi-chunk read.
> 
> V3: Per-reader snapshot state, so each open fd gets its own cached
>     gpu_metrics buffer and all chunks for that reader come from the
>     same sample (Vitaly)
> 
> V4: Remove the residual PAGE_SIZE cap that v3 still carried over from
>     v1. The whole point of the bin_attribute conversion is to
>     lift the old PAGE_SIZE-1 limit, but v3 still had:
>       - WARN_ON_ONCE(len > PAGE_SIZE) with silent truncation to 4K
>       - kzalloc(PAGE_SIZE) for the snapshot buffer (fixed allocation)
>       - a separate memcpy from metrics into that fixed buffer
>     In v4 the snapshot buffer is allocated with kmemdup() sized to the
>     actual payload returned by amdgpu_dpm_get_gpu_metrics(), so payloads
>     larger than PAGE_SIZE work correctly.  The only remaining upper bound
>     is AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ (128 KiB), which is the
>     declared bin_attribute file size and serves as a sanity check —
>     exceeding it now returns -EOVERFLOW instead of silently truncating.
>     (Tom)
> 
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: Ib4fa233d9a25a396f1cc7d5fcf74f5f6578329f5
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 208 +++++++++++++++++++++---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |   4 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h  |   1 -
>  3 files changed, 188 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index a4d8e667eafb..303a2d643b10 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -34,8 +34,19 @@
>  #include <linux/nospec.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/string_choices.h>
> +#include <linux/sysfs.h>
> +#include <linux/sizes.h>
> +#include <linux/xarray.h>
>  #include <asm/processor.h>
>  
> +/*
> + * Sysfs reports this as the file size (stat/ls); kernfs also uses it to cap
> + * read offsets.  Actual payload length is the return value of
> + * amdgpu_dpm_get_gpu_metrics() and must not exceed this.
> + */
> +#define AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ	SZ_128K
> +
> +
>  #define MAX_NUM_OF_FEATURES_PER_SUBSET		8
>  #define MAX_NUM_OF_SUBSETS			8
>  
> @@ -1734,43 +1745,170 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>   * DOC: gpu_metrics
>   *
>   * The amdgpu driver provides a sysfs API for retrieving current gpu
> - * metrics data. The file gpu_metrics is used for this. Reading the
> - * file will dump all the current gpu metrics data.
> + * metrics data.  The binary sysfs file gpu_metrics is used for this.
> + * Reading the file returns the raw metrics blob.  The sysfs file size
> + * is an upper bound for inode metadata; the real length is the amount
> + * returned before EOF.
> + *
> + * Metrics are sampled atomically per reader: the first read at offset 0
> + * captures a snapshot into a per-fd cache; subsequent reads at higher
> + * offsets (for payloads that span multiple pages) are served from that
> + * same snapshot.  Concurrent readers each get their own cache.
>   *
>   * These data include temperature, frequency, engines utilization,
>   * power consume, throttler status, fan speed and cpu core statistics(
>   * available for APU only). That's it will give a snapshot of all sensors
>   * at the same time.
>   */
> -static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
> -				      struct device_attribute *attr,
> -				      char *buf)
> +
> +/* Per-reader snapshot entry, keyed by struct file pointer in the xarray */
> +struct gpu_metrics_snap_entry {
> +	void    *data;
> +	size_t  size;
> +	ktime_t timestamp;
> +};
> +
> +/* Evict stale entries from readers that closed without reaching EOF */
> +#define GPU_METRICS_SNAP_STALE_NS	(30ULL * NSEC_PER_SEC)
> +
> +static void gpu_metrics_evict_stale_locked(struct xarray *xa,
> +					   unsigned long skip_key)
> +{
> +	struct gpu_metrics_snap_entry *entry;
> +	unsigned long idx;
> +	ktime_t cutoff;
> +
> +	cutoff = ktime_sub(ktime_get(), ns_to_ktime(GPU_METRICS_SNAP_STALE_NS));
> +
> +	xa_for_each(xa, idx, entry) {
> +		if (idx != skip_key && ktime_before(entry->timestamp, cutoff)) {
> +			xa_erase(xa, idx);
> +			kfree(entry->data);
> +			kfree(entry);
> +		}
> +	}
> +}
> +
> +static void gpu_metrics_free_all(struct xarray *xa)
>  {
> +	struct gpu_metrics_snap_entry *entry;
> +	unsigned long idx;
> +
> +	xa_for_each(xa, idx, entry) {
> +		xa_erase(xa, idx);
> +		kfree(entry->data);
> +		kfree(entry);
> +	}
> +	xa_destroy(xa);
> +}
> +
> +static bool amdgpu_pm_gpu_metrics_bin_visible(struct amdgpu_device *adev,
> +					      uint32_t mask)
> +{
> +	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	if (!((ATTR_FLAG_BASIC | ATTR_FLAG_ONEVF) & mask))
> +		return false;
> +
> +	return gc_ver >= IP_VERSION(9, 1, 0);
> +}
> +
> +static ssize_t amdgpu_sysfs_gpu_metrics_read(struct file *f,
> +					      struct kobject *kobj,
> +					      const struct bin_attribute *attr,
> +					      char *buf, loff_t off,
> +					      size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct drm_device *ddev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(ddev);
> -	void *gpu_metrics;
> -	ssize_t size = 0;
> -	int ret;
> +	unsigned long key = (unsigned long)f;
> +	struct gpu_metrics_snap_entry *entry;
> +	ssize_t ret;
>  
> -	ret = amdgpu_pm_get_access_if_active(adev);
> -	if (ret)
> -		return ret;
> +	mutex_lock(&adev->pm.gpu_metrics_lock);
>  
> -	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> -	if (size <= 0)
> -		goto out;
> +	if (off == 0) {
> +		void *metrics;
> +		void *old;
> +		int len;
>  
> -	if (size >= PAGE_SIZE)
> -		size = PAGE_SIZE - 1;
> +		/* Evict stale entries from readers that never hit EOF */
> +		gpu_metrics_evict_stale_locked(&adev->pm.gpu_metrics_readers,
> +					       key);
>  
> -	memcpy(buf, gpu_metrics, size);
> +		ret = amdgpu_pm_get_access(adev);
> +		if (ret)
> +			goto out_unlock;
>  
> -out:
> -	amdgpu_pm_put_access(adev);
> +		len = amdgpu_dpm_get_gpu_metrics(adev, &metrics);
> +		amdgpu_pm_put_access(adev);
>  
> -	return size;
> +		if (len <= 0) {
> +			ret = len;
> +			goto out_unlock;
> +		}
> +
> +		if (WARN_ON_ONCE(len > AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ)) {
> +			ret = -EOVERFLOW;
> +			goto out_unlock;
> +		}
> +
> +		entry = xa_load(&adev->pm.gpu_metrics_readers, key);
> +		if (!entry) {
> +			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +			if (!entry) {
> +				ret = -ENOMEM;
> +				goto out_unlock;
> +			}
> +			old = xa_store(&adev->pm.gpu_metrics_readers, key,
> +				       entry, GFP_KERNEL);
> +			if (xa_is_err(old)) {
> +				kfree(entry);
> +				ret = xa_err(old);
> +				goto out_unlock;
> +			}
> +		}
> +
> +		/* (Re-)allocate snapshot buffer sized to actual payload */
> +		kfree(entry->data);
> +		entry->data = kmemdup(metrics, len, GFP_KERNEL);
> +		if (!entry->data) {
> +			xa_erase(&adev->pm.gpu_metrics_readers, key);
> +			kfree(entry);
> +			ret = -ENOMEM;
> +			goto out_unlock;
> +		}
> +		entry->size = len;
> +		entry->timestamp = ktime_get();
> +	} else {
> +		entry = xa_load(&adev->pm.gpu_metrics_readers, key);
> +		if (!entry) {
> +			ret = -EIO;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	if (off >= entry->size) {
> +		xa_erase(&adev->pm.gpu_metrics_readers, key);
> +		kfree(entry->data);
> +		kfree(entry);
> +		ret = 0;
> +		goto out_unlock;
> +	}
> +
> +	count = min_t(size_t, count, entry->size - off);
> +	memcpy(buf, (u8 *)entry->data + off, count);
> +	ret = count;
> +
> +out_unlock:
> +	mutex_unlock(&adev->pm.gpu_metrics_lock);
> +	return ret;
>  }
>  
> +static const BIN_ATTR(gpu_metrics, 0444, amdgpu_sysfs_gpu_metrics_read, NULL,
> +		      AMDGPU_GPU_METRICS_BIN_ATTR_MAX_SZ);
> +
>  static int amdgpu_show_powershift_percent(struct device *dev,
>  					char *buf, enum amd_pp_sensors sensor)
>  {
> @@ -2579,7 +2717,6 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
>  			      .attr_update = ss_power_attr_update),
>  	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
> @@ -2657,9 +2794,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  		     gc_ver != IP_VERSION(9, 4, 3)) ||
>  		    gc_ver < IP_VERSION(9, 0, 0))
>  			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
> -		if (gc_ver < IP_VERSION(9, 1, 0))
> -			*states = ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>  		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
>  			*states = ATTR_STATE_UNSUPPORTED;
> @@ -4755,6 +4889,19 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  	if (ret)
>  		goto err_out0;
>  
> +	if (amdgpu_pm_gpu_metrics_bin_visible(adev, mask)) {
> +		mutex_init(&adev->pm.gpu_metrics_lock);
> +		xa_init(&adev->pm.gpu_metrics_readers);
> +		ret = sysfs_create_bin_file(&adev->dev->kobj,
> +					    &bin_attr_gpu_metrics);
> +		if (ret) {
> +			xa_destroy(&adev->pm.gpu_metrics_readers);
> +			mutex_destroy(&adev->pm.gpu_metrics_lock);
> +			goto err_out1;
> +		}
> +		adev->pm.gpu_metrics_bin_registered = true;
> +	}
> +
>  	if (amdgpu_dpm_is_overdrive_supported(adev)) {
>  		ret = amdgpu_od_set_init(adev);
>  		if (ret)
> @@ -4806,6 +4953,12 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  	return 0;
>  
>  err_out1:
> +	if (adev->pm.gpu_metrics_bin_registered) {
> +		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
> +		gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);
> +		mutex_destroy(&adev->pm.gpu_metrics_lock);
> +		adev->pm.gpu_metrics_bin_registered = false;
> +	}
>  	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  err_out0:
>  	if (adev->pm.int_hwmon_dev)
> @@ -4821,6 +4974,13 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>  	if (adev->pm.int_hwmon_dev)
>  		hwmon_device_unregister(adev->pm.int_hwmon_dev);
>  
> +	if (adev->pm.gpu_metrics_bin_registered) {
> +		sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_gpu_metrics);
> +		gpu_metrics_free_all(&adev->pm.gpu_metrics_readers);
> +		mutex_destroy(&adev->pm.gpu_metrics_lock);
> +		adev->pm.gpu_metrics_bin_registered = false;
> +	}
> +
>  	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index aa3f427819a0..3677a4f543fb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -349,6 +349,10 @@ struct amdgpu_pm {
>  	/* dpm */
>  	bool                    dpm_enabled;
>  	bool                    sysfs_initialized;
> +	bool                    gpu_metrics_bin_registered;
> +	struct mutex            gpu_metrics_lock;
> +	/* per-reader snapshot entries, keyed by (unsigned long)struct file * */
> +	struct xarray           gpu_metrics_readers;

Pretty clear NAK on that approach. What the heck are you doing here?

Regards,
Christian.

>  	struct amdgpu_dpm       dpm;
>  	const struct firmware	*fw;	/* SMC firmware */
>  	uint32_t                fw_version;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> index c12ced32f780..dc6875871f1d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
> @@ -73,7 +73,6 @@ enum amdgpu_device_attr_id {
>  	device_attr_id__unique_id,
>  	device_attr_id__thermal_throttling_logging,
>  	device_attr_id__apu_thermal_cap,
> -	device_attr_id__gpu_metrics,
>  	device_attr_id__smartshift_apu_power,
>  	device_attr_id__smartshift_dgpu_power,
>  	device_attr_id__smartshift_bias,

