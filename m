Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6448C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 18:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420AF893ED;
	Mon, 17 Aug 2026 18:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bCwcEL2M";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C275893ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 18:52:06 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so322128a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 11:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786992725; cv=none;
 d=google.com; s=arc-20260327;
 b=lgEWlqHRUg3pSIC5TpO9KXRhqS9q2+c1m3aCD2rLKRjFEA/vcVRsoa2arloEzr9Zec
 Exr2T9PheY25VIhiF10iCBhF+sd1RbfcpkPkcX1vG+123yAlhiAy2+Jy0djI0LoWcJLc
 beZz69Dtwsb0DtYNM+Q0M83M23eEWLUsSLEZS/dGshZg5MRkVbZJmepOAg+R31CJ5IPe
 lnlVWHHLwhnOMc5bGKxXYYDhQ3s0un1SEVmAodZV9TfpeQF3vIofB1SyLkBP9kJVtTq7
 gQ/9h9Y8lbgBpz2s8i9cjwilMwZ3G9md22oa1Z3QvBbU6bh4VqQZQC/L0HepKZIsWc6B
 1JjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ou4b0AtR4xHvuwUK72lB7Z7K/msZA07xL2sldj5ekak=;
 fh=UlaLYeM5d0J9FiZIYEANT4lh6OCkKngp8m2rL0J6GOk=;
 b=HXM9bmj7Wv0x6W28nvnpE3GpjGUfI1dm8kgml1gK1EOJSfL9xK2/jU2bf5PxR3oPtk
 lk3YmMRQoyOn380is5/eGxXwwKioGhwtWb2VaUnt9B3MJCZwWFUhkeKeInj+9QA3bR6C
 vZ3uflfsScHs8o44QE0hlbD2KthYQbDKyt3z328cKnTEDziSCq0+srwagQIDxsO0pAie
 aUDzS7nQLZr53Ikb5wyoDqWCycQRujoFGRVvBSlxZP2CRuqujfjLgYmE6CAJ5GKgUJWr
 mPK7/wTlRm6faSilxHDHdo8hF3/k1/hwnqpqDGj6W8ELLiEMRaNWFkVYq56JQU0JIdHm
 Fo7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786992725; x=1787597525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ou4b0AtR4xHvuwUK72lB7Z7K/msZA07xL2sldj5ekak=;
 b=bCwcEL2MKZdnQfu2MtNditQNywXC81xFFIoaIqmBr3DAuqlRuCFHnkMMuQZ+BbawIm
 /9vvWRjJb7dWnMKzAjRvYFyve5IZxbCPlZKhbApR0ZimFeKYhIctQIqolxoS83b8OrD5
 a1hSqq6SXBVAn4oo0ARo89xIonApiNXKDeJDWXb6lmrhdj94wzogJxxHY5vU7uc2Su+a
 jvxZ8R9waSzRt+9FGvg5rBniSG2x1+L9swv8AoiomYV6x5js2jN+BmbVYIOonShXoDhg
 S8sI7PCdYhcKsMhfZqHEzvGl/LxZZbQIC/vksd4KAhUNbEEODL/pRt9ARKRJCm78lvJg
 oGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786992725; x=1787597525;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ou4b0AtR4xHvuwUK72lB7Z7K/msZA07xL2sldj5ekak=;
 b=Y94bup7mYsT67Gp8r9dFLqvEz77FMLxNUzgA02SQv5Hzgm76NNv1mnzXViNAoISCYh
 nkKMAbIWTRixVG9G44BU78YahAeKWoZ6KryxIdgLAZD8loUuh1iKKC6QHJy2qOvAojhw
 +DEOk1bq5U0gC3lQ1yBbCWc+wbLp5U6QTpS7klRmSqjiDbVO4/yz1/YlDFT6d7NQnAw+
 XDOapl7KcWui+7UprCa8qiG3GR7y1ceDzwNTUg9ETvn1DL3RnveMl1cIHAsjQALLuMK4
 7q2+eTQ/JIFgNyJ2DUFstwpwn9Fn3b9ZuemCV2kAsMg9qHnt8yHTO8WsESwJRbQOqWjw
 PlgA==
X-Gm-Message-State: AOJu0Yyey6adzy+FFXhfXyat6oxfpdE9RLi33onhir/f0nhwZeNB3tbp
 tpIyiiDMk1SpxXW3iN1fNXx4uP+dVEtH6uwMhntwi4oKWHOprxw8oIq17PFy7mXehvdsXe+DyKs
 JiXcjZkBEmHYrUSwwj+sr3QEQvFTq85MfEg==
X-Gm-Gg: AR+sD10ek/xZpUNTobCMdKC5SZUWLYzXvoyUPeStjQniFJAN+Lnq5kFuxIWuKtNRpCs
 6+nUJ3x32WtxrIIc1OOmTXPcH+kwDBf4WBP2/uuSgoGvxz0/QajgI9EUWYeY3wQ+qtleZ/2/3AN
 OF5kyNnYgwRTH/6yCS556jFRlm7NX57crV7NXkFNwYvWtAw9k89tqBsdBedvx1PJBHv2AXkf16+
 xFF3vKUP2dsinqhX76y9kMm5zZwmYUFZl8+ZHQlaohjkuPIhXQFUdKCxfOqOSDkZVEOIrejhYAx
 aUQyxb+x1qY19NDBQYhn0cUwRwCHA1vPwRb2EQv+opxuO4YBI1yBIRIPhJHV7BpPMdH7cvicdiz
 HT3fAgITlIdeY4FTmcbNPPVwmgq72heQ=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3933e6465ccmr17925232a91.3.1786992725416; Mon, 17 Aug 2026
 11:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260814172914.2691513-1-alexander.deucher@amd.com>
In-Reply-To: <20260814172914.2691513-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 14:51:53 -0400
X-Gm-Features: AcwNN1V2Um4C-MoYdOoIKxK5uAjh5e2JnSCj8JxiZqhIlUNTHYUi390pdD6qUik
Message-ID: <CADnq5_M5BLTuvYqhznLaNKR=h0z-gUdSC6p9guusYNeo7GVhbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, David Rosca <david.rosca@amd.com>
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

On Fri, Aug 14, 2026 at 1:35=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we end up emitting a VM fence keep pipeline sync
> associated with that fence.  If not, emit them as
> part of the IB fence.
>
> v2: fix need_pipe_sync handling
>
> Cc: David Rosca <david.rosca@amd.com>
> Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index da4dc489e80bd..360e6f00cb7c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 vm_af =3D job->hw_vm_fence;
>                 /* VM sequence */
>                 vm_af->ib_wptr =3D ring->wptr;
> -               amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_need=
ed,
> +               amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_nee=
ded,
>                                 &emit_gds_needed);
>                 vm_af->ib_dw_size =3D
>                         amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr,=
 ring->wptr);
> @@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned int num_ibs,
>         if (ring->funcs->insert_start)
>                 ring->funcs->insert_start(ring);
>
> +       /* this may have been handled by amdgpu_vm_flush */
> +       if (need_pipe_sync)
> +               amdgpu_ring_emit_pipeline_sync(ring);
> +
>         if (emit_spm_needed)
>                 adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 71050a86bcc3a..b7d0461184d62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring =
*ring,
>   * Emit a VM flush when it is necessary.
>   */
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -                    bool need_pipe_sync, bool *emit_spm_needed,
> +                    bool *need_pipe_sync, bool *emit_spm_needed,
>                      bool *emit_gds_needed)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -827,7 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
>         if (gds_switch_needed && emit_fence)
>                 *emit_gds_needed =3D false;
>
> -       if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> +       if (!vm_flush_needed && !gds_switch_needed && !(*need_pipe_sync) =
&&
>             !cleaner_shader_needed && !spm_update_needed)
>                 return;
>
> @@ -847,8 +847,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
>                 patch =3D amdgpu_ring_init_cond_exec(ring,
>                                                    ring->cond_exe_gpu_add=
r);
>
> -       if (need_pipe_sync)
> +       if (emit_fence && *need_pipe_sync) {
>                 amdgpu_ring_emit_pipeline_sync(ring);
> +               *need_pipe_sync =3D false;
> +       }
>
>         if (cleaner_shader_needed)
>                 ring->funcs->emit_cleaner_shader(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 7f2ba728e3ed3..d32183cd9e0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        int (*callback)(void *p, struct amdgpu_bo *bo),
>                        void *param);
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -                    bool need_pipe_sync, bool *emit_spm_needed,
> +                    bool *need_pipe_sync, bool *emit_spm_needed,
>                      bool *emit_gds_needed);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                           struct amdgpu_vm *vm, bool immediate);
> --
> 2.55.0
>
