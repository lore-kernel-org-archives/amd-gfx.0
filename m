Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5787AC3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 20:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A7B10E252;
	Mon, 15 Jul 2024 20:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7e/csnS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3954510E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 20:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGzVa2Tqb5FxgkKkN/Jk11ooopDDRJCwcOQ00GZhJgUTKebxtO5FDMAlBygmCWVGlCLY8Lh9A6rR0gJ4OZXtG/crIqj1RQrw15EzsOksztcshJd69Z7dbee7FRelw+w6AARN4Knrz5bX5c/PvkrJ+8h6foZ7Ats+78g9drs66xrKoQ/8ECFrXOOIyx2IiCeB0jZEngkACN4Ig6JUHwk9go32JmOIGQkOc+j+Cg9z7BfxUYc6AglmnJ+vTG72KLRevcF5pEA1tfHN1QVNw2RheWAXvVMgdro+NiGag/zlg4LN6th2qb7q0hthuRPsu4btFjljd8HsUPCgU02rLvZRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIGxrjQeynMt8LyLN+vmCFm4QBjN8Ej42KZ4SPvGiEI=;
 b=bUpCVb6fM2SkmsrYrCsFLWCUM+U5d7EIWyLzZIOug6lM1OKmv6jsOqpxosQ5m1jOj0G8rZuW9+iBt7XOAZDVDYtxtibUa9j0zNe0F0tAKu8wz0Bku89dKbZ6UjOYg2Sc41gsaUwLJQg8T1liz+QNoMUPN0iwguVHUxsFcy04CDJWPzkBVgjkl9e+RSEN2wwCuhvGE1A9EbbgOJ0Ur7uaAtZgRlSGBB3o69TMvkqyEb9v4Lw7BoStDG2Q9rHvYwgMKEWiRgIfF8DyQlc2VtK+SnXAQAvgfRtHRjUSgRWK1D9tgNoFuVzBPMNRqcUkn7GR92g8WoDwWF1aqhFLGlMGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIGxrjQeynMt8LyLN+vmCFm4QBjN8Ej42KZ4SPvGiEI=;
 b=j7e/csnSzQLBVeZAQ6FxTkOxwYYukW80O2xM1IBIe4+Z3nBiADT3VhrtTBwIrcET7+Lfqp5lkmnHVY/xc3Bn7qksNcb+x0HxMsh1fsbNFANMUWivW0PbfAA0EWKMDpAY6kGvYEJUHKX8nSMaeHViszUYsRy9L9Z0OUw5WkUSFJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:43:04 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:43:04 +0000
Message-ID: <76ca1923-2d00-499d-bbc3-2120de4b3e64@amd.com>
Date: Mon, 15 Jul 2024 16:43:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add doc entry for program_3dlut_size
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 alexdeucher@gmail.com
Cc: Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>
References: <20240715203908.3679450-1-alex.hung@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240715203908.3679450-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::38) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ae2204-44a8-48a4-81bb-08dca50eb975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1Q1UlBNVmErK2l0WGx6NGwzWjJNM2FZVjE5ODRtbmtha2lremRLYjZpRUtU?=
 =?utf-8?B?QVlhMnBsWTdLcmIyenliVlMvOHltZ3o3cjNQaHRvdUw0ajNtOTJtNVVTS3Z2?=
 =?utf-8?B?OWI5dUc4RWMybXVTUXh3eTdVSThYUGFwRlI0dFRiMmtna3htVTF6eW8zTjQ5?=
 =?utf-8?B?WVdHY0RvWnoxamMrb1JjSzVjaU5WYjlOQk1BOGhIMUdBV1gzNGxPdmtSdXpn?=
 =?utf-8?B?SkdZQ3RZZkdjUnNCUHgxdkRObGp3Q2ZiL0xOYWw2czVGZlNrMzRHbUoza05y?=
 =?utf-8?B?dEtiSC9ud2x1NUlTVnpZZFVBQjYxWlhqdHpyMDNvSC9NQnZ0THdFRVRlOTBn?=
 =?utf-8?B?VVZJcTJNYVVzK1orSUVnVEJNc1dEQno5RFNZMkx1cm9QY2F0bmt5UDF4RkR6?=
 =?utf-8?B?U2JzeUVidHdvMThCdnpXOUVKYTFMY3JWeXZidVhiNEk4RTc0dHhMeC9saWpE?=
 =?utf-8?B?OHhITDEwU2RNcDJWblNyMEd5QWpyT3gvNDdmOVhhV2J6eFVIVEJNQUNOTHVL?=
 =?utf-8?B?empWOEZjWk1DN3ZWTGcveEZ1d25tbmdtUjdVSXJGU2p1Y1lsTDNzME1KbHNO?=
 =?utf-8?B?SXFZT2NxdiswM3JBVlRvREhnMjVtZmtVc0F6NUZDOEliS1ZnR3RneVNiMnlp?=
 =?utf-8?B?MTZxS3gwek1TcUlSNnFXbExzZ3RnMWtSZzAyemJVVnJoN0U4Mm9Sd0VGU0oz?=
 =?utf-8?B?czE4dk5DUXV5cjB1S0lJeHpScXA3SDNna2I4NWJxNml5VnRhZENiRHhsR0Z6?=
 =?utf-8?B?cVUzY01Pd3VnTk9qM3hWcU1ZSzl5Vm55eDlQdExDM1NLQ2NDSXZwN0tBTkR2?=
 =?utf-8?B?S1F0VW9PblhJWXBnRXk3WkhTWjBHUUJZZzg0WWFWYnEydTkvNFg5OXl2amJp?=
 =?utf-8?B?MHlLa2Z4ZUlUS0RqaDh4RFUxT3Z0b1JGQjdPVC90QU9jV04rbkJZZzczdEcy?=
 =?utf-8?B?M1RMRnprcnRsVVlkeVkyTDJqbmFZbzZvWDBnSHVpZ3IxenBiTzNtcVVIRUJM?=
 =?utf-8?B?ZkUrQ1BXZGc2VDVIdlFBdTlrUTlyY25ZZEhvZXRhZ1YrU2pFMDQxQk5yZEdV?=
 =?utf-8?B?d090WGlWVnZZSHpxazlmd2ZBdUMwaWo1d3NFUlpEZnhvWEF6ZmoyYUZyTzBo?=
 =?utf-8?B?OCtNNDR1TzBFT1ZBRGdpbHI1Nis3Z00yOVB5UnI0NjdXNmZqaDF5NWZhdTVy?=
 =?utf-8?B?MG1ORFBRL2MzK2FPVitDNGYrRmpUcmxNbVcvTFpzcjg0WUlFd21xdjVjWG1s?=
 =?utf-8?B?am5XSU4zWUJSb21mZGxvaE51SG1LSStLY2RNVC8yOEIvRllZTjlISnAyNEJr?=
 =?utf-8?B?QXgrSjRvNGtmcFdNQTRHMVF2YzZ4bytIMDd2djRFK2dCeHBOVHFEWUwxOTJR?=
 =?utf-8?B?TkxEdzJVR2JxdGFpazlCd09IekdETlpPckFIbEl6aWh2QlVSakkxaEdVR2lT?=
 =?utf-8?B?TytGb2dxV3U0REtDdGJEZXV0N21xYnhFcEM4dGpuQ2hnQ2hGMHVWd21meFhs?=
 =?utf-8?B?bHRRUEMydkM1M0g0YWFkd0E5WTYwOUxMNjF4VDdxVWpmbWs2ZE41c2hlVFNy?=
 =?utf-8?B?TDArYkwvL1BJVHk3QURMVnVPcWFneGNKa1k5YkN2V252RHFybjlud2dqWUJa?=
 =?utf-8?B?TUtaUGVPQ1dTeE83R1pkd2VwTnVUb29rV3Qyam9rbjlIRnpQMFJwVld1aEV6?=
 =?utf-8?B?c0w4dHZaSTVJcmlwNU1ER0wzaXgwejRaOUJTd0xrdnlFdVFRZ0Vxb3FEN2hK?=
 =?utf-8?B?K0h1bkpOTXR2UWFBWGVabkFNZ090YkFudHBMK1dGeFZuQ1JRSmg3LzFnbGl3?=
 =?utf-8?B?bjVjUkRKYlhCbTdVMzMydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk1vcTF0ZFRCRnlkSHBFZ1VQanZ1SjUrajg1aWlCMThYYXNNUHVhZERNazJ2?=
 =?utf-8?B?cENaTXdaSWJlTVUxb2ZZY2x3S3UxcDQ0b1d5NzBVMnNtbFBMZ3ZwcWlYeXVB?=
 =?utf-8?B?T2RFaURSLzZrcE8wVU10V01tVVVmUDU5V1dSVmZ2cEdLcG9vZ1AzdTVDalc0?=
 =?utf-8?B?NUJsUHc2dzFvdWtFRitUWXR2TVdzSUlpQzgyZDRXQmNhYndPT0J6UzNwTTQy?=
 =?utf-8?B?NGxjSEozQ3NqOSsxaldmRnp0RzZjVVZ0dlYwQk1ucHBnZmJheUp0NjBUZDdL?=
 =?utf-8?B?R2pqTVVyV3ZpR0p3N0pwMXZ4N1UxbDEzclNLVHhlQW5zK2JKRFpyZ0ZtTUZy?=
 =?utf-8?B?bVdkTmJJWE5RYmQ3ZkswTklhSUtqTWNIY2tDZ05QSE9PWko3akFyM2Y4bGNz?=
 =?utf-8?B?WmE0WVUvVDJzSEEwRzI0NW5TQUlUakhRbUprSmh5MjFIbWlXMmRnQjBsRSs1?=
 =?utf-8?B?cWJ4cGw4OCtqWjRkRHFabzBRQ05JSml5ZmN1SDQ2eVB3dXo5MmUrZHJGL2pa?=
 =?utf-8?B?RC9CZHd0TmhHajR0UDg1THpMcGJHUzJhUnlCZkVvQ0l1cVVhWVJocC9Ub09l?=
 =?utf-8?B?L2c1VDAvWTU2MU5IRVRIZEFqcUdkTU1CYU01TmZDQWc3QnZZUDNaei9HdFdV?=
 =?utf-8?B?RHkzbGxUNFpIRkFqVi8xM1BMZFRVYWNZcmU2OFR3NFZ6Sk9hNEFqOHpCaEc3?=
 =?utf-8?B?VlprRWQ4SnE0Ny9OTnNzME42Tjk2SGpJVER2NGpJUXlaWFdLNXkxOFRRSE5h?=
 =?utf-8?B?Y1VabnlQZ0tLSGtvZ2NOM1hSblBkREo2SEhCc3ZLa2VmbHVPbXNUMWl0bDFv?=
 =?utf-8?B?R29mKzRNUnJScmVObzlIREUzREcvbTU5bTd5VEdiUGZPQWJiZ2t3M2FSbkcv?=
 =?utf-8?B?WEVwWTFVamU1Y3ljMnl1aElQcjVxcWtGSEdwNXhFc0lqZ24rUnFpd1oxVm91?=
 =?utf-8?B?b1Z5aExaZ3k2SFRZNnBaOVAzM1lJMVBmSFAvLzVPT3NYZDVwSWFpd1IyTU94?=
 =?utf-8?B?Mkd3RElnMUF6RGJ1TjFFRjFLa1VPQkttKy9xNnd2enNuSi9Qc2FraHdEZzRo?=
 =?utf-8?B?Q0Z6RHRwK3NMTnVUR2VzdFQ5eXBhb053dDU0QnZzbG9BMUJBWEp4RlBEQ2Q5?=
 =?utf-8?B?MTQ1NFdVZGV1aWJPaktEZ2JWSlU5bHRMSEJiQVdWUjNvdUhCWUZkQ1p4S2RD?=
 =?utf-8?B?cjhvMUJ3blNobThqUFMvUnV3TTI1Rm1oZ2tFUU9CN1hnSWlLV3QwZCszQzRy?=
 =?utf-8?B?cytibVN0ZmVwbFQrWXg3bWRNMlFqbjF2Y3hVc2hqNkpPVkxZUFU0VUNMdUtR?=
 =?utf-8?B?dGp2c0FBTWppRlNuUHlabE11L1N5U0JIbzlpb3I2dXdleDY5RWxQeEh3bTlE?=
 =?utf-8?B?SlE3cFpXaC9ER29WR3lkb0x6S1dHOWc5WDNhWU1tTDlhYWJkZzFEUWdBZmsw?=
 =?utf-8?B?N2x5SVVuaXlLa1RONk9wZnltdGI1cXZGS1ZBZTdxOUxiRVY2ZVNXZ0lUVi95?=
 =?utf-8?B?QkZiakUvUU9MUThwSFlXYWlRS2Fmb25Vd1dObzZwNWE0N3hMZjdQVGh3NTly?=
 =?utf-8?B?K2tlYmp5Zk8wR1QwRXU5Y00xeGIxVWQwVEJnK252ZTE0V0hYb0R1cDFVaW5a?=
 =?utf-8?B?WERlTS90WHpMeW9QbWRWZUFkS1pIeVV4VU5SZzNQSHJUUm93SUpQTEMrcVJ0?=
 =?utf-8?B?ajF4L09YSmlzaDZDRWQzcE5KanVFK2M3R21LRXVGTEZvMm1pRS9XNEdRNGRx?=
 =?utf-8?B?eU1CWVdUNmJ3Wk95WGx1Z1d5VjZKNjRvaE1URWk0blNVSWF4YXhzNnljeVBZ?=
 =?utf-8?B?bzNWZnRxNjY2NmdJWWpmNjlGNlVOY0EzWGlMbkJyZlFIbTgvWEI1a2RacVh3?=
 =?utf-8?B?M2V0ZmNDOFZaak9rS2tBTmdmNVRtQjl1OGozUEhHWkdNTUxzZ3k4WlhCN0xy?=
 =?utf-8?B?eHBxN0ZGd1FpWjZHSk5EYkgwZWM4ZFVkclZrTkpNczBGK0w4SmU4VmRlQWJG?=
 =?utf-8?B?STVteEtGaEh4bEdDcE11TWh4UW9BTEhRcko0UGRUSHdza044eFNtaXEyejVV?=
 =?utf-8?B?ZVlIcTZ3bUxyczBsRmgvUkROdkhOTUM4YzZ1eWdkYXFyVzJpc0gzcHYwVmtN?=
 =?utf-8?Q?/Xr3+LsEfX3/YozLmY8ykSzNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae2204-44a8-48a4-81bb-08dca50eb975
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:43:04.0844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pvzA3LAHe2XXMoQP5PXOUmRGJn5VC4wPWnmpliNLnAGkynl0x2hCdcxdSjwtwZShe1hvc0NZ8EviY9TxkS7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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



On 7/15/24 4:39 PM, Alex Hung wrote:
> Fixes the warning:
> 
> Function parameter or struct member 'program_3dlut_size' not described in 'mpc_funcs'
> 
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> index 40a9b3471208..3a89cc0cffc1 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> @@ -1039,6 +1039,20 @@ struct mpc_funcs {
>   	*/
>   	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
>   			bool lut_bank_a, int mpcc_id);
> +	/**
> +	* @program_3dlut_size:
> +	*
> +	* Program 3D LUT size.
> +	*
> +	* Parameters:
> +	* - [in/out] mpc - MPC context.
> +	* - [in] is_17x17x17 - is 3dlut 17x17x17
> +	* - [in] mpcc_id
> +	*
> +	* Return:
> +	*
> +	* void
> +	*/
>   	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
>   };

With the following tag added,

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

this patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>


--

Thanks & Regards,
Aurabindo Pillai
