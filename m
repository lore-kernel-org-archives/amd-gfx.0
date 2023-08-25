Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FB0C3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 13:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8FE10E690;
	Fri, 25 Aug 2023 13:07:02 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6118510E690
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 13:07:01 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5733d431209so558781eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692968820; x=1693573620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaSWuHdx3cpUz13HQr0N7sa9LJkhO7ZEQ50ruv2o+RM=;
 b=aZTKJ23oU/OXrmOv7i0jdlowred2J9pZ1Q13WBJ23Ed+MMCd5KdLAhEgAQS0kwNYh9
 V2nn0AnD+o3CnV4EblMbKUN3mV37jC1jYj5Tgyr3NyFFanHU1BxmBn8kiQnz5I34iCjK
 oryAQRXKNWJP9lBy56Bhrs8PdLHLGcuoC8t19GIll5VIZuL5IAkBoj+l6dhQ5RrUZvfq
 hGu783v08sGyP9P303NUVxG8UCjqIb8Le4dFNC2KJ1pX07zIhWl6Pg0Q7Fha8+RET+sE
 ah6V+4uuezjZscSLKA240hPY2MskKVOgHZxtTMejfzBgJzIv4Tokf9uAHcR4/MNkWwrj
 IpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968820; x=1693573620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaSWuHdx3cpUz13HQr0N7sa9LJkhO7ZEQ50ruv2o+RM=;
 b=eMvThEkpN1/S3GLaWad/jbTM3CWA7NgUJP4LugPxLbTzYJAnR2WPLxRU1nakS+SQBL
 V3S+K7sMbH8omWpVpnXVVNcyZ7i0VuJLyu/pa+S8sufxm8tXVcqAG8/uox67NQcTZepU
 F9pJtE+6ZnHCSRlYQrDsWg5RBEcba2vrYP726zsNjRMYRVMw9UhpG0k5R3uM/uXlq6is
 ENx+jxC9O1MOx5vpl/rm7Ze4MKXYWqLgoU8ABLjir5tMH/1sRBiU0fgaAGLUeCgAUmiW
 dLc0SAvOGUuA4dIaFiLmFoPx+TD3FbIR6aZXquq184BrStuG8qfD8AnZ6mEwR3EEougk
 9rvA==
X-Gm-Message-State: AOJu0YysTf4xX/zjUhPsJ58e0bs6G6N5IviqJ0OsriMk4kEwoui30Kaj
 UdL3hmYzxZSP0hwPAPZ3U1MJgPE5vJUCJf5IepSD5jyC
X-Google-Smtp-Source: AGHT+IGjs+sPNzb5ZtV4/sVaPZczn3+SZANEV5UOpnGLh8UNi4QdZ4RKFxLMP1bUCttCawKw/A8NijZB9z5HYqHHIeE=
X-Received: by 2002:a4a:dfb4:0:b0:56d:10bb:c2d4 with SMTP id
 k20-20020a4adfb4000000b0056d10bbc2d4mr4788380ook.1.1692968820544; Fri, 25 Aug
 2023 06:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230825031926.1932471-1-kenneth.feng@amd.com>
In-Reply-To: <20230825031926.1932471-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Aug 2023 09:06:49 -0400
Message-ID: <CADnq5_Pjp03KqBbvLJwxKAqwUCk3Wrqd0Bmo95rzU0ZDjqR3DQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: workaround for the wrong ac power detection
 on smu 13.0.0
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
Cc: evan.quan@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 25, 2023 at 3:35=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> workaround for the wrong ac power detection on smu 13.0.0

Is this to work around the bug in the power supply code for USB
controllers or something else?  If so that was already fixed upstream
so this is really more of a candidate for stable rather than -next.

Alex


>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 +--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0232adb95df3..fd1798fd716e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1021,8 +1021,7 @@ static int smu_v13_0_process_pending_interrupt(stru=
ct smu_context *smu)
>  {
>         int ret =3D 0;
>
> -       if (smu->dc_controlled_by_gpio &&
> -           smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
>                 ret =3D smu_v13_0_allow_ih_interrupt(smu);
>
>         return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 3903a47669e4..128468355375 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2664,7 +2664,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_f=
uncs =3D {
>         .enable_mgpu_fan_boost =3D smu_v13_0_0_enable_mgpu_fan_boost,
>         .get_power_limit =3D smu_v13_0_0_get_power_limit,
>         .set_power_limit =3D smu_v13_0_set_power_limit,
> -       .set_power_source =3D smu_v13_0_set_power_source,
>         .get_power_profile_mode =3D smu_v13_0_0_get_power_profile_mode,
>         .set_power_profile_mode =3D smu_v13_0_0_set_power_profile_mode,
>         .run_btc =3D smu_v13_0_run_btc,
> --
> 2.34.1
>
