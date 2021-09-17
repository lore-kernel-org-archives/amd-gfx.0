Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66ADC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55BA61152
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 15:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A55BA61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344BD6EC80;
	Fri, 17 Sep 2021 15:07:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCACC6EC80
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 15:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku4G8srfa+bGa1Hea4721ubr/cNd1ZKxxqsMiMcTXV3WI0PbMRsFv7adpKUTCaS43g56r0nWeN1CdSbbxB7abP876FVEPm6LJlq5+ATPTDTRA1UTHxxZ8xLwR7dt0NNkF8Whs7CtmrDGAILriB0TgwPxEaeJLnbUyw03OKhaywUaWD/In3OLJgQ2/e229SuNwpcyeyo+BoeMPe7Ua54X+2JYol+cVzS1w9pQX1n/bRah2tFpXgGwldLjo2htc+ghZE2yjv1D0iDpcO71XdjQ9pKkCFAW5nHAeRpqK5TlxDSR9n1Pjl5yWwGyZ9q3dQSnNERjYBypLGUcw+L/oe89QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=75bSvf6hlp/wt41AdvADiatG/sw7DAGnVZaPZyDGkTE=;
 b=Pnerp1iJ0wcXWgvSz7/T14zNhcj+rmyp+vAoacop1NBlekFa73sl7v7Nr1dC0JubZ4J+n7ACLffE8pgbujBnQpoeEJmPp+dF1pAS9THA8cxAZN3GxwfoIgqGTYTaR2CXcer6BI/py64i0pK/k0E79swTILcqNv6HPVdU+/eRCilR1KYw3JbQMccZaBU0ERUDRHvluspnvosMQh9Fue71QeFw5LABUty+NNBvKaj6WeiSM0WyGf6oVVfyWIQzzZk3TJZRuHNlLL9qD0CVoARuTLMTIw0R4XIzTukLzEpEj5Upyzl4D5ybj4mo0/CBQcXIfHpF7SkBnpIRqKiXLmDaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75bSvf6hlp/wt41AdvADiatG/sw7DAGnVZaPZyDGkTE=;
 b=yjeYReZ0zKRKFCKXUVii2JV3U5JItscQSjTlWhm1GQJfFjDcEeU2uVYCcabaJG1fs2jyBfCVPbgjBIgFFS0eW7E3CgQ8NncJcf+fcL6rv6LCO8j4kJeNKrUZNHbB9pN3eYYf870H7D1ap/HiDt6a/Am7QlvmNwK3dkBVEM6qiXE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 15:07:21 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%6]) with mapi id 15.20.4478.025; Fri, 17 Sep 2021
 15:07:21 +0000
Date: Fri, 17 Sep 2021 11:07:17 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Anson Jacob <Anson.Jacob@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: move FPU associated DSC code to DML
 folder
Message-ID: <20210917150717.vdnd4g7owacejv2y@outlook.office365.com>
References: <20210907143235.4309-1-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907143235.4309-1-qingqing.zhuo@amd.com>
X-ClientProxiedBy: BN0PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:408:ec::31) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from outlook.office365.com (2607:fea8:56e0:6d60:c759:3fa8:6ade:8176)
 by BN0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:408:ec::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 15:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80aea446-25ac-4706-79d5-08d979ecd917
X-MS-TrafficTypeDiagnostic: CH0PR12MB5370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB537066E8C17123C65CFFD0AD98DD9@CH0PR12MB5370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfVmnzRV+wJjqdvsQNkyXinvUkfIFbR4yxEClBaabqzM8+Wtx+djMr7V4hK0xOevihh2ovk87daWVxJCIhxbXv/tgIXWg24b/y85/pcZ5dXEQdJMPtcqZP+Vu8Q9H88BO7b028f70IsghI04qAFa+0gCX4mxZ6bMeSBgz710llPAT5tj7Txpjh/M7S7T5mlm+doudMun/wt6YvODK1ZNxGKvXkqwSDqmTo2WJLzSwxMnOjBW0y+6cGwP+HYj8GDfBXvrFEHIm3ij+9EFoFoD9rz1vKFA+/yhfcpfQXRAnRycmZi2XNMSw0KlE9/CgGMIV0U8ohQcK3IVBfRCDZppV4bVUz7Prwjxc2v69dY5KqXBBoR17LnCA2v+71MSHn4gOhlD9k0ZiIhWk71faGPMM6NuCmUID5VcyKNHEH+GynNPo6TLW220sqD6QY8bqoUI+vhXA9DBmwM0YNdfIvnYkbrLjIPFn0vlHZjPMeWi2UxIy7ZkBx6PY0WE45yF1m9lH/OYKLWfYSrLWsMPwxQsAHpm/aFzxzomLMhhkaTGe6of+koUbThE6D8S1i+JruekTPlWAhEpySargxw86PC/eoDHwxkZGF24pZoXssZvUQxbGEbg7mI9N454Znc2uZVMEJ9aVNOPn03Y/Cs/O4J/MgzGcwTyClLNwgHr3xymlZKkdC4Yeac/4ZH2csL7K1VV87TEzTLhx1lfgvgnuHqKHYa+Rq/aBb+aJKl16KMilDAq4vodor/iqylXurQg1bO9ySW8Am57ZYbMIVmoMxlDz5f+d2G5AZtYx/qSxUZhzgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(6666004)(8676002)(52116002)(4326008)(86362001)(5660300002)(966005)(6862004)(7696005)(30864003)(316002)(8936002)(9686003)(55016002)(508600001)(54906003)(186003)(66476007)(6506007)(66556008)(66946007)(83380400001)(66574015)(6636002)(2906002)(38100700002)(461764006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FFBBVK8ennBXE2iBlPczLorgBDI06UVEYS97nJhbSGgY8ao10zfn/dTk85?=
 =?iso-8859-1?Q?+6r1z2FjDQr+I6zSLcSscZTHZG8i74Jhk99jMByBZk1sqOoq4Sw5WpWiqF?=
 =?iso-8859-1?Q?MW1YBHOBLuqf3e06e2DMr7Oi6gmPKCSYfk6PU0It5URwakKLqkF4O7f5GY?=
 =?iso-8859-1?Q?iKs5qG6tuAU5gOSV/4HqzK4NsoXGp/1mppu0edINSsS93OV0SfU10yoDcW?=
 =?iso-8859-1?Q?jet/J6fDaPOQVeaY9edI1SWve8C8fIgpXXpi36v2yIRB0aSsmsnfoyyWZK?=
 =?iso-8859-1?Q?sJmMKshp8hdWmVo2Mhcqa0dV5do7OCTKdpUBuIJzo7GaIAOgraGdvuP2Ng?=
 =?iso-8859-1?Q?o7QRxgYmdDVbGGjm+l+x0zuUwG/OXHVu/wd6+KE+MHs4htPGwXgdkZ6j3T?=
 =?iso-8859-1?Q?kGpYswTgC0lU0AHsGaQbygetM/Mob+YX0N36K/02fpch4BnxNsZiThrxuc?=
 =?iso-8859-1?Q?7ZC/Z8elMQo3qb+s3Ce/PdPlpTWmU/dMU130Xm+shh4nXgGxGU16UDslmb?=
 =?iso-8859-1?Q?8HStORkGRJNn/ZGojTAqhltQpznJHffYAFRJ6b77hJn35DJMBUifDfZukG?=
 =?iso-8859-1?Q?3yrldMfWFj5Hb6sbcvWN++eC5uk2zknnBulbbfuk8uMEW+Fd9BkQt8sgl8?=
 =?iso-8859-1?Q?Zh9+Wqt+Q8Hi14ewrJnpAOjLZzydgZz4nuc/68ncnHRlLCJjHFQF0/yBsQ?=
 =?iso-8859-1?Q?90hflctpAItwUAdzU3iykcD+q8bnyzmbyowLeQuouBDytNMM4CW8Ugc1kD?=
 =?iso-8859-1?Q?bg74Sw968eBzM1BE3sbZRyfZzI/1n1on9xOywhhk6pxZEsEcSnVM+WVw6D?=
 =?iso-8859-1?Q?PSCo2Xl7hOsX4PvL+khFCGo4PFJ8zJM+2zwe1hflgWCBLPUixNYkcW7ph6?=
 =?iso-8859-1?Q?yzvR1FgCjB98RxxQyelaVx0H2nNoYf0rXxjFgVztHPwe78eY+z9Jr69sS6?=
 =?iso-8859-1?Q?ro2AUIRt7/oDocU0WNCZckXV2v3vsO2rcSH04IYGf+CMTOKXhrSZ6kWRgL?=
 =?iso-8859-1?Q?6N8oZ566vzgkFhGaH8hiX7AxqFxwW5+kJpASKCQXmCS+5JOJaXKJCZZbao?=
 =?iso-8859-1?Q?iFXptSkqxHURbtaMf3/pJS1vFtYiYfkJVynyeTshXFGL12mB6Z+Oy1pUTi?=
 =?iso-8859-1?Q?IE27YrSqESBMJV7Dth8MGteR8CsALdhV9OwsiWmmuZrM/b9S61hdxUECRE?=
 =?iso-8859-1?Q?dpxo4yHfdGup5H9ZJQSw2BeZjpFELovmJznN3XeOx/9yCDOHBmFyTmjfeL?=
 =?iso-8859-1?Q?wuTM47gR+RxLqc7xVTNDZ48Yd3IINeHbd01yd2+sANe1JYM9RS7y9dOwSB?=
 =?iso-8859-1?Q?/BQqhQGg34uj/xQHPFI3g5FLPD7B+cxUFLx5Pwf3arpWNZGU6nB1+Il1UM?=
 =?iso-8859-1?Q?Vo2W4a0zmz5+VRA3fAYMfDumXH//HK5EDLOIbu0uZlpdiqL9Q7n01xkXsn?=
 =?iso-8859-1?Q?+y5xZB/FYj8y6fRY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aea446-25ac-4706-79d5-08d979ecd917
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 15:07:21.4438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZqLCuN7C7RMQEs5neLMrZNFpiqBYLaSmCmlbeAoIWha5bHFQyR3eRbFwQHNPdDWOIXwSIWbur5bGT6Q5B061w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
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

Hi Lilian,

This change lgtm.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 09/07, Qingqing Zhuo wrote:
> As part of the FPU isolation work documented in
> https://patchwork.freedesktop.org/series/93042/, isolate
> code that uses FPU in DSC to DML, where all FPU code
> should locate.
> 
> This change does not refactor any fuctions but move code
> around.
> 
> Cc: Anson Jacob <Anson.Jacob@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
>  .../amd/display/dc/{ => dml}/dsc/qp_tables.h  |   0
>  .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 287 ++++++++++++++++++
>  .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  89 ++++++
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   8 -
>  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 257 ----------------
>  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +--
>  .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
>  8 files changed, 380 insertions(+), 315 deletions(-)
>  rename drivers/gpu/drm/amd/display/dc/{ => dml}/dsc/qp_tables.h (100%)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 56055df2e8d2..9009b92490f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> @@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcfla
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
>  CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
>  endif
>  CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> @@ -99,6 +101,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
>  DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
>  DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
>  DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
> +DML += dsc/rc_calc_fpu.o
>  endif
>  
>  AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
> rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> new file mode 100644
> index 000000000000..0436fc64948f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "rc_calc_fpu.h"
> +
> +#include "qp_tables.h"
> +#include "amdgpu_dm/dc_fpu.h"
> +
> +#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> +
> +#define MODE_SELECT(val444, val422, val420) \
> +	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> +
> +
> +#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> +	table = qp_table_##mode##_##bpc##bpc_##max; \
> +	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> +	break
> +
> +static int median3(int a, int b, int c)
> +{
> +	if (a > b)
> +		swap(a, b);
> +	if (b > c)
> +		swap(b, c);
> +	if (a > b)
> +		swap(b, c);
> +
> +	return b;
> +}
> +
> +static double dsc_roundf(double num)
> +{
> +	if (num < 0.0)
> +		num = num - 0.5;
> +	else
> +		num = num + 0.5;
> +
> +	return (int)(num);
> +}
> +
> +static double dsc_ceil(double num)
> +{
> +	double retval = (int)num;
> +
> +	if (retval != num && num > 0)
> +		retval = num + 1;
> +
> +	return (int)retval;
> +}
> +
> +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> +		       enum max_min max_min, float bpp)
> +{
> +	int mode = MODE_SELECT(444, 422, 420);
> +	int sel = table_hash(mode, bpc, max_min);
> +	int table_size = 0;
> +	int index;
> +	const struct qp_entry *table = 0L;
> +
> +	// alias enum
> +	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> +	switch (sel) {
> +		TABLE_CASE(444,  8, max);
> +		TABLE_CASE(444,  8, min);
> +		TABLE_CASE(444, 10, max);
> +		TABLE_CASE(444, 10, min);
> +		TABLE_CASE(444, 12, max);
> +		TABLE_CASE(444, 12, min);
> +		TABLE_CASE(422,  8, max);
> +		TABLE_CASE(422,  8, min);
> +		TABLE_CASE(422, 10, max);
> +		TABLE_CASE(422, 10, min);
> +		TABLE_CASE(422, 12, max);
> +		TABLE_CASE(422, 12, min);
> +		TABLE_CASE(420,  8, max);
> +		TABLE_CASE(420,  8, min);
> +		TABLE_CASE(420, 10, max);
> +		TABLE_CASE(420, 10, min);
> +		TABLE_CASE(420, 12, max);
> +		TABLE_CASE(420, 12, min);
> +	}
> +
> +	if (table == 0)
> +		return;
> +
> +	index = (bpp - table[0].bpp) * 2;
> +
> +	/* requested size is bigger than the table */
> +	if (index >= table_size) {
> +		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> +		return;
> +	}
> +
> +	memcpy(qps, table[index].qps, sizeof(qp_set));
> +}
> +
> +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +{
> +	int   *p = ofs;
> +
> +	if (mode == CM_444 || mode == CM_RGB) {
> +		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> +		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else if (mode == CM_422) {
> +		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> +		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	} else {
> +		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> +		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +		*p++ = -10;
> +		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> +		*p++ = -12;
> +		*p++ = -12;
> +		*p++ = -12;
> +	}
> +}
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version)
> +{
> +	float bpp;
> +	float bpp_group;
> +	float initial_xmit_delay_factor;
> +	int padding_pixels;
> +	int i;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> +	 * target bpp (the latter is what calc_rc_params expects)
> +	 */
> +	if (is_navite_422_or_420)
> +		bpp /= 2.0;
> +
> +	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +
> +	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> +
> +	switch (cm) {
> +	case CM_420:
> +		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> +		break;
> +	case CM_422:
> +		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	case CM_444:
> +	case CM_RGB:
> +		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> +		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> +		rc->second_line_bpg_offset  = 0;
> +		break;
> +	}
> +
> +	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> +	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> +
> +	if (cm == CM_422 || cm == CM_420)
> +		slice_width /= 2;
> +
> +	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> +	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> +		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> +			rc->initial_xmit_delay++;
> +	}
> +
> +	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> +	rc->flatness_det_thresh = 2 << (bpc - 8);
> +
> +	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> +	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> +	if (cm == CM_444 && minor_version == 1) {
> +		for (i = 0; i < QP_SET_SIZE; ++i) {
> +			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> +			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> +		}
> +	}
> +	get_ofs_set(rc->ofs, cm, bpp);
> +
> +	/* fixed parameters */
> +	rc->rc_model_size    = 8192;
> +	rc->rc_edge_factor   = 6;
> +	rc->rc_tgt_offset_hi = 3;
> +	rc->rc_tgt_offset_lo = 3;
> +
> +	rc->rc_buf_thresh[0] = 896;
> +	rc->rc_buf_thresh[1] = 1792;
> +	rc->rc_buf_thresh[2] = 2688;
> +	rc->rc_buf_thresh[3] = 3584;
> +	rc->rc_buf_thresh[4] = 4480;
> +	rc->rc_buf_thresh[5] = 5376;
> +	rc->rc_buf_thresh[6] = 6272;
> +	rc->rc_buf_thresh[7] = 6720;
> +	rc->rc_buf_thresh[8] = 7168;
> +	rc->rc_buf_thresh[9] = 7616;
> +	rc->rc_buf_thresh[10] = 7744;
> +	rc->rc_buf_thresh[11] = 7872;
> +	rc->rc_buf_thresh[12] = 8000;
> +	rc->rc_buf_thresh[13] = 8064;
> +}
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420)
> +{
> +	float bpp;
> +	u32 bytes_per_pixel;
> +	double d_bytes_per_pixel;
> +
> +	dc_assert_fp_enabled();
> +
> +	bpp = ((float)drm_bpp / 16.0);
> +	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> +	// TODO: Make sure the formula for calculating this is precise (ceiling
> +	// vs. floor, and at what point they should be applied)
> +	if (is_navite_422_or_420)
> +		d_bytes_per_pixel /= 2;
> +
> +	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> +
> +	return bytes_per_pixel;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> new file mode 100644
> index 000000000000..d3900ff7fa89
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __RC_CALC_FPU_H__
> +#define __RC_CALC_FPU_H__
> +
> +#include "os_types.h"
> +
> +#define QP_SET_SIZE 15
> +
> +typedef int qp_set[QP_SET_SIZE];
> +
> +struct rc_params {
> +	int      rc_quant_incr_limit0;
> +	int      rc_quant_incr_limit1;
> +	int      initial_fullness_offset;
> +	int      initial_xmit_delay;
> +	int      first_line_bpg_offset;
> +	int      second_line_bpg_offset;
> +	int      flatness_min_qp;
> +	int      flatness_max_qp;
> +	int      flatness_det_thresh;
> +	qp_set   qp_min;
> +	qp_set   qp_max;
> +	qp_set   ofs;
> +	int      rc_model_size;
> +	int      rc_edge_factor;
> +	int      rc_tgt_offset_hi;
> +	int      rc_tgt_offset_lo;
> +	int      rc_buf_thresh[QP_SET_SIZE - 1];
> +};
> +
> +enum colour_mode {
> +	CM_RGB,   /* 444 RGB */
> +	CM_444,   /* 444 YUV or simple 422 */
> +	CM_422,   /* native 422 */
> +	CM_420    /* native 420 */
> +};
> +
> +enum bits_per_comp {
> +	BPC_8  =  8,
> +	BPC_10 = 10,
> +	BPC_12 = 12
> +};
> +
> +enum max_min {
> +	DAL_MM_MIN = 0,
> +	DAL_MM_MAX = 1
> +};
> +
> +struct qp_entry {
> +	float         bpp;
> +	const qp_set  qps;
> +};
> +
> +typedef struct qp_entry qp_table[];
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +				    bool is_navite_422_or_420);
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +			       enum bits_per_comp bpc, u16 drm_bpp,
> +			       bool is_navite_422_or_420,
> +			       int slice_width, int slice_height,
> +			       int minor_version);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index 8d31eb75c6a6..8d01b8a9fc6a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -2,14 +2,6 @@
>  #
>  # Makefile for the 'dsc' sub-component of DAL.
>  
> -ifdef CONFIG_X86
> -dsc_ccflags := -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dsc_ccflags := -mhard-float -maltivec
> -endif
> -
>  ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> index 7b294f637881..87acec33b8d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> @@ -25,264 +25,7 @@
>   */
>  #include <drm/drm_dsc.h>
>  
> -#include "os_types.h"
>  #include "rc_calc.h"
> -#include "qp_tables.h"
> -
> -#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_min)
> -
> -#define MODE_SELECT(val444, val422, val420) \
> -	(cm == CM_444 || cm == CM_RGB) ? (val444) : (cm == CM_422 ? (val422) : (val420))
> -
> -
> -#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, max)): \
> -	table = qp_table_##mode##_##bpc##bpc_##max; \
> -	table_size = sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \
> -	break
> -
> -
> -static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
> -		       enum max_min max_min, float bpp)
> -{
> -	int mode = MODE_SELECT(444, 422, 420);
> -	int sel = table_hash(mode, bpc, max_min);
> -	int table_size = 0;
> -	int index;
> -	const struct qp_entry *table = 0L;
> -
> -	// alias enum
> -	enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> -	switch (sel) {
> -		TABLE_CASE(444,  8, max);
> -		TABLE_CASE(444,  8, min);
> -		TABLE_CASE(444, 10, max);
> -		TABLE_CASE(444, 10, min);
> -		TABLE_CASE(444, 12, max);
> -		TABLE_CASE(444, 12, min);
> -		TABLE_CASE(422,  8, max);
> -		TABLE_CASE(422,  8, min);
> -		TABLE_CASE(422, 10, max);
> -		TABLE_CASE(422, 10, min);
> -		TABLE_CASE(422, 12, max);
> -		TABLE_CASE(422, 12, min);
> -		TABLE_CASE(420,  8, max);
> -		TABLE_CASE(420,  8, min);
> -		TABLE_CASE(420, 10, max);
> -		TABLE_CASE(420, 10, min);
> -		TABLE_CASE(420, 12, max);
> -		TABLE_CASE(420, 12, min);
> -	}
> -
> -	if (table == 0)
> -		return;
> -
> -	index = (bpp - table[0].bpp) * 2;
> -
> -	/* requested size is bigger than the table */
> -	if (index >= table_size) {
> -		dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
> -		return;
> -	}
> -
> -	memcpy(qps, table[index].qps, sizeof(qp_set));
> -}
> -
> -static double dsc_roundf(double num)
> -{
> -	if (num < 0.0)
> -		num = num - 0.5;
> -	else
> -		num = num + 0.5;
> -
> -	return (int)(num);
> -}
> -
> -static double dsc_ceil(double num)
> -{
> -	double retval = (int)num;
> -
> -	if (retval != num && num > 0)
> -		retval = num + 1;
> -
> -	return (int)retval;
> -}
> -
> -static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> -{
> -	int   *p = ofs;
> -
> -	if (mode == CM_444 || mode == CM_RGB) {
> -		*p++ = (bpp <=  6) ? (0) : ((((bpp >=  8) && (bpp <= 12))) ? (2) : ((bpp >= 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-2) : ((((bpp >=  8) && (bpp <= 12))) ? (0) : ((bpp >= 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-4) : ((((bpp >=  8) && (bpp <= 12))) ? (-2) : ((bpp >= 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <=  6) ? (-6) : ((((bpp >=  8) && (bpp <= 12))) ? (-4) : ((bpp >= 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));
> -		*p++ = (bpp <= 12) ? (-6) : ((bpp >= 15) ? (0) : (-6 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-2) : (-8 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-4) : (-8 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-8) : ((bpp >= 15) ? (-6) : (-8 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = (bpp <= 12) ? (-10) : ((bpp >= 15) ? (-8) : (-10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >=  8) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else if (mode == CM_422) {
> -		*p++ = (bpp <=  8) ? (2) : ((bpp >= 10) ? (10) : (2 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (8) : (0 + dsc_roundf((bpp -  8) * (8 / 2.0))));
> -		*p++ = (bpp <=  8) ? (0) : ((bpp >= 10) ? (6) : (0 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-2) : ((bpp >= 10) ? (4) : (-2 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-4) : ((bpp >= 10) ? (2) : (-4 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-6) : ((bpp >= 10) ? (0) : (-6 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-2) : (-8 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-4) : (-8 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-8) : ((bpp >= 10) ? (-6) : (-8 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = (bpp <=  8) ? (-10) : ((bpp >= 10) ? (-8) : (-10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  6) ? (-12) : ((bpp >= 7) ? (-10) : (-12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	} else {
> -		*p++ = (bpp <=  6) ? (2) : ((bpp >=  8) ? (10) : (2 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (8) : (0 + dsc_roundf((bpp -  6) * (8 / 2.0))));
> -		*p++ = (bpp <=  6) ? (0) : ((bpp >=  8) ? (6) : (0 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-2) : ((bpp >=  8) ? (4) : (-2 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-4) : ((bpp >=  8) ? (2) : (-4 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-6) : ((bpp >=  8) ? (0) : (-6 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-2) : (-8 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-4) : (-8 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-8) : ((bpp >=  8) ? (-6) : (-8 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = (bpp <=  6) ? (-10) : ((bpp >=  8) ? (-8) : (-10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -		*p++ = -10;
> -		*p++ = (bpp <=  4) ? (-12) : ((bpp >=  5) ? (-10) : (-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> -		*p++ = -12;
> -		*p++ = -12;
> -		*p++ = -12;
> -	}
> -}
> -
> -static int median3(int a, int b, int c)
> -{
> -	if (a > b)
> -		swap(a, b);
> -	if (b > c)
> -		swap(b, c);
> -	if (a > b)
> -		swap(b, c);
> -
> -	return b;
> -}
> -
> -static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> -			       enum bits_per_comp bpc, u16 drm_bpp,
> -			       bool is_navite_422_or_420,
> -			       int slice_width, int slice_height,
> -			       int minor_version)
> -{
> -	float bpp;
> -	float bpp_group;
> -	float initial_xmit_delay_factor;
> -	int padding_pixels;
> -	int i;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	/* in native_422 or native_420 modes, the bits_per_pixel is double the
> -	 * target bpp (the latter is what calc_rc_params expects)
> -	 */
> -	if (is_navite_422_or_420)
> -		bpp /= 2.0;
> -
> -	rc->rc_quant_incr_limit0 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->rc_quant_incr_limit1 = ((bpc == BPC_8) ? 11 : (bpc == BPC_10 ? 15 : 19)) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -
> -	bpp_group = MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> -
> -	switch (cm) {
> -	case CM_420:
> -		rc->initial_fullness_offset = (bpp >=  6) ? (2048) : ((bpp <=  4) ? (6144) : ((((bpp >  4) && (bpp <=  5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = median3(0, 12, (int)((3 * bpc * 3) - (3 * bpp_group)));
> -		break;
> -	case CM_422:
> -		rc->initial_fullness_offset = (bpp >=  8) ? (2048) : ((bpp <=  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	case CM_444:
> -	case CM_RGB:
> -		rc->initial_fullness_offset = (bpp >= 12) ? (2048) : ((bpp <=  8) ? (6144) : ((((bpp >  8) && (bpp <= 10))) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))));
> -		rc->first_line_bpg_offset   = median3(0, (12 + (int) (0.09 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm == CM_444 ? 0 : 2)) * 3) - (3 * bpp_group)));
> -		rc->second_line_bpg_offset  = 0;
> -		break;
> -	}
> -
> -	initial_xmit_delay_factor = (cm == CM_444 || cm == CM_RGB) ? 1.0 : 2.0;
> -	rc->initial_xmit_delay = dsc_roundf(8192.0/2.0/bpp/initial_xmit_delay_factor);
> -
> -	if (cm == CM_422 || cm == CM_420)
> -		slice_width /= 2;
> -
> -	padding_pixels = ((slice_width % 3) != 0) ? (3 - (slice_width % 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> -	if (3 * bpp_group >= (((rc->initial_xmit_delay + 2) / 3) * (3 + (cm == CM_422)))) {
> -		if ((rc->initial_xmit_delay + padding_pixels) % 3 == 1)
> -			rc->initial_xmit_delay++;
> -	}
> -
> -	rc->flatness_min_qp     = ((bpc == BPC_8) ?  (3) : ((bpc == BPC_10) ? (7)  : (11))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_max_qp     = ((bpc == BPC_8) ? (12) : ((bpc == BPC_10) ? (16) : (20))) - ((minor_version == 1 && cm == CM_444) ? 1 : 0);
> -	rc->flatness_det_thresh = 2 << (bpc - 8);
> -
> -	get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> -	get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> -	if (cm == CM_444 && minor_version == 1) {
> -		for (i = 0; i < QP_SET_SIZE; ++i) {
> -			rc->qp_min[i] = rc->qp_min[i] > 0 ? rc->qp_min[i] - 1 : 0;
> -			rc->qp_max[i] = rc->qp_max[i] > 0 ? rc->qp_max[i] - 1 : 0;
> -		}
> -	}
> -	get_ofs_set(rc->ofs, cm, bpp);
> -
> -	/* fixed parameters */
> -	rc->rc_model_size    = 8192;
> -	rc->rc_edge_factor   = 6;
> -	rc->rc_tgt_offset_hi = 3;
> -	rc->rc_tgt_offset_lo = 3;
> -
> -	rc->rc_buf_thresh[0] = 896;
> -	rc->rc_buf_thresh[1] = 1792;
> -	rc->rc_buf_thresh[2] = 2688;
> -	rc->rc_buf_thresh[3] = 3584;
> -	rc->rc_buf_thresh[4] = 4480;
> -	rc->rc_buf_thresh[5] = 5376;
> -	rc->rc_buf_thresh[6] = 6272;
> -	rc->rc_buf_thresh[7] = 6720;
> -	rc->rc_buf_thresh[8] = 7168;
> -	rc->rc_buf_thresh[9] = 7616;
> -	rc->rc_buf_thresh[10] = 7744;
> -	rc->rc_buf_thresh[11] = 7872;
> -	rc->rc_buf_thresh[12] = 8000;
> -	rc->rc_buf_thresh[13] = 8064;
> -}
> -
> -static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> -				    bool is_navite_422_or_420)
> -{
> -	float bpp;
> -	u32 bytes_per_pixel;
> -	double d_bytes_per_pixel;
> -
> -	bpp = ((float)drm_bpp / 16.0);
> -	d_bytes_per_pixel = dsc_ceil(bpp * slice_width / 8.0) / slice_width;
> -	// TODO: Make sure the formula for calculating this is precise (ceiling
> -	// vs. floor, and at what point they should be applied)
> -	if (is_navite_422_or_420)
> -		d_bytes_per_pixel /= 2;
> -
> -	bytes_per_pixel = (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> -
> -	return bytes_per_pixel;
> -}
>  
>  /**
>   * calc_rc_params - reads the user's cmdline mode
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> index 262f06afcbf9..c2340e001b57 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> @@ -27,55 +27,7 @@
>  #ifndef __RC_CALC_H__
>  #define __RC_CALC_H__
>  
> -
> -#define QP_SET_SIZE 15
> -
> -typedef int qp_set[QP_SET_SIZE];
> -
> -struct rc_params {
> -	int      rc_quant_incr_limit0;
> -	int      rc_quant_incr_limit1;
> -	int      initial_fullness_offset;
> -	int      initial_xmit_delay;
> -	int      first_line_bpg_offset;
> -	int      second_line_bpg_offset;
> -	int      flatness_min_qp;
> -	int      flatness_max_qp;
> -	int      flatness_det_thresh;
> -	qp_set   qp_min;
> -	qp_set   qp_max;
> -	qp_set   ofs;
> -	int      rc_model_size;
> -	int      rc_edge_factor;
> -	int      rc_tgt_offset_hi;
> -	int      rc_tgt_offset_lo;
> -	int      rc_buf_thresh[QP_SET_SIZE - 1];
> -};
> -
> -enum colour_mode {
> -	CM_RGB,   /* 444 RGB */
> -	CM_444,   /* 444 YUV or simple 422 */
> -	CM_422,   /* native 422 */
> -	CM_420    /* native 420 */
> -};
> -
> -enum bits_per_comp {
> -	BPC_8  =  8,
> -	BPC_10 = 10,
> -	BPC_12 = 12
> -};
> -
> -enum max_min {
> -	DAL_MM_MIN = 0,
> -	DAL_MM_MAX = 1
> -};
> -
> -struct qp_entry {
> -	float         bpp;
> -	const qp_set  qps;
> -};
> -
> -typedef struct qp_entry qp_table[];
> +#include "dml/dsc/rc_calc_fpu.h"
>  
>  void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps);
>  u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index ef830aded5b1..1e19dd674e5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -22,7 +22,6 @@
>   * Authors: AMD
>   *
>   */
> -#include "os_types.h"
>  #include <drm/drm_dsc.h>
>  #include "dscc_types.h"
>  #include "rc_calc.h"
> -- 
> 2.25.1
> 

-- 
Rodrigo Siqueira
https://siqueira.tech
