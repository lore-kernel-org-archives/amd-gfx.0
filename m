Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D2AECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A446A10E6C0;
	Mon,  9 Sep 2024 21:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIlTzivc";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D836510E03A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:04:42 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-7d21b0c8422so691550a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725915882; x=1726520682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1azgYq4oKnTDsJ2uWQ4QdGzYqEUH33wwWCjytPfNpis=;
 b=YIlTzivcgpGKaLJsPQ9vxW2ROOwGMEU2Jwc5jJd8R4TOnvmnU+RPXiv2oWD00BMLq0
 KtQg5MDYJzMUQb6eAc9/uqtswx2qz8EeHmHPD3Ja56sZsp3/pV5Rh0RcXaAtxTm0N+F+
 Rix4t6CYc96VsoypjYS8MZ9TxOcatTyBRB72iryPgNdTntMAixP+qvsdxtM3vufvm8CI
 2jXRKt5kizJK7qmvZpcInMCV1J973NHDHYM6XlO5utBop32y4Ye4esu9Y+6qqAWHr1SX
 1wdYn3r1OiBiWlH9lLYr5Xzyyp2tVOaRIqVcqj1z74+ll5y+i61EdlA2LhzAX2X+qz1g
 3fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725915882; x=1726520682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1azgYq4oKnTDsJ2uWQ4QdGzYqEUH33wwWCjytPfNpis=;
 b=EhWIiD/2ou/5gnJAM2fOElKbM9r1SytWWJahyCGR5U0sNTZZw8I/vHWGjLZ0mgqqc1
 yRetETkS5x/TalWuQttulSWu9Z2ypLuQ3O6Yc6WiITi+/773ePpXWiVL7//2lZFCykq/
 RvKJ7usJVVK1gBnUB3imuisCV9ZAKM8MNQxwuXVq/PIgw65ZRuf08agoxNzI5s6YypUR
 f02d0c29DQbT0nlXT9ctVjjvERVmLgZaC69wvtNkc+AROjM1MGmewaehKVNbWTYYLPSi
 L0fhWpxI5L2WRhEhOysx2xQGCl26cWt9NK6HJgiG9ygmE6fCEm9mX+swaaOQrGDrHD+d
 udhQ==
X-Gm-Message-State: AOJu0YwbNPsczdw2P/q3UuCu+jRs1L2We69j9UxG/iaY524jIeVQb2wK
 DXDYQQgv30GnelJ0S0IRjp3guaWyfOPea1LayEz94MCiamjkgg2gHoU2F1usM9JTKpgppoZGgDi
 +1qXh/eToo892pkxEvH3ON+2teVs=
X-Google-Smtp-Source: AGHT+IH2DLFZI6wTS35uaYjEvqL+cD7O1F4MRF03W7WooopbWxn/DnqWFt2aOMLEde6AqnFWrLjGi9NFWF5rn1XSqpA=
X-Received: by 2002:a17:902:f0cb:b0:205:60f5:4c0 with SMTP id
 d9443c01a7336-206f0669d0emr62275865ad.9.1725915881997; Mon, 09 Sep 2024
 14:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-3-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:04:30 -0400
Message-ID: <CADnq5_M4j+9wSY+F3CgFMujaTtHFR2xyga9ry65nnV=J771JLQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

With the error Feifei mentioned fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Sep 2, 2024 at 4:13=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Drop pending_reset flag in gmc block. Instead use init level to
> determine which type of init is preferred - in this case MINIMAL.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 33 ++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  6 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
>  6 files changed, 13 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4fb09c4fbf22..db5046e8b10d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1691,7 +1691,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *=
adev)
>         }
>
>         /* Don't post if we need to reset whole hive on init */
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
>                 return false;
>
>         if (adev->has_hw_reset) {
> @@ -2985,7 +2985,7 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>                 amdgpu_ttm_set_buffer_funcs_status(adev, true);
>
>         /* Don't init kfd if whole hive need to be reset during init */
> -       if (!adev->gmc.xgmi.pending_reset) {
> +       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) {
>                 kgd2kfd_init_zone_device(adev);
>                 amdgpu_amdkfd_device_init(adev);
>         }
> @@ -3499,14 +3499,9 @@ static int amdgpu_device_ip_suspend_phase2(struct =
amdgpu_device *adev)
>                 }
>
>                 /* skip unnecessary suspend if we do not initialize them =
yet */
> -               if (adev->gmc.xgmi.pending_reset &&
> -                   !(adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_GMC ||
> -                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_SMC ||
> -                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_COMMON ||
> -                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOC=
K_TYPE_IH)) {
> -                       adev->ip_blocks[i].status.hw =3D false;
> +               if (!amdgpu_ip_member_of_hwini(
> +                           adev, adev->ip_blocks[i].version->type))
>                         continue;
> -               }
>
>                 /* skip suspend of gfx/mes and psp for S0ix
>                  * gfx is in gfxoff state, so on resume it will exit gfxo=
ff just
> @@ -4320,20 +4315,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev=
)) {
>                 if (adev->gmc.xgmi.num_physical_nodes) {
>                         dev_info(adev->dev, "Pending hive reset.\n");
> -                       adev->gmc.xgmi.pending_reset =3D true;
> -                       /* Only need to init necessary block for SMU to h=
andle the reset */
> -                       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> -                               if (!adev->ip_blocks[i].status.valid)
> -                                       continue;
> -                               if (!(adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_GMC ||
> -                                     adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_COMMON ||
> -                                     adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_IH ||
> -                                     adev->ip_blocks[i].version->type =
=3D=3D AMD_IP_BLOCK_TYPE_SMC)) {
> -                                       DRM_DEBUG("IP %s disabled for hw_=
init.\n",
> -                                               adev->ip_blocks[i].versio=
n->funcs->name);
> -                                       adev->ip_blocks[i].status.hw =3D =
true;
> -                               }
> -                       }
> +                       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_MIN=
IMAL);
>                 } else if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP=
_VERSION(13, 0, 10) &&
>                                    !amdgpu_device_has_display_hardware(ad=
ev)) {
>                                         r =3D psp_gpu_reset(adev);
> @@ -4441,7 +4423,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* enable clockgating, etc. after ib tests, etc. since some block=
s require
>          * explicit gating rather than handling it automatically.
>          */
> -       if (!adev->gmc.xgmi.pending_reset) {
> +       if (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) {
>                 r =3D amdgpu_device_ip_late_init(adev);
>                 if (r) {
>                         dev_err(adev->dev, "amdgpu_device_ip_late_init fa=
iled\n");
> @@ -4518,7 +4500,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (px)
>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_p=
m_domain);
>
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wo=
rk,
>                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
>
> @@ -5490,7 +5472,6 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>                 list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
>                         /* For XGMI run all resets in parallel to speed u=
p the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                               tmp_adev->gmc.xgmi.pending_reset =3D fals=
e;
>                                 if (!queue_work(system_unbound_wq, &tmp_a=
dev->xgmi_reset_work))
>                                         r =3D -EALREADY;
>                         } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 82bde5132dc6..3dece2e69608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2495,7 +2495,6 @@ static void amdgpu_drv_delayed_reset_work_handler(s=
truct work_struct *work)
>         for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
>                 adev =3D mgpu_info.gpu_ins[i].adev;
>                 flush_work(&adev->xgmi_reset_work);
> -               adev->gmc.xgmi.pending_reset =3D false;
>         }
>
>         /* reset function will rebuild the xgmi hive info , clear it now =
*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 4d951a1baefa..33b2adffd58b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -182,7 +182,6 @@ struct amdgpu_xgmi {
>         bool supported;
>         struct ras_common_if *ras_if;
>         bool connected_to_cpu;
> -       bool pending_reset;
>         struct amdgpu_xgmi_ras *ras;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 61a2f386d9fb..2076f157cb6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3185,7 +3185,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *=
adev)
>          * when the GPU is pending on XGMI reset during probe time
>          * (Mostly after second bus reset), skip it now
>          */
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
>                 return 0;
>         ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
>         /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 7de449fae1e3..a7a892512cb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -860,7 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>         if (!adev->gmc.xgmi.supported)
>                 return 0;
>
> -       if (!adev->gmc.xgmi.pending_reset &&
> +       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
>             amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 ret =3D psp_xgmi_initialize(&adev->psp, false, true);
>                 if (ret) {
> @@ -907,7 +907,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>
>         task_barrier_add_task(&hive->tb);
>
> -       if (!adev->gmc.xgmi.pending_reset &&
> +       if ((adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL) &&
>             amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgm=
i.head) {
>                         /* update node list for other device in the hive =
*/
> @@ -985,7 +985,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev=
)
>                 }
>         }
>
> -       if (!ret && !adev->gmc.xgmi.pending_reset)
> +       if (!ret && (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL=
))
>                 ret =3D amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>
>  exit_unlock:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 16fcd9dcd202..7225f63c26b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1616,7 +1616,8 @@ int smu_v11_0_baco_set_state(struct smu_context *sm=
u, enum smu_baco_state state)
>                         break;
>                 default:
>                         if (!ras || !adev->ras_enabled ||
> -                           adev->gmc.xgmi.pending_reset) {
> +                           (adev->init_lvl->level !=3D
> +                            AMDGPU_INIT_LEVEL_MINIMAL)) {
>                                 if (amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D
>                                     IP_VERSION(11, 0, 2)) {
>                                         data =3D RREG32_SOC15(THM, 0, mmT=
HM_BACO_CNTL_ARCT);
> --
> 2.25.1
>
