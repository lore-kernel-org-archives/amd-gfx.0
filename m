Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AE21061B28
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 00:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86BE10E7E0;
	Tue, 31 Mar 2026 00:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="awTkIlv4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC0910E7E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 00:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up6cYoE/GTn0WTIUXHzo7kOruRTkx0sV9FFH/WBxqW30sC36ifdc1ENPPpLphGwK6kd+fPZZR/JVyfXCmWDmzgsYa+cCoYt0ygjuUNK8A09GQYKk6Nu/a/kE/7hShQoPrtCF01gKhL4jGx0U/jWlGm+AdQfxWjDWxiFo8JrwT4Zi4vTjtAKkZrg47oTIitSo0N5VeWoD1hSRg6aR4D0FaLasXP/FPkZR3cZG2VCfcd4mCKrx7aCoa+5WSySp4uE43CKJQ5FWBSg2wW/fYhvrYPzZPuLJ2fgaL3Mq26WkuSoNyJrBXsdAiKQoItNMmkthbvDJi2jGDHKh6UdK7vxqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1D3ghBS9GkYlzg5IyGzVtVKOXiT/KktnNOAugLQlus=;
 b=Qq/9te5VLaUwcPYudvSBll5f0GX12BSbE69m91El8L2gBJk78Oa0HDsPo2uXZRQYrKaAHmM1YJQ1NQPYKBElCojE67rjYh0vaGtdElA+NtW/CMx8qisBewKcfdzXCIQBhpCUCnscludB717pDOQ3gIYge4SCVqxE6Z8gRieSIbbYJmYyQK5D6xiDxJgRL0xLJQF+xqXE+/pW2te3y4+vzK85O2PfgcPui6wY7kQMCB6uqyMm8cty9buouo/molSdtugmQq+aLhafvPcUPB+MiWKsikNvUifBzKKMuMsL28dcaMv8p3q4PfXmk0V2BqLhq8aiM/MOCovDtnX2eWzXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1D3ghBS9GkYlzg5IyGzVtVKOXiT/KktnNOAugLQlus=;
 b=awTkIlv40Uu9cZnGlmMewHWf8/ivHwiTiQm82aRZfhLQ6uSRUsN+6mEqLbddwe0PocA/QPwLpgDsFCcZVBoA36s44vTLMznNjZP/9baGthmhVU0I2b00r+Zn8MRf1Fr1eX6EAeU66KnUs3zlbKf4Mrk+AG9JDvembGg3bm0RGEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 00:09:17 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 00:09:17 +0000
Message-ID: <201d3393-33f4-4fa9-a12f-1952c85092d3@amd.com>
Date: Mon, 30 Mar 2026 18:09:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix dc_is_fp_enabled name mismatch
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>
References: <20260330025603.2145115-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330025603.2145115-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:303:6a::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: a89ef3d7-ebfb-4439-9912-08de8eb9bfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: V2pSjN91etxaNbWoCfS2QwG7KgHPOsfYElOBWIQp++6MEk3AAVpt054aLr3ejfOylff59H+20dNGTja53RRSU0sFOotAImMRJ9cbWWv02nMVBiLHgq8MruNUny1weWPfQvyBPBjUn+yvHY/01MztrxgT1XcEAcicjaOLLnoVlRvrLqs4LZiR7znzSPzezKFhlzKJZhAMpoTMJDWEWW1bg2vWLEhana4CAEUBpYKNituFHZJa3/0FAeja3oWbMF5h+LOTWHqdRQo1TJK/Cm2koej6sD0RFKhQZoX9X9X9LUuUJ+ZE1fQi3E9EmZNz3kGRPyE673D8zmP5xpgQjC07868BCjCZXxMOWqPUSe3+YoqWihauAEL1ovlfGxEsJjcmbuTfO1YsyWNyIcyszBpJh9yKk8dTiC47k8Hyl2difKNkTPysiBfI6W23GIfndpTtc1NjZywp26gl7SJYo0iuvmzyKEEmuWXBVc1bkCx/mYFZkyGVq5vf8mUZXZ3xpNO6w+G45KgGLJmwnv4/p+GQ5hqMQjuJ+82einUzY6meeh6hNvyx2cRxYHB2e+6tDwTBD8v9p8HVgtKuaTZ8ohCjy8k4YkIq2Cuc+T8w4U9O/LuZmhMMtnteuILd9GF2tKSFi33MUL1R4YF26xPfcfySShTbHRsX1D11KmyiHunDdpsB/HUfhdUwfv9BZJqgN27XAaRv/r8VBaDBo7l1tsQ/KERdPTvGiaT6lIoyHKpHZnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9zQ1AxSjFCc0lob1BVU0dFbElEbUVoUnZ6Qzl4MjEyMjIxNjQ1bkYyWHVP?=
 =?utf-8?B?d3FadThYQWxPdHhHSWxmcG9zOU1RdzBxcnE0UzRQK00zZk1LTWFjQ05va09z?=
 =?utf-8?B?MXJjNmhOSjlqQnZCcTl5d0ZLTVNaSG5QcmNaVng2NXRJRk9oUWJ3LzYzVGdX?=
 =?utf-8?B?a2Ztbm5EQ09zRk9GWmpkamtncDFGNDgrb1AvTE1DWmt1Y0JYdk4xakl2Q3A5?=
 =?utf-8?B?RlhoSGl5VnlhNTZyQythM0cwYTlaSW5nNXBVdzQ2U1UrTS91NGZYVG1IeEdB?=
 =?utf-8?B?Wmlaby94SVVIYmJxbmNzOUxlYzBwSUNYK0tDMk42eVlwMXdjbjlwTytYVndJ?=
 =?utf-8?B?eWVaeFVCRjExZk13ZFZWUFVmbm8yK0J1S0pwY2ljdFJXTzBwbEdDZGxRT1FD?=
 =?utf-8?B?R1daQ2xEOXp2TkgrUHVZVlprSXcyZlRKVTV4UGhBaDk5VU5HMlpkZFZnWlZ1?=
 =?utf-8?B?V1ZIV2dtN09sTmNIdzRHbEptYjMyTVNiRHhaekltd3BFRXBRTm1KNi81YVV6?=
 =?utf-8?B?UWd2S3ljN1g2NnV0QUVKdkxteVhEQXlWNHN4M0VzaWpHV1EwR0p2MjZUM2ZO?=
 =?utf-8?B?UmRJeGJpbEVic2MrdWhKeHc1UFJ5T01aeTBhMHNYa3Btb3NPeFliTzBwdHlu?=
 =?utf-8?B?bGUrZVhab1BSWlJLaWpDTitnMEJHSEFFT3Z3WHZMZklHcUtzbmg5MHdyRjZ0?=
 =?utf-8?B?MENWdmh6TFBaTkxHRVJhcWJLKzhhczB1ZnlrUlVMQ0Q4azBJYVJORHF4MUZM?=
 =?utf-8?B?aXlaTGd3bzJqTTN0VFEzclFIdzU5WnhFNjlqSlZZYmFUeTduU081blJDVjQv?=
 =?utf-8?B?UzMyRFo0WFN3R0k4R1Y4emtVNG9KSU9GcmV2UlZ4enlrZkd3d0VxUkJGQWEy?=
 =?utf-8?B?eW8vbFdWaFNKT2JhZHNTeXloeHlrQm9TbitKUmdpczlhRUFGRmN2bnpmbkdB?=
 =?utf-8?B?M2xUZ2VoRUx4cExVNnNrQVRIZTZ6cFZLaHczTlRMSHhBNWRSWkdSbzNZVVlz?=
 =?utf-8?B?cDVCaS93V1FqOGhRQUlJZkZtaTdKUFFtVWJ2Tm83RjNJL3cyZjJjdUk5OXZN?=
 =?utf-8?B?VWRYS3VMUmh3MTBKMUY3b3pSY2RHdXBaR0R5SEVGd1d3MGU2ZGkwYTZoazZU?=
 =?utf-8?B?U2l5YWk0QlNxRFgvT3pTeERSeTdaalgySUJHNmQ1L0E2dW9Ga0tiRXZPSUhF?=
 =?utf-8?B?Z0tWc24zMFlJdTBTeSszYkxRWE1PVGhMR3JVZjA5YkJZcnp5UDloRHg5U3Yy?=
 =?utf-8?B?b0pDL3U3aE44SXFTcGRqRi9oUUFoRHgvS3dlUm9lQTlwMW4wUkFFWEQ2K2pR?=
 =?utf-8?B?U3QrSVgrSW45U2IvVXRrMytWVTdlQ1RnTkpJS05hOWpXVHlyNEcycDZGUmc2?=
 =?utf-8?B?ME1QWmhYRlc5aHk1ODFMMkM3THQxeFBzQnd6VXZPOXJRUHJVakFSN2RXM091?=
 =?utf-8?B?cEFTVEtpWGQzN21FbUdzU3I0MDI1Z1VBL0VicUZEeW5acHZ4NjU5V054YWdz?=
 =?utf-8?B?WGhoWG1oNWZsb2p4M1BtaGx6bWYvWmlUTDFUcFlvY2dpZ3R5RzFxTS9Ham5L?=
 =?utf-8?B?dUFCT3BpUkREcUdwSUFpT0luS3QxcXNQYmNTN1hHc1ZYbmt2ano4dENVQkZH?=
 =?utf-8?B?WFM2MXNpN0JSNFlsYWJNWk9wcWI0Uk9DNzVVM1NiSXdnZEZNVDFUS0pKUmYz?=
 =?utf-8?B?bFJXNnJJQlNPSGhmQzRaeUpsbmtLcFUzMjBZNlVWRC9QT3dMWGk2UmFzL1RO?=
 =?utf-8?B?N29hY2c5SlMvYStmaDJiMC9rOTdJOW5SSU4xTG9Ncy85b2U4bTlRTzM5Mkw1?=
 =?utf-8?B?ZGUvTTBCZy9IK0NOWlhwMTh3MDludVVtNGhNT016OVhsVjVxa29zNjJjUlBY?=
 =?utf-8?B?SUZsMi9USjdQMkVDZm1jRzlqQzJLY2h5L2R1a1pNQWxXQzExUTFpYTJRK1ho?=
 =?utf-8?B?YWh1L3UrZ0pBWUx1OGJVaytGck5tRzd2aWJXZW9WY2R2SWlPOWhQb3NRbnlw?=
 =?utf-8?B?VUxxbG5zdUl1T0o0emFmVjB3eGhabGJqdEJ5NTZPSEpVcjdFRWtoa1BwZ2x6?=
 =?utf-8?B?Y0JrV2VXVGQ1N2lqczlaUktINzI4OFNFR1hUaGErenVtWnZoSXlXbTdWTVVs?=
 =?utf-8?B?WDJqMmVYRjFrSjd5d0V0VDlzVGlZQWkxM0hvRHZJMHFOYWs3SnpXa2EvL3Rj?=
 =?utf-8?B?ZGNHT3gwMGR2OWlKajNJalFwYnR0K09LKys3SjdvcXg3bGUxUEpzWG9pcDNG?=
 =?utf-8?B?WmxyRXNuSU03UFk3eXJKdFpsOXVQYTUxbXpoMVVDdTFxdU0rUWRaQUhKQVY1?=
 =?utf-8?B?dEl0RGxadGdycU1xcE5ualptWDBkdHZ4eTkwQTJ3UWtTS1dGN05yQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89ef3d7-ebfb-4439-9912-08de8eb9bfd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 00:09:17.3430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icWSL4yrMOQ7GCvLAR6bRJrYfrNIK1ZMjWk5gSa01jcVHDGLZDfFyTGFjqQ6HyAEzoW7mKlWrUvFLnu583rdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/29/26 20:56, Srinivasan Shanmugam wrote:
> Fix incorrect function name in comment to match dc_is_fp_enabled.
> 
> This function checks if FPU is currently active by reading a counter.
> The FPU helpers manage safe usage of FPU in the kernel by tracking when
> it starts and stops, avoiding misuse or crashes.
> 
> Fixes: 1489d86d9ac9 ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dillon Varone <dillon.varone@amd.com>
> Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index 8ba9b4f56f87..172999cc84e5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -59,7 +59,7 @@ inline void dc_assert_fp_enabled(void)
>   }
>   
>   /**
> - * dc_assert_fp_enabled - Check if FPU protection is enabled
> + * dc_is_fp_enabled - Check if FPU protection is enabled
>    *
>    * This function tells if the code is already under FPU protection or not. A
>    * function that works as an API for a set of FPU operations can use this

