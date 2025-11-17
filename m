Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A16CE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 19:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF5B10E3F9;
	Mon, 17 Nov 2025 19:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hp+RVV3P";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC2E10E3F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 19:38:41 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7b99c2a5208so372631b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763408321; x=1764013121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWBlv27Dksc7HrBPUdOReRPEGAb8gw0+ItSWLw68B88=;
 b=hp+RVV3PLikh1h1HHLyr6VEdalpXrbwjiytBmm5zGkLkJcq8/Bjz2AIIgPJ5KxbA3E
 oEA1cJN6sDNT/Oe6nYrB3DrYP4I0XC2D8UZAp54EFDnMReGIqVK0CSXfkqNcIClchjf8
 sGuOz7twNNQmXCMrK71UyYeYhroEAXhbLVvZrIY9x0tEwq8tm8CK8PxTl+NzbEqn4TGK
 pEOMrXE0itUbyrnb2lE4iMdnEVl/HWFSQx61zcIFEC2L4RJRw1GapzdHCJfVW3m9QvN+
 iKXWnFNYa/vl0ScX3qtYpDGWiIrW9ez9F+Ti1iPikPqVK2ClOZHt7X4y474xBEPke0in
 xPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763408321; x=1764013121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EWBlv27Dksc7HrBPUdOReRPEGAb8gw0+ItSWLw68B88=;
 b=NI9+n00gmIPJFRazv9OBDzVkuIeaWAqBURfMlBtrash+ZTaXf47CtALejsZS89q0Kw
 /mFnVG42f8Umfo2muSSKLyg4KIsuzp3OosZfD6H52qSdOYSTKi+GitrE9V+lpWoO+/r4
 vyRqQRiGYZfhn2hIahh6Zmz+9n+44e0mS0wn0ckPrw5RS+JHs3eXIoQSDLt2oimAbgRS
 QNnqPEygtji8uRQHSiSsVgjS1wVOCBFsLGlqw5TZPTqbdAMOReZoXTWQ0su74uQ1s5xB
 j9WGMj6zy/6v7TVpqmcYIXz4iOIQIoUldnzrmfLs2bnc2RgNUaG93VIxvRQldnJoUchL
 lnlw==
X-Gm-Message-State: AOJu0YzFLkj+XodAiiFkNXAxgYRIYi04gsrEBpi3/1dnml9ofAdj5wPj
 L2zQyM0UZgnLpkvIAEgEZ9XXP881X9N/iQNAQTlISA1cGv41d7nrGE8Kbk1LzqT5m3jl2hdm15B
 GwQbKy56/lgeW/jhF+CziNaT3xaFvL/c=
X-Gm-Gg: ASbGncuqDH27suCqBIrEymXl1x2GA9qhj2073JKKAlGV3WbqqbIa6uB2RJi4WcSare4
 TXVfF38L51cNIMQXZCU/O6hE0Q2fk1PNQwUUEghlDWn92OzFkneQcpdDyu4hmTscBSJEmaiCe+S
 QkviI99in1WvddWR5ROcZWqPAZ18L6i9v+nRasV6G7wMUejzzuuGcyF53i+z38GByC0asM2AnUp
 XY1PZjPzVXCs2l27sYwd428OX3XPH3ZHviYykJMt0apmXBiKF/y2OoT1lIAbPusw4vJ2aU=
X-Google-Smtp-Source: AGHT+IFw+WamDCBwcmKs7ViNx4T5bwc4cNYCwwbn0Jd4DLeSo+2vCqUcd6+HDDs1xhn8kHeO7snA1pVYk6/KGV9gIic=
X-Received: by 2002:a05:7022:6186:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-11b4941c45dmr4967156c88.5.1763408321331; Mon, 17 Nov 2025
 11:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20251116173321.4831-1-rbmccav@gmail.com>
In-Reply-To: <20251116173321.4831-1-rbmccav@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Nov 2025 14:38:29 -0500
X-Gm-Features: AWmQ_blHHYc5TZLAOrneOd3RNEx5Qsw9cHSZhuvgZck70-WcLnivbQRg6pgFYMI
Message-ID: <CADnq5_P8z9C8e6kZLOyzTAxrhj97-ujm2bVWXij9PnrJTBwHdA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: delete radeon_fence_process in is_signaled,
 no deadlock
To: Robert McClinton <rbmccav@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 stable@vger.kernel.org
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

On Mon, Nov 17, 2025 at 3:42=E2=80=AFAM Robert McClinton <rbmccav@gmail.com=
> wrote:
>
> Delete the attempt to progress the queue when checking if fence is
> signaled. This avoids deadlock.
>
> dma-fence_ops::signaled can be called with the fence lock in unknown
> state. For radeon, the fence lock is also the wait queue lock. This can
> cause a self deadlock when signaled() tries to make forward progress on
> the wait queue. But advancing the queue is unneeded because incorrectly
> returning false from signaled() is perfectly acceptable.
>
> Link: https://github.com/brave/brave-browser/issues/49182
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4641
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Robert McClinton <rbmccav@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_fence.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/rade=
on/radeon_fence.c
> index 5b5b54e876d4..167d6f122b8e 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -360,13 +360,6 @@ static bool radeon_fence_is_signaled(struct dma_fenc=
e *f)
>         if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D seq)
>                 return true;
>
> -       if (down_read_trylock(&rdev->exclusive_lock)) {
> -               radeon_fence_process(rdev, ring);
> -               up_read(&rdev->exclusive_lock);
> -
> -               if (atomic64_read(&rdev->fence_drv[ring].last_seq) >=3D s=
eq)
> -                       return true;
> -       }
>         return false;
>  }
>
> --
> 2.51.2
>
