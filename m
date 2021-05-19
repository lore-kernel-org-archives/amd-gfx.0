Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD335C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A91960D07
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 15:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A91960D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0D96EE03;
	Wed, 19 May 2021 15:44:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E014D6EE03
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 15:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D56DwQAKvSmqJIZbZT0wxg9lgmvRCR7V3wWAX/AcwtdoH8LV6Mygae19e27+Dz76sbBgVtutp6DLMse1a+8Kn4eNUOjvI2TeHsH9AQWp82xTnBT4RH02hjTxfhcDfwZRwS+zYsvZvZ/lCGhPd2p6x38/R6nMGy/QjtQSuCg5i+DWIo252jj9IiEm67/QNGd6AJlY061Z0RP64OppxOhwlTCMJxiau6NoZkpKoQX1bGEj4fgVQSCk1xXuA2IfJjLrlgOL1tvV2PkXj1v5Co1bLdP++NVCms2E32tdo8MI5P59wjtfmlVEMH56UQkNsTY3Ua8+twpaGzVQBVO/lIEzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk3P37cRNggBk3zDFUACCImZz06XzK7ZYTZ2a293VWA=;
 b=Vt7UQoXeCPXvcsN7fv3kNtCbbNdOqVpeAzPo+GfF0xHc0x68JOSny/Un9rbQkKOG8CniV0phapiZNMVX6E3YwejDQjv+SRj0jHErAD8qd31XLBAhTlIiTT7Y5nxqSzVvLZiCaswcNHq0p0/GAkJZe0ZuWV7C24sDM7J0h18bTbRA+fs0IYUblkhCgcabbxte6M69Y0FLQq7XRUq2s20MJ87t1Hz2MsJlV1pjzoDwOVIuZTSoEkhs4UmsHoBAfu5Oy9+FUvEvLBndNXHh0IoYxn7QWcoWyVcGs/zssVsyXwQbBsGZixJ8TuvuwRb0n8UgB32D53k56VpIWS07F4/dYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk3P37cRNggBk3zDFUACCImZz06XzK7ZYTZ2a293VWA=;
 b=JvFZpQGaDI7foFPwluDvHJNW273P03IBgV2pB9rchoMwtlPHawXxSrxwCLeMlnLB6KPEyqeU2POGohcFSaqOrOZLw2PmOYk8IIXCQOhf+Cwxjve2U2ULihFN8C0b5Z/zV/jfhqkZHQ9XHssai9/W9TXcDHqCQvLM0UVVLWwzT1w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 15:44:49 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 15:44:49 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: display vcn pp dpm
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519060233.13597-1-david.nieto@amd.com>
 <20210519060233.13597-3-david.nieto@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <f2710077-6b91-670a-4caa-86e3fa755606@amd.com>
Date: Wed, 19 May 2021 21:14:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519060233.13597-3-david.nieto@amd.com>
Content-Language: en-US
X-Originating-IP: [117.222.149.218]
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (117.222.149.218) by
 PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 19 May 2021 15:44:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b764789f-96f8-468b-5c8a-08d91add0911
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51372EDDAC02C8FCC2FAC5BB972B9@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRdtkKyb95OwJTTATj2YS8ajjLt7J8dV1nOvegr8TUavLLwD9jAE6iabpYWo7AHSuf8VyiG0hmFji7VG6NBZifwKGwLqtYrnvxUO1pkmeC4YJIralRVV4ZVPSc88mFy9Jh53goWbfesaaPRXns0kLHOx+6fOf85a7/tRV+mYATq4zxXlShmxHbP/SvywvWOISPz2OAvKJT0cr8wv3N+cPQ1rekz9H0s3HJMDkgg5Dc7en+0Rz0BL/A50zerLsCt9cNJvlSbSDfMq2WDlUZNdULp3yKvzgr+WUE8y++KV9YugACOpCceXifaUvGl5dzmxbbo1cAk2VU4uw8Et/LVb795T9WHekcvzEP4ICg7G0xje3cdN6E53LV9lGz/GEy3JrHXbC2t9+85u+eVGJ7YL8L8I/ZiyzqFGAJHT/8DT3tmwuqXT2EngM5lIpkkg+YI1NPsbYuNN01NMEXSfO3+BxoIAb2a/lq3CtsRT0RuRhErAtwV/a0oFXtuWXwi9js3BctOVJ7Pj077X6OItHfCTuKfOMhdB+2zYq3KKAL2+hOweXNfh7QiZfmEiAjwqgRFY6QnbFJaw3SzwB79Vn70zn/abx43fgJuw6+ceXoTj4UnEeQM3LHDolO8HYavpn7uoNOU9d+nLIEEn+OMMoVu/fAjGuNOo6DDJurOsM5ul4YsQfG65Lu1whOdibDHMp/mr7NHz8jHfRBFC7dJg1eydbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(38100700002)(38350700002)(478600001)(186003)(316002)(52116002)(956004)(44832011)(2616005)(16526019)(2906002)(53546011)(16576012)(31696002)(5660300002)(26005)(8936002)(66556008)(6486002)(66476007)(8676002)(66946007)(86362001)(6666004)(31686004)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlJNRlV3MjU2UVVnanBHemZGWksySTZ3VG52UFpQdnlTRjJOUkpRdVNsbGMy?=
 =?utf-8?B?SGtPMFlSRXFrNUdTQ2VRL2RwOThqS1pMYWx2NjU3SEF5WDhTTTZaTlVrY2h1?=
 =?utf-8?B?ZEF5eHpyRldzRzVDcjMxNE1DWkFLVHRYVE5FVW5UWEh1bkt0U2dBRkFQWmVt?=
 =?utf-8?B?VkNOL2ZGRjAybURpU2tkSDAzdU9MOHB5TWcvT1hSZFg3SmVqcXdPb1BhcHAr?=
 =?utf-8?B?TWVuL1o4K3VWZ0tnYVJkbnk4SDJDS3JsS3ZKQTlVaFRQYW5JdlBFWitTaGtw?=
 =?utf-8?B?QmNSNTFUZ3c0S2tpT25reURXMHBoYk9VcGM5TWovMUt2NXdyclMwaEhSU0pZ?=
 =?utf-8?B?UkU0TTg3WWk3WjJNZkxERjgrd2JJeGx2dFNWU0xxeDkvRER1UzkzRzgrOHBn?=
 =?utf-8?B?NWE1dkx3ZmpmRkdtTHdvNUhxTVdJa2toMlZvZG1KL3ByK1laSDhzMUUwbHVu?=
 =?utf-8?B?SEFUV256Q2xSTU5MS29XNE13TzFRYTJ0d0RydjNkUHorTVBsMHJaa1RTTkl2?=
 =?utf-8?B?cS9SYkhaRXpkS042SEhYZzBnTHp6NEh4dmFDRURTc3pYQmRSVGY5ZVVnbGhk?=
 =?utf-8?B?Q1JzSjVNSkthcm1ZTUdwY2pQSEpLR3ZKcnZvTSswWTlEd2x4TzNtU2laMTdv?=
 =?utf-8?B?UFN1K25EQXNIS3NmMnRMa2RoYktBUSs3YnVQOGQ3aVkrdWZWWEpUcjZzcFhP?=
 =?utf-8?B?NHdRTGlHTCtHMWpoVXlrKzNLRm4zbXBjL0wyeHIwNVVlN1MyaTg4TE94K1cy?=
 =?utf-8?B?T3NpMm5CeEgyYmFUTllMV2RiTGNVYmZGWVdwYnpBbUNYV3NDaEhKOVlwTm4v?=
 =?utf-8?B?cWwySjJyMHRrbGZSdkVjN0orQ2kxN1BoRE1QclNCd0lsdisxS2sweDBEK1ht?=
 =?utf-8?B?N3gwNXY4MlRIUm1tZG1vVDFQRHRic3NaS1BlbXlJeElKMjA2MjcwSXRWblhy?=
 =?utf-8?B?NkNKMkVNUnpGOE9BNUozZnBjOGhySVJWMGw5TGkxcllKQW1KQmlKMkcxalRE?=
 =?utf-8?B?dWlZUnZsQ0ZQbDdQQ3ZsUC84dFdrWmNjSGd0cnNvMVQ0MUNYZ05hZ0hxMTdT?=
 =?utf-8?B?WFh4M3Z4NGFrQmRNeXl6MEc0Nk5HQ1gvKyszMjQyQ3dnMFRkaDZBWm5nc05B?=
 =?utf-8?B?VzVtYkk0alVPaVVMSElyOGJHN2I3UFl2bXpIdHhXMTliTmp0TmdzZFkrdzVt?=
 =?utf-8?B?M0w4bktiTlE5a1dISHJLSnNHaXJScTRHTlcyZFA1NkN4aVA4bVNQMnBiTkpx?=
 =?utf-8?B?TE0yZVA3bkg0aDRHcVp4dnVGTWxncXpEeW9PS1hpUHJMUjlyZjBhWU5TK2Qx?=
 =?utf-8?B?TEhyOUdaZkpCcmlOZ1BnbkdIY3FsU1lhZDQyeW9QM2t5Zy9aOEp5MDZkeFlD?=
 =?utf-8?B?cGhXOHpEZW1yV1FZMlBHRUNUNkRZaEtLM25VS1N3aGMyaXQ1TVZ2b3VGQWFG?=
 =?utf-8?B?endJWHI5NHVJTEpoL1VwZ1hjWkUrYy92K3l5NzZWMnJTRjA4REVHVkVaOTFp?=
 =?utf-8?B?a3RHQnBIZ2cwNGk0aVFrM1VGWlJIVjB5bEF2cVc5TXlzZndCSThyZ2d2WTQ1?=
 =?utf-8?B?YTBnZ2FSVGRVUURjd0tlR3hoZDZsZk16ZXpESUFEeHowTDVDUjRTNGp1cVgy?=
 =?utf-8?B?Y0lhYitseGgvMjgyUmVETTlrSGxrLzVSaGErTFdqUmxVNlVzWXNZa0xNUk1L?=
 =?utf-8?B?MG1kd3JqVWw4ZnpaNzdYWXFGamlyRXRJVzRrQ1JDaDFPbUVxcTd0OTMyYmhT?=
 =?utf-8?Q?3ddUvrkCsQDT4EYdiFOx2zdoqgKP7GJGQRSDgyK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b764789f-96f8-468b-5c8a-08d91add0911
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 15:44:49.3008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GmqMeurE44CK2JbhHdLoA58X6EYdYdRIqtn1YD6iOao7upX1NyFMhHQJm5t3bP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
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


Avoid changes to sienna_cichlid_force_clk_levels as well.
With that addressed patch is

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/19/2021 11:32 AM, David M Nieto wrote:
> Enable displaying DPM levels for VCN clocks
> in swsmu supported ASICs
> 
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 +++++++++++++++++++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  8 ++++
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 34 ++++++++++++++
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 46 +++++++++++++++++++
>   5 files changed, 136 insertions(+)
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
> index b8971303a873..7763de464678 100644
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
> index f43b4c623685..0805dc439572 100644
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
> @@ -532,6 +545,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
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
> @@ -543,6 +564,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   	case SMU_MCLK:
>   	case SMU_DCEFCLK:
>   	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
>   		for (i = 0; i < count; i++) {
>   			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
>   			if (ret)
> @@ -730,6 +753,17 @@ static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks
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
> index 7c191a5d6db9..fb744f3e17d7 100644
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
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
