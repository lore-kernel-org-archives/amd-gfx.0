Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA954D3EE6B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EF210E078;
	Thu, 22 Jan 2026 15:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NCwhzXZJ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F010E078
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:01:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so14691945e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769094086; x=1769698886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvCjR8X0IAE1BREUCOgJ6vVkdqVRr0pGs0xIiR58gY8=;
 b=NCwhzXZJgLGjKZlAwG+U0wLY5NuY8bqZ5uGVlixS986e2dgM6EEudFdkoDwSXOXUDC
 hSHmrr6evou3/sZOB+VSrx168GAkieY3cal1uGqxzVUn6hBnd0UBnDoF1/2Iubyl5DNi
 lVfta4ahmtMYHVjuZKt1mvc/Abwhg4nZhInUzUjF+ZhQSDkVXM6G6NsySkEFTwgye3H2
 M3IWyA+e/MIKrOp7Wj9o8vORpTab0UM3t27mTluhfNtAtSSAlvazcXyLpFKm7RxsYk8P
 bjuGjT/lPwM5Ayo0aM+NrJ/83/F7IkMtWZBN8P9fzr6YYqtAmTIFZOuEjIjT48fC0/Ns
 FsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769094086; x=1769698886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cvCjR8X0IAE1BREUCOgJ6vVkdqVRr0pGs0xIiR58gY8=;
 b=fOx6+3R6E+cz1z+EKwAs9LVJoBfe7JYlEGBGJFLl2Y8zMUcr8IKcvxJKa4rFJUgk1g
 uwg5g0Ulvskn59YpVwyppf3NvW1sI0kR0AIUZhsRZDYY2mdSId/uHQn9mQuKxUCHKs+c
 RhgtzK/WRp/Oug1fMJwQzZ9lbf+ZzxNtPOp62HWIxQyIBTjTutqZ1Lp31uZ7ykC2DJeA
 r82oJMei4lbRC1NykAvMJEJVRBc/sLllePeyEjch0/IrCozDSGsTSRx6h3JualwnDL30
 FNcO0Nz5ceqx8EozGVjo1eDMtmP/2nA0o9UNKmgMNsbL7OVfa0x6TKVvDMAdd+VH/hfM
 CYMw==
X-Gm-Message-State: AOJu0YxQcL14QsPpfUPSnXwLYGlyA1+L8d2rNEakecOvpTPsRG53LvLG
 9DiAW+ugwvGfl3xXDqZ80ZbyTmIBvQ4NpRzKAHBknxgNQnKmuMoHzQx8HAbPeQ==
X-Gm-Gg: AZuq6aLO4O5PgKrbJiDU6DG7Fn2/7cYcyJerLFQ8nCUgpSXWhANtjX9KtXugweJ/xb1
 eOVNgNsP48q6q4PBT7Gy1fUSTKKzALkrfTErE8wetApwy4hV2Rj6OJG44VBwqM+/zr/A9IxS8a4
 rwb3XfBmRnpIX2UAHlDgRBx9nGEIDAdxdQtvNVmpO69Jkn1B0qio/Sylpmk6lVUi6sUuxmFvap5
 OEMl0xmzyzU6cfaYFB8m+oOoFW9OseU4kiT4dZgsE2b4/FSMIDoAta52z/a3MGnAoZk5306fe75
 VEbN615K4z9L4dE6ORc6qmWD6+hSfrxqOKrg6fHg3s9jEVVSkjIDdwOY6oqEav6Afbjqlflr04k
 1SY2xG0iVs09iBJnJkyPoLKnvTwpkSD/NTFPg5VHFGreiL/LqtLu2csUUhwEbkIhGGMQq+3fUQD
 9VJKO6gNKN3yPEZEY06LwHluElv/FVEh2gOfDZAb22P5EHr0uW09gbpudH
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id
 5b1f17b1804b1-4803f44a19amr125655945e9.37.1769094085863; 
 Thu, 22 Jan 2026 07:01:25 -0800 (PST)
Received: from timur-hyperion.localnet (5400182B.dsl.pool.telekom.hu.
 [84.0.24.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48048b49880sm59781895e9.11.2026.01.22.07.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 07:01:25 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
Date: Thu, 22 Jan 2026 16:01:24 +0100
Message-ID: <2808451.vuYhMxLoTh@timur-hyperion>
In-Reply-To: <20260121182447.2434085-1-alexander.deucher@amd.com>
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, January 21, 2026 7:24:47=E2=80=AFPM Central European Standard=
 Time Alex=20
Deucher wrote:
> From: Jon Doron <jond@wiz.io>
>=20
> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> ih2 interrupt ring buffers are not initialized. This is by design, as
> these secondary IH rings are only available on discrete GPUs. See
> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> AMD_IS_APU is set.
>=20
> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> get the timestamp of the last interrupt entry. When retry faults are
> enabled on APUs (noretry=3D0), this function is called from the SVM page
> fault recovery path, resulting in a NULL pointer dereference when
> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
>=20
> The crash manifests as:
>=20
>   BUG: kernel NULL pointer dereference, address: 0000000000000004
>   RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>   Call Trace:
>    amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>    svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>    amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>    gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>    amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>    amdgpu_ih_process+0x84/0x100 [amdgpu]
>=20
> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
> IP 9.3.0 from noretry=3D1") which changed the default for Renoir APU from
> noretry=3D1 to noretry=3D0, enabling retry fault handling and thus
> exercising the buggy code path.
>=20
> Fix this by adding a check for ih1.ring_size before attempting to use
> it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgp=
u:
> Rework retry fault removal").  This is needed if the hardware doesn't
> support secondary HW IH rings.
>=20
> v2: additional updates (Alex)
>=20
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jon Doron <jond@wiz.io>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thank you for taking care of this!

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> 8e65fec9f534e..243d75917458a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
> amdgpu_device *adev, uint64_t addr,
>=20
>  	if (adev->irq.retry_cam_enabled)
>  		return;
> +	else if (adev->irq.ih1.ring_size)
> +		ih =3D &adev->irq.ih1;
> +	else if (adev->irq.ih_soft.enabled)
> +		ih =3D &adev->irq.ih_soft;
> +	else
> +		return;
>=20
> -	ih =3D &adev->irq.ih1;
>  	/* Get the WPTR of the last entry in IH ring */
>  	last_wptr =3D amdgpu_ih_get_wptr(adev, ih);
>  	/* Order wptr with ring data. */




