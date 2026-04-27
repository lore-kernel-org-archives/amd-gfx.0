Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD8FFF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF5810E63A;
	Mon, 27 Apr 2026 08:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aY5rIGRF";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38C210E639
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXglZDOpJuuk6wDlC+NPhhEfReI56KKQyrD+mE5F+5PCELs+CWw89zWdzTi2AdTh/EqQtCpJynaSRmAu5WXpYM4YcXE6eObZ4IkbZmXgdp/LFjlB3QRLFy+O6Ws+v5PbqdYdeG0oMhZD4v5IWFFw4oYSo/MTZzYwJ/dMRy2BD6czJKrdjCm6BfkAeQUxwYVzSqEQpR3D0JjEfD7VtYBajrcu45ARhxzPXvUucKobORJpzuGmonlqJn3JA3u/RQLTSTIvr61UGVik5b+bDG2c7a5UvDHLXyFDy2fvv8Q/tVmX2fU2PR9/VLt+PY3MVFLspJcgD05AXtLRmKNSoj7znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldYyoQGIjYwiGFGNSkuB6Ul23MUlQ4ThiASZqiwNEn4=;
 b=ejb9baFUIsf2kY18Wvvh5K/4ayDqAm7VSrrYAcKcnXXJG0Bctjw2X8fXRnER3FscLge9PzfEPhGqEGFBV/9Nkx7RRYWDmBfp3WBvEOGFVzOnPlhBl8sgK62wgsHQxtHnc4fd6gnmP/dYrEDJYZ0hd5b0EIQEIYTTOMwEmX4iBr1bzfW+295KTFcOzz6EPx2o+P2P22cvFpBTR1TNDEPSfN9decLFNatcYVnfGWZ2QEbNsbdIC0uMfuIahUxlwJt4O2ZuHrKpLSdOQOe1EuqB5V3W0z2Bz4403ALaSXoqaVsF/7jv9RlHweQWTyHGFly2Ydt1NNfA+pveBpSHwmY3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldYyoQGIjYwiGFGNSkuB6Ul23MUlQ4ThiASZqiwNEn4=;
 b=aY5rIGRF11ESkNvJKXSaDCdHGqV/pBSlvXzahjxqRaTI0BejbtRdxBUWdP8BXw3A4hDyeWHcTK+/xhlwHUD7y0nS/cahn78VUiij57bdbAvl31IMdxtt6qV4++ZKOjWwNZ1Lw8aRXodkxvo3042HlUd50vOqs63IcihQUISn+z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:39:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 08:39:44 +0000
Message-ID: <0d55bb5b-a860-48cf-b415-e7b5d001fb9c@amd.com>
Date: Mon, 27 Apr 2026 10:39:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] drm/amdgpu/gem: only enforce amdgpu_bo access
 checks on amdgpu_bo objects
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
 <20260427083543.1328533-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260427083543.1328533-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4985b4b0-091b-4cb6-2e75-08dea438885a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PdukKQYHAjYiNbAXoPkslDbfTZdlluvJ91I73ozdcgOdha8lWpmcz87wFKdMSrOkyIBIkllzw7u5f+A65BJg6bAxZ2b3qGKtvavEtA8PK2Uj33DnhLKUEFLFTw7YLUuckYzRiAZgzpoYLMSZeQ3Pg6tH0rHYv6CA2T0SrDFD/5FweX4UZMyx+BmAyycI0ZsfKbRA3QxYonsFwqi1S0c7SeZUCkgxs5Vc4Xv1CeH1mMzY64c0ISGNeQEkp9e57m7eNkWS+VI5wUXqFDGbAIZ5oAr8sQ6p7FxV4eTPnxWHvLFcHpgOAsvA1W/8tWRLkTYov+DbYi8pnCEXkw1DwjLHVkpV4kuUrdzhAmLtzcxFxJo8jI+HmfslfbT8ASbZUFOkojMHJP4PqjYmyIK+fjiAM7Y0Gs2FclTlnaD+Z6yMyY/GbxRD8rbA6N/orG8Qq0rqz/c8gxev5t3aD9CeqWBQfqSN4vDXhO8/+iV8r8/QunJJ3qrxbQcGNMGHIo9g/g+i+1oZRjxUE1N6PwmwwwyVdrOynINSxTLUv/cRm2xc1lg5r9hnwy7NGVU9qVvenoXid8SmjIVaxIpHQpEtyz0VpmdxJNIct7nGGBkGOMN+I6IwAt58CUGkpxIYF4CqlU9f4l7jC9xFlVl04Stku4o8N0ADWWOylTy3/z82lKurZz4SWpecrJt2SvB+uTC0+h54h+lGGmCcVTbylKpQn+btmxk0dlWURpti0kOvl7TvH9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDk1dk1mQVpHWVdkL1JTbk5QMlpYUURGQ0FQZUhpNmNPUnE4c2JRZkhkbkI3?=
 =?utf-8?B?R3RIZCtTMXhJbUhtR2YyWFJ5VDYrcWZ1ZDlTZUZBbDRGL0JVTTIySkxxWnVs?=
 =?utf-8?B?YTgvV244RGNHSk4zKy94V3ZYUnpPemovVlk3TGM0THRNN0xZQVhxRHRxa3Z3?=
 =?utf-8?B?RDgzMHB6aGRKVE84M0MvZlZDOWJQNHlmSWtqclRBQjdGUW4rSFBHMnM2MDhh?=
 =?utf-8?B?QlVRQ2F5TFg5aXhrZjN0NkF0RzFubitoaEtnMCs2Q1pDWE9wQmJiWTVpUEN0?=
 =?utf-8?B?RGJ4S2xjbEpFQkxncFBIb21nUGtvdDFRNFY4YU5QQnhucTdIVi9qWFVSUTIy?=
 =?utf-8?B?aW1VTklhRHU4My9QSzRVQlgyRUNKUUJ6WG93Tm5EK1p5MUFLZ0ROblhVUG9E?=
 =?utf-8?B?ZXNCNjMrM3I5d043RGVVaFpWNkFKdzFXVHdsaXRyZFVGZSt1aVVNenV4aVNp?=
 =?utf-8?B?OWc1eFhrZUtJdTgvdk03T3o1a2Zvak1xSkxrbTYxSlJRdERWN0RSdE9EZm5n?=
 =?utf-8?B?NDdtMDg3UUFWcFRHb0Q5RXNIN0NRd0R5L1V2VkJ3OWZBZVFEdGNtWEZZK1lZ?=
 =?utf-8?B?WHlsbnlzZzh6WFR2UTB4bWQxeC8wQ2VLS251Qi9SajZWL1I4dXFwNjlCNFBx?=
 =?utf-8?B?Zi9VT29kVW9XYXpyNHJNYTJOT2YwWjA2ajRHTHBBZGJNNUhyQ0FuTzhZN2wy?=
 =?utf-8?B?SnBJSVU0aUxOZS9JQlJ6MUFiTVBnY3BHdjRoUnFyY1VGVEh4ay94dWNUN214?=
 =?utf-8?B?emo5U0RNWU9aSTNTcks5bkpweVhhRmRYSkpuZ2hmMkdxVjl5MXp6NGE2L2dy?=
 =?utf-8?B?SkVlS0M2WGZRN2ZwVTVnRGlNYTFMRG92OFVJUHYzbkRCZjBGaXlhbHFmRGZy?=
 =?utf-8?B?YmRQWk5pbkkrNmhSQXEzNXRqMHoralVTbUR0SjlnV1FLRkp2OGNMODB4RWpz?=
 =?utf-8?B?R2tFc0M3dEc2SUxUSzZZRi9qSWMxOENLMkxhaTRleEtOVDl2cmtoRC82K2xp?=
 =?utf-8?B?eW4xVXAwTHUxRndIS3l0QUx1bWx1MzFxcFgwanFpMXN5L0xUSHI0ZDVIRzNo?=
 =?utf-8?B?MzZRQzBZVVZPbUQ4TFR5WkxEb2Q0eFJha0p2SFZVam5DZXA1cS96WitzOVRp?=
 =?utf-8?B?U3FtZlJnVDk1bUppTGZVejhRUENKeXg3QjFTSENyWmRDUlpaTkVQRnQ2aGRL?=
 =?utf-8?B?MTl3eUd5QkxycDh2TGo3eGlXUUVMK2UyU2p6eEN4NUFFMlJHSXdpQjRvYVNJ?=
 =?utf-8?B?TklDM2ZkTTdBOFBYcVVkNlhEYitMMjVkNlovRGxldEFxeGlMMjlHU3JSd2Zq?=
 =?utf-8?B?dDJpQlpGWVhHd0dpR0RjQUw0blVWREFHYzJpcUdFQytDcEJPd3doMVIvTTds?=
 =?utf-8?B?RzMyUHpMVlhBY2FydnVEL1IxT2Z3OFNWRXc5d1I3T3BVY0V0MDZJRXkyUkRt?=
 =?utf-8?B?cTNHVXVkWHpBTUV2ZkhBNmRmSUp1VEtRNmw4WTEwMFZIc1FjM2VqZUJIclc5?=
 =?utf-8?B?ME9jb3FRL0hqeWNTeU9jMnNPN3NsMmFMNkNUQWJrQ3ZoTFAxaFluNWdEM1lu?=
 =?utf-8?B?NXVoUUd1TXduU0w5MDhjNXpmakczWFpwVHYxVklSLzRIZXdqUy8ycTZza0FF?=
 =?utf-8?B?bkw0UzY3cEV3YUh6UERqVlA4bytxL0FxdmZFZjFVRWdPTUxJeUNkaDU1cmpN?=
 =?utf-8?B?bDhlYTZxNWx5cTZEYkpnemcxenRUdUpTLzE2RFpVak5PY1JaRlkzb0dXWFBP?=
 =?utf-8?B?RWZYbU1iMkVzMGVVRTBYOXBNZDkrWTFVRlJjOVlOZ3l6R2RXNGVKVjRoS0pN?=
 =?utf-8?B?TEs2QmVlMURvaG0zUlRWTlJ1RzlxVE1MdHpERGdMMVVxZjJQVFBlMWN5eXNW?=
 =?utf-8?B?clZwY3JWa3BOcGRsYkZKY0xsM2FPKzF3Y2RpT3pGMnlnOFN5MDFmaEVnVktt?=
 =?utf-8?B?UlNQTi90K3dZL1hTVFpkNU1CTnNqVXUyZGlsSUxpd1dBL05ZYWdPS2tyTWlH?=
 =?utf-8?B?ZXdyNVRtVXpiT0ZvVHBPR2plZUdSV2tOM1FSdGV5UUZ1dlpqNUFJYzVBbnhq?=
 =?utf-8?B?SFJjQ08vZmxqeml4dFhKckZSSjVyZ090ZWRVdUJrVGRoWHBsU014M09SMU1a?=
 =?utf-8?B?TGZISDB0UnFMS2J6MWhHOXBTaXBYOG9sdjZBVXNsU2NtaVJyWWNFMHBCczA3?=
 =?utf-8?B?aGx5emd6cnVLZkRkbjRIamkzSi9pUWIybERwWVpGTTE3RmRBWHZub3p3TUFK?=
 =?utf-8?B?WnhYNk5lTzIxUGlRb3RHRldEVHhyUytaT3c0RU8xRTV0MFdvU29EYjA4M0xq?=
 =?utf-8?Q?79wi4HqfMhhtFmRfdD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4985b4b0-091b-4cb6-2e75-08dea438885a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:39:44.7634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ckqmPzOU1V1h3HjIIpQwNaak4b/fHpRMyZva4pqVGV2gHeklCyYvxiE+4xFC10d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

On 4/27/26 10:34, Jesse Zhang wrote:
> From: "Jesse.zhang" <Jesse.zhang@amd.com>
> 
> amdgpu_mode_dumb_mmap() unconditionally cast every looked-up
> drm_gem_object to amdgpu_bo via gem_to_amdgpu_bo() and then read
> robj->tbo.ttm and robj->flags.  For a bare drm_gem_object created via
> drm_gem_private_object_init() with its own drm_gem_object_funcs (e.g.
> the SDMA UMQ doorbell pool BO),

Well big NAK to that approach.

Why in the world would we want to create a GEM object directly through drm_gem_private_object_init()?

Regards,
Christian.


> the cast yields a pointer to unrelated
> memory.  Whether that memory happens to look like a usermm or carry
> AMDGPU_GEM_CREATE_NO_CPU_ACCESS set is a function of allocator state,
> producing intermittent -EPERM returns from DRM_IOCTL_AMDGPU_GEM_MMAP.


> 
> Gate the amdgpu_bo-specific check on gobj->funcs matching
> amdgpu_gem_object_funcs, and resolve the mmap offset via the GEM
> vma_node directly so the path works for any drm_gem_object backed by
> this ioctl.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0071d6957828..ccb92088172c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -587,13 +587,22 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
>  	if (!gobj)
>  		return -ENOENT;
>  
> -	robj = gem_to_amdgpu_bo(gobj);
> -	if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
> -	    (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
> -		drm_gem_object_put(gobj);
> -		return -EPERM;
> +	/*
> +	 * The amdgpu_bo-specific access checks below assume gobj is wrapped
> +	 * in an amdgpu_bo. Bare drm_gem_object instances (e.g., the SDMA UMQ
> +	 * doorbell pool BO created via drm_gem_private_object_init with its
> +	 * own funcs) are not amdgpu_bo, so gem_to_amdgpu_bo would dereference
> +	 * unrelated memory and intermittently return -EPERM.
> +	 */
> +	if (gobj->funcs == &amdgpu_gem_object_funcs) {
> +		robj = gem_to_amdgpu_bo(gobj);
> +		if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
> +		    (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
> +			drm_gem_object_put(gobj);
> +			return -EPERM;
> +		}
>  	}
> -	*offset_p = amdgpu_bo_mmap_offset(robj);
> +	*offset_p = drm_vma_node_offset_addr(&gobj->vma_node);
>  	drm_gem_object_put(gobj);
>  	return 0;
>  }

