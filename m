Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE15C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 15:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F0B10E27C;
	Tue,  5 Aug 2025 15:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bui+j3SC";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4778010E27C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 15:55:21 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-31ebeb3882cso782584a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754409321; x=1755014121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ufVsPrV3S8r/p0tlNGmV/FkN5IcqUjCJMGj8FO8vJM=;
 b=Bui+j3SCqFz8ZBymKNZph2fICOvI6S+AjzsUO/lnY4RKOuaYJAMvP9aFWQQL6i+Lw1
 tlEstx4sR9RFc99ImQ+hhOmIQMM5L42/xZls3VzjZki+/c3wnHXf+WC/rztqJV2bwOl0
 8AexLOqbWKTZDa1tuMcMcCzIr9ZRIysgPn2BFBV0xZNoHpXKslos8pXIHfwkTuNl0Lje
 h+Y2G416N2VShUC7RBfXl2LWK1jTEh4b3+a4Q8JcOHy6H0CbTEhBuSX3/gPHNwjLlzva
 iMxwmOu3l352JEgV6Dppzz2g+j9Sf1f6ArowAfZAvlYwoy83A2KLnu2wjc5/SZuwBBPE
 /G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754409321; x=1755014121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ufVsPrV3S8r/p0tlNGmV/FkN5IcqUjCJMGj8FO8vJM=;
 b=XGPGOKv7BLyWorm4EIJZnxX3cm3Al2S6uigkpWq8LvcqO4+P8ewJIexgFjhcOdt+ba
 QAAQced166A5qVXMpZpAH4C6so4wJBbvh62wiKPEhEa/d/54e4Oi2CMzXeMmMNEW89zR
 jU5/WJn2JgBLKV+xPnVkAKW95xKaw0kM5icbqa3qaGj5kvaKOf2uyBVWgSHEFa5cvaiF
 6JMQY8IVtfWxcYNQDb/bpC9IScdKJgcCv56GF2Fdgue7gtWBqQhKoWNBK/PRRd6PQgER
 rUsjHOokU9+PWiUg+Zjrh/7LK2Vhkts4Np5gdz94Bi3mC4yaO4sKt1G2Bo6dPwrPrWVv
 MeUg==
X-Gm-Message-State: AOJu0YypVUi0A6xVzd7rg07AA8+3X7JfGPP6UNZChI8aeiGDgLMJ0A4U
 S7LjutBkDZbm5MRY5iIGfcbu4itIhxDTU9Txw3iK1qYplPps+hykhO3nOa5uOk32BOxMMepYgkh
 vgAX4Y0u29KD+ZSQQRlhcR4XshXn0KBc=
X-Gm-Gg: ASbGncvFNtR5mPvxluNLwvN7xj0mxxzsdb51Pju0AD0TlaaUTeB1Zj8TFSXuAzAEjKz
 /pGiO9vcLxchoCLGAbH+iqxEEIq1HKyrz9RD5zN1FasGUpuO2LPGm3EZL+4mOdkvW9juwpHTYKT
 3fX3xl2lfXf+Q1E8ns81JMSXgBLCRcN0zL2/VByX4kIccdvIa0kwFN48ChvYQ57OUyVTwUvt7tr
 GRMji0s
X-Google-Smtp-Source: AGHT+IE8/falVAXXPY+8nca+5T1P3AwH4Bk6dcT6jhVKjONbT6YKssNHbI5fdea3QX3qvgNzH8LMmZ+vTZi/Xnv/KNo=
X-Received: by 2002:a17:90b:3852:b0:31e:bb42:c463 with SMTP id
 98e67ed59e1d1-321161e328dmr8275835a91.2.1754409320517; Tue, 05 Aug 2025
 08:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250805155058.669805-1-asad.kamal@amd.com>
In-Reply-To: <20250805155058.669805-1-asad.kamal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Aug 2025 11:55:07 -0400
X-Gm-Features: Ac12FXxlpxKwD0Zszu94WQ4DJdW_4fPmnEHPkmGcSnmNqph-oiukhU4PbrAysVo
Message-ID: <CADnq5_OkPUZaVAq038Yge6bMM4JjjXUoTNT+3yUhNTytbLavUA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: Increase cache interval time
To: Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, hawking.zhang@amd.com, 
 le.ma@amd.com, shiwu.zhang@amd.com, alexander.deucher@amd.com
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

On Tue, Aug 5, 2025 at 11:51=E2=80=AFAM Asad Kamal <asad.kamal@amd.com> wro=
te:
>
> Increase cache interval time to 50 ms while fetching system
> metrics table for smu_v13_0_12 since polling interval is less frequent fo=
r
> this data.
>
> v2: Make caching interval soc independent, however customization can be
> done in soc specific callbacks(Alex/Lijo)

I would split this into two patches, one to add the soc independent
change, and one to adjust smu 13.0.12.  We also need to implement the
cache implementation in the smu backend code for other chips.  It
would be nice to move that logic to a higher level so each smu backend
doesn't have to implement the caching.

Alex

>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index dc48a1dd8be4..c62d68d7410f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_c=
ontext *smu)
>
>  static int smu_smc_table_sw_init(struct smu_context *smu)
>  {
> +       struct smu_table_context *smu_table =3D &smu->smu_table;
>         int ret;
>
> +       smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval =3D
> +               AMDGPU_TEMP_METRICS_CACHE_INTERVAL;
> +
>         /**
>          * Create smu_table structure, and init smc tables such as
>          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 611b381b9147..7a52c00c700e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -32,6 +32,8 @@
>  #include "smu_types.h"
>  #include "linux/firmware.h"
>
> +#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL     50
> +
>  #define SMU_THERMAL_MINIMUM_ALERT_TEMP         0
>  #define SMU_THERMAL_MAXIMUM_ALERT_TEMP         255
>  #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES  1000
> @@ -258,6 +260,7 @@ struct smu_table {
>         struct amdgpu_bo *bo;
>         uint32_t version;
>         unsigned long  metrics_time;
> +       uint32_t cache_interval;
>  };
>
>  enum smu_perf_level_designation {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index fca50f6a8ef6..5ead66375d38 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_co=
ntext *smu,
>         return 0;
>  }
>
> -static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu=
, void *metrics_table,
> -                                                bool bypass_cache)
> +static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu=
, void *metrics_table)
>  {
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         uint32_t table_size =3D smu_table->tables[SMU_TABLE_SMU_METRICS].=
size;
>         struct smu_table *table =3D &smu_table->driver_table;
>         int ret;
>
> -       if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].me=
trics_time ||
> +       if (!smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
>             time_after(jiffies,
>                        smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_=
time +
> -                      msecs_to_jiffies(1))) {
> +                      msecs_to_jiffies(smu_table->tables[SMU_TABLE_TEMP_=
METRICS].cache_interval))) {
>                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetric=
sTable, NULL);
>                 if (ret) {
>                         dev_info(smu->adev->dev,
> @@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct s=
mu_context *smu,
>         else if (type  =3D=3D SMU_TEMP_METRIC_BASEBOARD)
>                 smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metric=
s, 1, 0);
>
> -       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics, false=
);
> +       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics);
>         if (ret) {
>                 kfree(metrics);
>                 return ret;
> --
> 2.46.0
>
