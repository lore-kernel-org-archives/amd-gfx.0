Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F20BD111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 04:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E5D10E0D1;
	Mon,  1 Dec 2025 04:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVSLzXS3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0040110E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 04:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2o8BDaoo/lp/7ihvQj0TUXMXea4IW6/he7F2GhpHFvLXMCyYmm/pIszHnw5MJ4Y+8C6kFMTXrMWy7MF7WuGVZ8YaBfkqWXNfhb9VWBZbPK/BP4aWhiIJilH1lnOi/lpbXUjhKtdOu4xNpbZQNY1HfFYbT5PfVLRzlS89o8KT155c8FuRsxn53ZQOASPqUqewMydH6+KClqAsVJwyHRZHxDV9IgFdLA7k2w0rK8qgIK+SQ1YySqBAfyxnN78YCF/3v80lPQnjfbl4P9ZLWDRZSaDeHd2L3coY5XrVz4YPqPm7MuoHKkyKNHBM5NpbpCEgX6wTbVKmEEdBgSuMiT+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTLzCQWrao1uwcybXXRdGImS58M3kP9h85OTiiwbAUo=;
 b=TOBmkv5XiDJy//DZlwpvJek3o2nf/3dbVdv5YcTWWfLcmIm1s1+KEHzqslyOn/jUmNXcrjTtD5IA3v8+RLGzkCclnVXdnGN4j7NAADRrzi++jrjqqFyEbvXKo/BZ0TCQAg905mZ8yhhoZU/6n6kOjzatoYlmYRbQPrMDewsVPYIxA6i01pMsX8CIvZ2KbX0z2Y261/82oU5NeRM0PXNDi7/xucKojQ4hnYPU3Sm0OJQzh2d9zipn/DiJD8m0jTMWliqyWniH7OZr5YJiIIPKexCCwK3zcYbXEHxjep2yxEmGRJBpzhnT2wVIpAObbt+TLzCZkzKgHeolPp2+QxtRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTLzCQWrao1uwcybXXRdGImS58M3kP9h85OTiiwbAUo=;
 b=zVSLzXS3aGClVd+MxPutCrVdYtiwgM0rAX1DmXqH85hpmB0bOx2r9CnFIMqCdX7S/dwhGDxbZ2/pwKv5HUeufsITr5MWL3D5WuWTgorJRbxyCZ590Y5j2xlpgIN8Ie0T6XIrhLTRAkrnQVakilJro48E06k2kInvOVHCXH/3zUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 04:39:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 04:39:18 +0000
Message-ID: <e9f7d64d-0681-44fa-beab-441cf8c57dc1@amd.com>
Date: Mon, 1 Dec 2025 10:09:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Move enum for VDD board
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, tom.stdenis@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20251128122854.715773-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251128122854.715773-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 128a3dd7-76f7-411c-7c3e-08de309396e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1Z2QjVJYTNYK0cxaWltbGQ5N09Uc2JDUTZvQmFsTjkyemVBNmZTbm44T2lw?=
 =?utf-8?B?aFRuU3BwSkwvaHMyL0Rpb3lHanRmSkdXWXNZRldaVnJBZDZpYUh5UG1VRXNV?=
 =?utf-8?B?NVVrRXRwTHB0Y0ZOZWpaYmc4OWNmakdpeFAyUUdpRUhtMHgrZFpwaUw5Smp5?=
 =?utf-8?B?MmpwZFdyZEY5c1pab3B5ejRWcmR0RnZGTGM4aEN5RW5nNzFMQUpLMlJxTHMx?=
 =?utf-8?B?UVprUit5SC9XOWkyMFNnS1JpTlU2QWtidnNEc2dPY1JZbkdPZkRKL2ovbFlT?=
 =?utf-8?B?YkYyeVFtV0tIbnFYYnRxeTBEM0pRQzFWamJwSjNjc2hQOXIvRENnOFlCMFdJ?=
 =?utf-8?B?UXVVeFBxcXJmM1lzVG5nWDZkb0RHSGtlVGxwK1FXbnRPSmIxbSt6VXBld0Nr?=
 =?utf-8?B?WGlIbnZseTB6QU11NWsyanNHa0FSVFR4UHFtMjRaRkZSbVdTL1YxTko0TkRF?=
 =?utf-8?B?UlZseVdSNlNWaGNSaFZMZjU1cGF2cTlBMWkvSjY0cXovS2NkYjlpSUx3L0JV?=
 =?utf-8?B?V0NrZHd1WHk3R0E3cXNMSjhQektIRmpoQURTTWpTMDRkQmlNSC9IcjlYQno5?=
 =?utf-8?B?NGpVNzFET0k5NGN3WDd4cUdtZGlKdFNFUnFMcFFraE1BSDltWDJYZEVxY2k3?=
 =?utf-8?B?R2tJem1uUi9JWXFYRC9HY3h0R2YwVHdOQ0JjMmNJbFJmd2pET1JiY1piVVdr?=
 =?utf-8?B?cjZXRC94UUJXVExBZHY1VG92Q1FtWFFFVW5LcjIxd1YwclVXWkg4QlpNRWFH?=
 =?utf-8?B?UlQzdHAwMTJNRnNtTE5RTERTejJwOG5aVE5hNExWSlFzbUVVN3RvZy9ZRHBT?=
 =?utf-8?B?VlhhUVdIMXJOZDBvSnM4d1ZqczA5emUzN29qYlBOY1gxby9IOGFGclhZajlR?=
 =?utf-8?B?ZmRTK0JpYU1NZ3Z1SEcvNCtQenZsSjJZV2hqNThHTWFHZCticGNWNm9ubURp?=
 =?utf-8?B?SmxUdlB6UFE2Q2RKQUhtcmpYUHpBSEN6TndOc3JnOVJqeWxkMjNMZGhQdmN4?=
 =?utf-8?B?MUZkclVibDVXNzA1bG9DRWhJdzhzSHVaMEZHRzhTVTZIMWZTTE5zMmJ5M1FD?=
 =?utf-8?B?bE42QkluR0JSVGpjUWRtejY3THVJSkczY3AyQU9qaUlmWnVaMlp0VnFiTFdj?=
 =?utf-8?B?V3RaaDJrWnNnSHpNWVNUSUFCL1pYckZNVXoyZk9HTGZ2R09XSFV0MTc5NEc4?=
 =?utf-8?B?cXNIdUhZQkxtYU0rSGVMYVlaNE1wV0VodE9QYWFHRDdycjlJelNYMEpFdHBh?=
 =?utf-8?B?VGVsU0YrblgxblJ6c1F0R1NJaGpZWEtaYjRLRUdOd1BIVGFzL1FWMlR2c2xB?=
 =?utf-8?B?UUFWN3A1RXlVRFlvdGg1ZktIa1JMMTF0ZzRJWjhmallLL05KYlNVYzdoSENJ?=
 =?utf-8?B?V2oyVGJKUTd1TGN3c3VBa2hzckRMTTFzMllnK0hRRVptMmUyNlhaRTZneUtV?=
 =?utf-8?B?bWJOWFJPaEdOcXhlTWJvbmc0bHpqMUxBZ2NOMWFoNzBOYmUwZi9yQkttczRz?=
 =?utf-8?B?dWYwNnd2OS9heDUyakovNWg3aFkrbGJ1VzJzYjVWdDRQL3NwbzEvb2pydnVE?=
 =?utf-8?B?U0kyb1dWY1lUb1BPdTdoMElLeEtWdkRxM2JpRm5LdDBrL0d4YXJlbm9QMWRu?=
 =?utf-8?B?a1BxUTF4dUEwa1pMb0NNSy82NWo1M0lVb0lpYmp0RUx4ZklwR1ZHSGlOK2Nm?=
 =?utf-8?B?OHBobWl0OVdERU9Zek5EcVVDN05rbHFkMm9Ga3IrQ3M1Q2VXRm5KOStvRFVr?=
 =?utf-8?B?Y28xUTkxeHR6ZnA0OFRXaVQvd3c3blc5TmZJWldOTHpkQTk2MjdmZWk1OTJI?=
 =?utf-8?B?QzVBT3JWblNNaUNpV3dQcjU4MkRxNDVISTJIRUtvOUVYMkR3QUdWSGxqeUdv?=
 =?utf-8?B?WEluNGh4TnZ0bzkvT0l4SnI3aFpYajRFVURUMi9tZjRBbjFVbmk5YzFRWFYr?=
 =?utf-8?Q?CWev/Q+g2QG54eMxImItNcaxy5yIuDmf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjY4VDU2OS9EOXVRcVR6NXhLZGdKS25YdE9vNlR1N21BaVluNTNUT3ppeDlz?=
 =?utf-8?B?UWtwbnV5VkppVEFDakRXQ0lyVE9GU0Z1Nmh0aEhrRjdKaVB1WGFsemd2UlF3?=
 =?utf-8?B?VVRzNEZpQVdzTU9WSlBtcVpZa1EvYVBtRnJ1Nmp5VjNXVlpEbDQxV0IxOHJp?=
 =?utf-8?B?ZERrbEdnQUlLUzIxZ1ljTzJMczNhMmxxQVRKbjVsVzY2bjNNbWd1bXQ4MU85?=
 =?utf-8?B?OGZ4YnhJWkpIbEJZRWJUMEZGYklEQ2k5R0JFRGRTTGF2aXY5UnBPUm1rUmRH?=
 =?utf-8?B?TlRIMVlVWXU2bi9ETkhxVkk0alltQWRCWUw3YTRXUHFVSGY4a29odytpNFR2?=
 =?utf-8?B?MFdwL1dOQXBYVjY0TmJia3pCTERIR2FJUklycEY3cnlRVTFkdktuekRhMEgx?=
 =?utf-8?B?VXdYbVNQRW1yMXphMDEwblNvdkFlanY4QWhXZ3J2aytPYnYvY1czbDRrS1A5?=
 =?utf-8?B?S2c4MWRtK2xpemNXQ211OFV5Z0RKS2xRNGJsUUxtVDJyZmNTRW9SVXQ1RWpk?=
 =?utf-8?B?Tk5GaHZTL29Gb2ZoQWV2Q29QVzYwNDRSMlkxZ0h6OUEyb0p6YWlwbXNWcTRl?=
 =?utf-8?B?RDR4czc0ZWpuZkNUWXBiTC84VFpRVkptVUNuUEx0MW1QaDBiaFZoNGIvOEJy?=
 =?utf-8?B?TG9PZW1vRXRFK2lIRnNzMmFhUURLeFIrODBiNEpOMktwRGN1VCthVjNQOXZU?=
 =?utf-8?B?V1VITk1McjVaUUd2ZDJpQlVSN0hXdjUzbU1vaEI5bVZSaE5uWW5TUGpKejBh?=
 =?utf-8?B?WFREUGxtY1JhaTFWRXRPMjNIUkFQVUFManM4NDNyRW1lRkx6S3B2MW42N09R?=
 =?utf-8?B?dGZLTXNyRTdJSDVEV2JOUk92NGVqRk9kTEIrYmVFZFhDdnpCK2czaDNzSnpC?=
 =?utf-8?B?NTNiSmVHYWxOMmxKZXlwVUtwYzFabUROLzY3N0x4QVhnZkE2WnQ5azRZQXRi?=
 =?utf-8?B?ekIwb2VlanZzdlJYeHdLeExrTldVWUxFOHhOeDV1RFRzZjF2bEJpeHZHdG5y?=
 =?utf-8?B?Z2RMcVBHdjFxM2xReFZXSkc0Qkl2WDBicnpNNWs3N20zamdIWlNDb3RtM25V?=
 =?utf-8?B?YnExblhVek5zOTFwODBxNnk0NkN1YnlHUXl5ck5pVzVWcHl2dXhwREdNSjNG?=
 =?utf-8?B?c29QN0VYNUtZY0FSRVQvQXFFTHdVMTNOVW1WN2VzNnNKV00xYzdIZmdYazR1?=
 =?utf-8?B?MmpsVWllU3c2TnVDMi93QVhlU29WRmhnL09sRkQxMW1Nayt4aUxlVVluQTBk?=
 =?utf-8?B?T0tic0NnZ2Q4MHV4aVpIYStFUTlDeEhHbFMxRk9tamFkaVViN2xVamNzL08y?=
 =?utf-8?B?aytvU1NEVU5DYmVUaU5QNTVaamdYdnhyU1NUcW1IUzVpdlVkUENyeHNvdUYw?=
 =?utf-8?B?aWtJTFVCOWZpSHlqRDJyL2w1WGFmUGtlN2FkU1JxUUlGb2lObTRNNWE1d3cv?=
 =?utf-8?B?N1Q1czMrdUw3dnRrRXpxVFc2dWlmLzZRUGEvL2l2YXFLM2JtemtlNTR1aHJT?=
 =?utf-8?B?SFBPTXVEL1hMYXZFMlZmeEk5ZkJrOUYwTzNXVHpMRG4xUXVMdHNVcWpVTFFW?=
 =?utf-8?B?cW5uazREcVMraWlsK3pLVjBacDJUZktmVGY0c3h6YnM4TmlaU2cwNHg0YmNF?=
 =?utf-8?B?Vlk0Tm5ZcXVacTBZNWZqTVZRUkppNTNaenk1SHhvZHZWOHphamh1ZFlybm9R?=
 =?utf-8?B?VEdObzNTYzV5enZVZXBMUVgrVzVwNmQ1WFpGM2NIWXV5MXRVZ0NsTDNZK3By?=
 =?utf-8?B?TDVOSlB6RnNGVGxwMmN4MkIxSmdTK0psR2lzWU5kNGlPODVnTDZwWEd2L0lB?=
 =?utf-8?B?NWMvOThWTVRTWURxTmFzaTlNOVNEU2RVdjRNU0NmeDFQMDJENStkaDhnSzJU?=
 =?utf-8?B?NjdKWVJyc0N1UGJuRmZDV3pGNWhaRmhmd1lrQkNWOWNjNEFZekJwWk9zeFFV?=
 =?utf-8?B?UE5aVHIxZG5YbGl3dHpneGEwc1dJcGtDT0Z6eVY4c1lTZkFzbytla1czemc3?=
 =?utf-8?B?TkdkOE5BUUdYV2loa0RyZFk5amJZa3p1Tk92WjhGaEpPeXFhSkF1M1JTTWFH?=
 =?utf-8?B?bzBLY2dPQndtRTY2a1dIM1pHc0V5RmVNWFFTUFJCUCtmWDJqNXpUb25IQVJY?=
 =?utf-8?Q?yvH8ol9tVjAG/rDfgM2/5pKMt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128a3dd7-76f7-411c-7c3e-08de309396e5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 04:39:18.7122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd7uhgoQGg5ndAtdynmkVRw5aX/+g2NJtplEryKbPyXndBxtfQqbjJiGgHcriy5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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



On 11/28/2025 5:58 PM, Asad Kamal wrote:
> Move AMDGPU_PP_SENSOR_VDDBOARD below already existing
> members to maintain backward compatibility
> 
> Fixes: 96ac487c1200 ("drm/amd/pm: Add board voltage node to hwmon")
> 

Please remove this as this is not a fix in driver. This is done only 
because client like umr keeps a separate copy of driver definitions 
instead of directly using driver header. A client code is not supposed 
to keep a local copy and assume driver follows the same order.


> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 92477120c28d..2a454f06c022 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -136,7 +136,6 @@ enum amd_pp_sensors {
>   	AMDGPU_PP_SENSOR_CPU_CLK,
>   	AMDGPU_PP_SENSOR_VDDNB,
>   	AMDGPU_PP_SENSOR_VDDGFX,
> -	AMDGPU_PP_SENSOR_VDDBOARD,
>   	AMDGPU_PP_SENSOR_UVD_VCLK,
>   	AMDGPU_PP_SENSOR_UVD_DCLK,
>   	AMDGPU_PP_SENSOR_VCE_ECCLK,
> @@ -162,6 +161,7 @@ enum amd_pp_sensors {
>   	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
>   	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
>   	AMDGPU_PP_SENSOR_VCN_LOAD,
> +	AMDGPU_PP_SENSOR_VDDBOARD,
>   	AMDGPU_PP_SENSOR_NODEPOWERLIMIT,
>   	AMDGPU_PP_SENSOR_NODEPOWER,
>   	AMDGPU_PP_SENSOR_GPPTRESIDENCY,

