Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A86C61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 10:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171E589E47;
	Mon, 31 Aug 2026 10:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Znc2e3KP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA75A89E47
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 10:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvT0RzFZmWfDuxAsUN2xNln/uYJYsS1iOpSHrEP7UCsikCCZsoVrxJNnDmO8mBLSpsItjOSukbOUPbwR10xj9mjGNVFAqhvt5EBh8fDCBSlf6XMgKKYlHtVLIhryVZ0Unv5oC6JRFtiqcBb6pChtyOBnEtD77q+3jReXK59++zKXC7TavkD6Qq1R7eC2sxrM7FCi29ey0r+4yNPpxmCg6PZxE18UB0pc/7c4eUzjxRdJXYD8i8pnqiho8KaEX70AbxuXRBW9jt5QOoCc/c/UDFoXw5SKOT0F8rztMrIXePRLGCLojxsm/hYXwksS1K4iOqESBJGH1v5eYV3zOnQTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkqt5ME19w6c/T/TKMk0xKUMWM+SvuAvYpRSVadD99E=;
 b=YMvg7+5SOFXaxuryzZEwNKSvwdpT/9jYEPAIfBbXjej0Tt4e6b13fHABFy3p/Feq/FziFuUJgfKv1cdF/qTFJxdUtj1oL4aY3bKIlnJRld59Nb2BxWu4fngY2vf51abnWReDLjczHrjEZ2z1LMa0QJyoOKYl+M3IkTNNwnGjE3rcXB6ILnFNzJXV41om2LZR30cdKmDRAYPcBC7kEJoMFAi/WXmeGDmzPnTKACI3KL9Q/Yt4mGIuEiQnDNOX6WtOMUtn5qbZLwQ0vKVq4plTELMPgGEN+pRtX+KaF1wrnaBQtqGrt6kVnNW39NKKCYPd2qDFHEr51M6XbhE/wxrprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkqt5ME19w6c/T/TKMk0xKUMWM+SvuAvYpRSVadD99E=;
 b=Znc2e3KPFoeZDla11S+V68DAhtbGtteO0v48KvXLlusxVOzU+osQEJyH6bbduF9bRBvGYFlTabPUoGRou7Qthuir4VhEkBfw/11RjzggUyoTcsreBJvmoDbqGYyFlYEZrfeTa5GGBSTTXMvS8RAR8sJHHdk7MsJGue27pbs8hDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:51:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:51:14 +0000
Message-ID: <f5d6e979-3bec-489b-8809-654dc87fbd67@amd.com>
Date: Mon, 31 Aug 2026 16:21:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amd/pm: stage od reset for smu 13.0.6
To: Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <20260831043507.523599-5-kevin.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260831043507.523599-5-kevin.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a1d400-6f52-4cac-d252-08df074dc733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sb1++6XSRvsmhQhhkpr2hMLlUZwqituPoAVQtY6PHk6vHaRpk+ywOPh5oGsvcDgwBlqOOSM7LAAkOGb6pQrettft+jDB77/udAX2llxcXP8YKlepKkzG4gl/JRv8UzxLIbukZTkLvcrsp3d5TK/OAON16zFq31O2dvePjPU3u0TGrBjnaM3JhU75Sk+oOZPqe+/CdzqYp357RcgoSbkNoKeb2x8cx0qPTPR1q/p/5JH+iSTAYPHpHMCBOo7n4l6ev4d6dMVcH9hlfEcNv/X6ufPEAlO085YyOOCI9nFqAc4QZLvHfl3Q/CSW90ap0HqqpVba2NLBz3x3qSNvIrYjWe94rllmC6SQ9NqL1MnZYFs+FV3ZTOldu99jSG0Sm1UPT1uYYXy32eRB5FTT9Q7zb9PXWQUS5mDzCM+Zeu/9TNrfPNgiqgCuizDAvDSx84GXL6Li6B+XKwPMptKoIISXLoZ1iXYfLzozJV0NkheGfxUXevalLgfKGqXEZZsfEFk7VU1FZfgQ1C5xI5PFg+G37euIegMMn7qmgvDymO/Xw48gbDCO5rGujeiVyXUlHcAgGHmaAOgnyl1NVjtjp+OrYQtgE6hCB64dAA3/uUZZsUpIQ9y6YCGkiNBT/yHY3iDxKY5MvHrIrbbe3vj1WnyntytaP4MXajf8lJXsdVcCNZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZvcWwwUm1oVHd3amRWZ2tUVWxUWlRzejdueCsvaEo5eHYyRzd2ODhFaWdu?=
 =?utf-8?B?bzhmVlBMc25wREg4c1J6cnV5RmE0eUQrT0czLzd5SlBtbFV4dStGZ3FvVWJr?=
 =?utf-8?B?bkdWcXdvREZ6RWluN3BqcE1IMlJVZndMQWdSWUEzQnJyY3VJVjEzZlE0TWRh?=
 =?utf-8?B?VmtBMm9xblIwRHFjRzh4a3NjL0tManZYbmJVcTQvcTJVQy9mRnVlNUQvTUlh?=
 =?utf-8?B?TGVCS1FFeTMvaXVWOTM4UkRRTjRvRGJUZUU1Z2lWWm92Y0hEY2lPVFY5M3JB?=
 =?utf-8?B?bjFuN3NZc2dGdlFlSUtmYWY1WEJlQ1JpRGJhclRyY0IvMjgwNjYva3FkVE55?=
 =?utf-8?B?VzNjbFp2R2gvUGdncVhIOUdDMEdLamJ2a2JlTXVFZTV6cUxwUnVYWUNyamlF?=
 =?utf-8?B?cjgrZFFlZ29PUWkxU0poOUFPbVNXbVg3WEtKV1FjTGhzampTQnc1cG02NndT?=
 =?utf-8?B?aEpGYTBJcHhiTlVlQTNsaVcyNVR2NEVDTlpreEJCYzc4cU9pZzN4NjdoaGNN?=
 =?utf-8?B?dWpEMWp0Z0xIWUlxZUJMdG5TWVhaVnduOTJOTm8vRzVkZ1FpRUc1amR5MEln?=
 =?utf-8?B?MVJwWDVBMXJtTlNqNE5IMXptY1pzN0tHK3h0dHRCQWpQU29tUzNoYWhkZTFS?=
 =?utf-8?B?OERab3JvMEY1Y0dCUXNUN3RXUmtmZVYraXZPMW9XaTNBdTRwMVJVc211VzZW?=
 =?utf-8?B?WjhveVNiS3VBQXdhQUNQaURNemRtTUNHWjFEb2JMMDM3TFZMNnNRR1ppcEJw?=
 =?utf-8?B?dnpyZlN5a1VIUHRqZ3d3UmQxWHZGb0cyV0w5UkRybmpJak52aU5BTDFmOEQz?=
 =?utf-8?B?amdFZGdtb2dYNUJVeUEvcDZlM29nYmVsWVBmMm1wUWlQR3dra1VIbzN4amNx?=
 =?utf-8?B?T2ZKUVNXVE1LTU5TaWVDVEw0MlFDMkwwMGtGMXhFVlEvbHFqMTBMRGdMY3BT?=
 =?utf-8?B?SDU5WEx1OVVIZmQyU0tCbTNLUmlvd2xIeHBzS2tmdWcxRHVEWnE3Q3Q3M01P?=
 =?utf-8?B?ZnNSZC9BcDhrL1FIQWs5Z3ZsYks5OUdjeDJPNXpJQTRYeDdKYXBnRllVVFgz?=
 =?utf-8?B?a1BmTlBSSllSUDNDeUx0UEQ1VVJlUzRWWEsyWlZaeWlnNWZxRG1MTGpUeElp?=
 =?utf-8?B?T3YvalZZbWlBTk5hdmVNNDBiYUNlZEc1TVB5YjRTeUs4bzRvWDh0dDl4dmhW?=
 =?utf-8?B?RVE1SzRGVDk1RmpNUWowYlhYa2tGTTEvc2x0Z011QzN4SHpDRmoyUVExRWt4?=
 =?utf-8?B?OTk4N1ErU1dTdm04RXhhei85Y3M5ZjhJSGhEVnFMSmdwWCtma2QxNW1BKy8w?=
 =?utf-8?B?UHc3RnV4QU1ncXlya1pVVTNMMWdUT1NhMXBDcHNHenVPT3JDUmNDUDBWY1FM?=
 =?utf-8?B?ZWxWaG9qMjBmSGJQUXNKeEZieXFtVi9GNEx0WWV3bW1wemNZbnloU01XcE43?=
 =?utf-8?B?dnE3eTBHd3dnTU5LTjB2RVNrc1lJTUw2ejc4NlJKU09UUDduOVA5QU9rWHBI?=
 =?utf-8?B?cEZuYkNlRHI4bFBrRFMvbGhRclpOUTF0a3owUlJXTVhSMG9nZVJ5bG1LYWRE?=
 =?utf-8?B?THg2bHNVV0lvWnpKTFVzcGI2V0pQczZ0c0VXK2dzVEZIdEpDazJvTEFVMnc3?=
 =?utf-8?B?cEQwQ0V2RTY5UEV4YU5oeXh2dThua2ZlQWRtL241QVJEY0dMV3B5UVEzVWZ0?=
 =?utf-8?B?LzNZSXhLUGJJZFhWZ2FrZFVDcXI0bE9OZmZWNGZtVDIyMjVITTVsTTlWYTRJ?=
 =?utf-8?B?YkN4MlgzTjVlREdMZXBjTFZlSlV1dzljc3EwaUdlZ1U1T3dwa1ErRmNGNUUv?=
 =?utf-8?B?RytjdXYzcWQwNW5aSTVsYzRpNlMxQjF2N2xoMlJhcURZSzlZQTFreWNXN0t1?=
 =?utf-8?B?R3JGL0JuS3RiWkRxeHdackNoV05pdlBheUNhd3NKZDlYaXpubXBLdHFObVB6?=
 =?utf-8?B?Lzd1TzJGUXdNSGNoUHgwcFlIZTJBdGVSaXJVMUoxeWJ3OU5vQ0N1T2g0M3l4?=
 =?utf-8?B?cUdjT3dFckwzc1ZzcDlMZG9mZXJZRm1DT1RpWUpMZUxVUXJJSytpTW5RTWk3?=
 =?utf-8?B?WlRaR2p2R0U1TG5NSlE5VVl1Y0NtN1FmYXNGQkRhQTNXL3YyRjhXSkNrZEo5?=
 =?utf-8?B?SVJHaEZDK3owSndGV3N4UldBWWo0QXBua1M3ZG9HWmxIbm96M29qNWlmUzVn?=
 =?utf-8?B?VEdIRmdSUjJLMVNhWDNOY1l3R2dIZXowNDU4L2tIZTd6VG1lVFJDL2x2blg0?=
 =?utf-8?B?eUJTL3dwMUJodzZXdUx1TTVnajFBcjAwTkhFN0hUaENldlRqT2tTRWxaYzFm?=
 =?utf-8?Q?/oBlgeDmCODaPTYVx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a1d400-6f52-4cac-d252-08df074dc733
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:51:14.7198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nQjbCVnibCf0IGKNvsMAoIMqsK5nm2YOsW1rbOhHeR2NduiZX46Jjkh/aN2Y93f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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



On 31-Aug-26 10:05 AM, Kevin Wang wrote:
> [Some people who received this message don't often get email from kevin.wang@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> SMU 13.0.6 applies default GFXCLK, UCLK, and FCLK ranges directly from
> PP_OD_RESTORE_DEFAULT_TABLE. This bypasses the staged OD transaction.
> 
> Stage defaults through one helper and let c submit them. Gate UCLK and
> FCLK staging and commit on their DPM features, and require the UCLK
> firmware capability before staging or submitting its limit.
> 
> Signed-off-by: Kevin Wang <kevin.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------
>   1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 4dec3a93cb3d..169e38db629d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2130,14 +2130,45 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>          return ret;
>   }
> 
> +static void smu_v13_0_6_stage_default_dpm_limits(struct smu_context *smu)
> +{
> +       struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> +       struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
> +       struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
> +
> +       pstate_table->gfxclk_pstate.custom.min =
> +               SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.gfx_table);
> +       pstate_table->gfxclk_pstate.custom.max =
> +               SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.gfx_table);
> +
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
> +           smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX))) {
> +               pstate_table->uclk_pstate.custom.min =
> +                       SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
> +               pstate_table->uclk_pstate.custom.max =
> +                       SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
> +       } else {
> +               pstate_table->uclk_pstate.custom.min = 0;
> +               pstate_table->uclk_pstate.custom.max = 0;
> +       }
> +
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
> +               pstate_table->fclk_pstate.custom.min =
> +                       SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
> +               pstate_table->fclk_pstate.custom.max =
> +                       SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
> +       } else {
> +               pstate_table->fclk_pstate.custom.min = 0;
> +               pstate_table->fclk_pstate.custom.max = 0;
> +       }
> +}

The default values shouldn't be put as custom min/max limits. The custom 
limits will keep non-zero values to indicate any custom limit is set or 
not. It's not used to keep the default limits.
> +
>   static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>                                            enum PP_OD_DPM_TABLE_COMMAND type,
>                                            long input[], uint32_t size)
>   {
>          struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
>          struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
> -       struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
> -       struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
>          struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>          uint32_t min_clk;
>          uint32_t max_clk;
> @@ -2258,42 +2289,8 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>                          dev_err(smu->adev->dev,
>                                  "Input parameter number not correct\n");
>                          return -EINVAL;
> -               } else {
> -                       /* Use the default frequencies for manual and determinism mode */
> -                       min_clk = SMU_DPM_TABLE_MIN(
> -                               &dpm_context->dpm_tables.gfx_table);
> -                       max_clk = SMU_DPM_TABLE_MAX(
> -                               &dpm_context->dpm_tables.gfx_table);
> -
> -                       ret = smu_v13_0_6_set_soft_freq_limited_range(
> -                               smu, SMU_GFXCLK, min_clk, max_clk, false);
> -
> -                       if (ret)
> -                               return ret;
> -
> -                       if (SMU_DPM_TABLE_MAX(uclk_table) !=
> -                           pstate_table->uclk_pstate.curr.max) {
> -                               min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.uclk_table);
> -                               max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.uclk_table);
> -                               ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
> -                                                                             SMU_UCLK, min_clk,
> -                                                                             max_clk, false);
> -                               if (ret)
> -                                       return ret;
> -                       }
> -
> -                       if (SMU_DPM_TABLE_MAX(fclk_table) !=
> -                           pstate_table->fclk_pstate.curr.max) {
> -                               max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
> -                               min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
> -                               ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
> -                                                                             SMU_FCLK, min_clk,
> -                                                                             max_clk, false);
> -                               if (ret)
> -                                       return ret;
> -                       }
> -                       smu_v13_0_reset_custom_level(smu);
>                  }
> +               smu_v13_0_6_stage_default_dpm_limits(smu);
>                  break;
>          case PP_OD_COMMIT_DPM_TABLE:
>                  if (size != 0) {
> @@ -2318,8 +2315,10 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>                          if (ret)
>                                  return ret;
> 
> -                       if (pstate_table->fclk_pstate.custom.max) {
> -                               min_clk = pstate_table->fclk_pstate.curr.min;
> +                       if (pstate_table->fclk_pstate.custom.max &&
> +                           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
> +                               min_clk = pstate_table->fclk_pstate.custom.min ?:
> +                                       pstate_table->fclk_pstate.curr.min;

This is intentional to always enforce the min limit, there is no custom 
min limit allowed for FCLK.

>                                  max_clk = pstate_table->fclk_pstate.custom.max;
>                                  ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
>                                                                                SMU_FCLK, min_clk,
> @@ -2328,10 +2327,14 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>                                          return ret;
>                          }
> 
> -                       if (!pstate_table->uclk_pstate.custom.max)
> +                       if (!pstate_table->uclk_pstate.custom.max ||
> +                           !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) ||
> +                           !smu_v13_0_6_cap_supported(smu,
> +                                                            SMU_CAP(SET_UCLK_MAX)))
>                                  return 0;
> 
> -                       min_clk = pstate_table->uclk_pstate.curr.min;
> +                       min_clk = pstate_table->uclk_pstate.custom.min ?:

Same here, there is no custom min allowed for UCLK.

Thanks,
Lijo

> +                               pstate_table->uclk_pstate.curr.min;
>                          max_clk = pstate_table->uclk_pstate.custom.max;
>                          return smu_v13_0_6_set_soft_freq_limited_range(
>                                  smu, SMU_UCLK, min_clk, max_clk, false);
> --
> 2.55.0
> 

