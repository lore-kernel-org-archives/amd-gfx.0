Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54006CA6017
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 12:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F5410EBD9;
	Sat, 10 Oct 2026 12:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="eQBr+X+0";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C1C10E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 19:58:41 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-5352a876d5aso935461cf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2026 12:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791575920; cv=none;
 d=google.com; s=arc-20260327;
 b=UDK3p97BtXXPwwyqsu0N2Pac5uYzAbTH8J1o/10LiCtTRz3eYaiCp5QfxkxlcxJLVy
 +GsEqYQ1BKQXxWTTnkjuhVSauJxvRcrpm3koq3lQSAzS3kZr/kX521pktb7SPgC7GIsZ
 Ol0bWCEuOq+CckxDM7c9yqjAckjEN3KQ3Wr0cbDytTHReRhGlgAiY+ffvGANATukvDtv
 VJaqpKs4wqVkY/4UWbtLB7KeGpWIQ6kt6Cqeo1BENJZw6Bo+UweNcGYVko3TBR/pZEOw
 sylychWIvu9hWNiSy+BspkCkDhiwwizLjOqDj7sh/QdBgHA+7h2pPUE+s4akp/qbb849
 qNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b323lMeWzZyrcQFhlnQ9xpwpl54vP96R3/ZTsdqCYHM=;
 fh=yLi1qkBEjI4hWx4ctoYIepIWyfytajmK327yLlpTOGM=;
 b=qNX3H9eFjAsIwvNykmEQM0B/A5Nvklqj/M3EBfu4+OQVs8fK353K9iToBQ7aY7eJ9M
 akKCHSCzxh7uKD6n0eM1qgomqMXCpoOIc97kUtGZzkDhjuicndDYYtLtfSeJ/GtWDc8H
 jJv7IkM0r3ddhY1PHg9KbOrDb/a2xHa8Oie8gd+SumMT8289dvSmUW7EEHjhHP9PvS2E
 YEXgJpz0+bKqg/v5/+q2J9Yt/R6v+S14Qofk/UHilB86LV76gBXJnMiIq44yzGzbSdm7
 i+2WlAANkdYr6IwYXpmkpIUZftbTzHRJ28imdddqlYtHoPISf32w9PslzN2e12+YfDND
 RSHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1791575920; x=1792180720;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b323lMeWzZyrcQFhlnQ9xpwpl54vP96R3/ZTsdqCYHM=;
 b=eQBr+X+00CAWgywBHtYhON3w/S3E+L/OL955aYitSZmqTzsdkbX1Hab/DxO47jRGHU
 KElap1F66rUd96MO643KMvBjXoZ4sO3Ddxk11mQChJ9uw2iWOSDIGYXpzP2khPv2e+gj
 eVvUMutfmedsL9qgg4g0zVEYVKCG2pk6y+RkihgUFmXXHXBUSdXcAm/ZMdVbeSd4oTOl
 aAOy7ttGCrPhJtJBIL1EHLhWNBFFjxW+1I3+xmVhKOwzd8H9tsUiA0ggy0MHAWw+te07
 1mvZRvDQr6mlTk0G+bbfuX1ZGaOUJeRIugihVdf6IKxJ5oKz065f9LVYvjHhXN3a/naI
 kB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791575920; x=1792180720;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b323lMeWzZyrcQFhlnQ9xpwpl54vP96R3/ZTsdqCYHM=;
 b=cY7A8qqiB9xji0kwkUn9puYMoYVX6ic8Ok/xnq1BwMPqktvh/wb+ieLZRvZnU2WREj
 VsEytbLVrNpKG6kO3QULWborD9yula47cCWbeA1/t5v3Zs/sXJXzgQRR66KMb4R2c+xg
 /9kNhS2jJRQO4DxUyIqJ2Ln1OawmLuysJsHF0TMA0OjMWAAueL6pUsT2GSkF9NXjuTdC
 Ee7VdOMRjopiojXTU/o8lOoQkGmtJAhWzR8bQrRCBSyYPYsWxRNMS4qqL4P6GvBN9XYe
 SgnF2RJQ+TBJP4C5VQIrmh56VSTVfvBQAnyO11smSt5FtpVTOq6fn8EmihMkOckHthGo
 hr2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwF5MaN5SpQ9EMdab1VSrCbqkaCVzSeXP85prqI4wpnSSxD/+r/CYJua6n77fJmsKGZSjRedKrs@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrgy2absCK3omlLwLrhLqCR9K4dQfdDilQpV6nWBM8zuP1h5NV
 QAen6/s/Rk1ypKGkjPeE7N4ktMoEgIa/vcSgrpnIuXukOBePskKbv5ND7zuTEUWIzpk0VFu2D0G
 e346Y7kgU5KnzimsEE4U7JE2Fcb5xr2js+En2rXvbtA==
X-Gm-Gg: AYBFou1zjsGHOeqI4Rie4oTRxelB0YWx3QGw73EbAOca6OidQZT5wXNU8Pkk/2kWa/0
 dbI8Nsc0XSCMSOOb6vxgmy9EqtuBawkifyHyu1Iz1urbxXxfGgS6BaiL9AgqUNT0NyDrit+yEGl
 l3KZ3Tqls08noTPWNZcOR3/pgMtX60Bl7Edg9XAOnVxjEYHw2mX6arZf4YQELeiwM40c5YqiO25
 4h3YYsHJSG4MoUxupAQR07LmWf4Xx8BKYewVUCpgAAYEN3jq/LVLOEMp01udoLPWyKJsCLQFSzz
 WtHa6kBvk4HIarFNUDTPzuTF/m0noYiXuZyVTao8R108kxMhcsepSF1nfoiJ7jCHGrI7HcI/ypt
 za9stAHH4w/PQ
X-Received: by 2002:a05:622a:4d07:b0:531:11ac:23d8 with SMTP id
 d75a77b69052e-5359fba60edmr44281441cf.49.1791575920528; Fri, 09 Oct 2026
 12:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <01534506-891e-4d0d-8d0c-fb5e82264c03@jqluv.com>
 <01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com>
 <90be0ade-a7d3-45bc-b83a-4d28c1b6bcf6@amd.com>
In-Reply-To: <90be0ade-a7d3-45bc-b83a-4d28c1b6bcf6@amd.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Fri, 9 Oct 2026 12:58:28 -0700
X-Gm-Features: AclHuK-h5nomg0pWq8bvGIG1S4tweTtJzMZ4Yk4pFyM9nfR4mtpQOooA9J7J3_Q
Message-ID: <CAGpo2mcVd-nyCaQUarWj0ghSms0odRQBAWw-3K_12cNyeXwqug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: place GFX12 compute queue MQDs in CPU-visible
 VRAM
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="00000000000054e17a065d6dc667"
X-Mailman-Approved-At: Sat, 10 Oct 2026 12:37:50 +0000
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

--00000000000054e17a065d6dc667
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 11:00=E2=80=AFAM Felix Kuehling <felix.kuehling@amd.=
com>
wrote:

>
> On 2026-10-09 03:07, Christian K=C3=B6nig wrote:
>
> On 10/9/26 00:11, Geramy Loveless wrote:
>
> KFD sub-allocates the MQD of every GFX12 user compute queue from its
> GTT pool, so the MQD is in system memory. The CP accesses the MQD while
> it runs the queue. A dispatch that exactly fills a shader engine is
> retired through a path that accesses the MQD, so with the MQD in system
> memory that dispatch pays the PCIe/host-link latency.
>
> Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
> PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
> threads:
>
>   - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
>     workgroups.
>   - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the =
same amdgpu code under a
>     different host OS: 51 us with the MQD in system memory, 17 us with
>     the MQD in VRAM.
>
> On dGPUs, allocate GFX12 compute queue MQDs with
> amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
> the BO is placed in the CPU-visible part of VRAM, which is needed
> because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
> at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
> and in a new update_mqd_gpu_addr().
>
> Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
> (unpin at suspend, repin on resume) covers these MQDs, and implement
> update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
> a repin.
>
> This follows existing practice: KFD already places compute queue MQDs
> in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
> amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
> (amdgpu_gfx_mqd_sw_init()).
>
> Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
> unchanged, as are APUs that prefer GTT.
>
> Testing: compile-tested on amd-staging-drm-next. The patched kernel has
> not been measured on Linux yet; the VRAM number above is from the other
> host OS.
>
> for macos r9700 support reference where i prove the gains:https://github.=
com/lemonade-sdk/mac_linuxgpu
>
> Absolutely clear NAK!
>
> You are missing tons and I mean litterally hundreds of technical pre-requ=
isites of doing this.
>
> Keep in mind that VRAM is not coherent, you need HDP flushes and iosys_ma=
p() handling for all memory accesses to the MQD for that to work correctly.
>
> We have some internal patches to do this, but IIRC they are still not ful=
l stable.
>
> This is already enabled on some GFX9 HW:
>

So then the GFX9 patch only needs to be applied to GFX12 then?

> commit d4a814f400d4f3bd1e52f9b82e7d1f11b2721cf8
> Author: Philip Yang <Philip.Yang@amd.com> <Philip.Yang@amd.com>
> Date:   Thu Nov 20 16:43:04 2025 -0500
>
>     drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
>
>     To reduce queue switch latency further, move MQD to VRAM domain, CP
>     access MQD and control stack via FB aperture, this requires contiguou=
s
>     pages.
>
>     After MQD is initialized, updated or restored, flush HDP to guarantee
>     the data is written to HBM and GPU cache is invalidated, then CP will
>     read the new MQD.
>
>     Signed-off-by: Philip Yang <Philip.Yang@amd.com> <Philip.Yang@amd.com=
>
>     Reviewed-by: Felix Kuehling <felix.kuehling@amd.com> <felix.kuehling@=
amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com> <alexander.de=
ucher@amd.com>
>
> Regards,
>   Felix
>
>
>
> Regards,
> Christian.
>
>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com> <gloveless@jqluv.com=
>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_mqd_manager.c
> index 9b7859a77..e6b45950e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
>  	case IP_VERSION(9, 4, 3):
>  	case IP_VERSION(9, 4, 4):
>  	case IP_VERSION(9, 5, 0):
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
>  		return true;
>  	default:
>  		return false;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031..d3a8c2aed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_man=
ager *mm,
>  	return mqd_mem_obj;
>  }
>
> +/*
> + * The CP accesses the MQD while the queue is running, so keep compute q=
ueue
> + * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
> + */
> +static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
> +					   struct queue_properties *q)
> +{
> +	u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
> +	struct amdgpu_device *adev =3D mm->dev->adev;
> +	struct kfd_mem_obj *mqd_mem_obj;
> +	struct amdgpu_bo *bo =3D NULL;
> +
> +	if (!mqd_on_vram(adev))
> +		return allocate_mqd(mm, q);
> +
> +	mqd_mem_obj =3D kzalloc_obj(*mqd_mem_obj);
> +	if (!mqd_mem_obj)
> +		return NULL;
> +
> +	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM, &bo,
> +				    &mqd_mem_obj->gpu_addr,
> +				    (void **)&mqd_mem_obj->cpu_ptr)) {
> +		kfree(mqd_mem_obj);
> +		return NULL;
> +	}
> +	mqd_mem_obj->mem =3D bo;
> +
> +	return mqd_mem_obj;
> +}
> +
>  static void init_mqd(struct mqd_manager *mm, void **mqd,
>  			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>  			struct queue_properties *q)
> @@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void =
*mqd,
>  	set_priority(m, q);
>
>  	q->is_active =3D QUEUE_IS_ACTIVE(*q);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +				struct kfd_mem_obj *mqd_mem_obj,
> +				struct queue_properties *qp)
> +{
> +	struct v12_compute_mqd *m =3D get_mqd(mqd);
> +	u64 addr =3D mqd_mem_obj->gpu_addr;
> +
> +	m->cp_mqd_base_addr_lo =3D lower_32_bits(addr);
> +	m->cp_mqd_base_addr_hi =3D upper_32_bits(addr);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
>
>  static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
> @@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void =
**mqd,
>  		*gart_addr =3D addr;
>
>  	qp->is_active =3D 0;
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
>
>  static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
> @@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD=
_TYPE type,
>  	switch (type) {
>  	case KFD_MQD_TYPE_CP:
>  		pr_debug("%s@%i\n", __func__, __LINE__);
> -		mqd->allocate_mqd =3D allocate_mqd;
> +		mqd->allocate_mqd =3D allocate_cp_mqd;
>  		mqd->init_mqd =3D init_mqd;
>  		mqd->free_mqd =3D kfd_free_mqd_cp;
>  		mqd->load_mqd =3D load_mqd;
> @@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD=
_TYPE type,
>  		mqd->get_wave_state =3D get_wave_state;
>  		mqd->mqd_stride =3D kfd_mqd_stride;
>  		mqd->restore_mqd =3D restore_mqd;
> +		mqd->update_mqd_gpu_addr =3D update_mqd_gpu_addr;
>  #if defined(CONFIG_DEBUG_FS)
>  		mqd->debugfs_show_mqd =3D debugfs_show_mqd;
>  #endif
>
>

--00000000000054e17a065d6dc667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 9, 2026 at 11:00=E2=80=AFAM=
 Felix Kuehling &lt;<a href=3D"mailto:felix.kuehling@amd.com">felix.kuehlin=
g@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><u></u>

 =20
  <div>
    <p><br>
    </p>
    <div>On 2026-10-09 03:07, Christian K=C3=B6nig
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre style=3D"font-family:monospace">On 10/9/26 00:11, Geramy Loveles=
s wrote:
</pre>
      <blockquote type=3D"cite">
        <pre style=3D"font-family:monospace">KFD sub-allocates the MQD of e=
very GFX12 user compute queue from its
GTT pool, so the MQD is in system memory. The CP accesses the MQD while
it runs the queue. A dispatch that exactly fills a shader engine is
retired through a path that accesses the MQD, so with the MQD in system
memory that dispatch pays the PCIe/host-link latency.

Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
threads:

  - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
    workgroups.
  - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the sa=
me amdgpu code under a
    different host OS: 51 us with the MQD in system memory, 17 us with
    the MQD in VRAM.

On dGPUs, allocate GFX12 compute queue MQDs with
amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
the BO is placed in the CPU-visible part of VRAM, which is needed
because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
and in a new update_mqd_gpu_addr().

Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
(unpin at suspend, repin on resume) covers these MQDs, and implement
update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
a repin.

This follows existing practice: KFD already places compute queue MQDs
in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
(amdgpu_gfx_mqd_sw_init()).

Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
unchanged, as are APUs that prefer GTT.

Testing: compile-tested on amd-staging-drm-next. The patched kernel has
not been measured on Linux yet; the VRAM number above is from the other
host OS.

for macos r9700 support reference where i prove the gains:
<a href=3D"https://github.com/lemonade-sdk/mac_linuxgpu" target=3D"_blank" =
style=3D"font-family:monospace">https://github.com/lemonade-sdk/mac_linuxgp=
u</a>
</pre>
      </blockquote>
      <pre style=3D"font-family:monospace">Absolutely clear NAK!

You are missing tons and I mean litterally hundreds of technical pre-requis=
ites of doing this.

Keep in mind that VRAM is not coherent, you need HDP flushes and iosys_map(=
) handling for all memory accesses to the MQD for that to work correctly.

We have some internal patches to do this, but IIRC they are still not full =
stable.</pre>
    </blockquote>
    <p>This is already enabled on some GFX9 HW:</p></div></blockquote><div =
dir=3D"auto"><br>So then the GFX9 patch only needs to be applied to GFX12 t=
hen?<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p dir=
=3D"auto"></p>
    <pre style=3D"font-family:monospace">commit d4a814f400d4f3bd1e52f9b82e7=
d1f11b2721cf8
Author: Philip Yang <a href=3D"mailto:Philip.Yang@amd.com" target=3D"_blank=
" style=3D"font-family:monospace">&lt;Philip.Yang@amd.com&gt;</a>
Date:   Thu Nov 20 16:43:04 2025 -0500

    drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
   =20
    To reduce queue switch latency further, move MQD to VRAM domain, CP
    access MQD and control stack via FB aperture, this requires contiguous
    pages.
   =20
    After MQD is initialized, updated or restored, flush HDP to guarantee
    the data is written to HBM and GPU cache is invalidated, then CP will
    read the new MQD.
   =20
    Signed-off-by: Philip Yang <a href=3D"mailto:Philip.Yang@amd.com" targe=
t=3D"_blank" style=3D"font-family:monospace">&lt;Philip.Yang@amd.com&gt;</a=
>
    Reviewed-by: Felix Kuehling <a href=3D"mailto:felix.kuehling@amd.com" t=
arget=3D"_blank" style=3D"font-family:monospace">&lt;felix.kuehling@amd.com=
&gt;</a>
    Signed-off-by: Alex Deucher <a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank" style=3D"font-family:monospace">&lt;alexander.deucher@a=
md.com&gt;</a>

</pre>
    <p>Regards,<br>
      =C2=A0 Felix</p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <pre style=3D"font-family:monospace">
Regards,
Christian.

</pre>
      <blockquote type=3D"cite">
        <pre style=3D"font-family:monospace">Signed-off-by: Geramy Loveless=
 <a href=3D"mailto:gloveless@jqluv.com" target=3D"_blank" style=3D"font-fam=
ily:monospace">&lt;gloveless@jqluv.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index 9b7859a77..e6b45950e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		return true;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031..d3a8c2aed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manag=
er *mm,
 	return mqd_mem_obj;
 }
=20
+/*
+ * The CP accesses the MQD while the queue is running, so keep compute que=
ue
+ * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
+ */
+static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
+					   struct queue_properties *q)
+{
+	u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size);
+	struct amdgpu_device *adev =3D mm-&gt;dev-&gt;adev;
+	struct kfd_mem_obj *mqd_mem_obj;
+	struct amdgpu_bo *bo =3D NULL;
+
+	if (!mqd_on_vram(adev))
+		return allocate_mqd(mm, q);
+
+	mqd_mem_obj =3D kzalloc_obj(*mqd_mem_obj);
+	if (!mqd_mem_obj)
+		return NULL;
+
+	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &amp;bo,
+				    &amp;mqd_mem_obj-&gt;gpu_addr,
+				    (void **)&amp;mqd_mem_obj-&gt;cpu_ptr)) {
+		kfree(mqd_mem_obj);
+		return NULL;
+	}
+	mqd_mem_obj-&gt;mem =3D bo;
+
+	return mqd_mem_obj;
+}
+
 static void init_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void *m=
qd,
 	set_priority(m, q);
=20
 	q-&gt;is_active =3D QUEUE_IS_ACTIVE(*q);
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
+}
+
+static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
+				struct kfd_mem_obj *mqd_mem_obj,
+				struct queue_properties *qp)
+{
+	struct v12_compute_mqd *m =3D get_mqd(mqd);
+	u64 addr =3D mqd_mem_obj-&gt;gpu_addr;
+
+	m-&gt;cp_mqd_base_addr_lo =3D lower_32_bits(addr);
+	m-&gt;cp_mqd_base_addr_hi =3D upper_32_bits(addr);
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
 }
=20
 static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
@@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void **=
mqd,
 		*gart_addr =3D addr;
=20
 	qp-&gt;is_active =3D 0;
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
 }
=20
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
 		pr_debug(&quot;%s@%i\n&quot;, __func__, __LINE__);
-		mqd-&gt;allocate_mqd =3D allocate_mqd;
+		mqd-&gt;allocate_mqd =3D allocate_cp_mqd;
 		mqd-&gt;init_mqd =3D init_mqd;
 		mqd-&gt;free_mqd =3D kfd_free_mqd_cp;
 		mqd-&gt;load_mqd =3D load_mqd;
@@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_T=
YPE type,
 		mqd-&gt;get_wave_state =3D get_wave_state;
 		mqd-&gt;mqd_stride =3D kfd_mqd_stride;
 		mqd-&gt;restore_mqd =3D restore_mqd;
+		mqd-&gt;update_mqd_gpu_addr =3D update_mqd_gpu_addr;
 #if defined(CONFIG_DEBUG_FS)
 		mqd-&gt;debugfs_show_mqd =3D debugfs_show_mqd;
 #endif
</pre>
      </blockquote>
      <pre style=3D"font-family:monospace"></pre>
    </blockquote>
  </div>

</blockquote></div></div>

--00000000000054e17a065d6dc667--
