Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC26E74ADB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE30D10E266;
	Tue,  3 Dec 2024 21:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HezaLVmw";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB7E10E266
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:34:13 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7fb9b79ec6aso474537a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Dec 2024 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733261653; x=1733866453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZQJ8fENtAghqTJ672lWeFkpNP4yeHgQbninGLYqCfE=;
 b=HezaLVmwxZ8NXkWGknH4BjVa5UpM02xwactrbVtD4Np6lUR7+fCR2IiYY8NV4gltAZ
 oVZrzbxtJ0WHMNrRILtiP3TF7jSeiHkl3sHvm0OmD5b714Vg3XcaYmiFpUoULQS0F9Rh
 X/+rIN4Kaor9eIy8ebcAIxsqFtmfi5jT9WwgdFhXprJjXv7HaCjh27JDBDl/9Q6yjkN1
 vxInzC5k0Tc3CIkHXjbbbs3DXVoAbLoDE1ewMAkTZXtZp5xrdf+FyPzryPgHkzwJy+qn
 EcQwnM4gAKe7QFGBByHlf2awpWid63fc30oWyorIdJeizMdqT1fVM1S43oIVoTyexD+J
 BRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733261653; x=1733866453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZQJ8fENtAghqTJ672lWeFkpNP4yeHgQbninGLYqCfE=;
 b=Ne8RyY+ck6YF6Iz+uj73VFSfaFR4R87UZS5vWe6gDwhMrFTOtlw5rERbGRpu19ODm6
 OBYcdSqOcn/3I4FyBxELbS7gys5fk8pvaeK/4sAxDAG6dx9JxtFs48qVyNnP7hYtF0mj
 OSuH93fC5bjHTj9sU+/0zVGkDqlDEz0BSpxz+VzSFfw4vIMN/Uq5SgEiH3s1yNwD36Mg
 UCU2RijS7XO57wNpYPckYsAyhI/hrnVhpCn0zd0mIVFW/juWrF4uR9bgvxhYxbLns/xR
 FyqkaMZAs4zLhcLwLy0ddDnqhpuANhXjY0ZiQsrujarDfCGyf7yyWhNLaFGM0hwaFNQ8
 TfUg==
X-Gm-Message-State: AOJu0Yw5cqYYDOkfFFzq5QfoouoXa4lop0QB5tRCWLvqTN0JTzvsbk3a
 eXZsizwLgt4fnezdQ0NQwC2pkVgs0nVhMhIJhxnhd4CY3xVjWGfW5XntgJyIzBReFOS9ObYueSk
 vaQBcD5cHEk8Gl3djEkVmd0vdMQYuG+U+
X-Gm-Gg: ASbGncuFq7d8eY1lwAovDm9kEdNY5ga83h2kxgpT8QyCaDOlCM6cC7l+B1zgLJRtoOh
 +k54FmPSMW2uQ47KMMbkdPa3SdwNfQG0=
X-Google-Smtp-Source: AGHT+IFYo0B2+rbVVmR5Kn2zkQ8CJQz+5k7U8YXBEyckoSLuJbAygJhJP4D0MmsTcm9Tt0jn0SewDMw47KlnGeHNmBo=
X-Received: by 2002:a05:6a00:3a12:b0:71e:5b2b:9927 with SMTP id
 d2e1a72fcca58-7257fa42635mr2378152b3a.1.1733261652576; Tue, 03 Dec 2024
 13:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20241203181403.23515-1-mario.limonciello@amd.com>
In-Reply-To: <20241203181403.23515-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Dec 2024 16:34:00 -0500
Message-ID: <CADnq5_MfGC=f-+=eT4g0hMQtqjJxX-GuHDOPLV9Z3KsUFg98rA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
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

On Tue, Dec 3, 2024 at 1:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some of the firmware that is loaded by amdgpu is not actually required.
> For example the ISP firmware on some SoCs is optional, and if it's not
> present the ISP IP block just won't be initialized.
>
> The firmware loader core however will show a warning when this happens
> like this:
> ```
> Direct firmware load for amdgpu/isp_4_1_0.bin failed with error -2
> ```
>
> To avoid confusion for non-required firmware, adjust the amd-ucode helper
> to take an extra argument indicating if the firmware is required or not.
>
> On non-required firmware use firmware_request_nowarn() instead of
> request_firmware() to avoid the warnings.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c        |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 18 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c       |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h      |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c          |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c          |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 12 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c         |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 ++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 ++++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c     |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  3 ++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  3 ++-
>  35 files changed, 136 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_cgs.c
> index 16153d275d7a..68bce6a6d09d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -414,7 +414,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_de=
vice *cgs_device,
>                                 return -EINVAL;
>                         }
>
> -                       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, =
"%s", fw_name);
> +                       err =3D amdgpu_ucode_request(adev, &adev->pm.fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
> +                                                  "%s", fw_name);
>                         if (err) {
>                                 DRM_ERROR("Failed to load firmware \"%s\"=
", fw_name);
>                                 amdgpu_ucode_release(&adev->pm.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 16b9b3c4190c..83f0de30317e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2483,6 +2483,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
> +                                  AMDGPU_UCODE_NOT_REQUIRED,
>                                    "amdgpu/%s_gpu_info.bin", chip_name);
>         if (err) {
>                 dev_err(adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.c
> index d52f18393970..56cc179fca26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -77,7 +77,8 @@ static int isp_load_fw_by_psp(struct amdgpu_device *ade=
v)
>                                        sizeof(ucode_prefix));
>
>         /* read isp fw */
> -       r =3D amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", =
ucode_prefix);
> +       r =3D amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_NOT_=
REQUIRED,
> +                               "amdgpu/%s.bin", ucode_prefix);
>         if (r) {
>                 amdgpu_ucode_release(&adev->isp.fw);
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index a67e6a52347f..bb946fa1e912 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1438,10 +1438,12 @@ int amdgpu_mes_init_microcode(struct amdgpu_devic=
e *adev, int pipe)
>                          pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "" : "1");
>         }
>
> -       r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe], "%s", fw_na=
me);
> +       r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe], AMDGPU_UCOD=
E_REQUIRED,
> +                                "%s", fw_name);
>         if (r && need_retry && pipe =3D=3D AMDGPU_MES_SCHED_PIPE) {
>                 dev_info(adev->dev, "try to fall back to %s_mes.bin\n", u=
code_prefix);
>                 r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
> +                                        AMDGPU_UCODE_REQUIRED,
>                                          "amdgpu/%s_mes.bin", ucode_prefi=
x);
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 12832fd834fb..3043ec5d3a31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3290,7 +3290,8 @@ int psp_init_asd_microcode(struct psp_context *psp,=
 const char *chip_name)
>         const struct psp_firmware_header_v1_0 *asd_hdr;
>         int err =3D 0;
>
> -       err =3D amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_=
asd.bin", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->psp.asd_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_asd.bin", chip_name);
>         if (err)
>                 goto out;
>
> @@ -3312,7 +3313,8 @@ int psp_init_toc_microcode(struct psp_context *psp,=
 const char *chip_name)
>         const struct psp_firmware_header_v1_0 *toc_hdr;
>         int err =3D 0;
>
> -       err =3D amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_=
toc.bin", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_toc.bin", chip_name);
>         if (err)
>                 goto out;
>
> @@ -3475,7 +3477,8 @@ int psp_init_sos_microcode(struct psp_context *psp,=
 const char *chip_name)
>         uint8_t *ucode_array_start_addr;
>         int err =3D 0;
>
> -       err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_=
sos.bin", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_sos.bin", chip_name);
>         if (err)
>                 goto out;
>
> @@ -3751,7 +3754,8 @@ int psp_init_ta_microcode(struct psp_context *psp, =
const char *chip_name)
>         struct amdgpu_device *adev =3D psp->adev;
>         int err;
>
> -       err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_t=
a.bin", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE=
_REQUIRED,
> +                                  "amdgpu/%s_ta.bin", chip_name);
>         if (err)
>                 return err;
>
> @@ -3786,7 +3790,8 @@ int psp_init_cap_microcode(struct psp_context *psp,=
 const char *chip_name)
>                 return -EINVAL;
>         }
>
> -       err =3D amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_=
cap.bin", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->psp.cap_fw, AMDGPU_UCOD=
E_NOT_REQUIRED,
> +                                  "amdgpu/%s_cap.bin", chip_name);
>         if (err) {
>                 if (err =3D=3D -ENODEV) {
>                         dev_warn(adev->dev, "cap microcode does not exist=
, skip\n");
> @@ -3909,7 +3914,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct de=
vice *dev,
>         if (!drm_dev_enter(ddev, &idx))
>                 return -ENODEV;
>
> -       ret =3D amdgpu_ucode_request(adev, &usbc_pd_fw, "amdgpu/%s", buf)=
;
> +       ret =3D amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQU=
IRED,
> +                                  "amdgpu/%s", buf);
>         if (ret)
>                 goto fail;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 113f0d242618..b3c032f249f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -219,9 +219,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device =
*adev,
>         amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, si=
zeof(ucode_prefix));
>         if (instance =3D=3D 0)
>                 err =3D amdgpu_ucode_request(adev, &adev->sdma.instance[i=
nstance].fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s.bin", ucode_prefix)=
;
>         else
>                 err =3D amdgpu_ucode_request(adev, &adev->sdma.instance[i=
nstance].fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s%d.bin", ucode_prefi=
x, instance);
>         if (err)
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index d3cd76c6dab3..ffbb3377e0f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1434,6 +1434,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_d=
evice *adev, int block_type,
>   *
>   * @adev: amdgpu device
>   * @fw: pointer to load firmware to
> + * @required: whether the firmware is required
>   * @fmt: firmware name format string
>   * @...: variable arguments
>   *
> @@ -1442,7 +1443,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_d=
evice *adev, int block_type,
>   * the error code to -ENODEV, so that early_init functions will fail to =
load.
>   */
>  int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmwa=
re **fw,
> -                        const char *fmt, ...)
> +                        enum amdgpu_ucode_required required, const char =
*fmt, ...)
>  {
>         char fname[AMDGPU_UCODE_NAME_MAX];
>         va_list ap;
> @@ -1456,7 +1457,10 @@ int amdgpu_ucode_request(struct amdgpu_device *ade=
v, const struct firmware **fw,
>                 return -EOVERFLOW;
>         }
>
> -       r =3D request_firmware(fw, fname, adev->dev);
> +       if (required =3D=3D AMDGPU_UCODE_REQUIRED)
> +               r =3D request_firmware(fw, fname, adev->dev);
> +       else
> +               r =3D firmware_request_nowarn(fw, fname, adev->dev);
>         if (r)
>                 return -ENODEV;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index 4150ec0aa10d..827d75185d83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -551,6 +551,11 @@ enum amdgpu_firmware_load_type {
>         AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>  };
>
> +enum amdgpu_ucode_required {
> +       AMDGPU_UCODE_NOT_REQUIRED,

Maybe:
AMDGPU_UCODE_OPTIONAL instead?  Either way.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       AMDGPU_UCODE_REQUIRED,
> +};
> +
>  /* conform to smu_ucode_xfer_cz.h */
>  #define AMDGPU_SDMA0_UCODE_LOADED      0x00000001
>  #define AMDGPU_SDMA1_UCODE_LOADED      0x00000002
> @@ -604,9 +609,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_f=
irmware_header *hdr);
>  void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hd=
r);
>  void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr=
);
>  void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header=
 *hdr);
> -__printf(3, 4)
> +__printf(4, 5)
>  int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmwa=
re **fw,
> -                        const char *fmt, ...);
> +                        enum amdgpu_ucode_required required, const char =
*fmt, ...);
>  void amdgpu_ucode_release(const struct firmware **fw);
>  bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>                                 uint16_t hdr_major, uint16_t hdr_minor);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_umsch_mm.c
> index bd2d3863c3ed..dde15c6a96e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -587,7 +587,8 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsc=
h_mm *umsch)
>                 break;
>         }
>
> -       r =3D amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_nam=
e);
> +       r =3D amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE=
_REQUIRED,
> +                                "%s", fw_name);
>         if (r) {
>                 release_firmware(adev->umsch_mm.fw);
>                 adev->umsch_mm.fw =3D NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 31fd30dcd593..30e9869a0584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -260,7 +260,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       r =3D amdgpu_ucode_request(adev, &adev->uvd.fw, "%s", fw_name);
> +       r =3D amdgpu_ucode_request(adev, &adev->uvd.fw, AMDGPU_UCODE_REQU=
IRED, "%s", fw_name);
>         if (r) {
>                 dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \=
"%s\"\n",
>                         fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 599d3ca4e0ef..65387f6943b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -158,7 +158,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, un=
signed long size)
>                 return -EINVAL;
>         }
>
> -       r =3D amdgpu_ucode_request(adev, &adev->vce.fw, "%s", fw_name);
> +       r =3D amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQU=
IRED, "%s", fw_name);
>         if (r) {
>                 dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \=
"%s\"\n",
>                         fw_name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 05f01f50194b..2455cc126e59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -99,9 +99,13 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>         amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, size=
of(ucode_prefix));
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
>                 if (i =3D=3D 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) =
=3D=3D  IP_VERSION(4, 0, 6))
> -                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
> +                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw,
> +                                                AMDGPU_UCODE_REQUIRED,
> +                                                "amdgpu/%s_%d.bin", ucod=
e_prefix, i);
>                 else
> -                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw, "amdgpu/%s.bin", ucode_prefix);
> +                       r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[=
i].fw,
> +                                                AMDGPU_UCODE_REQUIRED,
> +                                                "amdgpu/%s.bin", ucode_p=
refix);
>                 if (r) {
>                         amdgpu_ucode_release(&adev->vcn.inst[i].fw);
>                         return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 83cb9f565fe5..2c12840ea444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -236,7 +236,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
>         int ret;
>
>         amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(=
fw_prefix));
> -       ret =3D amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin"=
, fw_prefix);
> +       ret =3D amdgpu_ucode_request(adev, &adev->vpe.fw, AMDGPU_UCODE_RE=
QUIRED,
> +                                  "amdgpu/%s.bin", fw_prefix);
>         if (ret)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 1563e35da0fe..a5cd950c94be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -133,9 +133,11 @@ static int cik_sdma_init_microcode(struct amdgpu_dev=
ice *adev)
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 if (i =3D=3D 0)
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma.bin", =
chip_name);
>                 else
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma1.bin",=
 chip_name);
>                 if (err)
>                         goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index f1b35b4a73ff..c4e15418e187 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4138,18 +4138,21 @@ static int gfx_v10_0_init_microcode(struct amdgpu=
_device *adev)
>         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp%s.bin", ucode_prefix, w=
ks);
>         if (err)
>                 goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me%s.bin", ucode_prefix, wk=
s);
>         if (err)
>                 goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_ce%s.bin", ucode_prefix, wk=
s);
>         if (err)
>                 goto out;
> @@ -4173,6 +4176,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_mec%s.bin", ucode_prefix, w=
ks);
>         if (err)
>                 goto out;
> @@ -4180,6 +4184,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_mec2%s.bin", ucode_prefix, =
wks);
>         if (!err) {
>                 amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC=
2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index f63a06661f86..67cd42031571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -641,6 +641,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu=
_device *adev, const char *
>         int err =3D 0;
>
>         err =3D amdgpu_ucode_request(adev, &adev->psp.toc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_toc.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -690,6 +691,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_dev=
ice *adev)
>
>         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -707,6 +709,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_dev=
ice *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -722,9 +725,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_de=
vice *adev)
>                 if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 0, 0) &&
>                     adev->pdev->revision =3D=3D 0xCE)
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc=
_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/gc_11_0_0_rlc_=
1.bin");
>                 else
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc=
_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_rlc.bin", u=
code_prefix);
>                 if (err)
>                         goto out;
> @@ -737,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_dev=
ice *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_mec.bin", ucode_prefix);
>         if (err)
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index ebb09c363803..d0697b0869e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -539,6 +539,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu=
_device *adev, const char *
>         int err =3D 0;
>
>         err =3D amdgpu_ucode_request(adev, &adev->psp.toc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_toc.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -568,6 +569,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_dev=
ice *adev)
>         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -575,6 +577,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_dev=
ice *adev)
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0=
_STACK);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me.bin", ucode_prefix);
>         if (err)
>                 goto out;
> @@ -583,6 +586,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_dev=
ice *adev)
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_rlc.bin", ucode_pre=
fix);
>                 if (err)
>                         goto out;
> @@ -595,6 +599,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_dev=
ice *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_mec.bin", ucode_prefix);
>         if (err)
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 81c185a8b3a0..1b4c0dcee7e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -337,6 +337,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -345,6 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         adev->gfx.pfp_feature_version =3D le32_to_cpu(cp_hdr->ucode_featu=
re_version);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -353,6 +355,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         adev->gfx.me_feature_version =3D le32_to_cpu(cp_hdr->ucode_featur=
e_version);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_ce.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -361,6 +364,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         adev->gfx.ce_feature_version =3D le32_to_cpu(cp_hdr->ucode_featur=
e_version);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_rlc.bin", chip_name);
>         if (err)
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 60931396f76b..17a07e1adffa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -934,33 +934,39 @@ static int gfx_v7_0_init_microcode(struct amdgpu_de=
vice *adev)
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp.bin", chip_name);
>         if (err)
>                 goto out;
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me.bin", chip_name);
>         if (err)
>                 goto out;
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_ce.bin", chip_name);
>         if (err)
>                 goto out;
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_mec.bin", chip_name);
>         if (err)
>                 goto out;
>
>         if (adev->asic_type =3D=3D CHIP_KAVERI) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_mec2.bin", chip_nam=
e);
>                 if (err)
>                         goto out;
>         }
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_rlc.bin", chip_name);
>  out:
>         if (err) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index f15beb217b48..a2a45be68c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -982,13 +982,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_de=
vice *adev)
>
>         if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_type <=3D C=
HIP_POLARIS12) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>                                            "amdgpu/%s_pfp_2.bin", chip_na=
me);
>                 if (err =3D=3D -ENODEV) {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp=
_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_pfp.bin", c=
hip_name);
>                 }
>         } else {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_pfp.bin", chip_name=
);
>         }
>         if (err)
> @@ -999,13 +1002,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_d=
evice *adev)
>
>         if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_type <=3D C=
HIP_POLARIS12) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>                                            "amdgpu/%s_me_2.bin", chip_nam=
e);
>                 if (err =3D=3D -ENODEV) {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_=
fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_me.bin", ch=
ip_name);
>                 }
>         } else {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_me.bin", chip_name)=
;
>         }
>         if (err)
> @@ -1017,13 +1023,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_=
device *adev)
>
>         if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_type <=3D C=
HIP_POLARIS12) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>                                            "amdgpu/%s_ce_2.bin", chip_nam=
e);
>                 if (err =3D=3D -ENODEV) {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_=
fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_ce.bin", ch=
ip_name);
>                 }
>         } else {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_ce.bin", chip_name)=
;
>         }
>         if (err)
> @@ -1044,6 +1053,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_de=
vice *adev)
>                 adev->virt.chained_ib_support =3D false;
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_rlc.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -1093,13 +1103,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_=
device *adev)
>
>         if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_type <=3D C=
HIP_POLARIS12) {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                          AMDGPU_UCODE_NOT_REQUIRED,
>                                            "amdgpu/%s_mec_2.bin", chip_na=
me);
>                 if (err =3D=3D -ENODEV) {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec=
_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_mec.bin", c=
hip_name);
>                 }
>         } else {
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_mec.bin", chip_name=
);
>         }
>         if (err)
> @@ -1112,13 +1125,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_=
device *adev)
>             (adev->asic_type !=3D CHIP_TOPAZ)) {
>                 if (adev->asic_type >=3D CHIP_POLARIS10 && adev->asic_typ=
e <=3D CHIP_POLARIS12) {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec=
2_fw,
> +                                                  AMDGPU_UCODE_NOT_REQUI=
RED,
>                                                    "amdgpu/%s_mec2_2.bin"=
, chip_name);
>                         if (err =3D=3D -ENODEV) {
>                                 err =3D amdgpu_ucode_request(adev, &adev-=
>gfx.mec2_fw,
> +                                                          AMDGPU_UCODE_R=
EQUIRED,
>                                                            "amdgpu/%s_mec=
2.bin", chip_name);
>                         }
>                 } else {
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec=
2_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_mec2.bin", =
chip_name);
>                 }
>                 if (!err) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 4e27528b7e57..30d9b6dacb6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1429,18 +1429,21 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct =
amdgpu_device *adev,
>         int err;
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_pfp.bin", chip_name);
>         if (err)
>                 goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.me_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_me.bin", chip_name);
>         if (err)
>                 goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_ce.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -1476,6 +1479,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgp=
u_device *adev,
>                 (((adev->pdev->revision >=3D 0xC8) && (adev->pdev->revisi=
on <=3D 0xCF)) ||
>                 ((adev->pdev->revision >=3D 0xD8) && (adev->pdev->revisio=
n <=3D 0xDF))))
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_rlc_am4.bin", chip_=
name);
>         else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmw=
are(adev, &smu_version) =3D=3D 0) &&
>                 (smu_version >=3D 0x41e2b))
> @@ -1483,9 +1487,11 @@ static int gfx_v9_0_init_rlc_microcode(struct amdg=
pu_device *adev,
>                 *SMC is loaded by SBIOS on APU and it's able to get the S=
MU version directly.
>                 */
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_kicker_rlc.bin", ch=
ip_name);
>         else
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_rlc.bin", chip_name=
);
>         if (err)
>                 goto out;
> @@ -1518,9 +1524,11 @@ static int gfx_v9_0_init_cp_compute_microcode(stru=
ct amdgpu_device *adev,
>
>         if (amdgpu_sriov_vf(adev) && (adev->asic_type =3D=3D CHIP_ALDEBAR=
AN))
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -                                          "amdgpu/%s_sjt_mec.bin", chip_=
name);
> +                                  AMDGPU_UCODE_REQUIRED,
> +                                  "amdgpu/%s_sjt_mec.bin", chip_name);
>         else
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +                                          AMDGPU_UCODE_REQUIRED,
>                                            "amdgpu/%s_mec.bin", chip_name=
);
>         if (err)
>                 goto out;
> @@ -1531,9 +1539,11 @@ static int gfx_v9_0_init_cp_compute_microcode(stru=
ct amdgpu_device *adev,
>         if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
>                 if (amdgpu_sriov_vf(adev) && (adev->asic_type =3D=3D CHIP=
_ALDEBARAN))
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec=
2_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sjt_mec2.bi=
n", chip_name);
>                 else
>                         err =3D amdgpu_ucode_request(adev, &adev->gfx.mec=
2_fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_mec2.bin", =
chip_name);
>                 if (!err) {
>                         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_I=
D_CP_MEC2);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 8eccb080d56f..9c146e37c55e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -545,6 +545,7 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgp=
u_device *adev,
>
>
>         err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
> +                                  AMDGPU_UCODE_REQUIRED,
>                                    "amdgpu/%s_rlc.bin", chip_name);
>         if (err)
>                 goto out;
> @@ -578,10 +579,12 @@ static int gfx_v9_4_3_init_cp_compute_microcode(str=
uct amdgpu_device *adev,
>
>         if (amdgpu_sriov_vf(adev))
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -                               "amdgpu/%s_sjt_mec.bin", chip_name);
> +                                          AMDGPU_UCODE_REQUIRED,
> +                                          "amdgpu/%s_sjt_mec.bin", chip_=
name);
>         else
>                 err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> -                               "amdgpu/%s_mec.bin", chip_name);
> +                                          AMDGPU_UCODE_REQUIRED,
> +                                          "amdgpu/%s_mec.bin", chip_name=
);
>         if (err)
>                 goto out;
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index 8e878ab44e76..2245dda92021 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -131,7 +131,8 @@ static int gmc_v6_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) =3D=3D 0x58)
>                 chip_name =3D "si58";
>
> -       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.b=
in", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_RE=
QUIRED,
> +                                  "amdgpu/%s_mc.bin", chip_name);
>         if (err) {
>                 dev_err(adev->dev,
>                        "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 347bccd92696..9aac4b1101e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -157,7 +157,8 @@ static int gmc_v7_0_init_microcode(struct amdgpu_devi=
ce *adev)
>                 return -EINVAL;
>         }
>
> -       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.b=
in", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_RE=
QUIRED,
> +                                  "amdgpu/%s_mc.bin", chip_name);
>         if (err) {
>                 pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n",=
 chip_name);
>                 amdgpu_ucode_release(&adev->gmc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 29ce36038b3f..d06585207c33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -259,7 +259,8 @@ static int gmc_v8_0_init_microcode(struct amdgpu_devi=
ce *adev)
>                 return -EINVAL;
>         }
>
> -       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.b=
in", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_RE=
QUIRED,
> +                                  "amdgpu/%s_mc.bin", chip_name);
>         if (err) {
>                 pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chi=
p_name);
>                 amdgpu_ucode_release(&adev->gmc.fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0.c
> index d4f72e47ae9e..aeca5c08ea2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -50,7 +50,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_devic=
e *adev)
>         DRM_DEBUG("\n");
>
>         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
> -       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_=
imu.bin", ucode_prefix);
> +       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_imu.bin", ucode_prefix);
>         if (err)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v12_0.c
> index 1341f0292031..df898dbb746e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> @@ -47,7 +47,8 @@ static int imu_v12_0_init_microcode(struct amdgpu_devic=
e *adev)
>         DRM_DEBUG("\n");
>
>         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
> -       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_=
imu.bin", ucode_prefix);
> +       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCOD=
E_REQUIRED,
> +                                  "amdgpu/%s_imu.bin", ucode_prefix);
>         if (err)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index c6af318908e4..269bf1e3337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -145,9 +145,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_de=
vice *adev)
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 if (i =3D=3D 0)
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma.bin", =
chip_name);
>                 else
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma1.bin",=
 chip_name);
>                 if (err)
>                         goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index d438f2f7a408..c9ad9ec48688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -305,9 +305,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_de=
vice *adev)
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
>                 if (i =3D=3D 0)
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma.bin", =
chip_name);
>                 else
>                         err =3D amdgpu_ucode_request(adev, &adev->sdma.in=
stance[i].fw,
> +                                                  AMDGPU_UCODE_REQUIRED,
>                                                    "amdgpu/%s_sdma1.bin",=
 chip_name);
>                 if (err)
>                         goto out;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 85f21db6ef24..fff5a1cdf474 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2338,7 +2338,8 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>                 return 0;
>         }
>
> -       r =3D amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, "%s", fw_name=
_dmcu);
> +       r =3D amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, AMDGPU_UCODE_=
REQUIRED,
> +                                "%s", fw_name_dmcu);
>         if (r =3D=3D -ENODEV) {
>                 /* DMCU firmware is not necessary, so don't raise a fuss =
if it's missing */
>                 DRM_DEBUG_KMS("dm: DMCU firmware not found\n");
> @@ -5306,7 +5307,8 @@ static int dm_init_microcode(struct amdgpu_device *=
adev)
>                 /* ASIC doesn't support DMUB. */
>                 return 0;
>         }
> -       r =3D amdgpu_ucode_request(adev, &adev->dm.dmub_fw, "%s", fw_name=
_dmub);
> +       r =3D amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_=
REQUIRED,
> +                                "%s", fw_name_dmub);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 2bed85ba835e..a87dcf0974bc 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7709,7 +7709,8 @@ static int si_dpm_init_microcode(struct amdgpu_devi=
ce *adev)
>         default: BUG();
>         }
>
> -       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.b=
in", chip_name);
> +       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQ=
UIRED,
> +                                  "amdgpu/%s_smc.bin", chip_name);
>         if (err) {
>                 DRM_ERROR("si_smc: Failed to load firmware. err =3D %d\"%=
s_smc.bin\"\n",
>                           err, chip_name);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 480cf3cb204d..189c6a32b6bd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -105,7 +105,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>                 return 0;
>
>         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, size=
of(ucode_prefix));
> -       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin",=
 ucode_prefix);
> +       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQ=
UIRED,
> +                                  "amdgpu/%s.bin", ucode_prefix);
>         if (err)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index bb506d15d787..7bb45ff6d5c8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -103,7 +103,8 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>                 return 0;
>
>         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, size=
of(ucode_prefix));
> -       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin",=
 ucode_prefix);
> +       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQ=
UIRED,
> +                                  "amdgpu/%s.bin", ucode_prefix);
>         if (err)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8344f54e6674..5b86df0c8536 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -305,7 +305,8 @@ static int smu_v13_0_6_init_microcode(struct smu_cont=
ext *smu)
>
>         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
>                                        sizeof(ucode_prefix));
> -       ret  =3D amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin"=
, ucode_prefix);
> +       ret  =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_RE=
QUIRED,
> +                                   "amdgpu/%s.bin", ucode_prefix);
>         if (ret)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4d083f7f772e..9b2f4fe1578b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -79,7 +79,8 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
>                 return 0;
>
>         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, size=
of(ucode_prefix));
> -       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin",=
 ucode_prefix);
> +       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQ=
UIRED,
> +                                  "amdgpu/%s.bin", ucode_prefix);
>         if (err)
>                 goto out;
>
> --
> 2.34.1
>
