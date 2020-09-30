Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE217C4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F50020738
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="cxCP4ZwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F50020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164136E095;
	Wed, 30 Sep 2020 13:08:07 +0000 (UTC)
Received: from services.gouders.net (services.gouders.net [141.101.32.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CBC6E092
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 09:55:51 +0000 (UTC)
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net
 [47.66.24.155]) (authenticated bits=0)
 by services.gouders.net (8.14.8/8.14.8) with ESMTP id 08U9ragA029238
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2020 11:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
 t=1601459617; bh=PUQcXsedfrMCea59QAwg2slMBkUVMc2ibuObQr5E7aI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cxCP4ZwLjC4bFSjhX6Os3vmNlbKoD9kujZGLiCnTlpC4FRpAqxOaO/ngtEaF43RCv
 u4PS1ohzyIGubkLEyZg/pdEFQNTX5xISrIvseN6mKFLH/ZN69f3piM0ll8Hpj7sYKk
 K6Lrti2dzoPX5diLcwOX9eaeGpwXtunjy62DUvLg=
From: Dirk Gouders <dirk@gouders.net>
To: Evan Quan <evan.quan@amd.com>
Subject: Re: [PATCH] drm/amd/pm: setup APU dpm clock table in SMU HW
 initialization
In-Reply-To: <20200930040756.23559-1-evan.quan@amd.com> (Evan Quan's message
 of "Wed, 30 Sep 2020 12:07:56 +0800")
References: <20200930040756.23559-1-evan.quan@amd.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Wed, 30 Sep 2020 11:53:31 +0200
Message-ID: <gha6x78uas.fsf@gouders.net>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 30 Sep 2020 13:08:05 +0000
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Evan Quan <evan.quan@amd.com> writes:

> As the dpm clock table is needed during DC HW initialization.
> And that (DC HW initialization) comes before smu_late_init()
> where current APU dpm clock table setup is performed. So, NULL
> pointer dereference will be triggered. By moving APU dpm clock
> table setup to smu_hw_init(), this can be avoided.

Thanks for the quick response.  I tested the patch and it fixes the call
trace I initially reportet (#1 in the table below).  #2 is unaffected by
this patch.  I could try to bisect it as well bud did not do it, so far.

Probably, I caused some confusion in the original thread and I will try to
order it a bit.  What I noticed is:

         with amdgpu.discovery value    | noticed issue
         ===============================================================
1)                unset or "1"          | call trace because of
                                        | assert(0) in rn_clk_mgr_helper_populate_bw_params()
         -------------------------------+-------------------------------
2)                      0               | NULL pointer dereference in soc15_set_ip_blocks()

This patch fixes #1, i.e. avoids the assert() in following code in
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c

	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
			j = i;
			break;
		}
	}

	if (j == -1) {
		/* clock table is all 0s, just use our own hardcode */
		ASSERT(0);
		return;
	}

To me, the commit message sounds as if the patch fixes #2 whereas it
really is #1 that gets fixed.  I also wonder if we probably want a
fixes-line for completeness:

Fixes: 02cf91c113ea (drm/amd/powerplay: postpone operations not required for hw setup to late_init)

Dirk

> Change-Id: I2bb1f9ba26f9c8820c08241da62f7be64ab75840
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Dirk Gouders <dirk@gouders.net>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f46cf9ea355e..8f6045def272 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -482,17 +482,6 @@ static int smu_late_init(void *handle)
>  		return ret;
>  	}
>  
> -	/*
> -	 * Set initialized values (get from vbios) to dpm tables context such as
> -	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> -	 * type of clks.
> -	 */
> -	ret = smu_set_default_dpm_table(smu);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> -		return ret;
> -	}
> -
>  	ret = smu_populate_umd_state_clk(smu);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
> @@ -1021,6 +1010,17 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Set initialized values (get from vbios) to dpm tables context such as
> +	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> +	 * type of clks.
> +	 */
> +	ret = smu_set_default_dpm_table(smu);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> +		return ret;
> +	}
> +
>  	ret = smu_notify_display_change(smu);
>  	if (ret)
>  		return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
