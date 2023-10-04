Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA79E784A9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 14:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B8E10E381;
	Wed,  4 Oct 2023 14:04:37 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C690E10E381
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 14:04:35 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dc9c2b2b79so1301323fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696428275; x=1697033075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPr6lnsE40Oze6BU0NaZ8M9TYX2G9Zl61MY0Lh9nnGI=;
 b=eMN0gW+/5+/MpeZiyHMtStJnxiRsK0Jn7fhfftyeEphKsWqGOaxSe4JHxmU7m4XjG3
 i3dIOQZVkmwYCUAGacHldA+r/RBmaL99YeprK/aQ2rwW2o6LWKC9XcsEZNjubyTdnrgc
 TsxCRld2UjeHltXxKrD70urOdzKu3jZXKQfqt0yE8biVG/lh308MCGsbOTR2n0cXwkX+
 oQZjSwveZtF2c0+5DPOjuSEAgsaDVO5qrudj23dd6uiU3KGIsoL320NgEZYmyMtcD4Hh
 2QdS13V11Kut7SoW7Qd/p2luBOT3pS1eTzThv9pWTJa8l4Tw7/Y8Ou6o3DBnA0tGDQel
 Y1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428275; x=1697033075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPr6lnsE40Oze6BU0NaZ8M9TYX2G9Zl61MY0Lh9nnGI=;
 b=DJCSJR2ga7GG4Y1RF0wNa1NSxuU4wMPQY9T3A2WB6GG8YGc72UgDfBu9M9KSU+j3a/
 i01v9bg8zuIaiDKRtOeTZ3N5NMX4XsU/F5YxlchUdULSzEeiQr7sDGZMQIxLSORRRP2+
 VyTsZJp68qEQLRBN1n3udj49W6uuIJnCze/50MIf6lkLiaILnyTeKDG7bhiO1GoVYPLX
 fqiawRYw8W/tADwKvKGLYnbjuAzA3NddTnQbF467eqDuoYf0/i8xF3aSyzqn6P9eZJ6g
 xZpX9k40oSanbB3Ea7u3YYJTVZmzYk9Ap3rdMXx5ngu6xRpX+TGy0ZIaRjfYjRWL3xEF
 T2TA==
X-Gm-Message-State: AOJu0YzS+nVL8LyWoAXeTxAXXLTxawNinMLcFp9HJveBfGsq9/AGn+ta
 2ypia2ICTLc8PJgK0WaI1k4sNLJNDBjRaWJPh0M=
X-Google-Smtp-Source: AGHT+IHKuJD0E2MeJ/WetqRRwAlpyfeO2vTuhtN8fFAzGJGwKbvhfZgwFbWWMKqsYbIPBqRvVd5lSzpBDUnlsk/+xs4=
X-Received: by 2002:a05:6870:c14f:b0:1c0:fe16:90f8 with SMTP id
 g15-20020a056870c14f00b001c0fe1690f8mr2726884oad.57.1696428274789; Wed, 04
 Oct 2023 07:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231003190731.106594-1-alexander.deucher@amd.com>
In-Reply-To: <20231003190731.106594-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Oct 2023 10:04:23 -0400
Message-ID: <CADnq5_OTfvO0piqPPnvMrJCq9YJmQ8pJrPZh_Fuz1MNNikv-6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Tue, Oct 3, 2023 at 6:47=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> When ROCm is active enable additional SMU 13.0.0 optimizations.
> This reuses the unused powersave profile on PMFW.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 38b5457baded..b6c0c42de725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -714,6 +714,14 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_de=
vice *adev, bool idle)
>         amdgpu_dpm_switch_power_profile(adev,
>                                         PP_SMC_POWER_PROFILE_COMPUTE,
>                                         !idle);
> +       /* Add optimizations for SMU13.0.0.  Reuse the power saving profi=
le */
> +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0=
, 0)) &&
> +           ((adev->pm.fw_version =3D=3D 0x004e6601) ||
> +            (adev->pm.fw_version >=3D 0x004e7300))) {
> +               amdgpu_dpm_switch_power_profile(adev,
> +                                               PP_SMC_POWER_PROFILE_POWE=
RSAVING,
> +                                               !idle);
> +       }
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> --
> 2.41.0
>
