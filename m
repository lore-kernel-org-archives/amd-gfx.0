Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25580C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 19:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C814010E27D;
	Tue,  4 Mar 2025 19:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EAnpm2g7";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A0910E27D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 19:41:16 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2217875d103so16714485ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 11:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741117276; x=1741722076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPl3VE0ZiyfiNMJhaZlml8GUSqTNMNnbpW8HjOaJ5T0=;
 b=EAnpm2g7AvqSsFK+Si3nlWbRy7ZxW1BDyFp/aoNQxCdvB7qWdUhXDuoJA2esGiLDNq
 zbJssd48vo93mn7+cpsSd+Ke1RKL6TdXLPNKnCxncZyOt4lIhGYiHaaEQGx6uaIIwpXf
 MghR6kpsEqIYvk9h3Ze0snn5U4aI6GqLDmGrHEby+nId4kPd+gAPn/LGqdpuX6sJt8Ye
 ttaB8cEa7bu/TNmRfrZifqf6iCrwlgkik0b42eZUXMeqsT8HXtuMl7SrowmkZlgnhwx8
 ePpRdmBG8ad1cRVuVjW3pOzKwmOtyW5BFotcQCTyEHIERI8G87pmfPvBWqwp/syEerMb
 E0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741117276; x=1741722076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPl3VE0ZiyfiNMJhaZlml8GUSqTNMNnbpW8HjOaJ5T0=;
 b=M8DtEqj26188UTzv4bpHXIuzowERtp8fyHNJSRfuDcQIsw7quarcrZItoYLUVvZTJD
 Oeufpc7Kb9s3uvn2tvXaC6HS+Dw0dhKXBKsxclYhSAV3mrMY7VaAM1RV2iA7AG1sQ7+W
 g+jog06rOgahEHAS9nAZ42jAUB7FAgDMcmkPJX/6QQhnIKH4aY7utwD+A+GsbW76XCus
 xhtgcRRik0pHCRT8xdQAKkXVQm7z73C+OV4WY4bK+e4BJDbSO0dIFkop5aEsFhQPZ0b+
 gq+JooSGaNf0+/hRz4WCqqOqvP0kZYUVjofIYFcuj2IpIDXYpqCYpk0KE3XWD/D/dGCl
 MnWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOZvJRz6pQzm/UzDCechp/JQSziRJNZVvGjIJh7IetnQHA75Zu3SD2C4WrYqvMJ9r2kcul90VY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTN7BUFtU1BM4t2fClmMMe0//VsXrOmRaCCYcHdPoUCprWOHR9
 8jq46tD57WhEUStxxMHYLeh2tu5Vdfeh2UsZ9hNLlmKou49nznNeEXtDLsSqvpJJKKHzAgOjaBD
 FK/2rC2Nayui1ca+7k8IzeRiG5znXDce8
X-Gm-Gg: ASbGncuYAytL/6rhTavvGQfRs6EqJFlyNCuIkQRD86AS4wwu2k1oF0IvljH/VoZjgpI
 t6+62JbQBbsLo+G9W2H0T4ZifHI3X7hae2d0HvuCffMO5X9A3nKw9NdtdaKwvbe/UPIAzbxbuZh
 5Iws6E1Fd4EJKqNpCJni6NAGrbSg==
X-Google-Smtp-Source: AGHT+IGOSHYuTPeozxobulJWW0UFJK40Hd9PbzrUYlTNA/KJwSycdS02D4okZPmjUOYprJVMDGNn6WcXyZtadOrWYK8=
X-Received: by 2002:a17:903:7cc:b0:223:5e57:44f0 with SMTP id
 d9443c01a7336-223f1d361e4mr2105455ad.14.1741117276419; Tue, 04 Mar 2025
 11:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20250304193202.383241-1-sunil.khatri@amd.com>
In-Reply-To: <20250304193202.383241-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 14:41:05 -0500
X-Gm-Features: AQ5f1JqNNRNP52H9y7rRJD9W9TOL7JL90M7PYcCyJ2PLmerHzWhphGHHSNYySmo
Message-ID: <CADnq5_N-jy=G-7H_EVOUJvqVa5aFp6Jqi-gauqSo6VWVNWmNdw@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: validate return value of
 pm_runtime_get_sync
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Mar 4, 2025 at 2:32=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> An invalid return value 'r' of the pm_runtime_get_sync
> is r < 0, so fix the return value check and add proper
> failure log and exit cleanly.
>
> Successful refcount in userqueue creation to make sure
> device remains in active state.
>

Fixes: 33d65834b02d ("drm/amdgpu/userq: handle runtime pm")

> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3a71d01b54c9..7df50ff80f9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -289,8 +289,11 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>         queue->userq_prop =3D userq_props;
>
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> -       if (r)
> +       if (r < 0) {
> +               drm_err(&adev->ddev, "Failed to increment ref count of de=
vice pm_runtime\n");

I would use dev_err() here for consistency since we don't use the
drm_* variants that much.  Also update the error message so that it's
clear where it's coming from.  E.g.,
"pm_runtime_get_sync() failed when creating userq\n"
With those fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>                 goto free_mqd;
> +       }
>
>         r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, =
userq_props);
>         if (r) {
> --
> 2.34.1
>
