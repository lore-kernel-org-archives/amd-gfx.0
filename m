Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86CBD0EE3F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 22:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678B410E08A;
	Fri, 11 Oct 2024 22:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mkxky6k+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81F810E08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 22:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ8bs1+QFVaKgkHOGRcwnmThbCgNkjnVq8CJfMPeeKw8pmUKZeYLfLpN5xEFEvPZyrCmQLdLNNOn/crz3Mr62plAzEhcMixYfEKMNCo5uPG95TNN/8K5Fq8UlMRCZ3ugpbE2xk6wDr8V7McNF4ltvgRH1zkOSqJkxqEqazVP/45XID3H7yfJ09khdk3N0nUszayHHFQzbC1cWOVcMKDn8EKSM5pO7lwd6cSMpwmf05NxTglkNz85evlDBTVgRak6YoBGnQa9E3BjTPO9ykgbLMHQM3rjRXHmTZ7mAvcHCBrUBSFOgmXBjzUy+misIsCTo85Iyoz+n4YEc0SbtNGJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=serYxsY5iQ1kw07JAecwL0Au2EUU5V4hmYyv17mrtX8=;
 b=jIfxdw8GxjB1lU0ViFK+I1WKpL037N5+Ten1Wgrcp7MTovl6BhWVjfJPRDvsc5zKKqpMFxD/hBd4dvINEipfwgrtz8aMQvFfZPhwhlQEaWqdt3EQnp+MvW4XIJYEtLP0bSIBLHHUDM1OekqHYRjLEJ51JcOzgmKklWZ8PV9yea7Y5gIFCWa09LjXnfAxqyM9WzD5HsY5eEdDMWkH9gkhv5UhCdc2L0nKDdPp0GNYtJs+hztOAnYBtmRFgcjU8HRfxZm9i8lzETDYIbhhp8YUGo1j/aPE6OguEEG1uLtdfbdukgHmnd8bz1YF7zz70/ofRsMASMneOubnBMvVE17b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=serYxsY5iQ1kw07JAecwL0Au2EUU5V4hmYyv17mrtX8=;
 b=Mkxky6k+QhHRaYPxyQhUW76bDzOZXPbMfCNcWnX2IOYLEvuOlno4dGhadP5LzWeMGahEqpSPJLa4JVcyPhE9fA/if3/oUzpq6rVjhwontGA8iSVPJklEUGaZC2VsGgjlnR8pV/mqn6mEE1i5TmqvGBvkCN/OKi9NJlk5o/BwzIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 22:53:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 22:53:40 +0000
Message-ID: <709e0490-422e-497a-b2ee-4a90b70aee3b@amd.com>
Date: Fri, 11 Oct 2024 18:53:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Accounting pdd vram_usage for svm
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241011202232.3354-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241011202232.3354-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a37709-5ccc-421b-a9ef-08dcea478c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S28yS1hmK3diRmQwSU5DNE1yNVRNV0ZkK3diencyYWpmUWVMSmtFZnREbmxP?=
 =?utf-8?B?c3RtVWp4Z2RJOXhZdytYWXR5Rk9QalhGV1dXbG1YVlNRSFpDUW44S1o2dGM5?=
 =?utf-8?B?Q25HMWJUM2VTV2t0VExxM05CVm44akVCTFM2SXhEMXNra3MwbkFUeG9RQ05R?=
 =?utf-8?B?NW5XNW1ZQ1Z3SzhjZ2FCMGhJbUl0RFJmd0trL1I4eGw3L1hrQWp0NlBmQ3Fm?=
 =?utf-8?B?dE1QeWJadjF0cVd2RW9PdjBNcTRzVlhqZEgxRUc3d1FlRFhFdE95WlBscS9h?=
 =?utf-8?B?NnI1NkhtRGxXL1pwSnVQSHU0V3d2M01NQzJTdUJXU2wxWGw3eStHM0dZVVNX?=
 =?utf-8?B?bEpLdFYrVW9TVXNoTnNSTjNwQnlyT3dZLzBlTDBPdEFwb3N5WEdobWZqT3Zw?=
 =?utf-8?B?RFpJNHExSmFiSi9qMS82RHVmRXZROTZPaXZvL1MvMDlET1l4RUhNczhXTEtE?=
 =?utf-8?B?MlZHUWwrVWRMYjZ4VjNERkw1MUdwcTJXK1hmM3J0UHg2VDRwMmMraGJReUZV?=
 =?utf-8?B?NnFQQ3IwQkFmRHVtYlNOTk5TcHdIN2E2aXBMYzN5dkxrN1NBdk9tWXZVM1R1?=
 =?utf-8?B?YkFXM2k4dzVIRXJ1THI2NG5xMlJIK3puRkNKNUFES05XTm04Qk5uVHg1eWI5?=
 =?utf-8?B?Ry9RSEs3RWw4NVNBeE1RMmFFOEIrNjhSS01ONCtvSXNhVzFsQ3lYTUo1OUhV?=
 =?utf-8?B?eE9Kak1wd1JrT0E4VjlRQzVySkEvSC9EQkVwS0IyV3QyRlJrcFJNV1NhSjlM?=
 =?utf-8?B?SjhYWTNUc25xSU5QUkNNUFd1dWdHN3ExMmIvMW1VKzU3UXBoaHdmTzhBS2dN?=
 =?utf-8?B?TGVZMUQ2YUxyVi9rcW5TaDk5Tkt2T3BicjhoSDhBUm96MFNNcHZ0NUVxS2VY?=
 =?utf-8?B?Q0F4T2NFRnJIQ01yZWJuMUhWdm9rNkZOWlhGYmU5aDIwcWN2QkY4c2IwVlVL?=
 =?utf-8?B?SjJCVlhrNDZiQktxd0MrRG5jYXFnTklneUwzTEh3YlJsQmZlQ3BYQXRyNkFh?=
 =?utf-8?B?Q0Uxc0h1cGppeVNKZ0ZDNVdKb0hLZWN2cWV5SGlGZzVkNTAzZ2tJenV2OUNq?=
 =?utf-8?B?VitrdXgwMVBIMVdIMGZJb2YwSkJXRC9Uc213TnBDZnRYQzY1ZitkZk1Zcm11?=
 =?utf-8?B?Z0RYRXB0TGd4TEFkQVhybzl2TmpoVVdJK2V6Uy9XMWduUDBEbWtpZzFhREdn?=
 =?utf-8?B?T2dENXVWOWVQdzlOYk8xeUJYbTVDSGovcnpQbXJrcHdsYzdWRzEvT3RuUTI3?=
 =?utf-8?B?dTI1OWw2djNDVlNCbGU5MGdoYjQ3aCtqaEVWVDNxSEVJR29xN0FIVUtUb2cy?=
 =?utf-8?B?WnhUdEkxOWRSSGRDWkxpQ3ovdnRVQjc3WTlUMFprTjFMRHJFbldYdUphS0pJ?=
 =?utf-8?B?OUlhUW1qbGZRdTBMYkViL0VlWjFYRHo5bjlRT21Ka2hiMnZlL05SdHZPMStS?=
 =?utf-8?B?YlRvcSsydVpKUFFBNks4TnNZMXZpMmtWaitGaGJhWlEyRGJvZjA1dGtqT1NC?=
 =?utf-8?B?aXNlM201UUE1R3lqeE5IWlp2L2Z5UFNTSm1FWDgvRysrakQxaDJJd0cvenZs?=
 =?utf-8?B?bUNpNFJBVlF6UnhoT3ZOV3hEUjhNRzFwTVlUY3NKZVNXeHdvN0FrSEVBejhK?=
 =?utf-8?B?K3MrTWIySUxQcXRMTGllTzNpdFpSMERNWGI3VmNwQkp1Sll4aVFGa2xGY1Nw?=
 =?utf-8?B?Qy9FTWg5bXRaQW4xS0E0WGQ1Z25JamNDMVJtNjIwZndUUG1yaWtOTENRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVHS0dPZm0rUUJCakhVOVFxbU1Nam5GV3JPVFlZNWRrRnFzalNpTURNYXA5?=
 =?utf-8?B?UTZPaWVtckhYbk1VTmtyQzdwL0llSmR2ZU01VlUySHhkQXg0RE8vZTRWdE54?=
 =?utf-8?B?SGp2azdkLzgydHR3TkNUVlY3cTJLbDZ3UTl0YnZFU2pyYjFaZnIvSi9DTXZR?=
 =?utf-8?B?UVZqZVhrVjVOT3pVVW4ySmpPWmJpNWZlVEp1U21ndWk1QmRiSzVhVElNUllj?=
 =?utf-8?B?VE9UZGVSV0txVEtGZkgrMTViTzhsYWtJZ243MVpnSzNmZFVFVUJlSWY2Umdn?=
 =?utf-8?B?bUh2MHIxcFBxcWJaQXlTdEszbzQ5eW40TEtiVEw1MnZ1M21yS1IzSzVPeFdq?=
 =?utf-8?B?Vy9RL1Joc3ZrK250VkRaVytRMXhkd0pTZFE4cW8yYmRxM3psekVkcmM5ZWVP?=
 =?utf-8?B?WGJSK1R6UmpmS3lOZi9RQkxHT25hUnZaLzRaUU1OUU50Z3VGV3p5UWtnV282?=
 =?utf-8?B?Z2lGR0cwRVJmZXJNQkp2VWM2cWtyYVBPdzhKN1BMMmI5alBHU2lFcnRTOFhy?=
 =?utf-8?B?Z1ZtVFdkQUhEYm81RHIvQnlpRTRHMWNJbkQxVFdVMXlRS1JyQk5INGx4dENY?=
 =?utf-8?B?UHNsMXh0VnRMb3RnWDBOcW5CU2dsb29WVElEaTNsdThWNVBKMWgxamhRaHpz?=
 =?utf-8?B?S0VGL3dFYnBuNWhGU1dwQTJ3M0hwdC9pVkROVzByU0UzTXFBdHlWWXU2eVlh?=
 =?utf-8?B?bUFadzlaMlBHQmhDcUEyckJ5M25ROG9sUHQ1RmdVVEgvQ3pGMVl5NGh0ejFk?=
 =?utf-8?B?RHJTeEJVcWpOSVRNV2djbW80b0NybEhUSk9JU2loRFFIbnZGV1phemRaWkxx?=
 =?utf-8?B?UmhPc0lhd3ZtM0FzeTVaVkVjY0ViTFhBOXZPRDJzZW9zYVNyc2pqenRtRUxD?=
 =?utf-8?B?aUcvY3RpQ2c5cTR6ZlBwNHJjMk5DQThlNUIxK1k2ZTNwS3VBREtxWDFBRTRY?=
 =?utf-8?B?QnpUOTBEcTQzcEl4dXoyNnFoeXNXS2VIQnl6MGtPV3R5T1dKc3AyeSt5RFBp?=
 =?utf-8?B?OEJVVTljZXI2TW0vaHF0c051bTdwR21kbjVLRFdLRVphM0prK2pUY1VLNnJh?=
 =?utf-8?B?RXdocFJTRmhDU1V5M00zSzc2Wm11ZUhKVHg3K0lEalp6UXl3YW9wWS9iWTJU?=
 =?utf-8?B?T2hVaEFJSE5rN2NJaTJKVXQ2RmRwQVArdi93K0RFZ2Y2d2VwNm9UbC82TTBh?=
 =?utf-8?B?eGhuS2tHS1BHNjZHbUw3bFh4OVpCeVBDQ2hyZVFpUzdjbVBncjlGOTJ1WWhS?=
 =?utf-8?B?R3BWVWVlRjV5cjc0YjJocXZ1a3NZamU2Qk9OOVRtNVRVeGFOSXo2eW5RaGhk?=
 =?utf-8?B?L3d2OHhJSWowODRCSnFDQ3h2aldaaTM0N0Q3bUhCNHVBaU81bWxocnBRWnRX?=
 =?utf-8?B?T0ZuQzNvNnFCeG44dnpFTEZhMmd6SE1ZZlpTaGNqcGtGYTNPUjcwMlU3RmZ3?=
 =?utf-8?B?NEgwMmhOd015QzY4S1pOVTdaSkpkZnRydDZvVVRoK1FCUG9EcjE0eFJpdzVG?=
 =?utf-8?B?TDZzeWFJeFN5Y2c5QXpWSFlMbnlpMmQ0M1pkSCtua1d6SkhqdVgrZk1nUThP?=
 =?utf-8?B?MWVNdGNaY2lyLzhxSnlIV2pzc0I2SzhYanNocGMwTkdvSjdDOFBSVy9ISEx3?=
 =?utf-8?B?VG1oRldjUFFaZm4xNlVsZ1FvcTA3MkpVU0dKSFJoU3JWRTgvOE1mbThJNUxP?=
 =?utf-8?B?WDRmTnhISUM1YzdoNVdqMUdGNVpQNE1mMG1CM2NSS3l0Uk0yWE8rajhNZys3?=
 =?utf-8?B?bkVFRUk0WHJxYWlSOWh1aXJqWC8vbzVDMGowR2J6Nm9GMU9KQ0R4VFQ5WXYy?=
 =?utf-8?B?SFFNWDF4b3Jwc2JzMzl4c25IeXJkWkJsdnBzdy9uS1ZaYmVKWWRNQ25mdmNU?=
 =?utf-8?B?TUlWK0ZSeGhFTGVZUzg0OXdtY1p4MW85clFLY09rdlNMR2VWdHJHVlVsamUv?=
 =?utf-8?B?VEFRdTZlTVluZ0JBVmczZC9pczlrVFNPUnlhRS9sOENpTXZtWW9MV0RVdEFB?=
 =?utf-8?B?ZCsrUlg0b0dUdkNsZVdINk1FaTUzRFNqK2k4Z3hNSjBKbXFUMWxxUlRUSkdH?=
 =?utf-8?B?djdqV1d2UlpFN0licURySGFBMlhRQWpBN0R5MWQ2MlorVXBoUkJUQ2QxT0tR?=
 =?utf-8?Q?CT+EuuTuJb6Jqr+DngC4hl6dI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a37709-5ccc-421b-a9ef-08dcea478c93
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 22:53:40.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiApc7hOZTeykui1p6/kaLHqIGIIyKGotNO0xatuoYdg3DAPSeZCQnl4P04YrPSt1kWIuCyKBQQKcnIwr8jKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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



On 2024-10-11 16:22, Philip Yang wrote:
> Process device data pdd->vram_usage is read by rocm-smi via sysfs, this
> is currently missing the svm_bo usage accounting, so "rocm-smi
> --showpids" per process VRAM usage report is incorrect.
> 
> Add pdd->vram_usage accounting when svm_bo allocation and release,
> change to atomic64_t type because it is updated outside process mutex
> now.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 26 ++++++++++++++++++++++++
>  4 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index a1f191a5984b..065d87841459 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1148,7 +1148,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  
>  		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>  			size >>= 1;
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
> +		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
>  	}
>  
>  	mutex_unlock(&p->mutex);
> @@ -1219,7 +1219,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  		kfd_process_device_remove_obj_handle(
>  			pdd, GET_IDR_HANDLE(args->handle));
>  
> -	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
> +	atomic64_sub(size, &pdd->vram_usage);
>  
>  err_unlock:
>  err_pdd:
> @@ -2347,7 +2347,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>  	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>  		bo_bucket->restored_offset = offset;
>  		/* Update the VRAM usage count */
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
> +		atomic64_add(bo_bucket->size, &pdd->vram_usage);
>  	}
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6a5bf88cc232..9e5ca0b93b2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -775,7 +775,7 @@ struct kfd_process_device {
>  	enum kfd_pdd_bound bound;
>  
>  	/* VRAM usage */
> -	uint64_t vram_usage;
> +	atomic64_t vram_usage;
>  	struct attribute attr_vram;
>  	char vram_filename[MAX_SYSFS_FILENAME_LEN];
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 7909dfd158be..4810521736a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -332,7 +332,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>  		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>  							      attr_vram);
> -		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
> +		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>  	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
>  		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>  							      attr_sdma);
> @@ -1625,7 +1625,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>  	pdd->bound = PDD_UNBOUND;
>  	pdd->already_dequeued = false;
>  	pdd->runtime_inuse = false;
> -	pdd->vram_usage = 0;
> +	atomic64_set(&pdd->vram_usage, 0);
>  	pdd->sdma_past_activity_counter = 0;
>  	pdd->user_gpu_id = dev->id;
>  	atomic64_set(&pdd->evict_duration_counter, 0);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 857ec6f23bba..3e2911895c74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -405,6 +405,27 @@ static void svm_range_bo_release(struct kref *kref)
>  		spin_lock(&svm_bo->list_lock);
>  	}
>  	spin_unlock(&svm_bo->list_lock);
> +
> +	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
> +		struct kfd_process_device *pdd;
> +		struct kfd_process *p;
> +		struct mm_struct *mm;
> +
> +		mm = svm_bo->eviction_fence->mm;
> +		/*
> +		 * The forked child process takes svm_bo device pages ref, svm_bo could be
> +		 * released after parent process is gone.
> +		 */
> +		p = kfd_lookup_process_by_mm(mm);
> +		if (p) {
> +			pdd = kfd_get_process_device_data(svm_bo->node, p);
> +			if (pdd)
> +				atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
> +			kfd_unref_process(p);
> +		}
> +		mmput(mm);
> +	}
> +
>  	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
>  		/* We're not in the eviction worker. Signal the fence. */
>  		dma_fence_signal(&svm_bo->eviction_fence->base);
> @@ -532,6 +553,7 @@ int
>  svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>  			bool clear)
>  {
> +	struct kfd_process_device *pdd;
>  	struct amdgpu_bo_param bp;
>  	struct svm_range_bo *svm_bo;
>  	struct amdgpu_bo_user *ubo;
> @@ -623,6 +645,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>  	list_add(&prange->svm_bo_list, &svm_bo->range_list);
>  	spin_unlock(&svm_bo->list_lock);
>  
> +	pdd = svm_range_get_pdd_by_node(prange, node);
> +	if (pdd)
> +		atomic64_add(amdgpu_bo_size(bo), &pdd->vram_usage);
> +
>  	return 0;
>  
>  reserve_bo_failed:
