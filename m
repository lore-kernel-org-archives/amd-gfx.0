Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE84CD6E41
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 08:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F81110E077;
	Wed, 27 May 2026 08:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZaAjpyo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6195E10E753
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 08:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIIrjOdEWxrPSE8nGnyXyqo/kBr/rJHNZTz3XJIKdI85KjW7ukinRRCFj2i/9m8g60yUdO8G7fZJ3PuFDLuFxI3a2WGuEf62tB8biMfbm16VA30yXQz1XNlMuC03NpK6V4a5UIkZrJlnWjA/UIPOg2A5j7GU9+2C1r5sASyZgH9aCAUPV5H/g3Th83lf6fWDuRT5I4TiObGBO7ZD7d+V4jwQw/TGbuwbbXF4N6ax2gc2YGpUCfWYqXiOu6EYdNEzx7qnpyfhBDduxifKDmeJWaOKv/cFyvuR4pCImaEfJgnxx+n2qZJLem30nHzrhgxVJKHtLbMEYZYL3JgewQvZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo6sDKjAh6q48IyF8BBtWERojU09Y5UGx743VzNXwGk=;
 b=I48bebYCKpuqHBf8aAPfZW73aaaVFQR+ReDNGRNLEMbQrHu1yrW3Rn0Ouu4CPIGTcoHM1pvGmqdfQraqXIIWee+fDK0D9L3rJGifh70y9Edm/ScewrV5VTpdVRW4rNoyCHVlIa8xD/Cw8O9cBEqUyBpqwchsr4MRGrd8JpUexE9lWwErnfz4VIuPAkgU4NtXfNL1ABXKVWR0oNMCZoNzB+PqNJ3Y++YOFXuMiQs+024T8OwMGtLoXE+lNHkKgNtJRVYzDmNEXv02nZVg8cN4D/mGZDv6ZceVgE9/vXxuUu24rGxMMnixB2jsOifkAoWEPDCXkpD9woKQUyVHaKQXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo6sDKjAh6q48IyF8BBtWERojU09Y5UGx743VzNXwGk=;
 b=FZaAjpyoZwMWgG8Y1M8fiQmZkPCeHShS7EXvLz+wTlQddf9NUnIAoCo1OgxrgpRgxOIwsdMVardWCmzf8VhCa1AfDhpjm0KUB1cO8ZLhuQ25Ssjclrp6O830BX787fsRJSLAadebsTNvlQKiMD//bpQp+T0hC7yfpxPkrBzod0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 08:10:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:10:28 +0000
Message-ID: <50260781-195a-4f77-bd83-9209268a4e2d@amd.com>
Date: Wed, 27 May 2026 10:10:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] drm/amdgpu: Extend listing of buffer handles with the
 userptr object flag
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526160630.35562-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0560.namprd03.prod.outlook.com
 (2603:10b6:408:138::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db173ae-c10d-4fd5-d1a4-08debbc769b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|10063799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: WIH6QDFS/Dmk8AHDkyHB/bf9KAo5aGhfJajvIG+Pc0ZY/XW6VY/8qHs3izVMbI8j15PAFqrgxTQOC6a58sEqcqmRI6pl83wHVed72O2ZsfMHFoZnmFhWuoFgFGOMYXLO3u5ALI9/ndbkKlXlsplgsuI6LT2BCY6oEkU29vhH1lzDFSWVWaeQW4Q7arw4FGkT5LMocqrqOhS4Rl2nvhDRp5Ql4yKW4K3TgRonyhoQfjwXQEIhfShrezsqdOcryyG4Dpatw2xTfB3BGjoMmG+cMxlVJfGpoh2FczQDITzY8zcgpF70DnCenGsfMlmnkQPz9ARUmRkAd/bzxvloGBVDYxoQxPKp11YWDz0b4bnMWIjhbu28Mkeos/q4fl3EOoABi3v0fRoqprkfXJjuXXePfx1MOX+WPUqBbPEd4vtLZAElsJO1N++87lfTrsyMg5tXcjihlf1vncp5/38HDZfoKYYomABYxfBdaFGZqBkf9DUMZdi6Dhl6cy9DjSUld0uj4aEBEcLm5FLOhy5azXOCtc0RB/2hBp6yt5PD2PEMaw4ppLGXvSgIKwixx7gIymnf+MV7o5fFf9EbTSUvyTcvnqu5ml8Jm4gFwkYxep90ibm4LAOnka7NQ4xhz6c0KNC6X0CRltyQhJUcpgeNKN7VirhIAVRzJlCyPpmUZNiwXpGQYjpXE1cGPEsHBBhFKLy2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(10063799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0x3OXQ5d21PMXFTNnNFLzdlcTVIZTRIM09JYU4zUmlEWFhqL2F6YzMrdEhY?=
 =?utf-8?B?NXpYRWp6V2VkM2Y5L0RlcGpiYW1OQmxnNUplMWFnZGVheW9KbWYzOVhMV3Bz?=
 =?utf-8?B?ZWpPV0RHcURXY0h2TXJjQ05teU42Sm5CY0JrWjd0dnRMNXNZVXh1NmZ6b1Qx?=
 =?utf-8?B?QmhhN3VsaHJVaHZsNVVvWXNuajNPYjlGNlpndC8yQ0NVNFk2QWNYK0FjR2pK?=
 =?utf-8?B?aUYxcSs5Z0RXdmwzWWtaSlNXbjlOU0RoQThwcXk1Mm91L00zTWRTSlk5WjU0?=
 =?utf-8?B?RnlFdEhwRkcxRUE5bEF6cVhoRGRHUHI0b3Z0QlZBUE04L2VpdVZEQUVrcE5l?=
 =?utf-8?B?NWh1enNieC9aOEVZRzFlTHFSaUh4aFFzb1JVbk5Ib2JvdWY1VHMreGJkb0tD?=
 =?utf-8?B?QUdYbmMraTZxNDRTZnMvanpYTDhKbzVKbERCdXRMQlhvYzYvYlc1dXd1cDZm?=
 =?utf-8?B?bkFsUlYzU1RERkp4ZHEvTDF6TGV2YjJubHYwbXNBVVZKMTFPRGJRdHR3Tno5?=
 =?utf-8?B?cTdlODRpa3EvZkRZaUZDeTNPNzVKa1ZsYm9qZlppK05LUUliSjJqSldBZnB6?=
 =?utf-8?B?SWJYWU1mS3hBaXliMHBlc3l4Q0VubndyazZMa2tnTGNTdTM2N01oQ2lWVFBI?=
 =?utf-8?B?ejlPZ0NnMWMzTkRMNG41OUNqRlN3REdXVHdRQWRzdFZlcjdaY0NkaWpNSkFX?=
 =?utf-8?B?UUt2ZlZMbVlzb3NaekJGbm56K3ZsM05IcU5MSXpEQXBlbUdWbW9NVktTbk05?=
 =?utf-8?B?bVNNZ2xIQVlYRkpVQXFmcEttc2xWRUZ2MlpaTmpBZnV6SWcvYnRpL0JJWUV0?=
 =?utf-8?B?NzBORmFtQUVhcXlrZUNuWVhiNmpZTDNQS20zOEowbkhiQm5NVWJiMDFucXFs?=
 =?utf-8?B?QnBDSUhpd3FDck1tYjVvWTBLanBOYjd2Y2czRUFzaC9vM3orZXp2TmhQNkRI?=
 =?utf-8?B?YnJLTm44elRsUkZ4Vjg2RlhJL3UzMVZaV3JKQTZHa3NIU0JaYkZ2enUvVWtv?=
 =?utf-8?B?MEkwZkdNSmtjNm4yWVZpa1NGQkczdm5WdWdBb3lyYmQ1RDhldlV6bWJkWUdv?=
 =?utf-8?B?UmhzTlFIUjE5VDNVVW9yN2t1VFZwMisxLytQb0pUTzJyMTRUd1dVc25ZKytN?=
 =?utf-8?B?WG9pWGEyOHJlSUorU0s1VXBvaFBJbFhZT1E3OXFSNW00dTJ6ZWo5OFJuV2ti?=
 =?utf-8?B?Q3M2V1RPMXRpcGtoNTIrZUQrNklUcThGczZlVlhERStxbjdtTmVWWUd3dzlk?=
 =?utf-8?B?Z00zb0NZUlRXbWxUWENUVHFmdlJrdzNvSE0xcGp6Z3FRL3NMUVRsVHI2cGF5?=
 =?utf-8?B?ZWlUMnkwNzlZbEUyV3A0VFNTdy94THhkejdPT3I0dkg3K0dYSWphYmxlSVRj?=
 =?utf-8?B?WURWNngydFBZRTQzU3QwM0sxeitsdU5ub3Q3eVBhZktGN1dDd3NvQnl4dlZN?=
 =?utf-8?B?eTlaaEh0YUhQOEIySjBYQmVXbmdybWhzUWZxL0FGRVp0SVdjUmpyK3ZTakpi?=
 =?utf-8?B?TGhTeWpvVmJmcXRjOTJ4Nmw4V0lHdWRHMXFEc2FLQkM2bTNtaDQzN2l3a0Rk?=
 =?utf-8?B?QnNJWExucThsL0J6elU1TTAxVnVHY3A5TjlCeEZSYkxoTXV0TnAzY29RODRK?=
 =?utf-8?B?cDJDNnViNjdNeWFzNlIzdUl0Qjk0QzJFM0E1ZmhMSWVHenJyUi9lVEJFWkxl?=
 =?utf-8?B?ZjlZL1RlQk1WdGIvcUMvVkNRbEkxTDNKUisyZjlGL3hQakRtNUx4N1VCa2NB?=
 =?utf-8?B?dkgxVExiUEwyVkc4c0psZDVyQTNDc1FKbkFaVWkxMjhTcHE2ckRZNWZiZGhB?=
 =?utf-8?B?akpRcVQzRjNTMXJEVkZuaGNtM0xCN1cyQllsT3hwTkcwOG5VUlhOdWFrSXdX?=
 =?utf-8?B?Z0hlbktia3Qrald3WXhidDBqQlZKMnEvNHd4NS84SWI1V1lZNzFoa0thNkJu?=
 =?utf-8?B?ZXVGQ3N5KytiUDJXaERNRTZ6b09SWS9uMEN3dzdlVy9NenhnSG9TZE5wUGRv?=
 =?utf-8?B?azFaaVRwMjhqeEorZ2R1WW5ZRmZJT2VYeng3UXpFT2VPRXBEUStzTHFiTDVk?=
 =?utf-8?B?VnhJcEVWZWtUK091Y0FoVExmU0xiQlg2RCsxbi81SVY4TkF5MlRHTWRzVWM0?=
 =?utf-8?B?OTNNU2gzOWxTZTdGbzZweTMySEVudTIycGlSQ0RRTEU3T1ZGbFR5UXhUT1Vt?=
 =?utf-8?B?S0NHU01VRDVLTUJCU0ZZcU5QeGNLWFdEZThsRlQ2TGhuT01jMnE4WWx2ckVZ?=
 =?utf-8?B?aGtkaWp5TnROMHQ1NFBkd0pmejFhSGJxWFF4dU9rYlo5bWdOVml1NUJQZFBl?=
 =?utf-8?Q?YF6usz4UVWPc9/RHV2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db173ae-c10d-4fd5-d1a4-08debbc769b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:10:28.0559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PgbX5AOAh4K52PuHp6JaKO4a2vsPW8BRevz+oYeL55wP6McCHfhB8NAWWkj+zIU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

On 5/26/26 18:06, Tvrtko Ursulin wrote:
> Add a new flag (AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR) to the
> DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS ioctl.
> 
> This is required to allow for checkpoint and restore of userptr objects.
> 
> The existing struct drm_amdgpu_gem_list_handles_entry is used with the
> userptr creation flags places in alloc_flags, while the alignment field
> contains the userspace address.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 18 +++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 40 +++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 19 +++++++++++-
>  include/uapi/drm/amdgpu_drm.h           |  7 +++--
>  4 files changed, 61 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0259d81e5157..5eb8433229b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1186,14 +1186,20 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  
>  		bo_entry = &bo_entries[bo_index];
>  
> -		bo_entry->size = amdgpu_bo_size(bo);
> -		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> -		bo_entry->preferred_domains = bo->preferred_domains;
>  		bo_entry->gem_handle = id;
> -		bo_entry->alignment = bo->tbo.page_alignment;
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
> +			bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR;
> +			bo_entry->alloc_flags = amdgpu_ttm_tt_get_userptr_flags(bo->tbo.ttm);
> +			bo_entry->alignment = amdgpu_ttm_tt_get_userptr_addr(bo->tbo.ttm);
> +		} else {
> +			bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> +			bo_entry->preferred_domains = bo->preferred_domains;
> +			bo_entry->alignment = bo->tbo.page_alignment;
>  
> -		if (bo->tbo.base.import_attach)
> -			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +			if (bo->tbo.base.import_attach)
> +				bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +		}
>  
>  		bo_index += 1;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d2e00efc741..4023c84fe29d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -767,6 +767,33 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  	return r;
>  }
>  
> +/*
> + * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
> + */
> +bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
> +{
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> +
> +	if (gtt == NULL || !gtt->userptr)
> +		return false;
> +
> +	return true;
> +}
> +
> +u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm)
> +{
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> +
> +	return gtt->userflags;
> +}
> +
> +u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm)
> +{
> +	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> +
> +	return gtt->userptr;
> +}
> +
>  #endif
>  
>  /*
> @@ -1374,19 +1401,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>  	return true;
>  }
>  
> -/*
> - * amdgpu_ttm_tt_is_userptr - Have the pages backing by userptr?
> - */
> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
> -{
> -	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> -
> -	if (gtt == NULL || !gtt->userptr)
> -		return false;
> -
> -	return true;
> -}
> -
>  /*
>   * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index f2f23a42b3cc..8c0424577dea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -211,12 +211,30 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct amdgpu_hmm_range *range);
> +bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
> +u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm);
> +u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  					       struct amdgpu_hmm_range *range)
>  {
>  	return -EPERM;
>  }
> +
> +static inline bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
> +{
> +	return false;
> +}
> +
> +static inline u32 amdgpu_ttm_tt_get_userptr_flags(struct ttm_tt *ttm)
> +{
> +	return -1;
> +}
> +
> +static inline u64 amdgpu_ttm_tt_get_userptr_addr(struct ttm_tt *ttm)
> +{
> +	return 0;
> +}
>  #endif
>  
>  /**
> @@ -251,7 +269,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>  				  unsigned long end, unsigned long *userptr);
>  bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>  				       int *last_invalidated);
> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>  bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>  uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>  uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..3069560ac26e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -836,6 +836,7 @@ struct drm_amdgpu_gem_op {
>  };
>  
>  #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR	(1 << 1)
>  
>  struct drm_amdgpu_gem_list_handles {
>  	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> @@ -851,7 +852,7 @@ struct drm_amdgpu_gem_list_handles_entry {
>  	/* gem handle of buffer object */
>  	__u32 gem_handle;
>  
> -	/* Currently just one flag: IS_IMPORT */
> +	/* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
>  	__u32 flags;
>  
>  	/* Size of bo */
> @@ -860,10 +861,10 @@ struct drm_amdgpu_gem_list_handles_entry {
>  	/* Preferred domains for GEM_CREATE */
>  	__u64 preferred_domains;
>  
> -	/* GEM_CREATE flags for re-creation of buffer */
> +	/* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
>  	__u64 alloc_flags;
>  
> -	/* physical start_addr alignment in bytes for some HW requirements */
> +	/* physical start_addr alignment in bytes for some HW requirements or drm_amdgpu_gem_userptr.addr */
>  	__u64 alignment;

Make that an union, e.g. union { __u64 alignment; __u64 userptr; }, apart looks pretty good to me.

Regards,
Christian.

>  };
>  

