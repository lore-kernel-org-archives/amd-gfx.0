Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B72C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 14:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D7F10E3BB;
	Tue, 23 Jan 2024 14:03:52 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CDF10E3BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 14:03:51 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-5993047a708so2167221eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706018571; x=1706623371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6leFmD8a0DrkH0vsGTsY7ZFbXE9VS4Tj7nkSBviGpXo=;
 b=evVvv0E9qD/nzyD5JNIo7A14N4fSqHTYLyr8ripyJNyZsVwTjzuNEMiwdaQGFR9Y11
 q1Y50v2mWasDurA4QoZDqvrPhro1NYroSf6IJCEQgStkpRuFDLGBWwWSnrTJOby1DztW
 bBu1f0W5DyFtJDjGoua7eD/OvKoqm8F46XhZvlN2hsKGIgO0Gk+eqOs7OCSQMopstVnt
 UGpuEOjF2rVudqvNMWKkJsF9DCJDuSVIm315IXdU3BhEyOL03o8Sx8pMnaTjKR2OXFsx
 oailPXsCcActcxtb2ivBhE5XbLpdAXvslr942k4rNoP5BTpQvRiJ8JNPj7G5xyre2pOH
 /vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706018571; x=1706623371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6leFmD8a0DrkH0vsGTsY7ZFbXE9VS4Tj7nkSBviGpXo=;
 b=ZoEPg1vplfapUz7vMCKmIW+MpORad3HXWcpp6xkeN8wjMqIYI2Y3R0iISrtS265Zu+
 FJwkjVcz6tqt77UIg9IlO4V2yU0bMSjqw/rpvMBw9BSwXP8T4ggY40dd9+LrhLx1p2fN
 KMStt4FrD676fGwItmIvwxfz92KayU9/PoH4Jxs+zMW3Do6xdFgtdNCvnZR+8/1PMmrp
 eBqN8pA+o6JoSZ6zwc0W2lLxrGERd/PmuhZKoWV0rsTmLg6fXWYfh7k1vBEaFH9f3OOQ
 4mdJyPvxh3MiO1f/PHu7JkD8GJm+MzCyIIr7A8Gj76nENfCH9C+J9Whx8A7XoPnQtvhB
 MT1w==
X-Gm-Message-State: AOJu0YyEGPmkVKfsKmyqJKH4BH06k+y5SailBvxfn380GHkZxYfDGJwq
 wcR8QY9JXglwlqssIIfYcKlUHqOf820m5GNBBU8cnZ8udyHvArQsTmas2LATDkeUCaNtOxDcw4R
 hK/jt3okvvd/x/frI24L5QE1U8lo=
X-Google-Smtp-Source: AGHT+IHewo6qq1nGlk8Q6PMiernjsFoKsEHcD+Cb9ROFbIjQPhFj1ncTYiaXSQQegO/Xg4y5QUagfSjOvf1k/FS5sDM=
X-Received: by 2002:a05:6870:b513:b0:214:306d:3565 with SMTP id
 v19-20020a056870b51300b00214306d3565mr1572209oap.54.1706018570998; Tue, 23
 Jan 2024 06:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20240105060525.579292-1-Jun.Ma2@amd.com>
In-Reply-To: <20240105060525.579292-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jan 2024 09:02:39 -0500
Message-ID: <CADnq5_MzP4TRW9ArFw+F0JqQBQ-bnz1-iZg43zmTWPnKWVL9Qw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix the warning info in mode1 reset
To: Ma Jun <Jun.Ma2@amd.com>
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 5, 2024 at 1:15=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Fix the warning info below during mode1 reset.
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  ? show_regs+0x6e/0x80
> [  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000005]  ? __warn+0x91/0x150
> [  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000006]  ? report_bug+0x19d/0x1b0
> [  +0.000013]  ? handle_bug+0x46/0x80
> [  +0.000012]  ? exc_invalid_op+0x1d/0x80
> [  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
> [  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000007]  ? __flush_work.isra.0+0x208/0x390
> [  +0.000007]  ? _prb_read_valid+0x216/0x290
> [  +0.000008]  __cancel_work_timer+0x11d/0x1a0
> [  +0.000007]  ? try_to_grab_pending+0xe8/0x190
> [  +0.000012]  cancel_work_sync+0x14/0x20
> [  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
> [  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]
>
> This warning info was printed after applying the patch
> "drm/sched: Convert drm scheduler to use a work queue rather than kthread=
".
> The root cause is that amdgpu driver tries to use the uninitialized
> work_struct in the struct drm_gpu_scheduler
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> v2:
>  - Rename the function to amdgpu_ring_sched_ready and move it to
> amdgpu_ring.c (Alex)
>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 14 +++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +-
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4b1d5f42249f..d0d82e69b034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5700,7 +5700,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> -                       if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> +                       if (!amdgpu_ring_sched_ready(ring))
>                                 continue;
>
>                         drm_sched_stop(&ring->sched, job ? &job->base : N=
ULL);
> @@ -5776,7 +5776,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> -                       if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> +                       if (!amdgpu_ring_sched_ready(ring))
>                                 continue;
>
>                         drm_sched_start(&ring->sched, true);
> @@ -6265,7 +6265,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                 struct amdgpu_ring *ring =3D adev->rings[i];
>
> -               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +               if (!amdgpu_ring_sched_ready(ring))
>                         continue;
>
>                 drm_sched_start(&ring->sched, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 41266bc99345..9555d5532d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -636,7 +636,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>                 DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
>                               ring->name);
>
> -       ring->sched.ready =3D !r;
> +       if (!ring->no_scheduler)
> +               ring->sched.ready =3D !r;
>         return r;
>  }
>
> @@ -719,3 +720,14 @@ void amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *r=
ing)
>         if (ring->is_sw_ring)
>                 amdgpu_sw_ring_ib_mark_offset(ring, AMDGPU_MUX_OFFSET_TYP=
E_DE);
>  }
> +
> +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
> +{
> +       if (!ring)
> +               return false;
> +
> +       if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
> +               return false;
> +
> +       return true;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index bbb53720a018..fe1a61eb6e4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned num_ibs,
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
> -
> +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
>  #endif
> --
> 2.34.1
>
