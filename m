Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABAAC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0700710E816;
	Wed,  7 May 2025 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRGaX6sl";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447FE10E816
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:01:19 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-30a8831e462so2186a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 May 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746630079; x=1747234879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwXt7qPjMzEnLZENNFdjmyIBfnQHTWgdIE7i6G+ZtS8=;
 b=gRGaX6slo3L7/NbELlo6EGoPYgOc6Bzse3QTe7EgFErOQP0E+SNNHIF2TDzvcSIgG8
 sGHsutjRKR3P3rN/st4OKiCmQDRB58m7QNdIrejrgbkJtu0hIS5BvSxPZc9d9JrlKnUn
 6Y/8KSUw7CdhTWqG/SEjXKkESaxrQyiLBjIEKh1Xg/W58kuAg/KOyQDLydwsS3DDO21k
 7st+eUd7Q0+LdpZwjX4J/fb7LeG/Jvalf0xDBcIw4g839bJw93OXrPkkOr7Vgqq3JLk3
 AbJtn2mVgsujFF74QBy6EuoKiOndmIFVY4pk12PAnGXmmrTUHDYGqaeTZ8ZMRbScn7IY
 zUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630079; x=1747234879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwXt7qPjMzEnLZENNFdjmyIBfnQHTWgdIE7i6G+ZtS8=;
 b=ReozIHETPPnTCv6uTwy3tMZffz+aYZC9ElkbE+2GVfFnrxXC0Gz9C8Ald5l/6LuhoP
 trEsKTTATZrFTSUK6BlT6JtdjVPmCucZIQyGKfyhAWXful/uPHZ4fCwUakc4FCmCXqNC
 cQ0VUt26c0GU/RgmRTJPdLV3ND7gmBnApLnL3zTXoWRvQs4pwYGOz1natmAwOvVyYfq7
 OFcffe1NAPK7BEoZ6ucnhFwpJdA7ao+8YayM59tvfIRE5dZ1Ehf9VoQMYePBYmb1nO4Y
 RxVgp/JEZrtYvENrOCHZUphFHd9dY9zOM7QGkZ8EKRFhbbhdsEIO5O6/YrV0T6BvkCPb
 136A==
X-Gm-Message-State: AOJu0YzTPnTcovXsmsOxx1ASDLCErO54NZL7htdLMIgM+eALmPUUMBRg
 IhGXQwGWDkkB1kJepllZkMhM6NfM9fqVqMUBt0m9Nz9C9krTl0jk2x6eB+H0PvuyRaYd0viz3kH
 R8UheUrBfkdw76G7aVnLkJKC5SYE=
X-Gm-Gg: ASbGncvevOOBCRULRVWzEsFtaquLCJRiWjJAPEqz58+Uae18OMMbgMGkmJby03MoUC1
 qbwk/9/RgEKWQNM/naQu0wBBdShhEZtEbkWWi/tIJE9wzbRWYwHeD3eDPPgbNqQBdgL4OvON7LT
 Mf8wnn6F2Te+fOYcdQ1qI71w==
X-Google-Smtp-Source: AGHT+IGkPqF3OGMpJ+PxJMNh3dsbHUDA4SgKR/wBhns769AEo4illDwMeLT4KayuG1oM4j95Bk6b90gNZ2GIJz8mPtQ=
X-Received: by 2002:a17:90b:33c1:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30aac16c2e2mr2271544a91.1.1746630078511; Wed, 07 May 2025
 08:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250506204948.12048-1-mario.limonciello@amd.com>
 <20250506204948.12048-4-mario.limonciello@amd.com>
In-Reply-To: <20250506204948.12048-4-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 May 2025 11:01:06 -0400
X-Gm-Features: ATxdqUH6fZKwmqRLBLeF51NJgLXr_fXtjq3vtLFjm5zgtVbLwzvVmSqWtFxfshE
Message-ID: <CADnq5_PJkqe=ZeTe1XhGsUp3d+HRVo3zXQ=cv_vUYQEpEnpDQQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amd: Add per-ring reset for vcn v5.0.0 use
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, David.Wu3@amd.com
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

On Tue, May 6, 2025 at 4:50=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If there is a problem requiring a reset of the VCN engine, it is better t=
o
> reset the VCN engine rather than the entire GPU.
>
> Add a reset callback for the ring which will stop and start VCN if an
> issue happens.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good to me.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index b90da3d3e140..27dcc6f37a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -196,9 +196,9 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>                         adev->vcn.inst[i].pause_dpg_mode =3D vcn_v5_0_0_p=
ause_dpg_mode;
>         }
>
> -       /* TODO: Add queue reset mask when FW fully supports it */
>         adev->vcn.supported_reset =3D
>                 amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_e=
nc[0]);
> +       adev->vcn.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
>
>         vcn_v5_0_0_alloc_ip_dump(adev);
>
> @@ -1172,6 +1172,20 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struc=
t amdgpu_ring *ring)
>         }
>  }
>
> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> +
> +       if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +               return -EOPNOTSUPP;
> +
> +       vcn_v5_0_0_stop(vinst);
> +       vcn_v5_0_0_start(vinst);
> +
> +       return amdgpu_ring_test_helper(ring);
> +}
> +
>  static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs =
=3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
> @@ -1199,6 +1213,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_un=
ified_ring_vm_funcs =3D {
>         .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
>         .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .reset =3D vcn_v5_0_0_ring_reset,
>  };
>
>  /**
> --
> 2.49.0
>
