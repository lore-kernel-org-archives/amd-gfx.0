Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5471EE8181A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 11:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C255710E3A6;
	Tue, 26 Sep 2023 11:12:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9C810E3A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 11:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjtEiapVr9O/8AOTCX8rJXse0Jxc6x8ccgU6YNwoUuvIuwxzLLGSxvFRVKXBB7h95H16mqm+SkYYdKjo1SQ6Vsqrc+PL0MWYnZp9c1Q76LztALK7lT3YBohGDTXYG7ds6IXerA1tPCuur4DBegKRb0yHygfalzpLJqEortV4PtPTQs955PvLrvG156MHyY+H21pUK+2oc4jgaDAQsMwHI2QRFn7CXo3iOpkHnM9o1lWKI9XsA1VU6AatUyP3tYpTJ2APEuzy6pIP83pjJEOlsLIYKrjHZDO4oUR1BI+xSO7eatyZF2IiltvnFFt2fYe/ullonwTYFk37BPQ/M2tUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+YlIgOgcyuAUvzO7jsV/J/OcNSRS/myDbODR8neEyk=;
 b=gQnx3P2NCqI9qXZFvQeRaTVeZfnmVTQZF1nmQf7pahJMNO2hLmjhwzNTz0JLDp2JVzvhXmSpzqkpba4uRRRX92nIKjLM75UkAPilnMtazlM11+Lf2JtlD/bAaK9y6CZqx/0NfLgjnRnCLSazF7S2fa4+b/TL0EUFLUFOZF2yhEOtpVs6+PHT1G/Bea9MO+s+VZV01E/2y9X6wrrPJ7G17uhuK4+2ZFnx/U5O8pxufhcgAn6fmLH/Bqktf/Xv+jL6aZF/AHA38hLIR4tSzQr/xFiIajVXfKjJFHUBdR8SyY1kdIv6CpGVqL9BJQgNCW7wh9qBGpYz+kSUbl9SilpC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+YlIgOgcyuAUvzO7jsV/J/OcNSRS/myDbODR8neEyk=;
 b=zDJgow/sqRpiqeo4BC2WJ0ntVO8gsuHY86E2EGtXDG+7IbWhR5I0r/tigvU8ryspD2Go/MVU45Sp3a1g30C4dkfTvCgdk+Xm0wJ4vIR+cbnRtLgtYymEiYGHYkk7LMVfWK7tc3i1frgd+Pu09FEfptyMELN5MtF77R3BPsGcKUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Tue, 26 Sep
 2023 11:12:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 11:12:03 +0000
Message-ID: <4483780b-cb29-5d74-b973-daf45976d124@amd.com>
Date: Tue, 26 Sep 2023 16:41:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/1] drm/amd/pm: fix the print_clk_levels issue for SMU
 v13.0.6
Content-Language: en-US
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230926110249.5071-1-le.ma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230926110249.5071-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e012ac4-61be-44e6-f88e-08dbbe816951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22AzY6JNU7YtaogTZx6pgpUvU4dUyHVRS2aq5+0HW8Gdl+v0xpQi8xn7j69hCkSrICKik3PVcoH+YdHOQl3Aq2wzHl/I4t2SP6ox9gSj4QenOj2IkH2A8ktkUfn+pGxX44dNTj8Dlv5nmNiJqpijpWHlT9z6B0yJx6HmOpJWAD6S9XsSkIKI056QO1p/KNuBhy/GbJXRy1otb3poCWKWjBZXJs6jO2c9lHFUljHyHeNMeprCz7UnRgxn+JnMsWxAhx7flBrYXrmO05sGEYxs6qxrRlu/TxXyZ7Cb128Lbxg+w1oXR1cFSl5vsdmfCVTNJtDD9v2fpcGLSabGDJ8RnOw6jHHCtKy0tJkI8dT4SN6aCMsGd7ySO+2VkaiAZuc65OlKRTgEAycTO4R/Eoa1W/ZjC0u6tCM9MGw36gptNvZ6zeEiuLT1vKK7xNXiKYa3IwCGa46oUVCMA6dpsv+erZDjGrapeL8ILYzaCYAFIdz+hDkV94veyBYBV32WiKch7cRjDjjoEBTye8qpo4TQ0eVPSKzvsR6kALDNTyUG12X8qRLTtdcZBgbkSL0b5DyqW9hGh0FOBlgMuUEBgpcOOWcNIxRz1Z+EtR5FR+YwMyemzwr5RHbZZd24/2aZSOow3txa4n6JyroHcWbk6Q31yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(86362001)(31696002)(2906002)(31686004)(4326008)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(478600001)(6666004)(83380400001)(26005)(6486002)(6506007)(316002)(36756003)(66476007)(66556008)(66946007)(53546011)(2616005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRlVFIwdjVWZXh4aEdTSlpkVmxyMHAzZUJyaStHZUh5RVdTNFB0UTlQcXRw?=
 =?utf-8?B?U0VSdHNMekhmSkxDZUM3SXhaaElRaEl4Y0orbW1leXEzVWg2cU95T2orLzky?=
 =?utf-8?B?OVkwZ3d0KzJ2MkxGeUVhVDRIOFRMRUp5aVRNejYzMWoweW9Tb3VhMzRtOHZZ?=
 =?utf-8?B?TEh4bDJnZk5Hc3l1YUVLdlJqVjlJVk5GSE4wQWg0VktibGRNSlhYaFp3Nk5i?=
 =?utf-8?B?V1lydm4ybjBOTEVtbEloeHJYVFhYR0tWTXhSS1gzNVc1b0lDOS9YSExxTXZa?=
 =?utf-8?B?d0xZdFhEamJ6NHVBNHlsVUJpTGtycTduSDBmN0JlZmJjVGRIcHdBcGxoR1d3?=
 =?utf-8?B?ZHlhaEF5NWt3MzhtV096cHh3L0cyZk9oYzZhQSsyN0ZQN0pxdGV4Vkpybkhl?=
 =?utf-8?B?Wjl2MEJyN1pjNFNuSWhCcUdnVDZNS1FMbkU2MHdFWjBQbytmUEI2TTgrQ3FB?=
 =?utf-8?B?QjhES0QxQkNwQ1RPc29FcWFYVGQ4cDRqcnQxcm9Vc1lCZzZMTzREcHpxVlN6?=
 =?utf-8?B?djAydHNCaVNhL0dhNGV1UWhyYURSVGo3MnU4d1BiOUNwN3RzbWJoUXZWYjhZ?=
 =?utf-8?B?UVIxZUpMR3lKYXVubTRkSUVoVFYyYUtRZXk2L3RRdlpJczhKelExTjA2L1RF?=
 =?utf-8?B?Q2hpQkVNOFI0ZDRDdnJhQW5Rd1NoeDJVRi9CMTQyUDBQV296YXVNNVBhZmZS?=
 =?utf-8?B?M0hSQk1MbG1CNENLV3JuNDRrZlRMKzNQSnFkYW56OUNJVmZZM1IvdW5tS1dh?=
 =?utf-8?B?ZDU1eGtncG9SV2VtVGJsZ3BuMWlMWitYN1U2TzJuMGZGdkdjWHVnUTRXYWs0?=
 =?utf-8?B?Y3F4emZ0SWljV2ZEdGxnSjdLa0VmaWJ4TU9vT2xnak5hV01EMWVvUkhRa0pB?=
 =?utf-8?B?MUU2aitnM2pPaktKclQ1QTl3c1lqUmY3U28zdExJcjYzSU1QNHpYRlB4VmdL?=
 =?utf-8?B?dENIZmt6UlVMdzA1bUZLQjMvelpCTGxrVTVBZDJVTHRPNGEwM0hUUitFZUhv?=
 =?utf-8?B?aDMvV2NRWjRrYzFsQXRUeWFXY0ZwbzduNUMvR1lzNTQxUkdYTlZ5MjJwQUFY?=
 =?utf-8?B?SmV3TFhMYXNDQUc0UlpjSmJiak85QldDdGp6cDNCbGZ2UHZJSG5MNlBpSkxx?=
 =?utf-8?B?N3Z1QTBrbnB3R3FOQzJuZ2EvRjZjNllHalFpa2tnL09aNnR0cWZxY2MrL2Nl?=
 =?utf-8?B?N2ZVWlpycFpza1VGdkpWeURPM1Z6cXlXdzV4aDJUeHNSNmQ4RjhwSDRvWGkw?=
 =?utf-8?B?RUpwVXFTOGFSMWt0MFZ5SUJWQ2YvU2xZYU9BRmh4c0pURkpHdGQrNEViZWdV?=
 =?utf-8?B?RkFtMFgrRDVtSmNINEg5NUpxRnFzUnVwT0FNa3NyM2krenZNb01BMTEvSUlG?=
 =?utf-8?B?TnlyYVVySTB3dm9jeEt2RXkwL1BxWEFBSFhnUFRidFo5Tys3Y1hNS0hVOStq?=
 =?utf-8?B?cXR0ZUxkcSsyYklCNVdhaE1kRFltdm00dUErYmwrUXVLKzg1M0RvMHpKOWxW?=
 =?utf-8?B?dnEyTkFPd3VQNHIyZWlLU3VCMndtNVpWSUFRckhldUtVckdRM24yMEM3Wmgr?=
 =?utf-8?B?SnJFVkJ0NGQzVHdtZjBZUUJvZXdHTTh1dElYckRNVnNSL21FdDlQZUFmUmdu?=
 =?utf-8?B?cXV6UHJkYWRLUGVMbVEvZnlYQkIxaCszQ2MvMXFGdDhkd2ZtdTZ2MnYwRlZ0?=
 =?utf-8?B?WVlWaDZwUXFqNFdSWEE5YkJCS1dORTc1YUx0azlTbmI4Q3d4SkViZE53NkpN?=
 =?utf-8?B?TlNtWHRnOGZMcmdOenR1MXliMlpVczA5TG5vV0hFb0RwTDhXaXBEc2pLR3JS?=
 =?utf-8?B?bGN0Y1ZBbGg1aUNCNTJscGlDekJZVlp0RndKa3lrRTlkYXlUbU9FWW1qV0xP?=
 =?utf-8?B?WHpSQWM2TGE1VTBUWkduZFBORGY4eUs0cXlMNlV6MXB6TzE3bFFDUERzaEI1?=
 =?utf-8?B?OTVUVkdmVzg2eXpwUVhZYVlPK0tINithZHViaWlHYUtpQm95WW1GNnc5RlZC?=
 =?utf-8?B?VDN0SDEwZm1oaWxIV2o1L21ZdURnb3VYaVA0YWlqY2t0ODVRVHVjcE5lZG5o?=
 =?utf-8?B?dEdGNlh5NDVhVWhYTUhBR0F5MVlJU2NYbCt1MDFqQnAzOFUzQ2JxcGltMlJh?=
 =?utf-8?Q?2sTWl3HhCkdQy5rdXuFxjfyI2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e012ac4-61be-44e6-f88e-08dbbe816951
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:12:03.3928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zJgmXg1KKUcMx0kG26/buBGUn6mGc/pvECdiqFuyGuMBqnTqiarSE+6WnFXEJOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/26/2023 4:32 PM, Le Ma wrote:
> Pass the correct size to smu_v13_0_6_print_clks, otherwise
> the same place in buf will be re-written.
> 

Where is this getting affected? As far as I see, there are no multiple 
emits to the same buffer in this code path.

Thanks,
Lijo

> Change-Id: Ia0e12430d01146a11490204c1bab4b4f06cd17ea
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 11a6cd96c601..19c117eb5ebe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -821,12 +821,12 @@ static int smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
>   	return smu_v13_0_6_get_smu_metrics_data(smu, member_type, value);
>   }
>   
> -static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf,
> +static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
>   				  struct smu_13_0_dpm_table *single_dpm_table,
>   				  uint32_t curr_clk, const char *clk_name)
>   {
>   	struct pp_clock_levels_with_latency clocks;
> -	int i, ret, size = 0, level = -1;
> +	int i, ret, level = -1;
>   	uint32_t clk1, clk2;
>   
>   	ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
> @@ -947,8 +947,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
> -					      "mclk");
> +		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					      now, "mclk");
>   
>   	case SMU_SOCCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
> @@ -961,8 +961,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
> -					      "socclk");
> +		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					      now, "socclk");
>   
>   	case SMU_FCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
> @@ -975,8 +975,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
> -					      "fclk");
> +		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					      now, "fclk");
>   
>   	case SMU_VCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
> @@ -989,8 +989,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
> -					      "vclk");
> +		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					      now, "vclk");
>   
>   	case SMU_DCLK:
>   		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
> @@ -1003,8 +1003,8 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
>   
>   		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>   
> -		return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
> -					      "dclk");
> +		return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
> +					      now, "dclk");
>   
>   	default:
>   		break;
