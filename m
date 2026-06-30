Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B47AC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA2810E1E7;
	Tue, 30 Jun 2026 12:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCLoUTwq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD08610E1E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 12:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENrY1ZMVFZDWaIEbgDCPxBi9tSV0jrrl0L/IK6IXbAfmvb4jzzCGhFn88/bi6B97WKJRQ5/Ux573i5C32RIfG4Kerq0OrSOVWJvvrd/rz43QmVDAz+smUh1oYN4fgIKJylCRtE31s3MzNLYwc/rWzUOZiGyfW9buEMHtuAfu2avzbtQT3wAiy+F+yh2lu/8djwQ9XqzzpBbyVaFXPImNTosQpuW5xy43jvxykmzjwFm1i4/Sm19VXRKgVY446g/7MCaPUIcXBrkRc7LHn9iFCr1XlE6CbbEFxGORXjCk452M28nrKfFl1zLMXuGDYzxvz991FhjsH8JVLiMQZIRwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asJLz0VIKclN0/4thRpaGerYAXfwZ3surpP/hbCsY4I=;
 b=FB1y7a54Xyu+j8Ov/32U1cG7tQAZVZol/rJu7NpQ6y8Nz5i8MEODdtCaOLd/pVYSlNK/VZmq4vv+/ztMivWf3Ygfa5BbrTVZzQ6UVQceXkPGH68hH9a+BS1MzOYUumjeY2wVqNO/6N9ZwGmhvPko2+nkG+jUQABoZGwQL3OP3s1suHsgesoFTRRRyhziDCFY0ysgwAN4buawi2I99K3yCfayAi/g7x/MkgfWWAgunXTva+sF2fQzYy80ox3Z9T252bKH5U4HebeT7Dn0ysJO9le3btYSoB/4MGOekzfMxrL0Pw5vn2ffoeKbHhnaB62Mz3F02CE/FWP7BqFcNELOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asJLz0VIKclN0/4thRpaGerYAXfwZ3surpP/hbCsY4I=;
 b=ZCLoUTwqkUQvXwuRhDQRs9V4c6hIAFpqRD+ZGcP0gAPZ/JhFIi9B8M0rM+jmrlAzZIOBIx4FO4K5zBerka2a7CfP2RdzVRis0xrb4LVkEpviDOTbYEX6mTkle3f6Zl8tSzTxDgM1lluKdAswpHFDVTgS7i6sOBqUKiQeHPYYO0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 12:50:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 12:50:50 +0000
Message-ID: <38cf3568-cdd6-46e6-960d-03c378cb0669@amd.com>
Date: Tue, 30 Jun 2026 14:50:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/4] drm/amdgpu: Extend listing of buffer handles with
 the userptr object flag
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
 <20260623141257.66086-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260623141257.66086-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:52d::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 5331eee1-88b3-48a4-b9ed-08ded6a63683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info: hOxTSF3M06XHjGS7tMu0TlbUsXsjAVytd6OEPw2IhDitb1ndZvbQQZQ3dCto9PII8gXGQTNCViMCpaitRbTT3Bkkj/GKtniM+I5FM7lz4xQQCxDC2/Emq0/T4YNUuiZmeh0sFDSprgU6x8yjitocDsiagKxKQy7ZYr41m0Qh0fD2kBTKfsqV1sRVhCtS0GesS6Qo1ImUFXUFERa/OVRb64RSRtHQfmsWeFxRkWBUYw76iSR9JV2ks2ukxKjREgBDS7QFk/DAL043bAwncZchNx4Bge/UtNLiqIwa9/DgnuxuTIruJvSvy68ueT1c0YpXa3UBWoIk+fuTYUdgswvonh2/GKuXQRUhYaE7AusLRlfG7iyeigqAauthxQXvBjJIrsuP6o4FRZO6/sc++SCVICLNa3Nh5eE1nLEvL9l+f+pALjJ3nK9LzMcw7nu348xPggajo/VLMq06/Z3tiyXmXz9ox2TdmHJSgyniPzVK5CJpq6qafx59gyVb8HaKh15x+ckj5U3pBaJ4QciLutHb+LNlSF6UYEVg0GSLtK/urf1Ira4aUR1n++rIL7AImT7AIUSNKk2iTJTthIc2VGCcjMxSmyS4JrHQO0u6E6e8mVES78GxueYj3I5LXglKwrf2wSsmsMfYuKNzAaMkK7l9LTfUC1TjTHuT2LUzEVkxSWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10063799003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnd6d0sxTjE4ZFRaejBFNGVmRDVtMk5hZFdSampPYm14R1JsRmZRTm1Rdk9E?=
 =?utf-8?B?Ky8vRE9oOW1VbnFJeVdCM1NHS3ZRUGd0bHJyaStrVFVab2RrSlZtNjh2MndK?=
 =?utf-8?B?TDdnd3FkRXVyM2RCMGVYc2RlWHRtaXRuMjBhQ3NXc2tEd0Nnc1lrLzNnVWk1?=
 =?utf-8?B?U2lDSFVxWWxFblZpNlBOZFZBOUxleTJBalRuTnpCUUY3UDBoRWxMY2R1a0M5?=
 =?utf-8?B?N2xIZzNkaG82L1pBN2tTWDNDM1JsMWZQZFhJVCtGeHRCUnQySVJqR2IyNjBZ?=
 =?utf-8?B?T0Q1Vkx1N0QzeCthMlRyVmlDc2c1UUhXajVmaG4weFh2UDV6bjU2NmRvWG9i?=
 =?utf-8?B?VGJzbzNwdUVSMWMxSmhDaEtGNUlrUURNKzJwdktzR2Q1MGJRMjNmNzJCYkt2?=
 =?utf-8?B?bWl2dzIvNkVLcSt1cExzNnZGSDVJcVoyQ3ZUcCtreTZHcW8rTkRKcVU3WHdi?=
 =?utf-8?B?aDYrNFQ3R294R01GTHdHK2VNSmpLc01tNmE4TGdsUkdDZWtoTUtzT1NhcjJ2?=
 =?utf-8?B?YUNNV1QrUTRkNEJkVGhiYmZMZnZTNXRUK3Q3bXFhcXQ3THFPcmUycXVQZVcx?=
 =?utf-8?B?d3c1TU0yNTRQK3d1T2dlYlc2M0ZGSFFtSHVQbzYzUy9UaXgzNUxwK09Bc3Bu?=
 =?utf-8?B?QythbDdTUWpRc01IZFBTeExxMGNHRTJxTmNITUZkeFhHd0dHNXUvcDE5dXBu?=
 =?utf-8?B?SUltc3kzd2t6eHd4WXNWYXR2V1F5NGFQRFhlbktPMTJwYzcrNzhhRnpJYmxq?=
 =?utf-8?B?MUVOM2hzZmpoalljc0ZoMFJ4S1dtc1VsUGtLeGcxcUxkMHRCR3lpNjdDSldZ?=
 =?utf-8?B?NzBLMWhZWTNCMTBXQzlWTW1wMmFKekllWGExRk8ya0NjQ2VyVnQ2VDRiRTdZ?=
 =?utf-8?B?MVlkSWJkampJc0pTcjFDQUMyTDJXakhEc1lrd3JEL2p1bERNWTZTekFrek5K?=
 =?utf-8?B?WkxiSGx5U2w5dUtsSDVaSWk3Z2hzTUxGMnJ4YnU4bUwvVlpocGJYaXBFL2dY?=
 =?utf-8?B?OERhUDNVS1E2cTdlUUpmYzFuSE4yZWNJRDkwSkw0UWNXL3ZaUUxubXZKUFk1?=
 =?utf-8?B?czJMM0gwUnVYRVduZEtzbjEweDk4c1pNN3h6VWNrUjdsNG8zTHpCalFoNWJs?=
 =?utf-8?B?RllYLzJIZmdWaE5vNU9lUTR3akgxYW9oWDgxNEo2RnYrTXp6ZGdrQTBWbTFs?=
 =?utf-8?B?bVd4RHU2N0xIL2RUR2czQXVDL3NvOFBRL2M2Z1FpOGpqQStUcGlTM0I0L1Iz?=
 =?utf-8?B?WEQ3eXJQSXQ3SFBDa0dOQWh4TUpBbnNaYnBFVGxoN09HTk90enMzOXZ6L3ZK?=
 =?utf-8?B?dWUvYXJxUktDSGRSZG45eEVJM0FFQ0lGM3JMZXNRWVFOcVhuUlBXM3AxM0ZQ?=
 =?utf-8?B?RW1IUS9vNHozZmlCbUpqM1ZaM0JMYnc3ZUdHemQxSWRybzF6TU5ZVWk5Vkpl?=
 =?utf-8?B?bEdFYlRyL09ORUg4NXozZkpPVURzbGJrYnRNNUJ2YmtqaEFGeXVUbGxuOUNl?=
 =?utf-8?B?M2gyTmtuMHdiUWJHeDd3YVg4VU9FV3RYWGdsQnhwNVg4dTJGV3FFUmRzdUFP?=
 =?utf-8?B?cVdpTzI3enVRYUV1RHJQelpuYmZnRkxtSkVqb3FtZm4rSzJBamFyUVZmQlpO?=
 =?utf-8?B?TVFMS1NPZGREcGhHNlBqeXlBRS9qUkU4R2JlYnhsZEhQZVRzT01lZWRSc3Ez?=
 =?utf-8?B?by9ndERpMWlJUWVjUGtRV05WTlRZVndzK3hCRkhOaDRWaTNrZU4rcE5lRHgz?=
 =?utf-8?B?WmpzT3gvc0Fvdkdyc3pXUU94UkdBYW56c0ljWkw2UzRkZW5kR3BoRWxPNEV0?=
 =?utf-8?B?QU9tMHJhYm1xSlV1WUZ6b3FYdTEyTWVCR0xNVzZRVEl4OVpYK0UyNFpaZjFi?=
 =?utf-8?B?dW0rcGdMSkZJcGY0c0VTV2EyQ2dmZjVXTmJyLytJekd5VjNaRk44WDVlemov?=
 =?utf-8?B?anQyRy9Cd0V1czAwMklxVkJHSFNCTkxSVExTYlFDWExjUFJKM0JkTGJwNm0z?=
 =?utf-8?B?NFB2ZXk5WHVNWlE0eURiVUgyWmVTMEEvd2Nxc3RzWVhqUFpNSUJzeVBueEUw?=
 =?utf-8?B?NUpkb1p2eGtDMkZjS1ZtNWxWaTZTdEdFNmtrZXRla050ampNbm1sTzcwTVBh?=
 =?utf-8?B?dFY3bzVHSXhjem05SjIwSVFXN2hDU2tCbzZDWG1SUFR1dHhaa3M3cW0xZmxE?=
 =?utf-8?B?dFN1WXFIZm1vQ05YdkNXRHhSSjBnNGphRWZJQjh0S0Q3SXAxcHlZZ3JLZ0pH?=
 =?utf-8?B?YU9Db3d2V2h3ckdKbm5wNm1DeHhndjJrUWQ5U3BVeGVDWjRDdHdzck4zekNu?=
 =?utf-8?Q?VvBV5j41H5nkaovVtl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5331eee1-88b3-48a4-b9ed-08ded6a63683
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:50:50.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJFHZYLDGywpvtJjTNEBzOrXDlSd9BkDjPd7+OtVFqfHuCVdVKSMbn/+ILgyh/xF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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

On 6/23/26 16:12, Tvrtko Ursulin wrote:
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
>  include/uapi/drm/amdgpu_drm.h           | 14 ++++++---
>  4 files changed, 67 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 862fbc2e125f..e75026aba874 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1204,14 +1204,20 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
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
> +			bo_entry->userptr = amdgpu_ttm_tt_get_userptr_addr(bo->tbo.ttm);
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
> index 16c060badaee..7ce9e0e194c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -785,6 +785,33 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
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

That should actually check for usertask and not userptr.

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

This is identical to the existing amdgpu_ttm_tt_get_userptr() function, just without error handling.

I suggest to just extend amdgpu_ttm_tt_get_userptr() to also return the flags.

Apart from that the patch looks good to me of hand.

Regards,
Christian.

>  #endif
>  
>  /*
> @@ -1392,19 +1419,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
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
> index 2d72fa217274..e1b3495b902f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -209,12 +209,30 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
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
> @@ -249,7 +267,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>  				  unsigned long end, unsigned long *userptr);
>  bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>  				       int *last_invalidated);
> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>  bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>  uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>  uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..24f2dffc0789 100644
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
> @@ -860,11 +861,16 @@ struct drm_amdgpu_gem_list_handles_entry {
>  	/* Preferred domains for GEM_CREATE */
>  	__u64 preferred_domains;
>  
> -	/* GEM_CREATE flags for re-creation of buffer */
> +	/* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
>  	__u64 alloc_flags;
>  
> -	/* physical start_addr alignment in bytes for some HW requirements */
> -	__u64 alignment;
> +	union {
> +		/* physical start_addr alignment in bytes for some HW requirements */
> +		__u64 alignment;
> +
> +		/* drm_amdgpu_gem_userptr.addr for userptr objects */
> +		__u64 userptr;
> +	};
>  };
>  
>  #define AMDGPU_VA_OP_MAP			1

