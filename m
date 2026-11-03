Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09D606A32D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VAuY6gqx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874CA10F55F;
	Tue,  3 Nov 2026 12:38:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E2C10F55F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=OtlWmlHV7MMxELT5iswz8Ziag00ZQ0bXWdPnzqz3v+k=; t=1793709515; x=2109069515; 
 b=VAuY6gqx1YQhKz2a/d4qIPzgwmwToyaSR1Q0xwA7wyvb6U8Ahh6irpKQ/5fiet8nFYLswZ8T3uB
 8oqHzmAmgGAviyYQmWNtawzlohTJV6kb/PWn3Ca5PFk3JDdLR+6EkrUXD9QuqJyANGBtwp6X7aJ7U
 sHsoD1QlKwVy4CgNDc5uE0lRLYXM2QLTe4NZBxm0uXEA1XZKfkJvKak48EyZlFiyGMmvkHgvHHeOr
 K1dY3WxOjzMrCQcSO69BlCWXFT6y6jRw/N1Rg4JWQSFFwzwMIfwudr+wkS8h9KN7AFs3CVvBdW9+5
 SoNyAiADj1k0Ic+w1KrpVpP/4xhWb0aLHp6A==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xODmb-001DJK-Hc; Tue, 03 Nov 2026 13:38:33 +0100
Message-ID: <3cad32b6-d773-4185-a0d9-248cc8a43088@igalia.com>
Date: Tue, 3 Nov 2026 12:38:32 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] drm/amdgpu: Add a new ioctl for listing client
 contexts
To: "Francis, David" <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20261019130159.11739-1-tvrtko.ursulin@igalia.com>
 <20261019130159.11739-6-tvrtko.ursulin@igalia.com>
 <CHAPR12MB99924785371BD43E9F3652DB28EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CHAPR12MB99924785371BD43E9F3652DB28EF6F2@CHAPR12MB999247.namprd12.prod.outlook.com>
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


On 28/10/2026 18:48, Francis, David wrote:
>> +       xa_lock(&mgr->ctx_handles);
>> +       xa_for_each(&mgr->ctx_handles, id, ctx) {
>> +               struct drm_amdgpu_gem_list_contexts_entry *context;
>> +               enum amd_dpm_forced_level level;
>> +
>> +               if (idx >= num) {
>> +                       ret = -EAGAIN;
>> +                       break;
>> +               }
>> +
>> +               kref_get(&ctx->refcount);
>> +               xa_unlock(&mgr->ctx_handles);
> 
> xa_for_each take the read-side xa lock, so not sure if these xa_lock and
> xa_unlock calls do anything.

It's for grabbing the reference safely should userspace try and destroy 
the context from a parallel thread.

>> +       if (!ret)
>> +               if (copy_to_user(u64_to_user_ptr(args->contexts), contexts,
>> +                                num * sizeof(*contexts)))
>> +                       ret = -EFAULT;
> 
> Should be idx, not num, right?
> 
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES     0x19
>>   #define DRM_AMDGPU_PROC_OPTIONS         0x1A
>>   #define DRM_AMDGPU_UALINK_HANDLE        0x1B
>> +#define DRM_AMDGPU_GEM_LIST_CONTEXTS   0x1C
> 
> Might be my e-mail client, but the number of spaces here looks like it doesn't line
> up to me. If it looks right to you with 8-space tabs it probably is.

It's a single tab on my end, and in the original patch on the mailing 
list. Perhaps even Exchange server playing whitespace games on your end?

>> +struct drm_amdgpu_gem_list_contexts_entry {
>> +       /* gem context handle */
>> +       __u32 handle;
>> +
>> +       /* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
>> +       __u32 flags;
> 
> Should probably note that there aren't any of these at the moment

Hmm what was I thinking here.. Probably struct drm_amdgpu_ctx_in.flags 
and not AMDGPU_GEM_LIST_CONTEXTS_FLAG_*. But you are right, there aren't 
any of those currently. Can I adjust kerneldoc to point to struct 
drm_amdgpu_ctx_in->flags.flags? I can send a separate patch which 
documents there are none up there.

Regards,

Tvrtko

> ________________________________________
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Sent: Monday, October 19, 2026 9:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: kernel-dev@igalia.com; Francis, David; Koenig, Christian; Alex Deucher; Kuehling, Felix; Tvrtko Ursulin
> Subject: [PATCH v4 5/7] drm/amdgpu: Add a new ioctl for listing client contexts
> 
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 102 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>   include/uapi/drm/amdgpu_drm.h           |  31 +++++++
>   4 files changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 2f0349233695..5eb156d72db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -723,6 +723,108 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>          return r;
>   }
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
> +                                  struct drm_file *filp)
> +{
> +       struct drm_amdgpu_gem_list_contexts *args = data;
> +       struct drm_amdgpu_gem_list_contexts_entry *contexts;
> +       struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +       struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> +       struct amdgpu_device *adev = mgr->adev;
> +       unsigned long id, idx = 0, num = 0;
> +       struct amdgpu_ctx *ctx;
> +       int ret = 0;
> +
> +       if (args->padding)
> +               return -EINVAL;
> +
> +       xa_for_each(&mgr->ctx_handles, id, ctx)
> +               num++;
> +
> +       if (num == 0 || args->num_contexts < num) {
> +               args->num_contexts = num;
> +               return 0;
> +       }
> +
> +       contexts = kvzalloc_objs(*contexts, num);
> +       if (!contexts)
> +               return -ENOMEM;
> +
> +       xa_lock(&mgr->ctx_handles);
> +       xa_for_each(&mgr->ctx_handles, id, ctx) {
> +               struct drm_amdgpu_gem_list_contexts_entry *context;
> +               enum amd_dpm_forced_level level;
> +
> +               if (idx >= num) {
> +                       ret = -EAGAIN;
> +                       break;
> +               }
> +
> +               kref_get(&ctx->refcount);
> +               xa_unlock(&mgr->ctx_handles);
> +
> +               context = &contexts[idx];
> +
> +               context->handle = id;
> +               context->init_priority = ctx->init_priority;
> +               context->override_priority = ctx->override_priority;
> +
> +               mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> +               if (ctx == adev->pm.stable_pstate_ctx) {
> +                       level = amdgpu_dpm_get_performance_level(adev);
> +
> +                       switch (level) {
> +                       case AMD_DPM_FORCED_LEVEL_AUTO:
> +                               context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_NONE;
> +                               break;
> +                       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +                               context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_STANDARD;
> +                               break;
> +                       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +                               context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
> +                               break;
> +                       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +                               context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
> +                               break;
> +                       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +                               context->pstate_flags = AMDGPU_CTX_STABLE_PSTATE_PEAK;
> +                               break;
> +                       default:
> +                               ret = -EIO;
> +                               break;
> +                       };
> +
> +               }
> +               mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> +
> +               idx++;
> +               amdgpu_ctx_put(ctx);
> +               xa_lock(&mgr->ctx_handles);
> +       }
> +       xa_unlock(&mgr->ctx_handles);
> +
> +       args->num_contexts = idx;
> +
> +       if (!ret)
> +               if (copy_to_user(u64_to_user_ptr(args->contexts), contexts,
> +                                num * sizeof(*contexts)))
> +                       ret = -EFAULT;
> +
> +       kvfree(contexts);
> +
> +       return ret;
> +}
> +
>   struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>   {
>          struct amdgpu_ctx *ctx;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ab6f9131ac11..79d57659d748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3139,7 +3139,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>          DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>          DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
> +       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
> 
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b558336bc4c6..0e17d9fc665f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -69,6 +69,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>                          struct drm_file *filp);
>   int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>                                    struct drm_file *filp);
> +int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
> +                                  struct drm_file *filp);
> 
>   int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>                                  struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 7620d6acfa0a..7f7aae3c2498 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>   #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>   #define DRM_AMDGPU_PROC_OPTIONS                0x1A
>   #define DRM_AMDGPU_UALINK_HANDLE       0x1B
> +#define DRM_AMDGPU_GEM_LIST_CONTEXTS   0x1C
> 
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -83,6 +84,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>   #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
> 
>   /**
>    * DOC: memory domains
> @@ -888,6 +890,35 @@ struct drm_amdgpu_gem_list_handles_entry {
>          };
>   };
> 
> +struct drm_amdgpu_gem_list_contexts {
> +       /* User pointer to array of drm_amdgpu_gem_list_contexts_entry */
> +       __u64 contexts;
> +
> +       /* Size of the contexts buffer / Number of contexts in the client (if larger than size of buffer, must retry) */
> +       __u32 num_contexts;
> +
> +       __u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_contexts_entry {
> +       /* gem context handle */
> +       __u32 handle;
> +
> +       /* AMDGPU_GEM_LIST_CONTEXTS_FLAG_* */
> +       __u32 flags;
> +
> +       /* context initial priority */
> +       __s32 init_priority;
> +
> +       /* context override priority */
> +       __s32 override_priority;
> +
> +       /* pstate flags */
> +       __u32 pstate_flags;
> +
> +       __u32 padding;
> +};
> +
>   #define AMDGPU_VA_OP_MAP                       1
>   #define AMDGPU_VA_OP_UNMAP                     2
>   #define AMDGPU_VA_OP_CLEAR                     3
> --
> 2.56.0
> 

