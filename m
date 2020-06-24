Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B9C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54C020768
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUWB5/qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54C020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714E86E095;
	Wed, 24 Jun 2020 14:55:45 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E776E095
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:55:43 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 17so2834569wmo.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1vpmxn1FSKUQyNEnsqPzYcUolrUfrJMH0ceElceXIok=;
 b=WUWB5/qtA4QxCNxf7wmeBdJja7yq/6ySW9Wi536TK3G9+G4E76vTqGcF6D21gRpgWS
 CUztwemMVS7NVxOrSGsPGEnQuTKrZ5yA+bIsCULdIOM9FmDPVgNj6ck1bh1XbonctOZb
 FaiXq36aeKF0G18/SW6JvTQ6rONZMqVXy1Y9wMub9fDp8lSwtGhaM5say7FmcF8OEspf
 zmv28wX7kP2vmRvqFhsfxW2iixjPjoGm8B6U0T8sNvKEw64RssufVngDBiYArdx+YQbO
 UW751CPAZezTNJBPcQ2ecm6YJcMJG8gj7uQVqrJ9sc9xHxFcHmu8vpTzUBoI7D661RBv
 tfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1vpmxn1FSKUQyNEnsqPzYcUolrUfrJMH0ceElceXIok=;
 b=h5Gjwek2GDQ6xVKfs5QJpFxKCl5zE/mwzJP8+I7rzrOEb5ijI7M5VTO35lgur5QSU/
 PTtZzjiku7LB7v8N0yZQ1/Nh4tCHNbNQdDk/TXXTaQ54h/Ob+xdVjRGPsda4e8/StMho
 4LfmP+hDK1mm2TRKIpT0poWK93YSMXUttZuEHw9ejec2VpPNY0JjQb2XLwUjuTutF+8b
 ogly+G0kPRp4MZDNp4QaTEY6Wuw65+XKJJi6x+p1Pep3pgdt5TIySkIwHTUoA3pKbSTD
 +nmxFIO0gm8nCzdM9lQH06Esqvbxi0XEKsvhJ4wcPBd3iiNSAWyfRnun+jEAT/xntmqN
 +vMw==
X-Gm-Message-State: AOAM531t2nU26erlMUOHzxbDC1OpbSyQ1F+SPxjR2fjzfopsRXYxFy6h
 BMVdHs/vA6fRwXa3fnC2QldqOiAkqIKYwy0dfkWmRQ==
X-Google-Smtp-Source: ABdhPJwkOIKW9elxH0wX9FwvEoVab5tVLXvR+o1jMn60V32xO0UDxQifiRKwNa+TPSUWSRipIbWxbWFoCa527NOoXJA=
X-Received: by 2002:a1c:3954:: with SMTP id g81mr16612184wma.73.1593010542220; 
 Wed, 24 Jun 2020 07:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200624114948.30948-1-alex.jivin@amd.com>
In-Reply-To: <20200624114948.30948-1-alex.jivin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jun 2020 10:55:30 -0400
Message-ID: <CADnq5_PjP9gz2Ydn25v+akChapEyiKhvJ3oSwnVJ2wreHW+h3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: SI support for UVD and VCE power managment
To: Alex Jivin <alex.jivin@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 24, 2020 at 7:50 AM Alex Jivin <alex.jivin@amd.com> wrote:
>
> Port functionality from the Radeon driver to support
> UVD and VCE power management.
>
> Signed-off-by: Alex Jivin <alex.jivin@amd.com>

Please split this into three patches, one to add the set_uvd clocks
interface, one to set the set_vce clocks interface, and one to add the
power management code.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    |   9 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |  67 +++--
>  drivers/gpu/drm/amd/amdgpu/si.c        | 361 ++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c    |  19 ++
>  drivers/gpu/drm/amd/amdgpu/sid.h       |  32 +++
>  5 files changed, 462 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6c7dd0a707c9..4b5a9a259a21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1083,6 +1083,15 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>                 tmp_ |= ((val) & ~(mask));                      \
>                 WREG32_PLL(reg, tmp_);                          \
>         } while (0)
> +
> +#define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
> +       do {                                                    \
> +               u32 tmp = RREG32_SMC(_Reg);                     \
> +               tmp &= (_Mask);                                 \
> +               tmp |= ((_Val) & ~(_Mask));                     \
> +               WREG32_SMC(_Reg, tmp);                          \
> +       } while (0)
> +
>  #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
>  #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
>  #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 347b06d3c140..26c8e39a78bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -3558,21 +3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  {
>         int ret = 0;
>
> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> -       if (ret)
> -               DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> -                         enable ? "enable" : "disable", ret);
> -
> -       /* enable/disable Low Memory PState for UVD (4k videos) */
> -       if (adev->asic_type == CHIP_STONEY &&
> -               adev->uvd.decode_image_width >= WIDTH_4K) {
> -               struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +       if (adev->family == AMDGPU_FAMILY_SI) {
> +               if (enable) {
> +                       mutex_lock(&adev->pm.mutex);
> +                       adev->pm.dpm.uvd_active = true;
> +                       adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +                       mutex_unlock(&adev->pm.mutex);
> +               } else {
> +                       mutex_lock(&adev->pm.mutex);
> +                       adev->pm.dpm.uvd_active = false;
> +                       mutex_unlock(&adev->pm.mutex);
> +               }
>
> -               if (hwmgr && hwmgr->hwmgr_func &&
> -                   hwmgr->hwmgr_func->update_nbdpm_pstate)
> -                       hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> -                                                              !enable,
> -                                                              true);
> +               amdgpu_pm_compute_clocks(adev);
> +       } else {
> +               ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> +               if (ret)
> +                       DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> +                                 enable ? "enable" : "disable", ret);
> +
> +               /* enable/disable Low Memory PState for UVD (4k videos) */
> +               if (adev->asic_type == CHIP_STONEY &&
> +                       adev->uvd.decode_image_width >= WIDTH_4K) {
> +                       struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> +
> +                       if (hwmgr && hwmgr->hwmgr_func &&
> +                           hwmgr->hwmgr_func->update_nbdpm_pstate)
> +                               hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> +                                                                      !enable,
> +                                                                      true);
> +               }
>         }
>  }
>
> @@ -3580,10 +3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  {
>         int ret = 0;
>
> -       ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> -       if (ret)
> -               DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> -                         enable ? "enable" : "disable", ret);
> +       if (adev->family == AMDGPU_FAMILY_SI) {
> +               if (enable) {
> +                       mutex_lock(&adev->pm.mutex);
> +                       adev->pm.dpm.vce_active = true;
> +                       /* XXX select vce level based on ring/task */
> +                       adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +                       mutex_unlock(&adev->pm.mutex);
> +               } else {
> +                       mutex_lock(&adev->pm.mutex);
> +                       adev->pm.dpm.vce_active = false;
> +                       mutex_unlock(&adev->pm.mutex);
> +               }
> +
> +               amdgpu_pm_compute_clocks(adev);
> +       } else {
> +               ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> +               if (ret)
> +                       DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> +                                 enable ? "enable" : "disable", ret);
> +       }
>  }
>
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index cda9aa5e4b9e..471489436b49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1266,12 +1266,6 @@ static u32 si_get_xclk(struct amdgpu_device *adev)
>         return reference_clock;
>  }
>
> -//xxx:not implemented
> -static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
> -{
> -       return 0;
> -}
> -
>  static void si_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
>  {
>         if (!ring || !ring->funcs->emit_wreg) {
> @@ -1427,6 +1421,358 @@ static uint64_t si_get_pcie_replay_count(struct amdgpu_device *adev)
>         return (nak_r + nak_g);
>  }
>
> +static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
> +                                  unsigned cg_upll_func_cntl)
> +{
> +       unsigned i;
> +
> +       /* Make sure UPLL_CTLREQ is deasserted */
> +       WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
> +
> +       mdelay(10);
> +
> +       /* Assert UPLL_CTLREQ */
> +       WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
> +
> +       /* Wait for CTLACK and CTLACK2 to get asserted */
> +       for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
> +               uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
> +
> +               if ((RREG32(cg_upll_func_cntl) & mask) == mask)
> +                       break;
> +               mdelay(10);
> +       }
> +
> +       /* Deassert UPLL_CTLREQ */
> +       WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
> +
> +       if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> +               DRM_ERROR("Timeout setting UVD clocks!\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static unsigned si_uvd_calc_upll_post_div(unsigned vco_freq,
> +                                         unsigned target_freq,
> +                                         unsigned pd_min,
> +                                         unsigned pd_even)
> +{
> +       unsigned post_div = vco_freq / target_freq;
> +
> +       /* Adjust to post divider minimum value */
> +       if (post_div < pd_min)
> +               post_div = pd_min;
> +
> +       /* We alway need a frequency less than or equal the target */
> +       if ((vco_freq / post_div) > target_freq)
> +               post_div += 1;
> +
> +       /* Post dividers above a certain value must be even */
> +       if (post_div > pd_even && post_div % 2)
> +               post_div += 1;
> +
> +       return post_div;
> +}
> +
> +/**
> + * si_calc_upll_dividers - calc UPLL clock dividers
> + *
> + * @adev: amdgpu_device pointer
> + * @vclk: wanted VCLK
> + * @dclk: wanted DCLK
> + * @vco_min: minimum VCO frequency
> + * @vco_max: maximum VCO frequency
> + * @fb_factor: factor to multiply vco freq with
> + * @fb_mask: limit and bitmask for feedback divider
> + * @pd_min: post divider minimum
> + * @pd_max: post divider maximum
> + * @pd_even: post divider must be even above this value
> + * @optimal_fb_div: resulting feedback divider
> + * @optimal_vclk_div: resulting vclk post divider
> + * @optimal_dclk_div: resulting dclk post divider
> + *
> + * Calculate dividers for UVDs UPLL (except APUs).
> + * Returns zero on success; -EINVAL on error.
> + */
> +static int si_calc_upll_dividers(struct amdgpu_device *adev,
> +                                unsigned vclk, unsigned dclk,
> +                                unsigned vco_min, unsigned vco_max,
> +                                unsigned fb_factor, unsigned fb_mask,
> +                                unsigned pd_min, unsigned pd_max,
> +                                unsigned pd_even,
> +                                unsigned *optimal_fb_div,
> +                                unsigned *optimal_vclk_div,
> +                                unsigned *optimal_dclk_div)
> +{
> +       unsigned vco_freq, ref_freq = adev->clock.spll.reference_freq;
> +
> +       /* Start off with something large */
> +       unsigned optimal_score = ~0;
> +
> +       /* Loop through vco from low to high */
> +       vco_min = max(max(vco_min, vclk), dclk);
> +       for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {
> +               uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
> +               unsigned vclk_div, dclk_div, score;
> +
> +               do_div(fb_div, ref_freq);
> +
> +               /* fb div out of range ? */
> +               if (fb_div > fb_mask)
> +                       break; /* It can oly get worse */
> +
> +               fb_div &= fb_mask;
> +
> +               /* Calc vclk divider with current vco freq */
> +               vclk_div = si_uvd_calc_upll_post_div(vco_freq, vclk,
> +                                                    pd_min, pd_even);
> +               if (vclk_div > pd_max)
> +                       break; /* vco is too big, it has to stop */
> +
> +               /* Calc dclk divider with current vco freq */
> +               dclk_div = si_uvd_calc_upll_post_div(vco_freq, dclk,
> +                                                    pd_min, pd_even);
> +               if (dclk_div > pd_max)
> +                       break; /* vco is too big, it has to stop */
> +
> +               /* Calc score with current vco freq */
> +               score = vclk - (vco_freq / vclk_div) + dclk - (vco_freq / dclk_div);
> +
> +               /* Determine if this vco setting is better than current optimal settings */
> +               if (score < optimal_score) {
> +                       *optimal_fb_div = fb_div;
> +                       *optimal_vclk_div = vclk_div;
> +                       *optimal_dclk_div = dclk_div;
> +                       optimal_score = score;
> +                       if (optimal_score == 0)
> +                               break; /* It can't get better than this */
> +               }
> +       }
> +
> +       /* Did we found a valid setup ? */
> +       if (optimal_score == ~0)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
> +{
> +       unsigned fb_div = 0, vclk_div = 0, dclk_div = 0;
> +       int a;
> +
> +       /* Bypass vclk and dclk with bclk */
> +       WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +                VCLK_SRC_SEL(1) | DCLK_SRC_SEL(1),
> +                ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
> +
> +       /* Put PLL in bypass mode */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_BYPASS_EN_MASK, ~UPLL_BYPASS_EN_MASK);
> +
> +       if (!vclk || !dclk) {
> +               /* Keep the Bypass mode */
> +               return 0;
> +       }
> +
> +       a = si_calc_upll_dividers(adev, vclk, dclk, 125000, 250000,
> +                                 16384, 0x03FFFFFF, 0, 128, 5,
> +                                 &fb_div, &vclk_div, &dclk_div);
> +       if (a)
> +               return a;
> +
> +       /* Set RESET_ANTI_MUX to 0 */
> +       WREG32_P(CG_UPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
> +
> +       /* Set VCO_MODE to 1 */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_VCO_MODE_MASK, ~UPLL_VCO_MODE_MASK);
> +
> +       /* Disable sleep mode */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_SLEEP_MASK);
> +
> +       /* Deassert UPLL_RESET */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
> +
> +       mdelay(1);
> +
> +       a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
> +       if (a)
> +               return a;
> +
> +       /* Assert UPLL_RESET again */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_RESET_MASK, ~UPLL_RESET_MASK);
> +
> +       /* Disable spread spectrum. */
> +       WREG32_P(CG_UPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
> +
> +       /* Set feedback divider */
> +       WREG32_P(CG_UPLL_FUNC_CNTL_3, UPLL_FB_DIV(fb_div), ~UPLL_FB_DIV_MASK);
> +
> +       /* Set ref divider to 0 */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_REF_DIV_MASK);
> +
> +       if (fb_div < 307200)
> +               WREG32_P(CG_UPLL_FUNC_CNTL_4, 0, ~UPLL_SPARE_ISPARE9);
> +       else
> +               WREG32_P(CG_UPLL_FUNC_CNTL_4,
> +                        UPLL_SPARE_ISPARE9,
> +                        ~UPLL_SPARE_ISPARE9);
> +
> +       /* Set PDIV_A and PDIV_B */
> +       WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +                UPLL_PDIV_A(vclk_div) | UPLL_PDIV_B(dclk_div),
> +                ~(UPLL_PDIV_A_MASK | UPLL_PDIV_B_MASK));
> +
> +       /* Give the PLL some time to settle */
> +       mdelay(15);
> +
> +       /* Deassert PLL_RESET */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
> +
> +       mdelay(15);
> +
> +       /* Switch from bypass mode to normal mode */
> +       WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_BYPASS_EN_MASK);
> +
> +       a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
> +       if (a)
> +               return a;
> +
> +       /* Switch VCLK and DCLK selection */
> +       WREG32_P(CG_UPLL_FUNC_CNTL_2,
> +                VCLK_SRC_SEL(2) | DCLK_SRC_SEL(2),
> +                ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
> +
> +       mdelay(100);
> +
> +       return 0;
> +}
> +
> +static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
> +{
> +       unsigned i;
> +
> +       /* Make sure VCEPLL_CTLREQ is deasserted */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +       mdelay(10);
> +
> +       /* Assert UPLL_CTLREQ */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
> +
> +       /* Wait for CTLACK and CTLACK2 to get asserted */
> +       for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
> +               uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
> +
> +               if ((RREG32_SMC(CG_VCEPLL_FUNC_CNTL) & mask) == mask)
> +                       break;
> +               mdelay(10);
> +       }
> +
> +       /* Deassert UPLL_CTLREQ */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
> +
> +       if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
> +               DRM_ERROR("Timeout setting UVD clocks!\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 0;
> +}
> +
> +static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
> +{
> +       unsigned fb_div = 0, evclk_div = 0, ecclk_div = 0;
> +       int a;
> +
> +       /* Bypass evclk and ecclk with bclk */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +                    EVCLK_SRC_SEL(1) | ECCLK_SRC_SEL(1),
> +                    ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +       /* Put PLL in bypass mode */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_BYPASS_EN_MASK,
> +                    ~VCEPLL_BYPASS_EN_MASK);
> +
> +       if (!evclk || !ecclk) {
> +               /* Keep the Bypass mode, put PLL to sleep */
> +               WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +                            ~VCEPLL_SLEEP_MASK);
> +               return 0;
> +       }
> +
> +       a = si_calc_upll_dividers(adev, evclk, ecclk, 125000, 250000,
> +                                 16384, 0x03FFFFFF, 0, 128, 5,
> +                                 &fb_div, &evclk_div, &ecclk_div);
> +       if (a)
> +               return a;
> +
> +       /* Set RESET_ANTI_MUX to 0 */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
> +
> +       /* Set VCO_MODE to 1 */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_VCO_MODE_MASK,
> +                    ~VCEPLL_VCO_MODE_MASK);
> +
> +       /* Toggle VCEPLL_SLEEP to 1 then back to 0 */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
> +                    ~VCEPLL_SLEEP_MASK);
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_SLEEP_MASK);
> +
> +       /* Deassert VCEPLL_RESET */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +       mdelay(1);
> +
> +       a = si_vce_send_vcepll_ctlreq(adev);
> +       if (a)
> +               return a;
> +
> +       /* Assert VCEPLL_RESET again */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
> +
> +       /* Disable spread spectrum. */
> +       WREG32_SMC_P(CG_VCEPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
> +
> +       /* Set feedback divider */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_3,
> +                    VCEPLL_FB_DIV(fb_div),
> +                    ~VCEPLL_FB_DIV_MASK);
> +
> +       /* Set ref divider to 0 */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_REF_DIV_MASK);
> +
> +       /* Set PDIV_A and PDIV_B */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +                    VCEPLL_PDIV_A(evclk_div) | VCEPLL_PDIV_B(ecclk_div),
> +                    ~(VCEPLL_PDIV_A_MASK | VCEPLL_PDIV_B_MASK));
> +
> +       /* Give the PLL some time to settle */
> +       mdelay(15);
> +
> +       /* Deassert PLL_RESET */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
> +
> +       mdelay(15);
> +
> +       /* Switch from bypass mode to normal mode */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
> +
> +       a = si_vce_send_vcepll_ctlreq(adev);
> +       if (a)
> +               return a;
> +
> +       /* Switch VCLK and DCLK selection */
> +       WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
> +                    EVCLK_SRC_SEL(16) | ECCLK_SRC_SEL(16),
> +                    ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
> +
> +       mdelay(100);
> +
> +       return 0;
> +}
> +
>  static const struct amdgpu_asic_funcs si_asic_funcs =
>  {
>         .read_disabled_bios = &si_read_disabled_bios,
> @@ -1437,7 +1783,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>         .set_vga_state = &si_vga_set_state,
>         .get_xclk = &si_get_xclk,
>         .set_uvd_clocks = &si_set_uvd_clocks,
> -       .set_vce_clocks = NULL,
> +       .set_vce_clocks = &si_set_vce_clocks,
>         .get_pcie_lanes = &si_get_pcie_lanes,
>         .set_pcie_lanes = &si_set_pcie_lanes,
>         .get_config_memsize = &si_get_config_memsize,
> @@ -2228,4 +2574,3 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
>         }
>         return 0;
>  }
> -
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index c00ba4b23c9a..ea914b256ebd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -6953,6 +6953,24 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +static void si_set_vce_clock(struct amdgpu_device *adev,
> +                            struct amdgpu_ps *new_rps,
> +                            struct amdgpu_ps *old_rps)
> +{
> +       if ((old_rps->evclk != new_rps->evclk) ||
> +           (old_rps->ecclk != new_rps->ecclk)) {
> +               /* Turn the clocks on when encoding, off otherwise */
> +               if (new_rps->evclk || new_rps->ecclk) {
> +                       /* Place holder for future VCE1.0 porting to amdgpu
> +                       vce_v1_0_enable_mgcg(adev, false, false);*/
> +               } else {
> +                       /* Place holder for future VCE1.0 porting to amdgpu
> +                       vce_v1_0_enable_mgcg(adev, true, false);
> +                       amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
> +               }
> +       }
> +}
> +
>  static int si_dpm_set_power_state(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -7029,6 +7047,7 @@ static int si_dpm_set_power_state(void *handle)
>                 return ret;
>         }
>         ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
> +       si_set_vce_clock(adev, new_ps, old_ps);
>         if (eg_pi->pcie_performance_request)
>                 si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
>         ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
> index 75b5d441b628..6156a795ad6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -47,6 +47,7 @@
>  #define SI_MAX_LDS_NUM                 0xFFFF
>  #define SI_MAX_TCC                     16
>  #define SI_MAX_TCC_MASK                0xFFFF
> +#define SI_MAX_CTLACKS_ASSERTION_WAIT   100
>
>  #define AMDGPU_NUM_OF_VMIDS            8
>
> @@ -2479,4 +2480,35 @@
>
>  #define        MC_VM_FB_OFFSET                                 0x81a
>
> +/* Discrete VCE clocks */
> +#define CG_VCEPLL_FUNC_CNTL                             0xc0030600
> +#define    VCEPLL_RESET_MASK                            0x00000001
> +#define    VCEPLL_SLEEP_MASK                            0x00000002
> +#define    VCEPLL_BYPASS_EN_MASK                        0x00000004
> +#define    VCEPLL_CTLREQ_MASK                           0x00000008
> +#define    VCEPLL_VCO_MODE_MASK                         0x00000600
> +#define    VCEPLL_REF_DIV_MASK                          0x003F0000
> +#define    VCEPLL_CTLACK_MASK                           0x40000000
> +#define    VCEPLL_CTLACK2_MASK                          0x80000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_2                           0xc0030601
> +#define    VCEPLL_PDIV_A(x)                             ((x) << 0)
> +#define    VCEPLL_PDIV_A_MASK                           0x0000007F
> +#define    VCEPLL_PDIV_B(x)                             ((x) << 8)
> +#define    VCEPLL_PDIV_B_MASK                           0x00007F00
> +#define    EVCLK_SRC_SEL(x)                             ((x) << 20)
> +#define    EVCLK_SRC_SEL_MASK                           0x01F00000
> +#define    ECCLK_SRC_SEL(x)                             ((x) << 25)
> +#define    ECCLK_SRC_SEL_MASK                           0x3E000000
> +
> +#define CG_VCEPLL_FUNC_CNTL_3                           0xc0030602
> +#define    VCEPLL_FB_DIV(x)                             ((x) << 0)
> +#define    VCEPLL_FB_DIV_MASK                           0x01FFFFFF
> +
> +#define CG_VCEPLL_FUNC_CNTL_4                           0xc0030603
> +
> +#define CG_VCEPLL_FUNC_CNTL_5                           0xc0030604
> +#define CG_VCEPLL_SPREAD_SPECTRUM                       0xc0030606
> +#define    VCEPLL_SSEN_MASK                             0x00000001
> +
>  #endif
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
