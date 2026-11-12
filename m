Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99750606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=coy5t7rd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F122D10E098;
	Thu, 12 Nov 2026 22:50:00 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B460F10E098
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:49:54 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-4a75fe043b6so44824fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794523794; cv=none;
 d=google.com; s=arc-20260327;
 b=TctOgsHW0Th2ugCxR2e9PX59udhs3TwUKMu4g6CNzuEbX+w2VqBbpILn4EdTFcVjW4
 wR2QG6322+Po0j+A9d6Fd2PTT0zSMWHmtyAco03x00avNbgTneGjQwe4J2ygI6WF9o7v
 Lk6EgB7oCR3F4ELToN4yGHkJDJO6NHzk0JquKhN6Jyl4Zu4f/JXWRy0TrUl5kpzDOIzh
 x29EgRoYirU1YFkZDb5wCFAshw/wejFKMPbrNcXLjpDWZ68WkJOgzb6vZ+uVAp5xoI+S
 TOY5ZY0RHAZBhCjxJ6XQxi/6N5rxGimCoIOd/smo8yN/pzIUC6WeIliVSyXMoEimnjNS
 RMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hweaDnyXvZiFAH3B35dnxaNa30/mth5d0jGm9uDRLjs=;
 fh=AyWQXr+Y7caAIcVuHpYENxXJMBoNjSK4OHaf4yXuLyw=;
 b=k/uxPKETRodUSUmUs1WVYjjAH6gs5s7JaPG6mQmQXmv4AP4eRUJxvW5g2DCbzQ9lPf
 yUFRtflAH99ljybKjJKhuhdiDNf+uptawzVRWSAlhgvceAXJcN56WHpI4a3f+WquhUOw
 t3oDo0FViHyzzmFH9Jm8nGzdlLsoCTGfCupWDahXuWhQFN5qvVwSbaA9Xw6SWYyynTxL
 hAYoMhmVMnHr9MaLUp+plCOL0d7dFFsvnNOy8skzmwjmCLM0uiK+HeXSY7N+vD6uS74q
 dJgAj1NPI4pz67XpmwIAx31vHQVmNcgtiQQ8UbOtqjRKWhOtGBcJVkhwNjh2e9v1J2fd
 0aYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794523794; x=1795128594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hweaDnyXvZiFAH3B35dnxaNa30/mth5d0jGm9uDRLjs=;
 b=coy5t7rdKO6AAiIBClJZBbMgtNHOoVFQPKGscA84lR/5ijLKqQdwbRL9doVbz/Dpzr
 DNzWExdnChEVnCvRXOa9U3T0q4hSuWLXIcqpGu2Q33BPOacQimBdvBZ/PqbXl8A8DzO/
 yqU0YkOitLUsxyOFJD436cd9mwb1mZJ8sIlcz0K5W9+9O2uVHs20at1XQhno4/LnX50b
 qEWFhid6cVpB9zipdzAhqrMmbHkw8MrkIfWPdfCk00V4zbQhD8eoxc4AZY1ogtv6YTQi
 b+MbkVJyrwnBsIcbcWubbp0Kog39dO9mXfRdsDFu7vKbf16mioUegp8woAOzalx1NhIK
 BKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794523794; x=1795128594;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hweaDnyXvZiFAH3B35dnxaNa30/mth5d0jGm9uDRLjs=;
 b=0nh/fmzHWI+gxEFs75DKHlUSRI6uz08MYGUIS1bs+O8s6nFjZGIoFeHH3WmWNbKf3n
 Cq5CmwF+IGhN2TjpQ6t0/9ANTXKtZU9ovkdVw3gVX83ax9Ytdz0nJtHeKYUS4rNBW+gE
 4YzMDEcEBvTrrSyCWjaM2/yuYCujiS7x/rYYARMUrdwEb/FMa7H0Cdx9x/+bVnmzMkUD
 FBbH0EEjHWqxEkSyLIjl2CwK1TF+Nvkch4Vy2GcQvr8U7tdsGG2cYZ01tR2fcep+0zvs
 Kz9vXO5XFJjxRT2x3jLsCJMSmWGefSmp3/f0LCyZPIpuXvcZjTahIS4+YiHrf7rc6jDy
 H3yA==
X-Gm-Message-State: APuU4Z9xU4nFuecqUv2E2thrjJfe1EN0LzHhB+9Met8TdrbzStz61HTQ
 jOef40iGRD0QwkqbhRtkiUcz1ASGCPG2SSm5MpLtDvSmYtTi925RvYuA+afnf5P8eVdzAMImqSv
 vdEkr/RcbaqjwQbtuaS8kssIAhUSCd0c=
X-Gm-Gg: AYBFou37pfmoLG9yVaI3nvP+N9FbYyEu4KBjpwBErsuBUi4uc8ztQJIGnos/sMK5/i7
 GlIUsqDoYCg+4KOo/0Uprulg2wPqBPt4VUHCylQhT0IcEllwWSWb08/Ifq2847KIjaC/xZzxR6Z
 Arn3QH3LCarMFOmIwYxm9OK8ZH4THQ01isEQvSjyf1e6glTCax2zBASC4ZZbg1Fz/4+NATAg2/c
 Usu/gbTQh3kSC0CLUF4y+8Us7zCWsZuvRpaZkFxAtnXOgChkjZaDAcbmCM7UYr788BxaGStZKvO
 0rSu1Uifp2p7ZxOpccan39GvLd+UOXtV2zRYw7zMz5vxJ0hovfQba+a5t6iEHn3mhSvOIcFemTR
 gRHKQGSm1U+PfzJB750kSKsslfPbYH7IgDohMMGD2Srkc0md4alQrBr3eqoSH5Kopn5FL9J9MI5
 QpSNcXpUDuzsmwHqau1P3GWBiFbZdv3CGGaH2xRyl7VI/jpJ/xV2etYwZFAcs=
X-Received: by 2002:a05:6808:1914:b0:55b:f88d:baa5 with SMTP id
 5614622812f47-56e66a9517emr897374b6e.6.1794523793566; Thu, 12 Nov 2026
 14:49:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112212417.1769071-1-alexander.deucher@amd.com>
In-Reply-To: <20261112212417.1769071-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:49:42 -0500
X-Gm-Features: AclHuK_PC3FBswSMFRNtCvmYxGqw2zSvP8mTVjOlZrJT-rZbSD6mAjeuSBax4xI
Message-ID: <CADnq5_P0ZYuzvTrqOfu-2qV6zD_YfWrCoWxYbK6Fu7d=pT1EdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Ignore this patch and the v2.  They need to be reworked.

Alex

On Thu, Nov 12, 2026 at 5:21=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This largely reverts commit 90b1b26bb030d6c666f8cad52cd3d8019d404ad9.
>
> Not emitting the spm update via the ring causes CI flakeyness on
> gfx11.  Add back the SPM ring emission, but skip the MMIO path
> if ring is specified.
>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB pat=
h")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 15 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  4 ++--
>  11 files changed, 49 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 324d25c77897a..1ff5d5cfb141d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -750,7 +750,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct a=
mdgpu_ring *ring,
>         ring->reemit =3D true;
>         amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
>         if (emit_spm_needed)
> -               ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ri=
ng->xcc_id,
> +               ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ri=
ng->xcc_id, NULL,
>                                                            ring->adev->vm=
_manager.spm_vmid);
>         spin_lock_irqsave(&ring->fence_drv.lock, flags);
>         do {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 6210edf1937aa..a24cdf5852a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -213,7 +213,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>                 amdgpu_ring_emit_pipeline_sync(ring);
>
>         if (emit_spm_needed)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring,
>                                                      adev->vm_manager.spm=
_vmid);
>
>         if (emit_gds_needed)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_rlc.h
> index e38a8ea02c520..2ae2c1d0f702b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
>         void (*reset)(struct amdgpu_device *adev);
>         void (*start)(struct amdgpu_device *adev);
>         void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
> -                       unsigned int vmid);
> +                       struct amdgpu_ring *ring, unsigned vmid);
>         bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t=
 reg);
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 7683e8a0a4380..f226758b15467 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8187,7 +8187,7 @@ static void gfx_v10_0_update_spm_vmid_internal(stru=
ct amdgpu_device *adev,
>  }
>
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> -               unsigned int vmid)
> +               struct amdgpu_ring *ring, unsigned int vmid)
>  {
>         amdgpu_gfx_off_ctrl(adev, false);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..ac814c12d60f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amd=
gpu_ring *ring,
>  static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_=
id);
>  static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xc=
c_id);
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> +                                     struct amdgpu_ring *ring,
>                                       unsigned int vmid);
>  static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2606,7 +2607,7 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_devic=
e *adev)
>          * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM=
 VMID
>          * once it runs, also after a GPU reset or a resume.
>          */
> -       gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +       gfx_v11_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmi=
d);
>
>         return 0;
>  }
> @@ -5615,12 +5616,21 @@ static int gfx_v11_0_update_gfx_clock_gating(stru=
ct amdgpu_device *adev,
>  }
>
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> -               unsigned int vmid)
> +               struct amdgpu_ring *ring, unsigned vmid)
>  {
>         u32 reg, pre_data, data;
>
> -       amdgpu_gfx_off_ctrl(adev, false);
>         reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +       if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
> +           ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +            (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +               data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << R=
LC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +               amdgpu_ring_emit_wreg(ring, reg, data);
> +               return;
> +       }
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
>         if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev=
))
>                 pre_data =3D RREG32_NO_KIQ(reg);
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index df2fb09bbcd86..07f981f27bcc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -287,6 +287,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amd=
gpu_ring *ring,
>  static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_=
id);
>  static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xc=
c_id);
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> +                                     struct amdgpu_ring *ring,
>                                       unsigned int vmid);
>  static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2158,7 +2159,7 @@ static int gfx_v12_0_rlc_resume(struct amdgpu_devic=
e *adev)
>          * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM=
 VMID
>          * once it runs, also after a GPU reset or a resume.
>          */
> -       gfx_v12_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +       gfx_v12_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmi=
d);
>
>         return 0;
>  }
> @@ -3978,12 +3979,22 @@ static void gfx_v12_0_update_perf_clk(struct amdg=
pu_device *adev,
>
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>                                       int xcc_id,
> +                                     struct amdgpu_ring *ring,
>                                       unsigned vmid)
>  {
>         u32 reg, data;
>
> -       amdgpu_gfx_off_ctrl(adev, false);
>         reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +       if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
> +           ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) ||
> +            (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) {
> +               data =3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << R=
LC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +               amdgpu_ring_emit_wreg(ring, reg, data);
> +               return;
> +       }
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
>         if (amdgpu_sriov_is_pp_one_vf(adev))
>                 data =3D RREG32_NO_KIQ(reg);
>         else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c044..2bbe83d98563a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -217,7 +217,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(str=
uct amdgpu_device *adev);
>  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>         struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xc=
c_id,
> -                                     unsigned int vmid);
> +                                     struct amdgpu_ring *ring, unsigned =
vmid);
>
>  static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel=
,
>                                    int mem_space, int opt, uint32_t addr0=
,
> @@ -1866,7 +1866,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_d=
evice *adev,
>         int r;
>
>         /* init spm vmid with 0xf */
> -       gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid=
);
> +       gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.sp=
m_vmid);
>
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
>                 gfx_v12_1_xcc_init_csb(adev, xcc_id);
> @@ -2945,7 +2945,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu=
_device *adev,
>
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>                                       int xcc_id,
> -                                     unsigned int vmid)
> +                                     struct amdgpu_ring *ring,
> +                                     unsigned vmid)
>  {
>         u32 reg, data;
>
> @@ -2962,6 +2963,14 @@ static void gfx_v12_1_update_spm_vmid(struct amdgp=
u_device *adev,
>                 WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_=
MC_CNTL, data);
>         else
>                 WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL=
, data);
> +
> +       if (ring
> +           && amdgpu_sriov_is_pp_one_vf(adev)
> +           && ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
> +               || (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE))) =
{
> +               uint32_t reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id=
), regRLC_SPM_MC_CNTL);
> +               amdgpu_ring_emit_wreg(ring, reg, data);
> +       }
>  }
>
>  static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 72c84b61fda16..43dea0810137b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3256,7 +3256,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *=
adev)
>
>         /* init spm vmid with 0xf */
>         if (adev->gfx.rlc.funcs->update_spm_vmid)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_ma=
nager.spm_vmid);
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev-=
>vm_manager.spm_vmid);
>
>         return 0;
>  }
> @@ -3483,7 +3483,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device=
 *adev)
>  }
>
>  static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -               unsigned int vmid)
> +               struct amdgpu_ring *ring, unsigned vmid)
>  {
>         u32 data;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 4666aa5b38c75..360a958f7577d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1276,7 +1276,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *=
adev)
>
>         /* init spm vmid with 0xf */
>         if (adev->gfx.rlc.funcs->update_spm_vmid)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_ma=
nager.spm_vmid);
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev-=
>vm_manager.spm_vmid);
>
>         return 0;
>  }
> @@ -5484,7 +5484,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_=
device *adev, int xcc_id)
>  }
>
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -               unsigned int vmid)
> +               struct amdgpu_ring *ring, unsigned vmid)
>  {
>         u32 data;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..0b01801b0571b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5227,7 +5227,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struc=
t amdgpu_device *adev,
>  }
>
>  static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -               unsigned int vmid)
> +               struct amdgpu_ring *ring, unsigned int vmid)
>  {
>         amdgpu_gfx_off_ctrl(adev, false);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index da031caa4e9e6..30c8b751849cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1397,7 +1397,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device=
 *adev)
>  {
>         /* init spm vmid with 0xf */
>         if (adev->gfx.rlc.funcs->update_spm_vmid)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_ma=
nager.spm_vmid);
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev-=
>vm_manager.spm_vmid);
>
>         return 0;
>  }
> @@ -1609,7 +1609,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_devi=
ce *adev)
>  }
>
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -                                             int inst, unsigned int vmid=
)
> +                                             int inst, struct amdgpu_rin=
g *ring, unsigned int vmid)
>  {
>         u32 reg, pre_data, data;
>
> --
> 2.56.0
>
