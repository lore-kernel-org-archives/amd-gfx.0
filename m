Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04279CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8846710ECD3;
	Thu, 28 May 2026 07:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEaZXthy";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C9D10ECD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 07:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdvjIux0j2XDX/fZZ/ho1P7gET2TOAccu8I4/qq1VZ6KbBSHjCQU/+lyQ8KDAwgilrEUQyVqPoEwrvSaX0R6cMacoQmBZn7mhIZJQyBqf7OryuzsxGswIka8y7C5Cj4MWazr91z9huvOLAxBNS2sKGhrJYEPpS+et7nLCisOWkDLFAifFnapeRdBalQY5aDCC2+kI7P7cbunhSqiCOCIsyHgwQk3yeJWiQpETBn9oOU6ot+YNpqrXD5r5iSWpTCkWALocZQfsojb65Emd+BV1+hzxFyRIpbfMh2YaGJsCL5NKkGT9MZtMUHfVcHHI71nVQ4ncz05JfD8DnuiJ3W+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbWcL+GMeYhH0ga9yKPbrrIGqpze6HBtgOiJp8AVpPY=;
 b=ykrTloC6PVKTHYM4mfXJrVW22A8KZL0SSxbUj3WyIUQVlNHZqhiEKpF6Wi2DFRt8THtzv8JBIbswtwVMxH5kKORNsVlXBC0dZrnHoKeCzCIaw8z3ZiO56b4LS41UMtmpvKLivFhhjzLwayN7wOgpOq8RhwK97tStyXbeJiQ5VqaLKo2b6jO9WJZ2DgR7vYW5YLWgwqMZsvvA6cCOW6o5lAngnas54dsgeqsCRSoxWxVOV02Azu8IABD+MOsVREik6jQK6Yt7LyZ3PAy0jiXwOYIgqE88QhRNQFBSZXhAb12SzrJYVgyQci4tVI+qhJPzktCH/BiJ8au1f8AeQv1R1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbWcL+GMeYhH0ga9yKPbrrIGqpze6HBtgOiJp8AVpPY=;
 b=ZEaZXthyrezqTGGHt7E3gp1enM6DGA6d2jzIUpwhJGZ+xgvUxrb0nv2QLU2IY2Sq+4nA4YEujro3EsPTFukiqXpIEnIdyuUYx++HqyfPRqkN3YsMJ7Vnk2cxDbexvXAKJApyRA/8tYayvVoviI4uQlj6A5R4L+E9hGAa3lOHW1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 07:04:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:04:10 +0000
Message-ID: <a23d40b2-8ae5-42f0-a0b9-a76875b13614@amd.com>
Date: Thu, 28 May 2026 09:04:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260527162918.9585-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527162918.9585-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: cda56c98-eee1-42fc-dc46-08debc875136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 21hqCEDQ/NGH2eIEdRBpqjmXMfTA9UM330kXBm2/tC3Sd46bjSqb6r/Ag24bXY0gQ0QynwDROBIeFcdPineI6aBqnkJDEtNoRhDZXQEh4fNvaws8r/ex5yyqXR3zLCv+M3vtNU2cO4/q4oCJsg+jhBq/r4O8WcXFFMvK7GnbcrusC/ghSWVQHpLPuFdS1zupURpmVjEMekR3p0CByV7UHNUNSa8bmijwBsfPWO44BJ/VEPeg5IRbXy366gpWW+ONtPU+2Ag+m3DgR+YZzpOGd/cVLJtwZXV8Aa3uiaQQhlum6OmGFqVxas3EuV6G8uoo8z9HGXyBFCIQJK4yd3mUjor+dh2E+5mAQhDruMh1Z69t7qzbrYvZROtnwIrWzibw6174U+nMgSTZSudi1dZQ07Pl8TiyzsiJBNz8nQl4unChsuObZefWA8WfGPs8g8Smytw4tByZCRtz6FLNS18LvsxTrbDu/KjkeFQ6DI9B/gX8zKGI+gFXxD3chLWtMMpniBmyr9xEVEK4dRPAw6lw+Ujyh9KwaTqXPNXeLmBrMaYMtUfYrAdbz2g9BOP6IJ4mr8DiYsBqFVbfdady/lc8Yy8Y63Rb76wGSIidxFvjXShEErQJFdsTB6IAHYK4SgVSWbQpB2m7poK1PpEad4cZ5DbNrWhXHJ9zGcSUQEyKs6TUbFZt/jrbSvUAJ5MYVnCl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWg5b0lCMkxqY2JCRVZsL3Y0dGJEcWhkOURBRzBMZkliaW8rTDNJY3h0ZWdP?=
 =?utf-8?B?anF4OWJqNVdXVWorQ2FQYUFneEFNN3h0MStIVDhwSWFnQVZoWitZQmpDeVY0?=
 =?utf-8?B?NGNoclUvSUN3RWJTenROMUVDRzZmMG91cjBSaS81RlZPVTVRNW1BaHdsd3Ji?=
 =?utf-8?B?ZUY3Zlg0cjFnQXpTZ3hLdDhkZWRsQUJCL09tS1Q5TWZMZk5rc1Rqbk5hOWwr?=
 =?utf-8?B?RGpKOGJUN0dzTGdaRFhsNGxvQXZhZEJubHhDc1FFb245cG5LOVNCb1VvQWd4?=
 =?utf-8?B?SE9iaU9IOXVXejBkb0VnSzBVOEQ4U0hJeHVZRWRjNnUzekF6L0Y4ck92MXNB?=
 =?utf-8?B?Z1d5VU5YdVVZb0NvbXBqZGdYSERPQTI2REFiWjhwSVNjS2pNdW96b0tHN3VS?=
 =?utf-8?B?NUVlWlMyY3RIS1RvUTVxeUUrWVpydENXZURjWXNPbUk4RVRDenh4cTRQUGxL?=
 =?utf-8?B?QnpzRkNmT2FCK0Q5L1VDRHlOOWJ0VEhBSHFPUmhVckhWb0hKR3ZxbFdwOVd6?=
 =?utf-8?B?dEdIcElrSFo2TUJmb2tWRkx2cHptVjh4ZVNXYzFmdlVPUUFaUjNYdlR4MnNT?=
 =?utf-8?B?bUR3SUcwaDR6WTVML1ZGVVN4clBReTNlbDNsV1VoMVQ0amsyZHo5SE4wbm5Q?=
 =?utf-8?B?RFJPUTdwdUJuZjVJeUJlSVpna0FJNUhtWitaZ3ZNYVlQeE1Dc2JlZDNSaHZv?=
 =?utf-8?B?Y3NvUjYyaTZoaTNod3dXQjI5ZEpkM24wa3B5SGY5VzdVenl4cXpEakxOK3c0?=
 =?utf-8?B?Zk14RytpTjBpNy8yUnBrSHhnM2pmNTgxRGlWVjJ0YWxQZENra2ptYndwTnly?=
 =?utf-8?B?VkFZYmh6aHBKMUpKdFc3WkxxbURqZGV0RHA5SjBqRjhvTVgyNnpVR3I4THdS?=
 =?utf-8?B?eDdtb2ZhMnc5VDl3WlRBaGt6aFgrNU5YdjZPSlprRElOTTFiMGE5MHVKaHVX?=
 =?utf-8?B?dUIzQmYrM3JQNmRmUHJuSFc5YWJ0ckFSWkhyOFo1dVhlamRKa1ZCcGR3Y2Nh?=
 =?utf-8?B?alZsMkpPOU1KUUNaVVpwR0FrNS8vMWROM1hYak1jeGlqdTkrSWxNQ0JkK0VB?=
 =?utf-8?B?UnIyMEJKa0Z2YnVRNnd3YUdoZEgrYThCbWZFTDJhdjRMa1N6eTdySHhEdFJF?=
 =?utf-8?B?UmQ5NGNFT1poNmJCREtvZlRuRC9nWTRkQmRjQi9QRlpWUlU3d1BGdHJqNjlS?=
 =?utf-8?B?Tkd1TFAxazRRSGxSVlhwdm9zeGlNendFcUdBY2QxRVdmVG1aQkJNMW5hdUI1?=
 =?utf-8?B?UGZ6T0xtUEVqQkMxSlVkUURPcXhZKzB3VXozNm5QOS9nUUw5eDVhMEtWZDBs?=
 =?utf-8?B?TzlSS2FkdUtGNTVBdFVLblQvaTZQSHlOOCtNZkJUUDV1RkpnTExpOUtjSW1N?=
 =?utf-8?B?SW1xcmt5SStJRmhJRlBSbm1jZzROMCtYdnl3V1ZrZ25uNWNvaUVyNDk1QXFL?=
 =?utf-8?B?eTc4UzBBL1owWElCTU52OXJMSlRwbUhFMW9ra2FzaW10MHo0Y3AxT2FzZm01?=
 =?utf-8?B?bmlSdmRqVzU3S2x5b3piTGs1YWQzajNCeUZHWkN5Rnp1V1g3RjNUSitNbEh0?=
 =?utf-8?B?aE1kWUEzWGJGUzRZRDBwZWJUblA5ZlJJcVMySm1jYXY0b0t6VFNDMWFpcUNJ?=
 =?utf-8?B?QU9tOEFwNjRIVnVLRTJxZzZqcHI5c0NLbFFsSVc3ektibUZZMy9vUzA2ZXRY?=
 =?utf-8?B?bnl6RDY2RFdWNkI3QncwY09hYTgwU2xTODFpODhnS3luRXFSQ2p2ak8wSGNy?=
 =?utf-8?B?Ui9PRVlITzJYcVk4dzRPV2xSVGNWYXRHVkhFMG4va2poMUowVUE0S081SHg5?=
 =?utf-8?B?RVlod2hyL3p1S2NhZXJDZHpUejBMbElJL2hHS1p2dDFVbDliYnN5bDV6ak03?=
 =?utf-8?B?cW1pTDBvOURla1F4YUVMVVNRQWZXSGhybUpPeVFRRzBmalBGZXp1SkN3b0Vi?=
 =?utf-8?B?Y1IwdjVHaHRjNVlkNVk0c2lwYktYTkg2aTZaZFhOTjYrbitzMVRMelg4c1pa?=
 =?utf-8?B?SXFpSG9ySkx5TkdsZFFHcTlCc3ZSR1JWZUdEVnh0UkxESEIrVE9IUFAyUnRz?=
 =?utf-8?B?ZFpjVFpIOUJ5ZU1OVE1rZ1BFQkVxZDVWSVRHKzF1RW1ORTMxZkp2RDFkWm1Z?=
 =?utf-8?B?bmZzMWl1dEhSZkdMY1o1M01GeUFtTDlyT0FMTE5HZmdzalA2MERYczV6Tldh?=
 =?utf-8?B?MkM4dXJuUTZVcHZEdEJMRWlvUSsyTnBtNE5FdlNSS0lDb3lsSjZTdHVVTWNV?=
 =?utf-8?B?NWRBTFZpUUFHYXBMWW9qNS9hNnFjUlh0WWVMMkl4WFlOcTEzMjZ6dXVkUG1N?=
 =?utf-8?Q?PpjRdzA0wy3QSJdf9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda56c98-eee1-42fc-dc46-08debc875136
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:04:10.3594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZumw4J64VjD4ORWh7lHGwazwSTIWJynHXTUp0ClhiYuWMTbZe2Z8ZzSqsMfA0dq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

On 5/27/26 18:29, Natalie Vock wrote:
> The "moved" VM state is a bit unfortunately named, because BOs can end
> up in this state without being physically moved. While we need to
> invalidate every mapping when BOs are physically moved, in some other
> cases like PRT binds/unbinds there is no need to refresh mappings except
> those affected by the bind.
> 
> Full invalidation of all BO mappings manifested as severe regressions in
> PRT bind performance, which this patch fixes. The offending patch is
> 53f0235c0284 ("drm/amdgpu: restructure VM state machine v4") in the
> amd-staging-drm-next tree, although it has not yet propagated anywhere
> else.

Thanks a lot for nailing this down, but that was actually one of the bugs I was trying to fix with this.

> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index beaf0aef6f474..969716b3e67e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -214,11 +214,13 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   * amdgpu_vm_bo_moved - vm_bo is moved
>   *
>   * @vm_bo: vm_bo which is moved
> + * @moved: true if the BO physically changed locations, i.e. all previous
> + *         mappings are invalid
>   *
>   * State for vm_bo objects meaning the underlying BO was moved but the new
>   * location not yet reflected in the page tables.
>   */
> -static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool moved)

Just move setting the moved flag out of this function.

>  {
>  	struct amdgpu_vm_bo_status *lists;
>  	struct amdgpu_bo *bo = vm_bo->bo;
> @@ -232,7 +234,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  		vm_bo->moved = false;
>  		list_move(&vm_bo->vm_status, &lists->idle);
>  	} else {
> -		vm_bo->moved = true;amdgpu_vm_validate
> +		if (moved)
> +			vm_bo->moved = true;
>  		list_move(&vm_bo->vm_status, &lists->moved);
>  	}
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
> @@ -425,7 +428,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  	 */
>  	if (bo->preferred_domains &
>  	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		amdgpu_vm_bo_moved(base);
> +		amdgpu_vm_bo_moved(base, true);
>  	else
>  		amdgpu_vm_bo_evicted(base);
>  }
> @@ -597,7 +600,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			return r;
>  
>  		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> -		amdgpu_vm_bo_moved(bo_base);
> +		amdgpu_vm_bo_moved(bo_base, false);

That one and all other in amdgpu_vm_validate() look questionable to me.

When the buffer was validated (e.g. physically moved) the flag should already be set, but setting it again should be harmless in most cases.

>  	}
>  
>  	/*
> @@ -614,7 +617,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		amdgpu_vm_bo_moved(bo_base);
> +		amdgpu_vm_bo_moved(bo_base, false);
>  	}
>  
>  	if (!ticket)
> @@ -634,7 +637,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		amdgpu_vm_bo_moved(bo_base);
> +		amdgpu_vm_bo_moved(bo_base, false);
>  
>  		/* It's a bit inefficient to always jump back to the start, but
>  		 * we would need to re-structure the KFD for properly fixing
> @@ -1782,7 +1785,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  		amdgpu_vm_prt_get(adev);
>  
>  	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> -		amdgpu_vm_bo_moved(&bo_va->base);
> +		amdgpu_vm_bo_moved(&bo_va->base, false);

This is probably the one which really kills you.

Thanks,
Christian.

>  
>  	trace_amdgpu_vm_bo_map(bo_va, mapping);
>  }
> @@ -2091,7 +2094,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>  		    !before->bo_va->base.moved)
> -			amdgpu_vm_bo_moved(&before->bo_va->base);
> +			amdgpu_vm_bo_moved(&before->bo_va->base, false);
>  	} else {
>  		kfree(before);
>  	}
> @@ -2106,7 +2109,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>  		    !after->bo_va->base.moved)
> -			amdgpu_vm_bo_moved(&after->bo_va->base);
> +			amdgpu_vm_bo_moved(&after->bo_va->base, false);
>  	} else {
>  		kfree(after);
>  	}
> @@ -2280,7 +2283,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>  
>  		if (bo_base->moved)
>  			continue;
> -		amdgpu_vm_bo_moved(bo_base);
> +		amdgpu_vm_bo_moved(bo_base, true);
>  	}
>  }
>  

