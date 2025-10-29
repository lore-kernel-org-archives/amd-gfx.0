Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C300CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 21:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D68810E84F;
	Wed, 29 Oct 2025 21:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5MRoH/E";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A540110E84F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 21:19:23 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-7a2687cb882so60036b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761772763; x=1762377563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HztwhMdK2guT91T0y7pZEhLi2Iw0mfNvqsC/mRK9EE=;
 b=A5MRoH/EmdryeeYHLqoQ/Pc6M1Y+oh9zf3Yxb9RVKFP/mLnSXiSSwvMndY8veWEZQ0
 uCSDrjewgFeOMDCGrUUSG5wJ4ns40zyG4fGxDWgJUSPMObTyb/pae8pM+Ez0nYxG0sOy
 01OnwsioY84xVapmTCs5l69D94GqzTnQJNh7lDXLiRg11xaF8Fp8fEkEjK4e1GoY5/U2
 8MIdKwHVNCc70MrcmsJMsOEuBAPIOydC5T8QAPaSuHkYWsagvgBxyOVaqQhdWLBsYm+F
 6Xgru1J46MVu5pyeW8o7JngD3JlDM+N494VlRFIN4Qvunl2LDhblj1OgTZ21Sxo+VGNt
 74aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761772763; x=1762377563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HztwhMdK2guT91T0y7pZEhLi2Iw0mfNvqsC/mRK9EE=;
 b=DmbsHF7K36K8rs7b1XGCpABtUsVKyEKdJXTGjrl9qFg8KZgYLXp9hJ2S1TWLbu0OuO
 66SGe+IvWyr0ApyhCsc2vOkzuY2BkAP9+cLVnV0+Z9qdMx6qlQDjhqxWNpzJLyrEcpFP
 ryyLYslXLCJ4wxfMGVuneaviZeO3U7ou7HUNwPrSyYQo1nRd41NTtabk3pygsmwATor9
 D2Xi+zKKMMnUD2WmL/4/Ypt94gxL8vkvZvC9+px8dfq3LWGL9KGJtaMdNLPtJ9sJq3cK
 6w3Tp8SRnstEeI4O5JOAsoXsVs9jNDqkMabkIdt3XAWW3A25BsJvXZzLWHJ84bdbH+CQ
 +2PQ==
X-Gm-Message-State: AOJu0YzY66zwTUsVZR1uvtsw7I/tkZbM1ReGYPWEB6WUZW/cmK7Rj9O4
 9uPqtSM4rQ0np3eJxo/T7+vAa8/pYwNoHb6KqZz2cen+YsPb80KF5pL2SKtsHFaUjR72LykwauA
 E37oAcfg/00LnyEgt8GhFzzPHV4H8hkZ83A==
X-Gm-Gg: ASbGnct7f01MS5LTlbqVml110oW2wKVw41CcfidSKBWa2a1lc0I9idYmDw91LPBaihQ
 GHlLzxV5OqOco+MvxQJoB/EsnBBe/ZZrHnvymzdPg9sjG4BxQtNQlXKmxQpkom572PZKMG7YLuz
 Sa+TaGn0uNO4Ank3eTFmoEVt82pYHsqj+hrpFKobM37NM3C9AWR6WvWUWVv4/mGn6HH+XC3H3Iz
 OIl8+PuZ2jjWGm/DUX92rKn2t49KA8lwACmChGIteYWYx3t0zS14+HNNIo1
X-Google-Smtp-Source: AGHT+IFdlgGitx3rjDlXe6bEc/8WVwdaoxZGZbshMr1z/aQ8pcnnwbpgMHotcwI7IbNwszscqyOLwO2toNAQd70USBU=
X-Received: by 2002:a17:902:d2d0:b0:294:ef99:e7ee with SMTP id
 d9443c01a7336-294ef99ee5fmr1516585ad.6.1761772763028; Wed, 29 Oct 2025
 14:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251023165243.317153-1-mario.limonciello@amd.com>
 <20251023165243.317153-2-mario.limonciello@amd.com>
In-Reply-To: <20251023165243.317153-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Oct 2025 17:19:11 -0400
X-Gm-Features: AWmQ_bm6FYppJuNoMh5YrXZ4-YPzdFTpe8ohJiomqxvibCnnPOrNWFhExvmObu0
Message-ID: <CADnq5_N784+4XCPF3VCvpWZ86wKmfcbYrkvaEsU6jgNufrcOaQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/amd: Unwind for failed device suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Oct 23, 2025 at 12:53=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If device suspend has failed, add a recovery flow that will attempt
> to unwind the suspend and get things back up and running.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
>  1 file changed, 72 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3ffb9bb1ec0b..645b15aa34f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5231,7 +5231,7 @@ void amdgpu_device_complete(struct drm_device *dev)
>  int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> -       int r =3D 0;
> +       int r, rec;
>
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
> @@ -5247,8 +5247,9 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>                         return r;
>         }
>
> -       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
> -               dev_warn(adev->dev, "smart shift update failed\n");
> +       r =3D amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
> +       if (r)
> +               goto unwind_sriov;
>
>         if (notify_clients)
>                 drm_client_dev_suspend(adev_to_drm(adev), false);
> @@ -5259,16 +5260,16 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>
>         r =3D amdgpu_device_ip_suspend_phase1(adev);
>         if (r)
> -               return r;
> +               goto unwind_smartshift;
>
>         amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_r=
unpm);
>         r =3D amdgpu_userq_suspend(adev);
>         if (r)
> -               return r;
> +               goto unwind_ip_phase1;
>
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> -               return r;
> +               goto unwind_userq;
>
>         amdgpu_ttm_set_buffer_funcs_status(adev, false);
>
> @@ -5276,16 +5277,79 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
>         if (r)
> -               return r;
> +               goto unwind_evict;
>
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_release_full_gpu(adev, false);
>
>         r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>         if (r)
> -               return r;
> +               goto unwind_ip_phase2;
>
>         return 0;
> +
> +unwind_ip_phase2:
> +       /* suspend phase 2 =3D resume phase 2 + resume phase 1 */
> +       rec =3D amdgpu_device_ip_resume_phase2(adev);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-initialize IPs phase2: =
%d\n", rec);
> +               return r;
> +       }
> +       rec =3D amdgpu_device_fw_loading(adev);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to reload firmwares: %d\n", r=
ec);
> +               return r;
> +       }
> +       rec =3D amdgpu_device_ip_resume_phase1(adev);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-initialize IPs phase1: =
%d\n", rec);
> +               return r;
> +       }
> +
> +unwind_evict:
> +       if (adev->mman.buffer_funcs_ring->sched.ready)
> +               amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +       amdgpu_fence_driver_hw_init(adev);
> +
> +unwind_userq:
> +       rec =3D amdgpu_userq_resume(adev);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-initialize user queues:=
 %d\n", rec);
> +               return r;
> +       }
> +       rec =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !ade=
v->in_runpm);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-initialize kfd: %d\n", =
rec);
> +               return r;
> +       }
> +
> +unwind_ip_phase1:
> +       /* suspend phase 1 =3D resume phase 3 */
> +       rec =3D amdgpu_device_ip_resume_phase3(adev);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-initialize IPs phase1: =
%d\n", rec);
> +               return r;
> +       }
> +
> +unwind_smartshift:
> +       rec =3D amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
> +       if (rec) {
> +               dev_warn(adev->dev, "failed to re-update smart shift: %d\=
n", rec);
> +               return r;
> +       }
> +
> +unwind_sriov:
> +       if (amdgpu_sriov_vf(adev)) {
> +               rec =3D amdgpu_virt_request_full_gpu(adev, true);
> +               if (rec) {
> +                       dev_warn(adev->dev, "failed to reinitialize sriov=
: %d\n", rec);
> +                       return r;
> +               }
> +       }
> +
> +       adev->in_suspend =3D adev->in_s0ix =3D adev->in_s3 =3D false;
> +
> +       return r;
>  }
>
>  static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
> --
> 2.51.1
>
