Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DD9D2E01B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 07:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4575910E75E;
	Wed, 23 Oct 2024 07:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aX+yXpnt";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E577810E75E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 07:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX5Z26tcpH+6vOr4tuORE0NgWhq1ypLZp9UrBAoYn4x4HG5uB4jJYfUFos8RznoIf7TVk0MGbLYvxMCYEhPdBQnF/JUNXKQv5SSPOq2Meyqe3u1WyYpjxCf3ChIcHm6kn0Pxy6lYyxPyfFdyoNNwg24s/Tj4YqpXcNGxml/kb0PspX19sNYOi5oi2RqX8jow/PCgdW0iPBBF+6sKjwss2t+fkoAl+ZDbnBVyKh+Onp59QyZGvfPOL/JsahWcDBKYeCiweoNz5stGC3TPLolbrr1E1a94XE2GIHtzkt30AHizNtNMAoz5/Dc0uJGmWAKwYE/i14Q/O1Aa1ah1j7RkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr/k6dGcvwC8vJxnbyDHtmFIu4+MPtVD8OOE/ox2Nhc=;
 b=WwFHF/OoyaM5zZLXHzdXhaXlQu0rfbvpbJYLsDlN/UcZiBvL6sFYYYDYKXpAAIklbfWpJvdOr3nqxjfmNq4UF3P0CN7gpwYe27hN4WZvBvnuR8enV6S9pS/glZg3jyOD9J1nbfAaYoAPFkq3p69vbi8v3TlF/it1TaaGfM+P3wQvh7Ileo9/ThGczfxp6UDjSlvbOFHb96tlaUYyeK8QIWFu1GVCdUipHfDhfZayxtPnH+NRzVh/YaIB+zEoWGRjAv9u6VHEUNzgGPdOJj6d4RfrF2ZlsYiiiUON/TYXxv/uJrMty63XBh+QJ/Q8tp+bBbqzEGokub/75EWxTPsM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr/k6dGcvwC8vJxnbyDHtmFIu4+MPtVD8OOE/ox2Nhc=;
 b=aX+yXpntbEK1nZijE4cocmhKaLVYHR5NJG2SUuK2gpmfovN0gWV0wlbJImyo3CdRBGhKjkOREgIVbNQNh89f+PsOrj9R9Z5sGyjxKDr/xEoSkDbIDqRAFeP5OlXNSwIakAdNQZmH2DA/GG/uUi8hjwMIjl7KtuLx38Jea6gFXhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 07:11:17 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:11:16 +0000
Message-ID: <f1445355-ce06-414b-b824-373db7d2b29b@amd.com>
Date: Wed, 23 Oct 2024 09:11:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5 V2] drm/amdgpu: Add sysfs interface for sdma reset mask
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241023024337.2578496-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241023024337.2578496-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 934de82a-1591-4597-2d1c-08dcf331e2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm5aYUF6cjFubU5PTHd0Y0hZZDBieWNxSjQ2MUQxU2g5TG94clpWMTJTUE5y?=
 =?utf-8?B?UnlZYTBYQ2lzNEthSGF1QTh0TXhvV2hUZ1RqY21ETVdldHFsczNlMkIyQ29F?=
 =?utf-8?B?VVV6Z0JkTFRvZlgzSjRaNkJodHcxNzZXQUtCa2thSGl0Z3VqKytJTGV1WkU2?=
 =?utf-8?B?NXJlS2d6anVuR2NSbDJwM3FSdHRkYkpxckVLQUhNUCtjU3BrSzkvYTBvbXdC?=
 =?utf-8?B?OCtCaXVDY1I5YURtckRpUlFoUS9INjlOQXVseEJudkVsS0V3ZGlYaWlkN01i?=
 =?utf-8?B?MXphNjJxTFBsUml2aXVtMTg2OURNOWFZNzY2bmliZ1hnVlNRUkZHbit2eUtx?=
 =?utf-8?B?aDVLV2tMTjVCbS9rY2MyYlIyS2xLaEZjZWNIdlVXZitOcDRFd29OblFnMlRQ?=
 =?utf-8?B?WDdEbG5yMitUbk13bXZLakZhWmx1a2RlM0NXYnltdHpicW5XeWhRSlhxamw5?=
 =?utf-8?B?NDZmTkdJMnJKTkV1ZldHdTVveFZMYlE4QzJCc2g0c05iM2pFY1VIamwxYUdo?=
 =?utf-8?B?L09CT1YyWElHOG5nZTh2REg2SEpTQUd4SzNDT3ViNTRaUDRKOXlNdVQzQkFu?=
 =?utf-8?B?V3EwRkVsRHhLbVVtKzhEYVRVYklaQmVySlZrMnF2NkNwZUhTRzN6ZmJrU00v?=
 =?utf-8?B?NGV0SlMrUnBPOGFoMWpvZUU0UW9NWEJkQTkweU9SVGRhVWs5WWFvaEhxa2Er?=
 =?utf-8?B?RzVFRCttTjBzOVpxYzhjSnZXaE8vc2pRV0Q1cS8wYjV5OW9PeFpoYUtZeEpk?=
 =?utf-8?B?MTdtUWxOZi9UakUxNjlvNEJRVytaT3Z5RCtkOFVNalo5aVZNZjZOTERqN29k?=
 =?utf-8?B?ODNRaGZzNjYzUGwrSUlRNXZTcmVsT1RJL0pIUFZNT3lYeGsyKzFqc2h6a3Rz?=
 =?utf-8?B?dVdaQzZSbGtXenRlclozR09tQTB1SStsSmROd0tidUNLd2YxODdaT28rZjM3?=
 =?utf-8?B?bkxWUEFmVDV0VUpONkVBNDhtRDJTWVF1VTlHb2lKOXArTXRja2JXRzlBQWhi?=
 =?utf-8?B?ZWhXbWEyQVdkSGVERzNrOTVYNnhwcGVpOHZLUUx6ZXlRcndXRENkK0xhN1hL?=
 =?utf-8?B?QzJJTS9YM043TWNjYVM4YWtDbmd2R240MFRUTmw0Z3RPRlhSbnhzRUdYMWR0?=
 =?utf-8?B?QW5FVUJ6OEdEMjJWVHlNQnBHQXhFTkJrSm1XQngwR1lKK2NIYWMrRnlsbXRy?=
 =?utf-8?B?em01c1licUFuQzZjSlpxZXEzalVscXVqaW9HdXh0UjVyaWFiTU80dUZjT01L?=
 =?utf-8?B?Yzl3YXZKT0NzZW53MStFci9vOC9GVkhyYktib2RHeGtnUVA2WTJFZERjaHg1?=
 =?utf-8?B?Y2ZmaFQwWFRuckVmRXdvaEJxRk9aR0pZTkUzUlFvSEpydGVGalQwMW9GNjha?=
 =?utf-8?B?VkNEQ0U0TmdBR0ZnZERYQllSWnMvOXJoeTZQV0M5K3ZPWm5xNmpidGMxOUZQ?=
 =?utf-8?B?a3JIeEwyZmU3alg1UTNOMWl2OHM4YTZwQ296UVEwYWRGcE9xRmpmVWpuVk1L?=
 =?utf-8?B?YmFaUS80aXBDUTRyQ0F6ZlFaUW9qVUVEdmVCSnhZcU5MbGVOTFVLUERid2tJ?=
 =?utf-8?B?MjYrdFRxTWJXSG1vZnhOdDQydHBaNnNXVFJYbnRBUTI4ZVFRbVlrc3Nld1BJ?=
 =?utf-8?B?U0VncUpjekU2dFM0cEVvUFRWREJIUW9NTllXS1ZEdXVpRVM2YmxhOW1xd3RT?=
 =?utf-8?B?WFlXcjRZcXRlRHp4V1JzK1laVS9WVW9kTHgvQzFDYkFFL1lycFAyUm5adDZL?=
 =?utf-8?Q?/q3MxA0WJ0I0kMWtfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDc1VzFDdEJKOFgzZWgrZFlDcWhKckdLaWJyU2VqWEpwdlRJZjY2Ny9HOW5l?=
 =?utf-8?B?enNvOXNZQlo3V1hmWWJvTzZLMU0vaDlhcXpaUXQxUUZ4NmJnWWxycUoyYzAw?=
 =?utf-8?B?Z0dKbk5uUmJLSGsrU2JTZmJVWkJkR1FqREoxNlc5dHRGMGJlYjVaa1d4bWpy?=
 =?utf-8?B?V1NTVEoxWVhOeE9NQnd6MkpNR2xJS3NhUXRjSzk0ekNpWmJwUVFIMUtxR1Vh?=
 =?utf-8?B?UkVlRmN3TVVXelNMNkxzZmZhaW1uaCtmOHdWclY2VWwxRnBlZURzNnI5NzJJ?=
 =?utf-8?B?dTBjVGNiUi9kcStGM2RlUXBHeUVRT3lzVEp4a3dvZ2JzMVp0NEdiT0E4UnVH?=
 =?utf-8?B?dGhlZUtVSnVmKzJKangveE9PMTE1TE43Q3hEb3hGN0pMMlJNaGF2QmpuYWtQ?=
 =?utf-8?B?aHBFK0ppTjh5R05jOFFRRi90ZGhYRXpUbHByOGVYVlBQbmkxZHNpUkdXTEZ5?=
 =?utf-8?B?TXozbDcwSkt4WHFWNGdObWFtOGZReDdQY3E4RnI5ay8rWUwwT3JTNmExWTFS?=
 =?utf-8?B?RENoeFE2RDFVeTZxOE11eFl4Q0ZxbCtXcjJBUUl5MUR1bUk4NzNHdS8wZm9Q?=
 =?utf-8?B?WkcxM3dHQVpPRXRDWnlTS0J2bzRjYStpTm40RzNoeHlyR3p3M1cvR3lVZzk5?=
 =?utf-8?B?S0U1akdnWjBlSmZ4NmhzcktGUWx0L21rM1dGQ3ZGVElVb2lhZ1NCUWlINUx6?=
 =?utf-8?B?eHY1SmZZb3dRek9ieGxUR04xSVROdDBpYkFGaTJZaGpkTkljYld1c2lBZSsr?=
 =?utf-8?B?cnRVb2drWEIzYXRkaXFpU3NOeEJuZXlTcFZ6SDZ0MnpsL21xVTRuVGE5K2kw?=
 =?utf-8?B?c2VOZWlucGVCbnhFa1BaSkFuOTB3NXNTd3ROOHNZQjhXU0ZaVzA1eWQ3c2t0?=
 =?utf-8?B?R2cxV1pVeXhRNjhiWFFMSWtDQjZGcXhtZ1VEbllFc2RRMFJWR25Ba1FrY3or?=
 =?utf-8?B?N2wrYkdVN1A0QTZxNXJUbkVQSmg0YmZhaHdwK3k5aUIyeld4amVqN2MzTlg3?=
 =?utf-8?B?aHRrQ1BFSDhrcVBiK0w3TlRtb2p0WGgrTWdvdUJMOUJybWhtU3RxTkJTSEww?=
 =?utf-8?B?S2pXL3hRK25NNEtFd3VsYlgrbkc4ekNnVUNnV1MraWJCbWd4UXpVeGpmeGh5?=
 =?utf-8?B?WWNGdWtLZFZ1a1NGZjczekdGQ3MxcUVoMVJMcm9LWUNYRnV6RG44SGxKSUNW?=
 =?utf-8?B?VVJjUDJCbjVqT2FFdS92K3pIdkhYMnNuVlVyQjBzQ29McEQzT1YyRDUybnhX?=
 =?utf-8?B?QTFZaTJrZFdyeFJOOUdGODdvQUk0T0xrSmRtL0RQelpOTDJsVVZZVTJta1Jp?=
 =?utf-8?B?OXNVZjVIQzUzdklPMW1XanZpbWgxUGd1aGZxWFJualNFWVdxL1pHai9wWEhF?=
 =?utf-8?B?UTgxZmd4SEV6ZmlGM3l4KzNsSVNaZlV0VGlwUjEvdmpxS2hDd1htY2xLVFdD?=
 =?utf-8?B?ZGZIS01mNzZSdndRbjBNUmtENkczVXhjcFE4WUpFdmtuZFQxc3VMUGJBR3JK?=
 =?utf-8?B?eE04MmplVjU1VThZa3dkNFd3R1U2cGk1V3VZOFgydW96bWV2Rms4QzFMdUow?=
 =?utf-8?B?cWhJd0ZCV2JLL0dpZGhpaFRFaDk1MU1rTVhleHdCak1BQmNyYmRvdkltVkFv?=
 =?utf-8?B?dzNoR0t6M1lUdmZNVXBSbzZLYTBOc1JKOTFxRGJXRFlIZUNOYTdLZitPbnhy?=
 =?utf-8?B?Ynpsa3FtRDkxMEdBODhBbExQN3gxemM4NWdkUFpyTGhxeDdKdUtKY2NMR1pS?=
 =?utf-8?B?Q3Q0b1czTHlFcTdZZkZmbDYwcmtuOUtGMC9HMUlITGh1Zml1WmFPbmtobE91?=
 =?utf-8?B?VXU3TE92dmhVVlVFNll2dWtpbG1uOFRLa1kycEpZQ3ZOQ0pTelVCODlMb0J3?=
 =?utf-8?B?a0x0QkxMSldpVFZDZlpGMUdxMVlXazAvRGhldjc0UXVLbnN4RnNXQjdjamRH?=
 =?utf-8?B?QlVnSEU3TDZoRnlrY1lNZlVEczhVWk1IemFOWVhGWUxBVE5ZYzJrY3V5cVNM?=
 =?utf-8?B?N3A3Zk1ES0t3WUNqS2ZOeWdKakhVMjh0TDl4dG9iaHNMeTZndldrdVpEaEV3?=
 =?utf-8?B?YkhKT01kRXNGVDJucWIyWXZia281c1Z2M2VGTWp1THZaaWtrbGFUYi82V0M0?=
 =?utf-8?Q?vZ/nNqRaXlxgIbHyWmtSEWyUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934de82a-1591-4597-2d1c-08dcf331e2f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:11:16.8990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ijofdcFmC2K65oNcCv2iFrcf5wDenDi1hlSwz3sV8GIdfvFqWJ6b1NE8p3O01Bo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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



Am 23.10.24 um 04:43 schrieb Jesse.zhang@amd.com:
> Add the sysfs interface for sdma:
> sdma_reset_mask
>
> The interface is read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc),
> soft reset, queue reset, and pipe reset.
>
> V2: the sysfs node returns a text string instead of some flags (Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by:Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 48 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++
>   10 files changed, 90 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 183a976ba29d..f20b7285f5fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -343,3 +343,51 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +static ssize_t amdgpu_get_sdma_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	ssize_t size = 0;
> +	struct amdgpu_ring *ring = &adev->sdma.instance[0].ring;
> +
> +	if (!adev || !ring)
> +		return -ENODEV;
> +

> +	if (amdgpu_device_should_recover_gpu(adev))
> +		size += sysfs_emit_at(buf, size, "full ");
> +
> +	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
> +			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)

A total nit pick, but the indentation here is wrong and I think 
checkpatch.pl might complain about that.

In general the Linux kernel coding styles says that for "if"s you should 
indent with tabs and then spaces so that in this case the && is under 
the amdgpu_gpu_recovery.... of the previous line.

> +		size += sysfs_emit_at(buf, size, "soft ");
> +
> +	if (amdgpu_gpu_recovery && ring->funcs->reset)
> +		size += sysfs_emit_at(buf, size, "queue ");

You could add a generic helper which takes the ring as parameter and 
prints "full soft queue" into the buffer. Patch #1 is kind of special 
because of the FW limitations, but that should make patch #2-#5 a bit 
smaller and use more generic code.

And should we print the strings in the order they are applied? In other 
words "soft queue full" ?

Apart from that the patches look totally clean to me.

Regards,
Christian.

> +
> +	size += sysfs_emit_at(buf, size, "\n");
> +	return size;
> +}
> +
> +static DEVICE_ATTR(sdma_reset_mask, 0444,
> +		   amdgpu_get_sdma_reset_mask, NULL);
> +
> +int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	if (adev->sdma.num_instances) {
> +		r = device_create_file(adev->dev, &dev_attr_sdma_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +{
> +	if (adev->sdma.num_instances)
> +		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 087ce0f6fa07..3058548d0733 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -175,5 +175,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>   void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>           bool duplicate);
>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> +int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
> +void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 10fd772cb80f..bd04310cb2b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -863,6 +863,10 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -874,6 +878,7 @@ static int sdma_v2_4_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	sdma_v2_4_free_microcode(adev);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 69fba087e09c..1fcf7e977143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1149,6 +1149,10 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   	}
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev)
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1160,6 +1164,7 @@ static int sdma_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	sdma_v3_0_free_microcode(adev);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index c1f98f6cf20d..19fe25cbb24e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1926,6 +1926,10 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1940,6 +1944,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   			amdgpu_ring_fini(&adev->sdma.instance[i].page);
>   	}
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 2, 2) ||
>   	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 0))
>   		amdgpu_sdma_destroy_inst_ctx(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c7cea0890c9..320b1e63b78b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1442,6 +1442,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1456,6 +1460,7 @@ static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
>   			amdgpu_ring_fini(&adev->sdma.instance[i].page);
>   	}
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
>   	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
>   		amdgpu_sdma_destroy_inst_ctx(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 6a675daf5620..00dcae89119e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1459,6 +1459,10 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1470,6 +1474,7 @@ static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	amdgpu_sdma_destroy_inst_ctx(adev, false);
>   
>   	kfree(adev->sdma.ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index e1413ccaf7e4..dab4210c4401 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1364,6 +1364,10 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1375,6 +1379,7 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	amdgpu_sdma_destroy_inst_ctx(adev, true);
>   
>   	kfree(adev->sdma.ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4856a093e23f..e90d9ab65017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1367,6 +1367,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>   #endif
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1378,6 +1382,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	amdgpu_sdma_destroy_inst_ctx(adev, true);
>   
>   	kfree(adev->sdma.ip_dump);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 24f24974ac1d..650bb470426f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1317,6 +1317,10 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	else
>   		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>   
> +	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return r;
>   }
>   
> @@ -1328,6 +1332,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->sdma.num_instances; i++)
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   
> +	amdgpu_sdma_sysfs_reset_mask_fini(adev);
>   	amdgpu_sdma_destroy_inst_ctx(adev, true);
>   
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)

