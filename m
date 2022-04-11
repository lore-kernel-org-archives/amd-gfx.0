Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BDAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9842110F5F4;
	Mon, 11 Apr 2022 13:56:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3856610F5F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 13:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZyFyABlmA6VENMNF3RPkSpfWJdTs8XgSVchfNoeR7T1/hmtGmrFfCC8LDt8gGTjlzMbysK9uPANZ+YDiUH/dk+jL102j+Uppb+fvDUk90xmN95qat3xKXpsW34qVJsUoezBsOn0VFDhyQiQ/tc4cKRnZ+pZz3U624XLkUc3b62c79/OrkIIRLsHSQsNy6ybPLfOlBWXlYn5120tjZHVdnNtPdLMOHpw9p/7Ng5r6ybc9e1C7ZtfOVBnyqAEp/4SuqN5lgFnCp4/vvUZfhxOIjE4mNDwc1/qloUvI9W6c5f28rGbYQgn+HDsHo93ZMs1i7j39i5QSFIKDL/K1BFM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kg0ltKduOKkwwRVSFA/NQOgI7dI/178eheogiflVG4=;
 b=JWZf1kb7C4Yd/G/8xEKHLZexspqIpZvwguFHL6kX/1d/Ew0fn8PqfjkSVoqd4ZZWaz6J/xmUyPT+hus4xHC/HAlqGM+mO0cd6lXW+Jzi0F+c1cxf3KOT0y7HY8oTqe5o6etthV58VTiwpHSScc14l9uFEWMt8UWfKM/VHgT0zAH3fZRoYMmXTDPICMRB3cYO0aIW/kqJXFfXHZ+wlo0AXZcttChsHN4IsX/ptXTQhv1HiLM4euegf6VJ/fezD60ntedrMDee66jDgsItIN0+tVBZS3LMPHwoX9GPAz0weaRYUu7qy4Kmhzoqf7xmxQRgLHgOARhW+H5scZCWyj8NGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kg0ltKduOKkwwRVSFA/NQOgI7dI/178eheogiflVG4=;
 b=zVTCWOJTwf69B0Gqow+ANwH7+BGGx7D5+5B0ESMReb52UirGG8wgXHSfFegnfP5VUchOtALVbQG224G7U+Y5PoFjecv0Y0Q5DqC1ptPQQxuy9njB6sxlZ5mDT/NDzjSzOOAX1fhFxyrWjs47pIhbr3iICLuIF9lHuK8kMC1WvQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1185.namprd12.prod.outlook.com (2603:10b6:404:1e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:56:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 13:56:12 +0000
Message-ID: <fe4163d9-c935-cf78-661d-00ba75fd1fea@amd.com>
Date: Mon, 11 Apr 2022 19:25:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Content-Language: en-US
To: Elena Sakhnovitch <elena.sakhnovitch@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220411133216.3407198-1-elena.sakhnovitch@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220411133216.3407198-1-elena.sakhnovitch@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bafd21-271a-47cf-9f84-08da1bc3095f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1185:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1185223C9DE4605B0D6B9FD097EA9@BN6PR12MB1185.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdedP2CGQ5bBbU2jOZGOCn3pujg0jGhRNy30fWGobWJD58xZ3wHXpZV/zXk0QF8tQrHCnMN6gkr3H6Xiu9hJmiIWTThMnuARcksjvNLlV4bBb6AqyNnZPBDzZzcnPRL+xG1ROelKfcV8b/zAFk9Vm8M9gElIzIg3DH5M9n8LvTpP7by2kBTazHq8fIHWQCPCf2CBQRecunn3qKS08TSFnt0r+2nEI7bc0ZsilnAFLDAGzVmzr6O95EiRDAZZo7DN+fKJVMDhvJ48VBPqHapJh5aMP3S7Mge9vB9036Kgb75x/D3h+vgCsbrWs4kwKdmH6BWAooEQwTGE2sG2+JG8hpwYykBWO3l2y+FfwYEYVgOsV1BL5N1gt3dFe/tHvPecuYTl/0c5ewFBjrVSACrkyYJhOvWSC3xCIeJaPChJLW2lAOq8arA8oJ1IYyYVyMpm5cFhOiWdOUv7ABR5tl3v2rVjZW31YQhy+sJBPsyvqJe+cxLH/bqCO7Z7QnbEI2pB4E3zCCyrXNBH4iyRRUO3s+eU9uDjDQrZUQKo7U2gJwY1JUKgqerFUKk0sBGbYzf8a8kx8pcoPpD5iwsZV1y+ZUveS2jWo1srzvzoE0N3zxKYeI6ZpBIKGerFA4IzMN0Ip8D+dHbVBCv9+yue7hWYmRzTkXXsJmug8wvFOujZMMIZ+NZ71RyxWj7Z1N5+hL2Jf+RE17MPo+thkKvzJVhT049YQuhhilxQnHNNJI0UaSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66476007)(26005)(6512007)(8676002)(6506007)(316002)(2906002)(38100700002)(83380400001)(6486002)(508600001)(86362001)(6666004)(186003)(5660300002)(31696002)(31686004)(53546011)(36756003)(8936002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2VrQ1NEcGRkbnZpZUZJdDBFRE52T1RhL2Q1dURJbVpqMTFnRVZEbHYxOTdE?=
 =?utf-8?B?VzN4K1p6QXVGL3FLWEpHN242c2w3VEdOam5wWGZaeWEyNHpZYS9hN0Rob2ZP?=
 =?utf-8?B?N2IvVHB0UUcrYnFNRXI5WDB4MWZoZHdxRjlPb0tpakFqMzA0bTJnTGpTYlY5?=
 =?utf-8?B?blFVNS83NzJ1QjJYby9IZ09SMkhxRnlyUTJScWxuMXZ5RHVFYTdnSWloWENP?=
 =?utf-8?B?WVN6dnBXUkpmV1gvNUdvTmprWklUNEloTW9wVFlXQWZuQ1JxVkY3L2V5UVlj?=
 =?utf-8?B?bVZqQUgxWElpdjZNcFNuenlKb1JaMjVVMlBtWkVjV1REOVlNaUVGUGZDZWE1?=
 =?utf-8?B?MytlajdYc2VKS0xYK1hpeTBYUEE0ZUp1SVlteEQwZEVoalNPN1hjYUNsT1d5?=
 =?utf-8?B?enJJR3BadXUzRmMyK2tqRzU5NVVlUHpFK3BNZ3JoMzBILzVQZXl2SXY1R1o1?=
 =?utf-8?B?WDg0azRVU0lmNnFENlhTd0p6VkxSMDhrQmtJNFppb2MycXJEU3VSMWhON3Bu?=
 =?utf-8?B?NzRPWlNiTHdSdHBvM1YwMFd0UTBtTmlkK2szSnlvWi8vSXJHbGJpL2hYN0xw?=
 =?utf-8?B?bGp0NXRWakwzSEh6M3l1WFpBRnFNb3FVaWE5dVNrZzVrOFpVWE03UzlpaXpV?=
 =?utf-8?B?VExjV3ZkcVZKNUxSUUJyQTY4TzJRcWRIbG9UbFBGNERQQjRxbS9oTC9KdW1R?=
 =?utf-8?B?YlBscTBPR1dLd3YrbDhQL0psQmZTOXNpb2J4U05URkpNK0hpblM5ZXNRR1l4?=
 =?utf-8?B?UHByaGNFVFZBT0RrckF5T2NENHZBaE9EL1JpbWFaS21USU9SbnM0Y3E3WjVr?=
 =?utf-8?B?V2t0alo4ZC9ESTI4RGJPamVXSDJraVVqS3dURkdzbVlKRE80MExxdWlMRjBx?=
 =?utf-8?B?eEM2QWplODVKK3RUbFRYM092SS9FenRsOE1iMmN4aWM4SVdRWHh3WmJWbUho?=
 =?utf-8?B?UVhyL01OTDdDWXF3T0daK0MxQjdrTW9PQW5OUDMwOVlvWnQreHpKczVOOG1O?=
 =?utf-8?B?V1BJSDdITjNNZ1c3a05ZOTFyVENQUHE1eXpQYlp1Y2I1VWhRTFpsTm1WZW10?=
 =?utf-8?B?WHRUSzlrWU1oVURiL3pyemdUaFN4aWFyMHZkWnN0S2N2WS94SWw5MGhERHZS?=
 =?utf-8?B?UGUzNm9jRTE1OThKUlhtaGxTQXBFZkZ0aHE2VjkxdXZuTWViRTFCMjdsTzRS?=
 =?utf-8?B?V1hKMFB0OFMyNmxwUTZIRjh6RkIxTlgrZUJrMTczNHA1b2FUME9SZVlEeFMw?=
 =?utf-8?B?bjNRYXM5bFlXQTk5d1k3VUNnYW53WlBtWHl1M2lWWDlYcWJLbDFLak56S1Rs?=
 =?utf-8?B?clR3TTIvTFB1a1NONVN4UWI0MVFUSGpzSS90VkxpRkFodjlaWGQwdFZJbUd3?=
 =?utf-8?B?Mlo5OTVmOXFWcU5OcXYvUmNNaStMa0J0TGwraEIxMmU0RnhJMnkzTE9zekd2?=
 =?utf-8?B?bDBndVVJdnBHRDZIaCtYdDV3clVDZnNKdmZFR01aVW9aV3ZvT21YTE9zVld3?=
 =?utf-8?B?ZEhXMTVxdko2WGRwMkJuZTNnMTRXejFzZ1FZbU9HVjM4K1Vwell4c05Qd2Fa?=
 =?utf-8?B?VUFzekJjeGxHLy9kbFlONTdESEt0amZTVDRFNG5va2RhNFNmamtPRjJkYmpE?=
 =?utf-8?B?QXllMmhwSHEwQVlRRkJDTklCYlZSWU5UeC9oaUdsRVZFRTFpazh1Mml5QitG?=
 =?utf-8?B?M2dXUTBQTFhiSkxVVW41eHdLb05icFkyWnFEWXZzWW9saVF3dW5MR3hKTVRW?=
 =?utf-8?B?RHBHckw2d0diWU42MzR2RlJOQmljUXZjM0JpaU1PNCtnWTEzQlIwbnFsbVZF?=
 =?utf-8?B?WnRLQnRrWDB3elo4S3N3MmN4aCtQZ1F0RkZPdEs4VGdYRElNek9ld0lZcnpw?=
 =?utf-8?B?YjdNdmlTU2VRYmo2YkZLZWt0NktIOTl5bDZLQlVUVEVqUVJrQk1nZFFTY0pn?=
 =?utf-8?B?YUpERTdYakhMOXUzQUpFOGVPemt4YmFJRkM3a2dST2dKMFhmTWpyYzk2cVFp?=
 =?utf-8?B?TVJYRXAxdHpWN28xSTdhWGJqR0RLbXNSeDVwQmE4dkFYYXRvUW9leE5Nd3FO?=
 =?utf-8?B?OEFZcVZyWDFNMmc2Z2FzTXlPdER4em11L2pDSEo2ODdpNWNtVDNrVnJSVXRn?=
 =?utf-8?B?KzNybE1NZDh5Y3NkN1B4a2VhTmt6ekZlT1hnTVF6cVR4Q2hRc0U3UVdkRFZB?=
 =?utf-8?B?dTFtN0lWcHNPeFF3ZHZsTFRXaWhTQmpFSzJENEhqZGxPVDVVa1kzTzByZkR3?=
 =?utf-8?B?eEp5dUV2T0gwV3BlSGRyZysvbGpIN2UrdE1PTUd1QlFMQTNWamFNMVMrZ3RP?=
 =?utf-8?B?eUUwZDBNMVFaTk9lTEJ1Z0kxZWlId2NxMHVPTk9zWi81QW1sRWc0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bafd21-271a-47cf-9f84-08da1bc3095f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:56:11.9618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kc3gvJ92ltPVENvChHPvib4Q5CAurg5P+m3oQfNgDfskEd0J9srh3GLtsv+sW1KY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1185
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



On 4/11/2022 7:02 PM, Elena Sakhnovitch wrote:
> On Sienna Cichild, not all platforms use PMFW based fan control. On such
> ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
> knobs for fan control also as it is not possible to report or control
> fan speed on such platforms through driver.
> v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT
> 
> Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index ab3e9d8b831e..ddc388b061b6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   	}
>   }
>   
> +static void sienna_cichlid_check_fan_support(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	PPTable_t *pptable = table_context->driver_pptable;
> +	/* No sort of fan control possible if PPTable has it disabled */
> +	smu->adev->pm.no_fan =
> +		!(pptable->FeaturesToRun[1] & (1U << FEATURE_FAN_CONTROL_BIT));

#define FEATURE_FAN_CONTROL_BIT         32

Given the above, this doesn't work. You may cast FeaturesToRun as 
uin64_t* and use a mask like 1ULL << FEATURE_FAN_CONTROL_BIT

Thanks,
Lijo

> +	if (smu->adev->pm.no_fan)
> +		dev_info_once(smu->adev->dev,
> +			      "PMFW based fan control disabled");
> +}
> +
>   static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
> @@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   		smu->dc_controlled_by_gpio = true;
>   
>   	sienna_cichlid_check_bxco_support(smu);
> +	sienna_cichlid_check_fan_support(smu);
>   
>   	table_context->thermal_controller_type =
>   		powerplay_table->thermal_controller_type;
> @@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>   	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
>   	memcpy(table_member, smc_dpm_table->I2cControllers,
>   			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
> -	
> +
>   	return 0;
>   }
>   
> 
