Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4442C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 13:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6482064B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 13:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6482064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42F46EA35;
	Wed,  9 Dec 2020 13:14:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD5E6EA35
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 13:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXTEQr1h+yq5U5kLMApKFXJkmQOsimocfsmGNkQfzwjL1K9HG5RD8+rQ1fsvMotTVkGxVbvKmMJmJa29y1CCLiTA5oHxiHXnT1eQuxn8Ua0yL+XkaFB971hBq9wy1k6FGQ1+XwBKgxaHPhyARp/q3sTrqfSO7FEfKfvFWbOlKrpIXAUXGSNABu/NmtK2lHrwE0xpFmFS2IA+vignUC17e345DsUxHfBT9GNx3DdkoIcyK3EsqzGao284XxecDToECrwturJpqoaiJ23Ml+UyBq811F7Uq+R9B3T00Uwp2lOkemvnb+4+I3tmEc4rchS6m9Ei8pH3tctRBXs2dKF/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0EfaK/j/dgBOzZtzW8YdMzsEs5bVOyKakCVlTob5Oc=;
 b=Y9hnI9CBInoQbsJmSVV1wWh9LNirtIRCffCed/nthIglLJXN9VioI9WlSYxw7zfePoqf0mhmVdX3qrSMCeY7VBLQONunnZqHD8k9wkgKQkHR9YChXbM0HprqHvQaF4IOkAJXJtYwl/PXVcP/1lIut+bQacXQ++p2q0TKZ7tLf5Fxmc1OziJOLeXfktWaueerYnvycg68NTk7KzJnm/JRtBtFsJn8TeFZBpxgGf9BLLqD2zpbqQoQjhRNbZkOM50xfUlu5fJn+grScQDoWnaUym5MbH7+ogJB9dREkQG+Zo8Rybiro5VMRr1kLtYzZnRl/hM3MWSl1NPqHHfUAFrgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0EfaK/j/dgBOzZtzW8YdMzsEs5bVOyKakCVlTob5Oc=;
 b=bRDqs4Ei8H8WIU+IIuqvmDRFilQm0bHwMt3jYDrqIPOTTxTTGXAhLUBwkH0UCpuE6DKYO+u3pwohGeX++Qjyt5xPVO3yoX+tuk63iREaYsDAdtcZ1+XcnzVSxRfxM8A6xUkdaKthoW7qNkxIjrC+oVgTP2pGodEHciyQw359iSw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2587.namprd12.prod.outlook.com (2603:10b6:907:f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 13:14:05 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 13:14:05 +0000
Date: Wed, 9 Dec 2020 21:13:52 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
Subject: Re: [PATCH v2 2/2] drm/amd/pm: inform SMU RLC status thus
 enable/disable DPM feature for vangogh
Message-ID: <20201209131352.GA1245060@hr-amd>
References: <20201209124938.11680-1-Xiaomeng.Hou@amd.com>
 <20201209124938.11680-2-Xiaomeng.Hou@amd.com>
Content-Disposition: inline
In-Reply-To: <20201209124938.11680-2-Xiaomeng.Hou@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 13:14:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42f78752-9e3c-4db2-7f7f-08d89c444dfe
X-MS-TrafficTypeDiagnostic: MW2PR12MB2587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2587E989F3FE03129CF24765ECCC0@MW2PR12MB2587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6nxfWwjkHA6i2nMniIswYKgmqRt9fW9wvDUK6ZIkTTzEPmEgGZx5kaqMIFBOyICCvy+2PO/uTEYKieLs0EbUW9DIaj8LRSPBCocGAfLPU5ZT/G99SPKjhcqgBrCPrctybmA+EYR/b2yNgk7Rch0X05pppdEQsdtOWciWtvGMSTKxLP5z/IMjs03GVv5hXFqTDjIWFwAzfm9ZHrjiAHsTOUDcMnGS8XrMiaPLaRDuwb3WaYHq0YXIaNLAeNUV804ZDVCm5v8xFmlTwnR3vh/oWxPYumFFfM3fWcQDJ+PWhchlA19RfHXv2W8A3tWiQGHCHqrwSMuGT+fe7qamri+j7qm12aiwjS6YeT79Qf5kTLKK28d3airi4bAcQi0eoft
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(186003)(66946007)(16526019)(9686003)(66556008)(26005)(508600001)(6666004)(33716001)(6496006)(52116002)(54906003)(956004)(66476007)(83380400001)(5660300002)(2906002)(55016002)(8676002)(34490700003)(8936002)(6636002)(4326008)(33656002)(86362001)(6862004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m0C3S9WK3/kJOCibdfSSlddWxCDdaTRQBl6siyMPQ6JPzCKZwOFMwoiDsQEL?=
 =?us-ascii?Q?ma+fTIK4OX3mhew0x8wpa3jmJFNg5++YjGSTbknYK88uIIWSmSPhjMZiFG7h?=
 =?us-ascii?Q?7DKk2+FIKNtngOKTXLg7DMGfOiLOKtQYrR3G76ZRGIRBkfEKyKF6v+GBS8Wf?=
 =?us-ascii?Q?JsfpLqJy9DwPSPDizRHstaanSPBG008SYTHdO1r6quIzaVsJ2OErdLXonlF4?=
 =?us-ascii?Q?wFJDheFRmgVQ4VVskAhJNRqFkLhORhATPpEud2T1yFSOjZMRDxZfj6vXI0nP?=
 =?us-ascii?Q?jnewcGJQ5iQFEEAlyYjOgyXDopL7jHF5f+f+qlTdRIjns7lOkp+edlqVS9jo?=
 =?us-ascii?Q?x76mjrfvODbfN2h2E2PmcjBza6MaRP34T/2p4f+bMNImcz2KkIOlPxS2bYLZ?=
 =?us-ascii?Q?eyuIFzDvH3hImEOyLaTSDjkQM4F5AZdUczSzdfW1IwJuqc/ILD3NHoP0vIeu?=
 =?us-ascii?Q?BzHJZgmkBbNsTLz4Z2zAO7XVNAJh4QYcyDaLe1FZoF4UOjZW+YXTlkcKkLNL?=
 =?us-ascii?Q?F4U8K9TtQ5GB3F4Xq9Ce5nsbdJLQzlKDnwba6eGke2G0wRLVqXO2k23mY1hI?=
 =?us-ascii?Q?7sTMiOTe/qhPSmgVehj8H350KuHzm/b0oAvBjNP0G3ViUthuAFe8PmL7zi3P?=
 =?us-ascii?Q?C4piBlhgsoZx6hyDOTp46wqOmfaZnpPackeVqnJcdwdknhMSU82Vs6kpgjr7?=
 =?us-ascii?Q?jN8lRAnC3quk58YFH5lUj/HrjdlsPZwtRj5aioxIwYXP+0Pm3BzKKscWV5yc?=
 =?us-ascii?Q?TyjQ8enCmg7MNJo1KWhWV87bAKOuKqU2Bw+MNlKNvEMIvC2QgJok30/o0V9u?=
 =?us-ascii?Q?fMLhGNF/b5fuAkrhUdxjCHyiTSLQ18gXCwTISJABulJHN4yDQ9XWYytQCpVU?=
 =?us-ascii?Q?XlGOrG1PvzF+ZWSD9d/VXoQkN0bOGi7FM0TNhCaliLLHEHOerm/3iNFmtpc4?=
 =?us-ascii?Q?ZsEBqoabX65B/lxvHpq5QR2OgyZXyNamXDWxxuc4mIMweb+J6bJDS9q82lQd?=
 =?us-ascii?Q?0RhC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 13:14:05.1649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f78752-9e3c-4db2-7f7f-08d89c444dfe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie47i1deKXVap/ji3+I9L4OLje01uMwzN/iNwhWWLQqevM/sbNewNJenNrKkKS/hNoE8xbnP4s2k4HG+CBXRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2587
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 09, 2020 at 08:49:38PM +0800, Hou, Xiaomeng (Matthew) wrote:
> RLC is halted when system suspend/shutdown. However, due to DPM enabled, PMFW is
> unaware of RLC being halted and will continue sending messages, which would
> eventually cause an ACPI hang. Use the system_feature_control interface to
> notify SMU the status of RLC thus enable/disable DPM feature.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++++++++++++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h    |  4 ++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index ddaa6a705fa6..fb16d94b4031 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		0),
>  	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			0),
>  	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			0),
> -	MSG_MAP(Spare,                          PPSMC_MSG_spare,				0),
> +	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
>  	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
>  	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
> @@ -722,6 +722,20 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static int vangogh_system_features_control(struct smu_context *smu, bool en)
> +{
> +	int ret = 0;
> +
> +	if (en)
> +		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
> +								RLC_STATUS_NORMAL, NULL);
> +	else
> +		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
> +								RLC_STATUS_OFF, NULL);

I think we can simplify the codes as below:

return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
                                       en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);

With that update, series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs vangogh_ppt_funcs = {
>  
>  	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -750,6 +764,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>  	.print_clk_levels = vangogh_print_fine_grain_clk,
>  	.set_default_dpm_table = vangogh_set_default_dpm_tables,
>  	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
> +	.system_features_control = vangogh_system_features_control,
>  };
>  
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> index 8756766296cd..eab455493076 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
> @@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu);
>  #define VANGOGH_UMD_PSTATE_SOCCLK       678
>  #define VANGOGH_UMD_PSTATE_FCLK         800
>  
> +/* RLC Power Status */
> +#define RLC_STATUS_OFF          0
> +#define RLC_STATUS_NORMAL       1
> +
>  #endif
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
