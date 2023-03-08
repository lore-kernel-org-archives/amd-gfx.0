Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FDDC678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 21:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA3E10E021;
	Wed,  8 Mar 2023 21:11:36 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE9510E021
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 21:11:34 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 a23-20020a4ad5d7000000b005250867d3d9so2750512oot.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 13:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678309893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RsiMPIqEbAZ2a1XeueCZtTk58NvKvyBJoo2lnQ7uXZo=;
 b=TJM/dM/LJ6H/9R3wn6D6XamAwGAou0d40e8DAdwZ0dNWSLp6UobUFkeueljlYa2zQo
 RDtzGEZxtHFqTSG624Y+Mn7cllMlZNiE0kST46CRPtn5/NHn6MsBlYn0XQyKtZVK/+2n
 So2BmK50p9V5fTmNQZmcdi8vorfb3uxbA378GJ8Cjm08dUl1abrKlVQL+n0WybQPFZp+
 mu6Mg5DUfp1s9sc9qg3TONhiev+3XAqRDWGBUgeJIFmXNwciAIwbbrGrEKOPP/OSsP+o
 yozbPUzlYt+RR3T8y4yaQdQssIrC3lxoZEZV/SXCgH55bWOeViDcJqtIGSPBIiWyhypK
 tbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678309893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RsiMPIqEbAZ2a1XeueCZtTk58NvKvyBJoo2lnQ7uXZo=;
 b=VpOwWTbL67WFOw+DrOFXiB/GfYQV/ma3/I1bvAUlr9UTJU91cr9aF5Lhb19Rcp6+JL
 VZ7rI66y7Kjj9OoEvgH2FVQ9hau0olCtKdrP8h36F98tCZSH9UNi6NcEv6uwKtl4iXOK
 lSjb401a3DbIbEokt8gQy3Yxv6S3iUm3SrS2ClNhOtvrQUq5/kpAwuop4BkU2I7AtjXg
 zyu7vlC7/bmqzEJIAlwqkc8sBhbkcy7+jfjEh+GpkdzlJJfDJu5C+hfHVS5p/hfuaAIf
 mTcGsoCiUqKBP+7ZSxvi/fADjfR0ZmMkgeWyv0HkYSX37LFv35YBA8e3ympJCuwLHmhd
 17jg==
X-Gm-Message-State: AO0yUKU1aOXaWVXJrKFr+Mwqhny39Wwfa/kDfon+OluOOLeB7j58MZJQ
 YkB1hOxzNoOUdDJ9WE26wU66Id1hfVuFDOyn/an7jZToLEw=
X-Google-Smtp-Source: AK7set99n0ojKrYCTQpyCLQiH2BnNmEZN3pbfn1zi17KnRklSpZ4Aby7AbYOtljKIsknMaHKXp38/JchoGjAfmb6/+8=
X-Received: by 2002:a4a:4114:0:b0:520:1309:c69d with SMTP id
 x20-20020a4a4114000000b005201309c69dmr6680448ooa.0.1678309893485; Wed, 08 Mar
 2023 13:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20230308152014.3814372-1-alexander.deucher@amd.com>
In-Reply-To: <20230308152014.3814372-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Mar 2023 16:11:22 -0500
Message-ID: <CADnq5_Mij45+hSQtS6RwauT+6K862QvL6AJ+LhHRW8YHnTZ1VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: Fix sienna cichlid incorrect OD volage
 after resume
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Evan Quan <evan.quan@amd.com>,
 =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 8, 2023 at 10:20 AM Alex Deucher <alexander.deucher@amd.com> wr=
ote:
>
> From: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
>
> Always setup overdrive tables after resume. Preserve only some
> user-defined settings in user_overdrive_table if they're set.
>
> Copy restored user_overdrive_table into od_table to get correct
> values.
>
> On cold boot, BTC was triggered and GfxVfCurve was calibrated. We
> got VfCurve settings (a). On resuming back, BTC will be triggered
> again and GfxVfCurve will be recalibrated. VfCurve settings (b)
> got may be different from those of cold boot.  So if we reuse
> those VfCurve settings (a) got on cold boot on suspend, we can
> run into discrepencies.
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: B=C5=82a=C5=BCej Szczygie=C5=82 <mumei6102@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Will add the bug references as well when I commit this:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1897
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2276

Thanks for the patch.

Alex

> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++-----
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 697e98a0a20a..75f18681e984 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2143,16 +2143,9 @@ static int sienna_cichlid_set_default_od_settings(=
struct smu_context *smu)
>                 (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>         OverDriveTable_t *user_od_table =3D
>                 (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> +       OverDriveTable_t user_od_table_bak;
>         int ret =3D 0;
>
> -       /*
> -        * For S3/S4/Runpm resume, no need to setup those overdrive table=
s again as
> -        *   - either they already have the default OD settings got durin=
g cold bootup
> -        *   - or they have some user customized OD settings which cannot=
 be overwritten
> -        */
> -       if (smu->adev->in_suspend)
> -               return 0;
> -
>         ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
>                                    0, (void *)boot_od_table, false);
>         if (ret) {
> @@ -2163,7 +2156,23 @@ static int sienna_cichlid_set_default_od_settings(=
struct smu_context *smu)
>         sienna_cichlid_dump_od_table(smu, boot_od_table);
>
>         memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> -       memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> +
> +       /*
> +        * For S3/S4/Runpm resume, we need to setup those overdrive table=
s again,
> +        * but we have to preserve user defined values in "user_od_table"=
.
> +        */
> +       if (!smu->adev->in_suspend) {
> +               memcpy(user_od_table, boot_od_table, sizeof(OverDriveTabl=
e_t));
> +               smu->user_dpm_profile.user_od =3D false;
> +       } else if (smu->user_dpm_profile.user_od) {
> +               memcpy(&user_od_table_bak, user_od_table, sizeof(OverDriv=
eTable_t));
> +               memcpy(user_od_table, boot_od_table, sizeof(OverDriveTabl=
e_t));
> +               user_od_table->GfxclkFmin =3D user_od_table_bak.GfxclkFmi=
n;
> +               user_od_table->GfxclkFmax =3D user_od_table_bak.GfxclkFma=
x;
> +               user_od_table->UclkFmin =3D user_od_table_bak.UclkFmin;
> +               user_od_table->UclkFmax =3D user_od_table_bak.UclkFmax;
> +               user_od_table->VddGfxOffset =3D user_od_table_bak.VddGfxO=
ffset;
> +       }
>
>         return 0;
>  }
> @@ -2373,6 +2382,20 @@ static int sienna_cichlid_od_edit_dpm_table(struct=
 smu_context *smu,
>         return ret;
>  }
>
> +static int sienna_cichlid_restore_user_od_settings(struct smu_context *s=
mu)
> +{
> +       struct smu_table_context *table_context =3D &smu->smu_table;
> +       OverDriveTable_t *od_table =3D table_context->overdrive_table;
> +       OverDriveTable_t *user_od_table =3D table_context->user_overdrive=
_table;
> +       int res;
> +
> +       res =3D smu_v11_0_restore_user_od_settings(smu);
> +       if (res =3D=3D 0)
> +               memcpy(od_table, user_od_table, sizeof(OverDriveTable_t))=
;
> +
> +       return res;
> +}
> +
>  static int sienna_cichlid_run_btc(struct smu_context *smu)
>  {
>         int res;
> @@ -4400,7 +4423,7 @@ static const struct pptable_funcs sienna_cichlid_pp=
t_funcs =3D {
>         .set_soft_freq_limited_range =3D smu_v11_0_set_soft_freq_limited_=
range,
>         .set_default_od_settings =3D sienna_cichlid_set_default_od_settin=
gs,
>         .od_edit_dpm_table =3D sienna_cichlid_od_edit_dpm_table,
> -       .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
> +       .restore_user_od_settings =3D sienna_cichlid_restore_user_od_sett=
ings,
>         .run_btc =3D sienna_cichlid_run_btc,
>         .set_power_source =3D smu_v11_0_set_power_source,
>         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
> --
> 2.39.2
>
