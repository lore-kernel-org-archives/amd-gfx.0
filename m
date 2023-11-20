Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49929C2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 18:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEE610E117;
	Mon, 20 Nov 2023 18:51:21 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7B510E117
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 18:51:20 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f5eac85e0eso801902fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700506279; x=1701111079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAo1F1Ar4VU1q+bAPY4AjUS/NCxQ4Rf70LTJU+qz9s0=;
 b=fQRDOxFAytmWtXnmUXLPLLi5yvNOGiZFlTwYPoKXFlJU+dhqoz5k81KpbS2qh5Wk4R
 MLtrMT4HhpRnfkMBFmf4YS2JdEK8NVfWhmsYJK/P8MrCb8MBM42hVwpFvzreL9Q0go1s
 DECY2Pd4o45BTD1cb/eVttA7Trq/0FgqPeyrUkR6hcHeSACLwVNnp6qxF/nXiMCqy/7k
 dZXu1L6/DyplWFVHcQ3KIjRnQ6aovkI8qAk78YEASrPf6NL96fooYjBQRopmr9xXgZ6i
 m1T8hWHUIbsSDxVtaoj8WMbIaxoinM+Cq7ayFWZi3I84E497qHPHorMydgKHVbtJs/rF
 8uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700506279; x=1701111079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAo1F1Ar4VU1q+bAPY4AjUS/NCxQ4Rf70LTJU+qz9s0=;
 b=UY2A+2wf3O5MJPcCxSwv+y0sLDK81B1qkEQzbUK08f3rjozVA+JIKaj9U5pxNnGmzD
 dOqaaRPjmIvk4JNdHV7SinZplZLjkMlJaQcznRfnPLrtY9/d5i/f4wHl9cHtfnTw8kSB
 PDxn9LLNXrDR7v7qZJ4rzCSVAw1tipndMM78wJO2zbcXob7cZvyhP7s5KO+DX1IdLdSn
 IyaF2LxDrgypaEhTE7vwbRzSPnrCz3XpXU980DesyABtMK2p5zqlt6QGHn0NFtxi6AtD
 ino1sWD+1K9xom8u5YR3ckt5puMwAs7LIUXXCG/aadCpsoopjtrZYugdQ7ip153lyOgW
 3k2g==
X-Gm-Message-State: AOJu0YxHPmciLQG4raZ5OrUZxxVuBBXQI6WHplxygYwkNOklhtBz3oeC
 3c6fKaMJvUdAWJMFJcZdphhKtR3iN8DXCFdgSDc=
X-Google-Smtp-Source: AGHT+IEup6jBvhal0C1IxuDfxJEp3DDkho9VINscF9YcLhQzfudUDbVcgNIwWqKvLLtnmpTa6d0lgOMRBEfv9yYpBBw=
X-Received: by 2002:a05:6870:bf16:b0:1e9:8d7a:fc5b with SMTP id
 qh22-20020a056870bf1600b001e98d7afc5bmr8095977oab.47.1700506279161; Mon, 20
 Nov 2023 10:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20231118161321.18632-1-alex.sierra@amd.com>
In-Reply-To: <20231118161321.18632-1-alex.sierra@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Nov 2023 13:51:07 -0500
Message-ID: <CADnq5_Oe2KxOaKk6Dk3WC2wrHU7QUBdyugpQ-PBaeo7jhJ0c-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Force order between a read and write to the
 same address
To: Alex Sierra <alex.sierra@amd.com>
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
Cc: Felix.Kuehling@amd.com, joseph.greathouse@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Nov 18, 2023 at 1:12=E2=80=AFPM Alex Sierra <alex.sierra@amd.com> w=
rote:
>
> Setting register to force ordering to prevent read/write or write/read
> hazards for un-cached modes.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 22 +++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  8 +++++++
>  .../include/asic_reg/gc/gc_11_0_0_offset.h    |  2 ++
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 68747a52e5c2..592ac993f013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3193,7 +3193,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001f=
f, 0x00000000),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x0001002=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a0000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a0000=
0),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_sienna_cich=
lid[] =3D {
> @@ -3245,6 +3246,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_2[] =3D {
>
>         /* This is not in GDB yet. Don't remove it. It fixes a GPU hang o=
n Navy Flounder. */
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x000000=
20),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
=3D {
> @@ -3275,6 +3277,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_vangogh[] =3D {
>
>         /* This is not in GDB yet. Don't remove it. It fixes a GPU hang o=
n VanGogh. */
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x000000=
20),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_3[] =3D {
> @@ -3297,7 +3300,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_3[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xf=
fffffff, 0x00000800),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00=
000820),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =3D {
> @@ -3336,7 +3340,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_4[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x0001002=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x010300=
00),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a0000=
0),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x000000=
20)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x000000=
20),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_5[] =3D {
> @@ -3371,7 +3376,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_5[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001f=
f, 0x00000000),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001f=
f, 0x00000000),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a0000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a0000=
0),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillf=
ish[] =3D {
> @@ -3408,7 +3414,7 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_0_cyan_skillfish[] =3D
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x0000=
0130),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xff=
ffffff),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x00030008, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x0080000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x0080000=
0),
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_6[] =3D {
> @@ -3433,7 +3439,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_6[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x0000100=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x0001002=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  static const struct soc15_reg_golden golden_settings_gc_10_3_7[] =3D {
> @@ -3458,7 +3465,8 @@ static const struct soc15_reg_golden golden_setting=
s_gc_10_3_7[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x0000100=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0xffffff7f, 0x0001002=
0),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x010300=
00),
> -       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0)
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x0010000=
0),
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0x20000000, 0x20000000)
>  };
>
>  #define DEFAULT_SH_MEM_CONFIG \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index fd22943685f7..84decd069875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -89,6 +89,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
>
> +static const struct soc15_reg_golden golden_settings_gc_11_0[] =3D {
> +       SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000, 0x20000000=
)
> +};
> +
>  static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =3D
>  {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL, 0x9fff8fff=
, 0x00000010),
> @@ -303,6 +307,10 @@ static void gfx_v11_0_init_golden_registers(struct a=
mdgpu_device *adev)
>         default:
>                 break;
>         }
> +       soc15_program_register_sequence(adev,
> +                                       golden_settings_gc_11_0,
> +                                       (const u32)ARRAY_SIZE(golden_sett=
ings_gc_11_0));
> +
>  }
>
>  static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int en=
g_sel,
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> index c92c4b83253f..4bff1ef8a9a6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h
> @@ -6369,6 +6369,8 @@
>  #define regTCP_INVALIDATE_BASE_IDX                                      =
                                1
>  #define regTCP_STATUS                                                   =
                                0x19a1
>  #define regTCP_STATUS_BASE_IDX                                          =
                                1
> +#define regTCP_CNTL                                                     =
                                0x19a2
> +#define regTCP_CNTL_BASE_IDX                                            =
                                1
>  #define regTCP_CNTL2                                                    =
                                0x19a3
>  #define regTCP_CNTL2_BASE_IDX                                           =
                                1
>  #define regTCP_DEBUG_INDEX                                              =
                                0x19a5
> --
> 2.32.0
>
