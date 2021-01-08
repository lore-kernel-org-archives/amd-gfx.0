Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55764C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 11:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC16323976
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 11:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16323976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743CB89AFF;
	Fri,  8 Jan 2021 11:00:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7BD89AFF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 11:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsBmWXU1I2pHoW7hr4UaVeQBMxKxvtMFpkBVekm+NATmpbQEot0d9Ey5tPBVmDKNjX5H+74nKJJ3j1TJ3rIQu6Qrf/F/5zRwtQpYoBLBpwq1SoCssz7JCTogfxEJYJBef0OKZ7TJDQuDVVXwE9xKad2MCybYAbF7LFxoaL/0hX5Uz4ULSwHYJyONFV7rJAViQX2OpnmeJQZX/F+y8PW37oaZwvepUbcxOMakecsIJCI6rotwwBpuqp15srVcpf9yjhiqBox7bwBo6yO/sYU6ZPtLTt+px1T0oRbA/Gcx+S4Aak8bpkRrkguEoNUXP15IjP8nB4b+6mijhZS9i7+AdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myyc7AoRqTgqqmNwzYJVwaWhr0UDOxWKGMGABH4nQM0=;
 b=lPPHhQ5e9ZYLh9BN0jZt9Z/F3I6GRVVkkSHxY3JzDsMzEBsW/JrbC00zZt4Z4inUM2FQCQzNSCBX9t9WX5m91lK2FZEQTuV+NxRMg5Qz1z5VSOAzGwnJEyF2s8Wpcu1ILwqwaQD/d3N6ZRq/7sSZeDFDwLcdlBXC3EDsUGeKp6DXZdlYteSAXOcOIMKoRYJuZVj0tBbySaCnOKF862cCMp3OyBiS7yc4CV98MopsVtxRFAk1Fp8epYHybiVsEiAlH/RJBDZgo73skQQh4cHpYSZ90yyPpMOox5D7hZ5N8Mry368sZjYaxRTUhtMhn+V+r4OhqhQ3Z8E1TJKl27dpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myyc7AoRqTgqqmNwzYJVwaWhr0UDOxWKGMGABH4nQM0=;
 b=v1XaEQcTxP7XhOlHqLwsTsN+ep+VjXg8b39wJH0nWA1UvhML6xnS6dLmO1RxkcSZf8DVHf5QnfSwkWlHbTKTvcGk/vWLKmwM8x/AxLQnAlz6TMje3elpCVjNSOfvb7EMqJXaFPtuB8HKnBlbwfoY88sa5cwI/Lc3NPAp+EbZCYQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0048.namprd12.prod.outlook.com (2603:10b6:301:59::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 11:00:05 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 11:00:05 +0000
Date: Fri, 8 Jan 2021 18:59:57 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>
Subject: Re: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature
 for vangogh
Message-ID: <20210108105957.GA1164783@hr-amd>
References: <20210108085507.1164588-1-ray.huang@amd.com>
 <20210108085507.1164588-8-ray.huang@amd.com>
 <DM6PR12MB2619B9C5907EC6CA8A506A5AE4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619B9C5907EC6CA8A506A5AE4AE0@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:203:d0::15) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HKAPR04CA0005.apcprd04.prod.outlook.com (2603:1096:203:d0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 11:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed32736d-da74-409d-ef24-08d8b3c48e18
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0048126064C7664C8DB0E98BECAE0@MWHPR1201MB0048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGo3olyjaE6dJxt9mhIVonrqY2McgUlsEcBbk9zl5/5FmNawE/o9HcK2a53+M+vfj2+42C9yfehiEH1DpovrZw/6y+nS1a7PDgcEuvclERGA889hKSCpgHtf3iLRuN3NjIUOyRg03bBMtGJJP9O5EJVqIMHJnSRD5xFt+fWsKs0k00Gmr5NXYJfPNwiHf4FBjbE1sGIuY4k2ACI9DWBYweWMA5YVyZD+ujSyGH7soLdTrW0Ub3jtLY2je1yuaK2CQ8fSRZNJqtHHNYB1UzUhB9QvNJLusDniY4TVR6ENmrvIy4N+ag0Mu1fk1BKDoqaeZxTOSMIoqHntOWU0XPl8TUic+NwsxOgxVbFX27YjQE9lYs9/qe8UkT84tGvnPv+ftdii4zmrwkJcJdfWzHL0fVjVGaM3A/T5S0Npf25oOCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(6666004)(316002)(1076003)(83380400001)(54906003)(6636002)(6496006)(53546011)(66556008)(55016002)(26005)(186003)(16526019)(33656002)(2906002)(86362001)(956004)(66946007)(8936002)(4326008)(33716001)(478600001)(45080400002)(5660300002)(52116002)(966005)(6862004)(8676002)(9686003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GXOZfL/Tai2WhmA49pYKmvH+2tCEuq+p5vtCm98/AKbrnpT7vJrl6AHqZ1RS?=
 =?us-ascii?Q?0dWgCKICoIh1lAAwRc073fzWe6lHNkyx87ZlTVsd8IlrMhFp8y+4cKjMVAJG?=
 =?us-ascii?Q?zE1O7BUUwNTw3ePjizOOd6tzoNzws97bWD37WJ701/sAFzaEwXdbYslSjcnS?=
 =?us-ascii?Q?VLvAESAmtplyWJ/bijGfQR1gyhsad7sxed5SFrFVE92LlPq2Y9J4g4mDLOaH?=
 =?us-ascii?Q?i+m4I6kbqmYZqKH5kh6Ukf5Q8hzbLHMHUc1EnIgW2xRbf5Mb/5c2dLDTAVsm?=
 =?us-ascii?Q?bm8mbmUYYUFYQCqXsFzV046RlBICwz23uNMcxjAbsFLBqf/Rue2ERIKSzpWj?=
 =?us-ascii?Q?5E2YUx+r8zgVftRDb47X8lhjkWuJBMvSvyAIxEo9Bp/aS9a+1Hi0zeobDKty?=
 =?us-ascii?Q?7Q1aZ2K5ESkXvm8N2K/ll78As+xL4NWVdveeipIU8f8Qui//zpwyDWfgbcoQ?=
 =?us-ascii?Q?hJ+abcd22Q4Do42Sh5Gx1DAn82wQtAcSdSFSSwop8rpheUZSFqf087iy6jXP?=
 =?us-ascii?Q?CMGAnmElJty4PEKDo1ttSvcacxPkqI55jK7s+fFSa/Q3Ho9Oad9CqxBDFtXi?=
 =?us-ascii?Q?MDhO/inzax6dUkC+PR9Km3d8qARA8SiVhbSTcrP2RSmGNKKdRAHxPHq7Ro1t?=
 =?us-ascii?Q?78ZTjKgZiMzhwuFDPZlVcYKzrNFW35pN4cTYFM7Fk/k9F0yB85CjJK7zOCoF?=
 =?us-ascii?Q?LSG95C+x3NdDBI3gpSxg/SbbFKlofM4jqvf/q4HB14LMYHsUZiD6RcXHJ3xa?=
 =?us-ascii?Q?mCRfCXRiKuaEt0eJUGwobFOjPbtYV0wHQCDffn4svTBZF1iWTmR3H6jz4FUb?=
 =?us-ascii?Q?M64iofzt0tCAM6e7z3u4yEkXyryUZmlzqYG1MQKRX8tNKnY8JLrgYyMGt3FN?=
 =?us-ascii?Q?EFHqKzbeCCBdIQZubQ8AOsWI7nUODwglMtGB6VQxxVxh9SzUGR92vAbQ2HL8?=
 =?us-ascii?Q?aJkTKv+JsCR8zz8rZEkYHZxlT91JBx3G+0sWN44tiuFtMbbHvlM7W1Kg6Vix?=
 =?us-ascii?Q?6F8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 11:00:04.9836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ed32736d-da74-409d-ef24-08d8b3c48e18
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL5wVrDwlW3RKh1QbEbIxaCn1xKwv5bH7ZfKW1C822T6L7MWZjobOPWO+nuZ1P6iDfH2l4Re34CMcx7WEUD+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0048
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

I think about it again, we should not combine the fine grain and OD feature
together on the prints. APU doesn't support OD, it will make user confused.

Alternative, we can combine the fine grain prints both cpu and gfx together
here instead.

Thanks,
Ray

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
