Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF61DC83029
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 15:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807E310E47B;
	Mon, 30 Jun 2025 15:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jvau++3v";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33CC10E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 15:07:25 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so594751a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751296045; x=1751900845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOr9/IJutqvmHOwlug9ojOPC32aFeZSk1fKm2e//yv8=;
 b=jvau++3vsBkIgY5do+s2FD4tIe2AWmAixmYOJUb94DDOmK+A0kB/lm6DGbV8od7h3X
 SFkrw+2hO26fpao24r3oHVy07oqpl8Pxiz0mTnBa1EXL1TrF9ixXQF5RptJ0FoMUoRde
 NdJQtNTipIIPEDaTwypGcLnvPdvxfpTdInv+TK6h93lnRmDeiopcTkU3uhmgHYinuz8X
 Ew3DK1KPSUVPCjPIXoacVxK08bsRlOfcrySrHFOLeRlGJcMln6sWrkYas/0FmePWHCkr
 H7eTHuMaOK3xAfowxl264ivqJVpbpvMgXIvID1/vk2rVhfbB4WJBGXMcKqvyQ94H9oSF
 nfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296045; x=1751900845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOr9/IJutqvmHOwlug9ojOPC32aFeZSk1fKm2e//yv8=;
 b=TzPvjEfD8L5k38v3O0XlW7kkIuur7Q7MMPD79eUpK5Y0fuROZxokJPPh3gBPYu8qi7
 PtA0tc/GWNouqWUEaf9365xwZtNQjxP4U0R/6rraSeD/ICBIiyZkCIEdg6jSt7PwehMH
 zbkcdQcuLCCrnKsmzw4uGjBEDh2g30neyYO8d06MuQLb87wCGCfO+ztrwjKgob9CCMnI
 KFDw4ksytygTFOYGA2HcSRo2HtVaM+g1r4aznEuJ8Vvw3BQ0nOUQnwQw6pEd3p7UFTTt
 PRfWRC8/dLyKYqV1/K0kNMH99HSUC9a65FpGNygOokiI0oPo7a/OCXN4FoME8UmBwe0L
 lJGw==
X-Gm-Message-State: AOJu0Ywx+IbYPqpgOPZTDDUtKaUyA0/69qqY0rN9fle2Z5B3fBw1oDsg
 1/wBo7oxtP1ZQqQc43mBJvxgbWSpzo1s7Ggv+OVm2N82EmzrCE3vd78jZ40ShqlysVHMNxV4SU/
 P/6zzOKoPMKGDCLmwL+aU+lv+d8U38tXdkA==
X-Gm-Gg: ASbGnctRmq0eLsdsap69ZuVObUPcc/limjnlFbq8BVAfj5uquA23AM44V2nShkkpVAB
 /2z1kkvgLcPSF3gsdqb6Ds/vsAYrPvBPGShZXMICbDvwATojmXX2V8PXFTCu9YPV9bAJ69OXRp2
 bv1HWy4xncckem86uXBOYdAWhv55fZeAabQvzcI44h60Rh
X-Google-Smtp-Source: AGHT+IEeQ2rAHjf93hhGZBJMJUT3wMxtOho5KJ/bSxRmPm1LJWB5VQRV1qvjE6UNwnS6tt15vw1jnE9u1J0VWi7Kg04=
X-Received: by 2002:a17:90b:2dca:b0:312:25dd:1c8b with SMTP id
 98e67ed59e1d1-318ec34194bmr5627468a91.2.1751296044902; Mon, 30 Jun 2025
 08:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250630135700.1286085-1-lijo.lazar@amd.com>
In-Reply-To: <20250630135700.1286085-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Jun 2025 11:07:13 -0400
X-Gm-Features: Ac12FXx3AzEhQ5M-22QQ9RZ6wwcZGnjhw82P-w7fGoPqILj9DfLo_6qRF3Fu1aw
Message-ID: <CADnq5_PAkaq+ZfGsm5-rFeLWVSu1_sqcBpz12Ykv-Ha79RRZLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Pass adev pointers to functions
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Mon, Jun 30, 2025 at 10:03=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Pass amdgpu device context instead of drm device context to some
> amdgpu_device_* functions. DRM device context is not required in those
> functions. No functional change.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 24 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  8 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 65 ++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 15 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 +-
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c         |  4 +-
>  6 files changed, 57 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f9c981a3ea05..ebc1a2203492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1583,16 +1583,16 @@ void amdgpu_device_program_register_sequence(stru=
ct amdgpu_device *adev,
>
>  int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
>  int amdgpu_device_link_reset(struct amdgpu_device *adev);
> -bool amdgpu_device_supports_atpx(struct drm_device *dev);
> -bool amdgpu_device_supports_px(struct drm_device *dev);
> -bool amdgpu_device_supports_boco(struct drm_device *dev);
> -bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
> -int amdgpu_device_supports_baco(struct drm_device *dev);
> +bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_px(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
> +int amdgpu_device_supports_baco(struct amdgpu_device *adev);
>  void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>                                       struct amdgpu_device *peer_adev);
> -int amdgpu_device_baco_enter(struct drm_device *dev);
> -int amdgpu_device_baco_exit(struct drm_device *dev);
> +int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> +int amdgpu_device_baco_exit(struct amdgpu_device *adev);
>
>  void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
>                 struct amdgpu_ring *ring);
> @@ -1695,7 +1695,8 @@ int amdgpu_acpi_pcie_performance_request(struct amd=
gpu_device *adev,
>                                                 u8 perf_req, bool adverti=
se);
>  int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
>                                     u8 dev_state, bool drv_state);
> -int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_s=
s ss_state);
> +int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> +                                  enum amdgpu_ss ss_state);
>  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
>  int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset=
,
>                              u64 *tmr_size);
> @@ -1726,8 +1727,11 @@ static inline void amdgpu_acpi_release(void) { }
>  static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { =
return false; }
>  static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *=
adev,
>                                                   u8 dev_state, bool drv_=
state) { return 0; }
> -static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
> -                                                enum amdgpu_ss ss_state)=
 { return 0; }
> +static inline int amdgpu_acpi_smart_shift_update(struct amdgpu_device *a=
dev,
> +                                                enum amdgpu_ss ss_state)
> +{
> +       return 0;
> +}
>  static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backl=
ight_caps *caps) { }
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index ae2d08cf027e..6c62e27b9800 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -811,18 +811,18 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_d=
evice *adev,
>  /**
>   * amdgpu_acpi_smart_shift_update - update dGPU device state to SBIOS
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu device pointer
>   * @ss_state: current smart shift event
>   *
>   * returns 0 on success,
>   * otherwise return error number.
>   */
> -int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_s=
s ss_state)
> +int amdgpu_acpi_smart_shift_update(struct amdgpu_device *adev,
> +                                  enum amdgpu_ss ss_state)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
>         int r;
>
> -       if (!amdgpu_device_supports_smart_shift(dev))
> +       if (!amdgpu_device_supports_smart_shift(adev))
>                 return 0;
>
>         switch (ss_state) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 30173daeff85..154b1f18400a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -413,19 +413,16 @@ static const struct attribute_group amdgpu_board_at=
trs_group =3D {
>
>  static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
>
> -
>  /**
>   * amdgpu_device_supports_px - Is the device a dGPU with ATPX power cont=
rol
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu device pointer
>   *
>   * Returns true if the device is a dGPU with ATPX power control,
>   * otherwise return false.
>   */
> -bool amdgpu_device_supports_px(struct drm_device *dev)
> +bool amdgpu_device_supports_px(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
>         if ((adev->flags & AMD_IS_PX) && !amdgpu_is_atpx_hybrid())
>                 return true;
>         return false;
> @@ -434,15 +431,13 @@ bool amdgpu_device_supports_px(struct drm_device *d=
ev)
>  /**
>   * amdgpu_device_supports_boco - Is the device a dGPU with ACPI power re=
sources
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu device pointer
>   *
>   * Returns true if the device is a dGPU with ACPI power control,
>   * otherwise return false.
>   */
> -bool amdgpu_device_supports_boco(struct drm_device *dev)
> +bool amdgpu_device_supports_boco(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
>         if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>                 return false;
>
> @@ -455,29 +450,24 @@ bool amdgpu_device_supports_boco(struct drm_device =
*dev)
>  /**
>   * amdgpu_device_supports_baco - Does the device support BACO
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu device pointer
>   *
>   * Return:
>   * 1 if the device supports BACO;
>   * 3 if the device supports MACO (only works if BACO is supported)
>   * otherwise return 0.
>   */
> -int amdgpu_device_supports_baco(struct drm_device *dev)
> +int amdgpu_device_supports_baco(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
>         return amdgpu_asic_supports_baco(adev);
>  }
>
>  void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev;
>         int bamaco_support;
>
> -       dev =3D adev_to_drm(adev);
> -
>         adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> -       bamaco_support =3D amdgpu_device_supports_baco(dev);
> +       bamaco_support =3D amdgpu_device_supports_baco(adev);
>
>         switch (amdgpu_runtime_pm) {
>         case 2:
> @@ -497,10 +487,12 @@ void amdgpu_device_detect_runtime_pm_mode(struct am=
dgpu_device *adev)
>                 break;
>         case -1:
>         case -2:
> -               if (amdgpu_device_supports_px(dev)) { /* enable PX as run=
time mode */
> +               if (amdgpu_device_supports_px(adev)) {
> +                       /* enable PX as runtime mode */
>                         adev->pm.rpm_mode =3D AMDGPU_RUNPM_PX;
>                         dev_info(adev->dev, "Using ATPX for runtime pm\n"=
);
> -               } else if (amdgpu_device_supports_boco(dev)) { /* enable =
boco as runtime mode */
> +               } else if (amdgpu_device_supports_boco(adev)) {
> +                       /* enable boco as runtime mode */
>                         adev->pm.rpm_mode =3D AMDGPU_RUNPM_BOCO;
>                         dev_info(adev->dev, "Using BOCO for runtime pm\n"=
);
>                 } else {
> @@ -549,14 +541,14 @@ void amdgpu_device_detect_runtime_pm_mode(struct am=
dgpu_device *adev)
>   * amdgpu_device_supports_smart_shift - Is the device dGPU with
>   * smart shift support
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu device pointer
>   *
>   * Returns true if the device is a dGPU with Smart Shift support,
>   * otherwise returns false.
>   */
> -bool amdgpu_device_supports_smart_shift(struct drm_device *dev)
> +bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev)
>  {
> -       return (amdgpu_device_supports_boco(dev) &&
> +       return (amdgpu_device_supports_boco(adev) &&
>                 amdgpu_acpi_is_power_shift_control_supported());
>  }
>
> @@ -2202,7 +2194,8 @@ static void amdgpu_switcheroo_set_state(struct pci_=
dev *pdev,
>         struct drm_device *dev =3D pci_get_drvdata(pdev);
>         int r;
>
> -       if (amdgpu_device_supports_px(dev) && state =3D=3D VGA_SWITCHEROO=
_OFF)
> +       if (amdgpu_device_supports_px(drm_to_adev(dev)) &&
> +           state =3D=3D VGA_SWITCHEROO_OFF)
>                 return;
>
>         if (state =3D=3D VGA_SWITCHEROO_ON) {
> @@ -4194,13 +4187,13 @@ static void amdgpu_device_xgmi_reset_func(struct =
work_struct *__work)
>         if (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_BACO) =
{
>
>                 task_barrier_enter(&hive->tb);
> -               adev->asic_reset_res =3D amdgpu_device_baco_enter(adev_to=
_drm(adev));
> +               adev->asic_reset_res =3D amdgpu_device_baco_enter(adev);
>
>                 if (adev->asic_reset_res)
>                         goto fail;
>
>                 task_barrier_exit(&hive->tb);
> -               adev->asic_reset_res =3D amdgpu_device_baco_exit(adev_to_=
drm(adev));
> +               adev->asic_reset_res =3D amdgpu_device_baco_exit(adev);
>
>                 if (adev->asic_reset_res)
>                         goto fail;
> @@ -4355,7 +4348,6 @@ static void amdgpu_device_set_mcbp(struct amdgpu_de=
vice *adev)
>  int amdgpu_device_init(struct amdgpu_device *adev,
>                        uint32_t flags)
>  {
> -       struct drm_device *ddev =3D adev_to_drm(adev);
>         struct pci_dev *pdev =3D adev->pdev;
>         int r, i;
>         bool px =3D false;
> @@ -4816,7 +4808,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode);
>
> -       px =3D amdgpu_device_supports_px(ddev);
> +       px =3D amdgpu_device_supports_px(adev);
>
>         if (px || (!dev_is_removable(&adev->pdev->dev) &&
>                                 apple_gmux_detect(NULL, NULL)))
> @@ -4982,7 +4974,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
>         kfree(adev->xcp_mgr);
>         adev->xcp_mgr =3D NULL;
>
> -       px =3D amdgpu_device_supports_px(adev_to_drm(adev));
> +       px =3D amdgpu_device_supports_px(adev);
>
>         if (px || (!dev_is_removable(&adev->pdev->dev) &&
>                                 apple_gmux_detect(NULL, NULL)))
> @@ -5155,7 +5147,7 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>                         return r;
>         }
>
> -       if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
> +       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
>                 dev_warn(adev->dev, "smart shift update failed\n");
>
>         if (notify_clients)
> @@ -5324,7 +5316,7 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol notify_clients)
>         }
>         adev->in_suspend =3D false;
>
> -       if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
> +       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0))
>                 dev_warn(adev->dev, "smart shift update failed\n");
>
>         return 0;
> @@ -6369,7 +6361,8 @@ static int amdgpu_device_sched_resume(struct list_h=
ead *device_list,
>                         amdgpu_vf_error_put(tmp_adev, AMDGIM_ERROR_VF_GPU=
_RESET_FAIL, 0, r);
>                 } else {
>                         dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!=
\n", atomic_read(&tmp_adev->gpu_reset_counter));
> -                       if (amdgpu_acpi_smart_shift_update(adev_to_drm(tm=
p_adev), AMDGPU_SS_DEV_D0))
> +                       if (amdgpu_acpi_smart_shift_update(tmp_adev,
> +                                                          AMDGPU_SS_DEV_=
D0))
>                                 dev_warn(tmp_adev->dev,
>                                          "smart shift update failed\n");
>                 }
> @@ -6837,12 +6830,11 @@ bool amdgpu_device_is_peer_accessible(struct amdg=
pu_device *adev,
>  #endif
>  }
>
> -int amdgpu_device_baco_enter(struct drm_device *dev)
> +int amdgpu_device_baco_enter(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
> -       if (!amdgpu_device_supports_baco(dev))
> +       if (!amdgpu_device_supports_baco(adev))
>                 return -ENOTSUPP;
>
>         if (ras && adev->ras_enabled &&
> @@ -6852,13 +6844,12 @@ int amdgpu_device_baco_enter(struct drm_device *d=
ev)
>         return amdgpu_dpm_baco_enter(adev);
>  }
>
> -int amdgpu_device_baco_exit(struct drm_device *dev)
> +int amdgpu_device_baco_exit(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>         int ret =3D 0;
>
> -       if (!amdgpu_device_supports_baco(dev))
> +       if (!amdgpu_device_supports_baco(adev))
>                 return -ENOTSUPP;
>
>         ret =3D amdgpu_dpm_baco_exit(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b299e15bb5e5..4f8632737574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2457,10 +2457,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>
>         if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
>                 /* only need to skip on ATPX */
> -               if (amdgpu_device_supports_px(ddev))
> +               if (amdgpu_device_supports_px(adev))
>                         dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DI=
RECT_COMPLETE);
>                 /* we want direct complete for BOCO */
> -               if (amdgpu_device_supports_boco(ddev))
> +               if (amdgpu_device_supports_boco(adev))
>                         dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART=
_PREPARE |
>                                                 DPM_FLAG_SMART_SUSPEND |
>                                                 DPM_FLAG_MAY_SKIP_RESUME)=
;
> @@ -2493,9 +2493,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                  * into D0 state. Then there will be a PMFW-aware D-state
>                  * transition(D0->D3) on runpm suspend.
>                  */
> -               if (amdgpu_device_supports_baco(ddev) &&
> +               if (amdgpu_device_supports_baco(adev) &&
>                     !(adev->flags & AMD_IS_APU) &&
> -                   (adev->asic_type >=3D CHIP_NAVI10))
> +                   adev->asic_type >=3D CHIP_NAVI10)
>                         amdgpu_get_secondary_funcs(adev);
>         }
>
> @@ -2560,8 +2560,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>         /* Return a positive number here so
>          * DPM_FLAG_SMART_SUSPEND works properly
>          */
> -       if (amdgpu_device_supports_boco(drm_dev) &&
> -           pm_runtime_suspended(dev))
> +       if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev=
))
>                 return 1;
>
>         /* if we will not support s3 or s2i for the device
> @@ -2834,7 +2833,7 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>                 /* nothing to do */
>         } else if ((adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO) ||
>                         (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO)) {
> -               amdgpu_device_baco_enter(drm_dev);
> +               amdgpu_device_baco_enter(adev);
>         }
>
>         dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
> @@ -2875,7 +2874,7 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
>                 pci_set_master(pdev);
>         } else if ((adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO) ||
>                         (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO)) {
> -               amdgpu_device_baco_exit(drm_dev);
> +               amdgpu_device_baco_exit(adev);
>         }
>         ret =3D amdgpu_device_resume(drm_dev, false);
>         if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 5d38276fc900..4aab5e394ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -91,7 +91,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>         if (adev->rmmio =3D=3D NULL)
>                 return;
>
> -       if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_UNLOAD))
> +       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
>                 DRM_WARN("smart shift update failed\n");
>
>         amdgpu_acpi_fini(adev);
> @@ -161,7 +161,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev=
, unsigned long flags)
>         if (acpi_status)
>                 dev_dbg(dev->dev, "Error during ACPI methods call\n");
>
> -       if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
> +       if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_LOAD))
>                 DRM_WARN("smart shift update failed\n");
>
>  out:
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 5537dcf23b5c..c2fde0e33b38 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1897,7 +1897,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct de=
vice *dev,
>  static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgp=
u_device_attr *attr,
>                                 uint32_t mask, enum amdgpu_device_attr_st=
ates *states)
>  {
> -       if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> +       if (!amdgpu_device_supports_smart_shift(adev))
>                 *states =3D ATTR_STATE_UNSUPPORTED;
>
>         return 0;
> @@ -1908,7 +1908,7 @@ static int ss_bias_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>  {
>         uint32_t ss_power;
>
> -       if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
> +       if (!amdgpu_device_supports_smart_shift(adev))
>                 *states =3D ATTR_STATE_UNSUPPORTED;
>         else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_S=
S_APU_SHARE,
>                  (void *)&ss_power))
> --
> 2.49.0
>
