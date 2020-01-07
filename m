Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF55C33C8C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E694208C4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cehKtfBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E694208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04A06E10F;
	Tue,  7 Jan 2020 16:49:27 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4E86E10F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 16:49:26 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id b6so198173wrq.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gZ1bdxlrB4mUttnWEU5C4Teo+YCKYGXmRijcdVd5jTk=;
 b=cehKtfBNB/AiDKK7gBw3/d33nXIKWA7CKlL3NqBZBQNHJq7OR10dqRMqu3Dd3fUAAp
 2zdjaK9LlqNAFL6v1uF6OX9840r2VVGUi/9UsAe1BNn+k0uuGBb3qLRfLpzUtKwTCW5O
 kmhFLgOwxgQk9ZFOgsr13Del470nQrYlOt2bG7+K51QWU08NVRo3Dl2PSMS6iCqcYJsK
 64zDeUDP+eiYH589mcj+nrXEsHs5NAbgI68kfpXyobtr97euD6HbWYI7xvpZQpbFGodG
 SoLmD53K2rS/kvQjtkm7AcGmdMlOrIISQpDWWFu9s/glhcDDuW/Qr7vXZtE4MjSvXlMC
 LV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gZ1bdxlrB4mUttnWEU5C4Teo+YCKYGXmRijcdVd5jTk=;
 b=SU8UCyuhxH/IgtHP++DziI/VQM2ft3+Dq9Xgii4JXyqrl1saTboh5ipxtwC3epTj+/
 vzczX+o0wLsuUNEuOKyWO5BdU8MFeTRpQuiFiyJJvnlC1Yj12VZkwBhXLC/MEfqSCZs0
 EDFBQ980cA2YcPGr65wEAO0u0mXKOACp3PARokG5pqWeTUpBxo1tWZc7QNX/gHIWn29e
 nzEzCHI6iqEpxDiYL4Kcl3dhsIjRFtQefq664Vof289jedmt/IRLUhrF0YJ0hh3+rdkY
 P6ClihzQagLr0oTwYue65k0d6hH23h2kp6Il/TGMR5EfocaN367PsT1Z+2bt0zPFLO0V
 OpZg==
X-Gm-Message-State: APjAAAXmlJ6YynHfeGaciS7UZSctgYpOie74wu72HpJUA8iCE2QPHFrT
 0VllgoaT/cci9Vt5/II7ohV9PBGxWgbgvDOw5pA=
X-Google-Smtp-Source: APXvYqxrJ5cSLSaMr8gvl4Q/d4hMprbDLgXX/dwwxusXJm4iowrMaNNu5YHc6rUd2a+mMwLCKDEyHxmeE6EdzrFKymg=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr12425wrn.50.1578415764894;
 Tue, 07 Jan 2020 08:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200107094812.29886-1-evan.quan@amd.com>
In-Reply-To: <20200107094812.29886-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jan 2020 11:49:12 -0500
Message-ID: <CADnq5_NRwxVr+p7MY86ttKLutnpNRmb+1po5+RU0A3Jiin_vaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: cover the powerplay implementation
 details
To: Evan Quan <evan.quan@amd.com>
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

On Tue, Jan 7, 2020 at 4:48 AM Evan Quan <evan.quan@amd.com> wrote:
>
> This can save users much troubles. As they do not
> actually need to care whether swSMU or traditional
> powerplay routine should be used.
>
> Change-Id: I827fe4cac0d4fd487782168a7fe73e15756a7109
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  53 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c    | 158 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h    |  24 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |   8 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  83 ++---------

Nice cleanup.  You can clean up baco and reset support in vi.c and
cik.c as well similar to what you did in soc15.c  With that included,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>  8 files changed, 203 insertions(+), 149 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d3da9dde4ee1..88e10b956413 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -613,15 +613,9 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>
> -       if (is_support_sw_smu(adev))
> -               smu_switch_power_profile(&adev->smu,
> -                                        PP_SMC_POWER_PROFILE_COMPUTE,
> -                                        !idle);
> -       else if (adev->powerplay.pp_funcs &&
> -                adev->powerplay.pp_funcs->switch_power_profile)
> -               amdgpu_dpm_switch_power_profile(adev,
> -                                               PP_SMC_POWER_PROFILE_COMPUTE,
> -                                               !idle);
> +       amdgpu_dpm_switch_power_profile(adev,
> +                                       PP_SMC_POWER_PROFILE_COMPUTE,
> +                                       !idle);
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 09271127dfe1..bf892143e1d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2351,14 +2351,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                 adev->ip_blocks[i].status.hw = false;
>                 /* handle putting the SMC in the appropriate state */
>                 if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
> -                       if (is_support_sw_smu(adev)) {
> -                               r = smu_set_mp1_state(&adev->smu, adev->mp1_state);
> -                       } else if (adev->powerplay.pp_funcs &&
> -                                          adev->powerplay.pp_funcs->set_mp1_state) {
> -                               r = adev->powerplay.pp_funcs->set_mp1_state(
> -                                       adev->powerplay.pp_handle,
> -                                       adev->mp1_state);
> -                       }
> +                       r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
>                         if (r) {
>                                 DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
>                                           adev->mp1_state, r);
> @@ -4365,55 +4358,21 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>         if (ras && ras->supported)
>                 adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
>
> -       if (is_support_sw_smu(adev)) {
> -               struct smu_context *smu = &adev->smu;
> -               int ret;
> -
> -               ret = smu_baco_enter(smu);
> -               if (ret)
> -                       return ret;
> -       } else {
> -               void *pp_handle = adev->powerplay.pp_handle;
> -               const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -               if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
> -                       return -ENOENT;
> -
> -               /* enter BACO state */
> -               if (pp_funcs->set_asic_baco_state(pp_handle, 1))
> -                       return -EIO;
> -       }
> -
> -       return 0;
> +       return amdgpu_dpm_baco_enter(adev);
>  }
>
>  int amdgpu_device_baco_exit(struct drm_device *dev)
>  {
>         struct amdgpu_device *adev = dev->dev_private;
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +       int ret = 0;
>
>         if (!amdgpu_device_supports_baco(adev->ddev))
>                 return -ENOTSUPP;
>
> -       if (is_support_sw_smu(adev)) {
> -               struct smu_context *smu = &adev->smu;
> -               int ret;
> -
> -               ret = smu_baco_exit(smu);
> -               if (ret)
> -                       return ret;
> -
> -       } else {
> -               void *pp_handle = adev->powerplay.pp_handle;
> -               const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -               if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
> -                       return -ENOENT;
> -
> -               /* exit BACO state */
> -               if (pp_funcs->set_asic_baco_state(pp_handle, 0))
> -                       return -EIO;
> -       }
> +       ret = amdgpu_dpm_baco_exit(adev);
> +       if (ret)
> +               return ret;
>
>         if (ras && ras->supported)
>                 adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> index cd76fbf4385d..39fc39531cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> @@ -983,3 +983,161 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>
>         return ret;
>  }
> +
> +int amdgpu_dpm_baco_enter(struct amdgpu_device *adev)
> +{
> +       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +       void *pp_handle = adev->powerplay.pp_handle;
> +       struct smu_context *smu = &adev->smu;
> +       int ret = 0;
> +
> +       if (is_support_sw_smu(adev)) {
> +               ret = smu_baco_enter(smu);
> +       } else {
> +               if (!pp_funcs || !pp_funcs->set_asic_baco_state)
> +                       return -ENOENT;
> +
> +               /* enter BACO state */
> +               ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
> +       }
> +
> +       return ret;
> +}
> +
> +int amdgpu_dpm_baco_exit(struct amdgpu_device *adev)
> +{
> +       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +       void *pp_handle = adev->powerplay.pp_handle;
> +       struct smu_context *smu = &adev->smu;
> +       int ret = 0;
> +
> +       if (is_support_sw_smu(adev)) {
> +               ret = smu_baco_exit(smu);
> +       } else {
> +               if (!pp_funcs || !pp_funcs->set_asic_baco_state)
> +                       return -ENOENT;
> +
> +               /* exit BACO state */
> +               ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
> +       }
> +
> +       return ret;
> +}
> +
> +int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
> +                            enum pp_mp1_state mp1_state)
> +{
> +       int ret = 0;
> +
> +       if (is_support_sw_smu(adev)) {
> +               ret = smu_set_mp1_state(&adev->smu, mp1_state);
> +       } else if (adev->powerplay.pp_funcs &&
> +                  adev->powerplay.pp_funcs->set_mp1_state) {
> +               ret = adev->powerplay.pp_funcs->set_mp1_state(
> +                               adev->powerplay.pp_handle,
> +                               mp1_state);
> +       }
> +
> +       return ret;
> +}
> +
> +bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
> +{
> +       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +       void *pp_handle = adev->powerplay.pp_handle;
> +       struct smu_context *smu = &adev->smu;
> +       bool baco_cap;
> +
> +       if (is_support_sw_smu(adev)) {
> +               return smu_baco_is_support(smu);
> +       } else {
> +               if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
> +                       return false;
> +
> +               if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
> +                       return false;
> +
> +               return baco_cap ? true : false;
> +       }
> +}
> +
> +int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
> +{
> +       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +       void *pp_handle = adev->powerplay.pp_handle;
> +       struct smu_context *smu = &adev->smu;
> +
> +       if (is_support_sw_smu(adev)) {
> +               return smu_mode2_reset(smu);
> +       } else {
> +               if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
> +                       return -ENOENT;
> +
> +               return pp_funcs->asic_reset_mode_2(pp_handle);
> +       }
> +}
> +
> +int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
> +{
> +       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +       void *pp_handle = adev->powerplay.pp_handle;
> +       struct smu_context *smu = &adev->smu;
> +       int ret = 0;
> +
> +       if (is_support_sw_smu(adev)) {
> +               ret = smu_baco_enter(smu);
> +               if (ret)
> +                       return ret;
> +
> +               ret = smu_baco_exit(smu);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               if (!pp_funcs
> +                   || !pp_funcs->get_asic_baco_state
> +                   || !pp_funcs->set_asic_baco_state)
> +                       return -ENOENT;
> +
> +               /* enter BACO state */
> +               ret = pp_funcs->set_asic_baco_state(pp_handle, 1);
> +               if (ret)
> +                       return ret;
> +
> +               /* exit BACO state */
> +               ret = pp_funcs->set_asic_baco_state(pp_handle, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
> +                                   enum PP_SMC_POWER_PROFILE type,
> +                                   bool en)
> +{
> +       int ret = 0;
> +
> +       if (is_support_sw_smu(adev))
> +               ret = smu_switch_power_profile(&adev->smu, type, en);
> +       else if (adev->powerplay.pp_funcs &&
> +                adev->powerplay.pp_funcs->switch_power_profile)
> +               ret = adev->powerplay.pp_funcs->switch_power_profile(adev, type, en);
> +
> +       return ret;
> +}
> +
> +int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
> +                              uint32_t pstate)
> +{
> +       int ret = 0;
> +
> +       if (is_support_sw_smu_xgmi(adev))
> +               ret = smu_set_xgmi_pstate(&adev->smu, pstate);
> +       else if (adev->powerplay.pp_funcs &&
> +                adev->powerplay.pp_funcs->set_xgmi_pstate)
> +               ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
> +                                                               pstate);
> +
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> index 2cfb677272af..902ca6c00cca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> @@ -341,10 +341,6 @@ enum amdgpu_pcie_gen {
>                 ((adev)->powerplay.pp_funcs->reset_power_profile_state(\
>                         (adev)->powerplay.pp_handle, request))
>
> -#define amdgpu_dpm_switch_power_profile(adev, type, en) \
> -               ((adev)->powerplay.pp_funcs->switch_power_profile(\
> -                       (adev)->powerplay.pp_handle, type, en))
> -
>  #define amdgpu_dpm_set_clockgating_by_smu(adev, msg_id) \
>                 ((adev)->powerplay.pp_funcs->set_clockgating_by_smu(\
>                         (adev)->powerplay.pp_handle, msg_id))
> @@ -517,4 +513,24 @@ extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
>
>  extern int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low);
>
> +int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
> +                              uint32_t pstate);
> +
> +int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
> +                                   enum PP_SMC_POWER_PROFILE type,
> +                                   bool en);
> +
> +int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
> +
> +int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
> +
> +bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
> +
> +int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
> +                            enum pp_mp1_state mp1_state);
> +
> +int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
> +
> +int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index db7b2b3f9966..b88b8b82bb64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -543,12 +543,6 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                 return;
>
> -       if (!is_support_sw_smu(adev) &&
> -           (!adev->powerplay.pp_funcs ||
> -            !adev->powerplay.pp_funcs->set_powergating_by_smu))
> -               return;
> -
> -
>         mutex_lock(&adev->gfx.gfx_off_mutex);
>
>         if (!enable)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 5cf920d9358b..c626f3e59ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -291,13 +291,7 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
>
>         dev_dbg(adev->dev, "Set xgmi pstate %d.\n", pstate);
>
> -       if (is_support_sw_smu_xgmi(adev))
> -               ret = smu_set_xgmi_pstate(&adev->smu, pstate);
> -       else if (adev->powerplay.pp_funcs &&
> -                adev->powerplay.pp_funcs->set_xgmi_pstate)
> -               ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
> -                                                               pstate);
> -
> +       ret = amdgpu_dpm_set_xgmi_pstate(adev, pstate);
>         if (ret) {
>                 dev_err(adev->dev,
>                         "XGMI: Set pstate failure on device %llx, hive %llx, ret %d",
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index b0229543e887..42ede3aa6dbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -478,7 +478,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
> -                   is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
> +                   !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
> @@ -489,7 +489,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
> -                   is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
> +                   !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> @@ -502,7 +502,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>                 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
> -                   is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
> +                   !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
> @@ -513,7 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
> -                   is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
> +                   !amdgpu_sriov_vf(adev))
>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 714cf4dfd0a7..decfcce1a267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -479,29 +479,10 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
>         return ret;
>  }
>
> -static int soc15_asic_get_baco_capability(struct amdgpu_device *adev, bool *cap)
> -{
> -       if (is_support_sw_smu(adev)) {
> -               struct smu_context *smu = &adev->smu;
> -
> -               *cap = smu_baco_is_support(smu);
> -               return 0;
> -       } else {
> -               void *pp_handle = adev->powerplay.pp_handle;
> -               const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -               if (!pp_funcs || !pp_funcs->get_asic_baco_capability) {
> -                       *cap = false;
> -                       return -ENOENT;
> -               }
> -
> -               return pp_funcs->get_asic_baco_capability(pp_handle, cap);
> -       }
> -}
> -
>  static int soc15_asic_baco_reset(struct amdgpu_device *adev)
>  {
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +       int ret = 0;
>
>         /* avoid NBIF got stuck when do RAS recovery in BACO reset */
>         if (ras && ras->supported)
> @@ -509,32 +490,9 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
>
>         dev_info(adev->dev, "GPU BACO reset\n");
>
> -       if (is_support_sw_smu(adev)) {
> -               struct smu_context *smu = &adev->smu;
> -               int ret;
> -
> -               ret = smu_baco_enter(smu);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_baco_exit(smu);
> -               if (ret)
> -                       return ret;
> -       } else {
> -               void *pp_handle = adev->powerplay.pp_handle;
> -               const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -               if (!pp_funcs ||!pp_funcs->get_asic_baco_state ||!pp_funcs->set_asic_baco_state)
> -                       return -ENOENT;
> -
> -               /* enter BACO state */
> -               if (pp_funcs->set_asic_baco_state(pp_handle, 1))
> -                       return -EIO;
> -
> -               /* exit BACO state */
> -               if (pp_funcs->set_asic_baco_state(pp_handle, 0))
> -                       return -EIO;
> -       }
> +       ret = amdgpu_dpm_baco_reset(adev);
> +       if (ret)
> +               return ret;
>
>         /* re-enable doorbell interrupt after BACO exit */
>         if (ras && ras->supported)
> @@ -543,17 +501,6 @@ static int soc15_asic_baco_reset(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -static int soc15_mode2_reset(struct amdgpu_device *adev)
> -{
> -       if (is_support_sw_smu(adev))
> -               return smu_mode2_reset(&adev->smu);
> -       if (!adev->powerplay.pp_funcs ||
> -           !adev->powerplay.pp_funcs->asic_reset_mode_2)
> -               return -ENOENT;
> -
> -       return adev->powerplay.pp_funcs->asic_reset_mode_2(adev->powerplay.pp_handle);
> -}
> -
>  static enum amd_reset_method
>  soc15_asic_reset_method(struct amdgpu_device *adev)
>  {
> @@ -567,11 +514,11 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_ARCTURUS:
> -               soc15_asic_get_baco_capability(adev, &baco_reset);
> +               baco_reset = amdgpu_dpm_is_baco_supported(adev);
>                 break;
>         case CHIP_VEGA20:
>                 if (adev->psp.sos_fw_version >= 0x80067)
> -                       soc15_asic_get_baco_capability(adev, &baco_reset);
> +                       baco_reset = amdgpu_dpm_is_baco_supported(adev);
>
>                 /*
>                  * 1. PMFW version > 0x284300: all cases use baco
> @@ -598,7 +545,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>                                 amdgpu_inc_vram_lost(adev);
>                         return soc15_asic_baco_reset(adev);
>                 case AMD_RESET_METHOD_MODE2:
> -                       return soc15_mode2_reset(adev);
> +                       return amdgpu_dpm_mode2_reset(adev);
>                 default:
>                         if (!adev->in_suspend)
>                                 amdgpu_inc_vram_lost(adev);
> @@ -608,25 +555,18 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>
>  static bool soc15_supports_baco(struct amdgpu_device *adev)
>  {
> -       bool baco_support;
> -
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_ARCTURUS:
> -               soc15_asic_get_baco_capability(adev, &baco_support);
> -               break;
> +               return amdgpu_dpm_is_baco_supported(adev);
>         case CHIP_VEGA20:
>                 if (adev->psp.sos_fw_version >= 0x80067)
> -                       soc15_asic_get_baco_capability(adev, &baco_support);
> -               else
> -                       baco_support = false;
> -               break;
> +                       return amdgpu_dpm_is_baco_supported(adev);
> +               return false;
>         default:
>                 return false;
>         }
> -
> -       return baco_support;
>  }
>
>  /*static int soc15_set_uvd_clock(struct amdgpu_device *adev, u32 clock,
> @@ -846,8 +786,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>                 if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
>                         amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
> -               if (is_support_sw_smu(adev))
> -                       amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> +               amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
>                 amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
