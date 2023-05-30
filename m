Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18250C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A542810E3A7;
	Tue, 30 May 2023 15:28:02 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFEB10E3A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:28:01 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-19f268b1d83so2992484fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685460481; x=1688052481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfpaTZ7WvCfWqAjwTaagTPzHc/LAiu/m4nhHDv6s0W4=;
 b=pqf6aLB1lai3Z43Qj34RHuUxb7XTGLaWYI3AH0dNyynqrWQaQuxLIU+VHQVE/VdcUB
 caDyrdgcLuJlP04AMAtrFbabO3s1F3WNO0NqnC46jrr9abfqGraY2PZfA00Roxldap5W
 qZP9Dau4trUQoZMqcUtDhG4dwLURQCsIvXsQUgkkp78iB/jchde7NAP8uzzuNfjuCcQF
 HqhNHThEZ5a4JbDBIf1CjPScGd1QFMuL4NO7gDgpNB6pMng2TgJV04xVWcIyvdpTaH03
 wkHtW9EWQBZdEKIltpOkIdC1en9ctxew93LSO7EgkgWQ0JOS/qWjZsA4zc0kDvLWFHRa
 3zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460481; x=1688052481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfpaTZ7WvCfWqAjwTaagTPzHc/LAiu/m4nhHDv6s0W4=;
 b=MfDH1Sa9+/cvEqaUQGxzxac9MJdpk6us7F5vPFuBXk8y1Qrvxpw/ZPP+05dEaJlDvt
 YNEX38Z3iDCRTGAoufSXi+qXT1lpcYhj+WL5RaIhhFIWVPTNhwnr5wDYAsemkoZsTLkK
 GAT2pkVkMMh8eWWDxT7r8et3wXJwKyl83tCAGmQyP6ISQPEb15TVi2qA1LBPFx0NJ2cs
 zoHx9vzTmLnXpHgBbN/Pb3XndbsGJqff+rfzs7nnbuivyDfvnyl0lvglHjBb5H5yK1+r
 ClbvfnxvZyvfIrEcA9xVpZy1I3VgZr3xraA3wcgd0tIln7zCAkv+vBTjDq8ToNiCVmih
 1vCA==
X-Gm-Message-State: AC+VfDxQEGjEqDkGRrNxWq+EnDeG8gxTtykScauSTcZ1ZaaH2avzGoJO
 nnL3kuJTsqtc2BQ4wNllj9FYF1zXJhy9hYhj1nLEwEkyTRA=
X-Google-Smtp-Source: ACHHUZ4GcEQOTaq/Won2NLNekEX1gaB5aie09TmPK2luynLA77vtPNuTFlAeWO97c6pH7OihS/bR2MMUiLo/iiBmfXM=
X-Received: by 2002:a05:6870:8897:b0:18e:d932:a85d with SMTP id
 m23-20020a056870889700b0018ed932a85dmr806503oam.28.1685460480683; Tue, 30 May
 2023 08:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230529145606.1914552-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230529145606.1914552-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 11:27:49 -0400
Message-ID: <CADnq5_M1_sQ4qVZLj4Ddf-egP6w=dqvdrSysEZL1Y0Ly-EpaXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcp_id' in
 amdgpu_amdkfd_reserve_mem_limit
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

On Mon, May 29, 2023 at 10:56=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix these warnings by adding 'xcp_id' argument.
>
> gcc with W=3D1
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:160: warning: Function p=
arameter or member 'xcp_id' not described in 'amdgpu_amdkfd_reserve_mem_lim=
it'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index fa4057da0d7f..cd5d7a39ad0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -152,8 +152,11 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>   * @size: Size of buffer, in bytes, encapsulated by B0. This should be
>   * equivalent to amdgpu_bo_size(BO)
>   * @alloc_flag: Flag used in allocating a BO as noted above
> + * @xcp_id: xcp_id is used to get xcp from xcp manager, one xcp is
> + * managed as one compute node in driver for app
>   *
> - * Return: returns -ENOMEM in case of error, ZERO otherwise
> + * Return:
> + *     returns -ENOMEM in case of error, ZERO otherwise
>   */
>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>                 uint64_t size, u32 alloc_flag, int8_t xcp_id)
> --
> 2.25.1
>
