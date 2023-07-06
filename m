Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A4EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19BD10E08F;
	Thu,  6 Jul 2023 18:12:43 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AE510E08F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:12:43 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5634808e16eso738271eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688667161; x=1691259161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxoEjy5dZAAh8sjJttfLOOtEgT/iZ31HS8tRe5bTiRc=;
 b=LAlBxfTlu0rFK9nvKaTSfBgWEMJU3XRatrjgDcp5pfssv+HQjLowoWuqyJ46rEHxnz
 rOXi6BncZyh89E8rPR/dP+2xyppj4QsO0i/J4TLGvhqaM/VPjIN5gCcA+xkX+8SKyU3r
 jKZV7aHPLKs87LE/aj2MdPmZwZEJVUIjccm8ZEpL3DSUQyWDHnWzM2ZzD6c2AEztWEng
 k5GisDVs1TPc5jo6J4JZoH/uZuh57aW+++/nvVMsdPq/ZPQKhfa5Bp28HvyEfxpzSpNo
 BLiruIXuUhXVLOzQpqp1R4vr2GJ8nz+1OReAhHNTFMzy+2BpDSirlmKVYyBpCJheVwtq
 PP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688667161; x=1691259161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxoEjy5dZAAh8sjJttfLOOtEgT/iZ31HS8tRe5bTiRc=;
 b=aLaSPBzAt7uv3rsO26e1aEM6YEsaPruok0CCGGrkDEA+7bJ8GSYfFsuaqaQOA+sGB0
 04Eo6OFtb6eQ9L1T7DVPCOmxd7PBKMF68K3WFLmlhZ3rGi23oW9r9jhxZ/EaUQ8/dlk1
 3bdv8DqSxUCU6ayxuAfQ+qy/FqIT45oSIGMihf7iqxERw2go3nwBXzI637R/SDwedOFk
 SuX12yYwIFOz0wWUihP4rDhhRiCbN/aI2of9lmHpGav1iopq4tyLA+/SsBoOv4Sj3pn5
 phBVnro80JJWX5UBPUYs1YYgSXxkqMEYTQN7iHOQox2J7pVPjbtDXz5Uxd5jiJDRipcs
 maPg==
X-Gm-Message-State: ABy/qLY3yor2RWp1E6rlyMYJKlbpBDHlyhLD6l9DN/UdIwu26A37V02X
 sATdfshFA8lscKVxwpozWHa78IcGPiMuXVM2MpqD5rOy
X-Google-Smtp-Source: APBJJlGpNZRMgHWNauY1FvsRAhJWxf6MEI8b6JaTbC9AWMSthwhJE10GxroTGHTLv0VRdjHENpRs+t3C1EN8cK7+/WY=
X-Received: by 2002:a05:6808:13c4:b0:3a1:b938:e9df with SMTP id
 d4-20020a05680813c400b003a1b938e9dfmr3592772oiw.31.1688667161134; Thu, 06 Jul
 2023 11:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230706162528.17739-1-Zhigang.Luo@amd.com>
In-Reply-To: <20230706162528.17739-1-Zhigang.Luo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 14:12:29 -0400
Message-ID: <CADnq5_OVpY=He1xcXR0xFdHN8nAdy4ZX3uc+vV24SZFMa2NEbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove SRIOV VF FB location programming
To: Zhigang Luo <Zhigang.Luo@amd.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 12:25=E2=80=AFPM Zhigang Luo <Zhigang.Luo@amd.com> w=
rote:
>
> For SRIOV VF, FB location is programmed by host driver, no need to
> program it in guest driver.
>
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: I2a4838f6703e94bb0bcf3a8e923c69466e37803f
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 15 +--------------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 12 ------------
>  2 files changed, 1 insertion(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index 47f95ec218a3..03ae661e3b54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -406,20 +406,6 @@ static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu=
_device *adev,
>         int i;
>
>         tmp_mask =3D xcc_mask;
> -       /*
> -        * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
> -        * VF copy registers so vbios post doesn't program them, for
> -        * SRIOV driver need to program them
> -        */
> -       if (amdgpu_sriov_vf(adev)) {
> -               for_each_inst(i, tmp_mask) {
> -                       i =3D ffs(tmp_mask) - 1;
> -                       WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB=
_LOCATION_BASE,
> -                                    adev->gmc.vram_start >> 24);
> -                       WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB=
_LOCATION_TOP,
> -                                    adev->gmc.vram_end >> 24);
> -               }
> -       }
>
>         /* GART Enable. */
>         gfxhub_v1_2_xcc_init_gart_aperture_regs(adev, xcc_mask);
> @@ -606,6 +592,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_de=
vice *adev)
>         max_region =3D
>                 REG_GET_FIELD(xgmi_lfb_cntl, MC_VM_XGMI_LFB_CNTL, PF_MAX_=
REGION);
>
> +       DRM_INFO("XXXXXX xgmi_lfb_cntl=3D0x%x seg_size=3D0x%llx", xgmi_lf=
b_cntl, seg_size);

Leftover debugging statement.  With that removed, the series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
>
>         max_num_physical_nodes   =3D 8;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_8.c
> index 5e8b493f8699..784c4e077470 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -413,18 +413,6 @@ static void mmhub_v1_8_program_invalidation(struct a=
mdgpu_device *adev)
>
>  static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_sriov_vf(adev)) {
> -               /*
> -                * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase the=
y are
> -                * VF copy registers so vbios post doesn't program them, =
for
> -                * SRIOV driver need to program them
> -                */
> -               WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
> -                            adev->gmc.vram_start >> 24);
> -               WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
> -                            adev->gmc.vram_end >> 24);
> -       }
> -
>         /* GART Enable. */
>         mmhub_v1_8_init_gart_aperture_regs(adev);
>         mmhub_v1_8_init_system_aperture_regs(adev);
> --
> 2.25.1
>
