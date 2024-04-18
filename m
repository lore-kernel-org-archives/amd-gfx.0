Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87570C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 18:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19779113F01;
	Thu, 18 Apr 2024 18:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lh/nYbWd";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1404C113F01
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 18:54:20 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-6edb76d83d0so1095122b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713466460; x=1714071260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyJC7TeFh1NxmI34aw7Zf/SDKfyjH1hyM551JST3Ec8=;
 b=Lh/nYbWd0zdz+lCADqmQslZn2LrqZcrT0cfpM6IpScAG8lY2KEA5qYdrrK70RYk+ma
 PwVQyFpY4Mn4eHLnCGKq2CRwTQ+0PDSaq2gPRMHeSm4qYqEyExR80dEYgHgLUdu2EtEK
 T8FK58NOp1cu9cD/KwL7An+zU0153pVMIcv3ecOSRE6DgSyj8j8ONhWbMihu79BXnnEb
 nKy268nxPCHrAZXnG7e73JFtE6NbZsWpwgrTQUG61vcfNTzW534kuleRzVDDTfqbiLr1
 orGs9ouhQ+oSD5UUmhMoDItwlo6J8QittSDtzONnIa5gHo3ppZMzKQjWX4+mPgggPY2s
 5kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713466460; x=1714071260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyJC7TeFh1NxmI34aw7Zf/SDKfyjH1hyM551JST3Ec8=;
 b=dM7OugZCy/UJj87wRRqLmJBPJMO63UJBV+zPiQPsf03yXeHHlL2Jadlq3OCamrtOUC
 eUX9Yi2gUm3KjxMHHZaaJFoFyJPDpKePXZ7f0uNVaqUPhE5SpDYARsRWjzfNPW0/DWPA
 ggV2DGgRGY20PqoGZNKixJLeTKz1isdvN+ER0d/98CUC1YKRTsLlt9AnfQx1MduOETlT
 BoJgEK78pX9K4PZ/uzbspJf/dLumMW4cTGEq03vgHfZwzRIN8Zf0UZGm+QuGRUZTMb/X
 3fnqNSrAiabhaR27RRnxhqL9wQZf/QW4YcZTNPrHO3EN7Y83XMay0K3hiNovCyg4CuQt
 k8eg==
X-Gm-Message-State: AOJu0YzRKifj1wMNHhomMpOKqgOpvppRat1J0T6KpE/3XV9cp8WRYh3a
 9O5dOaF0mrbxsQ5XG0EqO57CAyfhDzfK9m5dV+XYHB7laXX67TyEEf4SRs3G0Tdx3WUKeg6jyYl
 zrj/ydrKoLjjvgSebTmjR2m4yX2gcGnF7
X-Google-Smtp-Source: AGHT+IFguBPbM5Ha2b7t3JXhZ54a2teliAwDc6WdwFwjHGVJ4g+rJf7yglHsEr4vptO0CZcLrAM6wy3+EmEXtGaqZ5M=
X-Received: by 2002:a05:6a20:9f0a:b0:1a9:8152:5102 with SMTP id
 mk10-20020a056a209f0a00b001a981525102mr109416pzb.24.1713466460311; Thu, 18
 Apr 2024 11:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240418180807.240782-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240418180807.240782-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Apr 2024 14:54:07 -0400
Message-ID: <CADnq5_O9LHsQhwG=G_XmMdG9v=adem5qC6+wtSa-Rep3ek7NJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix unitialized variable warnings
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Thu, Apr 18, 2024 at 2:22=E2=80=AFPM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Init r to 0 to avoid returning an uninitialized value if we never
> enter the loop. This case should never be hit in practive, but

s/practive/practice/

> returning 0 doesn't hurt.

s/returning/initializing to/

With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> The same fix is applied to the 4 places using the same pattern.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 8f82fb887e9c..724445545563 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -298,7 +298,7 @@ static int vcn_v3_0_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
> -       int i, j, r;
> +       int i, j, r =3D 0;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D vcn_v3_0_start_sriov(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 832d15f7b5f6..9be7ae7af4b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -253,7 +253,7 @@ static int vcn_v4_0_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int i, r =3D 0;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D vcn_v4_0_start_sriov(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 501e53e69f2a..593c64e4b8ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -221,7 +221,7 @@ static int vcn_v4_0_5_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int i, r =3D 0;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index bc60c554eb32..246f967e2e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -187,7 +187,7 @@ static int vcn_v5_0_0_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring;
> -       int i, r;
> +       int i, r =3D 0;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> --
> 2.41.0
>
