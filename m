Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE386C5DF85
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 18:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D40C10E12C;
	Wed, 19 Aug 2026 18:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz5EYjR/";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7634C10E12C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 18:46:19 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-744ca620161so46717137.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 11:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787165178; cv=none;
 d=google.com; s=arc-20260327;
 b=qIRohqrlZsx7VurIZSivF9Wz4udv6jZ/QM4gUQGjwPq3nol89lIWhOZObHgljxdvph
 pqruzQdiX5eUUdrCR+BIXZByJsNSeao9i46+GhkrgEFpwbi9etGDsacb/lelxUu9XcR9
 Uu2o489VKdR31SoAlXlz8THwIXLABV6eNRntXkjNuVnWVd0+iuFCK63ovEl3iV3QTJFf
 BfsIRtLarwbXpU8IqGBdIh4UBAHTgi5zHBimusHh1B/kTOdaxNsYXwKzfVxLT46+c40x
 WStGqoA6A31DGSfBbL9PnVXJP9UpBY4kPr70FFNHA4eicSvK9c9U2oU2yuGAB/FakN7y
 uN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UfLG2NH8uuqt4uEQrP8cDXbdagEYsIFGZX9Ev2t60SI=;
 fh=9vOszAai2AI0Hw/GHddpUWBge+q08tJRQ7GYTWpdqCk=;
 b=r7RZWvVonKu8yatyD3UCoa9/09JFUNykmSq/ZeAaI1/pjHhgaMfdF+TqnpA68CtTdL
 XnJRix/pUVtP7NYMidHigdkIQE7sEkyCql5biXHdAQ1FqXA+P7yVLaCWKQ3Y6AIK3t7Z
 629CgaGF7pyJ04kgI43iL4PWQtRZjInX7EBp0s3chg9dnviQnH6FzXc/fUuAia4yb/5r
 2GCPDF6c7BOHtLdjFOE5HYWbANnNfa2dpUBaY5Ur7LRH1yKbbvCQiINC1ZK73EE8r20v
 B0ZGKBx8zMawfdVXD1NY9gNbFG1GEJ4B7nxFq2boD+x+jiEwQb79ttdUE/rdIt/52t1o
 ZjMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165178; x=1787769978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UfLG2NH8uuqt4uEQrP8cDXbdagEYsIFGZX9Ev2t60SI=;
 b=Dz5EYjR/okWYUQ6i4nuAoKscl7YOVG9fKiAhPu3YdnkDkpkiNh0t/pwRwFDzV9kiMc
 2wc7nlbwpY3AUOqDa0fjbEG/3hwQexIG7HKj03vDaLl046/2n3K2nwrnE/GMjZR2d4ks
 DTDO6OVC707zfeA91x1h5SI9QA2cWcOFJF04qU0Gu5Edf/k7xHb6tAh28L4z5D0Q04//
 IgzmntWZJEJllDrYzTEngRxe2aduq0rbBar+u8MIwjFi3Z9SKfUHaK7SXjHivE6wjqzr
 OTEzt8L9TOwvWezREBDehUCUi1/MYpg09ISNN9GzsOAORItgfCUysMH5zsoUXm9s7JSf
 ZX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165178; x=1787769978;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UfLG2NH8uuqt4uEQrP8cDXbdagEYsIFGZX9Ev2t60SI=;
 b=nDcfeBxC4gXQ4Ee0uUV/g2TE2DwEC5nA/E+3cep1ms7pKyp1DLAhTaz/PagdGYJl0b
 KsZS3DhceRkOui8OVykE1jtWrvbkd0NvwUK2vsyDC1maVnX0DCyaV80ZkaGVuGQ7/+0b
 8tB7wioREfDmBBB9wOyT0ewbK5N3kBE4OwpDhU/pe31UcVvNbT+yxQuj+8e8LGI+KthI
 JBC4xuhtVKTRU/2dwrH6ZVnPx8HiL36UzmBaw+uQ78OVGmWXu+eRx2NP/UIAUyJgHlM4
 RK/WHsXvob5MulpWVIgmNf9hB+ZtrhqWPi8aKh/GVVNjL8MiFni8c+2n+pFQCc7FuHZo
 n/rQ==
X-Gm-Message-State: AOJu0Yy6/sZjk7SOrYFPb8Y5uh7aG8vB+6BOCFNmL4zYhaIWJc1GCQ/A
 eys+lG6YawZgzj/YsqPn3/D+Vhtd2+o6f5PCMKLw6GMLUSYD7vyePmWeNdmjwd3wASaJowUQoqi
 xbXtX803GxQR3UXx1mXZvObG8RLPKlsc=
X-Gm-Gg: AR+sD12Wd7jUCMuFMd2st8aFoMGvD+q4pl9lLuj1RGwGnUujY5ppibBHqygiMXOvXHi
 vQV3Gq02pUnsDu0tKQaoDGwDWILFtHncC4ERQIdMeia5LOhnrsezBVvt6wQaCkfZFIOPvV10/W4
 Y584E2JTxiYIrA1qG+VYqwZ57BSyKm/0AOYQPiQm1MQX7VZ4KWWTxB/HLep0495V3RrjgDnIogA
 8P/4hGu5QYL3FX1RJXYOoKl1X4+zSCHKo9AU3O6snYZxg2ZIRmhFLLU0RyneT+TCqwbT87D9C1z
 Fg7qS7YTHfOdvMjnDyB5YBfzB9R95uh4/PpbHeOXhjKC5ASCcde4Inb/FzfQ3NiMdJyv4SfHFc6
 ZZQNt7l4/HYR1kWJO+0YfISxwBthq5zJE
X-Received: by 2002:a05:6102:41a5:b0:740:2974:57bd with SMTP id
 ada2fe7eead31-777f5a413a2mr936746137.0.1787165178019; Wed, 19 Aug 2026
 11:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260819022138.3908141-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260819022138.3908141-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Aug 2026 14:46:05 -0400
X-Gm-Features: AcwNN1VWoESduIhIwrdU0Th4fMM2d_aL2m2JsVJ-jRSiRJWmB6mwJL1rkMTzsac
Message-ID: <CADnq5_O=__oGRMPMDOaLG5sw2aG3NVuXZM5_2iQ7H2tai0CBEA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, prike.liang@amd.com, 
 Sunil Khatri <sunil.khatri@amd.com>
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

On Tue, Aug 18, 2026 at 10:40=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> On resume, amdgpu_userq_vm_validate_and_restore_queue() updates each queu=
e's
> wptr GPU address via amdgpu_bo_gpu_offset().
>
> WPTR BOs are VM-mapped, but each BO has its own reservation object and is=
 not
> implicitly covered by the VM validation path here. This can leave offset =
reads
> without proper BO locking/placement state and trigger WARN_ONs.
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1486 at amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu=
], CPU#3: kworker/3:1/116
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_userq_vm_validate_and_restore_queue+0x629/0x960 [amdgpu]
>    amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
>    process_scheduled_works+0xa6/0x460
>    worker_thread+0x13c/0x290
>    kthread+0xfb/0x140
>    ret_from_fork+0x1b6/0x2b0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1485 at amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu=
], CPU#2: kworker/2:1/127
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu]
>
> Add each queue's WPTR BO to the drm_exec ww context and validate it to it=
s
> allowed placement before the later offset update.
>
> v2:
> - Clarify that WPTR BOs are VM-mapped (fix incorrect "not part of VM" wor=
ding). (Christian)
> - Describe both parts of the fix: lock BO reservations in drm_exec and
>   validate BO placement before offset reads.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 17cc48d87c4d..ab8fc14a235b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1054,6 +1054,30 @@ amdgpu_userq_vm_validate_and_restore_queue(struct =
amdgpu_userq_mgr *uq_mgr)
>                 drm_exec_retry_on_contention(&exec);
>                 if (unlikely(ret))
>                         goto unlock_all;
> +
> +               /*
> +                * WPTR BOs are VM-mapped, but each BO has its own reserv=
ation
> +                * object. Lock them into this drm_exec ww context so the=
 later
> +                * amdgpu_bo_gpu_offset() reads are done with the BO resv=
 locked.
> +                */
> +               xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> +                       struct ttm_operation_ctx wptr_ctx =3D { false, fa=
lse };
> +
> +                       bo =3D queue->wptr_obj.obj;
> +                       if (!bo)
> +                               continue;
> +
> +                       ret =3D drm_exec_prepare_obj(&exec, &bo->tbo.base=
,
> +                                                  TTM_NUM_MOVE_FENCES + =
1);
> +                       drm_exec_retry_on_contention(&exec);
> +                       if (unlikely(ret))
> +                               goto unlock_all;
> +
> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_d=
omains);
> +                       ret =3D ttm_bo_validate(&bo->tbo, &bo->placement,=
 &wptr_ctx);
> +                       if (unlikely(ret))
> +                               goto unlock_all;
> +               }
>         }
>
>         if (invalidated) {
> --
> 2.49.0
>
