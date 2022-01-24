Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE746C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3801C10E6A8;
	Mon, 24 Jan 2022 07:55:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A7E10E6A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj/gzlZiO6wA5+K4km4Pw0q7DCIbrqUTHBn0pw+TbLCuxh/v1pWVb2icH7j8onrYI9ccPBD5+xySj9w70irz+6wcCvGyNvf+KtNpwjMIDuQm5PqtFLFEaFeMPdlWUiUlYeYUNRYGAJRhx0tB+wwjAMe+U4VpGOzNsKl55Pa4LSBmz174OxTlBssEPmZC2RZkp7g/XlcpnFBadgqq/y3W6hlD60Gx82hnZnErzXL2pfrmNP/7aQmGn6RVgY4wKHfjG3fL6Wmciym2qZHbRVNnWwADTmVX6aeB0USxgJDC3F0mV14T7vCw5rxMoP/+gPdpvX4n56U8Ma5hD90ajeSYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br7uTrtOR4WRE4sXKsTL5mi1EMh65/8axQSW0XIDVLQ=;
 b=S4IZ2Cd8zxLWkWyUakjQxBc9Ko72850/l6OdSIae18ejSXGwUbO4+9XmzESTnH2hkJnnym1HJCOxjHOl4X9og/Qdmap8akYvs3pu/8f5tClgVxCn5YOOVGlL0DFzSQn29jg1bv89Q7YdUXMMmoa0SlF+bbk01H0XQwv9wzvZ6jcCfq/yd+NKKm4isdg5lbfTthXEziohDb5BvaW8AVEkp87cRGFQKTNxgEVGJCpQ3Bn/dV11PYmihKAM7oWIO6nG7J4ix3U4jBVQLVDPRvvuuvoi2TwxU9Bo0vSa6DWSEMwq/dyNbBLTYKIEWY9bgEQWbByAf48GjuvYidA6OZAr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br7uTrtOR4WRE4sXKsTL5mi1EMh65/8axQSW0XIDVLQ=;
 b=QlmO4R+JJYHItOg69VKP2g3apNrXV/3AzzvnDuCcZbxvq2Io3Vkqapc9ygqhfq+QFZMSR+K++SttNnyaHzr49gmxsh8hgraKFX+VsercP/t+SM9LC5VxMrWtM+azoK2vNhR5hSw+0IgkC0FrYu/+QtSQD+RDzEbe3vMqpqpUZoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 07:55:56 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:55:56 +0000
Date: Mon, 24 Jan 2022 15:55:34 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: use existing fini_smc_tables function
 for cyan skillfish
Message-ID: <Ye5bdqT5wZuxV7Bg@amd.com>
References: <20220124064342.273055-1-Lang.Yu@amd.com>
 <20220124064342.273055-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124064342.273055-2-Lang.Yu@amd.com>
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cdd61fd-a54a-4bda-6d87-08d9df0ef3af
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00195B63E4D0A27C887B81B1EC5E9@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eJHjfnwZmOxtoX7RHaiJGf5GEmNpdIW1Q8uqfVJdkpzefVp1gRgG/v/aGIFyk9OM3OFB1/1VaxacqgXytGAuB5ksiK5nhPdV6pDz8KLet62UaQ0PzrGiMLWpuT52m0RcrjXM+6658DlzPF5ydombtlvuznUSPPySnl3Yll2RYlCob8toKoSYzoZngkoDnDdMDA5B5NPUeOK1jqFB677HB/Frp57Ade0YlnvjhYAdvinP+//Cc7x3R/rhzIy5OS5DCBfKjxMOFUegaEgb+GAvU/umQLP5KmIQ/4CgJVwCWYwfa8DD2eXBFn5AxdDZ+AX387RQQCEiKQip59Ep5Iiiq447182oZFcFhDsWK/SS37549X2PW81D9Djdvc15jZgDxeHEy88Ib8TihcAdifTKN7CII4rXy1N2SVQxZIJFJcY0veG92HCb17fva2LGFXGFdDShEoKcauWzA8914J55gftaZZkBkgPfLnRwBkZ8ggcEtob6B4mPcmmxUYCP0ejwervJ7Sxq+TzenyKz3sQOhVy/dWJhJj7vL+XVnokK9vpLA/Z8VOVazZN9ZzOPY+roW1aGof4e5sbFab8aQEduFjn8gWHhYZLMo+cguvNXyAQEpyzGqwoNJ/OsQkyi+ToBROg7SCBSwsMstLNN513GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6636002)(316002)(2906002)(5660300002)(86362001)(2616005)(38100700002)(6512007)(36756003)(6486002)(8936002)(37006003)(54906003)(26005)(4326008)(6666004)(6506007)(6862004)(66556008)(8676002)(66476007)(83380400001)(508600001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RU72vs2P17yQ9hB4FIBbZb89arJtGXhAmxS7807wzt1b48THs0GL9o1RcJEe?=
 =?us-ascii?Q?oQNOQGwlW3IRyQxgLnJgTYjm0NNXmfxZATY1CfWUSnOKFbeu3Nhc/QooHfZQ?=
 =?us-ascii?Q?iA1GDjCcdkhwPlZryvbUZ2Q4Z1L4Hz8OYDtYWX7Igj0c+rQ+5r615LsEQpLH?=
 =?us-ascii?Q?tZHq7cGprZFMm5txaCw/azP1AcSip47FY0okINoJdpIKjBk29vtoIAJF+cvg?=
 =?us-ascii?Q?QfEE8QaRHtCIFFKcPw2AtuGOcqJX/793q5ciA3bx1U+qjaDTH7W7xY1Y2sQL?=
 =?us-ascii?Q?82BURaz+FLpDhmkwQOykrRN/yyPEpXtOt3xM7T2fagMVa3RjJVKY2A2gx1Hb?=
 =?us-ascii?Q?Mjeg8hFZ+lc9YU2H1TCLryjmDVv707NCcOB2D6Ie7zCcTTEBaBeq3JQ+oHjM?=
 =?us-ascii?Q?BS0r2gVSXJTRAj/dAgnVXAVM0tPz1zexV7V828SF0+/MH9QBKDunMUmk8htI?=
 =?us-ascii?Q?YU6B9PWlrdjrO6TNHNvigrBE0cegGkTPgBLFPpi9kV7DnCUO1NMqWLWaZKUA?=
 =?us-ascii?Q?5ogyLItG4lE6cFiglbanVlaNuAG+asFREFgQWLJpKio0+fVjgOZGoQ0o9+zx?=
 =?us-ascii?Q?0nVFE+6x3o5FN2ujtl9gaCM0sNlrDbHhtxi8Rm7wTKH/9ru58tb7lVcFjPBi?=
 =?us-ascii?Q?9OMH+I606sV+LkTYjO/E5FE7S9VdPTQUMmOXIaIxUFfow1XX4kbfCEwB+vf0?=
 =?us-ascii?Q?tIjdAQBnKK7ASw6EIYzpoahBjhYIDLEnxGgA10Hx9tw/lqTsJ8eFyMC17lJ+?=
 =?us-ascii?Q?Q1ToqAVaA1e2TXHyhQdTaxJwTyPFe8t+kJbC+g4v9POLCSOYe2d6VD4JBjCr?=
 =?us-ascii?Q?cUIPfg/K4crB+El9RGxS1ZPtNJoor7xUKaf0IwjTDKxf77dD1vCNtLX1BLlb?=
 =?us-ascii?Q?DpOlEth8eoM7y9ZhvuWh1UvA9ZOeT/Y0bWUhIe79CcsdJ/2wKvwKXlj76P2b?=
 =?us-ascii?Q?ycThe/SyB03f3777wRy87hRfYuQtpA8xN1qUVfdaK/p4xo9ck2bh7y3FqY7J?=
 =?us-ascii?Q?nO4+76JwifrlSQwHwaE7WAwBiapMGO50cFPscHz75Z8BVyzj6OQTdH/Euo3E?=
 =?us-ascii?Q?IKlp6ecxTAX4BLk2UriHhq0oreAFVI3BbfkJkkJDa1X6PCC2LX0ahamDh1V0?=
 =?us-ascii?Q?WYUvMc9oRewURxa8iz8wVUAmvQRLKvt08xACiOLKwS6LoL9EEE7HTjX10EeY?=
 =?us-ascii?Q?T5KniEu462WBHn48nnOSAB7lxSZzHGsE+GqYU2BXUoUCNTZDFRq0WZ3XYXjl?=
 =?us-ascii?Q?A02sPhwtP3tYwW1mpLOZMOIgnVYeylMYiV4KnfPP7TUccZGnrM0/i9pz7bEG?=
 =?us-ascii?Q?GakrKLtsUDlZVEZTE6Ugo6ERkGFQD5c+2AhJDxNAHcAtxkKxiB7qNOMsbpXC?=
 =?us-ascii?Q?o6CbQDGRqIX0oSxdxQek8oOnXkupeIxQAGHe41bl0TqYoN3Xz+k1o8h8/QW3?=
 =?us-ascii?Q?dNP7y9BLG5s54FdbP2YeGInEBKrGqXB0zFL6chdUscuWd6ucY7A5CKwmqWHh?=
 =?us-ascii?Q?Ic4mcCS0uZzvs7+2KEzbvk1+uOdgkB1djzC+KfDYlenCr4hP4dOH77NHpmWC?=
 =?us-ascii?Q?Yp8NeO0F7a3YiaCjYPiEAMUj+krNhy/FXzU8D3pf/SSmG68QCW7ZYrKLTJVA?=
 =?us-ascii?Q?NptRW94Y2Nz0GD5SOqOG9VY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdd61fd-a54a-4bda-6d87-08d9df0ef3af
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:55:56.1469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZb+cRXxKeDsZDlFjVvuaCLsYKFmcmLBkznlgKPLTj0w7RbMdT18vSXxIVd4ThkssxSY/y3dBA21qcbfUjepdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 02:43:42PM +0800, Yu, Lang wrote:
> Remove redundant code and use general smu_v11_0_fini_smc_tables function.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 665905a568eb..a2b72d19a400 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -125,22 +125,6 @@ static int cyan_skillfish_init_smc_tables(struct smu_context *smu)
>  	return smu_v11_0_init_smc_tables(smu);
>  }
>  
> -static int cyan_skillfish_finit_smc_tables(struct smu_context *smu)
> -{
> -	struct smu_table_context *smu_table = &smu->smu_table;
> -
> -	kfree(smu_table->metrics_table);
> -	smu_table->metrics_table = NULL;
> -
> -	kfree(smu_table->gpu_metrics_table);
> -	smu_table->gpu_metrics_table = NULL;
> -	smu_table->gpu_metrics_table_size = 0;
> -
> -	smu_table->metrics_time = 0;
> -
> -	return 0;
> -}
> -
>  static int
>  cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
>  					MetricsMember_t member,
> @@ -567,7 +551,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>  	.init_power = smu_v11_0_init_power,
>  	.fini_power = smu_v11_0_fini_power,
>  	.init_smc_tables = cyan_skillfish_init_smc_tables,
> -	.fini_smc_tables = cyan_skillfish_finit_smc_tables,
> +	.fini_smc_tables = smu_v11_0_fini_smc_tables,
>  	.read_sensor = cyan_skillfish_read_sensor,
>  	.print_clk_levels = cyan_skillfish_print_clk_levels,
>  	.is_dpm_running = cyan_skillfish_is_dpm_running,
> -- 
> 2.25.1
> 
