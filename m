Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC13C77B71
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Apr 2023 12:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9AF10E356;
	Sat,  8 Apr 2023 12:39:03 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BCB10EDDA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 18:17:15 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-62ddb232ddaso1036235b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Apr 2023 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1680891435; x=1683483435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuwimqlPO9HpY2//fLh7FzFmSEeSG4CgWKNzgwGf5e0=;
 b=Pxebkcm9CczGaHvPx5PvvvRnR6vaeDp6HKms/KgNAqJQXvWemgVDWj5OCZHUEsr5j3
 G9LMgv/KajspUvAGyGLQ7Iszic6kbG9P2k5NSjI2veF2IMW/awCFrSItQeZmJWK2XLZ8
 i6eaSk3xj2bQYr9/oCtHhhg4bWIW25XK+DRij7sRFBY0PrKPBfd43oe3kVErQiVRHnnP
 rBC1NfOjx2peA67xPLFCrmXLrsiOeHJW2kZXiKf92yzvKxgztNNJ4tJanifs/JMLrTin
 Iun3CcwO27658Fb0advMSuPzDrAVtKjlY5wElw8gSey5BR3sb1CzIGcoUtpUEIO4NNiT
 hDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680891435; x=1683483435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuwimqlPO9HpY2//fLh7FzFmSEeSG4CgWKNzgwGf5e0=;
 b=iwAEUGihHqDb+965oF/B7QUqBlbkOiAFHOZ0owq6AgK453DsfERUmksnIrpU9Md9fW
 msnK/LT475ZtMW3ics/ms0NqJojlCDQCYNlfjg11NRcu1Sqkw4ROr3Y3hNRhmgRuRLUd
 fGl+NDFZD+EfyM8rqeCjDtivRpBpQ5KKI2SLPaFLS3k+4h6X605FvUvtBl+cKXybdWvW
 6VccGcdfPDA2A60GkhB8pZVwOIZfc7DZVIokwP3rjAwRc19GqygIugicldmgVYAkGLAl
 mcrBRz84bafE2nxCVz9y2l1T5E4R7y9UwxpmYkos/T8kJtujBizAVU/x/5pmzp4vCJca
 /K0g==
X-Gm-Message-State: AAQBX9ePY9zX/uwCz9MhURfc54dRh7pQ8RBZ2ok/+F6WI3j7Tywtz2m/
 mRwYaqsvT5e5DWWfnV2rue2vLa/W6ddynsxp89G349+XibdSGQYpC1YTcA==
X-Google-Smtp-Source: AKy350Y6wWEggvCrlIf1bje2atujKhf9qMM/qxlunzgcridw/Fvst4ed6hVP1rP9DeneT/1K3zn48LLIF486O17fgc0=
X-Received: by 2002:a05:6a00:2ea8:b0:61c:67d2:a332 with SMTP id
 fd40-20020a056a002ea800b0061c67d2a332mr1427088pfb.3.1680891434554; Fri, 07
 Apr 2023 11:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230331164041.1859088-1-trix@redhat.com>
In-Reply-To: <20230331164041.1859088-1-trix@redhat.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 7 Apr 2023 11:17:03 -0700
Message-ID: <CAKwvOd=5Uw=6_8erAq0gt_-URUqXgK2ZvtCv5Ch_VZdk01sayQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: remove unused num_of_active_display variable
To: Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 08 Apr 2023 12:39:00 +0000
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
Cc: tim.huang@amd.com, lijo.lazar@amd.com, andrealmeid@igalia.com,
 KevinYang.Wang@amd.com, kenneth.feng@amd.com, dri-devel@lists.freedesktop.org,
 Xinhui.Pan@amd.com, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nathan@kernel.org, mario.limonciello@amd.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, Kun.Liu2@amd.com,
 evan.quan@amd.com, airlied@gmail.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 31, 2023 at 9:40=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:1700:6: error: variab=
le
>   'num_of_active_display' set but not used [-Werror,-Wunused-but-set-vari=
able]
>         int num_of_active_display =3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks for the patch!
Fixes: commit 75145aab7a0d ("drm/amdgpu/swsmu: clean up a bunch of
stale interfaces")
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..f93f7a9ed631 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1696,8 +1696,6 @@ static int smu_display_configuration_change(void *h=
andle,
>                                             const struct amd_pp_display_c=
onfiguration *display_config)
>  {
>         struct smu_context *smu =3D handle;
> -       int index =3D 0;
> -       int num_of_active_display =3D 0;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
> @@ -1708,11 +1706,6 @@ static int smu_display_configuration_change(void *=
handle,
>         smu_set_min_dcef_deep_sleep(smu,
>                                     display_config->min_dcef_deep_sleep_s=
et_clk / 100);
>
> -       for (index =3D 0; index < display_config->num_path_including_non_=
display; index++) {
> -               if (display_config->displays[index].controller_id !=3D 0)
> -                       num_of_active_display++;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
