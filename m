Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42968C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 09:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAED610E400;
	Mon, 11 Aug 2025 09:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="X18oWMjQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9166E10E400
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3uDkAlqi1YGy/EnVE3ilg3kzmpX6jwcYOexwxSIjSwM=; b=X18oWMjQb59Sg0CnlormsyuZby
 NEtCmizx37MaNkpOBNUCi/bLnejEvqn7J0H0nnKA2533Nv8DlzS4cmu/FMkm0/lcj3kcrVasPMD03
 scQNzwfoqMsp0gG5UvRmqBWjGvhxkVAgkIX61ilwqFlImIIT1Xgs9VJ26dNmfnaNwrdDvu2s+VcBs
 QhVRC0CLOSdpW6pC+0axTfc0ymjBxvcm+NgrlUWZdc5zmHPYNJR5F7TgEFXrECavKR935Lm9FeiYd
 sIyqQzCgxNBscCgTG9REpbikyhcpsgYe5v2Neppr5p/P6GoAROmWYrhexbPigSect0S1qTcmc7yqu
 QgDphB5g==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ulPIR-00Ci5y-6Q; Mon, 11 Aug 2025 11:58:27 +0200
Message-ID: <970a605c-32a6-4e3b-982f-69f57c5960b9@igalia.com>
Date: Mon, 11 Aug 2025 10:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 Christian.Koenig@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250807202245.2970262-1-David.Francis@amd.com>
 <20250807202245.2970262-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250807202245.2970262-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 07/08/2025 21:22, David Francis wrote:
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 82 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>   include/uapi/drm/amdgpu_drm.h           | 33 ++++++++++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..f19795dddf9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..7f55e3b7d8a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1032,6 +1032,88 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +/**
> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * num_bos is set as an input to the size of the bo_buckets array.
> + * num_bos is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_handles *args = data;
> +	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);
> +
> +	if (args->num_entries < num_bos) {
> +		args->num_entries = num_bos;
> +		return 0;
> +	}
> +	args->num_entries = num_bos;

Looks like authoritative number is only obtained in the second iteration 
so I think it should be assigned only there.

At least the uapi doc does not suggest ("OUT: Number of handles in 
process (if larger than size of buffer, must retry)" that the count can 
be larger than the actual number of handles, and that handles must also 
be tested for being non-zero. If that is the intention it works as is 
but needs to be documented in the uapi.

> +	if (num_bos == 0)
> +		return 0;
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries) {
> +		ret = -ENOMEM;
> +		goto exit_free;

return -ENOMEM is enough here.

> +	}
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);

Why is this flag special and why it is okay to not restore it?

> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;

Imported ones are only informative (since they will need a completely 
different path to restore)? But it is required to list them? Do you have 
the restore side implemented for reference?

> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	if (!ret) {
> +		ret = copy_to_user((void __user *)args->entries, bo_entries, num_bos * sizeof(*bo_entries));

u64_to_user_ptr()

> +		if (ret) {
> +			pr_debug("Failed to copy BO information to user\n");

I would be tempted to remove this pr_debug since -EFAULT is pretty clear 
anyway. In which case this whole if (ret) block seems superflous.

> +			ret = -EFAULT;
> +		}
> +	}
> +exit_free:
> +	kvfree(bo_entries);
> +
> +	return ret;
> +}
> +
> +
>   static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>   				  int width,
>   				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b51e8f95ee86..7cdb6237bb92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp);
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp);
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>   
>   int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..218a179818d4 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ		0x16
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>   
>   /**
>    * DOC: memory domains
> @@ -811,6 +813,37 @@ struct drm_amdgpu_gem_op {
>   	__u64	value;
>   };
>   
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_list_handles {
> +	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> +	__u64   entries;
> +
> +	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */
> +	__u32   num_entries;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_handles_entry {
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;
> +
> +	/* Pending how to handle this; provides information needed to remake the buffer on restore */
> +	__u32 preferred_domains;

Hm, just as an observation, the width for these is not very well defined 
in the uapi. Yes flags are just a few, but for example 
drm_amdgpu_gem_create_in has them as u64 and also value via 
AMDGPU_GEM_OP_SET_PLACEMENT. So maybe future proofing to __u64 wouldn't 
harm here. It would also remove the need to pad the structure.

Regards,

Tvrtko

> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	__u32 padding;
> +};
> +
>   #define AMDGPU_VA_OP_MAP			1
>   #define AMDGPU_VA_OP_UNMAP			2
>   #define AMDGPU_VA_OP_CLEAR			3

