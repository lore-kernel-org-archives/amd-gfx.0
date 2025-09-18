Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384F4CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6E410E04A;
	Thu, 18 Sep 2025 20:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NesMpc+3";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF0A10E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:56:55 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2699ef1b4e3so1492345ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758229015; x=1758833815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s09jth5p+lGgL0jCeeJUv3xmvZTAqkTZBsGpKSPJQJs=;
 b=NesMpc+3s4ep3an4vzap+95dkr1yD7xAP6D3YDD9+4RYNooz1m1DmvlrCwIDrVQHE0
 BDXE/NTjHcl3GQqwrs9zTX5s6QAZtfismnXoVeWy4Qr+v+cvgcbXqtvQtwZvznotOPhR
 7snh/PtAEHQNxHsFxbexizFr2MJ7Zoh2ONPvaakELTPU0zYlCkPQOqGRO4Ml8ykma5pE
 aKgI8uycWmY42ydCitxfFVNuMWclGu/eo8foIVUjfJuCWxNEPJPuerKChFWjV5jh58za
 WDDRnGcS2EEnznUsINUctGkY06AinVb13J1ilvLd3BgEufy4Z6IIxyGubjzGFj8rO2bB
 RJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758229015; x=1758833815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s09jth5p+lGgL0jCeeJUv3xmvZTAqkTZBsGpKSPJQJs=;
 b=UosKEbiSE6wr9ExZs0AxZclN5XftsBxGL1zESNH6pxqiOR+Vura54l49cXuk1UPVT6
 q79nfg1UaVRXlhztIpO0S/HUrAJ5zYJjFvCQAfCkmtWO/JFabDm3RDJkvNVfGVIsJSlY
 qiVXorhrcYtM9eo3NY3KibaxVbh4YZa0GIsV6qql3vqtFEarCSFClea5vQMHmT9ZNYsR
 8RSxLhKqSQYcRCqbZ5ryyC9GVTYng/DK8PcP5xqUlIcUoc2qdFrJfoqO5Tp2vjrHaxHN
 UYu4Lbxg73B3Dz+7IWEYxeGtJcMp9yQiM81bg0jSxb32vUFdV+xdaWjnCO0Icf8GYlDI
 c0qA==
X-Gm-Message-State: AOJu0YzH1mQ494MDgl0KpjQDplBq7ijLFT0HMGFcZGNADAVp53mNAZWv
 KStISEVDfk7QvU5n9AcctjWx0ZDzEmJfWBn9SnbXaZ6jTx8xn944VJ0ZPhUtav/UsHMwyzlfSSl
 98OksapxS5/qqSpBPCO6OIhpCzLg+t4g=
X-Gm-Gg: ASbGnctEfFdpy2XkhARnEIRFrbLYX5welGr9t74WR6rQwd/m/h5wyPZ6tfDGovnYRZb
 h1h+1mK9wCWgmry8CVneWVmiQGW5wL0unldnX6+QQYHLj/BVUOQcB2nOVuWxlL8+cX1XG3Ep7h4
 DVlpL2+q+P/ta/qQGjZP8++k1PYOhCzHwGlIG5NUs1qjyOLWF2JKF9GW9zZNuz9g1iQqDWV0/gY
 DUIOlkxQA4V3hAGQLWHtK+RjA==
X-Google-Smtp-Source: AGHT+IFH6WhUFh1ZiO6zIKBAbQoMWw0RSReLiVCg1y3kfKdC4SX579mBfZUXvYimVnsl0Eq7aoHUJ1jDHpnZzbYnMwk=
X-Received: by 2002:a17:902:f548:b0:25f:74a8:6893 with SMTP id
 d9443c01a7336-269ba499f2fmr6315585ad.5.1758229015403; Thu, 18 Sep 2025
 13:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-5-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:56:44 -0400
X-Gm-Features: AS18NWCXVJ_NGRRjCtz5LwsdCbv9Vbx6h5D1F_y85ph_oGG2MbWuxhBEyJ9Awxw
Message-ID: <CADnq5_OkbEs3X+JihVVXX09XA3+q-RO99Kr7nQesTsneEk_esA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] drm/amdgpu: add userq invalid VA query
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Sep 18, 2025 at 4:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq invalid VA query interface.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Move patches 1-3, and 5 to the end of the series so we can land the
validation changes before the query status changes.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 83f0ecdaa0b7..3b57352e523a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -577,6 +577,8 @@ amdgpu_userq_query_status(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
>         if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm)=
)
>                 args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_V=
RAMLOST;
>
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA)
> +               args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_I=
NVALID_VA;
>         mutex_unlock(&uq_mgr->userq_mutex);
>
>         return 0;
> --
> 2.34.1
>
