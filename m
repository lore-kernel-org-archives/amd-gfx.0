Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C5CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 21:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1300E10E1AD;
	Wed, 22 Oct 2025 21:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVJ+1QsG";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D77910E1AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 21:19:25 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7a2687cb882so15819b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761167965; x=1761772765; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Faeq8QWkm3mPEkC80XXveXnYDXMXWEm/MZpCy/4dyfs=;
 b=DVJ+1QsG3Ua1g1eu2bHTl/HmclLqq9P/CmB3ObTFCl28U2Xg88eF3C/l0zz+kCibYt
 pvLBW0AInnW7wTOL55UKiNcGre0lm5WnyGpyqWAwj11dLDENULaOm/cw+mb+0NCseiTS
 LcO8ju4gm7a9KY9LWECVr5/B9mkUZ50MkbH5AFVl7b4V1nrvPJAM0wnnI3XpGU5wj1Xk
 0iJtr48xtqhy9IZF999zPkZMxK+LpxK69D8IfuMlCQ02SwNTUh1Xy8TaX1PptyBxUStU
 7BOVi7EwWIcH/aJKuKILhvqjjFrE00pVLL1x5xuDldy9zYd4EyGg0ZwTuvV4xcUXNw9t
 b7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761167965; x=1761772765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Faeq8QWkm3mPEkC80XXveXnYDXMXWEm/MZpCy/4dyfs=;
 b=ujvcCFm9rvEy0iIU9pkEKCuNfaKpU1Exqk7I64qPoJQ5elMu/tE2nssuICoSeiL9+o
 NfSFS0DvMxX8Z0l8uwEzlFm81b0u9f7Gv6VK9m2+C5sRvj58yQ7GjQjlI3ceb+UspCto
 cC0Rvr2PeXNnEvpNqSphY9HwykYl0h5GEbNQV4bIM51adIkCiJtUp7oigN4XgYDlPVQD
 oiFn78A+8gSSZH89UPwFntgBsSnvZdr9EKOmlGUYaUSJMsxD8s+I/CQYTrLyiW2AbqUE
 WT8C8Ypi8cxYGKNNjLUSNKRbnBS70ecEUMl0f1PTC/6iUuxclS8tkJTHJPwtYOsxw7o5
 XNzg==
X-Gm-Message-State: AOJu0YwpDQVia4xzcPIe4VldZwFJoBff5PRsfxBGHC8KhME8T4UFIyPl
 plfk6RNoW8E0nuOxzCIulMyrYL8uGHEhMFZj0oGV05g2SBMrOBYHEQulkgs4+hOKvpk8srWMs+N
 7w3e4ENKUAn4/CLeaPDx4Ejz7OWwpjaEwmw==
X-Gm-Gg: ASbGncsBv9DXRtIu3OlleJITPvRy+y5SgDEgPpMLtQNBKZb/kMlScAUYYP+MotIy+mz
 PFoWEZpS2NbDguEf7SWK4bfvLrnuEMUl/y9iTsWslCNyMql6iRfw0R1E4ExwqHhyQJ3PIGu/r9u
 2kKEGVKqFXaEJ2CYy8rsNZmr2+Yd499N9lw9r09V2kqUOCE0jB64S8EvzPKBlFbhMH+mridNYpk
 nL5s+s/oPk/XwuMNFfvFMc3035CtlvAxICwPDxtcEcn8l6xc4umPiW6LeHYS6aP2I5ypwc=
X-Google-Smtp-Source: AGHT+IFwNTgB7LW6YUqaO/YLkgnRTXZ7H/wn07xjOQxwfB081DP5njWS0W4fwxSUf0nk5+qjx7RQKpb2hCodfTFIx48=
X-Received: by 2002:a17:902:d484:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-290cba419fdmr159692085ad.7.1761167964880; Wed, 22 Oct 2025
 14:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251022211342.1785797-1-alexander.deucher@amd.com>
In-Reply-To: <20251022211342.1785797-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Oct 2025 17:19:12 -0400
X-Gm-Features: AS18NWDsXfMnmtTbsm_qVGrgE2DksqYxhGxS2OmDFlRh7RCCorepUPumnJQ-Dys
Message-ID: <CADnq5_PjE=ngyWseOn_pz-ApFkzy1Uc3KnqEZqJiLCWeWO_u4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix leak when we don't use the vm_fence
To: Alex Deucher <alexander.deucher@amd.com>
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

bad commit message ignore this one too.

On Wed, Oct 22, 2025 at 5:14=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we don't end up using the vm fence, we never initialize it
> so it never gets freed.  Free it in that case.
>
> v2: handle this in the job callbacks.
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 3d396ab625f33..8ad8b16e96760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -295,6 +295,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>         amdgpu_sync_free(&job->explicit_sync);
>
> +       if (!job->hw_fence->base.ops)
> +               kfree(job->hw_fence);
> +       if (!job->hw_vm_fence->base.ops)
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> @@ -324,6 +329,11 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> +       if (!job->hw_fence->base.ops)
> +               kfree(job->hw_fence);
> +       if (!job->hw_vm_fence->base.ops)
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> --
> 2.51.0
>
