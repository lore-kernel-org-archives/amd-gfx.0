Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174C606A328
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=HqlzpH6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5C910E0DC;
	Tue,  3 Nov 2026 12:28:05 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC1E10E0DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=HCRghUa7gKzhtMwYvMTx45iN0L0Y5Asekbm8NdoGl5g=; t=1793708879; x=2109068879; 
 b=HqlzpH6QP82twjgDvIV6cmg2c6D6H4qu4pRxUkQ5x55k8m1MV17DHdDU6pwTdXMXXZCdMZF7Ixa
 C4MZpIdBQlrcgKuFG+m1MAUknsjaQFQUSk9ogluhrtMVFt/h2LiKcGFNGDksC3Uhzb0JK1Ih1n4U2
 hqFW0tVxYo0Mkezxhbfcqk4fuzmgichMCrqHd6rIbL1stFuCGLMs/mlmgdlpXZ2s1LDVLqBSEmoDZ
 HaXuS8u6vuM+VTcQJcnLdsgDs8AdALmQFfoizNVKhjOw4n2uxHFtTqL7Wnm3rYZG9TbY1wGzvr0vP
 yOx5Lj9pAhar/j2dehgkRtqGBbfeKYdnMSPA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xODcM-001Cn2-0r; Tue, 03 Nov 2026 13:27:58 +0100
Message-ID: <589bbf64-9781-418f-a35c-8a8ed27281f3@igalia.com>
Date: Tue, 3 Nov 2026 12:27:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with
 the userptr object flag
To: "Francis, David" <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-5-tvrtko.ursulin@igalia.com>
 <CHAPR12MB9992476693CFD1600BBC10AF38EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CHAPR12MB9992476693CFD1600BBC10AF38EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 28/10/2026 18:27, Francis, David wrote:
>> +       union {
>> +               /* physical start_addr alignment in bytes for some HW requirements */
>> +               __u64 alignment;
>> +
>> +               /* drm_amdgpu_gem_userptr.addr for userptr objects */
>> +               __u64 userptr;
>> +       };
> 
> Would appreciate comments here making it explicit when this field should be interpreted each
> way - something like
> /* When AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR is not set */

Makes sense, marking as TODO for next respin.


> With that change, patch is
> Reviewed-by: David Francis <David.Francis@amd.com>

Ty!

Tvrtko

> ________________________________________
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Sent: Monday, October 19, 2026 9:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: kernel-dev@igalia.com; Francis, David; Koenig, Christian; Alex Deucher; Kuehling, Felix; Tvrtko Ursulin
> Subject: [PATCH v4 4/7] drm/amdgpu: Extend listing of buffer handles with the userptr object flag
> 
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 21 +++++++++++++++------
>   include/uapi/drm/amdgpu_drm.h           | 14 ++++++++++----
>   2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 385be1e0944c..e3d3e205a4fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1267,14 +1267,23 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> 
>                  bo_entry = &bo_entries[bo_index];
> 
> -               bo_entry->size = amdgpu_bo_size(bo);
> -               bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> -               bo_entry->preferred_domains = bo->preferred_domains;
>                  bo_entry->gem_handle = id;
> -               bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
> +               bo_entry->size = amdgpu_bo_size(bo);
> +               if (amdgpu_ttm_tt_is_userptr(bo->tbo.ttm)) {
> +                       u32 flags;
> 
> -               if (bo->tbo.base.import_attach)
> -                       bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +                       bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR;
> +                       amdgpu_ttm_tt_get_userptr(&bo->tbo, &bo_entry->userptr,
> +                                                 &flags);
> +                       bo_entry->alloc_flags = flags;
> +               } else {
> +                       bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> +                       bo_entry->preferred_domains = bo->preferred_domains;
> +                       bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
> +
> +                       if (bo->tbo.base.import_attach)
> +                               bo_entry->flags = AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +               }
> 
>                  bo_index += 1;
>          }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 29009f6aabde..7620d6acfa0a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -851,6 +851,7 @@ struct drm_amdgpu_gem_op {
>   };
> 
>   #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT (1 << 0)
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_USERPTR        (1 << 1)
> 
>   struct drm_amdgpu_gem_list_handles {
>          /* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> @@ -866,7 +867,7 @@ struct drm_amdgpu_gem_list_handles_entry {
>          /* gem handle of buffer object */
>          __u32 gem_handle;
> 
> -       /* Currently just one flag: IS_IMPORT */
> +       /* AMDGPU_GEM_LIST_HANDLES_FLAG_* */
>          __u32 flags;
> 
>          /* Size of bo */
> @@ -875,11 +876,16 @@ struct drm_amdgpu_gem_list_handles_entry {
>          /* Preferred domains for GEM_CREATE */
>          __u64 preferred_domains;
> 
> -       /* GEM_CREATE flags for re-creation of buffer */
> +       /* GEM_CREATE flags for re-creation of buffer or drm_amdgpu_gem_userptr.flags */
>          __u64 alloc_flags;
> 
> -       /* physical start_addr alignment in bytes for some HW requirements */
> -       __u64 alignment;
> +       union {
> +               /* physical start_addr alignment in bytes for some HW requirements */
> +               __u64 alignment;
> +
> +               /* drm_amdgpu_gem_userptr.addr for userptr objects */
> +               __u64 userptr;
> +       };
>   };
> 
>   #define AMDGPU_VA_OP_MAP                       1
> --
> 2.56.0
> 

