Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97561CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 13:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC9F10E0C1;
	Fri, 16 Oct 2026 13:41:02 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41AA10E0C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 13:40:56 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3ac7538422bso352724a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 06:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792158056; cv=none;
 d=google.com; s=arc-20260327;
 b=lTmSbn+0uRSC6Mu/838FmzcXuwtdtpCtAmHcSNJc5Raj4W9HSOS1gQ1MsjmVPWkqh2
 uhnLwNnISK184SK4rCnpd3gh1HgNGHZiryy9lanq8z6neErPakj4SQicVVRpE9w9HvHW
 hVGHNJfweL4oHrLtr3kGutUDt23SieLMcwsS3vTQ/5zEOab6Q6hC4Zn+82V3lugZUZHv
 +MEcBmlefXIusd0vsh3xFUV2+d61YTj5oFoRBa2W3Jngis/7Ol19dqiPflB/8z6FMa7l
 WmPCLeK2BmIX1o7X9f3K0pc/k6tqdVWflWOSRSHdVLiyaxxPKYiQo2plr/UDkvrI2w6z
 neHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xaurz2IJKiWqBzCe6AWOSxvpnubj+QEDLk5LNyxGM3k=;
 fh=DQDkEk7cjH9qo/qhbOOcdFrMUCzIapL/8r1jm50U0nw=;
 b=rXXXra0v1yiJpi4MKWarN7jnzcuwK1EGz3a3YtI0GPQvEW1Tp8GM/b69y09ayssoec
 JuhxuNei4pSfB1paLHB+l2kIKZ+fKCUz9RNNrIixfYdxNNkxODIJIoAK7QRKK+M1rrSa
 HEj34UOHuIfjMmGH1vsG6o11jwNBy/spPiWppN48ye6o6HwI5jhN0vFaSgfbbQ8wnkDf
 7qpM2bDtST41b5Vz6E+oVz8v/9DnIO1WwHlGaE244IYTxkBulGEMt1nJdoReShoE0xhY
 Mw0V6l8UPEHm/oOTIRmxCNXY1kju2TZ8tZrnkBmTVDGwZ4ovBZpGjgEj35zIgvWfHaB7
 yK4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792158056; x=1792762856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xaurz2IJKiWqBzCe6AWOSxvpnubj+QEDLk5LNyxGM3k=;
 b=ZjSb9Eju/7cPqmYXtZWB/DaInC5uFsSdCEbYgi00Tc+JIcovdlN6i92UABGpA93zSh
 kUjpEm7zI6kbB+ul4ywsb1xlAtA61dZJvSbISRLAoO+XC785gICWR75O1p3jQHDOkC4p
 EjC9EHranetD8fZlyHPRrB7y8Etfz2xmwdcRSYD2KxzcE7+2dUoU4ITY5QRm7wV5o3sE
 skfojzMCgITP9zdJL+EbQw3kJJoVEg3OMosuL7yNhRH33TT9vAS7kFt0C6eLONKIFrU9
 STqLC4+wgAzi3sgfErQWiahoh9Xk/arQy5VxhY81eIJRzxBNcih5yo8ANtfZl+a7FA0S
 cFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158056; x=1792762856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xaurz2IJKiWqBzCe6AWOSxvpnubj+QEDLk5LNyxGM3k=;
 b=vWZLm6LMBoaTY8LWYnS1U2+HLo7r31FEZxxVfp5NTLbCE5ZciZC4IpMYRQg3g37cDi
 B28xaYsRiDvG6J5DVcHV7YAbd2nr3WRJAn7XvI32wKkUnPL9XQKA14CxCr1R6Lr2gLXR
 NgFuu9tKLZZYJlbV/E3y8Acn5yMweqCyzybYPVuNUYOTj4gVX/IUxikpcLr7vhPKd+Ao
 4e5SutW9IqGqcUrP1pZnr6xv7Ey6sdl2HJi3izEEv1xY2Oi3YiKzsXfbNv9LiE7gP4SG
 5mCqEjFifdSzh4c3tnFTSwDBedMobNBIFoP4mLRSl24n6O8+i0ZYvcGTF+g7tG+ysFtY
 tWbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIbRdresWjQV7JS5/WvXYvD0TENTgkqu6QSRS367+I9bE4d+IFrnzii149gWW7+qiKygRGwOKs@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKuD6CABKjsk7X8Un+UsnY1RFZR98F6h/7CMtZs4FgQiktv5U+F
 cNd/05DXS/QjJvYFqLhSz1bvOy2LpLnKm3NOMBBUllHSmhYLNFXjaDo89mb5kghbIP0h03dbi0I
 lM/pEze2h+vobDA0wnDS4THduhI5qzR0=
X-Gm-Gg: AYBFou3fv2khdM6OZASkTcup5ZPgnA83DJPqei6Cq2aTFBWxzrk7oUKXGHMvrj+Kf8z
 05C1cJnkZYsDWfRjObqkH/Qd3NXuwlqjs54AbSCqtXkATmyHGBOSaJwTK5nA5r+svvpq07TLdiv
 lJfCb29J7vpHoou5UNBbCCCnuSOEETDpM6DM0aioBSuonheN5sGBsMeujIJz4bwKJhWYqPw2h3E
 xpdt8ao6nUmcb/fImyR9s7Rk/w8H/JUA3ceCYGE+jXUhhWtFftl336feZG0VmMhKqBakNtoSKZV
 pM5HwKQMuRtOR/0zvf/3TFDsjGC1xNCUhGxwy8t4rqdIPw7nNPx/KrxuivDpqcEJ9Kp5CwWq48s
 9Hfz4lADXRW5CEiSEx4OY4qXnQc4snc8tWdwZz126kw==
X-Received: by 2002:a17:90b:1d04:b0:3ac:a11a:7c88 with SMTP id
 98e67ed59e1d1-3aca11a7dfemr8165055a91.3.1792158056034; Fri, 16 Oct 2026
 06:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261016030734.1091829-1-sunil.khatri@amd.com>
In-Reply-To: <20261016030734.1091829-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:40:43 -0400
X-Gm-Features: AclHuK91W3XEn3IkFbfzeUXNkxQ8UXxGTDYVr2Q9MBxyUiVnKnovuAMhRMcWOEU
Message-ID: <CADnq5_MHvsck_FG77bF5ybSBak+cz5DSt36XOsFK3WhkquN6ng@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu/userq: commit seq64 BO mapping for
 userqueues
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Oct 15, 2026 at 11:07=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> The seq64 sync BO's PTE update only ran from the legacy CS path, so
> userqueue-only clients never got it mapped and their fence_drv could
> never signal completion. Commit it in
> amdgpu_userq_vm_validate_and_restore_queue() too, the same way prt_va
> is already handled there, so it covers both queue creation and
> post-eviction restore.
>
> Fixes: ae05e3f3d02b812c ("drm/amdgpu: move amdgpu_vm_bo_update() call int=
o correct location")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 4dca1ab48410a..0c92534131b9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1083,6 +1083,14 @@ amdgpu_userq_vm_validate_and_restore_queue(struct =
amdgpu_userq_mgr *uq_mgr)
>                 if (unlikely(ret))
>                         goto unlock_all;
>
> +               if (fpriv->seq64_va) {
> +                       ret =3D drm_exec_prepare_obj(&exec, &fpriv->seq64=
_va->base.bo->tbo.base,
> +                                                  TTM_NUM_MOVE_FENCES + =
1);
> +                       drm_exec_retry_on_contention(&exec);
> +                       if (unlikely(ret))
> +                               goto unlock_all;
> +               }
> +
>                 /*
>                  * WPTR BOs are VM-mapped, but each BO has its own reserv=
ation
>                  * object. Lock them into this drm_exec ww context so the=
 later
> @@ -1140,6 +1148,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct =
amdgpu_userq_mgr *uq_mgr)
>         if (ret)
>                 goto unlock_all;
>
> +       if (fpriv->seq64_va) {
> +               ret =3D amdgpu_vm_bo_update(adev, fpriv->seq64_va, false)=
;
> +               if (ret)
> +                       goto unlock_all;
> +       }
> +
>         key =3D 0;
>         /* Validate User Ptr BOs */
>         list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status=
) {
> @@ -1203,6 +1217,10 @@ amdgpu_userq_vm_validate_and_restore_queue(struct =
amdgpu_userq_mgr *uq_mgr)
>          * it explicitly (as the CS path syncs it) before restarting queu=
es.
>          */
>         dma_fence_wait(fpriv->prt_va->last_pt_update, false);
> +
> +       if (fpriv->seq64_va)
> +               dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
> +
>         dma_fence_wait(vm->last_update, false);
>
>         xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> --
> 2.34.1
>
