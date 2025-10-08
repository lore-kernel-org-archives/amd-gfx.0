Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184ABCAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FCD10E011;
	Wed,  8 Oct 2025 15:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fgv84OJn";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D037B10E011
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:00:07 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26987b80720so13413835ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759935607; x=1760540407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3sSSteRYiPof+b7ivYas/rGon7uI86X3xiuLq1Scgg=;
 b=Fgv84OJnRdEy1ChAM+SZnR+JDLuFXJarZYKZiLklz6/scZ8DpgH42ZXbMqWdbr5uWx
 Hx7WG9E1hop4JVYXQODww3WUdWS0x78mvv8Bn5gCHTWdsqhg5eVDbaGZcutNVUROULPE
 u8CwqFntMM8KEj9Nn6M8CRaFolaLeCzVGQ0cl2R/jygDGHxMoh197gl+2fffuMn3Pi3B
 +/woPzW7EZxS5XoTR7AWVrZsgACp4dOSv0Cx1TLAUaLkXY08L1kATy9/bKKZu0y1XRzL
 3m3GEyAtuBvV5u1YLFysjNE1Vxy9cYxdDeYLNRE76edI1EfA6E3aqZbfvSc117Kp0tFo
 wllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935607; x=1760540407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3sSSteRYiPof+b7ivYas/rGon7uI86X3xiuLq1Scgg=;
 b=P4wLWTn5YJBz8KizvGarYkdO5jk3ngSNJAVMYsQnL7KH07IB5ShNxnnB8/bxDl1Ih2
 CA+XaxG4615gXgjfL4V6om3Z04USkqx+EqgaA4KpbxrWBX88ogZWYQwvAZPuU1V/zwcU
 o0ybqr8lthCkAkGaDHrzkLx+wwOouUx6Y+UBO1c4XRx1QyVZUPuuw4xnDf1WLf1LShpU
 0agPYd4CqLj79iXBWow+5lIGkFiCIsVJtbT6eJYqNPkO9JMG0aelahhVaOKSKIjU1lAZ
 l3t0vcjxF9cX8ykcNJibTGqSq/P2qFIy1Zk8Exj8RLg3cTb+xFxG5yeGhZMHAVnFFj0K
 u8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrk3EotkFp5C/IwoZmEP+NuSZGwxUBJvEzSrRR7Rc7UG5oYTy+n9bf0fZSckACob2AcBhXpXD8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykE/VjD0vJCvpy8eIO8CUIupM5W2p8BYbnsb1g/aPPCHhHQzd+
 /M/wVb8yFJOMvaQSkjt6VHMZHg9gJwhN4cJLUp1kNZf0NnKx7f0YO+lf8vE07bMMYvoRjQsERk5
 0ptJ9gw/d3RWgqVmlxfTVcOJ1jFzRONM=
X-Gm-Gg: ASbGncuuR8JVGJAULeMUhz6f/EdDUfDcZRVRcFCtPkUM3Ch2/TCJSmaRdmmbCjOPP6b
 qkPyOBWq5TIYg9SHE1I8Fgd7fxr2aO0PYLcy/etf2Q3jX1K2hF+GKMc5wvsgU0s1fhM2oJLK8VS
 f90XeeH9apjmF0yao8iYQeH88EYHPDP30eJodcGV5U6D4eUdjg5a2YveTskqlLAB4SO49Tpj6kH
 N5B6kyfIawyev3/nLQtNSr9cymrwXw=
X-Google-Smtp-Source: AGHT+IHs8CdAmLsBpkPoDiDN/FLdXceXOOlM8jrO7dpIXc+8phEsufd7QuqI/S8C9sIBxp67EO5csx3f50/YTg4pY9w=
X-Received: by 2002:a17:903:110c:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-290272667a9mr24888855ad.4.1759935607288; Wed, 08 Oct 2025
 08:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250926230535.5632-1-alexander.deucher@amd.com>
 <DS0PR12MB7804991C02AB82307ECEBF9997E1A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804991C02AB82307ECEBF9997E1A@DS0PR12MB7804.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 10:59:55 -0400
X-Gm-Features: AS18NWDjZiJR9GS0yLqfXSnWQIHnQyKY3TM-qJS12b8O8YniRLF2bddZg-1bN4w
Message-ID: <CADnq5_MA8zQH3=LMEowxvFj7JJDO5iVXZdRHm81db6q+mTR90A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "StDenis,
 Tom" <Tom.StDenis@amd.com>
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

On Wed, Oct 8, 2025 at 10:50=E2=80=AFAM Lazar, Lijo <Lijo.Lazar@amd.com> wr=
ote:
>
> [Public]
>
> Will it be better to handle at a single place?
>
> Like :
>         If (!xcc_mask)
>                 xcc_mask =3D 1;
>         if (!sdma_mask)
>                 sdma_mask =3D MASK(sdma.num_instances)

We could, but this only applies to this handful of old cards without
native IP discovery.  If we do it in one place, we may break something
on boards with native IP discovery support.

Alex

> Thanks,
> Lijo
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Saturday, September 27, 2025 4:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; StDenis, Tom <Tom.StD=
enis@amd.com>
> Subject: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery =
firmware
>
> Chips which use the IP discovery firmware loaded by the driver reported i=
ncorrect harvesting information in the ip discovery table in sysfs because =
the driver only uses the ip discovery firmware for populating sysfs and not=
 for direct parsing for the driver itself as such, the fields that are used=
 to print the harvesting info in sysfs report incorrect data for some IPs. =
 Populate the relevant fields for this case as well.
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
>                 if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK) @@ -=
2565,7 +2567,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *=
adev)
>                 amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
> +               adev->sdma.sdma_mask =3D 3;
>                 adev->gmc.num_umc =3D 4;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, 0)=
; @@ -2592,7 +2596,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
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
; @@ -2619,8 +2625,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
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
, 2, 0); @@ -2665,7 +2673,9 @@ int amdgpu_discovery_set_ip_blocks(struct am=
dgpu_device *adev)
>                 amdgpu_discovery_init(adev);
>                 vega20_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
> +               adev->sdma.sdma_mask =3D 3;
>                 adev->gmc.num_umc =3D 8;
> +               adev->gfx.xcc_mask =3D 1;
>                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
>                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
>                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, 0)=
; @@ -2693,8 +2703,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
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
; @@ -2726,8 +2738,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
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
; @@ -2762,6 +2776,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
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
