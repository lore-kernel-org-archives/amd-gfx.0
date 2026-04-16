Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40182F8A175
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 13:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EAA10E1D7;
	Thu, 16 Apr 2026 13:28:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MoonP/c0";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AA710E1D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:28:08 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2df943e0a96so32039eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 06:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776346088; cv=none;
 d=google.com; s=arc-20240605;
 b=K0cw3P3odQzLc/xb4VO3IyguBpJNjLzIig+9paLe8c+K58NHYwjn1zuBQvDK3Ewyeo
 NMx8TOhOBmi8Jcb5zU660p/F9zkUxVzlTtmYj/KpGoHPI5W9Rx53KUsS8WpBuoJ9sGZi
 jHOcXGkicVryf6tWtd/ZTqCBwqVKOtk0YTrZIDYnSjXU87p4u9A5fLSOwhzWzTJ5/pe7
 GTGwHMG8kVb/pkx3knPj1bMi6L//9EJN73riPSMQul2VpFQp9OIFqRznIhkw+UrXJ7Kc
 VGeF0J0N+2+SBhBldyvi+/4tVgVIYep19VyBRUT74ah80hlNlV/SK852yVCRqMuDazsk
 BnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 fh=9KynxTPI8BRQpFxDm8CVpSLsknuhnXygUOdD603y/8U=;
 b=Lw7W34fyk8uTZs2oUOB1XhBn6WCw2/F7HZ7EwFKf3hGvITZir2ohMD/IPyq6oqq/0t
 hdgJ68Xe+63PQaKItU+DEFnhzeP8rRGNHc7C1cDOS79d+/YMj9E+8ssRQzKt33hcz0tc
 8548r00FUIusCvtRIUeVHFKFOYwAGCh9w9ktQ9fyglyPnHCzLpoida6XguAVzZUnUH64
 ssqJVMtGGyioBl4GbbWRnPzRgceFcYdaQYUeQaiYaS8X4wODurhmuiyR7iFqthzxjB8s
 yomvY5nFIXrfqFYQ7u2Etyj5Mwcy3OFMTDlQDbMjVTh8NtM9LRa8WHX5BzsS0gat/6BU
 H/DQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346088; x=1776950888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 b=MoonP/c0aocnapVDPtFcfopjTw9ri/Y8AfmaXmwSCcVWhAIroKIOCMct76rTF4dTjs
 IvRFxvlLy9Xpdtk4fhuNAMZr1a7/5IrsrbgYykMMVSFEvUJAYYQrc/Na+iywmVn485EV
 zbUW3L7+wo85cgFNZWGXesrtWpzgc1xJr8EetfLMt7d7kF9DdFYrhG/cmfQgxnnTgh2c
 gxWaMulobxEVtLlPIFTXuvxLFrFjZeNml738+EaoM8QekR2JdR+p1rzw02VQTk3FnmCM
 00lOguYr1MjVmzPHYgFhbF4vSV3q5PJ4648u69al5qKjPUfyuzG+yoHhx7gU8PceQuIy
 ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346088; x=1776950888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwhq/rWJv+hSIncbqP+T4zRf5Z8JAVJckW0Tn/6VCys=;
 b=CHS2f7TthMqbmLlh2wfr6mD66Zl10m1LThn29D0lxElrabtOTxsyqU9GkRXyRoy/wI
 1W8/o9GcD/VrVGhmUO9I7ZuXhQ12oy+5T2ZuXxSq1Ka315Yj1S395KAvGn4YVy5Vk1yi
 gauDGQO04wZ+kuY5uQwAzdyzf1B8ZlM0v6rBFqfWL6ffgYesxGWma1KShbRBFgbT+kRw
 9pimMaeV89N20jfoTOy5oFpojhnPmyXTJOaEvfbxqtdAfGzoYM/0bvjHIXWkswGJ9xaB
 QCMbwOVIIKTZqZc2/URsBIA/sctMV7b6KmfRrVqcTrXNxYUfrKKVTrSwf2DkvhUXaG+U
 kd1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZiZhS5lTZstd0zN5/D5pjHvrQyjDvdW366ZdKCfodxIEZSQ5Wv3cEyxzytnjLDu8ZqBsK6QmB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLGHXLHFmy7l0VMoZph5Iea3BU2lDrnm6tqkE8HfZtySezNwwV
 5aRqEeTpgbYyPeC0779syasJaMnXq47m0yeNMEzpYRExms7EDwFkFOWIAlmW5ZEiTV7ZkCIs/4X
 0K+yCuwuHhNSwpM6IC1PRlSjMGf5gcIc=
X-Gm-Gg: AeBDieui7Y2Pnw0vLu+InnsXPJb06RWWrrqBylyts2P3RLY1ryQMmwzydJiZq+p+uAh
 etMm0U/0zLVhLjOviZ4zyNph5ZE+DRV4Nda6PFqv0Ivrk/iQKlG+RxgKETC4lX9sKn/+bYKHSnm
 7KERghIwxv8fJoGlw6Tmli9OKCvRjm2YrXoDV0vcXQZqUuAFcirXK7KBuaTQyudh/jPIRomSQSG
 uu9c/7Iwx87GmYtf0mztuYumwb5+0BEuqnqUvxkyNgfx9zFMMcxfb/4OMFk8qwiMLHc+B+KYuRt
 Rt/daOtT+KUX0MqkDg4gHicYrgK4Eh0OsVseaEqnNbm6q1YUJP84QPTS92tUQPy1/H1kcA==
X-Received: by 2002:a05:7022:698e:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12c65906a48mr552300c88.2.1776346087791; Thu, 16 Apr 2026
 06:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260415164029.52537-1-leonardocesar@usp.br>
In-Reply-To: <20260415164029.52537-1-leonardocesar@usp.br>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Apr 2026 09:27:54 -0400
X-Gm-Features: AQROBzABpaNT6X8DJN-YvzCXN2JUjZTRyimTed_f2ZFWFV7TJ7I7jo0CAlHdb0I
Message-ID: <CADnq5_MbpE9AT8qZiLQkYZ7QZ2YWwmu2U8vj3+C+umR1dnJL9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate ring preempt ib function
To: Leonardo Cesar <leonardocesar@usp.br>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, Apr 16, 2026 at 4:54=E2=80=AFAM Leonardo Cesar <leonardocesar@usp.b=
r> wrote:
>
> The ring preemption function is identical for both gfx_v11_0 and
> gfx_v12_0. This patch refactors the code by moving the core logic
> into a generic function inside amdgpu_gfx.c to reduce code
> duplication and simplify future maintenance.
>
> Signed-off-by: Leonardo Cesar <leonardocesar@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 51 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 47 +----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 47 +----------------------
>  4 files changed, 55 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2956e45c9..a157cbd8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2684,3 +2684,54 @@ void amdgpu_debugfs_compute_sched_mask_init(struct=
 amdgpu_device *adev)
>  #endif
>  }
>
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +       int i, r =3D 0;
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> +       unsigned long flags;
> +
> +       if (adev->enable_mes)
> +               return -EINVAL;
> +
> +       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +               return -ENOMEM;
> +       }
> +
> +       /* assert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +       /* assert IB preemption, emit the trailing fence */
> +       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> +                                       ring->trail_fence_gpu_addr,
> +                                       ++ring->trail_seq);
> +       amdgpu_ring_commit(kiq_ring);
> +
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       /* poll the trailing fence */
> +       for (i =3D 0; i < adev->usec_timeout; i++) {
> +               if (ring->trail_seq =3D=3D
> +                       le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >=3D adev->usec_timeout) {
> +               r =3D -EINVAL;
> +               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +       }
> +
> +       /* deassert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, true);
> +       return r;
> +}
> +
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index a0cf0a3b4..77050f988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -664,6 +664,8 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 cou=
nt);
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>
> +int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
> +
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
>         switch (mode) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5097de940..ef9c61d9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6208,52 +6208,7 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct =
amdgpu_ring *ring,
>
>  static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
> -       int i, r =3D 0;
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq =3D=3D
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >=3D adev->usec_timeout) {
> -               r =3D -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> +       return amdgpu_gfx_ring_preempt_ib(ring);

There's no need to wrap this.  Just replace the call sites with the
new function.

Alex

>  }
>
>  static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool r=
esume)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 65c33823a..fc5ec2778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4613,52 +4613,7 @@ static unsigned gfx_v12_0_ring_emit_init_cond_exec=
(struct amdgpu_ring *ring,
>
>  static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  {
> -       int i, r =3D 0;
> -       struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       unsigned long flags;
> -
> -       if (adev->enable_mes)
> -               return -EINVAL;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       spin_lock_irqsave(&kiq->ring_lock, flags);
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> -               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -               return -ENOMEM;
> -       }
> -
> -       /* assert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, false);
> -
> -       /* assert IB preemption, emit the trailing fence */
> -       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMA=
P,
> -                                  ring->trail_fence_gpu_addr,
> -                                  ++ring->trail_seq);
> -       amdgpu_ring_commit(kiq_ring);
> -
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -       /* poll the trailing fence */
> -       for (i =3D 0; i < adev->usec_timeout; i++) {
> -               if (ring->trail_seq =3D=3D
> -                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> -                       break;
> -               udelay(1);
> -       }
> -
> -       if (i >=3D adev->usec_timeout) {
> -               r =3D -EINVAL;
> -               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> -       }
> -
> -       /* deassert preemption condition */
> -       amdgpu_ring_set_preempt_cond_exec(ring, true);
> -       return r;
> +       return amdgpu_gfx_ring_preempt_ib(ring);
>  }
>
>  static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t =
reg,
> --
> 2.43.0
>
