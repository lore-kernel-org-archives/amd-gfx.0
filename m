Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CDE77198
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 16:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A79A10E2DA;
	Mon,  6 Jan 2025 16:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iwA2Kl+z";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D05310E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 16:25:54 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2166db59927so21012765ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2025 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736180694; x=1736785494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzbDCOPXK/Fejq0FLR46gartHPGvBjgRbfcVoMEzj8E=;
 b=iwA2Kl+ziQ1iSeNJv9jVNn2mVu+84MD8JZen7Q9bA+9hbGwJdACUp5qwh2+seb0zOo
 vmSHmzRiozNQGfL0zC/R5JIiOWlghxI5LUyxSxviuvHp4evMSJD71dLOFXGwFJiM43Uc
 hLNSuav+WlBss4cyqX3OwcrVQ+QUtzQWSvvDqBxwNq//A+2SBULksAeI4DQzy4x8gCdP
 9kMeSn6YlS+XdCVWw7qrgwTqRlEnqc8lvIsJqCXVK4ab47fxPC0kggHwzxriWhcTgrXd
 ztDl/RLBeiA3lAHxeRQsrQpvdsWCw8UXzQ6XH5LMgp0cl3uB41hgWp+TE+p7jvXAsi97
 ifnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736180694; x=1736785494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zzbDCOPXK/Fejq0FLR46gartHPGvBjgRbfcVoMEzj8E=;
 b=qCpa/BWuI5Qc70+i2HEvFpjUtbfJEYwngs4lTVut6bwLN5lZBbv5418BZIxiRVcqu+
 k5vKwT8Q2NyvSll5FlWI/Rnf5rtcQDsIKDx4MVbZks2YWiOnTtrnH68DGlo/29jcIhTV
 CWzkI1RcKyXgM/NQMSggD4yUHRcuqMIv7gEH7FX2e3M5J2AztpioJOqMlMqSIXN6D5K5
 Ak4SiJogLBEeaOoOSbawVvLAzi8PTORyyV4y7mFRGcGn2t9a+onpFx9BsHFfGNNw7kLf
 iez2CGt8dn3fYUJBpj7lMBNTYf/sPej1okK+gb00hwn2YohWmj7ue81tVFO5hOEK3wUj
 fkiQ==
X-Gm-Message-State: AOJu0Yz2a4cHsa5bhiGjnn4ItuFBTqrU6yvHFr9Fk90JLcbigDC9+rZf
 CU/JgNHIktAnRQ5QPd6OVFZPRhSoRyEqTKgfBYpyjrAbrbbKkD5BNE68AwAoc3x+NpG+43BYYSk
 a3Na6T7Sxd57Mi3Z64UrpKCJlmrhvAOPd
X-Gm-Gg: ASbGncuvdZWb77GexdXqYW1qa8+B27mKJd3ecg93nauHuVqcQwOE3R5vATLt0tCY21p
 tuid25okvhV3FJeXbrGKwv5/No05ueer7T2pdjA==
X-Google-Smtp-Source: AGHT+IHldyuJPzDS4agnHe2j4bBYBPfaEdvxshBepTxEQeVdZgPB4Q72/OAiP3hbaxWRh4f1N26uai/rC3idghaNoB8=
X-Received: by 2002:a17:90b:5488:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f452dff7b8mr34343154a91.3.1736179126542; Mon, 06 Jan 2025
 07:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20241225080814.1692482-1-kenneth.feng@amd.com>
In-Reply-To: <20241225080814.1692482-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2025 10:58:35 -0500
Message-ID: <CADnq5_NT7mC--R=pSo62riPD05cVwzmXwKzakWWKnaU=sgduBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com, 
 alexander.deucher@amd.com
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

On Wed, Dec 25, 2024 at 3:08=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> add the interface to set and save the bootup workload type
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 27 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>  4 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 6a9e26905edf..92fa19cac32a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -349,6 +349,33 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_de=
vice *adev,
>         return ret;
>  }
>
> +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *a=
dev,
> +                                               bool en)
> +{
> +       struct smu_context *smu =3D (struct smu_context*)(adev->powerplay=
.pp_handle);

You need to check if is_support_sw_smu() before accessing the smu context.

> +       int current_profile_mode =3D smu->power_profile_mode;
> +       int saved_profile_mode =3D smu->saved_power_profile_mode;
> +       int ret =3D 0;
> +
> +       if (en && current_profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP=
_DEFAULT)
> +               return 0;
> +
> +       if (!en && current_profile_mode !=3D PP_SMC_POWER_PROFILE_BOOTUP_=
DEFAULT)
> +               return 0;
> +
> +       if (en) {
> +               ret =3D amdgpu_dpm_switch_power_profile(adev, current_pro=
file_mode, !en);
> +               smu->saved_power_profile_mode =3D current_profile_mode;
> +               smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_D=
EFAULT;

Should take the pm.mutex when you mess with the smu context.

> +       } else {
> +               ret =3D amdgpu_dpm_switch_power_profile(adev, saved_profi=
le_mode, !en);
> +               smu->power_profile_mode =3D saved_profile_mode;
> +               smu->saved_power_profile_mode =3D PP_SMC_POWER_PROFILE_BO=
OTUP_DEFAULT;

Same here.

> +       }
> +
> +       return ret;
> +}
> +
>  int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
>                                uint32_t pstate)
>  {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index 1f5ac7e0230d..5fe404bbb033 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_dev=
ice *adev,
>                                     enum PP_SMC_POWER_PROFILE type,
>                                     bool en);
>
> +int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *a=
dev,
> +                                   bool en);
> +
>  int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
>
>  int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..a6f748361198 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_conte=
xt *smu)
>                                 PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>         }
>         smu_power_profile_mode_get(smu, smu->power_profile_mode);
> +       smu->saved_power_profile_mode =3D smu->power_profile_mode;
>  }
>
>  static int smu_sw_init(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3630593bce61..c58fc31fb1d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -560,6 +560,7 @@ struct smu_context {
>         uint32_t workload_mask;
>         /* default/user workload preference */
>         uint32_t power_profile_mode;
> +       uint32_t saved_power_profile_mode;
>         uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
>         /* backend specific custom workload settings */
>         long *custom_profile_params;
> --
> 2.34.1
>
