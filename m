Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F696107526E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9662810E8C4;
	Thu, 19 Mar 2026 07:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SkG9Bn4w";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5433210E8C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2mUQ3fTUMDmwxog4TW8rtjxc2yp2SC8X/NQHhoVylsT7irRaz1Rko+ctYM+lbkJJFJap0G2YcjVNqRpqYKCkHpwmTQDguIByOH9dtdGb96Q6u9jnenJbgtJd5WPc6u4eaGzOx4MF+EEI5USZMUvKljwyNYPcpvf35tkV+YE2t300T30vEyC839vHCfbJa+I4Uy/Gam30l40QGzJntCCovR+FjgIuVvgnsw8ifUd9+Hb3Gc55Ck8cWWGs8jYgfCdUTfz5lQZsLkUcqYwL0jN2SCil/TERw/l0oC4nrKnj9ewvQ9x4T6ndmf+ngkQKDVNZvMUjOEh3/oq0BvzG41ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV1U0853d7PBwT33EuL+HU0r+tjTWFB/ntLk7+uGB28=;
 b=vxv8qW68uphjkuYVcBJ9I8bfz2k2pZO8PKFAs12dnRr1yE91kCZ0TVji+ZBY8nnFuvCQwFCTyxIrE8CkWp9zbC7sUqnWl40oqReQ3x3SQstCiTcpAPgwe9hry7LRcbhuMhNZCHEY5gjafCNM3nY902LEODmxbrZlDnWrT9M13wP/87OeEE8C1OsPT1t120Ja4WB7II18p6PbEMu07wX7NBk2J7916G2GwEBNqPkM0DZHulwgAK+Nf8/nWnRSHncr0C+RyPnAYiSYU/ZepWC9V5wE8rn6zpR3J49qhaP/ZsgK4C+E+LS2ekAJ/asxG+QSZOes8zLR11+ejOlTEfeb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV1U0853d7PBwT33EuL+HU0r+tjTWFB/ntLk7+uGB28=;
 b=SkG9Bn4wMJNFtef8Tzed5zs7qMALxelZ1W5fF9lkagEd4uFRxo0R0Cn2fNQuq2zSw/h3lTu+1egEjpC4KqT4Ga4A8hgd9+RfHeBIiKlUA/we7fmWyywDOMUBtPQ1Ie7j9GpB527ffLLKN0QKSnyXKgddTWbhLCpuaufWQSj007I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:23:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:23:07 +0000
Message-ID: <84526990-a5f3-4456-b964-f81e42416ef4@amd.com>
Date: Thu, 19 Mar 2026 08:23:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20260318150814.48340-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318150814.48340-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 295477fe-d39e-4904-0e72-08de85885e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5lgnThmwQZujjXvirid1bLYgEC6fy2C21cZo4LWM9osvkXbeV3RiNUcQKdiIXcYRkU+Ohu8DD/ebsyQm9B1Qth1ZRcRB3JRMrENHc0ffQI20Bf/9ODlvb7iWrm3ph5AeCqItaFIFiJYw4wDyFqS0YnyolAFS/ToSEIcOl6vYP6DoV8P2yzER1iXUQnOQEcqyeb63PMMj1P7cmTVGcbR//kulm0iO+2PvctNwYEBDZKF2POjfyP3P4/npk3RF5oU8pNPaZXDEa2A836gpXQw2pEBYptX2C1Q21cmOmtdFU9nHwfdfnBMEpYfToJ85OE1d2e7s4W+iwxRrMH/Im2r3i6GhKoy+evxnZlVlIDld25uaDtiX7DzMQds96+CvSLLIiRnR1qUVHIO28gOw69REZhRhIPPyu4XzeP7pBD7Cyc9lgp8OXzSkqV1rFKwQS9STJpkXzWC+lt8Afj3U9V372TT+KB76px2AyHmDtgCvS9GJ7boAly9HufgverKj56+bOf6ZskREdZq4cQ/P/zhSwZsbxOyylKyw3UPWagxhZ3Iw7EoCI9gKU/A48TG0fRyVdYUUEnb+E6qLitR0N3IsN3gn2dJiZ8vTmBvzsEFKLf7zKgHW0X9/lNzysM7/DWgqkLTYvIJNi08FZPfromFWgL1EjQE5n381P2pakoj7x2Z3HV5J3aumnrAhGiKcC4YWO2abrsS4XYJ+pVRu5iQkRFhEQfryQzGTYKgRtkNCTuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTZidExUN1IvYUdFaklEUDNGcC9TYys4WkxCRmcveS84czVFc25sblU1UnNt?=
 =?utf-8?B?K2xmMW9wa0JWVm0yUHFvZzR2TDJwdndJSFJVcjF0dUkyOFJwRlplSnpiNGE4?=
 =?utf-8?B?VS9OZmFsRUxBdEVkdVN2dVg1WkFQNnR1eE9kN0tEeVhmY3RHZUNnQzFEZ0ha?=
 =?utf-8?B?aUJBWDdiMVZlWkFqeVRTR0pTYnNUeDgwYjhZZklVUVhtaUdiSUlzYXA1Sm1N?=
 =?utf-8?B?NnB6YU9VamxBQWljVUpOU0xyYjM3aG4vK29Gc0RNcEJUTDNnQVFrbFhZeVJ3?=
 =?utf-8?B?WXBscWpvVGZsOW92U0Z0dmxsQjcyRXZHTXcyOXM1SFczcmVGZHMvcGswSjhU?=
 =?utf-8?B?ZHhOZVdham84azd5bmdBYlZhQms2V0xNVjZLb00zT09zUU53T2ZZRUM5cy9y?=
 =?utf-8?B?YnFYTkM3MXNFNlZhZndRUFNnaUp2RStiU1BYa0lwdWl3VW5Md21JeVd0b2hk?=
 =?utf-8?B?dUpSK2I0M2k5SU41cVlZNEdHS2FXS1ZlalpEdzU4TFgzSHROMWppWUpERVNx?=
 =?utf-8?B?V1BMYXZDbWNDUFhKTlRscCtuL3VwZHR2eEEvVGt4ektPN0NDUEE3ZlYxTHk4?=
 =?utf-8?B?Y3VMSHJQR2JvMWpuTlJLVTVlS29JV1BvWlp5dFVvK0ZNYjRoZTV4bWpaRUlO?=
 =?utf-8?B?VGozRmV2dDJ5V09Oa1NVOVZTK0E4bFE5Nm9UUjB1VDZNbjFjMnBVSHpWanAx?=
 =?utf-8?B?OEcybVVOdjcwMjdIemcrOUtVd0taMUU4N1Z5dW5CUnlCU2FyUTFOK0N4eVFC?=
 =?utf-8?B?dTVxNkFMT1dlVFpENFRHQ1NyMnZrOU9SOW1mNDZMREJheW9LOVhxMUpEb3Jy?=
 =?utf-8?B?a2FjTFJXRHRQTnJhNTFjUFROMVJGSVY1SzM4SjliSVo2eXhLbzVua2ptak44?=
 =?utf-8?B?Z0Z2ZlhnUWQ5K2R0dzVJdEwvWnppaU1iaVRtOEtyUjRldlpSQ3dCdnc3YkVY?=
 =?utf-8?B?YnRlUUU5NlJEVW1SYVNqay8rNVd3M3hnSk8wSjFUdXA4VkNtNGNXb2FtY3Nx?=
 =?utf-8?B?MXlManFiRUpselQxUFI4VisyalpRcHhpSlI4RERidHdQeXp4eldvaFFhemZn?=
 =?utf-8?B?LzVBeGN3bVhhWGxPR1B6S2wybjQwVk5qSmFXVHFvVWMxdnoyT21nUFVKakl5?=
 =?utf-8?B?QkkrQ0RVWGJyM0RIcFA4VkdpZWFsTlprQUtFMmZXaGI4YlI5cEM5aDJ1NzZI?=
 =?utf-8?B?SWJOR3Z6cU1MWVhzeGlTVEdMbEUrT3NyTDM4K2l4NWppdVpJZ0wyckNJVjJt?=
 =?utf-8?B?dnBRSjV0WHYweGxENzU4NGNITU16TDZYZXI3YWlhQTRjQm5OYWcwQjdkdkFI?=
 =?utf-8?B?N0lXNXJmUXpjR2pVOGNXbm92T1FPNWRCNGhpcXlDUm5iUndlZUlQN1huWThS?=
 =?utf-8?B?bnZ2NzlZbHNOb2ovYlA0U2tDdjVVVDRkd3ZadUp2WTl6S2l4N0gvc1I2aVoz?=
 =?utf-8?B?Sk1hY0I2M0U1dFl1TVJJZ1dEZkVEVkZsNVdCaVh0WCtVY2FVQndEZGUrRVRm?=
 =?utf-8?B?cFJNWHRUNTJTREh2SURaNzJ6Yk9EUUQycWNQdXRBQ0EyVWxCT0ozcThtWTF0?=
 =?utf-8?B?OE1EZ3BOci9mZEhxR2JYQmxMN21xRGpaSUdMMW5HeSt4VWxwa2wwOFNXRlIx?=
 =?utf-8?B?cGtsdmMwZSszOThsRStnSGxoNEdnR1puR1dnamllYlZHa1RXaThxMlpXZGgr?=
 =?utf-8?B?dWo2cWFNcFpOdzNkM2l2NUFsZlpzM1BIbGQxU1pFSVRCNVAvNmFDRWVsWTFZ?=
 =?utf-8?B?VmFZeXMvTjZJRmFETXIvQ3VadXRTL3dWY2o3K2ZFUWQwci9hZmlVY0JVcGFP?=
 =?utf-8?B?SmpGV1A5VjhvTkhFVjcrNDF2a2dWOGFLaWpuY2VzZERLdktPNzNZWm15a0g0?=
 =?utf-8?B?cFViNmU2WG5iR0ozdWYyOXZVUkdLalBnbmxyWUxUSXZJVXkrK3kyUUxlQitM?=
 =?utf-8?B?SzhzcGtzMjFjMXhueFJBSHpUWUpQOC9Rd25YaTRkelpEeW9MdEMrR1hBMEVH?=
 =?utf-8?B?S1BVMEVwcnpOS0s5L1F0MHRIc2czRnpyVDVSNTB0S1U0Um1JUGV1SXUrdmZZ?=
 =?utf-8?B?bVhwUVF5UVA0SDhYSTZOTnRiVzZXbE9FaFk1ZTQ4Y3lxbFl2aWhWQmQ2QTBW?=
 =?utf-8?B?ZUtrRVE2eHhxQzJxSFFwd3ZFc25OUENuUjFYdFYyTmcvODk3d1dOMGRYMlE3?=
 =?utf-8?B?U0ZEek9KWUthL3FSZUNLbkdCL1ptRmp1YTJyRWdxRWkxTGJidVBZSHQ0UERN?=
 =?utf-8?B?Wmd1VmZIa2lRaVZVNFJzeUdqN1hOSXIxejI3dUh1THRmVE5MS3FueFk3MDN5?=
 =?utf-8?Q?kLA3f2Qj65GgZApV/7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295477fe-d39e-4904-0e72-08de85885e1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:23:07.6713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UenN7sjv9JiOWhVW/TAqmzTOgFndidWBAIx/+0mssc14OdTPFigZDEVmoPChOEjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

On 3/18/26 16:08, Eric Huang wrote:
> PASID resue could cause interrupt issue when process
> immediately runs into hw state left by previous
> process exited with the same PASID, it's possible that
> page faults are still pending in the IH ring buffer when
> the process exits and frees up its PASID. To prevent the
> case, it uses idr cyclic allocator same as kernel pid's.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

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

