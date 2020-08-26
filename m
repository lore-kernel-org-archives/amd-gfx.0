Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED4CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28F720825
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwGdTI66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28F720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2B96E992;
	Wed, 26 Aug 2020 15:08:18 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52156E992
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 15:08:17 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y3so2156733wrl.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PYnPqPMGvVqXJ7oaU1S8r68LLmGRUDY2SSCFG8ScRfQ=;
 b=RwGdTI66kC0syfK8GDDZ2HYak6FdO412rycb7+HC9D17KvU3814MjaoSm6LhqXEVac
 k0ucBSGVgF3ImV9yPiI+b/xWvEtEF2WqdlFxW901759zO43hbB7Rhh8JjCPt6azmZGFZ
 7P2DCcw4jLl83BxZIj7jSR7APw0SGvrYm/AbnLbSG9S8tLYofUFCZWnPb0HgfS8wfEbg
 s4aAnKTMwD3JwgJiX+510vt+Us2hXirJLsg4uG6uRt+NWic7xTC5r0acmgFFfJLCLLIo
 9NoOdU4o/rRgH1Fx0FViWraPgTJeHTPu9PRj5whnEuRmoMjZ/8Lm1/APpIaloF9FifI5
 YUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PYnPqPMGvVqXJ7oaU1S8r68LLmGRUDY2SSCFG8ScRfQ=;
 b=nJhM/sYW2wlqSsclJrshtg/AGw3KAdk4qVnXu4tTRU4OK+iwNP+NlOxgasbbuYrb6q
 qCRJuKZS1Zk8YgVFb215Hrii4nkiSjyJjHabssSR9zLEl2AN5XYQxBSQHSKSnJR3FwfT
 XIogd4tOT+AxMmRyj1JtxI+22JS9IqWviWlaAgc9rnn7TQV9Vcm+oeNVAW+bA9Bk4+aw
 4Zy19GqnopS19OS+NpNI9Z9ihFekPAlAtzDa73Q4UYqQf6RztaciCQDWhX8zGMkZXJX4
 ueW07Ga/KiWabxSt9tewq09HdtHvmd1fSEcEPdRXTWZG+ZtabZR/u+UKw3wIBig8cxSU
 OWTw==
X-Gm-Message-State: AOAM530SP722auRwxUcAB0w8ojlvtnJj0AbckLCYEOW+xwVDqNhRDyLM
 5E1Mov9lzYzJhGm56U8x31FIOaU2iOLABAFA57g=
X-Google-Smtp-Source: ABdhPJx/TWYx5Cffboy3VjSw45K5xgLTgEkqnFN3wywbgs/roRdw7MUfa2aZutNo5FuFARt69GNeKj7moM4QPYGQSG0=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr16487221wrs.374.1598454496154; 
 Wed, 26 Aug 2020 08:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2020 11:08:04 -0400
Message-ID: <CADnq5_Peom5X8Lox-kPD5bANHttHd2AYqEBwdCXJd3c=ka7QXg@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 26, 2020 at 10:47 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Add DPC handlers with basic recovery functionality.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>  3 files changed, 196 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49ea9fa..3399242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -49,6 +49,8 @@
>  #include <linux/rbtree.h>
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
> +#include <linux/pci.h>
> +#include <linux/aer.h>
>
>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_bo_driver.h>
> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> +                                          pci_channel_state_t state);
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> +void amdgpu_pci_resume(struct pci_dev *pdev);
> +
> +
>  #include "amdgpu_object.h"
>
>  /* used by df_v3_6.c and amdgpu_pmu.c */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a948ed..84f8d14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   *
>   * Returns the 8 bit value from the offset specified.
>   */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> +{
> +

Unrelated whitespace changes.

>         if (offset < adev->rmmio_size)
>                 return (readb(adev->rmmio + offset));
>         BUG();
> @@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>   *
>   * Writes the value specified to the offset specified.
>   */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> +{
> +

Unrelated whitespace changes.

>         if (offset < adev->rmmio_size)
>                 writeb(value, adev->rmmio + offset);
>         else
> @@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>
>  void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>  {
> +

Unrelated whitespace changes.

>         trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>
>         if ((reg * 4) < adev->rmmio_size)
> @@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>                     uint32_t acc_flags)
>  {
> +

Unrelated whitespace changes.

>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>                 return amdgpu_kiq_wreg(adev, reg, v);
>
> @@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   */
>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>  {
> +

Unrelated whitespace changes.

>         if ((reg * 4) < adev->rio_mem_size)
>                 iowrite32(v, adev->rio_mem + (reg * 4));
>         else {
> @@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   */
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  {
> +

Unrelated whitespace changes.

>         if (index < adev->doorbell.num_doorbells) {
>                 return readl(adev->doorbell.ptr + index);
>         } else {
> @@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  {
> +

Unrelated whitespace changes.

>         if (index < adev->doorbell.num_doorbells) {
>                 writel(v, adev->doorbell.ptr + index);
>         } else {
> @@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   */
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  {
> +

Unrelated whitespace changes.

>         if (index < adev->doorbell.num_doorbells) {
>                 return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>         } else {
> @@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  {
> +

Unrelated whitespace changes.

>         if (index < adev->doorbell.num_doorbells) {
>                 atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>         } else {
> @@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>         NULL
>  };
>
> +

Unrelated whitespace changes.

>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                 }
>         }
>
> +       pci_enable_pcie_error_reporting(adev->ddev.pdev);
> +
> +
>         /* Post card if necessary */
>         if (amdgpu_device_need_post(adev)) {
>                 if (!adev->bios) {
> @@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (r)
>                 dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> +       if (pci_save_state(pdev))
> +               DRM_ERROR("Failed to save PCI state!!\n");
> +

This will break suspend.

>         return 0;
>
>  failed:
> @@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>
>         return 0;
>  }
> +
> +/**
> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
> + * @pdev: PCI device struct
> + * @state: PCI channel state
> + *
> + * Description: Called when a PCI error is detected.
> + *
> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
> + */
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +       DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
> +
> +       switch (state) {
> +       case pci_channel_io_normal:
> +               return PCI_ERS_RESULT_CAN_RECOVER;
> +       case pci_channel_io_frozen: {
> +               /* Fatal error, prepare for slot reset */
> +
> +               amdgpu_device_lock_adev(adev);
> +               return PCI_ERS_RESULT_NEED_RESET;
> +       }
> +       case pci_channel_io_perm_failure:
> +               /* Permanent error, prepare for device removal */
> +               return PCI_ERS_RESULT_DISCONNECT;
> +       }
> +       return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
> + * @pdev: pointer to PCI device
> + */
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
> +{
> +
> +       DRM_INFO("PCI error: mmio enabled callback!!\n");
> +
> +       /* TODO - dump whatever for debugging purposes */
> +
> +       /* This called only if amdgpu_pci_error_detected returns
> +        * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
> +        * works, no need to reset slot.
> +        */
> +
> +       return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/**
> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
> + * @pdev: PCI device struct
> + *
> + * Description: This routine is called by the pci error recovery
> + * code after the PCI slot has been reset, just before we
> + * should resume normal operations.
> + */
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +       int r;
> +       bool vram_lost;
> +
> +       DRM_INFO("PCI error: slot reset callback!!\n");
> +
> +       pci_restore_state(pdev);
> +
> +       r = amdgpu_device_ip_suspend(adev);
> +       if (r)
> +               goto out;
> +
> +
> +       /* post card */
> +       r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +       if (r)
> +               goto out;
> +
> +       r = amdgpu_device_ip_resume_phase1(adev);
> +       if (r)
> +               goto out;
> +
> +       vram_lost = amdgpu_device_check_vram_lost(adev);
> +       if (vram_lost) {
> +               DRM_INFO("VRAM is lost due to GPU reset!\n");
> +               amdgpu_inc_vram_lost(adev);
> +       }
> +
> +       r = amdgpu_gtt_mgr_recover(
> +               &adev->mman.bdev.man[TTM_PL_TT]);
> +       if (r)
> +               goto out;
> +
> +       r = amdgpu_device_fw_loading(adev);
> +       if (r)
> +               return r;
> +
> +       r = amdgpu_device_ip_resume_phase2(adev);
> +       if (r)
> +               goto out;
> +
> +       if (vram_lost)
> +               amdgpu_device_fill_reset_magic(adev);
> +
> +       /*
> +        * Add this ASIC as tracked as reset was already
> +        * complete successfully.
> +        */
> +       amdgpu_register_gpu_instance(adev);
> +
> +       r = amdgpu_device_ip_late_init(adev);
> +       if (r)
> +               goto out;
> +
> +       amdgpu_fbdev_set_suspend(adev, 0);
> +
> +       /* must succeed. */
> +       amdgpu_ras_resume(adev);
> +
> +
> +       amdgpu_irq_gpu_reset_resume_helper(adev);
> +       r = amdgpu_ib_ring_tests(adev);
> +       if (r)
> +               goto out;
> +
> +       r = amdgpu_device_recover_vram(adev);
> +
> +out:
> +
> +       if (!r)
> +               DRM_INFO("PCIe error recovery succeeded\n");
> +       else {
> +               DRM_ERROR("PCIe error recovery failed, err:%d", r);
> +               amdgpu_device_unlock_adev(adev);
> +       }
> +
> +       return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/**
> + * amdgpu_pci_resume() - resume normal ops after PCI reset
> + * @pdev: pointer to PCI device
> + *
> + * Called when the error recovery driver tells us that its
> + * OK to resume normal operation. Use completion to allow
> + * halted scsi ops to resume.
> + */
> +void amdgpu_pci_resume(struct pci_dev *pdev)
> +{
> +       struct drm_device *dev = pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +       amdgpu_device_unlock_adev(adev);
> +
> +       DRM_INFO("PCI error: resume callback!!\n");
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d984c6a..4bbcc70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -31,7 +31,6 @@
>  #include <drm/drm_pciids.h>
>  #include <linux/console.h>
>  #include <linux/module.h>
> -#include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
>  #include <drm/drm_probe_helper.h>
> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
>         .patchlevel = KMS_DRIVER_PATCHLEVEL,
>  };
>
> +static struct pci_error_handlers amdgpu_pci_err_handler = {
> +       .error_detected = amdgpu_pci_error_detected,
> +       .mmio_enabled   = amdgpu_pci_mmio_enabled,
> +       .slot_reset     = amdgpu_pci_slot_reset,
> +       .resume         = amdgpu_pci_resume,
> +};
> +
>  static struct pci_driver amdgpu_kms_pci_driver = {
>         .name = DRIVER_NAME,
>         .id_table = pciidlist,
> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>         .remove = amdgpu_pci_remove,
>         .shutdown = amdgpu_pci_shutdown,
>         .driver.pm = &amdgpu_pm_ops,
> +       .err_handler = &amdgpu_pci_err_handler,
>  };
>
>  static int __init amdgpu_init(void)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
