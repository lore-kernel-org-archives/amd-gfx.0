Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46706C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 23:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21E264E49
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 23:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21E264E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0C16E128;
	Wed,  3 Feb 2021 23:37:17 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D156E128
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 23:37:16 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id m7so1762759oiw.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Feb 2021 15:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vniWOCs9+IhD06HcPsgaYIYWSeyhgkmaCmaIpk1ZMAo=;
 b=sm7synINi2dMTDq/nNNipQKnXwOG2irSKQUb69lFAM5pIg/Hak9YrnMQctbdaaogV4
 PYjxtwGme8qVWD063+SCuLk7I1beNOaRYEnRua/3e9UXhxrt/vEGR+Q/t1DeC+wxP7TT
 byz5Rk2ZJi7VEZjGV0C9+u/KMF0r2FFF0Mguvf2W+P4DM9ByX08tfHo04bh9BPpKKtfE
 yQV2Zx8HIZBHxnBxwPE/vPOTMNRyl010Vo6MAurov2FCqYHX089jEdosc70epZLNwV7y
 e9joSzwm9UB63YUtcHKHrUFCleKApJEXgK278ADWpg47VtqVv9zeik8e9oZ/YrzMrdzS
 +cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vniWOCs9+IhD06HcPsgaYIYWSeyhgkmaCmaIpk1ZMAo=;
 b=hl7Gyb+m1sPPhtdq0g57raDiODhcultmVWuhwv3lkbfB+4GY2EATwGiUMZLW/UXabS
 cL3IP7AAaocgiooDSTqkDj/HEINp664KoUO6XsrmoVkie3r7aMkFSU417Ou6qvBVZuRA
 fA7Qrhi1yh2H+B8HbfgImJDbrsQSWS37h7vjvevhaEHYqwbJjKvZTbc2dCVgib5736BO
 fGsflNsxZsQL4g6NH5tcX9As38VNvpjFvomhzxUKZLAXFfaHwmwvBJ54dPi1FKQUnx3D
 1UuqQ4VT7LvbkaWEB9ZQ6gqDqfe7oF6Rnfzqx9L9uBLoZYoIOyPCQMh+Eam2/1osfElU
 RaEg==
X-Gm-Message-State: AOAM530DJc0YatXPS2+j301bySJbNUh+9VTmb9SHWg15kFbT24UFgMu+
 ong1yrAl1EGkoiWIEy5utU6K/KarU8tKJgCBZnw=
X-Google-Smtp-Source: ABdhPJwHKjLQM8w+jdlMj2NZaO4FWly2OySe4+p0EQKIcEqfqoPe9xiNH/VrIKOAvXByQXI76HNJ4DTKErVK+VfYnYk=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr3519207oia.120.1612395435678; 
 Wed, 03 Feb 2021 15:37:15 -0800 (PST)
MIME-Version: 1.0
References: <1612341030-13679-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1612341030-13679-1-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Feb 2021 18:37:04 -0500
Message-ID: <CADnq5_OepyTSMCPzjgdP+BuCcvY8LFzSMm6ijvfk0ehm2oSYEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: update register offsets for VGH in the
 gfx_v10_0_setup_grbm_cam_remapping function
To: chen gong <curry.gong@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 3:30 AM chen gong <curry.gong@amd.com> wrote:
>
> For Vangogh, the offset values of some GC registers used in the
> gfx_v10_0_setup_grbm_cam_remapping() function are not the same as those
> of Sienna_Cichlid, so cannot be reused.
>
> Although gfx_v10_0_setup_grbm_cam_remapping() is not called now for
> Vangogh, it is necessary to implement this patch in case we enable this
> code in the future.
>
> Signed-off-by: chen gong <curry.gong@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 56 +++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 8ac2af2..a9ce2a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7029,9 +7029,63 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
>         WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
>
>         switch (adev->asic_type) {
> +       case CHIP_VANGOGH:
> +               /* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
> +               WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
> +
> +               /* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
> +               data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
> +                       GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
> +                      (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_Vangogh) <<
> +                       GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
> +               break;
>         case CHIP_SIENNA_CICHLID:
>         case CHIP_NAVY_FLOUNDER:
> -       case CHIP_VANGOGH:
>         case CHIP_DIMGREY_CAVEFISH:
>                 /* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
>                 data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
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
