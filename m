Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C399CD98F2
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jun 2026 17:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF0710E09D;
	Sun, 21 Jun 2026 17:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxeAK76v";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C5710E09D
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 17:27:10 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bc0b90dd2so327151eec.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jun 2026 10:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782062830; cv=none;
 d=google.com; s=arc-20240605;
 b=YYf+9iVPiCzYuP+6ceMeSEMfdWDBBlJatPZtsGQp1DvUcrqXjQo0mR2IxDSeSZDRdX
 Jr7ejmVFqWojjzNcd1mQ77DutVPccbHVm9YU5ngKUN8NP9uEBTLcp7T+6Pi6+5Ckhzv9
 Qi3K6HiLdVBDq7NqCTiwSJyGWaNuxT5BU9kGl91PTZN3z7Cb41b/ywjeIbOBAhA39r2z
 3df9ah+EodsFsnutHLgxIr2lzoAtw1t2v9GyTrv/S+uhyD0NfPa/QpwhGw70ytLtGeFu
 85g4fafVypMBUu/WzsouW3D9smd5QkELw5IxtiGu8ZRwkoenWcFZob1PA2pZt/s8Nz1D
 PqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B6gccKUHtG/Kz2+jpK9V3X3fmNjzZun0MwGL4O18h4Y=;
 fh=8ctcLcTMQegsol4jW1vK0/TpYIQESQo3t9uXEfVRTmA=;
 b=Rr1k/VBxfzvSJH0pvamcPtAEdUKf89b9wr9T3kmfvN76DxTyJYrni45nsuW1OL6DHo
 m95yWhC/7V8qhG56kKx1Bn3/lmJxXS/oUAYccGV/NU1ogUgrjfuBzk/ljgiiFCwq41DV
 V18APV9Wy24c/HdJK/Mik4IfoKptxweOQ6d1IYaexQlnduyC4fx7Nov1M7xkxYTOP9wE
 Y2aR0deviXEWAufpM6LEuljsMHIqOt4INY1XeU9sN6oBuC14sS852PhmTiR1Lge43rUR
 twwzTeHHo+E6uaqtL35laUKTRe6AYrjznDaYpX+1OlfepEsydvPdLaXd6tZhmt8bz+Lq
 ZqgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782062830; x=1782667630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6gccKUHtG/Kz2+jpK9V3X3fmNjzZun0MwGL4O18h4Y=;
 b=BxeAK76vZVqLxEKO01qBniAotWCN1LwSxlumNyEJH5ilHI111XjFz2BtKWVlafI+C6
 h1ea+sy8DYGkXaVcu5juKQAC0T9lvKmjMsNKK8yzXNdIhJ8867uqNc9EjecSBwYeRhHC
 uR0LrvrhJO0XJ9tjSWwHunDsAnYwsO4SULzWQ5RuZmWSKRdo1pAcoNznQDDCYLwgwY9h
 P1F1qJmTPywU7SQGVY9jLt6ZLEzCXVBCNG9BJFkitA2W+Yd2TMOopdyB8WWdzATOLjQu
 /bGII5nTKcLtbOB0KVbbSxKsnPMxpY+LVKSCmmpFUNFCGM55jgHkRrr5iGnDly9Dtqcx
 WlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782062830; x=1782667630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6gccKUHtG/Kz2+jpK9V3X3fmNjzZun0MwGL4O18h4Y=;
 b=WeSxu9TFRCuYw0tusICWrDFzJHuUkz0WHkMU15wbxPYN1A1FEtWMpWBsJquVRHs1YS
 91V5N28yFxi3h7tHLtEry8fMK/jChKaPq945XDXXW2a8wm4W6mN3B78vEAyUAyswxtVx
 UMb+2w3yFJMLEk4mZyIi+tG5i0ouNe8yRCphn9H5EBcaMcxWv6SgZGQsC1W93pOyPJFE
 kJBMMQ7yN38nSFEygEnSX9PcJGymAUBXaG0HFfTrlyfINzuS5au3o6szlntmaEt4F8zl
 PSSu0cYzOEeikM7qWDg/zpYt6n3qhFfheWTi0ShPh7/Bx3zXo/m3PsWd2L08CXz+6CNn
 3WOw==
X-Gm-Message-State: AOJu0Yw3IeVtqkIZcGAZjQKJ/gsURPFAggzoTruIcYoSvHEsf7It2FZM
 UImqclY1KmQYlvrEDXKKzcwb72xKfjD/yiMDlDPq4TNo+Htk49bVNaOaOZ+h+1YFwb6O9/guOEa
 ldu4be2MW8R6xk8AA5B4NHklScsezuis=
X-Gm-Gg: AfdE7cnmfpCY2qpM05zcO8Xio7KabuV0CXiDDKfFGGfK5wOsYjKL9Hv1NlL9o1BZsf8
 3MQLXH6QaeDlUG2peesIxzWU5fS6kyaTxqoFUnsr4pzYn4DOeiSMVsaRefzckFsN5wpzMzh4oDn
 vKonsOpXFS5c2wbiLfeG2MQv/v2nPqTJQSOjdi6GguYqNZRq+S0z2cY2Usn80z6vLZwi4zwPojd
 Fv5vc8w9kwNSFgqXBkimwwJ7ofVRc3SSVq9YKW8qDmFesV4ah7A6JNbDQt2A9w+bYw6BrRJuDp5
 Pzg5q1khZmYoFvHegF2vuHQN3BWimwgn5cRhOBU4UcYeXpfiKhLPyVo82Jo=
X-Received: by 2002:a05:7301:38a4:b0:2d5:9438:2a02 with SMTP id
 5a478bee46e88-30c06fea5aamr3968700eec.1.1782062829724; Sun, 21 Jun 2026
 10:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260620153753.3061314-1-Jesse.Zhang@amd.com>
 <20260620153753.3061314-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260620153753.3061314-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 21 Jun 2026 13:26:57 -0400
X-Gm-Features: AVVi8CeSVOnX7krNEJtW3YG6bkE5oqYhhtJ_Sala0hccVhfzXqqBuK_YjqrJUjY
Message-ID: <CADnq5_OpCOZSnY=yATQ3DDEbQ+sAkbS0v60viAnnqiP-F5atrw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: defer KCQ remap until after MES resume in
 reset flow
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
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

On Sat, Jun 20, 2026 at 11:38=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> Split amdgpu_gfx_mes_reset_queue_start() into reset+unmap now and queue
> reinit later, and do the remap only after amdgpu_mes_resume(). Avoids
> re-adding legacy queues while MES gangs are still suspended.
>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

The series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Is there a way we can clean this up in a future patch set?  It's
getting really complicated.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 70 +++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
>  2 files changed, 55 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 982b41606d48..a5b835d0c166 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1989,10 +1989,24 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(=
struct device *dev,
>         return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_re=
set);
>  }
>
> +static int amdgpu_gfx_mes_reset_queue_reinit(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int r;
> +
> +       amdgpu_gfx_mqd_reset_restore(ring);
> +
> +       r =3D amdgpu_mes_map_legacy_queue(adev, ring, 0);
> +       if (r)
> +               dev_err(adev->dev, "failed to remap kgq\n");
> +
> +       return r;
> +}
> +
>  static int amdgpu_gfx_mes_reset_queue_start(struct amdgpu_ring *ring,
>                                              unsigned int vmid,
>                                              struct amdgpu_fence *timedou=
t_fence,
> -                                            bool use_mmio)
> +                                            bool use_mmio, bool *need_re=
init)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         bool reinit_queue;
> @@ -2007,6 +2021,9 @@ static int amdgpu_gfx_mes_reset_queue_start(struct =
amdgpu_ring *ring,
>         else
>                 reinit_queue =3D use_mmio;
>
> +       if (need_reinit)
> +               *need_reinit =3D false;
> +
>         amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_m=
mio, 0);
> @@ -2018,13 +2035,9 @@ static int amdgpu_gfx_mes_reset_queue_start(struct=
 amdgpu_ring *ring,
>                                                   RESET_QUEUES, 0, 0, 0);
>                 if (r)
>                         return r;
> -               amdgpu_gfx_mqd_reset_restore(ring);
>
> -               r =3D amdgpu_mes_map_legacy_queue(adev, ring, 0);
> -               if (r) {
> -                       dev_err(adev->dev, "failed to remap kgq\n");
> -                       return r;
> -               }
> +               if (need_reinit)
> +                       *need_reinit =3D true;
>         }>         return 0;
>  }
> @@ -2034,12 +2047,19 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring=
 *ring,
>                                struct amdgpu_fence *timedout_fence,
>                                bool use_mmio)
>  {
> +       bool need_reinit;
>         int r;
>
> +       /* Single-queue reset (no suspend/resume): re-add the queue inlin=
e. */
>         r =3D amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence=
,
> -                                             use_mmio);
> +                                             use_mmio, &need_reinit);
>         if (r)
>                 return r;
> +       if (need_reinit) {
> +               r =3D amdgpu_gfx_mes_reset_queue_reinit(ring);
> +               if (r)
> +                       return r;
> +       }
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> @@ -2239,7 +2259,8 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_d=
evice *adev,
>                                     struct amdgpu_ring *guilty_ring,
>                                     unsigned int db,
>                                     struct amdgpu_ring **out_ring,
> -                                   struct amdgpu_fence **out_fence)
> +                                   struct amdgpu_fence **out_fence,
> +                                   bool *out_reinit)
>  {
>         bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
>         struct amdgpu_fence *fence;
> @@ -2248,14 +2269,16 @@ static int amdgpu_gfx_reset_mes_kcq(struct amdgpu=
_device *adev,
>
>         *out_ring =3D NULL;
>         *out_fence =3D NULL;
> +       *out_reinit =3D false;
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 ring =3D &adev->gfx.compute_ring[i];
>                 if (ring =3D=3D guilty_ring)
>                         continue;
>                 if (ring->doorbell_index =3D=3D db) {
>                         fence =3D amdgpu_ring_find_guilty_fence(ring);
> +                       /* reset + unmap now; re-add (map) is deferred to=
 after resume */
>                         r =3D amdgpu_gfx_mes_reset_queue_start(ring, 0, f=
ence,
> -                                                             use_mmio);
> +                                                             use_mmio, o=
ut_reinit);
>                         if (r)
>                                 return r;
>                         *out_ring =3D ring;
> @@ -2306,12 +2329,16 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>  fence_reset:
>         /* reset the queue this came from if specified */
>         if (ring) {
> +               bool reinit =3D false;
> +
> +               /* reset + unmap now; re-add (map) is deferred to after r=
esume */
>                 r =3D amdgpu_gfx_mes_reset_queue_start(ring, 0, guilty_fe=
nce,
> -                                                     use_mmio);
> +                                                     use_mmio, &reinit);
>                 if (r)
>                         goto out;
>                 deferred_end[n_deferred].ring =3D ring;
>                 deferred_end[n_deferred].fence =3D guilty_fence;
> +               deferred_end[n_deferred].reinit =3D reinit;
>                 n_deferred++;
>         }
>         if (uq) {
> @@ -2322,6 +2349,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_devi=
ce *adev,
>         for (i =3D 0; i < num_hung; i++) {
>                 struct amdgpu_ring *hr =3D NULL;
>                 struct amdgpu_fence *hf =3D NULL;
> +               bool hr_reinit =3D false;
>
>                 pipe =3D hqd_info[i].pipe_index;
>                 queue =3D hqd_info[i].queue_index;
> @@ -2330,12 +2358,13 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>                 /* reset any KCQs */
>                 r =3D amdgpu_gfx_reset_mes_kcq(adev, ring,
>                                              adev->gfx.mec.mes_hung_db_ar=
ray[i],
> -                                            &hr, &hf);
> +                                            &hr, &hf, &hr_reinit);
>                 if (r)
>                         goto out;
>                 if (hr) {
>                         deferred_end[n_deferred].ring =3D hr;
>                         deferred_end[n_deferred].fence =3D hf;
> +                       deferred_end[n_deferred].reinit =3D hr_reinit;
>                         n_deferred++;
>                 }
>                 /* reset any KFD queues */
> @@ -2372,12 +2401,21 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_de=
vice *adev,
>         /* resume all will enable the non-hung queues */
>         amdgpu_mes_resume(adev, 0);
>
> -       /* Now CP is running again =E2=80=94 replay backed-up commands an=
d ring
> -        * doorbells on each reset queue.
> +       /* Now CP is running again =E2=80=94 for queues that were unmappe=
d during the
> +        * reset, re-add (map) them only now that MES is resumed and back=
 to a
> +        * normal state, then replay backed-up commands and ring doorbell=
s on
> +        * each reset queue.
>          */
>         for (i =3D 0; i < n_deferred; i++) {
> -               int er =3D amdgpu_ring_reset_helper_end(deferred_end[i].r=
ing,
> -                                                     deferred_end[i].fen=
ce);
> +               int er;
> +
> +               if (deferred_end[i].reinit) {
> +                       er =3D amdgpu_gfx_mes_reset_queue_reinit(deferred=
_end[i].ring);
> +                       if (er && !r)
> +                               r =3D er;
> +               }
> +               er =3D amdgpu_ring_reset_helper_end(deferred_end[i].ring,
> +                                                 deferred_end[i].fence);
>                 if (er && !r)
>                         r =3D er;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index aefd4f03b443..9432107c96a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -550,6 +550,7 @@ struct amdgpu_gfx {
>  struct amdgpu_gfx_deferred_entry {
>         struct amdgpu_ring      *ring;
>         struct amdgpu_fence     *fence;
> +       bool                    reinit;
>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> --
> 2.49.0
>
