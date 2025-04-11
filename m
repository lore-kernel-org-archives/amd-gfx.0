Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCFFC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E69B10EC03;
	Fri, 11 Apr 2025 15:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h77IbaD/";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3370B10EC02
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:50:48 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3054e2d13a7so396303a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386648; x=1744991448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV+sHDoZIBQ0FGTT0RqEqn0QNAJPkH0XM0pr/XGBbnY=;
 b=h77IbaD/YfeY9r5Je5ydBofjjyJJgmVrq7Q4Uq+Vkqf9X+AxFTNLAa5mI7j/SLWeGo
 0Mr0pxHt0/AD59COs/K7Ozscs4EvP/f4p7FgsqLaPgeBW8l+yfOGIh1YqFbvCjSzqnCE
 PcHQjrjxF7QOdYggdmoYDTnacxtww7ofdBFf4mCpggdQ5DNDTYbWy7ttUpJyu2bZxA4L
 8lSwKX6xkITUCc1KOdRPVjQzuLlUSLk6+Lmx4UNQpgPUMTqrQyeJEiISYhVHFB4tO7cJ
 TKjEDfM3BnTaewy4Spm0I6H53QOVZiEfg2/TZodzMlNb9+rMF5M3OYY6L51jfgFsP4lx
 fLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386648; x=1744991448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TV+sHDoZIBQ0FGTT0RqEqn0QNAJPkH0XM0pr/XGBbnY=;
 b=tLfTOtppaQhOER/e79MzoOm89vTrNezh+u/VrQK9mrnUXRatk3j3r+C0/qwlEJAW3T
 G/xi/LK0rO1KY+egG6kEBR2OF+y+1GB14QKb5rMOkTPEXVLHgk6DEWWNsmdkdQpbfj4f
 IndQB4bBhmiokjGIahqAecnDUKPZb7SiBxn2E9dlxnKJoe3Q+dCXULC6mFmxw6nQP3+Y
 li2CwsAxCtYGBzAsI8QLKJ7XgElbQtHmnRTBIPqZ6rA0EqGJv0XFKeihr4aJy1IzZShj
 IjuDH0/11ZC7XabEjpB2v16vC1JgFfx0aEfGHd5z5hEkQJFNjQWyBKwKkURPKnPQw/nJ
 kZ9A==
X-Gm-Message-State: AOJu0YxQdtwKMboE2sS1CIYn70ti7ymK34c9ZzKnGF7v/zqrwa5MUIgj
 0JS13bFXqkvlCQQ91G0tK7T3PolEITRpFage+C3ZwkaxprI6Ad6VrTY9I9If+12ZIBczEWX+Ez0
 UWvxp9DkkV8byQGtIQ2/LWTEtT8g=
X-Gm-Gg: ASbGncvM5gx3Rw3u4BWP/JFNdtzkjmctqJsspZN3PZdIhrdQG4Imqci7pMkWegaNIkb
 +Spy2wxhjbICL6z48gOUKJBzPsPlC/SYBNc8/liRqdj3nOZ/0D5tJ567P1nH9QpyvIIYACR4DAU
 2qcMUzDG50mZsn+IJNIA4xsg==
X-Google-Smtp-Source: AGHT+IEOYH2itSMdFXZftETnWKoJP/uPModE6wuCTRd7VLl1y6QVrXD9gEtBSfkQuPr344TVd7e9flZr4ZywZR3eVwY=
X-Received: by 2002:a17:90b:33cd:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-3082367472fmr1997869a91.4.1744386647531; Fri, 11 Apr 2025
 08:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:50:36 -0400
X-Gm-Features: ATxdqUH3AiCDbWQWJ1NIr8OLBAU_VELVnNnwp-KQBfT2wv8ho8kf925QM0Cf_9E
Message-ID: <CADnq5_MK8T-ev1+qTZMMb8v607C2hdOYgOjuY_8tv6kamimhxw@mail.gmail.com>
Subject: Re: [v5 1/6] drm/amdgpu: Add the new sdma function pointers for
 amdgpu_sdma.h
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Fri, Apr 11, 2025 at 4:29=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch introduces new function pointers in the amdgpu_sdma structure
> to handle queue stop, start and soft reset operations. These will replace
> the older callback mechanism.
>
> The new functions are:
> - stop_kernel_queue: Stops a specific SDMA queue
> - start_kernel_queue: Starts/Restores a specific SDMA queue
> - soft_reset_kernel_queue: Performs soft reset on a specific SDMA queue
>
> v2: Update stop_queue/start_queue function paramters to use ring pointer =
instead of device/instance(Chritian)
> v3: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename=
 them. (Alex)
> v4: rework the ordering a bit (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 0b1fbcf0b4d0..a6c8f07a0da4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -50,6 +50,12 @@ enum amdgpu_sdma_irq {
>
>  #define NUM_SDMA(x) hweight32(x)
>
> +struct amdgpu_sdma_funcs {
> +       int (*stop_kernel_queue)(struct amdgpu_ring *ring);
> +       int (*start_kernel_queue)(struct amdgpu_ring *ring);
> +       int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32 in=
stance_id);
> +};
> +
>  struct amdgpu_sdma_instance {
>         /* SDMA firmware */
>         const struct firmware   *fw;
> @@ -68,7 +74,7 @@ struct amdgpu_sdma_instance {
>         /* track guilty state of GFX and PAGE queues */
>         bool                    gfx_guilty;
>         bool                    page_guilty;
> -
> +       const struct amdgpu_sdma_funcs   *funcs;
>  };
>
>  enum amdgpu_sdma_ras_memory_id {
> --
> 2.25.1
>
