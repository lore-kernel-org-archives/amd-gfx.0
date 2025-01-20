Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C932CC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 15:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6030610E429;
	Mon, 20 Jan 2025 15:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qv54XgWw";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3C910E429
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 15:27:23 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso1007283a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737386783; x=1737991583; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIOJNHER7nUwRs2Yxfk41MxcMvaTTSdbJfpJ/koGoIA=;
 b=Qv54XgWw7T15G/m36NhBjlfByHrDTIfyE2b8xIesoMhYo4jas34//CW9smSgeK79Dg
 LNySFip1n9lxKAoEPVH5spwcuFd8gXsEQmVwZxpDTttxSnfizZkfF1bTegwYPPjBoqQ2
 97OegF99RSd5FFx1ky4yfP7tbbLt7bsNOlVBGHiXvSfUyL3VU8cUqK0Po8H3jzjTMkqm
 UA7h+JOO5x52fKbti9C0yXqlR6PUa/f539WwbApkTh8Rbu5khLhv7+cKaHdveUnh/OY1
 B8aq2ehndoDdmh91CQmqiEUYn8+OKkR39H+5WODzbbGRyu7vUgFXlpN3zaCt25MPNDDs
 PINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737386783; x=1737991583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIOJNHER7nUwRs2Yxfk41MxcMvaTTSdbJfpJ/koGoIA=;
 b=YrHlmQhTqLCgbFSopNV0CvcHza9v7MvYQyh/XL0NVgBpLsCVgB+USAt7WXFINMEn3w
 jS1GBNQHsE7dyh9t8BCi0GNfQNhc1jYKVI51xkni3o/QDccMxl666f5ngO9Dno6KuLnN
 1pboNvPdtpy47dDW5XInEMa37SvzhFdqYP4xLRy+pzGC0wruKYE/mBgg+rKCN7oqVGX+
 5fMto6dzG0iY9QGoP+/ppYE/YcR7wfmFssorP9hkqAi2kwZ5Km6RitHFMDngp8glC312
 KL2AUmTnASVME+Gsiw5DR5UOFobSRKD7cmQcvm3zpVP8xxsMFk+c6MxRB2WZRpFe3oXV
 AVjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1U76nW5TPpSbzDax2w4ogAmHRpJQLSTd6e6uT2ujy1WISiuQyImGjJFLB6mWysmc6isM/IuUq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRFDU4uI1jSydoxZbfTeWV4+5/xIhGmr5eNkTJBkDK+/LaI1Qt
 rCAZhsML/asNqUFvi2vn/CGEF3vp70nWkh57jm1UTPlwxareXmIR7zZ6miIRI0rQW8p7ZBOrT7k
 /fL08lQAYGiW1cezv9aQoATI164nqdg==
X-Gm-Gg: ASbGnctwrPVyqeyLN7MJtrhIULp7TwI0BhPnLtVY5whQ8FISQoD6aTbn7EFl/bct6qA
 RCnZVdVrehASfRPDfNpQ6xWeSvHUJnrs+9ZACdOGW9yZsy9QF1SI=
X-Google-Smtp-Source: AGHT+IFUapmv2543Si+Dg85jRKG1nD0X3tjUuOnC/Z0H0goAJJ/tMLmt0HBYsYHw9mysfV3APKEKPz4hOy3GvgBCsnw=
X-Received: by 2002:a17:90a:d883:b0:2ee:f1e3:fd0c with SMTP id
 98e67ed59e1d1-2f783295935mr7422006a91.8.1737386782885; Mon, 20 Jan 2025
 07:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20250120074126.971042-1-perry.yuan@amd.com>
In-Reply-To: <20250120074126.971042-1-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jan 2025 10:26:11 -0500
X-Gm-Features: AbW1kvYi2URjFzck7Kx87zxPvBeBzHnqcOB1CnQfF2yYvvdHcoxYYzh39o9j6T4
Message-ID: <CADnq5_N8RV7r7FzZMhrircJmP0DTAx_q56BsNYz6Oo1KCPN3SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix parameter compatibility issue in
 amdgpu_vkms_early_init
To: Perry Yuan <perry.yuan@amd.com>
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, 
 amd-gfx@lists.freedesktop.org, flora.cui@amd.com, bob.zhou@amd.com
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

On Mon, Jan 20, 2025 at 2:52=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> GCC raises a parameter compatibility error log for the
> amdgpu_vkms_early_init function because it previously accepted
> a generic `void *handle` parameter. This change updates the
> function signature to accept a specific `struct amdgpu_ip_block *`
> parameter instead.
>
> error log:
> /tmp/amd.fwXY79Rm/amd/amdgpu/amdgpu_vkms.c:805:16: error:
> initialization of =E2=80=98int (*)(struct amdgpu_ip_block *)=E2=80=99 fro=
m
> incompatible pointer type =E2=80=98int (*)(void *)=E2=80=99 [-Werror=3Din=
compatible-pointer-types]
> .early_init =3D amdgpu_vkms_early_init,
>
> Acked-by:  Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index 5530d4ead536..e958e1cd85e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -617,9 +617,9 @@ static const struct amdgpu_irq_src_funcs amdgpu_vkms_=
crtc_irq_funcs =3D {
>         .process =3D NULL,
>  };
>
> -static int amdgpu_vkms_early_init(void *handle)
> +static int amdgpu_vkms_early_init(struct amdgpu_ip_block *ip_block)
>  {
> -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       struct amdgpu_device *adev =3D ip_block->adev;
>
>         adev->crtc_irq.num_types =3D adev->mode_info.num_crtc;
>         adev->crtc_irq.funcs =3D &amdgpu_vkms_crtc_irq_funcs;
> --
> 2.34.1
>
