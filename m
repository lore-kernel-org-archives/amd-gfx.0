Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B67CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 15:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0826710E846;
	Wed,  8 Oct 2025 15:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djpIwtO1";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2314610E846
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 15:31:33 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-26808b24a00so12996865ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759937493; x=1760542293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jxBbME/wEBfbg53fHXMaJExmXR0Veo6KEoH0QJwv9c=;
 b=djpIwtO1YIGzMldd/gHikxM0glAG9/vO/w9pQI7dZX9IxhwjYPm29JMIQ0RibHh2wm
 kMmYwYgvH5J2UjijcefPYGADUY1Ef6+mzTbmIjXsYIxqLFPgDWja3v7+nDEuGb3bwecn
 TMvEODKEPRH2W/wAR2PcuilYFvyG9g1dcNgObTw2wWW51bFYhFYhECo3I+sE352ZBHGT
 bqwX7hdgLiY1QZa6uvTQ5DFabYhvsA8gHr2yuSzIsCi7NS7xyOUg2tUMM4ntPd3xnFES
 mOlposEqxzEH2la2rjp9CRUReCAkB5+mXumykHKrO3yEeC0srNotO6hPyMg1MDsDWElI
 wIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937493; x=1760542293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jxBbME/wEBfbg53fHXMaJExmXR0Veo6KEoH0QJwv9c=;
 b=OXOOyWkOYC5ty7mPi7yTm3s5F6XG2Wyd2/sfMfnSQx9sgOYwXd9lyJWUstokNVIbDD
 ySduhTDkQW77lawRX/2Zt6DyQ9GdpkFVvVuZAu8hnVXdJfZOEVRixosJQRI9+R5n22g6
 YvQahNm2O1Fidh9sNeb7PsVVptvSykp4qFPQFKVBRODBPFa257uj36wlAphcgSU/wrIi
 KwSTA2pU1DTT/2eiCmQblf+zbEidANKB8g25qnGFJUl+TS7BmFXQv5C+w7zUXG0vhUOs
 k/E2VHVq2LfavwD2Nu3/eqPm6T0/95CIu2cTxHlCAFgjAEC0i38OBKh1EFCLs9JoFtoB
 8P4Q==
X-Gm-Message-State: AOJu0YyxgHGKfpqMHxodXaQoMPUiyXltdk1gPqST2O+yLhS3F4DfuVK3
 pWxIh9spl01M7yXH10qHmQxXrMFbHTodxmUL11lT1BEOOFodiiE2PpOl0jFVg8jnL7c8X8Eqn2j
 SRoIY8Bkrs5oJWquQAuTjGycYvpT1dY6aiw==
X-Gm-Gg: ASbGncvOpN0YZ1a2y78yPCxyq8aQPDSH3xw+VKb5jZJX1G66IlLjXlK4WBKeizwH/bv
 CdIHuRMl0jfYSCXvqTMZXUZ8qUDRUtXyLOg/SVmcO16UQzJDr9RL519MesePD7ja8ZyCRLi2XWW
 cmRtZSp0GuejCPJC1UZRVBrN+I84GEYlek9BsTqx2sjDQf9krWbBQHgdBbJc2fIEW7XgZuHMe4f
 7fLpsP2zTqpKes20Wul4b6vpn/VHRa9g0sqcHfms3APSGVxR7qg
X-Google-Smtp-Source: AGHT+IGMBpI7Z6ORxH5JX7uqEcWsrRVQEFXQJa31dzmMSppUH6uuFf7tM4k5wQvXJhm9zS9wDk83M3Y4Q6e5GCLZI54=
X-Received: by 2002:a17:903:120a:b0:261:500a:5742 with SMTP id
 d9443c01a7336-290274555bcmr24054365ad.10.1759937492539; Wed, 08 Oct 2025
 08:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251002174245.1691343-1-mario.limonciello@amd.com>
 <20251002174245.1691343-2-mario.limonciello@amd.com>
In-Reply-To: <20251002174245.1691343-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 11:31:20 -0400
X-Gm-Features: AS18NWCvHxPxWCSgrNGJNL4epAo0vzMl4R5KZnnU68R6nb0BC-WC5AMMoZfIQXg
Message-ID: <CADnq5_P3wW=89cuFUgs493jdU1tHiovCLCTMv=ygNo=g3yXdBQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd: Unify shutdown() callback behavior
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Oct 2, 2025 at 1:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> The shutdown() callback uses amdgpu_ip_suspend() which doesn't notify
> drm clients during shutdown.  This could lead to hangs.
>
> [How]
> Change amdgpu_pci_shutdown() to call the same sequence as suspend/resume.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4905efa63ddc..e377fbb43e96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2558,7 +2558,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>          */
>         if (!amdgpu_passthrough(adev))
>                 adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
> -       amdgpu_device_ip_suspend(adev);
> +       amdgpu_device_prepare(dev);
> +       amdgpu_device_suspend(dev, true);

I think we did this before, but users complained that it took longer
to shut down their systems.

Alex

>         adev->mp1_state =3D PP_MP1_STATE_NONE;
>  }
>
> --
> 2.51.0
>
