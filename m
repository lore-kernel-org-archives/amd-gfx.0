Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3F961107
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD3F961107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF466E9AF;
	Fri, 29 Oct 2021 02:35:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AF06E9AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 02:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHyzAo7RtubxKo/lZJfJhjfay5GA39hoH01ULLDsi9fMyv4c3npz3GjOTmsXE8wocOxRAol8QK12VVH75hB6/FyVdOKrswTtEFCIAyHAwBvLM88sL0MPJ44I+syc5OuFO0/QDhoixnr+P2SKJPxxOQeLbK8Lvwkaf1MvrvjLLwL1uSqfZUU5bTZ7XRo8sRpRnV7oJwGRkr0l2dgNgdwZqhi2YylrvUWVO4C3Mp+V6rJDcf1TNFI3lXilxrTuZfPf2jiS66+x0xfVP/q+6/TLN/7o/fx+CZEbxeboSaHACE0NvFM3736VRKmieMjoaBHIVMyxCJ4BZ1b5DNh1kzQWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hlDKItWe6Y79udHs6HNGPNiZOaH1g089Q5Tv/VN/YU=;
 b=FI5FRrvdGc7U9ltCQB7O6h/LoGfLxxtvpcd6x0HXOYpR+CUYXQNLkIytTsY9DfRcSxyOeUtEGThn9sQWQ6GdpGOxtwo24DmeXQBMjox8DUjOzkLttWbgHOLAvwKUCBm37u7QWhReCSrnB+qX7ymhOceRPW9+rI6L54u15aySpFZ9JVCImfV6/U8She4uRdJXo5skrIVJ+uonDIqc+3+X88VbK4dY1vFzGmgugfMScHRX2nGzgz2Z03AfMc1Q7UevbwuXYa4i2JgBIW2AzrR2yLNKlzyk8tqAQ/2RyUkQaLYvT9l0/QnoFZdBIXHqaPtR5bz6y3CMiXlgIxQvX4KZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hlDKItWe6Y79udHs6HNGPNiZOaH1g089Q5Tv/VN/YU=;
 b=SHiikzuPXcWNGPMv0CY0Mb82x2JHuyWp2ZhRep0kG5FHNVEXKyniF4EiRoD6UTjUkBNoiBdX9/8JBJu8SrpDO1PNGlAEf4RVW89V486XBXVI3P6mhsxeyGMOAfkKW15Vw6OQrW6/gMBbZ5Q2km8vA+MWiuP+exiWIw0L9OFxJwM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com (10.174.53.144) by
 CY4PR1201MB0056.namprd12.prod.outlook.com (10.172.78.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Fri, 29 Oct 2021 02:35:49 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 02:35:49 +0000
Date: Fri, 29 Oct 2021 10:35:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
Message-ID: <YXtd7LmF7Brsjrpk@hr-amd>
References: <20211028155336.2990-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028155336.2990-1-mario.limonciello@amd.com>
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by
 HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.5 via Frontend Transport; Fri, 29 Oct 2021 02:35:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84dfd3a-03d1-4211-e149-08d99a84d161
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056CA1A00E9B015D34C0ADAEC879@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SYjZbW0SEI4NcV1cV97/4mtGjxJKH5EkrSi5wmv/Qh44pjH7mzZVyY1Tim6yROwYhj6xo6mK8IGnw4X9Xz+B7Ox/FyQYN1GjnT/Wy16evfmq3jjV5GNaOglrt3n3Npla8XHDQWnzQDFkokqXuIBbFgGPF6a5+02y9CmixCuoFnNqskxLaf7HaGaeQLu/K4qOePyx6TxWSDdXgtp09MVkTOclE4KLKXJFdfSf+vEAB3b5qsYuXyeSZwOMRQkLX/CzI/Xj52eIbbs4c5Uu65E9ulCLwVC2C9re2DjP1QHN748oykhQwsSyjPnUR6XXS3RbtPevpSG1l+ynHfm369AxBKsscmJzATU/jNd6SCUNKm5M3kqiB0I0wGkuGBZqeMEarA8CdpWKQhUlOrA7b24vTJtqwO7PqrHN4+LQB/+P2Ny7aeimeRQw39i5e9FKkNsEmNNXXJxVx6kONduR4+/iRBC8cvh1hbeuDAQNQAc5gJypaKbkzSfB70kDqwjrY9MWvsmU8Z+XDCjuW5EfCgze100WhpsXyWdO6e9RWAtqVwdXU76GYs9swuGpNxUiKrgdPMm5yssZCDX1wFY84JIJHoPGEwZJcdGJ/fyWrZErNgLY9nELRWjPkFkUZOUGOEEwgzL5QMwku9jrN2aAxMb+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(86362001)(6496006)(19627235002)(66946007)(55016002)(6862004)(5660300002)(33716001)(8936002)(956004)(26005)(186003)(316002)(6636002)(6666004)(2906002)(66556008)(83380400001)(508600001)(66476007)(38100700002)(4326008)(30864003)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAqnkQWuUJToEa46DjElNpcIRISvq35v7HIOWf9cZ1iN22y3FPxHVOKQ/jfb?=
 =?us-ascii?Q?WDFpIN/YOXPqUdNrRwq4KY6g+pr1VajK9uWw2MMWgBOWka+j8J3hhNE0uk9t?=
 =?us-ascii?Q?1xRQCHNvizQldLNFerv27uT+S0o/dghtRqoNO9/pvwlf6RLy5WQJeUuBg3v+?=
 =?us-ascii?Q?sCeHfrXjzadbIymYamxbCu6/yLRbgS9g7CEi3trBszXX5cGJY3L3Op2/zqGg?=
 =?us-ascii?Q?pyLS37J44zW0oQEo9p9mjNCnkCu4caOMjUPo9buNP6B+JAFFRa05Ltkps3Aa?=
 =?us-ascii?Q?Br7JVVublbITSy3MjV4p0gftigDtSvC09TY9RbQhP+q+qZahgppklX0AwnJa?=
 =?us-ascii?Q?UcI2wqk2ZVVvsTZXuQPLwdsuPaCRvsWvceTUPeM2n8AiqOs2HIhqgOs+okVd?=
 =?us-ascii?Q?cSS/JuhAReJaNcd3kMUxquMxDR2w6cVRJy0YI0KeNrTjPg31NQnxMf3Jxepx?=
 =?us-ascii?Q?ETi734LgOXfMRtSpB0xNO3NSZ9wUUANQkrK1ltlCLJh6nWuaoIyOJyR5GnNk?=
 =?us-ascii?Q?v5wnDkiTEVb8rbpFU/A8eau+WrrsI0ROeHzJDrT5E+zFgZ/s+jMHO9I1ujdI?=
 =?us-ascii?Q?5kcbRR8cctFMq3Nzc+b8N1HRMceH/VVwjm4ThCee/RPPD00crNm4O9gUgU8r?=
 =?us-ascii?Q?H4N9LobfXRv17ELwZsF7LqglpGuVlfN5wH5u6CUH+qN24+Mbeozq+drMgzfi?=
 =?us-ascii?Q?TCivvcxrIVvjpVOisEnOPuzyJM0d9cHvGFvfSPw0Qlxx2jTRay4zR/wyeqVn?=
 =?us-ascii?Q?GHYm4HwjDksin850Kpmde5zb06nYBQp2ByyOEISsuMOImrWF2e+85C40g3uB?=
 =?us-ascii?Q?qAb/ArHKIgWYO2sVFjWF7MSTUUQhYMHjJ7gpUkhcYSMSNMqXWRvX6hhnUT/H?=
 =?us-ascii?Q?yq6nQCRehrNVlo8Ii+aIgLi3Lwu75xtYDrgSz0E0PY9+k11geeKNZs2ZPxZT?=
 =?us-ascii?Q?Sgp0/JqcqyJryzVliApXRRizm3D0SOFRGrmlbFbf2+dIYbhTfB/MvgiJc1Lj?=
 =?us-ascii?Q?iC55bGFDCU4FtU7zfVOUdWB0z/A5kRbJGyYnAuxfiMrSxiaLsmdIN1+yq5T0?=
 =?us-ascii?Q?PkTp2XcHF1N/2WuBHBFYd8wWEx2Nd2JgX7E0nFQHHmZ1BKAxopBrSDcNw8j9?=
 =?us-ascii?Q?YfBTvI0RJltdsTxSm+LAb7Tr9f27Wcp93xcM+pWI9CNHFlOXERSeNyY/G9rR?=
 =?us-ascii?Q?xAPdbKyihH/wTj0fnXWQ7+jNrfadEpJEXobxjtx8W4LQSrzvtMre7wsU4kKM?=
 =?us-ascii?Q?sNmBEz1QLHG89etJbk1se3ol+YatsYSYKIlZfWjYIFet3uxrsVM6DiQDXF4w?=
 =?us-ascii?Q?1lqhicpZMADG3S4HpFnEJUTntn3DtEhinzgC30h2D80cxNNlC9K8pQNZBTyT?=
 =?us-ascii?Q?a57Q7bTP/fRneUdvM1CBcNBWm7Ogw/zcpF5dlWyb8/0xyooh8N3/KP/Srwbs?=
 =?us-ascii?Q?hmulB2fc/eNub4O+ffpCzB/1V6il0FiZ8NwJW+hgZBbLmhXVGInmQMtfLx2G?=
 =?us-ascii?Q?dBJDkC4e3jm00tPtW968GrgQTnOWKrwXUHP1hXtIUGLGkleCaziX1rVB6kXd?=
 =?us-ascii?Q?Xrb/BYWDCg852LI1d/lp9Cd5HEndSW4H5JUmFUEyzvWatUo1p2GBTBFplS9M?=
 =?us-ascii?Q?RRb4enlVrl6h7yDvzt0kwn8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84dfd3a-03d1-4211-e149-08d99a84d161
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 02:35:49.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXmqA8mBvQHGnm9OLoSXi/VRlKSC30pVnN4SgRRUcpuVJoa4yYh+JaggaTnEeWAaDDcd7dYUX3qM5JCjppnw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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

On Thu, Oct 28, 2021 at 10:53:36AM -0500, Mario Limonciello wrote:
> Although this has been plumbed for Renoir, Green Sardine, Van Gogh,
> and Yellow Carp the functionality in the SMU doesn't do anything for

I double confirmed them in the firmware. These messages are actually
existed in SMU firmware of Renoir, Van Gogh, and Green Sardine, we should
not remove them in these platforms.

And for Yellow Carp, it is better to use a firmware check to skip the
function than remove them entirely in case somebody doesn't upgrade his/her
SBIOS.

Thanks,
Ray

> these APUs.  Drop the associated code with them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
>  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
>  4 files changed, 2 insertions(+), 262 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> index 1d3447991d0c..23d24173bc5d 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> @@ -51,7 +51,7 @@
>  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
>  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
>  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
> +#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
>  #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
>  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
>  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
> @@ -63,7 +63,7 @@
>  #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
>  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
>  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
> -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
> +#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
>  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
>  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
>  #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 421f38e8dada..2451d990d577 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
>  	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
> -	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
>  	MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,	0),
>  	MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,	0),
>  	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	0),
> @@ -182,14 +181,6 @@ static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP_VALID(DPMCLOCKS),
>  };
>  
> -static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
> -
>  static const uint8_t vangogh_throttler_map[] = {
>  	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
>  	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
> @@ -1010,80 +1001,6 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int vangogh_get_power_profile_mode(struct smu_context *smu,
> -					   char *buf)
> -{
> -	static const char *profile_name[] = {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size = 0;
> -	int16_t workload_type = 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> -		 * Not all profile modes are supported on vangogh.
> -		 */
> -		workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -
> -		if (workload_type < 0)
> -			continue;
> -
> -		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> -{
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> -					workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> -}
> -
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>  					  enum smu_clk_type clk_type,
>  					  uint32_t min,
> @@ -2190,8 +2107,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>  	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
>  	.system_features_control = vangogh_system_features_control,
>  	.feature_is_enabled = smu_cmn_feature_is_enabled,
> -	.set_power_profile_mode = vangogh_set_power_profile_mode,
> -	.get_power_profile_mode = vangogh_get_power_profile_mode,
>  	.get_dpm_clock_table = vangogh_get_dpm_clock_table,
>  	.force_clk_levels = vangogh_force_clk_levels,
>  	.set_performance_level = vangogh_set_performance_level,
> @@ -2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map = vangogh_message_map;
>  	smu->feature_map = vangogh_feature_mask_map;
>  	smu->table_map = vangogh_table_map;
> -	smu->workload_map = vangogh_workload_map;
>  	smu->is_apu = true;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 145f13b8c977..21da7989f1ba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
>  	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
>  	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
> -	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
>  	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,              1),
>  	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,                  1),
>  	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,              1),
> @@ -120,14 +119,6 @@ static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP_VALID(SMU_METRICS),
>  };
>  
> -static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
> -
>  static const uint8_t renoir_throttler_map[] = {
>  	[THROTTLER_STATUS_BIT_SPL]		= (SMU_THROTTLER_SPL_BIT),
>  	[THROTTLER_STATUS_BIT_FPPT]		= (SMU_THROTTLER_FPPT_BIT),
> @@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> -{
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		/*
> -		 * TODO: If some case need switch to powersave/default power mode
> -		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> -		 */
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> -}
> -
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
>  {
>  	int ret = 0;
> @@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
>  	return 0;
>  }
>  
> -static int renoir_get_power_profile_mode(struct smu_context *smu,
> -					   char *buf)
> -{
> -	static const char *profile_name[] = {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size = 0;
> -	int16_t workload_type = 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
> -		 * Not all profile modes are supported on arcturus.
> -		 */
> -		workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -		if (workload_type < 0)
> -			continue;
> -
> -		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
>  static int renoir_get_smu_metrics_data(struct smu_context *smu,
>  				       MetricsMember_t member,
>  				       uint32_t *value)
> @@ -1389,11 +1305,9 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>  	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
>  	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
>  	.force_clk_levels = renoir_force_clk_levels,
> -	.set_power_profile_mode = renoir_set_power_profile_mode,
>  	.set_performance_level = renoir_set_performance_level,
>  	.get_dpm_clock_table = renoir_get_dpm_clock_table,
>  	.set_watermarks_table = renoir_set_watermarks_table,
> -	.get_power_profile_mode = renoir_get_power_profile_mode,
>  	.read_sensor = renoir_read_sensor,
>  	.check_fw_status = smu_v12_0_check_fw_status,
>  	.check_fw_version = smu_v12_0_check_fw_version,
> @@ -1429,7 +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map = renoir_message_map;
>  	smu->clock_map = renoir_clk_map;
>  	smu->table_map = renoir_table_map;
> -	smu->workload_map = renoir_workload_map;
>  	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
>  	smu->is_apu = true;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a403657151ba..8215bbf5ed7c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			1),
>  	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			1),
>  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		1),
> -	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		1),
>  	MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
>  	MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,	1),
>  	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,		1),
> @@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP_VALID(CUSTOM_DPM),
>  	TAB_MAP_VALID(DPMCLOCKS),
>  };
> -
> -static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,		WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
> -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
> -};
>  	
>  static int yellow_carp_init_smc_tables(struct smu_context *smu)
>  {
> @@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
>  	return 0;
>  }
>  
> -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
> -						char *buf)
> -{
> -	static const char *profile_name[] = {
> -					"BOOTUP_DEFAULT",
> -					"3D_FULL_SCREEN",
> -					"POWER_SAVING",
> -					"VIDEO",
> -					"VR",
> -					"COMPUTE",
> -					"CUSTOM"};
> -	uint32_t i, size = 0;
> -	int16_t workload_type = 0;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> -		/*
> -		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
> -		 * Not all profile modes are supported on yellow carp.
> -		 */
> -		workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       i);
> -
> -		if (workload_type < 0)
> -			continue;
> -
> -		size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
> -			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
> -	}
> -
> -	return size;
> -}
> -
> -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
> -						long *input, uint32_t size)
> -{
> -	int workload_type, ret;
> -	uint32_t profile_mode = input[size];
> -
> -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> -		return 0;
> -
> -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> -	workload_type = smu_cmn_to_asic_specific_index(smu,
> -						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       profile_mode);
> -	if (workload_type < 0) {
> -		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
> -					profile_mode);
> -		return -EINVAL;
> -	}
> -
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> -				    NULL);
> -	if (ret) {
> -		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> -					workload_type);
> -		return ret;
> -	}
> -
> -	smu->power_profile_mode = profile_mode;
> -
> -	return 0;
> -}
> -
>  static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>  						void **table)
>  {
> @@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>  	.read_sensor = yellow_carp_read_sensor,
>  	.is_dpm_running = yellow_carp_is_dpm_running,
>  	.set_watermarks_table = yellow_carp_set_watermarks_table,
> -	.get_power_profile_mode = yellow_carp_get_power_profile_mode,
> -	.set_power_profile_mode = yellow_carp_set_power_profile_mode,
>  	.get_gpu_metrics = yellow_carp_get_gpu_metrics,
>  	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
>  	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
> @@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map = yellow_carp_message_map;
>  	smu->feature_map = yellow_carp_feature_mask_map;
>  	smu->table_map = yellow_carp_table_map;
> -	smu->workload_map = yellow_carp_workload_map;
>  	smu->is_apu = true;
>  }
> -- 
> 2.25.1
> 
