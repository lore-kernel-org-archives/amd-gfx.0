Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCA1CE7A91
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 19:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A19710E945;
	Thu,  5 Sep 2024 19:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kmek/Qii";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC5F10E945
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 19:54:57 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2d88ec20283so117776a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Sep 2024 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566097; x=1726170897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nA1YVxDr1nU5V0JegUXkk4VscfF5Rsqnuv47mdxNAYk=;
 b=kmek/QiiFDhPEDoM41rgvsexO1rcK1PO9wLFbkdSOKxINEK1pyIPgkLpPSy9rIbcnC
 cgwVzW98r2RjVf2RnyiZCvPR8ba4s1MIo+czvZ73AtALUJhcuYQEWamO0YyY7Lcrxfer
 JXjxof0z7ThBkofPaZjVacHrEaC99ddvC2jMeKdXkBkPpz1hNO36NDTqTHvg0QubGIG4
 Sv9o16/Be2PX6f6jgVoZHAeMAY/Rat2eSu1socGZqUVuCrlqmU/F54raYWZTDw8vm0Ws
 pp0APQzv2jc/JnUXe9VwggyFSCaEzW9wyL4lnPFdKxGcBc7Ub1P+rZmaLVYppshDBfej
 SfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566097; x=1726170897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nA1YVxDr1nU5V0JegUXkk4VscfF5Rsqnuv47mdxNAYk=;
 b=HMXRGKK8vF6zn87CroJNtdEWAt+MreUo5mFeBDpNYAfwWeI5JSSL5MHVJ2FzfQ6SXY
 +ndL2RqSH/lLm5Iq4BsaKjSDSNu/M87yzEFfAn1yNLxAGAwjxW2SuuxpUarRy5+3kTSh
 9EAdmUo9Wg36AxAdWxTPXfYRvW0nA7VblceaIJQzKQ+5aeaWH82axmrEgTRlQDVrgljr
 QMO76Q+l2yu9fUMGCRXr6Hy+1df6ZFd/lvAO34qn75IU1v4YnF+KuX3mQy1i1B7zo374
 lRJnwbtiDuBRyIyGX6VkHFkQGh5QUgoAwDge67IOUqhoppdAoRANZVuBHzuilNudJt66
 mhKA==
X-Gm-Message-State: AOJu0YwxuuiQacpS5d/DpwkDGD9r1EzyMxurVKTSlSM10oRWbU1f7kii
 36KF2rd8TS682mv9SnJdV7kwN5xSpTkT+AVS5pGOP0YLW/OfO198mqEG3iBGhkfhlTI9UCgIuH4
 clRkEhRRqO1i+B2O3vRTxP0UVnPl85w==
X-Google-Smtp-Source: AGHT+IGM3mc0nPCkKdtnEPRVISv/asSRi67Atvmmtq2CiFnH9EpUMNJBo14dN0X9ipCk/VI8BzbQMOgGEHAiV6VeYFU=
X-Received: by 2002:a17:902:d2c3:b0:206:b6db:499f with SMTP id
 d9443c01a7336-206f0367ab9mr1313575ad.0.1725566096589; Thu, 05 Sep 2024
 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240905074002.47855-1-kenneth.feng@amd.com>
In-Reply-To: <20240905074002.47855-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Sep 2024 15:54:41 -0400
Message-ID: <CADnq5_ND+oQKn_jT-twKPuRsaNY53geKEFKjHwZETZGeS2-poQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: update the features set on smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Thu, Sep 5, 2024 at 3:40=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com> =
wrote:
>
> update the features set on smu v14.0.2/3
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h         | 11 ++++++++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |  9 +++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_types.h
> index 12a7b0634ed5..5b3e38eb26b7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -439,7 +439,16 @@ enum smu_clk_type {
>         __SMU_DUMMY_MAP(BACO_CG),                       \
>         __SMU_DUMMY_MAP(SOC_CG),    \
>         __SMU_DUMMY_MAP(LOW_POWER_DCNCLKS),       \
> -       __SMU_DUMMY_MAP(WHISPER_MODE),
> +       __SMU_DUMMY_MAP(WHISPER_MODE),                  \
> +       __SMU_DUMMY_MAP(EDC_PWRBRK),                            \
> +       __SMU_DUMMY_MAP(SOC_EDC_XVMIN),                         \
> +       __SMU_DUMMY_MAP(GFX_PSM_DIDT),                          \
> +       __SMU_DUMMY_MAP(APT_ALL_ENABLE),                                \
> +       __SMU_DUMMY_MAP(APT_SQ_THROTTLE),                               \
> +       __SMU_DUMMY_MAP(APT_PF_DCS),                            \
> +       __SMU_DUMMY_MAP(GFX_EDC_XVMIN),                         \
> +       __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),                                \
> +       __SMU_DUMMY_MAP(FAN_ABNORMAL),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(feature)       SMU_FEATURE_##feature##_BIT
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index a31fae5feedf..7125f72d01f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -199,6 +199,15 @@ static struct cmn2asic_mapping smu_v14_0_2_feature_m=
ask_map[SMU_FEATURE_COUNT] =3D
>         FEA_MAP(MEM_TEMP_READ),
>         FEA_MAP(ATHUB_MMHUB_PG),
>         FEA_MAP(SOC_PCC),
> +       FEA_MAP(EDC_PWRBRK),
> +       FEA_MAP(SOC_EDC_XVMIN),
> +       FEA_MAP(GFX_PSM_DIDT),
> +       FEA_MAP(APT_ALL_ENABLE),
> +       FEA_MAP(APT_SQ_THROTTLE),
> +       FEA_MAP(APT_PF_DCS),
> +       FEA_MAP(GFX_EDC_XVMIN),
> +       FEA_MAP(GFX_DIDT_XVMIN),
> +       FEA_MAP(FAN_ABNORMAL),
>         [SMU_FEATURE_DPM_VCLK_BIT] =3D {1, FEATURE_MM_DPM_BIT},
>         [SMU_FEATURE_DPM_DCLK_BIT] =3D {1, FEATURE_MM_DPM_BIT},
>         [SMU_FEATURE_PPT_BIT] =3D {1, FEATURE_THROTTLERS_BIT},
> --
> 2.34.1
>
