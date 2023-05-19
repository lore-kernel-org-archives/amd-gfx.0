Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F02C7EE26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 16:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A6A10E540;
	Fri, 19 May 2023 16:52:16 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBAF610E540
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 16:52:14 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-39415d3526bso1259770b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684515133; x=1687107133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlaI+pENUV/E1/VPN8sYLXCd1NurZ9vnnaASwpTyDRY=;
 b=pP5JeMHu8UTzT4T9SyRJnx2puy/jZvkF9rdHDkc2Kr2jF2yy9Hwmy/86reI/gJohbp
 JuvcNV/Qpyt/dTrm6ulD7mM/osqi/IlFiK0KZS4YTEGqqZpjFTU2Hc1U1TYd0R57fCjU
 QDKwlvbTmLh4CyiFOairkAYXQdRTA9N/0rdE0HU5u97pm7gf8ug++83UjYbDbTzw02il
 z544HCfqR7EgfkLBFuEF1giRxJiORlAwei3Sh/u/uRgblb9O32ElvoErH11EaXmnQSwL
 t5TQO+hTgZIifZUseI7O01hyP856qf36vVMBMY+QJsEImBzReuFqsJpkfC0t3kAoAsCP
 b9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515133; x=1687107133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlaI+pENUV/E1/VPN8sYLXCd1NurZ9vnnaASwpTyDRY=;
 b=Mkt40ZqV1Taw8Y6jnuIWCHKbPfxvvZ5fuw6xOJt1ybRJfVUQpnTLGRp5afErXyJpSx
 mTiFQU/Yxgz01KdInb1/Ukvddvx7xL83wJUkvkVI2bi6bQEmdJHfgoFjm0ZL2umlNySm
 E/zXTs9J4GumIphm6ijANKGpxHZY2gI4aZFS3FOI/aRBbzH0VOWQa11OpQiQwZ1HFLfX
 hATTNa65VTbEow6swWFbCX0aa2pdTya7QoIX/MvoUkYz65gtiJct/Gc6K0IFjF5SGsM1
 /Rwuj3K+JJlcR4uhvOuYytqDefv2ZowgpMhMYm5nXFPvdRr1Y03lqhwrYegA0Q8jVX+2
 wgKQ==
X-Gm-Message-State: AC+VfDy0hP66OVimGwr39NMcsncXxyYvFNs3zdqfR/6VRAEMUeImxnOP
 XDvHzbqmhPdQE5vM6RziOVZhUfQtSAxLNws4y1PVNjEc
X-Google-Smtp-Source: ACHHUZ7aapA59jIboSkm69irUbOdvTXAoToU8xfoDRlz5C5bWYvgd525WJzLW+L28WX9B9asJiW49IXb3L1GOQ/7res=
X-Received: by 2002:a05:6808:903:b0:396:9fe5:1a65 with SMTP id
 w3-20020a056808090300b003969fe51a65mr1278075oih.16.1684515133603; Fri, 19 May
 2023 09:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230519105852.247254-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519105852.247254-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 May 2023 12:52:02 -0400
Message-ID: <CADnq5_Nm6PbUH_peWiX1U_09zZq5YyfdNBjxEkzEfmrxPHnVWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix errors & warnings in mmhub_v1_8.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 19, 2023 at 6:59=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix below errors & warnings reported by checkpatch:
>
> ERROR: code indent should use tabs where possible
> WARNING: please, no space before tabs
> WARNING: please, no spaces at the start of a line
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> ERROR: space prohibited before that '++' (ctx:WxB)
> WARNING: Block comments use a trailing */ on a separate line
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_8.c
> index 3648994724c2..8600e42434e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -271,7 +271,7 @@ static void mmhub_v1_8_init_cache_regs(struct amdgpu_=
device *adev)
>                                             VMC_TAP_PTE_REQUEST_PHYSICAL,=
 0);
>                 }
>                 WREG32_SOC15(MMHUB, i, regVM_L2_CNTL4, tmp);
> -       }
> +       }
>  }
>
>  static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
> @@ -328,7 +328,7 @@ static void mmhub_v1_8_disable_identity_aperture(stru=
ct amdgpu_device *adev)
>  static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub;
> -       unsigned num_level, block_size;
> +       unsigned int num_level, block_size;
>         uint32_t tmp, inst_mask;
>         int i, j;
>
> @@ -776,9 +776,10 @@ static void mmhub_v1_8_inst_reset_ras_err_status(str=
uct amdgpu_device *adev,
>         /* reset mmea ras err status */
>         mmea_cgtt_clk_cntl_addr_dist =3D regMMEA1_CGTT_CLK_CTRL - regMMEA=
0_CGTT_CLK_CTRL;
>         mmea_err_status_addr_dist =3D regMMEA1_ERR_STATUS - regMMEA0_ERR_=
STATUS;
> -       for (i =3D 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i +=
+) {
> +       for (i =3D 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++=
) {
>                 /* force clk branch on for response path
> -                * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 1 */
> +                * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN =3D 1
> +                */
>                 reg_value =3D RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
>                                                 regMMEA0_CGTT_CLK_CTRL,
>                                                 i * mmea_cgtt_clk_cntl_ad=
dr_dist);
> @@ -814,7 +815,8 @@ static void mmhub_v1_8_inst_reset_ras_err_status(stru=
ct amdgpu_device *adev,
>
>         /* reset mm_cane ras err status
>          * force clk branch on for response path
> -        * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 1 */
> +        * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET =3D 1
> +        */
>         reg_value =3D RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL=
);
>         reg_value =3D REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
>                                   SOFT_OVERRIDE_ATRET, 1);
> --
> 2.25.1
>
