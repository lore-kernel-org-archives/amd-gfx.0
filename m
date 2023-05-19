Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7648C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 12:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660FB10E03D;
	Fri, 19 May 2023 12:16:16 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D55810E5FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 12:16:14 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30959c0dfd6so297289f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1684498572; x=1687090572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3+sYfreO1O7h5wERVdZ5iNThrMcs4OjDSlwhhU2ZyyI=;
 b=wY1mr2MGyfgIqN5z/VChWB4IVyqQa7+9USHl28FRq5rj5NHFBEbyrM1uVz0qFG6Zu+
 LE0ViPudqVJvN6Uhn/VpqUICrynkdPZkHWcq4NLMnh/QKW/lpK+TJ0TDhQyUB7Fqs2/P
 1eqFyrnmZ7UHCCq3ixfMEeEoI7xMj+UE8WlZ14eSSy72R3lUtZ5PSxyMktyWtpiMAjpF
 RcQflmehyEwYZL7kjfOFXcjpAnjXPW8GM+Hr2/CWmZLKOTbX6CLH1lfxXfYK4csK+Kfb
 t+VeMvp+DjRYqKVb77QGGEr289lBVqnIgY2JlBpQ/Yn57XZzH0zndB2JzEUXsiv/qj8r
 wGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684498572; x=1687090572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+sYfreO1O7h5wERVdZ5iNThrMcs4OjDSlwhhU2ZyyI=;
 b=gYoEHSXn90pJmoJJZRzdkSFFpNAgWAdk1YselTwtikCDbfhtIERSIhlaTiog4/DpgQ
 87S7hDUIdRMhGXxgGQYiI1aQx6/DBSICKZL+Ri9ZjI64lm/x05zpqzuJekdnlTsvBp2D
 /DCnH/ChOGOfeyh8IlZdKILlfAgIY93kxh7OXjLfhR/oxo5SOAkKogp6mfaexmxC81qB
 ONuO8RlZLuW5aC+CfTZzhVgrO7VpvUjHhOxd8lvTnp7PuBGzZbtWaXPuMFlUof7Pxayv
 dSRE/+N5ckp1IYKfftd3eq/3JvFYzeiM6WuZdcrsKln5gW57AWjkyzlxJNQh6PVPWzYh
 8KVA==
X-Gm-Message-State: AC+VfDwLCe4PWrWPgkxF6N31yi+XjMRYlFWp5Dd1P1Yvfmim1M9AW6KK
 y6pM6gBVw2Iw1kaidAAIfL55WYF5kO0rpJUY2oDH5g==
X-Google-Smtp-Source: ACHHUZ7F8jB0WcXbJjvPnmVADsKtKI6X4uZQCEzufPVHt+SoSv3A/qtx6uiZwGmzj7dJ72caxa08Q7Y8C/xcfc40pp0=
X-Received: by 2002:adf:db51:0:b0:309:48b3:3ad6 with SMTP id
 f17-20020adfdb51000000b0030948b33ad6mr1610046wrj.47.1684498572457; Fri, 19
 May 2023 05:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
 <20230510212333.2071373-6-alexander.deucher@amd.com>
In-Reply-To: <20230510212333.2071373-6-alexander.deucher@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Fri, 19 May 2023 13:16:01 +0100
Message-ID: <CAHbf0-GBC+4uPm=QCaH4a8FT56AnRJy-_wwMQ6z9q0mv3nr77w@mail.gmail.com>
Subject: Re: [PATCH 06/29] drm/amdgpu: keep amdgpu_ctx_mgr in ctx structure
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: James Zhu <James.Zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 10 May 2023 at 22:24, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> From: James Zhu <James.Zhu@amd.com>
>
> Keep amdgpu_ctx_mgr in ctx structure to track fpriv.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Acked-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e3d047663d61..06d68a08251a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -332,6 +332,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>         else
>                 ctx->stable_pstate = current_stable_pstate;
>
> +       ctx->ctx_mgr = &(fpriv->ctx_mgr);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 5fd79f94e2d0..85376baaa92f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>         unsigned long                   ras_counter_ce;
>         unsigned long                   ras_counter_ue;
>         uint32_t                        stable_pstate;
> +       struct amdgpu_ctx_mgr           *ctx_mgr;
>  };
>
>  struct amdgpu_ctx_mgr {
> --
> 2.40.1
>

Hi

This isn't compiling for me with clang 16

drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:348:19: error: use of
undeclared identifier 'fpriv'
       ctx->ctx_mgr = &(fpriv->ctx_mgr);
                        ^
1 error generated.

Cheers

Mike
