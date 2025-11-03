Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49CCCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 23:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CA810E4EF;
	Mon,  3 Nov 2025 23:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="abqADSTs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700110E4EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 23:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6DDAf0ZAWwGzziKKpzibEPk+xFcskZLKXLtjI4kc/Vy/AmlLfFvijqHN5ijOcADcYUHht/JDbFP2n5QWNqoTF8Otv6J6Bm1A8ysx/Yet6tRgaDInmrnMR2ziu6AUtiRIf7p91D2sM1mBEP7c03T9k3RL2jDO6m5gS3amTBUzv27s2rHvVvdNT2up2hcxmN/0X+wRDAQEFYMt56plxEH7dgK9J+JYGou3WqwySstwWbx1SzyUDdzjdUCqP7aL0v18Y4rZt6T3KW6qSu7yJ+FF05VWxJ0bv57VsPW5365yaqnr5n+KJnVic+YiQqUa1uwJDTMWq2ibtgDKcPijGzzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWtADcjoEr++ZdJvxMx6ea+VByqHuhbN5GvL+Ri3jGI=;
 b=i/yziNLVTZgo0RBumo+E99Vvv6ymkGjfsEL3mS4tzqDxO+yKxrvwkAV/Icf5FCtr6aFn82Rvx3xV5A/hJj42s1XC2pjc/0TODufejstcvUYlJRJ2BmT3nk9eIOKw1nfT6zJVFp12eBSIwecBTu7CsPZkb/wuL3jaJVxGNIvlG1mGv/ipZJb0lWY4LuA0nttR/cNnElptsExOPjjHTdhC9m1typ/sDFP8DQBTBPH+bUFpdaFln83WRv+fx/PuipjqfacB7mT1qWokNyDVMB9Tc2dLOOS1Y0jdQjyg4wYyTvIq1Dt1ixRLtjRF5qH/rLb73pmiEUvOap2dkJb4z4zCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWtADcjoEr++ZdJvxMx6ea+VByqHuhbN5GvL+Ri3jGI=;
 b=abqADSTsiIJ++sNeBDTDMz+3CAg+cGHMyvLtNkSg2+dQbNrr7/DDgkhTIXhAmODrnSBakdd3RSt4gSCm3CXlZyCMYwEMkaH7R4NsZkK4C7GDpv5S2FuoFvDiG2ltLRRLcvDZkYp1E3OgxiGsNhr7Nb7e+qrrnLFqKVp8AdzFHQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 23:25:52 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 23:25:51 +0000
Content-Type: multipart/alternative;
 boundary="------------VeiAWP0saL07bYZaK0KTR5qE"
Message-ID: <d6a6ae67-6b7b-4cb0-83f2-d1f2624c2f4d@amd.com>
Date: Mon, 3 Nov 2025 17:25:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
X-ClientProxiedBy: DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29)
 To DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ee3d9a-5c67-4cbd-c3ef-08de1b3053ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZKcTI2MFpEcCtqc0dGckRGcHA0V2pBeXhvdlJaa3FHOXpjelpDN3ZXRC95?=
 =?utf-8?B?MEhKM3poeXl2Z3UvWExPalNrSlRPMm0rcllHcjNCdGV5bHo2ZGRpUVl4KzVP?=
 =?utf-8?B?a095emh0UDVNMDA2NCtrbnBHSXh0Q0FRa0RkR1ZEWi9pSXpPUzhCZEtFK2hi?=
 =?utf-8?B?ZWl1RnNIeWtHV1dFZ1ZrQTZkcmJRcHJqMmlRaEJ3RzgxZFNzVzZwSldCVDZz?=
 =?utf-8?B?Z0ZXbkhIcnN2TnhSWHlUaTlQVER6U3lIQUlSdzNwTEkrejJ4T3Exd05weEda?=
 =?utf-8?B?R0U5WnVCMTlDUVl0VUxCa1hUZXZqcExjVmRkTldOUVBwOFcvZGpMTlpwSmZN?=
 =?utf-8?B?blQ5VFlBaEpFamYzbTRiUE1WVnlkMHgrNnNHZnBqV0JVREs4K09MZVQrMFRW?=
 =?utf-8?B?YWdQUnpDNGp6UTBDUWlIOFRXVkU0YTZpVHhwWG81K3Q5N052Qk9WSkhFa254?=
 =?utf-8?B?ZjYxUnBPaWw2T0RoV3lPWGVCQlZzcWdOSjdyLzBjbXl2dldHN3R3T1ZFdkxW?=
 =?utf-8?B?bVZobDZvdXYvMzZGbk11dG1wVTBMRTRMZVlTTVJPRGY2SDRxMmltV04xU05a?=
 =?utf-8?B?MEdTOEhBYVMwUEQ3RW8vUFUwTmpmUXI0U002N3B5OXB0dGc3N0NOeVV5NGNu?=
 =?utf-8?B?ZXVzczJvRTU3Tk9SZnRkMm9JZWV2QWdGK0tJditacmw4azYyOWFqWEFWK0tS?=
 =?utf-8?B?YTMvM0JvNVF1WGlTdy9KVGtBbzJFYkgzYW5kR1pROVo0OExaRU1vL0tWbW1R?=
 =?utf-8?B?NWJ4c1RkcU9URU5TaEdDOVFVdysxa3BJbW1vdWlsMGJ5ZUFSSXN1eUNSVi9w?=
 =?utf-8?B?RnZlTk5kV25UNUNXbzVQUklZTUpLREhPMkJsbUNycTFzNGdteXVXdmZmczZy?=
 =?utf-8?B?UFpWVGx2Qlh0SWVubVVITlVLbzVOa3lYSGhsdXkyQmtHVlh6L05xYmp5VjFY?=
 =?utf-8?B?Wmo3SFgrRVN2L0FpWldXRUlZbUFmc0xhS3VtNDNTUXJtNUNDWHFyc0R5QXRE?=
 =?utf-8?B?ZWtqUHJCdmcrczJ6RWwvSEZ5YWRaWXJXYU14NW9UdTNjMnNpbk1uMGJzREFh?=
 =?utf-8?B?aGgwdWczdTlyWXd4VzlkS085cm4yL0xxZzRRNGsraHFKUjdVWHlSZytlWlZE?=
 =?utf-8?B?WjM5aTZjazNiQVJVbUlJN05PV3BOeVhRbHljdVFjQVl2SFVzYzBZaWJPR0dm?=
 =?utf-8?B?aFczRUdpOWtFNFNMdnpTZXRRZXJPaVpmWVpoS1U3RFdKa1N5WldnNlNoSjVt?=
 =?utf-8?B?WDBLelhHTUF5U2ExQWNHSTN3UkwvNURPZzJDV1Y5MlFBc1pSejR0UTJlNjYw?=
 =?utf-8?B?ckpiQkdDcnBzZ1FrT1hsaTlMaFZuQ01xazlLb011THpUN1hjWmdQaFJLZWpI?=
 =?utf-8?B?TWlOZHlIbDlqdnROdWlnekN1ZWZxcWw2RUtCVytMWGUvYmQyZWp4bExGcG5i?=
 =?utf-8?B?d0hxanp6amxPU2ZXNldSQWg0VS8raVlacW1mTnhDc21yanJ4WW1ucCt3Smxt?=
 =?utf-8?B?QVc4Z1hNTVgwT3Q4ZmV2OVFKRS83bmlqQVNBOUZaeWdxMTJCOVE3YlZheU11?=
 =?utf-8?B?SC9PUm1RMGVpVzMwRzk5R1lMUmxldWJSakZicDNQU1F2R1NkM0hsU2RZV2VD?=
 =?utf-8?B?eWMyK2l0WVRnb045QlFiSjN6angwK3ZOMmE0WnpEYWg1YkFpZFAwbFBlUCtp?=
 =?utf-8?B?dnhnclV6cXdKejlnMVhhdCt4bXVBNmdaRlQweGx2VW9BemYvY0tNclUxOGh4?=
 =?utf-8?B?ZDFvZHdTWXd6bWtoQ0RnQ2RrU3FOb1V5MlViSDA2Zjc5VTZud2JVV09vR3Nu?=
 =?utf-8?B?MVduTXpsZ1c0N2p4eTAvSEZBME1xNnExc3RDMEQ4ZG55VEIyN3lYWlI3UlZE?=
 =?utf-8?B?VEczSDg2KzA5UHFhV0dHck5wSmxBMW9haCtsZWF3amlpS2tmazdDMTNUSGs4?=
 =?utf-8?Q?OsQegRXkD711pZqh1+0boAxwRwr7gZUX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlLV2Y5TDRlRFFhN2NYZ0hna3Q5d2lMelhoYThFdVBQR2NhV0RaaW1idy92?=
 =?utf-8?B?aDdibzd4QzFZTGlMbU0rVU5zT1RhcSs0d2FoYTliUDh6T0Z4WUxBNW00S0d5?=
 =?utf-8?B?T21oOHZnTis3Unh5Vi81bzR5OGJJRXU2T2RPbEZqNHF1Wk5Ea0Q5YU1Rb0Mx?=
 =?utf-8?B?bHppQTFPVWRsdVNSa1ZOTkM3T3pVbjR4Q0F2UENQQnhmU2xyKys5Z1pvM0py?=
 =?utf-8?B?bDdPYytSUUY3c3RMMUFtUVRHYm9zQUdZV0IvTjZObVBUb1p4VS9FUXNuRGlv?=
 =?utf-8?B?NTVLcTJrcTgzQmJpRG9nRVlFZFB6VDFRYm1MZGJ3cVpUaWtGRkFSdXZGbENW?=
 =?utf-8?B?TnRHOXI4SmFKdkFtVWZMQ1FCQ0ZoNiszWmRvTFB3dFhJWlNzZzdTdmt1Y3o3?=
 =?utf-8?B?czA4RC9CODRzdGkxcHJSMFNjVzVhcjJLLzVyRjlrQ05tS3JJRklqL0V2VlA2?=
 =?utf-8?B?UUtpem9KbTE3a24vQnl4U3V5aitldnR5cFhZRHpUV3ppMUdmbnVwbDJiRGJM?=
 =?utf-8?B?cXJheGZTSGR0d1hJUDVKclBuNHJmZHE5czlvVFNWMTJJZVJGWk9VcUtKdTcz?=
 =?utf-8?B?MlVYaGRwMDVHbDZTdFU0V2NNR2Z6RmZBbER0QmJTWEhUODBxZ2J3OXZPQis3?=
 =?utf-8?B?MjFISjM2bFFubFNsOFlrR1F5WTJ1V1RsWmpYYkU5OC9XN2dzWHl1VVJRdGpW?=
 =?utf-8?B?cnl5OUV5R0JmcEhSZnVTTTJnQUZwN0owVXNPMVZiRmFQWEFOdy9vMzlkWnFP?=
 =?utf-8?B?eDhRTlUrTzNDblV2SlNvdVhMREFXaDF6eG1KK0VDaWFtc0psQm10S0Z6N28v?=
 =?utf-8?B?M08xZktTR2lZVHk0TzduNTNoZW9TTW9Vd2hvMEpFQmIzclVhc1E3Q2RJZk85?=
 =?utf-8?B?dzJ6aElTc2VZdUFvRkxPQ05sVmR6Q3pSY0pIT0JZcUx2MlhvV3UyWnJTK011?=
 =?utf-8?B?bXBhaDNjWmxUVkNFelhDOVBSejlRVkhjQjV0Q2plNHhsWkJOM0FaS25GZWlW?=
 =?utf-8?B?Y01vRFhzSE13K092RmNHMk9ncHFaaUxIbGtPb1NsYlhQTjE1dGdEZDlUNyth?=
 =?utf-8?B?dGtIU3liUy9sN3F0WGZKTTI2N3V1RXZleWlNeEtjbmRUQXoySzg0RExLcmg3?=
 =?utf-8?B?Wk1JUGJHc1FHTmNKK0cvVlJod2kzWGVEVlNmMWtVNmhZWXlBVDVkN1dlODcw?=
 =?utf-8?B?d255d1FDYTQvREtSM0FIZ0xzZ0JrWFRaQ3hEU2xKU0tIUk1VVXhJTDZqTkZt?=
 =?utf-8?B?NmNsU0R1Q2xCc0R4cy9VWktxRjdNV1VXN2YzbEVhazErdGc2NjVkRFVDTmtq?=
 =?utf-8?B?RjRIN3pNaUNxV0RIZFpaNytCSXdLWUVBOS9wVkR3d2t2SnRKbTJGVVZYOUZh?=
 =?utf-8?B?cWtpZ2l2cHZjVEhuSnVzYzJyVU1ZSjArZUNuWDZjRm1URnJJU1pLZ1NEUC9D?=
 =?utf-8?B?WFBqT05rMzhQY3p5ZXl0eXNPMmxIZ0t0Z2poTDJSd1dPdGVBeW9UdmxyNmpD?=
 =?utf-8?B?dk94eG4xSXRCVEZYMHhLSDJrZkxjZ2lVekRGR0luVWxuaDk4VEZmeVJHcThz?=
 =?utf-8?B?SkZSNTFieUxNa3VaZzRjS2NFTzdMRDBVdDZXSEg5aEVlSFpjSGF3Y0Y1bGw0?=
 =?utf-8?B?MU1xUXF4N3h2eURtQndydzJuVktQeFd0YWppNURObkp1ZHFLL1I0anJ5UVVQ?=
 =?utf-8?B?QnorK0o0RXRPUnFJb1A4V2MycDJjNjVpbVVDdGZMRDNXUGtiZlJWWW5NU0l2?=
 =?utf-8?B?WnM0N2RJZWVJOGFmZjJjWkFYSnVUNlVoV1llckFOcFF3Z044ZjVZUXhRRDBw?=
 =?utf-8?B?bXJrbTR4ckdOUmJRdkc1c2lQZENpRUtJV291NC9laFhieVYyOVh0MmhGSnR6?=
 =?utf-8?B?dE5PNVd3OUgvMHlGUTAzNi9Ja0NyaVZOREk1ck9UTnJJQ3RTZm45ZHozMnRU?=
 =?utf-8?B?TE9sZERBYnhkb3FIR2pjaDJST1JkMXVvOWpqU3AvenFlL25IcFh2LytIdzZr?=
 =?utf-8?B?QjYxZ3l4eVlIbGNSQlAwdm80cWtwVTZDREhBUy90ZmVUMFZpR0FEMUd2cDdy?=
 =?utf-8?B?YVhKZTNZZGxzeXhBWXpITisxd2Y4OWxkMWJrcmtkS1RCU0xGVVVzK0I4alA5?=
 =?utf-8?Q?QyxQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ee3d9a-5c67-4cbd-c3ef-08de1b3053ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:25:51.5034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FN6PIrFkJ7mGKLhuFeCjXVtVCT1UZRLQTazBq4RaY4pgfrIdWLPErKaZ7wDAjJE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

--------------VeiAWP0saL07bYZaK0KTR5qE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/3/2025 4:21 PM, Harish Kasiviswanathan wrote:
> Fix the following corner case:-
>   Consider a 2M huge page SVM allocation, followed by prefetch call for
> the first 4K page. The whole range is initially mapped with single PTE.
> After the prefetch, this range gets split to first page + rest of the
> pages. Currently, the first page mapping is not updated on MI300A (APU)
> since page hasn't migrated. However, after range split PTE mapping it not
> valid.
>
> Fix this by forcing page table update for the whole range when prefetch
> is called.  Calling prefetch on APU doesn't improve performance. If all
> it deteriotes. However, functionality has to be supported.
>
> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
> VRAM
>
> v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU
>
> Suggested-by: Philip Yang<Philip.Yang@amd.com>
> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index c30dfb8ec236..26eac89c90a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   	int gpuidx;
>   
>   	for (i = 0; i < nattr; i++) {
> +		if (!p->xnack_enabled)
> +			*update_mapping = true;

If you want always set update_mapping, set it outside loop, not need set 
it during each attribution check.

And I think the discussion is setting update_mapping when there is split 
for prange. If change existing prange attributions without split, not 
need update vm for 
KFD_IOCTL_SVM_ATTR_PREFERRED_LOC/KFD_IOCTL_SVM_ATTR_PREFETCH_LOC.

Regards

Xiaogang

> +
>   		switch (attrs[i].type) {
>   		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>   			prange->preferred_loc = attrs[i].value;
> @@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
> -			if (!p->xnack_enabled)
> -				*update_mapping = true;
>   
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
--------------VeiAWP0saL07bYZaK0KTR5qE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/3/2025 4:21 PM, Harish
      Kasiviswanathan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com">
      <pre wrap="" class="moz-quote-pre">Fix the following corner case:-
 Consider a 2M huge page SVM allocation, followed by prefetch call for
the first 4K page. The whole range is initially mapped with single PTE.
After the prefetch, this range gets split to first page + rest of the
pages. Currently, the first page mapping is not updated on MI300A (APU)
since page hasn't migrated. However, after range split PTE mapping it not
valid.

Fix this by forcing page table update for the whole range when prefetch
is called.  Calling prefetch on APU doesn't improve performance. If all
it deteriotes. However, functionality has to be supported.

v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
VRAM

v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU

Suggested-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c30dfb8ec236..26eac89c90a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 	int gpuidx;
 
 	for (i = 0; i &lt; nattr; i++) {
+		if (!p-&gt;xnack_enabled)
+			*update_mapping = true;</pre>
    </blockquote>
    <p>If you want always set&nbsp;<span style="white-space: pre-wrap">update_mapping, set it outside loop, not need set it during each attribution check.</span></p>
    <p>And I think the discussion is setting update_mapping when there
      is split for prange. If change existing prange attributions
      without split, not need update vm for&nbsp;&nbsp;<span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_PREFERRED_LOC/KFD_IOCTL_SVM_ATTR_PREFETCH_LOC.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			prange-&gt;preferred_loc = attrs[i].value;
@@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
-			if (!p-&gt;xnack_enabled)
-				*update_mapping = true;
 
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
</pre>
    </blockquote>
  </body>
</html>

--------------VeiAWP0saL07bYZaK0KTR5qE--
