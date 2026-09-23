Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0832C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2313F10F1E7;
	Wed, 23 Sep 2026 21:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnGFM2DD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD4210E4C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsL2vZ8uRd6KG+6ExFciersBQ8pACKad8r2n6EsAqoDwO4tbcR38M/lvP5rFwXT4nhsgK6Bx//b4m3d+TkPUT1EYU2K1mnxYUIrJSoL3LF73PFBaQ0xLx++7ocLJ19RXL52+61Aa4nSP5uFjih6Hgxwf1JwLaWMTsoMKeKMUA9SFhS/oxSsr43nB9mSGRKr8m5krXbVIVUTACVWxMf7fCuIX2T30uSzjJYJG65sYS8M/lsfTlsh+eoR5dBJaNQSpnpAExay1HhEjXTenI8fhWKN6yVuTv5zT/HMnFeoeyfQUkqWiPva7YKK7f8z6CSpsgfc5TELQhAQcj4NmRFqnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEgFZKiE5eXwK4uCECOfAmEsST38I4ka4yTIWwjPXN8=;
 b=Je75im24M5/G+lTCfxQCK/Rh88n5WM8wJfqSrHEG9oqRdthaqvrbBZV69iZ/RgQ2hdTK19pBKPHcMDZOrrwh8fhhuJMa29SEli55QotPQjqcBIm3GUb6jV7IUC8NSMp2tXbZGz83RKcQhV4R0FFzb56HOKVCCP9n52jDkeuGzVJS6gCoNyVx/1Bvn8+XJRKQX70LAMBOiDCWwOJh2JFhY/05xuSuiP5kcUna1m7cqPY9qY0TXU5/8Une1fdW21pAG4NFGlkcSoFTf6VN08oEwULrKY0Uqz1cYSPL7zw1KHvRrns7gTH+tC9Y39cYOQ4ZLZTZFKTL8IdtMSUEw9a1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEgFZKiE5eXwK4uCECOfAmEsST38I4ka4yTIWwjPXN8=;
 b=mnGFM2DDgmzbLDoq8WNzOtgMwusGp4s3dDjx6ORhm0J9FYCpgMbhmwNk17uQq9XtyzyF6IMu0vYMun7mBTxTDc41UDkGuKyaL6YggCSLg62hFz8bDUpauGigruQLR9bJf4E2vQP1ahIWTNc/jpUAzPqe0/XytKvw2eIjmbenOAM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB7972.namprd12.prod.outlook.com
 (2603:10b6:8:14f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:47:38 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:47:38 +0000
Message-ID: <f089c9d1-39ff-418d-9fd6-b90b4be173ec@amd.com>
Date: Wed, 23 Sep 2026 17:47:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 5/5] drm/amdgpu: Fix NPA BO memory accounting stats
 during import invalidation
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
 <20260923212515.1420047-5-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260923212515.1420047-5-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: f90a5a79-408f-44ce-c08d-08df19bc48ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P/AHExk4C5bTfB+PuWbBOU2/ZsxrjLpL6/XZX0Wvhk/USjLirr05Y4TeNRQXQ7C2mhNhGMsIOCxgKKN5BWFMjl8gGo8XQe8Pk4nBBiL6/186s5tVwpyJZbzidSrKHvKmEtjei5g3PjvMcDzVUjv8Rz+fsg4LpR3C+E5weVgHOawwzNAPcaI7bU5jo04dLi6w4ycRb4jCtRomDKYkz5ZX/mRiy3IJRdRviCrapD7NzxGocfr1TGVKepaKlHxNyo7F0r/iZnop1TUNaD4lxujGNLr9hCnEo/eMGMHodvpZoDd66oXmCzbEjs8WFhGnO1L97LpKvmxFr3vuj7yHW5tyMjPBvmu1mfrz4vt5v6YHLqciwcTMEe+CSmyDvxu+u6nbNfhpqKAVY68WlqZKmnB0PMEMEzFxCNKVeUtybVDdgTnJ4DtvDY01TIdlM6B4/VYr0YJWTMGTu5YjYniFu/k0y1CY1n+ZFkXjE0OdM85NDk6sTuiHsPL9e8QXqIrCbjiSyAlFOfR6DdOJILPKrBuHdpktAKGpjBcniun2nye7c8Izw/mjOZyB8UaGrFP8AbJPUZNpDa725YiVKaoDWR5UNa7olvZ9Nz7A1KNN/JHe98/OYNnEPO1rf8BihirByPZ19mPCZ6MMMGKEsSVYDfrnLttQgrTG6XV6CrahORsig+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFWcjNRL1hHdnRBaVAraXJjM1lQek5NN1dxZzNXdW1UdmE1MmdScmZKYVN5?=
 =?utf-8?B?RkR6NWxYVTk3dWJMeXllQStPQzRmSW5rQURtR0k4UHVHN3R4TmtKQTdUUDBJ?=
 =?utf-8?B?dFdjaWlOZlNLamZnelNOOEFXTmFuZ1c0Q2pueVAvQmsvalRPZ2x6a3VIellM?=
 =?utf-8?B?dldtQkNlWGpna0JvMWRxbHJoWnVieWpEbThKRjJRZHFQQkVBWXZERU92NVdQ?=
 =?utf-8?B?STZuSmtKY0pyYzh2M1ZIczJmSkRObzlSYjdSWUhpOHpzSnllYmg0ZGlralAw?=
 =?utf-8?B?TDczVGQ5QVlZcmZFd2tPUzlqYkZDQkhYVWJhY0ZzOHNHUnVaeFovcEFTakJk?=
 =?utf-8?B?NHRHMHhCdWVwcFBQeDRjM3BTUG51UnZSS2UyZ3NzZjg2cE8zcnMwQzBCWFJU?=
 =?utf-8?B?VDg1YUlnVUhEWm5EaGtveGpib1loR2pNN3BqYVZNK0wyN0RyZGVIOGhuNGZV?=
 =?utf-8?B?L1hrZkRHaFRVM25XL1FORHlTZVRJSTRVcnZpR2o0dkpEQzRCcWRNVmtITC9T?=
 =?utf-8?B?L2NiYW51ZTEycHEvb2t1OWFPY0JCdld4TEY5YkNxNGdGVGpzM3VodnFydHAz?=
 =?utf-8?B?blBSRHJyZlgvRzFnV1hHUU5qeXFoaGUzTW1kblI2bVI2SnVMQXNvanpBMWcz?=
 =?utf-8?B?SUphRHFZd3l5R1R6dFRQN04vcjROR2swN014dzlCeThqcVNOaXdHTVlkOTBT?=
 =?utf-8?B?TjVYQVpPTS9RZUU3c3BqU2VVZlVVa29tVk1abnpvM2ZkcFdXK09iTEtyWHda?=
 =?utf-8?B?THliR3RCT2J2QWorS1BHMVZxWldVNUtDVDFKbTFRMjZPbnFHUkNjZ3NUSytR?=
 =?utf-8?B?UTFCYWJUWTREYXhRYUZGcDI5Q3Y4Z3ZiNDJ4Q0h4Z1RqbXg4RW0zZG1HS1Y0?=
 =?utf-8?B?b1g5MWJEUHdQNHQ4eWp4TkpIM0Y3ZWhESEVlT2Nad2h3U3hDUHBPNDJwdERz?=
 =?utf-8?B?YnU1aEFXekl4YXpITjJPR2QyU2NraHNmR294RWE2UmZMOUVHOFRLSm5LSWhz?=
 =?utf-8?B?WFVDZHdnNUFYZGJIMEZsYkkwZnZpS01JdDI5TkE3M3NLVzhTR05yaXJGSkFQ?=
 =?utf-8?B?SzI0YkJ4T004bHY3NUFtS25GNXFicGNkRGFzd1FpWDYrckdDcFJra21pQUV3?=
 =?utf-8?B?Vk9VakovM0N1ekxsYi9UOFZWZ1h6aFUzRjR3U2d3bkVEQ1hUQkxaaDhNOGR0?=
 =?utf-8?B?MFU4aTRKRkRlNjNudU5Fd3c3Znk0ZlIzR0lTRnpXQkUxVnAyMU1vMmRqUk4v?=
 =?utf-8?B?Yk4rYjQyTUVNOHowNUU0TkR5a2d5ZG16ZWxLSUQ5SEFFNmpPSktLejYyYjBu?=
 =?utf-8?B?TUhhdElXS1Z0N09QU29wL1VlUEtzUk9Nb1RpSEFsTElGcCt4OUpLVUVuckNx?=
 =?utf-8?B?RnUxUjBhUHM3SVBHUGVWRktXWVprNGNVQng1eVA0QmhNcEliTzFkTk9yNHhy?=
 =?utf-8?B?a0tOOHpnOHg2eVBSVDVLRVBQRnBRVDMwT2o0Z3plL3BETGNyMm8vZXl3TTUy?=
 =?utf-8?B?MWord0FJNnBPVFNla3dmYU1xM3FwR21GQmhNU0NOeG1nZFJqWEVFazNuWnBY?=
 =?utf-8?B?Ukh3eEtCR0R3RytBaWJDeXRqMVZwdjZOOE12VEYxUjhMSkFWazhjV3J3YVpV?=
 =?utf-8?B?NHhJY3BrN254MlVsN1U5T2VYOEtwZWVnaG5qSVp1UHhoTEpNLzM5bE1yMUh4?=
 =?utf-8?B?RmV3bjh4Z1I4aWRzYkNvQ2hXNnNEZlhuTVZFUEdzN085MndVaTM3S21xeTF2?=
 =?utf-8?B?dEJOckgxUUVEVzk0VjY4RzRaK1UxRnBENVdFdWhUd2E5Y1NpMTMySXNMS1Vy?=
 =?utf-8?B?WjZYWEJJNnVxRUkyaFhqNUhwcTJHa09SdjE3MllEMFpXZTNWQmRZVVhDdEhv?=
 =?utf-8?B?WVhnZDlDYWNhUVBET1ZFcUltekowNm1KeFFmQXIxdmp3TmxIa2dzOGZkM0FG?=
 =?utf-8?B?QU5Nd2VXSmhYam1CZEpiUlNZUS9JbzVOWHpYRjZqNDU1Z3F3endUZTExb0lP?=
 =?utf-8?B?c0Fxbjd6bnE5azhnSkJOcGUxRVlVN2pHNnVneDd4SXZQd0VLclI1NWNOMTd0?=
 =?utf-8?B?SDh6ckg4QVdVUmNnbVZWMUFwZm8zSXMwSEp5VVA0ZW5UdlNkNHNlVzRQaWRH?=
 =?utf-8?B?RVdoQXdIWDA3cS9DTFYrbWJRYWNxOUV3Z0ZRTjdWSVJLLzMzcGdpQ29YN1lZ?=
 =?utf-8?B?Qjg5MHpYVE9MbDBrVDYybUdyNEduUVZFVHFrdUtQZEdHbE1PUWkvcE9pZ3Rr?=
 =?utf-8?B?dVp0WlBnbERnYUluUTRCUEh0MlArSXltYUl4WDA5WlRWYnpOQVlGYXYxVFBH?=
 =?utf-8?Q?oMM7VFdH+cJTNE2SZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90a5a79-408f-44ce-c08d-08df19bc48ff
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:47:38.0073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsGYa8dZUrpOMd9RzFcNEqeJD+B4gKlkR3x8gE9NJ1vmd/PedOMbCLxe8bfXc9FEu9Nu6xNwcimbhNo1ZpnbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

On 2026-09-23 17:20, Mukul Joshi wrote:
> Use amdgpu_vm_bo_move() for updating the NPA BO memory accounting stats
> when the NPA BO is moved out from NPA domain into an empty placement.
> Without this, when the app finishes, it spits out a warning:
> "VM memory stats for proc .. task .. is non-zero when fini"
>
> This was only affecting the memory accounting stats, we were not leaking
> any memory here.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - New change added.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index f6ad64be4349..8fed28dc7502 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3056,12 +3056,7 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
>   		}
>   	}
>   
> -	/* FIXME: This should be after the "if", but needs a fix to make sure
> -	 * DMABuf imports are initialized in the right VM list.
> -	 */
> -	amdgpu_vm_bo_invalidate(bo, false);
> -	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
> -		goto fini;
> +	amdgpu_vm_bo_move(bo, NULL, false);
>   
>   	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
>   	if (r) {
