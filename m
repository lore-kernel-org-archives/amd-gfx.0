Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38D606A319
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ECrPidsJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A3710E0A4;
	Mon, 19 Oct 2026 21:13:19 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6902110E0A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 21:13:13 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-14f0e9c6543so73693c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792444392; cv=none;
 d=google.com; s=arc-20260327;
 b=iub8b/83bau0bAGr9oiUwQ8vJ0eas91KdVFDi0D1zVVKAHi7SLujY59Pj+NgIkuOde
 lxeOk0CRKZ9vuvFinOQIq3hBnPR4ola4Z6TsxLo1ShlCZkKQFJbDUPrv/icz0LsQjNE1
 5mhTK2P4Ufg+dd4oy0J8LLM1T/6kXtLaZNvtnFEwlIu8GYbkCsPPvSqRmhDc4Ysnqj3T
 7UM5v4qZ3b3OMzyoRj6962LhvbZDDZj6GppdLVguJeL3UJC7gQ8jYbwaXBXGxSCg4l4w
 20Ct2BoJwEYtQlNkbx/jVZ632Z6Uzog9dG798e06XKTaMc+s4Cb/3dBZhz4eqeWHgc+a
 N/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+u0/ej1RUpMXPKNzUFUwIWxWWxunNvLylGs2S64cp0o=;
 fh=ZlSltIR2c1VucsJDFdvxd+YzV1bCwiej+/u2AzQzY5M=;
 b=MxCj1iNhuTXP926XzNweUXDagLppiQaZW9lhRUPw31+LskhN7z+uUYUtuSxYDRBqi9
 +Ky6Om3lLPwCKh244GJKsyIyNZzAPZv/zvQfL7ufeZAIYcEdv1V5AJ6GbzbpzVD3b4SG
 tiUMSw2iHMvO6/N+M/AeVdQGbSrBnhz6ExNy5Kan4DkSApjCSIor7/evv4l79Mbboh/0
 5IgbPzo2bFLpfaJ0VIfzzH8gTxgrm/+G0XwotOmUenIjC9CzXE2cR5cXocpTt7Tlcg1A
 HDxkVegbZMJI9D90OGyypqc3Vg4KJV7nAleAcdquuc9rsEDfwCz8SVfooWC2g2yyaz+y
 Slhg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792444392; x=1793049192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+u0/ej1RUpMXPKNzUFUwIWxWWxunNvLylGs2S64cp0o=;
 b=ECrPidsJzM9UmXtmBNYC4ykAy6uk8V3G3pK+bVxukvmrnfC1VjrdMTXFYuTbELxrwE
 tKhGNErjmuTC6qjbIIvgEj2mKvo27oBfi8kR331h/3TpuC2TPpSC9thYrB5wbx61PdCG
 McuQMcSeyWDJBkLjOxCD/FJEwBXGbVvF+VqA+9rXXkf8w8PLmEG4vqM9I2d1QzeNUzZR
 Zm9s08VO7DkjOiwNqTztZ5OuuFJkJQTSquPWwAHOFci7OEkgeAsvMc4Uyn/pGcsIjli5
 vXarznXCLiy7P2DFfOkrpySB6FpdVW37ZzozpmhalQbImhblNOQVlJLEICU9byOnaB2l
 KnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444392; x=1793049192;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+u0/ej1RUpMXPKNzUFUwIWxWWxunNvLylGs2S64cp0o=;
 b=KwX9dmvnlR267gblRLmN65DyNKBB1D3rSt5WoTB9nSSIGjh44b8nYJrZSvu+epW1yn
 k/5HXq+YJ+VlvtN7E0GUyKQrqVsNvdqRHqik0pbgYQos9wJuYUGD55YbAG91VsANDkQh
 54cGvHkN7mjWo93oJ9ng9Elv1vt5cn1uxuYlC5mZeurr2mSXxi6lSB+egn4mdowpgjGm
 7kKwJdx7EFr95LC+cMdh9MlG6PvnUGp8N/vmRKQT5GT4z/uT0vZw/ILwLvp08BAmIuGD
 3/SwEWD55iWLZFC8JlNCu2215vdf82U/KG0R3Jqn3l0Xi8ruxLKxfMoPsdhO1ne/t81l
 ptGw==
X-Gm-Message-State: AFq9FYKnTU3IL8rTgqc1s4TgKjFN5W/O/Ay4zzbbz0N5Gvvq5B3TXm1y
 TKuSMcFOC5ctLVLFwyzW4MUUMH8JuDspmUkyI/Z0YAPKAgPA7KIHcg8z3OnN675qirZ51vPKxRC
 9Zm96nKG8x8Z6syfDcnyMJID3pwN32JM=
X-Gm-Gg: AYBFou2MOu8K0GXPJWiuRNBksAPHjJcu7GJtlwIz2NHpCuKT1nWRrP1Blcj3loxVQxw
 GedQtxsT0/hgMzeFsAj/9FdkoLQzoOfHyvM1VM5bcgAJeGmsTZH66y8XSjzNso2+IuOkd0IqwDh
 2rS1pDOQbh4x+b3pMrNu5NeInANT6U0isqrHSRHrm5Wmzug2f0GlnWgFg9eDgxDEdTNEwpBVSTJ
 FvbOUFUOW7jw09JPGMIZBIayebiSH6vZ+aFwA1EWLNUvN9fksqi0v13CUvoO9VUpZ1ZOFNfsMru
 CKGkH8XIZKdfPVH26NLAYB8YmpGz6P4QZ9XKytarQUto+92GkhsjEWcOmXfGiyRFw1BRLbSMnV3
 Ka+DFa4skAXXGZgE/hbhcNJ1zetaapqZkEwI1jFSYsg==
X-Received: by 2002:a05:7022:170a:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-185106a1606mr19774919c88.2.1792444392486; Mon, 19 Oct 2026
 14:13:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
In-Reply-To: <20261015193037.86472-1-olivier.kaloudoff@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 17:13:00 -0400
X-Gm-Features: AclHuK9TjQWYJtM07AD8TEdUXn195kFGDqL8uo3lD1u9rNJQkP8enhdhDKZG-_k
Message-ID: <CADnq5_OTyZaSXmpQa32zU_DjJ3Y9tvPgrmZsftUCrhmrpcbuCA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: guard VCE/UVD sched entity teardown on
 failed probe
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, tvrtko.ursulin@igalia.com, 
 phasta@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

Alex

On Thu, Oct 15, 2026 at 3:41=E2=80=AFPM Olivier Kaloudoff
<olivier.kaloudoff@gmail.com> wrote:
>
> Since commit 037b98a2312e ("drm/amdgpu: move UVD and VCE sched entity
> init after sched init"), drm_sched_entity_init() for the VCE and UVD
> kernel entities runs in the scheduler-init phase, well after the
> IP-block sw_init phase has allocated the vcpu_bos.
>
> If probe fails between the two phases, amdgpu_device_fini_sw() still
> runs the per-IP sw_fini callbacks for blocks that did complete
> sw_init. Both amdgpu_vce_sw_fini() and amdgpu_uvd_sw_fini() then call
> drm_sched_entity_destroy() on an entity that was never initialized:
> entity->rq is NULL and drm_sched_entity_flush() dereferences it,
> oopsing in whatever context drove the failed probe.
>
> The hole was latent-but-safe until commit 2df5efb45425 ("drm/sched:
> Remove redundant entity->rq initialization and checks") removed the
> if (!entity->rq) early return that commit 1decbf6bb0b4 ("drm/sched:
> Fix entities with 0 rqs.") had put in drm_sched_entity_flush(), on the
> grounds that entity->rq can never be NULL. That holds only for
> entities that completed drm_sched_entity_init() =E2=80=94 not for the
> never-initialized entity this teardown path reaches.
>
> Observed on real hardware: MI50 (Vega20, VCE 4.0 / UVD 7.2) behind a
> Thunderbolt link =E2=80=94 a pciehp presence/link-change event re-probes =
the
> device; when the re-probe fails (-EINVAL here), the cleanup path
> NULL-derefs inside drm_sched_entity_flush() in the pciehp IRQ thread
> and takes the whole machine down (panic_on_oops, EFI pstore capture).
> Reproduced twice on 7.3-rc5, 2026-10-06 and 2026-10-09, identical
> signature; the faulting instruction is `mov (%rax),%r15` on rax =3D
> entity->rq =3D=3D NULL, i.e. `sched =3D entity->rq->sched`:
>
>   BUG: kernel NULL pointer dereference
>   RIP: drm_sched_entity_flush+0x34/0x2d0 [gpu_sched]
>   drm_sched_entity_destroy
>   amdgpu_vce_sw_fini
>   vce_v4_0_sw_fini
>   amdgpu_device_fini_sw
>   ...
>   pciehp_configure_device
>   pciehp_handle_presence_or_link_change
>
> Guard the entity teardown on entity->rq, which is set only by
> drm_sched_entity_init(). amdgpu_ring_fini() already self-guards via
> the rings[] registration, and the vcpu_bo/firmware cleanup still runs
> as before.
>
> v2: retarget Fixes: at commit 2df5efb45425 ("drm/sched: Remove
> redundant entity->rq initialization and checks") =E2=80=94 the !entity->r=
q
> check from commit 1decbf6bb0b4 ("drm/sched: Fix entities with 0
> rqs.") that Alex pointed to was removed by it in the 7.3 window,
> so this is a regression there, not a pre-existing hole.
>
> Fixes: 2df5efb45425 ("drm/sched: Remove redundant entity->rq initializati=
on and checks")
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index ecd7caa95..cd35ff7ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -377,7 +377,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>         void *addr =3D amdgpu_bo_kptr(adev->uvd.ib_bo);
>         int i, j;
>
> -       drm_sched_entity_destroy(&adev->uvd.entity);
> +       if (adev->uvd.entity.rq)
> +               drm_sched_entity_destroy(&adev->uvd.entity);
>
>         for (j =3D 0; j < adev->uvd.num_uvd_inst; ++j) {
>                 if (adev->uvd.harvest_config & (1 << j))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 1f7a98cdc..3952af9ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -253,7 +253,8 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>         if (adev->vce.vcpu_bo =3D=3D NULL)
>                 return 0;
>
> -       drm_sched_entity_destroy(&adev->vce.entity);
> +       if (adev->vce.entity.rq)
> +               drm_sched_entity_destroy(&adev->vce.entity);
>
>         for (i =3D 0; i < adev->vce.num_rings; i++)
>                 amdgpu_ring_fini(&adev->vce.ring[i]);
> --
> 2.39.5
