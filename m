Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 02:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1B523619
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 02:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1B523619
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FFC896A3;
	Thu, 14 Jan 2021 02:57:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D51896A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 02:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwLKtnfKBSdfYHupb1YFc5OPUye1a+4eH2Iym/+cf1DX4LauADrBnAn0qyFCZdG+RyLSaaMKV5AYEdDdf/9KuwYLsGZF0IxLx279tYa62BYw0p5AqXGnovd19q8kJSB46nX8nEoXoVNGYhgY6pSf+blvRW2yd2QZp2shHsR5Q2Ky3m+F2IceOuvqeaugWm5EUcKfTfBkGIJh/Oz4h7E1qnQSgTZg6XmbNgeuotsVVYjgy+BdE9OeEszgEp7+UqSkjrl69Ez0zWfz/yRn2z1ENnJJO9wgJLyF03eOlVsjYGzw7rm4uAs6iX5/0k7T1+2HEhc8yeyuyjsUeWFwLElbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQUZWrAG/CdT2WGEqeb4z9Y3w/2gdQadv9HsVJMsSXc=;
 b=Gyi5d99auV6lK4bMtLIwVB8fmqkafACdT0hfAYN/YaPmzb45arFAxwfcnGlt6egVHD3x2mJSdvDNrqLmwTFheLbFrEGZwr6OWNZsMPGcYtfiEC0yIGGfIO0eWrLtyEHSZ1tf8kIqJgOrzK+F/Fq9/kkTsjrnNnV5sEerFqWXU/3NkWqxvqDI6WRD8UBFxzLQwspi6XFk2Phj/ffxTgKlxJoFnUBNcIu6scWrj7ou1CVXfgRgWsrnTwMvlMKyNAM2naANXwx42xkiLpce3+kDv+e+bA5/3NQB9Bss7wOzq5SETXr+hShLdufxEauJ5PKp1CTl2rZw/fEPlrMVdbTtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQUZWrAG/CdT2WGEqeb4z9Y3w/2gdQadv9HsVJMsSXc=;
 b=wsUFB10trVPZejGnfAMaXtt5dS5seFD5Vq1mNCyTWsPBTAYBHg7IJ53PJrsKCra821o5iidIW8bGwIcHyNdrNkaMiNVFhmSy4PQFHUy2ZTWjf1XzwJDMIcbGMxI0pSFqHlfh2mtDrLv9TZi9Q3uKEW4DtyVcdT/JTbvQl3s3xes=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 02:57:42 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 02:57:42 +0000
Date: Thu, 14 Jan 2021 10:57:34 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: modify the fine grain tuning function
 for vangogh
Message-ID: <20210114025734.GD283203@hr-amd>
References: <20210113112204.25469-1-Xiaojian.Du@amd.com>
 <20210113112204.25469-2-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210113112204.25469-2-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Thu, 14 Jan 2021 02:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12f1ff15-13a7-45e0-d600-08d8b838298a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01282F96A1AD0BDE414C71CFECA80@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFDb9lZ67348/4lVXC9liNa547cCh2NJDtqU8ABduc/h1bYi+PobSSuFM1wJwQPL4FfjBpq/55WKN/de0fV+7XPso0Mk0NXWrPR+9VcxW91ir0sis8iSCTgUrLGNLe/vPgTmRYzrEwUZunYkMk4P4H66RGpSFIX7HhKX5vSDxwt/ihRkyfe1o0P5sO8NEQGrZ2UB9ua7idwe2B8RXM4ZamEdCV5MQlkEeKBSxz8LY3X0VEMLaXTjLeulsxwak+zSyHNbcWZg4wgktyI1PHfObnMixNHYartK9GXKFHzObvJ/0r6Z/ifTVMYrd5l6NUQnRe00rPnBOQXTCHE4TtPViedDbUWDPwvoMQvbAvBXu8q/A1738qihhLS2RPNmSahxJU7kwZCx+jrBh+lzoJruzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(478600001)(26005)(33716001)(6496006)(9686003)(54906003)(86362001)(33656002)(956004)(4326008)(1076003)(186003)(52116002)(83380400001)(66556008)(8676002)(66476007)(8936002)(55016002)(5660300002)(6862004)(66946007)(16526019)(2906002)(316002)(6636002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WnaeJ2ydlcdX5htMCCFHke+PKjHOENj2J+nNXC1oBE2hTTvFXWTVLOAkEdht?=
 =?us-ascii?Q?0B//QeyfOEbyrES57CRkDzSpfIXGTbhzYIW4TBYgqP9ip/BOvxuogYDn0YJX?=
 =?us-ascii?Q?YaCnMlrxkNuQod/pOIvkrXOlWWkQwRgfQW0rE1lTEtm197c+X2m/csc+ORlN?=
 =?us-ascii?Q?NYG5tFz9fqN11SkyqjQP6ZdKpWG6JyjHUwjrCvhd3JQxr8iDtVq2d8HLd/Pi?=
 =?us-ascii?Q?i1ZmcPmxzfkOzNN6Wc0wtVJifLfYIXcx6jJ6tAe1OGQ4sWg8pTtXNQLhjrVn?=
 =?us-ascii?Q?OhXJSZcVF72/NsTJklzuU2cRrcQyTBJjyr954TG5bwURcPGihMiAl0fCMcl0?=
 =?us-ascii?Q?7QYANLNjU5PoX5nrQAKtanBOY+1qjBe4rX43V8DVE6iWN4oWkUM+AAh3l8Mr?=
 =?us-ascii?Q?u3v25J2pIrXEyL6d9FU5iR2KgrrVxdJ8CGsbCLzQvO6oMk/8FKeHp6K+gla+?=
 =?us-ascii?Q?6GjsLJdz+679bS2Gs/qXZGXMOzGGm3tB3SQzseFCctnMcf9+e8b/o606wI3R?=
 =?us-ascii?Q?B4wEOlP38Y2CM1rzqpH+MzHavrIL/1UZdC5OpqyGKZwdHoDWed7Jt0Td4q8f?=
 =?us-ascii?Q?zdxHBvgkZ7o4Kbe4lqx46QsPn49ziNODe7u7ukLDradERw/raQrx72AruMdK?=
 =?us-ascii?Q?icKd0xiAYXLXlXGoMY2X7fz6Y4ldQFJBhRoCKNtXV0uYanfzhZwxbhmsxeO1?=
 =?us-ascii?Q?wSTb0Yi4Im0C22/+f960ZdHOLkh2dvIewXABnPPYm7WuJuTP0P9rKXVRqL6T?=
 =?us-ascii?Q?beKt1uGeEr9tccUja8jqNItA9ZtY/5eYGIiH9UVlJOHsox2JyeBCZSYE5gbK?=
 =?us-ascii?Q?l8JyZyyPd2Ibj14WBt4WCoiGwuoT4Pn6KRIMjnCcm17wVSJz8vQMXb+SFx77?=
 =?us-ascii?Q?dbGHgo8+jx9ExjCVVtXvsrSDMxBm1WX9Ce3jMtpM4jqCjwnz7OGudOhzT8On?=
 =?us-ascii?Q?dzw+q+Lrs1T/++n/gtO/eJMjFl8kLBFicBUo3h8Laly/CDQ2nDIggjvbvRWm?=
 =?us-ascii?Q?Z8hS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 02:57:42.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1ff15-13a7-45e0-d600-08d8b838298a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONaQ0nXs/pcM7PuK9i9omrOwQt6Niw0jrVHu3K8GIJoKuXEHY0EDW1/0cm5MI7F8qKXRn5LqCqEqfTXKKBVd6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 07:22:04PM +0800, Du, Xiaojian wrote:
> This patch is to modify the fine grain tuning function for vangogh.
> It is risky to add two new flags to common smu struct.
> So this patch uses the existing old flag to make the two sysfs files
> work separately -- "power_dpm_force_performance_level" and
> "pp_od_clk_voltage".
> Only the power_dpm_force_performance_level is switched to "manual"
> mode, the fine grain tuning function will be started.
> In other mode, including "high","low","min_sclk","min_mclk",
> "standard" and "peak", the fine grain tuning function will be shut down,
> and the frequency range of gfx and cpu clock will be restored the
> default values.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 --
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 -
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 52 +++++++++++++++++--
>  3 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 277559e80961..25ee9f51813b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -466,9 +466,6 @@ struct smu_context
>  	uint32_t gfx_actual_hard_min_freq;
>  	uint32_t gfx_actual_soft_max_freq;
>  
> -	bool fine_grain_enabled;
> -	bool fine_grain_started;
> -
>  	uint32_t cpu_default_soft_min_freq;
>  	uint32_t cpu_default_soft_max_freq;
>  	uint32_t cpu_actual_soft_min_freq;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 976a9105aecc..7fe61ad3ed10 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -419,8 +419,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>  		break;
>  	case CHIP_VANGOGH:
>  		vangogh_set_ppt_funcs(smu);
> -		/* enable the OD by default to allow the fine grain tuning function */
> -		smu->od_enabled = true;
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index b49044825680..3e32b223d47b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -438,6 +438,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
>  {
>  	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
>  	SmuMetrics_t metrics;
> +	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  	int i, size = 0, ret = 0;
>  	uint32_t cur_value = 0, value = 0, count = 0;
>  	bool cur_value_match_level = false;
> @@ -450,7 +451,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
>  
>  	switch (clk_type) {
>  	case SMU_OD_SCLK:
> -		if (smu->od_enabled) {
> +		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>  			size = sprintf(buf, "%s:\n", "OD_SCLK");
>  			size += sprintf(buf + size, "0: %10uMhz\n",
>  			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
> @@ -459,7 +460,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
>  		}
>  		break;
>  	case SMU_OD_CCLK:
> -		if (smu->od_enabled) {
> +		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>  			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
>  			size += sprintf(buf + size, "0: %10uMhz\n",
>  			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
> @@ -468,7 +469,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
>  		}
>  		break;
>  	case SMU_OD_RANGE:
> -		if (smu->od_enabled) {
> +		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
>  			size = sprintf(buf, "%s:\n", "OD_RANGE");
>  			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
>  				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
> @@ -1127,15 +1128,39 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  
>  	switch (level) {
>  	case AMD_DPM_FORCED_LEVEL_HIGH:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = vangogh_force_dpm_limit_value(smu, true);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_LOW:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = vangogh_force_dpm_limit_value(smu, false);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_AUTO:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = vangogh_unforce_dpm_levels(smu);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = smu_cmn_send_smc_msg_with_param(smu,
>  					SMU_MSG_SetHardMinGfxClk,
>  					VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
> @@ -1165,6 +1190,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn,
>  								VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
>  		if (ret)
> @@ -1176,6 +1207,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  			return ret;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = vangogh_get_profiling_clk_mask(smu, level,
>  							NULL,
>  							NULL,
> @@ -1189,6 +1226,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
>  		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
> +		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +
> +		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
> +		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> +
>  		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
>  				VANGOGH_UMD_PSTATE_PEAK_GFXCLK, NULL);
>  		if (ret)
> @@ -1401,8 +1444,9 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>  {
>  	int ret = 0;
>  	int i;
> +	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  
> -	if (!smu->od_enabled) {
> +	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
>  		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
