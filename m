Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NAxnxjlk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D4C10E37D;
	Mon, 26 Oct 2026 18:25:33 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB2610F095
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:25:28 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35159e0092aso495327eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793039127; cv=none;
 d=google.com; s=arc-20260327;
 b=O1Ds/E9om1ezvyqc6lvhsMLgQzpmzSQL3tUlrzZhw5aoq33Uup/kx33DRkhIDLqxdY
 YRjVSb06DnS80wkxu9kgY0JxEJ/tstr0PCF2nakdBkJv3I7aJYXIWyKdwLrWTsDFXdlB
 q6WSIpXmV5ycFnehK772UdjAdsu0KCH3nw3CzvJsXcnWBYDr8rbjzHKH1AhPrQRRKvw7
 rMJkGYZE8GVJzWNhqulr55tdhhjG4HqGgxsSRgOIg6PAUFkWFTvdOV1i2xQPdrwc95/f
 KnolBBi9QHw0W7YNbgMY/gCG4xz5x+o1Cz6Onyb65+gxArgFdfPk6Ya2DTxZwU/JTkGZ
 7PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
 fh=yEO2q63ynnq/5UBBeATOJtRYpoaFi7ZktmFrhMqrq0E=;
 b=PY2EATYllMQozaJHEYco0AW7OhAb0Nx6EesueXhm6TSJYdrLrSBd9i3r0ll1r5b8gA
 mv13WLUnys6/ypwLSBm6fzomG1XpY7SGw+r1OVLF/3a+xiOr1xtXKfF65rqZeQZTbNJe
 +gM+hwOyzB4TzDK+5TcqgACol1/If39Tv8js91FOFWQy0F/ocVCxjrW7syZk7RnGEvyf
 Muhev6DvJRhjNDYaXqoEb5AS9ZRrLZ/ess+YoSGHUEVmajaCrTmNvOsS/xGsVQUxC2rJ
 mlBpnngNiIsDN6uiNgiz4yY3648z3BI4+sSyJXIAK+x4UJhUF1fMJzHhuChL655y35OE
 7qrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793039127; x=1793643927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
 b=NAxnxjlkJ22m33oPl+q/tQWY7wQkGtEMMP0p2kTpI/Rd3RtCaxbpYXlzaDilLwsKQj
 nYmeAKTHdUTLcHRFlLkMO69hFwNadX/G5aYNLbPgxE4umcNDBYIsIIuHiJ1HbTj1jzYY
 wCrO3QLUXJ/TilBvDQn70h4yCZLF/+hkJ1Mtn+gZlXCut8D1bhodsKvSGrHlpuROgj4T
 e9Gc+3MwQlSLTPAo66cbC4J3KWjOzgAPqbg8jUcK1aVSBVEP1kC/gtxRma+ucO2XXXtL
 L0yaeLfwldC15vprD92R73vSLpqLMK3u+9n0W4mhygSuKr6BOebYKp5sdWOVnXBTu2r5
 H1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039127; x=1793643927;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Do/93Ec+a4uH5EBQqfEmx8Kskebovc78z6QXsKmL6Zw=;
 b=FlRxgYiEoPIUwY8sdXsKgoabKfEGOgsa9mfS0FwzTDqrCPk+jnmG6NBqgFfSUIGmkx
 GwkOSvt4FTYB8Z1AWbknjVw4L3sFFdJSe5u4zF9pRuUTrxob40RPEJe70FO4sejpEtaV
 SshjsgrnmQnLCfylJ5Si1UxwFvAA5x4vbYllg24pLOcVySLhfdHL+kB94u5KR2NFmjk2
 vUhl+db9DYJ864Kf8IPWAziSKXOnyP1W/lSwYwpRfNXW905+j1gyYX8r97wNSH7T9CNu
 g4vyPc1BnCF55CmQoGbsHdPL2AEJgZNdVY/TFedUmZ3GNysz139NKiRwaxZ7LZ1Db5S8
 +bGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw42f7LuR19yz07rRuSmPY8jvIOxi0wrNHPNz2NhcmR0FGf7CUdLl75RdnXwhCZFlveFWo/Oq9s@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLs7JKn9mpxlGHJquvvDo/pd3RaeeyFDckhqdOzmX7Z97z3It8
 AIIGUY39VJ1A27KogBcjajl61kTwA8c0jAeoLX/9RcLZ9p0deMDG5BWQFSh/FA4VT9G/6XthBWS
 daCJuKTOkcG+ABpGIFoSO8XfFG7NSzTM=
X-Gm-Gg: AYBFou0Fau1yMtb607EkFdaQj3n+YQwO357qkQ06hj3O07UEz13fPcxvqfzS4bCTqTg
 TDc4e2l7lwf+dHNuTei0ZcpSXtlaaJxeH06M6nagG3yHjJJ8vrYTCzbmxmBM9gdtcqVVLoEN/rP
 f9x1lZy86NeMzOc1wfOVuy3IFQsZDpxyX9wVf1UW/v78z+Zm7/bqPB2PCjhbmrogNA7SgdEaah/
 pyj+qIqCcg+De7MwMdYTHwIESl4Qgo376n/DeH6t6p94RJuLZ1UlmIh8Iy1RCm0N7oweJ+1vNou
 cKSSU1f28zD/8VY3kSURFIAKgb4SHyB9Q+6yPiYiR+l3L7/WZvJpZitMYVRE23KLOUVQhEwWTWm
 XxLjup8X0BXMUmvBm87aoPa+9RcLGv8lvJ5+trkGMsfLQRFDolDsWEvrjtpVVu0Dk58mRN+tVpE
 pVRR7681oNv2lurYTQRb2DZeA=
X-Received: by 2002:a05:7022:7f05:b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-199345c5ecamr17915804c88.1.1793039127302; Mon, 26 Oct 2026
 11:25:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-11-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:25:15 -0400
X-Gm-Features: AclHuK-iVje5ZZPGXAxueHXGbehXRgBbIH4abpn4VFZrQQC5igwZxtMQm-2wnbg
Message-ID: <CADnq5_O2tEUHOcbiKL8c4UHpy3AmOWtmM7A8o3jP2qLwkx2jUQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/amdgpu: Catch register access while GMUX keeps
 the GPU off
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 12:26=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> As mentioned previous any access to the GPU when the GMUX has
> shut off the rails results in a CPU CATTER, skip and report
> any register access after the GPU was runtime suspended for GMUX power-of=
f.
>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6fd607587..ac8dfc3ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -881,6 +881,8 @@ struct amdgpu_device {
>         /* enable runtime pm on the device */
>         bool                            in_runpm;
>         bool                            has_pr3;
> +       /* GMUX has cut power, any register access would hang the PEG lin=
k */
> +       bool                            gmux_off;

You can drop this.  Nothing about this is GMUX specific.

>
>         bool                            ucode_sysfs_en;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c1f196242..8185934b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -946,6 +946,11 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_devi=
ce *adev)
>         if (adev->no_hw_access)
>                 return true;
>
> +       if (unlikely(READ_ONCE(adev->gmux_off))) {
> +               WARN_RATELIMIT(1, "%s: register access while powered off =
by GMUX\n",
> +                                       dev_name(adev->dev));
> +               return true;
> +       }
>  #ifdef CONFIG_LOCKDEP
>         /*
>          * This is a bit complicated to understand, so worth a comment. W=
hat we assert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 5ad7b6dd8..135798c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2932,6 +2932,9 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>                 amdgpu_device_baco_enter(adev);
>         }
>
> +       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
> +               WRITE_ONCE(adev->gmux_off, true);
> +
>         dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
>
>         return 0;
> @@ -2960,6 +2963,8 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
>         if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
>                 return -EINVAL;
>
> +       WRITE_ONCE(adev->gmux_off, false);
> +
>         /* Avoids registers access if device is physically gone */
>         if (!pci_device_is_present(adev->pdev))
>                 adev->no_hw_access =3D true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_reg_access.c
> index 7468855c1..bb5dbeb7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -594,6 +594,9 @@ u32 amdgpu_device_indirect_rreg(struct amdgpu_device =
*adev, u32 reg_addr)
>         void __iomem *pcie_data_offset;
>         u32 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -677,6 +680,12 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr)
>         void __iomem *pcie_data_offset;
>         u64 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;

Duplicate check here.

Alex

> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -706,6 +715,9 @@ u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_d=
evice *adev, u64 reg_addr)
>         void __iomem *pcie_data_offset;
>         u64 r;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return 0;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> @@ -762,6 +774,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device=
 *adev, u32 reg_addr,
>         void __iomem *pcie_index_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -784,6 +799,9 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_de=
vice *adev, u64 reg_addr,
>         void __iomem *pcie_index_hi_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> @@ -832,6 +850,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev, u32 reg_addr,
>         void __iomem *pcie_index_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>
> @@ -861,6 +882,9 @@ void amdgpu_device_indirect_wreg64_ext(struct amdgpu_=
device *adev, u64 reg_addr,
>         void __iomem *pcie_index_hi_offset;
>         void __iomem *pcie_data_offset;
>
> +       if (amdgpu_device_skip_hw_access(adev))
> +               return;
> +
>         pcie_index =3D adev->nbio.funcs->get_pcie_index_offset(adev);
>         pcie_data =3D adev->nbio.funcs->get_pcie_data_offset(adev);
>         if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offs=
et))
> --
> 2.55.0
>
