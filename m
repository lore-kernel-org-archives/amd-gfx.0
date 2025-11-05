Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD8ACCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E1A10E784;
	Wed,  5 Nov 2025 15:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PDt7UQKB";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF82310E2D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:57:41 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7ab689d3fa0so5912b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Nov 2025 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762358261; x=1762963061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXaLWej6JfzIu9ssTcbdqMnbgJIM3exaMmR5oVYQD9Y=;
 b=PDt7UQKBemDwloUhNg5w1lPel6K95rOep639SrYl/bFRLQblSbDfM+QtxP3zkOue0v
 DmQmpxd+cqqX+6xjaoXOl24SxmWvayD15oxq/n0asv6nYMbPHiNNYaJrp3VIqZGwPm0g
 6xZC+ytDVTmsP0lhlfISiXOOPV3cYcAVOtDLhLvf7Z8N04P1q8XBcg/W1UJ991EWQ6WE
 A8WUH19u1VyF6rra5KkfsvWz7uupbedI6BjSimaIm5AGXJ/Xjxctl1PTjEQs0YS9NF9f
 ANl4EW/PHXxjEhj4AktCdQYzNidlsOStQg/qrd9L+X2OBUybjh/eNokklg8etYbdySN3
 qYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762358261; x=1762963061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXaLWej6JfzIu9ssTcbdqMnbgJIM3exaMmR5oVYQD9Y=;
 b=adk8mMn+ic8Cqp/viOlorRKIaAxb+sjJ7aEAbwWlF1bLfAbsDz9O3evivzO5nwyMF6
 pocuVSl3XmvfPzfWwbPEE7HrEDrgpIZBaYRgxEgzNEA13v4SmCI+03hIeDbHVulYoSFz
 QP0Mkf+IEhOjWaUbrpeB8KTLN8iPz3Swoo/XbAJBEgNTtlPRVZa9k/ZzYUhBdbq5nnT0
 k8WcSg/A3nxDwkVnwUSOoMddjTGj/6Nytjkk9eC01fyHaFjohflZjr8Y8j34bPXDnur1
 VP9rCaTTiOAxDdsI0w+ScjO94ZJGnpZH3vqcuj7fR4o0P6DEEZkGIJ6laQh3bIfVKfLz
 uc8A==
X-Gm-Message-State: AOJu0YyXWdt5JOWxQz0A7JBCy7T6BlvhaoVE8jG0xDwpt+QpeBLFYWvE
 C/rvV3SgT5fBdXhQFXaqhTKCRsQoPi8X9WJoeZIkqcZFZCdLEUz6smeCRCRDg7hmkgNdOMspRu/
 +L39GG1ejtKKKFTe418TD5dcFbnbaW8LIMw==
X-Gm-Gg: ASbGncsZe5E2gioI1QyrzE/Fx7Jl7/wEMVcnGFl1Z/kRtQCHdp6lqkYKy0NR4EsGhaL
 NcdeW/svvs0nBDJi6qnjJuXEvPPTNETqACqE6VROJ8puKB9aAxcLBIAiNikKvajCTQI32FyOVVp
 5KjgA/3rUggEHc7S9Km8WNrfJ1pubpOS6D6Pre2iA2JPYJ0Dv2NYV2yURbr9YlDV+LwXbERVOjF
 9fgb3tuVO0u0f3FazrNiERWFKsiB0TQkDo2bJXMqebVXkwhA4ECfCCcIntqwX4wzO1s8jU=
X-Google-Smtp-Source: AGHT+IE+JkS1rsR5g9jpChqK29ekNUzfW+nvYOQJkB2CnHpmKwZWG2hmsMfKOjn5REnp92Qgf4Yk6sBkOzuRGAEEHrA=
X-Received: by 2002:a05:6a20:c991:b0:345:3ef1:b477 with SMTP id
 adf61e73a8af0-34f86aff738mr2406931637.6.1762358261392; Wed, 05 Nov 2025
 07:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20251105154902.75998-1-mario.limonciello@amd.com>
In-Reply-To: <20251105154902.75998-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Nov 2025 10:57:29 -0500
X-Gm-Features: AWmQ_bmq22W77SgsaXOpkApDZVoUVDVX9SDJma3O4g-D-drL4so2U1RPQsNKzLs
Message-ID: <CADnq5_MczGsMu=8wrmbr0FJ0G9zscXTN=ZqGOTNg5CucstzB_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix suspend failure with secure display TA
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

On Wed, Nov 5, 2025 at 10:56=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit c760bcda83571 ("drm/amd: Check whether secure display TA loaded
> successfully") attempted to fix extra messages, but failed to port the
> cleanup that was in commit 5c6d52ff4b61e ("drm/amd: Don't try to enable
> secure display TA multiple times") to prevent multiple tries.
>
> Add that to the failure handling path even on a quick failure.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4679
> Fixes: c760bcda83571 ("drm/amd: Check whether secure display TA loaded su=
ccessfully")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 8c0e5d03de50..aa7987d0806c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2355,8 +2355,11 @@ static int psp_securedisplay_initialize(struct psp=
_context *psp)
>         if (!ret && !psp->securedisplay_context.context.resp_status) {
>                 psp->securedisplay_context.context.initialized =3D true;
>                 mutex_init(&psp->securedisplay_context.mutex);
> -       } else
> +       } else {
> +               /* don't try again */
> +               psp->securedisplay_context.context.bin_desc.size_bytes =
=3D 0;
>                 return ret;
> +       }
>
>         mutex_lock(&psp->securedisplay_context.mutex);
>
> --
> 2.51.2
>
