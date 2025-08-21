Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2180CA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 13:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44ABF10E995;
	Thu, 21 Aug 2025 13:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZU9OqlmK";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6389310E995
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 13:11:12 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2445813f6d1so1714025ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755781872; x=1756386672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0hPr408HGc7lyp1MHbATyYq9vjBXYLpofyIRBWhZ/s=;
 b=ZU9OqlmKl5/q5nSPeLQrq4q5sir6JM/eneD/bmgvAo60EnKF9kwjH5uya5Xj96stz0
 SaCliFoGt9H7Qc8Ek2u5ooWgyiitGRXPH57wpFGb8VR0MtcRiJUqbPRE0C6Etw4Q1Sh1
 8Ss7+J3MFKgzLTgCQa9tBx7gWdXkx0+dTUrhNnHg1NorRK1WATu1QxcyoiFmg2OjEeVF
 /fZezLWV+uH0wELxeGxNdXQyROPe9U9edsZ5OzCK3r3AYp696UaufUN/EfkfAtNcMy/z
 pq1jPLbs77X74EQ8HYjRsPffmWw0ufwR85z941l/BThtfJjWSLY5mOOzg+5bVsaVVFbZ
 pjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755781872; x=1756386672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0hPr408HGc7lyp1MHbATyYq9vjBXYLpofyIRBWhZ/s=;
 b=TtwCV8+OdkgVWB/Y0wHnGxXXd4cISNIBBuqwHBPDvr5U0kmCBtFtFHb2E782+G565l
 V2efEThlnVmjLQbTmzXnTrIUbuoa3hTJYFK4/1vdnEKn5Ps+wKWjBzlfjNZwsuT5GDqu
 SYCP9Seow/DF9w071eY2w8cRxQpNisZRK1+oy0BKoWjtgdbuv3RFERB1K3KfnxD7xete
 /JY5g7KpLDjwD5ps4y7q1lltY/V4Bi0oWeaECMIptGjIAnTEGm+wST8V38Ro9Vs4UZJT
 zTC2Y1vZnnX1iQGYJmAJxeUxPZplFNAr/g59bsuTRE1MjepN1gn440s412xsGyS3W7fp
 0Scw==
X-Gm-Message-State: AOJu0YwVnm0Gc7Zx4j5SQh3brRQJpjTqqVUkqumXS1yKSTJgIE4oJJ+g
 cz3lr62nSVhvbxgKhcFhLZOVcaKtd4n27mjY5I9YywqT8woT9HOTlAWFrkdp49+UG2EdxStAAmc
 eh2QIv67kBRs4v9sZh7hVZVeZoXaJyXz/sQ==
X-Gm-Gg: ASbGnctN5xJnVs5+jmMZm8cyvHHVICBNJAkvxUQWoR7GiNqgQ277qq0KXJ70FLoP6Hx
 FjEzk8tmNlPGDhf8kHEbuL9uN/rg6b0pJ7BvCb+uiQczVhHj0GikAbaj+K7sSKgz9Xw2QPiQ4Md
 Q0XQ38sKrcYekJxZs/ROtYCYZNC/lhVKPZUySCMtWJehYAlYRZq2NmJKbTe+1T+8tehIqmu3wea
 JLjrGeTBQ370+FG9Q==
X-Google-Smtp-Source: AGHT+IHQyTRCgoOnypG5f4iz37j6Cy4hs4B0YJVwws2gEQdOUGgRar/xijGRrqO746Ad32NmTz92I5gFLKgLrC7QYPU=
X-Received: by 2002:a17:902:d492:b0:245:f2c2:6504 with SMTP id
 d9443c01a7336-245febf340bmr16929665ad.2.1755781871756; Thu, 21 Aug 2025
 06:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250818073550.2074766-1-lijo.lazar@amd.com>
In-Reply-To: <20250818073550.2074766-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 09:11:00 -0400
X-Gm-Features: Ac12FXz1a5HEpYvkCyuP3itViWvV9BvOD0wesNlv9dNQ5eMHlDsgS33XjjuDOqc
Message-ID: <CADnq5_PqExwyc05YOv0b8ywE-_JUQHN1u3MNok0zn-GdDVBmQw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: Make use of __free for cleanup
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com
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

On Mon, Aug 18, 2025 at 3:44=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Use __free(kfree) for memory alloc cleanups in SMUv13.0.6
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: Use __free in metrics related functions also.
>
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 63 ++++++++-----------
>  1 file changed, 25 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 627a8188d868..b5d1b2427c3c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -535,6 +535,9 @@ static int smu_v13_0_6_tables_init(struct smu_context=
 *smu)
>  {
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>         struct smu_table *tables =3D smu_table->tables;
> +       void *gpu_metrics_table __free(kfree) =3D NULL;
> +       void *driver_pptable __free(kfree) =3D NULL;
> +       void *metrics_table __free(kfree) =3D NULL;
>         struct amdgpu_device *adev =3D smu->adev;
>         int gpu_metrcs_size =3D METRICS_TABLE_SIZE;
>         int ret;
> @@ -553,37 +556,32 @@ static int smu_v13_0_6_tables_init(struct smu_conte=
xt *smu)
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
>
> -       smu_table->metrics_table =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERN=
EL);
> -       if (!smu_table->metrics_table)
> +       metrics_table =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
> +       if (!metrics_table)
>                 return -ENOMEM;
>         smu_table->metrics_time =3D 0;
>
>         smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_metrics_v=
1_8);
> -       smu_table->gpu_metrics_table =3D
> +       gpu_metrics_table =3D
>                 kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
> -       if (!smu_table->gpu_metrics_table) {
> -               kfree(smu_table->metrics_table);
> +       if (!gpu_metrics_table)
>                 return -ENOMEM;
> -       }
>
> -       smu_table->driver_pptable =3D
> -               kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
> -       if (!smu_table->driver_pptable) {
> -               kfree(smu_table->metrics_table);
> -               kfree(smu_table->gpu_metrics_table);
> +       driver_pptable =3D kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
> +       if (!driver_pptable)
>                 return -ENOMEM;
> -       }
>
>         if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
>             IP_VERSION(13, 0, 12)) {
>                 ret =3D smu_v13_0_12_tables_init(smu);
> -               if (ret) {
> -                       kfree(smu_table->metrics_table);
> -                       kfree(smu_table->gpu_metrics_table);
> +               if (ret)
>                         return ret;
> -               }
>         }
>
> +       smu_table->gpu_metrics_table =3D no_free_ptr(gpu_metrics_table);
> +       smu_table->metrics_table =3D no_free_ptr(metrics_table);
> +       smu_table->driver_pptable =3D no_free_ptr(driver_pptable);
> +
>         return 0;
>  }
>
> @@ -2619,9 +2617,9 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct s=
mu_context *smu, int xcp_id,
>         const u8 num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS_4_0_3;
>         int version =3D smu_v13_0_6_get_metrics_version(smu);
>         struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
> +       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
>         struct amdgpu_device *adev =3D smu->adev;
>         int ret, inst, i, j, k, idx;
> -       MetricsTableV0_t *metrics_v0;
>         MetricsTableV1_t *metrics_v1;
>         MetricsTableV2_t *metrics_v2;
>         struct amdgpu_xcp *xcp;
> @@ -2646,17 +2644,14 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct=
 smu_context *smu, int xcp_id,
>                 return -ENOMEM;
>
>         ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
> -       if (ret) {
> -               kfree(metrics_v0);
> +       if (ret)
>                 return ret;
> -       }
>
>         if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
>                     IP_VERSION(13, 0, 12) &&
> -           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
> -               ret =3D smu_v13_0_12_get_xcp_metrics(smu, xcp, table, met=
rics_v0);
> -               goto out;
> -       }
> +           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
> +               return smu_v13_0_12_get_xcp_metrics(smu, xcp, table,
> +                                                   metrics_v0);
>
>         metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
>         metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;
> @@ -2727,8 +2722,6 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct s=
mu_context *smu, int xcp_id,
>                         idx++;
>                 }
>         }
> -out:
> -       kfree(metrics_v0);
>
>         return sizeof(*xcp_metrics);
>  }
> @@ -2739,31 +2732,26 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct=
 smu_context *smu, void **table
>         struct gpu_metrics_v1_8 *gpu_metrics =3D
>                 (struct gpu_metrics_v1_8 *)smu_table->gpu_metrics_table;
>         int version =3D smu_v13_0_6_get_metrics_version(smu);
> +       MetricsTableV0_t *metrics_v0 __free(kfree) =3D NULL;
>         int ret =3D 0, xcc_id, inst, i, j, k, idx;
>         struct amdgpu_device *adev =3D smu->adev;
> -       MetricsTableV0_t *metrics_v0;
>         MetricsTableV1_t *metrics_v1;
>         MetricsTableV2_t *metrics_v2;
>         struct amdgpu_xcp *xcp;
>         u16 link_width_level;
> -       ssize_t num_bytes;
>         u8 num_jpeg_rings;
>         u32 inst_mask;
>         bool per_inst;
>
>         metrics_v0 =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
>         ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
> -       if (ret) {
> -               kfree(metrics_v0);
> +       if (ret)
>                 return ret;
> -       }
>
> -       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 12) &&
> -           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
> -               num_bytes =3D smu_v13_0_12_get_gpu_metrics(smu, table, me=
trics_v0);
> -               kfree(metrics_v0);
> -               return num_bytes;
> -       }
> +       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
> +                   IP_VERSION(13, 0, 12) &&
> +           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
> +               return smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v=
0);
>
>         metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
>         metrics_v2 =3D (MetricsTableV2_t *)metrics_v0;
> @@ -2949,7 +2937,6 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct s=
mu_context *smu, void **table
>         gpu_metrics->firmware_timestamp =3D GET_METRIC_FIELD(Timestamp, v=
ersion);
>
>         *table =3D (void *)gpu_metrics;
> -       kfree(metrics_v0);
>
>         return sizeof(*gpu_metrics);
>  }
> --
> 2.49.0
>
