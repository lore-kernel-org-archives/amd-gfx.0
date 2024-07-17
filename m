Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD7CC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1189E10E403;
	Wed, 17 Jul 2024 20:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MPSmjrO/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9B210E403
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRm5G9f/FsD1p7r6KDZTDKaGW+xfMFiej+DQzVi+gail5VEZJFCbstx7toMLjg+dJV92zj9wHARZanojg95cGa4aTZOMdt561/bSbUmWq2l1kpGnoKcHbJ8/kIDQ4YfMHQZX9GXyXfE4kg8Ya5Zd/cSSYO9+XL437bAT8oyPUjWC4PiyDYOuZnSUKr27zI4clNU3CUz64b5TvrHlAHtlInp0mp2ZWCF832tAEFcmbp1Tn0HN8801RPD06vazScjoT3R7qiKvNKL3j9KhdGfzdsUrGwkehmfXzw6oAwSiP+MrIvaXIVOB4varGmo5oyP5nSwK6frO42MlDlnSA+bVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA12Nd1ayo99yhX+ztIBOYQNwjgfRdAKBb8g4e1zv80=;
 b=J2tuNvlxYEpJm5HIF7mvssDSFHGstUKRPeVGapGftA31fViHJRBm8H6gGqdlownxYhppxVH9a0gpOJL9MRIOoXD88R/6Yynl10j7QJ5hHF2PPhL6bmevbKhOe/QSRb5eby3Xchqw+U9fkgUIYwzbl0y+IImZNY3ogzjwnYawmVwmffinE/UWC9HHjLf9DymqYM/KJShveGFFRSOP8pgjJ84uiPZ6eOK5aaGld24Si4kmxBwDKO1idkCoERg0hlhYQQAWZWccpdTyo3t5awtKwJkJU8gK9/CGh8mgu4dibQP+XLVZtHaURawpM+st5AG3GivozBL4o6AbL3YHu1KpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA12Nd1ayo99yhX+ztIBOYQNwjgfRdAKBb8g4e1zv80=;
 b=MPSmjrO/ylro3MoTdHzDfAemGfzs2v6H0Ov6jz7h9rNmVVzGGNEgku5DxzDeZjUxy9ZfYETjWcNKv27yaA265eaETXYGF4MWOlq+bFn2Kxye4UdrL4muFMyHUzKRhJkhGNx8kO+RBAY8HahswTnEaLOmVA66bJvo0rlJfx3USCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 20:26:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:26:27 +0000
Message-ID: <428ab0f9-7070-4852-b03d-85454ec7351d@amd.com>
Date: Wed, 17 Jul 2024 16:26:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdkfd: Ensure user queue buffers residency
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-6-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240715123502.7013-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b64bb61-6473-445d-deed-08dca69ebc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVFVMENIdU0wNWdLNVB1SGs4ZHk3aFZaeUZhYTF0QnplTWdYRzFoV3VVTWp1?=
 =?utf-8?B?c3NDZ0tiYVlocG1TTVFaaFIxb0pYaSt6dUR5NmdHSG9lNkViYTRsM0NYZnoz?=
 =?utf-8?B?K0N3TEdxRkVYZnJTN0djR3BvNjRWcGtINHdvcC90M3pZVUw2TFpxR0JWK3gy?=
 =?utf-8?B?YkMrRnViNUtVbEFvczIrNGhVbVhaZmVvL3hmMlJoZW5GVWxEYnQvSmZzNVFi?=
 =?utf-8?B?YWNxbVFCSUhuTWt3eE9OOHZLUWU4NmVqYlJKRkdVQ2QyWEkyZk9nTVEzSEQ3?=
 =?utf-8?B?aU5HMDY2ZUZqekVDTnBrREFDakdvRGFGa2NmY0F1elVockF1MFIwTGNXd1Uw?=
 =?utf-8?B?eDJkVG9vMVdZeFl0QXROUWdhZVBRNS8zZzF0OHJwNFhuczJaWUpLWC9OeWln?=
 =?utf-8?B?b1I5bzdScXBza0wyaXhZWmdzVWEyTlEzdmlmRXdZYThsZUNscGFqcXVNRWc5?=
 =?utf-8?B?bHo2dHVDdDVkcTdpeFVnTTIyQ2NlMkFwMnpXK2hCTFNOSlByR3BiWHNWSElR?=
 =?utf-8?B?NEt0TjAvTlRMWmlMV0FJS2U1eTFQYXo5NkhkY3FSL3VGamZTVEJ2LzhGY1gy?=
 =?utf-8?B?d2ZWMWZWZzVWNkVsRG5JbXFYLzhqM2swVTBJa2RaQXBKdVVTaXRiQXRmdmdw?=
 =?utf-8?B?Z3dsMTNxTWVGN1RaYktnVDNxb2dWaUI0Y05CS1U0OVowWGp2TnNuckNQdFNq?=
 =?utf-8?B?YXFKS2RuMlBLVHBFYW9teUhOMGZBWVRnNUQ3dnVqdjNaNzVaMXBETWZFbmta?=
 =?utf-8?B?c3U4VnEyQXp5ZGg4eUh0UjE5NXdpT1pjWFZwSFFaUWE3Qmc2cjFDUzdjNDR3?=
 =?utf-8?B?Vk1QOGdSd2wvdUJnZVRNYzRZU05XL1hTNVM4SlFmclN5OE9pMUdoUk5obVFi?=
 =?utf-8?B?SzBLbWVpVjJtRGxQZ3BJSFh3aWRZQjVseVVhSXkrdW56b3ZZZGFQS3IvRU1E?=
 =?utf-8?B?Nmc4RnIwT1pHMVNhdklmazJKeE5IUUllRThpVUhtU3dHRmhmdHVlVS9YMGR4?=
 =?utf-8?B?WWo0dXJQTTliMkJUUHA5Mk1MR0ZSV2xFM1dxc3drTWlGbXdFazN4UTNYd3BG?=
 =?utf-8?B?NjBidTZkREhlbkFyd1pvTElzbkNjVnBuMmZyVTJvWHpDNmJtUDBWVmIweG1F?=
 =?utf-8?B?QmlLQ01xbDFjVUdYOTNPWndmcCtRRFkwa1NiV2lYTGtranFJNFQwOGNsVlJD?=
 =?utf-8?B?eHg0UmQzckhHR0FaQ3pGYWdwcUJsamVUWjZuOFRhRTVHbGZkME9DTklIajgx?=
 =?utf-8?B?SXBpdnJKWFgxZnFrRnJsQmtBSFZyR09OU3gzYXdodjRrWEV0ZDVrTVF2U25j?=
 =?utf-8?B?U3AzRFc5SWNHLzhqMlZVampOZmFHcTZOL2ZTR05iK3o2dnltQW5CWWExbmNV?=
 =?utf-8?B?cmg0bjJrVnNpZkYwQU5oZ1ZMU0RGd3p3UVlTa0xWV3AxYmhZUjNPc1VOTndS?=
 =?utf-8?B?MlY3cVFVbUJTM2JBbWpkTTQvaCsxMHJZbS95YXVFS09sUlRDa3FqRlN1SE1J?=
 =?utf-8?B?ZUFmUTJucDRvaTAxbFMzWjh4ekd2UHZPbVFJNzJQK1pkMkUra25pY1ZhNDNO?=
 =?utf-8?B?ZGE0S3RvN0pxUCtCZmEzRjNjT2dhUnhWSjVKSWlSRHRJTmwweGNBRHh0UCtz?=
 =?utf-8?B?bzB5V2JSZGdmdzJ1Y2RGZ3QyZC9DQVRqek9FWDZQUldoc2ZxNVI1b0JmSFVm?=
 =?utf-8?B?NE5QV0oxMEJaN21IeHBFdE5jVUMrSUQway91V2lRcXdIeTJxRWpQS0Nuak1Q?=
 =?utf-8?B?MU1GSk5oNm5QbFhqbEhaaWdxYzhsbENScCt0Ni9xYWVRYnIyWExKTmk5dGky?=
 =?utf-8?B?L0gxMFVFSXg2U0d2Z2E0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFMwdzBVOUZncGNOU1hNbzQweVEwajk5NDM3WmxaNzQ3UkY0QXhFTlhjSFJY?=
 =?utf-8?B?QkFXaXNGa1FnYm9lZUYxZll2M0xQUTh6bCtCaEk5ZWh0M1Q2US9uMzVPNGVr?=
 =?utf-8?B?MFVTU091eDlQRkp1Y1EyR0pBdnJiRnQyenlHK3B0c2RVMXh6ZU9vNFFTcWI0?=
 =?utf-8?B?TkxiTkMwd2p6ajNJckYvL2UxRHQreURIS0F1aHhBNVZUcVlqQkN3eGNjMi9Y?=
 =?utf-8?B?NDkwcWFFeWhRakVPZi9NZWxDQXNTcW5IVHV3SUlJZGFwbVZyeGE4NWpXUTl6?=
 =?utf-8?B?NkVDZTNCcTZ5WTNaRkM5SGhLUGVrdExUeEl4bTNaTXRFQUdhTnJkYXlpdVgw?=
 =?utf-8?B?Q2prNkNicjBPY2dJUUF2TTgrOTFjUG1aZTNvaVFuK25PUElHTGlrcHJZSnUy?=
 =?utf-8?B?QzRHUVJiZlJwZUtvNmRhY0NPU3dMYXRXbGhIY2dPTDVuUUtsUm1GTFNPMjYr?=
 =?utf-8?B?ZmRaeHRrTTk5d2ZQYWhuYk5Ic3FCVytUTVRxOGJlZmZhTDFvU0RWbXJMRHVI?=
 =?utf-8?B?dVV2bXpGZWhHOUxjWDJtT3pnQzFKUjE1ZWJXYzVSdytodWlMS3p1bFZxK3Rr?=
 =?utf-8?B?ZnZrWGFQRVF1NWRmQlB1WFoyYm9hZmNEQlcyQ0ViR1ZxdUZmdUlZN1M5eEEx?=
 =?utf-8?B?REFtdFhBSHFJWDN1c1VIamdFSGpOK1U4eENXYzVPQTNPQ245cVlVYXRoditU?=
 =?utf-8?B?UWtTQkR0Z0RpSEJpV1l1WGwxQ21FdlloNzVaa1RRODVmNDF1L2RzS2RQVHAz?=
 =?utf-8?B?NlNVdFMrTVNkY2Y4SGxDNEJ1bytIL1ZKUksvWU5UNzBYQ0FZakNmazFobXVF?=
 =?utf-8?B?QmxYYTU2YVhzVjdlY1JVOWg3MWNNa0Eweml6YjJNa0x4eHBiYWRCN2JZUHBK?=
 =?utf-8?B?M0JVMTNzcmFYcEtudHlodEhjNjUzZTI5RWNJc3lwU2haR0pkZU1MTkFzUld1?=
 =?utf-8?B?L1p2UWV3SmM0VUtmYTJEeHJwYlY1NHl5MWpGNnB2NGY3UitjUUZ6ei8wQnlV?=
 =?utf-8?B?NHNkSDcvZjBEZCtUQjNkS2RxRXJNdFhySVJOTnRlY3ZlYk00TExyV1l0R3dF?=
 =?utf-8?B?N2ZPV1FSYU1XSlQzWEdiVVBPazlnSFY3S1pmUkszR0ZVdjgrUXh3WGMxcUFV?=
 =?utf-8?B?bGxQYTNXbmp4aTc5Tzd3L28wSlFRRmVUWlRKYklqZEo0OWQwSFRBMnRWWkY2?=
 =?utf-8?B?R0FpNjQ1ZXFZMDllVlQ1SGJFMWRPRTRybDRLeWREdUVtS3BaZ3o4amcvMHEw?=
 =?utf-8?B?UXhnVWhYYzJEck5sMHplN1NCSmNtMk02SGpvOUlCK3cyVjc4Z2F3dDBXRVJa?=
 =?utf-8?B?RENkNWUrQ2w1RHFyY2dpaXpOTkZHYzY2MWhCRCtiSzUrdXZxZnp3ZVVxNFVG?=
 =?utf-8?B?Vzd6L3ZNYjN2OVFoa3JudURuUndiZmwxaFZsc053L3NNQWhwbHd6dzcreHYr?=
 =?utf-8?B?eVBQT3hpQ0tIL2xVay9iVmRCdkVZR1lKcmtCYlJKZU5hUFdkTDU0WHpJQ250?=
 =?utf-8?B?a3p6U3VJNVZxcWc5YUE1M0x6Q0FremRQOXd4VjJKOGxTb2hKT2h1bENyQzZm?=
 =?utf-8?B?Z2I2Rjhia0lNMDVHVXl3RjRxUU1JZmxwRzI2WUVzRlJzelgwVjRYWDZYNDZQ?=
 =?utf-8?B?YS9Talk1bEdJb0VzNFFQdlNEY1g3YVNIVGo5Sm42dFBVRHNsaS9SYlZPUGxk?=
 =?utf-8?B?ZTZncFNZZDd3QWVGUzFjNFFOZ1JJVXIyaGNFVm95SXpXUWVrc2N4SGtpa0w3?=
 =?utf-8?B?NC83SVZUZGRxLzE2WjVPMkdTSzdoTVJCR1VSbEk0UGswRlRqa0lIeGwxZVdk?=
 =?utf-8?B?eHY3Z3ByaFI0aDJuZEt1NU5vYU5pT1A3b0lrM3U1M0tNZWdEL3JBUVNTYlNo?=
 =?utf-8?B?L1hNZXFIckxtbisyNy8zdDNudTNBZ2J6TlAxcHVvTmtEZk5tbmM1ME5NWXd4?=
 =?utf-8?B?NzhhdFlUSlIwWFBPK2E1Q3dWZ1IyNmJwbmZyT1lHRitNdVdJZDNhcE4zY2ZM?=
 =?utf-8?B?VG8xWnZhcUZCUzY5QTNKK1lTR2JiUDVpVWZ2YmxnSWlEYkFNZkNhMjkxcnZ2?=
 =?utf-8?B?dHdYVTVFNHNnTEVCVUFicUMzYnd1N2hLcXNsWjNVNFpaNmdsN2gxSWlzTDdF?=
 =?utf-8?Q?DQqC+GtDajDbOtThjdzjHlict?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b64bb61-6473-445d-deed-08dca69ebc23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:26:27.2519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZvcj0rnaCoi+dl6+NzzDJwHrv1mXtdv6uS8ezIDU1SK3cVI6KPk87PLFbgZBtjaZLqoWULC73fIcYBA+mKLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

On 2024-07-15 08:34, Philip Yang wrote:
> Add atomic queue_refcount to struct bo_va, return -EBUSY to fail unmap
> BO from the GPU if the bo_va queue_refcount is not zero.
>
> Create queue to increase the bo_va queue_refcount, destroy queue to
> decrease the bo_va queue_refcount, to ensure the queue buffers mapped on
> the GPU when queue is active.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 14 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  6 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 34 ++++++++++++++++---
>   5 files changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ab37e7aec26..6d5fd371d5ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1252,7 +1252,7 @@ static int unreserve_bo_and_vms(struct bo_vm_reservation_context *ctx,
>   	return ret;
>   }
>   
> -static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
> +static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   				struct kfd_mem_attachment *entry,
>   				struct amdgpu_sync *sync)
>   {
> @@ -1260,11 +1260,18 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   	struct amdgpu_device *adev = entry->adev;
>   	struct amdgpu_vm *vm = bo_va->base.vm;
>   
> +	if (bo_va->queue_refcount) {
> +		pr_debug("bo_va->queue_refcount %d\n", bo_va->queue_refcount);
> +		return -EBUSY;
> +	}
> +
>   	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
>   
>   	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>   
>   	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> +
> +	return 0;
>   }
>   
>   static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -2191,7 +2198,10 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %p\n",
>   			 entry->va, entry->va + bo_size, entry);
>   
> -		unmap_bo_from_gpuvm(mem, entry, ctx.sync);
> +		ret = unmap_bo_from_gpuvm(mem, entry, ctx.sync);
> +		if (ret)
> +			goto unreserve_out;
> +
>   		entry->is_mapped = false;
>   
>   		mem->mapped_to_gpu_memory--;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index bc42ccbde659..d7e27957013f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -90,6 +90,12 @@ struct amdgpu_bo_va {
>   	bool				cleared;
>   
>   	bool				is_xgmi;
> +
> +	/*
> +	 * protected by vm reservation lock
> +	 * if non-zero, cannot unmap from GPU because user queues may still access it
> +	 */
> +	unsigned int			queue_refcount;
>   };
>   
>   struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 202f24ee4bd7..65a37ac5a0f0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1384,8 +1384,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   			peer_pdd->dev->adev, (struct kgd_mem *)mem, peer_pdd->drm_priv);
>   		if (err) {
> -			pr_err("Failed to unmap from gpu %d/%d\n",
> -			       i, args->n_devices);
> +			pr_debug("Failed to unmap from gpu %d/%d\n", i, args->n_devices);
>   			goto unmap_memory_from_gpu_failed;
>   		}
>   		args->n_success = i+1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d0dca20849d9..95fbdb12beb1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1291,6 +1291,7 @@ void print_queue_properties(struct queue_properties *q);
>   void print_queue(struct queue *q);
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>   			 u64 expected_size);
> +void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>   int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 0e661160c295..3fd386dcb011 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -106,6 +106,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>   	}
>   
>   	*pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> +	mapping->bo_va->queue_refcount++;
>   	return 0;
>   
>   out_err:
> @@ -113,6 +114,19 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>   	return -EINVAL;
>   }
>   
> +void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
> +{
> +	if (*bo) {
> +		struct amdgpu_bo_va *bo_va;
> +
> +		bo_va = amdgpu_vm_bo_find(vm, *bo);
> +		if (bo_va)
> +			bo_va->queue_refcount--;
> +	}
> +
> +	amdgpu_bo_unref(bo);
> +}
> +
>   int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
>   	struct amdgpu_vm *vm;
> @@ -166,10 +180,20 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
> -	amdgpu_bo_unref(&properties->wptr_bo);
> -	amdgpu_bo_unref(&properties->rptr_bo);
> -	amdgpu_bo_unref(&properties->ring_bo);
> -	amdgpu_bo_unref(&properties->eop_buf_bo);
> -	amdgpu_bo_unref(&properties->cwsr_bo);
> +	struct amdgpu_vm *vm;
> +	int err;
> +
> +	vm = drm_priv_to_vm(pdd->drm_priv);
> +	err = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (err)
> +		return err;

The caller never handles these errors. See my comments on patch 2.

Regards,
   Felix


> +
> +	kfd_queue_buffer_put(vm, &properties->wptr_bo);
> +	kfd_queue_buffer_put(vm, &properties->rptr_bo);
> +	kfd_queue_buffer_put(vm, &properties->ring_bo);
> +	kfd_queue_buffer_put(vm, &properties->eop_buf_bo);
> +	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
>   	return 0;
>   }
