Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14601CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 14:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29A810E4F1;
	Mon, 11 May 2026 14:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rWaGlnKH";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D777910E7B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 14:55:56 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2f16c892babso180675eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 07:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511356; cv=none;
 d=google.com; s=arc-20240605;
 b=KZ401SucGPvBY4Dj0sUOBbsTAG9s00yCWbsvEbOEA06njuSk/uZc/9wkBOFfMkeYxM
 025EWc7lseO0+/VMMT5EoUBAn1Mqj/68BV5LcsD8QalNHCN07tvzZ7DVU321C2sGZf9+
 BwdWYiL9Wr/NFghHD88iq19DsgwJNVmJeXj/Ad0W2f5XqO3Zgvdxe5DnrbM3ma1JQrMi
 drbfu/Mp9Yw0wzZ0jfGdFnp7xcnx+7/y98Ksy43+tgOSELtimhuQOVAKSTMBfMoHj7Cu
 pnAyG0i/R5Ui13DRSNMw/FY+3K9qZ9/M06/aGR04vVkeGBmaSgUusjcq9MXFq+kkICMm
 1EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HHlD5OTyHtfAYM76phsY/ZqvgweuPXTS9NKTApgHnkI=;
 fh=ElDNM5Tv8IUviZg4xNga0syPq6dgNyK0sWvFeWyjLFQ=;
 b=T1qahosDF0XEcGgj3pfs4263TdLL+Yx1WIBSXs7gDk6CGQPW6y7kmUCIMW5MRa1SrF
 rDoTOgpqTW0ame9+tkqAzBVcxsOktruf6zMZMGd3yIH7Gl0fIDqmAnYDRYnL2wL3ysg6
 5wVbPm8r1AZFpUgncDL2RIhG5nuPZy0OT1qiKizJGGdvG8K/Bj5cIWxTNWOs5QJMHI8K
 KsHAOtz79HECF39cXCBKOT85ENCVcwRLJMOFcp97kPfXb8j+7ZG/hrLYRESi3RpH+HoK
 TI7uTA6FAkt1LDxicQwCnw6XhJc64YF7F+EPAsgPyTwXwiqmHRPIbvsx3LBABucrHHZZ
 3U1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778511356; x=1779116156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHlD5OTyHtfAYM76phsY/ZqvgweuPXTS9NKTApgHnkI=;
 b=rWaGlnKHpDPNPKXBd0SzDgPzQ0/Bq6JRumwEUsHfnLEiE601IvKZDO/Oxr7aOaYEkJ
 P840HGl+h9HAAHXiUJhJe21PEghSriH8daBlSZMlIXMuGtiqis3/mxBBOzKKpm4DoI/S
 dGOh1h3up+uWqFj1w5v0XBFHlInstfZkJZPnaWZ6oZU2/+g15yV3ktBL+i2gXHk10J6Q
 P7APwFLWdOJSYWFRHO9sd2CrmVKtm7LnjLsbe2hIClLjvtiJINGUhV7sSi6xrag2Qo7/
 rLltXNVq/cmByPh0rAW3xZsx2n4bq7EYx5CNUZ2fgeBoirKyTpahRQMA6A0Pg3WvnGS4
 B9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511356; x=1779116156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHlD5OTyHtfAYM76phsY/ZqvgweuPXTS9NKTApgHnkI=;
 b=oj3SFAXXOVDvfZMiFkwtbCRF2ESeGIyKZviU8isHiMTmbUia0ZtSit9LGU2Cm7V+ZY
 kcnHzSCwqzxKBha7qi1MoMnHZb5MjpChpnDYqowy9OfNQ9dSODFtk4Jn6P9a9H97j07N
 dLyTC+SuCRveQkvGQrWFeZxuLEt42QWcwVOeUioWSfrtHX9NnOgNtbycQ8Q666jL8lfW
 2OppkqJ0oQHn+hoJ4mblOrUK/S8RA6xQ7xEfY8znZa4CGb87FxFI7aZWluq8LKFRK5Nl
 qLyOErPJrKVxz/FVDIemWLoAkt7sN46GGoWcqFymeZ07zu5wDmWmQ+Fvxo9AL5T+hun8
 +cRQ==
X-Gm-Message-State: AOJu0Yx0igxNYb9Fxb21VgEQixu/A460/exZVHxJp2MrUJndyot8/gxj
 8AWxtBnVf/VprAODuNR+9RTUef2ueU2zdCjA7KCpItEDcaINGFrbnjiuk8Tt3vdcwkpsMLSA3JZ
 Ckqcf+VbBSnp2qeD+hOFms1TOsxMA2KI=
X-Gm-Gg: Acq92OFvbi0QK50g1+f4Ta0jCoOHs0be80y4uqmwtfPDtWjGSHd7CphhdDJQNWP57pR
 A92QPieQclb2LAsc96SzwZR2BgnLHxpXimoB1Li10Eq+SQCvJDckoQusBmBUGzEQuoIUnUgtkEN
 1yt6ZmR/B8BYNP+rQ+2rqU6RsWKhdgK743tqfIxczxALuQxenWht8C8SutFzV7fAvait7DQKT4Y
 yrGaDPHfHoMir5quyKNPENu50gvnvatjYcqvgi0/z1+aDDnn7G0vi4/YT/BlldF8HZsald7AdZq
 AyOYTPZc40cpCDhMYMc2FOMuAiUcms8Teog2X5uxOaTauU3Heqz4kdFMwVPa/uEABbpe1SBF+Ua
 MCKzO
X-Received: by 2002:a05:7300:3b08:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-2f54c37e2eamr5585309eec.6.1778511355948; Mon, 11 May 2026
 07:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260509020339.262889-1-andrebueno.mac@gmail.com>
In-Reply-To: <20260509020339.262889-1-andrebueno.mac@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 May 2026 10:55:44 -0400
X-Gm-Features: AVHnY4K4GV4mA1OKBu9p19GDepiceXFJ3wxCdlXzKKTfJ9oZ1hXbKk39wjb4GTs
Message-ID: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
Subject: Re: [PATCH V1 RESEND] drm/amdgpu: deduplicate JPEG v5.0 interrupt
 routine
To: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 enzo.spinella@usp.br, dri-devel@lists.freedesktop.org
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

On Sun, May 10, 2026 at 6:14=E2=80=AFAM Andre Luiz Batista Bueno
<andrebueno.mac@gmail.com> wrote:
>
> Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical
> interrupt processing routines. To avoid code duplication,
> extract this implementation into a shared common function
> in new jpeg_v5_0_interrupt.c and .h files.
>
> Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
> Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      | 57 +----------------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      | 57 +----------------
>  .../gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c  | 64 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h  | 12 ++++
>  5 files changed, 83 insertions(+), 108 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h

This is not common to jpeg v5.  jpeg_v5_0_0.c has a different
interrupt handler, although it could probably be shared with that as
well.  I think the additional fields in the IH should be 0s so it
should work correctly, but we'd need to verify.  If you do want to
share this, I would just make the implementation in jpeg_v5_0_1.c
non-static and then just use it directly in jpeg_v5_0_2.c.

Alex

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index db66c6372199..69e5e55e1a2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -229,6 +229,7 @@ amdgpu-y +=3D \
>         jpeg_v5_0_0.o \
>         jpeg_v5_0_1.o \
>         jpeg_v5_0_2.o \
> +       jpeg_v5_0_interrupt.o \
>         jpeg_v5_3_0.o
>
>  # add VPE block
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index edecbfe66c79..6e5611921eda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -34,6 +34,8 @@
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +#include "jpeg_v5_0_interrupt.h"
> +
>  static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev);
>  static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
> @@ -759,60 +761,7 @@ static int jpeg_v5_0_1_process_interrupt(struct amdg=
pu_device *adev,
>                                          struct amdgpu_irq_src *source,
>                                          struct amdgpu_iv_entry *entry)
>  {
> -       u32 i, inst;
> -
> -       i =3D node_id_to_phys_map[entry->node_id];
> -       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
> -
> -       for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
> -               if (adev->jpeg.inst[inst].aid_id =3D=3D i)
> -                       break;
> -
> -       if (inst >=3D adev->jpeg.num_jpeg_inst) {
> -               dev_WARN_ONCE(adev->dev, 1,
> -                             "Interrupt received for unknown JPEG instan=
ce %d",
> -                             entry->node_id);
> -               return 0;
> -       }
> -
> -       switch (entry->src_id) {
> -       case VCN_5_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG1_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG2_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG3_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG4_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG5_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG6_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG7_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG8_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG9_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
> -               break;
> -       default:
> -               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> -                             entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> +       return jpeg_v5_0_process_interrupt_common(adev, entry);
>  }
>
>  static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_2.c
> index 285c459379c4..daea95907639 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -34,6 +34,8 @@
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +#include "jpeg_v5_0_interrupt.h"
> +
>  static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
>  static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
> @@ -587,60 +589,7 @@ static int jpeg_v5_0_2_process_interrupt(struct amdg=
pu_device *adev,
>                                          struct amdgpu_irq_src *source,
>                                          struct amdgpu_iv_entry *entry)
>  {
> -       u32 i, inst;
> -
> -       i =3D node_id_to_phys_map[entry->node_id];
> -       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
> -
> -       for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
> -               if (adev->jpeg.inst[inst].aid_id =3D=3D i)
> -                       break;
> -
> -       if (inst >=3D adev->jpeg.num_jpeg_inst) {
> -               dev_WARN_ONCE(adev->dev, 1,
> -                             "Interrupt received for unknown JPEG instan=
ce %d",
> -                             entry->node_id);
> -               return 0;
> -       }
> -
> -       switch (entry->src_id) {
> -       case VCN_5_0__SRCID__JPEG_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG1_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG2_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG3_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG4_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG5_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG6_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG7_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG8_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
> -               break;
> -       case VCN_5_0__SRCID__JPEG9_DECODE:
> -               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
> -               break;
> -       default:
> -               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> -                             entry->src_id, entry->src_data[0]);
> -               break;
> -       }
> -
> -       return 0;
> +       return jpeg_v5_0_process_interrupt_common(adev, entry);
>  }
>
>  static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c b/drivers/g=
pu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
> new file mode 100644
> index 000000000000..a76ee6586b63
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +#include "amdgpu.h"
> +#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
> +#include "jpeg_v5_0_interrupt.h"
> +
> +int jpeg_v5_0_process_interrupt_common(struct amdgpu_device *adev,
> +                                      struct amdgpu_iv_entry *entry)
> +{
> +       u32 i, inst;
> +
> +       i =3D node_id_to_phys_map[entry->node_id];
> +       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
> +
> +       for (inst =3D 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
> +               if (adev->jpeg.inst[inst].aid_id =3D=3D i)
> +                       break;
> +
> +       if (inst >=3D adev->jpeg.num_jpeg_inst) {
> +               dev_WARN_ONCE(adev->dev, 1,
> +                             "Interrupt received for unknown JPEG instan=
ce %d",
> +                             entry->node_id);
> +               return 0;
> +       }
> +
> +       switch (entry->src_id) {
> +       case VCN_5_0__SRCID__JPEG_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG1_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG2_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG3_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG4_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG5_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG6_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG7_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG8_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
> +               break;
> +       case VCN_5_0__SRCID__JPEG9_DECODE:
> +               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
> +               break;
> +       default:
> +               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> +                             entry->src_id, entry->src_data[0]);
> +               break;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h b/drivers/g=
pu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h
> new file mode 100644
> index 000000000000..046bcb4a3906
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +
> +#ifndef __JPEG_V5_0_INTERRUPT_H__
> +#define __JPEG_V5_0_INTERRUPT_H__
> +
> +struct amdgpu_device;
> +struct amdgpu_iv_entry;
> +
> +int jpeg_v5_0_process_interrupt_common(struct amdgpu_device *adev,
> +                                      struct amdgpu_iv_entry *entry);
> +
> +#endif /* __JPEG_V5_0_INTERRUPT_H__ */
> --
> 2.43.0
>
