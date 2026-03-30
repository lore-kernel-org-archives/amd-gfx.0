Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1315E1061B15
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 17:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9719B10E5FD;
	Mon, 30 Mar 2026 17:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tKHzZ1sj";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6811F10E638
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 17:12:33 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12714f01940so329494c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 10:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774890753; cv=none;
 d=google.com; s=arc-20240605;
 b=aWu1AJpMHa53plfufb/OMQRxWOy+ns2BtJhkn/Komg/dbRMwbaCYNnI5rnCMQtQvdx
 eJCSa4CH2pfsngG9j4mZsuUDq4lAZ3guHv61YJQWMyuwNtaZCFRtY0T9w77LH61Rwhxf
 P2udXhYQcnzyg2IGEOvpucZfGuYyea0sFt2ZeS7lVQ3tVZaLBRlwzsSt9zlzCJfampjv
 +agoMT9NHafma4jEskUBXAkr9iSkYC/dLvJ0aTdpEHw2lZEHnJsxKeaPRhn9yv4+RLff
 S9pYs1stpTQQ7RVoURsHuA8NLtKjnkkSWDKjiVNwcMzpL7plnMQvBpouWw3wXV3iBVN+
 PT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/Qk4TKkoYvkwDhY8ww3r8wj5bW+iC0cOTIASU54PcZw=;
 fh=+jYedTXkJMLCCAigTiD49Kv1g3JhoyfrqkQ39E6EHwU=;
 b=BMlt+am3dcHyWzwApIDvz1ng7k8+kUojwZ3y6p7HhnppjChbaYh2vSV2eBCeoQAQjD
 Fp0FgwF3mRFTUeKDqBXUm5mck/mVEfPoPG18emvNbaS2HVi/nc2A9qLJ878I8E9jI3+5
 mCmMQBQoc8Xr3fBY+Amc8Z877uWhEEPpryFO/tLC5zFm8GqWIetKnfixWf/8b9OV2PEg
 HTln6n0cKCsdqPGuxI9gVYAVu091TmBz0rb2Rl9aJLxQYUMBHKtx0tM5lcLPKzEbhATs
 wWlz8Tuoe8hoGFo5uM1Z78LBhTwHZrrxqntmE5TjWwuWgKCuSpTcsGrB3Y1m6+uGb2uv
 CpDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774890753; x=1775495553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qk4TKkoYvkwDhY8ww3r8wj5bW+iC0cOTIASU54PcZw=;
 b=tKHzZ1sjNE91riLrPoHxw6PsTyIcTob6wiudSNUQey6WQCokxrQQsENIf6l53nbvYp
 dnM4a+/efUhDjips8Dv9ou6mdNYrnjGQVy0TjlgoIwngOt0ZIfgYmtqEUhGUvEK3k+us
 LN1IT9vVARfI/kHRKKBWLCKRNA/IKQrFweTvC5h9rjPCAC+lJRAc0WuOEUdCWIiu0zJT
 GITcMOSPlVKmurDevkIqJRgrOpnbYQJRS+styYqB46EokA0czivS/tF14kNo3isDwbfJ
 QFKnn0zjKCAylZ7q6ZR5hGXdV1davTUKw/dfoSW4odMELyupDkBd0qsx+HAopyRv6Xca
 MzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890753; x=1775495553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Qk4TKkoYvkwDhY8ww3r8wj5bW+iC0cOTIASU54PcZw=;
 b=dHFtaBxFKbQnffp2nF1SoHyunWPKrKVzQZFAIwiKtuUOF1r1Ovf8cJpWkNEjpEEzDk
 3uZD6W5C6J89ynTd7tUqwsJyo67SzfnAYFpxC++oNdmqcxRQx0jHqmxYbcaql/d1qvO9
 Hsw3PfCtnZ+K0KfsRl+kbdW5T/aXmTeyVTTrli7m4XB3xRadrU0axJKj7jfp+yTNkT9W
 NmwIUfMVPXqG8OrH6Hg4qlcm2S4NgGgfDP53KNQc6hk1+YrAGUuzNXkPSCzorqwZSoh9
 MBrhoitxcPl+i2pZXlTpkQNe7kIR9fKNUb6JnZLSXQ5Yg643E7Hz9fCtM1Q5UONny3LL
 FiXg==
X-Gm-Message-State: AOJu0YzeCYvoaSE0bjjLj84g36Ja76QsAoToFjdc7QT2UTLNhOu/3qKl
 EEVAhQo1X385LggSCPJt+CmgqAPuKy487YKjF4KCKkXT7CuK9PqKKgbKHsffgVSqHcc2WfpfrY0
 DFphsiJcXmSmlPnfSNUl4n2nqZ89+mb8=
X-Gm-Gg: ATEYQzy3lUnKHh/9R6i+uJfTOfxV+u5Kz1a5N5n0pz+Uv37S/yKZD4XVkuscvHfNOCP
 FLb1M+G6qeBoLHQxzbelRtNHN1g2uLmyetM9aflcP+sbElutd2TRM/nDm80CkwyWAXgiZkch/Ex
 yPgc3h1xk1phHsvUKxiSp7/06xGOohKPCOVgMAfw1+7AigJNdFTmJhtfXGbJpp9AWfpTfY+uh2z
 fVjO23dGZJDnVu/p0frzqnusHgpjOZRp61Dih7ySBgfYp0ph1rD2IPkpYZK3KClFKTW5YPEwSv7
 9xsw5Nk6XGnYlVCRvJjhhXlxorjGTAXHCbTTjVYh4PTgWrflDBfvZm9kxcM8Tn1eiLEQuQ==
X-Received: by 2002:a05:693c:2c05:b0:2c7:3c4f:7eb7 with SMTP id
 5a478bee46e88-2c73c4f8633mr467432eec.0.1774890752371; Mon, 30 Mar 2026
 10:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
 <20260325141226.1173216-7-lijo.lazar@amd.com>
In-Reply-To: <20260325141226.1173216-7-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Mar 2026 13:12:20 -0400
X-Gm-Features: AQROBzATHO-NP6-w77Pt4-19QEot527RhbAxq_pOlJX4UVkoFU1CDgNIB7oLado
Message-ID: <CADnq5_MANKJYgXHQm8iObJw4nbaDKO0UqLwiBd7DUAg68sKuaw@mail.gmail.com>
Subject: Re: [PATCH 7/9] drm/amdgpu: Add fw vram usage reserve-region
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Feifei.Xu@amd.com
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

On Wed, Mar 25, 2026 at 12:09=E2=80=AFPM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Use reserve region helpers for initializing/reserving firmware usage
> region in virtualized environments.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  6 +--
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 12 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 54 ++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 39 +++++++-------
>  .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  8 +--
>  6 files changed, 41 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 763f2b8dcf13..956eb33008f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1685,9 +1685,9 @@ static int amdgpu_atombios_allocate_fb_scratch(stru=
ct amdgpu_device *adev)
>                         (uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERV=
ATION <<
>                         ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>                         /* Firmware request VRAM reservation for SR-IOV *=
/
> -                       adev->mman.fw_vram_usage_start_offset =3D (start_=
addr &
> -                               (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -                       adev->mman.fw_vram_usage_size =3D size << 10;
> +                       amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VR=
AM_USAGE,
> +                                         (start_addr & (~ATOM_VRAM_OPERA=
TION_FLAGS_MASK)) << 10,
> +                                         size << 10, true);
>                         /* Use the default scratch size */
>                         usage_bytes =3D 0;
>                 } else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..36e1f6b65075 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -120,9 +120,9 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struc=
t amdgpu_device *adev,
>                 (u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>                 ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>                 /* Firmware request VRAM reservation for SR-IOV */
> -               adev->mman.fw_vram_usage_start_offset =3D (start_addr &
> -                       (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -               adev->mman.fw_vram_usage_size =3D fw_size << 10;
> +               amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE=
,
> +                                 (start_addr & (~ATOM_VRAM_OPERATION_FLA=
GS_MASK)) << 10,
> +                                 fw_size << 10, true);
>                 /* Use the default scratch size */
>                 *usage_bytes =3D 0;
>         } else {
> @@ -152,9 +152,9 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struc=
t amdgpu_device *adev,
>             ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
>                 ATOM_VRAM_OPERATION_FLAGS_SHIFT)) =3D=3D 0)) {
>                 /* Firmware request VRAM reservation for SR-IOV */
> -               adev->mman.fw_vram_usage_start_offset =3D (fw_start_addr =
&
> -                       (~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -               adev->mman.fw_vram_usage_size =3D fw_size << 10;
> +               amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE=
,
> +                                 (fw_start_addr & (~ATOM_VRAM_OPERATION_=
FLAGS_MASK)) << 10,
> +                                 fw_size << 10, true);
>         }
>
>         if (amdgpu_sriov_vf(adev) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 0dde3fbfba59..674ceb24f93a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1735,22 +1735,6 @@ void amdgpu_ttm_unreserve_vram(struct amdgpu_devic=
e *adev,
>         memset(resv, 0, sizeof(*resv));
>  }
>
> -/*
> - * Firmware Reservation functions
> - */
> -/**
> - * amdgpu_ttm_fw_reserve_vram_fini - free fw reserved vram
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * free fw reserved vram if it has been reserved.
> - */
> -static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
> -{
> -       amdgpu_bo_free_kernel(&adev->mman.fw_vram_usage_reserved_bo,
> -               NULL, &adev->mman.fw_vram_usage_va);
> -}
> -
>  /*
>   * Driver Reservation functions
>   */
> @@ -1768,31 +1752,6 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struc=
t amdgpu_device *adev)
>                                                   &adev->mman.drv_vram_us=
age_va);
>  }
>
> -/**
> - * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * create bo vram reservation from fw.
> - */
> -static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
> -{
> -       uint64_t vram_size =3D adev->gmc.visible_vram_size;
> -
> -       adev->mman.fw_vram_usage_va =3D NULL;
> -       adev->mman.fw_vram_usage_reserved_bo =3D NULL;
> -
> -       if (adev->mman.fw_vram_usage_size =3D=3D 0 ||
> -           adev->mman.fw_vram_usage_size > vram_size)
> -               return 0;
> -
> -       return amdgpu_bo_create_kernel_at(adev,
> -                                         adev->mman.fw_vram_usage_start_=
offset,
> -                                         adev->mman.fw_vram_usage_size,
> -                                         &adev->mman.fw_vram_usage_reser=
ved_bo,
> -                                         &adev->mman.fw_vram_usage_va);
> -}
> -
>  /**
>   * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from dr=
iver
>   *
> @@ -2183,9 +2142,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>          *The reserved vram for firmware must be pinned to the specified
>          *place on the VRAM, so reserve it early.
>          */
> -       r =3D amdgpu_ttm_fw_reserve_vram_init(adev);
> -       if (r)
> -               return r;
> +       if (adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >
> +           adev->gmc.visible_vram_size) {
> +               adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size =
=3D 0;
> +       } else {
> +               r =3D amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_FW_VRAM_U=
SAGE);
> +               if (r)
> +                       return r;
> +       }
>
>         /*
>          * The reserved VRAM for the driver must be pinned to a specific
> @@ -2348,7 +2312,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>                                         &adev->mman.sdma_access_ptr);
>
>         amdgpu_ttm_free_mmio_remap_bo(adev);
> -       amdgpu_ttm_fw_reserve_vram_fini(adev);
> +       amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_FW_VRAM_USAGE);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index eaa26cda5780..df46f43e578c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -101,12 +101,6 @@ struct amdgpu_mman {
>
>         bool                    keep_stolen_vga_memory;
>
> -       /* firmware VRAM reservation */
> -       u64             fw_vram_usage_start_offset;
> -       u64             fw_vram_usage_size;
> -       struct amdgpu_bo        *fw_vram_usage_reserved_bo;
> -       void            *fw_vram_usage_va;
> -
>         /* driver VRAM reservation */
>         u64             drv_vram_usage_start_offset;
>         u64             drv_vram_usage_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index c8e4c6e356aa..e9b8c08051f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -437,12 +437,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_d=
evice *adev,
>         struct eeprom_table_record bp;
>         uint64_t retired_page;
>         uint32_t bp_idx, bp_cnt;
> -       void *vram_usage_va =3D NULL;
> -
> -       if (adev->mman.fw_vram_usage_va)
> -               vram_usage_va =3D adev->mman.fw_vram_usage_va;
> -       else
> -               vram_usage_va =3D adev->mman.drv_vram_usage_va;
> +       void *fw_va =3D adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.cpu_addr;
> +       void *vram_usage_va =3D fw_va ? fw_va : adev->mman.drv_vram_usage=
_va;
>
>         memset(&bp, 0, sizeof(bp));
>
> @@ -710,15 +706,16 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_d=
evice *adev)
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  {
>         uint32_t *pfvf_data =3D NULL;
> +       void *fw_va =3D adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.cpu_addr;
>
>         adev->virt.fw_reserve.p_pf2vf =3D NULL;
>         adev->virt.fw_reserve.p_vf2pf =3D NULL;
>         adev->virt.vf2pf_update_interval_ms =3D 0;
>         adev->virt.vf2pf_update_retry_cnt =3D 0;
>
> -       if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) =
{
> +       if (fw_va && adev->mman.drv_vram_usage_va) {
>                 dev_warn(adev->dev, "Currently fw_vram and drv_vram shoul=
d not have values at the same time!");
> -       } else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usa=
ge_va) {
> +       } else if (fw_va || adev->mman.drv_vram_usage_va) {
>                 /* go through this logic in ip_init and reset to init wor=
kqueue*/
>                 amdgpu_virt_exchange_data(adev);
>
> @@ -763,31 +760,32 @@ void amdgpu_virt_exchange_data(struct amdgpu_device=
 *adev)
>         uint64_t bp_block_offset =3D 0;
>         uint32_t bp_block_size =3D 0;
>         struct amd_sriov_msg_pf2vf_info *pf2vf_v2 =3D NULL;
> +       void *fw_va =3D adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.cpu_addr;
>
> -       if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) =
{
> -               if (adev->mman.fw_vram_usage_va) {
> +       if (fw_va || adev->mman.drv_vram_usage_va) {
> +               if (fw_va) {
>                         if (adev->virt.req_init_data_ver =3D=3D GPU_CRIT_=
REGION_V2) {
>                                 adev->virt.fw_reserve.p_pf2vf =3D
>                                         (struct amd_sriov_msg_pf2vf_info_=
header *)
> -                                       (adev->mman.fw_vram_usage_va +
> +                                       (fw_va +
>                                         adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_DATAEXCHANGE_TABLE_ID].offset);
>                                 adev->virt.fw_reserve.p_vf2pf =3D
>                                         (struct amd_sriov_msg_vf2pf_info_=
header *)
> -                                       (adev->mman.fw_vram_usage_va +
> +                                       (fw_va +
>                                         adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_DATAEXCHANGE_TABLE_ID].offset +
>                                         (AMD_SRIOV_MSG_SIZE_KB << 10));
>                                 adev->virt.fw_reserve.ras_telemetry =3D
> -                                       (adev->mman.fw_vram_usage_va +
> +                                       (fw_va +
>                                         adev->virt.crit_regn_tbl[AMD_SRIO=
V_MSG_RAS_TELEMETRY_TABLE_ID].offset);
>                         } else {
>                                 adev->virt.fw_reserve.p_pf2vf =3D
>                                         (struct amd_sriov_msg_pf2vf_info_=
header *)
> -                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
> +                                       (fw_va + (AMD_SRIOV_MSG_PF2VF_OFF=
SET_KB_V1 << 10));
>                                 adev->virt.fw_reserve.p_vf2pf =3D
>                                         (struct amd_sriov_msg_vf2pf_info_=
header *)
> -                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
> +                                       (fw_va + (AMD_SRIOV_MSG_VF2PF_OFF=
SET_KB_V1 << 10));
>                                 adev->virt.fw_reserve.ras_telemetry =3D
> -                                       (adev->mman.fw_vram_usage_va + (A=
MD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
> +                                       (fw_va + (AMD_SRIOV_MSG_RAS_TELEM=
ETRY_OFFSET_KB_V1 << 10));
>                         }
>                 } else if (adev->mman.drv_vram_usage_va) {
>                         adev->virt.fw_reserve.p_pf2vf =3D
> @@ -1081,13 +1079,14 @@ int amdgpu_virt_init_critical_region(struct amdgp=
u_device *adev)
>         }
>
>         /* reserved memory starts from crit region base offset with the s=
ize of 5MB */
> -       adev->mman.fw_vram_usage_start_offset =3D adev->virt.crit_regn.of=
fset;
> -       adev->mman.fw_vram_usage_size =3D adev->virt.crit_regn.size_kb <<=
 10;
> +       amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
> +                                 adev->virt.crit_regn.offset,
> +                                 adev->virt.crit_regn.size_kb << 10, tru=
e);
>         dev_info(adev->dev,
>                 "critical region v%d requested to reserve memory start at=
 %08llx with %llu KB.\n",
>                         init_data_hdr->version,
> -                       adev->mman.fw_vram_usage_start_offset,
> -                       adev->mman.fw_vram_usage_size >> 10);
> +                       adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.offset,
> +                       adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.size >> 10);
>
>         adev->virt.is_dynamic_crit_regn_enabled =3D true;
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driv=
ers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 81553230dca4..1a640b76c988 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -36,17 +36,17 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct =
ras_core_context *ras_core,
>         struct amdgpu_device *adev =3D ras_core->dev;
>         struct amdsriov_ras_telemetry *ras_telemetry_cpu;
>         struct amdsriov_ras_telemetry *ras_telemetry_gpu;
> +       void *fw_va =3D adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE]=
.cpu_addr;
>         uint64_t fw_vram_usage_start_offset =3D 0;
>         uint64_t ras_telemetry_offset =3D 0;
>
>         if (!adev->virt.fw_reserve.ras_telemetry)
>                 return -EINVAL;
>
> -       if (adev->mman.fw_vram_usage_va &&
> -           adev->mman.fw_vram_usage_va <=3D adev->virt.fw_reserve.ras_te=
lemetry) {
> -               fw_vram_usage_start_offset =3D adev->mman.fw_vram_usage_s=
tart_offset;
> +       if (fw_va && fw_va <=3D adev->virt.fw_reserve.ras_telemetry) {
> +               fw_vram_usage_start_offset =3D adev->mman.resv_region[AMD=
GPU_RESV_FW_VRAM_USAGE].offset;
>                 ras_telemetry_offset =3D (uintptr_t)adev->virt.fw_reserve=
.ras_telemetry -
> -                               (uintptr_t)adev->mman.fw_vram_usage_va;
> +                               (uintptr_t)fw_va;
>         } else if (adev->mman.drv_vram_usage_va &&
>                 adev->mman.drv_vram_usage_va <=3D adev->virt.fw_reserve.r=
as_telemetry) {
>                 fw_vram_usage_start_offset =3D adev->mman.drv_vram_usage_=
start_offset;
> --
> 2.49.0
>
