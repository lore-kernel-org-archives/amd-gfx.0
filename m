Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94793C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 18:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4AA20786
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJw5ODjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4AA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1314989FCC;
	Tue, 18 Aug 2020 18:23:23 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C5089E36
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 18:23:21 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a15so19140269wrh.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y9PFDdNcCgoksqI97/p98SRGNNUmk8Dyr8UztoIgWGw=;
 b=QJw5ODjk4gJAWZ7iMQq9AxmXMEaGJisETSJvfe38yzTlPH4L2wNH5bampvkJfbFB7t
 4HL5PoaUjNgUfp+rG4de2pBFhfRPmSPNbRFVKxctIPFEqaxTIv2DpuRnhcaglC+KAjN7
 RJ6so9Vp4q56LvVW7hsy3fW0as4HpLWRWD2ebS31xbmaDD1AzheWr2GLJ/29WURmol+y
 Na4kQ2rCaXNeVHGvI0PtlqhrjVUUWCnveXcOAguohESiefLNqz/ctB2IhGxfllySv16W
 g3aMXa0sOfR6aUAPUIH045njCtyd9VagFjJNYZSU8+1/sNw4K5MayNIalDpl5/SodNyW
 ZmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y9PFDdNcCgoksqI97/p98SRGNNUmk8Dyr8UztoIgWGw=;
 b=hlbkZ+7xlLc30DiqjZVxxNFCK5lEjR9+gwOnH9UA3Rrq7SOWP8rfAe8+Iz7gcOpV43
 kLrmQRtCocX/upmx8zPO+894dR/oMdC9szf8tJH53JAkW5JVKGRygLKazDeupfdJH7n0
 JIRQGW4FRX+gWO3LZi3qr9onZgFmyMirPO5dfd3SbvhTUAT752QldvfZ2iA6aOE7tyM5
 Bv9MW34oAfQqQ/mSKHqMwPlT0cXn1u9pLyfubgWdPt/oYlgyn07TgwPc7Gqq7jlWs/qa
 lwDXjWi3+TXj8ijXEZNOIprAU0iBAxO7AD5VzpX+wIsVjYzBFGRFc6GLx5dHbz/1jc7S
 DR9A==
X-Gm-Message-State: AOAM531Xz8sOf74lbGOWRMgwkqAz3hiNx9UTrDhquGDY08mw0cSDKPRR
 OAuQhThekhVHYCZosivsegiKZzQqj6NmDafz/lQ=
X-Google-Smtp-Source: ABdhPJwKUDCA9JapK+EC+cSmddkCMUSUfgqba1UaIfnPxuQ/FdiWUWjd3eDwoEvFpjnkBLqXe4gzwmP68hOk4EyzNvI=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr22035724wrs.374.1597774997260; 
 Tue, 18 Aug 2020 11:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200815012533.7677-1-luben.tuikov@amd.com>
 <20200815012533.7677-3-luben.tuikov@amd.com>
In-Reply-To: <20200815012533.7677-3-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2020 14:23:04 -0400
Message-ID: <CADnq5_MQzBOwjv7qnrsaxm6fSk5CfWUuLZLng6fot87WCFbvNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Embed drm_device into amdgpu_device
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 14, 2020 at 9:25 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Embed struct drm_device into struct amdgpu_device.
> Modify the macro DRM_TO_ADEV()
> accordingly. Introduce a new macro to yield the
> DRM device from amdgpu_device, ADEV_TO_DRM().
> Eliminate the use of drm_device.dev_private,
> in amdgpu.
> Add a DRM driver relase function, which frees
> the amdgpu_device after all krefs on the DRM
> device have been released.

You might want to also mention that this switches from using
drm_dev_alloc() to drm_dev_init().  It might also be more helpful to
introduce the ADEV_TO_DRM() macro in a new prior patch so that the
diff for this change is smaller and easier to follow. That makes it
more obvious what the functional change is here.  A few comments
below, I think there is some component stuff leftover from debugging.
Other than that, it looks pretty good to me overall.

Alex

>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   6 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 178 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  41 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  37 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c       |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  51 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        | 194 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  46 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  46 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  46 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  46 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c      |  36 ++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  78 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   4 +-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
>  35 files changed, 475 insertions(+), 467 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0268bb1da82b..5581ba958fca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -724,8 +724,8 @@ struct amd_powerplay {
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
>         struct device                   *dev;
> -       struct drm_device               *ddev;
>         struct pci_dev                  *pdev;
> +       struct drm_device               ddev;
>
>  #ifdef CONFIG_DRM_AMD_ACP
>         struct amdgpu_acp               acp;
> @@ -988,7 +988,8 @@ struct amdgpu_device {
>         struct ratelimit_state          throttling_logging_rs;
>  };
>
> -#define DRM_TO_ADEV(_drmdevp)  ((struct amdgpu_device *)(_drmdevp)->dev_private)
> +#define DRM_TO_ADEV(_drmdevp) container_of(_drmdevp, struct amdgpu_device, ddev)
> +#define ADEV_TO_DRM(_amddevp) ((struct drm_device *)(&((_amddevp)->ddev)))
>
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
>  {
> @@ -996,8 +997,6 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
>  }
>
>  int amdgpu_device_init(struct amdgpu_device *adev,
> -                      struct drm_device *ddev,
> -                      struct pci_dev *pdev,
>                        uint32_t flags);
>  void amdgpu_device_fini(struct amdgpu_device *adev);
>  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
> @@ -1187,7 +1186,7 @@ static inline void *amdgpu_atpx_get_dhandle(void) { return NULL; }
>  extern const struct drm_ioctl_desc amdgpu_ioctls_kms[];
>  extern const int amdgpu_max_kms_ioctl;
>
> -int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags);
> +int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags);
>  void amdgpu_driver_unload_kms(struct drm_device *dev);
>  void amdgpu_driver_lastclose_kms(struct drm_device *dev);
>  int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 913c8f0513bd..0d81fd70775a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -463,11 +463,11 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>
>                 if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
>                         if (adev->flags & AMD_IS_PX) {
> -                               pm_runtime_get_sync(adev->ddev->dev);
> +                               pm_runtime_get_sync(adev->ddev.dev);
>                                 /* Just fire off a uevent and let userspace tell us what to do */
> -                               drm_helper_hpd_irq_event(adev->ddev);
> -                               pm_runtime_mark_last_busy(adev->ddev->dev);
> -                               pm_runtime_put_autosuspend(adev->ddev->dev);
> +                               drm_helper_hpd_irq_event(ADEV_TO_DRM(adev));
> +                               pm_runtime_mark_last_busy(adev->ddev.dev);
> +                               pm_runtime_put_autosuspend(adev->ddev.dev);
>                         }
>                 }
>                 /* TODO: check other events */
> @@ -817,7 +817,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>                         struct drm_encoder *tmp;
>
>                         /* Find the encoder controlling the brightness */
> -                       list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
> +                       list_for_each_entry(tmp, &adev->ddev.mode_config.encoder_list,
>                                             head) {
>                                 struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index cf185f3b8ae8..00b40c67ae6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -119,7 +119,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>                         .gpuvm_size = min(adev->vm_manager.max_pfn
>                                           << AMDGPU_GPU_PAGE_SHIFT,
>                                           AMDGPU_GMC_HOLE_START),
> -                       .drm_render_minor = adev->ddev->render->index,
> +                       .drm_render_minor = adev->ddev.render->index,
>                         .sdma_doorbell_idx = adev->doorbell_index.sdma_engine,
>
>                 };
> @@ -160,7 +160,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>                                         adev->doorbell_index.last_non_cp;
>                 }
>
> -               kgd2kfd_device_init(adev->kfd.dev, adev->ddev, &gpu_resources);
> +               kgd2kfd_device_init(adev->kfd.dev, ADEV_TO_DRM(adev), &gpu_resources);
>         }
>  }
>
> @@ -494,7 +494,7 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>                 goto out_put;
>
>         obj = dma_buf->priv;
> -       if (obj->dev->driver != adev->ddev->driver)
> +       if (obj->dev->driver != adev->ddev.driver)
>                 /* Can't handle buffers from different drivers */
>                 goto out_put;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 351ad1945199..dbe283d320db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -148,7 +148,7 @@ void amdgpu_atombios_i2c_init(struct amdgpu_device *adev)
>
>                         if (i2c.valid) {
>                                 sprintf(stmp, "0x%x", i2c.i2c_id);
> -                               adev->i2c_bus[i] = amdgpu_i2c_create(adev->ddev, &i2c, stmp);
> +                               adev->i2c_bus[i] = amdgpu_i2c_create(ADEV_TO_DRM(adev), &i2c, stmp);
>                         }
>                         gpio = (ATOM_GPIO_I2C_ASSIGMENT *)
>                                 ((u8 *)gpio + sizeof(ATOM_GPIO_I2C_ASSIGMENT));
> @@ -541,7 +541,7 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
>                 }
>         }
>
> -       amdgpu_link_encoder_connector(adev->ddev);
> +       amdgpu_link_encoder_connector(ADEV_TO_DRM(adev));
>
>         return true;
>  }
> @@ -1995,7 +1995,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>                 return -ENOMEM;
>
>         adev->mode_info.atom_card_info = atom_card_info;
> -       atom_card_info->dev = adev->ddev;
> +       atom_card_info->dev = ADEV_TO_DRM(adev);
>         atom_card_info->reg_read = cail_reg_read;
>         atom_card_info->reg_write = cail_reg_write;
>         /* needed for iio ops */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index 002672477e1f..41e96bcbe856 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1521,7 +1521,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                       struct amdgpu_hpd *hpd,
>                       struct amdgpu_router *router)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index c35671c95975..ca6321e578e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -69,8 +69,8 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>         adev->debugfs_count = i;
>  #if defined(CONFIG_DEBUG_FS)
>         drm_debugfs_create_files(files, nfiles,
> -                                adev->ddev->primary->debugfs_root,
> -                                adev->ddev->primary);
> +                                adev->ddev.primary->debugfs_root,
> +                                adev->ddev.primary);
>  #endif
>         return 0;
>  }
> @@ -147,7 +147,7 @@ static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
>         init_waitqueue_head(&adev->autodump.gpu_hang);
>
>         debugfs_create_file("amdgpu_autodump", 0600,
> -               adev->ddev->primary->debugfs_root,
> +               adev->ddev.primary->debugfs_root,
>                 adev, &autodump_debug_fops);
>  }
>
> @@ -223,23 +223,23 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>
>         *pos &= (1UL << 22) - 1;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         if (use_bank) {
>                 if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
>                     (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines)) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return -EINVAL;
>                 }
> @@ -288,8 +288,8 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>         if (pm_pg_lock)
>                 mutex_unlock(&adev->pm.mutex);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -336,15 +336,15 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -354,8 +354,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>                 value = RREG32_PCIE(*pos >> 2);
>                 r = put_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -366,8 +366,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -395,15 +395,15 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -412,8 +412,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>
>                 r = get_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -426,8 +426,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -455,15 +455,15 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -473,8 +473,8 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>                 value = RREG32_DIDT(*pos >> 2);
>                 r = put_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -485,8 +485,8 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -514,15 +514,15 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -531,8 +531,8 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>
>                 r = get_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -545,8 +545,8 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -574,15 +574,15 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -592,8 +592,8 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>                 value = RREG32_SMC(*pos);
>                 r = put_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -604,8 +604,8 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -633,15 +633,15 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -650,8 +650,8 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>
>                 r = get_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         amdgpu_virt_disable_access_debugfs(adev);
>                         return r;
>                 }
> @@ -664,8 +664,8 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         amdgpu_virt_disable_access_debugfs(adev);
>         return result;
> @@ -792,22 +792,22 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>
>         valuesize = sizeof(values);
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r) {
>                 amdgpu_virt_disable_access_debugfs(adev);
> @@ -874,15 +874,15 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>         wave = (*pos & GENMASK_ULL(36, 31)) >> 31;
>         simd = (*pos & GENMASK_ULL(44, 37)) >> 37;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
>         r = amdgpu_virt_enable_access_debugfs(adev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -897,8 +897,8 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>         amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (!x) {
>                 amdgpu_virt_disable_access_debugfs(adev);
> @@ -972,7 +972,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         if (!data)
>                 return -ENOMEM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0)
>                 goto err;
>
> @@ -995,8 +995,8 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         amdgpu_gfx_select_se_sh(adev, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
>         mutex_unlock(&adev->grbm_idx_mutex);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         while (size) {
>                 uint32_t value;
> @@ -1018,7 +1018,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>         return result;
>
>  err:
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>         kfree(data);
>         return r;
>  }
> @@ -1043,9 +1043,9 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -1054,8 +1054,8 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
>
>                 r = get_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         return r;
>                 }
>
> @@ -1067,8 +1067,8 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *bu
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return result;
>  }
> @@ -1092,7 +1092,7 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0)
>                 return r;
>
> @@ -1101,15 +1101,15 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>
>                 r = amdgpu_get_gfx_off_status(adev, &value);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         return r;
>                 }
>
>                 r = put_user(value, (uint32_t *)buf);
>                 if (r) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         return r;
>                 }
>
> @@ -1119,8 +1119,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>                 size -= 4;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return result;
>  }
> @@ -1212,7 +1212,7 @@ static const char *debugfs_regs_names[] = {
>   */
>  int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  {
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>         struct dentry *ent, *root = minor->debugfs_root;
>         unsigned int i;
>
> @@ -1237,7 +1237,7 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>
>         r = pm_runtime_get_sync(dev->dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -1296,7 +1296,7 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
>
>         r = pm_runtime_get_sync(dev->dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -1317,7 +1317,7 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
>
>         r = pm_runtime_get_sync(dev->dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -1518,9 +1518,9 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>         if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>                 return -EINVAL;
>
> -       ret = pm_runtime_get_sync(adev->ddev->dev);
> +       ret = pm_runtime_get_sync(adev->ddev.dev);
>         if (ret < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return ret;
>         }
>
> @@ -1533,8 +1533,8 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>                 return 0;
>         }
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (ret)
>                 return -EINVAL;
> @@ -1554,7 +1554,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>
>         adev->debugfs_preempt =
>                 debugfs_create_file("amdgpu_preempt_ib", 0600,
> -                                   adev->ddev->primary->debugfs_root, adev,
> +                                   adev->ddev.primary->debugfs_root, adev,
>                                     &fops_ib_preempt);
>         if (!(adev->debugfs_preempt)) {
>                 DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
> @@ -1563,7 +1563,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>
>         adev->smu.debugfs_sclk =
>                 debugfs_create_file("amdgpu_force_sclk", 0200,
> -                                   adev->ddev->primary->debugfs_root, adev,
> +                                   adev->ddev.primary->debugfs_root, adev,
>                                     &fops_sclk_set);
>         if (!(adev->smu.debugfs_sclk)) {
>                 DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9ac2892131c1..519bfe7b612e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1216,7 +1216,8 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   * Callback for the switcheroo driver.  Suspends or resumes the
>   * the asics before or after it is powered up using ACPI methods.
>   */
> -static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
> +static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> +                                       enum vga_switcheroo_state state)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         int r;
> @@ -1509,7 +1510,7 @@ static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
>         adev->enable_virtual_display = false;
>
>         if (amdgpu_virtual_display) {
> -               struct drm_device *ddev = adev->ddev;
> +               struct drm_device *ddev = ADEV_TO_DRM(adev);
>                 const char *pci_address_name = pci_name(ddev->pdev);
>                 char *pciaddstr, *pciaddstr_tmp, *pciaddname_tmp, *pciaddname;
>
> @@ -2874,13 +2875,13 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>         if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
>
>                 task_barrier_enter(&hive->tb);
> -               adev->asic_reset_res = amdgpu_device_baco_enter(adev->ddev);
> +               adev->asic_reset_res = amdgpu_device_baco_enter(ADEV_TO_DRM(adev));
>
>                 if (adev->asic_reset_res)
>                         goto fail;
>
>                 task_barrier_exit(&hive->tb);
> -               adev->asic_reset_res = amdgpu_device_baco_exit(adev->ddev);
> +               adev->asic_reset_res = amdgpu_device_baco_exit(ADEV_TO_DRM(adev));
>
>                 if (adev->asic_reset_res)
>                         goto fail;
> @@ -2896,7 +2897,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>  fail:
>         if (adev->asic_reset_res)
>                 DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
> -                        adev->asic_reset_res, adev->ddev->unique);
> +                        adev->asic_reset_res, adev->ddev.unique);
>  }
>
>  static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
> @@ -2979,8 +2980,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>   * amdgpu_device_init - initialize the driver
>   *
>   * @adev: amdgpu_device pointer
> - * @ddev: drm dev pointer
> - * @pdev: pci dev pointer
>   * @flags: driver flags
>   *
>   * Initializes the driver info and hw (all asics).
> @@ -2988,18 +2987,15 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>   * Called at driver startup.
>   */
>  int amdgpu_device_init(struct amdgpu_device *adev,
> -                      struct drm_device *ddev,
> -                      struct pci_dev *pdev,
>                        uint32_t flags)
>  {
> +       struct drm_device *ddev = ADEV_TO_DRM(adev);
> +       struct pci_dev *pdev = adev->pdev;
>         int r, i;
>         bool boco = false;
>         u32 max_MBps;
>
>         adev->shutdown = false;
> -       adev->dev = &pdev->dev;
> -       adev->ddev = ddev;
> -       adev->pdev = pdev;
>         adev->flags = flags;
>
>         if (amdgpu_force_asic_type >= 0 && amdgpu_force_asic_type < CHIP_LAST)
> @@ -3244,7 +3240,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         /* init the mode config */
> -       drm_mode_config_init(adev->ddev);
> +       drm_mode_config_init(ADEV_TO_DRM(adev));
>
>         r = amdgpu_device_ip_init(adev);
>         if (r) {
> @@ -3386,9 +3382,9 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         amdgpu_irq_disable_all(adev);
>         if (adev->mode_info.mode_config_initialized){
>                 if (!amdgpu_device_has_dc_support(adev))
> -                       drm_helper_force_disable_all(adev->ddev);
> +                       drm_helper_force_disable_all(ADEV_TO_DRM(adev));
>                 else
> -                       drm_atomic_helper_shutdown(adev->ddev);
> +                       drm_atomic_helper_shutdown(ADEV_TO_DRM(adev));
>         }
>         amdgpu_fence_driver_fini(adev);
>         if (adev->pm_sysfs_en)
> @@ -3412,7 +3408,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>              amdgpu_has_atpx_dgpu_power_cntl()) &&
>             !pci_is_thunderbolt_attached(adev->pdev))
>                 vga_switcheroo_unregister_client(adev->pdev);
> -       if (amdgpu_device_supports_boco(adev->ddev))
> +       if (amdgpu_device_supports_boco(ADEV_TO_DRM(adev)))
>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
>         vga_client_register(adev->pdev, NULL, NULL, NULL);
>         if (adev->rio_mem)
> @@ -3454,9 +3450,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>         struct drm_connector_list_iter iter;
>         int r;
>
> -       if (dev == NULL || dev->dev_private == NULL) {
> +       if (!dev)
>                 return -ENODEV;
> -       }
>
>         adev = DRM_TO_ADEV(dev);
>
> @@ -4052,7 +4047,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>
>                         if (r) {
>                                 DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
> -                                        r, tmp_adev->ddev->unique);
> +                                        r, tmp_adev->ddev.unique);
>                                 break;
>                         }
>                 }
> @@ -4426,7 +4421,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 /*TODO Should we stop ?*/
>                 if (r) {
>                         DRM_ERROR("GPU pre asic reset failed with err, %d for drm dev, %s ",
> -                                 r, tmp_adev->ddev->unique);
> +                                 r, tmp_adev->ddev.unique);
>                         tmp_adev->asic_reset_res = r;
>                 }
>         }
> @@ -4462,7 +4457,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 }
>
>                 if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
> -                       drm_helper_resume_force_mode(tmp_adev->ddev);
> +                       drm_helper_resume_force_mode(ADEV_TO_DRM(tmp_adev));
>                 }
>
>                 tmp_adev->asic_reset_res = 0;
> @@ -4638,7 +4633,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>         struct amdgpu_device *adev = DRM_TO_ADEV(dev);
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>
> -       if (!amdgpu_device_supports_baco(adev->ddev))
> +       if (!amdgpu_device_supports_baco(ADEV_TO_DRM(adev)))
>                 return -ENOTSUPP;
>
>         if (ras && ras->supported)
> @@ -4653,7 +4648,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>         int ret = 0;
>
> -       if (!amdgpu_device_supports_baco(adev->ddev))
> +       if (!amdgpu_device_supports_baco(ADEV_TO_DRM(adev)))
>                 return -ENOTSUPP;
>
>         ret = amdgpu_dpm_baco_exit(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 4bb30f2a2680..2d27060f59f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -93,7 +93,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
>          * targeted by the flip
>          */
>         if (amdgpu_crtc->enabled &&
> -           (amdgpu_display_get_crtc_scanoutpos(adev->ddev, work->crtc_id, 0,
> +           (amdgpu_display_get_crtc_scanoutpos(ADEV_TO_DRM(adev), work->crtc_id, 0,
>                                                 &vpos, &hpos, NULL, NULL,
>                                                 &crtc->hwmode)
>              & (DRM_SCANOUTPOS_VALID | DRM_SCANOUTPOS_IN_VBLANK)) ==
> @@ -619,59 +619,62 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>         int sz;
>
>         adev->mode_info.coherent_mode_property =
> -               drm_property_create_range(adev->ddev, 0 , "coherent", 0, 1);
> +               drm_property_create_range(ADEV_TO_DRM(adev), 0,
> +                                         "coherent", 0, 1);
>         if (!adev->mode_info.coherent_mode_property)
>                 return -ENOMEM;
>
>         adev->mode_info.load_detect_property =
> -               drm_property_create_range(adev->ddev, 0, "load detection", 0, 1);
> +               drm_property_create_range(ADEV_TO_DRM(adev), 0,
> +                                         "load detection", 0, 1);
>         if (!adev->mode_info.load_detect_property)
>                 return -ENOMEM;
>
> -       drm_mode_create_scaling_mode_property(adev->ddev);
> +       drm_mode_create_scaling_mode_property(ADEV_TO_DRM(adev));
>
>         sz = ARRAY_SIZE(amdgpu_underscan_enum_list);
>         adev->mode_info.underscan_property =
> -               drm_property_create_enum(adev->ddev, 0,
> -                                   "underscan",
> -                                   amdgpu_underscan_enum_list, sz);
> +               drm_property_create_enum(ADEV_TO_DRM(adev), 0,
> +                                        "underscan",
> +                                        amdgpu_underscan_enum_list, sz);
>
>         adev->mode_info.underscan_hborder_property =
> -               drm_property_create_range(adev->ddev, 0,
> -                                       "underscan hborder", 0, 128);
> +               drm_property_create_range(ADEV_TO_DRM(adev), 0,
> +                                         "underscan hborder", 0, 128);
>         if (!adev->mode_info.underscan_hborder_property)
>                 return -ENOMEM;
>
>         adev->mode_info.underscan_vborder_property =
> -               drm_property_create_range(adev->ddev, 0,
> -                                       "underscan vborder", 0, 128);
> +               drm_property_create_range(ADEV_TO_DRM(adev), 0,
> +                                         "underscan vborder", 0, 128);
>         if (!adev->mode_info.underscan_vborder_property)
>                 return -ENOMEM;
>
>         sz = ARRAY_SIZE(amdgpu_audio_enum_list);
>         adev->mode_info.audio_property =
> -               drm_property_create_enum(adev->ddev, 0,
> +               drm_property_create_enum(ADEV_TO_DRM(adev), 0,
>                                          "audio",
>                                          amdgpu_audio_enum_list, sz);
>
>         sz = ARRAY_SIZE(amdgpu_dither_enum_list);
>         adev->mode_info.dither_property =
> -               drm_property_create_enum(adev->ddev, 0,
> +               drm_property_create_enum(ADEV_TO_DRM(adev), 0,
>                                          "dither",
>                                          amdgpu_dither_enum_list, sz);
>
>         if (amdgpu_device_has_dc_support(adev)) {
>                 adev->mode_info.abm_level_property =
> -                       drm_property_create_range(adev->ddev, 0,
> -                                               "abm level", 0, 4);
> +                       drm_property_create_range(ADEV_TO_DRM(adev), 0,
> +                                                 "abm level", 0, 4);
>                 if (!adev->mode_info.abm_level_property)
>                         return -ENOMEM;
>                 adev->mode_info.freesync_property =
> -                       drm_property_create_bool(adev->ddev, 0, "freesync");
> +                       drm_property_create_bool(ADEV_TO_DRM(adev), 0,
> +                                                "freesync");
>                 if (!adev->mode_info.freesync_property)
>                         return -ENOMEM;
>                 adev->mode_info.freesync_capable_property =
> -                       drm_property_create_bool(adev->ddev,
> +                       drm_property_create_bool(ADEV_TO_DRM(adev),
>                                                  0,
>                                                  "freesync_capable");
>                 if (!adev->mode_info.freesync_capable_property)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index d008ca95130c..53dc9f9a46c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -117,7 +117,7 @@ void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
>
>  void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
>  {
> -       struct drm_device *ddev = adev->ddev;
> +       struct drm_device *ddev = ADEV_TO_DRM(adev);
>         struct drm_crtc *crtc;
>         struct amdgpu_crtc *amdgpu_crtc;
>
> @@ -138,7 +138,7 @@ void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
>
>  u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_crtc *crtc;
>         struct amdgpu_crtc *amdgpu_crtc;
>         u32 vblank_in_pixels;
> @@ -165,7 +165,7 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
>
>  u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_crtc *crtc;
>         struct amdgpu_crtc *amdgpu_crtc;
>         u32 vrefresh = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index a887460bbb02..3bf650fbfbf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/vga_switcheroo.h>
>  #include <drm/drm_probe_helper.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/component.h>

Leftover from debugging?

>
>  #include "amdgpu.h"
>  #include "amdgpu_irq.h"
> @@ -1082,8 +1083,8 @@ static struct drm_driver kms_driver;
>  static int amdgpu_pci_probe(struct pci_dev *pdev,
>                             const struct pci_device_id *ent)
>  {
> -       struct drm_device *dev;
> -       struct amdgpu_device *adev;
> +       struct drm_device *ddev;
> +       struct amdgpu_device *adev = NULL;
>         unsigned long flags = ent->driver_data;
>         int ret, retry = 0;
>         bool supports_atomic = false;
> @@ -1138,36 +1139,46 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> -       dev = drm_dev_alloc(&kms_driver, &pdev->dev);
> -       if (IS_ERR(dev))
> -               return PTR_ERR(dev);
> +       adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return -ENOMEM;
> +
> +       adev->dev = &pdev->dev;
> +       adev->pdev = pdev;
> +       ddev = ADEV_TO_DRM(adev);
> +       ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
> +       if (ret)
> +               goto err_free;
>
>         if (!supports_atomic)
> -               dev->driver_features &= ~DRIVER_ATOMIC;
> +               ddev->driver_features &= ~DRIVER_ATOMIC;
>
>         ret = pci_enable_device(pdev);
>         if (ret)
>                 goto err_free;
>
> -       dev->pdev = pdev;
> +       ddev->pdev = pdev;
> +       pci_set_drvdata(pdev, ddev);
>
> -       pci_set_drvdata(pdev, dev);
> -
> -       ret = amdgpu_driver_load_kms(dev, ent->driver_data);
> +       ret = amdgpu_driver_load_kms(adev, ent->driver_data);
>         if (ret)
>                 goto err_pci;
>
>  retry_init:
> -       ret = drm_dev_register(dev, ent->driver_data);
> +       ret = drm_dev_register(ddev, ent->driver_data);
>         if (ret == -EAGAIN && ++retry <= 3) {
>                 DRM_INFO("retry init %d\n", retry);
>                 /* Don't request EX mode too frequently which is attacking */
>                 msleep(5000);
>                 goto retry_init;
> -       } else if (ret)
> +       } else if (ret) {
>                 goto err_pci;
> +       }
> +
> +       /* ret = component_bind_all(adev->dev, ddev); */
> +       /* if (ret) */
> +       /*      DRM_ERROR("component_bind_all() returned %d\n", ret); */

Leftover from debugging?

>
> -       adev = DRM_TO_ADEV(dev);
>         ret = amdgpu_debugfs_init(adev);
>         if (ret)
>                 DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> @@ -1177,7 +1188,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  err_pci:
>         pci_disable_device(pdev);
>  err_free:
> -       drm_dev_put(dev);
> +       drm_dev_put(ddev);
>         return ret;
>  }
>
> @@ -1190,6 +1201,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>         if (THIS_MODULE->state != MODULE_STATE_GOING)
>  #endif
>                 DRM_ERROR("Hotplug removal is not supported\n");
> +       /* component_unbind_all(&pdev->dev, dev); */
>         drm_dev_unplug(dev);
>         amdgpu_driver_unload_kms(dev);
>         pci_disable_device(pdev);
> @@ -1197,6 +1209,14 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>         drm_dev_put(dev);
>  }
>
> +static void amdgpu_driver_release(struct drm_device *ddev)
> +{
> +       struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
> +
> +       drm_dev_fini(ddev);
> +       kfree(adev);
> +}
> +
>  static void
>  amdgpu_pci_shutdown(struct pci_dev *pdev)
>  {
> @@ -1491,6 +1511,7 @@ static struct drm_driver kms_driver = {
>         .open = amdgpu_driver_open_kms,
>         .postclose = amdgpu_driver_postclose_kms,
>         .lastclose = amdgpu_driver_lastclose_kms,
> +       .release   = amdgpu_driver_release,
>         .irq_handler = amdgpu_irq_handler,
>         .ioctls = amdgpu_ioctls_kms,
>         .gem_free_object_unlocked = amdgpu_gem_object_free,
> @@ -1525,8 +1546,6 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>         .driver.pm = &amdgpu_pm_ops,
>  };
>
> -
> -
>  static int __init amdgpu_init(void)
>  {
>         int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index 25ddb482466a..984cee16829e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -135,7 +135,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
>                                AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
>                                AMDGPU_GEM_CREATE_VRAM_CLEARED;
>
> -       info = drm_get_format_info(adev->ddev, mode_cmd);
> +       info = drm_get_format_info(ADEV_TO_DRM(adev), mode_cmd);
>         cpp = info->cpp[0];
>
>         /* need to align pitch with crtc limits */
> @@ -231,7 +231,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
>                 goto out;
>         }
>
> -       ret = amdgpu_display_framebuffer_init(adev->ddev, &rfbdev->rfb,
> +       ret = amdgpu_display_framebuffer_init(ADEV_TO_DRM(adev), &rfbdev->rfb,
>                                               &mode_cmd, gobj);
>         if (ret) {
>                 DRM_ERROR("failed to initialize framebuffer %d\n", ret);
> @@ -254,7 +254,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
>         drm_fb_helper_fill_info(info, &rfbdev->helper, sizes);
>
>         /* setup aperture base/size for vesafb takeover */
> -       info->apertures->ranges[0].base = adev->ddev->mode_config.fb_base;
> +       info->apertures->ranges[0].base = adev->ddev.mode_config.fb_base;
>         info->apertures->ranges[0].size = adev->gmc.aper_size;
>
>         /* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
> @@ -270,7 +270,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
>         DRM_INFO("fb depth is %d\n", fb->format->depth);
>         DRM_INFO("   pitch is %d\n", fb->pitches[0]);
>
> -       vga_switcheroo_client_fb_set(adev->ddev->pdev, info);
> +       vga_switcheroo_client_fb_set(adev->ddev.pdev, info);
>         return 0;
>
>  out:
> @@ -318,7 +318,7 @@ int amdgpu_fbdev_init(struct amdgpu_device *adev)
>                 return 0;
>
>         /* don't init fbdev if there are no connectors */
> -       if (list_empty(&adev->ddev->mode_config.connector_list))
> +       if (list_empty(&adev->ddev.mode_config.connector_list))
>                 return 0;
>
>         /* select 8 bpp console on low vram cards */
> @@ -332,10 +332,10 @@ int amdgpu_fbdev_init(struct amdgpu_device *adev)
>         rfbdev->adev = adev;
>         adev->mode_info.rfbdev = rfbdev;
>
> -       drm_fb_helper_prepare(adev->ddev, &rfbdev->helper,
> -                       &amdgpu_fb_helper_funcs);
> +       drm_fb_helper_prepare(ADEV_TO_DRM(adev), &rfbdev->helper,
> +                             &amdgpu_fb_helper_funcs);
>
> -       ret = drm_fb_helper_init(adev->ddev, &rfbdev->helper);
> +       ret = drm_fb_helper_init(ADEV_TO_DRM(adev), &rfbdev->helper);
>         if (ret) {
>                 kfree(rfbdev);
>                 return ret;
> @@ -343,7 +343,7 @@ int amdgpu_fbdev_init(struct amdgpu_device *adev)
>
>         /* disable all the possible outputs/crtcs before entering KMS mode */
>         if (!amdgpu_device_has_dc_support(adev))
> -               drm_helper_disable_unused_functions(adev->ddev);
> +               drm_helper_disable_unused_functions(ADEV_TO_DRM(adev));
>
>         drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);
>         return 0;
> @@ -354,7 +354,7 @@ void amdgpu_fbdev_fini(struct amdgpu_device *adev)
>         if (!adev->mode_info.rfbdev)
>                 return;
>
> -       amdgpu_fbdev_destroy(adev->ddev, adev->mode_info.rfbdev);
> +       amdgpu_fbdev_destroy(ADEV_TO_DRM(adev), adev->mode_info.rfbdev);
>         kfree(adev->mode_info.rfbdev);
>         adev->mode_info.rfbdev = NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 68ba263f4611..6d77c423543c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -155,7 +155,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>                        seq);
>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                                seq, flags | AMDGPU_FENCE_FLAG_INT);
> -       pm_runtime_get_noresume(adev->ddev->dev);
> +       pm_runtime_get_noresume(adev->ddev.dev);
>         ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>         if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>                 struct dma_fence *old;
> @@ -284,8 +284,8 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>                         BUG();
>
>                 dma_fence_put(fence);
> -               pm_runtime_mark_last_busy(adev->ddev->dev);
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_mark_last_busy(adev->ddev.dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>         } while (last_seq != seq);
>
>         return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 292c7a505b9e..65ed08699f81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -92,7 +92,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>
>  void amdgpu_gem_force_release(struct amdgpu_device *adev)
>  {
> -       struct drm_device *ddev = adev->ddev;
> +       struct drm_device *ddev = ADEV_TO_DRM(adev);
>         struct drm_file *file;
>
>         mutex_lock(&ddev->filelist_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> index da7449ab0595..e404d27d6973 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -253,7 +253,7 @@ void amdgpu_i2c_add(struct amdgpu_device *adev,
>                     const struct amdgpu_i2c_bus_rec *rec,
>                     const char *name)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         int i;
>
>         for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 422491eb8042..79d4331ed2ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -85,7 +85,7 @@ static void amdgpu_hotplug_work_func(struct work_struct *work)
>  {
>         struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>                                                   hotplug_work);
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_mode_config *mode_config = &dev->mode_config;
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
> @@ -268,9 +268,9 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>                 if (!adev->enable_virtual_display)
>                         /* Disable vblank IRQs aggressively for power-saving */
>                         /* XXX: can this be enabled for DC? */
> -                       adev->ddev->vblank_disable_immediate = true;
> +                       adev->ddev.vblank_disable_immediate = true;
>
> -               r = drm_vblank_init(adev->ddev, adev->mode_info.num_crtc);
> +               r = drm_vblank_init(ADEV_TO_DRM(adev), adev->mode_info.num_crtc);
>                 if (r)
>                         return r;
>
> @@ -284,14 +284,14 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>
>         adev->irq.installed = true;
>         /* Use vector 0 for MSI-X */
> -       r = drm_irq_install(adev->ddev, pci_irq_vector(adev->pdev, 0));
> +       r = drm_irq_install(ADEV_TO_DRM(adev), pci_irq_vector(adev->pdev, 0));
>         if (r) {
>                 adev->irq.installed = false;
>                 if (!amdgpu_device_has_dc_support(adev))
>                         flush_work(&adev->hotplug_work);
>                 return r;
>         }
> -       adev->ddev->max_vblank_count = 0x00ffffff;
> +       adev->ddev.max_vblank_count = 0x00ffffff;
>
>         DRM_DEBUG("amdgpu: irq initialized.\n");
>         return 0;
> @@ -311,7 +311,7 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
>         unsigned i, j;
>
>         if (adev->irq.installed) {
> -               drm_irq_uninstall(adev->ddev);
> +               drm_irq_uninstall(ADEV_TO_DRM(adev));
>                 adev->irq.installed = false;
>                 if (adev->irq.msi_enabled)
>                         pci_free_irq_vectors(adev->pdev);
> @@ -522,7 +522,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>  int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>                    unsigned type)
>  {
> -       if (!adev->ddev->irq_enabled)
> +       if (!adev->ddev.irq_enabled)
>                 return -ENOENT;
>
>         if (type >= src->num_types)
> @@ -552,7 +552,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>  int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>                    unsigned type)
>  {
> -       if (!adev->ddev->irq_enabled)
> +       if (!adev->ddev.irq_enabled)
>                 return -ENOENT;
>
>         if (type >= src->num_types)
> @@ -583,7 +583,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>  bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>                         unsigned type)
>  {
> -       if (!adev->ddev->irq_enabled)
> +       if (!adev->ddev.irq_enabled)
>                 return false;
>
>         if (type >= src->num_types)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8335f831fdf4..d6474a85b64e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -86,7 +86,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>         amdgpu_unregister_gpu_instance(adev);
>
>         if (adev->rmmio == NULL)
> -               goto done_free;
> +               return;
>
>         if (adev->runpm) {
>                 pm_runtime_get_sync(dev->dev);
> @@ -96,10 +96,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>         amdgpu_acpi_fini(adev);
>
>         amdgpu_device_fini(adev);
> -
> -done_free:
> -       kfree(adev);
> -       dev->dev_private = NULL;
>  }
>
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
> @@ -130,22 +126,18 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>  /**
>   * amdgpu_driver_load_kms - Main load function for KMS.
>   *
> - * @dev: drm dev pointer
> + * @adev: pointer to struct amdgpu_device
>   * @flags: device flags
>   *
>   * This is the main load function for KMS (all asics).
>   * Returns 0 on success, error on failure.
>   */
> -int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
> +int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  {
> -       struct amdgpu_device *adev;
> +       struct drm_device *dev;
>         int r, acpi_status;
>
> -       adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);
> -       if (adev == NULL) {
> -               return -ENOMEM;
> -       }
> -       dev->dev_private = (void *)adev;
> +       dev = ADEV_TO_DRM(adev);
>
>         if (amdgpu_has_atpx() &&
>             (amdgpu_is_atpx_hybrid() ||
> @@ -160,7 +152,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>          * properly initialize the GPU MC controller and permit
>          * VRAM allocation
>          */
> -       r = amdgpu_device_init(adev, dev, dev->pdev, flags);
> +       r = amdgpu_device_init(adev, flags);
>         if (r) {
>                 dev_err(&dev->pdev->dev, "Fatal error during GPU init\n");
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3d95b3edb635..ef58fc3ab206 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -555,7 +555,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>         bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
>         if (bo == NULL)
>                 return -ENOMEM;
> -       drm_gem_private_object_init(adev->ddev, &bo->tbo.base, size);
> +       drm_gem_private_object_init(ADEV_TO_DRM(adev), &bo->tbo.base, size);
>         INIT_LIST_HEAD(&bo->shadow_list);
>         bo->vm_bo = NULL;
>         bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 4a7a37e21201..48a18df1c658 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -2076,7 +2076,7 @@ static ssize_t amdgpu_get_thermal_throttling_logging(struct device *dev,
>         struct amdgpu_device *adev = DRM_TO_ADEV(ddev);
>
>         return snprintf(buf, PAGE_SIZE, "%s: thermal throttling logging %s, with interval %d seconds\n",
> -                       adev->ddev->unique,
> +                       adev->ddev.unique,
>                         atomic_read(&adev->throttling_logging_enabled) ? "enabled" : "disabled",
>                         adev->throttling_logging_rs.interval / HZ + 1);
>  }
> @@ -2374,9 +2374,9 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>         if (channel >= PP_TEMP_MAX)
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -2405,8 +2405,8 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -2511,9 +2511,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       ret = pm_runtime_get_sync(adev->ddev->dev);
> +       ret = pm_runtime_get_sync(adev->ddev.dev);
>         if (ret < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return ret;
>         }
>
> @@ -2523,8 +2523,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>                 pwm_mode = smu_get_fan_control_mode(&adev->smu);
>         } else {
>                 if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         up_read(&adev->reset_sem);
>                         return -EINVAL;
>                 }
> @@ -2534,8 +2534,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return sprintf(buf, "%i\n", pwm_mode);
>  }
> @@ -2556,9 +2556,9 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>         if (err)
>                 return err;
>
> -       ret = pm_runtime_get_sync(adev->ddev->dev);
> +       ret = pm_runtime_get_sync(adev->ddev.dev);
>         if (ret < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return ret;
>         }
>
> @@ -2568,8 +2568,8 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>                 smu_set_fan_control_mode(&adev->smu, value);
>         } else {
>                 if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         up_read(&adev->reset_sem);
>                         return -EINVAL;
>                 }
> @@ -2579,8 +2579,8 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return count;
>  }
> @@ -2611,9 +2611,9 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2628,15 +2628,15 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>
>         if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
>                 pr_info("manual fan speed control should be enabled first\n");
> -               pm_runtime_mark_last_busy(adev->ddev->dev);
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_mark_last_busy(adev->ddev.dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return -EINVAL;
>         }
>
>         err = kstrtou32(buf, 10, &value);
>         if (err) {
> -               pm_runtime_mark_last_busy(adev->ddev->dev);
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_mark_last_busy(adev->ddev.dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2649,8 +2649,8 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>         else
>                 err = -EINVAL;
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -2669,9 +2669,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2686,8 +2686,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -2708,9 +2708,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2725,8 +2725,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -2746,9 +2746,9 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -2759,8 +2759,8 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -2780,9 +2780,9 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -2793,8 +2793,8 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -2813,9 +2813,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2830,8 +2830,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -2851,9 +2851,9 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2867,15 +2867,15 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>         up_read(&adev->reset_sem);
>
>         if (pwm_mode != AMD_FAN_CTRL_MANUAL) {
> -               pm_runtime_mark_last_busy(adev->ddev->dev);
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_mark_last_busy(adev->ddev.dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return -ENODATA;
>         }
>
>         err = kstrtou32(buf, 10, &value);
>         if (err) {
> -               pm_runtime_mark_last_busy(adev->ddev->dev);
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_mark_last_busy(adev->ddev.dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2890,8 +2890,8 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -2910,9 +2910,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       ret = pm_runtime_get_sync(adev->ddev->dev);
> +       ret = pm_runtime_get_sync(adev->ddev.dev);
>         if (ret < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return ret;
>         }
>
> @@ -2922,8 +2922,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>                 pwm_mode = smu_get_fan_control_mode(&adev->smu);
>         } else {
>                 if (!adev->powerplay.pp_funcs->get_fan_control_mode) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         up_read(&adev->reset_sem);
>                         return -EINVAL;
>                 }
> @@ -2933,8 +2933,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return sprintf(buf, "%i\n", pwm_mode == AMD_FAN_CTRL_AUTO ? 0 : 1);
>  }
> @@ -2963,9 +2963,9 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>         else
>                 return -EINVAL;
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -2975,8 +2975,8 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>                 smu_set_fan_control_mode(&adev->smu, pwm_mode);
>         } else {
>                 if (!adev->powerplay.pp_funcs->set_fan_control_mode) {
> -                       pm_runtime_mark_last_busy(adev->ddev->dev);
> -                       pm_runtime_put_autosuspend(adev->ddev->dev);
> +                       pm_runtime_mark_last_busy(adev->ddev.dev);
> +                       pm_runtime_put_autosuspend(adev->ddev.dev);
>                         up_read(&adev->reset_sem);
>                         return -EINVAL;
>                 }
> @@ -2985,8 +2985,8 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return count;
>  }
> @@ -3002,9 +3002,9 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3014,8 +3014,8 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>                                    (void *)&vddgfx, &size);
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -3045,9 +3045,9 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>         if  (!(adev->flags & AMD_IS_APU))
>                 return -EINVAL;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3057,8 +3057,8 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>                                    (void *)&vddnb, &size);
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -3085,9 +3085,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3097,8 +3097,8 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>                                    (void *)&query, &size);
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -3128,9 +3128,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3148,8 +3148,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return size;
>  }
> @@ -3166,9 +3166,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3186,8 +3186,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         return size;
>  }
> @@ -3215,9 +3215,9 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>         value = value / 1000000; /* convert to Watt */
>
>
> -       err = pm_runtime_get_sync(adev->ddev->dev);
> +       err = pm_runtime_get_sync(adev->ddev.dev);
>         if (err < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return err;
>         }
>
> @@ -3232,8 +3232,8 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (err)
>                 return err;
> @@ -3252,9 +3252,9 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3264,8 +3264,8 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>                                    (void *)&sclk, &size);
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> @@ -3291,9 +3291,9 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>         if (amdgpu_in_reset(adev))
>                 return -EPERM;
>
> -       r = pm_runtime_get_sync(adev->ddev->dev);
> +       r = pm_runtime_get_sync(adev->ddev.dev);
>         if (r < 0) {
> -               pm_runtime_put_autosuspend(adev->ddev->dev);
> +               pm_runtime_put_autosuspend(adev->ddev.dev);
>                 return r;
>         }
>
> @@ -3303,8 +3303,8 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>                                    (void *)&mclk, &size);
>         up_read(&adev->reset_sem);
>
> -       pm_runtime_mark_last_busy(adev->ddev->dev);
> -       pm_runtime_put_autosuspend(adev->ddev->dev);
> +       pm_runtime_mark_last_busy(adev->ddev.dev);
> +       pm_runtime_put_autosuspend(adev->ddev.dev);
>
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 1311d6aec5d4..5a46d2b44005 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -226,7 +226,7 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
>         pmu_entry->pmu.attr_groups = attr_groups;
>         pmu_entry->pmu_perf_type = pmu_perf_type;
>         snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d",
> -                               pmu_file_prefix, adev->ddev->primary->index);
> +                               pmu_file_prefix, adev->ddev.primary->index);
>
>         ret = perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
> index 87cbc9011b2d..4ec8c32e682f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
> @@ -46,7 +46,7 @@ static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
>         struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>         struct ta_rap_shared_memory *rap_shared_mem;
>         struct ta_rap_cmd_output_data *rap_cmd_output;
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         uint32_t op;
>         int ret;
>
> @@ -116,7 +116,7 @@ static const struct file_operations amdgpu_rap_debugfs_ops = {
>  void amdgpu_rap_debugfs_init(struct amdgpu_device *adev)
>  {
>  #if defined(CONFIG_DEBUG_FS)
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>
>         if (!adev->psp.rap_context.rap_initialized)
>                 return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index cd1403f83dcf..d3ae40b097c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1197,7 +1197,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
>  static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>
>         con->dir = debugfs_create_dir(RAS_FS_NAME, minor->debugfs_root);
>         debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13ea8ebc421c..9d21675fbe39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -420,7 +420,7 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>                              struct amdgpu_ring *ring)
>  {
>  #if defined(CONFIG_DEBUG_FS)
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>         struct dentry *ent, *root = minor->debugfs_root;
>         char name[32];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6f1f982684c0..a0b0477a30ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1926,8 +1926,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         /* No others user of address space so set it to 0 */
>         r = ttm_bo_device_init(&adev->mman.bdev,
>                                &amdgpu_bo_driver,
> -                              adev->ddev->anon_inode->i_mapping,
> -                              adev->ddev->vma_offset_manager,
> +                              adev->ddev.anon_inode->i_mapping,
> +                              adev->ddev.vma_offset_manager,
>                                dma_addressing_limited(adev->dev));
>         if (r) {
>                 DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> @@ -2611,7 +2611,7 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>  #if defined(CONFIG_DEBUG_FS)
>         unsigned count;
>
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>         struct dentry *ent, *root = minor->debugfs_root;
>
>         for (count = 0; count < ARRAY_SIZE(ttm_debugfs_entries); count++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 1e211544f2dc..80624deffe4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -45,7 +45,7 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>         if (adev->mode_info.num_crtc == 0)
>                 adev->mode_info.num_crtc = 1;
>         adev->enable_virtual_display = true;
> -       adev->ddev->driver->driver_features &= ~DRIVER_ATOMIC;
> +       adev->ddev.driver->driver_features &= ~DRIVER_ATOMIC;
>         adev->cg_flags = 0;
>         adev->pg_flags = 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 63e258f7ba99..6e35291bf448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -308,7 +308,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
>
>
>  remove_link:
> -       sysfs_remove_link(&adev->dev->kobj, adev->ddev->unique);
> +       sysfs_remove_link(&adev->dev->kobj, adev->ddev.unique);
>
>  remove_file:
>         device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 3effe97f4fca..e6010f0bc839 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -1673,7 +1673,7 @@ amdgpu_atombios_encoder_set_crtc_source(struct drm_encoder *encoder)
>  void
>  amdgpu_atombios_encoder_init_dig(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_encoder *encoder;
>
>         list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 67f85b74c392..8ea2a02d1953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -328,7 +328,7 @@ static void dce_v10_0_hpd_set_polarity(struct amdgpu_device *adev,
>   */
>  static void dce_v10_0_hpd_init(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -383,7 +383,7 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *adev)
>   */
>  static void dce_v10_0_hpd_fini(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -2701,7 +2701,7 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
>         if (amdgpu_crtc == NULL)
>                 return -ENOMEM;
>
> -       drm_crtc_init(adev->ddev, &amdgpu_crtc->base, &dce_v10_0_crtc_funcs);
> +       drm_crtc_init(ADEV_TO_DRM(adev), &amdgpu_crtc->base, &dce_v10_0_crtc_funcs);
>
>         drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
>         amdgpu_crtc->crtc_id = index;
> @@ -2709,8 +2709,8 @@ static int dce_v10_0_crtc_init(struct amdgpu_device *adev, int index)
>
>         amdgpu_crtc->max_cursor_width = 128;
>         amdgpu_crtc->max_cursor_height = 128;
> -       adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> -       adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
> +       adev->ddev.mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> +       adev->ddev.mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
>
>         switch (amdgpu_crtc->crtc_id) {
>         case 0:
> @@ -2792,24 +2792,24 @@ static int dce_v10_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.funcs = &amdgpu_mode_funcs;
> +       adev->ddev.mode_config.funcs = &amdgpu_mode_funcs;
>
> -       adev->ddev->mode_config.async_page_flip = true;
> +       adev->ddev.mode_config.async_page_flip = true;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
>
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
>         /* allocate crtcs */
>         for (i = 0; i < adev->mode_info.num_crtc; i++) {
> @@ -2819,7 +2819,7 @@ static int dce_v10_0_sw_init(void *handle)
>         }
>
>         if (amdgpu_atombios_get_connector_info_from_object_table(adev))
> -               amdgpu_display_print_display_setup(adev->ddev);
> +               amdgpu_display_print_display_setup(ADEV_TO_DRM(adev));
>         else
>                 return -EINVAL;
>
> @@ -2832,7 +2832,7 @@ static int dce_v10_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       drm_kms_helper_poll_init(adev->ddev);
> +       drm_kms_helper_poll_init(ADEV_TO_DRM(adev));
>
>         adev->mode_info.mode_config_initialized = true;
>         return 0;
> @@ -2844,13 +2844,13 @@ static int dce_v10_0_sw_fini(void *handle)
>
>         kfree(adev->mode_info.bios_hardcoded_edid);
>
> -       drm_kms_helper_poll_fini(adev->ddev);
> +       drm_kms_helper_poll_fini(ADEV_TO_DRM(adev));
>
>         dce_v10_0_audio_fini(adev);
>
>         dce_v10_0_afmt_fini(adev);
>
> -       drm_mode_config_cleanup(adev->ddev);
> +       drm_mode_config_cleanup(ADEV_TO_DRM(adev));
>         adev->mode_info.mode_config_initialized = false;
>
>         return 0;
> @@ -3157,14 +3157,14 @@ static int dce_v10_0_pageflip_irq(struct amdgpu_device *adev,
>         if (amdgpu_crtc == NULL)
>                 return 0;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         works = amdgpu_crtc->pflip_works;
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>                                                  "AMDGPU_FLIP_SUBMITTED(%d)\n",
>                                                  amdgpu_crtc->pflip_status,
>                                                  AMDGPU_FLIP_SUBMITTED);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return 0;
>         }
>
> @@ -3176,7 +3176,7 @@ static int dce_v10_0_pageflip_irq(struct amdgpu_device *adev,
>         if (works->event)
>                 drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         drm_crtc_vblank_put(&amdgpu_crtc->base);
>         schedule_work(&works->unpin_work);
> @@ -3245,7 +3245,7 @@ static int dce_v10_0_crtc_irq(struct amdgpu_device *adev,
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
>
>                 if (amdgpu_irq_enabled(adev, source, irq_type)) {
> -                       drm_handle_vblank(adev->ddev, crtc);
> +                       drm_handle_vblank(ADEV_TO_DRM(adev), crtc);
>                 }
>                 DRM_DEBUG("IH: D%d vblank\n", crtc + 1);
>
> @@ -3485,7 +3485,7 @@ static void dce_v10_0_encoder_add(struct amdgpu_device *adev,
>                                  uint32_t supported_device,
>                                  u16 caps)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index 2c61e0874b32..3fea9fba63e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -346,7 +346,7 @@ static void dce_v11_0_hpd_set_polarity(struct amdgpu_device *adev,
>   */
>  static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -400,7 +400,7 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
>   */
>  static void dce_v11_0_hpd_fini(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -2809,7 +2809,7 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
>         if (amdgpu_crtc == NULL)
>                 return -ENOMEM;
>
> -       drm_crtc_init(adev->ddev, &amdgpu_crtc->base, &dce_v11_0_crtc_funcs);
> +       drm_crtc_init(ADEV_TO_DRM(adev), &amdgpu_crtc->base, &dce_v11_0_crtc_funcs);
>
>         drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
>         amdgpu_crtc->crtc_id = index;
> @@ -2817,8 +2817,8 @@ static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int index)
>
>         amdgpu_crtc->max_cursor_width = 128;
>         amdgpu_crtc->max_cursor_height = 128;
> -       adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> -       adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
> +       adev->ddev.mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> +       adev->ddev.mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
>
>         switch (amdgpu_crtc->crtc_id) {
>         case 0:
> @@ -2913,24 +2913,24 @@ static int dce_v11_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.funcs = &amdgpu_mode_funcs;
> +       adev->ddev.mode_config.funcs = &amdgpu_mode_funcs;
>
> -       adev->ddev->mode_config.async_page_flip = true;
> +       adev->ddev.mode_config.async_page_flip = true;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
>
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
>
>         /* allocate crtcs */
> @@ -2941,7 +2941,7 @@ static int dce_v11_0_sw_init(void *handle)
>         }
>
>         if (amdgpu_atombios_get_connector_info_from_object_table(adev))
> -               amdgpu_display_print_display_setup(adev->ddev);
> +               amdgpu_display_print_display_setup(ADEV_TO_DRM(adev));
>         else
>                 return -EINVAL;
>
> @@ -2954,7 +2954,7 @@ static int dce_v11_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       drm_kms_helper_poll_init(adev->ddev);
> +       drm_kms_helper_poll_init(ADEV_TO_DRM(adev));
>
>         adev->mode_info.mode_config_initialized = true;
>         return 0;
> @@ -2966,13 +2966,13 @@ static int dce_v11_0_sw_fini(void *handle)
>
>         kfree(adev->mode_info.bios_hardcoded_edid);
>
> -       drm_kms_helper_poll_fini(adev->ddev);
> +       drm_kms_helper_poll_fini(ADEV_TO_DRM(adev));
>
>         dce_v11_0_audio_fini(adev);
>
>         dce_v11_0_afmt_fini(adev);
>
> -       drm_mode_config_cleanup(adev->ddev);
> +       drm_mode_config_cleanup(ADEV_TO_DRM(adev));
>         adev->mode_info.mode_config_initialized = false;
>
>         return 0;
> @@ -3283,14 +3283,14 @@ static int dce_v11_0_pageflip_irq(struct amdgpu_device *adev,
>         if(amdgpu_crtc == NULL)
>                 return 0;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         works = amdgpu_crtc->pflip_works;
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>                                                  "AMDGPU_FLIP_SUBMITTED(%d)\n",
>                                                  amdgpu_crtc->pflip_status,
>                                                  AMDGPU_FLIP_SUBMITTED);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return 0;
>         }
>
> @@ -3302,7 +3302,7 @@ static int dce_v11_0_pageflip_irq(struct amdgpu_device *adev,
>         if(works->event)
>                 drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         drm_crtc_vblank_put(&amdgpu_crtc->base);
>         schedule_work(&works->unpin_work);
> @@ -3372,7 +3372,7 @@ static int dce_v11_0_crtc_irq(struct amdgpu_device *adev,
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
>
>                 if (amdgpu_irq_enabled(adev, source, irq_type)) {
> -                       drm_handle_vblank(adev->ddev, crtc);
> +                       drm_handle_vblank(ADEV_TO_DRM(adev), crtc);
>                 }
>                 DRM_DEBUG("IH: D%d vblank\n", crtc + 1);
>
> @@ -3611,7 +3611,7 @@ static void dce_v11_0_encoder_add(struct amdgpu_device *adev,
>                                  uint32_t supported_device,
>                                  u16 caps)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index cf3e7062524f..33a1fb8e8b1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -279,7 +279,7 @@ static void dce_v6_0_hpd_set_polarity(struct amdgpu_device *adev,
>   */
>  static void dce_v6_0_hpd_init(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -324,7 +324,7 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *adev)
>   */
>  static void dce_v6_0_hpd_fini(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -2591,7 +2591,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>         if (amdgpu_crtc == NULL)
>                 return -ENOMEM;
>
> -       drm_crtc_init(adev->ddev, &amdgpu_crtc->base, &dce_v6_0_crtc_funcs);
> +       drm_crtc_init(ADEV_TO_DRM(adev), &amdgpu_crtc->base, &dce_v6_0_crtc_funcs);
>
>         drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
>         amdgpu_crtc->crtc_id = index;
> @@ -2599,8 +2599,8 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>
>         amdgpu_crtc->max_cursor_width = CURSOR_WIDTH;
>         amdgpu_crtc->max_cursor_height = CURSOR_HEIGHT;
> -       adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> -       adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
> +       adev->ddev.mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> +       adev->ddev.mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
>
>         amdgpu_crtc->crtc_offset = crtc_offsets[amdgpu_crtc->crtc_id];
>
> @@ -2669,20 +2669,20 @@ static int dce_v6_0_sw_init(void *handle)
>
>         adev->mode_info.mode_config_initialized = true;
>
> -       adev->ddev->mode_config.funcs = &amdgpu_mode_funcs;
> -       adev->ddev->mode_config.async_page_flip = true;
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.funcs = &amdgpu_mode_funcs;
> +       adev->ddev.mode_config.async_page_flip = true;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
>         /* allocate crtcs */
>         for (i = 0; i < adev->mode_info.num_crtc; i++) {
> @@ -2693,7 +2693,7 @@ static int dce_v6_0_sw_init(void *handle)
>
>         ret = amdgpu_atombios_get_connector_info_from_object_table(adev);
>         if (ret)
> -               amdgpu_display_print_display_setup(adev->ddev);
> +               amdgpu_display_print_display_setup(ADEV_TO_DRM(adev));
>         else
>                 return -EINVAL;
>
> @@ -2706,7 +2706,7 @@ static int dce_v6_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       drm_kms_helper_poll_init(adev->ddev);
> +       drm_kms_helper_poll_init(ADEV_TO_DRM(adev));
>
>         return r;
>  }
> @@ -2717,12 +2717,12 @@ static int dce_v6_0_sw_fini(void *handle)
>
>         kfree(adev->mode_info.bios_hardcoded_edid);
>
> -       drm_kms_helper_poll_fini(adev->ddev);
> +       drm_kms_helper_poll_fini(ADEV_TO_DRM(adev));
>
>         dce_v6_0_audio_fini(adev);
>         dce_v6_0_afmt_fini(adev);
>
> -       drm_mode_config_cleanup(adev->ddev);
> +       drm_mode_config_cleanup(ADEV_TO_DRM(adev));
>         adev->mode_info.mode_config_initialized = false;
>
>         return 0;
> @@ -2967,7 +2967,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *adev,
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
>
>                 if (amdgpu_irq_enabled(adev, source, irq_type)) {
> -                       drm_handle_vblank(adev->ddev, crtc);
> +                       drm_handle_vblank(ADEV_TO_DRM(adev), crtc);
>                 }
>                 DRM_DEBUG("IH: D%d vblank\n", crtc + 1);
>                 break;
> @@ -3036,14 +3036,14 @@ static int dce_v6_0_pageflip_irq(struct amdgpu_device *adev,
>         if (amdgpu_crtc == NULL)
>                 return 0;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         works = amdgpu_crtc->pflip_works;
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>                                                 "AMDGPU_FLIP_SUBMITTED(%d)\n",
>                                                 amdgpu_crtc->pflip_status,
>                                                 AMDGPU_FLIP_SUBMITTED);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return 0;
>         }
>
> @@ -3055,7 +3055,7 @@ static int dce_v6_0_pageflip_irq(struct amdgpu_device *adev,
>         if (works->event)
>                 drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         drm_crtc_vblank_put(&amdgpu_crtc->base);
>         schedule_work(&works->unpin_work);
> @@ -3297,7 +3297,7 @@ static void dce_v6_0_encoder_add(struct amdgpu_device *adev,
>                                  uint32_t supported_device,
>                                  u16 caps)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index db6d23c85a7a..b947e32eba63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -273,7 +273,7 @@ static void dce_v8_0_hpd_set_polarity(struct amdgpu_device *adev,
>   */
>  static void dce_v8_0_hpd_init(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -318,7 +318,7 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *adev)
>   */
>  static void dce_v8_0_hpd_fini(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>         u32 tmp;
> @@ -2609,7 +2609,7 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
>         if (amdgpu_crtc == NULL)
>                 return -ENOMEM;
>
> -       drm_crtc_init(adev->ddev, &amdgpu_crtc->base, &dce_v8_0_crtc_funcs);
> +       drm_crtc_init(ADEV_TO_DRM(adev), &amdgpu_crtc->base, &dce_v8_0_crtc_funcs);
>
>         drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
>         amdgpu_crtc->crtc_id = index;
> @@ -2617,8 +2617,8 @@ static int dce_v8_0_crtc_init(struct amdgpu_device *adev, int index)
>
>         amdgpu_crtc->max_cursor_width = CIK_CURSOR_WIDTH;
>         amdgpu_crtc->max_cursor_height = CIK_CURSOR_HEIGHT;
> -       adev->ddev->mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> -       adev->ddev->mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
> +       adev->ddev.mode_config.cursor_width = amdgpu_crtc->max_cursor_width;
> +       adev->ddev.mode_config.cursor_height = amdgpu_crtc->max_cursor_height;
>
>         amdgpu_crtc->crtc_offset = crtc_offsets[amdgpu_crtc->crtc_id];
>
> @@ -2689,24 +2689,24 @@ static int dce_v8_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.funcs = &amdgpu_mode_funcs;
> +       adev->ddev.mode_config.funcs = &amdgpu_mode_funcs;
>
> -       adev->ddev->mode_config.async_page_flip = true;
> +       adev->ddev.mode_config.async_page_flip = true;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
>
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
>         /* allocate crtcs */
>         for (i = 0; i < adev->mode_info.num_crtc; i++) {
> @@ -2716,7 +2716,7 @@ static int dce_v8_0_sw_init(void *handle)
>         }
>
>         if (amdgpu_atombios_get_connector_info_from_object_table(adev))
> -               amdgpu_display_print_display_setup(adev->ddev);
> +               amdgpu_display_print_display_setup(ADEV_TO_DRM(adev));
>         else
>                 return -EINVAL;
>
> @@ -2729,7 +2729,7 @@ static int dce_v8_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       drm_kms_helper_poll_init(adev->ddev);
> +       drm_kms_helper_poll_init(ADEV_TO_DRM(adev));
>
>         adev->mode_info.mode_config_initialized = true;
>         return 0;
> @@ -2741,13 +2741,13 @@ static int dce_v8_0_sw_fini(void *handle)
>
>         kfree(adev->mode_info.bios_hardcoded_edid);
>
> -       drm_kms_helper_poll_fini(adev->ddev);
> +       drm_kms_helper_poll_fini(ADEV_TO_DRM(adev));
>
>         dce_v8_0_audio_fini(adev);
>
>         dce_v8_0_afmt_fini(adev);
>
> -       drm_mode_config_cleanup(adev->ddev);
> +       drm_mode_config_cleanup(ADEV_TO_DRM(adev));
>         adev->mode_info.mode_config_initialized = false;
>
>         return 0;
> @@ -3057,7 +3057,7 @@ static int dce_v8_0_crtc_irq(struct amdgpu_device *adev,
>                         DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
>
>                 if (amdgpu_irq_enabled(adev, source, irq_type)) {
> -                       drm_handle_vblank(adev->ddev, crtc);
> +                       drm_handle_vblank(ADEV_TO_DRM(adev), crtc);
>                 }
>                 DRM_DEBUG("IH: D%d vblank\n", crtc + 1);
>                 break;
> @@ -3126,14 +3126,14 @@ static int dce_v8_0_pageflip_irq(struct amdgpu_device *adev,
>         if (amdgpu_crtc == NULL)
>                 return 0;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         works = amdgpu_crtc->pflip_works;
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>                                                 "AMDGPU_FLIP_SUBMITTED(%d)\n",
>                                                 amdgpu_crtc->pflip_status,
>                                                 AMDGPU_FLIP_SUBMITTED);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return 0;
>         }
>
> @@ -3145,7 +3145,7 @@ static int dce_v8_0_pageflip_irq(struct amdgpu_device *adev,
>         if (works->event)
>                 drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         drm_crtc_vblank_put(&amdgpu_crtc->base);
>         schedule_work(&works->unpin_work);
> @@ -3373,7 +3373,7 @@ static void dce_v8_0_encoder_add(struct amdgpu_device *adev,
>                                  uint32_t supported_device,
>                                  u16 caps)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 873200b0ba80..a055921a7819 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -235,7 +235,7 @@ static int dce_virtual_crtc_init(struct amdgpu_device *adev, int index)
>         if (amdgpu_crtc == NULL)
>                 return -ENOMEM;
>
> -       drm_crtc_init(adev->ddev, &amdgpu_crtc->base, &dce_virtual_crtc_funcs);
> +       drm_crtc_init(ADEV_TO_DRM(adev), &amdgpu_crtc->base, &dce_virtual_crtc_funcs);
>
>         drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
>         amdgpu_crtc->crtc_id = index;
> @@ -374,24 +374,24 @@ static int dce_virtual_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       adev->ddev->max_vblank_count = 0;
> +       adev->ddev.max_vblank_count = 0;
>
> -       adev->ddev->mode_config.funcs = &amdgpu_mode_funcs;
> +       adev->ddev.mode_config.funcs = &amdgpu_mode_funcs;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
>
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         r = amdgpu_display_modeset_create_props(adev);
>         if (r)
>                 return r;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
>         /* allocate crtcs, encoders, connectors */
>         for (i = 0; i < adev->mode_info.num_crtc; i++) {
> @@ -403,7 +403,7 @@ static int dce_virtual_sw_init(void *handle)
>                         return r;
>         }
>
> -       drm_kms_helper_poll_init(adev->ddev);
> +       drm_kms_helper_poll_init(ADEV_TO_DRM(adev));
>
>         adev->mode_info.mode_config_initialized = true;
>         return 0;
> @@ -415,9 +415,9 @@ static int dce_virtual_sw_fini(void *handle)
>
>         kfree(adev->mode_info.bios_hardcoded_edid);
>
> -       drm_kms_helper_poll_fini(adev->ddev);
> +       drm_kms_helper_poll_fini(ADEV_TO_DRM(adev));
>
> -       drm_mode_config_cleanup(adev->ddev);
> +       drm_mode_config_cleanup(ADEV_TO_DRM(adev));
>         /* clear crtcs pointer to avoid dce irq finish routine access freed data */
>         memset(adev->mode_info.crtcs, 0, sizeof(adev->mode_info.crtcs[0]) * AMDGPU_MAX_CRTCS);
>         adev->mode_info.mode_config_initialized = false;
> @@ -602,7 +602,7 @@ static int dce_virtual_connector_encoder_init(struct amdgpu_device *adev,
>         if (!encoder)
>                 return -ENOMEM;
>         encoder->possible_crtcs = 1 << index;
> -       drm_encoder_init(adev->ddev, encoder, &dce_virtual_encoder_funcs,
> +       drm_encoder_init(ADEV_TO_DRM(adev), encoder, &dce_virtual_encoder_funcs,
>                          DRM_MODE_ENCODER_VIRTUAL, NULL);
>         drm_encoder_helper_add(encoder, &dce_virtual_encoder_helper_funcs);
>
> @@ -613,7 +613,7 @@ static int dce_virtual_connector_encoder_init(struct amdgpu_device *adev,
>         }
>
>         /* add a new connector */
> -       drm_connector_init(adev->ddev, connector, &dce_virtual_connector_funcs,
> +       drm_connector_init(ADEV_TO_DRM(adev), connector, &dce_virtual_connector_funcs,
>                            DRM_MODE_CONNECTOR_VIRTUAL);
>         drm_connector_helper_add(connector, &dce_virtual_connector_helper_funcs);
>         connector->display_info.subpixel_order = SubPixelHorizontalRGB;
> @@ -663,14 +663,14 @@ static int dce_virtual_pageflip(struct amdgpu_device *adev,
>         if (amdgpu_crtc == NULL)
>                 return 0;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         works = amdgpu_crtc->pflip_works;
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
>                         "AMDGPU_FLIP_SUBMITTED(%d)\n",
>                         amdgpu_crtc->pflip_status,
>                         AMDGPU_FLIP_SUBMITTED);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return 0;
>         }
>
> @@ -682,7 +682,7 @@ static int dce_virtual_pageflip(struct amdgpu_device *adev,
>         if (works->event)
>                 drm_crtc_send_vblank_event(&amdgpu_crtc->base, works->event);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         drm_crtc_vblank_put(&amdgpu_crtc->base);
>         amdgpu_bo_unref(&works->old_abo);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e8ca41c848aa..1d588a7b77d2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -268,7 +268,7 @@ static struct amdgpu_crtc *
>  get_crtc_by_otg_inst(struct amdgpu_device *adev,
>                      int otg_inst)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_crtc *crtc;
>         struct amdgpu_crtc *amdgpu_crtc;
>
> @@ -320,7 +320,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>                 return;
>         }
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>
>         if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
>                 DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
> @@ -328,7 +328,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>                                                  AMDGPU_FLIP_SUBMITTED,
>                                                  amdgpu_crtc->crtc_id,
>                                                  amdgpu_crtc);
> -               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                 return;
>         }
>
> @@ -380,7 +380,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>                 e->sequence = drm_crtc_vblank_count(&amdgpu_crtc->base);
>                 e->pipe = amdgpu_crtc->crtc_id;
>
> -               list_add_tail(&e->base.link, &adev->ddev->vblank_event_list);
> +               list_add_tail(&e->base.link, &adev->ddev.vblank_event_list);
>                 e = NULL;
>         }
>
> @@ -393,7 +393,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>                 amdgpu_get_vblank_counter_kms(&amdgpu_crtc->base);
>
>         amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
>                          amdgpu_crtc->crtc_id, amdgpu_crtc,
> @@ -429,7 +429,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>                         /* BTR processing for pre-DCE12 ASICs */
>                         if (acrtc_state->stream &&
>                             adev->family < AMDGPU_FAMILY_AI) {
> -                               spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +                               spin_lock_irqsave(&adev->ddev.event_lock, flags);
>                                 mod_freesync_handle_v_update(
>                                     adev->dm.freesync_module,
>                                     acrtc_state->stream,
> @@ -439,7 +439,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>                                     adev->dm.dc,
>                                     acrtc_state->stream,
>                                     &acrtc_state->vrr_params.adjust);
> -                               spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +                               spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>                         }
>                 }
>         }
> @@ -489,7 +489,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>         if (adev->family < AMDGPU_FAMILY_AI)
>                 return;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>
>         if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
>             acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> @@ -522,7 +522,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>                 acrtc->pflip_status = AMDGPU_FLIP_NONE;
>         }
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>  }
>
>  static int dm_set_clockgating_state(void *handle,
> @@ -850,7 +850,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  #endif
>         int r;
>
> -       adev->dm.ddev = adev->ddev;
> +       adev->dm.ddev = ADEV_TO_DRM(adev);
>         adev->dm.adev = adev;
>
>         /* Zero all the fields */
> @@ -986,10 +986,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>         /* TODO: Add_display_info? */
>
>         /* TODO use dynamic cursor width */
> -       adev->ddev->mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
> -       adev->ddev->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
> +       adev->ddev.mode_config.cursor_width = adev->dm.dc->caps.max_cursor_size;
> +       adev->ddev.mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>
> -       if (drm_vblank_init(adev->ddev, adev->dm.display_indexes_num)) {
> +       if (drm_vblank_init(ADEV_TO_DRM(adev), adev->dm.display_indexes_num)) {
>                 DRM_ERROR(
>                 "amdgpu: failed to initialize sw for display support.\n");
>                 goto error;
> @@ -1390,7 +1390,7 @@ static int dm_late_init(void *handle)
>         bool ret = true;
>
>         if (!adev->dm.fw_dmcu)
> -               return detect_mst_link_for_all_connectors(adev->ddev);
> +               return detect_mst_link_for_all_connectors(ADEV_TO_DRM(adev));
>
>         dmcu = adev->dm.dc->res_pool->dmcu;
>
> @@ -1420,7 +1420,7 @@ static int dm_late_init(void *handle)
>         if (!ret)
>                 return -EINVAL;
>
> -       return detect_mst_link_for_all_connectors(adev->ddev);
> +       return detect_mst_link_for_all_connectors(ADEV_TO_DRM(adev));
>  }
>
>  static void s3_handle_mst(struct drm_device *dev, bool suspend)
> @@ -1672,9 +1672,9 @@ static int dm_suspend(void *handle)
>         }
>
>         WARN_ON(adev->dm.cached_state);
> -       adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
> +       adev->dm.cached_state = drm_atomic_helper_suspend(ADEV_TO_DRM(adev));
>
> -       s3_handle_mst(adev->ddev, true);
> +       s3_handle_mst(ADEV_TO_DRM(adev), true);
>
>         amdgpu_dm_irq_suspend(adev);
>
> @@ -1828,7 +1828,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>  static int dm_resume(void *handle)
>  {
>         struct amdgpu_device *adev = handle;
> -       struct drm_device *ddev = adev->ddev;
> +       struct drm_device *ddev = ADEV_TO_DRM(adev);
>         struct amdgpu_display_manager *dm = &adev->dm;
>         struct amdgpu_dm_connector *aconnector;
>         struct drm_connector *connector;
> @@ -2443,7 +2443,7 @@ static void handle_hpd_rx_irq(void *param)
>
>  static void register_hpd_handlers(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct amdgpu_dm_connector *aconnector;
>         const struct dc_link *dc_link;
> @@ -2874,18 +2874,18 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>
>         adev->mode_info.mode_config_initialized = true;
>
> -       adev->ddev->mode_config.funcs = (void *)&amdgpu_dm_mode_funcs;
> -       adev->ddev->mode_config.helper_private = &amdgpu_dm_mode_config_helperfuncs;
> +       adev->ddev.mode_config.funcs = (void *)&amdgpu_dm_mode_funcs;
> +       adev->ddev.mode_config.helper_private = &amdgpu_dm_mode_config_helperfuncs;
>
> -       adev->ddev->mode_config.max_width = 16384;
> -       adev->ddev->mode_config.max_height = 16384;
> +       adev->ddev.mode_config.max_width = 16384;
> +       adev->ddev.mode_config.max_height = 16384;
>
> -       adev->ddev->mode_config.preferred_depth = 24;
> -       adev->ddev->mode_config.prefer_shadow = 1;
> +       adev->ddev.mode_config.preferred_depth = 24;
> +       adev->ddev.mode_config.prefer_shadow = 1;
>         /* indicates support for immediate flip */
> -       adev->ddev->mode_config.async_page_flip = true;
> +       adev->ddev.mode_config.async_page_flip = true;
>
> -       adev->ddev->mode_config.fb_base = adev->gmc.aper_base;
> +       adev->ddev.mode_config.fb_base = adev->gmc.aper_base;
>
>         state = kzalloc(sizeof(*state), GFP_KERNEL);
>         if (!state)
> @@ -2899,7 +2899,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>
>         dc_resource_state_copy_construct_current(adev->dm.dc, state->context);
>
> -       drm_atomic_private_obj_init(adev->ddev,
> +       drm_atomic_private_obj_init(ADEV_TO_DRM(adev),
>                                     &adev->dm.atomic_obj,
>                                     &state->base,
>                                     &dm_atomic_state_funcs);
> @@ -3064,10 +3064,10 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>         props.type = BACKLIGHT_RAW;
>
>         snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
> -                       dm->adev->ddev->primary->index);
> +                       dm->adev->ddev.primary->index);
>
>         dm->backlight_dev = backlight_device_register(bl_name,
> -                       dm->adev->ddev->dev,
> +                       dm->adev->ddev.dev,
>                         dm,
>                         &amdgpu_dm_backlight_ops,
>                         &props);
> @@ -3467,7 +3467,7 @@ static ssize_t s3_debug_store(struct device *device,
>         if (ret == 0) {
>                 if (s3_state) {
>                         dm_resume(adev);
> -                       drm_kms_helper_hotplug_event(adev->ddev);
> +                       drm_kms_helper_hotplug_event(ADEV_TO_DRM(adev));
>                 } else
>                         dm_suspend(adev);
>         }
> @@ -3594,7 +3594,7 @@ static int dm_early_init(void *handle)
>          */
>  #if defined(CONFIG_DEBUG_KERNEL_DC)
>         device_create_file(
> -               adev->ddev->dev,
> +               adev->ddev.dev,
>                 &dev_attr_s3_debug);
>  #endif
>
> @@ -6068,7 +6068,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>         num_formats = get_plane_formats(plane, plane_cap, formats,
>                                         ARRAY_SIZE(formats));
>
> -       res = drm_universal_plane_init(dm->adev->ddev, plane, possible_crtcs,
> +       res = drm_universal_plane_init(ADEV_TO_DRM(dm->adev), plane, possible_crtcs,
>                                        &dm_plane_funcs, formats, num_formats,
>                                        NULL, plane->type, NULL);
>         if (res)
> @@ -6916,7 +6916,7 @@ static void update_freesync_state_on_stream(
>         if (!new_stream->timing.h_total || !new_stream->timing.v_total)
>                 return;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         vrr_params = new_crtc_state->vrr_params;
>
>         if (surface) {
> @@ -6969,7 +6969,7 @@ static void update_freesync_state_on_stream(
>                               (int)new_crtc_state->base.vrr_enabled,
>                               (int)vrr_params.state);
>
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>  }
>
>  static void pre_update_freesync_state_on_stream(
> @@ -6992,7 +6992,7 @@ static void pre_update_freesync_state_on_stream(
>         if (!new_stream->timing.h_total || !new_stream->timing.v_total)
>                 return;
>
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         vrr_params = new_crtc_state->vrr_params;
>
>         if (new_crtc_state->vrr_supported &&
> @@ -7015,7 +7015,7 @@ static void pre_update_freesync_state_on_stream(
>                         sizeof(vrr_params.adjust)) != 0);
>
>         new_crtc_state->vrr_params = vrr_params;
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>  }
>
>  static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
> @@ -7824,7 +7824,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>          * send vblank event on all events not handled in flip and
>          * mark consumed event for drm_atomic_helper_commit_hw_done
>          */
> -       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> +       spin_lock_irqsave(&adev->ddev.event_lock, flags);
>         for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>
>                 if (new_crtc_state->event)
> @@ -7832,7 +7832,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>
>                 new_crtc_state->event = NULL;
>         }
> -       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> +       spin_unlock_irqrestore(&adev->ddev.event_lock, flags);
>
>         /* Signal HW programming completion */
>         drm_atomic_helper_commit_hw_done(state);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 3e227d384413..aae86dfdbc1e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -2214,7 +2214,7 @@ static int force_timing_sync_set(void *data, u64 val)
>
>         adev->dm.force_timing_sync = (bool)val;
>
> -       amdgpu_dm_trigger_timing_sync(adev->ddev);
> +       amdgpu_dm_trigger_timing_sync(ADEV_TO_DRM(adev));
>
>         return 0;
>  }
> @@ -2273,7 +2273,7 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
>                 .llseek = default_llseek
>         };
>
> -       struct drm_minor *minor = adev->ddev->primary;
> +       struct drm_minor *minor = adev->ddev.primary;
>         struct dentry *root = minor->debugfs_root;
>         int ret;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index cbcf504f73a5..bc99bf505cc1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -719,7 +719,7 @@ void amdgpu_dm_set_irq_funcs(struct amdgpu_device *adev)
>   */
>  void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>
> @@ -755,7 +755,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>   */
>  void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         struct drm_connector *connector;
>         struct drm_connector_list_iter iter;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 5506610b33df..8d9647535204 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -304,7 +304,7 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
>  void
>  dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
>  {
> -       struct drm_device *dev = adev->ddev;
> +       struct drm_device *dev = ADEV_TO_DRM(adev);
>         int i;
>
>         for (i = 0; i < adev->dm.display_indexes_num; i++) {
> @@ -450,7 +450,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>         aconnector->mst_mgr.cbs = &dm_mst_cbs;
>         drm_dp_mst_topology_mgr_init(
>                 &aconnector->mst_mgr,
> -               dm->adev->ddev,
> +               ADEV_TO_DRM(dm->adev),
>                 &aconnector->dm_dp_aux.aux,
>                 16,
>                 4,
> --
> 2.28.0.215.g878e727637
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
