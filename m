Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A9EF589D9
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297F910F14A;
	Thu, 23 Apr 2026 14:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bG8Wk1dN";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC3110F142
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:16 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12714f01940so497389c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 07:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776952816; cv=none;
 d=google.com; s=arc-20240605;
 b=OKvBuTnfxd5oMXuzs4SXkGcz7q0C3VqY92TlsRaODzJnt7UQ7bJ6rlQyGfpacz99X5
 PTLnsS0y8v6pJWWqwWUp5OErk9ukuVD8fFLt8/eleeapPgK6q0iVSz7/UKOAFOlwA60S
 MVxUELgj5A9PuKSV3KTqlsK9BkFY7EkfokR6QZUUuXWkPBC92T94CQaVB8lYaBisEPkn
 NN3MonW/sNB7HlW5n5Y0VnMkKSBVxp6v1+LyztYUwuxmdcWrF3tR747Q2HhePabTMe0G
 Srruns8DGDVI2tC+laFHnufHrx56DQSct3kfE2b6ZAwBDWeSrryoiVdD3m1JoFGkcAeo
 Zpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 fh=QBgCsO5thhIS+T20QA9haaBhED/aQwfM2SSSl+9VVSM=;
 b=ZhjfCU2haPKSGMSBoNAAR3zD46TfoLGARxJHecUXogrcWeatC3n/zTe+OjoxtQ3hN+
 YN/a1pYt3sALMHqfKfovNcELjlhBuMD0J+BzOfLmqmbwMAdRy9YgEm25Dja9U0tMbDJG
 vNR4N3Lo0aCE3ct9ujT+MJKN7CsNOyeEEA0CMU+L0Qfg6/5NbOEMvMcpP65EWEw/y5Eu
 PV4+lxnYqjWGeavYKqDfUhkDSVnIsPjakxqG2mZF8f5+1XkXrjOEkCHsTvtXjMQWr9+g
 FZiiWCEaO1GeePnNrxbJs8FhT7rbPOAcg5iatgU3DOK0cYAW5wikNPBp19pBV0hsueTX
 keDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776952816; x=1777557616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 b=bG8Wk1dNk4xYTwzsL9yGHOoQKsfcFuBNZIHOsUPpe+aDjibR/EkQii9nF650cdO4go
 POrFVgwE/KlSCd99/zTq+k0Ub9mNXQm5P7HY8sk7SFiWmWWtANam/esdyrjiBVnxn1vN
 ItpflU9k14ZCzSPXvDyfHLPjpkP1rgE2iY9+ZLyVHM4JrgmMeFzQUgOqpbSq88qOdvmo
 Xis0CPVTLsZRGHXCvKa4wj4nu+3UbeCNqXYmRZ39nGHzPbZkp/9J7EB1omAtcnx7lwcd
 n9lXZM/LtvLCCMhmtdRq5+Ozwt1g8fyxLMnPkeGmgjZgEpyYLOXhZ3nu3tEqUefOhrLi
 iRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952816; x=1777557616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6CFLHuMNx88CjyYDUQpHwR3+vyQaKEvOKoH2tj3KBI=;
 b=PGEkPRSbmOaLNQXn2dGKU47Wt/nFrirQ2HVhgMlRpswdGWbBYN6kp1SZse08PumIdb
 Fv+T0pvB3W1zgwRuVa3fg94TIcC8CiXFGEXUT2p+QUz7c8GLdW1fhr79jR8ekqXaSpox
 nO5HzWwfY4tiaJJmmkoyqw0SLS/N1wpObtx8HjqMfsawvhCBcwWkDDQHTgBLwOplbs0P
 iI92uZAms1Y+MKbHr1QTeXww5oMM8fiBlrgmdn7Hp457aem567UCGk5FnV0kqpo9zjJ5
 nelxHeNLuxTDJYnbY2ojd6rDJOV6SSUE8rUb21GB7CKZIHPDSTJd4pWYhk7B/zQ59ev8
 ryCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9r8QcwmzPVVt13m/L8C1kRVVIr6Cnvr2PqekYE6inOoD1oOjGFTGkdedbuOhPgAeE6hHUQ/wA1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEaUgStHRtSiWT1Pty8NENZ9bv2d3MRL9h3ctq9vX8oNjidqNK
 04L5hYsc91Pvk/CSVnCP8oXTZlVCJhii9IRQmegnbRB4lv46f/DQ0IJhDX60vEiSlnTqjUkrtUP
 joFsW9AonSf/3W6BKq/mRlplFs+BVhLM=
X-Gm-Gg: AeBDiesb+tWRxL/f80ENU65ARki/Xi1GDb9fKo4JLSNVrztHl/pd6rmRCl3zJcOi3zG
 /HQ+0Ci869RaMtjNRnQXeLfM1vZ51NVfegLBnfFufWcx3iX9bMNucl+mTdVG7Ewht48rVny5OzH
 lGXQeH2yCPp0+w3Prf0FguU6nUZniDPiBpyfqrf8hrwRwE5HoJcW0B+hnl92hFY3BA5uSex8KgS
 SCWMGFzMts0Ohvj1hexTxkrix9CIuKMueAK4C4lZ0UxqpL2F5GueYuk0ZX4NCNjCYSf9cfG51XW
 m9o8LMdwwHTa8ecoFkW2WDBb3CXJRTwk+Q/7SVHfLtS7kiupfcTn5ItQXgf8ZffnghHZs5ohVxN
 wRfBO
X-Received: by 2002:a05:7022:1282:b0:128:e6e2:0 with SMTP id
 a92af1059eb24-12c73fa23aemr5510335c88.6.1776952815140; Thu, 23 Apr 2026
 07:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423000629.47095-1-gabrielsousa230@gmail.com>
In-Reply-To: <20260423000629.47095-1-gabrielsousa230@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Apr 2026 10:00:03 -0400
X-Gm-Features: AQROBzABuIfAhLr_mlMeNhXvA3-uI3tYv_M94OeLMXiq2n7dT17FCYn4jQr2u48
Message-ID: <CADnq5_NAykPRCEAPAP7G9jJX7hLdtTfbfhMSt_1r_Z=UtstbmA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: deduplicate register access and helper
 routines
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, Apr 23, 2026 at 4:52=E2=80=AFAM Gabriel Almeida
<gabrielsousa230@gmail.com> wrote:
>
> Several helper functions are duplicated across multiple files with
> identical logic.
>
> Move these helpers to more appropriate locations based on their
> functionality:
> - move read_indexed_register to amdgpu_reg_access.c as
>   amdgpu_read_indexed_register
> - move program_aspm to amdgpu_nbio.c as
>   amdgpu_nbio_program_aspm

Can you split this into two patches?  one for the nbio change and one
for the read_indexed_register change?

Thanks!

Alex

>
> No functional changes intended.
>
> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
> v2:
> - Move read_indexed_register to amdgpu_reg_access.c instead of a new file
> - Move program_aspm to amdgpu_nbio.c
> - Drop amdgpu_common.[ch]
> - Drop changes to common_sw_init
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      | 10 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |  2 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 +++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/nv.c               | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc15.c            | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c            | 30 ++-----------------
>  drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +------------
>  9 files changed, 41 insertions(+), 123 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_nbio.c
> index a97426583..e4c8e9872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -84,3 +84,13 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *ad=
ev, struct ras_common_if *
>         amdgpu_ras_block_late_fini(adev, ras_block);
>         return r;
>  }
> +
> +
> +void amdgpu_nbio_program_aspm(struct amdgpu_device *adev)
> +{
> +       if (!amdgpu_device_should_use_aspm(adev))
> +               return;
> +
> +       if (adev->nbio.funcs->program_aspm)
> +               adev->nbio.funcs->program_aspm(adev);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_nbio.h
> index b528de6a0..a61f3a6e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -121,4 +121,6 @@ u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_d=
evice *adev);
>
>  bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
>
> +void amdgpu_nbio_program_aspm(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 540040c76..daefbeeee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_de=
vice *adev, uint32_t inst,
>         }
>         return ret;
>  }
> +
> +
> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +                              u32 se_num, u32 sh_num, u32 reg_offset)
> +{
> +       uint32_t val;
> +
> +       mutex_lock(&adev->grbm_idx_mutex);
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> +
> +       val =3D RREG32(reg_offset);
> +
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       return val;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.h
> index 4d88e5cd1..a1011af6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> @@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_dev=
ice *adev, uint32_t inst,
>                                     uint32_t reg_addr, char reg_name[],
>                                     uint32_t expected_value, uint32_t mas=
k);
>
> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +                                       u32 se_num, u32 sh_num, u32 reg_o=
ffset);
> +
>  #endif /* __AMDGPU_REG_ACCESS_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 7ce1a1b95..1ab9d450e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -354,29 +354,13 @@ static struct soc15_allowed_register_entry nv_allow=
ed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32=
 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
>
>  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return nv_read_indexed_register(adev, se_num, sh_num, reg=
_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -511,16 +495,6 @@ static int nv_set_vce_clocks(struct amdgpu_device *a=
dev, u32 evclk, u32 ecclk)
>         return 0;
>  }
>
> -static void nv_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -
> -}
> -
>  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
>         .major =3D 1,
> @@ -984,7 +958,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block *=
ip_block)
>                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev);
>
>         /* enable aspm */
> -       nv_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index b456e4541..87b398dd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>  };
>
> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, =
u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc15_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
>                         return adev->gfx.config.gb_addr_config;
> @@ -695,15 +678,6 @@ static int soc15_set_vce_clocks(struct amdgpu_device=
 *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc15_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
>  {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> @@ -1284,7 +1258,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         /* enable aspm */
> -       soc15_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index fbd1d97f3..93c002e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, =
u32 se_num,
> -                                        u32 sh_num, u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>                                       bool indexed, u32 se_num,
>                                       u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc21_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) && adev->gfx.config.gb_addr_config)
>                         return adev->gfx.config.gb_addr_config;
> @@ -470,15 +453,6 @@ static int soc21_set_vce_clocks(struct amdgpu_device=
 *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc21_program_aspm(struct amdgpu_device *adev)
> -{
> -       if (!amdgpu_device_should_use_aspm(adev))
> -               return;
> -
> -       if (adev->nbio.funcs->program_aspm)
> -               adev->nbio.funcs->program_aspm(adev);
> -}
> -
>  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
>         .major =3D 1,
> @@ -925,7 +899,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         /* enable aspm */
> -       soc21_program_aspm(adev);
> +       amdgpu_nbio_program_aspm(adev);
>         /* setup nbio registers */
>         adev->nbio.funcs->init_registers(adev);
>         /* remap HDP registers to a hole in mmio space,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index d1adf19a5..265db9331 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_al=
lowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>
> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
> -                                           u32 se_num,
> -                                           u32 sh_num,
> -                                           u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
> -
>  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>                                          bool indexed, u32 se_num,
>                                          u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc24_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) &&
>                     adev->gfx.config.gb_addr_config)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/soc_v1_0.c
> index 709b1669b..4a5fe8e9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1_0=
_allowed_read_registers[] =3D {
>         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>  };
>
> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *ade=
v,
> -                                              u32 se_num,
> -                                              u32 sh_num,
> -                                              u32 reg_offset)
> -{
> -       uint32_t val;
> -
> -       mutex_lock(&adev->grbm_idx_mutex);
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> -
> -       val =3D RREG32(reg_offset);
> -
> -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> -       mutex_unlock(&adev->grbm_idx_mutex);
> -       return val;
> -}
>
>  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>                                             bool indexed, u32 se_num,
>                                             u32 sh_num, u32 reg_offset)
>  {
>         if (indexed) {
> -               return soc_v1_0_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> +               return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
>         } else {
>                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG_1) &&
>                     adev->gfx.config.gb_addr_config)
> --
> 2.43.0
>
