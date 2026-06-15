Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F5CD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 13:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3D310E436;
	Mon, 15 Jun 2026 13:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6y8JQBs";
	dkim-atps=neutral
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2CA10E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 13:54:31 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-59ebc9135edso120285e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 06:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781531670; cv=none;
 d=google.com; s=arc-20240605;
 b=KME0v78PD/QQmro8pg0+sA6Ywl2j0+vNFa6rg67Qv1fv4J0TGRbNottXiVJA3LFgH4
 ion5pz3dbAxID1wiNIy60Y6aDngJhUv7D5KQAbfUpfgOf/EgZKmSS0reDiz4MszI+Rh7
 mNTI5WWQfgktqQbplUGkCa0KkNH/QKnCpKZdl1E1x/83WpHeG0PlVHgyWXBxNkriJ0jj
 Rc9s392Duy8h2+My6SFnO1QoSrF9mzBP318TafRMoMcg+M8dMKf0uZYxIrFd88Z085az
 TXEzmj/Hr8b2iat+e8eW3jAxvupW6sw0MojWnKnk9xkIvOBVSLrHUfw+5t6Tii6YhTlN
 0KmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=20u8IcsIKSPRT/ptwVuz0JdY/Ou6LJfrAtPgq31H6r8=;
 fh=wmrUFF5CAH2Kir5OCD0KmqRLkRC9GgHOreJOcDjH8mM=;
 b=NUv/CjLBKL1AwRwYpyjpwlL/cO7uuRN+knUbY1k1nw95qFR952cFzHsvoo9Kv5xGRx
 LZshKMjih2EICGlpZZh/nJIa2dPcgZQmwanUO0NmRZ+YdJ5qtVbEup4ZnDBHLe19Yw9W
 2HFVwiFK/z9Q5lH1hdwyfuIA6TELT4JFexS419nmz4pjulHkjyOJm/wePdOs85oPPomC
 9zZD080FH5AjCIZG0ITvNwXvHrYx1L0gm0w14/jGxA3sYHclCvIp3MkT38j9lksouVxJ
 kzP3NBs7ESnatObA5iZ023JX4GsEtPtBGWuiVVASVyuAocfJJZmtsoRNBr2TQwM3EFIR
 4Drw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781531670; x=1782136470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20u8IcsIKSPRT/ptwVuz0JdY/Ou6LJfrAtPgq31H6r8=;
 b=b6y8JQBsS5gFw0Oa4M/PUB6EYnBAuu+J+ZEkTu0m5Kf0zPPDLzAPGMIN3ah1WQKt2v
 2/7p6FCzDRdccmdmbyU/Bl546UQmPpxUpDmoQ0+RF/3yikIaF2VBvH0gzdHPsQMFgRu5
 OWEW1ul9VGLH4zNFSirNstyBM4Y79F8UyAw5m9SGINpsiAtbj8jcRKG3zaW+ap9i488z
 uZ+RVC15pd1XYnRQZxXYrsAjwyydSbkI1wu+sYKpp+BLue2aP5346ddsXWDWW3vXkIwj
 EIt1JmmnaX3LQVTAtC4zqkZwlqPd8m2lX/7EEMxaZDhuD9IXzbW6ScD12swqQZAyhjJ9
 /uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781531670; x=1782136470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=20u8IcsIKSPRT/ptwVuz0JdY/Ou6LJfrAtPgq31H6r8=;
 b=mB0pTsAF5F/FhUQCvOKjO26nnfeJXkh1+gPberPj2XDlPMGpNIdE6JcdJLg+YNS3Bo
 XjgfYG0kos9MlHImO6g/tFlEcPk+pask6Mcte8Z+AW+nK9FhgKLCVJAG3iEE9PzyxelB
 etS1BM1UzOaP/dprQ3t2/G+9wiZMU/Y+7e2wOuObAuFftLwd1Ow2ZEwkL66PDJuIwi1r
 5KeFOw3ZXbHAr877GuMPi6LcHzKOPLcYa4avdR2zWtoNMZMKXIkY4hra5ALbVUaZiqbD
 cBXel3qe3i7yhi8kL+b1kwL0ClBWQHtGuPHEgoi8mM7mCtWXPp5/o2z4+Ddw039bYGyy
 mdNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Znw6Gvvi07JWTOxxals03REe23fIUx25SSaJhMFwhTMTL3tBGryiTN2Yo1noiB60jNJB1mH6h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhAqwVLMRZdyEqALulc6uCY/OWcqzfadwzmUxVX6XRH+jnM01C
 6enj9lYtEEMifKW9SBsf5vweRNfKN7qBpHvPsARPiiSFkFT0PIqcwMb7oUZcjBkjMe79IQelm1S
 gIlo/IJ7TkKsDs/q/V/H0ZMlg8kR7E1U=
X-Gm-Gg: Acq92OFRbUfITS83+/MjOHvxhbJmc+xwo0d4RngaLEgGeBXkNb8JlJZQUMKFSQwDgoO
 OP/Df9suB2I5QI2wpDbwY5S+UXlWf/swWLJRZhhu1mKebiEhwe7+vZsJap+En65bklFZylV6pUz
 8SYyAjlkJ2uymmeyOKSy1ovf8UXdKfNoNf8rNULXuyEZirkt87jCx4jG3r8T/Xs68jX0QU+63Uy
 zoIM6RLfTVJOwXvBBIGer0yWGejBIWe6byWigk8aIIaNqTFRx9t1BSALeoDm26pBUwEomsippni
 jpPu48hE8uKOICAbqvdkRrV+Bc+ZHH8tz35AWNhC0WjY7gkZK/PD8FFZIH4V+jKsHzvkhA==
X-Received: by 2002:a05:6102:5121:b0:605:53ef:d53f with SMTP id
 ada2fe7eead31-71e88ae95c7mr2022720137.2.1781531669932; Mon, 15 Jun 2026
 06:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
In-Reply-To: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 09:54:17 -0400
X-Gm-Features: AVVi8CfnFZYO5Hd7oJy5kzsa5knWo6A7-OgaUbbbKBzf7hRHhgCPtkjfqQHR3dM
Message-ID: <CADnq5_Puhk0vEsYkM3uUs+n5i_a0eMFx=0NPwm5WKfEaYDabWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Huang Rui <ray.huang@amd.com>, Huang Trigger <Trigger.Huang@amd.com>
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

On Fri, Jun 12, 2026 at 5:44=E2=80=AFAM Jiqian Chen <Jiqian.Chen@amd.com> w=
rote:
>
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2 compute Ring test and IB test fail
> randomly. It because the HQDs of MECs are always active before or
> after Mode2, that causes MECs use stale HQDs when MECs are unhalted
> before driver restore MQDs, and causes CPC and CPF are still stuck
> after Mode2, then causes compute Ring and IB tests fail.
>
> So, add sequences to deactivate HQDs of MECs in suspend IP function
> of the resetting process.
>
> v2: Move all sequences into a new function gfx_v9_0_cp_mode2_clear_state =
(Ray Huang)
>     To check reset Mode2 method in the if condition (Ray Huang)
> v3: Move all sequences before Mode2 instead of after Mode2 (Timur Krist=
=C3=B3f)
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v2->v3 changes:
> * Move all sequencess before Mode2 instead of after Mode2, and add a new
>   function gfx_v9_0_deactivate_kcq_hqd to do the disable compute HQDs
>   sequences.
>   Then the resetting CPC and CPF are not needed since we have already
>   move all sequences before Mode2 and they are not stuck
>
> v1->v2 changes:
> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> * Add reset Mode2 method check to the if condition that call my sequences
>
> v1:
> Hi all,
>
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
>
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that caused Compute Ring tests fail.
>
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restoring
> MQDs to HQDs).
>
> So, I send this patch to fix above problems.
> There are two main changes of my patch:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 90bbddb45730..0c01701488e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4071,6 +4071,39 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         return r;
>  }
>
> +static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
> +{

Should probably also add amdgpu_gfx_rlc_enter_safe_mode() here.

> +       for (int i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +               u32 tmp;
> +               struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> +
> +               mutex_lock(&adev->srbm_mutex);
> +               soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue=
, 0, 0);
> +               tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
> +               /* disable the queue if it's active */
> +               if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
> +                       int j;
> +
> +                       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
> +                       for (j =3D 0; j < adev->usec_timeout; j++) {
> +                               tmp =3D RREG32_SOC15(GC, 0, mmCP_HQD_ACTI=
VE);
> +                               if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +                                       break;
> +                               udelay(1);
> +                       }
> +                       if (j =3D=3D AMDGPU_MAX_USEC_TIMEOUT) {
> +                               DRM_DEBUG("comp_%u_%u_%u dequeue request =
failed.\n",
> +                                                       ring->me, ring->p=
ipe, ring->queue);
> +                               /* Manual disable if dequeue request time=
s out */
> +                               WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +                       }
> +                       WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
> +               }
> +               soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +               mutex_unlock(&adev->srbm_mutex);
> +       }

and amdgpu_gfx_rlc_exit_safe_mode() here.

Alex

> +}
> +
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -4095,6 +4128,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 return 0;
>         }
>
> +       if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> +               amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD_MO=
DE2)
> +               gfx_v9_0_deactivate_kcq_hqd(adev);
> +
>         /* Use deinitialize sequence from CAIL when unbinding device from=
 driver,
>          * otherwise KIQ is hanging when binding back
>          */
> --
> 2.39.5
>
