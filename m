Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD4EC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF01A10EC44;
	Wed, 29 Jul 2026 13:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A086UZCN";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3219A10EC44
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 13:54:55 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so64798a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 06:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333295; cv=none;
 d=google.com; s=arc-20260327;
 b=H1BsDCFzj9d3uUnViVgx9QplQkcieU4mQv/kqyByJLWQ0HojSkDP9546ejDIgJOmSd
 9odWT2LS8VaCaDpUs6DFg4l/MC7SYDdGlAhk9aAC9di7Lbd/bj8MaQuKwn2ZnEIEaFz3
 ZJiamcy0yWdlz3W7Y9k3hYkIfEyimevc6gw2+iELJZuojv1baUQh/omWAqArWtSKsD4b
 hpDIzQfF2SLs/yx89ajGbM7vVEgi8xLZPZr4v3zp0YFy6zKMJ5oy7HFRQ92PLpc4wAL2
 j6d4HAJP+ANbyYCz2E9RaTEezyz+mi3F23kqhIx1jBv07rIeKN49qQ2rxq814VTAjO/x
 jo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z/ROWV4Wzd8Aj3AfNKWRT+3zvBReqegFc07fRQnkPOI=;
 fh=0tB5q1u2Hcms08iwOECvTnTawWFAXkdeddoWFM8HgFY=;
 b=lzpYrNFna1wOHCOP1Fi+yMMx142QsGQeKoyeLmhvRUkKG9BpHJ/iHCdAHCp+lLI1lt
 EPTGA+5Ml0l+RwOroFHNrkqBcVdwrgN7cRcbAIo33C+Lp+F1L122hq59SnMUg2WlG5+E
 LqROYwqdEl6sp7RAScByL1dxWuXGnillh5j2KXYfFjE+CnH+nLXRdG60h4vWpSKkoBrW
 Efuj18/fs4rqHuJdUEO8FqWPjqYmNM/5t10OillqcIInKxfmRm38qSdgKPDHAWrhcsdK
 ZzUK1IRDhU2t9h2jbPhyxDrwlfBmzl7SfNTtyX5oB8EmjQUfhKR6u18BFJV23MoUr37+
 sHpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785333295; x=1785938095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z/ROWV4Wzd8Aj3AfNKWRT+3zvBReqegFc07fRQnkPOI=;
 b=A086UZCNEqMeGE4EO2DhWtP/rgG3nyQGUR3dhkMy1UXx2+EkVxEw6dlWA2ZCl2ZZ3A
 eVJQ4+oAsFF3cmOrRtrIhlk1ZNDEtOmvBohY09PkE+HORoED0mFbsXXxoho7hwK0Ir3n
 FLF+uySrleGFibZ/0ErwTe8a+mxTbMdgSxYYA0Ma9pUQ3ow5YqtUka37m8HQ871s3tya
 IPEW4wm+7a+D0A0g/rCRs86kDVTqyWdiUf/U2im4wJmKdO/zRwMmALQlt68m8cErGNJy
 Fgvusk1Sq1Njjal9HEF/aAcbmDDHm97Okgu6mt5Z5Zrt8NDaEnI8+z0TDc8NBI8VsC3X
 Y2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333295; x=1785938095;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/ROWV4Wzd8Aj3AfNKWRT+3zvBReqegFc07fRQnkPOI=;
 b=m/lZyTb6PgsvL8Zak+l4fsMGz0O3iYfQO2XVHlK5L2viS9QXiQL6dIxKqQGPJvXeF4
 9XnYbYUtWnWWACOlZRVob8ytuHYIhuv1JHMLT7sStmde0sJGZDvYKto0ZcS3x+VUrCPl
 yWr/FD3FGyrP2AYbWh5WuzaDqpFKmAa7JrBeCb+HzQXmW/qpqoD4CNaNdHzhJwIx6gbB
 NVd2N0ov34HWgStwpu+AzedgglRDxlpieCatPRc3Lz9TisZJ63XgFkxEruP9b6z6dD7K
 RCYtIWwzrHFdm7CdFipsf1LWuhIakc+bYTk6sQ2mvSXzgn3cwPnj0UF0/ABp6ovgHnc4
 BcCg==
X-Gm-Message-State: AOJu0YxuC3EOfCTvNRcOnqEWA5p7l/yVjpd5W/rkCIsAM13MgAtpwIsS
 PvrcBXqFGPjeC41DERJyJ00byvDh7SdWoTmBtPqRvQ6LaqTcq70zBsFD9jl2z2exB1B2ayy0uFe
 H0t1qci0U33rjNlYiRiNq2Kq4o7at/rty/Q==
X-Gm-Gg: AR+sD12nZ+mjKIGJYwMfkLQBeT7G50MTFtNsuVbVYL9XUeRBVGmnWfOGAbFu5y4kToX
 fFqPBaE1AbXrpp+sHbnXuJEBE93nK5IrESOJ4ub39/85IhnCneDDityGuCMMPjFMb/YDbgOuf4z
 fvYhGPAX3KohydhNaFB5H7jHKZyQeljVZj+88YVe8JBtOsMmci/rkrrw4wXepsaF6XR91rOCfnS
 9jmnElFY8sEm00pvY9QmXlbiOr/Sgi8fG/gwq+57P+E/mIuEO0B5QmdwsDLXqcZVwsYdUijPGdU
 d8gNCvetA+w50Que9BZXrZF8vBICQcAmLSR1DXdXCjWrrI4n4DnNo9gjA25Zvct7Tbtn77fnYQI
 5MTndR9YA/IgYN5vzWgcMjMuvGrEM+wo=
X-Received: by 2002:a17:90b:280e:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-38f6a321a61mr6429012a91.2.1785333294535; Wed, 29 Jul 2026
 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260729120118.1659135-1-lijo.lazar@amd.com>
 <20260729120118.1659135-2-lijo.lazar@amd.com>
In-Reply-To: <20260729120118.1659135-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 09:54:41 -0400
X-Gm-Features: AUfX_mw9aOyZz6n0jxtlNfMG8A8FNYm9GIOP3rOtVNWP7jEN69k36fRiH1gFitQ
Message-ID: <CADnq5_P4K8pGoZncuAx2U1CoEhSFmUbv_wUaR0pSWMkR59BkFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Allocate coredump ring buffers per ring
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 29, 2026 at 8:38=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Allocate each ring buffer separately. A single allocation summing all
> ring sizes can exceed the page allocator's MAX_ORDER limit and fail;
> per-ring buffers stay small enough to satisfy. The existing allocation
> style doesn't capture any ring data if the huge allocation fails.
> Splitting into multiple allocations helps to capture as much data as
> possible for the core dump.
>
> A failed ring is left with a NULL buffer and skipped when formatting.
>
> Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the =
device")
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Assisted-by: Claude Code
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 50 ++++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  3 +-
>  2 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 4dfea36997d4..87e15e39eb30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -343,7 +343,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count,=
 struct amdgpu_coredump_inf
>         struct amdgpu_ip_block *ip_block;
>         struct amdgpu_ring *ring;
>         int ver, i, j;
> -       u32 ring_idx, off;
> +       u32 ring_idx;
>         bool sizing_pass;
>
>         sizing_pass =3D buffer =3D=3D NULL;
> @@ -443,7 +443,6 @@ amdgpu_devcoredump_format(char *buffer, size_t count,=
 struct amdgpu_coredump_inf
>                 for (i =3D 0; i < coredump->num_rings; i++) {
>                         ring_idx =3D coredump->rings[i].ring_index;
>                         ring =3D coredump->adev->rings[ring_idx];
> -                       off =3D coredump->rings[i].offset;
>
>                         drm_printf(&p, "ring name: %s\n", ring->name);
>                         drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask=
: %x\n",
> @@ -452,12 +451,18 @@ amdgpu_devcoredump_format(char *buffer, size_t coun=
t, struct amdgpu_coredump_inf
>                                    ring->buf_mask);
>                         drm_printf(&p, "Ring size in dwords: %d\n",
>                                 ring->ring_size / 4);
> +
> +                       if (!coredump->rings[i].ring_dw) {
> +                               drm_printf(&p, "Ring contents unavailable=
\n");
> +                               continue;
> +                       }
> +
>                         drm_printf(&p, "Ring contents\n");
>                         drm_printf(&p, "Offset \t Value\n");
>
>                         for (j =3D 0; j < ring->ring_size; j +=3D 4)
>                                 drm_printf(&p, "0x%x \t 0x%x\n", j,
> -                                          coredump->rings_dw[off + j / 4=
]);
> +                                          coredump->rings[i].ring_dw[j /=
 4]);
>                 }
>         }
>
> @@ -498,10 +503,12 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset=
, size_t count,
>  static void amdgpu_devcoredump_free(void *data)
>  {
>         struct amdgpu_coredump_info *coredump =3D data;
> +       u32 i;
>
>         kvfree(coredump->formatted);
> +       for (i =3D 0; i < coredump->num_rings; i++)
> +               kvfree(coredump->rings[i].ring_dw);
>         kvfree(coredump->rings);
> -       kvfree(coredump->rings_dw);
>         kvfree(data);
>  }
>
> @@ -543,9 +550,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>         struct amdgpu_coredump_info *coredump;
>         size_t size =3D sizeof(*coredump);
>         struct drm_sched_job *s_job;
> -       u64 total_ring_size, ring_count;
> +       u64 ring_count;
>         struct amdgpu_ring *ring;
> -       int i, off, idx;
> +       int i, idx;
>
>         /* No need to generate a new coredump if there's one in progress =
already. */
>         if (work_busy(&adev->coredump_work))
> @@ -585,7 +592,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>
>         /* Dump ring content if memory allocation succeeds. */
>         ring_count =3D 0;
> -       total_ring_size =3D 0;
>         for (i =3D 0; i < adev->num_rings; i++) {
>                 ring =3D adev->rings[i];
>
> @@ -594,38 +600,34 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol skip_vram_check,
>                     coredump->ring !=3D ring)
>                         continue;
>
> -               total_ring_size +=3D ring->ring_size;
>                 ring_count++;
>         }
> -       if (ring_count) {
> -               coredump->rings_dw =3D kvzalloc(total_ring_size, GFP_NOWA=
IT);
> +       if (ring_count)
>                 coredump->rings =3D kvcalloc(ring_count,
>                                            sizeof(struct amdgpu_coredump_=
ring),
>                                            GFP_NOWAIT);
> -       }
> -       if (coredump->rings && coredump->rings_dw) {
> -               for (i =3D 0, off =3D 0, idx =3D 0; i < adev->num_rings &=
& idx < ring_count; i++) {
> +       if (coredump->rings) {
> +               for (i =3D 0, idx =3D 0; i < adev->num_rings && idx < rin=
g_count; i++) {
> +                       struct amdgpu_coredump_ring *cdump_ring;
> +
>                         ring =3D adev->rings[i];
>
>                         if (atomic_read(&ring->fence_drv.last_seq) =3D=3D=
 ring->fence_drv.sync_seq &&
>                             coredump->ring !=3D ring)
>                                 continue;
>
> -                       coredump->rings[idx].ring_index =3D ring->idx;
> -                       coredump->rings[idx].rptr =3D amdgpu_ring_get_rpt=
r(ring);
> -                       coredump->rings[idx].wptr =3D amdgpu_ring_get_wpt=
r(ring);
> -                       coredump->rings[idx].offset =3D off;
> +                       cdump_ring =3D &coredump->rings[idx];
> +
> +                       cdump_ring->ring_dw =3D kvzalloc(ring->ring_size,=
 GFP_NOWAIT);
> +                       if (cdump_ring->ring_dw)
> +                               memcpy(cdump_ring->ring_dw, ring->ring, r=
ing->ring_size);
>
> -                       memcpy(&coredump->rings_dw[off], ring->ring, ring=
->ring_size);
> -                       off +=3D ring->ring_size / 4;
> +                       cdump_ring->ring_index =3D ring->idx;
> +                       cdump_ring->rptr =3D amdgpu_ring_get_rptr(ring);
> +                       cdump_ring->wptr =3D amdgpu_ring_get_wptr(ring);
>                         idx++;
>                 }
>                 coredump->num_rings =3D idx;
> -       } else {
> -               kvfree(coredump->rings_dw);
> -               kvfree(coredump->rings);
> -               coredump->rings_dw =3D NULL;
> -               coredump->rings =3D NULL;
>         }
>
>         coredump->adev =3D adev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 63f27337c09a..cb874d8c3394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -34,8 +34,8 @@
>  struct amdgpu_coredump_ring {
>         u64                             rptr;
>         u64                             wptr;
> +       u32                             *ring_dw;
>         u32                             ring_index;
> -       u32                             offset;
>  };
>
>  struct amdgpu_coredump_ib_info {
> @@ -53,7 +53,6 @@ struct amdgpu_coredump_info {
>         struct amdgpu_ring              *ring;
>
>         struct amdgpu_coredump_ring     *rings;
> -       u32                             *rings_dw;
>         u32                             num_rings;
>
>         /* Readable form of coredevdump, generate once to speed up
> --
> 2.49.0
>
