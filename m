Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810D1C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4495460232
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4495460232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DE76E1E0;
	Wed, 19 May 2021 05:44:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1A06E1E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 05:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI6JD5L1RLrVs7VLZaSIH8j0ZrkfuSAwDkuhOL9JhXYyeKH22IN8bot8DXS1ppOlUOuai1gTVAWYhCgyHaru7hfhbNUodKd9dnasc45lZUDX7TfGUDmM3r9wVC7+jLaPJYYBv39vL2F6LVhBBHwXqnFzBpZ5hUcgakNjZy6xDeGvVVQzV4Mo7ts5ANbafuHzXOgPWzKFcQCiJ8b2KNylQ/VDu25qtsB+xnm+vlQYynUOvpgbUzdFI80nRxMiX091IMj423GqBq1C9RTTyZ9o9ejMywIK6uexBvUo2dxI8r7DIzTMCPoZcLYE3xxm8J1IkYT9H5F9pKW7HFyQYMLtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW0i7syawY1s7Q7D+XXHA7t997neJJTUTCbTi6Jmj/s=;
 b=Z6LOLqMwfY7rxqkhTspncIK+/FV6WiphVkUItq4JXaaEsX1EENYGHznquyTvmdai25EBuMHn5XPpBn48jbfHh3P9P39EW0OPbGUaybITzbQNkRAK+dNQOGgog+TuDHYnNtbbXpppPqVfRF2SEqLD43YxTzCo//q+SZVd1blkpNyEc3IMNzXCgXqMxNXr6Pp7akWaEVYNsaY18hAnR6MGXA5uFrk0YB7e7h7A5aAMaoSwCZKyvU2HKTKm50SOlSMUrm+B6vW9rw/Vt/G8EtagSD1LShseStSw+m+0FblcNEfjGGjiBl7lzTsiFtfSG+Z8Zcvkc5X86aBoh07B80yg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW0i7syawY1s7Q7D+XXHA7t997neJJTUTCbTi6Jmj/s=;
 b=xXareUy0j+HKMIpQ3Q0dCbFhR+z+TBSV/xw5QcKRESh1EBTdgpAXNVViFMN0EJF0Uw8a6CRi9R+3mh/hr0+zMlwYl6WR2OjFOA55lHyNGDA+q/7eWm/wGUB94NUJwm+agowNx4IZFyLxsehmHltPNWsVy9QNetpYYKhjSqO9zLQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 05:44:36 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 05:44:36 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: display vcn pp dpm
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <20210518040957.23266-1-david.nieto@amd.com>
 <20210518040957.23266-3-david.nieto@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
Date: Wed, 19 May 2021 11:13:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210518040957.23266-3-david.nieto@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MA1PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::27) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.156.106] (165.204.158.249) by
 MA1PR01CA0133.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 05:44:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff1016f-2b15-4484-1c02-08d91a892fe2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51058CCBD7B34E5566B37339972B9@CH0PR12MB5105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZbVQJu7XQDDp+9f4cbQOHyMPfJKjjJR3tO9/GJNaHrSH/P7QgBZ7SEqmAYBSSB5UYdbPRRGJGYryl9wmDl1vJW5lTBNAzO9f5rSwW5xlaadLrygArGOe2xT35XlTWDGu2scl1axyYPmII7xERusZK+/XF3lSWDmNx178KocE0sPRZFsYOmo+66EEnk2QoSDPQPObkJeMPG5zpz8BliPjRYvrUg6atNDya/GUWa5b6Wsj14KlwRHDpj4krPLSPxrMvcC+4yXNYNAw8PpxNMe9VTC9WvF+mnBnkeuuLs+GBsUjRI6pwf2bx2CADQ84hXLjwzrv9xuLNip29I/MXlWSN3hnSQOCdx7EHLRg7RLkplCWz6xohl14vN/3KQU/Wn1ON0yBARSI/RlypHPJifBBi/uCo6oscpYl/L1jk2ggvEKFP254L70o5jRsb2xcR6aexUc5CwdsoBxrPLaLI9H/5K772N9ISOXTFGShkTSbMdrRop1OwdjzJmO02ZMe+VfeB8LU70RSRoqDSjKFBiVseGXhBTXXC2ujd2ASbN4cDfvEwbzwE8+E+SsLMNI4s2GjwJLZH65+rU7KGDqIdvMq1F/QQMW+GmnNxutKm85aoWYzHlohNhouus3+X35r2BVfAzD++vjPWYnbz8bvEf70fjSt1NbYTJNaPrkcpUdjB1I0xxQD7KYuZg9h9ZoOqDqyyDdGPuaQ65AbtddZENvtJt6D6opRP+dmAWCiUi06yo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(31686004)(8936002)(83380400001)(36756003)(316002)(8676002)(16576012)(5660300002)(2906002)(38100700002)(16526019)(44832011)(31696002)(53546011)(66556008)(38350700002)(186003)(66946007)(86362001)(478600001)(66476007)(2616005)(6666004)(52116002)(956004)(26005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDJjMGluYlZGL29EakNTR1d0OU9Kd0xER3FXU2hidVVBdCtyOXRJRDZVVlFv?=
 =?utf-8?B?K1VDaHdGYmRGREpINkRxM3NXNTVsWkVpN1ByVGxzaGlqVTd0U0x0aWpwSDNR?=
 =?utf-8?B?UnVyNTVQbm5NcCtPSGRseWYyMTI1WkJtVlVmaEpWWll1STlab1FpcmNaNDF5?=
 =?utf-8?B?cmpOTTk1bGVZakFzanVHOGtkS1l2WlpCQS8yUEYzMU91ZEZOTXcrdmZNdjU4?=
 =?utf-8?B?QU9UWGk0VHdtNjhxa3NSRDF6OXppeitqMndKWEZXTGM1bnM3ckFsckNyY2Jm?=
 =?utf-8?B?T0JmTlFOaUlvUjcyUkhwSTZVQXduTHZ5alZSN0crUmlEaDl4Q3JLVG5PQXI0?=
 =?utf-8?B?cDJmUUljeTk5cDBEZUN1OG12Q2hONTJVV2xDeEVVbXBJZ0hucU5VemJyZmdx?=
 =?utf-8?B?OFErV291UmQ1aVpJT1pxU2wyWXhaY0Nic0xmMnBuTllXME40UnZqMzYzOGFW?=
 =?utf-8?B?TTB3TlA5SFhPWVJJWW1wcDY5MmJLdnozOUcwQm96dTFDUUw3ZkNvYWVobzBF?=
 =?utf-8?B?a1h3SzQxUWpnTnpjNkczV1pqbkpCVVovOWdYcmxQc3hFaUgxMkxILzQ2dEho?=
 =?utf-8?B?WW1hUko0dHEyZ1lNdWNCaS9Qdmx3NG51T01kVGVVbjYxdVZ3RGFXWXpWMGMr?=
 =?utf-8?B?alRPZGsrKzVFeVNWOVpRM21EcER5RlFXRis4dm1SbExXNGJTUnptcmgwa1A3?=
 =?utf-8?B?Q2xMWXlBNU9uRUdLYUt1bFI2cWFkdHdNeklWcVFjaFJ6aCt3dHZqMC8xWjM4?=
 =?utf-8?B?VlR2d1FhNXRTTFRTN2VHWnVQU1NKcnVMV3FhamNUcEpMTDFkbGdhU25qZXlP?=
 =?utf-8?B?djREOGxnZ3F6WDF0bi9neW0xZEszd0dUVHFJSmsrR09VSHllS2J1MDVGNUNr?=
 =?utf-8?B?dUVYTWhBZkNYa2tIODBGQU1vMS94L083K2w5bjEyNGlOTGErbFZIbGRDZ3lq?=
 =?utf-8?B?VVU5Zm82U0I0NFh5T1pzczZGaXl1SGk2c0Q0VmMxQnRNc3Q0ZWJISU0zL0ZQ?=
 =?utf-8?B?UlIzMjB3eml0Vi9qemQ3WVVwQUNnL0xKQU13ejA0N21rdGs4ZzVZUVVSMjlM?=
 =?utf-8?B?TFA2dGw0ZEVzcjVqcm1DYlc5citpR1BHSG84MG1KaFRoTXc4NVlZb29yYXFU?=
 =?utf-8?B?RnYxeFN0M2h2UEhPaG9zcXpZVUtOQWEzeDU2aEp6VThrd0VDTW9xZ1FHQ0t5?=
 =?utf-8?B?bGQ2djNrRjUyU0ZzQnQ4L0J2d0Y2cGNzSXo2Vk9VbWprUVJBVlZRUGdVWkh2?=
 =?utf-8?B?TGtQejM2cHlnUXhCTXpVYVRQdmw1eFg1OUtmVjBQQm51TUZQdlNTL0dDWGoy?=
 =?utf-8?B?RXpUL05BQkY3bW11VzlldENrdDhlbTNvUWlUVzZxcUNHUTVYV3dTTE42QzB4?=
 =?utf-8?B?U1pFVi85RlJiVVd0V3MrODhYdTRzU2VuSkFleVhRNkRwVW54MWkxWFBFd3lJ?=
 =?utf-8?B?eUZGelZXTnQ4VGR3cEVQMk9iYWRibEVsdXJOV29BQ0pZWXo1bWlOdS9yS3o5?=
 =?utf-8?B?VS9McmpLRmwvUTNFMERFTFY4SjIrYlU1UWhYR3BINUY5UlViNWtldlR2SW11?=
 =?utf-8?B?MnlreStjNFhUbnZ6bnc5ZWFsaUF6d0taaVR3OU51a0lkRlFURFJyUUludUlq?=
 =?utf-8?B?T05Pa05pa2M0czBPL3E2cUpEcENwZ253U3I4LzR4amFZM2VFUU9xVDNiRzBV?=
 =?utf-8?B?bVZRdDBCUkl6a3VwR0J2YkFRanJkV3JHbjNldXo5ZlJQS1dzQ09PVlZvTTht?=
 =?utf-8?Q?F3OkAkGGd1Iup8mabJO9h81ICwMMNnU01Wm5yVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff1016f-2b15-4484-1c02-08d91a892fe2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:44:36.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kjvhxZnneB8SnC5iKb+L8qLtuQVrVxjGne1IRjR1WPeaV3LONML4AQoHItM/bKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/18/2021 9:39 AM, David M Nieto wrote:
> Enable displaying DPM levels for VCN clocks
> in swsmu supported ASICs
> 
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 ++++++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  4 ++
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  8 ++++
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 38 +++++++++++++++
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 48 +++++++++++++++++++
>   5 files changed, 144 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 77693bf0840c..1735a96dd307 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -822,6 +822,52 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>   				now) ? "*" : ""));
>   		break;
>   
> +	case SMU_VCLK:
> +		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
> +			return ret;
> +		}
> +
> +		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
> +		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
> +			return ret;
> +		}
> +
> +		for (i = 0; i < single_dpm_table->count; i++)
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
> +				i, single_dpm_table->dpm_levels[i].value,
> +				(clocks.num_levels == 1) ? "*" :
> +				(arcturus_freqs_in_same_level(
> +				clocks.data[i].clocks_in_khz / 1000,
> +				now) ? "*" : ""));
> +		break;
> +
> +	case SMU_DCLK:
> +		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
> +			return ret;
> +		}
> +
> +		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
> +		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
> +			return ret;
> +		}
> +
> +		for (i = 0; i < single_dpm_table->count; i++)
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
> +				i, single_dpm_table->dpm_levels[i].value,
> +				(clocks.num_levels == 1) ? "*" :
> +				(arcturus_freqs_in_same_level(
> +				clocks.data[i].clocks_in_khz / 1000,
> +				now) ? "*" : ""));
> +		break;
> +
>   	case SMU_PCIE:
>   		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
>   		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 9339fd24ae8c..2e801f2e42a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1273,6 +1273,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_UCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
>   	case SMU_DCEFCLK:
>   		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
>   		if (ret)
> @@ -1444,6 +1446,8 @@ static int navi10_force_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_UCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:

This is related to forcing clock levels, commit messages only mentions 
about display. Skip this or modify commit message accordingly.

>   		/* There is only 2 levels for fine grained DPM */
>   		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
>   			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 0c40a54c46d7..6da6d08d8858 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -987,6 +987,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_UCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_VCLK1:
> +	case SMU_DCLK:
> +	case SMU_DCLK1:
>   	case SMU_DCEFCLK:
>   		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
>   		if (ret)
> @@ -1150,6 +1154,10 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_UCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_VCLK1:
> +	case SMU_DCLK:
> +	case SMU_DCLK1:
>   		/* There is only 2 levels for fine grained DPM */
>   		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
>   			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index f43b4c623685..3a6b52b7b647 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -109,6 +109,8 @@ static struct cmn2asic_mapping renoir_clk_map[SMU_CLK_COUNT] = {
>   	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
>   	CLK_MAP(UCLK, CLOCK_FCLK),
>   	CLK_MAP(MCLK, CLOCK_FCLK),
> +	CLK_MAP(VCLK, CLOCK_VCLK),
> +	CLK_MAP(DCLK, CLOCK_DCLK),
>   };
>   
>   static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
> @@ -202,6 +204,17 @@ static int renoir_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type
>   			return -EINVAL;
>   		*freq = clk_table->FClocks[dpm_level].Freq;
>   		break;
> +	case SMU_VCLK:
> +		if (dpm_level >= NUM_VCN_DPM_LEVELS)
> +			return -EINVAL;
> +		*freq = clk_table->VClocks[dpm_level].Freq;
> +		break;
> +	case SMU_DCLK:
> +		if (dpm_level >= NUM_VCN_DPM_LEVELS)
> +			return -EINVAL;
> +		*freq = clk_table->DClocks[dpm_level].Freq;
> +		break;
> +
>   	default:
>   		return -EINVAL;
>   	}
> @@ -296,6 +309,8 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
>   		case SMU_UCLK:
>   		case SMU_FCLK:
>   		case SMU_MCLK:
> +		case SMU_VCLK:
> +		case SMU_DCLK:
>   			ret = renoir_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);

Please double check if this is the right place for V/D clocks. mclk_mask 
says this is related to memory clock values only.

>   			if (ret)
>   				goto failed;
> @@ -324,6 +339,8 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
>   		case SMU_UCLK:
>   		case SMU_FCLK:
>   		case SMU_MCLK:
> +		case SMU_DCLK:
> +		case SMU_VCLK:
>   			ret = renoir_get_dpm_clk_limited(smu, clk_type, NUM_MEMCLK_DPM_LEVELS - 1, min);

Please double check if this is the right place for V/D clocks. 
NUM_MEMCLK_DPM_LEVELS says this is related to memory clock values only.

>   			if (ret)
>   				goto failed;
> @@ -532,6 +549,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   		count = NUM_FCLK_DPM_LEVELS;
>   		cur_value = metrics.ClockFrequency[CLOCK_FCLK];
>   		break;
> +	case SMU_VCLK:
> +		count = NUM_VCN_DPM_LEVELS;
> +		cur_value = metrics.ClockFrequency[CLOCK_VCLK];
> +		break;
> +	case SMU_DCLK:
> +		count = NUM_VCN_DPM_LEVELS;
> +		cur_value = metrics.ClockFrequency[CLOCK_DCLK];
> +		break;
>   	default:
>   		break;
>   	}
> @@ -543,6 +568,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_DCEFCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
>   		for (i = 0; i < count; i++) {
>   			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
>   			if (ret)
> @@ -730,6 +757,17 @@ static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks
>   		clock_table->MemClocks[i].Vol = table->MemClocks[i].Vol;
>   	}
>   
> +	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
> +		clock_table->VClocks[i].Freq = table->VClocks[i].Freq;
> +		clock_table->VClocks[i].Vol = table->VClocks[i].Vol;
> +	}
> +
> +	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
> +		clock_table->DClocks[i].Freq = table->DClocks[i].Freq;
> +		clock_table->DClocks[i].Vol = table->DClocks[i].Vol;
> +	}
> +
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 7c191a5d6db9..bc628326776c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -816,6 +816,52 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   								       now) ? "*" : ""));
>   		break;
>   
> +	case SMU_VCLK:
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
> +			return ret;
> +		}
> +
> +		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
> +		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
> +			return ret;
> +		}
> +
> +		for (i = 0; i < single_dpm_table->count; i++)
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
> +					i, single_dpm_table->dpm_levels[i].value,
> +					(clocks.num_levels == 1) ? "*" :
> +					(aldebaran_freqs_in_same_level(
> +								       clocks.data[i].clocks_in_khz / 1000,
> +								       now) ? "*" : ""));
> +		break;
> +
> +	case SMU_DCLK:
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
> +			return ret;
> +		}
> +
> +		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
> +		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> +		if (ret) {
> +			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
> +			return ret;
> +		}
> +
> +		for (i = 0; i < single_dpm_table->count; i++)
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
> +					i, single_dpm_table->dpm_levels[i].value,
> +					(clocks.num_levels == 1) ? "*" :
> +					(aldebaran_freqs_in_same_level(
> +								       clocks.data[i].clocks_in_khz / 1000,
> +								       now) ? "*" : ""));
> +		break;
> +
>   	default:
>   		break;
>   	}
> @@ -920,6 +966,8 @@ static int aldebaran_force_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_SOCCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:

V/D Clock forcing is not applicable on Aldebaran. No need to add 
anything here.

>   		/*
>   		 * Should not arrive here since aldebaran does not
>   		 * support mclk/socclk/fclk softmin/softmax settings
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
