Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BABA103E164
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB6310E7C8;
	Wed, 18 Mar 2026 10:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJE86NUF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBB910E7C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWsL6kAFizFH1mEcTeXWmMbIeKMX4JCDDKxyTeXlmhfcziRz531js0CfucgtJ/oki6l27xx9aXmyyrILDFpm64G0Q+7fw8heF7X2NbM4Jem1p74s1akJ5Kr3GEjkW+APpHZJbiLiyAWtzTNV6AiZmEIQ3mu76ptKBlecPE0wUwWbs03D1nWfzRiyo2FHGxThHUfDaLUDM3CCb+VXkvDTmVXogtuhg4GSxN0FUK7eJEtkpp7eh8a9XcoMavUVoqdja85rRyD24INckGMV4NpmiwSdlj7fG2LOxtnPLg7F9FSk0Y7ZziaHatigW5Uz4Vh/IuBWJDBQsNQJKoA3mVq9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyG6McjSx2RXamLJjmqf22KJURpt/VcqFYdC6uFhRlU=;
 b=WLH7U7zHnVwQZRgD4EVCKPN1GZU8xxRz4Pb2E8v57AqjgvywpZowLc8CvIiO+qmMn8IGL2gxRRyUBOO+PEH8pMxcSqJBTtBV7XcG03bo2Y9sU5xA8xuZuwFPu6/hmCcjs0BxwSOBXy2xtDkzZoLxBK3I0tn4G6bdqZv1ll7KeQ2kEK2D0UcNjhhHbNEE/LrzEOdPg1OBdWx47a4slwnseZcP5cZjtBI+tpdDS1jjsf3Sg4kSrp+bXnFq+zMz21elWKY/paJykCvm2Lh0C2Tio8BByeGAAkxzvTc3wE9NF6MovoDSRSWbwGENqwPXkx+NipzSSjMg7yAioA4k0IdAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyG6McjSx2RXamLJjmqf22KJURpt/VcqFYdC6uFhRlU=;
 b=NJE86NUFgI7iCgsgt4y46IeYg4U4eRayUuvOqUzF6rUHxsqdH2jQkk2fJkjYJxswdm3HQdiYug3h1pio+KvAVvaAA4ugNsBX6Rjzxrm5GZcXnVR40T5cM12yuZE9+HilTG9WXzBOpzb8Wu6oj2to96D/QDIePdNciYAKdZqCIfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 10:59:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:59:19 +0000
Message-ID: <9ce170c4-d0ba-4725-8087-6212cd2e0c89@amd.com>
Date: Wed, 18 Mar 2026 16:29:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/amd/pm: Return -EOPNOTSUPP for unsupported
 OD_MCLK on smu_v13_0_6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260318103906.3107670-1-asad.kamal@amd.com>
 <20260318103906.3107670-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318103906.3107670-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0276.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb6467e-20d4-4884-e1d9-08de84dd6756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: DD6fFow489s3M8b1RhWTmpmOosxVMcqoE/KB3LNy71ApVyzg8OtNhcBUSpGgve6PPVZaDmufu7Dowv47fnpmfuNlS4bYK7Xbia/ziMhOAuew7Y9nGAOxzVtPY10WULEnR52AxSCd9XuV1cdI+UMsDwGjkNGycpv4E8nXW8UUPUJRRrsto8dbhnbtH+ojVQvuvQc/mAIWCk6JdAi1Uaupne56vj2OXnsGHSLDaDD9re3iqs5ErbWYvtXnDYLZZ30quF9x+DKEcf9HIRIPkmjE2YkWxjV/4SdvDKkIOAe+CSScCmY2wr6bza6VQdY519RuK+bZu4rf60LjOdRl1iC+qKnprkXvc7TMESfBc3C/Pv40xHABRZ4gaeIzxaaIgkESMcmq3bF5k3pDLcPSDBHsWxbp0vGKTBZHja71mbrU4NC+lzIV+XThZtcvOy5TjNLZCcSWolDa+G8r7FZodbIgjv8rnqY7WDg6m7h3twX3UPlnwxH1cZ5oDoUzJhHu2+XAZo5gg4j+/23dJc36B6TzsN3EuXdJNhbB/S6FqS6gZZIKzgJiFRdJPAgbtixoV5/Zf819E9lMRWIE9qst+I9rBQ8S3rLOwsldX1xnYGjHIitBDAdvgz8+09XddwNCXlS96//B0Ok+hQADYwDvPY1WbsBqL0nS4Oo2qX8xsG6ubgZqIshg/uIy0V7pj7qh5xkOTA3XUu2izgZZSruu0/kRbn3BkVwfc+rh+L9DolGGes4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRLYW1iQXhvT0hoQzdFRElrM09PVjlSWForWDdsRUxRV3Z0emJQR21BNUZB?=
 =?utf-8?B?bDdCMVZqTU9YMGdRdElqTWlsMURtOFpLdVJ0VGFTd3FJQThrUk5zK1pZU3R6?=
 =?utf-8?B?clJtS1FWdmNuMC9DOHA1Yit5eDdRdmovQVlHU2kwY1ZaSTJjLyszUWhKWWdp?=
 =?utf-8?B?akdPcmlYdndxMU4wbVN3M1NoWW1iSzlaNzBrakRZT2pkOC81MTd1V1pVSFIv?=
 =?utf-8?B?ZVFwemxJODh6aENIOVlvN2VSZktJSW1FcXpESVJlZ0tiWUtqZmU4U2FiQUx5?=
 =?utf-8?B?YzVKT1h0VEdMeHVYWlNVQzlkUzdnTXcwMFFtUWZEZ2oyZGFWcHc1L2FkUFd4?=
 =?utf-8?B?aWJKcCt3cC9jbVZGYUE4aWdVSndDdXRJOWszYXhGUGJ6SllFWlNvdUp5clE1?=
 =?utf-8?B?Y0pLa240TGJSYndNT1IrNnFDOTdHRmRsTFNPOUdyeFlWeU16L2hCMk1UUjJQ?=
 =?utf-8?B?bnNWUlRBbC9QVmZSb2svNEwwQTZEWVppNlRtelh6LzZ0NXlMVWpMazNxYUsy?=
 =?utf-8?B?ajFpZit5b3ZkQWp1YjVxc0JmTC9xNFMyRS90Y1pabnpRZi9yb1ZTQmp4N1gx?=
 =?utf-8?B?d3hqWnBrcXhhSHRvdDdybHVKUUNYR2Y0MW1jVjFBdVZNbG8xcXBhWTlUK3pw?=
 =?utf-8?B?dVlvMk9aUngyY0V1V1hlbzkzL01FTGlZb0N4VlBaeTdGR0M0YmdoL0FySlhh?=
 =?utf-8?B?K3NLMG9TWTZzdVFURU5sdEhyWGlzTVBrVTNzck9heGpPSmdDaGVnZXp3bGh0?=
 =?utf-8?B?Z2krc0pBbzArbENtQnF1VzRHbFpDdHZYNjZNRXpDTW1TTGFycHV1ckl3OWpE?=
 =?utf-8?B?aHk1UUc4aGVreGFSSGlack1KbUkxRlJwQWZQUWRMaHZYckNHaWl3T3gvU1Va?=
 =?utf-8?B?Umg1QVZSenlGMEgrb1Ird0ZJSEQ1N29Yb2NSWGNneTlkWklQQ0JYakNWVVFq?=
 =?utf-8?B?WkNpUnFWUGY2REpSWDNBcllaVHpOdGhlUWJ1bW1Zbm80Y1F3NjI3SnVsSFBp?=
 =?utf-8?B?TVZBTmdmVUJEK2daeXRUeUl5cTlRdnJkZlhzN1I1citpQWorZXVTRUdxRklT?=
 =?utf-8?B?SFBBb0t4clNqMTlpWi81M3V2Sm8xTm9ob29UN20xT1IwaXlWZ0NYbDd1MGMw?=
 =?utf-8?B?cXgyZldKaEZsZks3NGVoR21VREpkNWVmTC9RRHpDNjB3TG1YbHNhNzQyTXNV?=
 =?utf-8?B?eDdUWVdPLyszeStValRvUlA4czByWkVjOUw2SmNqUERnT2VhU2NRWUlKYVRj?=
 =?utf-8?B?OGVoWkVCN3EvOUlZYlROU21xWkc1cXVYeXduUm5jM0E5RVBkeEhHV2JFcEYx?=
 =?utf-8?B?cDlZak1LT01tRXNhNkllQkVjZ016NzZRT0FHR3VVajBJbUk0WTVEbU1xWXBi?=
 =?utf-8?B?KzVONXRNb1UrYndYVklxMStMc3VTNG5BclVKRSs0c3lEK1NZRGc4ZkZiS29C?=
 =?utf-8?B?bGZZYUd6VWw1b2FEMDJtWHV2QjNiQ0VxSEwrU3dueUxwTVlnSE9hNnJUNWps?=
 =?utf-8?B?dzlGL1lHOEFXdFgvQUR4R0kwd040NkJpckMzWFdGQU9qL0JSTUxrcnFUQVhB?=
 =?utf-8?B?RHc5RDVSNitSNDQ3VHBCMTkraWJZUDVCVHZRdmxBOTNaWUJJT0ZqcnpKRVB5?=
 =?utf-8?B?eUZuT0ZKd1VSa2RlcVE2cDE3T0h5bkVRZUxXdnpNdk1GOG5EYWVGMTdPQ0JZ?=
 =?utf-8?B?cTB3YzRhcDRJNGtFM1BQeWpacEVIRDF1TzR5ejh2b05iQjQ0QWRuSkxaaEZH?=
 =?utf-8?B?VGlrR2pBTkgrWFd2UVcyN2p3VFpURmZqdStxSFZDU2VUK3ZVeWRaR2daWDBo?=
 =?utf-8?B?S3hiUCtKSStjTVNxTjR4WE5Gbm9JWjlVZ1lWMHdwOHd1N2piblRPLzBvdjky?=
 =?utf-8?B?OWY4RG8vSUUwM0tnenV4L2ptZ08vbDNVdFh4c3BSSlJjckhqWDBwdTdDR1Bn?=
 =?utf-8?B?V3B5NSttZzFXbExXaXVqV21tMkhnNFF3em5zcTR1YXpJZkxtTm1rQ3J2S3Fr?=
 =?utf-8?B?SSs0Q09tYWYrcU03VHdid1JSY2ZpeGhwVUN4dUliY1hMYXZsbzRwRThqaWgy?=
 =?utf-8?B?VCtmK1k1UElOdDdLTm8zSlJ1WTRnaitYdHY5R2U2elRsODJ1Q1kxYlBNT0Jt?=
 =?utf-8?B?OTI2M25BMk9SaHVqbm9EMGtSMHExaFB4SjVBYlFFcVRTcUFtMTd6RGlDVjdE?=
 =?utf-8?B?SGdsVlRGTTVleEVwRnpzeEExdHg0b2ttQUNvclBXK2lMZEVoaEh2dVVuazdt?=
 =?utf-8?B?d0VUVkcvWVJGcjNoQ2h1N1YrcnRxdUJKajk5eWFtSmFvZy9UVkR2T29Ddncr?=
 =?utf-8?B?RmRhcjQ5TTdKQ2ZWTXY5NXVDeFpqcXFOdmJyb1NuZEM1cnBKNXNrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb6467e-20d4-4884-e1d9-08de84dd6756
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:59:19.3553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev/rvQw8QjLQqhaOQ/61tf4/Y7FRpkdpxMmT83JRcKSvdWZomEDLVMQqbRu3p28k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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
> When SET_UCLK_MAX capability is absent, return -EOPNOTSUPP from
> smu_v13_0_6_emit_clk_levels() for OD_MCLK instead of 0. This makes
> unsupported OD_MCLK reporting consistent with other clock types
> and allows callers to skip the entry cleanly.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index dcc447e5044f..bcf8921bf1c7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1394,7 +1394,7 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
>   		break;
>   	case SMU_OD_MCLK:
>   		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX)))
> -			return 0;
> +			return -EOPNOTSUPP;
>   
>   		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
>   		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",

