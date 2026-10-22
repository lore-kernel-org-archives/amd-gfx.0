Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5F606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X0TW2rj6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C02011261F;
	Thu, 22 Oct 2026 13:26:18 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED24311261F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 13:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWOJh46+1LZcfVOFB0+NYERWlur6r7api+Y+qZIql2CIjpA6+Ih7DeEENyIemNHZ0MFFdmoxesA/IEhl+o0jBrmNPA5WhW6tJDJJGehTF4su7kk2e6bW4o7lkywDOb3ImHBvcOZj4ACSxlQfDABpVJrO91ahTJFZ7MPyWs4xg5QHplaF14uZKMWuUYh1ICFSTNmBVHogBfAUNmX0ZjwXVJUpBNsNO4CeJlpsJAJXqyO1rVaTgdVtk8rRVKv2Xuj9EQ7tweABelKZVCoVY1Lsnsrc4ayvcIq3nAuvqnhZERkdKRVkmzkV6Qz+B55ynYBvowubaVs9wJSzip5nY+ytcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ind98dIqtUEEKPmJYjqKj71RVKqMP9B6PVOcDOgs+50=;
 b=kfZ8aMKFFZRu2vxzRB492KqhHW/fQygPJ1gQ1fJqux15qsvFQokOmo1/pS1NrfSUbTDFoJrrSzeaC9fIva8cixqetJnbrjLjggSc9IhC2NM0pV4+xEpJu6Q4bRAW75FzvgWX0uZwOWEJaXIOx8LinZK6ESnrhHI33gqWgMzT88MRBUpr/F5YrCr9jOLPzciL/pSwDvTUK/qXYIjrpR25xdMUzWAAhrRCOHX6IbtF2vaOPElS8dbD3cqsIDbiTLGaOYE8KuPxhcFw0HtMKr2kNNxsg6r8OGQ6TjhIf4NAXI+IilkB0s4bwJK34crSNWNzl5IzjMj0ZXv3i8NU7giR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ind98dIqtUEEKPmJYjqKj71RVKqMP9B6PVOcDOgs+50=;
 b=X0TW2rj6d9FEZWxNYF7DkCy3Ax6ekSrU3ryz5Vvh0GakCkvzY0VWDPlFgkS8YZj6luYL2JHwkJ8l2N0D76x04AL+R/rqsj/65ys0nDwUt8ReQ4m+qt+gnD82bzF34zcUVC2NxVL3vmnA9Ldn+URnMLk3UmqFOuq0OjZ410SfaSg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 13:26:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 13:26:07 +0000
Message-ID: <de301682-6841-4245-bc64-3a0f01dd1259@amd.com>
Date: Thu, 22 Oct 2026 15:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: keep the CS user fence BO in GTT
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261022024407.4187271-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022024407.4187271-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:208:32a::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 256660c9-9a4b-4c71-9b78-08df304007c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sOmhRxuWQJxtyULh5278VeLaLvxwe9TKLGmjrMpiCsN5issEdrmJT1jjYi1XOvbcQZmUf/h1vIlJmX+AHDaeNvzPfPCETEwbzDg3U6UZwPnvVb7srl99qRE2lJSU1JxnUXsjoH3cNZAlDC3DGBikTj8NTm7iMsA16H8FwWdDzX7huCGMH9Lyj8ZO/9sfsknZyFewBkrdy4Ymp+gvSc5ELb1Ho7htmUN6ZRGJZZhmGWyO3W5D0fqn1Ytjdi+D5E4qPpwtGNLx7EV4znldKXi6k++IFfxIilptskLlEms8SwMA4r0WOEFTzLgKZncq6hQYOD39zevcV96Tqicpg/dpshFhpBKWjipzZ3dyjMEPkSB7k1u4koTlUmCoo6ZdesUIKsBPrGvk8kQ2MSVt15b/25jJzmEgjF4EGYdQoyaLpNKMBZRNi7zXJS0mx/IsBmIXWujtMk1zJwFZbdT6n47XLg+cxRpXrKDfEyiZ21XIr0S78pXi06VurSO2xRl0C1939ZZhKWpf8cx4l/SkwTtQtwr/3N4j/QuEZnzmeAFZGWXVlinYeh3QboTUmY+x3jsDzETExHrGZ8I6862pDe2Duih8AijOmXvsagMjIyLABJk8CCR51wa7xoxrz2noybmfYjN4PB+RlfcDZvaXC8uDdde+qccQrQ3xWFGOIN+L+Rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VVS24wUW4rT0IyTmtwWDNjeCt1QWt2SzcwakZ1dzNrTkpBSUxLekFOTHZN?=
 =?utf-8?B?N1p5RGZIQkVRQnZDVWt1RG11bFoyWGRNeFZiVHhrZkdveDh0aE5kZDRYRE1D?=
 =?utf-8?B?WHppUUNqU21xYmt5U1dBQm04K0xlT243SUNaS1dyR0tRc3BUa3l1S1ZsOFBD?=
 =?utf-8?B?Zkt4UkV0eGMyVHFIK2JjWlBNN1NNVUZGSy83cXRDTXh2eklZUUhoWGFLRUk0?=
 =?utf-8?B?RDlpUG9PY3B3VnZldUNOQ0ZqN2dxenJkWnVocFM3SEpoSC9TeFFRWWRDMk9n?=
 =?utf-8?B?R3VaVjVyV2pENHpTWnlEZVJoL0piN2tzYzFaVGtDNnFmVG4xZFYxdmw1aUR2?=
 =?utf-8?B?cTBqRnFHNlpEaDVSVDlRYzZPQmJtVDlZemRxSnB2UnpRdXp1WXZMSTRiRTZT?=
 =?utf-8?B?aHBnS3JFR01aT0ZvU0dOdFRzZW04aFdpS3lHcFJWZ01QQzd2d3A4MTZkMzk0?=
 =?utf-8?B?TWZMcnNRQ2xUZ0JjS0RLU2pFTUFucmZQemtkRFNVb3N4WjExeURTNjZYSTZ6?=
 =?utf-8?B?OWt2c3lGc1lrc1dWa2t6SkQwcTgyODBRRU0wQjhRTmJOWkpPM2YrMHk0aC92?=
 =?utf-8?B?Q0lkWmFaK1g4NHkxeDZNdHl1VFE4TFZFZXZRWjZ3VVFWWXJmUnF6a1JtQjNr?=
 =?utf-8?B?N0k0TWpzOWhzZnJwWlM3VWRlM1puRmFXZlg4cndpQmRIUURCYjdWbHhvR1hr?=
 =?utf-8?B?aVNDVzkvWnlnOXJGemZIZkFmQjNhZk51MDdKT1BQaS9zb0swVlc1UlRQekw1?=
 =?utf-8?B?TDNNaC9kZEJRd2RFYTBBV0x1SC9xbnljc3cyNzViRXJqQllIOXU1TkVXSE9K?=
 =?utf-8?B?c3dIUElORGEzUDRSUWVPdEc1OUFIcHFhREUzU05BL0NTc0xGaWVTUFAvaExD?=
 =?utf-8?B?RVBXUkFsTmh5Y2hiUUx1R1Y5dkY5WDhqVkJBcElsZTVNY3d0U0lsYnhFeFNh?=
 =?utf-8?B?RUJQanltVGx2UStLSzZ2ajhUOVhUQVd1Qlk0eGJGQ25wOUZzRVN4Yy90R2V1?=
 =?utf-8?B?alA5QkZOZXRYaGlJTS9lWCsxZDRFcytuQ2M3dGtiVy9mT1IyWkNzaXVYb3VX?=
 =?utf-8?B?MkUwSGF0czlTdEEvblFBN29PcDk0RTNVdWkySGNLQXhldGxnTVZyZ3MyNjcz?=
 =?utf-8?B?dndMVW5lOHk1MVZEMkNsenhMNkJLaWllVGI1M1l6WVg5c1JkcFlJTGFVbExB?=
 =?utf-8?B?My9vSC9aSDdIMHFxT2dFVndVamhha1F2UWNxMUhwMGFweEFoVEVvRDN4ODZQ?=
 =?utf-8?B?bXI0S1dHUFJTaXpOc0ZoUDZyU2U2V2xxL2FVREZ1RjVDTUlhL1FIMVZvNS91?=
 =?utf-8?B?SUdiUmZoaWN2aHFaREhFUmtNcy9VbmRpSDA5cTIvL0Z1ZmljVk1iVE9JeWhO?=
 =?utf-8?B?YlhFalhaSjJvUDlPSGJWc0tLRzNXSmFVVVJ1S0hjamZjdjR4YisreFprSmc2?=
 =?utf-8?B?dGl6MXpjRTlPU2pueDdaRXdyT2lqNVQvTVFEZG54Y0dtZkhNbUwwdktDWmlX?=
 =?utf-8?B?Vjc5aW12V0syWUNIY0xJZmFEWlFTZVFSTDJkd2ZOWWcrWTJQQ0FwYXgwZWhP?=
 =?utf-8?B?ZXJ4QzRLVzRJZlR6MUdnR3J3RjM4VklBZS8xQlJ6aXVrZW1OeG03YXYyMERt?=
 =?utf-8?B?NW1KWUU1MDVvdlF3U0VuMTl2dm84SFBGTkQxV0RjL3NEWjlYeHdycEs0S01x?=
 =?utf-8?B?eitvQ05pV3VaRHZzZUV0YzVHbVMvUFBaN3JLU1ozZkF3OGlHZUsyamh3OXVM?=
 =?utf-8?B?SjZTMlZZV2ZmaUZmcnFFbmQ0UWtPZDduTkZxRjQwcDNhekJ3b29JSEEyaVZF?=
 =?utf-8?B?T0JrZjhQRUpZM25FYWtYbmJRUys1TkQ4MDd1MDg2bUNadU5vamo4WC9VNFBL?=
 =?utf-8?B?Rk9TRVBsck5NNFh0ZFFFamN3N1YrWHFSYldJTHBmd2JCZjBtN1RHNFFnRWlk?=
 =?utf-8?B?WGVYRVp6ZnNmVmlxUWZMMG5WWUJhVFdXdDVkejUwdFN2KzlaQ1BKUG8xREVK?=
 =?utf-8?B?NTFBdStGUHlHV0FkOXA4UCswNzVPVTFpM0FZQ25qQnJBdVBhVkdxY0ZvZkpO?=
 =?utf-8?B?TjM3dXRiZFVjVXFvOW12clJsR3BTd1pmSUNRUjVFZVIvVEFYMm5DYXdCcFJi?=
 =?utf-8?B?Y3hDaVNOb2k2YW9vaUlJb0tlVXpPZjFlaEszVnBST3FxU2lJMzBKY05Oek1O?=
 =?utf-8?B?WE9JNksxdm54cW5vZUY1d3BxZDdJUjk5WnNZRlRYNDBwR3R6Tk0waW5hMm81?=
 =?utf-8?B?WG5zQld2MU1HblMva2tNcTJtV2FTbXJOaTRiUkVKbDBrUDV1Q0hCb1hZVHYr?=
 =?utf-8?Q?Tcg/y4SUl2fdwqg4Z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256660c9-9a4b-4c71-9b78-08df304007c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:26:07.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1OIaAImyRLi0XlDVJI/jR0RLaaegG2Vnk6iy5PsO+ceuC48qlx3Ssz7hY9D6JHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 04:44, Jesse Zhang wrote:
> The CS ioctl hands the GPU the GART address of the user fence BO, but
> since the BO keeps its own preferred and allowed domains, it no longer
> makes sure the BO is in GTT. A user fence in a VRAM BO, which only needs
> to be a page in size, gets its address from amdgpu_bo_gpu_offset(), which
> warns about non-contiguous VRAM. On navi31, a CS with a user fence in a
> 4K VRAM BO, or in one created with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID:
> 
>   WARNING: amdgpu_object.c:1531 at amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu], CPU#11: cs_gem_checks/18393
>   RIP: 0010:amdgpu_bo_gpu_offset+0x86/0xb0 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_cs_parser_bos.isra.0+0x4eb/0x850 [amdgpu]
>    amdgpu_cs_ioctl+0x97e/0x2510 [amdgpu]
>    drm_ioctl_kernel+0xac/0x110 [drm]
>    drm_ioctl+0x2c6/0x5b0 [drm]
>    __x64_sys_ioctl+0xa0/0xf0
>    do_syscall_64+0xa3/0x4d0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> and BOs which can't be in GTT at all, like GWS or OA ones of a page in
> size, pass the checks as well.
> 
> Only take BOs which can't be anywhere else than in GTT as user fence,
> which the CS then validates there along with its other BOs. While at it,
> detect userptrs with amdgpu_ttm_tt_is_userptr(); amdgpu_ttm_tt_get_usermm()
> returns NULL once the task which created the userptr is gone.
> 
> v2: only take BOs which can only be in GTT instead of special casing the
>     user fence BO in the validation, use amdgpu_ttm_tt_is_userptr()
>     (Christian)
> 
> Fixes: 1ea863fd736e ("drm/amdgpu: keep the prefered/allowed domains in the BO")

That is not really correct. I would drop it and just add a CC: stable tag.

The problem is there for like forever as far as I can see.

> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fa301c71b782..7db85de5de8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -150,7 +150,11 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
>  	if (size != PAGE_SIZE || data->offset > (size - 8))
>  		return -EINVAL;
>  
> -	if (amdgpu_ttm_tt_get_usermm(p->uf_bo->tbo.ttm))
> +	if (amdgpu_ttm_tt_is_userptr(p->uf_bo->tbo.ttm))
> +		return -EINVAL;
> +
> +	if (p->uf_bo->preferred_domains != AMDGPU_GEM_DOMAIN_GTT &&
> +	    p->uf_bo->allowed_domains != AMDGPU_GEM_DOMAIN_GTT)
>  		return -EINVAL;
>  
>  	*offset = data->offset;

