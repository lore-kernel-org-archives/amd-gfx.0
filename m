Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE802D65C70
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5946410E8AB;
	Wed, 17 Dec 2025 15:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03QicO9k";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011032.outbound.protection.outlook.com
 [40.93.194.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1166710E581
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxyJ5QlphhZodjO36+Uo5YmpbYZ+QQAIrVRYa0L7q+FMOBoMoIdfFnlZH8p1GqJNiaRsXxhMCUsPo7VDSmmn+s11zU09tzCpropC1Ob4TJS2CTJcIamqx8LpBOPv3m5xj0hnavHkz0xazYKIOWwCAd8nM2ECX5W0lvhueZoLVV5Aob6+pJlyui+JCjm49biyM1wiIXrd0mUed0QUg9T0Yyply7BuBvOJdnzl6fNiEbI7ZcDyyVL/a61cvOL0l1Xd95MgGSuJsCy63RirM+wssnYpmkKi271HwUxFWu5HAtCSY/QT/+gCQ++sBvg3VvpVN54S64F1BPJkGn1kgRiOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B180liyY2Qm97DnY7OU92+9v838FHMKknm6Xkd+W1c=;
 b=xhsqfPRzWEDIwLKS9TrVJifLALFOgkeKaNTBNi/FpyzCVBcyyjIeL7ltmMeDkGzaQDOZbe66tzuhEitYJ9wsVsNRju13rx5tKN0I6OeV7VsBiDpk4dB6r6mLYlD8e40lwiYHmxY1hcPkRwCgM7V0CLrt7QBX63Rt55QCCGIHLd/XKgYjdB0nkou/xjZjuoEoLaxU8m9ogi8kO7Yx1nQFFx8ae31Gwa1t9KxzekS+xJTIVKaXYDIIK7JVauHP10C318cz0d+qlINKDTR2r2E9cyGSWbekFzNfoR869Zbs7SxBrxLaI2U5jxwfz4lK9PsiQvlHV3Sz1r5iATFapR1QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B180liyY2Qm97DnY7OU92+9v838FHMKknm6Xkd+W1c=;
 b=03QicO9krhKeO+bMoIToxNaKTt9+Gm/axchqU4JHtqnXqHjC6N1axHF29m9Uc/u12ByFCQw4RDp6bS/rV+J1MNa79eR4P3xGVoF+8nZwlSjkvuX6lW66wrVJyKbO5AT0VJqjvX5AyRFA7XSa7jlR0KtejV3VADNFiHDSmg7DHQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:44:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:44:22 +0000
Message-ID: <3721bd77-a1e1-48b4-afe1-d0a9845c7b2f@amd.com>
Date: Wed, 17 Dec 2025 21:14:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Skip SMU init for backdoor loading
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
References: <20251217154151.2018978-1-alexander.deucher@amd.com>
 <20251217154151.2018978-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251217154151.2018978-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: e0da985e-44b5-4259-def8-08de3d8325fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHVJMlVGWVFnTnoxSHFXckVYS1Njc2lsV0tkMEhkSkd6aFVrdHM0NUNMQXJW?=
 =?utf-8?B?Ti9DVUg1RU13MzQ5aW5HZXhwdWZVK3RsQVN2N1BwVjB4Wk5wdXBYa29ZKzRn?=
 =?utf-8?B?TG1hU0FpK0VJSGtaaTgxV0dsZE5CMXVJZUZ5Y2dDWjRTV3RnNmZ4L21jRVVt?=
 =?utf-8?B?UmkwRlp3WER0azI5d1c2b2k1b0srVmlFZnlDWU9UMlgzanB5b2RjOFR0cmVi?=
 =?utf-8?B?NzUvOTVyUWlERWthUUwwZlZ2NGJWM3c4TFl5aXdJdlQ1dlU0VWdxbGdNdTJk?=
 =?utf-8?B?ODFoTHhBT2dYYkExWnQ1SXI0REdkaSsybWNMcS9RTm1PMC9ycXVCb01ZRXlB?=
 =?utf-8?B?eU9lb1JvZFRpcUFUaWpjK1dyRmgyc2Z0YkNpQWk2a0dKY1JaQWxPY3RzcmVE?=
 =?utf-8?B?aWZpanAyYS82M3V0Z1VHK3V2Q09YV1dURk1ZbHRQSEpJQkEwcWFvK3paQ3B2?=
 =?utf-8?B?M3Q2ZHI0QnNVaXROTkFtb1lEcDYxME5vMWlFMlhIdkpBK1lFOGtpbWl1aE9y?=
 =?utf-8?B?MXhjditBVWNZZW1EeFI1YVk0UitMWXp4a3RjTnRxRzd6dmp6S3hMSFNVODN6?=
 =?utf-8?B?U1VZWTN4YTZXWFUzWWNpOGp3eitKU0FxdngzOVZmbWdTUWpueUpGcC9MbkNl?=
 =?utf-8?B?T0VqMXY5Z0hzbzFzMGpuSmgxaWhYTi9JbHhHYnFMZXMvc1FlK0F6Y09uUjF1?=
 =?utf-8?B?ZXRnV003VThpUU9PTlpwL1hwb09UakNhYkpTOTRmbmh3TlJTYnErbmFNVGNX?=
 =?utf-8?B?Z1VEVDVhd0VDSGJ0eXdaNG5NZjV3NUdlQ21IdVZIT2RpVXNvLzBWTTRzMGpG?=
 =?utf-8?B?WjRMd3hBSHdTekp0L0U3bnJaWFJPNVhycjNtazFUeVZYbkFsNDB2YkhpNVVL?=
 =?utf-8?B?ZVpKcm9tWWlBYTcycFdzV3oxYkNteEhaaDZ1aWFIN0NxaWZVWUlKNWttY04y?=
 =?utf-8?B?ZXJjTnBZSU5PVDIvZ1Rzb1g1dUFPemZEaitxVXVrZ1FYR2NkbVhpMDZYeFF6?=
 =?utf-8?B?Y1kyWkZKdzRFeVFNdkVZaG1aa1F0WWlPajJsZ0IvWXFXMGlTNmxtTVNyeTB2?=
 =?utf-8?B?T0QxWWJoZWNwVHMwNVdsajhtQnRuY1Z0WStxM0REU1hyK2J3MHRJd2EweVhq?=
 =?utf-8?B?cHJvMkNuVjNpZWZ1NFZWQkZHUFRUUllYbzE5TlV5LzJVc1ZRbHVGZkc0OGVq?=
 =?utf-8?B?U3B4RkxqcmVoV0NTQlMzREkyOVAxQms4TWtLNTZ5cXBUcDZKMGtwc2ZXcEJL?=
 =?utf-8?B?RHJUcHliZjZoemJxcHlHNTBuN2pQNU1Oc1Y4S2EzSG1NMUlOQ3pWcTBkM2xa?=
 =?utf-8?B?MGJ2M1VabkZUekUvbERFYVJSb09PSk56ZHJiTGpjd3h6SnNvOCtGbVRIR3lL?=
 =?utf-8?B?N2VvT2w2dG0ybDRQb2k1NE9Td0NwL0JPa0pUSUZxVFBscSs4V1ptSVlleVYx?=
 =?utf-8?B?Wlh3MGZrWUpXT2ZWYkUyaDZ2UmVZVHNaY1pVOXRaejB2YUlBVU1ZbnluNXY0?=
 =?utf-8?B?cjRrTVF5TGxqenJQditEMWpHS2M2U2xJdEVTcnJTQndvcjJhWUpRVmRxbHBW?=
 =?utf-8?B?bmpZSURRM0dDR3Q2dlVxT0Y3c1cyV1NtcGN1U2lVbk5oN3NvbUFDKzdVZzNL?=
 =?utf-8?B?TmNOTU9pSFdia2ZGSzNJbEJqOTVpVm9aYWNycUlsa3BvQVk2ckp6SysvRVRR?=
 =?utf-8?B?bzI5M0h1ZmR6Qzd1d0VBS3lsRGVKU0Eyd1lRU21RejI4ckxUSWpDUjJjTm1y?=
 =?utf-8?B?cGhlV09OenYvajdUckVIb2ZHMURoSm80SEk0cnhrOHZOSzVNL3ByL21DUTJK?=
 =?utf-8?B?ajV4SitXcnlxV3BXYWE5b1Y2b1YvMHhaa2d4aG9hVGluK0NTRnFGdWJlZHUz?=
 =?utf-8?B?TUpqNGtBK0NwSnJSM3hZUGxqVDVSMTRMeXNobzRta2JSYm5jWlRrVGFIRlcy?=
 =?utf-8?Q?xcHIp6RB9IMG0pPvLribVfjZ4iobg5si?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2Q3enFPeGlwdE1WS010bmhZNUE1QmliRy9OamZzazZHLzNOWFJaWGsySU1U?=
 =?utf-8?B?OS9NckI1Z3JEOE82c0tGNTBrV3JoeHQyK2xMUWZXcXBaNWNJQkpLMTh0TlFw?=
 =?utf-8?B?bzgxZ0tTcStvMWtFaktYTlJoc2o3OHhLbUMvaG10b0xoQkZYbHFJYmlId3NC?=
 =?utf-8?B?RjZZbnRCcnFpWmJ1aGR6QysyNTlqWWgvU1IyUVBRTFdRSFBsMGdoMktMbzE5?=
 =?utf-8?B?QVlLQ2hhdVpZT21NeHNtZjM3ckFFK0JuOGlraWV2dnRRMDNMQzZPRjVFVkNt?=
 =?utf-8?B?NGpLT0xaSG80d041U1lSMFU1RzFsbXFnbHN3Q3cyaUcxSDFSVkphUExPaVhl?=
 =?utf-8?B?WnB1VThTWXN0S1pLOE5mdDdURyszeTNsdS9qbHdwd2NlWitPSlYrYWpiWXdQ?=
 =?utf-8?B?b1N0SElxK2VCa0RUaS9IWW5qNWNVazNMRlc1TVFzTTJuV2x3N1lROUJNZVJO?=
 =?utf-8?B?Q0VZZXIrekZSNUswd1dvNnNOdlBaN2lxQmxDMkJoQjJ0WXh5K2krSldhQW9C?=
 =?utf-8?B?Wk1zSGczUXVSSEYwYjNBUFFsUlZFTEtjNk1va21MM2tydS9ya1F0RjY2VmF6?=
 =?utf-8?B?QjhFTGtha0lUKzdwWXQ4MUFpWHhzYkNhdU1jQmRUZWJac21JejlibXN6ejdx?=
 =?utf-8?B?ZkYzNkdqcWpFckdUN0RxY2d2ZnZBVTMwTWg4Y2JuR2x5L1dON2pPd1lzdUZ3?=
 =?utf-8?B?L2NUNjBmNitXaEJNWUdpTlRqU3lmS0NXSUdCRUMyV1JPSktBa1E5Szd5VHZa?=
 =?utf-8?B?QU56b2dnb3Z0QW5zZmlNYitZQzRWOHhvSHRPTjFmK3NJQk9RZjBsQTFUNTFu?=
 =?utf-8?B?LzBDYVlheXZPbDhMelYvREZLU3FBY0VFZU1VRDRNZTZnMWY1UDkzWFlxOVh0?=
 =?utf-8?B?NWZ2c3hzbEhEUkV0TnpjdHdycWIwRDBzUHVjb250N3BKejNTTTVBemFGcGRo?=
 =?utf-8?B?SmN4U2Q5YlBVZ0hoZ2NKaTFrVnhQeWVOK1h1V0MyS0Z4T1F3MDBJNkZmZVBu?=
 =?utf-8?B?eUhkZm55OS9GRkgwVC9PSk1jVkhuUyttb3o5U21EQlBQNDRITGZwVkZBYjcw?=
 =?utf-8?B?blZuZy9HajRtZlZ3cmhVSFVaaHhNT1E3dlltdlZMTFFHeUY4UmVJODZVb2FQ?=
 =?utf-8?B?SFJqb2JNVTl1eEFscGM2MDlJYUhNdFNSelE5cnRuOGJSSXdUd2NwcVllWEMr?=
 =?utf-8?B?TEpxbWlyOWczZmlYV25hWldHVjhDa2wwSzdDN3UrdExreTBKV25vWERFSkNq?=
 =?utf-8?B?WWRpeVpQWVh4QTJrYnpmZENVeVY2a2RaVzJ0RzJaVGpNQkdDb3laNUVaQWRv?=
 =?utf-8?B?dkJGSSt6YnhYYlhYdTRzd2gyMnB6VmFacmxnQVFzMUw5MjJLRnAvSEhGenFS?=
 =?utf-8?B?Q2xKWThXSHNaWHN6QmREUlVDZFM3V3B6YUdNcjZMd3IyTlAvVU5WelVHWEJS?=
 =?utf-8?B?NVNIdWw4ejRFQnFPSThGS3BmUW9xVGtZOHVudFN4ZzFXaXhIeElvRTc0NTdF?=
 =?utf-8?B?cXNLYUtWa3VlR1NENFdPN3g2a1hRdHkrSitUS2M4V2JZdE94QmlNYkxkWTRV?=
 =?utf-8?B?Rm9mL2VFeENmcitLclZMUjI3R0JMR09CYmtaY0huWW5tbzdHditFbnZ5Mndk?=
 =?utf-8?B?bDBYVzBYa1Z0RnFDZFVnNFo1NHQ4eTFpdHVvTDB4bDhNNHd1Sm8vdWprS0gw?=
 =?utf-8?B?LzRUaWJaY3VkRTlPWWxxMGgycTJET2labkZDaXAyQkZQUFkzcjdkeXIvV2Q0?=
 =?utf-8?B?Rk1LRGxiNTlGSEoxRUQrWTV3QWlMU1ZzbGw3Z0o1VVhWVDQrNmY1ekVraTVE?=
 =?utf-8?B?QUlIQVExRTdqeEQ3Qm8xbU9ZalNTdCtOQ05KaHQ5YXRHZVlxNGRhUlp1bWVB?=
 =?utf-8?B?Q0QwOXdlcXRTa1U5UnhqLzNrM1VZUUJqdnpvZS9UclViRXY1OGoxb3FIRFZw?=
 =?utf-8?B?MGpacjNERWRja01HVWpRYTA0K3VOeVFyV1U4ejlZandJRE9MTjhJc1lZY2xQ?=
 =?utf-8?B?OERBV1Q4RWlqR1p5bW05NGhMcFRMM3RBUUZEY00vaU9JN3FpOWNkYlZlUGlm?=
 =?utf-8?B?YTIwcldEb1d4cDRxNXZJL3JvNGYvTXdkbVNwT2ZjcnpWMEhlUHIrU0ZJemgz?=
 =?utf-8?Q?VjDUEqIwRhLCvexnstuPV4aUk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0da985e-44b5-4259-def8-08de3d8325fe
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:44:22.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihQOsIwj39WgEFDind17hRe+ryr0Z9KXy6LMdi+1t/WJgnK5S+4lPPdf+92xbg4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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



On 17-Dec-25 9:11 PM, Alex Deucher wrote:
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> 
> Handle backdoor firmware loading in smu init.
> 

This is in common code and doesn't look to be universally applicable 
across all SOCs.

Thanks,
Lijo

> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b7dfd98d387d3..6ff593dd163da 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1921,7 +1921,10 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>   		smu->pm_enabled = false;
>   		return 0;
>   	}
> -
> +	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> +		dev_info(adev->dev, "Do minimal SMU init for backdoor loading case\n");
> +		return 0;
> +	}
>   	ret = smu_start_smc_engine(smu);
>   	if (ret) {
>   		dev_err(adev->dev, "SMC engine is not correctly up!\n");

