Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D3CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 09:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A95710E5D3;
	Tue, 12 Aug 2025 09:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XE5/27rF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648A110E5D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6MZ3N8yZSAvDDvKN7+/0wSCQbQE0Y6DzYkxsXbTemU=; b=XE5/27rFMIghYI6dTCVg2lfBNV
 F7PBx13eiMfDpih6askdgilIScNL4uOqhYTgZ6gG40PUxmXn/SyGpo8qlr/C+lBQFkbzetJZLqKlj
 /P6l27+oxAe4ONsUipw/vKnZW0oh1tQh2hpUtkrj4j848XVc7nzfJSBqeyj9lAz/P6CgzOz6lrGzV
 F1kSZbRHoSn6suTuz/Uo7jBXXKM9+dojYQamK5x88O8pwBQPGnrQKeQcZ4ZBBztwmUvzf/Uc3z5mI
 Ikmz5RV4gnmMgBl4SOd0dvTXlpUpe2uItDpzRgUx0KjtNHrgbBEW49wob+B740B7vjhYY4NvZv9zF
 ZXTQF+SA==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ullIs-00DAsv-BU; Tue, 12 Aug 2025 11:28:22 +0200
Message-ID: <5e3de4f0-b529-4b18-a99d-5c2d592cbb73@igalia.com>
Date: Tue, 12 Aug 2025 10:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 Christian.Koenig@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250811150536.3394262-1-David.Francis@amd.com>
 <20250811150536.3394262-2-David.Francis@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250811150536.3394262-2-David.Francis@amd.com>
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


On 11/08/2025 16:05, David Francis wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 83 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>   include/uapi/drm/amdgpu_drm.h           | 31 +++++++++
>   4 files changed, 117 insertions(+)
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
> index e3f65977eeee..3873d2c19b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1032,6 +1032,89 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
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
> +
> +	if (num_bos == 0) {
> +		args->num_entries = 0;
> +		return 0;
> +	}
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries)
> +		return -ENOMEM;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
> +		/* WIPE_ON_RELEASE is set automatically in the driver; it is not permitted in
> +		 * BO creation. In the interest of giving the user exactly the flags they need
> +		 * to recreate the BO, clear it.
> +		 */

Ha, curious. What is the reason flags userspace cannot use are specified 
in the uapi header?

> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;

I had a question regarding this part in v11. Any comment on that?

Anyway, thanks for implementing the other changes I suggested, this one 
LGTM now.

Regards,

Tvrtko

> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	args->num_entries = bo_index;
> +
> +	if (!ret)
> +		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
> +
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
> index bdedbaccf776..59b423883e91 100644
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
> @@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
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
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* Preferred domains for GEM_CREATE */
> +	__u64 preferred_domains;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +};
> +
>   #define AMDGPU_VA_OP_MAP			1
>   #define AMDGPU_VA_OP_UNMAP			2
>   #define AMDGPU_VA_OP_CLEAR			3

