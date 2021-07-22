Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0954C63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D98610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 08:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D98610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE2B6E8DC;
	Thu, 22 Jul 2021 08:10:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B276E828
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 08:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9C6TWWSr2HfD+LipIob9yOJHDEnkgndhAS87Wt+rwdlI67/DSlW0Nq14LhIBdkV0GGQmUvBgCnfLSWpxBrK+3O5ON/h8tDFS8vJlJvuORErq0PPwzzy+ZhUdN0x5a2DnTx7x/8wsDugIBnra6851d/YKJS1IVxtiTKX2CRk1jqw5mhHCA8F+VR9sverLUdo+BAJm55pPIRinTGk0E0OcTXMmWaH9AtQyyqKs3tnXnHr8gjXF22n1m0GSO47k+HHa7WjouhWv6yDLQ7lisNCw35YQcBiLND4+K82jdCH51hWWShtLZ+ShuEF016n3LHZA6eXk0jbge0bYd9jhEfllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTWWTCZ4AaxCH9tExn1dNjRss8rxg5eMMxG5czk3mpU=;
 b=GRJBPE1Kw3iqjhEwVnrlNzw5lbnBkntamnG2ipPurWVSRDNKVBgu57HDRtCet+6pjQ3KU3DbkhHg78YZb16rmMa5ECVIel8r9dpxRnGrqVtjXnGH9zpse8v+3ok/ebeAOtjanUv+Ofjr+emEgzYk5noyvPfTG8Z0H8fIRLm9l3tVnNjkcTk0HpgnK7lm8Wd2k/zLr6aRIeubVodHM1WnogdG36lXlqhtuo/xpVei1Vz1nqNn19t9sTacnmlcF/o6aBPxA9qmGFhaxq+eP/eF+W+jsqhLzHPR7jxwbDXCxaLt10BBfyqB6PG2aIJ3vhkmeETT8weO2wQzNHZkz2qB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTWWTCZ4AaxCH9tExn1dNjRss8rxg5eMMxG5czk3mpU=;
 b=cl+68EizN5hB4H+le1SUTUeU3MaNM67FydXBb+EOIIeA5Oa9QWGXoIFaD/W9CEf3e4m6C0CkTBX048GIYAGBnV+kv5kW8jh8RL6u+wdmbEzzyPce6uIihQkuaq1PNLjcj9XOHNV3LHKFS0kldcnos9Zj5YtbiykYr+s8bhIcyqg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 08:10:18 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 08:10:18 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210722032046.767094-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b7ded1e9-08ae-212e-7fa4-2f797bbd228e@amd.com>
Date: Thu, 22 Jul 2021 13:40:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210722032046.767094-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 08:10:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a9b7505-6ce9-4fb8-4af0-08d94ce82482
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51122616D4E2BDF1388D2D0F97E49@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjbHk2+JHRFkW3OEaJgT33cdLtjZc59wg6tCLwcLvCuRduvqSOCK8U6ttgm+ZPDX9ij+PNO501Fyg6YVYXy9yXBmzepcDTWYaUl18yERR2xbkPVr0IYi0GQeWusdVjRGth2v2sH7rf2AMsaeqin1H7thCnl9kQC2lWJWoKk2ZoXJE+ruowpwoQicxc71tBTFIwbpTiohPM5I9xZA0gdYyowzHcY0l05WHI/BlthAfwZBalT/ZVIq+hng44bsGwsg6A5yZY+67bZCY5KAtY1sm6zdPPbkN5uINe13b18b87jRmDOGnqJYqwWLgHPa5/NFfzhjSYFN6CHBt0Lj1tgSxIcqTjq7xo4CY5tep/e+ZXrP9Or5FfCpck99NCMNy4rq0NXM3tpkOwEc26/dT4Wlp9hWLWujOQkac1jYH2Haro/8Y4WIvwLyLadbQxagoQ12Fc6U688RwtD9VlifjIAa2wZqZb86Eg+cgrtRF1z1hJrH6rwB0Imqd4h1ucc5dW/BVaNzoagAx+22Sql4pIsNHkHEe797CdC6LMPB7xnHwyDB+QOe9pxHHLAOwIrTyXgB0qd1wjAmlgr3yvRQ/TxlB793zZRPl+6fW2oCU2x776vCjTuasu95rA76+H0t9eB+TYDQaMggYxUYry6Lx7bgFV8DBGNed2Z+dH3ap98aeUUHajUrd4OHAD4PwRKSOpgImJYJBzTZ31iHKnxc/+LEhP22guHn7ffRhsq/oomF4WD7DQ2/to6ZXK7yPi0s6DPN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(6486002)(956004)(66476007)(16576012)(508600001)(5660300002)(26005)(186003)(8676002)(66574015)(53546011)(38100700002)(31696002)(83380400001)(36756003)(8936002)(6666004)(31686004)(86362001)(66946007)(316002)(4326008)(2616005)(2906002)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUc4UERkOEp3T2Rqd2l0WVV0dWszUXBqOTQweVdDUjZicHRCclpBWFAzNDc0?=
 =?utf-8?B?RXNHNTNzblBVYWc2TjdUQTczeUtCRjNBajI0aWxiRGcwZkFrTzBNeVk1K2tK?=
 =?utf-8?B?NkdUVHA5V2dVQ3RjbUxTbURidVgzOTNMRHNyWFJNamdudjJCQXZYZDRLRmxq?=
 =?utf-8?B?b0pBamlzd3dZTVFmSmppMytVdCt4RVp4TllYZnJaQkNSM0diOUdQM1NlWk5a?=
 =?utf-8?B?c3hQS1NuMmsxNmlDMlhrSE5TR0dXNDdtSWhBaDZxU1Q1Skgzd1RFbUoxaWNl?=
 =?utf-8?B?NHQ2VGhlcTZCK3pZTmd6dnlXMlhza1pFb09Ub00ybk9PaFlwOHBlaHp6NThZ?=
 =?utf-8?B?UmxlbkV4L05LdEx5WVhuc0lyOG5WY2VCeWNiWnlBeksvaFMzelBtams2ck1j?=
 =?utf-8?B?UG45WU03UVdQSnhtcTVhYkE0cHRmMmFVNXdkTjRkcEVSME0xcHJhWndpZVlp?=
 =?utf-8?B?NXY4a1puamdGY3FYcG4vVkNLeldhWVlJQ2Y5M2lVTStmamtXSFNuNENiUXF4?=
 =?utf-8?B?QjJnN1dvTWVxZWN3VlVENGhpdzBweE4ycnRyNjAzRzRLb0NXZ1FwZGtpczJV?=
 =?utf-8?B?SXluOVZnSU50azZhSTlnaVk0bTlNMTlsZzZBTFFxRXZhL21QblM2T0dwMFZI?=
 =?utf-8?B?czZ5NmtMVDl3VzJzTjNJUUtNYis5M3Z1R0lWb1NteUJqS2Q1UHlFaldVcyts?=
 =?utf-8?B?eXppbkgyeWoyc3RYWG9OM2pJUy9zTXRPcGlDV3Vyc0tUUVVuN2d4dVltZk94?=
 =?utf-8?B?bk5WaDArbXdJVW5TTGoyZEdwTmxZWWFiZUx0TlVPajJjWTF2bXMvcFNuYlZD?=
 =?utf-8?B?cVVibjJvdzlUc2FWZEJCMGNyUmsvUjArTUtQS3ptVHVCTTk4aUVvMFdlZUpn?=
 =?utf-8?B?ZXRYRDl1VEdOd0dTc0tIL2trdUNhWnhpc0hFNFR3SGxaUFNXSkhCeUFPMVBM?=
 =?utf-8?B?RVJ4YTJvTGJFcU9WdVJ2ZTEzWlBYdmJaSVNQWWpUKzZuYTRxS2pCRXk3NFEy?=
 =?utf-8?B?WUNOaWQzVlRBTTd6Q0RscStxR3JnbXIrYmw4dU1hTGk0T0xqRUVwclE3NTE0?=
 =?utf-8?B?WXM3R2dDTnhEc1oyeTRtbS91QkswSm1aTUNvR1R4Z0ZtbkpnQ1FMM3Rsek0r?=
 =?utf-8?B?TTRNTVRxV3IvRTBOa0ZIMGU2ODVTZFR0SXFpQ05wblJUZmtQa2JlRWE1R3VQ?=
 =?utf-8?B?WXJTaGhacFd3azhrNFVEM0tBYnJTU0NicElEWW1ETlI1VW1LTjNvTW1kbHJv?=
 =?utf-8?B?dmhlUUdndzR5aDBtbG9WOXAvNTF0VXNCSnMwTkdJRkx3czJmeSt6bEJyWHRk?=
 =?utf-8?B?YmpkTFl1bUU5ZHF1WHZ4T0I1ejl0dTc0Z01QbURaS0R6NlZqMlhIYVV0YUlD?=
 =?utf-8?B?NHUvMHcwcmVZVkJaNDJjQTBBVzZMQi90ajcrNWU2enJGeHhvbzdHMjJPN0JD?=
 =?utf-8?B?N00yZzB2NENYT0pOM2tjbzlBUjVHMkcvbmRDL0pUNG9iODBJY3pZWXVhenFN?=
 =?utf-8?B?U3FzTWE4SENaclNKK3poN0lqQnpabmFBR2FVYkk2VVN3UTduYkhUN29OenJp?=
 =?utf-8?B?UFkvV2hoVk5ZYzdnQ0wzZXJVdjdMeXR2ckIzWm40dTNLdk9ZMWJwREF5Mndq?=
 =?utf-8?B?Q2RNUDRrVyswYXVCaWIrczc0Zjg2ZnhMWVJYWGk4UFcvYi8wZnA3OHV6Wk9o?=
 =?utf-8?B?R0dFakdtLzFjSk9JakpJY2FwRjVHaDk2L3VNZkRZT1ZDZkV5OVdOaitPcVFS?=
 =?utf-8?Q?E43SXQaaCBYneXGU37FqhulNdXFyvPx44Zx1yYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9b7505-6ce9-4fb8-4af0-08d94ce82482
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 08:10:17.9343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln/9CrTC8a4Xkpas5qgSz0cnnHZg86sq2W8MUatQkc3NhiQ70RxDy4xJ1/bGBQCF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/22/2021 8:50 AM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feeding
>      to SMU.
> 
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52 ++++++++++++++-----
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
>   4 files changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3e89852e4820..8ba53f16d2d9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>   	uint32_t power_limit;
>   	uint32_t fan_speed_percent;
>   	uint32_t flags;
> +	uint32_t committed_od;
>   
>   	/* user clock state information */
>   	uint32_t clk_mask[SMU_CLK_COUNT];
> @@ -352,6 +353,7 @@ struct smu_table_context
>   
>   	void				*overdrive_table;
>   	void                            *boot_overdrive_table;
> +	void				*committed_overdrive_table;

May be rename it to user_overdrive_table - OD table with user settings?

>   	uint32_t			gpu_metrics_table_size;
>   	void				*gpu_metrics_table;
> @@ -623,6 +625,12 @@ struct pptable_funcs {
>   				 enum PP_OD_DPM_TABLE_COMMAND type,
>   				 long *input, uint32_t size);
>   
> +	/**
> +	 * @restore_committed_od_settings: Restore the customized and committed
> +	 *                                 OD settings on S3/S4/Runpm resume.
> +	 */
> +	int (*restore_committed_od_settings)(struct smu_context *smu);
> +
>   	/**
>   	 * @get_clock_by_type_with_latency: Get the speed and latency of a clock
>   	 *                                  domain.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..5f7d98e99f76 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
>   		}
>   	}
>   
> +	/* Restore customized and committed OD settings */
> +	if (smu->user_dpm_profile.committed_od) {
> +		if (smu->ppt_funcs->restore_committed_od_settings) {
> +			ret = smu->ppt_funcs->restore_committed_od_settings(smu);
> +			if (ret)
> +				dev_err(smu->adev->dev, "Failed to upload customized OD settings\n");
> +		}
> +	}
> +

Just thinking if there is a need to handle it ASIC specific. The flags 
and table pointer are maintained in common structure. So can't we do the 
restore of user OD settings directly in this common flow instead of 
having each ASIC to implement the callback?

>   	/* Disable restore flag */
>   	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..4752299d7f91 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2296,39 +2296,45 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
>   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>   	int ret = 0;
>   
> -	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)boot_od_table, false);
>   	if (ret) {
>   		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
>   		return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt1) {
> +	if (!boot_od_table->GfxclkVolt1) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt1,
> -								od_table->GfxclkFreq1);
> +								&boot_od_table->GfxclkVolt1,
> +								boot_od_table->GfxclkFreq1);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt2) {
> +	if (!boot_od_table->GfxclkVolt2) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt2,
> -								od_table->GfxclkFreq2);
> +								&boot_od_table->GfxclkVolt2,
> +								boot_od_table->GfxclkFreq2);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	if (!od_table->GfxclkVolt3) {
> +	if (!boot_od_table->GfxclkVolt3) {
>   		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -								&od_table->GfxclkVolt3,
> -								od_table->GfxclkFreq3);
> +								&boot_od_table->GfxclkVolt3,
> +								boot_od_table->GfxclkFreq3);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +	navi10_dump_od_table(smu, boot_od_table);
>   
> -	navi10_dump_od_table(smu, od_table);
> +	/*
> +	 * For S3/S4/Runpm, no need to install boot od table to overdrive_table as
> +	 *   - either they already share the same OD settings on bootup
> +	 *   - or they have user customized OD settings
> +	 */
> +	if (!smu->adev->in_suspend)
> +		memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
>   
>   	return 0;
>   }
> @@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
>   			return ret;
>   		}
> +		if (memcmp(table_context->overdrive_table, table_context->boot_overdrive_table,
> +			sizeof(OverDriveTable_t))) {

Shouldn't this be - compare against the edited settings and last 
committed settings, overdrive_table vs committed_overdrive_table?

Basically, user_od_table can be initialized with boot_od settings and 
the flag gives the indication that user_od table is being used or not. 
Before updating, check if the edited table (overdrive_table) and the 
current user_od table are different, then commit the new table.

> +			smu->user_dpm_profile.committed_od = true;
> +			memcpy(table_context->committed_overdrive_table, table_context->overdrive_table,
> +					sizeof(OverDriveTable_t));
> +		} else {
> +			smu->user_dpm_profile.committed_od = false;
> +		}
>   		break;
>   	case PP_OD_EDIT_VDDC_CURVE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
> @@ -2499,6 +2513,19 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	return ret;
>   }
>   
> +static int navi10_restore_committed_od_settings(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	void *od_table = table_context->committed_overdrive_table;
> +	int ret = 0;
> +
> +	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
> +
> +	return ret;
> +}

As mentioned before, not sure if this is needed as callback. Even if, 
this can be something common for smuv11, there is nothing ASIC specific 
in this logic, right?

Thanks,
Lijo

>   static int navi10_run_btc(struct smu_context *smu)
>   {
>   	int ret = 0;
> @@ -3262,6 +3289,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
>   	.set_default_od_settings = navi10_set_default_od_settings,
>   	.od_edit_dpm_table = navi10_od_edit_dpm_table,
> +	.restore_committed_od_settings = navi10_restore_committed_od_settings,
>   	.run_btc = navi10_run_btc,
>   	.set_power_source = smu_v11_0_set_power_source,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..28fc3f17c1b1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
>   			ret = -ENOMEM;
>   			goto err3_out;
>   		}
> +
> +		smu_table->committed_overdrive_table =
> +			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
> +		if (!smu_table->committed_overdrive_table) {
> +			ret = -ENOMEM;
> +			goto err4_out;
> +		}
> +
>   	}
>   
>   	return 0;
>   
> +err4_out:
> +	kfree(smu_table->boot_overdrive_table);
>   err3_out:
>   	kfree(smu_table->overdrive_table);
>   err2_out:
> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
>   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>   
>   	kfree(smu_table->gpu_metrics_table);
> +	kfree(smu_table->committed_overdrive_table);
>   	kfree(smu_table->boot_overdrive_table);
>   	kfree(smu_table->overdrive_table);
>   	kfree(smu_table->max_sustainable_clocks);
>   	kfree(smu_table->driver_pptable);
>   	kfree(smu_table->clocks_table);
>   	smu_table->gpu_metrics_table = NULL;
> +	smu_table->committed_overdrive_table = NULL;
>   	smu_table->boot_overdrive_table = NULL;
>   	smu_table->overdrive_table = NULL;
>   	smu_table->max_sustainable_clocks = NULL;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
