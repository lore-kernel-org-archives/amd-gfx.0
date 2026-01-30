Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3773E6BF0A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 18:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6647610EA4E;
	Fri, 30 Jan 2026 18:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMFbOmXp";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611F10EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 18:47:38 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b70b21ce0aso48243eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769798858; cv=none;
 d=google.com; s=arc-20240605;
 b=iXGcIdaVHraP96+DvcOliESSKndxaC/MToR0MYvyx6dhXgzYQfG81NBzv0LiGaqDBk
 E7aoSrKB5J3Kt5zs+nbMOkRsDfpTq7op5E3hdThH8V4SnRJnKhB116SU9BqxWTmjJwpV
 hjChBmbMddYqZzMhWBTx4yIarzGVzV0uvOTY799SGfm/OHOiQi3oItYrSWydLoPpM3kL
 2NIKVg4hPX4vHzZQWqySctw3ZXA7X/VHYzwXULuPO7tFpH3eELSla4lUrPkBddQmgi+u
 8CDiouhA0gvwkkSyA0ke4OCaGAIDzF0m1sS3y9mM4LnJd3L6eLRYL3UcT/2Wf0gutTJT
 seWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lWPnweHtJZnLrj8TAxCLgeQrtM6nVOs3yWeukBOS48E=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=Zf6bjHBwfy4jle8SxM7a8UhGwn/xkt32+AZpKiRiRImvW8N5nzkXZPRrboBxNMfeX9
 HlBAM/gMj9Ga7lk0KmFdyIKmhUi0sTU890yEhZZNPk6/QQyH03sae8glhP0qlwCMTWPs
 1LYcF/TQ+c/5zObx6B6wq3lzoR+gGzPHV0V4k4qLIsxjMGBF5fx7RBebYMkUhZu+wAtS
 pE/Ha+XlgDkrWZM26/y85qmyRCPOVSjWvJghHYBhpKLTOcMh016CbS455saxvwjGVDMB
 UGBcMzGaE/Og/s9LlXLAjxZTZYWQC0AU3cIkaFyKG2E3GgOmGFf9IOC/dIlqjS0WNqNS
 7OvA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769798858; x=1770403658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWPnweHtJZnLrj8TAxCLgeQrtM6nVOs3yWeukBOS48E=;
 b=GMFbOmXpDAzNUrOER3/1qY1f94yRY3UUJQWppJVaGI2pfl/7CY0TNIVkkBtEt4macV
 a02HCTheh6TpRdN0WTnIk4SFlC35XyUl300Ktz3wZf5Q2Czhbjg7L4HobYVbqOqSBSCE
 fvfWveaRyMOI3QK7Nv6SjZJl3LX5Yi9k6k3fflArUze+JOnBnP+8DEh9vzQoWgr8p6ny
 ETtvahPylj5YzW4UZLfFn4U+ywhg7IavYlcr8zxF+IAiMdXjXE3BPUSjlV8oHU3kQR1H
 aM7wwNrpJIE/oJOnQDiJ2QPPLtPHkFGWKkVgA4QyTEC4Ootary/zgACdDbTRC/SqxZ93
 5tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769798858; x=1770403658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWPnweHtJZnLrj8TAxCLgeQrtM6nVOs3yWeukBOS48E=;
 b=Rgbm6q5ecSr0qME+V7ubPQcTKI1xlF0JVaQlf+orKNRKFdBHqAf78+n3QbKi/G9+Gw
 4RqD7O34bMgr23gfzMRhGACnRCt/EnHOVnJRRwTgpbkUMJIpac9FobBkeTm3DUGLieyS
 cd77DoFGwkhoAhEBXzo6SgOqALI8pXYtQn64q8booqxusj5qc3TIkJs2GrL1RRGppfOb
 uKxXIMWUb/4xw+/G5ZQeph1Lpwbx90DVBo7sk2yzBfMyvmecmDd9SjiFczZl60L3ADXs
 abNVhi+TphhZLIEoO/MtmcnEm1YaNc25Nu74Lp8OyllCV5j2XZQR4Wole53dWhK0yt40
 ezHA==
X-Gm-Message-State: AOJu0YyQ0WclUgaXLJuPyc2mOERtQx2yQk22i9oE30n6MJaQVRojpycR
 bUWHA4k2T33bRkFO2knWMFPppIoO2gP4lEFJhZ4odvFrhYI16McHQkD5GRQF/IdX46vB75Rgef7
 dzkIAoPJfcqCDyQW3DtnkQd34wDdXgk8=
X-Gm-Gg: AZuq6aJeOB8DLrSQGH+YPold7YIzMxxIe/V3LsG1wAXFrqPrtDHjhC9pQfh+3ewyPtx
 5gHlBy4QDKGlZLNXypLYo39sVR1uHli1A5m5VQz/kdmxCCYDVRiwC0AcMyvaRFiShGJ4nkxhAU7
 BZGlKKSa6E8NEvkeGNoqdwydPvahndm+MlKm66B+UzD1SLDS2+71dZ+1uMBsimUPokEsRi65qJY
 0oqucZ8YsBXbKR9sG1oiG4kNixrCbOT87gEYHkl4wY3EFGYzMth59HIBZPxuy2fN/sa2BcD
X-Received: by 2002:a05:7300:6da6:b0:2b7:24fc:f639 with SMTP id
 5a478bee46e88-2b7c866cfd2mr1060743eec.3.1769798857545; Fri, 30 Jan 2026
 10:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20260112152041.441734-1-alexander.deucher@amd.com>
In-Reply-To: <20260112152041.441734-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 13:47:26 -0500
X-Gm-Features: AZwV_Qiy8CZq2HY7-Gr19Zt37sc5N_VMq5qUB-T7q4horACZRT4ZZY91NSKLKvI
Message-ID: <CADnq5_NkTvzOW367vtgrea7yYCM+Ac38xk-9UPfqAHNRtRhpVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: program some additional registers
 for resets
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

Ping on this series.

Alex

On Mon, Jan 12, 2026 at 10:21=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> The first change prevents the hw from overwriting the ring with
> NOOPs after a reset.  This is helpful for debugging user queues
> since the contents will be retained.  The second change disables
> conversion of XNACK to XACK during a queue reset.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 624929473b136..6145cfc0334b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3616,14 +3616,24 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_d=
evice *adev)
>         struct amdgpu_ring *ring;
>         const struct cs_section_def *sect =3D NULL;
>         const struct cs_extent_def *ext =3D NULL;
> -       int r, i;
>         int ctx_reg_offset;
> +       int r, i;
> +       u32 val;
>
>         /* init the CP */
>         WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
>                      adev->gfx.config.max_hw_contexts - 1);
>         WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
>
> +       if (!amdgpu_sriov_vf(adev)) {
> +               val =3D RREG32_SOC15(GC, 0, regCP_DEBUG_2);
> +               val =3D REG_SET_FIELD(val, CP_DEBUG_2, RB_PACKET_INJECTOR=
_DISABLE, 1);
> +               WREG32_SOC15(GC, 0, regCP_DEBUG_2, val);
> +               val =3D RREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL);
> +               val =3D REG_SET_FIELD(val, CPF_UTCL1_CNTL, VMID_RESET_MOD=
E, 1);
> +               WREG32_SOC15(GC, 0, regCPF_UTCL1_CNTL, val);
> +       }
> +
>         if (!amdgpu_async_gfx_ring)
>                 gfx_v11_0_cp_gfx_enable(adev, true);
>
> --
> 2.52.0
>
