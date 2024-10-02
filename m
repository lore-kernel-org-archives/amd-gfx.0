Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A00CF6D3B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDD310E664;
	Wed,  2 Oct 2024 16:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+cLtf3v";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5C210E632
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:44:19 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2e13718283bso8130a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887459; x=1728492259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38BzCTuncZ1XvDuLhMAY9J2/RlXxGiU4/uEx+zOGSd8=;
 b=I+cLtf3vP0hn0ng07hgkXNJtiSj7H0YlINRV73a61Vpi9p1MC0cm2VJS1Le5Y80CAi
 fv/mdlX+ZDopwbYACssVWcyXPhMYjEgPC14Pepb8yl19urBc3MPSV1S5Kzo0BTYDpGpz
 jLtxKUG8eiZIuVzprbRIge+vBKTAESi/HOnkI+DoLNXQ4kqJGWmwA8rsVpCk07BR6S0c
 uL9eXxiUsto8UeMAV/8lU0fjd40ItFBEhsLgir4vHY2K9FQyKmzrBq6x0cNFq63lDM9y
 K6DWEqMF8YBvcs9hoohgxcWJ3jRMfW3Ks6PhpwwE5Tx/8kfn+2H0iSAgV7Olz4XmKAuF
 62Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887459; x=1728492259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38BzCTuncZ1XvDuLhMAY9J2/RlXxGiU4/uEx+zOGSd8=;
 b=tmk87k0xLoU80YwNx8EmJ8ocdQyJlGfJ0VopPPNNNtbxiG1lu4l035STAweoXDaM9h
 349rNQ1swOowP9GOxCO9elOaIUP8+uPV+gNWomst0BDRToGu4ECmi3KZq/7qNE107X3W
 sg+AbeY6jpsjxB6X/qJS4nN3zdUUV6DSN3XMCPXSn1TewHzEkBrDQ1+2OqYWjI/nS1in
 jgTmyybYmaHXYwGY8mbyEdwUErokhDCt2y8QuYTnITvMv2PTPmdT8fb9UlHuFxw4T6UY
 DH+vxrzIbi26B3wn3WNn4Fco1WemuBb5hyjjZR7O/GlT7PcMcUnunXd9uyJhBDq6iQya
 McLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCbwqvtWwDzgysIWCVpj496NzQovuT05FXbmoinDmBZIL9SfkE5ndrhTTnf5Xr+H7LCerH2tvh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFTFv2Pq/BJsMGU5usUSeNj4qQBhmROLlCWd90wmRUVPk5T/wO
 P+wzrQ2f2U+7C3bzvIBprb+upapsKL/JETgEjc40b2XMbBOxy9ojOtGAtK0smxKlzbHko6nhzlN
 HWEHEe/sloTUfn2rKY7zWqqJZC2Jpzem4
X-Google-Smtp-Source: AGHT+IF7WBUatT+4trRrytkFqE6WoG+Ws1PluIfvbRcm+rexLSiSxCcgsXeAkHo5q/H/khanOokpTZUTexDbeN5tbTg=
X-Received: by 2002:a17:902:c407:b0:20b:c92:1a12 with SMTP id
 d9443c01a7336-20bc5a0a80fmr21498635ad.9.1727887458945; Wed, 02 Oct 2024
 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
 <20241002043936.2960921-6-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-6-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:44:07 -0400
Message-ID: <CADnq5_P+5p3khX0kfP2remMk=DFejU6CqBkYbxDqDrZjxEr5CA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx12: Apply Isolation Enforcement to GFX
 & Compute rings
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Oct 2, 2024 at 12:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit applies isolation enforcement to the GFX and Compute rings
> in the gfx_v12_0 module.
>
> The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
> `amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
> called when a ring begins and ends its use, respectively.
>
> `amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
> begins its use. This function cancels any scheduled
> `enforce_isolation_work` and, if necessary, signals the Kernel Fusion
> Driver (KFD) to stop the runqueue.
>
> `amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
> its use. This function schedules `enforce_isolation_work` to be run
> after a delay.
>
> These functions are part of the Enforce Isolation Handler, which
> enforces shader isolation on AMD GPUs to prevent data leakage between
> different processes.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index df4a30f8a205..a012166b6bcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5340,6 +5340,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>         .emit_mem_sync =3D gfx_v12_0_emit_mem_sync,
>         .reset =3D gfx_v12_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v12_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute =3D {
> @@ -5377,6 +5379,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_compute =3D {
>         .emit_mem_sync =3D gfx_v12_0_emit_mem_sync,
>         .reset =3D gfx_v12_0_reset_kcq,
>         .emit_cleaner_shader =3D gfx_v12_0_ring_emit_cleaner_shader,
> +       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> +       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>
