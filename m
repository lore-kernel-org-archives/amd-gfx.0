Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37656C3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 19:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4AD10E263;
	Tue,  6 May 2025 19:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hXmtMeDl";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EA810E263
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 19:12:46 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-30a80e3222fso187776a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 May 2025 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746558763; x=1747163563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeBzmwx/v7ssLymwjiGQVoMfLiKmS6dy6bI7vk6sRoY=;
 b=hXmtMeDl3A9J9QLzD58WfnF/yJHvqeR1M2YeP6jEmblYjfNG4WFyUq+YIm7WUOGh9C
 tOmqpUmrPpSeQyC0m9095MIYqtnpEzvLM6FVqbkbs8hsAFIoFv8umGfkxYF7qxFZME4M
 JdUAGYQh21i10As1JIgB//pBuypvg6MFGBXwnH0yZoDi/OvGKbgxJf/LAJM5ZaWcFseJ
 PZd1bF+yeHRfIfTdIzraUni9LnSaapp3dICe54ptFHrwskCwTo8aX+LY5tFxmyrzEnMA
 E4EePWWzY25v1wjcYepOJCcaH464aMCTSbuIUwEyufmwMmy+Y05I/ou0b0jhP/zpVi3d
 GYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746558763; x=1747163563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeBzmwx/v7ssLymwjiGQVoMfLiKmS6dy6bI7vk6sRoY=;
 b=hKCUrHfLpQNrJLdr2oF0HCuATZuVad7ntvOAzWJ47jVLtjpU4NU33lELaGLPNSmePr
 boCnvm6Qcp3FlLGuUZwwmX5kTLNSrQO3pxxHNJuVnoShzxquUEqM4FNvJnzJw4qsjwLm
 Zv1cwtyRQoGRNoapRmMieHXAA+EMYKseempw7DJNkIs9nSlBXhtWIwbzLIsIvw3HtkUz
 abTmbg/LHzo4aJ7WomYkvcRYi+my+vax/dJxVqIwykrhQEw7DArsskQLoS1Ylh7uZx2Y
 ma2aj0j4lm43LuoCS2EutGuSm4grtFko1mzSa+96PWnK+dggcEYOIrjSREilEF5MWNWr
 eAfQ==
X-Gm-Message-State: AOJu0Yz/qzxvFLh1jZst8uP9uMenMrsKvltRtpf3Bp4GqmELBQc5+80m
 QV0UqhC4jkBPXeuTFHZ8sbl03AvkeQssC3mErr/T2wvNBnEBNjSzIuBJw9xt3eidjOUsWIys6Zq
 YInZtqSz6MjUnL5PnLm+URLA0h4GVBJWM
X-Gm-Gg: ASbGnctKOP9hGlfQfEKNZsdMjwTJY7UOANqHKbN3NFupRaF/WbgVf/wopeSN2NzZs6J
 +1MER8eGefjY4Tu9mDhcHmT3nr5MlFg+bCknTxAREML7sCDYcrnPzuZ/svNLLt8NCtiQk16oXRM
 WnijV3IzGZ5xsWoMlMh1cVZ4wlfwT4Zxl0
X-Google-Smtp-Source: AGHT+IEgnWldeCQ+qQrrSoGcFzslKzPprHgKXS5zbL+0Kswp1Gz53XjL8BRAwgzMJXo4lmxPTso7WN1mxcZMwyW37H8=
X-Received: by 2002:a17:90b:4a0d:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30aac168c32mr302391a91.2.1746558763625; Tue, 06 May 2025
 12:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250506175419.3518-1-mario.limonciello@amd.com>
 <20250506175419.3518-2-mario.limonciello@amd.com>
In-Reply-To: <20250506175419.3518-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 15:12:32 -0400
X-Gm-Features: ATxdqUHQAeGkc2XUA_BcpzkQiA47VsGMJWuJlWSMLI6sGQJK-RCIQSQoYLgact0
Message-ID: <CADnq5_MyumjKzir20fOxYvEci84oGWszyVH2rmaf6D6f8amdPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd: Add per-ring reset for vcn v4.0.5 use
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 David.Wu3@amd.com
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

On Tue, May 6, 2025 at 2:19=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> There is a problem occurring on VCN 4.0.5 where in some situations a job
> is timing out.  This triggers a job timeout which then causes a GPU
> reset for recovery.  That has exposed a number of issues with GPU reset
> that have since been fixed. But also a GPU reset isn't actually needed
> for this circumstance. Just restarting the ring is enough.
>
> Add a reset callback for the ring which will stop and start VCN if the
> issue happens.
>
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 558469744f3a..3e6e8127143b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1440,6 +1440,24 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struc=
t amdgpu_ring *ring)
>         }
>  }
>
> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i;
> +
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
> +
> +               if (ring !=3D &vinst->ring_enc[0])
> +                       continue;

You can drop the loop and just look up the instance directly:
struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];

Also check if per queue reset is supported:
if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
        return -EOPNOTSUPP;

You'll also need something like:
adev->vcn.supported_reset =3D
amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
in vcn_v4_0_5_sw_init().

Also, since each VCN instance is only single threaded, you could
theoretically save the other jobs in the ring and fix up the ring
pointers after resetting to continue after the bad job.  That could be
left as a future improvement however.

Alex

> +               vcn_v4_0_5_stop(vinst);
> +               vcn_v4_0_5_start(vinst);
> +               break;
> +       }
> +
> +       return amdgpu_ring_test_helper(ring);
> +}
> +
>  static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
> @@ -1467,6 +1485,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_=
ring_vm_funcs =3D {
>         .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
>         .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .reset =3D vcn_v4_0_5_ring_reset,
>  };
>
>  /**
> --
> 2.49.0
>
