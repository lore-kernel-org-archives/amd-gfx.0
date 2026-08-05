Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E054C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 15:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C38510E0F8;
	Wed,  5 Aug 2026 15:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzGX3Hj2";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415A910E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 15:30:52 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38fe113c792so153329a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785943852; cv=none;
 d=google.com; s=arc-20260327;
 b=T92hwcpEcE+xDdZOW/JQ6LnnBkT2OyW28VcdseLWVnGEethmaue/v642pe7ay6B6jt
 eZm8sk4h+/Bebd8LOJoh/VBYYLUAY8/gokTHWMbSa2gncDLonxe8Bn3hCYJk3RdcvgOG
 oL6xcF9dGuZH7h2+H+4h2DWPzBc36IEn3A+2kCxFChkoD0AUEAXq//IZQvFPl14BwHrm
 npEm/iBQIpRQDG9uvjgQ9J7p5GuZf2GPgnxeKk70GFMxtlu0vI3O8oeikLa9iAc4BDWc
 Ap9g/OjI8z6ck9+d3Xnz0XtiIOAUnBLkobN4j+KsSj5LAb+hrugKiBvWasjMOU2fYYwe
 89ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YtfXTOQLJRgnrVgfVMGbP+QXuAuCQv9FqQrzk3l1/K4=;
 fh=kMzb7pE8xZdPO1j8hgtE8M4jNTh785Fj1ZCtpwIUrgs=;
 b=B+/D/ZBath/WXI9INmFPYdz5MwdI+pvj0kbO5XNQCuVQTnTun80P/5Wv1eCphEnvvi
 syWPzoQHB3Qd5f4cupH1scImnbTCd3JdTd1WOn2YmjXQL/N6DVOEzbRt1b21qqFVsrHz
 83EhHbpTTdCyfRpSQint1iLuB3dzy6tLHsK5Fu586SHZm8bH0bdayWbGczQpr0UOXcOY
 v8LUMeLQxFSUyvX4e3Gpb6iK4ei8Pl0wx8LSlRtynk+pi5YYrPUbxlrlDJo80CFoBBE5
 pgkkWikZ4Bd2g5wPpCkFCoanPKM63vtNrEIcwO5OnjJIydxxHxTgh9vy+sY4RRE95gjW
 gROw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943852; x=1786548652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YtfXTOQLJRgnrVgfVMGbP+QXuAuCQv9FqQrzk3l1/K4=;
 b=mzGX3Hj2hOrsXocBwXInt+/5/U8zsCSE7Wyr1YZ5lPWxjj0V00389DyFDI3SuuOieG
 +tJ5CNqn4ZZh3BPGM2o5rPPkUT4ztXx+GAQIVPKIq64Gi8qKE9bX/ebpN0VKmq4ID0sa
 tgl+D5w+OLsq71npglHTqD4Q2EmWJl/xDTP5J94ll7Fk/TZjCKpNCspF+5GfCB/dOHXp
 8DQqa8EyRZQLxJaxh+tYb/XmuWVZeuvROYzjWAdldQzWrgP6QnEX71yANzRastwSJ+mJ
 RehrSGDFRsYmaKs8ibun3vihQmIb0PH4xS4JP1tknZ2kwpqaId5d3SCl4H5ar8Hnbo0L
 6i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943852; x=1786548652;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YtfXTOQLJRgnrVgfVMGbP+QXuAuCQv9FqQrzk3l1/K4=;
 b=geDbm4xHXcKoTAm+OzFQjB1RqKuAfD81Pdc2MerIawSEvBDEMiK/qzIVyDG6wERvvU
 Y2VgaRdTvkPrs/K8Zwe3u5HgOiQQy9DmbcI7NFm4Pho+Dq1fWHcT4A1VOzA7i4FK548I
 9WNrlLb51TgNVZAdN9P3Ndp/lBKqKzpKp7seCzu2I3CpxHIBOKWYkQqnhCxLtIXVLQ2r
 FTLzxJYX0dy43WJiBamky1PSe0ysPCihTKuNdKDEbobqPcuwKdy2I+Vj7IPOmmuAptd6
 ndQbmgMq/ThMr+0eLq1VskNIKTIfwadyqg5q7CGCJzBKlJmcuJ9WqBngQi8KEo5KGLf8
 7+0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjjfM3zpXRoEYNAHfNDiajUJWYoDTNEpmshs4vAeMIdJnqy4JNfe3FtKPPbq4BbAE+fR1UfBDX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWmimr5zWs6KdBDqD84nqj2aHPa4NgovRHa5Ov6ENclHcbowLk
 xDWwBJePoPNnHtKhqX2Hp1fZpQF78RijbHh67O/dsdJuAdgi8WTWRDeNcPGZ6fsAayswhpDXMAc
 A8mEZTby8TtGhdTDvztBzvgE6hFtQ3mc=
X-Gm-Gg: AR+sD11TsrPjPmp2e4B1u0DSqahQXiIetugsYeTX+yFePGdR+LPj/TdK76nbq75pc0H
 bpxQrZzmvAaOzCGtqqOfrF6ReQatTxNsYPzosgYpDMrp7dauoAabOZGIDUi4cuU9yg3TUXYZWcA
 ay6YRACQH3NIS73JzvVgGcHbt6/7mm+WBiEvGqQBljNwXleCYVn2IK/9Ul8Xjc0RkVOU8sTT5N5
 RICB2/eLyqL2oatVcWuClD0HgmVIyRAnePVnpbK6xITr3uVrj2Okq8jN36WW6wPL7gngzYgKWUZ
 KSLE/miTNENK70oEtXSxLgAwkFNoYMt1sJMnB5FFEn//HxM57TPZgVqZoYXCCN/E5mOOhlYfUbu
 WlXMH0xC4ug/SzJVYh6CAOjBXMdHgzFfF7OiX74JCdQ==
X-Received: by 2002:a17:90b:3803:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3903b9c95aamr5953319a91.0.1785943850548; Wed, 05 Aug 2026
 08:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260805084114.1767743-1-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260805084114.1767743-1-Shubhankar.MilindSardeshpande@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 11:30:38 -0400
X-Gm-Features: AUfX_mzcyDrp1TR9AP-ykuYVZQajYrYC6YIpIKuZJPhM9_MrAZBhgUFwsi2iGrM
Message-ID: <CADnq5_Msk6bCV_DP_Ro_4UkEYy7073NSPXtD_Eo2mAoxogkikw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: add support for NBIO IP version
 7.11.5"
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Cc: Alexander.Deucher@amd.com, Pratik.Vishwakarma@amd.com, 
 Christian.Koenig@amd.com, amd-gfx@lists.freedesktop.org, 
 Veerabadhran.Gopalakrishnan@amd.com
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

On Wed, Aug 5, 2026 at 5:18=E2=80=AFAM Shubhankar Milind Sardeshpande
<Shubhankar.MilindSardeshpande@amd.com> wrote:
>
> This reverts commit 74ab07e3290ff38b31448af7bcf2085cadbb5e1a.
>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpa=
nde@amd.com>

Assuming patch 3 adds the new register headers, switch the order of
patches 2 and 3 when you commit them.  WIth that the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   1 -
>  drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 153 +++++-------------
>  2 files changed, 36 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index a404d8aa13ee..b5a25ca2e901 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3488,7 +3488,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 break;
>         case IP_VERSION(6, 3, 1):
>         case IP_VERSION(7, 11, 4):
> -       case IP_VERSION(7, 11, 5):
>                 adev->nbio.funcs =3D &nbif_v6_3_1_funcs;
>                 adev->nbio.hdp_flush_reg =3D &nbif_v6_3_1_hdp_flush_reg;
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/a=
md/amdgpu/nbif_v6_3_1.c
> index 000516b5845a..57b0cf817afb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> @@ -57,56 +57,12 @@
>  #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                    =
                0x0021
>  #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX           =
                2
>
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5  =
                0x8e13
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH_nbio_7_11_5_B=
ASE_IDX         5
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5   =
                0x8e14
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW_nbio_7_11_5_BA=
SE_IDX          5
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5       =
                0x8e15
> -#define regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL_nbio_7_11_5_BASE_I=
DX              5
> -
> -#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5                 =
                0x012d
> -#define regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL_nbio_7_11_5_BASE_IDX        =
                2
> -#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5                 =
                0x012e
> -#define regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL_nbio_7_11_5_BASE_IDX        =
                2
> -
> -#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5                  =
                0x0021
> -#define regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0_nbio_7_11_5_BASE_IDX         =
                2
> -
> -#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5                                =
                0x0100
> -#define regBIF_BX1_BIF_FB_EN_nbio_7_11_5_BASE_IDX                       =
                2
> -
> -#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5                           =
                0x00f1
> -#define regBIF_BX1_INTERRUPT_CNTL_nbio_7_11_5_BASE_IDX                  =
                2
> -#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5                          =
                0x00f2
> -#define regBIF_BX1_INTERRUPT_CNTL2_nbio_7_11_5_BASE_IDX                 =
                2
> -
> -#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5                     =
                0x0106
> -#define regBIF_BX_PF1_GPU_HDP_FLUSH_REQ_nbio_7_11_5_BASE_IDX            =
                2
> -#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5                    =
                0x0107
> -#define regBIF_BX_PF1_GPU_HDP_FLUSH_DONE_nbio_7_11_5_BASE_IDX           =
                2
> -
> -#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5          =
                0x00f7
> -#define regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL_nbio_7_11_5_BASE_IDX =
                2
> -
> -//BIF_BX1_BIF_FB_EN
> -#define BIF_BX1_BIF_FB_EN__FB_READ_EN__SHIFT_nbio_7_11_5                =
                0x0
> -#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN__SHIFT_nbio_7_11_5               =
                0x1
> -#define BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_nbio_7_11_5                  =
                0x00000001L
> -#define BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_nbio_7_11_5                 =
                0x00000002L
> -
>  static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5)) {
> -               WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL=
_nbio_7_11_5,
> -                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL);
> -               WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL=
_nbio_7_11_5,
> -                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_REG_FLUSH_CNTL);
> -       } else {
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL=
,
> -                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_MEM_FLUSH_CNTL);
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL=
,
> -                       adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP=
_REG_FLUSH_CNTL);
> -       }
> +       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
> +               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLU=
SH_CNTL);
> +       WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
> +               adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLU=
SH_CNTL);
>  }
>
>  static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
> @@ -115,8 +71,6 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device=
 *adev)
>
>         if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
>                 tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0=
_STRAP0_nbif_4_10);
> -       else if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(=
7, 11, 5))
> -               tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0=
_STRAP0_nbio_7_11_5);
>         else
>                 tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0=
_STRAP0);
>
> @@ -128,21 +82,12 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_devi=
ce *adev)
>
>  static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, boo=
l enable)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5)) {
> -               if (enable)
> -                       WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7=
_11_5,
> -                                    BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK_n=
bio_7_11_5 |
> -                                    BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK_=
nbio_7_11_5);
> -               else
> -                       WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN_nbio_7=
_11_5, 0);
> -       } else {
> -               if (enable)
> -                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
> -                                    BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> -                                    BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK)=
;
> -               else
> -                       WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
> -       }
> +       if (enable)
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
> +                            BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
> +                            BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
> +       else
> +               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
>  }
>
>  static u32 nbif_v6_3_1_get_memsize(struct amdgpu_device *adev)
> @@ -155,14 +100,8 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct a=
mdgpu_device *adev,
>                                             int doorbell_index,
>                                             int doorbell_size)
>  {
> -       u32 doorbell_range;
>         if (instance =3D=3D 0) {
> -               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION=
(7, 11, 4))
> -                       doorbell_range =3D RREG32_SOC15(NBIO, 0,
> -                                       regGDC_S2A0_S2A_DOORBELL_ENTRY_2_=
CTRL_nbif_4_10);
> -               else
> -                       doorbell_range =3D RREG32_SOC15(NBIO, 0,
> -                                       regGDC_S2A0_S2A_DOORBELL_ENTRY_2_=
CTRL);
> +               u32 doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_=
S2A_DOORBELL_ENTRY_2_CTRL);
>
>                 if (use_doorbell) {
>                         doorbell_range =3D REG_SET_FIELD(doorbell_range,
> @@ -191,10 +130,12 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct =
amdgpu_device *adev,
>                                                        S2A_DOORBELL_PORT2=
_RANGE_SIZE,
>                                                        0);
>
> -               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION=
(7, 11, 4))
> -                       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL_nbif_4_10, doorbell_range);
> +               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSI=
ON(7, 11, 4))
> +                       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL_nbif_4_10,
> +                                    doorbell_range);
>                 else
> -                       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL, doorbell_range);
> +                       WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_2_CTRL,
> +                                    doorbell_range);
>         }
>  }
>
> @@ -239,15 +180,15 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct a=
mdgpu_device *adev,
>                                                S2A_DOORBELL_PORT4_RANGE_S=
IZE,
>                                                0);
>
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> -               WREG32_SOC15(NBIO, 0,
> -                               regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbi=
f_4_10,
> -                               doorbell_range);
> -       else
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
> +               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CT=
RL_nbif_4_10,
> +                            doorbell_range);
> +       } else {
>                 if (instance)
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_5_CTRL, doorbell_range);
>                 else
>                         WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_EN=
TRY_4_CTRL, doorbell_range);
> +       }
>  }
>
>  static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
> @@ -299,7 +240,7 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amd=
gpu_device *adev,
>
>  static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4)) {
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4)) {
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CT=
RL_nbif_4_10, 0x30000007);
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CT=
RL_nbif_4_10, 0x3000000d);
>         } else {
> @@ -341,13 +282,7 @@ nbif_v6_3_1_enable_doorbell_selfring_aperture(struct=
 amdgpu_device *adev,
>  static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
>                                           bool use_doorbell, int doorbell=
_index)
>  {
> -       u32 ih_doorbell_range;
> -
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> -               ih_doorbell_range =3D RREG32_SOC15(NBIO, 0,
> -                               regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbi=
f_4_10);
> -       else
> -               ih_doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S=
2A_DOORBELL_ENTRY_1_CTRL);
> +       u32 ih_doorbell_range =3D RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_D=
OORBELL_ENTRY_1_CTRL);
>
>         if (use_doorbell) {
>                 ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
> @@ -376,11 +311,12 @@ static void nbif_v6_3_1_ih_doorbell_range(struct am=
dgpu_device *adev,
>                                                   S2A_DOORBELL_PORT1_RANG=
E_SIZE,
>                                                   0);
>
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
>                 WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL_nbif_4_10,
> -                               ih_doorbell_range);
> +                            ih_doorbell_range);
>         else
> -               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL, ih_doorbell_range);
> +               WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CT=
RL,
> +                            ih_doorbell_range);
>  }
>
>  static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
> @@ -388,13 +324,9 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_dev=
ice *adev)
>         u32 interrupt_cntl;
>
>         /* setup interrupt control */
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> -               WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2_nbio_7_1=
1_5,
> -                               adev->dummy_page_addr >> 8);
> -       else
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->d=
ummy_page_addr >> 8);
> +       WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_pag=
e_addr >> 8);
>
> -       interrupt_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNT=
L_nbio_7_11_5);
> +       interrupt_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNT=
L);
>         /*
>          * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=3D0 - dummy =
read disabled with msi, enabled without msi
>          * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=3D1 - dummy =
read controlled by IH_DUMMY_RD_EN
> @@ -406,10 +338,7 @@ static void nbif_v6_3_1_ih_control(struct amdgpu_dev=
ice *adev)
>         interrupt_cntl =3D REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUP=
T_CNTL,
>                                        IH_REQ_NONSNOOP_EN, 0);
>
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> -               WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL_nbio_7_11=
_5, interrupt_cntl);
> -       else
> -               WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrup=
t_cntl);
> +       WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
>  }
>
>  static void
> @@ -432,23 +361,17 @@ nbif_v6_3_1_get_clockgating_state(struct amdgpu_dev=
ice *adev,
>
>  static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *ad=
ev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> -               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FL=
USH_REQ_nbio_7_11_5);
> -       else
> -               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_REQ);
> +       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ)=
;
>  }
>
>  static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *a=
dev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 5))
> -               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FL=
USH_DONE_nbio_7_11_5);
> -       else
> -               return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FL=
USH_DONE);
> +       return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE=
);
>  }
>
>  static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
>         else
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX=
);
> @@ -456,7 +379,7 @@ static u32 nbif_v6_3_1_get_pcie_index_offset(struct a=
mdgpu_device *adev)
>
>  static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) >=3D IP_VERSION(7, 11, =
4))
> +       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 11=
, 4))
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
>         else
>                 return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA)=
;
> @@ -626,12 +549,8 @@ static void nbif_v6_3_1_set_reg_remap(struct amdgpu_=
device *adev)
>                 adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>                 adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_RE=
G_HOLE_OFFSET;
>         } else {
> -               if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSI=
ON(7, 11, 5))
> -                       adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET=
(NBIO, 0,
> -                               regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNT=
L_nbio_7_11_5) << 2;
> -               else
> -                       adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET=
(NBIO, 0,
> -                               regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNT=
L) << 2;
> +               adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0=
,
> +                       regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>                 adev->rmmio_remap.bus_addr =3D 0;
>         }
>  }
> --
> 2.43.0
>
