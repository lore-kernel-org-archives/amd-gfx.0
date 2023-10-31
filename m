Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC6C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 13:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1189410E4C7;
	Tue, 31 Oct 2023 13:22:37 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD0B10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 13:22:34 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1e98e97c824so3371524fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698758554; x=1699363354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1qJQnXjeDp3CgtRxPbMAthZNNeUV6Cf5lNR1akm13s=;
 b=iB/jUlsgh4uLMNAJhVh+P+/EHtd/SlkTPfEMc9H/h6bF/F7LgTvJkvNBw5wWLmgU9Z
 g3hu1+1mcJRAOPGP627VMEmiyqD/kFJ7tuKwIwm1aSWDaPQIBl8pkyRIlBQnOFDdrUna
 PRGhqhjfXF03GDSQIWt6Fyux/nTU1jrWjY5oySKlr9+sKJkxk1Z46LoqYxpCbipH8gz/
 HiAEmhrlXZNxF6qreusbJsAxupqcisi3y+pde3IjuPgOvhvIJddiuFKN1j+Kcy25j6Vl
 5jdad44r5VfM3J/7fSKDF1kOuWf+2KllSG1i4eNCazSGGLtPwBsKTK9HFPVnOWXS+Kpe
 QHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698758554; x=1699363354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1qJQnXjeDp3CgtRxPbMAthZNNeUV6Cf5lNR1akm13s=;
 b=OmDHtpRDNj7Dkjdia9jG2Yz0hUe/sWdeN9oPPmeYqaMkWC7i8p5URshAs/GgCCswLq
 eowJ99JA9UhiJiNkuZbZT8sTj3ZZVn2az+rEfrVGDG9qOSmdxY1b+WPfLgzAhFutEnyd
 Vy2LmZp1B74NZokURCSs67qqxZ5OjplG/H81mBBgx7zHfKOki/nXC9bTTFdmqB52vyNt
 3MEyVekeereXs0PpQyynLBjhg91hi3gviZr2u8OE6S4YZNzw4SCPB06yAvYMB6UsRIb7
 7Xoc8brTOG/9ZmRTkrwAxsTcWtkZfEYBVc+UY5PbDFAXk0C8S3ATLTf+AlQhew0XTs/I
 uTig==
X-Gm-Message-State: AOJu0Yw6UbOPUVp4swOywZX7kf7ehfi4bFKPBKiDsec+4NsEcjlz6bF0
 XMti5okHBHnvjZrpFB0Bnl0jpxuXbqcD2dYe9hQ=
X-Google-Smtp-Source: AGHT+IEqjvbUTPTyeD0QAhV5I1a4hPQSI6mDq9DZaXZx8IwgpNmq3MRfOWRH2eMaT/OYDs6O9WfEEnVjiHRppQGnwBY=
X-Received: by 2002:a05:6870:1202:b0:1ef:c082:ecc7 with SMTP id
 2-20020a056870120200b001efc082ecc7mr1254953oan.6.1698758554031; Tue, 31 Oct
 2023 06:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231031032305.2055080-1-li.ma@amd.com>
In-Reply-To: <20231031032305.2055080-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Oct 2023 09:22:22 -0400
Message-ID: <CADnq5_P85O0Rx5365bnrjyBaGhxGnmrngyv1JRzqd_GgUWYoVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/swsmu: remove fw version check in sw_init.
To: Li Ma <li.ma@amd.com>
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
Cc: yifan1.zhang@amd.com, xiaojian.du@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 30, 2023 at 11:37=E2=80=AFPM Li Ma <li.ma@amd.com> wrote:
>
> dorp fw version check and using max table size to init table.
>
> Signed-off-by: Li Ma <li.ma@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 3efc6aed28f1..762b31455a0b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -234,24 +234,15 @@ static int vangogh_tables_init(struct smu_context *=
smu)
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>         SMU_TABLE_INIT(tables, SMU_TABLE_ACTIVITY_MONITOR_COEFF, sizeof(D=
pmActivityMonitorCoeffExt_t),
>                        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, max(sizeof(SmuMetri=
cs_t), sizeof(SmuMetrics_legacy_t)),
> +                      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> -       if (smu->smc_fw_if_version < 0x3) {
> -               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuM=
etrics_legacy_t),
> -                               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_le=
gacy_t), GFP_KERNEL);
> -       } else {
> -               SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuM=
etrics_t),
> -                               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -               smu_table->metrics_table =3D kzalloc(sizeof(SmuMetrics_t)=
, GFP_KERNEL);
> -       }
> +       smu_table->metrics_table =3D kzalloc(max(sizeof(SmuMetrics_t), si=
zeof(SmuMetrics_legacy_t)), GFP_KERNEL);
>         if (!smu_table->metrics_table)
>                 goto err0_out;
>         smu_table->metrics_time =3D 0;
>
> -       if (smu->smc_fw_version >=3D 0x043F3E00)
> -               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_m=
etrics_v2_3);
> -       else
> -               smu_table->gpu_metrics_table_size =3D sizeof(struct gpu_m=
etrics_v2_2);
> +       smu_table->gpu_metrics_table_size =3D max(sizeof(struct gpu_metri=
cs_v2_3), sizeof(struct gpu_metrics_v2_2));
>         smu_table->gpu_metrics_table =3D kzalloc(smu_table->gpu_metrics_t=
able_size, GFP_KERNEL);
>         if (!smu_table->gpu_metrics_table)
>                 goto err1_out;
> --
> 2.25.1
>
