Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78535E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 09:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04A010E3E5;
	Thu,  2 Jan 2025 09:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHCNnbBS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03A310E3E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 09:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqlDE/fiNdRnt4BM+smqlCcvKbfn+nkG+RUkaTiKFropg4trXeSQUSp36RNDrcvHT30mOpCZYEqbZJDGQW3qLwZaiLYXfGWX50bJ6YzGoh0Drl99Vxjya0EFM3Z+Hi4JZIOSzEDhwQ8BZBL2pFlMc0QsBXCWahFf3WgoBD2CIaHF2Fj7UI1UN2SILQ31O1U1PChD67xCKOP6AGbLR2vGxvJ13beKJ+nkFWts01R0W/J8jjT8NTzaJqIv3QP0Xu5DtdFjR/RAjM18DKyA4d0oKjnVZRP5T7aSmg0aHqqWik2CatUz1P8Dau1jpH1O3s6Efp+2c5at0AJG9lhXOvTXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKNXG9snpZZhoWqPuefpdqVq0H4Eej/zLH25ca/HlfQ=;
 b=W5PuOdllFLt1vernE/3E3urJVsuqoHiZAyiLFnwZMgG1K/DJUPBvtCVPfWTHkjr2uRi5oBScNfLFK0yUif4x5bu+mmsNJ0gWS0R8GX0rxVjo0pzaCZlsHZNXMXnSrlVjmSfSfB0zsc0X1/RvxxxbpfNYRDDsgNeQQ/Lz/zBotJ1qKVcj+zdSY+TXG6vmNyyhjoFoUEwQMwMEaHJs8Lg6NnzxN9nNEg+RawXVe7FclyC6xhNBUDwB60pEWhLdtKZMONck57jTL012H07eB1wtWBTa+161K39ztJNH7D7QHvLkhV18jb5kZUc8WdjLltFpwgxoEuBKwVGJpyxbOXCvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKNXG9snpZZhoWqPuefpdqVq0H4Eej/zLH25ca/HlfQ=;
 b=pHCNnbBSNVJF2xV/yuN6ZQMln6pvpnRoJypWnpIxQ1fEJnjmwJiXmaBXtLKnWMHwRzEUPC/JXP7K4k6WEum+Ib4IrQlBkv/gFapgYP5Wa9auiE2g4ezUpcDDIT7W39pSvfnA9iewcIqBC4LCSmDSeuh0bLrtgV7cUJZOuJiHNdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.14; Thu, 2 Jan 2025 09:31:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 09:31:59 +0000
Message-ID: <fe6027cf-1618-49fe-9907-a54ba74d8e07@amd.com>
Date: Thu, 2 Jan 2025 15:01:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reduce RLC safe mode request for gfx clock
 gating
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241224061609.1207220-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241224061609.1207220-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5216163c-bd5a-4849-71e9-08dd2b104e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFI2WFpiUzJNRFBSM1MybmswMEFMem5OOW55c0djNnpFalowaG9EV2F0N2wx?=
 =?utf-8?B?QTJ6Vm9sZ2dHajVvY1lOckJ1L1daVlVUTytFSHo1RDAwcVFjeTVRSG9YWG1y?=
 =?utf-8?B?OFEvRWdxZmlqVWtjSHcySmlJSzFKeldIT1Y3T0pReFpWNzRPYUhIY0JhL3pZ?=
 =?utf-8?B?VHZJOEhnMGNjckVMQTZrTnhXbHpOc3dpaGNhRkxyTVI0aGFmSG9hSjhyc3RU?=
 =?utf-8?B?NUFWeXRkOGtoeWNBTTNHejNLVnV5M0hPaDlqRytNN05Ka2IzZUNBSHhVcW9l?=
 =?utf-8?B?K04rNDZIREZMRVJRcFhHdDNiMjFteEVtd0lvdU9jdXlzdEZ6NFEvMWN3cXk4?=
 =?utf-8?B?Q1NOeXR2Q05xeXBXR25LeWpMNDgyWlBPN293YlVoUGtzL0JlS3JDRkRtbzRJ?=
 =?utf-8?B?Nk11NnNkbDdvcUduMS9kTldVMkE4RmFyOHlPN1lJaVU0TVFhSjJhQ1lHcUJS?=
 =?utf-8?B?Z3I3UndxaXJlZHJubXZVenJ2NGtCQU9rUVQ5ZmVJSFlteldPa0o3QWg2Z0Fs?=
 =?utf-8?B?WE0xdTdOQURIU3NSUFFXMjltMW0xS1VDUTlQdUgvT2JlRTFuNVdYT0E0SThE?=
 =?utf-8?B?OXkwa2dMZ2ZZNSs4ZVhlUmxzQWg2RGs2Q1lYRVgrbW4rS2JVWHdlcUhLbG9n?=
 =?utf-8?B?ZjFmL0FJd3BjR1RlTmY1TUVCOHg0UnJsTnlBb3V3aFR4N0hrMm5zSThZaWlL?=
 =?utf-8?B?ckE3M1p1c2xZczQyRHp5d0lnbGdobEtkMy9pR2pYWGZrb3AwSTQ1V2JuT2Qr?=
 =?utf-8?B?eUFXM1hUWUxrdEI1TDlQdjNobDNsckE3cjUxTDlHeFpHOHNqWk9hOGVwSVpz?=
 =?utf-8?B?dzd4Z09tTk1OaTNkMmd3MWVtdUVncUdtTTh0YUlDNUd4dFkvQWt6TzNkSEhv?=
 =?utf-8?B?Q0llMDllQnAvbEZKZ0pTaUpPTlJhMm5oUnJROXBHMTFjU2lDbU1DNFc5OHph?=
 =?utf-8?B?RnpLVkYvKzJNQkthVEFwbzN0b3ZkZURvK3M0ZlB2K1lmMUlrOUZvRllhQ0pY?=
 =?utf-8?B?N3c5akZuYlNQMWdvMmo0M0dsblRKTnIrd09IYUdIdnlZRHllWGxGVGpUbHpm?=
 =?utf-8?B?dVRhNzdqai84ZDBVL2VDYjJtVHZRMkg5Wk5OTUhnSncva2pWbWt4aEtkUmJl?=
 =?utf-8?B?M0xmNDg4K0JGRGo5STVwb1hvRXVDeGFNQytqMHQrK21GblpmN1Y2UkxRT0Zl?=
 =?utf-8?B?d2J3YWoxUll3NWEzalJvTUN3dk1zR0x0T1BmZnZ3ZjU5NkczN25RWWd4cS9X?=
 =?utf-8?B?Y2RJOHpPVmZzWktWREdkSWc0OGNNdlhDNFdTNjdxU2hqamt3anVaU0VueDdE?=
 =?utf-8?B?SEh6d3Nwa25aZ3dCTEhDZ00zUk14S2NMU0wrT1ZPN201YXErSnV3NHI1TWd2?=
 =?utf-8?B?MHdLcE5UZmI0Qkl5WmFWbW5jTFdjUW9XZk03RFlISTd6NmZmeUIvdFJ4R0hQ?=
 =?utf-8?B?U0RyVWtJdzZEZ2xIeERMaWhWemVqWVlwcWNycm9DS2l5Vlh0cUxsM0ZwVlRk?=
 =?utf-8?B?NkJzcUtqYlRaVis3bEZkRnJ5eHBmUUFSUjEyZW5VNm5neVNTdDZvVUErTTMw?=
 =?utf-8?B?bnJzZ2JYa1dWOUtUUkJSb2lMdkFPUWVyY3o0WlRETVhyWTRmRTk3ZzRqZ0Q1?=
 =?utf-8?B?V1U5cHV4MElXaUZpQU5zTFRkWk9Ha3ZkZ1hRM1Y0UVpUZnQwNkprVjBzYTFr?=
 =?utf-8?B?RTdYQytNWTlYL0NldjdTa0cwSlZ2d09WRm82VE1uYU1DSzJuaHhMVnlTeFFk?=
 =?utf-8?B?c0xvMTVUQ2syQlZnYnpGVkFicEQ0MGlVZzRFL0tGckhENjYzNmZrRE1nR282?=
 =?utf-8?B?aHM0dXRIK1VBM1RsaUtaQlFraHhFeW9SbmRoc0ZyNS80eDhUSTcrMFRPWDc1?=
 =?utf-8?Q?dnHFFxz6sGwy4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZQaXNpWCtzSzU4T0dQWlNjN1AvS25SMGVqM2dNVlpDUUJzWnNSUmhpa0No?=
 =?utf-8?B?S0tvdVZockFPdERTZGkzcklJb3hrczRYdTZSM1R1WmlxZDE1ZnVvUWpJcm9M?=
 =?utf-8?B?Q3UvRkxMSVRvVThPOGd5amR6UGQyanpQcGxwdUwzczY5eXNwOUh0cTdkVG05?=
 =?utf-8?B?U3NKd0RVb2lxUmt2UFpWWkh1bnJ4b3dEcWRmZy8zQmpNTnZJUGNKb0FHSHdm?=
 =?utf-8?B?NXJ4aXlySzU2K1Q3anRoSHhKRkFxeFQ2UU9IZVBSUWkrTTExQkg2ZG9ZNXdR?=
 =?utf-8?B?OWNBNmZqd2hJRHJpNnArdEVQRzlCdWk1VGRpOEJLSUJ2TnVVOGRwVUI5VE9B?=
 =?utf-8?B?d243dDlrNDl3ZlNXUmF2ZzRMQ3JWT2hJWTlCc0kyNndBWURtaDdDTWM3WEZo?=
 =?utf-8?B?c1gvYzJTK09FVEdsSFhOamdSQ3FUVi9wbjF3akZ0cWc2czF4OGt4UjB0bEUx?=
 =?utf-8?B?djNLUWRpNHJ0UUVEZTlBKy9ia3RycUpzWkJxaE1HckNPT0VIV1lzRzczRTVl?=
 =?utf-8?B?MENlZEM0N09WY3o5MmlRWkNZZmF5WElucCtZOEw2OVpSbWxDbHc1TkJ6QnJB?=
 =?utf-8?B?aTd3ajBrRkhXTW0zZjYraUNPU29PTWFNTHlHT0JLYU5JZTNlTGV1N0E1L1gv?=
 =?utf-8?B?RFdSRjFFalpvWnBLSTRNVkUwdWIxRkhMVUtwU0Vpc3FGbEpVUnhKWWVTd0Uw?=
 =?utf-8?B?a0VvT2NPK0pLS3Q1bktJbEpuUWY5akNTeWRBOUtwendLWGhBSythZUhzRlk3?=
 =?utf-8?B?M081NkhpSitYM2ZMT1ROWnk1Qm5VUDZZaHRpZW1rWkFGQ0RCMmFMSVlpaFdH?=
 =?utf-8?B?bzVOZEZyWDRPWmkyREl6ZUJiYWxpYzZ6OXB2RVNoekswdkxlNFV5TzRrdVJB?=
 =?utf-8?B?RzdLZU83SU14VFM1R3E2Z2kvRkpaN0lZSC9tMWp0S3dhRE9iUTNWc1ZPbFpB?=
 =?utf-8?B?N3pPVk1YVzF2ektwSjI5RzdLNUtTV1RIdWJCemVVNkJQTGJnU1lGa2tvMkNR?=
 =?utf-8?B?MnZkTEY5SlNwY1RhL0luZGNtRHN5MjZGaTRSbFZHMmRUN240ZmZlK3N1WGZL?=
 =?utf-8?B?SmdTY2hjWDJGb1pOWm53VWxEanNXY1M5bkRlQXg2aFpIeGFpMm9abTNDeXFD?=
 =?utf-8?B?bmRnL0JoNG5yby9KVDJ1VzZybGFwSEM2UkI1WE4raEY1Tk82V0xZL2EwT2gy?=
 =?utf-8?B?MnBTNDlRdTVvempHVDZoa21ZN29ZZC9SK1VUTFAvZCtLa3pUYUtGRllrYTVU?=
 =?utf-8?B?UjEybGVKL3ZDaWJRZmhlaUQwamE5Z25sOTFMWERydHk3cnVDMi9ORUcrZlJK?=
 =?utf-8?B?SnVMUkZQcmZJemU4a1kzSStOVVNjZi91TFcyY0xCaUNqYzFESTJiMnk0TFlN?=
 =?utf-8?B?Qkh2UXJxSlZtY2FuaExRbkhXNm9XWjBWb3lYRDAxVS9UWDQ5UER2L0xqU3o0?=
 =?utf-8?B?akNVK2dpcFdPWEQwcFdXbFVadUY3Ri94QjhSZnpUZlYybXZCZktoaEdqcUpG?=
 =?utf-8?B?d3VCdUdDU0FYeENyVDhYRE0vRmJKN1NGWk1FK2tldXRXWkYvd09IejYwOFlV?=
 =?utf-8?B?Y0VDL1Jvd01pWGNoNGdHci8wWTRPekdFQURCdnltSDhMMDUvMHNCbWRQaENL?=
 =?utf-8?B?YTJZWVhDeGhldkxTRHVHMlBiMUJ3VFBCUzFXS1BQOFpMeVNucGlJU3ZDU1pG?=
 =?utf-8?B?SnIrNWNCcU90blQ3UkhBSjRyQzV1TlNRa0ZpL2NkblN1d2pIY3FhUW0veGlK?=
 =?utf-8?B?ZFVHbzZrdGh6d1puM1phMnR0bVRyT2M1cFhmMWU2Rm5WVWEzSXEvNVFCblRj?=
 =?utf-8?B?RWJtZHlLRVFhQzZEaC81YTYxN01Gd1hRQ3FsUjlXTklsOFQxeENpSGdNTVVm?=
 =?utf-8?B?bkNNaGYrdUt3dTd1cUgvMFdlcTlROTVGZnY4Zjc2TGhtZkI5VUx5Y2s0OXlE?=
 =?utf-8?B?dFdPWDE5UTA0T2VsRFpKY3ZVTTJkKzFsRXlXcldWcUt4ZEo2aWt0WjAwUWto?=
 =?utf-8?B?RWZwcWpjZWhMdEtyQ2ZKdlN5UFZRQldyL2ZueWd2YWlMMERmYUM4cFJJZm9z?=
 =?utf-8?B?NXNuR3kwZHVKR1Frcks5TGUyUUFyOWhidGxzV1ErQ2Q2MERhZUxualJ3dkFm?=
 =?utf-8?Q?BEiCepE8jhaGhrGxgy06NIV1L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5216163c-bd5a-4849-71e9-08dd2b104e51
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 09:31:59.3531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1UehGQlFpCssSY3AoQKlTaG353PnI+VQZ9g4w258sbfYPbMmBK0SsYuFI1wsCIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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



On 12/24/2024 11:46 AM, Prike Liang wrote:
> The driver can only request one time for the power safe mode instead of
> polling and disabling the power feature each time prior to program the
> GFX clock gating control registers. This update will reduce the latency
> on the GFX clock gating entry.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 14 ++------------
>  2 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index af73f85527b7..6a025438f9d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5639,8 +5639,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  {
>  	uint32_t temp, data;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	/* It is disabled by HW by default */
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>  		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
> @@ -5734,8 +5732,6 @@ static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  		/* 7- wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
>  		gfx_v8_0_wait_for_rlc_serdes(adev);
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
> @@ -5745,8 +5741,6 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  
>  	temp = data = RREG32(mmRLC_CGCG_CGLS_CTRL);
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>  		temp1 = data1 =	RREG32(mmRLC_CGTT_MGCG_OVERRIDE);
>  		data1 &= ~RLC_CGTT_MGCG_OVERRIDE__CGCG_MASK;
> @@ -5827,12 +5821,12 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  	}
>  
>  	gfx_v8_0_wait_for_rlc_serdes(adev);
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  					    bool enable)
>  {
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +
>  	if (enable) {
>  		/* CGCG/CGLS should be enabled after MGCG/MGLS/TS(CG/LS)
>  		 * ===  MGCG + MGLS + TS(CG/LS) ===
> @@ -5846,6 +5840,8 @@ static int gfx_v8_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  		gfx_v8_0_update_coarse_grain_clock_gating(adev, enable);
>  		gfx_v8_0_update_medium_grain_clock_gating(adev, enable);
>  	}
> +
> +	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4b5006dc3d34..fa572b40989e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4964,8 +4964,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  {
>  	uint32_t data, def;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	/* It is disabled by HW by default */
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>  		/* 1 - RLC_CGTT_MGCG_OVERRIDE */
> @@ -5030,8 +5028,6 @@ static void gfx_v9_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
>  			WREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL, data);
>  		}
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> @@ -5042,8 +5038,6 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>  	if (!adev->gfx.num_gfx_rings)
>  		return;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	/* Enable 3D CGCG/CGLS */
>  	if (enable) {
>  		/* write cmd to clear cgcg/cgls ov */
> @@ -5085,8 +5079,6 @@ static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
>  		if (def != data)
>  			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D, data);
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
> @@ -5094,8 +5086,6 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  {
>  	uint32_t def, data;
>  
> -	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -
>  	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
>  		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
>  		/* unset CGCG override */
> @@ -5137,13 +5127,12 @@ static void gfx_v9_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
>  		if (def != data)
>  			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL, data);
>  	}
> -
> -	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  }
>  
>  static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  					    bool enable)
>  {
> +	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>  	if (enable) {
>  		/* CGCG/CGLS should be enabled after MGCG/MGLS
>  		 * ===  MGCG + MGLS ===
> @@ -5163,6 +5152,7 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  		/* ===  MGCG + MGLS === */
>  		gfx_v9_0_update_medium_grain_clock_gating(adev, enable);
>  	}
> +	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>  	return 0;
>  }
>  

