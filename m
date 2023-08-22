Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B62EE4996
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 13:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6140210E062;
	Tue, 22 Aug 2023 13:48:48 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC5B10E389
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 13:48:45 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a8036d805eso3335215b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692712125; x=1693316925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc6oqwRas5SviGb16SDrO7vd2NRB6RrrJ2cAXK5Cckc=;
 b=R77Jh4TF8gFQ9XMHLEw/jnmVbKj/k1VkHbYU0IauMZmc7rwejHGrKINg2CdPhbcIg+
 rgRW3qkRGAK+1s9gYyblFEgfNyD1y3yZCRv8b8DryVsZHyKbxxZx/OVNL6Gh5akT+5GF
 MntaywushUTunXtOQ0xTZzaxApQtaJJl7PrwkRgdcmF7nxTHUV3UVh8QiiajK+WkUWYO
 t7e0c8b62HjWcqmsEhnqPXd+uI5hpwFIgO8KHeMMgajpVvIdiN9OzDeewfJVBYoCCULx
 uzjMbSjDKaUR//gvQBLdJvEfEQqfUVVEVXPYSro/lJw1Jk8lJ8s1bFH0G7BgavQTqhxM
 Wb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692712125; x=1693316925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc6oqwRas5SviGb16SDrO7vd2NRB6RrrJ2cAXK5Cckc=;
 b=af8UARgWCpHP1KQP638LNoo1PvxrOpPT9y1mZBRQ6RjAjRqB7FSwWVROcP83ZJlKbJ
 Hna+e2o9paer/AyTJIrpcktu+KhLVJcX4UANgqpEP0KA9uFj1beH4ZXsEsgV+6EVjJhQ
 ZkxCe8v8g6PzoHetGoMOdyzT1CVuZTR04IFjtZbjo8MN8UwxYAdwvjksfV8gQ/CK3ZjJ
 7HgmQzosGR1gHMK+EOZCeahqVtr1cJhGon706kpBZEFfuj2BG0GT2yg1VsOC0A0oXi6M
 iGUCKQfPUMf+SHH5L50KWPbivDbqNJueaENZNt8iGTSmpJC1HHQXF/OSQnwv9D6rsuvH
 eznQ==
X-Gm-Message-State: AOJu0YxEM8L1Jd12FtScnjWEwF8Y1EizEpmortz4z+tNELf0KEP2pNT8
 W6pEtB6dyXgIyGy6vU64DU03jhDR+PX6sX3sN8c=
X-Google-Smtp-Source: AGHT+IFt2X6SemTcRC/KWBkOcqCf7HbfRtQDCstt8sNEpWx0ZhGerBoJKSxDaHllYg5koGYSoATsf/y1CZrrEhRCNII=
X-Received: by 2002:a05:6808:f8d:b0:3a7:f153:b5e5 with SMTP id
 o13-20020a0568080f8d00b003a7f153b5e5mr13815949oiw.29.1692712124780; Tue, 22
 Aug 2023 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230815033547.65220-1-mario.limonciello@amd.com>
In-Reply-To: <20230815033547.65220-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Aug 2023 09:48:33 -0400
Message-ID: <CADnq5_OMqCC_Lpc33OaWDPiJnaA3r3jktbfsQYx_ioDz_gm8_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Drop USB-C PD F/W flashing support
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 15, 2023 at 4:40=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This support was introduced for pre-navi3x dGPUS.  The interface that
> this was wired up to isn't usable by fwupd, and no devices had a need
> to release firmware into the wild.
>
> Navi3x dGPUs introduce an interface that can flash the entire IFWI
> image that is acceptable by userspace software like fwupd.

Technically the USB PD is separate from the IFWI and should still be
applicable to any dGPU with USB.  While the interface is not ideal for
fwupd, I feel like we should leave it around until we have something
better to replace it on the off chance there is a USB PD image update
that needs to be flashed.

Alex


>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/flashing.rst   | 12 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 91 -------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 60 ----------------
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 60 ----------------
>  5 files changed, 233 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/flashing.rst b/Documentation/gpu/am=
dgpu/flashing.rst
> index bd745c42a538f..4556d58866e8e 100644
> --- a/Documentation/gpu/amdgpu/flashing.rst
> +++ b/Documentation/gpu/amdgpu/flashing.rst
> @@ -16,18 +16,6 @@ The IFWI flash process is:
>  3. "Read" from the `psp_vbflash` sysfs file to initiate the flash proces=
s.
>  4. Poll the `psp_vbflash_status` sysfs file to determine when the flash =
process completes.
>
> -USB-C PD F/W
> -------------
> -On GPUs that support flashing an updated USB-C PD firmware image, the pr=
ocess
> -is done using the `usbc_pd_fw` sysfs file.
> -
> -* Reading the file will provide the current firmware version.
> -* Writing the name of a firmware payload stored in `/lib/firmware/amdgpu=
` to the sysfs file will initiate the flash process.
> -
> -The firmware payload stored in `/lib/firmware/amdgpu` can be named any n=
ame
> -as long as it doesn't conflict with other existing binaries that are use=
d by
> -`amdgpu`.
> -
>  sysfs files
>  -----------
>  .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 8fdca54bb8a11..15450b9aabdae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3471,88 +3471,6 @@ static int psp_set_powergating_state(void *handle,
>         return 0;
>  }
>
> -static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
> -                                        struct device_attribute *attr,
> -                                        char *buf)
> -{
> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -       uint32_t fw_ver;
> -       int ret;
> -
> -       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initializ=
ed) {
> -               DRM_INFO("PSP block is not ready yet.");
> -               return -EBUSY;
> -       }
> -
> -       mutex_lock(&adev->psp.mutex);
> -       ret =3D psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
> -       mutex_unlock(&adev->psp.mutex);
> -
> -       if (ret) {
> -               DRM_ERROR("Failed to read USBC PD FW, err =3D %d", ret);
> -               return ret;
> -       }
> -
> -       return sysfs_emit(buf, "%x\n", fw_ver);
> -}
> -
> -static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> -                                                      struct device_attr=
ibute *attr,
> -                                                      const char *buf,
> -                                                      size_t count)
> -{
> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> -       int ret, idx;
> -       char fw_name[100];
> -       const struct firmware *usbc_pd_fw;
> -       struct amdgpu_bo *fw_buf_bo =3D NULL;
> -       uint64_t fw_pri_mc_addr;
> -       void *fw_pri_cpu_addr;
> -
> -       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initializ=
ed) {
> -               DRM_INFO("PSP block is not ready yet.");
> -               return -EBUSY;
> -       }
> -
> -       if (!drm_dev_enter(ddev, &idx))
> -               return -ENODEV;
> -
> -       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> -       ret =3D request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> -       if (ret)
> -               goto fail;
> -
> -       /* LFB address which is aligned to 1MB boundary per PSP request *=
/
> -       ret =3D amdgpu_bo_create_kernel(adev, usbc_pd_fw->size, 0x100000,
> -                                     AMDGPU_GEM_DOMAIN_VRAM |
> -                                     AMDGPU_GEM_DOMAIN_GTT,
> -                                     &fw_buf_bo, &fw_pri_mc_addr,
> -                                     &fw_pri_cpu_addr);
> -       if (ret)
> -               goto rel_buf;
> -
> -       memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> -
> -       mutex_lock(&adev->psp.mutex);
> -       ret =3D psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
> -       mutex_unlock(&adev->psp.mutex);
> -
> -       amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_ad=
dr);
> -
> -rel_buf:
> -       release_firmware(usbc_pd_fw);
> -fail:
> -       if (ret) {
> -               DRM_ERROR("Failed to load USBC PD FW, err =3D %d", ret);
> -               count =3D ret;
> -       }
> -
> -       drm_dev_exit(idx);
> -       return count;
> -}
> -
>  void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t =
bin_size)
>  {
>         int idx;
> @@ -3566,15 +3484,6 @@ void psp_copy_fw(struct psp_context *psp, uint8_t =
*start_addr, uint32_t bin_size
>         drm_dev_exit(idx);
>  }
>
> -/**
> - * DOC: usbc_pd_fw
> - * Reading from this file will retrieve the USB-C PD firmware version. W=
riting to
> - * this file will trigger the update process.
> - */
> -static DEVICE_ATTR(usbc_pd_fw, 0644,
> -                  psp_usbc_pd_fw_sysfs_read,
> -                  psp_usbc_pd_fw_sysfs_write);
> -
>  int is_psp_fw_valid(struct psp_bin_desc bin)
>  {
>         return bin.size_bytes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 3c7d9051b8c6b..4f62013ffed3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -128,8 +128,6 @@ struct psp_funcs {
>         int (*mem_training)(struct psp_context *psp, uint32_t ops);
>         uint32_t (*ring_get_wptr)(struct psp_context *psp);
>         void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
> -       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_m=
c_addr);
> -       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver)=
;
>         int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
>         int (*vbflash_stat)(struct psp_context *psp);
>  };
> @@ -429,14 +427,6 @@ struct amdgpu_psp_funcs {
>  #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
>  #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp),=
 (value))
>
> -#define psp_load_usbc_pd_fw(psp, fw_pri_mc_addr) \
> -       ((psp)->funcs->load_usbc_pd_fw ? \
> -       (psp)->funcs->load_usbc_pd_fw((psp), (fw_pri_mc_addr)) : -EINVAL)
> -
> -#define psp_read_usbc_pd_fw(psp, fw_ver) \
> -       ((psp)->funcs->read_usbc_pd_fw ? \
> -       (psp)->funcs->read_usbc_pd_fw((psp), fw_ver) : -EINVAL)
> -
>  #define psp_update_spirom(psp, fw_pri_mc_addr) \
>         ((psp)->funcs->update_spirom ? \
>         (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 8f84fe40abbbb..8aaecc725ec19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -586,64 +586,6 @@ static void psp_v11_0_ring_set_wptr(struct psp_conte=
xt *psp, uint32_t value)
>                 WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
>  }
>
> -static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t f=
w_pri_mc_addr)
> -{
> -       struct amdgpu_device *adev =3D psp->adev;
> -       uint32_t reg_status;
> -       int ret, i =3D 0;
> -
> -       /*
> -        * LFB address which is aligned to 1MB address and has to be
> -        * right-shifted by 20 so that LFB address can be passed on a 32-=
bit C2P
> -        * register
> -        */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20))=
;
> -
> -       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PM=
SG_35),
> -                            0x80000000, 0x80000000, false);
> -       if (ret)
> -               return ret;
> -
> -       /* Fireup interrupt so PSP can pick up the address */
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LFB=
 << 16));
> -
> -       /* FW load takes very long time */
> -       do {
> -               msleep(1000);
> -               reg_status =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35);
> -
> -               if (reg_status & 0x80000000)
> -                       goto done;
> -
> -       } while (++i < USBC_PD_POLLING_LIMIT_S);
> -
> -       return -ETIME;
> -done:
> -
> -       if ((reg_status & 0xFFFF) !=3D 0) {
> -               DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [=
15:0] =3D 0x%04x\n",
> -                               reg_status & 0xFFFF);
> -               return -EIO;
> -       }
> -
> -       return 0;
> -}
> -
> -static int psp_v11_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *=
fw_ver)
> -{
> -       struct amdgpu_device *adev =3D psp->adev;
> -       int ret;
> -
> -       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_F=
W_VER);
> -
> -       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PM=
SG_35),
> -                                    0x80000000, 0x80000000, false);
> -       if (!ret)
> -               *fw_ver =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36);
> -
> -       return ret;
> -}
> -
>  static const struct psp_funcs psp_v11_0_funcs =3D {
>         .init_microcode =3D psp_v11_0_init_microcode,
>         .bootloader_load_kdb =3D psp_v11_0_bootloader_load_kdb,
> @@ -657,8 +599,6 @@ static const struct psp_funcs psp_v11_0_funcs =3D {
>         .mem_training =3D psp_v11_0_memory_training,
>         .ring_get_wptr =3D psp_v11_0_ring_get_wptr,
>         .ring_set_wptr =3D psp_v11_0_ring_set_wptr,
> -       .load_usbc_pd_fw =3D psp_v11_0_load_usbc_pd_fw,
> -       .read_usbc_pd_fw =3D psp_v11_0_read_usbc_pd_fw
>  };
>
>  void psp_v11_0_set_psp_funcs(struct psp_context *psp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0.c
> index 58db1ee631b39..46af460e60ed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -557,64 +557,6 @@ static int psp_v13_0_memory_training(struct psp_cont=
ext *psp, uint32_t ops)
>         return 0;
>  }
>
> -static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t f=
w_pri_mc_addr)
> -{
> -       struct amdgpu_device *adev =3D psp->adev;
> -       uint32_t reg_status;
> -       int ret, i =3D 0;
> -
> -       /*
> -        * LFB address which is aligned to 1MB address and has to be
> -        * right-shifted by 20 so that LFB address can be passed on a 32-=
bit C2P
> -        * register
> -        */
> -       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, (fw_pri_mc_addr >> 20)=
);
> -
> -       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2P=
MSG_35),
> -                            0x80000000, 0x80000000, false);
> -       if (ret)
> -               return ret;
> -
> -       /* Fireup interrupt so PSP can pick up the address */
> -       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, (GFX_CMD_USB_PD_USE_LF=
B << 16));
> -
> -       /* FW load takes very long time */
> -       do {
> -               msleep(1000);
> -               reg_status =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35)=
;
> -
> -               if (reg_status & 0x80000000)
> -                       goto done;
> -
> -       } while (++i < USBC_PD_POLLING_LIMIT_S);
> -
> -       return -ETIME;
> -done:
> -
> -       if ((reg_status & 0xFFFF) !=3D 0) {
> -               DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [=
15:0] =3D %04x\n",
> -                               reg_status & 0xFFFF);
> -               return -EIO;
> -       }
> -
> -       return 0;
> -}
> -
> -static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *=
fw_ver)
> -{
> -       struct amdgpu_device *adev =3D psp->adev;
> -       int ret;
> -
> -       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, C2PMSG_CMD_GFX_USB_PD_=
FW_VER);
> -
> -       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2P=
MSG_35),
> -                                    0x80000000, 0x80000000, false);
> -       if (!ret)
> -               *fw_ver =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36);
> -
> -       return ret;
> -}
> -
>  static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
>  {
>         uint32_t reg_status =3D 0, reg_val =3D 0;
> @@ -707,8 +649,6 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
>         .ring_get_wptr =3D psp_v13_0_ring_get_wptr,
>         .ring_set_wptr =3D psp_v13_0_ring_set_wptr,
>         .mem_training =3D psp_v13_0_memory_training,
> -       .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
> -       .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
>         .update_spirom =3D psp_v13_0_update_spirom,
>         .vbflash_stat =3D psp_v13_0_vbflash_status
>  };
> --
> 2.34.1
>
