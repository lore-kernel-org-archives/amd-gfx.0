Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0A2C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 17:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C1110E0CA;
	Thu, 23 Mar 2023 17:15:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A248910E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 17:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bda3SH5wgq+bFsJ6n1yX9KPb/yRG9WzaP/dczuG9aaV78FElIH7JBnb1No/adDZ+dtq1K9G8EWwXt3DHp2GBLa98cGH60vTDxvsAtFzfogfzhU+y2WppoirBNC1VXjuJYUli/Fpj97uhXkR99jmw3BHwxRe6x34wek5nrLWGXhdzran60VU649SqFdiaU3CpLSyN1L9JNFu1blQCEbvsRKuOCZHTTXOZEPgF9deBArEqPXpW1aoiI+xR3qxlOR3Cj+uK0kP0/NqNRuVO2YUmd2Gvi03YhBYKVdljDg+ahANr6hBsDSXCJsUct6Lu4DrKsbN/VJy5z1avsNejpvUhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgSLDg3dmotMvdeyAwgZqzeJjuzuZzka8+DrrOdo8FQ=;
 b=FsC005CvZjeeDJxHon5uwkiw8eMSefat4crW+WmkGLfv9ASA8GMlX+dZQKPh4AEkEMZiu0VdZYFWE59zjMP4kz1TgnOsszViZWasv4nAhwlpxvMiwuAIgmAjPcavzbjWnVxUhb6rryJktQKrd+TWoMcQYKAJMZqLuMeknpxjLpOAFszLNGrO7BN9fpe99ZW9Lzc32sfEa6w4TfTIeMCWDeX7wHDxRl7QrB+z/dgUii4jwxKF7fQl1MkCZs1vpX8UO2dcp8f60CB8tER0MemM7uNt30Xg+Tz12vKoA4h6ygHR4wbK6/ut0puqjYpPzCMNfiqwmEW76zoh6cJ4wjuI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgSLDg3dmotMvdeyAwgZqzeJjuzuZzka8+DrrOdo8FQ=;
 b=Hc732Gpp5XQIq1FPEJJ5DwigO2B90uKvxAeiQ9XKMXZxvuFTsMb1doniNo7Rn//bnJmtdnAhDTTZHGKn3wzzZj9JNVZCrKswK0PMCuY22OJUVh/1FcHwbynikD8BKs32jVDNElMljzsGm/tiy4tpOD3zRg2Mxe62uvsw2BOklL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Thu, 23 Mar
 2023 17:14:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 17:14:58 +0000
Message-ID: <bc2d087d-c627-fa0d-7b4e-da3b763f8cff@amd.com>
Date: Thu, 23 Mar 2023 12:14:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [v1,3/3] drm/amd/pm: vangogh: support to send SMT enable message
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230322054808.1555230-4-WenYou.Yang@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230322054808.1555230-4-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:610:118::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d724be-a117-40db-5e2b-08db2bc22101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zVLpbLkrGXLJeuX2T3a3EO4MweEZuwbqYIviNdgr+se5uJjJGs8EQcKfjjBHLi7ugqsw9E+jaIDA1HR5VsJeTq//GUgtGOpUIIK8jjtCll1dn+z6RBv/KYaXS55DCM+Q0VWo6Wi96xXGttRhCDi29PV0fwGFoYeIys4GK7vx2qNhUMWFCbJ06Csjv4DSlbKITiEbhpt6366ovr/D78fsw051/P78OjLFR0xNIM5DmcXZrh46ru8aiEambYTM4tMJsxEvRpa2bxQ2MuNPWrlx2r6sQdbCsb51KNlPbBA+p0cJl51vL4OOY+eM1bzAqW88h8gm3/JBfi2M+hdqD7JiHjMLZ85//DEaV/jT1fz2+3wBiDwn6AUQiH/9XsVi2yRW61lt1BLS1jsN28eMEdDaH+n4ibrP7ZrnB68xbAFqWPqclspHGuy/tFbjW7bGVRHmgE6yoXSCb4Us/wF+ePERb6NowojVUR1GKTtKi7YX7NIx7wJS833NYd7pbr8+L7Wph4wNR/L0z2xUq6T6K+GBmRiOVuSAHOOJM5W9zr0mw1/h7WuDXJ6KFGrtaAojNZrsraXf4SMRLDAYb/RddSsXkVwAZySuGdOjlfEAEzQVh0MhYVSutZavO/3a/dpifHvW5PHePR+bjJh2dFJqT8mqDrBPoiF1T8hNLB68Zm3q6pdvcZVKTC+xLBErceGVaihL8SHXSmSE8Ul7gT96Vdh0iAgkoaW5IRE5cVZ3ftvcmxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(8936002)(5660300002)(2906002)(4326008)(8676002)(15650500001)(66946007)(316002)(31686004)(6636002)(478600001)(66476007)(6666004)(6512007)(53546011)(6506007)(6486002)(26005)(66556008)(2616005)(41300700001)(83380400001)(36756003)(186003)(86362001)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmgrRGRqZDFsa2NURnNES3BOeUk3QXBRbUhpVXpHMWd5N1lEanJkU0p1MWlp?=
 =?utf-8?B?VGFxVWE2Wk9vTVBRQ3RTR2xBcXRnSmgzRkhqcHV3OStlenB2eTRKTG03Y2ln?=
 =?utf-8?B?aHBYbkxpYVZNZk1raEQwSGg2bDFaQW5FbjBnM0o2RWY5d1pWdXZ3ZGVYNXNO?=
 =?utf-8?B?SWE3djA4WDc3dTI4d2wwMzUrVTVzbHM4eXYxS1FzQmtXNHN6ZXQxN0hDYnVY?=
 =?utf-8?B?SENGcFJqeFZsYWdCRHg5cURheUZZeWMyQTFRK3QyTzh4dnhYRC9VKzgwVVov?=
 =?utf-8?B?RkFiSjJ3RS9oODdZa09ISmc1Ly8xZ2pqdnh3WTR0Q2RzZE1SenUxVGpRTTNV?=
 =?utf-8?B?ZUc2Z2JieXBvaytCdngzK1ZvYVdXb3hRazVYbG0vTGY3MzVsVGlwcUVvbjZF?=
 =?utf-8?B?ZlQ5WjU4SjR1TFZ1MENmZ3EzT0tQTlFJem0wSXJJUFc0L3JzbmNUdnd0OXdX?=
 =?utf-8?B?MXVLQi9BSkQ5Nm5DSlFNZmVndFlIS3FodkxaeVpxWXBZTW5vYWhsUGkzZC91?=
 =?utf-8?B?NFhyaExVTUduWmxLNXptU1JRd2JYKzhxSUFNZjNOUXo5L1Z5dFRDM0NyZERU?=
 =?utf-8?B?cGIzM0s1YkVpc0VHcmQ2VTVseWF0Skh6UEpoMHNrSWtuUWhYWGtqNE90MVIv?=
 =?utf-8?B?ajhZTzlUTlVBaXkrU0hCWnNxMVBudEkyMXJWYVZsVmdQb3k3M0hSRFUySy9o?=
 =?utf-8?B?MUxyaklrZERmTzA5SHlwSjl4Zk4zYmt2VkRWVjRZZUJZUVA4L04rUXF0RU1I?=
 =?utf-8?B?UlVoSzJFMVo2U3BxU3YxWTRaMzFEclJQTElJV3JXSjhJUUowMkFQbDQxeTlx?=
 =?utf-8?B?WVR1b1M0OWYxY2tKL00zVHZ5SW9zQVRRT1M2bnBOaE9vckp1Z0gzNDlYelI1?=
 =?utf-8?B?NHU3d0RaQS9PWlZIN1RJeGFzd1dSc2t1QVMraUZoSUpaKzArTWxaR0xmblNp?=
 =?utf-8?B?ZWZYT3hvKzV2cVpkVW14MXNoN2pDN2loczRiNkFMbGRGZ3VaWlcrRGVpU0xF?=
 =?utf-8?B?WkQrZ0ZHbmNWaTZaUDdSRFZkdEoySVdzRXA1TFo4QU5sMkdJL2FSR1RJdkZL?=
 =?utf-8?B?SHlFUUFkakhvOTllL2tQR2FtM2JzdU1CZXNTaHlXVHRtRlgzTFAxcjdITWM0?=
 =?utf-8?B?ckNpZFNPM2hCTXhhWVcwS3FpRW9NeUtYdWR4aXNtMmxlMWF4dkRWVUlibXZ5?=
 =?utf-8?B?QUZGU0ZhRDg0K2hNamtyUFVnV0k1M0ZmaUNFUjVJdWhWOEljVG9KRElmamNa?=
 =?utf-8?B?dk5tT1hUN1A0NFNZdEw4ZC9RemNGMUJoVWg4SGxyT3A0d1hSOWIyZFJDeDRz?=
 =?utf-8?B?a2dmaEh4bVlQZW9yN3ZOR3M4c1dkMWRNTGZSRjQ1R1p0bVh4THdqQUR1dDZj?=
 =?utf-8?B?QkQ5T203ejYvTGZwdGxmZlM3bHhLRmlCdHpiU1BycGZ5Q0xqZzVGQ1NHN2Uy?=
 =?utf-8?B?OHF6cEVDY1pCZWdrVEN2VGFGalN0aVFyK1ovVkRhZEI2aTVpVWg2NytsaS9Z?=
 =?utf-8?B?QmE3dFFXczdqVXlSSWp6bjlER05zbkZkMnM0WURUOU5TWUU2QXliVGFOWnpk?=
 =?utf-8?B?cDE3K1R5WTZ4TkIwOFR1VkJ0TmNXTkhRakl6K2Zmc0FWSmorRHpNRXZNTVY0?=
 =?utf-8?B?QmY4cUVIRGdjMWxFVi9rNEdLcmVlSTBVYmJBS1lwL01NSHlONmtSeFczT0E5?=
 =?utf-8?B?NklBZjUxaDQ4ejQwK1U0Y2NTVkR4Mnk0cGpuK1Ava0VSM2JEU2xMbWtCUjcv?=
 =?utf-8?B?OUZZU20zTEg4WjJ3Y2lkQk1LblJZVy9HanE1UjNlbUsyVXlUYVcwUUt6UURx?=
 =?utf-8?B?S2NaeUV0R251ek0zTGdHVkZrcUdqUEVGTXlGTG0yNGFsem5mR1BrR0k5YzJj?=
 =?utf-8?B?RDNvWkhlWHQvOWo2Ym9BdzNGZEptaUVJL0x0UlltSlBNQzY0NEwxMm5taWN0?=
 =?utf-8?B?K1RQKytwTFVPcjY4Z3JHMnBST1FQRnpDaXgxT2lEQWg3WWJWZGFFd1JGc0Iv?=
 =?utf-8?B?Z1FSWW44bVJHVXBnUWZ3N1NJcUpvQjN4d0dFeHorY2JkMFJoY2JGQWJ6VVhq?=
 =?utf-8?B?Ymo5Z0puUmpLWEVVWkEwUGtXK0lNR1JIeWxjc1ZWL1NBeUVDS05IMXNSbGE5?=
 =?utf-8?Q?01FbYUm0KidrLKczsOgIurLsN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d724be-a117-40db-5e2b-08db2bc22101
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 17:14:58.2319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w2CuHoNWfvCyX/7OuQnNfsva1teRRfXLlnTqIE7dsJr2ktMbr61kzGkilXq829ud9x9yPpi0vu5ad0+wmyy8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
Cc: ying.li@amd.com, kunliu13@amd.com, richardqi.liang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/22/2023 00:48, Wenyou Yang wrote:
> Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to pmfw
> for vangogh.
> 
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++++++++++++++++
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..2b182dbc6f9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -111,7 +111,8 @@
>   #define PPSMC_MSG_GetGfxOffStatus		       0x50
>   #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
>   #define PPSMC_MSG_LogGfxOffResidency		       0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> +#define PPSMC_Message_Count                            0x54

This doesn't make sense that the PPSMC_Message_Count would be smaller 
than the biggest message.  This should be:

#define PPSMC_Message_Count 0x59

>   
>   //Argument for PPSMC_MSG_GfxDeviceDriverReset
>   enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..820812d910bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>   	__SMU_DUMMY_MAP(AllowGpo),	\
>   	__SMU_DUMMY_MAP(Mode2Reset),	\
>   	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..f0eeb42df96b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
>   	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
>   	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
> +	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
>   };
>   
>   static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
> @@ -2428,6 +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
>   	return ret;
>   }
>   
> +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (enable) {
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +						      SMU_MSG_SetCClkSMTEnable,
> +						      1, NULL);
> +	} else {
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +						      SMU_MSG_SetCClkSMTEnable,
> +						      0, NULL);
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct pptable_funcs vangogh_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -2474,6 +2492,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>   	.get_power_limit = vangogh_get_power_limit,
>   	.set_power_limit = vangogh_set_power_limit,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> +	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
>   };
>   
>   void vangogh_set_ppt_funcs(struct smu_context *smu)

