Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9675E606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PQzOsEC9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1FC10EA0A;
	Tue, 20 Oct 2026 10:56:26 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010033.outbound.protection.outlook.com
 [52.101.193.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E371110EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 10:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohz+39jrIt/F8F9LTZwuox6lIkIteMc41qhw8VFxTf99bQWOcp0ejRIoDafcs3gThDYzqlyZsxKCtTI9udwUi4GVPsHXDkEWBkasy/QH6+aakhQzJ6Tap9ZacE6LX60lICalNRPA+174axsPFO8g1lOSUlh//N5znT0/ubOWNi69g8jG2BYLmKgOK9pN70+9jzbKNW/bhi++rC1JTRZCUkttjIq1F0ayCG6Zo5US7AguVcTEBM9L81T1zcF1DQxtdDuyc0uVJp0b5Uvizdf/oR16AODVbZxFMRtVUbAVgntiL9gCaklkbjwXwxIIdhbH3zFWs9Jb8t7yZT4Ue8F4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOBbjDhgoyNpnpibk4+8O6YYk6/mW6bQv8Y9UI7RCGI=;
 b=Cwz2LlT2+5dj9r4pb97M7VevH0C8QxM6uoGGo2xiYgGRcUwd0Bi7m8nyDx2BheMX219+T6ZZFavVkyRiUxEAGY5zPSlEIx3aIpxT5jCW0KuuiodXw8eu3EAJVJaAutCAK7aTHRnmxfxaNLDxB7LmJkf3N+1vZSt4rSSQVRU3oUDMkMo/xwAA9kZW1wUxdnMFAFwX/1x3AkWnh/wARgQFrWpYEnZZTJS1nzF19ad7BzWQN75KxCjM8cNZf4sPyE2d9GCH06BvPgVLBRY5KO4Qj3avEJ+B3hiO3CwDJSGH0yiPfWo4d5CYAYQvKZB2PHmoca0rr93iAzUJ3ZLHA9PZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOBbjDhgoyNpnpibk4+8O6YYk6/mW6bQv8Y9UI7RCGI=;
 b=PQzOsEC9p3kMpW7wlx0EW7u2KFKOGxLQp6VzlwjwBhMPhQcVDrRnX5ztXN9j7UTzGvd47BjufU97A7Iok6ybsJyPRTvzHtkuQEqht8KY8VL4197RDyny4HvWhNcx8dOlA8iIJh5jP9ffl35RVU2LfKlbEC3qRddJ0wZchfxzxOI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:56:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:56:14 +0000
Message-ID: <a1ccc011-7d8a-48c7-8ed7-171bfe4ab0b0@amd.com>
Date: Tue, 20 Oct 2026 12:56:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] drm/amdgpu: Move amdgpu_ttm_tt_is_userptr() under
 conditional compilation
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019130159.11739-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d4c15e-7986-45d0-f118-08df2e98c255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: dl+YxLO9BeASPn6V0wrlF0Zvz+3wqFxAq//6CwiutSMG30AO6HgKesIsngVUzC1OwpbQXvDgsFGHV2b5Acw6IOw99ckNIoU6DGOltJ5F/b4PyzCUyIRxLBU+t0TEI87IEOziEee2gqaZjiPDFqZFsdt7M8v7FNB3mo2vy+enlvnO6rt2flJePJHnUopY2F3CG2f9fp0kLuWnGAFecJpDGVAa6M6WpnXJ5S4AJk8XRUfuul5Z4tiAydrtA1xy8+4j1aipAdzqz8r3qW18yK15A43zZ7ckVDMqx/XLJhKRU1cUWKhhll1w2LOjGvkX8elV9MfqUVD+9C5A6WGQKURIr/MowZc9sM4ZyqwaKRhd7AWryYUokrIUvidkfNIIY58YbjxLL/3t0RdkbGiOljGRI0ibChTeCXCVIXvHPDyCh56KcJlJzC7EK81yLIYydr62UccRV2VpwyXPk3KtBDgUn3FnQ8GSn8eYEbXg1Cewk33YIJZFWS7/o7zK2ydv0IPfXTxGYWR5TOK6yvW7fLk/4V3XZn+8h2HScBTkj8hTTRYOcgGhz3H6NEAk/szM/Xucehy2HWtOSNBy+yYRBGQ7bRSM1rENeOOtHGoiNlMnbBn2Tmf3RIGYnazCbZ9dEPmZZr4hig6Gsb+qjfk7O1kTXe2bUVJv67Q3jvDmuvybnYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9ZMXp1OUtCWjBaTHhUMkViTjhvVFJvYkJrYzBBeXY5NUZFaWEwTUZ4MVR5?=
 =?utf-8?B?ak9GeWFjSjlhNmVVMmhyOEhldFgyYXBJa0FqY0Q1L2FxVXpWYUJaTGt6S1J4?=
 =?utf-8?B?ZnF1emN3TWxvSnIrdG1yU1YwcVdHNVJ2RExqMXFTd0RVb3JMQjZ2SjhDenNv?=
 =?utf-8?B?bUVhMmdIZnBZZktlNUdDQW1wRndYYkVKTmZvb0pUazh5Y2lBcThlaWlOSFJh?=
 =?utf-8?B?dEdiRWJqMDVhQjdTNkFWdXFiUXdCRWJTeGMzYjZTYVpvcFNMeDVVVWlsenFL?=
 =?utf-8?B?M0E4ei9TaVBEcUQxMGlRVWdHZmQvMHFHUFNPY0VLa29SeDg5SHJyYWxZRlRn?=
 =?utf-8?B?WEFYTHRWNjdNRzVQQnd2N3RUTEhMRlpucER4TDZ5WTNTc09LeWMyQzR3SHI0?=
 =?utf-8?B?Z0l1WnR4VkZweVpGYXpLcEJ0TEFpR0xqUDBEZ3pwOWhRQ3VkcXA1dU5TQWpJ?=
 =?utf-8?B?RzRESW5vOVBPM25KNzZESEJJRG1oUG8xeGd6SC8wMUFoblQ2VUdrdnZ3TDJL?=
 =?utf-8?B?Y3NrYkxkWENOS0E1NStXSis2ZUF5UU0xUklWcExqR29jQ2ZTVkpXNEZCdGtv?=
 =?utf-8?B?K1lmQUR6OEdKSjV3eTVEM3R1NStJRnIrSUM2a0srSEoyZzdLZ2svK1g5Z0J3?=
 =?utf-8?B?WnZCbmZEZ2RUUkwvVHFaMVFEMGFvaHd0WVZKMTF4SGlMV1g5UG1IbTRVS3lt?=
 =?utf-8?B?cnY2eExTY0c1QzRzWVcvOGUxNHlqU1NYaHZRV0VKU1k1ejZSVnJNN1dMeWYw?=
 =?utf-8?B?VXNLdVlHb1l6NUdTck00alE3aWFwZ24rbTBWMnU4K2dwdmVxeGQyRzFuQkNW?=
 =?utf-8?B?N1ZtdTVhTTNhOG82c0JQQ1dDWk91amlkazZQZHFDMHByQTZ0YkpRU29FT3Nn?=
 =?utf-8?B?Sys4Mnc5OXNISGw3UEdEVVlqbDkveXIzeEJWZTRhM2JCVjRBUzZyTzJhd2ow?=
 =?utf-8?B?bkVVOFRQSzhYV1ZKM0VEbjRvTjcvQndUc3FtK3FhdWhtZTBhR1lmMVREYzNq?=
 =?utf-8?B?dTFlRDBpekRPSXVrZTF6cC9Ya0NLT3pFWXRxcVVINUUxdUdhSzdmbWlqT0Rl?=
 =?utf-8?B?KzNzbEtETU1zWjBETWRpK3ZPYkZzeUtkZjVEdmRDTEVGVEVaNVVpMDNYdzlV?=
 =?utf-8?B?SDJvelVJbGFIOEFPUWdGRVdGSDkxT2U1cUR5K0FtcU13dlhWY2FVOGVUQyt3?=
 =?utf-8?B?YjNFRHJNdHpYYy85RXpmZ284NDdSV2hlQnRrbG4vb2g5WWs0ME4rUkVJUThv?=
 =?utf-8?B?WHkvZ3hGVThFYzdkTWZGaGhSVmdtS2ovajZ0ai9BQm51SHFjLzBnYitZbUpZ?=
 =?utf-8?B?a3YvTTdsVlU0cHY5eElFWHhIRFV5d1JLT3hKOC9uNjRlOFNGbkdhbnl6WTZJ?=
 =?utf-8?B?ckZqTXVBc2p1Zy9QR3U0MFJ1UEtuY1NjSklmRFN6V3RXS3pUZEFwNVI4TjZR?=
 =?utf-8?B?ZVdqb1lNLzZvbzRFSWxYbm5YVEErdDRqNjBwd3R6WHUyZ01XRkIyS0dXT29E?=
 =?utf-8?B?cklmSGFzT1h3OEZFY2gvWFVKYklGQ3dLWVlaemg3UkF2OWJVd1BOakFINGdH?=
 =?utf-8?B?dHlYZ3puWGlDSDNyZGVPZis0Y3pxV2g4U0sveUVLNkYxNzhVWmtBY2ZEYlFD?=
 =?utf-8?B?bU8xeXlSQWJBc2xqOU5qUG9sWW9uejJBQ051Y0Zic0pheFk3UzR0WkdmVG9T?=
 =?utf-8?B?Ynl0RDhwa1YzbmxyUlpRUEtLWHY4V3hXODRCR2Fsc1hDM0lTVVc1RFFvUUVs?=
 =?utf-8?B?d1NobHY3OTFuNm5WSzVRWGJVc3RzUDNYclJjcytrTGNuK3I3YXM4TnFrNitl?=
 =?utf-8?B?MU43YjlCZkp2UTNLQ2NuZ2Q2MWRneU9CZStOTHpGOXV5NElDbG9nS1IxNU85?=
 =?utf-8?B?Qjg2QlJLMnI3K2IzSlc4TkhVSTRFVE5XQWc4MmdKNzViTmM0dFBaRVNiNnZH?=
 =?utf-8?B?WlJ4L3dHeUdzYXdYeHhSVXdhdXN2bzNEekVub2xLOEREaVhuQlpNalZwTk9o?=
 =?utf-8?B?SlRtNVAwMlM1aVVPbmhrU1Q4OHEvWTduWFdpL1lNTkxrcmdvbWc5ZGhOZVFB?=
 =?utf-8?B?NGM1QjJOMDF1N1gzbW5nTzFYZndnQkFsMXVWaXo1cUkrS2daK2E5OFQvUXNr?=
 =?utf-8?B?QVQwUFhpbDNIS0hFaFlrVjl2QmhYU09yM1JLdjA4TkFHSlNkSmFUckYxT01i?=
 =?utf-8?B?MWJlUmttY3VZQVY0c3g3ZTBhdzNPelNFOHl6cUl0NTU4ZTd1SW1MRjFQbEcz?=
 =?utf-8?B?OTBPMVdLWllzTld4RlFRSklrR1VMSVZsYnB5eEFnV3lJUTJ5SHZuR2QvNWJh?=
 =?utf-8?Q?RwBGvYz97qQjqxHIe5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d4c15e-7986-45d0-f118-08df2e98c255
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:56:14.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmxeNecBe9w7u7J71RfChNWeTyaWfVkwKtkkrR/3Pyn/fAjjX4BJjVAnZLUE4Zvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 15:01, Tvrtko Ursulin wrote:
> If userptr support is not compiled in there is no point to emit an out of
> line function and respective calls which always returns false. Move the
> declaration and implementation to the the already present conditional blocks.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  7 ++++++-
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8acb12da6e8b..cebeabd0ee72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -802,6 +802,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
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
> +	if (gtt == NULL || !gtt->usertask)
> +		return false;
> +
> +	return true;
> +}
> +
>  #endif
>  
>  /*
> @@ -1409,19 +1422,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
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
> -	if (gtt == NULL || !gtt->usertask)
> -		return false;
> -
> -	return true;
> -}
> -
>  /*
>   * amdgpu_ttm_tt_is_readonly - Is the ttm_tt object read only?
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index adb6cfae5052..8d14d8a5c25c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -213,12 +213,18 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct amdgpu_hmm_range *range);
> +bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
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
>  #endif
>  
>  /**
> @@ -253,7 +259,6 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
>  				  unsigned long end, unsigned long *userptr);
>  bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
>  				       int *last_invalidated);
> -bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
>  bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
>  uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
>  uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,

