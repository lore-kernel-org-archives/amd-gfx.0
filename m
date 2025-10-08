Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4371ACCA472
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 13:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916810E111;
	Wed,  8 Oct 2025 13:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F/Vrg/YS";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BB910E111
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 13:16:14 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b5509894ee9so353025a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759929374; x=1760534174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdYiIPBArkbyP3g7EzyufecmIgHfGowPP36KxVUtx9I=;
 b=F/Vrg/YSaP0f3XpxTF8GsTJIn338tNY7o2yQOcHZC/Sxu2vuy+v/687Y2SKSVmObcH
 YnblS2C5TIYJiBsIeGAjGrJXAvqujDPE413O5bdz3b6oMuyr0hiJcYd0YW75by+3AYTB
 3Sp30+bJl8Lye6NHm/RaoXQp+duteMcreq2wfjx+Llp8T9ZzbQFCqJE0tZrvQqyI66iJ
 J4auOFwjGR1cLcPhq+7Tf8AVgW3y7+GIdvB8jXj9UTsAj/MMPRilFqxh+Fq18m9u7h5R
 pybxcwR52lkH6n0MC0QMyzx2NV/Qm1h4qbrhOf+53/Mxp4IVvV7qF9mFjRtVgS20woe9
 Xxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759929374; x=1760534174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdYiIPBArkbyP3g7EzyufecmIgHfGowPP36KxVUtx9I=;
 b=sVffh3eXTbnXtQKetjGhdN0IlOOtucbe75dOwikQlD/iPNOkYb853DDmcs3pMjf5IE
 3Cqg3cAtswYLXHJHwfaYYN/ij2bKGlonUd4xQ2VMRS53Z+Py93dyM5wZJ+BAN4mnbMfN
 2HBaf6Ieo2VKU/2Zei23u7u3qKAPmi5q2ssaAHqENdiHBvShwFlOZ2T6d8yheZnNIy7q
 be662OjnqKN1QLTVvndchPKzckMAH7iTrztcWvdOAsAMzr3hLlkQ1RyQLAh8Qa7rgv5r
 1R32wSZr1W6X58lDEERXi8rmBVQI0yKuZYESiTtNT00zfcSxRnwfY+vpKG+SOBGezoaI
 H6fA==
X-Gm-Message-State: AOJu0YyztRW9o5BHzICNGONdePcwXjdvkf5SsaRdWTmIa7EyZZNAyAZZ
 W6LSAsmlZz8miVYTc8vR4xRCiUNt4HUbapBWecN+y7JigocYCfIUBhOw7NilXofXxpqg1fWZPSx
 6+RkDtCmYQbZbw3WdCDW4bhUOI6xVQVw=
X-Gm-Gg: ASbGncsQA9tM13UBPteb2qTs88CJyN0cU54xH6GdHLAT7zlPOjlkNmEb+ohmbFgNiKD
 WG8T2X+s4iqd9jwYCsVRjahlTsgO+T5umLafoTtBJtrqAWTIAnIw/K2qL9bWbYgwTaEF/Dbtrl/
 JcvNl0sKdmBNpAdBpX+UH3OTgawzCxbnHZX1i5p9oobcknaFPRNuAlY1ppQ3WrBu7du3U3wh3Zo
 jSYPfS73ar0/lRwl88HAGbaG+YPM2g=
X-Google-Smtp-Source: AGHT+IGF5zUw8YO/IErqvwPtTlbIyVdUl+luWn9JPEnkq1ztEmO3ygwSJrey1g4/9720qwXFapGoC9mmgzJEe/TT9XM=
X-Received: by 2002:a17:902:fb8b:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2902743ae8fmr16480005ad.6.1759929373963; Wed, 08 Oct 2025
 06:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250926230535.5632-1-alexander.deucher@amd.com>
In-Reply-To: <20250926230535.5632-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 09:16:02 -0400
X-Gm-Features: AS18NWAd4xMceYs3qL3LeATrquy_i5NXyQ6viSwq4YGkejuZwBqAtk5rN_YLACw
Message-ID: <CADnq5_Pp5JRtW_4TiJXULB_kptF_hCdeaBbLQq_N1N2Me3Gc1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom St Denis <tom.stdenis@amd.com>
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

Ping?

On Fri, Sep 26, 2025 at 7:44=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Chips which use the IP discovery firmware loaded by the driver
> reported incorrect harvesting information in the ip discovery
> table in sysfs because the driver only uses the ip discovery
> firmware for populating sysfs and not for direct parsing for the
> driver itself as such, the fields that are used to print the
> harvesting info in sysfs report incorrect data for some IPs.  Populate
> the relevant fields for this case as well.
>
> Fixes: 514678da56da ("drm/amdgpu/discovery: fix fw based ip discovery")
> Cc: Tom St Denis <tom.stdenis@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 73401f0aeb346..dd7b2b796427c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1033,7 +1033,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(st=
ruct amdgpu_device *adev,
>         /* Until a uniform way is figured, get mask based on hwid */
>         switch (hw_id) {
>         case VCN_HWID:
> -               harvest =3D ((1 << inst) & adev->vcn.inst_mask) =3D=3D 0;
> +               /* VCN vs UVD+VCE */
> +               if (!amdgpu_ip_version(adev, VCE_HWIP, 0))
> +                       harvest =3D ((1 << inst) & adev->vcn.inst_mask) =
=3D=3D 0;
>                 break;
>         case DMU_HWID:
>                 if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
> @@ -2565,7 +2567,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
> +               adev->sdma.sdma_mask =3D 3;
>                 adev->gmc.num_umc =3D 4;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, 0)=
;
> @@ -2592,7 +2596,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
> +               adev->sdma.sdma_mask =3D 3;
>                 adev->gmc.num_umc =3D 4;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 3, 0);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 3, 0);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, 1)=
;
> @@ -2619,8 +2625,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 1;
> +               adev->sdma.sdma_mask =3D 1;
>                 adev->vcn.num_vcn_inst =3D 1;
>                 adev->gmc.num_umc =3D 2;
> +               adev->gfx.xcc_mask =3D 1;
>                 if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
>                         adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9=
, 2, 0);
>                         adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9=
, 2, 0);
> @@ -2665,7 +2673,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 amdgpu_discovery_init(adev);
>                 vega20_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
> +               adev->sdma.sdma_mask =3D 3;
>                 adev->gmc.num_umc =3D 8;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, 0)=
;
> @@ -2693,8 +2703,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 amdgpu_discovery_init(adev);
>                 arct_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 8;
> +               adev->sdma.sdma_mask =3D 0xff;
>                 adev->vcn.num_vcn_inst =3D 2;
>                 adev->gmc.num_umc =3D 8;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 1);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 1);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, 1)=
;
> @@ -2726,8 +2738,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 amdgpu_discovery_init(adev);
>                 aldebaran_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 5;
> +               adev->sdma.sdma_mask =3D 0x1f;
>                 adev->vcn.num_vcn_inst =3D 2;
>                 adev->gmc.num_umc =3D 4;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 2);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 2);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 4, 0)=
;
> @@ -2762,6 +2776,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 } else {
>                         cyan_skillfish_reg_base_init(adev);
>                         adev->sdma.num_instances =3D 2;
> +                       adev->sdma.sdma_mask =3D 3;
> +                       adev->gfx.xcc_mask =3D 1;
>                         adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(2=
, 0, 3);
>                         adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(2=
, 0, 3);
>                         adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(=
5, 0, 1);
> --
> 2.51.0
>
