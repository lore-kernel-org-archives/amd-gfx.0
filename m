Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05448FCD0C8
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F1010E6A7;
	Wed, 18 Mar 2026 07:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0vpuiny";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8CC10E6A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPCX1YExcKskVsLXSu2DjetkOBnW4qDKkSm58o7EDWkv0TyDD0/b32McoirN0XpoDlE3LE5l7YY7w/JEz2tI0PytXBmYx1zW8TPNUK16YM7FieTCTzIIWCEf91heh/P1QzMij6q5V325EH76a6boMiYCGkjCD80vhKYi4wDK1Ih4jSyJA+i5GESZ3MdcqF4mrQY7bJFyEhqnOzo9FUrm3LTWT6aT/DYGIzBLwYaXltU8rWepTVP/knJp49JY7JegoCIMq6ID6MM3KUh4O/d+pliZZK7s2zdVVYIOQuklqQKQ0t5kETjl+bw2av8VJED3vXyz3D3ECo8QYrHFSNr8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9cTjwSBjhHNi5jX9YwX5Aa9PpLtcgfZZLUm5ppV44w=;
 b=IsT/zH6TcppLLjzlO7IwZEU0O+wxA7WeVkVtFV04tt56yMrvfzpLhxBLQphe5INGg5PfD/IxmDwsZfUvhbS2FhX39uCC+hs6GnubNvTSRsUU6LHg3t6RdP7IZgbEMVuszZHX7YG9Ps+qKkOAlN0xU902YzD8bAYBc+WTP3RladTGi7Cu3UXboorBwN2EJYd0q3DaD3RvaIjaPyu8Gb79Cq9Sx2VIGmPLNCm355Dtp9mwGuVj4Lq8EvlYkUGUgpbcehvBQJz3kVG6Oh7nBow+5YDqwV4hsKiZ7JuCuib8BXxxYHcB0QqgDNC1rmD8wVpduWHLLrFjgUzi8gID5PamCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9cTjwSBjhHNi5jX9YwX5Aa9PpLtcgfZZLUm5ppV44w=;
 b=H0vpuinyDMpM3LUJNh1UXbfdeRcbPSP+/pZhzn0Ivyd5cgJ0TU4GAoa42tzlmHjMSJ6ke7g33tDdGKaTXuZTExSL4LsBoNucC7JkXZdPrd32w6mUWpBIWhc73/v6JF856RAAxur32BIYy0xDbbI6P8Cntozle6B12tvnk5PzpM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:37:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:37:26 +0000
Message-ID: <8b4d0a73-159f-4434-b78b-6c086637ac5e@amd.com>
Date: Wed, 18 Mar 2026 08:37:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20260317185801.149610-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317185801.149610-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 182933e7-a5a5-4b95-ee35-08de84c133af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: XesD5y3ZWY/oqGFP/07pI1/3vgKBgFjSybkrRG5U64jZy9rlxewMXk+5HS7C5+TuNhr+WR9G4zi2wX4R8lkWwgugxQFOD/P+HHFfM5P82JjO3qHWobRIkF5p0QbcIzsjrYYhMqls3M4WTyPPJFiPxYENl4SdTV59RHF5T5xFqHB0OuJMWtyalb7yBayxVmktq6Phc3dGOuYEda34slIkuy4M94wXSPz5NTQzgylp5LfhK8Lh3e7QC6UEvCZ2Ms/xuYlzyNJvb6Auucfb6xVOqOu+KFsU+cXRwdHXMLlaMtEc8jVVtRWokxe0GjsXG6tA9OVhvWtrkXaaRk0UFf2qcEkl/CkAyWngXgnA+zw5+KYXZ7d2e60xyXjevONU7wKULl27FXAG5MNKvU4fUhtAru3wBF0sAzK3dTzkqH/c8An0VdJkKXtaRU6lM8OT/pTBh8mteSn83GvVYETmxBNOZXGVL3n4KB/qhpFyQwZcNaBLUV4bV22+Cozekd/Nfk/u85FCbRz7zGJr4o1Kda3m2ONEnP4P13nj9g8IZG/LTR239MS2iW7TqabBnpODqED2uQYSZ9Now6KtGNgjbIFVkoVwm9yWBM3UKmktf0YvJCS2xUlK28TTmwZrVw8VTqcCujzDMiBEHHd3iins44iMTgG7vfWqHbOTPJE+0tXQjXfAbwTfQuwpNmRhrErZXg24eHG/fkzqr9+E4YzWOwT9gUPqKTdUzwlDILlOHs1uL1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFiWHpTRU80U28wQUlJakZCYjY0OVZFTkcvS2VSYndVb3oyNm1QMlNsN3d1?=
 =?utf-8?B?S3JwRnpxRlRDQStYZXk5dE1mQjgxVzkrbTluVys0c2JNWlVyeW9EQVZxNmtx?=
 =?utf-8?B?bk85VEdBVlA0T3dTcktNWjNoQ0pSUGVJY3hTdEphV29MSWY1YjllRExqUXVZ?=
 =?utf-8?B?YXdaRVgxTXpFWEQ3VFVPUFNnMDJOd013MVpibWhZLzd1dHJ2d1VWSkc2eWg0?=
 =?utf-8?B?c00rSEljM005YVVIZUtWUk56QWpIVWJodDVHQzc3R0ZuSUx1MmtET0h2Z0JE?=
 =?utf-8?B?cjErdmhoWTVNYkV6aEQ2alFkWDNsbzhqYjRaSGdvSzBOVHo4bitOSkEwLzhW?=
 =?utf-8?B?eVdFcTFTQjlGWDZ3YzJzNnU5NWl2elphQVVCdkNUM2MxUjBwK2FjZUV0L3pv?=
 =?utf-8?B?emRhOG9CZ1BvbUtZb3BKdUJsMzJzbjVOaW9zNy9jRUZFaUJLekNxajN1dWRI?=
 =?utf-8?B?cjBMYnppaSsvS0xLTy9DV1JGNHp0a1FnOG1Ma2R4TTZBYmFvS2liQS9ZVlZQ?=
 =?utf-8?B?OWZUSnc4Smp1Sy9BVTVHcjdLVzF4TElnc0lldGh4SSt6NWRFVlNXMXpjZWZq?=
 =?utf-8?B?NEZqUUIzR3lRSWJreHdIa1NiM0JFSXpDcW5yTmZDeVN0Yy9weGRzallLU09C?=
 =?utf-8?B?VEVOUmloRENZLzljZ2xRc2p6NjAyemx0SjFNRWZLQTk0Um15WnNYUW9jTzVQ?=
 =?utf-8?B?REhIZnc4R2Z2cGtwZ3hZdEhteGUyY0JQTUpKRndEWEMxMW5Oa0lNb0haT3BG?=
 =?utf-8?B?UnZVYjJYYUpGK1lmbzh1d3laVUFrMmFxU0tLL25VTEI2VkhEODJPVXRnYzB6?=
 =?utf-8?B?ajN3WTZkS1ZlMG5LcU4zcjdjeHBNTCtkV0RlbFFocmxHbjFjWmFsdE1xTllN?=
 =?utf-8?B?RTlpKzdhQ01XMXdiMDN1dzdMbUphSzZ4SDRSRVlBSEYzT2NQY2VGL2lmdWV0?=
 =?utf-8?B?L3B3MHRhMC9yVllUeVJFRzk0TGxUYldvZk5UMTZ0NGdSQStZUUExNElTR1JP?=
 =?utf-8?B?RUxxTW9UWTk1RmVPSWdOejFVL3BraTZ1Z25yNTMwNUIyOXJ2VTVCS0xjWEZt?=
 =?utf-8?B?YVZ6aGM4UENubjhXZkZNUzZUSU80WXljTzB6VE85bHlpVGlnTFFBV2ZHTDlS?=
 =?utf-8?B?bER3eDN1T2RGUms2dnFlRzRRMkxNODVTUEYyVVJBQzFKblFFcVMvK1FOZmtU?=
 =?utf-8?B?alkrVFp1MWI1KzNVYUFkdWU2RTdyUEgvVitEOTdYcXM4QitPRGN4Q1pYRkJU?=
 =?utf-8?B?dFRkQmxwbk5sNlBGTVpMdFdLK3hOOHVYK1FOTU1CNmk1cEJ2d3R0WjFkbzV4?=
 =?utf-8?B?TC9PRVdDY2g2b0hBeElwVkZBNU1lRW9aaE8wcnh0TDZnSGRJS1lPdk45Qlpa?=
 =?utf-8?B?NFlpQ084M0M5WXJEQVl1ZjZjL20vYkxXY0U2TFJqUzE0ckZTNUhORHhUSllC?=
 =?utf-8?B?Q1NiSWFuZ1RRN2M1RWNkeW1WR1Z4VC9wd2VaL3ZUZFpiZWNwb2VLcGsxbnJJ?=
 =?utf-8?B?OTQrbDFRc2hQSlRJcldlc0Y2STBFd1BBT1VCYW1JYnBpRHRLd2V6TldCdU5a?=
 =?utf-8?B?N1Z6RVR1dHI5NDhkSGRweHM3RE5Oa3hqWGlWNm9LbWRaQlJKREFSc0FBS2M5?=
 =?utf-8?B?S2FIeTNFazRSU1MweGNCL1FHeUI0VWY4TmR0cEF4TzgyTlVORk9BRFhhYlA4?=
 =?utf-8?B?YWU1WFB4KzY4a01wc1pDQzg1SnU5a1grNUZuNHM3clBHbnRtV3lTVlpKVm9h?=
 =?utf-8?B?Q1Z5UnJhc3FFNHpIREFpNG85MjloSnZNQkgrUGwzTEN0R2NCVGkwcURIcFVL?=
 =?utf-8?B?SHZzWmdiRGVydW55ZnZVMkkvb0psNlZjVTJBeFd6elBTMEFLTE9EeU00S0tZ?=
 =?utf-8?B?ODRCSGxIczB3M3ZXNmlkMVBDVy8rVXFUWm9DZ1FxOE5Qb3FNM0NKSEhvRXd2?=
 =?utf-8?B?QzNIOW1CZjJhUDcwZzh0M09UdjFmR2RyZDNhMjZNN21EQ3ZQZU9KZ0RXU1By?=
 =?utf-8?B?V0J5WTRvWi9aeW1GaGtFd1lOSmU4TzhZN2FQOXk3azg0UzErUTFZc3dxZTJv?=
 =?utf-8?B?b01aMWtreDJ4SklOUElkeVdCeG5HbUZ6c1ZjRzhrSzh6NEpNV0dGRjVra3dq?=
 =?utf-8?B?Y0FMb0ZsMnNmeUt2VmVJdmxoclN1SnY1eG9CeXdjelhXSlZGSWVQWG43WXAz?=
 =?utf-8?B?WkVBamZxeGZubmYxb1JlYVdNZHpJZVV4V2lDSXJsLytUTkFYZnRjOTFaa1hZ?=
 =?utf-8?B?MEJNMUNlMTROUlR1bnpkU0psaG9RTkxFSWJFV1I2ZnNpWnk5eGtPZ0dFb1lh?=
 =?utf-8?Q?EuLpb1DcaNmAQX5WEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182933e7-a5a5-4b95-ee35-08de84c133af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:37:26.7029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEP3l6LctSfK1RZgA6hiMaYd4N5IWgPsmACAhkRnot3jXQDoEGG4ZQq+mBZHGBjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

On 3/17/26 19:58, Eric Huang wrote:
> PASID resue could cause cache, TLBs and interrupt issues
> when process immediately runs into hw states left by previous
> process exited with the same PASID, to prevent the case, it
> uses the same allocator as kernel pid's.

The implementation looks good now, but that is still not a good justification for the change.

What potential HW state do we have which could cause problems here?

Regards,
Christian.

> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
>  3 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cab36322c16..0801c023f5a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -35,10 +35,13 @@
>   * PASIDs are global address space identifiers that can be shared
>   * between the GPU, an IOMMU and the driver. VMs on different devices
>   * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using a global IDA. VMs are
> - * looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using IDR cyclic allocator
> + * (similar to kernel PID allocation) which naturally delays reuse.
> + * VMs are looked up from the PASID per amdgpu_device.
>   */
> -static DEFINE_IDA(amdgpu_pasid_ida);
> +
> +static DEFINE_IDR(amdgpu_pasid_idr);
> +static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
>  
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
> @@ -50,8 +53,8 @@ struct amdgpu_pasid_cb {
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
>   *
> - * Allocates a PASID of the given width while keeping smaller PASIDs
> - * available if possible.
> + * Uses kernel's IDR cyclic allocator (same as PID allocation).
> + * Allocates sequentially with automatic wrap-around.
>   *
>   * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -59,14 +62,15 @@ struct amdgpu_pasid_cb {
>   */
>  int amdgpu_pasid_alloc(unsigned int bits)
>  {
> -	int pasid = -EINVAL;
> +	int pasid;
>  
> -	for (bits = min(bits, 31U); bits > 0; bits--) {
> -		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
> -					(1U << bits) - 1, GFP_KERNEL);
> -		if (pasid != -ENOSPC)
> -			break;
> -	}
> +	if (bits == 0)
> +		return -EINVAL;
> +
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> +			         1U << bits, GFP_KERNEL);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
>  
>  	if (pasid >= 0)
>  		trace_amdgpu_pasid_allocated(pasid);
> @@ -81,7 +85,10 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
> -	ida_free(&amdgpu_pasid_ida, pasid);
> +
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	idr_remove(&amdgpu_pasid_idr, pasid);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -616,3 +623,15 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>  		}
>  	}
>  }
> +
> +/**
> + * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> + *
> + * Cleanup the IDR allocator.
> + */
> +void amdgpu_pasid_mgr_cleanup(void)
> +{
> +	spin_lock(&amdgpu_pasid_idr_lock);
> +	idr_destroy(&amdgpu_pasid_idr);
> +	spin_unlock(&amdgpu_pasid_idr_lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index b3649cd3af56..a57919478d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -74,6 +74,7 @@ int amdgpu_pasid_alloc(unsigned int bits);
>  void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  			       u32 pasid);
> +void amdgpu_pasid_mgr_cleanup(void);
>  
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..5b9bdb79efcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2864,6 +2864,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  	xa_destroy(&adev->vm_manager.pasids);
>  
>  	amdgpu_vmid_mgr_fini(adev);
> +	amdgpu_pasid_mgr_cleanup();
>  }
>  
>  /**

