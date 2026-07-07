Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2B3C44500
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 11:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC1D10E2C9;
	Tue,  7 Jul 2026 11:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VoDwfDV/";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C55110E2C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 11:02:41 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso4107059f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783422160; x=1784026960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+fmtT98uZzQVGA8vxU1FmKdk2jnMlEMMwuI9Mk+cKY=;
 b=VoDwfDV/FuVImbuTqcygPeyBExbAixEqfYeZfUZY0x74951aKDZNfxSEoJ5qIxLwsn
 xWdgNAW7Fdema8YEHhQCCibIlOSOzHtfsgQOuobpodvFOgUhzvxAZDmSfyGG47bQ9dJo
 i9YmEX9ajs+zK779dLZL8OAIK0iLBUbLIyFzA0zLMM5BiaG1ZYvxAoG21LINHZWMApYF
 6PYkj+SxSOT3Y1vuylMZuidhazk+pPvWWrVZmadKuuFQZHjbS5uMF+TsvUAdoETJmLXt
 8jKADk12rrNBYnbK/owowbBPQy6mlbpun7xn5ezE91ITezsnfE4onYBwrixuDnHwJrEl
 Ckvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783422160; x=1784026960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+fmtT98uZzQVGA8vxU1FmKdk2jnMlEMMwuI9Mk+cKY=;
 b=bJ4chA38iAJb4t/PsbAuEhFsJZgQClQinCalU7ErHB7bzPC93mhWzcQh+2768rZut3
 7Ag8XlDOdMUHUZqh/JkRZucKjxM0Bbwf6IRrWYLkOlwoIInqxdkGl/QB9lhuvv3R4X8b
 uMOcCXaPj3IC5lolI1uvtRqHIzDTuB/cD0XQY7VuRjEWKlc8PSs9/1G80wrIOpW5aDq8
 3Iogu0q2mncQmRzRkpZTSqcTzE9FuoXHHYWKNj+l7ftfmwwakWDhI9fX1IbCav3FANbW
 GHW/GsLB0dtj4dN/VWlzELb7sPRL+HM1F0IsMk3r5VjFaoUmAcQk/GIi+zam/tGDNKs+
 qkrw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9nlVxQ+0HdCK9Kd6al7o34Y0xaRIl1AdcTdTyD3kISA9MXDLShaG6MBnvzRzCmw6Vvfw3Adk/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF/aqFMJCva+nmXLSqJYvB/wVBeqC6E6q5uhX/pATeZm8+Q11Y
 yyU1DFKKIn0QICRKsmoKMHeLiHf2gT+9hXul/KZUriRyzBg6uQp/z9hh
X-Gm-Gg: AfdE7cmOonLo5GdE9+TE2o650lDQiXrz3flUg0Rw+y437XzqagrViRxWb9Rke4bbTfg
 +7vq3JZq4j4doFeILcG4Q2pKOB5EtVu68/wlAPr9BT7ld13K9yxBaWGLEiYxA2kZvhEMBn1dGkR
 VNIeRmbc3ffG8eOvLrMaVSisW49p4Tbcb621G+sR9LPOhF2EEV4VgBuJpO7aDjCZvHBimum7CDe
 3sQBsHdHv8RlHyqAoJNoB6BGmSW5Nwrl/tmCql5t8Gv3wTzBLFnRezLwoaAtcVX3+7fKO31gpbS
 Zn1VG6H8d+rQwcthn9mkdxCbI3cF3+8ozniQjOfFo4LHZbDLKrs/reBSpHSOLf6u0JRvGxvtm+9
 kCPIBvNUqxv1CFP9I46RbBOD7807s5zjV6hqSReRMoZm/m9b/BG+xPZt4IL41K7F0pyAbzTX/Gw
 1AzPeVicHbQna4eWZsUrW3bAZt/PsPKolWUIfonpIr0o67LEzLeyJup3mJcfh05ylRJ4lhrYG7P
 HVcrGubOVQQr2XvIoA=
X-Received: by 2002:a05:6000:ac8:b0:474:b9d1:321b with SMTP id
 ffacd0b85a97d-47de669bbdemr4084319f8f.6.1783422159661; 
 Tue, 07 Jul 2026 04:02:39 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm33426889f8f.5.2026.07.07.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:02:39 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
Date: Tue, 07 Jul 2026 13:02:37 +0200
Message-ID: <12766042.8bMQJbFj6T@timur-max>
In-Reply-To: <20260707093812.109176-1-marco.crivellari@suse.com>
References: <20260707093812.109176-1-marco.crivellari@suse.com>
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

On 2026. j=C3=BAlius 7., kedd 11:38:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Marco Crivellari=20
wrote:
> system_wq (per-CPU) and system_unbound_wq (unbound) are the older
> workqueue name, replaced by system_{percpu|dfl}_wq.
> The new workqueues have been introduced by:
>=20
>   128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>=20
> Usage of older workqueues will now trigger a pr_warn_once() because they =
are
> marked as deprecated as per commit:
>=20
>   64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}=
_wq
> is used")
>=20
> So change the used workqueue with the newer, keeping the same behavior.
>=20
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Nice catch, thank you Marco!

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c index 53be764968e4..95cceed4e971
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>  			 unsigned int num_dw)
>  {
>  	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry,=20
num_dw);
> -	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> +	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
>  }
>=20
>  /**




