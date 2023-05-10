Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D5C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 12:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BFD10E493;
	Wed, 10 May 2023 12:44:09 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545FA10E493
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 12:44:08 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-394021fb9c1so796154b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683722647; x=1686314647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTa0hFCTzD176cuen+1SYddOaH5Eb8zq9V0V9arc5iE=;
 b=HRtE0kUHTPz6pxPVQolVwddOS9JzxIGU1/Hxlk4wDr2xALl0Uvf9KwpKuv0Sq7OwtM
 URGIQ1Sr1+SeLGR12EDzURGEiispnyEE2IxIBN6JmW0Zqn6tBlar88gcPfGLbmErMBaC
 3kq/K4BJmwURefucyW4nuLwY45alQxQTCZEDltSZcHVYlPaTwArPv25AEiBw4f30d21T
 1PN/Qo/bC9x2maLawixyO37/6DxIXwi6Z6yA5afK8pwn6zGSVxPkhbqbRUD3eQqUYdnY
 eYqj4m0azjTIowKwj3psiGzUmZQi5QiBn+2e7k5w/iXumubf7JsIIDKovu0SQ71SBAuZ
 omhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683722647; x=1686314647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTa0hFCTzD176cuen+1SYddOaH5Eb8zq9V0V9arc5iE=;
 b=BB3HN+aKOL0+luBvYgzdT7s0+vP+hl7aQmnDz9KB8UeVJGPLQAeaR6qqoqIvZgqkdO
 y08F0X6XZwaF/wU/MheSiIPVTgMwCpgQ2BWBdNm9He26z0ozCsJIJf3hX+nWOdm9Cmaz
 JCqNFaG27L6lSlVRbQ0VO2Izj8XKhsX8iVpg8T5MWzAvq27ONPmEePzcSHwQMNTzk99r
 ZAUF+bHL2MGxu3FKHKI6vFfq5/QNui+GhL8jz3y2/K2gkH9WVY4vBf6hk2weUbcmYPAg
 KrPHvMQn2JVOQc8+TEquFNOtBwNyq5vImTHgZ/riuwBnMg31QJqX7itgvCsvMhFPf5vC
 0xsg==
X-Gm-Message-State: AC+VfDxNYlSWPS0s7x/2OcjRgfLnAsYZH7Y1hKMP7pUPXcKy52Cpwxvw
 roMsThRrPNxL3IkFZ9RDJfToYUpdw94qBRUsBUc=
X-Google-Smtp-Source: ACHHUZ72Jqf7fw3KLfq27rX6UJfz3wr7ChKDGo0xvn16RRy92UCooOILe7PojJfocJlrFeunZHKIuNE5S7Xj7jitvjs=
X-Received: by 2002:a05:6808:3a86:b0:38d:fdf2:962e with SMTP id
 fb6-20020a0568083a8600b0038dfdf2962emr3094393oib.23.1683722646907; Wed, 10
 May 2023 05:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230510083730.1919231-1-yifan1.zhang@amd.com>
In-Reply-To: <20230510083730.1919231-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 May 2023 08:43:54 -0400
Message-ID: <CADnq5_O+pcpYSMy6VxuS6h7k8D+3UpQMDQdBBcj2Xjy-upPU8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org,
 Yogesh.Mohanmarimuthu@amd.com, Mario.Limonciello@amd.com,
 Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 10, 2023 at 4:38=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> gfx 11.0.4 range starts from 0x80.
>
> Fixes: 311d52367d0a ("drm/amdgpu: add soc21 common ip block support for G=
C 11.0.4")
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 0f82b8e83acb..6bff936a6e55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -711,7 +711,7 @@ static int soc21_common_early_init(void *handle)
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_GFX_PG |
>                         AMD_PG_SUPPORT_JPEG;
> -               adev->external_rev_id =3D adev->rev_id + 0x1;
> +               adev->external_rev_id =3D adev->rev_id + 0x80;
>                 break;
>
>         default:
> --
> 2.37.3
>
