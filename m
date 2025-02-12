Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFDBC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9A810E0E6;
	Wed, 12 Feb 2025 15:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="soRPtRDX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149EF10E0E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCmYdWZbUsrx93Sys5mU8bEqlru5axe/pAHZc7Vex7NQRXsdhO3t1ZqyfUX8s3/8yc5l0eI8xrWk1/iMWS7iNLX/X1oGT35PB6889QivpPoi4u+RO4+rLmy2jfmrGwN1iZrHZB+Bqc3Igl+TnYSETHNcYkQhErLz8YmBC9XAnYSZehZBzh5+XYoWukZbckfjho3ILWfAR76i2Utrhsu58qOnXRsPdfNs2uuG+LPIv12xHkzwUMU1zdlT6e4j6U1K3Gr/WJtZKL6V9JC3bRdWU1SZ8HuPuySaYapB+DSvu+0hF+nlFtJ3oa4wH81a6cp2SFbd7mpZYg81z4HghSJonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqCfGMbKjn1pgF2LPJRDLoHOW7FY2r13O5pAxM0P7wc=;
 b=ZHiQmORgB0Y/QhAq3wIINxxhzcxQy1dHAJ5Y8TXevnirzBjLV48DQiCynjsNC/1d3A8eSQUY4VfhyDtLWEw7A38BcfRcsTy9MzhldpIFhAs78DkWQNwYupPbTpu5prZ5StGkLRtJMUx558+ExDEINRjjYOpo9j6BddF3OKZb/YKpMZDNy46SaSeiTSaLMSvpbf1tqCq5BQdBt0vEWcowvU6otV9Xg1g6LXcwu764sHIBIJWoFGrfl3sPNnT16mA8Cse60kWaAMpAQy0w5vIrtpXSvcBtfGmoUMYwS1bv708pZ61KzzszwyH8KgdtvIw7goZug0jLdtLS5IrF7tyxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqCfGMbKjn1pgF2LPJRDLoHOW7FY2r13O5pAxM0P7wc=;
 b=soRPtRDXpk3poIlDLLMrjABlNQqSkYE7hx0AZDAZBkpN81PuXcTbf67UoA2jYe/5gOrcQBNBj/1ZJzTTPiBqYVHaM3M+y8SFYo0hlkFTbFw7e/IkB7+ZDY3hIZRRCpINgYbydpbHfEJwPKbPtrgqcMl9KWTJuhNYR6Xtcqc98kM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Wed, 12 Feb
 2025 15:51:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 15:51:59 +0000
Message-ID: <3b433507-42a6-4f5c-b03b-1bc176277845@amd.com>
Date: Wed, 12 Feb 2025 21:21:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn4.0.3: drop dpm power helpers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250212151559.2683916-1-alexander.deucher@amd.com>
 <20250212151559.2683916-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250212151559.2683916-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bf8607-7d04-4696-b529-08dd4b7d2f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlQ4TGRjclFLbTl2dm1lMzk4TXI4ZWZGVDQ3aDNtaWJKbFkyV1ZSdXI2aGZr?=
 =?utf-8?B?czBoaUxBc1hOUTVUdU8rUExuVFZHMVhCMU1BOFJ1QS9RVnk5d25aSzBITStL?=
 =?utf-8?B?cDc4aWZqSm9mRVpMMXNQSkZFZXd1N1FkQWs4RElLc1RyQm84cy9BL1lBYnlL?=
 =?utf-8?B?cUFWUTlEY05tOTZsc2kvcEoxbHArcFhVK0JIZkRlbUhsQlh6eEhzU1kzVXpV?=
 =?utf-8?B?aEZqdEZJcm5QaHpTY25DWld0V0RaVnlkQ1V4L2l2YmcwRmw4NllZN0lpbElE?=
 =?utf-8?B?WEJvQk5yU0FwbEZMS0RLeTlsckd4K3ZGUFo0RXBPc0JKbkcxZkpKNVkyQyta?=
 =?utf-8?B?NVBOZVZtNnhidzM1ckhTOFRRMllNczNGd2pLeHJaT0dEUVljWjZGTkxsRDMx?=
 =?utf-8?B?YlA0RjN6bVYrSmlUc3ZDVFlCZmVySVRVc0svQ25SLy9IRkI1bkEraU55eHdU?=
 =?utf-8?B?enFMSzJXN1VWcmR2ZS9OTUpDcUtuM2V1L2JRY2kzeUs4MjNoZjdBVnE1bXI0?=
 =?utf-8?B?K0JpUVZmRmZlWlNKTTVBRDdadW9GMzlEQXFwTU5UZk0wRFpuZFZrMjNvWXFM?=
 =?utf-8?B?blZjVmpJazVTVmUvbVFJUFVnN095U2czYjN0Y2cyS2VIUEtLYmhCTzlxV1ZJ?=
 =?utf-8?B?R2FqRHZrRlZIYkVyUUt1cW90bUtwVy80dVBBRmppUldUOCtyei9sWXNpOVVR?=
 =?utf-8?B?cHRKM2dEZ0VhU25YU1VOSDVjR1BrcnhaUUpJZHNSOUtxUmRJSGxnUjFkb1k5?=
 =?utf-8?B?M1Badk5zc3BFbjZhZExaVFlJZlMvaFNNc3FjWFZLcU9ISlpPMkg1WW1WSnhH?=
 =?utf-8?B?a1ZhUTFCQUlXb09hbVJiMU5DdlQvK2lta2VLa3RzaTE5MWF4VGMwM3RYdFV5?=
 =?utf-8?B?VUlnZnNNbDIwYVgyZ3hoUzhXY3gxYyt1Y1VsODZTYVFrbzBZazJJOTF1SzdU?=
 =?utf-8?B?Y1pid005SGIyelB4TGJZV3EyVHRxRStMSmRTQjArUk5HMnRlWnRIekFhUFJT?=
 =?utf-8?B?bGdLTnJoanZQSDJjeG9Pc2pOcEx0RWlyZm8wRVc0L1FTMi9JY2hBZElhN2Fr?=
 =?utf-8?B?ejV5Nmg3cU1KM05LMHJhT2NrSi9WWm9TMlUvczZNL25ScHR4UnZremFyT2Ru?=
 =?utf-8?B?MVo4cmpwMkVmS2c4NjlRbTROMm5xb25Qdzl0bFI5WEN0TlJKY0UzNlcwTzFu?=
 =?utf-8?B?VzF5NTFiOU1BdnlveWxBMzI2SW5uOElBWWJBclE0MzBka1ZPdlV3SmI1a1Yx?=
 =?utf-8?B?NTdlMHFuRlNQTVB6Zlg4MDdoYVlzZFc2TllZWDRmeHBTeFFrY3dKelZ0T3oy?=
 =?utf-8?B?bjFBdUtYMUtjOVg2V1NJLzZ3YUo1cTNEM3hESEFwSzFkSGF4dHVSOEJ0SEsz?=
 =?utf-8?B?c0plODdwUktXcmNxS0FhK0gvemJCY0FXQ09BQmFUR1lGVGw5VDFCbFdXajdE?=
 =?utf-8?B?aStwTDl4aDMzcE11a2lTMC8zQzR6Rk1LN3dwdlQzSmpucC9OclNDVy9scUt2?=
 =?utf-8?B?MEJXZXg3ZVY1SGQ0WTF0Y3V2Y3Y4YVRmd05wMmU0VCtlZW82V0QrYUZOT2xW?=
 =?utf-8?B?cGxNc2tuV0RyWlNQU1REcm5XQ0g1ZCtIc09LL2FyZ2dCQUhhektPN29SYWpt?=
 =?utf-8?B?bU84L0hBMC9wTVJwZy84SlpRNXdEUk1uRUQyd2lESlI5VGVKbG5oT0N1YXc5?=
 =?utf-8?B?UEVDanNVRXhqek1YM0gxMVhFY1NEYStaSXNZMWNJUHV3dzV6U2Y3SDl5QjB1?=
 =?utf-8?B?RnlwVjBSc0JoaExSTk1zKzdySFVnRDU0MlN4MkZYQzJ0NXRRR0JDVnJWblRV?=
 =?utf-8?B?dmh5bHJLbitWSXhteGtpclIzU0lqcVNkTW9BZXhMbkNFUHZITkEwbEVZWk03?=
 =?utf-8?Q?6Gm3bCmpJ0AjL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUg3NHp4b2lrRnZKY2ZIU25lUzdSNGZ1RzRQcXhGMWc3ZXBYMVRsRGwyaUxK?=
 =?utf-8?B?bmVmYmVkL053alBaeTR4d0Jua3p2eUJDak1nNk1YMWttZjQrVWJvbFU1TVpj?=
 =?utf-8?B?MDhOQktjZjJjQnNrd0MyR2pxM1hJSjRSdVViMW00bkVFSlNUS3huWklZdzNZ?=
 =?utf-8?B?RnpuSkhLMktHVWJuUHdXKzJzQlF0azhhZjdoSElZbWVzV3hoenN0RmdKV2dw?=
 =?utf-8?B?dEhpK2ZFdGt2dkgyaVU4YVpNWGhEMWI2MkU0L3Z1b2QxYUIwSTFkd2NUK00v?=
 =?utf-8?B?ODcyNnBmcllEK3FLYWRtZmtHU0p2RCtyY0V0L013czFVRWF1cThrcW9IWE02?=
 =?utf-8?B?VG5qOGdNdEtPWlpsdUVyTVlRZHJyeGg1TU01eU5MTjlRZVlEbUNxWkJzd3VD?=
 =?utf-8?B?VTlaRURmbHhDc1Q4RlFrTnJuUERnUlpPditvdWhLeUdGVkE4QmpDRXJMVlZV?=
 =?utf-8?B?citLRE1yWGhtMldvSWlRUjZhTFZxbTN2T29IdHBYaXRPVHgwK3o4ZXp6cU85?=
 =?utf-8?B?cGpxVERxMFNIeHFSakt2ZEdldyttRkprSlFZNFZCcDFGS2Z4ZUNqSHZMMFFn?=
 =?utf-8?B?UXNqbHdhVEREQnRCS0NTcFUyTFRDRHcxUCtlMS9JN1lQT0k2T2JsaTIzWUVs?=
 =?utf-8?B?WDVvV0lyY3NDZkh6Wk50S2VkL3FNNHFoeml4ZXFjU1U0cG5uWTl0YUFwaElY?=
 =?utf-8?B?R0RWQm94THV4ejZzVjRSU2tZaFFSTXNUWDJyeUtOdVVvNVJRcmNkWi9NYWFY?=
 =?utf-8?B?MUNYMjBxMU90UnlnVUs1RTQ2WVVpVDJ1R255VVRXYmY4K2F3WHBNYjVPbkJo?=
 =?utf-8?B?NHMrSElCT2IvMU9YR0tIbEt5WGgxSm1XZ01Pcit4dWo4MkNaSldlQWVTZ01h?=
 =?utf-8?B?S1NYeTVUM1dVcG5wWmhrSnZiRUt3K05SdVk3UVJSQzgrV0VrUXZ1Nlp5T0Zi?=
 =?utf-8?B?MFdobm9IS0JmcDBrZVZxaEtlKy9IcU4xeG92N0pRdW1BckwrclVTZG9XN3E5?=
 =?utf-8?B?MGpJaVhhdjV5clFKQ1RpTkhQSEFJZVJ0QXN3T2pIR0hqL3FSNEI0Ly8yZjY5?=
 =?utf-8?B?cTZBejhMVjM3T25BODVLbVhuVnRKWjNpYmhQYUwzWllHTkpYWm5lOS8vQndw?=
 =?utf-8?B?MDBibmNmdTJMMTh3aHdyb0VxV0Y5cElGVUZ6V0hyMVNhYTEwWVk4QUdvcXla?=
 =?utf-8?B?WVo1S0x0Wllra3B4N003M21JcFFvN1NGaGJBbE51QmtRZHFna0N0UzU1a2Nu?=
 =?utf-8?B?NFJvcE9INW1UQmtHZ3NoUlZsTkZSK3FPK1lMdWdIZy9MSHNIb3pXZWg4N0x0?=
 =?utf-8?B?N0xoVXJrSGE0Z3Vzb0lzSXhtZ2w3RFF0S29PUU1kSWVjZkFHRTdPNVZOcjNo?=
 =?utf-8?B?VlVBT1hhSHhsZDFkV201L1QrMWZXTTQwbjlpRzl2QWc2R3pRTFlqUWdvMUNE?=
 =?utf-8?B?c2o0Q1Roc2RJUkhyS2tNUzFLckxPclF3NXkvZXNyVXFxUWZpYzQ0ZGNqWGFJ?=
 =?utf-8?B?WmZiMlM1WmZCdHkyb3l5WDVQRmlCZWRaWCt4Y1RTcFEycTNSK2pSQmxiZWs0?=
 =?utf-8?B?QUpUUTREcytLOU05NHJmWkZuK3orVDI0Z2VuTW5IMEtLUTFuanB1MStNbzR0?=
 =?utf-8?B?L2d3dDV4UnhDMS9KL0MwZmZuNVBWUkl0WG82RDJlY0tkUms4L3VUcFJQcWUr?=
 =?utf-8?B?ZXVYaDZKUTVsL1VwTDR3azZaTUtWK0JxWmJkNzdWTDhmb1dnV2pwcDB5QTdY?=
 =?utf-8?B?VFI0dEtYVzR5T3VFM0hiQ0QzbFdxazV5bWNPci9SVGhXNVJoY2J5QUxuUFN2?=
 =?utf-8?B?RzdMTjJTdGI2UmxGUHlSRldTeEUveDVUNUp2dk5jTjBERElsWWtGb1ZON3k1?=
 =?utf-8?B?SkNFd0ljYTVnN2lKWDhtYnNJY3BqZmxUa2FCWDBxNXEvRXNzQUw5WEt6ZFpD?=
 =?utf-8?B?Ymh5RGJzV0tKaXdqeXdlZ3djUWI2RzV5K0wzdGM0U2JiR3VRNDhYOE5ua3V0?=
 =?utf-8?B?OThGTjc5L0lmS3NSWEN1NVJYKzh5SFhlWjR4M0dhUHFMczlsY2N1b1BzcWlm?=
 =?utf-8?B?QUdreUdFdWpBb2czVkE2b0MvMVBqOFBqcTdaYThKRVIvU2JBdnVmYzRYZHZV?=
 =?utf-8?Q?TRo+gwEkw6KDME0MnT0UmLGNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bf8607-7d04-4696-b529-08dd4b7d2f0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:51:59.2471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBJCbQjwo2Js7n6QGb307q/g5gg+F2TTTDWatd+Yma0QoTzSvMm9i4aedVrdxa02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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



On 2/12/2025 8:45 PM, Alex Deucher wrote:
> VCN 4.0.3 doesn't support powergating so there is
> no need to call these.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches 1, 2 & 4
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Patch 3
	Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index e09eaf4469ddf..acda694eb74ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1127,11 +1127,6 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
>  	int i, j, k, r, vcn_inst;
>  	uint32_t tmp;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>  			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> @@ -1403,11 +1398,6 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
>  		vcn_v4_0_3_enable_clock_gating(adev, i);
>  	}
>  Done:
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> -
>  	return 0;
>  }
>  

