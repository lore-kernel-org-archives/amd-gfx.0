Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED93C3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 13:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A55210E5AB;
	Tue, 13 May 2025 13:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UMLKrVFX";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56E10E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 13:59:46 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-22e3ed5ee1cso5945875ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747144786; x=1747749586; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnPO3C8Icf8X7RcTbKO2KwJLmP84RF29y6Paz5okCP8=;
 b=UMLKrVFXd0G7PBzzwhOOuvoQ9DknAUmeTZr7HnyxmMCEA3IXvDGXNRLOnL8uoST7o7
 C0K/Cx3Q0IEMOcV+vxnC7vBsrgBnxyaaiVuMnj/qn/e7pIxj49zQlTNtxgP3MklVrjrq
 JlOFyKDYz3QeXIQuyja6tmcGzNB84P3cxseSO0/SZH1RA0Z2I8bQ6eKm5QJTkgASRykj
 Vjklx1/x+Aok8je9s2MhqOuCQCS/FsKBhRVyTUBSZZKq1fH7t7BDcvzv7rB8WrCvRAcN
 93sXE+X1BRml0rtgTSP2Rj3gp005NlbuI1AyL/69/PugFa5Dy5DSgZWdJBmfOio1s/0f
 RwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747144786; x=1747749586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnPO3C8Icf8X7RcTbKO2KwJLmP84RF29y6Paz5okCP8=;
 b=Sy127PVwiwsPfA7UvJxYzmTxRovzIDE0/7hZSeSsmhM3vqLq/nCayF03YJ+1cVULet
 E9H3BKVrDcFFlRDqejxl/IS6BQrf7QpgFIrL/THoToSsA+ABfSL8ERkguYB44vqip+sd
 KDo2+f9KsMmw2532sgfA0MgUmHgbgtStc/O7b2omrM2erAztlsg7hSeX84kqtcNJH3zf
 nv36EmJbYX7dPn+iUd21gmO6isPRu2DSgkIpv2H+IF2ITe4EuXTUdUnAI/0Tsuhyuue9
 F24esOueHuh1GzwNjv9nveQEZBKsASjWiA25uQsTY11UTL68zGmPvKI2nwrADjfwt48W
 kdqA==
X-Gm-Message-State: AOJu0YzPHhfYcn8eeYzL788uLbYTUzwUC5mN1RuNuUAN7dCxodySKuSt
 Lcw3fqxtObVXL+ZOL8UN4eJU68ERYz1AF2dDqGrVA24f4fz41xvOta5wkv1wcQchmtjm43FFUE2
 ejnFBhZFngoECLlNAddtwmM2i2tglzA==
X-Gm-Gg: ASbGncvgCWct7eSZtFbw8TaABJvZ3eSEh+3xLQVG0W+mjRqeE9flx8ORWn27vhEgO2J
 ot7fU3yJoe9tuFodN5m7Nqg47OztM82V+iKOwuRWSnz3BVYK7P7w7s8magYqoL3JNbNk6kcd/Mr
 exVsp4rtLyWwtHmLjRdzGxSuN/KXYBJR6p
X-Google-Smtp-Source: AGHT+IEsybMFf5BpJkHavwfK2Z36ObuKh4zRsQoP13AQDQaQT0g6QnwfOXKvWEjgHIuAIgHjXHanXGj1jV/IGFtSJU8=
X-Received: by 2002:a17:902:e54f:b0:22f:b00d:fe59 with SMTP id
 d9443c01a7336-22fc8d98a69mr97151565ad.9.1747144786290; Tue, 13 May 2025
 06:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250513134953.417516-1-lijo.lazar@amd.com>
In-Reply-To: <20250513134953.417516-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 09:59:34 -0400
X-Gm-Features: AX0GCFuA6F8WlGCaGqrTGd9NkiJwjKzq7K82OX9XXpRMoM7jBXTBL4xI-zh0Ulg
Message-ID: <CADnq5_OfEXZxivfxxO513TpHWS-ae5QPRKt4-uQp6NNZXjP43Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Move SMUv13.0.12 function declarations
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

On Tue, May 13, 2025 at 9:58=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Move them to SMUv13.0.6 header file as they are used only in SMU
> v13.0.6.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         | 9 ---------
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 8 ++++++++
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index 9d4cb54a45de..4263798d716b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -298,14 +298,5 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_cont=
ext *smu,
>
>  void smu_v13_0_interrupt_work(struct smu_context *smu);
>  void smu_v13_0_reset_custom_level(struct smu_context *smu);
> -bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
> -int smu_v13_0_12_get_max_metrics_size(void);
> -int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
> -int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
> -                                     MetricsMember_t member,
> -                                     uint32_t *value);
> -ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **tab=
le);
> -extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
> -extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 6e7293d3f264..1ccc150882eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -75,4 +75,12 @@ extern void smu_v13_0_6_set_ppt_funcs(struct smu_conte=
xt *smu);
>  bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6=
_caps cap);
>  int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
>
> +bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
> +int smu_v13_0_12_get_max_metrics_size(void);
> +int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
> +int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
> +                                     MetricsMember_t member, uint32_t *v=
alue);
> +ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **tab=
le);
> +extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
> +extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
>  #endif
> --
> 2.25.1
>
