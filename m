Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623A3C001DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A1310E0A2;
	Wed, 26 Jul 2023 18:29:55 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9768E10E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:29:52 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bb1ec7945dso768024a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396192; x=1691000992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDFwZkCEhEdICE206oGKwvkWRDfjTW7Uf1X1o0OV8Pk=;
 b=bH3c/NA7p2MW3/3cS8a1KJoQU+gBjLJhbaPvs8TmT6JHlHx0eEsQ6woG4SG8BjVLUi
 w4mEnzEnpN/BXs0EKDvnce2AjKZnLvac9eY0uCPpE/ghGZbIcwtfCUVqLHA+Y3omJtDW
 c88Vv52zxz4TU5sCQLJEHPut3qVV6cZ9wZlDp4J6d1cUb2joXSI0GTEPWPYNmCkbtIX6
 WxI5gjIavYPYOeKTH+L9K/SLR7cf65SJMn/UUgogIT20CM9lwcPt3aAzOOyS6Vo++vvx
 MQgny6KYSEjqry3DwlpQMTKzaF0vlh5eBMSh6hwrAWXOBKpKjBgw+2RhZryk4mchpO09
 XXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396192; x=1691000992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDFwZkCEhEdICE206oGKwvkWRDfjTW7Uf1X1o0OV8Pk=;
 b=VjSvm71nDQag3poCBLNf6EMJ/EteuiPIPBwpQizApfdMaJcXZLMVMM+q9eSYc4slvS
 RrU9xwPITD4slVpcwjOqA+U0FAAwvGjs2dSRKzlI8mJA/EYowEeJfeI24bZRnhfGI4Hw
 rbf07kA7liowoWiQBSqckISo4+ra6QMSV/BRQMUgUi2dlNRnG8XoSagS6ICWNX0a65z2
 i2Ax09zp9ta3Alns7OE2LLuO7O8ROnkl8V7eXcFWX7xy5bSnabr/lM4f3ws0tZN0uWue
 THhNUjwPZo3xXqivb659dhDRrIEAQrS/ih4EdoKlaALblGrWnYYasmW86046HSVM+OQU
 o4+g==
X-Gm-Message-State: ABy/qLZz91u6M5ULlCTEFLFBRBQWhiNGG/soLMSGT1Jb24rnM1OXmJfK
 8uG8nXaQ5/f5LpI4l9MJIQ6joAJgzGRDvYX4s+KSeOKFEJo=
X-Google-Smtp-Source: APBJJlElVEYYSqCx+8db0PWtc+N0DeHDGDf8I4R7bkfIoDdlUUe6r3UhPZ3Pk1Zq0wWAhCv5ggSfq1REPTQuGKiOlsw=
X-Received: by 2002:a05:6830:3485:b0:6bb:307c:74ed with SMTP id
 c5-20020a056830348500b006bb307c74edmr378556otu.0.1690396191761; Wed, 26 Jul
 2023 11:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230726151459.2490598-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726151459.2490598-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:29:40 -0400
Message-ID: <CADnq5_N_09NuikQfE_KG66fWrYW0SwKZLaWeKb59hkpPn7bbtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use parentheses for sizeof *numa_info in
 'amdgpu_acpi_get_numa_info'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 26, 2023 at 11:15=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below:
>
> WARNING: sizeof *numa_info should be sizeof(*numa_info)
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 385c6acb5728..a5a2b06c6588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -868,7 +868,7 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_numa_=
info(uint32_t pxm)
>         if (!numa_info) {
>                 struct sysinfo info;
>
> -               numa_info =3D kzalloc(sizeof *numa_info, GFP_KERNEL);
> +               numa_info =3D kzalloc(sizeof(*numa_info), GFP_KERNEL);
>                 if (!numa_info)
>                         return NULL;
>
> --
> 2.25.1
>
