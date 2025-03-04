Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09967C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 23:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB0A10E6C8;
	Tue,  4 Mar 2025 23:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XLP7c/lq";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0604810E6C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 23:12:41 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fe8f6a4bfaso1625999a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741129952; x=1741734752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTfG/Tvd79kLLb3WKYLea/dq07bNZipbPsW4Q+kzc48=;
 b=XLP7c/lq/GBWHOXtPAPlCyNHV5xkUPMVrFZDhWxLJcMHFKnrku8RUn/PJjXj2N8dlI
 wyLTyNkgwyYZBkK+FhAZn7qRKKNwdRP17VQezMjX1FhhwBHwMVXbWm+d/C/ih1Giv+mi
 /cHRMdtvUb9FE4aCJq6pZnjRATWKPZlW8wQZYzZUBYnUPI3pRwxgyNmfU+chcbDdu3yr
 X1t55ot+0/sw8V2WsoNd0pc71SLTPqw/gLiwChxslP8Ftm9QmtpAqgKnkPug5nrDYuUb
 IZgkdcliOGtA8NsSuHlRJ5sL8B34sZmeDEQ8gjAU6DZmmC1xHnddCZyI89o1xA+zIfFh
 8ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741129952; x=1741734752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fTfG/Tvd79kLLb3WKYLea/dq07bNZipbPsW4Q+kzc48=;
 b=dTf+WAdtUvmq/PCE0TnueJHY1iktTTDkBAA0/o3cQicvPMgAI+Nx/TeuHOlv7yWTDx
 K1UFBzRDBoOvcFHxMmrfk+PL2QhZFsrMdV3ZHZyhdcAGZXefiZRW120mU8H3aFTbBioh
 lmm1+NiZ7Qi/VYlKgEOShYSLlTOO4MnYY/2WVA3C8Ek0GKOpvlzEkeb/jxTF+ttCAkb0
 SEpVPv9zFfbHb2mqggkpfNBITWQiQRrp9/mvamNpOlof4OhrJ2jGG4OUR4ZEH2YgI5fb
 fPXn0hRB7Z63YM5XEPRgbQJRirCCCKIrmz1JTNv2aZ5HwbFZIUbw6V9SutdZKpYbwxRo
 IEtA==
X-Gm-Message-State: AOJu0Yyy5tC+ThqCoLM+pkwyLo+IbyJkJqkPQOuKx3EWahcs+ZJ9EigA
 NxOkkuVsIS3dwMjbyUL6j1YekZEGYlUzrKi79VJL4WCEDhoFix77iA8zOp/fA5mqAn4+WIt8Sax
 7fP99Luy3O1mndqo3RsZ851IHatqTLw==
X-Gm-Gg: ASbGncsUypstWA34CxhtnyqCCqsbfbxSamb4GIS8s+pQXvWYv1xat5hzQfFltLK0Ldb
 SymqIamYUL6kDse4AHYY+CSTULFRTpcexB1G1EZPXX5AD/3q3Gb4abAHj+Uf4swKn+BwHv9twcL
 IeaJ1NbNgRgohHq0XN+xlSKyN9UA==
X-Google-Smtp-Source: AGHT+IGc29OTIJxBinx2rjqpsZzP9WuKTKoCOsPf39uhAvmFIQlbD5vf8Gvr2QMQ7xyI9P549WzM64DHM8B7Ivh2jKc=
X-Received: by 2002:a17:90b:3b8f:b0:2fe:9730:8e42 with SMTP id
 98e67ed59e1d1-2ff497a62femr683815a91.3.1741129951590; Tue, 04 Mar 2025
 15:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20250304162242.4029795-1-alexander.deucher@amd.com>
In-Reply-To: <20250304162242.4029795-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 18:12:19 -0500
X-Gm-Features: AQ5f1JqAzU5UbPE1Bc2pn_PfEEvysHMZXnxVbppY9xypGLvSCzgzD-GzSWS1wJ8
Message-ID: <CADnq5_OF8fypN9noOkpW+gLUe3-DS5NzW9oM+az_g5OtLBQoFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Mar 4, 2025 at 11:29=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> VCN 2.5 uses the PG callback to enable VCN DPM which is
> a global state.  As such, we need to make sure all instances
> are in the same state.

Actually ref counting won't work because the gate and ungate calls may
not be balanced.  I just sent a v3 which just adds a new work handler
for vcn 2.5.

Alex

>
> v2: switch to a ref count (Lijo)
>
> Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle=
 work handler")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 41 +++++++++++++++++++------
>  2 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index 26c9c2d90f455..3bc4fe4aeb481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -358,6 +358,10 @@ struct amdgpu_vcn {
>
>         bool                    per_inst_fw;
>         unsigned                fw_version;
> +       /* VCN 2.5 global PG handling */
> +       struct mutex            global_pg_lock;
> +       unsigned int            global_pg_count;
> +       enum amd_powergating_state global_pg_state;
>  };
>
>  struct amdgpu_fw_shared_rb_ptrs_struct {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index dff1a88590363..972f0842ea47b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -172,6 +172,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *i=
p_block)
>         uint32_t *ptr;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> +       mutex_init(&adev->vcn.global_pg_lock);
> +
>         for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
>                 volatile struct amdgpu_fw_shared *fw_shared;
>
> @@ -1853,21 +1855,42 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_vc=
n_inst *vinst,
>                                  enum amd_powergating_state state)
>  {
>         struct amdgpu_device *adev =3D vinst->adev;
> -       int ret;
> +       struct amdgpu_vcn_inst *v;
> +       int ret =3D 0, i;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       if (state =3D=3D vinst->cur_state)
> -               return 0;
> +       mutex_lock(&adev->vcn.global_pg_lock);
> +       if (state =3D=3D AMD_PG_STATE_GATE) {
> +               if (adev->vcn.global_pg_count =3D=3D 0)
> +                       goto unlock;
> +               adev->vcn.global_pg_count--;
> +               if (adev->vcn.global_pg_count =3D=3D 0 &&
> +                   adev->vcn.global_pg_state =3D=3D AMD_PG_STATE_UNGATE)=
 {
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +                               v =3D &adev->vcn.inst[i];
> +
> +                               ret =3D vcn_v2_5_stop(v);
> +                       }
> +                       adev->vcn.global_pg_state =3D AMD_PG_STATE_GATE;
> +               }
> +       } else {
> +               if (adev->vcn.global_pg_count =3D=3D 0 &&
> +                   adev->vcn.global_pg_state =3D=3D AMD_PG_STATE_GATE) {
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +                               v =3D &adev->vcn.inst[i];
>
> -       if (state =3D=3D AMD_PG_STATE_GATE)
> -               ret =3D vcn_v2_5_stop(vinst);
> -       else
> -               ret =3D vcn_v2_5_start(vinst);
> +                               ret =3D vcn_v2_5_start(v);
> +                       }
> +                       adev->vcn.global_pg_state =3D AMD_PG_STATE_UNGATE=
;
> +               }
> +               adev->vcn.global_pg_count++;
> +       }
>
> -       if (!ret)
> -               vinst->cur_state =3D state;
> +unlock:
> +       vinst->cur_state =3D state;
> +       mutex_unlock(&adev->vcn.global_pg_lock);
>
>         return ret;
>  }
> --
> 2.48.1
>
