Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F39FCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 14:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1754310EDA3;
	Wed, 20 May 2026 14:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tL80+Obj";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC3C10ED01
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 14:24:41 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c750eaf4cso242434c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 07:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287081; cv=none;
 d=google.com; s=arc-20240605;
 b=g7wU4/QRs5h8eoPphNMLew4+b0iAWwztCtlNeafNhB1Y2UM0h6Khb+64zUBT3lWiCb
 s+R+118oLSiEW6slhFSge6iWOcMYCg9S4YYMV6JxxevlVqX3kRyHjRWDPF6tYW6KIO39
 xZ0HFs/qhUBzp/DinI1Y3DV6/y+KLNCiMLHuOZrQY4i7BBkdNyhu3uGcfa5JSBvPCFSl
 +NOjS+8qLD0qCX7UrPHvwbXXU3tZEAX1vUFYwxlNMLznoXPDu0fJisADRMiBrZS7+Z7L
 GBe+/zKuFzG6ivQZkftf+/JvMl+KAo3nruKBgpwOfNcAIvAsDyRs6HpBotyQtu3RmbuM
 C74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aoa72Vlm6YG6Db2Pq6NIKZszk0rEB/eaZDyIsm0RtZU=;
 fh=XO+31KTmBjEuRDud09vqMlaEz1H66xQ4VPgpO6PJXxw=;
 b=OUodPDCngDoTRh3Zgt+rOTEDH0s4KS5RxXIDo/t3iR1l2nxpxNpEi7XnZNwDLvGtoW
 W5WEkhQ+v/GqHNfTV1S7H7FH8mxsf1KGTROE4bBdQ3pAt0t0/gKoFaVMiTbC5eY5wgvs
 oLXzZed0qi9A6i5LXmtsQlnD4s6hXuD9BSgAdSc+9xcLQxM6q3yL6P0l/8eP9M5BxgNa
 7n05pLDE79O/3GMyULcBDzC8apXfnx2tFAzIaBf6VSYnPqiCbtAvqjgL0mALXy8g2vsZ
 +rH5m+JidvomEacnjPSJNesSWkpJAm7SpblhXIvybOGkGiQjyxLSpP6PagMrIT79KKnk
 6S0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779287081; x=1779891881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoa72Vlm6YG6Db2Pq6NIKZszk0rEB/eaZDyIsm0RtZU=;
 b=tL80+ObjD6pqTi4Bcu0mSx53Sr06xqq8ns6Fq+4cSySZJq4FPsoRwdIL8QlmdQoYNQ
 ALKdQl1m/TMuFN0dbnpLzpcsVAThy5BPJtVAPChn1NJ1cd+/ujgwA+Mm7293CVUKxLyK
 VIq10emGY495vmCI/YO/Enx9hbm8kGfajtGLGzyJ+vidQTzOEY3xu8r/skXs/dPVek6B
 Zlvaep4voqxAsLwm4wPvTnvndn3wfsTWRq85Ujtalicsvwct8k7zd2dQOtChDWxJK+Vt
 H0ni4nK8rybdHEEKb2fOng+pDLF7Impw/asdR2s1CoNKN0+ZmAI526jan2lzdl5VsE5A
 0ULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779287081; x=1779891881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aoa72Vlm6YG6Db2Pq6NIKZszk0rEB/eaZDyIsm0RtZU=;
 b=aeUkQW5LrYVmwyp4339WyszLMaRbIuEhrJOYGCeDeeDaKtBWG/RQ5PL509WhofHXX7
 GqrzZbJl9QEL2xioF1/V2yZKP7XX5EOY4Jw+SsdJTa1REU6zaYIAaTCcL1wffJHASVgC
 ylM3Yhoy1Upnw8XWH8nuuK6XtKHj6peu/AOWMXCjY06HJS7X8BGmG/3FYIRBZ1S7WoH4
 d1r+lolNU79Y9T/E73tStK7G+vC4TtsjnOedp9hv+owEegr6uAEtu1+WBREC4bn9UKWJ
 NJHF6/RMOQa8BGhVO5uMPb2bKW2R/j0ePzTnkHJ6gBzkaSG+KFEsUTfVgCOXBdJ4cmlf
 sHsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UReeaC7KeqQZFs/qNdN1Zquf3furq2FdKvselcIPNt/1WM6Qq9YTkEu10Ai3sw/Scm89kJgT5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp5z5K0NSVwEyQSAiNavNRmFRJrNt927VYRsAoLfeJa4/Vvj4a
 izYfxpmWyqE1rWFoLcuu8bXFbS3fLNXwj9zBcwBO2cNNXKSGTsXrcAnz2RB7x0CWE69dqkAXD+5
 Yp527CHF9HjE4NhUCrEALDWT+zkLpOYQxiyuq
X-Gm-Gg: Acq92OGuCnkPgjw9ycRXNZELeBFPvyzIJSq372viUrGUdNavZWJQg4ilmg/GZEqndoW
 EqjlFMaVczVon6uuRMUw/9HdWs8U9hgoFwP4/wlAylz6Avx/F4LjKUo1cuL56dxTBgob3S+AcRN
 fP9HMc2tQi4swxwAQNutK23oRYLVnqdVN5PV98nB461n/P9kdsqe1yZpo140MTwq1ymprnBXih3
 DcEYo1JLfD2dbySyPXTjq4FfmKqQ/nQBZD50+cMGbUOxSWqWrI8ZOkY1+2qGnLHBStq9f9jOX3P
 l4nCXOSWS7T6E9qsZudRwXZ6/sd5i/9P+8Skn7aHpEFN5LS8Rtk+JXofTywnC5Z4PkEDjQ==
X-Received: by 2002:a05:7022:909:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-1350452217amr4844001c88.1.1779287080589; Wed, 20 May 2026
 07:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260520082328.1773691-1-jmuthyal@amd.com>
In-Reply-To: <20260520082328.1773691-1-jmuthyal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2026 10:24:29 -0400
X-Gm-Features: AVHnY4K0G5tavl7ScULYPchT0uoaIIkFr6EhbYMKiP4V_KUCqsRaSS_BDSppiu8
Message-ID: <CADnq5_PGkMxg6yrRaOrBWzq56aZkrhGZ3r6Jw5WHEB3WFVJOPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified
 ring
To: Jeevana Muthyala <jmuthyal@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
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

On Wed, May 20, 2026 at 4:29=E2=80=AFAM Jeevana Muthyala <jmuthyal@amd.com>=
 wrote:
>
> From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
>
> Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 40 ++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index d5f49fa33bee..4223159c9a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1234,6 +1234,38 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_u=
nified_ring_vm_funcs =3D {
>         .reset =3D vcn_v5_0_0_ring_reset,
>  };
>
> +static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs_s=
ecure =3D {
> +       .type =3D AMDGPU_RING_TYPE_VCN_ENC,
> +       .align_mask =3D 0x3f,
> +       .nop =3D VCN_ENC_CMD_NO_OP,
> +       .secure_submission_supported =3D true,
> +       .no_user_fence =3D true,
> +       .get_rptr =3D vcn_v5_0_0_unified_ring_get_rptr,
> +       .get_wptr =3D vcn_v5_0_0_unified_ring_get_wptr,
> +       .set_wptr =3D vcn_v5_0_0_unified_ring_set_wptr,
> +       .emit_frame_size =3D
> +               SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> +               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
> +               4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
> +               5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
> +               1, /* vcn_v2_0_enc_ring_insert_end */
> +       .emit_ib_size =3D 5, /* vcn_v2_0_enc_ring_emit_ib */
> +       .emit_ib =3D vcn_v2_0_enc_ring_emit_ib,
> +       .emit_fence =3D vcn_v2_0_enc_ring_emit_fence,
> +       .emit_vm_flush =3D vcn_v2_0_enc_ring_emit_vm_flush,
> +       .test_ring =3D amdgpu_vcn_enc_ring_test_ring,
> +       .test_ib =3D amdgpu_vcn_unified_ring_test_ib,
> +       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_end =3D vcn_v2_0_enc_ring_insert_end,
> +       .pad_ib =3D amdgpu_ring_generic_pad_ib,
> +       .begin_use =3D amdgpu_vcn_ring_begin_use,
> +       .end_use =3D amdgpu_vcn_ring_end_use,
> +       .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
> +       .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
> +       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .reset =3D vcn_v5_0_0_ring_reset,
> +};
> +
>  /**
>   * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
>   *
> @@ -1244,12 +1276,18 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_=
unified_ring_vm_funcs =3D {
>  static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
)
>  {
>         int i;
> +       const struct amdgpu_ring_funcs *funcs;
> +
> +       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(5, 3, =
0))
> +               funcs =3D &vcn_v5_0_0_unified_ring_vm_funcs_secure;
> +       else
> +               funcs =3D &vcn_v5_0_0_unified_ring_vm_funcs;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unifi=
ed_ring_vm_funcs;
> +               adev->vcn.inst[i].ring_enc[0].funcs =3D funcs;

This could be simplified to just:

if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(5, 3, 0))
    adev->vcn.inst[i].ring_enc[0].funcs =3D
&vcn_v5_0_0_unified_ring_vm_funcs_secure;
else
    adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unified_ring_vm_fun=
cs;

With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 adev->vcn.inst[i].ring_enc[0].me =3D i;
>         }
>  }
> --
> 2.43.0
>
