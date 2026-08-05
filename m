Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5EBC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9312810ED69;
	Wed,  5 Aug 2026 08:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PqjnycWZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA3510ED6D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmsPLq68WEXxkOoXQNOgBBo6zhWQvIb39+n8Qg1JGwp/2pLg4uROoVQFl5P7QBpIeykSnHbv6NIBSlWumGc0q8FLZoMLPokJw0xIFRxdWjAi6UPIBv7jDfElPJ9xOI5ipYppDqPQDdlOy0Y62DT+Rz+IEbKU62Umd6pTbtrdGl8YlrG86M0y6yQKMD4pspSx6K3VL0a4wl27F8wGoKxswRKbWqY1v+XYJdyzpl80bV9FiUMC4LGj6AxEaZW0nTuOnnsmtwV1KNZUuWYp/rtSnbCo2HESBrPx4QxBT3BYk8Mm8V56zGyXjB6yK1D65GqcS1Iz4LTcBYv2lcpZyP6Dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUdHRb89lFxXjcKaH1FpG23U9bpnmixcfkx5pYLndYg=;
 b=GL6lH5cQUXst4o+Dnb2bN0uV8IBrmBZtcONTOHfy+VtERXRJmA116EWarbWJ2mr2AhXlpWTE2el21lwXu2teqe8d+XhZUtpZKXCOzyPh2ZE7hn8XFwGb8iWdaYoTG9XwEmxrjy2pZSCzsfJTUSCWRTttfW/vr6YiWCClpDwEH0Isoxx3bKXg4QW7biSSepnoOKsnw4g7yH+eaJQgdz92888MJTpr19snAMUBMM3L13E2uPa8wM8UldRSPsc6WJFXJeQ7PiyFV9iR5cC0xbJOoIA5HHXy2Y0BhcBOA/frjboxGxobYcD4gh2eeZhW0PaPZ6YWAnYb4lDcK97QdS+dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUdHRb89lFxXjcKaH1FpG23U9bpnmixcfkx5pYLndYg=;
 b=PqjnycWZaTci5yoyYoWpbXbCXZsngHPzEjVS9IZvDfXPJHB1uortCOPKV4u5FX5qC4P8ovdgKQHk3OwLkkGML4uXx+1G/p5nVpMuQyA+NoWj8rmc4uTyChhyTFKU8+/P6GWabtz9ZRzOoclgPFeSsqmaZjbXEsVLGriIXk5H634=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 08:06:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:06:12 +0000
Message-ID: <8364a68e-1d5f-42e3-b87d-9cf6346ef6d1@amd.com>
Date: Wed, 5 Aug 2026 10:06:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cap GTT size to physical RAM on APUs
To: Harkirat Gill <harkirat.gill@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260727194207.176803-1-harkirat.gill@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260727194207.176803-1-harkirat.gill@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 943e0537-820d-4abc-15c4-08def2c86a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lx6HPViz28g2y5KvTDYTGrXXtB2jRUd4WhLGqmtaTP+N0EZc+Nnch0JSkQIzDGEsOJRhdxEYYo7nV65Wg/hPCfzGn8c1Q2u13O0v/WuQCvG//4uLK1Zlet0+NqnAvyE4HIojDM+HLUQm42T/aHC3wFXWQYxbOfWUflkR2NUx5mUvMDH5px9V53MiY8HXDyibFtmH/oA33OJM+o86NRkjgUsh5WNFgIslmJBYPKHTwK/TDpzr0k8CeempVYDERpZNpcL+quPfQ7EE/Iwphdi43rHqbkIufnVp3zcNWTj3tDfIGOVYiqMYk9LDzEHo7WfCvAjaz+NF3sCNx+iOOnz9dFjEJ4jCrrcKMid9lNg8LHVC0hwKXGkCeUshTTCRGEXcKIOwL6wL4dOBPYAmvlUqR+gQn2O8XJVMtMAl3LNwxAAk44D8cq2dkFZ2U6ZUCqTck1GX2SBS7Nh/LCwLowBEo13k+P5ObBQMHMLKqq+/v3WnhDUNIEzcLK1TvHVS87xpScVYEbeeGRC6mFmXOFLw/xwV7fVcYVzYoIF8JHt5HNi8yPcgcR0lkGDZATAALqTvwcA1k2rhFwb7Nf1Fiu6NvLhzPJk5YXTdb8+/UNc+OgE+xpX1QrJipfocQbmXviXFU6bfM3BvMAmQOl7PhxwSqgiSe9zhck+lJ7mfg9lm5ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVg0YWZSUUNkNTBqSjQrNVRJWUJLNldtUVVBVHR0UnZ2MERYRDBPb1lqS2dH?=
 =?utf-8?B?KzFhbTdKcEQ4djRhWjhtVi85R2NwTGtiL1lKT1lIS1ZPSDJ2ZHh4U3ZIUEhK?=
 =?utf-8?B?dlg3ZzBGTWRpVkluYWxqeTlJZjRGQVBsVkEvNzh5ZUU1NDh6TUIvc1pmdDYv?=
 =?utf-8?B?TGZSakc3RlZ0YzdLZG50SlRNeHdwNVBVdUsray9WQlZRRml3QTJRc0ZpWnlF?=
 =?utf-8?B?WVhla0ZnMER4bHJUbzBQNG4xRlhySG5BOU1GU1pvbkRDcmtBTkZmRzFndlNP?=
 =?utf-8?B?NkxwdHJNaEw4eWhEVVFvZ3JCZGp2TU96VUVmemw5aG5jUVU4V1ZxVVFYUTBu?=
 =?utf-8?B?RC9ibjVrLzVBU2h1OXFvblMxaW9CSzF2U2dldnlhb2d4dHhhOUE4WG1ScXBH?=
 =?utf-8?B?cmZKYno4Z2MvY0pJeGtmMWJXRFdEcjZMREpOcHQ1NnVJWXpiWUVvc21nV3Iv?=
 =?utf-8?B?d1daUjFDK2JNeURWdWJ3VWRUM29wL1g5VnhOV3VWd1lrNlVHM0x5ZS9tc3Ro?=
 =?utf-8?B?azcrSFhyNWo4L0RpeHdwSmJjVHRhSmNzOG5RaU80OFk0bGRZZE1zZHdnVGs4?=
 =?utf-8?B?MEhXTU9DRm50Zys3TzZQaEFsclZwcTBaQUw1TXJyRzFITC8zSlpiVFRPVC9K?=
 =?utf-8?B?WFh5M2ZpeS9IdzNtWGJZT2x3UlhuNDRaK2NhZkNzRWk5NDhueWhIT0w0VHlr?=
 =?utf-8?B?ZFJaVFY4ZXJ6WEVSZXU5MU1Oakc4MW5ZY1NvWFZHSGpDVUplWUtZOExmdkFI?=
 =?utf-8?B?Wm9uWmZRbHplNmZwRml4ZmRhaEFZL1lYZmRvRjZOeFpYeVFucW14bS9uLzlD?=
 =?utf-8?B?S0RRSXY3RE9mTExWR0V1c3IyL3hwbEh6NkRLdDNoSFdSci9ob2o3MzhTdWYz?=
 =?utf-8?B?eXNmSVF5N1BhaVpsSkNlZlJNeTlUNnYyUmQ2TzVWWldzc0pCOStIOXNQcm1K?=
 =?utf-8?B?T0tnS0dNSUw3VEV6UkcxMjJpMWhiVUhIRXgySXVMS2hWckdYcVBuL0kycjI5?=
 =?utf-8?B?dDNKS1RIWkRlaGM2ays1bjNyKzN6SzZISVZSbVJreDFzYXRLY01QSHBmQllV?=
 =?utf-8?B?bGJZM3VrWjdyaWUzV0VRVFpEa3piSFhybmFISnNrUHd0ZjFRbHB3cm1UZW8z?=
 =?utf-8?B?dEM5YzhsWC91S3grTkQ1S0VTd0p4K0VqVGMvQjlsVDZkZHUycmJURTBMbE9a?=
 =?utf-8?B?cHoyZkJMeHFRaG55Rnh0MWxONU5BOHRYekdJUlVCN3FrMERYVm1QTWhmZE5L?=
 =?utf-8?B?QkJlK25YMDY5bUR2RlJ1bXkzOC83TXE3eGFNc2FyZEh0L3RtUUtsdDl3MVBW?=
 =?utf-8?B?ODQ1NzVrRk1SM2MxbWQ5WmttWEJieHZTN0lGbC91ZG9MKzZYdjFFa3l1T0JY?=
 =?utf-8?B?SVNRRXZXMStyRmhTS0xqeVpqYzZjeGVQemtHQzhnMkxBeVVXWHl3RnBoaklv?=
 =?utf-8?B?M2dDeWRMdWJydEdpSXUvTTFLaGErQ25mbDZZdjBxYlBWODFyN1U2ZmlxRDZ0?=
 =?utf-8?B?R1ZwY1RmYXorWU1BdFd4bFFGc3N3dUpKdlV2akxBKzl4cExscHhtY0w2V05R?=
 =?utf-8?B?cTVTWndvNjNjRmZlNTAxdlgrSThBVTU3dURCQjNKNFpuWWxmL2htVlkzN2Nx?=
 =?utf-8?B?dU1lcjlKVHdpbXhLNkhpc3JiV2pVRTY5NVE1azBJbkhLZi9MVlFVZS9ub1lM?=
 =?utf-8?B?c25WbExVOHlabXh4aDhJYjdyR2pxV1FnRW4vQ3ZTSER2UHN1cHNxejJaQlg2?=
 =?utf-8?B?NlNLdGJVSmY2WUpMK1JLWGlreXp0U2p1b1RjU3NqZG45L0dwSEc2SS9vUGdC?=
 =?utf-8?B?LytSL1pSWlRsMGRWWEx1MDJEKzZuSE8yZHYxbDZOc1QweGhEK0RrdUhhMVVB?=
 =?utf-8?B?UVFZaVVuSXJ3L1pWa09zd08yOGNNbStFYkNJbU5JVlY2bnFiRlhyeEw5ZzZU?=
 =?utf-8?B?eTFNbzYrK1JsSDV0WHBpMmg0OHdmcXl3dEp6ZWE4bzczY2lUVzA5eGRaUVhU?=
 =?utf-8?B?cWZnVHlVeDJpaitFUWgrSExrcEhRODNTbEtvdjFoalFRbSs3ajFwYUxxbmth?=
 =?utf-8?B?eWp1VVRYZmhNeEIzOFU3YU1EOHNhZGt2SjlFSXVzWC9pdnI2aEppVEdRSzFO?=
 =?utf-8?B?RlJtVUlDWGJ4alFvVHZqRCszZ28yeUxuNnFWYzlyM1pMMFZiaEJ5R3FjQTZk?=
 =?utf-8?B?OHh2WTFobHhnVTc2cWxpZEdKSXZLQnpRMnFQWDUyN0huMERXbXkrMFlCZkZC?=
 =?utf-8?B?OXRnVitlNE9RYlZwQVo1ZDF6MExIdWJYOHNOZUgzSHBtNnFjWjBzNGZIaDZL?=
 =?utf-8?Q?G3Hp1cOcqg7eaI1Sdn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943e0537-820d-4abc-15c4-08def2c86a65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:06:12.6867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbaEfq8J/VdEwubn+9OHg4E/t9KjfGjPQ6YTVYJJLmU+gNkaUrPYcabdYbikzH3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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

On 7/27/26 21:42, Harkirat Gill wrote:
> On APUs, the GTT pool is backed by system RAM, but its size is not bound
> to the non-carveout memory that actually backs it. A user can end up
> with GTT + VRAM exceeding total physical memory through the following
> sequence:
> 
>  - Have a large non-carveout memory space (~128GB) and accordingly set a
>    large GTT (~100GB) via the ttm module parameter.
>  - Lower the non-carveout memory space in BIOS by increasing the UMA
>    Frame Buffer Size (VRAM) to 64GB.
>  - The previously set GTT value (~100GB) persists, even though the new
>    non-carveout space (64GB) can no longer back it.
> 
> This leads to a case where kernel reports GTT (100GB) + VRAM (64GB)
> despite the sum being greater than total physical memory (128GB).
> 
> Cap the GTT size to totalram_pages() on APUs. totalram_pages() already
> excludes the VRAM carveout, so the resulting GTT can never exceed the
> system RAM that actually backs it.
> 
> Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
> Assisted-by: Claude:claude-opus-4

Absolutely clear NAK.

This is exactly what the gtt_size module parameter is good for in the first place!

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 7920675af..da89d19dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2173,6 +2173,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		gtt_size = configured_size;
>  	}
>  
> +	/* Cap GTT so that it does not exceed total physical RAM. */
> +	if (adev->flags & AMD_IS_APU) {
> +		u64 phys_ram = (u64)totalram_pages() << PAGE_SHIFT;
> +
> +		if (gtt_size > phys_ram) {
> +			gtt_size = phys_ram;
> +			dev_info(adev->dev,
> +				 "Capping GTT to %uM to not exceed available system memory\n",
> +				 (unsigned int)(gtt_size / (1024 * 1024)));
> +		}
> +	}
> +
>  	/* Initialize GTT memory pool */
>  	r = amdgpu_gtt_mgr_init(adev, gtt_size);
>  	if (r) {
> 
> base-commit: ea97ab2759506d9a818ffed1009bde01062b4091

