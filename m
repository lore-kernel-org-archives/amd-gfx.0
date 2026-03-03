Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE5EDA68A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 15:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2B410E835;
	Tue,  3 Mar 2026 15:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJER8m3N";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E0010E835
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 15:23:15 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2be14f5827aso87017eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 07:23:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772551395; cv=none;
 d=google.com; s=arc-20240605;
 b=bC38zmRvBbbML96NbnvckyVM3mVgrnG46qddw5D6NyasVdwDupFDo4uq9y0/EFbPXj
 Bpy8jkRQdwuFH89Y9rtZP9FUVEI6kylKQ1CBYKSzIcvIAkK3+Py3IUzTHZkMYIURYJJs
 i5r3TKIyFEx6fdkO3auqPviWRqqWji85fjWhjTrtuO/wJrvvNW2ZEOBBZbE7YWZapVxw
 MlEzHXPYY+wgr9k6PM5snYUsbdC1RvQAtRYO/WJKdQu622HXlovRxwnEST2j8uRL9BDF
 zvYWMKWW4Q4OCBf3rAMM+2qCsWF5IA0BcP6QqBf6JrIdl7ycRkahLOY2w3en/G3rF1dy
 Velg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=opnGNP4BsvYB6gWVClj1hcid2Inu56hwSl+NbBzcXds=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=SmvLfL/udAsAYvhk4z0AxG8PpNIFb0TDvOyfyOj9FRMGqrsG3Cix8BlWOsuK00KQao
 m/i1FXaJYdVHZZb/pKDEH8Z9f/hf33JLXjI1q62IHGXd0QCC0/u9SU859wa0T4DvucHI
 cbieRURC5I3Ha7kB1/s+ggBZthpMS+SgLhBvyx5c2z/mYOKO//bvQ3Hk3D6Kdijzwkqj
 cMp9wY8IEagTI8BSHrVAb4kTqhBICcb4Yj+uEa2Thut6+gyTEn/roiDUgzESsCC4pMXM
 Tu+WhIZj/LFEetsyB0YZehnoKKWRCVTWhWEzRYOig8yq3v3ycSdK1Phz0b8qCJnmMGf3
 BKoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772551395; x=1773156195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opnGNP4BsvYB6gWVClj1hcid2Inu56hwSl+NbBzcXds=;
 b=hJER8m3N5CxCuQcv6PPjpMjo0KljBiZz0TzMSD3A/XNu5N8cyhc/sIrAJo4Gp5EGZl
 rmAzSluGUrZpUQJSDfcAnoflsMRbZPv6P+jCGinEMmqRXndDc9y6pfO9+AHInE6EaWZ2
 N4RPc60XSy0hHxhyNMKeIFBeR47EKSPHaFWgMRNs62OUG+9UWmRAtJ7epHNuLSEG/pqK
 0V6/pzGP3jNNxbWQ97dFXFywXVraMSS13S0C3vflBhp6IfazpBx69seUav9dfWLhygry
 69PG/2slh8gM9KDr1J/d3wsTKScl+0vtBrZb/oyOsL67B7C59mTRH6KUq3ZY3SLVseLg
 oKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772551395; x=1773156195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=opnGNP4BsvYB6gWVClj1hcid2Inu56hwSl+NbBzcXds=;
 b=S2fVsA8FFiJglrAXogYtgd5v4vP8wNRvOWdr3Kh391tQoKScRbIXkaQAe8UHRkA2xZ
 zhXTu4+2jrAtHHoigpOYlqRMw7TTz/qmnYl5b5gAdVXISFEN2SF7hlUfZZm6zRTqDW8x
 ddsLI2frLh0g2kZ613bn7vVo4Wsg2StPPu4RAUgQ1+tghbtrZ2dmAX5ZgxepMV73I+el
 w8iaWMcx3C282wdDO2wxQ7qTN5T7ovsM75bGQb8QKbu8ba3FiZCnzeXg7fOUnTx0WKwk
 nLn1IiQQwHsQCBAAJPbzj5yRXbj9oIFqIZoBj7CLCNMiJbWhEKdsy8r0cwpYKLDpERyL
 FaBg==
X-Gm-Message-State: AOJu0Yzsf63btaEqvpEQZrqPsTMK0Djoi4L6AXW/qkiVmOaF+lqzUBek
 lPw9IKJfHBbSwJHAGNS0DY/wNPUn041kdcn89JbZm1n4p4A02/parYO31KpgaOapHbGBpDz3XqR
 aOCwYwqVCYnkg7by5a7tZA/I0wTjK8wOtMQ==
X-Gm-Gg: ATEYQzxwr5j+k6NjvmqElH9VTmN2xyJkvzq0Xsm7UdswcQxWvC3ZMOzi/V4bplA+wRN
 hYAobFHF4hd5J6cre+662sDEcfkTaRqT+vq6g3SWbrjLECSrACWp0vFJ9uQ8IIjOzSWGkBCJkFJ
 tHrmkmTMdg945p45WkrT5+HxdhN3QVyuoGfF2xUprIyd9KiAFHxAKYn1RjZs1DFotxzAS8GX6fH
 vKxj+LbzPwtwDZhLDoV/FTbVZ9edObK5uX272SjHZ+wmEDhMKqluNth0+z1E6VR9xIKevB3pfzz
 lMYoDCUznJIVbSUj1Y6R1dznXo1Y5Bc/736Q716+uaamrsRSsuoMHWzruXtpHWtXSdhIqA==
X-Received: by 2002:a05:7300:3b28:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2be291314bdmr284868eec.3.1772551394590; Tue, 03 Mar 2026
 07:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
In-Reply-To: <20260128195327.2158888-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Mar 2026 10:23:02 -0500
X-Gm-Features: AaiRm53i3PwX9HzPIV4BjkemiRFhrJ7w-u65lbFyfbSZPqxjF9Dg520oOjMzPcM
Message-ID: <CADnq5_Obq9LW2TrvB0y8ELha1BubjWz9n2sh59Zr2NRN+EZoWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

Alex

On Wed, Jan 28, 2026 at 3:12=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Plumb in support for disabling kernel queues and make it
> the default.  For testing, kernel queues can be re-enabled
> by setting amdgpu.user_queue=3D0
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109 +++++++++++++++++++------
>  1 file changed, 82 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 08ae50a6313f3..f93ee275ce398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 break;
>         }
>
> -       /* recalculate compute rings to use based on hardware configurati=
on */
> -       num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> -                            adev->gfx.mec.num_queue_per_pipe) / 2;
> -       adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute_rings,
> -                                         num_compute_rings);
> +       if (adev->gfx.num_compute_rings) {
> +               /* recalculate compute rings to use based on hardware con=
figuration */
> +               num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> +                                    adev->gfx.mec.num_queue_per_pipe) / =
2;
> +               adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute=
_rings,
> +                                                 num_compute_rings);
> +       }
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>
> @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_devic=
e *adev,
>         gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
>  }
>
> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev=
,
> +                                             bool enable)
> +{
> +       unsigned int irq_type;
> +       int m, p, r, x, num_xcc;
> +
> +       if (adev->gfx.disable_kq) {
> +               num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +               for (x =3D 0; x < num_xcc; x++) {
> +                       for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> +                               for (p =3D 0; p < adev->gfx.mec.num_pipe_=
per_mec; p++) {
> +                                       irq_type =3D AMDGPU_CP_IRQ_COMPUT=
E_MEC1_PIPE0_EOP
> +                                               + (m * adev->gfx.mec.num_=
pipe_per_mec)
> +                                               + p;
> +                                       if (enable)
> +                                               r =3D amdgpu_irq_get(adev=
, &adev->gfx.eop_irq,
> +                                                                  irq_ty=
pe);
> +                                       else
> +                                               r =3D amdgpu_irq_put(adev=
, &adev->gfx.eop_irq,
> +                                                                  irq_ty=
pe);
> +                                       if (r)
> +                                               return r;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -2801,6 +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +       gfx_v12_1_set_userq_eop_interrupts(adev, false);
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>         for (i =3D 0; i < num_xcc; i++) {
> @@ -2868,10 +2901,26 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_=
block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> +
> +       switch (amdgpu_user_queue) {
> +       case -1:
> +       default:
> +               adev->gfx.disable_kq =3D true;
> +               adev->gfx.disable_uq =3D true;
> +               break;
> +       case 0:
> +               adev->gfx.disable_kq =3D false;
> +               adev->gfx.disable_uq =3D true;
> +               break;
> +       }
> +
>         adev->gfx.funcs =3D &gfx_v12_1_gfx_funcs;
>
> -       adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
> -                                         AMDGPU_MAX_COMPUTE_RINGS);
> +       if (adev->gfx.disable_kq)
> +               adev->gfx.num_compute_rings =3D 0;
> +       else
> +               adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kc=
q(adev),
> +                                                 AMDGPU_MAX_COMPUTE_RING=
S);
>
>         gfx_v12_1_set_kiq_pm4_funcs(adev);
>         gfx_v12_1_set_ring_funcs(adev);
> @@ -2898,6 +2947,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_bl=
ock *ip_block)
>         if (r)
>                 return r;
>
> +       r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> +       if (r)
> +               return r;
> +
>         return 0;
>  }
>
> @@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struct am=
dgpu_device *adev,
>         if (xcc_id =3D=3D -EINVAL)
>                 return;
>
> -       switch (me_id) {
> -       case 0:
> -               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> -                       ring =3D &adev->gfx.gfx_ring[i];
> -                       /* we only enabled 1 gfx queue per pipe for now *=
/
> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id)
> -                               drm_sched_fault(&ring->sched);
> -               }
> -               break;
> -       case 1:
> -       case 2:
> -               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -                       ring =3D &adev->gfx.compute_ring
> +       if (!adev->gfx.disable_kq) {
> +               switch (me_id) {
> +               case 0:
> +                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +                               ring =3D &adev->gfx.gfx_ring[i];
> +                               /* we only enabled 1 gfx queue per pipe f=
or now */
> +                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id)
> +                                       drm_sched_fault(&ring->sched);
> +                       }
> +                       break;
> +               case 1:
> +               case 2:
> +                       for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> +                               ring =3D &adev->gfx.compute_ring
>                                         [i +
>                                          xcc_id * adev->gfx.num_compute_r=
ings];
> -                       if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> -                           ring->queue =3D=3D queue_id)
> -                               drm_sched_fault(&ring->sched);
> +                               if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> +                                   ring->queue =3D=3D queue_id)
> +                                       drm_sched_fault(&ring->sched);
> +                       }
> +                       break;
> +               default:
> +                       BUG();
> +                       break;
>                 }
> -               break;
> -       default:
> -               BUG();
> -               break;
>         }
>  }
>
> --
> 2.52.0
>
