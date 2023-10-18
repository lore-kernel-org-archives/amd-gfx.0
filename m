Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6CDCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 15:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA1B10E0BF;
	Wed, 18 Oct 2023 15:42:32 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9516D10E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 15:42:29 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57b9193b1aeso4100060eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697643748; x=1698248548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF9Ilh/6A5ZkIJ74wMlxlnGBvTgiF5BlQui0uRQmiaM=;
 b=mj9NM+9VLlSd2hIpvCxMllFpck+c6eJTSyM0zSw7//B83v0Uf+371XRDsvx3vzE684
 T9Ey+TWyEPVSAJKVqOFax/11CrXil3aOYiIOyCy7rHdcVE5i2BNAjj4AA1ff7xAv5vma
 tNbOux392yVNOseE/R0aZG1ZN5zozBxoLOtND7fBgjRV/SodJzVczelwYzEYwXkUySOM
 9UHnGSsO57WjXe0wSV46/ueaoFeVpG+rtk7TmN9oXDKy1jyZULULC9YBoSSS5+9uQ8Ip
 OR7c8h5uSwz6gZZBRapike3WjAVd3Bg4IvuJeRqkm31Ghyeiee7WlRDLNawNq6LnHUjk
 KDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697643748; x=1698248548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GF9Ilh/6A5ZkIJ74wMlxlnGBvTgiF5BlQui0uRQmiaM=;
 b=ZLcosWc/yWEPAhZaDt9C3eEV4+p8FcXtKKIU71FtHp+6TeSzKHqYcEtWUeDW27mZkM
 W+OShEI5rfV4tiLuwjFF1Gs3cjp7NcKUSt+1PzIfsCHZ9DfNRSrM2jt9D89JukHET+YA
 ttBDaIDztvKdXx6tyvqGyh0riMa/rqSnd0R1jttdHZ1ipDUtEspYhUTkitbIPep7Fzj9
 w1BlvpynbLwDQsAmxZ+hUeeIsn5btsoIlPvLBz1c8elW/CZTHc5C/Mp0lABUHA3ktZoD
 GYIfeIxwQsq46aMnUYzpPFwp2JyW3yz3xalIs18Bcxd2fdSko9eEu08QXO8+1cftO/G/
 07Vw==
X-Gm-Message-State: AOJu0Ywnsz8mNcSw+UFJrruEdlm3PjFZurfC5+ZhMBzzIOSQwJpKADE7
 eO4Xhbzi3lHhQM2PDrrJVpCR1WOXvkcRCeWZwxw=
X-Google-Smtp-Source: AGHT+IG7LAeIIdMoNaOt+dTW8vUiTxxcqIA7EoldtOyrYd6hxTKUvDBVn79NmjT50rCt7+HPE3rv5bR+ztMZrjolqyM=
X-Received: by 2002:a05:6870:f115:b0:1e1:8aa8:4561 with SMTP id
 k21-20020a056870f11500b001e18aa84561mr2927459oac.16.1697643748547; Wed, 18
 Oct 2023 08:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231018052650.2553161-1-li.ma@amd.com>
In-Reply-To: <20231018052650.2553161-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Oct 2023 11:42:17 -0400
Message-ID: <CADnq5_N=+JHxDebu613sVdbyWKQE4Hsfk9cyt-S-qVX+2vCkcQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix missing stuff in NBIO v7.11
To: Li Ma <li.ma@amd.com>
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, ben.li@amd.com,
 lang.yu@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 18, 2023 at 6:17=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> add get_clockgating_state, update_medium_grain_light_sleep and
> update_medium_grain_clock_gating in nbio_v7_11_funcs
> v1:
> add missing funcs in nbio_v7_11.c
> v2:
> modify the if condition and add spport for nbio v7.11 clockgating.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c       | 78 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
>  .../asic_reg/nbio/nbio_7_11_0_offset.h        |  6 ++
>  .../asic_reg/nbio/nbio_7_11_0_sh_mask.h       | 13 +++-
>  4 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/am=
d/amdgpu/nbio_v7_11.c
> index 3a94f249929e..676ab1d20d2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
> @@ -272,6 +272,81 @@ static void nbio_v7_11_init_registers(struct amdgpu_=
device *adev)
>  */
>  }
>
> +static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_de=
vice *adev,
> +                                                      bool enable)
> +{
> +       uint32_t def, data;
> +
> +       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
> +               return;
> +
> +       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_=
USB4_CPM_CONTROL);
> +       if (enable) {
> +               data |=3D (BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_=
DYN_GATE_ENABLE_MASK |
> +                        BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_D=
YN_GATE_ENABLE_MASK |
> +                        BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_L=
CNT_GATE_ENABLE_MASK |
> +                        BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_R=
EGS_GATE_ENABLE_MASK |
> +                        BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_P=
RBS_GATE_ENABLE_MASK |
> +                        BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK_=
REGS_GATE_ENABLE_MASK);
> +       } else {
> +               data &=3D ~(BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK=
_DYN_GATE_ENABLE_MASK |
> +                         BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_=
DYN_GATE_ENABLE_MASK |
> +                         BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_=
LCNT_GATE_ENABLE_MASK |
> +                         BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_=
REGS_GATE_ENABLE_MASK |
> +                         BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_=
PRBS_GATE_ENABLE_MASK |
> +                         BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK=
_REGS_GATE_ENABLE_MASK);
> +       }
> +
> +       if (def !=3D data)
> +               WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_CPM_=
CONTROL, data);
> +}
> +
> +static void nbio_v7_11_update_medium_grain_light_sleep(struct amdgpu_dev=
ice *adev,
> +                                                     bool enable)
> +{
> +       uint32_t def, data;
> +
> +       if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
> +               return;
> +
> +       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_=
USB4_PCIE_CNTL2);
> +       if (enable)
> +               data |=3D BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM=
_LS_EN_MASK;
> +       else
> +               data &=3D ~BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_ME=
M_LS_EN_MASK;
> +
> +       if (def !=3D data)
> +               WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE=
_CNTL2, data);
> +
> +       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_=
USB4_PCIE_TX_POWER_CTRL_1);
> +       if (enable) {
> +               data |=3D (BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL=
_1__MST_MEM_LS_EN_MASK |
> +                       BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_=
_REPLAY_MEM_LS_EN_MASK);
> +       } else {
> +               data &=3D ~(BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTR=
L_1__MST_MEM_LS_EN_MASK |
> +                       BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_=
_REPLAY_MEM_LS_EN_MASK);
> +       }
> +
> +       if (def !=3D data)
> +               WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE=
_TX_POWER_CTRL_1, data);
> +}
> +
> +static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
> +                                           u64 *flags)
> +{
> +       uint32_t data;
> +
> +       /* AMD_CG_SUPPORT_BIF_MGCG */
> +       data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_CPM=
_CONTROL);
> +       if (data & BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE=
_ENABLE_MASK)
> +               *flags |=3D AMD_CG_SUPPORT_BIF_MGCG;
> +
> +       /* AMD_CG_SUPPORT_BIF_LS */
> +       data =3D RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCI=
E_CNTL2);
> +       if (data & BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_=
MASK)
> +               *flags |=3D AMD_CG_SUPPORT_BIF_LS;
> +}
> +
>  const struct amdgpu_nbio_funcs nbio_v7_11_funcs =3D {
>         .get_hdp_flush_req_offset =3D nbio_v7_11_get_hdp_flush_req_offset=
,
>         .get_hdp_flush_done_offset =3D nbio_v7_11_get_hdp_flush_done_offs=
et,
> @@ -288,6 +363,9 @@ const struct amdgpu_nbio_funcs nbio_v7_11_funcs =3D {
>         .enable_doorbell_aperture =3D nbio_v7_11_enable_doorbell_aperture=
,
>         .enable_doorbell_selfring_aperture =3D nbio_v7_11_enable_doorbell=
_selfring_aperture,
>         .ih_doorbell_range =3D nbio_v7_11_ih_doorbell_range,
> +       .update_medium_grain_clock_gating =3D nbio_v7_11_update_medium_gr=
ain_clock_gating,
> +       .update_medium_grain_light_sleep =3D nbio_v7_11_update_medium_gra=
in_light_sleep,
> +       .get_clockgating_state =3D nbio_v7_11_get_clockgating_state,
>         .ih_control =3D nbio_v7_11_ih_control,
>         .init_registers =3D nbio_v7_11_init_registers,
>         .remap_hdp_registers =3D nbio_v7_11_remap_hdp_registers,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index df7462cec6ab..7fe199560264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -863,6 +863,7 @@ static int soc21_common_set_clockgating_state(void *h=
andle,
>         case IP_VERSION(4, 3, 0):
>         case IP_VERSION(4, 3, 1):
>         case IP_VERSION(7, 7, 0):
> +       case IP_VERSION(7, 11, 0):
>                 adev->nbio.funcs->update_medium_grain_clock_gating(adev,
>                                 state =3D=3D AMD_CG_STATE_GATE);
>                 adev->nbio.funcs->update_medium_grain_light_sleep(adev,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset=
.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> index 846a8cf3926a..ff30f04be591 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
> @@ -775,6 +775,12 @@
>  #define regPCIE_USB4_ERR_CNTL5_BASE_IDX                                 =
                                5
>  #define regPCIE_USB4_LC_CNTL1                                           =
                                0x420179
>  #define regPCIE_USB4_LC_CNTL1_BASE_IDX                                  =
                                5
> +#define regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL                      =
                                0x420118
> +#define regBIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL_BASE_IDX             =
                                5
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2                       =
                                0x42001c
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2_BASE_IDX              =
                                5
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1             =
                                0x420187
> +#define regBIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1_BASE_IDX    =
                                5
>
>
>  // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mas=
k.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> index 84242240f611..7f131999a263 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
> @@ -24634,7 +24634,18 @@
>  //PCIE_USB4_LC_CNTL1
>  #define PCIE_USB4_LC_CNTL1__PCIE_USB_ROUTER_CLEAR_PATH_MODE__SHIFT      =
                                      0x0
>  #define PCIE_USB4_LC_CNTL1__PCIE_USB_ROUTER_CLEAR_PATH_MODE_MASK        =
                                      0x00000001L
> -
> +//BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MA=
SK                                    0x00000001L
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_M=
ASK                                   0x00000002L
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_=
MASK                                  0x00000020L
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_=
MASK                                  0x00000040L
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_=
MASK                                  0x00000080L
> +#define BIF_BIF256_CI256_RC3X4_USB4_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE=
_MASK                                 0x00000100L
> +//BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_CNTL2__SLV_MEM_LS_EN_MASK      =
                                      0x00010000L
> +//BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_=
MASK                                  0x00000001L
> +#define BIF_BIF256_CI256_RC3X4_USB4_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_=
EN_MASK                               0x00000008L
>
>  // addressBlock: nbio_nbif0_bif_cfg_dev0_rc_bifcfgdecp
>  //BIF_CFG_DEV0_RC0_VENDOR_ID
> --
> 2.25.1
>
