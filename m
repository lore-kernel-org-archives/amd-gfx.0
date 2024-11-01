Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD973E6F069
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 15:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5743010E2F0;
	Fri,  1 Nov 2024 15:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pTZZ9whN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC1D10E2F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 15:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkoUabSCSPVTFPcPIi3LxlNl/BzkTBBocx6Qtd97L4h496ebyywOgCqOZh8MAen4xiggA5d1T+PuXg/L7+erCfnIIRFL1IDqyPPSUU2LMx7dOLBmUfJO2y1FU3OMyPyys/57ggB850yGpFlIEsAjMeQDcjnNmPoBsGpo3ZzCLOeaNMfUWkJm/4lWUyadDGPFBmLK09pPfU27w3ja7zBZsU7xE3zhQEbWALm1/BPc9HtbwdVfepblKw4LYcwRAsy9zWkmOQUrpDHkZbHuK2b5eIUKyASfF8ES8Vcd4bZR1ErHn953HwdLVGOmrLM/j8J5bmj/mR1dNaPSC7q6VNJFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEXOqeTXgyQYIzBjP/sRQsk4qfFiLGhtScsaFqKNmeQ=;
 b=Hoi25PZcVvN17ebOfe31vntLp6Gh5e2jESMHEuRSRnN8tWvb6o4nALM3ZtnArNSmuDYKG3yUy+zd2Z9LwawQ6SeuZH1Bj+gjmS0wdutcPOlv+0BwimbZGUoJqo31zwSUDvXAt9ERPGpldOWYAPYnh6Zj5livj+UdrjkZ4M7is9fLflGaJgyxlAfuk6St5BoS5A4Z89rgs0oXm7Dp2MXrJSfWyppgBiHkj/Px5ikB3spcgUHyzPK5sviA0Eg5Hv8lg/4sfVIeqanLaYws6bxTi8z6WQzOlccREERx9jlZQg06SAfh4BtJjkoJU+LZhG8W8qQpZZLbkpUe7Ok4sxxYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEXOqeTXgyQYIzBjP/sRQsk4qfFiLGhtScsaFqKNmeQ=;
 b=pTZZ9whNeuLb61CzbmJum/tFXNKiyW0Di95GqooO2W7HmTeZwA+KmK1YHq5AYfNA1NK/DNgMhGl4CsEpu39uP8dktv5MxysN/Ql4ZX/Dtcu83gJ1yMUXg5ZACPzIZfbQDGStqBgOwl+GHrNumok85MovDMNLSYRaA+P3x/kLOXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 15:43:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:43:29 +0000
Message-ID: <4b624213-1187-4c1e-a37f-644cf3ca1703@amd.com>
Date: Fri, 1 Nov 2024 10:43:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] drm/amd/display: Fix brightness level not retained
 over reboot
To: Zaeem Mohamed <zaeem.mohamed@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, mark.herbert42@gmail.com
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
 <20241101134940.1426653-8-zaeem.mohamed@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241101134940.1426653-8-zaeem.mohamed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a6eae3-a964-42c9-2566-08dcfa8beef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU1hRjQzK2N3MGFkeUprK0lGQlVQeC9MVStvZ2FOaGgzM1dUVG9FZGR5SFd0?=
 =?utf-8?B?T1hFdUVXenBrb29xOXRRWGlYdDVDTHhlYUtKQVp2L0tJdDBEaGdOSHE4U0ZX?=
 =?utf-8?B?bnlwMERaUC9aT21OYmo1Wkc1SmEydS9GU1A2U3grZDJzcHhpM2RXemRuMURC?=
 =?utf-8?B?d2tlY0JVcHdhdXV5SzRQRUx2dVFsTWlqeGp5NytJUU4xL3VzUk1KSFc3bnRh?=
 =?utf-8?B?UGRidzlRczYzZTRaZ3JIdVNiTWI4UkRFaFMyVUZMSHhLN2lHWk1DY0lCRXZw?=
 =?utf-8?B?R2FZQm9nZG1XTFlHalZuWDhrMjdETEgrUlE3bERxaGhybkdPbkxxa0hZSXZq?=
 =?utf-8?B?aU1uSk4rdVlkQVRaMnpucEN5MmpidzA4VnBKcHpjc21EcTNjNHhPODY0SjVP?=
 =?utf-8?B?SWZ2Q1NPOXpDck5VVDY0Tk9BN094UWw5Ny9EQ1VoRTZlQVVuRmMwWnNzV3JY?=
 =?utf-8?B?Mk9BZ0R0RkpicVhvWlJlS2NERG9jbVN3ZjEzOTlCM0VqSERJdWxWcHpFUC9m?=
 =?utf-8?B?V1poY1RNOTRycDkwcDkrNXJ6STFmVTJEcm8yQjlVcEJZQUZrTzVKQTBBMEkr?=
 =?utf-8?B?VHYxbjRNcml0dDBoTzNDei9TY2tDbFcrd2FETGR4dldpTkdaMFZxL2xyM0dO?=
 =?utf-8?B?OStybjV4Q2c4U2IwRHJCblZlbnhoVHg4RVFOWlVZNkNvdXozbHRoczZhMk9X?=
 =?utf-8?B?a2NQOUZicGRVVXhKcXVMQkwyNG93NExhRENrbTZQSDdKd3ovZDBZbUZLQWZI?=
 =?utf-8?B?c0g1WEdNYkJqdzJHZFlJYzFGYlhyTGNWQzB5OVRhY2gvaUt4NUdvMGtSL2tX?=
 =?utf-8?B?NnpXd3J4L3BtSS9YM3Y3WTdjRVBtalNNdFhFVzlFUDhkUTFjYllQbDAxSk15?=
 =?utf-8?B?UDhZS0VUTWF1UUc1VlB1ZG9wa2RxL3VrdEY2d20vTnQ5SERvVVc4ekFEOUpQ?=
 =?utf-8?B?T1huLytYdEd6UmRDK1RhQjJUZUxZbGVPcjZ2OUxVaE9peDhJOFVxYlJqeGpm?=
 =?utf-8?B?N09haVltUGRSTVdlMkxuS1J1dlJqa3U0cWM5c0hpb2VTQnZxNEFIQUI3Tk5L?=
 =?utf-8?B?YlBrN1NGaTBvNEp1OXNZeDBLblF5cDdQQ0MwQzlRTVllT2o0YXBkRWNIOGt1?=
 =?utf-8?B?QjdKZmwyMGl2cFN5TXB4dHAzcjFvUTl4YTZFUXJvL0tXck9ielRFSFkxVmJZ?=
 =?utf-8?B?aXp6SzFJQWcxQnIzbG1adkNrM05tcndlMXFGNS9qMFZxbTd5aHhMR0w1VXQw?=
 =?utf-8?B?STdRcHY1anc2UXNnRXgvWVRuKzdockFzbmJTYXF5cExkSkFzZkxmM0hlTG9h?=
 =?utf-8?B?bTJTSUxNYVdVY0w3Z0dBalN4Z0cxRkFJeTE2Q3BXM1J0VVVXaEp5VGtWL1pj?=
 =?utf-8?B?T0JxTmJ2KzZxSEpMU0xyZHpqcGhGZ0YrV3ZkMGYvMFhFVjJMSDhaSmYwb0c5?=
 =?utf-8?B?U24zWk1EbS92b2ZCRUVYTFZDZjVDdGNhdzdLN3ZYeFB5YjBKcGJIcG5QcUxs?=
 =?utf-8?B?aTdrMEFTTkZQblNjUitnY2s1dEZlSGw1UnBYM0dJODB6OUlqSllYb2I1bkxv?=
 =?utf-8?B?QXliczNCanB4UzVtUFFhSWxOdmNtSVhZeitVWkNzczNsQ0ZoTlBnTzc0cjQ4?=
 =?utf-8?B?WHBtbWlleHdVYnNxams5RC9lRGxMV2w3WHM3M25TVU5FMFVra2lEcDYxZXpU?=
 =?utf-8?Q?/tcJLWbxwjKnQhK0+Hlc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1LZnFvYU9oWmlOUXcvMFZNU2NNODgvaGVnTXdJaWxuN2MvWFhEdWxQM3Rv?=
 =?utf-8?B?OWJ3VEpuWHc5blZLOVFGQk8rOWtBRjE1QmFYckdNUnY3U1BFTHkyYnBrdUNY?=
 =?utf-8?B?TTYyOTlTMWFRL0cyMTliekZncDE3aDV2a2puM2F6eDRGMkNxQktYOWk2VlFu?=
 =?utf-8?B?azBjZ1pEQVVqaTVxN0ZTbjFTQUxLQU04RE8rdVlwd2pRNXdTSERtYnByOUM1?=
 =?utf-8?B?djJyUUY5WlVVaTMvYjF3YTY1M0t2amhEcHBqbUdHTDFpVFcreDBOcC9aSUMr?=
 =?utf-8?B?WjQ2K3Bra0NaMGloeFRrb1FnQnNJTUc2aUREVlVpVlEwa0NJTHM5NHBBZ28y?=
 =?utf-8?B?bndjTjFSSzRpMksyaW9nMloxL296enFEYnRGOGRucjZMaXFXL3JpaEhpdG5G?=
 =?utf-8?B?Vjg5ZVZYNjg0SUxlY2loRlZqRHJZTE5uaklvMjJucWo3aWR0U1hIL0xJY2lh?=
 =?utf-8?B?Mkc3OEFIcmxaZHZPVEJTYllUVW9QcjRZak5RUGxyUGo1M2VWUFVQWFhyWE5E?=
 =?utf-8?B?Vkd0dGc1VnJiNUJGblV3WVJ3c1VLNkRjRHZzbGY1Zm1iUE1vTjBmTXh1YjY2?=
 =?utf-8?B?U1FIRlptTVc0c3MvQXNYVU1tNWEzeERIWWlvRWVBZU8wZmMvN3A5Zjc0dVB5?=
 =?utf-8?B?YXFFay9lYWV0aXI5dzBnQnA4VTJQY25wRFBuQnNhWHMyVWRGSGFoYnI4Qy91?=
 =?utf-8?B?alNCdTc1TVpIUCtCenk1OEVPbVlaRkt4MGRLeXhVejc5YUl3Q3VFVlNPcWds?=
 =?utf-8?B?Wm1LdG9WTmZBR0Z2YkptRE4rZ3hEa3dWTndpSERycldXNUxLYlZodXRCOU9N?=
 =?utf-8?B?OTBsV25nODZ4NEw1emltT0lCaXZZQ3VBYkN0ZHNvaXpsc2NDNUVzd0R3ZURG?=
 =?utf-8?B?WTdQQXJuMmVQTkZTL2RDM2puMklrNk9nTXl0Q1g1NWMvN3hjQk5SV2RDYjhE?=
 =?utf-8?B?YUU2R2FqVFM4ZUMyQTVNSlRzdGFPZCs4ZEJZUUhDaGYzeHd5QldEQVZaN2lV?=
 =?utf-8?B?VHhzWmJ6MXM3VzltNkZLSkptcjVjWHlrM3I3Lys5bHg2UWxoenRrdU16NTMy?=
 =?utf-8?B?N1FwdVVXSDlKMHNkTlZQN09IbGsyUURPZTJmZWFvRysrNnpFTWtGRE1FckZt?=
 =?utf-8?B?Szc2NlJZcDlVT1NnR0Vlb1hZbnczUE9jRXNKWU9IRFVzTk1zLzJlTmlSVEJB?=
 =?utf-8?B?MUZaeWxqU2h6N2pSVnJnVXpiSGtaUW1YVExXaFNOUXJiVHp2U0JqL21UUWF3?=
 =?utf-8?B?NXlwN2IzdUZWS0RyRmpOdklIUnJvQnpHZXRGZWdlN0dVMEh2bElvZWpVOGxX?=
 =?utf-8?B?dGxzQmdSUmhXSC82NHE1MDk4M2JuZzNTcld0NXpBeWRITm0yVTJMUUNVbEZm?=
 =?utf-8?B?QWZscldUNEVWUG9TYTBaeTcyTG5jSlVnQ1BJM3RJbDlHNnJsaW1mRTJ2Vjcz?=
 =?utf-8?B?L0dZZG5mVmhWaTJiRUs4RXA2enNqUWZITXZvNnljM1B3MlB5bHp6Y1Z1NFAx?=
 =?utf-8?B?Y3pYY1JGeXBaV2JPWURYUjhGbVF5KzVCcEJ3QkIrSDhIUW15YVlsdUtjMUlT?=
 =?utf-8?B?S2NrVzlsVTh3QmJQWDBFdU5iTE9TeHdNZEZOeGdIenR2S04rWFZmUTRUMm1q?=
 =?utf-8?B?VkgrRGFGWVVZaFN2cmZ1eXN6RnBOWk92WEIyWkNVelpvbjY2eEQ1SzRQUS85?=
 =?utf-8?B?VzJLd0ZJZFFSamJ0eVVxdkIzVGZQSDVKajV5cVNDT0pDU2F5SmJSaThwQ0V3?=
 =?utf-8?B?bW9FUUtlcTk1bVE3c0FmWkVSaTVXQ2JRYnZ0SUMyWHNvdjhVeUdiQ0JvUm1z?=
 =?utf-8?B?YWplTUpPSmdhV0VTMzRKUnd6aVFsMkFJYnNUWGJSa2hrYzUyWTNUQ2pnN0Zj?=
 =?utf-8?B?RkkwU2UwMno2ZnpZWC9KSENMNXR6d1RmVG0xbGY4K2s1M3p0NVp2RHY1N1cw?=
 =?utf-8?B?bitJeUpnOTdJL0dKM1p1MCtZSDh1UmJ1MHVFUVA3WWVkM3k1R0Z6YWRHUVpw?=
 =?utf-8?B?dnZMRGMrNkpCWjlsazNzbzMyNEprMlFCUTZqMG1Fb2Q2Y01VVzN1U0w5N3pY?=
 =?utf-8?B?ZGFxMUx5K0FoWTlhZDliWHJMb2dCR1V1ekJmc20rbytRVjFLVjlQRUdwdHBO?=
 =?utf-8?Q?Kd8lLvUm5wzWk4cFEFq1jLMKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a6eae3-a964-42c9-2566-08dcfa8beef2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:43:29.8356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en7TIHnXOPd4SUWE1h5gqELlsm8l+iAv5uJwP5t8IdUAjYccBYogblpwG4bGsohTHyt/ZADPdI2lvc4YL63PFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

On 11/1/2024 08:49, Zaeem Mohamed wrote:
> From: Tom Chung <chiahsuan.chung@amd.com>
> 
> [Why]
> During boot up and resume the DC layer will reset the panel
> brightness to fix a flicker issue.
> 
> It will cause the dm->actual_brightness is not the current panel
> brightness level. (the dm->brightness is the correct panel level)
> 
> [How]
> Set the backlight level after do the set mode.
> 
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>

Some more tags, please explicitly add these while merging.

Cc: stable@vger.kernel.org
Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
Reported-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3655

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bbfc47f6595f..2599a99509de 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9411,6 +9411,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   	bool mode_set_reset_required = false;
>   	u32 i;
>   	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
> +	bool set_backlight_level = false;
>   
>   	/* Disable writeback */
>   	for_each_old_connector_in_state(state, connector, old_con_state, i) {
> @@ -9530,6 +9531,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   			acrtc->hw_mode = new_crtc_state->mode;
>   			crtc->hwmode = new_crtc_state->mode;
>   			mode_set_reset_required = true;
> +			set_backlight_level = true;
>   		} else if (modereset_required(new_crtc_state)) {
>   			drm_dbg_atomic(dev,
>   				       "Atomic commit: RESET. crtc id %d:[%p]\n",
> @@ -9581,6 +9583,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   				acrtc->otg_inst = status->primary_otg_inst;
>   		}
>   	}
> +
> +	/* During boot up and resume the DC layer will reset the panel brightness
> +	 * to fix a flicker issue.
> +	 * It will cause the dm->actual_brightness is not the current panel brightness
> +	 * level. (the dm->brightness is the correct panel level)
> +	 * So we set the backlight level with dm->brightness value after set mode
> +	 */
> +	if (set_backlight_level) {
> +		for (i = 0; i < dm->num_of_edps; i++) {
> +			if (dm->backlight_dev[i])
> +				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +		}
> +	}
>   }
>   
>   static void dm_set_writeback(struct amdgpu_display_manager *dm,

