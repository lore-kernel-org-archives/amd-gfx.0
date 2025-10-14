Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D119CCD193
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 17:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9468310E22C;
	Tue, 14 Oct 2025 17:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hvnpHWNk";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DE010E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 17:26:41 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26808b24a00so8553155ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760462801; x=1761067601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ctL5GBfdIzYaXsz9tEEz3oQ7D1ysg8u3sbU9HuHaeU=;
 b=hvnpHWNkis/V0fEwdFjYXsugwFxNTheSx4aaawPk6ujp1stWbgd+NUnFcP2rzit9kC
 WzbjJ9FW5wLGloWoOevvxQadEhcq4ucZAh0quCWom4FWHT4QaB1Vlp9EOf/mWVOc0a6w
 SP2DzgS1+t8M1gyJOeZ8xh7WApfpiC+5b04Lt8XtvBZEEldOz6iY6YGYDdkveVhxusG6
 RvSLHyGx1oT8dKtJX0/rXUEVHAQ/evGgJ4VBKxEjn2DJeulQldMrWPB6yjp6I+OOvkZK
 mzMElb2SaiJsxJLm+WbnaOfsAWZLNiPmFw40H+TtF5WkG5IFQLBBr5gjmbUeAsndXLqL
 OrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760462801; x=1761067601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ctL5GBfdIzYaXsz9tEEz3oQ7D1ysg8u3sbU9HuHaeU=;
 b=Njh+C4gFxpC1x+/dqRLeIUK6mZeKGwLhazor8LJtR3I3L0hu9kwR0goBk+mtBgII6A
 Rj55qOAPJr3VZox0KK+D8RAgq6ZgdfD1i8EPZXzlLJMwzIyxKEEVre9wrho9NnW8O8/M
 FwmGvW7RX0+pqOdWKKnpLQQwOsprb/aAt31bxhDrIrYrDdznaH1wgpuwGqf0EePxha9N
 EKpUdGb/5fU832tfFXCh+aYHpmO+j7mcnwK01yCr39ldeAxiMSfmHGIdvladjRMOKMAf
 4xxCfQU9cuXcxjN+sPtZLGfbRR63tBHF3gMSQgnd3arM680jQ42vzHoetKS5bL5RqHF+
 e1Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW07ILF3ev/BqOUvJD87fXgS5ZQYEhI8ErPdDUPnID24ikgDbDNd9mWjBzTjHcu7+8Cqtc8bcEU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWeiU4ps8wTc85ozNgoeBlyyNsNP7w9WLeCZwn3c9FhCLzZsPE
 3p6aZr+zN6+ap4WGHyzGJPHubjHYDt7J6rJOEONhOSPdyLWzahoxjYvmE7etTeh0XqYMIC9aaJV
 zsi9oh+9YlcZGUrYym93wwHI9XNUD2JY=
X-Gm-Gg: ASbGncutezUtlsrsA9oO+WuoY7fVS6pe2wXc0KHTyY3qXck0tQxxZox4ZH/UC+YYeJ6
 TQgX5Xi7QZ2re/Jn+tGhDWD8zK38+ySSrF9K+dmFH4yLZ+X55GUF7//Vm06UvcXEhzJV51ec8FD
 pl76cGQLI4vNB5fycoAktYS+uSHDkH3XeREk+IyfqTy1WkRqW7+GWs0lvlBOkyO85tizALcMIJs
 q593J6RPD5gRmwMtGt3/3IoBWMiTu2NE/VU
X-Google-Smtp-Source: AGHT+IFDma62B7uRmqEHRzS5/lATlfy5E6zecJq5Le8Qy+fypbwQ62OXcDZjNNmlpn6nD6pllH1CPbwbHnchDQEB/LM=
X-Received: by 2002:a17:903:18b:b0:26a:f96c:3099 with SMTP id
 d9443c01a7336-290273de44fmr177848155ad.3.1760462801018; Tue, 14 Oct 2025
 10:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251013163042.531225-1-ilya.zlobintsev@gmail.com>
 <20251013163042.531225-2-ilya.zlobintsev@gmail.com>
 <ac39add0-f211-4323-8cff-3ee017f6264b@amd.com>
In-Reply-To: <ac39add0-f211-4323-8cff-3ee017f6264b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Oct 2025 13:26:29 -0400
X-Gm-Features: AS18NWCzZ6Gb-b8i1Ej7cxPzf3_FllKOCaIS69GBacj1oPvvqgTCXy-DzpxxPko
Message-ID: <CADnq5_M=jZG7OwjRrd6-GWYmt47gvx+rA2kNcSZjY24c9KRedg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>, amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

Alex

On Tue, Oct 14, 2025 at 11:41=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 10/13/2025 10:00 PM, Ilya Zlobintsev wrote:
> > Calling `smu_cmn_get_sysfs_buf` aligns the
> > offset used by `sysfs_emit_at` to the current page boundary, which was
> > previously directly returned from the various `print_clk_levels`
> > implementations to be added to the buffer position.
> > Instead, only the relative offset showing how much was written
> > to the buffer should be returned, regardless of how it was changed
> > for alignment purposes.
> >
> > Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >   .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  5 +++--
> >   drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 15 ++++++++------=
-
> >   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +++--
> >   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 10 ++++++----
> >   drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  7 ++++---
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  7 ++++---
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  5 +++--
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  5 +++--
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  7 ++++---
> >   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  7 ++++---
> >   .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  5 +++--
> >   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  5 +++--
> >   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  7 ++++---
> >   13 files changed, 52 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/=
drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > index 9548bd3c624b..55401e6b2b0b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > @@ -291,11 +291,12 @@ static int cyan_skillfish_print_clk_levels(struct=
 smu_context *smu,
> >                                       enum smu_clk_type clk_type,
> >                                       char *buf)
> >   {
> > -     int ret =3D 0, size =3D 0;
> > +     int ret =3D 0, size =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0;
> >       int i;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -353,7 +354,7 @@ static int cyan_skillfish_print_clk_levels(struct s=
mu_context *smu,
> >               return ret;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 0028f10ead42..bbf09aec9152 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -1469,7 +1469,7 @@ static int navi10_print_clk_levels(struct smu_con=
text *smu,
> >                       enum smu_clk_type clk_type, char *buf)
> >   {
> >       uint16_t *curve_settings;
> > -     int i, levels, size =3D 0, ret =3D 0;
> > +     int i, levels, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t freq_values[3] =3D {0};
> >       uint32_t mark_index =3D 0;
> > @@ -1484,6 +1484,7 @@ static int navi10_print_clk_levels(struct smu_con=
text *smu,
> >       uint32_t min_value, max_value;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_GFXCLK:
> > @@ -1497,11 +1498,11 @@ static int navi10_print_clk_levels(struct smu_c=
ontext *smu,
> >       case SMU_DCEFCLK:
> >               ret =3D navi10_get_current_clk_freq_by_table(smu, clk_typ=
e, &cur_value);
> >               if (ret)
> > -                     return size;
> > +                     return size - start_offset;
> >
> >               ret =3D smu_v11_0_get_dpm_level_count(smu, clk_type, &cou=
nt);
> >               if (ret)
> > -                     return size;
> > +                     return size - start_offset;
> >
> >               ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type)=
;
> >               if (ret < 0)
> > @@ -1511,7 +1512,7 @@ static int navi10_print_clk_levels(struct smu_con=
text *smu,
> >                       for (i =3D 0; i < count; i++) {
> >                               ret =3D smu_v11_0_get_dpm_freq_by_index(s=
mu, clk_type, i, &value);
> >                               if (ret)
> > -                                     return size;
> > +                                     return size - start_offset;
> >
> >                               size +=3D sysfs_emit_at(buf, size, "%d: %=
uMhz %s\n", i, value,
> >                                               cur_value =3D=3D value ? =
"*" : "");
> > @@ -1519,10 +1520,10 @@ static int navi10_print_clk_levels(struct smu_c=
ontext *smu,
> >               } else {
> >                       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_=
type, 0, &freq_values[0]);
> >                       if (ret)
> > -                             return size;
> > +                             return size - start_offset;
> >                       ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_=
type, count - 1, &freq_values[2]);
> >                       if (ret)
> > -                             return size;
> > +                             return size - start_offset;
> >
> >                       freq_values[1] =3D cur_value;
> >                       mark_index =3D cur_value =3D=3D freq_values[0] ? =
0 :
> > @@ -1653,7 +1654,7 @@ static int navi10_print_clk_levels(struct smu_con=
text *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int navi10_force_clk_levels(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/=
drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 31c2c0386b1f..774283ac7827 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -1281,7 +1281,7 @@ static int sienna_cichlid_print_clk_levels(struct=
 smu_context *smu,
> >       struct smu_11_0_7_overdrive_table *od_settings =3D smu->od_settin=
gs;
> >       OverDriveTable_t *od_table =3D
> >               (OverDriveTable_t *)table_context->overdrive_table;
> > -     int i, size =3D 0, ret =3D 0;
> > +     int i, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t freq_values[3] =3D {0};
> >       uint32_t mark_index =3D 0;
> > @@ -1289,6 +1289,7 @@ static int sienna_cichlid_print_clk_levels(struct=
 smu_context *smu,
> >       uint32_t min_value, max_value;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_GFXCLK:
> > @@ -1434,7 +1435,7 @@ static int sienna_cichlid_print_clk_levels(struct=
 smu_context *smu,
> >       }
> >
> >   print_clk_out:
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 2c9869feba61..665eee58358d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -565,7 +565,7 @@ static int vangogh_print_legacy_clk_levels(struct s=
mu_context *smu,
> >       DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
> >       SmuMetrics_legacy_t metrics;
> >       struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       bool cur_value_match_level =3D false;
> >
> > @@ -576,6 +576,7 @@ static int vangogh_print_legacy_clk_levels(struct s=
mu_context *smu,
> >               return ret;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -658,7 +659,7 @@ static int vangogh_print_legacy_clk_levels(struct s=
mu_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int vangogh_print_clk_levels(struct smu_context *smu,
> > @@ -666,7 +667,7 @@ static int vangogh_print_clk_levels(struct smu_cont=
ext *smu,
> >   {
> >       DpmClocks_t *clk_table =3D smu->smu_table.clocks_table;
> >       SmuMetrics_t metrics;
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       bool cur_value_match_level =3D false;
> >       uint32_t min, max;
> > @@ -678,6 +679,7 @@ static int vangogh_print_clk_levels(struct smu_cont=
ext *smu,
> >               return ret;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -779,7 +781,7 @@ static int vangogh_print_clk_levels(struct smu_cont=
ext *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int vangogh_common_print_clk_levels(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 3baf20f4c373..eaa9ea162f16 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -494,7 +494,7 @@ static int renoir_set_fine_grain_gfx_freq_parameter=
s(struct smu_context *smu)
> >   static int renoir_print_clk_levels(struct smu_context *smu,
> >                       enum smu_clk_type clk_type, char *buf)
> >   {
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0, min =3D 0, ma=
x =3D 0;
> >       SmuMetrics_t metrics;
> >       bool cur_value_match_level =3D false;
> > @@ -506,6 +506,7 @@ static int renoir_print_clk_levels(struct smu_conte=
xt *smu,
> >               return ret;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_RANGE:
> > @@ -550,7 +551,7 @@ static int renoir_print_clk_levels(struct smu_conte=
xt *smu,
> >                       size +=3D sysfs_emit_at(buf, size, "2: %uMhz %s\n=
", max,
> >                                       i =3D=3D 2 ? "*" : "");
> >               }
> > -             return size;
> > +             return size - start_offset;
> >       case SMU_SOCCLK:
> >               count =3D NUM_SOCCLK_DPM_LEVELS;
> >               cur_value =3D metrics.ClockFrequency[CLOCK_SOCCLK];
> > @@ -607,7 +608,7 @@ static int renoir_print_clk_levels(struct smu_conte=
xt *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static enum amd_pm_state_type renoir_get_current_power_state(struct s=
mu_context *smu)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > index c1062e5f0393..677781060246 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > @@ -1195,15 +1195,16 @@ static int smu_v13_0_0_print_clk_levels(struct =
smu_context *smu,
> >       struct smu_13_0_dpm_table *single_dpm_table;
> >       struct smu_13_0_pcie_table *pcie_table;
> >       uint32_t gen_speed, lane_width;
> > -     int i, curr_freq, size =3D 0;
> > +     int i, curr_freq, size =3D 0, start_offset =3D 0;
> >       int32_t min_value, max_value;
> >       int ret =3D 0;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       if (amdgpu_ras_intr_triggered()) {
> >               size +=3D sysfs_emit_at(buf, size, "unavailable\n");
> > -             return size;
> > +             return size - start_offset;
> >       }
> >
> >       switch (clk_type) {
> > @@ -1534,7 +1535,7 @@ static int smu_v13_0_0_print_clk_levels(struct sm=
u_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> > index b081ae3e8f43..6908f9930f16 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> > @@ -497,11 +497,12 @@ static int smu_v13_0_4_get_dpm_level_count(struct=
 smu_context *smu,
> >   static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
> >                                       enum smu_clk_type clk_type, char =
*buf)
> >   {
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t min, max;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -565,7 +566,7 @@ static int smu_v13_0_4_print_clk_levels(struct smu_=
context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int smu_v13_0_4_read_sensor(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > index f5db181ef489..4576bf008b22 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> > @@ -861,11 +861,12 @@ static int smu_v13_0_5_set_soft_freq_limited_rang=
e(struct smu_context *smu,
> >   static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
> >                               enum smu_clk_type clk_type, char *buf)
> >   {
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t min =3D 0, max =3D 0;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -928,7 +929,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_=
context *smu,
> >       }
> >
> >   print_clk_out:
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > index 285cf7979693..0e1b225dd875 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > @@ -1428,7 +1428,7 @@ static int smu_v13_0_6_print_clks(struct smu_cont=
ext *smu, char *buf, int size,
> >   static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
> >                                       enum smu_clk_type type, char *buf=
)
> >   {
> > -     int now, size =3D 0;
> > +     int now, size =3D 0, start_offset =3D 0;
> >       int ret =3D 0;
> >       struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
> >       struct smu_13_0_dpm_table *single_dpm_table;
> > @@ -1437,10 +1437,11 @@ static int smu_v13_0_6_print_clk_levels(struct =
smu_context *smu,
> >       uint32_t min_clk, max_clk;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       if (amdgpu_ras_intr_triggered()) {
> >               size +=3D sysfs_emit_at(buf, size, "unavailable\n");
> > -             return size;
> > +             return size - start_offset;
> >       }
> >
> >       dpm_context =3D smu_dpm->dpm_context;
> > @@ -1575,7 +1576,7 @@ static int smu_v13_0_6_print_clk_levels(struct sm=
u_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool=
 max,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index c96fa5e49ed6..a3fc35b9011e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -1184,15 +1184,16 @@ static int smu_v13_0_7_print_clk_levels(struct =
smu_context *smu,
> >       struct smu_13_0_dpm_table *single_dpm_table;
> >       struct smu_13_0_pcie_table *pcie_table;
> >       uint32_t gen_speed, lane_width;
> > -     int i, curr_freq, size =3D 0;
> > +     int i, curr_freq, size =3D 0, start_offset =3D 0;
> >       int32_t min_value, max_value;
> >       int ret =3D 0;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       if (amdgpu_ras_intr_triggered()) {
> >               size +=3D sysfs_emit_at(buf, size, "unavailable\n");
> > -             return size;
> > +             return size - start_offset;
> >       }
> >
> >       switch (clk_type) {
> > @@ -1523,7 +1524,7 @@ static int smu_v13_0_7_print_clk_levels(struct sm=
u_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int smu_v13_0_7_od_restore_table_single(struct smu_context *sm=
u, long input)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > index 73b4506ef5a8..5d7e671fa3c3 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > @@ -1041,12 +1041,13 @@ static uint32_t yellow_carp_get_umd_pstate_clk_=
default(struct smu_context *smu,
> >   static int yellow_carp_print_clk_levels(struct smu_context *smu,
> >                               enum smu_clk_type clk_type, char *buf)
> >   {
> > -     int i, idx, size =3D 0, ret =3D 0;
> > +     int i, idx, size =3D 0, ret =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t min, max;
> >       uint32_t clk_limit =3D 0;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -1111,7 +1112,7 @@ static int yellow_carp_print_clk_levels(struct sm=
u_context *smu,
> >       }
> >
> >   print_clk_out:
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int yellow_carp_force_clk_levels(struct smu_context *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index fe00c84b1cc6..b1bd946d8e30 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -1132,11 +1132,12 @@ static int smu_v14_0_common_get_dpm_level_count=
(struct smu_context *smu,
> >   static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
> >                                       enum smu_clk_type clk_type, char =
*buf)
> >   {
> > -     int i, idx, ret =3D 0, size =3D 0;
> > +     int i, idx, ret =3D 0, size =3D 0, start_offset =3D 0;
> >       uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
> >       uint32_t min, max;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       switch (clk_type) {
> >       case SMU_OD_SCLK:
> > @@ -1202,7 +1203,7 @@ static int smu_v14_0_0_print_clk_levels(struct sm=
u_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context=
 *smu,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > index 086501cc5213..2cea688c604f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> > @@ -1056,15 +1056,16 @@ static int smu_v14_0_2_print_clk_levels(struct =
smu_context *smu,
> >       struct smu_14_0_dpm_table *single_dpm_table;
> >       struct smu_14_0_pcie_table *pcie_table;
> >       uint32_t gen_speed, lane_width;
> > -     int i, curr_freq, size =3D 0;
> > +     int i, curr_freq, size =3D 0, start_offset =3D 0;
> >       int32_t min_value, max_value;
> >       int ret =3D 0;
> >
> >       smu_cmn_get_sysfs_buf(&buf, &size);
> > +     start_offset =3D size;
> >
> >       if (amdgpu_ras_intr_triggered()) {
> >               size +=3D sysfs_emit_at(buf, size, "unavailable\n");
> > -             return size;
> > +             return size - start_offset;
> >       }
> >
> >       switch (clk_type) {
> > @@ -1374,7 +1375,7 @@ static int smu_v14_0_2_print_clk_levels(struct sm=
u_context *smu,
> >               break;
> >       }
> >
> > -     return size;
> > +     return size - start_offset;
> >   }
> >
> >   static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
>
