Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09B0E732D1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51310E652;
	Thu, 28 Sep 2023 13:23:58 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3384C10E652
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:23:56 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dd1714b9b6so4329347fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695907435; x=1696512235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQ4F0jP31vcTMAgdhE3K2B86QDBCVJXgxF1LM34XF+k=;
 b=LtDyea/BvKpKPa1FepyyiHJHcVwPKO875YUE8a+Th3qn1F+cFmVyn1XFWnasXcCdqH
 aiMYUqbwgUjAe+W7HGnfyMI3p2/82EjDLtX4oPXEmk3q6sZJcRMgN66F1E/kBx/DrKdw
 A6DkGkQZdfWrc/ZVVt44yjy1TBweaukMzmTGfwZmLBJocHCXrjjszdD5i239/6Gv8VJg
 2vVyc3xOA8ch5Vp8rwkPUnplpXFmazo+OrgKBfhZ16KqJLkmFTHdKv4YAMlQ3XKU/0XA
 W3XiqstytGND8AuT2jIxDoCREPeZLbLLpiIolbKvzJIgh/vaSvsdHR6IPqjMxkMIXu+/
 ggMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695907435; x=1696512235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQ4F0jP31vcTMAgdhE3K2B86QDBCVJXgxF1LM34XF+k=;
 b=KvGDSp5yvP7lbM2q3MsNisYraGjl3lgwz74ruKkMdfPAJO+fvHm40n7b9gL/adbeIG
 N/IBw+oQB58NRjfBHPe4VIbtcgHcdxqzTSB1ClrvzhwLvnQxynEX3cLLQSqJSeExANbm
 4Q2QsmiUZzZ6Pb7kv1xy2JZDsrIAed4FY008j8Ox8pewwX/m0fQDAogiTPgC2weucADJ
 hmEjvruoOl2Eky3NhgGiCk+rSHxSOgceXAfOUv6DeEBnpvEKW02UxJu1rzce5OeSLzUv
 NDTjMQyyxYXwhlxK4fig5uuIrgsKDS3+r0ZWxEIE9D8SVrmYDKpn4dhqzy7cm7Xo8Xok
 Vufw==
X-Gm-Message-State: AOJu0Ywajxbm/51t0RygjHweNBMCIDxGpPv5qJiFQe/f5OFbUDawipGl
 JY/eqt19aQYzu1FFsck/rV2LlWbATjee986fl5G8W1TH
X-Google-Smtp-Source: AGHT+IFrRiDS4OIBkP8qa1Ooyfckok8xwpUM14K9F56UJGDj4kdqX7iUf+LVCa7gHb9qyKTTLafGUioge5LpiPz/Qbc=
X-Received: by 2002:a05:6870:958b:b0:1bf:df47:7b5e with SMTP id
 k11-20020a056870958b00b001bfdf477b5emr1269698oao.16.1695907435251; Thu, 28
 Sep 2023 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230927181251.2364633-1-alexander.deucher@amd.com>
In-Reply-To: <20230927181251.2364633-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Sep 2023 09:23:44 -0400
Message-ID: <CADnq5_MMWMoLrKa2GWDcx24-gG=6T6kuftEznvujwjUWxNa9Aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: add a way to force a particular
 placement for GART
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

Ping on this series?  Fixes an issue for SR-IOV in stress tests.

Alex

On Wed, Sep 27, 2023 at 2:31=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We normally place GART based on the location of VRAM and the
> available address space around that, but provide an option
> to force a particular location for hardware that needs it.
>
> v2: Switch to passing the placement via parameter
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 22 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 +-
>  8 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 2bfeaacd050c..60c81c3d29d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -269,7 +269,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *=
adev, struct amdgpu_gmc *mc
>   * If GART size is bigger than space left then we ajust GART size.
>   * Thus function will never fails.
>   */
> -void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_=
gmc *mc)
> +void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_=
gmc *mc,
> +                             enum amdgpu_gart_placement gart_placement)
>  {
>         const uint64_t four_gb =3D 0x100000000ULL;
>         u64 size_af, size_bf;
> @@ -287,11 +288,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc)
>                 mc->gart_size =3D max(size_bf, size_af);
>         }
>
> -       if ((size_bf >=3D mc->gart_size && size_bf < size_af) ||
> -           (size_af < mc->gart_size))
> -               mc->gart_start =3D 0;
> -       else
> +       switch (gart_placement) {
> +       case AMDGPU_GART_PLACEMENT_HIGH:
>                 mc->gart_start =3D max_mc_address - mc->gart_size + 1;
> +               break;
> +       case AMDGPU_GART_PLACEMENT_LOW:
> +               mc->gart_start =3D 0;
> +               break;
> +       case AMDGPU_GART_PLACEMENT_BEST_FIT:
> +       default:
> +               if ((size_bf >=3D mc->gart_size && size_bf < size_af) ||
> +                   (size_af < mc->gart_size))
> +                       mc->gart_start =3D 0;
> +               else
> +                       mc->gart_start =3D max_mc_address - mc->gart_size=
 + 1;
> +               break;
> +       }
>
>         mc->gart_start &=3D ~(four_gb - 1);
>         mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index f593259a66c3..e699d1ca8deb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -199,6 +199,12 @@ struct amdgpu_mem_partition_info {
>
>  #define INVALID_PFN    -1
>
> +enum amdgpu_gart_placement {
> +       AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
> +       AMDGPU_GART_PLACEMENT_HIGH,
> +       AMDGPU_GART_PLACEMENT_LOW,
> +};
> +
>  struct amdgpu_gmc {
>         /* FB's physical address in MMIO space (for CPU to
>          * map FB). This is different compared to the agp/
> @@ -391,7 +397,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *=
adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_=
gmc *mc,
>                               u64 base);
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
> -                             struct amdgpu_gmc *mc);
> +                             struct amdgpu_gmc *mc,
> +                             enum amdgpu_gart_placement gart_placement);
>  void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>                              struct amdgpu_gmc *mc);
>  void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 70370b412d24..8e6e36279389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -670,7 +670,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu=
_device *adev,
>         base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_s=
egment_size;
>
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
> -       amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>         if (!amdgpu_sriov_vf(adev))
>                 amdgpu_gmc_agp_location(adev, mc);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index d0a9ee2f12d3..d611d2efce3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -634,7 +634,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu=
_device *adev,
>         base =3D adev->mmhub.funcs->get_fb_location(adev);
>
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
> -       amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>         if (!amdgpu_sriov_vf(adev) ||
>             (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
>                 amdgpu_gmc_agp_location(adev, mc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index 3f31f268e0eb..7f66954fd302 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -212,7 +212,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_=
device *adev,
>         base <<=3D 24;
>
>         amdgpu_gmc_vram_location(adev, mc, base);
> -       amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
>
>  static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index a72dc21cf6fc..3869cefab7bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -240,7 +240,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_=
device *adev,
>         base <<=3D 24;
>
>         amdgpu_gmc_vram_location(adev, mc, base);
> -       amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 8ce77d074d17..4126172feb7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -414,7 +414,7 @@ static void gmc_v8_0_vram_gtt_location(struct amdgpu_=
device *adev,
>         base <<=3D 24;
>
>         amdgpu_gmc_vram_location(adev, mc, base);
> -       amdgpu_gmc_gart_location(adev, mc);
> +       amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT=
);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 6b15677c0314..37e96d9d30a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1611,7 +1611,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgp=
u_device *adev,
>                 amdgpu_gmc_sysvm_location(adev, mc);
>         } else {
>                 amdgpu_gmc_vram_location(adev, mc, base);
> -               amdgpu_gmc_gart_location(adev, mc);
> +               amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_=
BEST_FIT);
>                 if (!amdgpu_sriov_vf(adev))
>                         amdgpu_gmc_agp_location(adev, mc);
>         }
> --
> 2.41.0
>
