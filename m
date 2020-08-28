Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E8C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549B420848
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PryK6w5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549B420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1F26E519;
	Fri, 28 Aug 2020 19:26:58 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52FB16E519
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:26:57 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id f7so196657wrw.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XNRNaqSg5ZUrf1+0FEqukS+rlkjmBmzlPe/MvqrZhT0=;
 b=PryK6w5DAdm4i068zgBMtC+IzFQbXnMmZSQSfbLoOOgtMSi8sIZVMDBzHmsoT5hbKb
 kNEsp6KiJIs+gAPJfqaoBRgBgaUdgxT/Ci3Ig9hIPSOI+v73Jt0pAJ0GkapoIF7PdQpU
 GpFXGNnBJ4g6+faFvM67gZ6LFj4BkvKeSnqoYoanAvoM1ai/PnvBx1kgxt2nF5GvOqAs
 DRCe2X24moCpocaHGnamnXAoZO1D4nXipGbnafQENiDs1mmIn6yZTrRSp2C2nIQAQrmw
 +C1f9Pz3rg5Xn0ynSCvhKMROIWoMto8YsvK2CCxMs485+sLHLIoRlkL0jTiqbirv2vro
 fR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XNRNaqSg5ZUrf1+0FEqukS+rlkjmBmzlPe/MvqrZhT0=;
 b=NvAuwwKAajqLe0L4D8SAjWBwI8Rv8+EnC6MDaaBFrACr4aTaHeg+ptZziLG0I7eaLO
 QJcX1yTT8okdcCsRz6vBm+plrpNLqyJXYmSpOQZEcTjcTVoBQMVj5sJ3TWPheRntK6HA
 EAsFwuOHivzZWU2KnZ1THPxG12hq6QUKczDV/D87ZwxFLJv4HegrvSF5KBO3jIOenOTX
 IFps7PrZIexg6kxhmEoGxdvAC3ouGo+8JkS+zApcX96d1SFnAuc6fZIfWuD6s1wqJAis
 TfHhCNvo3PmeGSZ9x+TfdfELuTJ+nwAKor/S38Lbhgv1kekNZSobdsbCdy/sYXyeSZKF
 QWjg==
X-Gm-Message-State: AOAM531kxd/rDalLHUTo6YLN5rexnPFgC9KhHnGGqAkqvLbyIAKRzHtO
 k6k45SWwKHeNk2fN2QTPF5mW0mfc6Q4byMuJ44FWFeuI
X-Google-Smtp-Source: ABdhPJyFPIVJ4uUi4Qtmm+M88kFPnYF6K4BQ28w7ke4JIX5/6+7kcuGQq6n1WOiNLdKJmeHQI8yb/h6VVSchTiQoXaE=
X-Received: by 2002:adf:fecc:: with SMTP id q12mr442205wrs.374.1598642815863; 
 Fri, 28 Aug 2020 12:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-3-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-3-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:26:44 -0400
Message-ID: <CADnq5_N_NjiB5XMZW8JODPtfa3_yqEpa1G896K6ZgL763LH23g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
 state
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
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some bloks might be even gated and so best is to avoid touching it.

typo: "blocks"

>
> v2: Rename in_dpc to more meaningful name
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>  8 files changed, 71 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3399242..cac51e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>         atomic_t                        throttling_logging_enabled;
>         struct ratelimit_state          throttling_logging_rs;
>         uint32_t                        ras_features;
> +       bool                            in_pci_err_recovery;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 937f8b0..e67cbf2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>         uint32_t ret;
>
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>                 return amdgpu_kiq_rreg(adev, reg);
>
> @@ -352,6 +355,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   */
>  uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         if (offset < adev->rmmio_size)
>                 return (readb(adev->rmmio + offset));
>         BUG();
> @@ -374,14 +380,21 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   */
>  void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if (offset < adev->rmmio_size)
>                 writeb(value, adev->rmmio + offset);
>         else
>                 BUG();
>  }
>
> -void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
> +void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
> +                                      uint32_t v, uint32_t acc_flags)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>
>         if ((reg * 4) < adev->rmmio_size)
> @@ -409,6 +422,9 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>                     uint32_t acc_flags)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>                 return amdgpu_kiq_wreg(adev, reg, v);
>
> @@ -423,6 +439,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>                     uint32_t acc_flags)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if (amdgpu_sriov_fullaccess(adev) &&
>                 adev->gfx.rlc.funcs &&
>                 adev->gfx.rlc.funcs->is_rlcg_access_range) {
> @@ -444,6 +463,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>   */
>  u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         if ((reg * 4) < adev->rio_mem_size)
>                 return ioread32(adev->rio_mem + (reg * 4));
>         else {
> @@ -463,6 +485,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   */
>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if ((reg * 4) < adev->rio_mem_size)
>                 iowrite32(v, adev->rio_mem + (reg * 4));
>         else {
> @@ -482,6 +507,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   */
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         if (index < adev->doorbell.num_doorbells) {
>                 return readl(adev->doorbell.ptr + index);
>         } else {
> @@ -502,6 +530,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if (index < adev->doorbell.num_doorbells) {
>                 writel(v, adev->doorbell.ptr + index);
>         } else {
> @@ -520,6 +551,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   */
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         if (index < adev->doorbell.num_doorbells) {
>                 return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>         } else {
> @@ -540,6 +574,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  {
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         if (index < adev->doorbell.num_doorbells) {
>                 atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>         } else {
> @@ -4778,7 +4815,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>
>         pci_restore_state(pdev);
>
> +       adev->in_pci_err_recovery = true;
>         r = amdgpu_device_ip_suspend(adev);
> +       adev->in_pci_err_recovery = false;
>         if (r)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d698142..8c9bacf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>         struct amdgpu_ring *ring = &kiq->ring;
>
> +       if (adev->in_pci_err_recovery)
> +               return 0;
> +
>         BUG_ON(!ring->funcs->emit_rreg);
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>
>         BUG_ON(!ring->funcs->emit_wreg);
>
> +       if (adev->in_pci_err_recovery)
> +               return;
> +
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>         amdgpu_ring_alloc(ring, 32);
>         amdgpu_ring_emit_wreg(ring, reg, v);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d6c38e2..a7771aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>         int i;
>         struct amdgpu_device *adev = psp->adev;
>
> +       if (psp->adev->in_pci_err_recovery)
> +               return 0;
> +
>         for (i = 0; i < adev->usec_timeout; i++) {
>                 val = RREG32(reg_index);
>                 if (check_changed) {
> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>         bool ras_intr = false;
>         bool skip_unsupport = false;
>
> +       if (psp->adev->in_pci_err_recovery)
> +               return 0;
> +
>         mutex_lock(&psp->mutex);
>
>         memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 4cfc786..613dac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
>                                         DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
>                                                   ATOM_CMD_TIMEOUT_SEC);
>                                         ctx->abort = true;
> +                                       dump_stack();

Leftover from debugging?



>                                 }
>                         } else {
>                                 /* jiffies wrap around we will just wait a little longer */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2db195e..ccf096c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +
> +       if (!adev->in_pci_err_recovery) {
>  #ifndef BRING_UP_DEBUG
> -       if (amdgpu_async_gfx_ring) {
> -               r = gfx_v10_0_kiq_disable_kgq(adev);
> -               if (r)
> -                       DRM_ERROR("KGQ disable failed\n");
> -       }
> +               if (amdgpu_async_gfx_ring) {
> +                       r = gfx_v10_0_kiq_disable_kgq(adev);
> +                       if (r)
> +                               DRM_ERROR("KGQ disable failed\n");
> +               }
>  #endif
> -       if (amdgpu_gfx_disable_kcq(adev))
> -               DRM_ERROR("KCQ disable failed\n");
> +               if (amdgpu_gfx_disable_kcq(adev))
> +                       DRM_ERROR("KCQ disable failed\n");
> +       }
> +

gfx9 probably needs something similar, but that can come later if we
ever validate this for older parts.

>         if (amdgpu_sriov_vf(adev)) {
>                 gfx_v10_0_cp_gfx_enable(adev, false);
>                 /* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8462b30..306461d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>  {
>         int ret = 0;
>
> +
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
>
> +
> +

Unrelated whitespaces changes.  Please drop.  With this things fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>         switch (block_type) {
>         /*
>          * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a58ea08..97aa72a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0, index = 0;
>
> +       if (smu->adev->in_pci_err_recovery)
> +               return 0;
> +
>         index = smu_cmn_to_asic_specific_index(smu,
>                                                CMN2ASIC_MAPPING_MSG,
>                                                msg);
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
