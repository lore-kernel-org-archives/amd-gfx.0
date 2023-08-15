Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45149C001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 16:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC9210E261;
	Tue, 15 Aug 2023 16:56:31 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92DC10E26F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 16:56:29 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c4c7a83bcdso2192599fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692118589; x=1692723389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZM26tvCvtlobwWLcKWHNJmUua7GFsGB8JpozwDWy+g=;
 b=JPkHrDXWLIrorccD7o/p511Qk2NDw00oGls9BgPLdc/Yfgzk6HdOn3T6o8CpPxDGuy
 gZkFJUoZ2IMtFSYlW1sC35bbDnUnsTPq2DOLcu9jtqA+IBifC5jkEMOnupFNS2L/9vYG
 tsUX3uo91GLA68e1V2iR49pG1DSeg49ss8rTbHZWVdhgVYBv6bQkUpDsutBwR+lAp//2
 ezOty5AfBgfZtSfHhdynnW5qO6Nw+SdGZVOyuJD8LtJfsTa6LTj59lK2vFOFGczAgFoE
 D6qHM26yLEuJ+/sJw6NvbPGAprjOd2MoYPjW3PXw8REM39XgJddKcSbO0k3RigcvP5de
 QhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692118589; x=1692723389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZM26tvCvtlobwWLcKWHNJmUua7GFsGB8JpozwDWy+g=;
 b=JiZAwR/bzjXZM15lqodNqxDBZRrjcM5iWwpWn8e8Eta0ofPzbxW/1yObWPUIQwe9vf
 qQeC1ZJ2BTv/e5rePLEjUj17Qmqu+ZKguiN+UmoTazvrzKt1CS8RrBoDvmmYceAVqg85
 67yQ0lqln6qx+DDCvSo5nKJvJsKDm/TgTO+XO0uAsF6I3PvR0XF2ioBt+rUvptBs2Elf
 rel8UydDE3GJseJKqbDCjEfbhRNEUNG1v1IxDhrR2IWY5Bw/7FYWW+J4QU8FvLqTd51F
 ZZC4SvV85ojeAT+BsXhiSngz0FDKN7xGxy73osdjF8VIAmX46W0Ym8C7HSo/BZn5BRMh
 HU1A==
X-Gm-Message-State: AOJu0YyQdBcViWCISzUEpVAdg+2PZnA7a+kjzkHNKRQPVNWYQ+mj+io5
 EaMvF09DzhI69FVHKXPRH/uOxeE+Fd0wREgUaQw=
X-Google-Smtp-Source: AGHT+IF2FwXKxI80mmPEBWn8PFf5MOJfQbPUJuXBqMTeKNBqbi2rVDePdCcIHkrM/FvoWfcxP0NoPnrDSgFkXNsw8Wc=
X-Received: by 2002:a05:6870:7027:b0:1be:ec3b:3ae1 with SMTP id
 u39-20020a056870702700b001beec3b3ae1mr13388463oae.50.1692118588951; Tue, 15
 Aug 2023 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230815085710.842188-1-kenneth.feng@amd.com>
In-Reply-To: <20230815085710.842188-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Aug 2023 12:56:17 -0400
Message-ID: <CADnq5_N6436Mdqz+V4er+=VFm=6O_C=i5T3R2+Nkc_eqh8uZLw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: allow the user to force BACO on smu v13.0.0/7
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 15, 2023 at 5:05=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> allow the user to force BACO on smu v13.0.0/7
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Would it be better to default to BACO?  It would save more power at
the expense of resume latency.

Alex


> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 895cda8e6934..52e9c7611013 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2263,7 +2263,7 @@ int smu_v13_0_baco_set_state(struct smu_context *sm=
u,
>         if (state =3D=3D SMU_BACO_STATE_ENTER) {
>                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                       SMU_MSG_EnterBaco,
> -                                                     smu_baco->maco_supp=
ort ?
> +                                                     (smu_baco->maco_sup=
port && amdgpu_runtime_pm !=3D 1) ?
>                                                       BACO_SEQ_BAMACO : B=
ACO_SEQ_BACO,
>                                                       NULL);
>         } else {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a5857acee641..12ccc12657d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2211,7 +2211,8 @@ static int smu_v13_0_0_baco_enter(struct smu_contex=
t *smu)
>
>         if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>                 return smu_v13_0_baco_set_armd3_sequence(smu,
> -                               smu_baco->maco_support ? BACO_SEQ_BAMACO =
: BACO_SEQ_BACO);
> +                               (smu_baco->maco_support && amdgpu_runtime=
_pm !=3D 1) ?
> +                                       BACO_SEQ_BAMACO : BACO_SEQ_BACO);
>         else
>                 return smu_v13_0_baco_enter(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 93b3e8fa8238..f0bcc7995983 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2139,7 +2139,8 @@ static int smu_v13_0_7_baco_enter(struct smu_contex=
t *smu)
>
>         if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>                 return smu_v13_0_baco_set_armd3_sequence(smu,
> -                               smu_baco->maco_support ? BACO_SEQ_BAMACO =
: BACO_SEQ_BACO);
> +                               (smu_baco->maco_support && amdgpu_runtime=
_pm !=3D 1) ?
> +                                       BACO_SEQ_BAMACO : BACO_SEQ_BACO);
>         else
>                 return smu_v13_0_baco_enter(smu);
>  }
> --
> 2.34.1
>
