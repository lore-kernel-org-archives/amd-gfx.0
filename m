Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2098C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74110EAF3;
	Thu, 22 Aug 2024 14:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bjnSnH63";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3AB10EAF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:35:28 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso102153a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724337328; x=1724942128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/ZRHAeLLOXiB5Hw/Ri1SH7hLdDgE93dP9qwqagxYYM=;
 b=bjnSnH63DqwFd3DUKE9zhB6001HglmnG7P6ocxNZpYhTypRAQiAIhhcI8LqDJuTR7D
 ocT8E1O0ittkyogXutcBpcdXxTrqKn+S4aKbQLitZKt5NHrh/vOOOq2Ump0Ltckp+bxP
 MwaM5aytEx9ytktixt6+3c2OY3OWrNqo81EgTMsRcCgURA9PQqBMPN1afoISSNty1Pe7
 f74smoWuCgDQU4rKHWVcRqVxI3WZonprJXhdzhRGLUYKA2H6w4niY39tEtiLPABRKbO+
 WwqRXOxltjR0/G8rD0pgmcBbmvg9cYrunHQF6DfxymNn2tCsf6ySpHnFcIPKJtnqWhXN
 y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724337328; x=1724942128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/ZRHAeLLOXiB5Hw/Ri1SH7hLdDgE93dP9qwqagxYYM=;
 b=L6wshwCsCs8WBYxcNIuieM605mbkxyo2bIGoht0elFgkpSDYEtmVLyiIS9RD9XZbbg
 NDP/a+G7aMeJI+Nd+23teVt6yfppStvRop2nAJwcffzam2YNGAJdCdOyRqnYRc9NMoAj
 rDj2GiSPXHdTMMUMuDja3XGfh3cNZHO59HzXEb5K1WDdeXzcvWslZgc/DVOgI/z9VaTi
 GRQrsD7haowh8TH2J99p9goCQviBaYy4ZGLrMRhao7cawC1/gCktQ1sdEUG19cVlabJp
 J+j+o1N2I0daGGDGkFGq1T8aJGlhWxJTPH0lKw2itZl88BIRcrVb2Lg8KnHx0AE8vYMs
 0P8w==
X-Gm-Message-State: AOJu0Yx0XJVDfQgx0QylWnfkkiPYZZlpE/oHWtKiskFcDZ1eB8mVLw3a
 wt9ps1Yl49DICnlU7RuPRzc4zz1VcITwxGGdZuF9f69mUPLEgXkwF/985mmqebB6aRIipHzSBux
 WtUgmf9LcotyJ+AAgBXYIDFZTNB76AA==
X-Google-Smtp-Source: AGHT+IEP8yvOzs4ExMWbrxbWMMm0QCAR29zbsaIue3i41oj5ZRpkYtgamBJIvq0Ts7QlwRMRoklTKYRYrAorKmSobuA=
X-Received: by 2002:a05:6a00:13a5:b0:70b:705f:dda7 with SMTP id
 d2e1a72fcca58-714235f0d8bmr3985990b3a.4.1724337328071; Thu, 22 Aug 2024
 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240822021235.1699703-1-candice.li@amd.com>
In-Reply-To: <20240822021235.1699703-1-candice.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 10:35:16 -0400
Message-ID: <CADnq5_PQS0ZOsziAQ14FM2BEoFJHx72YmQeD8SHy75tx5hsSDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Drop unsupported features on smu v14_0_2
To: Candice Li <candice.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Yang Wang <kevinyang.wang@amd.com>
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

On Wed, Aug 21, 2024 at 10:12=E2=80=AFPM Candice Li <candice.li@amd.com> wr=
ote:
>
> Drop unsupported features on smu v14_0_2.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 47 -------------------
>  1 file changed, 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 5913f9c60fe002..391d06cc6e5816 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2115,50 +2115,6 @@ static void smu_v14_0_2_set_smu_mailbox_registers(=
struct smu_context *smu)
>         smu->debug_resp_reg =3D SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMS=
G_54);
>  }
>
> -static int smu_v14_0_2_smu_send_bad_mem_page_num(struct smu_context *smu=
,
> -               uint32_t size)
> -{
> -       int ret =3D 0;
> -
> -       /* message SMU to update the bad page number on SMUBUS */
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                         SMU_MSG_SetNumBadMemoryPagesRet=
ired,
> -                                         size, NULL);
> -       if (ret)
> -               dev_err(smu->adev->dev,
> -                         "[%s] failed to message SMU to update bad memor=
y pages number\n",
> -                         __func__);
> -
> -       return ret;
> -}
> -
> -static int smu_v14_0_2_send_bad_mem_channel_flag(struct smu_context *smu=
,
> -               uint32_t size)
> -{
> -       int ret =3D 0;
> -
> -       /* message SMU to update the bad channel info on SMUBUS */
> -       ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                 SMU_MSG_SetBadMemoryPagesRetiredFlagsPe=
rChannel,
> -                                 size, NULL);
> -       if (ret)
> -               dev_err(smu->adev->dev,
> -                         "[%s] failed to message SMU to update bad memor=
y pages channel info\n",
> -                         __func__);
> -
> -       return ret;
> -}
> -
> -static ssize_t smu_v14_0_2_get_ecc_info(struct smu_context *smu,
> -                                       void *table)
> -{
> -       int ret =3D 0;
> -
> -       // TODO
> -
> -       return ret;
> -}
> -
>  static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
>                                            void **table)
>  {
> @@ -2897,12 +2853,9 @@ static const struct pptable_funcs smu_v14_0_2_ppt_=
funcs =3D {
>         .enable_gfx_features =3D smu_v14_0_2_enable_gfx_features,
>         .set_mp1_state =3D smu_v14_0_2_set_mp1_state,
>         .set_df_cstate =3D smu_v14_0_2_set_df_cstate,
> -       .send_hbm_bad_pages_num =3D smu_v14_0_2_smu_send_bad_mem_page_num=
,
> -       .send_hbm_bad_channel_flag =3D smu_v14_0_2_send_bad_mem_channel_f=
lag,
>  #if 0
>         .gpo_control =3D smu_v14_0_gpo_control,
>  #endif
> -       .get_ecc_info =3D smu_v14_0_2_get_ecc_info,
>  };
>
>  void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
> --
> 2.25.1
>
