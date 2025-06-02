Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7D6C5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 12:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908FB10E50C;
	Mon,  2 Jun 2025 12:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aDSecf2A";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1821210E50C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 12:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCU1awYy2A68DzqXwmQJiNq7Djn1IUh3lfQedKMeNKo4BgbeRZTOKmzdtIUIzCEg15JvyRGXWyuVeYeJe8/u+kZfqsd2/QmjP7RRBCb4o+rCiy9Fc5VoPImL0t+UOd9cb5nqbzle8Tdk8qF3UsAY4cFOk17dzp6Xpj+qowR30u1+2j/vwANv9Oz0v4Z7N4fPZAcs9jlUt/lFt3fYH+mki13+t/X+SKECqg8fU6N/eeeQLoZ4hrrbxWiQuSN4Xh3kW1FuTmr5oeaajSvtdhQWkMGI2tOOVNwPXV8q49kGNFTUm+tlHCoMrTKx0TW54KJDhssIi5dzEMaMFCRvXVtgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfbu4IjKsHTdr7r4eR4mpPbo9GF2TAW0u+ImDImaAaA=;
 b=qIKsDW3mwV0MHcgXgvHJS/As1r4nrQqPBdC6Jt8SaPmbNq624qMDlYoMZAQ/N5/ToY00zkSjU6AxDZoX50IGmcpdVfOO7TOS6LkmHipCld/FvxFJkcOceh/ioNVpV+yHvd2fmamyVr5c9glzHS8FjGkd7+i1uhHSnKxirqQQ27SgH0qvQTpEkFKcQcoik1t+UBBKXKuy9Xhl48dK0zKvGapajBwzDWJSMCQ9pJ+/ntu2IwG0aAm2L6UvnX0Lf/6jLHqBRCFfidcYgtTAOXSje6+DQmxhPqR0t6ZMT3uPZ0fLnI2TGyn4kYOsMs4VBmryjZcFq2o+Ktdqq8f236sM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfbu4IjKsHTdr7r4eR4mpPbo9GF2TAW0u+ImDImaAaA=;
 b=aDSecf2AeF4yP4MVp8GLQJFUtmVxorXn/4+xkx1vIRbod/rHSSo02BHHgagPTHpE3ZZNFFCT6GouKsEJXRRebT06jKW50vm78UFqqu9SgNEJJsXqNEhpUJ/CSVxwcb3MJ45i30ql38Ma+feTPC1WGhb7+42i60TzwRPnHtpV3QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 12:41:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 12:41:30 +0000
Message-ID: <f1a7656c-d374-4a44-83bb-a84eb8a8b9fe@amd.com>
Date: Mon, 2 Jun 2025 14:41:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] drm/amdgpu: enable legacy enforce isolation by
 default
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250529200758.6326-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dd896b-efd7-4dec-b5ab-08dda1d2cc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0I3YkpBTTVxZ3hOU3V2SW5EeWtYRFZleklOU0tTbEpYTHBTSkFlQkZGZFIw?=
 =?utf-8?B?TWQxcFAzSlp3UG13UnZGY2tTRWtpOHBobUp0WDBhbkJHc2dsd1p2VW0xazZO?=
 =?utf-8?B?K0J1WDR1bit0clMxMWNST3Nsa1lkVDB3N04wVVJiTnBUeHFnQjh4eEllMTU3?=
 =?utf-8?B?bWVwdllyakZ3YUJqSzJZSS9ya3ZmTFk0UVp6MXVydHVCMlhXemMrR1g1Skh5?=
 =?utf-8?B?dkt3UkMwbWFkd05jbVhmcUxtRDBTMXNRMHdFR2YzbFpPKzN2bVVONE1pZk1Q?=
 =?utf-8?B?SnJzYjk1bTJ4Rlhuak1USVY2SVkxbVFlcnF5MmJJZHhXY09RUFBlbHVmVHVZ?=
 =?utf-8?B?N2R6VXZ2MkFRdEFCakhZUkFGNGhqRGNQMjRBYS9pOEdIY2wxOUo3TVZJaXlZ?=
 =?utf-8?B?bTdxMFFiZExOb1NpRVYxaHNpTElyclZIOFF4VWlpU1pmQTl6dGFtMFU1d0dm?=
 =?utf-8?B?QUNPaDUvV3M3VFdJS1hoZTI1NlZTQ0Y5bTA5cXhDdW11U0tPKzdMMksxUGtS?=
 =?utf-8?B?K0dicGRTMktxZUdDVGtlZk11MVlWRlM1cXhyNm1tMW1pWHRNc2srdk1CQmJi?=
 =?utf-8?B?L3ZwYVpFa2tPUXE3cmIrOFZUNzFkTVE3eGxselNHRjRGY0xJVnlMRFZRbFNB?=
 =?utf-8?B?MDFZMlEwOFV0TWlibHJyK25aMThsTUY5cXh6S3MxVDdIV1dPaDVReWVzSXhX?=
 =?utf-8?B?RW1od09CUUtjb08rYWpsNmYrRk8vSkYvWDFWbjlpVG41a1VIREU5VjVPYXVR?=
 =?utf-8?B?dFRVdjlyUE9qUTNXSTR6REt3b20yVnlLSnNKUFI3THQvYWptZWJKVTMwRWwz?=
 =?utf-8?B?RThXMS9ON0JoeHNIREtLdVpUVkQxV1BnN1EvZmdqK0dZMCtZZkNLcmI1QXdU?=
 =?utf-8?B?SkRjazhUQWxISE1XazJ4TUk4S3l0c2U0OHB5MTNWL3N3QkpqVjk0QUo2K0tL?=
 =?utf-8?B?UWZwcEYzMlVsNXNiL3lRK1BnOVpHWXE5VEtXRnVuOWlxcklOVDduZ1Zpenhx?=
 =?utf-8?B?YTRna1N2WWlQUEVQN05WdTVsdlBNMFgwajNiUFNmTHVXSFNjM29QU1RrTUg5?=
 =?utf-8?B?NTYrek1TVHlMTllUZGxiMkpyb1hpMWs1cFBJYkRFWmg4YlZxeFRtNExPWkhZ?=
 =?utf-8?B?R0c1TmxXV1hrcWJIZjhDWFdyZFJ2bXdHMGxyNGRJL1dWODFCQ3lVQ0d3UmlN?=
 =?utf-8?B?RTFLTWZwVVVsVVhhTno2cDI0aGlqNDlaOFBhdTUzL04wa1l3SWs1QzJ6VVQv?=
 =?utf-8?B?bC9Jb0MraG9CdnM2T3JjL2FkZ2ZmOVRuelZ0dFJFUmVpTnIrRXVqK2xZZ0xM?=
 =?utf-8?B?eGFIQi9Bd00vaFV4MzNmMTg2bUZiUC9ROWwwUHlrd3FQejRBSlFkaFlIdmcv?=
 =?utf-8?B?ZTNadmZyQlBaWVJQc2RBWjhvRVpuSzNtRE5wVnRxalZERlYyUmo3THFkMWJ2?=
 =?utf-8?B?ajNPc0xsM29WZHI3cmxnQkRmb3lOMThnNDBpdW44cFh0Q1RweWhkZUFNTENI?=
 =?utf-8?B?NHRqdldGS0NWOXZZeWxMdU5NcGtaOXhmbWNTWElpTGNNOE5rQ0JNZGU3eXJ6?=
 =?utf-8?B?RlZ2U0tBMW9lTDRvSzZvMGgrek41ZmRmTVJQSlNjR28rMjBHeW9MQUdyWkJD?=
 =?utf-8?B?NG1YUUlsTDJEdE82NkRIMXR1UXpnV1VRUkNJZEIzM0t4ZjBxb2xnMjVSVmE0?=
 =?utf-8?B?R0VSaENvWWVQTTExdlRKamhORE1mVThqVzhzQUJBQndUcWZxQWNFNlVKcmh0?=
 =?utf-8?B?VkRVbUhYZDZlMFlhS01sTjhJUU9zOXZwS2prS0pUdVhyd3VPN2wxTTNhNWZo?=
 =?utf-8?B?Sjl0TURBaFZUaEhCOWhoOTV4YnRnSFhtNmlTUTFrM1orRUU1WkZPamhRNHNU?=
 =?utf-8?B?MmV5SUxqZExSNERGZ2RDUVM4MlFxUDNyMVlPQXZUU2RuU01UMW9hU0hzeHdY?=
 =?utf-8?Q?h8uteV2pIR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZxTmozUE45SzAyUGQzVnAyTjJNTUNGREJzVFVBT3NPMklZKzY5SXhYTGx0?=
 =?utf-8?B?aEh0TWJZUFF4RnNzdlcyeXNKYzd1VmVuWTVqWEtjVzBZam4xZ0NpZ2xOYUhu?=
 =?utf-8?B?cmR0dVFTYW9ybXp5cnJmd0RsNUNCajBLblFkQkk5MW8yUWhuSExIQ1l0cGZG?=
 =?utf-8?B?MjFVejREWCtNMTlmUGkyYkpuMzkwS2lKVHdKMjZ0QWFOeUVhcDU0OTAySFRK?=
 =?utf-8?B?WVkzVXVzaW5QcVVFV2Nvc3hkQTVzOEdvT1hHRHhvaUN5QnVJcGtadGNjdWJv?=
 =?utf-8?B?dUdHWDJUUENEZkJJNnpXd2Q5Vk5tK1J1ZU1zUjhXc0dOVEU1amJDcDdwVnJQ?=
 =?utf-8?B?QUdXQUl4ZXlwMU9Mdmc3VDdDUmo2TUNCaThoVWhld0hkTW9aTkhKbGFkSXpk?=
 =?utf-8?B?SVF0TGlzbnMzZEtqN1JLYWtzR1VpeWZob0tTRUo4d2VUQkJ6NFpYTklzMy9s?=
 =?utf-8?B?cHU4czE1c3NXaXFLVS9rclBCQTBuaU01Nk0xVlJqb2djU1gwMlpSMSs1eFls?=
 =?utf-8?B?elB5V2RJazNraU94akJGeXM2bUlUVVVCWHJJeTBEa1FDRy82dmF6N25yOFpO?=
 =?utf-8?B?SjVFNWVqc1ZETWM4NmsyNVVFS2VIOG9NMEN5SHFaWFB0ZUh0TWpjWTNNQ3pl?=
 =?utf-8?B?LzFZajVFM01Za3ZqaTQwR1FyOTNTb3NGTnExTUZPa2FrMFc4VVZ3cFdhbU1K?=
 =?utf-8?B?U1ZhcjhjRllmc052UVIwK2JVOTQwQVVQbEl6T2lpY3I2dE1NNEQ0SGsxSjFS?=
 =?utf-8?B?eEdWQytWWk5IQWZoUW1pWnBUUzZTMERXWStaMnVkdldqSjYyNUczQ2xwZmc3?=
 =?utf-8?B?QlYraHdPcWRQbjBjNWo5NkpyYnlxcUdnREY0S3V3MUhHa0hJKzZVZTlkVGl4?=
 =?utf-8?B?b1dnL2lmMEErZ1NSVm5XOHp6WTdPL1A2b0NVeGVEYUJrM3VkZUpQcU1jSm1j?=
 =?utf-8?B?c2F6d1hLTmsyTDdwOEx1YWlEM3VtZXlqWHJSZWZsaW1uZ0ZGbjV2aW4rbEZH?=
 =?utf-8?B?UXJ4eVZHV0F3ajRtZHlzemxQenRQZWRMYlMrYy8yWENPb2xJZTcyMUk3VHEy?=
 =?utf-8?B?SzFRQVBlS1orTDgwMGJmRGU5c09VZ1IzOFRxbnF1NDAzaS82OE04YlFoU0po?=
 =?utf-8?B?cGtScldqUFdjUW1UbEtlei9pbTZkY2p5dmZwOW5QWGVBZEdhMWJvcVd4UEE2?=
 =?utf-8?B?ekVRdm5TaHVhU2tsaTNCaTF6UWZqQXE0bGsvaU1WNExKeDR5TFM2aHo1SnRk?=
 =?utf-8?B?cEFBMStDR3lDMHArSkthUHJMQ1dTbG93MnpleXBaMTJONjdhblJmNkJhQnkv?=
 =?utf-8?B?Vlgrb3FqbXNTUjFoNkNDMVowL1BVV2lkak9pN3NENUdId2loTVYyRUNHbWNP?=
 =?utf-8?B?Q2VLUkUwdU5zWG5QeUh6Mzkwd0h3Y0JPWFJPSGJaWGtNcUZTc05BUEJrYzln?=
 =?utf-8?B?eEVWcWVYUXRuNndDL3hRNXpHRXFrNThiekhnV1NGU0d1dDE2VHBlSkZ3SWMx?=
 =?utf-8?B?SUQyL1FmZTd1QW9saFMzb0h2NUR0eUF5MlZnb3FyVHVlS1NIMEtUVWJzOGVQ?=
 =?utf-8?B?VHhYd1ZSeUdUaVBIVmwxZHFmRy9xWnVBUUFQeTh6V0EzYWdMK3M4dEhHVkN2?=
 =?utf-8?B?Y0oxVnZLTUhNd0VaVHhWSlBER1FMWjVDQkROQkU2OWtEbWFXak9wVnF4OHA0?=
 =?utf-8?B?c2VnNTJKeXdEaE9ydkpDR0NuVzRpZk1uRUZLOC9YOWZUWklWTWFvN0tBNE55?=
 =?utf-8?B?a2VCVWxWeGI0YldJcHFQSHRqM3ErOXlsaW9RaFRiek5tdEFNdWZ5RGFHcXpq?=
 =?utf-8?B?TEVCYURRc280T0FlUEw3RzhoRFU4b0JVdERhWVAvK2tkVWoyMmdsbndjcTJX?=
 =?utf-8?B?NlNXV1gxZmNPd3J2b1ZrYWt2UCtEcDFwbjA4bHFTNGRGNGZoenZYZGhqVkR6?=
 =?utf-8?B?bTJWVUhsZWtYYmpMOUlVeEFKYVl4aStkWjVHSTYwaldwZkx5NXRSMFRqMEEz?=
 =?utf-8?B?NlFyNDZlSlgyOWpZNGRYd1hjVjB4WEY0Z3lhVjBhdWd2WTNCWUUvZkI3aDYr?=
 =?utf-8?B?ZG05cFc0RW9YN1o5VHVQYVFZU29nd2Q4Q0w3Y1NMSCtvMERSd20vSnloczZV?=
 =?utf-8?Q?DVoi1oPDwpnySZLaSfFgr/0FU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dd896b-efd7-4dec-b5ab-08dda1d2cc30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:41:29.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARAUWlbBqSKvos0bGKWs3AIF21TNgggLsje7ro25dxbVYSMbmFkuJ2pssULirL+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

On 5/29/25 22:07, Alex Deucher wrote:
> Enable legacy enforce isolation (just serialize kernel
> GC submissions).  This way we can reset a ring and
> only affect the the process currently using that ring.
> This mirrors what windows does.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Yeah, that's exactly what I wanted to suggest after seeing that you wanted to do that per GFX IP version.

Reviewed-by: Christian König <christian.koenig@amd.com>

But we might run into complains if people used compute for background jobs for some reason.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 72e41781afb06..ca882e3d95bb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2148,9 +2148,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  
>  	for (i = 0; i < MAX_XCP; i++) {
>  		switch (amdgpu_enforce_isolation) {
> -		case -1:
>  		case 0:
> -		default:
>  			/* disable */
>  			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
>  			break;
> @@ -2159,7 +2157,9 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>  			adev->enforce_isolation[i] =
>  				AMDGPU_ENFORCE_ISOLATION_ENABLE;
>  			break;
> +		case -1:
>  		case 2:
> +		default:
>  			/* enable legacy mode */
>  			adev->enforce_isolation[i] =
>  				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;

