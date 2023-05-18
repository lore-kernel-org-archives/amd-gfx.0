Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F25C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 13:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1E010E0C0;
	Thu, 18 May 2023 13:51:50 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0119410E0C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 13:51:48 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-552b65f527dso1069120eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684417907; x=1687009907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjP8fVbYT1gIb8aU1S8eAJxok9TQSFAn5SL1XOovhls=;
 b=GadkeMFT/i07js8GtS4isCkQ+/hJBXsI/C+AT7zUiXGQXDJRryPIsC3QXq+zlQFUxJ
 jRubDpTqptbQjNJ+XmhRgkIXMvoY53Rc4t9IBpqwKEBBTCWryIBw2RHDzqmPx++Vy3js
 /rW6a5Dni0iZMUJhbewaypWBoThtEBr2fMhupu1KyYDLsZewWLCCYo/t8Aa0wpSLwlKq
 mDo6FvGWewoTH6SdCNvsG3hOIqevCUR87MrA1AqO4QOmrZWA2uykE59EwHmQyo0NuZQt
 YWAkMsGiWjPIHsPCVvacXoIGMlrHYYK9x4z3UBWmwEvJepVu93AEI3S3cnQSCFHkJq5+
 ydiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684417907; x=1687009907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjP8fVbYT1gIb8aU1S8eAJxok9TQSFAn5SL1XOovhls=;
 b=aRO3JGc6nH3qqxcgVngYoN0AK52HtAZCuI3yLNTYPYMY0I5UMCflify3+m7sa2WMkw
 3l5KuqU92nEmEEL36QABErZ5lYdbwwyGNT7PzzgRAr42uH7T+eEOZHEn/xMG4J5Zg20v
 VJabjqUtCGpAjDJQ0b6dglllQfX60XCOZB5SRpyHQuvQVosBGsxhkGg5yb1GbuyAH5Pu
 TfmgbTy2XhRPCSdtY6WAQlWaKWWlD6AGxu0P/TC01CH1nWFLfeLw+U7csStWay4OICtY
 7d6p3k7GlITntb5p4wK7r0xdOaQVHiyMRpobR5+fmaE1YHb7yqwcjkbjZzOyUoy3/H5h
 LntA==
X-Gm-Message-State: AC+VfDx4s2+/PEMm++leOijPfM+wzRh8jPwtJKI2wi76DKLVjTc3UfJy
 ThZYuozm1EbuKOMfIZGDHm8Cdr5nziGWT6qrh1841+Vh
X-Google-Smtp-Source: ACHHUZ5wVOFIe/6z67PVf07NjEA6HlOOBe5Ly7RTAk6oNuRUdjGVXqSKLjtqdv/1H8LmAWMsoyvln+vfNe8NKz40a70=
X-Received: by 2002:a05:6808:4c8:b0:38c:398e:6afd with SMTP id
 a8-20020a05680804c800b0038c398e6afdmr1231330oie.53.1684417907475; Thu, 18 May
 2023 06:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230518031137.192047-1-Tong.Liu01@amd.com>
In-Reply-To: <20230518031137.192047-1-Tong.Liu01@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 May 2023 09:51:36 -0400
Message-ID: <CADnq5_O1d0Xfi=_D-HMFE2x_xvgNgEc0J7LaNMKz+jO6Jwyd+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect pcie_gen_mask in passthrough
 case
To: Tong Liu01 <Tong.Liu01@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, amd-gfx@lists.freedesktop.org, haijun.chang@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 17, 2023 at 11:12=E2=80=AFPM Tong Liu01 <Tong.Liu01@amd.com> wr=
ote:
>
> [why]
> Passthrough case is treated as root bus and pcie_gen_mask is set as
> default value that does not support GEN 3 and GEN 4 for PCIe link
> speed. So PCIe link speed will be downgraded at smu hw init in
> passthrough condition
>
> [how]
> Move get pci info after detect virtualization and check if it is
> passthrough case when set pcie_gen_mask
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a9d9bbe8586b..18c6e9872247 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3813,8 +3813,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_ba=
se);
>         DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
>
> -       amdgpu_device_get_pcie_info(adev);
> -
>         if (amdgpu_mcbp)
>                 DRM_INFO("MCBP is enabled\n");
>
> @@ -3830,6 +3828,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* detect hw virtualization here */
>         amdgpu_detect_virtualization(adev);
>
> +       amdgpu_device_get_pcie_info(adev);
> +
>         r =3D amdgpu_device_get_job_timeout_settings(adev);
>         if (r) {
>                 dev_err(adev->dev, "invalid lockup_timeout parameter synt=
ax\n");
> @@ -5589,7 +5589,7 @@ static void amdgpu_device_get_pcie_info(struct amdg=
pu_device *adev)
>                 adev->pm.pcie_mlw_mask =3D amdgpu_pcie_lane_cap;
>
>         /* covers APUs as well */
> -       if (pci_is_root_bus(adev->pdev->bus)) {
> +       if (pci_is_root_bus(adev->pdev->bus) && !amdgpu_passthrough(adev)=
) {
>                 if (adev->pm.pcie_gen_mask =3D=3D 0)
>                         adev->pm.pcie_gen_mask =3D AMDGPU_DEFAULT_PCIE_GE=
N_MASK;
>                 if (adev->pm.pcie_mlw_mask =3D=3D 0)
> --
> 2.34.1
>
