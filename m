Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BFCC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 03:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63BBB10E3CA;
	Wed, 26 Jan 2022 03:26:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F59E10E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 03:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPCIwEIwc/BCD70I8s2N43KqlC5e26RNT9ygWUjS9D18iF+E/GHSHW/RZMeDTo309tx6QhcvpJ6vgmvHSBQUN8v0o1VN7ewIedEHreN6hE8VOP1UHzExkfAGW6lmQytzCsEFjMxF86FDxhssIrqicBnxFBGCQLcliKZx5MjanrZNxsgVIW2rj0cUWN0Y5V4znhOJN5/CVtRDViSesSdl5KmAC172Cdx08Yts9gJoxl+L5N+4PMgVEMK/AkcazSgKuxlybl/6XtG/goX2LNHWjWLvDhrwI4ftxJolQKTTL/b1WrutK8ek/7WIa3YfHP1069dxqxmi5+SWFVueKhFX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OadE1tbwcNA9peb+k0YjYZaDzHJ+hy31UgSUjzelzZQ=;
 b=invlZVbH9/9hUEBg84xZqPKo1Rs7BNpY6XabR3BQJS8nrvadWoq8xQOJBLNHQefmFC+XuZn6WCyo/DKcca+yhTh6W8NpB5C97+5Zb+nvKkgkviIZLb6QkYMmuKloKA8BHB6F922/4Cq25+ehs+DUyq0tssmjYtUlf57Z9eY9IFU1VjRckf7HgOMfojQIbTon0JQs6W+A50V9YFxxLUGISafggMlwH0X87OxYA1IaF/r7Z6zrEmprdGo6dwwsLrQJ1trq56q/wbyDIXrZp0rFpSD698rFH3pz7rwX2kKuF5D+3s4aOIzhcILsbXP26yoVu+UeQ32KyqyPhL3kGKsKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OadE1tbwcNA9peb+k0YjYZaDzHJ+hy31UgSUjzelzZQ=;
 b=3UI+ad0E2hsQT4kP2nl32pk2L0RfXqCcK39leLV50qde8cgqGSQOJKvPp7igVxav4ARJZlmEF3xZf6hcoPX5johJbYJrUvGpkCq+Az0zfviQ4h5Qq+aiqpN4wTWzBGHvLB2LE8jrTUDyuKn9M5aGflSz83WtMi37X4bd27GgPMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 03:26:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 03:26:37 +0000
Message-ID: <8fc1a895-5bd0-54c6-6e00-8dac75711b58@amd.com>
Date: Wed, 26 Jan 2022 08:56:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/amdgpu: update algorithm of umc address conversion
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com,
 john.clements@amd.com
References: <20220125104612.27050-1-tao.zhou1@amd.com>
 <20220125104612.27050-3-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220125104612.27050-3-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::30) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a928eaaa-2078-4eb8-a970-08d9e07ba8ca
X-MS-TrafficTypeDiagnostic: BYAPR12MB2965:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2965D6DEBB31A074040F625797209@BYAPR12MB2965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OD/+cmH8Li/CkQWhADI1zj64pnZ4Ar1Sp6uZ6bTMcSdFuhYavgXw1gcKv2jn6pkUyUvN77n/Fu0wkCUoYFH7V8HN5Qaaf51e8cBK/a+iFRFI2pcfbWIJzdjFr5XPpQp1mJ3E2JtUverloTC/FyoaRLxPN2dukD8nmTXdbdPtpGVQVDYr3r6JPY45Xt8iIPv7zsgoHzkf4Ga41IAhBEA6gxwAUXAyrXZ88J2YvOCTlqo6PGea8iATPUhH1nojpVMykSsnopnotHoymaSZXByXgpDodXacR3SEOGayXsFKXojFq+th/9TdDix0755vVVjW73RMu3g98OpsK5qWyZDMIQoxGzbSNcxRc9xs7x7Oz2L6d01iLRJsibeRpZiC/78cBt0BFi3viBBh18o6gd2IWF0bVivLFhp+zLIOzTjTMTWXREOuwoGY6WPWAOoxO5GZUMdznuDvt55XX630vkM8qSYZoRsgmeEDOkkqxIO3dIPGYk4YTDxzVh76pSkKGq0J3p6ZlVVC8zGmXdqyhIl7cT11VWQdq6xgki3QnLdP33lbDWqAqtdMRWWzcon1XNKSj8bc3YwCEEQ8Ox8/bYc7QZWpLdZmv4iRlynQBZHLkTgqX+PSPrHcGsby3IhONIM1++yIbkMpPms0iKsbTltJV4vbbwDx9dXkb0YuzoJGUYAbQS5SJLCHWz5WcBQX7LyUnF0DhGHHpGaqvExU3Z4fpBjDUFq1HKfY6tv+QMW2T3Jl1yqKQUiHxzpjbcvBq4Z0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(6666004)(6512007)(6506007)(86362001)(8676002)(5660300002)(53546011)(31696002)(2906002)(38100700002)(8936002)(2616005)(36756003)(83380400001)(508600001)(66946007)(66476007)(66556008)(6636002)(26005)(186003)(316002)(31686004)(6486002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0hWbXN5Y3YxYTZnYXpUbUVmbzlaeFR6TnlCb1ZpSW54RlBhNDBxMDlibkwz?=
 =?utf-8?B?bEhKeURGWjRMV2JaaGtvSDdGRWd4dS80RG91SFZVa0RHZmxOYWtPV040eWw0?=
 =?utf-8?B?aTB2aXYwaU9PeG4yMFdOamRKbTVxeUY0Q2pjUHpBQzArNTRvNnF3K09ndWxR?=
 =?utf-8?B?ZERUWWFTdzBPeWl4VFkxSHVHQytkUEx1OXluQnlVTG5WS2RvSWdFcE9tbTRV?=
 =?utf-8?B?QjZwQmJRRTNET0dmMmh5Mkp0MFFqaHphRDg5ckF0Vko1MWk1ck1FUk0ycklu?=
 =?utf-8?B?bHV3Ry91amg3WXhYYkZQMmJxQm9JZVNGYzRDdjVCaXdrajJrYVdCNU9uWTBM?=
 =?utf-8?B?aENqM3VIUW0yeGZTeDBKSlM3bHQwZzNFQXBHWU1SVGlZWDM3eWVDU0NSTlM1?=
 =?utf-8?B?VkNhWUgvRTJIN1Y4VzJJOWo0QWlCZjlaZW4zb2laM3NCaS9NWTRRY243VG9P?=
 =?utf-8?B?ai96ZHB1MTRRT1hPWGRpT0dLbzA2RlFDSkY3VG1EREplK05DNTM4SG50b3Bq?=
 =?utf-8?B?bjRSYnBEb1V0V3l0T0NKYm1qeDNISnY2aGoxaGwraTJITTliaWgvWTRnWndU?=
 =?utf-8?B?Sm1leGZPckVGS3drWnlteXJXUUR1YjNUdEpHOHY4ckI5VWRwUGREOSsrd0RU?=
 =?utf-8?B?dFVudk1SaFgyL2xSN2g0TjV0ZFdVVTk1N3NOYVZqS2EwSm9QWE43Rjk0aEVK?=
 =?utf-8?B?Y3QrYVZrSkxxV0xnYW9mWExhM05vaG4zQVlHNmRwRUhCQ1JzMFJRcXcvakp1?=
 =?utf-8?B?RjI2Q1RRaUw2U2ZhL01TM0VBeDZ2d0h6OGhVRDRLSER0NkpyeHF0VDg4dDZh?=
 =?utf-8?B?Rk0vV05oWWJFSWZWMGVoTmVaZlZUUDdmV3FMbWJnVDdnOXFUSVVQRnNrZFBh?=
 =?utf-8?B?ZzlFZEJsYkJyV2RFVjJPMlptOVJPV0pMTVJDZFRaSStIOXFQTnJjUmd2d1dk?=
 =?utf-8?B?V3lTM082L0JHbVh1QkNZM0g5V3Rrdk55dnM2S1ZTL2Rablh3Si9sazRDTmVv?=
 =?utf-8?B?RGdmMlQ3T3h0Y09mdkwwVE1JNVdQczhZUWdLb1BZNXJTbTQ0eVNWZTlMQXRL?=
 =?utf-8?B?bnR6eDh1NG1aZGNYVjlKZXJWUk43SUVBK3JYQmJaM0hmb1pWaWxtV3ZYMDk5?=
 =?utf-8?B?QXZaSUxyK0ROQk84L09FaG5OSkRPdTk5QTBRcVhHQWJvMDMrNzFvMS9xdmF5?=
 =?utf-8?B?bkhPdWhZbld6bVZrc3dXa2xiaVNub0dPcGJ3a2VrVkFlTWxGVTVpdXJmMEZw?=
 =?utf-8?B?WE9pZFVGU1FnUWZkZjlSSVBXQkZVQmtqSjhOT0M2Y1NJUXU3dFdGTjRUZ01H?=
 =?utf-8?B?RXZxZTJ1MVJWcHJhWVNqd1k0RCtnMGpFK2l4cWx1OENGYmpBdWUyRlNjR0w1?=
 =?utf-8?B?UnF1enhQNVZmNTNLQk1ZRkp3a2RrWHRjNlhLeHdZc3pRWm1FZTZjWG84NzBi?=
 =?utf-8?B?T3pKa1U3WVJWRWpwV2xzQ1pYU0YxbUpiRDVBZlAzSkxFT2FFS0QyQkFhVVhY?=
 =?utf-8?B?TmhTcjhTcEdrd0s2Mkorb0JhbUdzd0tnWEoxcWduSUJZTkczZ2FTSHlQeU5r?=
 =?utf-8?B?SXhNWFplejlaMTVYNTRRVGhYU21hNnVsMXlSNTYrSldNdHd1SjNCNFVaR3lW?=
 =?utf-8?B?ZEJZalhsNjd6UW1uUitBamZJcHZyRU9rbnp5WVZCZ1VUeGZaN0ZIdmpEL1VD?=
 =?utf-8?B?cGZXYmRpMjZnZDF3NDVacXRVUEYxaU0zSDVod0VGbkJPamw2UzFoK2V3R0FH?=
 =?utf-8?B?eU5IblYzeTRGUVdLMTgvS3FSdjhyczJGZlJtRDlEakNXZXFkY2N2SVMrSVlG?=
 =?utf-8?B?d1RuRFdIS1pjcmp3K05OTUhQMmp5d3g4TDJlcGlka0JBbEVqOG16RHlWSTZw?=
 =?utf-8?B?SHVBL28vVEdKWUs1cHpUVmNjZ1FvKzBodWd0WW5UazFHNEpxUFEvcjJuWUdq?=
 =?utf-8?B?WWNDbHk2VE8yd3h2azJGcUdDckFHMGNxeGc1SW9EblArcDNtVzIwV0VkWGdv?=
 =?utf-8?B?Y0czREtSem9zNjdlamI1cmg3S2cyVVhlbFdiL3o0S3Ixc3ptdFZRaGdTUXgx?=
 =?utf-8?B?ZXlEQnRxdTlVTzV2QmVkeUVodHpuYVM2RXU2R3ViOEkrODJXOUR0RDNLT25p?=
 =?utf-8?Q?iiKc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a928eaaa-2078-4eb8-a970-08d9e07ba8ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 03:26:37.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUJlV5uRz7mucrFGlwj9PzrlhMBEGfsVVwmWd0KIj3rXwn7WN2LCDFN4w+4JlN+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
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



On 1/25/2022 4:16 PM, Tao Zhou wrote:
> On ALDEBARAN, we need to traverse all column bits higher than
> BIT11(C4C3C2) in a row, the shift of R14 bit should be also taken
> into account. Retire all pages we find.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 41 +++++++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  4 +++
>   2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 300dee9ec6b4..1ecba7b5df1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -119,7 +119,7 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>   					 uint32_t ch_inst,
>   					 uint32_t umc_inst)
>   {
> -	uint64_t mc_umc_status, err_addr, retired_page;
> +	uint64_t mc_umc_status, err_addr, soc_pa, retired_page, column;
>   	uint32_t channel_index;
>   	uint32_t eccinfo_table_idx;
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> @@ -145,15 +145,27 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>   		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>   
>   		/* translate umc channel address to soc pa, 3 parts are included */
> -		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
> +		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
>   				ADDR_OF_256B_BLOCK(channel_index) |
>   				OFFSET_IN_256B_BLOCK(err_addr);
> +		/* clear [C4 C3 C2] in soc physical address */
> +		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
>   
>   		/* we only save ue error information currently, ce is skipped */
>   		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
> -				== 1)
> -			amdgpu_umc_fill_error_record(err_data, err_addr,
> +				== 1) {
> +			/* loop for all possibilities of [C4 C3 C2] */
> +			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
> +				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
> +				amdgpu_umc_fill_error_record(err_data, err_addr,
>   					retired_page, channel_index, umc_inst);
> +
> +				/* shift R14 bit */
> +				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
> +				amdgpu_umc_fill_error_record(err_data, err_addr,
> +					retired_page, channel_index, umc_inst);
> +			}
> +		}
>   	}
>   }
>   
> @@ -332,8 +344,9 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
>   					 uint32_t umc_inst)
>   {
>   	uint32_t mc_umc_status_addr;
> -	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
>   	uint32_t channel_index;
> +	uint64_t mc_umc_status, mc_umc_addrt0;
> +	uint64_t err_addr, soc_pa, retired_page, column;
>   
>   	mc_umc_status_addr =
>   		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
> @@ -363,15 +376,27 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
>   		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>   
>   		/* translate umc channel address to soc pa, 3 parts are included */
> -		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
> +		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
>   				ADDR_OF_256B_BLOCK(channel_index) |
>   				OFFSET_IN_256B_BLOCK(err_addr);
> +		/* clear [C4 C3 C2] in soc physical address */
> +		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
>   
>   		/* we only save ue error information currently, ce is skipped */
>   		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
> -				== 1)
> -			amdgpu_umc_fill_error_record(err_data, err_addr,
> +				== 1) {
> +			/* loop for all possibilities of [C4 C3 C2] */
> +			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
> +				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
> +				amdgpu_umc_fill_error_record(err_data, err_addr,
> +					retired_page, channel_index, umc_inst);
> +
> +				/* shift R14 bit */
> +				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
> +				amdgpu_umc_fill_error_record(err_data, err_addr,
>   					retired_page, channel_index, umc_inst);
> +			}
> +		}
>   	}
>   

Better to maintain the page decode logic in a single function.

umc_v6_7_save_bad_page_info(err_addr, channel)

Thanks,
Lijo

>   	/* clear umc status */
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> index 9adebcf98582..b67677867b45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
> @@ -45,6 +45,10 @@
>   #define UMC_V6_7_NA_MAP_PA_NUM	8
>   /* R14 bit shift should be considered, double the number */
>   #define UMC_V6_7_BAD_PAGE_NUM_PER_CHANNEL	(UMC_V6_7_NA_MAP_PA_NUM * 2)
> +/* The C2 bit in SOC physical address */
> +#define UMC_V6_7_PA_C2_BIT	17
> +/* The R14 bit in SOC physical address */
> +#define UMC_V6_7_PA_R14_BIT	34
>   /* UMC regiser per channel offset */
>   #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
>   extern struct amdgpu_umc_ras umc_v6_7_ras;
> 
