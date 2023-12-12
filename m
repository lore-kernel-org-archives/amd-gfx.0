Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45913C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 17:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D314F10E097;
	Tue, 12 Dec 2023 17:37:39 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFF510E097
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 17:37:37 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-20307e91258so412407fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702402656; x=1703007456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dFkhAJLiwIxHh++89ELP8nkjMv4+dq2MXQkC+Zq/D5A=;
 b=RYFOFrkLpwXnVjucPlvHpPlhSZLeAC/SwnHL9n6XtI9x7u9TGHInc/U1f9BNZnBu4R
 kBtcmKy795X4k3iTDOvlmjIqtz/a+oWTcHPfbLc3TVnl08/uQmSh3c6KOShxRJgG8ElK
 4hRgxBArX7kLqB5EcOGvhr5bh2stSM5ZUyWFmhvsNSa7UFlnSjFd5bVqVPHFw/mEzrxb
 gkdLkJJC6Ilo2X015TlaYVY4mCWKGeNm3KTdb9+VT+YZqb+DP4PA0ScKNGzSHmPtD2M1
 5g/m/oRcndEkh11K9Qob92U9qV8QpR8bTpaXeuS4OmE88DzZsnCrf4+xzmojSeu6c+LW
 o2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702402656; x=1703007456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFkhAJLiwIxHh++89ELP8nkjMv4+dq2MXQkC+Zq/D5A=;
 b=XkBhZ8KEbop/J2S7AZX0aB/FBGr6uJdjzAHpIL3PKkVfCdVjZs+Oga8+hE2Un0V4JG
 By9GKYZUj8DTty2YR0gW1BUoDlvxglIHvuxbhT1tA5HYQx9fl4obc+VFzkfS9FCLDKxu
 t0Osyyz/ejaxPGQpU77LVJKmfyJ07i0gGWKmtRifFXTRcuSkZnlyEV6BBCXo21YWVSh0
 q3yrrP8yvKIYvD0Lq2YfESGFJaKpj/2gpa7bxCR+0EeMNcJi18hvpLaSF/DX0/A0U48u
 WFhaeAcrbxl0W5EHBkLqLgFtd6X1Ff91mYeht9GSB4nY/uO4Vjd+5ONUfMOQBZP3yU2w
 nBQA==
X-Gm-Message-State: AOJu0Yyhx8fFe9Cycy5unxfTo0w/ygutCdlgLbgA9pTJzuIxXxswUp6S
 /YxnD646V/cEaZETGALZWSBuFCjGGhjlAm0JGnkKeKNe
X-Google-Smtp-Source: AGHT+IHbNuai8febFp3np72wUeHmNJ/19KfbQR7tOmYIP2/k2aQddFz47WSqta3wsev8dtguosgC398kKxfTgxPLWLM=
X-Received: by 2002:a05:6871:5ca:b0:1fb:75a:7794 with SMTP id
 v10-20020a05687105ca00b001fb075a7794mr6501323oan.69.1702402656451; Tue, 12
 Dec 2023 09:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20231212070916.141121-1-mario.limonciello@amd.com>
In-Reply-To: <20231212070916.141121-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Dec 2023 12:37:25 -0500
Message-ID: <CADnq5_MsKJVMya0n18oOmUFOyq8wYZwAAFuaA13KC-odT5N5Qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix a probing order problem on SDMA 2.4
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 12, 2023 at 12:30=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 751e293f2c99 ("drm/amd: Move microcode init from sw_init to
> early_init for SDMA v2.4") made a fateful mistake in
> `adev->sdma.num_instances` wasn't declared when sdma_v2_4_init_microcode(=
)
> was run. This caused probing to fail.
>
> Move the declaration to right before sdma_v2_4_init_microcode().
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3043
> Fixes: 751e293f2c99 ("drm/amd: Move microcode init from sw_init to early_=
init for SDMA v2.4")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

FWIW, looks like cik_sdma.c and sdma_v3_0.c never switched their
microcode init to early init.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index 45377a175250..8d5d86675a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -813,12 +813,12 @@ static int sdma_v2_4_early_init(void *handle)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         int r;
>
> +       adev->sdma.num_instances =3D SDMA_MAX_INSTANCE;
> +
>         r =3D sdma_v2_4_init_microcode(adev);
>         if (r)
>                 return r;
>
> -       adev->sdma.num_instances =3D SDMA_MAX_INSTANCE;
> -
>         sdma_v2_4_set_ring_funcs(adev);
>         sdma_v2_4_set_buffer_funcs(adev);
>         sdma_v2_4_set_vm_pte_funcs(adev);
> --
> 2.34.1
>
