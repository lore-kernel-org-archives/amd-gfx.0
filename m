Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6204CCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB73910EA29;
	Thu,  9 Oct 2025 12:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VxymAukT";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF2210EA29
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:46:33 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b631a684a9fso62567a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760013993; x=1760618793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UrXaVfO3NFs3Oyi215Renu6iA60sUwRiD2uTGvc51o=;
 b=VxymAukT0F9vHKTaSBJYYdq6Ax4y2fD4guO/uvkaSFaF2EVAEHQtnFhcpvy6YD1n5Z
 QkNeylNQNAw6BpZ1LJNUOsMcxuwebC3wFrJd1oKPTc0p5tEoRxC5ZCCmY9zGLpqiaMXJ
 uZVsJ1YfG0vpbkEHZjYyqw4s15m7Cp/ufkWulJCviiHG4hws7i9NaKNV+mpocPL51iz+
 MTOK4kxEcYCApo+Rp+RHqGz9GCmm8QtfUptzy9SMgEFCvNa1RNeRbsBn3TJgQ6WNK08G
 TRJ66WzXOkminYmKsYzxy+A92N+tnL/80vn+1cqLsWydHJu2Znlf+Wz6M6pTf74dQtre
 M44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760013993; x=1760618793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UrXaVfO3NFs3Oyi215Renu6iA60sUwRiD2uTGvc51o=;
 b=hPf4FtxEVOGMmTGCXKFMZ+wKAsLAACCabXjShg3T8NNelmVyDjBfwjl1pfc0CPecVG
 IVt2+jfG/tYbO4yK3XTDHzZGpP3yjVnHHErI6KEsXzJxYCcDlb1gfT7J0MesSrcMVVR1
 ygp3+iIg4nYp0GFlXDb1N7moco+r8rMEyepe+oPz2OuklmVTSMG0CAAi5lmpKBPgu2mW
 8SXCCbTyHk8RlRWgrMtI7Gy+MEx0yEUhsFPoIntsjVOHIAnBF+Uu4ZoaexI6yOGeI46n
 /FJDaad8opi6KJHdfMjuVM7jHBKckdLONqHBs+VkYJ6zfhjOwX3D0cWglrslF0lT8Wy5
 yk6w==
X-Gm-Message-State: AOJu0YxDch77tiJdsfTAdBw759Nw9z67UnksUj/v3YXwogI+hTAntNY2
 ijHaSimSwwjS7zE3IwbBL09TsdWVUY6hH3MEap33Yw92ENpJqqGmHomACb8zcRWpfy+LTDkGQ8d
 G5azCuv/TS/n7qfwLIofxHGMiXCQo+2LheQ==
X-Gm-Gg: ASbGncsbdpEtWAhnFbAxFIMzlXGew5v9hupiX3i3azX4vygL1gWfR7MTs7Y+6ELMS5s
 wL2FcpU4A1LFrF+cC2T9PnzNnbPJPnB5G7xzC0j/Iz//mBNaQWNEgBxYD2RVGIvgEE6pQE0hJuo
 mhwCNHMo2EfOuzJwQC3loSdLpLfIsOVTaD2806nYFyg7nsj2yqix11C/YV6FvE4UGQOklEdjxbb
 HWo82LjOtJtY9eLFTCc/Jl0iPyFS1+8dDYlIumZBw==
X-Google-Smtp-Source: AGHT+IGaJa4p/j8gXgwnrU5ZUCJPR7Gvbed+r8YdKBW2vGQmU3Awzxi5R67LdOTx6HXysHuLSPpQPDhIzX2iqk1nsEQ=
X-Received: by 2002:a17:902:d2c6:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-29027215f8bmr47895765ad.2.1760013993220; Thu, 09 Oct 2025
 05:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251009024822.3973163-1-Victor.Zhao@amd.com>
In-Reply-To: <20251009024822.3973163-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 08:46:21 -0400
X-Gm-Features: AS18NWDsdiP6ktHaSieDE_1_9ZTCqe4s_632vRDzcLr_WQ_VNTK5wt39WR4s_Lo
Message-ID: <CADnq5_PEnJON8-UttUDgy8TYMptj4QRRch-mub5AnnJr7Y4dkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add kiq hdp flush callbacks
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, HaiJun.Chang@amd.com
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

On Wed, Oct 8, 2025 at 10:48=E2=80=AFPM Victor Zhao <Victor.Zhao@amd.com> w=
rote:
>
> Add kiq hdp flush callbacks for gfx ips to support gpu hdp flush when no
> ring presents
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

This patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
>  6 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 8841d7213de4..751732f3e883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v10_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v10_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v10_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v10_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 66c47c466532..10d2219866f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdg=
pu_device *adev)
>                         if (version_minor =3D=3D 3)
>                                 gfx_v11_0_load_rlcp_rlcv_microcode(adev);
>                 }
> -
> +
>                 return 0;
>         }
>
> @@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(stru=
ct amdgpu_device *adev)
>         }
>
>         memcpy(fw, fw_data, fw_size);
> -
> +
>         amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
>         amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
>
> @@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v11_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v11_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v11_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v11_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 710ec9c34e43..e2bb8668150d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_wa=
it,
> +       .emit_hdp_flush =3D gfx_v12_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 0856ff65288c..d3d0a4b0380c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_kiq =3D {
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_rreg =3D gfx_v8_0_ring_emit_rreg,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> +       .emit_hdp_flush =3D gfx_v8_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index dd19a97436db..f1a2efc2a8d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> +       .emit_hdp_flush =3D gfx_v9_0_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index fb5585ab52be..e0b50c690f8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4792,6 +4792,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ri=
ng_funcs_kiq =3D {
>         .emit_wreg =3D gfx_v9_4_3_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_4_3_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_4_3_ring_emit_reg_write_reg_w=
ait,
> +       .emit_hdp_flush =3D gfx_v9_4_3_ring_emit_hdp_flush,
>  };
>
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
