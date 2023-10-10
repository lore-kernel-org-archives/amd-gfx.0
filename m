Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F0CD80D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F2310E37D;
	Tue, 10 Oct 2023 14:01:59 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A0D10E37D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:01:57 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1e113555a47so3841976fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696946517; x=1697551317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6uhZ5hWhl3djWs7zCmTi5jHkRyPAHm4e3b5ueDs8s4=;
 b=bUWdctNmlkGHRb6c0cLXYkHOwfoXz2F/KaQ8k+yLSAs67bvOg5y8ZU+3HRQrnk0hkl
 ZgwERgS3zXB4m/lsdPmamPXChXn3npFsyaDlEnxbsPRzxFY8H+ldg3Vd+5pI13ALcO+s
 55Q6FwfWOf4pgYkLo6pwWmPCNltJcYoul2bRP5d6u0ILXLOBzmZQLXXNFRynBrFf9dvu
 tC5jK56SyARKJZUm8FXdR8+joBk/+HVIxwdcNtBuVhbWWvc+PTASHsiVjZa4e0s3za26
 sGiIxwh3Lornpy31howE1HAK9b9elRizv+9P/KftjISrbkiVR3paX31j06FxuwRsz0jf
 gIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696946517; x=1697551317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6uhZ5hWhl3djWs7zCmTi5jHkRyPAHm4e3b5ueDs8s4=;
 b=FgXOtFo7W9KZyXHOY5FGKSA3uqpTcnT0YJws2XQL5SrXOa1008Fj0e4DSrqFb4GO6w
 jdlW+MAfyenQj9g628Fz1RmvDDZrWV6b1kz8CB8a2+GBNrC54//0u9hXMgc7dXtQyJNN
 BmjxaykcLK9w+5f2wSJ97qhKbpyMXGgmpE95d9bzFXPiH42R+/XWSYhVlPKfSq+zzJda
 IE688J0Yzp1VC+ULTAeXzH/Vm1/RaoZuFrO7b9PcBnRjitXQcZvlwRamuWLGm6CbjXJq
 q/aOvhsZnf8XcoBU6AT/Qfun7ce8igdebMWjjF7gj41ukyVDFrB/qh3yoXEKkIJX8dUi
 16+Q==
X-Gm-Message-State: AOJu0YzM+iY4zZDonNwVrs/1TEUyFNdWiL3tQdm7BqhpQ+KIF7aV55yI
 HsUR0FBFmP2aMY/rQD8/LvPQ0liY0z07wx6InR4/zBs8
X-Google-Smtp-Source: AGHT+IFpECc2fO0Xm9ElK7kmnwKoPAMZtgV3I73pczLTq7b09TYStabm0U1tVIAteFTRqBXE0xTsWVHt7KpmlEXIUV8=
X-Received: by 2002:a05:6870:1708:b0:1ba:caf2:acc3 with SMTP id
 h8-20020a056870170800b001bacaf2acc3mr22436375oae.5.1696946516843; Tue, 10 Oct
 2023 07:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231007085402.67350-1-Lang.Yu@amd.com>
 <20231007085402.67350-2-Lang.Yu@amd.com>
 <BL1PR12MB5144A7CE930A1DEB9778671BF7CEA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <ZSSeWF+QzRG8/CNa@lang-desktop>
In-Reply-To: <ZSSeWF+QzRG8/CNa@lang-desktop>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Oct 2023 10:01:45 -0400
Message-ID: <CADnq5_PigFnW97EqCEL5x0joDBZO5qqaCyUSdXycDO-1BxSxKA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
To: Lang Yu <Lang.Yu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 10, 2023 at 9:42=E2=80=AFAM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 10/10/ , Deucher, Alexander wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Yu, Lang <Lang.Yu@amd.com>
> > > Sent: Saturday, October 7, 2023 4:54 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > > <Yifan1.Zhang@amd.com>; Gopalakrishnan, Veerabadhran (Veera)
> > > <Veerabadhran.Gopalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> > > Subject: [PATCH 2/3] drm/amdgpu/umsch: power on/off UMSCH by DLDO
> > >
> > > VCN 4.0.5 uses DLDO.
> > >
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 26
> > > ++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > index a60178156c77..7e79954c833b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> > > @@ -34,6 +34,16 @@
> > >  #include "umsch_mm_4_0_api_def.h"
> > >  #include "umsch_mm_v4_0.h"
> > >
> > > +#define regUVD_IPX_DLDO_CONFIG                             0x0064
> > > +#define regUVD_IPX_DLDO_CONFIG_BASE_IDX                    1
> > > +#define regUVD_IPX_DLDO_STATUS                             0x0065
> > > +#define regUVD_IPX_DLDO_STATUS_BASE_IDX                    1
> > > +
> > > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT
> > > 0x00000002
> > > +#define UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG_MASK
> > > 0x0000000cUL
> > > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT
> > > 0x00000001
> > > +#define UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK
> > > 0x00000002UL
> > > +
> > >  static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > > *umsch)  {
> > >       struct amdgpu_device *adev =3D umsch->ring.adev; @@ -50,6 +60,1=
4
> > > @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm
> > > *umsch)
> > >
> > >       umsch->cmd_buf_curr_ptr =3D umsch->cmd_buf_ptr;
> > >
> > > +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) =
{
> > > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > > +                     1 <<
> > > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > > +                     0 <<
> > > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > > +
> > >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > > +     }
> > > +
> >
> > Is this the right place for this?  umsch_mm_hw_init() only calls this f=
or FW_LOAD_DIRECT.  Maybe that check needs to be dropped?
>
> That check is dropped in [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor =
loading.

Ah, I checked that, but I missed it.  Thanks.

>
> PMFW removed DLDO programing in PPSMC_MSG_PowerUpUmsch function.
> So driver needs to program it explicitly.

Ok.  So is the SMC message still required in addition?

Alex

>
> Regards,
> Lang
>
> > Alex
> >
> > >       data =3D RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
> > >       data =3D REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL,
> > > MES_CORE_SOFT_RESET, 0);
> > >       WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data); @@ -
> > > 229,6 +247,14 @@ static int umsch_mm_v4_0_ring_stop(struct
> > > amdgpu_umsch_mm *umsch)
> > >       data =3D REG_SET_FIELD(data, VCN_UMSCH_RB_DB_CTRL, EN, 0);
> > >       WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_DB_CTRL, data);
> > >
> > > +     if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 5)) =
{
> > > +             WREG32_SOC15(VCN, 0, regUVD_IPX_DLDO_CONFIG,
> > > +                     2 <<
> > > UVD_IPX_DLDO_CONFIG__ONO0_PWR_CONFIG__SHIFT);
> > > +             SOC15_WAIT_ON_RREG(VCN, 0, regUVD_IPX_DLDO_STATUS,
> > > +                     1 <<
> > > UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS__SHIFT,
> > > +
> > >       UVD_IPX_DLDO_STATUS__ONO0_PWR_STATUS_MASK);
> > > +     }
> > > +
> > >       return 0;
> > >  }
> > >
> > > --
> > > 2.25.1
> >
