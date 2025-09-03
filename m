Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E09CA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 22:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B749910E20D;
	Wed,  3 Sep 2025 22:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qjxks2w9";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E0710E20D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 22:47:24 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-24b132bd90dso664085ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Sep 2025 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756939643; x=1757544443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwY7T6U+AgZ18nT9zgsWVRG2QaaWUuwUhXYsGBCiKf4=;
 b=Qjxks2w9ZSFQa5UKjHwqF5gT2voQIHDevWJ064FXsaBp2gvkXgxJz739bd/gH9r16W
 xbT5v/CTL40SW8N6lsEEmuEQ+8QdnDXoQySS9VF5ZI/dQd/99QkQdzMjbetzQt8YTgGe
 0I7lm1PrG/PVpXxoz3YPUX9HY/8bFb5IVL2lo7pG3pxlprMsgmi9P2ABc4xIGvkRYszz
 tCh+gfbHcSjRagXsq0OMnB14gr4Uz331wRl/s+vkJ7Vwurz+ZOW5Y+U2P8SdasE1Xjfk
 Kydw4P1a1AhdCv00dcDMelbGsdTubOaHXHmyF/DhmGfo0ZOwxJPtJWagAfROv45E6GKz
 l2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756939643; x=1757544443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fwY7T6U+AgZ18nT9zgsWVRG2QaaWUuwUhXYsGBCiKf4=;
 b=xLenO63MI2z4xaU6tDTTeXhoD9XLodl2Cj4gQIInJQu/q7ifYJF13wc2B0K/hJzPDX
 39u0SCCzf1c09vjLJeooeu4hHEQhHQKGd3aSYKlGoCogq6HMtzq7v9QKKCNAmT6mx0jn
 XWA4lWTedmx6XCQxnyec2asaQ3OynpiAjJtU+gGLIfJuzYavOP1CjLiU3FaJpnBUK9IG
 JCSiVKY4+t13SZGQP9slXrCOJQnN+hh6GRILKsmy+C/3JgbGIpIMMeZPAEUQ9KWy1YG9
 17BYlRrVdx5CEoPwdkSxnv7ZO70ExI+Aa6kA+vL8Q+hSn6CCHdvnyvvKR5q/C+OCOzDv
 ifLA==
X-Gm-Message-State: AOJu0Ywe/1DcMguiK0JLSRH8AmrVDiZYYVkeP1bzqdsSBbf83dCjzHFP
 7dO5/Myu3rQkfiqKicH5y3xRP27lhPS5s2Q0rM91YYtJZ71IDwzJCXmlvDpqQapeFGK/+j4kqeu
 UPOIjyd6kGu2td9ym1COtt+7eFkdEkgc=
X-Gm-Gg: ASbGnct0lqmGM6H6tjh5+qJULlluEUP5yGg+9/HuivA9NDT0L9zWLS2ppXdkYd+tZ6N
 CqoQ5dYHdebiXDRLSzaHRKsS0wyrwn2xeW0DmFxoSabWnqzQp8qZOr7RGkOKvWvQNyZbjVxUaG7
 tIZu+yJDd+mDR1Hm2agTAdX7ZhvSuQ/Bm29WJHCiU98AvhHynCecXMK66tLUb+jB3moPzxkLRYP
 XPEV1pnLchzo0APkg==
X-Google-Smtp-Source: AGHT+IFSeFivsEaCZ3y0bXtwZn933PqJ4BxJZ4OtzbR+qUc/En0IY121v8DIyu41YssPZYm5fAeDZKAgLmD1b1IjTeE=
X-Received: by 2002:a17:902:dac3:b0:24c:b39f:bac2 with SMTP id
 d9443c01a7336-24cb39fbd68mr12261045ad.1.1756939643380; Wed, 03 Sep 2025
 15:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250903083914.2604482-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Sep 2025 18:47:11 -0400
X-Gm-Features: Ac12FXzFIytWFj0_Qohb_UYW98hZJM8u8lUMQtFd7HP2X5bOtUcWDK9HfBoWpWU
Message-ID: <CADnq5_Nv017Tr+1b2WXO3=v8z5NZsRwQyhnKYdBgQsrdiedjYA@mail.gmail.com>
Subject: Re: [v14 01/11] drm/amdgpu: Add preempt and restore callbacks to
 userq funcs
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

Patches 1, 3, 4, 5, 6, 7, 8, 9 look good to me.  I think those can
land.  Just a minor comment on patch 2.

Alex

On Wed, Sep 3, 2025 at 4:59=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Add two new function pointers to struct amdgpu_userq_funcs:
> - preempt: To handle preemption of user mode queues
> - restore: To restore preempted user mode queues
>
> These callbacks will allow the driver to properly manage queue
> preemption and restoration when needed, such as during context
> switching or priority changes.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..5111d7dce86f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
>                      struct amdgpu_usermode_queue *queue);
>         int (*map)(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_usermode_queue *queue);
> +       int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
> +                  struct amdgpu_usermode_queue *queue);
> +       int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
> +                  struct amdgpu_usermode_queue *queue);
>  };
>
>  /* Usermode queues for gfx */
> --
> 2.49.0
>
