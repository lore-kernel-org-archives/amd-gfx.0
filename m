Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDECCD183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 06:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089F110E964;
	Thu, 16 Oct 2025 06:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/jg9ZUV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268B010E963
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 06:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJOFSbYnpV8eGJAdmlU0R1IRVmRdO279pmO2RDAWrHwhWbMGfe0c0qib575Y65ACi4oBQZghWyTw4n9B19iVPesY3wz2Hgy2LQy+8ZgKQBl9IDPdCL9l5pRZ/xAItJjIOaPSATdveelJeML4/5jwqWJrTSUWdvri1blfHi1Q4QOW2Tya9MxH/MDBTq+W8I3duYWhfUWcAj+bk9ylXIZjxU/ouo1V7NoKwvd+VGZpIQ4CkJ7hJFm3a4gVjoGZVjCr/WfiqrvSOVW0m+9VlfOnmkpdHggJH4TmsvslfoRRwnPPH7mcF7qsnFtGdrEc/EfcL8u1nR37LYTpZae57faJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ygtv2kVKzmifZazoBQMxpMelsoN9iT9fF1fMH4kt0o=;
 b=Ph+XrKBGb/H9lq1ZU1vtavOJzxzJsv6BUVVH9Yjw6Vu4UxUcH3CQW5kBMZseEHV7rMomNaN6IXXXxfqqev51xnLaeCUEkGCKvcl4TJFBlPClJ50X1POTT5TEvP/PhE7VJXzRtD0XtSoCY/IUlHZ+1cGI2rg3nQLezNBe1tqZoJxN6bndfp2bQ/WbPU1KcnWpbXf/pIUjAI3T/LTt2ec52of52NUyd1ptYMpDArjZFCWypneB83Bw9g7rvW6AJ1/5hcC+oXkb+Zn2VfWEEhNlF2zIO5XxptybLK4T1ABPEGO5CAnDzuQiaomJ44mOUosUglPljycsZT6x4Qw8HYrEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ygtv2kVKzmifZazoBQMxpMelsoN9iT9fF1fMH4kt0o=;
 b=U/jg9ZUVDmre24Z0Dje+lDZov0R0vDGhIVDtWrJJ84cY5S5csAfA5su7o8V5nHpjLVoIZM/ILHBaaD58XrwoKOXFNZYNUf8A8CfWy2yLiKWI3PHapM+lNVNcBdx1MleEfo05qSu2Zm3ds1xHrXRghyRqGTxnh8SXYuZhRtFDchg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 06:41:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 06:41:10 +0000
Message-ID: <b319a8c7-5478-49cd-afc2-2184d126a2f8@amd.com>
Date: Thu, 16 Oct 2025 12:11:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amd: Check that VPE has reached DPM0 in idle
 handler
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Peyton.Lee@amd.com, Sultan Alsawaf <sultan@kerneltoast.com>
References: <20251015021305.624573-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251015021305.624573-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0087.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 453bb654-ca00-427b-1e4a-08de0c7efdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHVHVi9CRVNHYXBrVXMvMmZZS1BweFJ0eDRiM2dVTXJ2cTc0cURjRENmRTY2?=
 =?utf-8?B?enp5VHdnUURNSkMvejFMc0R3L2UxVVM1aFNwSGpGeFZSdlhtbEZJVDBDdU1R?=
 =?utf-8?B?RjA5NVFNWXNqTURxMTljNkJ0QkFZOVQvK0pxWDFPa0dpUjRiRWNQZmFUN2JX?=
 =?utf-8?B?NmgwQ1BDS3k0ZWZlbkpnYW9lMnk4YWwvM09ibzBVMkVTMGd1eHhVZnRvYllF?=
 =?utf-8?B?Z1V3Wk51c1ZyUytKMDFZTnkxd2U0UFU4M2lqNHZHK3Bic21UaWRZSjl3T09G?=
 =?utf-8?B?NnBqSE51YnY4aWZmRHU2a1UxN0R5RE0yZU5PTlNLMCtpbVV6bTNPSG9BejVo?=
 =?utf-8?B?OC8wenFJeElaNWtXRnl0UURTcjE5OURIVXY1amZhWHJtVWV5c2VDbVFFM0lB?=
 =?utf-8?B?bVJDdURFVFRNS3BFdUpzY2NUQnBFMnp3U1hDOGVoT2F2VTcyb2MrSWRxNUpG?=
 =?utf-8?B?bTRhOW1TczdOczl6OUNURmFSVTZIaVNtdjhJcjBCR0dFVVdCSU1YQ0Uxa2p0?=
 =?utf-8?B?THVTbzRXOGJCYmp1TkttUDdqdDJPeW84T3FPbVQ0ajMzNmgyQkRtWGVhcDgw?=
 =?utf-8?B?aGN2Q2p2UDdiV1lzQWxyNjdqQ25IWnZkUWV4VzB6OW5tdU5xbnNrdWVXaVdU?=
 =?utf-8?B?ZVZoZUVMdnlKZDNTUlprK0tsa0hobmJTMnBrRTdOSDdsZDFYeFVyaUdyeGpS?=
 =?utf-8?B?RmtpS0pHcE5XTWsxYjNnRTd3U0g3Sm5RQmN5YXFaRWkrSVNKNWFFYlFUK0NF?=
 =?utf-8?B?NkJpSUplanQwK2VmSzhyejUyQjBjWnFjRVNzYk9KbkRxMmRUYjNScTRqZjlv?=
 =?utf-8?B?RGpjQ2ZXVmMxMTl0cGRhOW5DZEJKYVBRYmFRbDF6KzBwY0hmcXVYbEsyODMr?=
 =?utf-8?B?aTg0M1lqMEtoeGtxWTlXSHY1LzFMVDZVVEVNRjdiaTlsaWQwVUExYTZTR2lN?=
 =?utf-8?B?RTJHNkxCUWlWTWFqUXhyZzY5b2UxVWhsbCtSTG1nc01DdlBjKzR1TDNCLzQx?=
 =?utf-8?B?eU9ibWtldDlBcjV4Vk1QUWMwZkw0RFlTQzFPRlBIcElUMUswTkJUa0hwc2tt?=
 =?utf-8?B?TGRLbFFFUEcxallmYVhXM3BYTnZacUtjZnQ5dXlxZGxkQkNCbFFSM3Ntcjk5?=
 =?utf-8?B?Y21xTmNpUXJ4aDhKWjZLYW0xdGQxckZnZDE5dk0vb1V3bEdFWWVCTkhWTlg5?=
 =?utf-8?B?cE1DeWZEaUtwa2dwVGx0TmpNc3VFSXRlY3JhRUJOMkJYVDJ5UjZLM2lwZUJP?=
 =?utf-8?B?SW0rVGRvQm9XMkhpTEJxdjcrMEZIa0orMEp1dDRrVUtiQTlVUlZmY3N3UFRU?=
 =?utf-8?B?Vlg4TDRGQndPSG5VSG9TZE9Majgwb3EvQytUSmkzREFrNnI4REJhS2w4aFhQ?=
 =?utf-8?B?NEwzYXZSR2VMb05pWVNBZWdaZUphVXFoeHJRQ1hTcmxRamJUWWpTdjN1a0Zm?=
 =?utf-8?B?SGJoWEVLaUFFalZwVDlNVFBzUzdSR1V6M3RyRDZ6NkQvRmxqWUZVQksxWldv?=
 =?utf-8?B?UUUzYTVCd1pJdmZpQmJDQTNKS3VIVVpudDVXVkZSdDV4V1l3dEN2ZDVOU3NP?=
 =?utf-8?B?WDh3bFVDVThDVDZaam1UT3dOa011eW1SNzFkb04zWGUwbk1RS2ZxOEdybzc0?=
 =?utf-8?B?TU56RlB6RU5jWkJ6N3U4bys4MTZFcEtIa0hmMXphYW4yOGhjQzZva2JmWENj?=
 =?utf-8?B?MUZjSVFRVFh3bHhUam1zWjFvR3BRaXYxQUVSZzN5UE9veEVkWUI2SXJFSUI2?=
 =?utf-8?B?ajdwTjVadTZEZWRwazFIcmxpMHFUbEtHczMvVjhiN09sbXBxUE1Vb2lkRDJq?=
 =?utf-8?B?TXoyWDJKSkFLRnhtVHhXaGZHQ09UQjRBN0svY0N2L1BCK0tKQi9NYVVBUHI4?=
 =?utf-8?B?NVhOWlpsNlhjL0F4TjBXVGxOa2JQMDRjUkREYm5xN0YwV2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2IwaWdUSjdCYTRUWmJETlF5K0ozYVFGdDk5cE1sWkN3dWVsVDN6MTFqN1Iy?=
 =?utf-8?B?N2Frcmh2QWNHUmpHZ0NnbTFSc0N4QnV4ZXFJaTJhSkhnL0EvSHpNUlg3U1FG?=
 =?utf-8?B?Y3Vkd2RlS0NIQTliMUE2cHlGSCtWcGRtTzhBSTN5Zlg1S3RMYXFUV3JyUjdm?=
 =?utf-8?B?M2l1NXA0N0ovYXRJb3dzaFVZU0xFaW4zTS95N0FpbWZNVzNKWFdRa1dWM2xK?=
 =?utf-8?B?a25ZcmlQRjNOd2g0VGw3K1VmRDlKTEtNU2tWbDlSS3VIZUQ4VTlJTVFwcm1w?=
 =?utf-8?B?ejR0dUJZZmJSVWdoK1RxdFZvdENxdElFU3JDSkRZR0NJcFpsY296TzF3RDRk?=
 =?utf-8?B?d3FaRUdqVDJpRDRsSzNQTnpQWW5xNGl5eWJFdTkvS1NIVERNWEh1MERHQU1j?=
 =?utf-8?B?ejdWOU9jdExiUk9YeFpFMlcvLzRKQzk3cXVPb2NtUHRjRWtRZEpYVDRGQU12?=
 =?utf-8?B?MWJPWkFUWEdCUnh5Lyt4V1ArdzF1alEvbS9abVZPSXBvdnNlYndaYndUaHE1?=
 =?utf-8?B?cjdVZ2JsNTUrcFA3RUk4T1ZUVWh6cjc5dk5LTy9vYktJNTJuN05FV0JRUTdu?=
 =?utf-8?B?c3VDc0xYV1hpVit5TS9WNGtvNWVJdzdtV3VFNXllRTAyeXFQamFWeVdQa1N0?=
 =?utf-8?B?bmp0ZXUzK2lheHB3LzlReTdPdVNwVEoyS1p5QWJpV3BEYXZCMlVUam9GcEVB?=
 =?utf-8?B?ZHZrVUFJZVZBRmJzRkVxM2FxcTY5ZERvVGcwWUlOMkQ1V1VYcXJkQjJESE9G?=
 =?utf-8?B?TFBpUndxOGpDZncvbDc2bFU5MklKZlNFT2hHZDNTbnZhVEYwNGMwaFkvQzhl?=
 =?utf-8?B?VVIxREQwR1kvN2FoMHQ4SUgyWDMxZzFWMEJFbmRFZmZxS1RaWEJpM0FvOXZh?=
 =?utf-8?B?alM1eFR2ZzN6RmZhQmlsaTA4cnUzRFhqdU0xeEh3RlJQZlRTTmdKYit2YlpL?=
 =?utf-8?B?ZFN1VEhPdUF0M1pIaXlvaHBHNldtK3I3UGlkV1V1bndyMHdkM0owdUd4Z0RN?=
 =?utf-8?B?U3ozaXNBckF2YW96NjZXYXFPNDZPaU13VjdZUTA2bDkzczNnWFcxUWFySWsv?=
 =?utf-8?B?eFdoTnNXT3ZMTnVWdE1PNTM5Nk9Kblo1OUFkMlJ2ak0wbUk5QldVWVpVMVps?=
 =?utf-8?B?eVNIU3liWDhVSTJHYnVYVFVocU5UdzhCNzdFSHFFRUFMUFp2UklUUDRTTE00?=
 =?utf-8?B?RDU2aVI0QSs0VUpNMHlJWncyZEVUMEZvZzYyOHNCL1NpUGozUlBOeTFxcGdr?=
 =?utf-8?B?bWg3Zk9UaHVDcUlHVEdSY09oUHRhbTZ2KzVuNXlkMm5SczJrUFhFdDZjZHFR?=
 =?utf-8?B?R3BvcjJyS2pKSHE5NTZkalp4aDJVV1orWGtNb2hKL1RZeVVaTytmTjR5a2VD?=
 =?utf-8?B?Z0pScEJpcWNvZXNYQmFnNUNCQUU0YmhpUytMdlp6czRFSmRTRDRGWllrQlRV?=
 =?utf-8?B?VDBxVUFRUVlxRDNXTVY3NGhVMkJiR2VrNkhLL2FxZGFFbk1yUi9qVGplRjNV?=
 =?utf-8?B?eEVxam4zM0pYamNUbWlJMm1WR0FTRVdTOVBZNU5DYVRnb1Vsd3pwWjZUblB6?=
 =?utf-8?B?ak5wWFBZOXU1NEpxc2g3UUFHTFJFUTlOOWkySVRJcGZWOFIvSU12bTBvYm5S?=
 =?utf-8?B?TFJ5SHdFWi9FUDNHcXRuSTJrU25MT3hDbENOZER3SUpKY3A0Y3hBRncxZHNT?=
 =?utf-8?B?UlV4UnJmQUxYSzN6UGNuVkpqandFN3JKM1g0RmRJQnZLWWpYSU10QVg3K3Np?=
 =?utf-8?B?NGdTN0xJVjEvN3JKZElxUXBxVEIzZjhtWXZ5K0VrREd5ZlZXZUVhODI0b0w2?=
 =?utf-8?B?dVZ2K1NEcVZ3QXU5ZzJXd2loQTI4Y3Jua0tCWlRxRXQ0NnZIcmdIVVVzanNj?=
 =?utf-8?B?WTUrYXRyQ1VBdHJBZ21tYnV1a3Fsd1FSMWJ6blpUTmI5OHVrYzVWU05WeEtV?=
 =?utf-8?B?WnA0UUs2ZnRmTXljZ21ydEx0S21PdGhLZ3FscUZmNkk5cEx4Tjc5cjEvZEZV?=
 =?utf-8?B?UUZ6dm1TRFZtOEZxZGZRa2F2YzdoQStuWFdvZ08wYTVWSG9DL21PcTgxMXIz?=
 =?utf-8?B?eWhtalZHMnVzYmw3amNBZEk2d3FoSWh3bkhZMTdpMjRFZmFmRXpoS2dNbDU0?=
 =?utf-8?Q?RLsX8aGJCkaGeR1oPWEpcb2u2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453bb654-ca00-427b-1e4a-08de0c7efdfb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 06:41:10.3677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWzRWbj24RCd0pzK1+O0sgY7QYcP2Z1hydv+oCYP9YcqZyZAnAkl7hmuAtmS6HDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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



On 10/15/2025 7:43 AM, Mario Limonciello wrote:
> [Why]
> Newer VPE microcode has functionality that will decrease DPM level
> only when a workload has run for 2 or more seconds.  If VPE is turned
> off before this DPM decrease, the SOC can get stuck with a higher
> DPM level.
> 
> This can happen from amdgpu's ring buffer test because it's a short
> quick workload for VPE and VPE is turned off after 1s.
> 
> [How]
> In idle handler besides checking fences are drained check that VPE DPM
> level is really is at DPM0. If not, schedule delayed work again until
> it is.
> 
> Cc: Peyton.Lee@amd.com
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>   * only apply to Strix Halo (VPE 6.1.1)
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 31 ++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 474bfe36c0c2..95d0badeb479 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +/*
> + * vpe_wait_dpm0: whether to reschedule idle work waiting for IP to reach DPM0
> + */
> +static int vpe_wait_dpm0(struct amdgpu_device *adev)
> +{

This is not really a wait, may be renamed as vpe_get_req_dpm_level()

> +	struct amdgpu_vpe *vpe = &adev->vpe;
> +
> +	if (!adev->pm.dpm_enabled)
> +		return 0;
> +
> +	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
> +	case IP_VERSION(6, 1, 1):
> +		break;
> +	default:
> +		return 0;
> +	}

These checks could be in a separate function like - 
vpe_need_dpm0_at_power_down(adev). It could return false once pmfw 
carries the fix for IP version.
> +
> +	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
> +}
> +
>   static void vpe_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_device *adev =
> @@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
>   	unsigned int fences = 0;
>   
>   	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
> +	if (fences)
> +		goto reschedule;
>   
> -	if (fences == 0)
> +	if (!vpe_wait_dpm0(adev)) {

This may be,

	if (vpe_need_dpm0_at_power_down(adev) && vpe_get_req_dpm_level() != 0)
		goto rechedule
	else
		power_gate()

Thanks,
Lijo
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> -	else
> -		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> +		return;
> +	}
> +
> +reschedule:
> +	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>   }
>   
>   static int vpe_common_init(struct amdgpu_vpe *vpe)

