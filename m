Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F49FA3755
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 14:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B097F10E1A6;
	Fri, 13 Sep 2024 14:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7MC8GSc";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D57410E1A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 14:27:01 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-7c3d8105646so74416a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726237620; x=1726842420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRYnK7kRPhBjKpH4njc7mWYJza8ec7zdVFQSvzjPiI0=;
 b=L7MC8GScm720JgitYiU2R51xnZkrTHhKy/r73ia3QGrEt3C5+ne0H3lqHGEikebVFW
 eSKssOLNVYZm9zemq/CBoOdh78jIGEmRb1O3VONdHeRJxf+bFF5y9nug8NQKeWvkt1QM
 JGBj3pBIQgNjTJ0Ze7kHhBB50qAQnCWF9i7ciZnxcOxU+8aGNdkK9jVApVgarVMDkhO3
 Jx74LEpDned0dJyL/kAKf8kNysGOObteE2dAmUCX9hgbBDQtGVjXjXPDkhvTkRKV9qRU
 QSTIxiv9TjlUXPtXShQXjyuXk7PzSb9u50bJ05JpBF49MyPZnsN/hSljUwGSb+zZ6xuL
 T4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726237620; x=1726842420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRYnK7kRPhBjKpH4njc7mWYJza8ec7zdVFQSvzjPiI0=;
 b=O/KAqrLNaWR0RR+q7x9NsKhB37+nEyufSWg3Om4YdM86YMl3Z7QWZazUDfyowq9H+x
 fjNhRchEvhE30NYDI87ChpHx2tOruJ6BC+I7PC5L52U2k5XXQnXJwn82xTiMii8B3IjJ
 uesWkrT6luneqVhLB/1ek4Qyyd8CBZ0/oBqxOY+naAjmjiMLvViyg8gVgFTEUjM7QybM
 tVZxMs9oxQygZyXdqK4O3CvxZUNwEnHo0OvK6IFUz9MQ97Wi/NwLjcQ+DmVlbLD1fbek
 Zn56HFJbWOSM/QzE2E5qNm7fg/6rBl3VCs/pYzNymu4i4XlGgViDgpXWxiDFyyOSplEs
 JrWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ1JhAszDvu+QHFL88V1cUIkkAI9YMtR9hxevCYyw8uYftPOMheFTJ4lkAaCC//8RrJ26s6wOe@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNQXWDm8IemOqRgis6Y6neeyi0dsQZIiE4k7m5bYgsXqdgWs/4
 G845NCx4MNgHyjZqkHp/Xsolvx02bXEYK3cornYs3x6lOVxTkATVYc6tOacXgvo8R8X7XA6U7LA
 w8qInJKubL9XRcJWgXHyfdMZaJ9/TYQ==
X-Google-Smtp-Source: AGHT+IEpEdESQLToVrgNyKpBBvLUlcDgiX7JqnyKNYwmXDWAvnub3+L5IieKKmXjR20fvDy14QGGPP71lrx19Qs5WGY=
X-Received: by 2002:a17:90b:104a:b0:2db:60b:3669 with SMTP id
 98e67ed59e1d1-2dba007c325mr3019249a91.8.1726237620232; Fri, 13 Sep 2024
 07:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240913013837.311481-1-lingshan.zhu@amd.com>
In-Reply-To: <20240913013837.311481-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Sep 2024 10:26:48 -0400
Message-ID: <CADnq5_MWQNOc8WDsnZMNVRtYY7enXYnQ-gGiKi-PgJG8JeyW6w@mail.gmail.com>
Subject: Re: [PATCH] AMDGPU: init saw registers for mmhub v1.0
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: alexander.deucher@amd.com, ray.huang@amd.com, 
 amd-gfx@lists.freedesktop.org, Du Bin <bin.du@amd.com>
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

On Thu, Sep 12, 2024 at 9:40=E2=80=AFPM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> This commits init registers in the Stand Along Walker
> for mmhub v1.0, to support ISP use cases.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Reported-and-Tested-by: Du Bin <bin.du@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       | 48 +++++++++++++++++++
>  .../include/asic_reg/mmhub/mmhub_1_0_offset.h | 23 +++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_0.c
> index e3ddd22aa172..80864898b480 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -229,6 +229,52 @@ static void mmhub_v1_0_disable_identity_aperture(str=
uct amdgpu_device *adev)
>                      0);
>  }
>
> +static void mmhub_v1_0_init_saw(struct amdgpu_device *adev)
> +{
> +       uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +       uint32_t tmp;
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32 *=
/
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_=
LO32,
> +                           lower_32_bits(pt_base >> 12));
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32 *=
/
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_=
HI32,
> +                           upper_32_bits(pt_base >> 12));
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32 =
*/
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR=
_LO32,
> +                           (u32)(adev->gmc.gart_start >> 12));
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32 =
*/
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR=
_HI32,
> +                           (u32)(adev->gmc.gart_start >> 44));
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32 */
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_L=
O32,
> +                           (u32)(adev->gmc.gart_end >> 12));
> +
> +       /* VM_9_X_REGISTER_VM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32 */
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_H=
I32,
> +                           (u32)(adev->gmc.gart_end >> 44));
> +
> +       /* Program SAW CONTEXT0 CNTL */
> +       tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL);
> +       tmp |=3D 1 << CONTEXT0_CNTL_ENABLE_OFFSET;
> +       tmp &=3D ~(3 << CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET);
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXT0_CNTL, tmp);
> +
> +       /* Disable all Contexts except Context0 */
> +       tmp =3D 0xfffe;
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CONTEXTS_DISABLE, tmp);
> +
> +       /* Program SAW CNTL4 */
> +       tmp =3D RREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4);
> +       tmp |=3D 1 << VMC_TAP_PDE_REQUEST_SNOOP_OFFSET;
> +       tmp |=3D 1 << VMC_TAP_PTE_REQUEST_SNOOP_OFFSET;
> +       WREG32_SOC15(MMHUB, 0, mmVM_L2_SAW_CNTL4, tmp);
> +}
> +
>  static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB0(0)];
> @@ -283,6 +329,8 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgp=
u_device *adev)
>                                     i * hub->ctx_addr_distance,
>                                     upper_32_bits(adev->vm_manager.max_pf=
n - 1));
>         }
> +
> +       mmhub_v1_0_init_saw(adev);

Do these exist on all mmhub v1 based chips or just some specific ones?
 I.e., is there any problem programming these for all chips that use
mmhub v1?

Alex

>  }
>
>  static void mmhub_v1_0_program_invalidation(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.=
h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
> index 2c3ce243861a..380e44230bda 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_0_offset.h
> @@ -1232,6 +1232,29 @@
>  #define mmMC_VM_MX_L1_PERFCOUNTER_HI                                    =
                               0x059d
>  #define mmMC_VM_MX_L1_PERFCOUNTER_HI_BASE_IDX                           =
                               0
>
> +// Stand Alone Walker Registers
> +#define VMC_TAP_PDE_REQUEST_SNOOP_OFFSET                                =
                               8
> +#define VMC_TAP_PTE_REQUEST_SNOOP_OFFSET                                =
                               11
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32                  =
                               0x0606
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32_BASE_IDX         =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32                  =
                               0x0607
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32_BASE_IDX         =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32                 =
                               0x0608
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_LO32_BASE_IDX        =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32                 =
                               0x0609
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_START_ADDR_HI32_BASE_IDX        =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32                   =
                               0x060a
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_LO32_BASE_IDX          =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32                   =
                               0x060b
> +#define mmVM_L2_SAW_CONTEXT0_PAGE_TABLE_END_ADDR_HI32_BASE_IDX          =
                               0
> +#define mmVM_L2_SAW_CONTEXT0_CNTL                                       =
                               0x0604
> +#define mmVM_L2_SAW_CONTEXT0_CNTL_BASE_IDX                              =
                               0
> +#define CONTEXT0_CNTL_ENABLE_OFFSET                                     =
                               0
> +#define CONTEXT0_CNTL_PAGE_TABLE_DEPTH_OFFSET                           =
                               1
> +#define mmVM_L2_SAW_CONTEXTS_DISABLE                                    =
                               0x060c
> +#define mmVM_L2_SAW_CONTEXTS_DISABLE_BASE_IDX                           =
                               0
> +#define mmVM_L2_SAW_CNTL4                                               =
                               0x0603
> +#define mmVM_L2_SAW_CNTL4_BASE_IDX                                      =
                               0
>
>  // addressBlock: mmhub_utcl2_atcl2dec
>  // base address: 0x69900
> --
> 2.43.5
>
