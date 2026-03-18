Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF0E103E160
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 11:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93B210E7CA;
	Wed, 18 Mar 2026 11:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwlx5agB";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8DD10E7CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 11:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t43medVXnx0rKpTKlG8HdC6PZztnTP+jMJj7ga6TDkyshVH8MY4NeAsAVHFGNWCK5SsS1N/xZp1XQ6zm7SvpDrFjp64jIWC1P5Rp2VeKh077xQ1Zce1D58B+5tGYfzrrWi+0L4e9ypSwWwc4U+PNG4ovh0oQjTdSDhPXYdcLFxtL1G3dQ9KKEGhECmkQg3QisGRvsOvoiC1h0nDe0Ve4mW6CQAOHU+gal47YpCbtisjwmO7A6JQiolxAU5b5EjdKDzMkaOT0fFmCbuCZCjarpxYIaj9ccteg719u2nN6YnJB0nNl+KKFSO3CbqQnpXHstEseroOtGcs8HJ5qWfnPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIjQd1r3bqxTmkfiRetClWz+Juvvh34cUSJtLyzNeTw=;
 b=FPyc600uSeFdd1oZB70vhgCBIOauwdPoDbjQY2EwpRCxXmn9nm7qja0N8Ch7cnmtPNxIbCiSuufiNLDXJa9TWo5hMfpckasRs8GIF+Cpz/hEZACeqLrKKpNY55UTf+64uHedlnq45zSqlLqaLIvlr36sUYtT7Infm7oPQDJBfC513oX+EXRmcc6+hV+DvqqgBOvD5EtOU+hYsY4ZQeWu+2ro8XZxOyp5f6Ucwa2q3GrTQ71hsO96n3fj2SeMXPL2ccLOru8kgT79Jf6esKuyU470REzSDbAhBuUYpm6qa7oZuzc7tBJb0WofjjI0UhioLZMy2V0PrZmU+zi6qlEHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIjQd1r3bqxTmkfiRetClWz+Juvvh34cUSJtLyzNeTw=;
 b=uwlx5agBJMQSsFbOB2TLa1HPnwrvWvws4ix/OjN6by2occFkGwVnEdRdqS7LHSw8TDgaL9sZ3ycIo4ycYNX/3g1CpqLn7ZRqzB4UwyU1l7gUZj0QfOmEdaSo7hL6sKLVQxKhO07rOaz80U0r0WIfCZUqWl+ytw71/1/y2Y6Bx74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 18 Mar
 2026 11:01:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:01:36 +0000
Message-ID: <5f015fc7-db2f-4065-b68a-44189148392c@amd.com>
Date: Wed, 18 Mar 2026 16:31:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/pm: Add custom fclk setting support
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260318103906.3107670-1-asad.kamal@amd.com>
 <20260318103906.3107670-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318103906.3107670-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b6b62d-fdc4-4f2f-62f9-08de84ddb8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: umzgy8Fk1BxUclugNyaCfXs/jP3p8tJ2n+wsUpJDMjA77zU1N7XKSGeJhhws4603TbYeiLnuZQhJOGQbSh6xNgSSORi8Y4fF25GNJSR3xMRyL/nIA5mkGzkez2tN3ZC5FGdU7yBwswxJaJW8u5+oGNdZ0WssPleul+AslZYjLrdCMm1lKPBsfUXPa780IJk1AyAtYHDJOJ7EVpnG7qlmsocRGfQrZokS3Lp7zxTHrmki6Of4d9qRUgHt3zReWUrReaz084Gq/dfjnckWDup24LLU2OMPkNJtqwIFZzyOiTQi+0Z5wQUa4gSfj3kNHFmblpgXnQy2f8sY9xX1Wh/Mkev0r39Mjkz7i5UDCx3H6WA6t5CPasUn8Uye1DKHWbnF75NaEPi5UHZ/pzpQXndTwPw9VXYbJl6rCZXi9kJbBwBFEOfP5VJO4D+JFhole01agvUokrLUiHkwwdn7miVj5BaKtCOhrypMFmKQ0mPSYAxXCjuFGWWxIjUdAppUdYESmAQMgSVCQnRly8pJSlknKsXEcgr1tMuWwzgw1eD/peuXdwpdnpFJjM/QmUUiJJtl8rUtsbhCYnw6b4HJ4sFdYzU1GBwK7tKpsGJtdUjsuBX0KUjZRVZCjM0Z3wru/Km9E11k1+yUiwehbsVKBr7suTl5ghAryJOym7Th4JBOg4T69mBw40RPSsqeAgy/iCv99dTRKG+5pT9YBh7iHZzMy9YGonW8jiwlWYI60wdaeWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm8vT2lCY25lZk5TcHNBcFR0eTFBWXk1M1BadTFqalc2VUt5enAzR3l5M1hi?=
 =?utf-8?B?RURjQVZLZlEyMW11NmRQa0xRQ2EvN0ZmaXh1Y2xpcFBKdDNNTlV4Nk5rSzky?=
 =?utf-8?B?T2pxYkRTQitZanp5Q3NjUjVWNHU1MHpoVXlZN2RvMzNhcldjWUlIdjRvdVhn?=
 =?utf-8?B?STFjQTlXbTR5NGFZL21OaHVVYWl4UmVVdnMvUFhYRGorWnFsT0hYdkw3dzdo?=
 =?utf-8?B?UTUyejJnZXEya0dwa21EVmFYM1owd1N6WHRJSk51OFpMTXV3OXoxdnVwZXVK?=
 =?utf-8?B?NmJVcm9mbnBUcjVBMVpWN1hUczhiWjRsZWhPOHZUZlpBWGp0RFBsZU9hMzYw?=
 =?utf-8?B?WXBtb2dMaXU4dFpSSWF2b0RDOVFOekh5R0FaYlhUMzBHSTFaRDRaYXQrbXZ1?=
 =?utf-8?B?WnBSYWlNbW1wM0ZXSEZqc1o3WHY0Z0lCU0NVSzJXM0RMU0oyRW9vOCt3ZjFk?=
 =?utf-8?B?aDV1cmlYaVRPMkdVdWdpNW1MM2o4Q2taY1RuUFF0RGFwMWwvRUdKRmd6Zjg5?=
 =?utf-8?B?YWNmRllOdlNaUjFIeEMyRFhEU0dRYUJWYWZqUWNiR1lWejVUVU0rbVRwRmwz?=
 =?utf-8?B?WHRxQVljb1o2cXlJLzR5dzA0dXRuNldORUtzVjc5bk1rT0h6Ky9tbjR2ZStH?=
 =?utf-8?B?R3JnVEpCQXNoVHpuUG11WWtGTW1JYXQ1elBWTSsrWnZNazdFcUdOQ0dYaFZI?=
 =?utf-8?B?NEsweE9HUmNtNUpuaXJJVEJLTDhYcU52Vzl2ZXE1c2ZPQ21YeGhsM0VGRDJF?=
 =?utf-8?B?Q0dmSmVJR1p3M2VDY3Z3S2huRkowcmkrVWZkbndXWDc4aDRFR1RSN3p2TC9t?=
 =?utf-8?B?VDcvdGxuT1FlQytKWEFQTHFqMnMxVXFRSVVzdUpxLzFKNTRiMEc1eGtncmxh?=
 =?utf-8?B?R0RiVEUrWXZDSmRvNENvNVExek44a2k0U1ZDckkvZk1JeW9QalNLVlphZHNs?=
 =?utf-8?B?d21NOVBwM2lxcW5OYW9ROWZXOWIweUpOaVYzcnU1b0tNbHlXNWxqZHZubVFm?=
 =?utf-8?B?RlNKZzF2b3poOU1EazdSRGgxdmtBZHROdmEwZHZjUnFaMndPUDRjYnNRK292?=
 =?utf-8?B?RnVwZllubEpqU2pMckxkaWlON1FwSkhHTW94RWYyVWlmUWJ0Nk1VM0NyZzVL?=
 =?utf-8?B?WHNUdHBveGxWaVBRaVFaVjBQdHlFYzZnajRlRmFXQmZxZG1rRFNUZVorUHA2?=
 =?utf-8?B?TTJBMi9NYyt4elpweVhTZG8rNmxudytKeG9oZGhKQnUvN3lXWDVqY2xwOTM4?=
 =?utf-8?B?N0M0Q25yNTVzZnZuUWNNL1U5YnRsRmRpdzcycmpzZmd0dlo4YnlzRFpUUEdL?=
 =?utf-8?B?eDcwRks4VmJ5OUIyVjlUeWpGU1o1M2N1bTRTcDZoWnNhN2huQXphKzBPRm9v?=
 =?utf-8?B?YzhhOEtYcFRpaHlySE11MzlLWTNvRWlLR2xvSkFXR1MzTmVZOWtGMEJSbGg1?=
 =?utf-8?B?dVNRS2RaQ3E3ZG8zbGEzaHJacnJoOGRUS1NscVpSRmFZS2lncWZHdTlJd2cv?=
 =?utf-8?B?VDN6dWFCbVJreVBlcysrcWdnL291cHN3TVBuVUl6azBmY1RjZHQyam8zTzNR?=
 =?utf-8?B?QXVqQVhKUFp2S0I0amZDdjkrUGJTNnJtYitFOXI2ay9ENjZuUWR3eVhXZnRn?=
 =?utf-8?B?Z1VGNFU5dDgxSDUrWC9zdGV6dDhzdXUzc1pUclk0Ujh2c2wxeEl1V3FVcVVu?=
 =?utf-8?B?Zlkya1pOUEo2NmhqTnoxUzBYb1B4SHBoc2RTNDZ3M2g2bGx3QW5GR282NDlZ?=
 =?utf-8?B?ZXlhOEFHRkdTYWJkKzZ4NUVqN3J1dkVsT2tHZzQ1THJ5L0tEdlJqeWlGTWhq?=
 =?utf-8?B?bnowTDhVUlM3MU4wMFoxVXgxc0ZuSnFVbXV3aXlLSzVqdHNUaGowT3M1c1FT?=
 =?utf-8?B?b1Vvdk84QkErUkJhSzdMUzRQR3JkOGcrbmo3bE5aMnZSTStiNjZ5VGlIbTJs?=
 =?utf-8?B?R0puWFhpQWQ3RHF1UUhCY25tVUpnTjNpUW44QWtRZVU2YXFMRFF5Wnl1N2gr?=
 =?utf-8?B?UzBkVWZKQzhyMVpkTm9BTEpKd1E2bWpzYnBiREF2MW1BSkJ0NnBYazJhcCtV?=
 =?utf-8?B?NEJkc05HSjFDcnNrbjBvVHpZOTBFVWw5ZGRiRzcxZGhxbnVyZFR5VFU3UVV0?=
 =?utf-8?B?d1VQQTR6c1VMYWRJZ2hlVGpjQ25WbEg2T3ZEUXVObmloR25sdWdBL1NWdUNp?=
 =?utf-8?B?Q2J2N1U3Q1JQNnFtWVYweTllaXFQZlYrck44Tkw4ZC9SOE0yY0w4YXhjclZo?=
 =?utf-8?B?MDBxN3kxdTE5VW1wNEwvM2VzdWRGRmNINlcrV2s1OXl1UHNzOGo0VCtLWVFz?=
 =?utf-8?B?Y3pZNHpETzVTK1c1Rkp0eGFzRStTVTQvd1RPWWFDQm9NRG9nY0hpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b6b62d-fdc4-4f2f-62f9-08de84ddb8ff
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:01:36.1185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcx3chtNqs5LyCc+I8i+VZG5l5b6A5xvd6bUPlU34QtWMUVJF2JLO8yJl3xe7Aq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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



On 18-Mar-26 4:09 PM, Asad Kamal wrote:
> Add custom fclk setting support for smu_v13_x_x
> 
> v2: Move uclk fix to separate patch, return EOPNOTSUPP in case of dpm
> disabled (Lijo)
> 
> v3: remove dpm check for filling fclk pstate table (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 82 ++++++++++++++++++-
>   2 files changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index cf3781aba02a..d8a1c402a624 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2467,4 +2467,6 @@ void smu_v13_0_reset_custom_level(struct smu_context *smu)
>   	pstate_table->uclk_pstate.custom.max = 0;
>   	pstate_table->gfxclk_pstate.custom.min = 0;
>   	pstate_table->gfxclk_pstate.custom.max = 0;
> +	pstate_table->fclk_pstate.custom.min = 0;
> +	pstate_table->fclk_pstate.custom.max = 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index bcf8921bf1c7..f76665c85bc3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1199,6 +1199,7 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
>   	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
>   	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
>   	struct smu_dpm_table *soc_table = &dpm_context->dpm_tables.soc_table;
> +	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
>   	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>   
>   	pstate_table->gfxclk_pstate.min = SMU_DPM_TABLE_MIN(gfx_table);
> @@ -1216,6 +1217,12 @@ static int smu_v13_0_6_populate_umd_state_clk(struct smu_context *smu)
>   	pstate_table->socclk_pstate.curr.min = SMU_DPM_TABLE_MIN(soc_table);
>   	pstate_table->socclk_pstate.curr.max = SMU_DPM_TABLE_MAX(soc_table);
>   
> +	pstate_table->fclk_pstate.min = SMU_DPM_TABLE_MIN(fclk_table);
> +	pstate_table->fclk_pstate.peak = SMU_DPM_TABLE_MAX(fclk_table);
> +	pstate_table->fclk_pstate.curr.min = SMU_DPM_TABLE_MIN(fclk_table);
> +	pstate_table->fclk_pstate.curr.max = SMU_DPM_TABLE_MAX(fclk_table);
> +	pstate_table->fclk_pstate.standard = SMU_DPM_TABLE_MIN(fclk_table);
> +
>   	if (gfx_table->count > SMU_13_0_6_UMD_PSTATE_GFXCLK_LEVEL &&
>   	    mem_table->count > SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL &&
>   	    soc_table->count > SMU_13_0_6_UMD_PSTATE_SOCCLK_LEVEL) {
> @@ -1401,7 +1408,15 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
>   				      pstate_table->uclk_pstate.curr.min,
>   				      pstate_table->uclk_pstate.curr.max);
>   		break;
> +	case SMU_OD_FCLK:
> +		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT))
> +			return -EOPNOTSUPP;
>   
> +		size += sysfs_emit_at(buf, size, "%s:\n", "OD_FCLK");
> +		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
> +				      pstate_table->fclk_pstate.curr.min,
> +				      pstate_table->fclk_pstate.curr.max);
> +		break;
>   	case SMU_SCLK:
>   	case SMU_GFXCLK:
>   		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
> @@ -2043,7 +2058,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>   	int ret = 0;
>   
>   	if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK &&
> -	    clk_type != SMU_UCLK)
> +	    clk_type != SMU_UCLK && clk_type != SMU_FCLK)
>   		return -EINVAL;
>   
>   	if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) &&
> @@ -2084,6 +2099,15 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>   				pstate_table->uclk_pstate.curr.max = max;
>   		}
>   
> +		if (clk_type == SMU_FCLK) {
> +			if (max == pstate_table->fclk_pstate.curr.max)
> +				return 0;
> +
> +			ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_FCLK, 0, max, false);
> +			if (!ret)
> +				pstate_table->fclk_pstate.curr.max = max;
> +		}
> +
>   		return ret;
>   	}
>   
> @@ -2126,6 +2150,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>   	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
>   	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
>   	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
> +	struct smu_dpm_table *fclk_table = &dpm_context->dpm_tables.fclk_table;
>   	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>   	uint32_t min_clk;
>   	uint32_t max_clk;
> @@ -2206,6 +2231,40 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>   			pstate_table->uclk_pstate.custom.max = input[1];
>   		}
>   		break;
> +	case PP_OD_EDIT_FCLK_TABLE:
> +		if (size != 2) {
> +			dev_err(smu->adev->dev,
> +				"Input parameter number not correct\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!smu_cmn_feature_is_enabled(smu,
> +						SMU_FEATURE_DPM_FCLK_BIT)) {
> +			dev_warn(smu->adev->dev,
> +				 "FCLK limits setting not supported!\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
> +		if (input[0] == 0) {
> +			dev_info(smu->adev->dev,
> +				 "Setting min FCLK level is not supported\n");
> +			return -EOPNOTSUPP;
> +		} else if (input[0] == 1) {
> +			if (input[1] > max_clk) {
> +				dev_warn(smu->adev->dev,
> +					 "Maximum FCLK (%ld) MHz specified is greater than the maximum allowed (%d) MHz\n",
> +					 input[1], max_clk);
> +				pstate_table->fclk_pstate.custom.max =
> +					pstate_table->fclk_pstate.curr.max;
> +				return -EINVAL;
> +			}
> +
> +			pstate_table->fclk_pstate.custom.max = input[1];
> +		} else {
> +			return -EINVAL;
> +		}
> +		break;
>   
>   	case PP_OD_RESTORE_DEFAULT_TABLE:
>   		if (size != 0) {
> @@ -2235,6 +2294,17 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>   				if (ret)
>   					return ret;
>   			}
> +
> +			if (SMU_DPM_TABLE_MAX(fclk_table) !=
> +			    pstate_table->fclk_pstate.curr.max) {
> +				max_clk = SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
> +				min_clk = SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
> +				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
> +									      SMU_FCLK, min_clk,
> +									      max_clk, false);
> +				if (ret)
> +					return ret;
> +			}
>   			smu_v13_0_reset_custom_level(smu);
>   		}
>   		break;
> @@ -2261,6 +2331,16 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
>   			if (ret)
>   				return ret;
>   
> +			if (pstate_table->fclk_pstate.custom.max) {
> +				min_clk = pstate_table->fclk_pstate.curr.min;
> +				max_clk = pstate_table->fclk_pstate.custom.max;
> +				ret = smu_v13_0_6_set_soft_freq_limited_range(smu,
> +									      SMU_FCLK, min_clk,
> +									      max_clk, false);
> +				if (ret)
> +					return ret;
> +			}
> +
>   			if (!pstate_table->uclk_pstate.custom.max)
>   				return 0;
>   

