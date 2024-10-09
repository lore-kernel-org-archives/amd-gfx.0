Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6428ECF044A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 10:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0013810E24A;
	Wed,  9 Oct 2024 10:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FN0IKWMJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F6910E24A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 10:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNjGwXC+k8ZAzSaTUYUDAISFA4t6R3kGVVma9Lt56bRkHfJlr9p9u6800KNb56BLe3uOyf8SC6GvWwha7uOeUePHOQWPLfEnKhM5fFeF7EizK5ZGUbjT9c2+/WSwNo3yrJupXOygy+l0hlwE7Ohqs3ZrAk0bYmWMQKzGiPIRea9XQY3cAv+FVLlAJndKMljKxKEo/UU8P1zzqUaYjTCvbGesb2T8Wb8pGYY9upkaU1/kf+HYB53JW9w60WPw8eb+bfnav0Lm4Du4X5ewuhIHY/2d38MJZtzq54/2B9dntI9S02wD6u6GIMp457CPdUE6JWiK2lKZ5rnUxtO8M9HfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvvNrxT+n/sGeOWwiMiPL1Ymh/P2f1hHyCZe5WgcXcE=;
 b=TK5w6nbzJOZ2l/hHEQ8apcKH8OXIox98h6HFpUwJ2ONgD7w0SX8o7x7TAKrqCkxy/ca0fGdGSct7eCdEcmvjx4Ore2DkwUEmYwxOVIAdvQ+GrvEmX4/shsG04g9ENmd1NCkjMplHCM6NuI+nVfpqZ8wENh+uoN3ekZ293+1cbpP0Pp+0vQ1vt4KRmu1F65f504twdYzMwHWCNp65Ap0u7nscRs//NY+ye+SQ9kcNtntcqJSvMv+e2u0lcq00cOMKCwRn4JQhfdGNdxdLhknNpf+IfEWyiqPRYO6KiWTuEYOTuahXnorC9pkmRZnMzw58jp7HudBnEUPckoo8JNBsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvvNrxT+n/sGeOWwiMiPL1Ymh/P2f1hHyCZe5WgcXcE=;
 b=FN0IKWMJMJ6ov0lGO6gPaSqen2eFutfm9JXRXFXXqjRup4Doo2NwYFMf4AG3y8LNTnCEqP2697xkC6Hmr2Lo50C000ah+loh9Fx+wpRvn03/5rm/eY1n3qerw9X6IGFfKG4nSdXrX+pgZZeqkuSYzpnMGvf61bzCO4boJgjaONs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 9 Oct
 2024 10:49:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:49:34 +0000
Message-ID: <d605349a-0e09-414c-add3-b1a1350e1a9e@amd.com>
Date: Wed, 9 Oct 2024 12:49:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: validate if sw_init is defined or NULL
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009084823.828235-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241009084823.828235-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: a56e4855-8378-44b5-b367-08dce8500fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sk9jY2VYRklLQ0xXdmJxTnA2bkJSc21ERWVZVFluWG0yZW92R0RiUE9yNWNy?=
 =?utf-8?B?V1ArcUREMFJmR05qbkFRclhINmIvZ1JzV2pOUUdrSHBDbEJvZTRUdHEwUHJP?=
 =?utf-8?B?cWZBTkszaGNFNXZORWUrdGcyc2pEck1ub0hTZjFhNnNhQjVDTWtheGY1VHVX?=
 =?utf-8?B?TjA2d0NTTEF3RGdsNDgvWVJEZ2cxRXZnQ0JBU2p4WFVUL3Ixc05uOGNwR1Nw?=
 =?utf-8?B?RSsxN3NOanlFSWovZG9BNm5PcmJOaXVTMWg3MTdUVWhyL25SZEtDdXowbTdk?=
 =?utf-8?B?ekNHdWJZaTk1L3R1SDBJMTJTNVlkQ2s4VThCM3h3aXNONkp1bXRocXZwVmFP?=
 =?utf-8?B?VUxvR1RiU3lKNWEyejdwZ3dYZGRSblBhVkFGUlNVb3pTalJoSWFOVG9TSWJh?=
 =?utf-8?B?OEFZc29OMlpDMFlrdXJBd1VWQnRRa1lrenpJOU4xTU1FVUp2bHh5b1BIRWVL?=
 =?utf-8?B?YUJhcHFyRnlRK01YZWt2Q2tLQ2FLUjNBak9kbWMvcFdFTk43SFZ1YzlqSTRO?=
 =?utf-8?B?SzlTWFYrenhQc2pXZVd6cWRVMDN6bjIvNmdJM05obEpuREVNeWdkNUpacCtj?=
 =?utf-8?B?eEhNTlNzMkVBaHRUTlllZ1lYbjVjaW4zNmdpRms2eC9TVUY1cXpQUTNvT3BW?=
 =?utf-8?B?dXJaNllhOGU1enJCaGR3bENsWnVyM2tXWDNhVEhsU01OVVlDN2NSSk40RGx5?=
 =?utf-8?B?M0J4U0tyZWsyaGh6OGZocnM2MGJJbTkwZHVqSWVxd0M5WFpnZ05OTEZyQmNU?=
 =?utf-8?B?R0YyenJnV25VeGJXUWgzTy8zb25ZQTAwMUI1R3dSS3dvelQ4OG5Za2xMVnpP?=
 =?utf-8?B?cExzcGhyUjVPL2MweTBnUUM0Tk1YYjBDUWxjVFlkYThUVFdDWHcxTVoxYXBq?=
 =?utf-8?B?elZ1MjNORUc3T0Q1ZHZkYWlGbHE5OEpFYWRkd0Urb3J2YjdTQy9lK3JFYzNL?=
 =?utf-8?B?NVZoKzMvT3hBYXJPZy9ydHJkdTExeGs5NC9wMkd2dStlWkdoSkoxdG10OWpN?=
 =?utf-8?B?T2grekR0cDlHMDArZDlwZG1LN3lKSDdLdUJyeVZKQjBSQ0h5Y2w3UHRTMTJW?=
 =?utf-8?B?Ry9iYlE0OVhQUndqVE8xdUxiVU5kQlJJVmgwWmU0anFGaGN0UkZSOE9MYVY3?=
 =?utf-8?B?alprUUJlUXV1YzFncm15NGVJMmJ3SWs5aElPNkppak5CaEZXc0dDWFlQZzVm?=
 =?utf-8?B?Y2ZUVWt6UkllazZ2YkJwMkg0QWVCcjM0KzQ1QlludFQzNjFwNkF2dVY5YVFM?=
 =?utf-8?B?WHpJSUErTzYwbEV6OFAvQk8wNTUvRTY4Q0hpK0NvTWM1ODNkNGEyK21aTmZs?=
 =?utf-8?B?TVNzK3ZzbUNJVlV2TTBTUVJWQlVxTFBhQWE4Vlg2c0FJSXhrZStzaXpoM1Vr?=
 =?utf-8?B?V05jVEhac1htNmx6OWhBa0E4dUhLaHcvNlFTVlU3NUJhamlNc2ZYNUVsWlJZ?=
 =?utf-8?B?akNRK1R2dWFJbGovR3lsc2l5di8xYzY5SFB4OGxCNW5OdXpqblZocHVndS95?=
 =?utf-8?B?QnNtNUxkbWhwMjJSS2VzMkZWY0dVcW5vcG0wMzNhb0NUVmY3WVZMU0pYSmZw?=
 =?utf-8?B?RGc4RitiWlgxc21pTFduaHJsZHUwd1pJbkhzL0ZGOUhhNjhIYXZmY0pxN0RW?=
 =?utf-8?B?Y0l3OGZkbHlXdGVnOWtEMkMwb2UzYVBMc2ZyYTF3S25lc1VmTXk0aE1JcTNu?=
 =?utf-8?B?MC9hNElCNWwwZGt2QnJIMk9oTHBXRVd4bWFqNTVjZi9FcWJQbWNKZHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHI1dkEyUkkyWmdzVXd0azJKRWFQMndYbVF0eGk1cFZrY0ZZa0VyN2xKQThP?=
 =?utf-8?B?TjhKK29XblZ1NlpoVTlOeURnNElXeGI1QTd4L3RlZ3NPZmxJeC82UE15eSty?=
 =?utf-8?B?UU1aZFQzOGtNNVJ2d3hsNUR0QUZsWjVScllWQVlIM0lWVjhqMlRZV1loNXpq?=
 =?utf-8?B?aE1GM3FaVFM1eHFadkx1UmNMMzFIdmR6Nm1EUXJ2eEYvQ1piblF2YlZydlF0?=
 =?utf-8?B?Ni9OclhtYndlRG5YcVhaelVFdDZndElScllseEJnMVFIKzgzck05d01VZlJL?=
 =?utf-8?B?NlUvd3ByNUZRRHp0TWVaQzduRUVlWngzS1BXUDFCLzU4MldOaDNtSjRDTnFX?=
 =?utf-8?B?OU1GZ3JtZklSbW9EaUxic2FTZmtNVEVuN240NjZNand6Y0MxWEROL0JvS3k2?=
 =?utf-8?B?WGNjeFd6Z2ZEUDFheDF3YlhCTVRMRDIrZlBLbG01OUNyQVgwVjNpZHJ5eDBE?=
 =?utf-8?B?VldyK2pUTTUzcEc4Y3puYkVDSnhqZFl1Wkc4VVUxOWRmTTRQWXR4WTY0Ylhm?=
 =?utf-8?B?TXRBT2dCTk0rZHdONW1RMm12eXpDTTdrNU5nNWZhaHNETStGcmdBMHl5c3Uw?=
 =?utf-8?B?OFFGQUpzT2FTWDRWVTFCbVVqUTBTMnRNOEduWEEycUZHdWFZU0dRY2cvbXB0?=
 =?utf-8?B?NGdISUk3S3hzVTlMWXMrWkgzb3NrNGtNcWs1YjlCcU9NY3R2d0pVRmY4OGpv?=
 =?utf-8?B?QXE4aWsrVTJldUJjUzlYQ0MzTHRhQmhVNmxTRkgvSlIwS2wvZW1vdk91QnBn?=
 =?utf-8?B?VjVvVlpUM2NHeUJtV09jUUEwMVhqcldNS3J5d3lKQ2ZKeEcwcVJiaW5RWE9p?=
 =?utf-8?B?dVhFQ1pKbGJ6QjF1a2EzclVTdVF1Q2xZQjJNOS93SzBJT1R0M3lBOC9PMFVW?=
 =?utf-8?B?bFNEZXVaS3VrSjBJUEtpb1o2NndnM0ZKUzBsOHRlZHhhM3cwNVFObWpaTU5y?=
 =?utf-8?B?VEJvdVNIclVJMThQZDR1MlNiU0gyeFluN25NTTZzTnNtZlJlRUhKeHBXUWJF?=
 =?utf-8?B?dk1PamZiQjFBUWlWeHlJbFI3cXhiR1lYNHhHR3p5MHU5OVZWSkRpQzZ3VFlk?=
 =?utf-8?B?czdHL3NQandoN0xJUVJ5a0pMQWgxSWhwZ0VMWktPZ3JXempRMzU2R0FFTjhp?=
 =?utf-8?B?WUZURkhlMm9BN3dmckNOY21RK0pWb1VwZkZJTCtZVElmaG1HU2hRSTRvUzEz?=
 =?utf-8?B?c0UvbytsTjhPeVg0TmJZUjV3aDBhMDhNNFdCMjNhNVVZQTcrRE5nVEZ3RWth?=
 =?utf-8?B?N3JrODdOenhoT05pQ2Ryc2VVS0xqRGhua3VRRC93bFRyM2xWbitBNGc0dVVT?=
 =?utf-8?B?WHZ5V2hHdllXb3ppUU1GK09EcCs5Unc5Mk9lbFpIbzBUdVNhSFp5WHdyWko5?=
 =?utf-8?B?NVNtTGJicVNSZVBvYUxSaURPWXNUN1RCS2JKcXRWTjUzL0xRRkw2disxTStD?=
 =?utf-8?B?VjVDQjlzdUFFWlI0elpQZ3BTZ1dHYlZOODZOUVA4WXlTQ1pObHFwL1JXUS8x?=
 =?utf-8?B?N0lQcVQ0R3UwaVUwMTAvM1NzM0R5SVIzTk8yYVFtRExNSU5qdjBNM2N5dGpo?=
 =?utf-8?B?SUxKOTlxRFZ4NnkvaVZVSzN1aG9UYkk2WU5Pam40a2xTTmRoWlkzRTREcXpl?=
 =?utf-8?B?TDFkS3pHeWlnaGhrM1RNUDRlbUszOHViVUJhZDR1ZXI4RzR0NzZwR0RFTERV?=
 =?utf-8?B?dmRabEpKRTRCcElpT1N4VXk3bm9WN1h1ZWtLV3BDZklKUHpjaVBzTE1qL0pF?=
 =?utf-8?B?RHpJUUhxSWU4R3EyS0FRWm9SOWlSTy9KVXVpc2hLVEhTWWUyd3h3MEhycld2?=
 =?utf-8?B?dGFuK3V2VW5zazJHMVBJWlR4bmhqcU10NVArSFBWbWl2bnZRcm9waWJsajNR?=
 =?utf-8?B?b0I5cG0ySmsxay9EQVZ4a09vcHg5VUh1R2Y5RWk1ZFFhMTFRY1FXRk9wWTgr?=
 =?utf-8?B?QjM2QUUzMzVTbnNpakVidVpZYy9xQTA5S0IwUitsNUI0VXdZd216alVDMW9r?=
 =?utf-8?B?RWlpRmd0M1JUckFweGhNRzNjdVZZbmFEazZRRUFvNVc0TTd0b1NlYWlEcDFP?=
 =?utf-8?B?MWE0b2tYcUVmY0ZBakNERThXSHM4MXF6SlcySllPY2hFODFmb0tXU2hxQ1pJ?=
 =?utf-8?Q?ZDKE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e4855-8378-44b5-b367-08dce8500fc8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:49:34.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMEYcu0tUnetKenczfXCONE4D2oj/mbcSDGP8uK7BSlMUMpB7KmS4+SQp3moPjQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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

Am 09.10.24 um 10:48 schrieb Sunil Khatri:
> Before making a function call to sw_init, validate
> the function pointer.

Maybe add " like we do for hw_init." or some similar example of optional 
callback.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 38a7423101f3..4a6def74964e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2851,13 +2851,15 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;
> -		r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
> -		if (r) {
> -			DRM_ERROR("sw_init of IP block <%s> failed %d\n",
> +		if (adev->ip_blocks[i].version->funcs->sw_init) {
> +			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
> +			if (r) {
> +				DRM_ERROR("sw_init of IP block <%s> failed %d\n",
>   				  adev->ip_blocks[i].version->funcs->name, r);
> -			goto init_failed;
> +				goto init_failed;
> +			}
> +			adev->ip_blocks[i].status.sw = true;
>   		}
> -		adev->ip_blocks[i].status.sw = true;

I think we should set that to true regardless of the callback being 
defined or not.

Could be that an IP has a sw_fini callback, but not a sw_init one.

Regards,
Christian.

>   
>   		if (!amdgpu_ip_member_of_hwini(
>   			    adev, adev->ip_blocks[i].version->type))

