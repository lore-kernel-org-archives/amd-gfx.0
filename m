Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5410FCCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 21:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AB510E841;
	Wed, 22 Oct 2025 21:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A61upfxG";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F0910E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 21:11:21 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2699ef1b4e3so71775ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761167480; x=1761772280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNXtO/AQn/BC/plZTyfzG84ButbDAJHF2wGotF37kDk=;
 b=A61upfxGX7fJwATiCiY8sFNNe6DqgBEzeJ6Z8Vznro50FYfPzfmcInezJBJZRbAB0R
 9QYhJhz51h1jzqiTLWi6FuIzS9GrsOhA3CifC4yYjHmZ5BfrINj2Fd6dLa5Ac7FhNwIL
 iwLRQ2EUrbr1pSyigaDf9ZXATNFeKfQWcQSk90Bpc2jLlNrq/n57vop1S4851j+hteAs
 pmFztvZh//why+aEOGoKSOm+Lamx+ieGOXIXuqONUPsa4VWxVcwubc4O70wRYiaAz9Ey
 ch0famDDVXUGIwO4xkTSegXqsfJ0D5CNZNCH9aCrorFuP8OBRUuQFwe8kFM46ctRxZ0p
 OfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761167480; x=1761772280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNXtO/AQn/BC/plZTyfzG84ButbDAJHF2wGotF37kDk=;
 b=AFBxhj/CSoYfqHbFTwvQM4OXay0preuXkZCZVmoCYLQBRT0k1Ix8/4i9F1GarTfdhu
 EpS5pQMsm/wnL44mozwsMF5n1Ase8sUird4i89jaOxNwYCIigls3rylKXYkZhTijTqsx
 s2ofKP/SrEsqaLDSHnH/8/ZtKoom0w9RQOEpDvM3knpc7M7EgACsT49jf7cH33aqkNQN
 cXsT5gz07JFrbTVFpKUFFnuonf0p+K2+4E135b2wGy+ddtsBVm1Wp7vKiGYGSQxfQmif
 aG9WHhZBVwSoA3Vaht+0B1QHJD8RFicn0VgelBQO3x5kueh/f1aJPAXmpHRvmLOb9HAC
 Trsg==
X-Gm-Message-State: AOJu0YxtvI9wqWCMUpUfmt6jBj/QpFt4hLGXb3gQihfE73PBmEd4oExE
 NCWrYHUcFk7cQxts84MQtEMy4ZXUEIZ3p4CRAlgRJ4KwRIEuDn7bHrHLHlJ0RbUF+0GPqd7kfaC
 1nIxputpIPbIyN+6iokLiRdpN0cN7xng=
X-Gm-Gg: ASbGncvnze0hNzTIRCcNrPfUqbhs7jdjUQv+ZmVIipHkzA6ervl5nu1K96iUy9wSb//
 GDNBNYrL13n/ByxlLI8tqqygBTPwyvw4kFzQCneOMIxUa6ynB0uHuYC5vohmvle/Tikb15xhRih
 6cB2Lm4uw9+BQ8kfAJjHHNlNNF6o7MNLl3yAf+IgDf4yockYbM+G6hIk/NNeEl8yQqp49GkZ8d6
 DaVa8BKmlzJnNAfSbEfASfrPhvla8XL5/vLopiRkvoZ6ySOTgVHnLnUd4Tv9Ko5u7r7RAE=
X-Google-Smtp-Source: AGHT+IH79fI7iBBIW28fO/TAdu16qi+nueU+JvdmPPDeuZiu816bbzVa3By5O1gvWMgJ8WE9+cU2gVlkCBMHj8rdoBc=
X-Received: by 2002:a17:903:8c3:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-290c9d2debcmr149190765ad.4.1761167480537; Wed, 22 Oct 2025
 14:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251022204507.1782776-1-alexander.deucher@amd.com>
In-Reply-To: <20251022204507.1782776-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Oct 2025 17:11:07 -0400
X-Gm-Features: AS18NWBIQ_nQsw-FcVr1g6oEJP4pJ2JHIOFcKgekfhjokkEjbVXKkZkeu5_syDM
Message-ID: <CADnq5_Ou3SExu6OT40BzjGX1bM8xx-N30efeqaQa3STcuWAH9w@mail.gmail.com>
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

On Wed, Oct 22, 2025 at 4:51=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we don't end up using the vm fence, we never initialize it
> so it never gets freed.  Free it in that case.
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I have a better fix.  Ignore this.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index db66b4232de02..f3373d5f429f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -845,6 +845,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>                 if (r)
>                         return r;
>                 fence =3D &job->hw_vm_fence->base;
> +       } else {
> +               /* free the vm fence if we are not using it */
> +               kfree(job->hw_vm_fence);
>         }
>
>         if (vm_flush_needed) {
> --
> 2.51.0
>
