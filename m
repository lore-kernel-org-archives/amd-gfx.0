Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA253C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 19:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730A210E1DA;
	Wed,  5 Feb 2025 19:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQUwFacZ";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA51310E1DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 19:13:50 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-21bb2c2a74dso434715ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2025 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738782830; x=1739387630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HrUYCovtZ7DPFvqjP/ux7vAwyc1nNJz8Gk1KCgxCwg=;
 b=PQUwFacZcelPxC42Nncanm5Y6zhxOsRJiU1QQqDzbhmGgs4/SSu8iKmWqRxfLeqNwN
 PFKmq9kA1a0Gt06Wah52NzvYvF4iJOK329/H+UhDRSVCR+GbkAZQmQemHy+ypjitiE9B
 g5DjIoWDHZzpQPt+g6CCuIu3bDGrYwMuGboWGl0ciPna8omgyCfIzJO0TPQLdFCjVZWE
 Lfw+LG6bJRbMMmd+yLTb3WzbL/mAtCz0vCgeN0lPWRC1tQUnF4mx78wdW4rfQ3vmeLZE
 0dX2ArP8qLSpWg+lNr6NJ9GfoPu2dRoEzrqpI1qHwXapjuVKwVpEJTvkOBCQPtuQxw1x
 sR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738782830; x=1739387630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HrUYCovtZ7DPFvqjP/ux7vAwyc1nNJz8Gk1KCgxCwg=;
 b=qxBWkOXOhTvgYzkltV0Z50Ia9kGNpOzpLd5WQsw1BVQxM1YBoM7uEAaqytC27QOs8c
 0SdymNPzRYY1nC4bY6XBH0s/iaoZJZCYgC+8Scsym5i8jOlSLZwbFhHXoiGUdvrvh6Ge
 L8CAMJjrltvkFOW/fJjZlUAZMVFRJpVs1c+yN2Hvz1ZtHcv1OvKPTak8ve3RiXw+DW6F
 h8QiO30hlx5697F/s25NbX8lhxb/sXzQ1jCtDULagjp+7Uos+6rayT3mX6qgxvdry7jN
 McoBMD7OBzSN9TCdEXoAbARB/Yjt+zNbTgkW6ykw8kyYAxEcjaBg3jvzE9FQzvGjIKCj
 aisQ==
X-Gm-Message-State: AOJu0YybkHIPrQEF6zG2p4xF7qYCQP2d5a2SMXa5RAjeVl+FL3ZJRivK
 5Swap6Q2gzJvfxn88/kv8HWauX/nDSANQK+ol0T94O58p4vYnSt84KLBM0tqtyGJXX61GDBDKh7
 0WmlKLjNy4fniFFHG5wCQcatktnk=
X-Gm-Gg: ASbGncsZVfHu9MyMdSPyQyBfqSnQWokZ3TONwumALBvXVzkhtn85y2CwzQNaeTGQN9V
 86yHTUfgkSay72g/D9ijMuRN/lkJ1R9IV9r/tZdepJjN7vGPZ3uIAWdtOO1CualRPrg4iTRN8
X-Google-Smtp-Source: AGHT+IHS62c2sjG+AlScxRxCh1W9ojKBbfmE59zx+wKpyYugwB0bIKrpwnpT+9UOBsG1lg0g4a0fipSv0Dn5yF8hx38=
X-Received: by 2002:a17:902:ce03:b0:20b:9b07:777a with SMTP id
 d9443c01a7336-21f17ebe96bmr25888045ad.10.1738782830299; Wed, 05 Feb 2025
 11:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20250205183738.103990-1-shaoyun.liu@amd.com>
In-Reply-To: <20250205183738.103990-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2025 14:13:38 -0500
X-Gm-Features: AWEUYZnNTm9MyInMU21qh6_4WvEyy95_G803GgO786q6lD5Ey9-XwnaZMG7NNtE
Message-ID: <CADnq5_OXOegZQ=iHJanfAi6K7ZhpdzccLe3eNcP-ceBTzKCNFA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/include : MES v11 and v12 API header update
To: Shaoyun Liu <shaoyun.liu@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Feb 5, 2025 at 1:57=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> wr=
ote:
>
> MES requires driver set cleaner_shader_fence_mc_addr
> for cleaner shader support.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index eb46cb10c24d..6b5cd347dfb5 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -266,7 +266,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
>                 };
>                 uint64_t                                                 =
       mes_info_ctx_mc_addr;
>                 uint32_t                                                 =
       mes_info_ctx_size;
> -               uint32_t                                                 =
       mes_kiq_unmap_timeout; // unit is 100ms
> +               uint64_t                                                 =
       reserved;
> +               uint64_t                                                 =
       cleaner_shader_fence_mc_addr;
>         };
>
>         uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index c9b2ca5cf75f..1938150a1943 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -278,6 +278,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
>                 uint32_t                            mes_debug_ctx_size;
>                 /* unit is 100ms */
>                 uint32_t                            mes_kiq_unmap_timeout=
;
> +               uint64_t                            reserved;
> +               uint64_t                            cleaner_shader_fence_=
mc_addr;
>         };
>
>         uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> --
> 2.34.1
>
