Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF3CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A131610E754;
	Tue,  2 Sep 2025 14:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVWDct4R";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC2F10E754
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:29:16 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2493798cd83so7213805ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756823356; x=1757428156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9JustDtG/7SuBPZM1Pd8GiQ4C7DFC9Au1IREAch/dk=;
 b=DVWDct4RBAV17x3OUdBZuqhCHFYfccqpDTIzw56TnRSkQArT94ssL3rFse15Uvd+6Y
 1fFrdc2EzW4cysEFifVrJlz0wuj6tNobwHPsP1ii5lRHZgBrRyLCiv4RWJ6zQoH3/S5S
 qms9CJAKl2+Hnzk1/Mt3pazRvnC1xkBaAeuENM7s792HsqLjVZn0YQf207QRArC5UTah
 biulGAzV0uNc5WW+RFx3qd5KEY44eKuJjBcSYGQTsr9ScmY8k+hwFrv8i3K6nIrXQRF8
 KJlJGL4MLsGWun8eYW+qtGw8xWV23lZ6V1xJXja6fc2WUKT/itgpcWd2b4iuRbSa4fMi
 eo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756823356; x=1757428156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9JustDtG/7SuBPZM1Pd8GiQ4C7DFC9Au1IREAch/dk=;
 b=c/dBnTpxZWMgOsQ8MAOZBVYhgRaNtuKgu4nG2cssXCC2PMyNRTO7mwH3zgwkpMrEZW
 y9NSzb+aad67spPUu4taWhEq6QLvGVBDu7l0UU8+N266bBJdAD15Sum43QMiTe7JefFQ
 J7vnmLMGTmXtGmPqWNLxerRfhD243q3TPeKWoslcmc2hSAbXgCaukGLCHzh/N+7GhTc9
 BoPMVyc+GuiQWlp9mL9lQ6bQpkMdMcZ2FZrrvby82RO63L0mOZo1fQ/KhBe9v3VhIdpC
 kZ1ZCgtCwvx+5x8/IWsGI9On5hs2/lb6SvE9xvxIUolmubh0tySfMx86xpye+JIZ2uDv
 kagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvpMtedQmi/4UDfd4X2vE4E+mqZ3l4qlABLBhM9fEbmSDgXl0gIvNz82GNOoRt40O5m+HqnQKc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7H78nhuYfsrK6i25WWrifQoM5hks+5kKw/M17Condn09Fibqu
 c1fhGchp0v4Ewo9Hf8yNOvJTw1K1hsvZjhn/4sc7qOscM1q/96rbmYBPiLFACtG6vTrMUKirfbG
 uNEzOZfDNbLPwArUbb80UYHbF9luywJk=
X-Gm-Gg: ASbGncsFD3NL7ohSEnvQKFswbrzWnwj4YIYZiflZel16D5qR0Swuq1bQiB2aD7RmLh+
 wGOLAXuZeO675xhpg9mkkMN496PDII7WcZGDR++k19vQiDx0KbzgRKNsLojarNf2vzjIdELgM/a
 dmDMImvEpN9098JZgDmEQbAS5nCRPs95oZEpPZo9FGFcl6a8th4b73E9QwzevUzF9j87gwri1D4
 YaVtFGUrVVY+p2mFQ==
X-Google-Smtp-Source: AGHT+IHGSOAdiwrxjdK+vunWNFm5ihUB1UHXWKFt4/ANjncXeKLkuzMcqIARqf+vg409wkDOXCPZcqUR/T3/wj8RrDY=
X-Received: by 2002:a17:903:22d1:b0:248:8a31:bf6f with SMTP id
 d9443c01a7336-2491eadb922mr112468645ad.4.1756823355670; Tue, 02 Sep 2025
 07:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250831100321.400238-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250831100321.400238-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 10:29:04 -0400
X-Gm-Features: Ac12FXyJBWUfEp3KqFO4gFqjLkJUKTFr12rCw6JeJaQUdFgrf-c30u-de7lycWw
Message-ID: <CADnq5_M9yaghNRMV470CDB6c9i_kLYY_00QaugH-_O5VpkLjJA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Correct misnamed function in amdgpu_gem.c
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

On Sun, Aug 31, 2025 at 6:53=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The header comment above amdgpu_gem_list_handles_ioctl referenced
> drm_amdgpu_gem_list_handles_ioctl. Update the comment to reflect the
> actual function identifier to avoid misleading prototype warnings.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:1106: warning: expecting prototyp=
e for drm_amdgpu_gem_list_handles_ioctl(). Prototype was for amdgpu_gem_lis=
t_handles_ioctl() instead
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 4f4f8b0bde05..a07fe5c9ccec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,7 +1087,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, voi=
d *data,
>  }
>
>  /**
> - * drm_amdgpu_gem_list_handles_ioctl - get information about a process' =
buffer objects
> + * amdgpu_gem_list_handles_ioctl - get information about a process' buff=
er objects
>   *
>   * @dev: drm device pointer
>   * @data: drm_amdgpu_gem_list_handles
> --
> 2.34.1
>
