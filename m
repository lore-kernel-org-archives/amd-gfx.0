Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41874C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B9610EC86;
	Tue, 30 Jun 2026 13:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nzTk/tQR";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D607510E1FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEe5MJItgupylYy1nXVa81pv8Bsq2ZjbNlhqiX+957jSyHZDenrPDYiZMvAUXOvDUPYEPYychrbLUwSciP5xb60/XZoW6CU1nd2BmhQJXQ7OqV9hYX/Cifp+Urn/FZB0uUsAxeQrfmlc57f2qRIHfjEkAa5eRg2n+mHc4qtUZYmv0ZK+lnU9694lWOh0QC/xFBGriJEuKK7MV9zfwFksuWzJaTA7DhBOZdi7tAe/O/JQSM4nSZJMDRYHRO22ja2ssArZstdYHSpTfFySgpk6ecrpPJdPHaHjT4BBhNd3T5h6Rgzm0TN6B3zLd3dmiHvISQN3A6LR8d+GDXAYgvs4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cATyS8qaIqg2zulIt90lO7d8eFK70KaMNJ+9oMvWyEA=;
 b=jpP3+F5egyTjqSTCnFHOXHM6l/zIive+mUAGVR31vNHpEKPSs1XbnxH4K+Sm9N0s/CmAColtcqwWNkrxWCqPxUzB4/pGm6o/0s/Kjci1vqkATui+StU5U2Duod5GJky/c5aaCTYE65lB5vzu2WzGQRSO683IPEyBDwN1QMc9NjJWVijUz73c7Dt2mf4q3IiweXZLv7XaC2a/9iF7MB8J1itDo4rDcqa0MFXl699ADoUwajG2gfltqr+7IcCcc2SFY7Bi43hkO2sLqezFkJiWnZ80UQKA6+ukQH84taH0CYdtUHAiEnFP88+12bs7WJt8uVj+mODueWIGHZV3g1/xTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cATyS8qaIqg2zulIt90lO7d8eFK70KaMNJ+9oMvWyEA=;
 b=nzTk/tQRgDGW6U17aU14/d+95JlaSpRYmqm4I7kVjhCaKu65rHFSwLbqS10Q7ecxpUyrxMf8rEJ53yzyeKO5TExaax0JVpvQb1w3YI939vKnhdLmTkvzVbSuaCdK5+8ihaMlewbBEihIyUUkSsDbWDLqTVDjeP2nobfRc2wacsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:02:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:02:58 +0000
Message-ID: <109ee3c0-2111-4256-bcac-59da1f76d2d5@amd.com>
Date: Tue, 30 Jun 2026 15:02:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/4] drm/amdgpu: Add a new ioctl for listing client
 contexts
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
 <20260623141257.66086-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260623141257.66086-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: d035be32-adeb-4b6b-5045-08ded6a7e865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: FDDGMvGXCUBpQ5laXQ3y4iOjiuywghacY24viBE5Y0Au1Qntoh6s+JPrdsdjmKI8F8KYxOUuCnoz0Ad8xGbifljj/HwMvyQtTM8WV42Dq+g9fdz0ZfP5Uo4viurVcEzX2jiPrEuSWBDsPMPZAYRn+ZT0Tgb2y0HB2ByoIy8a/Vx80eyUypjHgZgmxCsaCWADoDjP2ti22lDkJJsskXfY5U270gtaordtU5UNKE0LQG8NVar76azSGLaqvYzfihUNtFeckFvOLAtEkP0E6W7aCiHUWuIpB5WiEQFhg9lsBDUeiir+sluhHjc93oDNFVvEbwiejJtQkvHnDDYkPMct++75BrqP0rnJq4dbUNnnj+KDzIZxCYT6mLMYJw5bhx7260lDPQHDBpBUXkGlE9L+jvKm8o00yaEldiqBhaKqcDSi4bw//gXs7pjOxYZTrI65kMSoVq1+QDqbsz8wuTu3u0oSTNZs+EWlT52RWUHUeggPXq/EqJYy7eSU9siqdLpiWl+xNZTWMwy6qKFKq17xkyBxlsS4mm5gKFwxbpnuBcJAgkjEffQbYp8d4c+Vta3Sr38JKtOu31F3Imf2mJ+StUf/oIJLtMuASou0/go63lUebr72V1GbLd+MMH3a3BxLWG+7F4lO+hsuEznsSJs2MOuxNpmXw7S2N4GFTtWNOaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FPVGlEdFpxMHpUU2F6RXZIMnNLaXVTQmZjSTRtTS91R3BPQUNFUFlqRyth?=
 =?utf-8?B?UmJtalphUUJZUXl3U1l1a1FocG9zOE1hL2IxUGZIV05lYWxPcFUzMzd1Z1dj?=
 =?utf-8?B?VktNdmNGY1V2cFVDcTZPK0x5ZnpTOWVaRndBd3lsUVg5RzhDTTBpV2oyNmxp?=
 =?utf-8?B?QytZZ1Z3bEl5SWJuU2doS25aNUMxaEFZV3ZNdkhaK0tKZzUwSHpjRWxKNjBy?=
 =?utf-8?B?SGh2OG1BeS9QNkVtRE1kSmZyQlpQWjIwZEluZkpWbVVYZVMxWGg2d2FQU0Nz?=
 =?utf-8?B?Nk5rUTlRTTRudG5kR3RFVkxaS0lFNDIwNW9WNFJyMDhCa2tQejNqZFRJbHBs?=
 =?utf-8?B?WUNPZHgwZzc2bzVlTDZ2SDl3SGRNcXljTnNwcy9LaFNEUS9vU1YwVFdNQXRh?=
 =?utf-8?B?ZU9HRmw5ZXREQlBCZkl0REZPaW1xbmJ5Uk45RFFGSXNRbHhmNzhxdUR0Y3RL?=
 =?utf-8?B?Ti9DdHFaQW1hL25LR01VeFNhRVI5Y1J2Qmo0N2hvU0RIY1ZTQTc1cmI5K2cy?=
 =?utf-8?B?cHA1eGp4U3NLek1lUjRUSjRzYzNmR1ZPYXVjNHNjcG5YYkZPaTlLU0k3UEVS?=
 =?utf-8?B?ZWpMRGJDcloydk4wMHdqUGJCNnRQMTl4Z3VCWnNtTEUrVTZSaXlqM2tJbU1p?=
 =?utf-8?B?cXpCalNkaDVmbnNsdm43azZJd0NQZnpYOWhaOS82M1ExTk03b1dnOHlYRTFt?=
 =?utf-8?B?ZXNETHJ6QkR2TEdTNXE0Zi95SnM5REZ2UFNXMnZ2eXc2U25QT3IwMTZld0hE?=
 =?utf-8?B?dGdFRVlCVlozRUJUZEZlYVBvazcrMWZYdU9SaEt3RjhkNC9ySUlSYUFxY2V2?=
 =?utf-8?B?MWtRTVVRNWloZWdoNkZTeUxxWXF2cU1aK3JZWFZRQnNSZGZ2Y1cxNUZUUjFy?=
 =?utf-8?B?a2tBMWZOa09nb3hRL09Jenp2UjdYS0R1Y0pMTlFvN3BoV0MzOTZ6eHlMMHpD?=
 =?utf-8?B?eWJsbytrVy9lTGJtUEJBTHl0VS94a29sUE1Dc3BFanowdDQwb0JTUGJ5eE1r?=
 =?utf-8?B?ZkFmTEtKRHJaS2FubkJlMCswVGJ5RTlZUThvS1lRL0FBV2oyYTJabndrZzJQ?=
 =?utf-8?B?b3g1T00vdy9qZ085dkFqaGZvdVc2Wmp3a05pNDlrWDVuVzNWMjh1OUJwL3Jt?=
 =?utf-8?B?S3pJbHpzVFE5MENxeG5OeklpeXpxcXhWUTZadHN3VHB3WjFreG1qU0R5NTdS?=
 =?utf-8?B?Q29LZ2ZjN2ZaU2ZmdlRjZUEyUW5rSVlkNUZyL1dZczd2WUpoa0J3NldCSEUw?=
 =?utf-8?B?M2s5dkx3TWlESm9rZnpvbFhBYkVCUTRBY1FKWEJkMVhGUmg4Wmt6UjdFdHBr?=
 =?utf-8?B?OWVjL3MxdGp1QWJxUzlQeHlHV3ZzOFFHRWl6SENxVVFKeDMvWkxuU3RjbDd2?=
 =?utf-8?B?SVd4MC9iMkd0RHRMZW5WUEVnOUFxRGJudVpOcDRwZmNkMkJQSnZudFVDUk12?=
 =?utf-8?B?dDIxdkg4QzVSNmh1eUc5YUhpZHgwOFY0YjFQUENBL3A2MlVma0xZL0QrZXlz?=
 =?utf-8?B?K1J0SG4xRGUxU3ZvZFc1TmlBU3k1WGZsaHJtUGttNzl6TDl6Wno5Nm9NQ1hE?=
 =?utf-8?B?TDZGcUkzcjVBQ0ZmOVJjdktuM0RVcENCcnp6clVGWG8ycDA1dG9QK2taSDht?=
 =?utf-8?B?YmF6Nk14MFoya0hybDV1bitRSXlrNFp1VHNNUTlVNTRtYkRJdG9IYWt6L1V3?=
 =?utf-8?B?eG4rQldacVdxekZsdlJsa0JJcFdTNTh2NVkwYjZKL1ZZMnF0Q21vZWdrTkJZ?=
 =?utf-8?B?YjJodGYvaEwrc1EwMUdWZnhtSE5MdVJ4ZHN5eTZWOEdPSG93eHNHSFBaMXhP?=
 =?utf-8?B?L1lmdVMyajlCdXQvZzBCTG45b21MQ1dpbEt5YTN4WERJdVJOZkg5M0pYWXZy?=
 =?utf-8?B?eEJrTjZnZk5pREU1QjQ1OUY0OXhqMGhPOTdEY0lFcXF2YTdLeWdFNyt5SXBO?=
 =?utf-8?B?c0ZOL1V6M0RRSHpmZ1RuQTlGOUYzYjNGRnljQ2NvZnB6VmJNR1J6eWlWaEZv?=
 =?utf-8?B?eDdrNjJPc1AreVpibG9iM29LaW9OOXJoZzJjOGdWT0RIN25oVHhqSmJWcU94?=
 =?utf-8?B?TzR5anpkMVlQV3N3QVVycTIzTzdidHUzVFRiZG5jSjVCMkpySHBFWXFobCt1?=
 =?utf-8?B?M2g2WUNSVUxSbUVRZDZSTnVnUUoyQUpGS3ZHZzR3MUVHdzlTUG4zM1hvN09N?=
 =?utf-8?B?b3FLcG1vNG91eXNHVnE0cVFxK3RQdUNlUWFMUzk1NnFqV2k0TGg3d3MzTTFn?=
 =?utf-8?B?Mm1CMXRCeHZOMUZ3QXB1Y1UzcFExejBPMzl3Q0NHZDBqbE5EbzYzS2NoRjlS?=
 =?utf-8?Q?mFz/uCmxvWTWRBJz46?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d035be32-adeb-4b6b-5045-08ded6a7e865
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:02:58.1886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLfOjYiOGBo2wqOEqAGFUYxhXPRc4/i6abBBzbOfLmrZLlg4lRBrqgwVn89Fbv+j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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
> Similar in principle to DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES, we need a new
> ioctl to list any contexts created by the client.
> 
> Lets add it as DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS, and the respective uapi
> data structures.
> 
> Structures contain all information required to re-create the context,
> modulo the handle id replication, which will be handled in a following
> patch.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 100 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>  include/uapi/drm/amdgpu_drm.h           |  31 ++++++++
>  4 files changed, 134 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index ce35b415093d..b9bbf8677174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -768,6 +768,106 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_gem_list_contexts_ioctl - get information about clients contexts
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
> +				   struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_contexts *args = data;
> +	struct drm_amdgpu_gem_list_contexts_entry *contexts;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> +	struct amdgpu_device *adev = mgr->adev;
> +	unsigned long num = 0, idx = 0;
> +	struct amdgpu_ctx *ctx;
> +	int ret = 0;
> +	u32 id;
> +
> +	if (args->padding)
> +		return -EINVAL;
> +
> +	mutex_lock(&mgr->lock);
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> +		num++;
> +	mutex_unlock(&mgr->lock);
> +
> +	if (num == 0 || args->num_contexts < num) {
> +		args->num_contexts = num;
> +		return 0;

For the args->num_contexts < num case I would expect an error return.

> +	}
> +
> +	contexts = kvzalloc_objs(*contexts, num);
> +	if (!contexts)
> +		return -ENOMEM;
> +
> +	mutex_lock(&mgr->lock);
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +		struct drm_amdgpu_gem_list_contexts_entry *context;
> +		enum amd_dpm_forced_level level;
> +
> +		if (idx >= num) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		context = &contexts[idx];
> +
> +		context->handle = id;
> +		context->init_priority = ctx->init_priority;
> +		context->override_priority = ctx->override_priority;
> +
> +		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> +		if (ctx == adev->pm.stable_pstate_ctx) {
> +			level = amdgpu_dpm_get_performance_level(adev);
> +
> +			switch (level) {
> +			case AMD_DPM_FORCED_LEVEL_AUTO:
> +				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_NONE;
> +				break;
> +			case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_STANDARD;
> +				break;
> +			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
> +				break;
> +			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
> +				break;
> +			case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +				context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_PEAK;
> +				break;
> +			default:
> +				ret = -EIO;
> +				break;
> +			};
> +
> +		}
> +		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);

Looks good to me of hand, but Alex should probably take a look at this power stuff as well.

> +
> +		idx++;
> +	}
> +	mutex_unlock(&mgr->lock);
> +
> +	args->num_contexts = idx;
> +
> +	if (!ret)
> +		if (copy_to_user(u64_to_user_ptr(args->contexts), contexts,
> +				 num * sizeof(*contexts)))
> +			ret = -EFAULT;
> +
> +	kvfree(contexts);
> +
> +	return ret;
> +}
> +
>  struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
>  	struct amdgpu_ctx *ctx;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bf4260269681..f61f0ddd3ccf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b558336bc4c6..0e17d9fc665f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -69,6 +69,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
>  int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *filp);
> +int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
> +				   struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 24f2dffc0789..3191ae1a0549 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> +#define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
>  
>  /**
>   * DOC: memory domains
> @@ -873,6 +875,35 @@ struct drm_amdgpu_gem_list_handles_entry {
>  	};
>  };
>  
> +struct drm_amdgpu_gem_list_contexts {
> +	/* User pointer to array of drm_amdgpu_gem_list_contexts_entry */
> +	__u64 contexts;
> +
> +	/* Size of the contexts buffer / Number of contexts in the client (if larger than size of buffer, must retry) */

That comment looks to long and needs to be broken into multiple lines.

Apart from that looks really good to me,
Christian.

> +	__u32 num_contexts;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_contexts_entry {
> +	/* gem context handle */
> +	__u32 handle;
> +
> +	/* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
> +	__u32 flags;
> +
> +	/* context initial priority */
> +	__s32 init_priority;
> +
> +	/* context override priority */
> +	__s32 override_priority;
> +
> +	/* pstate flags */
> +	__u32 pstate_flags;
> +
> +	__u32 padding;
> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

