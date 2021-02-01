Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DDC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8238E64D9E
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 15:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8238E64D9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3776E323;
	Mon,  1 Feb 2021 15:30:52 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C427C6E323
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 15:30:50 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id k25so19162740oik.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I6XWzWyUDp9upVbASgwYsVKPquUCsSyUYU2j7XZVp3U=;
 b=le8aZdbyXWDg2mlG8ML0Sva5MKokI3JqwkybKGnwFYS3U5NCO2YdC8fK3XvqPQf+oR
 uKtHM2f5cQpTpJzuO1SPmsJOdK1BDI7e6F23UFJpGvJ1rpoI8uKce1KjsQU8zFCu2vnB
 GMHEFP+jQGlGvDRmwwftkwdnhzfFd4/ciusSgrJycGZQHTeQANl/xD5vGVGsGoV82L+I
 5pGrbYBu7x5cOGp0ub5mOu85sNHuAlKEovqiOlePQHZzMw3zgHoSMN+NM56i4HS5zFHU
 CZqtU7NYL2CrvnhqfT3b0JjLJjjKqe2jvVUiKO3+LSeIepTo/inf8Og8vXtkAOJRxikY
 R72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I6XWzWyUDp9upVbASgwYsVKPquUCsSyUYU2j7XZVp3U=;
 b=JCEc3H5ph0SxtgNKW30ZHIwS70XnucTosf/6pp4jUj2h376q42CrPeP9dKcWtiCgL3
 valFJAnFOQYYWNvFoEUVV2tuu+egol962vZaNOr2L6NC4BsZyy6fj5ed8bW8i0FCWSlf
 y5JogYheTxHxw+lYuHMpBbWWvktGn0VtvsCkaObZA8Buaztp/oAy17f1QVS+hyi6fp4D
 De3xEpFZ82f72HpbN7uuDzohheaB3G027OjZppu8ZdfrTTuhQcJQNM/t1NdYZF6CLPf0
 0MpG406SDbmTtg37Y9VXaBEaemlRYwiuTOk8symv0JGHrWLRd7lM+ZR8Z/eDIGrgiQwI
 dZCg==
X-Gm-Message-State: AOAM532KLop6fI75n8K6D+en7lIA0l23Kmzyu5/oAH9UzIMeG8RdDJIt
 qkXsu+1IL7ezhul38guovvw5gdq4L1hyEb1FmV/fiBDCD54=
X-Google-Smtp-Source: ABdhPJwLijCsTodXVCLcM7JnZiz87s9GjAhHTJTb1ABw4gXQ0QEVq9q6Jka/Lnq6d8gvJThFu46jSN5i0xiPlX2JoYo=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr11094049oia.120.1612193450158; 
 Mon, 01 Feb 2021 07:30:50 -0800 (PST)
MIME-Version: 1.0
References: <1612170423-13733-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1612170423-13733-1-git-send-email-curry.gong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Feb 2021 10:30:39 -0500
Message-ID: <CADnq5_OGnqESNNqwkwMFwHcw8+AEcQH8w5+JGJAzRXcKohAUCg@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 1, 2021 at 4:07 AM chen gong <curry.gong@amd.com> wrote:
>

Missing patch description.

Also, nothing wrong with the change per se, but
gfx_v10_0_check_grbm_cam_remapping() returns true for vangogh, so
gfx_v10_0_setup_grbm_cam_remapping() is never called for vangogh.

Alex

> Signed-off-by: chen gong <curry.gong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 56 +++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 024460b..d7e9a18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7031,9 +7031,63 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
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
