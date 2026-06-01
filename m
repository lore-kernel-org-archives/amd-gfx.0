Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CC0CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FDA112F42;
	Mon,  1 Jun 2026 07:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K+4OCLzF";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20C1112F3E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 07:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAk15Byjs9JFb1rg+qvE3S3bzTWS20ElPmkHiSCUYSFsZk8Bo8FDH9wTA9UKqliCqZa7uSUC0VjmHEa5M3omFBZS5SnZp3L1kjj4q3lIBZT9NLpcYJ5+vrXyfyEL2tTBIJYtmlD3KkwClhbcNQynntFsbpYQogQTfiUCGV2ekHpjWQeFHLdqSGgmZo2JtmOdNUtMt4sLGNLlmZKbNiEkJf83sdntdLJtKEJLDw9wb+uRBUhv8QOFvzp8q0H+RTE5zZErqu6lgUt3t4TS9h40nLIKSoh5eQhkC75D0HUDJVlr4Y35/x6+2AuYanD6zuiAVfPhryWyoUFoRCvBnIoXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vitZSkNDYfz6x+6MapMSNvfoJUsnwI767/goXMoO0yA=;
 b=T8SEtOTUO5isA3A0cVt3R22lUg6T0p9SbBXZcLyeoanmh5rK78XH82HgTJTnRQ/gRIsEO32INyiyk7lUoBTaGI8z/dchYjJ5jv9U0mAg7fmlY08aUdET0H/y3PUAW5n2PSywydXbOPPzUAE8udHlnhdRA0BdRdD1raFmnPpnk2UvndAZvzQ7mIbd1DPVV/Rgvuq+6/RkJdfgd+5t61sM1B78cH3rN/A4TGHMbscqf3ZvvOvw07OP4Qc4xxoDYRknk42mLHha6/yFWO9+wDTXzTFbniGdU2wCnFKgAoMwsfNJAEy2n5KNnFkP67aVtzQV2rLIrzE/YgVf89y9HeBC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vitZSkNDYfz6x+6MapMSNvfoJUsnwI767/goXMoO0yA=;
 b=K+4OCLzF759SoDok4u3vDi7p1OeP3PxGXqn89sxc295/OL9ZH9JQkNSw9TwcouXLWXfQIs/SAejFadWl7rL0YwNNiolFkNOAittuUKvgR8yS1eDUEL0F4ksc1ZwR3ZDB8qzUgZNdunMLlQklWbRXsSOc4PxbMZ68yc0h2R88vUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 07:58:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 07:58:13 +0000
Message-ID: <e8037d85-e3a4-4382-a7ea-6af28f89e5e2@amd.com>
Date: Mon, 1 Jun 2026 09:58:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260529153051.973261-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260529153051.973261-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 437b20ef-3bab-4cfe-6ac5-08debfb38815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: URbROamO1abyBdj21ef+xDiBo/T/4kg5uvPb1UTlT6547pzH0wEbnvuTsxvonpcnTjTmiMrzveuqYJz4iVMHSQgupA/YAcCXnRox77RBUKXKo3fEK2lSpy8md9SvTYMf81b18Yr2VFEhHYp0mmkvFrz+cpuLOE8fLvLq114awwKlh0gc1PqhCKAvU59N8Efge1wuBr/Ekty1FACWAvlnNG+p8yLPVzen0WDyLZOA3HQ6qVnsP45xzYVFL+kB6nzfvV7xcnQWXV2NVqBelvs4QHFxP2PRbcuLK7ZqYM660CUBcU4776mIBBCR9etDqL2fQzbFaB4zJEhHWxF9YbDh8sSf1wTahy/2E6CmsIwlmmnBnaL3w4v7/G7lPkRrIFAb9ziFMevxM0L5rVzC5IGrRxp5XPehMYU2iKPhQgv+CPpniGpQG8EgxIJGqOVqoUtUq0qj5uDMrNOUh7zg0xvGV6zL6jMpzzSzrIyARG9gV+rWlvJu8+XmfiZFYnzy0Zin0zR8l2lOmwzr1dOJIlIb2ApU6JjESNWNswmL/wzsq99/EAYmwgbcMMV8xny0neIBgBCOie0FGNqSEG0MqGzsaC3qIs+5egz0CacaNMJtzHYu5GN46sinP0ps/nHHDb1UPMIzIbAYPQE3Uo7MF5uL7TBm/qj2JWvi1q1bknZFfSBNrs9yvqWy8tk0fKJb5YMc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWthWnRFbG1Da0VwS2pJaTJsZER2TGhnOFdrallOTzdjQzR0QTEwSm0zOGlE?=
 =?utf-8?B?anZieVhrbmx0ZTJkNUNZYUc2RU9oaExJRzhlWXh0cFZEeVhnWklxcG93eFBF?=
 =?utf-8?B?WnlicW5xczlUbnN6Q05hUHRmNmRrNE5ValFQblY0QzJ2cklxbmtkNFVIalRj?=
 =?utf-8?B?NVB5M0ljbVBOSENQSzBaTTIvVGZ0TmFodG5NSyszVXpNTmt4Q2pTZCtHdDlu?=
 =?utf-8?B?UllkZXJhcEtabzV5T3ZxQkUyR0U1dFZ1WVVPejJmS1VFYUR5UUZwK0krcnJi?=
 =?utf-8?B?K2pzU1VhN2RCTVJ4T1FkN0pkbnBtODRUM1hSYi9ocmM4S08vdFIydVZqZ29Y?=
 =?utf-8?B?SDFQbURRa0ZEcmFzM2pYL1Yyak9iZDJSRmw4a3dxRk9wWmNSZWhXZDhPR25X?=
 =?utf-8?B?Qkpna1o0cHdwQ2EwcWEwcElpNTFjY2FMQW02bDN1LzR0TUxGbERZUFRsOHdw?=
 =?utf-8?B?a3RSLzM2eVJia1g1UE5XVWZ4NklIazRlMHBHT2toWlVZd2dhNHNPclRGaGo2?=
 =?utf-8?B?WEgza2FPYlRGN0kwTVQ5STBha09qUW15V1RLajJFM3BDQ3lDY0ZoakdXQ3pF?=
 =?utf-8?B?ZXlheG9qMnBDMlhGWHBwbWgrUllrbDhtTCtURjdPNkZIa2piZ3RBamNWZnpj?=
 =?utf-8?B?WDVvOHZyc2ZzcytXTHd2czR6UnhBR0ZEUUVYQS9Od3kvZUNWcHk1VzNQVm5h?=
 =?utf-8?B?Vm9aU1NGdWhLM1hPZEI2M05ENkZhbFM1Yk0wU0V1ZmFCb1BCUnd3NGlaL3l6?=
 =?utf-8?B?SWZxUCttWUVreXJ6STNDMkMzQWRaS3hELzVwaUpyNXBLSWk0eGtyWDVBMlhV?=
 =?utf-8?B?L2F2NXp4RFlUK0VjdUU3K1N0bFBjWlhPK2hLTjlNdzFJUFdybDdGSnB5OFU4?=
 =?utf-8?B?VGZNcHczNnNyWkw5MjJTMFB3bXc0UXhaWVJvZ0lRckFiblV1TGRsOEZNQnps?=
 =?utf-8?B?UkRaSGVzeWNVekJ4UW1QYSs3UGM5dUhkY0oxTkpkamd5QVFvRU02VldyaXc4?=
 =?utf-8?B?MXdqb25PQ3ZZU00yeVRaaGFyTmJodnRidCthME1nSXJsTDFPOWwyMzA4d1dt?=
 =?utf-8?B?L1RjTVo2LzN5Mi9STy9KQnpoanhseFdTTjZPaUxMVDhyZXpjQld6UGV4OEZ2?=
 =?utf-8?B?SUsvVGt0MnUydjdFMHVvN0wyUmFGS0lTOE1UOVN3d1hsU21uQUdlbVkyU214?=
 =?utf-8?B?SEJWWVl5aFpyRjJzV2FUazlLVnhBLzRtT1JXaVpXUkx1NGJhd0hnOXIwb2Rx?=
 =?utf-8?B?NzVMa0U5NC9udWpNRmMwRzFTS2gxOVpqd25sVlNQVjd4MVh5aWgydmFEekhQ?=
 =?utf-8?B?cmU2OWpBRFc5RzRnRE9PbFYrR0Q3Mkd6QklyOWZpVzhEREFUVUtTcTZXZUdT?=
 =?utf-8?B?QlhiV1J0aGhoWTJBVFNuZjZibHJsT2RLelZydDN0V3ZrRUgyUno5UmJGaEJo?=
 =?utf-8?B?eVlTQmpwMkljcWEzRDZ6cVVOK1ZtNkRURlVLM2NMT1NkdjFQRWVKa1JGSEcx?=
 =?utf-8?B?WVhCZHg0Tk1VcVJYUGgrY1ByaWR3OXJvVHJHTnBsejdKZDZaYjhPckpvSTdQ?=
 =?utf-8?B?Z29oVTJZdkVIbXUyTE8wWlBHblpSUTMvRUpuTGJHb1BHZ1FVcUJpbnppanFk?=
 =?utf-8?B?SXZyc0VZNzdkdks1Wm8rQ2ZMeHB4ZDhza3VzMmE4ajlFUnRJQU16K2MzR0Jm?=
 =?utf-8?B?ZW5zUnI1RUE0ZERqRmhyUG9aNTdndWZsOG82RnJWNmw3K1VEWGx0TWovQmhH?=
 =?utf-8?B?OUxqQjJDb3BwckhpWVlXUDYxcE1QcTlQY0tLZXdvdmszMlJOb3pWeTBnOFJ4?=
 =?utf-8?B?RkFwclJ0YTFpUkZWL2ZUM0pBWk4rR28xbERUc0g5eUpoVUpFTGtCZmFHdExI?=
 =?utf-8?B?VnE1Y0xSS0s2NFkzbjRKck83b3c4TE1SSElNV2dMNUo5WUU3UnVIc0dzV2c1?=
 =?utf-8?B?NWJHTDlFRUFweTJrUTZBN1YwNmdINFloZVYvSWRReHJ2TFFaMHhwRER0WVV2?=
 =?utf-8?B?YllmNWdpTWpMamZlampyMlR0YitWMzZyWFZYeUt0OGliVUFwdzRaTHl3ZUNR?=
 =?utf-8?B?NmFOc1Q2bk13Y2FUa0U3VU1uSDQveDd5dUpwSjBhcHNnT3hnRVBZbGhvQmJu?=
 =?utf-8?B?NE1VL1ZGVko3azJFckZaSHhuWUxUN3RhamdrWWRGVlY1MlBLRVE1bCthVjdG?=
 =?utf-8?B?d2lxN0E5MmZ3OTZUNEpkOUJ4eTZ5SDNwUTNvbHJ3RW5mOU4xdGJSNE1COUJP?=
 =?utf-8?B?blFHN0VRRHFMdWFFbkYzTkEzdzd0UmtKUXBta0U1NUNGVXNhM3pGTTExeFp5?=
 =?utf-8?Q?r8WzmatbBuqzIiRxl8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437b20ef-3bab-4cfe-6ac5-08debfb38815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 07:58:13.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1iGfE8mVjSe7+eR/OsNzo85OJsJKHHytzpwayISw/HKvFhWlhxwLjIzad6LrWxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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

On 5/29/26 17:30, Natalie Vock wrote:
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
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

Reviewed-by: Christian König <christian.koenig@amd.com>

I will try to pick them up later today.

> ---
> v2: Move setting of vm_bo->moved out of amdgpu_vm_bo_moved (Christian)
> v3: Set moved = true in a few more places (Christian)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b523a7b97d6f1..9ddeb984beff7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -232,7 +232,6 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  		vm_bo->moved = false;
>  		list_move(&vm_bo->vm_status, &lists->idle);
>  	} else {
> -		vm_bo->moved = true;
>  		list_move(&vm_bo->vm_status, &lists->moved);
>  	}
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
> @@ -597,6 +596,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			return r;
>  
>  		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> +		bo_base->moved = true;
>  		amdgpu_vm_bo_moved(bo_base);
>  	}
>  
> @@ -614,6 +614,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> +		bo_base->moved = true;
>  		amdgpu_vm_bo_moved(bo_base);
>  	}
>  
> @@ -634,6 +635,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> +		bo_base->moved = true;
>  		amdgpu_vm_bo_moved(bo_base);
>  
>  		/* It's a bit inefficient to always jump back to the start, but
> @@ -2270,6 +2272,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>  
>  		if (bo_base->moved)
>  			continue;
> +		bo_base->moved = true;
>  		amdgpu_vm_bo_moved(bo_base);
>  	}
>  }

