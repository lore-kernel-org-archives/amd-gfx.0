Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C5CE8D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 19:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9628F10E089;
	Fri, 14 Nov 2025 19:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0eb0E7l";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5926F10E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 19:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1dp7kHAJuVo2UlrZVBP5YhmihaetNzeZdFQvY1SOfQr36CJRvJU/4IKoV1kBvCbKTqVqtAwGfyTIz8ExmSUR/0CwBI6tm8SjPxRtBvyQ0D/ey5fIIo19FNIidXLCFxHTg7ibl7+fMre8StIToyPB1fS6z5UHjPVzIl+lFxit9yFEADJsz+8N8p4WF0bihyuP9CeKGHntE0ciZwuqNx2Wqlg+YXzDsoKy4xQHQLbkwzagubbit0vK9prZH8SraeaEORaRNXAwUDmsH6UrXHYjG5tB7JSe+lZjpbUUD/wjkTcEERj/OCkzIZZd2bNMuTRdk9/HGeqzEURZdTedX2CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UX7AzI8AppZqip0gH6VNV7OQPJxxX/bYVs5fg7fTTmg=;
 b=PhAG5SaRBxuzBnqoZkYUhkWQWmTtLewXbbKvPflH4TqCIhVHL268CZX+2p3XlJUqUTPmhsk534a3zIpZcZKL3w3RLob34R6ncUDfc0fS1/DPtbkbhzSoDeQXdmLwrH9PEfKS+5rj/js5olebAQqbBjC6BdOPsgcHl9iAq7gKUcqPXEmEcOKdjP60nqp190VqXgR8Zp50iSknZ97a/sMQRbiYhUa4jVgUDBCCkezDsFhpaMLzIDBYIu8Tlf3NM3VF4sBNvOjzO+xx3EADLrGmshctx9LCM8FYQrKC/4yXC5EHdolHwktH3PO2qV2Cj7XZXEjxWNb/6XuBCeez+Cmhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX7AzI8AppZqip0gH6VNV7OQPJxxX/bYVs5fg7fTTmg=;
 b=K0eb0E7lP6odYSSMJbZq4LeqSgUCof+cd8ujnuB3T3eiPLiuvRKo8KhSg/jUyPjSi81tXLa8z2sWHuiN9hc6lJ4rD6iZG/J90NIjufYS17kPqsrgXc1xaN+p0utdjKRxIaCmSmGiL6VNcOVSyX2pU6ucDUKovbIK2izqk0Y/wi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 19:30:14 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 19:30:14 +0000
Message-ID: <38c18f35-3f7a-44dd-ac11-fb116408a248@amd.com>
Date: Fri, 14 Nov 2025 19:30:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Trap handler support for expert scheduling
 mode
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251114174407.769287-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20251114174407.769287-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e293ae-a6af-4b32-c654-08de23b43be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STZLMXZJQTJrWkJrUmo3ZnlUWnRORUcrMC9RWTdpNkJNSG5yNk5rczRkaUNC?=
 =?utf-8?B?RGRHMURZMEppL1lpR2R4clltMWkza2hGamRoN241NklNQUhZaVA0Q3lrQVdO?=
 =?utf-8?B?aDVqVTJQN2xHUHQ3SFpnOW05azVQbFl3Rm5qUDFXc0w5NlEzd2xhYXcwOHg5?=
 =?utf-8?B?azBsUzhHN0RNVDlpR2RlZ3RzR1lEOGszMUd1azVObnN2UFdZQk9pZVZLbE42?=
 =?utf-8?B?UzI1VkJ0Ym1NRTJPbjgyZEh1dUJVMWhaclpvd1hzNVc5L2x3VUpMSkFkYncz?=
 =?utf-8?B?aHZwYjVSWnBDNFVBcVloUlVDa2xjTllvcm5nTDZHOG1jQ3Z3NVpYeFJDcVNP?=
 =?utf-8?B?akNwdXhULzhjRFlNc2lwM3FicHoyaDVUaXhQdkxKSXd3dlluUVpSZHJUSmRz?=
 =?utf-8?B?NENGRk84a2NOVUFWTUl3YVMxNzJaMkxsSitFbWR3UDdXRkR3QkVUYTRKVUtS?=
 =?utf-8?B?STRBSXVGR3labUlFL1lRajU5L3lzaHh2VFE3OWdVLzBFT2MzUzZHeGJ1YXZX?=
 =?utf-8?B?emN0Qzh2bmY5VEN1WFJ6ZHpIODZ3R1F4NXpTWk1wSTE4Y0pCSzdHOUJGd1Mw?=
 =?utf-8?B?VFFQenl2dm44QWJlcXMvaHJ0QVdWUEV2a0dMRXBEYlhPMjJ6eG9LSjl5ZUdI?=
 =?utf-8?B?T0FJN0JjcVAvOThRQnJKYUdocWorbml6MEFEeURTb0N0WTdnY3BnUjlSK1RW?=
 =?utf-8?B?QUdxL1ZtNCtaUUtqeFlKSHNRTFhWSTVSYzJUcGx3bkhZcTVCT29zY0RoZnIy?=
 =?utf-8?B?QVN1bXJES0k2YWNBdlVPZmlXdm9yQ1c5RnJEZFlTZEpHbktpQ3F2SXVPd1hj?=
 =?utf-8?B?NVZ5RU1oaFltd0lCcUFHS2txZnZYWjl5UGMwYjZDNVJQZUI5YUJzc1FYbWpr?=
 =?utf-8?B?U0x5WjJicFUxUDdVbFhvTm9Oa2crS09VQ3pnSmNhU1psNkNicUNlSWl5eVBS?=
 =?utf-8?B?S25CMXlXMzhybEgrVElnTkFEYm1Tc1pzQlk4OFZKZm81SVJTYWVmUmx0SjJE?=
 =?utf-8?B?ZjNDYStBaXVtdjFiYjJKYjhYQVFUUDhEWjE0Y2Y1bzQyY0hOd1dIVGRxSW9m?=
 =?utf-8?B?cHRjUWhqWERERkpGb3lXWUJ5VkRjTjBidFVwRzA4SzBNeEVJSzdZUENNbWF2?=
 =?utf-8?B?RTVDT3RscXBJZWZoS3Y5QnBxK0ZtZ3RnV2lnQkFFN3BmUmd1cGNvOUxwdjNN?=
 =?utf-8?B?NHlwYWw2TXJ0d2huN3Zkc2pPL0xQd1M5bklJMnRxaFZTdlgrNnlIdjgxVVJN?=
 =?utf-8?B?RnJ3cXBlRHdac09ObHJnN09PbEo4SVJsV2ZsYXlheHBDV0JJVmJIQmFLc24z?=
 =?utf-8?B?S2tBRkdTR2lKTnV0V05xbERydWNSWVBoeVVaUUpzUk1OTCs4RXhZekZPZ3Z3?=
 =?utf-8?B?OWlSLy8rTXhVeDZWQXBaTmVBOWhtRGhCTk1nVlE0eUQ0Tk5WazBvcTRDSndS?=
 =?utf-8?B?T3BoYkl2SU51ZU9OeE42b0hDNXlGd0k2dmdodVhQWW9YSGpNVGFSdzRkRkxN?=
 =?utf-8?B?ajMraTROQWxOa3VZNk8yemIyL1owUWxwRkkzenBodnF1bWpPY3BOQklqblRa?=
 =?utf-8?B?aUFqQjE2TzFMNU0yQmpuamd4Mzg2TUN2T3FSZnJYT2g0MEc3S2dPcVNhckgr?=
 =?utf-8?B?aDVIbm8vNmoweDYwSjErOXVoY29tZ3lKb3VaUWhaZHQ0T21xQjRyZEI3QVI4?=
 =?utf-8?B?Qmd2ZnlYQk9uWGlCMHpPa0FndXRhSnFYaUh1TnZvOVNMZ3ZIM3g4VDRuM0JZ?=
 =?utf-8?B?YUQwb2ZkTVhQNUh4N3BWNDZ0by85MUxxeHh1aWNsNVo5bmJsTjFaeTlzeVVj?=
 =?utf-8?B?eXBtNlZKZlFMaXBMb2VJbEFmSDk2UGltWUd4K1dyaGhqMjIwcEdpdjBkcTR0?=
 =?utf-8?B?ZFRRT0lPdnVEb0VFZXRqanMxanlIeHNndlA5ZG5ENXB6eDJQbm1yalJjT3ZL?=
 =?utf-8?Q?upyttjJxQDcadanog8UM0H+SYXyIufON?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNwa2ZXb2oyMThNRi92a2pjeUZwRENxV1R6K25GTUJLT0VocUZ4bklVRUx6?=
 =?utf-8?B?YmpCSnNoNmlQNW0yMGhWUDlqendNb21nVmpvZUFWa29HQm5JRGhPYVA1OGZR?=
 =?utf-8?B?amJqVFo4UW1qU21pWWVSTGhzNVNzcDBYMU1MNDdibEppVjA4ZDJHZ1VqVmRp?=
 =?utf-8?B?NHF0dTJCZHhDL3RGRDZ3L08wV0xjOUdmbmNraEJJSnpDSnBla3dLM0FSeXRH?=
 =?utf-8?B?NjVGRms4Z0NER1ZMLzdyYUFZRDJIQ3kySlBGVTNJY2VGMkdjRmtoWGsrRW5v?=
 =?utf-8?B?WExEYkRJV0JWVGJURW4rUldZVVRHRDZ2NzNjcC9yYnZaSkpiVG1zRkhLdHc5?=
 =?utf-8?B?ZlpQMWxjbm1EQ2xrbGxYVE1OVnBEMi9yMnFweTV4V0JIOUpKSnE3T0NIZ0Qx?=
 =?utf-8?B?MUtJZzdPbzZqdUFEVDZaaGFLaTloMUJvYTZYSnVCTXVvODFSTER6NlNuNFVK?=
 =?utf-8?B?WVdFVTNRSmhBZlExaTRUaDU1VW5zVGs1WGw2eG9tUXZZR0t1RVJueDNEMzhx?=
 =?utf-8?B?U3BMSWVTcEVyVWVZQ1VtZGpDRUVKT05ML0R3NlJGSVpuaW92N1FkZjNGRGpI?=
 =?utf-8?B?bDVpVHdTVzRyVnBrL1V2YXo4clBsM0pqZ0tTTjZOcGRMWlhISkI5RVNBd1lP?=
 =?utf-8?B?TklFa2ZmN3I3RlRWNGpDeWwyVU1VK3NSS0NtY1VTREY2ekF2S2RaZFk0RXNG?=
 =?utf-8?B?dFloVXV3b3Q5SkRId3FYVkNIZ0VSUGFzOUY0Z2IydTJFT1BUOWJtNHprNnRF?=
 =?utf-8?B?bjJYL3I2eEtnM1JLTzlNYmppd0o3eWtFQ2pIR3pUT09ZVlFrV1p2M0Q1QVJ6?=
 =?utf-8?B?UXN4RGlyWmJYZXRHc2JVS1ByR0h4TEd6eUh2bnF4b29kQ1RIczhZRGpHNWI3?=
 =?utf-8?B?bDFKYkJ1OVFCRDRUZXVNL0RTSHZIYkRMemg5WTVDQnB1ZzEvME44cTdGM1VX?=
 =?utf-8?B?S3NzTkdhckk2elIxdlhBaExCVDJVKys4ejVzUTZFM0g5TXVaQ1lqblM5Ui96?=
 =?utf-8?B?eUw2M3BBU0V0TTJoN1dnZzN6M0IyT1p6VjlzQjZOV0YrK3NyZ3IrY25sRmJF?=
 =?utf-8?B?NzNNMWo3UkJTYmFVUVJxODU0dlA0RlpSaEh1SjE1R05BbjdGYmFMLzdNY0pV?=
 =?utf-8?B?TStKOTY0RGdDcFZsT2cydlBTcXUvME9lN2VCNWUwWFpYTStXbzMreUdzYlp3?=
 =?utf-8?B?OUhYU1QrdmM5RGszK0pSQXBtMGsyZ0JwZ1Z0WExSR2RkMFFKYlRXdUMzVTNu?=
 =?utf-8?B?RHhCUWtQaFB5QS90dTZiTTl5aTE4d1U3T2Q4SzRIK0dWK1FqNHJyR21xZDZK?=
 =?utf-8?B?N2p3L2hyZE1ZRkZqTEhuSFR5NEdudE5haU80ZjdSM2tMbHpGc0dIYU5BTkZ3?=
 =?utf-8?B?ZW9tOUJXQkZCZTZMVG9CN0crd3BBbjNPNmdwTjlXNWZ1SGJNNlZWYWt2cmdX?=
 =?utf-8?B?WXM4cGFTK0dXcnFQaHhQU3hNMEY0K1dyRldiNFZJVGNpVHlmaW1YN0ZHZCtJ?=
 =?utf-8?B?WHBQUWNNZjNFTDIxRXFiNDhOYjNNQlZ1WDNtTHFLWU5IWmhLdmlpVnM5QmN1?=
 =?utf-8?B?M2ZxSHZCVlN3QWhobG9EaURqWllGYmt5RWJickw5UUNGZDRnejlraU9sVzB0?=
 =?utf-8?B?Ui9MV0Y1MStLaCs2NlBnMkQ4YmN5R25MQzJWN1JYSFNwWEROd2tMMHY4dG5R?=
 =?utf-8?B?eHpUb0E0ZERwdksySmVIQkV4Zkpia3JBM2M5QUd5OHdkejBjQXhCT3VoMWNl?=
 =?utf-8?B?SndkNnlwUTJqRU0wdkNxMkxNZVJYYkZneGRIVERZZ012ZDhkeWw1cVRiclNB?=
 =?utf-8?B?VllSazZ2NExEeVExV3RqM0JhR3JMNHZmaVBkZEpoSlRsc0cvbUhFYWdvL0Fx?=
 =?utf-8?B?ZXZKZXhobThsVlFvTTlBalBDd1VMQVZDbmsxbUlQNVU5Mm5mcUVhTGlOWGw5?=
 =?utf-8?B?ZU9HZlY4N281RGZXaXplMThIenNqZTYzd05tNHdFd2c5UjY4WUlPejZsbWE5?=
 =?utf-8?B?aG1TTFZ5OE5aZ21XbGRUUm9RT1lpUmZYN3FyU0t1VU0xaGx1YkRFb1BSeU1H?=
 =?utf-8?B?RFlDV2paajBpZGpoRTV5bFQ0WWhDY3NwdDJGWE5tWlNGUkZYcG9uRWZxaXNi?=
 =?utf-8?Q?bO7zrt7dYhvbPNQu6sZbK0rCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e293ae-a6af-4b32-c654-08de23b43be4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 19:30:14.2363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3+ExwLlvvJCmOybYuF6L9/yH7zqe/Rx42Ri6XPa8e4a+T95TWx10D6akVZ5EoClgb2BpPEGONsmgQXqCJXblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
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



On 14/11/2025 17:44, Jay Cornwall wrote:
> The trap handler may be entered with dependency checking disabled.
> Wait for dependency counters and save/restore scheduling mode.
> 
> v2:
> 
> Use ttmp1 instead of ttmp11. ttmp11 is not zero-initialized.
> While the trap handler does zero this field before use, a user-mode
> second-level trap handler could not rely on this being zero when
> using an older kernel mode driver.

Hi,

I think I would have kept ttmp11 for most places, just copied those 2 
bits in ttmp1 just before jumping to 2nd level trap handler to avoid the 
tracking of when ttmp1 and s_sched_mode can alias.

I think one spot might have issue, see below.

> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 853 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  39 +-
>   2 files changed, 468 insertions(+), 424 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 0320163b6e74..5b09fac1c09e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,14 +3644,18 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
>   };
>   
>   static const uint32_t cwsr_trap_gfx12_hex[] = {
> -	0xbfa00001, 0xbfa002a2,
> -	0xb0804009, 0xb8f8f804,
> +	0xbfa00001, 0xbfa002ad,
> +	0xb0804009, 0xb8eef81a,
> +	0xbf880000, 0xb980081a,
> +	0x00000000, 0xb8f8f804,
> +	0x916dff6d, 0x0c000000,
> +	0x846e9a6e, 0x8c6d6e6d,
>   	0x9178ff78, 0x00008c00,
>   	0xb8fbf811, 0x8b6eff78,
>   	0x00004000, 0xbfa10008,
>   	0x8b6eff7b, 0x00000080,
>   	0xbfa20018, 0x8b6ea07b,
> -	0xbfa20042, 0xbf830010,
> +	0xbfa20045, 0xbf830010,
>   	0xb8fbf811, 0xbfa0fffb,
>   	0x8b6eff7b, 0x00000bd0,
>   	0xbfa20010, 0xb8eef812,
> @@ -3662,7 +3666,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xf0000000, 0xbfa20005,
>   	0x8b6fff6f, 0x00000200,
>   	0xbfa20002, 0x8b6ea07b,
> -	0xbfa2002c, 0xbefa4d82,
> +	0xbfa2002f, 0xbefa4d82,
>   	0xbf8a0000, 0x84fa887a,
>   	0xbf0d8f7b, 0xbfa10002,
>   	0x8c7bff7b, 0xffff0000,
> @@ -3681,99 +3685,45 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00004000, 0x80ec886c,
>   	0x82ed806d, 0xbfa00002,
>   	0x806c846c, 0x826d806d,
> +	0x936eff6d, 0x0002001a,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
> -	0x85788978, 0xb9783244,
> -	0xbe804a6c, 0xb8faf802,
> -	0xbf0d987a, 0xbfa10001,
> -	0xbfb00000, 0x8b6dff6d,
> -	0x0000ffff, 0xbefa0080,
> -	0xb97a0151, 0xbeee007e,
> -	0xbeef007f, 0xbefe0180,
> -	0xbefe4d84, 0xbf8a0000,
> -	0x8b7aff7f, 0x04000000,
> -	0x847a857a, 0x8c6d7a6d,
> -	0xbefa007e, 0x8b7bff7f,
> -	0x0000ffff, 0xbefe00c1,
> -	0xbeff00c1, 0xee0a407a,
> -	0x000c0000, 0x00000000,
> -	0x7e000280, 0xbefe007a,
> -	0xbeff007b, 0xb8fb0742,
> -	0x847b997b, 0xb8fa3b05,
> -	0x807a817a, 0xbf0d997b,
> -	0xbfa20002, 0x847a897a,
> -	0xbfa00001, 0x847a8a7a,
> -	0xb8fb1e06, 0x847b8a7b,
> -	0x807a7b7a, 0x8b7bff7f,
> -	0x0000ffff, 0x807aff7a,
> -	0x00000200, 0x807a7e7a,
> -	0x827b807b, 0xd7610000,
> -	0x00010870, 0xd7610000,
> -	0x00010a71, 0xd7610000,
> -	0x00010c72, 0xd7610000,
> -	0x00010e73, 0xd7610000,
> -	0x00011074, 0xd7610000,
> -	0x00011275, 0xd7610000,
> -	0x00011476, 0xd7610000,
> -	0x00011677, 0xd7610000,
> -	0x00011a79, 0xd7610000,
> -	0x00011c7e, 0xd7610000,
> -	0x00011e7f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xbefe00ff,
> -	0x00003fff, 0xbeff0080,
> +	0x85788978, 0xb96e081a,
> +	0xb9783244, 0xbe804a6c,
> +	0xb8faf802, 0xbf0d987a,
> +	0xbfa10001, 0xbfb00000,
> +	0x916dff6d, 0xf0000000,
> +	0xbefa0080, 0xb97a0151,
> +	0xbeee007e, 0xbeef007f,
> +	0xbefe0180, 0xbefe4d84,
> +	0xbf8a0000, 0x8b7aff7f,
> +	0x04000000, 0x847a857a,
> +	0x8c6d7a6d, 0xbefa007e,
> +	0x8b7bff7f, 0x0000ffff,
> +	0xbefe00c1, 0xbeff00c1,
>   	0xee0a407a, 0x000c0000,
> -	0x00004000, 0xd760007a,
> -	0x00011d00, 0xd760007b,
> -	0x00011f00, 0xbefe007a,
> -	0xbeff007b, 0xbef4007e,
> -	0x8b75ff7f, 0x0000ffff,
> -	0x8c75ff75, 0x00040000,
> -	0xbef60080, 0xbef700ff,
> -	0x10807fac, 0xbef1007d,
> -	0xbef00080, 0xb8f30742,
> -	0x84739973, 0xbefe00c1,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20002,
> -	0xbeff0080, 0xbfa00002,
> -	0xbeff00c1, 0xbfa0000c,
> -	0xbef600ff, 0x01000000,
> -	0xc4068070, 0x008ce801,
> -	0x00008000, 0xc4068070,
> -	0x008ce802, 0x00010000,
> -	0xc4068070, 0x008ce803,
> -	0x00018000, 0xbfa0000b,
> -	0xbef600ff, 0x01000000,
> -	0xc4068070, 0x008ce801,
> -	0x00010000, 0xc4068070,
> -	0x008ce802, 0x00020000,
> -	0xc4068070, 0x008ce803,
> -	0x00030000, 0xb8f03b05,
> -	0x80708170, 0xbf0d9973,
> -	0xbfa20002, 0x84708970,
> -	0xbfa00001, 0x84708a70,
> -	0xb8fa1e06, 0x847a8a7a,
> -	0x80707a70, 0x8070ff70,
> -	0x00000200, 0xbef600ff,
> -	0x01000000, 0x7e000280,
> -	0x7e020280, 0x7e040280,
> -	0xbe804ec2, 0xbf94fffe,
> -	0xb8faf804, 0x8b7a847a,
> -	0x91788478, 0x8c787a78,
> -	0x917aff6d, 0x80000000,
> -	0xd7610002, 0x00010071,
> -	0xd7610002, 0x0001026c,
> -	0xd7610002, 0x0001047a,
> -	0xd7610002, 0x0001066e,
> -	0xd7610002, 0x0001086f,
> -	0xd7610002, 0x00010a78,
> -	0xd7610002, 0x00010e7b,
> +	0x00000000, 0x7e000280,
> +	0xbefe007a, 0xbeff007b,
> +	0xb8fb0742, 0x847b997b,
> +	0xb8fa3b05, 0x807a817a,
> +	0xbf0d997b, 0xbfa20002,
> +	0x847a897a, 0xbfa00001,
> +	0x847a8a7a, 0xb8fb1e06,
> +	0x847b8a7b, 0x807a7b7a,
> +	0x8b7bff7f, 0x0000ffff,
> +	0x807aff7a, 0x00000200,
> +	0x807a7e7a, 0x827b807b,
> +	0xd7610000, 0x00010870,
> +	0xd7610000, 0x00010a71,
> +	0xd7610000, 0x00010c72,
> +	0xd7610000, 0x00010e73,
> +	0xd7610000, 0x00011074,
> +	0xd7610000, 0x00011275,
> +	0xd7610000, 0x00011476,
> +	0xd7610000, 0x00011677,
> +	0xd7610000, 0x00011a79,
> +	0xd7610000, 0x00011c7e,
> +	0xd7610000, 0x00011e7f,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
> @@ -3782,113 +3732,54 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
>   	0xd8500000, 0x00000000,
> -	0xb8faf811, 0xd7610002,
> -	0x00010c7a, 0xb8faf801,
> -	0xd7610002, 0x0001107a,
> -	0xb8faf814, 0xd7610002,
> -	0x0001127a, 0xb8faf815,
> -	0xd7610002, 0x0001147a,
> -	0xb8faf812, 0xd7610002,
> -	0x0001167a, 0xb8faf813,
> -	0xd7610002, 0x0001187a,
> -	0xb8faf802, 0xd7610002,
> -	0x00011a7a, 0xbefa50c1,
> -	0xbfc70000, 0xd7610002,
> -	0x00011c7a, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xbefe00ff,
> -	0x0000ffff, 0xbeff0080,
> +	0xbefe00ff, 0x00003fff,
> +	0xbeff0080, 0xee0a407a,
> +	0x000c0000, 0x00004000,
> +	0xd760007a, 0x00011d00,
> +	0xd760007b, 0x00011f00,
> +	0xbefe007a, 0xbeff007b,
> +	0xbef4007e, 0x8b75ff7f,
> +	0x0000ffff, 0x8c75ff75,
> +	0x00040000, 0xbef60080,
> +	0xbef700ff, 0x10807fac,
> +	0xbef1007d, 0xbef00080,
> +	0xb8f30742, 0x84739973,
> +	0xbefe00c1, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20002, 0xbeff0080,
> +	0xbfa00002, 0xbeff00c1,
> +	0xbfa0000c, 0xbef600ff,
> +	0x01000000, 0xc4068070,
> +	0x008ce801, 0x00008000,
>   	0xc4068070, 0x008ce802,
> -	0x00000000, 0xbefe00c1,
> +	0x00010000, 0xc4068070,
> +	0x008ce803, 0x00018000,
> +	0xbfa0000b, 0xbef600ff,
> +	0x01000000, 0xc4068070,
> +	0x008ce801, 0x00010000,
> +	0xc4068070, 0x008ce802,
> +	0x00020000, 0xc4068070,
> +	0x008ce803, 0x00030000,
>   	0xb8f03b05, 0x80708170,
>   	0xbf0d9973, 0xbfa20002,
>   	0x84708970, 0xbfa00001,
>   	0x84708a70, 0xb8fa1e06,
>   	0x847a8a7a, 0x80707a70,
> +	0x8070ff70, 0x00000200,
>   	0xbef600ff, 0x01000000,
> -	0xbef90080, 0xbefd0080,
> -	0xbf800000, 0xbe804100,
> -	0xbe824102, 0xbe844104,
> -	0xbe864106, 0xbe884108,
> -	0xbe8a410a, 0xbe8c410c,
> -	0xbe8e410e, 0xbf068079,
> -	0xbfa10032, 0xd7610002,
> -	0x00010000, 0xd7610002,
> -	0x00010201, 0xd7610002,
> -	0x00010402, 0xd7610002,
> -	0x00010603, 0xd7610002,
> -	0x00010804, 0xd7610002,
> -	0x00010a05, 0xd7610002,
> -	0x00010c06, 0xd7610002,
> -	0x00010e07, 0xd7610002,
> -	0x00011008, 0xd7610002,
> -	0x00011209, 0xd7610002,
> -	0x0001140a, 0xd7610002,
> -	0x0001160b, 0xd7610002,
> -	0x0001180c, 0xd7610002,
> -	0x00011a0d, 0xd7610002,
> -	0x00011c0e, 0xd7610002,
> -	0x00011e0f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0x80799079,
> -	0xbfa00038, 0xd7610002,
> -	0x00012000, 0xd7610002,
> -	0x00012201, 0xd7610002,
> -	0x00012402, 0xd7610002,
> -	0x00012603, 0xd7610002,
> -	0x00012804, 0xd7610002,
> -	0x00012a05, 0xd7610002,
> -	0x00012c06, 0xd7610002,
> -	0x00012e07, 0xd7610002,
> -	0x00013008, 0xd7610002,
> -	0x00013209, 0xd7610002,
> -	0x0001340a, 0xd7610002,
> -	0x0001360b, 0xd7610002,
> -	0x0001380c, 0xd7610002,
> -	0x00013a0d, 0xd7610002,
> -	0x00013c0e, 0xd7610002,
> -	0x00013e0f, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0xd8500000,
> -	0x00000000, 0x80799079,
> -	0xc4068070, 0x008ce802,
> -	0x00000000, 0x8070ff70,
> -	0x00000080, 0xbef90080,
> -	0x7e040280, 0x807d907d,
> -	0xbf0aff7d, 0x00000060,
> -	0xbfa2ff88, 0xbe804100,
> -	0xbe824102, 0xbe844104,
> -	0xbe864106, 0xbe884108,
> -	0xbe8a410a, 0xd7610002,
> -	0x00010000, 0xd7610002,
> -	0x00010201, 0xd7610002,
> -	0x00010402, 0xd7610002,
> -	0x00010603, 0xd7610002,
> -	0x00010804, 0xd7610002,
> -	0x00010a05, 0xd7610002,
> -	0x00010c06, 0xd7610002,
> -	0x00010e07, 0xd7610002,
> -	0x00011008, 0xd7610002,
> -	0x00011209, 0xd7610002,
> -	0x0001140a, 0xd7610002,
> -	0x0001160b, 0xd8500000,
> +	0x7e000280, 0x7e020280,
> +	0x7e040280, 0xbe804ec2,
> +	0xbf94fffe, 0xb8faf804,
> +	0x8b7a847a, 0x91788478,
> +	0x8c787a78, 0x917aff6d,
> +	0x80000000, 0xd7610002,
> +	0x00010071, 0xd7610002,
> +	0x0001026c, 0xd7610002,
> +	0x0001047a, 0xd7610002,
> +	0x0001066e, 0xd7610002,
> +	0x0001086f, 0xd7610002,
> +	0x00010a78, 0xd7610002,
> +	0x00010e7b, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
> @@ -3896,273 +3787,389 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
>   	0x00000000, 0xd8500000,
> -	0x00000000, 0xc4068070,
> +	0x00000000, 0xb8faf811,
> +	0xd7610002, 0x00010c7a,
> +	0xb8faf801, 0xd7610002,
> +	0x0001107a, 0xb8faf814,
> +	0xd7610002, 0x0001127a,
> +	0xb8faf815, 0xd7610002,
> +	0x0001147a, 0xb8faf812,
> +	0xd7610002, 0x0001167a,
> +	0xb8faf813, 0xd7610002,
> +	0x0001187a, 0xb8faf802,
> +	0xd7610002, 0x00011a7a,
> +	0xbefa50c1, 0xbfc70000,
> +	0xd7610002, 0x00011c7a,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xbefe00ff, 0x0000ffff,
> +	0xbeff0080, 0xc4068070,
> +	0x008ce802, 0x00000000,
> +	0xbefe00c1, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0xbef600ff,
> +	0x01000000, 0xbef90080,
> +	0xbefd0080, 0xbf800000,
> +	0xbe804100, 0xbe824102,
> +	0xbe844104, 0xbe864106,
> +	0xbe884108, 0xbe8a410a,
> +	0xbe8c410c, 0xbe8e410e,
> +	0xbf068079, 0xbfa10032,
> +	0xd7610002, 0x00010000,
> +	0xd7610002, 0x00010201,
> +	0xd7610002, 0x00010402,
> +	0xd7610002, 0x00010603,
> +	0xd7610002, 0x00010804,
> +	0xd7610002, 0x00010a05,
> +	0xd7610002, 0x00010c06,
> +	0xd7610002, 0x00010e07,
> +	0xd7610002, 0x00011008,
> +	0xd7610002, 0x00011209,
> +	0xd7610002, 0x0001140a,
> +	0xd7610002, 0x0001160b,
> +	0xd7610002, 0x0001180c,
> +	0xd7610002, 0x00011a0d,
> +	0xd7610002, 0x00011c0e,
> +	0xd7610002, 0x00011e0f,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0x80799079, 0xbfa00038,
> +	0xd7610002, 0x00012000,
> +	0xd7610002, 0x00012201,
> +	0xd7610002, 0x00012402,
> +	0xd7610002, 0x00012603,
> +	0xd7610002, 0x00012804,
> +	0xd7610002, 0x00012a05,
> +	0xd7610002, 0x00012c06,
> +	0xd7610002, 0x00012e07,
> +	0xd7610002, 0x00013008,
> +	0xd7610002, 0x00013209,
> +	0xd7610002, 0x0001340a,
> +	0xd7610002, 0x0001360b,
> +	0xd7610002, 0x0001380c,
> +	0xd7610002, 0x00013a0d,
> +	0xd7610002, 0x00013c0e,
> +	0xd7610002, 0x00013e0f,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0x80799079, 0xc4068070,
>   	0x008ce802, 0x00000000,
> -	0xbefe00c1, 0x857d9973,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8fb4306, 0x8b7bc17b,
> -	0xbfa10044, 0x8b7aff6d,
> -	0x80000000, 0xbfa10041,
> -	0x847b897b, 0xbef6007b,
> -	0xb8f03b05, 0x80708170,
> -	0xbf0d9973, 0xbfa20002,
> -	0x84708970, 0xbfa00001,
> -	0x84708a70, 0xb8fa1e06,
> -	0x847a8a7a, 0x80707a70,
> -	0x8070ff70, 0x00000200,
>   	0x8070ff70, 0x00000080,
> -	0xbef600ff, 0x01000000,
> -	0xd71f0000, 0x000100c1,
> -	0xd7200000, 0x000200c1,
> -	0x16000084, 0x857d9973,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbefd0080, 0xbfa20013,
> -	0xbe8300ff, 0x00000080,
> -	0xbf800000, 0xbf800000,
> -	0xbf800000, 0xd8d80000,
> -	0x01000000, 0xbf8a0000,
> -	0xc4068070, 0x008ce801,
> -	0x00000000, 0x807d037d,
> -	0x80700370, 0xd5250000,
> -	0x0001ff00, 0x00000080,
> -	0xbf0a7b7d, 0xbfa2fff3,
> -	0xbfa00012, 0xbe8300ff,
> -	0x00000100, 0xbf800000,
> +	0xbef90080, 0x7e040280,
> +	0x807d907d, 0xbf0aff7d,
> +	0x00000060, 0xbfa2ff88,
> +	0xbe804100, 0xbe824102,
> +	0xbe844104, 0xbe864106,
> +	0xbe884108, 0xbe8a410a,
> +	0xd7610002, 0x00010000,
> +	0xd7610002, 0x00010201,
> +	0xd7610002, 0x00010402,
> +	0xd7610002, 0x00010603,
> +	0xd7610002, 0x00010804,
> +	0xd7610002, 0x00010a05,
> +	0xd7610002, 0x00010c06,
> +	0xd7610002, 0x00010e07,
> +	0xd7610002, 0x00011008,
> +	0xd7610002, 0x00011209,
> +	0xd7610002, 0x0001140a,
> +	0xd7610002, 0x0001160b,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xd8500000, 0x00000000,
> +	0xc4068070, 0x008ce802,
> +	0x00000000, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8fb4306,
> +	0x8b7bc17b, 0xbfa10044,
> +	0x8b7aff6d, 0x80000000,
> +	0xbfa10041, 0x847b897b,
> +	0xbef6007b, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0x8070ff70,
> +	0x00000200, 0x8070ff70,
> +	0x00000080, 0xbef600ff,
> +	0x01000000, 0xd71f0000,
> +	0x000100c1, 0xd7200000,
> +	0x000200c1, 0x16000084,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xbfa20013, 0xbe8300ff,
> +	0x00000080, 0xbf800000,
>   	0xbf800000, 0xbf800000,
>   	0xd8d80000, 0x01000000,
>   	0xbf8a0000, 0xc4068070,
>   	0x008ce801, 0x00000000,
>   	0x807d037d, 0x80700370,
>   	0xd5250000, 0x0001ff00,
> -	0x00000100, 0xbf0a7b7d,
> -	0xbfa2fff3, 0xbefe00c1,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20004,
> -	0xbef000ff, 0x00000200,
> -	0xbeff0080, 0xbfa00003,
> -	0xbef000ff, 0x00000400,
> -	0xbeff00c1, 0xb8fb3b05,
> -	0x807b817b, 0x847b827b,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa2001b,
> -	0xbef600ff, 0x01000000,
> -	0xbefd0084, 0xbf0a7b7d,
> -	0xbfa10040, 0x7e008700,
> -	0x7e028701, 0x7e048702,
> -	0x7e068703, 0xc4068070,
> -	0x008ce800, 0x00000000,
> +	0x00000080, 0xbf0a7b7d,
> +	0xbfa2fff3, 0xbfa00012,
> +	0xbe8300ff, 0x00000100,
> +	0xbf800000, 0xbf800000,
> +	0xbf800000, 0xd8d80000,
> +	0x01000000, 0xbf8a0000,
>   	0xc4068070, 0x008ce801,
> -	0x00008000, 0xc4068070,
> -	0x008ce802, 0x00010000,
> -	0xc4068070, 0x008ce803,
> -	0x00018000, 0x807d847d,
> -	0x8070ff70, 0x00000200,
> -	0xbf0a7b7d, 0xbfa2ffeb,
> -	0xbfa0002a, 0xbef600ff,
> +	0x00000000, 0x807d037d,
> +	0x80700370, 0xd5250000,
> +	0x0001ff00, 0x00000100,
> +	0xbf0a7b7d, 0xbfa2fff3,
> +	0xbefe00c1, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20004, 0xbef000ff,
> +	0x00000200, 0xbeff0080,
> +	0xbfa00003, 0xbef000ff,
> +	0x00000400, 0xbeff00c1,
> +	0xb8fb3b05, 0x807b817b,
> +	0x847b827b, 0x857d9973,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa2001b, 0xbef600ff,
>   	0x01000000, 0xbefd0084,
> -	0xbf0a7b7d, 0xbfa10015,
> +	0xbf0a7b7d, 0xbfa10040,
>   	0x7e008700, 0x7e028701,
>   	0x7e048702, 0x7e068703,
>   	0xc4068070, 0x008ce800,
>   	0x00000000, 0xc4068070,
> -	0x008ce801, 0x00010000,
> +	0x008ce801, 0x00008000,
>   	0xc4068070, 0x008ce802,
> -	0x00020000, 0xc4068070,
> -	0x008ce803, 0x00030000,
> +	0x00010000, 0xc4068070,
> +	0x008ce803, 0x00018000,
>   	0x807d847d, 0x8070ff70,
> -	0x00000400, 0xbf0a7b7d,
> -	0xbfa2ffeb, 0xb8fb1e06,
> -	0x8b7bc17b, 0xbfa1000d,
> -	0x847b837b, 0x807b7d7b,
> -	0xbefe00c1, 0xbeff0080,
> -	0x7e008700, 0xc4068070,
> -	0x008ce800, 0x00000000,
> -	0x807d817d, 0x8070ff70,
> -	0x00000080, 0xbf0a7b7d,
> -	0xbfa2fff7, 0xbfa0016e,
> -	0xbef4007e, 0x8b75ff7f,
> -	0x0000ffff, 0x8c75ff75,
> -	0x00040000, 0xbef60080,
> -	0xbef700ff, 0x10807fac,
> -	0xbef1007f, 0xb8f20742,
> -	0x84729972, 0x8b6eff7f,
> -	0x04000000, 0xbfa1003b,
> -	0xbefe00c1, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8ef4306, 0x8b6fc16f,
> -	0xbfa10030, 0x846f896f,
> -	0xbef6006f, 0xb8f83b05,
> -	0x80788178, 0xbf0d9972,
> -	0xbfa20002, 0x84788978,
> -	0xbfa00001, 0x84788a78,
> -	0xb8ee1e06, 0x846e8a6e,
> -	0x80786e78, 0x8078ff78,
> -	0x00000200, 0x8078ff78,
> -	0x00000080, 0xbef600ff,
> -	0x01000000, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbefd0080, 0xbfa2000d,
> -	0xc4050078, 0x0080e800,
> -	0x00000000, 0xbf8a0000,
> -	0xdac00000, 0x00000000,
> -	0x807dff7d, 0x00000080,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xbfa2fff4,
> -	0xbfa0000c, 0xc4050078,
> -	0x0080e800, 0x00000000,
> -	0xbf8a0000, 0xdac00000,
> -	0x00000000, 0x807dff7d,
> -	0x00000100, 0x8078ff78,
> -	0x00000100, 0xbf0a6f7d,
> -	0xbfa2fff4, 0xbef80080,
> -	0xbefe00c1, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8ef3b05, 0x806f816f,
> -	0x846f826f, 0x857d9972,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa2002c, 0xbef600ff,
> -	0x01000000, 0xbeee0078,
> -	0x8078ff78, 0x00000200,
> -	0xbefd0084, 0xbf0a6f7d,
> -	0xbfa10061, 0xc4050078,
> -	0x008ce800, 0x00000000,
> -	0xc4050078, 0x008ce801,
> -	0x00008000, 0xc4050078,
> -	0x008ce802, 0x00010000,
> -	0xc4050078, 0x008ce803,
> -	0x00018000, 0xbf8a0000,
> -	0x7e008500, 0x7e028501,
> -	0x7e048502, 0x7e068503,
> -	0x807d847d, 0x8078ff78,
> -	0x00000200, 0xbf0a6f7d,
> -	0xbfa2ffea, 0xc405006e,
> -	0x008ce800, 0x00000000,
> -	0xc405006e, 0x008ce801,
> -	0x00008000, 0xc405006e,
> -	0x008ce802, 0x00010000,
> -	0xc405006e, 0x008ce803,
> -	0x00018000, 0xbf8a0000,
> -	0xbfa0003d, 0xbef600ff,
> -	0x01000000, 0xbeee0078,
> -	0x8078ff78, 0x00000400,
> -	0xbefd0084, 0xbf0a6f7d,
> -	0xbfa10016, 0xc4050078,
> -	0x008ce800, 0x00000000,
> -	0xc4050078, 0x008ce801,
> -	0x00010000, 0xc4050078,
> -	0x008ce802, 0x00020000,
> -	0xc4050078, 0x008ce803,
> -	0x00030000, 0xbf8a0000,
> -	0x7e008500, 0x7e028501,
> -	0x7e048502, 0x7e068503,
> -	0x807d847d, 0x8078ff78,
> -	0x00000400, 0xbf0a6f7d,
> -	0xbfa2ffea, 0xb8ef1e06,
> -	0x8b6fc16f, 0xbfa1000f,
> -	0x846f836f, 0x806f7d6f,
> -	0xbefe00c1, 0xbeff0080,
> -	0xc4050078, 0x008ce800,
> -	0x00000000, 0xbf8a0000,
> -	0x7e008500, 0x807d817d,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xdiff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 7d6219cd5bd2c..6883f16b89cfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -461,7 +461,7 @@ L_SAVE_HWREG:
         s_andn2_b32     s_save_state_priv, s_save_state_priv, 
SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
         s_or_b32        s_save_state_priv, s_save_state_priv, s_save_tmp

-       s_andn2_b32     s_save_tmp, s_save_pc_hi, 
S_SAVE_PC_HI_FIRST_WAVE_MASK
+       s_and_b32       s_save_tmp, s_save_pc_hi, ADDRESS_HI32_MASK
         v_writelane_b32 v2, s_save_m0, 0x0
         v_writelane_b32 v2, s_save_pc_lo, 0x1
         v_writelane_b32 v2, s_save_tmp, 0x2bfa2fff6,
> -	0xbeff00c1, 0xc405006e,
> +	0x00000200, 0xbf0a7b7d,
> +	0xbfa2ffeb, 0xbfa0002a,
> +	0xbef600ff, 0x01000000,
> +	0xbefd0084, 0xbf0a7b7d,
> +	0xbfa10015, 0x7e008700,
> +	0x7e028701, 0x7e048702,
> +	0x7e068703, 0xc4068070,
>   	0x008ce800, 0x00000000,
> -	0xc405006e, 0x008ce801,
> -	0x00010000, 0xc405006e,
> +	0xc4068070, 0x008ce801,
> +	0x00010000, 0xc4068070,
>   	0x008ce802, 0x00020000,
> -	0xc405006e, 0x008ce803,
> -	0x00030000, 0xbf8a0000,
> +	0xc4068070, 0x008ce803,
> +	0x00030000, 0x807d847d,
> +	0x8070ff70, 0x00000400,
> +	0xbf0a7b7d, 0xbfa2ffeb,
> +	0xb8fb1e06, 0x8b7bc17b,
> +	0xbfa1000d, 0x847b837b,
> +	0x807b7d7b, 0xbefe00c1,
> +	0xbeff0080, 0x7e008700,
> +	0xc4068070, 0x008ce800,
> +	0x00000000, 0x807d817d,
> +	0x8070ff70, 0x00000080,
> +	0xbf0a7b7d, 0xbfa2fff7,
> +	0xbfa00171, 0xbef4007e,
> +	0x8b75ff7f, 0x0000ffff,
> +	0x8c75ff75, 0x00040000,
> +	0xbef60080, 0xbef700ff,
> +	0x10807fac, 0xbef1007f,
> +	0xb8f20742, 0x84729972,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa1003b, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef4306,
> +	0x8b6fc16f, 0xbfa10030,
> +	0x846f896f, 0xbef6006f,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
>   	0x84788a78, 0xb8ee1e06,
>   	0x846e8a6e, 0x80786e78,
>   	0x8078ff78, 0x00000200,
> -	0x80f8ff78, 0x00000050,
> +	0x8078ff78, 0x00000080,
>   	0xbef600ff, 0x01000000,
> -	0xbefd00ff, 0x0000006c,
> -	0x80f89078, 0xf462403a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd847d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0x80f8a078, 0xf462603a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd887d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0x80f8c078, 0xf462803a,
> -	0xf0000000, 0xbf8a0000,
> -	0x80fd907d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0xbe884308, 0xbe8a430a,
> -	0xbe8c430c, 0xbe8e430e,
> -	0xbf06807d, 0xbfa1fff0,
> -	0xb980f801, 0x00000000,
> -	0xb8f83b05, 0x80788178,
> -	0xbf0d9972, 0xbfa20002,
> -	0x84788978, 0xbfa00001,
> -	0x84788a78, 0xb8ee1e06,
> -	0x846e8a6e, 0x80786e78,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xbfa2000d, 0xc4050078,
> +	0x0080e800, 0x00000000,
> +	0xbf8a0000, 0xdac00000,
> +	0x00000000, 0x807dff7d,
> +	0x00000080, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff4, 0xbfa0000c,
> +	0xc4050078, 0x0080e800,
> +	0x00000000, 0xbf8a0000,
> +	0xdac00000, 0x00000000,
> +	0x807dff7d, 0x00000100,
> +	0x8078ff78, 0x00000100,
> +	0xbf0a6f7d, 0xbfa2fff4,
> +	0xbef80080, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef3b05,
> +	0x806f816f, 0x846f826f,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa2002c,
> +	0xbef600ff, 0x01000000,
> +	0xbeee0078, 0x8078ff78,
> +	0x00000200, 0xbefd0084,
> +	0xbf0a6f7d, 0xbfa10061,
> +	0xc4050078, 0x008ce800,
> +	0x00000000, 0xc4050078,
> +	0x008ce801, 0x00008000,
> +	0xc4050078, 0x008ce802,
> +	0x00010000, 0xc4050078,
> +	0x008ce803, 0x00018000,
> +	0xbf8a0000, 0x7e008500,
> +	0x7e028501, 0x7e048502,
> +	0x7e068503, 0x807d847d,
>   	0x8078ff78, 0x00000200,
> +	0xbf0a6f7d, 0xbfa2ffea,
> +	0xc405006e, 0x008ce800,
> +	0x00000000, 0xc405006e,
> +	0x008ce801, 0x00008000,
> +	0xc405006e, 0x008ce802,
> +	0x00010000, 0xc405006e,
> +	0x008ce803, 0x00018000,
> +	0xbf8a0000, 0xbfa0003d,
>   	0xbef600ff, 0x01000000,
> -	0xbeff0071, 0xf4621bfa,
> +	0xbeee0078, 0x8078ff78,
> +	0x00000400, 0xbefd0084,
> +	0xbf0a6f7d, 0xbfa10016,
> +	0xc4050078, 0x008ce800,
> +	0x00000000, 0xc4050078,
> +	0x008ce801, 0x00010000,
> +	0xc4050078, 0x008ce802,
> +	0x00020000, 0xc4050078,
> +	0x008ce803, 0x00030000,
> +	0xbf8a0000, 0x7e008500,
> +	0x7e028501, 0x7e048502,
> +	0x7e068503, 0x807d847d,
> +	0x8078ff78, 0x00000400,
> +	0xbf0a6f7d, 0xbfa2ffea,
> +	0xb8ef1e06, 0x8b6fc16f,
> +	0xbfa1000f, 0x846f836f,
> +	0x806f7d6f, 0xbefe00c1,
> +	0xbeff0080, 0xc4050078,
> +	0x008ce800, 0x00000000,
> +	0xbf8a0000, 0x7e008500,
> +	0x807d817d, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff6, 0xbeff00c1,
> +	0xc405006e, 0x008ce800,
> +	0x00000000, 0xc405006e,
> +	0x008ce801, 0x00010000,
> +	0xc405006e, 0x008ce802,
> +	0x00020000, 0xc405006e,
> +	0x008ce803, 0x00030000,
> +	0xbf8a0000, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0x80f8ff78,
> +	0x00000050, 0xbef600ff,
> +	0x01000000, 0xbefd00ff,
> +	0x0000006c, 0x80f89078,
> +	0xf462403a, 0xf0000000,
> +	0xbf8a0000, 0x80fd847d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0x80f8a078,
> +	0xf462603a, 0xf0000000,
> +	0xbf8a0000, 0x80fd887d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0x80f8c078,
> +	0xf462803a, 0xf0000000,
> +	0xbf8a0000, 0x80fd907d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0xbe884308,
> +	0xbe8a430a, 0xbe8c430c,
> +	0xbe8e430e, 0xbf06807d,
> +	0xbfa1fff0, 0xb980f801,
> +	0x00000000, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0xbef600ff,
> +	0x01000000, 0xbeff0071,
> +	0xf4621bfa, 0xf0000000,
> +	0x80788478, 0xf4621b3a,
>   	0xf0000000, 0x80788478,
> -	0xf4621b3a, 0xf0000000,
> -	0x80788478, 0xf4621b7a,
> +	0xf4621b7a, 0xf0000000,
> +	0x80788478, 0xf4621c3a,
>   	0xf0000000, 0x80788478,
> -	0xf4621c3a, 0xf0000000,
> -	0x80788478, 0xf4621c7a,
> +	0xf4621c7a, 0xf0000000,
> +	0x80788478, 0xf4621eba,
>   	0xf0000000, 0x80788478,
> -	0xf4621eba, 0xf0000000,
> -	0x80788478, 0xf4621efa,
> +	0xf4621efa, 0xf0000000,
> +	0x80788478, 0xf4621e7a,
>   	0xf0000000, 0x80788478,
> -	0xf4621e7a, 0xf0000000,
> -	0x80788478, 0xf4621cfa,
> +	0xf4621cfa, 0xf0000000,
> +	0x80788478, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> +	0xbf8a0000, 0xb96ef814,
>   	0xf4621bba, 0xf0000000,
>   	0x80788478, 0xbf8a0000,
> -	0xb96ef814, 0xf4621bba,
> +	0xb96ef815, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8a0000, 0xb96ef815,
> +	0xbf8a0000, 0xb96ef812,
>   	0xf4621bba, 0xf0000000,
>   	0x80788478, 0xbf8a0000,
> -	0xb96ef812, 0xf4621bba,
> +	0xb96ef813, 0x8b6eff7f,
> +	0x04000000, 0xbfa1000d,
> +	0x80788478, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8a0000, 0xb96ef813,
> -	0x8b6eff7f, 0x04000000,
> -	0xbfa1000d, 0x80788478,
> -	0xf4621bba, 0xf0000000,
> -	0x80788478, 0xbf8a0000,
> -	0xbf0d806e, 0xbfa10006,
> -	0x856e906e, 0x8b6e6e6e,
> -	0xbfa10003, 0xbe804ec1,
> -	0x816ec16e, 0xbfa0fffb,
> -	0xbefd006f, 0xbefe0070,
> -	0xbeff0071, 0xb97b2011,
> -	0x857b867b, 0xb97b0191,
> -	0x857b827b, 0xb97bba11,
> -	0xb973f801, 0xb8ee3b05,
> -	0x806e816e, 0xbf0d9972,
> -	0xbfa20002, 0x846e896e,
> -	0xbfa00001, 0x846e8a6e,
> -	0xb8ef1e06, 0x846f8a6f,
> -	0x806e6f6e, 0x806eff6e,
> -	0x00000200, 0x806e746e,
> -	0x826f8075, 0x8b6fff6f,
> -	0x0000ffff, 0xf4605c37,
> -	0xf8000050, 0xf4605d37,
> -	0xf8000060, 0xf4601e77,
> -	0xf8000074, 0xbf8a0000,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> +	0xbf8a0000, 0xbf0d806e,
> +	0xbfa10006, 0x856e906e,
> +	0x8b6e6e6e, 0xbfa10003,
> +	0xbe804ec1, 0x816ec16e,
> +	0xbfa0fffb, 0xbefd006f,
> +	0xbefe0070, 0xbeff0071,
> +	0xb97b2011, 0x857b867b,
> +	0xb97b0191, 0x857b827b,
> +	0xb97bba11, 0xb973f801,
> +	0xb8ee3b05, 0x806e816e,
> +	0xbf0d9972, 0xbfa20002,
> +	0x846e896e, 0xbfa00001,
> +	0x846e8a6e, 0xb8ef1e06,
> +	0x846f8a6f, 0x806e6f6e,
> +	0x806eff6e, 0x00000200,
> +	0x806e746e, 0x826f8075,
> +	0x8b6fff6f, 0x0000ffff,
> +	0xf4605c37, 0xf8000050,
> +	0xf4605d37, 0xf8000060,
> +	0xf4601e77, 0xf8000074,
> +	0xbf8a0000, 0x936eff6d,
> +	0x0002001a, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0xb96e081a,
>   	0xb97af804, 0xbe804ec2,
>   	0xbf94fffe, 0xbe804a6c,
>   	0xbe804ec2, 0xbf94fffe,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 5a1a1b1f897f..7d6219cd5bd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -78,6 +78,10 @@ var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
> +
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
> +
>   var BARRIER_STATE_SIGNAL_OFFSET			= 16
>   var BARRIER_STATE_VALID_OFFSET			= 0
>   
> @@ -94,6 +98,14 @@ var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
>   var S_SAVE_PC_HI_FIRST_WAVE_MASK		= 0x80000000
>   var S_SAVE_PC_HI_FIRST_WAVE_SHIFT		= 31
>   
> +var S_SCHED_MODE_DEP_MODE_SHIFT			= 26
> +var S_SCHED_MODE_DEP_MODE_SIZE			= 2
> +var S_SCHED_MODE_DEP_MODE_MASK			= 0xC000000
> +
> +#if ASIC_FAMILY == CHIP_GFX12
> +var s_sched_mode				= ttmp1
> +#endif
> +
>   var s_sgpr_save_num				= 108
>   
>   var s_save_spi_init_lo				= exec_lo
> @@ -160,8 +172,19 @@ L_JUMP_TO_RESTORE:
>   	s_branch	L_RESTORE
>   
>   L_SKIP_RESTORE:
> +	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
> +	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)
> +	s_wait_alu	0
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
> +		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
> +
>   	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
>   
> +	// Save SCHED_MODE[1:0] into s_sched_mode[27:26].
> +	s_andn2_b32	s_sched_mode, s_sched_mode, S_SCHED_MODE_DEP_MODE_MASK
> +	s_lshl_b32	ttmp2, ttmp2, S_SCHED_MODE_DEP_MODE_SHIFT
> +	s_or_b32	s_sched_mode, s_sched_mode, ttmp2
> +
>   	// Clear SPI_PRIO: do not save with elevated priority.
>   	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
>   	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
> @@ -278,6 +301,8 @@ L_TRAP_CASE:
>   	s_addc_u32	ttmp1, ttmp1, 0x0
>   
>   L_EXIT_TRAP:
> +	// ttmp1 may alias s_sched_mode.
> +	s_bfe_u32	ttmp2, s_sched_mode, (S_SCHED_MODE_DEP_MODE_SHIFT | (S_SCHED_MODE_DEP_MODE_SIZE << 0x10))
>   	s_and_b32	ttmp1, ttmp1, 0xFFFF
>   
>   	// Restore SQ_WAVE_STATUS.
> @@ -287,6 +312,11 @@ L_EXIT_TRAP:
>   	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
>   	// Only restore fields which the trap handler changes.
>   	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +
> +	// Assume relaxed scheduling mode after this point.
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE, SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, \
> +		 SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), ttmp2
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
>   		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
>   
> @@ -301,7 +331,7 @@ L_SAVE:
>   	s_endpgm
>   L_HAVE_VGPRS:
>   
> -	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
> +	s_andn2_b32	s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK	// Clear unused bits for storage

Do we need that? We are saving, we will not restore the scheduling mode 
from this point.  With this change, we would save the sched_mode in the 
PC slot.

Would need something like that to avoid the issue:

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm 
b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 7d6219cd5bd2c..6883f16b89cfd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -461,7 +461,7 @@ L_SAVE_HWREG:
         s_andn2_b32     s_save_state_priv, s_save_state_priv, 
SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
         s_or_b32        s_save_state_priv, s_save_state_priv, s_save_tmp

-       s_andn2_b32     s_save_tmp, s_save_pc_hi, 
S_SAVE_PC_HI_FIRST_WAVE_MASK
+       s_and_b32       s_save_tmp, s_save_pc_hi, 0x0000ffff
         v_writelane_b32 v2, s_save_m0, 0x0
         v_writelane_b32 v2, s_save_pc_lo, 0x1
         v_writelane_b32 v2, s_save_tmp, 0x2

but I think it would be easier to just clear the top bits in ttmp1 as 
soon as we know that we won't s_rfe.

Best,
Lancelot.

>   	s_mov_b32	s_save_tmp, 0
>   	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
>   
> @@ -1039,10 +1069,17 @@ L_SKIP_BARRIER_RESTORE:
>   	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 scope:SCOPE_SYS
>   	s_wait_idle
>   
> +	// s_restore_pc_hi may alias s_sched_mode.
> +	s_bfe_u32	s_restore_tmp, s_sched_mode, (S_SCHED_MODE_DEP_MODE_SHIFT | (S_SCHED_MODE_DEP_MODE_SIZE << 0x10))
>   	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
> +
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
>   
> +	// Assume relaxed scheduling mode after this point.
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE, SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, \
> +		 SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), s_restore_tmp
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
>   
>   	// Make barrier and LDS state visible to all waves in the group.

