Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02087C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 10:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7017910EAFF;
	Mon, 24 Jan 2022 10:57:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B81310EAFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqD4kNFxfcSXI47JdHM8dGdZxxuc2I4IVdxiREBaDwOAvNWjulg823+jzOvqS963NjbChWsdpqPDvPRdHCgn41R6AsXi0yoA4t5ER/IKE/sUQtjQhQYNigZ0wwBFtZvPWghzhzKK2yhX9EPW0G0bFYiX8LwoHHg/XNl4S2EfIK4PN7tAUg8fnuaNzVpxy6v8swdWALsBCfxZ4OuvWd7upgo+bFhiIg13Eon7LWOOruIx9Z2vDaJf5AEFhy7ABu+Vo7SOw397EO1ZrYWrpf7njMXsCXGbTZpA4y8mh7396feGFCWa6kSl7kiBdR/rQEc1bug9ks3KV0cEuTMbN5IMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezawql1ZTwJ7XDeCug4drCMt1DlqOiYxgfdbXKwyFhs=;
 b=Buy8dIOrbN1ZfF+xF1v3SK7ztkwFrZWPbTMadP6QfN/AYJPE9OemHz7P70poyNlt5TMJZ2eBmKMVbHpF4/FpMMQi53XSxDDkKOa4mhwnjAXNHwea1tzHtFY6FXScNjr0445ra98Y7+ALzxzi9InZZPnA91rlOm1jSy/TXJhpwasUbv7Czgsg8eYmF05MnHSgAsjghmoF5bPYpSaaxiq10TElZKobqSMuvhY1/noxknw/q5gp6wVN9dlvcu03GL+sLdNVTC8gz67QetmHWanfIhLTpG6AIYzCz/BC5ViDznf4p/W/0TInVsJKbnbnf04df+yhAWQz0vehPBDbiUZ7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezawql1ZTwJ7XDeCug4drCMt1DlqOiYxgfdbXKwyFhs=;
 b=l3fPmhc8p3EX6nVpNLZS0l6onsH9n2OKlnRglWJXN+mcQyzMA3sxESah82P5HjO5XyFIsxgAxN2baREecY52xXUj9lizy1K8kS9pEHEox5q4ioBsMJ3G8XNAFHsQDrKatPufpLH21Q1xxb0I9Xy2bN/NbqougtHOdycJODZliPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.17; Mon, 24 Jan 2022 10:57:45 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 10:57:45 +0000
Date: Mon, 24 Jan 2022 18:57:36 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Message-ID: <Ye6GIEBcLhXVjX0p@lang-desktop>
References: <20220124091215.335613-1-Lang.Yu@amd.com>
 <88871a71-8fae-3fd2-17d4-d583d800070e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88871a71-8fae-3fd2-17d4-d583d800070e@amd.com>
X-ClientProxiedBy: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9617c97e-f6c7-4125-a003-08d9df2859c0
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB469574D537E473B26DB12613FB5E9@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dezusWLfsvgveAjucB6yYZ6pdR8ZROvzaEZszM5/h6+ZH9v8T7ktv0GD625vzTK9S/CRUxUXX6RaMHPKlHvAnYR84ZElYGs8Oh0X7Yq9rDq2pO1OkK2lya3Lfc/5NOHOJk0qcBkhzKomO96Ln7egwPsvxfpbAUcCs5YVjfAmdLLrUI1h3Z+j/gja17puxhSDevfXyHGt6uKwL043X6e8FRAGsjvYgxWRVZRfKMtTTRXvozfPpveTO9+gPudvBpd1/Vod9zR8AIUOHYVHcajGvwkebJr0vCozHhZJt1Xa+KmENOCAMZmQC4gIF2R/M8N7tOc5mD4Y9I4beyHphdZsKKT5LjpMewtAKfkHzwcVHAGEAJO+J3E6nb256oNNyiLKZQ0pDtU3w4D+/cWqcxL5MH5KUZPW0+L7tRpfGEGZ1jJGqYa3hEnlBcL7Mgj+4ZY7qrhc7vQt4FS2iDvvZS0hJ/M5kYQfvWetQsJaufPdZGKdbBOhblmHnax8akib6Qn3JVSCCeo9UNCPB/Mrb26J8ddRWOi0u3qfLijcIhauL7HB1ngNP6aWMqW7fOU+g5XDoDkemold08S0ICJZBGUw/XDSrIIamKHbK4reUcwRwp7bzR21pJ9CXzmAaXp4WAcNM4xU96tZetes/1SyQrdR4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(7916004)(366004)(8936002)(8676002)(83380400001)(6862004)(5660300002)(66476007)(6486002)(4326008)(6636002)(26005)(186003)(508600001)(53546011)(66556008)(6506007)(2906002)(38100700002)(6512007)(9686003)(6666004)(66946007)(86362001)(33716001)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9IFF6Fq0hs3YdRCb2CSbcN1G1vJNuY4EiGtPJmmhhQKwICcFEsHD3k4JMWBV?=
 =?us-ascii?Q?DfT4wyA+dWxyBoM0qy903kGxyrhk7Cc/W5Odxu8bRsHDexUkn+N3IBL36/ap?=
 =?us-ascii?Q?zECu7wOPn8s9hwy396BibBF8vA1PtRWH0W9v0PJXFZTg7VZ3SKCOVY0EyYui?=
 =?us-ascii?Q?C+SScd+enDxTSR7hitUROBQ7E1La4cTyJYyEY5T2zxTfet5GUla3vRAo1Iiq?=
 =?us-ascii?Q?w1N8yhFN7Wldek27SuVoBAHe0W6QmHv60uJgAZYe4XaiMQNfy+rgjjTxy5Fq?=
 =?us-ascii?Q?cG2duuapAcfUaIiuivkn1eDGnw/HMx811IOaHajVuWp88S1ZNSz6IaMPVvti?=
 =?us-ascii?Q?gFFD8h2ULBEy+eEBwnHzv8i9T0+27GZraA+6Jmr9saNbhnCwOV2HRhHPT0UA?=
 =?us-ascii?Q?dlaZ5Byx//OXtD3iPfFKe9YfgCpjKZWnPJAffHXn0SAbsCjmIZc8AzXjjQXY?=
 =?us-ascii?Q?Ogd+HbBf8YtLdwRFF8lYNOYQFadZf4rE5ZZsDzpp0HMzvsIarh7RpxY9XwPF?=
 =?us-ascii?Q?31GFvf/kq33mwF6i3aPZ5W7txmbBpa4dAzQI5FJF4JhlXziQz6HYQG4VmUmD?=
 =?us-ascii?Q?D+4u4FmOZpEBZ2jx5n2j3/nt0EhAQtFMWpCUGaImCPKWSy1/eg+oCt5mJhIv?=
 =?us-ascii?Q?0/vklCNHEoYu32S8EaYJxIe1yR7SJQpP2IBoTDGcPP007kYEwZ9C7imfT5Q9?=
 =?us-ascii?Q?VOGa7tpRU58lI10qO9b5hvVSHIxwTGWyrbc7fXirZeP77LvKSdcOuf1ikaSx?=
 =?us-ascii?Q?2BvFIMxYqUksl+s/Vljqznoh49x0BPIkChHwYQT+hL5VDLi4nEyTN5qw8w0z?=
 =?us-ascii?Q?dmNYNqA7FgW65O6YGBY7/N9I/gRi8tudyBWyQo7xxHMZAQ+3nBEq/PNkSFit?=
 =?us-ascii?Q?gyhJS1JrFdzkIn1xoNIXuVqZJVVdEfx91hQMeODTPsZ5t/AI/I38uSgt3IDR?=
 =?us-ascii?Q?o0BDl1ufDEP1MTiqv3ktH/u0z0GyxnrXmnXeoQIbXMNI+GyffHYDSuBfRS4N?=
 =?us-ascii?Q?Pi0cVQ4jgJjMZq2W5wIjbjeEaU4RmrRW80gUETTmbZPKr1F+Za2vTklRJueq?=
 =?us-ascii?Q?9SCXqfQZytBuT3qiPQY8BSR/YXN8TiqndXQ+F+34HYlUYhTXnEVAsOVpRhLw?=
 =?us-ascii?Q?eUb7pz7/3iHQ5xbf4YLHpy/IK6p2LfXizYk4fHzzB4KH2QzJTIaEiQ5wOD1U?=
 =?us-ascii?Q?BpaDGd1Q3tHCnZ531qDhT250OYZNb+BaGEP1xlMgs1nYOW81Bru8ebeC2K5I?=
 =?us-ascii?Q?FzGLskXcFkIBwXNnvnSBqBftpH5A1YFjHO36LerXA73LNK2jtxCZxbmRjd4L?=
 =?us-ascii?Q?jZsxzDNs5jh5zbCsLcXaU5KRYQO36ixBwMzK76hy5tvpgCg4+Y/+8kWoZqp7?=
 =?us-ascii?Q?JzUHM0NNVGBPV+3FPqXrd1JKWPDWuXnRmtMfGfkewD98egCKfmQzU9kiFN0H?=
 =?us-ascii?Q?aI21CSJlNle4wRtSrWOIao9hX326OfsLBfp90bgysJIL9+f1bJekYl/rLzWD?=
 =?us-ascii?Q?xz2fo6imEZ4pyj5zAAwNDCxw22kzXnz2Cp7LXh3mnBSxIwlas7y4mGPEpAXr?=
 =?us-ascii?Q?L+KG8Euibc3r2wBTdcYeUvBJrtwTNRUOsC9ICmVlx469cvMZu6AC8CbLap7c?=
 =?us-ascii?Q?iVpgk2WQusx2Wi2t0K4/y8I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9617c97e-f6c7-4125-a003-08d9df2859c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 10:57:44.9616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK0Qz0+uTeCw3KSbaI/myPf+RYZWhw5BgupLwfeMUnfUw7hVsK5H+WB6cHgm0VyNzlVjEiny/wpphkmNLgdPgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/24/ , Lazar, Lijo wrote:
> 
> 
> On 1/24/2022 2:42 PM, Lang Yu wrote:
> > Some clients(e.g., kfd) query sclk/mclk through this function.
> > Because cyan skillfish don't support dpm. For sclk, set min/max
> > to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX(to maintain the
> > existing logic).For others, set both min and max to current value.
> > 
> > Before this patch:
> >   # /opt/rocm/opencl/bin/clinfo
> > 
> >   Max clock frequency:                           0Mhz
> > 
> > After this patch:
> >   # /opt/rocm/opencl/bin/clinfo
> > 
> >   Max clock frequency:                           2000Mhz
> > 
> > v2:
> >   - Maintain the existing min/max sclk logic.(Lijo)
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 35 +++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > index 2238ee19c222..1b58fea47181 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > @@ -552,6 +552,40 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
> >   	return ret;
> >   }
> > +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> > +						enum smu_clk_type clk_type,
> > +						uint32_t *min,
> > +						uint32_t *max)
> > +{
> > +	int ret = 0;
> > +
> > +	if (min) {
> > +		switch (clk_type) {
> > +		case SMU_GFXCLK:
> > +		case SMU_SCLK:
> > +			*min = CYAN_SKILLFISH_SCLK_MIN;
> > +			break;
> > +		default:
> > +			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, min);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (max) {
> > +		switch (clk_type) {
> > +		case SMU_GFXCLK:
> > +		case SMU_SCLK:
> > +			*max = CYAN_SKILLFISH_SCLK_MAX;
> > +			break;
> > +		default:
> > +			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, max);
> > +			break;
> 
> It's better to use temporary variables rather than fetching metrics table
> twice when min/max are both non-null.

Thanks for your advice. Do you think if the following is fine? Thanks!

static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
						enum smu_clk_type clk_type,
						uint32_t *min,
						uint32_t *max)
{
	int ret = 0;

	if (min) {
		switch (clk_type) {
		case SMU_GFXCLK:
		case SMU_SCLK:
			*min = CYAN_SKILLFISH_SCLK_MIN;
			break;
		default:
			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, min);
			if (ret)
				return ret;
			break;
		}
	}

	if (max) {
		switch (clk_type) {
		case SMU_GFXCLK:
		case SMU_SCLK:
			*max = CYAN_SKILLFISH_SCLK_MAX;
			break;
		default:
			if (min)
				*max = *min;
			else 
				ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, max);
			break;
		}
	}

	return ret;
}

Regards,
Lang

> Thanks,
> Lijo
> 
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
> >   	.check_fw_status = smu_v11_0_check_fw_status,
> > @@ -565,6 +599,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
> >   	.is_dpm_running = cyan_skillfish_is_dpm_running,
> >   	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
> >   	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> > +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
> >   	.register_irq_handler = smu_v11_0_register_irq_handler,
> >   	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
> >   	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> > 
