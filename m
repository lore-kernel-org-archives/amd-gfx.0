Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB72CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 13:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4902710E11C;
	Tue, 17 Oct 2023 13:04:28 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EF010E11C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 13:04:26 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1e98e97c824so3378617fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697547865; x=1698152665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrwJDE+IqCEN+iFudADfo0tG2V0N7pnZawzIsGMcXP4=;
 b=YXceTxFXDO+Ozlwy427gVSuRdsXR9khstkfY5vk8w+01YkVQbaLMJtHHLB5fqsy2K5
 9QSlvAZMK6QlTFl+UvQ8i5UhnEzAPjiXSZlkO3GDV7f1J0WGvk9Q8eQF2+gU9aevaBWl
 iNHMuo7lJkiWOFvQWRA8Rw0Ydk0fD+dnUTkiNfsmOjMMGsy1n/55gxB5sfOLfW4XTpnV
 3CoqeoE7BqfgGtyL+Xx/Wnzg9ye4Nht3xhYN8/N7mapXxgAgNFLZBs+lSCXMA2mb4MfB
 w1xL6yNv+2Dm3d6lAtWusUfAA6xIuj0JrchniJyenyK3qho8C/PqpEFdnOaleBMjvC5F
 dYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547865; x=1698152665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrwJDE+IqCEN+iFudADfo0tG2V0N7pnZawzIsGMcXP4=;
 b=a0YEMJRiGfmAaAfZvKGO96EsIr9dXwD0CVgaYYg4G2s9laMjT4QsmYSJ2sSCTR5s8a
 UTyItQDGBEnN/tI16Mxa3UO2FlXQr6gBVAKA/MlI0+sV5fOnWgBk42kvG8CEwVck4EQB
 nQArXGxpeSnraE/BqSST2pFj6K9SoYcY7lwoBBv+Ej+0vBFfoomk5Oklf3nqEjeBg9xS
 ZuMzp6L9q9E2FhoVXBF/a2a8roYB8dTaS9kJpB7CIk9XjbbywOFeZXu+NIEjLvER+6rG
 uHEdNO6L2gZgjFU1ofOIddBxT+qwx5BZebbma6RZJHCzqktjwGLVtYXbKjLykOwDs1UK
 LV6w==
X-Gm-Message-State: AOJu0Yy2/pm7liJxzynTg9Thx0L20d7msAa9MDDktz9bFb/N4TWgCYM4
 XecRI0p1OBAUbdgxbtVTm2L5NsWIg33AaccrEb4=
X-Google-Smtp-Source: AGHT+IHFQdvDm/jdtx9dyd1iZQARdlFjMSfRlMrJnOjSBEsLK4achgZd9QTBGVEWh40Ck+egdzE9xnS2wJz4NVq6qD4=
X-Received: by 2002:a05:6870:134f:b0:1e9:88a0:a67f with SMTP id
 15-20020a056870134f00b001e988a0a67fmr998667oac.23.1697547864169; Tue, 17 Oct
 2023 06:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231017121015.1336786-1-christian.koenig@amd.com>
In-Reply-To: <20231017121015.1336786-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Oct 2023 09:04:13 -0400
Message-ID: <CADnq5_PY7RRL7Xp7Ju14yqBRBdBcxWuR0+H-ysDtZCZzdUrkXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: ignore duplicate BOs again
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 17, 2023 at 8:22=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Looks like RADV is actually hitting this.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index efdb1c48f431..d93a8961274c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r *p,
>         }
>
>         amdgpu_sync_create(&p->sync);
> -       drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
> +       drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
> +                     DRM_EXEC_IGNORE_DUPLICATES);
>         return 0;
>  }
>
> --
> 2.34.1
>
