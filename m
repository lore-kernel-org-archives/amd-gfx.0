Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C7EE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 21:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4E710E43C;
	Fri,  3 Jan 2025 21:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKNx+bwm";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EAF10E43C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 21:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2Kkke3Z5darEiXjrRYEollI0iVvBmjpidj4Q6MjgEc8Vu8Qlhs0mL6gV0F2+mTEXNWKHXTQJGvjd/ruJLYZguszlz3hL+zT7DNIKicznZsA3wX0TM6iIUKwuwpm6OWt6F+iIY0a7M9ZGe+VeNkBxeHNyy4+EYX0kFhoPBe+0lZcW3mYXWAn4rx/1rs9ZYO73/KYi+Bm8t/FvfaEJM2veiWiCYn1ODJEK01e7nG6zTL4zO5TVGCKjvK+J/BjobAwKRocTeaaIb/CEn/DpJpJCnLogAd0OQtHxCHOB/3Qh1Q6d6KXQGTlXqd2Z6VPlU3Gl5ppHBJ0JYvzNGZnFhcJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOc2um/5NQcFegeSq7gYZ3t0J3fwfukRvG+LhKxLwYg=;
 b=V5S1XbnPChUuFfIsqrctsL0ove+G5Y3V790KDUWulduc4UZqiqhgFu3H/t4fiXG4pofeoNtgUMl2g/v87XXqmbg0DsOeNt37mlrLvNgzXJ818lxjc8o5pXUTNYPmCtZNbWRZEXBCGAy4zerUTldbrQjTJl9Tv2E1Ea2Da9SCmy2XJPWkvBBgpK3OBTZlSp/0nbdy+kYrxFXW3rFBEaA/HELeSB1ZwnKhxnqK1pYb2/2zE1ZeikCOJPF4O5KbypgvzR1UxgQbutY198/D1a3w6oXtRRrF2ZAHPePo4HxKG3nbnzVewJ1/S1ygAYYVmByPqRpag22g2fgughR6raPupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOc2um/5NQcFegeSq7gYZ3t0J3fwfukRvG+LhKxLwYg=;
 b=lKNx+bwmegcV/+gndmnDtCiJo0iQOw/7uHqag4PPgEif0UuBohFNZ1611fXecN4VLT5BQ+c/k/QGATPXm4ojZ7xv34Z3JYaYUEl1akOXOQFGee+n07tYIzQcs0WCB0tnhRK1qstTI0IxqYjqGxQ+14Q5Sgl3xfEBZJl3quQYqX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 21:37:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8314.011; Fri, 3 Jan 2025
 21:37:34 +0000
Message-ID: <bc8ff41b-b5cf-445a-9d93-39f0cc1121e0@amd.com>
Date: Fri, 3 Jan 2025 16:37:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: add CEC notifier to amdgpu driver
To: Kun Liu <Kun.Liu2@amd.com>, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com
Cc: Mario.Limonciello@amd.com, Alexander.Deucher@amd.com,
 richardqi.liang@amd.com
References: <20241230081501.93823-1-Kun.Liu2@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241230081501.93823-1-Kun.Liu2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0444.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3825e441-d816-4dea-16bd-08dd2c3ed586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amdBMzVTVU9OdG9JanYvN0YzU3Z3K09XYzQrSTVDaWtZTlJ2M1VEUkNxeDBj?=
 =?utf-8?B?b3JhWGRwU094WE5lbWFrZ0thdGFpYld3T2FYN0ZOY3E2VmJNUHlraXlGZnZP?=
 =?utf-8?B?VkdmWm9sT2lYSkhqcFJxSFpqRklhai9rMmRwRm9aYlZKK3RYSGpJdURYZVBh?=
 =?utf-8?B?TkYvZ0xuRWt3TVg5eWxpTnJobTRYSjF5bFJXcTREcTFCYnVXUnpVZUEzdFdK?=
 =?utf-8?B?UC9DYjlFbktQUlZTTjc5SklOMlhqNFdzUmdub2I5aDMrSlpDblJ6YTZ6SWMx?=
 =?utf-8?B?Sm1zQlJpa2xTYk9NU3ZEK1FZdEhLUkp5WUZnN0VhdTVLbmo2NzI0a1BVbENi?=
 =?utf-8?B?V0R1NitHWExWQ2xvNlIvekpuUEwzSmpYaHhtaVNEL1JHbzE4bXYvUnBnQ2pO?=
 =?utf-8?B?eXJnNVgzMUJSTDRic0NBdGJxaS9ZM0UrM0pGelZNS09FZ2o1dEZ3Z2NyRGFD?=
 =?utf-8?B?R3BZek1hMk1TL25SVUNvMU5JOTdZMHU1YUJuUWVhQ2RRUys0M1hJWjNWZWhI?=
 =?utf-8?B?QXBDTG5sZEtwaFNMaEFkem4vVCtwd2duWVJxUENqUmJJbzlFTG0rUkM0YTJu?=
 =?utf-8?B?dnMwRnZmdDg1OUR3Vm9MWGMvQUdHVXVaUHhjYXAzekNjQVdmV0hOeE8wbWdi?=
 =?utf-8?B?NHBnVE9sbVVNRVBLenZvUFhhRHNsM0YyYVI5c0kwUHVKRVgzaHBZeisrTjUz?=
 =?utf-8?B?alNjdW8rNFhobDVhNUxxZUYzSmZhOUJiSWVKS1U3dlhiSVY3TnVXQWVlMi9r?=
 =?utf-8?B?WDZOYkViWWw1bTg0SWpaLytFZjdLd3lnMmJIQmp4N25ieUZ0VlpiSDd6MDY5?=
 =?utf-8?B?OU41NmN5a0RWQmtkOHp3bDF6dGd4NkpRM1FnaVJTMmgvM0Fub3VIbkwyTDhM?=
 =?utf-8?B?M0Q2UzRTZmwvRi9ySlE2b1R0Nlo4djIyWXVBRk8wZmRQV0lCZVdLZGpYWG1o?=
 =?utf-8?B?UXBEQmc0L3FNcTJLK3hCeHRBMEhWZDFBNmlmM3ROZ0krV3ZmZkdPWmtMRVFq?=
 =?utf-8?B?aC9KaEJ2dmo1YmZERG4xWHNmZ3JDT25ZSk42MXQyVW9heXNrTXZZSDhIWTZn?=
 =?utf-8?B?RldzUDJxUmU3ZkhEWDhGS084NEE0N2RCWVVUWU5ZME1mU1VTL3RLaWE3YnJM?=
 =?utf-8?B?bEpzaGQzN0p6YXdjbEdNSkxlQW5nZzFtTXJmUjhiSmZVaHh5VU9SSmNrd0Nq?=
 =?utf-8?B?NEc5VnZTT1lsZHRxU2JpQlRnWFZWV2dwR2EybS9rZTRkUEZ3TnJPZnR1YTBk?=
 =?utf-8?B?N0pKMTZYN0J1bDFhWFlsdklsOFNVc0xZMndRUnNuWmxzNUQwMDVjMUducGZl?=
 =?utf-8?B?VjA5OE1IREw3ZFh1TitYYVRtVUQ0cC9JR2d0ZzFhVFVKM0F4VmozSmJOTCtx?=
 =?utf-8?B?eStLb2E3c3lPb09NRURnQ3h5Q0ZIZXViVDVqSnVKVlNrbVdRdDlDalRZOHpi?=
 =?utf-8?B?bDU5ZytVL29LbEpJUFA2cmpOczhmNWFtcDcwUzM2SjMvWjNwVVpsQ25iZVNv?=
 =?utf-8?B?RGp1MXVLNVp1blM0c2FyWkZwai9UZEVQaE5KRU9TRGFIQ1ZjWGY4WEpqV0ts?=
 =?utf-8?B?cUJoVjJtZW1ZSm4vU2YvMjNFUWFqeis4dHI4SmxMa3NNdzg3M2pCYkUvZkJw?=
 =?utf-8?B?bU5xVU1uV1dJOUdFRWlQWS9IbXBGZzkyTVM5bTY0ZExaWFltWnFlLzZvb2Nq?=
 =?utf-8?B?WHlHaTMvU0VTZkpCM0xTaG84ZUN5VzNBZFl5UTFnVnQ2NzY1Z21ncTZSUkJG?=
 =?utf-8?B?UFJwRy9WYTZudE5tSmErd0xoWHZJZ0VBd1JFYnVodTZRM3p2enFYRWxJVkl5?=
 =?utf-8?B?R1BCTnFINU9YKytDNWwvQjFDY2VWUHZDNnQ5SEpyRTRWZVpEWGdLK3kxSU1u?=
 =?utf-8?Q?qQyZ8Wxd1kFe4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEMzajdRd3Y0MWFzTFJoazQ0c0J3Qk1waUNHdGlaYndTTThzL0pvZkdvSGRC?=
 =?utf-8?B?WENFc0V5WndJWCtXUmV6VnpJQll6cjFsVDEwVWl2MkxhY21JdWZoYjgvWDZt?=
 =?utf-8?B?cFgwTUtXcStwTHpGSk5sRDVPemVJUE9vc1d1Tkk5UmtXSHY1TkF6TEV1T0d2?=
 =?utf-8?B?MVRBRWFNVGV3M3Z5V2p5MndpZU5wblpwSjBUTzlXTXByOVk2b3M3ZXloNGtm?=
 =?utf-8?B?dGdzR1VkakJJSDd1djNEZFJ2VjkyaS9PdW5zSzQvZ2s2S2lFdFE4cTBWdThz?=
 =?utf-8?B?ZzdwSEF4cUVlRW1ORy9wSXRUZzl0QnVMaWErNVcxNmdZM2xZMFNvem4rY3Ev?=
 =?utf-8?B?SUNwMVFaQlI5U2VWVUtmdEdmMHF4MW4veklkYkJ0N0tCYUZtL3dkM2x0L3Bo?=
 =?utf-8?B?QXluaElva0hUUGp4WjJick5kekVGL3NvWkVmNmI3RWZGUGtpL2lRblVBZmxR?=
 =?utf-8?B?MGRRYUFFam5GUW14bWlDMHBOWFZDTitoZlFFb3FSS2hBM2hTZTRxckJ1Z3Bo?=
 =?utf-8?B?SnZBN0Vzb3hFMmdGSUN6bTNBVTZSb2YvREJJd1dqeENLNC9KVGsrKys0YytQ?=
 =?utf-8?B?bzJkV1hMS2t6OStjVDVTY3FPSk9KMDdHcW1PdFRwTzJqT1YvTWxpS0JYdVZW?=
 =?utf-8?B?M2pOanBTMEE1NFRUNmE1b3BIZG9CaU96QmZwcmRsVE55SnV3eEgxSEVGRHE4?=
 =?utf-8?B?bnh5WksvL1pKUmlNZWc4ZTV2Y1ZOVHhLUzFCZUU1K28reGd2K29jMDEycndI?=
 =?utf-8?B?Q3JINjNWVVk3ZXlQMlVEbXJObnZPUEsvSWFBaEZPVnk1KzNVVC9sZE9oTTZJ?=
 =?utf-8?B?eDFoZ1pjUXd0aVlCcnQvSTlTTGgxQkhHRzFpWDRkOVdsRCtvKzlQMUNDeVBX?=
 =?utf-8?B?UVdmUVNlZVc1TGhFc0s5K0kzR1dRK0V4UEpxZkhUZkdrNXpQVjNMZnhSR2xU?=
 =?utf-8?B?ZWFvb0ZKYWdnbUpva1JlREJPRWRLRW5qcVI5UThTL3dQM1JFdXU4YkdvaTU2?=
 =?utf-8?B?amZCNHFhdG5IdkRnWmp2d1JiRjNwMTRBRGFoamVVUzdKVGxPem8yTDNhRUNx?=
 =?utf-8?B?OTAxZitzaW9HdDFVUGxnM1Q3QXQreWJKYUtGcnZaNVVtRUtNR1dCcXdvWmhD?=
 =?utf-8?B?dGd4VThpaXdtOGNnRzM4Nml1d3RnZTVvV04rek1Hc1ljVEgvRTdvbWJIWlRO?=
 =?utf-8?B?YWU3YTV2NDJGN05VeVUrL2theXl3MGtCTnRCdnhMZW1LZFJMUFRpMTQ0UGR3?=
 =?utf-8?B?cHpPSktsSjNydXBLWldkN0RpZ0hJZEFlNUR4VldyWk9yT3AzUFduNDVJTDZU?=
 =?utf-8?B?ODBBK1RhRjA2eFRCWFhuTnhhN0luSFA3ditnN0VFUExncWJTSlFCZ3Qvc1RN?=
 =?utf-8?B?cUVGbjVaVmpsL2NlWjJRa1NhYUdSQ3BGdHM5RHh2RUczV1VrOFJHTndiUUdR?=
 =?utf-8?B?TGd2NzJhNVlNNWdXeG8wRDRrd3Q2c1gxdk93dWxJTUJRN1NxamlxZ1ZiRkRL?=
 =?utf-8?B?YVRSQUxyK1Uzelp4UGJROWpXaDNqVU52VUd1YzFhVitVa1M0ZmZwS2s0dHpm?=
 =?utf-8?B?YWpTZFdtbXdLcGJKQTF3TjZPWjU0dTV3RXdhQ04zbXBGcmhsWFBRVTJLZlph?=
 =?utf-8?B?UzdWUkFFRXBZV0dZMFU4Y0pBdnVvR2hCQ1h1RVRwdXZJVWVwVlhKTkRLZkNs?=
 =?utf-8?B?VzBTaVhJekxTZkVIQkZhaHhLNXB6MDV1dVRSdTVncVVJQlJEYm1wMXdRa3FH?=
 =?utf-8?B?RTNWOWdZV0RydEdnZzE0QjJzS2taWW9yMkRMZjFvNFhkdVl1ejRoalFXalZ5?=
 =?utf-8?B?N2J4eG5HSmJBMDNMMXhBQ0VmOWRaWnNqZGF3YUNWcUR0Tk01aSs1RVlYVVVD?=
 =?utf-8?B?TTJiYVlVQ2pYc01uUjJreGtVL2h2T0M4MTUzUjBpOTBad2ZmZjhLVjByOFRS?=
 =?utf-8?B?NnJTYXlORWJBaFNJSW40SGo3OGU1UDVZcTh1NzNCNEh6citrUklZcEJLQ1or?=
 =?utf-8?B?dzBJK29odlFkeEQvSElmSzFPTjVHVy90TGhjRE1iMXJJLzUvN0VyaUgxdGdM?=
 =?utf-8?B?ZUR4Qy9HYjJWdm1hMmJ5Mjd6eExSbDVuaDVVUEY5K1hwNzlzSWNNck5EZWRs?=
 =?utf-8?Q?Lc5fvH7bqniFVdiJW7CuxU1gF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3825e441-d816-4dea-16bd-08dd2c3ed586
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 21:37:34.0424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Elb+QTdYuDwhQSE7wcvmzhx5CzhUufGfVaiL5D//qadUh7EkcNn9g3te3j5KmKz3UeMNH6pUkmua6h+iRo72KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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



On 2024-12-30 03:15, Kun Liu wrote:
> This patch adds the cec_notifier feature to amdgpu driver.
> The changes will allow amdgpu driver code to notify EDID
> and HPD changes to an eventual CEC adapter.
> 
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig           |  2 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 66 ++++++++++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h      |  5 ++
>  5 files changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 11e3f2f3b1..abd3b65643 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -8,6 +8,8 @@ config DRM_AMD_DC
>  	bool "AMD DC - Enable new display engine"
>  	default y
>  	depends on BROKEN || !CC_IS_CLANG || ARM64 || LOONGARCH || RISCV || SPARC64 || X86_64
> +	select CEC_CORE
> +	select CEC_NOTIFIER
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
>  	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
>  	select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && !(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 85f21db6ef..3bd93cc14f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -97,6 +97,7 @@
>  #include <drm/drm_audio_component.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  
> +#include <media/cec-notifier.h>
>  #include <acpi/video.h>
>  
>  #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
> @@ -2746,6 +2747,54 @@ static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
>  	mutex_unlock(&mgr->lock);
>  }
>  
> +static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n) {
> +		drm_dbg(ddev, "failed to unset edid\n");

If I read this right this function and the set_edid one
below will be called on all connectors, not just HDMI ones,
and will spam this log to dmesg. I recommend we drop the
debug print here, or, at minimum, combine it with a check
for connector type.

> +		return;
> +	}
> +
> +	cec_notifier_phys_addr_invalidate(n);
> +}
> +
> +static void hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_connector *connector = &aconnector->base;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct cec_notifier *n = aconnector->notifier;
> +
> +	if (!n) {
> +		drm_dbg(ddev, "failed to set edid\n");
> +		return;
> +	}
> +
> +	cec_notifier_set_phys_addr(n,
> +			connector->display_info.source_physical_address);
> +}
> +
> +static void s3_handle_hdmi_cec(struct drm_device *ddev, bool suspend)
> +{
> +	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +
> +	drm_connector_list_iter_begin(ddev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> +			continue;
> +
> +		aconnector = to_amdgpu_dm_connector(connector);
> +		if (suspend)
> +			hdmi_cec_unset_edid(aconnector);
> +		else
> +			hdmi_cec_set_edid(aconnector);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> +
>  static void s3_handle_mst(struct drm_device *dev, bool suspend)
>  {
>  	struct amdgpu_dm_connector *aconnector;
> @@ -3017,6 +3066,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>  	if (IS_ERR(adev->dm.cached_state))
>  		return PTR_ERR(adev->dm.cached_state);
>  
> +	s3_handle_hdmi_cec(adev_to_drm(adev), true);
> +
>  	s3_handle_mst(adev_to_drm(adev), true);
>  
>  	amdgpu_dm_irq_suspend(adev);
> @@ -3289,6 +3340,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>  	 */
>  	amdgpu_dm_irq_resume_early(adev);
>  
> +	s3_handle_hdmi_cec(ddev, false);
> +
>  	/* On resume we need to rewrite the MSTM control bits to enable MST*/
>  	s3_handle_mst(ddev, false);
>  
> @@ -3598,6 +3651,7 @@ void amdgpu_dm_update_connector_after_detect(
>  		dc_sink_retain(aconnector->dc_sink);
>  		if (sink->dc_edid.length == 0) {
>  			aconnector->drm_edid = NULL;
> +			hdmi_cec_unset_edid(aconnector);
>  			if (aconnector->dc_link->aux_mode) {
>  				drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>  			}
> @@ -3607,6 +3661,7 @@ void amdgpu_dm_update_connector_after_detect(
>  			aconnector->drm_edid = drm_edid_alloc(edid, sink->dc_edid.length);
>  			drm_edid_connector_update(connector, aconnector->drm_edid);
>  
> +			hdmi_cec_set_edid(aconnector);
>  			if (aconnector->dc_link->aux_mode)
>  				drm_dp_cec_attach(&aconnector->dm_dp_aux.aux,
>  						  connector->display_info.source_physical_address);
> @@ -3623,6 +3678,7 @@ void amdgpu_dm_update_connector_after_detect(
>  		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
>  		update_connector_ext_caps(aconnector);
>  	} else {
> +		hdmi_cec_unset_edid(aconnector);
>  		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>  		amdgpu_dm_update_freesync_caps(connector, NULL);
>  		aconnector->num_modes = 0;
> @@ -7042,6 +7098,7 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>  	if (amdgpu_dm_should_create_sysfs(amdgpu_dm_connector))
>  		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>  
> +	cec_notifier_conn_unregister(amdgpu_dm_connector->notifier);
>  	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>  }
>  
> @@ -8278,6 +8335,27 @@ create_i2c(struct ddc_service *ddc_service,
>  	return i2c;
>  }
>  
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
> +{
> +	struct cec_connector_info conn_info;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct device *hdmi_dev = ddev->dev;
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_HDMI_CEC) {
> +		drm_info(ddev, "HDMI-CEC feature masked\n");
> +		return -EINVAL;
> +	}
> +
> +	cec_fill_conn_info_from_drm(&conn_info, &aconnector->base);
> +	aconnector->notifier =
> +		cec_notifier_conn_register(hdmi_dev, NULL, &conn_info);
> +	if (!aconnector->notifier) {
> +		drm_err(ddev, "Failed to create cec notifier\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
>  
>  /*
>   * Note: this function assumes that dc_link_detect() was called for the
> @@ -8341,6 +8419,10 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>  	drm_connector_attach_encoder(
>  		&aconnector->base, &aencoder->base);
>  
> +	if (connector_type == DRM_MODE_CONNECTOR_HDMIA
> +		|| connector_type == DRM_MODE_CONNECTOR_HDMIB)
> +		amdgpu_dm_initialize_hdmi_connector(aconnector);
> +
>  	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
>  		|| connector_type == DRM_MODE_CONNECTOR_eDP)
>  		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 6464a83783..4c1942652b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -671,6 +671,8 @@ struct amdgpu_dm_connector {
>  	uint32_t connector_id;
>  	int bl_idx;
>  
> +	struct cec_notifier *notifier;
> +
>  	/* we need to mind the EDID between detect
>  	   and get modes due to analog/digital/tvencoder */
>  	const struct drm_edid *drm_edid;
> @@ -1010,4 +1012,6 @@ void dm_free_gpu_mem(struct amdgpu_device *adev,
>  
>  bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
>  
> +int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
> +
>  #endif /* __AMDGPU_DM_H__ */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 6a97bb2d91..922f329175 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -25,6 +25,7 @@
>  
>  #include <linux/string_helpers.h>
>  #include <linux/uaccess.h>
> +#include <media/cec-notifier.h>
>  
>  #include "dc.h"
>  #include "amdgpu.h"
> @@ -2825,6 +2826,67 @@ static int is_dpia_link_show(struct seq_file *m, void *data)
>  	return 0;
>  }
>  
> +/*
> + * function description: Read out the HDMI-CEC feature status
> + *
> + * Example usage:
> + * cat /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + */
> +static int hdmi_cec_state_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector = m->private;
> +	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +
> +	seq_printf(m, "%s:%d\n", connector->name, connector->base.id);
> +	seq_printf(m, "HDMI-CEC status: %d\n", aconnector->notifier ? 1:0);
> +
> +	return 0;
> +}
> +
> +/*
> + * function: Enable/Disable HDMI-CEC feature from driver side
> + *
> + * Example usage:
> + * echo 1 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + * echo 0 > /sys/kernel/debug/dri/0/HDMI-A-1/hdmi_cec_state
> + */
> +static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
> +				     size_t size, loff_t *pos)
> +{
> +	char tmp[2];
> +	int ret;
> +	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> +	struct drm_connector *dconn = &aconnector->base;
> +	struct drm_device *ddev = aconnector->base.dev;
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	if (copy_from_user(tmp, buf, 1)) {
> +		drm_dbg_driver(ddev, "Failed to copy user data !\n");
> +		return -EFAULT;
> +	}
> +
> +	switch (tmp[0]) {
> +	case '0':
> +		cec_notifier_conn_unregister(aconnector->notifier);
> +		aconnector->notifier = NULL;
> +		break;
> +	case '1':
> +		ret = amdgpu_dm_initialize_hdmi_connector(aconnector);
> +		if (ret)
> +			return ret;
> +		cec_notifier_set_phys_addr(aconnector->notifier,
> +				dconn->display_info.source_physical_address);

Would it be better to call hdmi_cec_set_edid to
consolidate the codepaths?

Harry

> +		break;
> +	default:
> +		drm_dbg_driver(ddev, "Unsupported param\n");
> +		break;
> +	}
> +
> +	return size;
> +}
> +
>  DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
> @@ -2837,6 +2899,7 @@ DEFINE_SHOW_ATTRIBUTE(psr_capability);
>  DEFINE_SHOW_ATTRIBUTE(dp_is_mst_connector);
>  DEFINE_SHOW_ATTRIBUTE(dp_mst_progress_status);
>  DEFINE_SHOW_ATTRIBUTE(is_dpia_link);
> +DEFINE_SHOW_STORE_ATTRIBUTE(hdmi_cec_state);
>  
>  static const struct file_operations dp_dsc_clock_en_debugfs_fops = {
>  	.owner = THIS_MODULE,
> @@ -2972,7 +3035,8 @@ static const struct {
>  	char *name;
>  	const struct file_operations *fops;
>  } hdmi_debugfs_entries[] = {
> -		{"hdcp_sink_capability", &hdcp_sink_capability_fops}
> +		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> +		{"hdmi_cec_state", &hdmi_cec_state_fops}
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 98d9e840b0..05bdb4e020 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
>  	 * eDP display from ACPI _DDC method.
>  	 */
>  	DC_DISABLE_ACPI_EDID = 0x8000,
> +
> +	/*
> +	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
> +	 */
> +	DC_DISABLE_HDMI_CEC = 0x10000,
>  };
>  
>  enum amd_dpm_forced_level;

