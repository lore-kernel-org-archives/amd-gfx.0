Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773D4CCF9FC
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 12:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1764C10E135;
	Thu, 30 Oct 2025 12:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8vLF39d";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72CE10E135
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 12:51:56 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7a2687cb882so165174b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761828716; x=1762433516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IJzgPUzCdSNdEwZJLYYLoBpg6OBGdeLb9Tmkft1lQU=;
 b=R8vLF39dVQdKl36x5VeAMUAbzmqXsQHbh6qD9wXkf1Tq8pYq0eKSNCmxW1vguEPw4w
 hDkjzo56FrSdYiUhLBQ7sueFg3H/JOcCEmIapFZCStCzVB3zoZK9heelEIuP//4TnDfo
 5NpjgyPbYbUO1XIFN40M3H5POoX1TMUIW5veRIIV6GfZkZwrDYzX+AIHSRxrcY2g/nBl
 1vyFqKGgBrMRrpLES4stYq7KcKHKtp1XeNgsjsKVQnFhCoChrS3NH33DHPilvADN+9I9
 p6fJyTIkAlG+8a9NsgIE5AbkWxajkwiz7/E+GmwqW6p322VFhUyfVi/Vt9o/+TVPINRC
 CyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761828716; x=1762433516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IJzgPUzCdSNdEwZJLYYLoBpg6OBGdeLb9Tmkft1lQU=;
 b=rr+n+raJTRCubM2g7NoAMHePtnh/U9cK55CRtllZxIHcJ9Ix+Hw533HMCNbHgccny/
 9e8EJWb20QU7BsmNQ9U93jJc3aWCe1pJ87sk7jxmJnR4aiU4CFh4bAqFeBA7MQN+ao9K
 7sAdZWiGV+m2UQmgrYFUThsLwxK3htQ3UefIq0v62Yy/GvZaZ6fMliQrqg1cOHoMYmjb
 kNFSz17N3wtBjv29Ao57cQfXKkqx3DwV3wUndHt46iIZDToLbB6F3WmXugmL0kvNKp46
 PxFNruHaXwQbVfFqRS6S2pYkXuCLiIXmNzyYTUoMeuPQBruVVRYaEfHQJZKuO6KNZtxf
 mYWA==
X-Gm-Message-State: AOJu0YysaqXRIMQH6j9AK0TpvbJo51kB6p2Ulpy6E4PSr1Tdog11tqT+
 1KZj7CaGcog1/2F7lRHQ5495BKER/Xsx3O9wjEZZzyDEBsxPYfo6qnCU/fNAgIJYrCPEG3nAb8X
 v0evys5mLsIJj8QCm9Ro5ekaLbe0KsP8=
X-Gm-Gg: ASbGnctPgeNDTo2tdzj/N3TFFheTKaxe/5JebpMrbscrXGRSpvzh8gimoiZniSJuDHl
 oVJRdSe17nuE0Q2G4FyzAz2rnhLpsc4yk6Szgm9Edmlwb1b/dhgJjPefCL5k9Zen0/ASkfX0HRj
 A0JE5aP//u5MRsOqdr4oinMidz1VogJrmTkIGEjWv7e2KiZEIZNrFys3/a9tyVFuNzbZHeZlXsh
 cSMkGeHBUckBZ+uGKb5AnVkWgK2ILXl4viFDCft4FHHStcxx6n359xuF3UW
X-Google-Smtp-Source: AGHT+IGdoaRyO3UmV6V38/90OjmuAecFZ4X93QC85kqeUjxq/lRcLnX3tM0Z1serWS2sujdO3KYeq2MM+j6ffIEtxUg=
X-Received: by 2002:a17:902:8c92:b0:294:9847:fbfc with SMTP id
 d9443c01a7336-294def6c333mr30589605ad.11.1761828716350; Thu, 30 Oct 2025
 05:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251027220255.507105-1-alexander.deucher@amd.com>
In-Reply-To: <20251027220255.507105-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 08:51:44 -0400
X-Gm-Features: AWmQ_bkIepxIAnUOM7CQJSog9VBTZqDXMfKNUq_qPOfPNJ_z2STc_DSmO_tSfN0
Message-ID: <CADnq5_Piw=8hGjp3Pad6fnc2jmm9BhoEavVBacyqOUaP-U9Ejg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <Jesse.Zhang@amd.com>
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

Ping?

On Mon, Oct 27, 2025 at 6:03=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we don't end up initializing the fences, free them when
> we free the job.
>
> v2: take a reference to the fences if we emit them
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 39229ece83f83..0596114377600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 return r;
>         }
>         *f =3D &af->base;
> +       /* get a ref for the job */
> +       dma_fence_get(*f);
>
>         if (ring->funcs->insert_end)
>                 ring->funcs->insert_end(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 55c7e104d5ca0..dc970f5fe601b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>         amdgpu_sync_free(&job->explicit_sync);
>
> +       if (job->hw_fence->base.ops)
> +               dma_fence_put(&job->hw_fence->base);
> +       else
> +               kfree(job->hw_fence);
> +       if (job->hw_vm_fence->base.ops)
> +               dma_fence_put(&job->hw_vm_fence->base);
> +       else
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> +       if (job->hw_fence->base.ops)
> +               dma_fence_put(&job->hw_fence->base);
> +       else
> +               kfree(job->hw_fence);
> +       if (job->hw_vm_fence->base.ops)
> +               dma_fence_put(&job->hw_vm_fence->base);
> +       else
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index db66b4232de02..f8c67840f446f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>                 if (r)
>                         return r;
>                 fence =3D &job->hw_vm_fence->base;
> +               /* get a ref for the job */
> +               dma_fence_get(fence);
>         }
>
>         if (vm_flush_needed) {
> --
> 2.51.0
>
