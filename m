Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02BCF364B6
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 21:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8BC10E869;
	Thu,  9 Apr 2026 21:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2p8KdDIo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C16E10E869
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 21:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm6lpb5L2dUhm71WoJa3n+SL+RbVdT414JYxJoMlGWFwPku7JFjmfWmUsp9ZKnlMEJb6E4Areb0CnvgG3qamr4guuKuOK8Tpx17W0KE+ahEG6IcOEFhKR9T86/xvWFzlrco6QUjvZJjA2mbotASBqNyfNhz7AEKJ2VI/QZ/sTS03iV4fjwOyTDLfXDzFxV7zzWxrMQwRd4UQaxUnxVIA3pK/QcHdM9CEGD/ok/6/U6qN0CCgQdMeT/2XP7A2IkXEFnKzqu0lJ3PrC001eSG+oG5JDQZuZ4OhUeZbXkF1BWS4x0llTZAVercpmfqwhLKqaRK68kBx2NsIGbt13dNahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQaR2CIiScSSvvIyrvnEhoj0/icHMpm77aqc2pL+GR4=;
 b=iQ/z0ujKVsY6xG/zS2d7sGfMsNkZoUtH+6W9MerN/+XzEtp9rL04JAodm1TTI5EjZ2Pu3VPFjMmR6s9IVojXySD9nJWU45j8zSO7PYAkX6uVsd/yiycAn4oOxWBwyRRAFuge1HMHRJgJSEqJb5DvOKGSCo5i5MpQlRslYg8N08Rk4fhE9StVHoiAecj3rO64w+/YyubG6Mj5fsFeW3TH6ZxxqG6auZWHxW5ylDSwmGngyLuHrI6n+YYOCBAty76zno7xAuYJ5+9u19aPvNtYfYpa2vzaWWPpHj4tW7yDozcPZZpkyCTrSr0SxhypnybD//9Uqv+klGmWi78myDF38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQaR2CIiScSSvvIyrvnEhoj0/icHMpm77aqc2pL+GR4=;
 b=2p8KdDIolq7nmRhsDsj3LieYlhbHMJhCwzNuurtfydY1/9CLubNBSOnBf0qcQgL0HuJQTASinFoL+8ujSoTvE3BB5wEERygDwZ+0HGctwn3S+b8CuyoXabDEpP1su/IKAClnN/SCvDCssONQqWXkx4H0QRKRmJStqz0wkPJ1pHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::610) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 21:11:41 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 21:11:41 +0000
Message-ID: <0620f110-6cd6-4e64-9745-395067fd5838@amd.com>
Date: Thu, 9 Apr 2026 17:11:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Clear VRAM for all user mode allocations
To: Amir Shetaia <Amir.Shetaia@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, christian.koenig@amd.com
References: <20260409150315.1441442-1-Amir.Shetaia@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260409150315.1441442-1-Amir.Shetaia@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 42616243-0e42-4fb0-7390-08de967c9869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 1Aw9BtktDAs9sOgwai6LWPWpbt5UlEg7CLeTwFJ3evyD2yWm0GQgBFmW3jiQCX/ZZzHcyxWADFyxY7e6wolasANJzNh6vgRUMqdQ0l/CtXqWY8BfOW1BVvP+xeMwmb9CKt9gzFltuvSq+JWGKi+kMP23NUwcNh7l6d9i+Z8YkGJjq7kERzQCuXL+6ZkugoPQmSY3F7HLV3m1Xi2DfSBgV6R/9kjf9IeqfHE7lGyzLjnbnb6X9jUxzebLAexuP0ZXX/Pp1DbBOgtXHwxZRf3NTvKOMR5HDhVVcxVikBccotsmWE+PvYA2ASYpezRsXY9ytN9h4Dl7USXI1HYi1NE9zZlOcE6XeO6NNPVxTRN0OOBl021jrZ6fm6Slxe8rcqPbHmz9skTrZX5+LbA1HQEVx0HyEYEFjE/LtoMh0VIP0+5/CsO/NWXb+z5uyrJ3Crw0dHV5e6hDiFQUG6LkUrGhuj4vlfWcdO/uqPJkxBMDZqaYTD4qPevyUnJWD4JQme3vbj1cp2ZZprfHQ1Bv2Aklis8KD8mL7YPNMO3yfo4X+LcCgRGwTlm6afVZBCI5EWEny7ZsCmeNLVKGEP66KMZsNx+hP1bQb7cIdxsCmFlJxT1KlAeRr/9s6u+OKrY2aMb5btYCQUpkcPtcyM589kqTHdY3riqPa27ZsdvRD8ZygmNSJ2tjtdPLaxI1659AaRj4iZGqgel0ZcZKed4f5MHVYQz195qeQQyVcd1psJzyt5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjU5bHpuZ0FUK2tOSkxEZitFcXA5NEZiRk1RM21nbWIzZFNEMmptUU9oa0Ez?=
 =?utf-8?B?empwVFVmUHVQaFRoT0tHYVRzdmFERHpoVnBNSkVheWp2ZWFQV0FjMTJvSlQr?=
 =?utf-8?B?bVl2NnJ1ZWdOWE9WbXV6Yi9GUk5YUE5kNmZiaTRhbkJ2NEc4ZXI1akJrZUpv?=
 =?utf-8?B?SFRjM25jUVBpSEtGYUtGeHhKd0hlRW02SnJVTXhEVnpRUzl1Uk90RlpEN3ZG?=
 =?utf-8?B?SWdFREVsM1ZjZGx2dmlWdHNnU3ZMOEd2Q2dsMldMQnlyVm44L21nVEhTajlX?=
 =?utf-8?B?WjRWQ2dvWEozc0VralQ0alRVbDdtQkRQSGYrdHQzTVJmendFTGxNa0JQK3c1?=
 =?utf-8?B?cFpCd0liSGZueUxRNFBSMVhKcTRDWlZWKy9kSTNmYk52Q0JybDN3UnlFNmRI?=
 =?utf-8?B?UHNDZjY1QkNycHBNRWJBS1VXWDZZL3BYUldjZmVCM3ljVkkvdFpmdlUvcVRP?=
 =?utf-8?B?QWNXOTdDemNuaG9PR05jVERLSnlrc1E1enAwd2hVMmd3blpiMjd3d3hTbVVO?=
 =?utf-8?B?RUhGakM1YWZHc3NrYis1N25DQTZvSnJCRVBXeWE4bFVHSUovTWl1Q1JaWjNO?=
 =?utf-8?B?dVJWTFhDU2pRZENTUWFtK0J0NmdybGNxNDMwTDQzKzZLOGJ3Ukt5RUszN2lB?=
 =?utf-8?B?VEJJdm5CNlFwRHJyZ092WXJqZnR4bk9hcjJsU3FZKzlrNjV6Yk5VdUt1Vnpi?=
 =?utf-8?B?Z0RGQ21QdUZISGtOR2FDTmtBNVdPMEp0eG10dklyTHlndVVqbW4zWjBxZkF1?=
 =?utf-8?B?NHdFUWl3ZU1QK0t2czFJZmhGS3FZRE8zNFFZWFhPZFVDQzM1M2l0Mk5tME1Z?=
 =?utf-8?B?bkVQdnlhZE40aityeERzYlpERGpIRjVBRGVodmdEZFJybkludXlPUU1ONHYx?=
 =?utf-8?B?b0VHazliKy9DL3pqMG5FYTQySG5MU3UyRkdUU2ptREVCR05ycjZpSFE3WVRr?=
 =?utf-8?B?ZnhORjZXQm9uWGxWNFZuOEFYTHMvYmsxSXZMSTc1d2psamFBUEd5Tm5SN3BJ?=
 =?utf-8?B?T1QyUEtESE9DOG5MZ3pOazB6VDNZU3VQOThvdUJSYlBTVk1rcFg3R25iODNl?=
 =?utf-8?B?R2ZPZ3pIaHFkK2QwcVV5LzRmMkkzUzBEZ3k4TllPSEMyOE5JbXFkNFlKSDQ1?=
 =?utf-8?B?MERBYnhiQXc0MTJKUkdueExrTTkxVHAvUlA1UmRhRENXaTV1NERnczRjaVAz?=
 =?utf-8?B?QjJwTEtlQjF4dGNjcWxEelRKdjNnMkN0bTNLNk5yVkVLZVpoaUt5Wi9CSE9k?=
 =?utf-8?B?UmQ2S0NoT1hvK0RKd0RyR3NoWFFVbit6b2ZaZHJHdFlsNkJTL05ScWFBNjFQ?=
 =?utf-8?B?N2NvM1p4c2Jsd0RLaEpMTlFTMWZrdjJvSzQzZUFSZ2VSaWhNQ0p1dkNncG9r?=
 =?utf-8?B?WmZUTnN5cDM1Z01hbExTc2RKbzUzYitiZ3NDQnBLRnZZM2gySUU5WXJ0YTh0?=
 =?utf-8?B?ZEpaV2tGKzBlUytmeDQxZHFZdnFkWmVSSkZOTGFRZTlWVW9qY0pMYkdWL3cw?=
 =?utf-8?B?a0k0RzBlcklTcGo1cFZXMWo3dDFYNnlqZEsxWlp3WGtTNVdxUEJzSVRCT2RV?=
 =?utf-8?B?UFNEZHRFcEtCeldNVWxrWVpTWVRkVHNKZ3BkRHAycEVqVXhQcnZaaEpYMzNh?=
 =?utf-8?B?QUR2YUpZTVJBWHA2eG5JYWI3a2ZSbERWNE1lWnBGS3dIVFAzRnRFd3V5QzVk?=
 =?utf-8?B?YTJEWXhjWmxQcjY1MTVZbGJ4YS9GalZlUXRpMmF4V3RMRldNOXh0YW9TNkFk?=
 =?utf-8?B?TDRNWWhnR1Fvczdqdi9OWWRRN3lPYm54eWprTmpKcnU4ZlgyS3NUYWpwRDNm?=
 =?utf-8?B?QklBV3BUdENicVBIeU0xRzE1R0tNWWxNbDBIMUlOV0NsY1NHdlc4bGFOd0JV?=
 =?utf-8?B?OFprOXI2ZE5ITnZUVGNmTlpPQVRDa0wxYTZTZjNhZ1daaVY5RVlmWFp6Nnh3?=
 =?utf-8?B?NjZXMmtRS1IwS2tldVEyNXhJblhCdTBwU011ZDJxbDhSa2JMT0FmZERneFRF?=
 =?utf-8?B?b1NFTFRPZ21mRkJiUlJ4bVlQaGw5YzhVRVdUM2FUdDB5VFVBdjRtK1kyZTRY?=
 =?utf-8?B?TitrTXZockdGb2Y1RXlLVEdOUDZsSFpWVWFlcENnSWw5aU1EQVFYTW5YZ1oz?=
 =?utf-8?B?ZEZmRWEwTUtZRmp6N1I0YTA0RFNMcTd5Z0J4OUtGT0lxNGhMMk9hbmcyd0NX?=
 =?utf-8?B?alVrd0hJWkYyVGtrcFBEVVNrZFpqUkN5N09mSUliZFJwYk9FSkp3SnhoYkha?=
 =?utf-8?B?enVGMTlKclBOYmhDUEdMQmlPQkN3ZzNwZGZZV3lBeFFxalB4RDE4S2VkdGJS?=
 =?utf-8?B?TysyY1JValVwcTk5OXJIVHlrZFhQcUVpTkxCNTBIR2xoNi9Pb1d0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42616243-0e42-4fb0-7390-08de967c9869
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 21:11:41.2607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iawEgkA7koKIPthzyXvudCFJVU+SDokKD1gCz/ZvBt5PaCdFR5Grs1stH5Eg/aJwDZzUY6ez+4yGiP6ob1U1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

On 2026-04-09 11:03, Amir Shetaia wrote:
> amdgpu_gem_object_create() sets AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
> but not AMDGPU_GEM_CREATE_VRAM_CLEARED. While the GEM ioctl adds
> VRAM_CLEARED separately, other callers such as KFD do not, leaving
> freshly allocated VRAM with stale data observable by user mode.
>
> This causes crashes in applications that expect zero-initialized
> VRAM, such as RCCL P2P transport where stale page table remnants
> corrupt protocol handshake fields.
>
> Add AMDGPU_GEM_CREATE_VRAM_CLEARED alongside VRAM_WIPE_ON_RELEASE
> in amdgpu_gem_object_create() to cover all user mode VRAM paths.
>
> Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Please also wait for Christian's OK for this patch.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b0ba2bdaf43a..c704bc53946c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -175,7 +175,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   
>   	memset(&bp, 0, sizeof(bp));
>   	*obj = NULL;
> -	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
> +	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
> +		 AMDGPU_GEM_CREATE_VRAM_CLEARED;
>   
>   	bp.size = size;
>   	bp.byte_align = alignment;
