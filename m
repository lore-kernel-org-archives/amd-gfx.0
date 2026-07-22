Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33735C44536
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 18:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE0210EE95;
	Wed, 22 Jul 2026 18:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hTE0eMeU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4431610EE79
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 18:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmBkLt2kdKqqfZsNiXQ1lWa0G7+GjPQs27DsTO4w12Rvd0fmjCTcNCL5yiQAqf2x8ODfwtOr9xs1i3+Z6BzkUzelpIA9Q9wR5CpGfAoXPSWu/tLPzw4MV9/VuFdQayXRknmcThz2gUSUrmQ7QHc1WaYnegSTHaGD02e+jZEVCCw/MUyYJRyZSurplBgunAPBmgsIvd4ihdqw6tS6wgi8bwPKyrSFPR4qbaSP5qXCWVIIc4ZHh9cMLu6DAE7MusGiAeI9kpJqfrgEibQNoipe0YwCt7CJ++1qoBHzDaUyJlT4c/C2VU6esFEKpwy31IqEKXWZnmAQ4s+fOXQpJLz4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRIOJCKNC/VLmmp/pWczXzlOnvGhAaAIFn1+/EfTXAE=;
 b=chZcbyQDmd+t9INFaJ0S5+9momK+P026j1wl0y+o+K/nndVIREBvSczzJhYK12wYAI3mo0Bs/CvG46oJLnFkVej5wM7bsHC2+uVmk0e8LKZnzzPjnZIyqb2gK8No2cypQdKyTZ6/QodUR6F/4ut2CZBEKRPd3a8b2bhej7aylHWpKBPTle2Jzye0qtsadNU1/rGyAwFmhfPtSCg/jPbuY49RXLVwP45k5ZyyGdNTULRf3bISdBMNgM7LIkJ0zzSu1sZuHXOX3BxDBMMych8AolxW7cNNiuFmFbaBTgiYsgOumH0PU+NDWAcW0O8rl4NlluT7ADDoIctkHClg5My3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRIOJCKNC/VLmmp/pWczXzlOnvGhAaAIFn1+/EfTXAE=;
 b=hTE0eMeUN3FSqXV3FWjsMT2b2ttZVjpEkcRuLp8fw7TX0ETba9Jg4Iu90KJ7MKurl4FdMBA3O4TLCpOwKLWK/3ifL5+xSM4ASHmUyR/WCuNLNhn/Bje0XJIQ3fb66HuHl+880ahjflMeoJXnrb7ZQWutBvZDa9ffzIccdoKvKSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 18:27:29 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 18:27:29 +0000
Message-ID: <6a705b70-dc0d-42de-a18d-cbc1a4698f71@amd.com>
Date: Wed, 22 Jul 2026 12:27:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/amd/display: use a separate helper to
 translate degamma curves
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 Xaver Hugl <xaver.hugl@kde.org>, robert.mader@posteo.de,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260623160112.1636801-1-mwen@igalia.com>
 <20260623160112.1636801-4-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260623160112.1636801-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:8:55::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: d3069dfc-80dd-42e7-9a3d-08dee81ee2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: kNohDheXaQ0wrk6hAp3uqhOaiNJKqPnofV2d0oMua+ek9XT+W4zVzmoYcG1Ie3QlmJE6iiMM4D7MJ39QgiV5bvsyLpH4U2KLn6uRysPiZsBmbiEVBlbSAWqQyYvZoYKDriQuWuK35mMWB+DWNhxiDUM83kuWlMqvkcUtY1+svsyO4JnImwRXut9chLHp85yrj9UUbhrxuHyIItet0FVAuZvwbIfKm9Aiu9uGs1Md7G+pqtz+ANttqB/3umYzN9w8g7AZEgspFrXmzJAhd6FclSG+xx7DL5cdkyQ1aw166p73UOd1C0E/KfEsIdIkDenTCv86SokhZsxViJbbbmQZmUnplejkph5F7vYYd1mSlP1XZWpw4zGsD0SIy9LjE2fN6l/NQphvaI4Q7vHyQ/c4CuvsVlUMKr//fmjbT7fpWVQSeTAtYU+rWI3Rm5Y7xWj0ZwlJpBEH3LZ9+x5zZ9lVpbXO8CnRkD1Pj9cUYt6oXa0RZQmakavTulw0LxVgMDT+0pZHZt+jhjjIkHIZN6erL+ktAOHrk0NGaSfdNB1qY8ZqHL2WqRlmnhZmoGXe7JcjcwQa6qI37UXvECsyjEOoFScOjfbSXxKR3v7eMwoqIpabIR6Z6KqRbw7Rt1U0vI6P9GejQNuYWSfIYzQBzHsiZ7vcj4v2sv+yCtrCgp3+FeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzY5VWw5dVRxaFJ1MmJEZjJHUVBnQ1NNQ3hCWDhDd3YxL1BoeHhieXArZHZM?=
 =?utf-8?B?SHJQN1dBdkNSR1NMbkwxQmN5QXUvSmpzV0k0T0kxRXlCVTNyaWNjT1o4MWxP?=
 =?utf-8?B?YkkycVVwNTQ0TXA3MEdXUngwWUMraFFMdW9vWXBQUUdiRmpGY0p6c3JSR1ZG?=
 =?utf-8?B?T1NQZXl1OWRXdE4zZDhNTjJJVWJDNXRuL2hLbGE3Sm84SlVya2JWQUxRU2Fn?=
 =?utf-8?B?c0VvamJ5OHYvdVJTZHlkSmo2Y2E5THZBd3Y2L2tyb0pwREdPTE16QXlzeXBv?=
 =?utf-8?B?ZXRlUkliY0pJU080VTJZUXA5NlRkQWhWT1pmRExObGRhemcxRUdvdTNpeE9y?=
 =?utf-8?B?RFlsZDlCUGd0b0pxM21CRmRteDBvOVA2OWhjMWpjTmNCZ1piNW93WCtxOVZI?=
 =?utf-8?B?NjhIdCtDeEVjQWIwQ3J4WjVSUDA2eHJYenQycXBZcVM1d05XVlBEa05hVndZ?=
 =?utf-8?B?Vk1FSXNHVTh5VjdiMm8weGZzNlVvdjRUZGxvQnlCZDk0N2pObEJ0NjNPajh4?=
 =?utf-8?B?VXorNkJPbmpHUGZISnhUNGJSellETVVkRnRPMXd6MmhiNnc1aU5ZKzdKMXk1?=
 =?utf-8?B?ZFZEZWIzS2hHZDU1RXY0ZVIwbzZ2ZFdITENuN2xsL1pkU2h5UmFkMXhDeUx2?=
 =?utf-8?B?UnVNQnBNcWV3MVpTTzlQbVhKUzhuN2c1eDNRMkllK0FMd2UwQndWWlVpei9j?=
 =?utf-8?B?bXhqZ0l3Uk8yREZwYnkxVWg4OXBoak1leXI0czNQd0JRb004aEl5TFB2SzFa?=
 =?utf-8?B?NTkwSDhnQXlnRm1PcUlKaGh1bGhiS2ZKR0VwbE9IZmdvTzZSdE5TNVZVQWN1?=
 =?utf-8?B?L3REWm9sd1d4dkpwa1dRSURpVDh1QWtVUmVmU2hyYzBsMkpXSHhhWW9WSUl3?=
 =?utf-8?B?RWZjOHVRZUtxLzd3Z0w5YkVRZG5meG9BbDdRdzFRR1YrS1dGZlhSZ1FYekhI?=
 =?utf-8?B?MDgySzFZOWtXaFFsR05lZkFPZlo4Q3lYcS9JTi9MYk02OXBXRGcwY3BiSlZx?=
 =?utf-8?B?VEhaZDRDWEtMb3krM3ZCZSs0dVkzWG5HY0Zab3BYdmZINkVtZEhKeVVTM2JG?=
 =?utf-8?B?SzVIQ2ZDUURZNk1lY2lxT1EySC85dUkwYlRiRVJmeXA0MDhudEtla0Q4b2FU?=
 =?utf-8?B?VXA1bGlLVWk3bysyZ294ZHNPLzJoNlFkV2NwSmdVZU5TRTFwdVdac3l6RGJT?=
 =?utf-8?B?T2FOQ0diVGEzcUJNei95d0pLanFMeDlGUWw1cjZjZE4yZTArdVRNaWpHdFdC?=
 =?utf-8?B?RVJ2a0ZjaGFhVUgrTDdNR1dUVWF2K1dhTFhWOG9QS1JhK0IvNEptWC9LcmE0?=
 =?utf-8?B?VTlaWGdzT2s1Y0tkMjM3aWZocjlBUnE4eVpIblJNM243dmJOVXA2NkJEdXFv?=
 =?utf-8?B?c3E3NGJKbVdkNW0yKzBQRWg3RkNzYjFPQmdLNjVXMzdwZ2Uxa25PaXhwT3lY?=
 =?utf-8?B?TkgxcTRtTFB5dHNjN2pPaU4zNEhsQ3YvUHFEcHdubE1lOUlKSy9CV1Yza2cx?=
 =?utf-8?B?SGh4Qm1MekNhN0UwQTNyWWZDSERrVVJsVW55bUNJZnNOMVhVREw4SVdabnIw?=
 =?utf-8?B?UEhWOVJ3cUNCanJPdnVzU2NRMEhtZlhtdnQ4cmRjSi9Ic1MzVVZ1SVZzTmV6?=
 =?utf-8?B?QXNmTkxJa2hRTy8xdU9BTkhzQUZidTEzRHJIYXByRFRWNi9ydERTRy9YSkJl?=
 =?utf-8?B?Zjk3NmNWekVFc2NZRzBBdEVrZHFqL0dwMkVtb09KR0hIYjh0WUpFcUd6eG9Z?=
 =?utf-8?B?REJvektHdGdsNzEvc2wwaEpmcHo1YXJmc0ZtL2xoU1lNRDRtUS9tSnBVTG8z?=
 =?utf-8?B?OC9URHphb1k3c2NYWVp6WVduSTgyY3NaTzlreDhGUFNkUTlMTGhlVTdGZjBt?=
 =?utf-8?B?YVBCVVlieXFtSWEwc21iWDZoQ0ZuMVNuN0tVS3RpSUNFczNCYStIaFhJTWRp?=
 =?utf-8?B?RHJhaHd4WHBUSWNYMitXWWo2R2JoWG5xeWl3T05uTlNSejhvM3VwN1kwNWFi?=
 =?utf-8?B?YTFuTjNNMVdKekYrM043RzZibmU0dkxqVmRTWTlaRjNDREdnVmVCSm5NT09O?=
 =?utf-8?B?UDJSTWdYckU2RU1FdFROVER2dnhUYTdNbHVqQytFMGZRZFprRlNYWXBuL012?=
 =?utf-8?B?MmNadFlvTUpBcURCNWJCdDRUU2VhbE1tNjVROFI1c01WRlc5Wml2bUwwOXlD?=
 =?utf-8?B?YTRjYXpvV2JiMVI0Y2F4RmQxVFBwb1FnVWtla3hDZTZ5bkxPclRuWnFzUkdi?=
 =?utf-8?B?cDA1eExPTUF1YmhRRHU4QStlT2J4M0Qzb2Z0Yk9lTkpaSjNaeGwzcFpEY2Z4?=
 =?utf-8?Q?COXu5bwPN06mCP/uI+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3069dfc-80dd-42e7-9a3d-08dee81ee2f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 18:27:28.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRrpVtOpGm8FHLPuwFs28+HuhYtj00eKpAFTyC0jcuUB8SvqVAJr83FLimWk6RxEkSmT+SeJI/FaeRx8gvJHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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



On 6/23/26 09:58, Melissa Wen wrote:
> In newer DCN families, there is no hw predefined curves for shaper,
> blend and regamma. When userspace sets pre-defined curves for these
> blocks, the driver uses AMD color module to program predefined curve as
> LUT. However, it was using the same LUT segmentation for EOTF and
> inverse EOTF by using the same color management helper. This is causing
> banding on blend when PQ predefined curve is set. Besides that, degamma
> predefined HW curve cannot be used with subsampled 4:2:0/4:2:2 formats
> as it affects the linearity of color space in which HW scaler operates.
> 
> To mitigate banding when using the blend block and better support
> subsampled format on degamma, use different translation helpers when
> linearizing and delinearizing.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index 1340f673ec3b..c2ea25927765 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -493,11 +493,9 @@ bool dcn32_set_mcm_luts(
>   	if (plane_state->cm.blend_func.type == TF_TYPE_HWPWL)
>   		lut_params = &plane_state->cm.blend_func.pwl;
>   	else if (plane_state->cm.blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
> -		result = cm3_helper_translate_curve_to_hw_format(
> -			plane_state->ctx,
> +		result = cm3_helper_translate_curve_to_degamma_hw_format(
>   			&plane_state->cm.blend_func,
> -			&dpp_base->regamma_params,
> -			false);
> +			&dpp_base->regamma_params);
>   		if (!result)
>   			return result;
>   

The above change broke two IGT's kms_colorop subtests (tested on DCN3.5) 
as below

=====================================
Starting subtest: plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut
i 2569 j 0 shift 10 mask 3ff comp1 3bf comp2 3ff, pixel1 3bfeffbf pixel2 
3fffffff
[79.216137] (kms_colorop:10824) CRITICAL: Test assertion failure 
function colorop_plane_test, file ../tests/kms_colorop.c:281:
[79.216143] (kms_colorop:10824) CRITICAL: Failed assertion: 
compare_with_bracket(&sw_transform_fb, output_fb)
[79.216165] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
implemented
Stack trace: not implemented
Subtest plane-XR30-XR30-srgb_inv_eotf_lut-srgb_eotf_lut failed.

Starting subtest: plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2
i 15390 j 0 shift 10 mask 3ff comp1 398 comp2 3b8, pixel1 398e6398 
pixel2 3b8ee3b8
[81.747233] (kms_colorop:10824) CRITICAL: Test assertion failure 
function colorop_plane_test, file ../tests/kms_colorop.c:281:
[81.747239] (kms_colorop:10824) CRITICAL: Failed assertion: 
compare_with_bracket(&sw_transform_fb, output_fb)
[81.747256] (kms_colorop:10824) CRITICAL: Last errno: 38, Function not 
implemented
Stack trace: not implemented
Subtest plane-XR30-XR30-gamma_2_2-gamma_2_2_inv-gamma_2_2 failed.
=====================================

The root cause is from color delta increases, as also confirmed by the 
following IGT POC change:

--- tests/kms_colorop.c
+++ tests/kms_colorop.c
@@ -182,7 +182,7 @@ static bool compare_with_bracket(igt_fb_t *in, 
igt_fb_t *out)
                 return igt_cmp_fb_pixels(in, out, 1, 1);

         if (is_amdgpu_device(in->fd))
-               return igt_cmp_fb_pixels(in, out, 13, 13);
+               return igt_cmp_fb_pixels(in, out, 70, 13);


Is there any concerns on reverting above changes (or this patch)?

Note: I am looking for early feedback because I have not yet tested on 
other DCN hardware.


> @@ -554,9 +552,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>   	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>   		params = &plane_state->in_transfer_func.pwl;
>   	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
> -		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
> -							&plane_state->in_transfer_func,
> -							&dpp_base->degamma_params, false))
> +		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
> +								&dpp_base->degamma_params))
>   		params = &dpp_base->degamma_params;
>   
>   	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);

