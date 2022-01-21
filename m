Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBE1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 08:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C39F10E98F;
	Fri, 21 Jan 2022 08:52:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC09710E990
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 08:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce/isHrwDJvboSHvNhmTIa5bUecCC2FJ2iZzQd85hQu1S5hfgBL6DaIlpy/WrCMXZPAI6CGtRfVV95+U19Im0Z9IyVMfENOCATRGFChdPuWizTNmsn3dtGyM6Vyov80RhZJ+U+LtVwnR0RlGZsnFP+OGcTOxzIdO6e/zfeg3AET1RJZ0pyMo1Zmk3zpEIx97LnXYwJMw0uAmRRjH71KwIbfbOlxUZb8IJ55S5KaQWBv22V0H8LIL0TzC4eekZbbXLOgzOojZHyTHpZ6XXmgLPvX1qsmEDTZj6rKDvRTu1s4wltdEYDwY53qUCz6VH1W9xsgFtwFvrZI9Mrb+Iq0vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20c6NYWNytoOFrB6Tb+wOsdKbtfbDuUAtuoGTb2NxKs=;
 b=c2CfonUYk4EUaa7nt8cDWOUJ7C11p+RJdYJS7u3ObpGyd0zSrwuCw38pZd5u4LRRvLyu0hUYBLsGrT42+YySNvh/iN/dI8CDwyzIR1Wkcw6MjyNAswKjAV0dnYH7rxcwRjrFas+Ash61AIyivPIkLgsjppVSuzADyhfNEBDCBfS8VaOGNeCgRlkZ2bkyl8Rv7SEHR9lmr0D0z5m9L3OSxDXzF75uoRDVzgk//PNHBhl0/a58s6CDgkx2XO80f1h7CSkPZ3eitEptKQO6Fnp4ua2Af1k1xgYWAL7mjclcvDSYgwceISJK01G3aOi2dLxQSk+/CNe5IrqVtgB0pVSqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20c6NYWNytoOFrB6Tb+wOsdKbtfbDuUAtuoGTb2NxKs=;
 b=rl9CsPRdrhUeGGCWpyimxSGdkxEuCUPNgxjInpZc8xaLIOUYZuAdUcVMsfwWDVJG4t9CAjN/molOUbagD+Sh+97vOSZenZ5YBXVOs0jovkzc3Iew9/PNxS6SZ21E4tyMLkHgdCgV81sCxBu3WVtb89UcagMpVsqkoEu0H+BDGCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2616.namprd12.prod.outlook.com (2603:10b6:a03:66::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 08:52:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 08:52:05 +0000
Message-ID: <76e60a91-c398-3bf7-0e4d-f3c346a3bcf0@amd.com>
Date: Fri, 21 Jan 2022 14:21:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported' member of
 smu_feature structure
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220121074443.639392-1-evan.quan@amd.com>
 <20220121074443.639392-3-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220121074443.639392-3-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::32) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae8a980a-7182-437b-c161-08d9dcbb4c5c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2616:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2616B7400D359EE22EB9B066975B9@BYAPR12MB2616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YspckqCr3ESd+uCsjUB+QAJpmI8mvN40GPQwgi5zhPUPmBnYNGGYLyAf0Zr6Gw8LPt3TvWBKD5MJB2rOCAEmRzwrUEHbn3NQgcqXQiG7QmaArf+ANof8bvfDhq+KO9G9bPfs64xV8zUmignt4XQ/T49NsCz4OsOjR0DMMdBC0w2GX1z92GY5xT2UhE/LNGPMW6SXg58QnrGfOuirVI2WRoBPa3VnQQRh0/UFZdq6J1WETeatonuuAp3MkdW+wyDVN3bpl8zblgyzC5inThMIENRPQ2xk771849L20319n211Y7TEWJhhphzYoq+YWzxuAqZxoBNx28F6JgsGChH6a372zgnKGH5UblcxF8bOErwjOhmHmYx0RC0cQ6FV3xQU7o9GpBZXeJb8DdsyLhc0dcm+3+cBhK/9MuxYvwujMxTMmIaluB84rtOhEhMjxGPmSKFP5Z1cF/+i+H6YTI24t/+u6wifhZ1S03o5PNaoxlrTJH4NmaLfOkHPJ3k1idqhXf/CoTUym5Bdco8ZxlZTx+BYlWhN6YnR5eMJcWGfiWLdnEgfGr4dDdupwt6ejbANP5OYHFaRe64g2cAdgyKC+X6axMsqGU4MOKC/a79Nm1EGd2j11LmDYgcgxA6NlXVGBFMb3Rm/oUy/ph4e8MeXBRGpd2I7Duui2eyhYOPuihHQJpA0JiyUwGPdW7AXheRHDB8Fr7xhxIa9vvLNCgtZV9HrfeS6lNd6d+46vhxVk9BMkvX9ndZh455KhkN4JVZv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8676002)(186003)(66946007)(26005)(66556008)(508600001)(2906002)(6512007)(6506007)(2616005)(53546011)(4326008)(6486002)(38100700002)(30864003)(31696002)(8936002)(316002)(31686004)(5660300002)(86362001)(83380400001)(6666004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWEwRlBoNVBYTHZXalhuR3VEUWZydjkrNHptd1h5NFBBRWtSLzRPTytldklZ?=
 =?utf-8?B?QXh2SjBZdGV2OHk1djJtcVUwZi9hclRoSHVtQmh3bFMxTlpNei9BZGpETm5M?=
 =?utf-8?B?R25KODJabmhLaWNXYWhLUU4wbFcwSWRzZWZkbVFIa041RlVsdzlnMFJGVDlh?=
 =?utf-8?B?Yko0RklQTExibk1rd1cwM1pLVGxwc3FxdVU2Ry9KNVlzV3N6YUhwdHU2ZmVh?=
 =?utf-8?B?ZVp3NmpuYXlRclJ2VmNLRGlIZ2J2dVVpZUY2ZEFOZTV5TkxFL0dGYS9VZ1lq?=
 =?utf-8?B?RlF3ZUdNOWJuTDJsMEZnbmxlaWVmWDJZM3BYbDgxd0VtL2lDa2Y5MFpmaFBs?=
 =?utf-8?B?SHFqdkRlZEFVUlpJclBGd05kVVA1bC9lT1BPWHQxeFEyTnNSelFWa0E4aUxj?=
 =?utf-8?B?eUNZeGxCT0gzNWdsaW8wZFpHUU9iU1FEZ0pKSks4RUp6Q0JadjI4eXVkYkkv?=
 =?utf-8?B?MThMY0dtWTQrMzNRdVhMbXhNNEFLZnNOMXorbi9WeGxMSThYRjMweng4K2Zs?=
 =?utf-8?B?aVBYcTBOUi8rNi92dVdHVFdqbDZCVWQxenZST0tUQmZaOEpsK0tGUHY3dU92?=
 =?utf-8?B?SU5oWkZZMEhjaFUzeDByYXJ6Q3Z4aDFGU2N1REFBRCtPcmZsalR4a0JYalJM?=
 =?utf-8?B?OHlyL0hsZjlSa2ZmYmZUbTgyVXpwemZva2JmK3hJQTRyZzFTUjJoeWJBWS9L?=
 =?utf-8?B?d1ZSYjd6dDlJM3V1d3htMFFSYVVzaS9SanI3YVZjYjB5eUFhczdGWkVFdExt?=
 =?utf-8?B?RjVpS2lmenQ4V20wZjZoYkdIeHRheUNqcFVTMHQ0RW5FWktzS2NZRncxdTRD?=
 =?utf-8?B?elpaV21IZEJxd0F3YnhFYmh2bnpGbG1PRkdsc2YwUElFNlVCdlNyTXlzUG5I?=
 =?utf-8?B?Y2J4ZzFQYUF4VUZoS3E1NElOSHhaTGZueXVIa3dBMnkrZnNiRE40RG9xY2VR?=
 =?utf-8?B?MXo0RXVXVVJmRlpEbXBFbHllT1ltOU1rQWJwejc3T2tkNWQ3eWJONHAzVUYy?=
 =?utf-8?B?MmJYRlNacGNJTW4yY0VCdWNwTW1aSCtwNHNrVnluU1Y2WXBGUmFXcFN1MDFP?=
 =?utf-8?B?ZlVYWVE1YXBoejN4aXN4M21tZ1JkVkYxK1pUM3BteTdmQ0phaC85bUNnUmlQ?=
 =?utf-8?B?ZnRZYldVQXgyZm54Q014SEV5cDIvcTBwU2tUT2tuM3FHZW5EUVhnMjk0OTFo?=
 =?utf-8?B?S0Z6eC9HUHhnUUQ1SmdJbEMwcjdwdjlUUytuT2pGejZ0TnVhNGtKbUQzV3Q0?=
 =?utf-8?B?MmhIc1BHYXYrQURwTEVBa1I2cDM1dFZoakRVd2d0S1c5K2E5eTZ5WDBXekZB?=
 =?utf-8?B?LzE2Unk4T2FHd3IwSkNNVjlhZTVyVHlwcGNpNGZyc1I3elhyQXNGWWVVOWtl?=
 =?utf-8?B?QlhBZGx6c3JvazIzUys5R0ZOV0hrYzcyZlNWZ3BoK0IzMXNRVmZuaisrcEJF?=
 =?utf-8?B?dzF2S1VtR0JaNjI2MHJSdmh2M0RsU0NQT2FoWjNjWFE2L3hPUG12YWJNYnI1?=
 =?utf-8?B?N2w1dGNlMzFnTzBJbkZUek0vK20xalo2R3o2WmdWZnNDWEcvSVg3dkFubzJv?=
 =?utf-8?B?NmcweWwyTkMweXlEL1ExSHcrTGp1dHNGU2xha1FOZG5tQjJaSVJlSlp6RmNV?=
 =?utf-8?B?bW1HR05wWkRjM0hKSzAxbGtyd3ZVWEZzc252d0t2ZW53TkNVbkVpVGRwKzFN?=
 =?utf-8?B?L05xZHdIUE9nc2R6L0w2VHpNK3JKWjBiUzdqUnF5U3lEdnFlS3hvZVJ2YS8x?=
 =?utf-8?B?eGpBeGRzVkdzaWNhczM2QnJHSDdkMlNIRFhjUmVXYWRaZXprTnJmanE0NmUv?=
 =?utf-8?B?ZXlVcGpEZURPc2NRYkFpbUdrZWtxVzJoSEVuMmpwQzQxNENBKzgrZ0ZCRk5S?=
 =?utf-8?B?RE1FVUxWZWFSbUF3L3FGdHFZVE1KbmtVVmk2b1MzSDBUMEoyU2YwZG9CY1BT?=
 =?utf-8?B?cHdtSkhhOGFQRTA5VWVBSnFMTjhFbkt1c1lQdGoza1BJREtiRnQ2NkRpUEZy?=
 =?utf-8?B?RnN0SWNHOUFSeVdwSXliQTNkclFZTGpiSlQzN0JoYjd5SnJacTlRcTMxa0tV?=
 =?utf-8?B?ajhOL0hhNVRMUUVBbUhzc1BBQ1U1QlRHMzVNaklGbzF0R0RML0NWNFFMTG94?=
 =?utf-8?Q?fxG0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8a980a-7182-437b-c161-08d9dcbb4c5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 08:52:05.3090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/yHBksnv+fB39S88ZkCtBuNfTKg+e2vH1u0Wy2Gksmjotdv9NTC5bO5ei3sILgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2616
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/21/2022 1:14 PM, Evan Quan wrote:
> As it has exactly the same value as the 'enabled' member and also do
> the same thing.
> 

I believe the original intention is different. We need to cache the 
features which are really supported by PMFW on that device on init. When 
a request comes through sysfs node for enable/disable of a feature, we 
should check against this and disallow those which are not supported.

Thanks,
Lijo

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 ++++----
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++++++-----------
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 +----
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +----
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 17 -----------------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ---
>   10 files changed, 19 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5ace30434e60..d3237b89f2c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
>   
>   	smu->pool_size = adev->pm.smu_prv_buffer_size;
>   	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
> -	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
>   	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
>   	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 18f24db7d202..3c0360772822 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -388,7 +388,6 @@ struct smu_power_context {
>   struct smu_feature
>   {
>   	uint32_t feature_num;
> -	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
>   	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
>   	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
>   };
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 84834c24a7e9..9fb290f9aaeb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1625,8 +1625,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
>   	int ret = 0;
>   
>   	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
>   		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
>   						  smu->display_config->num_display,
>   						  NULL);
> @@ -1864,13 +1864,13 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
>   	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
>   	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>   		clock_req.clock_type = amd_pp_dcef_clock;
>   		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>   
>   		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
>   		if (!ret) {
> -			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
> +			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
>   				ret = smu_cmn_send_smc_msg_with_param(smu,
>   								  SMU_MSG_SetMinDeepSleepDcefclk,
>   								  min_clocks.dcef_clock_in_sr/100,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 651fe748e423..d568d6137a00 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1281,8 +1281,8 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
>   	int ret = 0;
>   
>   	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
>   #if 0
>   		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
>   						  smu->display_config->num_display,
> @@ -1521,13 +1521,13 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
>   	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
>   	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>   		clock_req.clock_type = amd_pp_dcef_clock;
>   		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>   
>   		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
>   		if (!ret) {
> -			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
> +			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
>   				ret = smu_cmn_send_smc_msg_with_param(smu,
>   								  SMU_MSG_SetMinDeepSleepDcefclk,
>   								  min_clocks.dcef_clock_in_sr/100,
> @@ -3752,7 +3752,7 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
>   	int ret = 0;
>   
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>   		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b58a4c2823c2..b69c2ecc8e25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>   		return ret;
>   
>   	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>   
>   	if (en) {
>   		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> @@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>   
>   		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>   			    feature->feature_num);
> -		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -			    feature->feature_num);
>   	}
>   
>   	return ret;
> @@ -1186,7 +1183,7 @@ smu_v11_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
>   {
>   	int ret = 0;
>   
> -	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> +	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>   		return 0;
>   
>   	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
> @@ -1607,7 +1604,7 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
>   		return false;
>   
>   	/* Arcturus does not support this bit mask */
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT) &&
>   	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
>   		return false;
>   
> @@ -2150,7 +2147,7 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
>   {
>   	int ret = 0;
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_GFX_ULV_BIT))
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
>   
>   	return ret;
> @@ -2162,7 +2159,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
> @@ -2170,7 +2167,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   		}
>   	}
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_UCLK_BIT)) {
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
> @@ -2178,7 +2175,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   		}
>   	}
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_FCLK_BIT)) {
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
> @@ -2186,7 +2183,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   		}
>   	}
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
> @@ -2194,7 +2191,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>   		}
>   	}
>   
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_LCLK_BIT)) {
>   		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
>   		if (ret) {
>   			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index b4a3c9b8b54e..e72831aa4859 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1960,7 +1960,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>   						      RLC_STATUS_OFF, NULL);
>   
>   	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>   
>   	if (!en)
>   		return ret;
> @@ -1971,8 +1970,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>   
>   	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>   		    feature->feature_num);
> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -		    feature->feature_num);
>   
>   	return 0;
>   }
> @@ -1989,7 +1986,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>   		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>   
>   	/* allow message will be sent after enable message on Vangogh*/
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>   			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>   		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
>   		if (ret) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1754a3720179..c5d354175675 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>   		return ret;
>   
>   	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>   
>   	if (en) {
>   		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
> @@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>   
>   		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>   			    feature->feature_num);
> -		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -			    feature->feature_num);
>   	}
>   
>   	return ret;
> @@ -1071,7 +1068,7 @@ smu_v13_0_auto_fan_control(struct smu_context *smu, bool auto_fan_control)
>   {
>   	int ret = 0;
>   
> -	if (!smu_cmn_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
> +	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT))
>   		return 0;
>   
>   	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, auto_fan_control);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index f425827e2361..e9172622c0c4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>   		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
>   
>   	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>   
>   	if (!en)
>   		return ret;
> @@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>   
>   	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>   		    feature->feature_num);
> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -		    feature->feature_num);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 50164ebed1cd..49bcabe9d708 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -476,23 +476,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   	}
>   }
>   
> -int smu_cmn_feature_is_supported(struct smu_context *smu,
> -				 enum smu_feature_mask mask)
> -{
> -	struct smu_feature *feature = &smu->smu_feature;
> -	int feature_id;
> -
> -	feature_id = smu_cmn_to_asic_specific_index(smu,
> -						    CMN2ASIC_MAPPING_FEATURE,
> -						    mask);
> -	if (feature_id < 0)
> -		return 0;
> -
> -	WARN_ON(feature_id > feature->feature_num);
> -
> -	return test_bit(feature_id, feature->supported);
> -}
> -
>   int smu_cmn_feature_is_enabled(struct smu_context *smu,
>   			       enum smu_feature_mask mask)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 4e34c18c6063..19919182260a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -48,9 +48,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   				   enum smu_cmn2asic_mapping_type type,
>   				   uint32_t index);
>   
> -int smu_cmn_feature_is_supported(struct smu_context *smu,
> -				 enum smu_feature_mask mask);
> -
>   int smu_cmn_feature_is_enabled(struct smu_context *smu,
>   			       enum smu_feature_mask mask);
>   
> 
