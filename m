Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C08C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D8520767
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtzD3kMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D8520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F420F89994;
	Mon, 31 Aug 2020 14:31:03 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4241E89919
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:30:58 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e16so6189990wrm.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hpTuWkgXX3fHNBnA4DS19bHCjuIYMmV2ZstcLiZAYjs=;
 b=TtzD3kMJH7ub1EcU77ybQ4XqKfoZch0IYLx9Kbn88T87dLv7nBQamRok0mPI5xsugq
 WIqPuOOQV02A8iq5ojCicgJEUp3DOb+8EhB0EJL0KbXbbPMsujLzduYguhxNLdxFMNiB
 OsG7EMSn8KMhi6pmN8+G1ZoZooWJa4jjYtHYajOg0UaXC2NqjPNwm40MChCGXyowybiz
 1wUo17MYMfLNYqydZwRhhLmSmWCvJfZSvqGGlFVAhzxQYj80opwHD3cHq7SaBQ5fZJyB
 214o8B/Gq/c6X7LQtLMstl/B7GBuBmn30qgzzWs/s0zi0Cx85ggRZNc/DTMuk0vPM6Kv
 0HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hpTuWkgXX3fHNBnA4DS19bHCjuIYMmV2ZstcLiZAYjs=;
 b=d+5lCrCfx/n/xnywh6jt2zkQaNfl2J9FLnImWceQCA9s5MNW0cn6ye5a6hW5wcne89
 qe4a2DvSRaLwBLdTw4faVmOdv9EvBGhx8kLvJWrPWyKJJLvWXk2rrD5mopljQjWBx8lW
 vatVuUSYqcShE5Q/s2wyBvxnp7/z/8Fpj4QMKeV0vdNa59hlNaVRybXyLb0+F609XnyK
 fZRURLjOb5dBExDZ91cIiGIvKCjXpoZmmVNJnn24YO2BEjEDjuKRHLU56GuwP2IqplA5
 HrKJ9XO2n/kElpIQ47kOvK3sykHpioA0y/dyqOr4t3bS/YQLva3E0BvnD1woTsC2wQkZ
 OoEw==
X-Gm-Message-State: AOAM531taltCSgwwMZ0tME8PAwelPY95bPotTkBXuCQ3J7oUjvsYLdwG
 GAa2W/iGmIxJFUwKffT0r071+g47ChZMOf+/b8B8s6q0
X-Google-Smtp-Source: ABdhPJx/B720kaCaDkbcSMC44GxzoQgvxpTXK7xhdFmdc71gNPHSrBSm5e5FVD3vuGz4UFBC+wrE2QEvOiwAWnEkYbI=
X-Received: by 2002:a05:6000:110a:: with SMTP id
 z10mr2020279wrw.374.1598884256719; 
 Mon, 31 Aug 2020 07:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_PEW=4Gkm6WmcYCh2wYOdPF5pas+4pp4=EvueH8wE38dA@mail.gmail.com>
 <a1e3d48a-c92f-9701-9297-d6a9e9edddba@amd.com>
In-Reply-To: <a1e3d48a-c92f-9701-9297-d6a9e9edddba@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2020 10:30:44 -0400
Message-ID: <CADnq5_PfmYwppNq+V2Xjw7dOhHgCGLSJ1FU5YmaAQZdDoad=nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Implement DPC recovery
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
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
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 31, 2020 at 10:26 AM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
> On 8/28/20 3:23 PM, Alex Deucher wrote:
> > On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >> Add DPC handlers with basic recovery functionality.
> >>
> >> v2: remove pci_save_state to avoid breaking suspend/resume
> >>
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 169 ++++++++++++++++++++++++++++-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
> >>   3 files changed, 184 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index 49ea9fa..3399242 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -49,6 +49,8 @@
> >>   #include <linux/rbtree.h>
> >>   #include <linux/hashtable.h>
> >>   #include <linux/dma-fence.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/aer.h>
> >>
> >>   #include <drm/ttm/ttm_bo_api.h>
> >>   #include <drm/ttm/ttm_bo_driver.h>
> >> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
> >>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
> >>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
> >>
> >> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> >> +                                          pci_channel_state_t state);
> >> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> >> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> >> +void amdgpu_pci_resume(struct pci_dev *pdev);
> >> +
> >> +
> >>   #include "amdgpu_object.h"
> >>
> >>   /* used by df_v3_6.c and amdgpu_pmu.c */
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index 5a948ed..937f8b0 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -350,7 +350,8 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
> >>    *
> >>    * Returns the 8 bit value from the offset specified.
> >>    */
> >> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> >> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> >> +{
> >>          if (offset < adev->rmmio_size)
> >>                  return (readb(adev->rmmio + offset));
> >>          BUG();
> >> @@ -371,7 +372,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> >>    *
> >>    * Writes the value specified to the offset specified.
> >>    */
> >> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> >> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> >> +{
> >>          if (offset < adev->rmmio_size)
> >>                  writeb(value, adev->rmmio + offset);
> >>          else
> >> @@ -2989,6 +2991,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
> >>          NULL
> >>   };
> >>
> >> +
> >>   /**
> >>    * amdgpu_device_init - initialize the driver
> >>    *
> >> @@ -3207,6 +3210,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >>                  }
> >>          }
> >>
> >> +       pci_enable_pcie_error_reporting(adev->ddev.pdev);
> >> +
> >> +
> >>          /* Post card if necessary */
> >>          if (amdgpu_device_need_post(adev)) {
> >>                  if (!adev->bios) {
> >> @@ -4701,3 +4707,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
> >>
> >>          return 0;
> >>   }
> >> +
> >> +/**
> >> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
> >> + * @pdev: PCI device struct
> >> + * @state: PCI channel state
> >> + *
> >> + * Description: Called when a PCI error is detected.
> >> + *
> >> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
> >> + */
> >> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +
> >> +       DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
> >> +
> >> +       switch (state) {
> >> +       case pci_channel_io_normal:
> >> +               return PCI_ERS_RESULT_CAN_RECOVER;
> >> +       case pci_channel_io_frozen: {
> >> +               /* Fatal error, prepare for slot reset */
> >> +
> >> +               amdgpu_device_lock_adev(adev);
> >> +               return PCI_ERS_RESULT_NEED_RESET;
> >> +       }
> >> +       case pci_channel_io_perm_failure:
> >> +               /* Permanent error, prepare for device removal */
> >> +               return PCI_ERS_RESULT_DISCONNECT;
> >> +       }
> >> +       return PCI_ERS_RESULT_NEED_RESET;
> >> +}
> >> +
> >> +/**
> >> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
> >> + * @pdev: pointer to PCI device
> >> + */
> >> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
> >> +{
> >> +
> >> +       DRM_INFO("PCI error: mmio enabled callback!!\n");
> >> +
> >> +       /* TODO - dump whatever for debugging purposes */
> >> +
> >> +       /* This called only if amdgpu_pci_error_detected returns
> >> +        * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
> >> +        * works, no need to reset slot.
> >> +        */
> >> +
> >> +       return PCI_ERS_RESULT_RECOVERED;
> >> +}
> >> +
> >> +/**
> >> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
> >> + * @pdev: PCI device struct
> >> + *
> >> + * Description: This routine is called by the pci error recovery
> >> + * code after the PCI slot has been reset, just before we
> >> + * should resume normal operations.
> >> + */
> >> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +       int r;
> >> +       bool vram_lost;
> >> +
> >> +       DRM_INFO("PCI error: slot reset callback!!\n");
> >> +
> >> +       pci_restore_state(pdev);
> >> +
> >> +       r = amdgpu_device_ip_suspend(adev);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +
> >> +       /* post card */
> >> +       r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       r = amdgpu_device_ip_resume_phase1(adev);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       vram_lost = amdgpu_device_check_vram_lost(adev);
> >> +       if (vram_lost) {
> >> +               DRM_INFO("VRAM is lost due to GPU reset!\n");
> >> +               amdgpu_inc_vram_lost(adev);
> >> +       }
> >> +
> >> +       r = amdgpu_gtt_mgr_recover(
> >> +               &adev->mman.bdev.man[TTM_PL_TT]);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       r = amdgpu_device_fw_loading(adev);
> >> +       if (r)
> >> +               return r;
> >> +
> >> +       r = amdgpu_device_ip_resume_phase2(adev);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       if (vram_lost)
> >> +               amdgpu_device_fill_reset_magic(adev);
> >> +
> >> +       /*
> >> +        * Add this ASIC as tracked as reset was already
> >> +        * complete successfully.
> >> +        */
> >> +       amdgpu_register_gpu_instance(adev);
> >> +
> >> +       r = amdgpu_device_ip_late_init(adev);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       amdgpu_fbdev_set_suspend(adev, 0);
> >> +
> >> +       /* must succeed. */
> >> +       amdgpu_ras_resume(adev);
> >> +
> >> +
> >> +       amdgpu_irq_gpu_reset_resume_helper(adev);
> >> +       r = amdgpu_ib_ring_tests(adev);
> >> +       if (r)
> >> +               goto out;
> >> +
> >> +       r = amdgpu_device_recover_vram(adev);
> >> +
> >> +out:
> >> +
> >> +       if (!r)
> >> +               DRM_INFO("PCIe error recovery succeeded\n");
> >> +       else {
> >> +               DRM_ERROR("PCIe error recovery failed, err:%d", r);
> >> +               amdgpu_device_unlock_adev(adev);
> >> +       }
> >> +
> >> +       return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> >> +}
> >> +
> >> +/**
> >> + * amdgpu_pci_resume() - resume normal ops after PCI reset
> >> + * @pdev: pointer to PCI device
> >> + *
> >> + * Called when the error recovery driver tells us that its
> >> + * OK to resume normal operation. Use completion to allow
> >> + * halted scsi ops to resume.
> >> + */
> >> +void amdgpu_pci_resume(struct pci_dev *pdev)
> >> +{
> >> +       struct drm_device *dev = pci_get_drvdata(pdev);
> >> +       struct amdgpu_device *adev = drm_to_adev(dev);
> >> +
> >> +       amdgpu_device_unlock_adev(adev);
> >> +
> >> +       DRM_INFO("PCI error: resume callback!!\n");
> >> +}
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index d984c6a..4bbcc70 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -31,7 +31,6 @@
> >>   #include <drm/drm_pciids.h>
> >>   #include <linux/console.h>
> >>   #include <linux/module.h>
> >> -#include <linux/pci.h>
> > Is this intended?  Seems unrelated.  I think this should be part of
> > the previous patch.
> >
> > Alex
>
>
> Which previous patch (it's the first one) ?

Ignore this comment.  I mixed up the patch ordering in my head when I
was reviewing this.  See my follow up reply.

Alex

>
> Andrey
>
>
> >
> >
> >>   #include <linux/pm_runtime.h>
> >>   #include <linux/vga_switcheroo.h>
> >>   #include <drm/drm_probe_helper.h>
> >> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
> >>          .patchlevel = KMS_DRIVER_PATCHLEVEL,
> >>   };
> >>
> >> +static struct pci_error_handlers amdgpu_pci_err_handler = {
> >> +       .error_detected = amdgpu_pci_error_detected,
> >> +       .mmio_enabled   = amdgpu_pci_mmio_enabled,
> >> +       .slot_reset     = amdgpu_pci_slot_reset,
> >> +       .resume         = amdgpu_pci_resume,
> >> +};
> >> +
> >>   static struct pci_driver amdgpu_kms_pci_driver = {
> >>          .name = DRIVER_NAME,
> >>          .id_table = pciidlist,
> >> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
> >>          .remove = amdgpu_pci_remove,
> >>          .shutdown = amdgpu_pci_shutdown,
> >>          .driver.pm = &amdgpu_pm_ops,
> >> +       .err_handler = &amdgpu_pci_err_handler,
> >>   };
> >>
> >>   static int __init amdgpu_init(void)
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cc25d1302358c420604b908d84b87e5a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342394332573022&amp;sdata=MvfAEC9Vc7fwkmBvihaTxDswrRJwFhjLWoEmjQKIIPg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
