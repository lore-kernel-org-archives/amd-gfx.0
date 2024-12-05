Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD8FE7716E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 19:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2016210E5C8;
	Thu,  5 Dec 2024 19:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3bN3Jp6i";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6764D10E5C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 19:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnBapeopzryIUwlggXxrA6frxf5jvzD2TxrlPNT1I4bPMhxVR/wl/gMcgRv+c4oWtUI25yd3lv2cNoo95rUn+9LcPChhPJQebcfSfGa9PRkEzEJ0nZ+r/OJmUz6bofk9vGL1z8Mz5eKSYumlwtgi7PxxI33MsQze3f8MuagdnG0BEj3jaTUS/LnTfAo6FlsZmrt4q4rrqUQgf0gjSmy+1rXfVYrJO9bERCgLbyfT83eQ7gYW7gHlDnPhj3xwDjWFsaUmx5m+MYwpF7cyhy1udfaNLAMvtyU5Gb5GACnIE3AX5FXjfj/mfWCYfKKQeAHWyO+osyi1Ugon5uCf57WKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0PEVLNfANP7BtgZJZuJoPOW4awvspEQ53S3p130S3c=;
 b=qsV5kOIvwQIORTRarF4gnPFnuEsaGjiP/32P2FVfwV5osYMZEs2cvF2B0gdfrvc1CvWzgAOly6qLvX5XOg9sHawLgT8X08cIL7WSTKPGFiK4aob06ThOfxD7p//FSYK2sRBAGs8dawz5mEyNmSU7/zxtoXgtC0fQl/FoOd4P1mkV58JyQmGZB7P5vzEUo2RnSuIlvSE3Xfge9t9cDL+tMrBw9TQlCG2gg+JcD7XqBaS0iALqXN9t/M635A53mFI1O6vwjUW7uwZE7Fi1OJUka3MApomUzay1Sei9miorBii1y+qhW5V8yBnKcEXjs9xLDOGnzQv3Ljf+Hij+1zJKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0PEVLNfANP7BtgZJZuJoPOW4awvspEQ53S3p130S3c=;
 b=3bN3Jp6ixjnBlMA2GaKpeUQEbu4DQneHNksz23ENT0ge1QkT8pViu5wuHLeRc/UiCgIkRyNtu0pk8GXwm/vjHCBX/0uBD4kVrFgg+6FCJqWRpBCbSV6r8I/G+dRcIzu3N3TY2WyElyBHnndd4FXoLcXQyEsijhywC9oUArt0DvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 19:05:24 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 19:05:24 +0000
Message-ID: <f2178448-4ac8-426d-b582-2508279cdf33@amd.com>
Date: Thu, 5 Dec 2024 14:05:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: hard-code MALL Cacheline size for gfx11, 
 gfx12
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241128161712.168408-1-Harish.Kasiviswanathan@amd.com>
 <20241128161712.168408-2-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Belanger, David" <david.belanger@amd.com>
In-Reply-To: <20241128161712.168408-2-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To CH3PR12MB9395.namprd12.prod.outlook.com
 (2603:10b6:610:1ce::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9395:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb56ff1-4b3c-438a-bdf6-08dd155fc598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWN3MW16bjVSTERvT3BIYzlNTHJCYzR1MVF6WFNjQWFQMjJDNlJvTTg2NEMx?=
 =?utf-8?B?a1NBQ2kveStpTXF4a3Z2bkpMTms2QkV4VHhCRzhNUmdPdWhUYlc3Tmo1QXV0?=
 =?utf-8?B?K2wxRHh2ZlFlU0hrUjFVV0hqc1hEeFlJS0xMc2ZFVkx0VzJwdjZpT2V3WEtZ?=
 =?utf-8?B?cE5FaU9QNHlDNC9kelduVXYrZGxHV080UlRoemk5Uml2VkV4RTYwNUZJSkNR?=
 =?utf-8?B?WWY1cGhsTzF6aW40bHhmR3dnY1JDa1JUSEYwN1N4ZUNybEM3UHAzZHFCSVNz?=
 =?utf-8?B?SjRnL2Exc1hMWFh5L1Q3em9ndnljOGd2NWJwZEMzQVBRZGtBVHBTa25LVGpY?=
 =?utf-8?B?c0Nmd0NENlpnV1NmaDFVaVpZc1RUL25SekZUVTd5SkwyeUFMUzY1bDBFbWFM?=
 =?utf-8?B?RnRRcTdzL3dXYVhuUWJiWkI1UmZTWlI1SkJHbjJEeWIxWWlvMUpmUUlHZk5z?=
 =?utf-8?B?UGlqeFdyOGVFdnByZGhRYnVGT2N6SVprSGo3RjlCOUd2RVZjbWFMQ053ZDJs?=
 =?utf-8?B?eGp6dHppdG9WcnRrZ0hmNVVieEg2Uy9YN0ozYlIxYkdoR0hhZGhNbXFzUDRM?=
 =?utf-8?B?eXBpSWFsRW9RZGljOXBQTW5kUmV2aFVrdGNyTUgraVhBSUtOUnNGaVVFUjlI?=
 =?utf-8?B?OXZJc01GMkk2WXVpdW01ZG9KbkZPUGJ4T3VFcVNhalRlVUhhMXoyNGNjV2po?=
 =?utf-8?B?bjYxQkxwbDVhQzdpRDR0dGNYUUdXT3kxRlBTRUw1M3V6U1dtd0ZQRC9nQWhw?=
 =?utf-8?B?OEFBNzBlMkJSWGdjMmI1Qmg4WVI3NDFVWHNqYmVyYmJVUldwbjA1VkNyTnhP?=
 =?utf-8?B?Zy9JQkFsY1NHTS9CM1V5QTRmc1NSdGoyY0hqcEIzVkhjVmdOUEVIUWV0U1VS?=
 =?utf-8?B?SWJweVlkWHEzRmduOEZnVko3RGFDa1R3VVdjUEcrVUtGVjM0V2tmWlFWYXEx?=
 =?utf-8?B?SmVVM3hQUkRQOFE5Y1NhTW5Na2ZTcnVYWDE1VUlKY28rSVpEbWxxaFZhcElM?=
 =?utf-8?B?R0JlYkFDeTduVXBYajFYNlMyckhqV0V6Q2xWM3dyYVVYY0lvYTBtU1U3aGlt?=
 =?utf-8?B?Tkl6SjBWb1lQMHpGNnM3c1BWU0dudkpnZkxxZmtOR0FOQllCUERrSFF0SzFu?=
 =?utf-8?B?VklybzdEbGEzck13WVE4NFJ2UmpaQVlzeWlZOER4VU5LTUdxRlUyU0ttRkpW?=
 =?utf-8?B?d0U5N1BPaU9aMDFDTlpFTlVPMXNtaEpEck9NbE0vUmRoSHFHSXNEQnVMWDZF?=
 =?utf-8?B?MmZpWVdsSzBlRUdmcE5obXg4VCtUWDlGWUZ2dm5HVjI2STk5UkNtbjMrZm9F?=
 =?utf-8?B?RHVzVFZrSHoyNzlueUdIL0UwQXBXVGpkWkRqazVKQlFtTngyM2FlNUZ6UVE3?=
 =?utf-8?B?MTdyUE93NTZmQ3Qxc3JNVDVFVnhCUmpOTXRYRmI0S3UzREsrQ3dWLzlzdlVh?=
 =?utf-8?B?RGRaQXJ6eHg0VTJrMFVhbUFDSlZQL2RPRlkveEoxdVQvd1h0OUU3SGprMlZC?=
 =?utf-8?B?TTFsMzlsTWFnNGJNVHJtVXJYdmxVVkRNQVlDTUZERHhvakpwdlVLVEYyb1JX?=
 =?utf-8?B?UjlZN0UvSHdsTXZZc3JQVXJ2bFNYRm9NcFc1ZnNvdXloQWdLbWhJVjZjWWZC?=
 =?utf-8?B?bk1CV0w4blBHUFhqMHRWWUh5R0NYaW43cVhrVy9wZ1BKcFdZbWg5TEdLSlVu?=
 =?utf-8?B?V0VoWFBOa3pKNUlIUXVUajhTb28rV3hLN3VFYVVUL0dPSEJhcnhoS25tNkZK?=
 =?utf-8?B?a1E2YTVESUhEWWdFUGNTSklaSDF1elowVXM2c0E1RERXaWJMMWtndWJQdGlT?=
 =?utf-8?B?Z2tkUDk2d0pEb0dLMWpEZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVlDbzViT2xyTkpHYVM1UGdRUmlkTXR3OW0vbHR0TG00RG5acVl3S1J3b29j?=
 =?utf-8?B?SGxNYWI0Wk1ZUXg2dHFXVmZ0WXVSekFsSllYbm1JRFhQZ3FmRFI2WXNudFp0?=
 =?utf-8?B?aFlSZnFWRVlsSWdJQUZRSkdYTHJPbDVKVnU0QVhLYktBWWJCQTlsMDd1d0oy?=
 =?utf-8?B?RmdET29kVTNmbW1NZ3pFbnUrVHVXS1NwQlhqVm5GYURlaFNxcTdEVGZ2Smo1?=
 =?utf-8?B?TFpybUt0eTlSSnVBTmtGeXVJSlBWcWJTVkUwK050YUp0eHVUSmIrS3RjZHpT?=
 =?utf-8?B?blYwWUdiT1hYc1NGZi9hRlRwdVhibENLZGZFemdLcUZudGQ2WUMxOXA1M2Zs?=
 =?utf-8?B?UGZPTXlUZEdBdmtkRHIvV3d4SlVXY3ZPeFpmTVRNdXVib0JKcWNsZWpHRDZJ?=
 =?utf-8?B?bm5ncFdqS1FGZHFzRkdla2JvT0lhUktmcUwwanRPWjRKTE9WKzdFcm1CQVpy?=
 =?utf-8?B?T0U2MXgxTXlSc2pjbFhmSEJpbnUvUm5TSE91VWhCUHlQQkxkNi9QcE1HY2Q4?=
 =?utf-8?B?SzRmcGVtVmwyS0l6TFRnMWxiREVXaVhqR0owR3BFTFIvRk0yWDcycU1KNjNN?=
 =?utf-8?B?WUMybE11eGNPdGE2Z1RCSVJWYi9WaWlQTk5DbHUwOElSZk1UQkVyM0xseTFt?=
 =?utf-8?B?azg1eWZ6K1owYWx5dkhOSFhFaTdUUE55Y1Y2QUM4ZzlMb2tDRkEwVmI0bTB3?=
 =?utf-8?B?L2FZL25YWlMxVFZJc3FyUzJCN0pkRWlJQ25zVk95Z1VTNU5uNFJWZnlNWVpn?=
 =?utf-8?B?cmhsT3U2UDN5M21IRi91Z0dxSklaR2YwcGJhSk02Smc4Tk01VmJXS2FzMncv?=
 =?utf-8?B?V2pyYUhyR3pMZkpIQ3kzZ2R2NitoaVYxWU5BTjF6MEk2L1hYa3J2azhVN0xl?=
 =?utf-8?B?VEpFbmlINW51ei9UTmI3SUNFTzIwMEVCbE1lR2ZCQnBrb09uYU5aVTJZaFp0?=
 =?utf-8?B?NkY4VEhNeXdoMkh4UmtvbFJKMFJTbk1RZkdHb05QM1ZwbW1uM25zNmlzV05q?=
 =?utf-8?B?aFUzYVM2Zi9QMGhyOXBERGZza3FzdXN5TEJKNUpoR3JYYXUxQ21oSDRZTTYz?=
 =?utf-8?B?bGVUV3RiN1VDSVlGN3RPSjZxRVhWdmM5SUdzWkpwWlVmUW5hdEJYOEZrcE4x?=
 =?utf-8?B?RjIyQjAwYm8reE9iTXJtY3NvY2tHeTdIMHBkOFFuVWtLaElSNVRTU0NCdDYr?=
 =?utf-8?B?b2tEZ0hIZy9uOTZsZ2tzbTRYMG15NjNzN1ZzMDhBY29CdTUwcW50bEtuTGl0?=
 =?utf-8?B?RjMzQW0vY1JPbVZ3d3ZQQXliaE15aVhHR0JWVzA3YndRUXJtbllOZHdwei9p?=
 =?utf-8?B?VDJ2dXd3U2d0T3hKRTVsakFqQUd4SUhVQ1IrVlNLeTZTVWZZc0Q0VTlCeEhD?=
 =?utf-8?B?dlVPNXNZUFhEd2x4TUc0amEzeDRaV2dLdjh4MWY4ek1MTFhCbzJaWU9HQjBv?=
 =?utf-8?B?ZzE2S1I1NjRTZUxaQXpjQTNNYUxsYTNyYnA1RDhJSW92NTdWWU8xUmtMUUwv?=
 =?utf-8?B?T0lxNXV4VW9HT3RjVzhCMzQ3YjBvMmJHRW0wMG1YeHBSTEljYmtrb0V1M0ND?=
 =?utf-8?B?ZSthU1RFYUZHVkcxWHFzT1Zmdng2ZnVmTFFWeEYyNkhLVnViYnpITHdhWVM2?=
 =?utf-8?B?ZmxQQ2RkZUl5bk84RnEzWmtmYm12c3pGMzZrWU5pR2VKM3ZXQUtGZllHMGhz?=
 =?utf-8?B?dTVETkFIVVRWcEgwNURleHd3UTdTcHhuMVBtQlp5TG0waDlVdmRYYzlRMXRH?=
 =?utf-8?B?bHdJL1BrL2YxekFmUjJZbU9XZHJEb0hrTVVSODkxNm9BWUZkN0VCWWdUOFFq?=
 =?utf-8?B?WEJDNUYvRzFqS2xLa29pM01zWkNTblliUkV4UzdjMTRpYktld0l0b0g4RUkv?=
 =?utf-8?B?Y3VXN3ozNzBpOEIzNEYyeWRBL091Yzd1N05PS2xxRmtya3NZQktpSSthL09L?=
 =?utf-8?B?eVozT0ZQSVIra3VYeERoZkVtZFlMNk9Rem5jc0ZoekxQRCtjT2dzZVpNNVkz?=
 =?utf-8?B?UFhWK2ZWR2FhalA0Kzk5aVJIWVAzb01CdlV1RDhzK3dSTHN6Y0pieFB0T3c4?=
 =?utf-8?B?WkNRbjNEWUhaWXR6OWdkaGFrZ1lwNjExdlh2WTc3eHJreWRFbVJjVVhKamdi?=
 =?utf-8?Q?2M3OUmwX9MYFgJF5RCkMbjsMS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb56ff1-4b3c-438a-bdf6-08dd155fc598
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 19:05:23.9360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg+rEvapyCaPusJkSVueBvP2ag8INcMtzafyijXD1FirqBIVO+LZ66TsF9wymKqxXc7FLkvWuFGfDoOsdWnZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
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


Reviewed-by: David Belanger <david.belanger@amd.com>


On 11/28/2024 11:17 AM, Harish Kasiviswanathan wrote:
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 3ca95f54601e..e0faec4682f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1504,7 +1504,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
>   					CRAT_CACHE_FLAGS_DATA_CACHE |
>   					CRAT_CACHE_FLAGS_SIMD_CACHE);
>   		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
> -		pcache_info[i].cache_line_size = 0;
> +		pcache_info[i].cache_line_size = 64;
>   		i++;
>   	}
>   	return i;
