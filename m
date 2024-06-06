Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B23C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E2110E166;
	Thu,  6 Jun 2024 13:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QCD8q0sN";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3236010E166
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 13:37:50 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso791683a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717681069; x=1718285869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHpp/ho5FAsDw23YX7plfteta4qtgiMlkZBS88rY0/s=;
 b=QCD8q0sN6QNkx/BvUwfzmkzQ4AY7ixAUq0q01n/xx492Xs8a11cvUacjMmHbdB6bi5
 bP4Jz1qbzArcyGt+DZNhBZMmnAcXKwpNbWc2h8jM9obb62sd3DyG07JBeb2ZSX6jENcn
 e5ThUUd6va4qACj36mHvQYkTXWAPHNn0gsSVqPfOkpKtDZJN8DyV6vVW1aTgG4KTLUez
 hcFLAIxbIk7JwmRMuXu/G1u7CN66SMWVuh4YmEpDcRkF331+9yHbNQ6ycc5rNdH87mKw
 gzfJl4WSYk2FDCPyyWX1wLWseYCyIYYLCQa+KQcudKjlZBrN1YV2vo1OZ6SkbsiA8UIF
 00Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681069; x=1718285869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHpp/ho5FAsDw23YX7plfteta4qtgiMlkZBS88rY0/s=;
 b=esoUkyU5EWFRFEhwI58P+uq1LnBSowLoLA/YBJXhALUjJ3QaBouFdowTGPSHvfokLd
 CqGWrdDZFdstHhXpLAHpb4cf4+sHkvW5Z7OYz/CuTbZv11UpfVLP07H3JHBBaspNMIAV
 HC3z04GQEt5mVKL5As63CWPWtOKROebPP3Ib5g3rmn9QO826m2txDr5pAWw8WpVdKtUk
 yHNkA9TtAxs5qygC9WBQ64utzayRVcFZV1aGNP2Gp1XdSa7OxPonMLdhDuUQdpb7oKXC
 muLe38cArDChdrgfIesEH+VMo9miRzNJEI8pbhA+6+o25cpWcnWzdXGc36bZ5MrPBMzI
 /TTQ==
X-Gm-Message-State: AOJu0YyBMOwF2SjMyxhcnFkG55f7Vx3vJEjeGECma+qTmlll8EbY3PeW
 NZA1bQw7gB61E5ICHRqT7saVuUaMEM+fTikm4nisuT+ZEKeowpfgk/xM2agtLAmHFecTDqfEVm2
 bRaYClKjZ1j3pWt4IYaCPvX7kGeo=
X-Google-Smtp-Source: AGHT+IF5b98c02q3cvwh+zM7cbmjVqQX1O85W36OCAaGs5U1C27E+oq6weUZQE13j802xY6LBU+fwifGU4iYg2UX7Jo=
X-Received: by 2002:a17:90b:f8c:b0:2bd:fa34:a613 with SMTP id
 98e67ed59e1d1-2c27db02ca2mr5106279a91.4.1717681069436; Thu, 06 Jun 2024
 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240606120337.435058-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20240606120337.435058-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jun 2024 09:37:37 -0400
Message-ID: <CADnq5_Ph53BjWVfq8ohNS2hcbbu5-p3zJyPWZ0xJspi893VU=w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Indicate CU havest info to CP
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 6, 2024 at 8:22=E2=80=AFAM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> To achieve full occupancy CP hardware needs to know if CUs in SE are
> symmetrically or asymmetrically harvested
>
> v2: Reset is_symmetric_cus for each loop
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index aecc2bcea145..d50dd6f4472a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4203,9 +4203,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct =
amdgpu_device *adev, int xcc_i
>  static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
>                                  struct amdgpu_cu_info *cu_info)
>  {
> -       int i, j, k, counter, xcc_id, active_cu_number =3D 0;
> -       u32 mask, bitmap, ao_bitmap, ao_cu_mask =3D 0;
> +       int i, j, k, prev_counter, counter, xcc_id, active_cu_number =3D =
0;
> +       u32 mask, bitmap, ao_bitmap, ao_cu_mask =3D 0, tmp;
>         unsigned disable_masks[4 * 4];
> +       bool is_symmetric_cus;
>
>         if (!adev || !cu_info)
>                 return -EINVAL;
> @@ -4223,6 +4224,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_dev=
ice *adev,
>
>         mutex_lock(&adev->grbm_idx_mutex);
>         for (xcc_id =3D 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++=
) {
> +               is_symmetric_cus =3D true;
>                 for (i =3D 0; i < adev->gfx.config.max_shader_engines; i+=
+) {
>                         for (j =3D 0; j < adev->gfx.config.max_sh_per_se;=
 j++) {
>                                 mask =3D 1;
> @@ -4250,6 +4252,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_de=
vice *adev,
>                                         ao_cu_mask |=3D (ao_bitmap << (i =
* 16 + j * 8));
>                                 cu_info->ao_cu_bitmap[i][j] =3D ao_bitmap=
;
>                         }
> +                       if (i && is_symmetric_cus && prev_counter !=3D co=
unter)
> +                               is_symmetric_cus =3D false;
> +                       prev_counter =3D counter;
> +               }
> +               if (is_symmetric_cus) {
> +                       tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), re=
gCP_CPC_DEBUG);
> +                       tmp =3D REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARV=
ESTING_RELAUNCH_DISABLE, 1);
> +                       tmp =3D REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARV=
ESTING_DISPATCH_DISABLE, 1);
> +                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_=
DEBUG, tmp);
>                 }
>                 gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff,=
 0xffffffff,
>                                             xcc_id);
> --
> 2.34.1
>
