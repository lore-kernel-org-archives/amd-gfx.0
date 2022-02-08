Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFB9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 18:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044DE10E56A;
	Tue,  8 Feb 2022 18:24:40 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4DC10E56A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 18:24:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 805F0B81BBA;
 Tue,  8 Feb 2022 18:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B6CC004E1;
 Tue,  8 Feb 2022 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644344673;
 bh=bm45v39iV2EmjAdyB2nTZyORQmoZuzjzbjGbbp/wSP0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OluGTlDMWSGW8VjXyrwOhEoRNvPb+KGLllqQFkTsZ9spp5+YmY2Zq2zv8U63DuNJM
 L6nDLZMvlvAZbQ3xg264EbhvZapgHQJyg6uDuKqy7Ja9WqvMzYz+iAvOWkBiPXTyXH
 OZ4/xVu04nLIPrJdAgTXcVi5/ATX5fHj2nmahO+70X3QOCNFjq+aUGR+LamoUB5cGG
 XzSrSJrCnv96dmdAaxOMw2TEhO4Zz0YHHfTNYx71fLb9334UT1IKztQfau4/SDl1g3
 KFjeTr8PKpMgbf8NyhoU6GZTjYd/CYccwxHpOtGJcWyZO5yzn1nND13lPKJ9E7oLJW
 OoumbxXTl5ZEw==
Date: Tue, 8 Feb 2022 11:24:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Evan Quan <evan.quan@amd.com>
Subject: Re: [PATCH V3 4/7] drm/amd/pm: correct the usage for 'supported'
 member of smu_feature structure
Message-ID: <YgK1Xetw4YVcUJ+n@dev-arch.archlinux-ax161>
References: <20220128070455.202014-1-evan.quan@amd.com>
 <20220128070455.202014-4-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128070455.202014-4-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Evan,

On Fri, Jan 28, 2022 at 03:04:52PM +0800, Evan Quan wrote:
> The supported features should be retrieved just after EnableAllDpmFeatures message
> complete. And the check(whether some dpm feature is supported) is only needed when we
> decide to enable or disable it.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 11 +++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c       |  8 ++++----
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c        |  3 ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c      |  5 +----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c        |  3 ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
>  7 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ae48cc5aa567..803068cb5079 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1057,8 +1057,10 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
>  
>  static int smu_smc_hw_setup(struct smu_context *smu)
>  {
> +	struct smu_feature *feature = &smu->smu_feature;
>  	struct amdgpu_device *adev = smu->adev;
>  	uint32_t pcie_gen = 0, pcie_width = 0;
> +	uint64_t features_supported;
>  	int ret = 0;
>  
>  	if (adev->in_suspend && smu_is_dpm_running(smu)) {
> @@ -1138,6 +1140,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		return ret;
>  	}
>  
> +	ret = smu_feature_get_enabled_mask(smu, &features_supported);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
> +		return ret;
> +	}
> +	bitmap_copy(feature->supported,
> +		    (unsigned long *)&features_supported,
> +		    feature->feature_num);
> +
>  	if (!smu_is_dpm_running(smu))
>  		dev_info(adev->dev, "dpm has been disabled\n");
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 84cbde3f913d..f55ead5f9aba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1624,8 +1624,8 @@ static int navi10_display_config_changed(struct smu_context *smu)
>  	int ret = 0;
>  
>  	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
>  		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
>  						  smu->display_config->num_display,
>  						  NULL);
> @@ -1860,13 +1860,13 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
>  	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
>  	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
>  
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>  		clock_req.clock_type = amd_pp_dcef_clock;
>  		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>  
>  		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
>  		if (!ret) {
> -			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
> +			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
>  				ret = smu_cmn_send_smc_msg_with_param(smu,
>  								  SMU_MSG_SetMinDeepSleepDcefclk,
>  								  min_clocks.dcef_clock_in_sr/100,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b6759f8b5167..804e1c98238d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1280,8 +1280,8 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
>  	int ret = 0;
>  
>  	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> -	    smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
> +	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
>  #if 0
>  		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
>  						  smu->display_config->num_display,
> @@ -1517,13 +1517,13 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
>  	min_clocks.dcef_clock_in_sr = smu->display_config->min_dcef_deep_sleep_set_clk;
>  	min_clocks.memory_clock = smu->display_config->min_mem_set_clock;
>  
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>  		clock_req.clock_type = amd_pp_dcef_clock;
>  		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>  
>  		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
>  		if (!ret) {
> -			if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
> +			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
>  				ret = smu_cmn_send_smc_msg_with_param(smu,
>  								  SMU_MSG_SetMinDeepSleepDcefclk,
>  								  min_clocks.dcef_clock_in_sr/100,
> @@ -3785,7 +3785,7 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
>  	int ret = 0;
>  
>  
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>  		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>  		if (ret)
>  			return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b34d3a416939..d36b64371492 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>  		return ret;
>  
>  	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>  
>  	if (en) {
>  		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
> @@ -817,8 +816,6 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
>  
>  		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>  			    feature->feature_num);
> -		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -			    feature->feature_num);
>  	}
>  
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 65f30cdafc8f..478151e72889 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1956,7 +1956,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>  						      RLC_STATUS_OFF, NULL);
>  
>  	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>  
>  	if (!en)
>  		return ret;
> @@ -1967,8 +1966,6 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
>  
>  	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>  		    feature->feature_num);
> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -		    feature->feature_num);
>  
>  	return 0;
>  }
> @@ -1985,7 +1982,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>  		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>  
>  	/* allow message will be sent after enable message on Vangogh*/
> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>  			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>  		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
>  		if (ret) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 6b77fc4b4698..92b5c1108a2e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>  		return ret;
>  
>  	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>  
>  	if (en) {
>  		ret = smu_cmn_get_enabled_mask(smu, &feature_mask);
> @@ -783,8 +782,6 @@ int smu_v13_0_system_features_control(struct smu_context *smu,
>  
>  		bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>  			    feature->feature_num);
> -		bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -			    feature->feature_num);
>  	}
>  
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index a7aabb8079ed..d89e8a03651b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -204,7 +204,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>  		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
>  
>  	bitmap_zero(feature->enabled, feature->feature_num);
> -	bitmap_zero(feature->supported, feature->feature_num);
>  
>  	if (!en)
>  		return ret;
> @@ -215,8 +214,6 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
>  
>  	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>  		    feature->feature_num);
> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
> -		    feature->feature_num);
>  
>  	return 0;
>  }
> -- 
> 2.29.0
> 
> 

Apologies if this has been reported or fixed already, I searched the
mailing list but did not see anything.

This change as commit 7ade3ca9cdb5 ("drm/amd/pm: correct the usage for
'supported' member of smu_feature structure") causes the following
errors/stacktrace when booting on a Ryzen 3 4300G based system, which
prevents me from reaching GNOME.

[    6.125321] amdgpu 0000:0c:00.0: amdgpu: Failed to retrieve supported dpm features!
[    6.125474] amdgpu 0000:0c:00.0: amdgpu: Failed to setup smc hw!
[    6.125595] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block <smu> failed -22
[    6.125995] amdgpu 0000:0c:00.0: amdgpu: amdgpu_device_ip_init failed
[    6.126126] amdgpu 0000:0c:00.0: amdgpu: Fatal error during GPU init
[    6.160535] amdgpu: probe of 0000:0c:00.0 failed with error -22
[    6.163849] ------------[ cut here ]------------
[    6.163964] Memory manager not clean during takedown.
[    6.164119] WARNING: CPU: 3 PID: 350 at drivers/gpu/drm/drm_mm.c:995 drm_mm_takedown+0x1f/0x30 [drm]
[    6.164353] Modules linked in: hid_logitech_hidpp joydev mousedev rtw88_8821ce rtw88_8821c rtw88_pci rtw88_core vfat mac80211 fat btusb btrtl libarc4 btbcm btintel lzo_rle hp_wmi intel_rapl_msr cfg80211 sparse_keymap bluetooth amdgpu(+) platform_profile r8169 hid_logitech_dj ecdh_generic wmi_bmof realtek intel
_rapl_common mdio_devres libphy rfkill kvm_amd kvm irqbypass drm_ttm_helper crct10dif_pclmul ttm snd_hda_codec_realtek snd_hda_codec_hdmi crc32_pclmul snd_hda_codec_generic ghash_clmulni_intel gpu_sched ledtrig_audio aesni_intel i2c_algo_bit snd_hda_intel crypto_simd snd_intel_dspcfg drm_kms_helper snd_hda_codec
cryptd rapl snd_hwdep syscopyarea sysfillrect snd_hda_core sysimgblt snd_pcm pcspkr fb_sys_fops sp5100_tco snd_timer k10temp ccp cec snd i2c_piix4 soundcore tpm_crb tpm_tis wmi tpm_tis_core tpm gpio_amdpt video rng_core pinctrl_amd gpio_generic acpi_tad mac_hid acpi_cpufreq usbhid pkcs8_key_parser sg crypto_user
fuse drm zram bpf_preload ip_tables x_tables ext4
[    6.164393]  crc32c_generic crc16 mbcache jbd2 xhci_pci crc32c_intel xhci_pci_renesas
[    6.166704] CPU: 3 PID: 350 Comm: systemd-udevd Not tainted 5.16.0-rc5-debug-01621-g7ade3ca9cdb5 #1 486b1a72751606fa3f686487a0e195723dfbf5fa
[    6.167024] Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
[    6.167207] RIP: 0010:drm_mm_takedown+0x1f/0x30 [drm]
[    6.167359] Code: 48 e9 6a ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 48 8b 47 38 48 83 c7 38 48 39 f8 75 01 c3 48 c7 c7 b0 bc 3e c0 e8 cf 7e 4c c5 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00
[    6.167847] RSP: 0018:ffffaea74164f930 EFLAGS: 00010286
[    6.167984] RAX: 0000000000000000 RBX: ffff8c69c43c0000 RCX: 0000000000000027
[    6.168171] RDX: ffff8c70baae0728 RSI: 0000000000000001 RDI: ffff8c70baae0720
[    6.168359] RBP: ffff8c69c43c5d88 R08: 0000000000000000 R09: ffffaea74164f760
[    6.168544] R10: ffffaea74164f758 R11: ffff8c70de37ffe8 R12: ffff8c69c43c5d88
[    6.168729] R13: ffff8c69c43c5d70 R14: ffff8c69c43c5d88 R15: ffff8c69c13b037c
[    6.168921] FS:  00007ff533bb5a40(0000) GS:ffff8c70baac0000(0000) knlGS:0000000000000000
[    6.169138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.169278] CR2: 00007f5b37c1ef10 CR3: 0000000108910000 CR4: 0000000000350ee0
[    6.169461] Call Trace:
[    6.169531]  <TASK>
[    6.169590]  amdgpu_vram_mgr_fini+0xe0/0x150 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.170112]  amdgpu_ttm_fini+0x11d/0x190 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.170553]  amdgpu_bo_fini+0x2a/0x90 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.170986]  gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.171442]  amdgpu_device_fini_sw+0xc9/0x340 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.171845]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu f875b0375176cd72cd7df8bb01e8902f994b9ac1]
[    6.172252]  devm_drm_dev_init_release+0x3d/0x60 [drm c0bf7c2e07a173ae66922afeaf398daf07c4aa7c]
[    6.172497]  release_nodes+0x38/0xb0
[    6.172594]  devres_release_all+0x8b/0xc0
[    6.172701]  really_probe+0x100/0x3f0
[    6.172799]  __driver_probe_device+0xfe/0x180
[    6.172913]  driver_probe_device+0x1e/0x90
[    6.173056]  __driver_attach+0xc0/0x1c0
[    6.173159]  ? __device_attach_driver+0xe0/0xe0
[    6.173281]  ? __device_attach_driver+0xe0/0xe0
[    6.173403]  bus_for_each_dev+0x89/0xd0
[    6.173508]  bus_add_driver+0x149/0x1e0
[    6.173609]  driver_register+0x8f/0xe0
[    6.173709]  ? 0xffffffffc12c6000
[    6.173796]  do_one_initcall+0x57/0x220
[    6.173898]  do_init_module+0x5c/0x270
[    6.173999]  load_module+0x258a/0x2760
[    6.174102]  ? __do_sys_init_module+0x12e/0x1b0
[    6.174223]  __do_sys_init_module+0x12e/0x1b0
[    6.174344]  do_syscall_64+0x5c/0x80
[    6.174445]  ? __vm_munmap+0x92/0x120
[    6.174546]  ? syscall_exit_to_user_mode+0x23/0x40
[    6.174671]  ? do_syscall_64+0x69/0x80
[    6.174770]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    6.174902] RIP: 0033:0x7ff5345ab32e
[    6.175000] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
[    6.175477] RSP: 002b:00007ffeccdd2918 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    6.175674] RAX: ffffffffffffffda RBX: 00005646206cfdd0 RCX: 00007ff5345ab32e
[    6.175851] RDX: 00007ff5346ff32c RSI: 000000000103912e RDI: 00007ff531498010
[    6.176032] RBP: 00007ff531498010 R08: 00007ff532a7d000 R09: 0000000000000000
[    6.176215] R10: 00005646207e5400 R11: 0000000000000246 R12: 00007ff5346ff32c
[    6.176443] R13: 00005646206cb670 R14: 00005646206cfdd0 R15: 0000564620660e80
[    6.176633]  </TASK>
[    6.176694] ---[ end trace 72edbf4275a2e0d9 ]---

If there is any other information I can provide or patches I can test, I
am happy to do so.

Cheers,
Nathan
