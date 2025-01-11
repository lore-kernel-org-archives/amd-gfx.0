Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE5E77188
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2025 03:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2673810E1C3;
	Sat, 11 Jan 2025 03:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="duPmegxf";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFCC10E053
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 03:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUdwc0yFzXrlgYqRohpgYUZrp3YenSecca8ti8Maw2ZO1ufKidrirQngynKjqZTHIdfi6Np1VE7aKxjhF9rVU+29Et1es8pOzHYR0mRVNhESU1By4kyxsA5jxJegnpLs27/cOk7MVNtl8J+f+DPXAyc5ILurhTq4RmQl3quUUcm5gYnxPc0gGQi93N/lpaQ4/zRpdKNKdEYQPf7Wm0e47zTOYSBh2tvpMIldKocnLfg97Yve0xlhuFgcH3JYdbj84BHFbMqeqi5aWRjEp0HQDOZxLHKJl+X65+wYCY+8oqZF8rW9iKB6sdtR+IwpyC1BhZl3lNyU1Gcq/w9BMkNhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJP54xxCofA/oLr81AcAK3uPgIdUBdSfKw9+UBe9cZA=;
 b=EACY/fxrgLJGtnF7Vqwp7tA3nz2ZeAkQ5Ybnnwa/lsohzPScbiF/x7S19fUj/HAdwSPMu15YYU6soeKtoeWSi9krDhfoFSwz350qQOzZAo5Le0mviIGN5a53g8RR9B633Ml13Wa1cMa67b+MX2tiQDEcTLEb4LnTgcbSeKEKxZS0F5EUNgbL6QZSDM9NvHHq1i50mGnPCiOUSzdHr8ly6tt8GiqwoZwqoMmUIJwPPzj7pgdchYGfsuhy9QlstEE1JDuF/gnUQsgoypyb/hcl+xV4fEvriGF3Kv6PTDT7h0hY3Gb4moaoLkLC/jHscENW4NcD/yTDgxcmboe3N6a9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJP54xxCofA/oLr81AcAK3uPgIdUBdSfKw9+UBe9cZA=;
 b=duPmegxf+BVW+9apqnN5rR406bc9cmg3Tja2lFNzLMRGKCtGeMmmDlcEnz/fim3iJSUjU7aHMS8KHntf15isjpIB6dnnt9sTM/aUMY4OdLruuKcD/7S2CqjU4HslN8F8MQJ+THGWj7rzpxLCwWIOBmQm+Af/Cgl7PMd0v8Bo3vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.12; Sat, 11 Jan 2025 03:31:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Sat, 11 Jan 2025
 03:31:23 +0000
Message-ID: <2db62f0a-eefb-4dfa-9118-6c8edd79d754@amd.com>
Date: Sat, 11 Jan 2025 09:01:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: Fill ip version for SMU v13.0.12
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Asad Kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
References: <20250110201715.3828934-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250110201715.3828934-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::34) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 313afdef-d219-446d-c91e-08dd31f06c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFdnWlVzbVJsa3J1aGFScG5rZEF6N3B5dkpVZmFCN29sQzl3azZaY1pSY0Jm?=
 =?utf-8?B?a21oR0dYR3hMRmw1bDkvc0JVMGt2TEZSZ1MwNVlrak4wK0pKWnZDRll6Yy9N?=
 =?utf-8?B?OGZkSWxhWkVxbWhTdnFSWGxxVnlUMXhKb3UvT3dBMWcxcGFWeHNZTmpzN2xu?=
 =?utf-8?B?bnVQM1IzbmRwK3VRa3JRd2NmT281aGMzK1NQcW5aeUx0TDByY3FXdUFBRjRP?=
 =?utf-8?B?VjVyTDBDR3VpNHpZaWxCQ2k2Y3h0bFhBdTZkelZLMTdvOWNYdmhsZ3gzeXA5?=
 =?utf-8?B?M3RBWVMwUmtaaGZnS2hHVjcrcnVEUUhwQi8yZzJublFlanIwQ3EyODJ5UzFM?=
 =?utf-8?B?V2hTb3M0UzZqQTFPU2Y0L053OW8zY3pIeFo1MHBIVHBKUDBOMU9ORVdyb0pM?=
 =?utf-8?B?bHlOY0pDZzZwSHIzRUdqQVB6cVJoY3owYXhVcFJrUEYwbDI5NStjZldDcnE5?=
 =?utf-8?B?VGNma08xNVFrd3hlUThxdTFiSDg3VkZKVXR5dHJab3NGei9kT1RGaUhTMGVX?=
 =?utf-8?B?b3N6eGkweTdPbzZaZm9RYXlsTjRhaHl1bTZPb0dhVE5jL0krSDlIeTM1c21J?=
 =?utf-8?B?bnpXSU9tV201aytlRG5wNE54SXBhRmlJMDd2WGZKek53Y3JXS2RCNGdUWnh2?=
 =?utf-8?B?aDBEUTIwM2dSQUFLNHZNS1BPNlpKOU1GQkJvMGZoRzYwYy9xMHBDN0YwM3hk?=
 =?utf-8?B?c3M4OVl0WFRIQWJTTEFTM053S3kyVG10Y0s3V1p4T3R5TDhyeWI2c3Ntc2Fu?=
 =?utf-8?B?WjFVV01MeTk3c2FLOXFTblBDbWpKejVhNE9YcnJKQ084NTFwaUFMYVIvMXly?=
 =?utf-8?B?OVZyMUUzUmx3OWhrcTI0NmZ2NG1NL2JQVWZTUlJSN1pYYkRHaEZoZmh3MlhN?=
 =?utf-8?B?cnFYV3F4d3N6dEpOTk05K3plRkJUMFJISmFoanR4LytVTTRmdmtlLzhhMm5L?=
 =?utf-8?B?MWV5djBVS2hONGVncnFpWGJvc3YyYUtBN3dNc1RkVVlZQlJpTTB4T1ozcG5D?=
 =?utf-8?B?aHN3VUVOZ1JYVVo0ckZ6VVBpcExtQTBmYTVZMWlPelhJZjd0aEJhQUtyaGg0?=
 =?utf-8?B?SXdzTStYbE1BeHI3WEE1WG9mUVM1dURqem5oTlNjYk9ZbjRJUjMvT2xqSHFx?=
 =?utf-8?B?NlR3UmJ0cm9LZTEzWUsrWDRRd2hsQWNmWHFvdDZ0WEtMTGc0VnBLR1RxWmlG?=
 =?utf-8?B?U0xjaTZWVkFrUlNtWW13SnNpSXVZM2dHNW1ISFVlVDM0cU41SmRMMnRjc2hk?=
 =?utf-8?B?QXo2UFFMaklINEd4OGg5OGdNc2NDYUF1cnhCNG9XaWFBREowdXArLzBrTDRh?=
 =?utf-8?B?dWRlN2VwcWV6MlNZa0IyNjl1OGhXRGNrOS9wNGRYcFhLUzFVTTczTEVWd1F1?=
 =?utf-8?B?cmJuR2g5dzZrYkFoM0Z3Q1pSYTZUUFQvWFN3NXZyWWtPOUNDTEhjSFVZeGNB?=
 =?utf-8?B?V2hVR0xRb2JsYU9zTi9JOVNSaE95eHArMHQxa1RhdU5jMXBNZU03S2ViaGpR?=
 =?utf-8?B?QVBMMUcrUUVjWnArK3pBV0Z4WDVRK1pTbFBnMllKOUZubStHRnoxTDZGZGNX?=
 =?utf-8?B?ODlNa0lOT2VIdU5YTWtXWit1aEZoMjZTRzJWVjJ4eC82b0F2ZW9RZ1lKUms4?=
 =?utf-8?B?TWtBRE5jd2VPY0JRK05LUWkwcnordkNGMGxvRUNLVlVnTHBMM0Jmb1BGSXRT?=
 =?utf-8?B?TndqOGpncWw4aEt1REkxSEN0M2lxWU5hMUhhMExWbW5Wa21FazlVZzZMSWdj?=
 =?utf-8?B?K0k3UyswWVFWd05QbDJxRVJscTNMVnhRdThjK2FPQk9LSUJjYlczWGxOdzQ3?=
 =?utf-8?B?dURzbG5CMEFoNFdDWjJrMlN5NUszelREZVpjaEdFU1htaFJ2R3dVbUNNaEpD?=
 =?utf-8?Q?CEbcSK+bNECIW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitValBIVU8ydG1xZHRsc3dDMDZnay92a2czTUg5SWxUSWMxTEdyTVFTYWtp?=
 =?utf-8?B?YnY0aCtFd2FQRkc2enpScjFTN2VpMSt1TUJRYWpGVWlEZ3VFQllxL2VXZzlZ?=
 =?utf-8?B?THlwRHFDVDNYTHBHZjg0aHYzZkpYMklsdDZrV1IrdWp6WWRyRzRQZmNIYTND?=
 =?utf-8?B?YUtaVmJsRXoxRkJWNGVxNnVHZS8vY0ZtMjFLMjZMOFYraTQwTzNjdldwSXA4?=
 =?utf-8?B?NGkrQlBzbnh0THVVdFVzOHhQNU5TZDhBSlFEOXZLclpBUzVqRk5zUU9ZVGRZ?=
 =?utf-8?B?N0k3UE5KZWFBNTdOeEk0YUFqK0M5WDRCcnBsUDMwQ24zV1ZzbEpOSkpxRFQz?=
 =?utf-8?B?Mm5abzIyNXpsdkt4bm9nS1dBd1FESnFyTXVSOFRTRCs3RlB4ZjVGdjl2QndS?=
 =?utf-8?B?ZW93UjNlVG9tY0lKbFFqaURrOVMyakJQMWRsaVRpN1JGZmlINWtrQ0xCYmUy?=
 =?utf-8?B?c0tWTiswYkdaQktpZm1RNVA1djlXQzVwTU5EK0RRODVGMUh2eFR4bHU5YzZN?=
 =?utf-8?B?Nkx1OHNIcjNEalhPZktzb2tFaU0rMnB2eGVNdXpITnRhUVhxZFp6S21tVzFL?=
 =?utf-8?B?VFc3dXlGUEpJbHlWdWc3b3pLL2ZCZzA5SlkrY0U5MTVrWHRVTTZtdXJKb01P?=
 =?utf-8?B?RkhkU3JMcFBzT2xmNCtGQVdSTHMzbm0rN2ZLUzNxSFA3TEVla0hsS3U3UmpW?=
 =?utf-8?B?SWR6VkRmaTRDQ2FadlJNck5jS0JZeVhBZFczVFJLOWlNMHM1aG5GcitSNVVL?=
 =?utf-8?B?OWlJWnExZnplOVZvY2JWcFZ2bGJFcGZQdUhxdVp4K1krTUYyZUtlZVQ2Tlpt?=
 =?utf-8?B?YjA3d3JRN3Y3U0dveGthZ3lzUUtsdnBhZHppR09jM2gwR1J3TW9lNlZiNERZ?=
 =?utf-8?B?N24xYmtZemtQTU9KQmx0NHRHeHIyRm04ZnJLZUZEdkViZDkwMVoyQ2J2WmxF?=
 =?utf-8?B?U2x4TlhscHZoaC96TWZmcUhkYXNDRG9ZMkxKSEpGVThyNHI1TU56blo2SVdK?=
 =?utf-8?B?TzBNMHFPaExWMWc1TkFBZGx4d3VkT3dNOHlIOVVvYUNSeFBJc1RLNzFVcnJ6?=
 =?utf-8?B?dWZRM2Z2aDQ1VWcrTVlTNW05S1dOTk5kRjBvby85ZUhGUEhwQlRCbkJxcE80?=
 =?utf-8?B?cWVvSGVERERUamVTN2N1U1g5dmwxRG9HeFRJZG01OStzV1hkMXpYUkVJeG0r?=
 =?utf-8?B?N1Q4ZTdORXpHdWh2eitMOTJVN3JpZlhCNmgwS2JMRVorM0tQa1lLMnVlc1hn?=
 =?utf-8?B?aEI0ZGtmeG1ESFBjcGF4SGFDekFrNlduaGdnWmUzK1hGaEFWVE5HbHZ5UUN6?=
 =?utf-8?B?Y0RTbHVWeTZiODJWWURXdThjS1pRbHIxQlV3QXBFSXNDMU5STVkxNG5BKzNK?=
 =?utf-8?B?L093d2FQWmIyYWtXZTdGVnVITnJrZ2NKOHJhM3VLRDFVVWtlWGs4MUFiM2ly?=
 =?utf-8?B?VlRjZVU5WjhmVVJuYndwbTJ3eUthUXNzSURiemFZMDB5aDRGMnhnSTZOSFd1?=
 =?utf-8?B?RjhrRno2bG9TNFk1eFFCbVZDOVg3Y2xhNy9pNVBIbWxlb2hLSDY5WGRUMmt1?=
 =?utf-8?B?UEs1amRDQ1REMXpNS1BSL3psSXZ0OEZRb2tKWjd1SjNIZlpwdk1hNDUxTVhk?=
 =?utf-8?B?ekNlNU43UkdOWTNYbnVmWjBFT3BxYm81QndJWVh2VkdoeXFXYndTdHNkL0tR?=
 =?utf-8?B?YTJnMTNndjBGY0ppckRQejJiQi9CaXFZVHBuM2J3d29SUWFMK0RlZm5vZXY1?=
 =?utf-8?B?K1dWLzFPTm1HS05uN2V5bGxSeDU2NTBLM2JvTDlGenhhTVBNQW9tWHBMWWps?=
 =?utf-8?B?UXF6cnFWWmNQa25JV2RBYVp1eXF5aHJwa2MrK0ZFTzdsd2lCakdyR2Q0QTcr?=
 =?utf-8?B?R3ZBVkU3c09jREZMZGVSTkVkeWRLTGw5S1Z6QjVJaFkvZjc0Rm53d28rc0w0?=
 =?utf-8?B?NTlIWGFiVFI0aUw2QW1ZdGN6MDVpRmNkSEtoREErWTlzZE9UejZreWNiUkpq?=
 =?utf-8?B?TVVCWFJBeFl1b3oxRUlacDAxbHNQSXRPaE84dHlVV1NuM0FCQ1E1eVJONzlU?=
 =?utf-8?B?cldQU2VPR1VWajF1aGErUC9Qc1FZdzJLMnpvUWFhckRBajh3eXNKK2FVQXk3?=
 =?utf-8?Q?ib9tqYRkeir6/QjkGcJb+sDro?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313afdef-d219-446d-c91e-08dd31f06c24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:31:23.6360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kim+BbWvfRWud7U4em4voFKWnw24LELzi1SjUiqZvtfPbmRnep1nuUj2CRWKFX8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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



On 1/11/2025 1:47 AM, Alex Deucher wrote:
> From: Asad Kamal <asad.kamal@amd.com>
> 
> Fill ip version in pm_metrics for SMU v13.0.12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8ab30b2f7119e..045a1a814c2a2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -603,6 +603,8 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
>  		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
>  	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
>  		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 14);
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
> +		pm_metrics->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 12);

Please remove all if checks and keep

	pm_metrics->common_header.mp1_ip_discovery_version =
amdgpu_ip_version(smu->adev, MP1_HWIP, 0);

Thanks,
Lijo

>  	pm_metrics->common_header.pmfw_version = pmfw_version;
>  	pm_metrics->common_header.pmmetrics_version = table_version;
>  	pm_metrics->common_header.structure_size =

