Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E81CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 14:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E463710E7AB;
	Wed, 22 Oct 2025 14:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JzFm2y15";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21CC10E7AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:08:08 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b6a42754723so236098a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761142088; x=1761746888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxWecD44n8F7A68MtB2Gk3SGRDfmDIC8qrgGGOx9IvQ=;
 b=JzFm2y15gzaqngtYJeuEXuDTCeDmCVz9dMyBnhT+ED/crIewLyewD1pQrWvq/9ANOf
 Q2BbhmtSWkxRCJs3/EaNkPsWa2QgJ0s+YgHlLEfnJ2ubZh4wXsWZ4PFD1Nq9sFqfv+7q
 0viCMeqHfmRgtlirqOiJuU9GvetRGlX7slbT+hwoX30/LHNggRp34RC7TEU6hQ+ocYyC
 u0BTx3FvQREel1kdL1IY3ELR3z0mfxWdQx1wjRtT3u7rhWkGq3oDJzQHNnC0pnm0dVYG
 oRV3EcdRCLaRqCQi6MM0HeV3CHzkb3d6w7KC85PJ52jJFv8dABnxUAc6LzI/QvMKXRyO
 P/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761142088; x=1761746888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxWecD44n8F7A68MtB2Gk3SGRDfmDIC8qrgGGOx9IvQ=;
 b=TkUi8bCmqa6tyDlSbqD8oKV6lsEsYrG1p/qpgSmvNtQad18JI40KJcnL7l4VVHcUJ9
 8cOk4V0sRUUoX6lOo3Rcx5gRIRuSPT+csi0Z60BCniaBpFCXMl2kB3xBv5rmyGOibGk3
 /iZ+HRkIX+ktTrB3L1wURQ9UGV571xr534/5jPqcnIphT0AEsEoePP1kvbWeCwN/Hvwy
 zPDRI5RyNrYOw2u+kq352qcw2q9zj+aS/X9yYq8HdlI5UchJrMw7MxrHdZohq+vDj3I5
 SHpdFjJxmCzK8ug6eHPSEgdkOo/h9XExy+XA9tInrrWTOliwovxsnk8FwTNap9Az18TE
 ZrMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk0MDPKMPZ7U/48Il8xqnHIr0lqEFghQO0ibmJgsW7yP2aGmpTPEzPAk1hsphu2253P83fXPX1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXFuBRr+OtacANvrwkG6Oeq6i5GE7KRL+8wnhXvlyph7tTbZlz
 4RTQabETS0xz7YEBTY1WEDR7EIg9lpqP1LpR2VYzd2+ysyqvm6k5CfMeRC3+fzy7z0b2Wb3x0ef
 lPIyqKZlz+exzwVWZcvi1ZjxHs330GAs=
X-Gm-Gg: ASbGnctMJnCNAdUvf+s+16mL91UhVISzZBfz8tvCJ+UGYnto7ZgYJM4MW/7q4YcgZFe
 GAks0dt5waMucOIF94o4xU+gWRUEuoWFknRCWIFm06iLDvJkeEKyOy0pF3LSoGUQUcFIZZxc8/M
 earNgJChCtlt9i9Pmce/LarGpwC29I506PZav1yfW7kWDIQSHbCbDeU4LBcs6mBzQSlw75mk2GZ
 SOoJfp8rB1QrIQeqREdLeqsuyPvKKqG8jVGc2Gt1ae7yNtuMgqUSVkC6QtC
X-Google-Smtp-Source: AGHT+IGM3mvFgkHnTG7QRIj/Gmy3p+LRuhhPAH5vukdmhYx7TsNqfkR+YhVrgCxY2EWb4hIpzDcGres9mluYuxqKhfc=
X-Received: by 2002:a17:903:120b:b0:28d:1904:6e77 with SMTP id
 d9443c01a7336-290c9d26917mr126853125ad.3.1761142087899; Wed, 22 Oct 2025
 07:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <aPi5_CILMKn3ZrVd@stanley.mountain>
In-Reply-To: <aPi5_CILMKn3ZrVd@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Oct 2025 10:07:56 -0400
X-Gm-Features: AS18NWBdUcj9BuAc7F-BssClfHNNkfo9ryZDxZvVPhEuoCs-u5I60K5betUL5-0
Message-ID: <CADnq5_MoG0s7K5wCaf8-32SWCnOeaPkYvDCyixem_w_jVBbgag@mail.gmail.com>
Subject: Re: [PATCH next] drm/amdgpu/userqueue: Fix use after free in
 amdgpu_userq_buffer_vas_list_cleanup()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, 
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
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

Applied.  Thanks!

Alex

On Wed, Oct 22, 2025 at 9:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The amdgpu_userq_buffer_va_list_del() function frees "va_cursor" but it
> is dereferenced on the next line when we print the debug message.  Print
> the debug message first and then free it.
>
> Fixes: 2a28f9665dca ("drm/amdgpu: track the userq bo va for its obj manag=
ement")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9d4751a39c20..2200e0bbf040 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -159,9 +159,9 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struc=
t amdgpu_device *adev,
>                         r =3D -EINVAL;
>                         goto err;
>                 }
> -               amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>                 dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>                         queue, va_cursor->gpu_addr);
> +               amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>         }
>  err:
>         amdgpu_bo_unreserve(queue->vm->root.bo);
> --
> 2.51.0
>
