Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EEFCA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 13:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5934210E2E0;
	Fri,  5 Sep 2025 13:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UExCGbHE";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC4610E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 13:32:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-32ba1f9c87cso120389a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079122; x=1757683922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YMepFXjYwhEQ7IA6bwJGUi9Ejy/qNIJucKvgMEsIGs=;
 b=UExCGbHEx2i2Zef+crshYDyENcMYBuEN2Qa5dP+43lgNAoGs3812e/f0Lm0LvfBUNf
 JifWMM/PltyvP31+bPqbmMIgd+7xKRMk+9U3PMWdsycaSmFjDEkAblpPqdxeH83DiqL3
 mTlDwcrlhPRDBUAuG7iU02tbcAFfUfyxE3t6FBw8RuCmCe7JDMv6zHpudRQJSics6hR4
 6Dz8N6oyGP1nmetibLbXQIg5gAqlmnFGAoUarmU3urSvSHJtAuGudAyKwsHbbUi3fROt
 4fcHehcIDie+a0a4RHziP3OabBbnXFGEfwpC9LE8sapNzAAD8Sr6vIk98uDw/h+ZgmjB
 J6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079122; x=1757683922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YMepFXjYwhEQ7IA6bwJGUi9Ejy/qNIJucKvgMEsIGs=;
 b=kDSfSHVSo7x4mUcsIHxFVt2/llabVvxtbLZ7Yt0zp5FvVUwh/Qr187G+3KS7XJt+rP
 SRefU5Yx6Pv5cwtk4CZ6xpUE7auk77T9H0U9FTRgL+lQC7GUk+EkCNm5UtDRfjzQVStg
 Bwps+82t3LDSglw1W3nbLD6EAds3eqn4OY049dmJMGy5jOxJwMq9uQ9EU9djzhe++zZx
 PgvKcqAPmGWxASdI9SqgI3AH/E8roUlm57nq5vcr76ljMsy3INI4QtvEJnXY7m2jt8AY
 1kjHKGf0wdkW8y4yNjy8emwbBgAdRpEPbGQxYoOMjOYMaB59H7xX1yI+3TYQ+phsq4fx
 XtLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx9Af6WGtgCUQ8AFrnNnVojxtV5BhKkNv+MZ5wbq+0P2kRogQfVWaHrr1RMbJ1g4qarpgQNDNJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrlIbxOuS3ycG7oFsnpM+YGwV7y2X+eYsO1GWg3V7nm8OsqZvB
 jp9+PzilAE5tGejAlEfdg5njzXw+37/OCvbQQN26ep4N4YAFEsIc8wb1roAeTyMJv7cr8oVEdz0
 EjsKE/augQf8ZXub9Ha1v4NGYWU4OEVg=
X-Gm-Gg: ASbGncvxZvZ2+zLR5vLpITY/bQss+fGckOsot3cquBkd0qsIyYWe2xId4rAZr6CW7JS
 mlox1exb3yXSvA5JBfLKziVLakMnRNRg28ebQbqrRWGLLBfJXqgfUkcQuLMrX7Tou+yZ/hkAIIi
 X4oxsq0LOcpbWFWiqN/Pf7UyQ9pbKPSxget5GmwqyFFkkbw2TI5bk/LFsPyM72+GQyp+sS4LiRj
 KcdivDskXMH2XmnTA==
X-Google-Smtp-Source: AGHT+IEe/wvRuuKle4+6VbzmKgT1ji4WT150x/ihFkC6UCxZULavQR0kaeTT8ntYFML2h6au4qiXi8Spz36fdnMcEyE=
X-Received: by 2002:a17:90b:1d08:b0:32a:8b55:5b82 with SMTP id
 98e67ed59e1d1-32a8b557332mr8674375a91.0.1757079121612; Fri, 05 Sep 2025
 06:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
In-Reply-To: <20250905124742.11305-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 09:31:50 -0400
X-Gm-Features: Ac12FXwpATvdcDvAHHCLAY1AtUt2RrF4JX5n_PZ0f8SGSsluuxQ6AXSK2cwIxME
Message-ID: <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 timur.kristof@gmail.com
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

On Fri, Sep 5, 2025 at 8:47=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Gang submission means that the kernel driver guarantees that multiple
> submissions are executed on the HW at the same time on different engines.
>
> Background is that those submissions then depend on each other and each
> can't finish stand alone.
>
> SRIOV now uses world switch to preempt submissions on the engines to allo=
w
> sharing the HW resources between multiple VFs.
>
> The problem is now that the SRIOV world switch can't know about such inte=
r
> dependencies and will cause a timeout if it waits for a partially running
> gang submission.
>
> To conclude SRIOV and gang submissions are fundamentally incompatible at
> the moment. For now just disable them.

Are you sure about this?  Thinking about this more, most gang
submissions are between gfx and compute.  The entire GC block (gfx,
compute, and sdma on gfx10+) gets preempted on world switch so all of
the active queues would be preempted.  Everything gets resumed when
the VF gets switched back.  VCN/JPEG gets switched independently so
that could be a problem if you have a gang with VCN and GC, but I
think all gangs within GC should in theory be ok.

Alex

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 2ac9729e4c86..434a551365c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p=
,
>                 }
>         }
>
> -       if (!p->gang_size) {
> +       if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size > =
1)) {
>                 ret =3D -EINVAL;
>                 goto free_all_kdata;
>         }
> --
> 2.43.0
>
