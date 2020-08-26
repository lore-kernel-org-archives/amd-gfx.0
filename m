Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C1C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01C42078A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpQth1GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01C42078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B996E992;
	Wed, 26 Aug 2020 15:09:45 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A176EA5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 15:09:44 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 2so2147358wrj.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kCWzu+UhwY+RPijmcJ2m1VPYXKd7OYBZpb8+6+oBbBc=;
 b=kpQth1GWJvMS/ZrA5J94eBoKpTLVfbp9/hBa4TQc9fyyVtbV3izMiVBZYmueJZkivX
 TrZ9mLQnyRJXv4PZjm2J4zfliiKLbx0ZSBYDz497m/oZccNI2ZtGgP4WEzMGGX1lYT9A
 E1Kf26YcxM1A8c94FBO5GCOTGTRGVZKdgPnycUaRFXL+KlHkrEpKz90x+N8MikVgzte+
 0xchuFLldenHap9UffU7cLItZiPqSB19XduVVgzoUncX7YMJlAKy/pqfgWLaky229vUC
 WzZywf37n9OBb2vjrdaSc1l6SSgIOuPjLvkrfVzEpom5spyh/BQKeks2lxbMGV7DMxGZ
 BUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kCWzu+UhwY+RPijmcJ2m1VPYXKd7OYBZpb8+6+oBbBc=;
 b=M3fpkJCSeeprdo3DzI6j9wq9WreVsdZh0/mrnv1OR7TKXXouz83TCxBH5qx3n2g12q
 paJO7Z2cMLCsE4kD156t+jr6pw8rR5uldMoaxn5x0tSkCecfYTG+lUMZEnJxwWxCJ/OX
 PQai4gCXHGeTINv8P/UwkBfpIhk1rTTSlTOcB23+PEAg4Uyj/W2NOualx2Qiej5R7l1g
 v+QbKFiT1ehinabyqrI/BCAqfg0cRpK0XlLYm+cKH8WVUiKe3prspkRbHK/Dx3mwv4Lq
 hpk1HSf4BvbDRXVVW0KLa+xZLT1xjhWFVHeuWfHmOwNbNz/aSUclJxTE+N6eI5ApeFRO
 zsyQ==
X-Gm-Message-State: AOAM532aKJ3uDd+b2bHNazUdPvBbn8T8qBUyEliceuHnuylXpMU/Nowq
 MWvs2xjZDHapkpuGMFnwL69KUjmxRyh9iR192xrZW30pHL0=
X-Google-Smtp-Source: ABdhPJxV1cKIWLrUZ+T2bHlpxiqMYlqPgW49WJAwkG8AuY4X1J9/mvj1+45HF7b7/tCLnjdchzWIN+nOE/PGbQTpMwQ=
X-Received: by 2002:a5d:6085:: with SMTP id w5mr15698518wrt.362.1598454582657; 
 Wed, 26 Aug 2020 08:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2020 11:09:31 -0400
Message-ID: <CADnq5_PPtMQTPMY3QNc1bVoNdeF_a-2WrhW3hEN5r4h4eRGk+g@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some bloks might be even gated and so best is to avoid touching it.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>  8 files changed, 64 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3399242..3489622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>         atomic_t                        throttling_logging_enabled;
>         struct ratelimit_state          throttling_logging_rs;
>         uint32_t                        ras_features;
> +       bool                            in_dpc;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84f8d14..e1bbefd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>         uint32_t ret;
>
> +       if (adev->in_dpc)
> +               return 0;
> +
>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>                 return amdgpu_kiq_rreg(adev, reg);
>
> @@ -350,8 +353,10 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   *
>   * Returns the 8 bit value from the offset specified.
>   */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> -{
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {

Unrelated whitespace changes.

> +
> +       if (adev->in_dpc)
> +               return 0;
>
>         if (offset < adev->rmmio_size)
>                 return (readb(adev->rmmio + offset));
> @@ -373,8 +378,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   *
>   * Writes the value specified to the offset specified.
>   */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> -{
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {

Unrelated whitespace changes.

> +
> +       if (adev->in_dpc)
> +               return;
>
>         if (offset < adev->rmmio_size)
>                 writeb(value, adev->rmmio + offset);
> @@ -384,6 +391,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>
>  void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>  {
> +       if (adev->in_dpc)
> +               return;
>
>         trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>
> @@ -412,6 +421,8 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>                     uint32_t acc_flags)
>  {
> +       if (adev->in_dpc)
> +               return;
>
>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>                 return amdgpu_kiq_wreg(adev, reg, v);
> @@ -427,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>                     uint32_t acc_flags)
>  {
> +       if (adev->in_dpc)
> +               return;
> +
>         if (amdgpu_sriov_fullaccess(adev) &&
>                 adev->gfx.rlc.funcs &&
>                 adev->gfx.rlc.funcs->is_rlcg_access_range) {
> @@ -448,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>   */
>  u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>  {
> +       if (adev->in_dpc)
> +               return 0;
> +
>         if ((reg * 4) < adev->rio_mem_size)
>                 return ioread32(adev->rio_mem + (reg * 4));
>         else {
> @@ -467,6 +484,8 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   */
>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>  {
> +       if (adev->in_dpc)
> +               return;
>
>         if ((reg * 4) < adev->rio_mem_size)
>                 iowrite32(v, adev->rio_mem + (reg * 4));
> @@ -487,6 +506,8 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   */
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  {
> +       if (adev->in_dpc)
> +               return 0;
>
>         if (index < adev->doorbell.num_doorbells) {
>                 return readl(adev->doorbell.ptr + index);
> @@ -508,6 +529,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  {
> +       if (adev->in_dpc)
> +               return;
>
>         if (index < adev->doorbell.num_doorbells) {
>                 writel(v, adev->doorbell.ptr + index);
> @@ -527,6 +550,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   */
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  {
> +       if (adev->in_dpc)
> +               return 0;
>
>         if (index < adev->doorbell.num_doorbells) {
>                 return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> @@ -548,6 +573,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  {
> +       if (adev->in_dpc)
> +                       return;
>
>         if (index < adev->doorbell.num_doorbells) {
>                 atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> @@ -4790,7 +4817,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>
>         pci_restore_state(pdev);
>
> +       adev->in_dpc = true;
>         r = amdgpu_device_ip_suspend(adev);
> +       adev->in_dpc = false;
>         if (r)
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d698142..50c42c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>         struct amdgpu_ring *ring = &kiq->ring;
>
> +       if (adev->in_dpc)
> +               return 0;
> +
>         BUG_ON(!ring->funcs->emit_rreg);
>
>         spin_lock_irqsave(&kiq->ring_lock, flags);
> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>
>         BUG_ON(!ring->funcs->emit_wreg);
>
> +       if (adev->in_dpc)
> +               return;
> +
>         spin_lock_irqsave(&kiq->ring_lock, flags);
>         amdgpu_ring_alloc(ring, 32);
>         amdgpu_ring_emit_wreg(ring, reg, v);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d6c38e2..555ef59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>         int i;
>         struct amdgpu_device *adev = psp->adev;
>
> +       if (psp->adev->in_dpc)
> +               return 0;
> +
>         for (i = 0; i < adev->usec_timeout; i++) {
>                 val = RREG32(reg_index);
>                 if (check_changed) {
> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>         bool ras_intr = false;
>         bool skip_unsupport = false;
>
> +       if (psp->adev->in_dpc)
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

Leftover from debug?

>                                 }
>                         } else {
>                                 /* jiffies wrap around we will just wait a little longer */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2db195e..86f268e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +
> +       if (!adev->in_dpc) {
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

Unrelated whitespace changes.

>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
>
> +
> +

Unrelated whitespace changes.

>         switch (block_type) {
>         /*
>          * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a58ea08..02cf55e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>         struct amdgpu_device *adev = smu->adev;
>         int ret = 0, index = 0;
>
> +       if (smu->adev->in_dpc)
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
