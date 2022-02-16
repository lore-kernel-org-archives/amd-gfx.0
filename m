Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042DBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 19:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5252A10E645;
	Wed, 16 Feb 2022 19:47:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98D110E645
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 19:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQD1bdVleBVtFPqW9Q05qBkEXpUxBetZpscOuW3bDpHhzVcwB1ApgLGMCkl5NN6ic/0dPI8Mg6FOn2Ty/59LSiCjYPdhthH+npMQdJWsZaRBKDM7mycsrEnYvhTba0pgQ4oUeJO/gIgRsB0lpiOXo/oFm0FkAE1A91bTGVKVXaTfbwOMGBHmVT1ADvQSEXtNCvdgGZJvQOQqEBUeIzj04f1F8FtR3vlI6UmsPBNv73aSmQMGdbukqxO10oVPMKbXg94/ggAeA2x/HW0mfbAOOht+VubUMe3snNwXZgazb17zj96jrkNkh1YL5IgMfi89Wyn8ICuZSogDOkd2IUJs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixEy5XimRc++xcFJnDxKlRSqj6pT7BxW885NvQNGjJs=;
 b=N2Xi69azxAMq+0GYqGKcKqh5lLIEDbncJdPjibcizQb1OQ4CpwLJvuYB4U9yAZfPBdLL+ZpJgO+TRDvtA4V8s/N/DwjpavGeIKIZS+WEaDJhIvTDQrwKOsgjkEE/nVPg/S8rjqo5NnVtLuNE8Q5z2GCFAQwhuIRxg4yABtlkiL/FnbGgYVRBcixqw/EMeaBPIxEH9XIwXNB2VhyPXg8CxgILiCrZRRkyCYAM19j0fyEdivjfdC/+AA2Vx0go2BKg6svwwuzFqPGt24+6ENakLCFRbRgzaLswVSS1YUDZCR273i7Y3euT6/BXVV/WE0I33TSSule4adtEpc0tFTw/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixEy5XimRc++xcFJnDxKlRSqj6pT7BxW885NvQNGjJs=;
 b=chG1p2+tikDurreEoA33TSvM7k61MOcYXMLUWnsoU1RbZ+XoZjcoOkekKwlNJWdlyciqTnFiAuGynjr7j+IGVuHNxV20sPZkyhqXK4T+3cnQz/7k53YQVoDoVQbwlhRjy4vUFIkfUhKyHsD+t3vS2Jvu5QdQeM9viDXD+1+zscc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 19:46:57 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 19:46:56 +0000
Message-ID: <088056a1-677e-3bb3-d6aa-cee4a9b74863@amd.com>
Date: Wed, 16 Feb 2022 14:46:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/6] drm/amd/display: Add DMUB support for DCN316
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
 <20220215214447.2234978-3-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220215214447.2234978-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2091d042-6f18-425f-585b-08d9f1851671
X-MS-TrafficTypeDiagnostic: DM6PR12MB5535:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55354641B87657A98170E5048C359@DM6PR12MB5535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jpIdN/Wb6zHK1D/2WkIZyzRvzbl3ANmerYQE58M9mSUR0PNIa0SEsBxHwNvm0yL0T1RG4Vm91zduz7I1JuPUuqnFrOo9DFsmqCqSUVrtEFzZW6IbFuIDm88DWWtpKThaEGa9zxN9OxxteeidLG+Q1/BC7eZrGArnrLdBCCG09Yknj/Dy+FWNosD6GFkt3Cm7QDXBHgGpu2WhcUYvrEia4ICGtYDaZsR1UWYC8Zu0NZqvlYPmnwe44Ej7Z0I64pKQqtGwFtFI6MpOvC+y6FWuu6aC5D2zJpcKZ9+WKiIfe+Y7mD93o80ZoF3whqKqXdTgLokbLYNPuKLcKLEcMSVjFEtbEiCnu81F2A715qm9D0ryXUSRnYPq/Hd25hoypmwDrjLsyzmlaDe5lRFDNjnTzQ9aSQJ7f64XdFphrxhC4RUt13+XwFe9H708V1QB0AknLTIsIRzC+to6cfP2iB9TKg05epEh1Wc+7FVMswB6ugMOrl5z/mxE0c6igpVgpDf4+k9moAFkPPOT75OVLiR0Zp76sMgl50sndm73CLTxXFnwEc2vnjhsCaM3Xe2EnvmqQZi45uh8gU+GI1xxbiRrMAVcuSQWIHiMM04+0b6aJ6JCCLZxdY95MtWZ7c9QVxrDY3cOkmieBm95Cy8na6/D0so6msAGzf1aVraQqANmgHRO4/8JI6v/Do5wQn5vLffypvREAP5Ji2DJlHzMbkkHXZzpTvO+cC3KNAXHo7wqeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8676002)(66476007)(66556008)(26005)(38100700002)(66946007)(6506007)(54906003)(316002)(6666004)(6512007)(53546011)(6486002)(86362001)(508600001)(8936002)(31696002)(83380400001)(31686004)(2616005)(2906002)(44832011)(5660300002)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEx2TWhvWkdDVzZxY3BiUnltalM5MVRDcGNVTnVNYmJJZG1Kb2NGVlp1Nlk1?=
 =?utf-8?B?cWhsYnozRGVIKzQwSmt5bnc2TTVQTW42RHpMMHFWUnhVVlJ1OWRaUW9mL29F?=
 =?utf-8?B?M29za2w5ZjNkaGJpOE9KdjBLSUozcnZ1NnNnZ3d4WUx1aEdjSEd0M2gvTmV6?=
 =?utf-8?B?eGxGV1BBMm9KMXFQNTc3Z2Z4bEV2cm1lMXFTVGxEQlgxWlRBYjJEWFJuL2ZG?=
 =?utf-8?B?OUliRW9VcEg4T2ZCY0l5dE1oUmxMYW5sVm45allFZzM5NG5VeXQ4N3pIdTFP?=
 =?utf-8?B?b0dNcW83VzJXNU1oL3drWUVqRVVaYlQ5Zk1heGRodWFYelI1TlByb21QZlBD?=
 =?utf-8?B?VVVKTzdENE9uNjhTNjZGTkY2bUxZbDhYeE9vY2NzWGtDRHpWNVdOb1hncndq?=
 =?utf-8?B?VzVQYll0Qlh5UXdBakxPR3BWQ3Mza1JuM0pObWpSVStwS29LNUhYL09lQzQw?=
 =?utf-8?B?ZnhER0dFYTBMYlpOWVg4TzFwWTJ1NkMyU2JGRjdmKzVFMGRueGF3VlppQ2o5?=
 =?utf-8?B?c3Z2R01NeitmL3FweXh1TkZ4L1gyU2tESXJReUEzalNOZkhYQXlaWnFXU0s3?=
 =?utf-8?B?YTBhRitieFpqRU5HRS9lQkUwOGV1Nm5oak5RVVU0RUVGMmxQNFRxV0MyZlh3?=
 =?utf-8?B?R1g3UU5VRHBnUmpxQTJjSVFzaTl2SFNiZE9BeUF6YTI2c1dWYlJISVo1T2NJ?=
 =?utf-8?B?WllzczJTTFBKMmhOSXZKWVB0REN5VTM4Tmc2RnJFc0ZEN1NnTk5vNmo0cUpX?=
 =?utf-8?B?SDJJM2Nlbk4vcEoxQ3MxL3krVGZiYUYza0dSYW9vK0ZlaGptWmpoV3FWWHBW?=
 =?utf-8?B?RXN6K2ZRdzdLS2IrSHVBd2IxblZSTU5MNy9weldERnZ5bDFjYWU2VVhRRWRy?=
 =?utf-8?B?RmFoM0d5clVRN3NuZTdXZE81NEVCaEhDbXhUam5aNTYvYnoxbHFmcTdMTGpm?=
 =?utf-8?B?SzVUVWtJdGp2azhkN3hxVHdnSHFNRFkyLzJVN3M5aXBrR29HUU9DbUVRZlRB?=
 =?utf-8?B?elVvVDVPN1cvVGwwVlNXUUF3ejRSSnNHeEpkeGpFdUdwdlc5ZEE1bENVeHNH?=
 =?utf-8?B?RFJaZEdhUWRha2c5Z2orVjRPQ0ZjM1J3MWJNemc2akFMS2xLaHZBRjVqUkhV?=
 =?utf-8?B?Z3Z4WEhnMzVic0ZNaDk5Skl0TUl0empiWEZjS1NkZFJLYkhTZjJBK2kyQXZx?=
 =?utf-8?B?NEpWUWtTdEpuV3ZVZlg4NGc5YmhYQTh5Y0svdVJpODMwczl1NjEyWFVDTHhw?=
 =?utf-8?B?OC9RMHh5Z0FvT2hJNGNXcStQblNZK01GRFlxUWltemdFQ3JvaEgzSkMwTUpM?=
 =?utf-8?B?SmcrZ1hnam9tTVNta0lzR05NdlpHblN3TkxHejQ3WW9tS3BmV0NMcjJWUWJ3?=
 =?utf-8?B?QUtFZlB1aHl0UDB0Q2l5ck9zT2dnSTdVL0dWT2FLNGNnZ1lZZ3VMNERLeEMz?=
 =?utf-8?B?WWpJdEo5RVhZOVdSZ3FjMjJhS3pqRm5jRmlzcDVhTXM2T1pxZXM4QjIrQ1dn?=
 =?utf-8?B?MXpNK3ZhSjJWYlpMK2Fma0tGV0VYWUdQL1FCYXZlK2hTT1RWd0I5WFhTUFVk?=
 =?utf-8?B?V0ZmSk1sd2R5SlNjTndueG5SZnFhREdEUkkyUld6cmRuOTBVTGVrMnBQNENh?=
 =?utf-8?B?aW1kZUtoL25TNjNZS0RybkpWOVVCeWJPRWYvLzh3ZVJHSkVYdzc1ZU5iK3k3?=
 =?utf-8?B?Q1ZXRE1LQXJ0c1BOQjl0ci9RMCthMmtMdmNJZklSeVViaGhjb1phems5TW5H?=
 =?utf-8?B?emIva0RlVFNNTmdkU3hyVVllUW5RTTVCOWxJTkVWbUkrRHpNK3BLNS9jTDZv?=
 =?utf-8?B?Zzc1am45S3MwMVBCZDhYQlpsSHYrOTVibUUvQmZWRkRyTC9tRXpSZnl5ai9X?=
 =?utf-8?B?akd3SEhBSTg3SWU4eEpJMjVUc3lyMmRBeEl6dzR1YXczTFhQOWp1aG5yQTI5?=
 =?utf-8?B?dGVKU09tSThTNzdCOHpQSE1wVUlKUk5tWUVNQW5WMHhVbTFOU0I2WGhsZW56?=
 =?utf-8?B?MVNrRllvandTNCtVdEZqL0M4dzBMSmdzNDFqYkVFS0dYekVhM2tvNXVMb3Jj?=
 =?utf-8?B?R1BTQlZyamtSVlp5T0RGRnA0TmZIOEo1bEgyTnpkSWVXNHE1N2phaXVqV0s3?=
 =?utf-8?B?anBvVmpoZm9TNDVpZ2poTStSOVBPRWIyZm1zYU5mSTQ1KzV4WGEzVnJTYTRU?=
 =?utf-8?Q?+B5n76W9spf/ep5xWCS2g6g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2091d042-6f18-425f-585b-08d9f1851671
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 19:46:56.6930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1l9Nl89fto3H8G+GuDJ+JyEH2LioQPGWTFhVF9Rfr1xw7pVb/6+kS8mrBYYAo7vUs97id3gPZA13gZp9djtfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
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
Cc: Leo Li <sunpeng.li@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-15 16:44, Alex Deucher wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> Initialize DMUB for DCN316. Use same funcs as DCN31 for
> DCN316.
> 
> Acked-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>  drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
>  drivers/gpu/drm/amd/display/dmub/src/Makefile |  2 +
>  .../drm/amd/display/dmub/src/dmub_dcn316.c    | 62 +++++++++++++++++++
>  .../drm/amd/display/dmub/src/dmub_dcn316.h    | 33 ++++++++++
>  .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 ++
>  6 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
>  create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a4254357bf5f..4b2cb9bdc3d2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1920,7 +1920,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>  		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
>  		break;
>  	case IP_VERSION(3, 1, 6):
> -		dmub_asic = DMUB_ASIC_DCN31B;
> +		dmub_asic = DMUB_ASIC_DCN316;
>  		fw_name_dmub = FIRMWARE_DCN316_DMUB;
>  		break;
>  
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 83855b8a32e9..821d3fb1f824 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -98,6 +98,7 @@ enum dmub_asic {
>  	DMUB_ASIC_DCN303,
>  	DMUB_ASIC_DCN31,
>  	DMUB_ASIC_DCN31B,
> +	DMUB_ASIC_DCN316,
>  	DMUB_ASIC_MAX,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
> index 0495bcdd3463..21e818862072 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
> +++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
> @@ -22,7 +22,9 @@
>  
>  DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
>  DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
> +
>  DMUB += dmub_dcn31.o
> +DMUB += dmub_dcn316.o
>  
>  AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
>  
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
> new file mode 100644
> index 000000000000..c43d1e3819e0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.c
> @@ -0,0 +1,62 @@
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
> +#include "../dmub_srv.h"
> +#include "dmub_reg.h"
> +#include "dmub_dcn316.h"
> +
> +#include "dcn/dcn_3_1_6_offset.h"
> +#include "dcn/dcn_3_1_6_sh_mask.h"
> +
> +#define DCN_BASE__INST0_SEG0                       0x00000012
> +#define DCN_BASE__INST0_SEG1                       0x000000C0
> +#define DCN_BASE__INST0_SEG2                       0x000034C0
> +#define DCN_BASE__INST0_SEG3                       0x00009000
> +#define DCN_BASE__INST0_SEG4                       0x02403C00
> +#define DCN_BASE__INST0_SEG5                       0
> +
> +#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
> +#define CTX dmub
> +#define REGS dmub->regs_dcn31
> +#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
> +
> +/* Registers. */
> +
> +const struct dmub_srv_dcn31_regs dmub_srv_dcn316_regs = {
> +#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
> +	{
> +		DMUB_DCN31_REGS()
> +		DMCUB_INTERNAL_REGS()
> +	},
> +#undef DMUB_SR
> +
> +#define DMUB_SF(reg, field) FD_MASK(reg, field),
> +	{ DMUB_DCN31_FIELDS() },
> +#undef DMUB_SF
> +
> +#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
> +	{ DMUB_DCN31_FIELDS() },
> +#undef DMUB_SF
> +};
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
> new file mode 100644
> index 000000000000..9e7d109129ea
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn316.h
> @@ -0,0 +1,33 @@
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
> +#ifndef _DMUB_DCN316_H_
> +#define _DMUB_DCN316_H_
> +
> +#include "dmub_dcn31.h"
> +
> +extern const struct dmub_srv_dcn31_regs dmub_srv_dcn316_regs;
> +
> +#endif /* _DMUB_DCN316_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 9280f2abd973..db2802a14f95 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -32,6 +32,7 @@
>  #include "dmub_dcn302.h"
>  #include "dmub_dcn303.h"
>  #include "dmub_dcn31.h"
> +#include "dmub_dcn316.h"
>  #include "os_types.h"
>  /*
>   * Note: the DMUB service is standalone. No additional headers should be
> @@ -220,7 +221,10 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>  
>  	case DMUB_ASIC_DCN31:
>  	case DMUB_ASIC_DCN31B:
> +	case DMUB_ASIC_DCN316:
>  		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
> +		if (asic == DMUB_ASIC_DCN316)
> +			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
>  		funcs->reset = dmub_dcn31_reset;
>  		funcs->reset_release = dmub_dcn31_reset_release;
>  		funcs->backdoor_load = dmub_dcn31_backdoor_load;

