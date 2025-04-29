Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E3AC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 13:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F16110E30D;
	Tue, 29 Apr 2025 13:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TbiRgg15";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E61010E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbYH2gcG5bw5a14hBDf8Nm78ngsq4b1EkqzrlXOlbXEt6mjHRxkccyLE8O9bfQfifoyYK3YtyTErJSBc3lTO0aBwW4OSVJsmd7gPrFa9ctRvBLsyE6oXYyiMiAWi9fD+s7VnmS/kl7QJV64CrY5RU1Q0i8TvaR2oVW6dVx0vB7SrBB8NTE97s7xAJr7o2O1/MOdV8Tpl4C630myciUAQY8hfuGltefdccMGsijkrZs+QaERxCJvTEUig9keUGjwAV/8UmubLtYsoD7bIHdO9G5hNinCxsV0jDFyIZUpVBVauoYaeqEygBCDOPes6g7q3JTj0oeqGoGNqusxgXDxhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqkPXi8yg+K+C8f9R8ixC69kPOAE/CIhx7XT1re802w=;
 b=uMZnmR2It2pXEMbUE9h63lPfBNCIqK7Otn/menNGsnL+8FxYL0liRMFiLuID40kxTvLuD7YiJhYQG4P8RL65z/fMKrNj1NRgw46eNI4aL3MaCghGSv/TzTf2jqJxs81Vn0t7W5L9AjnspHR+c3zFd8WImz+h29jVWvg2o8jDGDBaK9HvwTHmTlBip3UgDRH4yPzSmcVEvBDEAfIjmK/2T7JA5YO5Ke87hLJEyAMXLbFObDr81Ux5f8MQO/MTiFuQFfuactx21HLD4MA9KVQiIdkX+T5Q+3aKOTlPo23llJKeXJlbb1FRvdF1tfr/b7Y+Fn2+yuMppTnK9agmUZjVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqkPXi8yg+K+C8f9R8ixC69kPOAE/CIhx7XT1re802w=;
 b=TbiRgg15mZ5fmOenbPJKWJ5/akcar1Csfra/caXYXmN25NEvki9hHBzUQu0rzbJb4okut/oPMyR2eMiXx4Ysybn9PoIN+JOaM4b+ICF2uazXmuO3qgIaRIrvvUhNG0SjPW9uih3qv2TRqvwGFfktV28Kb/2/0Q9CpL2riQ1I8EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 13:46:05 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 13:46:05 +0000
Date: Tue, 29 Apr 2025 21:45:46 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remove mdelay in psp v12
Message-ID: <aBDYCuLAlxgXIQBM@amd.com>
References: <20250422041629.1938342-1-ray.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422041629.1938342-1-ray.huang@amd.com>
X-ClientProxiedBy: KL1P15301CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::13) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f99576-3efd-4055-55a5-08dd8724301a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Adw0/1ne6pDBj8c+5wE51WgbBrX0LYdMk/wyMOJ+T0SqtjaK8QMqJ4GnaWQU?=
 =?us-ascii?Q?71j0m2G1zZ463Yp9PoU9PZyjd3xcpJLjvarnKtQMZcKFX/LpMmlttjo5DNM9?=
 =?us-ascii?Q?3xGsxqbIZFyuriDaBR3VHSv0mO1UohtUn5lEXBmbInrpoDOjvi08kx0duYHj?=
 =?us-ascii?Q?xRCyoDiERC7LOshaclWC24BjOYVcqe1rnSqbVYOLB99A0u91pZgopZmU5ajU?=
 =?us-ascii?Q?MBab2+l9+Www/8ou2cXFB4cWdsivYRMxVmdLl98kB79f6A80CVarFqcG7/sd?=
 =?us-ascii?Q?CK0nSOjXj40diHLqHwCHbUXVe7HYeE8pjf5dJQQ+kOcy5olmTtTck7Vy0ite?=
 =?us-ascii?Q?+BQkIq32v8+UBA36ntIIk+qpkH75i9QP05ltt4/6xHvIBNLzd3hE+7j2wMVE?=
 =?us-ascii?Q?hWLrvSM/AZdskYEKXHCy/2RwNUrY8k7Tiw9pz6vCZ7EgCD+Cs7s+ymQxtNoQ?=
 =?us-ascii?Q?HaBwcMot+Z0QW137fZWizB1ccyZD+lGBR9QjpMkDDNNk/XKZRx9r5Qh4JjM0?=
 =?us-ascii?Q?buNKYGuJO1USEMfWuW5DivrBV0SlK8CwZLf9bsKg48Ti48SjSrGQ3oDMx6kG?=
 =?us-ascii?Q?5ut7iaPbQz+SJafJtFqNUuoWtDWbSB1wJUwak9wTQv5Ji5Un9cikkYKagcm6?=
 =?us-ascii?Q?nw8HrSwUh89U2xkcEX7dE5RQOUO1tbu97T2sDHP3hT0ag3y5k5F2dq4KK4LE?=
 =?us-ascii?Q?SXh5s7kSwTfTqTIugMovEix5enAyAjlJfxaky/ravAPDrgL2bFZ/2xHBVzW2?=
 =?us-ascii?Q?JjHcEkEiGqTBbRgbcFmEzCrR3X1IKphhsdCMq4r9lSwGcUxzc/q1+bmze97M?=
 =?us-ascii?Q?HpvBr52l/hpYgLZLPDllcEs2Qba8Zcbrri/WXDmriTdah73kInM7QSGOoHcn?=
 =?us-ascii?Q?K7ih5yr4P34mVRHKdxMdAdaswtQXnKUQJSM2MG02jzxHzWitKIsrYLOxPkuT?=
 =?us-ascii?Q?AJvyiV9NjjCIikbZhe5L36G7J56cFOPxvCzvTzyPzVZifhefjAQQZfJysjZ2?=
 =?us-ascii?Q?ZIQ1Z3NuMyH8nZfNQ3VrLI97iFTo5Kae5/UbGEnvd1dQsqt1CP+Usfw9V5+G?=
 =?us-ascii?Q?87qksmodkI/8lpPuqCvHcHFsoUgG9Sh2jtBzlmYj8kaF/EfMSiy/LJfr76pU?=
 =?us-ascii?Q?L+pFT7utMzdPDzxPLdR0KS8swzEn2o0rTiNPluwgAZ52oXKRpIGVIjWFeNU6?=
 =?us-ascii?Q?bK2v9jl4tuj3DEq2Hj6EnYyhPZIV8yZJMTpnZIHXwDsh9ozpz3SM6r7kwvsv?=
 =?us-ascii?Q?dfYWTsrXBKCjgCQkxzQJtbXBQEF9DZh1MyLvzsGGFUDkbKjhYkk6fItYKnhp?=
 =?us-ascii?Q?pU1CJpoTpp45VNeyKz9DeEb+Y2gjsI5Lsav5VvIZDqZ4YwOR0U+oDBUPd8iJ?=
 =?us-ascii?Q?/tk6eDZMga1jmZzCCifhrFtbrTJVa78dGZIE/YK5Ri8XJvGmXegs/XYjpdTl?=
 =?us-ascii?Q?fVqfLLvd4Us=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSmUZyvlpWehk+dDJhyMcUMDWNQdAd7lI1wFCkWI4JUXVn2fwWN4KKJRT89+?=
 =?us-ascii?Q?PekBi4mL7fYCVmNZ49MsPB9TXPnp4Pmff0pKSVAePqzEG1x4+oqL3zSioJOU?=
 =?us-ascii?Q?lg0WSzcJitvSir0rskPJObps/lDeutAYWD+Bbn1lHrv4tAZ7Ft5QePHZHT9e?=
 =?us-ascii?Q?5HtXovRwnLIogXhpegjhuDsq4I8e0itttB69aKVFxr+lBcGHhLopK8OKfToH?=
 =?us-ascii?Q?tVERyLqVCH1hnEU25P83sgFzkbUjGxIAsk7mKqdz3EF0DvaXe1/rdvb1cW5C?=
 =?us-ascii?Q?kak9KmLXWQXRn5RMu+1IKE1J4y+3tmauULYhFl8WAs71F2lcJdGXU/hbhjJu?=
 =?us-ascii?Q?t8xCnXFoEXzJEoIAu3Y59IsTF9Dl+kmaGpI7cL9U972Vjk+xG7qcKIP7hGbC?=
 =?us-ascii?Q?t6uUFCuV7gfTx0gM8ttGaurPR1SVOcYoqmtK3V7eYRrtiZyWRbvtoo82sHgD?=
 =?us-ascii?Q?sgK9nuVBPZXlJ1Li8GumIUSw2V8TPG6+2BQdye2SHtGs6gK857raYEdPb8LA?=
 =?us-ascii?Q?yleMdmQi9ot3Gg+BLlrFtDNX0oWdgMF1ty8q8qp44nfP6ZeY3lxSkHpbKcQd?=
 =?us-ascii?Q?fzF++8qZZwT+bt+o1Dmsp92jkc9vnxz68EaJIYORySkzroALYcfLSgWSvtvP?=
 =?us-ascii?Q?uXXyXTlp1zi3XRGs11d8mlGg1CZxlcj8e6YWTynrJtr2gWu/f+f+4iLzyA79?=
 =?us-ascii?Q?BxahhoVr0SbgUXjIPA1hsaxQPGLAWF3XNGhw5W9Vk7h7Uv0FFOziTm7SCW/7?=
 =?us-ascii?Q?yGXr0/M9+sOqbiXvQhiMnftkf92bfHbX9lGpvfNXfhkPE9DHEb4bE96zJopB?=
 =?us-ascii?Q?1GHkzLtECfhlt3PZwG/e8WZS2TrZpxv9F5mATstBKfVewzmWz3R98Tk789ec?=
 =?us-ascii?Q?04HUAYH26kBTIQXBQ/g0pHcx6gbiEyial3z11+zLp/Qfg79p6BIIhqwc+t4A?=
 =?us-ascii?Q?l1x9uPBpB8VM7XsX3orq/gYlBzRbKmMYyZHsk0s2Ieen9nCbA+dKOX+TySCh?=
 =?us-ascii?Q?1jwWySkU3P+UC/HrVuNy8B4iVj/66X5Gn1QKdQdewsswa99w51yT+oZnwKGd?=
 =?us-ascii?Q?72ZHeisYIg+LltaWJ6BN89S+jXuHaSgXZG4c8T7c3nXul1kp1wFrc7XrG2ro?=
 =?us-ascii?Q?K+mxWtKmIkLhPwQA/g1YSz81a2HABsXwe3HegB26O+xONFDaM8INasqfgMPk?=
 =?us-ascii?Q?9oj+M+ZhV0/Q+7n0ZpgtuWh94v8CFL0AUJ0ukfCU4HmVTXs2cq/8EY/qaQ7Y?=
 =?us-ascii?Q?aA9hBpLSLDjnRWn/6e0ca93s0+SP0qjmox7j1HpknBA/7Jj5B8uFSluAovTT?=
 =?us-ascii?Q?LzE8x128XsM4rAbyYrxDNooBPl5ZPJiEUIAn/g1Lcj7HZSkXXNVMLJNjmEaI?=
 =?us-ascii?Q?PiX/7r2OwjeLJ7CLh6fcJTrUows6WRXy4SPCJVqtonPK+O7X9oD8cXAK0fTm?=
 =?us-ascii?Q?1qBRQOwU0g1p5GJmvXAh8eyCMFL05v4QhugFv7r3TSgTz5rB2ZfLkoRLfqX2?=
 =?us-ascii?Q?W1sKCxjD2SEI1LUqsK9dGeGPui4/pVAdDjl4bHhrNaG+GC2+IBSTeSnh9yg+?=
 =?us-ascii?Q?+qthWYrXDmxjJ4KQeh7NeE3hr6jbSIdj/8dayvwb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f99576-3efd-4055-55a5-08dd8724301a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 13:46:05.4776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzFuFKNm2CGVQEDiUe9aM1f4q+Rz2rxEm+MZs73/T98Gip9g9agknPLFcMzezigGwCXe0Z7O+NoeFYVQAoCttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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

Soft ping~

On Tue, Apr 22, 2025 at 12:16:29PM +0800, Huang Rui wrote:
> Since secure firmware is more stable than bring up phase, I believe we
> don't need such mdelays any more before wait PSP response on PSP v12.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index fcd708eae75c..6331941440d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -99,9 +99,6 @@ static int psp_v12_0_bootloader_load_sysdrv(struct psp_context *psp)
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
>  	       psp_gfxdrv_command_reg);
>  
> -	/* there might be handshake issue with hardware which needs delay */
> -	mdelay(20);
> -
>  	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
>  			   0x80000000, 0x80000000, false);
>  
> @@ -138,8 +135,6 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
>  	       psp_gfxdrv_command_reg);
>  
> -	/* there might be handshake issue with hardware which needs delay */
> -	mdelay(20);
>  	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_81),
>  			   RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81),
>  			   0, true);
> @@ -161,7 +156,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
>  
> -	mdelay(20);
>  	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
>  		     0x80000000, 0x8000FFFF, false);
>  
> @@ -173,7 +167,6 @@ static void psp_v12_0_reroute_ih(struct psp_context *psp)
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
>  	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
>  
> -	mdelay(20);
>  	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
>  		     0x80000000, 0x8000FFFF, false);
>  }
> @@ -200,9 +193,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
>  		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
>  					     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
>  
> -		/* there might be handshake issue with hardware which needs delay */
> -		mdelay(20);
> -
>  		/* Wait for response flag (bit 31) in C2PMSG_101 */
>  		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
>  				   0x80000000, 0x8000FFFF, false);
> @@ -222,9 +212,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
>  		psp_ring_reg = psp_ring_reg << 16;
>  		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
>  
> -		/* there might be handshake issue with hardware which needs delay */
> -		mdelay(20);
> -
>  		/* Wait for response flag (bit 31) in C2PMSG_64 */
>  		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
>  				   0x80000000, 0x8000FFFF, false);
> @@ -247,9 +234,6 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
>  		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
>  				     GFX_CTRL_CMD_ID_DESTROY_RINGS);
>  
> -	/* there might be handshake issue with hardware which needs delay */
> -	mdelay(20);
> -
>  	/* Wait for response flag (bit 31) */
>  	if (amdgpu_sriov_vf(adev))
>  		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
> -- 
> 2.25.1
> 
