Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DF7CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E96AE10F1A0;
	Thu, 28 May 2026 13:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ce76aolj";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0119110F1A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:33:17 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-134a84f0aa7so432357c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975197; cv=none;
 d=google.com; s=arc-20240605;
 b=N2syPR0RTFxjTFxnCWu0JQOj4bzzdEihtXry3OQQAsZOqtCYX+Eni3V74XRShyq4QP
 f0s9PGSbDpurawAl5QRzxxkgcFOwK9eJKOEYIXsIv/6xpxiioSFRy31kex1dZdEajudo
 YatpuIs1FIgY5huVHIGCGzQ4UtttuFuhzsQ6j/bIrB+6O8uSnXBt7iOYaxhnoESesEgi
 Pm3bZ5cII2Hu89BBzJ8fDJ4vAmr5exhIzL5p+PYFwCV4+h7PNobTJGlRlYa8lrUgtlly
 uyR1Vcvt7VQeFyWXpFK5JI5ld3W+6d1PhThwJA7xe0CZpYY4w9ADirBexcDax2RISHIP
 Zm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ydqx2uHxUxL7QoRnA3Tun/ZcI9nwiEZj7253SUCVLqQ=;
 fh=HWm2afAHSC8EWbIEVyZKFUECI5UubF+rmJwSUwteqGA=;
 b=ManKkQDYZhIqFAE06uI9PnTaRFtfONn8LqKLsbE7lOpygGMHVgJn1XWYxxOocYiPe8
 4WBuhs1YCwnyPh0zELmGmXI4Pc7gZUT7GA98QZ83yWLBcentUtTYNVyiQ9+x73tl5CwZ
 y2b0PdirO2kQalSwxEXiANdX1Wd6FSIDEf3bBNkkI3xWVqxvPtaLRRiJuMzKFYRhFo7u
 kjtlpmU6NXsC5oPlYUbVkKLirIOGW165SKi6Gn8jFnKMSbfo3w2QbI0ocTHCNuKxM8Xq
 k1VozQzAnYP4TZpOeaz3SnJjJWO9GH/3QNbVVK5OSAjFqigE8OVObymdEDTuL2dtPycL
 ew+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975197; x=1780579997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ydqx2uHxUxL7QoRnA3Tun/ZcI9nwiEZj7253SUCVLqQ=;
 b=Ce76aolj/zwPnvt1ShwIyA9aDlIaDL32kKtF2wC6GL+jN21Dzi1pge3z1SMPZIS0wh
 NVQw5F+qMM3mCypk+cMfF/h0BvNTWvLqmrtti569XAT3jRBJBZd7ykmKakiCutWm1K+v
 8dcPT7Jt3o+CZq+XpqDOEj9ti9QSgeEkBhj6cvj1JbbuZPH0cdoRhsWvdZFVtRlEbbfT
 G2e4vi/iyEYqxT88lEsaEdwpCHh7tgVhfiUwsE/h0ucMvIBX3jdkcWncOdk8UY91uK2a
 5hr8nlXBNWR7USQO8BQZAkG+SMOPiedocbn47AagSKSAqGEQ64inTWIJPX9eU3IuinAZ
 I2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975197; x=1780579997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ydqx2uHxUxL7QoRnA3Tun/ZcI9nwiEZj7253SUCVLqQ=;
 b=a97Bxk2Y9uEdmo/RTmqgdbv5lJiKnedoqX9v1rr3sAmGSnIfts6F9rjHcItUocPSiy
 Gkq0OsZ3QB1y9stoGXvEbxop+eaHNYzs7U6LMiYiYoEoCWKA5HeMNQST65xsJ2BBEHrf
 P7IrHm32yLIjGm2rRo+EB97En5yMoeBdG4A45ViqPccG7+Ocw/jpc3EBcu+RlhKrqK9W
 rQFPHyq9+I9am1hSywgJqSAv5qExVvPTICMPLsvqWNPkHGY3VdExFIbbPsX4woIo03pT
 l8BiQ9NdEjHScIGv64Vuok3xf4dJqIMRmtvJrjltTs0NRuR3MkR482+tomJTGVnUOFQj
 PJfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+++p8pOQYOZ55yG7VNI8Ul/Fo4X5eY4mjE4JeRRS5iisd6TAVFDCbNxrrlkrpB6i4ccT7kcdB3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzujRbqBDTRRSqcJJOILFj3T20HS3ECNa1tORYA99i11irLUmY4
 7pzv8AOyuwLStT7AknavuKIBduT9fSiP65GAGhem0JK+F/GS1C8n3kjdS23RmxSqjNPdp/USY3R
 vUDiSflYk3ugMj7imDiy5rpEFr/D8I5VPHg==
X-Gm-Gg: Acq92OEQ/9e/BTISYufaqqZL6Q8joGlKe7et0qgruOk5mKhgAUyPHpCcSpqqAlzozwl
 VB3MUqTwCC6x8D81+giOPGtYAuHMT5K91Ftd14QJzJmbrlz+uJZpHi6eX7SeUP6iZQj3Lz+/CmN
 aPXCgHrmsTvfBrzbkJKYiycBoI6VB6vt/vJBM/W5QeB0uLm0NZRezD5kIMlP7YaBdock7wrid+V
 IF5q18NijqbTdi5qlmIL0fGhYxki8rGxHzJ3GaOsAjp+EJeZ0wvLA0ND6TTwNF03HqILuBXrVbz
 Xn5p/q95CeYmQU2x12GUT4YLlZ/4SvDWM/4vfnIxMbRysnYr3I4FlUME/vRkeueLUq8g5y+qQvv
 /xY5m
X-Received: by 2002:a05:7022:61a0:b0:135:1b3a:bffb with SMTP id
 a92af1059eb24-1377c2d5f5cmr533618c88.0.1779975197002; Thu, 28 May 2026
 06:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:33:05 -0400
X-Gm-Features: AVHnY4IdA_MYWrsglrpZQdVi49XX4c6jq5vk0wLeKbLGa6T7COqayk_LoSrt6xc
Message-ID: <CADnq5_Mxb68t1CRMdUwzQcmjTcRmYbcdowDExgYBUd0FhgFLmA@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: Add support for GC IP version 11.5.6
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 28, 2026 at 2:49=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Initialize GC IP 11_5_6
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/soc21.c            |  5 +++++
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
>  9 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 8e3b6a4050e9..5364b0540613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2097,6 +2097,7 @@ static int amdgpu_discovery_set_common_ip_blocks(st=
ruct amdgpu_device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
>                 break;
>         case IP_VERSION(12, 0, 0):
> @@ -2157,6 +2158,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struc=
t amdgpu_device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
>                 break;
>         case IP_VERSION(12, 0, 0):
> @@ -2479,6 +2481,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct=
 amdgpu_device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
>                 break;
>         case IP_VERSION(12, 0, 0):
> @@ -2690,6 +2693,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struc=
t amdgpu_device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
>                 adev->enable_mes =3D true;
>                 adev->enable_mes_kiq =3D true;
> @@ -3096,6 +3100,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 adev->family =3D AMDGPU_FAMILY_GC_11_5_0;
>                 break;
>         case IP_VERSION(12, 0, 0):
> @@ -3124,6 +3129,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 adev->flags |=3D AMD_IS_APU;
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 13bec8461cde..7bf4d1890152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -976,6 +976,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 /* Don't enable it by default yet.
>                  */
>                 if (amdgpu_tmz < 1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index fabdbbd0abb7..1941bfbcbfbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -129,6 +129,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>
>  static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> @@ -1123,6 +1127,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_d=
evice *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 adev->gfx.config.max_hw_contexts =3D 8;
>                 adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
>                 adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100;
> @@ -1606,6 +1611,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 adev->gfx.me.num_me =3D 1;
>                 adev->gfx.me.num_pipe_per_me =3D 1;
>                 adev->gfx.me.num_queue_per_pipe =3D 2;
> @@ -3078,7 +3084,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete=
(struct amdgpu_device *adev)
>                     amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 1) ||
>                     amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 2) ||
>                     amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 3) ||
> -                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 4))
> +                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 4) ||
> +                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION=
(11, 5, 6))
>                         bootload_status =3D RREG32_SOC15(GC, 0,
>                                         regRLC_RLCS_BOOTLOAD_STATUS_gc_11=
_0_1);
>                 else
> @@ -5721,6 +5728,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu=
_device *adev, bool enable)
>                 case IP_VERSION(11, 5, 2):
>                 case IP_VERSION(11, 5, 3):
>                 case IP_VERSION(11, 5, 4):
> +               case IP_VERSION(11, 5, 6):
>                         WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DEL=
AY_3_DEFAULT_GC_11_0_1);
>                         break;
>                 default:
> @@ -5760,6 +5768,7 @@ static int gfx_v11_0_set_powergating_state(struct a=
mdgpu_ip_block *ip_block,
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 if (!enable)
>                         amdgpu_gfx_off_ctrl(adev, false);
>
> @@ -5795,6 +5804,7 @@ static int gfx_v11_0_set_clockgating_state(struct a=
mdgpu_ip_block *ip_block,
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 gfx_v11_0_update_gfx_clock_gating(adev,
>                                 state =3D=3D  AMD_CG_STATE_GATE);
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 16388e3caea3..9664b7b8f0db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -604,6 +604,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_=
device *adev)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 adev->gfxhub.funcs =3D &gfxhub_v11_5_0_funcs;
>                 break;
>         default:
> @@ -778,6 +779,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>                 set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
>                 /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0.c
> index 46d25d55ebbe..f5927c3553ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -42,6 +42,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>
>  static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index a926a330700e..147ba2942690 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -58,6 +58,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>
>  static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
>  static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 93c002e511c7..963659deeaff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -833,6 +833,11 @@ static int soc21_common_early_init(struct amdgpu_ip_=
block *ip_block)
>                         AMD_PG_SUPPORT_GFX_PG;
>                 adev->external_rev_id =3D adev->rev_id + 0x1;
>                 break;
> +       case IP_VERSION(11, 5, 6):
> +               adev->cg_flags =3D 0;
> +               adev->pg_flags =3D 0;
> +               adev->external_rev_id =3D adev->rev_id + 0xd0;
> +               break;
>         default:
>                 /* FIXME: not supported yet */
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index cf7b1b038d5f..af2ae144f508 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1706,6 +1706,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, s=
truct kfd_gpu_cache_info **pc
>                 case IP_VERSION(11, 5, 2):
>                 case IP_VERSION(11, 5, 3):
>                 case IP_VERSION(11, 5, 4):
> +               case IP_VERSION(11, 5, 6):
>                         /* Cacheline size not available in IP discovery f=
or gc11.
>                          * kfd_fill_gpu_cache_info_from_gfx_config to har=
d code it
>                          */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 9e77c4a842ef..69facc5a544a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -167,6 +167,7 @@ static void kfd_device_info_set_event_interrupt_class=
(struct kfd_dev *kfd)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
> +       case IP_VERSION(11, 5, 6):
>                 kfd->device_info.event_interrupt_class =3D &event_interru=
pt_class_v11;
>                 break;
>         case IP_VERSION(12, 0, 0):
> @@ -448,6 +449,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *=
adev, bool vf)
>                          gfx_target_version =3D 110504;
>                          f2g =3D &gfx_v11_kfd2kgd;
>                          break;
> +               case IP_VERSION(11, 5, 6):
> +                       gfx_target_version =3D 110504;
> +                       f2g =3D &gfx_v11_kfd2kgd;
> +                       break;

This could be merged with the case above.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 case IP_VERSION(12, 0, 0):
>                         gfx_target_version =3D 120000;
>                         f2g =3D &gfx_v12_kfd2kgd;
> --
> 2.43.0
>
