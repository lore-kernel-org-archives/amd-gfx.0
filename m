Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC32B109C055
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D11910E82B;
	Wed, 25 Mar 2026 18:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTq7t7VR";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D385210E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:27:38 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-128bae6a35aso1066c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463258; cv=none;
 d=google.com; s=arc-20240605;
 b=GjUTlZ0kiTynQ1Od7X/xjKj11f8BtInp81C+GKvNrN5a61SYCeSEeuM4RvCe7WEvWM
 QXjJ3/XkFaZ/SQDCIcImubQv+uTI9runFeX1nWkrXp+iM3BrGIbPpPmd08KryunK9cB3
 pQFJp0AlXEbgB3dKy35nVLnotedmmnG12j7EODtUqjc9thnq3ImxSN3RkKlVojgfg4sI
 +MVVCC6gmaapa9y8k/YPZjKn7yLYdWdnVivAmHWdI31WHQvHLIoO7QK2mOhtCGUlyQKr
 eokrrEeeCzW+gOi1jb6NcfvXrLSgspbHrSX+IqX9ktkHoasEl52cMSFpxFGNPrsNw/Ek
 nPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RawWRftt8ySkLlXE5RZuVLLvL0ZTV95YFlRv2xD/ADw=;
 fh=+jYedTXkJMLCCAigTiD49Kv1g3JhoyfrqkQ39E6EHwU=;
 b=WEDx8XT0ZRrPyOLBlR3HQ6udsoLLR+Jz8LSWYr/5YqSOhozpJdc/eu/HkPjx1gLRFO
 6l5tYlSBsU4B6iYRmKPGdz+/Wy+oWiOoifYgnUbO9oJ7aSV/HtT8EKzt79W80KqQO02O
 /eUQt24TwNjle7FwqcAgA9afLwLP5Sm6ZNxfXXvJeohL/rK3NQWz7zhQ7F1j6YYCiZ24
 jZhMfGGo7swVXuTJ7Xjxk1lTf7wUU9q4NXW1bJaWJmP2oJTGR6klpdj9Qo4YzdxvcO1Y
 eys5Jw5Eo4td9UgY+yjszK/AvCupfMj1Ew+8xAUUC09E7Im138MPkHSexIochNto3o8g
 9oMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774463258; x=1775068058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RawWRftt8ySkLlXE5RZuVLLvL0ZTV95YFlRv2xD/ADw=;
 b=rTq7t7VRF5y/oFXqs4RN5cwLXBYtDNtwhv6R5rfpYg3kjDPlKYpxBaAi/U55SlIG7W
 3WKei9J859H0h+rxMmVoA00P4o+8hiqVzYHXTclBe0D3+Dfj963SmsV+A6gHnq8D0tOH
 rOxHinqLTwmZOrbhFXOGMeQJ3SVJjwsM37YyMyGqAWpQn4VATyWnCMISNL0ZlyIQGF/w
 ORcCRSsaI6eodMEduY72Usibnu/vA3/fLZv7lyJdaUFyFIiGCUppFizbcqfvNzBAanQp
 jNdT++FZbqnUIAmBXkE6EKgliXWeWTdF2BoY+smeMsPp7fp9RTCSo95zTg64/8yChmqw
 8WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774463258; x=1775068058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RawWRftt8ySkLlXE5RZuVLLvL0ZTV95YFlRv2xD/ADw=;
 b=qKfsRoPupt2TDYyjqBfbGk5e/xIwMEVsvwWX67ef6SaQLM5q3LXlSrTAaDPN9rFTOE
 7Mmw4YLjf7mZpj2Y/gUCvQObp0OS0qj5LRAN4hYxJgObYzWXJvMwWTXi0BH3A/qvOjXx
 ZVcfwPVUKiVcae1sG4mBShJdhwW7OcFzfyTnApRkxYibm9VpTIOPhv4OEOuJn0yIJfwb
 D+rkPKB2PhbmiG1rVZV93VM5XyUlqRGPhOntwRo5MfZ39ezsn6RATpu1rB+vk8mG4Z3H
 2c8zgVlfUnoBkToum8Gzjo8zOw1JOzx0PvTgS70uLp0qcltKGtLJAnnIz1vyMByAaVcY
 K96w==
X-Gm-Message-State: AOJu0YyCw/tTJC8uQn/mVuhWD35EiQcpDlhm3zIm9CjC7GAj3RUEsC3q
 d/4EQ8dRtCGSil/hp9bO+wCFA7U+i6qn+EHiyLdq4za9dxSLCtVmyeK38SGJ+3ultZnuPZEEwAS
 xCZgZ8ToMvAmrITU39fgONCCrNy6fxcc=
X-Gm-Gg: ATEYQzxwX52S1CkmgS4c1hqdHNj0n0C7aCcY4ONgiLOEmLrq7Duqm8PYFaMjWKUIaKm
 qb5bqxZ4opjAUEnAkytM4ddbP7AvpyOs6aBY2G9Tf2yC0xm+Ny18Sjo5WFv3bjr60Wi86u369US
 iwnHNgvvnsH0SiujqZAdPGzGyetcSpveVV4Jr7bea0skUSXpN2Pr5JDjauLDrddU8FGdZmG5ioI
 THUKQl6g2hNgDFdMRmD87q9Zac5t/1iNLpE9UcqJY3sA2Ld0xB+/hhcOK/U68tMKJOuA3qzaMqp
 YGmZ7Vyctg5usyZgpefMF5u8/7iHdamLMo7qRRnWus8d7xR7R0JJCoRIz6IZS/kPpx/46Dmo065
 ola9k
X-Received: by 2002:a05:7022:628e:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12a96ec2d71mr1056761c88.4.1774463257948; Wed, 25 Mar 2026
 11:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2026 14:27:26 -0400
X-Gm-Features: AaiRm50rtz3uWUD2qltMQ9HNCEbh-cF5gmmTQQV7xsebkEmgHxm3ivd80pkfhWI
Message-ID: <CADnq5_OqAtD9TJH3iHQ+iqRQBS5wi93VeiYodDEJ3Zh5CMgzFQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: Add reserved region ids
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Feifei.Xu@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 25, 2026 at 10:24=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Add reserved regions and helper functions to memory manager.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 58 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 31 +++++++++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 714fd8d12ca5..7f04e53983b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1677,6 +1677,64 @@ static struct ttm_device_funcs amdgpu_bo_driver =
=3D {
>         .access_memory =3D &amdgpu_ttm_access_memory,
>  };
>
> +void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
> +                               enum amdgpu_resv_region_id id,
> +                               uint64_t offset, uint64_t size,
> +                               bool needs_cpu_map)
> +{
> +       struct amdgpu_vram_resv *resv;
> +
> +       if (id >=3D AMDGPU_RESV_MAX)
> +               return;
> +
> +       resv =3D &adev->mman.resv_region[id];
> +       resv->offset =3D offset;
> +       resv->size =3D size;
> +       resv->needs_cpu_map =3D needs_cpu_map;
> +}
> +
> +int amdgpu_ttm_reserve_vram(struct amdgpu_device *adev,
> +                           enum amdgpu_resv_region_id id)
> +{
> +       struct amdgpu_vram_resv *resv;
> +       int ret;
> +
> +       if (id >=3D AMDGPU_RESV_MAX)
> +               return -EINVAL;
> +
> +       resv =3D &adev->mman.resv_region[id];
> +       if (!resv->size)
> +               return 0;
> +
> +       ret =3D amdgpu_bo_create_kernel_at(adev, resv->offset, resv->size=
,
> +                                        &resv->bo,
> +                                        resv->needs_cpu_map ? &resv->cpu=
_addr : NULL);
> +       if (ret) {
> +               dev_dbg(adev->dev, "reserve vram failed: id=3D%d offset=
=3D0x%llx size=3D0x%llx ret=3D%d\n",
> +                       id, resv->offset, resv->size, ret);
> +               memset(resv, 0, sizeof(*resv));
> +       }
> +
> +       return ret;
> +}
> +
> +void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,

Maybe use something other than reserve/unreserve in the names?  I feel
like that might cause confusion with amdgpu_bo_reserve/unreserve().

> +                              enum amdgpu_resv_region_id id)
> +{
> +       struct amdgpu_vram_resv *resv;
> +
> +       if (id >=3D AMDGPU_RESV_MAX)
> +               return;
> +
> +       resv =3D &adev->mman.resv_region[id];
> +       if (!resv->bo)
> +               return;
> +
> +       amdgpu_bo_free_kernel(&resv->bo, NULL,
> +                             resv->needs_cpu_map ? &resv->cpu_addr : NUL=
L);
> +       memset(resv, 0, sizeof(*resv));
> +}
> +
>  /*
>   * Firmware Reservation functions
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index bf101215757e..b73f65a4bc0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -59,6 +59,26 @@ struct amdgpu_ttm_buffer_entity {
>         u64                     gart_window_offs[2];
>  };
>
> +enum amdgpu_resv_region_id {
> +       AMDGPU_RESV_STOLEN_VGA,
> +       AMDGPU_RESV_STOLEN_EXTENDED,
> +       AMDGPU_RESV_STOLEN_RESERVED,
> +       AMDGPU_RESV_FW,
> +       AMDGPU_RESV_FW_EXTEND,
> +       AMDGPU_RESV_FW_VRAM_USAGE,
> +       AMDGPU_RESV_DRV_VRAM_USAGE,
> +       AMDGPU_RESV_MEM_TRAIN,
> +       AMDGPU_RESV_MAX
> +};
> +
> +struct amdgpu_vram_resv {
> +       uint64_t                offset;
> +       uint64_t                size;
> +       struct amdgpu_bo        *bo;
> +       void                    *cpu_addr;

Maybe cpu_ptr?

Other than those comments, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +       bool                    needs_cpu_map;
> +};
> +
>  struct amdgpu_mman {
>         struct ttm_device               bdev;
>         struct ttm_pool                 *ttm_pools;
> @@ -105,6 +125,8 @@ struct amdgpu_mman {
>         struct amdgpu_bo        *drv_vram_usage_reserved_bo;
>         void            *drv_vram_usage_va;
>
> +       struct amdgpu_vram_resv         resv_region[AMDGPU_RESV_MAX];
> +
>         /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>         struct amdgpu_bo        *sdma_access_bo;
>         void                    *sdma_access_ptr;
> @@ -171,6 +193,15 @@ void amdgpu_vram_mgr_clear_reset_blocks(struct amdgp=
u_device *adev);
>  bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>                             struct ttm_resource *res);
>
> +void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
> +                               enum amdgpu_resv_region_id id,
> +                               uint64_t offset, uint64_t size,
> +                               bool needs_cpu_map);
> +int amdgpu_ttm_reserve_vram(struct amdgpu_device *adev,
> +                           enum amdgpu_resv_region_id id);
> +void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,
> +                              enum amdgpu_resv_region_id id);
> +
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
>  void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
> --
> 2.49.0
>
