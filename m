Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906B7D12680
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 11:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CD010E09D;
	Tue,  5 Nov 2024 11:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IutC+tCY";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A35710E09D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 11:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtjJL8guna+X/84wEWWjMDM04uMAN5lhj8o6vvbxyUot8TXhiQbkk3HS0x0LoJdhlKqRLpj3RbYKD2p7uw4xEwBsTv/YABG9KmFDx1yTlnxkHX1T1/8Yae9t34cIVECY4p6221zQSFi2BzwOg+AQHL6AbRFm1Kf99z4VAMGcLG/BoZwfnW75ABsKiHh9n/WslPS2Mikij8OohhgvAhCPiafqlBGdI8bkM7OdRQWGkCbj7cUx7svVx9J5JZyssel6ZQhDlz1AIjUB4Pedn93mHsQWmM/x9v6ZnInXxFCbi1MRsIZXq2g1upfL5ZwIEt9vEY0oBM+tLVfR9clSOTTfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/riQwwJCCFLAO/x32XjpqJNTXinGNSZ72B1TwB/D5o=;
 b=duTK/qfKF6PzxsinrwhI7PUzhSbBiaG4sL2C3qpo3wMY+dSqBfZkpTvOkUqbrgAHkaQl2tmV7SerpgmFonV5nWNYaTI9e1ul3r/kkhc0JsNQoxWPwaB7cB/aAh5wiI+VrWh+qijBdHaDuWV7BmsLxyv6MnsFE3Rfyab7cg6GIMRnGNl8+DQxgdS2DGf6FOGh4Pei3rsOO2tn4hW583wjYkbQlumgc2OS2mCF6xjZEwn46AnGjgdvosnU/eEiaJ7iFmpoZ3y9TaWmW0RErL5fNUYWZGIa74PkSidi0VY4oEmXk3RHKUuC51pWeoC5zHLImyFG/U/iUEmF786cyrgEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/riQwwJCCFLAO/x32XjpqJNTXinGNSZ72B1TwB/D5o=;
 b=IutC+tCY4aHjH7vFCYiaPSHVX7T9P3U+2g1RHwWh0qJ7LZeiJ+z7JMb2rHfW/PsEmTes779M1Rja3579uPN0oXJOvMpK9HIt1j+hzWH26F8xUTIxiEH+bECqem9scb8w3ay7Hz/VQ6YJh58rNsgE2IzwbvaAjjNfoafp9oYtUDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 11:04:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 11:04:24 +0000
Message-ID: <04d4ab32-45a1-4b88-86ee-fb0f35a0ca40@amd.com>
Date: Tue, 5 Nov 2024 12:04:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: correct the SVM DMA device unmap direction
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241105023332.172404-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241105023332.172404-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd261a8-5b39-4862-1f5e-08dcfd899ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZaU1h6cXVCdVhlaDliY1pyWUd5TnBoYStZNEFtOWlmaUF6RWJQTk9XN28x?=
 =?utf-8?B?RlQwYUJVK2RwcXVSTFlzTFZySFR5ckZwUnR4ZVIwREdEZmdMeEl4ck1mR3pl?=
 =?utf-8?B?WkpwVTk0L1phY0VrQUs3UGpGR3N6MUNzM3E2OGs3RVdMMXpsdWVQVlFhcTNl?=
 =?utf-8?B?U1RGNnNnRXpiYkIwd1gxamV0WWEyS3lSVjBibkx3K2xtYXRmV05pODdZbGZi?=
 =?utf-8?B?RHVHN25aY2h3akhnNjlaMGU3dkVoaEIvbzlDYkFmTzcwcUVjSm9PMnZDeVRh?=
 =?utf-8?B?cy9lSTc3bFR6QkU1WjFqVCt6d2ttbzJWMzBaMjJ2WWpsdVpVQVhUVklUQks5?=
 =?utf-8?B?NnJiUWQrYnhDWTZiK0ptK0hwSFdUcFFydEZkTTNySmtNQUFkMjlBdWJ3WFlE?=
 =?utf-8?B?VmZsaXBEMGZtRC91c3RMV296LzUybWlOdm9FTTVWckJFUE04NXp6L2VrMVY0?=
 =?utf-8?B?L2pXVHo0UGYwTWRDU3BlVDJONmFYbTVhL2NybG1UYmN4UVpWZ2FKMHpFTm0x?=
 =?utf-8?B?cVdZNWtvYjVReTM3TGQ3cXoyQkNhbTAvcnpSNE9TOEFiREFselZsS05odVkx?=
 =?utf-8?B?aDZqalgxVTVxaEViY1l4M0RZVG5Wem5nQzE2UndHbmFyY2cyaVkvMjZqL05D?=
 =?utf-8?B?OWtXUXJxbzRWUHk0NkdZV1JpMEdUS25JLzBrUlJXaUVrL2N6N1p0U1ZaVjRi?=
 =?utf-8?B?aUY0dWZxZ0NqajkrM0RETE1qaE1McVRoMjZHdGtjL2hWNGJpSmdyd0JyOUhR?=
 =?utf-8?B?NHJKNXRRUUFqREtFdGRITXlrRmJQSGdxeGhsK09RMGd4UjZXc0I5TDdjOWox?=
 =?utf-8?B?aGxWeGNZajJ4a3Jua0Q3SGdscGRrNVVxM3BQcUFROEtEK1Q5S2dZbGx4YXVM?=
 =?utf-8?B?NE9BSG5LM0hsZFNJaFVpN3JZdG9Pb1BPSkZRaXcrT3N6ZTdmNitra1ZSczZv?=
 =?utf-8?B?bGhUdEI5d2lJV3Zhd0ZZeisxMFNkOWVsRzN1emd1eU9jSU02dTlZMnQvQVkx?=
 =?utf-8?B?eVJDRmRNY3JOSXY2Um9QS29Nb2l1d0F4R3VpR043UWdOS1BYU09qNGZlTlJu?=
 =?utf-8?B?dXE5ZE9HOVpnYWZIZmNWRHVTc1RERWJDcmM1VHZpNlVMaXhtZWkxc1pEN3B6?=
 =?utf-8?B?RTMrVndJeVpTdGc4NnBNdEdCeUx2ODEwOENWV3c4UG5Ea1lmVmZrR0xHWUMv?=
 =?utf-8?B?ZnJ4cEVzUG1sbHRqRWlmTmZBaTljUFpRZ0tZNk5CcGtNUjBKSFZhK0xRb1dR?=
 =?utf-8?B?TytjckRNZ0pXOWg5bjYvZGE1VmdoV05oNVJSOTc3Snc5c1QveU1saG9XNEJF?=
 =?utf-8?B?dndERDZuZDNGOWhvVVlsOVRHN2puR0dIQVYxVjg3c2ZQWnBTRkVhSE1QK3pu?=
 =?utf-8?B?TkdpTTNJdVhodmVkS0lWQXJWYjZsMEVReG02YmdoWDBkN0NLN0ZUS29PTVRX?=
 =?utf-8?B?R1dYZzA3Y1lDc1lMS3cxN1RXNFpTblNTNXVGVzU5Ri93MUJxNmtqdFEwditR?=
 =?utf-8?B?NUNkU1NXUUMyNlRTNXdPdkNNcFJNdVlmWTlvbStiTVBBOHROZUhRNkE0WjFX?=
 =?utf-8?B?YkJ2R3FVRXE1OVhEU3dlWExDWU5POFRWUVY3ZUVhSFpJUmsveHFKdzVmSlhS?=
 =?utf-8?B?RTJ5MGdIa2puN1J0YTltbndrallvVTA0VFRyWE40TTRuMDloQk9XZGNqeGpj?=
 =?utf-8?B?RWpnWHVqeUNSNUsva3Y1NkV5Vm1BSHNKeUZVMkw4UjlpWEVSQTNqMnR5NUkv?=
 =?utf-8?Q?WgynNCDh1aO9l6UhvLKbmhU7RI8Qwsb9J9Fdtyu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy9Ec2twK1V6MC9zZGFYL01lOW5CRVB6dHRCRFd1dGIxMVlRTkozcGVOd1o5?=
 =?utf-8?B?WEVrV2ROczk3ZFYraHJscWFBcVdFbVhrTWxlOWN5ZEY4SERUV3hHSzJjM2Er?=
 =?utf-8?B?dmpYeVpjMXhabFp1T0ZDbC9rZFpvOWRDcTBmc2dINWVJT1BCZUxUMTZDUlJC?=
 =?utf-8?B?UlRtdzFQWUNXN0sycjBLYWdldnRjT1hWcFJNWDBGcnFFYURXUi9YN3lPdWhX?=
 =?utf-8?B?ZlRNUTI2RU15cEh4V2dla2V0NjREVUsvZS82ZVc5cm5OOXdtd1gxNnlaRjZl?=
 =?utf-8?B?bldTYlhlTFkrVE1EVTJERGxqbWE1YU4vd0d0cVVXejB0UEsvL2x2Tlp6R0h4?=
 =?utf-8?B?NWRvZXZTRE1aZEtYOGhJZDd6WjJFS1RsMXFCVy9WWDFMS2FLOEMxM0tvbUt2?=
 =?utf-8?B?a1lkMTFDaUh2QkhLQ0JnWXZkdEQ2LzNUS3JCajhYSkcyS25LNFFrZlRpOWF2?=
 =?utf-8?B?Ly9rUHc5TVQ3aFAwbVRDYktFWXA5VTRiVUszOGZ5MGY3RTBZYzZHR1NMVGRw?=
 =?utf-8?B?TDZ0RVloNzdBTHpHdW5XanpKSXhHdDNvVUJRbm1RN09YcGNmWkRXRngvZFh1?=
 =?utf-8?B?UDRpZzRwMlZ6aXB3dTFtYWtoUThwTGRDdHZrNGJEcTVoWWNUNUUvL2dBR2Q4?=
 =?utf-8?B?eHlGRXhnellsakFkQVk1MUw1blVuZVJGRGJva0N2U05UeG04eUxyNWRDaW1i?=
 =?utf-8?B?NkhrWkpKZDZ5amZkZjN0cEdsZi8zS2ZZYWFXZU1jL3N0KzExOFBDdWNGa3FW?=
 =?utf-8?B?NTlmczBvREthcnY3a2R1bThCb1huY3dOdzluMGRlNDRKaUdRTjZGdEdtYjJi?=
 =?utf-8?B?L2orYUdEanM1U3kxZFNpTTlFWEl2eityZGlRUDY3TUUwcUxpOVJvYjBibjVZ?=
 =?utf-8?B?YmY2Ky8xNElFdVBtTVAyaGVxeTVwdWo4aDU1NFN0cmNwZUg1NmVpc0k2NTRn?=
 =?utf-8?B?NzBPQWJVWkUzV1V4T2VRaUFCZUROVmJZc1YwUFROc0gyRVVUREZoWjNTOVU5?=
 =?utf-8?B?NlpGbjBTN0U1SzV4dTFOWXBQSk01RitDT1dNSjZTWUFHYTN1QXh2eXNpQ0FT?=
 =?utf-8?B?T3J0VExJOG9JMzViZUFDV1VCbzFJbXVyYTBkQ3IrUHFoUTFnaHNOK1RJRUlO?=
 =?utf-8?B?amtkeWp1VldYbGQwMkNGM0xldnkrb1FSSUltWTNXK29rVFRuM1hZaHY2WlQ4?=
 =?utf-8?B?RXZlMXNTVlhzWjBaMTFKQmdaWFVRKzdJNGJkeUcrV3FiZDNPOXZtc1Vab1Yx?=
 =?utf-8?B?WVorTitrUDhudmFzU3BQVUlJYjFsaFRCdFVSdDZtMjFqOXV5NmJmVEFXdmlq?=
 =?utf-8?B?Slo4eU5EVDcwNkU1aDRoUllIQS95bk4yeEtmYldHVXNkV2I0b3hCSW1PaWNE?=
 =?utf-8?B?M2F2QWFtQzUyY2dGeU1YOWMxZ09uTXcvY01kUm8zVUtFeGZYNDdrVnBrK08v?=
 =?utf-8?B?U2cxRWhJenA1emZFU3NLUUF3L2NIMUlXaG42SW5iakt5WURuZU5OUklRWXRI?=
 =?utf-8?B?SCs3ME1NL3NiZXc2SFRINnA3VHVnSCt0bnh3NUNNdzBXU0hzSFc5b2IyR0Vs?=
 =?utf-8?B?N3BrV3o5cUNJWnpvWGhFV2lUcHc5V2dLVy8xSDF0aklXVDdCN0d0TklCaTlI?=
 =?utf-8?B?UUVnSnJnNkFBMWRNTitENGtFa1JBaGJ1TVR2TDJDcG1XUG9vT3lVNzBqSEY1?=
 =?utf-8?B?cEJ3Q0sva3YwOEhOQkVScVRyZUt6MVVodGNoWWlETENtdVdHZ2g4OHZLK3Vn?=
 =?utf-8?B?bWhoTm1NRUdIYkVJZm1IUzAyb1hOaUFKVndRb3ovVjZ3djhWZm9GcDd2ZTF5?=
 =?utf-8?B?SzF4SWpZUnNYa1hQMTBmdWRoUzZoZitYTlc4ZlZFZGgxRkh5bzdFdnFIaUlU?=
 =?utf-8?B?aUVYc3IyS2hBUHF6Y3hZZ3FwSGd2S0dSZlFaZUt1Z2V6MG9iQjdYVlpaTlFP?=
 =?utf-8?B?MDVFenBxdWxYTXRnK2RQdldEUklHbHJxdlpRK3Z1MUQrK0NxS3FyY0U3Nzlr?=
 =?utf-8?B?MUFIUDRNZ1JiTGJUZ2xnRUo2QXRiT0g3L0dqbGdEem55Ull6bXRoYlFPMGNz?=
 =?utf-8?B?TnNpaENFVml4cllBckZzVlUrZHpYdkx6NWwvWFo3MmFFSlJ1dGo2K2VMZzZK?=
 =?utf-8?Q?KmsknE9RHL5DlouC06UFwQOx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd261a8-5b39-4862-1f5e-08dcfd899ba2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 11:04:24.6453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3syiOwA6hg6HEuVsqRZZVkpR9BPFJv/h5fkULJ5NRjCN22q5gElfjX8f0hBcJkQ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

Am 05.11.24 um 03:33 schrieb Prike Liang:
> The SVM DMA device unmap direction should be same as
> the DMA map process.

At least of hand that looks like it's only papering over a major problem.

Why are DMA ranges for SVM mapped with a direction in the first place? 
That is usually not something we should do.

Regards,
Christian.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 ++-
>   3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index eacfeb32f35d..9d83bb9dd004 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -445,7 +445,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
>   
> -	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, DMA_TO_DEVICE);
>   
>   out_free:
>   	kvfree(buf);
> @@ -750,7 +750,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages, DMA_FROM_DEVICE);
>   
>   out_free:
>   	kvfree(buf);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3e2911895c74..c21485fe6cbb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -233,9 +233,9 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>   }
>   
>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
> -			 unsigned long offset, unsigned long npages)
> +			 unsigned long offset, unsigned long npages,
> +				enum dma_data_direction dir)
>   {
> -	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>   	int i;
>   
>   	if (!dma_addr)
> @@ -272,7 +272,7 @@ void svm_range_dma_unmap(struct svm_range *prange)
>   		}
>   		dev = &pdd->dev->adev->pdev->dev;
>   
> -		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages);
> +		svm_range_dma_unmap_dev(dev, dma_addr, 0, prange->npages, DMA_BIDIRECTIONAL);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index bddd24f04669..5370d68bc5b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct svm_range_list *svms,
>   			     enum svm_work_list_ops op);
>   void schedule_deferred_list_work(struct svm_range_list *svms);
>   void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
> -			 unsigned long offset, unsigned long npages);
> +			 unsigned long offset, unsigned long npages,
> +			 enum dma_data_direction dir);
>   void svm_range_dma_unmap(struct svm_range *prange);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);

