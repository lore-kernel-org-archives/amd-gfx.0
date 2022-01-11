Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463A3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 17:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74A510E25E;
	Tue, 11 Jan 2022 17:59:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6C710E173
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 17:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES07FnHjTn2U3gkaY8AioaWd5IaeuPfxXZ+OILVB/JsbXeto0FBpkmjvEyYbskcdAmvgJ7OH+5T0rD7MM9ri74UtmpkY0Cm0Z6GCIhwpqw6weLhgjgJurbJQ6fV7tRMYncZni2ppXE305Jl4iE3DDyw5DqKseF2qsey3KNKeH+/UTcJ9zXu5jzgno2FeC3eJpWTjngmoB3q90e749GIAisHlr4dPmZ//fYR24qjYoGmDxDmH5CarNzKddQtgyOnQ1TsRMHMEZVSB4v/1t/yS0LVVK933VWx7RDrxaFlUGhwDZV9A3wjl3nAgDR25pFNjpQjOx3j0j552TIBXKW4gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhRHO3EWdNpvMtVAnZ57ov5pd/m16iDJUN9nA+0Esmw=;
 b=noOaGWDZtgL3EEeHp4PpEZml9LXcZ84MBwTIebtd5gh1DBTqrygkb626TNlczTkZgIKspmh/Gst/+5BrWMn6Q8qWNsWQvl9hBMhYu4rKIrqy0a3c6QtfLPyEvLP68//qZfxW2BvGy7em3vKL3qg3W5L9lzU2sbDIMsIfuuBKX2vFQ1mTSpjFjBaNwNUDVXpnZa4vsf3kCxfLsmieY2UzAEA7O2dQPjP9MmLiE9QrjOttZwDuRM+8TEAH3jAHyPuxyPXX3052UDWfyV3+xUVCGGo0ju0t2nS5QyaYp3w+x7E+326dI6nXnY1wqAvGs2WE1mWoer7Kr/m6zT4itSkuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhRHO3EWdNpvMtVAnZ57ov5pd/m16iDJUN9nA+0Esmw=;
 b=O7eYJO+U7BjEf0yVPR3w8GuIYCnUE7Uo9dfeRiOFK07tkEvjzm0teH0PyQejXNafiDezItEEmhfP7pa8h7jzSM4dX+zRzIq6vcMBdeqSi7ovmuVuP8gsx2mRBWRBD07xAKqgI1Ck9ZRUagb04EfSuF3sV+ct4bBvkbuaYHFYlAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 17:59:23 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::894a:fe8e:9985:3b96]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::894a:fe8e:9985:3b96%2]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 17:59:23 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix ASIC name typos
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220111173105.699766-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4cd83c3e-512b-c776-33f1-4631141cde2a@amd.com>
Date: Tue, 11 Jan 2022 12:59:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220111173105.699766-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c01f27-2ea5-47ca-c0fa-08d9d52c1933
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55050555D9F8CBCB829DE6AC92519@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cuJQkYA+w6UOvhnPG2YiyCXmYtgGts9UD0JPv6ojoihOVy+lIm/I8caIVDFkYyAfpzusJwlxsPkttXPfBtgiyVJliZlYjw853ihDH/ow14HCfA1UinF8RNGhmntSRWwpBFidsC9lkxc0hPnheQoe3PrIlFbhwayAwjVEnq789xzaqXtrys/cEK8bymFobX3/ERG6IAJU1k2rus2Zh/guAVeU4giFm5CsdLqyvPiILkmIN5GH87Hr19A27LGhCFprPpbbHjh9MeItMLnkrYTw1mL9SgqKi6tIAQV4Jn17X8pdH/upwDsFRHaYD9W684brynMfkhwl3vmyJ3+2gf9BEEi03vzn4gAtnJxuCr/5gfuAMibV5Vln3sjB0sWEyMsRrk1KR1IN43In4tJnEgPp632GzG4du01T6FT9i81/8Hr1XXSkuNcNvNrLRZyjSoXt/h19XEfh+4VpimmnGrQy88NfQ9X1YnGgg2Yznx8LhcnR365BYDY8kK/EHT4Q6tr70hzP7eyTqJxDQ3aDPnxVIbCYc7HksUTsmtjg0e35zX2zkNnH9LIoaapIBmbji9Ws7VnDCBksZnuG+TiHYn1jJhY+fepd6cdGbc5OykXepvK3vDgxfSuMp/hgHk/XU5pzcQREaNyHgygEQzpCG5NXICweUtb5EPp9hk1EXmuhkLRoYi+LLkIGmo8h3fxi+wS291R7kvlMVBTKkLSMik9/OMZgO2/7O/DAkMlCe+S0Laedmo7EEDVa3fv5LV+Bup0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(2616005)(26005)(86362001)(6512007)(508600001)(6506007)(8936002)(44832011)(31696002)(66946007)(66556008)(5660300002)(8676002)(316002)(83380400001)(31686004)(36756003)(66476007)(6486002)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUFmcHlPZkNDSVdZbkhielF4U1FMdElFVFYrbVp5TU51N2p6eUxMelYrZ3FB?=
 =?utf-8?B?R09OMTBxQ1p4cVBzT1RaNWxqVnhUVTNBWkUrQkFQM0Nkb3h1L1pRUm1zQ1Yy?=
 =?utf-8?B?WDJldS9CVU95emRydE9JRmg0ai85ZFcwS2YxQzRYYmErQkV5YjE0NW5oZzZn?=
 =?utf-8?B?YVJDVGVYbEwrTzN0aTZDQmQzNjdGeEJLcUhWZ0NWUS9SN2V2UGZabk00WG5W?=
 =?utf-8?B?YVVoNWVqL0pHa0pOQ09HcDQ5blE1dUZ0Mlp1Q01zTGhMNHNEOGNNamFGRjFy?=
 =?utf-8?B?dUV6bEdxc0JnM2FYLzVDdGFPTE4rUlV0WXVKdk5MUm9CTEQ4OEpSVXF3dnRD?=
 =?utf-8?B?enZ2WmlEdnZ2N0Ywc09iN3ZUZFFiNlVPWGFPZEZpdzBwUlJKanA4SHFBTytB?=
 =?utf-8?B?cld0Q3QxTmxnc2dGcHIzb0VDLzFQNm5XUWxFUFEvL3d2UDVBWXhBWWtmalF3?=
 =?utf-8?B?OGJmalFoSDZuNHhza1ZFV1o0K3ppZUdvOUFpTVZVUUFWL2dlQlpiV0g3ck5s?=
 =?utf-8?B?MVdxUXJnMjQxN0JOM1drcTlWa1E1U2ZWTDAxNmtuRnRUQXB6eU4rc0MvTWtt?=
 =?utf-8?B?TCt2OG9lU3VpWk9TYnRUblJ3ZVZPL3pDMkEzV3phQnJucjB2Qlk2eC9wM05h?=
 =?utf-8?B?Ti9kaVVJYzVKRm56TDgrMW5DZjZrU01nZkpPTXQ1RE5IMk0xVERLS3lhQi9S?=
 =?utf-8?B?ckRvYW0ydDNCU0Nkako2SkpDYmJLS3JyZmFZRVVYc0FjdzNKRVg2dVNDeDBh?=
 =?utf-8?B?dzVwcU9Ga3FEdWFPY1lWZEc4dVowK2EvMG9MOUNSbkxDako4MGIyVEEybGR1?=
 =?utf-8?B?VENwSkltRFdzekpmZ2pDNHN6ZUxGOUk0cnlRVTJ5bzI0WnhScWtBTjg2cjE1?=
 =?utf-8?B?am9yeUJJQmlNTGgxTS8yZzlta3RtVHhERlFOeW5Send2QW1PSnRtT3lZOXVW?=
 =?utf-8?B?TnRGS2l4T0hXZEhqZkk0cDY1cENHbStMbm1JNVVaRFdzYzRsbnJackFSVW5U?=
 =?utf-8?B?cTNZWnlIbzVCL3A2NkFoS05OQk9nRzZGWmtqdUwvY1o2MitQYnlyRzl3blNi?=
 =?utf-8?B?WDJkNXhDYWZaSFVrTG9VeFBZQVAyTEVRNERyZEVFU2ZnOWxLTk41M0U4Q29w?=
 =?utf-8?B?cTRBUEh0T0ZmVHlyelZMQ1pncGp3T29ybldtOGxuVk5iL2xOMmRtWStQZ1M4?=
 =?utf-8?B?bzVpRmM3NUdEMlRRczlJcGhyWExubWdpWkVITkVHQmlWQ2QzWEdMUldacnVn?=
 =?utf-8?B?ekZ4ZXQrVE5LVjJpRUNpcUlwYXlwTGFKbzM4NkthOUR1UHcyMVkxbC9XdXVR?=
 =?utf-8?B?QVViWEpvamEwSTliRFBXdzByaDNuTnE1R0VqYWFWODd0blRlS0gwdUJoaTFD?=
 =?utf-8?B?T2lBNXp3Vkk5V1RSYi9aME4rUmd6WVpoMXl3MHd4RUM5a2hFUTRMY1o5VjBX?=
 =?utf-8?B?U2lTc2xMSUhpM2k3YnNTejhTTSsrVG9UZXFSV2JDUlhMZWxMcVM5OXpWbG9n?=
 =?utf-8?B?aklBY0I3YkpabEI5bE9FY1NhTmVDWjNoekEzZGVFVmpvT0p5dEQwdUUvb3FU?=
 =?utf-8?B?MGlUVWFGd1BQOVNhZUh0WW5ZdFpDV2RhNC9ZSVpNeUIySnRWQnhmczkybW1Z?=
 =?utf-8?B?UVNNK1hXa0x6bUpvZDZjVFVDWHBkVnNjTm9kV1pxbnJEeEhmaWI3SlZScmpy?=
 =?utf-8?B?T2doSmNJM1hSY2U4OTRBTGpuSXRMUEJma0hLaS8wdnhPY2UzY2hpT3p4UkFv?=
 =?utf-8?B?b0sxSTRRVlBhV2VTOFByVUxpUmxOZk9xQkZzcGI1Z2Q5WHJYVWlpSnJNRm5H?=
 =?utf-8?B?MlQ1UXRMNXF3V0ZZaisrb29aRFpRaWtYL2oxeWQzVCtaU2NmZ28weThOV2ll?=
 =?utf-8?B?S3VOVCttUWszckV4SVFtQnVKN1pDbzlCSUt3Q3I5WXBiL2p2L1k0clFVM3FL?=
 =?utf-8?B?cGJFTGcyRytxU0tqMEVoLzVsUzNmQ0NyWmhEQ25hSkxtcXorL1Y2VlhzVzR1?=
 =?utf-8?B?MnphYnF3bFVxZDRMUGxkMldDSEN3VjIzbDV5TjFNcnMzejN4RzArY1ljZDB0?=
 =?utf-8?B?U05nOTk4a1QrR0FMYmpOYXcxdmlheXQ3Ujkwd2dpUUVjdzY1NzEzQU1uRGRk?=
 =?utf-8?B?MkVyZEpGenY3OTV2S0xCQjAvTUhzQlg3MHNYUEk3MFVMS09GRlpzOEprMHpa?=
 =?utf-8?Q?52xILv06j6RA8Sg/RjPevc0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c01f27-2ea5-47ca-c0fa-08d9d52c1933
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:59:22.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGJ7WkcBI33Xa46RDAdNWaP/RHr5LrKho2eWlrTvG5BaCDxbSl6xUqVya8OxqqpxrQiBJzerXArM2w853SPH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
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

Am 2022-01-11 um 12:31 p.m. schrieb Kent Russell:
> Three misspelled ASICs in comments here, so fix the spelling
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 127d41d0e4f0..2b65d0acae2c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -68,20 +68,20 @@ static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
>  		case IP_VERSION(4, 0, 1):/* VEGA12 */
>  		case IP_VERSION(4, 1, 0):/* RAVEN */
>  		case IP_VERSION(4, 1, 1):/* RAVEN */
> -		case IP_VERSION(4, 1, 2):/* RENIOR */
> +		case IP_VERSION(4, 1, 2):/* RENOIR */
>  		case IP_VERSION(5, 2, 1):/* VANGOGH */
>  		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
>  			kfd->device_info.num_sdma_queues_per_engine = 2;
>  			break;
>  		case IP_VERSION(4, 2, 0):/* VEGA20 */
> -		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> +		case IP_VERSION(4, 2, 2):/* ARCTURUS */
>  		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
>  		case IP_VERSION(5, 0, 0):/* NAVI10 */
>  		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
>  		case IP_VERSION(5, 0, 2):/* NAVI14 */
>  		case IP_VERSION(5, 0, 5):/* NAVI12 */
>  		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> -		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> +		case IP_VERSION(5, 2, 2):/* NAVY_FLOUNDER */
>  		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
>  		case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
>  			kfd->device_info.num_sdma_queues_per_engine = 8;
