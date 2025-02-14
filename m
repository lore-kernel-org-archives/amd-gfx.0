Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9197C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5286510E34B;
	Fri, 14 Feb 2025 14:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DGc5k+GR";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744E310E34B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 14:30:01 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cbf5so464599a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739543401; x=1740148201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5l/EK9KcoG15U4Wpw2LtbOKVuSPEW8YSQRLQfby1vb8=;
 b=DGc5k+GRXePRw0iPT/XBzC8HqciVL8Zdj1llp/TkBMnWyNupLAt1rWx/TrINmlX5rt
 i2+qAH4dsYe5pc00RjsqPpcCjN15+w6OATLviGUj2Dz/Zn1qYM5sziPuKThz+XwTgd7t
 IGZdWSWUvds4Yy+eaqfbLD6GRe/7LFVrj0+/MGaIAlODsEXdJ2R86ybPq7EWzTzLTnoM
 ZYCnqf8TirZFTnPqYp7ZtAMaIDS2Z5BEVgCfQ+odpd67294CaXtuRaLbf9gpVxvCe5KF
 f9XmWz6STwx1ZvJha3QkJ/A6GTihKyJ7B2gwvB65JU4tEbVMqygyio/sAt7UYWAKGtf2
 uq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739543401; x=1740148201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5l/EK9KcoG15U4Wpw2LtbOKVuSPEW8YSQRLQfby1vb8=;
 b=mI6ytawCLccaz/dEV9taYpGu+gtLVmMT3TxuzMfeaLQuYmfs7CjwzsEQY0H0FjJ73K
 bAwgHEqi74pcpYrK4GsVQHCs3slCDAULaFp+hUov9rUQJD0b7lNg/S6AB03eV+FWUslP
 gRIPpEAEH1qMEd8cOA14LU/CnmLDXpd9nrrYsHL3vC485XzrTkgKyBW3cKU0K2329UFu
 d+8WNLhwlo1ZDjdBm8majeVg1qjhgDeVRx709KSmrFbF5G6x6bEJ9z5AkHRd1JSDEYUC
 ONg3C0vpRqzp4RKq8h0dkHoYmdV1K1sYBGfYXpBkRRvZBMGmBqg/lvYULm/gxk//PXnH
 /e1A==
X-Gm-Message-State: AOJu0YxxxRLX/mdpVuo8xaytI2ZscHEqbDFJq8Dg4SPxV7kgFFF3pO2k
 iCFPLRr3nia3ECYX8X9Agm93zqKjACc74UpbRQabUHSLoixJli8ootjXdKkdGfnAih1h2skqXLT
 K9jIMSfWxpFTRM1smrWZPRxLYsZ2LwsgL
X-Gm-Gg: ASbGnctEK6e+kiE55aPdzuBAv0OPkJS4ycUKSEUYKT+ERVQrW/vDSTBQ80VvxsWa7cz
 xfBSdE873yUcUpNJAfO4mmPA/UdCBdfIu9aOkFNYXzxAiBpWFNkyc3ICaUJP0tFWkJ5H6p2Oy
X-Google-Smtp-Source: AGHT+IGEkqGJ1jEQzc31FTAMAY5l3YDclZYVh1e6V+OuJxhzeSxFvWTM0PDgYZjc2AJXvUmqo2k5r4biwQlFeqD16j8=
X-Received: by 2002:a17:90b:4c41:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2fc2ceb5215mr2051852a91.1.1739543400791; Fri, 14 Feb 2025
 06:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20250214111528.361280-1-kenneth.feng@amd.com>
In-Reply-To: <20250214111528.361280-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2025 09:29:49 -0500
X-Gm-Features: AWEUYZnHIq1LpbNvNatkxB5-oCwPew_JFs37pCjOPoKmE7-jyIZyJYRZ6nwZ7nU
Message-ID: <CADnq5_N5YpnnUG9U_2TOYmMsMHT4MB4nQee1YiB3F0UQiifSpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: extend the gfxoff delay for compute workload
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

On Fri, Feb 14, 2025 at 7:32=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> extend the gfxoff delay for compute workload on smu 14.0.2/3
> to fix the kfd test issue.

This doesn't make sense.  We explicitly disallow gfxoff in
amdgpu_amdkfd_set_compute_idle() already so it should already be
disallowed.

Alex


>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  3 +++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 ++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 15 +++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
>  5 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b9bd6654f317..4ae6fde6c69c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -776,6 +776,9 @@ static void amdgpu_gfx_do_off_ctrl(struct amdgpu_devi=
ce *adev, bool enable,
>  {
>         unsigned long delay =3D GFX_OFF_DELAY_ENABLE;
>
> +       if (amdgpu_dpm_need_extra_gfxoff_delay(adev))
> +               delay *=3D 5;
> +
>         if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                 return;
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 7a22aef6e59c..87de50b73a0e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -873,6 +873,20 @@ int amdgpu_dpm_get_status_gfxoff(struct amdgpu_devic=
e *adev, uint32_t *value)
>         return ret;
>  }
>
> +bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev)
> +{
> +       struct smu_context *smu =3D adev->powerplay.pp_handle;
> +       bool ret =3D false;
> +
> +       if (is_support_sw_smu(adev)) {
> +               mutex_lock(&adev->pm.mutex);
> +               ret =3D smu_need_extra_gfxoff_delay(smu);
> +               mutex_unlock(&adev->pm.mutex);
> +       }
> +
> +       return ret;
> +}
> +
>  uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device =
*adev)
>  {
>         struct smu_context *smu =3D adev->powerplay.pp_handle;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index 1f5ac7e0230d..312ad348ce82 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -470,6 +470,7 @@ int amdgpu_dpm_get_residency_gfxoff(struct amdgpu_dev=
ice *adev, u32 *value);
>  int amdgpu_dpm_set_residency_gfxoff(struct amdgpu_device *adev, bool val=
ue);
>  int amdgpu_dpm_get_entrycount_gfxoff(struct amdgpu_device *adev, u64 *va=
lue);
>  int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *v=
alue);
> +bool amdgpu_dpm_need_extra_gfxoff_delay(struct amdgpu_device *adev);
>  uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device =
*adev);
>  void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>                                  enum gfx_change_state state);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index a1164912f674..61cd170ec30a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -133,6 +133,21 @@ int smu_get_status_gfxoff(struct smu_context *smu, u=
int32_t *value)
>         return 0;
>  }
>
> +bool smu_need_extra_gfxoff_delay(struct smu_context *smu)
> +{
> +       bool ret =3D false;
> +
> +       if (!smu->pm_enabled)
> +               return false;
> +
> +       if (((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION=
(14, 0, 2)) ||
> +           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
14, 0, 3))) &&
> +                smu->workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE)=
)
> +               return true;
> +
> +       return ret;
> +}
> +
>  int smu_set_soft_freq_range(struct smu_context *smu,
>                             enum smu_clk_type clk_type,
>                             uint32_t min,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3630593bce61..82f06c2a752d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1626,6 +1626,8 @@ int smu_set_residency_gfxoff(struct smu_context *sm=
u, bool value);
>
>  int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
>
> +bool smu_need_extra_gfxoff_delay(struct smu_context *smu);
> +
>  int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);
>
>  int smu_wait_for_event(struct smu_context *smu, enum smu_event_type even=
t,
> --
> 2.34.1
>
