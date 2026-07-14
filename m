Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4ACC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 09:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E9C88EFF;
	Tue, 14 Jul 2026 09:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqEMx7dN";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E7F88EFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKWsaYw3yU/gE9w0DNoMwU89323zd1cd6C+17EWuPAAoWP2pWDL34q83OvbkR7LWtkIgRViNx3njATtE810dukYRcaSUnDZl+h49vpl9EIxR0pledJWzRApB8schNPbrL+ahEarqj5NoxGd4ooW056u5UdnIWFm+OLwhYvwrfxBw/AMKZcp/5YQSiqWOwkVtnjuvEknfYk7g/7oXYCqylzI3ZqupVfcEYSph1bxi09I0Uw9FtccrooWvL+cUpAlC1M+V/ApoutWwr8zabWh070bberdbKsLrEum36IUhVGZBRczBNYIsX86hwPMkykSfKOu6Km1KkPIoV51+c24DoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaeFaD24yLaEX5MFKuqzYqkClfu1jzrzSJnPqqVsCHc=;
 b=Wb5qQ+HvyNEXhHIHPsx7KDz7fx38MZV9tD5sFysvux5nsYafdR578lZLBnoovKmgTvhrt5r0DVNi/hYoJoR8Zt2mPGxhi0wtihaSmsFKmAMYYLtaFUq0tVBYbaNwBoN0e9bMw15wCCO64uqVNS1gU3HcjJhqRuBUn51zyzKkFT/Fu/045aCR+FuBgHe+nL9c6YcXJgQvp6CqoF8fEIa8WOVgmxfPa7OpajRMz8L+HWQoQaykxLxz/TNSBlWV7e6z+hVH8DXALKD+8BHTfGLf/EPy5lyXMDWtcSlWthD43kS75Gy976gEpuA8mL8v3twPjRZfJMafJ6HY8eI3b1qtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaeFaD24yLaEX5MFKuqzYqkClfu1jzrzSJnPqqVsCHc=;
 b=VqEMx7dNSdZkQCMkrdAjwLaN+UixD3uzNRF4W+7qcNrgHRfuGgY9rq180IFOxEc0b7N+HDmfmsNmffRQU2TGP34pgaRPJYfxS0X9asIXRVZFrWKyBUWUeB5QqTufhSMw5nMC/Jir7+yzpGW9n2eQut5Zn6DtDyJfbLmZaf2yBpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAVPR12MB999120.namprd12.prod.outlook.com (2603:10b6:806:4e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 09:39:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:39:29 +0000
Message-ID: <0bdd946c-3763-430a-b613-be7f1c9b5885@amd.com>
Date: Tue, 14 Jul 2026 11:39:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAVPR12MB999120:EE_
X-MS-Office365-Filtering-Correlation-Id: bb76357b-954c-4215-26e7-08dee18bcd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PONRJR2gfbm+DEqT0AiShlXbVTqTUWfiQow/qnWsOcI/Ve33rlAJ1GibVXy2FTSoGdIGx/xz6dROX3PJGWay2Gx4CPIVaPuTWp41vMLH+3h/LosyQM9DZCOf3eHnz8wMXeu6ob/UtpjDzyCjpdeZpYyuZWjdjMEMQMenQJyOhpemhO0MX6RDPBmxTsdQQDuaOPi0gEFom91HnUkgW5M+XS0MgdXKBFTGtjqvG0GNQiuYBGhqnelEbv8R5uwdybcV8wELZyIs5CLPTYiqEAqXOaatkABp7MpAM1AwmRpr4qNQKNnNZA+GKB20BgzvT41J+fLC+dC75U8LgRLMiwDzAkWdOul7v+/VrGQgQccOlUVA2hJA8RvAOHK+BswZbJ87QGKvBoYtDmzEC2YatHuzda34YyDFlS/itD3IH9hNC+mudjFlBvpLF7vbFO3MXVqA78TLen8JLFZoQMDrXUw9Bs4PGaIWU6Q8FnYst1qyIsUiSliJPHQgFqyZ6/diRKMDMKNnzbeSCYEkaZLsvdkFrc3dNjFyEFSd4L83IHP6wx/c+MbI0WbvAUaPPxk+8TECuNdzwQ5CccKKJh8DK1wzpAN1bQT+3xeVWksWykBb2cYdW1QMhroqHMBSFvq5u1Hc/4NO2TeXIATPyPCz+cRCkObBMLvgRZLs4PnSAxJp4oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdVRXhDVmFieWduTGdVV2RxOW5tYUp5ZFZQaTNDQ1AyOTNmWXBiWENtT210?=
 =?utf-8?B?L21BK2JQWVN1TFRwM2kwajBGNzcxVUpNZWtLUmxEcVV0dEk2SStldEJPR2JI?=
 =?utf-8?B?MEJQS29YbXc3bW1IbDN6ODVZMWlGaG1tOG9sMHM1b21IUWt3eW56MFBoVGd0?=
 =?utf-8?B?Q0QyTUhXTkNrdEhZWnhVTWl3SUlKWFQ4N1J3aks4VkVScTlhMmFTN05Cck1H?=
 =?utf-8?B?SjRDVngrUm8xME9lRGYwVm9JdVpzdDVxZFJCY3lXRGxBQXRFMUc5SjlCeFNy?=
 =?utf-8?B?VG5DUGVvTnFWNnNKOC9lQWwvbGhheUY0bzFtZ2dTN1cwTlZaaTlMbU4vcGJV?=
 =?utf-8?B?L1dzSUg2enhtdWxwZTlRb0pEVk4zVElmck44Zm1PUlR4cHNXQ3hOV3c5SGx3?=
 =?utf-8?B?WUxmLzhVaEhUMTJGek1Pd1F2aVY4TUJsOUpKbURUMnpDQnlJZytQanNkQzlx?=
 =?utf-8?B?bU9tcGpCMVRYSXZPS2F4bDQ0RUxnYjU5ZzJEakY4TlZicUZhOXlFZ1VoNnc5?=
 =?utf-8?B?aUFHcjhWZW5iSnk1THQ2VzUzY3o4OVI4R3lvSlY0L1Q4K1Eyamt2ZTRWSU1U?=
 =?utf-8?B?cXJ6WmVKYk1OOVNGdUxiWnNWQUwyY3B3OU9COGQyQURvSEo5d3BFUVpDSmkr?=
 =?utf-8?B?RmQvSlg4RUZSdjVHNlRzSzI2MzVDZC8zaGMyTUNwblpUSGJuLy9IbzRMRmJW?=
 =?utf-8?B?cEpFRXQvRVA1a3BERG12ajZRQzhZYk9kbTVoanA5R1lheUp0UkVZczkxald0?=
 =?utf-8?B?cWJrZk9FV0N2ZHpyc0kzNk04ZEtTRWFFR3dJMlpNN0UrYTNMY0ZsV3NFNk1K?=
 =?utf-8?B?R3lEWHRwWUNKODJqZ1IwaGJOVlpKcE1MclYyaVJ1K2xYcWZ3VWxMd0NYNzdT?=
 =?utf-8?B?TUt4eUZndFZOVnQzRjllZlcvaUwraXJCNkZyZUV0dCtMdmIyY1Q5RlJGcmp4?=
 =?utf-8?B?OUc5Q25lZGxQSkRpNHJEb3N1RStUOWJpZlhmR2RVS2V3YmgwYlFKZXh6UmE5?=
 =?utf-8?B?a2Q4ZzRrYXV6RktuYUxqNkRWRGZFS3pZdnU3SG1tMmM1OWJ1Qnl3VVR1NEJV?=
 =?utf-8?B?SjZtWnNxclZRRjBvYUQ0Z0psR3hXRVRUWUo4d09RNzFsbUFDSGMrbzJyZmtU?=
 =?utf-8?B?L3R0dExvWld4VmhmazNrSVMrKzRNa2J5Wm1rTUtmWUFwTW4yMng4SFpuNHJS?=
 =?utf-8?B?ZWFGRzk5clRsNXZCVytDSGZKUU9hOTBEc21uOXpnT2RhSzQyZ3M2Y3RvU1Y2?=
 =?utf-8?B?NmFtajgyU08xS1V5dDE0dFdqY0FTQUgvZlk3UWtJU3ZWWkxkVTRvUHN6cm8w?=
 =?utf-8?B?VkRXZkYraXJSNjJmbXdKVGRNTVBLLzRPUDlOdnFwY1ZkZWdRUUdTTE9XbWR2?=
 =?utf-8?B?bXZRbUlIVVVXNlJWLzI5MHBWbmhCbnhQV1l4aWVVbktucXJXT2dZQ1RXOVpj?=
 =?utf-8?B?LzFoNkRRazNFbkptSW1DQkhZdWRzdFVJTk92UFV2YUV3QkdmN01oc2lQMTE4?=
 =?utf-8?B?YlhrZ0NEOC9MVWo2SDBVTDlyVTdtNGV5QTAwb3BDcVE1bm9HWkt4MWk3aDJL?=
 =?utf-8?B?SkVEd3JxeWtLZXV4ZzVrL1pqL1V2c2FFU1hmRUtyQmg2cHRva0lSeWYvc3dO?=
 =?utf-8?B?Uk9Fdjk5VkMySEU1OW1Lc1VXd2YwbEh3U0VjL1V4RWdIWmV6KzlLS1BDUkRs?=
 =?utf-8?B?ZEhoK2VsMHdRbkZvVDJXejlpZkI3SmJkYmRuZlhOaUNUUWtZMlZPQmcxclMy?=
 =?utf-8?B?MDJ1cWQySG5aakZqSWFJZTB3VndNei9EenJnUTNoTnJaWTdoNjZYWlp2MjJ5?=
 =?utf-8?B?djFCMG9VMUZHSmVXT3pXeURXSlBaWkZqdFBXQXNKZThsZURzcUp5UlhEOUdY?=
 =?utf-8?B?WFNoZVRZRDd3RjhwN21pcFpqT2FMSXpaSWx6bm9adXpKdUJNRzRIVS8wdllj?=
 =?utf-8?B?bGwwMzFQQi9oUk1KcG8wS1ZqYTJvRU9vV1BsNkZaR21HaHVBaGpQM0R6N2pi?=
 =?utf-8?B?N01EUDNKTTY3RHZvZXRwUDlPVWRhczNqVFZBQW8rdkoxMjRoQlRZV09DTVov?=
 =?utf-8?B?L3FTS1VUWkxXMU84SDlSb1BhZ1hWYnRoZW81bU9GUXFqTHNOUG5lSlR6N2N5?=
 =?utf-8?B?YUY4dW92ajRZNDI3WllFclVyS1BEVmtVeHNUakdOa1ZUK1YyRWtuUzVaZlMy?=
 =?utf-8?B?RzkzY0RGd2Nsa3VtYmxTcmsycG1lRkV5anFsSzlYKzlWSldqUFRPY1llUU5U?=
 =?utf-8?B?emtVT2l3VGloZ3ZDMm9IeXRZT2VGV0t2SGRwRnAyaVZRTzJpK0hQR1F0cklk?=
 =?utf-8?Q?/oVw8bY+ihfihOr/60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb76357b-954c-4215-26e7-08dee18bcd26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:39:29.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtV3Feh1+R0aVG5N0AYrKlqVu8px0K3Vt9hxK8vtMp/J2IabQ66DLZhn50yARM6h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999120
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

On 7/13/26 20:27, Alex Deucher wrote:
> We need to disallow gfxoff if we touch GC MMIO registers.
> At the moment we use KIQ or MES for TLB flushes so
> no intended functional change.

IIRC we actually tried this before and reverted it because it caused quite a bit of trouble.

The final solution was to use the semaphore to prevent GFXOFF from happening.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 1fcc0594fd0a9..83b91c94a6623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		return;
>  	}
>  
> +	/* disabllow gfxoff when we invalidate */
> +	if (vmhub < AMDGPU_MMHUB0(0))
> +		amdgpu_gfx_off_ctrl(adev, false);
> +
>  	/* This path is needed before KIQ/MES/GFXOFF are set up */
>  	spin_lock(&adev->gmc.invalidate_lock);
>  
> @@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  
>  	spin_unlock(&adev->gmc.invalidate_lock);
>  
> +	if (vmhub < AMDGPU_MMHUB0(0))
> +		amdgpu_gfx_off_ctrl(adev, true);
> +
>  	if (j < adev->usec_timeout)
>  		return;
>  

