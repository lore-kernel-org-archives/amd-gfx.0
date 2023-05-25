Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35DC77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 20:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5B710E1A3;
	Thu, 25 May 2023 20:26:36 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A198B10E1A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 20:26:35 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5559cd68b67so33203eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685046394; x=1687638394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsAwZ6MlQd1i6BvSMv+ZEkDU4RWS+Q6FS0WsiS3bZkI=;
 b=qsYPbqhB2kAXQZL2IrYIFdPRM2Ds1UqGWA716jFwtb/KrV2z1TlScvsxqST8Bvqtz7
 Afbegl00x0MaN4QAupBlxQuXiIHNXEonVcn9sxNsK7CIh2fNfzaEKs/RAdrgcEIA0Qru
 7G6hlWivg6Zrrsr4/Gs5brZaasAUVYtSLj2NKe9AxYl/zPWipjsC0V31pxaCYY07KuJq
 pGRrA/1+nFIuyzZBpJloEWSJgTJjmaAfjTarhFtRFlaCsvN2ZnCCQy97BGnvSCKY3EfX
 kPr309CGrSwNsjhfH6MDTmJBWx+AEZwENruIFE5trbJszzCEBd72PShUDIMpH67CmOQr
 p3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685046394; x=1687638394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsAwZ6MlQd1i6BvSMv+ZEkDU4RWS+Q6FS0WsiS3bZkI=;
 b=Aq3SXvzxUMvfp4J3gU0V/Sxza0ot1i+tsJZL9bz+A4SfGrmg+nr7SdOvosUObZJfRy
 MZnpqG7xC9Azf5qhvE4ZuUqEOUom5FgDO/NPAnTzc0k2f8ZxnVxGfswy4V6nw3YIYq7d
 nqZnze0At8gVRXMM3m7hip5AYPlRsMqbOggelsBQKnA+hJWUT0lmloAtgV6/LyeqEBzE
 mGnAbkwkwxq5ATnxi4Mov1Pnpfw3IzqXq565OiIwA2yIQ0tzTIBrVLHz9QUBdWmTv1kr
 M99HkOju/cYwf/Lwq+EAH43VfRTMy2ltlMxWdJASrFEcetlnpiCHG4V/cwuq0Lkj9dwM
 EvNw==
X-Gm-Message-State: AC+VfDwCtl8eVHAtAjLnCibQMI8VyyAUS5Axj3ObX691af6eCh55NcU3
 df0tg2BJb7Cmoa+wTMKpHIM6W+O3S9g3741JAnw=
X-Google-Smtp-Source: ACHHUZ6ftDcsxTtKxLfADhOzZqIpgZ4Z5SGZAPm/xWdjj9fi9BX6gtk/XsGYdjAO6zWZVqe2Jd/X+nOf2BzEsVPfA0s=
X-Received: by 2002:a4a:d28a:0:b0:555:722e:3ce with SMTP id
 h10-20020a4ad28a000000b00555722e03cemr6108124oos.9.1685046394150; Thu, 25 May
 2023 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230525180253.831726-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230525180253.831726-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 May 2023 16:26:23 -0400
Message-ID: <CADnq5_MVCbfo6933-4XLGT5UzFNVC3EnDo0MtZ2LQCihh5=08Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix up kdoc in amdgpu_acpi.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 2:03=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix these warnings by adding & deleting the deviant arguments.
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:906: warning: Function parameter=
 or member 'numa_info' not described in 'amdgpu_acpi_get_node_id'
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:906: warning: Excess function pa=
rameter 'nid' description in 'amdgpu_acpi_get_node_id'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index b050d462b2f3..3a6b2e2089f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -894,7 +894,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_=
info(uint32_t pxm)
>   * acpi device handle
>   *
>   * @handle: acpi handle
> - * @nid: NUMA Node id returned by the platform firmware
> + * @numa_info: amdgpu_numa_info structure holding numa information
>   *
>   * Queries the ACPI interface to fetch the corresponding NUMA Node ID fo=
r a
>   * given amdgpu acpi device.
> --
> 2.25.1
>
