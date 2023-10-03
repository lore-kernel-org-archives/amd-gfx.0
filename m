Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE395E7AD78
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 17:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7885710E027;
	Tue,  3 Oct 2023 17:12:16 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E146510E300
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 17:12:13 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1dc863efb61so769102fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Oct 2023 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696353133; x=1696957933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTi90OumNVVzxtWYvJzL/GKUsgRDu6C5AyvVL3IcDhk=;
 b=kPRBZZ6Rwuj5sy4VxbEnt7F/Zw+o1s8UMSV8mUNpJwZq9D+O8kdrYaJNaYh41wo6ky
 q1uY1bxn8Rn+9UYqJBwdvDGH73g3vws+C59ChgEO4UT9yrWEJVAGRuWI7GfkZhj1Rw6Y
 J8im+87ItiFNZkz3bs2olv3O/BNutIklIHYcR81SsXfOOvv1Ou2/xshG1HlelDTVY6Bx
 iaNELV2w2gGPBGSMUE/lhtqaY1ULag89u//rMvUALSfrPXhjk5Z6FzN8Zuaeex9c0FeL
 oQ8DO6ofWyRkNJqJPqlHYmLL9ZjFTZ8BPXZdjJymjXw1n3TbN2qGs3Cmzgx/A4Pdv5HK
 pk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696353133; x=1696957933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTi90OumNVVzxtWYvJzL/GKUsgRDu6C5AyvVL3IcDhk=;
 b=ccjQz9F/Qd1Q8z6/4GRNKdwWbmvXZCPr+Yt+wemGyLqdyUTEFWWtOk+bprqFr0CJM8
 7P9D4h67YbkRnaxwsnscvSIr2ShWw/J4IFS2lqRt2M3LowVq2O1bYPe4VUoB1MU/s/nD
 sqZlVx5xfcHgYltFbtXviPcLmO87+5mP43GSmzlui80Ctd/nCh8UGKM667LKHXys9aNN
 cA912BBs0Az/dEGl6Tt5WJxHDV0rvGjouuKNCzhoe3DULGYvx/PzgaFXraDceTTsCny4
 DEmLKQqPWv57oNbTZO9KmAWkM8PT/VaChYfFhO5LhlFeVDoSM9AQqr6OC9aWCNfx36T1
 xAIQ==
X-Gm-Message-State: AOJu0YzhSbXBrFrxZ6whn5W/UuMHHMsfLB0CJlaG6e2cGo3hCPj8Y0Rq
 6UPPogYC3Y2BS/hOmg2ZbmGHrUr95OGTrT+yHwc=
X-Google-Smtp-Source: AGHT+IG0ej4wEsnZrMHV0Bi9HdYwx46kF6UgaDH6Eyc2U2VA2qDamDa0FV/Z+myAy4Tefvp6tDIWJp5u8xGRkhi8f8g=
X-Received: by 2002:a05:6870:6592:b0:1cc:e169:96bf with SMTP id
 fp18-20020a056870659200b001cce16996bfmr236182oab.39.1696353133020; Tue, 03
 Oct 2023 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
 <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Oct 2023 13:12:01 -0400
Message-ID: <CADnq5_Oxs_6sbOrL-1SPTYdnSf1xoHi7VGNLZCvf-n8VhPFhLA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Oct 3, 2023 at 1:02=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> Ping on this series.
>
> Since there is no alternate header to put device property other than amdg=
pu.h, this can be moved also when appropriate split of header files are dec=
ided. Other than that any comments on this?
>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo L=
azar
> Sent: Friday, September 29, 2023 3:08 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
>
> Move definition of package type to amdgpu header and add new package type=
s for CEM and OAM.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 73e825d20259..ac048a77e97c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -302,6 +302,13 @@ struct amdgpu_hive_info;  struct amdgpu_reset_contex=
t;  struct amdgpu_reset_control;
>
> +enum amdgpu_pkg_type {
> +       AMDGPU_PKG_TYPE_APU =3D 2,
> +       AMDGPU_PKG_TYPE_CEM =3D 3,
> +       AMDGPU_PKG_TYPE_OAM =3D 4,
> +       AMDGPU_PKG_TYPE_UNKNOWN,
> +};
> +
>  enum amdgpu_cp_irq {
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 42ac6d1bf9ca..7088c5015675 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
>
>  #define NUM_XCC(x) hweight16(x)
>
> -enum amdgpu_pkg_type {
> -       AMDGPU_PKG_TYPE_APU =3D 2,
> -       AMDGPU_PKG_TYPE_UNKNOWN,
> -};
> -
>  enum amdgpu_gfx_ras_mem_id_type {
>         AMDGPU_GFX_CP_MEM =3D 0,
>         AMDGPU_GFX_GCEA_MEM,
> --
> 2.25.1
>
