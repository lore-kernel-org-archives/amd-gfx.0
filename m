Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B8ECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 03:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178F810E6CB;
	Thu,  8 Sep 2022 03:53:50 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0792110E6CB
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 03:53:47 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-127dca21a7dso13875362fac.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Sep 2022 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=l6NJaTKwEzsUeLi+E/HRk3WppQuMne4Aw9OZ/pKkHHQ=;
 b=DDMJJD/t7FsQnlGlQwHlpKFY+BXfgQWJqjnYA2TuWR2pNVOZP7inCViWY59JQ/wfmW
 snrjggPey/R/i07HPWzMKo9zdiO+bhYZTFQKRMvoL+2JTcICJclV+OteiEk3R0dT1nfV
 WZFwuHrziGFSeqTCDCiTO2WHt926+04Woznic65KXARzA/Ocy6qVH27Zn8mp9iKdAl6K
 YhtU3u89FsX80J/uvDw4DQ+1jv8bWBKJAHEn8qbEt1BZxDtWSOAqSpFn7kVGFZCwxURL
 eaXglMwOXXg8M9c3iJWT1N6qBi1JkSPjLt3HvTdKIzpM/p8pllyjUc1pRQ+BOYn3MxBR
 zRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=l6NJaTKwEzsUeLi+E/HRk3WppQuMne4Aw9OZ/pKkHHQ=;
 b=6Vdsl2fIzgDZ/xQgCUH0i14S0BJuNOn1oaTaKLmCpY4JItLJll6QX274uRMMnL+XW/
 mWpe4QvUhdqxP+yByZfhfQuFUePpvV6YBzE006y3npMhts73jZA+iadkdXSLRPOBS4GN
 OWt+hUJHfC0/uRbCxaGJoL64MPKrVoQ3VMW1/DwOU0UW78PGHUOYKuiJ879PnRcCGt6E
 HbFbCC5eJzUpjINuMWnR61K+SFq7h4env4EMb9bPjIfVJIXmWEAuT4VBnlY1OWbrJYCO
 fCO9KURiHHzLqKfWERvHJMJ824mG9kKwpejcaentNQWrVyWltFhJnaGgJIWl5/CeMS6v
 PtIw==
X-Gm-Message-State: ACgBeo10YqfO/SLTNku8GArHoQS747Hx0dGnBM1hyxZw5ddMJhWV7A3I
 C5lxGbE0jMBkNZUX5zwfvE7VPVh7ZDUOIqLQLr8=
X-Google-Smtp-Source: AA6agR6wB4TlEvFnY/1o4mg+//uRJcWR5499ivpee1TQBLXg6SBtu21avN5ycYzxr8SXYCov+ZnlFNiZ1mpoV/UYsMc=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr873127oam.96.1662609226653; Wed, 07 Sep
 2022 20:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220908032344.1682187-1-lijo.lazar@amd.com>
 <CADnq5_MQ64piXz-CJeEn2e4yi_kwePYCea_sTxdFUAb+j8wu5Q@mail.gmail.com>
 <b3b786b1-2f72-4f5e-f011-8acf06867d0e@amd.com>
 <CADnq5_ObpVNo7CVKpNEg0UJx0BnLb7OOoBhozKRxu-nR2N-8vQ@mail.gmail.com>
In-Reply-To: <CADnq5_ObpVNo7CVKpNEg0UJx0BnLb7OOoBhozKRxu-nR2N-8vQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Sep 2022 23:53:35 -0400
Message-ID: <CADnq5_OEckaKYr-bKi5iNXiB4+RYeY9kVy6XYoFwCu4svdBb6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: stable@vger.kernel.org, wielkiegie@gmail.com, helgaas@kernel.org,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 7, 2022 at 11:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Sep 7, 2022 at 11:40 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
> >
> >
> >
> > On 9/8/2022 8:58 AM, Alex Deucher wrote:
> > > On Wed, Sep 7, 2022 at 11:24 PM Lijo Lazar <lijo.lazar@amd.com> wrote=
:
> > >>
> > >> As per PCIE Base Spec r4.0 Section 6.18
> > >> 'Software must not enable LTR in an Endpoint unless the Root Complex
> > >> and all intermediate Switches indicate support for LTR.'
> > >>
> > >> This fixes the Unsupported Request error reported through AER during
> > >> ASPM enablement.
> > >>
> > >> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216455&amp;data=3D05%7C01%7=
Clijo.lazar%40amd.com%7Cc190635e13f047625b4508da914a47a5%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637982045476774989%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%=
7C&amp;sdata=3DmNq7A7oT2VwZVc7WtYyWj0BRAXV5MzNLir0o4%2BKiWYU%3D&amp;reserve=
d=3D0
> > >>
> > >> The error was unnoticed before and got visible because of the commit
> > >> referenced below. This doesn't fix anything in the commit below, rat=
her
> > >> fixes the issue in amdgpu exposed by the commit. The reference is on=
ly
> > >> to associate this commit with below one so that both go together.
> > >>
> > >> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in ge=
t_port_device_capability()")
> > >>
> > >> Reported-by: Gustaw Smolarczyk <wielkiegie@gmail.com>
> > >> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > >> Cc: stable@vger.kernel.org
> > >> ---
> > >
> > > Even though the ASPM code in si.c, cik.c, and vi.c doesn't mess with
> > > LTR, it still sets up ASPM so shouldn't it be protected with
> > > CONFIG_PCIEASPM as well?
> > >
> >
> > Yes, but it is only a compilation improvement and unrelated to this
> > patch. We don't access any ASPM related kernel variables in those
> > sequences. ltr_path variable used under this patch is declared under
> > ASPM config.
>
> Thanks for the information.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> >
> > Runtime protection is already there -
> > 0ab5d711ec74 (drm/amd: Refactor `amdgpu_aspm` to be evaluated per devic=
e)
> >
> > Thanks,
> > Lijo
> >
> > > Alex
> > >
> > >>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 9 ++++++++-
> > >>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 9 ++++++++-
> > >>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 9 ++++++++-
> > >>   3 files changed, 24 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/dr=
m/amd/amdgpu/nbio_v2_3.c
> > >> index b465baa26762..aa761ff3a5fa 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > >> @@ -380,6 +380,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_=
device *adev,
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL, data);
> > >>   }
> > >>
> > >> +#ifdef CONFIG_PCIEASPM
> > >>   static void nbio_v2_3_program_ltr(struct amdgpu_device *adev)
> > >>   {
> > >>          uint32_t def, data;
> > >> @@ -401,9 +402,11 @@ static void nbio_v2_3_program_ltr(struct amdgpu=
_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data=
);
> > >>   }
> > >> +#endif
> > >>
> > >>   static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
> > >>   {
> > >> +#ifdef CONFIG_PCIEASPM
> > >>          uint32_t def, data;
> > >>
> > >>          def =3D data =3D RREG32_PCIE(smnPCIE_LC_CNTL);
> > >> @@ -459,7 +462,10 @@ static void nbio_v2_3_program_aspm(struct amdgp=
u_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> > >>
> > >> -       nbio_v2_3_program_ltr(adev);
> > >> +       /* Don't bother about LTR if LTR is not enabled
> > >> +        * in the path */
> > >> +       if (adev->pdev->ltr_path)
> > >> +               nbio_v2_3_program_ltr(adev);
> > >>
> > >>          def =3D data =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP3);
> > >>          data |=3D 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_T=
IMER__SHIFT;
> > >> @@ -483,6 +489,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu=
_device *adev)
> > >>          data &=3D ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_A=
CK_MASK;
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> > >> +#endif
> > >>   }
> > >>
> > >>   static void nbio_v2_3_apply_lc_spc_mode_wa(struct amdgpu_device *a=
dev)
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/dr=
m/amd/amdgpu/nbio_v6_1.c
> > >> index f7f6ddebd3e4..37615a77287b 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
> > >> @@ -282,6 +282,7 @@ static void nbio_v6_1_init_registers(struct amdg=
pu_device *adev)
> > >>                          mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FL=
USH_CNTL) << 2;
> > >>   }
> > >>
> > >> +#ifdef CONFIG_PCIEASPM
> > >>   static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
> > >>   {
> > >>          uint32_t def, data;
> > >> @@ -303,9 +304,11 @@ static void nbio_v6_1_program_ltr(struct amdgpu=
_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data=
);
> > >>   }
> > >> +#endif
> > >>
> > >>   static void nbio_v6_1_program_aspm(struct amdgpu_device *adev)
> > >>   {
> > >> +#ifdef CONFIG_PCIEASPM
> > >>          uint32_t def, data;
> > >>
> > >>          def =3D data =3D RREG32_PCIE(smnPCIE_LC_CNTL);
> > >> @@ -361,7 +364,10 @@ static void nbio_v6_1_program_aspm(struct amdgp=
u_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> > >>
> > >> -       nbio_v6_1_program_ltr(adev);
> > >> +       /* Don't bother about LTR if LTR is not enabled
> > >> +        * in the path */
> > >> +       if (adev->pdev->ltr_path)
> > >> +               nbio_v6_1_program_ltr(adev);
> > >>
> > >>          def =3D data =3D RREG32_PCIE(smnRCC_BIF_STRAP3);
> > >>          data |=3D 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_T=
IMER__SHIFT;
> > >> @@ -385,6 +391,7 @@ static void nbio_v6_1_program_aspm(struct amdgpu=
_device *adev)
> > >>          data &=3D ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_A=
CK_MASK;
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> > >> +#endif
> > >>   }
> > >>
> > >>   const struct amdgpu_nbio_funcs nbio_v6_1_funcs =3D {
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/dr=
m/amd/amdgpu/nbio_v7_4.c
> > >> index 11848d1e238b..19455a725939 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> > >> @@ -673,6 +673,7 @@ struct amdgpu_nbio_ras nbio_v7_4_ras =3D {
> > >>   };
> > >>
> > >>
> > >> +#ifdef CONFIG_PCIEASPM
> > >>   static void nbio_v7_4_program_ltr(struct amdgpu_device *adev)
> > >>   {
> > >>          uint32_t def, data;
> > >> @@ -694,9 +695,11 @@ static void nbio_v7_4_program_ltr(struct amdgpu=
_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data=
);
> > >>   }
> > >> +#endif
> > >>
> > >>   static void nbio_v7_4_program_aspm(struct amdgpu_device *adev)
> > >>   {
> > >> +#ifdef CONFIG_PCIEASPM
> > >>          uint32_t def, data;
> > >>
> > >>          if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(7, 4,=
 4))
> > >> @@ -755,7 +758,10 @@ static void nbio_v7_4_program_aspm(struct amdgp=
u_device *adev)
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> > >>
> > >> -       nbio_v7_4_program_ltr(adev);
> > >> +       /* Don't bother about LTR if LTR is not enabled
> > >> +        * in the path */
> > >> +       if (adev->pdev->ltr_path)
> > >> +               nbio_v7_4_program_ltr(adev);
> > >>
> > >>          def =3D data =3D RREG32_PCIE(smnRCC_BIF_STRAP3);
> > >>          data |=3D 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_T=
IMER__SHIFT;
> > >> @@ -779,6 +785,7 @@ static void nbio_v7_4_program_aspm(struct amdgpu=
_device *adev)
> > >>          data &=3D ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_A=
CK_MASK;
> > >>          if (def !=3D data)
> > >>                  WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> > >> +#endif
> > >>   }
> > >>
> > >>   const struct amdgpu_nbio_funcs nbio_v7_4_funcs =3D {
> > >> --
> > >> 2.25.1
> > >>
