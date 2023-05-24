Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2777C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 12:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486F710E5D5;
	Wed, 24 May 2023 12:29:45 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5360510E5D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 12:29:43 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-18b1c643219so87562fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684931382; x=1687523382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAhlt+4UW2iuyXc8zpPrzAT0KdR1itBidSLb08DB5G0=;
 b=BcLUeD0y5PFwG6xE2clQtl15yC6TJQ8dpXTgcnqdqYjyG/qfQXmYFvGfqWzRNtXigG
 X/UqU65aQm24B4qm4p+kJRh/YHpEX5r/RE6G2AdNRZb6oEEg/KYJv1rUtI8naLflL1Ak
 RPLvHrM5qjEWfS7QTU8+SVRSrabqW1YS9fGaDbTt/CVrpSYnZSNLToTbaUtS1Ae3D+SR
 NEWJRzXbUWV5m0wbcUMHKv4rXyj6sbGjr5WXerW/RuHXLza3zPbvckEcNhKFQXhJR+c6
 4S1Le4dZsqRHKNQw6FWsPZ6lIVYKVoxPc9Eh0FQ2qAKbIJgYKbydXbQzqzuec7goTls2
 k6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684931382; x=1687523382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAhlt+4UW2iuyXc8zpPrzAT0KdR1itBidSLb08DB5G0=;
 b=GyN3DHlSDqZ1aBhYneTBclg/rGNLyq/4PK0Io1lSAMHzD7X6Q9O3lzD2plKslM6AQt
 BBp/95nkSysVAghi+s4+IgxgtkXIHHkKVNgMhs6EgRzZFlmpBgV5dUz2KbRqy/kJ9jZU
 Yeu0CCVQmJEPubOvN6dh9aQlYUeY+WiVKE9PxEMdB0JI3TXrPnj69koRN5LsdlTU/B2A
 MkDM0RhRRMtbQkamj6BFflM0r0iQY70Q+rbjSL5vwAA392q86VBCJ3/jdlV4T5MrvsU1
 6AI8uOdeTpfcrxyI5JXbz26a+sVXgslxVK4dZ3eVcOORoLkV88Kx6vCXNxwrEeS6LhGL
 DWfw==
X-Gm-Message-State: AC+VfDwUXMVIH7M7aKOv/THmD57USxDOhez1Efk7DXSCoFiFmKc2iZHG
 hVlDlrGaOmTfenWaLnMpzRbpsOW2+qTz/yYrra4=
X-Google-Smtp-Source: ACHHUZ7bphmm9EYpi14qwPL7y73KN3+cJxoBLr3DJ0wQ1NX4pmjJHNN+PjFKzorK7vmy38i6s0pflpmGShVvsRY43f0=
X-Received: by 2002:a05:6870:a405:b0:19e:a0df:414a with SMTP id
 m5-20020a056870a40500b0019ea0df414amr2134106oal.25.1684931381909; Wed, 24 May
 2023 05:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230524090001.3276718-1-jiadong.zhu@amd.com>
In-Reply-To: <20230524090001.3276718-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 May 2023 08:29:30 -0400
Message-ID: <CADnq5_NzJ7XuOms1ppQpei-UpRwGFuA8ehSGs9P8TR2+GuNX_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Program gds backup address as zero if no gds
 allocated
To: jiadong.zhu@amd.com
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

On Wed, May 24, 2023 at 5:00=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> It is firmware requirement to set gds_backup_addrlo and gds_backup_addrhi
> of DE meta both zero if no gds partition is allocated for the frame.

Presumably other gfx versions require something similar?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index cbdd9918b3e7..cbcf6126cce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -765,7 +765,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_devi=
ce *adev);
>  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                                 struct amdgpu_cu_info *cu_info);
>  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *ade=
v);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool re=
sume);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool re=
sume, bool usegds);
>  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>  static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>                                           void *ras_error_status);
> @@ -5160,7 +5160,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu=
_ring *ring,
>                         gfx_v9_0_ring_emit_de_meta(ring,
>                                                    (!amdgpu_sriov_vf(ring=
->adev) &&
>                                                    flags & AMDGPU_IB_PREE=
MPTED) ?
> -                                                  true : false);
> +                                                  true : false,
> +                                                  job->gds_size > 0 && j=
ob->gds_base !=3D 0);
>         }
>
>         amdgpu_ring_write(ring, header);
> @@ -5435,7 +5436,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_r=
ing *ring)
>         return r;
>  }
>
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool re=
sume)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool re=
sume, bool usegds)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         struct v9_de_ib_state de_payload =3D {0};
> @@ -5466,8 +5467,10 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdg=
pu_ring *ring, bool resume)
>                                  PAGE_SIZE);
>         }
>
> -       de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
> -       de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);
> +       if (usegds) {
> +               de_payload.gds_backup_addrlo =3D lower_32_bits(gds_addr);
> +               de_payload.gds_backup_addrhi =3D upper_32_bits(gds_addr);
> +       }
>
>         cnt =3D (sizeof(de_payload) >> 2) + 4 - 2;
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
> --
> 2.25.1
>
