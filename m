Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5F4C00528
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 16:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E0C89DFB;
	Mon,  7 Aug 2023 16:11:22 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465D489DFB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 16:11:20 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-56c74961e0cso3260115eaf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Aug 2023 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691424679; x=1692029479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdSWsT07AZG0/L3n76ph6hfjwaYcimjeP9wA12HW+LM=;
 b=I0JZ0dploidIFdNf9mlosoDMaPAS+0LdEmyoc8qa9iGNxZD9W5UIlgLCRReEaDYT10
 IjvoUJlD0W+AreDUbB+HH9gx0lrXmU2ylaK+HkckTxYk6lqDh+Oh7Ahm804y4bEa05xu
 UPFnspceKzEAiMunUYi8INsDzl130UR/mlJQeIFUxIFdAvqu723YOjUOR8EkbOIrSfh1
 NZIiQuYOxUg1iIMDrpsfHIqWoE8vxwc2Q/fQZT4RslMxW/TcK/NBjJx+yu5wBNrEzCCk
 vlqIqspEZulEj76GTnVmoLui2xf666cOxNWPxqvL9IbyWgA+0GEC0ZhSKUTz0B906MdC
 IsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424679; x=1692029479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdSWsT07AZG0/L3n76ph6hfjwaYcimjeP9wA12HW+LM=;
 b=V8l7YSSEDzbStLD+mn+oS/YWFsG8cmAifao5MSjcT0Aa7EkhZEfYVcpppCELgU60oy
 vrqAP8CXFzoIejDiblE1ZDx9Jka7UQnxZD4xJgiqtK2uODHY4DFFksckHneiOshYjPAO
 UQxA8MaJPnYaVO1BaGtTeRHsC8iNS2GJMBjR5G0xratgUl5zuj0Fr8fJV2mRjAna6I2a
 jBq7URAk48tniNu7odTbhmw5d/TBvl22ILQmF6422zPyhiODl0mJS/fL9NvYjtoWPfv4
 Q5RnwVt4CkFg4zWVjRKcX17qjZTj3PJzqPHk+fWCSURN+uA3ZRBulIu3rMVcINAh0IdQ
 Nsuw==
X-Gm-Message-State: AOJu0YzhEFU/mYy7DnJTTBJyXf5coUdANB74UAIDaCCezHKtFl79KdzV
 FfC72H4D/c8jnG+b5L5lVh+BeiONXPycMlKYbs8Rltx5
X-Google-Smtp-Source: AGHT+IFOnQI73P9g9buT0KrxWsCmHlzAgKi9Wz7DzQpgMMaGHusVnSfBb3F8mLNB9dNBkAeH05NO99CJbJVqBgcALoU=
X-Received: by 2002:a4a:3c5e:0:b0:56c:7120:835f with SMTP id
 p30-20020a4a3c5e000000b0056c7120835fmr8538671oof.5.1691424679231; Mon, 07 Aug
 2023 09:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803013559.506617-1-evan.quan@amd.com>
 <20230803013559.506617-2-evan.quan@amd.com>
In-Reply-To: <20230803013559.506617-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:11:08 -0400
Message-ID: <CADnq5_OQwY_53-sfkdw9j6zYr-_AW-JWe8A4LdmAzgGnjvtvUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: correct the logics for retreiving SMU13
 OD setting limits
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Aug 2, 2023 at 9:36=E2=80=AFPM Evan Quan <evan.quan@amd.com> wrote:
>
> To better meet the growing demainds for more OD features.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 70 +++++++++----------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 70 +++++++++----------
>  2 files changed, 64 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 2570e03e0fa7..f636a127983a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -97,6 +97,12 @@
>   */
>  #define SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
>
> +#define PP_OD_FEATURE_GFXCLK_FMIN                      0
> +#define PP_OD_FEATURE_GFXCLK_FMAX                      1
> +#define PP_OD_FEATURE_UCLK_FMIN                                2
> +#define PP_OD_FEATURE_UCLK_FMAX                                3
> +#define PP_OD_FEATURE_GFX_VF_CURVE                     4
> +
>  static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion, =
              1),
> @@ -1044,7 +1050,6 @@ static bool smu_v13_0_0_is_od_feature_supported(str=
uct smu_context *smu,
>
>  static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
>                                               int od_feature_bit,
> -                                             bool lower_boundary,
>                                               int32_t *min,
>                                               int32_t *max)
>  {
> @@ -1056,29 +1061,28 @@ static void smu_v13_0_0_get_od_setting_limits(str=
uct smu_context *smu,
>         int32_t od_min_setting, od_max_setting;
>
>         switch (od_feature_bit) {
> -       case PP_OD_FEATURE_GFXCLK_BIT:
> -               if (lower_boundary) {
> -                       od_min_setting =3D overdrive_lowerlimits->GfxclkF=
min;
> -                       od_max_setting =3D overdrive_upperlimits->GfxclkF=
min;
> -               } else {
> -                       od_min_setting =3D overdrive_lowerlimits->GfxclkF=
max;
> -                       od_max_setting =3D overdrive_upperlimits->GfxclkF=
max;
> -               }
> +       case PP_OD_FEATURE_GFXCLK_FMIN:
> +               od_min_setting =3D overdrive_lowerlimits->GfxclkFmin;
> +               od_max_setting =3D overdrive_upperlimits->GfxclkFmin;
>                 break;
> -       case PP_OD_FEATURE_UCLK_BIT:
> -               if (lower_boundary) {
> -                       od_min_setting =3D overdrive_lowerlimits->UclkFmi=
n;
> -                       od_max_setting =3D overdrive_upperlimits->UclkFmi=
n;
> -               } else {
> -                       od_min_setting =3D overdrive_lowerlimits->UclkFma=
x;
> -                       od_max_setting =3D overdrive_upperlimits->UclkFma=
x;
> -               }
> +       case PP_OD_FEATURE_GFXCLK_FMAX:
> +               od_min_setting =3D overdrive_lowerlimits->GfxclkFmax;
> +               od_max_setting =3D overdrive_upperlimits->GfxclkFmax;
> +               break;
> +       case PP_OD_FEATURE_UCLK_FMIN:
> +               od_min_setting =3D overdrive_lowerlimits->UclkFmin;
> +               od_max_setting =3D overdrive_upperlimits->UclkFmin;
> +               break;
> +       case PP_OD_FEATURE_UCLK_FMAX:
> +               od_min_setting =3D overdrive_lowerlimits->UclkFmax;
> +               od_max_setting =3D overdrive_upperlimits->UclkFmax;
>                 break;
> -       case PP_OD_FEATURE_GFX_VF_CURVE_BIT:
> +       case PP_OD_FEATURE_GFX_VF_CURVE:
>                 od_min_setting =3D overdrive_lowerlimits->VoltageOffsetPe=
rZoneBoundary;
>                 od_max_setting =3D overdrive_upperlimits->VoltageOffsetPe=
rZoneBoundary;
>                 break;
>         default:
> +               od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
>         }
>
> @@ -1305,13 +1309,11 @@ static int smu_v13_0_0_print_clk_levels(struct sm=
u_context *smu,
>
>                 if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATUR=
E_GFXCLK_BIT)) {
>                         smu_v13_0_0_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_G=
FXCLK_FMIN,
>                                                           &min_value,
>                                                           NULL);
>                         smu_v13_0_0_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_BIT,
> -                                                         false,
> +                                                         PP_OD_FEATURE_G=
FXCLK_FMAX,
>                                                           NULL,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz =
%10uMhz\n",
> @@ -1320,13 +1322,11 @@ static int smu_v13_0_0_print_clk_levels(struct sm=
u_context *smu,
>
>                 if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATUR=
E_UCLK_BIT)) {
>                         smu_v13_0_0_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_U=
CLK_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_U=
CLK_FMIN,
>                                                           &min_value,
>                                                           NULL);
>                         smu_v13_0_0_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_U=
CLK_BIT,
> -                                                         false,
> +                                                         PP_OD_FEATURE_U=
CLK_FMAX,
>                                                           NULL,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "MCLK: %7uMhz =
%10uMhz\n",
> @@ -1335,8 +1335,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_=
context *smu,
>
>                 if (smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATUR=
E_GFX_VF_CURVE_BIT)) {
>                         smu_v13_0_0_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FX_VF_CURVE_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_G=
FX_VF_CURVE,
>                                                           &min_value,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "VDDC_CURVE: %=
7dmv %10dmv\n",
> @@ -1381,8 +1380,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu=
_context *smu,
>                         switch (input[i]) {
>                         case 0:
>                                 smu_v13_0_0_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_BIT,
> -                                                                 true,
> +                                                                 PP_OD_F=
EATURE_GFXCLK_FMIN,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1398,8 +1396,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu=
_context *smu,
>
>                         case 1:
>                                 smu_v13_0_0_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_BIT,
> -                                                                 false,
> +                                                                 PP_OD_F=
EATURE_GFXCLK_FMAX,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1444,8 +1441,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu=
_context *smu,
>                         switch (input[i]) {
>                         case 0:
>                                 smu_v13_0_0_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_UCLK_BIT,
> -                                                                 true,
> +                                                                 PP_OD_F=
EATURE_UCLK_FMIN,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1461,8 +1457,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu=
_context *smu,
>
>                         case 1:
>                                 smu_v13_0_0_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_UCLK_BIT,
> -                                                                 false,
> +                                                                 PP_OD_F=
EATURE_UCLK_FMAX,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1503,8 +1498,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu=
_context *smu,
>                         return -EINVAL;
>
>                 smu_v13_0_0_get_od_setting_limits(smu,
> -                                                 PP_OD_FEATURE_GFX_VF_CU=
RVE_BIT,
> -                                                 true,
> +                                                 PP_OD_FEATURE_GFX_VF_CU=
RVE,
>                                                   &minimum,
>                                                   &maximum);
>                 if (input[1] < minimum ||
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index aa381991dede..708d977103ed 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -72,6 +72,12 @@
>
>  #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE  0x4000
>
> +#define PP_OD_FEATURE_GFXCLK_FMIN                      0
> +#define PP_OD_FEATURE_GFXCLK_FMAX                      1
> +#define PP_OD_FEATURE_UCLK_FMIN                                2
> +#define PP_OD_FEATURE_UCLK_FMAX                                3
> +#define PP_OD_FEATURE_GFX_VF_CURVE                     4
> +
>  static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_C=
OUNT] =3D {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,   =
              1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion, =
              1),
> @@ -1034,7 +1040,6 @@ static bool smu_v13_0_7_is_od_feature_supported(str=
uct smu_context *smu,
>
>  static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
>                                               int od_feature_bit,
> -                                             bool lower_boundary,
>                                               int32_t *min,
>                                               int32_t *max)
>  {
> @@ -1046,29 +1051,28 @@ static void smu_v13_0_7_get_od_setting_limits(str=
uct smu_context *smu,
>         int32_t od_min_setting, od_max_setting;
>
>         switch (od_feature_bit) {
> -       case PP_OD_FEATURE_GFXCLK_BIT:
> -               if (lower_boundary) {
> -                       od_min_setting =3D overdrive_lowerlimits->GfxclkF=
min;
> -                       od_max_setting =3D overdrive_upperlimits->GfxclkF=
min;
> -               } else {
> -                       od_min_setting =3D overdrive_lowerlimits->GfxclkF=
max;
> -                       od_max_setting =3D overdrive_upperlimits->GfxclkF=
max;
> -               }
> +       case PP_OD_FEATURE_GFXCLK_FMIN:
> +               od_min_setting =3D overdrive_lowerlimits->GfxclkFmin;
> +               od_max_setting =3D overdrive_upperlimits->GfxclkFmin;
>                 break;
> -       case PP_OD_FEATURE_UCLK_BIT:
> -               if (lower_boundary) {
> -                       od_min_setting =3D overdrive_lowerlimits->UclkFmi=
n;
> -                       od_max_setting =3D overdrive_upperlimits->UclkFmi=
n;
> -               } else {
> -                       od_min_setting =3D overdrive_lowerlimits->UclkFma=
x;
> -                       od_max_setting =3D overdrive_upperlimits->UclkFma=
x;
> -               }
> +       case PP_OD_FEATURE_GFXCLK_FMAX:
> +               od_min_setting =3D overdrive_lowerlimits->GfxclkFmax;
> +               od_max_setting =3D overdrive_upperlimits->GfxclkFmax;
> +               break;
> +       case PP_OD_FEATURE_UCLK_FMIN:
> +               od_min_setting =3D overdrive_lowerlimits->UclkFmin;
> +               od_max_setting =3D overdrive_upperlimits->UclkFmin;
> +               break;
> +       case PP_OD_FEATURE_UCLK_FMAX:
> +               od_min_setting =3D overdrive_lowerlimits->UclkFmax;
> +               od_max_setting =3D overdrive_upperlimits->UclkFmax;
>                 break;
> -       case PP_OD_FEATURE_GFX_VF_CURVE_BIT:
> +       case PP_OD_FEATURE_GFX_VF_CURVE:
>                 od_min_setting =3D overdrive_lowerlimits->VoltageOffsetPe=
rZoneBoundary;
>                 od_max_setting =3D overdrive_upperlimits->VoltageOffsetPe=
rZoneBoundary;
>                 break;
>         default:
> +               od_min_setting =3D od_max_setting =3D INT_MAX;
>                 break;
>         }
>
> @@ -1294,13 +1298,11 @@ static int smu_v13_0_7_print_clk_levels(struct sm=
u_context *smu,
>
>                 if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATUR=
E_GFXCLK_BIT)) {
>                         smu_v13_0_7_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_G=
FXCLK_FMIN,
>                                                           &min_value,
>                                                           NULL);
>                         smu_v13_0_7_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FXCLK_BIT,
> -                                                         false,
> +                                                         PP_OD_FEATURE_G=
FXCLK_FMAX,
>                                                           NULL,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "SCLK: %7uMhz =
%10uMhz\n",
> @@ -1309,13 +1311,11 @@ static int smu_v13_0_7_print_clk_levels(struct sm=
u_context *smu,
>
>                 if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATUR=
E_UCLK_BIT)) {
>                         smu_v13_0_7_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_U=
CLK_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_U=
CLK_FMIN,
>                                                           &min_value,
>                                                           NULL);
>                         smu_v13_0_7_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_U=
CLK_BIT,
> -                                                         false,
> +                                                         PP_OD_FEATURE_U=
CLK_FMAX,
>                                                           NULL,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "MCLK: %7uMhz =
%10uMhz\n",
> @@ -1324,8 +1324,7 @@ static int smu_v13_0_7_print_clk_levels(struct smu_=
context *smu,
>
>                 if (smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATUR=
E_GFX_VF_CURVE_BIT)) {
>                         smu_v13_0_7_get_od_setting_limits(smu,
> -                                                         PP_OD_FEATURE_G=
FX_VF_CURVE_BIT,
> -                                                         true,
> +                                                         PP_OD_FEATURE_G=
FX_VF_CURVE,
>                                                           &min_value,
>                                                           &max_value);
>                         size +=3D sysfs_emit_at(buf, size, "VDDC_CURVE: %=
7dmv %10dmv\n",
> @@ -1370,8 +1369,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu=
_context *smu,
>                         switch (input[i]) {
>                         case 0:
>                                 smu_v13_0_7_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_BIT,
> -                                                                 true,
> +                                                                 PP_OD_F=
EATURE_GFXCLK_FMIN,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1387,8 +1385,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu=
_context *smu,
>
>                         case 1:
>                                 smu_v13_0_7_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_GFXCLK_BIT,
> -                                                                 false,
> +                                                                 PP_OD_F=
EATURE_GFXCLK_FMAX,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1433,8 +1430,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu=
_context *smu,
>                         switch (input[i]) {
>                         case 0:
>                                 smu_v13_0_7_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_UCLK_BIT,
> -                                                                 true,
> +                                                                 PP_OD_F=
EATURE_UCLK_FMIN,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1450,8 +1446,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu=
_context *smu,
>
>                         case 1:
>                                 smu_v13_0_7_get_od_setting_limits(smu,
> -                                                                 PP_OD_F=
EATURE_UCLK_BIT,
> -                                                                 false,
> +                                                                 PP_OD_F=
EATURE_UCLK_FMAX,
>                                                                   &minimu=
m,
>                                                                   &maximu=
m);
>                                 if (input[i + 1] < minimum ||
> @@ -1492,8 +1487,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu=
_context *smu,
>                         return -EINVAL;
>
>                 smu_v13_0_7_get_od_setting_limits(smu,
> -                                                 PP_OD_FEATURE_GFX_VF_CU=
RVE_BIT,
> -                                                 true,
> +                                                 PP_OD_FEATURE_GFX_VF_CU=
RVE,
>                                                   &minimum,
>                                                   &maximum);
>                 if (input[1] < minimum ||
> --
> 2.34.1
>
