Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A56C021A0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 14:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763BA88647;
	Tue, 11 Feb 2025 14:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="At4wSAb0";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47ACE88647
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 14:53:19 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa122f62b5so1259159a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739285599; x=1739890399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/2I5GNX9uMuD6l/2V3SeXFavAMWu1kxcLsgy8MUZt0=;
 b=At4wSAb07weUSxacVTX9VREdiGrRNXL3LhctAUd8MTpJZZPpC5mOmU8hlGcro6Cdwj
 8ySEz+z7E2NuCduhupWoi8EEzNJIAENNJwcQ9FNvzyrblm6mbvcH40fSU50ceydmG+/k
 HP2NuiJ4/TOKF8vw91cr0jQEjhkv6dTmHPAdeJVwYn/ftmtoS0KoKKPYQgPYaptEZRvP
 mrydyk/bdCTXH5ke53xZ8l2bx4S+owNOUSX/k6THBQokVDdjfYYf9t8JCyzbveil0SsU
 FhwAdECpCZ02j7Ta0vEEa3QM3AtjWjQdu2sddhqt7LJgxzvG7S32R1xPCXs5L7hhFBbd
 947A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739285599; x=1739890399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/2I5GNX9uMuD6l/2V3SeXFavAMWu1kxcLsgy8MUZt0=;
 b=oFz8goHMkT3XRkk1WOpBOnIQceCEwzSU4x5gZH1V1+adOZYgUJ+VMS+CBbkXb7qV/M
 T/v3fNJoH3yKv8l/o3tyO5/pzrQVmg1eDo7PZvbh5cxDXlawkJsEzyu3OHU6GlFomEsR
 qLwmt+p4+RQTf9gDPMxihVsBtdv7Phuq/l9encYr782z7rC9R1JIfTFcvRc08nDgpEiH
 czkJBFFMxhRwVv8cNHrJSYbOD3sn8zaG3RyOUaRP0YzES8NHUOnXKLe3qGzFgnUYKW2+
 7KxQXMlcQ+mmowANjiIN4jt4Vtj+5cDP3V7/0EN7VJ8o1IJz7vJOp0cfJ5RNlV5qVWNq
 cCqQ==
X-Gm-Message-State: AOJu0Yz5/zmaUdkapUyESnP2c2FAtxEBVQtifi/DLTQ2rD95O2/Es/t0
 VDDFlnykV1FWOZhMo+IgxQqB+Oj4Eh9qHZ+604xgioP17D6WzKnjHfQx0/9L+n1qOIS+2v14UQg
 oYNv0e9mkqcQ9MuZsAUMEG7mHgepj/A==
X-Gm-Gg: ASbGncuUV51FCPGdkXs0/BVj8AhuxCWiJAYQsQFIpALseuuJADBj3zXzzTVsVuvrGYG
 6IK9nRoKotVIETi5YikfqMOL9R5KmawCxzx2I32TW9bNpymPb46VZR4zov9L9QJGsywjS77BA
X-Google-Smtp-Source: AGHT+IEfOrz/VXtM8W2I+t6WkouHIza/nrxjkp56PCRxEa9gnmnFHqYXl728Ko0R390o/CW20mAr2YPJ3c8Z+JWwlNw=
X-Received: by 2002:a17:90b:3e8a:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2fa23f5df75mr11512168a91.1.1739285598620; Tue, 11 Feb 2025
 06:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20250210233132.583035-1-alexander.deucher@amd.com>
 <20250210233132.583035-2-alexander.deucher@amd.com>
In-Reply-To: <20250210233132.583035-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Feb 2025 09:53:06 -0500
X-Gm-Features: AWEUYZkYzZz3ubs9pEHZVkn9t2GJazrQ5WuhzEFUAy-Da_TT_u5uDcjTab4rPcc
Message-ID: <CADnq5_O-vFrd4_z6Q99G_KPmdSLyD=e1ero6RRZ+rR7DtH6hWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/pm: fix UVD handing in
 amdgpu_dpm_set_powergating_by_smu()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Boyuan Zhang <boyuan.zhang@amd.com>
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

Ping on this series?  This fixes a regression.

Alex

On Mon, Feb 10, 2025 at 6:42=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> UVD and VCN were split into separate dpm helpers in commit
> ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
> but the check at the top was still included UVD from an earlier
> version of the patch.  Fix the check.
>
> Fixes: ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu"=
)
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3959
> Link: https://lists.freedesktop.org/archives/amd-gfx/2025-February/119827=
.html
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 6a9e26905edfc..7a22aef6e59c3 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -78,7 +78,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_dev=
ice *adev,
>         int ret =3D 0;
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>         enum ip_power_state pwr_state =3D gate ? POWER_STATE_OFF : POWER_=
STATE_ON;
> -       bool is_vcn =3D (block_type =3D=3D AMD_IP_BLOCK_TYPE_UVD || block=
_type =3D=3D AMD_IP_BLOCK_TYPE_VCN);
> +       bool is_vcn =3D block_type =3D=3D AMD_IP_BLOCK_TYPE_VCN;
>
>         if (atomic_read(&adev->pm.pwr_state[block_type]) =3D=3D pwr_state=
 &&
>                         (!is_vcn || adev->vcn.num_vcn_inst =3D=3D 1)) {
> --
> 2.48.1
>
