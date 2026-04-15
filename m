Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5752CF428E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 20:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA9E10E1B6;
	Wed, 15 Apr 2026 20:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D9R/olDK";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FE510E1A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 20:23:01 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so993565c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 13:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776284581; cv=none;
 d=google.com; s=arc-20240605;
 b=OoEYoEP6CeTUP8vzZGm6uobYNF5unlhsvS1y3iH6CG+LILaYHZULCPK/JRjkhBktqn
 sUsUFwa8qFNhv5Qu1mT+S2hy9bgjuaUErFsFpYIx1gaVhU6LHSnWmmPwwmsJWXGoUhWc
 s3+bebpKPqVSyQtUlOQBnbk2pj/APVr4pOzeDg3OStHJAkaBrPfqltEr73Ef7hJA4Tqt
 5JzzdaScwR9LZzL79TDOviRXX76l1Ux8efsozx9PPhgnvM7kYKBSg5oYPKrTSsyU2X45
 Q1xrkz8ZRahQ0nKpPrmD4rrNFg40RrrHvC1W/Vzcp1vdFpHdDNDo2vrA/uchO7JG0nEL
 uekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q6P0uBVwFnkHYvxQot6+TDtGlWunFt0s3U8ACRS3ykg=;
 fh=WRcOvqAWagn/OOijHcek4Yeq+cekNxSBiTd18ZctvQc=;
 b=UYOXo3SI4tfp2EiQCU+2DGJ/BREknAohQfBnfxN2YdzPa76SuzDjX1rQt3PgJt6sOT
 XF3+1JwmjT9cjINEbTXe/xaeN9zprBdlXmHvu91KV31DntzNU9mnpy5/IM4NAzzdsW3v
 uq3dIip1gEJBRZHSNluYRzjVudEM8/pIj11Lvpdp961F8UPQvY+a0nUHqWMFAjzHdRnY
 Yo3xB6CKzltHwzh6YHGJe8ktAElOICLBTOSYgfVrrJ/fM/mToTK98xe0CJp4gnHNI6gi
 d1HD8lPRwkwvNivngZm66omuxLcx4h7joGsMsmk2HV/pyOeXOQCI5T+q29E8XbBjABR3
 P2Nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776284581; x=1776889381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6P0uBVwFnkHYvxQot6+TDtGlWunFt0s3U8ACRS3ykg=;
 b=D9R/olDKP+s9iKNLXDtbJXIZpxYmCr3ZDkrBm1s0jIGxmhuOHIh3umWt7C+RohEBDz
 IDmsgPgdAvvY5HJvU2+LgdHlOK+KAJa/9J/ZsfgmYGMMMpOIMg4lopHa1U6L+AOl7G/f
 xxX7oNFNMjpNBcyE4BX8aiQu+HLQ/QFOkB5dBNGdGD3TRfhaPd1bwLyBZh6Jx6SLsaBF
 VdtgSr3ZPpPeW+B1Ha6BI1wJ2qmi3ZU69bajV8DwlOIM6QJpDFKKtw79+HjclGSU5W64
 y5opZn9vbuPiM20TfTraip/1aSXTpzaprP5/9Db/pQwG34GkovHllkYdTH6mJBXabZz8
 Ss3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284581; x=1776889381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q6P0uBVwFnkHYvxQot6+TDtGlWunFt0s3U8ACRS3ykg=;
 b=fxN+dZEP3d3pA0IeXWNWVpiTEI5VhF1d4RSjQfkjFHznnlKQrmcKM+O6f1jsU9+oCF
 M2YZsuHlsidD0vdwAgSlfY8tbKCnhkJNcg6Qc/EA+q8PSSuCwUiTuX1VJqZEUKmCS3Zg
 ru4OnKc5gAwuuRgHjaRXiHsXacHTGQ2PgWSfr3G9/iaboLKbkWq8c2bfzSU0YnWKD6Ct
 rRx6UGVdMc2+yEZhE+gLRoQ8t0x37YYEKGjexoI2B7oNMBVlUY8X30+CbF8gxSlCE2ya
 MX5eJ2pG9yn6ks0Hg1ViqssLbMw9W1T4nzhV3QrPJDGeFO/UeKtxDe3DzcF4VXebcVPa
 vsyw==
X-Gm-Message-State: AOJu0YymTfoixDgPepE/v1wvoAnrkDpQEMeD6Gz0uuCZxwxE4hOdl2rR
 i1FSTsj8VHOaZY4YSRmGTgkK2M7bZejnJ9TGkpxBk08aazsIhHoI+/ZAVaVHEBGasp7QqsHjAxl
 h0Ji1JI3zo70GC0txLVywi+HGcsIPw5974w==
X-Gm-Gg: AeBDieuzCfVAn+Yvu0DouO5n6hPC1qow+12J8CkCfGMVDTHMlwO0yMHaUJtg4DOA8RX
 /1Kt0MP9aA2a5VQK3AGYcOAqVVtIdgI9nGO7OFZMDKKVLCcYQfzHsT2THXZH6KPIeqtu/E6pRAd
 ccos3VWjP9TLMztgiOL93bGnCaDIqJpO0D91n9F884cwnrobf9gBZQB35ElxLOu/Gg9E+4UJdVu
 /lfvh3h0+3UfN9mr0zIZp19vX+PxF6xFjUaA16hLEYqTWFOIyiVKsxWtsM/BsDczhZXvoxCUtEK
 JDAyxNMyFdVOhezYkqrYCu6BWZ+Ywg/41+Sxnh3IY8fTvg59wAsXGulz9YWEHEImIBgq6w==
X-Received: by 2002:a05:7022:6182:b0:128:d590:2947 with SMTP id
 a92af1059eb24-12c5d4cb57bmr957289c88.4.1776284580793; Wed, 15 Apr 2026
 13:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260415200559.838180-1-bing.ma@amd.com>
In-Reply-To: <20260415200559.838180-1-bing.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Apr 2026 16:22:49 -0400
X-Gm-Features: AQROBzC09QxJ74JF43vVk60CFrUNz7efAiLS2iZa3S9T1X0-lIzMu_fdDuOlSP4
Message-ID: <CADnq5_MDOJrHu=Vg8On3_Va+qnL5=oS4oWGiwA4o4HKQSLue6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add gc v12_1_0 ip headers v6
To: Bing Ma <bing.ma@amd.com>
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

On Wed, Apr 15, 2026 at 4:14=E2=80=AFPM Bing Ma <bing.ma@amd.com> wrote:
>
> Add header files for gc v12_1_0 register offsets
> and shift masks
> v2: Update gc v12_1_0 ip headers
> v3: Update gc v12_1_0 ip headers
> v4, v5: Clean up registers (Alex)
> v6: Update gc v12_1_0 ip headers
>
> Signed-off-by: Bing Ma <Bing.Ma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/gc/gc_12_1_0_offset.h    | 110 +++++
>  .../include/asic_reg/gc/gc_12_1_0_sh_mask.h   | 455 ++++++++++++++++++
>  2 files changed, 565 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
> index d6a2839b4682..025e5490e6f1 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
> @@ -5475,6 +5475,14 @@
>  #define regCHA_PERFCOUNTER3_HI_BASE_IDX                                 =
                                1
>
>
> +// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfddec
> +// base address: 0x34000
> +#define regGC_CANE_PERFCOUNTER0_LO                                      =
                                0x36c0
> +#define regGC_CANE_PERFCOUNTER0_LO_BASE_IDX                             =
                                1
> +#define regGC_CANE_PERFCOUNTER0_HI                                      =
                                0x36c1
> +#define regGC_CANE_PERFCOUNTER0_HI_BASE_IDX                             =
                                1
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_perfsdec
>  // base address: 0x36000
>  #define regCPG_PERFCOUNTER1_SELECT                                      =
                                0x3800
> @@ -5761,6 +5769,16 @@
>  #define regCHA_PERFCOUNTER3_SELECT1_BASE_IDX                            =
                                1
>
>
> +// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfsdec
> +// base address: 0x36000
> +#define regGC_CANE_PERFCOUNTER0_SELECT                                  =
                                0x3e80
> +#define regGC_CANE_PERFCOUNTER0_SELECT_BASE_IDX                         =
                                1
> +#define regGC_CANE_PERFCOUNTER0_SELECT1                                 =
                                0x3e81
> +#define regGC_CANE_PERFCOUNTER0_SELECT1_BASE_IDX                        =
                                1
> +#define regGC_CANE_PERFCOUNTER0_MODE                                    =
                                0x3e82
> +#define regGC_CANE_PERFCOUNTER0_MODE_BASE_IDX                           =
                                1
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_gdfll_xvmin_xvmin_xvmin_reg=
_blk
>  // base address: 0x3a014
>  #define regXVMIN_XVMIN_WR_DATA                                          =
                                0x4806
> @@ -12080,6 +12098,22 @@
>  #define regGC_ATC_L2_PERFCOUNTER_HI_BASE_IDX                            =
                                1
>
>
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmprdec
> +// base address: 0x353d0
> +#define regGCUTCL2_FFBM_PERFCOUNTER_LO                                  =
                                0x34f4
> +#define regGCUTCL2_FFBM_PERFCOUNTER_LO_BASE_IDX                         =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER_HI                                  =
                                0x34f5
> +#define regGCUTCL2_FFBM_PERFCOUNTER_HI_BASE_IDX                         =
                                1
> +
> +
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbprdec
> +// base address: 0x353e0
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_LO                                =
                                0x34f8
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_LO_BASE_IDX                       =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_HI                                =
                                0x34f9
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_HI_BASE_IDX                       =
                                1
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbprdec
>  // base address: 0x353f0
>  #define regGC_L2TLB_PERFCOUNTER_LO                                      =
                                0x34fc
> @@ -12176,6 +12210,82 @@
>  #define regGC_ATC_L2_PERFCOUNTER_RSLT_CNTL_BASE_IDX                     =
                                1
>
>
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmpldec
> +// base address: 0x37bb0
> +#define regGCUTCL2_FFBM_PERFCOUNTER0_CFG                                =
                                0x3eec
> +#define regGCUTCL2_FFBM_PERFCOUNTER0_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER1_CFG                                =
                                0x3eed
> +#define regGCUTCL2_FFBM_PERFCOUNTER1_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER2_CFG                                =
                                0x3eee
> +#define regGCUTCL2_FFBM_PERFCOUNTER2_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER3_CFG                                =
                                0x3eef
> +#define regGCUTCL2_FFBM_PERFCOUNTER3_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER4_CFG                                =
                                0x3ef0
> +#define regGCUTCL2_FFBM_PERFCOUNTER4_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER5_CFG                                =
                                0x3ef1
> +#define regGCUTCL2_FFBM_PERFCOUNTER5_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER6_CFG                                =
                                0x3ef2
> +#define regGCUTCL2_FFBM_PERFCOUNTER6_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER7_CFG                                =
                                0x3ef3
> +#define regGCUTCL2_FFBM_PERFCOUNTER7_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER8_CFG                                =
                                0x3ef4
> +#define regGCUTCL2_FFBM_PERFCOUNTER8_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER9_CFG                                =
                                0x3ef5
> +#define regGCUTCL2_FFBM_PERFCOUNTER9_CFG_BASE_IDX                       =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER10_CFG                               =
                                0x3ef6
> +#define regGCUTCL2_FFBM_PERFCOUNTER10_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER11_CFG                               =
                                0x3ef7
> +#define regGCUTCL2_FFBM_PERFCOUNTER11_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER12_CFG                               =
                                0x3ef8
> +#define regGCUTCL2_FFBM_PERFCOUNTER12_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER13_CFG                               =
                                0x3ef9
> +#define regGCUTCL2_FFBM_PERFCOUNTER13_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER14_CFG                               =
                                0x3efa
> +#define regGCUTCL2_FFBM_PERFCOUNTER14_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER15_CFG                               =
                                0x3efb
> +#define regGCUTCL2_FFBM_PERFCOUNTER15_CFG_BASE_IDX                      =
                                1
> +#define regGCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL                           =
                                0x3efc
> +#define regGCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL_BASE_IDX                  =
                                1
> +
> +
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbpldec
> +// base address: 0x37c00
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER0_CFG                              =
                                0x3f00
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER0_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER1_CFG                              =
                                0x3f01
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER1_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER2_CFG                              =
                                0x3f02
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER2_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER3_CFG                              =
                                0x3f03
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER3_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER4_CFG                              =
                                0x3f04
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER4_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER5_CFG                              =
                                0x3f05
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER5_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER6_CFG                              =
                                0x3f06
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER6_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER7_CFG                              =
                                0x3f07
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER7_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER8_CFG                              =
                                0x3f08
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER8_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER9_CFG                              =
                                0x3f09
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER9_CFG_BASE_IDX                     =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER10_CFG                             =
                                0x3f0a
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER10_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER11_CFG                             =
                                0x3f0b
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER11_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER12_CFG                             =
                                0x3f0c
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER12_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER13_CFG                             =
                                0x3f0d
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER13_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER14_CFG                             =
                                0x3f0e
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER14_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER15_CFG                             =
                                0x3f0f
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER15_CFG_BASE_IDX                    =
                                1
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL                         =
                                0x3f10
> +#define regGCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL_BASE_IDX                =
                                1
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbpldec
>  // base address: 0x37c50
>  #define regGC_L2TLB_PERFCOUNTER0_CFG                                    =
                                0x3f14
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h =
b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
> index f606c5cd03c5..1cf890de35cb 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
> @@ -16951,6 +16951,15 @@
>  #define CHA_PERFCOUNTER3_HI__PERFCOUNTER_HI_MASK                        =
                                      0xFFFFFFFFL
>
>
> +// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfddec
> +//GC_CANE_PERFCOUNTER0_LO
> +#define GC_CANE_PERFCOUNTER0_LO__PERFCOUNTER_LO__SHIFT                  =
                                      0x0
> +#define GC_CANE_PERFCOUNTER0_LO__PERFCOUNTER_LO_MASK                    =
                                      0xFFFFFFFFL
> +//GC_CANE_PERFCOUNTER0_HI
> +#define GC_CANE_PERFCOUNTER0_HI__PERFCOUNTER_HI__SHIFT                  =
                                      0x0
> +#define GC_CANE_PERFCOUNTER0_HI__PERFCOUNTER_HI_MASK                    =
                                      0xFFFFFFFFL
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_cpwd_perfsdec
>  //CPG_PERFCOUNTER1_SELECT
>  #define CPG_PERFCOUNTER1_SELECT__PERF_SEL__SHIFT                        =
                                      0x0
> @@ -18123,6 +18132,46 @@
>  #define CHA_PERFCOUNTER3_SELECT1__PERF_MODE2_MASK                       =
                                      0xF0000000L
>
>
> +// addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_perfsdec
> +//GC_CANE_PERFCOUNTER0_SELECT
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL__SHIFT                    =
                                      0x0
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL1__SHIFT                   =
                                      0xa
> +#define GC_CANE_PERFCOUNTER0_SELECT__CNTR_MODE__SHIFT                   =
                                      0x14
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE1__SHIFT                  =
                                      0x18
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE__SHIFT                   =
                                      0x1c
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL_MASK                      =
                                      0x000003FFL
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_SEL1_MASK                     =
                                      0x000FFC00L
> +#define GC_CANE_PERFCOUNTER0_SELECT__CNTR_MODE_MASK                     =
                                      0x00F00000L
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE1_MASK                    =
                                      0x0F000000L
> +#define GC_CANE_PERFCOUNTER0_SELECT__PERF_MODE_MASK                     =
                                      0xF0000000L
> +//GC_CANE_PERFCOUNTER0_SELECT1
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL2__SHIFT                  =
                                      0x0
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL3__SHIFT                  =
                                      0xa
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE3__SHIFT                 =
                                      0x18
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE2__SHIFT                 =
                                      0x1c
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL2_MASK                    =
                                      0x000003FFL
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_SEL3_MASK                    =
                                      0x000FFC00L
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE3_MASK                   =
                                      0x0F000000L
> +#define GC_CANE_PERFCOUNTER0_SELECT1__PERF_MODE2_MASK                   =
                                      0xF0000000L
> +//GC_CANE_PERFCOUNTER0_MODE
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE0__SHIFT                 =
                                      0x0
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE1__SHIFT                 =
                                      0x2
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE2__SHIFT                 =
                                      0x4
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE3__SHIFT                 =
                                      0x6
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE0__SHIFT                =
                                      0x8
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE1__SHIFT                =
                                      0xc
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE2__SHIFT                =
                                      0x10
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE3__SHIFT                =
                                      0x14
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE0_MASK                   =
                                      0x00000003L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE1_MASK                   =
                                      0x0000000CL
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE2_MASK                   =
                                      0x00000030L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_MODE3_MASK                   =
                                      0x000000C0L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE0_MASK                  =
                                      0x00000F00L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE1_MASK                  =
                                      0x0000F000L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE2_MASK                  =
                                      0x000F0000L
> +#define GC_CANE_PERFCOUNTER0_MODE__COMPARE_VALUE3_MASK                  =
                                      0x00F00000L
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_xcc_gfx_cpwd_gdfll_xvmin_xvmin_xvmin_reg=
_blk
>  //XVMIN_XVMIN_WR_DATA
>  #define XVMIN_XVMIN_WR_DATA__XVMINDATA__SHIFT                           =
                                      0x0
> @@ -43203,6 +43252,28 @@
>  #define GC_ATC_L2_PERFCOUNTER_HI__COMPARE_VALUE_MASK                    =
                                      0xFFFF0000L
>
>
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmprdec
> +//GCUTCL2_FFBM_PERFCOUNTER_LO
> +#define GCUTCL2_FFBM_PERFCOUNTER_LO__COUNTER_LO__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER_LO__COUNTER_LO_MASK                    =
                                      0xFFFFFFFFL
> +//GCUTCL2_FFBM_PERFCOUNTER_HI
> +#define GCUTCL2_FFBM_PERFCOUNTER_HI__COUNTER_HI__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER_HI__COMPARE_VALUE__SHIFT               =
                                      0x10
> +#define GCUTCL2_FFBM_PERFCOUNTER_HI__COUNTER_HI_MASK                    =
                                      0x0000FFFFL
> +#define GCUTCL2_FFBM_PERFCOUNTER_HI__COMPARE_VALUE_MASK                 =
                                      0xFFFF0000L
> +
> +
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbprdec
> +//GCUTCL2_NHTTLB_PERFCOUNTER_LO
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_LO__COUNTER_LO__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_LO__COUNTER_LO_MASK                  =
                                      0xFFFFFFFFL
> +//GCUTCL2_NHTTLB_PERFCOUNTER_HI
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COUNTER_HI__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COMPARE_VALUE__SHIFT             =
                                      0x10
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COUNTER_HI_MASK                  =
                                      0x0000FFFFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_HI__COMPARE_VALUE_MASK               =
                                      0xFFFF0000L
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbprdec
>  //GC_L2TLB_PERFCOUNTER_LO
>  #define GC_L2TLB_PERFCOUNTER_LO__COUNTER_LO__SHIFT                      =
                                      0x0
> @@ -43660,6 +43731,390 @@
>  #define GC_ATC_L2_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK      =
                                      0x04000000L
>
>
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2ffbmpldec
> +//GCUTCL2_FFBM_PERFCOUNTER0_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER0_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER1_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER1_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER2_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER2_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER3_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER3_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER4_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER4_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER5_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER5_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER6_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER6_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER7_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER7_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER8_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER8_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER9_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL__SHIFT                  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_END__SHIFT              =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_MODE__SHIFT                 =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__ENABLE__SHIFT                    =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__CLEAR__SHIFT                     =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_MASK                    =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_SEL_END_MASK                =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__PERF_MODE_MASK                   =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__ENABLE_MASK                      =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER9_CFG__CLEAR_MASK                       =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER10_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER10_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER11_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER11_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER12_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER12_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER13_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER13_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER14_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER14_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER15_CFG
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL__SHIFT                 =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_END__SHIFT             =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_MODE__SHIFT                =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__ENABLE__SHIFT                   =
                                      0x1c
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__CLEAR__SHIFT                    =
                                      0x1d
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_MASK                   =
                                      0x000000FFL
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_SEL_END_MASK               =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__PERF_MODE_MASK                  =
                                      0x0F000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__ENABLE_MASK                     =
                                      0x10000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER15_CFG__CLEAR_MASK                      =
                                      0x20000000L
> +//GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT__SHIFT  =
                                      0x0
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__START_TRIGGER__SHIFT        =
                                      0x8
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER__SHIFT         =
                                      0x10
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY__SHIFT           =
                                      0x18
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL__SHIFT            =
                                      0x19
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE__SHIFT =
                                      0x1a
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT_MASK    =
                                      0x0000000FL
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__START_TRIGGER_MASK          =
                                      0x0000FF00L
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER_MASK           =
                                      0x00FF0000L
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY_MASK             =
                                      0x01000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL_MASK              =
                                      0x02000000L
> +#define GCUTCL2_FFBM_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK   =
                                      0x04000000L
> +
> +
> +// addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcutcl2nhttlbpldec
> +//GCUTCL2_NHTTLB_PERFCOUNTER0_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER0_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER1_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER1_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER2_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER2_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER3_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER3_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER4_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER4_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER5_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER5_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER6_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER6_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER7_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER7_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER8_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER8_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER9_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL__SHIFT                =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_END__SHIFT            =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_MODE__SHIFT               =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__ENABLE__SHIFT                  =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__CLEAR__SHIFT                   =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_MASK                  =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_SEL_END_MASK              =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__PERF_MODE_MASK                 =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__ENABLE_MASK                    =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER9_CFG__CLEAR_MASK                     =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER10_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER10_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER11_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER11_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER12_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER12_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER13_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER13_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER14_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER14_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER15_CFG
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL__SHIFT               =
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_END__SHIFT           =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_MODE__SHIFT              =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__ENABLE__SHIFT                 =
                                      0x1c
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__CLEAR__SHIFT                  =
                                      0x1d
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_MASK                 =
                                      0x000000FFL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_SEL_END_MASK             =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__PERF_MODE_MASK                =
                                      0x0F000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__ENABLE_MASK                   =
                                      0x10000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER15_CFG__CLEAR_MASK                    =
                                      0x20000000L
> +//GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT__SHIFT=
                                      0x0
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__START_TRIGGER__SHIFT      =
                                      0x8
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER__SHIFT       =
                                      0x10
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY__SHIFT         =
                                      0x18
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL__SHIFT          =
                                      0x19
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE__SHIF=
T                                     0x1a
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__PERF_COUNTER_SELECT_MASK  =
                                      0x0000000FL
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__START_TRIGGER_MASK        =
                                      0x0000FF00L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_TRIGGER_MASK         =
                                      0x00FF0000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__ENABLE_ANY_MASK           =
                                      0x01000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__CLEAR_ALL_MASK            =
                                      0x02000000L
> +#define GCUTCL2_NHTTLB_PERFCOUNTER_RSLT_CNTL__STOP_ALL_ON_SATURATE_MASK =
                                      0x04000000L
> +
> +
>  // addressBlock: CHIP_XCD_gfxip_aigc_gcutcl2_inst0_gcl2tlbpldec
>  //GC_L2TLB_PERFCOUNTER0_CFG
>  #define GC_L2TLB_PERFCOUNTER0_CFG__PERF_SEL__SHIFT                      =
                                      0x0
> --
> 2.34.1
>
