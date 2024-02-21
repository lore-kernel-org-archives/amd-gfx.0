Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A56C48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 19:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F151A10E7CC;
	Wed, 21 Feb 2024 19:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHveigyu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F8710E7CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 19:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwF+MR2tRyaJiy/wkaegYSSRITAxz7wNFNKb3wUop2n+T1PLO+5SaxbkdGBTN9htNpqngxoTlCIx+2yFRMddHAGFD9Fr12XCbKl2SPLTaRPup88FHsNl9nRDARL6q9GqyorEmyRdCp7i9/e8rfHtZX0padVi7vt/hZTufwnWWmcIvV/6tG0w7Kwd1vYOBMT1OOR9uGHbjW2Ap3xpCFYD96QzwecJ+S40gNa8yGrvJsF235qUt8CD1GZvyjUNOdHqv85M/wiAscnfI0TxyQcGrGkuWVP94zoSUWCH6BRZYWe46Ijlz5kqEiIoGYWCqCjlivlHIZFtW08Y50CZLXEujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgWQhOVhRcfxvPfUR8rMt58hvaF0enRaj/h4IQ13z7I=;
 b=IBR3SByelVE7edstlsFIjNdn4k6KKQpl/vCXygygbvZS+J4HUHK99pmf1yanoqwjMYIks7XIqcyEp6nTmTKi7J+J3+YEDT0nBAMbOED7bL1tOaAnypxuG4BvK5qEE0TDXedv4uLqupOjzCF8suigOHPjihEzwtnI5DQwhUiirCGskosDJM2uTstupiU8qLu0HgtCNyOPE0qwTBuBFdN21tQ3oVI6dCmvGPFVs19H13qzb+6vQpYGzLBYfP6X6SW5C+sotA6/78fn+sbq4UG9b03ChvGgH0P9hjCBBhqNYlPkDTj5UOoViYYSVw/QJs/ClWVsyPl75v7Hi5u4hybC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgWQhOVhRcfxvPfUR8rMt58hvaF0enRaj/h4IQ13z7I=;
 b=iHveigyuGZEPynGSuOOILzjU5Bs0vyCbZxMJFrpv1tr0Te6Liom2jLD9pSiLgoQR9d9Vu/61zbjpqhB/Orao4Qg8ww7v9ELOCgm6PeUe3UD9zw8BBRddVsrxLd/PMGdAt0a41R03NdpqRihqqicE45loGXDP60DLhtbONrfJYEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 19:21:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c25b:d4ab:643c:ede7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c25b:d4ab:643c:ede7%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:21:51 +0000
Message-ID: <e2209732-771f-41da-9d83-ac696a08bee5@amd.com>
Date: Wed, 21 Feb 2024 14:21:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix process reference drop on debug ioctl
Content-Language: en-US
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: JinHuiEric.Huang@amd.com, Harish.Kasiviswanathan@amd.com
References: <20240221105422.1354628-1-Jonathan.Kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240221105422.1354628-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e8e632-e1d7-4c61-1b32-08dc33125b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smK9kdb2/H7sBgj22fGceFVeliFxwSnFG8GKlxCCTgeUhMrgfiCkH2paZPEOernMJlbXUOif+Ib7p3/vdT9oKneucEL5fkDPDxySGE2bhVbLuRdPzN1Yoe78QrTD3PMzUYVzLqC3Wu0fPXa6x//NLxhKjG9vLDjedcxxyRUMbTD7vgEoLMDGMDxM24/O6uldeCMLYCZnfKIqzZRdx0cmi+LfxMMIPd0lnY48dh5HM6KrhxDjIoFNCfX7HM7PQbOLeXfiYsoRbscu6GkXnHjJUvSeBBiPrpDqACI05dHRiNRO18C59lIYvfdUqraOYHwe5S8I99F0K9I8haIUr71A1AmuOCoRiGG8ElGxOWB1y1a6FAMgRa4HYZKjt7AhwNMOZcxRHgc0xlvMrZalMrskmhr7OGimVsc2JopLbG0asSbk/QrA2+gHLck83Q6SMXHJUnPbJlQmGjFiBKSmAR9Ouv0rVTD2miS85eECKfcD6wE/SOahg6+4ucjge/Kdd+UlRptP0AWM4OfSO7J6+f9EQRtdVGLGSGuZ6b0UIcRWg7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRnNFYzaXhFMWFraFhWZWlNcThtMDljODVxY0k5WUpHSERJbE5uSWZyZFJq?=
 =?utf-8?B?VVFNSk1qREU1eXEvTm1QNmN3Qmpwc2c3YUJhaHJWZWYxcktSOWlHZUEwSEkx?=
 =?utf-8?B?azhEZ3hTdWNrU1lISnFCUVV6bUdBNVI2WEtIc0ZIVHljbmxpTEdzRVFlb3RO?=
 =?utf-8?B?Y0dySVY4U2l0TFpsRzZUbWd3ZEdZN2FXYnd1eGxEVG5tL0toVGpmTHFLYVJp?=
 =?utf-8?B?ZnFMUWp2RW1xam16MzNnWXJnaGRjZjNOcWcrZGI0KzZEQVZRUDhBTmVTUWJI?=
 =?utf-8?B?ZVZHNmg5OVYwRFN3UzlCU0JKd0RFU04ydXkzZnh2eCs5UFNaRTRBSUVpREtm?=
 =?utf-8?B?ZlorU0c4SmdRcTJoK3JpelBqay9zM253TDZ5ZGVkMGpuTDQ0NHpnRG9yNmFs?=
 =?utf-8?B?T2M2ZFVadk9sSmJRSytkSmM2bFJiSkdRdWROcDN2N1cweHdMN2hkZ3llZDdZ?=
 =?utf-8?B?VjJnNUViVG54YW9xaWNQYVJZRzhvblNGRXZ3Mm1wZGxYZjIxZnhkU1E3ZVk1?=
 =?utf-8?B?TmltQ3NtdDBYSDJQSjQrNmNOalEzd2ZBQkRQVUhiOVVzWDdkWXJKYXB1MDE4?=
 =?utf-8?B?QVFiMVViQVlGNWhZOTg1V2cvdDNCQ20rbE5BeHE5Q1NtbnQySDRCa25vT2NV?=
 =?utf-8?B?MERjcjNmMm1qMHRkbEZzc1lWQnViSndWZURtOXJhaU03ZVRFMzh2ai9HbVA4?=
 =?utf-8?B?SENvOWRrTWV6Y1pNaFFueG1PNEtWVUJHV1lzdlg2cmZFeC9PYjdMZTM3VUM3?=
 =?utf-8?B?eS9QaDAyL2VOZmFwT1RNNjFVOTR6U3ozN25ZTkF1aVVhTkZLWlNVUWtZNk1U?=
 =?utf-8?B?Mk1kSnAyOUdFR3AvMEx3N0U2amEyb05TelFjSEpzcU5xZWFOeU41bHFUWENq?=
 =?utf-8?B?QlN4S3RKdjlFV3BYdzNaN3E1cFZqWVBva2p1ZVphZ0tnbTFqeUFvME1xNm4w?=
 =?utf-8?B?RFg3Z1RrR3l0M3dTNzdScE54d1FnYzZmYTRkM0w1ZDhJZG5XQzlQenFSK2lI?=
 =?utf-8?B?bkhDUWljS0dHT3JMU0dVUy9hWElUeDVlYnNoMFVqRFVlMGE3UzY4QThlWEJq?=
 =?utf-8?B?YmxMNmZvbG1SaEdKMlh2dlZ4YUFFNmo2aEozL0VCMWpFM3NWOHNZb2UxYTdh?=
 =?utf-8?B?MCs2UkFLUGxNNkhNU0YreldkYTVGUUZHMGwwV3JRNTFZRXRXcTZGR216Z0xE?=
 =?utf-8?B?cWJaZExuUXZLTzBYMC9CUjZGN3hYNkd1SkhMR1phdUF0WHlORHRCYVZXejZE?=
 =?utf-8?B?eW5LaGJ5VUsvTGUwc1JFQXZFUzFRUGgrbHBIdkdHRlZkcXBLQlBIR3NSYW9M?=
 =?utf-8?B?RXl3OFJWQ05SZm9udmxiNGdvcy9oWGlKSHlWSDBjMDR5Q3craERxTFNudUpE?=
 =?utf-8?B?a1JqNjlBMC9wVld6NUFEVnZYWVZGVjdmSmFZeWVydS9oWGtvaDdiUTYwbFg0?=
 =?utf-8?B?RUxia2RoRWpLVGdPZ1l5MjlCbFRLUFhnR3ZsUGxoek1kbTRRRVJXUXBTOXpj?=
 =?utf-8?B?QmJMaWZISi9iR2tBaUU0cTlwZUtDWVBqMFBYRk5QSFRtSkNoVXgvQzQwOVFS?=
 =?utf-8?B?NTMvekZxV2VFOGtid0tlTWtSS1NqSjhBM2oxdVNzRDBqcHBhRXNoSi95WmlW?=
 =?utf-8?B?QVhjR0huSnk3TVJ6WnI3cmpBUytZOUlPWkk5R3VJL1dVelpkSVI5ako1b2Y2?=
 =?utf-8?B?aGUzcVFjTS9NRkt5aUZHUDAzMU9iaUVrRThaWDRSZlQzbTdTaWN3TVplV29o?=
 =?utf-8?B?YXREK0RwMGZyTW1EOEg1a1V5WXVGN2ljS1R4OHdGUkFta2tldlRJWUoySjBv?=
 =?utf-8?B?Y0N2RVBjNEFXK25ZR3BkTWd3Y0ZpdHdGM3RYNVJsWm1tY0VKamkzZXZLOFlM?=
 =?utf-8?B?amFUak9RNXo2S2ZPM1p4cW1IazN2Qk1nb1JZKzJJSksxcm1JU2p2T0REM2N2?=
 =?utf-8?B?YUVvUXl1dFJXckRab0VxdXFFaTk4SWpyYUlRZTU3Q3k4K3plL0REOFV5T2Jn?=
 =?utf-8?B?bmtBWVU1VHFmdFVhS0I2aG9nT2RTQVBzaWFmNzdkZWN4QTRRMWd3U0pnSG9Y?=
 =?utf-8?B?cVd3SzZFbjYxUnM0Z3gvKy90b3ZNWU1HNko3dXZacnQzYk93bkVGdTFPaEh6?=
 =?utf-8?Q?znWogZ21OZtH/4s2kHkgmcwAH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e8e632-e1d7-4c61-1b32-08dc33125b3e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:21:51.6550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAn32jyMQBS42dorZP23ObO1gHETgSk+OOyS7sSrO5H40iadZrZD0YC3A9A0y8dz0E0QuaL9wMlSrdiM3M9JBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
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


On 2024-02-21 05:54, Jonathan Kim wrote:
> Prevent dropping the KFD process reference at the end of a debug
> IOCTL call where the acquired process value is an error.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 80e90fdef291..824e660283b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2935,6 +2935,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	if (IS_ERR_OR_NULL(target)) {
>   		pr_debug("Cannot find process PID %i to debug\n", args->pid);
>   		r = target ? PTR_ERR(target) : -ESRCH;
> +		target = NULL;
>   		goto out;
>   	}
>   
