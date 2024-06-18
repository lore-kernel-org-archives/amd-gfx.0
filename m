Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0BDC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 18:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CF710E1C1;
	Tue, 18 Jun 2024 18:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFGEg2st";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957D510E22C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 18:11:11 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-70b2421471aso1681996a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718734271; x=1719339071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orK2hQoEn+sTVLQo+4lDpKY04Bc16zKzhu8s0ct/Tr4=;
 b=eFGEg2stdTKMHz08bZKQiYiWlAbvEiVsasmN/JmVoESfZZfUaUk7ywy/4AZaxSSpMR
 yOz3bxa1LZUn0x41lr5Bnuigfb/feZ6tkUMMtCHO4ne+5OXz4CLZwSE71r9GZ/4xG24n
 WG2oobecXfhv1CC4iwD4h52imrsGzK5ItagrjEJ5N19V3YvkocvQ8pQT7vYXumyYZUfo
 IROamrX2HWtmCFZtAqKXwu1FZNcsGdh1VrXT+n55TbIwhyAkpKKqxuSjScJbMWGQgBlP
 7Bv3cpzCw79TAYjO13wOXWUzvKIbUzHKYTx3H3EJbuPS2ocWgJDXmxHLKCUR23H0nMo2
 Pusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718734271; x=1719339071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orK2hQoEn+sTVLQo+4lDpKY04Bc16zKzhu8s0ct/Tr4=;
 b=Rhi1mKxz2YolOZl544k0kHWxV10ZIiMt0Lw3A9uRAUKzHNnmY7EHWrubRYl6gzkh5+
 EcS1M4UzlsM5HfeQsvL7m0AdmPrGjelyS7pa7GwYkDV1Dv60WBcCaJcXRdSSbSH0eI1q
 YmBD7l5AukoD+04OMdnZ2pCQIvoiztJ/LKaqcK9fByWHs2FzCi7JV7qnSzaTNdTX3xND
 waHeguCPUOaRfjjxd+LDGV6wgQMnqrITzVzOEux9H42BbPcRYI6mZwQH9OWobGCKx6ZK
 3yOk4BxIF1dG4lDblRDv3/jwh/0f00gfReMNZfvpMWA2z6PBUfutoeR4ifCncXgs0TS+
 D3Vg==
X-Gm-Message-State: AOJu0YyxjRsY0h/fm+ui+VftBZj/FOf31iS52WAP6GhYulQJlKM9keln
 IvZbZFycY+L5T5cGmLzbAQ+ZcR9IME+MurB7qqOcEFx5a2GxzaeRTmKazzJCE4DH0wvPyXUlhj2
 d1giNKYiiotysZcWcDoipAVR5N0JVdw==
X-Google-Smtp-Source: AGHT+IEwmtGGCDP2g7Ac3GHfQxJsNPi06m4STuarNhzMmcuM/WNL2gfzzY12XEsgQbQRh7DiabP4y9JHBFGL6S+xeAg=
X-Received: by 2002:a17:90b:104c:b0:2c4:caa1:5e3c with SMTP id
 98e67ed59e1d1-2c7b57f3271mr536295a91.9.1718734271020; Tue, 18 Jun 2024
 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240618164305.24221-1-mario.limonciello@amd.com>
In-Reply-To: <20240618164305.24221-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jun 2024 14:10:58 -0400
Message-ID: <CADnq5_PoAJ9R-aa1VXAoWk2D74h1fxta2PYb7p2bt4o2S9O9oQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't initialize ISP hardware without FW
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Pratap Nirujogi <pratap.nirujogi@amd.com>
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

On Tue, Jun 18, 2024 at 2:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although designs may contain an ISP IP block, the camera might be a USB
> camera. Because of this the ISP firmware is considered optional from
> amdgpu.  However if the firmware doesn't get loaded the hardware should
> not be initialized.
>
> Adjust the return code for early init to ensure the IP block doesn't go
> through the other init and fini sequences. Also decrease the message
> about firmware load failure to debug so it's not as alarming to users.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_isp.c
> index 215bae809153..4766e99dd98f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -142,8 +142,8 @@ static int isp_early_init(void *handle)
>         isp->parent =3D adev->dev;
>
>         if (isp_load_fw_by_psp(adev)) {
> -               DRM_WARN("%s: isp fw load failed\n", __func__);
> -               return 0;
> +               DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
> +               return -ENOENT;
>         }
>
>         return 0;
> --
> 2.34.1
>
