Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58ECCCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 10:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7113010E053;
	Tue, 14 Oct 2025 10:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9JAPCi3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653F210E201
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 10:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4aP4852z95fq/hayAXbHMzYm2Kn8pbgtc9yhVGk36ZTGOUBbFmZuXs8QnjoEdl9PkgMSnM6m8NKQjnKWhXVK+3q4gmEO2cxxycIeT0L/4RxhtvDky74orYLKD/1EUd46YLHEmxy7+nbYs+n9Qchx6XVN5pTyolX4EPELwfIKsLMWz6Mwc0IbXLZYSrULMy2fYgq1Hx9nfqMmnwikWFkzbn66qFbq1IYz8KL6sg+lw0jTvn55WUckDxpNCA1CXL4sIxjpQ9SjVdyGnGtnp4nxnJKgcpp1ninuZPA4EQ7Kr/keGQHzacUVP86V3uXW0otlp5kRMEIgS/+b1XvNxFJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nle9ZxLD8KzikwlqW5gyJwv5yR4V2JtRXNifFnkxMVU=;
 b=Lp5N8zCA9HKZ1dA40xuFBHuGoCg9be0sKGIKXcTHd6IyicqIRXFBKnv9XTZ9aYStjjh+4Ib1ijwgs/yRRzEt2kOVCntQ3Z7MvLHBqwWpCPORULan2vhpGT1YFFBOkw/LIP75Szq594i8KfcoL5XR1pKHsbmLgbnQ0Da25WXqjqZ6SxM9n8VjmqdZC7I2y4aIA+h/Ki+HwPyNY2cUdezjaQ1ARiMUWQXZM8elEW9MF0AmFMz4j0tR0FbWlv4iH8UTHkEc4EeSV5aSAUjP32ZTk7TtU3OVknUijYIOGPNqfwGaSa9oMI77SWvm//IwonoX7kVUGnLWqWCJE9q6jJGTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nle9ZxLD8KzikwlqW5gyJwv5yR4V2JtRXNifFnkxMVU=;
 b=Y9JAPCi3wgA6d+M6SfeetJJfwic4NuJVijTUjjSXXovLA1g4MJLTs63eqv6p+YaVLCaG/biQE4vgCjv5OcssCs8uIA/bNRMCYQFb68qVzreQo1Kcs+IJqObACEoquzzZ2sDYdN1Jq/y00hXNK/8x6xPSMw49EqwRMByzFFbIKGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 10:50:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:50:01 +0000
Message-ID: <e8950119-5f43-48cb-b912-5f9dd205aec0@amd.com>
Date: Tue, 14 Oct 2025 16:19:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: HaiJun.Chang@amd.com
References: <20251014093711.434989-1-Victor.Zhao@amd.com>
 <20251014093711.434989-2-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251014093711.434989-2-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b869972-414e-4f6b-ac25-08de0b0f6c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWE0UWpIRnZZbUU4Z05wdTJ4Vys3Vk1Ma1I5OUJQZjhqdjRsaWE3Ym5palQ0?=
 =?utf-8?B?cUZuSTRSOVBTeE5Zem1RYzQ2NjZNSFV2ZWxHKzF2TURiNlNybjh3RmlubVB6?=
 =?utf-8?B?SnN3bnpBZzQxaVVVTmlFQVZUcWUvUCtMS3VGMHBEVEhiYTMwZ0QzQ28yQURs?=
 =?utf-8?B?eDJodGdwS1NMbks4R21ZeFEwSXFwY2xzT3lXSk92SzAwL3VORHBxQ2J4S2lu?=
 =?utf-8?B?WWI4bkdGRGM1M1gyMnJINk5wWE5OZzkwaVJIMEQyRGN0Y2Irb0hYeTk0dTJx?=
 =?utf-8?B?Ui9keXRWVWJjMnF0NUU3bGFIdDE5VzhRcEc2c0hKYWo3MDNoSENENVk4UDQ4?=
 =?utf-8?B?blBUcWZJOG5QS09TSFFQVER1UUxpSURmOTh4aFYyeGtUanNQa1YwRWlDOTFm?=
 =?utf-8?B?Tnd1T3RkakEwWHBaL25KekhqZVRZS05LNjZJV2NTUStKRmh6N0tEWkpjbHYx?=
 =?utf-8?B?MWJweGRXaW1ZcUg5V1hYRVJ2alBGSzZmcStkN1cwK0lHd2hBbkFSZlZXRHkw?=
 =?utf-8?B?eVB1M1o2QVhTVmV0bDAzaG9MZWdTdjJuVjlseXFpU2UwaHArRy9nV3lPVDRa?=
 =?utf-8?B?Y1VEZTkycWhOU05ObWRsb2pmZlIvZU9qTkRpdHF0ZEVsN1Rsck1iRFl4QWVM?=
 =?utf-8?B?WndWNXM1VjlXTjQzcWI3T2JKclI3UnBSSnd5TGxrRjJRRzdSWXBobGdMR29U?=
 =?utf-8?B?ck9Ha0NqZFduUW1CVURBeXdiVmk3Y0JmbG1Ealp6V2NxTzBsYm8vUnZTYVVB?=
 =?utf-8?B?cHgrV2ZtajFrTzFCbXg0NkFtZ1dRZFRnWnZhUFRzNGE1cVZLY3RnTmxDR01P?=
 =?utf-8?B?K0NYUEJFS1hFcElJeHdXN240WlEyTEdxVlphdGlsam9UWVNROFBGbXFLRFlQ?=
 =?utf-8?B?NjV0TjVpYzM1OFdpcWVWLy9mUk8rejM2VUw1TmR5V3o3NlRJLzlldmdZVmVL?=
 =?utf-8?B?Nit3KzFQRUkwRWVPVDZMaW9vZ2R2ODArY1o5b0FqaUlkWlFMbXRwS2licHJL?=
 =?utf-8?B?cy9HN0Y0K0xBTHd2RHRzUUJsWVJSSlhjUk5ldkZJNUx6cDJGN2lRMXh2ZFVN?=
 =?utf-8?B?MTlGMjJ0U3BYZHllMWJGcVgwNXZ3NisvZGxtRjdBaHFESFJ6RHMwZ1VvZTZv?=
 =?utf-8?B?cGhiUHk5dDkza3lsa1g3ei8wMlc5aG9FM2JrWE92T0JTa09Jc3hNMktIdHE4?=
 =?utf-8?B?dmR2QlRhUXBUTjdLcUEwMllhVlNsSk8reHlVa0lXM0pyaTNtRk11ZUxWTFdz?=
 =?utf-8?B?Z240QjVxV0tIbFZKODV5QWkySG11ZXl6em5WcUFZcEpveUZlSlF2Q25ESnVl?=
 =?utf-8?B?Nk12T1VGNXYybE9BaGdHb2ZvRy9iZFlCTVp1M2tKeHhHV1p1V0ZabUJwOXgr?=
 =?utf-8?B?WFdTaUdzZEc5cFZzS1doRTNNY3NoKzBVKzZGWWNlRHJFUTVTaktHYWo4YnBv?=
 =?utf-8?B?VVB5UGRldWpGdUZQUDN3UkJrWldJZmQ2dmljazVZeVA1c0p2dzlLUWFlcnNm?=
 =?utf-8?B?UldVdDlZaEhZMElqOGRtT1RaUDRBODd5NGZCTExMTGRrSEhVNGZ5MUdpOER4?=
 =?utf-8?B?cTcyTkVZd2I4ZjdhbEQ3ZEtHTUVwbUdSUTFSNkZiMExMcVhpdnN3NUhmQk41?=
 =?utf-8?B?aVUwNlBLWW5MTHYrSTI0OVI0dWlhc1lpbW4zRThxUkVYOS9PbXhHajBIUWVZ?=
 =?utf-8?B?UzI5NjMrdUdPcFZscnFBa2FxZlo4QWFBTDdSWTVRejNka1EwTEdTQmdHNDhV?=
 =?utf-8?B?d0xGdEZya3IrYzIxMVZBNlRTTlNEbGVJUGNlRnFzb1hrRVBxbGN0TVY4Q0lN?=
 =?utf-8?B?OGtvbGNreDdydE5NT1hvdk43TUdva1E1QmZUWWZyQkN4NWg4UXBYSU1uWkxs?=
 =?utf-8?B?Vkp4R01od1YrdW9NbFA5cm5Jb0RBWmQvS0xtRm9yb2RweUZSMHRHWm1RNUhH?=
 =?utf-8?Q?zXjRLbqcAwcZE5E+Eq+LeJcOTGDug2IH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1Y2RjFtU0FDenFEQTVJUVJpMTN4eC9HTE1kK3pNL1l3amdCU1JYRW9KUVRW?=
 =?utf-8?B?dENyb0MzSnpDNHkwSEJpaFJrRmU0eHhDblZZMStBdUpNZW4rQnVkaEhOT0xq?=
 =?utf-8?B?QXR1L2NFVk1CSHcvUVlQdVZZR0dVUFEyKyttVXZkaXBSSmNWcFFZTHpqWGVl?=
 =?utf-8?B?YkVVRHZLKzBiR0RPQTZtVm82TmkyYktTSVFYWm9uVUlUTkNQY3lPZU1vRjhS?=
 =?utf-8?B?MndXOWl2cW5uNEFsSitIc21uY3VEMlRmdTdLT0xEajVoVkFkb1ZyV3RFd0ts?=
 =?utf-8?B?TDdmQmFkZEpaaFdjNGRSTzU4cE5kaFpoMEhHTVZjNmIwUGhCS0l4bE85aHNh?=
 =?utf-8?B?U0xiL3U0emdSaVRhTDIwTDBlWWJOVXA3OWZEWi85RVVrVU9SbmFyRTJhMk5k?=
 =?utf-8?B?eXhsUjY1Q25Eb3VSM3Jtazd6L1BHYjhLMHpaS3h1OHRZdXFWVDVTc0N1eElF?=
 =?utf-8?B?M2xZeFB0SzRoT2VaOEl4K2luRllHemxlcC9aVTllQTM1YnpZZi93eFlNb2Y1?=
 =?utf-8?B?WjVheUwxdDBTeTlpcDdldFhLRVZqU290eGdubkI1Vjlnb2RDRDc0clVkRG1o?=
 =?utf-8?B?TnlPeWdCREpZWXV6cFhaLzR2WkNMb1pNVjdJM1B6OEZHRDFwWkVCNEphZ0xH?=
 =?utf-8?B?eGVKYVF2b0d0azRUckFoV1BMaXpxMmJUK05ZZDlVMm14WFhEY2k3RGlQdGpL?=
 =?utf-8?B?Qm9ETXluUTBrblZQMmpMLzUxUWxYWDNqYkxwcFR1czNzQzM4d0FqZC96eHJG?=
 =?utf-8?B?bmVZME9la2UwOXZPWDVBRzdQdnBBTEZVVjlHNndvQWhSbTlsaEloa1JlTFhs?=
 =?utf-8?B?UlhaMXZ3MWtJRlVMNXpXOFg3aDRQd05jYkU0YXhyT2lyRU94VUVjRVlVNXJ2?=
 =?utf-8?B?cXcwRVN4UEg5enFmU283SElXR1NLZTlYdGVUUFV1bUJzbFN1OXF1U1VkdytC?=
 =?utf-8?B?WWFoQjNiZTArZUozVTdMUHVINnRUNE1XK1RySTNIeEtRcUFJdXN0LzJQN3Rp?=
 =?utf-8?B?aGJ0YlBmTjZOdWhZWlp6VGNEYWxWNUhrczB3cTZXQWpJbU5kWk1BNnJVWVVn?=
 =?utf-8?B?UUdCOEc5dmdBTVNyTkpSQ1ZGODZwME1wcWRFNHpDcXl2UE12c2NMUXRFRjMy?=
 =?utf-8?B?VkVLcU12TjVKdDYrcWw4VUpEaEN5OS91eVpXNDRNbE55ZTN3Qm5hZEJUeHZT?=
 =?utf-8?B?M1RwaUhPRkJGQU9rR3Vid1FUZHFpd2hmRjUweTNLcEF5blEwK0FxeHNsWEVD?=
 =?utf-8?B?bldac2tObGRzUmd2TTdnd2RQbk5URU5aaWc5SXk5cy9IWUpqY3JCbFU2Tlk3?=
 =?utf-8?B?cG1tbmJKU1UvUG51VisyTDRXZjZORTJ5VG5NL1U2S1BUeWttMCtCMm93cld0?=
 =?utf-8?B?d3lhUGZEVnlHandSVTkydE1kVTdLaEVQbWRCYWdJN2ZwRG1HYTZFZXpVYWFV?=
 =?utf-8?B?eDJ0a0dXL2k3eVk0b2FxVnlucVVKUmFvRnJuczNPTFlnb2g0WFRaS3V1OGxE?=
 =?utf-8?B?OTV1SnRyZnFWZnd0Y2VuMVZIMEhZTXZlVStxSTB2Zk0rdEs0bUxUd1IybU4y?=
 =?utf-8?B?YjNFckdsclRjVTV6TmNlemFWdEZOVVgrdm03azJmMnpqUFRSWHBWNkpXbGlO?=
 =?utf-8?B?ckkzU0hqNExkdGx3SWJmWFhJbTZjTmNhU0NKbXB2eld0THF3cW94R0RKTGFm?=
 =?utf-8?B?bGFtbXBqTmdxNUdpZ215MG53MllCT0F4VXUyMnc4TTFYSjJIUHFDRS9zSnZK?=
 =?utf-8?B?M2NJMXFQYSt4ZlUwWi92RUdWV2J5NXo3K0dEV1puc0lrL0xLSGtFOS9Lc1dw?=
 =?utf-8?B?Ry9qR21PK3hzZU5YdVI5T2p0dW9ySjZVa2JTdFpXSWNZcVZiSW1SYUlSNEFi?=
 =?utf-8?B?ZFp4UGtGMEd4Y3pqWmNXY1UwV29tZFA1Sk9sSlJLZmxGaG9pUG9PcG5lRmsz?=
 =?utf-8?B?ektNL3RLOCtvSnptT1JqMURvc0tkOUhtU1dzcXJqazg5N2tjekRSRzl0ZUlQ?=
 =?utf-8?B?Y1R0QjV5K3h4d2VlVmQ2NE1ZVWk3WFhqazUvSW9mNHZEMlpiRmxsbnFGZFFh?=
 =?utf-8?B?WU8za29HTVhNWlJTYWNaVnNEMzY2alRMOTZZcWJmTmxRRDhndE9zZmVRNEhR?=
 =?utf-8?Q?uzcJ6U5R+BO6Kxp/jbBo0lWVX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b869972-414e-4f6b-ac25-08de0b0f6c9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:50:01.2179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyRCayNY/mg0YKNYYu1beIbvL6B+Wxdzv3I6tFgttxwBMhmgNdf25Dt19aDL1r16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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



On 10/14/2025 3:07 PM, Victor Zhao wrote:
> Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for
> hdp flush. This register need to be write from CPU for nbif to aware,
> otherwise it will not work.
> 
> Implement amdgpu_kiq_hdp_flush and use kiq to do gpu hdp flush during
> sriov runtime.
> 
> v2:
> - fallback to amdgpu_asic_flush_hdp when amdgpu_kiq_hdp_flush failed
> - add function amdgpu_mes_hdp_flush
> 
> v3:
> - changed returned error
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 71 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 12 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
>   5 files changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a899fb4de29..65cc6f776536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -7279,10 +7279,17 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>   	if (adev->gmc.xgmi.connected_to_cpu)
>   		return;
>   
> -	if (ring && ring->funcs->emit_hdp_flush)
> +	if (ring && ring->funcs->emit_hdp_flush) {
>   		amdgpu_ring_emit_hdp_flush(ring);
> -	else
> -		amdgpu_asic_flush_hdp(adev, ring);
> +		return;
> +	}
> +
> +	if (!ring && amdgpu_sriov_runtime(adev)) {
> +		if (!amdgpu_kiq_hdp_flush(adev))
> +			return;
> +	}
> +
> +	amdgpu_asic_flush_hdp(adev, ring);
>   }
>   
>   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 7f02e36ccc1e..3d24f9cd750a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -33,6 +33,7 @@
>   #include "amdgpu_reset.h"
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_xgmi.h"
> +#include "amdgpu_mes.h"
>   #include "nvd.h"
>   
>   /* delay 0.1 second to enable gfx off feature */
> @@ -1194,6 +1195,75 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>   	dev_err(adev->dev, "failed to write reg:%x\n", reg);
>   }
>   
> +int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
> +{
> +	signed long r, cnt = 0;
> +	unsigned long flags;
> +	uint32_t seq;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_ring *ring = &kiq->ring;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
> +		return amdgpu_mes_hdp_flush(adev);
> +
> +	if (!ring->funcs->emit_hdp_flush) {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	r = amdgpu_ring_alloc(ring, 32);
> +	if (r)
> +		goto failed_unlock;
> +
> +	amdgpu_ring_emit_hdp_flush(ring);
> +	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +	if (r)
> +		goto failed_undo;
> +
> +	amdgpu_ring_commit(ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +	/* don't wait anymore for gpu reset case because this way may
> +	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
> +	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
> +	 * never return if we keep waiting in virt_kiq_rreg, which cause
> +	 * gpu_recover() hang there.
> +	 *
> +	 * also don't wait anymore for IRQ context
> +	 * */
> +	if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
> +		goto failed_kiq_hdp_flush;
> +
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +		if (amdgpu_in_reset(adev))
> +			goto failed_kiq_hdp_flush;
> +
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY) {
> +		dev_err(adev->dev, "failed to flush HDP via KIQ timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +
> +failed_undo:
> +	amdgpu_ring_undo(ring);
> +failed_unlock:
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +failed_kiq_hdp_flush:
> +	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
> +	return r < 0 ? r : -EIO;
> +}
> +
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_num_kcq == -1) {
> @@ -2484,3 +2554,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_compute_sched_mask_fops);
>   #endif
>   }
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index fb5f7a0ee029..efd61a1ccc66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry);
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
> +int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 8d03e8c9cc6d..be62681b0c3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -523,6 +523,18 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
> +{
> +	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +
> +	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
> +	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
> +	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
> +					     ref_and_mask, ref_and_mask);
> +}
> +
>   int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 6b506fc72f58..3a51ace2fa14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -427,6 +427,7 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
>   int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   				  uint32_t reg0, uint32_t reg1,
>   				  uint32_t ref, uint32_t mask);
> +int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
>   int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,

