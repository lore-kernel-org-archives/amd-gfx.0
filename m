Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B33CC10DAA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 14:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F25710E543;
	Wed, 29 Nov 2023 14:24:41 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBA210E543
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 14:24:39 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1fa37df6da8so2047340fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701267879; x=1701872679; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3IXZoOiBHV7I2i3RQo1isSRzOXMr4mEMAnUZglnzcI=;
 b=CQyg56MYwR4mcPnRQjxKzaEHu74XiShstSQg80AHPfGkbHjiirxK+ie0vlfzoxiPqr
 yk1e2wgvqSUz70c4LXsjR043idGLcL0AgqsQ6l6vqfEd6HyYj6sn0p6I7stSlTeBo6P0
 TKO7wNO91xa6oasvKgUqzHXv7bUVETrA2aT76ESYSMiXLhjfgaHjRK6aAniwYW5kkkLB
 /RYniq44DOZgRhMC9E/fmNcy+fi2+oi9hkEzp9/usQ4Lig/ppKsl9W8WIFLRV7KxBE4u
 TU5vHgCpF0YOqPBAPi/2wc1I13BFPLiu3rqaM/O5ZQHeC7pJmqet4sjRSj6BUOdC2o8w
 nZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701267879; x=1701872679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3IXZoOiBHV7I2i3RQo1isSRzOXMr4mEMAnUZglnzcI=;
 b=JRxcbwTuRHmpUuJS7y/bLI5RMKZUf9sw/FoQLTm6j6EKgJPxEOJrUPSl0rwSO00M+L
 iOd7lW46RAOjIiBdEb6xENuYOit84SlNkcxG0tw8srvatKs90LVucn0rqFDHH7bV80C5
 IkxdH7f9AbT8bCljVsoSxwtsf3Ml1OE9MDHWovbIYqUr77Di/WRXw89RetAabmVFaZ2r
 xZb5dAGAnAGdsVlsQMy4NoNJbo1Rj+doSR1PA44j5tRHLsQPRbwR7pqUtgd23NJ9RdnE
 NodRwuaaRxUu2yo8Omoe0VFD8YehQgcgHVNTkoz6WBTbEE2P8yZ2QgRhAmJXP4kMhlKh
 kvcw==
X-Gm-Message-State: AOJu0Ywwo6d+CqAMZFv4Tn23gmcScR+6/TlacK5jnb75OcHGv16H+92m
 a09C0GuObB6bFCo4MOFMa2nuCgW3q8XXJuoYr7xpCvtO
X-Google-Smtp-Source: AGHT+IHp5BxJm6omQJPBqj9MFqb2PSpP8oQnrqlSnCBwOTOKESRjithvu1ess2KHgf8S03ZgBR/1IKfJB/b4IAyC7Qo=
X-Received: by 2002:a05:6870:be89:b0:1f5:ccc2:b21e with SMTP id
 nx9-20020a056870be8900b001f5ccc2b21emr24143583oab.41.1701267878668; Wed, 29
 Nov 2023 06:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20231129134629.1478602-1-tom.stdenis@amd.com>
In-Reply-To: <20231129134629.1478602-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Nov 2023 09:24:27 -0500
Message-ID: <CADnq5_MBxsOnQsk6vFe2ijmaLMJz_DTZ07wAvWgrMBodALibnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add SMUIO headers for 10.0.2
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 29, 2023 at 9:22=E2=80=AFAM Tom St Denis <tom.stdenis@amd.com> =
wrote:
>
> These were requested by a UMR user for debugging purposes.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../asic_reg/smuio/smuio_10_0_2_offset.h      | 102 ++++++++++
>  .../asic_reg/smuio/smuio_10_0_2_sh_mask.h     | 184 ++++++++++++++++++
>  2 files changed, 286 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0=
_2_offset.h
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0=
_2_sh_mask.h
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offs=
et.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h
> new file mode 100644
> index 000000000000..a4dd372c0541
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright (C) 2023  Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIA=
BILITY, WHETHER IN
> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFT=
WARE.
> + */
> +#ifndef _smuio_10_0_2_OFFSET_HEADER
> +
> +// addressBlock: smuio_smuio_misc_SmuSmuioDec
> +// base address: 0x5a000
> +#define mmSMUIO_MCM_CONFIG                                              =
                               0x0023
> +#define mmSMUIO_MCM_CONFIG_BASE_IDX                                     =
                               0
> +#define mmIP_DISCOVERY_VERSION                                          =
                               0x0000
> +#define mmIP_DISCOVERY_VERSION_BASE_IDX                                 =
                               1
> +#define mmIO_SMUIO_PINSTRAP                                             =
                               0x01b1
> +#define mmIO_SMUIO_PINSTRAP_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER0                                             =
                               0x01b2
> +#define mmSCRATCH_REGISTER0_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER1                                             =
                               0x01b3
> +#define mmSCRATCH_REGISTER1_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER2                                             =
                               0x01b4
> +#define mmSCRATCH_REGISTER2_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER3                                             =
                               0x01b5
> +#define mmSCRATCH_REGISTER3_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER4                                             =
                               0x01b6
> +#define mmSCRATCH_REGISTER4_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER5                                             =
                               0x01b7
> +#define mmSCRATCH_REGISTER5_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER6                                             =
                               0x01b8
> +#define mmSCRATCH_REGISTER6_BASE_IDX                                    =
                               1
> +#define mmSCRATCH_REGISTER7                                             =
                               0x01b9
> +#define mmSCRATCH_REGISTER7_BASE_IDX                                    =
                               1
> +
> +
> +// addressBlock: smuio_smuio_reset_SmuSmuioDec
> +// base address: 0x5a300
> +#define mmSMUIO_MP_RESET_INTR                                           =
                               0x00c1
> +#define mmSMUIO_MP_RESET_INTR_BASE_IDX                                  =
                               0
> +#define mmSMUIO_SOC_HALT                                                =
                               0x00c2
> +#define mmSMUIO_SOC_HALT_BASE_IDX                                       =
                               0
> +#define mmSMUIO_GFX_MISC_CNTL                                           =
                               0x00c8
> +#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                  =
                               0
> +
> +
> +// addressBlock: smuio_smuio_ccxctrl_SmuSmuioDec
> +// base address: 0x5a000
> +#define mmPWROK_REFCLK_GAP_CYCLES                                       =
                               0x0001
> +#define mmPWROK_REFCLK_GAP_CYCLES_BASE_IDX                              =
                               1
> +#define mmGOLDEN_TSC_INCREMENT_UPPER                                    =
                               0x0004
> +#define mmGOLDEN_TSC_INCREMENT_UPPER_BASE_IDX                           =
                               1
> +#define mmGOLDEN_TSC_INCREMENT_LOWER                                    =
                               0x0005
> +#define mmGOLDEN_TSC_INCREMENT_LOWER_BASE_IDX                           =
                               1
> +#define mmGOLDEN_TSC_COUNT_UPPER                                        =
                               0x0025
> +#define mmGOLDEN_TSC_COUNT_UPPER_BASE_IDX                               =
                               1
> +#define mmGOLDEN_TSC_COUNT_LOWER                                        =
                               0x0026
> +#define mmGOLDEN_TSC_COUNT_LOWER_BASE_IDX                               =
                               1
> +#define mmGFX_GOLDEN_TSC_SHADOW_UPPER                                   =
                               0x0029
> +#define mmGFX_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                          =
                               1
> +#define mmGFX_GOLDEN_TSC_SHADOW_LOWER                                   =
                               0x002a
> +#define mmGFX_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                          =
                               1
> +#define mmSOC_GOLDEN_TSC_SHADOW_UPPER                                   =
                               0x002b
> +#define mmSOC_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                          =
                               1
> +#define mmSOC_GOLDEN_TSC_SHADOW_LOWER                                   =
                               0x002c
> +#define mmSOC_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                          =
                               1
> +#define mmSOC_GAP_PWROK                                                 =
                               0x002d
> +#define mmSOC_GAP_PWROK_BASE_IDX                                        =
                               1
> +
> +// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
> +// base address: 0x5ac40
> +#define mmPWR_VIRT_RESET_REQ                                            =
                               0x0110
> +#define mmPWR_VIRT_RESET_REQ_BASE_IDX                                   =
                               1
> +#define mmPWR_DISP_TIMER_CONTROL                                        =
                               0x0111
> +#define mmPWR_DISP_TIMER_CONTROL_BASE_IDX                               =
                               1
> +#define mmPWR_DISP_TIMER2_CONTROL                                       =
                               0x0113
> +#define mmPWR_DISP_TIMER2_CONTROL_BASE_IDX                              =
                               1
> +#define mmPWR_DISP_TIMER_GLOBAL_CONTROL                                 =
                               0x0115
> +#define mmPWR_DISP_TIMER_GLOBAL_CONTROL_BASE_IDX                        =
                               1
> +#define mmPWR_IH_CONTROL                                                =
                               0x0116
> +#define mmPWR_IH_CONTROL_BASE_IDX                                       =
                               1
> +
> +// addressBlock: smuio_smuio_svi0_SmuSmuioDec
> +// base address: 0x6f000
> +#define mmSMUSVI0_TEL_PLANE0                                            =
                               0x520e
> +#define mmSMUSVI0_TEL_PLANE0_BASE_IDX                                   =
                               1
> +#define mmSMUSVI0_PLANE0_CURRENTVID                                     =
                               0x5217
> +#define mmSMUSVI0_PLANE0_CURRENTVID_BASE_IDX                            =
                               1
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_m=
ask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h
> new file mode 100644
> index 000000000000..d10ae61c346b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h
> @@ -0,0 +1,184 @@
> +/*
> + * Copyright (C) 2023  Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> + * in all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> + * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIA=
BILITY, WHETHER IN
> + * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFT=
WARE.
> + */
> +#ifndef _smuio_10_0_2_SH_MASK_HEADER
> +
> +// addressBlock: smuio_smuio_misc_SmuSmuioDec
> +//SMUIO_MCM_CONFIG
> +#define SMUIO_MCM_CONFIG__DIE_ID__SHIFT                                 =
                                      0x0
> +#define SMUIO_MCM_CONFIG__PKG_TYPE__SHIFT                               =
                                      0x2
> +#define SMUIO_MCM_CONFIG__SOCKET_ID__SHIFT                              =
                                      0x5
> +#define SMUIO_MCM_CONFIG__PKG_SUBTYPE__SHIFT                            =
                                      0x6
> +#define SMUIO_MCM_CONFIG__CONSOLE_K__SHIFT                              =
                                      0x10
> +#define SMUIO_MCM_CONFIG__CONSOLE_A__SHIFT                              =
                                      0x11
> +#define SMUIO_MCM_CONFIG__DIE_ID_MASK                                   =
                                      0x00000003L
> +#define SMUIO_MCM_CONFIG__PKG_TYPE_MASK                                 =
                                      0x0000001CL
> +#define SMUIO_MCM_CONFIG__SOCKET_ID_MASK                                =
                                      0x00000020L
> +#define SMUIO_MCM_CONFIG__PKG_SUBTYPE_MASK                              =
                                      0x000000C0L
> +#define SMUIO_MCM_CONFIG__CONSOLE_K_MASK                                =
                                      0x00010000L
> +#define SMUIO_MCM_CONFIG__CONSOLE_A_MASK                                =
                                      0x00020000L
> +//IP_DISCOVERY_VERSION
> +#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION__SHIFT               =
                                      0x0
> +#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION_MASK                 =
                                      0xFFFFFFFFL
> +//IO_SMUIO_PINSTRAP
> +#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN__SHIFT                         =
                                      0x0
> +#define IO_SMUIO_PINSTRAP__AUD__SHIFT                                   =
                                      0x3
> +#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN_MASK                           =
                                      0x00000007L
> +#define IO_SMUIO_PINSTRAP__AUD_MASK                                     =
                                      0x00000018L
> +//SCRATCH_REGISTER0
> +#define SCRATCH_REGISTER0__ScratchPad0__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER0__ScratchPad0_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER1
> +#define SCRATCH_REGISTER1__ScratchPad1__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER1__ScratchPad1_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER2
> +#define SCRATCH_REGISTER2__ScratchPad2__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER2__ScratchPad2_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER3
> +#define SCRATCH_REGISTER3__ScratchPad3__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER3__ScratchPad3_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER4
> +#define SCRATCH_REGISTER4__ScratchPad4__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER4__ScratchPad4_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER5
> +#define SCRATCH_REGISTER5__ScratchPad5__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER5__ScratchPad5_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER6
> +#define SCRATCH_REGISTER6__ScratchPad6__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER6__ScratchPad6_MASK                             =
                                      0xFFFFFFFFL
> +//SCRATCH_REGISTER7
> +#define SCRATCH_REGISTER7__ScratchPad7__SHIFT                           =
                                      0x0
> +#define SCRATCH_REGISTER7__ScratchPad7_MASK                             =
                                      0xFFFFFFFFL
> +
> +// addressBlock: smuio_smuio_reset_SmuSmuioDec
> +//SMUIO_MP_RESET_INTR
> +#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR__SHIFT                 =
                                      0x0
> +#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR_MASK                   =
                                      0x00000001L
> +//SMUIO_SOC_HALT
> +#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN__SHIFT                       =
                                      0x2
> +#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN__SHIFT                      =
                                      0x3
> +#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN_MASK                         =
                                      0x00000004L
> +#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN_MASK                        =
                                      0x00000008L
> +//SMUIO_GFX_MISC_CNTL
> +#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff__SHIFT              =
                                      0x0
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                   =
                                      0x1
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFX_DLDO_CLK_SWITCH__SHIFT             =
                                      0x3
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFX_RLC_CGPG_EN__SHIFT                 =
                                      0x4
> +#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK                =
                                      0x00000001L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                     =
                                      0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFX_DLDO_CLK_SWITCH_MASK               =
                                      0x00000008L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFX_RLC_CGPG_EN_MASK                   =
                                      0x00000010L
> +
> +// addressBlock: smuio_smuio_ccxctrl_SmuSmuioDec
> +//PWROK_REFCLK_GAP_CYCLES
> +#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PreAssertion_clkgap_cycles__SHIFT=
                                      0x0
> +#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PostAssertion_clkgap_cycles__SHIF=
T                                     0x8
> +#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PreAssertion_clkgap_cycles_MASK  =
                                      0x000000FFL
> +#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PostAssertion_clkgap_cycles_MASK =
                                      0x0000FF00L
> +//GOLDEN_TSC_INCREMENT_UPPER
> +#define GOLDEN_TSC_INCREMENT_UPPER__GoldenTscIncrementUpper__SHIFT      =
                                      0x0
> +#define GOLDEN_TSC_INCREMENT_UPPER__GoldenTscIncrementUpper_MASK        =
                                      0x00FFFFFFL
> +//GOLDEN_TSC_INCREMENT_LOWER
> +#define GOLDEN_TSC_INCREMENT_LOWER__GoldenTscIncrementLower__SHIFT      =
                                      0x0
> +#define GOLDEN_TSC_INCREMENT_LOWER__GoldenTscIncrementLower_MASK        =
                                      0xFFFFFFFFL
> +//GOLDEN_TSC_COUNT_UPPER
> +#define GOLDEN_TSC_COUNT_UPPER__GoldenTscCountUpper__SHIFT              =
                                      0x0
> +#define GOLDEN_TSC_COUNT_UPPER__GoldenTscCountUpper_MASK                =
                                      0x00FFFFFFL
> +//GOLDEN_TSC_COUNT_LOWER
> +#define GOLDEN_TSC_COUNT_LOWER__GoldenTscCountLower__SHIFT              =
                                      0x0
> +#define GOLDEN_TSC_COUNT_LOWER__GoldenTscCountLower_MASK                =
                                      0xFFFFFFFFL
> +//GFX_GOLDEN_TSC_SHADOW_UPPER
> +#define GFX_GOLDEN_TSC_SHADOW_UPPER__GfxGoldenTscShadowUpper__SHIFT     =
                                      0x0
> +#define GFX_GOLDEN_TSC_SHADOW_UPPER__GfxGoldenTscShadowUpper_MASK       =
                                      0x00FFFFFFL
> +//GFX_GOLDEN_TSC_SHADOW_LOWER
> +#define GFX_GOLDEN_TSC_SHADOW_LOWER__GfxGoldenTscShadowLower__SHIFT     =
                                      0x0
> +#define GFX_GOLDEN_TSC_SHADOW_LOWER__GfxGoldenTscShadowLower_MASK       =
                                      0xFFFFFFFFL
> +//SOC_GOLDEN_TSC_SHADOW_UPPER
> +#define SOC_GOLDEN_TSC_SHADOW_UPPER__SocGoldenTscShadowUpper__SHIFT     =
                                      0x0
> +#define SOC_GOLDEN_TSC_SHADOW_UPPER__SocGoldenTscShadowUpper_MASK       =
                                      0x00FFFFFFL
> +//SOC_GOLDEN_TSC_SHADOW_LOWER
> +#define SOC_GOLDEN_TSC_SHADOW_LOWER__SocGoldenTscShadowLower__SHIFT     =
                                      0x0
> +#define SOC_GOLDEN_TSC_SHADOW_LOWER__SocGoldenTscShadowLower_MASK       =
                                      0xFFFFFFFFL
> +//SOC_GAP_PWROK
> +#define SOC_GAP_PWROK__soc_gap_pwrok__SHIFT                             =
                                      0x0
> +#define SOC_GAP_PWROK__soc_gap_pwrok_MASK                               =
                                      0x00000001L
> +
> +// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
> +//PWR_VIRT_RESET_REQ
> +#define PWR_VIRT_RESET_REQ__VF_FLR__SHIFT                               =
                                      0x0
> +#define PWR_VIRT_RESET_REQ__PF_FLR__SHIFT                               =
                                      0x1f
> +#define PWR_VIRT_RESET_REQ__VF_FLR_MASK                                 =
                                      0x7FFFFFFFL
> +#define PWR_VIRT_RESET_REQ__PF_FLR_MASK                                 =
                                      0x80000000L
> +//PWR_DISP_TIMER_CONTROL
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT__SHIFT             =
                                      0x0
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT            =
                                      0x19
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT           =
                                      0x1a
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK__SHIFT              =
                                      0x1b
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT           =
                                      0x1c
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE__SHIFT              =
                                      0x1d
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE__SHIFT              =
                                      0x1e
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT_MASK               =
                                      0x01FFFFFFL
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE_MASK              =
                                      0x02000000L
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE_MASK             =
                                      0x04000000L
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK_MASK                =
                                      0x08000000L
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK_MASK             =
                                      0x10000000L
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE_MASK                =
                                      0x20000000L
> +#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE_MASK                =
                                      0x40000000L
> +//PWR_DISP_TIMER2_CONTROL
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT__SHIFT            =
                                      0x0
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT           =
                                      0x19
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT          =
                                      0x1a
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK__SHIFT             =
                                      0x1b
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT          =
                                      0x1c
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE__SHIFT             =
                                      0x1d
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE__SHIFT             =
                                      0x1e
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT_MASK              =
                                      0x01FFFFFFL
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE_MASK             =
                                      0x02000000L
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE_MASK            =
                                      0x04000000L
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK_MASK               =
                                      0x08000000L
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK_MASK            =
                                      0x10000000L
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE_MASK               =
                                      0x20000000L
> +#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE_MASK               =
                                      0x40000000L
> +//PWR_DISP_TIMER_GLOBAL_CONTROL
> +#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH__SHIFT    =
                                      0x0
> +#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN__SHIFT       =
                                      0xa
> +#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH_MASK      =
                                      0x000003FFL
> +#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN_MASK         =
                                      0x00000400L
> +//PWR_IH_CONTROL
> +#define PWR_IH_CONTROL__MAX_CREDIT__SHIFT                               =
                                      0x0
> +#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK__SHIFT                  =
                                      0x5
> +#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK__SHIFT                 =
                                      0x6
> +#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN__SHIFT                       =
                                      0x1f
> +#define PWR_IH_CONTROL__MAX_CREDIT_MASK                                 =
                                      0x0000001FL
> +#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK_MASK                    =
                                      0x00000020L
> +#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK_MASK                   =
                                      0x00000040L
> +#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN_MASK                         =
                                      0x80000000L
> +
> +// addressBlock: smuio_smuio_svi0_SmuSmuioDec
> +//SMUSVI0_TEL_PLANE0
> +#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_IDDCOR__SHIFT                   =
                                      0x0
> +#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_VDDCOR__SHIFT                   =
                                      0x10
> +#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_IDDCOR_MASK                     =
                                      0x000000FFL
> +#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_VDDCOR_MASK                     =
                                      0x01FF0000L
> +//SMUSVI0_PLANE0_CURRENTVID
> +#define SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID__SHIFT       =
                                      0x18
> +#define SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID_MASK         =
                                      0xFF000000L
> +
> +#endif
> --
> 2.40.1
>
