Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4979FCAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 20:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC43B10E5CB;
	Mon,  8 Sep 2025 20:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jogyczxu";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764E510E5CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 20:25:52 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b4f18ddd8c3so327335a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 13:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757363152; x=1757967952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaHxc3uzl6HCB5ADb+bW2axVVlgopPW3O6ARyIKjp5w=;
 b=JogyczxuooqRDJUIsYpuh4Rux2pbX0a3cI8oBdymncThkz2QvBd7xwKoAyLYvovVY2
 nKqpv/pUdeKZjtlvQLLAE4/ockYkHyIfreGBcspmaOcfvfmoCp8upV/C22xukHnzuxcZ
 ExbyvCiD4IAGvjvsArnlOlY8ikkYGF2BQRAqxQ0lzZe5N7yx2+YajnV0RjAyUhfu059z
 viRiLh6tipmxb1SU7+M/pE8lEzdfW4T3gFLMdzozG2hJSPQwYhxeHuFhAyxYVGyjYJN0
 eQaCYkMLQHYPyvoo7HCYJqyHcXpLBVC1EzBP29qoeXlJa2mRP9HPEd+OgFz6b3RU/Uvd
 deTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757363152; x=1757967952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaHxc3uzl6HCB5ADb+bW2axVVlgopPW3O6ARyIKjp5w=;
 b=WJ+wKPleV42kE2hIEjPd+W4lvLf3FTJLNmOgLs4gxdaVN4P1cjxdUD5Grk3mDI910k
 Sga9T2I4tM18n3BCTSuEad4wUHI8W52NT0zo6yF73pQ1Hp318pkPctT9zHVzi2DtaQQM
 YsmOt00Z4Qf9o/Dqrwe9YFVEm35ZAnjRuHYLkl2GrRfZstASICOOvIv3FxtMmXWlfxsA
 WU5gvePnDBXj/yc0f8CZvX9pL6NxBxs4eXRUmBECZnLtmLK5ek0t6aou8W17KKL6p26b
 Tc6IjbSCg4NwUSXnkP+nqwje93+dhv6ujipdNLkJjL2Cc8uYbRAijigS5qFIAk7Wszqr
 jcxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Pj/B8b8cyxxIJt4lSNbZNKAHYPtbp2VTODE5+DyLcq6niDIV6nNEKDVs2Pran+jzHHJjsQwU@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8pv7QcEQpSwipxqye9T8T2IsLJAWF71T/z0dLdLt837v5aefv
 dXhFY4fee8S6h6RwaTzK54UttHKpln3j68zCfer8rKMVnDbsR/0NKADMZkJhAJWE1WMlqf52jaD
 VtQn8fZt4wJLEVbXCTwnoFL8AuqovhlA=
X-Gm-Gg: ASbGncvlKRsbB7QKqgZQAFLumvN9E77WdrPjGo/55khzqcW26BgtpfcrUagSIN4qVcL
 UhprNRkil4Fstgp01JuDLcAKcvj9EtmIkm9yndwbli9re/jAoZ/EQJnd1V4VRwBhH7S6o+ZKVxP
 tpGDai6VbuRnaOSR9ndFeXDJPAJ6Aiq70sMjc1xn+vTAKDtVZggEPfoGd+r4TN/4jFE4mZ1utzo
 Z6Tyxw=
X-Google-Smtp-Source: AGHT+IG7sZCHDzzxhXYWz4uhObmjMnFEcIDqASx4/DswnaJpzGUk+NMwZTXgPkIlqiH7Hybr9q9h9Q6aVAHemywAPt0=
X-Received: by 2002:a17:902:d501:b0:240:280a:5443 with SMTP id
 d9443c01a7336-2516fbd9a43mr75834705ad.3.1757363151818; Mon, 08 Sep 2025
 13:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250825004800.3851474-1-siqueira@igalia.com>
 <20250825004800.3851474-3-siqueira@igalia.com>
In-Reply-To: <20250825004800.3851474-3-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 16:25:39 -0400
X-Gm-Features: Ac12FXzdCAUsHPKPVf9N1-l2swBGLTTNHiW1VQy7teUk7mP4rlmBL9EXqjrp9uE
Message-ID: <CADnq5_Ow1XdVs83F_H+OjskZV4LMu1YDb9R-=u4mccr=8PZatg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu/vcn: Change amdgpu_vcn_sw_fini return
 to void
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

Applied the series.

Thanks!

Alex

On Sun, Aug 24, 2025 at 8:48=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> The function amdgpu_vcn_sw_fini() returns an integer, but this number is
> always 0. This commit changes the amdgpu_vcn_sw_fini() return to void,
> and eliminates all checks to this return across different VCNs.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 ++-----
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 9 +++------
>  11 files changed, 19 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c18..4ceb67febaae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -257,12 +257,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, =
int i)
>         return 0;
>  }
>
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
> +void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>  {
>         int j;
>
>         if (adev->vcn.harvest_config & (1 << i))
> -               return 0;
> +               return;
>
>         amdgpu_bo_free_kernel(
>                 &adev->vcn.inst[i].dpg_sram_bo,
> @@ -292,8 +292,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, in=
t i)
>
>         mutex_destroy(&adev->vcn.inst[i].vcn_pg_lock);
>         mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> -
> -       return 0;
>  }
>
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_rin=
g_type type, uint32_t vcn_instance)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index b3fb1d0e43fc..e2911eb915ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -516,7 +516,7 @@ enum vcn_ring_type {
>
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
> -int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
> +void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index c74947705d77..66dc3b5d01eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -230,11 +230,11 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block =
*ip_block)
>
>         jpeg_v1_0_sw_fini(ip_block);
>
> -       r =3D amdgpu_vcn_sw_fini(adev, 0);
> +       amdgpu_vcn_sw_fini(adev, 0);
>
>         kfree(adev->vcn.ip_dump);
>
> -       return r;
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index b115137ab2d6..c4e2659f8933 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -267,9 +267,9 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>
>         amdgpu_vcn_sysfs_reset_mask_fini(adev);
>
> -       r =3D amdgpu_vcn_sw_fini(adev, 0);
> +       amdgpu_vcn_sw_fini(adev, 0);
>
> -       return r;
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 3a7c137a83ef..748351e2da7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -465,9 +465,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *i=
p_block)
>                 r =3D amdgpu_vcn_suspend(adev, i);
>                 if (r)
>                         return r;
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> +               amdgpu_vcn_sw_fini(adev, i);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 95173156f956..a615d6a0a698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -349,9 +349,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *i=
p_block)
>                 if (r)
>                         return r;
>
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> +               amdgpu_vcn_sw_fini(adev, i);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 1785786a72f8..7e425cda388f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -302,11 +302,8 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *=
ip_block)
>
>         amdgpu_vcn_sysfs_reset_mask_fini(adev);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> -       }
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               amdgpu_vcn_sw_fini(adev, i);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index bae1ad4484ed..5fbd755fc24c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -283,11 +283,8 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         amdgpu_vcn_sysfs_reset_mask_fini(adev);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> -       }
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               amdgpu_vcn_sw_fini(adev, i);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 75c884a8f556..514c4e7e806e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -270,9 +270,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block =
*ip_block)
>                 if (r)
>                         return r;
>
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> +               amdgpu_vcn_sw_fini(adev, i);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 455f829b8bb9..92da911a5e4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -232,11 +232,8 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         amdgpu_vcn_sysfs_reset_mask_fini(adev);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> -       }
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               amdgpu_vcn_sw_fini(adev, i);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_1.c
> index 7cb21e2b4eb0..b8097718882c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -245,14 +245,11 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>                         return r;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               r =3D amdgpu_vcn_sw_fini(adev, i);
> -               if (r)
> -                       return r;
> -       }
> -
>         amdgpu_vcn_sysfs_reset_mask_fini(adev);
>
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> +               amdgpu_vcn_sw_fini(adev, i);
> +
>         return 0;
>  }
>
> --
> 2.47.2
>
