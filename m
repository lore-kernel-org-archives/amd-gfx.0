Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434BC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 04:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0952C61168
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 04:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0952C61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6316EB5C;
	Wed,  2 Jun 2021 04:55:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF476EB5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 04:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBBXiYIM0FEVIGpJ0FyDOHR6xD0ILF8+KU6iaxNBq6esZQ+08wA1100VkRZ8e3Avzbh5dXH6buwPUZfMoWL8/Ih1PCu8EKAyUAIZYVHHIKj/8zeRko/snN/Lksrv6xTj2KSkSoHJf2MJ2W5qdt2UqgXxlqc3PyQWzGUHhwqYAxuUc8d46lgF/Vd2Avr+/x31iae7teWAZkv7n+suma0fUZ7ou2w2MzcfOMCQy5DTiQHXX2Iv63mB82a1OvUPCSXuKH9ih38xuP/D66m4EIbQnyi8SKD25t1rEl4SYp/akxhNwru1doR+KUEI3lMP3XntW2pnA0+wUfFLryN9nca1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVPEz7YyqwvT7Jmoec94rxcRRY5AbwRS9V1IgMP/s1Y=;
 b=I2ap6dWHondjhcZPBP4v2wljTrnSKtGucNqBi8YY8kvblPFI9dRzj6uiocIfMwyHdmi3cj6LtDoIwPXlS//Bod6Qf3hJ0ODSeBg+LKJjawQdVxBECso9thftmEtkByl4z8RUgppBU1K//P5aV8yu5pXeSSHXP8whv3+mOfVTj/1J84nIEjA1Ivwy9l15iEh+c3BALHaZLKGHuBhxiGjm1zkspytUFLT+Z84rILADGICLJs+iTVej0RhKYJyUDVyDbYrm0yLJ1soDsvgR1SwEqqpHeDjQ21xsZgnqFmbXnxTCf9+MgoYZgKdr0aQ7C+VB9rpyN6uGH5IhsVZ95mZLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVPEz7YyqwvT7Jmoec94rxcRRY5AbwRS9V1IgMP/s1Y=;
 b=yLv5+SCVGHuezWZ7LwTbkMXlaCE0ch4BI1m48vJYmMel8PHks/cJXkFubHfW+7xeULOfGx/DwCX96ipBra6wsPY5UA46aWR5PeraF4Rz0ILqDAEaasYcQHlzSgCviWCIm5m6mRA9YYIgU0y4Z4ejr+z8D54PfSoQLlMx55cDogg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 04:55:29 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 04:55:28 +0000
Subject: Re: [PATCH v3 3/8] drm/amd/pm: Add arcturus throttler translation
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-3-Graham.Sider@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <a9afed26-9c43-0093-f7b4-b04b9e74f848@amd.com>
Date: Wed, 2 Jun 2021 10:25:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210601181231.24773-3-Graham.Sider@amd.com>
Content-Language: en-US
X-Originating-IP: [117.222.150.66]
X-ClientProxiedBy: PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::25) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (117.222.150.66) by
 PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 04:55:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 409f0e37-2107-43d1-7bd7-08d92582a487
X-MS-TrafficTypeDiagnostic: CH0PR12MB5281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5281C6EC145D035BBF5DB3A8973D9@CH0PR12MB5281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spr/L+h/MFOFhiuz/ZSGtVjjT43nPY2bjBzWInR2buEVbZGxZgaJaBX+YLzuKuhaJwQXER178P/BCGOInL5vJKegiWXbQTt5OkfKo8hsBu6u2j2qagP4I2hdxvtiOqqVFaXBybbfUf24ru1n3gV6+3Yyq8pAtMb2ik6b3l2sGBs0ZP+0fFFHR4TEl8wAdOQL/I43c3PXWZThr3B4mz8AruZJo72HCVTLfoH2p34W72uGBfTpX2PgqcCuX3QcDNK/164/WzUyF3DxwlHb6/VCqmxP/1drbwt6O5DD2+hwoTY4RKRpJHw+O+dLMTLytHbXmlI+/HyakyiAQTQknTU+nVJc/QO84zYux1N7KLG64FpiiShsKB3qdEusey0KTQufRvVjf+17Rx0XXBV20gCqTvgnjZXO0GXs35o2F0lEHxVB+eRp6CuIQzBxLMqgxmb0x1w9Pu6yJn3EmeFriSbrpF/v+bR0NVbz0c59bMxKiFty+8a0yT+uDoCpTtnLACFEMiRnf8g1WE8n5d3t1/3KCVjZoeKO8F/eXQ1CFvXicMOavRce20mJukXvlKh60wdduL75bRfWifK0K9j0/gK79SvlhiMwNVplMccaYaggxM/WGTs6ktA89GFhtpApuG0yjxYH3jQbkwL1YfJynkAvg7rHj+mmDzCPsGG0O77NoQ3RZ1sjUgmj55aGw3cTP1kV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(86362001)(83380400001)(38100700002)(2906002)(4326008)(8676002)(6666004)(16526019)(186003)(316002)(66946007)(31696002)(5660300002)(36756003)(53546011)(6486002)(31686004)(956004)(2616005)(66556008)(66476007)(26005)(16576012)(8936002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1JiYTJ6bTdlOC9RUVVJTHIyb3dZZzhxeVN4bUtmcXNWS0RFOU5ydHlTcjBF?=
 =?utf-8?B?aVVqd2lzZHQrL25EbjJEd0s5Tzc1c2UvMjlEUmdiaWo5MmpZNEZ6N1JuSkRi?=
 =?utf-8?B?azJRODRnUFpjaXpJRXlmL1NSalVHU05rSWllay9JeENYdkhtOHlyRjZGRTFY?=
 =?utf-8?B?TXJYOWhxWFIrdmpoOExwdWRRS2ZCU3cxZk1mREdJdGxZOEN2Tmx4c1BmN1po?=
 =?utf-8?B?a1N5WnhaLytjTEJ3TVJqaTR6aVpLUnJCQ1FPTVlnK0pCOUp3S0xqTW9adnhn?=
 =?utf-8?B?TUpjWUpkMjVINUtJc1dFOEFSWEhsczZSSUplQ2N6STdPMVRJNVQzTkNua2xQ?=
 =?utf-8?B?TkVCTk1PVVBxTHo5OGdRQ3FSM0toNEFwUmRNaXhGVkxlNW5YOGM5SGtnV2xW?=
 =?utf-8?B?N1pXV1d1dGlFWHVQY0RkQkR2Z2F0NWdhZWJ6anNZSnNkc0tDN3ErZmhqcm9z?=
 =?utf-8?B?TVNic2pPYzlrWkxuTlUreTRBV2dXNnp6MVhyZklMbkhnVTNZd2JxOTNJMlZR?=
 =?utf-8?B?bWtxanpBUW5Eem51aE9rMEkreHd3VE9INXNVK1FPOFc4ZUV4QjJ2aDJmVGpi?=
 =?utf-8?B?MnRhQmphbkRSQkVNY1VHdXYxRXNWdDlPUWplc1hnMnNFWHRxQTVPV0Q1QlMv?=
 =?utf-8?B?akd4aUxzZG85OXNqbFJZdVdFU1dRdjBmaUticGVZRzBrWFFjZGQ5OWs4THpL?=
 =?utf-8?B?UkJtZ3RGZDRCM0c3dnVERzZocVJINkdHY2h1Y3pXSE9lbmlYZGQ0NjdyMmNw?=
 =?utf-8?B?amNBdXJLcm1Qa3RFaTJhcGpGVWRFd0Z6dTgvNUhxY0J2UFNkNWhiMG5ZOUdm?=
 =?utf-8?B?TXpxYWFFRGhFYStRYVFqU3ZQZDBDN0Z0N2p3WjdUUDdqYmMxOVRaRHNoK2dG?=
 =?utf-8?B?bEt2ZHlBeXkybEtsWWkxQjZ3ZjZURW1GU2tRS1Rla2tVcmtnSVFXMXlxbm11?=
 =?utf-8?B?ckpSM29mai9XUS8wem5YV3Q2eldOdmh5SEVWeXZYYjFkcjlXZzZOWlhuYXFw?=
 =?utf-8?B?S0l6VmxEOTZFWWFTVjZyR00yTWc3MjViQ21peUwzTlUyZm8vbURsSU9GUDYr?=
 =?utf-8?B?alhpL2ljUlZmRFNDREh5NEhkMlBJYmlXdm4rMGJSSEVnZnI0S0FoRnZ3S1NF?=
 =?utf-8?B?N2hVbzNVRTlzUzNDS3hWdFRXei8rYVhJaE5Ba0dJdmNpMU9aM29jKzc2YytG?=
 =?utf-8?B?MkxlNVJQWERPRW9EdUZoQkxGYUtUTzBMTVhRVkJUZnNad3grbVNOSWVmaWlN?=
 =?utf-8?B?NzhzRDJ6ejdQNGJ6RGZBYWRuMlZkR25LR203dzJMem80MTJ0cVRTOU5ZYVlo?=
 =?utf-8?B?UmFvUGQ0RXZsUmRmalB3UVF1TzZQYzRMM0Z6NEgrSFlpUzd3YXF5SWloQU5p?=
 =?utf-8?B?KzdWQ0diZzFlUnI1VnV4NkhvTmJ2TzlqbTFIazZOU09MZWhCc1JaRjhWNVVJ?=
 =?utf-8?B?MnpDMDFrQkNtTnNwNzFkNE14ajJ0V3N0dktxZEEyYllsQlJGZ1hWSm43NmVC?=
 =?utf-8?B?NkdZTmdtNUlFcEdJSSsvR2FTcG5BNVNoSU5yME5NUU5iV25QeGV1ZDlINVd2?=
 =?utf-8?B?WVBuUmdZeDNqS1dLK1lHLzhTcW5PT2tWRURnanJsU1FQRUU4eGZqSlB5bk1C?=
 =?utf-8?B?MUNrQXNYWDRiTmFNdlVxS3hyeUNTZU1vL3dTV2VLTldrRXVnd0RuVG1ld2l4?=
 =?utf-8?B?dUhaVjdSMk9BQUtyUXlteHE5K2h4TkE0Yitsai9OenROR09EMzZOSnl0UGVQ?=
 =?utf-8?Q?VWF8jJaigbWZ8jJ3gt2HnMYx0Gpb3y8YGXC5Iip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f0e37-2107-43d1-7bd7-08d92582a487
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 04:55:28.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWV6fsJ03PRdSve3YPM1tHvCgKHMTd+FUwQHpUweYxQtucjVRAvK00pOa8KDdq1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
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
Cc: Harish.Kasiviswanathan@amd.com, Elena.Sakhnovitch@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/1/2021 11:42 PM, Graham Sider wrote:
> Perform dependent to independent throttle status translation
> for arcturus. Makes use of lookup table arcturus_throttler_map.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 45 ++++++++++++++++---
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1735a96dd307..c0bfd5634fca 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -211,6 +211,26 @@ static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_
>   	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
>   };
>   
> +static const uint8_t arcturus_throttler_map[] = {
> +	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
> +	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> +	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
> +	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> +	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> +	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
> +	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
> +	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
> +	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
> +	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
> +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> +	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
> +	[THROTTLER_VRHOT0_BIT]		= (SMU_THROTTLER_VRHOT0_BIT),
> +	[THROTTLER_VRHOT1_BIT]		= (SMU_THROTTLER_VRHOT1_BIT),
> +};
> +
>   static int arcturus_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -237,7 +257,7 @@ static int arcturus_tables_init(struct smu_context *smu)
>   		return -ENOMEM;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table) {
>   		kfree(smu_table->metrics_table);
> @@ -540,6 +560,19 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
>   	return (abs(frequency1 - frequency2) <= EPSILON);
>   }
>   
> +static uint64_t arcturus_get_indep_throttler_status(
> +					const unsigned long dep_status)
> +{
> +	uint64_t indep_status = 0;
> +	uint8_t dep_bit = 0;
> +
> +	for_each_set_bit(dep_bit, &dep_status, 32)
> +		indep_status |= smu_u64_throttler_bit(dep_status,
> +			arcturus_throttler_map[dep_bit], dep_bit);
No extra shifts as in smu_u64, this only needs  |= 1ULL << map[dep_bit]. 
Also this logic may be made common (smu_cmn) if the map is passed.

Thanks,
Lijo

> +	return indep_status;
> +}
> +
>   static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>   					 MetricsMember_t member,
>   					 uint32_t *value)
> @@ -2275,8 +2308,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
>   					void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> @@ -2286,7 +2319,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2315,6 +2348,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
>   
>   	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
>   
>   	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
>   
> @@ -2327,7 +2362,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
>   }
>   
>   static const struct pptable_funcs arcturus_ppt_funcs = {
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
