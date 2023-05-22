Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1079DC77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 13:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E29B10E323;
	Mon, 22 May 2023 13:19:52 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFCF10E323
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:19:49 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39425ea8e1fso3533055b6e.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684761588; x=1687353588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thgDHNu8+4WuhkY6TOsL/EZEd6PKH1S4EVrTVc6lhRY=;
 b=r5Ckk8GU9s5jOCU/UDcwspI1bMM3yMTckfNhJj/YZBcl7XWWoEG7wcJ8X9ZwEGC0pd
 ZJhzSOMqK4fajXg8FceMdwnmyeCHJHJnc+er5hntxr28W0D8Os/rUMCbWDPXGCf/ggrS
 Ge5JLLjMbiC35PzE07EqpWSvzGzUrAv6wEWrvC8JP5cLcqfl+puHnO85/yGZvGV43vhY
 y6ZNHcNiQs63G1v45eRF2lN0HobMD2Wc952yyMCz5K+0uyqiXT/G9cNufUTX8sjZGDWo
 ogaZasPTfGlmwW7p8iDsaoxTFBafj4A/czJPkkXdnkMsosyoPRWPVijLLmQ0Y6cEX/Xk
 4ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761588; x=1687353588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thgDHNu8+4WuhkY6TOsL/EZEd6PKH1S4EVrTVc6lhRY=;
 b=NL00Z30MvtPLNCKRowqTmthIb+W9J5LuVRue/SyMWQRN0b2bONewaXxVFl+7pz+egB
 xTI86YbOONsmhgZaNuR6IGcNIKpfAU+PnKy2bvl4iCi7pAM00p93yePxc4CI0s/fxj9J
 RheSus7QJP8OTqb8/YOEUmomutmx6gkQOmrWcCw4Ztyq6YoIVo0/1KLkIIaSoX6gzQJs
 C+H45wgR/slZuvJpmAjY/iwkJhlB7yDoBMoWtqDChwMfbvKb6KUmGuB3cvjRYzMXChEM
 aRRg+v65xTsTYRhy6nEJi7TrKNmF0ik9i2V2uFK7hQu/0bvpqrni399jonqZmHyGOIii
 dVzA==
X-Gm-Message-State: AC+VfDzycDBdZPPYOCymL6PDQ0GA+LDuN+nYA5AwbPe030zVqh/Wmz+v
 t+shy201c5Dvr6T6E0Jcl3Q3BHs2QugyMMS25k4=
X-Google-Smtp-Source: ACHHUZ4YJB3CrATVswK5KI5v8LAEA/lgDMRwEo1kVeE0/KItYAqAYF211WCRLwNNMAPknhdOAT1cCqkf9jQUCxVNgBk=
X-Received: by 2002:aca:f03:0:b0:38e:7168:697f with SMTP id
 3-20020aca0f03000000b0038e7168697fmr4729088oip.20.1684761588165; Mon, 22 May
 2023 06:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230522100832.1968912-1-Tim.Huang@amd.com>
 <20230522100832.1968912-4-Tim.Huang@amd.com>
In-Reply-To: <20230522100832.1968912-4-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 09:19:36 -0400
Message-ID: <CADnq5_MY2DRypj5X6EnmaGpgZsWPoh44nTpgwORJvCuNX-O99Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] amd/pm/swsmu: reverse mclk and fclk clocks levels for
 vangogh
To: Tim Huang <Tim.Huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Does Renoir need a similar fix?

Alex

On Mon, May 22, 2023 at 6:10=E2=80=AFAM Tim Huang <Tim.Huang@amd.com> wrote=
:
>
> This patch reverses the DPM clocks levels output of pp_dpm_mclk
> and pp_dpm_fclk.
>
> On dGPUs and older APUs we expose the levels from lowest clocks
> to highest clocks. But for some APUs, the clocks levels that from
> the DFPstateTable are given the reversed orders by PMFW. Like the
> memory DPM clocks that are exposed by pp_dpm_mclk.
>
> It's not intuitive that they are reversed on these APUs. All tools
> and software that talks to the driver then has to know different ways
> to interpret the data depending on the asic.
>
> So we need to reverse them to expose the clocks levels from the
> driver consistently.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..067b4e0b026c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -582,7 +582,7 @@ static int vangogh_print_legacy_clk_levels(struct smu=
_context *smu,
>         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
>         SmuMetrics_legacy_t metrics;
>         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> -       int i, size =3D 0, ret =3D 0;
> +       int i, idx, size =3D 0, ret =3D 0;
>         uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
>         bool cur_value_match_level =3D false;
>
> @@ -656,7 +656,8 @@ static int vangogh_print_legacy_clk_levels(struct smu=
_context *smu,
>         case SMU_MCLK:
>         case SMU_FCLK:
>                 for (i =3D 0; i < count; i++) {
> -                       ret =3D vangogh_get_dpm_clk_limited(smu, clk_type=
, i, &value);
> +                       idx =3D (clk_type =3D=3D SMU_FCLK || clk_type =3D=
=3D SMU_MCLK) ? (count - i - 1) : i;
> +                       ret =3D vangogh_get_dpm_clk_limited(smu, clk_type=
, idx, &value);
>                         if (ret)
>                                 return ret;
>                         if (!value)
> @@ -683,7 +684,7 @@ static int vangogh_print_clk_levels(struct smu_contex=
t *smu,
>         DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
>         SmuMetrics_t metrics;
>         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> -       int i, size =3D 0, ret =3D 0;
> +       int i, idx, size =3D 0, ret =3D 0;
>         uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
>         bool cur_value_match_level =3D false;
>         uint32_t min, max;
> @@ -765,7 +766,8 @@ static int vangogh_print_clk_levels(struct smu_contex=
t *smu,
>         case SMU_MCLK:
>         case SMU_FCLK:
>                 for (i =3D 0; i < count; i++) {
> -                       ret =3D vangogh_get_dpm_clk_limited(smu, clk_type=
, i, &value);
> +                       idx =3D (clk_type =3D=3D SMU_FCLK || clk_type =3D=
=3D SMU_MCLK) ? (count - i - 1) : i;
> +                       ret =3D vangogh_get_dpm_clk_limited(smu, clk_type=
, idx, &value);
>                         if (ret)
>                                 return ret;
>                         if (!value)
> --
> 2.34.1
>
