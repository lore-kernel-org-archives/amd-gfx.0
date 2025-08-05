Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F56C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 15:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1C310E289;
	Tue,  5 Aug 2025 15:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rnf6IDz0";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94C210E289
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 15:56:09 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-76c0387f1edso302885b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754409369; x=1755014169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ulx4lPvpvVQeHqfyAFwoyVVSZgKNzKOCC9uUcB6Dh2Q=;
 b=Rnf6IDz0fK82HUOG9Yt5UjEGt9koz78tOYy/8a3yw2qSbiK9DJYjY2aIr8HwCy228Y
 VYOwQFlxyW5fuV4+ifyYq3SQk7BloXJuCLcq+CxeW5Se4Phqw2SUZJEUv6106vBi0dsn
 3HtV8YHmujW8aIVZGajPz47ylE9lAMGB8vlSwUyNnz+Xim2/pGq0YOXw/J4PEwA2ftCw
 gvJYooOsdIQkpxDhKBdFnkSvbuXeERi2UoygZARxKC6k6D/O191tOqQQYQobk9YZCcdl
 YmZLXrRAXQvi1eX03hZMYQOWrJY+bjIAHdW7Rd84K3ib4/Z4TXL5gwWlWCy71oYKzUvL
 GpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754409369; x=1755014169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ulx4lPvpvVQeHqfyAFwoyVVSZgKNzKOCC9uUcB6Dh2Q=;
 b=XDGfY8VVoDlBhWSzT3+GQlIMzrpYOGnanVKiOvXjU9A7nlvApQOeZVW2K76xTMy1ug
 2EmZ1nxFVtwdpT0jqZbX/5VfaelVLYlul20y0zeI+R0ObPuwe0o3D7qfLqaPDafqiGcU
 WcsIyiLu/+vt32EdLHtL6EL7DktU2g4RYIxIUDeFNVWautsHygHNpcVIAJjxmDRLKW0W
 RNTnrnncWDNd1qTpJar6FqNcTzIoA1GthN8KE2dJjQm7flTB0NZ/KtmPgWb8Ghb+z6EU
 1O0VCZ+cAMduaoL1yUlWin0vqMCEkgeTE+CONyUwKhcSgGeWp8a5Pu5KEKIfoZGNWwUe
 Wv/g==
X-Gm-Message-State: AOJu0YyZ+ohpKuJa7CAmC3+4OQ5G6F7FmFFmWVChYZuepzWVSbml6O+K
 xve0OIcVuqOeUwC1kmaJYjKHVrkPO+QFqP9u0avJayXjO0VzAUIrbBPwYKFIllpVp5KMQVTw0Pf
 eQndt7fmVo/hAJ+3hGC126WiV3Gv1ujc=
X-Gm-Gg: ASbGnctI3+eQ+09hQESWgxYpR7TAJlcwfpFBVAwrEkZdHVkYVP9VfWk16qGjwhF3Jl7
 +glXDh5gPsSX9VKDg8I+vxHfC+H1VudAPQJcOtYuAi39ZfHecHquVlIRf2DvXilp0pXviljURYa
 xyP29UvPU2h3AbxIzgg/D7kfKUZhE7T+T7O0XE/0y7rbVaXN7spW41goKKO3myMzTDF30RrSi3e
 Rie/fS3
X-Google-Smtp-Source: AGHT+IEmi7hFrc5VyXlWKLchjq2bFC7HGNoJG2qwzw5KPAWvxkIyk2SZNLNyN8V4vqgqUXtpkQtDViSGnW59zRlq52g=
X-Received: by 2002:a17:90b:33d2:b0:31e:ec03:7fe4 with SMTP id
 98e67ed59e1d1-321162e4270mr7192629a91.8.1754409369018; Tue, 05 Aug 2025
 08:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250805155058.669805-1-asad.kamal@amd.com>
 <CADnq5_OkPUZaVAq038Yge6bMM4JjjXUoTNT+3yUhNTytbLavUA@mail.gmail.com>
In-Reply-To: <CADnq5_OkPUZaVAq038Yge6bMM4JjjXUoTNT+3yUhNTytbLavUA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Aug 2025 11:55:57 -0400
X-Gm-Features: Ac12FXy9TbjEZ9_E1_gJg7ndK-UdN7_L7GreLhKFWhF0zzreLtXdoPBYPtnPd10
Message-ID: <CADnq5_Nfj=opiyu2OF6qHe4arsQS0Nu6Vg-984E=ORPS9Ha1gg@mail.gmail.com>
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

On Tue, Aug 5, 2025 at 11:55=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Aug 5, 2025 at 11:51=E2=80=AFAM Asad Kamal <asad.kamal@amd.com> w=
rote:
> >
> > Increase cache interval time to 50 ms while fetching system
> > metrics table for smu_v13_0_12 since polling interval is less frequent =
for
> > this data.
> >
> > v2: Make caching interval soc independent, however customization can be
> > done in soc specific callbacks(Alex/Lijo)
>
> I would split this into two patches, one to add the soc independent
> change, and one to adjust smu 13.0.12.  We also need to implement the
> cache implementation in the smu backend code for other chips.  It
> would be nice to move that logic to a higher level so each smu backend
> doesn't have to implement the caching.

This can be a future optimization.  I don't want to block the smu
13.0.12 updates.

Alex

>
> Alex
>
> >
> > Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 4 ++++
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 3 +++
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----
> >  3 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index dc48a1dd8be4..c62d68d7410f 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu=
_context *smu)
> >
> >  static int smu_smc_table_sw_init(struct smu_context *smu)
> >  {
> > +       struct smu_table_context *smu_table =3D &smu->smu_table;
> >         int ret;
> >
> > +       smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval =3D
> > +               AMDGPU_TEMP_METRICS_CACHE_INTERVAL;
> > +
> >         /**
> >          * Create smu_table structure, and init smc tables such as
> >          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gp=
u/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index 611b381b9147..7a52c00c700e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -32,6 +32,8 @@
> >  #include "smu_types.h"
> >  #include "linux/firmware.h"
> >
> > +#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL     50
> > +
> >  #define SMU_THERMAL_MINIMUM_ALERT_TEMP         0
> >  #define SMU_THERMAL_MAXIMUM_ALERT_TEMP         255
> >  #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES  1000
> > @@ -258,6 +260,7 @@ struct smu_table {
> >         struct amdgpu_bo *bo;
> >         uint32_t version;
> >         unsigned long  metrics_time;
> > +       uint32_t cache_interval;
> >  };
> >
> >  enum smu_perf_level_designation {
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> > index fca50f6a8ef6..5ead66375d38 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> > @@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_=
context *smu,
> >         return 0;
> >  }
> >
> > -static int smu_v13_0_12_get_system_metrics_table(struct smu_context *s=
mu, void *metrics_table,
> > -                                                bool bypass_cache)
> > +static int smu_v13_0_12_get_system_metrics_table(struct smu_context *s=
mu, void *metrics_table)
> >  {
> >         struct smu_table_context *smu_table =3D &smu->smu_table;
> >         uint32_t table_size =3D smu_table->tables[SMU_TABLE_SMU_METRICS=
].size;
> >         struct smu_table *table =3D &smu_table->driver_table;
> >         int ret;
> >
> > -       if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].=
metrics_time ||
> > +       if (!smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
> >             time_after(jiffies,
> >                        smu_table->tables[SMU_TABLE_TEMP_METRICS].metric=
s_time +
> > -                      msecs_to_jiffies(1))) {
> > +                      msecs_to_jiffies(smu_table->tables[SMU_TABLE_TEM=
P_METRICS].cache_interval))) {
> >                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetr=
icsTable, NULL);
> >                 if (ret) {
> >                         dev_info(smu->adev->dev,
> > @@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct=
 smu_context *smu,
> >         else if (type  =3D=3D SMU_TEMP_METRIC_BASEBOARD)
> >                 smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metr=
ics, 1, 0);
> >
> > -       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics, fal=
se);
> > +       ret =3D smu_v13_0_12_get_system_metrics_table(smu, metrics);
> >         if (ret) {
> >                 kfree(metrics);
> >                 return ret;
> > --
> > 2.46.0
> >
