Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF83CD3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0F010E522;
	Mon, 28 Oct 2024 19:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WztN4jHE";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939FC10E522
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:07:48 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-7eb0448693eso357961a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142468; x=1730747268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmDPY6XRAnIRLjjdnASSaDXJSw8xS1KmhRpI7ZyJqZo=;
 b=WztN4jHEm/X2WX04Uxd/sJ62qRqNnI8nfgiMMjhfCPSPbO3jb3QuPr4tQ+Jnd9IdPH
 g7rNzTjLKnLnPDrPD9n+bWxeH1ROn56UQFZbJEI/Jd+IZcv3uRH+5WHUgyGfKJ9wiTon
 ZeLZZaujQLh7whQV45GJl+ZU1zV7g4TIEojOgrhTArt2i8BBWEGZ+WN7pzYw898cK+V4
 g6Se11TyTygDClaYPQdy4b1f3UXEn1jyg1GP2YQcobH1sLE6LiEtOedVNQ1J+S4V087j
 hk3ynaV6X5SViB7Zd8oSND8M7GJo3ryybc2JyfUkYqatUyIa6PbFZRszqIrnu6gx1wZ8
 aKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142468; x=1730747268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmDPY6XRAnIRLjjdnASSaDXJSw8xS1KmhRpI7ZyJqZo=;
 b=qV035b3RS0CWIkprasbjGvJ0K1pkq/1J7CtwCTdWGD/SKS6ZBPsZ26qhRZDxzYU7+n
 W2IuzWeU+HmhKFY5RjKEOI90LeVidMtKEJjEzN+FVTOwvOba+tHD4z4fYNu7xnS3HxF3
 SVraQHyqSgTUdyZOt5Y13Tt8CTXZvX375uuWORIA1JVL7JntaynEvoCYvG1Pzl3cqgFw
 uqtCz32CEASavQ9smnWDkFmJ8wWJd0hrdnIcdr1TrBlY5fEDWOHsqHfUTGlJ+tY9v9Cu
 jsj4W9eFqhqj76A9Fwkquxv5yTQ/4loKUMgwR9wLcDVhuBZnhhA+gipflL8FbyU5fY6g
 ZsUA==
X-Gm-Message-State: AOJu0YxHQm9pNvfj/B9IMWK8OWGUsRU9Z1U7vpM936CkIaCCbzcBh2is
 0zpgu4cRaf8/A4RmTBO6vfbafdZi9DE2ASd3hKmO9Cev9Ca7/vHzduuvFZLYuMWneMlTwkf9cnD
 oeoICW6YM3Xg91z/qMjixUYxDPCk=
X-Google-Smtp-Source: AGHT+IHJK2qxkqzp8N9+gja7kK/lN5K8eQsSm0JO6Sxwa6FoYwgh+xsWhKGBA0KUZ1ilKPmnfSaVg9oUnyjKY6KFqCw=
X-Received: by 2002:a05:6a20:7486:b0:1cf:2be2:8dd2 with SMTP id
 adf61e73a8af0-1d9a851e0b6mr6258548637.11.1730142467874; Mon, 28 Oct 2024
 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-3-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-3-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:07:36 -0400
Message-ID: <CADnq5_NL3zNYG1CO1n68FLmNFX6ck+Mo-y_X1yAJ6jC-wPvOJg@mail.gmail.com>
Subject: Re: [PATCH 02/29] drm/amd/pm: power up or down vcn by instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 10:48=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> For smu ip with multiple vcn instances (smu 11/13/14), remove all the
> for loop in dpm_set_vcn_enable() functions. And use the instance
> argument to power up/down vcn for the given instance only, instead
> of powering up/down for all vcn instances.
>
> v2: remove all duplicated functions in v1.
>
> remove for-loop from each ip, and temporarily move to dpm_set_vcn_enable,
> in order to keep the exact same logic as before, until further separation
> in the next patch.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
>  .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
>  4 files changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index fe2a740766a2..ccacba56159e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -238,6 +238,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context =
*smu,
>  {
>         struct smu_power_context *smu_power =3D &smu->smu_power;
>         struct smu_power_gate *power_gate =3D &smu_power->power_gate;
> +       struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
>         /*
> @@ -252,9 +253,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context=
 *smu,
>         if (atomic_read(&power_gate->vcn_gated) ^ enable)
>                 return 0;
>
> -       ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
> -       if (!ret)
> -               atomic_set(&power_gate->vcn_gated, !enable);
> +       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               ret =3D smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i=
);
> +               if (ret)
> +                       return ret;
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index a9cb28ce2133..24cf17e172f4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1157,19 +1157,15 @@ static int sienna_cichlid_dpm_set_vcn_enable(stru=
ct smu_context *smu,
>                                               int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> -       int i, ret =3D 0;
> +       int ret =3D 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               /* vcn dpm on is a prerequisite for vcn power gate messag=
es */
> -               if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG=
_BIT)) {
> -                       ret =3D smu_cmn_send_smc_msg_with_param(smu, enab=
le ?
> -                                                             SMU_MSG_Pow=
erUpVcn : SMU_MSG_PowerDownVcn,
> -                                                             0x10000 * i=
, NULL);
> -                       if (ret)
> -                               return ret;
> -               }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return ret;
> +       /* vcn dpm on is a prerequisite for vcn power gate messages */
> +       if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, enable ?
> +                                            SMU_MSG_PowerUpVcn : SMU_MSG=
_PowerDownVcn,
> +                                            0x10000 * inst, NULL);
>         }
>
>         return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 2bfea740dace..bb506d15d787 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2108,18 +2108,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *=
smu,
>                               int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> -       int i, ret =3D 0;
> +       int ret =3D 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return ret;
>
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu, enable ?
> -                                                     SMU_MSG_PowerUpVcn =
: SMU_MSG_PowerDownVcn,
> -                                                     i << 16U, NULL);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu, enable ?
> +                                             SMU_MSG_PowerUpVcn : SMU_MS=
G_PowerDownVcn,
> +                                             inst << 16U, NULL);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index ecb0164d533e..5460f8e62264 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -1511,29 +1511,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *=
smu,
>                               int inst)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> -       int i, ret =3D 0;
> +       int ret =3D 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return ret;
>
> -               if (smu->is_apu) {
> -                       if (i =3D=3D 0)
> -                               ret =3D smu_cmn_send_smc_msg_with_param(s=
mu, enable ?
> -                                                                     SMU=
_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
> -                                                                     i <=
< 16U, NULL);
> -                       else if (i =3D=3D 1)
> -                               ret =3D smu_cmn_send_smc_msg_with_param(s=
mu, enable ?
> -                                                                     SMU=
_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
> -                                                                     i <=
< 16U, NULL);
> -               } else {
> +       if (smu->is_apu) {
> +               if (inst =3D=3D 0)
>                         ret =3D smu_cmn_send_smc_msg_with_param(smu, enab=
le ?
> -                                                             SMU_MSG_Pow=
erUpVcn : SMU_MSG_PowerDownVcn,
> -                                                             i << 16U, N=
ULL);
> -               }
> -
> -               if (ret)
> -                       return ret;
> +                                                             SMU_MSG_Pow=
erUpVcn0 : SMU_MSG_PowerDownVcn0,
> +                                                             inst << 16U=
, NULL);
> +               else if (inst =3D=3D 1)
> +                       ret =3D smu_cmn_send_smc_msg_with_param(smu, enab=
le ?
> +                                                             SMU_MSG_Pow=
erUpVcn1 : SMU_MSG_PowerDownVcn1,
> +                                                             inst << 16U=
, NULL);
> +       } else {
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, enable ?
> +                                                     SMU_MSG_PowerUpVcn =
: SMU_MSG_PowerDownVcn,
> +                                                     inst << 16U, NULL);
>         }
>
>         return ret;
> --
> 2.34.1
>
