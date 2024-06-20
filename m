Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C49FC2BA18
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 13:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232E810E1BD;
	Thu, 20 Jun 2024 13:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U/wUylrW";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097E510E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 13:07:40 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-6e3ff7c4cc8so637260a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718888860; x=1719493660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M22I+n6woM27XGqCNUNR5NJNSsf9QUM1ZaAvcRWGvp0=;
 b=U/wUylrW/wZGMym1t0mzqN5XWRyXGurwUAHPOh3zX9if8pGEfgXQXN5d26+h+1FDbr
 BK9yo63hrEG6XbM1I8/joMWK0zoJuIe4jkhyZNFe7AMBfdPgkGRTuLMZ68CRgsjp9FLX
 JQmLOSfnWZHUhlUfveXEk14uF8WMp3PIsmVpc+KaVzjPvM9LJDeOutCrHNUUVFBrGoTC
 YcoI41hYnsIqqqS4O6k0j11d5ZbpZaVSDbgMsyE3FQyTvw/0ucjY0pg++S7xvwTB0Pwc
 s8ndSpjBC7aDkIG6IQwtNo6ZWjXvaZiVP72jxZ3+pJbAD388piwdFCt8/3s1M/tjRVzr
 tJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718888860; x=1719493660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M22I+n6woM27XGqCNUNR5NJNSsf9QUM1ZaAvcRWGvp0=;
 b=TXqfwosUSyP0feNStmDBNz0U6tMDAt2I6ScRBOC7wu64HDKcoWlBkvsZvjzrKUTq6O
 pbJmD/9AUVPLW0TbToL4JWHWqqPLNXy3jsl50MmnSfvSaFlK1iZSZe8pp9lSTrHfbg59
 ezMPdDcud+ElGismDThB8cZnyem9tKVDTyHBZtCYyXPvUtdpkaOayqTYdtVNk0hZ25D5
 3yHaaieXNgu+NlWhfcEI35ieEItjZDBdckoAnzrEoWFl5U9CbYbMEb6nka88mBOeK92E
 9JV1L5Rf33u2k1Qab/ag3/uwVsUTh02zbKNBQ/1ulzVUwUAm8QoQ0O0uGxRkc7v6pIlA
 7ChQ==
X-Gm-Message-State: AOJu0Yz9kduHcItwRg+8hMGmMpT86/u9R9gye1HvvCyLgemGo/N5ZoPl
 al0heQb5YEexszGRogSDbLCA0LNECcZ5AHew21O/3Urt87MbmJ9MClwXcIUXlPCiTuNORs2Zx2N
 ou/iZ/bg/N8013l9lTwMHJA2wQOk=
X-Google-Smtp-Source: AGHT+IGKLBHYNzwTZGYjyYw7BN/5Nx3vp/ba0QONQmkMGAqWKdAeSBd+wPXkAWgAmeey9srjqS3wdYjslvtNeVKuo+I=
X-Received: by 2002:a17:902:e843:b0:1f9:ccd0:2ab4 with SMTP id
 d9443c01a7336-1f9ccd02cbamr15229285ad.43.1718888860295; Thu, 20 Jun 2024
 06:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240620054406.2662-1-Frank.Min@amd.com>
 <SA1PR12MB5659299BF8D06931F83065E1E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659299BF8D06931F83065E1E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 09:07:28 -0400
Message-ID: <CADnq5_MMv6wA_mMQ2E+5-SwCOgKoKtvoVbcnyvZEY3Qfh2ExhA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: access ltr through pci cfg space
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>
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

On Thu, Jun 20, 2024 at 3:02=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>
>
> Access ltr through pci cfg space instead of mmio while programing aspm on=
 gfx12
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/a=
md/amdgpu/nbif_v6_3_1.c
> index 5a20bb229788..39919e0892c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
> @@ -345,6 +345,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_de=
vice *adev)  {  #ifdef CONFIG_PCIEASPM
>         uint32_t def, data;
> +       u16 devctl2, ltr;
>
>         def =3D data =3D RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
>         data &=3D ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
> @@ -374,12 +375,17 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_=
device *adev)
>         if (def !=3D data)
>                 WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data)=
;
>
> -       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVIC=
E_CNTL2);
> -       data &=3D ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
> +       pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
> +       data =3D def =3D devctl2;
> +       data &=3D ~PCI_EXP_DEVCTL2_LTR_EN;
>         if (def !=3D data)
> -               WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, =
data);
> +               pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, (u1=
6)data);
> +
> +       ltr =3D pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_LTR);
>
> -       WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x100110=
01);
> +       if (ltr) {
> +               pci_write_config_dword(adev->pdev, ltr + PCI_LTR_MAX_SNOO=
P_LAT, 0x10011001);
> +       }
>
>  #if 0
>         /* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or=
 someone else ? */
> --
> 2.34.1
>
