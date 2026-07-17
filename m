Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88CC4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 14:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADC510F58C;
	Fri, 17 Jul 2026 14:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FK1YqH6v";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4135D10F58C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 14:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y48rzC7x3SQ+PZXySWWiNdAc8CAUt+/RLySb5YyBGLUgpRlEXqxbkR3vv0cMCwPZIV8I9h4eQtyy90bD59Sy1DcjftxbV37sO9hXtoOtiMIFJiX3k8qkVGK6kyNtSqzmE3QSQRmCTKyG9c5oDQhSW1QwTNDa0lSMdxE0bfg6Eo6J2ZnHfLpjEulf9rNWHkX3JtCRMR1Fwq1SLay6etvG06oM8va+MmrzkzGTyGSaRuTmnvWna2RXaBiaMqvT2ChGUBVE7aGpjx2B4ZsxXW1jAlOjvyNCiOPyZ+fPp4Ejik2NXYr8X8OLPF3d925APWNIOeEnFVUrQeeHnleLn+2mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHGkAxAddMuAZxWsnrM6m2hXdTQQ5rzaLmcARF15INo=;
 b=QPLyKNv8/FPLc8NiNccpzD+374RNeAEO/2iFaky2kcVGaHqgR8qBs6mqy37Je1WxfWgKhHrPdmOknFhJR/PBWmICZDhxwm6CoJViXh4LrD5KcoBiQLTNcTUNdX/iG6f0yeQkjiE3NXY2hUrd3lcaR26WugGWqxArXAuXuTINxuPxxuK9gYwkGwz4uULQVSITN2B4GjRvtpPSU6Vv6vaoJTMA8heCTW8AYtf1tP2QDDgEk4SSVHcAmxzY1NvYuBxarLzZuxD5seqMpvJ/TmCLhL5NdQr9I6QibN7Zz5N3wROt2aDsU1NHYAzSAn/3pVKzFBZhDQazypBOL1O6bQ8FXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHGkAxAddMuAZxWsnrM6m2hXdTQQ5rzaLmcARF15INo=;
 b=FK1YqH6vz/EAjsGjOH/FRkQFY9cdxsyFU6+fVy39nYH6/ajAyF9YzoojkSAEfVayITCvlqBYFcAu13fEHzB8eUMAiGGSIB9pOPsVZDd+FRmp5wRCBDcuokTd8kOe/wwh+n5Kzpo9jAOTE1j8HyiQNzSroik59t4b9i2V9BMj4fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 14:32:38 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Fri, 17 Jul 2026
 14:32:38 +0000
Message-ID: <97767326-078c-424f-a38f-007355556aa4@amd.com>
Date: Fri, 17 Jul 2026 10:32:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Dispatch Compressed FRL Cap Check Inside
 dml1_frl_cap_chk_inter
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com
References: <20260717024329.2609156-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260717024329.2609156-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0498.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::6) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6c14ba-fa05-40c8-a589-08dee4104068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: klpZe+JeccCZeumaSHVQDFZIq5G0q+foEWyZ3Tf7uo1FymgTaRpJI7y46Bky2vDFs7fKtYvwwfFGygIXESF/ds41+C7klN12sVlYnLXdhxEB10FJA07vVwMpCVTMSa501FHbNLMgI7nnMfJk18SUvIDK8U+u9Uz8laFgfBio7To49l6tu2JiR9C8lJ5RVakHQFkY10T/UkdrHQIRRmY1ylmwywR+Fu65agZfbu47R6sQK7FLVitT8fDs+EoI028+m6wTSPvh+DoRtGnbcZtFVx+Dq8WL25l8FiWllHRMDCvPW9/bzT+RHQhcZe0YvuA6pXQg+CMqtoRrAaZCsSj/dkZ68JXnf60jVM/avJ2b1HgiQDxA3VmO3YtQZGodFi7CxHLhloZFPODX/VBzBYEAgVUXF4KEDyMqTmngjzOQ/C/QQ2pmccezbJ1oEeLjRrn0dB95qc7eHVLAma+vXRPfzPUDpYcHNLxcf5lFmlqWLJCP/dEGIs3cVPYK+0tsK/gyFL/aMDFd5Ikpni85K5l7eVrj6a2SCWPnzzps75H4oCGZ46BWIOfv+M0AcWe1vWlPOuajZwU3io5bK0sFnL/62WRvcA9uJbav/d/y+22guRrgt73C7+HRnSszROGmGOfjt2u5ffC/0PiPGjM99gxE92F+Z1dKnLbVGdzrzSL1OOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVXOEVKNlZhME5LYTFnYmJaWmNwV1UzdkxNSHJlL1pjeTRtK2w3Nmo2OTBO?=
 =?utf-8?B?dS9qeVVzL1RsRFNkTC9KU2pMcnJvNHlKZWVHVVhqV3lVRW0walpBTXRlbytS?=
 =?utf-8?B?ZFZVRTBzZ2c3R2QrVnJ4MERSM2xNUFdZZkZJSDhqZkRVMFVqM3F2RTNGZGk3?=
 =?utf-8?B?NkE4VlJRamxzZW1lQXNjemVOblBVMHZoZWhHQ2lsa2QzQ3NFeUxqcjRPeUxB?=
 =?utf-8?B?M05WV0RWNTFUMzZsMHhsdGRPaVJwRlZxQ2JjZkV3eFVDMzBRaGk0Zk5pRGlD?=
 =?utf-8?B?K2pUOU1PT3V5RkYwNUxGM0NPeVhpSjZQa255ZlNjVWMxczFjbnQ0N1lReDIw?=
 =?utf-8?B?ZGQ4QnpKYlRHM09oaXp4UFd0NTI1dXhyb2ZSUmFIdXFudHh5UGdCVytNeEpK?=
 =?utf-8?B?bzdKM2pYdUZjNzFMSFBIc2lGUEpLbzFOZzZZWjJxQlNVWTRuc1A2T1dHZTJa?=
 =?utf-8?B?TVhIWG5ob2pVWFJoWGZmWHhIaXhJMy9Bc1ZrN1lHTUxpc2FBaDJzbVYwSjNU?=
 =?utf-8?B?VGJoQlJIUkFjUjlOcFd6YTdaMUpoZFBJVnFadnhGRUR0MVJvYzRuRVBXRk9x?=
 =?utf-8?B?R25yV1NheTU1VnFRTk1DVTNpOGs0MGxHMWxscnFNYy93WXdkOW13NmtTWVZj?=
 =?utf-8?B?Y01ncnloeGp2cGI0OHd5UkxwMWpCWmxFTVA0ait2ZDNPc2I2dFpGZldFdjJy?=
 =?utf-8?B?RGg0TDJxK2lhSFlRcDFjbW9uZVZSTk1rOUNKUHdtZlJXYVNuRVpGQUtUVXMw?=
 =?utf-8?B?WHo4cVJBU0tkUVc5MzlmVGt0ajNkd01aY3N3UEk0OE5CMmRYTFUrb0QvbWRE?=
 =?utf-8?B?T3pxTURraWNYeERkL0JlWW02djRPTzY3MGU3WWZUN2taS2l1Mm5OdmU5RGt4?=
 =?utf-8?B?alNkLzZLTHZDQlcxSm50dDNMN1QwR3U3bkprZmVLbG1palBmaktNT0lEazQ4?=
 =?utf-8?B?b2hRM0dzdEpuNTBiR3VsbzJDVHoySitwdEt4WkhnWmlYQXJ2bHI1MUdCdVox?=
 =?utf-8?B?VEQ3MXFLT1lHMXFtTEh0Y09iNUZnQ2NwWlRoblAvQ0VCZWkvNnBPTGRjTzd2?=
 =?utf-8?B?V3JxaXA4ZlJoM2VXKytSTFpjQkxJVGVBeU4xNVpGUWx1QUNyMmZpSEdrT0Js?=
 =?utf-8?B?Y2UrYjJRKzcxK3o5L1YzNkJPVlBBbEVxVlBRK1ZOOEtrU0ZGbldwZ1I0VXVj?=
 =?utf-8?B?Zkd5ZWVCNkIyRU40S08rVHRMZ05aeGxOOFFzSE5KZ3ltbThyLy84dHdoSlYr?=
 =?utf-8?B?WnBVaTZGbkVVUEFMdEh3eGJBU3krU1NsZkFLWTBza2V1a1lLVjlzTjlISmJS?=
 =?utf-8?B?aDF2eEs1cUlGQXhIVUxNYVBUd0hFZlp3dVhBZzNPMmIyNFBvUEl6YkIyekw1?=
 =?utf-8?B?WEJmdEpITVhMa1ZvV1pqV2JaN2FqQm5lUWppVzJsekN3NFZRZ0lKZzRkcC9s?=
 =?utf-8?B?NXRzUitpMDFyT0lweFhiVkpDTEw1UmkrT2VXSnBoRFVteE96elhaVjVEQTNH?=
 =?utf-8?B?QkJpR2pJc0h0M29meC9Ga1pZTFB4eFRHdzNSOHh5bFY3NEd5Y2NscW9TSld0?=
 =?utf-8?B?cWpOczV1YWtiN09SR0VTcVdzSUoyVmRVUktaeiszaHc2ZXFkZWdmMzRPWlBL?=
 =?utf-8?B?a0lZVE5XbEIrYmdSSjZpYW9OdGpjK1pPVHhhYkg1aG1keGZBOGFOVTlqcGVX?=
 =?utf-8?B?UWVNdDhBUDhDb3R1NFY3ZTBRV0szR0RvM0pGYS9ycDFqc1ZkaGlOZWNoKzJS?=
 =?utf-8?B?UnFubFJxWXZ2YXNmTFJWRmszN2swcExuZWRkc2Zrbks2U2laR0hnU0lRZ0tV?=
 =?utf-8?B?WnlxRytBWW90SkFRSFQyQnE2SUZWaXZyYlVsa2J1b2p4Y1JYMTh5NlN6TnAr?=
 =?utf-8?B?NitZZDk2STBSMzg0TllVc2pYazExQWkvSDBnS3NBQkc0U3dwT1o2NDh1RFdJ?=
 =?utf-8?B?Y21aVTJjK2xVOEdiUHIwdUZmZWx6ekwzeWJKUzhLZXpHak1zcUwyRk44RkxZ?=
 =?utf-8?B?Uk5zcWhTcGc0RzgvRzB5NnozYUMyZEg0T1h4VVZnLzRLc0FTbTJHVG1NaXlR?=
 =?utf-8?B?aXZMazBNS1JleGxCV3RaWU10RHhJbkMrNGFBd1RxVVpHT1I5UmRyM051UlA2?=
 =?utf-8?B?a1ZHM0xvM2Q1eHQrM01Tb01XWWtJeUNPYXNTUkNrS2hJM2ZlRkdjdW9BNitt?=
 =?utf-8?B?VDJsSVBIcUU3VmFkQURQTVhsK0xJZnYvVFlhbkhPUVE4aFdCa3hNQ1hVaWdr?=
 =?utf-8?B?RGE3cFJBYVZIaTZ3U3NaZGZrcjNsWk80OG92QjNwSGNvdTFYWUpRdHBxUTFt?=
 =?utf-8?B?ZEF5OUYwYklyUnR5RTRIa21WRk5IVFh6OU55WmJaWDZ4enZwTWJDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c14ba-fa05-40c8-a589-08dee4104068
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 14:32:38.6267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +79ZTn+u1S5yGJ5EXP+IdNHWRmlOXtrjCiMB77EzscpjCfar1Wpleg6C6EfIfd9f4lnSBYpQyQhVSsGk5hXv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
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



On 2026-07-16 22:43, Fangzhi Zuo wrote:
> [why]
> DSC over HDMI FRL (e.g. 4k144) was pruned by DML mode support
> because the compressed FRL cap check was never reached.
> 
> dml32_TruncToValidBPP() validates the FRL output by calling
> dml1_frl_cap_chk_inter() directly. The compressed-vs-uncompressed
> dispatch (if params->compressed -> dml1_frl_cap_chk_compressed()) had
> been moved up into the top-level dml1_frl_cap_chk() wrapper, leaving
> dml1_frl_cap_chk_inter() as uncompressed-only. As a result a DSC stream
> routed through TruncToValidBPP was validated against the full
> uncompressed bandwidth, failed the cap check, and the mode was pruned
> (vlevel == num_states).
> 
> [how]
> Move the compressed dispatch back into dml1_frl_cap_chk_inter() so every
> caller of _inter() (including TruncToValidBPP) honours params->compressed.
> This matches the internal DAL tree.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> index 260f58a97fc7..da2c92e5c02f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> @@ -630,17 +630,17 @@ enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
>  {
>  	struct frl_cap_chk_intermediates inter;
>  
> -#if defined (CONFIG_DRM_AMD_DC_FP)
> -	if (params->compressed)
> -		return dml1_frl_cap_chk_compressed(params, &inter);
> -#endif
> -
>  	return dml1_frl_cap_chk_inter(params, &inter);
>  }
>  
>  enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params *params,
>  					       struct frl_cap_chk_intermediates *inter)
>  {
> +#if defined (CONFIG_DRM_AMD_DC_FP)
> +	if (params->compressed)
> +		return dml1_frl_cap_chk_compressed(params, inter);
> +#endif
> +
>  	return dml1_frl_cap_chk_uncompressed(params, inter);
>  }
>  

