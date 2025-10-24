Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84F2CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 20:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8AB10EB3D;
	Fri, 24 Oct 2025 20:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/kF89i1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010070.outbound.protection.outlook.com
 [52.101.193.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AF810EB3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ1l3yy8wYOFUAJnrYTgNM1ai2U5t+WBPuAYFymoTrS7HRl6OTj4/+ga1XMj3pHew3L2GKSsuR6S7rym3Ar7YUbn59vFmM/vXf5GHMZlsknIdxkPZmh+/k2nCA/CnJwt+TosiAbeT2a0zqh3CUlK3T4Z1SeWbGdZKVRkxGfP1SAKBzts8l+YOO1jkAN1xWC1sruUFiAtd5/6cwQ4PR7AEWLgZ+8YEvOvQ2ZHOeeMLENJlnOf7mncuwj5HlFARaM61SriXUzQuzhFwznM6vfadeaRqqacY2QocZKao7KgFV88xSQaWVATkEMzU8DSGJcQhYRsoifP1UJmf6aRk9Zcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVVgwvdYX6MUpBfhERStvt6ICtNNm+ydrhXw9dCWrnE=;
 b=dLFXN+YiIHs7+G5zTA7+dT9rZb4FPG+W9ClGrKCnrdk7nFhPm3yQ6xYcfovd/HC7+Nk+cwz8FEbRHfsmnwyBhdL6kE1RGdLD+uRY7uAF+OmZjws1b90ujrtPWfhyed6DMROGw+izPxrNQzEHYZthp6WV1LFHI6NjzSrxDbYqAZy+mhyCKvumYZT9dpZyzPK3xZBaTjSjTiwUZxLyzu0cJhO/7PvNAdbAw5KI2JdZV6gTDwX3tMRufJLMejg4ZeG1Su1lHQ/eu3kwVCFhndkONjbjew3eDPQzUYL9Z4C6Z9LTEqconfpSEApLTjjl41vO55Aaml9ConV6e/uJXDtB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVVgwvdYX6MUpBfhERStvt6ICtNNm+ydrhXw9dCWrnE=;
 b=d/kF89i16+p6ro6OlvrFDaq6JBkglZrZ10d5Dd8XDY4tBGH+ioJAJSwDypLzxBo1leytEGLy9P3riK+EfokOg2t1zZKKUE2qkGqs80L+QGmMHXfT4zw6qEYRXJfF8tF3iuRtuk+Nn5IGnvOuzXc86xc9JvEY88Ft/Sw2VwtdXJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 20:55:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:55:25 +0000
Message-ID: <c28815a2-64a0-4f82-afb7-3d9bb10ad717@amd.com>
Date: Fri, 24 Oct 2025 16:55:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3] drm/amdkfd: fix the clean up when
 amdgpu_hmm_range_alloc fails
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251024190701.2343948-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251024190701.2343948-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb9d423-cf1d-484b-3dac-08de133fa7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vzc2dWxtNmJZcTZ2ODU3WlZvemUxY3RYSnlrcmRYaUVCTjJ1QkF1ZnIvNm42?=
 =?utf-8?B?U2FOWk8vWTl4L0FRTC9Gcy9UaU5Qb1lSTG1ERGJnWE93VkRiTTFWL0IzNzlO?=
 =?utf-8?B?ZUQzb3JnYnlHL3M2aHh3VnRabHpvbmlrSlhtajhweG9ub0t0MDU4SUwwb0ZI?=
 =?utf-8?B?MEREeDlUd3pJd3ZWV05xQyt5ODB3d3lJM1UvREtOcnZMRE14Z1Jjc3JSbFYx?=
 =?utf-8?B?aUlXWVdzMVpscHdrMUFlQjBmMlhwVUpGT3E4UjVZN2JTdGs1SFpmZmZaajhQ?=
 =?utf-8?B?aHVsb1ltaGxCVFptVmRGaHFVNUQzajdHNXcreFdNOGtpV2hHVXJ5cnhva3pt?=
 =?utf-8?B?NDg3Mkl1aUdnSlZkQUFmNXAvd2Zrd3BjM083YXV6NExUc1Z0cnBWNTlLTXJ2?=
 =?utf-8?B?aEJSYlFxVUNMMEVBN3VvRndTZFZKQkJWRW1sbWZpbnJQTVV1V0FpeXlaVms4?=
 =?utf-8?B?d2w0NVFNMmdOaCt5QUpuYlF6NkdhNVFnaE02TzNvUEI1S1Z0NEliYlVJZXhL?=
 =?utf-8?B?L2JZMGYraGhBZVdRblRTQWZTMnFYNEZoQXhTbWJ0R1hvbXhjRjQwVUtDN0FU?=
 =?utf-8?B?Mm56N24xVTFWYkdtYVJ4SjNMVVJoSFdvU2U2Z3h3L0JscDkxWEVsSFFEVlJ0?=
 =?utf-8?B?cGp5STJ3R0o1TWxwQ0hteURBWnZqcDZKTmJFQzV1V0h0YitvTG41SGVGZldJ?=
 =?utf-8?B?UUFoQzIweTUvT08vdTloWmUrYnNyNnRMa29ySEdGRDNaRWNzR0hmOUFIcUdG?=
 =?utf-8?B?YnpPYmVxSHc2Q2htZEFGMUxnZFlDR2dteVpFeG16SUVuck8wSTFzY2FKWVk2?=
 =?utf-8?B?NUdWTCtGVW50cjRmczFZY3NSMUdGQWY4TitjSS84U1RRTnZzSkNyU0M0N2xB?=
 =?utf-8?B?WmVIYXQzaG1DOEk0MUJSVmdOV3paNWRYTndUUTFHRVRITGh1d21qKzhzclZu?=
 =?utf-8?B?RWw2Ymp1K1A2OHMyMWNRYU1qTGtlbnBRWTRTc2M0UnJwYmlYNEZ3RlpXYVlW?=
 =?utf-8?B?VlhCaFRlZS9tQ0pBeklGNW5qbHY3T1o1NG9saHlhbkxsTjc1cW9GbEVuZStL?=
 =?utf-8?B?b21ScSs5Rmg1N1FpYzllSkNsTmlqbFMyZDVKRVZsNnpyN1pmaVAzSGI0KzNx?=
 =?utf-8?B?U3ozcmNjMU8vRS9mZUd5dU9jb0RRclNGTHMzY1JOdU1MMWRRWDVDOEYvcVNM?=
 =?utf-8?B?byszQ0JzeGVSZXNYZDAxQnZlMFNHUDFnMmVwWC9YOGpUMW1pdkRRNVZVYVVv?=
 =?utf-8?B?VFJ0R2h6OUJWSG55WkpITjhpalJlVHpRTkpMWkRaYXVKL3BwYllIZThjQzFH?=
 =?utf-8?B?WnJOdnlNSmlSSklFYWZIM1lSRHlSV002bHVMam1mR09wL1FlaWQ3bFptb3ZE?=
 =?utf-8?B?SWJUcE54aGo2aDEwa1k5bmtKYTB4RFZHZXE3REhVbzd1SEdscExpOTg5VTVM?=
 =?utf-8?B?S2NmSTV3c0NoWm9qbldRTTdHTnQwQmNHYVVENUsxc2RYRVNybVJoZCtoQkNu?=
 =?utf-8?B?b2xlaFpnL1FpZEVpSXRuUkM3cHdRN09nUERHZ3liblQxTURqbWxQQ0pEUlVG?=
 =?utf-8?B?Sk9ZRUVVbGM2RVFTRTk2SS91MTY5TU1BYWJNUHYwbm1VZGlRb0E0MGZ6YU9x?=
 =?utf-8?B?N1RFdmQ5aEFyTWVSeGV1Y2xRSXZsOFhYQkpxdE1aZC9kUTRyQjZHUm9mYmhR?=
 =?utf-8?B?TDFrYXFDVUtvdktxM1FJNzVuR29OU2VzNFVRanhEMDdoaUtlYTBWaGRuOExM?=
 =?utf-8?B?alE1SWZ3S3VQc2ZrVmNvVWpLYkZXTlVKV01zWUF5UXVGQVpUdW5UNGFOWFNM?=
 =?utf-8?B?ZWJzeSt6YW5RMFJnVE9LMXdjOUYyenUzeWpUTnJyY0t0Z0VLR1E1ZGpidkNM?=
 =?utf-8?B?OHBXaXdYY3FiSng3d213RnNVUFhoWEljaU4rOEgyOHppWUpKRExRTkJrSEpT?=
 =?utf-8?Q?gkUwcyJqSxbY15RD0D/Kzdny0DptFPEc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE54cGdtUVVHVnZ0ejdabEQxY2pTejROYUNTUGt2RlZaQXN5Q2F1cVNCb2RV?=
 =?utf-8?B?Vkd1VVJ4RURPZ01UaFpiM2c2VG9RM0JzL2p5ZXIwNFlOeUpLbWZFa0Q4YTFh?=
 =?utf-8?B?NVBrNUl5MW1YWkhjL0ZxZ01TYnk3b3dUWEUwdWhIbXRHWDQvbW1MeTA1Q0ho?=
 =?utf-8?B?ZHJSbXYrMjFReXJESHR0K2JobmNvLzMydjI4SGF0emhoekNEQ0E3SU80RzJV?=
 =?utf-8?B?MTh1UENGV0ErMW1XbnJFUzUxdmtFNmVPWmZaUWUwNENnRHlCejRPNTZFZ25E?=
 =?utf-8?B?VlJRUVROcCtjZFp4bUNzVFlycVo0L2Y1b1d4K1J4bEF4T1NCTytGek5LRFl5?=
 =?utf-8?B?OHMxMERCWGJoMWZTSjNyc25GNWMwUkFIOGNucVE5RmZ1ZVhSMnB5TUpjcGNj?=
 =?utf-8?B?OFg3a0owb2ZkMTJrcmRnUCtjWmZ0SENmb0s1UklKSnc3VWp2RnpWVFc3NVNz?=
 =?utf-8?B?MTFnY1gxYWdHaVRTeDVsZVdqanVXUEttdlRZVWo4enF6UEFzYzFzcUZvUGFU?=
 =?utf-8?B?emhEZG1ZVm0vTE9DaE5jcEI3S0JLT0E0bGJ4elQxWmk1emJFbDRVamZOTUYx?=
 =?utf-8?B?clF6NTdKejNhZ3cvRTN6Rm5IT1lyZUpPcFFGTjU3bWJtWVg2cnNlc1dHVkVK?=
 =?utf-8?B?d1U4cGJ0VVBQZG5iQmhBdjdnVk1hZHM2eXNUdnpEMitCTXliMERnVmtjMTZi?=
 =?utf-8?B?OXZYNjFYeGV4WVNUOGhXVWZERFUvMFBQd1JQRWFvck9iSTRXVDgwSXhnZUtv?=
 =?utf-8?B?cUVuZDZHYzFKVE5ydjZkbXYvaTdLWHJyOEx0bjdRQVRkUkZ0VDdySXZxZ0Ex?=
 =?utf-8?B?Y0RtNGFmVVpLRFlRY3hMSEh6UTRTMG5WRGlWYloydEhSeTYzUW9kbGliL2VJ?=
 =?utf-8?B?eHBhVFpDWll2YlRaOGN0YVNSbGZCMDNPSFlGVUIvb3B6d0VQTEUwWjBqUE0v?=
 =?utf-8?B?Y2tKTWx5clRoREpBR1ZtOTZ2K1BBaUpKalJrb3lrSU9OWTNXSk55TzRuY0k0?=
 =?utf-8?B?ci82UEUvZlpaMWh1TFJkMDdLWEZkQnZqVlVwdzJVNGxJKy9IQ1NRMzVsY0lL?=
 =?utf-8?B?RzFwVUNFZGVwWGxEbFJlRmYrVzFocEdRRFcrZWhBRExvWkdiM0NwalB1NjFF?=
 =?utf-8?B?TkJ6K01jYWpJL0FsMXg4V1hGUGFtWEswcmcxVkdJcHRYVnlQekErb0tLRktn?=
 =?utf-8?B?a1JFU3A2QlB1NjhMSWxMYSt5blMyakNlOFNSM00xWEp4ZGtpUmdaY2Q0V1R2?=
 =?utf-8?B?UFZ5VEczc2QrMG1wYVg4elN5S1YzWi8wUGhYZUk4RGRTRG1LTUtBSWZoQXpw?=
 =?utf-8?B?aTJlMVB4cVRQM3Q5Wk85RmZPQzBPaE91RGtaYnZQdWF2Y0JyajhwRi9kbEo5?=
 =?utf-8?B?NVVaKzE5djZLd3FyemVaSUZvRVdWTXVBcmtrem5ockRuUWJRKzZNVXJROWRD?=
 =?utf-8?B?em5vWEFjT0wyYmhHUTFYelpZRlVKK2FHM0hPUVI0T3VZTHYybktBbmU5b2Vl?=
 =?utf-8?B?cS9tc1VzYlZxbzBkMnJ1a3R0R3BDdlFSNGJ6cEN2OU11NnVkOEJpdExjR1BY?=
 =?utf-8?B?b3Rkb1JoYVFLT05qVEt1RGpwVWZOcmplcjduc2RCT01CbXN4aXJUTjJFaUZQ?=
 =?utf-8?B?VzBXbGp6SnRHZytTLzR5MjdPbkxxcHRyTUpodGJqb2s3WllUYmRCQlF4cU82?=
 =?utf-8?B?bjgyNys4WDZVQWVUY1g4WVlIS2FGSC9xaXhQUTZXMWg0L1FOcytkT3lqbDlk?=
 =?utf-8?B?dXhPaUJlSUhQeDZhSjNsYldwK3ZLS1ZoWUVlaXQyZnpMNDQwUEVReG56b2Rz?=
 =?utf-8?B?aEdDMDNvd2x6YjdtOVZXUHRSRGEvMjhzV3N0SGFGQitoT2lrN201N2hkV1pF?=
 =?utf-8?B?cDRlVzRlUXNERUt3eThOWGVReU1BM1ZVajk1ODZJb096SFRKdnlHZzJqR2NY?=
 =?utf-8?B?NDJlNVVsN0dyZCt6YzlheVNBa3hNVU9zRjZLVEZOdVhGd05NRFlsZU1lYjdx?=
 =?utf-8?B?VWIrYTFmM29NRDdUbGwrOUVwWE5DbzZrZ0dHeThHZU9FZlZ1aE0raXZEcFhr?=
 =?utf-8?B?K0hWMCtSc0h1RVkyRnNRUnhyRVljVUx4SVdDOEErK3BsVlB1WXk0NUdVQTRZ?=
 =?utf-8?Q?x2hKfvJq2WIUEJ/2oRLDb6YKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb9d423-cf1d-484b-3dac-08de133fa7a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:55:25.1387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5+Mgxx35vEVvPLJ8/kI/YCP5KdosmcE10U81RPwApbstiU8TEJZS9pDNp8nfNdQM2QEda+9zjv0sQWRB898Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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


On 2025-10-24 15:07, Sunil Khatri wrote:
> we need to unreserve the bo's too during clean up along
> with freeing the memory of context.
>
> Fixes: c549912cd8 (drm/amdkfd: add missing return value check for range)
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7f0ab73e2396..35c592024a01 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1738,14 +1738,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			range = amdgpu_hmm_range_alloc(NULL);
> -			if (unlikely(!range)) {
> -				r = -ENOMEM;
> -				goto free_ctx;
> -			}
> -
> -			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +			if (likely(range))
> +				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>   						       readonly, owner,
>   						       range);

Please fix the indentation here so the parameters line up with the open 
parenthesis. With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +			else
> +				r = -ENOMEM;
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r) {
>   				amdgpu_hmm_range_free(range);
