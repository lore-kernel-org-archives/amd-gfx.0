Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800CDCD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 13:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEA310E7AD;
	Tue, 16 Jun 2026 13:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQJvhuWA";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2E810E7AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 13:50:52 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137e836ccc8so326554c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 06:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781617852; cv=none;
 d=google.com; s=arc-20240605;
 b=Q8Wz5E0Cla72AoYeY+5a04nUpXFrpPfe3zTFSBOI6gKtqYsxgoN35WC/wT2GmU91j8
 LiKlCo8aDnLOqrXjBU4JMyYir0+V9n7PBdgAOmWT4nfjhLEETDoVyTz15wHe0ztHfKzm
 PIdhaNp9G25G9RSfSoOoALGQpPR1/dlGflt5TFrjauKdcZQNBA1Cf6F4n9vWP+ERa9p6
 AO4gliFv9RR3XrE3TgAKTr9JeRa8SP+WiPMyDu3IM/3sPvC0lt9ElFY0XaeeOvAPv4XC
 PHdoIQxqNxdkK8OwWtPfw8FQ08zYvkDwiX9akl+AOCkrGFAP/k9B6FMdMk+UXAGPs2yv
 bRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rp02vzQBlNh4tQQ5N5fldDzYa63S1rGKHL0oepA25Os=;
 fh=gVf6fvsABP0ByoUtmYjsDXKLAu0ixkCuRN36w5o5Dig=;
 b=l1qQTDIjYJBT/HTDjbpkEsHYfr7YOMqcOqgN2Do9E90y9KhLPZOQHyWZWhdp5bagF7
 5FynaXbwU1YyqLBillEBoVqp239oiJ+k7XK/yRdmpBDuUn7UdpShYa06k3y0Hl5k4jMD
 2avLG2rGIPDvzxPiGSIOA21LXdZgeUkEifME24pmU6kIeXuU4UjMsY5XJowfQHTsc/Dc
 rmzsjFigRuEl18ZLjp6IXAepV9XGGVL5dq1yU/nvrl10zBl9DgPmOhZzuxczjPDKRQpi
 4xC7HQ24fcsmxsBQqGnH8yWBWxqmuuGN8XplQDE1/Xag68d5ZOOQcXVPNGNKgLY9v4iw
 hUdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781617852; x=1782222652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rp02vzQBlNh4tQQ5N5fldDzYa63S1rGKHL0oepA25Os=;
 b=jQJvhuWA0jJDmeB5UytMmrUwy2jakqWmdUM1u+5Iwak/urGqoYvJtWU3CiMThKIKn6
 f03r7kx/5P/3mf7iSxjxYj2CiDX68N5XUwoxiv5s9ZqHnnYu4iqTEejo7bsiTImCOk94
 mNa57r+FQkKPsxviVgUCtOr4bTLVykQ+2WBMM8BjVzLM3CwQhwknWav8jDAk0KJej0Jd
 mG+ZkEGhCCkB+nmJvu5KQvMWTVIN2OqGHGRjf0B2153ukMSrkDrv1U1YNYJYkhkrOLhq
 nTJ38SMYNpV/lVonEvNMJHCq1Rhun7vCXhKaOb7kb9DRyz2HWLr8ux57AcZ+FbhAHvZT
 qisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781617852; x=1782222652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rp02vzQBlNh4tQQ5N5fldDzYa63S1rGKHL0oepA25Os=;
 b=mHctPGxbjQlrh8UATh+vP6KMQukDWXTEdVLttCMo4HWp4lZMK+blJUrYAa61w0fBUc
 InWjK080JtjngtYAgPNUD5s+GHraD8TeeI/74A/c3sOYX4s8rMzXz9bkg118ZqeRzgHJ
 N/obgLcmYcPmd2qq6Dz2oBcDKj3wBeTyWQRbYOQtUnwe+i7NwLM7IxcUFw9ZtLm3FdCw
 eDVHmU2FJIAghACrJ8G7W0JmWiLvocOEVF/GVu0fv6+HtCQwJVMqgJuz8FuImv8VVP0f
 n9CXu4+3grso79VIV0okTkX0DeNdONyd/suTWi+wHC3ksvPPEdlbW7+4D5tnrHzy/l6+
 JWmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wXFQGnaNWVB+7qP1usSY0MNdoF9RS5Ia/VbA0MSqZoCjMFNfzaGSDn3Zx2+f140iBizLM4hLf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM3q95aGh4TQKf9aiN0+cEizEm7Y7Cn+VrlWCZ3WmxEVjaBj+n
 hFzslyGDE6qDUqKcw8bamSMqlvWuNEu69Qn6ubs6Tl9mpRM8MbNjiZWC5XQ7Ka85PUbdmFw6oBd
 XuZpb6HE6A/BYzSv6xyfpB3eO6+DIKSLnng==
X-Gm-Gg: Acq92OEa/JsLZnESw/djxSVL1BK5bbpOLPrcpp3hGa+KmzAEPig/OBz4OcW/jZItyBF
 71+C+YjDo85vtRZctExJtjKhuX0p2wUxDTNutQ2d3+CO5FAVynk9PMzU3RMB7A72y4W0F+tsLdU
 xsoW2eZNjq53IBDTcFATIiw3hE4OaYNLb1a9h9KCQYnyO4lTe1TWJwYVz2aQzqF1TB0qRDj4mFY
 1GDpaXSp0MW1fZYFlDNneUTIWo4EQig+ett4dv/XD6IEbje5Dbws6oV4HWSYJoUexUKj8wkCWB0
 kvm/oGtdf5W6yjhtHUUabjCdRTcRLf4MQ0QTCjEr+F6Q+JL7dq1d8srAmz2kr75I2xUxmg==
X-Received: by 2002:a05:7022:e984:b0:138:43e8:c6bc with SMTP id
 a92af1059eb24-1384bb7e833mr5720137c88.3.1781617852013; Tue, 16 Jun 2026
 06:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260616062505.1982738-1-Jiqian.Chen@amd.com>
In-Reply-To: <20260616062505.1982738-1-Jiqian.Chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 09:50:38 -0400
X-Gm-Features: AVVi8CeCejbtWD-R40U_9swuDDGE2eJf1CxzyP7fHDcNyqXQr178hHiK9s87Wkc
Message-ID: <CADnq5_M=fN2z+Q2Yhw6k=YCS7edVsqyK+Wy0DoLssnQ9xSQ6PA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
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

On Tue, Jun 16, 2026 at 2:34=E2=80=AFAM Jiqian Chen <Jiqian.Chen@amd.com> w=
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
> v4: Call amdgpu_gfx_rlc_enter/exit_safe_mode int the begin and end of
>     gfx_v9_0_deactivate_kcq_hqd (Alex Deucher)
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v3->v4 changes:
> * Call amdgpu_gfx_rlc_enter/exit_safe_mode() int the begin and end of
>   gfx_v9_0_deactivate_kcq_hqd()
> * Add RB of Ray and Timur
>
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
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 39 +++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 90bbddb45730..7704100eae10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4071,6 +4071,41 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         return r;
>  }
>
> +static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
> +{
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
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
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +}
> +
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -4095,6 +4130,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block=
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
