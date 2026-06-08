Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC25CD8C9F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 11:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D2710F27A;
	Mon,  8 Jun 2026 11:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L1/R2ThU";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0088410F277
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 11:52:54 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304dd3bb7a6so344606eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2026 04:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919574; cv=none;
 d=google.com; s=arc-20240605;
 b=QZxAlKoS6b6zySDYfwBNxWFTDtowo6Q+DmgiKn9c7CBEL+tZYSQk0S0iK/aaHS7unj
 iCh93AtSGPse4F94KPPeVnB8id21/ctnsEiZ/WTuqClsPdMvuFK7nTm2MVJpk3Nu3yz4
 JCfsjEokSCxQpaUaV3yARYj+Y6c/62Q5OZnptqsQHZ+51q2eHSrRhwwMyR92KeTI57Ii
 jy84tWe0WXx2fNVEbHMwg8NjI7fYyGm7pctijTJHl79elpRIpAEs9q71mm6G8XRo1vp9
 Gv0JWaeUaZAC+ePby09d1H9hyqMyYxIPWP7OpO4KO4HJBQ0iP8g2y5sDZgdqgzhq47fR
 S5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vb/teLmrJnjRmx5gdwLA+XVinuCZrQpKApO3FJKsWP8=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=T3td8Khc72yoCcK17xB8SEzeawGtFvWYq0bCW8vXt8zNY1gZ0j5WBZPD6Cayu85aBq
 33bOSH/n9LhFNQnqRN5VIZdAY7RWk/ifm6mGqzyw7vrB9b+8T1hjNKmQ1ffzKBZvydc5
 BhXIXGmqh1CwkeOm4x5aJCrVcab44kwdUcRZJJ0P5Bw9EJBRXe8qk73GljrE+o0SOJuE
 AbGtysrL+WDaZzCpU8nAFlD/7aCgnXXWWpkmipgz/jveftI+1pEsdnMaq0AbL2LzKpXG
 FTc/1yNU8HalKnjXYk2tBmyZXY8Zwp4MbvwGaz0jlqM06woUyC7vhlJT97NEbdLmpFfl
 icBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780919574; x=1781524374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vb/teLmrJnjRmx5gdwLA+XVinuCZrQpKApO3FJKsWP8=;
 b=L1/R2ThUK7DSJ2S/uGt5hoRgjmiJ8nBarOG+2t6pctxzR2gJ1okj1piJsWNrvNh3u0
 FdqMidNyUdR4LSUhmckQUpDDbybsqJF/qcW4DhKKlCN2z0tVVYcTTkCi/UOl3HPAwcMM
 hxtqk2lTvFA5SlX76Wv6ncVz1j4gFL/P7AIwiIi+hVCilLPRIht0nbj1gxj/nW5QZyAR
 VVggDmU1yXn1kATHDv9RoJg4gS7bmiVg27bIEhBzPUJwCKpEbhtFBpc65oIBzdD0fL54
 HkYs0/PnYGil0rzFW0eLoqTx+vRZSqTk8c1JCSGwVMKJ6mbUe+TYaclLzAHT7oYhX7U6
 j1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780919574; x=1781524374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vb/teLmrJnjRmx5gdwLA+XVinuCZrQpKApO3FJKsWP8=;
 b=oGkHFjy2/whC1fSqeWVl2LLwAm/5HsDRua7O/OLYm7ie+40DvGMcy/yorfXpX+dB7g
 Yt5FYRTRYXMagXAbOEmUmxt8B4qdn7vgQF/6s29IhMVQtGigxgh4ymJ+2A35wxmQcZkB
 InrJouRiPPr76+oO0/jdXFJQW46kIp1yx90cFtOLtJDicwBn7JT+C868I/+owYFc8c2i
 7DLtScnrVx49b1wj0QBTCJrB6YSw4GYcS5K2DRXV8KMZRP4ynOEwr40ueZYjJh56YebO
 i7oQl3/49PnFb79cXK768vxOfrCGnnV6ugpX2aBQnCEEcrWCrExcmpV44qs3E2fJXwsz
 3ypg==
X-Gm-Message-State: AOJu0YzSPCg24h+/z1WN1xrXZk0raMHFihYtvzqNYf5d3HMatp65VjBd
 vRdLCaPo54Fp5+iS3SZKYQVnncHNcyjzhnZyo2pVegJE5coNJF+Mcted7Gnm/lSJFRrJUg43/kE
 x9+F2ymR5e26xyDDGQXLJcDfda1Qn0bNWlvMcFSRiDQ==
X-Gm-Gg: Acq92OGdzU7TGqfS+fiNRI0oPr5cUcRzQgY2vjmoVNEHeZMpuO9q8yu43V8zlKMTBPv
 FSs1u65f0UfCNrEMrxAI69YdNrevoPKkgWXNrwbit4hyJ0TwxIP4gFlCWQwbPPTPto/XAgIFBhL
 IvvLYFqfTFTAkCqcbnLunLkPEwDXcStHaQAaXkkv/4Rc2JKsNOiFfWt0t3hktnmdJri931wFHHn
 Dqz67qSYoemVVPejPT4l6tUXU35Q1o0R9hDOBPqIedPt9k0DMNxGyb6/eK5B3Ol2I2eF8/bvMwv
 HCVcxc7bdKtIHtR09LhpbEnk/FVe8s/dtWYbbiFj8HobHlHpFOUXTdkfTuuh193ONfT5/UwEd28
 6MUQ=
X-Received: by 2002:a05:7022:f214:b0:12d:ce63:d8c5 with SMTP id
 a92af1059eb24-1380669ea61mr2674612c88.2.1780919574117; Mon, 08 Jun 2026
 04:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260608030726.3396300-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260608030726.3396300-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jun 2026 07:52:46 -0400
X-Gm-Features: AVVi8Cesr4U4ThFsrQOCNmDyxdel0YiyrzBNR6zuKTErx2GNoPPwfG4kU4y2F-0
Message-ID: <CADnq5_N9+4VLxU-jTZakBe0=XigQ8Dv2xCaeuuaefF-QSKZdBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: defer per-queue helper_end until after
 MES resume
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Sun, Jun 7, 2026 at 11:24=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> amdgpu_gfx_reset_mes_compute() runs amdgpu_mes_suspend(adev, 0) to
> quiesce all gangs, resets the offending queue(s), then resumes. The
> existing amdgpu_gfx_mes_reset_queue() called amdgpu_ring_reset_helper_end=
()
> right after unmap/restore/map of the reset queue, which re-emits backed-u=
p
> commands and rings the doorbell. That doorbell hits a still-suspended CP:
> on the subsequent resume the queue partially wedges -- the first new IB
> after the reset may execute but later submissions stall, which surfaces
> as repeated timeouts on the same ring under concurrent workloads.
>
> Split out amdgpu_gfx_mes_reset_queue_no_end() (backup + MES reset +
> unmap/restore/map only) and defer helper_end. amdgpu_gfx_reset_mes_comput=
e()
> collects the (ring, fence) pair for every queue it resets and runs
> helper_end on each after amdgpu_mes_resume(), so the re-emit doorbells
> land on a running CP. amdgpu_gfx_reset_mes_kcq() now reports the matched
> ring/fence back to the caller for the same reason.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 68 ++++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 ++
>  2 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9..b6202095f256 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1989,10 +1989,10 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(=
struct device *dev,
>         return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_re=
set);
>  }
>
> -int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
> -                              unsigned int vmid,
> -                              struct amdgpu_fence *timedout_fence,
> -                              bool use_mmio)
> +static int amdgpu_gfx_mes_reset_queue_no_end(struct amdgpu_ring *ring,

_no_end() sounds weird.  How about _start() instead?  With that fixed,
the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +                                            unsigned int vmid,
> +                                            struct amdgpu_fence *timedou=
t_fence,
> +                                            bool use_mmio)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         bool reinit_queue;
> @@ -2026,7 +2026,20 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring =
*ring,
>                         return r;
>                 }
>         }
> +       return 0;
> +}
>
> +int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
> +                              unsigned int vmid,
> +                              struct amdgpu_fence *timedout_fence,
> +                              bool use_mmio)
> +{
> +       int r;
> +
> +       r =3D amdgpu_gfx_mes_reset_queue_no_end(ring, vmid, timedout_fenc=
e,
> +                                             use_mmio);
> +       if (r)
> +               return r;
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> @@ -2216,24 +2229,37 @@ static void amdgpu_gfx_reset_stop_compute_scheds(=
struct amdgpu_device *adev,
>         }
>  }
>
> +/*
> + * Match the MES-reported hung doorbell against a compute ring and run
> + * the core reset (no helper_end). On hit, the matched ring and its guil=
ty
> + * fence are returned via *out_ring / *out_fence so the caller can defer
> + * helper_end until after MES has resumed all gangs.
> + */
>  static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
>                                     struct amdgpu_ring *guilty_ring,
> -                                   unsigned int db)
> +                                   unsigned int db,
> +                                   struct amdgpu_ring **out_ring,
> +                                   struct amdgpu_fence **out_fence)
>  {
>         bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
>         struct amdgpu_fence *fence;
>         struct amdgpu_ring *ring;
>         int i, r;
>
> +       *out_ring =3D NULL;
> +       *out_fence =3D NULL;
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 ring =3D &adev->gfx.compute_ring[i];
>                 if (ring =3D=3D guilty_ring)
>                         continue;
>                 if (ring->doorbell_index =3D=3D db) {
>                         fence =3D amdgpu_ring_find_guilty_fence(ring);
> -                       r =3D amdgpu_gfx_mes_reset_queue(ring, 0, fence, =
use_mmio);
> +                       r =3D amdgpu_gfx_mes_reset_queue_no_end(ring, 0, =
fence,
> +                                                             use_mmio);
>                         if (r)
>                                 return r;
> +                       *out_ring =3D ring;
> +                       *out_fence =3D fence;
>                         break;
>                 }
>         }
> @@ -2254,6 +2280,8 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>         unsigned int num_hung =3D 0;
>         bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
>         struct mes_remove_queue_input *queue_input =3D (struct mes_remove=
_queue_input *)faulty_queue_input;
> +       struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_=
RINGS + 1];
> +       int n_deferred =3D 0;
>
>         guard(mutex)(&adev->gfx.mec.reset_mutex);
>         /* stop the drm schedulers for all compute queues */
> @@ -2278,9 +2306,13 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_dev=
ice *adev,
>  fence_reset:
>         /* reset the queue this came from if specified */
>         if (ring) {
> -               r =3D amdgpu_gfx_mes_reset_queue(ring, 0, guilty_fence, u=
se_mmio);
> +               r =3D amdgpu_gfx_mes_reset_queue_no_end(ring, 0, guilty_f=
ence,
> +                                                     use_mmio);
>                 if (r)
>                         goto out;
> +               deferred_end[n_deferred].ring =3D ring;
> +               deferred_end[n_deferred].fence =3D guilty_fence;
> +               n_deferred++;
>         }
>         if (uq) {
>                 r =3D mes_userq_reset(uq);
> @@ -2288,15 +2320,24 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>                         goto out;
>         }
>         for (i =3D 0; i < num_hung; i++) {
> +               struct amdgpu_ring *hr =3D NULL;
> +               struct amdgpu_fence *hf =3D NULL;
> +
>                 pipe =3D hqd_info[i].pipe_index;
>                 queue =3D hqd_info[i].queue_index;
>                 queue_type =3D hqd_info[i].queue_type;
>
>                 /* reset any KCQs */
>                 r =3D amdgpu_gfx_reset_mes_kcq(adev, ring,
> -                                            adev->gfx.mec.mes_hung_db_ar=
ray[i]);
> +                                            adev->gfx.mec.mes_hung_db_ar=
ray[i],
> +                                            &hr, &hf);
>                 if (r)
>                         goto out;
> +               if (hr) {
> +                       deferred_end[n_deferred].ring =3D hr;
> +                       deferred_end[n_deferred].fence =3D hf;
> +                       n_deferred++;
> +               }
>                 /* reset any KFD queues */
>                 r =3D amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, =
pipe, queue,
>                                                   adev->gfx.mec.mes_hung_=
db_array[i]);
> @@ -2325,6 +2366,17 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_dev=
ice *adev,
>  out:
>         /* resume all will enable the non-hung queues */
>         amdgpu_mes_resume(adev, 0);
> +
> +       /* Now CP is running again =E2=80=94 replay backed-up commands an=
d ring
> +        * doorbells on each reset queue.
> +        */
> +       for (i =3D 0; i < n_deferred; i++) {
> +               int er =3D amdgpu_ring_reset_helper_end(deferred_end[i].r=
ing,
> +                                                     deferred_end[i].fen=
ce);
> +               if (er && !r)
> +                       r =3D er;
> +       }
> +
>         if (!r)
>                 amdgpu_gfx_reset_start_compute_scheds(adev, ring);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 4003360c7d9a..381fc17274b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -549,6 +549,11 @@ struct amdgpu_gfx {
>         bool                            disable_uq;
>  };
>
> +struct amdgpu_gfx_deferred_entry {
> +       struct amdgpu_ring      *ring;
> +       struct amdgpu_fence     *fence;
> +};
> +
>  struct amdgpu_gfx_ras_reg_entry {
>         struct amdgpu_ras_err_status_reg_entry reg_entry;
>         enum amdgpu_gfx_ras_mem_id_type mem_id_type;
> --
> 2.49.0
>
