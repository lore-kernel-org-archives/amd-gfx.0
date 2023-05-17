Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01D3C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 20:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AE010E272;
	Wed, 17 May 2023 20:54:41 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A6310E272
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 20:54:40 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ad13a1fbceso993419a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684356879; x=1686948879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9ybS5747TrLxWhO+UGfKOeKr5M2JdrwNugPqfSyBzA=;
 b=Yt8i5FhPQaFMgCOIhQuni6KApYBvC7mTfAIYlLsq+DPyfSkYvwAY/IhuanGKiO/F1Y
 AILeQRu32hGeU/a14n8kw5heIfum61fzLnTruQ0jy1O8Nbg8ZN01Kvih3y2PLjRFWGov
 9zGe7xLf0WCFEDAUfs1QgE712GKnQGam/JJJrQDrgQ2slSy9Sa7v0SuqazuOhMh8WUNZ
 xMqKcQN0hYTgWEA32Sl67VuWhaIq5rYF36uwY66TsDFN0muQUITFY4TTQ6vYgQGzsgHB
 P/GF3nQYqNOSaQzlr6AZW5vPrbeWpgMbHtb1THr1uqS6lUJRubqNZ0CbLo0NleGewAJi
 XdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684356879; x=1686948879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9ybS5747TrLxWhO+UGfKOeKr5M2JdrwNugPqfSyBzA=;
 b=aAVXAHn9KH1uO/wBX02g2KE9MTihpmgj9qKOzQQZe8EOiebUWnVafWi1HrwDLQofHJ
 ufe2exV56JOYnTPHEI5bxDvQMbJtELwJIXujhwcHQNgkg4zM6YVfXVduQALvTyLY4jKo
 04UPE/7qUMKE+zswGwo6ZQLGUD0JlY4cqkDP1RdUAy9GkESF56yU4SuTC8cybEha95CZ
 1TIKVUCkAQr8QcXR5pJIRuzO+rmkpLL6oaF2SRL724EgDnhCY4FLctogc17XMFd3YRcj
 Bof83VQ+LPmgEU09yTUJGNT6bvICrUZc3BHcubNqU3czrxMuWbf6ypg+FMMLrFsfxfPQ
 Ihrw==
X-Gm-Message-State: AC+VfDzjOQU4bXBFsOVSF4nkQBglbL7iiZsbJis9x2pob18XihSUaSOp
 Y8+t+4a6jWGrThSdRi5YrY/OWVfq2T3OVvUkjqGSIj4A
X-Google-Smtp-Source: ACHHUZ41TcfTJsUlHvxeUnwGxi7O1594RHeBa0uP2yN8tm5dOq9HuIySXtwQ56hRj8ibZck3D1fQyPr+sznD8d2zn50=
X-Received: by 2002:a05:6870:4c4:b0:196:27ad:510c with SMTP id
 u4-20020a05687004c400b0019627ad510cmr60862oam.41.1684356878962; Wed, 17 May
 2023 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230511092920.3039185-1-zhenguo.yin@amd.com>
In-Reply-To: <20230511092920.3039185-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 May 2023 16:54:27 -0400
Message-ID: <CADnq5_Ofq9tqeMgupaA_rFXMdZWXCAJFTbsnH286=U3_WjWjaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add entity error check in
 amdgpu_ctx_get_entity
To: ZhenGuo Yin <zhenguo.yin@amd.com>
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
Cc: Alexander.Deucher@amd.com, Monk.Liu@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org, jingwen.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 11, 2023 at 5:29=E2=80=AFAM ZhenGuo Yin <zhenguo.yin@amd.com> w=
rote:
>
> [Why]
> UMD is not aware of entity error, and will keep submitting jobs
> into the error entity.
>
> [How]
> Add entity error check when getting entity from ctx.
>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>

Looks correct to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index e3d047663d61..077e010e29d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -417,6 +417,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32=
 hw_ip, u32 instance,
>                           u32 ring, struct drm_sched_entity **entity)
>  {
>         int r;
> +       struct drm_sched_entity *ctx_entity;
>
>         if (hw_ip >=3D AMDGPU_HW_IP_NUM) {
>                 DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
> @@ -440,7 +441,14 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u3=
2 hw_ip, u32 instance,
>                         return r;
>         }
>
> -       *entity =3D &ctx->entities[hw_ip][ring]->entity;
> +       ctx_entity =3D &ctx->entities[hw_ip][ring]->entity;
> +       r =3D drm_sched_entity_error(ctx_entity);
> +       if (r) {
> +               DRM_DEBUG("error entity %p\n", ctx_entity);
> +               return r;
> +       }
> +
> +       *entity =3D ctx_entity;
>         return 0;
>  }
>
> --
> 2.35.1
>
