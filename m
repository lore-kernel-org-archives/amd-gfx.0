Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD59C282C5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 05:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F348010E1FE;
	Mon,  3 Mar 2025 05:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ZCPx0kQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454F810E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 05:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNno4T3jyAczadIHlxytVvil6jaB7ckAE/OHCWBTCRGcSs4PHOw2E9nm0QQ/eQ771tttb6UYeidKR3LZE+LhgPoSvOyWuTJcffI8tJAMTHwu7E/vII1FU3h86xnskR5pch0JyTo6gREWPFeU5siKzjsuhjvispfZa8bxmoG3buPEBwbH1nyioPl7YSDI1CU/wexZw62evY4WpZ1y8EwlHR9gnnQCJSgxtlFSesU+aF405d1YWgudbr9YotNfnORIUm2erHDujj15YSpphVfONhv6ofM/CGQTZjAeVec2pkLMk/fUcruRgsHGqFvgUAoGAHCWc4wu9LDXtlC6ytoGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1bxyHPpYwKYlVB2q7oM4LCE0hq0PXBF46vzsT6JaaE=;
 b=wh2nc40Ym4Y8rLRkm9pi4guiYEVACRx0aXQ+oPWLU8vZDhINX8v83URl8EVqhVBI/xV+ra+Wqw3gWaaA2/jVkr2m+me9NdneXU2hel/4SYaSZh7wr9xgTYTuY2S6vBV9T9Nu1SUa0po9BpnRs/4uuM/ELcp5QrasejdZbnpNfYB9k+6a36RZ9BQdmd/p8tvz97jaquE4Kog7LTNMrL8CZxw21pYY9AEl62+qP+0JyQBNYJfsWo89dv+0JxRBK8JsN3ONcRdFGEE4+cpA6Ll9mcsMuWaaZmqGH5l75byl9g2oqlx+I92s+MUJoDwuS1Sk5Kd8z+JQ0Qf1bqLQL5IoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1bxyHPpYwKYlVB2q7oM4LCE0hq0PXBF46vzsT6JaaE=;
 b=0ZCPx0kQlWVzJTSFe0yEtjI3lT6Fux5HQHQE0B+gF/3L3YFhKDOw/bn7Qe6yBM1JjwuFkphXOJIN3vmCEOXsNK//vq7v9DcNP1zRH6VWaEQq4ekcaq8ob88ctRKRRoQHD2jZKCxEHo1vOhg4sYeHj52Ta9XP9nViljt3tnOdZP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Mon, 3 Mar 2025 05:05:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 05:05:16 +0000
Message-ID: <b697eddf-b087-4fee-9d48-681434456070@amd.com>
Date: Mon, 3 Mar 2025 10:35:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix indentation issue
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kernel test robot <lkp@intel.com>
References: <20250227150321.813265-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250227150321.813265-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c10d7f-7506-42d3-0218-08dd5a10fc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUZtRDRhNmZJMUNDMEJvakxLMU16a1lqQ3dER3Q1NlU5V1NMU3p5dFM3MFJW?=
 =?utf-8?B?bExUTUU2aGZkNUk5aHh0emhMVDVZK3lGWi9udGZDQy9jQXgxYmp3dC9KU25o?=
 =?utf-8?B?YjI1SExheU41OEx0UlVhU3BwVVdlTnA4MTlwZmJhREpZdE5ETlZITTZxUDNZ?=
 =?utf-8?B?SHJEM1FjbWZteEZldXlzcG9WY1pHcjV4YTI0dUU1SUk3RHhvcXF6dmZqaGFt?=
 =?utf-8?B?VmMxdytkc0FVZjljSFVvdFhqUnB4cFBNblB1T05NMEJQeXAwemxuYlh4RU0v?=
 =?utf-8?B?QVRsSlNWREJETGwzWWFNaEdnU3k3ejdJRWxKT2RMcWNXSVowR2pHbVNLU1ND?=
 =?utf-8?B?WWMyU1JNbVhLTEc0WDR3d2wrWXBTOFlkdFllWUJlQjJnV21vYUhrR0xDdnZm?=
 =?utf-8?B?bG9DOGlRYjBmbnJoSHd5V1dnMVVyQXRBcnNQc0tnZVZVNXd3ZisrMkNMQWts?=
 =?utf-8?B?K1dhTklkUnIvbjNubGszMzlUU2NGbVJmUXZWNkZGVzZvNUJ2aTVZajdaUFMr?=
 =?utf-8?B?RGtCUU90RW8ycjZoSWdSalJ4RlY4RitGZjlFMFFIblJURkpYb2dINWNJbWVL?=
 =?utf-8?B?VjNZTUEwYkl2d3AwVHpBSThKRzQ5akdGM0g1dTZGd2ZMZER2RnF5VWZra2F6?=
 =?utf-8?B?RGViNWd6cEJhem1HZExhWXhPYVVic3hRR2pNUjB1LzVKZUJIZ1ord0VRenlP?=
 =?utf-8?B?M21ML28vOWhmYTMvb0JXZXZCNnRjUXhhT2Z6MlFVRzhTNG9UV2pzOEdMWCtT?=
 =?utf-8?B?dmJKbG9DWkROcU9yK1VLRk5RZnJpMjh3dlBmUjQxNEZCQTJUZDhVSllEb005?=
 =?utf-8?B?SHBidUJFSys0Y3NCRFdzeklDRUJSbEd2T1VydW85bzJVQXFpNDE0cmRGVkFF?=
 =?utf-8?B?cCtVVkQrZU9rODl4Q0l3cjlUZ1hsYlBxVldlOVFLdjV3SnhTakozK3k2YjB3?=
 =?utf-8?B?M3dqek9YT0VpOFlWOXRBMTlkNFdwU0s3MEFWNjY4YmRXcFRSb0pRNFhidUtu?=
 =?utf-8?B?STJmVGJBaWV0T0o4WjhaejYzWEl4SmFiVm9OQklVSmdvQ2V4Zk1BbmhGNzd3?=
 =?utf-8?B?MnpnRGI5dWFpRlU1RmxvT0x5TExhaHZ1dWdkMWh3OUxQYkNBTUYyNTBIRGxC?=
 =?utf-8?B?T25kRzlzbkZLQ1dvWFNTQktGR1E4eDRUbEp4eitKdmFmYXQ4dDZ3RGRZTTRt?=
 =?utf-8?B?UEdReUsvUk5sdGdYSERrZmlnTkduNk55dEsrVGxtVlE4SDE3Z0ppM0phR3Fh?=
 =?utf-8?B?WnJoVm1BREQxc1FqT1VibHR2RXI5TTQyUzAwSGVhaFdrSHhyYUJxYVN4Vmhi?=
 =?utf-8?B?aXNsUUVENUJiVVlKZElXb1MxT0ZEYkRXVFIxL3A1dVRnM0RZN0NnQkVOcmN3?=
 =?utf-8?B?RjhXOHI0T2YyNUtpMm1QWjE0cUJrc05Fb2ZpU01XMmo0UjdHbHhxOGFUNUtQ?=
 =?utf-8?B?RFpka2tySVhnbW5NZUhHSFpUek1rYjRUNGgwaXQyREE5S3VlUjEvLzBORTZ0?=
 =?utf-8?B?NW9zUVR0TDdpbGdOZ3F0M25xWENyV3Vmczg4YnJIOWFwVHlCZ04vaER3Q1RS?=
 =?utf-8?B?M1BRUGt4cEhWZ2NESnVqZEtPV09JTmhqZUV2UDhRVVdzckxZTlVYcS9kdnZH?=
 =?utf-8?B?REtXZTQxZzhmSk5VaWQzUTFnQTZiSCs2aXlzN3VXNnM1bjhuRFlseDFoTytF?=
 =?utf-8?B?ZVhYcDc5dHQwSS9ybGp5NC9YSktGSG5jemNiajJndkJYbWUrUHZOa2RGNVkv?=
 =?utf-8?B?M2hkb091WUNqLzVQSWp2czYwcGVDeGt1d3V0bGQyMkZ0YlpPZmxRajdXd2dz?=
 =?utf-8?B?ak8xd3BRT0hhczZYa3B1czg3STVjbkxRdDc3cUdqRWVEdis4RWJadjI2Y0x4?=
 =?utf-8?Q?+XZl3U+9+ubow?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmZ6ZHhWcmYyN1hCRVpIaVdMNm51cGhNcmNQcFIwUVJjeVhCc3lKdVdKY2oz?=
 =?utf-8?B?aEZOejBOMkNMa3Iwdkw5TlFQd0ZtRFpDWksyVWVUZWNTRU5YS3NhVGFOOWZR?=
 =?utf-8?B?Zlpkb2pZOUtNTHppVVhBVXdTVW04ZlBVajNSMlBiRW44YURNYXIvYktoemFT?=
 =?utf-8?B?V2NEK291TlZoOE43ZUkyZUlnOU1IRitRaEhsQUNHeHphbVFIUTZGRFA3STg5?=
 =?utf-8?B?RHBKMDFwV1JNRjBna3l1ZTdlRytiQStpVHluRWwzdllBdWZvOE5ZUFB3cHh5?=
 =?utf-8?B?aGFKNngyU2ppRTVxK0NVbTVKa1JuS1AwSHBXWWtlOVEwR1lheFREckxKZlNu?=
 =?utf-8?B?QkJIakZ2VW1maE11NkFudjNuVG1TaVkybEV5TFpMZ1lOM3Blc1lUTUc0dTRZ?=
 =?utf-8?B?RjNzR25WYUxJbXpUVk9NSk5ORnp3L1l4MFc4cERKM21aWnRRWE0rTUhPTWwr?=
 =?utf-8?B?d1FaQndkQ1JZZ2JIdXcwTXhZdjlXUHNUak5Ebys5Y3JYd2ZMZjV4N3dpN2JH?=
 =?utf-8?B?eWNnZ2JPK1ppNFE5cXRPN3dLMjRDNGNXK3Zac3R0ZmZhMFJjaVhLVUM4S1ZN?=
 =?utf-8?B?OHJJVVhnTjJyUEZUMUFnVWR1YlNWUGsxMGJERzBlT3FzUkhEMmNiQnhxSGR1?=
 =?utf-8?B?TmZzWVhHWWE2OHQ5SEs0NzF3d2w3UFdmbEp5eVRSQmZtSEk5OTdScGlDK2pC?=
 =?utf-8?B?ZjJSdXN4azZOV2ZXb1I4MHFMdDdrV2xFeWJ5ZlZ5YTR4UFpmZkY1M3ZRbjIz?=
 =?utf-8?B?cVgyNCtNZ3VFM3lnOTlZQk1RWW9XSFlPWURZUHZyaEE3ZFpGQ1FRbStITnJB?=
 =?utf-8?B?RXJleVhFT1d6ZXgyWFBwNEkyME43b3RsRFh4MkNCMlNLc1Z6QURqbVZCZlN0?=
 =?utf-8?B?RW9SQXlYb2I5cmFvdjJ2YnBPRUl1blpqemtQNjZPZE9lVzlZWXZ1MUdCT3RF?=
 =?utf-8?B?T0p5NVJhR2pKWkdSM2JjU09qN1ZvNkpBWituRDVkQVFJaDROblM4REd4QnRB?=
 =?utf-8?B?U0xzT0ZuSTRTS3pBU014eHBRQUNsL2tUeTlJTXpmMkZJOFFjYVYza3dxcVN3?=
 =?utf-8?B?d09wTVE4cldHZENndndKaEhxTTVmOWxjWERCZ3ZTcnpuQkkvaVZpT0VMTXM5?=
 =?utf-8?B?ckpTOGdpOTZ5aTdITVJ1bDV5RUluZEZ5VTZTYkNHSEx3NFdBcU5EWTdTYWtU?=
 =?utf-8?B?NFJxdUhEQUJRb0JJbG9QenVtd1FHeDUxL3VlajNjcjFsbVV5bnNaZ3hmdWda?=
 =?utf-8?B?a0MwTHlaZ1hibDBLTm44dktadk1vby9aUWs3NFcrQmFmdWZhVldkT0x3UGZ1?=
 =?utf-8?B?dkxneUViUGVYNUNNU0Y4ZzhUUDJZTjE4TkRDLzBjME5qK0RSLzVKMExWOE9w?=
 =?utf-8?B?L3VBaS9IbkNoMy9DTnBvM08wWjR0THQ0M3R0RjhWRWx1c05RNmRlVklrVlNB?=
 =?utf-8?B?ZXd3OVFvK0ZnR0JPclo4MTNCcUcrR0txd3Y0YTk5cis1U2hQVHM0S3JLWEhF?=
 =?utf-8?B?eS9RNy9sWnBIN2FKMDZKRU1aR2tEWkd6THlKb0V6MDEzVWllM2duQ1FhQWRH?=
 =?utf-8?B?KzFzQTV4bHVkRWFOSWRQZmt4N0VDemNzY3V1dU5jdXdKdW5RM0pYK3pXTU9k?=
 =?utf-8?B?Q1l2djVuOGFTdWhvSDc4Y255Z3J2eHNEM3V0Z1RGZlJRWFAvOFdudHJuc08x?=
 =?utf-8?B?WFpWem1JUjRHUTEzcnowcWJyU3gwSGt1SllKMWdrcEpCRmV4TkV3OC9qVENK?=
 =?utf-8?B?WjVXYU41RmUvWWhvdDBDMXRBRG9ReE1OMnphR2g1MDJaQUV1UkkvOEZ3V2NL?=
 =?utf-8?B?aFpadzZSL1pSNythdTZLTFRGV1VPTDI5Y3gyVlg0SXdpdlRiek9oQjV1b1ZF?=
 =?utf-8?B?V2NIZHFjNjlYNXptaDQ0bDZhZ1BDZGhvamVRN1luRnRIVUhlL0pKQnJMamky?=
 =?utf-8?B?a3Z0ZHhYTkRpcmJXbWRJcDNJNzhwdnV6aEprNHg2eXJLSTNhNmpsQXg5S1ht?=
 =?utf-8?B?L2tKcWdjN0VtWk1HdUQzUHY5R1lrdVhmZ3J3dGVXS2M5aHFNRVJyeFdsREk2?=
 =?utf-8?B?aXBIMURIY0d0Zlp4bERHQTQzTm5hUy9DT0UwdDk3a1J4RWN3ZzA4U0I1dkww?=
 =?utf-8?Q?v80o9CwE0ayntBgHIRVzEXsBZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c10d7f-7506-42d3-0218-08dd5a10fc5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 05:05:16.0086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+55uAyesjGtopWolJR0GB471kHwS8qcZmfryrp/TmINdM6vcwU5Jc4lLsCAla5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654
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



On 2/27/2025 8:33 PM, Asad Kamal wrote:
> Fix indentation issue for smu_v_13_0_12 get_gpu_metrics
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502272246.OISqUnC1-lkp@intel.com
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 5e80b9aabfc9..285dbfe10303 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -469,7 +469,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
>  				SMUQ10_ROUND(metrics->GfxBusy[inst]);
>  			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
>  				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
> -				idx++;
> +			idx++;
>  		}
>  	}
>  

