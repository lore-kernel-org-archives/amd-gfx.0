Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB47C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E83C10EE9B;
	Thu, 30 Mar 2023 14:33:59 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C0110EE8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:33:57 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-17aa62d0a4aso19927335fac.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680186836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSOCGSCjoG3XyGC9A1TzvVuKLLOgq+BswXoKiGJuUto=;
 b=N1++zht02XP0+sTaspGqiFUilhAk1hKTLYNtj9lwwEMb8xZ4Gf0/8t1W80+UcMaKIe
 WLOjswo99wdHDubliBAGXzeCBHJDzstQHeFywTPjNtI3uUzfb7XRpEDYq6cz9t8HVM4d
 4fb2qDVgJNu10gtOyHMSIfPfinFdDCmH0FldzpRZPkDEnsg++6tbP2vBOksn6xrPHFJx
 5pt8k3eJY6G9Z211jrzS5gxanXsVzR//7QaaoZhPwYTwSLuCUWlueP0FuuO7VsGl9vsu
 5L1JnJbb//Iea1LhcFpzTwIGYT30ymhh9oCHSTi2I7hyzAPMIRXkis7uiR4m0Y/JWthQ
 TXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680186836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSOCGSCjoG3XyGC9A1TzvVuKLLOgq+BswXoKiGJuUto=;
 b=i5xkwO8A2P1ejwIyoXsDb+cM0sBs6ezUvr/xc1kT0WmgfLM1NK6chgOpOmoUUhXWVS
 qNYWLT1u5vubF2XAwQj/QJ4LiPqNLx6CqFRNWv5SgpvhDqOE9w24g2E6bVj1nJ1nNIN1
 suUI+uqJu2+NIGth6jchqh36nQLjRZq+iKsb/JvASUoR5XUTaaslpR3J9Idjz/YFOHgh
 2ejRCT+QDpVXaKTzzcP2IS2R7Ig6iVabVyfg+6l2H08CY0tsfCdQwGJqHMavCrE/PWcY
 dfRE5ZMaflw7Z0PNSLX1QvHa1Lxyd/BOmOWDoPdC0BvIzTFbOkBqIHsIVwcakiq+MKZn
 UcqQ==
X-Gm-Message-State: AO0yUKVBQncGzZhlMvtKR9h/R7GTNosXN+of/CO4zS9HVu0eOEfm+z5V
 0SHScWWQylmQPf7Gp2sR+IoR1D+gTdqZ+Llv7wdxOPeZ
X-Google-Smtp-Source: AKy350Y5JnM6JcSgpgR7uMpRJMGWaQzQJhh/pcsSKpJAhvoVlZRxucCCNFf3BQaNlprJRks/huaKREc72D/TQK10YjU=
X-Received: by 2002:a05:6871:a816:b0:17e:2729:ce4 with SMTP id
 wl22-20020a056871a81600b0017e27290ce4mr5846822oab.3.1680186836385; Thu, 30
 Mar 2023 07:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-9-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-9-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:33:45 -0400
Message-ID: <CADnq5_NAo3mFUrGX3OH++RRAzjkModPnTsV+w8CAgF5QgKcaOQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/amdgpu: initialize ttm for doorbells
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch initialzes the ttm resource manager for doorbells.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6f61491ef3dd..203d77a20507 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1858,6 +1858,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
>                  (unsigned)(gtt_size / (1024 * 1024)));
>
> +       /* Initiailize doorbell pool on PCI BAR */
> +       r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL,
> +                                   DIV_ROUND_UP(adev->doorbell.size, PAG=
E_SIZE));

In practice this would never be an issue since the PCI BAR is always
at least 2M, but I think we probably don't want to round up here?  I
guess large pages would be a problem, but so would going beyond the
BAR.

Alex

> +       if (r) {
> +               DRM_ERROR("Failed initializing doorbell heap. \n");
> +               return r;
> +       }
> +
>         /* Initialize preemptible memory pool */
>         r =3D amdgpu_preempt_mgr_init(adev);
>         if (r) {
> --
> 2.40.0
>
