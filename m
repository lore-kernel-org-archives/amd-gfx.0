Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1962CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 06:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B38210EE4D;
	Fri,  3 May 2024 06:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xjUN8DZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4319110EE4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 06:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqtYd+8+kawTzlIK81jArd33k9ShFLhF+zK/f16u7S7B/vXYCEtgKcr9fPv0P8EaLi5PGiJrrYjLc5LlK06vB/5p3leazg6xj7Xzlo6PEgJAfmxHNOTUYZ4N7Zs4nwOj2V9CiQmYocYN5s0oYiWSszgj08puv/fVhvNeEEIIqu03LEd0UslpkWvtEB0d4xLQoGQpkY0TGg8g2Z4jXlEqqtpt29LjjSfvJk6y7Mp8/Y9plljd1tYvj+fS5ez45kCD6REPfRViCRyzt3PZ57ZR3qokJ0rLlcYjyhgthSpXf+4RLjkwltIOrGwYpnbJrGWcZUN22FOexPEW801fsFxB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+M2L+hyLqyA1z9K6D3SIXtJqj8RAoCvuFu+secDX4c=;
 b=Dc59HVt/u/qlA6e+ypZAdin+SP7Fd2mJ4Ag0KNGfL9vTuFAmZ4IMfCzoFTymMQnN99s3Vri8TSPdEhgze7eM1OpZgfyRMwiojTWtdi1Gg3MRV0Kx9pbABTJxGe4kBUqe9rI9W8toEmt4jtMryX8pBY9iNJmTg8ubhYiUNNVypoZ+AqAGdoYkZo9pnGza/BjqOZjiAWkOQjj7RK0GhW3C8jTq9uTcszkrL3iaR+zys+yBvFyt6SQsktMQmizQGRgIFfm01I+bnnvtSRx7pYteVO2fWFnt04Nk2abEa7WA6O3xV2R2AprLT34kU65PtSSXat4fcDwm4an6c37TVqpI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+M2L+hyLqyA1z9K6D3SIXtJqj8RAoCvuFu+secDX4c=;
 b=1xjUN8DZEMs8VRMOO7BvjyYKNJQDTn1+NgDtRWljPo2fkyNBWMy9q0FY9meuTQi0hkWhAsGPiImeiBVYRCgyLj1yFJxAW/Owqu4PUR2R+UJ0+/N8Kg9bDd+Oa363YKSEWwRQdhSv1QLsz63HkxS69woms37sIHfBRhBlJec52zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 06:53:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:53:19 +0000
Message-ID: <b00315b8-a11e-4686-9fbe-423091656c7d@amd.com>
Date: Fri, 3 May 2024 08:53:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/14] drm/amdgpu: enable SDMA-V6 usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
 <20240502163152.1382-13-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240502163152.1382-13-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d7bf79-26de-4db7-7a08-08dc6b3db77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkY1ekM2QWcwOUI3U053bVdJc2ZrZW84a1FDQ2xvZzNPa2E3aXl4TGVrOUpM?=
 =?utf-8?B?Z09saU5oRExEb293OXBBamFBelBVR2JOcXg0THlYZjRuVGFYWi9CLyswVzh4?=
 =?utf-8?B?TW9BVHNzQ0xZT292UjdjU21UZ2ZlbUR6Zkp4dHNCeUFvWnp6a3VpWTY3SEEy?=
 =?utf-8?B?NFRZbWJ5aHQ4elNxZjBZSmhSM0pha2N0QmJ1VFZDTmMxbWxXbXRlYlVuVnpE?=
 =?utf-8?B?SldlbHNlSGRxU3dFNXJraG9xNjJoU1hDSzJQczBzV0ZYeGZ2OWE1bUszWGNF?=
 =?utf-8?B?bGpMVlFPZjFNQUZiK0NtR0l2ZFJTdVhGcFdjcC81OXF6RVlQTU9IYmpoTGZi?=
 =?utf-8?B?MThGYVFhcjVkcW9ENFV6d2xXN0xFc21ZcEpnV2ZTTkJHQUZQeDVtb1dBYkdN?=
 =?utf-8?B?T3A1VDUrQUpFMHRPWmdnZEpWbWVXazV2TE40SjJJYlk3MkdEMkZrMEJOU1lJ?=
 =?utf-8?B?Nk9xU29OMDdhMTVhMWNBYUZEbVB5dlVDUXJCNFhVOTltckg1QU85QklQaGNP?=
 =?utf-8?B?TjQ5d1dPMERhUmFtNENSMTM2MWdOMU9RNkxDWjdOK09aQ05seFlPaVdjUUQ2?=
 =?utf-8?B?dDdTbUZwR3BneHNoM1hQV0tyQUtHeEZsbm1jKzNFSWxyb1JDalJvMll3TUkx?=
 =?utf-8?B?Z0djYUYvdC94eEhVdzEvKzlnUmxvay95dUNsNkpkN0tCZzRYaHNpNTVmcVpD?=
 =?utf-8?B?WHYzQUM3RUpidUIrdHNHaFBxVzVRQ0FQUkFDa2M4TWllVHdqRWRYeWRlamFj?=
 =?utf-8?B?anNuS3pScnErb1pQL3d1am5sanZyVXQxckI5d29ldS92aUlvNGRGN0d5SStQ?=
 =?utf-8?B?OW5NRjRTSjZVVWt6TXN2UUhzT3JKTklDZlV0Q01JczY3OXlLSHhvZlBKYndQ?=
 =?utf-8?B?ck1ZK1JVV3hQdWVxWENnOGFOdkZzUGd6aWFTb2tSMFlmZzdNRkNVSEZiV3ZQ?=
 =?utf-8?B?OWdUclNJVm1lR2NZNXRMczU3L0tHbXpRZGNYbFArdGJPNm5vb1h3aWk4Rmg5?=
 =?utf-8?B?NXh1MTJBZUpkclQ1aSt6TjhuWk5ldDVDYVZDVFpyUVRuV01jNXVnM1JvTFZz?=
 =?utf-8?B?S1pzV1ZzV3cvU0dQTVdtM2NkNVFaczRxNEwyaTh4aDZqNGRDaG15WG9KY0d5?=
 =?utf-8?B?ZE1yblViZUNUNDcvYzJONnJpUWtrZU05WjJmbWVNUm4xY0VwaGxOL1p0djgw?=
 =?utf-8?B?MENLVmg2OVNmTWUwSFBNMFpxQ1VHZENOWmsrY0Y5eUlBRzMwQ1FxMWcrVlFS?=
 =?utf-8?B?a0ZCUnZXY1h6TU1JOTR3aDEzTUVQYXhTVC9mQUxYMG1jUnMvSkJZbGlSU0dz?=
 =?utf-8?B?aVVKUnBqckQwdWdGVU9YUWxPeUR2a3orRWJxaEVNMmdibGRTcjBqQzdwVkR6?=
 =?utf-8?B?OEJrYWoxZTNna2UvNll2bVhHdlhMeE02TVR4SEU1LzljZGZaZzlnUVFDbnB4?=
 =?utf-8?B?czl6YXdUMXF0UXd4c3RZblJ1UVJDalJMdG1QMGhnU2R5VnltbUtwSmtIa05G?=
 =?utf-8?B?ajdleDRBeElrMG8yUjhwWU84MWpNVHdnZW9HVU5DbzdEdGxQdUF0UEFLUC9R?=
 =?utf-8?B?TzExRy9GbEJReFhZN2J4Tzl3Y0Q3MFIyT3U4RkNEbDJ1NTIrU3pUTk9kVHBV?=
 =?utf-8?B?dGMrdnc1d0JGMjg5SjQzRG5nNmswVjNBUjJpcVVWWTZCL2xVbTFQZ3hOUXlC?=
 =?utf-8?B?ekE1clQ2YUJFWVFyNUEzeDZEcDRKd0tWb01aQzhPRVk4WTMycHBHSzdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFJQkZQSGQ4RzZNZW01NmJFRndjSG1ySDRtQ05jdFM1enBlRFRlcnU5SFEr?=
 =?utf-8?B?cWZ2dng0Q1NCYTVZQk5uV0g5aXBqcWU5ZmdDU0FZN1liYk56bTNYVE05emRF?=
 =?utf-8?B?YUFmcHlRS1BFbC8zNjFKejB2STcvaFU2WGtTWWtWOWxHd3o5dHRmdnFsdUR1?=
 =?utf-8?B?enVvVlBjTjJnSW1XMzRpVkFUdC9DcFU4aHMwT3N6aFR1cXZVZCtiL3h5SlVa?=
 =?utf-8?B?WWttZHZqWmhmMmRIUnZWWThtcC9wUmNWL1VoU1pGci91RXMyM0NWbkdLVTBz?=
 =?utf-8?B?YnlPQlByNno5NU5YV05HZit0cllJSEUrYWFmK01HK28vUHM4NzZqcTNvZGJq?=
 =?utf-8?B?TkV6MEFhcC9ueWFrUzhycmRLWHdZc3IzYWJ5c09RU3RpMldKelBYYzl6eGNu?=
 =?utf-8?B?SHZUb1VxTzZBOE4xdUdyWWlQU25IZUNxMGk2VEpORVV0MnB2WDFNdkhIWWYw?=
 =?utf-8?B?d0JnbU45L01DMTJmM0dSL01jL295Mi9RQ3RUSnFFN0hWTTc5NWYvOHZtdmtq?=
 =?utf-8?B?UnZKTzZ2RGxjaHhrNWRoYkRyS2wxYXViRnJxMjNaYm1FTGtxM1ZSc0ptTHQ4?=
 =?utf-8?B?dk90aFA0RGJ5blc0R1dnVjNyKzdLb1F4bU1oanlVVSs5NVljbEcxdGR1S3BZ?=
 =?utf-8?B?M0hES0lSVkNRYUU4VFljVlA0cnpDTVVEZ2hCQ1VmeW5QSVlZaXZSeWJlNVVE?=
 =?utf-8?B?bUdSUzNXWjBjTmdzNEswMWluS2x1M0x4QWU2ZDdlSWRNUHMzYTlCTTBPREJy?=
 =?utf-8?B?WGhrQ3Q4cTM1SkVaaWFtZnpUMC9yVzh0NnpIZ0p1Q0FucVVmZVJSTHliemVt?=
 =?utf-8?B?K3YwKzVkTjRFUlZFaDhRZ3hkckhGazdiS1ZSUitQd0ZFMGRnL2JVb3JhampX?=
 =?utf-8?B?ai85ZmxJQTUyY3ViODJsRVhoV0hyUitiT1RFT09rL3dTa2ZGSzFzRFVvUXJR?=
 =?utf-8?B?MjhWWkQxbHVDTUswT0tjU0ZZTkRTUkE2WHJKV0JKK0FnV1ZVWlNkVHMwckZv?=
 =?utf-8?B?RlJXOEZwNzFTMnlzSXpJdUtiWkpEZ0tjQlp2RnNyM1BmN09XZzh6SkRhbVB6?=
 =?utf-8?B?NlJnS2hodjBITmN5dGhVQWdQU3Bna1M3L2JzRStmVW9jbjRPSUJtS0loUWtN?=
 =?utf-8?B?Rm9SSHNza0hDUTNXYnkzWmJZM2J6bWRuMjJGVm5xbXl4WkJZOHFyOFlYUmZF?=
 =?utf-8?B?RHZJUDNRZzlvY05vT3pnaHpBNjQ2OFgySVIwUURhcnYzM0tHZWtHSU80Mmtj?=
 =?utf-8?B?Vmo5T2xzUndISUw4Mzk5SUFxRHRaZ0pKWFdLd3E2MWlPMkVRcVdpajkvU2Iz?=
 =?utf-8?B?d0VpYjNhTHZjcXRTcHRoTlUvUXBmVllnU3hpWHpINm1GSmZaYUNDbFVnZmdQ?=
 =?utf-8?B?bWJoQnlLa3ZvTk9WaGU3L25RZlZHaTB0VG5HbU9KZUMyVGxUUkdEakFKNnk2?=
 =?utf-8?B?OGM3VlVpaXJEaWxESXpwRXp6TnlvZUl3aCtYa0w1RkNWM0RPRld4c3NTZ1h4?=
 =?utf-8?B?NXpwUDRFeTZoYmh2a28xU2hjcXVQV1VLMVBpMDlNa3FEekg5K01Bb3NvY09s?=
 =?utf-8?B?YjVoWStFQXQwanVLQUlhcmIwUmM2YW4vZjVvekxIUlRSOXBmMzdvbTB0ZGFQ?=
 =?utf-8?B?SWFZVU51bjRRejNxektBMlY0YnRtMWJWNlFIOVBkSGwzZDR2Vm9ZN2R5Lzdo?=
 =?utf-8?B?TTdlc1pQa0M4YXVZTGx5WnpuSStraXNKTG0xZVE4UmJCNXlUM3g0QkI4M3Iz?=
 =?utf-8?B?WjQ4WWt1SWVGeHowZ21uQjNqK3JTaDl0bkl6Ylk1cDRRQnJzblZQMGo4Wlk0?=
 =?utf-8?B?RzRSZ1lOdmd1NUNMQkUvQjgrOTEyaUNyL1p5dVM4NitzdkVrbVJLc0Q5U3c4?=
 =?utf-8?B?U2FtR2RKcVUzWHZLQVlHNHFZd3VPd1doTVF6blRDR1dVa0FWaXRYUUt4MGtw?=
 =?utf-8?B?c09OYTVpRHdBeExWR2s4VFkwb2c3a2lOdzZ6NkZZK3J3cGtxYzdsY0NPMnRu?=
 =?utf-8?B?QnlZVEFGd1owNEhNUGJUZWtlSjU0V1g2VG9kTzMwT3FEMkVYZnM5c0lDcEdN?=
 =?utf-8?B?NTVBYzl3NnJadjZ2OVA4TXlQUm5GTXVJVk1pSjJ3d040Qk92K3NBME96V1RD?=
 =?utf-8?Q?RDTLvXLYJWgIygXMzWmq75CMq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d7bf79-26de-4db7-7a08-08dc6b3db77e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:53:19.6541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABDJeb0gOGUDVDzB9VZbKL5App0GtKhVNsABeCBWfOHulgrxz6XGc6OqcT8Vwd+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

Am 02.05.24 um 18:31 schrieb Shashank Sharma:
> This patch does necessary modifications to enable the SDMA-v6
> usermode queues using the existing userqueue infrastructure.
>
> V9:  introduced this patch in the series
> V10: use header file instead of extern (Alex)
>
> Cc: Christian König <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index df0e74a3ec8c..f7ece0b31ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	int qid, r = 0;
>   
>   	/* Usermode queues are only supported for GFX/SDMA engines as of now */
> -	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
> +	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
>   		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index c833b6b8373b..0989400d0afe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -43,6 +43,7 @@
>   #include "sdma_common.h"
>   #include "sdma_v6_0.h"
>   #include "v11_structs.h"
> +#include "mes_v11_0_userqueue.h"
>   
>   MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
> @@ -1273,6 +1274,7 @@ static int sdma_v6_0_sw_init(void *handle)
>   		return -EINVAL;
>   	}
>   
> +	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>   	return r;
>   }
>   

