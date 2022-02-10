Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138DEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 02:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8762110E126;
	Thu, 10 Feb 2022 02:30:00 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC2A10E126
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 02:29:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 539FAB8237D;
 Thu, 10 Feb 2022 02:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28B7C340E7;
 Thu, 10 Feb 2022 02:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644460196;
 bh=P6obmLbbn9S3xwBAPYJBwuQxFf97ozNv8Mk4Fsi4ihU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gCo5k+66ioyKvqRcKzBr1a8i+eCmV7VwbTv97HScEf+wAt4oC2N53PMk6QaFKoHE/
 q1BIYRMGOIN0dQ2gwqONSGRBvYvs81Y+VLUmJsLHaEVbAp0lMP1a8w2aP6gWp3xbSa
 acVUG5c67jIdWITi5K2xAqhEVvd9Yt6djG4eYJ4P8lb9RR8gtX9ngizYYP9gsYWkKT
 GjmgJexXbxlS+NxeGd6i6PXov6r8M+hRSTcoYNSrxbLjN7PA9pR2knRwnaE/jnIBZa
 YPvhBDLy0qdY4868iLtUJH4+2MttkOfoRchdzvqsfIPqn/8S062FzD1jAjudkaxXz9
 gecb2lgvCrhBQ==
Date: Wed, 9 Feb 2022 19:29:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Evan Quan <evan.quan@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix enabled features retrieving on Renoir
 and Cyan Skillfish
Message-ID: <YgR4nzB294ZZEs9j@dev-arch.archlinux-ax161>
References: <20220210014700.856667-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210014700.856667-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Roman.Li@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 09:47:00AM +0800, Evan Quan wrote:
> For Cyan Skillfish and Renoir, there is no interface provided by PMFW
> to retrieve the enabled features. So, we assume all features are enabled.
> 
> Fixes: 7ade3ca9cdb5 ("drm/amd/pm: correct the usage for 'supported' member of smu_feature structure")
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I1231f146405a229a11aa7ac608c8c932d3c90ee4

Tested-by: Nathan Chancellor <nathan@kernel.org>

> --
> v1->v2:
>   - add back the logic for supporting those ASICs which have
>     no feature_map available
> v2->v3:
>   - update the check for smu_cmn_feature_is_enabled to use a more
>     generic way instead of asic type
> 
> Change-Id: I7dfa453ffc086f5364848f7f32decd57a5a5b0e6
> ---
>  .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 27 ++++++++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2b38a9154dd4..b3a0f3fb3e65 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -562,6 +562,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>  	.fini_smc_tables = smu_v11_0_fini_smc_tables,
>  	.read_sensor = cyan_skillfish_read_sensor,
>  	.print_clk_levels = cyan_skillfish_print_clk_levels,
> +	.get_enabled_mask = smu_cmn_get_enabled_mask,
>  	.is_dpm_running = cyan_skillfish_is_dpm_running,
>  	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>  	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 2a6b752a6996..4c12abcd995d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -500,7 +500,17 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
>  	uint64_t enabled_features;
>  	int feature_id;
>  
> -	if (smu->is_apu && adev->family < AMDGPU_FAMILY_VGH)
> +	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
> +		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * For Renoir and Cyan Skillfish, they are assumed to have all features
> +	 * enabled. Also considering they have no feature_map available, the
> +	 * check here can avoid unwanted feature_map check below.
> +	 */
> +	if (enabled_features == ULLONG_MAX)
>  		return 1;
>  
>  	feature_id = smu_cmn_to_asic_specific_index(smu,
> @@ -509,11 +519,6 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
>  	if (feature_id < 0)
>  		return 0;
>  
> -	if (smu_cmn_get_enabled_mask(smu, &enabled_features)) {
> -		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
> -		return 0;
> -	}
> -
>  	return test_bit(feature_id, (unsigned long *)&enabled_features);
>  }
>  
> @@ -559,7 +564,7 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>  	feature_mask_high = &((uint32_t *)feature_mask)[1];
>  
>  	switch (adev->ip_versions[MP1_HWIP][0]) {
> -	case IP_VERSION(11, 0, 8):
> +	/* For Vangogh and Yellow Carp */
>  	case IP_VERSION(11, 5, 0):
>  	case IP_VERSION(13, 0, 1):
>  	case IP_VERSION(13, 0, 3):
> @@ -575,8 +580,16 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
>  						      1,
>  						      feature_mask_high);
>  		break;
> +	/*
> +	 * For Cyan Skillfish and Renoir, there is no interface provided by PMFW
> +	 * to retrieve the enabled features. So, we assume all features are enabled.
> +	 * TODO: add other APU ASICs which suffer from the same issue here
> +	 */
> +	case IP_VERSION(11, 0, 8):
>  	case IP_VERSION(12, 0, 0):
>  	case IP_VERSION(12, 0, 1):
> +		memset(feature_mask, 0xff, sizeof(*feature_mask));
> +		break;
>  	/* other dGPU ASICs */
>  	default:
>  		ret = smu_cmn_send_smc_msg(smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index 530be44e00ec..15bcf72b8e56 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -55,7 +55,7 @@
>  #define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
>  #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
>  #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
> -#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, 0, smu, mask)
> +#define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
>  #define smu_feature_is_enabled(smu, mask)				smu_ppt_funcs(feature_is_enabled, 0, smu, mask)
>  #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
>  #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
> -- 
> 2.29.0
> 
> 
