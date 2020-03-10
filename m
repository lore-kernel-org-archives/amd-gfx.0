Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B68C10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64598208C3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea1titwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64598208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DDA36E3A0;
	Tue, 10 Mar 2020 21:29:58 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926E36E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 21:29:56 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so3064837wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2IjTVdGdLGIKpuYn/C2JxPN7c/hNCQctF/bd15f8+WI=;
 b=ea1titwhuiH/E117XA8tnICgRapUUIZPuQMAdsBANH3B76vDZ3eFn9qo9Kj9lG0ail
 moIiPENul48KAm9lcptrvoIaEHOvI/WtltobvXAcxJJvucbfgIq6FRZlhx4MWpcikll3
 VomCnTg8eTCRHtj73scLsJR89oOtD2yVeoVrR9A77a9bpQ6goRVw9Fy/6wLR0iwvj7Pn
 2PAz7NRi2WXGfYC5oXDkZhEt3LHI8fiKCHBRp6QPv9xFVUszZG3/UqS/7uy/XpwAy9Zw
 XjNV6uLGrcn1yMp6SYWLZroiGRQRKA2QfwxRtSJPRjlT4xtTNXqjvFchN7kT/TJ4MVB7
 cjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2IjTVdGdLGIKpuYn/C2JxPN7c/hNCQctF/bd15f8+WI=;
 b=X1X9CfDT7BNX3sP9UDSmzs4m5Rr25r5oNbhmAWQk03jM6++olDNCB/3Tip881qi5rc
 gbm8zCXVRzcGBd20s4N//LcL5VCYpLE0qkokeiWEPYOx4pkNRy8GsQ+s0Qr0HNNiZtcx
 00Nm5sIzXeWJ+uY/HbDK1E+GG+rqq1R54hOf4TQBrHZ4rmhGoVZ7YDjsnW4/Vi+sHLAg
 6k3ph5+f3fgSkvk3P2KNENhEdFFBijcrs0owQFs2ruE94o6iNw3li/gJ9VCDqOAlSwSG
 hnpxtyedyz6Bs91AAhMOBCQuzd66w4hsd1pDSpl+/ZzJA5MJS4WgbhdYTE3ew8l3hfpU
 oI/w==
X-Gm-Message-State: ANhLgQ1h425+aqAvHKoxz9tWSt46M06m+EzY+7wIlqVqmTioz7nGtJoJ
 rXGS6qA9IR00TTGMToT3XeAnR2ED35pno31/kxw=
X-Google-Smtp-Source: ADFU+vsGYqzB8A9PvuDMwGNQLYA3SeO7LijP0mRUi4DIA2oZ4fV4dBZ5wK+wFsU74swNI2h7L+DauHLCsb4/uq4OYLA=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr3986634wmc.39.1583875795062; 
 Tue, 10 Mar 2020 14:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <1583844514-28921-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1583844514-28921-1-git-send-email-Jack.Zhang1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Mar 2020 17:29:42 -0400
Message-ID: <CADnq5_NMt0CG+bTjNrL7A48ry0ukJZzbq=wySA=hqrtiMcmFKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov refine vcn_v2_5_early_init func
To: Jack Zhang <Jack.Zhang1@amd.com>
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
Cc: jazha@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 10, 2020 at 8:48 AM Jack Zhang <Jack.Zhang1@amd.com> wrote:
>
> refine the assignment for vcn.num_vcn_inst,
> vcn.harvest_config, vcn.num_enc_rings in VF
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 2d64ba1..9b22e2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -74,29 +74,30 @@ static int amdgpu_ih_clientid_vcns[] = {
>  static int vcn_v2_5_early_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -       if (adev->asic_type == CHIP_ARCTURUS) {
> -               u32 harvest;
> -               int i;
> -
> -               adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
> -               for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -                       harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
> -                       if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> -                               adev->vcn.harvest_config |= 1 << i;
> -               }
> -
> -               if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> -                                                AMDGPU_VCN_HARVEST_VCN1))
> -                       /* both instances are harvested, disable the block */
> -                       return -ENOENT;
> -       } else
> -               adev->vcn.num_vcn_inst = 1;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 adev->vcn.num_vcn_inst = 2;
>                 adev->vcn.harvest_config = 0;
>                 adev->vcn.num_enc_rings = 1;
>         } else {
> +               if (adev->asic_type == CHIP_ARCTURUS) {
> +                       u32 harvest;
> +                       int i;
> +
> +                       adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
> +                       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +                               harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
> +                               if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> +                                       adev->vcn.harvest_config |= 1 << i;
> +                       }
> +
> +                       if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
> +                                               AMDGPU_VCN_HARVEST_VCN1))
> +                               /* both instances are harvested, disable the block */
> +                               return -ENOENT;
> +               } else
> +                       adev->vcn.num_vcn_inst = 1;
> +
>                 adev->vcn.num_enc_rings = 2;
>         }
>
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
