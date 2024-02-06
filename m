Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5ABC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB33112E51;
	Tue,  6 Feb 2024 21:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cL7v38oF";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B9C112E51
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH6DCQDTvEOO3uQ6k40CFkc/6lBdYHH1Z/FekNmucCD8EozmJi5drhjMlmgscmlsAFMqHjyB836ygIK7Zu+ccis0YhRAbq+3mhybzf1G88GBpDLA/8NcB6v3jVHR5TzQO+gXKk1QTVz0SQxAqZGULYosj3KK+OuuFuH1NwRtcsDI+gzHZ5G+dSh99E3QvaOSl+ADo5jO1U98R3JatVExhcvgxBjEbdhu7ZPxSRG1rGmchm70nf7/PkBbg5wvmXDO0UUH8fLElAUoVLNZ3l2KhpJ9R83NXHU69FEbYWXfCuQ0M3n7hEpDI4IBkav6Yb6qL9kaQlGcMbA9Pt7xKLCPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG5bg19IC0mYxpkn9IPz0J8rNstz8+LfJCki5XsD0J0=;
 b=XrBjrtcKHxyT6ie2Em3OjbEIhqV9kPKFHTKDzfYVLmwfrvJxHF/q3NL8ztxCMyiaA4jPVqd1EANfOIwamlA7ihIMebJNr6cvsFWS3aXx4teqbtHZiPe/4wDHqSvF8TCX5NvVqx/V5qobXdd6UMBt9hu3OcuBaWAi23Zc//KSUK5BdBLIMw5Glid6PGuhSi9DNW1iLuWjxOZ9PExiHEAYgMoyRzYOuuKJ6Pik/1mxXs1Oqz75kMzdZe3rsdhxJqulmhjUpcz5JAwGRbZo8rKbIhU3mXWgg5FmJNaPhfW7FQCQnmn2ldPT7L7MSnnycMg8G0xqz+oR6PebA77Uu4ifxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG5bg19IC0mYxpkn9IPz0J8rNstz8+LfJCki5XsD0J0=;
 b=cL7v38oFjC9OGdLQlGNgnoZVMZivE0zvd6NKeR5au28kX2OLN7r+rbQfDVfAwnCR2ipf45fusZ6BceVChI0maA1DG66zrVavaN+GXNVQA7J8QO8vYXeRZRpLzqarcOJL5JIkmhxlAf0Pgg698IYMix3q39J0qpUxmUps65+zsiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 21:15:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 21:15:14 +0000
Message-ID: <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
Date: Tue, 6 Feb 2024 16:15:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD topology
Content-Language: en-US
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
References: <20240206205524.2697359-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240206205524.2697359-1-Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: d70df5b6-746e-4816-5421-08dc2758b62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67eozdcjGmBE5TRLwqCzs4KKlsHBTN/PA9HKWjtrl8ZtC3ciUWQ1BxJ6LjEMRTEb4g1izW+cXPXt4NIRiG1Tsv9c0DLUaBtQZAqkQNxIahSHXQXizqOH6yZW2zINnC+OqhWH/0JYDfpxefvyxs3xa+QRwZ1C+Y+I3nwcTbqjfPSk8J8BtFcXfq6VjydJ0h52z2qvAlo8Cl/Nzt9Si/FIdIzDVB0lroyHwR9m0eOfY0gdququvrPftEMTqZ7CjBEX8VEPWBKLCpfvz1OXLBuwUDCmss/GK8VfZplxUMA8dJaOwn5Ix2Tlj+Whp+U33yZkegiTFyXbun1n4FLc9HWjCsoDt3+pu+nhSQnAikmyLDjkJM6WN3WTV3wD8qgVOVm3saoj1sSFoWIFgjK37Nz/GAO3EEb23ugH5K75pqhr4ZOOmY9RFzvg3SnkqND/GhnBYoUDDaOWBqh2Pmm/4byWyuDphS8y7OQGt9TC0rWunx3nOFVUlocbA1BnsGSt2dFqc79PjIynVd1cfW1iEyd2HNhB8q27KIQlgvv/pnTDGWvz3Js5l2x8DuSD7ZILncFSnRqmaEJEtra5IubRHmZvvmT8IpizCINQIUCbzuFEZGIORe75py0eh4nBLqbvvDjUj3NvECGZ1YbAWstOUYv3aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(6636002)(41300700001)(66946007)(38100700002)(316002)(5660300002)(66476007)(8936002)(8676002)(66556008)(6506007)(110136005)(2906002)(44832011)(36916002)(53546011)(6486002)(31696002)(6512007)(478600001)(83380400001)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hCQjFueW1zamE3bFFsVnJqWXZwd0sxOVdnTjI1K3c2UG84NzV4dHJtbnpy?=
 =?utf-8?B?aFJCUFR3N2RyUHNHYjJoZlhFVExVV2VZVGNVVkxzSnFDSU9tcnNuUHhucW9E?=
 =?utf-8?B?bUJNYzFNR0xCbWNRWjlmaFkvLy9vUU1IdlFGeHZ0czNIRVlNcUVsSFFkWEdj?=
 =?utf-8?B?Q1JjZmJNOTFwQU9QZFRmV1B0eWlzT1E4MGZvTVFpd0F0c0RzMk5aTEVZeW9n?=
 =?utf-8?B?c0d5K1hrRWFMWHBpWHZ6WlQvaGVPN3hCbFdhNGtGSVRqRTJ6d2VwUGVRU0pX?=
 =?utf-8?B?aWxmUkhrR2pqUGZRSGhHRUlHUi9YZmJJYTdKMXlrQ0ZaZ2RTb20wcmhwV1J1?=
 =?utf-8?B?eFg2YmVxeGpEK3g5WG9oZlNMR1pOcVNiVGpRNFRNZFIya0RuaDhxZTJicVVs?=
 =?utf-8?B?MnZES2ttSXdVRnJVeEF2bFg2M0dDem1UMlZhT3ZRdzFhekloWXhOMnk1VWQ4?=
 =?utf-8?B?dW1LVWxnSmNrbTF3NnhRRnlKSlJxMU5CY1pkZFgrUnE0Q3phcXhGa3k1cWls?=
 =?utf-8?B?N2xicEs0dy82RVlraXdrbDRqWDBvVGM5RHpYM3A4N0RVbkVYSDY1MG81bzJZ?=
 =?utf-8?B?ZXN3aUdOVi9IdzJtTHFYM1VVdndSMFZSRzNpUDdpK1dhRVVKdjZSZ3EyNHNx?=
 =?utf-8?B?NFBhejNYS1pNK3FqbHpLVXBObW5ZakduSnVvaUpaMi9UMzNTdnpBZmNkWkZy?=
 =?utf-8?B?SWJYZllweDFFck5YTStHUzZ5NW05M212QnlGbW5CeDlrU0FIcXp1WUpxcnlM?=
 =?utf-8?B?VERFaVQ1Unhsb2FDc2YzaHpkbDBKekR1eTYwdGtTWjVnZ1ppd1QwZ0FtSDIz?=
 =?utf-8?B?VUlURE01c3M5d3ZzdlA3RXU3eFZpejQ3dTd0d1JQaXNCa3E4RGlYbXpwemQz?=
 =?utf-8?B?RWtEUXV3Zk43cllaVWNpeFoyeTBxc3V6SVFLc1M1ZWxtWGtkRnhySC8rR3E4?=
 =?utf-8?B?RzQ0MVJzYnUvZjEzbkJQQ0V6bjdzaDlld2cyYitmamx1Z1BDU0JPb2NYbHdL?=
 =?utf-8?B?T21UV2REV00rRWFVT1Qrd2tQRGxZM01RNmFpbkx0dHFRcVhIaExabnlJL1JU?=
 =?utf-8?B?a1FYOU0vL1ZGZEsvVExENUFOUHNuVWlNQ2x0M2R0ZW13SXllbk5jZ1Q2Y3Ny?=
 =?utf-8?B?a25EMnNrZDE4SjE0ZDJ2VlFPRnU5cEo5Um5HcnVYMTJqWm9LWXJiZDE5cDEw?=
 =?utf-8?B?Q2xUSDFvaUlWbkZCekpicjZWVHFjeVdjM2RLdjdvQm1SV3NzcEFGMC93UDgv?=
 =?utf-8?B?bEowTEd4TGhwRklQRU9XV2hSYVFVblhjZGQ4RUw5WUhLNWRzQlFHVnRJTjBE?=
 =?utf-8?B?WDBJOE5vUnpYYkhGdTdVYnJsY1NSc1lIbGV0ZnBoZ3QwN2ZhU0VmVjI1L1VS?=
 =?utf-8?B?Zm1wbnIzZ0FnNFl4aldhdDFZTS85RGVuWjN6WVNkWFUwdm95K1lZdGcwaHh3?=
 =?utf-8?B?aHlGRHdRdENVRUV4dU1hMlRybEUzMUZkVjhNZEx2ZHREa1c4Y1NUalkzZ2Nh?=
 =?utf-8?B?KzlBeHc5R1h0b2dYbEt5bkh1dTFFeWdOVnNPU0VHSXdaNmtxQ3RGTUVrVTVD?=
 =?utf-8?B?eXFYMWFIT2pjcWpOM1NmUWk1SEpMOHEyQ3FmMUs3TWw4dlBPWmxuZllSZXYv?=
 =?utf-8?B?QWp0dm84ZTlERDM0aGhkbndWRTRxUUxSdy9QZzBvdER3Szd1SjdTbEdSdW5q?=
 =?utf-8?B?SlZhVlo1cXRma05mU3hMdi93c2hxY2NraEE5bTB0WGp1QWJMekM4RG1Jd0JL?=
 =?utf-8?B?amFjenE2eUtWWGtCaEUzanNuU21iTjNKUmFUNmdKZmJ5WTdGankvUGhxckVj?=
 =?utf-8?B?TmRvWUhhN2RsY0J1elZPSUMybitCQW04QVh5OTBLTk9ZOS8xeG1YRjI3ZDJj?=
 =?utf-8?B?Z2dGQUFRQ0FTbXJCRVptbWJHTStvYUFaM0RIVTVwTjNoQUlWUFNHNWZGUWVj?=
 =?utf-8?B?QjluT2ZZRmtoWWpKdmxSZ1lubWl2akplaTRRWWhobFkrMGdZMFZsOFMxV0lB?=
 =?utf-8?B?U0xlaFpZWEVKRkJycHlwcE54dThHTll5Ky9VQzYrL1VRT2tiRFVpNnVteWRm?=
 =?utf-8?B?K2JveXFLWE1HdlE2dlQzSnBUeEpSdzlFZlYrOVpVUlJaNEFSTy96d1dzUU9L?=
 =?utf-8?Q?HC/tmwDnREkvIduA8wP3+oPMB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70df5b6-746e-4816-5421-08dc2758b62b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:15:14.8346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJT4bR3ZIQOehXOU1cyShF8bTJQiQtUq7u+hsXXB2lfVkUa8sostfOyepgdqiV9bgKZob54YAu5smj+l+LYQ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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


On 2024-02-06 15:55, Joseph Greathouse wrote:
> The current kfd_gpu_cache_info structure is only partially
> filled in for some architectures. This means that for devices
> where we do not fill in some fields, we can returned
> uninitialized values through  the KFD topology.
> Zero out the kfd_gpu_cache_info before asking the remaining
> fields to be filled in by lower-level functions.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

This fixes your previous patch "drm/amdkfd: Add cache line sizes to KFD 
topology". Alex, I think the previous patch hasn't gone upstream yet. Do 
you want a Fixes: tag or is is possible to squash this with Joe's 
previous patch before upstreaming?

One nit-pick below.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3df2a8ad86fb..67c1e7f84750 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1707,6 +1707,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   
>   	gpu_processor_id = dev->node_props.simd_id_base;
>   
> +	memset(cache_info, 0, sizeof(struct kfd_gpu_cache_info) * KFD_MAX_CACHE_TYPES);

Just use sizeof(cache_info). No need to calculate the size of the array 
and risk getting it wrong.

Regards,
   Felix


>   	pcache_info = cache_info;
>   	num_of_cache_types = kfd_get_gpu_cache_info(kdev, &pcache_info);
>   	if (!num_of_cache_types) {
