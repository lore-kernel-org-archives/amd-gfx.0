Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93719D3E79C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 07:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB2A10E071;
	Thu, 11 Dec 2025 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vz4xBBQu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7588010E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/8Z6KALYZ4GnTwK3vBV6Ds4ejv3MN1tAcsKBAmmAt6w3gzDW3NdsmELgdipsXx/oD5AErLH7UvNXHnA0+OD2lcR7P0xxHKc+Ik3ynVMsN4FbmakHuWXb7yUSGrIyj3n/7VhSmOhun8B+vkMz2kzIxhGL93DE7kRoEbGRn55T/djfZqcD+YmeZkj0BDU+bmhVAUlDu/6XX+LT/X47M1gcvkADqMGp7PSkALio4i2kFwgHMArTT6aeiPD9H8sUZRiSw2c57E5ShLiAdcf1vxnexqsNnU8HvaxHk3XeQ+jFn0IB8/KM6f9pNc5EJDGVVGhdgVSQhbKNjsNRQt0uTCyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3EUL1l24YU8myg64MrLjhYUOtMM9P+Aa/MRuoFAQmY=;
 b=LkotsLsSP0WPlhvhdIOeSSo5WNDLakm50beBTUwuWkyHwU/m1OFdFrMekgA7QZvHr739kmkxxHrlPN/uUNjF8hZ/OxlCXwCdfqEsrWxEb6S/1ZYSlbJLhcyKAiHEOKkYl45JojpN/CXPrl1rVKiGjDy82NqUU+6k0Ha4dWQGMCZZWfZn1gOuveXlSjbcF3MW2GYou5EtFIepybc/D6hOLTIlZMuEsvpFD2wbGPPVTFVUNYkjdwq7yMPqUNu2lbWhtAK9ty2uHbMDsRiuSVw8ynsz3Jlpk7e1oMavhlZR69aFHWPQBmJSOLk3SSs3L6VtvNGsGpQqFs5FRc6LlXahUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3EUL1l24YU8myg64MrLjhYUOtMM9P+Aa/MRuoFAQmY=;
 b=vz4xBBQuPM8a08uN+i0G4BMdSJHUklfZeBgwfQekupUbkyHu5OLO0bWBRoDJqcfHhHM/bMaG9rrTrTMxQdK0eTOvwWy0PJJKmItDmooDfW3zP3Nup8msTP6CGu5RLRbAqWl2u4HWavVhg/6bSBQA4SxcMbXirhvYJaS+0Aq9FOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:51:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:51:05 +0000
Message-ID: <c888bc0c-73ac-4cad-8d22-cf32422cad79@amd.com>
Date: Thu, 11 Dec 2025 13:21:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com,
 Kenneth Feng <kenneth.feng@amd.com>
References: <20251211051635.652412-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251211051635.652412-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a62013-06a5-4bb3-cca0-08de388a09cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anpSTW5JSzIrczEweUJlKzQxU2pvRyt5czRINU9OMWNPcmp6T3JYRFdWalU4?=
 =?utf-8?B?YVVxVWorQWtTclFtUUpCOG51Uy9COWswYVVHeUFaTkhrRHhnN1ZQc2Fwd1hF?=
 =?utf-8?B?ckhFMHdZOW54aFFGK3QvbXBIRlNHMnVnMTVKSlIzV0x5VitsSzU0NVZDZW5K?=
 =?utf-8?B?TnNKSmgzZlZKNlV0N05mWEVTOFFZYzhQVnFrMFBWTWlwelVtRHNKcXFwOG1p?=
 =?utf-8?B?d2hvWUJEblFOYVUxeUxTVG9Gd2R6VkEwTm5VUnFQU0MzQWRJVDBjbEl2WUsy?=
 =?utf-8?B?bWw3Ym9CV0E1eWFzSEhEcUVSbHhvVUtsanpiSk14T0RnV3VTVXg3MjZKMmZU?=
 =?utf-8?B?THBETnlXZFVrYUZtMnF6VStGMHhaby8xZXdUbWJpQXU2NVdJa01wZnZpZWE5?=
 =?utf-8?B?eTg5M21JZ0Z2cmIrTXk5NGtESEZSa2U3Z1ZSMmhiQXpvR0V5QmY2SHJQeTI0?=
 =?utf-8?B?a1MyUE1iVHdMbmt1bHZMb3FTUmxoZTB2dkxiSmQ3akFUaFg1VS9nZEFENG9i?=
 =?utf-8?B?VWFPS2p6M2F3dWdzTlRoYWlISXZPd1hBUzQzaUFxd2huampDMWlhUjdoV0R3?=
 =?utf-8?B?Y2xZYlN0QUhldDZjOXd3U29rRUpjNS9HaTZ5cDlIcGVKcC93LzR3c3FGdzQ0?=
 =?utf-8?B?Mmk3ZjhRVUlRSVBWREtwd2FQVzFDQVU1RFM1MVcvVllMQllMWnZGenBoR1Rv?=
 =?utf-8?B?TnNEN2dCajZjUERrUWFKQUw3U0FYVUxWNldreVRTcUY2eGo0WFdLSThYRW02?=
 =?utf-8?B?UTA4djdxWmxjWWtrRVRJRVlUVEtLNVAyb25EZjI0WXNsZDlYYm9BVy9hN2Vl?=
 =?utf-8?B?Wmg4Rk5vcmFJOXRJdERjS2U4Qld3dFQwZERqODIxSG9wVW5WNC9Qcnl5bmUz?=
 =?utf-8?B?b1JiNE15Qy93aHExK3Y2SkZPc29TN2g5TzFZNzZzekhxOEhOSHdjeVZSSTJn?=
 =?utf-8?B?Y3dCQ24rWVM1QXh2OW9CT0wzN3g5YkZaNlVKemRSS241bzFTclJJNXJNNWRy?=
 =?utf-8?B?RS80ZXpZRWUrU3pCNStiM1I2MjlzcEczbUczc3FPV1oyVjExYmtTVFBSNnpx?=
 =?utf-8?B?dmt0MURCcWZvRWlva3pqUnJpa3BNSXRyVmF4Wjc0SVZKNjRvc0d1eldBeStC?=
 =?utf-8?B?QzMyZXVVaU1KZ0xvQ29CSHMzb3lpc1c1WjFYMk0rSTFRRWtQS2FCWFNkR2Qx?=
 =?utf-8?B?M1RNWlVJeEhuQVFXMmJzWVBwZ2VOazRoQ0xLVWFmNk9lcXY5MHRUTHdmamZ4?=
 =?utf-8?B?SktxWVkzZE5TTVI3S2lOWnFmTy9iK0NDeTFDUm92U0VFbEdLRjJNN2FGdFB6?=
 =?utf-8?B?WS9xREtOd1M4Y0xncFU4R1RzVDlpbHNhZnZsMzgrQWFmVGpwM1M4Y1dlY095?=
 =?utf-8?B?aUU4cjhJOWoxeHJCNnJTQ2gvUno0cDE3WWtoVjh6VFViMURpRnFaN3AvZlBN?=
 =?utf-8?B?Q29VaTZkc1FGL0dOc0NVV0hlU29Ca3E1OWRvdFR0MThmYnhwV084QjZJbHEw?=
 =?utf-8?B?enBLVHdtTVovMUJwdS9PTEpWUW1KUWlIb0R4ZXBuRzZEbTU3SnhhbUJzSmw0?=
 =?utf-8?B?OVI1SDREaEc2WjFTazkvN2dJaVJhMWRXNnVJdEFBTjUvMTVGNzV5OGNtWWRB?=
 =?utf-8?B?NG8rNkVSNkUyazRQNmNuMDVETzRmWkgvUUd4RFJSclQ1UFpvOGxmNllXSUV4?=
 =?utf-8?B?dk94aWt0TGZNak9YdktYSGc1VDN2ek0zUnhpalhBeFliK2N1bnEwZlZnS2F4?=
 =?utf-8?B?eFFVQ1JDbmlmT3hvdTdKUlRnNTdoci9hRnA2czgvbXBTQ09YSWQzbXhRQUNq?=
 =?utf-8?B?VkFyejB3QTI4MnFqcHhIN2gza3BKakNTenBLTVVxNGNCUE4yMnRpbTExcG5L?=
 =?utf-8?B?YmJtekprbmlheUU5T0F5UTlpTEExZkdBNFpFQ0hTTTRhcWJNS3RuT1NFay9l?=
 =?utf-8?Q?JpY8OSy3yDtHNSk+vwy+bH6YMslR17Ts?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVRIak9ISkZSMXJWQW4xR1JVYWVQVytHMHU2OURyZjlMbEtzSkdTelNCQi9j?=
 =?utf-8?B?NFRaZjVub2dlQ1NmSXdXSWdGWnoyYXdJbUJUTFN4aG9EK05DZGk0YTRlYTM4?=
 =?utf-8?B?K29INWxZTWVnRDBjczA3WTBQZjNQeGN0VWNndFJxVWtkazAwMkltSDY2VHY4?=
 =?utf-8?B?UUlxK1BIbFVWNkcwOFJ6c1BPeFFaMXJINjdJdTFDMG5ENXFONHJMM04vNkE0?=
 =?utf-8?B?cWN4ZU1jejdxZ2w2TXdUN0ZYWFN2ZERubURzTWhHU1ZyZGtUVUY5d3YrenF3?=
 =?utf-8?B?bjM3NFVVbXRyUUhLMGJta2JZZDA1WnMzWm5QdmpYS294Y0VueHJHdjc4WC84?=
 =?utf-8?B?ME1INXJIdWRuY0p6ZHdyK255VWNueG9jRmdyNm84bFFUM1cxL0k5QXNjV29Q?=
 =?utf-8?B?V0phNExpM28xUmNlazZ1RmV4VkpMd2VwZE43RzhHWm9UNHdpMUVhNVV4OUlu?=
 =?utf-8?B?OXRxWmtlTUpVN2FaOVdDRjRKSkhRa2h0SmFxbmJZaEdYUGhUV3NLTlRBM2pp?=
 =?utf-8?B?b1VIb3dqNExYK241RWFoMjlkUUppR0l5YnFkUTdYTFpBMXY1TEhXTVdsb2gv?=
 =?utf-8?B?Y1RiZ3NwSGkyQUxiM0liMmlOWEZEdU1mSVNCNlAwNkZhK3RmZ1dLWm9wZHls?=
 =?utf-8?B?SDN4K29BMDExcUI1V2szNlZSTEVLYTFkSWdtREVUZThKRHppVUFwRmNKblZV?=
 =?utf-8?B?Rnhpa2pSOTgxanVMMFU5N29rUDdQeUZqeWxCNXQ2NlhvdGlLWEF3VGkxdER5?=
 =?utf-8?B?NmtYL3dpQVlKbXc5VGYydndlQmdOTFNrTUtlQVNJOXpwQWgzMGtTRVpwa1Vn?=
 =?utf-8?B?R0Z4QWN6K3NaM3Nncjg1bXZOVURSVCtXNlg1YzhMdDdrYUJHbzQyZkpQSmV1?=
 =?utf-8?B?WXVwMk43dHdpbzhFOTJMcVNMdTlsOUNBS2ZGS3I3RXJSczNEZVVKLzd5YWtl?=
 =?utf-8?B?Um9wVEVuS1llaU44ZGpHRjdyWS9OQ0VDVWZFV0t1bmtCT2VyT0JsSXJoTTUz?=
 =?utf-8?B?YWpMd2ZZM3hTc2srU1RPU2JSUTd4TGNJVlora1V1eFpKUGFKbmV3UnRreEFr?=
 =?utf-8?B?SGd3QmNoUVFHR2p0TjhLK3lNVWJPUHN4UDh5aTdkdTI4cEFlYmdyMXExTTBq?=
 =?utf-8?B?bm00N2w3OG9mNlFNMUxRejhVWlpwWm5kS3dGQVJQbzFXM3hyQmJSUXl4clpz?=
 =?utf-8?B?bkd4QWl4NUJ5R0l5bmNrQzg0bXlUSVVMUGhqb1ZYU1FibWh5NWxxd0g5eWg3?=
 =?utf-8?B?NVZFODFrcTVNcWxFdXUzNkF6NGRNMzluQ2J2bU1kSytWTnA5SU05UjhYcXZ6?=
 =?utf-8?B?NldRZzk2UW9lUTFlTk5XdTAvdWFzc2JlWERSZzBMTjltYXZOWXAzbUJOUEtR?=
 =?utf-8?B?eTNMOUlVRkhRTDBSTytOTDVhTUpLcGJtcnBqci9QMVozSmVDcC92aFhhallG?=
 =?utf-8?B?YU84VkdPbEROeHFVZFRyRGNaYWtLLy95ZnY0cWJvZ2YzSkxrNE81ZkE5ZHpM?=
 =?utf-8?B?TEtGak8wc1k2WnZqbEhWZHNZS2NRQjNsZDd0V1hGTi9DbU13aWd4WXpiak5J?=
 =?utf-8?B?ZDBOdmsyZHlucXlsWDF6SUk0aXl6RitVeVhHYzdURUtRODR4SlZXMHVYZVhC?=
 =?utf-8?B?Wkx0dTlEamVTZXp1QThqdS93TDNYV0NZckhDYzI4MDllZU4rbjVlZ05EN3pF?=
 =?utf-8?B?VHVadWtPV2VVMFJMeVcybUJOSzZraFVFbnhpMjBxSm1LdGZ5cVFyaHVUNk9j?=
 =?utf-8?B?VWltaHUwenJzQnBvQmlvTk9CLzk4bEVlbmtnSm5jQkN0T1BvUFJuQ1crS1p1?=
 =?utf-8?B?UTJQRnYyUHZPangrS3FsWGtlSHVNcmNpL2tzNmVCNE14RjJ6WUVXTmxVVzFs?=
 =?utf-8?B?VlJ3TVh1SytZUlZmdzgzSjF3ZiszMSsyY0kwMGtoNHg2UWtnZXMvd29PQVdK?=
 =?utf-8?B?c0xvQ3I5RDdEVnB1WDlpRXpTb3RMdThUOUUvWDY4K1VmNjBmajd3eWJUNWgw?=
 =?utf-8?B?cXVSZXFsQ2xQeE1vWU5PR2FJdGd1YVN2WXR1L0VXRlZiVVpUMGhtUGlYS0lP?=
 =?utf-8?B?ZTlLVjg0UTYzVTVMdUNCUnpGNU5OSVVSVWJ0UUh4blN1VmZGZWZvTUJZajQz?=
 =?utf-8?Q?os3EdRiZFjjT13d9FLLp8yYT6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a62013-06a5-4bb3-cca0-08de388a09cc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:51:05.7615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zca1GWhT9zv58DEvsbU4DFxi5UwHHGxqwPd0WKk9aO5cbqXbAmiALtCrye7/0JeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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



On 12/11/2025 10:46 AM, Yang Wang wrote:
> fix wrong pcie dpm parameter on navi10
> 
> Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 882830770b79..0c26fe6fb949 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
>   									pptable->PcieLaneCount[i] > pcie_width_cap ?
>   									pcie_width_cap : pptable->PcieLaneCount[i];
>   			smu_pcie_arg = i << 16;
> -			smu_pcie_arg |= pcie_gen_cap << 8;
> -			smu_pcie_arg |= pcie_width_cap;
> +			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
> +			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
>   			ret = smu_cmn_send_smc_msg_with_param(smu,
>   							SMU_MSG_OverridePcieParameters,
>   							smu_pcie_arg,

