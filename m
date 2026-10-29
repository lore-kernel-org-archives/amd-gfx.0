Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3E606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSrapWsA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BC7112589;
	Thu, 29 Oct 2026 22:03:19 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E07112589
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 22:03:12 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-17e82de56ccso980c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311392; cv=none;
 d=google.com; s=arc-20260327;
 b=dF+2syJoPwKjTz8RkAMPrUhXX+ZuLqyrpK1TcyJaLEZgRjDuX8HlDw0Zbsc27UEDtq
 kO/mKNDuyetV+WKZ/xvnexaNn31OI85vfh78X22oMR2oyLWUIk3cdfRQuIVjum6pCW80
 GXuydBACCo6SZjpIlmuU2vnDdBlT5HNO6to8Jrk2KIRnaT+sOfb3NcoYibAp79id1p+C
 SVsjxD7OzCMgF5JsODFZUx3D5BZIOzNlIWsE7rkUlRYXTDAqgLChFK9NvN/E+lnQzJgC
 dr8KvqhOOgOY3y0sKBt4pIgKNL398PdBlh7Mgb7Jy63CRUxh0Xmq9bH10ZsefWX0gnc2
 swjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XUfj/pzbBdUsD0WEfywPlbOLwQfu3ocN7pMp3/ZcRLw=;
 fh=qQPJ2C1cUZTI88KvdTTxpDqLRX3dsSacqfr/T5CS4Tg=;
 b=Ku3fHYsmR1Q+76dUMB2oOSopH8j9NB94YHk/OfCuO7esjHnvISR5QpQ8agrD9F3TBV
 QlkJIejt/2lyECIxML4vmth26e33Cb9Rt955lAaYDiTLfLagECIjOCrtSWtVZooDdZsu
 9pA54zUG648zg3MEY94kfwOph1fDcFpVYnbe71rKDAZJ9Qct9TNFRJE7US+KUdpp2TcZ
 44tkrCACecf0TkLQDdDl6Pa42BII02IYOhAuFhLGgy1ADFltQqMLiiWfqtPbpkPhEXAM
 1S4nfp4RlxuQq3Tv8FJE7LpQ2Y9W9wNla4xlh+kN4eugx4dgZ0UOHvKab8B6wKkUwuZZ
 PhSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311392; x=1793916192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUfj/pzbBdUsD0WEfywPlbOLwQfu3ocN7pMp3/ZcRLw=;
 b=dSrapWsANah3njhQRlp+8y5l2l+UdGL8/ueb9AJIsGDPy07VG1ZBjK/w0Oz+aR1APm
 HPLz2pb0aiCtjiSC4yufkVcd48zog/oiTXzkgnLaRTXOkJBVrXC9gRx0fPEONLFi87Qs
 N1cQlbzrJbC9U4SS8Bj+LMgciup0dzN9igvSd56N7HNTrJQ51VaTNhEJuawETYOG1nQW
 hU8EambevqTQgOeWxLXqmRy8SIE0HNQ4Paw4cSdq2yolgR35sGghlidQfppwtmraxtWN
 LjAsfRe/yF0NoA1tSuNBs3d8pt73u7wixO6nIzAymGVdHDxkmbVewvqvcVsafYJ61Iru
 5eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311392; x=1793916192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUfj/pzbBdUsD0WEfywPlbOLwQfu3ocN7pMp3/ZcRLw=;
 b=dsi6yjH7b2oGkQCBiSAOSAmucpAdRqZJabfGySj9rNtNSAB+FP6YZPxSECAKm4prG4
 axWoRd07xWqSXaqJ+35yrD0PO3qncooj3MDO3nzxtPTHInhdcIFLQkIwu5B3hKhjg51w
 YpYQOi5KKZLGERfBvt3TK8mE4ycKZuvBSHV3MsO313O/+J9lIlTzsfXJlPNhZsxH0p0e
 Xtxqyov+wM/vTTO1WFqQmu/gc2DQzJpCwiQ3vxgExYG+XcOCVceUldV4fSzp/vvq7iiT
 fuOOCU6G6a73IbfAETHEqghB0q81A58YmEjW50/MdVwpZQvwNgnwXZwVtYb4NCw+tunU
 /PbA==
X-Gm-Message-State: AFq9FYKScZNzjBY6cesYoNkRX90lqXWuh5+mf/bUk+yspPaSBO1376Q9
 hBaDsNsOl6z3oaJxn8wIZckZ9yJjujPEZs2+6raB5BaY6z5qRG8nvRHnGZJDxtITysQwpyHtO4J
 T2hg3WyT98m4R3yuUMp22+U16T5Ab900=
X-Gm-Gg: AYBFou1RVqmCJMS5+9fIV/S2MQ0wp/aSqklTnkfC+373K+j8guZggnxC5iO2v/drqQf
 uD8Mz3fCMBGFspmxWBnCBtGC3FSNLqN3X0aw6tswfAxuJeMrk4L3LoKN3iPsVlJlwCSYZRebk8D
 hbqcqaPDooJMlhWdSZT8WNZ1XVcOGM6sgVnhSgi2XyXxymHEs0Cg10FzzhlmRfzQCEbPRRYJrK+
 3B2rpoB0Fm3GO1hFUvHDbQxnemqW154nxha8fDO0KV4okTC9BYvlm+ROU9EYV8WC04qyXVLyRqf
 a0l37iZ9BbnZhG4M4WZvlZ2L/VP/ZSBswDyRjjSQeJnmrE5KKqS/LG1eM9Plr7c0TphW8XMxnO7
 c/ObKLj3XCs9dMrPUQmaqok5UrFqTAJcSiyNCbsYpJsZ08A0NAaR3foEyaimkDunW0oRjQ/h/F4
 CbFDLga1HzOH8QIMIAJ0BsyMU=
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr814858c88.0.1793311391699; Thu, 29 Oct 2026
 15:03:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025100332.110933-1-erhan.bilgili@gmail.com>
In-Reply-To: <20261025100332.110933-1-erhan.bilgili@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:03:00 -0400
X-Gm-Features: AclHuK-vekcrun3HTDuTkBiBjRsVddCCwh7kkCaKuiKGSeEDUulWCitY66U_xXM
Message-ID: <CADnq5_MCvhRKn0QnSJcfYDtzBUzC6BJBiaXEV3woHeB4Lx6QnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix duplicate dependency fence releases
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Jack.Xiao@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 4:43=E2=80=AFAM Erhan Bilgili <erhan.bilgili@gmail.=
com> wrote:
>
> drm_sched_job_add_dependency() consumes its fence reference on success
> and failure. Do not release the fence again if
> drm_sched_job_add_dependency() fails.
>
> Fixes: 41cc108b2451 ("drm/amdgpu: fix missing dma_fence_put in error path=
")
> Fixes: c1c4a8b21721 ("drm/amdgpu: grab extra fence reference for drm_sche=
d_job_add_dependency")
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c    | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sync.c
> index d6ae9974c952..4f31021b2152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -447,10 +447,8 @@ int amdgpu_sync_push_to_job(struct amdgpu_sync *sync=
, struct amdgpu_job *job)
>
>                 dma_fence_get(f);
>                 r =3D drm_sched_job_add_dependency(&job->base, f);
> -               if (r) {
> -                       dma_fence_put(f);
> +               if (r)
>                         return r;
> -               }
>         }
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index 1f44c1cc2bd5..c44b02580dd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -235,7 +235,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_upd=
ate_params *p,
>                 dma_fence_get(fence);
>                 r =3D drm_sched_job_add_dependency(&p->job->base, fence);
>                 if (r) {
> -                       dma_fence_put(fence);
>                         dma_resv_iter_end(&cursor);
>                         return r;
>                 }
> --
> 2.56.0
>
