Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A57C98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81BC10F384;
	Thu, 24 Sep 2026 07:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PTRjKqWL";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBCE10F384
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hat5hynWzG6PrdxKMpPe/Q9PCx2sV7+NTSw82xCoRHOAzypeVZevDbTTxnUg23wm9RtGcOlPD4x44dgg0pjVgCLKG1op0+o+j8PmROH9OS8kRVJAVDmHGvu6pVC53COnSDHYDtJb4Y5jcaHDb2Kc6K/zTZZG+l9a+XctnBg9Q1XWzWPOufPsUoawvHvSMS0aYrNm3RULXqQnSEiLDyLL6yWMua+hykDX29NDUxF1mxnwzDcdsms1cGwdF99uTPZpIQsUm7/oNyjxktxKlCs3m/MKU2Gh8loXu6196TbFOZvwXKS3n0xHI8mLeICJRUzoq1GCC+Dwv8fopnpGggYvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b/AF7D9BAkyL4Q0iq+0bG6HpxFKDYUrlF8yc5olrwo=;
 b=tDgH45BG03g923Fg3Q/u/JmTIp7KuHtfEHUYqMI6eG/K2+av3kLw0bLePmgCj9GRUpKeQJwh0ZSArV3hh9Zg76HLKHkLZu79ZBbb211NQn55NllRPLxtRvhFfvdZqJ8Tc7Ty9Qs5Pi2PRcvbafETGkTHsefRPt2dxDMlH5pYtHaCVLsqK//11CUj1GSxfA6SdzzXX6cSHS2MdBIRccuQegVVDtikGepi4Do7QreKJ+F8TIiJBL6nQqKyYfouDiGRJ7V0Fcsfsrq4WWMKg807FZRMxfu0Vtr9XP0GjNIXfIw61tspT1i894NKhl5xgu4qBKWs2V+Q0Q+i10OYusrzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b/AF7D9BAkyL4Q0iq+0bG6HpxFKDYUrlF8yc5olrwo=;
 b=PTRjKqWLkX+K0/6qdIy/EU6FTx1TxykYnBpd9TLSs4/U9k1mnYjGx5iLTa01L9hKvCbtqW2X5miOpteAjqy/hORtmMZd6y7tn5IgG9H+pYigzC5bECaZroWbwTKNoxYelnZ8QQKxkQJwga/zFtCG0a+j3C57hDQf7URHC8j9aGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 07:47:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:47:29 +0000
Message-ID: <8c04fa9f-3000-48c7-bdfb-549a004ddd68@amd.com>
Date: Thu, 24 Sep 2026 09:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] drm/amdgpu: use pm_runtime_resume_and_get for
 ctx ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f381b2-cf99-4d88-d71e-08df1a101530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: JL9sCMjOM4mk2D/Ek4QOVnCCpX6lBh9eei07DPv/2FHo3HGSz1YWe6nnYoAYjyshdpnwQie6+3SVHRe3WFMT9yUFeMyB4rJ4bEs1CcLTonOnWjIgMN9nSC5mgEp4RpM4bYBg1LMVWBBy+ywsggkimf+L+djlPFEU8+Qv0o4968XZWVnFkdZV0oTjSmhbAjQ6npNS1N4TBjT+nAUDMBhW7rGSSdGW4LsPz2M1URcKZrr3p4xfHGmDLB8LdUvLqESehTv1742Ok+Q1xMee4vZalL0PWyh8lZb++RHGf4GCec5xJZmZagU2K/kls+IfzkO9/tEJt+k0dZdPL1nq3W1XNOJ8XhySfm+RzrgaW4Yc9xW4iCQWMjNC/jIDOaytTe2CBnN+HoOXFlo7XpoGmrgMVsxyrKgXlvv1NITl1OoYIaxUH8l2EGZl1pKw59UtlUkNK3MzAWiApsY0BVKCMetzmpd+SMf+Mt64F/sc4KJQC2P80o1pxUft6Y/6Um6rUmzuGVGnllzeIYhM9apgB2Pc07n5VEViLqnDS3SXLQ5/IO4qPezukqqbVxQLmcLsWO5QjeTBoQyu5yieEBbkW7NWzZe5jHXRQZU9glCapAPxVXynk3ELE0xiFMA72pKxg1MC+MBYg3L/yCak1GIzWHpSL/+uGF/qnJl/FUMpL2Qre4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTlPUW9GUXI2eTRYeU9lNkNhc0JFRDc3NjF2ZXRvYU4ycUg0ZmkwSmJCb3M1?=
 =?utf-8?B?Sk14UzFnR2JUSmZBb01iSkpKWEk3cVJWSjVYODFFaTNXNnJlNkI2alJKdjhH?=
 =?utf-8?B?cy9QcGxXR1ZHT0NmQ25BVXJaazUwK2xSMnFScnZmRGdibU1tV1NwbHR3MDE2?=
 =?utf-8?B?VVNPOTRiR0FkQXNJc1VrMmpxRWRrS3MrR2pGKy9YVE5sRzRFZjN3dEVKUVUz?=
 =?utf-8?B?UWhKWFMyc3FJbXorQzRVVDR3RHFPSDc5MDZXZHp3ZitCbCtTMjNZRFdZNEp4?=
 =?utf-8?B?ZTJpYURNaTNaMktpSzJNRzlYYTBPVDVlbHFDd1FWbTE1WTNRN1ZzQkloOWlS?=
 =?utf-8?B?d291N3hUYVA2N0ZqNUNxZXN0L2RkL0wzZTFvbVpSQUh1SjVGdndHOHVUS2Vt?=
 =?utf-8?B?enBnQ2VVVEw1d2JXYlJoWXJvWmxoSlBNcng1RG8zU2dlSnptSjdCakZkbThO?=
 =?utf-8?B?Wjh3bkR5cWFJM3dLZlRLcDdBMG10YWV2VUZkRUVCbGZjeUtoN2h1d0FyNFdZ?=
 =?utf-8?B?Qm5UbGNaL3JRMVNKWE1ab3k4RS91UE90L1FqbUJkSVY4SU50WERoanFZOVhT?=
 =?utf-8?B?TERtUStNVTZyOTB0ZEx5U2tmZytGVmZNK2FQQkdlNlI5SkpLa2NMbUZKaE1i?=
 =?utf-8?B?elAzVFhrdVZ1eGszVnptVEN3VXpJUTNENjNrV2tFbEl2S0RKeWN5cVoybVBQ?=
 =?utf-8?B?NFFYNWhDQWs5L1d5RlpZekhzTEdybkdrV2YzOENoTWNYVW1GKzdCK3dWanlO?=
 =?utf-8?B?YjJ4cUR5SS9ua0drNDhLTXFQbHBncWJRdEIrRXpaWGptdmNicm12Q0hKMGxN?=
 =?utf-8?B?Nk5tUnQyK1BLUld2c3JBOGZnaHB0YlNZSDF1UldMb2s1QkErM1hJVHE5YVhp?=
 =?utf-8?B?dVlQMkkzdHExMStmQ05LdDlhTkt4VDFMZXB1UXBxYUkxQlh1UW8xTnhwcTZZ?=
 =?utf-8?B?MDgreC9YZS9DZkFnOTk5UnI3Y3U2VkxSdC9iNDltU0RPMk5TT2RDd0dDbUJ2?=
 =?utf-8?B?NC9kb09QWi9DcXoxeXBYc3p4L0ZmK0Z0aXppcmFiQ2cxdzdoMjgwU0l2eUpZ?=
 =?utf-8?B?Sk9yM3d6NlZodlptemt1dGNtcTRRbzU3Y3ptNHhZS0lJS0d0S3Z2QTl1UEx2?=
 =?utf-8?B?Tm4ybEFqL0cwRURnT1VaYWtxOUxyMGs2STU3MGYxTWhRTzlrQ0I4UEhRTWdX?=
 =?utf-8?B?cHdNUEUvZEFTcG5IMTdwZjhmd0tiN1g5eXZIRGEzTktRMUlPc2NNOGI5M3Bn?=
 =?utf-8?B?R3pSRXFTa2daMG96dmVib2tabFZVYlMyUFdzMkJuSEMxT0h5Q1h4NkR5UDRV?=
 =?utf-8?B?b3A0Qng0UW1QdCtmT01vYlk3MkxRQnRiZlYzWFd6VXhoMkxqT1V0eHFkb0Zo?=
 =?utf-8?B?amR6QU9idXNzY1dwY0NEMVhYdnkrMmRZOUcxeFdNbzkvOVdxQzFoQWdSeXF3?=
 =?utf-8?B?cFlRN1Y3Y2ZDVWovbE9ObmxOMTIwSEFGQ1QwWFZzNlM0UndoeFhYbDc1QWdw?=
 =?utf-8?B?N2dyOUR0Ty9XY2RGbWxiYnVFd1ZnYmJxSDRORVg4azJOaHJLQXJWTWdxd2Ji?=
 =?utf-8?B?Ni9Wem90Rk9JL2JVZ0VZK1pMZ1FuQVJFWlgrQjFXTms1MS8vRHJHRUpFdkFa?=
 =?utf-8?B?dkkwMUNvRFVvbG9DbjBPU2VHSFYrelNlampuTGY5eEEwcHJlcDVxSzQ0cjlO?=
 =?utf-8?B?SGxOTHU4MWxjdElCaXhMSjNxT2NrOW9XUFE2SlI3WStQN3V0UE43REJ1MWVa?=
 =?utf-8?B?SmdHMXdYOGNzeVBxZ003M3QvWFYxc09CZ1YySkVOM25zN01Vc3o5aGVCZlRw?=
 =?utf-8?B?TnhMNm9haHNWWTFFMERtY2xxSlNNbWNhZndaM1EyZW9hbHlvRVUyclFEL28z?=
 =?utf-8?B?bjR2ZHJYbTRZeC8rU1F4L2xvU2dTbXo5cXhsckJIZkhoVGVaQW9TaWF5d0dG?=
 =?utf-8?B?RTZ1RWJvbWFTYm1EbWY5b3ZKaDJ6cVJxb3pvQ25HZWQwYkdadldUWUc1TmZN?=
 =?utf-8?B?ckgzeXhnL2RENUlDU3hxbmZaQkVLSHp0ZWU0R3pOZDNRa1B4UTM1c29DVHo5?=
 =?utf-8?B?MXowMEJoOVV5NEFIbk9oVUtkU2Fab2o5bzVSSmhEaXl6TjlLL3VsSjVURGUw?=
 =?utf-8?B?dGlUSVk3THU5VmJYSTM4NGVnZkVJT1FBeFlXL2lrTTB4bk5qU2c1V1YxaVRW?=
 =?utf-8?B?V0VjMDJyNEUxZ0hrc216OERoUUhxSDkwamVIZUJuekIyeXNORmVCbXQvemlN?=
 =?utf-8?B?VDFqQU45UTYrSTVCVXM2V09HNEE3TFJZaStkR1pZRXNwcnRTeVlnVWdKK2pw?=
 =?utf-8?Q?YTHO/c/Pjf/uAiEwW7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f381b2-cf99-4d88-d71e-08df1a101530
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:47:28.9126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlE8TX4wBDJRPE9vsF+o78j17XphLFolt6WXmd+73t/lClFZ84T9LSD5UGjd8X93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Only amdgpu_ctx_set_stable_pstate() communicates with the hw.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> v3 (Shahyan): fixxed typo in commit description
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index b15ed4a534f1..a87f26139496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -28,6 +28,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_ras.h"
>  #include <linux/nospec.h>
> +#include <linux/pm_runtime.h>
>  
>  #define to_amdgpu_ctx_entity(e)	\
>  	container_of((e), struct amdgpu_ctx_entity, entity)
> @@ -643,10 +644,15 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>  	 * context id.
>  	 */
>  
> -	if (set)
> +	if (set) {
> +		r = pm_runtime_resume_and_get(adev->dev);
> +		if (r < 0)
> +			return r;
>  		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
> -	else
> +		pm_runtime_put_autosuspend(adev->dev);
> +	} else {
>  		*stable_pstate = amdgpu_get_stable_pstate(adev);
> +	}
>  
>  	amdgpu_ctx_put(ctx);
>  	return r;

