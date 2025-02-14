Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC5C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061AB10EBF6;
	Fri, 14 Feb 2025 08:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JcdqYlZc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E0010EBF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC3YZ2bn0FzuMGLeeXjldui27K8j/LqI1hsMUBfB8+ruQVOuIa5GWqVpd/9B9ROdDkTS98fh5jw/79hueW5GtUzX+ZArwQLWnfYyk0az1vYObzYTcSLcygCSAosvBGZAc0+ly69s1ylbtj8nGNFQ+zzBtpNOrfXvyws1F7l+xTT6H9kmhu7v+wI75R00SsUEMayxMQxWJ+uyAqBFJU24BPlmP7HYUqCrXEQDOTudke3twCEvxAOgG4k4YrHg0YTdn+iVRnA8PRgj8frTTd4yJ1A8jEQuO8uSLvH0hMjb65AHRPvACBeJjfRv/4ThVl5iPxOV2JX3RqRd9yiBsR5uIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOh1fFwI6KbmE2w4qcmq71JEAO36/KhMZkpUHTigl3k=;
 b=RUw3X2Qirz9/dbUgC0xToG2BrdkZpMXlB9wd0cnSU2aDwUc+YAK1v09Uhh6jkWf8Q1vWDm49nOBwMC060CtuFNAI4WzXpcKwr+nTutRvBWteXuC54gQu3swc7tdOBPzqpZafI6P/znDhqxGojtToNGaWGEU58Wz3x7DHg/6pLVkFgkZ5X5maElhNFXvky5gdEdyDFoTJg0XzGHWBBx+GWutRwt8QwwaGQ9L4M3E1kgSH8FbC2bb4J4xZ1AnMFtNhgK6Oc6E7bmQK2ia0pPHCg0wq5/3UHNt9FgYXTKfHWr3eqW4uTZax0EFJjyp6ViLNLZH8FyOZsE9N4NkmyDGCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOh1fFwI6KbmE2w4qcmq71JEAO36/KhMZkpUHTigl3k=;
 b=JcdqYlZcMuxguXS+Zf0dO6vFVA8KVSQUOgdEJs9fBXg3IpL3Qd9z3yCtL9eIWfsq8kqNfpTsnZhruiI7jG9YFkY9tom4NGjQ2h1dUo9ARj0HtPv9m9TlUOOgt0D0wxVHGNus2sUE4em8WV4KWcCCyt4pwFsvJloGFSyTyEuRaDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:12:21 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 08:12:20 +0000
Message-ID: <612c9a72-f639-4ec3-b1f6-a355dea8b61c@amd.com>
Date: Fri, 14 Feb 2025 13:42:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Do not write to GRBM_CNTL if Aldebaran
 SRIOV
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hoarce.chen@amd.com
References: <20250214001348.4767-1-victorchengchi.lu@amd.com>
 <20250214001348.4767-2-victorchengchi.lu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250214001348.4767-2-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: f05b270a-445e-475b-24be-08dd4ccf4dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEg5andiVnZDUUpqV1BlRVNYbis4Q3JJUk9LTmhPMWJHdE1hVnpZR2sray9V?=
 =?utf-8?B?SjM4SFBLUFhjdFdWVkJjeWo0OHNJakVWS08wMWNad25XZTlGOTArV2dId1Fm?=
 =?utf-8?B?aS9taDFMaWZDNFk5dld4RGxUSzZicW96QXQvbi9QdndJVVFQOVN3K2k0YnJo?=
 =?utf-8?B?bFZKaFpzWlA5VmJIUHo1UnpyanhyWldsVzUweDVDM3BnRWliZE1VcDNyZEJI?=
 =?utf-8?B?MXk5MFF4aE16a01Uc3BRSzFxTGRkUTByM0hOamc2R0RrOGJKWjRudTBpZDk1?=
 =?utf-8?B?aktqNHkyVUZVVXVscVZiYlFLb2lqQkJlVWhyUjBWa25WM1VnNVpONWxoSW9L?=
 =?utf-8?B?ektwR1J1bEhvbnFhWDFvRUppbVU3WGptZjByelA4S0h5NXB1WWFqYktSWDhR?=
 =?utf-8?B?ZFBIcldKRW1rL1BaWjBKY2Q0NGpYM2NCMGdvR2lJQ291c2w5VkplWVZFcDYx?=
 =?utf-8?B?R1F6ZDg1a2ZzQUtFWlpNM2hzME55TnU4UEcybldTNFJJeE1BTk9pS2VUVE00?=
 =?utf-8?B?ci9HaC9DcE84bTRIbHNuVXlNNVhIZzZPRE1wcFViY0JVb20wekpwSmszT3BM?=
 =?utf-8?B?MDJRelNSYW1XRGQ2TlFLU0tMU3ZBVXdhd09paklGNlB2dFBaZ1daY283ZUlL?=
 =?utf-8?B?aE5LcVBjU1RtRGRsdUJVbXRXdUplWEd4UDdKSXVWTStFOWxPU0VoNHBBRlQ4?=
 =?utf-8?B?N01MTjR0Ung5clJzeTZCeExqdE54QXgyYVdBbmJFZmk0TlIxRGp6a3FvejhL?=
 =?utf-8?B?bk01NXcxMG1BUGwxMDFzTFp4ZG80Vmh5bWVCaTl6WEs1WUl6RDN4dG5KaHc2?=
 =?utf-8?B?cUFOcU9uSWF5NXMzRUtpVTdZWTd5Z3RJeGdvRk5yRDljL0dsZlJrOU53ZnpK?=
 =?utf-8?B?ZzRuL2tIemRXczFOWENTWjUzY0F5T3pmb1pwSzVidzY1MkcvK1VQT1EraUxv?=
 =?utf-8?B?U1dYd25TSFo0S0tUS21RS09sUkVQdlhMK1h1b05vYmtsZ2VLY093Q1JqbTU2?=
 =?utf-8?B?Z3A1NjczcUowd2lwQ2pqb2pTK1BoZGYvR2ZiTWQ4dFI3SERBY2xGT0VzUFE1?=
 =?utf-8?B?bzJ4OWFkdkNaL3lWMmVUaVE1cVRPMFNBLzNJb1V0dXE4MXF4Z3VnWklPK3FP?=
 =?utf-8?B?U1NOa29iT3VVRWxrZWE1b0d2ajI4K1YxQ2NEU3QxSHMrd0FsUTI3OG93ZVg1?=
 =?utf-8?B?Mit1WVJiMitVNlVmRUwzRGZRMHhyM0hsV084alpOM0RCRVNEWFF2WHlYVVZP?=
 =?utf-8?B?QUg1ODZDTGUyUnFFRzhPMVo4c2tuUUF0b1VtbjVZL2QxYUtjb2thbFpDL3hK?=
 =?utf-8?B?bDN4TVRqWGxJejBLbklqNm44ZEdlbUszTkpTRTcxeUFrZ2QyTnRKWTdqTTA0?=
 =?utf-8?B?S3AzM25YRVNXbVlnQ0ZKNFkzYnRPTnRhQUpiUXZmcUtaRFByL2hTbVFRYTMz?=
 =?utf-8?B?RERuMmdpbWR3bWpBVWVPS2dWM0R3Q0I1ZFIxYllIUWdOV3lTVmhqQ0RQTzIz?=
 =?utf-8?B?MU1LRHhYWGxERGlTQm5JYXFFeHMxTDhiaHVvN2hLbXp0dkZFWFltV0tScTB2?=
 =?utf-8?B?SFdKaS9IZlhXbGFkUC8rcUxjRUlyOHNLY2FEL2xpWUIvOFNnc0N2Z2NxVXZh?=
 =?utf-8?B?RXVlTHQ1TXZzVHJwREU0R1BpOCtUQXVkRktiQW1uaGVtQ1BJRlI1Sk5VS0sx?=
 =?utf-8?B?THZYaVBrckJ3dy9nRmJzVE9sbmZzS2ZKQ29iZ2pQTW90VTlHWW1EdVhjL0Nk?=
 =?utf-8?B?Q2o0UGJ3SnByb0pUUVdsNS9ac01ZU3Z6L25UK3RlWlQ1bURZcXFSUFd3R0Zm?=
 =?utf-8?B?czREUm5ZL09ibWtmczNzRGZYcm1zN1BVWG9OUmhCNWNhcC9IVzNWVXpBZklw?=
 =?utf-8?Q?HDz1zYiCHbDXF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BuVXMxSU0xeDFhbUpWWWYzK09Sb2RlenBoeVcrK285ZUNFYk4zY0xRQ3Qz?=
 =?utf-8?B?eVZFYVBVWWhCOGdtSVByM3pRWmtTOVZZYkNSa1EzMWFGVmJyWjVSU3hNWVYx?=
 =?utf-8?B?RWljc001ZTBuZEFGSkZLVDRZY2k1N3ZtZnYxRGM5dUxkREV1ZGVETWFMT1Jq?=
 =?utf-8?B?V2ROb21aTlNKNHZpNjI2bmM4YzliOVNIU0FmQWUrM1Q1NDkyL0x1KzUwN0dQ?=
 =?utf-8?B?UVF4aVJYQVpBdTJYVTAvdVRvVFZ5RDVPMmkrdUkxTnp4VFkxZ3BPNDRLVXpO?=
 =?utf-8?B?bDJ2RzdwSEdaRkVoWmtNQVpKVGluTU5McmhjTENaczhBTkYwZGppQ2VjbVpy?=
 =?utf-8?B?Uy9BMU1UNUJkV1BvWVVkS0FnVHRrSC9hcU9OeTBwbE4rNVNFenRYdjZsTTk3?=
 =?utf-8?B?bVVmeG1ZeFRsK2lWUG5FOUtmaTVQbXZPeU5DZjY5UnAyT1hCYTV1SGVHNm9r?=
 =?utf-8?B?aHphZzJYRFU0dXRrU0ZnOG12bXJYb2FjcksvcUdsZXBIT0tZcUEyT3lPeFE0?=
 =?utf-8?B?dVhNZHBSQlpyV2JySElHZnQ4Tm1icXRSSkovZjNTaTJlMmgvRjBMZTVKc1JI?=
 =?utf-8?B?VCtWWDhpdEtzT3I5NUZIWE9iTTNrUFI4N2lJNzNleWlmcW41VUVvUkVZU2tk?=
 =?utf-8?B?WlhsNDU5UGowVTJLTHRyUkEwTy9CYjZMQTRNa1pkV3ZJRWJpdFpMZzNkUFF4?=
 =?utf-8?B?QkVaVDVwOGQzRWk1Nk5IQThKSE8xWVZnNGxrQUdZQXBGZWZnZVY4NllDaE9E?=
 =?utf-8?B?bUZieE9Cd28wdll1U0pkenlKVm0xSVFkbjRLY2hNUGpjVktuenlGV2k2Q3Zm?=
 =?utf-8?B?SjcxVENDSTNlcUlhaWNYRE1kNXphMnZla2VVdm5ReWZIY2NsYXNFM3RJczNL?=
 =?utf-8?B?alJnb0M1WE9HeXFFRnVlWUNnVE9PV3A1eDJrTk5QWmFqd3RYb3FZTDFtbUlj?=
 =?utf-8?B?aEJYKyt0MUpzd05DcXpIMHVEaE5IcWh0M212UU5reEJQcjRVSDBTMElVVW5i?=
 =?utf-8?B?RGtEOGVnRGJvWjBpUkdNdTVaZ1BjR2ZBOUJkS3k1VXRNZVFEc21Hd2Npbk1X?=
 =?utf-8?B?SUtjV0hEUjhoVW05YVlJQjVpSms0d2xtd2NLQ2VGWk5GSEVwbHBlb3MrOTRw?=
 =?utf-8?B?KzhHV0J6dTBnWmRaeHFsdXJpV2RlbEZpdGY5ZTk4RDdqdDV2T2wvQlRTUERO?=
 =?utf-8?B?M3hzTEpVRkc2R2phMGx2RnhmaE9mbGJsODNja2htTlNGWFFHK2Q4QXZtMUV3?=
 =?utf-8?B?KzRkV0FoYmM1cFNiaEk4Y2FuSVpjM2hpMHlVdk81OXZwa0FwdmFKdCtudmJn?=
 =?utf-8?B?Mnp1eGw5ZjltMktxdWcvMUh0S0hrSVo3WmxhYWNZbkFKTmFObno4dWVuemJH?=
 =?utf-8?B?R1ptSjRLdEFvRVcwNzVWK0dSSkx5Q3lwNjdJYXExbzVoanZHSUxrQ0FmQk9O?=
 =?utf-8?B?cDJweW9HVEFDOXFsZ1pzcThvcncwVlZhN0cyLzBKV0hrNGJ1dGNiRTdnWFRi?=
 =?utf-8?B?WC9wUk5IK2FBK1JVS3RKN0ZScTRtd0RSak0wVFBac3A4NVVyNFJKSyt4MEhh?=
 =?utf-8?B?YXBJS2U5Y3o0UlRHV0RzVFYvc0NVcTM3WWJSSXNrUStYcmRHc2xERDI4dXF4?=
 =?utf-8?B?UWZyZFVrQ0o4V0ROTFlFUG5xU1NmM3hIbTkrajdhOERHOEZYekhWcWZwMnBz?=
 =?utf-8?B?Nyt2WFBDM2JXNEhIblRJVTc1MVo3VThLa0ozSktsMFZXU2E0cVVKL21kM2VV?=
 =?utf-8?B?S1VXME0xMGlYbTk5MnpEWDlEbWM5amhyWjM1SmtBcUt3ajJTd044VGxSR1l5?=
 =?utf-8?B?bEhVYzgwTjZvQlNneUhKTWVkVlUydXhhMGsvS0hTeUFQdU5HdzZVU1NUeXhS?=
 =?utf-8?B?U0FVQjROWjB0RFFKNFdJeFU3RHZRRk5YL1dRU0MydzhVRnhNaHZHdlUwMFhL?=
 =?utf-8?B?YUxnKzFGaHhBMnduUGswZE9UZmtxTFdRL0g5Ujc3d0N5cm5BT2lodjU2ZHRN?=
 =?utf-8?B?NDRIeW9rQXhBdlFtLzQvMmZTWkJmWGpNK0hvWFZMOE9QQWFQVWd0WE56NWt0?=
 =?utf-8?B?WDh0WXdVQUlsdXVRbWtqeURsWFJtQUxadU5CbjNPOEx0RUtQRm5xRitVeDNu?=
 =?utf-8?Q?FjwhsD8Bz5VgwLbWnH8oj7HXp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05b270a-445e-475b-24be-08dd4ccf4dd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:12:20.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5ydDtJ3G86I/J/1R0fmjMM0cqT6kjD+12XynmILL6zb9+Kat7tlh/xH4qgifFCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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



On 2/14/2025 5:43 AM, Victor Lu wrote:
> Aldebaran SRIOV VF does not have write permissions to GRBM_CTNL.
> This access can be skipped to avoid a dmesg warning.
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ccdfe7c37517..569a76835918 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2637,7 +2637,9 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
>  	u32 tmp;
>  	int i;
>  
> -	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
> +	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_ALDEBARAN)) {

Please switch to IP version checks -
	amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2)

Thanks,
Lijo

> +		WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
> +	}
>  
>  	gfx_v9_0_tiling_mode_table_init(adev);
>  

