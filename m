Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323CCA5FA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 19:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8437510EB98;
	Mon, 28 Sep 2026 19:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/vRZOm6";
	dkim-atps=neutral
Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com
 [74.125.227.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35DA10EB98
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 19:09:03 +0000 (UTC)
Received: by mail-vs2-f39.google.com with SMTP id
 71dfb90a1353d-5ccb36d5a57so1774462e0c.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790622542; x=1791227342; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mY6h9A6Ya+GuTYW0wJWp5XBS/gk+NwaHDWAqJr/5Yus=;
 b=b/vRZOm6VOx7p6ffkka1KDnjwfWjGAPo2/uyk6FOKkFWzRbpBoTSGWy1RYYkmP/uEM
 UrtJPU6ukO0VxOv3tqDGR64Fa3+G17ohnt6IZloihs9K+FaV/t2chO6R7pFa+ISdrmE/
 bny98/sIaYjclhkHG8fxF4LfmGpO6N8XdUEFvBmc5S9Zb8PuptEc5OcvQyrRCvHx7fhe
 /JqOwOkMLl1JaHIf/HIlDIy6/UgkT0er6wFEqNcoqhTgHHbHhNt8OcbXR69neWs018Ld
 JrURe2WSjXP7g2tdgIsfTlwMpaToza/vd/pLMmTc4xs2M03N/rnUTviAjutvmF6tQ6AD
 Utig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622542; x=1791227342;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mY6h9A6Ya+GuTYW0wJWp5XBS/gk+NwaHDWAqJr/5Yus=;
 b=a/Ax90iknDJtl6qF6h7/9TBaORPrNoH1xMtbP4vYocwbW06iBgsMTcgQNzS6anq0mm
 qOBk3qNXWanxcP9ICWiHn5WM8D7XdAJCYCh1y6XMsAh5UUaNzhHvyeGNC5RYURhKzIOm
 SP7ySg1IofBFU2WSxaXeD6kdJhNPSEvzGGV38Hi6/3NbybBeCEkKQfhLCUJmCn//mmbz
 D8fL1Z69dxS2JDK777HoOZhrVKhgdPYfV92bZAuBbRRyiwANGqPp4lYvlVVHeL6pdddM
 LaVfL6Mtlo78aFuD5QtDHYJfSX9GUEpA/SIxlJthI5fZP98ZKPR8j4DpjY2H9woFY4n3
 Paeg==
X-Gm-Message-State: AFq9FYIIlKgOalajkoIIU7tHMjjBMCAyx1rgG+mwIlNmp8VOvpsURNSV
 VJhSKPGjub5mV6rJAQbULpJfKdCGz+Oxb0B0QwsJwkxlLBIp9tzVVEk6
X-Gm-Gg: AYBFou1EebNNKXq6vxqlTLhTvCmLbJO1bN7J7bB9qz2bQbwr6HhYg7cStsKN1He625Q
 Cc7OWur8WIXIAgaGzvsWdPotXnURz4vmeZK4wJ5SUtJOqpreDwzNIs1rQXZf3Zis+lLTZYL3u15
 /36n4xuikARwYLjh3Lzez/ERItGaz3uHE1VAwnbeFpUKtnk0pW78+iOwlWnE/xoPNz6VNfvN0PW
 b+vaFj1P2IapLJGrdtrFHPkMeB6sVilV7eaIzl8DM/zfHWZz882PtqIaPBwzu8GKyw7sax2FJp7
 +YIwcquNN7+dPrwuBU1bhvLdJIzG/guaMEHF0O+a77vhnKMqKPw+1B0t60BTQRDfnS8z0jEIst2
 Z6pPJ022sTlZ17onvqPlE1RW7SlAPklw34I6jfnMJyUwwTOfN/yr3vSpuABfBt833+114y2iSfM
 ow1asPZbUN5ovnOux2pVMZ9kKKNBQUMw6YCgu5SHwtakPvwdZBsEpeJce+9bHr4Ykn0dGWJkIO8
 OckdfFjT6PIzsWZ4I6agi2/XiFPdGCHbkfrqhCIeEdGGBACRJ/sN4fbaOHIrQs13fY1XtopLBep
 OQ3uiPMfG/gRN66iWIcZ
X-Received: by 2002:a05:6102:1495:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7b547005e03mr1071302137.31.1790622542621; 
 Mon, 28 Sep 2026 12:09:02 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9889b08af8asm7791029241.3.2026.09.28.12.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:09:02 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 6/9] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_pdes
Date: Mon, 28 Sep 2026 15:09:01 -0400
Message-ID: <hMcIZHEgT-KvjFZYjXEj-A@gmail.com>
In-Reply-To: <20260928151041.1857-6-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-6-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. szeptember 28., h=C3=A9tf=C5=91 11:10:38 keleti =C3=A1llamokbeli n=
y=C3=A1ri id=C5=91 Christian=20
K=C3=B6nig wrote:
> That case is handled by amdgpu_vm_update_leaves now.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c       | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  3 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  2 +-
>  8 files changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c index
> a5d1d83ee5d32..cb46111b2dc8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -503,7 +503,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct
> amdgpu_sync *sync) struct amdgpu_device *adev =3D
> amdgpu_ttm_adev(pd->tbo.bdev);
>  	int ret;
>=20
> -	ret =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	ret =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (ret)
>  		return ret;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c index e7a9c2de46131..eef3acfdb7c=
73
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1182,7 +1182,7 @@ static int amdgpu_cs_vm_handling(struct
> amdgpu_cs_parser *p) if (r)
>  		return r;
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c index
> 4e4814caf61a9..86a1239e49149 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -811,7 +811,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	}
>=20
>  	/* Always update PDEs after we touched the mappings. */
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r)
>  		goto error;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c index
> aac97dca36e33..899153716b7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2065,7 +2065,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct
> amdgpu_device *adev, goto out;
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r) {
>  		dev_err(adev->dev,
>  			"Failed %d to update page directories during=20
unmapping NPA: 0x%llx\n",
> @@ -2119,7 +2119,7 @@ static int amdgpu_ualink_map_npa_addr(struct
> amdgpu_device *adev, u64 npa_addr, goto out;
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r) {
>  		dev_err(adev->dev,
>  			"failed %d to update page directories for=20
NPA: 0x%llx\n",
> @@ -2661,7 +2661,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct
> amdgpu_device *adev, break;
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r) {
>  		dev_err(adev->dev,
>  			"Failed %d to update page directories during=20
force retry rpcs\n",
> @@ -2798,7 +2798,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct
> amdgpu_device *adev, break;
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r) {
>  		dev_err(adev->dev,
>  			"Failed %d to update page directories during=20
all NPA addresses
> unmapping\n", @@ -4873,7 +4873,7 @@ static void
> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev) }
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
>  	if (r) {
>  		dev_dbg(adev->dev, "failed %d to update directories\n",=20
r);
>  		goto out_unreserve;
> @@ -5016,7 +5016,7 @@ static int amdgpu_ualink_metadata_npa_mapping(struct
> amdgpu_device *adev) }
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm);
>  	if (r) {
>  		dev_dbg(adev->dev, "failed %d to update directories\n",=20
r);
>  		goto error_npa_mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c index
> 75d5ceaa53c65..cf427037a8303 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1173,7 +1173,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct
> amdgpu_userq_mgr *uq_mgr) goto retry_lock;
>  	}
>=20
> -	ret =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	ret =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (ret)
>  		goto unlock_all;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 017ec0ac0870d..cc6c419ff6f=
a2
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -985,15 +985,13 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t
> *pages_addr, uint64_t addr) *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> - * @immediate: submit immediately to the paging queue
>   *
>   * Makes sure all directories are up to date.
>   *
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> -			  struct amdgpu_vm *vm, bool immediate)
> +int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm *=
vm)
> {
>  	struct amdgpu_vm_update_params params;
>  	struct amdgpu_vm_bo_base *entry, *tmp;
> @@ -1011,7 +1009,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>  	memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
>=20
>  	r =3D vm->update_funcs->prepare(&params, NULL,
>  				     =20
AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index 3ff17625a8c0c..a3556cf6dd5=
25
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -451,8 +451,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct
> amdgpu_job *job, bool *need_pipe_sync, bool *emit_spm_needed,
>  		     bool *emit_gds_needed);
> -int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> -			  struct amdgpu_vm *vm, bool immediate);
> +int amdgpu_vm_update_pdes(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm,
>  			  struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c index 411bd3394442a..af8d2ede183a1
> 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1540,7 +1540,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd,
> struct svm_range *prange, last_start =3D prange->start + i + 1;
>  	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, false);
> +	r =3D amdgpu_vm_update_pdes(adev, vm);
>  	if (r) {
>  		pr_debug("failed %d to update directories 0x%lx\n", r,
>  			 prange->start);




