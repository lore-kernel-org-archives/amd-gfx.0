Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044AC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACD5235FF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 10:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACD5235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FACF89CDB;
	Fri,  8 Jan 2021 10:12:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB47089C6E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 10:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiEp4/RlYz5jq1M6jk1erpO9zQr83dIwb1mVDMNuO3gyvuYAzv0qXwWV1HX9Ccazr5h1Yr05qRH2T9nzfgI7ucE21LE+BjD/sj/blY+GJ2S1srkK6NMsep1/5yM2wwyFCGMo5aqOdKkpcsOeGYfBwAuLyH5vNZXS5F5aLJk1zIHbgoGC7Xct2/+CVeUTqOqgYgDcM8SXZkjYmXv2qjleX32jqhj4PiXCXainJQ1j7qRQ8jPI8Y6x1efNGIXy7y/nPm+gRXATz85Yr1ouNHjpFPto86tTTwyo9HThZnPRR9j8/DGmEbI1hQJTDN/3h/hS2SPl8BlfesBBGsoquZZESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82OngxRg3+F2MOCSq7VeizkSwEN9M/a36aZZKIpG47c=;
 b=BEbi5d0Fm0oGMsSUhf+A578cuEAzozPTmsfUD07fiHVDhDNb6r2At9PohhkwocvTX6LuZUG3RaiuOL8TOc+FSE1j70JZB15K+SGhvSWwj/5PGVSW8C4/40+bBsXAMtY7iYjcCQ8qdm2skZ//HI7VmouQBbKiP8YFuaFxaeGKAo0IZwu/Ypoh4VpAerxniGgsTsSMtBL3eEvfBUYgDWeC4NHGY4UV3Yyko610K5vY0y+BYqSjhzHdVuN2O00pEOlyUM9yH6+RbqHBKIK5HKd6ZnMu5nXUrGFsW51EyL4EMeKz48IQvENf2WV3C7aBwciKXYB9Y5NZuc7qNVH8fgdkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82OngxRg3+F2MOCSq7VeizkSwEN9M/a36aZZKIpG47c=;
 b=R95JX5Wo1JYFQCs1yUlvk2Pz3bdHpY74kDjpOdZZ7g38TFRJiTCP1TORhNn63xLTcEqMz0PHfJ6vgSM29v0UxoGTLEH+qBuSW9qQUBZv+nQVGGXY/arBVGG2RDIZ/sqdV914fO30b1Q+pgmT0NsEugaTaW2GHQGmSi+SUFCsvww=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1312.namprd12.prod.outlook.com (2603:10b6:300:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 10:12:31 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 10:12:31 +0000
Date: Fri, 8 Jan 2021 18:12:23 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature
 for vangogh
Message-ID: <20210108101223.GA1164860@hr-amd>
References: <20210108085507.1164588-1-ray.huang@amd.com>
 <20210108085507.1164588-8-ray.huang@amd.com>
 <DM6PR12MB2619B9C5907EC6CA8A506A5AE4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619B9C5907EC6CA8A506A5AE4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR0302CA0024.apcprd03.prod.outlook.com (2603:1096:202::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.4 via Frontend Transport; Fri, 8 Jan 2021 10:12:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd4ac82c-ea16-4834-bd07-08d8b3bde8fb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1312FD8D42206B5D9B9BF7EBECAE0@MWHPR12MB1312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cl04fGLUSLHjNX8/yw8kaFYjNO3mmKo8VDYuJskl9jR/IjhkXzg9RYpDLMPROvOoEeFbT1jF5XIyR6g7f0F8w0xLDRWlIPZ8FTkv83ciHfzT+652/EMOXQ66aUDXqmTrS3XSnw2XzptgeI2Ei727m0fpgPfhCuXdm4fVX2hMaC2lQ3sU42a5g8pcvGuVtGpe/1sAYFRrawWoytGBTmpiOzWrGfi8HNHnf3gioXFLRFUFewYs+tSUga/dchDJGRXEyuc8vTtxHNzl7L5o9d0ASiA7E6hBLLmNb3x9y9ajw72Z5kHq9gl9w7vFckSLa5A5FFBF6tyaLq+hryw3k2AURtJm6jKTJ/SQg+0qrR6SdgWchhL95HIgz6+vSewi3XNWVhNVZXGCrkZzLc7+hqz7F42wrJ1t9kWaU6JWcAfYrkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(33716001)(86362001)(66946007)(66476007)(66556008)(9686003)(966005)(54906003)(2906002)(5660300002)(33656002)(16526019)(8676002)(4326008)(478600001)(186003)(956004)(6496006)(52116002)(316002)(55016002)(45080400002)(53546011)(6862004)(6636002)(26005)(6666004)(83380400001)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yGu0zQxRnO0bco5l/rbCGFluVSa6NmWhWMoIEZ1t7EeQW9ZVffpAHjUtmGQi?=
 =?us-ascii?Q?RCTEjn8MTElIlLMHXBAtr+fNL9HompqUnswezDMyqAB+JJ6JgyGYVxMR0x0b?=
 =?us-ascii?Q?DIuBf6ABlPbQyg8KmhrLCZaDhmxPehlJExkMVaKYn3ahDNE7XAxesYKg2y8M?=
 =?us-ascii?Q?Mt9T7gUg2FAdcqmzIoyDwNJI+q410j92xy8pI8zUMpbDhaXUfKWkveUOVec/?=
 =?us-ascii?Q?JpET27I7BOwI/NCNSlgHFrmX3aCf7mlJ2wUDsqL69LLrjgDBneR4LzsBrwnI?=
 =?us-ascii?Q?S0T4kxOBVfPMxtjcSS0yX4PB4SIr58Ud/Dibw3CPgwgB+5n9FNzkhnPHZzve?=
 =?us-ascii?Q?B3+DUyxK7y9Vf2H9bSepzzi+rhgc8OPanlomgmCqEqoNA86jLetNAETt4AFO?=
 =?us-ascii?Q?ZrMRK5iu+mrw2tczmAW0/Rd3uBWBRWpj8h7LPwL7EcW8VRWsrcNV+Gl4VI4V?=
 =?us-ascii?Q?vM/h09+MhmHUCFW3b9UDF25ork9RYMOA5E+5UB7zbCiZ84M8S/WxfJVtA7Qp?=
 =?us-ascii?Q?wIDeL1gP1LESLDf2p+atzP9pw4paoL92svnxhWF0O28xH9lLaQM5H1k+dRKh?=
 =?us-ascii?Q?maP6lCt6eoof2Z8+rhMt49ds7UZFtjT9co7EEc78FxtviBlc+sfUwH2BO2DF?=
 =?us-ascii?Q?siZRe99/TU5AcWZ8eaJ0DW1C26szD8wsM74rScI6c87lm40hhiBXIVGHD/Iw?=
 =?us-ascii?Q?JQ03WItSLvIal+AAMxWRRlZwsStj0xJmKhvwgvj49uzu19gY5NqYT4ptE8kk?=
 =?us-ascii?Q?u6YQntDW6ZLv4NL+p6H/agmi5+vhNQo4h1RKITChWIvEM+IxQ0icuauPQppr?=
 =?us-ascii?Q?PnOuZKyqPGLBXxeKHpr+lcGj2I5fIfmiMcVAR9+5QcG/N1d7zZhFwPSVVK9f?=
 =?us-ascii?Q?iA4YiPE50Grq9pRg43oRsK4vD4jod35O+YPqtK1VeZWn1vOYLTf8IYiIQRRf?=
 =?us-ascii?Q?8z4/Swyhpgod7eAUirB/mLbioq75AecpLdviH4nRh5T5CjaxGfqCyPymAWGF?=
 =?us-ascii?Q?WdUO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 10:12:31.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ac82c-ea16-4834-bd07-08d8b3bde8fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBAsB9ZQvkUS/6SGDeW5+qY5tVRkKJV7AKW3+z4WaAKWN9hMXWKFvxokUlH4E+EuAW1R4QiuWZrWXtRFF39OJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 08, 2021 at 06:01:08PM +0800, Quan, Evan wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
> Sent: Friday, January 8, 2021 4:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
> Subject: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature for vangogh
> 
> This patch is to implement the processor fine grain feature for vangogh.
> It's similar with gfx clock, the only difference is below:
> 
> echo "p core_id level value" > pp_od_clk_voltage
> 
> 1. "p" - set the cclk (processor) frequency
> 2. "core_id" - 0/1/2/3, represents which cpu core you want to select
> 2. "level" - 0 or 1, "0" represents the min value,  "1" represents the
>    max value
> 3. "value" - the target value of cclk frequency, it should be limited in
>    the safe range
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 ++
>  drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 78 ++++++++++++++++++-
>  5 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 57b24c4c205b..a41875ac5dfb 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -156,6 +156,7 @@ enum {
>  enum PP_OD_DPM_TABLE_COMMAND {
>  PP_OD_EDIT_SCLK_VDDC_TABLE,
>  PP_OD_EDIT_MCLK_VDDC_TABLE,
> +PP_OD_EDIT_CCLK_VDDC_TABLE,
>  PP_OD_EDIT_VDDC_CURVE,
>  PP_OD_RESTORE_DEFAULT_TABLE,
>  PP_OD_COMMIT_DPM_TABLE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index a5be03aa384b..298784f73705 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -800,6 +800,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
> 
>  if (*buf == 's')
>  type = PP_OD_EDIT_SCLK_VDDC_TABLE;
> +if (*buf == 'p')
> [Quan, Evan] better to use "else if" here.

Fine.

> +type = PP_OD_EDIT_CCLK_VDDC_TABLE;
>  else if (*buf == 'm')
>  type = PP_OD_EDIT_MCLK_VDDC_TABLE;
>  else if(*buf == 'r')
> @@ -916,6 +918,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
>  size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDGFX_OFFSET, buf+size);
>  size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
> +size += smu_print_clk_levels(&adev->smu, SMU_OD_CCLK, buf+size);
>  } else if (adev->powerplay.pp_funcs->print_clock_levels) {
>  size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
>  size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 97d788451624..5f781a27cfb7 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -465,6 +465,12 @@ struct smu_context
>  uint32_t gfx_default_soft_max_freq;
>  uint32_t gfx_actual_hard_min_freq;
>  uint32_t gfx_actual_soft_max_freq;
> +
> +uint32_t cpu_default_hard_min_freq;
> +uint32_t cpu_default_soft_max_freq;
> +uint32_t cpu_actual_hard_min_freq;
> +uint32_t cpu_actual_soft_max_freq;
> +uint32_t cpu_core_id_select;
>  };
> 
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index 8e428c728e0e..b76270e8767c 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -237,6 +237,7 @@ enum smu_clk_type {
>  SMU_SCLK,
>  SMU_MCLK,
>  SMU_PCIE,
> +SMU_OD_CCLK,
>  SMU_OD_SCLK,
>  SMU_OD_MCLK,
>  SMU_OD_VDDC_CURVE,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 63be82386964..4d02177cf9b0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -449,6 +449,15 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
>  (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
>  }
>  break;
> +case SMU_OD_CCLK:
> +if (smu->od_enabled) {
> +size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
> +size += sprintf(buf + size, "0: %10uMhz\n",
> +(smu->cpu_actual_hard_min_freq > 0) ? smu->cpu_actual_hard_min_freq : smu->cpu_default_hard_min_freq);
> +size += sprintf(buf + size, "1: %10uMhz\n",
> +(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
> +}
> +break;
>  case SMU_OD_RANGE:
> [Quan, Evan] The allowed frequency range for cclk should prompt user here in SMU_OD_RANGE.

Fine.

>  if (smu->od_enabled) {
>  size = sprintf(buf, "%s:\n", "OD_RANGE");
> @@ -1245,7 +1254,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>  }
> 
>  static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
> -long input[], uint32_t size)
> +long input[], uint32_t size)
>  {
>  int ret = 0;
> 
> @@ -1255,6 +1264,34 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>  }
> 
>  switch (type) {
> +case PP_OD_EDIT_CCLK_VDDC_TABLE:
> +if (size != 3) {
> +dev_err(smu->adev->dev, "Input parameter number not correct (should be 4 for processor)\n");
> +return -EINVAL;
> +}
> +if (input[0] >= boot_cpu_data.x86_max_cores) {
> +dev_err(smu->adev->dev, "core index is overflow, should be less than %d\n",
> +boot_cpu_data.x86_max_cores);
> +}
> +smu->cpu_core_id_select = input[0];
> +if (input[1] == 0) {
> +if (input[2] < smu->cpu_default_hard_min_freq) {
> +dev_warn(smu->adev->dev, "Fine grain setting minimum cclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
> +input[2], smu->cpu_default_hard_min_freq);
> +return -EINVAL;
> +}
> +smu->cpu_actual_hard_min_freq = input[2];
> +} else if (input[1] == 1) {
> +if (input[2] > smu->cpu_default_soft_max_freq) {
> +dev_warn(smu->adev->dev, "Fine grain setting maximum cclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
> +input[2], smu->cpu_default_soft_max_freq);
> +return -EINVAL;
> +}
> +smu->cpu_actual_soft_max_freq = input[2];
> +} else {
> +return -EINVAL;
> +}
> +break;
>  case PP_OD_EDIT_SCLK_VDDC_TABLE:
>  if (size != 2) {
>  dev_err(smu->adev->dev, "Input parameter number not correct\n");
> @@ -1286,6 +1323,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>  } else {
>  smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
>  smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
> +smu->cpu_actual_hard_min_freq = smu->cpu_default_hard_min_freq;
> +smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
> 
>  ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
>  smu->gfx_actual_hard_min_freq, NULL);
> @@ -1300,6 +1339,20 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>  dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
>  return ret;
>  }
> +
> +ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
> +      smu->cpu_actual_hard_min_freq, NULL);
> [Quan, Evan] better to name it as "soft_min_freq" instead of "hard_min_freq".

Fine.

Thanks for your comments.

Ray

> +if (ret) {
> +dev_err(smu->adev->dev, "Set hard min cclk failed!");
> +return ret;
> +}
> +
> +ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
> +      smu->cpu_actual_soft_max_freq, NULL);
> +if (ret) {
> +dev_err(smu->adev->dev, "Set soft max cclk failed!");
> +return ret;
> +}
>  }
>  break;
>  case PP_OD_COMMIT_DPM_TABLE:
> @@ -1326,6 +1379,24 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>  dev_err(smu->adev->dev, "Set soft max sclk failed!");
>  return ret;
>  }
> +
> +ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
> +      ((smu->cpu_core_id_select << 20)
> +       | smu->cpu_actual_hard_min_freq),
> +      NULL);
> +if (ret) {
> +dev_err(smu->adev->dev, "Set hard min cclk failed!");
> +return ret;
> +}
> +
> +ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
> +      ((smu->cpu_core_id_select << 20)
> +       | smu->cpu_actual_soft_max_freq),
> +      NULL);
> +if (ret) {
> +dev_err(smu->adev->dev, "Set soft max cclk failed!");
> +return ret;
> +}
>  }
>  break;
>  default:
> @@ -1351,6 +1422,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
>  smu->gfx_actual_hard_min_freq = 0;
>  smu->gfx_actual_soft_max_freq = 0;
> 
> +smu->cpu_default_hard_min_freq = 1400;
> +smu->cpu_default_soft_max_freq = 3500;
> +smu->cpu_actual_hard_min_freq = 0;
> +smu->cpu_actual_soft_max_freq = 0;
> +
>  return 0;
>  }
> 
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca1f6eb71deeb42ff36b708d8b3b338dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637456929634329975%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nrUPCKEMCJqKBeGMjWfr7%2FCbuVaovJqC6AovtuRMtFk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
