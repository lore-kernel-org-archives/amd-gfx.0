Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0F5CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DAB10EB21;
	Fri, 24 Oct 2025 16:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHbidw+5";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02DA10EB21
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:59:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-27eca7297a7so3006775ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761325185; x=1761929985; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p4halj2McpQ4x9gJq6NZA+O8IH4RDJqGLfe1u1h3V4E=;
 b=dHbidw+5a+aqdIRHDWSWA/yvmsGpoMHQ+GtlS+z8BBs2/5sqgMOv0Rim4lr2J1IZur
 Qpd0Op04d5+O9dMNGK36iHkx0dmIRt6NpAgWw6wQwzVy+I+w3QO8Tue02sSh/tDZd/iu
 5rk0CNhQwuxH/1ryPxYYjG7C1k2VRSB0V/N0PWEh1cwsc5jP6UKVk3XoxK31BWqGI9ZN
 yGn8Cr3Avebdn/yACzXCHv30Aiq1UTBttvzaW2+MnhJpHnf4vOsR8vJBdPYKnwAhLz/l
 yV1DlP/gdSVgDu2FrQ/KPPjHiSpGMiZ7OkCvx2zNcXYG5pptT5pmOG5InPJAayqYElU0
 Z75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325185; x=1761929985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p4halj2McpQ4x9gJq6NZA+O8IH4RDJqGLfe1u1h3V4E=;
 b=NN+mslzVG3SV6cFQoRJfzwJXd1RUgF+BoV00nJI/jdyIH11IKqPd+cGQxLkGpvIN8N
 7mHndm/eBKvy/QdgbfllNIzXDYR5f1PFl2+X2mysh0vYoaGE0TcTSuBUDkkflKDpc/SQ
 x/thgkv+5lJluD1hwPUwi2yMwtqz4bIXr8P4zYO65WxdlfpjvDhTkk4wSrj8Siy0cCmd
 ilJZ+QfSK9gqlTt6NTYk6I6/13GnCsux+Hw8IDXh/omKPcIdpgV4fMUxyY0P/TBGMMhC
 8RXkeFB2KCtG11dBFxauCmYvYm2fIpLjUpNQsOQwaqSf6uaG4NYVaUZcj2VE3kCv1ZPb
 uO0w==
X-Gm-Message-State: AOJu0Yy6LNgrqXp4yppIfCYXfpLCPD/6QXajuF/D+I0D2pyNWYkY7Tcp
 okqjvsntlBr5RrW/fz2zyJ6/6fve9GOzuGZsinGvTWdMjfoAx7DNsiIHmZQx1d9XtcpkXAnny3C
 SKNdv73yfqHK+l3WQh9XBWfvSOu60pL8=
X-Gm-Gg: ASbGncvuaQRzymHzEmbeRFtqgqboZoKWBX/JnLuvHM+zy0Xsd6R0ItpWyDYpnepGgKO
 ymfvBb22M50N18tDv53QGw3600u406bl3UKcYx9wZb0+mFgLYCjX+Ab+XJfXEGHB6dE/yoLLak9
 TTTtpXqzznolRkOYuC79f8Vr9w2J/BOF2y5sGaXdWufbqVpT9/BzVceySWwVbsesa3nNivnieRK
 lqio3HwdE1hV1FG6IT/Y8WmdVgr9RkJ5hCRcP49jS2RaJaJAGDscrr22+9lUUGxbVc9cyE=
X-Google-Smtp-Source: AGHT+IGY0Oy8pTsE8bdHe/jFYhd4bjwQkZh+g2Z4vmSioPXxLRgywc0I1Ymh2bmnNrnlSAVSTDaNrUdqQ/Do9+1lI+k=
X-Received: by 2002:a17:902:dace:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-292d3fbc72cmr117357085ad.6.1761325185063; Fri, 24 Oct 2025
 09:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251024161216.345691-1-mario.limonciello@amd.com>
 <20251024161216.345691-2-mario.limonciello@amd.com>
In-Reply-To: <20251024161216.345691-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Oct 2025 12:59:31 -0400
X-Gm-Features: AS18NWCi4rBJQAsynaUGtOdG05iH5HMtC7a93K8D3gA-bm7sgcTMx2c0j4UrZss
Message-ID: <CADnq5_PCK1ttQki=9aGCpYSKinfy36C_s1f10p7wT-9rwc63ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Move Van Gogh specific suspend code into
 common `set_mp1_state`
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Robert Beckett <bob.beckett@collabora.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: multipart/mixed; boundary="000000000000fe1f1e0641ea791a"
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

--000000000000fe1f1e0641ea791a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:21=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> An `.notify_rlc_state` callback and wrappers for it were introduced
> to support notifying the PMFW that the system is about to suspend.
>
> There are already callbacks for `set_mp1_state` which get called at
> suspend though from `amdgpu_device_ip_suspend_phase2`.

This won't work.  PMFW needs to be notified that RLC is being turned
off before the driver turns it off.  I think the call in
amdgpu_device_suspend() is superfluous (but someone should check S3),
but the important one is in smu_disable_dpms() since that is called
right before we stop rlc.  I think something like the attached patches
should do the trick.

Alex

>
> [How]
> Tear out all the notify_rlc_state callbacks and instead move the
> Van Gogh specific code to a `set_mp1_state` callback.
>
> Cc: Robert Beckett <bob.beckett@collabora.com>
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ----
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 -
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 18 ------------------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ----------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 -----
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 ++++++++++++++++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
>  8 files changed, 18 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3ffb9bb1ec0b..4dbdcb7b11e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5281,10 +5281,6 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool notify_clients)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_release_full_gpu(adev, false);
>
> -       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
> -       if (r)
> -               return r;
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index 87814c2b526e..48846a3e4b7b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -523,7 +523,6 @@ struct amd_pm_funcs {
>                                    struct dpm_clocks *clock_table);
>         int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t =
*size);
>         void (*pm_compute_clocks)(void *handle);
> -       int (*notify_rlc_state)(void *handle, bool en);
>  };
>
>  struct metrics_table_header {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 5d08dc3b7110..5c4d0eb198c4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *a=
dev,
>         return ret;
>  }
>
> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
> -{
> -       int ret =3D 0;
> -       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> -
> -       if (pp_funcs && pp_funcs->notify_rlc_state) {
> -               mutex_lock(&adev->pm.mutex);
> -
> -               ret =3D pp_funcs->notify_rlc_state(
> -                               adev->powerplay.pp_handle,
> -                               en);
> -
> -               mutex_unlock(&adev->pm.mutex);
> -       }
> -
> -       return ret;
> -}
> -
>  int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>  {
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index 3bce74f8bb0a..c7ea29385682 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev=
);
>  int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>                              enum pp_mp1_state mp1_state);
>
> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
> -
>  int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
>
>  int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 4317da6f7c38..10d42267085b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *sm=
u)
>                 }
>         }
>
> -       /* Notify SMU RLC is going to be off, stop RLC and SMU interactio=
n.
> -        * otherwise SMU will hang while interacting with RLC if RLC is h=
alted
> -        * this is a WA for Vangogh asic which fix the SMU hang issue.
> -        */
> -       ret =3D smu_notify_rlc_state(smu, false);
> -       if (ret) {
> -               dev_err(adev->dev, "Fail to notify rlc status!\n");
> -               return ret;
> -       }
> -
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2) =
&&
>             !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
>             !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index c48028abc8c4..361e09f20ead 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1496,11 +1496,6 @@ struct pptable_funcs {
>          */
>         int (*set_mall_enable)(struct smu_context *smu);
>
> -       /**
> -        * @notify_rlc_state: Notify RLC power state to SMU.
> -        */
> -       int (*notify_rlc_state)(struct smu_context *smu, bool en);
> -
>         /**
>          * @is_asic_wbrf_supported: check whether PMFW supports the wbrf =
feature
>          */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 53579208cffb..3dc1919b8c64 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2208,6 +2208,23 @@ static int vangogh_notify_rlc_state(struct smu_con=
text *smu, bool en)
>         return ret;
>  }
>
> +static int vangogh_set_mp1_state(struct smu_context *smu,
> +                                enum pp_mp1_state mp1_state)
> +{
> +       int ret;
> +
> +       switch (mp1_state) {
> +       case PP_MP1_STATE_UNLOAD:
> +               ret =3D vangogh_notify_rlc_state(smu, false);
> +               break;
> +       default:
> +               /* Ignore others */
> +               ret =3D 0;
> +       }
> +
> +       return ret;
> +}
> +
>  static int vangogh_post_smu_init(struct smu_context *smu)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
> @@ -2524,7 +2541,7 @@ static const struct pptable_funcs vangogh_ppt_funcs=
 =3D {
>         .print_clk_levels =3D vangogh_common_print_clk_levels,
>         .set_default_dpm_table =3D vangogh_set_default_dpm_tables,
>         .set_fine_grain_gfx_freq_parameters =3D vangogh_set_fine_grain_gf=
x_freq_parameters,
> -       .notify_rlc_state =3D vangogh_notify_rlc_state,
> +       .set_mp1_state =3D vangogh_set_mp1_state,
>         .feature_is_enabled =3D smu_cmn_feature_is_enabled,
>         .set_power_profile_mode =3D vangogh_set_power_profile_mode,
>         .get_power_profile_mode =3D vangogh_get_power_profile_mode,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/dr=
m/amd/pm/swsmu/smu_internal.h
> index c09ecf1a68a0..b9976313e741 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -96,7 +96,6 @@
>  #define smu_get_default_config_table_settings(smu, config_table)       s=
mu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_ta=
ble)
>  #define smu_set_config_table(smu, config_table)                         =
       smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>  #define smu_init_pptable_microcode(smu)                                 =
       smu_ppt_funcs(init_pptable_microcode, 0, smu)
> -#define smu_notify_rlc_state(smu, en)                                  s=
mu_ppt_funcs(notify_rlc_state, 0, smu, en)
>  #define smu_is_asic_wbrf_supported(smu)                        smu_ppt_f=
uncs(is_asic_wbrf_supported, false, smu)
>  #define smu_enable_uclk_shadow(smu, enable)            smu_ppt_funcs(ena=
ble_uclk_shadow, 0, smu, enable)
>  #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)            s=
mu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
> --
> 2.49.0
>

--000000000000fe1f1e0641ea791a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-smu-Handle-S0ix-for-vangogh.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-smu-Handle-S0ix-for-vangogh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mh53i9hp0>
X-Attachment-Id: f_mh53i9hp0

RnJvbSBjM2Y5NzY5YmU2NTU3NzUxYjM1NjMyYTZkYzdlYTUzYmYzMDNiZmQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMjQgT2N0IDIwMjUgMTI6NTQ6MjUgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdS9zbXU6IEhhbmRsZSBTMGl4IGZvciB2YW5nb2doCgpGaXggdGhlIGZs
b3dzIGZvciBTMGl4LiAgVGhlcmUgaXMgbm8gbmVlZCB0byBzdG9wCnJsYyBvciByZWludGlhbGl6
ZSBQTUZXIGluIFMwaXguCgpDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9k
cm0vYW1kLy0vaXNzdWVzLzQ2NTkKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1k
Z3B1X3NtdS5jICAgICAgICB8IDYgKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTExL3ZhbmdvZ2hfcHB0LmMgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9z
bXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCmluZGV4IDEw
ZDQyMjY3MDg1YjAuLjViZWUwMmYwYmE4NjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvYW1kZ3B1X3NtdS5jCkBAIC0yMDU0LDYgKzIwNTQsMTIgQEAgc3RhdGljIGludCBzbXVfZGlz
YWJsZV9kcG1zKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQogCSAgICBzbXUtPmlzX2FwdSAmJiAo
YW1kZ3B1X2luX3Jlc2V0KGFkZXYpIHx8IGFkZXYtPmluX3MwaXgpKQogCQlyZXR1cm4gMDsKIAor
CS8qIHZhbmdvZ2ggczBpeCAqLworCWlmICgoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgTVAxX0hX
SVAsIDApID09IElQX1ZFUlNJT04oMTEsIDUsIDApIHx8CisJICAgICBhbWRncHVfaXBfdmVyc2lv
bihhZGV2LCBNUDFfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTigxMSwgNSwgMikpICYmCisJICAgIGFk
ZXYtPmluX3MwaXgpCisJCXJldHVybiAwOworCiAJLyoKIAkgKiBGb3IgZ3B1IHJlc2V0LCBydW5w
bSBhbmQgaGliZXJuYXRpb24gdGhyb3VnaCBCQUNPLAogCSAqIEJBQ08gZmVhdHVyZSBoYXMgdG8g
YmUga2VwdCBlbmFibGVkLgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMS92YW5nb2doX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
MS92YW5nb2doX3BwdC5jCmluZGV4IDUzNTc5MjA4Y2ZmYjQuLjk2MjZkYTJkYmE1ODQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMKQEAg
LTIyMTksNiArMjIxOSw5IEBAIHN0YXRpYyBpbnQgdmFuZ29naF9wb3N0X3NtdV9pbml0KHN0cnVj
dCBzbXVfY29udGV4dCAqc211KQogCXVpbnQzMl90IHRvdGFsX2N1ID0gYWRldi0+Z2Z4LmNvbmZp
Zy5tYXhfY3VfcGVyX3NoICoKIAkJYWRldi0+Z2Z4LmNvbmZpZy5tYXhfc2hfcGVyX3NlICogYWRl
di0+Z2Z4LmNvbmZpZy5tYXhfc2hhZGVyX2VuZ2luZXM7CiAKKwlpZiAoYWRldi0+aW5fczBpeCkK
KwkJcmV0dXJuIDA7CisKIAkvKiBhbGxvdyBtZXNzYWdlIHdpbGwgYmUgc2VudCBhZnRlciBlbmFi
bGUgbWVzc2FnZSBvbiBWYW5nb2doKi8KIAlpZiAoc211X2Ntbl9mZWF0dXJlX2lzX2VuYWJsZWQo
c211LCBTTVVfRkVBVFVSRV9EUE1fR0ZYQ0xLX0JJVCkgJiYKIAkJCShhZGV2LT5wZ19mbGFncyAm
IEFNRF9QR19TVVBQT1JUX0dGWF9QRykpIHsKLS0gCjIuNTEuMAoK
--000000000000fe1f1e0641ea791a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-move-PMFW-rlc-notifier-to-where-it-s-requ.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-move-PMFW-rlc-notifier-to-where-it-s-requ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mh53i9hu1>
X-Attachment-Id: f_mh53i9hu1

RnJvbSBjYzEwYTUzMTkzZWU2ZjAwZDc5NWFiZDhiZTM3YzgwZjkwYjNlMzA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMjQgT2N0IDIwMjUgMTI6MzY6MTUgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdTogbW92ZSBQTUZXIHJsYyBub3RpZmllciB0byB3aGVyZSBpdCdzIHJl
cXVpcmVkCgpGb3IgUzMgb24gdmFuZ29naCwgUE1GVyBuZWVkcyB0byBiZSBub3RpZmllZCBiZWZv
cmUgdGhlCmRyaXZlciBwb3dlcnMgZG93biBSTEMuICBNb3ZlIHRoaXMgbm90aWZpY2F0aW9uIHRv
CnRoZSBybGMgc3RvcCBmdW5jdGlvbiBzbyBpdCB3aWxsIGFsd2F5cyBnZXQgY2FsbGVkIGJmb3Jl
CnN0b3BwaW5nIHRoZSBSTEMuIFRoZSBjYWxsIGluIGFtZGdwdV9kZXZpY2Vfc3VzcGVuZCgpCnNl
ZW1zIHRvIGJlIHN1cGVyZmx1b3VzIHNvIHJlbW92ZSB0aGF0IGFzIHdlbGwuCgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgIDQgLS0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgICAgIHwgMTIgKysrKysrKysrKystCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyAgfCAxMCAtLS0tLS0tLS0tCiAz
IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA1MDUzYzVmNDc1YmE5
Li43OGMwZmMzYTUwYWU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCkBAIC01MjgzLDEwICs1MjgzLDYgQEAgaW50IGFtZGdwdV9kZXZpY2Vfc3VzcGVuZChz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIG5vdGlmeV9jbGllbnRzKQogCWlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpCiAJCWFtZGdwdV92aXJ0X3JlbGVhc2VfZnVsbF9ncHUoYWRldiwgZmFs
c2UpOwogCi0JciA9IGFtZGdwdV9kcG1fbm90aWZ5X3JsY19zdGF0ZShhZGV2LCBmYWxzZSk7Ci0J
aWYgKHIpCi0JCXJldHVybiByOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggMzliOGFkZjIzYTlmYS4uZDY0NTc5ZjVmYjFmOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTU0NzAsOCArNTQ3MCwxOCBA
QCBzdGF0aWMgaW50IGdmeF92MTBfMF9pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAogc3RhdGljIHZvaWQgZ2Z4X3YxMF8wX3JsY19zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQogewotCXUzMiB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIDAsIG1tUkxDX0NOVEwpOwor
CXUzMiB0bXA7CisJaW50IHI7CisKKwkvKiBOb3RpZnkgU01VIFJMQyBpcyBnb2luZyB0byBiZSBv
ZmYsIHN0b3AgUkxDIGFuZCBTTVUgaW50ZXJhY3Rpb24uCisJICogb3RoZXJ3aXNlIFNNVSB3aWxs
IGhhbmcgd2hpbGUgaW50ZXJhY3Rpbmcgd2l0aCBSTEMgaWYgUkxDIGlzIGhhbHRlZAorCSAqIHRo
aXMgaXMgYSBXQSBmb3IgVmFuZ29naCBhc2ljIHdoaWNoIGZpeCB0aGUgU01VIGhhbmcgaXNzdWUu
CisJICovCisJciA9IGFtZGdwdV9kcG1fbm90aWZ5X3JsY19zdGF0ZShhZGV2LCBmYWxzZSk7CisJ
aWYgKHIpCisJCWRldl9pbmZvKGFkZXYtPmRldiwgImZhaWxlZCB0byBub3RpZnkgUE1GVyBvZiBS
TEMgcG93ZXJkb3duXG4iKTsKIAorCXRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1STENfQ05U
TCk7CiAJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIFJMQ19DTlRMLCBSTENfRU5BQkxFX0YzMiwg
MCk7CiAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbVJMQ19DTlRMLCB0bXApOwogfQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYwppbmRleCA0MzE3ZGE2ZjdjMzg5Li4xMGQ0
MjI2NzA4NWIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdw
dV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYwpA
QCAtMjA3MiwxNiArMjA3Miw2IEBAIHN0YXRpYyBpbnQgc211X2Rpc2FibGVfZHBtcyhzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSkKIAkJfQogCX0KIAotCS8qIE5vdGlmeSBTTVUgUkxDIGlzIGdvaW5n
IHRvIGJlIG9mZiwgc3RvcCBSTEMgYW5kIFNNVSBpbnRlcmFjdGlvbi4KLQkgKiBvdGhlcndpc2Ug
U01VIHdpbGwgaGFuZyB3aGlsZSBpbnRlcmFjdGluZyB3aXRoIFJMQyBpZiBSTEMgaXMgaGFsdGVk
Ci0JICogdGhpcyBpcyBhIFdBIGZvciBWYW5nb2doIGFzaWMgd2hpY2ggZml4IHRoZSBTTVUgaGFu
ZyBpc3N1ZS4KLQkgKi8KLQlyZXQgPSBzbXVfbm90aWZ5X3JsY19zdGF0ZShzbXUsIGZhbHNlKTsK
LQlpZiAocmV0KSB7Ci0JCWRldl9lcnIoYWRldi0+ZGV2LCAiRmFpbCB0byBub3RpZnkgcmxjIHN0
YXR1cyFcbiIpOwotCQlyZXR1cm4gcmV0OwotCX0KLQogCWlmIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBHQ19IV0lQLCAwKSA+PSBJUF9WRVJTSU9OKDksIDQsIDIpICYmCiAJICAgICEoKGFkZXYt
PmZsYWdzICYgQU1EX0lTX0FQVSkgJiYgYWRldi0+Z2Z4LmltdS5mdW5jcykgJiYKIAkgICAgIWFt
ZGdwdV9zcmlvdl92ZihhZGV2KSAmJiBhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKQotLSAKMi41
MS4wCgo=
--000000000000fe1f1e0641ea791a--
