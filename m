Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D68C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCA510E04D;
	Wed, 29 Jul 2026 13:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e0ogzEVj";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6A810E04D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 13:44:22 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so82876a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 06:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332662; cv=none;
 d=google.com; s=arc-20260327;
 b=HahwBq7jzihIAoxrhM6CVBFsKpTxX6s0onGtltXhR7CourkqRsD642xSxC/BRplkGQ
 mTY1Ows8s0hRRJ5zJ5Im8IkpaDsKnlirCsucZBqXPfmou39godvCxaWmKvpeHSYDvWAf
 5ujStS6b8sGV3jZKVJbnWVvHaJTr6nniedKK/om70JSYyVAmVBewFphLv1JcxZ6DQ8IT
 CQ7MeAIpGsKWW8utrViXZCn0z+gDv6587f8nFP+5P6hMhL8iawCLROo7TKiRJsvmR6Ql
 Usl5wCg130XB2oYPqm2bAny0WTF2eX/EjFDPIYgmZiB+5oHyybVGnkBVfY5nWeQtJjF7
 yYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+ZAFHXWnaEE/as0BxhGvLJkairDQx49eW/sPX88v4uQ=;
 fh=0tB5q1u2Hcms08iwOECvTnTawWFAXkdeddoWFM8HgFY=;
 b=OMXbyRqFn8GHWZhLPUcIn6hTCpCCDaVdsalayzBiInxapWJ0yZjsZg4Lkyfu68NHKn
 IGa3OQiBtzdkfwbL2LZUefLP1b65d8LVckkofiSCniwb6a9DUV3Jo6IHysE6B1idIONj
 NaaBzR7uDgq6vRtKewIuUCfspT/54BLABvzYWbBl8ZxwyHkAwmRA5n5C5NE4Q8jctalb
 pMGHhY58GvINb/wL53tDMnD8CP8TVZspNSgFTrzePg2r6Z+ulki8ccv7a1VKueQ1s3ca
 4TiG/iHr2MfSGa8+HVfCKw6Wm9cr23vdaPRveYrmm7E0n2rfVQYolR0LGHSS59s+cy71
 6EHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785332662; x=1785937462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+ZAFHXWnaEE/as0BxhGvLJkairDQx49eW/sPX88v4uQ=;
 b=e0ogzEVjb1oq4W0DmeftGCD8m3xTKa1b/hHb6IZwYY1NzOL8Jx3PEkQzlxqdew4mhI
 JRPFmrnVxTRuugqwYQJq1cO0gaXBW4ChKrjOd4L+N8u70i2g6JkETQrCLuqvJDWYs1Hx
 Ij6KmM42hqR7ORUerWLFmf5ZrwHWS4MDEm8mWdD6K2+Rx6mSxQKjPvzk9aK6BYUPu6kM
 eu7KPG9u9353odzIuEqOsvSc69Chqk+pyXSPOxy/SmP5mB7FAaaTxXtPHXvWRZmaO+f3
 NC9s2QrKx5NzkERblL7GJlcY0mZQlLXqx81CQp3CeiEA3olqYZlXEh5vWJhBrbqKYuLs
 /iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332662; x=1785937462;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ZAFHXWnaEE/as0BxhGvLJkairDQx49eW/sPX88v4uQ=;
 b=LNRJG7dA8gwkO5AMYqcPGGxURZUzuzVNJLx30PL6kl5Rn+F70OKVlnTF6Zkyeh3X9K
 pxeOttmwuDbJbkHxjHe/w0JOwXu3ZpQpCrxr2Mj+wFIqeyHLKx4TLXxgbj0EWmlssYzo
 gxKa74OMEMBm83Tj3mh7ezGd6+89W9ZlXSFXUG91wLAvNzNO8UJx0NdNYgaiLWz5Ms98
 R2ZUC6vOzErE4mxngUo2cRKz1ttwtFKmpCTJI34TuM9E6dQ6Qp5Dre6ADSWwyB3oOc9J
 s1XaAMlI1B+jDyPhwrfIeTkKcFFMEsA3e63fI6OHJktWLxiM81vr1wqXrnZa8BVkUcD2
 KsRg==
X-Gm-Message-State: AOJu0YwsZ3uiruMVPtDddY8Z4P9hiHHtGVC8f6JEFeeiUwnjH/gdr7cu
 pnMcE5H5EH7n2Qig0r5xImiHiaf3zgV33GMhO9sFKami6sS/TH2ReXqt1coLMytiAHAmomvvXUn
 zMlmCiprVVMjnanqA0p5nirOTU/2SXdc=
X-Gm-Gg: AR+sD10DeoOIdDARRmXmtEBeFIEEztI+tmS6YNV2oKtQSEl0rtFjdLXoOAw0s//8keZ
 AEo8OYib/qT/NbOwVOKBHd9yF3RDZjWb8npBXku00unQDGquvevAL+NIIs4OIDnGsh30HQvoxbQ
 7A/iJhJq/k/zqPg7dN7Pvu3xZnA7bJBvM01rOUsEQ/SfFebKbaii/2l5A8liLEaC6KAVJTzacwn
 z6i34s6YY7z66TvqOa85tsU+g8JqS31zhRcJi5pqVSLRJ5dg6N6l1O8IQCR8XKdQcRNKCDVp0Oq
 ZJwiVnqobY89OYghV0aHOEsnAvPraS8tegygAuERJDoMuFrjOci8JssM3x5l86HMebm8b+k7/1i
 GDF8JiCAb53MCYJ4OmD0Z60YByIzr18c=
X-Received: by 2002:a17:90b:2b8b:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-38f6a2579a2mr6569045a91.2.1785332662139; Wed, 29 Jul 2026
 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260729112452.1644707-1-lijo.lazar@amd.com>
In-Reply-To: <20260729112452.1644707-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 09:44:10 -0400
X-Gm-Features: AUfX_mwqzcG-UNMjCdPdgdlCUHi0HpGLQHOdIjJLvAf6bYSU-pIhwGa-ZP60g9c
Message-ID: <CADnq5_PsLg1UhxAO2bJdKJNUpbXqkhD_UrK7CsUfPem+oPYhhA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Allocate coredump ring buffers per ring
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

On Wed, Jul 29, 2026 at 7:43=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

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
