Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9149DD0BB70
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 08:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3957C10E0DD;
	Thu, 24 Oct 2024 08:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeTDGtZY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CD910E0DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 08:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDZC7LJotnE/GxiadollAHyxWNvrKTHsY5ZlsJkNKpsX9D14eiqPlnIvFxEcaMrQU1c7K5HKQ5tLOQo+VRwi+ZXvylyhJX5cd7ATvk56YGAhmPjdsMTx/I6VhVhmU/rw8VTNF+OiLJPOmMvLp9AvbZl0yqCj4A/qUAw5CdcZB3AXPD/wztXiDX79/my6P/bOm/p4Mi9YOYJoJLUPEema1vHbfDDuak2DcB+J3EHOzh+u6GvvvBwNR8dsSWT7BJmNH/gKMsFsizn1GOEG/0w3xQB24FzZEtdEth6WMCOL8GxfzbYjb8iXm2y/Xn1IRqqqNB5B796u5XgSydVkLK2CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHJcpMXaj0LdvbafuNunfqQ+hsQnyh28Ky4wIaF4Yho=;
 b=Jsx1LluJe7p4X+jDdhPsDaJA9H16wdzosAR2Hr4rlSucxlCnaisfotGfUL5JBBkM+PzOslyL3arv/B3CKOsi00MVor5MKJNXlfr5hqJ8DoanTloXTQv2pnEqrxdf0mX4WirDhZCUf13yhpbYBLTv15tGMgh0hq4oFs4QzAANEh1QDMn7ACcj5x6v8kFN7IuusRbsbEgNwtwdDCBMmhyV9n+pbIdiw89DKeR8K9QItHl3YuZ0S+rjsvCzU3xcolj5Ayba4wkDXS/fNltI/Xz8lgET7x14lIyl4Y5N49DtDNpVPhHmDutpDa1bNIRJyNUwyYzVO4I9XrIlV8w3WmS91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHJcpMXaj0LdvbafuNunfqQ+hsQnyh28Ky4wIaF4Yho=;
 b=qeTDGtZYXFMKZGqAyDJdLsSS+26aeGtJy7Un4JCfgsSGv/6XhwLj/y1oEkCSEBkjQVjPSIBS8Tn5i0JWAr+32g9St/q3Ac741qocK0QmcNCgndtBYGx5OKNMGLeoBDnq0KBpHsCkQw+ThVUb5e8IrCS5B3ami54Wfzf2VOTXfcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 08:40:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 08:40:15 +0000
Message-ID: <5eb496bc-f0dd-40eb-8eb1-3b97771384d5@amd.com>
Date: Thu, 24 Oct 2024 14:10:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241024082159.45701-1-Prike.Liang@amd.com>
 <20241024082159.45701-2-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241024082159.45701-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b77238-012a-44cc-8201-08dcf4077a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUowVVZxMzNWZjJaV05aN1FBYkZSbmFEV0VVOTZlaml3ZDkxdnVWRm5rUHBi?=
 =?utf-8?B?NkVUSENzOWNpbloxTWxoWXZ3RWZsOWpGZmZVQW1HM3QrdC9rVVNCZWRaQWNR?=
 =?utf-8?B?SjJNNGFmYkNGVHc0eXNvTk1UZXFZSEhtY0crZ2JLeDlTNTBrUEFRd0t0dUp3?=
 =?utf-8?B?UkhiM0ZibUswWFQxRG5GOEV6ZGh5dGcrSlViUTBtYmswaGxadzhMcytzKzRx?=
 =?utf-8?B?dmNvejlKMFhteTVWeUpPN3VOalNLR0wyd0haWTYwcDNTTFpjRDgyVEdOQlJ5?=
 =?utf-8?B?OVN4S3FLQTJlcTNhT004byszV21TaEFBR0JNTVhmdGt6QVk3dXZQY29kN2s3?=
 =?utf-8?B?NExhTmJvakxneWY3ZXpxditra01NN0gxN1Q0MmdOK0JDN2tYdDQxL1hFeDRB?=
 =?utf-8?B?anVySnpFSWVFR2tHUXB3L3I1RWkxVU53Wks0TnFkOExGM241ZGpGYTJXYnhn?=
 =?utf-8?B?Y2FMU1dJcmpYT1ZxTE0ycHpqVG5xNlVjTEQ2N2dETERRTko5MmlKTW1MamFy?=
 =?utf-8?B?cUJOVFdVSTBUL3ZwZys5dGNoL2J4L09HUlV4SkxZT0d6YVJCQkRsQWI5TXZo?=
 =?utf-8?B?ZEZUUDBNWU90U1FkbUgxYksrYWtNNFRKbDZGN0d2VFJsTEJraFIycnorcTFj?=
 =?utf-8?B?MjU1TUxYU3FhZzdXeDI3Z01UK2lLQlU1ZGtkbVVMMzJYQ1I1Mzc3a0MwaW00?=
 =?utf-8?B?TUFJTXk5TVJKTU9SaUFHQXhrbWVITjMrMEMxcFd3TXRHRW9xUEx2NUNaYUk3?=
 =?utf-8?B?VThXSUFrKzhjcXJBQW0wSUZnOFlMWHFrQ00rT2ZHcjRLdnBwTHdUandCU3J0?=
 =?utf-8?B?OCt3TU1Xckl2MXRmQUdia3lsNkNiandKV2FaNkhJdWVLb0czV2RHQjB3SWdu?=
 =?utf-8?B?R2JydHE5WWFjZ3JPdzdMVHZ4RWlxNzNIYlZxNXp2eXhWcEVKbGV2N2EzSTJC?=
 =?utf-8?B?MDhWaFZGa0lsT0N4Mm4vd1NFc3NnLzFNMy93a1lIL1loWEpYWnBRSTA0RDEx?=
 =?utf-8?B?MU9UU3I5Q2xkbXJ1Lzl5SXdiL0ZLL21pN3hKZm9CMU4wQVZsaXE2N0NEbGZN?=
 =?utf-8?B?UnNHRzRpSVpYR1pIaDBPRDR6N0VrTUlNRVAySkFqUWozRnl2a2ZMTWhEcEQ3?=
 =?utf-8?B?V1IybnRoYzNpM3VuM0ZXM3pVbjNTV0ZVYXc2Y3RLMFhkZG9qdVArYXNucTho?=
 =?utf-8?B?cGZLT2hCQ0FOalBYbTFMOFRQb3BGL2FqUm41MXQyWVpXTU5LS2l1ZElrSXVm?=
 =?utf-8?B?MC9jR3FmazNCd1NBbk4wME5hWWR1TnZaVlBFTjJUbEtwSnl6NEdsdnhXeHA4?=
 =?utf-8?B?alF0bkhkTC8zUVJ6TE16emhSZlhwTEh2NitiMUZ0OXlxUXhoRTBEYUpISGpF?=
 =?utf-8?B?NzQxYlR5d2hRa01qays2RndNMlVwaDAyWnErak9hU2g2VmM0Wm9uYXhrNG5Y?=
 =?utf-8?B?d0w0V2tzQVMzcDhEd3FMZDgwQ0Fkei9yWGlvR2dxMzVzZFJ2MXY1K044U0NW?=
 =?utf-8?B?dXZBQzhQSGZnZ21VY0Q0a3FLcW15Ym81NFZNVHA2akpkRUp1TUxMZHVTWnI4?=
 =?utf-8?B?aEx4YUJudEQvVDZ1VUYwSGZsYWovVjhnSXgrWmlTWnpnbmpKWld6YnVyZVpK?=
 =?utf-8?B?RjMyYVJiWlBwYkw3aGZOTE5Wa2tHQ05VSy83TU1IZUxVb0dXL2tHTHgvR0Ey?=
 =?utf-8?B?M0F2M2JzODFabzNlaDdjTGdBM3Zwb0RoazZEcVNibkd0bUM4OURhaEZkNERN?=
 =?utf-8?Q?z9Nvb9eOTue6Nf0ipsO8jLIXWmRPLGZixTSNzFp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERPd1c4L0tjR3ZuaVBFbmRub0tEbFZJNkl1YkZHVVNJT1dPY09WYzdVQ3Nv?=
 =?utf-8?B?M1U1SFB6SDJNZzdhWm9UVzVyZGREMkxEZ0gyRlQrSkNkeitnWE0wRDgxYkEx?=
 =?utf-8?B?WVppWlJnVDQ1aEdDaE92SzlIRzlLVHp6N3pWR05wVnFDRkdMWGE5bkZzalR1?=
 =?utf-8?B?M2FQMnVWWjljR1VyNEJoS0VvUFpmWGpaOWtESFFWVk9kellrbWV6QTM3bmE3?=
 =?utf-8?B?NlhEOGdoajduOEtPU0VHN0lwRjhQSngvYXlMUy9QUHJ5Y05HYlQ4UHRIeGJH?=
 =?utf-8?B?VklKbWtzWm1JbDMrSzlRa2puV1QwMUxCT3FlSFNVRjdsWW1PTlZWK1hKcVU3?=
 =?utf-8?B?OU5jby9udFR6RU5DK25ocmVDNXRLMXpsUlA2aEQrcDZNL2l3SDYyZ2dTUDdr?=
 =?utf-8?B?VDNwWTVBWTc4bEs5MDJPZkQxL29xODQxMkoveldUVS9MbkFpQlNWN1M1NzdV?=
 =?utf-8?B?OWpCSDIvS1RZU3hpVGxIbldZdUQzYUErNGV6czlXVUNOYzd0WUZveU9kam11?=
 =?utf-8?B?MlNjZmhuQVU1b3ZFeGlNeGNTU1BYbmVCUUlUeFI5VXVBY1hWOXRSQkZmOHlO?=
 =?utf-8?B?SUdVaFd6Y2g5LzVxYUszdWxHMHhLY3hXYmc0UWFkR1JXbnlERS9QdGsrcjJm?=
 =?utf-8?B?SkRXQnpyMHA2SkFRdnVvKzYrRHB6VTEyWWhNK0RvOUNveWxHZy94b1hvNjY4?=
 =?utf-8?B?U1E3bE4rTm5KYy9TWW9Cd1pmRjBsL0JFcXEvUmNOSEErZ1ZmWUhGTy9QVWlP?=
 =?utf-8?B?elJZMEUwRWJwV2FiSUV2NmE1akRzMDFqTWJJWmp4ZmNVQndSZzlCNGtJTTBB?=
 =?utf-8?B?UWFnNHg0c0hYV2l5ZjJjSHRncHJPQzJ4VDlKVlFWYXNXNEVwNk41YzNBMHc5?=
 =?utf-8?B?alo3OG5BNVhvWlYyUDJqdlJrcUNoSnVCY1g4TGNHVWVVVEx2ZmtmNk8veUpo?=
 =?utf-8?B?TmhnZU1NSHpWYkE3ek1MYWR1SUlncDBUWVIrKzdBc3hBcjN5TlU5cGlGd1pG?=
 =?utf-8?B?cDBrdmRlUGk3Z1F0dHZyUFo0bndYK3kzaEkyWUs0Qi8wYnhIb3JFMGlPOGkr?=
 =?utf-8?B?YXlydzRJbmp1RjBKNVZENGtIRTZFc0FqaHVMdnpNeDRndC9yR2wrVUlMc0Nh?=
 =?utf-8?B?aHJQbjk5ZzVZQ3BsUlRpSCt6WGtIRmp3elBPNldPelAvRkxwS216ZWdUMDBi?=
 =?utf-8?B?QXV0VGR2ZzRpbUVhMTl5dFcvbHBoQjI5M1AvQ0ZNK3VYMGpKSnFPYldESERQ?=
 =?utf-8?B?cUZPRzUwbmhNVnBGNk8zOGhBbEpYd3h1SEkrVG5FRDI2VVhyT1JneWdoL21U?=
 =?utf-8?B?U1UwWkh0RGVEMWpUU2V0VFBCd1Vpdm55N203UFE4b2lEa2hWUHBQc2FPaSs4?=
 =?utf-8?B?UXZQalgzaGZPQ01RaU9uako3dFdnVHlTb01XSHhoSGFtUnNXUUIwOGhiNUZX?=
 =?utf-8?B?YWowb0RRWVFBNmFvbko2TUhxNVJHeFZoNWNES1Vpb0hKaXdlSlBxTVNtQUh6?=
 =?utf-8?B?VDhzR0tpUWFoWWtYTzZJMVdlKzFISDNxTTJtSmNkbUoySTJ1TmNOV2tIb3p3?=
 =?utf-8?B?d3ZnSVREdG9iQVF0bmNXLzQ4ZFZKYjYzTHk4T0IwSDk5TzRGbnAvbHNKejYw?=
 =?utf-8?B?ZGlocFpmU3VMSWw5TDNoUGF5a3N3MXloMDE0eGE3enhjQ1pBY1MrbnpSUU5O?=
 =?utf-8?B?ZFRyWkVEdjdvSnRCZUtoVEV3cjhpRmNlL3IrQWhzbDZwZE5nSXNiMDhOR2U5?=
 =?utf-8?B?WThSQVEyc1lpMlllY0ZqaWhLOEhXODFwR3RQb2NKMnBZL1prb3U0NG9YTXk0?=
 =?utf-8?B?bnRRS1FJSmlOM3ErYitoSVkySVhrRkFyZVV6S0w1a0pYWW5MUDBmZU9GOWtr?=
 =?utf-8?B?RTk5Y2RlYkJ6dTJjcmlENWxtZUVaTHRkYi80UEpWaFdoNGFOa3FZNXVxd0ZT?=
 =?utf-8?B?MXlOeDB6RkZkVk9wTnhDUklMZTQwTzFyU3A2c2N5V0oyd0tjUG5jdG8xY2s3?=
 =?utf-8?B?bFVHNkVDMHIvZU9paElrY2xxbURFa0pXdzRMZVRRbUx2azJxQ1V3TUI5azJh?=
 =?utf-8?B?ZVRBdmFjZHdobWd4YSt4aUtvWk1LSmpXOW9rRGFTYjE2QnAxaHJ1VUtEUkVG?=
 =?utf-8?Q?0JOCAc0qF4WTCdPEnxuCM8yhp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b77238-012a-44cc-8201-08dcf4077a4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:40:15.1603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+8POHrq35QHXtB2OTlS0WtMaMsYQVMh4Ty9fcJV7FjZFGOnxvk7MTuhXjZDBwbY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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



On 10/24/2024 1:51 PM, Prike Liang wrote:
> To check the status of S3 suspend completion,
> use the PM core pm_suspend_global_flags bit(1)
> to detect S3 abort events. Therefore, clean up
> the AMDGPU driver's private flag suspend_complete.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 --
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c      |  7 ++-----
>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 16 ++++++----------
>  5 files changed, 10 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..9b35763ae0a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>  	bool				in_s3;
>  	bool				in_s4;
>  	bool				in_s0ix;
> -	/* indicate amdgpu suspension status */
> -	bool				suspend_complete;
>  
>  	enum pp_mp1_state               mp1_state;
>  	struct amdgpu_doorbell_index doorbell_index;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 680e44fdee6e..78972151b970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  
> -	adev->suspend_complete = false;
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix = true;
>  	else if (amdgpu_acpi_is_s3_active(adev))
> @@ -2516,7 +2515,6 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>  
> -	adev->suspend_complete = true;
>  	if (amdgpu_acpi_should_gpu_reset(adev))
>  		return amdgpu_asic_reset(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..6ffcee3008ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
>  	 * confirmed that the APU gfx10/gfx11 needn't such update.
>  	 */
>  	if (adev->flags & AMD_IS_APU &&
> -			adev->in_s3 && !adev->suspend_complete) {
> -		DRM_INFO(" Will skip the CSB packet resubmit\n");
> +			adev->in_s3 && !pm_resume_via_firmware()) {
> +		DRM_INFO("Will skip the CSB packet resubmit\n");
>  		return 0;
>  	}
>  	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 12ff6cf568dc..d9d11131a744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>  	 *    performing pm core test.
>  	 */
>  	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -			!pm_resume_via_firmware()) {
> -		adev->suspend_complete = false;
> +			!pm_resume_via_firmware())
>  		return true;
> -	} else {
> -		adev->suspend_complete = true;
> +	else
>  		return false;
> -	}
>  }
>  
>  static int soc15_asic_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index c4b950e75133..8d5844d7a10f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -897,22 +897,18 @@ static int soc21_common_suspend(struct amdgpu_ip_block *ip_block)
>  
>  static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
>  {
> -	u32 sol_reg1, sol_reg2;
> +	u32 sol_reg;
>  
>  	/* Will reset for the following suspend abort cases.
>  	 * 1) Only reset dGPU side.
>  	 * 2) S3 suspend got aborted and TOS is active.
>  	 */
> -	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
> -	    !adev->suspend_complete) {
> -		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
> -		msleep(100);
> -		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
> -
> -		return (sol_reg1 != sol_reg2);
> -	}
>  
> -	return false;
> +	sol_reg = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);

Actually, two samples are taken intentionally to make sure that FW is
not hung before deciding on reset.

Thanks,
Lijo

> +	if (!(adev->flags & AMD_IS_APU) && sol_reg)
> +		return true;
> +	else
> +		return false;
>  }
>  
>  static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
