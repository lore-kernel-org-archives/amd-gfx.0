Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5054AF53D90
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 20:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC90A10E4B6;
	Mon, 16 Mar 2026 20:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cO/L29H2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013020.outbound.protection.outlook.com
 [40.93.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7CF10E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 20:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtZgLCZX+MOCyi0TaQQLcqabZ6w5YCpwENc6eUwW6DKYnMNN9MduOsWeJ9FCSd6/22RCIiwYm61+ahMNOmT4VoLxjdx790jXtELDR/HK8o6AZ73MLucupv0dtdXeu7r1pR1xQCveBUqIh9aXJclSr8jc4MsL0zT7qFYOIDEI0h4Npf+698j83l91yQQs919WhugTNBjT5nOAhYtet1UNNRHwOlO7IVXUcfsNJCOlytoMjhXKuQ/omMz126VTszth2Df9ylTwhCtDNIxaBLrkrE9u4dgqmz2ajuegDqbe2RzntlI8iu+MwO4hLsysh9Zjc0gF7bDdXawmzKB7qjL/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qQc1v8fySvaH9NavpxtCa66zmSaw2GpTY76w0IQkFg=;
 b=AGwuInt89vudkLGiB0SH9buV74lnglc1O4Uf7TfbiGfwAxFLo7hgCb+7KS4aDfFT20WHdWUvQcbTjdcddJPiQluWe5LYa2OQOQeKutwHxrt8ceBw3rjwMwNy8nFDLru7SOgaYxcAs6FUX+vv9RCRehCCPjRHwf7rlmtWNBuYP4+xAj0fQq+P9tveZaOOcmL73lMDj/02Kzcam6AokT3hYi5QpnAi2l3nRyDxnx0+YBswgSWq6BWfQS7EjTq6TguVp0YeWMWFetbLISDTy5ovWVQ036l87O4K2ed+/Q6FZ9QO15S/jFivGyku7xloe1c3utp/Tvcli7Dg3w8biNhBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qQc1v8fySvaH9NavpxtCa66zmSaw2GpTY76w0IQkFg=;
 b=cO/L29H2llTsRaueNb0fbK8YqbASL4FE8Yx03tawatJDeY17CFYgJ2nFfB2yP4sykYYnL78+ks1f5NFVPoFpo+PXGfY7xgUL8N2NbuY4HRxdlFg7ZmlMD4mEKKs3hXUkH2B/dMPnVTq077ZG1txQpYx46EjDipqrh3A+xZKEpC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 20:13:24 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 20:13:24 +0000
Message-ID: <307e01ee-272c-4a7c-b623-72d860adc60c@amd.com>
Date: Mon, 16 Mar 2026 16:13:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc9.0: add bounds checking for cid
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260316195252.2027784-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20260316195252.2027784-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5cac68-3b70-46c1-84d7-08de83987a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Talwp1Xq0vpeIV+vsB8d6Eo4vJwRt8VXU8aPQ6K3ZzrFYQP9Jaj+Y3flAfej/BVp3fHy5CuTjabInBfwZOK79TIKMmY8TTUVfn5xSCGUjt4txRY/+OrOQ5fPoV2j0xgaquoosv5K6vUtOwlSOJeHBZpNdGw3k/71Q/9VE52ymLMrr+KZ6I5Fn8FVEQzu6zpVmCji2H5hYwKDVRuv5soXWgsp9YkF9FKUH1FqYTwkrgrd3zstcW1azeAS+ukfuyVOxAB1uqflfasjewCVLtcrX4pvvPXY3QAT6NoIyow1u+4L/a80krdZkpUVpGhs7dGnVc64jtG/cODFGVfUdz1iyX9xWnwFWXt/Df8DO7ELbwu2IsyNOor6P/NnHz/uRnE3/1/P2kk0z4zmvWeOofXzvWYr3im/5gKCxPAdoUsp1uQpaAiiGNLDdNqNPKgA0jEVQYhntylonWdYwP6DLGDX2xahWP9LhdOdQ77Y3OhjncpsqFnTPFwZThWrGBrG7/8QGlJdJ9TjMBAuo3JdtYKVC8X4aK8T7AjhI+Bu0tCpa1FupNnuYt6q/YeCA7oxBavW0irkJysS4eAZiYR2t+vXLBrZDSCRkvMvE8ZqTNJKZU4goR0rfqpKVsSdxToI3mLduM9FreoAsyMgc79Tw6KmvTAm1AbobaQ32k83Mitf6B2cM/JVJcoE7z2lGF9Ehu10NXIhp2QTNnpAizbc8LY3S7LupisSYTLi1ez53ITGtGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFR1Rm9md1M4bGJvaUNqbnNEM3VRQWVSUmNVSGNqYWNWcjI3U0hoZ0k4NVdH?=
 =?utf-8?B?ZittcEVUYU9NbnFNWE00ZS9HcmtWS2VBNGVEeUllc2QxdWw2OUxTMHR4QW1q?=
 =?utf-8?B?T1Q1MVVFK3NBMHBwZURzYlRuRGp4UkYzNnpPZFdiTnJ3QWI1YnN1a1lOVVNs?=
 =?utf-8?B?UTBhNkVzSlNOeFVOeXN2UG9qaFd0NEN3ZDlEWkRKQ3c0M2J2b01Kc3YycVVk?=
 =?utf-8?B?WXNMak0wRys1VVBXVHRqaCttZEl0Qk5uajFXVnNjSEVNbU53a0NKQUltOWRr?=
 =?utf-8?B?bXA1QVkveERYTGk5cmpZYWl3bVplZXRSWHpEa0t2d0UxT0pyK0dkSkpocTdi?=
 =?utf-8?B?c2pUSFY5am1rMjdXV0NXeU5lMyszWEJieE9xK0dyOFkyRnRjTzRRU3dUMWhY?=
 =?utf-8?B?WVp4WWRrWmF3RGExL3FhUFovRHpYMFUwU1o4aVB2ME5HcFRRNlNnR0JVZHNR?=
 =?utf-8?B?bFgwbkg3ZlltOU82NFhSbVJJaFNseGp1dGhVRjhrVkF5ZnlzL24xMDRsamJT?=
 =?utf-8?B?ejhITURWd3JzNnVGZ1F5S25Sa1dKUkRtUjI2dUJFem5BNXBTaGFkNVhPZE1O?=
 =?utf-8?B?b2owazVPS2dJTDNKVlROVDNnMDFuVlh0ZXl3UExJTGFLcitIVjNHZUkyVSsw?=
 =?utf-8?B?V2UwbDB4RnFWMDEyWnIwQUNvUHcvS014QnQ3UDVvZlRZWDVhZXpKd2tBOG9V?=
 =?utf-8?B?OHIxbDJtRHFzMGtiUGR6QS9JRmVxdG9PYjNoOERlSTdtbEpvczFtNHh6cURw?=
 =?utf-8?B?RE51V004NDRxTkIwSERPTXIxc0srbDNIVUErT1d6Y2ZuSmtLME9oZTJ5cjFW?=
 =?utf-8?B?MkEvTCs1emlaSXpQQ0FKVkpKdVJHeTA1V08xMTE0MUsxOUJudngwdVBuY3BV?=
 =?utf-8?B?NXZHT3Znd3I0QWhxL0JwSk5LS2dmcDJxRGFkelVua0hOZFlBbTR3N3duSUJQ?=
 =?utf-8?B?Y0UyY2JWMWxVMlJnQXZEVzltTVZpL0hOTk9lU0E2UVFCRmd6dkxlSTAzdUJI?=
 =?utf-8?B?V1AzMnBQVWdGZ3dNS3E1QmxXdE5VaC9FTEtXeDBJVFVIajg3amhWVklxayts?=
 =?utf-8?B?dGxPS3RveXJzOXQ1Z0FBTXlEN0hqRlNMS1lkZUh6S2lxZFlVSmFGM1lnbnla?=
 =?utf-8?B?YlZGSlBkWUhhTGpPSkpKRG1jY215bzhMMSs0YzNnM3dHUmhZMGxDemZtazE2?=
 =?utf-8?B?SzZFLy9nSkw0YjNCbkRpcGU0N0c2eHA1VlBtelFaWVJKREMzQkZEVkpCTlg2?=
 =?utf-8?B?VEpZd2NmUzMyUmJqT2NVZkk0a0YyQ3g2NTFOZkRnYVNNRm5VVWF5bUlpc0pZ?=
 =?utf-8?B?N1VzSlZ6MnRtQ1M3U29PeWtOcE9WTkI1Z21lVXJpYTZyalBHQm9BNDZ3VElu?=
 =?utf-8?B?cWR4VmYvbHk1b1VnUzdITDR4WFBFYm56TFJkcS9YRnNrUm0wM1h2U0xqTEJC?=
 =?utf-8?B?WVVIMnp3R29lQ3F6dFFzbmxKbnV4SHQ3aFhDOFg4bU04NTNzY0dNVlRGRnpj?=
 =?utf-8?B?MVJPWWsvcG4vRWFWR3hYbTRGbGlYS0tLZFIvVmVEYTdCWitKLy85WWZFQzgv?=
 =?utf-8?B?VnVXQ3JOaXhCSXkxOE02TG1FYktoRUJ6QW1YYjZKMWF4cVpJOHRCeGhuVENC?=
 =?utf-8?B?MHNIUU5HbVcrbVJ1ZnE4ZURpQkxVZi9YVzJMeVlKZzg5RmFOV2duRk1ycEZm?=
 =?utf-8?B?NEZ1bTFzNTlJemxBT2hDTUFKaU5VY1pXMFFpUEMzd2wvaHVjSVNuYVQ4R0ds?=
 =?utf-8?B?ek1sUjUvcGJZS2JobDdUbkFCSEpTYkV5eG9ic1dxS0Q4STNXaEdsYlZJVkFP?=
 =?utf-8?B?RE9paTdxcmxhU1dFamk2S2g5eDZEMDRQNSt3SU1PWVloYjR3aHRDNlB2UkIz?=
 =?utf-8?B?djBLa09HTUM2YUVRbHVmLzJFT29kY1A5bVo0Um1ySmhTQ241RVk4WjBrMldI?=
 =?utf-8?B?czdSV0VyVmZZT0VUZmxWRUl0cWxKTWZuN1JzYm9INjlyZWxrREhMSWp4SXlO?=
 =?utf-8?B?cG4yNTRvMnl3SzkwVlprTVR2ZDA4M29ZcEpvek9xVldMRnQ2clZPd2NGT3ZQ?=
 =?utf-8?B?RktUZnVQQjJDb2E3VXIxdVRpYVRSNlFncjFEa2NEZTZCZDIwWm82OEpBYVB1?=
 =?utf-8?B?N2RIM3JhTkxGZVlYbnZiT1dtczhTZHdGakJoYXhzRTdhYjhldGVZY2Y5eHVu?=
 =?utf-8?B?RGdVVDg3TTd5dVpZWm82QzZOR0RCaTB3QTg5UkUvaUtvb1owOVVBdnRrVTNB?=
 =?utf-8?B?NU8rdFZBMEhVci9HODh4N1pjWm9oVnpSZWRaS0M0WnowSmFZdGFaL0hzRS81?=
 =?utf-8?B?S1hYZk5ZN3RhUWRja0ZuZTBBaTByYmZSMW1kdi9YbnRmUVc1MUg4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5cac68-3b70-46c1-84d7-08de83987a48
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:13:24.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyufu4ktcJEWmC2oSENenNa56hrToU578MNRwd7S6df5hfGDN2Gr6vcpiLSUPIcIodK6lm3zqZBc5QEagzJh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
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

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>

On 2026-03-16 15:52, Alex Deucher wrote:
> The value should never exceed the array size as those
> are the only values the hardware is expected to return,
> but add checks anyway.
>
> Cc: Benjamin Cheng <benjamin.cheng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e35ed0cc2ec62..8eba99aa0f8fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -662,28 +662,35 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  	} else {
>  		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>  		case IP_VERSION(9, 0, 0):
> -			mmhub_cid = mmhub_client_ids_vega10[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega10) ?
> +				mmhub_client_ids_vega10[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(9, 3, 0):
> -			mmhub_cid = mmhub_client_ids_vega12[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega12) ?
> +				mmhub_client_ids_vega12[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(9, 4, 0):
> -			mmhub_cid = mmhub_client_ids_vega20[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vega20) ?
> +				mmhub_client_ids_vega20[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(9, 4, 1):
> -			mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_arcturus) ?
> +				mmhub_client_ids_arcturus[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(9, 1, 0):
>  		case IP_VERSION(9, 2, 0):
> -			mmhub_cid = mmhub_client_ids_raven[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_raven) ?
> +				mmhub_client_ids_raven[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(1, 5, 0):
>  		case IP_VERSION(2, 4, 0):
> -			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_renoir) ?
> +				mmhub_client_ids_renoir[cid][rw] : NULL;
>  			break;
>  		case IP_VERSION(1, 8, 0):
>  		case IP_VERSION(9, 4, 2):
> -			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
> +			mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_aldebaran) ?
> +				mmhub_client_ids_aldebaran[cid][rw] : NULL;
>  			break;
>  		default:
>  			mmhub_cid = NULL;
