Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66032CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 15:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0792110E37D;
	Tue, 19 May 2026 15:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j1hP6ma5";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A8210E37D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 15:42:54 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so155834c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:42:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205374; cv=none;
 d=google.com; s=arc-20240605;
 b=K44uiy7foqDljTRCBtFsQukFMmdITVC9WVlvE3Nk5y5abCZb0bzhVJdRdMErtbEcQC
 3aGU3enqt9ZIrQ+2xiF1QJWf5R97LPrsvN/8e0IqSPVcszoDqOj2eROa93KlPiUcJMkU
 rHVKz7yX74jEEhz2S4e+f9KvsgzDGbjkJ9h9zZtTA9AR6I42TdTFKr9HbF4agu8Bl26q
 SW7la5tkufI9e5cNNQa2+74p4WJZof7ZYSn8RI6cxR0Chd44D679RWhh6pUvDKoFebi6
 1O6y1boykTmQ5MizAYGsf8sruRCZWMJWsJIbmhsNU2z7CNJJ1LK/TYf0yMpqiV5YqdXp
 fmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hN+MtALeb1KrrEmNxFkgBUg6GBL8s7eUt8h5rtH9UjI=;
 fh=1CDmQnl8THA2EZ7+XWE5dg4nuZkysfW7Hxlk986zBwc=;
 b=aH/MmRJ/bzPZw+xN3awFIn6/UpxPxb/WK5WCTFig1njp+DpXkusQiJVbT0br4wbJEp
 dkfz0uqsiSofIBx5jhI+0u6kZ1iCgtIMrcEKnbgKOVoGTYBkI8+B5COcdHIppdkqIweq
 BodOGkcMHXbXGjXUqG/I3XhQhcYsKRTTOp37v2g60yaP/iuulBnxdYGQPt2otDHnkcm2
 mJ0r8g5UiWPbityZFHRdeh7YjasHcYi2ffG2Vs9GCyFP0cikUMSLXkNbfHj2NIAtJgAa
 7z+gWp6a5hhNLo1po3R5MMccw3E+MjbciTVglSaUasGDMYJjlNvCfaMRQKvQ3fuKyKub
 imcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779205374; x=1779810174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hN+MtALeb1KrrEmNxFkgBUg6GBL8s7eUt8h5rtH9UjI=;
 b=j1hP6ma5QlPaHpO+sGoiuyk3sDcErk4dRNCedz2Ct8DrcDNSZkLUFH4nzsL6Kkdc0U
 kLsuvZDo/r33NadJdW8XFLnefd03UF8gdpUT6Y5L4iB/AMdCoLB1aJJwWQKh0pm/7FuU
 iZoNEy6tjiQbzKJ6IwP6jDov80cV6C1jhKWpUgToBdUekobUi+km1JZl9Hf1rHls4xUF
 EUvrF+7p6ZRl7n3B4Uq11FdEyYqvWGnxGcs5hBNa6CoDGSEB5Zz+wnsHxxtZP4NoP/pF
 TZFQ3tzNNpO6ic88aRqvtjopQBtMkAJqp9Sr3B49RfbsKnnnHqkGikISABEyy5qKj6yD
 r5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205374; x=1779810174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hN+MtALeb1KrrEmNxFkgBUg6GBL8s7eUt8h5rtH9UjI=;
 b=TRsV8CPOco2JrWHVxuw4j1g5zO/WfMlWTTZNi3eRMDPaDz92ReW7t8sJDDm7klnX+s
 CgWEGc8eJk2voKhGEkzbEyehhY+7aekSt4rYpQcBp8bIejcFq2rT44TgeZGLXWb+IFs6
 adGm4Go6Pd/JoV4oGn0MFKorqa1ODSijqBJilP0TsXJlsxOe4naf6Z3xrA26kGVt0uPG
 yFDUSy0KqLeQn4W4y7WxN8JcHewKV3ozJE/FIN6jDeIUEQDf+WCuPZrjuH3Ewm17v7/l
 vLo1Z8MrZc5bwgGeG6A2dXeSAkmAR2/5ysx6JpOBU/XIPwb8MUGUnWfenSEMV8KAhq4x
 mQzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xK99mRJqKclfIRx3MLhRfJDjY+22Fc2mc+CGut6c7djbDtN2QJXueItXpn+lKLndTAoWaJhZc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIVPNkrRrffvJxl5BPySFD8+ReMymsDdcLlj6xBB0otn2LPgQQ
 y3Sl1Mf7K6evvwBjrh00MXecaTblYjsTjGZNbJVTU/SoQlo0r5HXyZ1BNvh4vUND+/yQTh64uQs
 ovDrX9ON2hiToi9CKNQXfS2IviDKM+Z0b2Paa
X-Gm-Gg: Acq92OESTLAkF+gL34PXAqUFekfpxqsDsUWXtWtZRKQ8x+g8nSgcs4aKEEI41+dFg4S
 tNg77s8Qu8XAqaX0rpFmVh5HdvCorPq0IcfxzlAeYjpUkUsg0iJWB9VbelZ3eEnnh9zwjGKKnCu
 FirH9cDmbTl10X/kA4nTXHt7nMn1N+J6HlmRXXPc2uRumvvJFr58J/dN3RwQ5c4PSzpbMKDr20/
 mL2KnWgDlo8KHPA/CDVgPSlniLbbbPcsJuKXzeTVd6fAGDIzr/0/NZ8ZEqmdI8Ij99bpryd6zEG
 m20ryb3s5OhVQX7ONgPxs7KOfF5Hifp0XVTqGEg6FCauCHaoXOR6A/7GPpEdHMWtj9BHVQ==
X-Received: by 2002:a05:7022:f8a:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-13504525046mr3911080c88.2.1779205374073; Tue, 19 May 2026
 08:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260519131501.1077205-1-jmuthyal@amd.com>
In-Reply-To: <20260519131501.1077205-1-jmuthyal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 11:42:42 -0400
X-Gm-Features: AVHnY4LH5uGS76cjjTsnQ8gK13pl9B3wW0P2aB_LhejU9maGAlvieqDB_jjXGPo
Message-ID: <CADnq5_P4H3GA_N_E6noCZfR4swVAHFvU6=7xof0pbTAUE8zLxw@mail.gmail.com>
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

On Tue, May 19, 2026 at 9:34=E2=80=AFAM Jeevana Muthyala <jmuthyal@amd.com>=
 wrote:
>
> From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
>
> Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index d5f49fa33bee..cef15d6a4704 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1203,7 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring=
 *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> -static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs =
=3D {
> +static struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> @@ -1244,12 +1244,15 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_=
unified_ring_vm_funcs =3D {
>  static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
)
>  {
>         int i;
> +
> +       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(5, 3, =
0))
> +               vcn_v5_0_0_unified_ring_vm_funcs.secure_submission_suppor=
ted =3D true;

This won't work.  You are changing a global structure.  Please add a
duplicate vcn_v5_0_0_unified_ring_vm_funcs_secure with the flag set
and use that for 5.3.0 and use the other one for other 5.x.x variants.

Alex

>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unifi=
ed_ring_vm_funcs;
> +               adev->vcn.inst[i].ring_enc[0].funcs =3D (const struct amd=
gpu_ring_funcs *)&vcn_v5_0_0_unified_ring_vm_funcs;
>                 adev->vcn.inst[i].ring_enc[0].me =3D i;
>         }
>  }
> --
> 2.43.0
>
