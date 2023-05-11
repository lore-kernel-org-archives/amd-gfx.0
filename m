Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05FDC77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BFD10E1A8;
	Thu, 11 May 2023 02:23:05 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB64B10E1A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:23:03 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ab074ef787so1742637a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683771782; x=1686363782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BIkQcxk/Eoah4pzrxZYBdWWPGTWnxie7cA3k8HJuk0=;
 b=qm7WsLBjAZXI68PiG0ap3Z/v27gc1+xxXAVfS5JpUOkjzBb8e6CoQf2U5ZdcNLOwS5
 obrDju7YiIZXCIt4bMWWqoijI7r9wbQiYk4LobBjDbihQwB10ivcEdSvQRXqU4cZ/cX3
 09Tu7P22zoJ0EW7TgkUUNVJqgWGjEmSvcNl+j1DsAVEhBuPn323rcrnXWjgi3b+0kRRJ
 m47b41MYy01bmrZ1+GJcPlDXCvJ83Y5ekkHhKZvynYDEnBwUJ2VWBAdEcHKOPWg4hiM2
 dXDGDfFq8pWwvgVdeW4sKgLiDVAoMkYZYSi1St1khuoSR264HpGFrqjVeqTJsMe5mSA5
 DQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683771782; x=1686363782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BIkQcxk/Eoah4pzrxZYBdWWPGTWnxie7cA3k8HJuk0=;
 b=DmJrOanpLiA2n5zJzNF6OdHo02iAr5N16bmzQCiaA2keBijZGybyxWtm1ZUiv/vCCJ
 hsq3gOkZ/djoGSykJVr7u0HKUXzDF1Bl/THi7ddbON+a6jzJ7j/cp5UNgsVKzr5h+9e8
 CP6pUOPykyqTGTuhIcl54aeQ2kNmS4dzFOf2kobuLOF9Rb9jO4OSUh8nmA3djukKSVJT
 mM4pLTco7HsKDybCJbQpYyZMHNefcYsJp3C3FsTtzZDA4BRASCK7OtgzaAJVYIMoUuYG
 JkKl5YTePmay7njipxu2jZGOd7fJk0F1+U4XfbjtQP9y+LEAKjtsXDxswLKvKT378864
 dmkg==
X-Gm-Message-State: AC+VfDzNUAl6Hga/CPC3wwAU9+JTC0oG+hpf5AN0SqtLas0PmpjVU61L
 dRdjuF69WROJrnVKz4KDRNFCEK0KCzGOy09b4As=
X-Google-Smtp-Source: ACHHUZ5zHY/7dsva4zOXBczWn5XbbCwJfqEijllfgmAFsgel4snEDRkvFtnURQ3VAGBBoB8BzESdi/+/80n32mlM8H0=
X-Received: by 2002:a05:6808:b06:b0:390:6a10:c9f3 with SMTP id
 s6-20020a0568080b0600b003906a10c9f3mr4133312oij.18.1683771782492; Wed, 10 May
 2023 19:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230509140307.1369211-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230509140307.1369211-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 May 2023 22:22:51 -0400
Message-ID: <CADnq5_PinNGapPcPxDdinjWPqkoM=th_f_1-yfeGSbau8cyZ2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu _object, _ring.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 9, 2023 at 10:03=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix below warnings reported by checkpatch:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: static const char * array should probably be static const char *=
 const
> WARNING: space prohibited between function name and open parenthesis '('
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using=
 octal permissions '0444'.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  9 ++++-----
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 7c9b788ae0a9..fbd906ac556e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -130,7 +130,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo=
 *abo, u32 domain)
>         u32 c =3D 0;
>
>         if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> -               unsigned visible_pfn =3D adev->gmc.visible_vram_size >> P=
AGE_SHIFT;
> +               unsigned int visible_pfn =3D adev->gmc.visible_vram_size =
>> PAGE_SHIFT;
>
>                 places[c].fpfn =3D 0;
>                 places[c].lpfn =3D 0;
> @@ -935,7 +935,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u3=
2 domain,
>                 bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>         amdgpu_bo_placement_from_domain(bo, domain);
>         for (i =3D 0; i < bo->placement.num_placement; i++) {
> -               unsigned fpfn, lpfn;
> +               unsigned int fpfn, lpfn;
>
>                 fpfn =3D min_offset >> PAGE_SHIFT;
>                 lpfn =3D max_offset >> PAGE_SHIFT;
> @@ -1016,7 +1016,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>         }
>  }
>
> -static const char *amdgpu_vram_names[] =3D {
> +static const char * const amdgpu_vram_names[] =3D {
>         "UNKNOWN",
>         "GDDR1",
>         "DDR2",
> @@ -1148,8 +1148,8 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *b=
o, u64 *tiling_flags)
>   * Returns:
>   * 0 for success or a negative error code on failure.
>   */
> -int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
> -                           uint32_t metadata_size, uint64_t flags)
> +int amdgpu_bo_set_metadata(struct amdgpu_bo *bo, void *metadata,
> +                          u32 metadata_size, uint64_t flags)
>  {
>         struct amdgpu_bo_user *ubo;
>         void *buffer;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index a1d480b7fd1f..7429b20257a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -78,7 +78,7 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type =
type)
>   * Allocate @ndw dwords in the ring buffer (all asics).
>   * Returns 0 on success, error on failure.
>   */
> -int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw)
> +int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
>         /* Align requested size with padding so unlock_commit can
>          * pad safely */
> @@ -315,9 +315,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,
>                      amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs=
->emit_ib_size;
>         max_ibs_dw =3D (max_ibs_dw + ring->funcs->align_mask) & ~ring->fu=
ncs->align_mask;
>
> -       if (WARN_ON(max_ibs_dw > max_dw)) {
> +       if (WARN_ON(max_ibs_dw > max_dw))
>                 max_dw =3D max_ibs_dw;
> -       }
>
>         ring->ring_size =3D roundup_pow_of_two(max_dw * 4 * sched_hw_subm=
ission);
>
> @@ -591,7 +590,7 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *a=
dev,
>         char name[32];
>
>         sprintf(name, "amdgpu_ring_%s", ring->name);
> -       debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
> +       debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
>                                  &amdgpu_debugfs_ring_fops,
>                                  ring->ring_size + 12);
>
> @@ -601,7 +600,7 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *a=
dev,
>
>         if (ring->mqd_obj) {
>                 sprintf(name, "amdgpu_mqd_%s", ring->name);
> -               debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, r=
ing,
> +               debugfs_create_file_size(name, S_IFREG | 0444, root, ring=
,
>                                          &amdgpu_debugfs_mqd_fops,
>                                          ring->mqd_size);
>         }
> --
> 2.25.1
>
