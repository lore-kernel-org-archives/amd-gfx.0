Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E037CEACFB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 23:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F242210EB36;
	Fri, 14 Nov 2025 23:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkBCXo9Z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA67C10EB36
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 23:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvVIY9sdZIFJOkGWiaTSrBFy0AXeviuOVsIp8VHatSzomRjFdW7qvX4D3NdQ+9mKXtVuLOymU1GYsgaBfAnsxlKuD2TzOa/x2O0INUIrMZv72wRy8sVl0yl5by3INWHNbZOLIsiMNpFcAmOyDL/OW1SJTh5+oGz0T7ZWjLs3znooLtZ/GVe7ciWX66IiSpFFoEa7Z/ZPKh2MQCHn2Jj08y1yOZ2c2EVmo9Qvq/V4v9r22P0tsWxNWgYKKiJby3ZoUyOfrvfLjISlWXIsf5Q3QL8rWQwgf50mif91fRF8exR/sRafR1Mnf1gJ0KF23WWV1x34M0HTl2BMis5qSMLUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeWVPH+Mf6Yg8ZJedoLWw8jhNtgQ0Fc2X0MuI7UVJd8=;
 b=UgrzWpg3PZIAKvzlIu7ghR3HSC5LDYn/b8c9mnrlQuQdr0YAleV9MzjCKuqyMWyNXdT/6xbIpyAzSNJrsCdneuyQUvzIPHCjCbpQ0AstDVT65hzTSnm3ILkuXE9/C67F/cpLS8GPKdbTnMiYPJNvkdS3Dyy4O6WiXBoMUuhnvL1RjqP8pb8UsZI4SZ1rqd/iAW5l7i1K0tcOyC1yL4xkBDt5Tc/GkTowozLjCTYc4jE/Jf4hsUHuE5+Qk8okbZDqjzz7UANIS8Kh6Jr0J3YybgLT0pF9/4dJMHZVenYmYVqrMnXBU2hza4/EbiUc4aIwxsTjI5e5P0jm2k//408uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeWVPH+Mf6Yg8ZJedoLWw8jhNtgQ0Fc2X0MuI7UVJd8=;
 b=mkBCXo9ZPg5h4ANXSA9Fmkq7KpuDgp0f9MRWygAMk852PoNShGdmC5MKYDvF9t8ZkRU/zNyDEHc8cNK65+XSLBuuGh6n3rPdh7yEFz9zTTq6o3A17hezlz6BiRZlziIyEPZfRt+ifxzWSxt3+ZlroLaiANVPkddRlIijc0rt0FQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 23:26:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 23:26:44 +0000
Message-ID: <c87b788f-65a6-468d-b100-2295eb284489@amd.com>
Date: Fri, 14 Nov 2025 18:26:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251113210955.352373-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251113210955.352373-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6690d8a9-4683-422d-a27f-08de23d545c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk5EYjVpY0h3YmhYakx3U2R2S1NpaWxKS0MwMndTV3lGWk1ieWE2bEN0eU1Q?=
 =?utf-8?B?UXVwWGtlS2JEdFlKaDVBYllQSnJBMStDSVB0L2Nzd1dIcDFwcThoRmFrdDlh?=
 =?utf-8?B?OWpxRjFGdStmMXpHbjVzTlA0N0xrQnYzbkdTdFR0TTdST3NDNFQvU0NoSU5V?=
 =?utf-8?B?Y0VvUmdNbU54bHJQVk1lNFdldklnWWwvS09uTXI0dDRUM0l5dXRrRHYxM1ow?=
 =?utf-8?B?OWgrcTlxVkNVWlB2d20vUUIwSlNaRGJobWsrSEczMzRNbDlGbVdOZ3E2SWpN?=
 =?utf-8?B?dW9BQURCYUFUNFlqWmlzWDNhSVZXQzBGVFVaTUJVU0pZN3RPaTRZL20zbTFZ?=
 =?utf-8?B?QXRYYWFONEsydHkrRjVnQ3VrYnBJcjdIZmhhdWVUcmtjdUc2Nzh2dzRMWGUy?=
 =?utf-8?B?cU1iQlJqck1uWFlHMzZpbUpxMmMycWd0UGJEdFQ0d1VHdk41eCtoSGRzSmxS?=
 =?utf-8?B?Lzkrc1BSc3BNNGdkMFJrdlBTcFZYSnlrQitVOVVXTjhqMDZlOEVYa0VqaVdF?=
 =?utf-8?B?SURraTdVU1ZjT21iM2d2V3kwUzVxRmFHamJNaGZ6eW9tcFFaeFN6Vm9SVkla?=
 =?utf-8?B?am4rdm5OSEs0Ky9Kakg4bW44NENINVkxd21TQmVNb2ZiVTBTVCtpaHJBeXE3?=
 =?utf-8?B?TVBZb3dFMDcxUE9jZUNaaFJMQkRxVFdLNWptSFVZTHp2b1dsQ2dIbTNzcUZ5?=
 =?utf-8?B?RFNsUkNWcTYxZGRMZXh1MzZ0dHUyTWxhQjdYWS9RK1R2UG81djhVRjZFOVdh?=
 =?utf-8?B?S1cyQWVodE5lVUUwNnFEQTNvSS9MR1ROR0dhRVhab0hTTTVsQlVVRDY5Njl3?=
 =?utf-8?B?dW1wWmJiYmRubFZScDJVdmZhaGRCTUcyeHp3RVVOTGcyY1ptb1hpRURpcS9T?=
 =?utf-8?B?MnV6VlB0dDEzcXFLeU9kS01hY1k4WjdQS0FGR3piSlQ1b1R6UW5LbHRndW52?=
 =?utf-8?B?QmlOZ3A0azkyN1cweHduM0xHbmphd3I4RXcwQWNuYy9nTUQ1RHFaMHZnVTgr?=
 =?utf-8?B?SnFwTGR6K1FoaVgzY2VlNnM3UnRoNjZiRW5pVlduM054bHBYQVkwS0JCdk1p?=
 =?utf-8?B?S2EvOGIrQ0ZKKzRZQlJBeEx0c3pYei9nVjFsNlVZSTlTcjcvZW13eHo5R0Fj?=
 =?utf-8?B?cStYS1prUWE5WkZwdzFXa1k2SWRLWWJZNHlyNlAxcmN5STZQV0FyZFZNRDlk?=
 =?utf-8?B?ekRLMzc5YnFwc0xxVVYwQXhhMFRLeG9FcnBBaXVhRVFKL1VlYWZ0eUR1VjJ6?=
 =?utf-8?B?VzFhNW00N0lYMzdjSHdpR21lbFhZNFR5Tm11U0RCVWdXaDVNSWQ1cVpQR054?=
 =?utf-8?B?WFI1Vm5IMGlJM2xNY3k2Uk9aZnk1OWZjMFdOSSs5bUsyT3J1Z1YxTnpTcllI?=
 =?utf-8?B?ZVMzdVltOUdKcGRYQXA0UkxQRWZuYUU5Uzl1SDRRZ000c1BiZUR2Q2xveVdJ?=
 =?utf-8?B?aUpaQk8zM1NyUG9DVzlrMXR1ZUVaZWpLVTJWNU5ZWjZXdHlJVCsrYVgvNStt?=
 =?utf-8?B?NGZXRlVIRDJXZG54bWVna3g4MkwvNzRXWjdnSzJxKzh1TWJER1RVdlgvaml0?=
 =?utf-8?B?alkwbVpnSUxUaGljd0VPazl6eHZVUzNLd1l4TEk1a2JvVkdNb0hhNW12Y2pm?=
 =?utf-8?B?MUFFaFNCWUdBSmdVUExLZ2JBYWIwYW80Y2N4S1hVVkNGdHJjOEIxcE1qMEFC?=
 =?utf-8?B?R1V2YzdiYlhCSEhiY2NXMzk1aTlGQ3hHMFZMVnIzbTNSeTJtVTAyL3pDOTVN?=
 =?utf-8?B?WHpIS3lSRnhlVHpWMFlnUitYOGRsT3ppSS90eWF1VG5hc1QwWklPeWQ2Tm1n?=
 =?utf-8?B?ODczR0IxbHErc0xNV2IydGVzZlZ4YmZtdUpYc1VFUlYrY1dsUkRSRGhBQWV1?=
 =?utf-8?B?ZjA2Y2p5bDUvQ2QwMzBTRFNpUjFTMUtUZ2NWK2pwTTNQd00wVU5ob0RlTHQ3?=
 =?utf-8?Q?eqzP7VduzVbBvch6giKY4laRKEKkyC6g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNxRXdHV3k2ZHlhelphYlNFeksvb3F0bm1Hb1BxTXYrdlZzN21jNXFONTZN?=
 =?utf-8?B?M0psMFltMDVuNktVM20yMitiSlNES3VRdWdhYkE3Nm93SndKYlNBUzB5VjNF?=
 =?utf-8?B?Y3BQZFM3T0F2VDhMN0VBM1NJd01xZExMalFtWnN0cFByMngyZFM1QzF3MFox?=
 =?utf-8?B?ZDJhT3RyRGRYSDlNSVE4T1RwSmpCcEE1a0ZGSjdzRWJ4WGRIQUpCa0Z6UUJ6?=
 =?utf-8?B?U0tMRnhMMkNNVTNCaUdaeHJQcllldTI0RDJlNjZ5WmFEVFpxeUpzbngxZHY2?=
 =?utf-8?B?a0xncXZJNWxMVnJPb29jWEw2SDZGQnlySm9wUlA1Y2JHVUtENkFHSjNYTy84?=
 =?utf-8?B?b1hsRWk2ZDRWbDRxK2ZFdlhGbXFhVjJVUncwd2VPelhtbm9PdnRYMXdQd20z?=
 =?utf-8?B?bURRZlhkaThzK2syYnJkb21RS0lBYndBUzQ5Ym9uNzhnTkl5YkJ3eGtrZm8x?=
 =?utf-8?B?RDRhaHdiOXlRYWZvZ3F6ZWNGNjF5MG5ObzJGMUl2MzBrbWRvSXhmL0pLNVJ3?=
 =?utf-8?B?ZDZaek1WQlBwS2lFZHhGdEtWRzZQcG9LZXlFZDdWT2lIUDRmdW5Ick45dWdV?=
 =?utf-8?B?Wk9tWHBHY2l1dkgrV2phR3EvcWxuL2RwQk1TSDI3TEhSWE5ZeWVSWk9Uais2?=
 =?utf-8?B?OEsrUjBPK2lvaTRiRDEyOUErTzBzMktxWGVVTzMrelplbmNIZWZ2QzgyYlA4?=
 =?utf-8?B?QmxhV3NFTDM1c2VFTkUySkRIRVJwcm44WjBnWU5wYTlYK1FZcWQ3YnRMK3Fx?=
 =?utf-8?B?d0RxbnRaLzBJcklPKzk5bkQ4OHdDY0hQRE4wdFcxSVB1bUs2eC9tUklOUGZB?=
 =?utf-8?B?eGlWSlEwM0ZqaGV1OXg2UFZidkpBTXBoU3BzVVFmNFV2NHh5TDBKTlhhLzBu?=
 =?utf-8?B?ellyRU12WDFhYytUU2ZGeUlqdjFjNUJMMDdTeHlBYkN2V2xMT0RnWnFkcEtI?=
 =?utf-8?B?U2xjYmtEM1NtNk1tek52SEZCK1RZMXJWVDRPcFhmbFBETjJEbVduRVYvM25z?=
 =?utf-8?B?NjFuSmZZcHA1MjNCN0pvNEMwZE1FWUt3clhIMHVQQlU3NFJDNE1YNDdGdCt2?=
 =?utf-8?B?NHl0SWk2eXdBUVQranBuRmplcFd6Qk1iZ3NDeVgrL0VFRTR0OFZVTGViRXNy?=
 =?utf-8?B?R01oZ01rYTE5NjFhQTg1L2dtcitCSUFxMXpZNUtCQnhDU0tBdTNxYjBnNjdX?=
 =?utf-8?B?dE1XSyswUmx2TDB5cUNYNDhGQUlLYzA5VVdCbGxRT3V0di9DeUFLUFlVL1RZ?=
 =?utf-8?B?WW5TalU0czk4KzREUERiMzMvRXJ1Q2IyNExadDlEbmROeGJpSjY1RXlZTFhi?=
 =?utf-8?B?T21HaDQ1ZlVxeDRLQ0IwN1FPQkEraU1YcTZwemJUdUZCVS9TTlF4UGZSRWlv?=
 =?utf-8?B?MWhjaDZtbXVUdzVVbXlPYURHUjNLOXRFc2JsUnBtbWdMYjY4U29RNHFCeTE2?=
 =?utf-8?B?WXVVL0JSQmQyQi9SeTBRMWl3NlFsUmRSR2hJbUtZN0c4elRCM09yMkk1a2dV?=
 =?utf-8?B?S3BUQlFWUEsxZ1Z6bzFZcTZETXFpNXJrdGJuTHZZL3FCTEZZNVRrTVRBQm9X?=
 =?utf-8?B?clNTa3lKamlIVzNESHliT2JEclFGSTFXSVREQmlDOFh3ZnR3SDUwVkxXKzRH?=
 =?utf-8?B?S2U1WG0yNWI5N212aVpkbDAvbUphbkxkOHlvZ2F0LzAzQi9wakJsek1ZSWNl?=
 =?utf-8?B?dUI2YnFPRWZ4blBRa2xoTkZGZkFDT1FGdy92NXI5a0QxcTBDbU9jMjNHUHdV?=
 =?utf-8?B?WFc4enlvbGY1Q1JEdHV5alFRdkYxVEZmQk9SU1RjMU5YZDJsMWlIQU1vTjN3?=
 =?utf-8?B?TDcrVyt2MzFTRnUvS0RFQVZUcitRb24vRlRSRnF1VDVRT1FZVEZJYVpKQkJk?=
 =?utf-8?B?c0JNcllrMDNqanErNHhjSmJlZi9JODYrSHlXOFBvd1RUbENXeFl3UTJESVZy?=
 =?utf-8?B?T2w1QktpVTdiL0RVVlJKemF0T1EwUnl0OWRwQTRvdUk1Wm40UGJHV2JmbTNM?=
 =?utf-8?B?MktBTlVDQWpnekRPZU12MmZJdUxFWTlXNitjaGR0RmZna3ZHTUxBTWVOekdX?=
 =?utf-8?B?blgwNkRQSHdBVEJxR2Y4VnhhL21VbjREWUEvMDlLV3VZSS9hWjZoMFU3azVp?=
 =?utf-8?Q?Htx7W67Ba/40vmWtATyVmF3Hf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6690d8a9-4683-422d-a27f-08de23d545c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:26:44.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ctlE/pS/g0wm0wtaRAlY8+j6NcEeyhcORVq4WL5sIpGGR5bAvhpnO5vXDwNef2nD35MkHVTQcVPHXlnFE0tCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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


On 2025-11-13 16:09, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)
>
> When split svm ranges that have been mapped using huge page should use huge
> page size(2MB) to check split range alignment, not prange->granularity that
> means migration granularity.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 521c14c7a789..c60d8134db45 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1146,11 +1146,14 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>   {
>   	struct svm_range *tail = NULL;
>   	int r = svm_range_split(prange, prange->start, new_last, &tail);
> +	bool huge_page_mapping = IS_ALIGNED(prange->start, 512);

Instead of hard-coding 512 here, it would be more future-proof to call 
amdgpu_vm_pt_num_entries(adev, AMDGPU_VM_PDB0). That's currently a 
static function in amdgpu_vm_pt.c. Christian, would you object to making 
that non-static?

Also, to improve the check whether the range can really use huge pages, 
you could add a check that it's size is at least 512 pages.


>   
>   	if (!r) {
>   		list_add(&tail->list, insert_list);
> -		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
> -			list_add(&tail->update_list, remap_list);
> +		if (huge_page_mapping) {
> +			if (!IS_ALIGNED(tail->start, 512))

Make that one condition: if (huge_page_mapping && !IS_ALIGNED...)


> +				list_add(&tail->update_list, remap_list);
> +		}
>   	}
>   	return r;
>   }
> @@ -1162,11 +1165,16 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>   	struct svm_range *head = NULL;
>   	int r = svm_range_split(prange, new_start, prange->last, &head);
>   
> +	bool huge_page_mapping = IS_ALIGNED(prange->start, 512);

Why the blank line before huge_page_mapping? It's part of your variable 
declarations.


> +
>   	if (!r) {
>   		list_add(&head->list, insert_list);
> -		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
> -			list_add(&head->update_list, remap_list);
> +		if (huge_page_mapping) {
> +			if (!IS_ALIGNED(prange->start, 512))

Same as above.

Regards,
   Felix


> +				list_add(&head->update_list, remap_list);
> +		}
>   	}
> +
>   	return r;
>   }
>   
