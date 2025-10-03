Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374CBCAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4F310E968;
	Fri,  3 Oct 2025 20:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K+boKzgW";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522FA10E968
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:15:33 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b5509894ee9so149559a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Oct 2025 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759522533; x=1760127333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdYiIPBArkbyP3g7EzyufecmIgHfGowPP36KxVUtx9I=;
 b=K+boKzgW3OeTTqBTcSpYjk1SDlAOg5XTcJO60gNOCoU8cPJYUNQyu6lfJ/ETVOilR8
 C5EPjuru2Y/wFyG+Gp/mi3av20/H/snB0vRlI04Dzld9+ByeXZMDNCUom2WHUgty9RnA
 xN/up/Ea40r+4LcnMVYYg2y7go4WakXTC0Smq9un11hYhiAY9WJ0r4Zr7mkxaO8GvdqC
 +yrMR1qknxj0/ekjUvVjScoDaDpw+zD5Ekxi80jMnKO2IyykGCqNy38my82Ma4lx/n2I
 jSl5te2zGJNZNNX/wluCJfNlM1j75LcCLgF2rc9y7MzUz2KO5mIU8gQmUFPJJtm8CFPL
 JvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522533; x=1760127333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdYiIPBArkbyP3g7EzyufecmIgHfGowPP36KxVUtx9I=;
 b=o1md76NfBIYddX6mK2eRKb5IRQtxYz1WbmNJt32aG4nf890Diu+s60OKpmXgz94OWp
 N6jwZXc4rqCREdTN2t1SQ1t+ArYaNcVfbFoNgNDoNCN+PShg0/RIofVxwiodaJbH184S
 E+2j8sgJnAPPtFKosQx9ICEvZBiqga2AiyUkRStNLkaQVHt3Td+LArv4wNlkP2kW0gEg
 +R76qAGLHH9VMIWAVk/45IqeHTqvXPULFQp4yr1+CPQR2aSWmZqifEGVWaNVLDCVZLBW
 5HW6z0PIyiW+jpMxkiDLttDjAW9cc1/0+J3Y3h7q/j4rVG3s241z9ShuvRwa9L9IGsuJ
 dZCA==
X-Gm-Message-State: AOJu0YzzYhIA6UyKtKAD3poJ1EuXgy0tVppSFmT0RjmGnRqddiPypW7C
 OjvJQbMm+TBB8X8RintpWAZo31pMM2mMrJUM07StScPYdK2CrOLaCf+DuuB/lRsbABXYMGAuJJI
 Nd6rMm3uZ+6BTyVjvjGAamF0pD8edgQE=
X-Gm-Gg: ASbGncvTbIg5gcj8pxF1FKZ252GUfS9265/aJDOPWnJBrs30+mDYm9FLQ45cMU3wyWq
 B6sPmJdIjUF3hluWlEnRK9YIY5OYiyIWJnsOX0FU0gQ52ycodHNP4zfaU0SQol9BBdKfmHXrmvM
 uDgLTB+vs82drJARShZKCh6cq6Ai3nmrguga5rBDxP8NMP/pm0r0MB7Pi9j0obhA3J+9t8+lY4f
 ovt/sveJ2gvivoW7Bx57jF+FGuZ0Y8=
X-Google-Smtp-Source: AGHT+IG6nXKg6KaYNUXQsaQB4Vd0ieCmwVtNnshNlcVBVbdvw0pd0ShtGpcX/SxTFo2+HMenGQfUKhoW68iqjLvrWVo=
X-Received: by 2002:a17:902:f684:b0:253:a668:b638 with SMTP id
 d9443c01a7336-28e9a58b4dcmr27483665ad.2.1759522532770; Fri, 03 Oct 2025
 13:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250926230535.5632-1-alexander.deucher@amd.com>
In-Reply-To: <20250926230535.5632-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Oct 2025 16:15:20 -0400
X-Gm-Features: AS18NWCyFgCFpPhjI_C-PvsOA5HrSVUQdG-0970oo9ne4TudgTsdZe-ZgwuhR78
Message-ID: <CADnq5_NnPYTABohK=+V0Kfcpkan+Lq-rFB3tvSEcXwkBRHU6Gw@mail.gmail.com>
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
