Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91309EE49A5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2862C10E2B0;
	Mon, 21 Aug 2023 20:51:54 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756F010E2B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:51:52 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4dd644cf8so2511863fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692651111; x=1693255911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrjcG3ZfU0uJITSzYLl0N2W2NOSnV64Dj9raQyJDtKo=;
 b=drPWDJUSOvB3s22Dg3nNFJSwR6L3QJpQ9hcaC5ISceQrhAIEy/sHrWgOufxrNkONL7
 EB3p20OG4KIHVa9TcFOo5ciqXCo/n6Wi4tEmmfT18ArIfa7RcH77/KTpbzsjNbEbW89W
 slAk2RSjil8NMhFJmEU38DY4CGJduP/Ib3Nf28vMDe9Dnwl/2bJTWqN3Tr1RivdegDym
 gVL8pYdW+iB9zn6Tp6zJT8zvlRoY4Wfp9dXo4ugpAhUUFE/Ggvw5/o5cnPcMB6Mrj/m9
 kcjKo4cWYXAeoYUbGb46diXmImWCmW8riDXV61CzC8ekYSv+1FsconcCrwoHeDxP/ay6
 FI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692651111; x=1693255911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrjcG3ZfU0uJITSzYLl0N2W2NOSnV64Dj9raQyJDtKo=;
 b=WUrUjSNbRnafk0ccxyvGaedClNNHoFloHdwtTIeGY0vVPRVj0uwqPaba0uSI6AWO2C
 3J80ClPgWxMVlEYSZtRRepZAK4/IJoHEJmtZvkTbY003Z8e5FRQsYMf6Thsn65WhErkn
 jwj+Oy6Mo+u92/6+T92BB1mTl0xbjIPW0wWctvg0FUBxc6+DnoSNYVWpx7jRrvzDUlVM
 AThrvkd8pD8KRrdOTc6OxhCyRQr2YQXfQMXzMZV/xKzRIAwdjQdElEqCsCnLl3H8jmt8
 XL5PzoiHxsWtxi0hZn6pNhUCgvwfJTGMm9t/qOF+YXMjxKpEYzdI6Tt7XbU7QmZqrY3k
 RpXA==
X-Gm-Message-State: AOJu0YwUsbhATcULXXPTnWbDvgjU1WPFAhsbSiLCCIluiV4ePomx7er+
 Me+rJ0LwzR2QTXMhizM0L+BuAHGXbnRFLRi39XgA/PBX
X-Google-Smtp-Source: AGHT+IFLCdGzQJ6ONojZLpuab9XEpbczH4XCKEdNg7sABk4Gpm3kLLCj7OPFpZoZo2PlAkOg2NAZeIyvBG3AWMan6ZM=
X-Received: by 2002:a05:6871:707:b0:1bf:4a66:d54f with SMTP id
 f7-20020a056871070700b001bf4a66d54fmr10600953oap.56.1692651111676; Mon, 21
 Aug 2023 13:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230821063255.628681-1-evan.quan@amd.com>
In-Reply-To: <20230821063255.628681-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Aug 2023 16:51:40 -0400
Message-ID: <CADnq5_O0R7N7UUkUB5NhSWC=r4=sSKKM5nk5+ZAO6sgaz6N9Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fulfill the support for SMU13
 `pp_dpm_dcefclk` interface
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Guan Yu <guan.yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Aug 21, 2023 at 3:10=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote=
:
>
> Fulfill the incomplete SMU13 `pp_dpm_dcefclk` implementation.
>
> Reported-by: Guan Yu <guan.yu@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 27 +++++++++++++++++++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 27 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index bd0d5f027cac..5fdb2b3c042a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -176,6 +176,7 @@ static struct cmn2asic_mapping smu_v13_0_0_clk_map[SM=
U_CLK_COUNT] =3D {
>         CLK_MAP(VCLK1,          PPCLK_VCLK_1),
>         CLK_MAP(DCLK,           PPCLK_DCLK_0),
>         CLK_MAP(DCLK1,          PPCLK_DCLK_1),
> +       CLK_MAP(DCEFCLK,        PPCLK_DCFCLK),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_=
COUNT] =3D {
> @@ -707,6 +708,22 @@ static int smu_v13_0_0_set_default_dpm_table(struct =
smu_context *smu)
>                 pcie_table->num_of_link_levels++;
>         }
>
> +       /* dcefclk dpm table setup */
> +       dpm_table =3D &dpm_context->dpm_tables.dcef_table;
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
> +               ret =3D smu_v13_0_set_single_dpm_table(smu,
> +                                                    SMU_DCEFCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dpm_table->count =3D 1;
> +               dpm_table->dpm_levels[0].value =3D smu->smu_table.boot_va=
lues.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled =3D true;
> +               dpm_table->min =3D dpm_table->dpm_levels[0].value;
> +               dpm_table->max =3D dpm_table->dpm_levels[0].value;
> +       }
> +
>         return 0;
>  }
>
> @@ -794,6 +811,9 @@ static int smu_v13_0_0_get_smu_metrics_data(struct sm=
u_context *smu,
>         case METRICS_CURR_FCLK:
>                 *value =3D metrics->CurrClock[PPCLK_FCLK];
>                 break;
> +       case METRICS_CURR_DCEFCLK:
> +               *value =3D metrics->CurrClock[PPCLK_DCFCLK];
> +               break;
>         case METRICS_AVERAGE_GFXCLK:
>                 if (metrics->AverageGfxActivity <=3D SMU_13_0_0_BUSY_THRE=
SHOLD)
>                         *value =3D metrics->AverageGfxclkFrequencyPostDs;
> @@ -1047,6 +1067,9 @@ static int smu_v13_0_0_get_current_clk_freq_by_tabl=
e(struct smu_context *smu,
>         case PPCLK_DCLK_1:
>                 member_type =3D METRICS_AVERAGE_DCLK1;
>                 break;
> +       case PPCLK_DCFCLK:
> +               member_type =3D METRICS_CURR_DCEFCLK;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1196,6 +1219,9 @@ static int smu_v13_0_0_print_clk_levels(struct smu_=
context *smu,
>         case SMU_DCLK1:
>                 single_dpm_table =3D &(dpm_context->dpm_tables.dclk_table=
);
>                 break;
> +       case SMU_DCEFCLK:
> +               single_dpm_table =3D &(dpm_context->dpm_tables.dcef_table=
);
> +               break;
>         default:
>                 break;
>         }
> @@ -1209,6 +1235,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_=
context *smu,
>         case SMU_VCLK1:
>         case SMU_DCLK:
>         case SMU_DCLK1:
> +       case SMU_DCEFCLK:
>                 ret =3D smu_v13_0_0_get_current_clk_freq_by_table(smu, cl=
k_type, &curr_freq);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Failed to get current cl=
ock freq!");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index e54a6efc4fb5..d289662f4223 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -147,6 +147,7 @@ static struct cmn2asic_mapping smu_v13_0_7_clk_map[SM=
U_CLK_COUNT] =3D {
>         CLK_MAP(VCLK1,          PPCLK_VCLK_1),
>         CLK_MAP(DCLK,           PPCLK_DCLK_0),
>         CLK_MAP(DCLK1,          PPCLK_DCLK_1),
> +       CLK_MAP(DCEFCLK,        PPCLK_DCFCLK),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_=
COUNT] =3D {
> @@ -696,6 +697,22 @@ static int smu_v13_0_7_set_default_dpm_table(struct =
smu_context *smu)
>                 pcie_table->num_of_link_levels++;
>         }
>
> +       /* dcefclk dpm table setup */
> +       dpm_table =3D &dpm_context->dpm_tables.dcef_table;
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCN_BIT)) {
> +               ret =3D smu_v13_0_set_single_dpm_table(smu,
> +                                                    SMU_DCEFCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dpm_table->count =3D 1;
> +               dpm_table->dpm_levels[0].value =3D smu->smu_table.boot_va=
lues.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled =3D true;
> +               dpm_table->min =3D dpm_table->dpm_levels[0].value;
> +               dpm_table->max =3D dpm_table->dpm_levels[0].value;
> +       }
> +
>         return 0;
>  }
>
> @@ -777,6 +794,9 @@ static int smu_v13_0_7_get_smu_metrics_data(struct sm=
u_context *smu,
>         case METRICS_CURR_FCLK:
>                 *value =3D metrics->CurrClock[PPCLK_FCLK];
>                 break;
> +       case METRICS_CURR_DCEFCLK:
> +               *value =3D metrics->CurrClock[PPCLK_DCFCLK];
> +               break;
>         case METRICS_AVERAGE_GFXCLK:
>                 *value =3D metrics->AverageGfxclkFrequencyPreDs;
>                 break;
> @@ -1027,6 +1047,9 @@ static int smu_v13_0_7_get_current_clk_freq_by_tabl=
e(struct smu_context *smu,
>         case PPCLK_DCLK_1:
>                 member_type =3D METRICS_CURR_DCLK1;
>                 break;
> +       case PPCLK_DCFCLK:
> +               member_type =3D METRICS_CURR_DCEFCLK;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -1176,6 +1199,9 @@ static int smu_v13_0_7_print_clk_levels(struct smu_=
context *smu,
>         case SMU_DCLK1:
>                 single_dpm_table =3D &(dpm_context->dpm_tables.dclk_table=
);
>                 break;
> +       case SMU_DCEFCLK:
> +               single_dpm_table =3D &(dpm_context->dpm_tables.dcef_table=
);
> +               break;
>         default:
>                 break;
>         }
> @@ -1189,6 +1215,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_=
context *smu,
>         case SMU_VCLK1:
>         case SMU_DCLK:
>         case SMU_DCLK1:
> +       case SMU_DCEFCLK:
>                 ret =3D smu_v13_0_7_get_current_clk_freq_by_table(smu, cl=
k_type, &curr_freq);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Failed to get current cl=
ock freq!");
> --
> 2.34.1
>
