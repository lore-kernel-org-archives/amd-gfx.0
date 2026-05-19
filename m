Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A20CD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 09:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E0B10EB9E;
	Tue, 19 May 2026 09:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCqDRkb7";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5711210EB9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyQR+XE/7AivJeb6Vs3p88eh3OU9dOW1NSIma9xLkfcIBGtYbt0RTE04DHWjMwEW4/mIMRjrjLiW1GEKRSmuNoJP89zthWsAVi4YJUZaeBXYn7lX6JXJQdG5b0c62uXG97vH9f5ef7S0D4QM5YP7c0IpZmWykHA4ZJlpPVTNXFqy7JiyVFD4gKTv7PlXB5ULnbW1FTW9LDz8CKdeXbyHOpW+A3+Vz+Wf72Ymq+u5VOGIFVZcXWoLgnA8osBOrpBTioOJhpysx27KFANmE+0Pqz1dJUQPfVzwGMghvEdibH2FwYGYnWsXBK32iFh2AHqtNN7wmaQxLh79mopwhA5M4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHr+7L7dgLrzhLvoTnYD5VlQAcOWZdoMYLZ2X9s3c/g=;
 b=V1maJmxqn36JwX8IIFLVDyehyEu3vpF6vRcf3oUlWNQXvNzbUEZ3lkIdoUYQMZedRQN608TiX4TLz9v8HS2E/SIFjZH7LKu3NQVi2NuwHMf1quS04BOgEiIdS8R3A7kkt/oiUI11cmANJ7Ake5bd+05gcjJt08Yr9kozB7Dlmv/c22NgFQFwr5zuNrqUFcY7wF7nVRhkXNnGaUeWKdbKAdILnTMSj0vUF3z1Bp3oYX7l2cl3UXUEb9RuNilSBUpJq0o5mBK8l5gQPd2tnPXYv1jOad8wAfUE1lx73Hpv1muK92QXluUwufxIys9bDHDsZakp9dCt/9sdaCFOmC+2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHr+7L7dgLrzhLvoTnYD5VlQAcOWZdoMYLZ2X9s3c/g=;
 b=WCqDRkb7rKuDtxz6SNAR0S/X+2RAatIRM669OshfU4g5QJtHYtY6btmRr2BIqr+NU4P8wRbmXX7iY6T7G+5dKHbhqHDjYKEAUCB8EVqDaIU3+XzS/cSOBwgpXbtR3dNU627WvY2QDJjSsJeYtPtTS4o+EAGChFEu46bhs20MgVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 09:06:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 09:06:56 +0000
Message-ID: <be651c7b-a9f0-4cbd-bf0a-30b2499b2ef1@amd.com>
Date: Tue, 19 May 2026 11:06:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu/uvd: Fix forcing BOs into UVD segment when
 it isn't at 0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519082204.60811-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b9068f2c-1a46-4b28-4ed6-08deb585fa39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7g9yEwpn8eoyBnkhRzyGNzifhVWENNmaO6JjgaM+ucexP5N8s8ynuCv+7Ch7OQ6gUm3OJ0SfxkUmZ1luJSpYlz7l5ITfxuOyCWtw2b274JTJ0HpUqVnBJ7+z2pgGFSEpPFbRKGDfhuL6X6/L3hZNPpUzgmMZiy2Mwcnr63AfOw/WnhOt5FNIoZh+FboXARZhu03Fgvup+ogvSScJqvrisOxEjCP9n27l8/iwmnWRCnPcHgL946bzPQr2JcdHdamOK3cBz8D+n60VMe37DxHRkUC7cHlGXgYbOYRAtvWvwmPWMRYWb6k//KBjfR2/DzQTrg18I6B8KMuPRcqV0c5doeijifdLUVeYVOc8dX2+obZufEOSosF1dysTQhHatKTZiISCBYPlUWh8H4+A9Ru3htXOAf2Fu6unRPMTc40RrRQcXDMfoNEKWQshvvSqYrIDmuA5atbbi7vcpmrH6P/R1aGPREjc58faTC9iQvvTaZa6Y+H92SjDj+iHnk/Gsli6ekV/4Fpo9+WvR2IXglGMWUGh4SKI/3eQduXXfIiCrE6xMOGYxUlHp3kTRQEtO6nJaHDMlfklNIqCIePmGrm2nzOb8LC0IsyvEADIE1u/TyYr9ZLY6rXIjeyuwAakLvgTiFjnhTZdNdtFvvMSpz/sXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3d5TWJZUTNmZUJZOWM3TDFuNTYyN245cVJERUtJMGk1Y3FOTW5qbjRLQ0dY?=
 =?utf-8?B?WS9GQzhMNVcvM09zaGtkVVowVG1vdCs3dVlPWHBoNXZBanVYekkyK0QwU2pk?=
 =?utf-8?B?d3gxUEFSSkJ3ZnpTWnVNanIyaXVJekxIbmtKQlBYTHp0cGJTV1dFQVcrZG9v?=
 =?utf-8?B?d2RMQm5YSGVQVVJVelU0Z1Bjc2tMRG83SEJ2YjFGdCtTdHZEN3g1a1ZlUWVj?=
 =?utf-8?B?N3JmTUNKWUFqQTVDZlg2djJBUVRhSDg3eFhNampTSmMrK0dOdnR5bmpkSG14?=
 =?utf-8?B?QXVDbHhDeDdiaHBBeGdhWHB3SzhPaEpzWDlMYy9RbXRnV3BHYy8rR28yNCtN?=
 =?utf-8?B?bWpmaStUb3Fid3BKY1NEbVg4RllWaHB2VjRPamN3NGNObHVMaHNkWXdybENM?=
 =?utf-8?B?OG82VUIweUM2NGRuMnZKbU1aUTFrT0k4Y3hUOXZVYXEreDhOZHVTdjRhQyta?=
 =?utf-8?B?b2NzUFpjWnVUNXFTMXZ4VDlSdzl3TFdPYU95eXY5d05tNjNUUXUxVXVlVklQ?=
 =?utf-8?B?enBINFpQamFCSDc5cTNFYnJMeGlKZWh1Wlo2SWowMnlYY1h0TnN0b3ZUU0lS?=
 =?utf-8?B?cE5MMGk5NVhqcUc2cUpaNDdvSUtnY0t4cTQ5NTBLUFF1ZDJLYUtaUjFJYlAz?=
 =?utf-8?B?WXhobUE0YS9QblZZZXU0THExN1JlODMzbXZjY2I5aHozNTFmcTZrSEd5NDlD?=
 =?utf-8?B?T0pGcG9Mc2NUb2ZGVklsSkxkZDg4OTM4SDRoTG9oNld5RkRSYURqQWVSV21E?=
 =?utf-8?B?SGU5R2JqN01wZEU1NGlqano5Mjk5dkRPSTVHc29mTE1pZFB5THFPZEJ1eS9Q?=
 =?utf-8?B?STd6SnQzNUZHbUVMYWNLWmUzODljbVNzd2FxVkRRK3NSbEhkVVpSVjFBa2dM?=
 =?utf-8?B?c2VndTBjUUs2bGJ0a2UvSy80RWxGZEZUcHpqZy91VjdrUkZwSDExdEppQVcv?=
 =?utf-8?B?Y1l3ZlArZ01QdXRnQ01xRlVaU0lGeE1VSW9uaG52UXRWdDR1SlZrODZhVFhr?=
 =?utf-8?B?ZHZkV0lSeHJPSHVhRElzdTN0OWwrSU8rSFBWN3c3VkIrRFp3VHdyNlk0cHdi?=
 =?utf-8?B?QzZWQ3k0NDlIK0tWSFJJTmpLNHRyMzFhczZsZUtIQjJYS0FMMlVnL1d3bVRo?=
 =?utf-8?B?b2JKckJDMWkwaGk2Sk1NMUFwc0NLeFVKR2FVNFRaWGlVeFdCVkJDSkxQc1Bh?=
 =?utf-8?B?YTUxVVlJdXVWd1V5UUUyN0VLdFlIR2VQRzQzWFVJVXZ4ZEl5N0x0UnA0K2pk?=
 =?utf-8?B?QzFiWXplNWhuNjVmK25qc3UzUDdWV3BDUVBCVDJxcWNsTVNJZDhxT21zQTFr?=
 =?utf-8?B?d1JHck5rc3AwZVJKeEI0TldTcGEyYVNMNm1FeU1HazllVG53d01ydW5zNGx4?=
 =?utf-8?B?OTQ0U2FpVFVIVm9jVkpDYkdCeFJOcDkxNUp1NnFuWG4rRW5ReUVoai9QUFJQ?=
 =?utf-8?B?WUluQVBIWTM5MmZkUnc0ZzRLVk1FbVFQZy9GdUtCRGRIU0xQa2Z2ZFNzL0gz?=
 =?utf-8?B?NGNMS0hyK3VqbWNJbWdQRWtGRGhEbkpxOW1iaXREUDBxeVZ6ZkJUSUdZbXlZ?=
 =?utf-8?B?WHpEd0J6aVhjRUcwMm5mMkgvazZTVDdPUUxJaXJjUHhOUmZWNGE5UG1VTEE5?=
 =?utf-8?B?NDFxVU9tNWhweEZCYnhJdmtVRjFGclpHRi9ianZXdkRMeDI4Z29TR3RpOXFU?=
 =?utf-8?B?dmhpWkVMY2lXUTBmREsvaXhWVDMzNTZhWUQxUGZJN2E2OE9CYllxSFNycTZQ?=
 =?utf-8?B?TENTUEJZZUg5TWhvUmJvRHd0MEROWTNpaTlQS0tCQkI3dWJpUEoxWDFGY29s?=
 =?utf-8?B?NitJbVdSMUt5WUMvVWJqYUNUMWtVRzdNdjM5Wi9FYXhJZHYzZTB4TkxrL3lW?=
 =?utf-8?B?VUgzRWphSnl1TlV3cS95NWdXZVJUbnNOS256amVYbWU3TXp6Ti9Hd3V3dWpm?=
 =?utf-8?B?ZTJqWHpBK2VwWXpZNzBtYVBjUG9IQjFSRDZjaWF1cW1yRGtsN3pNZXc1NFNx?=
 =?utf-8?B?cVRYaWNXYU5uMnVWU0VlNk5jUjQ1WGg3OTl3T1h0S1BhRmpqUlZwUVpmWDZO?=
 =?utf-8?B?clV3Zm8xMUZsNWlIdmRzZi9GcVRQTE9BLzBzamh4dHJoWllPOUx4OTBZU0M0?=
 =?utf-8?B?VGVobHRyV1JneWtydnpqZEhIeHRtRXM2clRXQzloSmFudk4zM2s3NEpWdEdj?=
 =?utf-8?B?OHFNc2xaZTBxRE56d08yNzVQUnRLMTFuT1M4Qm4xdnMwSnd4WFgzQVYxMmdY?=
 =?utf-8?B?c3NFVHppUFFZWGU0RTFOOVk2TVNCc09neUJTdEkwajV2NWpOTVVXQitQVktE?=
 =?utf-8?Q?Bv+qI1bt9E6GrwA1Bb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9068f2c-1a46-4b28-4ed6-08deb585fa39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:06:56.8218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUwmUTCMMLmyUJtJzn0+xJxz7jIgfdQYMGAGDM7Xeuvp//OkMFxb3nlQhzakaVIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

On 5/19/26 10:22, Timur Kristóf wrote:
> UVD 4.x and older can only access FB and MSG buffers from a
> specific 256M VRAM segment that the VCPU BO is also located in.
> We already modify all placements of the given BO to ensure
> the BO is placed within this segment.
> 
> Previously, amdgpu_uvd_force_into_uvd_segment() always assumed
> that the UVD segment is the first 256M of VRAM, even though
> under some conditions the VCPU BO could be allocated outside
> this segment, which made UVD non-functional as the BOs were
> not inside the same segment as the UVD VCPU BO.
> 
> Solve that by using the segment where the VCPU BO actually is.
> 
> This fixes an issue with UVD failing to initialize on SI/CIK
> when resizable BAR is enabled and the VCPU BO is allocated
> in a different segment.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 +++++++++++++++----------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 1e59ca924abe..993957927782 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -550,16 +550,29 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  	}
>  }
>  
> +/**
> + * amdgpu_uvd_force_into_uvd_segment() - Forces placement of a BO into the UVD segment
> + *
> + * @abo: buffer object whose placement is forced
> + *
> + * UVD 4.x and older can only access FB and MSG buffers from a specific 256M VRAM segment
> + * that the VCPU BO is also located in. Force the BO into that segment.
> + */
>  static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
>  {
> -	int i;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct amdgpu_bo *vcpu_bo = adev->uvd.inst[0].vcpu_bo;
> +	struct amdgpu_res_cursor vcpu_cur;
>  
> -	for (i = 0; i < abo->placement.num_placement; ++i) {
> -		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
> -		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
> -		if (abo->placements[i].mem_type == TTM_PL_VRAM)
> -			abo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> -	}
> +	amdgpu_res_first(vcpu_bo->tbo.resource, 0, amdgpu_bo_size(vcpu_bo), &vcpu_cur);
> +
> +	abo->placement.num_placement = 1;
> +	abo->placements[0].fpfn = ALIGN_DOWN(vcpu_cur.start, SZ_256M) >> PAGE_SHIFT;
> +	abo->placements[0].lpfn = abo->placements[0].fpfn + (SZ_256M >> PAGE_SHIFT);
> +	abo->placements[0].mem_type = adev->uvd.inst[0].vcpu_bo->tbo.resource->mem_type;

This should clearly be applied to all placements, it's just that VRAM should use the vcpu segment and GTT the first one.

> +
> +	if (abo->placements[0].mem_type == TTM_PL_VRAM)
> +		abo->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
>  }
>  
>  static u64 amdgpu_uvd_get_addr_from_ctx(struct amdgpu_uvd_cs_ctx *ctx)
> @@ -600,13 +613,8 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
>  	if (!ctx->parser->adev->uvd.address_64_bit) {
>  		/* check if it's a message or feedback command */
>  		cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
> -		if (cmd == 0x0 || cmd == 0x3) {
> -			/* yes, force it into VRAM */
> -			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
> -
> -			amdgpu_bo_placement_from_domain(bo, domain);
> -		}
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> +		if (cmd == 0x0 || cmd == 0x3)
> +			amdgpu_uvd_force_into_uvd_segment(bo);

The existing code was already correct. We just messed up the GTT handling by not having the correct check in the manager and not supporting GTT->GTT moves.

Regards,
Christian.

>  
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
>  	}

